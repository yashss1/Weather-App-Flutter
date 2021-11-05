import 'package:flutter/material.dart';
import 'package:climate_check/services/location.dart';
import 'package:climate_check/services/networking.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//Flutter spinkit has been used for the loader

const apiKey = '3de44e214ea931e546d6dac92c20d880';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude = 0, longitude = 0;

  @override
  void initState() {
    super.initState();
    getlocationData();
  }

  void getlocationData() async {
    Location location = Location();
    await location.getCurrentLocation();

    latitude = location.latitude;
    longitude = location.longitude;

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();

    // Going to next page and also passing the data of the json file
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  // Made for Practice
  void getData() async {
    // USING JSON
    // print(data);
    // var longitude = jsonDecode(data)['coord']['lon'];
    // var lattitude = jsonDecode(data)['coord']['lat'];
    // var weatherDescription = jsonDecode(data)['weather'][0]['description'];
    // print(longitude);
    // print(lattitude);
    // print(weatherDescription);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
