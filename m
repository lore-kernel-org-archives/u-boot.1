Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E06AC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 17:26:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADDD2849B1;
	Tue,  7 Jul 2026 19:26:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WzxW+c7Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6662849BA; Tue,  7 Jul 2026 19:26:54 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 865C6849A4
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 19:26:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6a31c05e1f7so776890eaf.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 10:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783445211; x=1784050011; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QsO6eTE8ez6rqQx3LNlhOwpGMqSXiFL4WjhaXZRTPsU=;
 b=WzxW+c7QS+idt5N/vk4pE5EM83x4tlBu3xE1Es/Esm4m+sbRSW06groxbv+aVG3Rym
 OfBSG1uBftjXbzyNCmfmBye4Dk7j57afTGuO2tYcmd4aVVYZjRqFmBozoevLshNNH03F
 CaedjQS1GF0z+Zrb5e8i4SbH2uKRRAdRq5wkuCSSLDxSvY7iai8rSgDKrM7mhOAASqSG
 UA61qhUFd6wWR4XoZUweIEzH3A4Nc+3UCFX/OepJp6BKe+v2Qg5LTtmYDu/4nzTopoLQ
 bej7VglDEn21B9MRdUBkDrFMqD5oYRz1JoAAO44Ve6DuFlfjd9K2Ym81TwBqEKOJ66CZ
 1lBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783445211; x=1784050011;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QsO6eTE8ez6rqQx3LNlhOwpGMqSXiFL4WjhaXZRTPsU=;
 b=qwWOzCyU38IRHWQe4epZD6SHCMtNAuAiiop6S2WDrdvvPBvO3jnBQlWhXna3Uh+mpA
 rn73iPJKCw8T/IiFTf0KN1rV283gliAO8NG/Ct/XO7GP2PuJ5PocKt3xVi2KyBIZy2ug
 dXUTed0ZNiJKOtQdUGgcYiEH7TXzaxvVmSCMdW4IXC5rAZzp1WEMU2J+FXjnjugYZgph
 CdK2ojG8307i+ZjLz4jt5wS41wvqQux/LMtZR99Kfbhujzi9RA2byA+05GjYS0N3ifK6
 Kwe54vFq0nbOPhuREroy0rWmRqoB7j8pjDNUMpm5+uFAPYF0df43uskqjdimNoRChgju
 bGyw==
X-Gm-Message-State: AOJu0YwHZK84J/Hb6tROIHV++SfsggrITIzZG/QyB3FVnTSsa/7DNovi
 QrI4wyA84lyd6krcwZOkpvDybWHpiACwv/JCh4WrwOIxQwEdvvdvvAcKh0sHNrj1NZLWC2nb
X-Gm-Gg: AfdE7clFvaWEbw+6W3YlGSYUE3MtiJtqA1980JyA0s/Np+SBDy2LytyELcJcEJqa7Ki
 Cltswv1S/OP2hB63Z66A3LEt6Sf69ob6Bs7pItfypxUFIdRvdpR3Q97C9rhzepebdzl/puXBoPO
 KVEUXQcg3kuGFCcWBcxVtvKZljlEd33kJqZUdtVjNn2IPN0OXfq84e+HCdZPx2VAJGAI+ZhZsca
 YZ2iscQpqOmO3wPTU4xsUEk89aeXQ+X1k6L3mPMnz9P59b24nJixrQ1tXSsraTKn03sbNhcCrFC
 aEcYIvmA5h7RSY062beMKdxvVSahIei2UH+pL3ksiRdhoU3VNRZEvgz95wzm0MoE+46uF5L6clP
 lRJlCJ40rPMDkdfcnR2qEfi2KWW8fxseRQuxUT1Bm9QmYp4uZIY9eXYLRPYEQt6ZC681zeHrpkR
 Yj52+mEXMIhdwLORXD/Lwr5FuvFrxkR9IqEEmYqkjJZBF9/s+HZBdIYueYclCiaRPoF+av9R/qT
 MQvjqoEJQTyWe4wZ3EMh4h3VQQnlOUvm0qtN66fe/pep9cg7lrUqZAcvCUUn0419/qKPlfr8zb/
 Lu3ghdTd/bmlmE22dw02
X-Received: by 2002:a05:6820:6ae2:b0:6a1:50f0:ccd0 with SMTP id
 006d021491bc7-6a35571fbd2mr3566519eaf.69.1783445210555; 
 Tue, 07 Jul 2026 10:26:50 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (174-29-11-8.hlrn.qwest.net.
 [174.29.11.8]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a31fd2cf7asm8919252eaf.4.2026.07.07.10.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 10:26:50 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v2] mmc: sunxi: mask DATA0 during H6-family clock updates
Date: Tue,  7 Jul 2026 11:26:29 -0600
Message-ID: <20260707172632.789646-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
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

On an H616 board using SPL DM MMC to boot from SD, the initial clock
update command can time out while disabling the card clock. This happens
before SPL can load the FIT from the card, so MMC init fails and SPL has
no bootable MMC device.

The timeout happens in mmc_update_clk() while issuing the
UPCLK_ONLY/WAIT_PRE_OVER command from mmc_config_clock(). Linux marks the
H6/A100/NCAT2-style controllers with mask_data0 and sets CLKCR MASK_DATA0
around clock update commands so the controller does not sample DAT0 as
busy while updating the clock.

Mirror that behavior for H6-family and NCAT2-family controllers in
mmc_config_clock(). The reproduced failure used SPL DM MMC, but the
affected clock-update path is shared with the non-DM SPL MMC path, so
apply the mask in the common code. Leave the command-error recovery
mmc_update_clk() unchanged, matching Linux which applies mask_data0 in the
clock on/off path.

Also clear LOW_POWER_ON while rewriting CLKCR for the update sequence, as
Linux does. U-Boot does not set this bit today, but clearing stale state
keeps the clock update sequence aligned with Linux.

Use the existing SoC-family test style here, like the calibration support
check, so the legacy SPL path is covered without relying on DM compatible
data.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Describe the reproduced H616 SPL DM MMC clock-update timeout.
  - Explain that the affected clock path is shared with non-DM SPL MMC.
  - Fold the DATA0 masking into mmc_config_clock().
  - Leave the command-error recovery clock update unchanged.
  - Justify LOW_POWER_ON clearing as Linux clock-update parity.
  - Explain the SoC-family check for the legacy SPL path.
---
 drivers/mmc/sunxi_mmc.c | 35 ++++++++++++++++++++++++++++++++---
 drivers/mmc/sunxi_mmc.h |  1 +
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
index e28c81afffe..a00a1e45978 100644
--- a/drivers/mmc/sunxi_mmc.c
+++ b/drivers/mmc/sunxi_mmc.c
@@ -64,6 +64,12 @@ static bool sunxi_mmc_can_calibrate(void)
 	       IS_ENABLED(CONFIG_MACH_SUN8I_R40);
 }
 
+static bool sunxi_mmc_needs_data0_mask(void)
+{
+	return IS_ENABLED(CONFIG_SUN50I_GEN_H6) ||
+	       IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2);
+}
+
 static int mmc_set_mod_clk(struct sunxi_mmc_priv *priv, unsigned int hz)
 {
 	unsigned int pll, pll_hz, div, n, oclk_dly, sclk_dly;
@@ -204,12 +210,24 @@ static int mmc_update_clk(struct sunxi_mmc_priv *priv)
 static int mmc_config_clock(struct sunxi_mmc_priv *priv, struct mmc *mmc)
 {
 	unsigned rval = readl(&priv->reg->clkcr);
+	bool mask_data0 = sunxi_mmc_needs_data0_mask();
 
 	/* Disable Clock */
-	rval &= ~SUNXI_MMC_CLK_ENABLE;
+	rval &= ~(SUNXI_MMC_CLK_ENABLE | SUNXI_MMC_CLK_POWERSAVE |
+		  SUNXI_MMC_CLK_MASK_DATA0);
+	if (mask_data0)
+		rval |= SUNXI_MMC_CLK_MASK_DATA0;
 	writel(rval, &priv->reg->clkcr);
-	if (mmc_update_clk(priv))
+	if (mmc_update_clk(priv)) {
+		if (mask_data0)
+			writel(rval & ~SUNXI_MMC_CLK_MASK_DATA0,
+			       &priv->reg->clkcr);
 		return -1;
+	}
+	if (mask_data0) {
+		rval &= ~SUNXI_MMC_CLK_MASK_DATA0;
+		writel(rval, &priv->reg->clkcr);
+	}
 
 	/* Set mod_clk to new rate */
 	if (mmc_set_mod_clk(priv, mmc->clock))
@@ -231,10 +249,21 @@ static int mmc_config_clock(struct sunxi_mmc_priv *priv, struct mmc *mmc)
 #endif
 
 	/* Re-enable Clock */
+	rval &= ~(SUNXI_MMC_CLK_POWERSAVE | SUNXI_MMC_CLK_MASK_DATA0);
 	rval |= SUNXI_MMC_CLK_ENABLE;
+	if (mask_data0)
+		rval |= SUNXI_MMC_CLK_MASK_DATA0;
 	writel(rval, &priv->reg->clkcr);
-	if (mmc_update_clk(priv))
+	if (mmc_update_clk(priv)) {
+		if (mask_data0)
+			writel(rval & ~SUNXI_MMC_CLK_MASK_DATA0,
+			       &priv->reg->clkcr);
 		return -1;
+	}
+	if (mask_data0) {
+		rval &= ~SUNXI_MMC_CLK_MASK_DATA0;
+		writel(rval, &priv->reg->clkcr);
+	}
 
 	return 0;
 }
diff --git a/drivers/mmc/sunxi_mmc.h b/drivers/mmc/sunxi_mmc.h
index 71865160319..c9a0f3833a2 100644
--- a/drivers/mmc/sunxi_mmc.h
+++ b/drivers/mmc/sunxi_mmc.h
@@ -58,6 +58,7 @@ struct sunxi_mmc {
 
 #define SUNXI_MMC_CLK_POWERSAVE		(0x1 << 17)
 #define SUNXI_MMC_CLK_ENABLE		(0x1 << 16)
+#define SUNXI_MMC_CLK_MASK_DATA0	(0x1U << 31)
 #define SUNXI_MMC_CLK_DIVIDER_MASK	(0xff)
 
 #define SUNXI_MMC_GCTRL		0x000
-- 
2.53.0

