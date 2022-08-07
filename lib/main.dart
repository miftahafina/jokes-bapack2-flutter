import 'dart:async';
import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jokes Bapack2 Flutter',
      theme: ThemeData(
        primarySwatch: Colors.teal
      ),
      home: const MainScreen(),
    );
  }
}

class JokeDetail extends StatefulWidget {
  const JokeDetail({Key? key}) : super(key: key);

  @override
  State<JokeDetail> createState() => _JokeDetailState();
}

class _JokeDetailState extends State<JokeDetail> {
  late Future<Joke> futureJoke;

  @override
  void initState() {
    super.initState();
    futureJoke = fetchJoke();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Joke>(
      future: futureJoke,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data!.data,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 32),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JokesBapack2 Flutter'),
      ),
      body: const SafeArea(
        child: Center(
          child: JokeDetail(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh_rounded),
        onPressed: () {},
      ),
    );
  }
}

class Joke {
  final int code;
  final String msg;
  final String data;

  const Joke({
    required this.code,
    required this.msg,
    required this.data
  });

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      code: json['code'],
      msg: json['msg'],
      data: json['data'],
    );
  }
}

Future<Joke> fetchJoke() async {
  final response = await http.get(Uri.parse('https://jokes-bapack2-api.herokuapp.com/v1/text/random'));

  if (response.statusCode == 200) {
    return Joke.fromJson(convert.jsonDecode(response.body));
  } else {
    throw Exception('Failed to load joke');
  }
}