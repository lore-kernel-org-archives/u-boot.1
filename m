Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37C0C61D92
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 13:03:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8551875C5;
	Tue, 21 Nov 2023 14:03:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iHtEqnBZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C4BC875C7; Tue, 21 Nov 2023 14:03:02 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::622])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01A8287545
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 14:02:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCFrPxwdjdnKEF3pUbfJJcJUPdHPAwA61SnL3cMYFdUmy1Vj6Sinrc2jNUqRK/WRuCVCgI6VM6pnUenXCZI4VLA8J6mx53TRgUBFVashTrb/Y4OCZAQh6jXanwjnROTAs3cKls+IOAhXlifaidwGbAEOEMSbIbvWXXDOfD3EToIOAT/d51rrxXPEQIlRAzWhxOe1oLNfvPHz/d4Azq1iIVbCwOi5dc5EqgtOEREBrVvICRpDq2PuVuB6My1B14uv2m2BtpLOuQbWqpsp4Pfd6OgUQbO400JuVAI52pUALkhy07d22OGWYszXIfLqE2nS/bKVzdkmSBEdTYaIBZ8vKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pzoz0jCwhjimETYB4GAh+cxGXwwrFcnLuT+fu9T/Vg=;
 b=kbhSrsLuFfl/kbA+xEIMPPMNpZyKacz2/h1CkGXGPSvEJrgAZlK3bn63DKj7pZRLmtOVcsHlfFg6zLhsi+AOA/M0aAq49NzhdG69ApwCSvVE/Pw1cZJBnm8ip4xSPqFfL+dGbCJWgcAtjMNiSrEx5a2A04YR79l/Y65valnadp/JqyF7KFfdnnM5t0GvHC6ZGro5V75mVHDEotxZNMjfUrJh/h2PoPEYUUebcDN7x3KWIfKHbAUtnrlVs/l+nzB2og3S040k8Sf+eNGq2IVNAJ1PuOlQ5SgvvrxA1UpqYoF+fUbmZOKFaMlIviXGHdVnpYHc+H3giMhLk7mqQezvbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pzoz0jCwhjimETYB4GAh+cxGXwwrFcnLuT+fu9T/Vg=;
 b=iHtEqnBZbJGd/uUgI3paOt1oGy9c8RJFAz/jnVS0j4rqx0AbynqLi0P+SY1TJckRFlO16UmsiSOMjmpJcGekXdUTJ1wBYK4myYLJHiYVEPoyjaS6o/Lr6EljOTqx7NzI19ZLPhLnxfcpRpyuCu9qlcVafzUu9xizWKqcYOaHXvc=
Received: from SN7PR04CA0086.namprd04.prod.outlook.com (2603:10b6:806:121::31)
 by CH0PR12MB5025.namprd12.prod.outlook.com (2603:10b6:610:d5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 13:02:56 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:121:cafe::b7) by SN7PR04CA0086.outlook.office365.com
 (2603:10b6:806:121::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Tue, 21 Nov 2023 13:02:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 13:02:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 07:02:55 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 21 Nov 2023 07:02:53 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>, <rfried.dev@gmail.com>,
 <v.v.mitrofanov@yadro.com>, <seanedmond@microsoft.com>,
 <emohandesi@linux.microsoft.com>
Subject: [UBOOT PATCH v4] test/py: net: Add dhcp abort test
Date: Tue, 21 Nov 2023 18:32:47 +0530
Message-ID: <dd44fc9bf39e0debc9d0bc78a5d9215bace26023.1700571693.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|CH0PR12MB5025:EE_
X-MS-Office365-Filtering-Correlation-Id: f78658be-421d-4c2d-5fb7-08dbea922dfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BzOp4PK5Ia+06mb7Xelv4gyNBjEMkkUhYnU4VjD56Bhrv3KLmFTE7CUYb4+nTjMlS4OZgH+8Pvvu2syht2ay7MpFu+mt0FZpyv2VSrZEEDSVMlaG3lhIfljMJlqir+3co3dmSS0MHMg6ZLQujmjdhPphrozITRBn7dN/+fS4JFdpe4sa2zhFYMWQA8JIi0K4g14v8P/vdiMewFyaXdIIPvvsN4vXjBPaAzZEknQFmD/4i3XO2E+TIe/m+Gyt5sXViL5/5o4IZEPiQHuc7LvTcXxK+ysfZEckQ4rOm9SyjekJdL7o3v89ivCh6sveg8OqoiCFqo6NVWBTtjyfaapM6Un2oqN9oGKKNIFISpCUuaW74RcQirsnYUGhhvpp7AHiGrDylV26eJzaLuN8ipax5gC2HjbNAQ2G10I+PPD0N3pybEhj9pu6PvVhz4PYM71M+4jUH0WhitqC5oIuIrnYypm8EI0VNkxBckN4qXQoJoex+KEDLmPApsOaoekH3oWN1Kw9qj4zfqEOSWnfA0cAEu1AY8xebicrL/eceq/wdMhp6u6CZ8N6CkdlUVI87ZH5sjupvpu3e+VQKncYJng1fWHgIPY/nYnaRBrmI7R3h25a87QLdRl4M5o/iSwHpcbBZqgcw0NW7kqFnYTnsYB25TQzg17I0WdeWmZg/ihuqU1AJPI6xev0Lw5pgpq3mRb+PoB+oFtcx7j0f+qmlFfoTuDpk8ODoDzFJGDyXnLPIhwfiOd9G+b/5oUKNE6sg3Ea3PEJHZ3q0Bch436oGRdhwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799012)(36840700001)(46966006)(40470700004)(26005)(41300700001)(36756003)(86362001)(5660300002)(2906002)(44832011)(40460700003)(40480700001)(36860700001)(478600001)(6666004)(83380400001)(47076005)(356005)(81166007)(8936002)(4326008)(8676002)(316002)(82740400003)(6916009)(70586007)(70206006)(54906003)(426003)(336012)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 13:02:56.0071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f78658be-421d-4c2d-5fb7-08dbea922dfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5025
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

Abort the dhcp request in the middle by pressing ctrl + c on u-boot
prompt and validate the abort status.

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
Changes in v2:
 - Mark CMD_MII command dependency

Changes in v3:
 - Skip the test if PHY device not present

Changes in v4:
 - Setup the network configuration by running dhcp test at the end of
 test
 - Add option to skip the test if it is not desired or possible
---
 test/py/tests/test_net.py | 57 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
index b2241ae6a482..e0749125fd53 100644
--- a/test/py/tests/test_net.py
+++ b/test/py/tests/test_net.py
@@ -7,6 +7,7 @@
 import pytest
 import u_boot_utils
 import uuid
+import re
 
 """
 Note: This test relies on boardenv_* containing configuration values to define
@@ -30,6 +31,11 @@ env__net_uses_pci = True
 # set to False.
 env__net_dhcp_server = True
 
+# False or omitted if a DHCP server is attached to the network, and dhcp abort
+# case should be tested.
+# If DHCP abort testing is not possible or desired, set this variable to True.
+env__dhcp_abort_test_skip = True
+
 # True if a DHCPv6 server is attached to the network, and should be tested.
 # If DHCPv6 testing is not possible or desired, this variable may be omitted or
 # set to False.
@@ -115,6 +121,57 @@ def test_net_dhcp(u_boot_console):
     global net_set_up
     net_set_up = True
 
+@pytest.mark.buildconfigspec("cmd_dhcp")
+@pytest.mark.buildconfigspec("cmd_mii")
+def test_net_dhcp_abort(u_boot_console):
+    """Test the dhcp command by pressing ctrl+c in the middle of dhcp request
+
+    The boardenv_* file may be used to enable/disable this test; see the
+    comment at the beginning of this file.
+    """
+
+    test_dhcp = u_boot_console.config.env.get("env__net_dhcp_server", False)
+    if not test_dhcp:
+        pytest.skip("No DHCP server available")
+
+    if u_boot_console.config.env.get("env__dhcp_abort_test_skip", False):
+        pytest.skip("DHCP abort test is not enabled!")
+
+    u_boot_console.run_command("setenv autoload no")
+
+    # Phy reset before running dhcp command
+    output = u_boot_console.run_command("mii device")
+    if not re.search(r"Current device: '(.+?)'", output):
+        pytest.skip("PHY device does not exist!")
+    eth_num = re.search(r"Current device: '(.+?)'", output).groups()[0]
+    u_boot_console.run_command(f"mii device {eth_num}")
+    output = u_boot_console.run_command("mii info")
+    eth_addr = hex(int(re.search(r"PHY (.+?):", output).groups()[0], 16))
+    u_boot_console.run_command(f"mii modify {eth_addr} 0 0x8000 0x8000")
+
+    u_boot_console.run_command("dhcp", wait_for_prompt=False)
+    try:
+        u_boot_console.wait_for("Waiting for PHY auto negotiation to complete")
+    except:
+        pytest.skip("Timeout waiting for PHY auto negotiation to complete")
+
+    u_boot_console.wait_for("done")
+
+    # Sending Ctrl-C
+    output = u_boot_console.run_command(
+        chr(3), wait_for_echo=False, send_nl=False
+    )
+
+    assert "TIMEOUT" not in output
+    assert "DHCP client bound to address " not in output
+    assert "Abort" in output
+
+    # Provide a time to recover from Abort - if it is not performed
+    # There is message like: ethernet@ff0e0000: No link.
+    u_boot_console.run_command("sleep 1")
+    # Run the dhcp test to setup the network configuration
+    test_net_dhcp(u_boot_console)
+
 @pytest.mark.buildconfigspec('cmd_dhcp6')
 def test_net_dhcp6(u_boot_console):
     """Test the dhcp6 command.
-- 
2.25.1

