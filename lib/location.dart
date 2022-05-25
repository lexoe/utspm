import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uts/maps.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
    required this.title,
    required this.nama,
  }) : super(key: key);

  final String title;
  final String nama;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _latitude = "";
  var _longitude = "";
  var _altitude = "";
  var _speed = "";
  var _address = "";
  final _formKey = GlobalKey<FormState>();

  Future<void> _updatePosition() async {
    Position pos = await _determinePosition();
    List pm = await placemarkFromCoordinates(pos.latitude, pos.longitude);
    setState(() {
      _latitude = pos.latitude.toString();
      _longitude = pos.longitude.toString();
      _altitude = pos.altitude.toString();
      _speed = pos.speed.toString();
      _address = pm[0].toString();
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnable;
    LocationPermission permission;
    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      return Future.error('Location Services are disable');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permission are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location Permission are permanently denied, we cannot request permission');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("NAMA KAMU"),
            Text(
              widget.nama,
              style: TextStyle(fontSize: 30),
            ),
            Text(
              "Kamu sedang sakit di rumah aja ya",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Sekarang kamu ada di:",
              style: TextStyle(fontSize: 20),
            ),
            Text(_address),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                     {
                      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Maps(),
          ));
                    }
                  },
                  child: const Text('Klik disini jika butuh isolasi'),
                ),
              ),
          ],
        ),
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _updatePosition,
        tooltip: 'Get GPS position',
        child: const Icon(Icons.change_circle_outlined),
      ),
    );
  }
}