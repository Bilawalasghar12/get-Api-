import 'package:flutter/material.dart';
import 'model class.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: App(),
      ),
    ),
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.purple,
          centerTitle: true,
          title: Text('listTile'),
        ),
        body: FutureBuilder<SkillDetail>(
            future: getBbb(),
            builder: (context, AsyncSnapshot<SkillDetail> snapshot) {
              return snapshot.hasData
                  ?
                    ListView.builder(
                      itemCount: snapshot.data!.data.all.length,
                       itemBuilder: (context, index) {
                         return Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Image.network(
                                    ('${snapshot.data!.data.all[index].pngImage}'),
                                    height: 70,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      Text('${snapshot.data!.data.all[index].name}'),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Text('${snapshot.data!.data.all[index].id}', )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          );
                       }
                     )

                  : CircularProgressIndicator();
            }));
  }

  Future<SkillDetail> getBbb() async {
    final token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3N0YWdpbmcuZ2V0LWxpY2Vuc2VkLmNvLnVrL2d1YXJkcGFzcy9hcGkvYXV0aC9sb2dpbiIsImlhdCI6MTY3NDgwNzkzMCwibmJmIjoxNjc0ODA3OTMwLCJqdGkiOiJJYVhac3oxQ1hhMFJTdzFtIiwic3ViIjoiMTciLCJwcnYiOiIyZTE2YThmMGRmMzcxNTZkNTkxMzJjZDk5NGEzMjY1OTdhNWMzZDViIiwiaWQiOjE3LCJ0eXBlIjoiSk9CU0VFS0VSIn0.cSKMkIBQ978DT1pZy-myAu9dTIcM-O-1SPFr1GArwkI";

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Accept": "application/json"
    };

    String x = "https://staging.get-licensed.co.uk/guardpass/api/skill/all";

    final response = await http.get(
      Uri.parse(
        x,
      ),
      headers: headers,
    );

    var data = jsonDecode(response.body);
    print(data);

    return SkillDetail.fromJson(data);
  }
}
