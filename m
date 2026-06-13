Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3CBCD98C5
	for <u-boot@archiver.kernel.org>; Sat, 13 Jun 2026 13:23:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB98784878;
	Sat, 13 Jun 2026 15:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="kh2MgrNy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EC6A8056B; Sat, 13 Jun 2026 09:44:18 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84D6B8005D
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 09:44:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 470162721D;
 Sat, 13 Jun 2026 09:44:16 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jnFWeblQYQOC; Sat, 13 Jun 2026 09:44:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1781336655; bh=+dAcYzaXunHQKTYfCWUa1qnJG4ZUy5YCP8mmiSiEpiY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=kh2MgrNy/vN4nSXVzbjeSaBmzxPXtT5CemH4z0V4eT7yUWBsiacNhcVzd2UO19WIS
 MSAGdAcpVadJh0L8Aym6k8TleU1fbeo62rXIrJRRN24JWixfsk93LjuLmt4RYmM96C
 w+aWpgcrWklZqaye086urqUGy4Yov/SqS6qGHpi+sr/gDScRiUIAeWb9v7z1Rkg0vu
 aN62zvuFR+euGez5nxKqn9tmN7COHJVzFvEte7zda1vBeSdVzecUz2erWdxOhl3NeK
 7Nd+/T0x3ySgXTR59J2F6sLJWlMSBKZmme5/E5MWDTmZ/YO8MYOAk9q4IGmaHlA0+v
 /nsaeN3R9nnCA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Sat, 13 Jun 2026 13:13:58 +0530
Subject: [PATCH v3 1/4] mmc: exynos_dw_mmc: add proper init sequence for
 HS400 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-dwmmc-exynos-hs400-es-v3-1-d23afa0ad417@disroot.org>
References: <20260613-dwmmc-exynos-hs400-es-v3-0-d23afa0ad417@disroot.org>
In-Reply-To: <20260613-dwmmc-exynos-hs400-es-v3-0-d23afa0ad417@disroot.org>
To: Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de
Cc: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anand Moon <linux.amoon@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Lukas Timmermann <uboot@timmermann.space>, 
 Henrik Grimler <henrik@grimler.se>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Mailman-Approved-At: Sat, 13 Jun 2026 15:22:52 +0200
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

HS400 support was added, but configuration necessary for HS400 support
was left out. Add necessary changes, which includes:
- Device tree properties, such as "samsung,dw-mshc-hs400-timing" and
  "samsung,read-strobe-delay", which function as per dt-bindings.
- Registers related to HS400, which are necessary to enable HS400+ support.
- Appropriate timing tunings for the HS400 mode.

Note that these changes are loosely based off of its Linux kernel
counterpart.

Fixes: bbe3b9fa0922 ("mmc: exynos_dw_mmc: add support for MMC HS200 and HS400 modes")
Reviewed-by: Henrik Grimler <henrik@grimler.se>
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 arch/arm/mach-exynos/include/mach/dwmmc.h |  5 ++
 drivers/mmc/exynos_dw_mmc.c               | 81 +++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/arch/arm/mach-exynos/include/mach/dwmmc.h b/arch/arm/mach-exynos/include/mach/dwmmc.h
index 4432deedef7..50081326c25 100644
--- a/arch/arm/mach-exynos/include/mach/dwmmc.h
+++ b/arch/arm/mach-exynos/include/mach/dwmmc.h
@@ -15,6 +15,11 @@
 #define DWMCI_SET_DRV_CLK(x)		((x) << 16)
 #define DWMCI_SET_DIV_RATIO(x)		((x) << 24)
 
+/* HS400 Related Registers */
+#define DWMCI_HS400_DQS_EN		0x180
+#define DWMCI_HS400_ASYNC_FIFO_CTRL	0x184
+#define DWMCI_HS400_DLINE_CTRL		0x188
+
 /* Protector Register */
 #define DWMCI_EMMCP_BASE		0x1000
 #define EMMCP_MPSECURITY		(DWMCI_EMMCP_BASE + 0x0010)
diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 7ccd113bd79..6558cdc803d 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -8,6 +8,7 @@
 #include <dwmmc.h>
 #include <asm/global_data.h>
 #include <malloc.h>
+#include <mmc.h>
 #include <errno.h>
 #include <asm/arch/dwmmc.h>
 #include <asm/arch/clk.h>
@@ -30,6 +31,14 @@
 #define CLKSEL_UP_SAMPLE(x, y)		(((x) & ~CLKSEL_CCLK_SAMPLE(7)) | \
 					 CLKSEL_CCLK_SAMPLE(y))
 
+/* RCLK_EN register defines */
+#define DATA_STROBE_EN			BIT(0)
+#define AXI_NON_BLOCKING_WR	BIT(7)
+
+/* DLINE_CTRL register defines */
+#define DQS_CTRL_RD_DELAY(x, y)		(((x) & ~0x3FF) | ((y) & 0x3FF))
+#define DQS_CTRL_GET_RD_DELAY(x)	((x) & 0x3FF)
+
 /**
  * DOC: Quirk flags for different Exynos DW MMC blocks
  *
@@ -71,6 +80,11 @@ struct dwmci_exynos_priv_data {
 	struct clk clk;
 	u32 sdr_timing;
 	u32 ddr_timing;
+	u32 hs400_timing;
+	u32 tuned_sample;
+	u32 dqs_delay;
+	u32 saved_dqs_en;
+	u32 saved_strobe_ctrl;
 	const struct exynos_dwmmc_variant *chip;
 };
 
@@ -162,6 +176,27 @@ static u8 exynos_dwmmc_get_ciu_div(struct dwmci_host *host)
 				& DWMCI_DIVRATIO_MASK) + 1;
 }
 
+static void exynos_config_hs400(struct dwmci_host *host, enum bus_mode mode)
+{
+	struct dwmci_exynos_priv_data *priv = exynos_dwmmc_get_priv(host);
+	u32 dqs, strobe;
+
+	dqs = priv->saved_dqs_en;
+	strobe = priv->saved_strobe_ctrl;
+
+	switch (mode) {
+	case MMC_HS_400:
+		dqs |= DATA_STROBE_EN;
+		strobe = DQS_CTRL_RD_DELAY(strobe, priv->dqs_delay);
+		break;
+	default:
+		dqs &= ~DATA_STROBE_EN;
+	}
+
+	dwmci_writel(host, DWMCI_HS400_DQS_EN, dqs);
+	dwmci_writel(host, DWMCI_HS400_DLINE_CTRL, strobe);
+}
+
 /* Configure CLKSEL register with chosen timing values */
 static int exynos_dwmci_clksel(struct dwmci_host *host)
 {
@@ -170,6 +205,9 @@ static int exynos_dwmci_clksel(struct dwmci_host *host)
 	u32 timing;
 
 	switch (host->mmc->selected_mode) {
+	case MMC_HS_400:
+		timing = CLKSEL_UP_SAMPLE(priv->hs400_timing, priv->tuned_sample);
+		break;
 	case MMC_DDR_52:
 		timing = priv->ddr_timing;
 		break;
@@ -186,6 +224,9 @@ static int exynos_dwmci_clksel(struct dwmci_host *host)
 
 	dwmci_writel(host, priv->chip->clksel, timing);
 
+	if (CONFIG_IS_ENABLED(MMC_HS400_SUPPORT))
+		exynos_config_hs400(host, host->mmc->selected_mode);
+
 	return 0;
 }
 
@@ -223,6 +264,16 @@ static void exynos_dwmci_board_init(struct dwmci_host *host)
 {
 	struct dwmci_exynos_priv_data *priv = exynos_dwmmc_get_priv(host);
 
+	if (CONFIG_IS_ENABLED(MMC_HS400_SUPPORT)) {
+		priv->saved_strobe_ctrl = dwmci_readl(host, DWMCI_HS400_DLINE_CTRL);
+		priv->saved_dqs_en = dwmci_readl(host, DWMCI_HS400_DQS_EN);
+		priv->saved_dqs_en |= AXI_NON_BLOCKING_WR;
+		dwmci_writel(host, DWMCI_HS400_DQS_EN, priv->saved_dqs_en);
+		if (!priv->dqs_delay)
+			priv->dqs_delay =
+				DQS_CTRL_GET_RD_DELAY(priv->saved_strobe_ctrl);
+	}
+
 	if (priv->chip->quirks & DWMCI_QUIRK_DISABLE_SMU) {
 		dwmci_writel(host, EMMCP_MPSBEGIN0, 0);
 		dwmci_writel(host, EMMCP_SEND0, 0);
@@ -319,6 +370,22 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 				   DWMCI_SET_DIV_RATIO(div);
 	}
 
+	err = dev_read_u32_array(dev, "samsung,dw-mshc-hs400-timing", timing, 2);
+	if (err) {
+		debug("DWMMC%d: Can't get hs400-timings, using ddr-timings\n",
+		      host->dev_index);
+		priv->hs400_timing = priv->ddr_timing;
+	} else {
+		priv->hs400_timing = DWMCI_SET_SAMPLE_CLK(timing[0]) |
+				     DWMCI_SET_DRV_CLK(timing[1]) |
+				     DWMCI_SET_DIV_RATIO(1);
+		if (dev_read_u32(dev, "samsung,read-strobe-delay", &priv->dqs_delay)) {
+			priv->dqs_delay = 0;
+			debug("DWMMC%d: read-strobe-delay is not found, assuming usage of default value\n",
+			      host->dev_index);
+		}
+	}
+
 	host->buswidth = dev_read_u32_default(dev, "bus-width", 4);
 	host->fifo_depth = dev_read_u32_default(dev, "fifo-depth", 0);
 	host->bus_hz = dev_read_u32_default(dev, "clock-frequency", 0);
@@ -356,6 +423,16 @@ static int exynos_dwmmc_get_best_clksmpl(u8 candidates)
 	return -EIO;
 }
 
+static int dw_mci_exynos_prepare_hs400_tuning(struct dwmci_host *host)
+{
+	struct dwmci_exynos_priv_data *priv = exynos_dwmmc_get_priv(host);
+
+	dwmci_writel(host, priv->chip->clksel, priv->hs400_timing);
+	host->bus_hz = exynos_dwmci_get_clk(host, host->clock);
+
+	return 0;
+}
+
 static int exynos_dwmmc_execute_tuning(struct udevice *dev, u32 opcode)
 {
 	struct dwmci_exynos_priv_data *priv = dev_get_priv(dev);
@@ -365,6 +442,9 @@ static int exynos_dwmmc_execute_tuning(struct udevice *dev, u32 opcode)
 	u32 clksel;
 	int ret;
 
+	if (mmc->hs400_tuning)
+		dw_mci_exynos_prepare_hs400_tuning(host);
+
 	clksel = dwmci_readl(host, priv->chip->clksel);
 	start_smpl = CLKSEL_CCLK_SAMPLE(clksel);
 
@@ -387,6 +467,7 @@ static int exynos_dwmmc_execute_tuning(struct udevice *dev, u32 opcode)
 		return ret;
 	}
 
+	priv->tuned_sample = ret;
 	dwmci_writel(host, priv->chip->clksel, CLKSEL_UP_SAMPLE(clksel, ret));
 
 	return 0;

-- 
2.53.0

