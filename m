Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98310CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:45:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1736E83937;
	Fri, 17 Oct 2025 17:44:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="SUyil9aw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D19E8386D; Fri, 17 Oct 2025 17:26:46 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B50F83826
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:26:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id DF43B262EA;
 Fri, 17 Oct 2025 17:26:43 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LyOBDer-CFoF; Fri, 17 Oct 2025 17:26:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760714803; bh=xX8uopkLYRZMW16Tw3mPXG9zhR9FUVAKTvbDloFUUP8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=SUyil9awNZ2E5LSrbNNnFmeacya+t6Ii6sMxp0nBpJV44PNwFG6idyRaoHUhfwXYF
 hFgFSxV6K6s/BAdbadYe/2LdJS5KCEbxYBUgNMWUdV5qczmTNyuaYZJV/dyepOwPvj
 n3H0LsG5gUmvYl/8eExu5TcadDJ4SXV5SKTN1z/pYGBgtR8qiOKOlCtCunkhfykVQu
 8/DO71akXoSl5HQxXZ/DmdQwsqnz3Tt0bd0CkPKBgKpMf4oLLiXLlpfIrwm92poAF7
 DfyWO0GKfIlxKPuKWp7U4cSSybIm8ftNE0/srWQWIEcwHAL/njPDPoLBZJipwvp8ag
 zAORYtcJbUDUA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 17 Oct 2025 20:54:13 +0530
Subject: [PATCH 8/9] mmc: exynos_dw_mmc: add support for SD UHS mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-mmc-dw-exynos7870-v1-8-a2c5139d9afe@disroot.org>
References: <20251017-mmc-dw-exynos7870-v1-0-a2c5139d9afe@disroot.org>
In-Reply-To: <20251017-mmc-dw-exynos7870-v1-0-a2c5139d9afe@disroot.org>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Jean-Jacques Hiblot <jjhiblot@ti.com>, 
 Ronald Wahl <ronald.wahl@legrand.com>, Anand Moon <linux.amoon@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Henrik Grimler <henrik@grimler.se>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714654; l=3419;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=xX8uopkLYRZMW16Tw3mPXG9zhR9FUVAKTvbDloFUUP8=;
 b=thS/qkYAFdtVdN/5BpKXi92+V4KYUsk/Wl6enhnX3Zf+Wf9cwG5ktSqr/tx1tAjOpan2QgpOy
 XU17O8+NNCNAXVsYsgQfHK6c9xR85f0yB2iUevg8X3lwyaptJgrqack
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Fri, 17 Oct 2025 17:43:57 +0200
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

SD UHS mode is already supported by the Exynos DW-MMC driver in mainline
Linux. Using that as reference, add support in the U-Boot driver.

The maximum frequency was capped to 200000000, increase it to 208000000,
which is the required frequency for UHS_SDR104, which has the highest
frequency of all UHS modes. Moreover, add UHS_CAPS to host capailities.
These changes allow both host and card to recognize support for all UHS
modes.

SDR104, SDR50, and DDR50 have their own CLKSEL timing values, which
requires the CIU div value to be set in bits 18:16. Move the function
exynos_dwmci_clksel() below exynos_dwmmc_get_ciu_div() so that the
latter is accessible from the former, and add cases for said timing
modes.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/mmc/exynos_dw_mmc.c | 48 ++++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 8311036109837d710ec141137684cd4f45ae449f..d436d33f53b36aadab3621a14e37ced71b23d96e 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -18,7 +18,7 @@
 #include <linux/printk.h>
 
 #define	DWMMC_MAX_CH_NUM		4
-#define	DWMMC_MAX_FREQ			200000000
+#define	DWMMC_MAX_FREQ			208000000
 #define	DWMMC_MIN_FREQ			400000
 #define	DWMMC_MMC0_SDR_TIMING_VAL	0x03030001
 #define	DWMMC_MMC2_SDR_TIMING_VAL	0x03020001
@@ -126,22 +126,6 @@ static int exynos_dwmmc_set_sclk(struct dwmci_host *host, unsigned long rate)
 	return 0;
 }
 
-/* Configure CLKSEL register with chosen timing values */
-static int exynos_dwmci_clksel(struct dwmci_host *host)
-{
-	struct dwmci_exynos_priv_data *priv = exynos_dwmmc_get_priv(host);
-	u32 timing;
-
-	if (host->mmc->selected_mode == MMC_DDR_52)
-		timing = priv->ddr_timing;
-	else
-		timing = priv->sdr_timing;
-
-	dwmci_writel(host, priv->chip->clksel, timing);
-
-	return 0;
-}
-
 /**
  * exynos_dwmmc_get_ciu_div - Get internal clock divider value
  * @host: MMC controller object
@@ -165,6 +149,33 @@ static u8 exynos_dwmmc_get_ciu_div(struct dwmci_host *host)
 				& DWMCI_DIVRATIO_MASK) + 1;
 }
 
+/* Configure CLKSEL register with chosen timing values */
+static int exynos_dwmci_clksel(struct dwmci_host *host)
+{
+	struct dwmci_exynos_priv_data *priv = exynos_dwmmc_get_priv(host);
+	u8 clk_div = exynos_dwmmc_get_ciu_div(host) - 1;
+	u32 timing;
+
+	switch (host->mmc->selected_mode) {
+	case MMC_DDR_52:
+		timing = priv->ddr_timing;
+		break;
+	case UHS_SDR104:
+	case UHS_SDR50:
+		timing = (priv->sdr_timing & 0xfff8ffff) | (clk_div << 16);
+		break;
+	case UHS_DDR50:
+		timing = (priv->ddr_timing & 0xfff8ffff) | (clk_div << 16);
+		break;
+	default:
+		timing = priv->sdr_timing;
+	}
+
+	dwmci_writel(host, priv->chip->clksel, timing);
+
+	return 0;
+}
+
 static unsigned int exynos_dwmci_get_clk(struct dwmci_host *host, uint freq)
 {
 	unsigned long sclk;
@@ -393,7 +404,8 @@ static int exynos_dwmmc_probe(struct udevice *dev)
 
 	host->name = dev->name;
 	host->board_init = exynos_dwmci_board_init;
-	host->caps = MMC_MODE_DDR_52MHz | MMC_MODE_HS200 | MMC_MODE_HS400;
+	host->caps = MMC_MODE_DDR_52MHz | MMC_MODE_HS200 | MMC_MODE_HS400 |
+		     UHS_CAPS;
 	host->clksel = exynos_dwmci_clksel;
 	host->get_mmc_clk = exynos_dwmci_get_clk;
 

-- 
2.51.0

