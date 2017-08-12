require './docs/takeaway.rb'

describe Takeaway do
  let(:menu) { double "menu" }

  context "#initialize" do
    it "basket is empty by default" do
      expect(subject.basket.size).to eq 0
    end
  end

  context "#header" do
    it "prints the main menu options" do
      message = "Welcome to the God of Cookery Takeaway.\n Choose an option\n1. See menu\n2. Choose dishes\n3. Basket\n4. Exit\n"
      expect { subject.header }.to output(message).to_stdout
    end
  end
  context "#show_menu" do
    it "prints the food menu" do
      expect(subject.show_menu).to respond_to(:display)
    end
  end
  
  context "#choose_dish" do
    it "selects a dish and puts it into the basket" do
      subject.choose_dish 1, 1
      expect(subject.basket.size).to eq 1
    end
    it "selects three dishes and puts it into the basket" do
      subject.choose_dish 1, 3
      expect(subject.basket.size).to eq 3
    end
    it "has a quantity of one by default if no input" do
      subject.choose_dish 2
      expect(subject.basket.size).to eq 1
    end
    it "invalid dish number chosen" do
      expect { subject.choose_dish 9, 1 }.to raise_error("Invalid choice")
    end
    it "negative dish number not allowed" do
      expect { subject.choose_dish 1, -3 }.to raise_error("Invalid choice")
    end
    it "negative quantity number not allowed" do
      expect { subject.choose_dish 1, -3 }.to raise_error("Invalid choice")
    end
  end

  context "#show_basket" do
    it "shows the contents of the basket" do
      subject.choose_dish 3, 2
      message = "Sorrowful Rice x 2\nTotal £244\n\n"
      expect { subject.show_basket }.to output(message).to_stdout
    end
    it "shows the quantity of the selected dishes" do
      subject.choose_dish 2, 4
      message = "Secret Roast Goose x 4\nTotal £2784\n\n"
      expect { subject.show_basket }.to output(message).to_stdout
    end
  end

  context "#tally" do
    it "shows the total price of the selected dishes" do
      subject.choose_dish 2, 2
      subject.choose_dish 5, 3
      expect(subject.tally).to eq 1878
    end
  end
end
