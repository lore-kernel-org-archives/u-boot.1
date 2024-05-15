Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA8CC25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 21:59:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CD3A8831C;
	Wed, 15 May 2024 23:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="2l3LC16j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 861158831C; Wed, 15 May 2024 23:59:31 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC4BF882DF
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 23:59:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-622e32414ffso45580517b3.1
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 14:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1715810368; x=1716415168;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S30jOVMd9IsjxB3XUEXYueHgs2hXeMAE5kqZHpHO9Oo=;
 b=2l3LC16j/rt+OKHDVg0vJHFPXQauk1Dq5Sn6nddKcfqyKJO6YXWaOFgmlywrEdnC+0
 GMaJ7/unpUUWZrzfdoxfUQ/jVN7mXUuI2UgF9bzRFEoZSfCDuKWUm/+Q0tF46fJFr+V2
 iVfT4u7NlrYnsLru6iAZrdXvjFMihYX3+OFkfefbfduid91bkiKK/KXXDfL/bQpG/Gdb
 N/dqN0x7n0cE9YzJbQaZgfRpkchbM0lElijgndjkizCh6ODunh1NGpMlaA7q7w9vx1fS
 T3yv2ORskba+KkF3IJxBVUQM6fnFeZ4gCSc/ozaXQn+KhgvlmzRT8miuaPUVT05FPGGo
 eERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715810368; x=1716415168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S30jOVMd9IsjxB3XUEXYueHgs2hXeMAE5kqZHpHO9Oo=;
 b=nSKfModN/ksOrLBi9uUYtUEVrot/+ZfUhbGKmZzHsgr5E2Ku+gj/pWze603r0QpNuh
 fiKOUq/ITmg9vvQTPicFUEZ2Hhh0ESFkOdPkMGIVEeAMSNeoyRe2/1SokoJjLjEA/0vJ
 loAcqFgLw2VEui3ZmxNSlMORQoDWVo4zcNVEzIzluXYvcgyd6z1lfE4v8QvGgpu8WnDv
 /1xOJ4xYgvf2OB2A43FospEYPdaT0waCGqLl57ZVlVjRBiNrqs3qk9Q3WTx8MsOulj0x
 uuqP/3U80tiBwfDfJKESFp9Bekg8e1PFF+XEyGEtwmnhKTJzQr/d5opxJ8nbJ+G3hL0o
 kPqA==
X-Gm-Message-State: AOJu0Yyb6YSM19l8QbUM59OrpIKNcKii6MuFd/jUy5kAHam1yrxhPHps
 eS9P8jVbCKFeh12ijcozkqml/G6sLOWGf0izytohcDAk+StU8/3vde5p39HAf96pnpJLcftE0q1
 nZg==
X-Google-Smtp-Source: AGHT+IEL0PhA/p8D7MXzOo6xHHNrT5jUS+2HFUtautkCpi1td0TnaGrxaUbeoKP73FaRMX6L1CCrdw==
X-Received: by 2002:a05:690c:4a12:b0:61a:eb16:ffbd with SMTP id
 00721157ae682-622aff93c08mr256143807b3.14.1715810367592; 
 Wed, 15 May 2024 14:59:27 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6209e37913asm30956457b3.105.2024.05.15.14.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 14:59:27 -0700 (PDT)
From: Greg Malysa <greg.malysa@timesys.com>
To: u-boot@lists.denx.de
Cc: Matthew McClintock <Matthew.Mcclintock@analog.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/11] gpio: Add support for SC5XX-family processor GPIO driver
Date: Wed, 15 May 2024 17:57:39 -0400
Message-ID: <20240515215837.14028-3-greg.malysa@timesys.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240515215837.14028-1-greg.malysa@timesys.com>
References: <20240515215837.14028-1-greg.malysa@timesys.com>
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

This adds support for using the GPIO pins on the SC5XX family of SoCs
from Analog Devices.

Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Co-developed-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
---

 MAINTAINERS                  |   1 +
 drivers/gpio/Kconfig         |   9 ++
 drivers/gpio/Makefile        |   1 +
 drivers/gpio/gpio-adi-adsp.c | 179 +++++++++++++++++++++++++++++++++++
 4 files changed, 190 insertions(+)
 create mode 100644 drivers/gpio/gpio-adi-adsp.c

diff --git a/MAINTAINERS b/MAINTAINERS
index dabc7d0591..5d7b0f39ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -610,6 +610,7 @@ T:	git https://github.com/analogdevicesinc/lnxdsp-u-boot
 F:	arch/arm/include/asm/arch-adi/
 F:	arch/arm/mach-sc5xx/
 F:	drivers/clk/adi/
+F:	drivers/gpio/gpio-adi-adsp.c
 F:	drivers/pinctrl/pinctrl-adi-adsp.c
 F:	drivers/serial/serial_adi_uart4.c
 F:	drivers/timer/adi_sc5xx_timer.c
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b050585389..142fe44533 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -97,6 +97,15 @@ config SPL_DM_GPIO_LOOKUP_LABEL
 	  different gpios on different hardware versions
 	  for the same functionality in board code.
 
+config ADI_GPIO
+	bool "ADI GPIO driver"
+	depends on DM_GPIO && (SC57X || SC58X || SC59X || SC59X_64)
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
index 4a29315435..ba58fbafd1 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_$(SPL_TPL_)DM_GPIO) += gpio-uclass.o
 
 obj-$(CONFIG_$(SPL_)DM_PCA953X)	+= pca953x_gpio.o
 
+obj-$(CONFIG_ADI_GPIO)		+= gpio-adi-adsp.o
 obj-$(CONFIG_ASPEED_GPIO)	+= gpio-aspeed.o
 obj-$(CONFIG_AT91_GPIO)	+= at91_gpio.o
 obj-$(CONFIG_ATMEL_PIO4)	+= atmel_pio4.o
diff --git a/drivers/gpio/gpio-adi-adsp.c b/drivers/gpio/gpio-adi-adsp.c
new file mode 100644
index 0000000000..0ce00572e0
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
2.43.2

