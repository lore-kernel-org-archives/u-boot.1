Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3CDC54FB9
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 08:41:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6054B8722C;
	Tue, 21 Nov 2023 09:41:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y8dxpu/l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F32FB8722C; Tue, 21 Nov 2023 09:41:36 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98CF486489
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 09:41:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oR2367lbt9TOl5a80wdGmpjSPmnpig19HRvzHePa8buYQMkZAHW/Bpai+8OSIbpkQfv9eY+7Gn4PivvN0+Hc4pzf7ROX8d9ZYQ5amatKsgfECMkjKU7/BWWdYIF1uO+VuzXDTr0CtB3Dw4KcWi/Vd80pjYRqNgo+9gpt/iaewTiHERs9y3Nkrp0t3HbbOMbJ3L7s3Cs7clFBFiW154fTGFl/sXR2bmhc4fQgsU9Zo26Kr0fegsDHL838go0/TCzNf2IVmwhMhpXaxUDxlolDQxd8wmAe2Z2Ml8lt8Y+xko37QE8+jh+rhCf/PNpskTaZcDme8f8QimZRe21Rlk6J9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPAh6EHl9uyYToi911TDmFjiHulPadRZmHKjO8GuPOY=;
 b=PoS/daqNqo4WP5HLxJLgEtppxUE73KZwMNyYOH4nhrFQEE2l40B7kmi2gOHqncVllr5WYSOQeY8LDsu8NM87dlBBMfWGVcr1cGx476xoSj12oGRDe3cNkTz+gl0ZZZ5IukhydXzFQSKMtVKyrsFSwjc2UtE9YcldHRG8wIIGaHRFbLwZOssL1c57g6Jjh9Yv6GWVg0wvTwzgSE5HMnqmJioiPMXCQDD6XkqA/lg8EgXKHSxFDuqNEqWgra857Jtw5/h39aeVbfKWYV4QuBgDv38WxbFnqhHcwVrVW6zrz+KsdsF9m+vyFPIdMYtdZ3p601LXi37SNlkli2btSGtgLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPAh6EHl9uyYToi911TDmFjiHulPadRZmHKjO8GuPOY=;
 b=y8dxpu/lFptDfVvUZjzPdZchG8+zZxpDrxl+Sv7t0LdTIdGlQnE4/XYoBQTQz6b1I9c8V5QXSR056U0VXBxGlKtT0MRheDsg0EJscqOR0nfVPS0xwYjRKuVscWJg2ozv4Xh5ITntvv/tN5duCSmEgK4jgjlvR3G+9Ii2EFIb8BM=
Received: from DS7PR03CA0297.namprd03.prod.outlook.com (2603:10b6:5:3ad::32)
 by SA0PR12MB4351.namprd12.prod.outlook.com (2603:10b6:806:71::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 08:41:29 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:3ad:cafe::32) by DS7PR03CA0297.outlook.office365.com
 (2603:10b6:5:3ad::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28 via Frontend
 Transport; Tue, 21 Nov 2023 08:41:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 08:41:28 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 02:41:20 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 02:40:52 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 21 Nov 2023 02:40:51 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] test/py: mii: Add tests for mii command
Date: Tue, 21 Nov 2023 14:10:51 +0530
Message-ID: <20231121084051.3381640-1-love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|SA0PR12MB4351:EE_
X-MS-Office365-Filtering-Correlation-Id: ff88c200-9426-4780-5d15-08dbea6da7a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0aJ2KD0WvJjQccPPp9br4lllpHZzS+IIV2SDZNSyEPhahCpQTXH1rL53ZQNOb0fSStJv46N4MLrb44OL2V/kMWGvnOJfBC8aMooGmCjs6Chp6eo15jPTJpW4eW8VWeT6Rp+ETiggaGa6TxZSdbdifV0iFjk6yXWlf8xYWdIVtmtG+QYTV8FB9MsNefWSpklFd/dVbBMKCe0azaQSlTA8CkG53BYyL91X5mahLwYhvcznO5fVUKxOznO9Q3qNp6GP2Px4FgyTpbxfZXgSfhx19PkcCVqSdVdwZA4h5tAfPdxEYZgsiieex/gv44cidUCV4ZXusEofYSKAvdcONx4UriM8EWPcWbzMdvzy3kKIZ5E3J6k2p94+dLMMoFiFxXrQzjsZHwQCR0RcKGEagsdbBN9QFQVYIzT5arJ26KPgysinzPl1fYw8I1GnorJV5A+vNVnj1wJ9Y8KJMkKO6nanPlOzDtjpeRfGEVwH0w/57mYSThUp0llgut/Kow7BArGwtMXzEBI74O9+JMtrMATiWjOtkFm5+eF1VnmNKAuBdmsdkAQVNgM/siwx0ulWALiOhyvK6K5TYLOS+6GhulXu5TPTFLnuPeLPEupFcUaqJRFL2ZrGptzMmodzbL+O/UEHxuVjVurjpFp1YxjY1a5khXOkp/DP0l5Ei3+nJK12kDqSRmcETEWjO4gQgAXvorNL+T3x3Nl3OAUzb5CiB2haKMeeGYE8cxoKaD8weH8GfuLHIJr02nLlXFnhoHIA2mSkVkbkKW4dF+2OFBZX6wuRqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(1800799012)(82310400011)(451199024)(186009)(64100799003)(40470700004)(36840700001)(46966006)(5660300002)(44832011)(2906002)(8936002)(8676002)(316002)(4326008)(6916009)(41300700001)(54906003)(70206006)(70586007)(40480700001)(478600001)(26005)(1076003)(2616005)(107886003)(336012)(426003)(40460700003)(36860700001)(81166007)(356005)(47076005)(36756003)(82740400003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 08:41:28.7243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff88c200-9426-4780-5d15-08dbea6da7a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4351
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

Add below test cases for mii commands:
mii_info -To display MII PHY info
mii_list - To list MII devices
mii_set_device - To set MII device
mii_read - To reads register from MII PHY address
mii_dump - To display data from MII PHY address

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
 test/py/tests/test_mii.py | 68 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 test/py/tests/test_mii.py

diff --git a/test/py/tests/test_mii.py b/test/py/tests/test_mii.py
new file mode 100644
index 000000000000..b213df3e3f2e
--- /dev/null
+++ b/test/py/tests/test_mii.py
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0
+# (C) Copyright 2023, Advanced Micro Devices, Inc.
+
+import pytest
+import re
+
+"""
+Note: This test doesn't rely on boardenv_* configuration value but they can
+change test behavior.
+
+For example:
+
+# Setup env__mii_deive_test_skip to True if tests with ethernet PHY devices
+# should be skipped. For example: Missing PHY device
+env__mii_device_test_skip = True
+
+It also checks for MII PHY device exist or not, it skips the test if PHY device
+does not exist.
+"""
+
+@pytest.mark.buildconfigspec("cmd_mii")
+def test_mii_info(u_boot_console):
+    if u_boot_console.config.env.get("env__mii_device_test_skip", False):
+        pytest.skip("MII device test is not enabled!")
+    expected_output = "PHY"
+    output = u_boot_console.run_command("mii info")
+    if not re.search(r"PHY (.+?):", output):
+        pytest.skip("PHY device does not exist!")
+    assert expected_output in output
+
+@pytest.mark.buildconfigspec("cmd_mii")
+def test_mii_list(u_boot_console):
+    if u_boot_console.config.env.get("env__mii_device_test_skip", False):
+        pytest.skip("MII device test is not enabled!")
+    expected_output = "Current device"
+    output = u_boot_console.run_command("mii device")
+    if not re.search(r"Current device: '(.+?)'", output):
+        pytest.skip("PHY device does not exist!")
+    assert expected_output in output
+
+@pytest.mark.buildconfigspec("cmd_mii")
+def test_mii_set_device(u_boot_console):
+    test_mii_list(u_boot_console)
+    output = u_boot_console.run_command("mii device")
+    eth_num = re.search(r"MII devices: '(.+?)'", output).groups()[0]
+    u_boot_console.run_command(f"mii device {eth_num}")
+    output = u_boot_console.run_command("echo $?")
+    assert output.endswith("0")
+
+@pytest.mark.buildconfigspec("cmd_mii")
+def test_mii_read(u_boot_console):
+    test_mii_list(u_boot_console)
+    output = u_boot_console.run_command("mii info")
+    eth_addr = hex(int(re.search(r"PHY (.+?):", output).groups()[0], 16))
+    u_boot_console.run_command(f"mii read {eth_addr} 0")
+    output = u_boot_console.run_command("echo $?")
+    assert output.endswith("0")
+
+@pytest.mark.buildconfigspec("cmd_mii")
+def test_mii_dump(u_boot_console):
+    test_mii_list(u_boot_console)
+    expected_response = "PHY control register"
+    output = u_boot_console.run_command("mii info")
+    eth_addr = hex(int(re.search(r"PHY (.+?):", output).groups()[0], 16))
+    response = u_boot_console.run_command(f"mii dump {eth_addr} 0")
+    assert expected_response in response
+    output = u_boot_console.run_command("echo $?")
+    assert output.endswith("0")
-- 
2.25.1

