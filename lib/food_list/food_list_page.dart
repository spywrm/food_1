import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_1/models/food_item.dart';
import 'package:http/http.dart' as http;

const apiBaseUrl = 'https://cpsu-test-api.herokuapp.com';
const apiGetFoods = '$apiBaseUrl/foods';

class FoodListPage extends StatefulWidget {
  const FoodListPage({Key? key}) : super(key: key);

  @override
  State<FoodListPage> createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  List<FoodItem>? foodList = [];

  void _handleClickButton() async {
    var response = await http.get(Uri.parse(apiGetFoods));
    var output = jsonDecode(response.body);
    print(response.statusCode);
    print(response.body);
    output['data'].forEach((item) {
      //print(item['name'] + ' ราคา ' + item['price'].toString());
      var foodItem = FoodItem.fromJason(item);
      print(foodItem);
      setState(() {
        foodList!.add(foodItem);
      });
    });
    print(foodList!.length);
  }

  Widget Mybox1(index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        child: Row(
          children: [
            Image.network("${foodList![index].image}",width: 200,height: 200),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${foodList![index].id}"),
                Text("${foodList![index].name}"),
                Text("${foodList![index].price}"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FOOD LIST")),

      body: Column(

        children: [
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (){
                setState(() {
                  foodList = <FoodItem>[];
                });
                _handleClickButton();
              },
              child: Text('${foodList!.length}'),
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ListView.builder(
                  itemBuilder: (context, index) {
                    return Mybox1(index);
                  },
                  itemCount: foodList!.length,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
