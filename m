Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F3CCA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 15:31:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1221A8304F;
	Tue, 12 Aug 2025 17:31:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=yngvason.is
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=yngvason.is header.i=@yngvason.is header.b="kKazgsFx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A48F834EC; Tue, 12 Aug 2025 17:31:03 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB98682CEA
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 17:31:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=yngvason.is
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andri@yngvason.is
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3b78d729bb8so3261081f8f.0
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 08:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=yngvason.is; s=google; t=1755012660; x=1755617460; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fPGeN+AVQf668gwgTd5KTPLPpjVM+ryoS8GNCBtU2lk=;
 b=kKazgsFxoytnjwh5ixjJ9HN4aNxFsxv6Ev8QLK/TbhvZK/ArzCXmyE5qAEiw3dz/qa
 s1j/7NxHLcB56BHOzmv8us+AGNut0ER5xhzww2bg4bpMFelxk12N/tjirOTRs6CNsc4J
 o4aizxp+ofjugqgA8zipe4OnjUViYzsCyVjKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755012660; x=1755617460;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fPGeN+AVQf668gwgTd5KTPLPpjVM+ryoS8GNCBtU2lk=;
 b=SghtP5FS+qvubI9gBn3jvgtZgUVb2EHrv6iSCDmMRGNY8woeYAncy0tMlr1oPEXKEb
 Sd1zdUIL0qwd7Ghv2dhhR59G5XgOBVAJqYOnbPx6EUlnZSiY2h28htf1Z6efzYf+uObS
 vMAJZBdO6gzUF1ldyZR9O2rqUQ3S7+oHiJkArawDEUppXYdGBH0qHvb0a35upo6mibVa
 B8e4kjaXLDQ3KBqrV1K/KyO/dNGbB2QPFua1TLcr8Gv6SvyygSqhCExf8wMxznWEHL2l
 5LqyGbg15teW2VZd3+gSt4J3VUrbcReTwBsYvm0idN/fVbOOXFE4kGuy7uPjrIJn9pyr
 5zTg==
X-Gm-Message-State: AOJu0YxSkkps0KNJuAOkBEt6r9pyWpOBdPUuQWPrFKls0O8GhD7T3Pve
 v0phOpyRNP9FuUmBz/Zdc8jpdfba1NX1kbfR0UwrmEZaMdUe+0NTbN6fBi7vD/pjSLbJUz+U4ER
 ywY4q
X-Gm-Gg: ASbGncs8VBvRmBNQ/ehQXeLno1ye5VtzXGJF8IVTou8fEOsHuiUXtdQnepZ8aLHwRvx
 EUcvAIrseDWG4ph5vRBv3ziM8IxorHFZqnvF0vm593uPSCk7QqM+UVypuOb31Ru7U3HbtVVs/yK
 /TJE7jbUyNIkVoc3Q/s2Pr0zGCzU9iNPK20fdqIaarLq7O534QdgOgCwrVFapBAAtz7X5v7arGQ
 PTOqPZ5vjOVK/Bmc0cPIWPyRX7xKjlvfyDLNj59Zw6qDYaeVWJs48ts6cy57nzUWCom0BXt72dh
 8BKCYRyelhfDB7aJM2QBp9t+K3x/ABHR3wr+plvfRG1e8Mu2/sX41F0fHYsGhOfXSUYNmskLJYc
 roT4LTrcp1UGq20JjBjGwlNYRKF73WMKE/qdNgrNEkFAYvBjsDr5uTwW5eP0=
X-Google-Smtp-Source: AGHT+IHZxJmVVv7bewxS1D+t1fuENYqrNYSDbLFAdlM4Y27yQQaI/AxZNBTfS1jR4ZRcjFW0cGWy1w==
X-Received: by 2002:a05:6000:25c8:b0:3b8:d30c:885f with SMTP id
 ffacd0b85a97d-3b900b80c45mr13071052f8f.53.1755012660087; 
 Tue, 12 Aug 2025 08:31:00 -0700 (PDT)
Received: from andri-workstation.turninn.appdynamic.com
 ([2a01:8280:aa07:ad:7285:c2ff:fef0:4baf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c485444sm45171091f8f.66.2025.08.12.08.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 08:30:59 -0700 (PDT)
From: Andri Yngvason <andri@yngvason.is>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Andri Yngvason <andri@yngvason.is>
Subject: [PATCH] drivers: led: Add WS28XX compatible LED driver
Date: Tue, 12 Aug 2025 15:30:18 +0000
Message-ID: <20250812153048.2775200-1-andri@yngvason.is>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This is a new LED driver for the WS28XX family of LED controllers from
Worldsemi and compatible devices from other manufacturers.

The LED chain must be connected to an SPI output. This driver uses SPI
to emulate the required digital signal.

Each LED gets a fixed colour assigned to it in the device tree.

Signed-off-by: Andri Yngvason <andri@yngvason.is>
---
 doc/device-tree-bindings/leds/leds-ws28xx.txt |  48 ++++
 drivers/led/Kconfig                           |   8 +
 drivers/led/Makefile                          |   1 +
 drivers/led/led_ws28xx.c                      | 233 ++++++++++++++++++
 4 files changed, 290 insertions(+)
 create mode 100644 doc/device-tree-bindings/leds/leds-ws28xx.txt
 create mode 100644 drivers/led/led_ws28xx.c

diff --git a/doc/device-tree-bindings/leds/leds-ws28xx.txt b/doc/device-tree-bindings/leds/leds-ws28xx.txt
new file mode 100644
index 00000000000..8c72c81fd55
--- /dev/null
+++ b/doc/device-tree-bindings/leds/leds-ws28xx.txt
@@ -0,0 +1,48 @@
+WS28XX compatible LEDs connected to SPI
+
+Required properties:
+- compatible: Must be "ws28xx-leds".
+- reg: SPI chip-select is unused, but should be set to <0>.
+
+Optional properties:
+- red-offset: The offset of the red colour component (default 0).
+- green-offset: The offset of the green colour component (default 8).
+- blue-offset: The offset of the blue colour component (default 16).
+- white-offset: The offset of the white colour component (disabled by default).
+- reset-period: Communication reset period in microseconds (default 50).
+
+The offsets are expressed in bits as they are sent out on the wire. E.g. if
+red-offset = <0> and green-offset = <8>, then red is sent first and then green.
+
+Each LED is represented as a sub-node of the ws28xx-leds device. Each node's
+name represents the name of the corresponding LED. Multiple LEDs can be chained
+and each LED is represented by a sub-node in the device tree in the same order
+as in the chain.
+
+Optional LED sub-node properties:
+- red: Brightness of the red colour component (0 - 255, default 0).
+- green: Brightness of the green colour component (0 - 255, default 0).
+- blue: Brightness of the blue colour component (0 - 255, default 0).
+- white: Brightness of the white colour component (0 - 255, default 0).
+
+Example:
+
+&spi0 {
+	status = "okay";
+
+	leds {
+		red-offset = <0>;
+		green-offset = <16>;
+		blue-offset = <8>;
+
+		red-led {
+			red = <127>;
+			default-state = "on";
+		};
+
+		green-led {
+			green = <127>;
+			default-state = "on";
+		};
+	};
+};
diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
index c98cbf92fab..4f711657ae0 100644
--- a/drivers/led/Kconfig
+++ b/drivers/led/Kconfig
@@ -88,6 +88,13 @@ config LED_PWM
 	  Enable support for LEDs connected to PWM.
 	  Linux compatible ofdata.
 
+config LED_WS28XX
+	bool "LED WS28XX"
+	depends on LED && DM_SPI
+	help
+	  Enable support for WS2811, WS2812 and other compatible LEDS
+	  controlled over SPI.
+
 config LED_BLINK
 	bool "Support hardware LED blinking"
 	depends on LED
@@ -142,6 +149,7 @@ config LED_STATUS
 	  Allows common u-boot commands to use a board's leds to
 	  provide status for activities like booting and downloading files.
 
+
 if LED_STATUS
 
 # Hidden constants
diff --git a/drivers/led/Makefile b/drivers/led/Makefile
index 996753b88ae..2b42b6eb9f7 100644
--- a/drivers/led/Makefile
+++ b/drivers/led/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_LED_PWM) += led_pwm.o
 obj-$(CONFIG_$(PHASE_)LED_GPIO) += led_gpio.o
 obj-$(CONFIG_LED_CORTINA) += led_cortina.o
 obj-$(CONFIG_LED_LP5562) += led_lp5562.o
+obj-$(CONFIG_LED_WS28XX) += led_ws28xx.o
diff --git a/drivers/led/led_ws28xx.c b/drivers/led/led_ws28xx.c
new file mode 100644
index 00000000000..a311a35dc88
--- /dev/null
+++ b/drivers/led/led_ws28xx.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) App Dynamic ehf.
+ * Written by Andri Yngvason <andri@yngvason.is>
+ *
+ * LED controllers in the WS28XX family from Worldsemi are controlled using a
+ * digital signal transmitted via a single wire. Multiple devices can be
+ * chained, in which case the first device will pass on extraneous data to the
+ * second device, second to third, and so on.
+ *
+ * Each bit in the digital signal is represented by a particular wave form. The
+ * bit period is 2.5 µs +/- 0.3 µs (400 kb/s).
+ *
+ * To represent 0, the signal goes high for 0.5 µs and then back low for the
+ * remainder of the bit period.
+ *
+ * To represent 1, the signal goes high for 1.2 µs and then back low for the
+ * remainder of the bit period.
+ *
+ * If the signal remains low for 50 µs or more, the device will reset
+ * communication and start receiving the next signal as if it were the first
+ * signal received.
+ *
+ * Bit-banging this waveform would be sub-optimal, but there is enough
+ * precision within half a byte of data transmitted over SPI to generate these
+ * waveforms so that they meet the specified timing constraints.
+ *
+ * The required data rate is 4 * 400 kb/s = 1.6 Mb/s, but the SPI clock
+ * frequency is twice that, or 3.2 MHz.
+ *
+ * Now, 0 can be represented using 8, which yields a duty period of 2.5 µs / 4
+ * = 0.6 µs, which is close enough, and 1 can be represented using 0xc, which
+ * yields a duty period of 2.5 µs / 2 = 1.25 µs, which is fits within the error
+ * margin.
+ */
+
+#include <dm.h>
+#include <errno.h>
+#include <led.h>
+#include <log.h>
+#include <malloc.h>
+#include <spi.h>
+#include <linux/delay.h>
+
+#define LEDS_WS28XX_DRIVER_NAME	"led_ws28xx"
+#define WS28XX_SPI_CLOCK 3200000
+#define LEDS_WS28XX_MIN_RESET_PERIOD_DEFAULT 50 /* µs */
+
+struct led_ws28xx_priv {
+	bool on;
+};
+
+struct led_ws28xx_plat {
+	u8 r, g, b, w;
+};
+
+struct led_ws28xx_wrap_plat {
+	bool have_white;
+	u8 r_off, g_off, b_off, w_off;
+	u32 reset_period;
+};
+
+static void byte_pattern_from_value(u8 *dst, u8 value)
+{
+	for (int i = 0; i < 8; i += 2) {
+		dst[i / 2] = (value & BIT(7 - i)) ? 0xc0 : 0x80;
+		dst[i / 2] |= (value & BIT(6 - i)) ? 0xc : 0x8;
+	}
+}
+
+static void ws28xx_spi_payload_from_led(u8 *payload,
+					struct led_ws28xx_wrap_plat *wrap,
+					struct udevice *dev)
+{
+	struct led_ws28xx_priv *priv = dev_get_priv(dev);
+	struct led_ws28xx_plat *plat = dev_get_plat(dev);
+	u8 r = 0, g = 0, b = 0, w = 0;
+
+	if (priv && priv->on) {
+		r = plat->r;
+		g = plat->g;
+		b = plat->b;
+		w = plat->w;
+	}
+
+	byte_pattern_from_value(payload + wrap->r_off / 2, r);
+	byte_pattern_from_value(payload + wrap->g_off / 2, g);
+	byte_pattern_from_value(payload + wrap->b_off / 2, b);
+
+	if (wrap->have_white)
+		byte_pattern_from_value(payload + wrap->w_off / 2, w);
+}
+
+static int led_ws28xx_commit(struct udevice *dev)
+{
+	struct led_ws28xx_wrap_plat *plat = dev_get_plat(dev);
+	int n_leds = device_get_child_count(dev);
+	int bytes_per_bit = 2;
+	int bits_per_led = plat->have_white ? 32 : 24;
+	int bytes_per_led = bits_per_led / bytes_per_bit;
+	int payload_size = n_leds * bytes_per_led;
+	struct udevice *child;
+	u8 *payload;
+	int pos = 0;
+	int ret;
+
+	payload = malloc(payload_size);
+	if (!payload)
+		return -ENOMEM;
+
+	device_foreach_child(child, dev) {
+		ws28xx_spi_payload_from_led(payload + pos, plat, child);
+		pos += bytes_per_led;
+	}
+
+	dm_spi_claim_bus(dev);
+	ret = dm_spi_xfer(dev, payload_size * 8, payload, NULL, SPI_XFER_ONCE);
+	dm_spi_release_bus(dev);
+
+	free(payload);
+
+	udelay(plat->reset_period);
+
+	return ret;
+}
+
+static int led_ws28xx_set_state(struct udevice *dev, enum led_state_t state)
+{
+	struct led_ws28xx_priv *priv = dev_get_priv(dev);
+
+	switch (state) {
+	case LEDST_OFF:
+		priv->on = false;
+		break;
+	case LEDST_ON:
+		priv->on = true;
+		break;
+	case LEDST_TOGGLE:
+		priv->on = !priv->on;
+		break;
+	default:
+		return -ENOSYS;
+	}
+
+	return led_ws28xx_commit(dev_get_parent(dev));
+}
+
+static enum led_state_t led_ws28xx_get_state(struct udevice *dev)
+{
+	struct led_ws28xx_priv *priv = dev_get_priv(dev);
+
+	return priv->on ? LEDST_ON : LEDST_OFF;
+}
+
+static int led_ws28xx_of_to_plat(struct udevice *dev)
+{
+	struct led_ws28xx_plat *plat = dev_get_plat(dev);
+
+	plat->r = dev_read_u32_default(dev, "red", 0);
+	plat->g = dev_read_u32_default(dev, "green", 0);
+	plat->b = dev_read_u32_default(dev, "blue", 0);
+	plat->w = dev_read_u32_default(dev, "white", 0);
+
+	return 0;
+}
+
+static const struct led_ops led_ws28xx_ops = {
+	.set_state = led_ws28xx_set_state,
+	.get_state = led_ws28xx_get_state,
+};
+
+U_BOOT_DRIVER(led_ws28xx) = {
+	.name = LEDS_WS28XX_DRIVER_NAME,
+	.id = UCLASS_LED,
+	.ops = &led_ws28xx_ops,
+	.plat_auto = sizeof(struct led_ws28xx_plat),
+	.priv_auto = sizeof(struct led_ws28xx_priv),
+	.of_to_plat = led_ws28xx_of_to_plat,
+};
+
+static int led_ws28xx_wrap_of_to_plat(struct udevice *dev)
+{
+	struct led_ws28xx_wrap_plat *plat = dev_get_plat(dev);
+	u32 w_off;
+
+	plat->r_off = dev_read_u32_default(dev, "red-offset", 0);
+	plat->g_off = dev_read_u32_default(dev, "green-offset", 8);
+	plat->b_off = dev_read_u32_default(dev, "blue-offset", 16);
+	plat->have_white = dev_read_u32(dev, "white-offset", &w_off) == 0;
+	plat->w_off = w_off;
+	plat->reset_period = dev_read_u32_default(dev, "reset-period",
+						  LEDS_WS28XX_MIN_RESET_PERIOD_DEFAULT);
+
+	return 0;
+}
+
+static int led_ws28xx_wrap_probe(struct udevice *dev)
+{
+	struct spi_slave *spi;
+	struct udevice *bus = dev->parent;
+
+	if (bus->uclass->uc_drv->id != UCLASS_SPI) {
+		log_err(LEDS_WS28XX_DRIVER_NAME " must be an SPI slave\n");
+		return -EOPNOTSUPP;
+	}
+
+	spi = dev_get_parent_priv(dev);
+	spi->max_hz = WS28XX_SPI_CLOCK;
+	spi->mode = SPI_MODE_0;
+	spi->wordlen = 8;
+
+	return 0;
+}
+
+static int led_ws28xx_bind(struct udevice *parent)
+{
+	return led_bind_generic(parent, LEDS_WS28XX_DRIVER_NAME);
+}
+
+static const struct udevice_id led_ws28xx_ids[] = {
+	{ .compatible = "ws28xx-leds" },
+	{ }
+};
+
+U_BOOT_DRIVER(led_pwm_wrap) = {
+	.name = LEDS_WS28XX_DRIVER_NAME "_wrap",
+	.id = UCLASS_NOP,
+	.of_match = led_ws28xx_ids,
+	.plat_auto = sizeof(struct led_ws28xx_wrap_plat),
+	.of_to_plat = led_ws28xx_wrap_of_to_plat,
+	.probe = led_ws28xx_wrap_probe,
+	.bind = led_ws28xx_bind,
+};
-- 
2.50.0

