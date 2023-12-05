Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBBEC4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 12:03:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67FD886FA5;
	Tue,  5 Dec 2023 13:03:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bH3D71Ob";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AB2F86FCE; Tue,  5 Dec 2023 13:03:01 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::622])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 035FA86F26
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 13:02:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6rPeEnhX4DobPomajWs1hErV9I4kr8QxcqmG/+VnflIbY4hC4kLgMNcf+HKjRwX/eSP5DHBZ4UZRDpAjbikV6TETeO/88T0SYXfDUE/EkvqGqAOkRH90VpHYeAo0s73BOr4WgH28XRSzD723pteucMAbuvjQC7nNUauGjoDNiK2OJB87lY06bUUDGhIklWUlQoQ23A80fy2fdJQljY77XnjU5RWVJjXxZxT7ik7karsyoFt/XHqdrgkihui45QqKkakVh9CI063An0j8nctPhdNOfGTR04/Q7WvZqn6vxb74aaVqp1SWAHZUHySFgINUCkRb4SnVfRU0DSWVMQFgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/k1Hs4q05RY0T76PjvARz2foFLpdYZhTr4521dj6wPQ=;
 b=kpfpnDyn80zQTS4As5foy45NmXbYQQZgirJSnnHB+fydWaQBm6MdA7gBSVboXZxaPBCcm0jaeqED7gyAJIjVHQv1s+ZrHAzfSnW1GuACH1u7/jHtsWJ8DhiEfIlLDJzE9+hEp2wOcQQEWR7YBYOnnYouCE27miaEBo4AbZ6GO1cU/fxh8EGUlaGXKH0ADdSMhpQeagy/RCweD0dvU24xxbDWPUGGG/8m+2Yqg7zm0MegBHTukaM3rPt7UZUAIJdFX5f/phGmVNGtWGYQYV/dXi0gUtTJ8zMnLFrPZCZGPLtXxTTM5fNVw5Kf65ainR5NPw/DoQdqvDgyy/Hc5p7abQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/k1Hs4q05RY0T76PjvARz2foFLpdYZhTr4521dj6wPQ=;
 b=bH3D71ObJUAZziM2SRxh5cbLs/GAxohLLjUZbDVFZhKL7BONNSxN3j+PS3ER2wFShxLrn+fGPKSc55IpwTlErVIAa3KvMENnpKbY0GZoZSiRxpuc2CTEcBK+yjo1HIE5tXzLIvJy2HMuM89LuE1ywKpEK1fZScteEUDmbqDsg9k=
Received: from PH7PR17CA0028.namprd17.prod.outlook.com (2603:10b6:510:323::8)
 by IA1PR12MB6115.namprd12.prod.outlook.com (2603:10b6:208:3e9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 12:02:55 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::1) by PH7PR17CA0028.outlook.office365.com
 (2603:10b6:510:323::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Tue, 5 Dec 2023 12:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 12:02:54 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 06:02:44 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 5 Dec
 2023 04:02:19 -0800
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 5 Dec 2023 06:02:18 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH v2] test/py: mii: Add tests for mii command
Date: Tue, 5 Dec 2023 17:32:17 +0530
Message-ID: <92d06d89e2d2d6b1738c62453789872dcb6bfa92.1701777713.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|IA1PR12MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ef647e-221a-481d-208e-08dbf58a1d42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0nnxJ5sjUE/5whmVaLEDVfycN8POqwc7vuMJXvapcrPsiUVAoLlJamup+KZGX6s5P4wxwTEwsorWPtOcmp/qNBVbtdfGRFJVe1jhDu4uAWcoi/g2Sf6O3ImjGPsddakEgeJm+QAQo08LitcnAiJlpwJ+yq/qWEsK4YhD5HsfRbeKIEcjC5RbbYsai++DbMaa1e6whFSz3oTdC5JdT39xOvHAyuWyIOmBI4b6sNVGuTV1R0JJtADxd44L7c3Tfy3XftX7Nc0rlwYIl1TejrAmRYfqWGsmP7rRQtnkpb49ECV9UoYNcbiCs/o3Iu+GO79Y5HXB5eJjarBIkIRLMDhZ351ehWRXnjo55kf7UI7xj0qi3FGt6KsoWYW689sCnDelOQuhHZLY3MsJeiz/TqQ2oh88uwhIxWuQOfAl76rAdSjZT8eT8a6WavezZ+3QHWtH6v7Du4Wt+PeoWy1IuuuDxiZAAhlOuahLlOhXatJVPavch2q2G2nwlsd3q57kYvmNz2hJXfj2Tikx+2WEUhQ9+42doE9TV/g48CE7j6Y88muvhGqV2thZyDVWxojKuLu6FJK4YNT59ba1ktxV5UMfEidQYhNFl7C2Zv1q8KXlxAImBiUA0icDRMObZaIsCOQtelGrBaf4C5ZioQqrdBkZ1kEFXdfOv1rjfxWWYAo7KdEpF4kjovgkNpF6W2gheqix0ogM5CsnxMGrplgt3SSa7HqwW+hu6n2qOBD7aC8S+v6UCd6Ma7cSLPKsMu8YLg9V6wSo2OG5dtk5yLHAUbiBgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(36840700001)(40470700004)(46966006)(40480700001)(36860700001)(44832011)(2906002)(316002)(6916009)(54906003)(86362001)(70206006)(70586007)(8676002)(41300700001)(8936002)(4326008)(36756003)(356005)(47076005)(5660300002)(82740400003)(81166007)(83380400001)(478600001)(40460700003)(426003)(336012)(107886003)(26005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 12:02:54.7440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ef647e-221a-481d-208e-08dbf58a1d42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6115
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
Changes in v2:
  - Get MII device list from env instead of auto-detecting it
  - Set the MII device to its current device after testing so that it
  won't impact next cases
---
 test/py/tests/test_mii.py | 92 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 test/py/tests/test_mii.py

diff --git a/test/py/tests/test_mii.py b/test/py/tests/test_mii.py
new file mode 100644
index 000000000000..e9bdbadffc8e
--- /dev/null
+++ b/test/py/tests/test_mii.py
@@ -0,0 +1,92 @@
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
+# Setup env__mii_device_test to set the MII device names. Test will be skipped
+# if env_mii_device_test is not set
+env__mii_device_test = {
+    "device_list": ["eth0", "eth1"],
+}
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
+
+    f = u_boot_console.config.env.get("env__mii_device_test", None)
+    if not f:
+        pytest.skip("No MII device to test!")
+
+    dev_list = f.get("device_list")
+    if len(dev_list) == 0:
+        pytest.fail("No MII device list provided via env__mii_device_test!")
+
+    expected_output = "Current device"
+    output = u_boot_console.run_command("mii device")
+    mii_devices = (
+        re.search(r"MII devices: '(.+)'", output).groups()[0].replace("'", "").split()
+    )
+
+    assert len([x for x in dev_list if x in mii_devices]) == len(dev_list)
+    assert expected_output in output
+
+@pytest.mark.buildconfigspec("cmd_mii")
+def test_mii_set_device(u_boot_console):
+    test_mii_list(u_boot_console)
+    f = u_boot_console.config.env.get("env__mii_device_test", None)
+    dev_list = f.get("device_list")
+    output = u_boot_console.run_command("mii device")
+    current_dev = re.search(r"Current device: '(.+?)'", output).groups()[0]
+
+    for dev in dev_list:
+        u_boot_console.run_command(f"mii device {dev}")
+        output = u_boot_console.run_command("echo $?")
+        assert output.endswith("0")
+
+    u_boot_console.run_command(f"mii device {current_dev}")
+    output = u_boot_console.run_command("mii device")
+    dev = re.search(r"Current device: '(.+?)'", output).groups()[0]
+    assert current_dev == dev
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

