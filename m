Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1ABCD8CA8
	for <u-boot@archiver.kernel.org>; Sat, 13 Jun 2026 13:23:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73412848C5;
	Sat, 13 Jun 2026 15:22:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="kzMZx+BI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B4EF80287; Sat, 13 Jun 2026 09:44:31 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19F888005D
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 09:44:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id D2B242720B;
 Sat, 13 Jun 2026 09:44:28 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2McTITCcEoVE; Sat, 13 Jun 2026 09:44:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1781336668; bh=YvP4mHZMNAXrNUUHjMCFc3wX39kTiGW7icaWRA0RYT0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=kzMZx+BIp0kj+4j90ZlW6KjoWw15zOAtJJdwEAEAzSb6w64Quv4CLZ87ue15VTtHR
 rQ8X7dgWbg2BcFuqbdH4OU3Dnxr3qsNYnPXHvk3KjhW5H19jtHFTsOTSVU1LBegWzM
 6uQOepk9je122wm2RLoLP4jkSxCTfNbHPadR/LPJ/ImYawg6VnTAfeDmSq8uPqymsM
 +YosWCuIEfluqeHUTDkRjLn4WFTGT+1fMd/uildb1yo3wHgZKXahQWkY1HUIZh134x
 PqN5a81GJQoZGP5O5LiNfFtZMeEr6azYTyfDeo98pGBNcCzpMgzyCbvpEiRktyrCLk
 hroWOx9w8nYbA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Sat, 13 Jun 2026 13:14:00 +0530
Subject: [PATCH v3 3/4] mmc: exynos_dw_mmc: add support for HS400ES
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-dwmmc-exynos-hs400-es-v3-3-d23afa0ad417@disroot.org>
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

