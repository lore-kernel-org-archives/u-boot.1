Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CF8C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 09:13:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60498887F3;
	Wed, 12 Jun 2024 11:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QZbzaJI7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0F6288791; Wed, 12 Jun 2024 11:11:48 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C67E88808
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 11:11:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45C9BcIv041728;
 Wed, 12 Jun 2024 04:11:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718183498;
 bh=MjtqJ7JijUMYwwU20XTpaSOUyGTRo/7UEwFXjg6xqyo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=QZbzaJI7Ogjoi2BUwsFnvGNDJHIBNpNa2k8ruxHd4W22EP/UHM8OFc3M6Hj1JuQWp
 GY5qcxwQSxDvoJiSHfqOVj2rBwTaHDqfAFKwLkLqw5FZ11oyjK1TEzI/7Rd9S7lZM0
 1kkkRJTobgFI7T1oTpGTsXmJH96QIOsBBWIMR/Fs=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45C9BcC4005134
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 12 Jun 2024 04:11:38 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 04:11:38 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 04:11:38 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com
 [172.24.227.55])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45C9BbxS062416;
 Wed, 12 Jun 2024 04:11:38 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <jh80.chung@samsung.com>,
 <lukma@denx.de>, <seanga2@gmail.com>, <vaishnav.a@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <sumit.garg@linaro.org>,
 <afd@ti.com>, <j-choudhary@ti.com>
CC: <vigneshr@ti.com>, <nm@ti.com>, <bb@ti.com>, <rogerq@kernel.org>
Subject: [PATCH v2 09/14] arch: mach-k3: Introduce basic files to support
 J722S SoC family
Date: Wed, 12 Jun 2024 14:41:18 +0530
Message-ID: <20240612091123.253835-10-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240612091123.253835-1-j-choudhary@ti.com>
References: <20240612091123.253835-1-j-choudhary@ti.com>
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

Introduce the basic functions and definitions needed to properly
initialize TI J722S family of SoCs.

Co-developed-by: Vaishnav Achath <vaishnav.a@ti.com>
Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm/mach-k3/Kconfig                      |   7 +-
 arch/arm/mach-k3/Makefile                     |   1 +
 arch/arm/mach-k3/include/mach/hardware.h      |   4 +
 .../arm/mach-k3/include/mach/j722s_hardware.h |  83 +++++
 arch/arm/mach-k3/include/mach/j722s_spl.h     |  49 +++
 arch/arm/mach-k3/include/mach/spl.h           |   4 +
 arch/arm/mach-k3/j722s/Kconfig                |  33 ++
 arch/arm/mach-k3/j722s/Makefile               |   7 +
 arch/arm/mach-k3/j722s/j722s_fdt.c            |  16 +
 arch/arm/mach-k3/j722s/j722s_init.c           | 287 ++++++++++++++++++
 10 files changed, 490 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-k3/include/mach/j722s_hardware.h
 create mode 100644 arch/arm/mach-k3/include/mach/j722s_spl.h
 create mode 100644 arch/arm/mach-k3/j722s/Kconfig
 create mode 100644 arch/arm/mach-k3/j722s/Makefile
 create mode 100644 arch/arm/mach-k3/j722s/j722s_fdt.c
 create mode 100644 arch/arm/mach-k3/j722s/j722s_init.c

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 2bb970c2d4..f3f42b3921 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -25,6 +25,9 @@ config SOC_K3_J721E
 config SOC_K3_J721S2
 	bool "TI's K3 based J721S2 SoC Family Support"
 
+config SOC_K3_J722S
+	bool "TI's K3 based J722S SoC Family Support"
+
 config SOC_K3_J784S4
 	bool "TI's K3 based J784S4 SoC Family Support"
 
@@ -84,6 +87,7 @@ config SYS_K3_BOOT_PARAM_TABLE_INDEX
 	default 0x43c3f290 if SOC_K3_AM62A7 && CPU_V7R
 	default 0x7000f290 if SOC_K3_AM62A7 && ARM64
 	default 0x43c4f290 if SOC_K3_AM62P5
+	default 0x43c7f290 if SOC_K3_J722S
 	help
 	  Address at which ROM stores the value which determines if SPL
 	  is booted up by primary boot media or secondary boot media.
@@ -122,7 +126,7 @@ config K3_EARLY_CONS_IDX
 
 config K3_ATF_LOAD_ADDR
 	hex "Load address of ATF image"
-	default 0x80000000 if (SOC_K3_AM625 || SOC_K3_AM62A7 || SOC_K3_AM62P5)
+	default 0x80000000 if (SOC_K3_AM625 || SOC_K3_AM62A7 || SOC_K3_AM62P5 || SOC_K3_J722S)
 	default 0x70000000
 	help
 	  The load address for the ATF image. This value is used to build the
@@ -163,6 +167,7 @@ source "arch/arm/mach-k3/am62ax/Kconfig"
 source "arch/arm/mach-k3/am62px/Kconfig"
 source "arch/arm/mach-k3/j721e/Kconfig"
 source "arch/arm/mach-k3/j721s2/Kconfig"
+source "arch/arm/mach-k3/j722s/Kconfig"
 source "arch/arm/mach-k3/j784s4/Kconfig"
 
 endif
diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
index 2b3ebd5c53..8c4f6786a5 100644
--- a/arch/arm/mach-k3/Makefile
+++ b/arch/arm/mach-k3/Makefile
@@ -14,4 +14,5 @@ obj-$(CONFIG_SOC_K3_AM642) += am64x/
 obj-$(CONFIG_SOC_K3_AM654) += am65x/
 obj-$(CONFIG_SOC_K3_J721E) += j721e/
 obj-$(CONFIG_SOC_K3_J721S2) += j721s2/
+obj-$(CONFIG_SOC_K3_J722S) += j722s/
 obj-$(CONFIG_SOC_K3_J784S4) += j784s4/
diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index 1024ee6872..b191d53a0f 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -36,6 +36,10 @@
 #include "j721s2_hardware.h"
 #endif
 
+#ifdef CONFIG_SOC_K3_J722S
+#include "j722s_hardware.h"
+#endif
+
 #ifdef CONFIG_SOC_K3_J784S4
 #include "j784s4_hardware.h"
 #endif
diff --git a/arch/arm/mach-k3/include/mach/j722s_hardware.h b/arch/arm/mach-k3/include/mach/j722s_hardware.h
new file mode 100644
index 0000000000..8d0bec2206
--- /dev/null
+++ b/arch/arm/mach-k3/include/mach/j722s_hardware.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * K3: J722S SoC definitions, structures etc.
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef __ASM_ARCH_J722S_HARDWARE_H
+#define __ASM_ARCH_J722S_HARDWARE_H
+
+#include <config.h>
+#ifndef __ASSEMBLY__
+#include <linux/bitops.h>
+#endif
+
+#define PADCFG_MMR0_BASE			0x04080000
+#define PADCFG_MMR1_BASE			0x000f0000
+#define CTRL_MMR0_BASE				0x00100000
+#define MCU_CTRL_MMR0_BASE			0x04500000
+#define WKUP_CTRL_MMR0_BASE			0x43000000
+
+#define CTRLMMR_MAIN_DEVSTAT			(WKUP_CTRL_MMR0_BASE + 0x30)
+#define MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK	GENMASK(6, 3)
+#define MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT	3
+#define MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK	GENMASK(9, 7)
+#define MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT	7
+#define MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK	GENMASK(12, 10)
+#define MAIN_DEVSTAT_BACKUP_BOOTMODE_SHIFT	10
+#define MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK	BIT(13)
+#define MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT	13
+
+/* Primary Bootmode MMC Config macros */
+#define MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK	0x4
+#define MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT	2
+#define MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK	0x1
+#define MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_SHIFT	0
+
+/* Primary Bootmode USB Config macros */
+#define MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT	1
+#define MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK	0x02
+
+/* Backup Bootmode USB Config macros */
+#define MAIN_DEVSTAT_BACKUP_USB_MODE_MASK	0x01
+
+/*
+ * The CTRL_MMR0 memory space is divided into several equally-spaced
+ * partitions, so defining the partition size allows us to determine
+ * register addresses common to those partitions.
+ */
+#define CTRL_MMR0_PARTITION_SIZE		0x4000
+
+/*
+ * CTRL_MMR0, WKUP_CTRL_MMR0, and MCU_CTRL_MMR0 lock/kick-mechanism
+ * shared register definitions. The same registers are also used for
+ * PADCFG_MMR lock/kick-mechanism.
+ */
+#define CTRLMMR_LOCK_KICK0			0x1008
+#define CTRLMMR_LOCK_KICK0_UNLOCK_VAL		0x68ef3490
+#define CTRLMMR_LOCK_KICK1			0x100c
+#define CTRLMMR_LOCK_KICK1_UNLOCK_VAL		0xd172bc5a
+
+#define MCU_CTRL_LFXOSC_CTRL			(MCU_CTRL_MMR0_BASE + 0x8038)
+#define MCU_CTRL_LFXOSC_TRIM			(MCU_CTRL_MMR0_BASE + 0x803c)
+#define MCU_CTRL_LFXOSC_32K_DISABLE_VAL		BIT(7)
+
+#define MCU_CTRL_DEVICE_CLKOUT_32K_CTRL		(MCU_CTRL_MMR0_BASE + 0x8058)
+#define MCU_CTRL_DEVICE_CLKOUT_LFOSC_SELECT_VAL	(0x3)
+
+#define ROM_EXTENDED_BOOT_DATA_INFO		0x43c7f1e0
+
+#define K3_BOOT_PARAM_TABLE_INDEX_OCRAM		0x7000F290
+
+#define TI_SRAM_SCRATCH_BOARD_EEPROM_START	0x43c30000
+
+#if defined(CONFIG_SYS_K3_SPL_ATF) && !defined(__ASSEMBLY__)
+
+static const u32 put_device_ids[] = {};
+
+static const u32 put_core_ids[] = {};
+
+#endif
+
+#endif /* __ASM_ARCH_J722S_HARDWARE_H */
diff --git a/arch/arm/mach-k3/include/mach/j722s_spl.h b/arch/arm/mach-k3/include/mach/j722s_spl.h
new file mode 100644
index 0000000000..eab8c511b7
--- /dev/null
+++ b/arch/arm/mach-k3/include/mach/j722s_spl.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef _ASM_ARCH_J722S_SPL_H_
+#define _ASM_ARCH_J722S_SPL_H_
+
+/* Primary BootMode devices */
+#define BOOT_DEVICE_SPI_NAND		0x00
+#define BOOT_DEVICE_RAM			0xFF
+#define BOOT_DEVICE_OSPI		0x01
+#define BOOT_DEVICE_QSPI		0x02
+#define BOOT_DEVICE_SPI			0x03
+#define BOOT_DEVICE_CPGMAC		0x04
+#define BOOT_DEVICE_ETHERNET_RGMII	0x04
+#define BOOT_DEVICE_ETHERNET_RMII	0x05
+#define BOOT_DEVICE_I2C			0x06
+#define BOOT_DEVICE_UART		0x07
+#define BOOT_DEVICE_MMC			0x08
+#define BOOT_DEVICE_EMMC		0x09
+
+#define BOOT_DEVICE_USB			0x2A
+#define BOOT_DEVICE_DFU			0x0A
+#define BOOT_DEVICE_GPMC_NAND		0x0B
+#define BOOT_DEVICE_GPMC_NOR		0x0C
+#define BOOT_DEVICE_XSPI		0x0E
+#define BOOT_DEVICE_NOBOOT		0x0F
+
+/* U-Boot used aliases */
+#define BOOT_DEVICE_ETHERNET		0x04
+#define BOOT_DEVICE_SPINAND		0x10
+#define BOOT_DEVICE_MMC2		0x08
+#define BOOT_DEVICE_MMC1		0x09
+/* Invalid */
+#define BOOT_DEVICE_MMC2_2		0x1F
+
+/* Backup BootMode devices */
+#define BACKUP_BOOT_DEVICE_DFU		0x01
+#define BACKUP_BOOT_DEVICE_UART		0x03
+#define BACKUP_BOOT_DEVICE_ETHERNET	0x04
+#define BACKUP_BOOT_DEVICE_MMC		0x05
+#define BACKUP_BOOT_DEVICE_SPI		0x06
+#define BACKUP_BOOT_DEVICE_I2C		0x07
+#define BACKUP_BOOT_DEVICE_USB		0x09
+
+#define K3_PRIMARY_BOOTMODE		0x0
+
+#endif /* _ASM_ARCH_J722S_SPL_H_ */
diff --git a/arch/arm/mach-k3/include/mach/spl.h b/arch/arm/mach-k3/include/mach/spl.h
index 8394277922..ac1a34502e 100644
--- a/arch/arm/mach-k3/include/mach/spl.h
+++ b/arch/arm/mach-k3/include/mach/spl.h
@@ -38,4 +38,8 @@
 #include "am62p_spl.h"
 #endif
 
+#ifdef CONFIG_SOC_K3_J722S
+#include "j722s_spl.h"
+#endif
+
 #endif /* _ASM_ARCH_SPL_H_ */
diff --git a/arch/arm/mach-k3/j722s/Kconfig b/arch/arm/mach-k3/j722s/Kconfig
new file mode 100644
index 0000000000..39d38ea5cf
--- /dev/null
+++ b/arch/arm/mach-k3/j722s/Kconfig
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+#
+
+if SOC_K3_J722S
+
+choice
+	prompt "TI K3 J722S based boards"
+	optional
+
+config TARGET_J722S_A53_EVM
+	bool "TI K3 based J722S EVM running on A53"
+	select ARM64
+	select BINMAN
+	select OF_SYSTEM_SETUP
+
+config TARGET_J722S_R5_EVM
+	bool "TI K3 based J722S EVM running on R5"
+	select CPU_V7R
+	select SYS_THUMB_BUILD
+	select K3_LOAD_SYSFW
+	select RAM
+	select SPL_RAM
+	select K3_DDRSS
+	select BINMAN
+	imply SYS_K3_SPL_ATF
+
+endchoice
+
+source "board/ti/j722s/Kconfig"
+
+endif
diff --git a/arch/arm/mach-k3/j722s/Makefile b/arch/arm/mach-k3/j722s/Makefile
new file mode 100644
index 0000000000..2b1fec131e
--- /dev/null
+++ b/arch/arm/mach-k3/j722s/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+#	Jayesh Choudhary <j-choudhary@ti.com>
+
+obj-$(CONFIG_OF_SYSTEM_SETUP) += j722s_fdt.o
+obj-$(CONFIG_SPL_BUILD) += j722s_init.o
diff --git a/arch/arm/mach-k3/j722s/j722s_fdt.c b/arch/arm/mach-k3/j722s/j722s_fdt.c
new file mode 100644
index 0000000000..29c832d28a
--- /dev/null
+++ b/arch/arm/mach-k3/j722s/j722s_fdt.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <asm/hardware.h>
+#include "../common_fdt.h"
+#include <fdt_support.h>
+
+int ft_system_setup(void *blob, struct bd_info *bd)
+{
+	fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
+	fdt_fixup_reserved(blob, "optee", CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
+
+	return 0;
+}
diff --git a/arch/arm/mach-k3/j722s/j722s_init.c b/arch/arm/mach-k3/j722s/j722s_init.c
new file mode 100644
index 0000000000..01b00681f6
--- /dev/null
+++ b/arch/arm/mach-k3/j722s/j722s_init.c
@@ -0,0 +1,287 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * J722S: SoC specific initialization
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <spl.h>
+#include <asm/io.h>
+#include <asm/arch/hardware.h>
+#include <dm.h>
+#include <dm/uclass-internal.h>
+#include <dm/pinctrl.h>
+
+#include "../sysfw-loader.h"
+#include "../common.h"
+
+struct fwl_data cbass_main_fwls[] = {
+	{ "FSS_DAT_REG3", 7, 8 },
+};
+
+/*
+ * This uninitialized global variable would normal end up in the .bss section,
+ * but the .bss is cleared between writing and reading this variable, so move
+ * it to the .data section.
+ */
+u32 bootindex __section(".data");
+static struct rom_extended_boot_data bootdata __section(".data");
+
+static void store_boot_info_from_rom(void)
+{
+	bootindex = *(u32 *)(CONFIG_SYS_K3_BOOT_PARAM_TABLE_INDEX);
+	memcpy(&bootdata, (uintptr_t *)ROM_EXTENDED_BOOT_DATA_INFO,
+	       sizeof(struct rom_extended_boot_data));
+}
+
+static void ctrl_mmr_unlock(void)
+{
+	/* Unlock all WKUP_CTRL_MMR0 module registers */
+	mmr_unlock(WKUP_CTRL_MMR0_BASE, 0);
+	mmr_unlock(WKUP_CTRL_MMR0_BASE, 1);
+	mmr_unlock(WKUP_CTRL_MMR0_BASE, 2);
+	mmr_unlock(WKUP_CTRL_MMR0_BASE, 3);
+	mmr_unlock(WKUP_CTRL_MMR0_BASE, 4);
+	mmr_unlock(WKUP_CTRL_MMR0_BASE, 5);
+	mmr_unlock(WKUP_CTRL_MMR0_BASE, 6);
+	mmr_unlock(WKUP_CTRL_MMR0_BASE, 7);
+
+	/* Unlock all CTRL_MMR0 module registers */
+	mmr_unlock(CTRL_MMR0_BASE, 0);
+	mmr_unlock(CTRL_MMR0_BASE, 1);
+	mmr_unlock(CTRL_MMR0_BASE, 2);
+	mmr_unlock(CTRL_MMR0_BASE, 4);
+	mmr_unlock(CTRL_MMR0_BASE, 5);
+	mmr_unlock(CTRL_MMR0_BASE, 6);
+
+	/* Unlock all MCU_CTRL_MMR0 module registers */
+	mmr_unlock(MCU_CTRL_MMR0_BASE, 0);
+	mmr_unlock(MCU_CTRL_MMR0_BASE, 1);
+	mmr_unlock(MCU_CTRL_MMR0_BASE, 2);
+	mmr_unlock(MCU_CTRL_MMR0_BASE, 3);
+	mmr_unlock(MCU_CTRL_MMR0_BASE, 4);
+	mmr_unlock(MCU_CTRL_MMR0_BASE, 6);
+
+	/* Unlock PADCFG_CTRL_MMR padconf registers */
+	mmr_unlock(PADCFG_MMR0_BASE, 1);
+	mmr_unlock(PADCFG_MMR1_BASE, 1);
+}
+
+static void k3_spl_init(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	if (IS_ENABLED(CONFIG_CPU_V7R))
+		setup_k3_mpu_regions();
+
+	/*
+	 * Cannot delay this further as there is a chance that
+	 * K3_BOOT_PARAM_TABLE_INDEX can be over written by SPL MALLOC section.
+	 */
+	store_boot_info_from_rom();
+
+	ctrl_mmr_unlock();
+
+	/* Init DM early */
+	ret = spl_early_init();
+	if (ret)
+		panic("spl_early_init() failed: %d\n", ret);
+
+	/*
+	 * Process pinctrl for the serial0 a.k.a. WKUP_UART0 module and continue
+	 * regardless of the result of pinctrl. Do this without probing the
+	 * device, but instead by searching the device that would request the
+	 * given sequence number if probed. The UART will be used by the DM
+	 * firmware image for various purposes and TIFS depends on us to
+	 * initialize its pin settings.
+	 */
+	ret = uclass_find_device_by_seq(UCLASS_SERIAL, 0, &dev);
+	if (!ret)
+		pinctrl_select_state(dev, "default");
+
+	if (IS_ENABLED(CONFIG_K3_EARLY_CONS)) {
+		/*
+		 * Allow establishing an early console as required for example
+		 * when doing a UART-based boot. Note that this console may not
+		 * "survive" through a SYSFW PM-init step and will need a re-init
+		 * in some way due to changing module clock frequencies.
+		 */
+		ret = early_console_init();
+		if (ret)
+			panic("early_console_init() failed: %d\n", ret);
+	}
+
+	if (IS_ENABLED(CONFIG_K3_LOAD_SYSFW)) {
+		/*
+		 * Configure and start up system controller firmware. Provide
+		 * the U-Boot console init function to the SYSFW post-PM
+		 * configuration callback hook, effectively switching on (or
+		 * over) the console output.
+		 */
+		ret = is_rom_loaded_sysfw(&bootdata);
+		if (!ret)
+			panic("ROM has not loaded TIFS firmware\n");
+
+		k3_sysfw_loader(true, NULL, NULL);
+	}
+
+	/*
+	 * Force probe of clk_k3 driver here to ensure basic default clock
+	 * configuration is always done.
+	 */
+	if (IS_ENABLED(CONFIG_SPL_CLK_K3)) {
+		ret = uclass_get_device_by_driver(UCLASS_CLK,
+						  DM_DRIVER_GET(ti_clk),
+						  &dev);
+		if (ret)
+			printf("Failed to initialize clk-k3!\n");
+	}
+
+	preloader_console_init();
+
+	if (IS_ENABLED(CONFIG_CPU_V7R)) {
+		/* Disable ROM configured firewalls right after loading sysfw */
+		remove_fwl_configs(cbass_main_fwls, ARRAY_SIZE(cbass_main_fwls));
+	}
+
+	/* Output System Firmware version info */
+	k3_sysfw_print_ver();
+}
+
+static void k3_mem_init(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	if (IS_ENABLED(CONFIG_K3_AM62A_DDRSS)) {
+		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
+		if (ret)
+			panic("DRAM init failed: %d\n", ret);
+	}
+}
+
+void board_init_f(ulong dummy)
+{
+	k3_spl_init();
+	k3_mem_init();
+}
+
+static u32 __get_backup_bootmedia(u32 devstat)
+{
+	u32 bkup_bootmode = (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK) >>
+				MAIN_DEVSTAT_BACKUP_BOOTMODE_SHIFT;
+	u32 bkup_bootmode_cfg =
+			(devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK) >>
+				MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT;
+
+	switch (bkup_bootmode) {
+	case BACKUP_BOOT_DEVICE_UART:
+		return BOOT_DEVICE_UART;
+
+	case BACKUP_BOOT_DEVICE_USB:
+		return BOOT_DEVICE_USB;
+
+	case BACKUP_BOOT_DEVICE_ETHERNET:
+		return BOOT_DEVICE_ETHERNET;
+
+	case BACKUP_BOOT_DEVICE_MMC:
+		if (bkup_bootmode_cfg)
+			return BOOT_DEVICE_MMC2;
+		return BOOT_DEVICE_MMC1;
+
+	case BACKUP_BOOT_DEVICE_SPI:
+		return BOOT_DEVICE_SPI;
+
+	case BACKUP_BOOT_DEVICE_I2C:
+		return BOOT_DEVICE_I2C;
+
+	case BACKUP_BOOT_DEVICE_DFU:
+		if (bkup_bootmode_cfg & MAIN_DEVSTAT_BACKUP_USB_MODE_MASK)
+			return BOOT_DEVICE_USB;
+		return BOOT_DEVICE_DFU;
+	};
+
+	return BOOT_DEVICE_RAM;
+}
+
+static u32 __get_primary_bootmedia(u32 devstat)
+{
+	u32 bootmode = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
+				MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
+	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
+				MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
+
+	switch (bootmode) {
+	case BOOT_DEVICE_OSPI:
+		fallthrough;
+	case BOOT_DEVICE_QSPI:
+		fallthrough;
+	case BOOT_DEVICE_XSPI:
+		fallthrough;
+	case BOOT_DEVICE_SPI:
+		return BOOT_DEVICE_SPI;
+
+	case BOOT_DEVICE_ETHERNET_RGMII:
+		fallthrough;
+	case BOOT_DEVICE_ETHERNET_RMII:
+		return BOOT_DEVICE_ETHERNET;
+
+	case BOOT_DEVICE_EMMC:
+		return BOOT_DEVICE_MMC1;
+
+	case BOOT_DEVICE_SPI_NAND:
+		return BOOT_DEVICE_SPINAND;
+
+	case BOOT_DEVICE_MMC:
+		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK) >>
+				MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT)
+			return BOOT_DEVICE_MMC2;
+		return BOOT_DEVICE_MMC1;
+
+	case BOOT_DEVICE_DFU:
+		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK) >>
+		    MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT)
+			return BOOT_DEVICE_USB;
+		return BOOT_DEVICE_DFU;
+
+	case BOOT_DEVICE_NOBOOT:
+		return BOOT_DEVICE_RAM;
+	}
+
+	return bootmode;
+}
+
+u32 spl_boot_device(void)
+{
+	u32 devstat = readl(CTRLMMR_MAIN_DEVSTAT);
+	u32 bootmedia;
+
+	if (bootindex == K3_PRIMARY_BOOTMODE)
+		bootmedia = __get_primary_bootmedia(devstat);
+	else
+		bootmedia = __get_backup_bootmedia(devstat);
+
+	debug("j722s_init: %s: devstat = 0x%x bootmedia = 0x%x bootindex = %d\n",
+	      __func__, devstat, bootmedia, bootindex);
+	return bootmedia;
+}
+
+u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
+{
+	u32 devstat = readl(CTRLMMR_MAIN_DEVSTAT);
+	u32 bootmode = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
+				MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
+	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
+			    MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
+
+	switch (bootmode) {
+	case BOOT_DEVICE_EMMC:
+		return MMCSD_MODE_EMMCBOOT;
+	case BOOT_DEVICE_MMC:
+		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
+			return MMCSD_MODE_RAW;
+	default:
+		return MMCSD_MODE_FS;
+	}
+}
-- 
2.25.1

