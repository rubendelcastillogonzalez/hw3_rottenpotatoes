# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|

  Movie.create(:title => movie[0] , :release_date => movie[1],
:rating => movie[2])
   
  end
 # flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

Given /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  listaRating=rating_list.split(', ')

listaRating.each do |field|
	if (uncheck=="un") 
	  uncheck("ratings_"+field)
	else 
	  check("ratings_"+field)
	end

	end 

end

When /^(?:|I )press "([^a+])"$/ do |button|
  click_button(button)
end
Then /^(?:|I )should see "\/([^\/]*)\/"$/ do |regexp|
  regexp = Regexp.new(regexp)

  if page.respond_to? :should
    page.should have_xpath('//*/<td>', :text => regexp)
  else
    assert page.has_xpath?('//*/<td>', :text => regexp)
  end
end
Then /^(?:|I )should not see "\/([^\/]*)\/"$/ do |regexp|
  regexp = Regexp.new(regexp)

  if page.respond_to? :should
    page.should have_no_xpath('//*', :text => regexp)
  else
    assert page.has_no_xpath?('//*', :text => regexp)
  end
end

Then /^the "([^"]*)" field(?: within (.*))? should contain "([^"]*)"$/ do |field, parent, value|
  with_scope(parent) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    if field_value.respond_to? :should
      field_value.should =~ /#{value}/
    else
      assert_match(/#{value}/, field_value)
    end
  end
end

Then /^(?:|I )should see (\d+) rows$/ do |nFilas|
  if page.respond_to? :should
     page.all('table#movies tr').count.should == Integer(nFilas)+1
    
  else
    page.all('table#movies tr').count.should == Integer(nFilas)+1
  end
end
Then /^I should see '(.*)' before '(.*)'$/ do |cadena1,cadena2|
  posCadena1=page.body.index(cadena1)
  posCadena2=page.body.index(cadena2)
  assert (posCadena1<posCadena2)
end
