Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D64C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 08:39:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91F3387182;
	Tue, 14 Nov 2023 09:39:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qRAMxwmi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE4D38719F; Tue, 14 Nov 2023 09:39:23 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 836198715B
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 09:39:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1wxm9v5r9xSev+HOj68Zb93nfkMXpe7Ib3vHYsGUUXaqS5xFP+34dVWeiYGYNqBpeiEfJSQLZr5yxoO7UvYwUrTweMz4XUHcgIlRmfQVkRQW2iEzASoXWDVE0U4ZURTO1cWrHKZfRZUtqxsCiRnrqQpEae1tqPGQYB0ufRbQw3/xk2G7HuYZUPhMvwYmxsA8DAg4rOoDwLuS6AfyurYpgWDljcKzcsl6Dafzt7dpMZB2dBiAedtmsfRx/2lzrWalkBzi124TuSjt/Ng73XxKCKho1ScoX2gs5gwgkAXu+pR5FskjJeKLwee/oJ+6S4MgwPjddixGhk1TnMk5+kZww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UO84ogFgzn5haPa8FHvutX21wG3XyZjYxAZ1IA/4knI=;
 b=kpzHGSXt3w3CytokxoQFxVqnrVm2X55uUQiraiv9ZbNWTseht3PoRSikwbmayZeQnfAvz4ebJ6XSxuKLILVwRSf1p6jIKIoq+69T1uJK+C3hmd3g+dsoLEf8DDNIbq8+Yy1enfHu93MFqqUHRFi5+Cty0kdjyKWEVPi9T13bn6ZKVOVVFV8hOjNCG+MZergp/nM/gVFPcDoL4GjTZiKtdDO34GyJ9C/C0vH6Wj80+mTMQ04ckjZrFA2ijR9387WQyjooLORvBXF3tq/TTHX1cZkVKiOsbLxRe7yftQ04jhTxtgyHmco3agsojMPOKkx2rus841XaRZ3+zE2XK4RB0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UO84ogFgzn5haPa8FHvutX21wG3XyZjYxAZ1IA/4knI=;
 b=qRAMxwmidf5Ucf5syWvDoeyNLtSJW2Gw/dnbkjgabA4DxjCzbVtJL/VNB09haZ+3ae3kL37OlbXaXO6aDAsYnKBpGhAiR7bE2jd37rraUQot2cJpqxNNytYLqvGZaUsFB2BVquwfHRVjl4MoDohYu2oI3apC6T4h4byJMVoJijM=
Received: from MN2PR18CA0004.namprd18.prod.outlook.com (2603:10b6:208:23c::9)
 by MW4PR12MB7310.namprd12.prod.outlook.com (2603:10b6:303:22c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 08:39:17 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:23c:cafe::a1) by MN2PR18CA0004.outlook.office365.com
 (2603:10b6:208:23c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31 via Frontend
 Transport; Tue, 14 Nov 2023 08:39:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Tue, 14 Nov 2023 08:39:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 14 Nov
 2023 02:39:08 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Tue, 14 Nov 2023 02:39:06 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>, <rfried.dev@gmail.com>,
 <v.v.mitrofanov@yadro.com>, <seanedmond@microsoft.com>,
 <emohandesi@linux.microsoft.com>
Subject: [UBOOT PATCH v3] test/py: net: Add dhcp abort test
Date: Tue, 14 Nov 2023 14:09:01 +0530
Message-ID: <a02d523a004e6c42c666dd0d90ace8cc44cbcee7.1699951058.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|MW4PR12MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: 07306397-1a42-4441-ba8e-08dbe4ed3032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qQzKFWIkxncSgWRJUqtuzl5mjYPq1P+KiCpOLOUOYr+yQSPCuflj9PgaaznnWFqghfhzAP9tfhSECeIhmpCC/Sr+hOBykR1ZJezth9PHHOTF6fI6nAjCO0eYnOKbmbM5n5d/N8zNtZjgKniEbZB66nlK4ZOysYwySEI9ffCas1+zi/GuhbVZkepre6OnqujVeq2mpq9Dl3c+dZnUwTkQfvEMmN8nIcb2cm76OhYNaIkfKusbPEM5m1dr1mJG597HxWsY3mgxS0O0CXrDKmqysd7vgBYcloKLnbCfUscgdM2M/EXydNZq10I2Pe83UDlsTWbo6RhxqTDY7XFLvaB1eieEHsQ4leBojPQKZ1qcJ+s+Xbs3mqWthIQ1vhZML1HpsNp/cO67/sFxEN60aTC000pvy4XR+ZZe0Fez0mwfT/IA/2UWDSE3NHz8nMLisMwzc7f2jUJpx1+T91BnhH5mTZ0mMTK/ZtWzRpIeMsTtEMr53fTCFlwW0k8BiOHqwcokJ+hzkUg8UoUYCZXDCHDh08iLY66VDkPSx/yO3cDQM74FeiuK9/m6ClMUJ7CLRagnArYMUdNaJrdYCCVy16WYcKljPszIev3T70sFpUv4I2q0JmIzF/6cU65AR0M4WhjvoYswWKIBA5JfYZxR+dQcy2YN7LmT0ffde0beB9IKrjSDcT9sQMgLffVwkByTQY9uL19ILW5Q3rGzJpoOombh4+AiPdBua1CrggfD8zpg7cTO4tlTEJ2S+cOvW1/OxZ4iir2StFtKuEUEqtjxpNjApA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(40470700004)(36840700001)(46966006)(40480700001)(36756003)(86362001)(40460700003)(478600001)(2906002)(6666004)(2616005)(41300700001)(4326008)(8676002)(8936002)(6916009)(316002)(54906003)(47076005)(26005)(426003)(336012)(83380400001)(36860700001)(5660300002)(70206006)(70586007)(44832011)(82740400003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 08:39:16.9757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07306397-1a42-4441-ba8e-08dbe4ed3032
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7310
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
---
 test/py/tests/test_net.py | 47 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
index b2241ae6a482..76647f274006 100644
--- a/test/py/tests/test_net.py
+++ b/test/py/tests/test_net.py
@@ -7,6 +7,7 @@
 import pytest
 import u_boot_utils
 import uuid
+import re
 
 """
 Note: This test relies on boardenv_* containing configuration values to define
@@ -115,6 +116,52 @@ def test_net_dhcp(u_boot_console):
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
+
 @pytest.mark.buildconfigspec('cmd_dhcp6')
 def test_net_dhcp6(u_boot_console):
     """Test the dhcp6 command.
-- 
2.25.1

