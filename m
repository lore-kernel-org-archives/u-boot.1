Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F2FC54E76
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 02:05:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF1E98748C;
	Fri, 17 Nov 2023 03:05:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l7fSNP9n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2E55874D3; Fri, 17 Nov 2023 03:05:12 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 168ED87469
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 03:05:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1cc5b705769so13516205ad.0
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 18:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700186706; x=1700791506; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KoH1OZ+22PotD+wHJZYahISCbvETjvK+bs2u0ohuhFo=;
 b=l7fSNP9n5dfp3mTjS8CCAiXWGiNbuzLialgRRnyU+10dwEvQm4kb3WEJbGNqmvIYc6
 Fga6+UXG2z1PQCrtI5J/ozOCADn+WqwaOSjDLrgZbO/6dbjMY22HBm/F0IXjG/tTY2xI
 9WRjhnLpUeSt7erB1jm/KAmSkl9TEL/hvxavTFF/xM1rRZFB4c2NHqWo2+FHc+fqKJPy
 fIZYCoMUjzlHnPF+kZeE1KTc415KwZoj58FzOs6gbhqv8e/tFu/iR6VseMHBCXKwf1Ba
 g8jSbubOzSGQDi52NH8cJ3EpQLNPnkXGbof/YKxACKo0a3qZrNWIp1L/gJl8vyljIymN
 sieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700186706; x=1700791506;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KoH1OZ+22PotD+wHJZYahISCbvETjvK+bs2u0ohuhFo=;
 b=I6mvSuotdne5+Dvb/e1+uec9LOigyFyDnOO2+FTC/6+umjHc/STjxC2sduXmk+eUz7
 3U6hw5h4HXXPhENTpDqqC7xWuRKfWNeHFPUbpIDaR3EhNlxOHpe/LLdZ6dDa8yN82C3+
 YTZ+6Wo2Gn/Dm87z5PHAHfI04UspWBN28iwp6zc53D4lvWgk87nVDphK8D2SnUmvoams
 5tDQNI2o6e2zgITDiSez6T27/u7ROH8F7qzNccwZWWo/gT8KVpESdcJ1CQSlp7qSuDA4
 IPuUNbEohkbqIHV4gsnHUEvBsJ0eCZ3Y0GpY0pRtNYOOEe7Z0ytLMeip35o5J3TOAIEg
 9/sg==
X-Gm-Message-State: AOJu0YwDA15HpVvCE57vBoIeieFXT/bPR8KCvsveTD1xS5pM0oamkawQ
 LlkQVULPJtf1HT8mkNhxqf7JpwEYXKo=
X-Google-Smtp-Source: AGHT+IEWA29CFkXZ+m/A/2ukLgglxPTLhyek8BHtuaWKGQqyDJAAoWNGtpp5KDnimEpfFgBq5zqlbw==
X-Received: by 2002:a17:902:f7d6:b0:1c3:3b5c:1fbf with SMTP id
 h22-20020a170902f7d600b001c33b5c1fbfmr9798870plw.10.1700186706125; 
 Thu, 16 Nov 2023 18:05:06 -0800 (PST)
Received: from cs20-buildserver.lan ([180.217.145.22])
 by smtp.gmail.com with ESMTPSA id
 p10-20020a170902e74a00b001c63429fa89sm309412plf.247.2023.11.16.18.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 18:05:05 -0800 (PST)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, YSCHU@nuvoton.com, KWLIU@nuvoton.com,
 jim.t90615@gmail.com, joe.hershberger@ni.com, rfried.dev@gmail.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v2] net: designware: Add bitbang feature for designware driver
Date: Fri, 17 Nov 2023 10:04:53 +0800
Message-Id: <20231117020453.1111505-1-JJLIU0@nuvoton.com>
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

Add bb_miiphy_bus function for designware bitbang feature.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
Changes for v2:
   - add bitbang delay dts read
   - modify printf to debug
---
 drivers/net/designware.c | 105 +++++++++++++++++++++++++++++++++++++++
 drivers/net/designware.h |   5 ++
 2 files changed, 110 insertions(+)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index a174344b3e..e86f96fc1a 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -767,6 +767,31 @@ int designware_eth_probe(struct udevice *dev)
 	priv->bus = miiphy_get_dev_by_name(dev->name);
 	priv->dev = dev;
 
+#if defined(CONFIG_BITBANGMII) && CONFIG_IS_ENABLED(DM_GPIO)
+	if (dev_read_bool(dev, "snps,bitbang-mii")) {
+		debug("\n%s: use bitbang mii..\n", dev->name);
+		ret = gpio_request_by_name(dev, "snps,mdc-gpio", 0,
+                                &priv->mdc_gpio, GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
+		if (ret) {
+			printf("no mdc-gpio\n");
+			return ret;
+		}
+		ret = gpio_request_by_name(dev, "snps,mdio-gpio", 0,
+                                &priv->mdio_gpio, GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
+		if (ret) {
+			printf("no mdio-gpio\n");
+			return ret;
+		}
+
+		priv->bb_delay = dev_read_u32_default(dev, "snps,bitbang-delay", 1);
+
+		bb_miiphy_buses[0].priv = priv;
+		sprintf(bb_miiphy_buses[0].name, dev->name);
+		priv->bus->read = bb_miiphy_read;
+		priv->bus->write = bb_miiphy_write;
+	}
+#endif
+
 	ret = dw_phy_init(priv, dev);
 	debug("%s, ret=%d\n", __func__, ret);
 	if (!ret)
@@ -876,3 +901,83 @@ static struct pci_device_id supported[] = {
 };
 
 U_BOOT_PCI_DEVICE(eth_designware, supported);
+
+#if CONFIG_IS_ENABLED(BITBANGMII) && CONFIG_IS_ENABLED(DM_GPIO)
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
+	printf("jim[%d]\n",priv->bb_delay);
+	udelay(priv->bb_delay);
+
+	return 0;
+}
+
+struct bb_miiphy_bus bb_miiphy_buses[] = {
+        {
+		.name		= "bb_miiphy",
+		.mdio_active	= dw_eth_bb_mdio_active,
+		.mdio_tristate	= dw_eth_bb_mdio_tristate,
+		.set_mdio	= dw_eth_bb_set_mdio,
+		.get_mdio	= dw_eth_bb_get_mdio,
+		.set_mdc	= dw_eth_bb_set_mdc,
+		.delay		= dw_eth_bb_delay,
+        }
+};
+
+int bb_miiphy_buses_num = ARRAY_SIZE(bb_miiphy_buses);
+#endif
diff --git a/drivers/net/designware.h b/drivers/net/designware.h
index 918a38615a..cf8de35cfe 100644
--- a/drivers/net/designware.h
+++ b/drivers/net/designware.h
@@ -230,11 +230,16 @@ struct dw_eth_dev {
 	u32 max_speed;
 	u32 tx_currdescnum;
 	u32 rx_currdescnum;
+#if defined(CONFIG_BITBANGMII)
+	u32 bb_delay;
+#endif
 
 	struct eth_mac_regs *mac_regs_p;
 	struct eth_dma_regs *dma_regs_p;
 #if CONFIG_IS_ENABLED(DM_GPIO)
 	struct gpio_desc reset_gpio;
+	struct gpio_desc mdc_gpio;
+	struct gpio_desc mdio_gpio;
 #endif
 #ifdef CONFIG_CLK
 	struct clk *clocks;	/* clock list */
-- 
2.25.1

