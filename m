Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCDCD6DDF2
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 12:02:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E1F3892CD;
	Fri, 15 Nov 2024 13:02:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eezN7RbO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B99589334; Fri, 15 Nov 2024 13:02:22 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93AA888E00
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 13:02:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N97O5d5KdPM7oZMdoIEyv6jNUe4JgleSWJqBXndoNiZIk96QMcNHEjwyB7819Xss501CouMmPY/JewVu2lzcCuw/FPOzBeGmv5Fd7cFMbDlkY1D7YZ+qzCtVnsPO9FfloBpkBeKbZ0YfW+7g0nwrbMQDkBJ3tPfwg2QlUsuu5FzmbofvkbSjFObfrzqhVU7HngRh56nYtAHHSB6Q13hxyOzZWoIwQ4sVm/sxXMjV7twvzV14E1dSRnCmc2GTE3Thbd7NWR2y/14y3Q+IT9r71ZEzJkL3rVtaPEY+Nvo6e/Z8RYPrPfTqvA06kgBnhONJ3vJhzrLi9rpnN+hAWByP5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OR4AiOdLNV0pKVUWll2qX3IlvjNajKxLrOoeVBmDrjk=;
 b=uvcvF5gyezTygbVqwIn/0USjOBW9RwZBu7FUAP2V4c+x4qcqfW5iiF3YTh6DPUw+TfL6nJ803rnRfeJRyOhzu6N1F4TQVNXb9JFXVlxTsMOvpK6jC4BT/6LqBorSk8UIybv6pCRHA7Sa7meQ3Z5MovLQqpweilg24rehJ5u6mR1+n3Asx6jJeNJcVk0j0+kqt1QJCAoL2GqFxFPbnLcw5OhfD5POxOfzNYyn8tWaOPSFId0gfNcDe62Ifvfblk1UUXjF51hhFUhlw6ILiPj+PXJDFbOOWfehzWcmP0xVjN2g2fghr/FgLAJxv03TVYaOkraZaE0aOG8qTcwSGFpqxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OR4AiOdLNV0pKVUWll2qX3IlvjNajKxLrOoeVBmDrjk=;
 b=eezN7RbOuVI0Fyoh592eCxonylGK5l/Wt9W1/y02f/TLdaXIVekTw6SaHOts80JCwxWC9JagB2VkVyCEAuFAWZ0tGnNbDtwweUonIONtI9dHas3vwoUrhb3KlHLtQkvpK7FkMPhxJQq+fyAcSy88cF7zOXWBNfYwcCrR7Msy6n0=
Received: from BL1PR13CA0386.namprd13.prod.outlook.com (2603:10b6:208:2c0::31)
 by CH3PR12MB8548.namprd12.prod.outlook.com (2603:10b6:610:165::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Fri, 15 Nov
 2024 12:02:13 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:208:2c0:cafe::6c) by BL1PR13CA0386.outlook.office365.com
 (2603:10b6:208:2c0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19 via Frontend
 Transport; Fri, 15 Nov 2024 12:02:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.1 via Frontend Transport; Fri, 15 Nov 2024 12:02:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 06:02:10 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 06:02:09 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 15 Nov 2024 06:02:07 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <padmarao.begari@amd.com>,
 <venkatesh.abbarapu@amd.com>, <git@xilinx.com>
Subject: [PATCH] test/py: zynqmp_rpu: Fix tcminit mode value
Date: Fri, 15 Nov 2024 17:32:02 +0530
Message-ID: <48f75577f6735a0d14105658e89b625d45537bb1.1731672024.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|CH3PR12MB8548:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a388cd1-2ed1-4f34-4881-08dd056d5799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ICZvrqem4Y1UCN1KlTH1fkuoXI9ICe7jtjqv1Q95oQs2DtPS/n2isy62FZy3?=
 =?us-ascii?Q?TaFxr3iAO2xEKKiei6KYxsSk9gdU1OA9GdGKMUnBFYNOON4lw1ZsEi54UYXg?=
 =?us-ascii?Q?bHnZVk7lREgzwWsMXwRbA+m9YHKpYoScNuzKPRHB4ffYQozRKJjfrTukFWhp?=
 =?us-ascii?Q?EQQu9f/VEeUoefcR6P0Ild5RurM9dq4jqa7tWVWW9Eq3oGIYqjyuzoY5T0zh?=
 =?us-ascii?Q?BTqJqlYx0Lhcm/SRS++fQqfqSs3JwD36h7zDL4E+z4jXl3cx/xUCm8GR6jlT?=
 =?us-ascii?Q?eyIlI1/zN3uccwfS7aE1RT3Nx9NPS5n2Wu+5nQeTNPJEtxtgrZzQK5WRmVFm?=
 =?us-ascii?Q?hTSLLMm2TzJIUmbB6/A5YqazmgOApUCbiWexhVzQ+Q0rkLyG1FWaUJBSlWw9?=
 =?us-ascii?Q?PYOp+pIZKe9JeLkt/jLE1Q+3IXbsvniio19UDkZu35FyibKM0oCdsheVxzVC?=
 =?us-ascii?Q?v6ZVmn85PGFjV5QnXdc2+e/9hNP+0SvbvvJNyc+vZWMR9NZOETJvnQz28f4w?=
 =?us-ascii?Q?Z8PtVy2aKJ8fYZpdT0o4OiMzqTheXOhgfFDQCmBwhjFTtBynr9prh0acIDC2?=
 =?us-ascii?Q?rOF0OCHUa5YgACWRjMWgFUKrH4iX59D5/oPAml3uaPWB4s3lAprAq5COrv9e?=
 =?us-ascii?Q?TKkWd3mNqXvED992GCOE6sJeVU25GOirX33BbtcXehw2habpseT25ABB67Cx?=
 =?us-ascii?Q?R9ihs0CQzq0yzbrBaOyT0JtoTXK0N4cXd34BLDNZ2oL8u4Sd+sBg8pp3b88s?=
 =?us-ascii?Q?dv9zUReChZL6x2aycGu40tr/KVXN/seVJ8rZtHdhv/FyLN5RKRcRLs/eXPBb?=
 =?us-ascii?Q?JffGGzKqL0T4kl8sO4SEDaQkgr7btF8ycerEHqcjqff4WJAWIlD2/spHqJvd?=
 =?us-ascii?Q?WlBIMxtAIpIpJDxIJTEQ+CiQTotSX5qfXdDH+tEzybOdooH8K9B91TK+BReX?=
 =?us-ascii?Q?Cg41/m7xkSXsawDH6j9vkTxGJ812sbNIiF2z3VDjQ/MNVXEw6Te+r2ibJb9g?=
 =?us-ascii?Q?lD8Qwf12yY1HUEg4d+hQ9/sx0LsZ/PApt9676zEmIXHVYCgXiJ/FIWgQDfVO?=
 =?us-ascii?Q?cXiK8h20yIc5RlrdQ5V+nexwSGbKOMpTJRSuenDX23JNcEj1ChGRZoJYud2X?=
 =?us-ascii?Q?c4bxTNp+fM2noj3HEfZpOkBfRn64t+ORdW/gVUE2cZVLQVIZYT/vx3/Km07a?=
 =?us-ascii?Q?aeP+mvYlNKJMQvWLX/m4l77FMz7rLNINITb1YDgqiL8upQW+JkYEDFXcLmBa?=
 =?us-ascii?Q?ZTuFjLG2aCMCb23quFGMf+rbrrdPyeGy/6ZPM6SQB/6cIAZmQ3xaBfl/Sm4n?=
 =?us-ascii?Q?4wOmRar+mB5N17rqZAJOMmVcI5sSXGuUx6YN8IoOyj5ZY5cdwqLT9oJs70IC?=
 =?us-ascii?Q?DHMgYhE94KC6NQNGhFjnT4+1onAQMbTo/UViA+NBOXoRAMVArw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 12:02:13.4934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a388cd1-2ed1-4f34-4881-08dd056d5799
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8548
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

Update the tcminit value to string and number both as per commit
342ccba5586a ("arm64: zynqmp: Fix tcminit mode value based on argv") and
also adds negative cases based on invalid command sequences.

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
 test/py/tests/test_zynqmp_rpu.py | 84 +++++++++++++++++++-------------
 1 file changed, 49 insertions(+), 35 deletions(-)

diff --git a/test/py/tests/test_zynqmp_rpu.py b/test/py/tests/test_zynqmp_rpu.py
index 479a612b4ec2..22f687dd6d39 100644
--- a/test/py/tests/test_zynqmp_rpu.py
+++ b/test/py/tests/test_zynqmp_rpu.py
@@ -70,7 +70,7 @@ def ret_code(u_boot_console):
 
 # Initialize tcm
 def tcminit(u_boot_console, rpu_mode):
-    output = u_boot_console.run_command('zynqmp tcminit %s' % rpu_mode)
+    output = u_boot_console.run_command(f'zynqmp tcminit {rpu_mode}')
     assert 'Initializing TCM overwrites TCM content' in output
     return ret_code(u_boot_console)
 
@@ -89,6 +89,13 @@ def disable_cpus(u_boot_console, cpu_nums):
     for num in cpu_nums:
         u_boot_console.run_command(f'cpu {num} disable')
 
+# Get random RPU mode between string and integer
+def get_rpu_mode(rpu_mode):
+    if rpu_mode == 0 or rpu_mode == 'lockstep':
+        return random.choice(['lockstep', 0])
+    elif rpu_mode == 1 or rpu_mode == 'split':
+        return random.choice(['split', 1])
+
 # Load apps on RPU cores
 def rpu_apps_load(u_boot_console, rpu_mode):
     apps, procs, cpu_nums, addrs, outputs, tftp_addrs = get_rpu_apps_env(
@@ -98,20 +105,20 @@ def rpu_apps_load(u_boot_console, rpu_mode):
         test_net.test_net_setup_static(u_boot_console)
 
     try:
-        assert tcminit(u_boot_console, rpu_mode).endswith('0')
+        assert tcminit(u_boot_console, get_rpu_mode(rpu_mode)).endswith('0')
 
         for i in range(len(apps)):
             if rpu_mode == 'lockstep' and procs[i] != 'rpu0':
                 continue
 
             load_app_ddr(u_boot_console, tftp_addrs[i], apps[i])
-            rel_addr = int(addrs[i] + 0x3C)
+            rel_addr = hex(int(addrs[i] + 0x3C))
 
             # Release cpu at app load address
             cpu_num = cpu_nums[i]
-            cmd = 'cpu %d release %x %s' % (cpu_num, rel_addr, rpu_mode)
+            cmd = f'cpu {cpu_num} release {rel_addr} {rpu_mode}'
             output = u_boot_console.run_command(cmd)
-            exp_op = f'Using TCM jump trampoline for address {hex(rel_addr)}'
+            exp_op = f'Using TCM jump trampoline for address {rel_addr}'
             assert exp_op in output
             assert f'R5 {rpu_mode} mode' in output
             u_boot_console.wait_for(outputs[i])
@@ -133,16 +140,13 @@ def test_zynqmp_rpu_app_load_negative(u_boot_console):
         u_boot_console)
 
     # Invalid commands
-    u_boot_console.run_command('zynqmp tcminit mode')
-    assert ret_code(u_boot_console).endswith('1')
-
     rand_str = ''.join(random.choices(string.ascii_lowercase, k=4))
-    u_boot_console.run_command('zynqmp tcminit %s' % rand_str)
-    assert ret_code(u_boot_console).endswith('1')
-
     rand_num = random.randint(2, 100)
-    u_boot_console.run_command('zynqmp tcminit %d' % rand_num)
-    assert ret_code(u_boot_console).endswith('1')
+    inv_modes = ['mode', rand_str, rand_num, 'splittt', 'locksteppp', '00', 11]
+
+    for mode in inv_modes:
+        u_boot_console.run_command(f'zynqmp tcminit {mode}')
+        assert ret_code(u_boot_console).endswith('1')
 
     test_net.test_net_dhcp(u_boot_console)
     if not test_net.net_set_up:
@@ -150,56 +154,66 @@ def test_zynqmp_rpu_app_load_negative(u_boot_console):
 
     try:
         rpu_mode = 'split'
-        assert tcminit(u_boot_console, rpu_mode).endswith('0')
+        assert tcminit(u_boot_console, get_rpu_mode(rpu_mode)).endswith('0')
 
+        inv_modes += [0, 1]
         for i in range(len(apps)):
             load_app_ddr(u_boot_console, tftp_addrs[i], apps[i])
 
             # Run in split mode at different load address
-            rel_addr = int(addrs[i]) + random.randint(200, 1000)
+            rel_addr = hex(int(addrs[i]) + random.randint(200, 1000))
             cpu_num = cpu_nums[i]
-            cmd = 'cpu %d release %x %s' % (cpu_num, rel_addr, rpu_mode)
+            cmd = f'cpu {cpu_num} release {rel_addr} {rpu_mode}'
             output = u_boot_console.run_command(cmd)
-            exp_op = f'Using TCM jump trampoline for address {hex(rel_addr)}'
+            exp_op = f'Using TCM jump trampoline for address {rel_addr}'
             assert exp_op in output
             assert f'R5 {rpu_mode} mode' in output
             assert not outputs[i] in output
 
             # Invalid rpu mode
-            rand_str = ''.join(random.choices(string.ascii_lowercase, k=4))
-            cmd = 'cpu %d release %x %s' % (cpu_num, rel_addr, rand_str)
-            output = u_boot_console.run_command(cmd)
-            assert exp_op in output
-            assert f'Unsupported mode' in output
-            assert not ret_code(u_boot_console).endswith('0')
+            for mode in inv_modes:
+                cmd = f'cpu {cpu_num} release {rel_addr} {mode}'
+                output = u_boot_console.run_command(cmd)
+                assert exp_op in output
+                assert f'Unsupported mode' in output
+                assert not ret_code(u_boot_console).endswith('0')
 
         # Switch to lockstep mode, without disabling CPUs
         rpu_mode = 'lockstep'
-        u_boot_console.run_command('zynqmp tcminit %s' % rpu_mode)
-        assert not ret_code(u_boot_console).endswith('0')
+        output = u_boot_console.run_command(
+            f'zynqmp tcminit {get_rpu_mode(rpu_mode)}'
+        )
+        assert 'ERROR: ' in output
 
         # Disable cpus
         disable_cpus(u_boot_console, cpu_nums)
 
         # Switch to lockstep mode, after disabling CPUs
-        output = u_boot_console.run_command('zynqmp tcminit %s' % rpu_mode)
+        output = u_boot_console.run_command(
+            f'zynqmp tcminit {get_rpu_mode(rpu_mode)}'
+        )
         assert 'Initializing TCM overwrites TCM content' in output
         assert ret_code(u_boot_console).endswith('0')
 
-        # Run lockstep mode for RPU1
+        # Run lockstep mode for RPU1/RPU0
         for i in range(len(apps)):
-            if procs[i] == 'rpu0':
-                continue
-
             load_app_ddr(u_boot_console, tftp_addrs[i], apps[i])
-            rel_addr = int(addrs[i] + 0x3C)
+            rel_addr = hex(int(addrs[i] + 0x3C))
             cpu_num = cpu_nums[i]
-            cmd = 'cpu %d release %x %s' % (cpu_num, rel_addr, rpu_mode)
+            cmd = f'cpu {cpu_num} release {rel_addr} {rpu_mode}'
             output = u_boot_console.run_command(cmd)
-            exp_op = f'Using TCM jump trampoline for address {hex(rel_addr)}'
+            exp_op = f'Using TCM jump trampoline for address {rel_addr}'
             assert exp_op in output
-            assert f'R5 {rpu_mode} mode' in output
-            assert u_boot_console.p.expect([outputs[i]])
+
+            if procs[i] == 'rpu1':
+                assert 'Lockstep mode should run on ZYNQMP_CORE_RPU0' in output
+                assert not ret_code(u_boot_console).endswith('0')
+            elif procs[i] == 'rpu0':
+                assert f'R5 {rpu_mode} mode' in output
+                u_boot_console.wait_for(outputs[i])
+                assert ret_code(u_boot_console).endswith('0')
+            else:
+                assert False, 'ERROR: Invalid processor!'
     finally:
         disable_cpus(u_boot_console, cpu_nums)
         # This forces the console object to be shutdown, so any subsequent test
-- 
2.25.1

