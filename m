Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C79FC41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 19:39:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10F6087BCE;
	Sat, 16 Dec 2023 20:38:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EC1DCuQk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19F54875A0; Sat, 16 Dec 2023 20:38:55 +0100 (CET)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F82087BD2
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 20:38:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-59067ccb090so1328214eaf.1
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 11:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702755528; x=1703360328; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iBlS079Rg+AwbZT5/JBY93QX02YIXJwInvqbx4at4Xc=;
 b=EC1DCuQkvDsxoE8StcSBatVMWBxTFv9338xpcoMDPmvp54Sn5tK5EeApHvZtCykZbi
 gtX36pp1rtj8N37Syf57xZR6K9zR46H5mn3SeCAXZ95RVknCyiI5Y+rVzYs+IbkI7GUk
 3UBUI6ji/8njZFo0cC9ArgMM65Q+CIVTSwoF1Bk5XsaWhfTUFR2hbU1g3rp7VWVJPEL/
 j+XsC6yrjzW4NgcTiv72BSFLKgjqE3MBAOQS+nPIKy4wixKURd3F8k+lBD+IlQyYpeCp
 nS9kUbLfsnENCEzZGe0wihesffbnuCLRuDjCgfsCxTNVp6YX5ZWv6v2E1P8uYhcbzzkC
 T4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702755528; x=1703360328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iBlS079Rg+AwbZT5/JBY93QX02YIXJwInvqbx4at4Xc=;
 b=lsx2Gwu+DZ48rRWCiB4c76cwJxMzhr44HHMNXCJyMUgk4ZoNjbfZrckSpzLK3NSKgA
 /6LKfU5d6lR/031aQ875IXwaA5rNqngRdbGcVs8x/Fai0sj1NlGgfBKTMLj7+3fzZoW+
 /KlhKYxnRisY2j8oFbgBG2qVbW6xT4XRtx0/gA69clzP1b4t3zRL8QBcgWzFJWaXXtRt
 FJTY4mdFeH1XDa8JNxc8nbpawZHcjH9vg57EYtDH5pg0AoyvGoqArNlpELLrrXHz9vWU
 6ear7s30fbW5q41pioPRmyKIM7xMvsIYsWFeoi/DYFzwTQzcqcRI4FNpv3vRRxowz5/O
 0TPw==
X-Gm-Message-State: AOJu0Yw4FXTYCdDmMs52chT3BE6On+TsA58qFzuIsNOdW0bBnV96CgNu
 wtvao4/u/SNwy0M6wneBXQg1ZI5IQDvOMQ==
X-Google-Smtp-Source: AGHT+IFpglPqevgalOSKnm2fUQa6k3yUhxVGDUKiIK07RFgdAISjHWS4Xr8cqyUe/VhrPEp2bQI9hA==
X-Received: by 2002:a05:6358:52d0:b0:170:e927:f0c4 with SMTP id
 z16-20020a05635852d000b00170e927f0c4mr10271469rwz.40.1702755527789; 
 Sat, 16 Dec 2023 11:38:47 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 p5-20020a05621415c500b0067f25f3ab10sm951003qvz.8.2023.12.16.11.38.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 Dec 2023 11:38:47 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 2/3] treewide: Remove clk_free
Date: Sat, 16 Dec 2023 14:38:42 -0500
Message-Id: <20231216193843.2463779-3-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231216193843.2463779-1-seanga2@gmail.com>
References: <20231216193843.2463779-1-seanga2@gmail.com>
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

This function is a no-op. Remove it.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 arch/arm/mach-rockchip/rk3288/rk3288.c        |  2 -
 arch/arm/mach-socfpga/clock_manager_agilex.c  |  2 -
 arch/arm/mach-socfpga/clock_manager_arria10.c |  7 +--
 arch/arm/mach-socfpga/clock_manager_n5x.c     |  2 -
 arch/arm/mach-zynq/clk.c                      |  2 -
 arch/mips/mach-pic32/cpu.c                    |  7 +--
 board/microchip/pic32mzda/pic32mzda.c         |  2 -
 board/sipeed/maix/maix.c                      |  1 -
 board/synopsys/hsdk/clk-lib.c                 |  2 -
 drivers/clk/aspeed/clk_ast2600.c              |  2 -
 drivers/clk/at91/compat.c                     | 14 +-----
 drivers/clk/clk-uclass.c                      | 26 +----------
 drivers/clk/clk-xlnx-clock-wizard.c           |  1 -
 drivers/clk/clk_versaclock.c                  | 12 +-----
 drivers/clk/clk_zynq.c                        |  2 -
 drivers/clk/clk_zynqmp.c                      |  2 -
 drivers/clk/imx/clk-imx8.c                    |  2 -
 drivers/clk/mvebu/armada-37xx-periph.c        |  2 -
 drivers/cpu/riscv_cpu.c                       |  2 -
 drivers/dma/bcm6348-iudma.c                   |  2 -
 drivers/gpio/at91_gpio.c                      |  2 -
 drivers/gpio/atmel_pio4.c                     |  2 -
 drivers/gpio/gpio-rcar.c                      |  1 -
 drivers/hwspinlock/stm32_hwspinlock.c         |  6 +--
 drivers/i2c/at91_i2c.c                        |  2 -
 drivers/i2c/designware_i2c.c                  |  2 -
 drivers/i2c/i2c-microchip.c                   |  2 -
 drivers/i2c/npcm_i2c.c                        |  1 -
 drivers/i2c/ocores_i2c.c                      |  2 -
 drivers/i2c/stm32f7_i2c.c                     |  4 +-
 drivers/mailbox/stm32-ipcc.c                  |  7 +--
 drivers/misc/ls2_sfp.c                        |  1 -
 drivers/mmc/arm_pl180_mmci.c                  |  1 -
 drivers/mmc/aspeed_sdhci.c                    |  4 +-
 drivers/mmc/atmel_sdhci.c                     |  2 -
 drivers/mmc/gen_atmel_mci.c                   | 19 +++-----
 drivers/mmc/msm_sdhci.c                       |  1 -
 drivers/mmc/pic32_sdhci.c                     |  1 -
 drivers/mmc/renesas-sdhi.c                    | 21 +++------
 drivers/mmc/snps_dw_mmc.c                     |  8 +---
 drivers/mmc/socfpga_dw_mmc.c                  |  1 -
 drivers/mmc/stm32_sdmmc2.c                    |  4 +-
 drivers/mmc/uniphier-sd.c                     |  1 -
 drivers/mtd/nand/raw/atmel/nand-controller.c  |  4 +-
 drivers/mtd/renesas_rpc_hf.c                  |  1 -
 drivers/net/bcm6348-eth.c                     |  2 -
 drivers/net/bcm6368-eth.c                     |  2 -
 drivers/net/designware.c                      |  1 -
 drivers/net/dwc_eth_qos.c                     | 43 +++----------------
 drivers/net/dwc_eth_qos_imx.c                 | 21 ++-------
 drivers/net/dwc_eth_qos_qcom.c                |  1 -
 drivers/net/dwc_eth_qos_rockchip.c            |  6 +--
 drivers/net/sni_ave.c                         |  5 +--
 drivers/net/ti/am65-cpsw-nuss.c               |  1 -
 drivers/phy/bcm6318-usbh-phy.c                |  2 -
 drivers/phy/bcm6348-usbh-phy.c                |  2 -
 drivers/phy/bcm6368-usbh-phy.c                |  4 --
 drivers/phy/meson-axg-mipi-dphy.c             |  1 -
 drivers/phy/meson-g12a-usb3-pcie.c            |  1 -
 drivers/phy/meson-gxl-usb2.c                  |  1 -
 drivers/phy/phy-rcar-gen2.c                   |  1 -
 drivers/phy/phy-rcar-gen3.c                   |  1 -
 drivers/pinctrl/pinctrl-k210.c                | 20 +++------
 drivers/power/domain/imx8mp-hsiomix.c         |  4 +-
 drivers/rtc/stm32_rtc.c                       | 16 ++-----
 drivers/serial/atmel_usart.c                  |  2 -
 drivers/serial/serial_bcm6345.c               |  1 -
 drivers/serial/serial_msm.c                   |  1 -
 drivers/serial/serial_pic32.c                 |  1 -
 drivers/spi/atcspi200_spi.c                   |  1 -
 drivers/spi/atmel-quadspi.c                   | 14 ++----
 drivers/spi/atmel_spi.c                       |  2 -
 drivers/spi/bcm63xx_hsspi.c                   |  4 --
 drivers/spi/bcm63xx_spi.c                     |  2 -
 drivers/spi/bcmbca_hsspi.c                    |  4 --
 drivers/spi/cadence_qspi.c                    |  1 -
 drivers/spi/designware_spi.c                  |  5 ---
 drivers/spi/meson_spifc_a1.c                  | 10 -----
 drivers/spi/mvebu_a3700_spi.c                 | 10 -----
 drivers/spi/spi-aspeed-smc.c                  |  1 -
 drivers/spi/stm32_spi.c                       | 19 ++------
 drivers/timer/dw-apb-timer.c                  |  2 -
 drivers/timer/ostm_timer.c                    |  2 -
 drivers/usb/dwc3/dwc3-meson-g12a.c            |  4 +-
 drivers/usb/dwc3/dwc3-meson-gxl.c             |  4 +-
 drivers/usb/host/ehci-atmel.c                 |  8 +---
 drivers/usb/host/ohci-da8xx.c                 |  1 -
 drivers/usb/host/xhci-rcar.c                  |  5 +--
 drivers/video/atmel_hlcdfb.c                  |  2 -
 drivers/video/mali_dp.c                       | 11 +----
 drivers/video/rockchip/rk3288_hdmi.c          |  4 +-
 drivers/video/rockchip/rk_edp.c               |  8 +---
 drivers/watchdog/designware_wdt.c             | 18 +++-----
 drivers/watchdog/meson_gxbb_wdt.c             |  4 +-
 include/clk.h                                 | 21 ---------
 95 files changed, 71 insertions(+), 430 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3288/rk3288.c b/arch/arm/mach-rockchip/rk3288/rk3288.c
index 26c7e41cd89..d9f782e342b 100644
--- a/arch/arm/mach-rockchip/rk3288/rk3288.c
+++ b/arch/arm/mach-rockchip/rk3288/rk3288.c
@@ -184,8 +184,6 @@ static int do_clock(struct cmd_tbl *cmdtp, int flag, int argc,
 
 		rate = clk_get_rate(&clk);
 		printf("%s: %lu\n", clks[i].name, rate);
-
-		clk_free(&clk);
 	}
 
 	return 0;
diff --git a/arch/arm/mach-socfpga/clock_manager_agilex.c b/arch/arm/mach-socfpga/clock_manager_agilex.c
index e035c09aaef..28f593b60e6 100644
--- a/arch/arm/mach-socfpga/clock_manager_agilex.c
+++ b/arch/arm/mach-socfpga/clock_manager_agilex.c
@@ -37,8 +37,6 @@ static ulong cm_get_rate_dm(u32 id)
 
 	rate = clk_get_rate(&clk);
 
-	clk_free(&clk);
-
 	if ((rate == (unsigned long)-ENOSYS) ||
 	    (rate == (unsigned long)-ENXIO) ||
 	    (rate == (unsigned long)-EIO)) {
diff --git a/arch/arm/mach-socfpga/clock_manager_arria10.c b/arch/arm/mach-socfpga/clock_manager_arria10.c
index b48a2b47bcd..8ab18f6b725 100644
--- a/arch/arm/mach-socfpga/clock_manager_arria10.c
+++ b/arch/arm/mach-socfpga/clock_manager_arria10.c
@@ -962,7 +962,6 @@ static u32 cm_get_rate_dm(char *name)
 	struct uclass *uc;
 	struct udevice *dev = NULL;
 	struct clk clk = { 0 };
-	ulong rate;
 	int ret;
 
 	/* Device addresses start at 1 */
@@ -982,11 +981,7 @@ static u32 cm_get_rate_dm(char *name)
 	if (ret)
 		return 0;
 
-	rate = clk_get_rate(&clk);
-
-	clk_free(&clk);
-
-	return rate;
+	return clk_get_rate(&clk);
 }
 
 static u32 cm_get_rate_dm_khz(char *name)
diff --git a/arch/arm/mach-socfpga/clock_manager_n5x.c b/arch/arm/mach-socfpga/clock_manager_n5x.c
index 4f098533e7c..0ed480de670 100644
--- a/arch/arm/mach-socfpga/clock_manager_n5x.c
+++ b/arch/arm/mach-socfpga/clock_manager_n5x.c
@@ -36,8 +36,6 @@ static ulong cm_get_rate_dm(u32 id)
 
 	rate = clk_get_rate(&clk);
 
-	clk_free(&clk);
-
 	if ((rate == (unsigned long)-ENXIO) ||
 	    (rate == (unsigned long)-EIO)) {
 		debug("%s id %u: clk_get_rate err: %ld\n",
diff --git a/arch/arm/mach-zynq/clk.c b/arch/arm/mach-zynq/clk.c
index e6a67326dd4..5e1ba8d43ed 100644
--- a/arch/arm/mach-zynq/clk.c
+++ b/arch/arm/mach-zynq/clk.c
@@ -44,8 +44,6 @@ int set_cpu_clk_info(void)
 			gd->bd->bi_arm_freq = rate;
 			gd->cpu_clk = clk_get_rate(&clk);
 		}
-
-		clk_free(&clk);
 	}
 	gd->bd->bi_dsp_freq = 0;
 
diff --git a/arch/mips/mach-pic32/cpu.c b/arch/mips/mach-pic32/cpu.c
index 3181a946a27..668adbbda62 100644
--- a/arch/mips/mach-pic32/cpu.c
+++ b/arch/mips/mach-pic32/cpu.c
@@ -30,7 +30,6 @@ static ulong rate(int id)
 	int ret;
 	struct udevice *dev;
 	struct clk clk;
-	ulong rate;
 
 	ret = uclass_get_device(UCLASS_CLK, 0, &dev);
 	if (ret) {
@@ -43,11 +42,7 @@ static ulong rate(int id)
 	if (ret < 0)
 		return ret;
 
-	rate = clk_get_rate(&clk);
-
-	clk_free(&clk);
-
-	return rate;
+	return clk_get_rate(&clk);
 }
 
 static ulong clk_get_cpu_rate(void)
diff --git a/board/microchip/pic32mzda/pic32mzda.c b/board/microchip/pic32mzda/pic32mzda.c
index e7337deea7f..3c2203d2202 100644
--- a/board/microchip/pic32mzda/pic32mzda.c
+++ b/board/microchip/pic32mzda/pic32mzda.c
@@ -36,8 +36,6 @@ int checkboard(void)
 	rate = clk_get_rate(&clk);
 	printf("CPU Speed: %lu MHz\n", rate / 1000000);
 
-	clk_free(&clk);
-
 	return 0;
 }
 #endif
diff --git a/board/sipeed/maix/maix.c b/board/sipeed/maix/maix.c
index 79e492f0a8e..06653b5a876 100644
--- a/board/sipeed/maix/maix.c
+++ b/board/sipeed/maix/maix.c
@@ -32,7 +32,6 @@ static int sram_init(void)
 			continue;
 
 		ret = clk_enable(&clk);
-		clk_free(&clk);
 		if (ret)
 			return ret;
 	}
diff --git a/board/synopsys/hsdk/clk-lib.c b/board/synopsys/hsdk/clk-lib.c
index be76d6c8f47..a9614e90800 100644
--- a/board/synopsys/hsdk/clk-lib.c
+++ b/board/synopsys/hsdk/clk-lib.c
@@ -56,8 +56,6 @@ int soc_clk_ctl(const char *name, ulong *rate, enum clk_ctl_ops ctl)
 
 	priv_rate = clk_get_rate(&clk);
 
-	clk_free(&clk);
-
 	mhz_rate = ceil(priv_rate, HZ_IN_MHZ);
 
 	if (ctl & CLK_MHZ)
diff --git a/drivers/clk/aspeed/clk_ast2600.c b/drivers/clk/aspeed/clk_ast2600.c
index eecfacd7fc0..a15909329bb 100644
--- a/drivers/clk/aspeed/clk_ast2600.c
+++ b/drivers/clk/aspeed/clk_ast2600.c
@@ -1143,8 +1143,6 @@ static void ast2600_clk_dump(struct udevice *dev)
 		ret = clk_get_rate(&clk);
 		rate = ret;
 
-		clk_free(&clk);
-
 		if (ret == -EINVAL) {
 			printf("clk ID %lu not supported yet\n",
 			       aspeed_clk_names[i].id);
diff --git a/drivers/clk/at91/compat.c b/drivers/clk/at91/compat.c
index 2fdc2fbd554..ee67093c607 100644
--- a/drivers/clk/at91/compat.c
+++ b/drivers/clk/at91/compat.c
@@ -516,7 +516,6 @@ static ulong periph_get_rate(struct clk *clk)
 {
 	struct udevice *dev;
 	struct clk clk_dev;
-	ulong clk_rate;
 	int ret;
 
 	dev = dev_get_parent(clk->dev);
@@ -525,11 +524,7 @@ static ulong periph_get_rate(struct clk *clk)
 	if (ret)
 		return ret;
 
-	clk_rate = clk_get_rate(&clk_dev);
-
-	clk_free(&clk_dev);
-
-	return clk_rate;
+	return clk_get_rate(&clk_dev);
 }
 
 static struct clk_ops periph_clk_ops = {
@@ -762,7 +757,6 @@ static ulong generic_clk_get_rate(struct clk *clk)
 	struct pmc_plat *plat = dev_get_plat(clk->dev);
 	struct at91_pmc *pmc = plat->reg_base;
 	struct clk parent;
-	ulong clk_rate;
 	u32 tmp, gckdiv;
 	u8 clock_source, parent_index;
 	int ret;
@@ -778,11 +772,7 @@ static ulong generic_clk_get_rate(struct clk *clk)
 	if (ret)
 		return 0;
 
-	clk_rate = clk_get_rate(&parent) / (gckdiv + 1);
-
-	clk_free(&parent);
-
-	return clk_rate;
+	return clk_get_rate(&parent) / (gckdiv + 1);
 }
 
 static ulong generic_clk_set_rate(struct clk *clk, ulong rate)
diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 9260e434988..d95a48b76d9 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -437,8 +437,6 @@ int clk_release_all(struct clk *clk, unsigned int count)
 		ret = clk_disable(&clk[i]);
 		if (ret && ret != -ENOSYS)
 			return ret;
-
-		clk_free(&clk[i]);
 	}
 
 	return 0;
@@ -775,22 +773,12 @@ bool clk_is_match(const struct clk *p, const struct clk *q)
 	return false;
 }
 
-static void devm_clk_release(struct udevice *dev, void *res)
-{
-	clk_free(res);
-}
-
-static int devm_clk_match(struct udevice *dev, void *res, void *data)
-{
-	return res == data;
-}
-
 struct clk *devm_clk_get(struct udevice *dev, const char *id)
 {
 	int rc;
 	struct clk *clk;
 
-	clk = devres_alloc(devm_clk_release, sizeof(struct clk), __GFP_ZERO);
+	clk = devm_kzalloc(dev, sizeof(*clk), GFP_KERNEL);
 	if (unlikely(!clk))
 		return ERR_PTR(-ENOMEM);
 
@@ -798,21 +786,9 @@ struct clk *devm_clk_get(struct udevice *dev, const char *id)
 	if (rc)
 		return ERR_PTR(rc);
 
-	devres_add(dev, clk);
 	return clk;
 }
 
-void devm_clk_put(struct udevice *dev, struct clk *clk)
-{
-	int rc;
-
-	if (!clk)
-		return;
-
-	rc = devres_release(dev, devm_clk_release, devm_clk_match, clk);
-	WARN_ON(rc);
-}
-
 int clk_uclass_post_probe(struct udevice *dev)
 {
 	/*
diff --git a/drivers/clk/clk-xlnx-clock-wizard.c b/drivers/clk/clk-xlnx-clock-wizard.c
index 70ee3af1074..a10a843f11f 100644
--- a/drivers/clk/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/clk-xlnx-clock-wizard.c
@@ -137,7 +137,6 @@ static int clk_wzrd_probe(struct udevice *dev)
 	ret = clk_enable(&clk_in1);
 	if (ret) {
 		dev_err(dev, "failed to enable clock\n");
-		clk_free(&clk_in1);
 		return ret;
 	}
 
diff --git a/drivers/clk/clk_versaclock.c b/drivers/clk/clk_versaclock.c
index 699df3cf3ee..bbe72256032 100644
--- a/drivers/clk/clk_versaclock.c
+++ b/drivers/clk/clk_versaclock.c
@@ -1000,26 +1000,18 @@ int versaclock_probe(struct udevice *dev)
 	return 0;
 
 free_out:
-	for (n = 1; n < vc5->chip_info->clk_out_cnt; n++) {
-		clk_free(&vc5->clk_out[n].hw);
+	for (n = 1; n < vc5->chip_info->clk_out_cnt; n++)
 		free(out_name[n]);
-	}
 free_selb:
-	clk_free(&vc5->clk_out[0].hw);
 	free(outsel_name);
 free_fod:
-	for (n = 0; n < vc5->chip_info->clk_fod_cnt; n++) {
-		clk_free(&vc5->clk_fod[n].hw);
+	for (n = 0; n < vc5->chip_info->clk_fod_cnt; n++)
 		free(fod_name[n]);
-	}
 free_pll:
-	clk_free(&vc5->clk_pll.hw);
 	free(pll_name);
 free_pfd:
-	clk_free(&vc5->clk_pfd);
 	free(pfd_name);
 free_mux:
-	clk_free(&vc5->clk_mux);
 	free(mux_name);
 
 	return ret;
diff --git a/drivers/clk/clk_zynq.c b/drivers/clk/clk_zynq.c
index 34f964d72af..e3cefe2e0c7 100644
--- a/drivers/clk/clk_zynq.c
+++ b/drivers/clk/clk_zynq.c
@@ -491,8 +491,6 @@ static void zynq_clk_dump(struct udevice *dev)
 
 			rate = clk_get_rate(&clk);
 
-			clk_free(&clk);
-
 			if ((rate == (unsigned long)-ENOSYS) ||
 			    (rate == (unsigned long)-ENXIO))
 				printf("%10s%20s\n", name, "unknown");
diff --git a/drivers/clk/clk_zynqmp.c b/drivers/clk/clk_zynqmp.c
index 0ffac194a19..e23f7da3f92 100644
--- a/drivers/clk/clk_zynqmp.c
+++ b/drivers/clk/clk_zynqmp.c
@@ -757,8 +757,6 @@ static void zynqmp_clk_dump(struct udevice *dev)
 
 			rate = clk_get_rate(&clk);
 
-			clk_free(&clk);
-
 			if ((rate == (unsigned long)-ENOSYS) ||
 			    (rate == (unsigned long)-ENXIO) ||
 			    (rate == (unsigned long)-EIO))
diff --git a/drivers/clk/imx/clk-imx8.c b/drivers/clk/imx/clk-imx8.c
index 9600672e071..d39b87b2e24 100644
--- a/drivers/clk/imx/clk-imx8.c
+++ b/drivers/clk/imx/clk-imx8.c
@@ -62,8 +62,6 @@ static void imx8_clk_dump(struct udevice *dev)
 		ret = clk_get_rate(&clk);
 		rate = ret;
 
-		clk_free(&clk);
-
 		if (ret == -EINVAL) {
 			printf("clk ID %lu not supported yet\n",
 			       imx8_clk_names[i].id);
diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index 1a7097029ae..f5c9bd735c1 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -454,7 +454,6 @@ static int armada_37xx_periph_clk_set_parent(struct clk *clk,
 	if (parent->dev != check_parent.dev)
 		ret = -EINVAL;
 
-	clk_free(&check_parent);
 	if (ret < 0)
 		return ret;
 
@@ -596,7 +595,6 @@ static int armada_37xx_periph_clk_probe(struct udevice *dev)
 		}
 
 		priv->parents[i] = clk_get_rate(&clk);
-		clk_free(&clk);
 	}
 
 	return 0;
diff --git a/drivers/cpu/riscv_cpu.c b/drivers/cpu/riscv_cpu.c
index d6484d7f4b4..c6919e303cd 100644
--- a/drivers/cpu/riscv_cpu.c
+++ b/drivers/cpu/riscv_cpu.c
@@ -45,7 +45,6 @@ static int riscv_cpu_get_info(const struct udevice *dev, struct cpu_info *info)
 		ret = clk_get_rate(&clk);
 		if (!IS_ERR_VALUE(ret))
 			info->cpu_freq = ret;
-		clk_free(&clk);
 	}
 
 	if (!info->cpu_freq)
@@ -141,7 +140,6 @@ static int riscv_cpu_probe(struct udevice *dev)
 		return 0;
 
 	ret = clk_enable(&clk);
-	clk_free(&clk);
 	if (ret == -ENOSYS || ret == -ENOTSUPP)
 		return 0;
 	else
diff --git a/drivers/dma/bcm6348-iudma.c b/drivers/dma/bcm6348-iudma.c
index d4cfe0c1868..33c7b981415 100644
--- a/drivers/dma/bcm6348-iudma.c
+++ b/drivers/dma/bcm6348-iudma.c
@@ -596,8 +596,6 @@ static int bcm6348_iudma_probe(struct udevice *dev)
 			pr_err("error enabling clock %d\n", i);
 			return ret;
 		}
-
-		clk_free(&clk);
 	}
 
 	/* try to perform resets */
diff --git a/drivers/gpio/at91_gpio.c b/drivers/gpio/at91_gpio.c
index 1409db5dc11..f80f4afd24f 100644
--- a/drivers/gpio/at91_gpio.c
+++ b/drivers/gpio/at91_gpio.c
@@ -603,8 +603,6 @@ static int at91_gpio_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	clk_free(&clk);
-
 #if CONFIG_IS_ENABLED(OF_CONTROL)
 	plat->base_addr = dev_read_addr(dev);
 #endif
diff --git a/drivers/gpio/atmel_pio4.c b/drivers/gpio/atmel_pio4.c
index 47ed2979814..be1dd752bf7 100644
--- a/drivers/gpio/atmel_pio4.c
+++ b/drivers/gpio/atmel_pio4.c
@@ -310,8 +310,6 @@ static int atmel_pio4_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	clk_free(&clk);
-
 	addr_base = dev_read_addr(dev);
 	if (addr_base == FDT_ADDR_T_NONE)
 		return -EINVAL;
diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index d6cfbd231a8..70778501232 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -165,7 +165,6 @@ static int rcar_gpio_probe(struct udevice *dev)
 	}
 
 	ret = clk_enable(&clk);
-	clk_free(&clk);
 	if (ret) {
 		dev_err(dev, "Failed to enable GPIO bank clock\n");
 		return ret;
diff --git a/drivers/hwspinlock/stm32_hwspinlock.c b/drivers/hwspinlock/stm32_hwspinlock.c
index 46ed64655a8..346b138e98f 100644
--- a/drivers/hwspinlock/stm32_hwspinlock.c
+++ b/drivers/hwspinlock/stm32_hwspinlock.c
@@ -69,11 +69,7 @@ static int stm32mp1_hwspinlock_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	ret = clk_enable(&clk);
-	if (ret)
-		clk_free(&clk);
-
-	return ret;
+	return clk_enable(&clk);
 }
 
 static const struct hwspinlock_ops stm32mp1_hwspinlock_ops = {
diff --git a/drivers/i2c/at91_i2c.c b/drivers/i2c/at91_i2c.c
index e743d2a849a..b7a25885e66 100644
--- a/drivers/i2c/at91_i2c.c
+++ b/drivers/i2c/at91_i2c.c
@@ -201,8 +201,6 @@ static int at91_i2c_enable_clk(struct udevice *dev)
 
 	bus->bus_clk_rate = clk_rate;
 
-	clk_free(&clk);
-
 	return 0;
 }
 
diff --git a/drivers/i2c/designware_i2c.c b/drivers/i2c/designware_i2c.c
index 215ce010cb7..29cf63375c7 100644
--- a/drivers/i2c/designware_i2c.c
+++ b/drivers/i2c/designware_i2c.c
@@ -770,7 +770,6 @@ int designware_i2c_of_to_plat(struct udevice *bus)
 
 	ret = clk_enable(&priv->clk);
 	if (ret && ret != -ENOSYS && ret != -ENOTSUPP) {
-		clk_free(&priv->clk);
 		dev_err(bus, "failed to enable clock\n");
 		return ret;
 	}
@@ -803,7 +802,6 @@ int designware_i2c_remove(struct udevice *dev)
 
 #if CONFIG_IS_ENABLED(CLK)
 	clk_disable(&priv->clk);
-	clk_free(&priv->clk);
 #endif
 
 	return reset_release_bulk(&priv->resets);
diff --git a/drivers/i2c/i2c-microchip.c b/drivers/i2c/i2c-microchip.c
index d82b80f5355..d453e243d6f 100644
--- a/drivers/i2c/i2c-microchip.c
+++ b/drivers/i2c/i2c-microchip.c
@@ -183,8 +183,6 @@ static int mpfs_i2c_init(struct mpfs_i2c_bus *bus, struct udevice *dev)
 	if (!clk_rate)
 		return -EINVAL;
 
-	clk_free(&bus->i2c_clk);
-
 	divisor = clk_rate / bus->clk_rate;
 
 	ctrl = readl(bus->base + MPFS_I2C_CTRL);
diff --git a/drivers/i2c/npcm_i2c.c b/drivers/i2c/npcm_i2c.c
index b867b6c8e91..c64752e1467 100644
--- a/drivers/i2c/npcm_i2c.c
+++ b/drivers/i2c/npcm_i2c.c
@@ -570,7 +570,6 @@ static int npcm_i2c_probe(struct udevice *dev)
 		printf("%s: fail to get rate\n", __func__);
 		return -EINVAL;
 	}
-	clk_free(&clk);
 
 	bus->num = dev->seq_;
 	bus->reg = dev_read_addr_ptr(dev);
diff --git a/drivers/i2c/ocores_i2c.c b/drivers/i2c/ocores_i2c.c
index 3b19ba78fa3..fff85118d0d 100644
--- a/drivers/i2c/ocores_i2c.c
+++ b/drivers/i2c/ocores_i2c.c
@@ -396,8 +396,6 @@ static int ocores_i2c_enable_clk(struct udevice *dev)
 
 	bus->ip_clk_khz = clk_rate / 1000;
 
-	clk_free(&bus->clk);
-
 	return 0;
 }
 
diff --git a/drivers/i2c/stm32f7_i2c.c b/drivers/i2c/stm32f7_i2c.c
index eaa1d692898..f42e08a6418 100644
--- a/drivers/i2c/stm32f7_i2c.c
+++ b/drivers/i2c/stm32f7_i2c.c
@@ -890,7 +890,7 @@ static int stm32_i2c_probe(struct udevice *dev)
 
 	ret = clk_enable(&i2c_priv->clk);
 	if (ret)
-		goto clk_free;
+		return ret;
 
 	ret = reset_get_by_index(dev, 0, &reset_ctl);
 	if (ret)
@@ -904,8 +904,6 @@ static int stm32_i2c_probe(struct udevice *dev)
 
 clk_disable:
 	clk_disable(&i2c_priv->clk);
-clk_free:
-	clk_free(&i2c_priv->clk);
 
 	return ret;
 }
diff --git a/drivers/mailbox/stm32-ipcc.c b/drivers/mailbox/stm32-ipcc.c
index 69c86e059f5..046e1a8aca6 100644
--- a/drivers/mailbox/stm32-ipcc.c
+++ b/drivers/mailbox/stm32-ipcc.c
@@ -134,18 +134,13 @@ static int stm32_ipcc_probe(struct udevice *dev)
 
 	ret = clk_enable(&clk);
 	if (ret)
-		goto clk_free;
+		return ret;
 
 	/* get channel number */
 	ipcc->n_chans = readl(ipcc->reg_base + IPCC_HWCFGR);
 	ipcc->n_chans &= IPCFGR_CHAN_MASK;
 
 	return 0;
-
-clk_free:
-	clk_free(&clk);
-
-	return ret;
 }
 
 static const struct udevice_id stm32_ipcc_ids[] = {
diff --git a/drivers/misc/ls2_sfp.c b/drivers/misc/ls2_sfp.c
index 2a81bc7de5f..5351c7ed34f 100644
--- a/drivers/misc/ls2_sfp.c
+++ b/drivers/misc/ls2_sfp.c
@@ -249,7 +249,6 @@ static int ls2_sfp_probe(struct udevice *dev)
 		}
 
 		rate = clk_get_rate(&clk);
-		clk_free(&clk);
 		if (!rate || IS_ERR_VALUE(rate)) {
 			ret = rate ? rate : -ENOENT;
 			dev_dbg(dev, "could not get clock rate (err %d)\n",
diff --git a/drivers/mmc/arm_pl180_mmci.c b/drivers/mmc/arm_pl180_mmci.c
index 9c5d48e90cd..5cf5502ed54 100644
--- a/drivers/mmc/arm_pl180_mmci.c
+++ b/drivers/mmc/arm_pl180_mmci.c
@@ -447,7 +447,6 @@ static int arm_pl180_mmc_probe(struct udevice *dev)
 
 	ret = clk_enable(&clk);
 	if (ret) {
-		clk_free(&clk);
 		dev_err(dev, "failed to enable clock\n");
 		return ret;
 	}
diff --git a/drivers/mmc/aspeed_sdhci.c b/drivers/mmc/aspeed_sdhci.c
index 9d79bf58cc7..c9626c6beb8 100644
--- a/drivers/mmc/aspeed_sdhci.c
+++ b/drivers/mmc/aspeed_sdhci.c
@@ -35,7 +35,7 @@ static int aspeed_sdhci_probe(struct udevice *dev)
 	ret = clk_enable(&clk);
 	if (ret) {
 		debug("%s: clock enable failed %d\n", __func__, ret);
-		goto free;
+		return ret;
 	}
 
 	host->name = dev->name;
@@ -66,8 +66,6 @@ static int aspeed_sdhci_probe(struct udevice *dev)
 
 err:
 	clk_disable(&clk);
-free:
-	clk_free(&clk);
 	return ret;
 }
 
diff --git a/drivers/mmc/atmel_sdhci.c b/drivers/mmc/atmel_sdhci.c
index 5347ba90431..d92bad97b71 100644
--- a/drivers/mmc/atmel_sdhci.c
+++ b/drivers/mmc/atmel_sdhci.c
@@ -147,8 +147,6 @@ static int atmel_sdhci_probe(struct udevice *dev)
 	host->ops = &atmel_sdhci_ops;
 	upriv->mmc = host->mmc;
 
-	clk_free(&clk);
-
 	ret = sdhci_probe(dev);
 	if (ret)
 		return ret;
diff --git a/drivers/mmc/gen_atmel_mci.c b/drivers/mmc/gen_atmel_mci.c
index d91819acfd7..3ee99558f6f 100644
--- a/drivers/mmc/gen_atmel_mci.c
+++ b/drivers/mmc/gen_atmel_mci.c
@@ -559,27 +559,20 @@ static int atmel_mci_enable_clk(struct udevice *dev)
 	int ret = 0;
 
 	ret = clk_get_by_index(dev, 0, &clk);
-	if (ret) {
-		ret = -EINVAL;
-		goto failed;
-	}
+	if (ret)
+		return -EINVAL;
 
 	ret = clk_enable(&clk);
 	if (ret)
-		goto failed;
+		return ret;
 
 	clk_rate = clk_get_rate(&clk);
-	if (!clk_rate) {
-		ret = -EINVAL;
-		goto failed;
-	}
+	if (!clk_rate)
+		return -EINVAL;
 
 	priv->bus_clk_rate = clk_rate;
 
-failed:
-	clk_free(&clk);
-
-	return ret;
+	return 0;
 }
 
 static int atmel_mci_probe(struct udevice *dev)
diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 604f9c3ff99..fe1e754bfde 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -81,7 +81,6 @@ static int msm_sdc_clk_init(struct udevice *dev)
 		return ret;
 
 	ret = clk_set_rate(&clk, clk_rate);
-	clk_free(&clk);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/mmc/pic32_sdhci.c b/drivers/mmc/pic32_sdhci.c
index fe555106a1d..7a8e33dbc7a 100644
--- a/drivers/mmc/pic32_sdhci.c
+++ b/drivers/mmc/pic32_sdhci.c
@@ -32,7 +32,6 @@ static int pic32_sdhci_probe(struct udevice *dev)
 		return ret;
 
 	clk_rate = clk_get_rate(&clk);
-	clk_free(&clk);
 
 	if (IS_ERR_VALUE(clk_rate))
 		return clk_rate;
diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
index 97aaf1e4ec3..a74559ca686 100644
--- a/drivers/mmc/renesas-sdhi.c
+++ b/drivers/mmc/renesas-sdhi.c
@@ -979,19 +979,19 @@ static int rzg2l_sdhi_setup(struct udevice *dev)
 	ret = clk_get_by_name(dev, "cd", &imclk2);
 	if (ret < 0) {
 		dev_err(dev, "failed to get imclk2 (chip detect clk)\n");
-		goto err_get_imclk2;
+		return ret;
 	}
 
 	ret = clk_get_by_name(dev, "aclk", &aclk);
 	if (ret < 0) {
 		dev_err(dev, "failed to get aclk\n");
-		goto err_get_aclk;
+		return ret;
 	}
 
 	ret = clk_enable(&imclk2);
 	if (ret < 0) {
 		dev_err(dev, "failed to enable imclk2 (chip detect clk)\n");
-		goto err_imclk2;
+		return ret;
 	}
 
 	ret = clk_enable(&aclk);
@@ -1026,11 +1026,6 @@ err_get_reset:
 	clk_disable(&aclk);
 err_aclk:
 	clk_disable(&imclk2);
-err_imclk2:
-	clk_free(&aclk);
-err_get_aclk:
-	clk_free(&imclk2);
-err_get_imclk2:
 	return ret;
 }
 
@@ -1071,7 +1066,7 @@ static int renesas_sdhi_probe(struct udevice *dev)
 		ret = clk_set_rate(&priv->clkh, 800000000);
 		if (ret < 0) {
 			dev_err(dev, "failed to set rate for SDnH clock (%d)\n", ret);
-			goto err_clk;
+			return ret;
 		}
 	}
 
@@ -1079,13 +1074,13 @@ static int renesas_sdhi_probe(struct udevice *dev)
 	ret = clk_set_rate(&priv->clk, 200000000);
 	if (ret < 0) {
 		dev_err(dev, "failed to set rate for SDn clock (%d)\n", ret);
-		goto err_clkh;
+		return ret;
 	}
 
 	ret = clk_enable(&priv->clk);
 	if (ret) {
 		dev_err(dev, "failed to enable SDn clock (%d)\n", ret);
-		goto err_clkh;
+		return ret;
 	}
 
 	if (device_is_compatible(dev, "renesas,sdhi-r9a07g044"))
@@ -1107,10 +1102,6 @@ static int renesas_sdhi_probe(struct udevice *dev)
 
 err_tmio_probe:
 	clk_disable(&priv->clk);
-err_clkh:
-	clk_free(&priv->clkh);
-err_clk:
-	clk_free(&priv->clk);
 	return ret;
 }
 
diff --git a/drivers/mmc/snps_dw_mmc.c b/drivers/mmc/snps_dw_mmc.c
index 50a8805e736..0134399e393 100644
--- a/drivers/mmc/snps_dw_mmc.c
+++ b/drivers/mmc/snps_dw_mmc.c
@@ -46,7 +46,7 @@ static int snps_dwmmc_clk_setup(struct udevice *dev)
 
 	ret = clk_enable(&clk_ciu);
 	if (ret && ret != -ENOSYS && ret != -ENOTSUPP)
-		goto clk_err_ciu;
+		goto clk_err;
 
 	host->bus_hz = clk_get_rate(&clk_ciu);
 	if (host->bus_hz < CLOCK_MIN) {
@@ -60,16 +60,12 @@ static int snps_dwmmc_clk_setup(struct udevice *dev)
 
 	ret = clk_enable(&clk_biu);
 	if (ret && ret != -ENOSYS && ret != -ENOTSUPP)
-		goto clk_err_biu;
+		goto clk_err_ciu_dis;
 
 	return 0;
 
-clk_err_biu:
-	clk_free(&clk_biu);
 clk_err_ciu_dis:
 	clk_disable(&clk_ciu);
-clk_err_ciu:
-	clk_free(&clk_ciu);
 clk_err:
 	dev_err(dev, "failed to setup clocks, ret %d\n", ret);
 
diff --git a/drivers/mmc/socfpga_dw_mmc.c b/drivers/mmc/socfpga_dw_mmc.c
index be3d8bfb3d7..387cb8b6b50 100644
--- a/drivers/mmc/socfpga_dw_mmc.c
+++ b/drivers/mmc/socfpga_dw_mmc.c
@@ -99,7 +99,6 @@ static int socfpga_dwmmc_get_clk_rate(struct udevice *dev)
 
 	host->bus_hz = clk_get_rate(&clk);
 
-	clk_free(&clk);
 #else
 	/* Fixed clock divide by 4 which due to the SDMMC wrapper */
 	host->bus_hz = cm_get_mmc_controller_clk_hz();
diff --git a/drivers/mmc/stm32_sdmmc2.c b/drivers/mmc/stm32_sdmmc2.c
index 5ff5e1a4d8b..a2b111a8435 100644
--- a/drivers/mmc/stm32_sdmmc2.c
+++ b/drivers/mmc/stm32_sdmmc2.c
@@ -766,10 +766,8 @@ static int stm32_sdmmc2_probe(struct udevice *dev)
 	int ret;
 
 	ret = clk_enable(&plat->clk);
-	if (ret) {
-		clk_free(&plat->clk);
+	if (ret)
 		return ret;
-	}
 
 	upriv->mmc = &plat->mmc;
 
diff --git a/drivers/mmc/uniphier-sd.c b/drivers/mmc/uniphier-sd.c
index 75003a0113e..8cde4308aae 100644
--- a/drivers/mmc/uniphier-sd.c
+++ b/drivers/mmc/uniphier-sd.c
@@ -64,7 +64,6 @@ static int uniphier_sd_probe(struct udevice *dev)
 	ret = clk_set_rate(&priv->clk, ULONG_MAX);
 	if (ret < 0) {
 		dev_err(dev, "failed to set rate for host clock\n");
-		clk_free(&priv->clk);
 		return ret;
 	}
 
diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index a2151f98491..0e0441472b8 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1999,10 +1999,8 @@ atmel_hsmc_nand_controller_remove(struct atmel_nand_controller *nc)
 
 	hsmc_nc = container_of(nc, struct atmel_hsmc_nand_controller, base);
 
-	if (hsmc_nc->clk) {
+	if (hsmc_nc->clk)
 		clk_disable_unprepare(hsmc_nc->clk);
-		devm_clk_put(nc->dev, hsmc_nc->clk);
-	}
 
 	return 0;
 }
diff --git a/drivers/mtd/renesas_rpc_hf.c b/drivers/mtd/renesas_rpc_hf.c
index aca7a6cdd25..979b64d4a2f 100644
--- a/drivers/mtd/renesas_rpc_hf.c
+++ b/drivers/mtd/renesas_rpc_hf.c
@@ -370,7 +370,6 @@ static int rpc_hf_probe(struct udevice *dev)
 	}
 
 	ret = clk_enable(&clk);
-	clk_free(&clk);
 	if (ret) {
 		dev_err(dev, "Failed to enable RPC clock\n");
 		return ret;
diff --git a/drivers/net/bcm6348-eth.c b/drivers/net/bcm6348-eth.c
index 72dcd07d30d..15a94f6ce9a 100644
--- a/drivers/net/bcm6348-eth.c
+++ b/drivers/net/bcm6348-eth.c
@@ -457,8 +457,6 @@ static int bcm6348_eth_probe(struct udevice *dev)
 			pr_err("%s: error enabling clock %d\n", __func__, i);
 			return ret;
 		}
-
-		clk_free(&clk);
 	}
 
 	/* try to perform resets */
diff --git a/drivers/net/bcm6368-eth.c b/drivers/net/bcm6368-eth.c
index fdd938ce0dd..9679a45b075 100644
--- a/drivers/net/bcm6368-eth.c
+++ b/drivers/net/bcm6368-eth.c
@@ -546,8 +546,6 @@ static int bcm6368_eth_probe(struct udevice *dev)
 			pr_err("%s: error enabling clock %d\n", __func__, i);
 			return ret;
 		}
-
-		clk_free(&clk);
 	}
 
 	/* try to perform resets */
diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index a174344b3ef..c8696358d6f 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -702,7 +702,6 @@ int designware_eth_probe(struct udevice *dev)
 			err = clk_enable(&priv->clocks[i]);
 			if (err && err != -ENOSYS && err != -ENOTSUPP) {
 				pr_err("failed to enable clock %d\n", i);
-				clk_free(&priv->clocks[i]);
 				goto clk_err;
 			}
 			priv->clock_count++;
diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index e40e399c802..9b3bce1dc87 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1382,38 +1382,30 @@ static int eqos_probe_resources_tegra186(struct udevice *dev)
 	ret = clk_get_by_name(dev, "master_bus", &eqos->clk_master_bus);
 	if (ret) {
 		pr_err("clk_get_by_name(master_bus) failed: %d", ret);
-		goto err_free_clk_slave_bus;
+		goto err_free_gpio_phy_reset;
 	}
 
 	ret = clk_get_by_name(dev, "rx", &eqos->clk_rx);
 	if (ret) {
 		pr_err("clk_get_by_name(rx) failed: %d", ret);
-		goto err_free_clk_master_bus;
+		goto err_free_gpio_phy_reset;
 	}
 
 	ret = clk_get_by_name(dev, "ptp_ref", &eqos->clk_ptp_ref);
 	if (ret) {
 		pr_err("clk_get_by_name(ptp_ref) failed: %d", ret);
-		goto err_free_clk_rx;
+		goto err_free_gpio_phy_reset;
 	}
 
 	ret = clk_get_by_name(dev, "tx", &eqos->clk_tx);
 	if (ret) {
 		pr_err("clk_get_by_name(tx) failed: %d", ret);
-		goto err_free_clk_ptp_ref;
+		goto err_free_gpio_phy_reset;
 	}
 
 	debug("%s: OK\n", __func__);
 	return 0;
 
-err_free_clk_ptp_ref:
-	clk_free(&eqos->clk_ptp_ref);
-err_free_clk_rx:
-	clk_free(&eqos->clk_rx);
-err_free_clk_master_bus:
-	clk_free(&eqos->clk_master_bus);
-err_free_clk_slave_bus:
-	clk_free(&eqos->clk_slave_bus);
 err_free_gpio_phy_reset:
 	dm_gpio_free(dev, &eqos->phy_reset_gpio);
 err_free_reset_eqos:
@@ -1451,13 +1443,13 @@ static int eqos_probe_resources_stm32(struct udevice *dev)
 	ret = clk_get_by_name(dev, "mac-clk-rx", &eqos->clk_rx);
 	if (ret) {
 		pr_err("clk_get_by_name(rx) failed: %d", ret);
-		goto err_free_clk_master_bus;
+		goto err_probe;
 	}
 
 	ret = clk_get_by_name(dev, "mac-clk-tx", &eqos->clk_tx);
 	if (ret) {
 		pr_err("clk_get_by_name(tx) failed: %d", ret);
-		goto err_free_clk_rx;
+		goto err_probe;
 	}
 
 	/*  Get ETH_CLK clocks (optional) */
@@ -1468,10 +1460,6 @@ static int eqos_probe_resources_stm32(struct udevice *dev)
 	debug("%s: OK\n", __func__);
 	return 0;
 
-err_free_clk_rx:
-	clk_free(&eqos->clk_rx);
-err_free_clk_master_bus:
-	clk_free(&eqos->clk_master_bus);
 err_probe:
 
 	debug("%s: returns %d\n", __func__, ret);
@@ -1489,13 +1477,6 @@ static int eqos_remove_resources_tegra186(struct udevice *dev)
 
 	debug("%s(dev=%p):\n", __func__, dev);
 
-#ifdef CONFIG_CLK
-	clk_free(&eqos->clk_tx);
-	clk_free(&eqos->clk_ptp_ref);
-	clk_free(&eqos->clk_rx);
-	clk_free(&eqos->clk_slave_bus);
-	clk_free(&eqos->clk_master_bus);
-#endif
 	dm_gpio_free(dev, &eqos->phy_reset_gpio);
 	reset_free(&eqos->reset_ctl);
 
@@ -1505,19 +1486,7 @@ static int eqos_remove_resources_tegra186(struct udevice *dev)
 
 static int eqos_remove_resources_stm32(struct udevice *dev)
 {
-	struct eqos_priv * __maybe_unused eqos = dev_get_priv(dev);
-
 	debug("%s(dev=%p):\n", __func__, dev);
-
-#ifdef CONFIG_CLK
-	clk_free(&eqos->clk_tx);
-	clk_free(&eqos->clk_rx);
-	clk_free(&eqos->clk_master_bus);
-	if (clk_valid(&eqos->clk_ck))
-		clk_free(&eqos->clk_ck);
-#endif
-
-	debug("%s: OK\n", __func__);
 	return 0;
 }
 
diff --git a/drivers/net/dwc_eth_qos_imx.c b/drivers/net/dwc_eth_qos_imx.c
index e3f55dd9817..9c4e3904413 100644
--- a/drivers/net/dwc_eth_qos_imx.c
+++ b/drivers/net/dwc_eth_qos_imx.c
@@ -70,30 +70,24 @@ static int eqos_probe_resources_imx(struct udevice *dev)
 	ret = clk_get_by_name(dev, "ptp_ref", &eqos->clk_ptp_ref);
 	if (ret) {
 		dev_dbg(dev, "clk_get_by_name(ptp_ref) failed: %d", ret);
-		goto err_free_clk_master_bus;
+		goto err_probe;
 	}
 
 	ret = clk_get_by_name(dev, "tx", &eqos->clk_tx);
 	if (ret) {
 		dev_dbg(dev, "clk_get_by_name(tx) failed: %d", ret);
-		goto err_free_clk_ptp_ref;
+		goto err_probe;
 	}
 
 	ret = clk_get_by_name(dev, "pclk", &eqos->clk_ck);
 	if (ret) {
 		dev_dbg(dev, "clk_get_by_name(pclk) failed: %d", ret);
-		goto err_free_clk_tx;
+		goto err_probe;
 	}
 
 	debug("%s: OK\n", __func__);
 	return 0;
 
-err_free_clk_tx:
-	clk_free(&eqos->clk_tx);
-err_free_clk_ptp_ref:
-	clk_free(&eqos->clk_ptp_ref);
-err_free_clk_master_bus:
-	clk_free(&eqos->clk_master_bus);
 err_probe:
 
 	debug("%s: returns %d\n", __func__, ret);
@@ -102,16 +96,7 @@ err_probe:
 
 static int eqos_remove_resources_imx(struct udevice *dev)
 {
-	struct eqos_priv *eqos = dev_get_priv(dev);
-
 	debug("%s(dev=%p):\n", __func__, dev);
-
-	clk_free(&eqos->clk_ck);
-	clk_free(&eqos->clk_tx);
-	clk_free(&eqos->clk_ptp_ref);
-	clk_free(&eqos->clk_master_bus);
-
-	debug("%s: OK\n", __func__);
 	return 0;
 }
 
diff --git a/drivers/net/dwc_eth_qos_qcom.c b/drivers/net/dwc_eth_qos_qcom.c
index df83f1c5f9e..8178138fc65 100644
--- a/drivers/net/dwc_eth_qos_qcom.c
+++ b/drivers/net/dwc_eth_qos_qcom.c
@@ -575,7 +575,6 @@ static int eqos_remove_resources_qcom(struct udevice *dev)
 
 	debug("%s(dev=%p):\n", __func__, dev);
 
-	clk_free(&eqos->clk_tx);
 	dm_gpio_free(dev, &eqos->phy_reset_gpio);
 	reset_free(&eqos->reset_ctl);
 
diff --git a/drivers/net/dwc_eth_qos_rockchip.c b/drivers/net/dwc_eth_qos_rockchip.c
index 834307a4477..fa9e513faea 100644
--- a/drivers/net/dwc_eth_qos_rockchip.c
+++ b/drivers/net/dwc_eth_qos_rockchip.c
@@ -372,7 +372,7 @@ static int eqos_probe_resources_rk(struct udevice *dev)
 		ret = clk_get_by_name(dev, "clk_mac_speed", &eqos->clk_tx);
 		if (ret) {
 			dev_dbg(dev, "clk_get_by_name(clk_mac_speed) failed: %d", ret);
-			goto err_free_clk_master_bus;
+			goto err_release_resets;
 		}
 	}
 
@@ -393,8 +393,6 @@ static int eqos_probe_resources_rk(struct udevice *dev)
 
 	return 0;
 
-err_free_clk_master_bus:
-	clk_free(&eqos->clk_master_bus);
 err_release_resets:
 	reset_release_bulk(&data->resets);
 err_free:
@@ -412,8 +410,6 @@ static int eqos_remove_resources_rk(struct udevice *dev)
 	if (dm_gpio_is_valid(&eqos->phy_reset_gpio))
 		dm_gpio_free(dev, &eqos->phy_reset_gpio);
 
-	clk_free(&eqos->clk_tx);
-	clk_free(&eqos->clk_master_bus);
 	reset_release_bulk(&data->resets);
 	free(data);
 
diff --git a/drivers/net/sni_ave.c b/drivers/net/sni_ave.c
index 8eeecbc4cf3..a265ce9df57 100644
--- a/drivers/net/sni_ave.c
+++ b/drivers/net/sni_ave.c
@@ -777,7 +777,7 @@ static int ave_of_to_plat(struct udevice *dev)
 		if (ret) {
 			dev_err(dev, "Failed to get clocks property: %d\n",
 				ret);
-			goto out_clk_free;
+			return ret;
 		}
 		priv->nclks++;
 	}
@@ -823,9 +823,6 @@ static int ave_of_to_plat(struct udevice *dev)
 out_reset_free:
 	while (--nr >= 0)
 		reset_free(&priv->rst[nr]);
-out_clk_free:
-	while (--nc >= 0)
-		clk_free(&priv->clk[nc]);
 
 	return ret;
 }
diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
index 18a33c4c0e3..6da018c0f9d 100644
--- a/drivers/net/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ti/am65-cpsw-nuss.c
@@ -948,7 +948,6 @@ static int am65_cpsw_probe_nuss(struct udevice *dev)
 		 cpsw_common->bus_freq);
 
 out:
-	clk_free(&cpsw_common->fclk);
 	power_domain_free(&cpsw_common->pwrdmn);
 	return ret;
 }
diff --git a/drivers/phy/bcm6318-usbh-phy.c b/drivers/phy/bcm6318-usbh-phy.c
index 1c10853940a..a2fa446cb1c 100644
--- a/drivers/phy/bcm6318-usbh-phy.c
+++ b/drivers/phy/bcm6318-usbh-phy.c
@@ -98,8 +98,6 @@ static int bcm6318_usbh_probe(struct udevice *dev)
 	if (ret < 0)
 		return ret;
 
-	clk_free(&clk);
-
 	/* enable power domain */
 	ret = power_domain_get(dev, &pwr_dom);
 	if (ret < 0)
diff --git a/drivers/phy/bcm6348-usbh-phy.c b/drivers/phy/bcm6348-usbh-phy.c
index ce6be3d7dab..857fb575ef1 100644
--- a/drivers/phy/bcm6348-usbh-phy.c
+++ b/drivers/phy/bcm6348-usbh-phy.c
@@ -62,8 +62,6 @@ static int bcm6348_usbh_probe(struct udevice *dev)
 	if (ret < 0)
 		return ret;
 
-	clk_free(&clk);
-
 	/* perform reset */
 	ret = reset_get_by_index(dev, 0, &rst_ctl);
 	if (ret < 0)
diff --git a/drivers/phy/bcm6368-usbh-phy.c b/drivers/phy/bcm6368-usbh-phy.c
index d057f1f52e8..1a2870d5149 100644
--- a/drivers/phy/bcm6368-usbh-phy.c
+++ b/drivers/phy/bcm6368-usbh-phy.c
@@ -137,8 +137,6 @@ static int bcm6368_usbh_probe(struct udevice *dev)
 	if (ret < 0)
 		return ret;
 
-	clk_free(&clk);
-
 #if defined(CONFIG_POWER_DOMAIN)
 	/* enable power domain */
 	ret = power_domain_get(dev, &pwr_dom);
@@ -173,8 +171,6 @@ static int bcm6368_usbh_probe(struct udevice *dev)
 		ret = clk_enable(&clk);
 		if (ret < 0)
 			return ret;
-
-		clk_free(&clk);
 	}
 
 	mdelay(100);
diff --git a/drivers/phy/meson-axg-mipi-dphy.c b/drivers/phy/meson-axg-mipi-dphy.c
index a69b6c97594..faa1d9d6d37 100644
--- a/drivers/phy/meson-axg-mipi-dphy.c
+++ b/drivers/phy/meson-axg-mipi-dphy.c
@@ -369,7 +369,6 @@ int meson_axg_mipi_dphy_probe(struct udevice *dev)
 	ret = clk_enable(&priv->clk);
 	if (ret && ret != -ENOSYS && ret != -ENOTSUPP) {
 		pr_err("failed to enable PHY clock\n");
-		clk_free(&priv->clk);
 		return ret;
 	}
 #endif
diff --git a/drivers/phy/meson-g12a-usb3-pcie.c b/drivers/phy/meson-g12a-usb3-pcie.c
index 40a5da948dc..1eaff410efa 100644
--- a/drivers/phy/meson-g12a-usb3-pcie.c
+++ b/drivers/phy/meson-g12a-usb3-pcie.c
@@ -398,7 +398,6 @@ int meson_g12a_usb3_pcie_phy_probe(struct udevice *dev)
 	ret = clk_enable(&priv->clk);
 	if (ret && ret != -ENOENT && ret != -ENOTSUPP) {
 		pr_err("failed to enable PHY clock\n");
-		clk_free(&priv->clk);
 		return ret;
 	}
 #endif
diff --git a/drivers/phy/meson-gxl-usb2.c b/drivers/phy/meson-gxl-usb2.c
index 8f5e4a43661..d633effa404 100644
--- a/drivers/phy/meson-gxl-usb2.c
+++ b/drivers/phy/meson-gxl-usb2.c
@@ -203,7 +203,6 @@ int meson_gxl_usb2_phy_probe(struct udevice *dev)
 	ret = clk_enable(&priv->clk);
 	if (ret && ret != -ENOSYS && ret != -ENOTSUPP) {
 		pr_err("failed to enable PHY clock\n");
-		clk_free(&priv->clk);
 		return ret;
 	}
 #endif
diff --git a/drivers/phy/phy-rcar-gen2.c b/drivers/phy/phy-rcar-gen2.c
index 17940959246..e528c4ec579 100644
--- a/drivers/phy/phy-rcar-gen2.c
+++ b/drivers/phy/phy-rcar-gen2.c
@@ -172,7 +172,6 @@ static int rcar_gen2_phy_remove(struct udevice *dev)
 	struct rcar_gen2_phy *priv = dev_get_priv(dev);
 
 	clk_disable(&priv->clk);
-	clk_free(&priv->clk);
 
 	return 0;
 }
diff --git a/drivers/phy/phy-rcar-gen3.c b/drivers/phy/phy-rcar-gen3.c
index 7159e7e8716..03c747b373b 100644
--- a/drivers/phy/phy-rcar-gen3.c
+++ b/drivers/phy/phy-rcar-gen3.c
@@ -142,7 +142,6 @@ static int rcar_gen3_phy_remove(struct udevice *dev)
 	struct rcar_gen3_phy *priv = dev_get_priv(dev);
 
 	clk_disable(&priv->clk);
-	clk_free(&priv->clk);
 
 	return 0;
 }
diff --git a/drivers/pinctrl/pinctrl-k210.c b/drivers/pinctrl/pinctrl-k210.c
index 13f0a342686..ee35dfe1420 100644
--- a/drivers/pinctrl/pinctrl-k210.c
+++ b/drivers/pinctrl/pinctrl-k210.c
@@ -691,23 +691,19 @@ static int k210_pc_probe(struct udevice *dev)
 
 	ret = clk_enable(&priv->clk);
 	if (ret && ret != -ENOSYS && ret != -ENOTSUPP)
-		goto err;
+		return ret;
 
 	ret = dev_read_phandle_with_args(dev, "canaan,k210-sysctl-power",
 					NULL, 1, 0, &args);
         if (ret)
-		goto err;
+		return ret;
 
-	if (args.args_count != 1) {
-		ret = -EINVAL;
-		goto err;
-        }
+	if (args.args_count != 1)
+		return -EINVAL;
 
 	priv->sysctl = syscon_node_to_regmap(args.node);
-	if (IS_ERR(priv->sysctl)) {
-		ret = PTR_ERR(priv->sysctl);
-		goto err;
-	}
+	if (IS_ERR(priv->sysctl))
+		return PTR_ERR(priv->sysctl);
 
 	priv->power_offset = args.args[0];
 
@@ -728,10 +724,6 @@ static int k210_pc_probe(struct udevice *dev)
 	}
 
 	return 0;
-
-err:
-	clk_free(&priv->clk);
-	return ret;
 }
 
 static const struct udevice_id k210_pc_ids[] = {
diff --git a/drivers/power/domain/imx8mp-hsiomix.c b/drivers/power/domain/imx8mp-hsiomix.c
index 6a721a934a7..e2d772c5ec7 100644
--- a/drivers/power/domain/imx8mp-hsiomix.c
+++ b/drivers/power/domain/imx8mp-hsiomix.c
@@ -111,7 +111,7 @@ static int imx8mp_hsiomix_probe(struct udevice *dev)
 
 	ret = power_domain_get_by_name(dev, &priv->pd_bus, "bus");
 	if (ret < 0)
-		goto err_pd_bus;
+		return ret;
 
 	ret = power_domain_get_by_name(dev, &priv->pd_usb, "usb");
 	if (ret < 0)
@@ -133,8 +133,6 @@ err_pd_usb_phy1:
 	power_domain_free(&priv->pd_usb);
 err_pd_usb:
 	power_domain_free(&priv->pd_bus);
-err_pd_bus:
-	clk_free(&priv->clk_usb);
 	return ret;
 }
 
diff --git a/drivers/rtc/stm32_rtc.c b/drivers/rtc/stm32_rtc.c
index 1753283460d..ec7584c3d70 100644
--- a/drivers/rtc/stm32_rtc.c
+++ b/drivers/rtc/stm32_rtc.c
@@ -223,10 +223,8 @@ static int stm32_rtc_init(struct udevice *dev)
 		return ret;
 
 	ret = clk_enable(&clk);
-	if (ret) {
-		clk_free(&clk);
+	if (ret)
 		return ret;
-	}
 
 	rate = clk_get_rate(&clk);
 
@@ -275,10 +273,8 @@ static int stm32_rtc_init(struct udevice *dev)
 unlock:
 	stm32_rtc_lock(dev);
 
-	if (ret) {
+	if (ret)
 		clk_disable(&clk);
-		clk_free(&clk);
-	}
 
 	return ret;
 }
@@ -298,17 +294,13 @@ static int stm32_rtc_probe(struct udevice *dev)
 		return ret;
 
 	ret = clk_enable(&clk);
-	if (ret) {
-		clk_free(&clk);
+	if (ret)
 		return ret;
-	}
 
 	ret = stm32_rtc_init(dev);
 
-	if (ret) {
+	if (ret)
 		clk_disable(&clk);
-		clk_free(&clk);
-	}
 
 	return ret;
 }
diff --git a/drivers/serial/atmel_usart.c b/drivers/serial/atmel_usart.c
index 9853f49c94f..9827c006fa8 100644
--- a/drivers/serial/atmel_usart.c
+++ b/drivers/serial/atmel_usart.c
@@ -253,8 +253,6 @@ static int atmel_serial_enable_clk(struct udevice *dev)
 
 	priv->usart_clk_rate = clk_rate;
 
-	clk_free(&clk);
-
 	return 0;
 }
 #endif
diff --git a/drivers/serial/serial_bcm6345.c b/drivers/serial/serial_bcm6345.c
index 2359656a239..13bc51725cd 100644
--- a/drivers/serial/serial_bcm6345.c
+++ b/drivers/serial/serial_bcm6345.c
@@ -239,7 +239,6 @@ static int bcm6345_serial_probe(struct udevice *dev)
 	if (ret < 0)
 		return ret;
 	priv->uartclk = clk_get_rate(&clk);
-	clk_free(&clk);
 
 	/* initialize serial */
 	return bcm6345_serial_init(priv->base, priv->uartclk, CONFIG_BAUDRATE);
diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
index a22623c316e..f4d96313b93 100644
--- a/drivers/serial/serial_msm.c
+++ b/drivers/serial/serial_msm.c
@@ -185,7 +185,6 @@ static int msm_uart_clk_init(struct udevice *dev)
 		return ret;
 
 	ret = clk_set_rate(&clk, clk_rate);
-	clk_free(&clk);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/serial/serial_pic32.c b/drivers/serial/serial_pic32.c
index 3c5d37ce0ab..0a03a9a2549 100644
--- a/drivers/serial/serial_pic32.c
+++ b/drivers/serial/serial_pic32.c
@@ -155,7 +155,6 @@ static int pic32_uart_probe(struct udevice *dev)
 	if (ret < 0)
 		return ret;
 	priv->uartclk = clk_get_rate(&clk);
-	clk_free(&clk);
 
 	/* initialize serial */
 	return pic32_serial_init(priv->base, priv->uartclk, CONFIG_BAUDRATE);
diff --git a/drivers/spi/atcspi200_spi.c b/drivers/spi/atcspi200_spi.c
index de9c14837cd..70cb242cd31 100644
--- a/drivers/spi/atcspi200_spi.c
+++ b/drivers/spi/atcspi200_spi.c
@@ -362,7 +362,6 @@ static int atcspi200_spi_get_clk(struct udevice *bus)
 		return -EINVAL;
 
 	ns->clock = clk_rate;
-	clk_free(&clk);
 
 	return 0;
 }
diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index cb64119f972..bd73e4fddf1 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -877,7 +877,6 @@ static int atmel_qspi_set_gclk(struct udevice *bus, uint hz)
 	ret = clk_enable(&gclk);
 	if (ret)
 		dev_err(bus, "Failed to enable QSPI generic clock\n");
-	clk_free(&gclk);
 
 	return ret;
 }
@@ -1000,7 +999,7 @@ static int atmel_qspi_enable_clk(struct udevice *dev)
 	ret = clk_enable(&pclk);
 	if (ret) {
 		dev_err(dev, "Failed to enable QSPI peripheral clock\n");
-		goto free_pclk;
+		return ret;
 	}
 
 	if (aq->caps->has_qspick) {
@@ -1008,32 +1007,27 @@ static int atmel_qspi_enable_clk(struct udevice *dev)
 		ret = clk_get_by_name(dev, "qspick", &qspick);
 		if (ret) {
 			dev_err(dev, "Missing QSPI peripheral clock\n");
-			goto free_pclk;
+			return ret;
 		}
 
 		ret = clk_enable(&qspick);
 		if (ret)
 			dev_err(dev, "Failed to enable QSPI system clock\n");
-		clk_free(&qspick);
 	} else if (aq->caps->has_gclk) {
 		ret = clk_get_by_name(dev, "gclk", &gclk);
 		if (ret) {
 			dev_err(dev, "Missing QSPI generic clock\n");
-			goto free_pclk;
+			return ret;
 		}
 
 		ret = clk_enable(&gclk);
 		if (ret)
 			dev_err(dev, "Failed to enable QSPI system clock\n");
-		clk_free(&gclk);
 	}
 
 	aq->bus_clk_rate = clk_get_rate(&pclk);
 	if (!aq->bus_clk_rate)
-		ret = -EINVAL;
-
-free_pclk:
-	clk_free(&pclk);
+		return -EINVAL;
 
 	return ret;
 }
diff --git a/drivers/spi/atmel_spi.c b/drivers/spi/atmel_spi.c
index aec6f4eca9a..d4f0c4c4483 100644
--- a/drivers/spi/atmel_spi.c
+++ b/drivers/spi/atmel_spi.c
@@ -338,8 +338,6 @@ static int atmel_spi_enable_clk(struct udevice *bus)
 
 	priv->bus_clk_rate = clk_rate;
 
-	clk_free(&clk);
-
 	return 0;
 }
 
diff --git a/drivers/spi/bcm63xx_hsspi.c b/drivers/spi/bcm63xx_hsspi.c
index a24bb430cbb..14c5142e917 100644
--- a/drivers/spi/bcm63xx_hsspi.c
+++ b/drivers/spi/bcm63xx_hsspi.c
@@ -581,8 +581,6 @@ static int bcm63xx_hsspi_probe(struct udevice *dev)
 	if (ret < 0 && ret != -ENOSYS)
 		return ret;
 
-	clk_free(&clk);
-
 	/* get clock rate */
 	ret = clk_get_by_name(dev, "pll", &clk);
 	if (ret < 0 && ret != -ENOSYS)
@@ -590,8 +588,6 @@ static int bcm63xx_hsspi_probe(struct udevice *dev)
 
 	priv->clk_rate = clk_get_rate(&clk);
 
-	clk_free(&clk);
-
 	/* perform reset */
 	ret = reset_get_by_index(dev, 0, &rst_ctl);
 	if (ret >= 0) {
diff --git a/drivers/spi/bcm63xx_spi.c b/drivers/spi/bcm63xx_spi.c
index 0600d56c69e..889ac1f966e 100644
--- a/drivers/spi/bcm63xx_spi.c
+++ b/drivers/spi/bcm63xx_spi.c
@@ -391,8 +391,6 @@ static int bcm63xx_spi_probe(struct udevice *dev)
 	if (ret < 0)
 		return ret;
 
-	clk_free(&clk);
-
 	/* perform reset */
 	ret = reset_get_by_index(dev, 0, &rst_ctl);
 	if (ret < 0)
diff --git a/drivers/spi/bcmbca_hsspi.c b/drivers/spi/bcmbca_hsspi.c
index fbe315a7d45..af45882db0a 100644
--- a/drivers/spi/bcmbca_hsspi.c
+++ b/drivers/spi/bcmbca_hsspi.c
@@ -375,8 +375,6 @@ static int bcmbca_hsspi_probe(struct udevice *dev)
 	if (ret < 0 && ret != -ENOSYS)
 		return ret;
 
-	clk_free(&clk);
-
 	/* get clock rate */
 	ret = clk_get_by_name(dev, "pll", &clk);
 	if (ret < 0 && ret != -ENOSYS)
@@ -384,8 +382,6 @@ static int bcmbca_hsspi_probe(struct udevice *dev)
 
 	priv->clk_rate = clk_get_rate(&clk);
 
-	clk_free(&clk);
-
 	/* initialize hardware */
 	writel(0, priv->regs + SPI_IR_MASK_REG);
 
diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index 2efd626852e..1d07f8136dc 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -231,7 +231,6 @@ static int cadence_spi_probe(struct udevice *bus)
 #endif
 		} else {
 			priv->ref_clk_hz = clk_get_rate(&clk);
-			clk_free(&clk);
 			if (IS_ERR_VALUE(priv->ref_clk_hz))
 				return priv->ref_clk_hz;
 		}
diff --git a/drivers/spi/designware_spi.c b/drivers/spi/designware_spi.c
index 1c7d0ca310b..e7ffe2f7e4f 100644
--- a/drivers/spi/designware_spi.c
+++ b/drivers/spi/designware_spi.c
@@ -316,7 +316,6 @@ __weak int dw_spi_get_clk(struct udevice *bus, ulong *rate)
 
 err_rate:
 	clk_disable(&priv->clk);
-	clk_free(&priv->clk);
 
 	return -EINVAL;
 }
@@ -731,10 +730,6 @@ static int dw_spi_remove(struct udevice *bus)
 	ret = clk_disable(&priv->clk);
 	if (ret)
 		return ret;
-
-	clk_free(&priv->clk);
-	if (ret)
-		return ret;
 #endif
 	return 0;
 }
diff --git a/drivers/spi/meson_spifc_a1.c b/drivers/spi/meson_spifc_a1.c
index cca4debb412..943bf6986f1 100644
--- a/drivers/spi/meson_spifc_a1.c
+++ b/drivers/spi/meson_spifc_a1.c
@@ -343,15 +343,6 @@ static int amlogic_spifc_a1_probe(struct udevice *dev)
 	return 0;
 }
 
-static int amlogic_spifc_a1_remove(struct udevice *dev)
-{
-	struct amlogic_spifc_a1 *spifc = dev_get_priv(dev);
-
-	clk_free(&spifc->clk);
-
-	return 0;
-}
-
 static const struct udevice_id meson_spifc_ids[] = {
 	{ .compatible = "amlogic,a1-spifc", },
 	{ }
@@ -379,6 +370,5 @@ U_BOOT_DRIVER(meson_spifc_a1) = {
 	.of_match	= meson_spifc_ids,
 	.ops		= &amlogic_spifc_a1_ops,
 	.probe		= amlogic_spifc_a1_probe,
-	.remove		= amlogic_spifc_a1_remove,
 	.priv_auto	= sizeof(struct amlogic_spifc_a1),
 };
diff --git a/drivers/spi/mvebu_a3700_spi.c b/drivers/spi/mvebu_a3700_spi.c
index 52882e8b263..bba2383a111 100644
--- a/drivers/spi/mvebu_a3700_spi.c
+++ b/drivers/spi/mvebu_a3700_spi.c
@@ -296,15 +296,6 @@ static int mvebu_spi_of_to_plat(struct udevice *bus)
 	return 0;
 }
 
-static int mvebu_spi_remove(struct udevice *bus)
-{
-	struct mvebu_spi_plat *plat = dev_get_plat(bus);
-
-	clk_free(&plat->clk);
-
-	return 0;
-}
-
 static const struct dm_spi_ops mvebu_spi_ops = {
 	.xfer		= mvebu_spi_xfer,
 	.set_speed	= mvebu_spi_set_speed,
@@ -328,5 +319,4 @@ U_BOOT_DRIVER(mvebu_spi) = {
 	.of_to_plat = mvebu_spi_of_to_plat,
 	.plat_auto	= sizeof(struct mvebu_spi_plat),
 	.probe = mvebu_spi_probe,
-	.remove = mvebu_spi_remove,
 };
diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 39620310218..7d5f101a766 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -1148,7 +1148,6 @@ static int apseed_spi_of_to_plat(struct udevice *bus)
 	}
 
 	plat->hclk_rate = clk_get_rate(&hclk);
-	clk_free(&hclk);
 
 	dev_dbg(bus, "ctrl_base = 0x%x, ahb_base = 0x%p, size = 0x%llx\n",
 		(u32)priv->regs, plat->ahb_base, (fdt64_t)plat->ahb_sz);
diff --git a/drivers/spi/stm32_spi.c b/drivers/spi/stm32_spi.c
index 82f6ed783f9..ddb410a94c0 100644
--- a/drivers/spi/stm32_spi.c
+++ b/drivers/spi/stm32_spi.c
@@ -526,22 +526,16 @@ static int stm32_spi_of_to_plat(struct udevice *dev)
 
 	ret = reset_get_by_index(dev, 0, &plat->rst_ctl);
 	if (ret < 0)
-		goto clk_err;
+		return ret;
 
 	ret = gpio_request_list_by_name(dev, "cs-gpios", plat->cs_gpios,
 					ARRAY_SIZE(plat->cs_gpios), 0);
 	if (ret < 0) {
 		dev_err(dev, "Can't get %s cs gpios: %d", dev->name, ret);
-		ret = -ENOENT;
-		goto clk_err;
+		return -ENOENT;
 	}
 
 	return 0;
-
-clk_err:
-	clk_free(&plat->clk);
-
-	return ret;
 }
 
 static int stm32_spi_probe(struct udevice *dev)
@@ -610,7 +604,6 @@ static int stm32_spi_probe(struct udevice *dev)
 
 clk_err:
 	clk_disable(&plat->clk);
-	clk_free(&plat->clk);
 
 	return ret;
 };
@@ -630,13 +623,7 @@ static int stm32_spi_remove(struct udevice *dev)
 
 	reset_free(&plat->rst_ctl);
 
-	ret = clk_disable(&plat->clk);
-	if (ret < 0)
-		return ret;
-
-	clk_free(&plat->clk);
-
-	return ret;
+	return clk_disable(&plat->clk);
 };
 
 static const struct dm_spi_ops stm32_spi_ops = {
diff --git a/drivers/timer/dw-apb-timer.c b/drivers/timer/dw-apb-timer.c
index b171232c484..d94a4e266e4 100644
--- a/drivers/timer/dw-apb-timer.c
+++ b/drivers/timer/dw-apb-timer.c
@@ -75,8 +75,6 @@ static int dw_apb_timer_probe(struct udevice *dev)
 			return ret;
 
 		uc_priv->clock_rate = clk_get_rate(&clk);
-
-		clk_free(&clk);
 	}
 
 	/* init timer */
diff --git a/drivers/timer/ostm_timer.c b/drivers/timer/ostm_timer.c
index 3ec729d2c43..3bf0d4647b5 100644
--- a/drivers/timer/ostm_timer.c
+++ b/drivers/timer/ostm_timer.c
@@ -49,8 +49,6 @@ static int ostm_probe(struct udevice *dev)
 		return ret;
 
 	uc_priv->clock_rate = clk_get_rate(&clk);
-
-	clk_free(&clk);
 #else
 	uc_priv->clock_rate = get_board_sys_clk() / 2;
 #endif
diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 196035215a6..1a3e9350c46 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -361,10 +361,8 @@ static int dwc3_meson_g12a_clk_init(struct dwc3_meson_g12a *priv)
 
 #if CONFIG_IS_ENABLED(CLK)
 	ret = clk_enable(&priv->clk);
-	if (ret) {
-		clk_free(&priv->clk);
+	if (ret)
 		return ret;
-	}
 #endif
 
 	return 0;
diff --git a/drivers/usb/dwc3/dwc3-meson-gxl.c b/drivers/usb/dwc3/dwc3-meson-gxl.c
index cbe8aaa005b..2ce915701a8 100644
--- a/drivers/usb/dwc3/dwc3-meson-gxl.c
+++ b/drivers/usb/dwc3/dwc3-meson-gxl.c
@@ -284,10 +284,8 @@ static int dwc3_meson_gxl_clk_init(struct dwc3_meson_gxl *priv)
 
 #if CONFIG_IS_ENABLED(CLK)
 	ret = clk_enable(&priv->clk);
-	if (ret) {
-		clk_free(&priv->clk);
+	if (ret)
 		return ret;
-	}
 #endif
 
 	return 0;
diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
index fba3595e10f..c6d50fd4551 100644
--- a/drivers/usb/host/ehci-atmel.c
+++ b/drivers/usb/host/ehci-atmel.c
@@ -70,13 +70,7 @@ static int ehci_atmel_enable_clk(struct udevice *dev)
 	if (ret)
 		return -EINVAL;
 
-	ret = clk_enable(&clk);
-	if (ret)
-		return ret;
-
-	clk_free(&clk);
-
-	return 0;
+	return clk_enable(&clk);
 }
 
 static int ehci_atmel_probe(struct udevice *dev)
diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index 33c4a911a09..d3d73d23844 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -115,7 +115,6 @@ static int ohci_da8xx_probe(struct udevice *dev)
 			err = clk_enable(&priv->clocks[i]);
 			if (err) {
 				dev_err(dev, "failed to enable clock %d\n", i);
-				clk_free(&priv->clocks[i]);
 				goto clk_err;
 			}
 			priv->clock_count++;
diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
index 5fc7afb7d21..fedcf786929 100644
--- a/drivers/usb/host/xhci-rcar.c
+++ b/drivers/usb/host/xhci-rcar.c
@@ -90,7 +90,7 @@ static int xhci_rcar_probe(struct udevice *dev)
 	ret = clk_enable(&plat->clk);
 	if (ret) {
 		dev_err(dev, "Failed to enable USB3 clock\n");
-		goto err_clk;
+		return ret;
 	}
 
 	ctx->hcd = (struct xhci_hccr *)plat->hcd_base;
@@ -114,8 +114,6 @@ static int xhci_rcar_probe(struct udevice *dev)
 
 err_fw:
 	clk_disable(&plat->clk);
-err_clk:
-	clk_free(&plat->clk);
 	return ret;
 }
 
@@ -127,7 +125,6 @@ static int xhci_rcar_deregister(struct udevice *dev)
 	ret = xhci_deregister(dev);
 
 	clk_disable(&plat->clk);
-	clk_free(&plat->clk);
 
 	return ret;
 }
diff --git a/drivers/video/atmel_hlcdfb.c b/drivers/video/atmel_hlcdfb.c
index 2bf19a6684b..652ba141801 100644
--- a/drivers/video/atmel_hlcdfb.c
+++ b/drivers/video/atmel_hlcdfb.c
@@ -62,8 +62,6 @@ static int at91_hlcdc_enable_clk(struct udevice *dev)
 
 	priv->clk_rate = clk_rate;
 
-	clk_free(&clk);
-
 	return 0;
 }
 
diff --git a/drivers/video/mali_dp.c b/drivers/video/mali_dp.c
index cbcdb99e1f0..dbb2f538617 100644
--- a/drivers/video/mali_dp.c
+++ b/drivers/video/mali_dp.c
@@ -360,25 +360,18 @@ static int malidp_probe(struct udevice *dev)
 
 	err = malidp_setup_mode(priv, &timings);
 	if (err)
-		goto fail_timings;
+		return err;
 
 	malidp_setup_layer(priv, &timings, MALIDP_LAYER_LV1,
 			   (phys_addr_t)uc_plat->base);
 
 	err = malidp_leave_config(priv);
 	if (err)
-		goto fail_timings;
+		return err;
 
 	malidp_set_configvalid(priv);
 
 	return 0;
-
-fail_timings:
-	clk_free(&priv->aclk);
-fail_aclk:
-	clk_free(&priv->pxlclk);
-
-	return err;
 }
 
 static int malidp_bind(struct udevice *dev)
diff --git a/drivers/video/rockchip/rk3288_hdmi.c b/drivers/video/rockchip/rk3288_hdmi.c
index 327ae787125..8bedee55ad4 100644
--- a/drivers/video/rockchip/rk3288_hdmi.c
+++ b/drivers/video/rockchip/rk3288_hdmi.c
@@ -67,10 +67,8 @@ static int rk3288_clk_config(struct udevice *dev)
 	 * monitor wants
 	 */
 	ret = clk_get_by_index(uc_plat->src_dev, 0, &clk);
-	if (ret >= 0) {
+	if (ret >= 0)
 		ret = clk_set_rate(&clk, 384000000);
-		clk_free(&clk);
-	}
 	if (ret < 0) {
 		debug("%s: Failed to set clock in source device '%s': ret=%d\n",
 		      __func__, uc_plat->src_dev->name, ret);
diff --git a/drivers/video/rockchip/rk_edp.c b/drivers/video/rockchip/rk_edp.c
index 3697d582510..dbd70ad583a 100644
--- a/drivers/video/rockchip/rk_edp.c
+++ b/drivers/video/rockchip/rk_edp.c
@@ -1095,20 +1095,16 @@ static int rk_edp_probe(struct udevice *dev)
 
 	if (edp_data->chip_type == RK3288_DP) {
 		ret = clk_get_by_index(dev, 1, &clk);
-		if (ret >= 0) {
+		if (ret >= 0)
 			ret = clk_set_rate(&clk, 0);
-			clk_free(&clk);
-		}
 		if (ret) {
 			debug("%s: Failed to set EDP clock: ret=%d\n", __func__, ret);
 			return ret;
 		}
 	}
 	ret = clk_get_by_index(uc_plat->src_dev, 0, &clk);
-	if (ret >= 0) {
+	if (ret >= 0)
 		ret = clk_set_rate(&clk, 192000000);
-		clk_free(&clk);
-	}
 	if (ret < 0) {
 		debug("%s: Failed to set clock in source device '%s': ret=%d\n",
 		      __func__, uc_plat->src_dev->name, ret);
diff --git a/drivers/watchdog/designware_wdt.c b/drivers/watchdog/designware_wdt.c
index 447a22d3b36..b22e0ee06a4 100644
--- a/drivers/watchdog/designware_wdt.c
+++ b/drivers/watchdog/designware_wdt.c
@@ -124,13 +124,11 @@ static int designware_wdt_probe(struct udevice *dev)
 
 	ret = clk_enable(&clk);
 	if (ret)
-		goto err;
+		return ret;
 
 	priv->clk_khz = clk_get_rate(&clk) / 1000;
-	if (!priv->clk_khz) {
-		ret = -EINVAL;
-		goto err;
-	}
+	if (!priv->clk_khz)
+		return -EINVAL;
 #else
 	priv->clk_khz = CFG_DW_WDT_CLOCK_KHZ;
 #endif
@@ -139,21 +137,15 @@ static int designware_wdt_probe(struct udevice *dev)
 	    ofnode_read_prop(dev_ofnode(dev), "resets", &ret)) {
 		ret = reset_get_bulk(dev, &priv->resets);
 		if (ret)
-			goto err;
+			return ret;
 
 		ret = reset_deassert_bulk(&priv->resets);
 		if (ret)
-			goto err;
+			return ret;
 	}
 
 	/* reset to disable the watchdog */
 	return designware_wdt_stop(dev);
-
-err:
-#if CONFIG_IS_ENABLED(CLK)
-	clk_free(&clk);
-#endif
-	return ret;
 }
 
 static const struct wdt_ops designware_wdt_ops = {
diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
index 6ab005813f9..01a35b3ab30 100644
--- a/drivers/watchdog/meson_gxbb_wdt.c
+++ b/drivers/watchdog/meson_gxbb_wdt.c
@@ -98,10 +98,8 @@ static int amlogic_wdt_probe(struct udevice *dev)
 		return ret;
 
 	ret = clk_enable(&clk);
-	if (ret) {
-		clk_free(&clk);
+	if (ret)
 		return ret;
-	}
 
 	/* Setup with 1ms timebase */
 	writel(((clk_get_rate(&clk) / 1000) & GXBB_WDT_CTRL_DIV_MASK) |
diff --git a/include/clk.h b/include/clk.h
index ea5f6bd6f79..af23e4f3475 100644
--- a/include/clk.h
+++ b/include/clk.h
@@ -247,19 +247,6 @@ static inline struct clk *devm_clk_get_optional(struct udevice *dev,
  */
 int clk_release_all(struct clk *clk, unsigned int count);
 
-/**
- * devm_clk_put	- "free" a managed clock source
- * @dev: device used to acquire the clock
- * @clk: clock source acquired with devm_clk_get()
- *
- * Note: drivers must ensure that all clk_enable calls made on this
- * clock source are balanced by clk_disable calls prior to calling
- * this function.
- *
- * clk_put should not be called from within interrupt context.
- */
-void devm_clk_put(struct udevice *dev, struct clk *clk);
-
 #else
 
 static inline int clk_get_by_phandle(struct udevice *dev, const
@@ -313,10 +300,6 @@ static inline int clk_release_all(struct clk *clk, unsigned int count)
 {
 	return -ENOSYS;
 }
-
-static inline void devm_clk_put(struct udevice *dev, struct clk *clk)
-{
-}
 #endif
 
 /**
@@ -424,10 +407,6 @@ static inline int clk_release_bulk(struct clk_bulk *bulk)
 	return clk_release_all(bulk->clks, bulk->count);
 }
 
-static inline void clk_free(struct clk *clk)
-{
-}
-
 #if CONFIG_IS_ENABLED(CLK)
 /**
  * clk_request() - Request a clock by provider-specific ID.
-- 
2.37.1

