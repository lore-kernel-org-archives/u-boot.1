Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025CCC36005
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 11:39:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BDAD81F00;
	Sun, 23 Mar 2025 12:36:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEFDF81D5A; Sun, 23 Mar 2025 12:36:36 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 67D3F81F45
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 12:36:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9707A169C;
 Sun, 23 Mar 2025 04:36:40 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A68313F7D8;
 Sun, 23 Mar 2025 04:36:32 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 18/34] sunxi: mmc: add support for Allwinner A523 MMC mod clock
Date: Sun, 23 Mar 2025 11:35:28 +0000
Message-ID: <20250323113544.7933-19-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250323113544.7933-1-andre.przywara@arm.com>
References: <20250323113544.7933-1-andre.przywara@arm.com>
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

The Allwinner A523 SoC has a slightly changed mod clock, where the P
factor, formerly a shift value, is now a second divider value.
Also the input clock is not PLL_PERIPH0_2X (1200MHz) anymore, but
PLL_PERIPH0_400M, so adjust the input rate calculation accordingly.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/mmc/sunxi_mmc.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
index 432be66c632..8614b04332d 100644
--- a/drivers/mmc/sunxi_mmc.c
+++ b/drivers/mmc/sunxi_mmc.c
@@ -92,6 +92,15 @@ static int mmc_set_mod_clk(struct sunxi_mmc_priv *priv, unsigned int hz)
 		pll = CCM_MMC_CTRL_PLL6;
 		pll_hz = clock_get_pll6();
 #endif
+
+		/*
+		 * The A523/T527 uses PERIPH0_400M as the MMC input clock,
+		 * which is the PERIPH0 nominal rate (1200MHz) / 3.
+		 * Together with the fixed post-divider of 2 of the MMC mod
+		 * clock, that gives a divider of 6.
+		 */
+		if (IS_ENABLED(CONFIG_MACH_SUN55I_A523))
+			pll_hz /= 6;
 	}
 
 	div = pll_hz / hz;
@@ -146,6 +155,10 @@ static int mmc_set_mod_clk(struct sunxi_mmc_priv *priv, unsigned int hz)
 			CCM_MMC_CTRL_SCLK_DLY(sclk_dly);
 	}
 
+	/* The A523 has a second divider, not a shift. */
+	if (IS_ENABLED(CONFIG_MACH_SUN55I_A523))
+		n = (1U << n) - 1;
+
 	writel(CCM_MMC_CTRL_ENABLE| pll | CCM_MMC_CTRL_N(n) |
 	       CCM_MMC_CTRL_M(div) | val, priv->mclkreg);
 
@@ -534,7 +547,8 @@ struct mmc *sunxi_mmc_init(int sdc_no)
 	cfg->host_caps = MMC_MODE_4BIT;
 
 	if ((IS_ENABLED(CONFIG_MACH_SUN50I) || IS_ENABLED(CONFIG_MACH_SUN8I) ||
-	    IS_ENABLED(CONFIG_SUN50I_GEN_H6)) && (sdc_no == 2))
+	    IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_MACH_SUN55I_A523)) &&
+	    (sdc_no == 2))
 		cfg->host_caps = MMC_MODE_8BIT;
 
 	cfg->host_caps |= MMC_MODE_HS_52MHz | MMC_MODE_HS;
-- 
2.46.3

