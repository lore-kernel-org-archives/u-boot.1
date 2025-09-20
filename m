Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C67CAC5A7
	for <u-boot@archiver.kernel.org>; Sat, 20 Sep 2025 16:10:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 832DD83390;
	Sat, 20 Sep 2025 18:10:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="isgbjDj7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B15882B07; Sat, 20 Sep 2025 18:10:24 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D72982B07
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 18:10:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45de56a042dso19544825e9.3
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 09:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758384621; x=1758989421; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DPLCJddy37ElqHCCinrM/0gIhq3nlDbuPmqdhyB27Ps=;
 b=isgbjDj7I0mXkASTRWyLweTJIargZWNAWS5RLxtQ82NGQU4Zqh75YrU/GlXioFMhGj
 hjUtLvlSVQd8I6SzI18Q1cFavuZYeZMikeXW1WrZCTmtJrKyK6MCKgDxG88yOslB4dUO
 21nCaBk1ezNDHPpfcVO7EE8SUMqLgzelJ5xNN4k0NjZhUudJObGyjdNyaNJxdCGkgX+Z
 YhehbIzCy58Yk5crvwPV4FepMygqMioQ8by1wEehq4D9haMs7/6IU6wnxasGw3R8wvG0
 OnVtImv6W2fBB+YibTdhq2P8KOygoKR6a8GbxD/k0u38+aZBfu+OZ65HtEvY6kIZtqt3
 hs6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758384621; x=1758989421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DPLCJddy37ElqHCCinrM/0gIhq3nlDbuPmqdhyB27Ps=;
 b=KGQt5uUfNC0n6UjA+OnlGBMrprlakyneS4E85UvzHhWFpZCWabU4uxOWu4hvvy0i4E
 yCovKgkHZQbPXsFavM2w3qHplkj82Fwmi0CQfBaleIE+QWH+lZFckP+RKGJ4BgBtUy9b
 cZcUZkOx7lwK8gUIGe3jRYUkpvhsbplJoN7h0RsH+u8mYEdQQ4HaXehpM/i8zZdmy/9G
 GHE26uegwDCVc0+frpzCrZABG4UtIeDq9IaRQIubZpqS0t+vWEBBd927emekJjl9Yl91
 4cdLTCoelPADd9voTOIS88LH2nLcB4dSj1IflcQBQRl0vsvjD+XWpW2EuuJ/jlnE9a4R
 0ISg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBtxWrEEhjatZBB06jMTO8FaeEr/rwPRhuQ6MH80kJZt1SrFRNPYzNgDDsKg/0u+b26WWHjcs=@lists.denx.de
X-Gm-Message-State: AOJu0YyPbZHCNlJKtWMPnKObT4vsI0ot2ydbSaG0kiqTsizykUnfqocM
 uLm2dNJzjY0JyeqN/Ezmu+/D84tv4NqgwIy4ELWKcSXU0qXbNVqa9Ing
X-Gm-Gg: ASbGncuCyP7jAZ4QWgEtuh1peeafdzFBoZHmg3JMeNQyHiRmZmPu2/vopU7RzU9fgBA
 2FVheiGk1UF3bG6ESDT+Z/lgwOcGZh/XJxF+3U5A0DPsdiChdyVxATELW9oZ6jyfyc630W8Pq6z
 YJQbcNk5/0IKkNZH/KYe+sWiL4GXLtInU3k2UVErtiPkxOR/xj0tR/EuZbuJbWi1GTKALgF8dUo
 dTIDiwyR2BhWvKcQlKTnwtVRXpc/xHtzyYV9PE0ebVzuDlqQ+XNobcRyGTWspDsx4OE0hnUh5PN
 R6z8gGf64K5FTZ2SM+C6XZBsHRCzjO3MMgrDEocBA4ZEtDaoK2cC4UQtaD+cwkxrey7CkiBlmet
 q7EQ6DU6lP+PuoqhtJ42yPy+1zE1AcvkNUGC+c2vyTmiPHtUwkIkJ73kcTklyCq96N6X5D3MBxn
 IUp9bAsw==
X-Google-Smtp-Source: AGHT+IHx16x+YRbl9P7hqcicwL2xiPmrpFY4LdPvS7CesKR+1rtwSh3KdXXXteD5fgNptvZUkADxyg==
X-Received: by 2002:a05:600c:1d1b:b0:45d:98be:ee91 with SMTP id
 5b1f17b1804b1-467eb8e20damr69355335e9.9.1758384621209; 
 Sat, 20 Sep 2025 09:10:21 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it.
 [95.249.236.54]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-45f325cec0fsm105878675e9.4.2025.09.20.09.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 09:10:20 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v2 1/5] net: mediatek: mt7531/7988: fix broken PHY turn ON/OFF
Date: Sat, 20 Sep 2025 18:09:41 +0200
Message-ID: <20250920161013.31799-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920161013.31799-1-ansuelsmth@gmail.com>
References: <20250920161013.31799-1-ansuelsmth@gmail.com>
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

The PHY for MT7531/MT7988 are never actully turned ON/OFF for the
affected PHY as we are read/writing to the wrong PHY address.

This is caused by the fact that we use the MT753X_PHY_ADDR macro 2
times offsetting the address multiple times.

One in the _setup() function and one in the mt7531_mii_read/write.

Drop the additional usage of MT753X_PHY_ADDR in setup() to correctly
set the PHY.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/mtk_eth/mt7531.c | 20 +++++++-------------
 drivers/net/mtk_eth/mt7988.c | 12 +++++-------
 2 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/net/mtk_eth/mt7531.c b/drivers/net/mtk_eth/mt7531.c
index 32d6bebbbdb..965bc3cb7e9 100644
--- a/drivers/net/mtk_eth/mt7531.c
+++ b/drivers/net/mtk_eth/mt7531.c
@@ -22,17 +22,13 @@
 
 static int mt7531_core_reg_read(struct mt753x_switch_priv *priv, u32 reg)
 {
-	u8 phy_addr = MT753X_PHY_ADDR(priv->phy_base, 0);
-
-	return mt7531_mmd_read(priv, phy_addr, 0x1f, reg);
+	return mt7531_mmd_read(priv, 0, 0x1f, reg);
 }
 
 static void mt7531_core_reg_write(struct mt753x_switch_priv *priv, u32 reg,
 				  u32 val)
 {
-	u8 phy_addr = MT753X_PHY_ADDR(priv->phy_base, 0);
-
-	mt7531_mmd_write(priv, phy_addr, 0x1f, reg, val);
+	mt7531_mmd_write(priv, 0, 0x1f, reg, val);
 }
 
 static void mt7531_core_pll_setup(struct mt753x_switch_priv *priv)
@@ -171,7 +167,7 @@ static int mt7531_setup(struct mtk_eth_switch_priv *swpriv)
 {
 	struct mt753x_switch_priv *priv = (struct mt753x_switch_priv *)swpriv;
 	u32 i, val, pmcr, port5_sgmii;
-	u16 phy_addr, phy_val;
+	u16 phy_val;
 
 	priv->smi_addr = MT753X_DFL_SMI_ADDR;
 	priv->phy_base = (priv->smi_addr + 1) & MT753X_SMI_ADDR_MASK;
@@ -180,10 +176,9 @@ static int mt7531_setup(struct mtk_eth_switch_priv *swpriv)
 
 	/* Turn off PHYs */
 	for (i = 0; i < MT753X_NUM_PHYS; i++) {
-		phy_addr = MT753X_PHY_ADDR(priv->phy_base, i);
-		phy_val = mt7531_mii_read(priv, phy_addr, MII_BMCR);
+		phy_val = mt7531_mii_read(priv, i, MII_BMCR);
 		phy_val |= BMCR_PDOWN;
-		mt7531_mii_write(priv, phy_addr, MII_BMCR, phy_val);
+		mt7531_mii_write(priv, i, MII_BMCR, phy_val);
 	}
 
 	/* Force MAC link down before reset */
@@ -239,10 +234,9 @@ static int mt7531_setup(struct mtk_eth_switch_priv *swpriv)
 
 	/* Turn on PHYs */
 	for (i = 0; i < MT753X_NUM_PHYS; i++) {
-		phy_addr = MT753X_PHY_ADDR(priv->phy_base, i);
-		phy_val = mt7531_mii_read(priv, phy_addr, MII_BMCR);
+		phy_val = mt7531_mii_read(priv, i, MII_BMCR);
 		phy_val &= ~BMCR_PDOWN;
-		mt7531_mii_write(priv, phy_addr, MII_BMCR, phy_val);
+		mt7531_mii_write(priv, i, MII_BMCR, phy_val);
 	}
 
 	mt7531_phy_setting(priv);
diff --git a/drivers/net/mtk_eth/mt7988.c b/drivers/net/mtk_eth/mt7988.c
index a416d87840c..87b6ed30cd0 100644
--- a/drivers/net/mtk_eth/mt7988.c
+++ b/drivers/net/mtk_eth/mt7988.c
@@ -61,7 +61,7 @@ static void mt7988_mac_control(struct mtk_eth_switch_priv *swpriv, bool enable)
 static int mt7988_setup(struct mtk_eth_switch_priv *swpriv)
 {
 	struct mt753x_switch_priv *priv = (struct mt753x_switch_priv *)swpriv;
-	u16 phy_addr, phy_val;
+	u16 phy_val;
 	u32 pmcr;
 	int i;
 
@@ -72,10 +72,9 @@ static int mt7988_setup(struct mtk_eth_switch_priv *swpriv)
 
 	/* Turn off PHYs */
 	for (i = 0; i < MT753X_NUM_PHYS; i++) {
-		phy_addr = MT753X_PHY_ADDR(priv->phy_base, i);
-		phy_val = mt7531_mii_read(priv, phy_addr, MII_BMCR);
+		phy_val = mt7531_mii_read(priv, i, MII_BMCR);
 		phy_val |= BMCR_PDOWN;
-		mt7531_mii_write(priv, phy_addr, MII_BMCR, phy_val);
+		mt7531_mii_write(priv, i, MII_BMCR, phy_val);
 	}
 
 	switch (priv->epriv.phy_interface) {
@@ -128,10 +127,9 @@ static int mt7988_setup(struct mtk_eth_switch_priv *swpriv)
 
 	/* Turn on PHYs */
 	for (i = 0; i < MT753X_NUM_PHYS; i++) {
-		phy_addr = MT753X_PHY_ADDR(priv->phy_base, i);
-		phy_val = mt7531_mii_read(priv, phy_addr, MII_BMCR);
+		phy_val = mt7531_mii_read(priv, i, MII_BMCR);
 		phy_val &= ~BMCR_PDOWN;
-		mt7531_mii_write(priv, phy_addr, MII_BMCR, phy_val);
+		mt7531_mii_write(priv, i, MII_BMCR, phy_val);
 	}
 
 	mt7988_phy_setting(priv);
-- 
2.51.0

