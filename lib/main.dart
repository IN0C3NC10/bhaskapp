import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String result="Informe os coeficientes!";

  TextEditingController aController = TextEditingController();
  TextEditingController bController = TextEditingController();
  TextEditingController cController = TextEditingController();


  //..function for reset fields
  void resetFields(){
    aController.text="";
    bController.text="";
    cController.text="";
    setState(() {
      result="Informe os coeficientes!";
      formKey = GlobalKey<FormState>();
    });
  }

  //..rules of your app
  void calculate(){
    setState(() {
      double a = double.parse(aController.text);
      double b = double.parse(bController.text);
      double c = double.parse(cController.text);
      double del, bhasP, bhasN;
      
      del = (pow(b, 2) - (4*a*c));

      //..does comparisons
      if(del < 0){
        result = "Delta = ${del.toString()}\nMenor que '0' não há 'x'!";
      }else if(del == 0){
        bhasP=(((-(b))+(sqrt(del)))/(2*a));
        result="Delta = 0\nx= ${bhasP.toString()}";
      }else{
        bhasP=(((-(b))+(sqrt(del)))/(2*a));
        bhasN=(((-(b))-(sqrt(del)))/(2*a));
        result="x'= ${bhasP.toString()} || x\"= ${bhasN.toString()}";
      }
    });
  }

  //..layout of your app
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //..configuration from top bar
      appBar: AppBar(
        title: Text("BhaskApp", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), 
            onPressed: (){
              resetFields();
          })
        ],
      ),

      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        //"SingleChildScrollView" USADO PARA NÃO ATRAPAHAR O TECLADO E ROLAR A TELA
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //..icon on top
              Icon(Icons.calculate, size: 120.0, color: Colors.blue),

              //..first input
              TextFormField(keyboardType: TextInputType.numberWithOptions(signed: true,), //..select keyboard type
                decoration: InputDecoration(
                    labelText: "Coeficiente 'A'",
                    labelStyle: TextStyle(color: Colors.blue[900])
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 25.0),
                controller: aController,
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty){
                    return "Insira o coeficiente 'A'!";
                  }}
              ),

              //..second input
              TextFormField(keyboardType: TextInputType.numberWithOptions(signed: true), //..select keyboard type
                decoration: InputDecoration(
                    labelText: "Coeficiente 'B'",
                    labelStyle: TextStyle(color: Colors.blue[900])
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 25.0),
                controller: bController,
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty){
                    return "Insira o coeficiente 'B'!";
                  }}
              ),

              //..third input
              TextFormField(keyboardType: TextInputType.numberWithOptions(signed: true), //..select keyboard type
                decoration: InputDecoration(
                    labelText: "Coeficiente 'C'",
                    labelStyle: TextStyle(color: Colors.blue[900])
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 25.0),
                controller: cController,
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty){
                    return "Insira o coeficiente 'C'!";
                  }}
              ),

              //..button
              Padding(
                padding: EdgeInsets.only(top:10.0, bottom:10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    //..with this, you can use your function
                    onPressed: (){
                      if (formKey.currentState.validate()){
                        calculate();
                      }
                    },
                    child: Text("Bhaskarar",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.blue,
                  ),
                ),
              ),

              //..the text or result
              Text(result,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue[900],
                  fontSize: 25.0,
                ),
              )
            ],
          ),
        )
      )
    );
  }
}
