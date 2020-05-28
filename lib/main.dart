import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Demo App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SimpleTab(),
    );
  }
}

class CustomTab {
  const CustomTab({this.title, this.color});

  final String title;
  final Color color;
}

class SimpleTab extends StatefulWidget {
  @override
  _SimpleTabState createState() => _SimpleTabState();
}

class _SimpleTabState extends State<SimpleTab>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  String selectedContainer = "";
  var data = [
    {
      'name': 'Shopping',
      'icon': Icons.local_shipping,
      'submenu': [
        "Action1",
        "Action2",
        "Action1",
        "Action2",
        "Action1",
        "Action2",
        "Action1",
        "Action2"
      ]
    },
    {
      'name': 'Service',
      'icon': Icons.room_service,
      'submenu': ["Action3", "Action5"]
    },
    {
      'name': 'Hotel',
      'icon': Icons.hotel,
      'submenu': ["Action4", "Action5"]
    },
    {
      'name': 'More',
      'icon': Icons.more,
      'submenu': ["Action6", "Action7"]
    },
    {
      'name': 'Custom',
      'icon': Icons.add_to_photos,
      'submenu': ["Action8", "Action9"]
    },
    {
      'name': 'Custom2',
      'icon': Icons.add_to_photos,
      'submenu': ["Action10", "Action11"]
    },
    {
      'name': 'Custom3',
      'icon': Icons.add_to_photos,
      'submenu': ["Action11", "Action12"]
    },
    {
      'name': 'Custom4',
      'icon': Icons.add_to_photos,
      'submenu': ["Action13", "Action14"]
    },
  ];

  @override
  Widget build(BuildContext context) {
//    selectedContainer = "";
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: bottomBar(data),
          )
        ],
      ),
    );
  }

  Widget bottomBar(data) {
    return new Container(
        margin: EdgeInsets.only(bottom: 10),
        constraints: new BoxConstraints(
          minHeight: 40.0,
          maxHeight: 140.0,
        ),
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: createTopMenu(),
            ),
            Expanded(
              child: new ListView(
                scrollDirection: Axis.horizontal,
                children: data
                    .map<Widget>((e) => Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    AnimatedContainer(
                      height: selectedContainer != e['name'] ? 50 : 60,
                      width: selectedContainer != e['name'] ? 70 : 80,
                      duration: Duration(milliseconds: 150),
                      curve: Curves.fastOutSlowIn,
                      child: GestureDetector(
                        child: new Container(
                          color: Colors.transparent,
                          margin: EdgeInsets.only(right: 20, left: 4),
                          child: AnimatedContainer(
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            duration: Duration(milliseconds: 150),
                            curve: Curves.fastOutSlowIn,
                            width: selectedContainer != e['name']
                                ? 30
                                : 40,
                            child: new LayoutBuilder(
                                builder: (context, constraint) {
                                  return Padding(
                                      padding: EdgeInsets.all(4),
                                      child: new Icon(
                                        e['icon'],
                                        size: constraint.biggest.width - 16,
                                        color:
                                        selectedContainer != e['name']
                                            ? Colors.grey
                                            : Colors.green,
                                      ));
                                }),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            if (selectedContainer == e['name']) {
                              selectedContainer = '';
                            } else {
                              selectedContainer = e['name'];
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ))
                    .toList(),
              ),
            )
          ],
        ));
  }

  Widget createTopMenu() {
    if (selectedContainer == "") {
      return Container();
    }
    var item =
    this.data.firstWhere((element) => element["name"] == selectedContainer);
    if (item == null) return Container();
    return new ListView(
      scrollDirection: Axis.horizontal,
      children: (item['submenu'] as List<String>)
          .map<Widget>((e) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            child: new Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 2),
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.all(Radius.circular(20))),
                height: 40,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(right: 20, left: 4),
                child: Text(
                  e,
                  style: TextStyle(color: Colors.green),
                )),
            onTap: () {},
          ),
        ],
      ))
          .toList(),
    );
  }
}
