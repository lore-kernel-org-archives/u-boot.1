Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D34ACA0EED
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 23:29:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CAE282DA1;
	Sat, 23 Aug 2025 01:29:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TD5aMAMO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9058182C84; Sat, 23 Aug 2025 01:29:44 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A11080EE5
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 01:29:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3c6743a10e3so652393f8f.0
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 16:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755905382; x=1756510182; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JcyVbfxRvhKI80z/NA73ou4olcbSBbSkfjTr7y9eDHY=;
 b=TD5aMAMOAUqf6ImIL6aE+kdubkFspLwpc9IGvXQfXGkIhrntwljIR/Y3d0Mbicwpvx
 XrZzqLJz1hVOWriMDpJusUcdc3Mu4Y0fXmG7HH2or1AFihS9IsfSvtrJ6x6yZazSnvP5
 R5hGg7xJtKT2l/J8+8GIN1SCIPCh5znmQbbx/6IIR+wRFqSWp7GwQehcOoUSAI9Bsxgg
 IvZa3xNF3hqFB8tOFibvaprAUW+Ih1dhOSNJKX1gXkez64xLwAQ56zoD7RevhLDrGjyX
 XK1ASzlRdaLhNdtkPRwQC1FDqbvmr0533elRT5/LTZVvX/YhmA00xSTccIQO2ZwMHXL4
 kgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755905382; x=1756510182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JcyVbfxRvhKI80z/NA73ou4olcbSBbSkfjTr7y9eDHY=;
 b=qBDmbZWiPWcU4SJ8htvH+H9P0kkbMEQeHTxGJluLxSvxPnM1V6PIs//f8U/uJBzbi/
 +ZpSXyG+ML/jilQiB+Y3fmbIdh7mpQmIcz+MXDaGu/jvtF3k5pTNxsLPveqsYsBKVerM
 UZfBM23infcq3Px0i55Sm6tg3e6VhNJKUEvxOcNLjACeHHstRnqjLhZpKfYps3JmilqR
 NL8MbtaKJELriWJNwPQMGEmqtsrizCjJKNkuAnk07/WMiaGrM6JBvawVvD4CNznOhLRT
 k3lhaShZkOaHKHl6OZsK0tNlacCKlydoqaZPRiU9sghR7OMwoIybnZHewh8jNBs16UuB
 JQmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYB2dSuKYR0doK2ubhmpt5kmxPtcnnRJu1sg5r/4GADAgrnlEoBOwdAM7RFJ3ATpV0LnXLY7s=@lists.denx.de
X-Gm-Message-State: AOJu0Ywg6ye4ZmcjA+O2gum0G6nwgjGG1lxRVPs3j2LwQ/hC+B2m0pjK
 AFom29weZQNcviHqeImvADtpnpYQRcep4qQ8Coeuu/fXTh7elEGT0cPe
X-Gm-Gg: ASbGncv5En5kvidrbJ/ScjiNvn94yci/rnAu4+7bBk+vVF/rslUmrYukhTYyVgQuif5
 LG0mk5YmPe7/fV5A+dE4dIZKq51zX3G3YtgL7QNwJxCyzjHXaTHYjlvPny5RN8Xqn9DNBUW3g6U
 Z4p6ku9hh1+UvQc2aXFADxsxUWeU0PTjY16fKiQsE8+OP4R0CaKoD4Yy1FVZW3k4+ZuRHx/Ti9h
 VPCTOZXAELD74uNOLt3OauX9P9shhkdRTmf3wEw8tDji7XL7afzcfw751SlLPxYhPvU3DL/Pjhg
 dVkKla3BU6ZwoSYtgaKtsuzrErv3FMFgYirI/fxzfg329Boarw9BjqPwO3uXw55Ib9t9H90bXMm
 q0+bx+hw9F+LpMcFkrxQTncN/EYJaWlsaaMarItCkX/fPoxe8TYUgOjPAzkUjqwfHK0IjTMg=
X-Google-Smtp-Source: AGHT+IEH3Y1TBMrqiw/hOp+X9xiJuwUZA4UipsSmkt9sZ7IJo3YBJ0QUh0r8SlaoYVsGsPL0/kuYAQ==
X-Received: by 2002:a5d:6b8d:0:b0:3c3:c280:d449 with SMTP id
 ffacd0b85a97d-3c5dc73143bmr2778001f8f.39.1755905381425; 
 Fri, 22 Aug 2025 16:29:41 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-251-209-58.retail.telecomitalia.it.
 [95.251.209.58]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3c7116e1483sm1216970f8f.50.2025.08.22.16.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 16:29:41 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Weijie Gao <weijie.gao@mediatek.com>, u-boot@lists.denx.de
Subject: [RFC PATCH 1/5] net: mediatek: move MT7531 mdio to dedicated driver
Date: Sat, 23 Aug 2025 01:29:15 +0200
Message-ID: <20250822232921.30076-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250822232921.30076-1-ansuelsmth@gmail.com>
References: <20250822232921.30076-1-ansuelsmth@gmail.com>
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

In preparation for support of MDIO on AN7581, move the MT7531 logic to a
dedicated driver and permit usage of the mdio read/write function to the
mtk_eth driver.

Minor changes are required to mtk_eth for this change as the dedicated
MDIO driver only needs info of the GSW register and nothing else.

This permits Airoha driver to make use of DM_MDIO to bind for the MT7531
driver that have the same exact register.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/Kconfig          |   3 +
 drivers/net/Makefile         |   4 +
 drivers/net/mdio-mt7531.c    | 140 +++++++++++++++++++++++++++++++++++
 drivers/net/mdio-mt7531.h    |   9 +++
 drivers/net/mtk_eth/Kconfig  |   1 +
 drivers/net/mtk_eth/mt753x.c |  29 +++-----
 drivers/net/mtk_eth/mt753x.h |   3 +
 7 files changed, 169 insertions(+), 20 deletions(-)
 create mode 100644 drivers/net/mdio-mt7531.c
 create mode 100644 drivers/net/mdio-mt7531.h

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index d1cb69f85ad..9ac9bee46c9 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -966,6 +966,9 @@ config TSEC_ENET
 	  This driver implements support for the (Enhanced) Three-Speed
 	  Ethernet Controller found on Freescale SoCs.
 
+config MDIO_MT7531
+	bool
+
 source "drivers/net/mtk_eth/Kconfig"
 
 config HIFEMAC_ETH
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index f8f9a71f815..beb7864adc2 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -62,7 +62,11 @@ obj-$(CONFIG_LITEETH) += liteeth.o
 obj-$(CONFIG_MACB) += macb.o
 obj-$(CONFIG_MCFFEC) += mcffec.o mcfmii.o
 obj-$(CONFIG_MDIO_IPQ4019) += mdio-ipq4019.o
+<<<<<<< HEAD
 obj-$(CONFIG_MDIO_GPIO_BITBANG) += mdio_gpio.o
+=======
+obj-$(CONFIG_MDIO_MT7531) += mdio-mt7531.o
+>>>>>>> net: mediatek: move MT7531 mdio to dedicated driver
 obj-$(CONFIG_MDIO_MUX_I2CREG) += mdio_mux_i2creg.o
 obj-$(CONFIG_MDIO_MUX_MESON_G12A) += mdio_mux_meson_g12a.o
 obj-$(CONFIG_MDIO_MUX_MESON_GXL) += mdio_mux_meson_gxl.o
diff --git a/drivers/net/mdio-mt7531.c b/drivers/net/mdio-mt7531.c
new file mode 100644
index 00000000000..4772c9b5407
--- /dev/null
+++ b/drivers/net/mdio-mt7531.c
@@ -0,0 +1,140 @@
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
+int mt7531_mdio_read(struct udevice *dev, int addr, int devad, int reg)
+{
+	struct mt7531_mdio_priv *priv = dev_get_priv(dev);
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
+int mt7531_mdio_write(struct udevice *dev, int addr, int devad,
+		      int reg, u16 value)
+{
+	struct mt7531_mdio_priv *priv = dev_get_priv(dev);
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
+static const struct mdio_ops mt7531_mdio_ops = {
+	.read = mt7531_mdio_read,
+	.write = mt7531_mdio_write,
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
+	.name           = "mt7531-mdio",
+	.id             = UCLASS_MDIO,
+	.probe          = mt7531_mdio_probe,
+	.ops            = &mt7531_mdio_ops,
+	.priv_auto	  = sizeof(struct mt7531_mdio_priv),
+};
diff --git a/drivers/net/mdio-mt7531.h b/drivers/net/mdio-mt7531.h
new file mode 100644
index 00000000000..ee096112f92
--- /dev/null
+++ b/drivers/net/mdio-mt7531.h
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+struct mt7531_mdio_priv {
+	phys_addr_t switch_regs;
+};
+
+int mt7531_mdio_read(struct udevice *dev, int addr, int devad, int reg);
+int mt7531_mdio_write(struct udevice *dev, int addr, int devad,
+		      int reg, u16 value);
diff --git a/drivers/net/mtk_eth/Kconfig b/drivers/net/mtk_eth/Kconfig
index e8cdf408237..67b2b612b1a 100644
--- a/drivers/net/mtk_eth/Kconfig
+++ b/drivers/net/mtk_eth/Kconfig
@@ -4,6 +4,7 @@ config MEDIATEK_ETH
 	select PHYLIB
 	select DM_GPIO
 	select DM_RESET
+	select MDIO_MT7531
 	help
 	  This Driver support MediaTek Ethernet GMAC
 	  Say Y to enable support for the MediaTek Ethernet GMAC.
diff --git a/drivers/net/mtk_eth/mt753x.c b/drivers/net/mtk_eth/mt753x.c
index cdd52f3ff1b..cf643f336d6 100644
--- a/drivers/net/mtk_eth/mt753x.c
+++ b/drivers/net/mtk_eth/mt753x.c
@@ -138,8 +138,8 @@ int mt7531_mii_read(struct mt753x_switch_priv *priv, u8 phy, u8 reg)
 
 	phy_addr = MT753X_PHY_ADDR(priv->phy_base, phy);
 
-	return mt7531_mii_rw(priv, phy_addr, reg, 0, MDIO_CMD_READ,
-			     MDIO_ST_C22);
+	return mt7531_mdio_read(&priv->mdio_priv, phy_addr, MDIO_DEVAD_NONE,
+				reg);
 }
 
 int mt7531_mii_write(struct mt753x_switch_priv *priv, u8 phy, u8 reg, u16 val)
@@ -151,48 +151,36 @@ int mt7531_mii_write(struct mt753x_switch_priv *priv, u8 phy, u8 reg, u16 val)
 
 	phy_addr = MT753X_PHY_ADDR(priv->phy_base, phy);
 
-	return mt7531_mii_rw(priv, phy_addr, reg, val, MDIO_CMD_WRITE,
-			     MDIO_ST_C22);
+	return mt7531_mdio_write(&priv->mdio_priv, phy_addr, MDIO_DEVAD_NONE,
+				 reg, val);
 }
 
 int mt7531_mmd_read(struct mt753x_switch_priv *priv, u8 addr, u8 devad,
 		    u16 reg)
 {
 	u8 phy_addr;
-	int ret;
 
 	if (addr >= MT753X_NUM_PHYS)
 		return -EINVAL;
 
 	phy_addr = MT753X_PHY_ADDR(priv->phy_base, addr);
 
-	ret = mt7531_mii_rw(priv, phy_addr, devad, reg, MDIO_CMD_ADDR,
-			    MDIO_ST_C45);
-	if (ret)
-		return ret;
-
-	return mt7531_mii_rw(priv, phy_addr, devad, 0, MDIO_CMD_READ_C45,
-			     MDIO_ST_C45);
+	return mt7531_mdio_read(&priv->mdio_priv, phy_addr, devad,
+				reg);
 }
 
 int mt7531_mmd_write(struct mt753x_switch_priv *priv, u8 addr, u8 devad,
 		     u16 reg, u16 val)
 {
 	u8 phy_addr;
-	int ret;
 
 	if (addr >= MT753X_NUM_PHYS)
 		return 0;
 
 	phy_addr = MT753X_PHY_ADDR(priv->phy_base, addr);
 
-	ret = mt7531_mii_rw(priv, phy_addr, devad, reg, MDIO_CMD_ADDR,
-			    MDIO_ST_C45);
-	if (ret)
-		return ret;
-
-	return mt7531_mii_rw(priv, phy_addr, devad, val, MDIO_CMD_WRITE,
-			     MDIO_ST_C45);
+	return mt7531_mdio_write(&priv->mdio_priv, phy_addr, devad,
+				 reg, val);
 }
 
 static int mt7531_mdio_read(struct mii_dev *bus, int addr, int devad, int reg)
@@ -224,6 +212,7 @@ int mt7531_mdio_register(struct mt753x_switch_priv *priv)
 	if (!mdio_bus)
 		return -ENOMEM;
 
+	priv->mdio_priv.switch_regs = priv->epriv.ethsys_base + GSW_BASE;
 	mdio_bus->read = mt7531_mdio_read;
 	mdio_bus->write = mt7531_mdio_write;
 	snprintf(mdio_bus->name, sizeof(mdio_bus->name), priv->epriv.sw->name);
diff --git a/drivers/net/mtk_eth/mt753x.h b/drivers/net/mtk_eth/mt753x.h
index 65046a1421c..cd128ad39fe 100644
--- a/drivers/net/mtk_eth/mt753x.h
+++ b/drivers/net/mtk_eth/mt753x.h
@@ -14,6 +14,8 @@
 #include <linux/bitops.h>
 #include <linux/bitfield.h>
 
+#include "../mdio-mt7531.h"
+
 struct mtk_eth_priv;
 
 #define MT753X_NUM_PHYS		5
@@ -254,6 +256,7 @@ struct mtk_eth_priv;
 
 struct mt753x_switch_priv {
 	struct mtk_eth_switch_priv epriv;
+	struct mt7531_mdio_priv mdio_priv;
 	struct mii_dev *mdio_bus;
 	u32 smi_addr;
 	u32 phy_base;
-- 
2.50.0

