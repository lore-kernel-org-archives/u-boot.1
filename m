Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF4DC3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 13:37:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EC8688804;
	Tue, 23 Jul 2024 15:35:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="v5UKgD13";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23EFD88403; Mon, 22 Jul 2024 22:24:57 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5CDA87F82
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 22:24:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4279c924ca7so34463705e9.2
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 13:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1721679894; x=1722284694;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQ02ZX1txPMd10CED5ZPi4bo2deYGAzG9QzWytCBLBQ=;
 b=v5UKgD13LXyvEL3jjt5A+3DG24qndiTJWajEqGC4zMtpC9DoxT9jqUiFccoFydz3sC
 Dkb/nFRuvKSY8xat71Bq6a36KWxF8t7DB4IMVl7waUOizZqtF5/zbEn6s8p0QpFjxg3i
 qNSscV4YyyYG99O5C6cwY94EQkni1yviXgSVKTy8/JfqJG6bvJRZ/cLfrQm454+FrVca
 ibNs4Q7RsmRB44jvpbJtwnoIeUXzNc+XNH5/iXlVjR3vVWUI77UPfI/U+084vuFG/NfJ
 ZQr90SLdVZVEvpGwKx7uyUkSIzfF3lAcWHjhklK0R6uIfzHzk1CkLzijiHpPL4KbBZqS
 GCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721679894; x=1722284694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nQ02ZX1txPMd10CED5ZPi4bo2deYGAzG9QzWytCBLBQ=;
 b=Mv/CPF3kTdojXWx/LDe5eWdWG3xM1iNTcUV0BA1HrAV4ANaPQD+2bsQL/vv5G3BgJs
 y60zlsSsoImv3rBJ5nupojsMbFX3wMrWVE22pWltChaZjIm/DPPaloe6PTlo7v3aWgbg
 yZgMjVrTiuZy0hMgE0shZQaplrSSgIwwnkQHgocElMxPAVQRQdwuz3vxP5lpBhLQMyfc
 BCMp6v98JZv7k0RAlVjJzsEZt2s+ckMf0hPhPNTbVfrKt+MpATrBBEK20ScxwzhSksxF
 IRLf1CYgs9aeZQs6r9OB73OH5s9xvy3YF4UAE6gwdygHFsfXa1k2FJSup24fzmyG21Q2
 i/qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU34yixXuh+rqVHIY19uJq/7F+OXlNLYnre0urQ0i1a3/57SUw64Mg4b1wB5gDzvAYKGaQRx2PMaOroMV7xBKd209btTQ==
X-Gm-Message-State: AOJu0Yx8Kzt7fA0We1O0HqGTprKc6JHC71JHQT3lY9NRS9PvaC0/Gq1q
 wUC7MsyattC+gaqQY74yiieJOSLsFqrzSYVSWcAZQP9+LuGFtoPLAgjFXII40D0=
X-Google-Smtp-Source: AGHT+IGwB8d89uQwxToS9Wdd9gXPHoJh9fRQDssEocWGSBAscMbSXA0f8J5UDZ6kyGtJJhE3sJVAkA==
X-Received: by 2002:a05:600c:3c8c:b0:426:5dc8:6a63 with SMTP id
 5b1f17b1804b1-427dc568cb5mr44404135e9.30.1721679894285; 
 Mon, 22 Jul 2024 13:24:54 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69071d0sm142982855e9.26.2024.07.22.13.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 13:24:53 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
X-Google-Original-From: Zixun LI <zli@ogga.fr>
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>,
	u-boot@lists.denx.de
Subject: [PATCH v2 4/4] usb: gadget: atmel: Add DM_USB_GADGET support
Date: Mon, 22 Jul 2024 22:23:30 +0200
Message-ID: <20240722202426.190986-5-zli@ogga.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722202426.190986-1-zli@ogga.fr>
References: <20240722202426.190986-1-zli@ogga.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 23 Jul 2024 15:35:55 +0200
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

Add driver model support by using the uclass UCLASS_USB_GADGET_GENERIC.

Disable local usb_gadget_register_driver()/usb_gadget_unregister_driver()
implementation which is implemented in udc-core.c when DM_USB_GADGET
is enabled.

Replace dm_usb_gadget_handle_interrupts() with handle_interrupts ops
when DM_USB_GADGET is enabled.

Disable legacy usba_udc_probe() to avoid conflict with DM when it's
enabled.

Compared to Linux driver only supported devices' DT bindings are included
(sorted as Linux driver)

Signed-off-by: Zixun LI <zli@ogga.fr>
---
 drivers/usb/gadget/atmel_usba_udc.c | 123 ++++++++++++++++++++++++++++
 include/linux/usb/atmel_usba_udc.h  |   2 +
 2 files changed, 125 insertions(+)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index 46f7ae9a0c..95abb86840 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -8,10 +8,13 @@
  */
 
 #include <clk.h>
+#include <dm.h>
 #include <log.h>
 #include <malloc.h>
 #include <asm/gpio.h>
 #include <asm/hardware.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
 #include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/list.h>
@@ -19,6 +22,10 @@
 #include <linux/usb/gadget.h>
 #include <linux/usb/atmel_usba_udc.h>
 
+#if CONFIG_IS_ENABLED(DM_USB_GADGET)
+#include <mach/atmel_usba_udc.h>
+#endif /* CONFIG_IS_ENABLED(DM_USB_GADGET) */
+
 #include "atmel_usba_udc.h"
 
 static struct usba_udc *controller;
@@ -1193,6 +1200,7 @@ static int usba_udc_pullup(struct usb_gadget *g, int is_on)
 	return 0;
 }
 
+#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
 int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 {
 	struct usba_udc *udc = controller;
@@ -1246,11 +1254,40 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 	return 0;
 }
 
+#else /* !CONFIG_IS_ENABLED(DM_USB_GADGET) */
+static int usba_udc_start(struct usb_gadget *g,
+			  struct usb_gadget_driver *driver)
+{
+	struct usba_udc *udc = controller;
+
+	usba_udc_enable(udc);
+
+	udc->driver = driver;
+
+	return 0;
+}
+
+static int usba_udc_stop(struct usb_gadget *g)
+{
+	struct usba_udc *udc = controller;
+
+	udc->driver = NULL;
+
+	usba_udc_disable(udc);
+
+	return 0;
+}
+#endif /* !CONFIG_IS_ENABLED(DM_USB_GADGET) */
+
 static const struct usb_gadget_ops usba_udc_ops = {
 	.get_frame		= usba_udc_get_frame,
 	.wakeup			= usba_udc_wakeup,
 	.set_selfpowered	= usba_udc_set_selfpowered,
 	.pullup			= usba_udc_pullup,
+#if CONFIG_IS_ENABLED(DM_USB_GADGET)
+	.udc_start		= usba_udc_start,
+	.udc_stop		= usba_udc_stop,
+#endif
 };
 
 static struct usba_udc udc_controller = {
@@ -1305,6 +1342,7 @@ static struct usba_ep *usba_udc_pdata(struct usba_platform_data *pdata,
 	return eps;
 }
 
+#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
 int usba_udc_probe(struct usba_platform_data *pdata)
 {
 	controller = &udc_controller;
@@ -1313,3 +1351,88 @@ int usba_udc_probe(struct usba_platform_data *pdata)
 
 	return 0;
 }
+
+#else /* !CONFIG_IS_ENABLED(DM_USB_GADGET) */
+struct usba_priv_data {
+	struct clk_bulk		clks;
+};
+
+static int usba_udc_clk_init(struct udevice *dev, struct clk_bulk *clks)
+{
+	int ret;
+
+	ret = clk_get_bulk(dev, clks);
+	if (ret == -ENOSYS)
+		return 0;
+
+	if (ret)
+		return ret;
+
+	ret = clk_enable_bulk(clks);
+	if (ret) {
+		clk_release_bulk(clks);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int usba_udc_probe(struct udevice *dev)
+{
+	struct usba_priv_data *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = usba_udc_clk_init(dev, &priv->clks);
+	if (ret)
+		return ret;
+
+	controller = &udc_controller;
+
+	controller->usba_ep = usba_udc_pdata(&pdata, controller);
+
+	controller->driver = 0;
+
+	ret = usb_add_gadget_udc((struct device *)dev, &controller->gadget);
+
+	return ret;
+}
+
+static int usba_udc_remove(struct udevice *dev)
+{
+	struct usba_priv_data *priv = dev_get_priv(dev);
+
+	usb_del_gadget_udc(&controller->gadget);
+
+	clk_release_bulk(&priv->clks);
+
+	return dm_scan_fdt_dev(dev);
+}
+
+static int usba_udc_handle_interrupts(struct udevice *dev)
+{
+	struct usba_udc *udc = controller;
+
+	return usba_udc_irq(udc);
+}
+
+static const struct usb_gadget_generic_ops usba_udc_gadget_ops = {
+	.handle_interrupts	= usba_udc_handle_interrupts,
+};
+
+static const struct udevice_id usba_udc_ids[] = {
+	{ .compatible = "atmel,at91sam9rl-udc" },
+	{ .compatible = "atmel,at91sam9g45-udc" },
+	{ .compatible = "atmel,sama5d3-udc" },
+	{}
+};
+
+U_BOOT_DRIVER(ateml_usba_udc) = {
+	.name	= "ateml_usba_udc",
+	.id	= UCLASS_USB_GADGET_GENERIC,
+	.of_match = usba_udc_ids,
+	.ops = &usba_udc_gadget_ops,
+	.probe = usba_udc_probe,
+	.remove = usba_udc_remove,
+	.priv_auto = sizeof(struct usba_priv_data),
+};
+#endif /* !CONFIG_IS_ENABLED(DM_USB_GADGET) */
diff --git a/include/linux/usb/atmel_usba_udc.h b/include/linux/usb/atmel_usba_udc.h
index c1c810759c..37c4f21849 100644
--- a/include/linux/usb/atmel_usba_udc.h
+++ b/include/linux/usb/atmel_usba_udc.h
@@ -20,6 +20,8 @@ struct usba_platform_data {
 	struct usba_ep_data	*ep;
 };
 
+#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
 extern int usba_udc_probe(struct usba_platform_data *pdata);
+#endif
 
 #endif /* __LINUX_USB_USBA_H */
-- 
2.45.2

