Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D816FF8862
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 07:29:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72B30841F2;
	Mon, 27 Apr 2026 09:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="jfk8257J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3A9080433; Mon, 27 Apr 2026 07:53:14 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 277E480077
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 07:53:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id EAEEC27657;
 Mon, 27 Apr 2026 07:53:10 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U9iCaFsqO6OS; Mon, 27 Apr 2026 07:53:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1777269190; bh=CYyUTstkCnMbot5ZRqhy/MJZo4B8Xw9bw5O2fZaesH0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=jfk8257JTYQ0PcWp5qhBONQ1s/IhDPsyXp2U2etaNmcq5aNSepfBQJJGI6X4Ye7WY
 xnSYES2MzfMaBu4dXAlSS65QItDEEqRAu9LjJeHpjbYq17mLS4gKuf3hGfBtrKhOyJ
 IJqK+4S+8t8Xhy8E+fxZKhFXa1aPJVNAj8gIfoLFdeG22fSHqLR2PWXD+bOMe64MkH
 zbaB2ZpjGaz7C6k2tMO9pq6tp6s5rNSuKU4eCP/sq8L1I6utuITebZmUXTyWMayXSt
 0zupCig2E2GyFgkLVEP/E/lTLDNIiefIwIl/Rneptzcn7DF6mxN6V7jwdN4gH5+8v7
 adPlYHeNyOgcw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Mon, 27 Apr 2026 11:22:51 +0530
Subject: [PATCH 3/4] mmc: exynos_dw_mmc: add support for HS400ES
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-dwmmc-exynos-hs400-es-v1-3-3495df40a9ac@disroot.org>
References: <20260427-dwmmc-exynos-hs400-es-v1-0-3495df40a9ac@disroot.org>
In-Reply-To: <20260427-dwmmc-exynos-hs400-es-v1-0-3495df40a9ac@disroot.org>
To: Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de
Cc: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anand Moon <linux.amoon@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Lukas Timmermann <uboot@timmermann.space>, 
 Henrik Grimler <henrik@grimler.se>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Mailman-Approved-At: Mon, 27 Apr 2026 09:28:50 +0200
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
 drivers/mmc/exynos_dw_mmc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index d5e90a9bd5c..34483e4c5a3 100644
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
@@ -238,7 +240,8 @@ static unsigned int exynos_dwmci_get_clk(struct dwmci_host *host, uint freq)
 	/* Should be double rate for DDR or HS mode */
 	if ((host->mmc->selected_mode == MMC_DDR_52 &&
 	     host->mmc->bus_width == 8) ||
-	    host->mmc->selected_mode == MMC_HS_400) {
+	    host->mmc->selected_mode == MMC_HS_400 ||
+	    host->mmc->selected_mode == MMC_HS_400_ES) {
 		freq *= 2;
 	}
 
@@ -263,7 +266,8 @@ static void exynos_dwmci_board_init(struct dwmci_host *host)
 {
 	struct dwmci_exynos_priv_data *priv = exynos_dwmmc_get_priv(host);
 
-	if (CONFIG_IS_ENABLED(MMC_HS400_SUPPORT)) {
+	if (CONFIG_IS_ENABLED(MMC_HS400_SUPPORT) ||
+	    CONFIG_IS_ENABLED(MMC_HS400_ES_SUPPORT)) {
 		priv->saved_strobe_ctrl = dwmci_readl(host, DWMCI_HS400_DLINE_CTRL);
 		priv->saved_dqs_en = dwmci_readl(host, DWMCI_HS400_DQS_EN);
 		priv->saved_dqs_en |= AXI_NON_BLOCKING_WR;
@@ -521,7 +525,7 @@ static int exynos_dwmmc_probe(struct udevice *dev)
 	host->name = dev->name;
 	host->board_init = exynos_dwmci_board_init;
 	host->caps = MMC_MODE_DDR_52MHz | MMC_MODE_HS200 | MMC_MODE_HS400 |
-		     UHS_CAPS;
+		     MMC_MODE_HS400_ES | UHS_CAPS;
 	host->clksel = exynos_dwmci_clksel;
 	host->get_mmc_clk = exynos_dwmci_get_clk;
 

-- 
2.53.0

