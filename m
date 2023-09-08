Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7AABEE57E7
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 09:36:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28B908647E;
	Fri,  8 Sep 2023 11:36:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rJ8dmeRq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64E2D86682; Fri,  8 Sep 2023 11:36:33 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C660280275
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 11:36:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3889aKg3068147;
 Fri, 8 Sep 2023 04:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694165780;
 bh=ZVsR79CrzU8nox4c2iw2cNm8QIWP8OI1V0Y3NRF//gE=;
 h=From:To:CC:Subject:Date;
 b=rJ8dmeRqMVbnPpwlUTorHUbzGASUdj6D7AsJ1v9mdxjmfWWAdQno8aLR87jsU+4g8
 Bj1gKFfZanOEOBcinGk7BQtqk+3Uel0rniA/VA+IMJYsy8JOru9w5FHSpEmG/cFwGP
 QFDdOJOq8AjP3yOd2asB1a7tyhPHg+LTUObkS5YY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3889aKaD008059
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 8 Sep 2023 04:36:20 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Sep 2023 04:36:20 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Sep 2023 04:36:20 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3889aGhm086631;
 Fri, 8 Sep 2023 04:36:17 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <afd@ti.com>
CC: <u-boot@lists.denx.de>, <xypron.glpk@gmx.de>, <bb@ti.com>,
 <miquel.raynal@bootlin.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <vigneshr@ti.com>
Subject: [PATCH] doc: board: ti: Move documentation from README to .rst
Date: Fri, 8 Sep 2023 15:06:16 +0530
Message-ID: <20230908093616.523135-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Make the conversion for all existing TI documentation from README to
.rst

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 board/ti/dra7xx/README            |  26 --
 board/ti/ks2_evm/README           | 194 -------------
 doc/README.ti-secure              | 226 ---------------
 doc/SPI/README.ti_qspi_am43x_test |  76 ------
 doc/SPI/README.ti_qspi_dra_test   |  47 ----
 doc/SPI/README.ti_qspi_flash      |  47 ----
 doc/board/ti/am335x_evm.rst       | 437 ++++++++++++++++++++++--------
 doc/board/ti/am43xx_evm.rst       | 188 +++++++++++++
 doc/board/ti/dra7xx_evm.rst       | 139 ++++++++++
 doc/board/ti/index.rst            |   3 +
 doc/board/ti/ks2_evm.rst          | 306 +++++++++++++++++++++
 11 files changed, 965 insertions(+), 724 deletions(-)
 delete mode 100644 board/ti/dra7xx/README
 delete mode 100644 board/ti/ks2_evm/README
 delete mode 100644 doc/README.ti-secure
 delete mode 100644 doc/SPI/README.ti_qspi_am43x_test
 delete mode 100644 doc/SPI/README.ti_qspi_dra_test
 delete mode 100644 doc/SPI/README.ti_qspi_flash
 create mode 100644 doc/board/ti/am43xx_evm.rst
 create mode 100644 doc/board/ti/dra7xx_evm.rst
 create mode 100644 doc/board/ti/ks2_evm.rst

diff --git a/board/ti/dra7xx/README b/board/ti/dra7xx/README
deleted file mode 100644
index 533da01a34..0000000000
--- a/board/ti/dra7xx/README
+++ /dev/null
@@ -1,26 +0,0 @@
-Summary
-=======
-
-This document covers various features of the 'dra7xx_evm' build and some
-related uses.
-
-eMMC boot partition use
-=======================
-
-It is possible, depending on SYSBOOT configuration to boot from the eMMC
-boot partitions using (name depending on documentation referenced)
-Alternative Boot operation mode or Boot Sequence Option 1/2.  In this
-example we load MLO and u-boot.img from the build into DDR and then use
-'mmc bootbus' to set the required rate (see TRM) and 'mmc partconfig' to
-set boot0 as the boot device.
-U-Boot # setenv autoload no
-U-Boot # usb start
-U-Boot # dhcp
-U-Boot # mmc dev 1 1
-U-Boot # tftp ${loadaddr} dra7xx/MLO
-U-Boot # mmc write ${loadaddr} 0 100
-U-Boot # tftp ${loadaddr} dra7xx/u-boot.img
-U-Boot # mmc write ${loadaddr} 300 400
-U-Boot # mmc bootbus 1 2 0 2
-U-Boot # mmc partconf 1 1 1 0
-U-Boot # mmc rst-function 1 1
diff --git a/board/ti/ks2_evm/README b/board/ti/ks2_evm/README
deleted file mode 100644
index ff0ec5a363..0000000000
--- a/board/ti/ks2_evm/README
+++ /dev/null
@@ -1,194 +0,0 @@
-U-Boot port for Texas Instruments Keystone II EVM boards
-========================================================
-
-Author: Murali Karicheri <m-karicheri2@ti.com>
-
-This README has information on the U-Boot port for K2HK, K2E, and K2L EVM boards.
-Documentation for this board can be found at
-http://www.advantech.com/Support/TI-EVM/EVMK2HX_sd.aspx
-https://www.einfochips.com/index.php/partnerships/texas-instruments/k2e-evm.html
-https://www.einfochips.com/index.php/partnerships/texas-instruments/k2l-evm.html
-
-The K2HK board is based on Texas Instruments Keystone2 family of SoCs: K2H, K2K.
-More details on these SoCs are available at company websites
- K2K: http://www.ti.com/product/tci6638k2k
- K2H: http://www.ti.com/product/tci6638k2h
-
-The K2E SoC details are available at
- http://www.ti.com/lit/ds/symlink/66ak2e05.pdf
-
-The K2L SoC details are available at
- http://www.ti.com/lit/ds/symlink/tci6630k2l.pdf
-
-The K2G SoC details are available at
- http://www.ti.com/lit/ds/symlink/66ak2g02.pdf
-
-Board configuration:
-====================
-
-Some of the peripherals that are configured by U-Boot
-+------+-------+-------+-----------+-----------+-------+-------+----+
-|      |DDR3   |NAND   |MSM SRAM   |ETH ports  |UART   |I2C    |SPI |
-+------+-------+-------+-----------+-----------+-------+-------+----+
-|K2HK  |2      |512MB  |6MB	   |4(2)       |2      |3      |3   |
-|K2E   |4      |512MB  |2MB	   |8(2)       |2      |3      |3   |
-|K2L   |2      |512MB  |2MB	   |4(2)       |4      |3      |3   |
-|K2G   |2      |256MB  |1MB	   |1          |1      |1      |1   |
-+------+-------+-------+-----------+-----------+-------+-------+----+
-
-There are only 2 eth port installed on the boards.
-
-There are separate PLLs to drive clocks to Tetris ARM and Peripherals.
-To bring up SMP Linux on this board, there is a boot monitor
-code that will be installed in MSMC SRAM. There is command available
-to install this image from U-Boot.
-
-The port related files can be found at following folders
- keystone2 SoC related files: arch/arm/cpu/armv7/keystone/
- EVMs board files: board/ti/k2s_evm/
-
-Board configuration files:
-include/configs/k2hk_evm.h
-include/configs/k2e_evm.h
-include/configs/k2l_evm.h
-include/configs/k2g_evm.h
-
-As U-Boot is migrating to Kconfig there is also board defconfig files
-configs/k2e_evm_defconfig
-configs/k2hk_evm_defconfig
-configs/k2l_evm_defconfig
-configs/k2g_evm_defconfig
-
-Supported boot modes:
- - SPI NOR boot
- - AEMIF NAND boot (K2E, K2L and K2HK)
- - UART boot
- - MMC boot (Only on K2G)
-
-Supported image formats:
- - u-boot.bin: for loading and running u-boot.bin through
-		Texas Instruments code composure studio (CCS) and for UART boot.
- - u-boot-spi.gph: gpimage for programming SPI NOR flash for SPI NOR boot
- - MLO: gpimage for programming NAND flash for NAND boot, MMC boot.
-
-Build instructions:
-===================
-Examples for k2hk, for k2e, k2l and k2g just replace k2hk prefix accordingly.
-Don't forget to add CROSS_COMPILE.
-
-To build u-boot.bin, u-boot-spi.gph, MLO:
-  >make k2hk_evm_defconfig
-  >make
-
-Load and Run U-Boot on keystone EVMs using CCS
-=========================================
-
-Need Code Composer Studio (CCS) installed on a PC to load and run u-boot.bin
-on EVM. See instructions at below link for installing CCS on a Windows PC.
-http://processors.wiki.ti.com/index.php/MCSDK_UG_Chapter_Getting_Started#
-Installing_Code_Composer_Studio
-Use u-boot.bin from the build folder for loading and running U-Boot binary
-on EVM. Follow instructions at
-K2HK http://processors.wiki.ti.com/index.php/EVMK2H_Hardware_Setup
-K2E  http://processors.wiki.ti.com/index.php/EVMK2E_Hardware_Setup
-K2L  http://processors.wiki.ti.com/index.php/TCIEVMK2L_Hardware_Setup
-K2G  http://processors.wiki.ti.com/index.php/66AK2G02_GP_EVM_Hardware_Setup
-
-to configure SW1 dip switch to use "No Boot/JTAG DSP Little Endian Boot Mode"
-and Power ON the EVM.  Follow instructions to connect serial port of EVM to
-PC and start TeraTerm or Hyper Terminal.
-
-Start CCS on a Windows machine and Launch Target
-configuration as instructed at http://processors.wiki.ti.com/index.php/
-MCSDK_UG_Chapter_Exploring#Loading_and_Running_U-Boot_on_EVM_through_CCS.
-The instructions provided in the above link uses a script for
-loading the U-Boot binary on the target EVM. Instead do the following:-
-
-1. Right click to "Texas Instruments XDS2xx USB Emulator_0/CortexA15_1 core (D
-   is connected: Unknown)" at the debug window (This is created once Target
-   configuration is launched) and select "Connect Target".
-2. Once target connect is successful, choose Tools->Load Memory option from the
-   top level menu. At the Load Memory window, choose the file u-boot.bin
-   through "Browse" button and click "next >" button. In the next window, enter
-   Start address as 0xc000000, choose Type-size "32 bits" and click "Finish"
-   button.
-3. Click View -> Registers from the top level menu to view registers window.
-4. From Registers, window expand "Core Registers" to view PC. Edit PC value
-   to be 0xc000000. From the "Run" top level menu, select "Free Run"
-5. The U-Boot prompt is shown at the Tera Term/ Hyper terminal console as
-   below and type any key to stop autoboot as instructed :=
-
-U-Boot 2014.04-rc1-00201-gc215b5a (Mar 21 2014 - 12:47:59)
-
-I2C:   ready
-Detected SO-DIMM [SQR-SD3T-2G1333SED]
-DRAM:  1.1 GiB
-NAND:  512 MiB
-Net:   K2HK_EMAC
-Warning: K2HK_EMAC using MAC address from net device
-, K2HK_EMAC1, K2HK_EMAC2, K2HK_EMAC3
-Hit any key to stop autoboot:  0
-
-SPI NOR Flash programming instructions
-======================================
-U-Boot image can be flashed to first 512KB of the NOR flash using following
-instructions:
-
-1. Start CCS and run U-Boot as described above.
-2. Suspend Target. Select Run -> Suspend from top level menu
-   CortexA15_1 (Free Running)"
-3. Load u-boot-spi.gph binary from build folder on to DDR address 0x87000000
-   through CCS as described in step 2 of "Load and Run U-Boot on K2HK/K2E/K2L
-   EVM using CCS", but using address 0x87000000.
-4. Free Run the target as described earlier (step 4) to get U-Boot prompt
-5. At the U-Boot console type following to setup U-Boot environment variables.
-   setenv addr_uboot 0x87000000
-   setenv filesize <size in hex of u-boot-spi.gph rounded to hex 0x10000>
-   run burn_uboot_spi
-   Once U-Boot prompt is available, Power OFF the EVM. Set the SW1 dip switch
-   to "SPI Little Endian Boot mode" as per instruction at
-   http://processors.wiki.ti.com/index.php/*_Hardware_Setup.
-6. Power ON the EVM. The EVM now boots with U-Boot image on the NOR flash.
-
-AEMIF NAND Flash programming instructions
-======================================
-U-Boot image can be flashed to first 1024KB of the NAND flash using following
-instructions:
-
-1. Start CCS and run U-Boot as described above.
-2. Suspend Target. Select Run -> Suspend from top level menu
-   CortexA15_1 (Free Running)"
-3. Load MLO binary from build folder on to DDR address 0x87000000
-   through CCS as described in step 2 of "Load and Run U-Boot on K2HK EVM
-   using CCS", but using address 0x87000000.
-4. Free Run the target as described earlier (step 4) to get U-Boot prompt
-5. At the U-Boot console type following to setup U-Boot environment variables.
-   setenv filesize <size in hex of MLO rounded to hex 0x10000>
-   run burn_uboot_nand
-   Once U-Boot prompt is available, Power OFF the EVM. Set the SW1 dip switch
-   to "ARM NAND Boot mode" as per instruction at
-   http://processors.wiki.ti.com/index.php/*_Hardware_Setup.
-6. Power ON the EVM. The EVM now boots with U-Boot image on the NAND flash.
-
-Load and Run U-Boot on keystone EVMs using UART download
-========================================================
-
-Open BMC and regular UART terminals.
-
-1. On the regular UART port start xmodem transfer of the u-boot.bin
-2. Using BMC terminal set the ARM-UART bootmode and reboot the EVM
-   BMC> bootmode #4
-   MBC> reboot
-3. When xmodem is complete you should see the U-Boot starts on the UART port
-
-Load and Run U-Boot on K2G EVMs using MMC
-========================================================
-
-Open BMC and regular UART terminals.
-
-1. Set the SW3 dip switch to "ARM MMC Boot mode" as per instruction at
-   http://processors.wiki.ti.com/index.php/66AK2G02_GP_EVM_Hardware_Setup
-2. Create SD card partitions as per steps given in Hardware Setup Guide.
-3. Copy MLO to Boot Partition.
-4. Insert SD card and Power on the EVM.
-   The EVM now boots with U-Boot image from SD card.
diff --git a/doc/README.ti-secure b/doc/README.ti-secure
deleted file mode 100644
index 27c0eaa77f..0000000000
--- a/doc/README.ti-secure
+++ /dev/null
@@ -1,226 +0,0 @@
-README on how boot images are created for secure TI devices
-
-CONFIG_TI_SECURE_DEVICE:
-Secure TI devices require a boot image that is authenticated by ROM
-code to function. Without this, even JTAG remains locked and the
-device is essentially useless. In order to create a valid boot image for
-a secure device from TI, the initial public software image must be signed
-and combined with various headers, certificates, and other binary images.
-
-Information on the details on the complete boot image format can be obtained
-from Texas Instruments. The tools used to generate boot images for secure
-devices are part of a secure development package (SECDEV) that can be
-downloaded from:
-
-	http://www.ti.com/mysecuresoftware (login required)
-
-The secure development package is access controlled due to NDA and export
-control restrictions. Access must be requested and granted by TI before the
-package is viewable and downloadable. Contact TI, either online or by way
-of a local TI representative, to request access.
-
-Booting of U-Boot SPL
-=====================
-
-	When CONFIG_TI_SECURE_DEVICE is set, the U-Boot SPL build process
-	requires the presence and use of these tools in order to create a
-	viable boot image. The build process will look for the environment
-	variable TI_SECURE_DEV_PKG, which should be the path of the installed
-	SECDEV package. If the TI_SECURE_DEV_PKG variable is not defined or
-	if it is defined but doesn't point to a valid SECDEV package, a
-	warning is issued during the build to indicate that a final secure
-	bootable image was not created.
-
-	Within the SECDEV package exists an image creation script:
-
-	${TI_SECURE_DEV_PKG}/scripts/create-boot-image.sh
-
-	This is called as part of the SPL/u-boot build process. As the secure
-	boot image formats and requirements differ between secure SOC from TI,
-	the purpose of this script is to abstract these details as much as
-	possible.
-
-	The script is basically the only required interface to the TI SECDEV
-	package for creating a bootable SPL image for secure TI devices.
-
-	Invoking the script for AM33xx Secure Devices
-	=============================================
-
-	create-boot-image.sh \
-		<IMAGE_FLAG> <INPUT_FILE> <OUTPUT_FILE> <SPL_LOAD_ADDR>
-
-	<IMAGE_FLAG> is a value that specifies the type of the image to
-	generate OR the action the image generation tool will take. Valid
-	values are:
-		SPI_X-LOADER - Generates an image for SPI flash (byte swapped)
-		X-LOADER - Generates an image for non-XIP flash
-		MLO - Generates an image for SD/MMC/eMMC media
-		2ND - Generates an image for USB, UART and Ethernet
-		XIP_X-LOADER - Generates a single stage u-boot for NOR/QSPI XiP
-
-	<INPUT_FILE> is the full path and filename of the public world boot
-	loaderbinary file (depending on the boot media, this is usually
-	either u-boot-spl.bin or u-boot.bin).
-
-	<OUTPUT_FILE> is the full path and filename of the final secure
-	image. The output binary images should be used in place of the standard
-	non-secure binary images (see the platform-specific user's guides and
-	releases notes for how the non-secure images are typically used)
-	u-boot-spl_HS_SPI_X-LOADER - byte swapped boot image for SPI flash
-	u-boot-spl_HS_X-LOADER - boot image for NAND or SD/MMC/eMMC rawmode
-	u-boot-spl_HS_MLO - boot image for SD/MMC/eMMC media
-	u-boot-spl_HS_2ND - boot image for USB, UART and Ethernet
-	u-boot_HS_XIP_X-LOADER - boot image for NOR or QSPI Xip flash
-
-	<SPL_LOAD_ADDR> is the address at which SOC ROM should load the
-	<INPUT_FILE>
-
-	Invoking the script for AM43xx Secure Devices
-	=============================================
-
-	create-boot-image.sh \
-		<IMAGE_FLAG> <INPUT_FILE> <OUTPUT_FILE> <SPL_LOAD_ADDR>
-
-	<IMAGE_FLAG> is a value that specifies the type of the image to
-	generate OR the action the image generation tool will take. Valid
-	values are:
-		SPI_X-LOADER - Generates an image for SPI flash (byte
-			swapped)
-		XIP_X-LOADER - Generates a single stage u-boot for
-			NOR/QSPI XiP
-		ISSW - Generates an image for all other boot modes
-
-	<INPUT_FILE> is the full path and filename of the public world boot
-	loaderbinary file (depending on the boot media, this is usually
-	either u-boot-spl.bin or u-boot.bin).
-
-	<OUTPUT_FILE> is the full path and filename of the final secure
-	image. The output binary images should be used in place of the standard
-	non-secure binary images (see the platform-specific user's guides and
-	releases notes for how the non-secure images are typically used)
-	u-boot-spl_HS_SPI_X-LOADER - byte swapped boot image for SPI flash
-	u-boot_HS_XIP_X-LOADER - boot image for NOR or QSPI flash
-	u-boot-spl_HS_ISSW - boot image for all other boot media
-
-	<SPL_LOAD_ADDR> is the address at which SOC ROM should load the
-	<INPUT_FILE>
-
-	Invoking the script for DRA7xx/AM57xx Secure Devices
-	====================================================
-
-	create-boot-image.sh \
-		<IMAGE_TYPE> <INPUT_FILE> <OUTPUT_FILE> <SPL_LOAD_ADDR>
-
-	<IMAGE_TYPE> is a value that specifies the type of the image to
-	generate OR the action the image generation tool will take. Valid
-	values are:
-		X-LOADER - Generates an image for NOR or QSPI boot modes
-		MLO - Generates an image for SD/MMC/eMMC boot modes
-		ULO - Generates an image for USB/UART peripheral boot modes
-
-	<INPUT_FILE> is the full path and filename of the public world boot
-	loader binary file (for this platform, this is always u-boot-spl.bin).
-
-	<OUTPUT_FILE> is the full path and filename of the final secure image.
-	The output binary images should be used in place of the standard
-	non-secure binary images (see the platform-specific user's guides
-	and releases notes for how the non-secure images are typically used)
-	u-boot-spl_HS_MLO - boot image for SD/MMC/eMMC. This image is
-		copied to a file named MLO, which is the name that
-		the device ROM bootloader requires for loading from
-		the FAT partition of an SD card (same as on
-		non-secure devices)
-	u-boot-spl_HS_ULO - boot image for USB/UART peripheral boot modes
-	u-boot-spl_HS_X-LOADER - boot image for all other flash memories
-		including QSPI and NOR flash
-
-	<SPL_LOAD_ADDR> is the address at which SOC ROM should load the
-	<INPUT_FILE>
-
-	Invoking the script for Keystone2 Secure Devices
-	================================================
-
-	create-boot-image.sh \
-		<UNUSED> <INPUT_FILE> <OUTPUT_FILE> <UNUSED>
-
-	<UNUSED> is currently ignored and reserved for future use.
-
-	<INPUT_FILE> is the full path and filename of the public world boot
-	loader binary file (only u-boot.bin is currently supported on
-	Keystone2 devices, u-boot-spl.bin is not currently supported).
-
-	<OUTPUT_FILE> is the full path and filename of the final secure image.
-	The output binary images should be used in place of the standard
-	non-secure binary images (see the platform-specific user's guides
-	and releases notes for how the non-secure images are typically used)
-	u-boot_HS_MLO - signed and encrypted boot image that can be used to
-		boot from all media. Secure boot from SPI NOR flash is not
-		currently supported.
-
-	Invoking the script for K3 Secure Devices
-	=========================================
-
-	The signing steps required to produce a bootable SPL image on secure
-	K3 TI devices are the same as those performed on non-secure devices.
-	The only difference is the key is not checked on non-secure devices so
-	a dummy key is used when building U-Boot for those devices. For secure
-	K3 TI devices simply use the real hardware key for your device. This
-	real key can be set with the Kconfig option "K3_KEY". The environment
-	variable TI_SECURE_DEV_PKG is also searched for real keys when the
-	build targets secure devices.
-
-Booting of Primary U-Boot (u-boot.img)
-======================================
-
-	The SPL image is responsible for loading the next stage boot loader,
-	which is the main u-boot image. For secure TI devices, the SPL will
-	be authenticated, as described above, as part of the particular
-	device's ROM boot process. In order to continue the secure boot
-	process, the authenticated SPL must authenticate the main u-boot
-	image that it loads.
-
-	The configurations for secure TI platforms are written to make the boot
-	process use the FIT image format for the u-boot.img (CONFIG_SPL_FRAMEWORK
-	and CONFIG_SPL_LOAD_FIT). With these configurations the binary
-	components that the SPL loads include a specific DTB image and u-boot
-	image. These DTB image may be one of many available to the boot
-	process. In order to secure these components so that they can be
-	authenticated by the SPL as they are loaded from the FIT image,	the
-	build procedure for secure TI devices will secure these images before
-	they are integrated into the FIT image. When those images are extracted
-	from the FIT image at boot time, they are post-processed to verify that
-	they are still secure. The outlined security-related SPL post-processing
-	is enabled through the CONFIG_SPL_FIT_IMAGE_POST_PROCESS option which
-	must be enabled for the secure boot scheme to work. In order to allow
-	verifying proper operation of the secure boot chain in case of successful
-	authentication messages like "Authentication passed" are output by the
-	SPL to the console for each blob that got extracted from the FIT image.
-
-	The exact details of the how the images are secured is handled by the
-	SECDEV package. Within the SECDEV package exists a script to process
-	an input binary image:
-
-	${TI_SECURE_DEV_PKG}/scripts/secure-binary-image.sh
-
-	This is called as part of the u-boot build process. As the secure
-	image formats and requirements can differ between the various secure
-	SOCs from TI, this script in the SECDEV package abstracts these
-	details. This script is essentially the only required interface to the
-	TI SECDEV package for creating a u-boot.img image for secure TI
-	devices.
-
-	The SPL/u-boot code contains calls to dedicated secure ROM functions
-	to perform the validation on the secured images. The details of the
-	interface to those functions is shown in the code. The summary
-	is that they are accessed by invoking an ARM secure monitor call to
-	the device's secure ROM (fixed read-only-memory that is secure and
-	only accessible when the ARM core is operating in the secure mode).
-
-	Invoking the secure-binary-image script for Secure Devices
-	==========================================================
-
-	secure-binary-image.sh <INPUT_FILE> <OUTPUT_FILE>
-
-	<INPUT_FILE> is the full path and filename of the input binary image
-
-	<OUTPUT_FILE> is the full path and filename of the output secure image.
diff --git a/doc/SPI/README.ti_qspi_am43x_test b/doc/SPI/README.ti_qspi_am43x_test
deleted file mode 100644
index 8fbf10b57a..0000000000
--- a/doc/SPI/README.ti_qspi_am43x_test
+++ /dev/null
@@ -1,76 +0,0 @@
-Testing details-
-----------------
-
-This doc simply illustrated the testing details of qspi flash
-driver with Macronix M25L51235 flash device.
-
-The test includes
-- probing the flash device
-- erasing the flash device
-- Writing to flash
-- Reading the contents of the flash.
-
-Test Log
---------
-
-Hit any key to stop autoboot:  0
-U-Boot# sf probe 0
-SF: Detected MX25L51235F with page size 256 Bytes, erase size 64 KiB, total 64 MiB, mapped at 30000000
-U-Boot# sf erase 0 0x80000
-SF: 524288 bytes @ 0x0 Erased: OK
-U-Boot# mw 81000000 0xdededede 0x40000
-U-Boot# sf write 81000000 0 0x40000
-SF: 262144 bytes @ 0x0 Written: OK
-U-Boot# sf read 82000000 0 0x40000
-SF: 262144 bytes @ 0x0 Read: OK
-U-Boot# md 0x82000000
-82000000: dededede dededede dededede dededede    ................
-82000010: dededede dededede dededede dededede    ................
-82000020: dededede dededede dededede dededede    ................
-82000030: dededede dededede dededede dededede    ................
-82000040: dededede dededede dededede dededede    ................
-82000050: dededede dededede dededede dededede    ................
-82000060: dededede dededede dededede dededede    ................
-82000070: dededede dededede dededede dededede    ................
-82000080: dededede dededede dededede dededede    ................
-82000090: dededede dededede dededede dededede    ................
-820000a0: dededede dededede dededede dededede    ................
-820000b0: dededede dededede dededede dededede    ................
-820000c0: dededede dededede dededede dededede    ................
-820000d0: dededede dededede dededede dededede    ................
-820000e0: dededede dededede dededede dededede    ................
-820000f0: dededede dededede dededede dededede    ................
-U-Boot# md 0x82010000
-82010000: dededede dededede dededede dededede    ................
-82010010: dededede dededede dededede dededede    ................
-82010020: dededede dededede dededede dededede    ................
-82010030: dededede dededede dededede dededede    ................
-82010040: dededede dededede dededede dededede    ................
-82010050: dededede dededede dededede dededede    ................
-82010060: dededede dededede dededede dededede    ................
-82010070: dededede dededede dededede dededede    ................
-82010080: dededede dededede dededede dededede    ................
-82010090: dededede dededede dededede dededede    ................
-820100a0: dededede dededede dededede dededede    ................
-820100b0: dededede dededede dededede dededede    ................
-820100c0: dededede dededede dededede dededede    ................
-820100d0: dededede dededede dededede dededede    ................
-820100e0: dededede dededede dededede dededede    ................
-820100f0: dededede dededede dededede dededede    ................
-U-Boot# md 0x82030000
-82030000: dededede dededede dededede dededede    ................
-82030010: dededede dededede dededede dededede    ................
-82030020: dededede dededede dededede dededede    ................
-82030030: dededede dededede dededede dededede    ................
-82030040: dededede dededede dededede dededede    ................
-82030050: dededede dededede dededede dededede    ................
-82030060: dededede dededede dededede dededede    ................
-82030070: dededede dededede dededede dededede    ................
-82030080: dededede dededede dededede dededede    ................
-82030090: dededede dededede dededede dededede    ................
-820300a0: dededede dededede dededede dededede    ................
-820300b0: dededede dededede dededede dededede    ................
-820300c0: dededede dededede dededede dededede    ................
-820300d0: dededede dededede dededede dededede    ................
-820300e0: dededede dededede dededede dededede    ................
-820300f0: dededede dededede dededede dededede    ................
diff --git a/doc/SPI/README.ti_qspi_dra_test b/doc/SPI/README.ti_qspi_dra_test
deleted file mode 100644
index e89f53587f..0000000000
--- a/doc/SPI/README.ti_qspi_dra_test
+++ /dev/null
@@ -1,47 +0,0 @@
--------------------------------------------------
-   Simple steps used to test the QSPI at U-Boot
--------------------------------------------------
-
-For #1, build the patched U-Boot and load MLO/u-boot.img
-
-----------------------------------
-Boot from another medium like MMC
-----------------------------------
-
-U-Boot# mmc dev 0
-mmc0 is current device
-U-Boot# fatload mmc 0 0x82000000 MLO
-reading MLO
-55872 bytes read in 8 ms (6.7 MiB/s)
-U-Boot# fatload mmc 0 0x83000000 u-boot.img
-reading u-boot.img
-248600 bytes read in 19 ms (12.5 MiB/s)
-
---------------------------------------------------
-Commands to erase/write u-boot/mlo to flash device
---------------------------------------------------
-U-Boot# sf probe 0
-SF: Detected S25FL256S_64K with page size 256 Bytes, erase size 64 KiB, total 32 MiB, mapped at 5c000000
-U-Boot# sf erase 0 0x10000
-SF: 65536 bytes @ 0x0 Erased: OK
-U-Boot# sf erase 0x20000 0x10000
-SF: 65536 bytes @ 0x20000 Erased: OK
-U-Boot# sf erase 0x30000 0x10000
-SF: 65536 bytes @ 0x30000 Erased: OK
-U-Boot# sf erase 0x40000 0x10000
-SF: 65536 bytes @ 0x40000 Erased: OK
-U-Boot# sf erase 0x50000 0x10000
-SF: 65536 bytes @ 0x50000 Erased: OK
-U-Boot# sf erase 0x60000 0x10000
-SF: 65536 bytes @ 0x60000 Erased: OK
-U-Boot# sf write 82000000 0 0x10000
-SF: 65536 bytes @ 0x0 Written: OK
-U-Boot# sf write 83000000 0x20000 0x60000
-SF: 393216 bytes @ 0x20000 Written: OK
-
-For #2, set sysboot to QSPI-1 boot mode(SYSBOOT[5:0] = 100110) and power
-on. ROM should find the GP header at offset 0 and load/execute SPL. SPL
-then detects that ROM was in QSPI-1 mode (boot code 10) and attempts to
-find a U-Boot image header at offset 0x20000 (set in the config file)
-and proceeds to load that image using the U-Boot image payload offset/size
-from the header. It will then start U-Boot.
diff --git a/doc/SPI/README.ti_qspi_flash b/doc/SPI/README.ti_qspi_flash
deleted file mode 100644
index 5cc1fd03b6..0000000000
--- a/doc/SPI/README.ti_qspi_flash
+++ /dev/null
@@ -1,47 +0,0 @@
-QSPI U-Boot support
-------------------
-
-Host processor is connected to serial flash device via qpsi
-interface. QSPI is a kind of spi module that allows single,
-dual and quad read access to external spi devices. The module
-has a memory mapped interface which provide direct interface
-for accessing data form external spi devices.
-
-The one QSPI in the device is primarily intended for fast booting
-from Quad SPI flash devices.
-
-Usecase
--------
-
-MLO/u-boot.img will be flashed from SD/MMC to the flash device
-using serial flash erase and write commands. Then, switch settings
-will be changed to qspi boot. Then, the ROM code will read MLO
-from the predefined location in the flash, where it was flashed and
-execute it after storing it in SDRAM. Then, the MLO will read
-u-boot.img from flash and execute it from SDRAM.
-
-SPI mode
--------
-SPI mode uses mtd spi framework for transfer and reception of data.
-Can be used in:
-1. Normal mode: use single pin for transfers
-2. Dual Mode: use two pins for transfers.
-3. Quad mode: use four pin for transfer
-
-Memory mapped read mode
------------------------
-In this, SPI controller is configured using configuration port and then
-controller is switched to memory mapped port for data read.
-
-Driver
-------
-drivers/qspi/ti_qspi.c
-    - Newly created file which is responsible for configuring the
-	qspi controller and also for providing the low level api which
-	is responsible for transferring the datas from host controller
-	to flash device and vice versa.
-
-Testing
--------
-A seperated file named README.dra_qspi_test has been created which gives all the
-details about the commands required to test qspi at U-Boot level.
diff --git a/doc/board/ti/am335x_evm.rst b/doc/board/ti/am335x_evm.rst
index 3332d51b36..2ba651eb6d 100644
--- a/doc/board/ti/am335x_evm.rst
+++ b/doc/board/ti/am335x_evm.rst
@@ -43,6 +43,180 @@ to look at both `include/configs/am335x_evm.h`,
 `include/configs/ti_am335x_common.h` and `include/configs/am335x_evm.h` as the
 migration to Kconfig is not yet complete.
 
+Secure Boot
+-----------
+
+.. secure_boot_include_start_config_ti_secure_device
+
+Secure TI devices require a boot image that is authenticated by ROM
+code to function. Without this, even JTAG remains locked and the
+device is essentially useless. In order to create a valid boot image for
+a secure device from TI, the initial public software image must be signed
+and combined with various headers, certificates, and other binary images.
+
+Information on the details on the complete boot image format can be obtained
+from Texas Instruments. The tools used to generate boot images for secure
+devices are part of a secure development package (SECDEV) that can be
+downloaded from:
+
+	http://www.ti.com/mysecuresoftware (login required)
+
+The secure development package is access controlled due to NDA and export
+control restrictions. Access must be requested and granted by TI before the
+package is viewable and downloadable. Contact TI, either online or by way
+of a local TI representative, to request access.
+
+.. secure_boot_include_end_config_ti_secure_device
+
+.. secure_boot_include_start_spl_boot
+
+1. Booting of U-Boot SPL
+^^^^^^^^^^^^^^^^^^^^^^^^
+
+When CONFIG_TI_SECURE_DEVICE is set, the U-Boot SPL build process
+requires the presence and use of these tools in order to create a
+viable boot image. The build process will look for the environment
+variable TI_SECURE_DEV_PKG, which should be the path of the installed
+SECDEV package. If the TI_SECURE_DEV_PKG variable is not defined or
+if it is defined but doesn't point to a valid SECDEV package, a
+warning is issued during the build to indicate that a final secure
+bootable image was not created.
+
+Within the SECDEV package exists an image creation script:
+
+.. prompt:: bash
+   :prompts: $
+
+   ${TI_SECURE_DEV_PKG}/scripts/create-boot-image.sh
+
+This is called as part of the SPL/u-boot build process. As the secure
+boot image formats and requirements differ between secure SOC from TI,
+the purpose of this script is to abstract these details as much as
+possible.
+
+The script is basically the only required interface to the TI SECDEV
+package for creating a bootable SPL image for secure TI devices.
+
+.. prompt:: bash
+   :prompts: $
+
+   create-boot-image.sh \
+		<IMAGE_FLAG> <INPUT_FILE> <OUTPUT_FILE> <SPL_LOAD_ADDR>
+
+.. secure_boot_include_end_spl_boot
+
+<IMAGE_FLAG> is a value that specifies the type of the image to
+generate OR the action the image generation tool will take. Valid
+values are:
+
+.. list-table::
+   :widths: 25 25
+   :header-rows: 0
+
+   * - PI_X-LOADER
+     - Generates an image for SPI flash (byte swapped)
+   * - X-LOADER
+     - Generates an image for non-XIP flash
+   * - MLO
+     - Generates an image for SD/MMC/eMMC media
+   * - 2ND
+     - Generates an image for USB, UART and Ethernet
+   * - XIP_X-LOADER
+     - Generates a single stage u-boot for NOR/QSPI XiP
+
+<INPUT_FILE> is the full path and filename of the public world boot
+loaderbinary file (depending on the boot media, this is usually
+either u-boot-spl.bin or u-boot.bin).
+
+<OUTPUT_FILE> is the full path and filename of the final secure
+image. The output binary images should be used in place of the standard
+non-secure binary images (see the platform-specific user's guides and
+releases notes for how the non-secure images are typically used)
+
+.. list-table::
+   :widths: 25 25
+   :header-rows: 0
+
+   * - u-boot-spl_HS_SPI_X-LOADER
+     - byte swapped boot image for SPI flash
+   * - u-boot-spl_HS_X-LOADER
+     - boot image for NAND or SD/MMC/eMMC rawmode
+   * - u-boot-spl_HS_MLO
+     - boot image for SD/MMC/eMMC media
+   * - u-boot-spl_HS_2ND
+     - boot image for USB, UART and Ethernet
+   * - u-boot_HS_XIP_X-LOADER
+     - boot image for NOR or QSPI Xip flash
+
+<SPL_LOAD_ADDR> is the address at which SOC ROM should load the
+<INPUT_FILE>
+
+.. secure_boot_include_start_primary_u_boot
+
+2. Booting of Primary U-Boot (u-boot.img)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The SPL image is responsible for loading the next stage boot loader,
+which is the main u-boot image. For secure TI devices, the SPL will
+be authenticated, as described above, as part of the particular
+device's ROM boot process. In order to continue the secure boot
+process, the authenticated SPL must authenticate the main u-boot
+image that it loads.
+
+The configurations for secure TI platforms are written to make the boot
+process use the FIT image format for the u-boot.img (CONFIG_SPL_FRAMEWORK
+and CONFIG_SPL_LOAD_FIT). With these configurations the binary
+components that the SPL loads include a specific DTB image and u-boot
+image. These DTB image may be one of many available to the boot
+process. In order to secure these components so that they can be
+authenticated by the SPL as they are loaded from the FIT image,	the
+build procedure for secure TI devices will secure these images before
+they are integrated into the FIT image. When those images are extracted
+from the FIT image at boot time, they are post-processed to verify that
+they are still secure. The outlined security-related SPL post-processing
+is enabled through the CONFIG_SPL_FIT_IMAGE_POST_PROCESS option which
+must be enabled for the secure boot scheme to work. In order to allow
+verifying proper operation of the secure boot chain in case of successful
+authentication messages like "Authentication passed" are output by the
+SPL to the console for each blob that got extracted from the FIT image.
+
+The exact details of the how the images are secured is handled by the
+SECDEV package. Within the SECDEV package exists a script to process
+an input binary image:
+
+.. prompt:: bash
+   :prompts: $
+
+   ${TI_SECURE_DEV_PKG}/scripts/secure-binary-image.sh
+
+This is called as part of the u-boot build process. As the secure
+image formats and requirements can differ between the various secure
+SOCs from TI, this script in the SECDEV package abstracts these
+details. This script is essentially the only required interface to the
+TI SECDEV package for creating a u-boot.img image for secure TI
+devices.
+
+The SPL/u-boot code contains calls to dedicated secure ROM functions
+to perform the validation on the secured images. The details of the
+interface to those functions is shown in the code. The summary
+is that they are accessed by invoking an ARM secure monitor call to
+the device's secure ROM (fixed read-only-memory that is secure and
+only accessible when the ARM core is operating in the secure mode).
+
+Invoking the secure-binary-image script for Secure Devices
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+.. prompt:: bash
+   :prompts: $
+
+   secure-binary-image.sh <INPUT_FILE> <OUTPUT_FILE>
+
+<INPUT_FILE> is the full path and filename of the input binary image
+
+<OUTPUT_FILE> is the full path and filename of the output secure image.
+
+.. secure_boot_include_end_primary_u_boot
+
 NAND
 ----
 
@@ -52,41 +226,53 @@ inserted with the files to write in the first SD slot and that mtdparts
 have been configured correctly for the board. All images are first loaded
 into memory, then written to NAND.
 
-Step-1: Building u-boot for NAND boot
-	Set following CONFIGxx options for NAND device.
-	CONFIG_SYS_NAND_PAGE_SIZE	number of main bytes in NAND page
-	CONFIG_SYS_NAND_OOBSIZE		number of OOB bytes in NAND page
-	CONFIG_SYS_NAND_BLOCK_SIZE	number of bytes in NAND erase-block
-	CFG_SYS_NAND_ECCPOS		ECC map for NAND page
-	CONFIG_NAND_OMAP_ECCSCHEME	(refer doc/README.nand)
-
-Step-2: Flashing NAND via MMC/SD
-
-.. code-block:: text
-
-	# select BOOTSEL to MMC/SD boot and boot from MMC/SD card
-	U-Boot # mmc rescan
-	# erase flash
-	U-Boot # nand erase.chip
-	U-Boot # env default -f -a
-	U-Boot # saveenv
-	# flash MLO. Redundant copies of MLO are kept for failsafe
-	U-Boot # load mmc 0 0x82000000 MLO
-	U-Boot # nand write 0x82000000 0x00000 0x20000
-	U-Boot # nand write 0x82000000 0x20000 0x20000
-	U-Boot # nand write 0x82000000 0x40000 0x20000
-	U-Boot # nand write 0x82000000 0x60000 0x20000
-	# flash u-boot.img
-	U-Boot # load mmc 0 0x82000000 u-boot.img
-	U-Boot # nand write 0x82000000 0x80000 0x60000
-	# flash kernel image
-	U-Boot # load mmc 0 0x82000000 uImage
-	U-Boot # nand write 0x82000000 ${nandsrcaddr} ${nandimgsize}
-	# flash filesystem image
-	U-Boot # load mmc 0 0x82000000 filesystem.img
-	U-Boot # nand write 0x82000000 ${loadaddress} 0x300000
-
-Step-3: Set BOOTSEL pin to select NAND boot, and POR the device.
+1. Building u-boot for NAND boot
+
+.. list-table:: CONFIGxx options for NAND device
+   :widths: 25 25
+   :header-rows: 1
+
+   * - Config
+     - Description
+   * - CONFIG_SYS_NAND_PAGE_SIZE
+     - number of main bytes in NAND page
+   * - CONFIG_SYS_NAND_OOBSIZE
+     - number of OOB bytes in NAND page
+   * - CONFIG_SYS_NAND_BLOCK_SIZE
+     - number of bytes in NAND erase-block
+   * - CFG_SYS_NAND_ECCPOS
+     - ECC map for NAND page
+   * - CONFIG_NAND_OMAP_ECCSCHEME
+     - (refer doc/README.nand)
+
+2. Flashing NAND via MMC/SD
+
+.. prompt:: bash
+   :prompts: =>
+
+   # select BOOTSEL to MMC/SD boot and boot from MMC/SD card
+   mmc rescan
+   # erase flash
+   nand erase.chip
+   env default -f -a
+   saveenv
+   # flash MLO. Redundant copies of MLO are kept for failsafe
+   load mmc 0 0x82000000 MLO
+   nand write 0x82000000 0x00000 0x20000
+   nand write 0x82000000 0x20000 0x20000
+   nand write 0x82000000 0x40000 0x20000
+   nand write 0x82000000 0x60000 0x20000
+   # flash u-boot.img
+   load mmc 0 0x82000000 u-boot.img
+   nand write 0x82000000 0x80000 0x60000
+   # flash kernel image
+   load mmc 0 0x82000000 uImage
+   nand write 0x82000000 ${nandsrcaddr} ${nandimgsize}
+   # flash filesystem image
+   load mmc 0 0x82000000 filesystem.img
+   nand write 0x82000000 ${loadaddress} 0x300000
+
+3. Set BOOTSEL pin to select NAND boot, and POR the device.
 	The device should boot from images flashed on NAND device.
 
 
@@ -107,16 +293,34 @@ Falcon Mode: eMMC
 
 The recommended layout in this case is:
 
-.. code-block:: text
-
-	MMC BLOCKS      |--------------------------------| LOCATION IN BYTES
-	0x0000 - 0x007F : MBR or GPT table               : 0x000000 - 0x020000
-	0x0080 - 0x00FF : ARGS or FDT file               : 0x010000 - 0x020000
-	0x0100 - 0x01FF : SPL.backup1 (first copy used)  : 0x020000 - 0x040000
-	0x0200 - 0x02FF : SPL.backup2 (second copy used) : 0x040000 - 0x060000
-	0x0300 - 0x06FF : U-Boot                         : 0x060000 - 0x0e0000
-	0x0700 - 0x08FF : U-Boot Env + Redundant         : 0x0e0000 - 0x120000
-	0x0900 - 0x28FF : Kernel                         : 0x120000 - 0x520000
+.. list-table:: eMMC Recommended Layout
+   :widths: 25 25 50
+   :header-rows: 1
+
+   * - MMC Blocks
+     - Description
+     - Location in bytes
+   * - 0x0000 - 0x007F
+     - MBR or GPT table
+     - 0x000000 - 0x020000
+   * - 0x0080 - 0x00FF
+     - ARGS or FDT file
+     - 0x010000 - 0x020000
+   * - 0x0100 - 0x01FF
+     - SPL.backup1 (first copy used)
+     - 0x020000 - 0x040000
+   * - 0x0200 - 0x02FF
+     - SPL.backup2 (second copy used)
+     - 0x040000 - 0x060000
+   * - 0x0300 - 0x06FF
+     - U-Boot
+     - 0x060000 - 0x0e0000
+   * - 0x0700 - 0x08FF
+     - U-Boot Env + Redundant
+     - 0x0e0000 - 0x120000
+   * - 0x0900 - 0x28FF
+     - Kernel
+     - 0x120000 - 0x520000
 
 Note that when we run 'spl export' it will prepare to boot the kernel.
 This includes relocation of the uImage from where we loaded it to the entry
@@ -130,27 +334,28 @@ had a FAT partition (such as on a Beaglebone Black) it is not enough to
 write garbage into the area, you must delete it from the partition table
 first.
 
-.. code-block:: text
-
-	# Ensure we are able to talk with this mmc device
-	U-Boot # mmc rescan
-	U-Boot # tftp 81000000 am335x/MLO
-	# Write to two of the backup locations ROM uses
-	U-Boot # mmc write 81000000 100 100
-	U-Boot # mmc write 81000000 200 100
-	# Write U-Boot to the location set in the config
-	U-Boot # tftp 81000000 am335x/u-boot.img
-	U-Boot # mmc write 81000000 300 400
-	# Load kernel and device tree into memory, perform export
-	U-Boot # tftp 81000000 am335x/uImage
-	U-Boot # run findfdt
-	U-Boot # tftp ${fdtaddr} am335x/${fdtfile}
-	U-Boot # run mmcargs
-	U-Boot # spl export fdt 81000000 - ${fdtaddr}
-	# Write the updated device tree to MMC
-	U-Boot # mmc write ${fdtaddr} 80 80
-	# Write the uImage to MMC
-	U-Boot # mmc write 81000000 900 2000
+.. prompt:: bash
+   :prompts: =>
+
+   # Ensure we are able to talk with this mmc device
+   mmc rescan
+   tftp 81000000 am335x/MLO
+   # Write to two of the backup locations ROM uses
+   mmc write 81000000 100 100
+   mmc write 81000000 200 100
+   # Write U-Boot to the location set in the config
+   tftp 81000000 am335x/u-boot.img
+   mmc write 81000000 300 400
+   # Load kernel and device tree into memory, perform export
+   tftp 81000000 am335x/uImage
+   run findfdt
+   tftp ${fdtaddr} am335x/${fdtfile}
+   run mmcargs
+   spl export fdt 81000000 - ${fdtaddr}
+   # Write the updated device tree to MMC
+   mmc write ${fdtaddr} 80 80
+   # Write the uImage to MMC
+   mmc write 81000000 900 2000
 
 Falcon Mode: FAT SD cards
 -------------------------
@@ -161,28 +366,30 @@ the FAT filesystem (only the uImage MUST be for this to function
 afterwards) along with a Falcon Mode aware MLO and the FAT partition has
 already been created and marked bootable:
 
-.. code-block:: text
+.. prompt:: bash
+   :prompts: =>
 
-	U-Boot # mmc rescan
-	# Load kernel and device tree into memory, perform export
-	U-Boot # load mmc 0:1 ${loadaddr} uImage
-	U-Boot # run findfdt
-	U-Boot # load mmc 0:1 ${fdtaddr} ${fdtfile}
-	U-Boot # run mmcargs
-	U-Boot # spl export fdt ${loadaddr} - ${fdtaddr}
+   mmc rescan
+   # Load kernel and device tree into memory, perform export
+   load mmc 0:1 ${loadaddr} uImage
+   run findfdt
+   load mmc 0:1 ${fdtaddr} ${fdtfile}
+   run mmcargs
+   spl export fdt ${loadaddr} - ${fdtaddr}
 
 This will print a number of lines and then end with something like:
 
-.. code-block:: text
+.. code-block:: bash
 
-           Using Device Tree in place at 80f80000, end 80f85928
-           Using Device Tree in place at 80f80000, end 80f88928
+   Using Device Tree in place at 80f80000, end 80f85928
+   Using Device Tree in place at 80f80000, end 80f88928
 
 So then you:
 
-.. code-block:: text
+.. prompt:: bash
+   :prompts: =>
 
-        U-Boot # fatwrite mmc 0:1 0x80f80000 args 8928
+   fatwrite mmc 0:1 0x80f80000 args 8928
 
 Falcon Mode: NAND
 -----------------
@@ -193,14 +400,15 @@ already located on the NAND somewhere (such as filesystem or mtd partition)
 along with a Falcon Mode aware MLO written to the correct locations for
 booting and mtdparts have been configured correctly for the board:
 
-.. code-block:: text
+.. prompt:: bash
+   :prompts: =>
 
-	U-Boot # nand read ${loadaddr} kernel
-	U-Boot # load nand rootfs ${fdtaddr} /boot/am335x-evm.dtb
-	U-Boot # run nandargs
-	U-Boot # spl export fdt ${loadaddr} - ${fdtaddr}
-	U-Boot # nand erase.part u-boot-spl-os
-	U-Boot # nand write ${fdtaddr} u-boot-spl-os
+   nand read ${loadaddr} kernel
+   load nand rootfs ${fdtaddr} /boot/am335x-evm.dtb
+   run nandargs
+   spl export fdt ${loadaddr} - ${fdtaddr}
+   nand erase.part u-boot-spl-os
+   nand write ${fdtaddr} u-boot-spl-os
 
 USB device
 ----------
@@ -217,27 +425,35 @@ The output of the 'dm tree' command shows which driver is bound to which
 device, so the user can easily configure their platform differently from
 the command line:
 
+.. prompt:: bash
+   :prompts: =>
+
+   dm tree
+
 .. code-block:: text
 
-	=> dm tree
-	 Class     Index  Probed  Driver                Name
-	-----------------------------------------------------------
-	[...]
-	misc          0  [ + ]   ti-musb-wrapper       |   |-- usb@47400000
-	usb           0  [ + ]   ti-musb-peripheral    |   |   |-- usb@47401000
-	ethernet      1  [ + ]   usb_ether             |   |   |   `-- usb_ether
-	bootdev       3  [   ]   eth_bootdev           |   |   |       `-- usb_ether.bootdev
-	usb           0  [   ]   ti-musb-host          |   |   `-- usb@47401800
+   Class     Index  Probed  Driver                Name
+  -----------------------------------------------------------
+  [...]
+  misc          0  [ + ]   ti-musb-wrapper       |   |-- usb@47400000
+  usb           0  [ + ]   ti-musb-peripheral    |   |   |-- usb@47401000
+  ethernet      1  [ + ]   usb_ether             |   |   |   `-- usb_ether
+  bootdev       3  [   ]   eth_bootdev           |   |   |       `-- usb_ether.bootdev
+  usb           0  [   ]   ti-musb-host          |   |   `-- usb@47401800
 
 Typically here any network command performed using the usb_ether
 interface would work, while using other gadgets would fail:
 
+.. prompt:: bash
+   :prompts: =>
+
+   fastboot usb 0
+
 .. code-block:: text
 
-	=> fastboot usb 0
-	All UDC in use (1 available), use the unbind command
-	g_dnl_register: failed!, error: -19
-	exit not allowed from main input shell.
+  All UDC in use (1 available), use the unbind command
+  g_dnl_register: failed!, error: -19
+  exit not allowed from main input shell.
 
 As hinted by the primary error message, the only controller available
 (usb@47401000) is currently bound to the usb_ether driver, which makes
@@ -246,20 +462,25 @@ least from a bootloader point of view). The solution here would be to
 use the unbind command specifying the class and index parameters (as
 shown above in the 'dm tree' output) to target the driver to unbind:
 
-.. code-block:: text
+.. prompt:: bash
+   :prompts: =>
 
-	=> unbind ethernet 1
+   unbind ethernet 1
 
 The output of the 'dm tree' command now shows the availability of the
 first USB device controller, the fastboot gadget will now be able to
 bind with it:
 
+.. prompt:: bash
+   :prompts: =>
+
+   dm tree
+
 .. code-block:: text
 
-	=> dm tree
-	 Class     Index  Probed  Driver                Name
-	-----------------------------------------------------------
-	[...]
-	misc          0  [ + ]   ti-musb-wrapper       |   |-- usb@47400000
-	usb           0  [   ]   ti-musb-peripheral    |   |   |-- usb@47401000
-	usb           0  [   ]   ti-musb-host          |   |   `-- usb@47401800
+  Class     Index  Probed  Driver                Name
+  -----------------------------------------------------------
+  [...]
+  misc          0  [ + ]   ti-musb-wrapper       |   |-- usb@47400000
+  usb           0  [   ]   ti-musb-peripheral    |   |   |-- usb@47401000
+  usb           0  [   ]   ti-musb-host          |   |   `-- usb@47401800
diff --git a/doc/board/ti/am43xx_evm.rst b/doc/board/ti/am43xx_evm.rst
new file mode 100644
index 0000000000..543526cd28
--- /dev/null
+++ b/doc/board/ti/am43xx_evm.rst
@@ -0,0 +1,188 @@
+.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. sectionauthor:: Neha Malcom Francis <n-francis@ti.com>
+
+AM43xx Generation
+=================
+
+Secure Boot
+-----------
+
+.. include:: am335x_evm.rst
+   :start-after: .. secure_boot_include_start_config_ti_secure_device
+   :end-before: .. secure_boot_include_end_config_ti_secure_device
+
+.. include:: am335x_evm.rst
+   :start-after: .. secure_boot_include_start_spl_boot
+   :end-before: .. secure_boot_include_end_spl_boot
+
+<IMAGE_FLAG> is a value that specifies the type of the image to
+generate OR the action the image generation tool will take. Valid
+values are:
+
+.. list-table::
+   :widths: 25 25
+   :header-rows: 0
+
+   * - SPI_X-LOADER
+     - Generates an image for SPI flash (byte swapped)
+   * - XIP_X-LOADER
+     - Generates a single stage u-boot for NOR/QSPI XiP
+   * - ISSW
+     - Generates an image for all other boot modes
+
+<INPUT_FILE> is the full path and filename of the public world boot
+loaderbinary file (depending on the boot media, this is usually
+either u-boot-spl.bin or u-boot.bin).
+
+<OUTPUT_FILE> is the full path and filename of the final secure
+image. The output binary images should be used in place of the standard
+non-secure binary images (see the platform-specific user's guides and
+releases notes for how the non-secure images are typically used)
+
+.. list-table::
+   :widths: 25 25
+   :header-rows: 0
+
+   * - u-boot-spl_HS_SPI_X-LOADER
+     - byte swapped boot image for SPI flash
+   * - u-boot_HS_XIP_X-LOADER
+     - boot image for NOR or QSPI Xip flash
+   * - u-boot-spl_HS_ISSW
+     - boot image for all other boot media
+
+
+<SPL_LOAD_ADDR> is the address at which SOC ROM should load the
+<INPUT_FILE>
+
+.. include:: am335x_evm.rst
+   :start-after: .. secure_boot_include_start_primary_u_boot
+   :end-before: .. secure_boot_include_end_primary_u_boot
+
+.. qspi_boot_support_include_start
+
+QSPI U-Boot support
+-------------------
+
+Host processor is connected to serial flash device via qpsi
+interface. QSPI is a kind of spi module that allows single,
+dual and quad read access to external spi devices. The module
+has a memory mapped interface which provide direct interface
+for accessing data form external spi devices.
+
+The one QSPI in the device is primarily intended for fast booting
+from Quad SPI flash devices.
+
+Usecase
+^^^^^^^
+
+MLO/u-boot.img will be flashed from SD/MMC to the flash device
+using serial flash erase and write commands. Then, switch settings
+will be changed to qspi boot. Then, the ROM code will read MLO
+from the predefined location in the flash, where it was flashed and
+execute it after storing it in SDRAM. Then, the MLO will read
+u-boot.img from flash and execute it from SDRAM.
+
+SPI mode
+^^^^^^^^
+
+SPI mode uses mtd spi framework for transfer and reception of data.
+Can be used in:
+
+ #. Normal mode: use single pin for transfers
+ #. Dual Mode: use two pins for transfers.
+ #. Quad mode: use four pin for transfer
+
+Memory mapped read mode
+^^^^^^^^^^^^^^^^^^^^^^^
+
+In this, SPI controller is configured using configuration port and then
+controller is switched to memory mapped port for data read.
+
+Driver
+^^^^^^
+
+drivers/qspi/ti_qspi.c
+    - File which is responsible for configuring the
+      qspi controller and also for providing the low level api which
+      is responsible for transferring the datas from host controller
+      to flash device and vice versa.
+
+.. qspi_boot_support_include_end
+
+Testing
+^^^^^^^
+
+These are the testing details of qspi flash driver with Macronix M25L51235
+flash device.
+
+The test includes
+ - probing the flash device
+ - erasing the flash device
+ - Writing to flash
+ - Reading the contents of the flash.
+
+Test Log
+
+.. code-block:: bash
+
+  Hit any key to stop autoboot:  0
+  => sf probe 0
+  SF: Detected MX25L51235F with page size 256 Bytes, erase size 64 KiB, total 64 MiB, mapped at 30000000
+  => sf erase 0 0x80000
+  SF: 524288 bytes @ 0x0 Erased: OK
+  => mw 81000000 0xdededede 0x40000
+  => sf write 81000000 0 0x40000
+  SF: 262144 bytes @ 0x0 Written: OK
+  => sf read 82000000 0 0x40000
+  SF: 262144 bytes @ 0x0 Read: OK
+  => md 0x82000000
+  82000000: dededede dededede dededede dededede    ................
+  82000010: dededede dededede dededede dededede    ................
+  82000020: dededede dededede dededede dededede    ................
+  82000030: dededede dededede dededede dededede    ................
+  82000040: dededede dededede dededede dededede    ................
+  82000050: dededede dededede dededede dededede    ................
+  82000060: dededede dededede dededede dededede    ................
+  82000070: dededede dededede dededede dededede    ................
+  82000080: dededede dededede dededede dededede    ................
+  82000090: dededede dededede dededede dededede    ................
+  820000a0: dededede dededede dededede dededede    ................
+  820000b0: dededede dededede dededede dededede    ................
+  820000c0: dededede dededede dededede dededede    ................
+  820000d0: dededede dededede dededede dededede    ................
+  820000e0: dededede dededede dededede dededede    ................
+  820000f0: dededede dededede dededede dededede    ................
+  => md 0x82010000
+  82010000: dededede dededede dededede dededede    ................
+  82010010: dededede dededede dededede dededede    ................
+  82010020: dededede dededede dededede dededede    ................
+  82010030: dededede dededede dededede dededede    ................
+  82010040: dededede dededede dededede dededede    ................
+  82010050: dededede dededede dededede dededede    ................
+  82010060: dededede dededede dededede dededede    ................
+  82010070: dededede dededede dededede dededede    ................
+  82010080: dededede dededede dededede dededede    ................
+  82010090: dededede dededede dededede dededede    ................
+  820100a0: dededede dededede dededede dededede    ................
+  820100b0: dededede dededede dededede dededede    ................
+  820100c0: dededede dededede dededede dededede    ................
+  820100d0: dededede dededede dededede dededede    ................
+  820100e0: dededede dededede dededede dededede    ................
+  820100f0: dededede dededede dededede dededede    ................
+  => md 0x82030000
+  82030000: dededede dededede dededede dededede    ................
+  82030010: dededede dededede dededede dededede    ................
+  82030020: dededede dededede dededede dededede    ................
+  82030030: dededede dededede dededede dededede    ................
+  82030040: dededede dededede dededede dededede    ................
+  82030050: dededede dededede dededede dededede    ................
+  82030060: dededede dededede dededede dededede    ................
+  82030070: dededede dededede dededede dededede    ................
+  82030080: dededede dededede dededede dededede    ................
+  82030090: dededede dededede dededede dededede    ................
+  820300a0: dededede dededede dededede dededede    ................
+  820300b0: dededede dededede dededede dededede    ................
+  820300c0: dededede dededede dededede dededede    ................
+  820300d0: dededede dededede dededede dededede    ................
+  820300e0: dededede dededede dededede dededede    ................
+  820300f0: dededede dededede dededede dededede    ................
diff --git a/doc/board/ti/dra7xx_evm.rst b/doc/board/ti/dra7xx_evm.rst
new file mode 100644
index 0000000000..4503b5e922
--- /dev/null
+++ b/doc/board/ti/dra7xx_evm.rst
@@ -0,0 +1,139 @@
+.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. sectionauthor:: Neha Malcom Francis <n-francis@ti.com>
+
+DRA7xx Generation
+=================
+
+Secure Boot
+-----------
+
+.. include:: am335x_evm.rst
+   :start-after: .. secure_boot_include_start_config_ti_secure_device
+   :end-before: .. secure_boot_include_end_config_ti_secure_device
+
+.. include:: am335x_evm.rst
+   :start-after: .. secure_boot_include_start_spl_boot
+   :end-before: .. secure_boot_include_end_spl_boot
+
+<IMAGE_FLAG> is a value that specifies the type of the image to
+generate OR the action the image generation tool will take. Valid
+values are:
+
+.. list-table::
+   :widths: 25 25
+   :header-rows: 0
+
+   * - X-LOADER
+     - Generates an image for NOR or QSPI boot modes
+   * - MLO
+     - Generates an image for NOR or QSPI boot modes
+   * - ULO
+     - Generates an image for USB/UART peripheral boot modes
+
+<INPUT_FILE> is the full path and filename of the public world boot
+loaderbinary file (for this platform, this is always u-boot-spl.bin).
+
+<OUTPUT_FILE> is the full path and filename of the final secure image.
+The output binary images should be used in place of the standard
+non-secure binary images (see the platform-specific user's guides
+and releases notes for how the non-secure images are typically used)
+
+.. list-table::
+   :widths: 25 25
+   :header-rows: 0
+
+   * - u-boot-spl_HS_SPI_X-LOADER
+     - boot image for SD/MMC/eMMC. This image is
+       copied to a file named MLO, which is the name that
+       the device ROM bootloader requires for loading from
+       the FAT partition of an SD card (same as on
+       non-secure devices)
+   * - u-boot-spl_HS_ULO
+     - boot image for USB/UART peripheral boot modes
+   * - u-boot-spl_HS_X-LOADER
+     - boot image for all other flash memories
+       including QSPI and NOR flash
+
+<SPL_LOAD_ADDR> is the address at which SOC ROM should load the
+<INPUT_FILE>
+
+.. include:: am335x_evm.rst
+   :start-after: .. secure_boot_include_start_primary_u_boot
+   :end-before: .. secure_boot_include_end_primary_u_boot
+
+eMMC Boot Partition Use
+-----------------------
+
+It is possible, depending on SYSBOOT configuration to boot from the eMMC
+boot partitions using (name depending on documentation referenced)
+Alternative Boot operation mode or Boot Sequence Option 1/2.  In this
+example we load MLO and u-boot.img from the build into DDR and then use
+'mmc bootbus' to set the required rate (see TRM) and 'mmc partconfig' to
+set boot0 as the boot device.
+
+.. prompt:: bash
+   :prompts: =>
+
+   setenv autoload no
+   usb start
+   dhcp
+   mmc dev 1 1
+   tftp ${loadaddr} dra7xx/MLO
+   mmc write ${loadaddr} 0 100
+   tftp ${loadaddr} dra7xx/u-boot.img
+   mmc write ${loadaddr} 300 400
+   mmc bootbus 1 2 0 2
+   mmc partconf 1 1 1 0
+   mmc rst-function 1 1
+
+.. include:: am43xx_evm.rst
+   :start-after: qspi_boot_support_include_start
+   :end-before: qspi_boot_support_include_end
+
+Testing
+^^^^^^^
+
+Build the patched U-Boot and load MLO/u-boot.img.
+
+Boot from another medium like MMC
+
+.. prompt:: bash
+
+  => mmc dev 0
+  mmc0 is current device
+  => fatload mmc 0 0x82000000 MLO
+  reading MLO
+  55872 bytes read in 8 ms (6.7 MiB/s)
+  => fatload mmc 0 0x83000000 u-boot.img
+  reading u-boot.img
+  248600 bytes read in 19 ms (12.5 MiB/s)
+
+Commands to erase/write u-boot/MLO to flash device
+
+.. prompt:: bash
+
+  => sf probe 0
+  SF: Detected S25FL256S_64K with page size 256 Bytes, erase size 64 KiB, total 32 MiB, mapped at 5c000000
+  => sf erase 0 0x10000
+  SF: 65536 bytes @ 0x0 Erased: OK
+  => sf erase 0x20000 0x10000
+  SF: 65536 bytes @ 0x20000 Erased: OK
+  => sf erase 0x30000 0x10000
+  SF: 65536 bytes @ 0x30000 Erased: OK
+  => sf erase 0x40000 0x10000
+  SF: 65536 bytes @ 0x40000 Erased: OK
+  => sf erase 0x50000 0x10000
+  SF: 65536 bytes @ 0x50000 Erased: OK
+  => sf erase 0x60000 0x10000
+  SF: 65536 bytes @ 0x60000 Erased: OK
+  => sf write 82000000 0 0x10000
+  SF: 65536 bytes @ 0x0 Written: OK
+  => sf write 83000000 0x20000 0x60000
+  SF: 393216 bytes @ 0x20000 Written: OK
+
+Next, set sysboot to QSPI-1 boot mode(SYSBOOT[5:0] = 100110) and power
+on. ROM should find the GP header at offset 0 and load/execute SPL. SPL
+then detects that ROM was in QSPI-1 mode (boot code 10) and attempts to
+find a U-Boot image header at offset 0x20000 (set in the config file)
+and proceeds to load that image using the U-Boot image payload offset/size
+from the header. It will then start U-Boot.
diff --git a/doc/board/ti/index.rst b/doc/board/ti/index.rst
index 89d537d195..b9cdf23e68 100644
--- a/doc/board/ti/index.rst
+++ b/doc/board/ti/index.rst
@@ -7,4 +7,7 @@ Texas Instruments
    :maxdepth: 2
 
    am335x_evm
+   am43xx_evm
+   dra7xx_evm
+   ks2_evm
    k3
diff --git a/doc/board/ti/ks2_evm.rst b/doc/board/ti/ks2_evm.rst
new file mode 100644
index 0000000000..0a789037a6
--- /dev/null
+++ b/doc/board/ti/ks2_evm.rst
@@ -0,0 +1,306 @@
+.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. sectionauthor:: Neha Malcom Francis <n-francis@ti.com>
+
+Keystone II EVM Generation
+==========================
+
+Summary
+-------
+
+This README has information on the U-Boot port for K2HK, K2E, and K2L EVM boards.
+Documentation for this board can be found at:
+
+ - http://www.advantech.com/Support/TI-EVM/EVMK2HX_sd.aspx
+ - https://www.einfochips.com/index.php/partnerships/texas-instruments/k2e-evm.html
+ - https://www.einfochips.com/index.php/partnerships/texas-instruments/k2l-evm.html
+
+The K2HK board is based on Texas Instruments Keystone2 family of SoCs: K2H, K2K.
+More details on these SoCs are available at company websites:
+
+K2K: http://www.ti.com/product/tci6638k2k
+K2H: http://www.ti.com/product/tci6638k2h
+
+The K2E SoC details are available at
+ http://www.ti.com/lit/ds/symlink/66ak2e05.pdf
+
+The K2L SoC details are available at
+ http://www.ti.com/lit/ds/symlink/tci6630k2l.pdf
+
+The K2G SoC details are available at
+ http://www.ti.com/lit/ds/symlink/66ak2g02.pdf
+
+Board Configuration
+-------------------
+
+Some of the peripherals that are configured by U-Boot
+
+.. list-table::
+   :widths: 10 10 10 10 10 10 10 10
+   :header-rows: 1
+
+   * -
+     - DDR3
+     - NAND
+     - MSM SRAM
+     - ETH Ports
+     - UART
+     - I2C
+     - SPI
+   * - K2HK
+     - 2
+     - 512MB
+     - 6MB
+     - 4(2)
+     - 2
+     - 3
+     - 3
+   * - K2E
+     - 4
+     - 512MB
+     - 2MB
+     - 8(2)
+     - 2
+     - 3
+     - 3
+   * - K2L
+     - 2
+     - 512MB
+     - 2MB
+     - 4(2)
+     - 4
+     - 3
+     - 3
+   * - K2G
+     - 2
+     - 256MB
+     - 1MB
+     - 1
+     - 1
+     - 1
+     - 1
+
+There are only 2 eth port installed on the boards.
+
+There are separate PLLs to drive clocks to Tetris ARM and Peripherals.
+To bring up SMP Linux on this board, there is a boot monitor
+code that will be installed in MSMC SRAM. There is command available
+to install this image from U-Boot.
+
+The port related files can be found at following folders:
+ - keystone2 SoC related files: arch/arm/cpu/armv7/keystone/
+ - EVMs board files: board/ti/k2s_evm/
+
+Board configuration files:
+ - include/configs/k2hk_evm.h
+ - include/configs/k2e_evm.h
+ - include/configs/k2l_evm.h
+ - include/configs/k2g_evm.h
+
+As U-Boot is migrating to Kconfig there is also board defconfig files
+ - configs/k2e_evm_defconfig
+ - configs/k2hk_evm_defconfig
+ - configs/k2l_evm_defconfig
+ - configs/k2g_evm_defconfig
+
+Supported boot modes:
+ - SPI NOR boot
+ - AEMIF NAND boot (K2E, K2L and K2HK)
+ - UART boot
+ - MMC boot (Only on K2G)
+
+Supported image formats:
+ - u-boot.bin: for loading and running u-boot.bin through Texas Instruments Code
+   Composer Studio (CCS) and for UART boot.
+ - u-boot-spi.gph: gpimage for programming SPI NOR flash for SPI NOR boot
+ - MLO: gpimage for programming NAND flash for NAND boot, MMC boot.
+
+Build Instructions
+------------------
+
+Examples for k2hk, for k2e, k2l and k2g just replace k2hk prefix accordingly.
+Don't forget to add CROSS_COMPILE.
+
+To build u-boot.bin, u-boot-spi.gph, MLO:
+
+.. prompt:: bash
+   :prompts: $
+
+   make k2hk_evm_defconfig
+   make
+
+Load and Run U-Boot on Keystone EVMs using CCS
+----------------------------------------------
+
+Need Code Composer Studio (CCS) installed on a PC to load and run u-boot.bin
+on EVM? See instructions at below link for installing CCS on a Windows PC.
+
+        `<http://processors.wiki.ti.com/index.php/MCSDK_UG_Chapter_Getting_Started#Installing_Code_Composer_Studio>`_
+
+Use u-boot.bin from the build folder for loading and running U-Boot binary
+on EVM. Follow instructions at:
+
+ - K2HK http://processors.wiki.ti.com/index.php/EVMK2H_Hardware_Setup
+ - K2E  http://processors.wiki.ti.com/index.php/EVMK2E_Hardware_Setup
+ - K2L  http://processors.wiki.ti.com/index.php/TCIEVMK2L_Hardware_Setup
+ - K2G  http://processors.wiki.ti.com/index.php/66AK2G02_GP_EVM_Hardware_Setup
+
+to configure SW1 dip switch to use "No Boot/JTAG DSP Little Endian Boot Mode"
+and Power ON the EVM.  Follow instructions to connect serial port of EVM to
+PC and start TeraTerm or Hyper Terminal.
+
+Start CCS on a Windows machine and Launch Target configuration as instructed at
+
+        `<http://processors.wiki.ti.com/index.php/MCSDK_UG_Chapter_Exploring#Loading_and_Running_U-Boot_on_EVM_through_CCS>`_
+
+The instructions provided in the above link uses a script for
+loading the U-Boot binary on the target EVM. Instead do the following:-
+
+#. Right click to "Texas Instruments XDS2xx USB Emulator_0/CortexA15_1 core (D
+   is connected: Unknown)" at the debug window (This is created once Target
+   configuration is launched) and select "Connect Target".
+#. Once target connect is successful, choose Tools->Load Memory option from the
+   top level menu. At the Load Memory window, choose the file u-boot.bin
+   through "Browse" button and click "next >" button. In the next window, enter
+   Start address as 0xc000000, choose Type-size "32 bits" and click "Finish"
+   button.
+#. Click View -> Registers from the top level menu to view registers window.
+#. From Registers, window expand "Core Registers" to view PC. Edit PC value
+   to be 0xc000000. From the "Run" top level menu, select "Free Run"
+#. The U-Boot prompt is shown at the Tera Term/ Hyper terminal console as
+   below and type any key to stop autoboot as instructed.
+
+.. code-block:: bash
+
+  U-Boot 2014.04-rc1-00201-gc215b5a (Mar 21 2014 - 12:47:59)
+
+  I2C:   ready
+  Detected SO-DIMM [SQR-SD3T-2G1333SED]
+  DRAM:  1.1 GiB
+  NAND:  512 MiB
+  Net:   K2HK_EMAC
+  Warning: K2HK_EMAC using MAC address from net device
+  , K2HK_EMAC1, K2HK_EMAC2, K2HK_EMAC3
+  Hit any key to stop autoboot:  0
+
+SPI NOR Flash Programming Instructions
+--------------------------------------
+
+U-Boot image can be flashed to first 512KB of the NOR flash using following
+instructions:
+
+1. Start CCS and run U-Boot as described above.
+2. Suspend Target. Select Run -> Suspend from top level menu
+   CortexA15_1 (Free Running)"
+3. Load u-boot-spi.gph binary from build folder on to DDR address 0x87000000
+   through CCS as described in step 2 of "Load and Run U-Boot on K2HK/K2E/K2L
+   EVM using CCS", but using address 0x87000000.
+4. Free Run the target as described earlier (step 4) to get U-Boot prompt
+5. At the U-Boot console type following to setup U-Boot environment variables.
+
+.. prompt:: bash
+   :prompts: =>
+
+   setenv addr_uboot 0x87000000
+   setenv filesize <size in hex of u-boot-spi.gph rounded to hex 0x10000>
+   run burn_uboot_spi
+
+Once U-Boot prompt is available, power off the EVM. Set the SW1 dip switch to
+"SPI Little Endian Boot mode" as per instruction at
+
+        `<http://processors.wiki.ti.com/index.php/*_Hardware_Setup>`_
+
+6. Power ON the EVM. The EVM now boots with U-Boot image on the NOR flash.
+
+AEMIF NAND Flash programming instructions
+-----------------------------------------
+
+U-Boot image can be flashed to first 1024KB of the NAND flash using following
+instructions:
+
+1. Start CCS and run U-Boot as described above.
+2. Suspend Target. Select Run -> Suspend from top level menu
+   CortexA15_1 (Free Running)"
+3. Load MLO binary from build folder on to DDR address 0x87000000
+   through CCS as described in step 2 of "Load and Run U-Boot on K2HK EVM
+   using CCS", but using address 0x87000000.
+4. Free Run the target as described earlier (step 4) to get U-Boot prompt
+5. At the U-Boot console type following to setup U-Boot environment variables.
+
+.. prompt:: bash
+   :prompts: =>
+
+   setenv filesize <size in hex of MLO rounded to hex 0x10000>
+   run burn_uboot_nand
+
+Once U-Boot prompt is available, Power OFF the EVM. Set the SW1 dip switch to
+"ARM NAND Boot mode" as per instruction at
+
+        `<http://processors.wiki.ti.com/index.php/>`_
+
+under Hardware Setup
+
+6. Power ON the EVM. The EVM now boots with U-Boot image on the NAND flash.
+
+Load and Run U-Boot on keystone EVMs using UART download
+--------------------------------------------------------
+
+Open BMC and regular UART terminals.
+
+1. On the regular UART port start xmodem transfer of the u-boot.bin
+2. Using BMC terminal set the ARM-UART bootmode and reboot the EVM
+
+.. prompt:: bash
+
+   BMC> bootmode #4
+   MBC> reboot
+
+3. When xmodem is complete you should see the U-Boot starts on the UART port
+
+Load and Run U-Boot on K2G EVMs using MMC
+-----------------------------------------
+
+Open BMC and regular UART terminals.
+
+1. Set the SW3 dip switch to "ARM MMC Boot mode" as per instruction at
+
+        `<http://processors.wiki.ti.com/index.php/66AK2G02_GP_EVM_Hardware_Setup>`_
+
+2. Create SD card partitions as per steps given in Hardware Setup Guide.
+3. Copy MLO to Boot Partition.
+4. Insert SD card and Power on the EVM.
+   The EVM now boots with U-Boot image from SD card.
+
+Secure Boot
+-----------
+
+.. include:: am335x_evm.rst
+   :start-after: .. secure_boot_include_start_config_ti_secure_device
+   :end-before: .. secure_boot_include_end_config_ti_secure_device
+
+.. include:: am335x_evm.rst
+   :start-after: .. secure_boot_include_start_spl_boot
+   :end-before: .. secure_boot_include_end_spl_boot
+
+<IMAGE_FLAG> is currently ignored and reserved for future use.
+
+<INPUT_FILE> is the full path and filename of the public world boot
+loader binary file (only u-boot.bin is currently supported on
+Keystone2 devices, u-boot-spl.bin is not currently supported).
+
+<OUTPUT_FILE> is the full path and filename of the final secure image.
+The output binary images should be used in place of the standard
+non-secure binary images (see the platform-specific user's guides
+and releases notes for how the non-secure images are typically used)
+
+.. list-table::
+   :widths: 10 20
+   :header-rows: 0
+
+   * - u-boot_HS_MLO
+     - signed and encrypted boot image that can be used to
+       boot from all media. Secure boot from SPI NOR flash is not
+       currently supported.
+
+.. include:: am335x_evm.rst
+   :start-after: .. secure_boot_include_start_primary_u_boot
+   :end-before: .. secure_boot_include_end_primary_u_boot
-- 
2.34.1

