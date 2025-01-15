Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD02C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 02:09:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB8BA8070C;
	Wed, 15 Jan 2025 03:09:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UQCewjf2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8086D80027; Wed, 15 Jan 2025 02:43:57 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C15E8069A
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 02:43:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhang971090220@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21654fdd5daso105244965ad.1
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736905434; x=1737510234; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z3AAYVQ77G29R4BCoUNAZHPpZEDeBWZJwriQ0CgQUec=;
 b=UQCewjf2oYgSlFNhP33iHj22u0pPYWYAto4Bq6PJcIxgDOs7NGwuAetZBZD/RMXLNk
 4B/SpVyvLIxWOW7l294Llw9igUi7RAeVH/7mXDw8za3QXDAZWkAS5oJw8Wt2SODlzJG9
 sOPy25jLUnz+Ui3OG3nYY7VEyld7TZFZ1MDRFIYUUpw+zbR2QDz2mKeSU7X/CNJs3jLf
 fw5VLmeT1fYuOx2k/3PSWzDFS6I80O5fD2HQAUkkUTvB9GuobzzVFxFUltb3WYgR932a
 /LUvinfheLk7QCdwkVILR97Azrkn6I5zEd0Z9fBWAyEzkb07fvtXR4cl+2OREb6Btb5s
 eh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736905434; x=1737510234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z3AAYVQ77G29R4BCoUNAZHPpZEDeBWZJwriQ0CgQUec=;
 b=ScvpRqL/Xhb2b6CEvVwpr+FjWBDEMu/SVYjS0wIToS8jxMXSZ7+cCbu4+E2HkKQ9nF
 /0iidskLXDwTsjrnC68De3fUva68imYiBBpJuyj3s5Hj5teszcOQHMAaOxLrtM/+6u4U
 sjRK1FhNdT3Z2yrLYa0CekM9vUQLgCp6VSObmpQFkT5bZdS+AKLqFMI9qESCobAQIYhw
 RYGPPh8GASNXHMbEeYTfAvm5pGA6GO3JqTgM+EQkWRlGq/YUJwaL25JGEd2dIoxOT1U5
 koOL788NG5ctO1Wd00uxWB2ODFO5k5wU6xerYIBxPLBR7k1ibPE99oXz17E0qElI5x5Y
 3Sfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOfs3xN0YsMdLAAdrHygERItuEajdMSAuXen3NVqtB/Kdf5QwBMt35E3JzkkElqCpqx5z1kkc=@lists.denx.de
X-Gm-Message-State: AOJu0YxcpbSopXoPWbwZMHGmO7D/iGZ9oO7B0jVG6+BPznTg/xVoyTRP
 XZkc4nx0sjcL8Tx2LqnRTCWk+Ul1/slOgZLvp4ca5adDrXiXZ12P
X-Gm-Gg: ASbGncuk5LHEQ0PDcACV8fzU0l5DJJFJ/xXMWvi5eizAjKqNXn9aljD4HsOpzz9u5ev
 iQAp/fsjZBmrdjfm8UralcdhBHwwyaXRv626S6XOFLt876MxHr/anozjwhioACZPL3gXRo6o9yu
 4q4akAFP0fl2vuDl5ztYrFzkoocw2Z/0WNp8+8noyQxhZhDj5+dQBM872NAAiBZXHN56IswTpjT
 WRo47Qm/dQwm5ojq92JNqYJbeTlwLNzRf/i5c+G5w3Jnyx0ovO2lOVzCoEoTa871qaqNHiee9jp
 kxQUkmcVeTvkc3uzZMRGlTcHO8Hp
X-Google-Smtp-Source: AGHT+IHYK559Nk/TZab1oIkEnitL9NF3MA/n89hwjcoSQqxyLk/AHYZxppHHeI22eDUzx+Ky/n/gMw==
X-Received: by 2002:a17:902:d481:b0:216:6d48:9177 with SMTP id
 d9443c01a7336-21a83f43c6bmr310242925ad.11.1736905433569; 
 Tue, 14 Jan 2025 17:43:53 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f10ddbesm73634675ad.2.2025.01.14.17.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 17:43:53 -0800 (PST)
From: Michael Chang <zhang971090220@gmail.com>
To: trini@konsulko.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 zhang971090220@gmail.com
Cc: JJLIU0@nuvoton.com,
	u-boot@lists.denx.de
Subject: [PATCH v3 1/1] net: designware: Add bitbang feature for designware
 driver
Date: Wed, 15 Jan 2025 09:42:11 +0800
Message-Id: <20250115014211.2599328-2-zhang971090220@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250115014211.2599328-1-zhang971090220@gmail.com>
References: <20250115014211.2599328-1-zhang971090220@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 15 Jan 2025 03:09:20 +0100
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
 arch/arm/dts/nuvoton-npcm845-evb.dts |   1 +
 drivers/net/designware.c             | 111 +++++++++++++++++++++++++++
 drivers/net/designware.h             |   6 +-
 3 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/nuvoton-npcm845-evb.dts b/arch/arm/dts/nuvoton-npcm845-evb.dts
index 0d3aaa0fff..1535defe38 100644
--- a/arch/arm/dts/nuvoton-npcm845-evb.dts
+++ b/arch/arm/dts/nuvoton-npcm845-evb.dts
@@ -190,6 +190,7 @@
 	snps,mdio-gpio = <&gpio2 28 GPIO_ACTIVE_HIGH>;    /* gpio92 */
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 1000000>;
+	snps,bitbang-delay = <1>;
 	snps,reset-gpio = <&gpio2 29 GPIO_ACTIVE_LOW>;    /* gpio93 */
 	status = "okay";
 };
diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 07b0f49ef5..4fe13777e5 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -784,6 +784,37 @@ int designware_eth_probe(struct udevice *dev)
 	priv->bus = miiphy_get_dev_by_name(dev->name);
 	priv->dev = dev;
 
+#if defined(CONFIG_BITBANGMII) && CONFIG_IS_ENABLED(DM_GPIO)
+	if (dev_read_bool(dev, "snps,bitbang-mii")) {
+		int bus_idx;
+
+		debug("\n%s: use bitbang mii..\n", dev->name);
+		ret = gpio_request_by_name(dev, "snps,mdc-gpio", 0,
+					&priv->mdc_gpio, GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
+		if (ret) {
+			debug("no mdc-gpio\n");
+			return ret;
+		}
+		ret = gpio_request_by_name(dev, "snps,mdio-gpio", 0,
+					&priv->mdio_gpio, GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
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
+						MDIO_NAME_LEN);
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
@@ -894,3 +925,83 @@ static struct pci_device_id supported[] = {
 };
 
 U_BOOT_PCI_DEVICE(eth_designware, supported);
+
+#if CONFIG_IS_ENABLED(BITBANGMII) && CONFIG_IS_ENABLED(DM_GPIO)
+static int npcm_eth_bb_mdio_active(struct bb_miiphy_bus *bus)
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
+static int npcm_eth_bb_mdio_tristate(struct bb_miiphy_bus *bus)
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
+static int npcm_eth_bb_set_mdio(struct bb_miiphy_bus *bus, int v)
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
+static int npcm_eth_bb_get_mdio(struct bb_miiphy_bus *bus, int *v)
+{
+	struct dw_eth_dev *priv = bus->priv;
+
+	*v = dm_gpio_get_value(&priv->mdio_gpio);
+
+	return 0;
+}
+
+static int npcm_eth_bb_set_mdc(struct bb_miiphy_bus *bus, int v)
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
+static int npcm_eth_bb_delay(struct bb_miiphy_bus *bus)
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
+		.mdio_active	= npcm_eth_bb_mdio_active,
+		.mdio_tristate	= npcm_eth_bb_mdio_tristate,
+		.set_mdio	= npcm_eth_bb_set_mdio,
+		.get_mdio	= npcm_eth_bb_get_mdio,
+		.set_mdc	= npcm_eth_bb_set_mdc,
+		.delay		= npcm_eth_bb_delay,
+		.priv		= NULL,
+	}
+};
+
+int bb_miiphy_buses_num = ARRAY_SIZE(bb_miiphy_buses);
+#endif
diff --git a/drivers/net/designware.h b/drivers/net/designware.h
index e47101ccaf..6b46bafeeb 100644
--- a/drivers/net/designware.h
+++ b/drivers/net/designware.h
@@ -229,11 +229,15 @@ struct dw_eth_dev {
 	u32 max_speed;
 	u32 tx_currdescnum;
 	u32 rx_currdescnum;
-
+#if  defined(CONFIG_BITBANGMII)
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
2.34.1

