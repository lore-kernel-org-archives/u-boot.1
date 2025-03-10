Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A03C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 13:37:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 031D8811B2;
	Mon, 10 Mar 2025 14:37:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ii6QtUdB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84CFF8122F; Mon, 10 Mar 2025 14:37:09 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA50F80107
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 14:37:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52ADb34H403065
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Mar 2025 08:37:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741613823;
 bh=BduwCatr3QGJCK5hDTmKNVGJTY9jxZLGLG6YY1HIObc=;
 h=From:To:CC:Subject:Date;
 b=ii6QtUdBsX26QSoU+q6wRL7EX/KSrRcvJ2aHBj3c7W1aC0Gr991Tp15PfKLibsXzf
 exHH/YOkaWvKCyWXwYXGMm8dBR18WEDWff9oV4s38bKHLsvnQp3hDC9fZcW6bfJ44G
 54F7l5QJHz/nZP3h+oxzSlqAdo0D43kfKk4I7WjM=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52ADb31m096132
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Mar 2025 08:37:03 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Mar 2025 08:37:02 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Mar 2025 08:37:02 -0500
Received: from localhost (a0543016.dhcp.ti.com [172.24.227.225])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52ADb1To082473;
 Mon, 10 Mar 2025 08:37:02 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>
Subject: [PATCH v1] config: falcon: move CFG_SYS_SPI_* to Kconfig
Date: Mon, 10 Mar 2025 19:06:46 +0530
Message-ID: <20250310133647.2712374-1-anshuld@ti.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

CFG_SYS_SPI_* are used in falcon boot to specify the offsets and size of
the repsective payloads. This patch moves them to Kconfig keeping the
values consistent for each of the effected boards.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Tested:
* U-boot CI: https://github.com/u-boot/u-boot/pull/750
---
 common/spl/Kconfig                   | 18 ++++++++++++++++++
 common/spl/spl_spi.c                 |  9 +++++----
 configs/am57xx_evm_defconfig         |  3 +++
 configs/am57xx_hs_evm_defconfig      |  3 +++
 configs/am57xx_hs_evm_usb_defconfig  |  3 +++
 configs/display5_defconfig           |  3 +++
 configs/display5_factory_defconfig   |  3 +++
 configs/dra7xx_evm_defconfig         |  3 +++
 configs/dra7xx_hs_evm_defconfig      |  3 +++
 configs/dra7xx_hs_evm_usb_defconfig  |  3 +++
 configs/imx28_xea_defconfig          |  3 +++
 configs/xilinx_zynq_virt_defconfig   |  3 +++
 configs/xilinx_zynqmp_kria_defconfig |  3 +++
 configs/xilinx_zynqmp_virt_defconfig |  3 +++
 include/configs/am57xx_evm.h         | 16 ----------------
 include/configs/display5.h           |  5 -----
 include/configs/dra7xx_evm.h         | 16 ----------------
 include/configs/xea.h                |  6 ------
 include/configs/xilinx_zynqmp.h      |  6 ------
 include/configs/zynq-common.h        |  8 --------
 20 files changed, 59 insertions(+), 61 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 94e118f8465..7ff0b468954 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1431,6 +1431,24 @@ config SYS_SPI_U_BOOT_OFFS
 	 Address within SPI-Flash from where the u-boot payload is fetched
 	 from.
 
+config SYS_SPI_KERNEL_OFFS
+	hex "Falcon mode: address of kernel payload in SPI flash"
+	depends on SPL_SPI_FLASH_SUPPORT && SPL_OS_BOOT
+	help
+	 Address within SPI-Flash from where the kernel payload is feteched
+	 in falcon boot.
+
+config SYS_SPI_ARGS_OFFS
+	hex "Falcon mode: address of args payload in SPI flash"
+	depends on SPL_SPI_FLASH_SUPPORT && SPL_OS_BOOT
+	help
+	 Address within SPI-Flash from where the args payload (usually the
+	 dtb) is feteched in falcon boot.
+
+config SYS_SPI_ARGS_SIZE
+	hex "Falcon mode: size of args payload in SPI flash"
+	depends on SPL_SPI_FLASH_SUPPORT && SPL_OS_BOOT
+
 config SPL_THERMAL
 	bool "Driver support for thermal devices"
 	help
diff --git a/common/spl/spl_spi.c b/common/spl/spl_spi.c
index 691a431a926..00dbd3011f0 100644
--- a/common/spl/spl_spi.c
+++ b/common/spl/spl_spi.c
@@ -82,13 +82,14 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 #if CONFIG_IS_ENABLED(OS_BOOT)
 	if (spl_start_uboot()) {
 		int err = spl_load(spl_image, bootdev, &load, 0,
-				   CFG_SYS_SPI_KERNEL_OFFS);
+				   CONFIG_SYS_SPI_KERNEL_OFFS);
 
 		if (!err)
 			/* Read device tree. */
-			return spi_flash_read(flash, CFG_SYS_SPI_ARGS_OFFS,
-					      CFG_SYS_SPI_ARGS_SIZE,
-					      (void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR);
+			return spi_flash_read(
+				flash, CONFIG_SYS_SPI_ARGS_OFFS,
+				CONFIG_SYS_SPI_ARGS_SIZE,
+				(void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR);
 	}
 #endif
 
diff --git a/configs/am57xx_evm_defconfig b/configs/am57xx_evm_defconfig
index d10d2a5940f..0cfad501298 100644
--- a/configs/am57xx_evm_defconfig
+++ b/configs/am57xx_evm_defconfig
@@ -41,6 +41,9 @@ CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR=0x1500
 CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS=0x200
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
+CONFIG_SYS_SPI_KERNEL_OFFS=0x1E0000
+CONFIG_SYS_SPI_ARGS_OFFS=0x140000
+CONFIG_SYS_SPI_ARGS_SIZE=0x80000
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_CMD_ADTIMG=y
 CONFIG_CMD_ABOOTIMG=y
diff --git a/configs/am57xx_hs_evm_defconfig b/configs/am57xx_hs_evm_defconfig
index 5cacd7f9cc5..14700d59bdb 100644
--- a/configs/am57xx_hs_evm_defconfig
+++ b/configs/am57xx_hs_evm_defconfig
@@ -39,6 +39,9 @@ CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
+CONFIG_SYS_SPI_KERNEL_OFFS=0x1E0000
+CONFIG_SYS_SPI_ARGS_OFFS=0x140000
+CONFIG_SYS_SPI_ARGS_SIZE=0x80000
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_CMD_ADTIMG=y
 CONFIG_CMD_ABOOTIMG=y
diff --git a/configs/am57xx_hs_evm_usb_defconfig b/configs/am57xx_hs_evm_usb_defconfig
index d865b123b90..634294e4766 100644
--- a/configs/am57xx_hs_evm_usb_defconfig
+++ b/configs/am57xx_hs_evm_usb_defconfig
@@ -41,6 +41,9 @@ CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
+CONFIG_SYS_SPI_KERNEL_OFFS=0x1E0000
+CONFIG_SYS_SPI_ARGS_OFFS=0x140000
+CONFIG_SYS_SPI_ARGS_SIZE=0x80000
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_CMD_ADTIMG=y
 CONFIG_CMD_ABOOTIMG=y
diff --git a/configs/display5_defconfig b/configs/display5_defconfig
index 765920bd5d1..b30b52f068c 100644
--- a/configs/display5_defconfig
+++ b/configs/display5_defconfig
@@ -53,6 +53,9 @@ CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR=0x3F00
 CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS=0x10
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x20000
+CONFIG_SYS_SPI_KERNEL_OFFS=0x150000
+CONFIG_SYS_SPI_ARGS_OFFS=0x140000
+CONFIG_SYS_SPI_ARGS_SIZE=0x10000
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="display5 > "
 CONFIG_SYS_MAXARGS=32
diff --git a/configs/display5_factory_defconfig b/configs/display5_factory_defconfig
index 4007c8900ce..9965e00a1d0 100644
--- a/configs/display5_factory_defconfig
+++ b/configs/display5_factory_defconfig
@@ -48,6 +48,9 @@ CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR=0x3F00
 CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS=0x10
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x20000
+CONFIG_SYS_SPI_KERNEL_OFFS=0x150000
+CONFIG_SYS_SPI_ARGS_OFFS=0x140000
+CONFIG_SYS_SPI_ARGS_SIZE=0x10000
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="display5 factory > "
 CONFIG_SYS_MAXARGS=32
diff --git a/configs/dra7xx_evm_defconfig b/configs/dra7xx_evm_defconfig
index 2448befb295..f9cb732357c 100644
--- a/configs/dra7xx_evm_defconfig
+++ b/configs/dra7xx_evm_defconfig
@@ -43,6 +43,9 @@ CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR=0x1500
 CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS=0x200
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
+CONFIG_SYS_SPI_KERNEL_OFFS=0x1E0000
+CONFIG_SYS_SPI_ARGS_OFFS=0x140000
+CONFIG_SYS_SPI_ARGS_SIZE=0x80000
 CONFIG_CMD_SPL=y
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
 CONFIG_CMD_NAND=y
diff --git a/configs/dra7xx_hs_evm_defconfig b/configs/dra7xx_hs_evm_defconfig
index f6f00454aaa..81da64be811 100644
--- a/configs/dra7xx_hs_evm_defconfig
+++ b/configs/dra7xx_hs_evm_defconfig
@@ -40,6 +40,9 @@ CONFIG_SPL_NAND_ECC=y
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
+CONFIG_SYS_SPI_KERNEL_OFFS=0x1E0000
+CONFIG_SYS_SPI_ARGS_OFFS=0x140000
+CONFIG_SYS_SPI_ARGS_SIZE=0x80000
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
 CONFIG_CMD_NAND=y
 CONFIG_BOOTP_DNS2=y
diff --git a/configs/dra7xx_hs_evm_usb_defconfig b/configs/dra7xx_hs_evm_usb_defconfig
index 850ccd934b7..1d099a56ee8 100644
--- a/configs/dra7xx_hs_evm_usb_defconfig
+++ b/configs/dra7xx_hs_evm_usb_defconfig
@@ -39,6 +39,9 @@ CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
+CONFIG_SYS_SPI_KERNEL_OFFS=0x1E0000
+CONFIG_SYS_SPI_ARGS_OFFS=0x140000
+CONFIG_SYS_SPI_ARGS_SIZE=0x80000
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
 # CONFIG_CMD_SETEXPR is not set
diff --git a/configs/imx28_xea_defconfig b/configs/imx28_xea_defconfig
index 38282e6ea92..348e2735350 100644
--- a/configs/imx28_xea_defconfig
+++ b/configs/imx28_xea_defconfig
@@ -62,6 +62,9 @@ CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR=0x400
 CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS=0x40
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x10000
+CONFIG_SYS_SPI_KERNEL_OFFS=0x100000
+CONFIG_SYS_SPI_ARGS_OFFS=0x80000
+CONFIG_SYS_SPI_ARGS_SIZE=0x8000
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_MAXARGS=32
diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
index 9196a95e88a..7167b9f4bc1 100644
--- a/configs/xilinx_zynq_virt_defconfig
+++ b/configs/xilinx_zynq_virt_defconfig
@@ -50,6 +50,9 @@ CONFIG_SPL_OS_BOOT=y
 CONFIG_SPL_PAYLOAD_ARGS_ADDR=0x10000000
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x100000
+CONFIG_SYS_SPI_KERNEL_OFFS=0x280000
+CONFIG_SYS_SPI_ARGS_OFFS=0x200000
+CONFIG_SYS_SPI_ARGS_SIZE=0x80000
 CONFIG_SYS_MAXARGS=32
 # CONFIG_BOOTM_NETBSD is not set
 CONFIG_CMD_IMLS=y
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index 1a6bd67afb8..269cd4953d1 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -57,6 +57,9 @@ CONFIG_SPL_PAYLOAD_ARGS_ADDR=0x8000000
 CONFIG_SPL_RAM_DEVICE=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x80000
+CONFIG_SYS_SPI_KERNEL_OFFS=0x80000
+CONFIG_SYS_SPI_ARGS_OFFS=0xa0000
+CONFIG_SYS_SPI_ARGS_SIZE=0xa0000
 CONFIG_SPL_ATF=y
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_CMD_SMBIOS=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index e5e56babf4c..7bb017deec8 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -55,6 +55,9 @@ CONFIG_SPL_PAYLOAD_ARGS_ADDR=0x8000000
 CONFIG_SPL_RAM_DEVICE=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x100000
+CONFIG_SYS_SPI_KERNEL_OFFS=0x80000
+CONFIG_SYS_SPI_ARGS_OFFS=0xa0000
+CONFIG_SYS_SPI_ARGS_SIZE=0xa0000
 CONFIG_SPL_ATF=y
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_CMD_SMBIOS=y
diff --git a/include/configs/am57xx_evm.h b/include/configs/am57xx_evm.h
index aa31f3b05a0..266b77fbf68 100644
--- a/include/configs/am57xx_evm.h
+++ b/include/configs/am57xx_evm.h
@@ -37,20 +37,4 @@
 
 /* CPSW Ethernet */
 
-/*
- * Default to using SPI for environment, etc.
- * 0x000000 - 0x040000 : QSPI.SPL (256KiB)
- * 0x040000 - 0x140000 : QSPI.u-boot (1MiB)
- * 0x140000 - 0x1C0000 : QSPI.u-boot-spl-os (512KiB)
- * 0x1C0000 - 0x1D0000 : QSPI.u-boot-env (64KiB)
- * 0x1D0000 - 0x1E0000 : QSPI.u-boot-env.backup1 (64KiB)
- * 0x1E0000 - 0x9E0000 : QSPI.kernel (8MiB)
- * 0x9E0000 - 0x2000000 : USERLAND
- */
-#define CFG_SYS_SPI_KERNEL_OFFS      0x1E0000
-#define CFG_SYS_SPI_ARGS_OFFS        0x140000
-#define CFG_SYS_SPI_ARGS_SIZE        0x80000
-
-/* SPI SPL */
-
 #endif /* __CONFIG_AM57XX_EVM_H */
diff --git a/include/configs/display5.h b/include/configs/display5.h
index 51fa2b03a2e..1d5cde5ac75 100644
--- a/include/configs/display5.h
+++ b/include/configs/display5.h
@@ -29,11 +29,6 @@
  * 0x1F00000 - 0x2000000 : SPI.factory  (1MiB)
  */
 
-/* Below values are "dummy" - only to avoid build break */
-#define CFG_SYS_SPI_KERNEL_OFFS      0x150000
-#define CFG_SYS_SPI_ARGS_OFFS        0x140000
-#define CFG_SYS_SPI_ARGS_SIZE        0x10000
-
 #define CFG_MXC_UART_BASE		UART5_BASE
 
 /* MMC Configs */
diff --git a/include/configs/dra7xx_evm.h b/include/configs/dra7xx_evm.h
index 96dcd731cb6..3c960ca2ce2 100644
--- a/include/configs/dra7xx_evm.h
+++ b/include/configs/dra7xx_evm.h
@@ -47,22 +47,6 @@
 
 #include <configs/ti_omap5_common.h>
 
-/*
- * Default to using SPI for environment, etc.
- * 0x000000 - 0x040000 : QSPI.SPL (256KiB)
- * 0x040000 - 0x140000 : QSPI.u-boot (1MiB)
- * 0x140000 - 0x1C0000 : QSPI.u-boot-spl-os (512KiB)
- * 0x1C0000 - 0x1D0000 : QSPI.u-boot-env (64KiB)
- * 0x1D0000 - 0x1E0000 : QSPI.u-boot-env.backup1 (64KiB)
- * 0x1E0000 - 0x9E0000 : QSPI.kernel (8MiB)
- * 0x9E0000 - 0x2000000 : USERLAND
- */
-#define CFG_SYS_SPI_KERNEL_OFFS	0x1E0000
-#define CFG_SYS_SPI_ARGS_OFFS	0x140000
-#define CFG_SYS_SPI_ARGS_SIZE	0x80000
-
-/* SPI SPL */
-
 /* NAND support */
 #ifdef CONFIG_MTD_RAW_NAND
 /* NAND: device related configs */
diff --git a/include/configs/xea.h b/include/configs/xea.h
index 00d62748733..2b358a41e2b 100644
--- a/include/configs/xea.h
+++ b/include/configs/xea.h
@@ -14,12 +14,6 @@
 
 #include <linux/sizes.h>
 
-/* SPL */
-
-#define CFG_SYS_SPI_KERNEL_OFFS	SZ_1M
-#define CFG_SYS_SPI_ARGS_OFFS	SZ_512K
-#define CFG_SYS_SPI_ARGS_SIZE	SZ_32K
-
 /* Memory configuration */
 #define PHYS_SDRAM_1			0x40000000	/* Base address */
 #define PHYS_SDRAM_1_SIZE		0x10000000	/* Max 256 MB RAM */
diff --git a/include/configs/xilinx_zynqmp.h b/include/configs/xilinx_zynqmp.h
index 13941ba3589..ec78f2ee8ed 100644
--- a/include/configs/xilinx_zynqmp.h
+++ b/include/configs/xilinx_zynqmp.h
@@ -194,12 +194,6 @@
 	"dfu_bufsiz=0x1000\0"
 #endif
 
-#if defined(CONFIG_SPL_SPI_FLASH_SUPPORT)
-# define CFG_SYS_SPI_KERNEL_OFFS	0x80000
-# define CFG_SYS_SPI_ARGS_OFFS	0xa0000
-# define CFG_SYS_SPI_ARGS_SIZE	0xa0000
-#endif
-
 #ifdef CONFIG_SPL_SYS_MALLOC_SIMPLE
 # error "Disable CONFIG_SPL_SYS_MALLOC_SIMPLE. Full malloc needs to be used"
 #endif
diff --git a/include/configs/zynq-common.h b/include/configs/zynq-common.h
index 37c77aa1611..93ae5891a07 100644
--- a/include/configs/zynq-common.h
+++ b/include/configs/zynq-common.h
@@ -191,14 +191,6 @@
 
 /* Not using MMC raw mode - just for compilation purpose */
 
-/* qspi mode is working fine */
-#ifdef CONFIG_ZYNQ_QSPI
-#define CFG_SYS_SPI_ARGS_OFFS	0x200000
-#define CFG_SYS_SPI_ARGS_SIZE	0x80000
-#define CFG_SYS_SPI_KERNEL_OFFS	(CFG_SYS_SPI_ARGS_OFFS + \
-					CFG_SYS_SPI_ARGS_SIZE)
-#endif
-
 /* SP location before relocation, must use scratch RAM */
 
 /* 3 * 64kB blocks of OCM - one is on the top because of bootrom */
-- 
2.43.0

