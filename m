Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728B0C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 20:21:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ACB187F30;
	Tue, 12 Mar 2024 21:20:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="yNbYm2nd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F13F387F8A; Tue, 12 Mar 2024 21:20:43 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F381383348
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 21:20:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42CKKT7i004645;
 Tue, 12 Mar 2024 15:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1710274829;
 bh=Te//NQFPgnnGGXx6i39er9EOBE6l8fpGa61K2KyDkWI=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=yNbYm2ndMFlZhXX3YAYwWq09zRt5TWzJgZ1ICzFnCkCvjrk1taX/jN7xJK4zNjHNA
 2NVs/ewXgtkRQL3GHbSPq2aZ0TXbppocMOLPLTE4AsVTGiBlA4zRGizuj0Mk0iB2Ur
 kso7L2zDCsihLcyzNxeic55IvI+7FPnjYuyitBwo=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42CKKTDH086638
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Mar 2024 15:20:29 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Mar 2024 15:20:28 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Mar 2024 15:20:29 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42CKKSFT097256;
 Tue, 12 Mar 2024 15:20:28 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Tue, 12 Mar 2024 15:20:24 -0500
Subject: [PATCH v4 06/13] arch: mach-k3: introduce basic files to support
 the am62px SoC family
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240205-am62px-wip-rebasing-v4-6-fa772bfa623b@ti.com>
References: <20240205-am62px-wip-rebasing-v4-0-fa772bfa623b@ti.com>
In-Reply-To: <20240205-am62px-wip-rebasing-v4-0-fa772bfa623b@ti.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass
 <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>, Nishanth Menon
 <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew Davis
 <afd@ti.com>, Igor Opaniuk <igor.opaniuk@foundries.io>, Hari Nagalla
 <hnagalla@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>, Vaishnav Achath
 <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=17564; i=bb@ti.com;
 h=from:subject:message-id; bh=882TjxhUAiGgyOvbWjFG+OeZfNbJU/d7oj53rVKCJcc=;
 b=owNCWmg5MUFZJlNZtg/QMQAAYf///v/Jbvd9rd/0fzt0+ve/6bv3fr++3P+//Lv/3Dd8382wA
 Rmyh2oBoADagAA0AAyDRoAA0aNNA0GCADRoANGgGgGjQ0ZNHpGRoNGh6ENNppEDEwTQD0gyANA0
 0aA0BpoA00HqADINA9Q0BkGgDQ9QANMTIZBo00A0ZBpoGIhoeoPUDTQMgDQBoDIGQ000aNBoGjT
 EDTJoAAaAaGIDEGQ0DQyAwg0yDEaYgAB5Bq3i/d384+2kD7y5xyJBi5rfRuq1qODesPCuka9BMu
 TTKhLAIKpVXR9ct25YBlZTGqCpag2G6hQQnPBEKBglPdZ9KnK7ZYcaAJhyafeK1kcrPxlifRIym
 OWcJ0IR2zxr22r9chR9OIyuEa1owyGMSM2u7teESy8pAUsLaMClNNCl76nY9TckAHpJSKMkhNBJ
 n+pETuuYfIBqr9qtXA3ZZOYOImBdWGjgi6Bf5m+pQ4s1J9KEr7DpgJYgRDjXaSumCQoqH6hOlM9
 C0EYIUwQGKjxPFmfMQI/AQa4Ni0tFh64BcCa3xQL9ULiFtGTuM6wKnYeww9luB2I76Ooej332aH
 TVPR7MSoP0h/ZPszhgcsBkpMsGBtJ8gLzo5eIlKjSebRCADRWSEecBK/f17NE38MFiwdyvam/eO
 dN0BmIKKUamRv+LuSKcKEhbB+gYgA==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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
 arch/arm/mach-k3/Kconfig                       |   7 +-
 arch/arm/mach-k3/Makefile                      |   1 +
 arch/arm/mach-k3/am62p5_init.c                 | 281 +++++++++++++++++++++++++
 arch/arm/mach-k3/am62px/Kconfig                |  32 +++
 arch/arm/mach-k3/include/mach/am62p_hardware.h |  83 ++++++++
 arch/arm/mach-k3/include/mach/am62p_spl.h      |  49 +++++
 arch/arm/mach-k3/include/mach/hardware.h       |   4 +
 arch/arm/mach-k3/include/mach/spl.h            |   4 +
 8 files changed, 460 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 6a937ff96d208..2bb970c2d4c9b 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -10,6 +10,9 @@ config SOC_K3_AM625
 config SOC_K3_AM62A7
 	bool "TI's K3 based AM62A7 SoC Family Support"
 
+config SOC_K3_AM62P5
+	bool "TI's K3 based AM62P5 SoC Family Support"
+
 config SOC_K3_AM642
 	bool "TI's K3 based AM642 SoC Family Support"
 
@@ -80,6 +83,7 @@ config SYS_K3_BOOT_PARAM_TABLE_INDEX
 	default 0x43c3f290 if SOC_K3_AM625
 	default 0x43c3f290 if SOC_K3_AM62A7 && CPU_V7R
 	default 0x7000f290 if SOC_K3_AM62A7 && ARM64
+	default 0x43c4f290 if SOC_K3_AM62P5
 	help
 	  Address at which ROM stores the value which determines if SPL
 	  is booted up by primary boot media or secondary boot media.
@@ -118,7 +122,7 @@ config K3_EARLY_CONS_IDX
 
 config K3_ATF_LOAD_ADDR
 	hex "Load address of ATF image"
-	default 0x80000000 if (SOC_K3_AM625 || SOC_K3_AM62A7)
+	default 0x80000000 if (SOC_K3_AM625 || SOC_K3_AM62A7 || SOC_K3_AM62P5)
 	default 0x70000000
 	help
 	  The load address for the ATF image. This value is used to build the
@@ -156,6 +160,7 @@ source "arch/arm/mach-k3/am65x/Kconfig"
 source "arch/arm/mach-k3/am64x/Kconfig"
 source "arch/arm/mach-k3/am62x/Kconfig"
 source "arch/arm/mach-k3/am62ax/Kconfig"
+source "arch/arm/mach-k3/am62px/Kconfig"
 source "arch/arm/mach-k3/j721e/Kconfig"
 source "arch/arm/mach-k3/j721s2/Kconfig"
 source "arch/arm/mach-k3/j784s4/Kconfig"
diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
index 310a4c211404b..6ee9864c72cad 100644
--- a/arch/arm/mach-k3/Makefile
+++ b/arch/arm/mach-k3/Makefile
@@ -22,5 +22,6 @@ obj-$(CONFIG_SOC_K3_AM642) += am642_init.o
 obj-$(CONFIG_SOC_K3_AM625) += am625_init.o
 obj-$(CONFIG_SOC_K3_AM62A7) += am62a7_init.o
 obj-$(CONFIG_SOC_K3_J784S4) += j784s4_init.o
+obj-$(CONFIG_SOC_K3_AM62P5) += am62p5_init.o
 endif
 obj-y += common.o security.o
diff --git a/arch/arm/mach-k3/am62p5_init.c b/arch/arm/mach-k3/am62p5_init.c
new file mode 100644
index 0000000000000..aab99aa0c958f
--- /dev/null
+++ b/arch/arm/mach-k3/am62p5_init.c
@@ -0,0 +1,281 @@
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
+	if (IS_ENABLED(CONFIG_K3_EARLY_CONS)) {
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
+	if (IS_ENABLED(CONFIG_K3_LOAD_SYSFW)) {
+		ret = is_rom_loaded_sysfw(&bootdata);
+		if (!ret)
+			panic("ROM has not loaded TIFS firmware\n");
+
+		k3_sysfw_loader(true, NULL, NULL);
+
+		/* Disable ROM configured firewalls */
+		remove_fwl_configs(cbass_main_fwls,
+				   ARRAY_SIZE(cbass_main_fwls));
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
index 224367d9f1adc..af982e70d171f 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -36,6 +36,10 @@
 #include "j784s4_hardware.h"
 #endif
 
+#ifdef CONFIG_SOC_K3_AM62P5
+#include "am62p_hardware.h"
+#endif
+
 /* Assuming these addresses and definitions stay common across K3 devices */
 #define CTRLMMR_WKUP_JTAG_ID	(WKUP_CTRL_MMR0_BASE + 0x14)
 #define JTAG_ID_VARIANT_SHIFT	28
diff --git a/arch/arm/mach-k3/include/mach/spl.h b/arch/arm/mach-k3/include/mach/spl.h
index 6f01ab58e27b4..8394277922532 100644
--- a/arch/arm/mach-k3/include/mach/spl.h
+++ b/arch/arm/mach-k3/include/mach/spl.h
@@ -34,4 +34,8 @@
 #include "j784s4_spl.h"
 #endif
 
+#ifdef CONFIG_SOC_K3_AM62P5
+#include "am62p_spl.h"
+#endif
+
 #endif /* _ASM_ARCH_SPL_H_ */

-- 
2.43.2

