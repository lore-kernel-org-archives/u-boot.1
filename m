Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25B9C54E90
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 14:51:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D212983100;
	Thu, 22 May 2025 16:51:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="Q/CUAEvf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D12F8307F; Thu, 22 May 2025 16:11:04 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D69C8309A
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 16:10:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=230144c57=Eoin.Dickson@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1747923060; x=1779459060;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=czhtuBOqByHlwkAWTqwOtnvxd3ca39v3uBFUqYuiuNs=;
 b=Q/CUAEvfaC3XW3bLM3W90qYHW/7Z+4vELEqqccBE3oHSjUtCrib/Pjkr
 /OAvebQ41YpY4Uou1UFHYPTZcqpVuC6mKJNdT8dtCVxp2lWVCn8VGxe3w
 +uc2Nzht+Yo4M6jDeIp5WNo0TN4Hd1rwZboP1c5YnOP65lu2OMD3MEP5Y
 61YmmUeuY8hb8YpK2jCO9rf34Ew2F42rfqjBtncZYNCGUrmXH+xa+xdyu
 ixIw7VcM3n35SjiBpyCBsGCKhAstcwGevqWlMnoOt/rO7Wwrjxr3TYnCe
 VmGMHCimhW6HXjVCA5IGTzJ+FN68/0Ox5WjfnZiY6fGp/1vwTqsSS4Gps g==;
X-CSE-ConnectionGUID: 4Vv6n9SaRFWqXYHoGSYIZA==
X-CSE-MsgGUID: /EZmX8fySS2E/2ng0bpA2w==
X-IronPort-AV: E=Sophos;i="6.15,306,1739862000"; d="scan'208";a="41493680"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 May 2025 07:10:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 22 May 2025 07:10:48 -0700
Received: from ird-lt-m75649b.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 22 May 2025 07:10:46 -0700
From: Eoin Dickson <Eoin.Dickson@microchip.com>
To: <u-boot@lists.denx.de>
CC: <rick@andestech.com>, <ycliang@andestech.com>,
 <conor.dooley@microchip.com>, <jamie.gibbons@microchip.com>,
 <praveen.kumar@microchip.com>, <eoin.dickson@microchip.com>,
 <cyril.jean@microchip.com>, <jagan@amarulasolutions.com>
Subject: [PATCH v1 2/4] spi: coreqspi: add xfer function for PolarFire SoC
Date: Thu, 22 May 2025 19:40:00 +0530
Message-ID: <20250522141002.1212408-3-Eoin.Dickson@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250522141002.1212408-1-Eoin.Dickson@microchip.com>
References: <20250522141002.1212408-1-Eoin.Dickson@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 22 May 2025 16:50:59 +0200
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

From: Eoin Dickson <eoin.dickson@microchip.com>

Add xfer function to PolarFire SoC coreqspi driver. The read and write
operations are limited to one byte at a time instead of four as CMD18
(multiple block read) reads garbage when four byte ops are enabled.

Signed-off-by: Eoin Dickson <eoin.dickson@microchip.com>
---
 drivers/spi/microchip_coreqspi.c | 113 ++++++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/microchip_coreqspi.c b/drivers/spi/microchip_coreqspi.c
index 5fe0c8e123..d3d7124fc0 100644
--- a/drivers/spi/microchip_coreqspi.c
+++ b/drivers/spi/microchip_coreqspi.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/types.h>
 #include <linux/sizes.h>
+#include <asm/gpio.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -98,6 +99,8 @@ DECLARE_GLOBAL_DATA_PTR;
 #define REG_X4_TX_DATA         (0x4c)
 #define REG_FRAMESUP           (0x50)
 
+#define MAX_CS_COUNT 1
+
 /**
  * struct mchp_coreqspi - Defines qspi driver instance
  * @regs:              Address of the QSPI controller registers
@@ -114,6 +117,7 @@ struct mchp_coreqspi {
 	u8 *rxbuf;
 	int tx_len;
 	int rx_len;
+	struct gpio_desc cs_gpios[MAX_CS_COUNT];
 };
 
 static void mchp_coreqspi_init_hw(struct mchp_coreqspi *qspi)
@@ -173,7 +177,7 @@ static inline void mchp_coreqspi_write_op(struct mchp_coreqspi *qspi, bool word)
 	while (qspi->tx_len >= 4) {
 		while (readl(qspi->regs + REG_STATUS) & STATUS_TXFIFOFULL)
 			;
-		data = *(u32 *)qspi->txbuf;
+		data = qspi->txbuf ? *((u32 *)qspi->txbuf) : 0xFF;
 		qspi->txbuf += 4;
 		qspi->tx_len -= 4;
 		writel(data, qspi->regs + REG_X4_TX_DATA);
@@ -185,7 +189,7 @@ static inline void mchp_coreqspi_write_op(struct mchp_coreqspi *qspi, bool word)
 	while (qspi->tx_len--) {
 		while (readl(qspi->regs + REG_STATUS) & STATUS_TXFIFOFULL)
 			;
-		data =  *qspi->txbuf++;
+		data = qspi->txbuf ? *qspi->txbuf++ : 0xFF;
 		writel(data, qspi->regs + REG_TX_DATA);
 	}
 }
@@ -472,6 +476,110 @@ static int mchp_coreqspi_probe(struct udevice *dev)
 	/* Init the mpfs qspi hw */
 	mchp_coreqspi_init_hw(qspi);
 
+	if (CONFIG_IS_ENABLED(DM_GPIO)) {
+		int i;
+
+		ret = gpio_request_list_by_name(dev, "cs-gpios", qspi->cs_gpios,
+							ARRAY_SIZE(qspi->cs_gpios), 0);
+
+		if (ret < 0) {
+			pr_err("Can't get %s gpios! Error: %d", dev->name, ret);
+			return ret;
+		}
+
+		for (i = 0; i < ARRAY_SIZE(qspi->cs_gpios); i++) {
+			if (!dm_gpio_is_valid(&qspi->cs_gpios[i]))
+				continue;
+			dm_gpio_set_dir_flags(&qspi->cs_gpios[i], GPIOD_IS_OUT);
+		}
+	}
+
+	u32 control = readl(qspi->regs + REG_CONTROL);
+
+	control |= (CONTROL_MASTER | CONTROL_ENABLE);
+	control &= ~CONTROL_CLKIDLE;
+	writel(control, qspi->regs + REG_CONTROL);
+
+	return 0;
+}
+
+static void mchp_coreqspi_cs_activate(struct udevice *dev)
+{
+	struct udevice *bus = dev_get_parent(dev);
+	struct mchp_coreqspi *qspi = dev_get_priv(bus);
+	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
+	u32 cs = slave_plat->cs;
+
+	if (CONFIG_IS_ENABLED(DM_GPIO) && dm_gpio_is_valid(&qspi->cs_gpios[cs]))
+		dm_gpio_set_value(&qspi->cs_gpios[cs], 1);
+}
+
+static void mchp_coreqspi_cs_deactivate(struct udevice *dev)
+{
+	struct udevice *bus = dev_get_parent(dev);
+	struct mchp_coreqspi *qspi = dev_get_priv(bus);
+	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
+	u32 cs = slave_plat->cs;
+
+	if (CONFIG_IS_ENABLED(DM_GPIO) && dm_gpio_is_valid(&qspi->cs_gpios[cs]))
+		dm_gpio_set_value(&qspi->cs_gpios[cs], 0);
+}
+
+static int mchp_coreqspi_xfer(struct udevice *dev, unsigned int bitlen,
+				const void *dout, void *din, unsigned long flags)
+{
+	struct udevice *bus = dev_get_parent(dev);
+	struct mchp_coreqspi *qspi = dev_get_priv(bus);
+	struct spi_slave *slave = dev_get_parent_priv(dev);
+	uint total_bytes = bitlen >> 3; /* fixed 8-bit word length */
+	u32 control, frames;
+
+	int err = 0;
+
+	err = mchp_coreqspi_wait_for_ready(slave);
+	if (err)
+		return err;
+
+	control = readl(qspi->regs + REG_CONTROL);
+	control &= ~(CONTROL_MODE12_MASK | CONTROL_MODE0);
+	writel(control, qspi->regs + REG_CONTROL);
+
+	frames = total_bytes & BYTESUPPER_MASK;
+	writel(frames, qspi->regs + REG_FRAMESUP);
+
+	frames |= FRAMES_FLAGBYTE;
+	writel(frames, qspi->regs + REG_FRAMES);
+
+	if (flags & SPI_XFER_BEGIN)
+		mchp_coreqspi_cs_activate(dev);
+
+	if (bitlen == 0)
+		goto out;
+
+	if (bitlen % 8) { // Non byte aligned SPI transfer
+		flags |= SPI_XFER_END;
+		goto out;
+	}
+
+	qspi->txbuf = (u8 *)dout;
+	qspi->rxbuf = (u8 *)din;
+
+	while (total_bytes) {
+		qspi->tx_len = 1;
+		qspi->rx_len = 1;
+		total_bytes--;
+
+		if (din) {
+			mchp_coreqspi_write_op(qspi, true);
+			mchp_coreqspi_read_op(qspi);
+		} else {
+			mchp_coreqspi_write_op(qspi, true);
+		}
+	}
+out:
+	if (flags & SPI_XFER_END)
+		mchp_coreqspi_cs_deactivate(dev);
+
 	return 0;
 }
 
@@ -484,6 +592,7 @@ static const struct spi_controller_mem_ops mchp_coreqspi_mem_ops = {
 static const struct dm_spi_ops mchp_coreqspi_ops = {
 	.claim_bus      = mchp_coreqspi_claim_bus,
 	.release_bus    = mchp_coreqspi_release_bus,
+	.xfer           = mchp_coreqspi_xfer,
 	.set_speed      = mchp_coreqspi_set_speed,
 	.set_mode       = mchp_coreqspi_set_mode,
 	.mem_ops        = &mchp_coreqspi_mem_ops,
-- 
2.34.1

