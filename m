Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD61C47258
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 03:09:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E143787D20;
	Thu,  1 Feb 2024 04:07:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xz6UWtp0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9FAD87D0A; Thu,  1 Feb 2024 04:06:57 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AACE987C56
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 04:06:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41136bWp082257;
 Wed, 31 Jan 2024 21:06:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706756797;
 bh=WSQQBLcOO/okrb3iI8KDXQ/uw/rr+ivJRbfbPpxI0SE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=xz6UWtp0p7Kamo8P7aM90JCtTnArCLMslNR0dZ7Hk94Tv7kKpxhiO8aXR+ScxEfyH
 3R6RfzwrxwZdpdE6kada0Q7G5HynAk6WV6leu0A/aonABHYfeWLnwT6onBA5nlT33Z
 v8se/GLC3BXKHV2PXUOjiob+IvfX7S3MDunHmVVc=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41136bT8124157
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 31 Jan 2024 21:06:37 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 21:06:37 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 21:06:37 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41136bdA098200;
 Wed, 31 Jan 2024 21:06:37 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Hari
 Nagalla <hnagalla@ti.com>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Nishanth Menon <nm@ti.com>,
 Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 UBoot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 06/13] arch: mach-k3: introduce basic files to support the
 am62px SoC family
Date: Wed, 31 Jan 2024 21:06:42 -0600
Message-ID: <20240201030634.1120963-23-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201030634.1120963-16-bb@ti.com>
References: <20240201030634.1120963-16-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17148; i=bb@ti.com;
 h=from:subject; bh=rLb6N1Pk1HAxuTeovdppNGd/4aBi4XSAaQmUd2uduUU=;
 b=owNCWmg5MUFZJlNZVbvorwAAbf////d//y/5XfuPy/1Otv/2/2v7b549nUrz6b46jtvk/dcwA
 Rti2OgANAAAANAGQAAGgDTygADIAyA0ekANDQDRo/VA2o9Q9J5R5QabUPUep6iDIaDQAGh6QAAG
 I0NME0AZADED1GAjQMQ0YJiaA0ZAAAAeU09QyYnqDFDaTQaDEaaBoGQ0aGmmTIaNAaDQeoAaMmg
 MjCGJiNNDI0aNDTI0NAANDTIaGggQcirZiJTfAUdgCxjYsSEuiP4sVOogW9sJIaAtP9oHTCRdcG
 GTJIg57zB+04opZo3djGXPiXwDbsBmNM+VsOQjY++T5D1d7ONKjpBShCBINECrPqvGzYItQY74v
 Yg1MJowvRcxKx4JMLBL7WKfyZBlg/EBoOvpX2t8Tzta6ZMVuFhsbIHLxG721CtTLAhSC36sn040
 5kWZglkulChzo99Lro4nNI3s9gsVqj2/lRqFKT5OFSBhCgWqSYlE0NAzAb9w6E4evUOzNFBFTHU
 VYsl4iYZ0eikuARdBj/SMw+ByA/YK8ghXSpKHD3QLqpDYCQBZ93Z+cvGwgF/Ct9xb9ptZkJ/fm1
 Em2bUr2u7hlP5AIW6MtwcsV89SadMDTkT/A/sAwW0O6sgHkkFjctqGxgyhTkCAcxt5MTfY1CHnH
 nqkFL/i7kinChIKt30V4A==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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
initialize TI's am62p family of SoCs

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/mach-k3/Kconfig                      |   7 +-
 arch/arm/mach-k3/am62p5_init.c                | 280 ++++++++++++++++++
 arch/arm/mach-k3/am62px/Kconfig               |  32 ++
 .../arm/mach-k3/include/mach/am62p_hardware.h |  83 ++++++
 arch/arm/mach-k3/include/mach/am62p_spl.h     |  49 +++
 arch/arm/mach-k3/include/mach/hardware.h      |   4 +
 arch/arm/mach-k3/include/mach/spl.h           |   4 +
 7 files changed, 458 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-k3/am62p5_init.c
 create mode 100644 arch/arm/mach-k3/am62px/Kconfig
 create mode 100644 arch/arm/mach-k3/include/mach/am62p_hardware.h
 create mode 100644 arch/arm/mach-k3/include/mach/am62p_spl.h

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 0574e81075e6d..02a9c423ecdb8 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -22,6 +22,9 @@ config SOC_K3_AM625
 config SOC_K3_AM62A7
 	bool "TI's K3 based AM62A7 SoC Family Support"
 
+config SOC_K3_AM62P5
+	bool "TI's K3 based AM62P5 SoC Family Support"
+
 endchoice
 
 if SOC_K3_J721E
@@ -34,7 +37,7 @@ config SYS_SOC
 
 config SYS_K3_NON_SECURE_MSRAM_SIZE
 	hex
-	default 0x80000 if SOC_K3_AM654
+	default 0x80000 if SOC_K3_AM654 || SOC_K3_AM62P5
 	default 0x100000 if SOC_K3_J721E || SOC_K3_J721S2
 	default 0x1c0000 if SOC_K3_AM642
 	default 0x3c000 if SOC_K3_AM625 || SOC_K3_AM62A7
@@ -78,6 +81,7 @@ config SYS_K3_BOOT_PARAM_TABLE_INDEX
 	default 0x43c3f290 if SOC_K3_AM625
 	default 0x43c3f290 if SOC_K3_AM62A7 && CPU_V7R
 	default 0x7000f290 if SOC_K3_AM62A7 && ARM64
+	default 0x43c4f290 if SOC_K3_AM62P5
 	help
 	  Address at which ROM stores the value which determines if SPL
 	  is booted up by primary boot media or secondary boot media.
@@ -153,6 +157,7 @@ source "arch/arm/mach-k3/am65x/Kconfig"
 source "arch/arm/mach-k3/am64x/Kconfig"
 source "arch/arm/mach-k3/am62x/Kconfig"
 source "arch/arm/mach-k3/am62ax/Kconfig"
+source "arch/arm/mach-k3/am62px/Kconfig"
 source "arch/arm/mach-k3/j721e/Kconfig"
 source "arch/arm/mach-k3/j721s2/Kconfig"
 
diff --git a/arch/arm/mach-k3/am62p5_init.c b/arch/arm/mach-k3/am62p5_init.c
new file mode 100644
index 0000000000000..5b6795cc7d246
--- /dev/null
+++ b/arch/arm/mach-k3/am62p5_init.c
@@ -0,0 +1,280 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AM62P5: SoC specific initialization
+ *
+ * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <spl.h>
+#include <asm/io.h>
+#include <asm/arch/hardware.h>
+#include "sysfw-loader.h"
+#include "common.h"
+#include <dm.h>
+#include <dm/uclass-internal.h>
+#include <dm/pinctrl.h>
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
+void board_init_f(ulong dummy)
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
+	 * Process pinctrl for the serial0 and serial3, aka WKUP_UART0 and
+	 * MAIN_UART1 modules and continue regardless of the result of pinctrl.
+	 * Do this without probing the device, but instead by searching the
+	 * device that would request the given sequence number if probed. The
+	 * UARTs will be used by the DM firmware and TIFS firmware images
+	 * respectively and the firmware depend on SPL to initialize the pin
+	 * settings.
+	 */
+	ret = uclass_find_device_by_seq(UCLASS_SERIAL, 0, &dev);
+	if (!ret)
+		pinctrl_select_state(dev, "default");
+
+	ret = uclass_find_device_by_seq(UCLASS_SERIAL, 3, &dev);
+	if (!ret)
+		pinctrl_select_state(dev, "default");
+
+	/*
+	 * Allow establishing an early console as required for example when
+	 * doing a UART-based boot. Note that this console may not "survive"
+	 * through a SYSFW PM-init step and will need a re-init in some way
+	 * due to changing module clock frequencies.
+	 */
+	if (IS_ENABLED(CONFIG_K3_EARLY_CONS))
+		ret = early_console_init();
+		if (ret)
+			panic("early_console_init() failed: %d\n", ret);
+	}
+
+	/*
+	 * Configure and start up system controller firmware. Provide
+	 * the U-Boot console init function to the SYSFW post-PM configuration
+	 * callback hook, effectively switching on (or over) the console
+	 * output.
+	 */
+	if (IS_ENABLED(CONFIG_K3_LOAD_SYSFW) {
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
+	/* Output System Firmware version info */
+	k3_sysfw_print_ver();
+
+	/* Disable ROM configured firewalls right after loading sysfw */
+	remove_fwl_configs(cbass_main_fwls, ARRAY_SIZE(cbass_main_fwls));
+
+	if (IS_ENABLED(CONFIG_K3_AM62A_DDRSS)) {
+		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
+		if (ret)
+			panic("DRAM init failed: %d\n", ret);
+	}
+
+	spl_enable_cache();
+	debug("am62px_init: %s done\n", __func__);
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
+	debug("am62px_init: %s: devstat = 0x%x bootmedia = 0x%x bootindex = %d\n",
+	      __func__, devstat, bootmedia, bootindex);
+	return bootmedia;
+}
diff --git a/arch/arm/mach-k3/am62px/Kconfig b/arch/arm/mach-k3/am62px/Kconfig
new file mode 100644
index 0000000000000..38a9e6811b119
--- /dev/null
+++ b/arch/arm/mach-k3/am62px/Kconfig
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+#
+
+if SOC_K3_AM62P5
+
+choice
+	prompt "TI K3 AM62Px based boards"
+	optional
+
+config TARGET_AM62P5_A53_EVM
+	bool "TI K3 based AM62P5 EVM running on A53"
+	select ARM64
+	select BINMAN
+
+config TARGET_AM62P5_R5_EVM
+	bool "TI K3 based AM62P5 EVM running on R5"
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
+source "board/ti/am62px/Kconfig"
+
+endif
diff --git a/arch/arm/mach-k3/include/mach/am62p_hardware.h b/arch/arm/mach-k3/include/mach/am62p_hardware.h
new file mode 100644
index 0000000000000..923466c41f456
--- /dev/null
+++ b/arch/arm/mach-k3/include/mach/am62p_hardware.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * K3: AM62Px SoC definitions, structures etc.
+ *
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef __ASM_ARCH_AM62P_HARDWARE_H
+#define __ASM_ARCH_AM62P_HARDWARE_H
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
+#define ROM_EXTENDED_BOOT_DATA_INFO		0x43c4f1e0
+
+#define K3_BOOT_PARAM_TABLE_INDEX_OCRAM         0x7000F290
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
+#endif /* __ASM_ARCH_AM62P_HARDWARE_H */
diff --git a/arch/arm/mach-k3/include/mach/am62p_spl.h b/arch/arm/mach-k3/include/mach/am62p_spl.h
new file mode 100644
index 0000000000000..db145a7bc83ba
--- /dev/null
+++ b/arch/arm/mach-k3/include/mach/am62p_spl.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef _ASM_ARCH_AM62P_SPL_H_
+#define _ASM_ARCH_AM62P_SPL_H_
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
+#endif /* _ASM_ARCH_AM62P_SPL_H_ */
diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index 040288150b12f..c035386d0978c 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -33,6 +33,10 @@
 #include "am62a_qos.h"
 #endif
 
+#ifdef CONFIG_SOC_K3_AM62P5
+#include "am62p_hardware.h"
+#endif
+
 /* Assuming these addresses and definitions stay common across K3 devices */
 #define CTRLMMR_WKUP_JTAG_ID	(WKUP_CTRL_MMR0_BASE + 0x14)
 #define JTAG_ID_VARIANT_SHIFT	28
diff --git a/arch/arm/mach-k3/include/mach/spl.h b/arch/arm/mach-k3/include/mach/spl.h
index 3ddc7eb6b63c2..f3b77cdcbb59e 100644
--- a/arch/arm/mach-k3/include/mach/spl.h
+++ b/arch/arm/mach-k3/include/mach/spl.h
@@ -30,4 +30,8 @@
 #include "am62a_spl.h"
 #endif
 
+#ifdef CONFIG_SOC_K3_AM62P5
+#include "am62p_spl.h"
+#endif
+
 #endif /* _ASM_ARCH_SPL_H_ */
-- 
2.43.0

