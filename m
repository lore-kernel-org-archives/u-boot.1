Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E26CA0EED
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 00:08:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93F8B83327;
	Fri, 29 Aug 2025 02:08:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sima.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sima.ai header.i=@sima.ai header.b="YGUk4ItJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F8E483327; Fri, 29 Aug 2025 00:55:41 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B47F8304F
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 00:55:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sima.ai
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nikunj.kela@sima.ai
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b4741e1cde5so258204a12.3
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 15:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sima.ai; s=google; t=1756421737; x=1757026537; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2R4wCHKBY3YQK43xzvfjWxSXRqB8MEqG2LSOUVELySo=;
 b=YGUk4ItJZ+2p4cMkaWYhd8OH+nrlMhoKdAjcOBrYgQGRCTgJN7hXZMd3E/L/9TlWcv
 8INm1A2siVQsDyLZlft8ex4xIZe7whLijYLT0DhobXb0vFEDSF35bfvVMGS5sk7R0AZ8
 Z27VNyVFsG7UffgKsQrGgme2plEfcXTFf//vNHSmRwPW3D7Ygb+z22Ops34FHKA0UaD5
 ho9/Y37ttoBG8yLopVcolhosLQ5iVCg3FDW9BsxIX5zX3TwhYP8QDR6sVN2Zcxem6urL
 e2egJ+bd29L37s/l/qMFrrmmiNLy8jxcO4gEP0KxoPfeN011YQJzRUg5mSx/fdbDhQry
 Rz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756421737; x=1757026537;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2R4wCHKBY3YQK43xzvfjWxSXRqB8MEqG2LSOUVELySo=;
 b=BG2kYqxMib4TOxkc3hsD9bLJUzgP70z3hm1YPfqbJOl/T/ROOwdzZD5wvO9ARa4k6U
 nXucB1yyQ8BN5lWUO/FMQtuwpTwSywTgryGC5y/N1oP7BCt2sx8S7k0tvkS/Af2Hdu1X
 Nvii1GABCjSspAlDMEkCt1wkaVZ9Qe05yDGlKEdyVZdf/C8E/SSB2g3hzMG8z62uTnOM
 EiBnrDpG8opXuIMg5WRVKarovuZ5LY7L4ZIcJrHVxKh3i/GoDCLjhKWi0F8wN/3eShrY
 o70p9WPhY+9w4IJvDODf2jZjhuZ8xk7jtlm3lnDWCdxYOpdx8hO3pd7Uqyo1hOQJRBWh
 w/KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX62obVXvAYUqMw6bpazOR9MFP0upl3AytH7+hMA6dDWVwcj7P7hYPjQFqEYA0UV80JQHTiyE=@lists.denx.de
X-Gm-Message-State: AOJu0YyBs1g48/4w8Q6+ryDsUawWgIAWQzCoVtjKpdpLbr1+x0nvDhZL
 1LxxJliKZXm8eYc5wyYmbpfcDtljsU36cN0GJ7oOYvRBaRoP8QnzQgNlfxrTqIGJQ74=
X-Gm-Gg: ASbGncvlV9q1hN9/jtXTtL7hBVmVWYN5G7H30A5hiJtxYxJ8Zz7HJQ+VvSGFrnXCYmX
 1/CStJEk21M7/23s9upZAyJ2A6GyK2sy1/qOuK1ks69nyYpWTI5Qsx5s31Si5dmwztkitB8OFwo
 6OlZf1w9FuSMlFOPhAz5DRWnKHLyf75P33qJNqpZGYyHc7yupGPDVjTQmhwUaL7E653CHuPy2vB
 vMA2kluPc29iaSc7qHksgD+38uQj9LDipVjrE9qyXH9a5H76c1tHo/f2xcWxVxWApiguKIkCikq
 YWNjpb6Wm5sMYbIziZOEpXhH0vKhiZI0m+BkYnUckB1mEAg7ZkdquOVSn0SxflYn0Z/W9CE8iJw
 JZWrw66Ydkzqtet7feHl2otvO8qLJaEQT4F0sIEzH
X-Google-Smtp-Source: AGHT+IFel4tClP6XCt0VXE6qqaRlAwIiwekSXzFa4njXMZr20o60OHaNTTTp50Q1yZf+YCRgKFZKtQ==
X-Received: by 2002:a05:6a21:798f:b0:243:6cee:62a3 with SMTP id
 adf61e73a8af0-2436cee6d16mr10818503637.6.1756421736784; 
 Thu, 28 Aug 2025 15:55:36 -0700 (PDT)
Received: from nikunj-kela-u22.eng.sima.ai ([205.234.21.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd318d3d7sm444688a12.46.2025.08.28.15.55.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 15:55:36 -0700 (PDT)
From: Nikunj Kela <nikunj.kela@sima.ai>
To: joe.hershberger@ni.com,
	rfried.dev@gmail.com
Cc: boon.khai.ng@altera.com, u-boot@lists.denx.de,
 Nikunj Kela <nikunj.kela@sima.ai>
Subject: [PATCH v2] net: xgmac: Augment mdio read/write with cl-45 format
 support
Date: Thu, 28 Aug 2025 15:55:32 -0700
Message-Id: <20250828225532.1147284-1-nikunj.kela@sima.ai>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 29 Aug 2025 02:08:06 +0200
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

Currently, clause-22 format is supported. This change adds
support for clause-45 format.

Signed-off-by: Nikunj Kela <nikunj.kela@sima.ai>
---
Changes in v2:
	- Created separate function for configuring clause format
[1]: https://patchwork.ozlabs.org/project/uboot/patch/20250510041200.2552981-1-nikunj.kela@sima.ai/
---
 drivers/net/dwc_eth_xgmac.c | 60 ++++++++++++++++++++++++-------------
 drivers/net/dwc_eth_xgmac.h |  1 +
 2 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/drivers/net/dwc_eth_xgmac.c b/drivers/net/dwc_eth_xgmac.c
index d29d871ea8c..ecb92d37ee0 100644
--- a/drivers/net/dwc_eth_xgmac.c
+++ b/drivers/net/dwc_eth_xgmac.c
@@ -140,9 +140,34 @@ static int xgmac_mdio_wait_idle(struct xgmac_priv *xgmac)
 				 XGMAC_TIMEOUT_100MS, true);
 }
 
+static u32 xgmac_set_clause(struct xgmac_priv *xgmac, int mdio_addr, int mdio_devad,
+			    int mdio_reg, bool is_c45)
+{
+	u32 hw_addr;
+	u32 val;
+
+	if (is_c45) {
+		val = readl(&xgmac->mac_regs->mdio_clause_22_port);
+		val &= ~BIT(mdio_addr);
+		writel(val, &xgmac->mac_regs->mdio_clause_22_port);
+		hw_addr = (mdio_addr << XGMAC_MAC_MDIO_ADDRESS_PA_SHIFT) |
+			   (mdio_reg & XGMAC_MAC_MDIO_REG_ADDR_C45P_MASK);
+		hw_addr |= mdio_devad << XGMAC_MAC_MDIO_ADDRESS_DA_SHIFT;
+	} else {
+		/* Set clause 22 format */
+		val = BIT(mdio_addr);
+		writel(val, &xgmac->mac_regs->mdio_clause_22_port);
+		hw_addr = (mdio_addr << XGMAC_MAC_MDIO_ADDRESS_PA_SHIFT) |
+			   (mdio_reg & XGMAC_MAC_MDIO_REG_ADDR_C22P_MASK);
+	}
+
+	return hw_addr;
+}
+
 static int xgmac_mdio_read(struct mii_dev *bus, int mdio_addr, int mdio_devad,
 			   int mdio_reg)
 {
+	bool is_c45 = (mdio_devad != MDIO_DEVAD_NONE);
 	struct xgmac_priv *xgmac = bus->priv;
 	u32 val;
 	u32 hw_addr;
@@ -159,19 +184,16 @@ static int xgmac_mdio_read(struct mii_dev *bus, int mdio_addr, int mdio_devad,
 		return ret;
 	}
 
-	/* Set clause 22 format */
-	val = BIT(mdio_addr);
-	writel(val, &xgmac->mac_regs->mdio_clause_22_port);
-
-	hw_addr = (mdio_addr << XGMAC_MAC_MDIO_ADDRESS_PA_SHIFT) |
-		   (mdio_reg & XGMAC_MAC_MDIO_REG_ADDR_C22P_MASK);
+	hw_addr = xgmac_set_clause(xgmac, mdio_addr, mdio_devad, mdio_reg, is_c45);
 
 	val = xgmac->config->config_mac_mdio <<
 	      XGMAC_MAC_MDIO_ADDRESS_CR_SHIFT;
 
-	val |= XGMAC_MAC_MDIO_ADDRESS_SADDR |
-	       XGMAC_MDIO_SINGLE_CMD_ADDR_CMD_READ |
-	       XGMAC_MAC_MDIO_ADDRESS_SBUSY;
+	if (!is_c45)
+		val |= XGMAC_MAC_MDIO_ADDRESS_SADDR;
+
+	val |= XGMAC_MDIO_SINGLE_CMD_ADDR_CMD_READ |
+		XGMAC_MAC_MDIO_ADDRESS_SBUSY;
 
 	ret = xgmac_mdio_wait_idle(xgmac);
 	if (ret) {
@@ -203,6 +225,7 @@ static int xgmac_mdio_read(struct mii_dev *bus, int mdio_addr, int mdio_devad,
 static int xgmac_mdio_write(struct mii_dev *bus, int mdio_addr, int mdio_devad,
 			    int mdio_reg, u16 mdio_val)
 {
+	bool is_c45 = (mdio_devad != MDIO_DEVAD_NONE);
 	struct xgmac_priv *xgmac = bus->priv;
 	u32 val;
 	u32 hw_addr;
@@ -219,21 +242,18 @@ static int xgmac_mdio_write(struct mii_dev *bus, int mdio_addr, int mdio_devad,
 		return ret;
 	}
 
-	/* Set clause 22 format */
-	val = BIT(mdio_addr);
-	writel(val, &xgmac->mac_regs->mdio_clause_22_port);
-
-	hw_addr = (mdio_addr << XGMAC_MAC_MDIO_ADDRESS_PA_SHIFT) |
-		   (mdio_reg & XGMAC_MAC_MDIO_REG_ADDR_C22P_MASK);
-
-	hw_addr |= (mdio_reg >> XGMAC_MAC_MDIO_ADDRESS_PA_SHIFT) <<
-		    XGMAC_MAC_MDIO_ADDRESS_DA_SHIFT;
+	hw_addr = xgmac_set_clause(xgmac, mdio_addr, mdio_devad, mdio_reg, is_c45);
 
 	val = (xgmac->config->config_mac_mdio <<
 	       XGMAC_MAC_MDIO_ADDRESS_CR_SHIFT);
 
-	val |= XGMAC_MAC_MDIO_ADDRESS_SADDR |
-		mdio_val | XGMAC_MDIO_SINGLE_CMD_ADDR_CMD_WRITE |
+	if (!is_c45) {
+		hw_addr |= (mdio_reg >> XGMAC_MAC_MDIO_ADDRESS_PA_SHIFT) <<
+			    XGMAC_MAC_MDIO_ADDRESS_DA_SHIFT;
+		val |= XGMAC_MAC_MDIO_ADDRESS_SADDR;
+	}
+
+	val |=	mdio_val | XGMAC_MDIO_SINGLE_CMD_ADDR_CMD_WRITE |
 		XGMAC_MAC_MDIO_ADDRESS_SBUSY;
 
 	ret = xgmac_mdio_wait_idle(xgmac);
diff --git a/drivers/net/dwc_eth_xgmac.h b/drivers/net/dwc_eth_xgmac.h
index 259f815f3f2..90c2e22997c 100644
--- a/drivers/net/dwc_eth_xgmac.h
+++ b/drivers/net/dwc_eth_xgmac.h
@@ -109,6 +109,7 @@ struct xgmac_mac_regs {
 #define XGMAC_MAC_MDIO_ADDRESS_SBUSY		BIT(22)
 #define XGMAC_MAC_MDIO_REG_ADDR_C22P_MASK	GENMASK(4, 0)
 #define XGMAC_MAC_MDIO_DATA_GD_MASK		GENMASK(15, 0)
+#define XGMAC_MAC_MDIO_REG_ADDR_C45P_MASK	GENMASK(15, 0)
 
 /* MTL Registers */
 
-- 
2.34.1

