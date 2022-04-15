import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'WeatherModel.dart';
import 'api_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'World  of Weather',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('World of Weather'),
        ),
        body: Center(
          child: SearchPage(),
        ),
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  WeatherModel weather;
  var cityController = TextEditingController();
  bool searched = false;
  void initState() {
    super.initState();
  }

  void getData() async {
    weather = await WeatherRepo().getWeather(cityController.text);

    setState(() {
      searched = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
              child: Container(
            child: FlareActor(
              "assets/WorldSpin.flr",
              fit: BoxFit.contain,
              animation: "roll",
            ),
            height: 300,
            width: 300,
          )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                TextFormField(
                  controller: cityController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black54,
                    ),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)), borderSide: BorderSide(color: Colors.black38, style: BorderStyle.solid)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)), borderSide: BorderSide(color: Colors.blue, style: BorderStyle.solid)),
                    hintText: "City Name",
                    hintStyle: TextStyle(color: Colors.black54),
                  ),
                  style: TextStyle(color: Colors.black54),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    onPressed: () {
                      setState(() {
                        getData();
                      });
                    },
                    color: Colors.blue,
                    child: Text(
                      "Search",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (weather != null)
                  Visibility(
                    visible: searched,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                (double.parse(weather.getTemp.toStringAsFixed(2)).toString()) + "° C" + "\nTemprature",
                                style: TextStyle(fontSize: 17, color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text((double.parse(weather.getMinTemp.toStringAsFixed(2)).toString()) + "° C" + "\nMin Temprature", style: TextStyle(fontSize: 17, color: Colors.white)),
                              Text((double.parse(weather.getMaxTemp.toStringAsFixed(2)).toString()) + "° C" + "\nMax Temprature", style: TextStyle(fontSize: 17, color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    replacement: Center(child: CircularProgressIndicator()),
                  ),
                Icon(Icons.sunny),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
