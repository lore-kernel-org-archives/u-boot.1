Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4E9D44161
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 14:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56FE78953C;
	Tue, 19 Nov 2024 15:26:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Dd1nzQEl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7EF789548; Tue, 19 Nov 2024 15:26:52 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69E5989500
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 15:26:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38245e072e8so1976625f8f.0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 06:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732026410; x=1732631210; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kktIutszN+A1PKP0UiRAEp6ay8+E6vSyC0RE6rd5iGU=;
 b=Dd1nzQElaTP8ibHUqsYV7yby1yrEb/v5odcfBv3N3ddw7WZDcYay3TOU0A4fd4+IUp
 bWmeXPjiWNPNzO/Vp6Xcw0+l2uI7zdKNnoep6QZlMz5/k3HbVAGQ6wnNKiTsIf3lmxIn
 53jQYm13FdDdmY+ykfDDwID4bgBUHdR9st6hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732026410; x=1732631210;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kktIutszN+A1PKP0UiRAEp6ay8+E6vSyC0RE6rd5iGU=;
 b=jm7mUTem+y8l6PaFKwOV1RYJr7+zMtihBIh0xt3tk8c+UlosYBQiQgzcY4FwoOZLpY
 fLfmldvnbDTiq7o2ykUYeuvpUg7yA6xTbn/+YIFh+tlT2ReIkWhxuYBljcJRIHBz5Vnd
 KtAiF1jJormq2Wqbwuw58PY4zFPjPNF0ivM6k8rPFmpZ2emjNEYZH27LS5SqAZVv6+YH
 nWjnx6pLO5Yv5Kli4hX43b1x1svQluPJM9uilbseXjHozRplWGhBNh7z7if5Xr80BmIV
 liHT5idn7+vY2CKgrhmfHYT0VOrDBCAHgCHj5G4ThtRAeLzWKy1ScSK9ccrisZJyto3V
 u2TA==
X-Gm-Message-State: AOJu0Yz+p9D+VHBOKvrRZZqqFvAKJMRK4q52w1dLie8mesJq63V2eiWr
 W1u/HXpxEpT3Tj5GS0PHBPB38w6GbfMr4zQhg2TWND9gUaC4AfuePFZCace80HtQ2kCk026U5ZX
 Dl/U=
X-Google-Smtp-Source: AGHT+IGK7+JH3p3baSCfIbyYVSBxNR/lGQU0qfio11NAaLdSsVrJ0eVq1NRD9opbpo1pI5D4bsBFyg==
X-Received: by 2002:a5d:5f54:0:b0:382:46ea:1113 with SMTP id
 ffacd0b85a97d-38246ea1870mr8092683f8f.4.1732026409717; 
 Tue, 19 Nov 2024 06:26:49 -0800 (PST)
Received: from oliver.tail58a08.ts.net ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38241f341d9sm7925157f8f.22.2024.11.19.06.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 06:26:49 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Markus Gothe <markus.gothe@genexis.eu>
Subject: [PATCH] Bitbanging MDIO driver for DM framework.
Date: Tue, 19 Nov 2024 08:26:44 -0600
Message-Id: <20241119142644.736942-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

From: Markus Gothe <markus.gothe@genexis.eu>

Linux DTS compatible MDIO bitbanging driver.
Both clause 22 and clause 45 MDIO supported and validated.

Heavily based on the Linux drivers (more or less the same code base).

Signed-off-by: Markus Gothe <markus.gothe@genexis.eu>
---
 drivers/net/Kconfig     |   6 +
 drivers/net/Makefile    |   1 +
 drivers/net/mdio_gpio.c | 313 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 320 insertions(+)
 create mode 100644 drivers/net/mdio_gpio.c

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 576cd2d50ad9..5e862158c566 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1007,6 +1007,12 @@ config FSL_ENETC
 	  This driver supports the NXP ENETC Ethernet controller found on some
 	  of the NXP SoCs.
 
+config MDIO_GPIO_BITBANG
+	bool "GPIO bitbanging MDIO driver"
+	depends on DM_MDIO && DM_GPIO
+	help
+	 Driver for bitbanging MDIO
+
 config MDIO_MUX_I2CREG
 	bool "MDIO MUX accessed as a register over I2C"
 	depends on DM_MDIO_MUX && DM_I2C
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index f5ab1f5dedf6..e51a917933eb 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -61,6 +61,7 @@ obj-$(CONFIG_LITEETH) += liteeth.o
 obj-$(CONFIG_MACB) += macb.o
 obj-$(CONFIG_MCFFEC) += mcffec.o mcfmii.o
 obj-$(CONFIG_MDIO_IPQ4019) += mdio-ipq4019.o
+obj-$(CONFIG_MDIO_GPIO_BITBANG) += mdio_gpio.o
 obj-$(CONFIG_MDIO_MUX_I2CREG) += mdio_mux_i2creg.o
 obj-$(CONFIG_MDIO_MUX_MESON_G12A) += mdio_mux_meson_g12a.o
 obj-$(CONFIG_MDIO_MUX_MESON_GXL) += mdio_mux_meson_gxl.o
diff --git a/drivers/net/mdio_gpio.c b/drivers/net/mdio_gpio.c
new file mode 100644
index 000000000000..a2a41f95190c
--- /dev/null
+++ b/drivers/net/mdio_gpio.c
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * GPIO based MDIO bitbang driver.
+ *
+ * Copyright 2024 Markus Gothe <markus.gothe@genexis.eu>
+ *
+ * This file is based on the Linux kernel drivers drivers/net/phy/mdio-gpio.c
+ * and drivers/net/phy/mdio-bitbang.c which have the following copyrights:
+ *
+ * Copyright (c) 2008 CSE Semaphore Belgium.
+ *  by Laurent Pinchart <laurentp@cse-semaphore.com>
+ *
+ * Copyright (C) 2008, Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
+ *
+ * Author: Scott Wood <scottwood@freescale.com>
+ * Copyright (c) 2007 Freescale Semiconductor
+ *
+ * Copyright (c) 2003 Intracom S.A.
+ *  by Pantelis Antoniou <panto@intracom.gr>
+ *
+ * 2005 (c) MontaVista Software, Inc.
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ */
+
+#include <dm.h>
+#include <log.h>
+#include <miiphy.h>
+#include <asm/gpio.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/mdio.h>
+
+#define MDIO_READ 2
+#define MDIO_WRITE 1
+
+#define MDIO_C45 BIT(15)
+#define MDIO_C45_ADDR (MDIO_C45 | 0)
+#define MDIO_C45_READ (MDIO_C45 | 3)
+#define MDIO_C45_WRITE (MDIO_C45 | 1)
+
+/* Minimum MDC period is 400 ns, plus some margin for error.  MDIO_DELAY
+ * is done twice per period.
+ */
+#define MDIO_DELAY 250
+
+/* The PHY may take up to 300 ns to produce data, plus some margin
+ * for error.
+ */
+#define MDIO_READ_DELAY 350
+
+#define MDIO_GPIO_MDC	0
+#define MDIO_GPIO_MDIO	1
+#define MDIO_GPIO_MDO	2
+
+struct mdio_gpio_priv {
+	struct gpio_desc mdc, mdio, mdo;
+};
+
+static void mdio_dir(struct udevice *mdio_dev, int dir)
+{
+	struct mdio_gpio_priv *priv = dev_get_priv(mdio_dev);
+
+	if (dm_gpio_is_valid(&priv->mdo)) {
+		/* Separate output pin. Always set its value to high
+		 * when changing direction. If direction is input,
+		 * assume the pin serves as pull-up. If direction is
+		 * output, the default value is high.
+		 */
+		dm_gpio_set_value(&priv->mdo, 1);
+		return;
+	}
+
+	if (dir)
+		dm_gpio_set_dir_flags(&priv->mdio, GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
+	else
+		dm_gpio_set_dir_flags(&priv->mdio, GPIOD_IS_IN);
+}
+
+static int mdio_get(struct udevice *mdio_dev)
+{
+	struct mdio_gpio_priv *priv = dev_get_priv(mdio_dev);
+
+	return dm_gpio_get_value(&priv->mdio);
+}
+
+static void mdio_set(struct udevice *mdio_dev, int what)
+{
+	struct mdio_gpio_priv *priv = dev_get_priv(mdio_dev);
+
+	if (dm_gpio_is_valid(&priv->mdo))
+		dm_gpio_set_value(&priv->mdo, what);
+	else
+		dm_gpio_set_value(&priv->mdio, what);
+}
+
+static void mdc_set(struct udevice *mdio_dev, int what)
+{
+	struct mdio_gpio_priv *priv = dev_get_priv(mdio_dev);
+
+	dm_gpio_set_value(&priv->mdc, what);
+}
+
+/* MDIO must already be configured as output. */
+static void mdio_gpio_send_bit(struct udevice *mdio_dev, int val)
+{
+	mdio_set(mdio_dev, val);
+	ndelay(MDIO_DELAY);
+	mdc_set(mdio_dev, 1);
+	ndelay(MDIO_DELAY);
+	mdc_set(mdio_dev, 0);
+}
+
+/* MDIO must already be configured as input. */
+static int mdio_gpio_get_bit(struct udevice *mdio_dev)
+{
+	ndelay(MDIO_DELAY);
+	mdc_set(mdio_dev, 1);
+	ndelay(MDIO_READ_DELAY);
+	mdc_set(mdio_dev, 0);
+
+	return mdio_get(mdio_dev);
+}
+
+/* MDIO must already be configured as output. */
+static void mdio_gpio_send_num(struct udevice *mdio_dev, u16 val, int bits)
+{
+	int i;
+
+	for (i = bits - 1; i >= 0; i--)
+		mdio_gpio_send_bit(mdio_dev, (val >> i) & 1);
+}
+
+/* MDIO must already be configured as input. */
+static u16 mdio_gpio_get_num(struct udevice *mdio_dev, int bits)
+{
+	int i;
+	u16 ret = 0;
+
+	for (i = bits - 1; i >= 0; i--) {
+		ret <<= 1;
+		ret |= mdio_gpio_get_bit(mdio_dev);
+	}
+
+	return ret;
+}
+
+/* Utility to send the preamble, address, and
+ * register (common to read and write).
+ */
+static void mdio_gpio_cmd(struct udevice *mdio_dev, int op, u8 phy, u8 reg)
+{
+	int i;
+
+	mdio_dir(mdio_dev, 1);
+
+	/*
+	 * Send a 32 bit preamble ('1's) with an extra '1' bit for good
+	 * measure.  The IEEE spec says this is a PHY optional
+	 * requirement.  The AMD 79C874 requires one after power up and
+	 * one after a MII communications error.  This means that we are
+	 * doing more preambles than we need, but it is safer and will be
+	 * much more robust.
+	 */
+	for (i = 0; i < 32; i++)
+		mdio_gpio_send_bit(mdio_dev, 1);
+
+	/*
+	 * Send the start bit (01) and the read opcode (10) or write (01).
+	 * Clause 45 operation uses 00 for the start and 11, 10 for
+	 * read/write.
+	 */
+	mdio_gpio_send_bit(mdio_dev, 0);
+	if (op & MDIO_C45)
+		mdio_gpio_send_bit(mdio_dev, 0);
+	else
+		mdio_gpio_send_bit(mdio_dev, 1);
+	mdio_gpio_send_bit(mdio_dev, (op >> 1) & 1);
+	mdio_gpio_send_bit(mdio_dev, (op >> 0) & 1);
+
+	mdio_gpio_send_num(mdio_dev, phy, 5);
+	mdio_gpio_send_num(mdio_dev, reg, 5);
+}
+
+/*
+ * In clause 45 mode all commands are prefixed by MDIO_ADDR to specify the
+ * lower 16 bits of the 21 bit address. This transfer is done identically to a
+ * MDIO_WRITE except for a different code. To enable clause 45 mode or
+ * MII_ADDR_C45 into the address. Theoretically clause 45 and normal devices
+ * can exist on the same bus. Normal devices should ignore the MDIO_ADDR
+ * phase.
+ */
+static int mdio_gpio_cmd_addr(struct udevice *mdio_dev, int phy, u32 dev_addr, u32 reg)
+{
+	mdio_gpio_cmd(mdio_dev, MDIO_C45_ADDR, phy, dev_addr);
+
+	/* send the turnaround (10) */
+	mdio_gpio_send_bit(mdio_dev, 1);
+	mdio_gpio_send_bit(mdio_dev, 0);
+
+	mdio_gpio_send_num(mdio_dev, reg, 16);
+
+	mdio_dir(mdio_dev, 0);
+	mdio_gpio_get_bit(mdio_dev);
+
+	return dev_addr;
+}
+
+static int mdio_gpio_read(struct udevice *mdio_dev, int addr, int devad, int reg)
+{
+	int ret, i;
+
+	if (devad != MDIO_DEVAD_NONE) {
+		reg = mdio_gpio_cmd_addr(mdio_dev, addr, devad, reg);
+		mdio_gpio_cmd(mdio_dev, MDIO_C45_READ, addr, reg);
+	} else {
+		mdio_gpio_cmd(mdio_dev, MDIO_READ, addr, reg);
+	}
+
+	mdio_dir(mdio_dev, 0);
+
+	/* check the turnaround bit: the PHY should be driving it to zero.
+	 */
+	if (mdio_gpio_get_bit(mdio_dev) != 0) {
+		/* PHY didn't drive TA low -- flush any bits it
+		 * may be trying to send.
+		 */
+		for (i = 0; i < 32; i++)
+			mdio_gpio_get_bit(mdio_dev);
+
+		return 0xffff;
+	}
+
+	ret = mdio_gpio_get_num(mdio_dev, 16);
+	mdio_gpio_get_bit(mdio_dev);
+
+	return ret;
+}
+
+static int mdio_gpio_write(struct udevice *mdio_dev, int addr, int devad, int reg, u16 val)
+{
+	if (devad != MDIO_DEVAD_NONE) {
+		reg = mdio_gpio_cmd_addr(mdio_dev, addr, devad, reg);
+		mdio_gpio_cmd(mdio_dev, MDIO_C45_WRITE, addr, reg);
+	} else {
+		mdio_gpio_cmd(mdio_dev, MDIO_WRITE, addr, reg);
+	}
+
+	/* send the turnaround (10) */
+	mdio_gpio_send_bit(mdio_dev, 1);
+	mdio_gpio_send_bit(mdio_dev, 0);
+
+	mdio_gpio_send_num(mdio_dev, val, 16);
+
+	mdio_dir(mdio_dev, 0);
+	mdio_gpio_get_bit(mdio_dev);
+
+	return 0;
+}
+
+static const struct mdio_ops mdio_gpio_ops = {
+	.read = mdio_gpio_read,
+	.write = mdio_gpio_write,
+	.reset = NULL,
+};
+
+/*
+ * Name the device, we use the device tree node name.
+ * This can be overwritten by MDIO class code if device-name property is
+ * present.
+ */
+static int mdio_gpio_bind(struct udevice *mdio_dev)
+{
+	if (ofnode_valid(dev_ofnode(mdio_dev)))
+		device_set_name(mdio_dev, ofnode_get_name(dev_ofnode(mdio_dev)));
+
+	return 0;
+}
+
+static int mdio_gpio_probe(struct udevice *mdio_dev)
+{
+	struct mdio_gpio_priv *priv = dev_get_priv(mdio_dev);
+	int ret = 0;
+
+	ret = gpio_request_by_name(mdio_dev, "gpios", MDIO_GPIO_MDC, &priv->mdc, GPIOD_IS_OUT);
+	if (ret)
+		return ret;
+
+	ret = gpio_request_by_name(mdio_dev, "gpios", MDIO_GPIO_MDIO, &priv->mdio, GPIOD_IS_IN);
+	if (ret)
+		return ret;
+
+	ret = gpio_request_by_name(mdio_dev, "gpios", MDIO_GPIO_MDO, &priv->mdo, GPIOD_IS_OUT);
+	if (ret && ret != -ENOENT)
+		return ret;
+
+	return 0;
+}
+
+static const struct udevice_id mdio_gpio_ids[] = {
+	{ .compatible = "virtual,mdio-gpio" },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(gpio_mdio) = {
+	.name = "gpio_mdio",
+	.id = UCLASS_MDIO,
+	.of_match = mdio_gpio_ids,
+	.bind = mdio_gpio_bind,
+	.probe = mdio_gpio_probe,
+	.ops = &mdio_gpio_ops,
+	.plat_auto = sizeof(struct mdio_perdev_priv),
+	.priv_auto = sizeof(struct mdio_gpio_priv),
+};
-- 
2.34.1

