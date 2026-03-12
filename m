Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C51FED2FC
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 09:58:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81EE0841C2;
	Thu, 12 Mar 2026 10:57:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="X3xeSr2f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A645584167; Thu, 12 Mar 2026 10:57:41 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D02E84180
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 10:57:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=3uCjIMgRIwWqqS03DpaM+i5FLFN8jNd+wSMzZw2IdQY=; b=X3xeSr2fcycvd0/O4KD4Pp1hR4
 +eIBE5ysziCpSpCmm2K+o9jij7ycvTpAmeXiQxqGJfbDh9863cQ49g10haVVnHV28vsamZy3yxjn6
 8+BNjiTmD9HEzlCYG5r7726fGK6TbIXLdH56wH4iZFfi4mr6Eqx2/KZ5PmWbcwWKWZrqcZKGDpgYt
 xSTUbRv6MAv3w/PdCHtnKJnPoNKioWUjOuT+AiO/L+jul7QQ/09lmybaYB6Wxw9g50nMRCVPePfmk
 kLmk35vlChB5P2LIcDsbnca6PPWG0HPxSqhCvqeo62bbXGKVBHNUg3ouvg3XFZmWxSu8SBSSAzafZ
 XMQNiVNw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w0cnR-0007xx-2B; Thu, 12 Mar 2026 10:57:37 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w0cnR-000Fyo-17; Thu, 12 Mar 2026 10:57:37 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Subject: [PATCH 06/13] board: tqma6: change to use shareable tq environment
Date: Thu, 12 Mar 2026 10:57:02 +0100
Message-ID: <20260312095711.3219756-7-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
References: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
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

- while at it create tqma6 environment file
- Remove CFG_FEC_MXC_PHYADDR, the address comes from device tree.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 board/tq/tqma6/tqma6.env     |  47 +++++++
 include/configs/tqma6.h      | 244 ++---------------------------------
 include/configs/tqma6_mba6.h |   3 -
 3 files changed, 61 insertions(+), 233 deletions(-)
 create mode 100644 board/tq/tqma6/tqma6.env

diff --git a/board/tq/tqma6/tqma6.env b/board/tq/tqma6/tqma6.env
new file mode 100644
index 00000000000..b1d7e5cbbcf
--- /dev/null
+++ b/board/tq/tqma6/tqma6.env
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2024-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Max Merchel
+ *
+ * TQMa6 environment
+ */
+
+#include <env/tq/tq-imx-shared.env>
+
+board=tqma6
+boot_os=bootz "${kernel_addr_r}" - "${fdt_addr_r}"
+emmc_bootp_start=TQMA6_MMC_UBOOT_SECTOR_START
+emmc_dev=0
+fdt_addr_r=TQMA6_FDT_ADDRESS
+fdtoverlay_addr_r=TQMA6_FDT_OVERLAY_ADDR
+image=zImage
+kernel_addr_r=CONFIG_SYS_LOAD_ADDR
+pxefile_addr_r=CONFIG_SYS_LOAD_ADDR
+ramdisk_addr_r=TQMA6_INITRD_ADDRESS
+mmcautodetect=yes
+mmcblkdev=0
+mmcdev=CONFIG_ENV_MMC_DEVICE_INDEX
+netdev=eth0
+sd_dev=1
+uboot=u-boot-with-spl.imx
+uboot_mmc_start=TQMA6_MMC_UBOOT_SECTOR_START
+uboot_mmc_size=TQMA6_MMC_UBOOT_SECTOR_COUNT
+uboot_spi_sector_size=TQMA6_SPI_FLASH_SECTOR_SIZE
+uboot_spi_start=TQMA6_SPI_UBOOT_START
+uboot_spi_size=TQMA6_SPI_UBOOT_SIZE
+
+#ifdef CONFIG_USB_FUNCTION_FASTBOOT
+
+/* 0=user 1=boot1 2=boot2 */
+fastboot_mmc_boot_partition = 1
+
+fastboot_partition_alias_all=CONFIG_FASTBOOT_FLASH_MMC_DEV :0
+
+fastboot_raw_partition_bootloader=
+	TQMA6_MMC_UBOOT_SECTOR_START TQMA6_MMC_UBOOT_SECTOR_COUNT mmcpart
+	"${fastboot_mmc_boot_partition}"
+
+fastbootcmd=fastboot usb 0
+
+#endif /* CONFIG_USB_FUNCTION_FASTBOOT */
diff --git a/include/configs/tqma6.h b/include/configs/tqma6.h
index bb335ee1b41..3c6678aa2b8 100644
--- a/include/configs/tqma6.h
+++ b/include/configs/tqma6.h
@@ -7,243 +7,22 @@
  * Configuration settings for the TQ-Systems TQMa6<Q,D,DL,S> module.
  */
 
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include <linux/stringify.h>
-
-/* place code in last 4 MiB of RAM */
+#ifndef __TQMA6_CONFIG_H
+#define __TQMA6_CONFIG_H
 
 #include "mx6_common.h"
 
-/* SPI Flash */
-
-#define TQMA6_SPI_FLASH_SECTOR_SIZE	SZ_64K
-
 /* MMC Configs */
 #define CFG_SYS_FSL_ESDHC_ADDR	0
 
-#if defined(CONFIG_TQMA6X_MMC_BOOT)
-
-#define TQMA6_UBOOT_OFFSET		SZ_1K
-#define TQMA6_UBOOT_SECTOR_START	0x2
-#define TQMA6_UBOOT_SECTOR_COUNT	0x7fe
-
-#define TQMA6_FDT_OFFSET		(2 * SZ_1M)
-#define TQMA6_FDT_SECTOR_START		0x1000
-#define TQMA6_FDT_SECTOR_COUNT		0x800
-
-#define TQMA6_KERNEL_SECTOR_START	0x2000
-#define TQMA6_KERNEL_SECTOR_COUNT	0x2000
-
-#define TQMA6_EXTRA_BOOTDEV_ENV_SETTINGS                                       \
-	"uboot_start="__stringify(TQMA6_UBOOT_SECTOR_START)"\0"                \
-	"uboot_size="__stringify(TQMA6_UBOOT_SECTOR_COUNT)"\0"                 \
-	"fdt_start="__stringify(TQMA6_FDT_SECTOR_START)"\0"                    \
-	"fdt_size="__stringify(TQMA6_FDT_SECTOR_COUNT)"\0"                     \
-	"kernel_start="__stringify(TQMA6_KERNEL_SECTOR_START)"\0"              \
-	"kernel_size="__stringify(TQMA6_KERNEL_SECTOR_COUNT)"\0"               \
-	"mmcdev="__stringify(CONFIG_ENV_MMC_DEVICE_INDEX)"\0"                       \
-	"loadimage=mmc dev ${mmcdev}; "                                        \
-		"mmc read ${loadaddr} ${kernel_start} ${kernel_size};\0"       \
-	"loadfdt=mmc dev ${mmcdev}; "                                          \
-		"mmc read ${fdt_addr} ${fdt_start} ${fdt_size};\0"             \
-	"update_uboot=if tftp ${uboot}; then "                                 \
-		"if itest ${filesize} > 0; then "                              \
-			"mmc dev ${mmcdev}; mmc rescan; "                      \
-			"setexpr blkc ${filesize} + 0x1ff; "                   \
-			"setexpr blkc ${blkc} / 0x200; "                       \
-			"if itest ${blkc} <= ${uboot_size}; then "             \
-				"mmc write ${loadaddr} ${uboot_start} "        \
-					"${blkc}; "                            \
-			"fi; "                                                 \
-		"fi; fi; "                                                     \
-		"setenv filesize; setenv blkc \0"                              \
-	"update_kernel=run kernel_name; "                                      \
-		"if tftp ${kernel}; then "                                     \
-			"if itest ${filesize} > 0; then "                      \
-				"mmc dev ${mmcdev}; mmc rescan; "              \
-				"setexpr blkc ${filesize} + 0x1ff; "           \
-				"setexpr blkc ${blkc} / 0x200; "               \
-				"if itest ${blkc} <= ${kernel_size}; then "    \
-					"mmc write ${loadaddr} "               \
-						"${kernel_start} ${blkc}; "    \
-				"fi; "                                         \
-			"fi; "                                                 \
-		"fi; "                                                         \
-		"setenv filesize; setenv blkc \0"                              \
-	"update_fdt=if tftp ${fdt_file}; then "                                \
-		"if itest ${filesize} > 0; then "                              \
-			"mmc dev ${mmcdev}; mmc rescan; "                      \
-			"setexpr blkc ${filesize} + 0x1ff; "                   \
-			"setexpr blkc ${blkc} / 0x200; "                       \
-			"if itest ${blkc} <= ${fdt_size}; then "               \
-				"mmc write ${loadaddr} ${fdt_start} ${blkc}; " \
-			"fi; "                                                 \
-		"fi; fi; "                                                     \
-		"setenv filesize; setenv blkc \0"                              \
-
-#elif defined(CONFIG_TQMA6X_SPI_BOOT)
-
-#define TQMA6_UBOOT_OFFSET		0x400
-#define TQMA6_UBOOT_SECTOR_START	0x0
-/* max u-boot size: 512k */
-#define TQMA6_UBOOT_SECTOR_SIZE		TQMA6_SPI_FLASH_SECTOR_SIZE
-#define TQMA6_UBOOT_SECTOR_COUNT	0x8
-#define TQMA6_UBOOT_SIZE		(TQMA6_UBOOT_SECTOR_SIZE * \
-					 TQMA6_UBOOT_SECTOR_COUNT)
-
-#define TQMA6_FDT_OFFSET		(CONFIG_ENV_OFFSET_REDUND + \
-					 CONFIG_ENV_SECT_SIZE)
-#define TQMA6_FDT_SECT_SIZE		(TQMA6_SPI_FLASH_SECTOR_SIZE)
-
-#define TQMA6_FDT_SECTOR_START		0x0a /* 8 Sector u-boot, 2 Sector env */
-#define TQMA6_FDT_SECTOR_COUNT		0x01
-
-#define TQMA6_KERNEL_SECTOR_START	0x10
-#define TQMA6_KERNEL_SECTOR_COUNT	0x60
-
-#define TQMA6_EXTRA_BOOTDEV_ENV_SETTINGS                                       \
-	"mmcblkdev=0\0"                                                        \
-	"uboot_offset="__stringify(TQMA6_UBOOT_OFFSET)"\0"                     \
-	"uboot_sectors="__stringify(TQMA6_UBOOT_SECTOR_COUNT)"\0"              \
-	"fdt_start="__stringify(TQMA6_FDT_SECTOR_START)"\0"                    \
-	"fdt_sectors="__stringify(TQMA6_FDT_SECTOR_COUNT)"\0"                  \
-	"kernel_start="__stringify(TQMA6_KERNEL_SECTOR_START)"\0"              \
-	"kernel_sectors="__stringify(TQMA6_KERNEL_SECTOR_COUNT)"\0"            \
-	"update_uboot=if tftp ${uboot}; then "                                 \
-		"if itest ${filesize} > 0; then "                              \
-			"setexpr blkc ${filesize} + "                          \
-				__stringify(TQMA6_UBOOT_OFFSET) "; "           \
-			"setexpr size ${uboot_sectors} * "                     \
-				__stringify(TQMA6_SPI_FLASH_SECTOR_SIZE)"; "   \
-			"if itest ${blkc} <= ${size}; then "                   \
-				"sf probe; "                                   \
-				"sf erase 0 ${size}; "                         \
-				"sf write ${loadaddr} ${uboot_offset} "        \
-					"${filesize}; "                        \
-			"fi; "                                                 \
-		"fi; fi; "                                                     \
-		"setenv filesize 0; setenv blkc; setenv size \0"               \
-	"update_kernel=run kernel_name; if tftp ${kernel}; then "              \
-		"if itest ${filesize} > 0; then "                              \
-			"setexpr size ${kernel_sectors} * "                    \
-				__stringify(TQMA6_SPI_FLASH_SECTOR_SIZE)"; "   \
-			"setexpr offset ${kernel_start} * "                    \
-				__stringify(TQMA6_SPI_FLASH_SECTOR_SIZE)"; "   \
-			"if itest ${filesize} <= ${size}; then "               \
-				"sf probe; "                                   \
-				"sf erase ${offset} ${size}; "                 \
-				"sf write ${loadaddr} ${offset} "              \
-					"${filesize}; "                        \
-			"fi; "                                                 \
-		"fi; fi; "                                                     \
-		"setenv filesize 0; setenv size ; setenv offset\0"             \
-	"update_fdt=if tftp ${fdt_file}; then "                                \
-		"if itest ${filesize} > 0; then "                              \
-			"setexpr size ${fdt_sectors} * "                       \
-				__stringify(TQMA6_SPI_FLASH_SECTOR_SIZE)"; "   \
-			"setexpr offset ${fdt_start} * "                       \
-				__stringify(TQMA6_SPI_FLASH_SECTOR_SIZE)"; "   \
-			"if itest ${filesize} <= ${size}; then "               \
-				"sf probe; "                                   \
-				"sf erase ${offset} ${size}; "                 \
-				"sf write ${loadaddr} ${offset} "              \
-					"${filesize}; "                        \
-			"fi; "                                                 \
-		"fi; fi; "                                                     \
-		"setenv filesize 0; setenv size ; setenv offset\0"             \
-	"loadimage=sf probe; "                                                 \
-		"setexpr size ${kernel_sectors} * "                            \
-			__stringify(TQMA6_SPI_FLASH_SECTOR_SIZE)"; "           \
-		"setexpr offset ${kernel_start} * "                            \
-			__stringify(TQMA6_SPI_FLASH_SECTOR_SIZE)"; "           \
-		"sf read ${loadaddr} ${offset} ${size}; "                      \
-		"setenv size ; setenv offset\0"                                \
-	"loadfdt=sf probe; "                                                   \
-		"setexpr size ${fdt_sectors} * "                               \
-			__stringify(TQMA6_SPI_FLASH_SECTOR_SIZE)"; "           \
-		"setexpr offset ${fdt_start} * "                               \
-			__stringify(TQMA6_SPI_FLASH_SECTOR_SIZE)"; "           \
-		"sf read ${fdt_addr} ${offset} ${size}; "                      \
-		"setenv size ; setenv offset\0"
-#else
-
-#error "need to define boot source"
-
-#endif
-
 /* 128 MiB offset as in ARM related docu for linux suggested */
 #define TQMA6_FDT_ADDRESS		0x18000000
 
-/* set to a resonable value, changeable by user */
-#define TQMA6_CMA_SIZE                 160M
+/* 256KiB above TQMA6_FDT_ADDRESS (TQMA6_FDT_ADDRESS + SZ_256K) */
+#define TQMA6_FDT_OVERLAY_ADDR		0x18040000
 
-#define CFG_EXTRA_ENV_SETTINGS                                              \
-	"board=tqma6\0"                                                        \
-	"uimage=uImage\0"                                                      \
-	"zimage=zImage\0"                                                      \
-	"boot_type=bootz\0"                                                    \
-	"kernel_name=if test \"${boot_type}\" != bootz; then "                 \
-		"setenv kernel ${uimage}; "                                    \
-		"else setenv kernel ${zimage}; fi\0"                           \
-	"uboot=u-boot.imx\0"                                                   \
-	"fdt_file=" CONFIG_DEFAULT_FDT_FILE "\0"                               \
-	"fdt_addr="__stringify(TQMA6_FDT_ADDRESS)"\0"                          \
-	"console=" CONSOLE_DEV "\0"                                            \
-	"cma_size="__stringify(TQMA6_CMA_SIZE)"\0"                             \
-	"initrd_high=0xffffffff\0"                                             \
-	"rootfsmode=ro\0"                                                      \
-	"addcma=setenv bootargs ${bootargs} cma=${cma_size}\0"                 \
-	"addtty=setenv bootargs ${bootargs} console=${console},${baudrate}\0"  \
-	"addfb=setenv bootargs ${bootargs} "                                   \
-		"imx-fbdev.legacyfb_depth=32 consoleblank=0\0"                 \
-	"mmcpart=2\0"                                                          \
-	"mmcblkdev=0\0"                                                        \
-	"mmcargs=run addmmc addtty addfb addcma\0"                             \
-	"addmmc=setenv bootargs ${bootargs} "                                  \
-		"root=/dev/mmcblk${mmcblkdev}p${mmcpart} ${rootfsmode} "       \
-		"rootwait\0"                                                   \
-	"mmcboot=echo Booting from mmc ...; "                                  \
-		"setenv bootargs; "                                            \
-		"run mmcargs; "                                                \
-		"run loadimage; "                                              \
-		"if run loadfdt; then "                                        \
-			"echo boot device tree kernel ...; "                   \
-			"${boot_type} ${loadaddr} - ${fdt_addr}; "             \
-		"else "                                                        \
-			"${boot_type}; "                                       \
-		"fi;\0"                                                        \
-		"setenv bootargs \0"                                           \
-	"netdev=eth0\0"                                                        \
-	"rootpath=/srv/nfs/tqma6\0"                                            \
-	"ipmode=static\0"                                                      \
-	"netargs=run addnfs addip addtty addfb addcma\0"                       \
-	"addnfs=setenv bootargs ${bootargs} "                                  \
-		"root=/dev/nfs rw "                                            \
-		"nfsroot=${serverip}:${rootpath},v3,tcp;\0"                    \
-	"addip_static=setenv bootargs ${bootargs} "                            \
-		"ip=${ipaddr}:${serverip}:${gatewayip}:${netmask}:"            \
-		"${hostname}:${netdev}:off\0"                                  \
-	"addip_dynamic=setenv bootargs ${bootargs} ip=dhcp\0"                  \
-	"addip=if test \"${ipmode}\" != static; then "                         \
-		"run addip_dynamic; else run addip_static; fi\0"               \
-	"set_getcmd=if test \"${ipmode}\" != static; then "                    \
-		"setenv getcmd dhcp; setenv autoload yes; "                    \
-		"else setenv getcmd tftp; setenv autoload no; fi\0"            \
-	"netboot=echo Booting from net ...; "                                  \
-		"run kernel_name; "                                            \
-		"run set_getcmd; "                                             \
-		"setenv bootargs; "                                            \
-		"run netargs; "                                                \
-		"if ${getcmd} ${kernel}; then "                                \
-			"if ${getcmd} ${fdt_addr} ${fdt_file}; then "          \
-				"${boot_type} ${loadaddr} - ${fdt_addr}; "     \
-			"fi; "                                                 \
-		"fi; "                                                         \
-		"echo ... failed\0"                                            \
-	"panicboot=echo No boot device !!! reset\0"                            \
-	TQMA6_EXTRA_BOOTDEV_ENV_SETTINGS                                      \
+/* 16MiB above TQMA6_FDT_ADDRESS (TQMA6_FDT_ADDRESS + SZ_16M) */
+#define TQMA6_INITRD_ADDRESS		0x19000000
 
 /* Physical Memory Map */
 #define PHYS_SDRAM			MMDC0_ARB_BASE_ADDR
@@ -252,6 +31,13 @@
 #define CFG_SYS_INIT_RAM_ADDR	IRAM_BASE_ADDR
 #define CFG_SYS_INIT_RAM_SIZE	IRAM_SIZE
 
+#define TQMA6_MMC_UBOOT_SECTOR_START	0x2
+#define TQMA6_MMC_UBOOT_SECTOR_COUNT	0x7fe
+
+#define TQMA6_SPI_FLASH_SECTOR_SIZE	SZ_64K
+#define TQMA6_SPI_UBOOT_START		0x400
+#define TQMA6_SPI_UBOOT_SIZE		0xc0000
+
 /*
  * All the defines above are for the TQMa6 SoM
  *
@@ -265,6 +51,4 @@
 #error "No baseboard for the TQMa6 defined!"
 #endif
 
-/* Support at least the sensor on TQMa6 SOM */
-
-#endif /* __CONFIG_H */
+#endif /* __TQMA6_CONFIG_H */
diff --git a/include/configs/tqma6_mba6.h b/include/configs/tqma6_mba6.h
index 9b9f4150951..81f96ac91e8 100644
--- a/include/configs/tqma6_mba6.h
+++ b/include/configs/tqma6_mba6.h
@@ -11,9 +11,6 @@
 #ifndef __CONFIG_TQMA6_MBA6_H
 #define __CONFIG_TQMA6_MBA6_H
 
-#define CFG_FEC_MXC_PHYADDR		0x03
-
 #define CFG_MXC_UART_BASE		UART2_BASE
-#define CONSOLE_DEV		"ttymxc1"
 
 #endif /* __CONFIG_TQMA6_MBA6_H */
-- 
2.43.0

