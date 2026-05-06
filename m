Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955CCCD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 12:37:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6997184974;
	Wed,  6 May 2026 14:36:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KYdO167l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DACD8484F; Wed,  6 May 2026 14:36:49 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D6058497A
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 14:36:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D613143EFC;
 Wed,  6 May 2026 12:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF27EC2BCB8;
 Wed,  6 May 2026 12:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778071004;
 bh=cr/NRii/FbqTCDZx0egkUlp2RqZnM00KqvE7rTxF+xo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KYdO167lw4asTnwgevATWEwAM/TQMT7cKhJvWnekuL1Z5cwpc3k49fer/7wRNSzq3
 6Koizb+nlJhSM/ltdxSDN7VsRBCo+KSd49pqXAdDIFRs5SF3YnkVDrKULT2TaYG8cV
 hnIg9k4ZC2m8OgeaC4D5adn3QIjaLmo3UXdFrDcuPRUc2xivOHr2BwFxOvzu2WHEn+
 Zig85UnGg8CKoLmC6uWBfOJTUvaz/eNWbjG7tZF49fz/aoCJplsVrr28UsF3t1kCPa
 qktCwZiNqGm5Got+5UbgqOaPuvmnqDDPjbFos7er2fjyi5ROg4EDtJOPYNviK0PQqk
 h8S+BI+1xdjFQ==
From: Michael Walle <mwalle@kernel.org>
To: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Tom Rini <trini@konsulko.com>, Pramod Kumar <pramod.kumar_1@nxp.com>,
 Vladimir Oltean <olteanv@gmail.com>, Alison Wang <alison.wang@nxp.com>,
 Tang Yuantian <andy.tang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 TsiChung Liew <Tsi-Chung.Liew@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Shengzhou Liu <Shengzhou.Liu@nxp.com>
Cc: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Jerome Forissier <jerome.forissier@arm.com>, u-boot@lists.denx.de,
 Michael Walle <mwalle@kernel.org>
Subject: [PATCH v2 11/11] p2041rdb: convert README to rst
Date: Wed,  6 May 2026 14:34:20 +0200
Message-ID: <20260506123507.2081751-12-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260506123507.2081751-1-mwalle@kernel.org>
References: <20260506123507.2081751-1-mwalle@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Convert the README to reST format.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 board/nxp/p2041rdb/README     | 128 -----------------------------
 board/nxp/p2041rdb/README.rst | 147 ++++++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+), 128 deletions(-)
 delete mode 100644 board/nxp/p2041rdb/README
 create mode 100644 board/nxp/p2041rdb/README.rst

diff --git a/board/nxp/p2041rdb/README b/board/nxp/p2041rdb/README
deleted file mode 100644
index c2a2f0ed9e5..00000000000
--- a/board/nxp/p2041rdb/README
+++ /dev/null
@@ -1,128 +0,0 @@
-Overview
-=========
-The P2041 Processor combines four Power Architecture processor cores
-with high-performance datapath acceleration architecture(DPAA), CoreNet
-fabric infrastructure, as well as network and peripheral bus interfaces
-required for networking, telecom/datacom, wireless infrastructure, and
-military/aerospace applications.
-
-P2041RDB board is a quad core platform supporting the P2041 processor
-of QorIQ DPAA series.
-
-Boot from NOR flash
-===================
-1. Build image
-	make P2041RDB_config
-	make all
-
-2. Program image
-	=> tftp 1000000 u-boot.bin
-	=> protect off all
-	=> erase eff40000 efffffff
-	=> cp.b 1000000 eff40000 c0000
-
-3. Program RCW
-	=> tftp 1000000 rcw.bin
-	=> protect off all
-	=> erase e8000000 e801ffff
-	=> cp.b 1000000 e8000000 50
-
-4. Program FMAN Firmware ucode
-	=> tftp 1000000 ucode.bin
-	=> protect off all
-	=> erase eff00000 eff3ffff
-	=> cp.b 1000000 eff00000 2000
-
-5. Change DIP-switch
-	SW1[1-5] = 10110
-	Note: 1 stands for 'on', 0 stands for 'off'
-
-Boot from SDCard
-===================
-1. Build image
-	make P2041RDB_SDCARD_config
-	make all
-
-2. Program the PBL image to SDCard
-	=> tftp 1000000 u-boot.pbl
-	=> mmc info
-	=> mmc write 1000000 8 672
-
-3. Program FMAN Firmware ucode
-	=> tftp 1000000 ucode.bin
-	=> mmc write 1000000 690 10
-
-4. Change DIP-switch
-	SW1[1-5] = 01100
-	Note: 1 stands for 'on', 0 stands for 'off'
-
-Boot from SPI flash
-===================
-1. Build image
-	make P2041RDB_SPIFLASH_config
-	make all
-
-2. Program the PBL image to SPI flash
-	=> tftp 1000000 u-boot.pbl
-	=> sf probe 0
-	=> sf update $fileaddr 0 $filesize
-
-3. Program FMAN Firmware ucode
-	=> tftp 1000000 ucode.bin
-	=> sf update $fileaddr 110000 $filesize
-
-4. Change DIP-switch
-	SW1[1-5] = 10100
-	Note: 1 stands for 'on', 0 stands for 'off'
-
-Device tree support and how to enable it for different configs
---------------------------------------------------------------
-Device tree support is available for p2041rdb for below mentioned boot,
-1. NOR Boot
-2. NAND Boot
-3. SD Boot
-4. SPIFLASH Boot
-
-To enable device tree support for other boot, below configs need to be
-enabled in relative defconfig file,
-1. CONFIG_DEFAULT_DEVICE_TREE="p2041rdb" (Change default device tree name if required)
-2. CONFIG_OF_CONTROL
-3. CONFIG_MPC85XX_HAVE_RESET_VECTOR if reset vector is located at
-   CFG_RESET_VECTOR_ADDRESS - 0xffc
-
-CPLD command
-============
-The CPLD is used to control the power sequence and some serdes lane
-mux function.
-
-cpld reset			 - hard reset to default bank
-cpld reset altbank		 - reset to alternate bank
-cpld lane_mux <lane> <mux_value> - set multiplexed lane pin
-		lane 6: 0 -> slot1 (Default)
-			1 -> SGMII
-		lane a: 0 -> slot2 (Default)
-			1 -> AURORA
-		lane c: 0 -> slot2 (Default)
-			1 -> SATA0
-		lane d: 0 -> slot2 (Default)
-			1 -> SATA1
-
-Using the Device Tree Source File
-=================================
-To create the DTB (Device Tree Binary) image file, use a command
-similar to this:
-	dtc -O dtb -b 0 -p 1024 p2041rdb.dts > p2041rdb.dtb
-
-Or use the following command:
-	{linux-2.6}/make p2041rdb.dtb ARCH=powerpc
-
-then the dtb file will be generated under the following directory:
-	{linux-2.6}/arch/powerpc/boot/p2041rdb.dtb
-
-Booting Linux
-=============
-Place a linux uImage in the TFTP disk area.
-	tftp 1000000 uImage
-	tftp 2000000 rootfs.ext2.gz.uboot
-	tftp 3000000 p2041rdb.dtb
-	bootm 1000000 2000000 3000000
diff --git a/board/nxp/p2041rdb/README.rst b/board/nxp/p2041rdb/README.rst
new file mode 100644
index 00000000000..8b8214adc57
--- /dev/null
+++ b/board/nxp/p2041rdb/README.rst
@@ -0,0 +1,147 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+P2041-RDB Board Overview
+========================
+
+The P2041 Processor combines four Power Architecture processor cores
+with high-performance datapath acceleration architecture(DPAA), CoreNet
+fabric infrastructure, as well as network and peripheral bus interfaces
+required for networking, telecom/datacom, wireless infrastructure, and
+military/aerospace applications.
+
+P2041RDB board is a quad core platform supporting the P2041 processor
+of QorIQ DPAA series.
+
+Boot from NOR flash
+===================
+
+1. Build image::
+
+    make P2041RDB_config
+    make all
+
+2. Program image::
+
+    => tftp 1000000 u-boot.bin
+    => protect off all
+    => erase eff40000 efffffff
+    => cp.b 1000000 eff40000 c0000
+
+3. Program RCW::
+
+    => tftp 1000000 rcw.bin
+    => protect off all
+    => erase e8000000 e801ffff
+    => cp.b 1000000 e8000000 50
+
+4. Program FMAN Firmware ucode::
+
+    => tftp 1000000 ucode.bin
+    => protect off all
+    => erase eff00000 eff3ffff
+    => cp.b 1000000 eff00000 2000
+
+5. Change DIP-switch to SW1[1-5] = 10110. Note: 1 stands for 'on', 0 stands for 'off'
+
+Boot from SDCard
+================
+
+1. Build image::
+
+    make P2041RDB_SDCARD_config
+    make all
+
+2. Program the PBL image to SDCard::
+
+    => tftp 1000000 u-boot.pbl
+    => mmc info
+    => mmc write 1000000 8 672
+
+3. Program FMAN Firmware ucode::
+
+    => tftp 1000000 ucode.bin
+    => mmc write 1000000 690 10
+
+4. Change DIP-switch to SW1[1-5] = 01100. Note: 1 stands for 'on', 0 stands for 'off'
+
+Boot from SPI flash
+===================
+
+1. Build image::
+
+    make P2041RDB_SPIFLASH_config
+    make all
+
+2. Program the PBL image to SPI flash::
+
+    => tftp 1000000 u-boot.pbl
+    => sf probe 0
+    => sf update $fileaddr 0 $filesize
+
+3. Program FMAN Firmware ucode::
+
+    => tftp 1000000 ucode.bin
+    => sf update $fileaddr 110000 $filesize
+
+4. Change DIP-switch SW1[1-5] = 10100. Note: 1 stands for 'on', 0 stands for 'off'
+
+Device tree support and how to enable it for different configs
+--------------------------------------------------------------
+
+Device tree support is available for p2041rdb for below mentioned boot,
+
+1. NOR Boot
+2. NAND Boot
+3. SD Boot
+4. SPIFLASH Boot
+
+To enable device tree support for other boot, below configs need to be
+enabled in relative defconfig file,
+
+1. CONFIG_DEFAULT_DEVICE_TREE="p2041rdb" (Change default device tree name if required)
+2. CONFIG_OF_CONTROL
+3. CONFIG_MPC85XX_HAVE_RESET_VECTOR if reset vector is located at
+   CFG_RESET_VECTOR_ADDRESS - 0xffc
+
+CPLD command
+============
+
+The CPLD is used to control the power sequence and some serdes lane
+mux function::
+
+  cpld reset			 - hard reset to default bank
+  cpld reset altbank		 - reset to alternate bank
+  cpld lane_mux <lane> <mux_value> - set multiplexed lane pin
+                lane 6: 0 -> slot1 (Default)
+                        1 -> SGMII
+                lane a: 0 -> slot2 (Default)
+                        1 -> AURORA
+                lane c: 0 -> slot2 (Default)
+                        1 -> SATA0
+                lane d: 0 -> slot2 (Default)
+                        1 -> SATA1
+
+Using the Device Tree Source File
+=================================
+To create the DTB (Device Tree Binary) image file, use a command
+similar to this::
+
+  dtc -O dtb -b 0 -p 1024 p2041rdb.dts > p2041rdb.dtb
+
+Or use the following command::
+
+  {linux-2.6}/make p2041rdb.dtb ARCH=powerpc
+
+then the dtb file will be generated under the following directory::
+
+  {linux-2.6}/arch/powerpc/boot/p2041rdb.dtb
+
+Booting Linux
+=============
+
+Place a linux uImage in the TFTP disk area::
+
+ => tftp 1000000 uImage
+ => tftp 2000000 rootfs.ext2.gz.uboot
+ => tftp 3000000 p2041rdb.dtb
+ => bootm 1000000 2000000 3000000
-- 
2.47.3

