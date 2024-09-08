// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

//====== Importação do Foundry
import {Test, console2} from "forge-std/Test.sol";

//====== Importações do Chainlink Local
import {IRouterClient, WETH9, LinkToken, BurnMintERC677Helper} from "@chainlink/local/src/ccip/CCIPLocalSimulator.sol";
import {CCIPLocalSimulator} from "@chainlink/local/src/ccip/CCIPLocalSimulator.sol";

//====== O(s) Contrato(s) à ser(em) testado(s)
import {DefensiveExample} from "../src/DefensiveExample.sol";

contract DefensiveExampleTest is Test {
    //======= Instância o CCIPLocalSimulator & Cria variáveis de teste
    CCIPLocalSimulator public s_ccipLocalSimulator;
    //======= Instância o Contrato a ser testado
    DefensiveExample public s_defense;

    //======= Declara as variáveis do CCIPLocal para ter acesso global
    uint64 public s_chainSelector;
    IRouterClient public s_sourceRouter;
    IRouterClient public s_destinationRouter;
    WETH9 public s_wrappedNative;
    LinkToken public s_linkToken;
    BurnMintERC677Helper public s_ccipBnM;
    BurnMintERC677Helper public s_ccipLnM;

    //======= Cria variáveis para testes
    address s_receiver = makeAddr("receiver");
    uint256 s_amount = 10*10**18;

    //======= Função padrão do ambiente de testes
    function setUp() public {
        //====== Deploy dos contratos
        s_ccipLocalSimulator = new CCIPLocalSimulator();

        //====== Recupera valor das variáveis
        (
            s_chainSelector,
            s_sourceRouter,
            s_destinationRouter,
            s_wrappedNative,
            s_linkToken,
            s_ccipBnM,
            s_ccipLnM
        ) = s_ccipLocalSimulator.configuration();

        //======= Solicita Link do faucet
        s_ccipLocalSimulator.requestLinkFromFaucet(s_receiver, s_amount);
    }
}
