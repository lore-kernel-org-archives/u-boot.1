Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2246C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 06:45:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAFFD86EF3;
	Tue,  2 Jan 2024 07:45:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j0Swy1M3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0927786F28; Tue,  2 Jan 2024 07:45:02 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EB0286BF7
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 07:44:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8IniIfYIa6o7znOmPEaXkQUKWxMwkF5xsdVqaxZN5Y2t+e+6fvCuVJDwjNlj+VzzOonAM4H86YyM3YfnweIAEnaXOQ7zdII60waZkpRCrlQtK32TPpHFpKNuK9CaNU0hxrooB45WZ+k3/Cj9ZeW7Yh+Rx+od9fcUYta05l60cYQPEzUnTF6NOUrh5tqH7T6tQEg7Sz94CYmohwV59kR7TvxqMZ16qKivSgPmz8IkBLyGijsPOlZ51xVUbhtcSgVX/gs5v2drMRt+k18TgrOu4Fa0zQd4peC8Kcvw5wu7kPRIZ6+IcpJNN9kkrhIxknM1TIEp2B4qGrhWhVooWOq0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOQZzEs1DZuvFDZee9upuikNPChPaE0CgPFXHS34B8U=;
 b=frBuJTxRtRjxBChc6zApYrXi9HT5CFquauxH9vCUD1rGzaoqpEiHE4iPtuzUPkYHSVOJBvd9P968BOxNsdAWUaeiMFvn4dTIMdNdbtTvW0/HxGIAXH78plQmZYlpUsJ9U5DyScVuQxnY716ooW0tdJRw9u48MGhwIrcPqg7ohXx/WXxGzcE9phFwPSx0m9b8+9zhPzgaVUPYe9IhZh+rgII48dtFhYOMCxMpLlS6hVIOa/UuNeLeinpvLPOsacg2WDDpvkFMFCJ43k6lCii8zflSi8btM8HBD0xe04l4P+iPCDtMEPhoOFJ30kZ7EPere/VXtU3xxOtDj+Ge9mnnjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOQZzEs1DZuvFDZee9upuikNPChPaE0CgPFXHS34B8U=;
 b=j0Swy1M3hpbMrsEWU8q/EVg9LZIwnu0DuT4sk+3tQShxwk8dbfUuwlFa23CkrqpdqNts+8ZMihpgVTJSEuDLSdrtn2ASk8z/ONQXeTSsE+SQ36O7M5rp76gdfMHYdY0sojLBr+OEpdkbq3y0YuylOFTZyBaphaqpe4ZqLdyUNW8=
Received: from BL0PR02CA0100.namprd02.prod.outlook.com (2603:10b6:208:51::41)
 by DM4PR12MB5183.namprd12.prod.outlook.com (2603:10b6:5:396::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 06:44:53 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:51:cafe::67) by BL0PR02CA0100.outlook.office365.com
 (2603:10b6:208:51::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20 via Frontend
 Transport; Tue, 2 Jan 2024 06:44:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 06:44:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 2 Jan
 2024 00:44:52 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 2 Jan
 2024 00:44:42 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 2 Jan 2024 00:44:41 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH v3] test/py: mii: Add tests for mii command
Date: Tue, 2 Jan 2024 12:14:35 +0530
Message-ID: <a6b464aff98b7ddcfa076c2155a1be51beec8583.1704177781.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|DM4PR12MB5183:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b89c37-3bda-4b08-2533-08dc0b5e532c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IARPJCQl+Q4rGK/uvnc7YJkPOpmemBhxeyzBXQmiW6cPyt5XRWdBAUukn/j235nbCD9PY7gE5mMhAL38+vb5TVHHUAKj/zoTQWh6Uel7X0cf+Qq5xqqiqDsLlCc5tu3uEDkLyXOtZwrl5Z5j6oqUAplkEHXBDor7WOSWSROgJpOgc1mUtY06XNcoe7Lf2LRH1MfAgH/222hbp9L8rYUdFuiCs/VvtICjflwVj5nEmi2oHU5ixBBJVRqT4CHILnBIKBN2VNOSO8KtvlK/L5vZdh+tbivEd+icsOuUt5GZuNhGnZor2cIMgXpNsHwnExXhOCf2e+A5IZhOBgeFi7L0DuiCYzaux17Now7hqgOcd6nIimsqDQmSgFkPzyZU1GAPDsQ0m79nJalapG9c6isHnOQPsS9gFcDsLgthf3pZv0e15oOwAOJFF/bS3heHhYJcmKxhU1yO10qIKu49gNuwpomcSaxgAZ8muIW4bgio26+rHqH8EAF3bM4/Dtdy3ue6wOseCqCdGgJkx0/DnramQ+A8zbbA2R8T1Hnym1b2udyT7IzCtQvEAOkckgutMwydGIlIaEIPVoKGs1dV8l51f51Tt8gSK+9AQsrOogQUuRx3u75BKXBmBgk+vwHcmCNI3iuN9MWZAQENO21t/Vtm9VHyZ2Ddk8FLD3W11iCsUyeSnVCZIUtzWdHsCjC0DKawQGkmHHBkxgY0BYYWHwmR/mQ6ZHtTnOxOZFOHFyWmoB0c+EHuiqhWZfVryU5a5ZBsrgXWu4VhLpTON2kJSkIe2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(36840700001)(40470700004)(46966006)(316002)(478600001)(8676002)(8936002)(4326008)(54906003)(6916009)(70206006)(70586007)(83380400001)(47076005)(36860700001)(6666004)(336012)(426003)(2616005)(107886003)(26005)(44832011)(5660300002)(2906002)(41300700001)(36756003)(82740400003)(81166007)(356005)(86362001)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 06:44:52.9532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b89c37-3bda-4b08-2533-08dc0b5e532c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5183
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
Changes in v3:
 - Use single quote in env to maintain consistency
---
 test/py/tests/test_mii.py | 92 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 test/py/tests/test_mii.py

diff --git a/test/py/tests/test_mii.py b/test/py/tests/test_mii.py
new file mode 100644
index 000000000000..7b6816d1089e
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
+    'device_list': ['eth0', 'eth1'],
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
+    if not dev_list:
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

