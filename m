Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32421C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 12:10:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4491188BD9;
	Fri,  3 May 2024 14:09:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LHdFW5zl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D521A88BE0; Fri,  3 May 2024 14:09:57 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::625])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2458688307
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 14:09:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQXG/jGHh+2A6Alv27d+f+bAsDz7dCWMmrBPkCyzCqV5IrOUdNzmwcRfobpCwqN+eK9/vaT1z2KwurgQ7cM2/odEZV9f10jTMcTaXKRfCsvmIpqyAHwBTthPvI/CZcQcb5fnLcqnOtlBEBeyUVnVqGM88qem2Qpo9Iph+YhYiVFTskilBo3p1fFY75T5EsyZmQMdnm7u5FAIEOu9z9gr/4uecSBeCKb6enLtdDQ5nyO5a6UXGAO/+QhEhNEv3uoc248Eq4ehurWa2Xsd35TGuzDKqResLZZO4Coo2lSCRAGanw3hKK291oDidda7Fcstojc/TNi963KF9ZBU5NXIzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+du8Non+sGco+8GCHAZCB+9NTovHBcrsTm/ylYPEk4g=;
 b=WDt817lF/ZHyMCFqfg7n0BgwpHUBZAidJ/btjgqUhWXxtqx6Zuc1sFCutqfBgM8ir6x4mkXdyW51IOZAl7c5MzjZaqa3m+ZelFd8QNUCmAym95R902FU3FmR+LfC4zWhFcaUgt1KKhUMJ3qWAKcO9nX7nqJQCvdFGX2pzVqtv2UNJ+E4WFA34DBHbuhWKuoTEvmxnA5zOQMBsr4I5jw8ukWM+/X/QLaFZrYaXkcXAHtfN0msoF+oodYn9Ljz+QAVDBGWQgDjEaFtG+IRU0vN+QieVuo8etEB2AWbdtRL2lhKRyRtq20K5gdyKG14LMVRpRQrR4GqIXzoUWNOAu+NUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+du8Non+sGco+8GCHAZCB+9NTovHBcrsTm/ylYPEk4g=;
 b=LHdFW5zlCjm592L5KZChdz+htZGGDb7ui+MLjmx8bhunaZjhPDA/cNf9qvwADEKwLdEstVKEM/d6gj6FE8TIX76305VORI6myZwkyCsyYAcPwpCg4CrWdzP8YRMzsqnlVu0Zp3pg9w0grba95mmNBILJyredfBq45oeF5HyVRa8=
Received: from CH2PR07CA0061.namprd07.prod.outlook.com (2603:10b6:610:5b::35)
 by MN0PR12MB5881.namprd12.prod.outlook.com (2603:10b6:208:379::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.34; Fri, 3 May
 2024 12:09:50 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::eb) by CH2PR07CA0061.outlook.office365.com
 (2603:10b6:610:5b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29 via Frontend
 Transport; Fri, 3 May 2024 12:09:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 3 May 2024 12:09:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 3 May
 2024 07:09:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 3 May
 2024 07:09:48 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 3 May 2024 07:09:47 -0500
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH v4] test/py: net_boot: Add test cases for net boot
Date: Fri, 3 May 2024 17:39:46 +0530
Message-ID: <d08d45f50dcdfb70e22a27cf13a990bcc2c020fc.1714738132.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|MN0PR12MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e6607c3-2ee1-4a5b-fdb3-08dc6b69ee77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xmf7WRDNf5nNDx1PYmy3GTOETaoa8hfcSn9csSDLW47B7HxXr28igeaJii2X?=
 =?us-ascii?Q?N2YPgL03sVNkKU0Kt7oCwxXdMw26wh/TS9r3FloQU6LPk0PwztNpCUbNLprE?=
 =?us-ascii?Q?hChMqut0F1yAmodc3YpI93BZ1OL6KMq44TqbQclxwiyZjKYvzag322rWSQgC?=
 =?us-ascii?Q?RnPIxgwgLkGoRszqYFvM5pzz+7O0Bn1NlTSLlBQt/k1F/u9+bXVQzGzM1c6I?=
 =?us-ascii?Q?ipjTRFFxgaRDWsKaG+JFGAamtFGrpVy6TeN88unyXYLcIiDJJK154xfnxmZz?=
 =?us-ascii?Q?x/uOdvCvIfqSE1KP0eo+36NaZPWgZr6PNoAsTJHF9WZywC9xtUh3yHCb4zql?=
 =?us-ascii?Q?BlmALzxW/83dVbgoTf1mVD9meDXLrHNbcw0k6GcjhyKd1RnTSBVSZe4jLjtV?=
 =?us-ascii?Q?VE2YvhAOYh45w0UMPQleiztBZCwnkN8YvArO7KvQ798GQXKf+s1UdbhfaHZE?=
 =?us-ascii?Q?hbld36fEp0WkmxOMRu1nwOT0cYC1/8wNMqxAwXrMTPzuFYtR0+yo5b72VcZ4?=
 =?us-ascii?Q?SFJGqVb/8tO116LR4Fgq5euDv28Ts+17GMPARSR2gYDerDAqLlvyekSfLT+f?=
 =?us-ascii?Q?ZKx89kazqEmSTMlNRIhDtmDoCOKUz4qz95mFYZSyTYkq5fhYK788DQuQm53h?=
 =?us-ascii?Q?h1P+jvBfY827xqIJfKdI4YzyzMaUlAIBn24sxBiYOlTS2khBIZnO1RwN2dL7?=
 =?us-ascii?Q?jN23vdL4+I3Qiwc9Kb8jI8DcffjiIijzCuM9XSCWiIFxiMYoPbPjQCe6V6Pg?=
 =?us-ascii?Q?9nmgCNHKfzwdk4Xsyg6JOoall9lIL4B5FJ4vgKzi10PJGunx9jpToKmhVtVh?=
 =?us-ascii?Q?96wI9QDJMl1d86yHuDcg7tTy5ayF+2TjbOD8TC5ZmHKNP+Eltlgl+QccxtFu?=
 =?us-ascii?Q?TqSsimhMb/0F9CtU6VvY1mEeUJzjLqH7dM9f9O7KJdRmuJfh0o510u34eJzX?=
 =?us-ascii?Q?ZrYgXS4pnYOmTmvugRc7rfigREQEwnF4Z2YZkee9wklr+Yis9BzDI935OdBj?=
 =?us-ascii?Q?/B5ewj1e2CdWwV4QT42fTfhRJ6bVibUmLjGfsjaVpqmzQdKKmlk0rSxq9yeW?=
 =?us-ascii?Q?sCmYBqVs1w5w87BawJb8/q7fB/MPaqavuFjq02wgrJPHtCsxuDlLHn8R+RLi?=
 =?us-ascii?Q?nRn5iFTMFUCO4S7PwtK5LNjfC2wAKmpJkQua2AHhSijEjqFt5sM8/9RBBxLq?=
 =?us-ascii?Q?sqn59/DCXGbePHgbZODAFl1B5IFNnJOvAqSHnee+Z+ZweSSAS6hanMXDD6gr?=
 =?us-ascii?Q?q9vkmp38VWM6K7Du4Qv7y2KRjcIqIVUHIBZ3rRRyehMuzN0qbye8L9UXkwVb?=
 =?us-ascii?Q?rxJ4v+vvmP4iPZKHvkKgnlu/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 12:09:49.5565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6607c3-2ee1-4a5b-fdb3-08dc6b69ee77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5881
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
---
 test/py/tests/test_net_boot.py | 394 +++++++++++++++++++++++++++++++++
 1 file changed, 394 insertions(+)
 create mode 100644 test/py/tests/test_net_boot.py

diff --git a/test/py/tests/test_net_boot.py b/test/py/tests/test_net_boot.py
new file mode 100644
index 000000000000..fb0fb7e80414
--- /dev/null
+++ b/test/py/tests/test_net_boot.py
@@ -0,0 +1,394 @@
+# SPDX-License-Identifier: GPL-2.0
+# (C) Copyright 2023, Advanced Micro Devices, Inc.
+
+import pytest
+import u_boot_utils
+import test_net
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
+    config = f.get('config', None)
+
+    return addr, pattern, timeout, config
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
+    addr, pattern, timeout, imcfg = setup_tftpboot_boot(u_boot_console)
+    with u_boot_console.temporary_timeout(timeout):
+        try:
+            # wait_for_prompt=False makes the core code not wait for the U-Boot
+            # prompt code to be seen, since it won't be on a successful kernel
+            # boot
+            u_boot_console.run_command('bootm %x'% addr, wait_for_prompt=False)
+            # You might want to expand wait_for() with options to add extra bad
+            # patterns which immediately indicate a failed boot, or add a new
+            # "with object" function u_boot_console.enable_check() that can
+            # cause extra patterns like the U-Boot console prompt, U-Boot boot
+            # error messages, kernel boot error messages, etc. to fail the
+            # wait_for().
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
+@pytest.mark.buildconfigspec('cmd_net')
+def test_net_tftpboot_boot_config(u_boot_console):
+    """Boot the loaded image from FIT image configuration
+
+    A boot file (fit image) is downloaded from the TFTP server and booted using
+    bootm command with the custom fit configuration, its boot log pattern are
+    validated.
+
+    The details of the file to download are provided by the boardenv_* file;
+    see the comment at the beginning of this file.
+    """
+    if u_boot_console.config.env.get('env__tftp_boot_test_skip', True):
+        pytest.skip('TFTP boot test is not enabled!')
+
+    addr, pattern, timeout, imcfg = setup_tftpboot_boot(u_boot_console)
+
+    with u_boot_console.temporary_timeout(timeout):
+        try:
+            u_boot_console.run_command(
+                'bootm %x#%s' % (addr, imcfg), wait_for_prompt=False
+            )
+            u_boot_console.wait_for(pattern)
+        finally:
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
+    if not addr:
+        pxe_boot_cmd = 'pxe boot'
+    else:
+        pxe_boot_cmd = 'pxe boot %x' % addr
+
+    with u_boot_console.temporary_timeout(timeout):
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

