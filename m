Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0F0C54E66
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 08:48:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9140287CAC;
	Tue, 12 Mar 2024 09:48:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4JonBwtm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 181EF87DFF; Tue, 12 Mar 2024 09:48:47 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BDA48792D
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 09:48:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvnExZTtN97udinPZ/1ihGgTw8PTHf9JuR8jObgFM1N7yo60ynNPNBvU9OTVMVMzAhbXZHcjFMvB5pYu/zT5JzZv03ozuQzy1dsz2G7eRTmuB5XuvH7Nvr4XBdZOqwW50tW+A7HH9/cJscwpcFFN0I9oPmPEXlTCaFnAXEgCf2qPhmRhbRAIIIAf/7Bt+zF+c4k60p76UnZCJhq8ZPpxT6ELpUefULO3iKghPz5PGI8lxEo6p7rAlea+9ZZNQqcy3Wk3lwk6CpXQB0McXKySPAnaLlm5EfIptKx579LVh30+T7J7FTN70Y5tIOCia2nB2L6bYr3KpY1sV741gf3KOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObYa1H6gd3Ch+G1+eEgkudD3MnlxQXDp2pjcdOn5qhY=;
 b=U2ytcY5B4c8UZ8DQzTjidvnGnynq4Dne80wlsJ7q6+Mt66yUe0fRUR3ejUhCwGjBM1kq86pDSJgONdPF01fMx8eLSS+0S9lIcOrjy50sYvC6tN/CK08dTOzaIsfMHWBhEkeW8arEzPzE5J5jaMqqa/J/pfALEYHWbuPY9grDu5cQCtyEp0q+p19wHzbJE+brP960KkLvvX7L8eWn6Kw8CDnnvRdj6WDQJGFg8Paa9jGTm+jTUCUdsuDDc6Qw65AmC9WMQaZfMaEr2Y016Vx1FZQZBJmWsACchSgSfctQvK49q//PpZsAwfTg35wvavzd0IffVfgVGZbsFtWSZtVDnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObYa1H6gd3Ch+G1+eEgkudD3MnlxQXDp2pjcdOn5qhY=;
 b=4JonBwtmOOijuSs6aFpQ2p8bKBWuqXW85ZKtStH7/sRiCnhisL58UVf7Re/jv39Cc8nuz4SRj56biqNGjQqXy/93oGX1OAyjxa1mmHvd16ulDC7fpbaVNhe9A9FWYqBwsILnJlEvKjQ1euFOF3Hzv5lH61WhRQH//YsSf7EU7wI=
Received: from MN2PR02CA0008.namprd02.prod.outlook.com (2603:10b6:208:fc::21)
 by DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 08:48:41 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:fc:cafe::1e) by MN2PR02CA0008.outlook.office365.com
 (2603:10b6:208:fc::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.37 via Frontend
 Transport; Tue, 12 Mar 2024 08:48:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 08:48:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 03:48:40 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 03:48:39 -0500
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH v4] test/py: reset: Add a test for reset command
Date: Tue, 12 Mar 2024 14:18:33 +0530
Message-ID: <043a52451c0e2d40f3da316a942236b27e21741c.1710233282.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: love.kumar@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|DM6PR12MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: bc0590c0-54b8-485a-46f5-08dc427137aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WcSb0A0f99xfY48p/fl4opqrA5K1UQ7t8VIY1776Qp5D69KfqTgUgCMcnFHKAHP0nchrETMwMwW4fAhWOlZA5NJn/OldcmEmeC22IGZg/PusF96tzXlUHy8qVE75xbDinkSEW6lShHfvjVYgwF89eMeHJlZYbjz/45314t7taDDkRGurYdp0CbfQS/S1RO3+Fhsz5Xd3w/UcwTZ/4ISl3/tEO9EVs82xVu0Q9mdxIh0vu1POzGHgRJ3mVy50AZOdlmMfOu8THWiOMc0vly4/jDZ4hDLf9VqWeNmsMloqTukR6Lt9MKd8/Ok7M0ka+/hA0/5nAiG5+k4OMdl3ervYDESk6pp9r5xSnRXe0gbGhgPoUV0UzoB/9gYsQI031JWrTq9DPC8pPdHtZW0lGdwaTozMc8zummFWQdLoQVSGI0qukzrGqITNU5/MUsuyA3Okjt/wDORyETtelzRxpBEU289mszewik5dN7DJVKD/aeVlFbF6rbotq2sMwJteQnhTxyZMx9WxU+tsGs2JroK3HTUKtHN9a2TcJncWWJQCA/iIvQun1e6rISTDraW0/0PhycpGz84XQ8KqSUXoujW8hblVjySzr90IyLumGi7mggi5ll7rBMtKpy/RY/R/u6/dHO2ZrddRftpW4d693zJOtI2tshBIxuNitu0kiMu2zYZv1YSxyxvLf3aqJvhn6lXvzzKQd2SKBmnZhy4jRWJfVUzPbpgg2zNAG0lZYbXn7mT1vOHAcz3+Kb/t3uV73TZ9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 08:48:41.1942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0590c0-54b8-485a-46f5-08dc427137aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4186
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
Changes in v3:
 - Fix the issue with bad pattern found on console
Changes in v4:
 - Add dependency with hush parser to support variable expansion
---
 test/py/tests/test_reset.py | 63 +++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 test/py/tests/test_reset.py

diff --git a/test/py/tests/test_reset.py b/test/py/tests/test_reset.py
new file mode 100644
index 000000000000..00fc31da57d1
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
+import test_000_version
+
+def setup_reset_env(u_boot_console):
+    if u_boot_console.config.env.get('env__reset_test_skip', False):
+        pytest.skip('reset test is not enabled')
+
+    output = u_boot_console.run_command('echo $modeboot')
+    if output:
+        bootmode = output
+    else:
+        f = u_boot_console.config.env.get('env__reset_test', None)
+        if not f:
+            pytest.skip('bootmode cannot be determined')
+        bootmode = f.get('bootmode', 'jtagboot')
+
+    if 'jtag' in bootmode:
+        pytest.skip('skipping reset test due to jtag bootmode')
+
+@pytest.mark.buildconfigspec('hush_parser')
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
+@pytest.mark.buildconfigspec('hush_parser')
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

