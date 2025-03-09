Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F674C282D1
	for <u-boot@archiver.kernel.org>; Sun,  9 Mar 2025 06:12:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65DEB8043C;
	Sun,  9 Mar 2025 07:12:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hNG6gwoV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86CE680F0B; Sun,  9 Mar 2025 07:12:51 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96B69801DE
 for <u-boot@lists.denx.de>; Sun,  9 Mar 2025 07:12:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-abec8b750ebso528708266b.0
 for <u-boot@lists.denx.de>; Sat, 08 Mar 2025 22:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741500767; x=1742105567; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wf1okhazCUEnLuartt0a7/ZV6WRZiFKgURRJRNienlY=;
 b=hNG6gwoVfIWvzkFTTSYkRUffir8slyLMjDE4izCCo2OzEVMjXO3z0X7RMKAdmZ1Rzv
 /xJiJFq8xVQjeWEm2svBcJ1xkjzErU9BK7GLpJae2xtBjcqb7KDAoDtB2ddWgQsL19jQ
 D4e5XNC++n6c1cKGroWfyQJio2Jq+LMkMYVITPqN/0R0u1/2ObRk6BWwy1Nx+fIVEyJs
 QLSrMZjpe9+/pFctqm0SYrf43Hfw3OgRCIPjJhqa1GfrhqUg3LkOcakx/+sow1lFK2Zk
 BbTSlmoenUjXi4z0GEr1G/eYeyxmmdXX3IoQfug4p/VbiA4oqAZnw4NwzdzvXQrBboU0
 1ZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741500767; x=1742105567;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wf1okhazCUEnLuartt0a7/ZV6WRZiFKgURRJRNienlY=;
 b=c5wtFjQNWEXHCahOOA46mMht1CUsKhtP36Oixuj3QBE1PIewVovpsTYif+PMxUoImV
 yYIXZyeSMJV7D1XP2htI5SL0Gdkn3YKnqodrtppMa8lVV4/1xVsnjEWOuBh4rEui5z5y
 3XQ+61j6HbQt8FMb0sY4oQGapgA6cARhwDt6MxZar8VqFY6Lzm9ftEtuDZVHWZE4AWqP
 tITMYp5o5ikdQ3jTD9QLe7e9FrGlN53SLejVvi4jT9P6bDlPcz1xNqf9HQBGLyBSx+zd
 RQXx25+Khh9Gfb2RqBuGPp5AtcaF6h4i/cgPC8Mk+KLUyea7RZ8ztC82ZScJPk34Vpjv
 lbXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWviTC/FTL3hwEj+OQ8D+JqM37ZDqE+394yyhbLxDQZbV65s7OyawCpKfWDtbzWONg8Zq2Nsnc=@lists.denx.de
X-Gm-Message-State: AOJu0YyKNOtoYGG2HtIs83Y1Oo+CKDlQXltapS4Q0G2zR0s8OHEj1LJA
 QMder8fWzYVuetmMz9xSY/G13vqeVnMIWhbQTUzmcryWUPyYNr95
X-Gm-Gg: ASbGncszUPH2wttJ3wofEkRReFqMXAyBhF0+4I8wZ66wwEeQkCGXrHjtS2iO3i23wnz
 GjUPdlYgMJzpUy2Vg3tRKdJG1/ccr0es+qY+RLjl7pa8rKRJ7G3pe/jSA5jYAYJZ+DYefw2Q9cA
 tuKXDBci5Se5dLU5lSbiXpWYa6sLduqffJWfyCHypEeW5Z3j8X28/I7fXQLgbi8UC/KdGLmfWxm
 2ganOLRmUgz8Rszx4snCc7lS9eIfYdkOUnOyejOCJzZk/9fy7XVM6z+b4eddZrWxNx/J2bnkthf
 x+w5wRhsSM8IZi9bekvvbhmDbKLOXk1zcXnecuIZYbRp0mtQqUW61PsqMg0AcugG
X-Google-Smtp-Source: AGHT+IFWRoRGXzo3k8TrAN8828qg6xExYhW0d6iKTv3ibuuEVSdFae7DO32G2sP4YujrCkEqJgW4MQ==
X-Received: by 2002:a17:906:180d:b0:ac2:5d24:1fcf with SMTP id
 a640c23a62f3a-ac25d2423fdmr632176466b.26.1741500767192; 
 Sat, 08 Mar 2025 22:12:47 -0800 (PST)
Received: from localhost.localdomain ([188.159.248.16])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac27a071479sm189558566b.113.2025.03.08.22.12.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 22:12:45 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: eng.fan@nxp.com,
	jh80.chung@samsung.com,
	trini@konsulko.com
Cc: andre.przywara@arm.com, u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] sunxi: mmc: Improve reset procedure
Date: Sun,  9 Mar 2025 07:12:41 +0100
Message-ID: <20250309061241.62170-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.48.1
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

Cards should always be reset and threshold set. This fixes eMMC on H616.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/mmc/sunxi_mmc.c | 28 ++++++++++++++++++++++------
 drivers/mmc/sunxi_mmc.h | 15 +++++++++++++--
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
index 0b56d1405bee..335def4b9738 100644
--- a/drivers/mmc/sunxi_mmc.c
+++ b/drivers/mmc/sunxi_mmc.c
@@ -442,6 +442,26 @@ out:
 	return error;
 }
 
+static void sunxi_mmc_reset(struct sunxi_mmc *regs)
+{
+	/* Reset controller */
+	writel(SUNXI_MMC_GCTRL_RESET, &regs->gctrl);
+	udelay(1000);
+
+	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2)) {
+		/* Reset card */
+		writel(SUNXI_MMC_HWRST_ASSERT, &regs->hwrst);
+		udelay(10);
+		writel(SUNXI_MMC_HWRST_DEASSERT, &regs->hwrst);
+		udelay(300);
+
+		/* Setup FIFO R/W threshold. Needed on H616. */
+		writel(SUNXI_MMC_THLDC_READ_THLD(512) |
+		       SUNXI_MMC_THLDC_WRITE_EN |
+		       SUNXI_MMC_THLDC_READ_EN, &regs->thldc);
+	}
+}
+
 /* non-DM code here is used by the (ARM) SPL only */
 
 #if !CONFIG_IS_ENABLED(DM_MMC)
@@ -489,9 +509,7 @@ static int sunxi_mmc_core_init(struct mmc *mmc)
 {
 	struct sunxi_mmc_priv *priv = mmc->priv;
 
-	/* Reset controller */
-	writel(SUNXI_MMC_GCTRL_RESET, &priv->reg->gctrl);
-	udelay(1000);
+	sunxi_mmc_reset(priv->reg);
 
 	return 0;
 }
@@ -684,9 +702,7 @@ static int sunxi_mmc_probe(struct udevice *dev)
 
 	upriv->mmc = &plat->mmc;
 
-	/* Reset controller */
-	writel(SUNXI_MMC_GCTRL_RESET, &priv->reg->gctrl);
-	udelay(1000);
+	sunxi_mmc_reset(priv->reg);
 
 	return 0;
 }
diff --git a/drivers/mmc/sunxi_mmc.h b/drivers/mmc/sunxi_mmc.h
index f4ae5a790c87..9d55904c213c 100644
--- a/drivers/mmc/sunxi_mmc.h
+++ b/drivers/mmc/sunxi_mmc.h
@@ -37,7 +37,9 @@ struct sunxi_mmc {
 	u32 res0;		/* 0x54 reserved */
 	u32 a12a;		/* 0x58 Auto command 12 argument */
 	u32 ntsr;		/* 0x5c	New timing set register */
-	u32 res1[8];
+	u32 res1[6];
+	u32 hwrst;		/* 0x78 Hardware Reset */
+	u32 res5;
 	u32 dmac;		/* 0x80 internal DMA control */
 	u32 dlba;		/* 0x84 internal DMA descr list base address */
 	u32 idst;		/* 0x88 internal DMA status */
@@ -46,7 +48,8 @@ struct sunxi_mmc {
 	u32 cbda;		/* 0x94 */
 	u32 res2[26];
 #if defined(CONFIG_SUNXI_GEN_SUN6I) || defined(CONFIG_SUN50I_GEN_H6) || defined(CONFIG_SUNXI_GEN_NCAT2)
-	u32 res3[17];
+	u32 thldc;		/* 0x100 Threshold control */
+	u32 res3[16];
 	u32 samp_dl;
 	u32 res4[46];
 #endif
@@ -123,6 +126,9 @@ struct sunxi_mmc {
 
 #define SUNXI_MMC_NTSR_MODE_SEL_NEW		(0x1 << 31)
 
+#define SUNXI_MMC_HWRST_ASSERT		(0x0 << 0)
+#define SUNXI_MMC_HWRST_DEASSERT	(0x1 << 0)
+
 #define SUNXI_MMC_IDMAC_RESET		(0x1 << 0)
 #define SUNXI_MMC_IDMAC_FIXBURST	(0x1 << 1)
 #define SUNXI_MMC_IDMAC_ENABLE		(0x1 << 7)
@@ -133,6 +139,11 @@ struct sunxi_mmc {
 #define SUNXI_MMC_COMMON_CLK_GATE		(1 << 16)
 #define SUNXI_MMC_COMMON_RESET			(1 << 18)
 
+#define SUNXI_MMC_THLDC_READ_EN		(0x1 << 0)
+#define SUNXI_MMC_THLDC_BSY_CLR_INT_EN	(0x1 << 1)
+#define SUNXI_MMC_THLDC_WRITE_EN	(0x1 << 2)
+#define SUNXI_MMC_THLDC_READ_THLD(x)	(((x) & 0xfff) << 16)
+
 #define SUNXI_MMC_CAL_DL_SW_EN		(0x1 << 7)
 
 #endif /* _SUNXI_MMC_H */
-- 
2.48.1

