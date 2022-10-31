class FoodItem {
  final int id;
  final String name;
  final int price;
  final String image;

  FoodItem(
      {required this.id,
      required this.name,
      required this.price,
      required this.image});
  String toString(){
    return "$id $name $price $image";
  }
  factory FoodItem.fromJason(Map<String,dynamic> json){
    return FoodItem(
      id:json['id'],
      name:json['name'],
      price:json['price'],
      image:json['image'],
    );
  }
}
