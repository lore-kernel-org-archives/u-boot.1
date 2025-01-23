Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DACC02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 12:13:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1EDE80818;
	Thu, 23 Jan 2025 13:12:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="qsC/t+yo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA4308076E; Thu, 23 Jan 2025 13:12:27 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C110807A7
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 13:12:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9601A148A1ED; Thu, 23 Jan 2025 13:12:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1737634344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YVlL+aT+Fy/vOeriG6zXqXNCaa/v4O1THSKzoxXi+Xk=;
 b=qsC/t+yoe1vX/Lu82Gmg84m6QfY0GNrQN3XWLZspryrr7vPL3WXXVYTa5TrhwNLhwOecAB
 Y4NDkSXtC9+YV74NQE0XYP7Vkz46s0nGqjrBmrT62Sn8LKy6RR3SSJaGByFinY9rO4rGN4
 UQiua6HDXp0x6PCL/u2peBacg9N1OSP1vU4XPHtKLYajwec/D8SMwmgUjSO6pg1eXvfuOy
 mwzPUXE++mMbWUqN5Gcqh9r+vHAEJSV4pR5/2n6siLNpMg0FbhGWLmmQWwrq+K7EIg17H4
 utb6/8kbZKpqoiNVKLO/SqjtI+k1i77YyV1/Iu3gFgZ96Qih6Fjvw8ATxzKUVQ==
From: Alexander Dahl <ada@thorsis.com>
To: Tudor Ambarus <tudor.ambarus@microchip.com>,
 Eugen Hristev <eugen.hristev@microchip.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 u-boot@lists.denx.de
Subject: [PATCH 6/7] spi: atmel-quadspi: Add support for classic SPI mode
Date: Thu, 23 Jan 2025 13:12:14 +0100
Message-Id: <20250123121215.21001-7-ada@thorsis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250123121215.21001-1-ada@thorsis.com>
References: <20250123121215.21001-1-ada@thorsis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The qspi controller on sama5d2 and sam9x60 supports "classic" SPI mode
without spi-mem enhancements and accelerations, very similar to the old
SPI controller on sam9g20 or the modern flexcom controllers of the same
SoC family.

Register interface differs somewhat, especially because only one
hardware controlled CS line is supported.  Some fields are missing, some
are in different registers, but in principal it works similar.  So code
is very much inspired by the old atmel-spi driver.

Tested on sam9x60 with a non-mainline driver to configure an FPGA.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/spi/atmel-quadspi.c | 155 +++++++++++++++++++++++++++++++++++-
 1 file changed, 154 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index d29b5ab96e9..a2faac5a505 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -10,11 +10,13 @@
  */
 
 #include <malloc.h>
+#include <asm/gpio.h>
 #include <asm/io.h>
 #include <clk.h>
 #include <dm.h>
 #include <errno.h>
 #include <fdtdec.h>
+#include <log.h>
 #include <dm/device_compat.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
@@ -258,6 +260,7 @@ struct atmel_qspi_caps {
 
 struct atmel_qspi_priv_ops;
 
+#define MAX_CS_COUNT	2
 struct atmel_qspi {
 	void __iomem *regs;
 	void __iomem *mem;
@@ -267,6 +270,7 @@ struct atmel_qspi {
 	struct udevice *dev;
 	ulong bus_clk_rate;
 	u32 mr;
+	struct gpio_desc cs_gpios[MAX_CS_COUNT];
 };
 
 struct atmel_qspi_priv_ops {
@@ -940,6 +944,135 @@ static int atmel_qspi_sama7g5_set_speed(struct udevice *bus, uint hz)
 	return ret;
 }
 
+static int atmel_qspi_claim_bus(struct udevice *dev)
+{
+	struct udevice *bus = dev_get_parent(dev);
+	struct atmel_qspi *aq = dev_get_priv(bus);
+	int ret;
+
+	aq->mr &= ~QSPI_MR_CSMODE_MASK;
+	aq->mr |= QSPI_MR_CSMODE_LASTXFER | QSPI_MR_WDRBT;
+	atmel_qspi_write(aq->mr, aq, QSPI_MR);
+
+	ret = atmel_qspi_set_serial_memory_mode(aq, false);
+	if (ret)
+		return log_ret(ret);
+
+	/* de-assert all chip selects */
+	if (IS_ENABLED(CONFIG_DM_GPIO)) {
+		for (int i = 0; i < ARRAY_SIZE(aq->cs_gpios); i++) {
+			if (dm_gpio_is_valid(&aq->cs_gpios[i]))
+				dm_gpio_set_value(&aq->cs_gpios[i], 0);
+		}
+	}
+
+	atmel_qspi_write(QSPI_CR_QSPIEN, aq, QSPI_CR);
+
+	return 0;
+}
+
+static int atmel_qspi_release_bus(struct udevice *dev)
+{
+	struct udevice *bus = dev_get_parent(dev);
+	struct atmel_qspi *aq = dev_get_priv(bus);
+
+	/* de-assert all chip selects */
+	if (IS_ENABLED(CONFIG_DM_GPIO)) {
+		for (int i = 0; i < ARRAY_SIZE(aq->cs_gpios); i++) {
+			if (dm_gpio_is_valid(&aq->cs_gpios[i]))
+				dm_gpio_set_value(&aq->cs_gpios[i], 0);
+		}
+	}
+
+	atmel_qspi_write(QSPI_CR_QSPIDIS, aq, QSPI_CR);
+
+	return 0;
+}
+
+static int atmel_qspi_set_cs(struct udevice *dev, int value)
+{
+	struct udevice *bus = dev_get_parent(dev);
+	struct atmel_qspi *aq = dev_get_priv(bus);
+	int cs = spi_chip_select(dev);
+
+	if (IS_ENABLED(CONFIG_DM_GPIO)) {
+		if (!dm_gpio_is_valid(&aq->cs_gpios[cs]))
+			return log_ret(-ENOENT);
+
+		return dm_gpio_set_value(&aq->cs_gpios[cs], value);
+	} else {
+		return -ENOENT;
+	}
+}
+
+static int atmel_qspi_xfer(struct udevice *dev, unsigned int bitlen,
+			   const void *dout, void *din, unsigned long flags)
+{
+	struct udevice *bus = dev_get_parent(dev);
+	struct atmel_qspi *aq = dev_get_priv(bus);
+	unsigned int len, len_rx, len_tx;
+	const u8 *txp = dout;
+	u8 *rxp = din;
+	u32 reg;
+	int ret;
+
+	if (bitlen == 0)
+		goto out;
+
+	if (bitlen % 8) {
+		flags |= SPI_XFER_END;
+		goto out;
+	}
+
+	len = bitlen / 8;
+
+	if (flags & SPI_XFER_BEGIN) {
+		ret = atmel_qspi_set_cs(dev, 1);
+		if (ret)
+			return log_ret(ret);
+		reg = atmel_qspi_read(aq, QSPI_RD);
+	}
+
+	for (len_tx = 0, len_rx = 0; len_rx < len; ) {
+		u32 status = atmel_qspi_read(aq, QSPI_SR);
+		u8 value;
+
+		if (status & QSPI_SR_OVRES)
+			return log_ret(-1);
+
+		if (len_tx < len && (status & QSPI_SR_TDRE)) {
+			if (txp)
+				value = *txp++;
+			else
+				value = 0;
+			atmel_qspi_write(value, aq, QSPI_TD);
+			len_tx++;
+		}
+
+		if (status & QSPI_SR_RDRF) {
+			value = atmel_qspi_read(aq, QSPI_RD);
+			if (rxp)
+				*rxp++ = value;
+			len_rx++;
+		}
+	}
+
+out:
+	if (flags & SPI_XFER_END) {
+		readl_poll_timeout(aq->regs + QSPI_SR, reg,
+				   reg & QSPI_SR_TXEMPTY,
+				   ATMEL_QSPI_TIMEOUT);
+
+		atmel_qspi_write(QSPI_CR_LASTXFER, aq, QSPI_CR);
+
+		ret = atmel_qspi_set_cs(dev, 0);
+		if (ret)
+			return log_ret(ret);
+	}
+
+	return 0;
+}
+
 static int atmel_qspi_set_speed(struct udevice *bus, uint hz)
 {
 	struct atmel_qspi *aq = dev_get_priv(bus);
@@ -1089,6 +1222,23 @@ static int atmel_qspi_probe(struct udevice *dev)
 	else
 		aq->ops = &atmel_qspi_priv_ops;
 
+	if (IS_ENABLED(CONFIG_DM_GPIO)) {
+		ret = gpio_request_list_by_name(dev, "cs-gpios", aq->cs_gpios,
+						ARRAY_SIZE(aq->cs_gpios), 0);
+		if (ret < 0) {
+			pr_err("Can't get %s gpios! Error: %d", dev->name, ret);
+			return ret;
+		}
+
+		for (int i = 0; i < ARRAY_SIZE(aq->cs_gpios); i++) {
+			if (!dm_gpio_is_valid(&aq->cs_gpios[i]))
+				continue;
+
+			dm_gpio_set_dir_flags(&aq->cs_gpios[i],
+					      GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
+		}
+	}
+
 	/* Map the registers */
 	ret = dev_read_resource_byname(dev, "qspi_base", &res);
 	if (ret) {
@@ -1127,9 +1277,12 @@ static const struct spi_controller_mem_ops atmel_qspi_mem_ops = {
 };
 
 static const struct dm_spi_ops atmel_qspi_ops = {
+	.claim_bus = atmel_qspi_claim_bus,
+	.release_bus = atmel_qspi_release_bus,
+	.xfer = atmel_qspi_xfer,
+	.mem_ops = &atmel_qspi_mem_ops,
 	.set_speed = atmel_qspi_set_speed,
 	.set_mode = atmel_qspi_set_mode,
-	.mem_ops = &atmel_qspi_mem_ops,
 };
 
 static const struct atmel_qspi_caps atmel_sama5d2_qspi_caps = {};
-- 
2.39.5

