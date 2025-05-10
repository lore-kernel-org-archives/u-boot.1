Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9D7C3ABCB
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 12:50:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBCBA8283E;
	Sat, 10 May 2025 14:50:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sima.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sima.ai header.i=@sima.ai header.b="r5LFowgF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1B5B8211F; Sat, 10 May 2025 06:12:09 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D00380EE5
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 06:12:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sima.ai
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nikunj.kela@sima.ai
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-737685eda9aso299207b3a.3
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 21:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sima.ai; s=google; t=1746850325; x=1747455125; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=96NyuEFezasbHrhHfQhRPOuv9SzJydnsX6mpauiLxck=;
 b=r5LFowgFSilGzQhydw3X0VhlKz8v/GlDt93fa1YuRgg0XjfZrc01U3d5YVe5kQPQHk
 kQ8wCh89YfRyw81kGOA/HeK14DMQX+rECebCRgUNQ+yF4FeyFq98cpx6FOyuspX5V/es
 DuWUDpzuOwW0XsBT8U3Pj6+s0XrvX+Xz9tKAqA5+ckuoxEJZm/5++44azltmRrsxnRY3
 1dbWZkFKZ1P7UP3Cn7QX0FOYUoknfzseVJ91Sre0yerQtkDIOfRnGVKQoCRY8oCmQ9Jb
 RhV2sAT/IbEmApI9ANDxgvEeBm5OV/kcgjFo6i5omwKPfArUacAmlIRP/VUjNcD0nHza
 fhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746850325; x=1747455125;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=96NyuEFezasbHrhHfQhRPOuv9SzJydnsX6mpauiLxck=;
 b=ZZB213By5mTHARMGStC2ZJw/z12q50CpMtc8wRURaE6bgj9iPXcOiJ0m+oEPwRlLe+
 MW7L6w5HZUJwKGWFQKkZd7QHdyUaBfqunzLsW07QQgUwoj9onrzrf8N/ccrQHH7vcuJV
 FVRvnEoPytRPJEby7NnRupMKAGtq5J9ObYRdLwj5MKNNs6aZyeAYSteMQcMc+Xd3waoO
 RMXWkR9zOZpA8TXVV+pqcKWei2pjvddPWP8yz5D2gOhOPlt8buQGFXuTDAa4YlP1/M7b
 o4WTs78KXN6OHZwqetbh5sPn8fiy/t62chnAZ36LkoQd299N4vR+wgC36qQXCV1ipshu
 1nhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5UGZg1782s7StD5Zr+NR7DnIig6hgqIvvc8HFT2vKGFB5i3KkPjPAzCoEkMOuow15Hz9HHTA=@lists.denx.de
X-Gm-Message-State: AOJu0YysuF7IJ4a7zp/e0oNhzIGQebe1SKo50cwJY5E7S0H1qNPzSfiw
 4+NFdV5puFECKZr8h9MzSvx5bGyJt6EAIbHno7/xAtqFSRMhOH7sgX4cRCIPyUA=
X-Gm-Gg: ASbGncsHYSPEEr4NLPRQPoxhMsr2JdzmxtndNussAcii7e6uJn5oFa4yHavV1XKRl9B
 69+rpT3t9y8nusl3YPuCK9bm9qq9Ki6R9gsKr9Xhj1dCHDxYqEAzkLt9d1JgBuXut8mB5gkclyK
 Y6J5JlW8PXDtVAZ3Jl9GRoGgPCXtn6nbed8V1Iwulwu2AEhrx0SDVd5eioGGFCuEzvg4RPd7K02
 lsnyoFz3KLrMryE8iVMpgxAt6zCOaPcH5VlY/ar2BNOiuaouB/pcSuqJZ7blsM2deaovIh0kUMk
 OOqgfLly7f/H8ZEILjh15iMOYT+/D43UkqhBUw+vqSJbsDJlQG4zQnLt5F9qk5hFgec9jg==
X-Google-Smtp-Source: AGHT+IFhSNNb3AHqnv+uRMgLP2RBiM++2bjOIfUmLwwseYfpjBrxDt0RYHj6QnNDGRrR5yHrbByTgw==
X-Received: by 2002:a05:6a00:3688:b0:73e:2b50:426 with SMTP id
 d2e1a72fcca58-7423bfba21dmr2948885b3a.4.1746850325017; 
 Fri, 09 May 2025 21:12:05 -0700 (PDT)
Received: from nikunj-kela-u22.eng.sima.ai ([205.234.21.7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742377278cesm2612464b3a.50.2025.05.09.21.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 21:12:04 -0700 (PDT)
From: Nikunj Kela <nikunj.kela@sima.ai>
To: joe.hershberger@ni.com,
	rfried.dev@gmail.com,
	trini@konsulko.com
Cc: tien.fong.chee@intel.com, boon.khai.ng@intel.com, u-boot@lists.denx.de,
 Nikunj Kela <nikunj.kela@sima.ai>
Subject: [PATCH] net: xgmac: Augment mdio read/write with cl-45 format support
Date: Fri,  9 May 2025 21:12:00 -0700
Message-Id: <20250510041200.2552981-1-nikunj.kela@sima.ai>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 10 May 2025 14:50:43 +0200
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
 drivers/net/dwc_eth_xgmac.c | 67 +++++++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 18 deletions(-)

diff --git a/drivers/net/dwc_eth_xgmac.c b/drivers/net/dwc_eth_xgmac.c
index 03959ea95a5..68c69b7b3df 100644
--- a/drivers/net/dwc_eth_xgmac.c
+++ b/drivers/net/dwc_eth_xgmac.c
@@ -147,6 +147,7 @@ static int xgmac_mdio_read(struct mii_dev *bus, int mdio_addr, int mdio_devad,
 	u32 val;
 	u32 hw_addr;
 	int ret;
+	u32 c45 = 1;
 
 	debug("%s(dev=%p, addr=0x%x, reg=%d):\n", __func__, xgmac->dev, mdio_addr,
 	      mdio_reg);
@@ -159,19 +160,34 @@ static int xgmac_mdio_read(struct mii_dev *bus, int mdio_addr, int mdio_devad,
 		return ret;
 	}
 
-	/* Set clause 22 format */
-	val = BIT(mdio_addr);
-	writel(val, &xgmac->mac_regs->mdio_clause_22_port);
+	if (mdio_devad == MDIO_DEVAD_NONE) {
+		/* Set clause 22 format */
+		c45 = 0;
+		val = BIT(mdio_addr);
+		writel(val, &xgmac->mac_regs->mdio_clause_22_port);
+	} else {
+		val = readl(&xgmac->mac_regs->mdio_clause_22_port);
+		val &= ~BIT(mdio_addr);
+		writel(val, &xgmac->mac_regs->mdio_clause_22_port);
+	}
 
-	hw_addr = (mdio_addr << XGMAC_MAC_MDIO_ADDRESS_PA_SHIFT) |
-		   (mdio_reg & XGMAC_MAC_MDIO_REG_ADDR_C22P_MASK);
+	if (c45) {
+		hw_addr = (mdio_addr << XGMAC_MAC_MDIO_ADDRESS_PA_SHIFT) |
+			   (mdio_reg & 0xffff);
+		hw_addr |= mdio_devad << XGMAC_MAC_MDIO_ADDRESS_DA_SHIFT;
+	} else {
+		hw_addr = (mdio_addr << XGMAC_MAC_MDIO_ADDRESS_PA_SHIFT) |
+			   (mdio_reg & XGMAC_MAC_MDIO_REG_ADDR_C22P_MASK);
+	}
 
 	val = xgmac->config->config_mac_mdio <<
 	      XGMAC_MAC_MDIO_ADDRESS_CR_SHIFT;
 
-	val |= XGMAC_MAC_MDIO_ADDRESS_SADDR |
-	       XGMAC_MDIO_SINGLE_CMD_ADDR_CMD_READ |
-	       XGMAC_MAC_MDIO_ADDRESS_SBUSY;
+	if (!c45)
+		val |= XGMAC_MAC_MDIO_ADDRESS_SADDR;
+
+	val |= XGMAC_MDIO_SINGLE_CMD_ADDR_CMD_READ |
+		XGMAC_MAC_MDIO_ADDRESS_SBUSY;
 
 	ret = xgmac_mdio_wait_idle(xgmac);
 	if (ret) {
@@ -207,6 +223,7 @@ static int xgmac_mdio_write(struct mii_dev *bus, int mdio_addr, int mdio_devad,
 	u32 val;
 	u32 hw_addr;
 	int ret;
+	u32 c45 = 1;
 
 	debug("%s(dev=%p, addr=0x%x, reg=%d, val=0x%x):\n", __func__, xgmac->dev,
 	      mdio_addr, mdio_reg, mdio_val);
@@ -219,21 +236,35 @@ static int xgmac_mdio_write(struct mii_dev *bus, int mdio_addr, int mdio_devad,
 		return ret;
 	}
 
-	/* Set clause 22 format */
-	val = BIT(mdio_addr);
-	writel(val, &xgmac->mac_regs->mdio_clause_22_port);
-
-	hw_addr = (mdio_addr << XGMAC_MAC_MDIO_ADDRESS_PA_SHIFT) |
-		   (mdio_reg & XGMAC_MAC_MDIO_REG_ADDR_C22P_MASK);
+	if (mdio_devad == MDIO_DEVAD_NONE) {
+		c45 = 0;
+		/* Set clause 22 format */
+		val = BIT(mdio_addr);
+		writel(val, &xgmac->mac_regs->mdio_clause_22_port);
+	} else {
+		val = readl(&xgmac->mac_regs->mdio_clause_22_port);
+		val &= ~BIT(mdio_addr);
+		writel(val, &xgmac->mac_regs->mdio_clause_22_port);
+	}
 
-	hw_addr |= (mdio_reg >> XGMAC_MAC_MDIO_ADDRESS_PA_SHIFT) <<
-		    XGMAC_MAC_MDIO_ADDRESS_DA_SHIFT;
+	if (c45) {
+		hw_addr = (mdio_addr << XGMAC_MAC_MDIO_ADDRESS_PA_SHIFT) |
+			   (mdio_reg & 0xffff);
+		hw_addr |= mdio_devad << XGMAC_MAC_MDIO_ADDRESS_DA_SHIFT;
+	} else {
+		hw_addr = (mdio_addr << XGMAC_MAC_MDIO_ADDRESS_PA_SHIFT) |
+			   (mdio_reg & XGMAC_MAC_MDIO_REG_ADDR_C22P_MASK);
+		hw_addr |= (mdio_reg >> XGMAC_MAC_MDIO_ADDRESS_PA_SHIFT) <<
+			    XGMAC_MAC_MDIO_ADDRESS_DA_SHIFT;
+	}
 
 	val = (xgmac->config->config_mac_mdio <<
 	       XGMAC_MAC_MDIO_ADDRESS_CR_SHIFT);
 
-	val |= XGMAC_MAC_MDIO_ADDRESS_SADDR |
-		mdio_val | XGMAC_MDIO_SINGLE_CMD_ADDR_CMD_WRITE |
+	if (!c45)
+		val |= XGMAC_MAC_MDIO_ADDRESS_SADDR;
+
+	val |=	mdio_val | XGMAC_MDIO_SINGLE_CMD_ADDR_CMD_WRITE |
 		XGMAC_MAC_MDIO_ADDRESS_SBUSY;
 
 	ret = xgmac_mdio_wait_idle(xgmac);
-- 
2.34.1

