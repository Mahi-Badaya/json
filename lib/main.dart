import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  List _data = await getJson();
  print(_data);

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('JSON Parse'),
        centerTitle: true,
        backgroundColor: Colors.teal.shade600,
      ),
      body: ListView.builder(
        itemCount: _data.length,
        itemBuilder: (BuildContext context, int position) {
          if (position.isOdd) return const Divider();

          //TITLE DATA
          return ListTile(
            contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 7.0),
            title: Text(
              "${_data[position]['title'][0].toString().toUpperCase()}${_data[position]['title'].toString().substring(1)}",
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),

            //CIRCLE AVATAR LETTER
            leading: CircleAvatar(
              backgroundColor: Colors.teal,
              maxRadius: 30.0,
              child: Text(
                "${_data[position]['title'][0].toString().toUpperCase()}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),

            onTap: () {
              _showDialogBox(context, "${_data[position]['body'][0].toString().toUpperCase()}${_data[position]['body'].toString().substring(1)}",
                  "${_data[position]['title'][0].toString().toUpperCase()}${_data[position]['title'].toString().substring(1)}");
            },

            //BODY DATA
            subtitle: Text(
              "${_data[position]['body'][0].toString().toUpperCase()}${_data[position]['body'].toString().substring(1)}",
              style: const TextStyle(fontSize: 18.0),
            ),
          );
        },
      ),
    ),
  ));
}

void _showDialogBox(BuildContext context, String message, String t) {
  var alert = AlertDialog(
    title: Text(t),
    content: Text(message),
    actions: <Widget>[
      FlatButton(
        child: const Text("OK"),
        onPressed: () {
          Navigator.pop(context);
        },
      )
    ],
  );

  showDialog(context: context, builder: (context) => alert);
}

Future<List> getJson() async {
  String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

  http.Response response = await http.get(Uri.parse(apiUrl));
  return json.decode(response.body);
}
