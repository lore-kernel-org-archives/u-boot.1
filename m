Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26CBC61DFB
	for <u-boot@archiver.kernel.org>; Sat, 21 Feb 2026 17:33:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C3D383E36;
	Sat, 21 Feb 2026 18:32:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZOhz+ohK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90A4F83AC5; Sat, 21 Feb 2026 17:32:38 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06DC1801BE
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 17:32:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a7a23f5915so17616445ad.2
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 08:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771691554; x=1772296354; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=veBAsCJPz3IbOwtOO0WTGe2YqkAR8c3b3Kl6W4G+yqw=;
 b=ZOhz+ohKjQsoGJsdGxiyqTn5AujRKLIDOVbBLOx39fXlVTHnXYtqBUQHtZydxrjrzG
 9YSk/WqJ3S80rcQ0n8rLlTWy3og7/k7vSX0iH0tnrcDYM0I6hSK4TXqBs76uN8M1SW7h
 O42x2XkRbcGe2WiVA7SwZPKRYknpKKyILMQ2dYyILLFBeFO0yTZ+huijGFkDDn5GBV56
 d3SHB28kPp1Pry97hPaesKne59L8J/LNe8BMz9fyiXkJiVb2YI1iIm5BqoX1o3fXjed7
 XJCyqIZM4R2ka+OubUWSxQGgVU4WA0zb+p5XU9HZ/PoOJBuEVoYl85DbmUWFH0dsVWEJ
 SngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771691554; x=1772296354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=veBAsCJPz3IbOwtOO0WTGe2YqkAR8c3b3Kl6W4G+yqw=;
 b=SF6Q7yvosEqRGNoGSlRxWgI3t5o6Lwsa9bRji8PGiklr0uuQSReZgOHWXSjxJmoDg7
 QRHz/GtEDfNDk2rcoampCtvhDtIal9322aUUo+/NpKyG4Ab27nOOUqljP90B8Un8mbRx
 UYW+rH4wRCpsz3X6t0QXWr+68M+LcuhYmyLkzXHId1Pfx2UxAWh0KxSQ7hMo1T1ThVCh
 8HcrVOT3yuA+20x60Nvep2CaHp5hIs9rgq6eEMXOVYHa/pbg+7AHSSNdk7NcK7GiC2Ao
 PZA2Gi7gNKduYaLqf1dhmZKXNJqREgQz9LN77Jr0WHFT4DBCqjWbDGCth4IHszU5HxWh
 x0lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaaFx8jKHJA1EKZG+63NsN39iV3LE/h5hGibIExNy17GN2DOUnXOkqcBn8ten5ey3vBYmq9zc=@lists.denx.de
X-Gm-Message-State: AOJu0YxJDoQkf8EBJrNQ2+5GOYbYbax5uUyTYQKQFE+NOmaDhjN1qWXJ
 OeHjWTskJZmM97f92PdYKmPVzU/YaV3dj6QjHbY7wycl4QS07JOM7tKJ
X-Gm-Gg: AZuq6aJT3XygeDuMKjIWH5Q4st68MA9XSzXzaDkTo8K3hLACF+FkaxGjIcJDYGFhQjQ
 HCAbnpgxPd+/50GF+nYfoVR2bOMAkmHJbnKhEP1xTR76X7/kKAzQMRrFQuUtShFMuAt4ns0oGKk
 v+6CFSzVat2HIFcicnJeTFUlBgFJGvwJIvLE6KwSeYMl+WMZLkoE0BsALoabwBBOO39OMkDb5lC
 hqbhIOfyPggFTSC4hy7Hk9Klc8Lk3E3rkW1uxdrJHFoIaqNQskknfllllYmb8zu+Mgo7DhqXodW
 SrxMo3AqY0SfFye5doQo8Wr0hU1lE9uQQFTg4XdiHJbacqXea2chYovKuVMG9wb1pUOmPQBq1lB
 rq3/FDayvzDKu43aH9vIyo3NSDH7LNjdCcG39rmJGX1/bQZ8uYFS+/+0DUDmhC5SUnOBvfDQMh3
 qJaEL2IwkRhoDHsmn4NIQ7mPBzhZ39rYkGNPBNhNOFlwThkPeeVFPuaeN1zI3iAj9Cex4WJXHvI
 YyEBxbM8qBlXkpxfLcxog==
X-Received: by 2002:a17:903:4b30:b0:2aa:de6a:8b29 with SMTP id
 d9443c01a7336-2ad74418ba5mr30311195ad.4.1771691554401; 
 Sat, 21 Feb 2026 08:32:34 -0800 (PST)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad7500e062sm36868365ad.48.2026.02.21.08.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Feb 2026 08:32:34 -0800 (PST)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: trini@konsulko.com, jerome.forissier@arm.com, sumit.garg@kernel.org,
 marek.vasut+renesas@mailbox.org
Cc: ericwouds@gmail.com, kabel@kernel.org, vladimir.oltean@nxp.com,
 frank-w@public-files.de, daniel@makrotopia.org, ansuelsmth@gmail.com,
 mkorpershoek@kernel.org, skylake.huang@mediatek.com, u-boot@lists.denx.de,
 "Lucien.Jheng" <lucienzx159@gmail.com>
Subject: [PATCH v1 4/4] net: phy: air_en8811h: use standard
 rx-polarity/tx-polarity properties
Date: Sun, 22 Feb 2026 00:31:14 +0800
Message-Id: <20260221163114.87553-5-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260221163114.87553-1-lucienzx159@gmail.com>
References: <20260221163114.87553-1-lucienzx159@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Feb 2026 18:32:49 +0100
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

