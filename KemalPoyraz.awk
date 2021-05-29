#!/bin/awk -f

BEGIN { FS=","
	numberSold = 0
	numberOfOrders = 0
	"date +%Y-%m-%d" | getline time
	currentYear = substr(time,1,4)
	numberOfItems = 0
}
{
	totalPrice = $3 * $4
	print totalPrice
	
	averagePrice += totalPrice
	{ if ($2 ~/juice/)
		numberSold = numberSold + $3
	}
	
	year = substr($5,1,4)
	{ if ((currentYear-1)==year)
		numberOfOrders = numberOfOrders + 1
	}
	
	orderYear = substr($5,1,4) * 360
	orderMonth = substr($5,6,7) * 30
	orderDay = substr($5,9,10)
	orderDate = orderYear + orderMonth + orderDay
	arrivalYear = substr($6,1,4) * 360
	arrivalMonth = substr($6,6,7) * 30
	arrivalDay = substr($6,9,10)
	arrivalDate = arrivalYear + arrivalMonth + arrivalDay
	{ if (arrivalDate - orderDate <= 5)
		numberOfItems = numberOfItems + 1
	}
}
	
END {
	print averagePrice / NR
	print numberSold
	print numberOfOrders
	print numberOfItems
}
