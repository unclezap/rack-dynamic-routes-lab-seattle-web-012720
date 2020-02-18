
class Application
    def call(env)

        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match("/items/")
            item_searched_name = req.path.split("/items/").last
            item_searched = Item.all.find {|i| i.name == item_searched_name}
            if item_searched != nil
                resp.write "#{item_searched.price}"
            else
                resp.write "Item not found"
                resp.status = 400
            end
        else
            resp.write "Route not found"
            resp.status = 404
        end
        resp.finish
    end    

end


# class Application

#     @@items = ["Apples","Carrots","Pears"]
#     @@cart = []
  
#     def call(env)
#       resp = Rack::Response.new
#       req = Rack::Request.new(env)
  
#       if req.path.match(/items/)
#         @@items.each do |item|
#           resp.write "#{item}\n"
#         end
#       elsif req.path.match(/search/)
#         search_term = req.params["q"]
#         resp.write handle_search(search_term)
#       elsif req.path.match(/cart/)
#         if @@cart[0] == nil
#           resp.write "Your cart is empty"
#         else
#           @@cart.each do |item|
#             resp.write "#{item}\n"
#           end
#         end
#       elsif req.path.match(/add/)
#         matcher = req.params["item"]
#         if @@items.include?(matcher)
#           @@cart << matcher
#           resp.write "added #{matcher}"
#         else
#           resp.write "We don't have that item"
#         end        
#       else
#         resp.write "Path Not Found"
#       end
  
#       resp.finish
#     end
  
#     def handle_search(search_term)
#       if @@items.include?(search_term)
#         return "#{search_term} is one of our items"
#       else
#         return "Couldn't find #{search_term}"
#       end
#     end
#   end