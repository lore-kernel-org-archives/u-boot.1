Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708DCCAC5A5
	for <u-boot@archiver.kernel.org>; Sat, 20 Sep 2025 14:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D567B83211;
	Sat, 20 Sep 2025 16:37:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VUPCtuC4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEBB6833EB; Sat, 20 Sep 2025 16:37:11 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B38868004F
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 16:37:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3ee15505cdeso1758512f8f.0
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 07:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758379028; x=1758983828; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4kFcYAwjv5RZcBxe86X0kE+mkn7LuOEhqUh6qg9N5hc=;
 b=VUPCtuC4ipMDbl6jGX82G+w/hL6KefZ+X+dNsmBlH0BJ8SjD5kGKUdCcbILPzjXwiY
 duEEa901dZnAslojFbbEJYtCpJaaXhEdYO1R/UtFdmqcZ7/SkcqUTOh1ExudSUWOo5UJ
 PWwtKXGUGnHYdAeXhF5cz0tgK+Cs2oIy7fZKrvjRkwUhfO41UoimF+21DieXj4/VQMVd
 voXMXZ8mwC6aJXovogVVGipD0U2kjk9EktC9DGsgX9G28w8/wWKW/42gdAU77Y044jzL
 DF+LW2H3Abo2jAo/ygQ8dX9BRRDoASnSQmZxUONHgfm0axuLMTb4o+zS6jbbq6jg8lBX
 8pBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758379028; x=1758983828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4kFcYAwjv5RZcBxe86X0kE+mkn7LuOEhqUh6qg9N5hc=;
 b=d40k17R/5ldOA2o723VVdU2R9wqfTfWMW8SQyyAZotI8X65PK7SCEui5kBFF5Z4GBh
 95ecERTo2Y2kxlbAqxGizq7CaCC80iAPNxh+Ylhx7nOMmukryFwC9pnexwB+w0JBiSvb
 v+QGkl6nZoJEvcXKkXgx37IVyMSvEc9HtPr/GtBt2XrwBkZ6u/dFgfDQLJOHVLJpzVaf
 pgz2+0WepMPx8w3QfgqW1aEh3eXf72cSE7wftc1d6ViXqEj0Y3X3rJeoXKOZB4w5mX0P
 NXXDUWW7ktu4JL8QU9A1Q19z8l/R1dyPMYQQ/A6ifGbuaI0uJnpG5c3o2ZU8rvvydXYe
 e6/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbwMkdqlgXQJXWbwS48UOtu+6fHhz7jFNYyGeaARI4xdhWJzjtC36EhTR1lNzKe0xAcFXOhk4=@lists.denx.de
X-Gm-Message-State: AOJu0Yyr5Wsy9zhxCY6gIr6eQbTGtFJLILEHFg1nyqx5KnKdT+7N10uY
 I3Bq1sn2ufqqjkh2QfpwrZBkvkOV6r4Yypp9FXlWDFx+AkYy+Bunfl5u
X-Gm-Gg: ASbGncthr+UYyCS13Y34ZdC5HlRZswG3k11YJPV181+RBU7Hv2KXWqHDo/sJAoaQ8Kq
 lEwkF8YbS37aYLetZNS21fJWT9/vSNoGp0MRtETfITrd7sb6ypkde/H7dUnjDOrAXJ9RjCwoLeU
 NkZQeJXsTdw7tQqapEwArmXe3Ob5xDMYHXV/klILZucufUOOtNMOOEtG955wWsqfD1UbGCaC9Zk
 Uu7Dqt6xjwPFdIZ/xd4YOO8pxiop62T3nOZU3ItPSEjWuOUWhW558WLtu3ty/XbERzyKQdD29TZ
 YxlghrJ8GOYxmiiizSJ04zglnQJq6pplxQeNt/JuV1f3S5A26GjI44NYj//nogmfwv/0B0JCVLp
 4uFDTa/WjCTWKw/7DUpcNMqw6OZSomwn0CK1vJpREgSf7gO8TQmfo2z3V3ZCzgjGr9bWOXdI=
X-Google-Smtp-Source: AGHT+IGVoDOqmdDUnFy6W9/i8kK5qu00HHsjrVXVK35hnvv2y3Wrok4ZIKjqLeurtfkA3zk14rfemQ==
X-Received: by 2002:a05:6000:290a:b0:3ea:63d:44a8 with SMTP id
 ffacd0b85a97d-3ee193f9113mr6081201f8f.15.1758379027930; 
 Sat, 20 Sep 2025 07:37:07 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it.
 [95.249.236.54]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fc00a92sm12353716f8f.63.2025.09.20.07.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 07:37:07 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 4/5] net: mediatek: move MT7531 MMIO MDIO to dedicated driver
Date: Sat, 20 Sep 2025 16:36:49 +0200
Message-ID: <20250920143656.29770-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920143656.29770-1-ansuelsmth@gmail.com>
References: <20250920143656.29770-1-ansuelsmth@gmail.com>
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
 drivers/net/mtk_eth/mt7988.c   |  79 +++++++++++++---
 6 files changed, 249 insertions(+), 12 deletions(-)
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
index 797070add7a..29b6363cbd7 100644
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
@@ -30,6 +33,7 @@ static int mt7988_reg_write(struct mt753x_switch_priv *priv, u32 reg, u32 data)
 
 static void mt7988_phy_setting(struct mt753x_switch_priv *priv)
 {
+	struct mii_dev *mdio_bus = priv->mdio_bus;
 	u16 val;
 	u32 i;
 
@@ -37,20 +41,26 @@ static void mt7988_phy_setting(struct mt753x_switch_priv *priv)
 		u16 addr = MT753X_PHY_ADDR(priv->phy_base, i);
 
 		/* Set PHY to PHY page 1 */
-		mt7531_mii_write(priv, addr, 0x1f, 0x1);
+		mt7531_mdio_mmio_write(mdio_bus, addr, MDIO_DEVAD_NONE,
+				       0x1f, 0x1);
 
 		/* Enable HW auto downshift */
-		val = mt7531_mii_read(priv, addr, PHY_EXT_REG_14);
+		val = mt7531_mdio_mmio_read(mdio_bus, addr, MDIO_DEVAD_NONE,
+					    PHY_EXT_REG_14);
 		val |= PHY_EN_DOWN_SHFIT;
-		mt7531_mii_write(priv, addr, PHY_EXT_REG_14, val);
+		mt7531_mdio_mmio_write(mdio_bus, addr, MDIO_DEVAD_NONE,
+				       PHY_EXT_REG_14, val);
 
 		/* PHY link down power saving enable */
-		val = mt7531_mii_read(priv, addr, PHY_EXT_REG_17);
+		val = mt7531_mdio_mmio_read(mdio_bus, addr, MDIO_DEVAD_NONE,
+					    PHY_EXT_REG_17);
 		val |= PHY_LINKDOWN_POWER_SAVING_EN;
-		mt7531_mii_write(priv, addr, PHY_EXT_REG_17, val);
+		mt7531_mdio_mmio_write(mdio_bus, addr, MDIO_DEVAD_NONE,
+				       PHY_EXT_REG_17, val);
 
 		/* Restore PHY to PHY page 0 */
-		mt7531_mii_write(priv, addr, 0x1f, 0x0);
+		mt7531_mdio_mmio_write(mdio_bus, addr, MDIO_DEVAD_NONE,
+				       0x1f, 0x0);
 	}
 }
 
@@ -65,24 +75,66 @@ static void mt7988_mac_control(struct mtk_eth_switch_priv *swpriv, bool enable)
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
+	struct mii_dev *mdio_bus;
 	u16 phy_addr, phy_val;
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
 		phy_addr = MT753X_PHY_ADDR(priv->phy_base, i);
-		phy_val = mt7531_mii_read(priv, phy_addr, MII_BMCR);
+		phy_val = mt7531_mdio_mmio_read(mdio_bus, phy_addr,
+						MDIO_DEVAD_NONE, MII_BMCR);
 		phy_val |= BMCR_PDOWN;
-		mt7531_mii_write(priv, phy_addr, MII_BMCR, phy_val);
+		mt7531_mdio_mmio_write(mdio_bus, phy_addr, MDIO_DEVAD_NONE,
+				       MII_BMCR, phy_val);
 	}
 
 	switch (priv->epriv.phy_interface) {
@@ -136,14 +188,16 @@ static int mt7988_setup(struct mtk_eth_switch_priv *swpriv)
 	/* Turn on PHYs */
 	for (i = 0; i < MT753X_NUM_PHYS; i++) {
 		phy_addr = MT753X_PHY_ADDR(priv->phy_base, i);
-		phy_val = mt7531_mii_read(priv, phy_addr, MII_BMCR);
+		phy_val = mt7531_mdio_mmio_read(mdio_bus, phy_addr,
+						MDIO_DEVAD_NONE, MII_BMCR);
 		phy_val &= ~BMCR_PDOWN;
-		mt7531_mii_write(priv, phy_addr, MII_BMCR, phy_val);
+		mt7531_mdio_mmio_write(mdio_bus, phy_addr, MDIO_DEVAD_NONE,
+				       MII_BMCR, phy_val);
 	}
 
 	mt7988_phy_setting(priv);
 
-	return mt7531_mdio_register(priv);
+	return 0;
 }
 
 static int mt7988_cleanup(struct mtk_eth_switch_priv *swpriv)
@@ -152,6 +206,7 @@ static int mt7988_cleanup(struct mtk_eth_switch_priv *swpriv)
 	struct mii_dev *mdio_bus = priv->mdio_bus;
 
 	mdio_unregister(mdio_bus);
+	free(mdio_bus->priv);
 	mdio_free(mdio_bus);
 
 	return 0;
-- 
2.51.0

