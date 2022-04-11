import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '2nd.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _namecontroller = TextEditingController();

  TextEditingController _heightontroller = TextEditingController();
  TextEditingController _updateController = TextEditingController();

  // List<String> name = ['Shafi', 'Rakib', 'Bondhon', 'Rahat'];

  // List<double> height = [.32, 3.67, 5.33, 6.77, 4.55];

  Box? heightBox;

  @override
  void initState() {
    heightBox = Hive.box('Data');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: _namecontroller,
                            decoration: InputDecoration(hintText: 'Name'),
                          ),
                          TextField(
                            controller: _heightontroller,
                            decoration: InputDecoration(hintText: 'Height'),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              var inputname = _namecontroller.text;
                              var inputheight = _namecontroller.text;

                              await heightBox?.add(inputname);
                              print('added');

                              Navigator.pop(context);
                            },
                            child: Text('Done'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(title: Text('Hive Practise')),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Container(
                height: 400,
                child: ValueListenableBuilder(
                  valueListenable: Hive.box('Data')
                      .listenable(), //it will listen all value according to box
                  builder:
                      (BuildContext context, dynamic value, Widget? child) {
                    return ListView.builder(
                      itemCount: heightBox!.keys.toList().length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            title: Text(heightBox!.getAt(index).toString()),
                            // subtitle: Text(heightBox[index].toString()),
                            trailing: Container(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text('Update'),
                                                content: Column(
                                                  children: [
                                                    Text('Edit'),
                                                    TextField(
                                                      controller:
                                                          _updateController,
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          var updatetxt =
                                                              _updateController
                                                                  .text;
                                                          heightBox!.putAt(
                                                              index, updatetxt);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text('Update'))
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      icon: Icon(Icons.edit)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        heightBox!.deleteAt(index);
                                      },
                                      icon: Icon(Icons.delete)),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    print(_namecontroller.text);
                  },
                  child: Text('Show Data')),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => second()));
                  },
                  child: Text('2nd screen'))
            ],
          ),
        ),
      ),
    );
  }
}
