Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A09CD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 16:27:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8142384901;
	Mon, 25 May 2026 18:27:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hiZ5A04p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6C49848F0; Mon, 25 May 2026 18:12:43 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C119848BB
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 18:12:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2ba6485d219so74443855ad.3
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 09:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779725559; x=1780330359; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6bqIXZgDQ/UMUvXqSsKgirnDD5nDcus65tNaiPSkH9s=;
 b=hiZ5A04pfbYgVDi1zmnA6LgoVgYneF1P0G06xxJIb/rOYstiywOK4OGRfn6MkwlSGp
 2952mdp1+BHk0IOJJyQwmx1cwD63JlEKLgnK5eELoxfsliSc2Kr4o9dJE7QpqWL7c3uG
 6OkPKteixSYPvGkhrHhcMuaA/FWCSqRzWDmYqDivh+CfcShlmqKLYMzRU2H6m7uQ80rF
 sb/u3jwanOkF9R2COSA3GrJtgF5K1DvmNiSf5MxAqj3euHHoN3lFRcu7fCGAFJ9xe/Qy
 NdSd45au5iHwD2bDRQfmLzakMf9flkrGmboN/wj5x+IoLyN7IDdKNVy9vZjCB4Dicazn
 /hqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779725559; x=1780330359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6bqIXZgDQ/UMUvXqSsKgirnDD5nDcus65tNaiPSkH9s=;
 b=SiHGYnRAVgxFcRyI7fwMYfAFGyVmlizSnl6GQbK/qRLK8idp+v6mg3gicWIki789uW
 8lerP2xF2AKDAe4eo0veXil+sHsH5doto7stUhngmYPQeEJqOv2kZl2HAAP9umGEQ6Hd
 4BbiGBhxryv0tRMeyHvQFuDfUHjAdjwrQ7mBEM6K8o8nj27OPDpc9+g1LhUtISVIuMWN
 rjVmaXUBaBiH4++WMam/tmmSBkdxQxvhY06YT5XyFZl6aiKEnjKL3M8djxCfm+HnRnqR
 fL322QCsGKc8Jj7857kPmy9XFWUvA36+QMo1rlCL2NYvSOzulaJu1U2q+/Y+CbBTQyn4
 E+zg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9jjU+PMUWOBt0x8284uTY1w2XRPZSC+SJYdsklhgHgPsWz5wlPk752IDm5uNtNiC0qj6F04ek=@lists.denx.de
X-Gm-Message-State: AOJu0YxZ9J2tJkyofjKI1tYKSlOUwKWbZ3gXSPzPyTIsmTrnXo5k3yXo
 e8fSq2N7wONPpQcOgLSPaeMnWF6j3cZ66LsVmo+RNHe1DyPNx8qGpyj6
X-Gm-Gg: Acq92OGZORHrqXD1dRLWwAp7mamdXA4490HyubXeVGu7E1AlVy/wBc59pUTJrNtZS71
 hYPtpmD63lfNlxVzitPFNm2oZBDs3kFEGd8wQ3iRQrSR8jq0n3XX/FS+equvDMRhTjIuKOnbDWl
 P0VYo1Kk906Fh5wEXFAkWymzQj0X3Flb/cb1d+vf3KVXC5VCFRA8ludgCQDcx9F9t6CFL9QCjeR
 xNdc0xNVSdEaKsnhGxJVL9CwKIh+CAnIET0pGvzzfEnGgzVdvkp/AXfN8PfUip/I01/T6Ueks5W
 v+qnehHWXgOd/byEJBVBaNUcPr3wmF9q/i+21Z59FcIe7sW3OeT9S/li15Gfe1EpEaGx9ltAu+G
 l29UkyiwmEkkKjD0oIFZPDsaW8e7wwhWy87wv3g3psls9WtVvvTEdd1N3EXqUvBMP1RSpLN58pD
 cwrzG4oKXtaLp1X+/XxMR9bB3Jz4tUSktiNZDH4ebPzMwJ2l8hLXD+h6zve3TCbDn02XPlIism3
 O+FRJxbMHJEB7xMSSWLHYroHnu1w4mZ
X-Received: by 2002:a17:902:cf06:b0:2b4:6080:d4d0 with SMTP id
 d9443c01a7336-2beb05e4154mr173496005ad.22.1779725559597; 
 Mon, 25 May 2026 09:12:39 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5924211sm92419305ad.84.2026.05.25.09.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 09:12:39 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: trini@konsulko.com, jerome.forissier@arm.com, sumit.garg@kernel.org,
 marek.vasut+renesas@mailbox.org, vladimir.oltean@nxp.com
Cc: ericwouds@gmail.com, kabel@kernel.org, frank-w@public-files.de,
 daniel@makrotopia.org, ansuelsmth@gmail.com, mkorpershoek@kernel.org,
 skylake.huang@mediatek.com, lucien.jheng@airoha.com, u-boot@lists.denx.de,
 "Lucien.Jheng" <lucienzx159@gmail.com>
Subject: [PATCH v5 2/3] net: phy: airoha: air_en8811: use standard
 rx-polarity/tx-polarity properties
Date: Tue, 26 May 2026 00:11:45 +0800
Message-Id: <20260525161146.114432-3-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260525161146.114432-1-lucienzx159@gmail.com>
References: <20260525161146.114432-1-lucienzx159@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 25 May 2026 18:27:06 +0200
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

