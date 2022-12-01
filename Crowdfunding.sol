pragma solidity 0.8.3;

contract SolidityFundamentals2 {
    enum State {
        IN_PROGRESS,
        ENDED
    }

    address payable public owner;
    State public currentState;

    constructor() {
        owner = payable(msg.sender);
    }

    function donate() external payable stillInProgress {}

    function checkAmountCollected()
        public
        view
        stillInProgress
        returns (uint256)
    {
        return address(this).balance;
    }

    function withdraw() external {
        require(msg.sender == owner, "only the owner can withdraw");
        owner.transfer(address(this).balance);
        currentState = State.ENDED;
    }

    modifier stillInProgress() {
        require(
            currentState == State.IN_PROGRESS,
            "donation phase is no longer in progress"
        );
        _;
    }
}
