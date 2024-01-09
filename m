Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14397C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 07:04:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56FB9877FE;
	Tue,  9 Jan 2024 08:04:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PNv7YUtr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C648487800; Tue,  9 Jan 2024 08:04:00 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::626])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D742387729
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 08:03:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5mkEiwSzDILEIxh1L6hc1QZrY0YrnF72qZiw40VbaNREH3p7jG+s3bWAmX9nMLOg5SGlp9ivxZoREItXQMAsulfyIjUQZmuOj7aw7BmZly0jyRRSorXpDrgWdzGGE31MVcjLl9wXVBJW/DPmbxKeTsbPIwN2Aas2SyVElzUliZDHcUEwxErTYE/dTJfdeSnMOZcLEsxQJ4e3n5h9wMhszKTUGNI3Lb28TiAhkCXOXK8c6WL1YwTQWhqWzuilfGG88i8MtpCn6JWYExlCjnfqWjwwuXSxuf4y0yvwB0GYiVA0zlywvFQKl4Sy+Z+oO2q3/O7PFFRPRelZFUUJ0NMWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J89ZE8MZeLta+HWXekxazfxjyFupQKLl6Q9XhBIkKb0=;
 b=KcwmLNOQe0kwauxv9yhXd4vEg7Azc4BCeVIQ7RIMwSl76yS2gUM3adeNTU43w36dOVozSohF9dNUKzjUOzt25ppkevkM6HKQXIDIo9Z/zDgKkb08KYk/E5pjL8cXfilshxCS/CKv+qnfrWGJf3TjrUku5bFxKL4l5xdBpVgqOo1qRMD27zJLfViYuGJgm+xzJIKTFm9k5n1ZUNw++Va6TRAA+8B4bOq/KdwkphOKTwBRPnmjHc2wI6+Bju8dJEvzHnTe1eQQ8qodRA5INgdAnASKlJtQCDNJM+2AxaaiWSLrVNsXiCqFc/3u35hMTYfqR4la4tzqD4boRnp0FBttZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J89ZE8MZeLta+HWXekxazfxjyFupQKLl6Q9XhBIkKb0=;
 b=PNv7YUtrExYB/3d2i1XT6z3HkTJxkZIvbnmauk5ALJ43AZzcHliu8T34btftdyRwTmtbDijwCebud0ItXPDpfrEbhV43a/Kjd7Wue0A1QDLwa/slHb/YHeo5JywMPn8GKkUBAHNeSYXdSwW1FF6s38FXALZ+HlTjspNrIh7i+h0=
Received: from BY5PR03CA0007.namprd03.prod.outlook.com (2603:10b6:a03:1e0::17)
 by PH7PR12MB6585.namprd12.prod.outlook.com (2603:10b6:510:213::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 07:03:54 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::9f) by BY5PR03CA0007.outlook.office365.com
 (2603:10b6:a03:1e0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Tue, 9 Jan 2024 07:03:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.12 via Frontend Transport; Tue, 9 Jan 2024 07:03:53 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 9 Jan
 2024 01:03:43 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 9 Jan 2024 01:03:42 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] test/py: net_boot: Add test cases for net boot
Date: Tue, 9 Jan 2024 12:33:36 +0530
Message-ID: <46d98c2d18f3577b755b9f0af886307f0d91849b.1704783802.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|PH7PR12MB6585:EE_
X-MS-Office365-Filtering-Correlation-Id: abc563d2-d96c-4927-cc97-08dc10e123e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4d65aYwTIG7cXwbHqHJXsmg+55wb3JYtwF0Fp7MPle/5voWZwSiWBzYNtdOM/5vx2WdeCV5D6ccbBV5nksgYKCHMkYryNJmBVAqBUjiN1Pq8K9kHUBE3pKtBxAfFOAteop+ZN5H2bDEuM6Sq9+BlokO0TJFFpPSnCvG+OtIXY/nWWCayuqbCQLKKNjXP+jWPs6hgxX/sMjc3cbhbxF5IOd6wT+QUPFm+wqhtEtNxyBoHc4dznetmJJqxXlgaZvYS2bLXdkj3l5mM98onrFvYMZZJMxJ5aceUsWB/Ahf+a8Cy9gHrzfxuwBuyg54fEFGc27mYUMYD/KO/IjWZAy130BWvgyzugmgKTyF7PBBMbjP5Xasyr0rMm7bhXn25Sx/CvDrd0kWvUigoiQLmV+u1v0WtC8ZCdpg8VESJXB7/9B0n6ZYAMSFWvGlwJ8QIdksPDwUIPvsNmStxLBJC7XrfoAaJpm7m4gLNV7EaayadNhzYjzAsQ/tF3xw+WT2yRmkLc+OXPkCPdZYNjAXI1bC9o/E6jXqI8JwC+yqu8YGQAmjxVSQcGFhlWoizrQl3O1sHWY82mrna2K8/d1P5mMcFNrJs5zxVOTBAyEC9LaLcd2UsqSBtcaT51eNLR/2KkoLlrooZ544He7KfFweX4dcPBA6QWZCdscTZBszZrcp34uYXDygiLZI+a58ZaBZ3OUT4dKSstBWUj+X9bx4eGzUAkceGqKVXIrpsO8X81njetL75wq1G5KsrhA0k/8hApWYa
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(40470700004)(46966006)(36840700001)(40480700001)(84970400001)(40460700003)(83380400001)(41300700001)(70206006)(70586007)(36756003)(81166007)(356005)(86362001)(82740400003)(36860700001)(47076005)(426003)(336012)(107886003)(26005)(2616005)(2906002)(5660300002)(6916009)(54906003)(316002)(6666004)(478600001)(44832011)(8936002)(8676002)(4326008)(30864003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 07:03:53.4597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abc563d2-d96c-4927-cc97-08dc10e123e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6585
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

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
 test/py/tests/test_net_boot.py | 371 +++++++++++++++++++++++++++++++++
 1 file changed, 371 insertions(+)
 create mode 100644 test/py/tests/test_net_boot.py

diff --git a/test/py/tests/test_net_boot.py b/test/py/tests/test_net_boot.py
new file mode 100644
index 000000000000..a1faf0db281b
--- /dev/null
+++ b/test/py/tests/test_net_boot.py
@@ -0,0 +1,371 @@
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
+    test_net.test_net_setup_static(u_boot_console)
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
+    addr, pattern, timeout, imcfg = setup_tftpboot_boot(u_boot_console)
+    response = u_boot_console.run_command('imi %x' % addr)
+    if not imcfg or not imcfg in response:
+        pytest.skip('The custom configuration not found')
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

