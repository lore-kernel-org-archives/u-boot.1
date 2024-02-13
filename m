Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51BFC4829A
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 12:57:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B07687D82;
	Tue, 13 Feb 2024 13:56:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VOGc7wEx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9FAB87D66; Tue, 13 Feb 2024 13:56:55 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4764A87D66
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 13:56:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpEej0e8Ql51RCDu3Zeup1VvSwstahUYSYhEnB0E/2h5EicJsIDFjs4yWj6y8BIbEv9Hm5RqncdFBCzrLfbGwFIE5heW/gudCFd5Ugh2QvDMNSRU10hOogb8AWkOiWbcCHRjDMF6Z7XxN2CFvInmEsie1pxXGFIJ1ltL9Vu8xI/Oyr3T2NdmkTM7vQCpiTfuEnR4lN5aYyhWO3irY2sU/35RXrunxS1lTr3KpF2H9oT/MgD0nYgKJ4z6U+zmRbRVpkAkpVr/4bt0dZX+45LBr67k5UdKp/CR87gLKaULZQRkGuaPbZ1IqPlyTgfmHcpz0DcMr8CSwuynIw4UMOgAYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okyBZHvNrBtFJPYjsQxsnb8986NHgYu4535ufjxPNaE=;
 b=Y+lv6XuGmyUebmFyMVCYF+7N1Bl7etyC/mDgTPQ8nW0JYqcXmbTP2og409eC59P3AjyD3tyGai8WnSgE9QLcKQBXsXH3YH3qZj+rb9AqiK2Chk1Z+pKIzeuyX6qon58fYK6GR1iVNBEntogTQWDYIY/DecvvQLmP2dmpx77BFkqc3AjO4n6NV+LqvgqxglITVWg24+GJvtwCYXl7ndgmbwASUcG6U+FczbANjgS8WZzA4KlSpq3E8Si2Vt/l4UUsnj4d6VjOEPAF5lcUU3M/qYQUwDLXuIIP8r4WDKWRxbyWyhp39HMsbFzfnhTt2Z+w0ujbKoYOauu5wX+dsDwj6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okyBZHvNrBtFJPYjsQxsnb8986NHgYu4535ufjxPNaE=;
 b=VOGc7wExMctHsIiFxSlOC5y1bcCiDav+MvTEc6O0cppfea+2kR7hZbkVh29862HrFqDevaA8lvqjsiI7G8W3MQN3j5Fy3INwG62FnqVvGKJw184m9EddW5xtuMr9k2mgHuGPTDQTo6c+nT1n1ZMEdMySOlD2q2uLVWHabKLEm+M=
Received: from BN0PR04CA0006.namprd04.prod.outlook.com (2603:10b6:408:ee::11)
 by SA0PR12MB4509.namprd12.prod.outlook.com (2603:10b6:806:9e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 12:56:48 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:ee:cafe::f4) by BN0PR04CA0006.outlook.office365.com
 (2603:10b6:408:ee::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Tue, 13 Feb 2024 12:56:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 12:56:47 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 06:56:47 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 06:56:46 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 13 Feb 2024 06:56:45 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH v2] test/py: saveenv: Add a test for saveenv command
Date: Tue, 13 Feb 2024 18:26:44 +0530
Message-ID: <9ad8684f92d8c1b5e821c6b755c73925eff36e19.1707818884.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|SA0PR12MB4509:EE_
X-MS-Office365-Filtering-Correlation-Id: b54ada52-3744-4cf1-15e3-08dc2c933d10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +5quhK3Vemu2NQYH8nHDMX4xhUBxRv5Q6kRqUaFcxfgNRavXFRhTgaj++ggSuAnYgTKiw2EBtKxXEA+V8FgTkhYKXWREqjEf7kYvrydyRrM7B3tEQoYOYSGDcleMLfizFLoNPEwphZRlN+pmzs9tpdok+Sw33l97QTfqiFqKI7xogfzK1jIsg28xTMBep2HK+2VZY29dltEkdWCe9Kcl8mp/4lDpZwvhuKF7QSG6LCtfjrxr3dMdx0X6/jGoXvTnzoBbpXZBDDbFleSl9bmtzV5Om8LKRU4PEcZm35kH758awgM3WL44MUAZHxgtCE+aElJPxJZNOozfjJU4LaUrFy/sULdSBQFm1wFg85zhYOgr8ekcXdNlUYkZTaVMgRti/z3US/jlR78INw7AZkPA8PjtRKAHYSeN2DtPm2ExsXwyBEh08maYzMx85nviyuUhFW3QPb05n6zAkRzilN1qv65gM9+Vr9WiOKNAITIAh/DU8ROYbSWfOHYkriThgBmHKtvf0p2x4XeSyacPjXyL8D7PSziGLV8DPffHbBPR4wRO8VY7G7t6Uw5ifJJfMSVpCcxAUjlf7rxoLr3pQUCKaxKuy/KUR7RYdg8zLP5OkeI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(36756003)(41300700001)(478600001)(2616005)(107886003)(83380400001)(26005)(426003)(336012)(70586007)(70206006)(5660300002)(4326008)(6916009)(8676002)(8936002)(81166007)(54906003)(316002)(86362001)(356005)(82740400003)(44832011)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 12:56:47.5735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b54ada52-3744-4cf1-15e3-08dc2c933d10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4509
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
---
 test/py/tests/test_saveenv.py | 138 ++++++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)
 create mode 100644 test/py/tests/test_saveenv.py

diff --git a/test/py/tests/test_saveenv.py b/test/py/tests/test_saveenv.py
new file mode 100644
index 000000000000..cac854d82bab
--- /dev/null
+++ b/test/py/tests/test_saveenv.py
@@ -0,0 +1,138 @@
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
+import re
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
+    output = u_boot_console.run_command('print modeboot')
+    if 'not defined' in output:
+        f = u_boot_console.config.env.get('env__saveenv_test', None)
+        if not f:
+            pytest.skip('bootmode cannot be determined')
+        bootmode = f.get('bootmode', 'jtagboot')
+    else:
+        m = re.search('modeboot=(.+)', output)
+        bootmode = m.group(1)
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
+    sc = "!#%&\()*+,-./:;<=>?@[\\]^_`{|}~"
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

