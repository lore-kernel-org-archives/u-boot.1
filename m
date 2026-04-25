Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A100FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:25:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F4133844E3;
	Sat, 25 Apr 2026 20:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h6zCObvt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 114488448C; Sat, 25 Apr 2026 20:22:26 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71F8484480
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 20:22:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-68470763896so4761095eaf.1
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 11:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777141342; x=1777746142; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6bqIXZgDQ/UMUvXqSsKgirnDD5nDcus65tNaiPSkH9s=;
 b=h6zCObvtHf79p3KdmM6Vv6PsSCqazkQM+na8Qnl2rW/7MimmxKNRDW+DLSpbaLF9UC
 akciq3lHaUmQYhBQGFWshfVdMRXPn5h4fMiXi3siKDZOVs/Gs/enntz4LXhoYYEMdYlW
 LQpX05o2A5PO7YXcyJpm87kLYwnUySqd3LEk7NuYqY8dpSDyZ77BnOBsOVYYYjODU6jv
 Z+FH/a9xJ63ttEawYj/PHCzkD/GDJCPC1UYWzengFbcFmQooCPj66640dQuEYFi3iWW0
 drtBan9lQh/eNusmI7VcuuwPKEZQxsO0nTN+09fTLPYcf9XrYLf30N73BaN+jMriJy5K
 qo3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777141342; x=1777746142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6bqIXZgDQ/UMUvXqSsKgirnDD5nDcus65tNaiPSkH9s=;
 b=FsqZer3rLTUSL0SOntWc4zNJNRCbEOWDcqY5gx/Cbcs6FF/B7zmFocv15gFABZDj8R
 Eo3r1xw+Kz/SRVFoSHr9zdQf+2L163HeHWcce0ZTOXEao5O1pkRZrs3yaA7pJ82gVya1
 Rb4R//3GoWKG2hIC94ZhdnhayXwKt57hY4f4FJEGTMHZAhvzpjX+1ItFIXPOq7i3hCFb
 9zd3HV/VWtmeTjA7y+1Me9chiwPKEE4ePKEjLNol6Cu1c6TjGiQdZYUPEvmh1m4XtOsu
 wiS9M4DF52PHwutx4Vt6359jHGXxZodBLL2t0d2DyKePPIGndhEg4DHxCSmEacLA07aK
 CxaA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9oZDnIytBaFEPqpjO0DxMlOrLIjomVqlvN8ndyj7upakN2pavD0Ou8Z/2WCToWaBQnbp7dhuw=@lists.denx.de
X-Gm-Message-State: AOJu0YxTj1dLnRcwj845WHsSL/JzngBH9G3uedd0GAeeA02XIb+o3WgM
 SuRuH9WIW0+iHNDoOk/NbCujY7hTUuKk0b1VRWVCgTtq6Dpwkc/JLUfdC3Dsww==
X-Gm-Gg: AeBDievibZ9fS7e3G3Lu+1PmyGfPNFKgC0Rfj+go4tchsZtFxWFjPqsgQwOvWcC0d6n
 1R1ACFdTLd03VE/StTc3+cEJcdTHIIZG6gwzibEMt7TX10f8v6FSZoAO9Z+pp9Z1Yhl/chQprjp
 LNkorlaleXIfo43Ufhz52Fu9/hxdgIoKmnCpseKMal5HzVj9RE8I1qJ6pAZeTwzXEg2TFbqWFMy
 02lXUWZdS5MONObEF7qgmrfTAUGNki7UYJFGLhYj0YYGfr3gRpp8WHaZp2Go9Jb1pb8RCs/1Fiu
 c7uJHxUkYuFfCW3GHBmASqFap4U1V6W5ksEVW29Nh6lx+gLk/OGzCIEcebcmblmcSvxNbtF9AQB
 k7+F1/UKY16Uj12fFAeB3Ca2yZ/PLcW2pQFgBvOy2n21Db5Vncv2m801Y7r9rWj/ZFK4HN/hrMt
 NCn39E0eC0toNPPA2k/xISqDC05ifvGFhkwNj9BYjAuoFk+vG0i65pm3QXyJkxh3BqVDnQDmQSV
 ecQyDooQRGNqoagNR+MOAoBcCDpCNP3
X-Received: by 2002:a17:903:2acb:b0:2b4:5b9e:2f51 with SMTP id
 d9443c01a7336-2b5f9fb80demr392994735ad.34.1777104520101; 
 Sat, 25 Apr 2026 01:08:40 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cbaasm250916935ad.54.2026.04.25.01.08.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 01:08:39 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: trini@konsulko.com, jerome.forissier@arm.com, sumit.garg@kernel.org,
 marek.vasut+renesas@mailbox.org, vladimir.oltean@nxp.com
Cc: ericwouds@gmail.com, kabel@kernel.org, frank-w@public-files.de,
 daniel@makrotopia.org, ansuelsmth@gmail.com, mkorpershoek@kernel.org,
 skylake.huang@mediatek.com, lucien.jheng@airoha.com, u-boot@lists.denx.de,
 "Lucien.Jheng" <lucienzx159@gmail.com>
Subject: [PATCH v4 2/3] net: phy: airoha: air_en8811: use standard
 rx-polarity/tx-polarity properties
Date: Sat, 25 Apr 2026 16:06:48 +0800
Message-Id: <20260425080649.75688-3-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425080649.75688-1-lucienzx159@gmail.com>
References: <20260425080649.75688-1-lucienzx159@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 20:25:41 +0200
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
``` dts config
rx-polarity = <PHY_POL_INVERT>;
tx-polarity = <PHY_POL_NORMAL>;

```en8811h init log with new PHY common props:
U-Boot 2026.01-rc5--gd1a76e2e4a64-dirty (Apr 25 2026 - 15:37:25 +0800)
131072 bytes read in 57 ms (2.2 MiB/s)
mtk-eth ethernet@15100000: MD32 firmware version: 24112802
ofnode_read_bool: airoha,pnswap-rx: false
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
ofnode_read_bool: airoha,pnswap-tx: false
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

 drivers/net/phy/airoha/Kconfig      |  1 +
 drivers/net/phy/airoha/air_en8811.c | 60 +++++++++++++++++++++--------
 2 files changed, 45 insertions(+), 16 deletions(-)

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
index 0b974472732..32f06dd6dfa 100644
--- a/drivers/net/phy/airoha/air_en8811.c
+++ b/drivers/net/phy/airoha/air_en8811.c
@@ -23,6 +23,7 @@
 #include <linux/compat.h>
 #include <dm/device_compat.h>
 #include <u-boot/crc.h>
+#include <linux/phy/phy-common-props.h>

 /* MII Registers */
 #define AIR_AUX_CTRL_STATUS		0x1d
@@ -1046,11 +1047,50 @@ static int air_leds_init(struct phy_device *phydev, int num, u16 dur, int mode)
 	return 0;
 }

-static int en8811h_config(struct phy_device *phydev)
+static int en8811h_config_serdes_polarity(struct phy_device *phydev)
 {
-	struct en8811h_priv *priv = phydev->priv;
 	ofnode node = phy_get_ofnode(phydev);
+	unsigned int pol, default_pol;
 	u32 pbus_value = 0;
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
+				  phy_string_for_interface(phydev->interface),
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
+				  phy_string_for_interface(phydev->interface),
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
+static int en8811h_config(struct phy_device *phydev)
+{
+	struct en8811h_priv *priv = phydev->priv;
 	int ret = 0;

 	/* If restart happened in .probe(), no need to restart now */
@@ -1081,20 +1121,8 @@ static int en8811h_config(struct phy_device *phydev)
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

