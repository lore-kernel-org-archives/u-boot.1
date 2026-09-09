Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F73C79FB7
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 12:46:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4CB15407B0;
	Wed,  9 Sep 2026 12:46:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id idel2QavFM0p; Wed,  9 Sep 2026 12:46:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 53E1540721
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788957985;
	b=MSVhEn2uRiAkLlOKUfdr1wr9wXlDTBhFf2E+tWKWDL5I5PEiB3DzKdbWCS2LXD1RQrC9
	 LNHNGz3PYmagRKN7D+GYuRPKSEmro+PzdCK/48ZCMAoSCtkgp7bKThaK1xk7UnvvyoHhZ
	 XNlPV0PwofjkeT3jyneDvpqZy9tW5rKtpBTFPTyB6/yaRnoQ7cJSnhuf2xSDHsPscxBmx
	 7CsDP/FghE+/PVrQWFhGjfFdQXjIva5FIF2U939Pvn7Uqp0jua4XOJPu6Dzsxt2Q7KaxS
	 ZAtSmSzZIIWcopYpzvoac99mI7lw5cOgemEpjfzztI0E+hrCoTKyNPljfFbJivlTMqw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788957985;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=K/e8H6l2vQmOk7e5ZJUyx6PHJ2H/nUBBf+ulxImSWTM=;
	b=UmjPoyF9vi8eSxEwerBTjp4uhue++19WRPF7BVzZqZh3L5Gat8zZoF2o0cAL3TzTMLXe
	 I7xX4P2A8q3offYlcwwDRXi/vPTer5x9kcFO/02vp3eCL+qe9/Jg7ltMoT58ibhfzNXwV
	 xFNb567XPR+cwMp42cQFx6aMvNBxUQEzxhVbLyAl8iecKMtT7Lf5jWS82ms1qMAGFdpej
	 9W0Z4uA/DFyVMXsReDpjsk00vUZok1q79hUKvmdUbgnkyEugPUXbeZPNo7VKraY3MWMNq
	 59vmZ4rrbZvsI51Jm3HrG/+ren2vmwT3HbyfvvA64/C9EK9RMwb/eERmoZTSkCc4HKw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788957985;
	bh=K/e8H6l2vQmOk7e5ZJUyx6PHJ2H/nUBBf+ulxImSWTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aGnW7aJFEscvQUbfh77pQHuoQf/u4cukHuUg4L2nJS1/yrvCmyLY/P0e3ELh3TJzg
	 nWtIx0/DT8phwKdt++qagenmV4VFnMQ0imxTr1cMkXHU+bsIWiMFRfC0EjhqhQZoUd
	 D847UWuuvQ5fprhrZ2Ht45NBlZuWB9jhI1bPLNRqnE/otaDKWLWX3LfG6P5lMwPxRN
	 dXAZS6GCYwTqeHKOVWGaw1joL0E/gEJd6xEkJqmXoKtQaZCb4/xrq+GXbwIe+I438x
	 gCI6+jqhryMQNj2s0oBRxDkYX85HZz2G7/SXSsrD08ytDbfFUx0FJHLYuUbRM5gCSJ
	 gVcRWSS5IVehg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53E1540721;
	Wed,  9 Sep 2026 12:46:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E6D7D268
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:52:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D913E80D44
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:52:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5-9j8cEnYp0F for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 08:52:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C176D80D3C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788943949;
 b=soQDeK8gMhd7MSsXHVxVAxi8LnEdxRo97RBrFv2bYFmG5T0qOq+Injr3tsmbkVfIBITJ
 c7uB5bPZmSaJvKzGTpokjCJcrB4qM6+IuMA6NKU+7X9+FDdQI1HcRDSKDcpJsWDK1kJSW
 rdX36DljtI2yqjOIctDLgobHIKcEaIy4f/2ytYvp7zXHhec7QzKiBVZ3bvldp4kj7zfrs
 P7TKsCVnhnWUL0LN2Q/74IqVBzz2unFHga1x3+Mx5VDxaGnsAfJmb2d0L288Gc+HIZ/uB
 C6qLNVQuzUzjeFNvqCsfJJRhbWA7CSOGDoDAmBDf0mKsYx0jDarMUhWkvAvpTlN9iEQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788943949;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=K/e8H6l2vQmOk7e5ZJUyx6PHJ2H/nUBBf+ulxImSWTM=;
 b=HS/ONbQmEQZ8fmYxmdDYFrPY5sRrWuPIzID08oAHw7XjgOtt2LQeFBqLXnMNb/nYcezb
 drjr5+U7BGxh27s0dQYECdeN5+tNexdFHTI8xPAFlZupORHGKPN9rbH1a+lYlNmUG3wUF
 EArvdC2wb+pBZoH31U0gYlwO4rRNb3ZlJQVe0YppMw9J+IkgzhFU82MMar3PBcyAvgo4L
 w6iuO4ms2Sw/iEqgzLW9MMI5DyoT+i2qvZTzLn8f95Lxls9duKSSezhx882+/cd14fe/W
 0e+HGqamQO0sJ8qIR9E4ZDAfy6eVRlrm1qTOdW1JDk8gsdYCJCSMJtYKCxL58FyPNDQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=RqsQXk9x; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=RqsQXk9x
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C176D80D3C
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:52:28 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c262898a2e4so59717266b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 01:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788943947; x=1789548747;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K/e8H6l2vQmOk7e5ZJUyx6PHJ2H/nUBBf+ulxImSWTM=;
 b=RqsQXk9xcC+WaM1ybyxC8WxVz2fpHvW3Gep9j8jx6+69DuNATx1eG+vGtQpX09LfZz
 Kij2pH1zLgWP3az38e3Yl0J8PuHrH9m88CRRRLIQlB4xVknMOEOGH9XyR+0uD56Ndofu
 2Jk0CPXFEDVHVhkcmHrmNHKiBS8KhUsBUxxTC9vU++sBkrIgNu4aFQwGp5G2U7hKPHwE
 9MRuNpJogpSGFMN7FnmDovSCGFKEHSVneC3VHy+Z5Aubd1zHgxOZSLVKOlZWI4r+eaLJ
 X0xglGUXmfueb9Dy6cWiCLkeeXxr/6PYaWRi2vkvI2MGNfdfA85mcIsihMiF6HO+jCh/
 /cMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788943947; x=1789548747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K/e8H6l2vQmOk7e5ZJUyx6PHJ2H/nUBBf+ulxImSWTM=;
 b=HEOxpRJ4Jelo196JmuiLNrQiMvi9Q0HNymLLaGmeiqRYrRS9TIgWzYeEb6RdZdJ9YO
 +nqpDLJwJAcv/n/xXZHQ+ZMXPf3H+1e3Og6ncIrCk1wtvGQBDEwyKX8sDuG8nPpccr7R
 scyj2A1mC0wJ4C1ArjbZuq4pUJGD5EvYJEf4XHpKBFOLRk4SsAU+54/74FhSeLAa9hY2
 oLKIo3hXSNUxIul8pdE6WoGBTxgYy7Zf3yFSg7tAyLuOiYseybB4vgsyomVMbQZZ1Rif
 3dAYPfPmBHawBWlgUuCl+CoRt2adyeQ/PCS4bVhAdgUo61l9U/64b2E0eqGMUgK0IQ11
 RndA==
X-Gm-Message-State: AFuF++laidV7NaH3i2JjLNXLivn3KSH2WDOnGTRMRlkxUxhrj4PuWRBg
 rhDjjm1c9DxzQlzou6bN4HiFmc3NJ75XbcIS5RFWSs3OF1Ww2Bd3ekQSX36zxZ/8c1Bw/nmzNj8
 WKtk/
X-Gm-Gg: AYBFou0JPzR/cdploKf02mM+tJbp042wIDpNlq3hfMBaaSMQUm8bIQb6ulrlNBzJZD7
 /csj/ZChmQIJPjuDLCDMAtuSTg/iKJQ0b5upgOwpP3xXYbRS+94UG/EjB9+toCkkoPUCnsGwY+u
 TvwOdHVGiim/tU1LXFGcw0vFF20XsDAtnuQFYDRaLqIhBqT2IpDRPrJEvQLeS+wQaHx++ykEKM8
 0CU6hhXbisUjXAwjoLveBZq/LciP32SBxFPIcHmcL/IVDZ0AR9DcKFEee8eE2rA8dLJ1i6gPhtZ
 VnQgG3J82nmlKfzjyHeJdraIdwcsj0XVh248HcnMRqJr5BZ4QQ+ihv00yqbHorfevZkzdyBMT6a
 S0FDW3YE6vi0uXK3ZCN8aj8ohjMHPBI4UlpYp6PwnWXt47XvEkhbC5y6r0hVfFocFcXMhLQVE9j
 DTu+PzN5Ixh6l4lULOd5heyT7JP7xBnFhHmCle+d0+HHKdZVOG941ybqmo9ZI6HlVlb74KBfq62
 fH/D7Y83tkurn4kqGXd5IrmAiH0ksLS
X-Received: by 2002:a17:906:4fd0:b0:c21:6f8c:231f with SMTP id
 a640c23a62f3a-c26115f07b2mr1238781066b.1.1788943946551; 
 Wed, 09 Sep 2026 01:52:26 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d5b371esm730398266b.54.2026.09.09.01.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 01:52:26 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v8 16/25] usb: gadget: fix up the last UDC drivers after the
 resync
Date: Wed,  9 Sep 2026 10:50:06 +0200
Message-ID: <20260909085015.2480097-17-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909085015.2480097-1-anders.roxell@linaro.org>
References: <20260909085015.2480097-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 12:45:47 +0000
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

