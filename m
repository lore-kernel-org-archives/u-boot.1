Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92001C27C52
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 09:49:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F252B87A9C;
	Wed,  5 Jun 2024 11:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lLFZ3DOX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DFF788348; Wed,  5 Jun 2024 11:49:51 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34C04831A2
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 11:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1pdogCsuZQyK7V5TxXpaQRI6t0EQxJFCpluKwWT9DPdbVlwzWl/ik87RQdv+LschXc5WLwcXoX45GbWhHH656bK8f1v1d8rDfbBTPq+ylZWVfI4QjVGMyMfeoUJX9Xta7TzN3YB7ZiSbQhm4v1jcrtzn+qISpt12BU6X/VwzetnAtbz7JtWrv79KwqsZAn94MTBHjj5C3W5+TFAuUs3Dlkojt8qRL51FVwXkDZ7DudLYfCU/fFz0SdOyPHyjpT2hzOCzSqqBy8wxS+f5psoTYPRi8E+18Izz7XtxgaNHkZhaZnhdX8Io5gkAVKF9wQUNMmCXDPQpEG0KhxEowMS9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcGT/Xt77ukjUaKL3dsT67OoOg+dgK+3b1WHfgyDQV0=;
 b=EId1mvyqqnOilEt/aX2KC4VHAmGG6s/O8e4fhO14XuiF9JoEOKWSpE2XeA+61uz5SZ2ecKd8+nEZrNja4r/+LifiTWYkc7uR3cF49PzMSuESQ1mFwgI5xJVOJ2MaO+bW37j9w9WFiH003dI62Zr4ui3JMkGCDUphbe8QTAwz9aJhY3PkLf2X6P1zciGzEpTTjtQlX3Utl9QYbJfvtFGgTRrl1jfovyKyZJo1MQpId/KpTFItIYQmu9UYlCB2+cYD6D4R5T4BBKVzi7oZXCjtU1Q+yszwtYmNROXpFJJtGBEOVrqyspXd8BPvJjhSpu87K2oCoXg0DaExQq+ZLst2AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcGT/Xt77ukjUaKL3dsT67OoOg+dgK+3b1WHfgyDQV0=;
 b=lLFZ3DOXDgPC0fV09YQg98pgxb8ytjUf8OyEucqKn/H6mQZBJ97u6aIzPdz3AkanY1Tshf2UJxf3q/2tzVKUKfUOopcDII6KlbwUr0w5e2PivIHj1xijhFeKHPulRP7log/a+F6S6S8zN5rn8b3SG6NC58BG/7HClpryCbUQYto=
Received: from PH8PR02CA0012.namprd02.prod.outlook.com (2603:10b6:510:2d0::24)
 by IA1PR12MB7589.namprd12.prod.outlook.com (2603:10b6:208:42b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Wed, 5 Jun
 2024 09:49:44 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::5a) by PH8PR02CA0012.outlook.office365.com
 (2603:10b6:510:2d0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.17 via Frontend
 Transport; Wed, 5 Jun 2024 09:49:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 09:49:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 04:49:42 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 5 Jun 2024 04:49:41 -0500
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH v7] test/py: net_boot: Add test cases for net boot
Date: Wed, 5 Jun 2024 15:19:35 +0530
Message-ID: <53549cdc5fc6c144f83ade47e159a3830f05e575.1717580941.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: love.kumar@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|IA1PR12MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: e638acc3-553c-47f4-3cdb-08dc8544d3c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bmQsSxTCrHh+PEVYQ0ZS3EQdUmSsyXx3rRqdlFSgclT5cz8OiYENYrFJjh4b?=
 =?us-ascii?Q?OPAgbZ4ASq5wCJ6S2L6StQN1saBCgwICWIBzx/JznBK0ZtF30uVvrrRRy7Pa?=
 =?us-ascii?Q?Zx3fYMF1stBfD84am9CglOkbqcDawadGPTZ1dQz+zKSMUA4TllRCUnzaeklp?=
 =?us-ascii?Q?XcD++rmhoqprHohmLM5jjFDCzIRCrUmWV7xMErA6nUzo3asXKN222vpEoWbH?=
 =?us-ascii?Q?pdD7pJUqdfBOJqUeEz/JPtvHxRZA7jbVNPr6julmJoKdZ1Tc+02ySRPnmW0d?=
 =?us-ascii?Q?QfBc9O1rZW2vq+lwjaX9hB0//emQ/jrjfBICtCa5d0vHCZqZWcHwhKreDKaA?=
 =?us-ascii?Q?MiCSVUrB/ST2F+dLziBJexYGRCNk2eHEgeGeWmBIGtmkzR8kHhRNeDBQjjxQ?=
 =?us-ascii?Q?Yzs6ZE8I1m7406EBpD/0eSTFCfkeFpWKwYV2wDj9wtgLtWR+0KGfW/2Qs/9V?=
 =?us-ascii?Q?YYcu1h/50nLuf83lodnDwZnRs5QqQgemsygjj5hN+2e7NaOsTE3RVlis6fnE?=
 =?us-ascii?Q?9U1OKC9uRXgTtN1XjW+IY76kaWSCsD/q/1q89hdLvnpeSLwTeSCwlVh7uR1h?=
 =?us-ascii?Q?gA2WNKJ6YSKefKpG9JENuK799phAT6Jr5hWj+UkBq8Hjg+JeDuiRqYx3cnI1?=
 =?us-ascii?Q?3/gGO+qPSKyKlqI6ueaCWJfoLXc/mWMdIJDrIq+ptn5aNqNAY+IT8JXl6A6A?=
 =?us-ascii?Q?8jJBIZ2J+vAJjgDSLBJx+hzrcC9UM3eNoPpr2GC6wb1Q9eTqdkaNzAyq9La8?=
 =?us-ascii?Q?UOtoI4dDc1sQLhKcSzAcGBS33UenmJzhQwhoUky0e/PzCtAOccpDGxpYPNNw?=
 =?us-ascii?Q?r17DwHpFaP6nHSPAmp4m6yLAZEC05/kILirHPjqat0zmPa+swI9GYLH4hv3S?=
 =?us-ascii?Q?vsgwQ1mYQsF+ftfACIBi83DZMH4B7AzTumW9MWgbwn8MMZXehjoFAK6LGY9v?=
 =?us-ascii?Q?WAsN/vxxG7O3GUWiE6vbAT2KeWeODALlx945JKcR/VhM95exnJCBsFlbUlO9?=
 =?us-ascii?Q?8rvc/f6Cu+QMbJvAd2S48jckq3jTzArnHKRBXfYu0B6z6dKvA1SHeGC/WNGg?=
 =?us-ascii?Q?iWbjg/auHhO6C7wGY/E8g0/dEOAi4LHV7XKMPnxoedxqwLG67YZ7abQRRDlD?=
 =?us-ascii?Q?rsNrJ1bNaySAVIUlxvtfUNnsIl4Cm7gngmTQ95HUGVkwq9FsH2QnakOreiUh?=
 =?us-ascii?Q?29M624Lw+t1CS0Z/a6qvkJbA6rCaW0zigq01HZIpgvQohLA3EUPRxnG1DUHX?=
 =?us-ascii?Q?NYzj3o9MM90qgDm2/54hWhP3o/RrI6xH3qO40gxtwm4zEvYb/lFKRciGR01/?=
 =?us-ascii?Q?5RvXPQt7QlOUn0/m8nBt/OhstYd591ukr1Lx7l8zuRXC8Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 09:49:43.5444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e638acc3-553c-47f4-3cdb-08dc8544d3c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7589
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

Add tests for booting image using tftpboot/pxe boot commands, tftpboot
boot case loads the FIT image into DDR and boots using bootm command
whereas pxe boot cases downloads the pxe configuration file from the
TFTP server and interprets it to boot the images mentioned in the pxe
configurations file.
This test relies on boardenv_* containing configuration values including
the parameter 'pattern'. tftpboot/pxe boot cases boots the Linux till the
boot log pattern value is matched. For example, if the parameter
'pattern' is defined as 'login:', it will boot till login prompt.

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
Changes in v2:
  - Expand commit message
Changes in v3:
  - Add the config option to skip the test
  - Remove imi command to check FIT image config
  - Configure static networking only if DHCP fails
Changes in v4:
  - Use configured timeout for tftpboot
Changes in v5:
  - Add pre-req for boot test to enable error check
  - Merged boot and boot config test
Changes in v6:
  - Use common setup_networking function for tftp and pxe cases
  - Check for bootfile env variable for pxe config name
Changes in v7:
  - Set pxefile_addr_r env variable to use the same address for loading
  and running pxe config
---
 test/py/tests/test_net_boot.py | 403 +++++++++++++++++++++++++++++++++
 1 file changed, 403 insertions(+)
 create mode 100644 test/py/tests/test_net_boot.py

diff --git a/test/py/tests/test_net_boot.py b/test/py/tests/test_net_boot.py
new file mode 100644
index 000000000000..4729ccf07feb
--- /dev/null
+++ b/test/py/tests/test_net_boot.py
@@ -0,0 +1,403 @@
+# SPDX-License-Identifier: GPL-2.0
+# (C) Copyright 2023, Advanced Micro Devices, Inc.
+
+import pytest
+import u_boot_utils
+import test_net
+import re
+
+"""
+Note: This test relies on boardenv_* containing configuration values to define
+which the network environment available for testing. Without this, this test
+will be automatically skipped.
+
+For example:
+
+# Details regarding a boot image file that may be read from a TFTP server. This
+# variable may be omitted or set to None if TFTP boot testing is not possible
+# or desired.
+env__net_tftp_bootable_file = {
+    'fn': 'image.ub',
+    'addr': 0x10000000,
+    'size': 5058624,
+    'crc32': 'c2244b26',
+    'pattern': 'Linux',
+    'config': 'config@2',
+    'timeout': 50000,
+    'check_type': 'boot_error',
+    'check_pattern': 'ERROR',
+}
+
+# False or omitted if a TFTP boot test should be tested.
+# If TFTP boot testing is not possible or desired, set this variable to True.
+# For example: If FIT image is not proper to boot
+env__tftp_boot_test_skip = False
+
+# Here is the example of FIT image configurations:
+configurations {
+    default = "config@1";
+    config@1 {
+        description = "Boot Linux kernel with config@1";
+        kernel = "kernel@0";
+        fdt = "fdt@0";
+        ramdisk = "ramdisk@0";
+        hash@1 {
+            algo = "sha1";
+        };
+    };
+    config@2 {
+        description = "Boot Linux kernel with config@2";
+        kernel = "kernel@1";
+        fdt = "fdt@1";
+        ramdisk = "ramdisk@1";
+        hash@1 {
+            algo = "sha1";
+        };
+    };
+};
+
+# Details regarding a file that may be read from a TFTP server. This variable
+# may be omitted or set to None if PXE testing is not possible or desired.
+env__net_pxe_bootable_file = {
+    'fn': 'default',
+    'addr': 0x10000000,
+    'size': 74,
+    'timeout': 50000,
+    'pattern': 'Linux',
+    'valid_label': '1',
+    'invalid_label': '2',
+    'exp_str_invalid': 'Skipping install for failure retrieving',
+    'local_label': '3',
+    'exp_str_local': 'missing environment variable: localcmd',
+    'empty_label': '4',
+    'exp_str_empty': 'No kernel given, skipping boot',
+    'check_type': 'boot_error',
+    'check_pattern': 'ERROR',
+}
+
+# False or omitted if a PXE boot test should be tested.
+# If PXE boot testing is not possible or desired, set this variable to True.
+# For example: If pxe configuration file is not proper to boot
+env__pxe_boot_test_skip = False
+
+# Here is the example of pxe configuration file ordered based on the execution
+# flow:
+1) /tftpboot/pxelinux.cfg/default-arm-zynqmp
+
+    menu include pxelinux.cfg/default-arm
+    timeout 50
+
+    default Linux
+
+2) /tftpboot/pxelinux.cfg/default-arm
+
+    menu title Linux boot selections
+    menu include pxelinux.cfg/default
+
+    label install
+        menu label Invalid boot
+        kernel kernels/install.bin
+        append console=ttyAMA0,38400 debug earlyprintk
+        initrd initrds/uzInitrdDebInstall
+
+    label local
+        menu label Local boot
+        append root=/dev/sdb1
+        localboot 1
+
+    label boot
+        menu label Empty boot
+
+3) /tftpboot/pxelinux.cfg/default
+
+    label Linux
+        menu label Boot kernel
+        kernel Image
+        fdt system.dtb
+        initrd rootfs.cpio.gz.u-boot
+"""
+
+def setup_networking(u_boot_console):
+    test_net.test_net_dhcp(u_boot_console)
+    if not test_net.net_set_up:
+        test_net.test_net_setup_static(u_boot_console)
+
+def setup_tftpboot_boot(u_boot_console):
+    f = u_boot_console.config.env.get('env__net_tftp_bootable_file', None)
+    if not f:
+        pytest.skip('No TFTP bootable file to read')
+
+    setup_networking(u_boot_console)
+    addr = f.get('addr', None)
+    if not addr:
+        addr = u_boot_utils.find_ram_base(u_boot_console)
+
+    fn = f['fn']
+    timeout = f.get('timeout', 50000)
+
+    with u_boot_console.temporary_timeout(timeout):
+        output = u_boot_console.run_command('tftpboot %x %s' % (addr, fn))
+
+    expected_text = 'Bytes transferred = '
+    sz = f.get('size', None)
+    if sz:
+        expected_text += '%d' % sz
+    assert expected_text in output
+
+    expected_crc = f.get('crc32', None)
+    output = u_boot_console.run_command('crc32 %x $filesize' % addr)
+    if expected_crc:
+        assert expected_crc in output
+
+    pattern = f.get('pattern')
+    chk_type = f.get('check_type', 'boot_error')
+    chk_pattern = re.compile(f.get('check_pattern', 'ERROR'))
+    config = f.get('config', None)
+
+    return addr, timeout, pattern, chk_type, chk_pattern, config
+
+@pytest.mark.buildconfigspec('cmd_net')
+def test_net_tftpboot_boot(u_boot_console):
+    """Boot the loaded image
+
+    A boot file (fit image) is downloaded from the TFTP server and booted using
+    bootm command with the default fit configuration, its boot log pattern are
+    validated.
+
+    The details of the file to download are provided by the boardenv_* file;
+    see the comment at the beginning of this file.
+    """
+    if u_boot_console.config.env.get('env__tftp_boot_test_skip', True):
+        pytest.skip('TFTP boot test is not enabled!')
+
+    addr, timeout, pattern, chk_type, chk_pattern, imcfg = setup_tftpboot_boot(
+        u_boot_console
+    )
+
+    if imcfg:
+        bootcmd = 'bootm %x#%s' % (addr, imcfg)
+    else:
+        bootcmd = 'bootm %x' % addr
+
+    with u_boot_console.enable_check(
+        chk_type, chk_pattern
+    ), u_boot_console.temporary_timeout(timeout):
+        try:
+            # wait_for_prompt=False makes the core code not wait for the U-Boot
+            # prompt code to be seen, since it won't be on a successful kernel
+            # boot
+            u_boot_console.run_command(bootcmd, wait_for_prompt=False)
+
+            # Wait for boot log pattern
+            u_boot_console.wait_for(pattern)
+        finally:
+            # This forces the console object to be shutdown, so any subsequent
+            # test will reset the board back into U-Boot. We want to force this
+            # no matter whether the kernel boot passed or failed.
+            u_boot_console.drain_console()
+            u_boot_console.cleanup_spawn()
+
+def setup_pxe_boot(u_boot_console):
+    f = u_boot_console.config.env.get('env__net_pxe_bootable_file', None)
+    if not f:
+        pytest.skip('No PXE bootable file to read')
+
+    setup_networking(u_boot_console)
+    bootfile = u_boot_console.run_command('echo $bootfile')
+    if not bootfile:
+        bootfile = '<NULL>'
+
+    return f, bootfile
+
+@pytest.mark.buildconfigspec('cmd_net')
+@pytest.mark.buildconfigspec('cmd_pxe')
+def test_net_pxe_boot(u_boot_console):
+    """Test the pxe boot command.
+
+    A pxe configuration file is downloaded from the TFTP server and interpreted
+    to boot the images mentioned in pxe configuration file.
+
+    The details of the file to download are provided by the boardenv_* file;
+    see the comment at the beginning of this file.
+    """
+    if u_boot_console.config.env.get('env__pxe_boot_test_skip', True):
+        pytest.skip('PXE boot test is not enabled!')
+
+    f, bootfile = setup_pxe_boot(u_boot_console)
+    addr = f.get('addr', None)
+    timeout = f.get('timeout', u_boot_console.p.timeout)
+    fn = f['fn']
+
+    if addr:
+        u_boot_console.run_command('setenv pxefile_addr_r %x' % addr)
+
+    with u_boot_console.temporary_timeout(timeout):
+        output = u_boot_console.run_command('pxe get')
+
+    expected_text = 'Bytes transferred = '
+    sz = f.get('size', None)
+    if sz:
+        expected_text += '%d' % sz
+    assert 'TIMEOUT' not in output
+    assert expected_text in output
+    assert f"Config file '{bootfile}' found" in output
+
+    pattern = f.get('pattern')
+    chk_type = f.get('check_type', 'boot_error')
+    chk_pattern = re.compile(f.get('check_pattern', 'ERROR'))
+
+    if not addr:
+        pxe_boot_cmd = 'pxe boot'
+    else:
+        pxe_boot_cmd = 'pxe boot %x' % addr
+
+    with u_boot_console.enable_check(
+        chk_type, chk_pattern
+    ), u_boot_console.temporary_timeout(timeout):
+        try:
+            u_boot_console.run_command(pxe_boot_cmd, wait_for_prompt=False)
+            u_boot_console.wait_for(pattern)
+        finally:
+            u_boot_console.drain_console()
+            u_boot_console.cleanup_spawn()
+
+@pytest.mark.buildconfigspec('cmd_net')
+@pytest.mark.buildconfigspec('cmd_pxe')
+def test_net_pxe_boot_config(u_boot_console):
+    """Test the pxe boot command by selecting different combination of labels
+
+    A pxe configuration file is downloaded from the TFTP server and interpreted
+    to boot the images mentioned in pxe configuration file.
+
+    The details of the file to download are provided by the boardenv_* file;
+    see the comment at the beginning of this file.
+    """
+    if u_boot_console.config.env.get('env__pxe_boot_test_skip', True):
+        pytest.skip('PXE boot test is not enabled!')
+
+    f, bootfile = setup_pxe_boot(u_boot_console)
+    addr = f.get('addr', None)
+    timeout = f.get('timeout', u_boot_console.p.timeout)
+    fn = f['fn']
+    local_label = f['local_label']
+    empty_label = f['empty_label']
+    exp_str_local = f['exp_str_local']
+    exp_str_empty = f['exp_str_empty']
+
+    if addr:
+        u_boot_console.run_command('setenv pxefile_addr_r %x' % addr)
+
+    with u_boot_console.temporary_timeout(timeout):
+        output = u_boot_console.run_command('pxe get')
+
+    expected_text = 'Bytes transferred = '
+    sz = f.get('size', None)
+    if sz:
+        expected_text += '%d' % sz
+    assert 'TIMEOUT' not in output
+    assert expected_text in output
+    assert f"Config file '{bootfile}' found" in output
+
+    pattern = f.get('pattern')
+    chk_type = f.get('check_type', 'boot_error')
+    chk_pattern = re.compile(f.get('check_pattern', 'ERROR'))
+
+    if not addr:
+        pxe_boot_cmd = 'pxe boot'
+    else:
+        pxe_boot_cmd = 'pxe boot %x' % addr
+
+    with u_boot_console.enable_check(
+        chk_type, chk_pattern
+    ), u_boot_console.temporary_timeout(timeout):
+        try:
+            u_boot_console.run_command(pxe_boot_cmd, wait_for_prompt=False)
+
+            # pxe config is loaded where multiple labels are there and need to
+            # select particular label to boot and check for expected string
+            # In this case, local label is selected and it should look for
+            # localcmd env variable and if that variable is not defined it
+            # should not boot it and come out to u-boot prompt
+            u_boot_console.wait_for('Enter choice:')
+            u_boot_console.run_command(local_label, wait_for_prompt=False)
+            expected_str = u_boot_console.p.expect([exp_str_local])
+            assert (
+                expected_str == 0
+            ), f'Expected string: {exp_str_local} did not match!'
+
+            # In this case, empty label is selected and it should look for
+            # kernel image path and if it is not set it should fail it and load
+            # default label to boot
+            u_boot_console.run_command(pxe_boot_cmd, wait_for_prompt=False)
+            u_boot_console.wait_for('Enter choice:')
+            u_boot_console.run_command(empty_label, wait_for_prompt=False)
+            expected_str = u_boot_console.p.expect([exp_str_empty])
+            assert (
+                expected_str == 0
+            ), f'Expected string: {exp_str_empty} did not match!'
+
+            u_boot_console.wait_for(pattern)
+        finally:
+            u_boot_console.drain_console()
+            u_boot_console.cleanup_spawn()
+
+@pytest.mark.buildconfigspec('cmd_net')
+@pytest.mark.buildconfigspec('cmd_pxe')
+def test_net_pxe_boot_config_invalid(u_boot_console):
+    """Test the pxe boot command by selecting invalid label
+
+    A pxe configuration file is downloaded from the TFTP server and interpreted
+    to boot the images mentioned in pxe configuration file.
+
+    The details of the file to download are provided by the boardenv_* file;
+    see the comment at the beginning of this file.
+    """
+    if u_boot_console.config.env.get('env__pxe_boot_test_skip', True):
+        pytest.skip('PXE boot test is not enabled!')
+
+    f, bootfile = setup_pxe_boot(u_boot_console)
+    addr = f.get('addr', None)
+    timeout = f.get('timeout', u_boot_console.p.timeout)
+    fn = f['fn']
+    invalid_label = f['invalid_label']
+    exp_str_invalid = f['exp_str_invalid']
+
+    if addr:
+        u_boot_console.run_command('setenv pxefile_addr_r %x' % addr)
+
+    with u_boot_console.temporary_timeout(timeout):
+        output = u_boot_console.run_command('pxe get')
+
+    expected_text = 'Bytes transferred = '
+    sz = f.get('size', None)
+    if sz:
+        expected_text += '%d' % sz
+    assert 'TIMEOUT' not in output
+    assert expected_text in output
+    assert f"Config file '{bootfile}' found" in output
+
+    pattern = f.get('pattern')
+    if not addr:
+        pxe_boot_cmd = 'pxe boot'
+    else:
+        pxe_boot_cmd = 'pxe boot %x' % addr
+
+    with u_boot_console.temporary_timeout(timeout):
+        try:
+            u_boot_console.run_command(pxe_boot_cmd, wait_for_prompt=False)
+
+            # pxe config is loaded where multiple labels are there and need to
+            # select particular label to boot and check for expected string
+            # In this case invalid label is selected, it should load invalid
+            # label and if it fails it should load the default label to boot
+            u_boot_console.wait_for('Enter choice:')
+            u_boot_console.run_command(invalid_label, wait_for_prompt=False)
+            expected_str = u_boot_console.p.expect([exp_str_invalid])
+            assert (
+                expected_str == 0
+            ), f'Expected string: {exp_str_invalid} did not match!'
+
+            u_boot_console.wait_for(pattern)
+        finally:
+            u_boot_console.drain_console()
+            u_boot_console.cleanup_spawn()
-- 
2.25.1

