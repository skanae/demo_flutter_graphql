import 'package:flutter/material.dart';
import 'package:hello_ferry/src/components/pokemon_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Pokemon Demo',
      home: PokemonListScreen(),
    );
  }
}
