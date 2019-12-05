import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json-cors&key=27be98bc";

void main() async {

//  print("Response: ");
//  print(response.body);
//  print(json.decode(response.body)["results"]["currencies"]);

  print(await getData());

  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
      inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber))
      ),
      hintColor: Colors.amber,
      primaryColor: Colors.white
    ),
  ));
}

class bitcoin extends StatefulWidget {
  @override
  _bitState createState() => _bitState();
}

class _bitState extends State<bitcoin> {

  String coret_1 = "blockchain_info";
  String coret_2 = "coinbase";
  String coret_3 = "bitstamp";
  String coret_4 = "foxbit";
  String coret_5 = "mercadobitcoin";
  String coret_6 = "omnitrade";
  String coret_7 = "xdex";

  String name_1;
  String name_2;
  String name_3;
  String name_4;
  String name_5;
  String name_6;
  String name_7;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("\$ Cotação do BitCoin \$",style: TextStyle( color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch(snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                    child: Text("Carregando Dados...",
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 25.0,
                        )

                    )
                );
              default:
                if(snapshot.hasError) {
                  return Center(
                      child: Text("Erro ao Carregar Dados :(",
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 25.0,
                          )
                      )
                  );
                } else {

                  name_1 = snapshot.data["results"]["bitcoin"][coret_1]["name"];
                  name_2 = snapshot.data["results"]["bitcoin"][coret_2]["name"];
                  name_3 = snapshot.data["results"]["bitcoin"][coret_3]["name"];
                  name_4 = snapshot.data["results"]["bitcoin"][coret_4]["name"];
                  name_5 = snapshot.data["results"]["bitcoin"][coret_5]["name"];
                  name_6 = snapshot.data["results"]["bitcoin"][coret_6]["name"];
                  name_7 = snapshot.data["results"]["bitcoin"][coret_7]["name"];

                  return SingleChildScrollView(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(Icons.account_balance_wallet, size: 150, color: Colors.amber, ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(right: 70.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Corretoras", textAlign: TextAlign.left, style: TextStyle(color: Colors.amber, fontSize: 25.0),),
                                      Divider(),
                                      Text("$name_1", style: TextStyle(color: Colors.amber, fontSize: 20.0), ),
                                      Text("$name_2", style: TextStyle(color: Colors.amber, fontSize: 20.0), ),
                                      Text("$name_3", style: TextStyle(color: Colors.amber, fontSize: 20.0), ),
                                      Text("$name_4", style: TextStyle(color: Colors.amber, fontSize: 20.0), ),
                                      Text("$name_5", style: TextStyle(color: Colors.amber, fontSize: 20.0), ),
                                      Text("$name_6", style: TextStyle(color: Colors.amber, fontSize: 20.0), ),
                                      Text("$name_7", style: TextStyle(color: Colors.amber, fontSize: 20.0), )
                                    ],
                                  )
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Preço", textAlign: TextAlign.left, style: TextStyle(color: Colors.amber, fontSize: 25.0)),
                                  Divider(),
                                  valueBitcoin(coret_1, snapshot),
                                  valueBitcoin(coret_2, snapshot),
                                  valueBitcoin(coret_3, snapshot),
                                  valueBitcoin(coret_4, snapshot),
                                  valueBitcoin(coret_5, snapshot),
                                  valueBitcoin(coret_6, snapshot),
                                  valueBitcoin(coret_7, snapshot),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
            }
          }
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final realControler =  TextEditingController();
  final dolarControler =  TextEditingController();
  final euroControler =  TextEditingController();

  double dolar;
  double euro;

  void _clearAll() {
    realControler.text = "";
    dolarControler.text = "";
    euroControler.text = "";
  }
  void _realChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
//    dolarControler.text = (real/dolar).toStringAsPrecision(2);
//    euroControler.text = (real/euro).toStringAsPrecision(2);
    dolarControler.text = (real/dolar).toStringAsFixed(2);
    euroControler.text = (real/euro).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
//    realControler.text = (dolar * this.dolar).toStringAsPrecision(2);
//    euroControler.text = (dolar * this.dolar / euro).toStringAsPrecision(2);
    realControler.text = (dolar * this.dolar).toStringAsFixed(2);
    euroControler.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text);
//    realControler.text = (euro * this.euro).toStringAsPrecision(2);
//    dolarControler.text = (euro * this.euro / dolar).toStringAsPrecision(2);
    realControler.text = (euro * this.euro).toStringAsFixed(2);
    dolarControler.text = (euro * this.euro / dolar).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("\$ Conversor de Moeda \$",style: TextStyle( color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.amber,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.account_balance_wallet),
            onPressed: () {
                Navigator.push(context, new MaterialPageRoute(builder: (context) => new bitcoin()));
              }
            )
        ],
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch(snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text("Carregando Dados...",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25.0,
                    )
                  )
                );
              default:
                if(snapshot.hasError) {
                  return Center(
                    child: Text("Erro ao Carregar Dados :(",
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 25.0,
                      )
                    )
                  );
                } else {
                  dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                  euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

                  return SingleChildScrollView(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(Icons.monetization_on, size: 150, color: Colors.amber, ),
                        buildTextField("Reais", "R\$", realControler, _realChanged),
                        Divider(),
                        buildTextField("Dólares", "US\$", dolarControler, _dolarChanged),
                        Divider(),
                        buildTextField("Euros", "€\$", euroControler, _euroChanged),
                      ],
                    ),
                  );
                }
            }
          }
      ),
    );
  }
}

Widget valueBitcoin (String corretora, AsyncSnapshot snapshot) {
  double value = snapshot.data["results"]["bitcoin"][corretora]["last"];
  String format = snapshot.data["results"]["bitcoin"][corretora]["format"][0];

  if (format == "USD") {
    format = "US\$";
  } else {
    format = "R\$";
  }
  return Padding(
    padding: EdgeInsets.only(top:0.0,bottom: 0.0),
    child: Text("$format $value", style: TextStyle(color: Colors.amber, fontSize: 20.0),),
  );
}

Widget buildTextField(String moeda, String prefix, TextEditingController controller, Function changes) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: moeda,
      labelStyle: TextStyle(color: Colors.amber),
      border: OutlineInputBorder(),
      prefixText: prefix,
    ),
    style: TextStyle(
        color: Colors.amber, fontSize: 25.0
    ),
    onChanged: changes,
    keyboardType: TextInputType.number,
  );
}


Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}
