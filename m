Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63653C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 17:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DABE9810ED;
	Wed, 26 Feb 2025 18:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KySIDIKv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53BC980FD4; Wed, 26 Feb 2025 18:33:02 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE35B80F12
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 18:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e573136107bso6108314276.3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 09:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740591178; x=1741195978; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IhJeQEM6dWj9o82rNFdWXBQ/GRMxMwNMwC14QadTBBg=;
 b=KySIDIKv50j6urKope04J7RJ+8X/7awBiz/lZhtZBEwlz9Cu1ZuAdg0bb3dgOGTGHj
 mIglI8JWHnwkn89OHClsfIGK0rlq1m4HF3KvENJlsAnk3VUM6CtTqLd38b+lgkHc0/pY
 8viaGaWIk4R60yQMP99AE2OiYKEUvcf+HJUyWtn7QuZes4HnhpQSUFCKdX80v3ga5s51
 8+KuSdDHilBPKE+H2sqA3gZMETle44CcXNpcNkdIdqfCSvwU/zFALcVRJ+TmWZKHVKul
 n4cCNAMeb+wq1h6bFyMnwHaj49nIaXzX2MBqRvjUdWk89MfcpzN0futiMoMPRfN4GjRQ
 XF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740591178; x=1741195978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IhJeQEM6dWj9o82rNFdWXBQ/GRMxMwNMwC14QadTBBg=;
 b=sjaGWRSwTmaQwbaGVTeAtofIpEqaCzj01frGBtLio3rik8spH3OFEZSNYjjI5GTtRq
 uUSIw1G2FL+OR4ouACzsUHjQChUNLANF3hX6ehvoGdy1MnqXvAdNelroG/I70GHRyPTe
 zn5nnHkXY8gtB2auy52JKO0PSZvWaOaIdY2MnTxX+RiBpw8BcEocSyA9TrRJoCppaGQI
 r1iptelY0qvpkb73OlEeAXpG7yb3NOOdoSHmqV7d1+KjQ6qQw3mhSkUuRIZxqGsGdG7+
 Y/9A0+MbQm2l13XC7HMmlCjaN6G9c6NIGFxiyNyAlQF7CHnfDtw1QKDEhubOsKZf8X57
 SQzA==
X-Gm-Message-State: AOJu0YwYt+fdHZTtXNOVFyAHoaquqOpAyFxss+zYVIPKrP5pbeCjMrM5
 faHDcv0d9J8AozboqERs06eDRWSUMTkzY90+mKPJgr5GZL0+B1RAJsy2h2g=
X-Gm-Gg: ASbGncuYGKJin/SdurwyIfAKl7DfCMUbCaP+nnQkdfYLXmiQPv4calCpg7vXeeoVYK0
 d2kZe3m1q5IxDk243X3+Qu5fmUXTNcXNUlk5EKwH0cgR7CA4b+jk30BAGBrW2m2NTeC2oxasexQ
 d4M836uhFMk5qAdRkJ8pM4L/79so3qxzZv/sfZY94268W4Z4OcwH+zUbPnXcV01H3U7qI/e5Gzd
 i8QMO+VMRMza+1DKcU+tZ8DOcClITOElgt8vlUSiejapV0oyBd2zj2jXDDuGgnhTPGBKmxjTYBy
 ZNkOiqjxkKDUS3akpPMPGBUqUlFIlHgVxioJB3absxxpDhmqCxp/luvpbXxu
X-Google-Smtp-Source: AGHT+IH7ztut4dAsPldq94670ZIbpJUZgr8Al0+tOpGTGJ7w/2LLcae1LFoEeyECedvNV/3P/MMdtA==
X-Received: by 2002:a05:6902:2708:b0:e5d:d512:1d76 with SMTP id
 3f1490d57ef6-e608a6cfff4mr4252380276.27.1740591178269; 
 Wed, 26 Feb 2025 09:32:58 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e607b40d227sm1067620276.31.2025.02.26.09.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 09:32:57 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com, Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>, Jim Liu <jim.t90615@gmail.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH v3 03/12] gpio: Add support for SC5XX-family processor GPIO
 driver
Date: Wed, 26 Feb 2025 12:30:25 -0500
Message-ID: <20250226173150.13198-4-malysagreg@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250226173150.13198-1-malysagreg@gmail.com>
References: <20250226173150.13198-1-malysagreg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Feb 2025 18:58:54 +0100
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

This adds support for using the GPIO pins on the SC5XX family of SoCs
from Analog Devices.

Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Co-developed-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
Signed-off-by: Greg Malysa <malysagreg@gmail.com>
---

(no changes since v1)

 MAINTAINERS                  |   1 +
 drivers/gpio/Kconfig         |   9 ++
 drivers/gpio/Makefile        |   1 +
 drivers/gpio/gpio-adi-adsp.c | 179 +++++++++++++++++++++++++++++++++++
 4 files changed, 190 insertions(+)
 create mode 100644 drivers/gpio/gpio-adi-adsp.c

diff --git a/MAINTAINERS b/MAINTAINERS
index abdb418b599..5c16c8f6646 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -632,6 +632,7 @@ F:	doc/device-tree-bindings/clock/adi,sc5xx-clocks.yaml
 F:	doc/device-tree-bindings/pinctrl/adi,adsp-pinctrl.yaml
 F:	doc/device-tree-bindings/timer/adi,sc5xx-gptimer.yaml
 F:	drivers/clk/adi/
+F:	drivers/gpio/gpio-adi-adsp.c
 F:	drivers/pinctrl/pinctrl-adi-adsp.c
 F:	drivers/serial/serial_adi_uart4.c
 F:	drivers/timer/adi_sc5xx_timer.c
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index f4a453e1cdd..00b01f5f09e 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -97,6 +97,15 @@ config SPL_DM_GPIO_LOOKUP_LABEL
 	  different gpios on different hardware versions
 	  for the same functionality in board code.
 
+config ADI_GPIO
+	bool "ADI GPIO driver"
+	depends on DM_GPIO && ARCH_SC5XX
+	help
+	  This driver supports GPIO banks on SC5xx processors. It
+	  supports inputs and outputs but does not support pin
+	  interrupt functionality (PINT) or other features in the
+	  Linux version of the driver.
+
 config ALTERA_PIO
 	bool "Altera PIO driver"
 	depends on DM_GPIO
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 3f882c065d8..e25ede1813c 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_$(PHASE_)DM_GPIO) += gpio-uclass.o
 
 obj-$(CONFIG_$(XPL_)DM_PCA953X)	+= pca953x_gpio.o
 
+obj-$(CONFIG_ADI_GPIO)		+= gpio-adi-adsp.o
 obj-$(CONFIG_ASPEED_GPIO)	+= gpio-aspeed.o
 obj-$(CONFIG_ASPEED_G7_GPIO)	+= gpio-aspeed-g7.o
 obj-$(CONFIG_ASPEED_SGPIO)	+= gpio-aspeed-sgpio.o
diff --git a/drivers/gpio/gpio-adi-adsp.c b/drivers/gpio/gpio-adi-adsp.c
new file mode 100644
index 00000000000..0ce00572e08
--- /dev/null
+++ b/drivers/gpio/gpio-adi-adsp.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Author: Greg Malysa <greg.malysa@timesys.com>
+ * Additional Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ */
+
+#include <dm.h>
+#include <asm-generic/gpio.h>
+#include <dm/device_compat.h>
+#include <linux/bitops.h>
+#include <linux/io.h>
+
+#define ADSP_PORT_MMIO_SIZE		0x80
+#define ADSP_PORT_PIN_SIZE		16
+
+#define ADSP_PORT_REG_FER			0x00
+#define ADSP_PORT_REG_FER_SET		0x04
+#define ADSP_PORT_REG_FER_CLEAR		0x08
+#define ADSP_PORT_REG_DATA			0x0c
+#define ADSP_PORT_REG_DATA_SET		0x10
+#define ADSP_PORT_REG_DATA_CLEAR	0x14
+#define ADSP_PORT_REG_DIR			0x18
+#define ADSP_PORT_REG_DIR_SET		0x1c
+#define ADSP_PORT_REG_DIR_CLEAR		0x20
+#define ADSP_PORT_REG_INEN			0x24
+#define ADSP_PORT_REG_INEN_SET		0x28
+#define ADSP_PORT_REG_INEN_CLEAR	0x2c
+#define ADSP_PORT_REG_PORT_MUX		0x30
+#define ADSP_PORT_REG_DATA_TGL		0x34
+#define ADSP_PORT_REG_POLAR			0x38
+#define ADSP_PORT_REG_POLAR_SET		0x3c
+#define ADSP_PORT_REG_POLAR_CLEAR	0x40
+#define ADSP_PORT_REG_LOCK			0x44
+#define ADSP_PORT_REG_TRIG_TGL		0x48
+
+struct adsp_gpio_priv {
+	void __iomem *base;
+	int ngpio;
+};
+
+static u32 get_port(unsigned int pin)
+{
+	return pin / ADSP_PORT_PIN_SIZE;
+}
+
+static u32 get_offset(unsigned int pin)
+{
+	return pin % ADSP_PORT_PIN_SIZE;
+}
+
+static int adsp_gpio_input(struct udevice *udev, unsigned int pin)
+{
+	struct adsp_gpio_priv *priv = dev_get_priv(udev);
+	u32 port, offset;
+	void __iomem *portbase;
+
+	if (pin < priv->ngpio) {
+		port = get_port(pin);
+		offset = get_offset(pin);
+		portbase = priv->base + port * ADSP_PORT_MMIO_SIZE;
+
+		iowrite16(BIT(offset), portbase + ADSP_PORT_REG_FER_CLEAR);
+		iowrite16(BIT(offset), portbase + ADSP_PORT_REG_DIR_CLEAR);
+		iowrite16(BIT(offset), portbase + ADSP_PORT_REG_INEN_SET);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int adsp_gpio_output(struct udevice *udev, unsigned int pin, int value)
+{
+	struct adsp_gpio_priv *priv = dev_get_priv(udev);
+	u32 port, offset;
+	void __iomem *portbase;
+
+	if (pin < priv->ngpio) {
+		port = get_port(pin);
+		offset = get_offset(pin);
+		portbase = priv->base + port * ADSP_PORT_MMIO_SIZE;
+
+		iowrite16(BIT(offset), portbase + ADSP_PORT_REG_FER_CLEAR);
+
+		if (value)
+			iowrite16(BIT(offset), portbase + ADSP_PORT_REG_DATA_SET);
+		else
+			iowrite16(BIT(offset), portbase + ADSP_PORT_REG_DATA_CLEAR);
+
+		iowrite16(BIT(offset), portbase + ADSP_PORT_REG_DIR_SET);
+		iowrite16(BIT(offset), portbase + ADSP_PORT_REG_INEN_CLEAR);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int adsp_gpio_get_value(struct udevice *udev, unsigned int pin)
+{
+	struct adsp_gpio_priv *priv = dev_get_priv(udev);
+	u32 port, offset;
+	u16 val;
+	void __iomem *portbase;
+
+	if (pin < priv->ngpio) {
+		port = get_port(pin);
+		offset = get_offset(pin);
+		portbase = priv->base + port * ADSP_PORT_MMIO_SIZE;
+
+		val = ioread16(portbase + ADSP_PORT_REG_DATA);
+		return !!(val & BIT(offset));
+	}
+
+	return 0;
+}
+
+static int adsp_gpio_set_value(struct udevice *udev, unsigned int pin, int value)
+{
+	struct adsp_gpio_priv *priv = dev_get_priv(udev);
+	u32 port, offset;
+	void __iomem *portbase;
+
+	if (pin < priv->ngpio) {
+		port = get_port(pin);
+		offset = get_offset(pin);
+		portbase = priv->base + port * ADSP_PORT_MMIO_SIZE;
+
+		if (value)
+			iowrite16(BIT(offset), portbase + ADSP_PORT_REG_DATA_SET);
+		else
+			iowrite16(BIT(offset), portbase + ADSP_PORT_REG_DATA_CLEAR);
+	}
+
+	return 0;
+}
+
+static const struct dm_gpio_ops adsp_gpio_ops = {
+	.direction_input = adsp_gpio_input,
+	.direction_output = adsp_gpio_output,
+	.get_value = adsp_gpio_get_value,
+	.set_value = adsp_gpio_set_value,
+};
+
+static int adsp_gpio_probe(struct udevice *udev)
+{
+	struct adsp_gpio_priv *priv = dev_get_priv(udev);
+	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(udev);
+
+	uc_priv->bank_name = "adsp gpio";
+	uc_priv->gpio_count = dev_read_u32_default(udev, "adi,ngpios", 0);
+
+	if (!uc_priv->gpio_count) {
+		dev_err(udev, "Missing adi,ngpios property!\n");
+		return -ENOENT;
+	}
+
+	priv->base = dev_read_addr_ptr(udev);
+	priv->ngpio = uc_priv->gpio_count;
+
+	return 0;
+}
+
+static const struct udevice_id adsp_gpio_match[] = {
+	{ .compatible = "adi,adsp-gpio" },
+	{ },
+};
+
+U_BOOT_DRIVER(adi_adsp_gpio) = {
+	.name	= "adi_adsp_gpio",
+	.id	= UCLASS_GPIO,
+	.ops	= &adsp_gpio_ops,
+	.probe	= adsp_gpio_probe,
+	.priv_auto = sizeof(struct adsp_gpio_priv),
+	.of_match = adsp_gpio_match,
+	.flags = DM_FLAG_PRE_RELOC,
+};
-- 
2.45.2

