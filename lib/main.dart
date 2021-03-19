import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _newConfirmedcase;
  String _totalConfirmedcase;
  String _newDeaths;
  String _totalDeaths;
  String _newRecovered;
  String _totalRecovered;

  bool isLoading = true;

  void initState() {
    super.initState();
    data();
    if (_newConfirmedcase != "") {
      Timer.periodic(new Duration(seconds: 1), (timer) {
        data();
      });
    }
  }

  Future<void> data() async {
    String url = 'https://api.covid19api.com/summary';
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    _newConfirmedcase = jsonData['Global']['NewConfirmed'].toString();
    _totalConfirmedcase = jsonData['Global']['TotalConfirmed'].toString();
    _newDeaths = jsonData['Global']['NewDeaths'].toString();
    _totalDeaths = jsonData['Global']['TotalDeaths'].toString();
    _newRecovered = jsonData['Global']['NewRecovered'].toString();
    _totalRecovered = jsonData['Global']['TotalRecovered'].toString();

    if (jsonData != null) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          toolbarHeight: 70,
          title: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(
              top: 20,
              bottom: 20,
            ),
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  colors: [Colors.lightBlueAccent, Colors.blue],
                  begin: Alignment.topLeft,
                  end: Alignment.centerRight,
                )),
            child: Row(
              children: [
                Text(
                  'COVID-19 ',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  'LIVE',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                )
              ],
            ),
          ),
          centerTitle: true),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                width: MediaQuery.of(context).size.width * 80 / 100,
                margin: EdgeInsets.only(bottom: 15, top: 15),
                child: Text(
                  'WORLD',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.all(10),
                      height: 150,
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            colors: [Colors.lightBlueAccent, Colors.blue],
                            begin: Alignment.topLeft,
                            end: Alignment.centerRight,
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("New Confirmed",
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          Text(
                            isLoading ? "Loading..." : _newConfirmedcase,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.all(10),
                      height: 150,
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            colors: [Colors.lightBlueAccent, Colors.blue],
                            begin: Alignment.topLeft,
                            end: Alignment.centerRight,
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Total Confirmed",
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          Text(
                            isLoading ? "Loading..." : _totalConfirmedcase,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.all(10),
                      height: 150,
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            colors: [Colors.pinkAccent, Colors.red],
                            begin: Alignment.topLeft,
                            end: Alignment.centerRight,
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("New Deaths",
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          Text(
                            isLoading ? "Loading..." : _newDeaths,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.all(10),
                      height: 150,
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            colors: [Colors.pinkAccent, Colors.red],
                            begin: Alignment.topLeft,
                            end: Alignment.centerRight,
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Total Deaths",
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          Text(
                            isLoading ? "Loading..." : _totalDeaths,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.all(10),
                      height: 150,
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            colors: [Colors.greenAccent, Colors.green],
                            begin: Alignment.topLeft,
                            end: Alignment.centerRight,
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("New Recovered",
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          Text(
                            isLoading ? "Loading..." : _newRecovered,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.all(10),
                      height: 150,
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            colors: [Colors.greenAccent, Colors.green],
                            begin: Alignment.topLeft,
                            end: Alignment.centerRight,
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Total Recovered",
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          Text(
                            isLoading ? "Loading..." : _totalRecovered,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      )),
                ],
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
