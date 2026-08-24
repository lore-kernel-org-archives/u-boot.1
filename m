Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A65C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:47:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA6EF811FA;
	Mon, 24 Aug 2026 16:47:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WKOZyaRTtLnO; Mon, 24 Aug 2026 16:47:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589951;
	bh=K/e8H6l2vQmOk7e5ZJUyx6PHJ2H/nUBBf+ulxImSWTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tTW8fzjGgiLL6qwHTtAwslaSoziwNvBc/qybyroAjBl6b3ENwNxLdBECDAosYGfzf
	 2KIBMYjRz+Ky+DLoDC0r3ebnxDSTjUQw5VnhPGvKHOsqbpdokeWWqdO67beS0yyUc5
	 kUlivQ9TM8YjCh2vuDwxnaDryoChbrrCD+bTE/Af5XEq9bttJMWXlWZLdMlyFGMnOr
	 kz72javchvvh9w4J8YvVw/PYopezCJC3vcozI4m98Ma9qumqth62Yf6DJ5z4kKgVY3
	 xqgZBN/MnXzRl0+qKVj4kxdSrWYb2wOKIyHVFMyKPYj/5+5A0pAMC3nYu/dR8cWhUR
	 C8sEP+Elz+u5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 084D880ED2;
	Mon, 24 Aug 2026 16:45:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BA813AD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7E04240029
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IBW6CRrN_jeb for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:43:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Fm6CT/9L
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4842440068
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:10 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c20e4487bdaso29785566b.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787586189; x=1788190989;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K/e8H6l2vQmOk7e5ZJUyx6PHJ2H/nUBBf+ulxImSWTM=;
 b=Fm6CT/9LUPH4ET4P/YDCp7KpOgX8ztg1OkWsGPmwKnQ4Uhola1d0NJGemDhQ6OKrc8
 SPiYKCgf7n/CagX1+R2DO6chqisn7dtNqokDf/2lr58xkudyVjJtJD09laq1FP9iQYfM
 T6FMRCiEjR7vrwUzefWLZ60wSdm+CCAwAFxUFg930bF3hNQLVr6FWcXXcSAUNXOSMgKH
 J18+hV53gurbJK8xT30FB+YLSKSh8BYr6b2rDxuLj/h4F9pZM+Hg89nniI82NqACLSSp
 rNXS5VtUrsXZRsJ1DA6JJPbbdXexk2DHVsNBscAQ8hBrmEdV11pDqsBvmtuPo9/D1T6z
 1GOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787586189; x=1788190989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K/e8H6l2vQmOk7e5ZJUyx6PHJ2H/nUBBf+ulxImSWTM=;
 b=LcZuCvdAEyvU3Fu/CEWgsMdb7NCgHY2E4kH+WceYk2BtWm3oK24pLvGeKCuzbfaAzi
 +qNLAEDhrSlZ0i/N6vJpDvlxdexcEdZ/sqUXsfqs05Pu7qe4x+PyPkc7/ZG/jk+gi7Eg
 nVZFcStsKR2oAfdu2Ea6kIEKBCi+wXCAVo+fxRvLTGshbSt8Z1eMHraSa/2VRUD1eWhg
 oeL+P92F/PMlPutd7Xz1W/7z5v6/EvIhOYl62+F6FLCqOzekEgQCtsO6+4bWJhv5WYMJ
 GWw3C0KbnzA74FRSSeEeJyEjm5y97fsWcua4nMrNL4Oo9kT6SqqOlHqhc41V6Mp4hBKa
 LqeA==
X-Gm-Message-State: AFuF++luxpRKqgKq8xW4ri37GnM/a/mOcOO4MF9z+7hGwQzLia1ScD6Z
 5KxuulQVQd7yrx7xTjIiIwmvM6qcAVWqZNbCnZi7wP2dxZlbnEzKi93lAVL+gPfAhxXdAf363yi
 cyOd7
X-Gm-Gg: AR+sD1092YJgvGQe2EIiJykex0DcXDPTEUTntyTZ9HZpKgCq+XzSJofrPPmq5e+qQlw
 H4JqK/+qadx4jcyQJ1mANM1fI0Rj3LdJ8kTzIwMqCQY3O2+3D0LjU3x/WlmAHv9PwgGY7mMJuyC
 d/O+JMOYrrFGMywGATTe1M5tBWImsO0yjg+FNdK2Bkdhyb/on3rrElfOx4Av8aiW0SjRiBEcU8y
 11wgAYn25r8zudtBdu9rJfUXp0I3xW/ArWHntMsXsN0UfX9BEPiJqS2704dxHcFbnZWNGssNuTs
 AM/ppRag+SGEgLhmVIRZOsaHOFpMnooIBs/QvuhQdW2NCr0ZnL6wlyImra8IztgkDhC7IZ66lBY
 YNSvAZe5YrspLkb35JPNBJjhWlLfiAtEwKJQXyLNFt0UrCDKUTyrJ9NGqrqKr6Qm4Jlly8/TS9I
 op9IgS4uUO6VDPm4lI3kS+CD/TJKvQFGqzmftsmjqdrKN/yMywdXIus9lo9HMbZzul+xI2Ppivm
 2zK+ase0s65qB6Vo9hgiw==
X-Received: by 2002:a17:907:c19:b0:c21:6f8c:231f with SMTP id
 a640c23a62f3a-c246a2e942emr1720223766b.1.1787586188729; 
 Mon, 24 Aug 2026 08:43:08 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e19a05bsm13368763a12.17.2026.08.24.08.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:43:07 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v7 15/24] usb: gadget: fix up the last UDC drivers after the
 resync
Date: Mon, 24 Aug 2026 17:41:24 +0200
Message-ID: <20260824154133.217744-16-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824154133.217744-1-anders.roxell@linaro.org>
References: <20260824154133.217744-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 16:43:55 +0000
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

