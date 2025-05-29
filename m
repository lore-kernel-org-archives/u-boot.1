Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24602C54FB3
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 12:27:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AC788309C;
	Thu, 29 May 2025 14:27:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="e0V8kCIG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1397183061; Thu, 29 May 2025 12:22:40 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50AFF8303C
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 12:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=237868047=Eoin.Dickson@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1748514157; x=1780050157;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HxKOp/n1k5mDxBBrJgn6l1sNXRecVNGBO1J/jcg9fkQ=;
 b=e0V8kCIGxWqCtvToZZTSXVToIqSWx13xDyKwNMbS79I0aXSM4PRIkJMC
 7H2xfR+KiLDgW+eEwny+3JolA590mfobq58KJxxGuk1eKgPBpzAHzfTm1
 i4PWpS+HDzher1+PDQSEv9BXYFq0Gfgd6IG5hRDNFqOPHqINHpoElWbIO
 rVzZVUgo/W/XUcoL3ds34nrqi4nCKPzsdyxeTNosbBwWsHT3WV4ioodbx
 myKSYOoIanS6E5DXN0rzWcRxBYtlsTl2rX0eFQJMTY2lfE0yJkxiXjGLS
 u9Wi6atWl6a26eLc+q/Q8CAv2HC/xOPoM4MvdF3rVYjPuL4hBN7kUZhfe g==;
X-CSE-ConnectionGUID: /+gMfZswTAmcTF4tFF0uoQ==
X-CSE-MsgGUID: Y9vi0tXtRDyR5pBXHR88iQ==
X-IronPort-AV: E=Sophos;i="6.15,192,1739862000"; d="scan'208";a="209696255"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 29 May 2025 03:22:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 29 May 2025 03:22:18 -0700
Received: from ird-lt-m75649b.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 29 May 2025 03:22:16 -0700
From: Eoin Dickson <Eoin.Dickson@microchip.com>
To: <u-boot@lists.denx.de>
CC: <rick@andestech.com>, <ycliang@andestech.com>,
 <conor.dooley@microchip.com>, <jamie.gibbons@microchip.com>,
 <praveen.kumar@microchip.com>, <eoin.dickson@microchip.com>,
 <cyril.jean@microchip.com>, <jagan@amarulasolutions.com>
Subject: [PATCH v2 2/2] spi: coreqspi: add xfer function for PolarFire SoC
Date: Thu, 29 May 2025 15:51:12 +0530
Message-ID: <20250529102112.3544972-3-Eoin.Dickson@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250529102112.3544972-1-Eoin.Dickson@microchip.com>
References: <20250529102112.3544972-1-Eoin.Dickson@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 29 May 2025 14:27:03 +0200
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
index 234b1688272..84b8965b7fc 100644
--- a/drivers/spi/microchip_coreqspi.c
+++ b/drivers/spi/microchip_coreqspi.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/types.h>
 #include <linux/sizes.h>
+#include <asm/gpio.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -97,6 +98,8 @@ DECLARE_GLOBAL_DATA_PTR;
 #define REG_X4_TX_DATA         (0x4c)
 #define REG_FRAMESUP           (0x50)
 
+#define MAX_CS_COUNT 1
+
 /**
  * struct mchp_coreqspi - Defines qspi driver instance
  * @regs:              Address of the QSPI controller registers
@@ -113,6 +116,7 @@ struct mchp_coreqspi {
 	u8 *rxbuf;
 	int tx_len;
 	int rx_len;
+	struct gpio_desc cs_gpios[MAX_CS_COUNT];
 };
 
 static void mchp_coreqspi_init_hw(struct mchp_coreqspi *qspi)
@@ -172,7 +176,7 @@ static inline void mchp_coreqspi_write_op(struct mchp_coreqspi *qspi, bool word)
 	while (qspi->tx_len >= 4) {
 		while (readl(qspi->regs + REG_STATUS) & STATUS_TXFIFOFULL)
 			;
-		data = *(u32 *)qspi->txbuf;
+		data = qspi->txbuf ? *((u32 *)qspi->txbuf) : 0xFF;
 		qspi->txbuf += 4;
 		qspi->tx_len -= 4;
 		writel(data, qspi->regs + REG_X4_TX_DATA);
@@ -184,7 +188,7 @@ static inline void mchp_coreqspi_write_op(struct mchp_coreqspi *qspi, bool word)
 	while (qspi->tx_len--) {
 		while (readl(qspi->regs + REG_STATUS) & STATUS_TXFIFOFULL)
 			;
-		data =  *qspi->txbuf++;
+		data = qspi->txbuf ? *qspi->txbuf++ : 0xFF;
 		writel(data, qspi->regs + REG_TX_DATA);
 	}
 }
@@ -471,6 +475,110 @@ static int mchp_coreqspi_probe(struct udevice *dev)
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
 
@@ -483,6 +591,7 @@ static const struct spi_controller_mem_ops mchp_coreqspi_mem_ops = {
 static const struct dm_spi_ops mchp_coreqspi_ops = {
 	.claim_bus      = mchp_coreqspi_claim_bus,
 	.release_bus    = mchp_coreqspi_release_bus,
+	.xfer           = mchp_coreqspi_xfer,
 	.set_speed      = mchp_coreqspi_set_speed,
 	.set_mode       = mchp_coreqspi_set_mode,
 	.mem_ops        = &mchp_coreqspi_mem_ops,
-- 
2.34.1

