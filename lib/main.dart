import "package:flutter/material.dart";

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController=TextEditingController();
  TextEditingController alturaController=TextEditingController();
  GlobalKey<FormState>formkey=GlobalKey<FormState>();

  String _informe="Informe o seu peso e altura para calcular o seu IMC";
  void _resetar(){
    setState(() {
    pesoController.text="";
    alturaController.text="";
    _informe="Informe o seu peso e altura para calcular o seu IMC";
    
    });
    
  }
void _calcular(){
  setState(() {
     double peso=double.parse(pesoController.text);
  double altura=double.parse(alturaController.text)/100;
  double imc= peso/(altura*altura);
  if(imc<18.6){
    _informe="Abaixo do peso (${imc.toStringAsPrecision(3)})";
  }else if(imc>=18.6&&imc<24.9){
    _informe="Peso Normal (${imc.toStringAsPrecision(3)})";
  }else if(imc>=24.9&&imc<29.9){
     _informe="Sobrepeso (${imc.toStringAsPrecision(3)})";
  }else if(imc>=29.9&&imc<34.9){
    _informe="Obesidade I (${imc.toStringAsPrecision(3)})";

  } else if(imc>=34.9&&imc<39.9){
    _informe="Obesidade II (${imc.toStringAsPrecision(3)})";
  }else if(imc>40){
    _informe="Obesidade III (${imc.toStringAsPrecision(3)})";
  }

  });
 
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Calculadora IMC",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.orange,
              ),
              onPressed: _resetar,
            )
          ],
        ),
        body: SingleChildScrollView(
          padding:EdgeInsets.fromLTRB(15.0,0.0,15.0,0.0),
          child:Form(
            key:formkey,
            child:Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(Icons.person, size: 110.0, color: Colors.blue[200]),
            TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (KG)",
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.purple[200], fontSize: 25),
                controller:pesoController,
                validator:(value){
                  if(value.isEmpty){
                    return "Por favor insira seu peso";
                  }else if(value.length>3){
                    return "Valor não permitido";

                  }else if(double.parse(value)>600){
                    return "Valor não permitido";
                  }
                  else if(double.parse(value)<=0){
                    return "Digite um valor válido por favor ";
                  }

                  
                } ,
                ),

            TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (Cm)",
                    labelStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.orange[200], fontSize: 25),
                controller:alturaController,
                validator:(value){
                  if(value.isEmpty){
                    return "Por favor insira sua altura";
                  }else if(value.length>3){
                    return "Valor não permitido";

                  }else if(double.parse(value)>=246){
                    return "Valor não permitido";
                  }else if(double.parse(value)<50){
                    return "Valor não permitido";
                  }

                },
                ),
              Padding(
                padding:EdgeInsets.only(top:30.0,bottom:15.0) ,
                child: Container(
                 height:50.0,
                 child: RaisedButton(
                  onPressed:(){
                    if(formkey.currentState.validate()){
                      _calcular();
                    }
                  },
                  child:Text("Calcular",style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize:20.0  )),
                  color:Colors.blue[200],
                )
               ),
              ),
               Text(_informe,textAlign:TextAlign.center ,
               style:TextStyle(
                 color:Colors.blue[200],
                 fontWeight:FontWeight.bold,
                 fontSize:15 
               )
               )
          ],
        ),
          )
        ),
        );
  }
}
