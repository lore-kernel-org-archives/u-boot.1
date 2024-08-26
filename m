Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FDCC5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 14:39:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E494688A3C;
	Mon, 26 Aug 2024 16:39:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ab+SasUI";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rcqXYfI3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F3B0889CA; Mon, 26 Aug 2024 16:39:13 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8649288A1B
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 16:39:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Wstbg24lBz9skc;
 Mon, 26 Aug 2024 16:39:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1724683151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=30Eko83YyP2t2HpDTWXTjGJpp8M4ZeSZld95MMk7pcU=;
 b=ab+SasUIlDX/h3sUL78ezW2J21oBNek754RGa9emknAY77Mdq6wosEKVc4AyM5cKXGNKVs
 hgvu+lg/jIkXRai0GT9jytwOBgYZBhl5AiaQRZOYF+3QHHJPUVIftAHNBJEow5eCZ2zLJw
 2fafhigk+/raqqdKl5OiV+YAgRJYFvezVxdMi6B27x5TFXIlmVOnlPAwN0uhOJ6SJ+/lsh
 WewX5oDhYtTm+r4Yd4eq5eJBBUUI9u3Dvgs8vHQoZQx25spYYdPc8wQ0WcoU2TNBN1LECF
 r+90aZfj/I+E8PNqnssRgUpWNdkDEyeduncn6CdZAZVLbkfT9Ss/35+Kf/T2Gw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1724683149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=30Eko83YyP2t2HpDTWXTjGJpp8M4ZeSZld95MMk7pcU=;
 b=rcqXYfI3cvsFP65Y9/c4JOf29EL/4zpNK5CoCND8YkMG+RZpkdKzfNI1MVDH4kQwPbUtJA
 HjkuB59UQ+SmrzVVEPG+HTUpmwHtVtfI9HyfP0lvxJfIB7Gh171ZTD3YWxSDFsepqOHE1K
 c9boYyIqzVFTWoRQy0F8nc+rwkghwVSnw/DA4xFmHEo0J1LRGxHRgdYNNFWiuO1l3zMrXK
 37o7uBZuYECqgndsfPRlt39YU7Om3M5/QaYSWbkpNHGOP8P050hOm8YUn/pDUcSNqv1Z0I
 Nd3GRtC/ve4RAwi52PAifACo0p6TL8pgMpXy46zdivYQ96xT+q9MOa08ZYE3yg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Linus Walleij <linus.walleij@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>,
 Zixun LI <admin@hifiphile.com>
Subject: [PATCH 2/6] usb: gadget: Drop usb_udc_release()
Date: Mon, 26 Aug 2024 16:38:37 +0200
Message-ID: <20240826143851.8020-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240826143851.8020-1-marek.vasut+renesas@mailbox.org>
References: <20240826143851.8020-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: tb85otid5zrtnzjb75caxb5qnyowyd1i
X-MBO-RS-ID: 5894878e64bc99ca51d
X-Rspamd-Queue-Id: 4Wstbg24lBz9skc
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

This callback is never called, drop it. Instead, call kfree(udc)
in usb_del_gadget_udc() to free the struct usb_udc data.

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
 drivers/usb/gadget/udc/udc-core.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index 37c0ee43c52..275d6fe7be8 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -41,7 +41,6 @@ struct usb_udc {
 	struct list_head		list;
 };
 
-static struct class *udc_class;
 static LIST_HEAD(udc_list);
 DEFINE_MUTEX(udc_lock);
 
@@ -150,21 +149,6 @@ static inline void usb_gadget_udc_stop(struct usb_udc *udc)
 	udc->gadget->ops->udc_stop(udc->gadget);
 }
 
-/**
- * usb_udc_release - release the usb_udc struct
- * @dev: the dev member within usb_udc
- *
- * This is called by driver's core in order to free memory once the last
- * reference is released.
- */
-static void usb_udc_release(struct device *dev)
-{
-	struct usb_udc *udc;
-
-	udc = container_of(dev, struct usb_udc, dev);
-	kfree(udc);
-}
-
 /**
  * usb_add_gadget_udc - adds a new gadget to the udc class driver list
  * @parent: the parent device to this udc. Usually the controller driver's
@@ -185,8 +169,6 @@ int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget)
 	dev_set_name(&gadget->dev, "gadget");
 	gadget->dev.parent = parent;
 
-	udc->dev.release = usb_udc_release;
-	udc->dev.class = udc_class;
 	udc->dev.parent = parent;
 
 	udc->gadget = gadget;
@@ -247,6 +229,7 @@ found:
 
 	if (udc->driver)
 		usb_gadget_remove_driver(udc);
+	kfree(udc);
 }
 EXPORT_SYMBOL_GPL(usb_del_gadget_udc);
 
-- 
2.45.2

