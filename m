Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCBDFC9EC8
	for <u-boot@archiver.kernel.org>; Sun,  8 Mar 2026 14:16:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50FAC83F14;
	Sun,  8 Mar 2026 15:16:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RqHQ+GYi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0254283952; Sun,  8 Mar 2026 15:12:52 +0100 (CET)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45B6B8063E
 for <u-boot@lists.denx.de>; Sun,  8 Mar 2026 15:12:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8296dabef74so4624623b3a.1
 for <u-boot@lists.denx.de>; Sun, 08 Mar 2026 07:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772979168; x=1773583968; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7HyHp8dY/D+MOypAl0WS6lTLTDFcxCQzG8d46lg/xuo=;
 b=RqHQ+GYiUDTtH0QdMRS501JyQUhJurXmhvliB/uHY5N7msU2VU8ELpScC7/4kavzhd
 9WnsWJ/szAMJlUmJ/Vx7ZpwZuvm0bbWQtkRoJ82iGHmhT2XfD1VDqOoTP7Tjwc7FlR1I
 xr5gow+NVfo8s28h7CslSjOvjP0GCQVwWVncb/Y7ugxybPAqJobJXq2cw+c4QJWGoKvB
 S3EqVXXLWSzvbETVKnHqa15/inboiJ5Mexh97W6Jy7OI4sG4TXHgVWS5N/zfrpzksyH1
 uUCr2SucMGFeWsXxyPmXPu2YX6uAoNIqvFEmIwame1ObKvspH1pYVEBuWGF7jWkfQM6U
 tspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772979168; x=1773583968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7HyHp8dY/D+MOypAl0WS6lTLTDFcxCQzG8d46lg/xuo=;
 b=ZVH7djdY+ZpxMYZYuuWHv5Zg/cRK1NNVQVRDfuoTHnBJ6owAWm+5JVU5g0Hv5/MehG
 motmOnEsvw/gVp8Mt1j1Wb5Ue4C9HSHq0t6Evps1G7DR+Fz62xvc/fC5SHSam01vHfhA
 3yVjG3tH291jG5KOPxSsCXtHTRkcUd1B2BB7BzL0mARB/1C6EqtNUtTPmZXsU7B2ZuK5
 4q44q4ynkaX/E1BApQldHLrukrmY6BNbhRS4uswIAR4ozxmOWYqm1MVwsub4O51e/xp5
 OcMOW099dTS1lBHXf43XfME0nSIOkvmIDCsm4BmUe8JbFzE2RWvJuUopnwnihZ3/BdRf
 zrMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1ZehFeiNrvVNBqVLMBIGcXmOth/HFeeBgxHN5T0IRKpQ+UaIBDgyvjYMXRk2Q3YpM5ZkrEWE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2Pxymq38rlqUcGibLZV/MP3SlP/pGs8eIZUkk+4lCQNftm4ki
 Inkxso48GO0EcVlQ0iUMiLgiC6ZcGyoxvsD1pSQ/zL+/hQ2GUYMqE1/k
X-Gm-Gg: ATEYQzyQ8B5KhgATjyec62XWyLaHtop5m0VS8BepANcqCAjAg7eWWGdo9QNkZCLeS00
 ImaxGxyR5Kjx8+XfRq3ZgNIZui/dRF1R81wqmU5qZ+2GY8PzY6+w6foUZlJV6Mv3aPFYsiY1uHb
 yxf4CM9vhMwIBOpazLHa3+3autAFMBG+p/4TrMnNe7oz8O7Cpc3jVNU5JTWqj9MyMjhvO4NjmPO
 eWjihee/g8FyMYGQ9EtxHnfZ6YgKbhLImEj2dMRzg6Qi5HRPfxGJtBqYaRCJpIOYXkb0tNH+f91
 psgg3zB1eeeg0cA6cc5CzjkECzXYxCALjtB7TpFPnnhnYZjhrsciMXbFN4cwulBJNBlRp5PXYwr
 4sw8nx497x5yxiRIeJWz0lMfHUkSkHojxdYP6tqOnSmD4MjqpgxZJvZFdvqgkpOjQaAcy7d34Pw
 +p1Ulp/BALs34AMumc9kN2Bu3eIbiJKW7dFfFe2E1URYmywBHJ4342Pma7LkH17jGW5PZ21OEfx
 IwPcTzMk+VsTepyXVSlCg==
X-Received: by 2002:a05:6a00:2d89:b0:829:8a1b:2bb3 with SMTP id
 d2e1a72fcca58-829a2d84ce6mr7488810b3a.22.1772979167666; 
 Sun, 08 Mar 2026 07:12:47 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-829a463a1adsm7273605b3a.11.2026.03.08.07.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2026 07:12:47 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: trini@konsulko.com, jerome.forissier@arm.com, sumit.garg@kernel.org,
 marek.vasut+renesas@mailbox.org
Cc: ericwouds@gmail.com, kabel@kernel.org, vladimir.oltean@nxp.com,
 frank-w@public-files.de, daniel@makrotopia.org, ansuelsmth@gmail.com,
 mkorpershoek@kernel.org, skylake.huang@mediatek.com, tommy.shih@airoha.com,
 lucien.jheng@airoha.com, u-boot@lists.denx.de,
 "Lucien.Jheng" <lucienzx159@gmail.com>
Subject: [PATCH v2 2/2] net: phy: air_en8811h: use standard
 rx-polarity/tx-polarity properties
Date: Sun,  8 Mar 2026 22:06:14 +0800
Message-Id: <20260308140614.50489-3-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260308140614.50489-1-lucienzx159@gmail.com>
References: <20260308140614.50489-1-lucienzx159@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 08 Mar 2026 15:16:22 +0100
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

Replace the proprietary airoha,pnswap-rx / airoha,pnswap-tx boolean
device tree properties with the standard rx-polarity and tx-polarity
properties defined in phy-common-props.yaml.

The driver first tries the standard properties; if absent it falls back
to the legacy ones for backward compatibility. The legacy properties are
marked deprecated in the bindings.

Link: https://git.kernel.org/linus/66d8a334b57e64e43810623b3d88f0ce9745270b
Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
---
The log below demonstrates the usage of the legacy and common PHY properties newly implemented in this version.
You could choose one of method to configure polarity of EN8811H.

1. EN8811H DTS using common PHY properties
	phy14: eth-phy@14 {
		compatible = "ethernet-phy-id03a2.a411";
		reg = <14>;
		//phy-supply = <&en8811_a>;
		pinctrl-names = "default";
		pinctrl-0 = <&en8811_pwr_a>;
		// airoha,pnswap-rx;
		rx-polarity = <PHY_POL_INVERT>;
		tx-polarity = <PHY_POL_NORMAL>;

		reset-gpios = <&pio 49 GPIO_ACTIVE_LOW>;
		reset-assert-us = <10000>;
		reset-deassert-us = <20000>;
	};

UBoot log:
mtk-eth ethernet@15100000: MD32 firmware version: 24112802
phy_get_polarity_for_mode: querying 'rx-polarity' for mode '2500base-x' (supported=0x3, default=0)
ofnode_get_u32_prop_for_name: looking up '2500base-x' in props='rx-polarity' names='rx-polarity-names' default=0
ofnode_read_prop: rx-polarity: ofnode_count_u32_prop: property 'rx-polarity' has 4 bytes (1 elements)
ofnode_get_u32_prop_for_name: 'rx-polarity' has 1 elements, 'rx-polarity-names' has -1 entries
ofnode_get_u32_prop_for_name: '2500base-x' not found in 'rx-polarity-names', trying 'default'
ofnode_get_u32_prop_for_name: 'default' entry not found in 'rx-polarity-names'
ofnode_get_u32_prop_for_name: single-element 'rx-polarity', reading directly
ofnode_read_u32_index: rx-polarity: 0x1 (1)
ofnode_get_u32_prop_for_name: resolved value 1 for name '2500base-x' from 'rx-polarity'
phy_get_polarity_for_mode: 'rx-polarity' for mode '2500base-x' = 1
mtk-eth ethernet@15100000: EN8811H: RX polarity = inverted
phy_get_polarity_for_mode: querying 'tx-polarity' for mode '2500base-x' (supported=0x3, default=0)
ofnode_get_u32_prop_for_name: looking up '2500base-x' in props='tx-polarity' names='tx-polarity-names' default=0
ofnode_read_prop: tx-polarity: ofnode_count_u32_prop: property 'tx-polarity' has 4 bytes (1 elements)
ofnode_get_u32_prop_for_name: 'tx-polarity' has 1 elements, 'tx-polarity-names' has -1 entries
ofnode_get_u32_prop_for_name: '2500base-x' not found in 'tx-polarity-names', trying 'default'
ofnode_get_u32_prop_for_name: 'default' entry not found in 'tx-polarity-names'
ofnode_get_u32_prop_for_name: single-element 'tx-polarity', reading directly
ofnode_read_u32_index: tx-polarity: 0x0 (0)
ofnode_get_u32_prop_for_name: resolved value 0 for name '2500base-x' from 'tx-polarity'
phy_get_polarity_for_mode: 'tx-polarity' for mode '2500base-x' = 0
mtk-eth ethernet@15100000: EN8811H: TX polarity = normal
eth0: ethernet@15100000
Hit any key to stop autoboot: 0
BPI-R3M>

2. EN8811H DTS using legacy configuration
	phy14: eth-phy@14 {
		compatible = "ethernet-phy-id03a2.a411";
		reg = <14>;
		//phy-supply = <&en8811_a>;
		pinctrl-names = "default";
		pinctrl-0 = <&en8811_pwr_a>;
		airoha,pnswap-rx;

		reset-gpios = <&pio 49 GPIO_ACTIVE_LOW>;
		reset-assert-us = <10000>;
		reset-deassert-us = <20000>;
	};

UBoot log:
mtk-eth ethernet@15100000: MD32 firmware version: 24112802
phy_get_polarity_for_mode: querying 'rx-polarity' for mode '2500base-x' (supported=0x3, default=0)
ofnode_get_u32_prop_for_name: looking up '2500base-x' in props='rx-polarity' names='rx-polarity-names' default=0
ofnode_read_prop: rx-polarity: <not found>
ofnode_count_u32_prop: property 'rx-polarity' not found (err=-22)
ofnode_get_u32_prop_for_name: 'rx-polarity' is absent, returning -ENOENT
phy_get_polarity_for_mode: 'rx-polarity' lookup failed for mode '2500base-x' (err=-2)
mtk-eth ethernet@15100000: EN8811H: Legacy RX polarity
ofnode_read_bool: airoha,pnswap-rx: true
phy_get_polarity_for_mode: querying 'tx-polarity' for mode '2500base-x' (supported=0x3, default=0)
ofnode_get_u32_prop_for_name: looking up '2500base-x' in props='tx-polarity' names='tx-polarity-names' default=0
ofnode_read_prop: tx-polarity: <not found>
ofnode_count_u32_prop: property 'tx-polarity' not found (err=-22)
ofnode_get_u32_prop_for_name: 'tx-polarity' is absent, returning -ENOENT
phy_get_polarity_for_mode: 'tx-polarity' lookup failed for mode '2500base-x' (err=-2)
mtk-eth ethernet@15100000: EN8811H: Legacy TX polarity
ofnode_read_bool: airoha,pnswap-tx: false
eth0: ethernet@15100000
Hit any key to stop autoboot: 0
BPI-R3M>

 drivers/net/phy/airoha/Kconfig      |  1 +
 drivers/net/phy/airoha/air_en8811.c | 91 ++++++++++++++++++++++++-----
 2 files changed, 77 insertions(+), 15 deletions(-)

diff --git a/drivers/net/phy/airoha/Kconfig b/drivers/net/phy/airoha/Kconfig
index 999564e4848..efe3c0f485b 100644
--- a/drivers/net/phy/airoha/Kconfig
+++ b/drivers/net/phy/airoha/Kconfig
@@ -6,6 +6,7 @@ config PHY_AIROHA_EN8811
 	bool "Airoha Ethernet EN8811H support"
 	depends on PHY_AIROHA
 	select FW_LOADER
+	select PHY_COMMON_PROPS
 	help
 	  AIROHA EN8811H supported.

diff --git a/drivers/net/phy/airoha/air_en8811.c b/drivers/net/phy/airoha/air_en8811.c
index 1a628ede82b..0ec11ba5231 100644
--- a/drivers/net/phy/airoha/air_en8811.c
+++ b/drivers/net/phy/airoha/air_en8811.c
@@ -23,6 +23,7 @@
 #include <linux/compat.h>
 #include <dm/device_compat.h>
 #include <u-boot/crc.h>
+#include <linux/phy/phy-common-props.h>

 #define EN8811H_PHY_ID		0x03a2a411

@@ -660,11 +661,82 @@ static int air_leds_init(struct phy_device *phydev, int num, u16 dur, int mode)
 	return 0;
 }

-static int en8811h_config(struct phy_device *phydev)
+static int en8811h_config_polarity(struct phy_device *phydev)
 {
-	struct en8811h_priv *priv = phydev->priv;
 	ofnode node = phy_get_ofnode(phydev);
+	unsigned int rx_pol, tx_pol;
 	u32 pbus_value = 0;
+	int ret;
+	bool use_legacy = false;
+
+	if (!ofnode_valid(node))
+		return 0;
+
+	/* Try standard rx-polarity property first */
+	ret = phy_get_manual_rx_polarity(node,
+					 phy_interface_strings[phydev->interface],
+					 &rx_pol);
+	if (ret == 0) {
+		dev_info(phydev->dev, "EN8811H: RX polarity = %s\n",
+			 rx_pol == PHY_POL_INVERT ? "inverted" : "normal");
+		if (rx_pol == PHY_POL_INVERT)
+			pbus_value |= EN8811H_POLARITY_RX_REVERSE;
+		else
+			pbus_value &= ~EN8811H_POLARITY_RX_REVERSE;
+	} else if (ret == -ENOENT) {
+		/* Fall back to legacy airoha,pnswap-rx property */
+		use_legacy = true;
+		dev_info(phydev->dev, "EN8811H: Legacy RX polarity\n");
+
+		if (ofnode_read_bool(node, "airoha,pnswap-rx"))
+			pbus_value |= EN8811H_POLARITY_RX_REVERSE;
+		else
+			pbus_value &= ~EN8811H_POLARITY_RX_REVERSE;
+	} else {
+		dev_err(phydev->dev, "EN8811H: Error reading rx-polarity: %d\n", ret);
+		return ret;
+	}
+
+	/* Try standard tx-polarity property first */
+	ret = phy_get_manual_tx_polarity(node,
+					 phy_interface_strings[phydev->interface],
+					 &tx_pol);
+	if (ret == 0) {
+		dev_info(phydev->dev, "EN8811H: TX polarity = %s\n",
+			 tx_pol == PHY_POL_INVERT ? "inverted" : "normal");
+		if (tx_pol == PHY_POL_INVERT)
+			pbus_value &= ~EN8811H_POLARITY_TX_NORMAL;
+		else
+			pbus_value |= EN8811H_POLARITY_TX_NORMAL;
+	} else if (ret == -ENOENT) {
+		/* Fall back to legacy airoha,pnswap-tx property */
+		if (!use_legacy)
+			dev_err(phydev->dev, "EN8811H: Mixing standard and legacy polarity properties\n");
+
+		dev_info(phydev->dev, "EN8811H: Legacy TX polarity\n");
+
+		if (ofnode_read_bool(node, "airoha,pnswap-tx"))
+			pbus_value &= ~EN8811H_POLARITY_TX_NORMAL;
+		else
+			pbus_value |= EN8811H_POLARITY_TX_NORMAL;
+	} else {
+		dev_err(phydev->dev, "EN8811H: Error reading tx-polarity: %d\n", ret);
+		return ret;
+	}
+
+	/* Apply polarity configuration to hardware */
+	ret = air_buckpbus_reg_modify(phydev, EN8811H_POLARITY,
+				      EN8811H_POLARITY_RX_REVERSE |
+				      EN8811H_POLARITY_TX_NORMAL, pbus_value);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int en8811h_config(struct phy_device *phydev)
+{
+	struct en8811h_priv *priv = phydev->priv;
 	int ret = 0;

 	/* If restart happened in .probe(), no need to restart now */
@@ -695,19 +767,8 @@ static int en8811h_config(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;

-	/* Serdes polarity */
-	pbus_value = 0;
-	if (ofnode_read_bool(node, "airoha,pnswap-rx"))
-		pbus_value |=  EN8811H_POLARITY_RX_REVERSE;
-	else
-		pbus_value &= ~EN8811H_POLARITY_RX_REVERSE;
-	if (ofnode_read_bool(node, "airoha,pnswap-tx"))
-		pbus_value &= ~EN8811H_POLARITY_TX_NORMAL;
-	else
-		pbus_value |=  EN8811H_POLARITY_TX_NORMAL;
-	ret = air_buckpbus_reg_modify(phydev, EN8811H_POLARITY,
-				      EN8811H_POLARITY_RX_REVERSE |
-				      EN8811H_POLARITY_TX_NORMAL, pbus_value);
+	/* Configure Serdes polarity from device tree */
+	ret = en8811h_config_polarity(phydev);
 	if (ret < 0)
 		return ret;

--
2.34.1

