Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0CDC4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 05:36:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BD4987BB4;
	Fri, 19 Jan 2024 06:36:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ncP1L5w7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13E2B87BBD; Fri, 19 Jan 2024 06:36:56 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A26A87B5F
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 06:36:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j61JAudzyj+hnhBViTmKV6ujU1kv98KREK0TITjVqVDNqlidvqNyMr7QijAAPImLWGVYk7wCxzXQ26laiIpMPfQse3lQM1JtB/MWkFm4z3ShNMyGptwlsvqWIC0KBwXKnU4TW71k2mpTSrvljTZvFA0IDcKVlaSKLCyp0Ey6bVVPGu8KjZTopp00VVlHUJQ+YTehbIb3doC2IUVX4PXM0ro9b6OtvaJw5vnOl2vO/c5uQ8vhi6GNJm7XLv4X5BtAprukv68TOAxkhBe2kjYTYutLFtGMvJ3IUc43Ez7hXb8QgnmqGGBqmf6da5mvKx24lf5vGolIu9XYk+Mk0rMkmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RhVJ0+9OOYDfcErDxjazcUW1VsFcZfq2jwznjJH728=;
 b=nAj1mvZHgSDjLVEAgbVYAvIrIK9hIG2W2QiHPn9xj+gESJZZh9e7FnYZulnkaF53aEB4AgwlQKQCLdWdwnvCNcNVAmMTFvoC0tpdy9C7vv4H29+6kCpgOtabYhEULsBTp4dJLuFofr7nNLxjz2K1IpH8OPeYj416rtV4WCu6xth/CmsOLSzjv4kIZrR5v4czVLwG9Sx8NxerDoAl7JntHdfHU+FxrFwVULps9z1GSYmuGHz/WZQyvLnceEIU3W4W7BpcQ80SLMJYFod9izvdROI82VDyXkg+7MUHv0CaSH7x50hgGtL25EkeF7Wr3XCIHzMe5OttYOoQjQh6Pcx2fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RhVJ0+9OOYDfcErDxjazcUW1VsFcZfq2jwznjJH728=;
 b=ncP1L5w7ZEpsQ4dJee3VhhfB1E1Z8GfscXNLKxgYZc86pXZa3DIBMbuuvQFkGMVFJC4S5lAkFsV8hvuJIVvKIJgilwadYJ6z1LQBdAGXTANryi8GyqTZWdnuZr3QaTRsvQzXEmcCPtZld6dyeasX2TzTFZL2Vx9FUxq2WtChG2w=
Received: from CY8PR22CA0007.namprd22.prod.outlook.com (2603:10b6:930:45::15)
 by DM4PR12MB7527.namprd12.prod.outlook.com (2603:10b6:8:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Fri, 19 Jan
 2024 05:36:50 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:45:cafe::64) by CY8PR22CA0007.outlook.office365.com
 (2603:10b6:930:45::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Fri, 19 Jan 2024 05:36:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Fri, 19 Jan 2024 05:36:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 23:36:48 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 18 Jan 2024 23:36:47 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] test/py: zynqmp_rpu: Add test for loading RPU apps
Date: Fri, 19 Jan 2024 11:06:41 +0530
Message-ID: <b71639dcb9a59d45e23248aa3ae6de2492a7909d.1705571560.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|DM4PR12MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca0251c-d704-4681-fb8c-08dc18b0a272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A68h5L9l6OYl++wj6ZeGIM6+MMKwVM2sz8ASaGwSlUKDzZpO7dXn6nNxUHbiV/AQIYxgKrWwVR2m8BIg5dl0+N3fePLGssGWdkXYmoKowxqzk2wG0/dNP+49GdnV14GKlceXbfbi/BYV0NioRc/ce7g0QSNhxqEGgnkAlhjdenylnNKx0YKxIgdd3hYGedbTQPLO8bz+UATAn+0gnw4xFOra8tG4Jdx6MERc1FGivQcUg7K7uWDle8JhoLbTQl1QTzjybNGfIqombODSTcPZXyCHEnKmbd30mf60TdBXPw4awERMZISejfa/zZemsaPdyd3K4NHG1nW2GamLkgowOW4wYMa2wIvHb0qOKocKuruphxQQUmxgxHI3l8wFbZIpVdLWSjNgKQk1Gf5px+PRgcHvIOyD4anYq2C3qptwOp+B33FfxU7XURdX4/k2qgvK7BKjpSv+4xivlcrxDDI6Cc4WY7LHEPEoCnaaVygzutqpfzue3RWuYfD6Maq00AftkgvUUu+JuQIPEv/OpYN5hKRZBII6Vxcvdqe7FsONstAA1tTbImb/l7URQdjOhVgd3S/tUT7EyNmLW9Rv+16tQyOleL7mi6ayX+jja6IMpaLU+IQXl1hKCDKdlFs2ILziLDqPpGupsfSJuVgl44g3/C6tt3mX9ywZf7deUxxtM73owwhHSffDMW32jfhlDY1dyIH92gCovSzDRHqmqac42ETos7JLPvofhXcMVy465NQHII9vAtcXzfZrmR4YJ78yiJUETgeGan8eeGe/EnadlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(40470700004)(36840700001)(46966006)(4326008)(26005)(44832011)(426003)(5660300002)(2906002)(336012)(6666004)(107886003)(2616005)(316002)(70206006)(70586007)(8936002)(8676002)(6916009)(41300700001)(86362001)(478600001)(36756003)(36860700001)(356005)(82740400003)(47076005)(83380400001)(81166007)(54906003)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 05:36:49.7429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca0251c-d704-4681-fb8c-08dc18b0a272
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7527
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

Add testcases for loading RPU applications in split and lockstep mode
including the negative one for AMD's ZynqMP SoC.

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
 test/py/tests/test_zynqmp_rpu.py | 208 +++++++++++++++++++++++++++++++
 1 file changed, 208 insertions(+)
 create mode 100644 test/py/tests/test_zynqmp_rpu.py

diff --git a/test/py/tests/test_zynqmp_rpu.py b/test/py/tests/test_zynqmp_rpu.py
new file mode 100644
index 000000000000..479a612b4ec2
--- /dev/null
+++ b/test/py/tests/test_zynqmp_rpu.py
@@ -0,0 +1,208 @@
+# SPDX-License-Identifier: GPL-2.0
+# (C) Copyright 2023, Advanced Micro Devices, Inc.
+
+import pytest
+import random
+import string
+import test_net
+
+"""
+Note: This test relies on boardenv_* containing configuration values to define
+RPU applications information for AMD's ZynqMP SoC which contains, application
+names, processors, address where it is built, expected output and the tftp load
+addresses. This test will be automatically skipped without this.
+
+It also relies on dhcp or setup_static net test to support tftp to load
+application on DDR. All the environment parameters are stored sequentially.
+The length of all parameters values should be same. For example, if 2 app_names
+are defined in a list as a value of parameter 'app_name' then the other
+parameters value also should have a list with 2 items.
+It will run RPU cases for all the applications defined in boardenv_*
+configuration file.
+
+Example:
+env__zynqmp_rpu_apps = {
+    'app_name': ['hello_world_r5_0_ddr.elf', 'hello_world_r5_1_ddr.elf'],
+    'proc': ['rpu0', 'rpu1'],
+    'cpu_num': [4, 5],
+    'addr': [0xA00000, 0xB00000],
+    'output': ['Successfully ran Hello World application on DDR from RPU0',
+               'Successfully ran Hello World application on DDR from RPU1'],
+    'tftp_addr': [0x100000, 0x200000],
+}
+"""
+
+# Get rpu apps params from env
+def get_rpu_apps_env(u_boot_console):
+    rpu_apps = u_boot_console.config.env.get('env__zynqmp_rpu_apps', False)
+    if not rpu_apps:
+        pytest.skip('ZynqMP RPU application info not defined!')
+
+    apps = rpu_apps.get('app_name', None)
+    if not apps:
+        pytest.skip('No RPU application found!')
+
+    procs = rpu_apps.get('proc', None)
+    if not procs:
+        pytest.skip('No RPU application processor provided!')
+
+    cpu_nums = rpu_apps.get('cpu_num', None)
+    if not cpu_nums:
+        pytest.skip('No CPU number for respective processor provided!')
+
+    addrs = rpu_apps.get('addr', None)
+    if not addrs:
+        pytest.skip('No RPU application build address found!')
+
+    outputs = rpu_apps.get('output', None)
+    if not outputs:
+        pytest.skip('Expected output not found!')
+
+    tftp_addrs = rpu_apps.get('tftp_addr', None)
+    if not tftp_addrs:
+        pytest.skip('TFTP address to load application not found!')
+
+    return apps, procs, cpu_nums, addrs, outputs, tftp_addrs
+
+# Check return code
+def ret_code(u_boot_console):
+    return u_boot_console.run_command('echo $?')
+
+# Initialize tcm
+def tcminit(u_boot_console, rpu_mode):
+    output = u_boot_console.run_command('zynqmp tcminit %s' % rpu_mode)
+    assert 'Initializing TCM overwrites TCM content' in output
+    return ret_code(u_boot_console)
+
+# Load application in DDR
+def load_app_ddr(u_boot_console, tftp_addr, app):
+    output = u_boot_console.run_command('tftpboot %x %s' % (tftp_addr, app))
+    assert 'TIMEOUT' not in output
+    assert 'Bytes transferred = ' in output
+
+    # Load elf
+    u_boot_console.run_command('bootelf -p %x' % tftp_addr)
+    assert ret_code(u_boot_console).endswith('0')
+
+# Disable cpus
+def disable_cpus(u_boot_console, cpu_nums):
+    for num in cpu_nums:
+        u_boot_console.run_command(f'cpu {num} disable')
+
+# Load apps on RPU cores
+def rpu_apps_load(u_boot_console, rpu_mode):
+    apps, procs, cpu_nums, addrs, outputs, tftp_addrs = get_rpu_apps_env(
+        u_boot_console)
+    test_net.test_net_dhcp(u_boot_console)
+    if not test_net.net_set_up:
+        test_net.test_net_setup_static(u_boot_console)
+
+    try:
+        assert tcminit(u_boot_console, rpu_mode).endswith('0')
+
+        for i in range(len(apps)):
+            if rpu_mode == 'lockstep' and procs[i] != 'rpu0':
+                continue
+
+            load_app_ddr(u_boot_console, tftp_addrs[i], apps[i])
+            rel_addr = int(addrs[i] + 0x3C)
+
+            # Release cpu at app load address
+            cpu_num = cpu_nums[i]
+            cmd = 'cpu %d release %x %s' % (cpu_num, rel_addr, rpu_mode)
+            output = u_boot_console.run_command(cmd)
+            exp_op = f'Using TCM jump trampoline for address {hex(rel_addr)}'
+            assert exp_op in output
+            assert f'R5 {rpu_mode} mode' in output
+            u_boot_console.wait_for(outputs[i])
+            assert ret_code(u_boot_console).endswith('0')
+    finally:
+        disable_cpus(u_boot_console, cpu_nums)
+
+@pytest.mark.buildconfigspec('cmd_zynqmp')
+def test_zynqmp_rpu_app_load_split(u_boot_console):
+    rpu_apps_load(u_boot_console, 'split')
+
+@pytest.mark.buildconfigspec('cmd_zynqmp')
+def test_zynqmp_rpu_app_load_lockstep(u_boot_console):
+    rpu_apps_load(u_boot_console, 'lockstep')
+
+@pytest.mark.buildconfigspec('cmd_zynqmp')
+def test_zynqmp_rpu_app_load_negative(u_boot_console):
+    apps, procs, cpu_nums, addrs, outputs, tftp_addrs = get_rpu_apps_env(
+        u_boot_console)
+
+    # Invalid commands
+    u_boot_console.run_command('zynqmp tcminit mode')
+    assert ret_code(u_boot_console).endswith('1')
+
+    rand_str = ''.join(random.choices(string.ascii_lowercase, k=4))
+    u_boot_console.run_command('zynqmp tcminit %s' % rand_str)
+    assert ret_code(u_boot_console).endswith('1')
+
+    rand_num = random.randint(2, 100)
+    u_boot_console.run_command('zynqmp tcminit %d' % rand_num)
+    assert ret_code(u_boot_console).endswith('1')
+
+    test_net.test_net_dhcp(u_boot_console)
+    if not test_net.net_set_up:
+        test_net.test_net_setup_static(u_boot_console)
+
+    try:
+        rpu_mode = 'split'
+        assert tcminit(u_boot_console, rpu_mode).endswith('0')
+
+        for i in range(len(apps)):
+            load_app_ddr(u_boot_console, tftp_addrs[i], apps[i])
+
+            # Run in split mode at different load address
+            rel_addr = int(addrs[i]) + random.randint(200, 1000)
+            cpu_num = cpu_nums[i]
+            cmd = 'cpu %d release %x %s' % (cpu_num, rel_addr, rpu_mode)
+            output = u_boot_console.run_command(cmd)
+            exp_op = f'Using TCM jump trampoline for address {hex(rel_addr)}'
+            assert exp_op in output
+            assert f'R5 {rpu_mode} mode' in output
+            assert not outputs[i] in output
+
+            # Invalid rpu mode
+            rand_str = ''.join(random.choices(string.ascii_lowercase, k=4))
+            cmd = 'cpu %d release %x %s' % (cpu_num, rel_addr, rand_str)
+            output = u_boot_console.run_command(cmd)
+            assert exp_op in output
+            assert f'Unsupported mode' in output
+            assert not ret_code(u_boot_console).endswith('0')
+
+        # Switch to lockstep mode, without disabling CPUs
+        rpu_mode = 'lockstep'
+        u_boot_console.run_command('zynqmp tcminit %s' % rpu_mode)
+        assert not ret_code(u_boot_console).endswith('0')
+
+        # Disable cpus
+        disable_cpus(u_boot_console, cpu_nums)
+
+        # Switch to lockstep mode, after disabling CPUs
+        output = u_boot_console.run_command('zynqmp tcminit %s' % rpu_mode)
+        assert 'Initializing TCM overwrites TCM content' in output
+        assert ret_code(u_boot_console).endswith('0')
+
+        # Run lockstep mode for RPU1
+        for i in range(len(apps)):
+            if procs[i] == 'rpu0':
+                continue
+
+            load_app_ddr(u_boot_console, tftp_addrs[i], apps[i])
+            rel_addr = int(addrs[i] + 0x3C)
+            cpu_num = cpu_nums[i]
+            cmd = 'cpu %d release %x %s' % (cpu_num, rel_addr, rpu_mode)
+            output = u_boot_console.run_command(cmd)
+            exp_op = f'Using TCM jump trampoline for address {hex(rel_addr)}'
+            assert exp_op in output
+            assert f'R5 {rpu_mode} mode' in output
+            assert u_boot_console.p.expect([outputs[i]])
+    finally:
+        disable_cpus(u_boot_console, cpu_nums)
+        # This forces the console object to be shutdown, so any subsequent test
+        # will reset the board back into U-Boot.
+        u_boot_console.drain_console()
+        u_boot_console.cleanup_spawn()
-- 
2.25.1

