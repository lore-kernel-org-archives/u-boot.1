Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A414AC48297
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 19:04:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC2AA87BB5;
	Tue,  6 Feb 2024 20:04:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dBmyyZP0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55CC087C21; Tue,  6 Feb 2024 20:04:09 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42FAA86DBD
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 20:04:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=belouargamohamed@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-410009b2ca8so761115e9.3
 for <u-boot@lists.denx.de>; Tue, 06 Feb 2024 11:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707246246; x=1707851046; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=23lwzsUrdv3++MhrdagNeL9/MasHmLOl6FS5JDRw7oE=;
 b=dBmyyZP0N9Ivi6m6nyIPfVTWpYBLnC8At6/56pFyxvVDFfPPZ42rEnD0hMKnwthv7S
 eh7gxQJ6BXmENtD74WDxcGFwxPEYVD7TwW1WHnLha8deMVmnW+cfA/mg2rfWG/wQvv1U
 5yVqajXxfxSgt6Fqof53iQWZsyva6tRfBx5rQXjQMBQt5gA2IdTozeQ13MiRMJFmsqSR
 lbDPp2cK4UJj3ELzBFSwG+r5pG7AdbHtksN/qOpmVOTnc2FeAERAMUuQi/Gn46FemrzS
 X48QqSXt/Cn8Xw2KpiUMfkLxqCO2P9dPpuHll+3B7qN18pXOH2NcMV+jqYCSGxwAgF+l
 ImAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707246246; x=1707851046;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=23lwzsUrdv3++MhrdagNeL9/MasHmLOl6FS5JDRw7oE=;
 b=YQRGfWSzn3ICNa55jNtrDA3r2QySrCi4PHT1b4hXTm5oxx5n2mkKeMkHh4MVDY/gXf
 xtUF/1Ets08qddGVLyzLFPyKC9CX5ER+coqT9LIXx4+2y0y/0WTmaqfUsdIh6cfPXx2O
 +NlwlSLyEs1KNTdVJuwYpEU1uvDqI/y/JbgapXJDk01TyRSM8QWXM20YtXRBj0olG2JF
 ftEemp1HjP/Je7HXGxLwg0GIb+F/eCYM74/tKpN38FxwjjSaGq85xto7TqbnRfzFqHcm
 JMPfdo3ZxG3sEbecsi0JNNVodvNtjwm1dYYDdZhpoE/ynlD5MLYpXQnWjCsnw039E+KV
 EIuw==
X-Gm-Message-State: AOJu0Yw+lDSNO2/wWiHETQz02yNfyFMkzANmPOrFNzbpQ5fdx/XwsZ2S
 0kQl1PrYJft0LlqZRLCZCWwKaxH5UQgomtTx29NVNi9ni34wdN1n2Rq8+Rkvf5E=
X-Google-Smtp-Source: AGHT+IF3bv6ffPI2pKyQ0Fv/uIu/vBGpXRcDC0NH1GG2/OJc6NXvyOjCIttANSvrLtmXGCo6pv8NbA==
X-Received: by 2002:a05:600c:3b16:b0:40f:b732:1ed7 with SMTP id
 m22-20020a05600c3b1600b0040fb7321ed7mr2906219wms.34.1707246246073; 
 Tue, 06 Feb 2024 11:04:06 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUsCHpZcUdc7TKF79FsxKAmQ3YCeJ20ro/H90Z8qmgrfdp5seB9BjGa7ALi7e0HWQzaN1OpM4pctZBLnL+roJdT3WNOZ/lIvkUUqJ3QkcCdSowVDteh0eChKX8U0oC67vM1xYYTO/s1dz/6SE+Xi/yu0A0W18ncrM9W7y6rFnzDRkqoH6LcV8Z64iKIog==
Received: from localhost.localdomain ([2a02:842a:10:ba01:bca7:218f:6ef0:fae7])
 by smtp.gmail.com with ESMTPSA id
 l31-20020a05600c1d1f00b0040e3635ca65sm2836230wms.2.2024.02.06.11.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 11:04:05 -0800 (PST)
From: belouargamohamed@gmail.com
X-Google-Original-From: m.belouarga@technologyandstrategy.com
To: u-boot@lists.denx.de
Cc: f.lahoudere@technologyandstrategy.com, eugen.hristev@microchip.com,
 dan.carpenter@linaro.org,
 BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>
Subject: [PATCH] net: macb: Add support for fixed link
Date: Tue,  6 Feb 2024 20:04:02 +0100
Message-Id: <20240206190402.15966-1-m.belouarga@technologyandstrategy.com>
X-Mailer: git-send-email 2.25.1
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

From: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>

The actual driver does not work when there is no linked PHY. These
changes add support for fixed-link feature in the device tree.

Signed-off-by: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>
---
 drivers/net/macb.c | 189 ++++++++++++++++++++++++++++-----------------
 1 file changed, 117 insertions(+), 72 deletions(-)

diff --git a/drivers/net/macb.c b/drivers/net/macb.c
index bfc48dac07..05d638cd77 100644
--- a/drivers/net/macb.c
+++ b/drivers/net/macb.c
@@ -128,6 +128,8 @@ struct macb_device {
 	unsigned long		dummy_desc_dma;
 
 	const struct device	*dev;
+	unsigned int    	duplex;
+	unsigned int    	speed;
 	unsigned short		phy_addr;
 	struct mii_dev		*bus;
 #ifdef CONFIG_PHYLIB
@@ -178,6 +180,12 @@ static int gem_is_gigabit_capable(struct macb_device *macb)
 	return macb_is_gem(macb) && !cpu_is_sama5d2() && !cpu_is_sama5d4();
 }
 
+/* Is the port a fixed link */
+static int macb_port_is_fixed_link(struct macb_device *macb)
+{
+	return macb->phy_addr > PHY_MAX_ADDR;
+}
+
 static void macb_mdio_write(struct macb_device *macb, u8 phy_adr, u8 reg,
 			    u16 value)
 {
@@ -666,97 +674,110 @@ static int macb_phy_init(struct udevice *dev, const char *name)
 	int i;
 
 	arch_get_mdio_control(name);
-	/* Auto-detect phy_addr */
-	ret = macb_phy_find(macb, name);
-	if (ret)
-		return ret;
+	/* If port is not fixed -> setup PHY */
+	if (!macb_port_is_fixed_link(macb)) {
+		/* Auto-detect phy_addr */
+		ret = macb_phy_find(macb, name);
+		if (ret)
+			return ret;
 
-	/* Check if the PHY is up to snuff... */
-	phy_id = macb_mdio_read(macb, macb->phy_addr, MII_PHYSID1);
-	if (phy_id == 0xffff) {
-		printf("%s: No PHY present\n", name);
-		return -ENODEV;
-	}
+		/* Check if the PHY is up to snuff... */
+		phy_id = macb_mdio_read(macb, macb->phy_addr, MII_PHYSID1);
+		if (phy_id == 0xffff) {
+			printf("%s: No PHY present\n", name);
+			return -ENODEV;
+		}
 
 #ifdef CONFIG_PHYLIB
-	macb->phydev = phy_connect(macb->bus, macb->phy_addr, dev,
-			     macb->phy_interface);
-	if (!macb->phydev) {
-		printf("phy_connect failed\n");
-		return -ENODEV;
-	}
+		macb->phydev = phy_connect(macb->bus, macb->phy_addr, dev,
+				     macb->phy_interface);
+		if (!macb->phydev) {
+			printf("phy_connect failed\n");
+			return -ENODEV;
+		}
 
-	phy_config(macb->phydev);
+		phy_config(macb->phydev);
 #endif
 
-	status = macb_mdio_read(macb, macb->phy_addr, MII_BMSR);
-	if (!(status & BMSR_LSTATUS)) {
-		/* Try to re-negotiate if we don't have link already. */
-		macb_phy_reset(macb, name);
-
-		for (i = 0; i < MACB_AUTONEG_TIMEOUT / 100; i++) {
-			status = macb_mdio_read(macb, macb->phy_addr, MII_BMSR);
-			if (status & BMSR_LSTATUS) {
-				/*
-				 * Delay a bit after the link is established,
-				 * so that the next xfer does not fail
-				 */
-				mdelay(10);
-				break;
+		status = macb_mdio_read(macb, macb->phy_addr, MII_BMSR);
+		if (!(status & BMSR_LSTATUS)) {
+			/* Try to re-negotiate if we don't have link already. */
+			macb_phy_reset(macb, name);
+
+			for (i = 0; i < MACB_AUTONEG_TIMEOUT / 100; i++) {
+				status = macb_mdio_read(macb, macb->phy_addr, MII_BMSR);
+				if (status & BMSR_LSTATUS) {
+					/*
+					 * Delay a bit after the link is established,
+					 * so that the next xfer does not fail
+					 */
+					mdelay(10);
+					break;
+				}
+				udelay(100);
 			}
-			udelay(100);
 		}
-	}
 
-	if (!(status & BMSR_LSTATUS)) {
-		printf("%s: link down (status: 0x%04x)\n",
-		       name, status);
-		return -ENETDOWN;
-	}
+		if (!(status & BMSR_LSTATUS)) {
+			printf("%s: link down (status: 0x%04x)\n",
+			       name, status);
+			return -ENETDOWN;
+		}
 
-	/* First check for GMAC and that it is GiB capable */
-	if (gem_is_gigabit_capable(macb)) {
-		lpa = macb_mdio_read(macb, macb->phy_addr, MII_STAT1000);
+		/* First check for GMAC and that it is GiB capable */
+		if (gem_is_gigabit_capable(macb)) {
+			lpa = macb_mdio_read(macb, macb->phy_addr, MII_STAT1000);
 
-		if (lpa & (LPA_1000FULL | LPA_1000HALF | LPA_1000XFULL |
-					LPA_1000XHALF)) {
-			duplex = ((lpa & (LPA_1000FULL | LPA_1000XFULL)) ?
-					1 : 0);
+			if (lpa & (LPA_1000FULL | LPA_1000HALF | LPA_1000XFULL |
+						LPA_1000XHALF)) {
+				duplex = ((lpa & (LPA_1000FULL | LPA_1000XFULL)) ?
+						1 : 0);
 
-			printf("%s: link up, 1000Mbps %s-duplex (lpa: 0x%04x)\n",
-			       name,
-			       duplex ? "full" : "half",
-			       lpa);
+				printf("%s: link up, 1000Mbps %s-duplex (lpa: 0x%04x)\n",
+					name,
+					duplex ? "full" : "half",
+					lpa);
 
-			ncfgr = macb_readl(macb, NCFGR);
-			ncfgr &= ~(MACB_BIT(SPD) | MACB_BIT(FD));
-			ncfgr |= GEM_BIT(GBE);
+				ncfgr = macb_readl(macb, NCFGR);
+				ncfgr &= ~(MACB_BIT(SPD) | MACB_BIT(FD));
+				ncfgr |= GEM_BIT(GBE);
 
-			if (duplex)
-				ncfgr |= MACB_BIT(FD);
+				if (duplex)
+					ncfgr |= MACB_BIT(FD);
 
-			macb_writel(macb, NCFGR, ncfgr);
+				macb_writel(macb, NCFGR, ncfgr);
 
-			ret = macb_linkspd_cb(dev, _1000BASET);
-			if (ret)
-				return ret;
+				ret = macb_linkspd_cb(dev, _1000BASET);
+				if (ret)
+					return ret;
 
-			return 0;
+				return 0;
+			}
 		}
-	}
 
-	/* fall back for EMAC checking */
-	adv = macb_mdio_read(macb, macb->phy_addr, MII_ADVERTISE);
-	lpa = macb_mdio_read(macb, macb->phy_addr, MII_LPA);
-	media = mii_nway_result(lpa & adv);
-	speed = (media & (ADVERTISE_100FULL | ADVERTISE_100HALF)
-		 ? 1 : 0);
-	duplex = (media & ADVERTISE_FULL) ? 1 : 0;
-	printf("%s: link up, %sMbps %s-duplex (lpa: 0x%04x)\n",
-	       name,
-	       speed ? "100" : "10",
-	       duplex ? "full" : "half",
-	       lpa);
+		/* fall back for EMAC checking */
+		adv = macb_mdio_read(macb, macb->phy_addr, MII_ADVERTISE);
+		lpa = macb_mdio_read(macb, macb->phy_addr, MII_LPA);
+		media = mii_nway_result(lpa & adv);
+		speed = (media & (ADVERTISE_100FULL | ADVERTISE_100HALF)
+			? 1 : 0);
+		duplex = (media & ADVERTISE_FULL) ? 1 : 0;
+		printf("%s: link up, %sMbps %s-duplex (lpa: 0x%04x)\n",
+			name,
+			speed ? "100" : "10",
+			duplex ? "full" : "half",
+			lpa);
+	}
+	else {
+		/* if macb port is a fixed link */
+		/* TODO : manage gigabit capable processors */
+		speed = macb->speed;
+		duplex = macb->duplex;
+		printf("%s: link up, %sMbps %s-duplex\n",
+			name,
+			speed ? "100" : "10",
+			duplex ? "full" : "half");	
+	}
 
 	ncfgr = macb_readl(macb, NCFGR);
 	ncfgr &= ~(MACB_BIT(SPD) | MACB_BIT(FD) | GEM_BIT(GBE));
@@ -1276,6 +1297,30 @@ int __weak macb_late_eth_of_to_plat(struct udevice *dev)
 static int macb_eth_of_to_plat(struct udevice *dev)
 {
 	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct macb_device *macb = dev_get_priv(dev);
+	void *blob = (void *)gd->fdt_blob;
+	int node = dev_of_offset(dev);
+	int fl_node, speed_fdt;
+
+	/* fetch 'fixed-link' property */
+	fl_node = fdt_subnode_offset(blob, node, "fixed-link");
+	if (fl_node >= 0) {
+		/* set phy_addr to invalid value for fixed link */
+		macb->phy_addr = PHY_MAX_ADDR + 1;
+		macb->duplex = fdtdec_get_bool(blob, fl_node, "full-duplex");
+		speed_fdt = fdtdec_get_int(blob, fl_node, "speed", 0);
+		if (speed_fdt == 100) {
+			macb->speed = 1;
+		}
+		else if (speed_fdt == 10) {
+			macb->speed = 0;
+		}
+		else {
+			printf("%s: The given speed %d of ethernet in the DT is not supported\n",
+					__func__, speed_fdt);
+			return -EINVAL;
+		}
+	}
 
 	pdata->iobase = (uintptr_t)dev_remap_addr(dev);
 	if (!pdata->iobase)
-- 
2.25.1

