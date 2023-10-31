Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD98C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 12:59:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D82C587C8F;
	Tue, 31 Oct 2023 13:59:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F9NC9Op3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6578987C8F; Tue, 31 Oct 2023 13:59:31 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 545F187B53
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 13:59:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kp3Z7QA9fsmXA/OpX4qKeHiZ6MGI95cYbEeOj5uf6QvwMVwawuSZ3gLlAZMBNMUY2FW5asAgaAinqYtI9Aw0ku+5UPhvR9ocu4tr42/rFJnmwebg0I1P7AI7y/Y/rTw5UvEwFT04nQZFB/mkHOgFVuIo5RBF3qvlobWSuYEZc4J/upK24RUU9LjrdL0j39TZ1S4zJgzo7LAsmWznLTryhUMjVtugv7puboP5EZYS90bXLplPDjBj2ngnxD+mnH/ps9oZu0vDU5VNYN2iWTLMLWs/8TdkCTAC5JOcAvqsNqMb+gHVmNg931PeptSh9Bm8+8CDROcfuZQ1AoZiZwVhiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mGmtX1c97XVM7DtDyHht9OpCvzrPNaObtQJ4YZf5+A=;
 b=j4htzzuNL4iTc7zV/cHBiIAI0dOU19SbQ+9bG4i3SOWdEbQL/zsWFBthFl2C66lbBv9Z0KxXti/HTOe1FIuUfNVLBrzKnKSj+jHfOTxKLSMM2kI9SyWGAd1sAYqTzgqPRxf2YXbaX1FVI5p2OfsnbHDdPxa3cKnHpPIX+gRm+cEOT47leoCPxp4Q8+dT7jLK6nxn74u6RhPNd6Uh3VANP3fky4CJBQdsIac4sXhN6OFAh/QzI3DReQDI0zDfHAbfmbgBcKDjdeIThb4VEk9FKsu1piwQ7gw5PtBMnvFdZI/575IRfl+Cz4b9VSHi6SKTc5pIm9pf+xnnQSeeKnWg+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mGmtX1c97XVM7DtDyHht9OpCvzrPNaObtQJ4YZf5+A=;
 b=F9NC9Op3fIDFGRBaf2F8XxpM3+U97CbE14BlpcB69SKP90RanAMDENAJ8pP7kdHW7+i3vo/znXVpYDOGTn5N+TF6lrl0niV3R7RNmlH6kbSQukO714zpsEzZKhwxWl6spdDaaqCeKZTDx1c+WlN44e5VfX6d/uoBoWQpkyOVBtk=
Received: from CY5PR19CA0131.namprd19.prod.outlook.com (2603:10b6:930:64::19)
 by DM4PR12MB5309.namprd12.prod.outlook.com (2603:10b6:5:390::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 12:59:24 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:64:cafe::3a) by CY5PR19CA0131.outlook.office365.com
 (2603:10b6:930:64::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Tue, 31 Oct 2023 12:59:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Tue, 31 Oct 2023 12:59:24 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 31 Oct
 2023 07:59:23 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 31 Oct
 2023 05:59:23 -0700
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Tue, 31 Oct 2023 07:59:21 -0500
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>, <rfried.dev@gmail.com>,
 <v.v.mitrofanov@yadro.com>, <seanedmond@microsoft.com>,
 <emohandesi@linux.microsoft.com>
Subject: [UBOOT PATCH v2] test/py: net: Add dhcp abort test
Date: Tue, 31 Oct 2023 18:29:20 +0530
Message-ID: <214217fdd0d69a107482c5c6f6dce96894aa5dc1.1698757115.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|DM4PR12MB5309:EE_
X-MS-Office365-Filtering-Correlation-Id: a72a4e49-b256-4e6e-4eb5-08dbda113531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XJqPzCgvKOSH9D/vDeGKce5zVQWs2Zv0hiNfPInSkQF2iIsBaNk/0dqtHtqRxiGivorXbWs2UfLg++mPadNjFqpx5uNrHwySS35m/oRtbnsVSrH7iILjjiWrAgMpzM7CO1Foc1+2290it5Y48wuC0kL5wvTOzor9O89PiMkq8Gytn806dKAqd0lPgcFta9HDliHI1LtOYwDLF2kdLnhNMVs24pqpY4iicxQvxvy1/h/Nr/IM45WDc8S8mAOkTr9fUcSWliQtNrEWifaM0dmYckSq7bSjx++wYX9hgnQ5z3E3bPsw2KpZ2e/RGaaw4rRjMKRd00sAv9PzzEkzvI7eKe50rJrR+8yTmjgcCkxbs237fs0QUx1t+KB7oXlzUxFeG5PClauAe0sYiQBUuBSIBPyCZ1p4eXXkHPvExt6HWRqjnE+hfinG7HkVXC8Rn/5Ye+EOmn87IqXLR6uRbBTEAUWTqFbP6euoMnTGmKH/rWPZx7kaKkis4FKQeMXgGjpC39bmHVNb9BXXc/Jd26mZI77d7uWdtVhFrhp4U0hiKET6GVt6NAH5AFv4FmGSVVxTvkB56/DdGTenbbhGnI1VQqh6rp+v3uGWf3ww01SrRkh6B36iw1ut8GIvQGx7F5HmQe6BJ4YPYigQM/Bk6IFpTrMAFGjAabxy8v69lljDhracPdgSZJ3n+aw+dQjjSD8egi+jkoDyBtklVeWDN5SS8X2nwgrI3qE/hy3xCOWde5EW9L+4sX0VXC/JFm5UP8TNTLiWWJ1TkLEoKzbKqA8ETw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(82310400011)(64100799003)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(478600001)(83380400001)(47076005)(26005)(2616005)(2906002)(336012)(426003)(5660300002)(41300700001)(54906003)(8936002)(44832011)(8676002)(4326008)(316002)(70206006)(70586007)(36860700001)(86362001)(36756003)(81166007)(356005)(82740400003)(6916009)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 12:59:24.3686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a72a4e49-b256-4e6e-4eb5-08dbda113531
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5309
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
---
 test/py/tests/test_net.py | 45 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
index b2241ae6a482..6d32ad2db687 100644
--- a/test/py/tests/test_net.py
+++ b/test/py/tests/test_net.py
@@ -7,6 +7,7 @@
 import pytest
 import u_boot_utils
 import uuid
+import re
 
 """
 Note: This test relies on boardenv_* containing configuration values to define
@@ -115,6 +116,50 @@ def test_net_dhcp(u_boot_console):
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

