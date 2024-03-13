Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E55C54E66
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 16:45:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91BE687E9A;
	Wed, 13 Mar 2024 17:45:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="oQzy/RZw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F93A87D80; Wed, 13 Mar 2024 12:55:08 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1281587B2A
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 12:55:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=piotr.wojtaszczyk@timesys.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a44d084bfe1so625989866b.1
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 04:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1710330905; x=1710935705;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=N6bvbClQyVJyE+gXJQHfcslAy0BCt7fJd/AkOC4xAjs=;
 b=oQzy/RZwL0c19VC4DJ7wp+LmXqIpYT7Wm/6aFCs72eR8LewP8PxCKdJcsbBOYR4M0y
 muGOTkuVXPA1Wf50e2r454giNAW+Txjb0i8oHgODsz5CjRgEpTFhqELOLQvuCzkJR29H
 ueZsRJXKakKhjL4HG5v5SDUxngowD5wFAWj/Rf6d1pOhzCDmbI8V3ikFPZafZ1IXc9/i
 2TKeJABYpH+HcKCaaPRKHzg2FHgkKwRtn3z2FZfJa8CL/ZD71jCKNfFbMuACGtyJR4TS
 wF9YB5e25nsonPcCFxuWuVV8aLkBqwzVOmkAe2zjBjhxJCDNC+G0YD0GjUEkOgSw9lPW
 LaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710330905; x=1710935705;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N6bvbClQyVJyE+gXJQHfcslAy0BCt7fJd/AkOC4xAjs=;
 b=rMU7RcIT1jDeQxerWSoiBqAQ7E/Erge6tRJ4Gi2M8w5BUJMYr/hOUanThahfLOxy7s
 fVakSvsgPFIuK/PJ0eP+NSGAtUMIAv71U4qyzKi6hFWVSED7Kq8yiKQSpRhhA4osQAAO
 Vg7ui3T/ovAxksDER/Ba+sUHet5GRalx4KR4IRanIIQbE3SbQpGyu6P5Mb2a4f9GjCdf
 9pzg1XLZBUpDzEWeetPAsfuxnT+buY1wlhdgOwQnDFVRrMTrtaloo4GSRQc7BwNM5Evy
 pZ9MHif1ZZmQjO0kNe2RImMv+xtK7ZPdfYHeOEDvhN7PCegF8gpUg0gGC5aVvgGNSndS
 6Mjw==
X-Gm-Message-State: AOJu0YzpKVSmthn5XVcUktgtcvpb2LZZANUmiMgnQBinZivQK63jkBAR
 6OdCm04TN3DZ1Dqn55jFtBwY8lyS9h/hdEAFzwNGSjDMbM6SoKTxyNtn0mUTNRQx3qGSFVqSeh6
 rjbk=
X-Google-Smtp-Source: AGHT+IHpMfMgrwKLPmHvlcucHWyfBNxIdmgz9vWuZJA7jWoWqP7dmSJQnRFNnu3qIC3QEKQ2Bfwp1w==
X-Received: by 2002:a17:906:7ca:b0:a45:7946:8782 with SMTP id
 m10-20020a17090607ca00b00a4579468782mr1966860ejc.1.1710330905127; 
 Wed, 13 Mar 2024 04:55:05 -0700 (PDT)
Received: from localhost.localdomain ([91.216.213.152])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a17090608d200b00a461f6da4e3sm3402031eje.94.2024.03.13.04.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 04:55:04 -0700 (PDT)
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
To: u-boot@lists.denx.de
Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] gpio: mcp230xx: Add support for models with SPI interface.
Date: Wed, 13 Mar 2024 12:54:56 +0100
Message-Id: <20240313115456.9251-1-piotr.wojtaszczyk@timesys.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 Mar 2024 17:45:05 +0100
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

Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
---

 drivers/gpio/Kconfig         |   3 +
 drivers/gpio/Makefile        |   2 +-
 drivers/gpio/mcp230xx_gpio.c | 144 ++++++++++++++++++++++++++++++++++-
 3 files changed, 144 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 2df3dc42d0..a7fb1eb3f4 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -256,6 +256,9 @@ config MCP230XX_GPIO
 	   - MCP23008
 	   - MCP23017
 	   - MCP23018
+	   - MCP23S08
+	   - MCP23S17
+	   - MCP23S18
 
 config MSCC_SGPIO
 	bool "Microsemi Serial GPIO driver"
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index da3da5da2b..90711702a6 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -23,7 +23,7 @@ obj-$(CONFIG_INTEL_ICH6_GPIO)	+= intel_ich6_gpio.o
 obj-$(CONFIG_INTEL_BROADWELL_GPIO)	+= intel_broadwell_gpio.o
 obj-$(CONFIG_IPROC_GPIO)	+= iproc_gpio.o
 obj-$(CONFIG_KIRKWOOD_GPIO)	+= kw_gpio.o
-obj-$(CONFIG_MCP230XX_GPIO)	+= mcp230xx_gpio.o
+obj-$(CONFIG_$(SPL_TPL_)MCP230XX_GPIO)	+= mcp230xx_gpio.o
 obj-$(CONFIG_MXC_GPIO)	+= mxc_gpio.o
 obj-$(CONFIG_MXS_GPIO)	+= mxs_gpio.o
 obj-$(CONFIG_NPCM_GPIO)      	+= npcm_gpio.o
diff --git a/drivers/gpio/mcp230xx_gpio.c b/drivers/gpio/mcp230xx_gpio.c
index 9f02fd42b3..df99fde566 100644
--- a/drivers/gpio/mcp230xx_gpio.c
+++ b/drivers/gpio/mcp230xx_gpio.c
@@ -11,6 +11,7 @@
 #include <errno.h>
 #include <dm.h>
 #include <i2c.h>
+#include <spi.h>
 #include <asm/gpio.h>
 #include <dm/device_compat.h>
 #include <dt-bindings/gpio/gpio.h>
@@ -20,6 +21,13 @@ enum mcp230xx_type {
 	MCP23008,
 	MCP23017,
 	MCP23018,
+	MCP23S08,
+	MCP23S17,
+	MCP23S18,
+};
+
+struct mcp230xx_info {
+	uint dev_addr;
 };
 
 #define MCP230XX_IODIR 0x00
@@ -29,29 +37,136 @@ enum mcp230xx_type {
 
 #define BANKSIZE 8
 
+#define MCP230XX_ADDR 0x20
+
+static int mcp230xx_read_spi(struct udevice *dev, uint reg_addr)
+{
+	struct mcp230xx_info *info = dev_get_plat(dev);
+	uint dev_addr, value = 0;
+	int ret;
+
+	/* set R/W bit for reading */
+	dev_addr = (info->dev_addr << 1) | 1;
+
+	ret = dm_spi_claim_bus(dev);
+	if (ret)
+		return ret;
+
+	ret = dm_spi_xfer(dev, 0, NULL, NULL, SPI_XFER_BEGIN);
+	if (ret < 0)
+		goto fail;
+	udelay(1);
+
+	ret = dm_spi_xfer(dev, 8, &dev_addr, NULL, 0);
+	if (ret < 0)
+		goto fail;
+
+	ret = dm_spi_xfer(dev, 8, &reg_addr, NULL, 0);
+	if (ret < 0)
+		goto fail;
+
+	ret = dm_spi_xfer(dev, 8, NULL, &value, 0);
+
+fail:
+	dm_spi_xfer(dev, 0, NULL, NULL,  SPI_XFER_END);
+	dm_spi_release_bus(dev);
+	if (ret < 0)
+		return ret;
+	return value;
+}
+
 static int mcp230xx_read(struct udevice *dev, uint reg, uint offset)
 {
 	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
 	int bank = offset / BANKSIZE;
 	int mask = 1 << (offset % BANKSIZE);
 	int shift = (uc_priv->gpio_count / BANKSIZE) - 1;
-	int ret;
+	int reg_addr = (reg << shift) | bank;
+	int ret = 0;
+
+	switch (dev_get_driver_data(dev)) {
+	case MCP23008:
+	case MCP23017:
+	case MCP23018:
+		ret = dm_i2c_reg_read(dev, reg_addr);
+		break;
+	case MCP23S08:
+	case MCP23S17:
+	case MCP23S18:
+		ret = mcp230xx_read_spi(dev, reg_addr);
+		break;
+	default:
+		return -ENODEV;
+	}
 
-	ret = dm_i2c_reg_read(dev, (reg << shift) | bank);
 	if (ret < 0)
 		return ret;
 
 	return !!(ret & mask);
 }
 
+static int mcp230xx_clrset_spi(struct udevice *dev, uint reg_addr, uint clr, uint set)
+{
+	struct mcp230xx_info *info = dev_get_plat(dev);
+	int dev_addr, value;
+	int ret;
+
+	/* R/W bit = 0 for writing */
+	dev_addr = (info->dev_addr << 1);
+
+	ret = mcp230xx_read_spi(dev, reg_addr);
+	if (ret < 0)
+		return ret;
+
+	value = ret;
+	value &= ~clr;
+	value |= set;
+
+	ret = dm_spi_claim_bus(dev);
+	if (ret)
+		return ret;
+
+	ret = dm_spi_xfer(dev, 0, NULL, NULL, SPI_XFER_BEGIN);
+	if (ret < 0)
+		goto fail;
+	udelay(1);
+
+	ret = dm_spi_xfer(dev, 8, &dev_addr, NULL, 0);
+	if (ret < 0)
+		goto fail;
+
+	ret = dm_spi_xfer(dev, 8, &reg_addr, NULL, 0);
+	if (ret < 0)
+		goto fail;
+
+	ret = dm_spi_xfer(dev, 8, &value, NULL,  0);
+
+fail:
+	dm_spi_xfer(dev, 0, NULL, NULL,  SPI_XFER_END);
+	dm_spi_release_bus(dev);
+	return ret;
+}
+
 static int mcp230xx_write(struct udevice *dev, uint reg, uint offset, bool val)
 {
 	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
 	int bank = offset / BANKSIZE;
 	int mask = 1 << (offset % BANKSIZE);
 	int shift = (uc_priv->gpio_count / BANKSIZE) - 1;
+	int reg_addr = (reg << shift) | bank;
 
-	return dm_i2c_reg_clrset(dev, (reg << shift) | bank, mask, val ? mask : 0);
+	switch (dev_get_driver_data(dev)) {
+	case MCP23008:
+	case MCP23017:
+	case MCP23018:
+		return dm_i2c_reg_clrset(dev, reg_addr, mask, val ? mask : 0);
+	case MCP23S08:
+	case MCP23S17:
+	case MCP23S18:
+		return mcp230xx_clrset_spi(dev, reg_addr, mask, val ? mask : 0);
+	default:
+		return -ENODEV;
+	}
 }
 
 static int mcp230xx_get_value(struct udevice *dev, uint offset)
@@ -181,22 +296,37 @@ static const struct dm_gpio_ops mcp230xx_ops = {
 static int mcp230xx_probe(struct udevice *dev)
 {
 	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
-	char name[32], label[8], *str;
+	struct mcp230xx_info *info = dev_get_plat(dev);
+	char name[32], label[32], *str;
 	int addr, gpio_count, size;
 	const u8 *tmp;
 
 	switch (dev_get_driver_data(dev)) {
 	case MCP23008:
+	case MCP23S08:
 		gpio_count = 8;
 		break;
 	case MCP23017:
 	case MCP23018:
+	case MCP23S17:
+	case MCP23S18:
 		gpio_count = 16;
 		break;
 	default:
 		return -ENODEV;
 	}
 
+	switch (dev_get_driver_data(dev)) {
+	case MCP23S08:
+	case MCP23S17:
+	case MCP23S18:
+		info->dev_addr = dev_read_u32_default(dev, "addr", MCP230XX_ADDR);
+		break;
+	default:
+		info->dev_addr = 0;
+		break;
+	}
+
 	addr = dev_read_addr(dev);
 	tmp = dev_read_prop(dev, "label", &size);
 	if (tmp) {
@@ -220,9 +350,14 @@ static int mcp230xx_probe(struct udevice *dev)
 }
 
 static const struct udevice_id mcp230xx_ids[] = {
+	/* i2c interface */
 	{ .compatible = "microchip,mcp23008", .data = MCP23008, },
 	{ .compatible = "microchip,mcp23017", .data = MCP23017, },
 	{ .compatible = "microchip,mcp23018", .data = MCP23018, },
+	/* spi interface */
+	{ .compatible = "microchip,mcp23s08", .data = MCP23S08, },
+	{ .compatible = "microchip,mcp23s17", .data = MCP23S17, },
+	{ .compatible = "microchip,mcp23s18", .data = MCP23S18, },
 	{ }
 };
 
@@ -231,5 +366,6 @@ U_BOOT_DRIVER(mcp230xx) = {
 	.id		= UCLASS_GPIO,
 	.ops		= &mcp230xx_ops,
 	.probe		= mcp230xx_probe,
+	.plat_auto	= sizeof(struct mcp230xx_info),
 	.of_match	= mcp230xx_ids,
 };
-- 
2.25.1

