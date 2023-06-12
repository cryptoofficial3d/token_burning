pragma solidity ^0.8.10;

contract TOKEN_BURNING 
{
    /* 
    *- The function is called "_transfer" and is an internal virtual override, which means it can only be accessed within the contract and can be overridden by child contracts.
    *- The first three lines are require statements that check if the sender, recipient, and transfer amount are valid. If any of these checks fail, the function will revert.
    *- The if statement checks if the transfer amount is greater than or equal to 100. If it is, then the transfer will trigger a burn of 0.5% of the transfer amount, and the remaining amount will be transferred to the recipient. If the transfer amount is less than 100, then the full transfer amount will be transferred to the recipient.
    *- The burn amount is calculated by multiplying the transfer amount by 5 and then dividing by 1000. This results in a burn of 0.5% of the transfer amount.
    *- The _burn function is called to burn the calculated burn amount from the sender's balance.
    *- The _beforeTokenTransfer function is called before the transfer takes place, which allows for additional checks or actions to be taken.
    *- The sender's balance is decreased by the transfer amount (including the burn amount), and the recipient's balance is increased by the transfer amount (minus the burn amount).
    *- An event is emitted to indicate that the transfer has taken place.
    *- The _afterTokenTransfer function is called after the transfer takes place, which allows for additional checks or actions to be taken.
*/


        function _transfer(address sender, address recipient, uint256 amount) internal virtual  { 
            require(sender != address(0), "ERC20: transfer from the zero address");
            require(recipient != address(0), "ERC20: transfer to the zero address");
            require(amount > 0, "ERC20: transfer amount must be greater than zero");

            if (amount >= 100) {
            uint256 burnAmount = amount * 5 / 1000;  // 0.5% The token will be burned     // This percentage value can be variable
            uint256 transferAmount = amount - burnAmount;

            _burn(sender, burnAmount);
            _beforeTokenTransfer(sender, recipient, transferAmount);

            _balances[sender] -= amount;
            _balances[recipient] += transferAmount;

            emit Transfer(sender, recipient, transferAmount);

            _afterTokenTransfer(sender, recipient, transferAmount);
            } else {
            _beforeTokenTransfer(sender, recipient, amount);

            _balances[sender] -= amount;
            _balances[recipient] += amount;

            emit Transfer(sender, recipient, amount);

            _afterTokenTransfer(sender, recipient, amount); 
            }
            }
}