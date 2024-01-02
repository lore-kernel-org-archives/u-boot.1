Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91309C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 06:47:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9FC186EF3;
	Tue,  2 Jan 2024 07:47:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X3+j50hn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3108786F28; Tue,  2 Jan 2024 07:47:21 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01DFC86BF7
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 07:47:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEhJvof2Ojtdz/A7Ylu7qHjsOeAoPkjPW7ko5JmDlX7bsWdyyh/Wd0tS1tN36Pijv6N5PHzHe7F6rTSb0LiByqjtUYXVdWKtWNPbsfux3Md83yrKBHTAQ1uoNI+ZYJFIbFriIhHlvOiAkxqA5/9/Y4Pe/Z3JsaSDiOygaqR3T4sBICYMQQk+mb9U/SViygD5Ob9O32KxVrquUglyLzulPaVdVx0ITn2v9aEtDriqkItkr8gEsDGFOtfB12kjBvGBpIXewxY8P8R1oWbeKM74zAtlrsYH8t2SFmRQrIs2RhccjfVyh9OZl1Qi+gW8xSEDYt0TiewVCi408Ze7YeZMfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onwCvFx0vbpdnuJSjipfWHqcP/HDrfSqpjXZzMDxLgE=;
 b=PNGe1R80wiDbYISPQlcL100+9GNjW/6xT/B2JqDeZK2SEz2Jj8pT+QqRJ/5piFNTJa88Z4OUQmFzQ32eyP+/ny+spvNY0bFx1u2Mi6MpyL9MOf7tyPDw9siKi8jQ/bravk+78fPsi5swzZA0YyZmbZ4UZCmfOSz/o+PtLUEf6tbeSgy6a2xw5WWoRvuUtLOJq8ZeBYmrWNM/TO3OQk2cB+88Xj/JJiUNtPXLaoDLj3fa6D9EZBUlAFx5SK3QeyAr6I7VzmMHZfClztBXO7L20luxdX5L09OBuA4CK8Kx1U83d+XWjqaxP3YwcbLoNhvREgEPaUz+QLnp6GL5WKCMZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onwCvFx0vbpdnuJSjipfWHqcP/HDrfSqpjXZzMDxLgE=;
 b=X3+j50hn93CvjKj6IEt6lHHxL5OstiEdMPrq/RReRUFwmlgkUIty1sf38ln0YkaEu5qbT7rS7L21GACkg8SFkyl8ZdiQrdT32ItUsjD91RoXBYGop9qdLMR7sFm0eMH6NYmlO2h9euTcvLXbnUROgGpHogwHN1WicmXMf6j0pZ4=
Received: from MN2PR20CA0046.namprd20.prod.outlook.com (2603:10b6:208:235::15)
 by SA1PR12MB8117.namprd12.prod.outlook.com (2603:10b6:806:334::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 06:47:15 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::f4) by MN2PR20CA0046.outlook.office365.com
 (2603:10b6:208:235::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25 via Frontend
 Transport; Tue, 2 Jan 2024 06:47:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 06:47:14 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 2 Jan
 2024 00:47:14 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 1 Jan
 2024 22:47:13 -0800
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 2 Jan 2024 00:47:12 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH v3] test/py: i2c: Add tests for i2c command
Date: Tue, 2 Jan 2024 12:17:07 +0530
Message-ID: <f7ff13475bbd3f0471bee709dc6a805d3da5915d.1704176360.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|SA1PR12MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: 4920f99e-cb9d-4454-4ced-08dc0b5ea7b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NNIIPSqM4EgsrNr8mrVl5Zr9QrcBtQsMxaniLPYb7cx62DOapF/jSRyoAuLw4fgR4T4hzdusBfMHlgBaw0JJXhaSX/W0LKeEIB2vRN6YGYZBFwrJXxk0JXMp61nYar/IgMIpb/j8Zx6N2rwcmccxTWKNYhv9e9h9j1knjLwsWr0bxqiSDSxzB92BHoyezO7Wm8nfaVeBzFrkwG0KdxMnXNkDVBfaS8Q4zdOmNQPy+QS5e9uVTbfGBrtmrf6f00o27SmHpFUr1R7bU0cYMXXvDOW29flWZ7NbO6XVXq+GYo9kIVUtytC1xEwQwFDqhCSMjBGAoKhrR5enp08LlffK+WCYxOB3TIyXJyy3V5iRdZHG3V7SZ5ZF3d9PgR0qMmTs/e8W4COj2DmgoXZYvcgnvg7Q6x5/wKn1CrabOLKI/PFyArVqHkWkgskS5SvWezc+LiuYZz/H+7U/WWeQffEL+H6HJxFbhwyGidcQiknsQWLXqhZzhKYfYM8a0jwLt3kLdMvUp3B0buZtNNu1OgROwoaUEMmLW9SZycjRWD+++pctzWwtYuoQIbktujeRS5J4QbtoDfv36k50q2bH//R9rwlEypiMtUaWzw22FwLSTjo9wRa4R0kFOW8pdE2MciM8HbjvrNntWJLjuqytXqBwbm61/jHyjGqzHxgLt8zx61RuBUYbV0WKCScwec8fd0DJAdZjGFD93YC9utPrLAi/u27mswA+1i7EgIdbrNbzhGw3gBCOBQf73Iu2luCwfntu6WY5wMVoFlC+JJ8UrwctOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799012)(36840700001)(40470700004)(46966006)(5660300002)(2906002)(4326008)(8676002)(8936002)(44832011)(316002)(54906003)(6916009)(36756003)(86362001)(478600001)(40460700003)(40480700001)(41300700001)(6666004)(107886003)(426003)(26005)(2616005)(336012)(356005)(81166007)(47076005)(70206006)(70586007)(82740400003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 06:47:14.8003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4920f99e-cb9d-4454-4ced-08dc0b5ea7b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8117
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
Changes in v3:
- Add test env dependency to run it for provided i2c bus list
---
 test/py/tests/test_i2c.py | 116 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 test/py/tests/test_i2c.py

diff --git a/test/py/tests/test_i2c.py b/test/py/tests/test_i2c.py
new file mode 100644
index 000000000000..825d0c2e6eb7
--- /dev/null
+++ b/test/py/tests/test_i2c.py
@@ -0,0 +1,116 @@
+# SPDX-License-Identifier: GPL-2.0
+# (C) Copyright 2023, Advanced Micro Devices, Inc.
+
+import pytest
+import random
+import re
+
+"""
+Note: This test relies on boardenv_* containing configuration values to define
+the i2c device info including the bus list and eeprom address/value. This test
+will be automatically skipped without this.
+
+For example:
+
+# Setup env__i2c_device_test to set the i2c bus list and probe_all boolean
+# parameter. For i2c_probe_all_buses case, if probe_all parameter is set to
+# False then it probes all the buses listed in bus_list instead of probing all
+# the buses available.
+env__i2c_device_test = {
+    'bus_list': [0, 2, 5, 12, 16, 18],
+    'probe_all': False,
+}
+
+# Setup env__i2c_eeprom_device_test to set the i2c bus number, eeprom address
+# and configured value for i2c_eeprom test case. Test will be skipped if
+# env__i2c_eeprom_device_test is not set
+env__i2c_eeprom_device_test = {
+    'bus': 3,
+    'eeprom_addr': 0x54,
+    'eeprom_val': '30 31',
+}
+"""
+
+def get_i2c_test_env(u_boot_console):
+    f = u_boot_console.config.env.get("env__i2c_device_test", None)
+    if not f:
+        pytest.skip("No I2C device to test!")
+    else:
+        bus_list = f.get("bus_list", None)
+        if not bus_list:
+            pytest.skip("I2C bus list is not provided!")
+        probe_all = f.get("probe_all", False)
+        return bus_list, probe_all
+
+@pytest.mark.buildconfigspec("cmd_i2c")
+def test_i2c_bus(u_boot_console):
+    bus_list, probe = get_i2c_test_env(u_boot_console)
+    bus = random.choice(bus_list)
+    expected_response = f"Bus {bus}:"
+    response = u_boot_console.run_command("i2c bus")
+    assert expected_response in response
+
+@pytest.mark.buildconfigspec("cmd_i2c")
+def test_i2c_dev(u_boot_console):
+    bus_list, probe = get_i2c_test_env(u_boot_console)
+    expected_response = "Current bus is"
+    response = u_boot_console.run_command("i2c dev")
+    assert expected_response in response
+
+@pytest.mark.buildconfigspec("cmd_i2c")
+def test_i2c_probe(u_boot_console):
+    bus_list, probe = get_i2c_test_env(u_boot_console)
+    bus = random.choice(bus_list)
+    expected_response = f"Setting bus to {bus}"
+    response = u_boot_console.run_command(f"i2c dev {bus}")
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
+        pytest.fail(
+            "No eeprom configured value provided via env__i2c_eeprom_device_test!"
+        )
+
+    # Enable i2c mux bridge
+    u_boot_console.run_command("i2c dev %x" % bus)
+    u_boot_console.run_command("i2c probe")
+    output = u_boot_console.run_command("i2c md %x 0 5" % addr)
+    assert value in output
+
+@pytest.mark.buildconfigspec("cmd_i2c")
+def test_i2c_probe_all_buses(u_boot_console):
+    bus_list, probe = get_i2c_test_env(u_boot_console)
+    bus = random.choice(bus_list)
+    expected_response = f"Bus {bus}:"
+    response = u_boot_console.run_command("i2c bus")
+    assert expected_response in response
+
+    # Get all the bus list
+    if probe:
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

