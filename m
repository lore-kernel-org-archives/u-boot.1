Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDF2C44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 16:21:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7226984EDD;
	Thu, 16 Jul 2026 18:09:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZM2LU4KV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF49484CCF; Thu, 16 Jul 2026 15:44:56 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB67080433
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:44:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c1676648c1eso20164766b.0
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784209494; x=1784814294; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MqblMTGDuJDee1C54atGnIvCKV2Xp2cKb7e7Q6uPZKg=;
 b=ZM2LU4KVBZLnniFV2k8mRez+qX2vOLmMj2AK9KtpDlh0v/MVpRRV61Zovpv+yU6iNH
 SKNAS1k3cQiYJT93uv8bLTsWHHNZAqImiRlsikw3Bqmz89TZLcfG2REB1ZvIo2CnaiEj
 3Ru9GiJPqRIY7PnWgSx0W8JQuxdfehgp+ulIVHyZ27K+Snc+RotZOdnbcdUt1oYkocyq
 ym5b7UAshEANZKrR66cPjCBbTK4ZpCcfAH9IAyoYweJwufiLPpv88Imkr1hyJ5tXlBIE
 bJVaVKQK84Ec9avjGFvzWEP8KXM448avmWa0Yk3dHEWA9Fe5emmQg6ln29syVBSJKMlD
 k+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784209494; x=1784814294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MqblMTGDuJDee1C54atGnIvCKV2Xp2cKb7e7Q6uPZKg=;
 b=sSXKIGKpmTIbUqqU3x52EQC1Zk/TbvNlR1baSEjrOFVl0tauk7w1cmAVl35xuXvLfw
 ZQVqRzDGNu4puXkDZiN/harCWm3BcZ60Imh6UuAuWg4j0grf3m9S2qmlcayS5G9bVR5W
 xhXg1mTTybZiUDRO4B51HIlGNNWuUU1UPTmqaaQtUJbxekY6CGAXw8Y2BKbmr390gevV
 huYG16OOxhvIKe1qQ40dNZwU6KCZV+xPtTO33F2DM0jxQ3e2hfLyvfN8mD4gsU4vF0F7
 bA5XBAPeNjNQRpeeLUux6sTRMVQBkXv3HldE0WnWME9bMMWBmJl7jLyLB+QFsTNQMOyc
 j7ow==
X-Gm-Message-State: AOJu0YwV3S7TWeUZBKCxVnZ25+9XjeOpqYiGOoyjrenG6iPqgs5iIDI3
 r6XKz5f5M9ELnb5a7F+iXnZBepktjn6z96aivx7FL7VEWVo4CToYW2QQBGDYjiUiaNLzrunbkMN
 l9CKJ
X-Gm-Gg: AfdE7ck1MISr/emvIY/8tnvzJzmh8PXGwhe33xnfivwT1aSYqOIco8MP64xm7Wd8Bn7
 bsNgesyPfny8PbnKyGqhnA9tvQzOMWYHzavBMgkMJ43qup3Wc2vPOvfAtgXZa8oBJXw8PIb/QYv
 rNawjTT7JAr7QXErBrKRFrZieEH9Ba8eCfObISrJMlASLmGD4KRJd/wmyjjoDTlZCt+Bw7CiWoK
 keYqkJe+oxdhE/TVSi4UkSIrW1gGcKyBSLszJWKfgrpt6mWkXzBZqH2yz4LuwKi07rP17DuYikB
 M2yHoow4BQvvQiUbI/BWwf15z1rKoAdCcVNSdTgU+SBwLkIJzBPFwFeXEzATSpbEJF9CjLB3+/K
 osxOAxXbr1qxFGPGrTVTBzwLt2Lk62dZQ191MwcK4xx1MKwJbKje1UC2T4f73pfL9799ZfCnCZE
 snib05X4E5bGbrlmbPXR5z+a17mOdrRHPkazgS4Rb5ThrHT9fY
X-Received: by 2002:a17:907:5cc:b0:c12:c7ca:d704 with SMTP id
 a640c23a62f3a-c161f438d78mr694561866b.6.1784209494229; 
 Thu, 16 Jul 2026 06:44:54 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1687317904sm217497666b.35.2026.07.16.06.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:44:53 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v5 71/75] usb: gadget: dwc2_udc_otg: fix up after the resync
Date: Thu, 16 Jul 2026 15:42:41 +0200
Message-ID: <20260716134305.614278-72-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716134305.614278-1-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Jul 2026 18:09:05 +0200
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

Adapt dwc2_udc_otg to the gadget API changes from the resync.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/gadget/dwc2_udc_otg.c | 174 +++++++++---------------------
 1 file changed, 50 insertions(+), 124 deletions(-)

diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
index 570fed347c9e..b067745cb2e3 100644
--- a/drivers/usb/gadget/dwc2_udc_otg.c
+++ b/drivers/usb/gadget/dwc2_udc_otg.c
@@ -113,9 +113,6 @@ static void dwc2_handle_ep0(struct dwc2_udc *dev);
 static int dwc2_ep0_write(struct dwc2_udc *dev);
 static int write_fifo_ep0(struct dwc2_ep *ep, struct dwc2_request *req);
 static void done(struct dwc2_ep *ep, struct dwc2_request *req, int status);
-static void stop_activity(struct dwc2_udc *dev,
-			  struct usb_gadget_driver *driver);
-static int udc_enable(struct dwc2_udc *dev);
 static void udc_set_address(struct dwc2_udc *dev, unsigned char address);
 static void reconfig_usbd(struct dwc2_udc *dev);
 static void set_max_pktsize(struct dwc2_udc *dev, enum usb_device_speed speed);
@@ -170,22 +167,6 @@ __weak void otg_phy_off(struct dwc2_udc *dev) {}
 
 #include "dwc2_udc_otg_xfer_dma.c"
 
-/*
- *	udc_disable - disable USB device controller
- */
-static void udc_disable(struct dwc2_udc *dev)
-{
-	debug_cond(DEBUG_SETUP != 0, "%s: %p\n", __func__, dev);
-
-	udc_set_address(dev, 0);
-
-	dev->ep0state = WAIT_FOR_SETUP;
-	dev->gadget.speed = USB_SPEED_UNKNOWN;
-	dev->usb_address = 0;
-
-	otg_phy_off(dev);
-}
-
 /*
  *	udc_reinit - initialize software state
  */
@@ -219,6 +200,18 @@ static void udc_reinit(struct dwc2_udc *dev)
 #define BYTES2MAXP(x)	(x / 8)
 #define MAXP2BYTES(x)	(x * 8)
 
+static int dwc2_gadget_pullup(struct usb_gadget *g, int is_on)
+{
+	clrsetbits_le32(&reg->device_regs.dctl, DCTL_SFTDISCON,
+			is_on ? 0 : DCTL_SFTDISCON);
+
+	return 0;
+}
+
+#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
+
+#else /* !CONFIG_IS_ENABLED(DM_USB_GADGET) */
+
 /* until it's enabled, this UDC should be completely invisible
  * to any USB host.
  */
@@ -238,112 +231,73 @@ static int udc_enable(struct dwc2_udc *dev)
 	return 0;
 }
 
-static int dwc2_gadget_pullup(struct usb_gadget *g, int is_on)
-{
-	clrsetbits_le32(&reg->device_regs.dctl, DCTL_SFTDISCON,
-			is_on ? 0 : DCTL_SFTDISCON);
-
-	return 0;
-}
-
-#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
-/*
-  Register entry point for the peripheral controller driver.
-*/
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
+static int dwc2_gadget_start(struct usb_gadget *g,
+			     struct usb_gadget_driver *driver)
 {
 	struct dwc2_udc *dev = the_controller;
-	int retval = 0;
-	unsigned long flags = 0;
 
 	debug_cond(DEBUG_SETUP != 0, "%s: %s\n", __func__, "no name");
 
-	if (!driver || driver->speed < USB_SPEED_FULL
-	    || !driver->bind || !driver->disconnect || !driver->setup)
+	if (!driver || driver->speed < USB_SPEED_FULL ||
+	    !driver->bind || !driver->disconnect || !driver->setup)
 		return -EINVAL;
+
 	if (!dev)
 		return -ENODEV;
+
 	if (dev->driver)
 		return -EBUSY;
 
-	spin_lock_irqsave(&dev->lock, flags);
 	/* first hook up the driver ... */
 	dev->driver = driver;
-	spin_unlock_irqrestore(&dev->lock, flags);
-
-	if (retval) { /* TODO */
-		printf("target device_add failed, error %d\n", retval);
-		return retval;
-	}
-
-	retval = driver->bind(&dev->gadget);
-	if (retval) {
-		debug_cond(DEBUG_SETUP != 0,
-			   "%s: bind to driver --> error %d\n",
-			    dev->gadget.name, retval);
-		dev->driver = 0;
-		return retval;
-	}
-
-	enable_irq(IRQ_OTG);
 
 	debug_cond(DEBUG_SETUP != 0,
 		   "Registered gadget driver %s\n", dev->gadget.name);
-	udc_enable(dev);
-
-	return 0;
+	return udc_enable(dev);
 }
 
-/*
- * Unregister entry point for the peripheral controller driver.
- */
-int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
+static void stop_activity(struct dwc2_udc *dev,
+			  struct usb_gadget_driver *driver)
 {
-	struct dwc2_udc *dev = the_controller;
-	unsigned long flags = 0;
-
-	if (!dev)
-		return -ENODEV;
-	if (!driver || driver != dev->driver)
-		return -EINVAL;
+	int i;
 
-	spin_lock_irqsave(&dev->lock, flags);
-	dev->driver = 0;
-	stop_activity(dev, driver);
-	spin_unlock_irqrestore(&dev->lock, flags);
+	/* don't disconnect drivers more than once */
+	if (dev->gadget.speed == USB_SPEED_UNKNOWN)
+		driver = 0;
+	dev->gadget.speed = USB_SPEED_UNKNOWN;
 
-	driver->unbind(&dev->gadget);
+	/* prevent new request submissions, kill any outstanding requests  */
+	for (i = 0; i < DWC2_MAX_ENDPOINTS; i++) {
+		struct dwc2_ep *ep = &dev->ep[i];
+		ep->stopped = 1;
+		nuke(ep, -ESHUTDOWN);
+	}
 
-	disable_irq(IRQ_OTG);
+	/* report disconnect; the driver is already quiesced */
+	if (driver) {
+		spin_unlock(&dev->lock);
+		driver->disconnect(&dev->gadget);
+		spin_lock(&dev->lock);
+	}
 
-	udc_disable(dev);
-	return 0;
+	/* re-init driver-visible data structures */
+	udc_reinit(dev);
 }
-#else /* !CONFIG_IS_ENABLED(DM_USB_GADGET) */
 
-static int dwc2_gadget_start(struct usb_gadget *g,
-			     struct usb_gadget_driver *driver)
+/*
+ *	udc_disable - disable USB device controller
+ */
+static void udc_disable(struct dwc2_udc *dev)
 {
-	struct dwc2_udc *dev = the_controller;
-
-	debug_cond(DEBUG_SETUP != 0, "%s: %s\n", __func__, "no name");
-
-	if (!driver || driver->speed < USB_SPEED_FULL ||
-	    !driver->bind || !driver->disconnect || !driver->setup)
-		return -EINVAL;
-
-	if (!dev)
-		return -ENODEV;
+	debug_cond(DEBUG_SETUP != 0, "%s: %p\n", __func__, dev);
 
-	if (dev->driver)
-		return -EBUSY;
+	udc_set_address(dev, 0);
 
-	/* first hook up the driver ... */
-	dev->driver = driver;
+	dev->ep0state = WAIT_FOR_SETUP;
+	dev->gadget.speed = USB_SPEED_UNKNOWN;
+	dev->usb_address = 0;
 
-	debug_cond(DEBUG_SETUP != 0,
-		   "Registered gadget driver %s\n", dev->gadget.name);
-	return udc_enable(dev);
+	otg_phy_off(dev);
 }
 
 static int dwc2_gadget_stop(struct usb_gadget *g)
@@ -433,34 +387,6 @@ static void nuke(struct dwc2_ep *ep, int status)
 	}
 }
 
-static void stop_activity(struct dwc2_udc *dev,
-			  struct usb_gadget_driver *driver)
-{
-	int i;
-
-	/* don't disconnect drivers more than once */
-	if (dev->gadget.speed == USB_SPEED_UNKNOWN)
-		driver = 0;
-	dev->gadget.speed = USB_SPEED_UNKNOWN;
-
-	/* prevent new request submissions, kill any outstanding requests  */
-	for (i = 0; i < DWC2_MAX_ENDPOINTS; i++) {
-		struct dwc2_ep *ep = &dev->ep[i];
-		ep->stopped = 1;
-		nuke(ep, -ESHUTDOWN);
-	}
-
-	/* report disconnect; the driver is already quiesced */
-	if (driver) {
-		spin_unlock(&dev->lock);
-		driver->disconnect(&dev->gadget);
-		spin_lock(&dev->lock);
-	}
-
-	/* re-init driver-visible data structures */
-	udc_reinit(dev);
-}
-
 static void reconfig_usbd(struct dwc2_udc *dev)
 {
 	/* 2. Soft-reset OTG Core and then unreset again. */
-- 
2.53.0

