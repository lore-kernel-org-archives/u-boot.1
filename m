Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19ABBC27C47
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 01:00:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BA0787200;
	Sat, 28 Oct 2023 02:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZGfYlUJY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1150087259; Sat, 28 Oct 2023 02:59:58 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94E28871DA
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 02:59:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7789a4c01ddso192474485a.1
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 17:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698454793; x=1699059593; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kCwa+cmd9mcljIgXqqsOAj94D7Ig8KAP3iNjpmiR9Vw=;
 b=ZGfYlUJYiISiY2p7xD0B0Zau2bYkFE9xEcoEGs9mBGDp1eS+GkWQcS9piaI/tTHm3X
 NnuaSx0sZjd6U3PsQAmeydVIb6S1Pl2WTvE7c1i9lyLcu0LX3OBCkauQJyixgFBu02yH
 0jADHE+x5eg3zveely8w6e2brg+X6SN05jERE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698454793; x=1699059593;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kCwa+cmd9mcljIgXqqsOAj94D7Ig8KAP3iNjpmiR9Vw=;
 b=sJF/wScmIyPon6yX+huAMedrZAKw3Fi3ZWDfXUgnMKC3lGtYy+W3z3njNGwWrD32b1
 DPlOupylW7o03M7R3+KMXb/Spyh72cak14A+q3KjjZ12qCr6Hu0xTMjPo1I23DgtoAf9
 WzZCIT8zei0CTZOuU2DAqn2K5ZLw9P+GRxS1F+sMQX1sK+fwWXJwudWfarXgbDCqfJ1B
 ze/5XfWwE8NWQ+vyg/6fODKn0R9kQAhsRv9bDeVgixCRyg2cWuJfYvwK0q1Nov8Kilyy
 2EdHI/LujypTi/m8d4VoJ3DerAOjGWigCvtiXyaAyuJTfZjCtKZUj3HnI+bGjLmJuWle
 PKvw==
X-Gm-Message-State: AOJu0YyGs9nh6lBZ1w4pgn2OVGEQMpLeuob6MJKrru9N6sIEQbrwnP34
 N8hZldd6Dkl1qCXB3gL2HfhAKzAFGHTIOH2uumK6BQ==
X-Google-Smtp-Source: AGHT+IHiLkAM7CFeTNGfrvNhnvMaLqiB6VLJ57SIobREoyqljSLRtUAaqPsMPt+/jnJjlvMqFfq1NQ==
X-Received: by 2002:a05:620a:4490:b0:77a:b62:a296 with SMTP id
 x16-20020a05620a449000b0077a0b62a296mr4984551qkp.3.1698454792821; 
 Fri, 27 Oct 2023 17:59:52 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6f2b-3a78-9e8e-d344.res6.spectrum.com.
 [2603:6081:7b00:6400:6f2b:3a78:9e8e:d344])
 by smtp.gmail.com with ESMTPSA id
 c22-20020a05620a0cf600b00765aa3ffa07sm1057350qkj.98.2023.10.27.17.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 17:59:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Mario Six <mario.six@gdsys.cc>, Andre Przywara <andre.przywara@arm.com>,
 Vladimir Oltean <olteanv@gmail.com>, Alison Wang <alison.wang@nxp.com>
Subject: [PATCH] scsi: Forceably finish migration to DM_SCSI
Date: Fri, 27 Oct 2023 20:59:51 -0400
Message-Id: <20231028005951.1187616-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

The migration deadline for moving to DM_SCSI was v2023.04. A further
reminder was sent out in August 2023 to the remaining platforms that had
not migrated already, and that a few more over the line (or configs
deleted).

With this commit we:
- Rename CONFIG_DM_SCSI to CONFIG_SCSI.
- Remove all of the non-DM SCSI code. This includes removing other
  legacy symbols and code and removes some legacy non-DM AHCI code.
- Some platforms that had previously been DM_SCSI=y && SCSI=n are now
  fully migrated to DM_SCSI as a few corner cases in the code assumed
  DM_SCSI=y meant SCSI=y.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
I'm cc'ing the maintainers of the last few platforms which did not yet
switch over and might need further updates or dts resyncs or something:
configs/controlcenterdc_defconfig
configs/highbank_defconfig
configs/ls1021atsn_qspi_defconfig
configs/ls1021atsn_sdcard_defconfig
configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig

Cc: Mario Six <mario.six@gdsys.cc> (maintainer:A38X BOARD)
Cc: Andre Przywara <andre.przywara@arm.com> (maintainer:HIGHBANK BOARD)
Cc: Vladimir Oltean <olteanv@gmail.com> (maintainer:NXP LS1021A-TSN Board)
Cc: Alison Wang <alison.wang@nxp.com> (maintainer:LS1021ATWR BOARD)
---
 Makefile                            |   1 -
 api/api_storage.c                   |   7 -
 arch/Kconfig                        |   2 +-
 arch/arm/Kconfig                    |   4 +-
 arch/arm/mach-imx/mx6/Kconfig       |   2 +-
 arch/arm/mach-mvebu/cpu.c           |   9 --
 arch/arm/mach-omap2/Makefile        |   7 -
 arch/arm/mach-omap2/boot-common.c   |   7 -
 arch/arm/mach-omap2/omap5/hw_data.c |  12 --
 arch/arm/mach-omap2/pipe3-phy.c     | 231 ----------------------------
 arch/arm/mach-omap2/pipe3-phy.h     |  35 -----
 arch/arm/mach-omap2/sata.c          |  72 ---------
 board/emulation/qemu-riscv/Kconfig  |   1 -
 board/highbank/highbank.c           |  13 --
 cmd/scsi.c                          |   3 -
 common/board_r.c                    |  15 --
 configs/apalis_imx6_defconfig       |   3 +-
 configs/dh_imx6_defconfig           |   3 +-
 configs/edison_defconfig            |   1 +
 configs/efi-x86_app32_defconfig     |   1 +
 configs/efi-x86_app64_defconfig     |   1 +
 configs/galileo_defconfig           |   1 +
 configs/mvebu_ac5_rd_defconfig      |   3 +-
 configs/novena_defconfig            |   1 +
 configs/udoo_defconfig              |   3 +-
 configs/wandboard_defconfig         |   3 +-
 configs/x240_defconfig              |   3 +-
 drivers/ata/Kconfig                 |  18 +--
 drivers/ata/Makefile                |   1 -
 drivers/ata/ahci.c                  | 172 +--------------------
 drivers/ata/sata.c                  |  58 -------
 drivers/ata/sata_sandbox.c          |  33 ----
 drivers/scsi/Kconfig                |  43 +-----
 drivers/scsi/Makefile               |  17 +-
 drivers/scsi/scsi.c                 | 151 ------------------
 drivers/ufs/Kconfig                 |   2 +-
 include/ahci.h                      |   3 -
 include/configs/ls1021aiot.h        |   7 -
 include/configs/ls1028ardb.h        |   5 -
 include/configs/ls1043ardb.h        |   7 -
 include/sata.h                      |  16 --
 include/scsi.h                      |   9 --
 42 files changed, 34 insertions(+), 952 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/pipe3-phy.c
 delete mode 100644 arch/arm/mach-omap2/pipe3-phy.h
 delete mode 100644 arch/arm/mach-omap2/sata.c
 delete mode 100644 drivers/ata/sata_sandbox.c

diff --git a/Makefile b/Makefile
index 8a04dfcf3638..a88cbe8c1185 100644
--- a/Makefile
+++ b/Makefile
@@ -1153,7 +1153,6 @@ endif
 	@# is enable to tell 'deprecated' that one of these symbols exists
 	$(call deprecated,CONFIG_TIMER,Timer drivers,v2023.01,$(if $(strip $(CFG_SYS_TIMER_RATE)$(CFG_SYS_TIMER_COUNTER)),x))
 	$(call deprecated,CONFIG_DM_SERIAL,Serial drivers,v2023.04,$(CONFIG_SERIAL))
-	$(call deprecated,CONFIG_DM_SCSI,SCSI drivers,v2023.04,$(CONFIG_SCSI))
 	@# Check that this build does not override OF_HAS_PRIOR_STAGE by
 	@# disabling OF_BOARD.
 	$(call cmd,ofcheck,$(KCONFIG_CONFIG))
diff --git a/api/api_storage.c b/api/api_storage.c
index 997e8727a965..78becbe39fb6 100644
--- a/api/api_storage.c
+++ b/api/api_storage.c
@@ -67,13 +67,6 @@ void dev_stor_init(void)
 	specs[ENUM_SATA].type = DEV_TYP_STOR | DT_STOR_SATA;
 	specs[ENUM_SATA].name = "sata";
 #endif
-#if defined(CONFIG_SCSI)
-	specs[ENUM_SCSI].max_dev = SCSI_MAX_DEVICE;
-	specs[ENUM_SCSI].enum_started = 0;
-	specs[ENUM_SCSI].enum_ended = 0;
-	specs[ENUM_SCSI].type = DEV_TYP_STOR | DT_STOR_SCSI;
-	specs[ENUM_SCSI].name = "scsi";
-#endif
 #if defined(CONFIG_CMD_USB) && defined(CONFIG_USB_STORAGE)
 	specs[ENUM_USB].max_dev = USB_MAX_STOR_DEV;
 	specs[ENUM_USB].enum_started = 0;
diff --git a/arch/Kconfig b/arch/Kconfig
index 4f5b75129f34..edd3ad09e54c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -248,7 +248,7 @@ config X86
 	imply DM_KEYBOARD
 	imply DM_MMC
 	imply DM_RTC
-	imply DM_SCSI
+	imply SCSI
 	imply DM_SERIAL
 	imply DM_SPI
 	imply DM_SPI_FLASH
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d812685c9842..6009b7d46dc9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1133,7 +1133,6 @@ config ARCH_SUNXI
 	select DM_SPI_FLASH if SPI
 	select DM_KEYBOARD
 	select DM_MMC if MMC
-	select DM_SCSI if SCSI
 	select DM_SERIAL
 	select OF_BOARD_SETUP
 	select OF_CONTROL
@@ -1838,7 +1837,7 @@ config TARGET_SL28
 	select PCI
 	select DM_RNG
 	select DM_RTC
-	select DM_SCSI
+	select SCSI
 	select DM_SERIAL
 	select DM_SPI
 	select GPIO_EXTRA_HEADER
@@ -2053,7 +2052,6 @@ config TARGET_POMELO
 	select PCI
 	select DM_PCI
 	select SCSI
-	select DM_SCSI
 	select DM_SERIAL
 	imply CMD_PCI
 	help
diff --git a/arch/arm/mach-imx/mx6/Kconfig b/arch/arm/mach-imx/mx6/Kconfig
index 7529b311f80e..50a9c3e4203d 100644
--- a/arch/arm/mach-imx/mx6/Kconfig
+++ b/arch/arm/mach-imx/mx6/Kconfig
@@ -246,7 +246,7 @@ config TARGET_KOSAGI_NOVENA
 	select DM_GPIO
 	select DM_MMC
 	select PCI
-	select DM_SCSI
+	select SCSI
 	select VIDEO
 	select OF_CONTROL
 	select SUPPORT_SPL
diff --git a/arch/arm/mach-mvebu/cpu.c b/arch/arm/mach-mvebu/cpu.c
index 6deffb818362..8e0de9353858 100644
--- a/arch/arm/mach-mvebu/cpu.c
+++ b/arch/arm/mach-mvebu/cpu.c
@@ -589,15 +589,6 @@ int board_ahci_enable(void)
 	return 0;
 }
 
-#ifdef CONFIG_SCSI_AHCI_PLAT
-void scsi_init(void)
-{
-	printf("MVEBU SATA INIT\n");
-	board_ahci_enable();
-	ahci_init((void __iomem *)MVEBU_SATA0_BASE);
-}
-#endif
-
 #ifdef CONFIG_USB_XHCI_MVEBU
 #define USB3_MAX_WINDOWS        4
 #define USB3_WIN_CTRL(w)        (0x0 + ((w) * 8))
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index bb01eab80e67..8c10c694dffb 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -27,13 +27,6 @@ obj-y	+= vc.o
 obj-y	+= abb.o
 endif
 
-ifneq ($(CONFIG_OMAP54XX),)
-ifeq ($(CONFIG_DM_SCSI),)
-obj-y	+= pipe3-phy.o
-obj-$(CONFIG_SCSI_AHCI_PLAT) += sata.o
-endif
-endif
-
 ifeq ($(CONFIG_$(SPL_TPL_)SYS_DCACHE_OFF),)
 obj-y	+= omap-cache.o
 endif
diff --git a/arch/arm/mach-omap2/boot-common.c b/arch/arm/mach-omap2/boot-common.c
index a2dd5f6df01e..5e4d29910c97 100644
--- a/arch/arm/mach-omap2/boot-common.c
+++ b/arch/arm/mach-omap2/boot-common.c
@@ -309,13 +309,6 @@ void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
 }
 #endif
 
-#ifdef CONFIG_SCSI_AHCI_PLAT
-void arch_preboot_os(void)
-{
-	ahci_reset((void __iomem *)DWC_AHSATA_BASE);
-}
-#endif
-
 #ifdef CONFIG_TI_SECURE_DEVICE
 void board_fit_image_post_process(const void *fit, int node, void **p_image,
 				  size_t *p_size)
diff --git a/arch/arm/mach-omap2/omap5/hw_data.c b/arch/arm/mach-omap2/omap5/hw_data.c
index e6bee48dfcb3..b39132222ee5 100644
--- a/arch/arm/mach-omap2/omap5/hw_data.c
+++ b/arch/arm/mach-omap2/omap5/hw_data.c
@@ -485,9 +485,6 @@ void enable_basic_clocks(void)
 		(*prcm)->cm_l4per_gpio6_clkctrl,
 		(*prcm)->cm_l4per_gpio7_clkctrl,
 		(*prcm)->cm_l4per_gpio8_clkctrl,
-#ifdef CONFIG_SCSI_AHCI_PLAT
-		(*prcm)->cm_l3init_ocp2scp3_clkctrl,
-#endif
 		0
 	};
 
@@ -506,9 +503,6 @@ void enable_basic_clocks(void)
 
 #ifdef CONFIG_TI_QSPI
 		(*prcm)->cm_l4per_qspi_clkctrl,
-#endif
-#ifdef CONFIG_SCSI_AHCI_PLAT
-		(*prcm)->cm_l3init_sata_clkctrl,
 #endif
 		0
 	};
@@ -542,12 +536,6 @@ void enable_basic_clocks(void)
 	setbits_le32((*prcm)->cm_l4per_qspi_clkctrl, (1<<24));
 #endif
 
-#ifdef CONFIG_SCSI_AHCI_PLAT
-	/* Enable optional functional clock for SATA */
-	setbits_le32((*prcm)->cm_l3init_sata_clkctrl,
-		     SATA_CLKCTRL_OPTFCLKEN_MASK);
-#endif
-
 	/* Enable SCRM OPT clocks for PER and CORE dpll */
 	setbits_le32((*prcm)->cm_wkupaon_scrm_clkctrl,
 			OPTFCLKEN_SCRM_PER_MASK);
diff --git a/arch/arm/mach-omap2/pipe3-phy.c b/arch/arm/mach-omap2/pipe3-phy.c
deleted file mode 100644
index 3dfb184c4308..000000000000
--- a/arch/arm/mach-omap2/pipe3-phy.c
+++ /dev/null
@@ -1,231 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * TI PIPE3 PHY
- *
- * (C) Copyright 2013
- * Texas Instruments, <www.ti.com>
- */
-
-#include <common.h>
-#include <sata.h>
-#include <asm/arch/clock.h>
-#include <asm/arch/sys_proto.h>
-#include <asm/io.h>
-#include <linux/bitops.h>
-#include <linux/delay.h>
-#include <linux/errno.h>
-#include "pipe3-phy.h"
-
-/* PLLCTRL Registers */
-#define PLL_STATUS              0x00000004
-#define PLL_GO                  0x00000008
-#define PLL_CONFIGURATION1      0x0000000C
-#define PLL_CONFIGURATION2      0x00000010
-#define PLL_CONFIGURATION3      0x00000014
-#define PLL_CONFIGURATION4      0x00000020
-
-#define PLL_REGM_MASK           0x001FFE00
-#define PLL_REGM_SHIFT          9
-#define PLL_REGM_F_MASK         0x0003FFFF
-#define PLL_REGM_F_SHIFT        0
-#define PLL_REGN_MASK           0x000001FE
-#define PLL_REGN_SHIFT          1
-#define PLL_SELFREQDCO_MASK     0x0000000E
-#define PLL_SELFREQDCO_SHIFT    1
-#define PLL_SD_MASK             0x0003FC00
-#define PLL_SD_SHIFT            10
-#define SET_PLL_GO              0x1
-#define PLL_TICOPWDN            BIT(16)
-#define PLL_LDOPWDN             BIT(15)
-#define PLL_LOCK                0x2
-#define PLL_IDLE                0x1
-
-/* PHY POWER CONTROL Register */
-#define OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_CMD_MASK         0x003FC000
-#define OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_CMD_SHIFT        0xE
-
-#define OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_FREQ_MASK        0xFFC00000
-#define OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_FREQ_SHIFT       0x16
-
-#define OMAP_CTRL_PIPE3_PHY_TX_RX_POWERON       0x3
-#define OMAP_CTRL_PIPE3_PHY_TX_RX_POWEROFF      0x0
-
-
-#define PLL_IDLE_TIME   100     /* in milliseconds */
-#define PLL_LOCK_TIME   100     /* in milliseconds */
-
-static inline u32 omap_pipe3_readl(void __iomem *addr, unsigned offset)
-{
-	return __raw_readl(addr + offset);
-}
-
-static inline void omap_pipe3_writel(void __iomem *addr, unsigned offset,
-		u32 data)
-{
-	__raw_writel(data, addr + offset);
-}
-
-static struct pipe3_dpll_params *omap_pipe3_get_dpll_params(struct omap_pipe3
-									*pipe3)
-{
-	u32 rate;
-	struct pipe3_dpll_map *dpll_map = pipe3->dpll_map;
-
-	rate = get_sys_clk_freq();
-
-	for (; dpll_map->rate; dpll_map++) {
-		if (rate == dpll_map->rate)
-			return &dpll_map->params;
-	}
-
-	printf("%s: No DPLL configuration for %u Hz SYS CLK\n",
-	       __func__, rate);
-	return NULL;
-}
-
-
-static int omap_pipe3_wait_lock(struct omap_pipe3 *phy)
-{
-	u32 val;
-	int timeout = PLL_LOCK_TIME;
-
-	do {
-		mdelay(1);
-		val = omap_pipe3_readl(phy->pll_ctrl_base, PLL_STATUS);
-		if (val & PLL_LOCK)
-			break;
-	} while (--timeout);
-
-	if (!(val & PLL_LOCK)) {
-		printf("%s: DPLL failed to lock\n", __func__);
-		return -EBUSY;
-	}
-
-	return 0;
-}
-
-static int omap_pipe3_dpll_program(struct omap_pipe3 *phy)
-{
-	u32                     val;
-	struct pipe3_dpll_params *dpll_params;
-
-	dpll_params = omap_pipe3_get_dpll_params(phy);
-	if (!dpll_params) {
-		printf("%s: Invalid DPLL parameters\n", __func__);
-		return -EINVAL;
-	}
-
-	val = omap_pipe3_readl(phy->pll_ctrl_base, PLL_CONFIGURATION1);
-	val &= ~PLL_REGN_MASK;
-	val |= dpll_params->n << PLL_REGN_SHIFT;
-	omap_pipe3_writel(phy->pll_ctrl_base, PLL_CONFIGURATION1, val);
-
-	val = omap_pipe3_readl(phy->pll_ctrl_base, PLL_CONFIGURATION2);
-	val &= ~PLL_SELFREQDCO_MASK;
-	val |= dpll_params->freq << PLL_SELFREQDCO_SHIFT;
-	omap_pipe3_writel(phy->pll_ctrl_base, PLL_CONFIGURATION2, val);
-
-	val = omap_pipe3_readl(phy->pll_ctrl_base, PLL_CONFIGURATION1);
-	val &= ~PLL_REGM_MASK;
-	val |= dpll_params->m << PLL_REGM_SHIFT;
-	omap_pipe3_writel(phy->pll_ctrl_base, PLL_CONFIGURATION1, val);
-
-	val = omap_pipe3_readl(phy->pll_ctrl_base, PLL_CONFIGURATION4);
-	val &= ~PLL_REGM_F_MASK;
-	val |= dpll_params->mf << PLL_REGM_F_SHIFT;
-	omap_pipe3_writel(phy->pll_ctrl_base, PLL_CONFIGURATION4, val);
-
-	val = omap_pipe3_readl(phy->pll_ctrl_base, PLL_CONFIGURATION3);
-	val &= ~PLL_SD_MASK;
-	val |= dpll_params->sd << PLL_SD_SHIFT;
-	omap_pipe3_writel(phy->pll_ctrl_base, PLL_CONFIGURATION3, val);
-
-	omap_pipe3_writel(phy->pll_ctrl_base, PLL_GO, SET_PLL_GO);
-
-	return omap_pipe3_wait_lock(phy);
-}
-
-static void omap_control_phy_power(struct omap_pipe3 *phy, int on)
-{
-	u32 val, rate;
-
-	val = readl(phy->power_reg);
-
-	rate = get_sys_clk_freq();
-	rate = rate/1000000;
-
-	if (on) {
-		val &= ~(OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_CMD_MASK |
-				OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_FREQ_MASK);
-		val |= OMAP_CTRL_PIPE3_PHY_TX_RX_POWERON <<
-			OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_CMD_SHIFT;
-		val |= rate <<
-			OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_FREQ_SHIFT;
-	} else {
-		val &= ~OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_CMD_MASK;
-		val |= OMAP_CTRL_PIPE3_PHY_TX_RX_POWEROFF <<
-			OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_CMD_SHIFT;
-	}
-
-	writel(val, phy->power_reg);
-}
-
-int phy_pipe3_power_on(struct omap_pipe3 *phy)
-{
-	int ret;
-	u32 val;
-
-	/* Program the DPLL only if not locked */
-	val = omap_pipe3_readl(phy->pll_ctrl_base, PLL_STATUS);
-	if (!(val & PLL_LOCK)) {
-		ret = omap_pipe3_dpll_program(phy);
-		if (ret)
-			return ret;
-	} else {
-		/* else just bring it out of IDLE mode */
-		val = omap_pipe3_readl(phy->pll_ctrl_base, PLL_CONFIGURATION2);
-		if (val & PLL_IDLE) {
-			val &= ~PLL_IDLE;
-			omap_pipe3_writel(phy->pll_ctrl_base,
-					  PLL_CONFIGURATION2, val);
-			ret = omap_pipe3_wait_lock(phy);
-			if (ret)
-				return ret;
-		}
-	}
-
-	/* Power up the PHY */
-	omap_control_phy_power(phy, 1);
-
-	return 0;
-}
-
-int phy_pipe3_power_off(struct omap_pipe3 *phy)
-{
-	u32 val;
-	int timeout = PLL_IDLE_TIME;
-
-	/* Power down the PHY */
-	omap_control_phy_power(phy, 0);
-
-	/* Put DPLL in IDLE mode */
-	val = omap_pipe3_readl(phy->pll_ctrl_base, PLL_CONFIGURATION2);
-	val |= PLL_IDLE;
-	omap_pipe3_writel(phy->pll_ctrl_base, PLL_CONFIGURATION2, val);
-
-	/* wait for LDO and Oscillator to power down */
-	do {
-		mdelay(1);
-		val = omap_pipe3_readl(phy->pll_ctrl_base, PLL_STATUS);
-		if ((val & PLL_TICOPWDN) && (val & PLL_LDOPWDN))
-			break;
-	} while (--timeout);
-
-	if (!(val & PLL_TICOPWDN) || !(val & PLL_LDOPWDN)) {
-		printf("%s: Failed to power down DPLL: PLL_STATUS 0x%x\n",
-		       __func__, val);
-		return -EBUSY;
-	}
-
-	return 0;
-}
diff --git a/arch/arm/mach-omap2/pipe3-phy.h b/arch/arm/mach-omap2/pipe3-phy.h
deleted file mode 100644
index 182bdcd4c81f..000000000000
--- a/arch/arm/mach-omap2/pipe3-phy.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * TI PIPE3 PHY
- *
- * (C) Copyright 2013
- * Texas Instruments, <www.ti.com>
- */
-
-#ifndef __OMAP_PIPE3_PHY_H
-#define __OMAP_PIPE3_PHY_H
-
-struct pipe3_dpll_params {
-	u16     m;
-	u8      n;
-	u8      freq:3;
-	u8      sd;
-	u32     mf;
-};
-
-struct pipe3_dpll_map {
-	unsigned long rate;
-	struct pipe3_dpll_params params;
-};
-
-struct omap_pipe3 {
-	void __iomem            *pll_ctrl_base;
-	void __iomem		*power_reg;
-	struct pipe3_dpll_map   *dpll_map;
-};
-
-
-int phy_pipe3_power_on(struct omap_pipe3 *phy);
-int phy_pipe3_power_off(struct omap_pipe3 *pipe3);
-
-#endif /* __OMAP_PIPE3_PHY_H */
diff --git a/arch/arm/mach-omap2/sata.c b/arch/arm/mach-omap2/sata.c
deleted file mode 100644
index 53c39ce1fb68..000000000000
--- a/arch/arm/mach-omap2/sata.c
+++ /dev/null
@@ -1,72 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * TI SATA platform driver
- *
- * (C) Copyright 2013
- * Texas Instruments, <www.ti.com>
- */
-
-#include <common.h>
-#include <ahci.h>
-#include <scsi.h>
-#include <asm/arch/clock.h>
-#include <asm/arch/sata.h>
-#include <sata.h>
-#include <asm/io.h>
-#include <asm/omap_common.h>
-#include "pipe3-phy.h"
-
-static struct pipe3_dpll_map dpll_map_sata[] = {
-	{12000000, {1000, 7, 4, 6, 0} },        /* 12 MHz */
-	{16800000, {714, 7, 4, 6, 0} },         /* 16.8 MHz */
-	{19200000, {625, 7, 4, 6, 0} },         /* 19.2 MHz */
-	{20000000, {600, 7, 4, 6, 0} },         /* 20 MHz */
-	{26000000, {461, 7, 4, 6, 0} },         /* 26 MHz */
-	{38400000, {312, 7, 4, 6, 0} },         /* 38.4 MHz */
-	{ },                                    /* Terminator */
-};
-
-struct omap_pipe3 sata_phy = {
-	.pll_ctrl_base = (void __iomem *)TI_SATA_PLLCTRL_BASE,
-	/* .power_reg is updated at runtime */
-	.dpll_map = dpll_map_sata,
-};
-
-int init_sata(int dev)
-{
-	int ret;
-	u32 val;
-
-	sata_phy.power_reg = (void __iomem *)(*ctrl)->control_phy_power_sata;
-
-	/* Power up the PHY */
-	phy_pipe3_power_on(&sata_phy);
-
-	/* Enable SATA module, No Idle, No Standby */
-	val = TI_SATA_IDLE_NO | TI_SATA_STANDBY_NO;
-	writel(val, TI_SATA_WRAPPER_BASE + TI_SATA_SYSCONFIG);
-
-	ret = ahci_init((void __iomem *)DWC_AHSATA_BASE);
-
-	return ret;
-}
-
-int reset_sata(int dev)
-{
-	return 0;
-}
-
-/* On OMAP platforms SATA provides the SCSI subsystem */
-void scsi_init(void)
-{
-	init_sata(0);
-	scsi_scan(1);
-}
-
-int scsi_bus_reset(struct udevice *dev)
-{
-	ahci_reset((void __iomem *)DWC_AHSATA_BASE);
-	ahci_init((void __iomem *)DWC_AHSATA_BASE);
-
-	return 0;
-}
diff --git a/board/emulation/qemu-riscv/Kconfig b/board/emulation/qemu-riscv/Kconfig
index d56b4b5bc1ed..108e9fdb00a9 100644
--- a/board/emulation/qemu-riscv/Kconfig
+++ b/board/emulation/qemu-riscv/Kconfig
@@ -59,7 +59,6 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply PCIE_ECAM_GENERIC
 	imply DM_RNG
 	imply SCSI
-	imply DM_SCSI
 	imply SYS_NS16550
 	imply SIFIVE_SERIAL
 	imply HTIF_CONSOLE if 64BIT
diff --git a/board/highbank/highbank.c b/board/highbank/highbank.c
index b5fa5101e881..7f67d1e45308 100644
--- a/board/highbank/highbank.c
+++ b/board/highbank/highbank.c
@@ -52,19 +52,6 @@ int board_init(void)
 	return 0;
 }
 
-#ifdef CONFIG_SCSI_AHCI_PLAT
-void scsi_init(void)
-{
-	u32 reg = readl(HB_SREG_A9_PWRDOM_STAT);
-
-	cphy_disable_overrides();
-	if (reg & PWRDOM_STAT_SATA) {
-		ahci_init((void __iomem *)HB_AHCI_BASE);
-		scsi_scan(true);
-	}
-}
-#endif
-
 #ifdef CONFIG_MISC_INIT_R
 int misc_init_r(void)
 {
diff --git a/cmd/scsi.c b/cmd/scsi.c
index 4549995ba73c..c501d7f456d7 100644
--- a/cmd/scsi.c
+++ b/cmd/scsi.c
@@ -34,9 +34,6 @@ static int do_scsi(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (argc == 2) {
 		if (strncmp(argv[1], "res", 3) == 0) {
 			printf("\nReset SCSI\n");
-#ifndef CONFIG_DM_SCSI
-			scsi_bus_reset(NULL);
-#endif
 			ret = scsi_scan(true);
 			if (ret)
 				return CMD_RET_FAILURE;
diff --git a/common/board_r.c b/common/board_r.c
index a7967849dc0c..da0b80f24ff0 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -472,17 +472,6 @@ static int initr_status_led(void)
 }
 #endif
 
-#if defined(CONFIG_SCSI) && !defined(CONFIG_DM_SCSI)
-static int initr_scsi(void)
-{
-	puts("SCSI:  ");
-	scsi_init();
-	puts("\n");
-
-	return 0;
-}
-#endif
-
 #ifdef CONFIG_CMD_NET
 static int initr_net(void)
 {
@@ -732,10 +721,6 @@ static init_fnc_t init_sequence_r[] = {
 #ifdef CONFIG_BOARD_LATE_INIT
 	board_late_init,
 #endif
-#if defined(CONFIG_SCSI) && !defined(CONFIG_DM_SCSI)
-	INIT_FUNC_WATCHDOG_RESET
-	initr_scsi,
-#endif
 #ifdef CONFIG_BITBANGMII
 	bb_miiphy_init,
 #endif
diff --git a/configs/apalis_imx6_defconfig b/configs/apalis_imx6_defconfig
index aa9cf77960bb..cf2af5797f3e 100644
--- a/configs/apalis_imx6_defconfig
+++ b/configs/apalis_imx6_defconfig
@@ -59,6 +59,7 @@ CONFIG_CMD_I2C=y
 # CONFIG_CMD_LOADB is not set
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
+# CONFIG_CMD_SCSI is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_SDP=y
 CONFIG_CMD_USB_MASS_STORAGE=y
@@ -105,7 +106,7 @@ CONFIG_DM_PMIC_PFUZE100=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_PFUZE100=y
 CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_DM_SCSI=y
+CONFIG_SCSI=y
 CONFIG_MXC_UART=y
 CONFIG_IMX_THERMAL=y
 CONFIG_USB=y
diff --git a/configs/dh_imx6_defconfig b/configs/dh_imx6_defconfig
index 5a83b6a08a26..154131e62e09 100644
--- a/configs/dh_imx6_defconfig
+++ b/configs/dh_imx6_defconfig
@@ -52,6 +52,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_SATA=y
+# CONFIG_CMD_SCSI is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_WDT=y
@@ -99,7 +100,7 @@ CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX6=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_DM_SCSI=y
+CONFIG_SCSI=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SPI=y
diff --git a/configs/edison_defconfig b/configs/edison_defconfig
index f134680e4122..db2e35f388b7 100644
--- a/configs/edison_defconfig
+++ b/configs/edison_defconfig
@@ -27,6 +27,7 @@ CONFIG_CMD_DFU=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
+# CONFIG_CMD_SCSI is not set
 CONFIG_CMD_TIMER=y
 CONFIG_CMD_HASH=y
 CONFIG_CMD_EXT4=y
diff --git a/configs/efi-x86_app32_defconfig b/configs/efi-x86_app32_defconfig
index dfc315774a50..682ba5b89576 100644
--- a/configs/efi-x86_app32_defconfig
+++ b/configs/efi-x86_app32_defconfig
@@ -20,6 +20,7 @@ CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_PART=y
+# CONFIG_CMD_SCSI is not set
 # CONFIG_CMD_NET is not set
 CONFIG_CMD_TIME=y
 CONFIG_CMD_EXT2=y
diff --git a/configs/efi-x86_app64_defconfig b/configs/efi-x86_app64_defconfig
index e0cfe3ee243a..d6b6c3d82995 100644
--- a/configs/efi-x86_app64_defconfig
+++ b/configs/efi-x86_app64_defconfig
@@ -21,6 +21,7 @@ CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_PART=y
+# CONFIG_CMD_SCSI is not set
 # CONFIG_CMD_NET is not set
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
diff --git a/configs/galileo_defconfig b/configs/galileo_defconfig
index 3eb1917454d5..35f7fb77e634 100644
--- a/configs/galileo_defconfig
+++ b/configs/galileo_defconfig
@@ -23,6 +23,7 @@ CONFIG_CMD_CPU=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
+# CONFIG_CMD_SCSI is not set
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
diff --git a/configs/mvebu_ac5_rd_defconfig b/configs/mvebu_ac5_rd_defconfig
index e8fa22b648be..0a9adcc03999 100644
--- a/configs/mvebu_ac5_rd_defconfig
+++ b/configs/mvebu_ac5_rd_defconfig
@@ -28,6 +28,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SCSI is not set
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
@@ -72,7 +73,7 @@ CONFIG_PINCTRL_ARMADA_8K=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_RTC=y
-CONFIG_DM_SCSI=y
+CONFIG_SCSI=y
 CONFIG_SYS_NS16550=y
 CONFIG_MVEBU_A3700_SPI=y
 CONFIG_DM_THERMAL=y
diff --git a/configs/novena_defconfig b/configs/novena_defconfig
index 278e3fd8adb1..238999118826 100644
--- a/configs/novena_defconfig
+++ b/configs/novena_defconfig
@@ -48,6 +48,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_SATA=y
+# CONFIG_CMD_SCSI is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
diff --git a/configs/udoo_defconfig b/configs/udoo_defconfig
index e128a62cd005..f89b163ddf56 100644
--- a/configs/udoo_defconfig
+++ b/configs/udoo_defconfig
@@ -34,6 +34,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_MMC=y
 # CONFIG_CMD_PINMUX is not set
 CONFIG_CMD_SATA=y
+# CONFIG_CMD_SCSI is not set
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
@@ -54,7 +55,7 @@ CONFIG_FEC_MXC=y
 CONFIG_MII=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX6=y
-CONFIG_DM_SCSI=y
+CONFIG_SCSI=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_DM_THERMAL=y
diff --git a/configs/wandboard_defconfig b/configs/wandboard_defconfig
index 7c1727f8b12b..c9ec962201b4 100644
--- a/configs/wandboard_defconfig
+++ b/configs/wandboard_defconfig
@@ -45,6 +45,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_SATA=y
+# CONFIG_CMD_SCSI is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_BMP=y
 CONFIG_CMD_CACHE=y
@@ -71,7 +72,7 @@ CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX6=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_PFUZE100=y
-CONFIG_DM_SCSI=y
+CONFIG_SCSI=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_DM_THERMAL=y
diff --git a/configs/x240_defconfig b/configs/x240_defconfig
index 4b1a761a9086..152413de0e50 100644
--- a/configs/x240_defconfig
+++ b/configs/x240_defconfig
@@ -24,6 +24,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SCSI is not set
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
@@ -68,7 +69,7 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_MAX313XX=y
-CONFIG_DM_SCSI=y
+CONFIG_SCSI=y
 CONFIG_SYS_NS16550=y
 CONFIG_MVEBU_A3700_SPI=y
 CONFIG_DM_THERMAL=y
diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 049f7efd10b8..9bc5283c2688 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -20,14 +20,6 @@ config SATA
 
 	  See also CMD_SATA which provides command-line support.
 
-config SYS_SATA_MAX_PORTS
-	int "Maximum supported SATA ports"
-	depends on SCSI_AHCI && !DM_SCSI
-	default 1
-	help
-	  Sets the maximum number of ports to scan when looking for devices.
-	  Ports from 0 to (this value - 1) are scanned.
-
 config LIBATA
 	bool
 	help
@@ -44,7 +36,7 @@ menu "SATA/SCSI device support"
 config AHCI_PCI
 	bool "Support for PCI-based AHCI controller"
 	depends on PCI
-	depends on DM_SCSI
+	depends on SCSI
 	depends on SCSI_AHCI
 	help
 	  Enables support for the PCI-based AHCI controller.
@@ -55,13 +47,13 @@ config SPL_AHCI_PCI
 	bool "Support for PCI-based AHCI controller for SPL"
 	depends on SPL
 	depends on SPL_PCI
-	depends on SPL_SATA && DM_SCSI
+	depends on SPL_SATA && SCSI
 
 config DWC_AHCI
 	bool "Enable Synopsys DWC AHCI driver support"
 	select SCSI_AHCI
 	select PHY
-	depends on DM_SCSI
+	depends on SCSI
 	help
 	  Enable this driver to support Sata devices through
 	  Synopsys DWC AHCI module.
@@ -91,7 +83,7 @@ config AHCI_MVEBU
 	bool "Marvell EBU AHCI SATA support"
 	depends on ARCH_MVEBU || ARCH_OCTEON
 	select SCSI_AHCI
-	select DM_SCSI
+	select SCSI
 	help
 	  This option enables support for the Marvell EBU SoC's
 	  onboard AHCI SATA.
@@ -112,7 +104,7 @@ if SATA
 config SATA_CEVA
 	bool "Ceva Sata controller"
 	depends on AHCI
-	depends on DM_SCSI
+	depends on SCSI
 	help
 	  This option enables Ceva Sata controller hard IP available on Xilinx
 	  ZynqMP. Support up to 2 external devices. Compliant with SATA 3.1 and
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 0b6f91098a39..af6f0bf2780c 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -14,7 +14,6 @@ obj-$(CONFIG_SATA) += sata.o sata_bootdev.o
 obj-$(CONFIG_SATA_CEVA) += sata_ceva.o
 obj-$(CONFIG_SATA_MV) += sata_mv.o
 obj-$(CONFIG_SATA_SIL) += sata_sil.o
-obj-$(CONFIG_SANDBOX) += sata_sandbox.o
 obj-$(CONFIG_AHCI_MVEBU) += ahci_mvebu.o
 obj-$(CONFIG_SUNXI_AHCI) += ahci_sunxi.o
 obj-$(CONFIG_MTK_AHCI) += mtk_ahci.o
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index cb2c648a91fd..04ddc3394648 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -33,10 +33,6 @@
 
 static int ata_io_flush(struct ahci_uc_priv *uc_priv, u8 port);
 
-#ifndef CONFIG_DM_SCSI
-struct ahci_uc_priv *probe_ent = NULL;
-#endif
-
 #define writel_with_flush(a,b)	do { writel(a,b); readl(b); } while (0)
 
 /*
@@ -169,11 +165,6 @@ int ahci_reset(void __iomem *base)
 
 static int ahci_host_init(struct ahci_uc_priv *uc_priv)
 {
-#if !defined(CONFIG_SCSI_AHCI_PLAT) && !defined(CONFIG_DM_SCSI)
-	struct udevice *dev = uc_priv->dev;
-	struct pci_child_plat *pplat = dev_get_parent_plat(dev);
-	u16 tmp16;
-#endif
 	void __iomem *mmio = uc_priv->mmio_base;
 	u32 tmp, cap_save, cmd;
 	int i, j, ret;
@@ -194,14 +185,6 @@ static int ahci_host_init(struct ahci_uc_priv *uc_priv)
 	writel(cap_save, mmio + HOST_CAP);
 	writel_with_flush(0xf, mmio + HOST_PORTS_IMPL);
 
-#if !defined(CONFIG_SCSI_AHCI_PLAT) && !defined(CONFIG_DM_SCSI)
-	if (pplat->vendor == PCI_VENDOR_ID_INTEL) {
-		u16 tmp16;
-
-		dm_pci_read_config16(dev, 0x92, &tmp16);
-		dm_pci_write_config16(dev, 0x92, tmp16 | 0xf);
-	}
-#endif
 	uc_priv->cap = readl(mmio + HOST_CAP);
 	uc_priv->port_map = readl(mmio + HOST_PORTS_IMPL);
 	port_map = uc_priv->port_map;
@@ -210,11 +193,6 @@ static int ahci_host_init(struct ahci_uc_priv *uc_priv)
 	debug("cap 0x%x  port_map 0x%x  n_ports %d\n",
 	      uc_priv->cap, uc_priv->port_map, uc_priv->n_ports);
 
-#if !defined(CONFIG_DM_SCSI)
-	if (uc_priv->n_ports > CONFIG_SYS_SATA_MAX_PORTS)
-		uc_priv->n_ports = CONFIG_SYS_SATA_MAX_PORTS;
-#endif
-
 	for (i = 0; i < uc_priv->n_ports; i++) {
 		if (!(port_map & (1 << i)))
 			continue;
@@ -313,23 +291,12 @@ static int ahci_host_init(struct ahci_uc_priv *uc_priv)
 	writel(tmp | HOST_IRQ_EN, mmio + HOST_CTL);
 	tmp = readl(mmio + HOST_CTL);
 	debug("HOST_CTL 0x%x\n", tmp);
-#if !defined(CONFIG_DM_SCSI)
-#ifndef CONFIG_SCSI_AHCI_PLAT
-	dm_pci_read_config16(dev, PCI_COMMAND, &tmp16);
-	tmp |= PCI_COMMAND_MASTER;
-	dm_pci_write_config16(dev, PCI_COMMAND, tmp16);
-#endif
-#endif
 	return 0;
 }
 
 
 static void ahci_print_info(struct ahci_uc_priv *uc_priv)
 {
-#if !defined(CONFIG_SCSI_AHCI_PLAT) && !defined(CONFIG_DM_SCSI)
-	struct udevice *dev = uc_priv->dev;
-	u16 cc;
-#endif
 	void __iomem *mmio = uc_priv->mmio_base;
 	u32 vers, cap, cap2, impl, speed;
 	const char *speed_s;
@@ -350,19 +317,7 @@ static void ahci_print_info(struct ahci_uc_priv *uc_priv)
 	else
 		speed_s = "?";
 
-#if defined(CONFIG_SCSI_AHCI_PLAT) || defined(CONFIG_DM_SCSI)
 	scc_s = "SATA";
-#else
-	dm_pci_read_config16(dev, 0x0a, &cc);
-	if (cc == 0x0101)
-		scc_s = "IDE";
-	else if (cc == 0x0106)
-		scc_s = "SATA";
-	else if (cc == 0x0104)
-		scc_s = "RAID";
-	else
-		scc_s = "unknown";
-#endif
 	printf("AHCI %02x%02x.%02x%02x "
 	       "%u slots %u ports %s Gbps 0x%x impl %s mode\n",
 	       (vers >> 24) & 0xff,
@@ -397,12 +352,8 @@ static void ahci_print_info(struct ahci_uc_priv *uc_priv)
 	       cap2 & (1 << 0) ? "boh " : "");
 }
 
-#if defined(CONFIG_DM_SCSI) || !defined(CONFIG_SCSI_AHCI_PLAT)
 static int ahci_init_one(struct ahci_uc_priv *uc_priv, struct udevice *dev)
 {
-#if !defined(CONFIG_DM_SCSI)
-	u16 vendor;
-#endif
 	int rc;
 
 	uc_priv->dev = dev;
@@ -415,21 +366,8 @@ static int ahci_init_one(struct ahci_uc_priv *uc_priv, struct udevice *dev)
 	uc_priv->pio_mask = 0x1f;
 	uc_priv->udma_mask = 0x7f;	/*Fixme,assume to support UDMA6 */
 
-#if !defined(CONFIG_DM_SCSI)
-	uc_priv->mmio_base = dm_pci_map_bar(dev, PCI_BASE_ADDRESS_5, 0, 0,
-					    PCI_REGION_TYPE, PCI_REGION_MEM);
-
-	/* Take from kernel:
-	 * JMicron-specific fixup:
-	 * make sure we're in AHCI mode
-	 */
-	dm_pci_read_config16(dev, PCI_VENDOR_ID, &vendor);
-	if (vendor == 0x197b)
-		dm_pci_write_config8(dev, 0x41, 0xa1);
-#else
 	struct scsi_plat *plat = dev_get_uclass_plat(dev);
 	uc_priv->mmio_base = (void *)plat->base;
-#endif
 
 	debug("ahci mmio_base=0x%p\n", uc_priv->mmio_base);
 	/* initialize adapter */
@@ -444,7 +382,6 @@ static int ahci_init_one(struct ahci_uc_priv *uc_priv, struct udevice *dev)
       err_out:
 	return rc;
 }
-#endif
 
 #define MAX_DATA_BYTE_COUNT  (4*1024*1024)
 
@@ -893,12 +830,7 @@ static int ata_scsiop_test_unit_ready(struct ahci_uc_priv *uc_priv,
 
 static int ahci_scsi_exec(struct udevice *dev, struct scsi_cmd *pccb)
 {
-	struct ahci_uc_priv *uc_priv;
-#ifdef CONFIG_DM_SCSI
-	uc_priv = dev_get_uclass_priv(dev->parent);
-#else
-	uc_priv = probe_ent;
-#endif
+	struct ahci_uc_priv *uc_priv = dev_get_uclass_priv(dev->parent);
 	int ret;
 
 	switch (pccb->cmd[0]) {
@@ -953,41 +885,12 @@ static int ahci_start_ports(struct ahci_uc_priv *uc_priv)
 	return 0;
 }
 
-#ifndef CONFIG_DM_SCSI
-void scsi_low_level_init(int busdevfunc)
-{
-	struct ahci_uc_priv *uc_priv;
-
-#ifndef CONFIG_SCSI_AHCI_PLAT
-	probe_ent = calloc(1, sizeof(struct ahci_uc_priv));
-	if (!probe_ent) {
-		printf("%s: No memory for uc_priv\n", __func__);
-		return;
-	}
-	uc_priv = probe_ent;
-	struct udevice *dev;
-	int ret;
-
-	ret = dm_pci_bus_find_bdf(busdevfunc, &dev);
-	if (ret)
-		return;
-	ahci_init_one(uc_priv, dev);
-#else
-	uc_priv = probe_ent;
-#endif
-
-	ahci_start_ports(uc_priv);
-}
-#endif
-
-#ifndef CONFIG_SCSI_AHCI_PLAT
 int ahci_init_one_dm(struct udevice *dev)
 {
 	struct ahci_uc_priv *uc_priv = dev_get_uclass_priv(dev);
 
 	return ahci_init_one(uc_priv, dev);
 }
-#endif
 
 int ahci_start_ports_dm(struct udevice *dev)
 {
@@ -996,65 +899,6 @@ int ahci_start_ports_dm(struct udevice *dev)
 	return ahci_start_ports(uc_priv);
 }
 
-#ifdef CONFIG_SCSI_AHCI_PLAT
-static int ahci_init_common(struct ahci_uc_priv *uc_priv, void __iomem *base)
-{
-	int rc;
-
-	uc_priv->host_flags = ATA_FLAG_SATA
-				| ATA_FLAG_NO_LEGACY
-				| ATA_FLAG_MMIO
-				| ATA_FLAG_PIO_DMA
-				| ATA_FLAG_NO_ATAPI;
-	uc_priv->pio_mask = 0x1f;
-	uc_priv->udma_mask = 0x7f;	/*Fixme,assume to support UDMA6 */
-
-	uc_priv->mmio_base = base;
-
-	/* initialize adapter */
-	rc = ahci_host_init(uc_priv);
-	if (rc)
-		goto err_out;
-
-	ahci_print_info(uc_priv);
-
-	rc = ahci_start_ports(uc_priv);
-
-err_out:
-	return rc;
-}
-
-#ifndef CONFIG_DM_SCSI
-int ahci_init(void __iomem *base)
-{
-	struct ahci_uc_priv *uc_priv;
-
-	probe_ent = malloc(sizeof(struct ahci_uc_priv));
-	if (!probe_ent) {
-		printf("%s: No memory for uc_priv\n", __func__);
-		return -ENOMEM;
-	}
-
-	uc_priv = probe_ent;
-	memset(uc_priv, 0, sizeof(struct ahci_uc_priv));
-
-	return ahci_init_common(uc_priv, base);
-}
-#endif
-
-int ahci_init_dm(struct udevice *dev, void __iomem *base)
-{
-	struct ahci_uc_priv *uc_priv = dev_get_uclass_priv(dev);
-
-	return ahci_init_common(uc_priv, base);
-}
-
-void __weak scsi_init(void)
-{
-}
-
-#endif /* CONFIG_SCSI_AHCI_PLAT */
-
 /*
  * In the general case of generic rotating media it makes sense to have a
  * flush capability. It probably even makes sense in the case of SSDs because
@@ -1098,7 +942,6 @@ static int ahci_scsi_bus_reset(struct udevice *dev)
 	return 0;
 }
 
-#ifdef CONFIG_DM_SCSI
 int ahci_bind_scsi(struct udevice *ahci_dev, struct udevice **devp)
 {
 	struct udevice *dev;
@@ -1190,16 +1033,3 @@ U_BOOT_DRIVER(ahci_scsi) = {
 	.id		= UCLASS_SCSI,
 	.ops		= &scsi_ops,
 };
-#else
-int scsi_exec(struct udevice *dev, struct scsi_cmd *pccb)
-{
-	return ahci_scsi_exec(dev, pccb);
-}
-
-__weak int scsi_bus_reset(struct udevice *dev)
-{
-	return ahci_scsi_bus_reset(dev);
-
-	return 0;
-}
-#endif
diff --git a/drivers/ata/sata.c b/drivers/ata/sata.c
index dcb5fcf476b5..be1ee01b296f 100644
--- a/drivers/ata/sata.c
+++ b/drivers/ata/sata.c
@@ -18,10 +18,6 @@
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
 
-#ifndef CONFIG_AHCI
-struct blk_desc sata_dev_desc[CONFIG_SYS_SATA_MAX_DEVICE];
-#endif
-
 int sata_reset(struct udevice *dev)
 {
 	struct ahci_ops *ops = ahci_get_ops(dev);
@@ -88,15 +84,6 @@ int sata_rescan(bool verbose)
 	return ret;
 }
 
-#ifndef CONFIG_AHCI
-#ifdef CONFIG_PARTITIONS
-struct blk_desc *sata_get_dev(int dev)
-{
-	return (dev < CONFIG_SYS_SATA_MAX_DEVICE) ? &sata_dev_desc[dev] : NULL;
-}
-#endif
-#endif
-
 static unsigned long sata_bread(struct udevice *dev, lbaint_t start,
 				lbaint_t blkcnt, void *dst)
 {
@@ -109,51 +96,6 @@ static unsigned long sata_bwrite(struct udevice *dev, lbaint_t start,
 	return -ENOSYS;
 }
 
-#ifndef CONFIG_AHCI
-int __sata_initialize(void)
-{
-	int rc, ret = -1;
-	int i;
-
-	for (i = 0; i < CONFIG_SYS_SATA_MAX_DEVICE; i++) {
-		memset(&sata_dev_desc[i], 0, sizeof(struct blk_desc));
-		sata_dev_desc[i].uclass_id = UCLASS_AHCI;
-		sata_dev_desc[i].devnum = i;
-		sata_dev_desc[i].part_type = PART_TYPE_UNKNOWN;
-		sata_dev_desc[i].type = DEV_TYPE_HARDDISK;
-		sata_dev_desc[i].lba = 0;
-		sata_dev_desc[i].blksz = 512;
-		sata_dev_desc[i].log2blksz = LOG2(sata_dev_desc[i].blksz);
-		rc = init_sata(i);
-		if (!rc) {
-			rc = scan_sata(i);
-			if (!rc && sata_dev_desc[i].lba > 0 &&
-			    sata_dev_desc[i].blksz > 0) {
-				part_init(&sata_dev_desc[i]);
-				ret = i;
-			}
-		}
-	}
-
-	return ret;
-}
-int sata_initialize(void) __attribute__((weak, alias("__sata_initialize")));
-
-__weak int __sata_stop(void)
-{
-	int i, err = 0;
-
-	for (i = 0; i < CONFIG_SYS_SATA_MAX_DEVICE; i++)
-		err |= reset_sata(i);
-
-	if (err)
-		printf("Could not reset some SATA devices\n");
-
-	return err;
-}
-int sata_stop(void) __attribute__((weak, alias("__sata_stop")));
-#endif
-
 static const struct blk_ops sata_blk_ops = {
 	.read	= sata_bread,
 	.write	= sata_bwrite,
diff --git a/drivers/ata/sata_sandbox.c b/drivers/ata/sata_sandbox.c
deleted file mode 100644
index e64cc4a5c10c..000000000000
--- a/drivers/ata/sata_sandbox.c
+++ /dev/null
@@ -1,33 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2015 Google, Inc
- * Written by Simon Glass <sjg@chromium.org>
- */
-
-#include <common.h>
-#include <blk.h>
-
-int init_sata(int dev)
-{
-	return 0;
-}
-
-int reset_sata(int dev)
-{
-	return 0;
-}
-
-int scan_sata(int dev)
-{
-	return 0;
-}
-
-ulong sata_read(int dev, ulong blknr, lbaint_t blkcnt, void *buffer)
-{
-	return 0;
-}
-
-ulong sata_write(int dev, ulong blknr, lbaint_t blkcnt, const void *buffer)
-{
-	return 0;
-}
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index a8014129d335..7e21c4ae2bb8 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -1,46 +1,9 @@
 config SCSI
-	bool "Support SCSI controllers"
+	bool "Support SCSI controllers with driver model"
 	help
 	  This enables support for SCSI (Small Computer System Interface),
 	  a parallel interface widely used with storage peripherals such as
 	  hard drives and optical drives. The SCSI standards define physical
 	  interfaces as well as protocols for controlling devices and
-	  tranferring data.
-
-config DM_SCSI
-	bool "Support SCSI controllers with driver model"
-	help
-	  This option enables the SCSI (Small Computer System Interface) uclass
-	  which supports SCSI and SATA HDDs. For every device configuration
-	  (IDs/LUNs) a block device is created with RAW read/write and
-	  filesystem support.
-
-if SCSI && !DM_SCSI
-
-config SCSI_AHCI_PLAT
-	bool "Platform-specific init of AHCI"
-	help
-	  This enables a way for boards to set up an AHCI device manually, by
-	  called ahci_init() and providing an ahci_reset() mechanism.
-
-	  This is deprecated. An AHCI driver should be provided instead.
-
-config SYS_SCSI_MAX_SCSI_ID
-	int "Maximum supported SCSI ID"
-	default 1
-	help
-	  Sets the maximum number of SCSI IDs to scan when looking for devices.
-	  IDs from 0 to (this value - 1) are scanned.
-
-	  This is deprecated and is not needed when BLK is enabled.
-
-config SYS_SCSI_MAX_LUN
-	int "Maximum support SCSI LUN"
-	default 1
-	help
-	  Sets the maximum number of SCSI Logical Unit Numbers (LUNs) to scan on
-	  devices. LUNs from 0 to (this value - 1) are scanned.
-
-	  This is deprecated and is not needed when CONFIG_DM_SCSI is enabled.
-
-endif
+	  tranferring data. For every device configuration (IDs/LUNs) a block
+	  device is created with RAW read/write and filesystem support.
diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
index d8d6de59090d..628be4c89fba 100644
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -4,25 +4,16 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
 ifndef CONFIG_SPL_BUILD
-obj-$(CONFIG_DM_SCSI) += scsi-uclass.o
-obj-$(CONFIG_SCSI) += scsi.o
-
+obj-$(CONFIG_SCSI) += scsi.o scsi-uclass.o
 ifdef CONFIG_SCSI
-ifdef CONFIG_DM_SCSI
 obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += scsi_bootdev.o
+obj-$(CONFIG_SANDBOX) += sandbox_scsi.o
+obj-$(CONFIG_SANDBOX) += scsi_emul.o
 endif
 endif
 
-endif
-
 ifdef CONFIG_SPL_BUILD
 ifdef CONFIG_SPL_SATA
-obj-$(CONFIG_DM_SCSI) += scsi-uclass.o
-obj-$(CONFIG_SCSI) += scsi.o
+obj-$(CONFIG_SCSI) += scsi.o scsi-uclass.o
 endif
 endif
-
-ifdef CONFIG_SCSI
-obj-$(CONFIG_SANDBOX) += sandbox_scsi.o
-obj-$(CONFIG_SANDBOX) += scsi_emul.o
-endif
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 779a34bd2f1c..363047d0f72c 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -21,38 +21,10 @@
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
 
-#if !defined(CONFIG_DM_SCSI)
-# ifdef CFG_SCSI_DEV_LIST
-#  define SCSI_DEV_LIST CFG_SCSI_DEV_LIST
-# else
-#  ifdef CONFIG_SATA_ULI5288
-
-#   define SCSI_VEND_ID 0x10b9
-#   define SCSI_DEV_ID  0x5288
-
-#  elif !defined(CONFIG_SCSI_AHCI_PLAT)
-#   error no scsi device defined
-#  endif
-# define SCSI_DEV_LIST {SCSI_VEND_ID, SCSI_DEV_ID}
-# endif
-#endif
-
-#if defined(CONFIG_PCI) && !defined(CONFIG_SCSI_AHCI_PLAT) && \
-	!defined(CONFIG_DM_SCSI)
-const struct pci_device_id scsi_device_list[] = { SCSI_DEV_LIST };
-#endif
 static struct scsi_cmd tempccb;	/* temporary scsi command buffer */
 
 DEFINE_CACHE_ALIGN_BUFFER(u8, tempbuff, 512);	/* temporary data buffer */
 
-#if !defined(CONFIG_DM_SCSI)
-static int scsi_max_devs; /* number of highest available scsi device */
-
-static int scsi_curr_dev; /* current device */
-
-static struct blk_desc scsi_dev_desc[SCSI_MAX_DEVICE];
-#endif
-
 /* almost the maximum amount of the scsi_ext command.. */
 #define SCSI_MAX_BLK 0xFFFF
 #define SCSI_LBA48_READ	0xFFFFFFF
@@ -107,7 +79,6 @@ static void scsi_setup_inquiry(struct scsi_cmd *pccb)
 	pccb->msgout[0] = SCSI_IDENTIFY; /* NOT USED */
 }
 
-#ifdef CONFIG_BLK
 static void scsi_setup_read_ext(struct scsi_cmd *pccb, lbaint_t start,
 				unsigned short blocks)
 {
@@ -286,59 +257,6 @@ static int scsi_buffer_aligned(struct udevice *dev, struct bounce_buffer *state)
 	return 1;
 }
 #endif	/* CONFIG_BOUNCE_BUFFER */
-#endif
-
-#if defined(CONFIG_PCI) && !defined(CONFIG_SCSI_AHCI_PLAT) && \
-	!defined(CONFIG_DM_SCSI)
-void scsi_init(void)
-{
-	int busdevfunc = -1;
-	int i;
-	/*
-	 * Find a device from the list, this driver will support a single
-	 * controller.
-	 */
-	for (i = 0; i < ARRAY_SIZE(scsi_device_list); i++) {
-		/* get PCI Device ID */
-		struct udevice *dev;
-		int ret;
-
-		ret = dm_pci_find_device(scsi_device_list[i].vendor,
-					 scsi_device_list[i].device, 0, &dev);
-		if (!ret) {
-			busdevfunc = dm_pci_get_bdf(dev);
-			break;
-		}
-		if (busdevfunc != -1)
-			break;
-	}
-
-	if (busdevfunc == -1) {
-		printf("Error: SCSI Controller(s) ");
-		for (i = 0; i < ARRAY_SIZE(scsi_device_list); i++) {
-			printf("%04X:%04X ",
-			       scsi_device_list[i].vendor,
-			       scsi_device_list[i].device);
-		}
-		printf("not found\n");
-		return;
-	}
-#ifdef DEBUG
-	else {
-		printf("SCSI Controller (%04X,%04X) found (%d:%d:%d)\n",
-		       scsi_device_list[i].vendor,
-		       scsi_device_list[i].device,
-		       (busdevfunc >> 16) & 0xFF,
-		       (busdevfunc >> 11) & 0x1F,
-		       (busdevfunc >> 8) & 0x7);
-	}
-#endif
-	bootstage_start(BOOTSTAGE_ID_ACCUM_SCSI, "ahci");
-	scsi_low_level_init(busdevfunc);
-	scsi_scan(true);
-	bootstage_accum(BOOTSTAGE_ID_ACCUM_SCSI);
-}
-#endif
 
 /* copy src to dest, skipping leading and trailing blanks
  * and null terminate the string
@@ -464,25 +382,6 @@ static void scsi_init_dev_desc_priv(struct blk_desc *dev_desc)
 #endif	/* CONFIG_BOUNCE_BUFFER */
 }
 
-#if !defined(CONFIG_DM_SCSI)
-/**
- * scsi_init_dev_desc - initialize all SCSI specific blk_desc properties
- *
- * @dev_desc: Block device description pointer
- * @devnum: Device number
- */
-static void scsi_init_dev_desc(struct blk_desc *dev_desc, int devnum)
-{
-	dev_desc->lba = 0;
-	dev_desc->blksz = 0;
-	dev_desc->uclass_id = UCLASS_SCSI;
-	dev_desc->devnum = devnum;
-	dev_desc->part_type = PART_TYPE_UNKNOWN;
-
-	scsi_init_dev_desc_priv(dev_desc);
-}
-#endif
-
 /**
  * scsi_detect_dev - Detect scsi device
  *
@@ -570,7 +469,6 @@ removable:
  * (re)-scan the scsi bus and reports scsi device info
  * to the user if mode = 1
  */
-#if defined(CONFIG_DM_SCSI)
 static int do_scsi_scan_one(struct udevice *dev, int id, int lun, bool verbose)
 {
 	int ret;
@@ -691,48 +589,7 @@ int scsi_scan(bool verbose)
 
 	return 0;
 }
-#else
-int scsi_scan(bool verbose)
-{
-	unsigned char i, lun;
-	int ret;
-
-	if (verbose)
-		printf("scanning bus for devices...\n");
-	for (i = 0; i < SCSI_MAX_DEVICE; i++)
-		scsi_init_dev_desc(&scsi_dev_desc[i], i);
-
-	scsi_max_devs = 0;
-	for (i = 0; i < CONFIG_SYS_SCSI_MAX_SCSI_ID; i++) {
-		for (lun = 0; lun < CONFIG_SYS_SCSI_MAX_LUN; lun++) {
-			struct blk_desc *bdesc = &scsi_dev_desc[scsi_max_devs];
-
-			ret = scsi_detect_dev(NULL, i, lun, bdesc);
-			if (ret)
-				continue;
-			part_init(bdesc);
-
-			if (verbose) {
-				printf("  Device %d: ", bdesc->devnum);
-				dev_print(bdesc);
-			}
-			scsi_max_devs++;
-		} /* next LUN */
-	}
-	if (scsi_max_devs > 0)
-		scsi_curr_dev = 0;
-	else
-		scsi_curr_dev = -1;
-
-	printf("Found %d device(s).\n", scsi_max_devs);
-#ifndef CONFIG_SPL_BUILD
-	env_set_ulong("scsidevs", scsi_max_devs);
-#endif
-	return 0;
-}
-#endif
 
-#ifdef CONFIG_BLK
 static const struct blk_ops scsi_blk_ops = {
 	.read	= scsi_read,
 	.write	= scsi_write,
@@ -746,11 +603,3 @@ U_BOOT_DRIVER(scsi_blk) = {
 	.id		= UCLASS_BLK,
 	.ops		= &scsi_blk_ops,
 };
-#else
-U_BOOT_LEGACY_BLK(scsi) = {
-	.uclass_idname	= "scsi",
-	.uclass_id	= UCLASS_SCSI,
-	.max_devs	= SCSI_MAX_DEVICE,
-	.desc		= scsi_dev_desc,
-};
-#endif
diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 0e0cc58e3d64..ee021c7d549d 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -2,7 +2,7 @@ menu "UFS Host Controller Support"
 
 config UFS
 	bool "Support UFS controllers"
-	depends on DM_SCSI
+	depends on SCSI
 	select CHARSET
 	help
 	  This selects support for Universal Flash Subsystem (UFS).
diff --git a/include/ahci.h b/include/ahci.h
index d7f951c3883b..d4f0f3ce0e71 100644
--- a/include/ahci.h
+++ b/include/ahci.h
@@ -223,9 +223,6 @@ int sata_dm_port_status(struct udevice *dev, int port);
  */
 int sata_scan(struct udevice *dev);
 
-int ahci_init(void __iomem *base);
-int ahci_reset(void __iomem *base);
-
 /**
  * ahci_init_one_dm() - set up a single AHCI port
  *
diff --git a/include/configs/ls1021aiot.h b/include/configs/ls1021aiot.h
index 83ab94ec444c..971a393817a3 100644
--- a/include/configs/ls1021aiot.h
+++ b/include/configs/ls1021aiot.h
@@ -57,13 +57,6 @@
  * MMC
  */
 
-/* SATA */
-#ifndef PCI_DEVICE_ID_FREESCALE_AHCI
-#define PCI_DEVICE_ID_FREESCALE_AHCI	0x0440
-#endif
-#define CFG_SCSI_DEV_LIST		{PCI_VENDOR_ID_FREESCALE, \
-	PCI_DEVICE_ID_FREESCALE_AHCI}
-
 /* SPI */
 
 #define FSL_PCIE_COMPAT		"fsl,ls1021a-pcie"
diff --git a/include/configs/ls1028ardb.h b/include/configs/ls1028ardb.h
index ee4f885c5341..0f591e3c4ab5 100644
--- a/include/configs/ls1028ardb.h
+++ b/include/configs/ls1028ardb.h
@@ -49,11 +49,6 @@
 					CSOR_NOR_TRHZ_80)
 #endif
 
-/* SATA */
-#define SCSI_VEND_ID 0x1b4b
-#define SCSI_DEV_ID  0x9170
-#define CFG_SCSI_DEV_LIST {SCSI_VEND_ID, SCSI_DEV_ID}
-
 /* Initial environment variables */
 #ifndef SPL_NO_ENV
 #undef CFG_EXTRA_ENV_SETTINGS
diff --git a/include/configs/ls1043ardb.h b/include/configs/ls1043ardb.h
index 60362b6a4d07..ef8fdc1912bd 100644
--- a/include/configs/ls1043ardb.h
+++ b/include/configs/ls1043ardb.h
@@ -199,13 +199,6 @@
 #endif
 #endif
 
-/* SATA */
-#ifndef SPL_NO_SATA
-#define SCSI_VEND_ID 0x1b4b
-#define SCSI_DEV_ID  0x9170
-#define CFG_SCSI_DEV_LIST {SCSI_VEND_ID, SCSI_DEV_ID}
-#endif
-
 #include <asm/fsl_secure_boot.h>
 
 #endif /* __LS1043ARDB_H__ */
diff --git a/include/sata.h b/include/sata.h
index 6111cf65d9d1..8414e77e42ba 100644
--- a/include/sata.h
+++ b/include/sata.h
@@ -2,22 +2,6 @@
 #define __SATA_H__
 #include <part.h>
 
-#if !defined(CONFIG_DM_SCSI) && !defined(CONFIG_AHCI)
-int init_sata(int dev);
-int reset_sata(int dev);
-int scan_sata(int dev);
-ulong sata_read(int dev, ulong blknr, lbaint_t blkcnt, void *buffer);
-ulong sata_write(int dev, ulong blknr, lbaint_t blkcnt, const void *buffer);
-
-int sata_initialize(void);
-int __sata_initialize(void);
-int sata_stop(void);
-int __sata_stop(void);
-int sata_port_status(int dev, int port);
-
-extern struct blk_desc sata_dev_desc[];
-#endif
-
 int sata_probe(int devnum);
 int sata_remove(int devnum);
 
diff --git a/include/scsi.h b/include/scsi.h
index ee9d622680d6..cf756aa62e16 100644
--- a/include/scsi.h
+++ b/include/scsi.h
@@ -10,10 +10,6 @@
 #include <bouncebuf.h>
 #include <linux/dma-direction.h>
 
-/* Fix this to the maximum */
-#define SCSI_MAX_DEVICE \
-	(CONFIG_SYS_SCSI_MAX_SCSI_ID * CONFIG_SYS_SCSI_MAX_LUN)
-
 struct udevice;
 
 /**
@@ -355,11 +351,6 @@ int scsi_scan(bool verbose);
  */
 int scsi_scan_dev(struct udevice *dev, bool verbose);
 
-#ifndef CONFIG_DM_SCSI
-void scsi_low_level_init(int busdevfunc);
-void scsi_init(void);
-#endif
-
 #define SCSI_IDENTIFY					0xC0  /* not used */
 
 /* Hardware errors  */
-- 
2.34.1

