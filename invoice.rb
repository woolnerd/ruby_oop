class Invoice

  WORKERS = [
    {
      email: 'bob@gmail',
      trades: ['cement'],
      cost: 80
    },
    {
    email: 'alice@gmail',
    trades: ['plumbing'],
    cost: 90
    },
    {
      email: 'ted@gmail',
      trades: %w[cement bricklaying],
      cost: 75
    }
  ]

  #find workers who have the trade

  def workers_with_trade(trade)
    WORKERS.filter { |worker| worker[:trades].include?(trade) }
  end

  def get_emails(workers)
    workers.map { |worker| worker[:email] }
  end

  def get_cheapest_worker(workers)
    workers.min { |a,b| a[:cost] <=> b[:cost] }
  end

  def schedule_workers(trades)
    worker_emails = trades.map { |trade| {"#{trade}" => get_emails( workers_with_trade(trade) )} }
    sort_emails(worker_emails)
  end

  def cheapest_workers_with_trade(trades)
    worker_emails = get_emails(trades.map { |trade| get_cheapest_worker(workers_with_trade(trade)) })
    sort_emails(worker_emails)
  end

  def sort_emails(emails)
    emails.sort { |a,b| a <=> b }
  end

  attr_reader :date, :product, :cost
  def initialize(date, product, cost)
    @date = date
    @product = product
    @cost = cost
  end

  def hello
    puts 'hello'
  end
end

i = Invoice.new(Time.now, 'test', 30)

p i.schedule_workers(['cement'])
p i.cheapest_workers_with_trade(['cement', 'plumbing'])



