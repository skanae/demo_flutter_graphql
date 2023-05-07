import 'package:built_collection/built_collection.dart';
import 'package:ferry/ferry.dart';
import 'package:ferry_flutter/ferry_flutter.dart';
import 'package:flutter/material.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:hello_ferry/src/components/graphql/__generated__/pokemon_card_fragment.data.gql.dart';
// import 'package:hello_ferry/__generated__/schema.schema.gql.dart';
import 'package:hello_ferry/src/components/pokemon_card.dart';

import 'graphql/__generated__/all_pokemon.data.gql.dart';
import 'graphql/__generated__/all_pokemon.req.gql.dart';
import 'graphql/__generated__/all_pokemon.var.gql.dart';

class PokemonListScreen extends StatelessWidget {
  const PokemonListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final link = HttpLink("https://pokeapi.dev");
    final cache = Cache();
    // final cache = Cache(possibleTypes: possibleTypesMap);
    final client = Client(link: link, cache: cache);

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Pokemon'),
      ),
      body: Operation<GAllPokemonData, GAllPokemonVars>(
        client: client,
        operationRequest: GAllPokemonReq(
          (b) => b
            ..vars.limit = 50
            ..vars.offset = 0,
        ),
        builder: (context, response, error) {
          if (response!.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          final pokemons = response.data?.pokemons?.results ?? BuiltList();

          return ListView.builder(
            itemCount: pokemons.length,
            itemBuilder: (context, index) => PokemonCard(
              pokemon: pokemons[index] as GPokemonCard,
            ),
          );
        },
      ),
    );
  }
}