enum Property {
  case Width(String)
  case Height(String)
}

enum Element {
  indirect case Div([Property], [Element])
  indirect case Span([Property], [Element])
  case Text(String)
}

func toHtml(_ prop: Property) -> String {
  switch prop {
  case let .Width(val):
    return "width=\"\(val)\""
  case let .Height(val):
    return "height=\"\(val)\""
  }
}
func toHtml(_ root: Element) -> String {
  switch root {
  case let .Div(props, children):
    return toHtml("div", props, children)
  case let .Span(props, children):
    return toHtml("span", props, children)
  case let .Text(val):
    return val
  }
}
func toHtml(_ tag: String, _ props: [Property], _ children: [Element]) -> String {
  let propsHtml = props.map {
    toHtml($0)
  }.joined(separator: ", ")

  let childrenHtml = children.map {
    toHtml($0)
  }.joined(separator: "\n")

  return "<\(tag) \(propsHtml)>\(childrenHtml)</\(tag)>" 
}

let html : Element =
  .Div(
    [ .Width("10")], 
    [ .Div([], [ .Text("hello, world") ])
    , .Span([], [ .Text("Ya!") ])
    ]
  )

print(html)
print(toHtml(html))

