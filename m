Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFB1C46CCD
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 12:21:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D560987252;
	Tue, 19 Dec 2023 13:21:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qDfbtpFM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68ABE87282; Tue, 19 Dec 2023 13:21:20 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC44887032
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 13:21:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikT6xuoTaHVVUqyoS3VU0lkAZHJlq9umjQRAe+bTC/Fo78zUMf5SdWj9yOeESWtDj4dduW2DOryKQp+H9DkWj5mpKmPGRzipJG5tJNjZGlPXJth4mnbg71Ldezh+EG9SMCCQMKhjq55ueGeLOSsblJxYJ25sorKkCqEVRSw178QGd3DOd6SmpJuIF0GCQ2dz3C9LuKQ9nw/ForNe7gglDl68iAdwhG8l4BSsVqkZPyOx4mKB+zQGnnVlQpMRRg6TIOQwkQGVovjRuLY5i1bwRBBSistEMyQ1ANuppRrmPnbQygdRhINmI+7G0LlM221BuvM9VfBN+Vbdx6OkJZMCBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAG92yKf4UlDXbxG/MWDPdh0pI8rsPYIigjcLzNGSXM=;
 b=cAPnoz9vliTqn7kmPEpCRteGl8NMScPrwB9/Funut2mNlnREwuI0rnEWFMJegcMzsu8XHfXUjyBDEQD1BLGaiItyOUiO6nltLYDRxP6ZZfIF6FJlLlj5B6pKfNWKnepOxkG1TJkn527NJCt7BAMrSwdjMjSY/99/8i+4SVoc369iT9sPJ34JcUMa8pPKUueqICbS3ZetmYPei2RJY8D3r4msyaLW0WUE9wVsI0A/nW81Cxj+qzvujZRX4ymlEbYwadbLhOU1deNxqBaPLXcdmrNsB8YaQZLNh0mjGC9mWihsz/T8MwRiE+D8ngAdfzynhAqlejgpd6088/ryOuDnzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAG92yKf4UlDXbxG/MWDPdh0pI8rsPYIigjcLzNGSXM=;
 b=qDfbtpFMWV2UnXU6kg6U99vjfpmn4bOqJd9VXFZh4gHAz04mfwiXi9xmcg2HWYAWU1a2D8i+aJrV0Tm4V0aP4zeA9kz12JbX3hdMDOcQ8f6rayCXyUQAoNmUOnn2LBVtX2syeEMcojtM115TzRtzfzPVPDBRAEVis2iwz8hmcVw=
Received: from DM6PR03CA0005.namprd03.prod.outlook.com (2603:10b6:5:40::18) by
 SJ0PR12MB6855.namprd12.prod.outlook.com (2603:10b6:a03:47e::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.38; Tue, 19 Dec 2023 12:21:14 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:40:cafe::ef) by DM6PR03CA0005.outlook.office365.com
 (2603:10b6:5:40::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Tue, 19 Dec 2023 12:21:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 12:21:14 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 19 Dec
 2023 06:20:58 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 19 Dec 2023 06:20:57 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] test/py: mdio: Add tests for mdio command
Date: Tue, 19 Dec 2023 17:50:51 +0530
Message-ID: <92907606c7b930808b82582bea752d4cee13cae6.1702988434.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|SJ0PR12MB6855:EE_
X-MS-Office365-Filtering-Correlation-Id: 4808df06-c6ad-4fdd-4112-08dc008cfe9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wHvLK5WIoMDSd0nTjuErYP0Yjjvnce6M3xFeTbrX4yHGFSMad3gC7cyDGv57gYEZ/CIkGmqBkoEq7uvhAoN7ZYH6oz2exPLQS7i4BN/BcbMNo4hw2JHoHLirxwxSLxBxk4lvNol//dwV9lUoJvdUWSXhScjyqhYZmy3lEYSRfCWK0uB4Rj1OS7NNGXGIRDXnNI3CUmpjRzParKzK7bPlND3M+ZDNO2aoGKNX4VjNJnrTQXq5B4MRvKt9nXVPdDcEf8dq5RczKU8WenrNwwUBL6EPaDhMVcBbYQvo3PEwUHq2tWEzXR+UQTVyk0LxAxPpEqEupZiSlhh7IxkPmhgyYWIDkksrE4peaRziIgHXEfUgLCWPfV/8wx8EnjCHbk23J18uFoAIaZATn1EnkNiMunZYzxchc2FN0x8rJPVJk/XnY87tucVk1gZ1R6bIu1m1CrEtpcE7T/Ra9opj5+rqeSPuNcHlOQU1Dj/rdptU0HmhOdMmQ7HBZo8F+Fp3NUigeAMaP1ODSoC81JPCudQunHe4AYIQckB6nQPlviFqDy5XXHqE7trbNLz1VQD5xgx+Rp4U22n6vh2Bf9gbGcdxP9OqbfP6Dw9o4U9xHW5EUfV35MR0VtJYPPispw4SxUFvAVScNyTvtYPMyBCutcos71suubqstobh5zlQOuQ8iZ2/JDMcSqpAD0+8ndnPm8um/eLn1fLWf/geSLCx9lVwrvrbnY2KP8BjlibytWY4WWIZtSKeJbABTFqkWGuueoULBRchzbGQQL4JtddWext3iA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799012)(36840700001)(46966006)(40470700004)(82740400003)(478600001)(36860700001)(40460700003)(47076005)(336012)(426003)(26005)(36756003)(2616005)(41300700001)(107886003)(6666004)(40480700001)(44832011)(86362001)(2906002)(6916009)(316002)(54906003)(70206006)(70586007)(5660300002)(81166007)(8936002)(4326008)(8676002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 12:21:14.6192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4808df06-c6ad-4fdd-4112-08dc008cfe9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6855
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

Add below test cases for mdio commands:
mdio_list - To list MDIO buses
mdio_read - To read PHY's register at <devad>.<reg>
mdio_write - To write PHY's register at <devad>.<reg>

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
 test/py/tests/test_mdio.py | 79 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 test/py/tests/test_mdio.py

diff --git a/test/py/tests/test_mdio.py b/test/py/tests/test_mdio.py
new file mode 100644
index 000000000000..89711e70b559
--- /dev/null
+++ b/test/py/tests/test_mdio.py
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: GPL-2.0
+# (C) Copyright 2023, Advanced Micro Devices, Inc.
+
+import pytest
+import re
+
+"""
+Note: This test relies on boardenv_* containing configuration values to define
+the PHY device info including the device name, address, register address/value
+and write data value. This test will be automatically skipped without this.
+
+For example:
+
+# Setup env__mdio_util_test to set the PHY address, device names, register
+# address, register address value, and write data value to test mdio commands.
+# Test will be skipped if env_mdio_util_test is not set
+env__mdio_util_test = {
+    "eth0": {"phy_addr": 0xc, "device_name": "TI DP83867", "reg": 0,
+                 "reg_val": 0x1000, "write_val": 0x100},
+    "eth1": {"phy_addr": 0xa0, "device_name": "TI DP83867", "reg": 1,
+                 "reg_val": 0x2000, "write_val": 0x100},
+}
+"""
+
+def get_mdio_test_env(u_boot_console):
+    f = u_boot_console.config.env.get("env__mdio_util_test", None)
+    if not f or len(f) == 0:
+        pytest.skip("No PHY device to test!")
+    else:
+        return f
+
+@pytest.mark.buildconfigspec("cmd_mii")
+@pytest.mark.buildconfigspec("phylib")
+def test_mdio_list(u_boot_console):
+    f = get_mdio_test_env(u_boot_console)
+    output = u_boot_console.run_command("mdio list")
+    for dev, val in f.items():
+        phy_addr = val.get("phy_addr")
+        dev_name = val.get("device_name")
+
+        assert f"{phy_addr:x} -" in output
+        assert dev_name in output
+
+@pytest.mark.buildconfigspec("cmd_mii")
+@pytest.mark.buildconfigspec("phylib")
+def test_mdio_read(u_boot_console):
+    f = get_mdio_test_env(u_boot_console)
+    output = u_boot_console.run_command("mdio list")
+    for dev, val in f.items():
+        phy_addr = hex(val.get("phy_addr"))
+        dev_name = val.get("device_name")
+        reg = hex(val.get("reg"))
+        reg_val = hex(val.get("reg_val"))
+
+        output = u_boot_console.run_command(f"mdio read {phy_addr} {reg}")
+        assert f"PHY at address {int(phy_addr, 16):x}:" in output
+        assert f"{int(reg, 16):x} - {reg_val}" in output
+
+@pytest.mark.buildconfigspec("cmd_mii")
+@pytest.mark.buildconfigspec("phylib")
+def test_mdio_write(u_boot_console):
+    f = get_mdio_test_env(u_boot_console)
+    output = u_boot_console.run_command("mdio list")
+    for dev, val in f.items():
+        phy_addr = hex(val.get("phy_addr"))
+        dev_name = val.get("device_name")
+        reg = hex(val.get("reg"))
+        reg_val = hex(val.get("reg_val"))
+        wr_val = hex(val.get("write_val"))
+
+        u_boot_console.run_command(f"mdio write {phy_addr} {reg} {wr_val}")
+        output = u_boot_console.run_command(f"mdio read {phy_addr} {reg}")
+        assert f"PHY at address {int(phy_addr, 16):x}:" in output
+        assert f"{int(reg, 16):x} - {wr_val}" in output
+
+        u_boot_console.run_command(f"mdio write {phy_addr} {reg} {reg_val}")
+        output = u_boot_console.run_command(f"mdio read {phy_addr} {reg}")
+        assert f"PHY at address {int(phy_addr, 16):x}:" in output
+        assert f"{int(reg, 16):x} - {reg_val}" in output
-- 
2.25.1

