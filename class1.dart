class Point {
  double x;
  double y;

  Point(this.x, this.y);

  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(json['x'] as double, json['y'] as double);
  }

  double distanceTo(Point other) {
    var dx = other.x - this.x;
    var dy = other.y - this.y;
    return Math.sqrt(dx * dx + dy * dy);
  }
}

void main() {
  var p = Point(2, 2);

  // Get the value of y.
  assert(p.y == 2);

  // Invoke distanceTo() on p.
  double distance = p.distanceTo(Point(4, 4));
  print("Distance between (2, 2) and (4, 4) is: $distance");

  // If p is non-null, set a variable equal to its y value.
  var a = p?.y;
  print("Value of a (y from p): $a");

  var p1 = Point(2, 2);
  var p2 = Point.fromJson({'x': 1, 'y': 2});
  print("p1: (${p1.x}, ${p1.y})");
  print("p2: (${p2.x}, ${p2.y})");
}

class ImmutablePoint {
  final int x;
  final int y;

  const ImmutablePoint(this.x, this.y);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ImmutablePoint) return false;
    ImmutablePoint otherPoint = other;
    return x == otherPoint.x && y == otherPoint.y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  String toString() => 'ImmutablePoint($x, $y)';
}

void main() {
  // Using const keywords to create constant map and its contents.
  const pointAndLine = const {
    'point': const [const ImmutablePoint(0, 0)],
    'line': const [const ImmutablePoint(1, 10), const ImmutablePoint(-2, 11)],
  };

  // Only one const, which establishes the constant context for the map.
  // Its contents are not individually declared as const.
  const pointAndLineSimple = {
    'point': [ImmutablePoint(0, 0)],
    'line': [ImmutablePoint(1, 10), ImmutablePoint(-2, 11)],
  };

  // Creating a constant instance of ImmutablePoint.
  var a = const ImmutablePoint(1, 1);

  // Creating a non-constant instance of ImmutablePoint.
  var b = ImmutablePoint(1, 1);

  // Checking if a and b are the same instance.
  // Since a is a constant and b is not, they cannot be the same instance.
  assert(!identical(a, b));

  // Printing the objects to verify their values.
  print('a: $a');
  print('b: $b');

  // Accessing the constant map and its contents.
  print('pointAndLine point: ${pointAndLine['point'][0]}');
  print('pointAndLine line start: ${pointAndLine['line'][0]}');
  print('pointAndLine line end: ${pointAndLine['line'][1]}');

  // Accessing the simple constant map and its contents.
  print('pointAndLineSimple point: ${pointAndLineSimple['point'][0]}');
  print('pointAndLineSimple line start: ${pointAndLineSimple['line'][0]}');
  print('pointAndLineSimple line end: ${pointAndLineSimple['line'][1]}');
}
// Point class with nullable x and y properties.
class Point {
  double? x; // Declare instance variable x, initially null.
  double? y; // Declare y, initially null.

  // OK, can access declarations that do not depend on `this`:
  double? initialX = 1.5;
  double? xWithDefault = initialX;

  // ERROR, can't access `this` in non-`late` initializer:
  // double? yWithError = this.x; // Uncomment to see the error

  // OK, can access `this` in `late` initializer:
  late double? z = this.initialX;

  // OK, `this.fieldName` is a parameter declaration, not an expression:
  Point(this.x, this.y);
}

// Person class with a private name and a greet method.
class Person {
  final String _name;

  Person(this._name);

  String greet(String who) => 'Hello, $who. I am $_name.';
}

// Impostor class implements the Person interface but reveals no name.
class Impostor implements Person {
  String get _name => '';

  Impostor() {} // No need for a named constructor since we're not passing _name.

  @override
  String greet(String who) => 'Hi $who. Do you know who I am?';
}

// Function that greets Bob using a Person.
String greetBob(Person person) => person.greet('Bob');

void main() {
  // Create a Point object and set its x value.
  var point = Point();
  point.x = 4;
  print('Point x: ${point.x}');
  print('Point y: ${point.y ?? 'null'}'); // Use null coalescing operator to print 'null' if y is null.

  // Create a Person object and greet Bob.
  var person = Person('Alice');
  print(greetBob(person)); // Should print: Hello, Bob. I am Alice.

  // Create an Impostor object and greet Bob.
  var impostor = Impostor();
  print(greetBob(impostor)); // Should print: Hi Bob. Do you know who I am?
}
