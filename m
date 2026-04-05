Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A32D3E9D800
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 20:17:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FC1A8407E;
	Sun,  5 Apr 2026 22:17:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oU8w4+BY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB51D8394E; Sun,  5 Apr 2026 16:51:04 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6C488341A
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 16:51:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-35d99bae2ebso2856845a91.3
 for <u-boot@lists.denx.de>; Sun, 05 Apr 2026 07:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775400659; x=1776005459; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7WZN/Hkcq7MSmV5F0vael9It/JztFoUAXL5o6yMeQQE=;
 b=oU8w4+BY0be5HPdvEeAduyJe9DIyaY3FH7P/812qTZqF0PF+/oUh7ksDwGlSKcmA+T
 LWpldYo9+/1d6gMW3EzRpzxzNYBkc+C0QuNsWRcSXHNjFry5qYknaS5Z2YfOvZGQiP2c
 EU1yfVmZCUV9yyS8Rcjn7NIwqW0UDe+hXPeUjDjI/HP9p6T3EMeGRq+QKo4rr+/eucpE
 GIeYR4hypQsRtUuUhthZQECSnYGbFJt5H0qCfb45E/zRYXbfR+CtBywHbORESoTQ+7Wc
 HC7WHJPtrvjHeOpLT0sBtfBiHLr9s3FwIWnLDWoBSZY+3AsfoGdsW8DYyRpIAQeLGDnk
 lggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775400659; x=1776005459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7WZN/Hkcq7MSmV5F0vael9It/JztFoUAXL5o6yMeQQE=;
 b=C42IbAmELSXBlwCkCVW0bW4LuGa1wTtC8psVrDRJsOqLL3UCq52QIdHYSW68eRnbN8
 3sSEKaPTxdn4vOhD84ic/xaFAPTcIcTwY4VkzEID4Ok4R8ToStaUp1pkUFg0eiX3V48P
 Wxz3/Fw8es91dZEBQbdDhkASB3DjDnree8gkq8avJukj+i996SxDDA2fzVAS3tC7YeoU
 0LVnCYhM6DMhNCkBxwWaw2ckzGXI3GhmOKpu5sr0ogyCkbxaOax2zzr+gG8RFTIqs3fP
 cjI4eCWaIuT8GLg9jAAms7/EgnFGgIZH36tX7qg9/LwOv8AYQ7I8EEMDW/JraW/tl9ly
 0LiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpfg7zbTKWE6laTibK1OkQYrBM9O/9+hGdiEStZ0/yqocuPy8TZrcbpoY95VYzQ0klPatXoYM=@lists.denx.de
X-Gm-Message-State: AOJu0YzXGfjApO4qgDeKl/zhG/FEuHg+Ik1zC9VsWXk4NquC4X63S0T8
 O3dP0H0jnxz8LjrNaFV5ZMkfddyAJdCfUoLZMEvZ+T2ysidPfBGo359s
X-Gm-Gg: AeBDieuFsN7vBuAKSVpZh0Wvad1tmFlAAZyX36oLq+B/nEz8BeNBac5Mg+/cXCWEq8f
 aJiLmQ1LxWqWHjCJCGpglvGx74Uov1hoHgtuM1Mxu6JkL6CrMqiUy3EdHesEbiUU8ht5OR7ZbfQ
 HB85+qB6h3TalfAgj4u6PXCdFEaFGXqw29CvEtJPrFR0WakqPDsLWA7/ZR64+F63G7B8XAXr4ZK
 486++513yxyZtqTN5j3tM6ASJHpBzAMRDZwPwe5T/z4EG2wdjiP29XGO9PHEQ6VpmfzCPhtJfJe
 pAcHMG+YPD4CPhcns6R7U6bVuAhEtH3w/f4dkSzUlsUDkKNdvVNJTiYF+5JiEGRr3yxSbkQdGzJ
 9+QujiWKP7ohXkSwziqPV+dWGsKe7cmiHsSGGBPp8g04lrz/yzn/HccxPOaM+7koswKdnISnZDq
 Ujtt1Z8Wb4fhl2PmEYu96A1D+N6ukisuFHvm1HVgvUh6pawF8obbFfzVuItGpAYwPe6pIqxNh8Y
 Vzvp4JIGnHAYIraYvq19Q==
X-Received: by 2002:a17:90b:1dcc:b0:35b:929f:7e92 with SMTP id
 98e67ed59e1d1-35de68ce5d0mr8917628a91.18.1775400659155; 
 Sun, 05 Apr 2026 07:50:59 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe959358sm15333261a91.13.2026.04.05.07.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 07:50:58 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: trini@konsulko.com, jerome.forissier@arm.com, sumit.garg@kernel.org,
 marek.vasut+renesas@mailbox.org, vladimir.oltean@nxp.com
Cc: ericwouds@gmail.com, kabel@kernel.org, frank-w@public-files.de,
 daniel@makrotopia.org, ansuelsmth@gmail.com, mkorpershoek@kernel.org,
 skylake.huang@mediatek.com, lucien.jheng@airoha.com, u-boot@lists.denx.de,
 "Lucien.Jheng" <lucienzx159@gmail.com>
Subject: [PATCH v3 2/4] net: phy: air_en8811h: use standard
 rx-polarity/tx-polarity properties
Date: Sun,  5 Apr 2026 22:49:42 +0800
Message-Id: <20260405144944.41074-3-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260405144944.41074-1-lucienzx159@gmail.com>
References: <20260405144944.41074-1-lucienzx159@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 05 Apr 2026 22:17:12 +0200
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

Backward compatibility is maintained by reading the legacy boolean
properties first and passing them as the default_pol argument to
phy_get_rx/tx_polarity(). If the standard properties are absent the
legacy values are used transparently, so existing device trees remain
functional without modification.

Link: https://git.kernel.org/linus/66d8a334b57e64e43810623b3d88f0ce9745270b
Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
---
 drivers/net/phy/airoha/Kconfig      |  1 +
 drivers/net/phy/airoha/air_en8811.c | 58 ++++++++++++++++++++++-------
 2 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/drivers/net/phy/airoha/Kconfig b/drivers/net/phy/airoha/Kconfig
index da8747939e3..4139df343ad 100644
--- a/drivers/net/phy/airoha/Kconfig
+++ b/drivers/net/phy/airoha/Kconfig
@@ -7,6 +7,7 @@ config PHY_AIROHA_EN8811
 	depends on PHY_AIROHA
 	depends on SUPPORTS_FW_LOADER
 	select FW_LOADER
+	select PHY_COMMON_PROPS
 	help
 	  AIROHA EN8811H supported.
 	  AIROHA AN8811HB supported.
diff --git a/drivers/net/phy/airoha/air_en8811.c b/drivers/net/phy/airoha/air_en8811.c
index 0b974472732..0a56ee0bdf3 100644
--- a/drivers/net/phy/airoha/air_en8811.c
+++ b/drivers/net/phy/airoha/air_en8811.c
@@ -23,6 +23,7 @@
 #include <linux/compat.h>
 #include <dm/device_compat.h>
 #include <u-boot/crc.h>
+#include <linux/phy/phy-common-props.h>
 
 /* MII Registers */
 #define AIR_AUX_CTRL_STATUS		0x1d
@@ -1046,6 +1047,47 @@ static int air_leds_init(struct phy_device *phydev, int num, u16 dur, int mode)
 	return 0;
 }
 
+static int en8811h_config_serdes_polarity(struct phy_device *phydev)
+{
+	ofnode node = phy_get_ofnode(phydev);
+	unsigned int pol, default_pol;
+	u32 pbus_value = 0;
+	int ret;
+
+	if (!ofnode_valid(node))
+		return 0;
+
+	default_pol = PHY_POL_NORMAL;
+	if (ofnode_read_bool(node, "airoha,pnswap-rx"))
+		default_pol = PHY_POL_INVERT;
+
+	ret = phy_get_rx_polarity(node,
+				  phy_interface_strings[phydev->interface],
+				  BIT(PHY_POL_NORMAL) | BIT(PHY_POL_INVERT),
+				  default_pol, &pol);
+	if (ret)
+		return ret;
+	if (pol == PHY_POL_INVERT)
+		pbus_value |= EN8811H_POLARITY_RX_REVERSE;
+
+	default_pol = PHY_POL_NORMAL;
+	if (ofnode_read_bool(node, "airoha,pnswap-tx"))
+		default_pol = PHY_POL_INVERT;
+
+	ret = phy_get_tx_polarity(node,
+				  phy_interface_strings[phydev->interface],
+				  BIT(PHY_POL_NORMAL) | BIT(PHY_POL_INVERT),
+				  default_pol, &pol);
+	if (ret)
+		return ret;
+	if (pol == PHY_POL_NORMAL)
+		pbus_value |= EN8811H_POLARITY_TX_NORMAL;
+
+	return air_buckpbus_reg_modify(phydev, EN8811H_POLARITY,
+				       EN8811H_POLARITY_RX_REVERSE |
+				       EN8811H_POLARITY_TX_NORMAL, pbus_value);
+}
+
 static int en8811h_config(struct phy_device *phydev)
 {
 	struct en8811h_priv *priv = phydev->priv;
@@ -1081,20 +1123,8 @@ static int en8811h_config(struct phy_device *phydev)
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
-				      EN8811H_POLARITY_TX_NORMAL,
-				      pbus_value);
+	/* Configure Serdes polarity from device tree */
+	ret = en8811h_config_serdes_polarity(phydev);
 	if (ret < 0)
 		return ret;
 
-- 
2.34.1

