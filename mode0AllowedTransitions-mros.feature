@fixture.crioOk
@fixture.testMode0
Feature: ECPC_STATE changes according to supervisor command when ECPC Test Mode is 0 (mrs)

  Scenario Outline: ECPC_FC goes from <state_1> to <state_2> when Supervisor sends <command>
    Given ECPC_FC is in APP_STATE "<state_1>"
    When ALL sends SUP_COMMAND equal to "<command>"
    Then FC_DIAGN sets APP_STATE to "<state_2>" before "3" seconds

  Examples: IDLE_STABLE Transitions
    | state_1                 | command             | state_2                 |
    | ECPC_IDLE_ERROR         | ECPC_GOTO_IDLE      | ECPC_IDLE_STABLE        |
    | ECPC_IDLE_STABLE        | ECPC_GOTO_PROT_CONF | ECPC_PROT_CONF_PROGRESS |
    | ECPC_IDLE_STABLE        | ECPC_GOTO_STANDBY   | ECPC_STANDBY_STABLE     |
    | ECPC_IDLE_STABLE        | ECPC_GOTO_ERROR     | ECPC_IDLE_ERROR         |
    | ECPC_PROT_CONF_ERROR    | ECPC_GOTO_PROT_CONF | ECPC_PROT_CONF_PROGRESS |
    | ECPC_PROT_CONF_PROGRESS | ECPC_GOTO_ERROR     | ECPC_PROT_CONF_ERROR    |
    | ECPC_PROT_CONF_STABLE   | ECPC_GOTO_ERROR     | ECPC_PROT_CONF_ERROR    |
    | ECPC_STANDBY_ERROR      | ECPC_GOTO_IDLE      | ECPC_IDLE_STABLE        |
    | ECPC_STANDBY_ERROR      | ECPC_GOTO_STANDBY   | ECPC_STANDBY_STABLE     |
    | ECPC_STANDBY_STABLE     | ECPC_GOTO_IDLE      | ECPC_IDLE_STABLE        |
    | ECPC_STANDBY_STABLE     | ECPC_GOTO_READY     | ECPC_READY_STABLE       |
    | ECPC_STANDBY_STABLE     | ECPC_GOTO_ERROR     | ECPC_STANDBY_ERROR      |
    | ECPC_READY_ERROR        | ECPC_GOTO_STANDBY   | ECPC_STANDBY_STABLE     |
    | ECPC_READY_ERROR        | ECPC_GOTO_READY     | ECPC_READY_STABLE       |
    | ECPC_READY_STABLE       | ECPC_GOTO_STANDBY   | ECPC_STANDBY_STABLE     |
    | ECPC_READY_STABLE       | ECPC_GOTO_ERROR     | ECPC_READY_ERROR        |
    | ECPC_READY_STABLE       | ECPC_GOTO_ONLINE    | ECPC_ONLINE_STABLE      |
    | ECPC_ONLINE_ERROR       | ECPC_GOTO_READY     | ECPC_READY_STABLE       |
    | ECPC_ONLINE_ERROR       | ECPC_GOTO_ONLINE    | ECPC_ONLINE_STABLE      |
    | ECPC_ONLINE_STABLE      | ECPC_GOTO_READY     | ECPC_READY_STABLE       |
    | ECPC_ONLINE_STABLE      | ECPC_GOTO_ERROR     | ECPC_ONLINE_ERROR       |

  Scenario Outline: ECPC_FC goes from <state_1> to <state_2> when PLC_STATE cmd is "ECPC_PLC_CONFIGURED"
    Given ECPC_FC is in APP_STATE <state_1>
    When PLC_SIM sends PLC_STATE equal to "ECPC_PLC_PROT_CONF"
    Then FC_DIAGN sets APP_STATE to <state_2> before "3" seconds

  Examples: IDLE_STABLE Transitions
    | state_1                 | state_2               |
    | ECPC_PROT_CONF_PROGRESS | ECPC_PROT_CONF_STABLE |
    | ECPC_PROT_CONF_STABLE   | ECPC_IDLE_STABLE      |
