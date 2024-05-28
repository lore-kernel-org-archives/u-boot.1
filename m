Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E66C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 09:03:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 105FA88441;
	Tue, 28 May 2024 11:03:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kriwj5rV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D2838841D; Tue, 28 May 2024 11:03:32 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEBA68845C
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 11:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KO83bQoq2pAev4c42YlCW2wuliJt83mnpFEFPErZpWKbC4VfgMSYLmVJsnqPowkXY7jR/zrfRKNPy4wTEFieD1ZYdxasIjzB4P0ACb6xnRIhUCwSe/FQtNDFZ15kNTqkE3nVZEGxc8NIM8/FnTI0BGw+QNIPMmN07wDy+npWR7aumgB4D0we9CUZ3lTWvZ/71RuBdmZlZrctpzT7B6q4uMUr1fK9UVDpECJU56QXqiE7eucHjX8N9BpZgWAbaRFOchOLEuAmfMPZU+2Bk767fF2Ben486ztyT4kH1LSprkLU9pzz9pI+0LFZI2eXqbmorqG8T551G923vVJ0fkSY7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMoWXWnAEtpoQBOU6novza3YUphkypDcY7pYt7Igzyc=;
 b=TbCOP43ku/SmTiUoVBVb+/w3RreYfNNb+aQWFG+1bSM9xmP+QC+3sxVuXGTNufXYO3kAdFga9MlFNnAOmkzWDp5WEV77intHqOurB8FDJFCb6ij3gDoNjFMiw9sd/n0PsJP76YGxjvHLNKQrqBmSWV9r2MTSQepzHr55NXzlwJhz+0R19LCAWUD8SmYWWW7j1SLJVaOLLUSsS2vP1o20ER5hU9vyWr9Amg27GJpg5GSxCZ2qVQT8wjJS/aiqYJMtVn5HHvBukp41Ysq0EB2zQYCbUUfOZkMc4vmXo1Fxk3xZYcR5+rOwmUQJl7SgI2vOmECGiMNoU+1tBaXka7UkBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMoWXWnAEtpoQBOU6novza3YUphkypDcY7pYt7Igzyc=;
 b=Kriwj5rVUaUEOdFZZnQL4ozcPrAxEhxqmVGXfS/dmcW/Du2zw7WaYgYLpyn3FbLorhHJee2Mgst5fSBGd7yKJaeDI9ln0O5wZGu4xrGv3rCTG3kOmQ1XGK5kBw5t2DoXPaUWTWUiMdMcD7K0cHgssGGq+mq8n0gTuUwAcETrcnU=
Received: from BN0PR03CA0048.namprd03.prod.outlook.com (2603:10b6:408:e7::23)
 by SA3PR12MB9092.namprd12.prod.outlook.com (2603:10b6:806:37f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 09:03:25 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::e2) by BN0PR03CA0048.outlook.office365.com
 (2603:10b6:408:e7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Tue, 28 May 2024 09:03:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 09:03:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 May
 2024 04:03:24 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 May
 2024 04:03:24 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 28 May 2024 04:03:23 -0500
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH v5] test/py: net_boot: Add test cases for net boot
Date: Tue, 28 May 2024 14:33:17 +0530
Message-ID: <eedb4599e11ffed72cd0866fa02d4b144e3192ad.1716886448.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: love.kumar@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|SA3PR12MB9092:EE_
X-MS-Office365-Filtering-Correlation-Id: 67ec3973-b5ec-4566-cccf-08dc7ef5086c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sgMRuxHGhDnafXqqqvZWDzAvYOuwRxA4hp4BuWvR6KHVIAaMg1RiH8dl4Kad?=
 =?us-ascii?Q?FNLGQ3jqVWMbJDPDIjJTi4l5uDQ4R8/Cebmwj+COBA6K/SRqaKTZVC1dt28n?=
 =?us-ascii?Q?izY9CQ8nd8faq2Nz9OxwgWvT4CBOz2uTsiMzKVzDS7NdNeU563cgSTqP1XXP?=
 =?us-ascii?Q?P67g8B4GmBGCppkEe2xBp6HJK47568IKRn9u5TNzZ7bFE+iYNCpEbZ5OQhrH?=
 =?us-ascii?Q?uiZNinzsjTxMCzgktFyjHZHkib6H1gm2e52rBji9sZsOue94YUi74eT+TaWR?=
 =?us-ascii?Q?deXJK8zeCKSkMKmHrAeDMFQIuDo3kW8w7yhdiTT8eSZpQDq4rYALuyWnSn/f?=
 =?us-ascii?Q?riPgk5ge3ZLDnr4Ny0tP5e9pVLIuhXQ96sfX5pw/3OzmeaHRYOUks+XCGvGv?=
 =?us-ascii?Q?FaQ66u7uMu9nCrtrxJ5CC1RkZIekViQWEx7TuCazuJGZ/Mwc7WXesUt6PNjz?=
 =?us-ascii?Q?apUgoY6iArTQ+pIwMxBBwymDmTg+PfcpCwsHOIT9D3GLE8XHzcidt5Dutsv+?=
 =?us-ascii?Q?u3hdgAVKi4wdDDyMYN7ZMTSgMDF8S/WklREU7Cb8qYfU4n9FwC27c4er9dNU?=
 =?us-ascii?Q?h/Y0h0jLDgmdCSeJQsye0Vjt7REODG9uN6G8h6BstAKNfndNYJ1fjV8uB+1n?=
 =?us-ascii?Q?cd9D1ejrCrzM2SwsjxvAI/gnX13MmxoVuP9BTi+3Oo4G8oSN9+prDrEgGqPu?=
 =?us-ascii?Q?S0tjH6unB9iqVwmR+O97+pu6U2TLg9iW7Aqu3Ka97qhKSlwFFFesuufXsxa0?=
 =?us-ascii?Q?04PMUQLIKbRukqV3XLVRl+T5Oa5xz5Qj3vXocQNfxJGZvOYcXTMB5gmRPMhn?=
 =?us-ascii?Q?qMzxXYSJWh6BJjewRqrvFVsL+QxPYc9uRyfsTpgtQre9f1OEqiX39gClGZ/w?=
 =?us-ascii?Q?BUFTFb+9DM5bKxW3UGxnyK8/H3ar40AlCPob3j4OtXQ4CSGBRilO0aR7YFIB?=
 =?us-ascii?Q?9XZlK1yy/i6j7yhBp6J930dY6lQ9ko4gC/oHyZO3mS62dIrQv1pEKpqZW2bJ?=
 =?us-ascii?Q?9U3K+L2w0NII0UscEEjjK4qfGBwuhTsqm51/MZ4WRkMr09IzNU9NDdq3E4jx?=
 =?us-ascii?Q?M+jchSKMVRSMJTZgEOv1FtFPV52xGouMchwCmsEooJT6/WknCEAY4Bu9bC62?=
 =?us-ascii?Q?rJPycX7kNFnAHLau+/Jfh4n7bMvXXbULRWMBReoC+qTZ4scDrK1VW907bjMH?=
 =?us-ascii?Q?ryvI8neWHUN4fxNqTwi0n9cWqFG41A1OhhsmGr7acjHu9YnmtY50xRFd4K2V?=
 =?us-ascii?Q?3jQ30Xd7yDEyZMz+sqylRqo/cn8F4t9KfaLkR9LpoGr2l92TUtYnKD4lJaYb?=
 =?us-ascii?Q?dRqrX7pLOtk1cyATM+hLYMi9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 09:03:25.2734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ec3973-b5ec-4566-cccf-08dc7ef5086c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9092
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
---
 test/py/tests/test_net_boot.py | 389 +++++++++++++++++++++++++++++++++
 1 file changed, 389 insertions(+)
 create mode 100644 test/py/tests/test_net_boot.py

diff --git a/test/py/tests/test_net_boot.py b/test/py/tests/test_net_boot.py
new file mode 100644
index 000000000000..e5e8ec688df1
--- /dev/null
+++ b/test/py/tests/test_net_boot.py
@@ -0,0 +1,389 @@
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
+def setup_tftpboot_boot(u_boot_console):
+    f = u_boot_console.config.env.get('env__net_tftp_bootable_file', None)
+    if not f:
+        pytest.skip('No TFTP bootable file to read')
+
+    test_net.test_net_dhcp(u_boot_console)
+    if not test_net.net_set_up:
+        test_net.test_net_setup_static(u_boot_console)
+
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
+    test_net.test_net_dhcp(u_boot_console)
+    test_net.test_net_setup_static(u_boot_console)
+    return f
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
+    f = setup_pxe_boot(u_boot_console)
+    addr = f.get('addr', None)
+    timeout = f.get('timeout', u_boot_console.p.timeout)
+    fn = f['fn']
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
+    assert "Config file 'default.boot' found" in output
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
+    f = setup_pxe_boot(u_boot_console)
+    addr = f.get('addr', None)
+    timeout = f.get('timeout', u_boot_console.p.timeout)
+    fn = f['fn']
+    local_label = f['local_label']
+    empty_label = f['empty_label']
+    exp_str_local = f['exp_str_local']
+    exp_str_empty = f['exp_str_empty']
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
+    assert "Config file 'default.boot' found" in output
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
+    f = setup_pxe_boot(u_boot_console)
+    addr = f.get('addr', None)
+    timeout = f.get('timeout', u_boot_console.p.timeout)
+    fn = f['fn']
+    invalid_label = f['invalid_label']
+    exp_str_invalid = f['exp_str_invalid']
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
+    assert "Config file 'default.boot' found" in output
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

