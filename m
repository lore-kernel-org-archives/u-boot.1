Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCA9C61D92
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 11:58:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E98C58759C;
	Tue, 21 Nov 2023 12:58:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l30NoAxt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA550875A7; Tue, 21 Nov 2023 12:58:53 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::611])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7119D87545
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 12:58:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeFdnsKFEOYRrc5PSKdYD1oNjiYYCdnyL7sY5H6q1y4WDDjuatgdF3TnR3RHYz3vGeOrmlJGkDLS8+7YfexmD6sd0LDRH8HgS3M19GAgOp4fNrpBzssamLylEEjrZZyeUzo8clyhD8Uq401J4NpNHqtBApTezuSYutdkvQMrQKA+pUVoKHu62B+GtmNppby1ggJ1TnyasOAYHV/1PEImOVm0Qm8UqqXnHGS337OY5Vp+TiDVOf+7KQYfL/i5hTV/KJarj0g0dsk3UAMA1rEgOc9KNFVHJFB1F8CivnaUnNs9FE3FlAYTtLemWoHNNAyIKsNSyc5UaGQ1kMKjP5LVdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgwZAa48eWAUBTAIKfDy21oHufuwPOC0tPem0oHnuEA=;
 b=nXHZSQ6TXKBRcUeVP7hHFaKpVmIAF8yKrhdRialeftxNGH+v4WdWVvyevj9mNy+bThknCViC2UdLCGwYGbQeBoVLdGSHVriHxM+mlBfzeR1rmUbbBgy2AuU5niVRCILMLb+cNSoW5C+mnU2CwR+2Z3kggV7H0i1pFMqcgAnBhC9XF0msxGyhjsbd9g+lKGc6Zs7FUB1KtKTLR6jAEPJ5V6vPiZWbndBhwi0kPaILGuO2lkdiy2B74+k9+0PR4W9tDyvxtdRfSZvSvf/ysMpmRMNsDDHWxVh7MQA2/P3n9eVBu66QCRX6x1WroZx8krcT37GBkKI8virbS4YcgrP//w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgwZAa48eWAUBTAIKfDy21oHufuwPOC0tPem0oHnuEA=;
 b=l30NoAxtlJzMUjzX8vKu0QpiOUFfQtW1ZyyeVsT56miK/e47Xb2DwaG26msM72ROiDuE2XQ9blwX9j9btIfDpPRX9Gr+QXvcDc/lR0SQC04WnyARnQlNFV03SGSPDjVKnnoIUHVKuzI52JtQxlAUTwnxGtk6hLImoUfckLSbFXM=
Received: from MN2PR19CA0025.namprd19.prod.outlook.com (2603:10b6:208:178::38)
 by BY5PR12MB4113.namprd12.prod.outlook.com (2603:10b6:a03:207::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 11:58:46 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:178:cafe::21) by MN2PR19CA0025.outlook.office365.com
 (2603:10b6:208:178::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Tue, 21 Nov 2023 11:58:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 11:58:46 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 05:58:45 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 05:58:45 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 21 Nov 2023 05:58:44 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH v2] test/py: i2c: Add tests for i2c command
Date: Tue, 21 Nov 2023 17:28:43 +0530
Message-ID: <0d8e994ea619d3942ee215a8f5635627e89c3512.1700567875.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|BY5PR12MB4113:EE_
X-MS-Office365-Filtering-Correlation-Id: 81240901-6420-4a2e-9726-08dbea893758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wcdQRM6KaUeFD+rr9mfndo0gSSJBgRTmikYUNcm8zXiIawlg8+acRQRIVuyPy24sOQHOLwq6H7yTnOVPvRVT8bLC4XV+sUQ2l6qMsvQxAmjU4sOtKx/O8bo9j29Q7ZZd2ezauYUptEtovT4m2LxFGiviuVfscUNC9BCwxWJ/yxm+eoZ+z9VslJs4f9vbbseAxSiYU7Es2S1PtprzD6BE5HTV0GKmHs9VXjxP9zszuTHnjHgcmHrRWAu4fT17DCHp2PYVyfu/02aT1KcmPUjX5B1hjieBYxlHSfDHIgPUqpN+5CM+BhVM29N6+HjhvEok+Y04mXXSu5lNcyNEOb3Gdk1Co71QXKdlBrvIYQCtGubgUDKFFXZ9LJmw98gi7IiINE/FuoQ7trHnUQGc/lwrlHcx+RZtgixWCDP27eOSGhdCl2FU4qYAtlZyACzIgO5yyiJ0irfwgphx9VZQ10g+2htj8b8aZYkDP3KLdkHxSYgpgyZ3o8bMC3VZwFAWwl7LoNBw9EL0cULDqSpf4GSrXO6B4px+Pkfb0vUnMI5kqrHDwQFeAL/zCBdxIi2ImXnXJmmQHlSgT1CcdjLnzWuzaSurDbNZmLv9Gi4LtjJgiumM4DWPQ67UCv1hPSmeoHpM8HdV5UM9dg9WKqEO+z+bL39SLuuJMfKXc8J9sLloOpe0IxflISQ4v848mH8ULzIWeNJO6+YIOxCUT8INJh/xjlzk6xRYA+yVjXMscyT1nrYOWsRa255qG907vjuh/MEt/x/LKsSM4E31ojWtq3JbUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(186009)(64100799003)(82310400011)(1800799012)(451199024)(46966006)(36840700001)(40470700004)(2616005)(356005)(82740400003)(86362001)(40480700001)(40460700003)(70586007)(70206006)(6916009)(54906003)(316002)(36756003)(81166007)(107886003)(26005)(336012)(426003)(2906002)(44832011)(5660300002)(36860700001)(41300700001)(8936002)(478600001)(47076005)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 11:58:46.2560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81240901-6420-4a2e-9726-08dbea893758
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4113
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

Add below test cases for i2c commands:
i2c_bus - To show i2c bus info,
i2c_dev - To set or show the current bus,
i2c_probe - To probe the i2c device,
i2c_eeprom - To test i2c eeprom device,
i2c_probe_all_buses - To list down all the buses and probes it

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
Changes in v2:
- Take the configured eeprom value from env to read back and compare
---
 test/py/tests/test_i2c.py | 108 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 test/py/tests/test_i2c.py

diff --git a/test/py/tests/test_i2c.py b/test/py/tests/test_i2c.py
new file mode 100644
index 000000000000..75321ee2fc20
--- /dev/null
+++ b/test/py/tests/test_i2c.py
@@ -0,0 +1,108 @@
+# SPDX-License-Identifier: GPL-2.0
+# (C) Copyright 2023, Advanced Micro Devices, Inc.
+
+import pytest
+import random
+import re
+
+"""
+Note: This test doesn't rely on boardenv_* configuration value but they can
+change test behavior.
+
+For example:
+
+# Setup env__i2c_device_test_skip to True if tests with i2c devices should be
+# skipped. For example: Missing QEMU model or broken i2c device
+env__i2c_device_test_skip = True
+
+# Setup env__i2c_eeprom_device_test to set the i2c bus number, eeprom address
+# and configured value for i2c_eeprom test case. Test will be skipped if
+# env__i2c_eeprom_device_test is not set
+env__i2c_eeprom_device_test = {
+    "bus": 3,
+    "eeprom_addr": 0x54,
+    "eeprom_val": "30 31",
+}
+
+# Setup env__i2c_device_test to provide the i2c bus list to test against it
+# for i2c_probe_all_buses case instead of probing all the buses available. If
+# it is not set, it list down all the buses and probes it
+env__i2c_device_test = {
+    "bus_list": [0, 2, 5, 12, 16, 18]
+}
+"""
+
+@pytest.mark.buildconfigspec("cmd_i2c")
+def test_i2c_bus(u_boot_console):
+    if u_boot_console.config.env.get("env__i2c_device_test_skip", False):
+        pytest.skip("I2C device test is not enabled!")
+    expected_response = "Bus"
+    response = u_boot_console.run_command("i2c bus")
+    assert expected_response in response
+
+@pytest.mark.buildconfigspec("cmd_i2c")
+def test_i2c_dev(u_boot_console):
+    if u_boot_console.config.env.get("env__i2c_device_test_skip", False):
+        pytest.skip("I2C device test is not enabled!")
+    expected_response = "Current bus"
+    response = u_boot_console.run_command("i2c dev")
+    assert expected_response in response
+
+@pytest.mark.buildconfigspec("cmd_i2c")
+def test_i2c_probe(u_boot_console):
+    if u_boot_console.config.env.get("env__i2c_device_test_skip", False):
+        pytest.skip("I2C device test is not enabled!")
+    expected_response = "Setting bus to 0"
+    response = u_boot_console.run_command("i2c dev 0")
+    assert expected_response in response
+    expected_response = "Valid chip addresses:"
+    response = u_boot_console.run_command("i2c probe")
+    assert expected_response in response
+
+@pytest.mark.buildconfigspec("cmd_i2c")
+def test_i2c_eeprom(u_boot_console):
+    f = u_boot_console.config.env.get("env__i2c_eeprom_device_test", None)
+    if not f:
+        pytest.skip("No I2C eeprom to test!")
+
+    bus = f.get("bus", 0)
+    if bus < 0:
+        pytest.fail("No bus specified via env__i2c_eeprom_device_test!")
+
+    addr = f.get("eeprom_addr", -1)
+    if addr < 0:
+        pytest.fail("No eeprom address specified via env__i2c_eeprom_device_test!")
+
+    value = f.get("eeprom_val")
+    if not value:
+        pytest.fail("No eeprom configured value provided via env__i2c_eeprom_device_test!")
+
+    # Enable i2c mux bridge
+    u_boot_console.run_command("i2c dev %x" % bus)
+    u_boot_console.run_command("i2c probe")
+    output = u_boot_console.run_command("i2c md %x 0 5" % addr)
+    assert value in output
+
+@pytest.mark.buildconfigspec("cmd_i2c")
+def test_i2c_probe_all_buses(u_boot_console):
+    if u_boot_console.config.env.get("env__i2c_device_test_skip", False):
+        pytest.skip("I2C device test is not enabled!")
+    expected_response = "Bus"
+    response = u_boot_console.run_command("i2c bus")
+    assert expected_response in response
+
+    # Get all the bus list
+    f = u_boot_console.config.env.get("env__i2c_device_test", None)
+    if f:
+        bus_list = f.get("bus_list")
+    else:
+        buses = re.findall("Bus (.+?):", response)
+        bus_list = [int(x) for x in buses]
+
+    for dev in bus_list:
+        expected_response = f"Setting bus to {dev}"
+        response = u_boot_console.run_command(f"i2c dev {dev}")
+        assert expected_response in response
+        expected_response = "Valid chip addresses:"
+        response = u_boot_console.run_command("i2c probe")
+        assert expected_response in response
-- 
2.25.1

