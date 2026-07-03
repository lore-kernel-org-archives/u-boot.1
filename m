Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4D8C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 19:48:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49A57849F0;
	Fri,  3 Jul 2026 21:48:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MPp3AHdd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C37DF84A04; Fri,  3 Jul 2026 21:48:01 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95F10849E5
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 21:47:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-448de0cc236so495123fac.2
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 12:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783108078; x=1783712878; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WChWo/or/Ea1U9rb4izzvYXKanE/as2Tyi+VJsElNkY=;
 b=MPp3AHddkeWtKGFbiah+LsGeASePdSkYC1ME3fRtVAOLrlcDnfvX6t5OzEWxeq92Ti
 zwPlyIlBTC+dEufAvPOq4ozjDDUGMOexfWiq8LQfVduYGofcFtBodmbPKiFTuzfXlZA9
 CCbJ+4CK5TEWKOhAC9jBKh2TjZksNnoJ5nMzV+M3A6Csso0tXfxZzx5UH/k8qzeXL963
 m3zE8xGWf9NCcqx2moTMxQ91WKlwft1VNzKevYGO93OE1pQ502OQyXxqBIUq66C48rqc
 f77BX0brH4Px6YWNQNjYOgGFAnPgEP8ASTZ+VpRaniNw5ZElUVxvMM3ib1ztieK81ZVy
 Zu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783108078; x=1783712878;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WChWo/or/Ea1U9rb4izzvYXKanE/as2Tyi+VJsElNkY=;
 b=BoMUd8I3dB+z8PphpmVTW3onil2Q8LvLlT1KqMzYPZy1NcF3vLyp5wxGju46zFWTvZ
 +s0IwO5ozHedZTFwBatMC7CMr0r97Z2wV51ZEGKYS9xSk9h1Gq0FVkFj4zEpJszo3OGK
 g1/t6AyXrVQkKsRKTJWlohLD7jXK5mwj61CRtmWx3U15B1mKNpveUMIUNjl54RHdWRkA
 Io3uvqiDbyxCohZhMPHMqRD0f82vEfzZ2DIFaeXHHdB0tKuCMmRMvnIfAryimgzzdfwe
 drQI8GGKu9zD2PCp8k6aW6rSb0b9L2mLb8BeY+KH4JshkuxNi+3r7EMt77OHcXqOjY4s
 bnAg==
X-Gm-Message-State: AOJu0YyF2mjM5Fr6QCfpnjaIAnU8QBZx+y3iCUE/XFoDd32CFgHRy12p
 7+gbDevtdzJVi9Sk2f5HXXFFwSCaV1pL8BF+p+I+ohOGrjbFya+4dvD++Rh4HCl0QCo=
X-Gm-Gg: AfdE7ckR9JjjSqw5f1Bghas2xXuuDst50B9ZFvHRgvONnVMgUMKyvzaIXSztbrJ3zgt
 9Y67aQEsgCi0oTfv651sZFTI4YfYXQYW554lHxrK7strgz176+ZOZClUGSOD+Y9+SNKmGicMkAc
 3AGk4i4FjTsGBazobWr95j6NkpezOF3ZqbcF7cXoKhIccb+ks8djW0+c8/2xSi89GRWLfKQYYTT
 PqgZbIAJklPZNK3ewEQpgDQwo4Am1QtxJ+lGKNzxpFdT764vyKPOT5dXAg18uVsWiFFeQ+Uxc9A
 iHok4h6ZPcRniHyryk6x47568ItzOdylKnNjMup1TtNfFJWS7xXIZUebU3y2wJBaTGZ1RRIlK/s
 IO7efPbmK8XaNpyFBnGZOCDPwC7V8EkbQWj851oBhb8SqkK680TYC2x3rSl4wZDNTzZIKE12Any
 6M0aXYUn46pyQT72Q8cy+U9ste0XqKOCsnDjW6K+rZVPPSKTR8z+sTM45kB2O0qeKORPzk8vtqy
 Kkz6OHuKkvw/0LksuLjjfISbGx3m1O/nA67uItn4BRiOOqIdpYOh4jJoMtBj2UJgiZuksbweY1F
 WhTLUedK9gZh35U=
X-Received: by 2002:a05:6871:28c:b0:439:a524:a29b with SMTP id
 586e51a60fabf-44d17f78418mr389642fac.7.1783108077999; 
 Fri, 03 Jul 2026 12:47:57 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (97-118-25-163.hlrn.qwest.net.
 [97.118.25.163]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb559559sm3000723fac.9.2026.07.03.12.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 12:47:57 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH] mmc: sunxi: mask DATA0 during H6-family clock updates
Date: Fri,  3 Jul 2026 13:47:34 -0600
Message-ID: <20260703194738.3540286-1-james.hilliard1@gmail.com>
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

Linux marks the H6/A100-style controllers with mask_data0 and sets the
CLKCR MASK_DATA0 bit while issuing update-clock commands. Without this,
the controller can sample DAT0 as busy around clock updates before the
first card command, so card detection may fail with -ETIMEDOUT.

Mirror the Linux behavior for H6-family and NCAT2-family controllers while
updating the card clock.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mmc/sunxi_mmc.c | 30 +++++++++++++++++++++++++++---
 drivers/mmc/sunxi_mmc.h |  1 +
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
index e28c81afffe..145d6bd7c9d 100644
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
@@ -201,14 +207,31 @@ static int mmc_update_clk(struct sunxi_mmc_priv *priv)
 	return 0;
 }
 
+static int mmc_update_clk_with_data0_mask(struct sunxi_mmc_priv *priv)
+{
+	bool mask_data0 = sunxi_mmc_needs_data0_mask();
+	int ret;
+
+	if (mask_data0)
+		setbits_le32(&priv->reg->clkcr, SUNXI_MMC_CLK_MASK_DATA0);
+
+	ret = mmc_update_clk(priv);
+
+	if (mask_data0)
+		clrbits_le32(&priv->reg->clkcr, SUNXI_MMC_CLK_MASK_DATA0);
+
+	return ret;
+}
+
 static int mmc_config_clock(struct sunxi_mmc_priv *priv, struct mmc *mmc)
 {
 	unsigned rval = readl(&priv->reg->clkcr);
 
 	/* Disable Clock */
-	rval &= ~SUNXI_MMC_CLK_ENABLE;
+	rval &= ~(SUNXI_MMC_CLK_ENABLE | SUNXI_MMC_CLK_POWERSAVE |
+		  SUNXI_MMC_CLK_MASK_DATA0);
 	writel(rval, &priv->reg->clkcr);
-	if (mmc_update_clk(priv))
+	if (mmc_update_clk_with_data0_mask(priv))
 		return -1;
 
 	/* Set mod_clk to new rate */
@@ -231,9 +254,10 @@ static int mmc_config_clock(struct sunxi_mmc_priv *priv, struct mmc *mmc)
 #endif
 
 	/* Re-enable Clock */
+	rval &= ~(SUNXI_MMC_CLK_POWERSAVE | SUNXI_MMC_CLK_MASK_DATA0);
 	rval |= SUNXI_MMC_CLK_ENABLE;
 	writel(rval, &priv->reg->clkcr);
-	if (mmc_update_clk(priv))
+	if (mmc_update_clk_with_data0_mask(priv))
 		return -1;
 
 	return 0;
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

