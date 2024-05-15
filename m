Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC4BC25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 21:59:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED7368831F;
	Wed, 15 May 2024 23:59:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="l4YILUnu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B15D588312; Wed, 15 May 2024 23:59:30 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 189FF88262
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 23:59:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-61bed738438so75178577b3.2
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 14:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1715810367; x=1716415167;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HhbpmA1GJPBJvYhvvqDOyerFdQWtuefSSOX0e0ZSxTs=;
 b=l4YILUnuWzUTRniZZzxWi9aiWrACF7A1OljODoC8iBu1SSAw2Nedr7WeBb274w+BAH
 NMNRWrxWJQ8aOL955rYJdjVzsUhzZCq7GpbbUDABZnN/+TyDEG+hQJQPyKpZiyagO4Bn
 a+LdkzCX0a1byPozBO+w1oxqbMXgLJPI/115V61TuEELcBKnphP/LslcYqIl1CGjpF+8
 JhBzeUzc7qzxhILI3yvUKLVYoh2/KpZjZn1seBmPBTp24iwRiRDZL/KrLc/+LTBCUozq
 /iyPzeEkMUwqdjDvAxC+N5mhsD21SrGCVPrRqpNttXL6WmOlOdaxXsC++co2n54xJHnM
 g49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715810367; x=1716415167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HhbpmA1GJPBJvYhvvqDOyerFdQWtuefSSOX0e0ZSxTs=;
 b=fhNU2izDRB+Vpck6YrUIvD/08Ej6lNZTYd6zM+nN+bbcGUKvfGIu49Mid2+JoJ3YHS
 uE8R5U4KdO57Xywd/WFdrq+xbjJ8tjwcjFNzI/132arDk/+KOY2o8m6ERccR4pzywovr
 Bzig2yNR58eH3R8+szoiDZcwfn79U2sUThlO1oQtk6uT+IMO5piKY4EWgnHwXomUyxZ1
 gPRPpJOOLMuZ2bgdVHidwv3MiASKOievGE1kyPyPzVRhAqsIhYLv5BvcIqL0OC0oXVom
 +dq/WNoIVy6q9KkgpnvhxHg/Cw/HJuwKVKBCoyG72RozyCFhX6uOUXa1L8Y/RpEHRv79
 52ig==
X-Gm-Message-State: AOJu0YyEeBlc0BG+uNK3YrjOfPbxaDeMj4iGqfCXcpgUDdc6+RvYWiGt
 eouwdBZxbZYigVK1auzkSSAGtEBULt4ZzA5+Wv+emAYoVZLxrV5nIWor2V779HhG1juUOPL1CeH
 9dw==
X-Google-Smtp-Source: AGHT+IEb/2Utq7uwBWDj/xY7+h1vOOP0FNoCVFiwYgSvr9ToX0Og8Xk3tbQs78im2MfPptWS2IqwFQ==
X-Received: by 2002:a05:690c:620b:b0:61b:1d8d:8c11 with SMTP id
 00721157ae682-622aff90296mr179643407b3.4.1715810366699; 
 Wed, 15 May 2024 14:59:26 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6209e37913asm30956457b3.105.2024.05.15.14.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 14:59:26 -0700 (PDT)
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
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/11] pinctrl: Add support for ADI SC5XX-family pinctrl
Date: Wed, 15 May 2024 17:57:38 -0400
Message-ID: <20240515215837.14028-2-greg.malysa@timesys.com>
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
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>

---


---
 MAINTAINERS                            |   1 +
 drivers/pinctrl/Kconfig                |   8 ++
 drivers/pinctrl/Makefile               |   1 +
 drivers/pinctrl/pinctrl-adi-adsp.c     | 156 +++++++++++++++++++++++++
 include/dt-bindings/pinctrl/adi-adsp.h |  21 ++++
 5 files changed, 187 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-adi-adsp.c
 create mode 100644 include/dt-bindings/pinctrl/adi-adsp.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6853288975..dabc7d0591 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -610,6 +610,7 @@ T:	git https://github.com/analogdevicesinc/lnxdsp-u-boot
 F:	arch/arm/include/asm/arch-adi/
 F:	arch/arm/mach-sc5xx/
 F:	drivers/clk/adi/
+F:	drivers/pinctrl/pinctrl-adi-adsp.c
 F:	drivers/serial/serial_adi_uart4.c
 F:	drivers/timer/adi_sc5xx_timer.c
 F:	include/env/adi/
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index a1d53cfbdb..0f3fb65e4e 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -170,6 +170,14 @@ config PINCTRL_APPLE
 	  both the GPIO definitions and pin control functions for each
 	  available multiplex function.
 
+config PINCTRL_ADI
+	bool "ADI pinctrl driver"
+	depends on DM && (SC57X || SC58X || SC59X || SC59X_64)
+	help
+	  This driver enables pinctrl support on SC5xx processors. This
+	  driver covers only the pin configuration functionality, and
+	  GPIO functionality is contained in the separate GPIO driver.
+
 config PINCTRL_AR933X
 	bool "QCA/Athores ar933x pin control driver"
 	depends on DM && SOC_AR933X
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 6d7b7cd905..7dd56774bd 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -3,6 +3,7 @@
 obj-y					+= pinctrl-uclass.o
 obj-$(CONFIG_$(SPL_)PINCTRL_GENERIC)	+= pinctrl-generic.o
 
+obj-$(CONFIG_PINCTRL_ADI)		+= pinctrl-adi-adsp.o
 obj-$(CONFIG_PINCTRL_APPLE)		+= pinctrl-apple.o
 obj-$(CONFIG_PINCTRL_AT91)		+= pinctrl-at91.o
 obj-$(CONFIG_PINCTRL_AT91PIO4)		+= pinctrl-at91-pio4.o
diff --git a/drivers/pinctrl/pinctrl-adi-adsp.c b/drivers/pinctrl/pinctrl-adi-adsp.c
new file mode 100644
index 0000000000..717ac8e005
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-adi-adsp.c
@@ -0,0 +1,156 @@
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
diff --git a/include/dt-bindings/pinctrl/adi-adsp.h b/include/dt-bindings/pinctrl/adi-adsp.h
new file mode 100644
index 0000000000..7dc8a1ef5c
--- /dev/null
+++ b/include/dt-bindings/pinctrl/adi-adsp.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ * Contact: Greg Malysa <greg.malysa@timesys.com>
+ *
+ */
+
+#ifndef DT_BINDINGS_PINCTRL_ADI_ADSP
+#define DT_BINDINGS_PINCTRL_ADI_ADSP
+
+#define ADI_ADSP_PIN(port, pin) (16 * ((port) - 'A') + (pin))
+#define ADI_ADSP_PINFUNC_ALT0 0
+#define ADI_ADSP_PINFUNC_ALT1 1
+#define ADI_ADSP_PINFUNC_ALT2 2
+#define ADI_ADSP_PINFUNC_ALT3 3
+
+#endif
-- 
2.43.2

