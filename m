Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9724EC25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 14:33:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E71287ECD;
	Mon,  3 Jun 2024 16:33:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o0wcb9NM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C852D882ED; Mon,  3 Jun 2024 16:33:55 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41C188780E
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 16:33:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oa+PZ43DXI8suSNpVtKgF71jnKqsi5+HVrfF69hi2ghfNtppum5JlRUiWJtaqp95RAita4BVjheVsgbd1JKH+mMQJr4u6ke4FkLKtiPMnsRgymrCrpX4mL68Fupn5Xisc7I1JAwo8seIbAUulLZ+ehL3FCqSWzKAomBEPjwHpLQpdGQ2cwh/1Hb5zvxxHfzPP7suZMRxQjCCZWx2Tfml2r6keWY0yKtLMka6Ux4SiqmebIOfQ8Fk9y8ZW8YeRWoXZfeVIj4vCAVavenDCfpD0eiltJSitmbDX5rO4K4C5WVxH58Qe+FnkotGegje+baPrB5myl+9EOC/jaoiPpv3yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eacTUfysxXW2iuPCLNYn24Vtyq8WyjWssdKRimeIugs=;
 b=DOSjQE3tbCa2Q0GzRZphWzXVBmxAlUBt+2ySxONbG7OW8IVL+q+9Bzj0wgUVeVzbuf01uQ9UydWPGpdtHIw1ZFgA6lNTRTjSz3HkldcegYkXR8ezSO6ob7TaEKGttdsRQXK2KsP5SsEU/UaMt7PYA87cZsJkQ+xYjIbIz5Z+yoc/rTIuxu9PnUBOQWT3XMXgnKm2D8Cys9ghXNRVed6DGUex8IJDktaXhCMMKAN+qbt/r5P2+WJA+i+wEV9DdlonX6gct6JZR4luP1soi+MsQrSRWrD3H/MKcGOlnLptaN6GbIKB5GZIho+5DXPhUnybslXdol0lqgFp3Mrgh+3Hgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eacTUfysxXW2iuPCLNYn24Vtyq8WyjWssdKRimeIugs=;
 b=o0wcb9NMdjmtKd1wE5SSKJ+4qmuRHrMJbOpC2dWn/iKnkM2A31nppNV7gdV9IbTYfx/7kP5BhMiOIQsktHc5QehR+E0Dr6Np/DvjQGMcY5SZX2pzzqQGO/i9ZrlqzPMn7VthjcyW3lHimm5hKdI9ciFmv/CjS9Qy1+vgqu6Fgmc=
Received: from SJ0PR03CA0271.namprd03.prod.outlook.com (2603:10b6:a03:39e::6)
 by CY5PR12MB6621.namprd12.prod.outlook.com (2603:10b6:930:43::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Mon, 3 Jun
 2024 14:33:49 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::71) by SJ0PR03CA0271.outlook.office365.com
 (2603:10b6:a03:39e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Mon, 3 Jun 2024 14:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 14:33:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 09:33:48 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 09:33:47 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 3 Jun 2024 09:33:46 -0500
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH v6] test/py: net_boot: Add test cases for net boot
Date: Mon, 3 Jun 2024 20:03:45 +0530
Message-ID: <3dcb3163c4b685d4ddd5f9d4149ac82a43955fe0.1717425151.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|CY5PR12MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f77ff2-fa34-48e2-e592-08dc83da2ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZV0tzMUo0LWnAEW0ImoUWFWrc7G1ryYiKWpnApdfd5VVdmbLIbNLK7klNn0E?=
 =?us-ascii?Q?E2aMyVIxXsBl+AUxdcksjJr80fizKsXKPQFlqhLGKtSK+h5TrGHGBm1yGbd4?=
 =?us-ascii?Q?wfIjqnpyuExvLSbwyFpGm0m8byZ/3ykhfMSILz8ryPNmN5AyJyVPEEuT8IJH?=
 =?us-ascii?Q?+0l3KutPGFwXP6tmSCRoEiDve/QKpSb93cPYVgdCHnNBqQkMmwooEmP/3wBc?=
 =?us-ascii?Q?EDf5XxMioivykNnLT0PC4XN+H9y1oulfkwyn/1ETnh8Iakhkd+AO1LrhakNT?=
 =?us-ascii?Q?OWy9+c1J4OtKg2xlqrp54cY5BYsiyO5dCnaat5AVTiQN1vdh2G2vdWIij4RM?=
 =?us-ascii?Q?9ScAPYFqafTaxjoLzZLv88w7vZ3lMnp7IA7VarNsxCYYEOVNK8XhLT61q7w8?=
 =?us-ascii?Q?dw5CE6Z988nkG6i1LJBAm0ELvRuAlvpaF69JtccelxH4lIxb5YQOHq9kqZCo?=
 =?us-ascii?Q?jFoC6g/WyKyxXqJkK+oOZ1vSzIOFf7JXzXiEOZ26Oi2q8RkITeYbHuqBP63D?=
 =?us-ascii?Q?eu5sh60Dz1XgL/LJHOLk7t/NDGm3Px6mrrSvwPm5n6xBTwKosP2YCoWWfekj?=
 =?us-ascii?Q?lxmj/sAnee7bu/x0ALZg/h7YHdP+xEdqm6p9AXo09rrZsU5y2B8OUHeetGXW?=
 =?us-ascii?Q?2Q74GnM+qzEPhMqk0dLuXgxNX8MLIxcgHakoFmEc+5uYFIw5FuiXm1C8poBS?=
 =?us-ascii?Q?YPbnnk5QvEriR0LzPL+SspGrVigCUY6hm3rLoD2NqrEY+MJpHLnd/dziBrE5?=
 =?us-ascii?Q?L1elGj1FQw70PSCFc1kI028ZHufKFov7eaiHnMzsCW2zGRElhHO3YTLl3/ez?=
 =?us-ascii?Q?dN96AJPw806slkKVdE8C66w3R+/Kh7QPFx1t/f0Mz4CjvB7WFDMXwYQehxE7?=
 =?us-ascii?Q?MJmgpzRCNcQDLP4wlY0yXRlUtwK8jrDki7GfAeLqb/lY8ZWHyACYRCHqxO40?=
 =?us-ascii?Q?osLQtKptBv5uibMmuFT8DWsT+SdQ0VvhI22x5Mddqf391daBgiilpkz9ziS5?=
 =?us-ascii?Q?Bu4aqOHhENaQztczyF/dP8PYEEchceoJ55phbV8DZdiZnSkoBM9lA2oV4XAd?=
 =?us-ascii?Q?AWpcebgd/r2rIo4cOePIY0fbkfvURppGWzM9deAmr0jpE/c4hrnfIBjIdDBI?=
 =?us-ascii?Q?B12cIY4WcFzvwbpgeuO625BAHWfOoEobxt/rfD8mrIvz3/pvv/PLk+M8THPK?=
 =?us-ascii?Q?GRNTuZdBk8CAiPy4W5uX/rpckAeYIvketYi14FyY/Stop66xvD9oAuBta/78?=
 =?us-ascii?Q?fHzRzJ4xEn4PqjbsN80q6z6HlxIgytOgk5jqYhBYxVcuIDWZE0lqmhw2dR/e?=
 =?us-ascii?Q?e932BEqSZ9FdsxY63FGeCECD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 14:33:49.0936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f77ff2-fa34-48e2-e592-08dc83da2ee2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6621
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
---
 test/py/tests/test_net_boot.py | 394 +++++++++++++++++++++++++++++++++
 1 file changed, 394 insertions(+)
 create mode 100644 test/py/tests/test_net_boot.py

diff --git a/test/py/tests/test_net_boot.py b/test/py/tests/test_net_boot.py
new file mode 100644
index 000000000000..41591b192830
--- /dev/null
+++ b/test/py/tests/test_net_boot.py
@@ -0,0 +1,394 @@
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

