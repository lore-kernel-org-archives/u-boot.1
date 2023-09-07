Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D0FEC8724
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 13:00:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E864886785;
	Thu,  7 Sep 2023 15:00:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X+KcekrM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6A998691E; Thu,  7 Sep 2023 15:00:26 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 647E086682
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 15:00:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOn7mw45AL4t+vU2zqDuUwZ789JwJ4Zp6NIERpj0ZYY6qUs7g3rLX0WS9P2UZzj264hrzZmMFT+Q5T9t+z49GAc5kMZA5e6MA8uFuWm0BC855uS1+3KHwCUSAItowy2QRQjGAwzCNTNOTXg2MJgMU/70FU/arlAcU/4D3TgCEpk/Fn/u5pPMbAW8iDQkCEPhWcSKmh6YXl1bq1V8cZMPeCKfxk8frYvKqPsCqnCeki0oAnUmTUcgNKDQ5Y7ZWRYzouL8oIXlIQjCvx6MCLdrAY6vp/6va6ZlA1bC2Aoh5Xzd6e9fxwShUIsk09fNqNILkYsgo7fcT/0TECILau/2Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxizLH5ANCN1zD8oiOuqTcpXBGpiF7UtVaUFgbnFUy4=;
 b=U2FOdjtsXDJtJJtyfbH6a54GGqMBVbiiGGs5YpLF6tXVY9FRjDQgzWW/UQagce9d58Xm4Py4hRahShQnFaQPP4rfizQvM/zKWqZoelzbrPIYPD79nNufIi6BdpmqEuZMYD0tKz7I67dfCj+wRVZeh+OHlEknKdEBWR8aAcLaiTlF78HmBFOAkitVR/xznzLpWIO7IrHS5mP4IwjmlYReRxpkW9/r8CIPdwNG+jQQ0GTW5/bmSzGaIsc5XnlYnn6IvRXJrJMBDMZVT73XRSoCK8pF5wpO7cpoWjPhB1pvBWTEyGjcJbAC1vSc0yCmqz43RUJ4cKHxO/AkmvTL9d+BLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxizLH5ANCN1zD8oiOuqTcpXBGpiF7UtVaUFgbnFUy4=;
 b=X+KcekrMqjOfJsle2lWV6QFowrNAgoTnUoQsMKyy/91AW76rDG7LGPgsDn/f0it5/EwINiBIwISvIbZSgdUxHbJAMUB2kU9BUw2sAm+xn9l0qbldknhLJ07zBTF/yEd0gGiq8rZcLHS3AXKVZTM7YqP40TlfexIgmfbTmw/7lL4=
Received: from CY5PR15CA0136.namprd15.prod.outlook.com (2603:10b6:930:68::24)
 by DM4PR12MB5072.namprd12.prod.outlook.com (2603:10b6:5:38b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 7 Sep
 2023 13:00:19 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:68:cafe::48) by CY5PR15CA0136.outlook.office365.com
 (2603:10b6:930:68::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.37 via Frontend
 Transport; Thu, 7 Sep 2023 13:00:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 13:00:18 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Sep
 2023 08:00:16 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Alexander Graf <agraf@csgraf.de>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Angelo Dureghello <angelo@kernel-space.org>, Bin
 Meng <bmeng.cn@gmail.com>, Sean Anderson <sean.anderson@seco.com>, Simon
 Glass <sjg@chromium.org>
Subject: [PATCH] global: Use proper project name U-Boot (next2)
Date: Thu, 7 Sep 2023 15:00:15 +0200
Message-ID: <044d9cffc3d8ed891b40d24c63ff74445cb3014b.1694091612.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7791; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=4P9U3IC4BwlZlTpkhXezQM7zAX22x4iMnktIEF6/jDk=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpSfJ2PvSfld+13C+0S7cvqnVsZ57DKWKvJWKq9vhHBeU
 laIM5vQEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACYiEsQwP12GbYUgn1bD03Ui
 uv5Sj5boKl1bz7Cg/2v0w5Wes8rrz8s69Z78HZN2fFcFAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DM4PR12MB5072:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c59382f-47d9-45c2-6be8-08dbafa26309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E1tGvxHAYFtZwh0XOSBGyB4XJ2qkU8I3sSZKYmPHJ9APfmyupyWnJsrZexGuASNIsAKnunuaSimmdh3C1AvErXeyeN71mnMMhZjsiav/TIABNCLo/+CBnmUYKc1RQvKBn77LiCvMxExbDkx2gRDWD0doP9/m83CBNCdiX7GmaTL+uNACA2HyMneCTO7GSrvie683dasZgdcxyDQL8VJia5l5iuyRkPjgjwEcK5/dh7Peke5ysHeCcofpybTanEzkmio5sghsMLfPL48HE0x2NEwWi0xvQ+Y9Upjai2U7IvNBG3JoosWGZH7fVphXWW8R0kE1fnvVCzrg+J1IplI2nNTyV9VXbscn0GpYklrro6XtMLzUZYp/bgmUMryl/626f1966ZGa5g0zzjkoMlmX0K40FCHXgIafKC0b8BUfRX7qqfnTxR7J7knwpxrgTrIc8j2FvSlJgpxmPN8FZ+jE/K4K8ZvjmTDpC4coWfTYXk64/MF/uPac2kBZfZaA2kpOPV1UmgaNy3/jW7vLbtCZLwL202G9k60fN4FvcyIWdJXnDlUtnSViVOF6NrApDyD0nj1iyKHMS4Jmd4jkxG4Im2xcHs1sjlhO70snXFkkhSHUr8ddKgqyXubgBfSseh/BH873NBqsc41lfl0guvhyy4bpTVgkjvaZrD4LdeALpweHuvk2O3jlSL7hnLkZcK3BTq9qZstP8JE9HsPpV8hncdRq8YzvcFmhu/k1B8cF2L27ks+LWNzbC0erSPi5/T0VVLT53wKPIn9lvzofJOqP3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(82310400011)(451199024)(186009)(1800799009)(46966006)(36840700001)(40470700004)(478600001)(83380400001)(2616005)(26005)(16526019)(426003)(336012)(2906002)(44832011)(54906003)(70586007)(110136005)(41300700001)(5660300002)(316002)(4326008)(8676002)(8936002)(40460700003)(40480700001)(47076005)(36860700001)(16799955002)(36756003)(15188155005)(86362001)(81166007)(356005)(82740400003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 13:00:18.3087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c59382f-47d9-45c2-6be8-08dbafa26309
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5072
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

Use proper project name in README, rst and comment.
Done in connection to commit bb922ca3eb4b ("global: Use proper project name
U-Boot (next)").

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/cobra5272/README                      | 18 +++++++++---------
 board/emulation/qemu-ppce500/qemu-ppce500.c |  2 +-
 doc/board/xilinx/zynq.rst                   |  2 +-
 doc/board/xilinx/zynqmp-r5.rst              |  4 ++--
 doc/imx/mkimage/imximage.txt                |  2 +-
 doc/usage/environment.rst                   |  2 +-
 doc/usage/semihosting.rst                   |  2 +-
 tools/binman/entries.rst                    |  2 +-
 8 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/board/cobra5272/README b/board/cobra5272/README
index 11abcfacdb6e..0b07148b73a3 100644
--- a/board/cobra5272/README
+++ b/board/cobra5272/README
@@ -1,6 +1,6 @@
 File:		README.COBRA5272
 Author:		Florian Schlote for Sentec elektronik (linux@sentec-elektronik.de)
-Contents:	This is the README of u-boot (Universal bootloader) for our
+Contents:	This is the README of U-Boot (Universal bootloader) for our
 		COBRA5272 board.
 Version:	v01.00
 Date:		Tue Mar 30 00:28:33 CEST 2004
@@ -31,7 +31,7 @@ Please refer to u-boot README (general info, u-boot-x-x-x/README),
 to u-boot-x-x-x/board/cobra5272/README and
 to the comments in u-boot-x-x-x/include/configs/cobra5272.h
 
-Configuring u-boot is done by commenting/uncommenting preprocessor defines.
+Configuring U-Boot is done by commenting/uncommenting preprocessor defines.
 
 Default configuration is
 
@@ -48,10 +48,10 @@ Default configuration is
 
 
 #-----------------------------------
-# u-boot FLASH version & RAM version
+# U-Boot FLASH version & RAM version
 #-----------------------------------
 
-The u-boot bootloader for Coldfire processors can be configured
+The U-Boot bootloader for Coldfire processors can be configured
 
 	1. as a standalone bootloader residing in flash & relocating itself to RAM on
 	startup automatically => "FLASH version"
@@ -60,7 +60,7 @@ The u-boot bootloader for Coldfire processors can be configured
 	prestage bootloader ("chainloading") & is running only from the RAM address it
 	is linked to => "RAM version"
 
-	This version may be very helpful when installing u-boot for the first time
+	This version may be very helpful when installing U-Boot for the first time
 	since it can be used to make available s. th. like a "bootstrap
 	mechanism".
 
@@ -71,7 +71,7 @@ How to build the different images:
 Flash version
 ------------------------------
 
-Compile u-boot
+Compile U-Boot
 
 in dir ./u-boot-x-x-x/
 
@@ -81,14 +81,14 @@ please first check:
 
 		CONFIG_MONITOR_IS_IN_RAM has to be not present in the file
 
-	=> u-boot as single bootloader starting from flash
+	=> U-Boot as single bootloader starting from flash
 
 
 	in configs/cobra5272_defconfig CONFIG_TEXT_BASE should be
 
 		CONFIG_TEXT_BASE=0xffe00000
 
-	=> linking address for u-boot as single bootloader stored in flash
+	=> linking address for U-Boot as single bootloader stored in flash
 
 then:
 
@@ -116,7 +116,7 @@ please modify the settings:
 
 		CONFIG_MONITOR_IS_IN_RAM=y
 
-	=> u-boot as RAM version, chainloaded by another bootloader or using bdm cable
+	=> U-Boot as RAM version, chainloaded by another bootloader or using bdm cable
 
 
 	in configs/cobra5272_defconfig CONFIG_TEXT_BASE should be
diff --git a/board/emulation/qemu-ppce500/qemu-ppce500.c b/board/emulation/qemu-ppce500/qemu-ppce500.c
index a39bcb4fa0c7..40fd9e5e02b1 100644
--- a/board/emulation/qemu-ppce500/qemu-ppce500.c
+++ b/board/emulation/qemu-ppce500/qemu-ppce500.c
@@ -318,7 +318,7 @@ ulong get_bus_freq(ulong dummy)
 int cpu_numcores(void)
 {
 	/*
-	 * The QEMU u-boot target only needs to drive the first core,
+	 * The QEMU U-Boot target only needs to drive the first core,
 	 * spinning and device tree nodes get driven by QEMU itself
 	 */
 	return 1;
diff --git a/doc/board/xilinx/zynq.rst b/doc/board/xilinx/zynq.rst
index 438912fe42c2..76d67bd62ee9 100644
--- a/doc/board/xilinx/zynq.rst
+++ b/doc/board/xilinx/zynq.rst
@@ -83,7 +83,7 @@ Mainline status
 ---------------
 
 - Added basic board configurations support.
-- Added zynq u-boot bsp code - arch/arm/mach-zynq
+- Added zynq U-Boot bsp code - arch/arm/mach-zynq
 - Added zynq boards named - zc70x, zed, microzed, zc770_xm010/xm011/xm012/xm013
 - Added zynq drivers:
 
diff --git a/doc/board/xilinx/zynqmp-r5.rst b/doc/board/xilinx/zynqmp-r5.rst
index 2cd368b0308e..266d07d1193f 100644
--- a/doc/board/xilinx/zynqmp-r5.rst
+++ b/doc/board/xilinx/zynqmp-r5.rst
@@ -26,7 +26,7 @@ configure and build armv7 toolchain::
 Notes
 ^^^^^
 
-Output fragment is u-boot.
+Output fragment is U-Boot.
 
 Loading
 -------
@@ -38,7 +38,7 @@ Bootgen
 ^^^^^^^
 
 The first way is to use Xilinx FSBL (First stage
-bootloader) to load u-boot and start it. The following bif can be used for boot
+bootloader) to load U-Boot and start it. The following bif can be used for boot
 image generation via Xilinx bootgen utility::
 
 
diff --git a/doc/imx/mkimage/imximage.txt b/doc/imx/mkimage/imximage.txt
index f2cf23c5dab8..fa4e486661c2 100644
--- a/doc/imx/mkimage/imximage.txt
+++ b/doc/imx/mkimage/imximage.txt
@@ -213,7 +213,7 @@ Disk identifier: 0xb712a870
 	Device Boot	 Start	       End	Blocks	 Id  System
 /dev/mmcblk0p1		     3		16	112455	 83  Linux
 
-I have set 100MB, leaving the first 2 sectors free. I will copy u-boot
+I have set 100MB, leaving the first 2 sectors free. I will copy U-Boot
 there.
 
 8. Write the partition table and exit.
diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
index c6439dde6689..c57b717caaf3 100644
--- a/doc/usage/environment.rst
+++ b/doc/usage/environment.rst
@@ -216,7 +216,7 @@ fdt_high
     0xffffffffffffffff (64-bit machines) then
     the fdt will not be copied at all on boot.  For this
     to work it must reside in writable memory, have
-    sufficient padding on the end of it for u-boot to
+    sufficient padding on the end of it for U-Boot to
     add the information it needs into it, and the memory
     must be accessible by the kernel. This usage is strongly discouraged
     however as it also stops U-Boot from ensuring the device tree starting
diff --git a/doc/usage/semihosting.rst b/doc/usage/semihosting.rst
index 6a280b455e0c..9303a6364d5d 100644
--- a/doc/usage/semihosting.rst
+++ b/doc/usage/semihosting.rst
@@ -23,7 +23,7 @@ eMMC or other NV media are available.
 There are two main ARM virtual Fixed Virtual Platform (FVP) models,
 `Versatile Express (VE) FVP and BASE FVP
 <http://www.arm.com/products/tools/models/fast-models/foundation-model.php>`_.
-The initial vexpress64 u-boot board created here runs on the VE virtual
+The initial vexpress64 U-Boot board created here runs on the VE virtual
 platform using the license-free Foundation_v8 simulator. Fortunately,
 the Foundation_v8 simulator also supports the BASE_FVP model which
 companies can purchase licenses for and contain much more functionality.
diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index e7dfe6b2a363..a8c7423c4005 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -2505,7 +2505,7 @@ Properties / Entry arguments:
 See Entry_u_boot_ucode for full details of the three entries involved in
 this process. This entry updates U-Boot with the offset and size of the
 microcode, to allow early x86 boot code to find it without doing anything
-complicated. Otherwise it is the same as the u-boot entry.
+complicated. Otherwise it is the same as the U-Boot entry.
 
 
 
-- 
2.36.1

