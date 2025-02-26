Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F0BC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 17:59:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4486280FB6;
	Wed, 26 Feb 2025 18:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WbXabAnH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32B8280F96; Wed, 26 Feb 2025 18:33:00 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D296580F88
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 18:32:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e5dc299deb4so3603276.1
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 09:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740591176; x=1741195976; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xRpUENnV7RjVZDWy31W21+4RgzNbAwSDmA9idD2fV/o=;
 b=WbXabAnHe5fvJAVEaQhItX7PNg3jgvpB0RMO076wD8u4pZxjkgfx02+lniGYR6QFSz
 fzvSnlOYxQgv47X20S0pBcnpvGXKYzGmZZYXo570NgbsBKLCvaJ96gyEGfDK70VNbDHD
 ESTi9waoLy+7vWovV2zI0E766ytgzwFNV7n7vqBlMxq8wijCpBJNG3WvosvVbBvJXsIR
 35zFCjo97QMlk60gVXSzLGMYKNuezmphLpeRo1Hcc0Khd5d32BLPWfgatgKHP1xyf0CP
 rZJ/ST5r4BYdOdi3Z8MmvWOU9OxpfDVurTBfaJl/enP4HhJlZrcgM62nbiq5n5bQmlzx
 2tHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740591176; x=1741195976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xRpUENnV7RjVZDWy31W21+4RgzNbAwSDmA9idD2fV/o=;
 b=ooNoEgEiBJvbpufOWBOVuIswbpujmUyBXkaTFOwWhMg7K2NDXyI0aqi2kqOqqlb48k
 Nrw9kz/SjaBFou0+PdqPRcEg4ncqy/jfFfasydmd/YMA3y8qK4QdijL1iVMR+tpplll4
 mdj3qXAlnm2NgWLrK0oqVBMGq2x11p2mpnn9HHdSD3hJXZx+wLVtNvxceLtEWrHsLjuG
 0+OVlV4J69fcT/bzwN/VZCSup+/RA1O2DjdTWzdp6J/usy1hu9CipmH3hhedVsSccUn/
 yzueTOdopuOGS0rZasXQmjUVsuu1Tc4tj9eH4z22/UaAAO3DVgUpNHVccrfAkvjp43y5
 dEZA==
X-Gm-Message-State: AOJu0YxXvNr4THuWYiQZYjcM9dpSm3MW2cPzXxZ6xCmshfhgCns/iQP9
 aVFeqDOWMazH8z4DS2HPR+9LcF6bVFH/Yz8Z+nKkZTmlRZbiOLIViDPCWmI=
X-Gm-Gg: ASbGncujZ7x19iY1HjrbfU5tmGKswGVZl3EmsGkZHGS2G6sQoDigkmp6HC6jI88Y8Gz
 o7fE/IOLVz2zG98pbO52gftyjHhFxP2BKoBRIjpojZgfDI0FXgtL/sIjH8XkMsBckqez6lm5U7m
 DeVwV7LAl8m6ixmA5/4awoRGfCb8hcZKNUBQ+DzDv6qUKJSkgiMW1PWHddzs5w+9qdzyv2TyY9Q
 4Unt/pC4U68TFRi0Ycr3u84TUBE2rOmVm9eYyOmhHR8RgvI9o07C3SJ52TsRRBYUxdsQlYgYWJc
 OnrJdevDg5eHjvg2D57YKWz2At6K650OvgYjZTsL6jMW5MZZs9waMcg8wAq9
X-Google-Smtp-Source: AGHT+IHnnkAQi5p2hwRYqNjuEWUoFH/BsdbWaYgoJ2v4KPr2iTylKVfHYrc3FDZ3fzHJoZA17MxeWw==
X-Received: by 2002:a05:6902:72c:b0:e5d:bf57:7dc7 with SMTP id
 3f1490d57ef6-e608a56cf33mr3887514276.21.1740591175926; 
 Wed, 26 Feb 2025 09:32:55 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e607b40d227sm1067620276.31.2025.02.26.09.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 09:32:55 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com, Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 01/12] pinctrl: Add support for ADI SC5XX-family pinctrl
Date: Wed, 26 Feb 2025 12:30:23 -0500
Message-ID: <20250226173150.13198-2-malysagreg@gmail.com>
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

This adds support for pin configuration on the Analog Devices SC5XX SoC
family. This commit is largely a port of the Linux driver, which has not
yet been submitted upstream.

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

Changes in v3:
- Add check if PORT peripheral base address was mapped successfully

Changes in v2:
- Clean up some whitespace errors
- Modify Kconfigs to reflect changes to mach-sc5xx/Kconfig


---
 MAINTAINERS                        |   1 +
 drivers/pinctrl/Kconfig            |   8 ++
 drivers/pinctrl/Makefile           |   1 +
 drivers/pinctrl/pinctrl-adi-adsp.c | 161 +++++++++++++++++++++++++++++
 4 files changed, 171 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-adi-adsp.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c1851280e6e..af8d0b7d5e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -631,6 +631,7 @@ F:	doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml
 F:	doc/device-tree-bindings/clock/adi,sc5xx-clocks.yaml
 F:	doc/device-tree-bindings/timer/adi,sc5xx-gptimer.yaml
 F:	drivers/clk/adi/
+F:	drivers/pinctrl/pinctrl-adi-adsp.c
 F:	drivers/serial/serial_adi_uart4.c
 F:	drivers/timer/adi_sc5xx_timer.c
 F:	include/configs/sc5*
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 6ee7dc1cce8..687fb339ea0 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -178,6 +178,14 @@ config PINCTRL_APPLE
 	  both the GPIO definitions and pin control functions for each
 	  available multiplex function.
 
+config PINCTRL_ADI
+	bool "ADI pinctrl driver"
+	depends on DM && ARCH_SC5XX
+	help
+	  This driver enables pinctrl support on SC5xx processors. This
+	  driver covers only the pin configuration functionality, and
+	  GPIO functionality is contained in the separate GPIO driver.
+
 config PINCTRL_AR933X
 	bool "QCA/Athores ar933x pin control driver"
 	depends on DM && SOC_AR933X
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 634047a91f4..e3a82b12c78 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -3,6 +3,7 @@
 obj-y					+= pinctrl-uclass.o
 obj-$(CONFIG_$(XPL_)PINCTRL_GENERIC)	+= pinctrl-generic.o
 
+obj-$(CONFIG_PINCTRL_ADI)		+= pinctrl-adi-adsp.o
 obj-$(CONFIG_PINCTRL_APPLE)		+= pinctrl-apple.o
 obj-$(CONFIG_PINCTRL_AT91)		+= pinctrl-at91.o
 obj-$(CONFIG_PINCTRL_AT91PIO4)		+= pinctrl-at91-pio4.o
diff --git a/drivers/pinctrl/pinctrl-adi-adsp.c b/drivers/pinctrl/pinctrl-adi-adsp.c
new file mode 100644
index 00000000000..debf434212d
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-adi-adsp.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Author: Greg Malysa <greg.malysa@timesys.com>
+ * Additional Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ *
+ * dm pinctrl implementation for ADI ADSP SoCs
+ *
+ */
+
+#include <dm.h>
+#include <dm/pinctrl.h>
+#include <dm/device_compat.h>
+#include <linux/bitops.h>
+#include <linux/io.h>
+
+#define ADSP_PORT_MMIO_SIZE		0x80
+#define ADSP_PORT_PIN_SIZE		16
+
+#define ADSP_PORT_PORT_MUX_BITS		2
+#define ADSP_PORT_PORT_MUX_MASK		0x03
+#define ADSP_PINCTRL_FUNCTION_COUNT 4
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
+struct adsp_pinctrl_priv {
+	void __iomem *base;
+	int npins;
+	char pinbuf[16];
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
+static int adsp_pinctrl_pinmux_set(struct udevice *udev, unsigned int pin, unsigned int func)
+{
+	struct adsp_pinctrl_priv *priv = dev_get_priv(udev);
+	void __iomem *portbase;
+	u32 port, offset;
+	u32 val;
+
+	if (pin >= priv->npins)
+		return -ENODEV;
+
+	if (func >= ADSP_PINCTRL_FUNCTION_COUNT)
+		return -EINVAL;
+
+	port = get_port(pin);
+	offset = get_offset(pin);
+	portbase = priv->base + port * ADSP_PORT_MMIO_SIZE;
+
+	val = ioread32(portbase + ADSP_PORT_REG_PORT_MUX);
+	val &= ~(ADSP_PORT_PORT_MUX_MASK << (ADSP_PORT_PORT_MUX_BITS * offset));
+	val |= func << (ADSP_PORT_PORT_MUX_BITS * offset);
+	iowrite32(val, portbase + ADSP_PORT_REG_PORT_MUX);
+
+	iowrite32(BIT(offset), portbase + ADSP_PORT_REG_FER_SET);
+	return 0;
+}
+
+static int adsp_pinctrl_set_state(struct udevice *udev, struct udevice *config)
+{
+	const struct fdt_property *pinlist;
+	int length = 0;
+	int ret, i;
+	u32 pin, function;
+
+	pinlist = dev_read_prop(config, "adi,pins", &length);
+	if (!pinlist) {
+		dev_err(udev, "missing adi,pins property in pinctrl config node\n");
+		return -EINVAL;
+	}
+
+	if (length % (sizeof(uint32_t) * 2)) {
+		dev_err(udev, "adi,pins property must be a multiple of two uint32_ts\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < length / sizeof(uint32_t); i += 2) {
+		ret = dev_read_u32_index(config, "adi,pins", i, &pin);
+		if (ret)
+			return ret;
+
+		ret = dev_read_u32_index(config, "adi,pins", i + 1, &function);
+		if (ret)
+			return ret;
+
+		ret = adsp_pinctrl_pinmux_set(udev, pin, function);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+const struct pinctrl_ops adsp_pinctrl_ops = {
+	.set_state = adsp_pinctrl_set_state,
+};
+
+static int adsp_pinctrl_probe(struct udevice *udev)
+{
+	struct adsp_pinctrl_priv *priv = dev_get_priv(udev);
+
+	priv->base = dev_read_addr_ptr(udev);
+	priv->npins = dev_read_u32_default(udev, "adi,npins", 0);
+
+	if (!priv->base) {
+		dev_err(udev, "Missing or invalid pinctrl base address\n");
+		return -ENOENT;
+	}
+
+	if (!priv->npins) {
+		dev_err(udev, "Missing adi,npins property!\n");
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+static const struct udevice_id adsp_pinctrl_match[] = {
+	{ .compatible = "adi,adsp-pinctrl" },
+	{ },
+};
+
+U_BOOT_DRIVER(adi_adsp_pinctrl) = {
+	.name = "adi_adsp_pinctrl",
+	.id = UCLASS_PINCTRL,
+	.of_match = adsp_pinctrl_match,
+	.probe = adsp_pinctrl_probe,
+	.priv_auto = sizeof(struct adsp_pinctrl_priv),
+	.ops = &adsp_pinctrl_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
-- 
2.45.2

