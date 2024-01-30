Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21EBC46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 08:07:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4572586DD2;
	Tue, 30 Jan 2024 09:07:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dLt3Asth";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 778E486EA6; Tue, 30 Jan 2024 09:07:28 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2F2E86D38
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 09:07:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exo4ddHHOXZQHMEORsGozuC0vzZHoI11lE1bi2HWxzHBvHHQATP8AmATXiUEGqYqcoqiWpg3ry1uBqA3kDgGPD9utcfIVV2AH8o+154cwXpUoe6aPyUCJigMjbI9c8/bPFGqSnrfHrB25XWYp+uDJzltCMUCbx97LWcQ61AI9lQtj7W5cNBw6sQ/42KTXCpvwPo1QT8sdHGJ3FWnD5RWcVV5apc7b5Edm4O/9HAX7Ew/JsRoEI46dSsrgBQtogjqH+JNwoHaAcoXevuKxvrWGw1y7+DnErJvHEeH+g5YWrfQFury9aT31pDo0lSel/aEkqWvH/ISdxK/Vzpen1+ZrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHWibb/MKB8Zm1Bd/q0Q/lmFebwBaLnKnNcWf8lbDbA=;
 b=iESOPgpeyfisBZYJ9tOZTRDxOMqNhTSe6loCLlTFKWZZPmuXa46ZxXU+mNbPv6/u+8KgmlZj1rztqVtX9kQm74TgfoAdGEF19LxAgho3FnA3bZMJWWrFOufYBjPpQGdSGO90bq6QOE5iJ9qp/oiR9oZyMxVjIcgTh6N4xQgNPbbGcVkRDBy1X+TL4SN2xIPG8rcRBkOjnASXsEH/YAGVqzfQMOufu5Ndt6fyfrpSBUCF7YQ5Equ6pml58JGT93Oh1WUGYh7U1HbpdWhCWopCT7AmWSkodFIsIuwaTpgvCfByiX9SRz81sEMZ46aG47d+ZRBVL/c8+NwjjIdewEd/+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHWibb/MKB8Zm1Bd/q0Q/lmFebwBaLnKnNcWf8lbDbA=;
 b=dLt3AsthVTbCb/jAEjsf9D6Y21TCyg7YOCPbz1s6tuPJkSCP1m+rRGnweTQPKicz45g4F79ttEeBMKf7/wXkRYAsOB6qJdvpZ63VlocrqTjw5y14ucqYKEw5boeptcZRDNy5Jp6setFuj2JytivWX1lcYU+sartbQkS2fdfzUc0=
Received: from CY5PR15CA0111.namprd15.prod.outlook.com (2603:10b6:930:7::25)
 by BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 08:07:18 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:7:cafe::ca) by CY5PR15CA0111.outlook.office365.com
 (2603:10b6:930:7::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 08:07:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 08:07:17 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 30 Jan
 2024 02:07:12 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 30 Jan
 2024 02:07:04 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 30 Jan 2024 02:07:02 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>, <rfried.dev@gmail.com>,
 <v.v.mitrofanov@yadro.com>, <seanedmond@microsoft.com>,
 <emohandesi@linux.microsoft.com>, <neil.armstrong@linaro.org>
Subject: [PATCH v5] test/py: net: Add dhcp abort test
Date: Tue, 30 Jan 2024 13:37:01 +0530
Message-ID: <e603fb51b11cb4c29470a44d4276ace356ce7ddd.1706599828.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|BL1PR12MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a7641d-2c4a-4b3f-50fd-08dc216a7a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QOkDd6UTKkDHdmpKiEKWdapwd+KZs1RCW8/jOBEH0nvo5VT6nLYZtlPvGS0+BP/opErgpjk6W3WmtG7R4xmyo7eSkuK+L0QTSCOIPUy7+VVCym3cO4omOMoaFxs19aQpmbR7jfGqe+47Z2tf5Kg69vEuxFJwRymIZKmFMmu8wypfwTfsBHx5JZLw0kJsZcREfW5WQSibpz2r2tfH4EqimmlDq+Vk4whyRQjsmmSctnf6lsZS7+ysUNgV46qmq6Wa/ZrpmMpIq3K2f4UHhfuBMQV3L7YgaxW/yvDzSm+p6kLB8ELqr8uOMyXlVHEWMcZv9/MVykCoWAyMsPKkr8wVnJuHHOy+clnpSMARP3OfYmiOfcExzupMH5xjgjhvCyXcEFEm1h8yWrFJyL1MvwvEBXjn+RBT/nuqu+QzB/meSCXuHXj5H5EIZRAs4rb7GYyUA59a94xDaFaP5jRCQ/i3iOGWtL8pEyhrbYBBZbkRHXdAF5qIJbGkatQiTzfqRdI8vqWchy2SPI/Q3nQSMGl2EkkMDoeXSQHk6mvioKw1jjoxL5IOM18Zp68zwNyXPCOivmLWnHms2gv6AdX6Sz6vpmMSDwbUjw7fC9Ag39XxOsnh0CMWDrtSxuX5CueZ9cBSFF+Wur4dzQteZSWkog2bOL+OexEcWAPVmD+V87IORIJbicZPPF8UmJS87IxqtijXM5Fx7WsfLoky29NZxSpT6lOfAGg8XZhDYCuvbjpygqBSnijYf7+MoyIGjsIDprHiAPkDLs1XS2KGueVFB8PRjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799012)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(83380400001)(26005)(426003)(336012)(36756003)(86362001)(47076005)(81166007)(82740400003)(41300700001)(8676002)(5660300002)(4326008)(36860700001)(44832011)(2616005)(356005)(8936002)(70586007)(54906003)(6916009)(2906002)(316002)(478600001)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 08:07:17.9697 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a7641d-2c4a-4b3f-50fd-08dc216a7a3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5898
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

Changes in v5:
 - Disable this test case by default
 - Use single quote to maintain consistency
 - Setup the network configuration before exiting the test
---
 test/py/tests/test_net.py | 58 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
index 4ff3dafd6293..038a473b2394 100644
--- a/test/py/tests/test_net.py
+++ b/test/py/tests/test_net.py
@@ -8,6 +8,7 @@ import pytest
 import u_boot_utils
 import uuid
 import datetime
+import re
 
 """
 Note: This test relies on boardenv_* containing configuration values to define
@@ -31,6 +32,12 @@ env__net_uses_pci = True
 # set to False.
 env__net_dhcp_server = True
 
+# False or omitted if a DHCP server is attached to the network, and dhcp abort
+# case should be tested.
+# If DHCP abort testing is not possible or desired, set this variable to True.
+# For example: On some setup, dhcp is too fast and this case may not work.
+env__dhcp_abort_test_skip = True
+
 # True if a DHCPv6 server is attached to the network, and should be tested.
 # If DHCPv6 testing is not possible or desired, this variable may be omitted or
 # set to False.
@@ -120,6 +127,57 @@ def test_net_dhcp(u_boot_console):
     global net_set_up
     net_set_up = True
 
+@pytest.mark.buildconfigspec('cmd_dhcp')
+@pytest.mark.buildconfigspec('cmd_mii')
+def test_net_dhcp_abort(u_boot_console):
+    """Test the dhcp command by pressing ctrl+c in the middle of dhcp request
+
+    The boardenv_* file may be used to enable/disable this test; see the
+    comment at the beginning of this file.
+    """
+
+    test_dhcp = u_boot_console.config.env.get('env__net_dhcp_server', False)
+    if not test_dhcp:
+        pytest.skip('No DHCP server available')
+
+    if u_boot_console.config.env.get('env__dhcp_abort_test_skip', True):
+        pytest.skip('DHCP abort test is not enabled!')
+
+    u_boot_console.run_command('setenv autoload no')
+
+    # Phy reset before running dhcp command
+    output = u_boot_console.run_command('mii device')
+    if not re.search(r"Current device: '(.+?)'", output):
+        pytest.skip('PHY device does not exist!')
+    eth_num = re.search(r"Current device: '(.+?)'", output).groups()[0]
+    u_boot_console.run_command(f'mii device {eth_num}')
+    output = u_boot_console.run_command('mii info')
+    eth_addr = hex(int(re.search(r'PHY (.+?):', output).groups()[0], 16))
+    u_boot_console.run_command(f'mii modify {eth_addr} 0 0x8000 0x8000')
+
+    u_boot_console.run_command('dhcp', wait_for_prompt=False)
+    try:
+        u_boot_console.wait_for('Waiting for PHY auto negotiation to complete')
+    except:
+        pytest.skip('Timeout waiting for PHY auto negotiation to complete')
+
+    u_boot_console.wait_for('done')
+
+    try:
+        # Sending Ctrl-C
+        output = u_boot_console.run_command(
+            chr(3), wait_for_echo=False, send_nl=False
+        )
+        assert 'TIMEOUT' not in output
+        assert 'DHCP client bound to address ' not in output
+        assert 'Abort' in output
+    finally:
+        # Provide a time to recover from Abort - if it is not performed
+        # There is message like: ethernet@ff0e0000: No link.
+        u_boot_console.run_command('sleep 1')
+        # Run the dhcp test to setup the network configuration
+        test_net_dhcp(u_boot_console)
+
 @pytest.mark.buildconfigspec('cmd_dhcp6')
 def test_net_dhcp6(u_boot_console):
     """Test the dhcp6 command.
-- 
2.25.1

