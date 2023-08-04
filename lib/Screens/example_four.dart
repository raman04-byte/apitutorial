import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ExampleFour extends StatefulWidget {
  const ExampleFour({super.key});

  @override
  State<ExampleFour> createState() => _ExampleFourState();
}

class _ExampleFourState extends State<ExampleFour> {
  var data;
  Future<void> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("This is Example four"),
      ),
      body: Column(children: [
        Expanded(
            child: FutureBuilder(
          future: getUserApi(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('LOADING...');
            } else {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      RowReuse(title: 'Name', value: data[index]['name'].toString()),
                      RowReuse(title: 'UserName', value: data[index]['username'].toString()),
                      RowReuse(title: 'Address', value: data[index]['address']['street'].toString()),
                      RowReuse(title: 'Geo', value: data[index]['address']['geo'].toString()),
                      RowReuse(title: 'Latitude', value: data[index]['address']['geo']['lat'].toString()),
                      RowReuse(title: 'Longitude', value: data[index]['address']['geo']['lan'].toString()),
                    ],
                  ),
                );
              });
            }
          },
        ))
      ]),
    );
  }
}

class RowReuse extends StatelessWidget {
  String title, value;
  RowReuse({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Text(title),
        Text(value),
      ]),
    );
  }
}
