import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteTransaction;
  final currency;

  TransactionList(this._transactions, this._deleteTransaction, this.currency);

  get currencyIcon {
    if (currency == 'USD') {
      return '\$';
    } else if (currency == 'INR') {
      return 'Rs.';
    }
  }

  List<DateTime> get transactionDates {
    return List.generate(
        _transactions.length, (index) => _transactions[index].date);
  }

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: constraints.maxHeight * 0.3,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 10,
                ),
                child: ListTile(
                  leading: Container(
                    height: 45,
                    width: 80,
                    // radius: 35,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: FittedBox(
                        child: Text(
                          currency == 'USD'
                              ? '$currencyIcon${_transactions[index].amount.toStringAsFixed(2)}'
                              : '$currencyIcon${_transactions[index].amount.toStringAsFixed(0)}',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    _transactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(_transactions[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? FlatButton.icon(
                          onPressed: () {
                            _deleteTransaction(_transactions[index].id);
                          },
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                          textColor: Theme.of(context).errorColor,
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.delete,
                          ),
                          color: Theme.of(context).errorColor,
                          onPressed: () {
                            _deleteTransaction(_transactions[index].id);
                          },
                        ),
                ),
              );
            },
            itemCount: _transactions.length,
          );
  }
}
