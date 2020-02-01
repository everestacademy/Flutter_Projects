/// This project was created with help of
/// this youtube playlist
/// https://www.youtube.com/playlist?list=PL4cUxeGkcC9jLYyp2Aoh6hcWuxFDX6PBJ
/// from The "Net Ninja" channel
/// and of this youtube video https://www.youtube.com/watch?v=ouVmyHtlkDs&feature=emb_logo
/// from "ProgrammingWizards TV" channel

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/location': (context) => Location(),
    },
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    String bgImage = data['isDayTime'] ? 'day.png' : 'night.png';

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/$bgImage'),
            fit: BoxFit.cover,
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Wrap(
                children: <Widget>[
                  Text(
                    data['url'],
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        color: Colors.white),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    data['time'],
                    style: TextStyle(
                      fontSize: 60.0,
                      letterSpacing: 2.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              ActionChip(
                label: Text(
                  'Edit Location',
                  style: TextStyle(color: Colors.black),
                ),
                backgroundColor: Colors.white,
                onPressed: () async {
                  dynamic result =
                      await Navigator.pushNamed(context, '/location');
                  setState(() {
                    data = {
                      'url': result['url'],
                      'time': result['time'],
                      'isDayTime': result['isDayTime'],
                    };
                  });
                },
                avatar: Icon(Icons.edit_location),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  Map data;
  TextEditingController textEditingController =  TextEditingController();
  bool search = true;
  String query;
  List<String> mainList;
  List<String> filteredList;
  void updateTime(String passedUrl) async {
    WorldTime instance = WorldTime(passedUrl);
    await instance.getTime();
    Navigator.pop(
      context,
      {
        'url': instance.url,
        'time': instance.time,
        'isDayTime': instance.isDayTime,
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // This list from http://worldtimeapi.org/api/timezone
    mainList = [
      "Africa/Abidjan",
      "Africa/Accra",
      "Africa/Algiers",
      "Africa/Bissau",
      "Africa/Cairo",
      "Africa/Casablanca",
      "Africa/Ceuta",
      "Africa/El_Aaiun",
      "Africa/Johannesburg",
      "Africa/Juba",
      "Africa/Khartoum",
      "Africa/Lagos",
      "Africa/Maputo",
      "Africa/Monrovia",
      "Africa/Nairobi",
      "Africa/Ndjamena",
      "Africa/Sao_Tome",
      "Africa/Tripoli",
      "Africa/Tunis",
      "Africa/Windhoek",
      "America/Adak",
      "America/Anchorage",
      "America/Araguaina",
      "America/Argentina/Buenos_Aires",
      "America/Argentina/Catamarca",
      "America/Argentina/Cordoba",
      "America/Argentina/Jujuy",
      "America/Argentina/La_Rioja",
      "America/Argentina/Mendoza",
      "America/Argentina/Rio_Gallegos",
      "America/Argentina/Salta",
      "America/Argentina/San_Juan",
      "America/Argentina/San_Luis",
      "America/Argentina/Tucuman",
      "America/Argentina/Ushuaia",
      "America/Asuncion",
      "America/Atikokan",
      "America/Bahia",
      "America/Bahia_Banderas",
      "America/Barbados",
      "America/Belem",
      "America/Belize",
      "America/Blanc-Sablon",
      "America/Boa_Vista",
      "America/Bogota",
      "America/Boise",
      "America/Cambridge_Bay",
      "America/Campo_Grande",
      "America/Cancun",
      "America/Caracas",
      "America/Cayenne",
      "America/Chicago",
      "America/Chihuahua",
      "America/Costa_Rica",
      "America/Creston",
      "America/Cuiaba",
      "America/Curacao",
      "America/Danmarkshavn",
      "America/Dawson",
      "America/Dawson_Creek",
      "America/Denver",
      "America/Detroit",
      "America/Edmonton",
      "America/Eirunepe",
      "America/El_Salvador",
      "America/Fort_Nelson",
      "America/Fortaleza",
      "America/Glace_Bay",
      "America/Godthab",
      "America/Goose_Bay",
      "America/Grand_Turk",
      "America/Guatemala",
      "America/Guayaquil",
      "America/Guyana",
      "America/Halifax",
      "America/Havana",
      "America/Hermosillo",
      "America/Indiana/Indianapolis",
      "America/Indiana/Knox",
      "America/Indiana/Marengo",
      "America/Indiana/Petersburg",
      "America/Indiana/Tell_City",
      "America/Indiana/Vevay",
      "America/Indiana/Vincennes",
      "America/Indiana/Winamac",
      "America/Inuvik",
      "America/Iqaluit",
      "America/Jamaica",
      "America/Juneau",
      "America/Kentucky/Louisville",
      "America/Kentucky/Monticello",
      "America/La_Paz",
      "America/Lima",
      "America/Los_Angeles",
      "America/Maceio",
      "America/Managua",
      "America/Manaus",
      "America/Martinique",
      "America/Matamoros",
      "America/Mazatlan",
      "America/Menominee",
      "America/Merida",
      "America/Metlakatla",
      "America/Mexico_City",
      "America/Miquelon",
      "America/Moncton",
      "America/Monterrey",
      "America/Montevideo",
      "America/Nassau",
      "America/New_York",
      "America/Nipigon",
      "America/Nome",
      "America/Noronha",
      "America/North_Dakota/Beulah",
      "America/North_Dakota/Center",
      "America/North_Dakota/New_Salem",
      "America/Ojinaga",
      "America/Panama",
      "America/Pangnirtung",
      "America/Paramaribo",
      "America/Phoenix",
      "America/Port-au-Prince",
      "America/Port_of_Spain",
      "America/Porto_Velho",
      "America/Puerto_Rico",
      "America/Punta_Arenas",
      "America/Rainy_River",
      "America/Rankin_Inlet",
      "America/Recife",
      "America/Regina",
      "America/Resolute",
      "America/Rio_Branco",
      "America/Santarem",
      "America/Santiago",
      "America/Santo_Domingo",
      "America/Sao_Paulo",
      "America/Scoresbysund",
      "America/Sitka",
      "America/St_Johns",
      "America/Swift_Current",
      "America/Tegucigalpa",
      "America/Thule",
      "America/Thunder_Bay",
      "America/Tijuana",
      "America/Toronto",
      "America/Vancouver",
      "America/Whitehorse",
      "America/Winnipeg",
      "America/Yakutat",
      "America/Yellowknife",
      "Antarctica/Casey",
      "Antarctica/Davis",
      "Antarctica/DumontDUrville",
      "Antarctica/Macquarie",
      "Antarctica/Mawson",
      "Antarctica/Palmer",
      "Antarctica/Rothera",
      "Antarctica/Syowa",
      "Antarctica/Troll",
      "Antarctica/Vostok",
      "Asia/Almaty",
      "Asia/Amman",
      "Asia/Anadyr",
      "Asia/Aqtau",
      "Asia/Aqtobe",
      "Asia/Ashgabat",
      "Asia/Atyrau",
      "Asia/Baghdad",
      "Asia/Baku",
      "Asia/Bangkok",
      "Asia/Barnaul",
      "Asia/Beirut",
      "Asia/Bishkek",
      "Asia/Brunei",
      "Asia/Chita",
      "Asia/Choibalsan",
      "Asia/Colombo",
      "Asia/Damascus",
      "Asia/Dhaka",
      "Asia/Dili",
      "Asia/Dubai",
      "Asia/Dushanbe",
      "Asia/Famagusta",
      "Asia/Gaza",
      "Asia/Hebron",
      "Asia/Ho_Chi_Minh",
      "Asia/Hong_Kong",
      "Asia/Hovd",
      "Asia/Irkutsk",
      "Asia/Jakarta",
      "Asia/Jayapura",
      "Asia/Jerusalem",
      "Asia/Kabul",
      "Asia/Kamchatka",
      "Asia/Karachi",
      "Asia/Kathmandu",
      "Asia/Khandyga",
      "Asia/Kolkata",
      "Asia/Krasnoyarsk",
      "Asia/Kuala_Lumpur",
      "Asia/Kuching",
      "Asia/Macau",
      "Asia/Magadan",
      "Asia/Makassar",
      "Asia/Manila",
      "Asia/Nicosia",
      "Asia/Novokuznetsk",
      "Asia/Novosibirsk",
      "Asia/Omsk",
      "Asia/Oral",
      "Asia/Pontianak",
      "Asia/Pyongyang",
      "Asia/Qatar",
      "Asia/Qostanay",
      "Asia/Qyzylorda",
      "Asia/Riyadh",
      "Asia/Sakhalin",
      "Asia/Samarkand",
      "Asia/Seoul",
      "Asia/Shanghai",
      "Asia/Singapore",
      "Asia/Srednekolymsk",
      "Asia/Taipei",
      "Asia/Tashkent",
      "Asia/Tbilisi",
      "Asia/Tehran",
      "Asia/Thimphu",
      "Asia/Tokyo",
      "Asia/Tomsk",
      "Asia/Ulaanbaatar",
      "Asia/Urumqi",
      "Asia/Ust-Nera",
      "Asia/Vladivostok",
      "Asia/Yakutsk",
      "Asia/Yangon",
      "Asia/Yekaterinburg",
      "Asia/Yerevan",
      "Atlantic/Azores",
      "Atlantic/Bermuda",
      "Atlantic/Canary",
      "Atlantic/Cape_Verde",
      "Atlantic/Faroe",
      "Atlantic/Madeira",
      "Atlantic/Reykjavik",
      "Atlantic/South_Georgia",
      "Atlantic/Stanley",
      "Australia/Adelaide",
      "Australia/Brisbane",
      "Australia/Broken_Hill",
      "Australia/Currie",
      "Australia/Darwin",
      "Australia/Eucla",
      "Australia/Hobart",
      "Australia/Lindeman",
      "Australia/Lord_Howe",
      "Australia/Melbourne",
      "Australia/Perth",
      "Australia/Sydney",
      "CET",
      "CST6CDT",
      "EET",
      "EST",
      "EST5EDT",
      "Etc/GMT",
      "Etc/GMT+1",
      "Etc/GMT+10",
      "Etc/GMT+11",
      "Etc/GMT+12",
      "Etc/GMT+2",
      "Etc/GMT+3",
      "Etc/GMT+4",
      "Etc/GMT+5",
      "Etc/GMT+6",
      "Etc/GMT+7",
      "Etc/GMT+8",
      "Etc/GMT+9",
      "Etc/GMT-1",
      "Etc/GMT-10",
      "Etc/GMT-11",
      "Etc/GMT-12",
      "Etc/GMT-13",
      "Etc/GMT-14",
      "Etc/GMT-2",
      "Etc/GMT-3",
      "Etc/GMT-4",
      "Etc/GMT-5",
      "Etc/GMT-6",
      "Etc/GMT-7",
      "Etc/GMT-8",
      "Etc/GMT-9",
      "Etc/UTC",
      "Europe/Amsterdam",
      "Europe/Andorra",
      "Europe/Astrakhan",
      "Europe/Athens",
      "Europe/Belgrade",
      "Europe/Berlin",
      "Europe/Brussels",
      "Europe/Bucharest",
      "Europe/Budapest",
      "Europe/Chisinau",
      "Europe/Copenhagen",
      "Europe/Dublin",
      "Europe/Gibraltar",
      "Europe/Helsinki",
      "Europe/Istanbul",
      "Europe/Kaliningrad",
      "Europe/Kiev",
      "Europe/Kirov",
      "Europe/Lisbon",
      "Europe/London",
      "Europe/Luxembourg",
      "Europe/Madrid",
      "Europe/Malta",
      "Europe/Minsk",
      "Europe/Monaco",
      "Europe/Moscow",
      "Europe/Oslo",
      "Europe/Paris",
      "Europe/Prague",
      "Europe/Riga",
      "Europe/Rome",
      "Europe/Samara",
      "Europe/Saratov",
      "Europe/Simferopol",
      "Europe/Sofia",
      "Europe/Stockholm",
      "Europe/Tallinn",
      "Europe/Tirane",
      "Europe/Ulyanovsk",
      "Europe/Uzhgorod",
      "Europe/Vienna",
      "Europe/Vilnius",
      "Europe/Volgograd",
      "Europe/Warsaw",
      "Europe/Zaporozhye",
      "Europe/Zurich",
      "HST",
      "Indian/Chagos",
      "Indian/Christmas",
      "Indian/Cocos",
      "Indian/Kerguelen",
      "Indian/Mahe",
      "Indian/Maldives",
      "Indian/Mauritius",
      "Indian/Reunion",
      "MET",
      "MST",
      "MST7MDT",
      "PST8PDT",
      "Pacific/Apia",
      "Pacific/Auckland",
      "Pacific/Bougainville",
      "Pacific/Chatham",
      "Pacific/Chuuk",
      "Pacific/Easter",
      "Pacific/Efate",
      "Pacific/Enderbury",
      "Pacific/Fakaofo",
      "Pacific/Fiji",
      "Pacific/Funafuti",
      "Pacific/Galapagos",
      "Pacific/Gambier",
      "Pacific/Guadalcanal",
      "Pacific/Guam",
      "Pacific/Honolulu",
      "Pacific/Kiritimati",
      "Pacific/Kosrae",
      "Pacific/Kwajalein",
      "Pacific/Majuro",
      "Pacific/Marquesas",
      "Pacific/Nauru",
      "Pacific/Niue",
      "Pacific/Norfolk",
      "Pacific/Noumea",
      "Pacific/Pago_Pago",
      "Pacific/Palau",
      "Pacific/Pitcairn",
      "Pacific/Pohnpei",
      "Pacific/Port_Moresby",
      "Pacific/Rarotonga",
      "Pacific/Tahiti",
      "Pacific/Tarawa",
      "Pacific/Tongatapu",
      "Pacific/Wake",
      "Pacific/Wallis",
      "WET"
    ];
  }

  _LocationState() {
    //Register a closure to be called when the object changes.
    textEditingController.addListener(() {
      if (textEditingController.text.isEmpty) {
        //Notify the framework that the internal state of this object has changed.
        setState(() {
          search = true;
          query = "";
        });
      } else {
        setState(() {
          search = false;
          query = textEditingController.text;
        });
      }
    });
  }

//Build our Location widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title:  Text("Timezones"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body:  Container(
        margin: EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          top: 10.0,
        ),
        child:  Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1.0),
              ),
              child:  TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            search ? originalListView() : filteredListView()
          ],
        ),
      ),
    );
  }

  //Create a ListView widget
  Widget originalListView() {
    return  Flexible(
      child:  ListView.builder(
          itemCount: mainList.length,
          itemBuilder: (
            BuildContext context,
            int index,
          ) {
            return  Card(
              color: Colors.white,
              elevation: 5.0,
              child:  ListTile(
                leading: Text('$index'),
                title:  Text("${mainList[index]}"),
                onTap: () {
                  updateTime(mainList[index]);
                },
              ),
            );
          }),
    );
  }

  //Perform actual search
  Widget filteredListView() {
    filteredList = List<String>();
    for (int i = 0; i < mainList.length; i++) {
      String item = mainList[i];

      if (item.toLowerCase().contains(query.toLowerCase())) {
        filteredList.add(item);
      }
    }
    return Flexible(
      child:  ListView.builder(
          itemCount: filteredList.length,
          itemBuilder: (BuildContext context, int index) {
            return  Card(
              color: Colors.white,
              elevation: 5.0,
              child:  ListTile(
                leading: Text('$index'),
                title:  Text("${filteredList[index]}"),
                onTap: () {
                  updateTime(filteredList[index]);
                },
              ),
            );
          }),
    );
  }
}

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setWorldTime() async {
    WorldTime instance = WorldTime('Asia/Kolkata');
    await instance.getTime();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'url': instance.url,
      'time': instance.time,
      'isDayTime': instance.isDayTime,
    });
  }

  @override
  void initState() {
    super.initState();
    setWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitCircle(
          color: Colors.blue,
          size: 50.0,
        ),
      ),
    );
  }
}

class WorldTime {
  String time;
  String url;
  bool isDayTime;
  WorldTime(this.url);

  Future<void> getTime() async {
    Response response = await get('http://worldtimeapi.org/api/timezone/$url');
    Map data = jsonDecode(response.body);
    String datetime = data['datetime'];
    String offsetHours = data['utc_offset'].substring(1, 3);
    String offsetMinutes = data['utc_offset'].substring(4, 6);
    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(
        hours: int.parse(offsetHours), minutes: int.parse(offsetMinutes)));
    time = DateFormat.jm().format(now);
    isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
  }
}
//----------------
