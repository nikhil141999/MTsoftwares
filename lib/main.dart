import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Homepage());
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List? listresponse;
  String? stringResponse;
  Map? mapresponse;
  Map? dataresponse;
  Future apicall() async {
    http.Response response;
    response = await http.post(Uri.parse(
        "http://adminapp.tech/sharefeelings/api/posts?category=12&subcategory=15"));
    if (response.statusCode == 200) {
      setState(() {
        mapresponse = json.decode(response.body);
        listresponse = mapresponse!['result'];
      });
    }
  }

  @override
  void initState() {
    apicall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xFF701ebd),
              Color(0xFF873bcc),
              Color(0xFFfe4a97),
              Color(0xFFe17763),
              Color(0xFF68998c),
            ])),
            child: Column(
              children: [
                Text(
                  listresponse![index]['title'].toString(),
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400),
                ),
                Text(
                  listresponse![index]['publish'].toString(),
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400),
                ),
                Text(
                  listresponse![index]['description'].toString(),
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      Image.network(listresponse![index]['imgpath'].toString()),
                ),

                //  Text(listresponse![index]['category'].toString()),
                //Text(listresponse![index]['subcategory'].toString()),
              ],
            ),
          );
        },
        itemCount: listresponse == null ? 0 : listresponse!.length,
      ),
    );
  }
}
