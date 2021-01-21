import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class TODOLOGIC extends ChangeNotifier {
  List<String> list = [];

  TODOLOGIC() {
    list.add("1");
  }

  void addData(String a) {
    list.add(a);
    print(list);
    notifyListeners();
    print("Listener Notifed");
  }
}

List<String> list = [];
String w;
String val;
String val1;
int h;
int id;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    print(w);

    return ChangeNotifierProvider(
      create: (_) => TODOLOGIC(),
      child: MaterialApp(
        title: 'Notes App',
        home: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text('Notes'),
          ),
          body: Builder(builder: (context) {
            var todoLogic = Provider.of<TODOLOGIC>(context);
            return Container(
                child: list.isEmpty
                    ? Center(child: Text("NO NOTES BUDDY"))
                    : ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (ctx, index) {
                          val = list[index];
                          if (val.length > 5) {
                            for (int i = 0; i < val.length; i++) {
                              if (val[i] == ' ') {
                                h = i;
                                break;
                              }
                            }
                            val = val.substring(0, h);
                          }
                          return Dismissible(
                            background: stackBehindDismiss(),
                            key: ObjectKey(list[index]),
                            onDismissed: (DismissDirection direction) {
                              var item = list.elementAt(index);
                              setState(() {
                                list.removeAt(index);
                              });
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("Item deleted"),
                                  action: SnackBarAction(
                                      label: "UNDO",
                                      onPressed: () {
                                        //To undo deletion
                                        undoDeletion(index, item);
                                      })));
                            },
                            child: Card(
                              elevation: 5,
                              margin: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 5,
                              ),
                              child: ListTile(
                                title: Text(val == null ? '' : val),
                                onTap: () {
                                  setState(() {
                                    id = index;
                                  });

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Newstate(list),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ));
          }),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                        create: (context) => TODOLOGIC(),
                        child: SecondRoute())),
              );
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  void undoDeletion(index, item) {
    /*
  This method accepts the parameters index and item and re-inserts the {item} at
  index {index}
  */
    setState(() {
      list.insert(index, item);
    });
  }

  Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }
}

String a;

class SecondRoute extends StatefulWidget {
  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  final myController = TextEditingController();
  // String a = "nakul";

  @override
  Widget build(BuildContext context) {
    var todoLogic = Provider.of<TODOLOGIC>(context);
    print(todoLogic.list);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notes'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.done,
                color: Colors.white,
              ),
              onPressed: () {
                a = myController.text;
                if (a != '') {
                  list.add(myController.text);
                  myController.clear();
                }

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => MyApp()),
                );
              },
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 100.0,
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Write you note here!',
                  border: InputBorder.none,
                ),
                controller: myController,
                maxLines: null,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                autofocus: true,
              ),
            ),
            Container(height: 100.0)
          ],
        ),
      ),
    );
  }
}

//Making new class
String d;

class Newstate extends StatefulWidget {
  Newstate(list);
  @override
  _NewstateState createState() => _NewstateState();
}

class _NewstateState extends State<Newstate> {
  // String e=list[id];
  final myController = TextEditingController();
  // String a = "nakul";

  @override
  Widget build(BuildContext context) {
    // print(list);

    var todoLogic = Provider.of<TODOLOGIC>(context);
    print(todoLogic.list);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notes'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.done,
                color: Colors.white,
              ),
              onPressed: () {
                //  print(myController.text);

                d = myController.text;
                if (d == '') {
                  list[id] += '';
                } else {
                  list[id] = myController.text;
                  // list.replaceRange(id, id + 1, [myController.text]);
                }

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => MyApp()),
                );
              },
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 100.0,
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Write Your Note Here.',
                  //d=myController.text,
                  border: InputBorder.none,
                ),
                // d=myController.text,
                controller: myController,
                maxLines: null,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                autofocus: true,
              ),
            ),
            Container(height: 100.0, child: SelectableText(' ' + list[id]))
          ],
        ),
      ),
    );
  }
}
