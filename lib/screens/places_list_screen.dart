// ignore_for_file: prefer_const_constructors, prefer_is_empty

import 'package:flutter/material.dart';
import './add_places_screen.dart';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context,listen:false).fetchAndSetPlaces(),
        builder:(ctx,snapshot) => snapshot.connectionState == ConnectionState.waiting ? Center(child:CircularProgressIndicator(), ) 
        : Consumer<GreatPlaces>(
          child: Center(
            child: Text('Got no places yet, start a dding some!'),
          ),
          builder: (ctx,greatPlaces,ch) => greatPlaces.items.length  <= 0 ? ch! : 
          ListView.builder(
            itemCount: greatPlaces.items.length,
            itemBuilder: (ctx,i) => ListTile(
              leading: CircleAvatar(backgroundImage: FileImage(greatPlaces.items[i].image!,),
              ),
              title: Text(greatPlaces.items[i].title),
              onTap: () {},
            ),
          ),
        ),
      ),
    );
  }
}
