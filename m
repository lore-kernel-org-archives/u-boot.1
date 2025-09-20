Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC36CAC5A7
	for <u-boot@archiver.kernel.org>; Sat, 20 Sep 2025 16:10:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0F5683335;
	Sat, 20 Sep 2025 18:10:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IDkG6nrJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A43183211; Sat, 20 Sep 2025 18:10:27 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F2B28003E
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 18:10:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45f31adf368so21178295e9.3
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 09:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758384625; x=1758989425; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CPYo1YdJySAkaOOEbvtoDOgllx+D3CLusA/7UbiDRsE=;
 b=IDkG6nrJLZPauLvrdtBbwKydpPh2qvS3N4Wpj4CFdP5kGdvLl3Fwc+a2RIVtm2mcDS
 D7Fc6s3OzyYN3nAicPAxWiAWwd4I3OdF7N51ibcR7O8g1twpbTga4lXITKDSzExJwJLT
 qX1W2d6RQFU3M/Cnx64vTsv1LtNfoSPShKM+08sUoFxi//+xcCxKUCBE5LoaA/sou2hH
 2lTY+SAbSEUMuzfx7dwFJrGDxWK5C0AUfcL36U3YyAyIwU8PkVMyCwCLNhR73sLD6Spo
 6GuTCgwSPFZ7Ri3gjJSiLqObzW8VHk3+2ClnqRAlxPiXBtWOuj9b9pln12qkK5tsYgWa
 VBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758384625; x=1758989425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CPYo1YdJySAkaOOEbvtoDOgllx+D3CLusA/7UbiDRsE=;
 b=PEy0n9XTtPnjPX+IpSOpNh4kCRsiRRI9QDDgQFRNp2P9Z79gQrk++au8iDUPQKu5P4
 hEDvtHrASVxu3Q9cbMarOYYxjdwkAjchnkStbbRwHOv3Az7HKffAtOoDGeY/opeG8WK8
 0rczZ0cezHkcUx+GcoDtvqMlyGCv2IeUWVyVn50QyS33t22my4A57TVXsXj02WIQWXGb
 vBXwvHLMNZAPIbqzBuuIBxDU4RaQKftLPepuD6EuOyP6geTSAyyAIVJNabStvynAOCPg
 FdELCYk2GSrYt1W7VWqxJodkGs7VYwjKv0v2/nQXiohGtb5yojtRPZyTySdPVzeVaj8c
 hqhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/HUHnPGNPcMWrU7legod2JkJdl/Xina2xOYlDGqk2ueSDYA0pwSWBRIf/wPNUDp3GVxP5S4M=@lists.denx.de
X-Gm-Message-State: AOJu0YxOA/exjo3d0bsKspr7RYY3fzvquSpTevixIrZJ4Rkq0YJw52KK
 m6gHAfyOZGHl1jgkgNilm+x1J0ecTD2WiT4aO/35xeX4VVNlLDKYexDd
X-Gm-Gg: ASbGnctbWSPp30t81zvGgAOvrBQb0DVCD3wfZcsCuIuwSTn0t3bLZMxoNqEv6+DWBPp
 FnpdjYEvexlydPD+xPpdcfNtmfrT8/2p6BoGY8taSIr4pu4T89WrDdPrl7imTelkOajL3E9ZS5I
 DdkqfeJXJip4nty7MQtgQOY6+Q5hH0SkPftgztFK8+7Wmw3nq4KxQkkfdG46c0ES5oWNCvizcg9
 bpcVz4XA0IfopOnel2t4Ibo1jJ+TBin7RVXaNK4puRfJqgsuCsGOnQk2tIGhZoOD/jfFZIejurh
 SnubrqVXAdN8KpvyO8+RzlEjjrn8okXhu28yyUn5FblS11ZygTqLQBJXH3f/IHcQ1OxI/UJW77T
 nnu/CROoIYBUnJrc3sDzS/lSUCe19gE/ULD4JudNcXB1INV9BKFMbH/OLo2ze/MF1QaK27BE=
X-Google-Smtp-Source: AGHT+IHjJH7d+0iHTuNPFudqAgtvS+Nw/N90UoXnnVEhokwXhXuBCLEToWECAKPoYcb6HYcqzw3n8w==
X-Received: by 2002:a05:600c:a04:b0:45b:8b3e:9f66 with SMTP id
 5b1f17b1804b1-467e78caaa3mr55870435e9.13.1758384624557; 
 Sat, 20 Sep 2025 09:10:24 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it.
 [95.249.236.54]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-45f325cec0fsm105878675e9.4.2025.09.20.09.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 09:10:24 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v2 4/5] net: mediatek: move MT7531 MMIO MDIO to dedicated
 driver
Date: Sat, 20 Sep 2025 18:09:44 +0200
Message-ID: <20250920161013.31799-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920161013.31799-1-ansuelsmth@gmail.com>
References: <20250920161013.31799-1-ansuelsmth@gmail.com>
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

In preparation for support of MDIO on AN7581, move the MT7531 MMIO logic
to a dedicated driver and permit usage of the mdio read/write function
to the mtk_eth driver.

This only affect MT7988 that can use MMIO operation to access the Switch
register. The MT7988 code is updated to make use of the external driver.

This permits Airoha driver to make use of DM_MDIO to bind for the MT7531
driver that have the same exact register.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/Kconfig            |   3 +
 drivers/net/Makefile           |   1 +
 drivers/net/mdio-mt7531-mmio.c | 168 +++++++++++++++++++++++++++++++++
 drivers/net/mdio-mt7531-mmio.h |   9 ++
 drivers/net/mtk_eth/Kconfig    |   1 +
 drivers/net/mtk_eth/mt7988.c   |  85 ++++++++++++++---
 6 files changed, 254 insertions(+), 13 deletions(-)
 create mode 100644 drivers/net/mdio-mt7531-mmio.c
 create mode 100644 drivers/net/mdio-mt7531-mmio.h

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index d1cb69f85ad..cee4a3fc9bd 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -966,6 +966,9 @@ config TSEC_ENET
 	  This driver implements support for the (Enhanced) Three-Speed
 	  Ethernet Controller found on Freescale SoCs.
 
+config MDIO_MT7531_MMIO
+	bool
+
 source "drivers/net/mtk_eth/Kconfig"
 
 config HIFEMAC_ETH
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index f8f9a71f815..a3c3420898c 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -63,6 +63,7 @@ obj-$(CONFIG_MACB) += macb.o
 obj-$(CONFIG_MCFFEC) += mcffec.o mcfmii.o
 obj-$(CONFIG_MDIO_IPQ4019) += mdio-ipq4019.o
 obj-$(CONFIG_MDIO_GPIO_BITBANG) += mdio_gpio.o
+obj-$(CONFIG_MDIO_MT7531_MMIO) += mdio-mt7531-mmio.o
 obj-$(CONFIG_MDIO_MUX_I2CREG) += mdio_mux_i2creg.o
 obj-$(CONFIG_MDIO_MUX_MESON_G12A) += mdio_mux_meson_g12a.o
 obj-$(CONFIG_MDIO_MUX_MESON_GXL) += mdio_mux_meson_gxl.o
diff --git a/drivers/net/mdio-mt7531-mmio.c b/drivers/net/mdio-mt7531-mmio.c
new file mode 100644
index 00000000000..3e325ca58da
--- /dev/null
+++ b/drivers/net/mdio-mt7531-mmio.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <asm/io.h>
+#include <dm.h>
+#include <linux/bitfield.h>
+#include <linux/iopoll.h>
+#include <miiphy.h>
+
+#define MT7531_PHY_IAC			0x701c
+#define   MT7531_PHY_ACS_ST		BIT(31)
+#define   MT7531_MDIO_REG_ADDR_CL22	GENMASK(29, 25)
+#define   MT7531_MDIO_DEV_ADDR		MT7531_MDIO_REG_ADDR_CL22
+#define   MT7531_MDIO_PHY_ADDR		GENMASK(24, 20)
+#define   MT7531_MDIO_CMD		GENMASK(19, 18)
+#define   MT7531_MDIO_CMD_READ_CL45	FIELD_PREP_CONST(MT7531_MDIO_CMD, 0x3)
+#define   MT7531_MDIO_CMD_READ_CL22	FIELD_PREP_CONST(MT7531_MDIO_CMD, 0x2)
+#define   MT7531_MDIO_CMD_WRITE		FIELD_PREP_CONST(MT7531_MDIO_CMD, 0x1)
+#define   MT7531_MDIO_CMD_ADDR		FIELD_PREP_CONST(MT7531_MDIO_CMD, 0x0)
+#define   MT7531_MDIO_ST		GENMASK(17, 16)
+#define   MT7531_MDIO_ST_CL22		FIELD_PREP_CONST(MT7531_MDIO_ST, 0x1)
+#define   MT7531_MDIO_ST_CL45		FIELD_PREP_CONST(MT7531_MDIO_ST, 0x0)
+#define   MT7531_MDIO_RW_DATA		GENMASK(15, 0)
+#define   MT7531_MDIO_REG_ADDR_CL45	MT7531_MDIO_RW_DATA
+
+#define MT7531_MDIO_TIMEOUT		100000
+#define MT7531_MDIO_SLEEP		20
+
+struct mt7531_mdio_priv {
+	phys_addr_t switch_regs;
+};
+
+static int mt7531_mdio_wait_busy(struct mt7531_mdio_priv *priv)
+{
+	unsigned int busy;
+
+	return readl_poll_sleep_timeout(priv->switch_regs + MT7531_PHY_IAC,
+					busy, (busy & MT7531_PHY_ACS_ST) == 0,
+					MT7531_MDIO_SLEEP, MT7531_MDIO_TIMEOUT);
+}
+
+static int mt7531_mdio_read(struct mt7531_mdio_priv *priv, int addr, int devad, int reg)
+{
+	u32 val;
+
+	if (devad != MDIO_DEVAD_NONE) {
+		if (mt7531_mdio_wait_busy(priv))
+			return -ETIMEDOUT;
+
+		val = MT7531_PHY_ACS_ST |
+		      MT7531_MDIO_ST_CL45 | MT7531_MDIO_CMD_ADDR |
+		      FIELD_PREP(MT7531_MDIO_PHY_ADDR, addr) |
+		      FIELD_PREP(MT7531_MDIO_DEV_ADDR, devad) |
+		      FIELD_PREP(MT7531_MDIO_REG_ADDR_CL45, reg);
+
+		writel(val, priv->switch_regs + MT7531_PHY_IAC);
+	}
+
+	if (mt7531_mdio_wait_busy(priv))
+		return -ETIMEDOUT;
+
+	val = MT7531_PHY_ACS_ST | FIELD_PREP(MT7531_MDIO_PHY_ADDR, addr);
+	if (devad != MDIO_DEVAD_NONE)
+		val |= MT7531_MDIO_ST_CL45 | MT7531_MDIO_CMD_READ_CL45 |
+		       FIELD_PREP(MT7531_MDIO_DEV_ADDR, devad);
+	else
+		val |= MT7531_MDIO_ST_CL22 | MT7531_MDIO_CMD_READ_CL22 |
+		       FIELD_PREP(MT7531_MDIO_REG_ADDR_CL22, reg);
+
+	writel(val, priv->switch_regs + MT7531_PHY_IAC);
+
+	if (mt7531_mdio_wait_busy(priv))
+		return -ETIMEDOUT;
+
+	val = readl(priv->switch_regs + MT7531_PHY_IAC);
+	return val & MT7531_MDIO_RW_DATA;
+}
+
+static int mt7531_mdio_write(struct mt7531_mdio_priv *priv, int addr, int devad,
+			     int reg, u16 value)
+{
+	u32 val;
+
+	if (devad != MDIO_DEVAD_NONE) {
+		if (mt7531_mdio_wait_busy(priv))
+			return -ETIMEDOUT;
+
+		val = MT7531_PHY_ACS_ST |
+		      MT7531_MDIO_ST_CL45 | MT7531_MDIO_CMD_ADDR |
+		      FIELD_PREP(MT7531_MDIO_PHY_ADDR, addr) |
+		      FIELD_PREP(MT7531_MDIO_DEV_ADDR, devad) |
+		      FIELD_PREP(MT7531_MDIO_REG_ADDR_CL45, reg);
+
+		writel(val, priv->switch_regs + MT7531_PHY_IAC);
+	}
+
+	if (mt7531_mdio_wait_busy(priv))
+		return -ETIMEDOUT;
+
+	val = MT7531_PHY_ACS_ST | FIELD_PREP(MT7531_MDIO_PHY_ADDR, addr) |
+	      MT7531_MDIO_CMD_WRITE | FIELD_PREP(MT7531_MDIO_RW_DATA, value);
+	if (devad != MDIO_DEVAD_NONE)
+		val |= MT7531_MDIO_ST_CL45 |
+		       FIELD_PREP(MT7531_MDIO_DEV_ADDR, devad);
+	else
+		val |= MT7531_MDIO_ST_CL22 |
+		       FIELD_PREP(MT7531_MDIO_REG_ADDR_CL22, reg);
+
+	writel(val, priv->switch_regs + MT7531_PHY_IAC);
+
+	if (mt7531_mdio_wait_busy(priv))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+int mt7531_mdio_mmio_read(struct mii_dev *bus, int addr, int devad, int reg)
+{
+	struct mt7531_mdio_priv *priv = bus->priv;
+
+	return mt7531_mdio_read(priv, addr, devad, reg);
+}
+
+int mt7531_mdio_mmio_write(struct mii_dev *bus, int addr, int devad,
+			   int reg, u16 value)
+{
+	struct mt7531_mdio_priv *priv = bus->priv;
+
+	return mt7531_mdio_write(priv, addr, devad, reg, value);
+}
+
+static int dm_mt7531_mdio_read(struct udevice *dev, int addr, int devad, int reg)
+{
+	struct mt7531_mdio_priv *priv = dev_get_priv(dev);
+
+	return mt7531_mdio_read(priv, addr, devad, reg);
+}
+
+static int dm_mt7531_mdio_write(struct udevice *dev, int addr, int devad,
+				int reg, u16 value)
+{
+	struct mt7531_mdio_priv *priv = dev_get_priv(dev);
+
+	return mt7531_mdio_write(priv, addr, devad, reg, value);
+}
+
+static const struct mdio_ops mt7531_mdio_ops = {
+	.read = dm_mt7531_mdio_read,
+	.write = dm_mt7531_mdio_write,
+};
+
+static int mt7531_mdio_probe(struct udevice *dev)
+{
+	struct mt7531_mdio_priv *priv = dev_get_priv(dev);
+
+	priv->switch_regs = dev_read_addr(dev);
+	if (priv->switch_regs == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	return 0;
+}
+
+U_BOOT_DRIVER(mt7531_mdio) = {
+	.name           = "mt7531-mdio-mmio",
+	.id             = UCLASS_MDIO,
+	.probe          = mt7531_mdio_probe,
+	.ops            = &mt7531_mdio_ops,
+	.priv_auto	  = sizeof(struct mt7531_mdio_priv),
+};
diff --git a/drivers/net/mdio-mt7531-mmio.h b/drivers/net/mdio-mt7531-mmio.h
new file mode 100644
index 00000000000..f98102cb939
--- /dev/null
+++ b/drivers/net/mdio-mt7531-mmio.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+struct mt7531_mdio_mmio_priv {
+	phys_addr_t switch_regs;
+};
+
+int mt7531_mdio_mmio_read(struct mii_dev *bus, int addr, int devad, int reg);
+int mt7531_mdio_mmio_write(struct mii_dev *bus, int addr, int devad,
+			   int reg, u16 value);
diff --git a/drivers/net/mtk_eth/Kconfig b/drivers/net/mtk_eth/Kconfig
index e8cdf408237..8716eb86064 100644
--- a/drivers/net/mtk_eth/Kconfig
+++ b/drivers/net/mtk_eth/Kconfig
@@ -30,6 +30,7 @@ config MTK_ETH_SWITCH_MT7531
 config MTK_ETH_SWITCH_MT7988
 	bool "Support for MediaTek MT7988 built-in ethernet switch"
 	depends on TARGET_MT7988
+	select MDIO_MT7531_MMIO
 	default y
 
 config MTK_ETH_SWITCH_AN8855
diff --git a/drivers/net/mtk_eth/mt7988.c b/drivers/net/mtk_eth/mt7988.c
index b77660be55c..29b6363cbd7 100644
--- a/drivers/net/mtk_eth/mt7988.c
+++ b/drivers/net/mtk_eth/mt7988.c
@@ -6,6 +6,7 @@
  * Author: Mark Lee <mark-mc.lee@mediatek.com>
  */
 
+#include <malloc.h>
 #include <miiphy.h>
 #include <linux/delay.h>
 #include <linux/mdio.h>
@@ -14,6 +15,8 @@
 #include "mtk_eth.h"
 #include "mt753x.h"
 
+#include "../mdio-mt7531-mmio.h"
+
 static int mt7988_reg_read(struct mt753x_switch_priv *priv, u32 reg, u32 *data)
 {
 	*data = readl(priv->epriv.ethsys_base + GSW_BASE + reg);
@@ -30,25 +33,34 @@ static int mt7988_reg_write(struct mt753x_switch_priv *priv, u32 reg, u32 data)
 
 static void mt7988_phy_setting(struct mt753x_switch_priv *priv)
 {
+	struct mii_dev *mdio_bus = priv->mdio_bus;
 	u16 val;
 	u32 i;
 
 	for (i = 0; i < MT753X_NUM_PHYS; i++) {
+		u16 addr = MT753X_PHY_ADDR(priv->phy_base, i);
+
 		/* Set PHY to PHY page 1 */
-		mt7531_mii_write(priv, i, 0x1f, 0x1);
+		mt7531_mdio_mmio_write(mdio_bus, addr, MDIO_DEVAD_NONE,
+				       0x1f, 0x1);
 
 		/* Enable HW auto downshift */
-		val = mt7531_mii_read(priv, i, PHY_EXT_REG_14);
+		val = mt7531_mdio_mmio_read(mdio_bus, addr, MDIO_DEVAD_NONE,
+					    PHY_EXT_REG_14);
 		val |= PHY_EN_DOWN_SHFIT;
-		mt7531_mii_write(priv, i, PHY_EXT_REG_14, val);
+		mt7531_mdio_mmio_write(mdio_bus, addr, MDIO_DEVAD_NONE,
+				       PHY_EXT_REG_14, val);
 
 		/* PHY link down power saving enable */
-		val = mt7531_mii_read(priv, i, PHY_EXT_REG_17);
+		val = mt7531_mdio_mmio_read(mdio_bus, addr, MDIO_DEVAD_NONE,
+					    PHY_EXT_REG_17);
 		val |= PHY_LINKDOWN_POWER_SAVING_EN;
-		mt7531_mii_write(priv, i, PHY_EXT_REG_17, val);
+		mt7531_mdio_mmio_write(mdio_bus, addr, MDIO_DEVAD_NONE,
+				       PHY_EXT_REG_17, val);
 
 		/* Restore PHY to PHY page 0 */
-		mt7531_mii_write(priv, i, 0x1f, 0x0);
+		mt7531_mdio_mmio_write(mdio_bus, addr, MDIO_DEVAD_NONE,
+				       0x1f, 0x0);
 	}
 }
 
@@ -63,23 +75,66 @@ static void mt7988_mac_control(struct mtk_eth_switch_priv *swpriv, bool enable)
 	mt7988_reg_write(priv, PMCR_REG(6), pmcr);
 }
 
+static int mt7988_mdio_register(struct mt753x_switch_priv *priv)
+{
+	struct mt7531_mdio_mmio_priv *mdio_priv;
+	struct mii_dev *mdio_bus = mdio_alloc();
+	int ret;
+
+	if (!mdio_bus)
+		return -ENOMEM;
+
+	mdio_priv = malloc(sizeof(*mdio_priv));
+	if (!mdio_priv)
+		return -ENOMEM;
+
+	mdio_priv->switch_regs = (phys_addr_t)priv->epriv.ethsys_base + GSW_BASE;
+
+	mdio_bus->read = mt7531_mdio_mmio_read;
+	mdio_bus->write = mt7531_mdio_mmio_write;
+	snprintf(mdio_bus->name, sizeof(mdio_bus->name), priv->epriv.sw->name);
+
+	mdio_bus->priv = mdio_priv;
+
+	ret = mdio_register(mdio_bus);
+	if (ret) {
+		free(mdio_bus->priv);
+		mdio_free(mdio_bus);
+		return ret;
+	}
+
+	priv->mdio_bus = mdio_bus;
+
+	return 0;
+}
+
 static int mt7988_setup(struct mtk_eth_switch_priv *swpriv)
 {
 	struct mt753x_switch_priv *priv = (struct mt753x_switch_priv *)swpriv;
-	u16 phy_val;
+	struct mii_dev *mdio_bus;
+	u16 phy_addr, phy_val;
+	int ret, i;
 	u32 pmcr;
-	int i;
 
 	priv->smi_addr = MT753X_DFL_SMI_ADDR;
 	priv->phy_base = (priv->smi_addr + 1) & MT753X_SMI_ADDR_MASK;
 	priv->reg_read = mt7988_reg_read;
 	priv->reg_write = mt7988_reg_write;
 
+	ret = mt7988_mdio_register(priv);
+	if (ret)
+		return ret;
+
+	mdio_bus = priv->mdio_bus;
+
 	/* Turn off PHYs */
 	for (i = 0; i < MT753X_NUM_PHYS; i++) {
-		phy_val = mt7531_mii_read(priv, i, MII_BMCR);
+		phy_addr = MT753X_PHY_ADDR(priv->phy_base, i);
+		phy_val = mt7531_mdio_mmio_read(mdio_bus, phy_addr,
+						MDIO_DEVAD_NONE, MII_BMCR);
 		phy_val |= BMCR_PDOWN;
-		mt7531_mii_write(priv, i, MII_BMCR, phy_val);
+		mt7531_mdio_mmio_write(mdio_bus, phy_addr, MDIO_DEVAD_NONE,
+				       MII_BMCR, phy_val);
 	}
 
 	switch (priv->epriv.phy_interface) {
@@ -132,14 +187,17 @@ static int mt7988_setup(struct mtk_eth_switch_priv *swpriv)
 
 	/* Turn on PHYs */
 	for (i = 0; i < MT753X_NUM_PHYS; i++) {
-		phy_val = mt7531_mii_read(priv, i, MII_BMCR);
+		phy_addr = MT753X_PHY_ADDR(priv->phy_base, i);
+		phy_val = mt7531_mdio_mmio_read(mdio_bus, phy_addr,
+						MDIO_DEVAD_NONE, MII_BMCR);
 		phy_val &= ~BMCR_PDOWN;
-		mt7531_mii_write(priv, i, MII_BMCR, phy_val);
+		mt7531_mdio_mmio_write(mdio_bus, phy_addr, MDIO_DEVAD_NONE,
+				       MII_BMCR, phy_val);
 	}
 
 	mt7988_phy_setting(priv);
 
-	return mt7531_mdio_register(priv);
+	return 0;
 }
 
 static int mt7988_cleanup(struct mtk_eth_switch_priv *swpriv)
@@ -148,6 +206,7 @@ static int mt7988_cleanup(struct mtk_eth_switch_priv *swpriv)
 	struct mii_dev *mdio_bus = priv->mdio_bus;
 
 	mdio_unregister(mdio_bus);
+	free(mdio_bus->priv);
 	mdio_free(mdio_bus);
 
 	return 0;
-- 
2.51.0

