Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC395C54E66
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 08:46:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01DA787CAC;
	Tue, 12 Mar 2024 09:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GLBIzP+o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F71787D70; Tue, 12 Mar 2024 09:46:20 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8D6D8792D
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 09:46:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=loq06gaxqCFhLMj2PJnZMlzqnyr1WED3YkCGUpLb0vsjOv3nh+5W2ev7FI2kgRwSfQYJ25WFZNTkDSrbggxjPOpZNQxFeWd021SeBVGHFt+LHWMt/+o/zmZV8SscGHckv/GbM/zBenHVOkpCE6RooI5OTL+nDNLUquNKkJc2iSuYu3ReQzLl6fKvvX6Su1hWaF0svRUgylLVX9MDBIRM5hUzpgKwgBD8rPRumZjzPyNDA9mzjN/jQ9O0Zu9yBRMOZ6oj4hyMGk/bxZ8WcuMQoCFHZSd3hG8adJnFkg87PTGQlziLZqBXR2JN55PWRTiiU37xSL0XaGqd8aUSMpnoLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvPPTvmag0B+RLJVSlE3rMpqEEB5VRVTqcxfbr1k9Do=;
 b=QPr2qQ1N8gWFpeyVduzIGUAaOj+SQ0eJ2Wn90fSz6jK+JKfOH73BxKJXnX6kaDbrGNG+HltundkQz/b0gKSN5AUL1F0j9gNkRULTgsfkIpsMdRnLnQduEYLSuHKMnXAd+5kOGVoTu3w1cwDMo1mPFzjaCaaxQD+X4lWU6cYGuWdNsU4KheN9PTUUjCTMlBrW+ihE7pRAAxzGn4wX0KFrAzGtumE7PmE/wAy71njQPcrN5FWHuD45uqM1NxiS2aTJCgOV9wdrgP9nc5AThfXWmuQmr/mtDUHPxzz2v1KYR19So14Orf6W7HRcYiGyhp6b9mna1VDTxt5U/JqZIzj+yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvPPTvmag0B+RLJVSlE3rMpqEEB5VRVTqcxfbr1k9Do=;
 b=GLBIzP+ofRgOmXZKX92v3wr1dkuR59O3ZqGcvGlRtQ8M/yxy2rVqWiKfEOWdLi3Yez7FvfkQFgf1eSQpvI0wFzJWVKs1g9QBiQvopNr5CuoolngyZZzrw3Ady9JFYXk49hYrm8KJ2pDYwRdnw98ESINPgLn8hbmm8r8GhjTfOC0=
Received: from BL1PR13CA0162.namprd13.prod.outlook.com (2603:10b6:208:2bd::17)
 by IA1PR12MB6553.namprd12.prod.outlook.com (2603:10b6:208:3a3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 08:46:12 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:2bd:cafe::b9) by BL1PR13CA0162.outlook.office365.com
 (2603:10b6:208:2bd::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17 via Frontend
 Transport; Tue, 12 Mar 2024 08:46:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 08:46:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 03:46:12 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 03:46:10 -0500
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH v4] test/py: saveenv: Add a test for saveenv command
Date: Tue, 12 Mar 2024 14:16:10 +0530
Message-ID: <e5be61472f03d771eba78625469a851363b0efba.1710225217.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: love.kumar@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|IA1PR12MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: 260d7279-a6c4-4e4a-87b0-08dc4270df2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A1cbx0tiTMXvnrtUsIubpmh63jA323sBDcd3eC1cE6TAWIjlo6f4x1NRQTC58aypZFWB5yNetKAMiC20uGxe2aJk6B26TMGfeC/G/TdDpXhPMRsaZygKr+ITZ5Hk5nLNu11OuFqthGwtG1869d4WC0ux3pZikGAYYQEimf9R4kIupVkH/fa1sA+lYNzQYb/G3iqEW7s4Gbugvc6WTWf0zIqgpyiGsNLFHA2XCJtHt8EYMD8TWzoSyo//MKyIXT9OSlP2svAIOkRe8w4bATIXjBx6IsYoSbtnIhTeWTpKg+RCUml/6FRnx89CQ5c6eZYINxuyODHZgXc1kLKpJ+ivLXD3fnf2IlIJvv4hMtcRRSrNnWhoHua9H1aRKcxA78Vv8NazRjg/n5qYpz1TS7V1OKtv8+4PUrcrYAwLqPQ79ruZDGBzCp8Oh/ZrQfIAVD/Tm7sLlYPZtkJWBmBeTKPxaAHcFQltUPY1LsDtttYSAren/ALYLm4jt1P2wG9FhvZ7IeUiJl9kauqHA6d1AC94HLwNhf4iZwSDkS5zrvT3JVyQ9oSFxArC1XFodK3fVgf4MlgqfVfxRNynyYGQo+r90rZGbpNuVrodK6XBUH1skmtwVshYxuXlSLFrTWwQRvu2mJaopHvEK5CII8wJEdknz6cD4nkGnKl6LkRn6+AKasMg3EvHVYMtiAyEoZaCrdMky9odKaPmth4FrLR3Exqy45zFN9KMdQUPHmT8h5dOa25otz2CAz863R4wQSCmP5yj
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 08:46:12.7175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 260d7279-a6c4-4e4a-87b0-08dc4270df2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6553
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

Add test case for saveenv command in non-JTAG bootmode which saves the
u-boot environment variables in persistent storage.

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
Changes in v2:
 - Set bootmode through boardenv if modeboot is not defined
Changes in v3:
 - Fix the issue with bad patterns and escape sequence warning
Changes in v4:
 - Add dependency with hush parser to support variable expansion
---
 test/py/tests/test_saveenv.py | 137 ++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)
 create mode 100644 test/py/tests/test_saveenv.py

diff --git a/test/py/tests/test_saveenv.py b/test/py/tests/test_saveenv.py
new file mode 100644
index 000000000000..7faa3bdf93de
--- /dev/null
+++ b/test/py/tests/test_saveenv.py
@@ -0,0 +1,137 @@
+# SPDX-License-Identifier: GPL-2.0
+# (C) Copyright 2023, Advanced Micro Devices, Inc.
+
+"""
+Note: This test doesn't rely on boardenv_* configuration value but they can
+change test behavior.
+
+For example:
+
+# Setup env__saveenv_test_skip to True if saveenv test is not possible or
+# desired and should be skipped.
+env__saveenv_test_skip = True
+
+# Setup env__saveenv_test to set the bootmode if 'modeboot' u-boot environment
+# variable is not set. Test will be skipped if bootmode is not set in both
+# places i.e, boardenv and modeboot u-boot environment variable
+env__saveenv_test = {
+    'bootmode': 'qspiboot',
+}
+
+# This test will be also skipped if the bootmode is detected to JTAG.
+"""
+
+import pytest
+import random
+import ipaddress
+import string
+import uuid
+
+# Setup the env
+def setup_saveenv_env(u_boot_console):
+    if u_boot_console.config.env.get('env__saveenv_test_skip', False):
+        pytest.skip('saveenv test is not enabled')
+
+    output = u_boot_console.run_command('echo $modeboot')
+    if output:
+        bootmode = output
+    else:
+        f = u_boot_console.config.env.get('env__saveenv_test', None)
+        if not f:
+            pytest.skip('bootmode cannot be determined')
+        bootmode = f.get('bootmode', 'jtagboot')
+
+    if 'jtag' in bootmode:
+        pytest.skip('skipping saveenv test due to jtag bootmode')
+
+# Check return code
+def ret_code(u_boot_console):
+    return u_boot_console.run_command('echo $?')
+
+# Verify env variable
+def check_env(u_boot_console, var_name, var_value):
+    if var_value:
+        output = u_boot_console.run_command(f'printenv {var_name}')
+        var_value = str(var_value)
+        if (var_value.startswith("'") and var_value.endswith("'")) or (
+            var_value.startswith('"') and var_value.endswith('"')
+        ):
+            var_value = var_value.split(var_value[-1])[1]
+        assert var_value in output
+        assert ret_code(u_boot_console).endswith('0')
+    else:
+        u_boot_console.p.send(f'printenv {var_name}\n')
+        output = u_boot_console.p.expect(['not defined'])
+        assert output == 0
+        assert ret_code(u_boot_console).endswith('1')
+
+# Set env variable
+def set_env(u_boot_console, var_name, var_value):
+    u_boot_console.run_command(f'setenv {var_name} {var_value}')
+    assert ret_code(u_boot_console).endswith('0')
+    check_env(u_boot_console, var_name, var_value)
+
+@pytest.mark.buildconfigspec('cmd_saveenv')
+@pytest.mark.buildconfigspec('hush_parser')
+def test_saveenv(u_boot_console):
+    """Test the saveenv command in non-JTAG bootmode.
+    It saves the U-Boot environment in persistent storage.
+    """
+    setup_saveenv_env(u_boot_console)
+
+    # Set env for random mac address
+    rand_mac = '%02x:%02x:%02x:%02x:%02x:%02x' % (
+        random.randint(0, 255),
+        random.randint(0, 255),
+        random.randint(0, 255),
+        random.randint(0, 255),
+        random.randint(0, 255),
+        random.randint(0, 255),
+    )
+    set_env(u_boot_console, 'mac_addr', rand_mac)
+
+    # Set env for random IPv4 address
+    rand_ipv4 = ipaddress.IPv4Address._string_from_ip_int(
+        random.randint(0, ipaddress.IPv4Address._ALL_ONES)
+    )
+    set_env(u_boot_console, 'ipv4_addr', rand_ipv4)
+
+    # Set env for random IPv6 address
+    rand_ipv6 = ipaddress.IPv6Address._string_from_ip_int(
+        random.randint(0, ipaddress.IPv6Address._ALL_ONES)
+    )
+    set_env(u_boot_console, 'ipv6_addr', rand_ipv6)
+
+    # Set env for random number
+    rand_num = random.randrange(1, 10**9)
+    set_env(u_boot_console, 'num_var', rand_num)
+
+    # Set env for uuid
+    uuid_str = uuid.uuid4().hex.lower()
+    set_env(u_boot_console, 'uuid_var', uuid_str)
+
+    # Set env for random string including special characters
+    sc = "!#%&()*+,-./:;<=>?@[\\]^_`{|}~"
+    rand_str = ''.join(
+        random.choices(' ' + string.ascii_letters + sc + string.digits, k=300)
+    )
+    set_env(u_boot_console, 'str_var', f'"{rand_str}"')
+
+    # Set env for empty string
+    set_env(u_boot_console, 'empty_var', '')
+
+    # Save the env variables
+    u_boot_console.run_command('saveenv')
+    assert ret_code(u_boot_console).endswith('0')
+
+    # Reboot
+    u_boot_console.run_command('reset', wait_for_reboot=True)
+
+    # Verify the saved env variables
+    check_env(u_boot_console, 'mac_addr', rand_mac)
+    check_env(u_boot_console, 'ipv4_addr', rand_ipv4)
+    check_env(u_boot_console, 'ipv6_addr', rand_ipv6)
+    check_env(u_boot_console, 'num_var', rand_num)
+    check_env(u_boot_console, 'uuid_var', uuid_str)
+    check_env(u_boot_console, 'str_var', rand_str)
+    check_env(u_boot_console, 'empty_var', '')
-- 
2.25.1

