Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE1CC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 17:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AA4F8110C;
	Wed, 26 Feb 2025 18:58:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P3LRK9ZF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 082BA80F92; Wed, 26 Feb 2025 18:33:05 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A023880F12
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 18:33:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e5dc299dee9so6501848276.3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 09:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740591181; x=1741195981; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N43h7TSUZ/zhHxg0YSncMyI5R1R0vdNK0MUcPzvqJok=;
 b=P3LRK9ZFiNoxOjKCKd/j2gRZeguW00UTl29E/C7S82kxZ1XA84cfR0eVL797sGjL/0
 eKFd/VqWWAyTaXuSI5zxPKlJZn3kiClT+nwzTgg8qvZV4mcr6COROKQwl9/Kkkh2Y6df
 TPVmQjdX/8kfp4eKyxN6gTmUapLlSyf64pVlHLkiOFtYx3NafrCH3PuKVtPa7067Z3TE
 ahxnQaWrLKIdzUdS//+sHly/8X95eTVnhOa8DMkJF+FiAUabQwlMAYCvi36EFvV8bEXj
 3NshIjue9ftuU3loq03pbkhXCIUb76g6z1CESkoER0YZltLbF6n42+CYoj3WJ6RC0ELX
 wndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740591181; x=1741195981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N43h7TSUZ/zhHxg0YSncMyI5R1R0vdNK0MUcPzvqJok=;
 b=uIjb8y+lBYDp7CaDdBWeB72j9onSxI1ZgTldnVZK56ylsm8ccuQpOlQGMnGTGEW83r
 5hHp/HSFywPwZltmqWJz0siKuUel/3s+31M03L3Pk4Fwpwju5A0paM9S8ucArBBLwuk6
 +clufE1Ngyk9xyXdBLTakRlqMsKHQfD2RgdClqwfxEEwcXJKcH9QK6p2Mhv0Kjfz7f1V
 oY+XtbnH+RWRlSGYSllZANhghJO6VBIOrXpeGAeqCAXjSAw+pZDtudBxlnY5thHEwQAL
 zKSWNb0sC12/zsJMWSdwwVAOvwVrUjBz4oUcEe8cdrcPGXpI3Exb4BWmWzv9eH/hFm7u
 ebMA==
X-Gm-Message-State: AOJu0YzRZe1Dsh7+oEr70rtWh9HN6bYKtHcyroiZMNSK5f1Pv7q2nzXy
 j21QY3Ge3rcW/fAe+CwHlH8xjy74iN0elheH6Hq0q7TzjKg14awZ/CYUy1Q=
X-Gm-Gg: ASbGncvjV2rAoyNcwiT60qI+0ZOzB+OoVlxyz5sibbZl0P8dUjnlS/jd2kIbN+emZHz
 79hfJ40hDWvBDLZHUwjwW4swJOfSZ8rXshPjF/c+/7bBFQtosKdZoaSzVuU1VT7Gc9m7A+N6f8N
 AHGC1e0HX8nXc9pWChsJFCjjZO6jTOh5eE+WGMS8EbCDudOpfm8sk/KVVwxcbpDSrkTTV7aPBCo
 Swech6VYR4V3D32knpbvphLYKyoYNXp1PHotm25bETPK0JjhXLGDt4J54714Sz8Vwau0CAzKgkG
 1tkf3ztsuHRd1M1pkCyZUQrebotzZC1gEh3pSM8teA==
X-Google-Smtp-Source: AGHT+IFrXFXm6MaulI94uAsivGujTtDoKtqwtOjh+iqpNja+fwiXR4iJBBvnLv6bsnjowuL8CmIsUQ==
X-Received: by 2002:a05:6902:18d5:b0:e5d:b2d7:65b9 with SMTP id
 3f1490d57ef6-e5e765f700amr14580836276.0.1740591180933; 
 Wed, 26 Feb 2025 09:33:00 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e607b40d227sm1067620276.31.2025.02.26.09.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 09:32:59 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 05/12] usb: musb-new: Add support for Analog Devices SC5xx
 SoCs
Date: Wed, 26 Feb 2025 12:30:27 -0500
Message-ID: <20250226173150.13198-6-malysagreg@gmail.com>
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

From: Nathan Barrett-Morrison <nathan.morrison@timesys.com>

This adds support for the MUSB-based USB controller found in the
Analog Devices SC57x and SC58x SoCs.

Co-developed-by: Greg Malysa <malysagreg@gmail.com>
Signed-off-by: Greg Malysa <malysagreg@gmail.com>
Co-developed-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
---

(no changes since v1)

 MAINTAINERS                   |   1 +
 drivers/usb/musb-new/Kconfig  |   7 ++
 drivers/usb/musb-new/Makefile |   1 +
 drivers/usb/musb-new/sc5xx.c  | 202 ++++++++++++++++++++++++++++++++++
 4 files changed, 211 insertions(+)
 create mode 100644 drivers/usb/musb-new/sc5xx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bfb81bb9891..b57e2119679 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -637,6 +637,7 @@ F:	drivers/gpio/gpio-adi-adsp.c
 F:	drivers/pinctrl/pinctrl-adi-adsp.c
 F:	drivers/serial/serial_adi_uart4.c
 F:	drivers/timer/adi_sc5xx_timer.c
+F:	drivers/usb/musb-new/sc5xx.c
 F:	include/configs/sc5*
 F:	include/dt-bindings/pinctrl/adi-adsp.h
 F:	include/env/adi/
diff --git a/drivers/usb/musb-new/Kconfig b/drivers/usb/musb-new/Kconfig
index c52afd41a75..ad9072a5327 100644
--- a/drivers/usb/musb-new/Kconfig
+++ b/drivers/usb/musb-new/Kconfig
@@ -22,6 +22,13 @@ config USB_MUSB_GADGET
 	  Enables the MUSB USB dual-role controller in gadget mode.
 
 if USB_MUSB_HOST || USB_MUSB_GADGET
+config USB_MUSB_SC5XX
+        bool "Analog Devices MUSB support"
+        depends on (SC57X || SC58X)
+	help
+	 Say y here to enable support for the USB controller on
+	 ADI SC57X/SC58X processors.
+
 config USB_MUSB_DA8XX
 	bool "Enable DA8xx MUSB Controller"
 	depends on ARCH_DAVINCI
diff --git a/drivers/usb/musb-new/Makefile b/drivers/usb/musb-new/Makefile
index 396ff02654b..6638772daca 100644
--- a/drivers/usb/musb-new/Makefile
+++ b/drivers/usb/musb-new/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_USB_MUSB_PIC32) += pic32.o
 obj-$(CONFIG_USB_MUSB_SUNXI) += sunxi.o
 obj-$(CONFIG_USB_MUSB_TI) += ti-musb.o
 obj-$(CONFIG_USB_MUSB_UX500) += ux500.o
+obj-$(CONFIG_USB_MUSB_SC5XX) += sc5xx.o
 
 ccflags-y := $(call cc-option,-Wno-unused-variable) \
 		$(call cc-option,-Wno-unused-but-set-variable) \
diff --git a/drivers/usb/musb-new/sc5xx.c b/drivers/usb/musb-new/sc5xx.c
new file mode 100644
index 00000000000..16201480b43
--- /dev/null
+++ b/drivers/usb/musb-new/sc5xx.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * ADI SC5XX MUSB "glue layer"
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Loosely ported from Linux driver:
+ * Author: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ *
+ */
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <linux/bitops.h>
+#include <linux/io.h>
+#include <linux/usb/musb.h>
+#include "linux-compat.h"
+#include "musb_core.h"
+#include "musb_uboot.h"
+
+#define MUSB_SOFTRST		0x7f
+#define  MUSB_SOFTRST_NRST	BIT(0)
+#define  MUSB_SOFTRST_NRSTX	BIT(1)
+
+#define REG_USB_VBUS_CTL	0x380
+#define REG_USB_ID_CTL		0x382
+#define REG_USB_PHY_CTL		0x394
+#define REG_USB_PLL_OSC		0x398
+#define REG_USB_UTMI_CTL	0x39c
+
+/* controller data */
+struct sc5xx_musb_data {
+	struct musb_host_data mdata;
+	struct device dev;
+};
+
+#define to_sc5xx_musb_data(d)	\
+	container_of(d, struct sc5xx_musb_data, dev)
+
+static void sc5xx_musb_disable(struct musb *musb)
+{
+	/* no way to shut the controller */
+}
+
+static int sc5xx_musb_enable(struct musb *musb)
+{
+	/* soft reset by NRSTx */
+	musb_writeb(musb->mregs, MUSB_SOFTRST, MUSB_SOFTRST_NRSTX);
+	/* set mode */
+	musb_platform_set_mode(musb, musb->board_mode);
+
+	return 0;
+}
+
+static irqreturn_t sc5xx_interrupt(int irq, void *hci)
+{
+	struct musb  *musb = hci;
+	irqreturn_t ret = IRQ_NONE;
+	u8 devctl;
+
+	musb->int_usb = musb_readb(musb->mregs, MUSB_INTRUSB);
+	musb->int_tx = musb_readw(musb->mregs, MUSB_INTRTX);
+	musb->int_rx = musb_readw(musb->mregs, MUSB_INTRRX);
+
+	if (musb->int_usb & MUSB_INTR_VBUSERROR) {
+		musb->int_usb &= ~MUSB_INTR_VBUSERROR;
+		devctl = musb_readw(musb->mregs, MUSB_DEVCTL);
+		devctl |= MUSB_DEVCTL_SESSION;
+		musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
+	}
+	if (musb->int_usb || musb->int_tx || musb->int_rx) {
+		musb_writeb(musb->mregs, MUSB_INTRUSB, musb->int_usb);
+		musb_writew(musb->mregs, MUSB_INTRTX, musb->int_tx);
+		musb_writew(musb->mregs, MUSB_INTRRX, musb->int_rx);
+		ret = musb_interrupt(musb);
+	}
+
+	if (musb->int_usb & MUSB_INTR_DISCONNECT && is_host_active(musb))
+		musb_writeb(musb->mregs, REG_USB_VBUS_CTL, 0x0);
+
+	return ret;
+}
+
+static int sc5xx_musb_set_mode(struct musb *musb, u8 mode)
+{
+	struct device *dev = musb->controller;
+	struct sc5xx_musb_data *pdata = to_sc5xx_musb_data(dev);
+
+	switch (mode) {
+	case MUSB_HOST:
+		musb_writeb(musb->mregs, REG_USB_ID_CTL, 0x1);
+		break;
+	case MUSB_PERIPHERAL:
+		musb_writeb(musb->mregs, REG_USB_ID_CTL, 0x3);
+		break;
+	case MUSB_OTG:
+		musb_writeb(musb->mregs, REG_USB_ID_CTL, 0x0);
+		break;
+	default:
+		dev_err(dev, "unsupported mode %d\n", mode);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int sc5xx_musb_init(struct musb *musb)
+{
+	struct sc5xx_musb_data *pdata = to_sc5xx_musb_data(musb->controller);
+
+	musb->isr = sc5xx_interrupt;
+
+	musb_writel(musb->mregs, REG_USB_PLL_OSC, 20 << 1);
+	musb_writeb(musb->mregs, REG_USB_VBUS_CTL, 0x0);
+	musb_writeb(musb->mregs, REG_USB_PHY_CTL, 0x80);
+	musb_writel(musb->mregs, REG_USB_UTMI_CTL,
+		    0x40 | musb_readl(musb->mregs, REG_USB_UTMI_CTL));
+
+	return 0;
+}
+
+const struct musb_platform_ops sc5xx_musb_ops = {
+	.init		= sc5xx_musb_init,
+	.set_mode	= sc5xx_musb_set_mode,
+	.disable	= sc5xx_musb_disable,
+	.enable		= sc5xx_musb_enable,
+};
+
+static struct musb_hdrc_config sc5xx_musb_config = {
+	.multipoint     = 1,
+	.dyn_fifo       = 1,
+	.num_eps        = 16,
+	.ram_bits       = 12,
+};
+
+/* has one MUSB controller which can be host or gadget */
+static struct musb_hdrc_platform_data sc5xx_musb_plat = {
+	.mode           = MUSB_HOST,
+	.config         = &sc5xx_musb_config,
+	.power          = 100,
+	.platform_ops	= &sc5xx_musb_ops,
+};
+
+static int musb_usb_probe(struct udevice *dev)
+{
+	struct usb_bus_priv *priv = dev_get_uclass_priv(dev);
+	struct sc5xx_musb_data *pdata = dev_get_priv(dev);
+	struct musb_host_data *mdata = &pdata->mdata;
+	void __iomem *mregs;
+	int ret;
+
+	priv->desc_before_addr = true;
+
+	mregs = dev_remap_addr(dev);
+	if (!mregs)
+		return -EINVAL;
+
+	/* init controller */
+	if (IS_ENABLED(CONFIG_USB_MUSB_HOST)) {
+		mdata->host = musb_init_controller(&sc5xx_musb_plat,
+						   &pdata->dev, mregs);
+		if (!mdata->host)
+			return -EIO;
+
+		ret = musb_lowlevel_init(mdata);
+	} else {
+		sc5xx_musb_plat.mode = MUSB_PERIPHERAL;
+		mdata->host = musb_register(&sc5xx_musb_plat, &pdata->dev, mregs);
+		if (!mdata->host)
+			return -EIO;
+	}
+	return ret;
+}
+
+static int musb_usb_remove(struct udevice *dev)
+{
+	struct sc5xx_musb_data *pdata = dev_get_priv(dev);
+
+	musb_stop(pdata->mdata.host);
+
+	return 0;
+}
+
+static const struct udevice_id sc5xx_musb_ids[] = {
+	{ .compatible = "adi,sc5xx-musb" },
+	{ }
+};
+
+U_BOOT_DRIVER(usb_musb) = {
+	.name		= "sc5xx-musb",
+	.id		= UCLASS_USB,
+	.of_match	= sc5xx_musb_ids,
+	.probe		= musb_usb_probe,
+	.remove		= musb_usb_remove,
+#ifdef CONFIG_USB_MUSB_HOST
+	.ops		= &musb_usb_ops,
+#endif
+	.plat_auto	= sizeof(struct usb_plat),
+	.priv_auto	= sizeof(struct sc5xx_musb_data),
+};
-- 
2.45.2

