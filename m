Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C6DEE57D6
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 07:11:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4D338631F;
	Fri,  8 Sep 2023 09:11:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wipRYL0S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE7038642E; Fri,  8 Sep 2023 09:11:43 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::61c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 820E685DEA
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 09:11:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKFFTfK8A6WV8hLLan5ZQthw97altlxRvuL1zYH5Cx5rpMKlokLXpyWwPMkQ8pAKPNs3k8t4Fz2/ovs9c59+/tDuJCrBXj8jvh+n6QBCGO3uwkX2rhoD0sG8tzeCyChIQsqAaiuO+CF3vxoPMi+j0zygcQ63a7AvJgvbpkezrRBth17TtQ0QPpp3eyUD2i9s/j9csLVF7Gpl8XjVzpfX7fv8rsC7j/FHTmP8dMHOqI86S691VUm33Yo7nAcjV3a2BAgT0A3/aiQpjvVzHTC8e1FYkO1/cF18a+eUG3ijfoJyCKcBHn2WXYZa1108EOdFQfdSMTU28ZCYYiMpW06TOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/S/MCNFN0ZMHWA2ftd+0fakZCGvntzgJqvnf4bBAmo=;
 b=jPhDJEposaYPw/yeqmtiK3s1n6LXGGmjB9mKHQbr0DLTjcm3i0jrv0nWomxPKySKGyAe+RxodTUwf3iXRSSUyXhjZVH/GOnuBeblp4GVz63cO7SrCxmNqVNuGSXuFneKx6Zec5PhKBuFqUtIicyk00FnrhtUI0rVX1zrwpxynHO+tv3fwoRZ+IRcVQlpKzmrOekFRXF4krf57Y/VwgC/DAixsebpIiAhM6yAPSwA42UBHki0FKeJX1vSBi+DwfdXffMCVS/dEOm40n5vxwbokzJCWmYRRMF7fDFY0bEZyAa1Gv2UDfTPOAqY0lfZbAUMTKJL4GAJTtOMiY4qX2PMKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/S/MCNFN0ZMHWA2ftd+0fakZCGvntzgJqvnf4bBAmo=;
 b=wipRYL0S9Sbvh+XrehWnGi+FlZ8Gh+pqCoXzfWyoE+zfK7OqxR5xJ3M8gPkc2gFEN/AQVW4pkqcz6VeGSAUncv3NjI3IeSI5UmH4SO7KhFldUGprjBlGqIrQbkp2043KAaPsEkVbnQHSNi42fDlkfGDzcA1WqVbeM6c5/I8KVpI=
Received: from DS7PR05CA0001.namprd05.prod.outlook.com (2603:10b6:5:3b9::6) by
 DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.30; Fri, 8 Sep 2023 07:11:36 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::35) by DS7PR05CA0001.outlook.office365.com
 (2603:10b6:5:3b9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.10 via Frontend
 Transport; Fri, 8 Sep 2023 07:11:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Fri, 8 Sep 2023 07:11:35 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Sep
 2023 02:11:33 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Alexander Graf <agraf@csgraf.de>, Angelo Dureghello
 <angelo@kernel-space.org>, Bin Meng <bmeng.cn@gmail.com>, Sean Anderson
 <sean.anderson@seco.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2] global: Use proper project name U-Boot (next2)
Date: Fri, 8 Sep 2023 09:11:31 +0200
Message-ID: <536af05e7061982f15b668e87f941cdabfa25392.1694157084.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7238; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=g7CHnUWgLVChTI83cNX70jXx1yd9+SUGELOOAbUwD8Y=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpRfJ2VnTzrvnHjxT43ts+KolbsfXs165DnVZc+enr1+Y
 nw6ko1aHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAiCe8Y5ko1tk2ctiYt+prg
 itxXGy/NrN91qpJhnknAwv35jeJyp3jsKyv+TjHO92uOAgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|DM6PR12MB4329:EE_
X-MS-Office365-Filtering-Correlation-Id: bc6f79a3-02e5-41ba-51fa-08dbb03ad6a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Y0b/lCv644YI9Ut86C7YrL4zoB8C0Eg5MyyvNzMneX5j8YhvytRX0d91Pbk6IQ05Pkh2tVm0SiCrQ51qUimiP/0XfUMQWxQkS+wTFdMDZjGhSHb+a2X+HIV3Ora8UGszj9Vmg1RZWLJuBvJ8jviAPnIwldXtwxsJ3PBFAOq7OGNU8TiiLr817UiNOt+8hCQ7CdFzFPa3E1cOBXwp3pCDai1cQwNl8j/8jecz24fUAmeANhO5frqWtLGAMWZyeYEDZxPzeS419wr94tHSEhb5NpoauIQVo8sMsAJSndM7NuQp+xfYJvIrASm1MIdsoVoFEikUhH0LYfELl392LHQnYYL90joY45v6gugmYtJ6Df/hhsCV52G4rl+hxtA8Ep6/7cYuMh+oSB+NTZw5r6Na/sZfhsUtzqLaWZYkrPq7igo5KHrGNtrH/tTcrZdtkiy684TXJrwtYG2/RtW6cvNrkN6jRPlne87fRqcQkbrNFti4VwGH2DSdt2/i2x2WMOlw0yx2ozap+rC6jRf09Ss9FoOiFLKavnxL3T/g3C4+hPkS1DznnJqWMMW15t1dP/djFiPDpjnovN6C542Z4ZrtGpkvAwcltf2YC3r5EOiFBIsYDwi6YmAHdcT7v38Wx3P26P9rNfde9kdz7G2VDo2M9C7a6hCScrqSQqRmPzKZc+QGYuraUis9PLuY2nyjZcqgFj5xVrDklaD4MaCuM3s6yU6XpoxV8WZ+znYt4P4Sh2wXnHtQ3peHyH81L3DGaurLPDTLzjs1tzgqpr+4rvPsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199024)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(5660300002)(40480700001)(83380400001)(44832011)(8936002)(8676002)(4326008)(16526019)(336012)(426003)(26005)(40460700003)(41300700001)(81166007)(36860700001)(82740400003)(356005)(2616005)(15188155005)(86362001)(478600001)(54906003)(70206006)(70586007)(110136005)(36756003)(2906002)(16799955002)(47076005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 07:11:35.7829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6f79a3-02e5-41ba-51fa-08dbb03ad6a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329
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

Changes in v2:
- Revert change in tools/binman/entries.rst reported by Simon

 board/cobra5272/README                      | 18 +++++++++---------
 board/emulation/qemu-ppce500/qemu-ppce500.c |  2 +-
 doc/board/xilinx/zynq.rst                   |  2 +-
 doc/board/xilinx/zynqmp-r5.rst              |  4 ++--
 doc/imx/mkimage/imximage.txt                |  2 +-
 doc/usage/environment.rst                   |  2 +-
 doc/usage/semihosting.rst                   |  2 +-
 7 files changed, 16 insertions(+), 16 deletions(-)

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
-- 
2.36.1

