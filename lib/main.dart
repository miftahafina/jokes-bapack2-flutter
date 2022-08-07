import 'package:flutter/material.dart';

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
      home: Scaffold(
        appBar: AppBar(
          title: const Text('JB2 Flutter'),
        ),
        body: SafeArea(
          child: Center(
            child: Text('Hello, flutter!'),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.refresh_rounded),
          onPressed: () {},
        ),
      ),
    );
  }
}
