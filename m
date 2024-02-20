Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E0FC48BC4
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 07:42:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F30C87F8B;
	Tue, 20 Feb 2024 08:42:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5ZqXrfmB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F08BA87CAB; Tue, 20 Feb 2024 08:42:13 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::630])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5C8987F60
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 08:41:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilTWd97LO2cEAx51uMNI1K+shwG9VR5bP8Kl7acYbrbgvz3dvqL5xtX8b8HYacKrf4TkJQHjVp4grKntvHQqkWD4TfUabHweGX962Oez0nqQ5/r4K52F0S4lN3NL56wV4L0BWEDctzpa7DnzHXCAG3zdmz6RC39wvW7Ost1Zqu5/ZnOo97m49Eon8n1krG83wE72xUabh0YHga4oNYZvTKJkEOs+MJwvCSlMy3wh8kwWdzxPNp1OpxLGMGU1sdyv11fLvMaiXXcKmUM0l0UlgeHmROPLHXyuXhy5Cz9goOO81S4XT9ECykP/ZLfLWJBda5bOoo9jk7wQmRCL23oIag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYnEbjxkpHmUfjFl5IO1c/Rr77f7ovTlLFUoFy+U+9k=;
 b=VUWjJAnvQsQDH1T9Pg20hSWj6PzoQRMT5JRM5S5K4O23a0o3hycJmowRA3j2G58/r1iDoA+/vZ4yzZ+0+FkhBrEsJcgYMkLQkynHd2IIFG/XBcm+agGfbpKRNv/GGauX3HijJoxuVnmJ/HOM6DIX30k+LLJ7O7K5MSO81us+qCG7vkvaHGQtWm5aNp6iV1AV1vKUFRVefw+0A8k9RiqYcvuiBYTeA2JhPz+feXoUfPVOtPA9SfqbIuSJhCGz9GypL2fNnVMHBIoXkuzRXXmC2i6wL8mXRpH80NRdtHKgNQ2NcyFg3wRRzq9PUcyE9vaV+XKx5OL7lHtMVu38ljYbFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYnEbjxkpHmUfjFl5IO1c/Rr77f7ovTlLFUoFy+U+9k=;
 b=5ZqXrfmBRa8hD4A0Lj7CQMPseFVDg4hks07DRl92ZhXtFxVWAXCOwkVTzoa3Op262WPJpimEdmp1Mkt1LBSspwtIYFodtQP6xFUuSn3mh73pFLPMcD6ofN44hTbanp6VcyVPeLqDtRg2KefLXZtZJn4oW40P+H7b4dt2p9+B7YY=
Received: from CY5PR18CA0030.namprd18.prod.outlook.com (2603:10b6:930:5::32)
 by BY5PR12MB4036.namprd12.prod.outlook.com (2603:10b6:a03:210::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Tue, 20 Feb
 2024 07:41:52 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:5:cafe::bc) by CY5PR18CA0030.outlook.office365.com
 (2603:10b6:930:5::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Tue, 20 Feb 2024 07:41:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 07:41:52 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 01:41:51 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 23:41:51 -0800
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 20 Feb 2024 01:41:49 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH v3] test/py: saveenv: Add a test for saveenv command
Date: Tue, 20 Feb 2024 13:11:49 +0530
Message-ID: <a206af0d5844af9b68d315e6e667db782fc5211b.1708413969.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|BY5PR12MB4036:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e3fe23-7e41-437e-7e2a-08dc31e7676b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PhDWBDZlsF9VzOg/1vlslf6mFM/o6JTbSrVZG/CTeW19Ii7C/6oQK4R56rh9oeY2AlWxVSykhLxnht7FGIhKl0a+m46wMJQEq3F5ZGsLlKmFatvpEyypiCyfi2JbfvGHafQdi2N4XpGrnef7vv0m4yO1rkGCUMu7EWMveJBhsYQ5O3Fj7rBnhuNeKDhFAr//MdKSHL2DBeBdoREoOt1o9LcwcAJNv7LyoEpSmc/8e+Fpaxy2/3VGA5AFPYWV3uFg5aUS+9zT0jb5OXHL0wQU6GI5T40SITVBiKgaAMzEJVUQecCErvNF+bYl+ELa3tGLXBeBsgedybrLYgKaPCLHAT62vpqbHoF4+Rmd639EO7zwl4NRQ5M9aCMroX4ZwO90EF8ogmCHTQ8iYv4T96hxvs0MflX5xIGndkH8e4A6AqvLTh6jrRJn1Yh1rlobTqA0IqoQHxdC6LJBiSzbLUdRFz+KOH21Txw3AnVGUaM+dXm3aoeNvLCVaGS1T3TvQ3aQQdE3gyRQlIL6+MattXuzQVed5ledbFuJ0wIMnPc03RvayUU+TDhHCXNETVznzIMbonzFPzMAoMQkhDS+twUsy30wV+8bAZRCU0GnN22qHqQw6cwUKXZ9R42XLBokzfcOO/nOb81EYMwuNkm/low4VNSEjwpF0knwdLCFB0V+tn8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(230273577357003)(36860700004)(46966006)(40470700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 07:41:52.1134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e3fe23-7e41-437e-7e2a-08dc31e7676b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4036
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
---
 test/py/tests/test_saveenv.py | 136 ++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)
 create mode 100644 test/py/tests/test_saveenv.py

diff --git a/test/py/tests/test_saveenv.py b/test/py/tests/test_saveenv.py
new file mode 100644
index 000000000000..fa0863f6d314
--- /dev/null
+++ b/test/py/tests/test_saveenv.py
@@ -0,0 +1,136 @@
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

