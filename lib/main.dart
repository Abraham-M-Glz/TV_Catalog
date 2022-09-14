//import 'dart:html';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.purple),
      home: const MyHomePage(title: 'WELCOME TO TV MAZE'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var data = [];
  String genresOfMovie = "";
  dataAPI() async {
    var response = await http.get(
      Uri.parse("https://api.tvmaze.com/show"),
      headers: {"Content.type": "application/json"},
    );
    print(response);
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
      });

      return data;
    } else {
      print('some faliure, try again');
    }
  }

  @override
  void initState() {
    dataAPI();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Details(
                        name: data[index]["name"],
                        language: data[index]["language"],
                        status: data[index]["status"],
                        genres: data[index]["genres"].join(', '),
                        premiered: data[index]["premiered"],
                        rating: data[index]["rating"]["average"].toString(),
                        imageUrl: data[index]["image"]["medium"]),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color.fromARGB(186, 17, 0, 252),
                  // boxShadow: [
                  //   BoxShadow(color: Colors.green, spreadRadius: 3),
                  // ],
                ),
                width: 30,
                height: 120,
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name:   " + data[index]["name"],
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Text(
                      "Language:   " + data[index]["language"],
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Text(
                      "Status:   " + data[index]["status"],
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Text("Genre:   " + data[index]["genres"].join(', '),
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                    Text("Click me for more details",
                        style: TextStyle(fontSize: 16, color: Colors.yellow)),
                  ],
                ),
                margin: EdgeInsets.all(8.0),
              ),
            );
          }),
    );
  }
}

class Details extends StatelessWidget {
  final String name, language, status, genres, premiered, rating, imageUrl;
  Details(
      {Key? key,
      required this.name,
      required this.language,
      required this.status,
      required this.genres,
      required this.premiered,
      required this.rating,
      required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Details"),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: TextStyle(
                      fontSize: 30,
                      color: Color.fromARGB(186, 17, 0, 252),
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color.fromARGB(186, 17, 0, 252),
                    // boxShadow: [
                    //   BoxShadow(color: Colors.green, spreadRadius: 3),
                    // ],
                  ),
                  //width: double.maxFinite,
                  height: 350,
                  padding: EdgeInsets.all(10.0),
                  child: Image.network(imageUrl),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Language: " + language,
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(186, 17, 0, 252)),
                ),
                Text(
                  "Status: " + status,
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(186, 17, 0, 252)),
                ),
                Text(
                  "Genres: " + genres,
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(186, 17, 0, 252)),
                ),
                Text(
                  "Premiered: " + premiered,
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(186, 17, 0, 252)),
                ),
                Text(
                  "Rating: " + rating,
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(186, 17, 0, 252)),
                )
              ],
            ),
          ),
        ));
  }
}
//https://api.tvmaze.com/ 

//ENDPOINTS:  

//shows 

//shows/$id 