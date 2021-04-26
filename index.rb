$payroll_records = [ {EMPLOYEE_NUMBER: '0012345', EMPLOYEE_NAME: 'JOE SUDDS',
                    HOURLY_RATE: '$10.34', HOURS_WORKED: '45.50'},

                    {EMPLOYEE_NUMBER: '0023456', EMPLOYEE_NAME: 'SUSIE SAMPLE',
                     HOURLY_RATE: '$12.57', HOURS_WORKED: '40.00'},

                    {EMPLOYEE_NUMBER: '0034567', EMPLOYEE_NAME: 'FRDERICK FENDAHL',
                     HOURLY_RATE: '$9.75', HOURS_WORKED: '75.25'},

                    {EMPLOYEE_NUMBER: '0045678', EMPLOYEE_NAME: 'PENELOPE PENNEL',
                     HOURLY_RATE: '$20.98', HOURS_WORKED: '40.00'},

                    {EMPLOYEE_NUMBER: '0056789', EMPLOYEE_NAME: 'HELEN HIGHWATER',
                     HOURLY_RATE: '$8.35', HOURS_WORKED: '35.00'},

                    {EMPLOYEE_NUMBER: '0067890', EMPLOYEE_NAME: 'JAMES FRITZ',
                     HOURLY_RATE: '$21.00', HOURS_WORKED: '50.50'} ]
$overtime_pay = 0
$regular_pay = 0
$gross_pay = 0
$tax_withheld = 0
$net_pay = 0
$hourly_pay_rate = 0
$hours_worked = 0
$regular_pay_total = 0
$overtime_pay_total = 0
$gross_pay_total = 0
$tax_withheld_total = 0
$net_pay_total = 0

$employee_number = ''
$employee_name = ''

$line_width = 135
$count = 0

def round_number(number)
  i, f = number.to_s.split('.')
  number = [i, f[0..1]].join('.').to_f
end

def get_payroll_record(array)
  $employee_number =  array[$count][:EMPLOYEE_NUMBER]
  $employee_name =  array[$count][:EMPLOYEE_NAME]
   hourly_pay =  array[$count][:HOURLY_RATE].split('')
   hourly_pay.shift
  $hourly_pay_rate = hourly_pay.join.to_f
  $hours_worked =  array[$count][:HOURS_WORKED].to_f
end

def set_totals_to_zero
  $overtime_pay_total = 0
  $regular_pay_total = 0
  $gross_pay_total = 0
  $tax_withheld_total = 0
  $net_pay_total = 0
end

def print_line_of_totals
  puts ''
  print (' '*30)+('TOTALS')+(' '*35)
  print ("$#{$regular_pay_total}".center(11))+(' '*3)
  print ("$#{$overtime_pay_total}".center(12))+(' '*3)
  print ("$#{$gross_pay_total}".center(9))+(' '*3)
  print ("$#{$tax_withheld_total}".center(11))+(' '*3)
  puts  (' ')+("$#{$net_pay_total}".center(11))
end

def print_headings
  puts ''
  puts("YUMMY GROSSERY SUPPLY, INC.".center($line_width))
  puts("WEEKLY PAYROLL REPORT".center($line_width))
  puts ''
  puts ''
  puts("  EMPLOYEE NUMBER      EMPLOYEE NAME      HOURLY RATE   HOURS WORKED  REGULAR PAY   OVERTIME PAY   GROSS PAY   TAX WITHHELD     NET PAY")
  puts ''
end

def process_payroll_records
  while $count <= $payroll_records.length-1
    compute_net_pay()
    print_line_of_report()
    accumulate_totals()
   $count += 1
    get_payroll_record($payroll_records) unless $count == $payroll_records.length
  end
end

def print_line_of_report
  print +(' '*2)+("#{$employee_number}".center(15))+(' '*3)
  print ("#{$employee_name}".ljust(19))+(' '*3)
  print ("$#{$hourly_pay_rate}".center(11))+(' '*3)
  print ("#{$hours_worked}".center(12))+(' '*3)
  print ("$#{$regular_pay}".center(11))+(' '*3)
  print ("$#{$overtime_pay}".center(12))+(' '*3)
  print ("$#{$gross_pay}".center(9))+(' '*3)
  print ("$#{$tax_withheld}".center(11))+(' '*3)
  puts  ("$#{$net_pay}".center(11))
end

def compute_net_pay
  compute_gross_pay()
  compute_tax_withheld()
  net_pay = $gross_pay - $tax_withheld
 $net_pay = round_number(net_pay)
end

def accumulate_totals
   regular_pay_total = $regular_pay_total + $regular_pay
  $regular_pay_total = round_number(regular_pay_total)
   overtime_pay_total = $overtime_pay_total + $overtime_pay
  $overtime_pay_total = round_number(overtime_pay_total)
   gross_pay_total = $gross_pay_total + $gross_pay
  $gross_pay_total = round_number(gross_pay_total)
   tax_withheld_total = $tax_withheld_total + $tax_withheld
  $tax_withheld_total = round_number(tax_withheld_total)
   net_pay_total = $net_pay_total + $net_pay
  $net_pay_total = round_number(net_pay_total)
end

def compute_gross_pay
  if $hours_worked >= 40
    $regular_pay = $hourly_pay_rate * 40
     overtime_pay = ($hours_worked - 40) * (1.5 * $hourly_pay_rate)
    $overtime_pay = round_number(overtime_pay)
     gross_pay = $regular_pay + overtime_pay
    $gross_pay = round_number(gross_pay)
  else
    $regular_pay = $hours_worked * $hourly_pay_rate
    $overtime_pay = 0
     gross_pay = $regular_pay
    $gross_pay = round_number(gross_pay)
  end
end

def compute_tax_withheld
  tax_withheld = $gross_pay * 0.15
 $tax_withheld = round_number(tax_withheld)
end

#Initialisation
set_totals_to_zero()
print_headings()
get_payroll_record($payroll_records)

#Proccessing loop
process_payroll_records()

#Termination
print_line_of_totals()
