Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4358ECCF9FE
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 22:44:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7251583B34;
	Fri, 31 Oct 2025 23:44:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="J30vfrnU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rSUU9z7j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7A3083B47; Fri, 31 Oct 2025 23:44:42 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55F4383B32
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 23:44:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cywyw02cNz9t70;
 Fri, 31 Oct 2025 23:44:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761950680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DKmY5nWCnan9qTFKLWcoCITmIGt2GJbG4XBkTqgAz0k=;
 b=J30vfrnU1zGC6rEiw3JtMeulgPj7U7hpwDWKNOu3YmYIKxQpkAaGeyc7h++5amtYEFMYf3
 YpwtxeoDhFMxL/bsQzyOLHgZqRaxqlE+DV1tadvQ1plJhv6ghVPutMWpx4rs8HxRvts02g
 Pc4qnl2Jo8Kd+k+uwyuKlBsvTXTZ4uaC6JFUp/YNGdwu+c0ulw+wDbekUWdlLU9M2TMaFf
 gML4m7W2MW1f5J4pWVpxURY1exgBBD1nvXoL2YCtqtrXQX84Gs+p1jZGZS1Ehu9op7aKOe
 5cb7cxBcqA9915Yd/ANU0Z14fXEQgeScTTMAtX/e+SqF/HKpiWkFnzvintt0og==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761950678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DKmY5nWCnan9qTFKLWcoCITmIGt2GJbG4XBkTqgAz0k=;
 b=rSUU9z7jUqwb2ehg3+j+OlTnju/8uYlkeox+VE9S744OGuKDsCoDXZcU5SufHaMYfLMRXF
 sHoos0k7yQI+w2FDeYCrPUrgqKH7l3y+TtW+DD1BWHg1rb/D2Usl2s0bTzFdfaH5S3JoD4
 BjXlvBfMclgpYRiZyZjsvLbzOggswD/qKUNkMfMKFBAshIVwmZ518dx3VxJLh+d6UM7W12
 fgJzepiijhlUZF5mq8KroE3Zsn0W1j3wQUXwAcGDSPlW1MbFasb3e3iC/EhAo3r59kBhIH
 pCAOY3ysVjWH3zfwSjpxmqvIcMtTdrWP8ihvf8tiaKc1Zq3oJlQw2Pqgq0RvhA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dominik Wernberger <dominik.wernberger@gmx.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 1/2] spi: Squash spi_slave_of_to_plat() into
 spi_child_post_bind()
Date: Fri, 31 Oct 2025 23:43:42 +0100
Message-ID: <20251031224434.102648-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: n369wbnbfssz7iuxhwad5jejzg66t7cm
X-MBO-RS-ID: ad8202fd0558e4eb6e4
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

The spi_slave_of_to_plat() is called from one place, spi_child_post_bind().
Squash it into the later and remove the public declaration, make this
function local static. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Dominik Wernberger <dominik.wernberger@gmx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: u-boot@lists.denx.de
---
 drivers/spi/spi-uclass.c | 145 +++++++++++++++++++--------------------
 include/spi.h            |  11 ---
 2 files changed, 69 insertions(+), 87 deletions(-)

diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
index 49b584c648d..a7a06312435 100644
--- a/drivers/spi/spi-uclass.c
+++ b/drivers/spi/spi-uclass.c
@@ -180,11 +180,79 @@ int spi_write_then_read(struct spi_slave *slave, const u8 *opcode,
 static int spi_child_post_bind(struct udevice *dev)
 {
 	struct dm_spi_slave_plat *plat = dev_get_parent_plat(dev);
+	int __maybe_unused ret;
+	int mode = 0;
+	int value;
 
 	if (!dev_has_ofnode(dev))
 		return 0;
 
-	return spi_slave_of_to_plat(dev, plat);
+#if CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)
+	ret = dev_read_u32_array(dev, "reg", plat->cs, SPI_CS_CNT_MAX);
+
+	if (ret == -EOVERFLOW || ret == -FDT_ERR_BADLAYOUT) {
+		dev_read_u32(dev, "reg", &plat->cs[0]);
+	} else {
+		dev_err(dev, "has no valid 'reg' property (%d)\n", ret);
+		return ret;
+	}
+#else
+	plat->cs[0] = dev_read_u32_default(dev, "reg", -1);
+#endif
+
+	plat->max_hz = dev_read_u32_default(dev, "spi-max-frequency",
+					    SPI_DEFAULT_SPEED_HZ);
+	if (dev_read_bool(dev, "spi-cpol"))
+		mode |= SPI_CPOL;
+	if (dev_read_bool(dev, "spi-cpha"))
+		mode |= SPI_CPHA;
+	if (dev_read_bool(dev, "spi-cs-high"))
+		mode |= SPI_CS_HIGH;
+	if (dev_read_bool(dev, "spi-3wire"))
+		mode |= SPI_3WIRE;
+	if (dev_read_bool(dev, "spi-half-duplex"))
+		mode |= SPI_PREAMBLE;
+
+	/* Device DUAL/QUAD mode */
+	value = dev_read_u32_default(dev, "spi-tx-bus-width", 1);
+	switch (value) {
+	case 1:
+		break;
+	case 2:
+		mode |= SPI_TX_DUAL;
+		break;
+	case 4:
+		mode |= SPI_TX_QUAD;
+		break;
+	case 8:
+		mode |= SPI_TX_OCTAL;
+		break;
+	default:
+		warn_non_xpl("spi-tx-bus-width %d not supported\n", value);
+		break;
+	}
+
+	value = dev_read_u32_default(dev, "spi-rx-bus-width", 1);
+	switch (value) {
+	case 1:
+		break;
+	case 2:
+		mode |= SPI_RX_DUAL;
+		break;
+	case 4:
+		mode |= SPI_RX_QUAD;
+		break;
+	case 8:
+		mode |= SPI_RX_OCTAL;
+		break;
+	default:
+		warn_non_xpl("spi-rx-bus-width %d not supported\n", value);
+		break;
+	}
+
+	plat->mode = mode;
+
+	return 0;
 }
 #endif
 
@@ -511,81 +579,6 @@ void spi_free_slave(struct spi_slave *slave)
 	device_remove(slave->dev, DM_REMOVE_NORMAL);
 }
 
-int spi_slave_of_to_plat(struct udevice *dev, struct dm_spi_slave_plat *plat)
-{
-	int mode = 0;
-	int value;
-
-#if CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)
-	int ret;
-
-	ret = dev_read_u32_array(dev, "reg", plat->cs, SPI_CS_CNT_MAX);
-
-	if (ret == -EOVERFLOW || ret == -FDT_ERR_BADLAYOUT) {
-		dev_read_u32(dev, "reg", &plat->cs[0]);
-	} else {
-		dev_err(dev, "has no valid 'reg' property (%d)\n", ret);
-		return ret;
-	}
-#else
-	plat->cs[0] = dev_read_u32_default(dev, "reg", -1);
-#endif
-
-	plat->max_hz = dev_read_u32_default(dev, "spi-max-frequency",
-					    SPI_DEFAULT_SPEED_HZ);
-	if (dev_read_bool(dev, "spi-cpol"))
-		mode |= SPI_CPOL;
-	if (dev_read_bool(dev, "spi-cpha"))
-		mode |= SPI_CPHA;
-	if (dev_read_bool(dev, "spi-cs-high"))
-		mode |= SPI_CS_HIGH;
-	if (dev_read_bool(dev, "spi-3wire"))
-		mode |= SPI_3WIRE;
-	if (dev_read_bool(dev, "spi-half-duplex"))
-		mode |= SPI_PREAMBLE;
-
-	/* Device DUAL/QUAD mode */
-	value = dev_read_u32_default(dev, "spi-tx-bus-width", 1);
-	switch (value) {
-	case 1:
-		break;
-	case 2:
-		mode |= SPI_TX_DUAL;
-		break;
-	case 4:
-		mode |= SPI_TX_QUAD;
-		break;
-	case 8:
-		mode |= SPI_TX_OCTAL;
-		break;
-	default:
-		warn_non_xpl("spi-tx-bus-width %d not supported\n", value);
-		break;
-	}
-
-	value = dev_read_u32_default(dev, "spi-rx-bus-width", 1);
-	switch (value) {
-	case 1:
-		break;
-	case 2:
-		mode |= SPI_RX_DUAL;
-		break;
-	case 4:
-		mode |= SPI_RX_QUAD;
-		break;
-	case 8:
-		mode |= SPI_RX_OCTAL;
-		break;
-	default:
-		warn_non_xpl("spi-rx-bus-width %d not supported\n", value);
-		break;
-	}
-
-	plat->mode = mode;
-
-	return 0;
-}
-
 UCLASS_DRIVER(spi) = {
 	.id		= UCLASS_SPI,
 	.name		= "spi",
diff --git a/include/spi.h b/include/spi.h
index 2783200d663..95e7d5b1556 100644
--- a/include/spi.h
+++ b/include/spi.h
@@ -657,17 +657,6 @@ int spi_chip_select(struct udevice *slave);
  */
 int spi_find_chip_select(struct udevice *bus, int cs, struct udevice **devp);
 
-/**
- * spi_slave_of_to_plat() - decode standard SPI platform data
- *
- * This decodes the speed and mode for a slave from a device tree node
- *
- * @blob:	Device tree blob
- * @node:	Node offset to read from
- * @plat:	Place to put the decoded information
- */
-int spi_slave_of_to_plat(struct udevice *dev, struct dm_spi_slave_plat *plat);
-
 /**
  * spi_cs_info() - Check information on a chip select
  *
-- 
2.51.0

