那么(/^可以在(.*)中添加镜像，版本为(.*)$/) do |label,tag|

  image = "#{namespaces[label]}/test"
  expect{Registry.push image, tag}.not_to raise_error
end

那么(/^可以删除(.*)中前述镜像的(.*)版本$/) do |label,tag|
  image = "#{namespaces[label]}/test"
  visit "/#{image}/tags"
  csrf_key = page.at('meta[name="csrf-param"]')[:content]
  csrf_token = page.at('meta[name="csrf-token"]')[:content]
  agent.post("/#{image}/tags/#{tag}",
             {'_method' => 'delete',csrf_key => csrf_token},
             {'Content-Type' => 'application/x-www-form-urlencoded; charset=UTF-8'}
            )
end
