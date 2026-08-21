Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F244C5DF8E
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:16:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 95BDB40EEB;
	Fri, 21 Aug 2026 13:16:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wtV-2_Dz_V2G; Fri, 21 Aug 2026 13:16:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318156;
	bh=K/e8H6l2vQmOk7e5ZJUyx6PHJ2H/nUBBf+ulxImSWTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xdl08QwlSFqYvjEUIOTV9E8zbgVCzY/irE1TxbheYya0qiEtWx55wZzxbFvpKXWQK
	 AuNoywqD2F0joQ/Zd4tyG5BJqVNs8WzEzX1BgGf8dCBiuhdqyvEOO+Hh6c9BljBwlX
	 +J3EopXLLmyFjnbTkY/owwXYhJJGWOcXePZNwWNUai+8W5AkFpwGpdrMgeGk2gGSoL
	 Va36YSomW+JK0BatD1WCyUhrP98myKTJ3HxN3GOMMpZ6WVGPKzbuiLp6zxB5CaKxa3
	 dR7Pj9XUk8B0ov++9L1+WbfEndRYZni9KAVceyDVni6nfTFMnZC6zBMUOmlIZ/iVll
	 +14OIcVJ70SDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D8D6040DEE;
	Fri, 21 Aug 2026 13:15:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BD952B2
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5E57980FF9
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zf3qd64RvfIJ for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:52:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=AcFxXDTB
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2AF4981013
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:43 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c15fc4707f5so5950566b.3
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302361; x=1787907161;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K/e8H6l2vQmOk7e5ZJUyx6PHJ2H/nUBBf+ulxImSWTM=;
 b=AcFxXDTBN+MRqlbEtJZGSYnxb4Z7xKjPRmxUmzzZNYjp68/1aFn4WttokgRGPCaIgS
 ECPGNa+iqfQR+0JyULfa01lWgmFKwO6i314hRW+pv8hvwlwmlrCPQtZ6UxIx/ghujxK3
 OCOY2WuS5fNVJzxdSKQE9qN5+xM0PRlZU2CDY2cmuvjKpTVzPdsdzzwZlPXzgDvagUv1
 MjNFRmXXkB5L4pyM+YR9V5B++su6i4I1rnR5yComFLRsCi4X0f6/oE5RbOGXPv2JPgrW
 Gz0prSXcTHQiHuTRhCH1Qsu6xvIrP5IoewNsl4KuoyJPbmDQzlJbUix2bcRjNdxKYE75
 JVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302361; x=1787907161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K/e8H6l2vQmOk7e5ZJUyx6PHJ2H/nUBBf+ulxImSWTM=;
 b=RfvVk52ARQbiq0YsddaTbTgBVEZfHNOzEQlz9zVSabtdA10VZAEdJKfw8TuntRHVqd
 nwUKyUX/dEPVLfbh9CjhiHM4Mf2XTutdO/+DB/x/Be3HkztXtNV1xGc0ug8HPr6ztstN
 8xhPOr/26ENdjTjz8I7kAaSOCAurSCrOvGjP1SH8cF0MNTdKtSMB/L7ss8lyxZXa4LD7
 IyZEOMRgoqCFuGDukN1+vMa6wn3Tkb6IufWLEJP+m64CK263kjuO4xNwgUCze1jGfQ0W
 xwYqGacLoDY3MctHnoMutAqyyC+DgO3fRwXsf3986a6DGCBo770KMRZ29bFYmoHEO1Mb
 MH+A==
X-Forwarded-Encrypted: i=1;
 AHgh+Roc0Z/jTurS/GZxzRuDJZrbXGWyIeVtW5ea9QjBAJIEyZbPHP+DdMxnAo2UdY/oD/eYmef/zfY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lGgklRVt8DAXg7iD6xQDkrbuGshfZ9QIjAJHI2tmNSPkCc+Bc4
 X/7hkHHzX5OZ6c4wllQZq9sn5k9I2uwBECuKdzIaSfZMKxju7H/n4BX3lFizdLQdA+g=
X-Gm-Gg: AR+sD105DV+TP3+io+Ha0YqHoA2FqHdzqDs4IO/QJP45dk7YtsekEjYWQ+CoRMu94Dq
 ZXVCd1uTasy8GtQ2BrpLfm2xtFs0Bu1QiKNAAzmAih78w2qU1199TI3W3wEXuZMz1NE5eVw5h4v
 bxrgG0AYujKruUV8JqzqJqBonMFzI16I3LNq/2QgHXCHe2iCU/HNmmgicjUpgIEDN+mX12dFRWF
 SxNfq1JjH+jGwH4cvD/7003jh8UAJACEg79Lk1dMn/2wgLsR4XFI97myViWE/MV5PazNhRZccS3
 cyfUd56WHUxHdZhNiaNFGcuC8jwIIdueFuClfMYaxTxRrQYt/Os1I0KhcMNrPBduwCGo2/i12WW
 noQAhU5vqe4Bi0WTu9i4x3+INWvrO5xsWr3HFoVvo+fHoOrgWOMyjHvz8UJc7Sum8MazQWqKGYR
 5t/iVh+zs4imx0iKLta4GJBzfH+vlCYSBHV8tNVFIZZgDbpxSsbre8J37xQdB+Ckv4HZ7OHi4hb
 d6bL0//jV+pbKlsJ1g/r0rs
X-Received: by 2002:a17:907:97c1:b0:c21:764c:9417 with SMTP id
 a640c23a62f3a-c246a2eb944mr264420666b.1.1787302361157; 
 Fri, 21 Aug 2026 01:52:41 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24589e1b22sm335834466b.9.2026.08.21.01.52.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:52:40 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marek.vasut+usb@mailbox.org>,
 Eugen Hristev <ehristev@kernel.org>, u-boot@lists.u-boot-project.org
Subject: [PATCH v6 78/87] usb: gadget: fix up the last UDC drivers after the
 resync
Date: Fri, 21 Aug 2026 10:47:54 +0200
Message-ID: <20260821084829.2070426-79-anders.roxell@linaro.org>
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

Adapt at91_udc and atmel_usba_udc to the new gadget API. udc-core has its
own usb_gadget_register_driver() now, so drop the local ones.

That leaves vbus_is_present(), usba_udc_enable() and usba_udc_disable()
used only from usba_udc_start() and usba_udc_stop(), which are
DM_USB_GADGET only. Move them under the same guard.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/gadget/at91_udc.c       |  46 -------------
 drivers/usb/gadget/atmel_usba_udc.c | 102 ++++++++--------------------
 drivers/usb/gadget/epautoconf.c     |   2 -
 3 files changed, 28 insertions(+), 122 deletions(-)

diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index b3c780a4e35c..5b0c55d59c8d 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -1435,52 +1435,6 @@ int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 	return at91_udc_irq(udc);
 }
 
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
-{
-	struct at91_udc *udc = controller;
-	int ret;
-
-	if (!driver || !driver->bind || !driver->setup) {
-		printf("bad paramter\n");
-		return -EINVAL;
-	}
-
-	if (udc->driver) {
-		printf("UDC already has a gadget driver\n");
-		return -EBUSY;
-	}
-
-	at91_start(&udc->gadget, driver);
-
-	udc->driver = driver;
-
-	ret = driver->bind(&udc->gadget);
-	if (ret) {
-		pr_err("driver->bind() returned %d\n", ret);
-		udc->driver = NULL;
-	}
-
-	return ret;
-}
-
-int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
-{
-	struct at91_udc *udc = controller;
-
-	if (!driver || !driver->unbind || !driver->disconnect) {
-		pr_err("bad paramter\n");
-		return -EINVAL;
-	}
-
-	driver->disconnect(&udc->gadget);
-	driver->unbind(&udc->gadget);
-	udc->driver = NULL;
-
-	at91_stop(&udc->gadget);
-
-	return 0;
-}
-
 int at91_udc_probe(struct at91_udc_data *pdata)
 {
 	struct at91_udc	*udc;
diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index 0caf8b8b7b45..52900ad654cf 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -32,12 +32,6 @@ static int usba_udc_stop(struct usb_gadget *gadget);
 
 #include "atmel_usba_udc.h"
 
-static int vbus_is_present(struct usba_udc *udc)
-{
-	/* No Vbus detection: Assume always present */
-	return 1;
-}
-
 static void next_fifo_transaction(struct usba_ep *ep, struct usba_request *req)
 {
 	unsigned int transaction_len;
@@ -1169,32 +1163,6 @@ static int usba_udc_irq(struct usba_udc *udc)
 	return 0;
 }
 
-static int usba_udc_enable(struct usba_udc *udc)
-{
-	udc->devstatus = 1 << USB_DEVICE_SELF_POWERED;
-
-	udc->vbus_prev = 0;
-
-	/* If Vbus is present, enable the controller and wait for reset */
-	if (vbus_is_present(udc) && udc->vbus_prev == 0) {
-		usba_writel(udc, CTRL, USBA_ENABLE_MASK);
-		usba_writel(udc, INT_ENB, USBA_END_OF_RESET);
-	}
-
-	return 0;
-}
-
-static int usba_udc_disable(struct usba_udc *udc)
-{
-	udc->gadget.speed = USB_SPEED_UNKNOWN;
-	reset_all_endpoints(udc);
-
-	/* This will also disable the DP pullup */
-	usba_writel(udc, CTRL, USBA_DISABLE_MASK);
-
-	return 0;
-}
-
 static struct usba_ep *usba_udc_pdata(struct usba_platform_data *pdata,
 				      struct usba_udc *udc)
 {
@@ -1255,69 +1223,55 @@ int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 	return usba_udc_irq(udc);
 }
 
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
+int usba_udc_probe(struct usba_platform_data *pdata)
 {
-	struct usba_udc *udc = &controller;
-	int ret;
-
-	if (!driver || !driver->bind || !driver->setup) {
-		log_err("bad parameter\n");
-		return -EINVAL;
-	}
+	struct usba_udc *udc;
 
-	if (udc->driver) {
-		log_err("UDC already has a gadget driver\n");
-		return -EBUSY;
-	}
+	udc = &controller;
 
-	usba_udc_enable(udc);
+	udc->usba_ep = usba_udc_pdata(pdata, udc);
 
-	udc->driver = driver;
+	return 0;
+}
 
-	ret = driver->bind(&udc->gadget);
-	if (ret) {
-		log_err("driver->bind() returned %d\n", ret);
-		udc->driver = NULL;
-	}
+#else /* !CONFIG_IS_ENABLED(DM_USB_GADGET) */
+struct usba_priv_data {
+	struct clk_bulk		clks;
+	struct usba_udc		udc;
+};
 
-	return ret;
+static int vbus_is_present(struct usba_udc *udc)
+{
+	/* No Vbus detection: Assume always present */
+	return 1;
 }
 
-int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
+static int usba_udc_enable(struct usba_udc *udc)
 {
-	struct usba_udc *udc = &controller;
-
-	if (!driver || !driver->unbind || !driver->disconnect) {
-		log_err("bad parameter\n");
-		return -EINVAL;
-	}
+	udc->devstatus = 1 << USB_DEVICE_SELF_POWERED;
 
-	driver->disconnect(&udc->gadget);
-	driver->unbind(&udc->gadget);
-	udc->driver = NULL;
+	udc->vbus_prev = 0;
 
-	usba_udc_disable(udc);
+	/* If Vbus is present, enable the controller and wait for reset */
+	if (vbus_is_present(udc) && udc->vbus_prev == 0) {
+		usba_writel(udc, CTRL, USBA_ENABLE_MASK);
+		usba_writel(udc, INT_ENB, USBA_END_OF_RESET);
+	}
 
 	return 0;
 }
 
-int usba_udc_probe(struct usba_platform_data *pdata)
+static int usba_udc_disable(struct usba_udc *udc)
 {
-	struct usba_udc *udc;
-
-	udc = &controller;
+	udc->gadget.speed = USB_SPEED_UNKNOWN;
+	reset_all_endpoints(udc);
 
-	udc->usba_ep = usba_udc_pdata(pdata, udc);
+	/* This will also disable the DP pullup */
+	usba_writel(udc, CTRL, USBA_DISABLE_MASK);
 
 	return 0;
 }
 
-#else /* !CONFIG_IS_ENABLED(DM_USB_GADGET) */
-struct usba_priv_data {
-	struct clk_bulk		clks;
-	struct usba_udc		udc;
-};
-
 static int usba_udc_start(struct usb_gadget *gadget,
 			  struct usb_gadget_driver *driver)
 {
diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index 4fbea9137240..5128d147c168 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -7,9 +7,7 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/types.h>
-#include <linux/device.h>
 
 #include <linux/ctype.h>
 #include <linux/string.h>
-- 
2.53.0

