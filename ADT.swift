// list
enum List<T> {
  indirect case Node(T, List<T>)
  case Nothing
}


func head<T>(_ list: List<T>) -> T? {
  switch list {
  case .Nothing:
    return nil
  case let .Node(val, _):
    return val
  }
}

func prepend<T>(_ e: T, _ list: List<T>) -> List<T> {
  return List.Node(e, list)
}

func toArray<T>(_ list: List<T>) -> [T] {
  switch list  {
  case .Nothing:
    return []
  case let .Node(val, next):
    return [val] + toArray(next)
  }
}

func drop<T>(_ count: Int, _ list: List<T>) -> List<T> {
  if count <= 0 {
    return list
  }
  switch list  {
  case .Nothing:
    return list
  case let .Node(_, next):
    return drop(count-1, next)
  }
}

var list : List<Int>
list = List.Node(3, List.Node(5, List.Node(7, List.Nothing)))

print(toArray(list))
print(head(list) ?? "empty")

var copy = prepend(1, list)
print(toArray(copy))
copy = drop(3, copy)
print(toArray(copy))
print(toArray(list))




// maybe
enum Maybe<A> {
  case Nothing
  case Just(A)
}

let a : Maybe<Int> = .Nothing
print(a)
let b : Maybe<Int> = .Just(3)
print(b)





// tree
enum BinaryTree<T> {
  indirect case Node(T, BinaryTree<T>, BinaryTree<T>)
  case Nothing
}

func inorder<T>(_ root: BinaryTree<T>) -> [T] {
  switch root  {
  case .Nothing: 
    return []
  case let .Node(val, left, right):
    return inorder(left) + [val] + inorder(right) 
    // return inorder(left) as [T] + [val] + inorder(right) 
    // let l = inorder(left) 
    // let r = inorder(right)
    // return l + [val] + r
  }
}

func height<T>(_ root: BinaryTree<T>) -> Int {
  switch root  {
  case .Nothing:
    return 0
  case let .Node(_, left, right):
    return max(height(left), height(right)) + 1
  }
}

let root : BinaryTree<Int> = 
  BinaryTree.Node(
    3, 
    BinaryTree.Node(
      5, 
      BinaryTree.Nothing, 
      BinaryTree.Nothing
    ), 
    BinaryTree.Node(
      7, 
      BinaryTree.Nothing, 
      BinaryTree.Nothing
    )
  )

print(inorder(root)) // [5, 3, 7]

print(height(root)) // 2








