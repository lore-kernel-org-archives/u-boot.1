Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F3ACDB474
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 23:29:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD4E386ED4;
	Fri, 13 Oct 2023 01:14:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PY9La4+R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6A1186E0E; Fri, 13 Oct 2023 01:08:23 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C60D86E88
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 01:06:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39CN6JvJ034162;
 Thu, 12 Oct 2023 18:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697151979;
 bh=tuleTQwcwc2gxe5soUtFzeJCq1/G9C1hCUUcBQp58Ss=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=PY9La4+Rlhv93x2GM3nXG4dwTDGeEl3yFOctQnm9yfUa28Z91Eee65NR2AnawPSGC
 PmJaLbIYc2vvH9S+AfNbkyULTBAg1BaF9lazxu4UvCpKgppcsDGw9BRz0hkiucc2p+
 WyLGhIaqRmyJ1IZdNvYzyMYh7xHpW/k/6TmVdDf4=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39CN6JX5062790
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 12 Oct 2023 18:06:19 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 12
 Oct 2023 18:06:18 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 12 Oct 2023 18:06:19 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39CN6IvF032224;
 Thu, 12 Oct 2023 18:06:18 -0500
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Hari
 Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 05/11] arch: mach-k3: introduce basic files to support the
 am62px SoC family
Date: Thu, 12 Oct 2023 18:06:22 -0500
Message-ID: <20231012230616.2101992-18-bb@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012230616.2101992-13-bb@ti.com>
References: <20231012230616.2101992-13-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=22779; i=bb@ti.com;
 h=from:subject; bh=RUYSooq5XYBOt0yBZ4lS5OwhX/Q2PH1+tE/7ZjFFWN4=;
 b=owNCWmg5MUFZJlNZnXnPzAAAbP///7ff/7/6rs3d19e1/36rvd1v/5/13PfPVy36393dnVawA
 RsYIeoNAAB6gA0aAAPSAAANAAANHqAGhoaGgNAAAaGjTRkBoPUGTanoaNJ5IdNMgaADQAaaNNA0
 APUNNBoABpkDQNAAGhkPUaAyAaBiAMnqMI0NDamh6h6htQdNNpGJkyDINB6gNDJkAyAGjTTQaaB
 kDJoABkAGQMjIxA0aAANNMgyNDRoaAAB0CiJ14wAHuIFjjvdJKBMYJVjIYYofxwT87AmEFyvVBV
 izINq18XbjVewIKOn2aHCOGMbRYwRibGhpOBCFit5Z8qhhBCWIx8KauQohy0TAIKmgCTd4rA6FS
 op694AVAdHgo0DwwQDcoDcsPY6vVMtDlw7y4RoOcfwfpleHvT+v05cqKXIMmqUyDn5xLczdeFgJ
 ZL7Fa1MnDNodBnGaguRHqU3YvRnRyjxAU+9Akcotr+M+ESUc8NyJRFtRCHpjviJRXbnYjB+zgfr
 kL/ZIOm8jkjCnfdUdpXZXi/WVKl0P9VrlgzrY/Bvzhz6w8BnhCGCCVLogTKRxbMUWtfhzCoUMLd
 T/h8yZCEakY3ER+rGQoIFgBNtIDFhgRwMAtIXkoOMBRzJaHCNMJKvgZcQlIU8Emy5pbUnsaQVlM
 U5YBcM3JfTq4f8XckU4UJCdec/M
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
 arch/arm/mach-k3/Kconfig                      |   6 +-
 arch/arm/mach-k3/Makefile                     |   2 +
 arch/arm/mach-k3/am62p5_init.c                | 261 ++++++++++++++++++
 arch/arm/mach-k3/am62px/clk-data.c            |  10 +
 arch/arm/mach-k3/am62px/dev-data.c            |  50 ++--
 arch/arm/mach-k3/arm64-mmu.c                  |   5 +-
 .../arm/mach-k3/include/mach/am62p_hardware.h |  83 ++++++
 arch/arm/mach-k3/include/mach/am62p_spl.h     |  49 ++++
 arch/arm/mach-k3/include/mach/hardware.h      |   4 +
 arch/arm/mach-k3/include/mach/spl.h           |   4 +
 10 files changed, 447 insertions(+), 27 deletions(-)
 create mode 100644 arch/arm/mach-k3/am62p5_init.c
 create mode 100644 arch/arm/mach-k3/include/mach/am62p_hardware.h
 create mode 100644 arch/arm/mach-k3/include/mach/am62p_spl.h

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 9a211871e04ef..5af567a24a2ba 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -22,6 +22,9 @@ config SOC_K3_AM625
 config SOC_K3_AM62A7
 	bool "TI's K3 based AM62A7 SoC Family Support"
 
+config SOC_K3_AM62P5
+	bool "TI's K3 based AM62P5 SoC Family Support"
+
 endchoice
 
 config SYS_SOC
@@ -29,7 +32,7 @@ config SYS_SOC
 
 config SYS_K3_NON_SECURE_MSRAM_SIZE
 	hex
-	default 0x80000 if SOC_K3_AM654
+	default 0x80000 if SOC_K3_AM654 || SOC_K3_AM62P5
 	default 0x100000 if SOC_K3_J721E || SOC_K3_J721S2
 	default 0x1c0000 if SOC_K3_AM642
 	default 0x3c000 if SOC_K3_AM625 || SOC_K3_AM62A7
@@ -73,6 +76,7 @@ config SYS_K3_BOOT_PARAM_TABLE_INDEX
 	default 0x43c3f290 if SOC_K3_AM625
 	default 0x43c3f290 if SOC_K3_AM62A7 && CPU_V7R
 	default 0x7000f290 if SOC_K3_AM62A7 && ARM64
+	default 0x43c4f290 if SOC_K3_AM62P5
 	help
 	  Address at which ROM stores the value which determines if SPL
 	  is booted up by primary boot media or secondary boot media.
diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
index fd77b8bbba5c9..f59e87b1ab776 100644
--- a/arch/arm/mach-k3/Makefile
+++ b/arch/arm/mach-k3/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_SOC_K3_J721E) += j721e/ j7200/
 obj-$(CONFIG_SOC_K3_J721S2) += j721s2/
 obj-$(CONFIG_SOC_K3_AM625) += am62x/
 obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
+obj-$(CONFIG_SOC_K3_AM62P5) += am62px/
 obj-$(CONFIG_ARM64) += arm64-mmu.o
 obj-$(CONFIG_CPU_V7R) += r5_mpu.o lowlevel_init.o
 obj-$(CONFIG_ARM64) += cache.o
@@ -24,6 +25,7 @@ obj-$(CONFIG_SOC_K3_J721S2) += j721s2_init.o
 obj-$(CONFIG_SOC_K3_AM642) += am642_init.o
 obj-$(CONFIG_SOC_K3_AM625) += am625_init.o
 obj-$(CONFIG_SOC_K3_AM62A7) += am62a7_init.o
+obj-$(CONFIG_SOC_K3_AM62P5) += am62p5_init.o
 obj-$(CONFIG_K3_LOAD_SYSFW) += sysfw-loader.o
 endif
 obj-y += common.o security.o
diff --git a/arch/arm/mach-k3/am62p5_init.c b/arch/arm/mach-k3/am62p5_init.c
new file mode 100644
index 0000000000000..b69ae6608a78d
--- /dev/null
+++ b/arch/arm/mach-k3/am62p5_init.c
@@ -0,0 +1,261 @@
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
+#if defined(CONFIG_CPU_V7R)
+	setup_k3_mpu_regions();
+#endif
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
+#ifdef CONFIG_K3_EARLY_CONS
+	/*
+	 * Allow establishing an early console as required for example when
+	 * doing a UART-based boot. Note that this console may not "survive"
+	 * through a SYSFW PM-init step and will need a re-init in some way
+	 * due to changing module clock frequencies.
+	 */
+	ret = early_console_init();
+	if (ret)
+		panic("early_console_init() failed: %d\n", ret);
+#endif
+
+#if defined(CONFIG_K3_LOAD_SYSFW)
+	/*
+	 * Configure and start up system controller firmware. Provide
+	 * the U-Boot console init function to the SYSFW post-PM configuration
+	 * callback hook, effectively switching on (or over) the console
+	 * output.
+	 */
+	ret = is_rom_loaded_sysfw(&bootdata);
+	if (!ret)
+		panic("ROM has not loaded TIFS firmware\n");
+
+	k3_sysfw_loader(true, NULL, NULL);
+#endif
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
+#if defined(CONFIG_K3_AM62A_DDRSS)
+	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
+	if (ret)
+		panic("DRAM init failed: %d\n", ret);
+#endif
+
+	debug("am62px_init: %s done\n", __func__);
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
diff --git a/arch/arm/mach-k3/am62px/clk-data.c b/arch/arm/mach-k3/am62px/clk-data.c
index 844e9bbbd6b16..4b9892fe05167 100644
--- a/arch/arm/mach-k3/am62px/clk-data.c
+++ b/arch/arm/mach-k3/am62px/clk-data.c
@@ -62,6 +62,11 @@ static const char * const clkout0_ctrl_out0_parents[] = {
 	"hsdiv4_16fft_main_2_hsdivout1_clk",
 };
 
+static const char * const main_emmcsd0_refclk_sel_out0_parents[] = {
+	"postdiv4_16ff_main_0_hsdivout5_clk",
+	"hsdiv4_16fft_main_2_hsdivout2_clk",
+};
+
 static const char * const main_emmcsd1_refclk_sel_out0_parents[] = {
 	"postdiv4_16ff_main_0_hsdivout5_clk",
 	"hsdiv4_16fft_main_2_hsdivout2_clk",
@@ -195,6 +200,7 @@ static const struct clk_data clk_list[] = {
 	CLK_MUX_PLLCTRL("sam62_pll_ctrl_wrap_mcu_0_sysclkout_clk", sam62_pll_ctrl_wrap_mcu_0_sysclkout_clk_parents, 2, 0x4020000, 0),
 	CLK_DIV("sam62_pll_ctrl_wrap_mcu_0_chip_div1_clk_clk", "sam62_pll_ctrl_wrap_mcu_0_sysclkout_clk", 0x4020118, 0, 5, 0, 0),
 	CLK_MUX("clkout0_ctrl_out0", clkout0_ctrl_out0_parents, 2, 0x108010, 0, 1, 0),
+	CLK_MUX("main_emmcsd0_refclk_sel_out0", main_emmcsd0_refclk_sel_out0_parents, 2, 0x108160, 0, 1, 0),
 	CLK_MUX("main_emmcsd1_refclk_sel_out0", main_emmcsd1_refclk_sel_out0_parents, 2, 0x108168, 0, 1, 0),
 	CLK_MUX("main_gtcclk_sel_out0", main_gtcclk_sel_out0_parents, 8, 0x43008030, 0, 3, 0),
 	CLK_MUX("main_ospi_ref_clk_sel_out0", main_ospi_ref_clk_sel_out0_parents, 2, 0x108500, 0, 1, 0),
@@ -233,6 +239,10 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(36, 10, "board_0_cp_gemac_cpts0_rft_clk_out"),
 	DEV_CLK(36, 11, "hsdiv4_16fft_main_1_hsdivout3_clk"),
 	DEV_CLK(36, 12, "postdiv4_16ff_main_2_hsdivout6_clk"),
+	DEV_CLK(57, 1, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(57, 2, "main_emmcsd0_refclk_sel_out0"),
+	DEV_CLK(57, 3, "postdiv4_16ff_main_0_hsdivout5_clk"),
+	DEV_CLK(57, 4, "hsdiv4_16fft_main_2_hsdivout2_clk"),
 	DEV_CLK(58, 0, "main_emmcsd1_io_clklb_sel_out0"),
 	DEV_CLK(58, 1, "board_0_mmc1_clklb_out"),
 	DEV_CLK(58, 2, "board_0_mmc1_clk_out"),
diff --git a/arch/arm/mach-k3/am62px/dev-data.c b/arch/arm/mach-k3/am62px/dev-data.c
index d06fb2ebf162f..3cc211ea20259 100644
--- a/arch/arm/mach-k3/am62px/dev-data.c
+++ b/arch/arm/mach-k3/am62px/dev-data.c
@@ -23,18 +23,19 @@ static struct ti_pd soc_pd_list[] = {
 
 static struct ti_lpsc soc_lpsc_list[] = {
 	[0] = PSC_LPSC(0, &soc_psc_list[0], &soc_pd_list[0], NULL),
-	[1] = PSC_LPSC(12, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[4]),
-	[2] = PSC_LPSC(13, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[5]),
-	[3] = PSC_LPSC(21, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[7]),
-	[4] = PSC_LPSC(23, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[7]),
-	[5] = PSC_LPSC(24, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[7]),
-	[6] = PSC_LPSC(28, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[7]),
-	[7] = PSC_LPSC(34, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[7]),
-	[8] = PSC_LPSC(53, &soc_psc_list[0], &soc_pd_list[1], &soc_lpsc_list[7]),
-	[9] = PSC_LPSC(56, &soc_psc_list[0], &soc_pd_list[2], &soc_lpsc_list[8]),
-	[10] = PSC_LPSC(72, &soc_psc_list[0], &soc_pd_list[3], &soc_lpsc_list[7]),
-	[11] = PSC_LPSC(73, &soc_psc_list[0], &soc_pd_list[3], &soc_lpsc_list[10]),
-	[12] = PSC_LPSC(74, &soc_psc_list[0], &soc_pd_list[3], &soc_lpsc_list[11]),
+	[1] = PSC_LPSC(12, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[5]),
+	[2] = PSC_LPSC(13, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[6]),
+	[3] = PSC_LPSC(20, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[8]),
+	[4] = PSC_LPSC(21, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[8]),
+	[5] = PSC_LPSC(23, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[8]),
+	[6] = PSC_LPSC(24, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[8]),
+	[7] = PSC_LPSC(28, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[8]),
+	[8] = PSC_LPSC(34, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[8]),
+	[9] = PSC_LPSC(53, &soc_psc_list[0], &soc_pd_list[1], &soc_lpsc_list[8]),
+	[10] = PSC_LPSC(56, &soc_psc_list[0], &soc_pd_list[2], &soc_lpsc_list[9]),
+	[11] = PSC_LPSC(72, &soc_psc_list[0], &soc_pd_list[3], &soc_lpsc_list[8]),
+	[12] = PSC_LPSC(73, &soc_psc_list[0], &soc_pd_list[3], &soc_lpsc_list[11]),
+	[13] = PSC_LPSC(74, &soc_psc_list[0], &soc_pd_list[3], &soc_lpsc_list[12]),
 };
 
 static struct ti_dev soc_dev_list[] = {
@@ -43,18 +44,19 @@ static struct ti_dev soc_dev_list[] = {
 	PSC_DEV(61, &soc_lpsc_list[0]),
 	PSC_DEV(178, &soc_lpsc_list[1]),
 	PSC_DEV(179, &soc_lpsc_list[2]),
-	PSC_DEV(58, &soc_lpsc_list[3]),
-	PSC_DEV(161, &soc_lpsc_list[4]),
-	PSC_DEV(162, &soc_lpsc_list[5]),
-	PSC_DEV(75, &soc_lpsc_list[6]),
-	PSC_DEV(36, &soc_lpsc_list[7]),
-	PSC_DEV(102, &soc_lpsc_list[7]),
-	PSC_DEV(146, &soc_lpsc_list[7]),
-	PSC_DEV(166, &soc_lpsc_list[8]),
-	PSC_DEV(135, &soc_lpsc_list[9]),
-	PSC_DEV(170, &soc_lpsc_list[10]),
-	PSC_DEV(177, &soc_lpsc_list[11]),
-	PSC_DEV(55, &soc_lpsc_list[12]),
+	PSC_DEV(57, &soc_lpsc_list[3]),
+	PSC_DEV(58, &soc_lpsc_list[4]),
+	PSC_DEV(161, &soc_lpsc_list[5]),
+	PSC_DEV(162, &soc_lpsc_list[6]),
+	PSC_DEV(75, &soc_lpsc_list[7]),
+	PSC_DEV(36, &soc_lpsc_list[8]),
+	PSC_DEV(102, &soc_lpsc_list[8]),
+	PSC_DEV(146, &soc_lpsc_list[8]),
+	PSC_DEV(166, &soc_lpsc_list[9]),
+	PSC_DEV(135, &soc_lpsc_list[10]),
+	PSC_DEV(170, &soc_lpsc_list[11]),
+	PSC_DEV(177, &soc_lpsc_list[12]),
+	PSC_DEV(55, &soc_lpsc_list[13]),
 };
 
 const struct ti_k3_pd_platdata am62px_pd_platdata = {
diff --git a/arch/arm/mach-k3/arm64-mmu.c b/arch/arm/mach-k3/arm64-mmu.c
index f8087d2421e7b..b453019d0445a 100644
--- a/arch/arm/mach-k3/arm64-mmu.c
+++ b/arch/arm/mach-k3/arm64-mmu.c
@@ -222,7 +222,8 @@ struct mm_region *mem_map = j721s2_mem_map;
 
 #endif /* CONFIG_SOC_K3_J721S2 */
 
-#if defined(CONFIG_SOC_K3_AM625) || defined(CONFIG_SOC_K3_AM62A7)
+#if defined(CONFIG_SOC_K3_AM625) || defined(CONFIG_SOC_K3_AM62A7) || \
+	defined(CONFIG_SOC_K3_AM62P5)
 
 /* NR_DRAM_BANKS + 32bit IO + 64bit IO + terminator */
 #define NR_MMU_REGIONS	(CONFIG_NR_DRAM_BANKS + 4)
@@ -269,7 +270,7 @@ struct mm_region am62_mem_map[NR_MMU_REGIONS] = {
 };
 
 struct mm_region *mem_map = am62_mem_map;
-#endif /* CONFIG_SOC_K3_AM625 || CONFIG_SOC_K3_AM62A7 */
+#endif /* CONFIG_SOC_K3_AM625 || CONFIG_SOC_K3_AM62A7 || CONFIG_SOC_K3_AM62P5 */
 
 #ifdef CONFIG_SOC_K3_AM642
 
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
index 85aa18918de9c..32a9e72d869ca 100644
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
index 356cd89210962..7a6cd0783cd41 100644
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
2.42.0

