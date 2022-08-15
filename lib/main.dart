import 'package:flutter/material.dart';
import 'package:giphy_navigator/modules/homepage/homepage_scene.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Giphy Navigator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      home: const HomepageScene(title: 'Giphy Navigator'),
    );
  }
}
