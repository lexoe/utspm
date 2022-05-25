import 'package:flutter/material.dart';

class Maps extends StatelessWidget {
  const Maps({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(color: Colors.blue,
        alignment: Alignment.center,
        height: 300,
        width: 600,
        child: const Text("Isinya maps"),),
        SizedBox(
          height: 380,
          width: 400,
          //color: Colors.black,
          child:
        ListView.builder(itemCount: 100,
        itemBuilder: (context, index) {
          return const ListTile(
            leading: CircleAvatar(),
            title: Text("list tempat isolasi"),
          );
        },))
      ]),
      );
  }
}