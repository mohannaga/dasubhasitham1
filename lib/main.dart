import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carousel Slider',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyWidget(),
    );
  }
}

Future fetchData() async {
  print('fetching data...');
  Map data = {"typeOf": "homeScreen", "page": 0, "perPage": 5};
  var body = json.encode(data);
  final response = await http.post(
      Uri.parse(
          'https://dev.dasubhashitam.com/api/dasubhashitam/v1/titles/fetchCardDetails'),
      body: body);

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON
    final data = json.decode(response.body);
    print(data);
    return data;
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load data');
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Display a loading indicator while waiting for data
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          // Display the fetched data
          final data = snapshot.data;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                  // title: Text(data['titles']['index']['title']),
                  // Customize the UI as needed
                  );
            },
          );
        }
      },
    );
  }
}

// class CarouselSliderExample extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(children: [
//         CarouselSlider(
//           items: [
//             Container(
//               margin: EdgeInsets.all(8.0),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10.0),
//                 image: DecorationImage(
//                   image: NetworkImage(
//                       "https://uploads-ssl.webflow.com/5a02e9549424fd0001b14f92/60fad3b6a6399a42157f60cf_t-AJ-2-Book.jpg"),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(8.0),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10.0),
//                 image: DecorationImage(
//                   image: NetworkImage(
//                       "https://play-lh.googleusercontent.com/Su12d38Ril2TRXRcPT4UfDz-Re87b6SRWo80dBDdkT8KHJ0KAKk4O1d7yN81OLMzspE=w526-h296-rw"),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(8.0),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10.0),
//                 image: DecorationImage(
//                   image: NetworkImage(
//                       "https://play-lh.googleusercontent.com/8E9R5juotNPOaBqyvcccQvSOx4g3as9ImM532cC-fKVjd-NEjzCib_zjTa93UAvWodg=w526-h296-rw"),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ],
//           options: CarouselOptions(
//             height: 380.0,
//             enlargeCenterPage: true,
//             autoPlay: true,
//             aspectRatio: 16 / 9,
//             autoPlayCurve: Curves.fastOutSlowIn,
//             enableInfiniteScroll: true,
//             autoPlayAnimationDuration: Duration(milliseconds: 800),
//             viewportFraction: 0.8,
//           ),
//         ),
//       ]),
//     );
//   }
// }



