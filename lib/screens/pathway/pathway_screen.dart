import 'package:flutter/material.dart';
import 'package:university/constants/constants.dart';
import 'package:university/models/embed_model.dart';
import 'package:university/services/embed_service.dart';

class PathwayScreen extends StatelessWidget {
  const PathwayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: screenHeight * 0.12,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Learn Topic", style: kPageTitleText),
                Text("by Mentor Name", style: kPageSubTitleText)
              ],
            ),
          )),
      body: FutureBuilder(
        future: EmbedService().getData('https://youtu.be/VY6003vijLw'),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final medaData = snapshot.data as MetaModel;
          return ListView.builder(
              itemCount: 10,
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              itemBuilder: (context, index) {
                return Row(children: [
                  Column(
                    children: [
                      Container(
                        //VERTICAL LINE
                        width: 2,
                        height: screenHeight * 0.30,
                        color: index == 0 ? kPrimaryColor : kAccentColor,
                      ),
                      Container(
                          //CIRCULAR ICON
                          padding: const EdgeInsets.all(5.0),
                          margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: kAccentColor),
                          child: Icon(Icons.lightbulb, color: kPrimaryColor)),
                      Container(
                        //VERTICAL LINE
                        width: 2,
                        height: screenHeight * 0.055,
                        color: kAccentColor,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            medaData.title,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20),
                          ),
                          Center(
                            child: Image.network(
                              medaData.image,
                              width: 300,
                              height: 180,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ]);
              });
        },
      ),
    );
  }

  // void _launchURL(String url) async =>
  //     await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}
