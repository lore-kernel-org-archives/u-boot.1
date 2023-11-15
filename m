Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF41C07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 06:38:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D7EF86863;
	Wed, 15 Nov 2023 07:38:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KP5Xrvqb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3E7A86C3B; Wed, 15 Nov 2023 07:38:53 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::616])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F0D7867E2
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 07:38:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfilDsjMge91kV5uUcWm0TbMIMnQNL3WDtLafER0i9u0Mub9dMcjUUQ7eaul+9tVa+FFsr/BQ46g0u21H1sNQNm/eWybKNAF9H2r2VQVUJseqtaXS9iqdGvugCYXLkokZBf9zEIddBnsaoFen4MWmVzG7s00uBBcyo4WUA8oydopW+wxfta9SOe6BqJOSfouRD5N6BfvX/RMwN+yzFz5BtS0gLCS9/GT9wc1zmo24BYnU1KR2hlkIql0+oFkwRSuqkJ8B65O+bytICKXopqBWMWhrK3zWpOuHImasIEjBtMHtz0eE6h5Bzzok2c9I6JyfK8+b3BVejPk8YmYD6jRwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Envrl0TvVfmIk+nU+JVdP5Oy77R3UQh4tFbKgSG57sU=;
 b=n/OjkdHZKrPsQ7T7KO74m4KvNMTsY9UE1V4aro0iC0iHMFqz1KNnz5dzhThRUooVyJmqOGVQC28PtKpbsXxcz/GGDzx1Cf8fAfRMizdXsVrUg/ASJ6yGLElQsBLOMZM5SrhujO4IrpJ64WFDcDLlKXsUJmVCdTV84wTtcH8brNSxhQnyAcxWWuBMu0c7D8I0aCOjsCTeTsJ9hAmTOPu3wab/BKwyoFvYYq1ryG0ANj8zHmKKYOtx9iLtoFe0lOILWYgR9WAJLQ9FLG0/WKFvaoHsMOopt/btns7VE9d18r9PHXq+wE5qGmoBe71BrrGRTDJH1LoX/nC+LkZ//tImJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Envrl0TvVfmIk+nU+JVdP5Oy77R3UQh4tFbKgSG57sU=;
 b=KP5XrvqbAiEaVYRn8kCJj3XmvXUfDtWQai4L+HwbjXm7ET4/fhFzBO4lDj4uNSOvrOJk1YHod1Z2NEn6m0snE+6VgqVLYBZEAXWQVdN1N6M/DJP1Km+92ctFGPh2RdlRqt2z9NSFj1U4EryxMHPAwFg26VYUlmn7Eqv3bt6nDTU=
Received: from DS7PR03CA0051.namprd03.prod.outlook.com (2603:10b6:5:3b5::26)
 by DM4PR12MB6589.namprd12.prod.outlook.com (2603:10b6:8:b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 06:38:46 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:5:3b5:cafe::fb) by DS7PR03CA0051.outlook.office365.com
 (2603:10b6:5:3b5::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Wed, 15 Nov 2023 06:38:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.19 via Frontend Transport; Wed, 15 Nov 2023 06:38:44 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 00:38:43 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 14 Nov
 2023 22:38:40 -0800
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Wed, 15 Nov 2023 00:38:39 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] test/py: i2c: Add tests for i2c command
Date: Wed, 15 Nov 2023 12:08:38 +0530
Message-ID: <5a86ff75b3ca210227e3a2a1d034afadce9ac209.1700030275.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|DM4PR12MB6589:EE_
X-MS-Office365-Filtering-Correlation-Id: 90af7ad6-6c68-48e6-8cc1-08dbe5a58392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tQzA6vuN2HPOmSsTw9orAJeykG3Di+z0gcvYeeIdqoFo3bQkhBsF4BEakwwKuZbh+YQ/xrmzeuxuU6raVmCrvGMWiUNb3ifSNTCZ1j3kBDOu6zlwEk3PEQi76zty/EvtluqjjRpJu7ddvTWtb/stYaDlF27ICOYCMPUx1acoficy72Of2cMwbZWvm4vpapVPurUu6iqnKo0dZkmDwq4/9kFOsthHFs179CuOi82sYUcT1q0j+qPWngHiz6489B7wgF7btgOlN9CAvvsmpk14Qq6eL1uf5WfkVx20FdBMpgLGlSbuCsTGGQJZ27wrPHcoOqMTzNili5uKm55q7QCxXYtzungr9SuwyQwE6BEokt3Wza0DNQlzKGOnCcOHRzNZY4OmfM9YVbZN3uzU87zw/d3Upk405/s5qIphgGOULlCW2RS2qJPKTdx2mz0F0goKq+i96nSQpeB6pxp5iQv/YHtBDNx/Wk60At0OBV1NkvDyurxbvsXOwI6NEmvt+JW9p5znM5nSeV+78lMY098yuay0NdKx5BQTb45yAzA0gD76ml9HAutNc9VTf/EaffXtfs7M6CRBY35QzTcEPJ0MbAPLRA0PFjWAJt0UyTHiPSaFJf61lyBOGRGS9lAeAa0MG/pFa4HUh8EoogZ1AjVqSA+HQYPjNKFK4RMdn9kXd1n/KfNgalGWgsuNbpGxU0bJBxaZ14O11o6G0sjm9K0fKvSPyFHoeDFoS/LfjTszD/7SiImVHYtb0Fj1uhMf6AWBv9V3/dSsW9IMXL0qieUjLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799009)(46966006)(40470700004)(36840700001)(2616005)(8936002)(426003)(336012)(82740400003)(40460700003)(26005)(107886003)(478600001)(44832011)(86362001)(36756003)(41300700001)(5660300002)(2906002)(4326008)(70586007)(70206006)(54906003)(6916009)(316002)(8676002)(40480700001)(356005)(47076005)(36860700001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 06:38:44.2060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90af7ad6-6c68-48e6-8cc1-08dbe5a58392
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6589
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
 test/py/tests/test_i2c.py | 107 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 test/py/tests/test_i2c.py

diff --git a/test/py/tests/test_i2c.py b/test/py/tests/test_i2c.py
new file mode 100644
index 000000000000..d4f533a3ba5e
--- /dev/null
+++ b/test/py/tests/test_i2c.py
@@ -0,0 +1,107 @@
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
+# Setup env__i2c_eeprom_device_test to set the i2c bus number and eeprom
+# address for i2c_eeprom test case. Test will be skipped if
+# env__i2c_eeprom_device_test is not set
+env__i2c_eeprom_device_test = {
+    "bus": 3,
+    "eeprom_addr": 0x54,
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
+    # Enable i2c mux bridge
+    u_boot_console.run_command("i2c dev %x" % bus)
+    u_boot_console.run_command("i2c probe")
+    val_int = random.randint(0, 255)
+    value = format(val_int, "02x")
+    u_boot_console.run_command("i2c mw %x 0 %x 5" % (addr, val_int))
+    expected_response = f"0000: {value} {value} {value} {value} {value} "
+    response = u_boot_console.run_command("i2c md %x 0 5" % addr)
+    assert expected_response in response
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

