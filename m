Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5A1C4829A
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 12:57:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8AC087D64;
	Tue, 13 Feb 2024 13:57:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x1poE6vk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 462D887D66; Tue, 13 Feb 2024 13:57:19 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98BB487D23
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 13:57:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2O4iKuN3Zxqex0CO79K/TcqUC3Cy6sZJWF958NY6DPcEqDLYEoHy7mY4b4iAZL+yyfgmnIFggf6iUbB8axpkUlMsM18eoApD5ts4GyPh/i7Ar+aM/T2f+rQOipV2XikKOcYd4llpzi0UasFZOFtzku3QolY+WDPeA4L3F+BWNk9WPS7va1nmenc17vveDFLcgEez5+CV0HBIRPK5SYkxQmQ0E6f0cgDgo8BBGH3rGhhzg2Uu609XcA6TNjKWEwKHqFmKlprsVo+wexIZRK5iEuhuHTRMI8Qi8RjHMDS3cj9+k3D8LSJj56758toEAJTVfDP86pY06J5+VKWAT83EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apAr4Opv71FViUkRVZ9LcAVMv19AYSxULzfTO0HwrOw=;
 b=oQFjRLP7rjkxww0pt3wpQLHfBN04W48zK2wAZZZ94RpUgzVCmHmCQ0MHE3jT3XINNqpfZgSeG85M6zMXgXj+8jBX/y6ZNPRf5G0LWjCPFIUCAhjTwuNeeTNlkA9D0AAXjWUConJC0dDkzvsGMetJXFQKuMs3lPPppFBD3HAZmx/TvbLnyt+29A6hqkIfUzf2THQTpM7JowOfaIdkYqJG/aTJUtYbDdn5Q9svPXpNn1Q97qnscCcSO8L94hlaoeB0zxGnQSCCNoMqSyW3vgqEHA+5QbdSK8ZZN243NS2I07YD/LA9Kw9orb44yEcTg7vWD81OjQ/lgVGEAWoZOFHq5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apAr4Opv71FViUkRVZ9LcAVMv19AYSxULzfTO0HwrOw=;
 b=x1poE6vkvY3TBo9kym1du8Mg/j/14BpiCKqNSwji4Dr219sOBuSjZikpafTJm8CrRrUQXiYyHjiX1u1L/zmySb5rdEf/d/1AoU06VytuS8D+pvClpQwi2kvPF0SH+wpTuLJJ4p2RGYdrP4fT8iHliCjEdTae/FNX3J+HJqKzJew=
Received: from CH0PR03CA0325.namprd03.prod.outlook.com (2603:10b6:610:118::31)
 by IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.21; Tue, 13 Feb
 2024 12:57:04 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::7) by CH0PR03CA0325.outlook.office365.com
 (2603:10b6:610:118::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.37 via Frontend
 Transport; Tue, 13 Feb 2024 12:57:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 12:57:04 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 06:57:03 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 06:57:03 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 13 Feb 2024 06:57:02 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH v2] test/py: reset: Add a test for reset command
Date: Tue, 13 Feb 2024 18:26:56 +0530
Message-ID: <3fe83c9fc262878367d9cfbde31e44b133edbd10.1707815050.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|IA1PR12MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: cea2508a-5955-4812-adf1-08dc2c934718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XmDMbLBC1Ar1RO2+u6Dm3BpK5DH7XP1aHx4uW5Vpy7mLg43p6eaEEWGJIRqojLz6X/pHQP8k8GDh6zJE9gwrWh5qeWiCR+RTPyiNFdkEeDJxwsis2NCe5GJhJVou8dFknjdcYkzylQ2xfuX4iRpZRlL3XjQRs1hDj457x7yV983Pk2zG11+z7MOqdGhj45pwhkq36sE/9C38rbReZ5B38i7dx++CdeKb4e3eGNtcsFAD19+sUg0qMpCCxJbVv+VZMqNdrOMF8S9CKg2RKKI0C3fpt/FYYgFOx6LrBYZxhrAvB6WXqSQvYzz7WL/4Iqokjo3VF+JB2j/HDPdHzXSFY2aJldSIc7B0Yn+S5wEmkARB+8LQkkf2q5JRCeqdVXKZQ9cWGuRdAMlP2rqFyCjIKijE4r0JlEZQkmy0BDteX71+Oy1BVO5mbWhMYG/rMTcDfTPXXN4wSv2xK+XA88N/HfxycEnVkxRDvG4UZpoCq6p9cufJ1JZ4U5bmwUWoYwLHXwNhMtyxeQQC0errhc/paqr+xkhDy8S0MEdqsJWFpWp2CmCRoPyAmHtAl5HRs1QHwRbe8NdZVwKlUIXWVeQSEN10gn68IRWpUnW+aqhX/Qk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(2906002)(36756003)(44832011)(81166007)(70206006)(86362001)(6916009)(356005)(5660300002)(26005)(336012)(426003)(316002)(54906003)(107886003)(82740400003)(6666004)(4326008)(83380400001)(8676002)(8936002)(2616005)(70586007)(478600001)(41300700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 12:57:04.3757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cea2508a-5955-4812-adf1-08dc2c934718
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017
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

Add a test for reset commands which performs resetting of CPU, It does
COLD reset by default and WARM reset with -w option.

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
Changes in v2:
 - Set bootmode through boardenv if modeboot is not defined
---
 test/py/tests/test_reset.py | 63 +++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 test/py/tests/test_reset.py

diff --git a/test/py/tests/test_reset.py b/test/py/tests/test_reset.py
new file mode 100644
index 000000000000..6153a6d3e4d2
--- /dev/null
+++ b/test/py/tests/test_reset.py
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0
+# (C) Copyright 2023, Advanced Micro Devices, Inc.
+
+"""
+Note: This test doesn't rely on boardenv_* configuration value but they can
+change test behavior.
+
+For example:
+
+# Setup env__reset_test_skip to True if reset test is not possible or desired
+# and should be skipped.
+env__reset_test_skip = True
+
+# Setup env__reset_test to set the bootmode if 'modeboot' u-boot environment
+# variable is not set. Test will be skipped if bootmode is not set in both
+# places i.e, boardenv and modeboot u-boot environment variable
+env__reset_test = {
+    'bootmode': 'qspiboot',
+}
+
+# This test will be also skipped if the bootmode is detected to JTAG.
+"""
+
+import pytest
+import re
+import test_000_version
+
+def setup_reset_env(u_boot_console):
+    if u_boot_console.config.env.get('env__reset_test_skip', False):
+        pytest.skip('reset test is not enabled')
+
+    output = u_boot_console.run_command('print modeboot')
+    if 'not defined' in output:
+        f = u_boot_console.config.env.get('env__reset_test', None)
+        if not f:
+            pytest.skip('bootmode cannot be determined')
+        bootmode = f.get('bootmode', 'jtagboot')
+    else:
+        m = re.search('modeboot=(.+)', output)
+        bootmode = m.group(1)
+
+    if 'jtag' in bootmode:
+        pytest.skip('skipping reset test due to jtag bootmode')
+
+def test_reset(u_boot_console):
+    """Test the reset command in non-JTAG bootmode.
+    It does COLD reset, which resets CPU, DDR and peripherals
+    """
+    setup_reset_env(u_boot_console)
+    u_boot_console.run_command('reset', wait_for_reboot=True)
+
+    # Checks the u-boot command prompt's functionality after reset
+    test_000_version.test_version(u_boot_console)
+
+def test_reset_w(u_boot_console):
+    """Test the reset -w command in non-JTAG bootmode.
+    It does WARM reset, which resets CPU but keep DDR/peripherals active.
+    """
+    setup_reset_env(u_boot_console)
+    u_boot_console.run_command('reset -w', wait_for_reboot=True)
+
+    # Checks the u-boot command prompt's functionality after reset
+    test_000_version.test_version(u_boot_console)
-- 
2.25.1

