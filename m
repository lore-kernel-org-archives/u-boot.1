Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A52C5DF89
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:16:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C011740EAD;
	Fri, 21 Aug 2026 13:16:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L-Eguj_R0aBZ; Fri, 21 Aug 2026 13:16:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318150;
	bh=a0skoXip4HNvsNuQzwOisKcXucwWRttVxVD4l0eDTSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Odlxo5W3zTk46Yi2aWqMLcZSLr8un81QdzKjhoQoKdy3wFuKzbnvQA5UsLR4z+CZj
	 twhRpwTzMute9ABuzLhMxiYzK8j4qVGZpjQryAPqKSsJPVXNJ7FStI8xWZWqRXllKc
	 rhEu1izGRYtRwRX4p0cx1BjbK6l/DCf2Xsu8+4n200yrQ4odlXffFse2bWRi4oRvAJ
	 1nwJ3mQNPyRN0Z+Qtliw+HqRk9brGP4cQ3jxwFdHXMV1a+R0DE/HouGGOsEpKgQ16L
	 GCXRAwVrwTijq5XYMSLYWeBn5/yY9+yEJp55wym/cZh3TwcWGAwSYlCc3Am1zQa3l3
	 2JRTvfN3P5yVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD75F40DEA;
	Fri, 21 Aug 2026 13:15:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6EDDD279
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 60E3D4090E
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q3bBIIHD1e5Z for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:52:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=Y8eF9ppB
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2EBFF407E5
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:40 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c082647cd0dso6446266b.0
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302358; x=1787907158;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a0skoXip4HNvsNuQzwOisKcXucwWRttVxVD4l0eDTSU=;
 b=Y8eF9ppB0Ah/zCgIDo9WikAJ5NIc0oLKDejo4LYgmxU0/y8vfoPad4H6advlamPnQ1
 p4DzFuU3E78b8JOhjpHh9mLTNhwxv+9tYYofn00wCUTw9r2INlOCVkDgsPhYg0DTPRlx
 hZWlenEVLUbezUBi2e0yMbF758Lab123t1tjg5YACy/SVHr3Up4TDCm4HNO/D0k6gE5/
 bH73nvAjcRXXCc8Ing7J5WgEf6XsBq9Xj28eEOUGKYf+Q/y7k8EvPaVxkkMVwP0duFB1
 EkdBZXQY7SyZhaTvwbm7P9gXYrPK3gfHdK6TrVV5HapqnU13roVFGqMFnr+gUj4KQFMa
 KtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302358; x=1787907158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=a0skoXip4HNvsNuQzwOisKcXucwWRttVxVD4l0eDTSU=;
 b=F4O1TN+4J94qSO9iI/I5DF1Lln5QLO5aHh/CquyirrCjbICsw5mzBZ4/zNCVQ28kIy
 KIXPf3xNoau9AoebMo6T2lcGqVG4kuuFImBx1yp4kN2viSAq++kQPe1dAQ5C7oci72xY
 1QzlfAxLCrwqPHXLO8IUv4EPW1v3AwTGmEhXam3cVwdn0qkie+9FWOCMRLCVlk/rWo/z
 6TkZK0zbbeSXk/DGpMoMQKZ04GfBLcWDmKdepQa3FuaYlovk97Y24JjlWMf0iR3aBQ+3
 BAffQNymZT2RE2Pi3TyJOBXxQwFxbZe4xjrV2hSJ9UR5mXJ+9i7z5gFsd4pJS69V3MLW
 XAKA==
X-Forwarded-Encrypted: i=1;
 AHgh+RowlFjj3GAX1JVJ+cpMkI1EKQdGOtjuXwMfsXh+ifWy/6oOnbVJNhvX0CsuuhiP2fl5/tHY0Ck=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mOjNsRoSQTi78EvDzVU1AJn4CVNPANDv552awmFooPSRF0148y
 4C4uUB1YOI5ZP/r9NijwDCE7YC2LzgUs/DWqwDfhoaWZigl87Vbftk+W2HfxJwNy8sQ=
X-Gm-Gg: AR+sD11Ea9ckSqN1VNaLnDggNA5LjzC5Q+ZNwuCtl1p110a5LDPcjn+D7agl7mFIiaE
 2RXaX3TR07Yw5Qb8ahfCI/Ge2R31Fv31Ytd4YeBfYr02FWVw9RT0jioSAfOLr+lpDgutnWIhvLw
 CD7wcsvjjAUr3qDIoXrFw1Fex3Kkz2D++iBv+pgJkYJgK4rnevdFHHUSOfsxUqyEBkDfdVwu/jB
 fDIm0b1yMbqip6mRdzQl98YRnT6Wkq3vA58nESuPrvE3mYHmIUFtfmu8oC7kOqaQNuCybReEW1A
 2lfzyvApaCVf1A3DjVrp4VC6Z1KqYv1MvFIRBhE2vkbMtK5rzsUCv0+py+oDqRUVA9gHPiDJUSb
 erdG7MxfiHFMyPSQQsq+KWo8sc6iUIIpuMGPohuumMuBPdQ/VNBgEGnXAz+69hdYxeLnCoa5EpV
 +vPy/qTCx9CeFogO4G/ua5Oqw4VARC5Cf7nyEkaxIWFSLU0tC1o0cfrSJ5UeG9hzGTn3m/r5tu2
 gNjBUo+cz5Lk/BVl4EYouiA
X-Received: by 2002:a17:907:d0e:b0:c20:c5f4:e19f with SMTP id
 a640c23a62f3a-c246a65fe29mr242976266b.4.1787302358155; 
 Fri, 21 Aug 2026 01:52:38 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c245940ccdbsm350325166b.63.2026.08.21.01.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:52:37 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marek.vasut+usb@mailbox.org>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 76/87] usb: gadget: dwc2_udc_otg: fix up after the resync
Date: Fri, 21 Aug 2026 10:47:52 +0200
Message-ID: <20260821084829.2070426-77-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:11:41 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Adapt dwc2_udc_otg to the new gadget API. udc-core has its own
usb_gadget_register_driver() now, so drop the local ones.

Eight call sites reach dwc2_udc_probe() from board code without
DM_USB_GADGET, six boards plus the socfpga and rockchip mach files, so
call usb_add_gadget_udc() there too. That covers 49 defconfigs.

Build tested on trats2 and socfpga_cyclone5, both keep their UDC.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/gadget/dwc2_udc_otg.c | 86 +++----------------------------
 1 file changed, 8 insertions(+), 78 deletions(-)

diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
index 570fed347c9e..398aec56a274 100644
--- a/drivers/usb/gadget/dwc2_udc_otg.c
+++ b/drivers/usb/gadget/dwc2_udc_otg.c
@@ -246,81 +246,6 @@ static int dwc2_gadget_pullup(struct usb_gadget *g, int is_on)
 	return 0;
 }
 
-#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
-/*
-  Register entry point for the peripheral controller driver.
-*/
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
-{
-	struct dwc2_udc *dev = the_controller;
-	int retval = 0;
-	unsigned long flags = 0;
-
-	debug_cond(DEBUG_SETUP != 0, "%s: %s\n", __func__, "no name");
-
-	if (!driver || driver->speed < USB_SPEED_FULL
-	    || !driver->bind || !driver->disconnect || !driver->setup)
-		return -EINVAL;
-	if (!dev)
-		return -ENODEV;
-	if (dev->driver)
-		return -EBUSY;
-
-	spin_lock_irqsave(&dev->lock, flags);
-	/* first hook up the driver ... */
-	dev->driver = driver;
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
-
-	debug_cond(DEBUG_SETUP != 0,
-		   "Registered gadget driver %s\n", dev->gadget.name);
-	udc_enable(dev);
-
-	return 0;
-}
-
-/*
- * Unregister entry point for the peripheral controller driver.
- */
-int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
-{
-	struct dwc2_udc *dev = the_controller;
-	unsigned long flags = 0;
-
-	if (!dev)
-		return -ENODEV;
-	if (!driver || driver != dev->driver)
-		return -EINVAL;
-
-	spin_lock_irqsave(&dev->lock, flags);
-	dev->driver = 0;
-	stop_activity(dev, driver);
-	spin_unlock_irqrestore(&dev->lock, flags);
-
-	driver->unbind(&dev->gadget);
-
-	disable_irq(IRQ_OTG);
-
-	udc_disable(dev);
-	return 0;
-}
-#else /* !CONFIG_IS_ENABLED(DM_USB_GADGET) */
-
 static int dwc2_gadget_start(struct usb_gadget *g,
 			     struct usb_gadget_driver *driver)
 {
@@ -364,7 +289,6 @@ static int dwc2_gadget_stop(struct usb_gadget *g)
 	return 0;
 }
 
-#endif /* !CONFIG_IS_ENABLED(DM_USB_GADGET) */
 
 /*
  *	done - retire a request; caller blocked irqs
@@ -809,10 +733,8 @@ static void dwc2_fifo_flush(struct usb_ep *_ep)
 static const struct usb_gadget_ops dwc2_udc_ops = {
 	.pullup = dwc2_gadget_pullup,
 	/* current versions must always be self-powered */
-#if CONFIG_IS_ENABLED(DM_USB_GADGET)
 	.udc_start		= dwc2_gadget_start,
 	.udc_stop		= dwc2_gadget_stop,
-#endif
 };
 
 static struct dwc2_udc memory = {
@@ -939,6 +861,14 @@ int dwc2_udc_probe(struct dwc2_plat_otg_data *pdata)
 
 	udc_reinit(dev);
 
+	/*
+	 * The boards call this from board code, there is no udevice for the
+	 * parent. udc-core only stores the pointer.
+	 */
+	retval = usb_add_gadget_udc(NULL, &dev->gadget);
+	if (retval)
+		pr_err("failed to register udc: %d\n", retval);
+
 	return retval;
 }
 
-- 
2.53.0

