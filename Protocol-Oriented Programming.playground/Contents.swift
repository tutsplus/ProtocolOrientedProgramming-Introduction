protocol Drivable {
    var topSpeed: Int { get }
}

protocol Reversible {
    var reverseSpeed: Int { get }
}

protocol Transport {
    var seatCount: Int { get }
}

struct Car: Drivable, Reversible, Transport {
    var topSpeed = 150
    var reverseSpeed = 20
    var seatCount = 5
}

extension Drivable {
    func isFasterThan(item: Drivable) -> Bool {
        return self.topSpeed > item.topSpeed
    }
}

let sedan = Car()
let sportsCar = Car(topSpeed: 250, reverseSpeed: 25, seatCount: 2)

sedan.isFasterThan(sportsCar)

extension Drivable where Self: Reversible {
    func hasLargerRangeThan(item: Self) -> Bool {
        return (self.topSpeed + self.reverseSpeed) > (item.topSpeed + item.reverseSpeed)
    }
}

sportsCar.hasLargerRangeThan(sedan)

extension CollectionType where Self.Generator.Element: Drivable {
    func averageTopSpeed() -> Int {
        var total = 0, count = 0
        for item in self {
            total += item.topSpeed
            count++
        }
        return (total/count)
    }
}

func averageReverseSpeed<T: CollectionType where T.Generator.Element: Reversible>(items: T) -> Int {
    var total = 0, count = 0
    for item in items {
        total += item.reverseSpeed
        count++
    }
    return (total/count)
}

let cars = [Car(), sedan, sportsCar]
cars.averageTopSpeed()
averageReverseSpeed(cars)
