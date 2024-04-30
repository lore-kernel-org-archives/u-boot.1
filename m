Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296BFC4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 08:55:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 531AB88500;
	Tue, 30 Apr 2024 10:55:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s7PtXS5G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F04488258; Tue, 30 Apr 2024 10:55:06 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31F4788258
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 10:55:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0fWmc3cGR2IWDwQ/MrlPIMimV1Ry+0fENuDVDmKHkUh0baZmtV0+rBN10dfMPFJih8OTN2V7jzwHEacNgP1oIFiGU/KnZVtzSjD1xLV824HcmlurGE1Z9s2oEJ4VXLRw02lJ/ydDkWxmnCD8NzPnxAPYzv/t7SCP/KbNqIGIRuxxdgAMwtlY7Q+4ZPCbVl6zCMlph3TRdlnPUVg5W+n4ikylIHd3oDUWm/8NDGCfM+iCTWgChhovHKuR/MiKH30GDT3ODu27PqIaloTJ6ds2W3bYcCKP5SJYM1HbeRDlxtKo06dQmlOzx6SvgZD/3pqrc0lgF8aVT9GMVX/erYmtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bxpznPJ5ZJ8b0Xwxbz4W6/bAUmzQNVgyMVnNCJe+2o=;
 b=OxwPDfVqZnJOPGPEMohH0zyb/TKXTMAJ9i3JCgMAp7v8urNNAyWTy3f2eBttpW6rgJ/Al0lBW8ii3gsWThlCuJIATCY+HAf/tOx268GCyKINZVpLfiCu8T1fRqLtTf7bYuQr3j3NsSqJYKrP55vocQPw1TgwkAGzBBYLf3juVcmkQGgErLspXCmrPH+BBwATTSG8hW/sPBAaO38paF6mYhhmKJkFrNA4GT/ctlb4i1L6rAw/ByET0ED41lwpP3nu2EOrSDtLqMkKDHjbDBY3ZTc7n+h6k7K42zZKZh25gWPqelroOxolI/3+qJ0JS8LgB9aKuhr/L+TI0S+ef8bzRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bxpznPJ5ZJ8b0Xwxbz4W6/bAUmzQNVgyMVnNCJe+2o=;
 b=s7PtXS5Gfu5A8yWO9h5sGJ56bBmZqw8Y/DQTUX9f7KbDJX1N9GlE4UvvATNsnK838MFU/eY2yu/NrODn+rHluGkQwCVVZTMxCev9XL2MJs8tMlZvv1qGbUn20xFnM2ssPpPn7DPcZqYfCzrxoRNSw+dBSSYWg8TkSpfEnhZrWMk=
Received: from MN2PR05CA0024.namprd05.prod.outlook.com (2603:10b6:208:c0::37)
 by PH7PR12MB5709.namprd12.prod.outlook.com (2603:10b6:510:1e0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 08:54:59 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:c0:cafe::84) by MN2PR05CA0024.outlook.office365.com
 (2603:10b6:208:c0::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.22 via Frontend
 Transport; Tue, 30 Apr 2024 08:54:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 08:54:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 03:54:58 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 03:54:57 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 30 Apr 2024 03:54:56 -0500
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH v3] test/py: net_boot: Add test cases for net boot
Date: Tue, 30 Apr 2024 14:24:55 +0530
Message-ID: <1e297cfe3063e6ac6103e0b15fbc61442fc4dea8.1714467244.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|PH7PR12MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f566bb-a791-449c-32f0-08dc68f3371e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RpZS8x1navq6SOTF33F+ic7auQigDnvLwmqbeW6woe1fJDO6YtgsUz1XQI37?=
 =?us-ascii?Q?TxH913NKto1LNqvNTW+JQNO2LF+Pwj4BOQWkcqg2zuVt8+U66O68vSUqo/ug?=
 =?us-ascii?Q?jP9TvcP+CoWdMQq8PQRArF7hWLrNleAYcebCckZA4X0li21Ilc4IcDlRVFkE?=
 =?us-ascii?Q?9yuZVGIVKOJqRi6oFWPmatEfKN3bJPx4lcR+WaUAOlclAtt4wzlDW9iPaXVT?=
 =?us-ascii?Q?u7zYOTRAAwwiFLxZH1HcR0WRy9CLuc+g9umtIPuuGL6dDr7tzM4nZ1P6F7Jo?=
 =?us-ascii?Q?VQL3BQGMp4iaw61ZdHYnWSJFgyC/9/ZQ/USUtcZWqDFZmYstTCqgp24fphy+?=
 =?us-ascii?Q?AA9OpXdu5u71IZGAzVmjPmfR8EtBRLXqMeja80+qv+A4ksW3bWARnfucZj5k?=
 =?us-ascii?Q?cifUmWr3mYQoWPLDdg6goNSQlt2lAPUJLe8jtWkGoOjaBt7B5mKQzLLyVLfn?=
 =?us-ascii?Q?4PgHHKRSaaha5lOTOU5YDoU/7R29DAsH0Wn4n3V/b5gMmchAOQqQqJ+uu39N?=
 =?us-ascii?Q?CQA2cJUrr5+vL8j0lVytlCxADuAOaAUcAXHlmZ3mmflL9dLraeOh1FWaMVGu?=
 =?us-ascii?Q?BagcDOhfbQqGM0uhrf1kyxxDpa2muIYyHtcISPw3nEIZoxdqYHpTyyg4Bc1L?=
 =?us-ascii?Q?sT6cJ6Go9gDak6HsiplBQ+aG0lidk0VgMM24LZHQmkvcJcSeTa/mqRgyerk2?=
 =?us-ascii?Q?6gPxKEhgAhbrxiw3lNCDproEj9btYu98b5eJwoRuVY7uSaPGFXIuyq/Wv/fn?=
 =?us-ascii?Q?BVh5Njw4DQtmsIIPdkJi+XzyK9Nmeec7H3Ei7QFIFtdDUUx1rMECJJenn7wG?=
 =?us-ascii?Q?XkIdXrMAJSL0SqtYRKfSC/qDo+46KDzChAKu8PDWJjSSTBAOn6DWEBUFxkpI?=
 =?us-ascii?Q?qpBSpMyo1ujLlBMoolrqDqFy2AY3aZcdu3LDWmHaWxEuN4eTLWdihQ4Wnvb2?=
 =?us-ascii?Q?IE5CHwTg24t5C3AVKg20SpNbJiEgdZEUlj6XnIc5YJ2r/JcVrGNz0NjIDzZS?=
 =?us-ascii?Q?3kdlZ50tA7aa3aKQhdAjYxSffYqQ76Zovht5tUc4P4Cf9NHR2C7zpSIUelgx?=
 =?us-ascii?Q?r/8K96vE3ZBLdrSWbjB2g1H3xRuWPd3SNnSaxwgp/qVcFc+p3+nn83xkf2GY?=
 =?us-ascii?Q?xdMklcPpAPGENe6iyVpPkdS7mEBdrc9fUogCm75UrDYjNARBgGfhuE9kFyzu?=
 =?us-ascii?Q?YGOM9UETXU1hSsQpojBnAefAA7N0DJLnl10SDZG/iwhThsP3NbHuEPdoK0/x?=
 =?us-ascii?Q?B5mwMt0Wtrvd55Tk9p+qmtISnMaEEkwmkA0AsJmg+S7jfrITR/DXioo/ZRZa?=
 =?us-ascii?Q?8FwohbyOxqA+hMAd+iXgl336?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 08:54:58.6460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f566bb-a791-449c-32f0-08dc68f3371e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5709
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
---
 test/py/tests/test_net_boot.py | 391 +++++++++++++++++++++++++++++++++
 1 file changed, 391 insertions(+)
 create mode 100644 test/py/tests/test_net_boot.py

diff --git a/test/py/tests/test_net_boot.py b/test/py/tests/test_net_boot.py
new file mode 100644
index 000000000000..cf7d5cca5cbd
--- /dev/null
+++ b/test/py/tests/test_net_boot.py
@@ -0,0 +1,391 @@
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
+    output = u_boot_console.run_command('tftpboot %x %s' % (addr, fn))
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
+    timeout = f.get('timeout', 50000)
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

