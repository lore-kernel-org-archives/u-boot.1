Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BDDC02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 14:13:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4144E8081A;
	Fri, 17 Jan 2025 15:11:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rujw6tTC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1E5D80312; Fri, 17 Jan 2025 11:46:05 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 960A1806D8
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 11:46:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhang971090220@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2167141dfa1so34807435ad.1
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 02:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737110762; x=1737715562; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GAKzIkF86e1mUzKGjNADoW+BKKVAVLsarc0clozPSFc=;
 b=Rujw6tTCxl/PUjghjQZQwKP0UjLoReUhTP0VA3Q7F4szqZiZhNGuV9OrOcFJKIQ+eW
 lNekmyW8eMbZgX4WVoTozvZgKnT5XO6gn8xlgvk4KMVAlK9X5dEFARG/wJ0suLuwq389
 vIlsCYN6iEwrmiSOXDoEGxwehGK4Jq2+l5n0EMG0H52eAVasgE2r/WR8hxm3t8fDpiqF
 xHVPA+dFKsJTHl49JahTt1z/wz06ALfm6cNYBomcnHqjASxDdxbOeqXbIpckNL2apeh6
 0gQdSj4bCNauvj4U5yn0ODQB1msZQxSTj2enYh+y2mkN+o7b78F8s9jMVzYFSMuigAZ2
 011g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737110762; x=1737715562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GAKzIkF86e1mUzKGjNADoW+BKKVAVLsarc0clozPSFc=;
 b=Wvg/WflxrYZvcblyRjv6+Im7/X8ATW/epdERAZDRJfqtQXatTQ695+yKqR/3hwSX55
 FTSxDOPHa7+MIZq/8NgqSqUotnYokRjfGQNAcKEG5kXok+SNjyHS40TC/geNVhK5MaHj
 8d2AyMvY3lSBeaHzzBg6cEsBMzw8QGphA4Bp0zHYOmAv5EM8zVvdtzupZ3v1SFYI75Va
 uqedpblcV0mGdSV9z4/r2WLMbKjgvOlHUMnSdEuZ8dj42sqsqP0Pw7fKXoxJ4egvKm4J
 UbMvF/jb9KnOjQQZWi17yEo/8BDToEhzxpspdOJ6/KRwAIt9Fo/d38Bk1mz+f2I/NhXV
 DU2A==
X-Gm-Message-State: AOJu0YwERU0etxTXMGI3/7gSkK4rcWKjOvCQRnhfNeEpo4vfV1MhkrOp
 d8vJPK5eExaPKYJu5ehskwFHRYhzdAnjUQaMq+hfaOTg3Cvx82Qzc16fQ26C
X-Gm-Gg: ASbGncsG4sOEL0cejz8/X3oqttPVC1/SgTcKxwNL42L7ZqsVNC9dRyGW8ZqPBZWQnOh
 07nK6g0oJWgY/DlZZuut0SGjFri8CjwGjWqVRBZJdGZczRKFoAhxxqPnDhNQQ4iGFPGJ16a25pl
 giiYWUv52YD5Bvh3/ozGLDbSEcdjQH35doI+SHzVAjT+f7Eq+wCpzUllK64rCFrmc2ijF7o5pjF
 vkkJg189iD+7twBZOgyUK4r9Qd3JgGIcoK3yTkLiZu4m15EvccMeUaxDkA0dcCWrksm7zya2NTB
 /MUcabWEVanPdxQPe52LP8Mka4hS
X-Google-Smtp-Source: AGHT+IH9T4P2bkP+ujoywXUxTYNkPjkFWLqLHhzv0lutEzb03bFC3E4C8UOoGnSmiN1weaL479BosQ==
X-Received: by 2002:a17:903:988:b0:215:ba2b:cd55 with SMTP id
 d9443c01a7336-21c35c53045mr34100285ad.2.1737110762055; 
 Fri, 17 Jan 2025 02:46:02 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d4028d6sm12972885ad.226.2025.01.17.02.46.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 02:46:01 -0800 (PST)
From: Michael Chang <zhang971090220@gmail.com>
To: trini@konsulko.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 zhang971090220@gmail.com, yschu@nuvoton.com, JJLIU0@nuvoton.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 3/3] net: designware: Add bitbang feature for designware
 driver.
Date: Fri, 17 Jan 2025 18:45:40 +0800
Message-Id: <20250117104540.1580343-4-zhang971090220@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250117104540.1580343-1-zhang971090220@gmail.com>
References: <20250117104540.1580343-1-zhang971090220@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Jan 2025 15:10:59 +0100
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

Add bb_miiphy_bus function for designware bitbang feature.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
Signed-off-by: Michael Chang <zhang971090220@gmail.com>
---
 drivers/net/designware.c | 113 +++++++++++++++++++++++++++++++++++++++
 drivers/net/designware.h |   6 ++-
 2 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 07b0f49ef5..94d8f1b4c0 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -784,6 +784,39 @@ int designware_eth_probe(struct udevice *dev)
 	priv->bus = miiphy_get_dev_by_name(dev->name);
 	priv->dev = dev;
 
+#if IS_ENABLED(CONFIG_BITBANGMII) && IS_ENABLED(CONFIG_DM_GPIO)
+	if (dev_read_bool(dev, "snps,bitbang-mii")) {
+		int bus_idx;
+
+		debug("\n%s: use bitbang mii..\n", dev->name);
+		ret = gpio_request_by_name(dev, "snps,mdc-gpio", 0,
+					   &priv->mdc_gpio, GPIOD_IS_OUT
+					   | GPIOD_IS_OUT_ACTIVE);
+		if (ret) {
+			debug("no mdc-gpio\n");
+			return ret;
+		}
+		ret = gpio_request_by_name(dev, "snps,mdio-gpio", 0,
+					   &priv->mdio_gpio, GPIOD_IS_OUT
+					   | GPIOD_IS_OUT_ACTIVE);
+		if (ret) {
+			debug("no mdio-gpio\n");
+			return ret;
+		}
+		priv->bb_delay = dev_read_u32_default(dev, "snps,bitbang-delay", 1);
+
+		for (bus_idx = 0; bus_idx < bb_miiphy_buses_num; bus_idx++) {
+			if (!bb_miiphy_buses[bus_idx].priv) {
+				bb_miiphy_buses[bus_idx].priv = priv;
+				strlcpy(bb_miiphy_buses[bus_idx].name, priv->bus->name,
+					MDIO_NAME_LEN);
+				priv->bus->read = bb_miiphy_read;
+				priv->bus->write = bb_miiphy_write;
+				break;
+			}
+		}
+	}
+#endif
 	ret = dw_phy_init(priv, dev);
 	debug("%s, ret=%d\n", __func__, ret);
 	if (!ret)
@@ -894,3 +927,83 @@ static struct pci_device_id supported[] = {
 };
 
 U_BOOT_PCI_DEVICE(eth_designware, supported);
+
+#if IS_ENABLED(CONFIG_BITBANGMII) && IS_ENABLED(CONFIG_DM_GPIO)
+static int dw_eth_bb_mdio_active(struct bb_miiphy_bus *bus)
+{
+	struct dw_eth_dev *priv = bus->priv;
+	struct gpio_desc *desc = &priv->mdio_gpio;
+
+	desc->flags = 0;
+	dm_gpio_set_dir_flags(&priv->mdio_gpio, GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
+
+	return 0;
+}
+
+static int dw_eth_bb_mdio_tristate(struct bb_miiphy_bus *bus)
+{
+	struct dw_eth_dev *priv = bus->priv;
+	struct gpio_desc *desc = &priv->mdio_gpio;
+
+	desc->flags = 0;
+	dm_gpio_set_dir_flags(&priv->mdio_gpio, GPIOD_IS_IN);
+
+	return 0;
+}
+
+static int dw_eth_bb_set_mdio(struct bb_miiphy_bus *bus, int v)
+{
+	struct dw_eth_dev *priv = bus->priv;
+
+	if (v)
+		dm_gpio_set_value(&priv->mdio_gpio, 1);
+	else
+		dm_gpio_set_value(&priv->mdio_gpio, 0);
+
+	return 0;
+}
+
+static int dw_eth_bb_get_mdio(struct bb_miiphy_bus *bus, int *v)
+{
+	struct dw_eth_dev *priv = bus->priv;
+
+	*v = dm_gpio_get_value(&priv->mdio_gpio);
+
+	return 0;
+}
+
+static int dw_eth_bb_set_mdc(struct bb_miiphy_bus *bus, int v)
+{
+	struct dw_eth_dev *priv = bus->priv;
+
+	if (v)
+		dm_gpio_set_value(&priv->mdc_gpio, 1);
+	else
+		dm_gpio_set_value(&priv->mdc_gpio, 0);
+
+	return 0;
+}
+
+static int dw_eth_bb_delay(struct bb_miiphy_bus *bus)
+{
+	struct dw_eth_dev *priv = bus->priv;
+
+	udelay(priv->bb_delay);
+	return 0;
+}
+
+struct bb_miiphy_bus bb_miiphy_buses[] = {
+	{
+		.name		= BB_MII_DEVNAME,
+		.mdio_active	= dw_eth_bb_mdio_active,
+		.mdio_tristate	= dw_eth_bb_mdio_tristate,
+		.set_mdio	= dw_eth_bb_set_mdio,
+		.get_mdio	= dw_eth_bb_get_mdio,
+		.set_mdc	= dw_eth_bb_set_mdc,
+		.delay		= dw_eth_bb_delay,
+		.priv		= NULL,
+	}
+};
+
+int bb_miiphy_buses_num = ARRAY_SIZE(bb_miiphy_buses);
+#endif
diff --git a/drivers/net/designware.h b/drivers/net/designware.h
index e47101ccaf..cccf9d54e0 100644
--- a/drivers/net/designware.h
+++ b/drivers/net/designware.h
@@ -229,7 +229,11 @@ struct dw_eth_dev {
 	u32 max_speed;
 	u32 tx_currdescnum;
 	u32 rx_currdescnum;
-
+#if IS_ENABLED(CONFIG_BITBANGMII) && IS_ENABLED(CONFIG_DM_GPIO)
+	u32 bb_delay;
+	struct gpio_desc mdc_gpio;
+	struct gpio_desc mdio_gpio;
+#endif
 	struct eth_mac_regs *mac_regs_p;
 	struct eth_dma_regs *dma_regs_p;
 #if CONFIG_IS_ENABLED(DM_GPIO)
-- 
2.34.1

