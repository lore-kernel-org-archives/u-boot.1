Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FDDCD343F
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 00:27:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB58884659;
	Wed, 13 May 2026 02:26:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wolfssl-com.20251104.gappssmtp.com header.i=@wolfssl-com.20251104.gappssmtp.com header.b="soxIk8gx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A6B083EF9; Wed, 13 May 2026 02:26:37 +0200 (CEST)
Received: from mail-dl1-x122c.google.com (mail-dl1-x122c.google.com
 [IPv6:2607:f8b0:4864:20::122c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E191838BB
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 02:26:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aidan@wolfssl.com
Received: by mail-dl1-x122c.google.com with SMTP id
 a92af1059eb24-13246950f3cso8129873c88.1
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 17:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20251104.gappssmtp.com; s=20251104; t=1778631992; x=1779236792;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VGQmXMiC9wgQRX7t9zd4WdvDYbep0XnHdMNo5ecbJ48=;
 b=soxIk8gxLeYFUlEKbJY63EPEqGg/UW/5wgjDBKaovct6/KvZqI6T5Iw460aXspI5jk
 Gwidt1b578mqjqATyqA85g9kY8jo/6EaMxb6cewGHVUu1XcswvdyrKMeyhofqQp6uVh3
 KOIDWsFo6vO1GDaLNEBkPPYk7Cn5rLC3jVK0tRN2VS5iqXNaUzMUWIopd3natdTw2er3
 GqpRKgv5IKiSF30UDyJvjFM9MveKBg2idE1a1NHyZzR77cuLNPNUm1jitXId9tjyCP8l
 tAdCIFcEOPjZasFqdPhuD5eXJYVdJ6GXtmZv1Sciq7aNRZGhKioVyOa+LWRyXjM976um
 o55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778631992; x=1779236792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VGQmXMiC9wgQRX7t9zd4WdvDYbep0XnHdMNo5ecbJ48=;
 b=Qv/G8R97Sro6E/6MpTtAxjXIsv4xnv/17Iq9VrXhiQqGY5Li5DTy0oEyYNrIcWvhNI
 qYFM43vvIib7cyh17Qa3f7yX5/7BdPLOtU6X+xvEYqfGNr9v9CNWpjur//SGOOkr5e4U
 Bc4JAgh9aKWLsgpSvm+PrJSGsfiK2kTMQvEllMbYU4OBCMq1c+NlOADrLnq/3mwwQtP6
 1asUtgT4C+1CIX+jh8umvKjpkywxQtgGpr55wVBdhfBUAK8EA7UqHDGVyAYQVV/7KYUN
 Rg03n3Qjax2N9t7VEr02m+a9KQvzoNy/ZebBB+uv77xKiaVe3LdYPE9KLtUKj/53NN9A
 jr+A==
X-Gm-Message-State: AOJu0YyrGEPlc80pZ95y1A177JucUSqtRuztMydcNXoUQicoQ9Z0pacq
 PdvEKVg39eutkMOUfoQrR/LAbQnZRhLVdFY5nfgOddzKUNpQnAnXF4KGZ/lHAeKBKxs1zwvshRl
 JY1cUCbI=
X-Gm-Gg: Acq92OHJud2V3AswzfEIeWR4arkWGQdXLPXWuzOvrgI4M03A1eYthfCiPYcqXXXi4Jz
 wMyhkWzdHfUb+ZtqJmoD2f8Ro19t9E5DuPNRXUlhSYlSkr0arKpBFbwmL/D8XbsAQkoTwMb3diA
 UR6e4/fYMGrgXJSSOJF/WQc9jo3eJWXSpGxcT3xNZyupr5IBg29be27+f6uAI/7VP8nDLRMbo4v
 p33YCf2NjDfbICsdSSEoYo9yyB5cbuXAexc08XutM2OXWv0vtO43Vd3b1lc4JdvEzZsIwKj85D+
 Xz98oSkYSyi8woUMsn74aIGmB2upzg1emwu7O3vGB9IecnWhWc9jeEj7B6CL8FjCevaB7Tv8jGO
 u5fHixQ3c73+E5ibe2OK9jn8Iom2k9ZaK5YFl704Ptket7bwk8Z0Ub2r3PgtnZ+/j2w0VACNRUX
 Oi4pMQ4+FsRAEJS4dMVO8JuCsURdKhIa5E+x+afTumokrlFWacPvp0YFhxIV26I861leyoyBFeA
 VX/i43e8aGiKutcXyBYWzOkUwiAi5+U+mL8KZ5EEUw=
X-Received: by 2002:a05:7022:2528:b0:130:6494:dcea with SMTP id
 a92af1059eb24-1342ee3f556mr817726c88.2.1778631992385; 
 Tue, 12 May 2026 17:26:32 -0700 (PDT)
Received: from localhost.localdomain ([207.231.76.218])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8884752ccsm19547827eec.17.2026.05.12.17.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 17:26:31 -0700 (PDT)
From: Aidan Garske <aidan@wolfssl.com>
To: u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, David Garske <david@wolfssl.com>,
 Aidan <aidan@wolfssl.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v4 03/14] spi: add BCM2835/BCM2711 hardware SPI controller
 driver
Date: Tue, 12 May 2026 17:26:07 -0700
Message-ID: <20260513002625.76915-3-aidan@wolfssl.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1778619453.git.aidan@wolfssl.com>
References: <cover.1778619453.git.aidan@wolfssl.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 May 2026 02:26:49 +0200
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

From: Aidan <aidan@wolfssl.com>

The BCM2835/BCM2711 SoC on Raspberry Pi 3/4 has no in-tree U-Boot
driver for its hardware SPI0 controller; existing U-Boot work with
SPI peripherals on these boards has to fall back to GPIO bit-banging
via spi-gpio.  That fallback is functional but slow (a few hundred
kHz versus the 32 MHz the controller supports), and for protocols
like the Infineon SLB9670 / SLB9672 TPM 2.0 TIS interface it makes
early-boot operations (startup, self-test, PCR extend) noticeably
sluggish.

Port the Linux kernel driver drivers/spi/spi-bcm2835.c into U-Boot
so existing device-tree nodes using the "brcm,bcm2835-spi" /
"brcm,bcm2711-spi" compatible work out of the box.  The port keeps
the same register layout and software-GPIO chip-select scheme the
Linux driver already uses, which is necessary to work around the
BCM2835 SPI block's CS auto-deassert behaviour - that behaviour
corrupts multi-byte TPM TIS transactions when hardware CS is left
enabled.

Notable deltas from the Linux driver:
 - DMA, interrupt and slave-mode paths are removed; the U-Boot
   xfer is a synchronous polled loop, which is appropriate for the
   pre-OS context.
 - U-Boot driver-model glue replaces the Linux spi_controller
   bookkeeping.
 - VideoCore 0x7E000000 peripheral addresses present in the BCM2711
   device tree are translated to the ARM-visible 0xFE000000 base.

The first user is the wolfTPM integration on rpi_4_wolftpm_defconfig
with an Infineon SLB9672 TPM HAT, but the driver is not TPM-specific
and any DM_SPI consumer (SPI-NOR flash, SPI EEPROM, etc.) will work
the same way.

Copyright on the ported portions remains with the original Linux
authors (Chris Boot, Stephen Warren, Martin Sperl).

Signed-off-by: Aidan Garske <aidan@wolfssl.com>
---
 drivers/spi/Kconfig       |   9 +
 drivers/spi/Makefile      |   1 +
 drivers/spi/bcm2835_spi.c | 440 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 450 insertions(+)
 create mode 100644 drivers/spi/bcm2835_spi.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 63d61ccf8ed..02ee2b2e6a0 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -116,6 +116,15 @@ config ATMEL_SPI
 	  many AT91 (ARM) chips. This driver can be used to access
 	  the SPI Flash, such as AT25DF321.
 
+config BCM2835_SPI
+	bool "BCM2835/BCM2711 SPI driver"
+	depends on ARCH_BCM283X
+	help
+	  Enable the BCM2835/BCM2711 SPI controller driver. This driver
+	  can be used to access SPI devices on Raspberry Pi boards
+	  including Pi 3 and Pi 4. It uses the hardware SPI controller
+	  rather than GPIO bit-banging.
+
 config BCM63XX_HSSPI
 	bool "BCM63XX HSSPI driver"
 	depends on (ARCH_BMIPS || ARCH_BCMBCA)
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 0dc2d23e172..47a1c6194b1 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_APPLE_SPI) += apple_spi.o
 obj-$(CONFIG_ATH79_SPI) += ath79_spi.o
 obj-$(CONFIG_ATMEL_QSPI) += atmel-quadspi.o
 obj-$(CONFIG_ATMEL_SPI) += atmel_spi.o
+obj-$(CONFIG_BCM2835_SPI) += bcm2835_spi.o
 obj-$(CONFIG_BCM63XX_HSSPI) += bcm63xx_hsspi.o
 obj-$(CONFIG_BCMBCA_HSSPI) += bcmbca_hsspi.o
 obj-$(CONFIG_BCM63XX_SPI) += bcm63xx_spi.o
diff --git a/drivers/spi/bcm2835_spi.c b/drivers/spi/bcm2835_spi.c
new file mode 100644
index 00000000000..b6ac35d37a3
--- /dev/null
+++ b/drivers/spi/bcm2835_spi.c
@@ -0,0 +1,440 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Driver for Broadcom BCM2835/BCM2711 SPI Controllers
+ *
+ * Copyright (C) 2012 Chris Boot
+ * Copyright (C) 2013 Stephen Warren
+ * Copyright (C) 2015 Martin Sperl
+ * Copyright (C) 2026 wolfSSL Inc.
+ *
+ * Ported from the Linux kernel driver drivers/spi/spi-bcm2835.c
+ * (GPL-2.0+) and re-architected for U-Boot's driver model:
+ * hardware chip-select is replaced with software-GPIO chip-select
+ * (which the Linux driver also does, to work around the CS
+ * auto-deassert behaviour of the BCM2835 SPI block during
+ * multi-byte TPM TIS transactions); DMA and interrupt support is
+ * removed; the transfer loop is a synchronous poll suitable for
+ * the U-Boot context.
+ */
+
+#include <dm.h>
+#include <errno.h>
+#include <log.h>
+#include <malloc.h>
+#include <spi.h>
+#include <asm/io.h>
+#include <asm/gpio.h>
+#include <dm/device_compat.h>
+#include <linux/delay.h>
+
+/* SPI register offsets */
+#define BCM2835_SPI_CS      0x00    /* Control and Status */
+#define BCM2835_SPI_FIFO    0x04    /* TX and RX FIFOs */
+#define BCM2835_SPI_CLK     0x08    /* Clock Divider */
+#define BCM2835_SPI_DLEN    0x0c    /* Data Length */
+#define BCM2835_SPI_LTOH    0x10    /* LoSSI mode TOH */
+#define BCM2835_SPI_DC      0x14    /* DMA DREQ Controls */
+
+/* CS register bits */
+#define BCM2835_SPI_CS_LEN_LONG     BIT(25)
+#define BCM2835_SPI_CS_DMA_LEN      BIT(24)
+#define BCM2835_SPI_CS_CSPOL2       BIT(23)
+#define BCM2835_SPI_CS_CSPOL1       BIT(22)
+#define BCM2835_SPI_CS_CSPOL0       BIT(21)
+#define BCM2835_SPI_CS_RXF          BIT(20)
+#define BCM2835_SPI_CS_RXR          BIT(19)
+#define BCM2835_SPI_CS_TXD          BIT(18)
+#define BCM2835_SPI_CS_RXD          BIT(17)
+#define BCM2835_SPI_CS_DONE         BIT(16)
+#define BCM2835_SPI_CS_LEN          BIT(13)
+#define BCM2835_SPI_CS_REN          BIT(12)
+#define BCM2835_SPI_CS_ADCS         BIT(11)
+#define BCM2835_SPI_CS_INTR         BIT(10)
+#define BCM2835_SPI_CS_INTD         BIT(9)
+#define BCM2835_SPI_CS_DMAEN        BIT(8)
+#define BCM2835_SPI_CS_TA           BIT(7)
+#define BCM2835_SPI_CS_CSPOL        BIT(6)
+#define BCM2835_SPI_CS_CLEAR_RX     BIT(5)
+#define BCM2835_SPI_CS_CLEAR_TX     BIT(4)
+#define BCM2835_SPI_CS_CPOL         BIT(3)
+#define BCM2835_SPI_CS_CPHA         BIT(2)
+#define BCM2835_SPI_CS_CS_10        BIT(1)
+#define BCM2835_SPI_CS_CS_01        BIT(0)
+
+/* Default clock rate - 250 MHz for Pi 4 */
+#define BCM2835_SPI_DEFAULT_CLK     250000000
+
+struct bcm2835_spi_priv {
+	void __iomem *regs;
+	u32 clk_hz;
+	u32 cs_reg;         /* Cached CS register value */
+	u32 speed_hz;
+	u8 mode;
+	struct gpio_desc cs_gpio;
+	int cs_gpio_valid;
+	int cs_asserted;    /* Track if CS should stay asserted between transfers */
+};
+
+struct bcm2835_spi_plat {
+	fdt_addr_t base;
+	u32 clk_hz;
+};
+
+static inline u32 bcm2835_spi_readl(struct bcm2835_spi_priv *priv, u32 reg)
+{
+	return readl(priv->regs + reg);
+}
+
+static inline void bcm2835_spi_writel(struct bcm2835_spi_priv *priv,
+									   u32 reg, u32 val)
+{
+	writel(val, priv->regs + reg);
+}
+
+static void bcm2835_spi_reset(struct bcm2835_spi_priv *priv)
+{
+	/* Clear FIFOs and disable SPI */
+	bcm2835_spi_writel(priv, BCM2835_SPI_CS,
+					   BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);
+}
+
+/* GPIO base for software CS control */
+static void __iomem *g_gpio_base = (void __iomem *)0xFE200000;
+
+/* Software CS control - assert (LOW = active) */
+static void bcm2835_spi_cs_assert(int cs_pin)
+{
+	/* GPCLR0 - clear pin (drive LOW) */
+	writel(1 << cs_pin, g_gpio_base + 0x28);
+}
+
+/* Software CS control - deassert (HIGH = inactive) */
+static void bcm2835_spi_cs_deassert(int cs_pin)
+{
+	/* GPSET0 - set pin (drive HIGH) */
+	writel(1 << cs_pin, g_gpio_base + 0x1C);
+}
+
+static int bcm2835_spi_xfer(struct udevice *dev, unsigned int bitlen,
+							const void *dout, void *din, unsigned long flags)
+{
+	struct udevice *bus = dev_get_parent(dev);
+	struct bcm2835_spi_priv *priv = dev_get_priv(bus);
+	const u8 *tx = dout;
+	u8 *rx = din;
+	u32 len = bitlen / 8;
+	u32 cs_reg;
+	u32 tx_count = 0, rx_count = 0;
+	int timeout;
+	int cs = spi_chip_select(dev);  /* Get chip select from slave device */
+	int cs_pin = (cs == 0) ? 8 : 7; /* CS0=GPIO8, CS1=GPIO7 */
+	u32 stat;
+
+	if (bitlen == 0) {
+		/* Handle CS-only operations (deassert) */
+		if (flags & SPI_XFER_END) {
+			bcm2835_spi_cs_deassert(cs_pin);
+			priv->cs_asserted = 0;
+		}
+		return 0;
+	}
+
+	if (bitlen % 8) {
+		dev_err(dev, "Non-byte-aligned transfer not supported\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * SOFTWARE GPIO CHIP SELECT - like Linux driver
+	 * Don't use hardware CS bits - set to 0 (unused)
+	 */
+	cs_reg = priv->cs_reg & ~(BCM2835_SPI_CS_CS_10 | BCM2835_SPI_CS_CS_01);
+
+	/* Assert CS at start of transaction (SPI_XFER_BEGIN) */
+	if (flags & SPI_XFER_BEGIN) {
+		bcm2835_spi_cs_assert(cs_pin);
+		priv->cs_asserted = 1;
+		udelay(1);  /* CS setup time */
+	}
+
+	/* Clear FIFOs for new transaction */
+	if (flags & SPI_XFER_BEGIN) {
+		bcm2835_spi_writel(priv, BCM2835_SPI_CS,
+						   cs_reg | BCM2835_SPI_CS_CLEAR_RX |
+						   BCM2835_SPI_CS_CLEAR_TX);
+		udelay(1);
+	}
+
+	/* Start transfer with TA=1 (but CS is controlled by GPIO, not hardware) */
+	bcm2835_spi_writel(priv, BCM2835_SPI_CS, cs_reg | BCM2835_SPI_CS_TA);
+
+	/* Poll for completion - transfer byte by byte */
+	timeout = 100000;
+	while ((tx_count < len || rx_count < len) && timeout > 0) {
+		stat = bcm2835_spi_readl(priv, BCM2835_SPI_CS);
+
+		/* TX FIFO not full - send next byte */
+		while ((stat & BCM2835_SPI_CS_TXD) && tx_count < len) {
+			u8 byte = tx ? tx[tx_count] : 0;
+
+			bcm2835_spi_writel(priv, BCM2835_SPI_FIFO, byte);
+			tx_count++;
+			stat = bcm2835_spi_readl(priv, BCM2835_SPI_CS);
+		}
+
+		/* RX FIFO has data - read it */
+		while ((stat & BCM2835_SPI_CS_RXD) && rx_count < len) {
+			u8 byte = bcm2835_spi_readl(priv, BCM2835_SPI_FIFO) & 0xff;
+
+			if (rx)
+				rx[rx_count] = byte;
+			rx_count++;
+			stat = bcm2835_spi_readl(priv, BCM2835_SPI_CS);
+		}
+
+		timeout--;
+	}
+
+	/* Wait for DONE */
+	timeout = 10000;
+	while (!(bcm2835_spi_readl(priv, BCM2835_SPI_CS) & BCM2835_SPI_CS_DONE) &&
+		   timeout > 0) {
+		udelay(1);
+		timeout--;
+	}
+
+	/* Read any remaining RX data from FIFO */
+	while (bcm2835_spi_readl(priv, BCM2835_SPI_CS) & BCM2835_SPI_CS_RXD) {
+		u8 byte = bcm2835_spi_readl(priv, BCM2835_SPI_FIFO) & 0xff;
+
+		if (rx && rx_count < len)
+			rx[rx_count++] = byte;
+	}
+
+	/* Clear TA to complete this transfer (doesn't affect GPIO CS) */
+	bcm2835_spi_writel(priv, BCM2835_SPI_CS, cs_reg);
+
+	/*
+	 * SOFTWARE GPIO CHIP SELECT control:
+	 * - SPI_XFER_END: deassert CS (GPIO HIGH)
+	 * - No END flag: keep CS asserted for next transfer
+	 */
+	if (flags & SPI_XFER_END) {
+		bcm2835_spi_cs_deassert(cs_pin);
+		priv->cs_asserted = 0;
+	} else {
+		/* Keep CS asserted for next transfer (e.g., wait state polling) */
+		priv->cs_asserted = 1;
+	}
+
+	if (timeout == 0) {
+		bcm2835_spi_cs_deassert(cs_pin);  /* Make sure CS is released */
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int bcm2835_spi_set_speed(struct udevice *bus, uint speed)
+{
+	struct bcm2835_spi_priv *priv = dev_get_priv(bus);
+	u32 cdiv;
+
+	if (speed == 0)
+		speed = 1000000;  /* Default 1 MHz */
+
+	priv->speed_hz = speed;
+
+	/* Calculate clock divider */
+	if (speed >= priv->clk_hz / 2) {
+		cdiv = 2;  /* Fastest possible */
+	} else {
+		cdiv = (priv->clk_hz + speed - 1) / speed;
+		cdiv += (cdiv & 1);  /* Must be even */
+		if (cdiv >= 65536)
+			cdiv = 0;  /* Slowest: clk/65536 */
+	}
+
+	bcm2835_spi_writel(priv, BCM2835_SPI_CLK, cdiv);
+
+	return 0;
+}
+
+static int bcm2835_spi_set_mode(struct udevice *bus, uint mode)
+{
+	struct bcm2835_spi_priv *priv = dev_get_priv(bus);
+	u32 cs_reg = 0;
+
+	priv->mode = mode;
+
+	/* Set clock polarity and phase */
+	if (mode & SPI_CPOL)
+		cs_reg |= BCM2835_SPI_CS_CPOL;
+	if (mode & SPI_CPHA)
+		cs_reg |= BCM2835_SPI_CS_CPHA;
+
+	/* CS bits will be set in xfer based on slave's chip select */
+	priv->cs_reg = cs_reg;
+
+	return 0;
+}
+
+static int bcm2835_spi_claim_bus(struct udevice *dev)
+{
+	return 0;
+}
+
+static int bcm2835_spi_release_bus(struct udevice *dev)
+{
+	return 0;
+}
+
+/* Setup GPIO pins for SPI0 with SOFTWARE chip select */
+static void bcm2835_spi_setup_gpio(void)
+{
+	u32 val;
+
+	/*
+	 * SPI0 pin configuration:
+	 * GPIO7  (CE1)  - OUTPUT (software CS) - GPFSEL0 bits 23:21 = 001
+	 * GPIO8  (CE0)  - OUTPUT (software CS) - GPFSEL0 bits 26:24 = 001
+	 * GPIO9  (MISO) - ALT0 (SPI)           - GPFSEL0 bits 29:27 = 100
+	 * GPIO10 (MOSI) - ALT0 (SPI)           - GPFSEL1 bits 2:0   = 100
+	 * GPIO11 (SCLK) - ALT0 (SPI)           - GPFSEL1 bits 5:3   = 100
+	 */
+
+	/* Set GPIO7, GPIO8 to OUTPUT, GPIO9 to ALT0 in GPFSEL0 */
+	val = readl(g_gpio_base + 0x00);
+	val &= ~((7 << 21) | (7 << 24) | (7 << 27));  /* Clear GPIO7,8,9 */
+	val |= (1 << 21);   /* GPIO7 = OUTPUT (001) */
+	val |= (1 << 24);   /* GPIO8 = OUTPUT (001) */
+	val |= (4 << 27);   /* GPIO9 = ALT0 (100) for MISO */
+	writel(val, g_gpio_base + 0x00);
+
+	/* Set GPIO10, GPIO11 to ALT0 in GPFSEL1 */
+	val = readl(g_gpio_base + 0x04);
+	val &= ~((7 << 0) | (7 << 3));  /* Clear GPIO10,11 */
+	val |= (4 << 0);    /* GPIO10 = ALT0 (100) for MOSI */
+	val |= (4 << 3);    /* GPIO11 = ALT0 (100) for SCLK */
+	writel(val, g_gpio_base + 0x04);
+
+	/* Deassert both CS lines (HIGH = inactive) */
+	bcm2835_spi_cs_deassert(7);  /* CE1 */
+	bcm2835_spi_cs_deassert(8);  /* CE0 */
+}
+
+/* TPM Reset via GPIO4 and GPIO24 */
+static void bcm2835_spi_tpm_reset(void)
+{
+	void __iomem *gpio_base = (void __iomem *)0xFE200000;
+	u32 val;
+
+	/* Set GPIO4 as output (GPFSEL0, bits 14:12) */
+	val = readl(gpio_base + 0x00);  /* GPFSEL0 */
+	val &= ~(7 << 12);  /* Clear bits 14:12 for GPIO4 */
+	val |= (1 << 12);   /* Set to output */
+	writel(val, gpio_base + 0x00);
+
+	/* Set GPIO24 as output (GPFSEL2, bits 14:12) */
+	val = readl(gpio_base + 0x08);  /* GPFSEL2 */
+	val &= ~(7 << 12);  /* Clear bits 14:12 for GPIO24 */
+	val |= (1 << 12);   /* Set to output */
+	writel(val, gpio_base + 0x08);
+
+	/* Assert reset on BOTH pins (LOW) */
+	writel((1 << 4) | (1 << 24), gpio_base + 0x28);  /* GPCLR0 */
+	mdelay(100);
+
+	/* Release reset on BOTH pins (HIGH) */
+	writel((1 << 4) | (1 << 24), gpio_base + 0x1C);  /* GPSET0 */
+	mdelay(150);  /* Wait for TPM to initialize */
+}
+
+static int bcm2835_spi_probe(struct udevice *bus)
+{
+	struct bcm2835_spi_plat *plat = dev_get_plat(bus);
+	struct bcm2835_spi_priv *priv = dev_get_priv(bus);
+	int ret;
+
+	priv->regs = (void __iomem *)plat->base;
+	priv->clk_hz = plat->clk_hz ? plat->clk_hz : BCM2835_SPI_DEFAULT_CLK;
+
+	/* Setup GPIO pins for SPI0 (ALT0 function) */
+	bcm2835_spi_setup_gpio();
+
+	/* Reset TPM before using SPI */
+	bcm2835_spi_tpm_reset();
+
+	/* Try to get CS GPIO from device tree */
+	ret = gpio_request_by_name(bus, "cs-gpios", 0, &priv->cs_gpio,
+				   GPIOD_IS_OUT | GPIOD_ACTIVE_LOW);
+	if (!ret) {
+		priv->cs_gpio_valid = 1;
+		/* Deassert CS initially */
+		dm_gpio_set_value(&priv->cs_gpio, 1);
+	} else {
+		priv->cs_gpio_valid = 0;
+	}
+
+	/* Reset the SPI controller */
+	bcm2835_spi_reset(priv);
+
+	/* Set default speed and mode */
+	bcm2835_spi_set_speed(bus, 1000000);  /* 1 MHz default */
+	bcm2835_spi_set_mode(bus, SPI_MODE_0);
+
+	return 0;
+}
+
+static int bcm2835_spi_of_to_plat(struct udevice *bus)
+{
+	struct bcm2835_spi_plat *plat = dev_get_plat(bus);
+	fdt_addr_t addr;
+
+	addr = dev_read_addr(bus);
+	if (addr == FDT_ADDR_T_NONE) {
+		dev_err(bus, "Failed to get SPI base address\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * On BCM2711 (Pi 4), the device tree often uses VideoCore bus addresses
+	 * which start with 0x7E. The ARM needs to access these via the ARM
+	 * peripheral base at 0xFE000000.
+	 */
+	if ((addr & 0xFF000000) == 0x7E000000)
+		addr = (addr & 0x00FFFFFF) | 0xFE000000;
+
+	plat->base = addr;
+
+	/* Try to get clock rate from device tree */
+	plat->clk_hz = dev_read_u32_default(bus, "clock-frequency",
+					     BCM2835_SPI_DEFAULT_CLK);
+
+	return 0;
+}
+
+static const struct dm_spi_ops bcm2835_spi_ops = {
+	.claim_bus      = bcm2835_spi_claim_bus,
+	.release_bus    = bcm2835_spi_release_bus,
+	.xfer           = bcm2835_spi_xfer,
+	.set_speed      = bcm2835_spi_set_speed,
+	.set_mode       = bcm2835_spi_set_mode,
+};
+
+static const struct udevice_id bcm2835_spi_ids[] = {
+	{ .compatible = "brcm,bcm2835-spi" },
+	{ .compatible = "brcm,bcm2711-spi" },
+	{ }
+};
+
+U_BOOT_DRIVER(bcm2835_spi) = {
+	.name           = "bcm2835_spi",
+	.id             = UCLASS_SPI,
+	.of_match       = bcm2835_spi_ids,
+	.ops            = &bcm2835_spi_ops,
+	.of_to_plat     = bcm2835_spi_of_to_plat,
+	.plat_auto      = sizeof(struct bcm2835_spi_plat),
+	.priv_auto      = sizeof(struct bcm2835_spi_priv),
+	.probe          = bcm2835_spi_probe,
+};
-- 
2.49.0

