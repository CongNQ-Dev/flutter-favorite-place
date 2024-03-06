import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/screens/new_place_screen.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  PlacesScreen({super.key});
  @override
  ConsumerState<PlacesScreen> createState() {
    // TODO: implement createState
    return _PlaceScreenState();
  }
}

class _PlaceScreenState extends ConsumerState<PlacesScreen> {
  late Future<void> placesFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    placesFuture = ref.read(userPlacesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final userPlaces = ref.watch(userPlacesProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Places'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const NewPlaceScreen()));
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: Padding(
            padding: EdgeInsets.all(8),
            child: FutureBuilder(
                future: placesFuture,
                builder: (context, snapshot) =>
                    snapshot.connectionState == ConnectionState.waiting
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : PlacesList(places: userPlaces))));
  }
}
