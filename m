Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8DBC3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 13:39:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F5928880E;
	Tue, 23 Jul 2024 15:36:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="1l8Qoo4b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2694887B4; Tue, 23 Jul 2024 15:19:16 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7B75887C0
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 15:18:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-427d2c8c632so39263325e9.2
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 06:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1721740733; x=1722345533;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S7YGTRNAP4Qvs03ij7q9pLjWucU4FpHpqQyRMNIRFE8=;
 b=1l8Qoo4bR+v+ElTugbrJ79Vkr4ruI9cnWKRibReAK30xLUPKIcd9sG7nDQ3ENw8VkM
 sTVHAgd74xpbtDXaqDzT2cUxoTCO/X6FKYF4f7lHTzATN3VDJ3g9LYJwVD6C5MUV6m/g
 6OCqAW5rqWed+T5FCzn3fhDa4FGpS6AlE1/jaU+uWpjLTudS8QW4hr5z0hIhKrY71wGY
 VQ4HCkG7UeA60r8e/Hr/CHsQXPacGMhAQ6CQnhIS8OMtRujS3efz85hwVegNsY6K9cI4
 KdmI5J/nRN2DSkkGAHD473q/o7ZrjRwRXenz2yNctbPbTRxXYgfMs40dzNKl2kbQ56J6
 e39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721740733; x=1722345533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S7YGTRNAP4Qvs03ij7q9pLjWucU4FpHpqQyRMNIRFE8=;
 b=ftw38QrKPnHJnIqHVAxwaMcnJW+13vn2/3MIP98f8pkms+8WtLRXajTabKXQEboOLz
 xoOthkN9ou0TS7OPTvVLqw10pI4nLMWNOfTLbUudP9kF/1y8kVkZn5W0Sc+GfM44bPbV
 uaqPNACnzGdA3wgISLvRZ8HXOD8z2O4WHpgyLiIT5jlxlioMnBp3uafNL4lQwPTx9Yx4
 vifYC8Jmvop4cgzH+myoIS0t9VHQvh/Kk2vUzG3jQ2ShpGGbIDkeP8wDSh91/cMSuKIh
 YvdBP81UxpArDtCZk18hzOdWIWdQQbsJkkjJeCx+alLkEqliUq95Fncp7tgxycp2NLTy
 rlhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpTw8s2HkLArz/GIs8OYWFqanTE5E+BqFSP2AJI0bMSuv2lG8+UurtKjU5aL5BYnaOM+7bV4+akxb9GXj8I79Un2DlPw==
X-Gm-Message-State: AOJu0YyLHunMUlHIUfTH85Z7UAK7o9i5CgGxAdPrm9ZdjAVpxOSijuph
 cLaoke99lG8bQSYTLpsV3ogrMeFXvUbGhkw1WO5R402OcYCg7WLmj+ed6vHB5Zo=
X-Google-Smtp-Source: AGHT+IHQOCPsh7UUuCNTRch4XaOZMoAPu/3b2I7rwBwH8uMAgHwxRJbwzL54BDY3I+Znt10iO/YHiA==
X-Received: by 2002:a05:600c:82c3:b0:426:5d37:67f0 with SMTP id
 5b1f17b1804b1-427dc548f5bmr69203155e9.13.1721740733057; 
 Tue, 23 Jul 2024 06:18:53 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427db2a4e3bsm140312545e9.44.2024.07.23.06.18.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 06:18:50 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
X-Google-Original-From: Zixun LI <zli@ogga.fr>
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>,
	u-boot@lists.denx.de
Subject: [PATCH v3 7/7] usb: gadget: atmel: Add DM_USB_GADGET support
Date: Tue, 23 Jul 2024 15:18:14 +0200
Message-ID: <20240723131817.262596-8-zli@ogga.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723131817.262596-1-zli@ogga.fr>
References: <20240723131817.262596-1-zli@ogga.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 23 Jul 2024 15:35:56 +0200
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

Disable legacy struct usba_udc controller as controller point is extracted
from udevice private data with DM.

Disable legacy usba_udc_probe() to avoid conflict with DM when it's
enabled.

Compared to Linux driver only supported devices' DT bindings are included
(sorted as Linux driver)

Signed-off-by: Zixun LI <zli@ogga.fr>
---
 drivers/usb/gadget/atmel_usba_udc.c | 138 ++++++++++++++++++++++++++++
 drivers/usb/gadget/atmel_usba_udc.h |   3 +
 include/linux/usb/atmel_usba_udc.h  |   2 +
 3 files changed, 143 insertions(+)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index a7b96449f8..b7b2e5196b 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -7,10 +7,14 @@
  *			   Bo Shen <voice.shen@atmel.com>
  */
 
+#include <clk.h>
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
@@ -18,6 +22,14 @@
 #include <linux/usb/gadget.h>
 #include <linux/usb/atmel_usba_udc.h>
 
+#if CONFIG_IS_ENABLED(DM_USB_GADGET)
+#include <mach/atmel_usba_udc.h>
+
+static int usba_udc_start(struct usb_gadget *gadget,
+			  struct usb_gadget_driver *driver);
+static int usba_udc_stop(struct usb_gadget *gadget);
+#endif /* CONFIG_IS_ENABLED(DM_USB_GADGET) */
+
 #include "atmel_usba_udc.h"
 
 static int vbus_is_present(struct usba_udc *udc)
@@ -528,6 +540,10 @@ static const struct usb_gadget_ops usba_udc_ops = {
 	.wakeup			= usba_udc_wakeup,
 	.set_selfpowered	= usba_udc_set_selfpowered,
 	.pullup			= usba_udc_pullup,
+#if CONFIG_IS_ENABLED(DM_USB_GADGET)
+	.udc_start		= usba_udc_start,
+	.udc_stop		= usba_udc_stop,
+#endif
 };
 
 static struct usb_endpoint_descriptor usba_ep0_desc = {
@@ -1237,6 +1253,7 @@ static struct usba_ep *usba_udc_pdata(struct usba_platform_data *pdata,
 	return eps;
 }
 
+#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
 static struct usba_udc controller = {
 	.regs = (unsigned *)ATMEL_BASE_UDPHS,
 	.fifo = (unsigned *)ATMEL_BASE_UDPHS_FIFO,
@@ -1312,3 +1329,124 @@ int usba_udc_probe(struct usba_platform_data *pdata)
 
 	return 0;
 }
+
+#else /* !CONFIG_IS_ENABLED(DM_USB_GADGET) */
+struct usba_priv_data {
+	struct clk_bulk		clks;
+	struct usba_udc		udc;
+};
+
+static int usba_udc_start(struct usb_gadget *gadget,
+			  struct usb_gadget_driver *driver)
+{
+	struct usba_udc *udc = to_usba_udc(gadget);
+
+	usba_udc_enable(udc);
+
+	udc->driver = driver;
+
+	return 0;
+}
+
+static int usba_udc_stop(struct usb_gadget *gadget)
+{
+	struct usba_udc *udc = to_usba_udc(gadget);
+
+	udc->driver = NULL;
+
+	usba_udc_disable(udc);
+
+	return 0;
+}
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
+	struct usba_udc *udc = &priv->udc;
+	int ret;
+
+	ret = usba_udc_clk_init(dev, &priv->clks);
+	if (ret)
+		return ret;
+
+	udc->fifo = (void __iomem *)dev_remap_addr_index(dev, FIFO_IOMEM_ID);
+	if (!udc->fifo)
+		return -EINVAL;
+
+	udc->regs = (void __iomem *)dev_remap_addr_index(dev, CTRL_IOMEM_ID);
+	if (!udc->regs)
+		return -EINVAL;
+
+	udc->gadget.ops = &usba_udc_ops;
+	udc->gadget.speed = USB_SPEED_HIGH,
+	udc->gadget.is_dualspeed = 1,
+	udc->gadget.name = "atmel_usba_udc",
+
+	udc->usba_ep = usba_udc_pdata(&pdata, udc);
+
+	udc->driver = NULL;
+
+	ret = usb_add_gadget_udc((struct device *)dev, &udc->gadget);
+
+	return ret;
+}
+
+static int usba_udc_remove(struct udevice *dev)
+{
+	struct usba_priv_data *priv = dev_get_priv(dev);
+
+	usb_del_gadget_udc(&priv->udc.gadget);
+
+	clk_release_bulk(&priv->clks);
+
+	return dm_scan_fdt_dev(dev);
+}
+
+static int usba_udc_handle_interrupts(struct udevice *dev)
+{
+	struct usba_priv_data *priv = dev_get_priv(dev);
+
+	return usba_udc_irq(&priv->udc);
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
+U_BOOT_DRIVER(atmel_usba_udc) = {
+	.name	= "atmel_usba_udc",
+	.id	= UCLASS_USB_GADGET_GENERIC,
+	.of_match = usba_udc_ids,
+	.ops = &usba_udc_gadget_ops,
+	.probe = usba_udc_probe,
+	.remove = usba_udc_remove,
+	.priv_auto = sizeof(struct usba_priv_data),
+};
+#endif /* !CONFIG_IS_ENABLED(DM_USB_GADGET) */
diff --git a/drivers/usb/gadget/atmel_usba_udc.h b/drivers/usb/gadget/atmel_usba_udc.h
index f6cb48c1cf..7f5e98f6c4 100644
--- a/drivers/usb/gadget/atmel_usba_udc.h
+++ b/drivers/usb/gadget/atmel_usba_udc.h
@@ -211,6 +211,9 @@
 #define EP0_EPT_SIZE		USBA_EPT_SIZE_64
 #define EP0_NR_BANKS		1
 
+#define FIFO_IOMEM_ID	0
+#define CTRL_IOMEM_ID	1
+
 #define DBG_ERR		0x0001	/* report all error returns */
 #define DBG_HW		0x0002	/* debug hardware initialization */
 #define DBG_GADGET	0x0004	/* calls to/from gadget driver */
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

