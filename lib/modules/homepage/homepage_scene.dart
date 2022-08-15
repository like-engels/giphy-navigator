import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:giphy_navigator/models/gif.dart';
import 'package:http/http.dart' as http;

class HomepageScene extends StatefulWidget {
  const HomepageScene({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomepageScene> createState() => _HomepageSceneState();
}

class _HomepageSceneState extends State<HomepageScene> {
  late final Future<List<Gif>> _gifsList = _getGifs();

  Future<List<Gif>> _getGifs() async {
    final response = await http.get(Uri.parse(
        "https://api.giphy.com/v1/gifs/trending?api_key=JIT8J0mWYkZhd9tQHmZswEESEsMlB1H1&limit=50&rating=g"));

    List<Gif> _gifs = [];

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);

      final jsonData = jsonDecode(body);

      for (var item in jsonData["data"]) {
        _gifs.add(Gif(item["title"], item["images"]["downsized"]["url"]));
      }

      return _gifs;
    } else {
      throw Exception("Nel");
    }
  }

  @override
  void initState() {
    _gifsList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder(
          future: _gifsList,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return GridView.count(
                  crossAxisCount: 2, children: _gifListWidget(snapshot.data));
            } else if (snapshot.hasError) {
              return const Text("Error");
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
        ));
  }

  List<Widget> _gifListWidget(data) {
    List<Widget> _gifs = [];

    for (var gif in data) {
      _gifs.add(Card(
          child: Column(children: [
        Expanded(
          child: Image.network(gif.url, fit: BoxFit.fill),
        ),
        Padding(padding: const EdgeInsets.all(8.0), child: Text(gif.name))
      ])));
    }

    return _gifs;
  }
}
