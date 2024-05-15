Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16450C25B78
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 22:00:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2923988313;
	Wed, 15 May 2024 23:59:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="ozo/mG37";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B65028833B; Wed, 15 May 2024 23:59:33 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75E3B88319
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 23:59:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-61df903aa05so83780787b3.3
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 14:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1715810369; x=1716415169;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z9HcA4JWgPSDLRUXBlmOK4D2/vkAb1WX3O/b9Qc4PBQ=;
 b=ozo/mG37cwHkdL/+lQh3q3/cojVcI4DQDQs0KwvmllYHeylIiyo6YvsOEwA2y0l+nz
 eAprmXmKQJcm6MIfWpquE7kh/keYf6vCLMWo6dK1SUY7PN8cRJEEDo/qOCye75ezOzU7
 LDneifCDKl/q19u5VyLSeUeXbrn8fSDrJf6tk0wdi2+n0XMOyMSeUaWA20vHdCtf4RLU
 3YElg6gSkZtES8bWvwYz4CtQ4WYtW3uJfvYpJHW5Cb/Dk6bAGvMGyjCsV3ArJBZfoZ1R
 sHiOwryZn2hXkkhFTKEdYYJd9KJkt2dCmLMR7vX6JZpyNuJ4iLnXAnLE2Eag/jepIUJD
 QYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715810369; x=1716415169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z9HcA4JWgPSDLRUXBlmOK4D2/vkAb1WX3O/b9Qc4PBQ=;
 b=gizMA6QzJXKrx7dzAd4lMvP7yrM2TQ2Jez2o8MFYFxi/+FXNr8CziaWplIqaZUx/jT
 cBuS6ox0P3GHwlxYyk7L/tPm+HcVMhlPGgVSKuHNgNw5dGH3hx+lEZ+63TBX5K2mL8DB
 3h9XoVTvh0kSXY1QSHOWx0LQGYAWOT1V52FPGjmyAFF/abeWAG2p3sakC1W+QEbhIk5Y
 500XiV109PxET4bXNOD3/mD6bPUml6yvWku26PT+2jDLiWChsDT8tsBYeh/00M/9JKCk
 ZYstdEOcbKXBz2zPeKQYTsZOy467aP9yG2SPgeuDbD1r7D1GckyNXNO3kbMwggnqPT4H
 IikA==
X-Gm-Message-State: AOJu0Yypx3EjqmfOlK0MQQpe5irtFp2kcUxtN5AhXB+3uJSsMBOJOiYQ
 u2udrhmw6uvs4xip7t+D0ykU92L1vJ+pXYMiDbSRam6XTvgZQKZ2FSkJipncNtsH9HrRlZbPL4P
 gcA==
X-Google-Smtp-Source: AGHT+IGlQh/lHxroPa4f90vF+HgnEJ99fhLVTD+KWmDlit1lDbfp3i6AOny1y57QF/GfCN4N5+bEbQ==
X-Received: by 2002:a81:c842:0:b0:61b:bd7f:c9f5 with SMTP id
 00721157ae682-622aff7e7eemr208088157b3.4.1715810369130; 
 Wed, 15 May 2024 14:59:29 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6209e37913asm30956457b3.105.2024.05.15.14.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 14:59:28 -0700 (PDT)
From: Greg Malysa <greg.malysa@timesys.com>
To: u-boot@lists.denx.de
Cc: Matthew McClintock <Matthew.Mcclintock@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/11] usb: musb-new: Add support for Analog Devices SC5xx SoCs
Date: Wed, 15 May 2024 17:57:41 -0400
Message-ID: <20240515215837.14028-5-greg.malysa@timesys.com>
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

From: Nathan Barrett-Morrison <nathan.morrison@timesys.com>

This adds support for the MUSB-based USB controller found in the
Analog Devices SC57x and SC58x SoCs.

Co-developed-by: Greg Malysa <greg.malysa@timesys.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
Co-developed-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
---

 MAINTAINERS                   |   1 +
 drivers/usb/musb-new/Kconfig  |   7 ++
 drivers/usb/musb-new/Makefile |   1 +
 drivers/usb/musb-new/sc5xx.c  | 202 ++++++++++++++++++++++++++++++++++
 4 files changed, 211 insertions(+)
 create mode 100644 drivers/usb/musb-new/sc5xx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d07d13dbc..3bcdb73e6e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -615,6 +615,7 @@ F:	drivers/gpio/gpio-adi-adsp.c
 F:	drivers/pinctrl/pinctrl-adi-adsp.c
 F:	drivers/serial/serial_adi_uart4.c
 F:	drivers/timer/adi_sc5xx_timer.c
+F:	drivers/usb/musb-new/sc5xx.c
 F:	include/env/adi/
 
 ARM SNAPDRAGON
diff --git a/drivers/usb/musb-new/Kconfig b/drivers/usb/musb-new/Kconfig
index c52afd41a7..ad9072a532 100644
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
index 396ff02654..6638772dac 100644
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
index 0000000000..16201480b4
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
2.43.2

