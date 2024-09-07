import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places/screens/add_place.dart';
import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/widgets/places_list.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({
    super.key,
  });

  @override
  ConsumerState<PlacesScreen> createState() {
    return _PlaceScreenSaste();
  }
}

class _PlaceScreenSaste extends ConsumerState<PlacesScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    _placesFuture = ref.read(userPlacesProvider.notifier).loadPlaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPlaces = ref.watch(userPlacesProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Your places'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const AddPlaceScreen()));
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: _placesFuture,
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : PlacesList(
                        places: userPlaces,
                      );
              },
            )));
  }
}
