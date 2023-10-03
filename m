Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC907E75455
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 12:46:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDBC5871DE;
	Tue,  3 Oct 2023 14:46:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lXyfgcf+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F567871F7; Tue,  3 Oct 2023 14:46:22 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::60f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 190CE8707E
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 14:46:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Or33+pAsNsMWN4ZJhT7f9OEiET4lVvtdilQorhI9MGb1I3Z1sWidXin4gqw9pIlIWGdW9+jPsLx+WZSdKtYjzvDpl/aytUkTxh0yTol4RKI0KZ6FjOS8Lqv2HnA4Zg4DQn5/9Onbmw9NuUv8QODGkPVbnMzxFAMHWtuX7TITRlrGO/MuOSuoOQXW1vfcKdcIk9rbn2rSN8qEb3nKFVnTrA+oraGCP3vVYpuXYoJgVzyg4oHQoViUHbbasBiMlnpbaY2l5fTv8S1meiywJXUpD163iLIU6ECeJEFvI402g1xOWtg7RtK7wVw/MAyeFTY3jP2S9CeEc1RZE9epkOI7+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxrzH/95d/6pzqdYS6XJT/XMjAZaCpoQ53YDPs0cy0g=;
 b=ho2TghXHDm3sGA6XwwWQGUv6xgB9QREpZYx7FD4Yci5YihwTo2xX6GwIu3kp5IhDfcoeBsAIyEkOWf2aJ/Q5m/RzoAykjArpTO251uUz43fgVOmd2eJhQ10EdUdeEtkGIoV4KPefVXEWjlCmzkWryGXqrkP2f93l1Vq86UK4QkqoHlxNZBNi2HgMCQgs7ZBNOAXj/Jj23M0sRGz07buGZi8K0Th/x4dBP23q2/X5KG4ol377953atguEivGwfYbd6clpkYrrPqvbfwiVgoXGlZDS7rhOgTCsZu9B153g8gQNZWY4JKRV2XepiHGFlW8ce0puKCP5sugIXv13STGr6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxrzH/95d/6pzqdYS6XJT/XMjAZaCpoQ53YDPs0cy0g=;
 b=lXyfgcf+KMQli2CIwK0p7ZAwDzFYr4L/kqSHFpF2JYcZhnkTfcVpUeqLY03/JZkUtgAnurMHD9H3cGoqX45W0o3MuiK1683HmHyRv0fOLhEXH0yz26vg9ZfvkYvUDKn45Qx/IRitcEzSCxfXfWOhMIBDru/bx+ZsaP+zMTvgwS0=
Received: from BL1PR13CA0301.namprd13.prod.outlook.com (2603:10b6:208:2c1::6)
 by LV3PR12MB9141.namprd12.prod.outlook.com (2603:10b6:408:1a7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 12:46:13 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2c1:cafe::e) by BL1PR13CA0301.outlook.office365.com
 (2603:10b6:208:2c1::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.23 via Frontend
 Transport; Tue, 3 Oct 2023 12:46:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 12:46:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 07:46:12 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 3 Oct 2023 07:46:10 -0500
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>, <rfried.dev@gmail.com>,
 <v.v.mitrofanov@yadro.com>, <seanedmond@microsoft.com>,
 <emohandesi@linux.microsoft.com>
Subject: [PATCH] test/py: net: Add dhcp abort test
Date: Tue, 3 Oct 2023 18:16:04 +0530
Message-ID: <12a4371d0abfe7de83a42847573b8db8c1bba8da.1696337031.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|LV3PR12MB9141:EE_
X-MS-Office365-Filtering-Correlation-Id: 6777bb10-5b5c-40d1-0bbb-08dbc40eb9c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eNXSviEWGP68D7Lf2FF+lExO8dpvITMWLg2DZ2hkHbASkqkoI1bdHZrhseWzMjNTaZZ61Aksq6b8O7VJXpji5szIpq1eBZAwBkq13Ff03lga8v8EoL6ZMAsbIkfijNX5kvbgqOlm1GNnPuVTDrxd/tk706j2BtayiylWARlFpyUEPH/M8eC6d5myGwhQ1Iq8GlOyhNKtW4Lg+k4ooxS4ybxUZE30NXGNHRpU7aOwJmeXfzxAHTJB1AgUmpkGH16LW84byiNlVgS82uhs3KEBqY5DRfY+KABOAU7aeUD3zXZIqwkR71a98/N82YlKjl0YWGg9ucsFXmgeaGqgjr82nlTd0kEz2yNhCQOfyLIpTWPewz4pymnU2b2zeYFa4OjmB9F5jn6kBxoA3/yLXNBMQBEtxvmvjmSBV9PQu8CbuDqm0mqsurAElnk/dRnBfErFyOYEkuAOvbJvVDmFuqJDpKwXXZ1UyljpwEr9fAdKdBcAFH/1wy+CxNlVyKnCIFaGemTZVvV4OQdN90qZDexvqgRjWZihFY1MSczWGMQ8MO6GbjMb8toh4KWVgY1coH0Bsp71O3RYDjunZgazI/53PTvK4pqTBx9bvPOgkie+rxCs6kHta13TW6+YB0yta7Kc/J9cKc4Tov4sQaxok5vKStznx/e7Nsk3yThStl4IZrBD2vDOam3cfY1toZKRlY8RFRyLs16bZALVN886JAY8f2ZnIWDGZMtL67aqh0WxEftMhiOZm0Ntggz3rBpPLbihzo7Y3CweNDU9ZBk6RN2hvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(186009)(82310400011)(1800799009)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(4326008)(83380400001)(336012)(426003)(5660300002)(356005)(81166007)(82740400003)(44832011)(86362001)(36756003)(6916009)(36860700001)(54906003)(316002)(70206006)(70586007)(478600001)(41300700001)(8676002)(8936002)(47076005)(2906002)(2616005)(26005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 12:46:12.8069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6777bb10-5b5c-40d1-0bbb-08dbc40eb9c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9141
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
 test/py/tests/test_net.py | 44 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
index cd4b4dc53cbc..1e8eb0357eef 100644
--- a/test/py/tests/test_net.py
+++ b/test/py/tests/test_net.py
@@ -6,6 +6,7 @@
 
 import pytest
 import u_boot_utils
+import re
 
 """
 Note: This test relies on boardenv_* containing configuration values to define
@@ -104,6 +105,49 @@ def test_net_dhcp(u_boot_console):
     global net_set_up
     net_set_up = True
 
+@pytest.mark.buildconfigspec("cmd_dhcp")
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
+    u_boot_console.run_command("setenv autoload no")
+
+    # Phy reset before running dhcp command
+    output = u_boot_console.run_command("mii device")
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
+
 @pytest.mark.buildconfigspec('cmd_dhcp6')
 def test_net_dhcp6(u_boot_console):
     """Test the dhcp6 command.
-- 
2.25.1

