Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499D510A1E7E
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 11:30:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5334A83FA3;
	Thu, 26 Mar 2026 12:29:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="HnbCPo4Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA01D840B5; Thu, 26 Mar 2026 12:29:40 +0100 (CET)
Received: from mail-dl1-x122c.google.com (mail-dl1-x122c.google.com
 [IPv6:2607:f8b0:4864:20::122c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CAD481E18
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 12:29:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-dl1-x122c.google.com with SMTP id
 a92af1059eb24-126ea4e9694so2002375c88.1
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 04:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1774524576; x=1775129376; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zF3BdZHRpB/pHfQJonf9bVhdkO7Uo7oZqm7EXSJmXMw=;
 b=HnbCPo4Z0ljQQpyv500utAY/vNnzptRokohTzJXSfG5rsd0/vFuzcJavpKnyILTksq
 M2sgU8/Ah9C1AevmyCfmxoEascyi49m3OoBnx7f4f1RMZ2S1JBeiV2q23LiIQ4iTfprN
 yF8EO+uo+h4A/S0H7Zhnak2LaHUM05ebjYgZhh0PFg1LHMePm8xgjlCQ1Se69kDGvqXd
 b+3VIZ1C6ttEkRbGiDNVZRcQvNyIjL2J9ITyMp/Y9Jn11VJjeRY4iPbotWQoH+ekgPHm
 u8BVKekp0Bc+4W9obcKWoNhzRWUBAwDbo7GzfLRGsiUtGiCmU3oif/T1lTHpV6T17Aha
 CG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774524576; x=1775129376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zF3BdZHRpB/pHfQJonf9bVhdkO7Uo7oZqm7EXSJmXMw=;
 b=DLUL4doxSf87l/r4cycWqwUa/OwS6hVHLjppNoNFCvN4eKwLcbvO3qZL+AweZLk9eM
 XSKt+AtPfih/x7N0s+4JEtiM9/UBFE4GL0f6RNW4OQcGif7HcQHs/nfyuW0pRlQIPgac
 hJhefoNZV2yB0XwfbaYIjgsgPKBhwR0Ceo2NfsSSqpzRUtrdYMslMTvYwMYY1IhK9k7N
 46LlNrm/YYDraVfie5/j+l/aXdtNGt5s/yipqf0TP72bMaVHXrwMitjliNJXE2HD3ggt
 Hndt0F9ud+KqncQKE0KJZzBBE4CmcixsenFAbAQ25lIl6AF+Ru0xB9/rFuIYHVqWlJ6y
 7/xQ==
X-Gm-Message-State: AOJu0YwNUKbza3bm6Cuyqy3du1QY6MIMOGRGo5nmrwiGOypYcMmUT14h
 JMJbnrVshyOHAOPP82039Tplv94o0ryIhGtxWhuaQh2wi6iMmFAAsuZUJlDMdSIgjnBVLwcCcbC
 nB8XnyHtl4Vej6N4VwaIvX7J8wEM85Sq+KjVz3kqxybIF/kVs3Q95uE5/eKx76uqT0QVE4ROVwY
 6oxNiHkK82kuM/5FCa2l+86NaPLYmlGyss74vfr/i/I74=
X-Gm-Gg: ATEYQzwWV6KsHKS9TYbZS7rKqhXBXjNh/2RHgstj4e+yT9P+yl/bRRYA6KIDbKNx6Zx
 evaCxdheAjHzj9/nKStP6DfLX1dRcK9ULm6JlEQx3BRXJ7Rc61WzlNT7rSNZ36MCNH3mOmOD2V2
 UvdxogxgZQAyUDfvz9wLSYhXM5u0cKX03SVDj66UY4Ht9rw5jfSjlV1yzS0OsJIUfb5r2v2E+DQ
 AQNjTTvpARI/yIeJvVsZrUZFwDxfDPtXq7wP6NONMDteW9L2KWCGjQCskbd2UohhLqHXVehJVrH
 XEJWtLeJGJwfrK1UL8d3X1nqGnnrAzE36Qs/IIp6vIqdlh8Z95TWQrOStJ8yDvw2qhkMZDdyDQl
 5lOFSJ344q7m0XlF3Ydao7Ikl3vqW3wg4A6Xp5DBbe+DeZsqSQ5qYhsUFEpg4Dhh6GBCSPKiPJ2
 l9uUD4bpM1KEWkI6Eoree9cXPlMGw37EeYI7HHu/1SMTfoFj/EUpZDyLQM6CNTJUd6zMa2r8/fk
 vufwz0TVMVTOJIm2c/G5Bulwy9YLxqy8mGwvPeE
X-Received: by 2002:a05:7022:fa09:b0:11b:b179:6e17 with SMTP id
 a92af1059eb24-12a96eeaf79mr3631130c88.34.1774524575864; 
 Thu, 26 Mar 2026 04:29:35 -0700 (PDT)
Received: from fedora (cpe-109-60-83-68.zg3.cable.xnet.hr. [109.60.83.68])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-12aa7624247sm3729221c88.11.2026.03.26.04.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 04:29:34 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: u-boot@lists.denx.de, trini@konsulko.com, lukma@denx.de, hs@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, gregory.clement@bootlin.com,
 lars.povlsen@microchip.com, horatiu.vultur@microchip.com,
 jerome.forissier@arm.com, marex@denx.de, daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 13/14] net: phy: add Microchip LAN8841 support
Date: Thu, 26 Mar 2026 12:26:54 +0100
Message-ID: <20260326112830.313874-13-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326112830.313874-1-robert.marko@sartura.hr>
References: <20260326112830.313874-1-robert.marko@sartura.hr>
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

Add driver for the Microchip LAN8841 PHY.

It provides fixes for erratas, as well as support for enabling the required
RGMII delays based on the PHY mode.

It is based on the upstream Linux driver.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/net/phy/Kconfig     |   3 +
 drivers/net/phy/Makefile    |   1 +
 drivers/net/phy/microchip.c | 185 ++++++++++++++++++++++++++++++++++++
 3 files changed, 189 insertions(+)
 create mode 100644 drivers/net/phy/microchip.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 709f1c91eb2..3eaf9d7495f 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -231,6 +231,9 @@ config PHY_MICREL_KSZ8XXX
 
 endif # PHY_MICREL
 
+config PHY_MICROCHIP
+	bool "Microchip Ethernet PHYs support"
+
 config PHY_MOTORCOMM
 	tristate "Motorcomm PHYs"
 	help
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 83520de7f1f..04e9d61a3c2 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -25,6 +25,7 @@ obj-y += mediatek/
 obj-y += airoha/
 obj-$(CONFIG_PHY_MICREL_KSZ8XXX) += micrel_ksz8xxx.o
 obj-$(CONFIG_PHY_MICREL_KSZ90X1) += micrel_ksz90x1.o
+obj-$(CONFIG_PHY_MICROCHIP) += microchip.o
 obj-$(CONFIG_PHY_MESON_GXL) += meson-gxl.o
 obj-$(CONFIG_PHY_MOTORCOMM) += motorcomm.o
 obj-$(CONFIG_PHY_NATSEMI) += natsemi.o
diff --git a/drivers/net/phy/microchip.c b/drivers/net/phy/microchip.c
new file mode 100644
index 00000000000..bc54311ab72
--- /dev/null
+++ b/drivers/net/phy/microchip.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <phy.h>
+#include <linux/bitops.h>
+
+#define PHY_ID_MATCH_MODEL_MASK 	GENMASK(31, 4)
+#define PHY_ID_LAN8841			0x00221650
+
+#define LAN8841_MMD_COMMON_CTRL_REG	2
+#define LAN8841_RXC_DLL_CTRL		76
+#define LAN8841_TXC_DLL_CTRL		77
+#define LAN8841_DLL_ENABLE_DELAY	0
+
+#define LAN8841_MMD_TIMER_REG			0
+#define LAN8841_MMD0_REGISTER_17		17
+#define LAN8841_MMD0_REGISTER_17_DROP_OPT(x)	((x) & 0x3)
+#define LAN8841_MMD0_REGISTER_17_XMIT_TOG_TX_DIS	BIT(3)
+#define LAN8841_OPERATION_MODE_STRAP_OVERRIDE_LOW_REG	2
+#define LAN8841_OPERATION_MODE_STRAP_OVERRIDE_LOW_REG_MAGJACK	BIT(14)
+#define LAN8841_MMD_ANALOG_REG			28
+#define LAN8841_ANALOG_CONTROL_1		1
+#define LAN8841_ANALOG_CONTROL_1_PLL_TRIM(x)	(((x) & 0x3) << 5)
+#define LAN8841_ANALOG_CONTROL_10		13
+#define LAN8841_ANALOG_CONTROL_10_PLL_DIV(x)	((x) & 0x3)
+#define LAN8841_ANALOG_CONTROL_11		14
+#define LAN8841_ANALOG_CONTROL_11_LDO_REF(x)	(((x) & 0x7) << 12)
+#define LAN8841_TX_LOW_I_CH_C_D_POWER_MANAGMENT	69
+#define LAN8841_TX_LOW_I_CH_C_D_POWER_MANAGMENT_VAL 0xbffc
+#define LAN8841_BTRX_POWER_DOWN			70
+#define LAN8841_BTRX_POWER_DOWN_QBIAS_CH_A	BIT(0)
+#define LAN8841_BTRX_POWER_DOWN_BTRX_CH_A	BIT(1)
+#define LAN8841_BTRX_POWER_DOWN_QBIAS_CH_B	BIT(2)
+#define LAN8841_BTRX_POWER_DOWN_BTRX_CH_B	BIT(3)
+#define LAN8841_BTRX_POWER_DOWN_BTRX_CH_C	BIT(5)
+#define LAN8841_BTRX_POWER_DOWN_BTRX_CH_D	BIT(7)
+#define LAN8841_ADC_CHANNEL_MASK		198
+#define LAN8841_PTP_RX_PARSE_L2_ADDR_EN		370
+#define LAN8841_PTP_RX_PARSE_IP_ADDR_EN		371
+#define LAN8841_PTP_RX_VERSION			374
+#define LAN8841_PTP_TX_PARSE_L2_ADDR_EN		434
+#define LAN8841_PTP_TX_PARSE_IP_ADDR_EN		435
+#define LAN8841_PTP_TX_VERSION			438
+#define LAN8841_PTP_CMD_CTL			256
+#define LAN8841_PTP_CMD_CTL_PTP_ENABLE		BIT(2)
+#define LAN8841_PTP_CMD_CTL_PTP_DISABLE		BIT(1)
+#define LAN8841_PTP_CMD_CTL_PTP_RESET		BIT(0)
+#define LAN8841_PTP_RX_PARSE_CONFIG		368
+#define LAN8841_PTP_TX_PARSE_CONFIG		432
+#define LAN8841_PTP_RX_MODE			381
+#define LAN8841_PTP_INSERT_TS_EN		BIT(0)
+#define LAN8841_PTP_INSERT_TS_32BIT		BIT(1)
+
+static int lan8841_config_rgmii_delay(struct phy_device *phydev)
+{
+	u16 rxcdll_val, txcdll_val;
+	int ret;
+
+	switch (phydev->interface) {
+	case PHY_INTERFACE_MODE_RGMII:
+		rxcdll_val = BIT(14);
+		txcdll_val = BIT(14);
+		break;
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		rxcdll_val = LAN8841_DLL_ENABLE_DELAY;
+		txcdll_val = LAN8841_DLL_ENABLE_DELAY;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+		rxcdll_val = LAN8841_DLL_ENABLE_DELAY;
+		txcdll_val = BIT(14);
+		break;
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		rxcdll_val = BIT(14);
+		txcdll_val = LAN8841_DLL_ENABLE_DELAY;
+		break;
+	default:
+		return 0;
+	}
+
+	ret = phy_modify_mmd(phydev, LAN8841_MMD_COMMON_CTRL_REG,
+			     LAN8841_RXC_DLL_CTRL, BIT_MASK(14),
+			     rxcdll_val);
+	if (ret < 0)
+		return ret;
+
+	return phy_modify_mmd(phydev, LAN8841_MMD_COMMON_CTRL_REG,
+			      LAN8841_TXC_DLL_CTRL, BIT_MASK(14),
+			      txcdll_val);
+}
+
+static int lan8841_config_init(struct phy_device *phydev)
+{
+	int ret;
+
+	if (phy_interface_is_rgmii(phydev)) {
+		ret = lan8841_config_rgmii_delay(phydev);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Initialize the HW by resetting everything */
+	phy_modify_mmd(phydev, LAN8841_MMD_COMMON_CTRL_REG,
+		       LAN8841_PTP_CMD_CTL,
+		       LAN8841_PTP_CMD_CTL_PTP_RESET,
+		       LAN8841_PTP_CMD_CTL_PTP_RESET);
+
+	phy_modify_mmd(phydev, LAN8841_MMD_COMMON_CTRL_REG,
+		       LAN8841_PTP_CMD_CTL,
+		       LAN8841_PTP_CMD_CTL_PTP_ENABLE,
+		       LAN8841_PTP_CMD_CTL_PTP_ENABLE);
+
+	/* Don't process any frames */
+	phy_write_mmd(phydev, LAN8841_MMD_COMMON_CTRL_REG,
+		      LAN8841_PTP_RX_PARSE_CONFIG, 0);
+	phy_write_mmd(phydev, LAN8841_MMD_COMMON_CTRL_REG,
+		      LAN8841_PTP_TX_PARSE_CONFIG, 0);
+	phy_write_mmd(phydev, LAN8841_MMD_COMMON_CTRL_REG,
+		      LAN8841_PTP_TX_PARSE_L2_ADDR_EN, 0);
+	phy_write_mmd(phydev, LAN8841_MMD_COMMON_CTRL_REG,
+		      LAN8841_PTP_RX_PARSE_L2_ADDR_EN, 0);
+	phy_write_mmd(phydev, LAN8841_MMD_COMMON_CTRL_REG,
+		      LAN8841_PTP_TX_PARSE_IP_ADDR_EN, 0);
+	phy_write_mmd(phydev, LAN8841_MMD_COMMON_CTRL_REG,
+		      LAN8841_PTP_RX_PARSE_IP_ADDR_EN, 0);
+
+	/* Disable checking for minorVersionPTP field */
+	phy_write_mmd(phydev, LAN8841_MMD_COMMON_CTRL_REG,
+		      LAN8841_PTP_RX_VERSION, 0xff00);
+	phy_write_mmd(phydev, LAN8841_MMD_COMMON_CTRL_REG,
+		      LAN8841_PTP_TX_VERSION, 0xff00);
+
+	/* 100BT Clause 40 improvement errata */
+	phy_write_mmd(phydev, LAN8841_MMD_ANALOG_REG,
+		      LAN8841_ANALOG_CONTROL_1,
+		      LAN8841_ANALOG_CONTROL_1_PLL_TRIM(0x2));
+	phy_write_mmd(phydev, LAN8841_MMD_ANALOG_REG,
+		      LAN8841_ANALOG_CONTROL_10,
+		      LAN8841_ANALOG_CONTROL_10_PLL_DIV(0x1));
+
+	/* 10M/100M Ethernet Signal Tuning Errata for Shorted-Center Tap
+	 * Magnetics
+	 */
+	ret = phy_read_mmd(phydev, LAN8841_MMD_COMMON_CTRL_REG,
+			   LAN8841_OPERATION_MODE_STRAP_OVERRIDE_LOW_REG);
+	if (ret & LAN8841_OPERATION_MODE_STRAP_OVERRIDE_LOW_REG_MAGJACK) {
+		phy_write_mmd(phydev, LAN8841_MMD_ANALOG_REG,
+			      LAN8841_TX_LOW_I_CH_C_D_POWER_MANAGMENT,
+			      LAN8841_TX_LOW_I_CH_C_D_POWER_MANAGMENT_VAL);
+		phy_write_mmd(phydev, LAN8841_MMD_ANALOG_REG,
+			      LAN8841_BTRX_POWER_DOWN,
+			      LAN8841_BTRX_POWER_DOWN_QBIAS_CH_A |
+			      LAN8841_BTRX_POWER_DOWN_BTRX_CH_A |
+			      LAN8841_BTRX_POWER_DOWN_QBIAS_CH_B |
+			      LAN8841_BTRX_POWER_DOWN_BTRX_CH_B |
+			      LAN8841_BTRX_POWER_DOWN_BTRX_CH_C |
+			      LAN8841_BTRX_POWER_DOWN_BTRX_CH_D);
+	}
+
+	/* LDO Adjustment errata */
+	phy_write_mmd(phydev, LAN8841_MMD_ANALOG_REG,
+		      LAN8841_ANALOG_CONTROL_11,
+		      LAN8841_ANALOG_CONTROL_11_LDO_REF(1));
+
+	/* 100BT RGMII latency tuning errata */
+	phy_write_mmd(phydev, MDIO_MMD_PMAPMD,
+		      LAN8841_ADC_CHANNEL_MASK, 0x0);
+	phy_write_mmd(phydev, LAN8841_MMD_TIMER_REG,
+		      LAN8841_MMD0_REGISTER_17,
+		      LAN8841_MMD0_REGISTER_17_DROP_OPT(2) |
+		      LAN8841_MMD0_REGISTER_17_XMIT_TOG_TX_DIS);
+
+	/* Disable Power Down */
+	phy_modify(phydev, MDIO_DEVAD_NONE, MII_BMCR, BMCR_PDOWN, 0);
+
+	return 0;
+}
+
+U_BOOT_PHY_DRIVER(lan8841) = {
+	.name = "Microchip LAN8841",
+	.uid = PHY_ID_LAN8841,
+	.mask = PHY_ID_MATCH_MODEL_MASK,
+	.features = PHY_GBIT_FEATURES,
+	.config = &lan8841_config_init,
+	.startup = &genphy_startup,
+	.shutdown = &genphy_shutdown,
+};
-- 
2.53.0

