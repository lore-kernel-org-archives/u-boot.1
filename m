Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7099C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 05:38:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06AC987B5F;
	Fri, 19 Jan 2024 06:38:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B5znY4vi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EC2C87BAF; Fri, 19 Jan 2024 06:38:43 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 384B78644E
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 06:38:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYzBTuxTCLTp/hi9hchLJe3HHWpDictpK7JLzQRqRcmQbKhUApcvIHXQdlJEiswrmCUuAQwAPoCwX1sqsTkUVSxkZAbQ5szglvV174kyYz8UzrCOEycFJXJOFdhgxIvuNCw0yp/K3B4gPvHcD1g4ubAzkrwo1Ox4C80MeyFv9CqZbRdVuaXR12WEctPRez0eKrD1YgiB/0ZlnkvF0BCPSBNHUDBS8zE4iqTSXGPd3QNwYQ0C5tP0PBKXXMzo3FE7bHUDNDjehtj23CyIHMVODIU+iefxcMlB4XYqsYiXDUnsYNF/7H2v4hmd3XP08oMboYRX9By3sCsHE8aNEt/6lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHm36mRM8tqD+alBJ3p1xe7+fenYn1oM3KFR+eCrGpg=;
 b=MG/u8J7T5n9xYA06Wje9uRBrJbCnYVpCNPHWlPR1lHvxu7pACq48aPF+eI5hiQRRpfHrzy8Y7aCSGizGcgivlZCzLLpwMGTszeeuMdfmhTqyZH6uhBmxe0O6umC+n9W8j+83SOPNDS8j3zF2KuAnrJzkX2uXSMUi/eBL4TLryZUizqv0G3v1mu9vXLloYISTKcupiAYPtb649m8vsijYfco1PUtmntrAPKdmlsaTrTB6blxEYaLujlsi1xt5SZgLBL8E/a7NY99SRm2hwhW5JgkcHuwtozi4FAMpNgXi+BTpYtgktZM4GK2lCQAO/jR2oPEayTxD23Rraz9Cmnr5Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHm36mRM8tqD+alBJ3p1xe7+fenYn1oM3KFR+eCrGpg=;
 b=B5znY4vixPymJbsOR8js288odZyqpPTiPgIPTKae3BHnU9nrkQF7d00nOF23fb1/epWv2CtWSZIMmIHyD+wLtI8H5/ra0f+kL9u4mWVGlYk0IsC8kvDn87OJt/anU0MMVvXRPB2KHkpWDY4BTlkudJEnWsik1vkw/Jvev4tsUf4=
Received: from CY5PR15CA0246.namprd15.prod.outlook.com (2603:10b6:930:66::19)
 by BN9PR12MB5130.namprd12.prod.outlook.com (2603:10b6:408:137::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 05:38:38 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:930:66:cafe::62) by CY5PR15CA0246.outlook.office365.com
 (2603:10b6:930:66::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Fri, 19 Jan 2024 05:38:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Fri, 19 Jan 2024 05:38:37 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 23:38:36 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 18 Jan
 2024 21:38:36 -0800
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 18 Jan 2024 23:38:35 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] test/py: gpio: Add gpio pins generic test
Date: Fri, 19 Jan 2024 11:08:34 +0530
Message-ID: <b68d58b3a80a9b2a7082f5d1be4ebe07934cc6c5.1705639865.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|BN9PR12MB5130:EE_
X-MS-Office365-Filtering-Correlation-Id: 700b8522-f9b0-4f6b-15cf-08dc18b0e2a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RxsJJxU40KI9ZX0TtTZ1Agob0vqJGfJySs5Nzj6S0+BPo3NxW9wUWbxOntkJwQPszqhx2rshMJSkYqLedZSQEgRAy4vZOj/hQdzkNqDaXph5PneW9HLoaElwjz5B/1/EOXbOjDyHKR7MY1/zL66hOd5ACx9InV20dOaPrTH5R+TmxqsmT2kZ5Za8yA1IykgYkq+MUIdBAIs43xsLfuYCMF1IN4wlGkCjoGTOkFRs4yLJZNHncXUiRraX9CwpLecsTd2RZGTiMoUsZrr49gPbxe9derCAylSU5qD661GHvXJL0h4GMf/3IV3rzad4OkzZrcgNCO7N2GeBaIj+JoWnBQCLSdkJNTacoLHouglKdwnyCoFdvR8MHhmPkaWeHi4HAFkPnbd9s09hiZxqP8L2jGDEBqRPXCLKqR9rbs0wins4pZrwqKlxslSoc2dlehHGVLZUoVb7JIIgkPQ8HrF1vp4UyQ/YrlAC6hYh8U/7xKgrKmMb+bc1pZ+L+vG1QzSD2WSpo3X0anEaERHNymhKTmD2Tcxc0JDfiaCX9EJS1tBrYjfsVX4ScNKB7G7+Z/1ueo/uTGcE9ZU/BylnRLUE84CWGkPpSYFQotqNGZTfDCiViYuob9wHye1w6ZyRjiPttFNOkCGvgX+ZMSUwJIpNgesPPdgLtscIpoE4++tW1SdvFAeruHI2hafNshAwzbdqWN08S8wWMWNU40qWVSgh42rplWWj1UJGr7jBJ0Mqgermt2+fqbETlXO+X6Fvz8THBNsjRzSnEEe7KGmC7Caw9P45+efd9dz8x92z92Uqbok=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(4326008)(8936002)(426003)(5660300002)(336012)(8676002)(47076005)(6916009)(316002)(54906003)(70206006)(70586007)(478600001)(44832011)(107886003)(2616005)(26005)(81166007)(356005)(82740400003)(2906002)(36756003)(41300700001)(86362001)(36860700001)(41533002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 05:38:37.4520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 700b8522-f9b0-4f6b-15cf-08dc18b0e2a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5130
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Add gpio pins generic test for the set of gpio pin list to test various
gpio related functionality, such as the input, set, clear, and toggle,
it also tests the input and output functionality for shorted gpio pins.
This test depends on boardenv* configuration to define gpio pins names.

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
 test/py/tests/test_gpio.py | 90 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/test/py/tests/test_gpio.py b/test/py/tests/test_gpio.py
index 0af186f23602..3e16e6365743 100644
--- a/test/py/tests/test_gpio.py
+++ b/test/py/tests/test_gpio.py
@@ -85,6 +85,13 @@ env__gpio_dev_config = {
         'gpio_ip_pin_clear':'66',
         'gpio_clear_value': 'value is 0',
         'gpio_set_value': 'value is 1',
+        # GPIO pin list to test gpio functionality for each pins, pin should be
+        # pin names (str)
+        'gpio_pin_list': ['gpio@1000031', 'gpio@1000032', 'gpio@20000033'],
+        # GPIO input output list for shorted gpio pins to test gpio
+        # functionality for each of pairs, where the first element is
+        # configured as input and second as output
+        'gpio_ip_op_list': [['gpio0', 'gpio1'], ['gpio2', 'gpio3']],
 }
 """
 
@@ -223,3 +230,86 @@ def test_gpio_input_generic(u_boot_console):
     response = u_boot_console.run_command(cmd)
     good_response = gpio_set_value
     assert good_response in response
+
+@pytest.mark.buildconfigspec('cmd_gpio')
+def test_gpio_pins_generic(u_boot_console):
+    """Test various gpio related functionality, such as the input, set, clear,
+       and toggle for the set of gpio pin list.
+
+       Specific set of gpio pins (by mentioning gpio pin name) configured as
+       input (mentioned as 'gpio_pin_list') to be tested for multiple gpio
+       commands.
+    """
+
+    f = u_boot_console.config.env.get('env__gpio_dev_config', False)
+    if not f:
+        pytest.skip('gpio not configured')
+
+    gpio_pins = f.get('gpio_pin_list', None)
+    if not gpio_pins:
+        pytest.skip('gpio pin list are not configured')
+
+    for gpin in gpio_pins:
+        # gpio input
+        u_boot_console.run_command(f'gpio input {gpin}')
+        expected_response = f'{gpin}: input:'
+        response = u_boot_console.run_command(f'gpio status -a {gpin}')
+        assert expected_response in response
+
+        # gpio set
+        u_boot_console.run_command(f'gpio set {gpin}')
+        expected_response = f'{gpin}: output: 1'
+        response = u_boot_console.run_command(f'gpio status -a {gpin}')
+        assert expected_response in response
+
+        # gpio clear
+        u_boot_console.run_command(f'gpio clear {gpin}')
+        expected_response = f'{gpin}: output: 0'
+        response = u_boot_console.run_command(f'gpio status -a {gpin}')
+        assert expected_response in response
+
+        # gpio toggle
+        u_boot_console.run_command(f'gpio toggle {gpin}')
+        expected_response = f'{gpin}: output: 1'
+        response = u_boot_console.run_command(f'gpio status -a {gpin}')
+        assert expected_response in response
+
+@pytest.mark.buildconfigspec('cmd_gpio')
+def test_gpio_pins_input_output_generic(u_boot_console):
+    """Test gpio related functionality such as input and output for the list of
+       shorted gpio pins provided as a pair of input and output pins. This test
+       will fail, if the gpio pins are not shorted properly.
+
+       Specific set of shorted gpio pins (by mentioning gpio pin name)
+       configured as input and output (mentioned as 'gpio_ip_op_list') as a
+       pair to be tested for gpio input output case.
+    """
+
+    f = u_boot_console.config.env.get('env__gpio_dev_config', False)
+    if not f:
+        pytest.skip('gpio not configured')
+
+    gpio_pins = f.get('gpio_ip_op_list', None)
+    if not gpio_pins:
+        pytest.skip('gpio pin list for input and output are not configured')
+
+    for gpins in gpio_pins:
+        u_boot_console.run_command(f'gpio input {gpins[0]}')
+        expected_response = f'{gpins[0]}: input:'
+        response = u_boot_console.run_command(f'gpio status -a {gpins[0]}')
+        assert expected_response in response
+
+        u_boot_console.run_command(f'gpio set {gpins[1]}')
+        expected_response = f'{gpins[1]}: output:'
+        response = u_boot_console.run_command(f'gpio status -a {gpins[1]}')
+        assert expected_response in response
+
+        u_boot_console.run_command(f'gpio clear {gpins[1]}')
+        expected_response = f'{gpins[0]}: input: 0'
+        response = u_boot_console.run_command(f'gpio status -a {gpins[0]}')
+        assert expected_response in response
+
+        u_boot_console.run_command(f'gpio set {gpins[1]}')
+        expected_response = f'{gpins[0]}: input: 1'
+        response = u_boot_console.run_command(f'gpio status -a {gpins[0]}')
+        assert expected_response in response
-- 
2.25.1

