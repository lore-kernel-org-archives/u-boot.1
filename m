Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D02C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 14:40:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7568388A7D;
	Mon, 26 Aug 2024 16:39:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HCs4h++n";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="M+CJpSon";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4169E884DB; Mon, 26 Aug 2024 16:39:19 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 341E68891B
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 16:39:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Wstbm6tnfz9sc8;
 Mon, 26 Aug 2024 16:39:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1724683157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q6g+sw8P74IQuyKf9zXbNPyAEnVyY2BTHAJz6KXLX64=;
 b=HCs4h++nyPn+M0/8cAw0jY5FDllYCqST8jyw0PEHeYeutPSJO9oGtBwMei3fxI2t3s+KXw
 MBfkQOoY/fQlvd844jBVwDDqQwVpTqGHYNiRsoGsUcD4ieZ/A8WVrJoKU362yeTuwF8Mcq
 fFymt/zthWW8wMcadeZzE6PTyqqSGAntB9zHIUI0RVsMRvMyrHXWE37lGTpQnaWAmOZiuJ
 HSqdlXxntdjz2WsWkS+vj0z1eY0QiYndq9MelFiJy4uwB7mKRBtxQuDggROxautD43IKfx
 zkvZKqhiR8fxoaSvZbi6E5SdCjjuf43gu5mpLWqgJSNxziB350KCG8qjx6QMtA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1724683155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q6g+sw8P74IQuyKf9zXbNPyAEnVyY2BTHAJz6KXLX64=;
 b=M+CJpSonV7vn+5y5HjZoTMlJ3+AR96AX8VbViNoB20YyyCHi4o1mSu99l4mHDq87/SPRKv
 znCzcAtQ1El5351XdDXKH/wX+O20JVJv6Xwh0y7iWZb5CrV+rEyf7+De1Axfn5nHcqureM
 XkhU6xePqLZPf94GZTVL7stpr/lPjlHgRplcEzmiuA3rKabv9enpIPL5z1MJ2I9eUNF8ek
 JX52B1y4xF4YYOnfHk82sd3fYljgXuW6kfvCjcZf9zm837uygvzHLsBQQ2tcB49A3xt1no
 ehm8PiRdEfm6+vf7Cg+LrRS6sD9BPxzlrUfnhW68qh6mcUIkhIRhD85YnNIW+w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Linus Walleij <linus.walleij@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>,
 Zixun LI <admin@hifiphile.com>
Subject: [PATCH 6/6] usb: gadget: Pass struct udevice to usb_add_gadget_udc()
Date: Mon, 26 Aug 2024 16:38:41 +0200
Message-ID: <20240826143851.8020-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240826143851.8020-1-marek.vasut+renesas@mailbox.org>
References: <20240826143851.8020-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 06de15503c370730942
X-MBO-RS-META: 5w5uygpuut6h8biqnfj79yxbndt8fbpm
X-Rspamd-Queue-Id: 4Wstbm6tnfz9sc8
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

Almost every UDC driver already passes casted pointer to struct udevice
usb_add_gadget_udc(), even if the behavior is not exactly correct. That
struct udevice is at risk of being corrupted in case something modified
it in the UDC core, which does not happen right now. Switch UDC core to
use struct udevice outright and drop the casts.

UX500 has to be updated slightly, as that is the last place which does
correctly use private struct device instance.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Zixun LI <admin@hifiphile.com>
---
 drivers/usb/cdns3/gadget.c        |  2 +-
 drivers/usb/dwc3/gadget.c         |  2 +-
 drivers/usb/gadget/dwc2_udc_otg.c |  2 +-
 drivers/usb/gadget/max3420_udc.c  |  2 +-
 drivers/usb/gadget/udc/udc-core.c | 19 +++++++++----------
 drivers/usb/mtu3/mtu3_gadget.c    |  2 +-
 drivers/usb/musb-new/omap2430.c   |  2 +-
 drivers/usb/musb-new/ti-musb.c    |  2 +-
 drivers/usb/musb-new/ux500.c      |  2 +-
 include/linux/usb/gadget.h        |  4 ++--
 10 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 32b2c412068..b3513cc9bdc 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -2660,7 +2660,7 @@ static int cdns3_gadget_start(struct cdns3 *cdns)
 	}
 
 	/* add USB gadget device */
-	ret = usb_add_gadget_udc((struct device *)priv_dev->dev,
+	ret = usb_add_gadget_udc(priv_dev->dev,
 				 &priv_dev->gadget);
 	if (ret < 0) {
 		dev_err(priv_dev->dev,
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index fe33e307d3e..a3c3437aa3e 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2688,7 +2688,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	if (ret)
 		goto err4;
 
-	ret = usb_add_gadget_udc((struct device *)dwc->dev, &dwc->gadget);
+	ret = usb_add_gadget_udc(dwc->dev, &dwc->gadget);
 	if (ret) {
 		dev_err(dwc->dev, "failed to register udc\n");
 		goto err4;
diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
index fbd6c9600fc..4b6327d86d1 100644
--- a/drivers/usb/gadget/dwc2_udc_otg.c
+++ b/drivers/usb/gadget/dwc2_udc_otg.c
@@ -1135,7 +1135,7 @@ static int dwc2_udc_otg_probe(struct udevice *dev)
 
 	the_controller->driver = 0;
 
-	ret = usb_add_gadget_udc((struct device *)dev, &the_controller->gadget);
+	ret = usb_add_gadget_udc(dev, &the_controller->gadget);
 
 	return ret;
 }
diff --git a/drivers/usb/gadget/max3420_udc.c b/drivers/usb/gadget/max3420_udc.c
index 557a1f0644e..7df73cd3625 100644
--- a/drivers/usb/gadget/max3420_udc.c
+++ b/drivers/usb/gadget/max3420_udc.c
@@ -836,7 +836,7 @@ static int max3420_udc_probe(struct udevice *dev)
 	max3420_setup_eps(udc);
 	max3420_setup_spi(udc);
 
-	usb_add_gadget_udc((struct device *)dev, &udc->gadget);
+	usb_add_gadget_udc(dev, &udc->gadget);
 
 	return 0;
 }
diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index 275d6fe7be8..102d74ec02a 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -37,7 +37,7 @@
 struct usb_udc {
 	struct usb_gadget_driver	*driver;
 	struct usb_gadget		*gadget;
-	struct device			dev;
+	struct udevice			*dev;
 	struct list_head		list;
 };
 
@@ -157,7 +157,7 @@ static inline void usb_gadget_udc_stop(struct usb_udc *udc)
  *
  * Returns zero on success, negative errno otherwise.
  */
-int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget)
+int usb_add_gadget_udc(struct udevice *parent, struct usb_gadget *gadget)
 {
 	struct usb_udc		*udc;
 	int			ret = -ENOMEM;
@@ -166,10 +166,9 @@ int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget)
 	if (!udc)
 		goto err1;
 
-	dev_set_name(&gadget->dev, "gadget");
-	gadget->dev.parent = parent;
+	gadget->dev = parent;
 
-	udc->dev.parent = parent;
+	udc->dev = parent;
 
 	udc->gadget = gadget;
 
@@ -189,7 +188,7 @@ EXPORT_SYMBOL_GPL(usb_add_gadget_udc);
 
 static void usb_gadget_remove_driver(struct usb_udc *udc)
 {
-	dev_dbg(&udc->dev, "unregistering UDC driver [%s]\n",
+	dev_dbg(udc->dev, "unregistering UDC driver [%s]\n",
 			udc->driver->function);
 
 	usb_gadget_disconnect(udc->gadget);
@@ -216,13 +215,13 @@ void usb_del_gadget_udc(struct usb_gadget *gadget)
 		if (udc->gadget == gadget)
 			goto found;
 
-	dev_err(gadget->dev.parent, "gadget not registered.\n");
+	dev_err(gadget->dev, "gadget not registered.\n");
 	mutex_unlock(&udc_lock);
 
 	return;
 
 found:
-	dev_vdbg(gadget->dev.parent, "unregistering gadget\n");
+	dev_vdbg(gadget->dev, "unregistering gadget\n");
 
 	list_del(&udc->list);
 	mutex_unlock(&udc_lock);
@@ -260,7 +259,7 @@ static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *dri
 {
 	int ret;
 
-	dev_dbg(&udc->dev, "registering UDC driver [%s]\n",
+	dev_dbg(udc->dev, "registering UDC driver [%s]\n",
 			driver->function);
 
 	udc->driver = driver;
@@ -280,7 +279,7 @@ static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *dri
 	return 0;
 err1:
 	if (ret != -EISNAM)
-		dev_err(&udc->dev, "failed to start %s: %d\n",
+		dev_err(udc->dev, "failed to start %s: %d\n",
 			udc->driver->function, ret);
 	udc->driver = NULL;
 	return ret;
diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index 027b7e61113..949b22f41c7 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -631,7 +631,7 @@ int mtu3_gadget_setup(struct mtu3 *mtu)
 
 	mtu3_gadget_init_eps(mtu);
 
-	return usb_add_gadget_udc((struct device *)mtu->dev, &mtu->g);
+	return usb_add_gadget_udc(mtu->dev, &mtu->g);
 }
 
 void mtu3_gadget_cleanup(struct mtu3 *mtu)
diff --git a/drivers/usb/musb-new/omap2430.c b/drivers/usb/musb-new/omap2430.c
index ba600d01102..54dff01db71 100644
--- a/drivers/usb/musb-new/omap2430.c
+++ b/drivers/usb/musb-new/omap2430.c
@@ -231,7 +231,7 @@ static int omap2430_musb_probe(struct udevice *dev)
 		if (!host->host)
 			return -EIO;
 
-		return usb_add_gadget_udc((struct device *)otg_board_data, &host->host->g);
+		return usb_add_gadget_udc(dev, &host->host->g);
 	}
 
 	musbp = musb_register(&plat->plat, (struct device *)otg_board_data,
diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
index ec1baa9337d..9e3f793af06 100644
--- a/drivers/usb/musb-new/ti-musb.c
+++ b/drivers/usb/musb-new/ti-musb.c
@@ -247,7 +247,7 @@ static int ti_musb_peripheral_probe(struct udevice *dev)
 
 	ti_musb_set_phy_power(dev, 1);
 	musb_gadget_setup(priv->periph);
-	return usb_add_gadget_udc((struct device *)dev, &priv->periph->g);
+	return usb_add_gadget_udc(dev, &priv->periph->g);
 }
 
 static int ti_musb_peripheral_remove(struct udevice *dev)
diff --git a/drivers/usb/musb-new/ux500.c b/drivers/usb/musb-new/ux500.c
index be0085f403d..c994dc2f04d 100644
--- a/drivers/usb/musb-new/ux500.c
+++ b/drivers/usb/musb-new/ux500.c
@@ -130,7 +130,7 @@ static int ux500_musb_probe(struct udevice *dev)
 	if (!host->host)
 		return -EIO;
 
-	return usb_add_gadget_udc(&glue->dev, &host->host->g);
+	return usb_add_gadget_udc(dev, &host->host->g);
 #endif
 }
 
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 194025ebd12..e631f71eab8 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -543,7 +543,7 @@ struct usb_gadget {
 	unsigned			a_hnp_support:1;
 	unsigned			a_alt_hnp_support:1;
 	const char			*name;
-	struct device			dev;
+	struct udevice			*dev;
 	void				*driver_data;
 	unsigned			quirk_ep_out_aligned_size:1;
 };
@@ -886,7 +886,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver);
  */
 int usb_gadget_unregister_driver(struct usb_gadget_driver *driver);
 
-int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget);
+int usb_add_gadget_udc(struct udevice *parent, struct usb_gadget *gadget);
 void usb_del_gadget_udc(struct usb_gadget *gadget);
 /*-------------------------------------------------------------------------*/
 
-- 
2.45.2

