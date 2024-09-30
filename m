Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0392FCF6499
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 02:12:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B879D88EB9;
	Mon, 30 Sep 2024 04:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ERUW9MPz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D045D88F33; Mon, 30 Sep 2024 03:51:03 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D82DC88D89
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 03:50:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-82cf3286261so148120539f.0
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 18:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727661041; x=1728265841; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wA9T8hMSlQHh4N77d3t+M0c1Gvgw8WRtEAihzSHAWg4=;
 b=ERUW9MPzmhGZcxV/KebLmZYwh1BBXvXD64Z/nR3iIDUjNy+y51H0/hQmlG4/Jnsymx
 EcUyTk3obUiu7gYTOBicnHcthijmu2bxfukfluldo81X+xWQ0RbkTvI2UU9xZb+KBZGi
 ksaP1ExXi9+kqAzxGHHxFMD/lJ+KZbIESaXWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727661041; x=1728265841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wA9T8hMSlQHh4N77d3t+M0c1Gvgw8WRtEAihzSHAWg4=;
 b=oO4sCTf1flERmC4FQ2KJExdpMKsqvc9cqz71C9dizgNMDqBD/m4zLcvFTsltri1qn1
 pqvoof4cQIgH65aVLkgxRXXsFHS+fwNIwLrz1QA3EESssIyUnD7Nz2nzAn6Y+wNxNsY9
 xHM778dXraFs7inNSmrcEME9MHt6BWOirj/hqJR8mMcugLulzQmMwpVhu6OUnqeYLxUa
 51bovBKKDgmSBBchZmCssq7HRqHbRxQoRxqM4Jy6qMC5ecIIXUCcZFNfyUnqs3G1SpJn
 gGGyoxBRO9TnziyxbbDr6J+zsXRtWAL4Vu37evZONz0o+ebTH9rzShUsjRL7wVmZR0ak
 d2+w==
X-Gm-Message-State: AOJu0YxuwdcGcJVqDkRz8XE8YAiOJPeI/sP4fKTzMuCU2lwkStN8JYvx
 cmDNSm0TDrD64q+uMuPx8e0zfNlqNbmvtfdgmrOVR//wFgavNxuV0TRW2SZ1uzxzY1yQc89ehTZ
 3tg==
X-Google-Smtp-Source: AGHT+IEJJCi5xl7tugAiuFpjyzMlMZNFW4jbshq2Lmx6NW1oBCkX/J/sjaVSbuaa+HXP4VoSDGO59g==
X-Received: by 2002:a92:c568:0:b0:3a0:9aef:4d0 with SMTP id
 e9e14a558f8ab-3a34514bbb7mr68769995ab.5.1727661040384; 
 Sun, 29 Sep 2024 18:50:40 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a344de1d5fsm22074185ab.62.2024.09.29.18.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 18:50:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>,
 Elaine Zhang <zhangqing@rock-chips.com>, Harald Seiler <hws@denx.de>,
 Heiko Schocher <hs@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sam Protsenko <semen.protsenko@linaro.org>, Stefan Roese <sr@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>, Weijie Gao <weijie.gao@mediatek.com>,
 William Zhang <william.zhang@broadcom.com>,
 shengfei Xu <xsf@rock-chips.com>
Subject: [PATCH v3 25/33] drivers: Use CONFIG_XPL_BUILD instead of
 CONFIG_SPL_BUILD
Date: Sun, 29 Sep 2024 19:49:48 -0600
Message-Id: <20240930014956.1434060-26-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930014956.1434060-1-sjg@chromium.org>
References: <20240930014956.1434060-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 30 Sep 2024 04:11:30 +0200
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

Use the new symbol to refer to any 'SPL' build, including TPL and VPL

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Split into several patches

 drivers/Makefile                              |  4 +-
 drivers/block/Makefile                        |  2 +-
 drivers/bus/Makefile                          |  2 +-
 drivers/clk/altera/clk-agilex.c               |  2 +-
 drivers/clk/altera/clk-agilex5.c              |  2 +-
 drivers/clk/altera/clk-n5x.c                  |  2 +-
 drivers/clk/clk-uclass.c                      |  2 +-
 drivers/clk/clk_vexpress_osc.c                |  4 +-
 drivers/clk/clk_zynq.c                        | 22 +++++-----
 drivers/clk/imx/clk-imx8mm.c                  |  6 +--
 drivers/clk/imx/clk-imx8mn.c                  |  6 +--
 drivers/clk/imx/clk-imxrt1020.c               |  2 +-
 drivers/clk/imx/clk-imxrt1050.c               |  2 +-
 drivers/clk/rockchip/clk_px30.c               |  6 +--
 drivers/clk/rockchip/clk_rk3188.c             |  6 +--
 drivers/clk/rockchip/clk_rk3288.c             |  8 ++--
 drivers/clk/rockchip/clk_rk3328.c             |  4 +-
 drivers/clk/rockchip/clk_rk3368.c             | 14 +++---
 drivers/clk/rockchip/clk_rk3399.c             | 10 ++---
 drivers/clk/rockchip/clk_rk3568.c             | 10 ++---
 drivers/clk/rockchip/clk_rk3588.c             | 14 +++---
 drivers/clk/sifive/sifive-prci.c              |  2 +-
 drivers/clk/starfive/clk-jh7110-pll.c         |  4 +-
 drivers/clk/stm32/clk-stm32mp1.c              |  6 +--
 drivers/core/ofnode.c                         |  4 +-
 drivers/crypto/fsl/jobdesc.c                  |  2 +-
 drivers/crypto/fsl/jr.c                       |  6 +--
 drivers/ddr/altera/sdram_gen5.c               |  4 +-
 drivers/ddr/fsl/lc_common_dimm_params.c       |  6 +--
 drivers/ddr/fsl/main.c                        |  6 +--
 drivers/ddr/imx/imx8m/Makefile                |  2 +-
 drivers/ddr/imx/imx8ulp/Makefile              |  2 +-
 drivers/ddr/imx/imx9/Makefile                 |  2 +-
 drivers/ddr/imx/phy/Makefile                  |  2 +-
 drivers/ddr/marvell/a38x/Makefile             | 44 +++++++++----------
 drivers/ddr/marvell/a38x/old/Makefile         | 28 ++++++------
 drivers/ddr/marvell/axp/Makefile              | 20 ++++-----
 drivers/firmware/firmware-zynqmp.c            | 10 ++---
 drivers/fpga/intel_sdm_mb.c                   |  2 +-
 drivers/fpga/zynqpl.c                         |  6 +--
 drivers/gpio/Makefile                         |  2 +-
 drivers/gpio/gpio-uclass.c                    |  4 +-
 drivers/gpio/pca953x.c                        |  2 +-
 drivers/gpio/rk_gpio.c                        |  4 +-
 drivers/gpio/s5p_gpio.c                       | 10 ++---
 drivers/gpio/sunxi_gpio.c                     |  2 +-
 drivers/gpio/tca642x.c                        |  2 +-
 drivers/gpio/tegra_gpio.c                     |  2 +-
 drivers/input/Makefile                        |  2 +-
 drivers/mailbox/zynqmp-ipi.c                  |  6 +--
 drivers/misc/Makefile                         |  6 +--
 drivers/misc/gsc.c                            |  2 +-
 drivers/misc/imx8/scu.c                       |  2 +-
 drivers/mmc/Makefile                          |  2 +-
 drivers/mmc/mmc-uclass.c                      |  4 +-
 drivers/mmc/mmc.c                             | 20 ++++-----
 drivers/mmc/mmc_legacy.c                      |  4 +-
 drivers/mmc/mmc_private.h                     |  2 +-
 drivers/mmc/omap_hsmmc.c                      |  4 +-
 drivers/mmc/rockchip_dw_mmc.c                 |  2 +-
 drivers/mmc/rockchip_sdhci.c                  |  2 +-
 drivers/mmc/socfpga_dw_mmc.c                  |  2 +-
 drivers/mmc/tmio-common.c                     |  2 +-
 drivers/mmc/uniphier-sd.c                     |  4 +-
 drivers/mmc/zynq_sdhci.c                      |  6 +--
 drivers/mtd/Makefile                          |  2 +-
 drivers/mtd/nand/Makefile                     |  2 +-
 drivers/mtd/nand/raw/Makefile                 |  2 +-
 drivers/mtd/nand/raw/atmel_nand.c             |  4 +-
 drivers/mtd/nand/raw/lpc32xx_nand_mlc.c       |  6 +--
 drivers/mtd/nand/raw/lpc32xx_nand_slc.c       |  8 ++--
 drivers/mtd/nand/raw/nand_base.c              | 10 ++---
 drivers/mtd/nand/raw/omap_gpmc.c              |  4 +-
 drivers/mtd/nand/raw/sand_nand.c              |  2 +-
 drivers/mtd/onenand/Makefile                  |  2 +-
 drivers/mtd/spi/Makefile                      |  2 +-
 drivers/mtd/spi/sf-uclass.c                   |  2 +-
 drivers/mtd/spi/sf_dataflash.c                |  2 +-
 drivers/mtd/spi/spi-nor-core.c                |  4 +-
 drivers/net/dwc_eth_xgmac_socfpga.c           |  2 +-
 drivers/net/dwmac_socfpga.c                   |  2 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |  4 +-
 drivers/pinctrl/pinctrl_stm32.c               |  4 +-
 drivers/pinctrl/tegra/Makefile                |  2 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier.h   |  2 +-
 drivers/power/Makefile                        |  2 +-
 drivers/power/pmic/rk8xx.c                    |  4 +-
 drivers/power/pmic/stpmic1.c                  |  6 +--
 drivers/power/power_core.c                    |  2 +-
 drivers/power/regulator/rk8xx.c               |  2 +-
 drivers/power/sy8106a.c                       |  2 +-
 drivers/ram/Makefile                          |  2 +-
 drivers/ram/mediatek/ddr3-mt7629.c            |  4 +-
 drivers/ram/rockchip/sdram_rk3188.c           | 12 ++---
 drivers/ram/rockchip/sdram_rk3288.c           | 12 ++---
 drivers/ram/rockchip/sdram_rk3399.c           |  2 +-
 drivers/ram/rockchip/sdram_rv1126.c           |  6 +--
 drivers/ram/sifive/sifive_ddr.c               |  6 +--
 drivers/ram/starfive/Makefile                 |  4 +-
 drivers/ram/stm32mp1/stm32mp1_ram.c           |  2 +-
 drivers/reset/reset-socfpga.c                 |  2 +-
 drivers/scsi/Makefile                         |  4 +-
 drivers/serial/Makefile                       |  2 +-
 drivers/serial/atmel_usart.c                  |  2 +-
 drivers/serial/ns16550.c                      |  4 +-
 drivers/serial/serial-uclass.c                |  2 +-
 drivers/serial/serial.c                       |  2 +-
 drivers/serial/serial_s5p.c                   |  2 +-
 drivers/serial/serial_zynq.c                  |  2 +-
 drivers/spi/designware_spi.c                  |  4 +-
 drivers/spi/rockchip_sfc.c                    |  2 +-
 drivers/sysreset/sysreset_ast.c               |  2 +-
 drivers/usb/cdns3/core.c                      |  6 +--
 drivers/usb/gadget/Makefile                   |  4 +-
 drivers/usb/gadget/f_sdp.c                    | 10 ++---
 drivers/usb/mtu3/mtu3_plat.c                  |  4 +-
 116 files changed, 289 insertions(+), 289 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 1acd94f3c17..1b7db812828 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -47,7 +47,7 @@ obj-y += bus/
 
 ifndef CONFIG_TPL_BUILD
 ifndef CONFIG_VPL_BUILD
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 
 obj-$(CONFIG_SPL_CPU) += cpu/
 obj-$(CONFIG_SPL_CRYPTO) += crypto/
@@ -80,7 +80,7 @@ obj-$(CONFIG_TPL_MPC8XXX_INIT_DDR) += ddr/fsl/
 
 endif
 
-ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)
+ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
 
 obj-y += ata/
 obj-$(CONFIG_DM_DEMO) += demo/
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index fe6a1fcf486..a551591fc91 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -9,7 +9,7 @@ ifndef CONFIG_$(SPL_)BLK
 obj-$(CONFIG_SPL_LEGACY_BLOCK) += blk_legacy.o
 endif
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_IDE) += ide.o
 obj-$(CONFIG_RKMTD) += rkmtd.o
 endif
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index 0802b9666bf..e14cb7fd9c7 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the bus drivers.
 #
 
-ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)
+ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
 obj-$(CONFIG_TI_PWMSS)	+= ti-pwmss.o
 obj-$(CONFIG_UNIPHIER_SYSTEM_BUS) += uniphier-system-bus.o
 endif
diff --git a/drivers/clk/altera/clk-agilex.c b/drivers/clk/altera/clk-agilex.c
index bdc7be0fb5d..e1ddd02f356 100644
--- a/drivers/clk/altera/clk-agilex.c
+++ b/drivers/clk/altera/clk-agilex.c
@@ -242,7 +242,7 @@ static void clk_basic_init(struct udevice *dev,
 	if (!cfg)
 		return;
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	/* Always force clock manager into boot mode before any configuration */
 	clk_write_ctrl(plat,
 		       CM_REG_READL(plat, CLKMGR_CTRL) | CLKMGR_CTRL_BOOTMODE);
diff --git a/drivers/clk/altera/clk-agilex5.c b/drivers/clk/altera/clk-agilex5.c
index 72b923465df..716c71598bc 100644
--- a/drivers/clk/altera/clk-agilex5.c
+++ b/drivers/clk/altera/clk-agilex5.c
@@ -263,7 +263,7 @@ static void clk_basic_init(struct udevice *dev,
 		clk_write_ctrl(plat,
 			       CM_REG_READL(plat, CLKMGR_CTRL) & ~CLKMGR_CTRL_BOOTMODE);
 	} else {
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 		/* Always force clock manager into boot mode before any configuration */
 		clk_write_ctrl(plat,
 			       CM_REG_READL(plat, CLKMGR_CTRL) | CLKMGR_CTRL_BOOTMODE);
diff --git a/drivers/clk/altera/clk-n5x.c b/drivers/clk/altera/clk-n5x.c
index 3e256101a94..09db250ab6d 100644
--- a/drivers/clk/altera/clk-n5x.c
+++ b/drivers/clk/altera/clk-n5x.c
@@ -52,7 +52,7 @@ static void clk_basic_init(struct udevice *dev,
 	if (!cfg)
 		return;
 
-#if IS_ENABLED(CONFIG_SPL_BUILD)
+#if IS_ENABLED(CONFIG_XPL_BUILD)
 	/* Always force clock manager into boot mode before any configuration */
 	clk_write_ctrl(plat,
 		       CM_REG_READL(plat, CLKMGR_CTRL) | CLKMGR_CTRL_BOOTMODE);
diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 16169dac234..a9937c22dcb 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -378,7 +378,7 @@ int clk_set_defaults(struct udevice *dev, enum clk_defaults_stage stage)
 	 * However, still set them for SPL. And still set them if explicitly
 	 * asked.
 	 */
-	if (!(IS_ENABLED(CONFIG_SPL_BUILD) || (gd->flags & GD_FLG_RELOC)))
+	if (!(IS_ENABLED(CONFIG_XPL_BUILD) || (gd->flags & GD_FLG_RELOC)))
 		if (stage != CLK_DEFAULTS_POST_FORCE)
 			return 0;
 
diff --git a/drivers/clk/clk_vexpress_osc.c b/drivers/clk/clk_vexpress_osc.c
index 2e0e7bbe68f..85ac92c908a 100644
--- a/drivers/clk/clk_vexpress_osc.c
+++ b/drivers/clk/clk_vexpress_osc.c
@@ -37,7 +37,7 @@ static ulong vexpress_osc_clk_get_rate(struct clk *clk)
 	return data;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static ulong vexpress_osc_clk_set_rate(struct clk *clk, ulong rate)
 {
 	int err;
@@ -64,7 +64,7 @@ static ulong vexpress_osc_clk_set_rate(struct clk *clk, ulong rate)
 
 static struct clk_ops vexpress_osc_clk_ops = {
 	.get_rate = vexpress_osc_clk_get_rate,
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	.set_rate = vexpress_osc_clk_set_rate,
 #endif
 };
diff --git a/drivers/clk/clk_zynq.c b/drivers/clk/clk_zynq.c
index b62b4646f4e..a8505f62bba 100644
--- a/drivers/clk/clk_zynq.c
+++ b/drivers/clk/clk_zynq.c
@@ -43,13 +43,13 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 enum zynq_clk_rclk {mio_clk, emio_clk};
 #endif
 
 struct zynq_clk_priv {
 	ulong ps_clk_freq;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	struct clk gem_emio_clk[2];
 #endif
 };
@@ -75,7 +75,7 @@ static void *zynq_clk_get_register(enum zynq_clk id)
 		return &slcr_base->uart_clk_ctrl;
 	case spi0_clk ... spi1_clk:
 		return &slcr_base->spi_clk_ctrl;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	case dci_clk:
 		return &slcr_base->dci_clk_ctrl;
 	case gem0_clk:
@@ -150,7 +150,7 @@ static ulong zynq_clk_get_pll_rate(struct zynq_clk_priv *priv, enum zynq_clk id)
 	return priv->ps_clk_freq * mul;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static enum zynq_clk_rclk zynq_clk_get_gem_rclk(enum zynq_clk id)
 {
 	u32 clk_ctrl, srcsel;
@@ -199,7 +199,7 @@ static ulong zynq_clk_get_cpu_rate(struct zynq_clk_priv *priv, enum zynq_clk id)
 	return DIV_ROUND_CLOSEST(zynq_clk_get_pll_rate(priv, pll), div);
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static ulong zynq_clk_get_ddr2x_rate(struct zynq_clk_priv *priv)
 {
 	u32 clk_ctrl, div;
@@ -223,7 +223,7 @@ static ulong zynq_clk_get_ddr3x_rate(struct zynq_clk_priv *priv)
 	return DIV_ROUND_CLOSEST(zynq_clk_get_pll_rate(priv, ddrpll_clk), div);
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static ulong zynq_clk_get_dci_rate(struct zynq_clk_priv *priv)
 {
 	u32 clk_ctrl, div0, div1;
@@ -251,7 +251,7 @@ static ulong zynq_clk_get_peripheral_rate(struct zynq_clk_priv *priv,
 	if (!div0)
 		div0 = 1;
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	if (two_divs) {
 		div1 = (clk_ctrl & CLK_CTRL_DIV1_MASK) >> CLK_CTRL_DIV1_SHIFT;
 		if (!div1)
@@ -268,7 +268,7 @@ static ulong zynq_clk_get_peripheral_rate(struct zynq_clk_priv *priv,
 			div1);
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static ulong zynq_clk_get_gem_rate(struct zynq_clk_priv *priv, enum zynq_clk id)
 {
 	struct clk *parent;
@@ -366,7 +366,7 @@ static ulong zynq_clk_set_gem_rate(struct zynq_clk_priv *priv, enum zynq_clk id,
 }
 #endif
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static ulong zynq_clk_get_rate(struct clk *clk)
 {
 	struct zynq_clk_priv *priv = dev_get_priv(clk->dev);
@@ -502,7 +502,7 @@ static void zynq_clk_dump(struct udevice *dev)
 
 static struct clk_ops zynq_clk_ops = {
 	.get_rate = zynq_clk_get_rate,
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	.set_rate = zynq_clk_set_rate,
 #endif
 	.enable = dummy_enable,
@@ -514,7 +514,7 @@ static struct clk_ops zynq_clk_ops = {
 static int zynq_clk_probe(struct udevice *dev)
 {
 	struct zynq_clk_priv *priv = dev_get_priv(dev);
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	unsigned int i;
 	char name[16];
 	int ret;
diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index a91c6767fac..bb6958f0ec2 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -31,7 +31,7 @@ static const char * const imx8mm_ahb_sels[] = {"clock-osc-24m", "sys_pll1_133m",
 					       "sys_pll1_400m", "sys_pll2_125m", "sys_pll3_out",
 					       "audio_pll1_out", "video_pll1_out", };
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static const char * const imx8mm_enet_axi_sels[] = {"clock-osc-24m", "sys_pll1_266m", "sys_pll1_800m",
 						    "sys_pll2_250m", "sys_pll2_200m", "audio_pll1_out",
 						    "video_pll1_out", "sys_pll3_out", };
@@ -95,7 +95,7 @@ static const char * const imx8mm_pcie1_aux_sels[] = {"clock-osc-24m", "sys_pll2_
 						     "sys_pll1_160m", "sys_pll1_200m", };
 #endif
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static const char * const imx8mm_pwm1_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
 						"sys_pll1_40m", "sys_pll3_out", "clk_ext1",
 						"sys_pll1_80m", "video_pll1_out", };
@@ -357,7 +357,7 @@ static int imx8mm_clk_probe(struct udevice *dev)
 		imx_clk_gate4("usb1_ctrl_root_clk", "usb_bus", base + 0x44d0, 0));
 
 	/* clks not needed in SPL stage */
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	clk_dm(IMX8MM_CLK_ENET_AXI,
 	       imx8m_clk_composite("enet_axi", imx8mm_enet_axi_sels,
 				   base + 0x8880));
diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 125215e84f4..be15ebd0e25 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -37,7 +37,7 @@ static const char * const imx8mn_enet_axi_sels[] = {"clock-osc-24m", "sys_pll1_2
 						    "sys_pll2_250m", "sys_pll2_200m", "audio_pll1_out",
 						    "video_pll_out", "sys_pll3_out", };
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static const char * const imx8mn_enet_ref_sels[] = {"clock-osc-24m", "sys_pll2_125m", "sys_pll2_50m",
 						    "sys_pll2_100m", "sys_pll1_160m", "audio_pll1_out",
 						    "video_pll_out", "clk_ext4", };
@@ -97,7 +97,7 @@ static const char * const imx8mn_i2c4_sels[] = {"clock-osc-24m", "sys_pll1_160m"
 						"sys_pll3_out", "audio_pll1_out", "video_pll_out",
 						"audio_pll2_out", "sys_pll1_133m", };
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static const char * const imx8mn_pwm1_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
 						"sys_pll1_40m", "sys_pll3_out", "clk_ext1",
 						"sys_pll1_80m", "video_pll_out", };
@@ -359,7 +359,7 @@ static int imx8mn_clk_probe(struct udevice *dev)
 		imx_clk_gate4("usb1_ctrl_root_clk", "usb_bus", base + 0x44d0, 0));
 
 	/* clks not needed in SPL stage */
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	clk_dm(IMX8MN_CLK_ENET_REF,
 	       imx8m_clk_composite("enet_ref", imx8mn_enet_ref_sels,
 	       base + 0xa980));
diff --git a/drivers/clk/imx/clk-imxrt1020.c b/drivers/clk/imx/clk-imxrt1020.c
index c80b02975aa..752434cb0ad 100644
--- a/drivers/clk/imx/clk-imxrt1020.c
+++ b/drivers/clk/imx/clk-imxrt1020.c
@@ -124,7 +124,7 @@ static int imxrt1020_clk_probe(struct udevice *dev)
 	clk_dm(IMXRT1020_CLK_SEMC,
 	       imx_clk_gate2("semc", "semc_podf", base + 0x74, 4));
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	struct clk *clk, *clk1;
 
 	clk_get_by_id(IMXRT1020_CLK_SEMC_SEL, &clk1);
diff --git a/drivers/clk/imx/clk-imxrt1050.c b/drivers/clk/imx/clk-imxrt1050.c
index 754f3948427..788e0650a92 100644
--- a/drivers/clk/imx/clk-imxrt1050.c
+++ b/drivers/clk/imx/clk-imxrt1050.c
@@ -180,7 +180,7 @@ static int imxrt1050_clk_probe(struct udevice *dev)
 
 	struct clk *clk, *clk1;
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	/* bypass pll1 before setting its rate */
 	clk_get_by_id(IMXRT1050_CLK_PLL1_REF_SEL, &clk);
 	clk_get_by_id(IMXRT1050_CLK_PLL1_BYPASS, &clk1);
diff --git a/drivers/clk/rockchip/clk_px30.c b/drivers/clk/rockchip/clk_px30.c
index d7825c66493..22ede1c38a8 100644
--- a/drivers/clk/rockchip/clk_px30.c
+++ b/drivers/clk/rockchip/clk_px30.c
@@ -989,7 +989,7 @@ static ulong px30_peri_set_clk(struct px30_clk_priv *priv, ulong clk_id,
 	return px30_peri_get_clk(priv, clk_id);
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static ulong px30_crypto_get_clk(struct px30_clk_priv *priv, ulong clk_id)
 {
 	struct px30_cru *cru = priv->cru;
@@ -1261,7 +1261,7 @@ static ulong px30_clk_get_rate(struct clk *clk)
 	case HCLK_PERI_PRE:
 		rate = px30_peri_get_clk(priv, clk->id);
 		break;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	case SCLK_CRYPTO:
 	case SCLK_CRYPTO_APK:
 		rate = px30_crypto_get_clk(priv, clk->id);
@@ -1345,7 +1345,7 @@ static ulong px30_clk_set_rate(struct clk *clk, ulong rate)
 	case HCLK_PERI_PRE:
 		ret = px30_peri_set_clk(priv, clk->id, rate);
 		break;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	case SCLK_CRYPTO:
 	case SCLK_CRYPTO_APK:
 		ret = px30_crypto_set_clk(priv, clk->id, rate);
diff --git a/drivers/clk/rockchip/clk_rk3188.c b/drivers/clk/rockchip/clk_rk3188.c
index f569a100f22..d8b03e1d7ab 100644
--- a/drivers/clk/rockchip/clk_rk3188.c
+++ b/drivers/clk/rockchip/clk_rk3188.c
@@ -80,7 +80,7 @@ enum {
 		       "divisors on line " __stringify(__LINE__));
 
 /* Keep divisors as low as possible to reduce jitter and power usage */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 static const struct pll_div gpll_init_cfg = PLL_DIVISORS(GPLL_HZ, 2, 2);
 static const struct pll_div cpll_init_cfg = PLL_DIVISORS(CPLL_HZ, 1, 2);
 #endif
@@ -371,7 +371,7 @@ static ulong rockchip_spi_set_clk(struct rk3188_cru *cru, uint gclk_rate,
 	return rockchip_spi_get_clk(cru, gclk_rate, periph);
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 static void rkclk_init(struct rk3188_cru *cru, struct rk3188_grf *grf,
 		       bool has_bwadj)
 {
@@ -557,7 +557,7 @@ static int rk3188_clk_probe(struct udevice *dev)
 		return PTR_ERR(priv->grf);
 	priv->has_bwadj = (type == RK3188A_CRU) ? 1 : 0;
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #if CONFIG_IS_ENABLED(OF_PLATDATA)
 	struct rk3188_clk_plat *plat = dev_get_plat(dev);
 
diff --git a/drivers/clk/rockchip/clk_rk3288.c b/drivers/clk/rockchip/clk_rk3288.c
index 432a79291c8..43c44fadbe7 100644
--- a/drivers/clk/rockchip/clk_rk3288.c
+++ b/drivers/clk/rockchip/clk_rk3288.c
@@ -223,7 +223,7 @@ static int rkclk_configure_ddr(struct rockchip_cru *cru, struct rk3288_grf *grf,
 	return 0;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #define VCO_MAX_KHZ	2200000
 #define VCO_MIN_KHZ	440000
 #define FREF_MAX_KHZ	2200000
@@ -421,7 +421,7 @@ static ulong rockchip_i2s_set_clk(struct rockchip_cru *cru, uint gclk_rate,
 
 	return rockchip_i2s_get_clk(cru, gclk_rate);
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 static void rkclk_init(struct rockchip_cru *cru, struct rk3288_grf *grf)
 {
@@ -819,7 +819,7 @@ static ulong rk3288_clk_set_rate(struct clk *clk, ulong rate)
 	case SCLK_SPI2:
 		new_rate = rockchip_spi_set_clk(cru, gclk_rate, clk->id, rate);
 		break;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	case SCLK_I2S0:
 		new_rate = rockchip_i2s_set_clk(cru, gclk_rate, rate);
 		break;
@@ -973,7 +973,7 @@ static int rk3288_clk_probe(struct udevice *dev)
 	priv->grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
 	if (IS_ERR(priv->grf))
 		return PTR_ERR(priv->grf);
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #if CONFIG_IS_ENABLED(OF_PLATDATA)
 	struct rk3288_clk_plat *plat = dev_get_plat(dev);
 
diff --git a/drivers/clk/rockchip/clk_rk3328.c b/drivers/clk/rockchip/clk_rk3328.c
index 9137dbe69ce..7701a9734ee 100644
--- a/drivers/clk/rockchip/clk_rk3328.c
+++ b/drivers/clk/rockchip/clk_rk3328.c
@@ -582,7 +582,7 @@ static ulong rk3328_spi_set_clk(struct rk3328_cru *cru, uint hz)
 	return rk3328_spi_get_clk(cru);
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static ulong rk3328_vop_get_clk(struct rk3328_clk_priv *priv, ulong clk_id)
 {
 	struct rk3328_cru *cru = priv->cru;
@@ -746,7 +746,7 @@ static ulong rk3328_clk_set_rate(struct clk *clk, ulong rate)
 	case SCLK_SPI:
 		ret = rk3328_spi_set_clk(priv->cru, rate);
 		break;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	case DCLK_LCDC:
 	case ACLK_VOP_PRE:
 	case ACLK_VIO_PRE:
diff --git a/drivers/clk/rockchip/clk_rk3368.c b/drivers/clk/rockchip/clk_rk3368.c
index d8943980521..630253fbb1d 100644
--- a/drivers/clk/rockchip/clk_rk3368.c
+++ b/drivers/clk/rockchip/clk_rk3368.c
@@ -50,7 +50,7 @@ struct pll_div {
 		       (_nr * _no) == hz, #hz "Hz cannot be hit with PLL " \
 		       "divisors on line " __stringify(__LINE__));
 
-#if IS_ENABLED(CONFIG_SPL_BUILD) || IS_ENABLED(CONFIG_TPL_BUILD)
+#if IS_ENABLED(CONFIG_XPL_BUILD) || IS_ENABLED(CONFIG_TPL_BUILD)
 static const struct pll_div apll_l_init_cfg = PLL_DIVISORS(APLL_L_HZ, 12, 2);
 static const struct pll_div apll_b_init_cfg = PLL_DIVISORS(APLL_B_HZ, 1, 2);
 #if !defined(CONFIG_TPL_BUILD)
@@ -88,7 +88,7 @@ static uint32_t rkclk_pll_get_rate(struct rk3368_cru *cru,
 	}
 }
 
-#if IS_ENABLED(CONFIG_SPL_BUILD) || IS_ENABLED(CONFIG_TPL_BUILD)
+#if IS_ENABLED(CONFIG_XPL_BUILD) || IS_ENABLED(CONFIG_TPL_BUILD)
 static int rkclk_set_pll(struct rk3368_cru *cru, enum rk3368_pll_id pll_id,
 			 const struct pll_div *div)
 {
@@ -130,7 +130,7 @@ static int rkclk_set_pll(struct rk3368_cru *cru, enum rk3368_pll_id pll_id,
 }
 #endif
 
-#if IS_ENABLED(CONFIG_SPL_BUILD) || IS_ENABLED(CONFIG_TPL_BUILD)
+#if IS_ENABLED(CONFIG_XPL_BUILD) || IS_ENABLED(CONFIG_TPL_BUILD)
 static void rkclk_init(struct rk3368_cru *cru)
 {
 	u32 apllb, aplll, dpll, cpll, gpll;
@@ -157,7 +157,7 @@ static void rkclk_init(struct rk3368_cru *cru)
 }
 #endif
 
-#if !IS_ENABLED(CONFIG_SPL_BUILD) || CONFIG_IS_ENABLED(MMC)
+#if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(MMC)
 static ulong rk3368_mmc_get_clk(struct rk3368_cru *cru, uint clk_id)
 {
 	u32 div, con, con_id, rate;
@@ -469,7 +469,7 @@ static ulong rk3368_clk_get_rate(struct clk *clk)
 	case SCLK_SPI0 ... SCLK_SPI2:
 		rate = rk3368_spi_get_clk(priv->cru, clk->id);
 		break;
-#if !IS_ENABLED(CONFIG_SPL_BUILD) || CONFIG_IS_ENABLED(MMC)
+#if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(MMC)
 	case HCLK_SDMMC:
 	case HCLK_EMMC:
 		rate = rk3368_mmc_get_clk(priv->cru, clk->id);
@@ -500,7 +500,7 @@ static ulong rk3368_clk_set_rate(struct clk *clk, ulong rate)
 		ret = rk3368_ddr_set_clk(priv->cru, rate);
 		break;
 #endif
-#if !IS_ENABLED(CONFIG_SPL_BUILD) || CONFIG_IS_ENABLED(MMC)
+#if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(MMC)
 	case HCLK_SDMMC:
 	case HCLK_EMMC:
 		ret = rk3368_mmc_set_clk(clk, rate);
@@ -586,7 +586,7 @@ static int rk3368_clk_probe(struct udevice *dev)
 
 	priv->cru = map_sysmem(plat->dtd.reg[0], plat->dtd.reg[1]);
 #endif
-#if IS_ENABLED(CONFIG_SPL_BUILD) || IS_ENABLED(CONFIG_TPL_BUILD)
+#if IS_ENABLED(CONFIG_XPL_BUILD) || IS_ENABLED(CONFIG_TPL_BUILD)
 	rkclk_init(priv->cru);
 #endif
 
diff --git a/drivers/clk/rockchip/clk_rk3399.c b/drivers/clk/rockchip/clk_rk3399.c
index 89924041299..155ea8d6353 100644
--- a/drivers/clk/rockchip/clk_rk3399.c
+++ b/drivers/clk/rockchip/clk_rk3399.c
@@ -56,7 +56,7 @@ struct pll_div {
 
 static const struct pll_div gpll_init_cfg = PLL_DIVISORS(GPLL_HZ, 2, 2, 1);
 static const struct pll_div cpll_init_cfg = PLL_DIVISORS(CPLL_HZ, 1, 2, 2);
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 static const struct pll_div ppll_init_cfg = PLL_DIVISORS(PPLL_HZ, 2, 2, 1);
 #endif
 
@@ -1464,7 +1464,7 @@ static int rk3399_clk_probe(struct udevice *dev)
 	priv->cru = map_sysmem(plat->dtd.reg[0], plat->dtd.reg[1]);
 #endif
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 	init_clocks = true;
 #elif CONFIG_IS_ENABLED(HANDOFF)
 	if (!(gd->flags & GD_FLG_RELOC)) {
@@ -1658,7 +1658,7 @@ static struct clk_ops rk3399_pmuclk_ops = {
 	.set_rate = rk3399_pmuclk_set_rate,
 };
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static void pmuclk_init(struct rk3399_pmucru *pmucru)
 {
 	u32 pclk_div;
@@ -1676,7 +1676,7 @@ static void pmuclk_init(struct rk3399_pmucru *pmucru)
 
 static int rk3399_pmuclk_probe(struct udevice *dev)
 {
-#if CONFIG_IS_ENABLED(OF_PLATDATA) || !defined(CONFIG_SPL_BUILD)
+#if CONFIG_IS_ENABLED(OF_PLATDATA) || !defined(CONFIG_XPL_BUILD)
 	struct rk3399_pmuclk_priv *priv = dev_get_priv(dev);
 #endif
 
@@ -1686,7 +1686,7 @@ static int rk3399_pmuclk_probe(struct udevice *dev)
 	priv->pmucru = map_sysmem(plat->dtd.reg[0], plat->dtd.reg[1]);
 #endif
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	pmuclk_init(priv->pmucru);
 #endif
 	return 0;
diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
index 35563509d61..977699d509d 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -91,7 +91,7 @@ static struct rockchip_pll_clock rk3568_pll_clks[] = {
 		     RK3568_PMU_MODE, 2, 10, 0, rk3568_pll_rates),
 };
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static ulong
 rk3568_pmu_pll_set_rate(struct rk3568_clk_priv *priv,
 			ulong pll_id, ulong rate)
@@ -1707,7 +1707,7 @@ static ulong rk3568_emmc_set_bclk(struct rk3568_clk_priv *priv, ulong rate)
 	return rk3568_emmc_get_bclk(priv);
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static ulong rk3568_aclk_vop_get_clk(struct rk3568_clk_priv *priv)
 {
 	struct rk3568_cru *cru = priv->cru;
@@ -2413,7 +2413,7 @@ static ulong rk3568_clk_get_rate(struct clk *clk)
 	case TCLK_EMMC:
 		rate = OSC_HZ;
 		break;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	case ACLK_VOP:
 		rate = rk3568_aclk_vop_get_clk(priv);
 		break;
@@ -2594,7 +2594,7 @@ static ulong rk3568_clk_set_rate(struct clk *clk, ulong rate)
 	case TCLK_EMMC:
 		ret = OSC_HZ;
 		break;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	case ACLK_VOP:
 		ret = rk3568_aclk_vop_set_clk(priv, rate);
 		break;
@@ -2894,7 +2894,7 @@ static void rk3568_clk_init(struct rk3568_clk_priv *priv)
 			priv->gpll_hz = GPLL_HZ;
 	}
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	ret = rk3568_bus_set_clk(priv, ACLK_BUS, 150000000);
 	if (ret < 0)
 		printf("Fail to set the ACLK_BUS clock.\n");
diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index db1384dacd2..6042fc10cdb 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -65,7 +65,7 @@ static struct rockchip_pll_clock rk3588_pll_clks[] = {
 		     RK3588_MODE_CON0, 0, 15, 0, rk3588_pll_rates),
 	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3588_PMU_PLL_CON(128),
 		     RK3588_MODE_CON0, 10, 15, 0, rk3588_pll_rates),
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	/*
 	 * The SPLL is part of the SBUSCRU, not the main CRU and as
 	 * such only directly accessible during the SPL stage.
@@ -76,7 +76,7 @@ static struct rockchip_pll_clock rk3588_pll_clks[] = {
 
 };
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 /*
  *
  * rational_best_approximation(31415, 10000,
@@ -875,7 +875,7 @@ static ulong rk3588_mmc_set_clk(struct rk3588_clk_priv *priv,
 	return rk3588_mmc_get_clk(priv, clk_id);
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static ulong rk3588_aux16m_get_clk(struct rk3588_clk_priv *priv, ulong clk_id)
 {
 	struct rk3588_cru *cru = priv->cru;
@@ -1600,7 +1600,7 @@ static ulong rk3588_clk_get_rate(struct clk *clk)
 	case CLK_GPU:
 		rate = 200000000;
 		break;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	case CLK_AUX16M_0:
 	case CLK_AUX16M_1:
 		rate = rk3588_aux16m_get_clk(priv, clk->id);
@@ -1760,7 +1760,7 @@ static ulong rk3588_clk_set_rate(struct clk *clk, ulong rate)
 	case CLK_150M_SRC:
 		ret = 0;
 		break;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	case CLK_AUX16M_0:
 	case CLK_AUX16M_1:
 		ret = rk3588_aux16m_set_clk(priv, clk->id, rate);
@@ -1965,7 +1965,7 @@ static int rk3588_clk_probe(struct udevice *dev)
 
 	priv->sync_kernel = false;
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	rockchip_pll_set_rate(&rk3588_pll_clks[B0PLL], priv->cru,
 			      B0PLL, LPLL_HZ);
 	rockchip_pll_set_rate(&rk3588_pll_clks[B1PLL], priv->cru,
@@ -2051,7 +2051,7 @@ U_BOOT_DRIVER(rockchip_rk3588_cru) = {
 	.probe		= rk3588_clk_probe,
 };
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define SCRU_BASE			0xfd7d0000
 #define SBUSCRU_BASE			0xfd7d8000
 
diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
index aa26d3a109b..de55504b5c9 100644
--- a/drivers/clk/sifive/sifive-prci.c
+++ b/drivers/clk/sifive/sifive-prci.c
@@ -670,7 +670,7 @@ static int sifive_prci_probe(struct udevice *dev)
 			__prci_wrpll_read_cfg0(pd, pc->pwd);
 	}
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
+	if (IS_ENABLED(CONFIG_XPL_BUILD)) {
 		if (device_is_compatible(dev, "sifive,fu740-c000-prci")) {
 			u32 prci_pll_reg;
 			unsigned long parent_rate;
diff --git a/drivers/clk/starfive/clk-jh7110-pll.c b/drivers/clk/starfive/clk-jh7110-pll.c
index 581035842fc..6d2bfb3ecb7 100644
--- a/drivers/clk/starfive/clk-jh7110-pll.c
+++ b/drivers/clk/starfive/clk-jh7110-pll.c
@@ -348,10 +348,10 @@ struct clk *starfive_jh7110_pll(const char *name, const char *parent_name,
 		return ERR_PTR(ret);
 	}
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD) && pll->type == PLL0)
+	if (IS_ENABLED(CONFIG_XPL_BUILD) && pll->type == PLL0)
 		jh7110_pllx_set_rate(clk, 1000000000);
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD) && pll->type == PLL2)
+	if (IS_ENABLED(CONFIG_XPL_BUILD) && pll->type == PLL2)
 		jh7110_pllx_set_rate(clk, 1188000000);
 
 	return clk;
diff --git a/drivers/clk/stm32/clk-stm32mp1.c b/drivers/clk/stm32/clk-stm32mp1.c
index 204ac170531..4044edfb768 100644
--- a/drivers/clk/stm32/clk-stm32mp1.c
+++ b/drivers/clk/stm32/clk-stm32mp1.c
@@ -26,7 +26,7 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 /* activate clock tree initialization in the driver */
 #define STM32MP1_CLOCK_TREE_INIT
 #endif
@@ -2279,7 +2279,7 @@ static int stm32mp1_clk_probe(struct udevice *dev)
 		dev_err(dev, "clock tree initialization failed (%d)\n", result);
 #endif
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #if defined(VERBOSE_DEBUG)
 	/* display debug information for probe after relocation */
 	if (gd->flags & GD_FLG_RELOC)
@@ -2314,7 +2314,7 @@ static const struct clk_ops stm32mp1_clk_ops = {
 	.disable = stm32mp1_clk_disable,
 	.get_rate = stm32mp1_clk_get_rate,
 	.set_rate = stm32mp1_clk_set_rate,
-#if IS_ENABLED(CONFIG_CMD_CLK) && !IS_ENABLED(CONFIG_SPL_BUILD)
+#if IS_ENABLED(CONFIG_CMD_CLK) && !IS_ENABLED(CONFIG_XPL_BUILD)
 	.dump = stm32mp1_clk_dump,
 #endif
 };
diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 7e3b3719d18..129b34a5cd2 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -611,7 +611,7 @@ int ofnode_read_u32_array(ofnode node, const char *propname,
 					   out_values, sz);
 
 		/* get the error right, but space is more important in SPL */
-		if (!IS_ENABLED(CONFIG_SPL_BUILD)) {
+		if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
 			if (ret == -FDT_ERR_NOTFOUND)
 				return -EINVAL;
 			else if (ret == -FDT_ERR_BADLAYOUT)
@@ -1468,7 +1468,7 @@ int ofnode_read_simple_size_cells(ofnode node)
 
 bool ofnode_pre_reloc(ofnode node)
 {
-#if defined(CONFIG_SPL_BUILD) || defined(CONFIG_TPL_BUILD)
+#if defined(CONFIG_XPL_BUILD) || defined(CONFIG_TPL_BUILD)
 	/* for SPL and TPL the remaining nodes after the fdtgrep 1st pass
 	 * had property bootph-all or bootph-pre-sram/bootph-pre-ram.
 	 * They are removed in final dtb (fdtgrep 2nd pass)
diff --git a/drivers/crypto/fsl/jobdesc.c b/drivers/crypto/fsl/jobdesc.c
index 55191736931..9c4ff4960fc 100644
--- a/drivers/crypto/fsl/jobdesc.c
+++ b/drivers/crypto/fsl/jobdesc.c
@@ -207,7 +207,7 @@ void inline_cnstr_jobdesc_hash(uint32_t *desc,
 	append_store(desc, dma_addr_out, storelen,
 		     LDST_CLASS_2_CCB | LDST_SRCDST_BYTE_CONTEXT);
 }
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 void inline_cnstr_jobdesc_blob_encap(uint32_t *desc, uint8_t *key_idnfr,
 				     uint8_t *plain_txt, uint8_t *enc_blob,
 				     uint32_t in_sz)
diff --git a/drivers/crypto/fsl/jr.c b/drivers/crypto/fsl/jr.c
index 27e24808946..c45481bef0b 100644
--- a/drivers/crypto/fsl/jr.c
+++ b/drivers/crypto/fsl/jr.c
@@ -713,7 +713,7 @@ int sec_init_idx(uint8_t sec_idx)
 
 	ccsr_sec_t *sec = caam->sec;
 	uint32_t mcr = sec_in32(&sec->mcfgr);
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_IMX8M)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_IMX8M)
 	uint32_t jrdid_ms = 0;
 #endif
 #ifdef CONFIG_FSL_CORENET
@@ -745,14 +745,14 @@ int sec_init_idx(uint8_t sec_idx)
 	mcr |= (1 << MCFGR_PS_SHIFT);
 #endif
 	sec_out32(&sec->mcfgr, mcr);
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_IMX8M)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_IMX8M)
 	jrdid_ms = JRDID_MS_TZ_OWN | JRDID_MS_PRIM_TZ | JRDID_MS_PRIM_DID;
 	sec_out32(&sec->jrliodnr[caam->jrid].ms, jrdid_ms);
 #endif
 	jr_reset();
 
 #ifdef CONFIG_FSL_CORENET
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	/*
 	 * For SPL Build, Set the Liodns in SEC JR0 for
 	 * creating PAMU entries corresponding to these.
diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/sdram_gen5.c
index 46c53e7c7a3..3c79bb11802 100644
--- a/drivers/ddr/altera/sdram_gen5.c
+++ b/drivers/ddr/altera/sdram_gen5.c
@@ -20,7 +20,7 @@
 
 #include "sequencer.h"
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 struct altera_gen5_sdram_priv {
 	struct ram_info info;
@@ -651,4 +651,4 @@ U_BOOT_DRIVER(altera_gen5_sdram) = {
 	.priv_auto	= sizeof(struct altera_gen5_sdram_priv),
 };
 
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
diff --git a/drivers/ddr/fsl/lc_common_dimm_params.c b/drivers/ddr/fsl/lc_common_dimm_params.c
index cc128112e4f..9c5b108267a 100644
--- a/drivers/ddr/fsl/lc_common_dimm_params.c
+++ b/drivers/ddr/fsl/lc_common_dimm_params.c
@@ -409,18 +409,18 @@ compute_lowest_common_dimm_parameters(const unsigned int ctrl_num,
 		if (dimm_params[i].n_ranks) {
 			if (dimm_params[i].registered_dimm) {
 				temp1 = 1;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 				printf("Detected RDIMM %s\n",
 					dimm_params[i].mpart);
 #endif
 			} else {
 				temp2 = 1;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 				printf("Detected UDIMM %s\n",
 					dimm_params[i].mpart);
 #endif
 			}
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 			puts("       ");
 #endif
 		}
diff --git a/drivers/ddr/fsl/main.c b/drivers/ddr/fsl/main.c
index 888dfb7ff33..d59e94779ff 100644
--- a/drivers/ddr/fsl/main.c
+++ b/drivers/ddr/fsl/main.c
@@ -863,16 +863,16 @@ phys_size_t __fsl_ddr_sdram(fsl_ddr_info_t *pinfo)
 	if ((first_ctrl == 0) && (total_memory - 1 > (phys_size_t)~0ULL)) {
 		puts("Detected ");
 		print_size(total_memory, " of memory\n");
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 		puts("       "); /* re-align to match init_dram print */
 #endif
 		puts("This U-Boot only supports <= ");
 		print_size((unsigned long long)((phys_size_t)~0ULL)+1, " of DDR\n");
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 		puts("       "); /* re-align to match init_dram print */
 #endif
 		puts("You could rebuild it with CONFIG_PHYS_64BIT\n");
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 		puts("       "); /* re-align to match init_dram print */
 #endif
 	}
diff --git a/drivers/ddr/imx/imx8m/Makefile b/drivers/ddr/imx/imx8m/Makefile
index aed91dc23f4..883e6e1b0d7 100644
--- a/drivers/ddr/imx/imx8m/Makefile
+++ b/drivers/ddr/imx/imx8m/Makefile
@@ -4,7 +4,7 @@
 # SPDX-License-Identifier:	GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_IMX8M_DRAM) += ddr_init.o
 obj-y += ../phy/
 endif
diff --git a/drivers/ddr/imx/imx8ulp/Makefile b/drivers/ddr/imx/imx8ulp/Makefile
index 7f44a92180f..4f2ad32351c 100644
--- a/drivers/ddr/imx/imx8ulp/Makefile
+++ b/drivers/ddr/imx/imx8ulp/Makefile
@@ -4,6 +4,6 @@
 # SPDX-License-Identifier:	GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_IMX8ULP_DRAM) += ddr_init.o
 endif
diff --git a/drivers/ddr/imx/imx9/Makefile b/drivers/ddr/imx/imx9/Makefile
index 9403f988b32..6c9506055b8 100644
--- a/drivers/ddr/imx/imx9/Makefile
+++ b/drivers/ddr/imx/imx9/Makefile
@@ -4,7 +4,7 @@
 # SPDX-License-Identifier:	GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_IMX9_DRAM) += ddr_init.o
 obj-y += ../phy/
 endif
diff --git a/drivers/ddr/imx/phy/Makefile b/drivers/ddr/imx/phy/Makefile
index bb3d4ee5b74..592d0c6ebad 100644
--- a/drivers/ddr/imx/phy/Makefile
+++ b/drivers/ddr/imx/phy/Makefile
@@ -4,6 +4,6 @@
 # SPDX-License-Identifier:	GPL-2.0+
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_IMX_SNPS_DDR_PHY) += helper.o ddrphy_utils.o ddrphy_train.o ddrphy_csr.o
 endif
diff --git a/drivers/ddr/marvell/a38x/Makefile b/drivers/ddr/marvell/a38x/Makefile
index 4e8a9d190d7..f49d009920e 100644
--- a/drivers/ddr/marvell/a38x/Makefile
+++ b/drivers/ddr/marvell/a38x/Makefile
@@ -1,29 +1,29 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-obj-$(CONFIG_SPL_BUILD) += mv_ddr_plat.o
-obj-$(CONFIG_SPL_BUILD) += mv_ddr_sys_env_lib.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_debug.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_init.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training_bist.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training_centralization.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training_db.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training_hw_algo.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training_ip_engine.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training_leveling.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training_pbs.o
-obj-$(CONFIG_SPL_BUILD) += mv_ddr_build_message.o
-obj-$(CONFIG_SPL_BUILD) += mv_ddr_common.o
-obj-$(CONFIG_SPL_BUILD) += mv_ddr_spd.o
-obj-$(CONFIG_SPL_BUILD) += mv_ddr_topology.o
-obj-$(CONFIG_SPL_BUILD) += xor.o
+obj-$(CONFIG_XPL_BUILD) += mv_ddr_plat.o
+obj-$(CONFIG_XPL_BUILD) += mv_ddr_sys_env_lib.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_debug.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_init.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training_bist.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training_centralization.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training_db.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training_hw_algo.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training_ip_engine.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training_leveling.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training_pbs.o
+obj-$(CONFIG_XPL_BUILD) += mv_ddr_build_message.o
+obj-$(CONFIG_XPL_BUILD) += mv_ddr_common.o
+obj-$(CONFIG_XPL_BUILD) += mv_ddr_spd.o
+obj-$(CONFIG_XPL_BUILD) += mv_ddr_topology.o
+obj-$(CONFIG_XPL_BUILD) += xor.o
 
 obj-$(CONFIG_ARMADA_38X_SUPPORT_OLD_DDR3_TRAINING) += old/
 
 ifdef CONFIG_DDR4
-	obj-$(CONFIG_SPL_BUILD) += mv_ddr4_mpr_pda_if.o
-	obj-$(CONFIG_SPL_BUILD) += mv_ddr4_training.o
-	obj-$(CONFIG_SPL_BUILD) += mv_ddr4_training_calibration.o
-	obj-$(CONFIG_SPL_BUILD) += mv_ddr4_training_db.o
-	obj-$(CONFIG_SPL_BUILD) += mv_ddr4_training_leveling.o
+	obj-$(CONFIG_XPL_BUILD) += mv_ddr4_mpr_pda_if.o
+	obj-$(CONFIG_XPL_BUILD) += mv_ddr4_training.o
+	obj-$(CONFIG_XPL_BUILD) += mv_ddr4_training_calibration.o
+	obj-$(CONFIG_XPL_BUILD) += mv_ddr4_training_db.o
+	obj-$(CONFIG_XPL_BUILD) += mv_ddr4_training_leveling.o
 endif
diff --git a/drivers/ddr/marvell/a38x/old/Makefile b/drivers/ddr/marvell/a38x/old/Makefile
index 1645a79b405..c9bc746cc2b 100644
--- a/drivers/ddr/marvell/a38x/old/Makefile
+++ b/drivers/ddr/marvell/a38x/old/Makefile
@@ -2,20 +2,20 @@
 # SPDX-License-Identifier:	GPL-2.0+
 #
 
-obj-$(CONFIG_SPL_BUILD) += ddr3_a38x.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_a38x_training.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_debug.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_hws_hw_training.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_init.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training_bist.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training_centralization.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training_db.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training_hw_algo.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training_ip_engine.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training_leveling.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training_pbs.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_training_static.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_a38x.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_a38x_training.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_debug.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_hws_hw_training.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_init.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training_bist.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training_centralization.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training_db.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training_hw_algo.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training_ip_engine.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training_leveling.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training_pbs.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_training_static.o
 
 define IncludeSymbolRename
   CFLAGS_$(1) = -include $(srctree)/drivers/ddr/marvell/a38x/old/glue_symbol_renames.h
diff --git a/drivers/ddr/marvell/axp/Makefile b/drivers/ddr/marvell/axp/Makefile
index d04d9a21db2..01e427296e6 100644
--- a/drivers/ddr/marvell/axp/Makefile
+++ b/drivers/ddr/marvell/axp/Makefile
@@ -1,12 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-obj-$(CONFIG_SPL_BUILD) += ddr3_dfs.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_dqs.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_hw_training.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_init.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_pbs.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_read_leveling.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_sdram.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_spd.o
-obj-$(CONFIG_SPL_BUILD) += ddr3_write_leveling.o
-obj-$(CONFIG_SPL_BUILD) += xor.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_dfs.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_dqs.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_hw_training.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_init.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_pbs.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_read_leveling.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_sdram.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_spd.o
+obj-$(CONFIG_XPL_BUILD) += ddr3_write_leveling.o
+obj-$(CONFIG_XPL_BUILD) += xor.o
diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index f99507d86c6..4b1b80d7abe 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -260,7 +260,7 @@ int zynqmp_pmufw_load_config_object(const void *cfg_obj, size_t size)
 	int err;
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD))
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
 		printf("Loading new PMUFW cfg obj (%ld bytes)\n", size);
 
 	flush_dcache_range((ulong)cfg_obj, (ulong)(cfg_obj + size));
@@ -282,7 +282,7 @@ int zynqmp_pmufw_load_config_object(const void *cfg_obj, size_t size)
 	if (ret_payload[0])
 		printf("PMUFW returned 0x%08x status!\n", ret_payload[0]);
 
-	if ((err || ret_payload[0]) && IS_ENABLED(CONFIG_SPL_BUILD))
+	if ((err || ret_payload[0]) && IS_ENABLED(CONFIG_XPL_BUILD))
 		panic("PMUFW config object loading failed in EL3\n");
 
 	return 0;
@@ -354,7 +354,7 @@ int __maybe_unused xilinx_pm_request(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
 	debug("%s at EL%d, API ID: 0x%0x, 0x%0x, 0x%0x, 0x%0x, 0x%0x\n",
 	      __func__, current_el(), api_id, arg0, arg1, arg2, arg3);
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD) || current_el() == 3) {
+	if (IS_ENABLED(CONFIG_XPL_BUILD) || current_el() == 3) {
 #if defined(CONFIG_ZYNQMP_IPI)
 		/*
 		 * Use fixed payload and arg size as the EL2 call. The firmware
@@ -416,10 +416,10 @@ static int zynqmp_firmware_bind(struct udevice *dev)
 	int ret;
 	struct udevice *child;
 
-	if ((IS_ENABLED(CONFIG_SPL_BUILD) &&
+	if ((IS_ENABLED(CONFIG_XPL_BUILD) &&
 	     IS_ENABLED(CONFIG_SPL_POWER_DOMAIN) &&
 	     IS_ENABLED(CONFIG_ZYNQMP_POWER_DOMAIN)) ||
-	     (!IS_ENABLED(CONFIG_SPL_BUILD) &&
+	     (!IS_ENABLED(CONFIG_XPL_BUILD) &&
 	      IS_ENABLED(CONFIG_ZYNQMP_POWER_DOMAIN))) {
 		ret = device_bind_driver_to_node(dev, "zynqmp_power_domain",
 						 "zynqmp_power_domain",
diff --git a/drivers/fpga/intel_sdm_mb.c b/drivers/fpga/intel_sdm_mb.c
index 45caef4f5c1..5a65bd98779 100644
--- a/drivers/fpga/intel_sdm_mb.c
+++ b/drivers/fpga/intel_sdm_mb.c
@@ -17,7 +17,7 @@
 #define RECONFIG_STATUS_POLL_RESP_TIMEOUT_MS		60000
 #define RECONFIG_STATUS_INTERVAL_DELAY_US		1000000
 
-#if !defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_ATF)
+#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_ATF)
 
 #define BITSTREAM_CHUNK_SIZE				0xFFFF0
 #define RECONFIG_STATUS_POLL_RETRY_MAX			100
diff --git a/drivers/fpga/zynqpl.c b/drivers/fpga/zynqpl.c
index 57467b4d975..3e86d854a01 100644
--- a/drivers/fpga/zynqpl.c
+++ b/drivers/fpga/zynqpl.c
@@ -414,13 +414,13 @@ static int zynq_load(xilinx_desc *desc, const void *buf, size_t bsize,
 	if (bstype != BIT_PARTIAL)
 		zynq_slcr_devcfg_enable();
 
-	if (!IS_ENABLED(CONFIG_SPL_BUILD))
+	if (!IS_ENABLED(CONFIG_XPL_BUILD))
 		puts("INFO:post config was not run, please run manually if needed\n");
 
 	return FPGA_SUCCESS;
 }
 
-#if defined(CONFIG_CMD_FPGA_LOADFS) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_CMD_FPGA_LOADFS) && !defined(CONFIG_XPL_BUILD)
 static int zynq_loadfs(xilinx_desc *desc, const void *buf, size_t bsize,
 		       fpga_fs_info *fsinfo)
 {
@@ -504,7 +504,7 @@ static int zynq_loadfs(xilinx_desc *desc, const void *buf, size_t bsize,
 
 struct xilinx_fpga_op zynq_op = {
 	.load = zynq_load,
-#if defined(CONFIG_CMD_FPGA_LOADFS) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_CMD_FPGA_LOADFS) && !defined(CONFIG_XPL_BUILD)
 	.loadfs = zynq_loadfs,
 #endif
 };
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index da0faf05246..990a670dd7b 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -3,7 +3,7 @@
 # Copyright 2000-2008
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_DWAPB_GPIO)	+= dwapb_gpio.o
 obj-$(CONFIG_AXP_GPIO)		+= axp_gpio.o
 obj-$(CONFIG_DM_74X164)		+= 74x164_gpio.o
diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
index 92ce68dd4a1..0213271e3a6 100644
--- a/drivers/gpio/gpio-uclass.c
+++ b/drivers/gpio/gpio-uclass.c
@@ -412,7 +412,7 @@ int dm_gpio_request(struct gpio_desc *desc, const char *label)
 
 static int dm_gpio_requestf(struct gpio_desc *desc, const char *fmt, ...)
 {
-#if !defined(CONFIG_SPL_BUILD) || !CONFIG_IS_ENABLED(USE_TINY_PRINTF)
+#if !defined(CONFIG_XPL_BUILD) || !CONFIG_IS_ENABLED(USE_TINY_PRINTF)
 	va_list args;
 	char buf[40];
 
@@ -461,7 +461,7 @@ int gpio_request(unsigned gpio, const char *label)
  */
 int gpio_requestf(unsigned gpio, const char *fmt, ...)
 {
-#if !defined(CONFIG_SPL_BUILD) || !CONFIG_IS_ENABLED(USE_TINY_PRINTF)
+#if !defined(CONFIG_XPL_BUILD) || !CONFIG_IS_ENABLED(USE_TINY_PRINTF)
 	va_list args;
 	char buf[40];
 
diff --git a/drivers/gpio/pca953x.c b/drivers/gpio/pca953x.c
index fc4dcf9f986..2fb14590c0f 100644
--- a/drivers/gpio/pca953x.c
+++ b/drivers/gpio/pca953x.c
@@ -143,7 +143,7 @@ int pca953x_get_val(uint8_t chip)
 	return (int)val;
 }
 
-#if defined(CONFIG_CMD_PCA953X) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_CMD_PCA953X) && !defined(CONFIG_XPL_BUILD)
 /*
  * Display pca953x information
  */
diff --git a/drivers/gpio/rk_gpio.c b/drivers/gpio/rk_gpio.c
index 24ba12dd820..57c49c75939 100644
--- a/drivers/gpio/rk_gpio.c
+++ b/drivers/gpio/rk_gpio.c
@@ -126,7 +126,7 @@ static int rockchip_gpio_get_function(struct udevice *dev, unsigned offset)
 }
 
 /* Simple SPL interface to GPIOs */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 enum {
 	PULL_NONE_1V8 = 0,
@@ -169,7 +169,7 @@ int spl_gpio_output(void *vregs, uint gpio, int value)
 
 	return 0;
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 static int rockchip_gpio_probe(struct udevice *dev)
 {
diff --git a/drivers/gpio/s5p_gpio.c b/drivers/gpio/s5p_gpio.c
index 83e65aa4aec..53dbbe97b5a 100644
--- a/drivers/gpio/s5p_gpio.c
+++ b/drivers/gpio/s5p_gpio.c
@@ -92,7 +92,7 @@ static void s5p_gpio_set_value(struct s5p_gpio_bank *bank, int gpio, int en)
 	writel(value, &bank->dat);
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* Common GPIO API - SPL does not support driver model yet */
 int gpio_set_value(unsigned gpio, int value)
 {
@@ -118,7 +118,7 @@ static unsigned int s5p_gpio_get_value(struct s5p_gpio_bank *bank, int gpio)
 	value = readl(&bank->dat);
 	return !!(value & DAT_MASK(gpio));
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 static void s5p_gpio_set_pull(struct s5p_gpio_bank *bank, int gpio, int mode)
 {
@@ -185,7 +185,7 @@ int s5p_gpio_get_pin(unsigned gpio)
 }
 
 /* Driver model interface */
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 /* set GPIO pin 'gpio' as an input */
 static int exynos_gpio_direction_input(struct udevice *dev, unsigned offset)
 {
@@ -230,7 +230,7 @@ static int exynos_gpio_set_value(struct udevice *dev, unsigned offset,
 
 	return 0;
 }
-#endif /* nCONFIG_SPL_BUILD */
+#endif /* nCONFIG_XPL_BUILD */
 
 /*
  * There is no common GPIO API for pull, drv, pin, rate (yet). These
@@ -260,7 +260,7 @@ void gpio_set_rate(int gpio, int mode)
 			  s5p_gpio_get_pin(gpio), mode);
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static int exynos_gpio_get_function(struct udevice *dev, unsigned offset)
 {
 	struct exynos_bank_info *state = dev_get_priv(dev);
diff --git a/drivers/gpio/sunxi_gpio.c b/drivers/gpio/sunxi_gpio.c
index 218ca2af397..2ca4960f17a 100644
--- a/drivers/gpio/sunxi_gpio.c
+++ b/drivers/gpio/sunxi_gpio.c
@@ -245,7 +245,7 @@ int sunxi_name_to_gpio(const char *name)
 {
 	unsigned int gpio;
 	int ret;
-#if !defined CONFIG_SPL_BUILD && defined CONFIG_AXP_GPIO
+#if !defined CONFIG_XPL_BUILD && defined CONFIG_AXP_GPIO
 	char lookup[8];
 
 	if (strcasecmp(name, "AXP0-VBUS-ENABLE") == 0) {
diff --git a/drivers/gpio/tca642x.c b/drivers/gpio/tca642x.c
index 1d45b500746..8307a07e14e 100644
--- a/drivers/gpio/tca642x.c
+++ b/drivers/gpio/tca642x.c
@@ -164,7 +164,7 @@ int tca642x_set_inital_state(uchar chip, struct tca642x_bank_info init_data[])
 	return ret;
 }
 
-#if defined(CONFIG_CMD_TCA642X) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_CMD_TCA642X) && !defined(CONFIG_XPL_BUILD)
 /*
  * Display tca642x information
  */
diff --git a/drivers/gpio/tegra_gpio.c b/drivers/gpio/tegra_gpio.c
index 0c40d36c41e..6cafffaad92 100644
--- a/drivers/gpio/tegra_gpio.c
+++ b/drivers/gpio/tegra_gpio.c
@@ -323,7 +323,7 @@ static int gpio_tegra_bind(struct udevice *parent)
 		return 0;
 
 	/* TODO(sjg@chromium.org): Remove once SPL supports device tree */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	ctlr = (struct gpio_ctlr *)NV_PA_GPIO_BASE;
 	bank_count = TEGRA_GPIO_BANKS;
 #else
diff --git a/drivers/input/Makefile b/drivers/input/Makefile
index 71f315adf6f..3e855346bce 100644
--- a/drivers/input/Makefile
+++ b/drivers/input/Makefile
@@ -8,7 +8,7 @@ obj-$(CONFIG_$(SPL_TPL_)OF_CONTROL) += key_matrix.o
 obj-$(CONFIG_$(SPL_TPL_)DM_KEYBOARD) += input.o keyboard-uclass.o
 obj-$(CONFIG_BUTTON_KEYBOARD) += button_kbd.o
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 
 obj-$(CONFIG_APPLE_SPI_KEYB) += apple_spi_kbd.o
 obj-$(CONFIG_I8042_KEYB) += i8042.o
diff --git a/drivers/mailbox/zynqmp-ipi.c b/drivers/mailbox/zynqmp-ipi.c
index 4df69734ed9..713d93a200c 100644
--- a/drivers/mailbox/zynqmp-ipi.c
+++ b/drivers/mailbox/zynqmp-ipi.c
@@ -108,7 +108,7 @@ static int zynqmp_ipi_send(struct mbox_chan *chan, const void *data)
 		writel(msg->buf[i], &mbx[i]);
 
 	/* Use SMC calls for Exception Level less than 3 where TF-A is available */
-	if (!IS_ENABLED(CONFIG_SPL_BUILD) && current_el() < 3) {
+	if (!IS_ENABLED(CONFIG_XPL_BUILD) && current_el() < 3) {
 		ret = zynqmp_ipi_fw_call(zynqmp, SMC_IPI_MAILBOX_NOTIFY, 0);
 
 		debug("%s, send %ld bytes\n", __func__, msg->len);
@@ -148,7 +148,7 @@ static int zynqmp_ipi_recv(struct mbox_chan *chan, void *data)
 		msg->buf[i] = readl(&mbx[i]);
 
 	/* Ack to remote if EL is not 3 */
-	if (!IS_ENABLED(CONFIG_SPL_BUILD) && current_el() < 3) {
+	if (!IS_ENABLED(CONFIG_XPL_BUILD) && current_el() < 3) {
 		ret = zynqmp_ipi_fw_call(zynqmp, SMC_IPI_MAILBOX_ACK,
 					 IPI_SMC_ACK_EIRQ_MASK);
 	}
@@ -168,7 +168,7 @@ static int zynqmp_ipi_dest_probe(struct udevice *dev)
 
 	node = dev_ofnode(dev);
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD) || of_machine_is_compatible("xlnx,zynqmp"))
+	if (IS_ENABLED(CONFIG_XPL_BUILD) || of_machine_is_compatible("xlnx,zynqmp"))
 		zynqmp->el3_supported = true;
 
 	ret = dev_read_u32(dev->parent, "xlnx,ipi-id", &zynqmp->local_id);
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e53d52c47b3..51ef51f1ed3 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_$(SPL_TPL_)CROS_EC) += cros_ec.o
 obj-$(CONFIG_$(SPL_TPL_)CROS_EC_SANDBOX) += cros_ec_sandbox.o
 obj-$(CONFIG_$(SPL_TPL_)CROS_EC_LPC) += cros_ec_lpc.o
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_SANDBOX) += sandbox_adder.o
 obj-$(CONFIG_CROS_EC_I2C) += cros_ec_i2c.o
 obj-$(CONFIG_CROS_EC_SPI) += cros_ec_spi.o
@@ -19,13 +19,13 @@ obj-$(CONFIG_SANDBOX) += swap_case.o
 endif
 
 ifdef CONFIG_$(SPL_)DM_I2C
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_SANDBOX) += i2c_eeprom_emul.o
 obj-$(CONFIG_USB_HUB_USB251XB) += usb251xb.o
 endif
 endif
 ifdef CONFIG_SPL_OF_PLATDATA
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_SANDBOX) += spltest_sandbox.o
 endif
 endif
diff --git a/drivers/misc/gsc.c b/drivers/misc/gsc.c
index feb02f97065..dee0bdd9663 100644
--- a/drivers/misc/gsc.c
+++ b/drivers/misc/gsc.c
@@ -389,7 +389,7 @@ static int gsc_probe(struct udevice *dev)
 	if (priv->rtc)
 		dev_set_priv(priv->rtc, priv);
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	gsc_banner(dev);
 #endif
 
diff --git a/drivers/misc/imx8/scu.c b/drivers/misc/imx8/scu.c
index bbd7e24200b..5d3db0bc4df 100644
--- a/drivers/misc/imx8/scu.c
+++ b/drivers/misc/imx8/scu.c
@@ -191,7 +191,7 @@ static int imx8_scu_probe(struct udevice *dev)
 	if (addr == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	plat->base = (struct mu_type *)CONFIG_MU_BASE_SPL;
 #else
 	plat->base = (struct mu_type *)addr;
diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
index 235c477c2e0..952201923d8 100644
--- a/drivers/mmc/Makefile
+++ b/drivers/mmc/Makefile
@@ -20,7 +20,7 @@ endif
 
 obj-$(CONFIG_SUPPORT_EMMC_BOOT) += mmc_boot.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_SPL_MMC_BOOT) += fsl_esdhc_spl.o
 endif
 
diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
index 83cdc9fd66d..c8db4f811c2 100644
--- a/drivers/mmc/mmc-uclass.c
+++ b/drivers/mmc/mmc-uclass.c
@@ -301,7 +301,7 @@ struct mmc *find_mmc_device(int dev_num)
 	ret = blk_find_device(UCLASS_MMC, dev_num, &dev);
 
 	if (ret) {
-#if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
 		printf("MMC Device %d not found\n", dev_num);
 #endif
 		return NULL;
@@ -373,7 +373,7 @@ void mmc_do_preinit(void)
 	}
 }
 
-#if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
 void print_mmc_devices(char separator)
 {
 	struct udevice *dev;
diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 96b0e20d669..55d24451e6e 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -328,7 +328,7 @@ int mmc_poll_for_busy(struct mmc *mmc, int timeout_ms)
 			break;
 
 		if (status & MMC_STATUS_MASK) {
-#if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
 			log_err("Status Error: %#08x\n", status);
 #endif
 			return -ECOMM;
@@ -341,7 +341,7 @@ int mmc_poll_for_busy(struct mmc *mmc, int timeout_ms)
 	}
 
 	if (timeout_ms <= 0) {
-#if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
 		log_err("Timeout waiting card ready\n");
 #endif
 		return -ETIMEDOUT;
@@ -483,7 +483,7 @@ static int mmc_read_blocks(struct mmc *mmc, void *dst, lbaint_t start,
 
 	if (blkcnt > 1) {
 		if (mmc_send_stop_transmission(mmc, false)) {
-#if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
 			log_err("mmc fail to send stop cmd\n");
 #endif
 			return 0;
@@ -534,7 +534,7 @@ ulong mmc_bread(struct blk_desc *block_dev, lbaint_t start, lbaint_t blkcnt,
 		return 0;
 
 	if ((start + blkcnt) > block_dev->lba) {
-#if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
 		log_err("MMC: block number 0x" LBAF " exceeds max(0x" LBAF ")\n",
 			start + blkcnt, block_dev->lba);
 #endif
@@ -2424,7 +2424,7 @@ static int mmc_startup_v4(struct mmc *mmc)
 		mmc->capacity_gp[i] <<= 19;
 	}
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	if (part_completed) {
 		mmc->enh_user_size =
 			(ext_csd[EXT_CSD_ENH_SIZE_MULT + 2] << 16) +
@@ -2723,7 +2723,7 @@ static int mmc_startup(struct mmc *mmc)
 	bdesc->blksz = mmc->read_bl_len;
 	bdesc->log2blksz = LOG2(bdesc->blksz);
 	bdesc->lba = lldiv(mmc->capacity, mmc->read_bl_len);
-#if !defined(CONFIG_SPL_BUILD) || \
+#if !defined(CONFIG_XPL_BUILD) || \
 		(defined(CONFIG_SPL_LIBCOMMON_SUPPORT) && \
 		!CONFIG_IS_ENABLED(USE_TINY_PRINTF))
 	sprintf(bdesc->vendor, "Man %06x Snr %04x%04x",
@@ -2741,7 +2741,7 @@ static int mmc_startup(struct mmc *mmc)
 	bdesc->revision[0] = 0;
 #endif
 
-#if !defined(CONFIG_DM_MMC) && (!defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBDISK_SUPPORT))
+#if !defined(CONFIG_DM_MMC) && (!defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBDISK_SUPPORT))
 	part_init(bdesc);
 #endif
 
@@ -2953,7 +2953,7 @@ retry:
 		err = mmc_send_op_cond(mmc);
 
 		if (err) {
-#if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
 			if (!quiet)
 				log_err("Card did not respond to voltage select! : %d\n",
 					err);
@@ -3008,7 +3008,7 @@ int mmc_start_init(struct mmc *mmc)
 #endif
 	if (no_card) {
 		mmc->has_init = 0;
-#if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
 		log_err("MMC: no card present\n");
 #endif
 		return -ENOMEDIUM;
@@ -3195,7 +3195,7 @@ int mmc_initialize(struct bd_info *bis)
 	if (ret)
 		return ret;
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	print_mmc_devices(',');
 #endif
 
diff --git a/drivers/mmc/mmc_legacy.c b/drivers/mmc/mmc_legacy.c
index a87d2276c1b..8f8ba34be71 100644
--- a/drivers/mmc/mmc_legacy.c
+++ b/drivers/mmc/mmc_legacy.c
@@ -44,7 +44,7 @@ struct mmc *find_mmc_device(int dev_num)
 			return m;
 	}
 
-#if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
 	printf("MMC Device %d not found\n", dev_num);
 #endif
 
@@ -93,7 +93,7 @@ void mmc_list_add(struct mmc *mmc)
 	list_add_tail(&mmc->link, &mmc_devices);
 }
 
-#if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
 void print_mmc_devices(char separator)
 {
 	struct mmc *m;
diff --git a/drivers/mmc/mmc_private.h b/drivers/mmc/mmc_private.h
index b32123758ea..fc45f017e5d 100644
--- a/drivers/mmc/mmc_private.h
+++ b/drivers/mmc/mmc_private.h
@@ -67,7 +67,7 @@ static inline ulong mmc_bwrite(struct blk_desc *block_dev, lbaint_t start,
 }
 #endif
 
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #ifdef CONFIG_MMC_TRACE
 void mmmc_trace_before_send(struct mmc *mmc, struct mmc_cmd *cmd);
diff --git a/drivers/mmc/omap_hsmmc.c b/drivers/mmc/omap_hsmmc.c
index 8e51453d2ae..e66ab25d02a 100644
--- a/drivers/mmc/omap_hsmmc.c
+++ b/drivers/mmc/omap_hsmmc.c
@@ -59,8 +59,8 @@
 DECLARE_GLOBAL_DATA_PTR;
 
 /* simplify defines to OMAP_HSMMC_USE_GPIO */
-#if (defined(CONFIG_OMAP_GPIO) && !defined(CONFIG_SPL_BUILD)) || \
-	(defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_GPIO))
+#if (defined(CONFIG_OMAP_GPIO) && !defined(CONFIG_XPL_BUILD)) || \
+	(defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_GPIO))
 #define OMAP_HSMMC_USE_GPIO
 #else
 #undef OMAP_HSMMC_USE_GPIO
diff --git a/drivers/mmc/rockchip_dw_mmc.c b/drivers/mmc/rockchip_dw_mmc.c
index fb77b049834..ca5752d24f1 100644
--- a/drivers/mmc/rockchip_dw_mmc.c
+++ b/drivers/mmc/rockchip_dw_mmc.c
@@ -83,7 +83,7 @@ static int rockchip_dwmmc_of_to_plat(struct udevice *dev)
 		return -EINVAL;
 	priv->fifo_mode = dev_read_bool(dev, "fifo-mode");
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	if (!priv->fifo_mode)
 		priv->fifo_mode = dev_read_bool(dev, "u-boot,spl-fifo-mode");
 #endif
diff --git a/drivers/mmc/rockchip_sdhci.c b/drivers/mmc/rockchip_sdhci.c
index 35667b86b50..a25bcaf017f 100644
--- a/drivers/mmc/rockchip_sdhci.c
+++ b/drivers/mmc/rockchip_sdhci.c
@@ -609,7 +609,7 @@ static int rockchip_sdhci_probe(struct udevice *dev)
 	 * Disable use of DMA and force use of PIO mode in SPL to fix an issue
 	 * where loading part of TF-A into SRAM using DMA silently fails.
 	 */
-	if (IS_ENABLED(CONFIG_SPL_BUILD) &&
+	if (IS_ENABLED(CONFIG_XPL_BUILD) &&
 	    dev_read_bool(dev, "u-boot,spl-fifo-mode"))
 		host->flags &= ~USE_DMA;
 
diff --git a/drivers/mmc/socfpga_dw_mmc.c b/drivers/mmc/socfpga_dw_mmc.c
index 3147d3019c0..9dc1ceaa09b 100644
--- a/drivers/mmc/socfpga_dw_mmc.c
+++ b/drivers/mmc/socfpga_dw_mmc.c
@@ -61,7 +61,7 @@ static int socfpga_dwmci_clksel(struct dwmci_host *host)
 	debug("%s: drvsel %d smplsel %d\n", __func__,
 	      priv->drvsel, priv->smplsel);
 
-#if !defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_ATF)
+#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_ATF)
 	int ret;
 
 	ret = socfpga_secure_reg_write32(SOCFPGA_SECURE_REG_SYSMGR_SOC64_SDMMC,
diff --git a/drivers/mmc/tmio-common.c b/drivers/mmc/tmio-common.c
index 0b396122b46..9fff1bc1a10 100644
--- a/drivers/mmc/tmio-common.c
+++ b/drivers/mmc/tmio-common.c
@@ -385,7 +385,7 @@ static bool tmio_sd_addr_is_dmaable(struct mmc_data *data)
 			return false;
 	}
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	if (IS_ENABLED(CONFIG_ARCH_UNIPHIER) && !IS_ENABLED(CONFIG_ARM64)) {
 		/*
 		 * For UniPhier ARMv7 SoCs, the stack is allocated in locked
diff --git a/drivers/mmc/uniphier-sd.c b/drivers/mmc/uniphier-sd.c
index 5b3650d52ee..cc89ff767ab 100644
--- a/drivers/mmc/uniphier-sd.c
+++ b/drivers/mmc/uniphier-sd.c
@@ -36,7 +36,7 @@ static ulong uniphier_sd_clk_get_rate(struct tmio_sd_priv *priv)
 {
 #if CONFIG_IS_ENABLED(CLK)
 	return clk_get_rate(&priv->clk);
-#elif CONFIG_SPL_BUILD
+#elif CONFIG_XPL_BUILD
 	return 100000000;
 #else
 	return 0;
@@ -50,7 +50,7 @@ static int uniphier_sd_probe(struct udevice *dev)
 	priv->clk_get_rate = uniphier_sd_clk_get_rate;
 	priv->read_poll_flag = TMIO_SD_DMA_INFO1_END_RD2;
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	int ret;
 
 	ret = clk_get_by_index(dev, 0, &priv->clk);
diff --git a/drivers/mmc/zynq_sdhci.c b/drivers/mmc/zynq_sdhci.c
index 24d0556cd37..0e2bdab4e7e 100644
--- a/drivers/mmc/zynq_sdhci.c
+++ b/drivers/mmc/zynq_sdhci.c
@@ -289,7 +289,7 @@ static inline int arasan_zynqmp_set_in_tapdelay(u32 node_id, u32 itap_delay)
 {
 	int ret;
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD) || current_el() == 3) {
+	if (IS_ENABLED(CONFIG_XPL_BUILD) || current_el() == 3) {
 		if (node_id == NODE_SD_0) {
 			ret = zynqmp_mmio_write(SD_ITAP_DLY, SD0_ITAPCHGWIN,
 						SD0_ITAPCHGWIN);
@@ -339,7 +339,7 @@ static inline int arasan_zynqmp_set_in_tapdelay(u32 node_id, u32 itap_delay)
 
 static inline int arasan_zynqmp_set_out_tapdelay(u32 node_id, u32 otap_delay)
 {
-	if (IS_ENABLED(CONFIG_SPL_BUILD) || current_el() == 3) {
+	if (IS_ENABLED(CONFIG_XPL_BUILD) || current_el() == 3) {
 		if (node_id == NODE_SD_0)
 			return zynqmp_mmio_write(SD_OTAP_DLY,
 						 SD0_OTAPDLYSEL_MASK,
@@ -356,7 +356,7 @@ static inline int arasan_zynqmp_set_out_tapdelay(u32 node_id, u32 otap_delay)
 
 static inline int zynqmp_dll_reset(u32 node_id, u32 type)
 {
-	if (IS_ENABLED(CONFIG_SPL_BUILD) || current_el() == 3) {
+	if (IS_ENABLED(CONFIG_XPL_BUILD) || current_el() == 3) {
 		if (node_id == NODE_SD_0)
 			return zynqmp_mmio_write(SD_DLL_CTRL, SD0_DLL_RST,
 						 type == PM_DLL_RESET_ASSERT ?
diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
index 10d575e9f93..db010417b86 100644
--- a/drivers/mtd/Makefile
+++ b/drivers/mtd/Makefile
@@ -16,7 +16,7 @@ mtd-$(CONFIG_RENESAS_RPC_HF) += renesas_rpc_hf.o
 mtd-$(CONFIG_HBMC_AM654) += hbmc-am654.o
 
 # U-Boot build
-ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)
+ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
 
 ifneq ($(mtd-y),)
 obj-y += mtd.o
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index 96e186600a1..68b53dced1b 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)
+ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
 nandcore-objs := core.o bbt.o
 obj-$(CONFIG_MTD_NAND_CORE) += nandcore.o
 obj-$(CONFIG_MTD_RAW_NAND) += raw/
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 46fead6fa48..ca10ac7aecb 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2006
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 
 ifdef CONFIG_SPL_NAND_DRIVERS
 NORMAL_DRIVERS=y
diff --git a/drivers/mtd/nand/raw/atmel_nand.c b/drivers/mtd/nand/raw/atmel_nand.c
index 4dbf7b47135..605298628d6 100644
--- a/drivers/mtd/nand/raw/atmel_nand.c
+++ b/drivers/mtd/nand/raw/atmel_nand.c
@@ -1251,7 +1251,7 @@ static int at91_nand_ready(struct mtd_info *mtd)
 }
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* The following code is for SPL */
 static struct mtd_info *mtd;
 static struct nand_chip nand_chip;
@@ -1526,4 +1526,4 @@ void board_nand_init(void)
 		if (atmel_nand_chip_init(i, base_addr[i]))
 			log_err("atmel_nand: Fail to initialize #%d chip", i);
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
diff --git a/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c b/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c
index c89661badbf..4430c4e93ee 100644
--- a/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c
@@ -152,7 +152,7 @@ static void lpc32xx_nand_init(void)
 		&lpc32xx_nand_mlc_registers->time_reg);
 }
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 
 /**
  * lpc32xx_cmd_ctrl - write command to either cmd or data register
@@ -606,7 +606,7 @@ void board_nand_init(void)
 		pr_err("nand_register returned %i", ret);
 }
 
-#else /* defined(CONFIG_SPL_BUILD) */
+#else /* defined(CONFIG_XPL_BUILD) */
 
 void nand_init(void)
 {
@@ -770,4 +770,4 @@ unsigned int nand_page_size(void)
 	return BYTES_PER_PAGE;
 }
 
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
diff --git a/drivers/mtd/nand/raw/lpc32xx_nand_slc.c b/drivers/mtd/nand/raw/lpc32xx_nand_slc.c
index 4d643bc64bc..109c31fb4d1 100644
--- a/drivers/mtd/nand/raw/lpc32xx_nand_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_nand_slc.c
@@ -84,7 +84,7 @@ static struct nand_ecclayout lpc32xx_nand_oob_16 = {
 	}
 };
 
-#if defined(CONFIG_DMA_LPC32XX) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_DMA_LPC32XX) && !defined(CONFIG_XPL_BUILD)
 #define ECCSTEPS	(CONFIG_SYS_NAND_PAGE_SIZE / CFG_SYS_NAND_ECCSIZE)
 
 /*
@@ -162,7 +162,7 @@ static int lpc32xx_nand_dev_ready(struct mtd_info *mtd)
 	return readl(&lpc32xx_nand_slc_regs->stat) & STAT_NAND_READY;
 }
 
-#if defined(CONFIG_DMA_LPC32XX) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_DMA_LPC32XX) && !defined(CONFIG_XPL_BUILD)
 /*
  * Prepares DMA descriptors for NAND RD/WR operations
  * If the size is < 256 Bytes then it is assumed to be
@@ -510,7 +510,7 @@ static void lpc32xx_write_byte(struct mtd_info *mtd, uint8_t byte)
  */
 int board_nand_init(struct nand_chip *lpc32xx_chip)
 {
-#if defined(CONFIG_DMA_LPC32XX) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_DMA_LPC32XX) && !defined(CONFIG_XPL_BUILD)
 	int ret;
 
 	/* Acquire a channel for our use */
@@ -533,7 +533,7 @@ int board_nand_init(struct nand_chip *lpc32xx_chip)
 	lpc32xx_chip->read_byte  = lpc32xx_read_byte;
 	lpc32xx_chip->write_byte = lpc32xx_write_byte;
 
-#if defined(CONFIG_DMA_LPC32XX) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_DMA_LPC32XX) && !defined(CONFIG_XPL_BUILD)
 	/* Hardware ECC calculation is supported when DMA driver is selected */
 	lpc32xx_chip->ecc.mode		= NAND_ECC_HW;
 
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 0545c23e268..1b65c6f6443 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -414,7 +414,7 @@ static int nand_block_markbad_lowlevel(struct mtd_info *mtd, loff_t ofs)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
 	int ret = 0;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	int res;
 #endif
 
@@ -434,7 +434,7 @@ static int nand_block_markbad_lowlevel(struct mtd_info *mtd, loff_t ofs)
 		nand_release_device(mtd);
 	}
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	/* Mark block bad in BBT */
 	if (chip->bbt) {
 		res = nand_markbad_bbt(mtd, ofs);
@@ -488,7 +488,7 @@ static int nand_block_isreserved(struct mtd_info *mtd, loff_t ofs)
 	if (!chip->bbt)
 		return 0;
 	/* Return info from the table */
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	return nand_isreserved_bbt(mtd, ofs);
 #else
 	return 0;
@@ -518,7 +518,7 @@ static int nand_block_checkbad(struct mtd_info *mtd, loff_t ofs, int allowbbt)
 		return chip->block_bad(mtd, ofs);
 
 	/* Return info from the table */
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	return nand_isbad_bbt(mtd, ofs, allowbbt);
 #else
 	return 0;
@@ -3729,7 +3729,7 @@ static void nand_set_defaults(struct nand_chip *chip, int busw)
 	if (!chip->read_buf || chip->read_buf == nand_read_buf)
 		chip->read_buf = busw ? nand_read_buf16 : nand_read_buf;
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	if (!chip->scan_bbt)
 		chip->scan_bbt = nand_default_bbt;
 #endif
diff --git a/drivers/mtd/nand/raw/omap_gpmc.c b/drivers/mtd/nand/raw/omap_gpmc.c
index a36e2a148cc..9c704c60e8e 100644
--- a/drivers/mtd/nand/raw/omap_gpmc.c
+++ b/drivers/mtd/nand/raw/omap_gpmc.c
@@ -1011,7 +1011,7 @@ static int omap_select_ecc_scheme(struct nand_chip *nand,
 	return 0;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 /*
  * omap_nand_switch_ecc - switch the ECC operation between different engines
  * (h/w and s/w) and different algorithms (hamming and BCHx)
@@ -1072,7 +1072,7 @@ int __maybe_unused omap_nand_switch_ecc(uint32_t hardware, uint32_t eccstrength)
 		err = nand_scan_tail(mtd);
 	return err;
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 /*
  * Board-specific NAND initialization. The following members of the
diff --git a/drivers/mtd/nand/raw/sand_nand.c b/drivers/mtd/nand/raw/sand_nand.c
index 456e841b1c4..3678bb8a41b 100644
--- a/drivers/mtd/nand/raw/sand_nand.c
+++ b/drivers/mtd/nand/raw/sand_nand.c
@@ -680,7 +680,7 @@ void board_nand_init(void)
 		log_info("Failed to get sandbox NAND: %d\n", err);
 }
 
-#if IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_SPL_NAND_INIT)
+#if IS_ENABLED(CONFIG_XPL_BUILD) && IS_ENABLED(CONFIG_SPL_NAND_INIT)
 void nand_deselect(void)
 {
 	nand_chip->select_chip(nand_to_mtd(nand_chip), -1);
diff --git a/drivers/mtd/onenand/Makefile b/drivers/mtd/onenand/Makefile
index 4dc417a5794..7f4a8514c17 100644
--- a/drivers/mtd/onenand/Makefile
+++ b/drivers/mtd/onenand/Makefile
@@ -3,7 +3,7 @@
 # Copyright (C) 2005-2007 Samsung Electronics.
 # Kyungmin Park <kyungmin.park@samsung.com>
 
-ifndef	CONFIG_SPL_BUILD
+ifndef	CONFIG_XPL_BUILD
 obj-$(CONFIG_CMD_ONENAND)	:= onenand_uboot.o onenand_base.o onenand_bbt.o
 obj-$(CONFIG_SAMSUNG_ONENAND)	+= samsung.o
 else
diff --git a/drivers/mtd/spi/Makefile b/drivers/mtd/spi/Makefile
index 409395382f5..2a287a62a47 100644
--- a/drivers/mtd/spi/Makefile
+++ b/drivers/mtd/spi/Makefile
@@ -6,7 +6,7 @@
 obj-$(CONFIG_$(SPL_TPL_)DM_SPI_FLASH) += sf-uclass.o
 spi-nor-y := sf_probe.o spi-nor-ids.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_SPL_SPI_BOOT)	+= fsl_espi_spl.o
 ifeq ($(CONFIG_$(SPL_TPL_)SPI_FLASH_TINY),y)
 spi-nor-y += spi-nor-tiny.o
diff --git a/drivers/mtd/spi/sf-uclass.c b/drivers/mtd/spi/sf-uclass.c
index a4d15bd64aa..102a9236826 100644
--- a/drivers/mtd/spi/sf-uclass.c
+++ b/drivers/mtd/spi/sf-uclass.c
@@ -54,7 +54,7 @@ struct spi_flash *spi_flash_probe(unsigned int busnum, unsigned int cs,
 	struct udevice *bus;
 	char *str;
 
-#if defined(CONFIG_SPL_BUILD) && CONFIG_IS_ENABLED(USE_TINY_PRINTF)
+#if defined(CONFIG_XPL_BUILD) && CONFIG_IS_ENABLED(USE_TINY_PRINTF)
 	str = "spi_flash";
 #else
 	char name[30];
diff --git a/drivers/mtd/spi/sf_dataflash.c b/drivers/mtd/spi/sf_dataflash.c
index 6db24189c8e..438eb3698d5 100644
--- a/drivers/mtd/spi/sf_dataflash.c
+++ b/drivers/mtd/spi/sf_dataflash.c
@@ -438,7 +438,7 @@ static int add_dataflash(struct udevice *dev, char *name, int nr_pages,
 	spi_flash->size = nr_pages * pagesize;
 	spi_flash->erase_size = pagesize;
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	printf("SPI DataFlash: Detected %s with page size ", spi_flash->name);
 	print_size(spi_flash->page_size, ", erase size ");
 	print_size(spi_flash->erase_size, ", total ");
diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 8f7a77e7169..b29b390a0ae 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -1030,7 +1030,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 
 	while (len) {
 		schedule();
-		if (!IS_ENABLED(CONFIG_SPL_BUILD) && ctrlc()) {
+		if (!IS_ENABLED(CONFIG_XPL_BUILD) && ctrlc()) {
 			addr_known = false;
 			ret = -EINTR;
 			goto erase_err;
@@ -4262,7 +4262,7 @@ int spi_nor_scan(struct spi_nor *nor)
 	nor->erase_size = mtd->erasesize;
 	nor->sector_size = mtd->erasesize;
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	printf("SF: Detected %s with page size ", nor->name);
 	print_size(nor->page_size, ", erase size ");
 	print_size(nor->erase_size, ", total ");
diff --git a/drivers/net/dwc_eth_xgmac_socfpga.c b/drivers/net/dwc_eth_xgmac_socfpga.c
index 270c1b0ca6c..87fb7e887e7 100644
--- a/drivers/net/dwc_eth_xgmac_socfpga.c
+++ b/drivers/net/dwc_eth_xgmac_socfpga.c
@@ -37,7 +37,7 @@ static int dwxgmac_socfpga_do_setphy(struct udevice *dev, u32 modereg)
 	u32 modemask = SYSMGR_EMACGRP_CTRL_PHYSEL_MASK <<
 		       xgmac->syscon_phy_regshift;
 
-	if (!(IS_ENABLED(CONFIG_SPL_BUILD)) && IS_ENABLED(CONFIG_SPL_ATF)) {
+	if (!(IS_ENABLED(CONFIG_XPL_BUILD)) && IS_ENABLED(CONFIG_SPL_ATF)) {
 		u32 index = ((u64)xgmac->syscon_phy - socfpga_get_sysmgr_addr() -
 			     SYSMGR_SOC64_EMAC0) >> 2;
 
diff --git a/drivers/net/dwmac_socfpga.c b/drivers/net/dwmac_socfpga.c
index bba3fc4d34b..a9e2d8c0972 100644
--- a/drivers/net/dwmac_socfpga.c
+++ b/drivers/net/dwmac_socfpga.c
@@ -68,7 +68,7 @@ static int dwmac_socfpga_do_setphy(struct udevice *dev, u32 modereg)
 	struct dwmac_socfpga_plat *pdata = dev_get_plat(dev);
 	u32 modemask = SYSMGR_EMACGRP_CTRL_PHYSEL_MASK << pdata->reg_shift;
 
-#if !defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_ATF)
+#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_ATF)
 	u32 index = ((u64)pdata->phy_intf - socfpga_get_sysmgr_addr() -
 		     SYSMGR_SOC64_EMAC0) >> 2;
 
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index ede3959c94f..2c373c7c12e 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -671,7 +671,7 @@ const struct pinctrl_ops mtk_pinctrl_ops = {
 };
 
 #if CONFIG_IS_ENABLED(DM_GPIO) || \
-    (defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_GPIO))
+    (defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_GPIO))
 static int mtk_gpio_get(struct udevice *dev, unsigned int off)
 {
 	int val, err;
@@ -814,7 +814,7 @@ int mtk_pinctrl_common_probe(struct udevice *dev,
 	}
 
 #if CONFIG_IS_ENABLED(DM_GPIO) || \
-    (defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_GPIO))
+    (defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_GPIO))
 	ret = mtk_gpiochip_register(dev);
 #endif
 
diff --git a/drivers/pinctrl/pinctrl_stm32.c b/drivers/pinctrl/pinctrl_stm32.c
index eada1001240..fbf0271f08a 100644
--- a/drivers/pinctrl/pinctrl_stm32.c
+++ b/drivers/pinctrl/pinctrl_stm32.c
@@ -39,7 +39,7 @@ struct stm32_gpio_bank {
 	struct list_head list;
 };
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 
 static char pin_name[PINNAME_SIZE];
 static const char * const pinmux_mode[GPIOF_COUNT] = {
@@ -488,7 +488,7 @@ static struct pinctrl_ops stm32_pinctrl_ops = {
 #else /* PINCTRL_FULL */
 	.set_state_simple	= stm32_pinctrl_set_state_simple,
 #endif /* PINCTRL_FULL */
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	.get_pin_name		= stm32_pinctrl_get_pin_name,
 	.get_pins_count		= stm32_pinctrl_get_pins_count,
 	.get_pin_muxing		= stm32_pinctrl_get_pin_muxing,
diff --git a/drivers/pinctrl/tegra/Makefile b/drivers/pinctrl/tegra/Makefile
index 75d3cabc62b..b1dda417475 100644
--- a/drivers/pinctrl/tegra/Makefile
+++ b/drivers/pinctrl/tegra/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 ifdef CONFIG_TEGRA20
 obj-y += pinctrl-tegra20.o
 else
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier.h b/drivers/pinctrl/uniphier/pinctrl-uniphier.h
index 5951835d6e8..da7bb4f6377 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier.h
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier.h
@@ -126,7 +126,7 @@ struct uniphier_pinctrl_socdata {
 
 #define __UNIPHIER_PINMUX_FUNCTION(func)	#func
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	/*
 	 * a tricky way to drop unneeded *_pins and *_muxvals arrays from SPL,
 	 * suppressing "defined but not used" warnings.
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index 6f7e6fb0a6b..5a987194cda 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -9,7 +9,7 @@ obj-y += pmic/
 obj-y += regulator/
 
 obj-$(CONFIG_AXP221_POWER)	+= axp221.o
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_AXP152_POWER)	+= axp152.o
 obj-$(CONFIG_AXP209_POWER)	+= axp209.o
 obj-$(CONFIG_AXP305_POWER)	+= axp_spl.o
diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
index 4d5a5ceafad..a14555cf472 100644
--- a/drivers/power/pmic/rk8xx.c
+++ b/drivers/power/pmic/rk8xx.c
@@ -237,7 +237,7 @@ static int rk8xx_bind(struct udevice *dev)
 	if (!children)
 		debug("%s: %s - no child found\n", __func__, dev->name);
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD) &&
+	if (IS_ENABLED(CONFIG_XPL_BUILD) &&
 	    IS_ENABLED(CONFIG_ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON))
 		dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
 
@@ -331,7 +331,7 @@ static int rk8xx_probe(struct udevice *dev)
 		      pmic_reg_read(dev, init_data[i].reg));
 	}
 
-	if (!IS_ENABLED(CONFIG_SPL_BUILD)) {
+	if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
 		printf("PMIC:  RK%x ", show_variant);
 		if (on_source && off_source)
 			printf("(on=0x%02x, off=0x%02x)",
diff --git a/drivers/power/pmic/stpmic1.c b/drivers/power/pmic/stpmic1.c
index c99a0c27b33..f0415fbd172 100644
--- a/drivers/power/pmic/stpmic1.c
+++ b/drivers/power/pmic/stpmic1.c
@@ -91,7 +91,7 @@ static int stpmic1_bind(struct udevice *dev)
 		dev_dbg(dev, "no child found\n");
 #endif /* DM_REGULATOR */
 
-	if (!IS_ENABLED(CONFIG_SPL_BUILD)) {
+	if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
 		ret = device_bind_driver(dev, "stpmic1-nvm",
 					 "stpmic1-nvm", NULL);
 		if (ret)
@@ -124,7 +124,7 @@ U_BOOT_DRIVER(pmic_stpmic1) = {
 	.ops = &stpmic1_ops,
 };
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static int stpmic1_nvm_rw(struct udevice *dev, u8 addr, u8 *buf, int buf_len,
 			  enum pmic_nvm_op op)
 {
@@ -230,7 +230,7 @@ U_BOOT_DRIVER(stpmic1_nvm) = {
 	.id = UCLASS_MISC,
 	.ops = &stpmic1_nvm_ops,
 };
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #ifdef CONFIG_SYSRESET
 static int stpmic1_sysreset_request(struct udevice *dev, enum sysreset_t type)
diff --git a/drivers/power/power_core.c b/drivers/power/power_core.c
index 1caf9f09346..61b2fe5f54a 100644
--- a/drivers/power/power_core.c
+++ b/drivers/power/power_core.c
@@ -78,7 +78,7 @@ struct pmic *pmic_get(const char *s)
 	return NULL;
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static int pmic_dump(struct pmic *p)
 {
 	int i, ret;
diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
index 34e61511d88..3f18ee65ce0 100644
--- a/drivers/power/regulator/rk8xx.c
+++ b/drivers/power/regulator/rk8xx.c
@@ -16,7 +16,7 @@
 #include <power/pmic.h>
 #include <power/regulator.h>
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #define ENABLE_DRIVER
 #endif
 
diff --git a/drivers/power/sy8106a.c b/drivers/power/sy8106a.c
index fb6028de71a..d9a2b6904b0 100644
--- a/drivers/power/sy8106a.c
+++ b/drivers/power/sy8106a.c
@@ -10,7 +10,7 @@
 #define SY8106A_VOUT1_SEL 1
 #define SY8106A_VOUT1_SEL_ENABLE (1 << 7)
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 static u8 sy8106a_mvolt_to_cfg(int mvolt, int min, int max, int div)
 {
 	if (mvolt < min)
diff --git a/drivers/ram/Makefile b/drivers/ram/Makefile
index fdb2e78ec9e..35d8f5761e1 100644
--- a/drivers/ram/Makefile
+++ b/drivers/ram/Makefile
@@ -20,7 +20,7 @@ obj-$(CONFIG_K3_DDRSS) += k3-ddrss/
 obj-$(CONFIG_IMXRT_SDRAM) += imxrt_sdram.o
 
 obj-$(CONFIG_RAM_SIFIVE) += sifive/
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_SPL_STARFIVE_DDR) += starfive/
 endif
 
diff --git a/drivers/ram/mediatek/ddr3-mt7629.c b/drivers/ram/mediatek/ddr3-mt7629.c
index c27c4593b9d..e9791697066 100644
--- a/drivers/ram/mediatek/ddr3-mt7629.c
+++ b/drivers/ram/mediatek/ddr3-mt7629.c
@@ -233,7 +233,7 @@ struct mtk_ddr3_priv {
 	struct clk mem_mux;
 };
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 static int mtk_ddr3_rank_size_detect(struct udevice *dev)
 {
 	struct mtk_ddr3_priv *priv = dev_get_priv(dev);
@@ -697,7 +697,7 @@ static int mtk_ddr3_probe(struct udevice *dev)
 	if (priv->dramc_ao == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	int ret;
 
 	ret = clk_get_by_index(dev, 0, &priv->phy);
diff --git a/drivers/ram/rockchip/sdram_rk3188.c b/drivers/ram/rockchip/sdram_rk3188.c
index 618bce5c9f4..ffff7d55f33 100644
--- a/drivers/ram/rockchip/sdram_rk3188.c
+++ b/drivers/ram/rockchip/sdram_rk3188.c
@@ -84,7 +84,7 @@ const int ddrconf_table[] = {
 #define DQS_GATE_TRAINING_ERROR_RANK0	(1 << 4)
 #define DQS_GATE_TRAINING_ERROR_RANK1	(2 << 4)
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 static void copy_to_reg(u32 *dest, const u32 *src, u32 n)
 {
 	int i;
@@ -851,7 +851,7 @@ static int rk3188_dmc_of_to_plat(struct udevice *dev)
 
 	return 0;
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #if CONFIG_IS_ENABLED(OF_PLATDATA)
 static int conv_of_plat(struct udevice *dev)
@@ -878,7 +878,7 @@ static int conv_of_plat(struct udevice *dev)
 
 static int rk3188_dmc_probe(struct udevice *dev)
 {
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	struct rk3188_sdram_params *plat = dev_get_plat(dev);
 	struct regmap *map;
 	struct udevice *dev_clk;
@@ -888,7 +888,7 @@ static int rk3188_dmc_probe(struct udevice *dev)
 
 	priv->pmu = syscon_get_first_range(ROCKCHIP_SYSCON_PMU);
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #if CONFIG_IS_ENABLED(OF_PLATDATA)
 	ret = conv_of_plat(dev);
 	if (ret)
@@ -950,12 +950,12 @@ U_BOOT_DRIVER(rockchip_rk3188_dmc) = {
 	.id = UCLASS_RAM,
 	.of_match = rk3188_dmc_ids,
 	.ops = &rk3188_dmc_ops,
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	.of_to_plat = rk3188_dmc_of_to_plat,
 #endif
 	.probe = rk3188_dmc_probe,
 	.priv_auto	= sizeof(struct dram_info),
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	.plat_auto	= sizeof(struct rk3188_sdram_params),
 #endif
 };
diff --git a/drivers/ram/rockchip/sdram_rk3288.c b/drivers/ram/rockchip/sdram_rk3288.c
index c9f61e933e9..25ceab98ee9 100644
--- a/drivers/ram/rockchip/sdram_rk3288.c
+++ b/drivers/ram/rockchip/sdram_rk3288.c
@@ -84,7 +84,7 @@ const int ddrconf_table[] = {
 #define DQS_GATE_TRAINING_ERROR_RANK1	(2 << 4)
 
 #if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
+	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
 static void copy_to_reg(u32 *dest, const u32 *src, u32 n)
 {
 	int i;
@@ -1013,7 +1013,7 @@ static int rk3288_dmc_of_to_plat(struct udevice *dev)
 
 	return 0;
 }
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #if CONFIG_IS_ENABLED(OF_PLATDATA)
 static int conv_of_plat(struct udevice *dev)
@@ -1041,7 +1041,7 @@ static int conv_of_plat(struct udevice *dev)
 static int rk3288_dmc_probe(struct udevice *dev)
 {
 #if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
+	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
 	struct rk3288_sdram_params *plat = dev_get_plat(dev);
 	struct udevice *dev_clk;
 	struct regmap *map;
@@ -1051,7 +1051,7 @@ static int rk3288_dmc_probe(struct udevice *dev)
 
 	priv->pmu = syscon_get_first_range(ROCKCHIP_SYSCON_PMU);
 #if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
+	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
 #if CONFIG_IS_ENABLED(OF_PLATDATA)
 	ret = conv_of_plat(dev);
 	if (ret)
@@ -1119,13 +1119,13 @@ U_BOOT_DRIVER(rockchip_rk3288_dmc) = {
 	.of_match = rk3288_dmc_ids,
 	.ops = &rk3288_dmc_ops,
 #if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
+	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
 	.of_to_plat = rk3288_dmc_of_to_plat,
 #endif
 	.probe = rk3288_dmc_probe,
 	.priv_auto	= sizeof(struct dram_info),
 #if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
+	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
 	.plat_auto	= sizeof(struct rk3288_sdram_params),
 #endif
 };
diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
index 5676c099a43..6fa8f268770 100644
--- a/drivers/ram/rockchip/sdram_rk3399.c
+++ b/drivers/ram/rockchip/sdram_rk3399.c
@@ -3196,7 +3196,7 @@ U_BOOT_DRIVER(dmc_rk3399) = {
 	.probe = rk3399_dmc_probe,
 	.priv_auto	= sizeof(struct dram_info),
 #if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
+	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
 	.plat_auto	= sizeof(struct rockchip_dmc_plat),
 #endif
 };
diff --git a/drivers/ram/rockchip/sdram_rv1126.c b/drivers/ram/rockchip/sdram_rv1126.c
index 4fbb088a8d9..b371f597d23 100644
--- a/drivers/ram/rockchip/sdram_rv1126.c
+++ b/drivers/ram/rockchip/sdram_rv1126.c
@@ -34,7 +34,7 @@
 
 struct dram_info {
 #if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
+	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
 	void __iomem *pctl;
 	void __iomem *phy;
 	struct rv1126_cru *cru;
@@ -49,7 +49,7 @@ struct dram_info {
 };
 
 #if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
+	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
 
 #define GRF_BASE_ADDR			0xfe000000
 #define PMU_GRF_BASE_ADDR		0xfe020000
@@ -3507,7 +3507,7 @@ error:
 static int rv1126_dmc_probe(struct udevice *dev)
 {
 #if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
+	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
 	if (rv1126_dmc_init(dev))
 		return 0;
 #else
diff --git a/drivers/ram/sifive/sifive_ddr.c b/drivers/ram/sifive/sifive_ddr.c
index bd2f438d727..c555d2af2d0 100644
--- a/drivers/ram/sifive/sifive_ddr.c
+++ b/drivers/ram/sifive/sifive_ddr.c
@@ -91,7 +91,7 @@ struct sifive_ddr_info {
 	u32 *physical_filter_ctrl;
 };
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 struct sifive_ddr_params {
 	struct sifive_ddrctl pctl_regs;
 	struct sifive_ddrphy phy_regs;
@@ -337,7 +337,7 @@ static int sifive_ddr_probe(struct udevice *dev)
 	priv->info.base = gd->ram_base;
 	priv->info.size = gd->ram_size;
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 	int ret;
 	u32 clock = 0;
 
@@ -404,7 +404,7 @@ U_BOOT_DRIVER(sifive_ddr) = {
 	.ops = &sifive_ddr_ops,
 	.probe = sifive_ddr_probe,
 	.priv_auto = sizeof(struct sifive_ddr_info),
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 	.plat_auto = sizeof(struct sifive_dmc_plat),
 #endif
 };
diff --git a/drivers/ram/starfive/Makefile b/drivers/ram/starfive/Makefile
index 1df42c377bd..f1567b04b4c 100644
--- a/drivers/ram/starfive/Makefile
+++ b/drivers/ram/starfive/Makefile
@@ -2,10 +2,10 @@
 #
 # Copyright (c) 2022 StarFive, Inc
 #
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_SPL_STARFIVE_DDR) += ddrphy_start.o
 obj-$(CONFIG_SPL_STARFIVE_DDR) += ddrphy_train.o
 obj-$(CONFIG_SPL_STARFIVE_DDR) += starfive_ddr.o
 obj-$(CONFIG_SPL_STARFIVE_DDR) += ddrphy_utils.o
 obj-$(CONFIG_SPL_STARFIVE_DDR) += ddrcsr_boot.o
-endif
\ No newline at end of file
+endif
diff --git a/drivers/ram/stm32mp1/stm32mp1_ram.c b/drivers/ram/stm32mp1/stm32mp1_ram.c
index debc458c0e2..e9cd6229ec4 100644
--- a/drivers/ram/stm32mp1/stm32mp1_ram.c
+++ b/drivers/ram/stm32mp1/stm32mp1_ram.c
@@ -371,7 +371,7 @@ static int stm32mp1_ddr_probe(struct udevice *dev)
 
 	priv->info.base = STM32_DDR_BASE;
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
+	if (IS_ENABLED(CONFIG_XPL_BUILD)) {
 		priv->info.size = 0;
 		ret = stm32mp1_ddr_setup(dev);
 
diff --git a/drivers/reset/reset-socfpga.c b/drivers/reset/reset-socfpga.c
index 866437fd24f..76d108080d9 100644
--- a/drivers/reset/reset-socfpga.c
+++ b/drivers/reset/reset-socfpga.c
@@ -46,7 +46,7 @@ struct socfpga_reset_data {
  */
 static bool socfpga_reset_keep_enabled(void)
 {
-#if !defined(CONFIG_SPL_BUILD) || CONFIG_IS_ENABLED(ENV_SUPPORT)
+#if !defined(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(ENV_SUPPORT)
 	const char *env_str;
 	long val;
 
diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
index 628be4c89fb..7c19a435722 100644
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2000-2007
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_SCSI) += scsi.o scsi-uclass.o
 ifdef CONFIG_SCSI
 obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += scsi_bootdev.o
@@ -12,7 +12,7 @@ obj-$(CONFIG_SANDBOX) += scsi_emul.o
 endif
 endif
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 ifdef CONFIG_SPL_SATA
 obj-$(CONFIG_SCSI) += scsi.o scsi-uclass.o
 endif
diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
index 78810f98367..66bd30b837b 100644
--- a/drivers/serial/Makefile
+++ b/drivers/serial/Makefile
@@ -63,7 +63,7 @@ obj-$(CONFIG_XEN_SERIAL) += serial_xen.o
 obj-$(CONFIG_XTENSA_SEMIHOSTING_SERIAL) += serial_xtensa_semihosting.o
 obj-$(CONFIG_S5P4418_PL011_SERIAL) += serial_s5p4418_pl011.o
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_USB_TTY) += usbtty.o
 endif
 obj-$(CONFIG_UART4_SERIAL) += serial_adi_uart4.o
diff --git a/drivers/serial/atmel_usart.c b/drivers/serial/atmel_usart.c
index 7e45a80969e..0b35582aaa4 100644
--- a/drivers/serial/atmel_usart.c
+++ b/drivers/serial/atmel_usart.c
@@ -218,7 +218,7 @@ static const struct dm_serial_ops atmel_serial_ops = {
 	.setbrg = atmel_serial_setbrg,
 };
 
-#if defined(CONFIG_SPL_BUILD) && !defined(CONFIG_SPL_CLK)
+#if defined(CONFIG_XPL_BUILD) && !defined(CONFIG_SPL_CLK)
 static int atmel_serial_enable_clk(struct udevice *dev)
 {
 	struct atmel_serial_priv *priv = dev_get_priv(dev);
diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
index 55bc39648d7..3489228127e 100644
--- a/drivers/serial/ns16550.c
+++ b/drivers/serial/ns16550.c
@@ -227,7 +227,7 @@ static void ns16550_setbrg(struct ns16550 *com_port, int baud_divisor)
 
 void ns16550_init(struct ns16550 *com_port, int baud_divisor)
 {
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_OMAP34XX)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_OMAP34XX)
 	/*
 	 * On some OMAP3/OMAP4 devices when UART3 is configured for boot mode
 	 * before SPL starts only THRE bit is set. We have to empty the
@@ -303,7 +303,7 @@ void ns16550_putc(struct ns16550 *com_port, char c)
 char ns16550_getc(struct ns16550 *com_port)
 {
 	while ((serial_in(&com_port->lsr) & UART_LSR_DR) == 0) {
-#if !defined(CONFIG_SPL_BUILD) && defined(CONFIG_USB_TTY)
+#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_USB_TTY)
 		extern void usbtty_poll(void);
 		usbtty_poll();
 #endif
diff --git a/drivers/serial/serial-uclass.c b/drivers/serial/serial-uclass.c
index 84f02f7ac76..9feaa1eceec 100644
--- a/drivers/serial/serial-uclass.c
+++ b/drivers/serial/serial-uclass.c
@@ -101,7 +101,7 @@ static void serial_find_console_or_panic(void)
 			}
 		}
 	}
-	if (!IS_ENABLED(CONFIG_SPL_BUILD) || !CONFIG_IS_ENABLED(OF_CONTROL) ||
+	if (!IS_ENABLED(CONFIG_XPL_BUILD) || !CONFIG_IS_ENABLED(OF_CONTROL) ||
 	    !blob) {
 		/*
 		 * Try to use CONFIG_CONS_INDEX if available (it is numbered
diff --git a/drivers/serial/serial.c b/drivers/serial/serial.c
index dc4bb06fa99..e10ca6eef76 100644
--- a/drivers/serial/serial.c
+++ b/drivers/serial/serial.c
@@ -315,7 +315,7 @@ static struct serial_device *get_current(void)
 
 	/* We must have a console device */
 	if (!dev) {
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 		puts("Cannot find console\n");
 		hang();
 #else
diff --git a/drivers/serial/serial_s5p.c b/drivers/serial/serial_s5p.c
index 801b7645afa..734780a124a 100644
--- a/drivers/serial/serial_s5p.c
+++ b/drivers/serial/serial_s5p.c
@@ -117,7 +117,7 @@ static void __maybe_unused s5p_serial_baud(struct s5p_uart *uart, u8 reg_width,
 		writeb(val % 16, &uart->rest.value);
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 int s5p_serial_setbrg(struct udevice *dev, int baudrate)
 {
 	struct s5p_serial_plat *plat = dev_get_plat(dev);
diff --git a/drivers/serial/serial_zynq.c b/drivers/serial/serial_zynq.c
index 55f13c00ddf..b74712f3eeb 100644
--- a/drivers/serial/serial_zynq.c
+++ b/drivers/serial/serial_zynq.c
@@ -152,7 +152,7 @@ static int zynq_serial_setbrg(struct udevice *dev, int baudrate)
 	return 0;
 }
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 static int zynq_serial_setconfig(struct udevice *dev, uint serial_config)
 {
 	struct zynq_uart_plat *plat = dev_get_plat(dev);
diff --git a/drivers/spi/designware_spi.c b/drivers/spi/designware_spi.c
index 6bd48b1b373..b520c727900 100644
--- a/drivers/spi/designware_spi.c
+++ b/drivers/spi/designware_spi.c
@@ -219,7 +219,7 @@ static int dw_spi_dwc_init(struct udevice *bus, struct dw_spi_priv *priv)
 
 static int request_gpio_cs(struct udevice *bus)
 {
-#if CONFIG_IS_ENABLED(DM_GPIO) && !defined(CONFIG_SPL_BUILD)
+#if CONFIG_IS_ENABLED(DM_GPIO) && !defined(CONFIG_XPL_BUILD)
 	struct dw_spi_priv *priv = dev_get_priv(bus);
 	int ret;
 
@@ -482,7 +482,7 @@ static int poll_transfer(struct dw_spi_priv *priv)
  */
 __weak void external_cs_manage(struct udevice *dev, bool on)
 {
-#if CONFIG_IS_ENABLED(DM_GPIO) && !defined(CONFIG_SPL_BUILD)
+#if CONFIG_IS_ENABLED(DM_GPIO) && !defined(CONFIG_XPL_BUILD)
 	struct dw_spi_priv *priv = dev_get_priv(dev->parent);
 
 	if (!dm_gpio_is_valid(&priv->cs_gpio))
diff --git a/drivers/spi/rockchip_sfc.c b/drivers/spi/rockchip_sfc.c
index 596c22aa010..43aefc20c9a 100644
--- a/drivers/spi/rockchip_sfc.c
+++ b/drivers/spi/rockchip_sfc.c
@@ -229,7 +229,7 @@ static int rockchip_sfc_ofdata_to_platdata(struct udevice *bus)
 	sfc->regbase = dev_read_addr_ptr(bus);
 	sfc->use_dma = !dev_read_bool(bus, "rockchip,sfc-no-dma");
 
-	if (IS_ENABLED(CONFIG_SPL_BUILD) && sfc->use_dma)
+	if (IS_ENABLED(CONFIG_XPL_BUILD) && sfc->use_dma)
 		sfc->use_dma = !dev_read_bool(bus, "u-boot,spl-sfc-no-dma");
 
 #if CONFIG_IS_ENABLED(CLK)
diff --git a/drivers/sysreset/sysreset_ast.c b/drivers/sysreset/sysreset_ast.c
index ef09440bbef..4e15ebd53cc 100644
--- a/drivers/sysreset/sysreset_ast.c
+++ b/drivers/sysreset/sysreset_ast.c
@@ -33,7 +33,7 @@ static int ast_sysreset_request(struct udevice *dev, enum sysreset_t type)
 		return -EPROTONOSUPPORT;
 	}
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 	ret = wdt_expire_now(wdt, reset_mode);
 	if (ret) {
 		debug("Sysreset failed: %d", ret);
diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index cbe06a9e7b6..4cfd38ec245 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -149,7 +149,7 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
 
 	dr_mode = best_dr_mode;
 
-#if defined(CONFIG_SPL_USB_HOST) || !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_SPL_USB_HOST) || !defined(CONFIG_XPL_BUILD)
 	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
 		ret = cdns3_host_init(cdns);
 		if (ret) {
@@ -412,7 +412,7 @@ int cdns3_bind(struct udevice *parent)
 
 	switch (dr_mode) {
 #if defined(CONFIG_SPL_USB_HOST) || \
-	(!defined(CONFIG_SPL_BUILD) && defined(CONFIG_USB_HOST))
+	(!defined(CONFIG_XPL_BUILD) && defined(CONFIG_USB_HOST))
 	case USB_DR_MODE_HOST:
 		debug("%s: dr_mode: HOST\n", __func__);
 		driver = "cdns-usb3-host";
@@ -498,7 +498,7 @@ int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 #endif
 
 #if defined(CONFIG_SPL_USB_HOST) || \
-	(!defined(CONFIG_SPL_BUILD) && defined(CONFIG_USB_HOST))
+	(!defined(CONFIG_XPL_BUILD) && defined(CONFIG_USB_HOST))
 static int cdns3_host_probe(struct udevice *dev)
 {
 	struct cdns3_host_priv *priv = dev_get_priv(dev);
diff --git a/drivers/usb/gadget/Makefile b/drivers/usb/gadget/Makefile
index 6abcce0d9c7..3158487cba4 100644
--- a/drivers/usb/gadget/Makefile
+++ b/drivers/usb/gadget/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_$(SPL_TPL_)USB_GADGET) += epautoconf.o config.o usbstring.o
 obj-$(CONFIG_$(SPL_TPL_)USB_ETHER) += epautoconf.o config.o usbstring.o ether.o
 obj-$(CONFIG_$(SPL_TPL_)USB_ETH_RNDIS) += rndis.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_SPL_USB_GADGET) += g_dnl.o
 obj-$(CONFIG_SPL_DFU) += f_dfu.o
 obj-$(CONFIG_SPL_USB_SDP_SUPPORT) += f_sdp.o
@@ -21,7 +21,7 @@ obj-$(CONFIG_USB_GADGET_BCM_UDC_OTG_PHY) += bcm_udc_otg_phy.o
 obj-$(CONFIG_USB_GADGET_DWC2_OTG) += dwc2_udc_otg.o
 obj-$(CONFIG_USB_GADGET_DWC2_OTG_PHY) += dwc2_udc_otg_phy.o
 obj-$(CONFIG_USB_GADGET_MAX3420) += max3420_udc.o
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_USB_GADGET_DOWNLOAD) += g_dnl.o
 obj-$(CONFIG_USB_FUNCTION_THOR) += f_thor.o
 obj-$(CONFIG_DFU_OVER_USB) += f_dfu.o
diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
index 5d62eb475d0..36934b1bcf7 100644
--- a/drivers/usb/gadget/f_sdp.c
+++ b/drivers/usb/gadget/f_sdp.c
@@ -411,7 +411,7 @@ static void sdp_rx_data_complete(struct usb_ep *ep, struct usb_request *req)
 		return;
 	}
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	env_set_hex("filesize", sdp->dnl_bytes);
 #endif
 	printf("done\n");
@@ -736,7 +736,7 @@ static u32 sdp_jump_imxheader(void *address)
 	return 0;
 }
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 static ulong sdp_load_read(struct spl_load_info *load, ulong sector,
 			   ulong count, void *buf)
 {
@@ -825,7 +825,7 @@ static int sdp_handle_in_ep(struct spl_image_info *spl_image,
 
 		/* If imx header fails, try some U-Boot specific headers */
 		if (status) {
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 			if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER))
 				sdp_func->jmp_address = (u32)search_container_header((ulong)sdp_func->jmp_address, sdp_func->dnl_bytes);
 			else if (IS_ENABLED(CONFIG_SPL_LOAD_FIT))
@@ -907,7 +907,7 @@ static void sdp_handle_out_ep(void)
 	}
 }
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 int sdp_handle(struct udevice *udc)
 #else
 int spl_sdp_handle(struct udevice *udc, struct spl_image_info *spl_image,
@@ -928,7 +928,7 @@ int spl_sdp_handle(struct udevice *udc, struct spl_image_info *spl_image,
 		schedule();
 		dm_usb_gadget_handle_interrupts(udc);
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 		flag = sdp_handle_in_ep(spl_image, bootdev);
 #else
 		flag = sdp_handle_in_ep(NULL, NULL);
diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index f8e14eabfb2..26fee141f6e 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -266,7 +266,7 @@ U_BOOT_DRIVER(mtu3_peripheral) = {
 #endif
 
 #if defined(CONFIG_SPL_USB_HOST) || \
-	(!defined(CONFIG_SPL_BUILD) && defined(CONFIG_USB_HOST))
+	(!defined(CONFIG_XPL_BUILD) && defined(CONFIG_USB_HOST))
 static int mtu3_host_probe(struct udevice *dev)
 {
 	struct ssusb_mtk *ssusb = dev_to_ssusb(dev->parent);
@@ -334,7 +334,7 @@ static int mtu3_glue_bind(struct udevice *parent)
 #endif
 
 #if defined(CONFIG_SPL_USB_HOST) || \
-	(!defined(CONFIG_SPL_BUILD) && defined(CONFIG_USB_HOST))
+	(!defined(CONFIG_XPL_BUILD) && defined(CONFIG_USB_HOST))
 	case USB_DR_MODE_HOST:
 		dev_dbg(parent, "%s: dr_mode: host\n", __func__);
 		driver = "mtu3-host";
-- 
2.34.1

