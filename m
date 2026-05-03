Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1F5CD3426
	for <u-boot@archiver.kernel.org>; Sun,  3 May 2026 12:34:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0CB38460E;
	Sun,  3 May 2026 14:33:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="I98WuJ4o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C8F283EF9; Sun,  3 May 2026 14:21:47 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E6BF83FEC
 for <u-boot@lists.denx.de>; Sun,  3 May 2026 14:21:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 6C21326AAB;
 Sun,  3 May 2026 14:21:45 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f5NfmxIJby3U; Sun,  3 May 2026 14:21:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1777810904; bh=YvP4mHZMNAXrNUUHjMCFc3wX39kTiGW7icaWRA0RYT0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=I98WuJ4oyGrVQZZ5OcLlKnnpBCaiz/or1PcF9p7jRszqpH4c1izM3XPLjRW/t0DoY
 /jVfu/lSFLQu2X6FaTB/T2BL1wivjuwNVANnWz9DjtcVgSRwFMZWv0zElsBuuPX8YI
 eHosUr1dhCTxb3WOZn51Cx5s2M1nyIC0YOymvNWCXBRxrXLbOFIL+8x6GqWr5Vt4T2
 nGo+JsJQryD3GJgCTRXLLymgZisXS5hWGDDnzejIGT3JAguM1OJQ3oxJa6E00Ybn8V
 VssbLcb8JtSCQeBjTN71TqGQrxJb6cyYx+sSYPEfDC6sCiVI7LEkf5wiCX2mLbVrZe
 MQoJPBLHC1yWQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Sun, 03 May 2026 17:51:28 +0530
Subject: [PATCH v2 3/4] mmc: exynos_dw_mmc: add support for HS400ES
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-dwmmc-exynos-hs400-es-v2-3-3ff1526142a7@disroot.org>
References: <20260503-dwmmc-exynos-hs400-es-v2-0-3ff1526142a7@disroot.org>
In-Reply-To: <20260503-dwmmc-exynos-hs400-es-v2-0-3ff1526142a7@disroot.org>
To: Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de
Cc: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anand Moon <linux.amoon@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Lukas Timmermann <uboot@timmermann.space>, 
 Henrik Grimler <henrik@grimler.se>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Mailman-Approved-At: Sun, 03 May 2026 14:33:33 +0200
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

Add support for HS400ES. This is trivial as no new init sequence is
required in the driver, add it to the host driver capabilities, and
direct the HS400ES mode on reusing the HS400 init sequence.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/mmc/exynos_dw_mmc.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 6558cdc803d..e0c4bbb17cc 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -185,6 +185,7 @@ static void exynos_config_hs400(struct dwmci_host *host, enum bus_mode mode)
 	strobe = priv->saved_strobe_ctrl;
 
 	switch (mode) {
+	case MMC_HS_400_ES:
 	case MMC_HS_400:
 		dqs |= DATA_STROBE_EN;
 		strobe = DQS_CTRL_RD_DELAY(strobe, priv->dqs_delay);
@@ -205,6 +206,7 @@ static int exynos_dwmci_clksel(struct dwmci_host *host)
 	u32 timing;
 
 	switch (host->mmc->selected_mode) {
+	case MMC_HS_400_ES:
 	case MMC_HS_400:
 		timing = CLKSEL_UP_SAMPLE(priv->hs400_timing, priv->tuned_sample);
 		break;
@@ -224,7 +226,8 @@ static int exynos_dwmci_clksel(struct dwmci_host *host)
 
 	dwmci_writel(host, priv->chip->clksel, timing);
 
-	if (CONFIG_IS_ENABLED(MMC_HS400_SUPPORT))
+	if (CONFIG_IS_ENABLED(MMC_HS400_SUPPORT) ||
+	    CONFIG_IS_ENABLED(MMC_HS400_ES_SUPPORT))
 		exynos_config_hs400(host, host->mmc->selected_mode);
 
 	return 0;
@@ -239,7 +242,8 @@ static unsigned int exynos_dwmci_get_clk(struct dwmci_host *host, uint freq)
 	/* Should be double rate for DDR or HS mode */
 	if ((host->mmc->selected_mode == MMC_DDR_52 &&
 	     host->mmc->bus_width == 8) ||
-	    host->mmc->selected_mode == MMC_HS_400) {
+	    host->mmc->selected_mode == MMC_HS_400 ||
+	    host->mmc->selected_mode == MMC_HS_400_ES) {
 		freq *= 2;
 	}
 
@@ -264,7 +268,8 @@ static void exynos_dwmci_board_init(struct dwmci_host *host)
 {
 	struct dwmci_exynos_priv_data *priv = exynos_dwmmc_get_priv(host);
 
-	if (CONFIG_IS_ENABLED(MMC_HS400_SUPPORT)) {
+	if (CONFIG_IS_ENABLED(MMC_HS400_SUPPORT) ||
+	    CONFIG_IS_ENABLED(MMC_HS400_ES_SUPPORT)) {
 		priv->saved_strobe_ctrl = dwmci_readl(host, DWMCI_HS400_DLINE_CTRL);
 		priv->saved_dqs_en = dwmci_readl(host, DWMCI_HS400_DQS_EN);
 		priv->saved_dqs_en |= AXI_NON_BLOCKING_WR;
@@ -522,7 +527,7 @@ static int exynos_dwmmc_probe(struct udevice *dev)
 	host->name = dev->name;
 	host->board_init = exynos_dwmci_board_init;
 	host->caps = MMC_MODE_DDR_52MHz | MMC_MODE_HS200 | MMC_MODE_HS400 |
-		     UHS_CAPS;
+		     MMC_MODE_HS400_ES | UHS_CAPS;
 	host->clksel = exynos_dwmci_clksel;
 	host->get_mmc_clk = exynos_dwmci_get_clk;
 

-- 
2.53.0

