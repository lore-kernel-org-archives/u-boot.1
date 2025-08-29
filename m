Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794DCCA0FF9
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 14:30:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D22028367F;
	Fri, 29 Aug 2025 16:29:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sima.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sima.ai header.i=@sima.ai header.b="B417jkAK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8844083487; Fri, 29 Aug 2025 06:12:40 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E942B8341A
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 06:12:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sima.ai
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nikunj.kela@sima.ai
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-248cd112855so2933015ad.1
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 21:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sima.ai; s=google; t=1756440756; x=1757045556; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0eRd1kzQJZKuOgV/2HCP0J8zb+0CQLnGHGsTDioM1rs=;
 b=B417jkAKOO9bL1F/lPd0PEJC+IoDTNs7RwuH14mLc3wYHuqVT4FS9heQEFoUrv6LGv
 pVQPRBvS8MbE2GLt3Precwcqn6oj/zMuhOsFadkUyRg0EJn7322KNZ0d8aRRJl9M70hX
 G0w9BQj8pN+TIJ6IdhnmhJprpw7n8IejOxORL7g8OK1PIhS2MNINP9WneVbGo6NDh03F
 kaN4LkhNSZmTsqKuNUiujcjYsHzodvaWtefOF9vMTVsGdv+5iSvsViRkFYtc3eG0vf6L
 fQT3gECAh6rAoSTqwJiWLF8QtujsYEdzIdrkIvE5OoLA042PxV3RYPESPVPhVMZ/Tro0
 WfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756440756; x=1757045556;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0eRd1kzQJZKuOgV/2HCP0J8zb+0CQLnGHGsTDioM1rs=;
 b=joosNKNSFm1p9Vwy1SiODeSW4juq6P+O5vuLwDUBAsOM69tePBAE6F6Go8gOshqmdq
 xV7o5kCpjeeUqXbeH9X1m/LfDG242W5ew2th8uTJeY3KAFyEyo0M5RdAm/zNcaIuIqS2
 o8DXj/NOoVHZC+2V3qCQeKNTe2Mg54XekQ3cB5CNDxtoCZT/eUaB7Ok+WdtO70eZizZT
 YVerA95PwJu4QUFqIU3ae/Ugj8MzGQUpLWJWiQ5PZB/n00+xhHTv57YlndrZ74hG9SlX
 KzV7JX/Hj/mYQ1kFgx8PFjfMRzALdrZ/04Rw/D4F2HqEYvrDtXzKtVfq0LQRQkaNWTme
 m3OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE2Gcbzbpr29NAgELrHSWBk5HeF+gQxA4CaYfJiV4Xf+ebuzcw5xyN+uTlQXGtGdA2QV/5a/c=@lists.denx.de
X-Gm-Message-State: AOJu0YzhLWvhYAXEZkE6m3WgGxMtJ//K50328A0LGRQuhkkCpsgg3bC9
 Gx+n5PK3yDehl2nPrC/5/9qW1pK8iULV6kQQPzKtdtDwkPijlBmasnDumSyTTJHOVdQ=
X-Gm-Gg: ASbGncvUYlOgzPLbDYu1jiOMDAVE1jNdSkPlSo6RNYDgNZhxQH4kzUzAGf1eBtXCJaB
 4diWfhPgcwfHG8FuvRYZsfzCANixX9NUFvOGfnlpczbDUjCETW16uJeczSCA6JY6LtBkZ1kJ+Zl
 c/NGolFX4ZFcq3SdVHJhCzj49dcA0TA40+t3HvLuN/2Yr2NDPNUn77o9BUmya4AvTEJ4kK87+5x
 DMv0m6LBpGi+/vuJWOtpg+CZfPsGk4KgmhWpgtFTI4KG73kkursSQUKkQ51ueBAP8XqrjnRQ2ax
 jJV/SEgA5au4FWTKzZ8CpRxadDBJ4n7pYiRGwZWAzNz+QbuewX+juDxTBvk042IU5ewuC4u9Uv6
 MpMAt0P0OZQ0x4rVcynrywiV3LxDB/9132MYhjw4xk2jphNfS2rQ=
X-Google-Smtp-Source: AGHT+IEms7cK5pkk+uVQkrHWGjIOVfZfTvPe+ddqJQRSQbT5wz9LPJQM/zdPasxa5zIeokFxZdptiw==
X-Received: by 2002:a17:902:f547:b0:249:928:77de with SMTP id
 d9443c01a7336-24909287d6dmr12479815ad.0.1756440756223; 
 Thu, 28 Aug 2025 21:12:36 -0700 (PDT)
Received: from nikunj-kela-u22.eng.sima.ai ([205.234.21.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490374417dsm10820995ad.52.2025.08.28.21.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 21:12:35 -0700 (PDT)
From: Nikunj Kela <nikunj.kela@sima.ai>
To: joe.hershberger@ni.com,
	rfried.dev@gmail.com
Cc: boon.khai.ng@altera.com, u-boot@lists.denx.de,
 Nikunj Kela <nikunj.kela@sima.ai>
Subject: [PATCH v3] net: xgmac: Augment mdio read/write with cl-45 format
 support
Date: Thu, 28 Aug 2025 21:12:32 -0700
Message-Id: <20250829041232.1160655-1-nikunj.kela@sima.ai>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 29 Aug 2025 16:29:12 +0200
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
Reviewed-by: Boon Khai Ng <boon.khai.ng@altera.com>
Tested-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
Changes in v3:
	- replaced tab with space

Changes in v2:
	- Created separate function for configuring clause format

[2]: https://patchwork.ozlabs.org/project/uboot/patch/20250828225532.1147284-1-nikunj.kela@sima.ai/
[1]: https://patchwork.ozlabs.org/project/uboot/patch/20250510041200.2552981-1-nikunj.kela@sima.ai/
---
 drivers/net/dwc_eth_xgmac.c | 60 ++++++++++++++++++++++++-------------
 drivers/net/dwc_eth_xgmac.h |  1 +
 2 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/drivers/net/dwc_eth_xgmac.c b/drivers/net/dwc_eth_xgmac.c
index d29d871ea8c..458b87af7a2 100644
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
+	val |= mdio_val | XGMAC_MDIO_SINGLE_CMD_ADDR_CMD_WRITE |
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

