import 'package:flutter/material.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: DataPage());
  }
}

class DataPage extends StatefulWidget {
  const DataPage({Key? key}) : super(key: key);

  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Information"),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: FutureBuilder(
          builder: (context, snapshot) {
            var showData = json.decode(snapshot.data.toString());
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        child: CircleAvatar(
                          backgroundImage: showData[index].containsKey('avatar')
                              ? NetworkImage(showData[index]['avatar'])
                              : NetworkImage(
                                  'https://icon-library.com/images/profile-icon-white/profile-icon-white-7.jpg'),
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  showData[index]['first_name'] +
                                      " " +
                                      showData[index]['last_name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(showData[index]['username']),
                                Text(showData[index].containsKey("status")
                                    ? showData[index]['status']
                                    : 'N/A')
                              ],
                            ),
                          )),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        child: Column(
                          children: [
                            Text(
                              showData[index]['last_seen_time'],
                            ),
                            CircleAvatar(
                              child: Text(
                                  showData[index].containsKey("messages")
                                      ? showData[index]['messages'].toString()
                                      : ''),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              itemCount: showData.length,
            );
          },
          future: DefaultAssetBundle.of(context)
              .loadString("assets/data_list.json"),
        ),
      ),
    );
  }
}
