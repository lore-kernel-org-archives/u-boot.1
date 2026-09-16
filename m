Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98ECDC982C4
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 13:09:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6BBF580EDC;
	Wed, 16 Sep 2026 13:09:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g_zQn5xRH7cG; Wed, 16 Sep 2026 13:09:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6542580E60
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789564147;
	b=FTzF+omyxn1jKSyufnr5yic23bHw5GVlmSyQ1Dol6IPVraAxERos3vKJr0Xp4lfy4w3f
	 sJ0Qp0QZGKb5GumDn0n0kAKDx1O3WVfpURZWmLzPxxK45BzsRHJRFEP1eZdEFJpc02fxU
	 SBcceo74LtM0yLUIrH8YckgtqgshhHfo2m1wbXQNa48pKckY+Ew3gI5etG9flFoQ/Xk0o
	 pX925/Fhu4hVqrkL8RolRrRqX2NX9R7M6MolJ2aeK+DSipR1kWhdxQBm1m1woGk2NxXX/
	 XiYuvfmjZaWKm1tGTxCP0wRbF4LW2cqPD2emDnniMIhtMIeX0dJGYmfSU7us1qUdhDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789564147;
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
	b=WLHRdEcPCr2pN26VvovUvPBGNlbxMkXJoLsTVQC7ImyZO+bJV8NSVLbmw74An/DWT+KX
	 PLJxZUyzw8FQIdtNaaAbU5+JVGsyqRFyyy9lbb8nJJiegnhgnygu7G0z18Wc1pxiuSQ3J
	 n7eE/YoDngBikpZv4y8/WNoFlltMkT0JaXk+fFZ0nm7HW6t0pG3tCgUAI5LpNjj2DLPT1
	 Z3D5BMjO48D1kXfm33BNvpioI4/PrpGgx7iIiZv1T2XyfYI4OwUvbo4R3QiH1esjxZ2We
	 OlkLFQG7f3T0N5qJuAk/YMPf5yfZNtBg32GGzX6PIvWLb1NyRD5+y50AIroYvVDaP2A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=namIG6pp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789564147;
	bh=K/e8H6l2vQmOk7e5ZJUyx6PHJ2H/nUBBf+ulxImSWTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k3/3qGcTryuZXKjydmlybR7yvii3LoApcXmv7KFhLf+fRhce+UCOlkDC/9LF+Ljhr
	 KMEXZDODlJSHFlBTuwa3BQhHSbZ+v4sSgqxhsh4Q0RrClPTyy89dRBT0HW/49zPxiU
	 K7A5YHphe5FcARxPRJ0mTINVLgYA8KuodxNXpuk1Xx6OwtaBHwe1InsKmw39UZnKsF
	 OWZ+HBbLzE4+E4ZsMyB/7j3juJuM4dKcosy17vUmUBpsLduw9Xfzx+MvMiAMPGOigf
	 gIyAAOVniei/PY2mk2DW2RcYmF36JvO91M7fXa/HagGaenqACUvs+EcmRnRCATrtRr
	 4bT+YMBcwD5VA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6542580E60;
	Wed, 16 Sep 2026 13:09:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D847DD9
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:40:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0B7AB80E42
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:40:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IBWALbG6h7Pw for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 12:40:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E877C80E3F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789562436;
 b=fjvig+zSbO7alV/bIp7qRKw1pRf0xV4D9aVAiK2z1H20YJ3xuiQ8RV0b5Ucqg+NWkidU
 ydZ0b3QFgSsrzq8PyrtdfMZOUXbi668LMC2/sSwAdUyQNEmCnBwIATFaWT5hvov4ywcA9
 zZ0ZWql1ROEl3FyG2JDq/Jef8IsOPAIV8IZ1qDf1E8MGD80muDjCXw42vFgt7uyB4dmil
 iO0lkZLlusscgnCAxVTGIs5mA2SmCWR1Pdygp6thTPbCKJch6blf8tOLMDzTEhn2d17Pc
 71mLbaUdHblTvbcxR3J7hwYTQBm8non97ZeavzHw4J/q5Qm9ii4638qH5JdgwYIE/Dg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789562436;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=K/e8H6l2vQmOk7e5ZJUyx6PHJ2H/nUBBf+ulxImSWTM=;
 b=PIF/sqrExPNuiSsha8vkG3T+SVoIGgO1twCm4oWmXbaccBuGbF8hAyZx7vSv12wRwAH5
 QNPwFDVr8+WTw0DeuZi34cmDcHRGjfhVr5tVOwR4djM+Xpoh6LeG+MB/ruD7rkdPYzsZ0
 1bia2gD1INElLmEQf+nfC2RfCfFpafvNBDsM/NXKA5M+uXzX1T+61nHFtWNkZ1pyjJNFK
 p+CX+M6+vx4yoSKmgHPisZGB0xX015Q7ExnjAvBoneFriK7un571x4doIia3my1tkxpzq
 8h82K+Z/x+fsyUJDFLI/OBcbFJeqehpX/Jefc8Wr+jdWzEuLqJItGMaMi/GhAFocvHA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=namIG6pp; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:34::f;
 helo=mail-ej2-x0f.google.com; envelope-from=anders.roxell@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=namIG6pp
Received: from mail-ej2-x0f.google.com (mail-ej2-x0f.google.com
 [IPv6:2a00:1450:4864:34::f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E877C80E3F
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:40:35 +0000 (UTC)
Received: by mail-ej2-x0f.google.com with SMTP id
 a640c23a62f3a-c25331b31e8so13461866b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789562434; x=1790167234;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K/e8H6l2vQmOk7e5ZJUyx6PHJ2H/nUBBf+ulxImSWTM=;
 b=namIG6ppHLgIW02zh0632XitT+UtNCumYXu2TXdJAgqaTbxZ9+4Fh1L7olTadkndzc
 K/MqX13Rww+rJKKoYlHv/J4pXIFHAa8WJ0Nh0wzygH29tVgMFUpX88nyjTYCGAsTXACS
 69UOZaYZFAPwU14El2XGlWSaaJ5jLNvJBtXhRb4CMV09SpCJrYyhWRCEnaJi6CBIf/uX
 6/6VCQQSk0aj/keJfeZVsnqP5llihOcmNjdYtJOVXZCajt0YsonU0Mfmzo2trDocymbv
 0cEoGuCIJ645m5OSjt1udruhRglRHrRQqJF5DP5Zrq9+garo9uQshIBYDnRab1928/KR
 hOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789562434; x=1790167234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K/e8H6l2vQmOk7e5ZJUyx6PHJ2H/nUBBf+ulxImSWTM=;
 b=vWovDPI7AB27qRBL09GOk2q0NSdcCGSBj9/QvCpEcIu4rnixi0juWiSCECMM1RZfOf
 g0oHH6RkUalkJsFE/BNvtRYDyGPbvEf8hxZ1k7+uycguiTx/PZ5A0OmXo6YwRp0dhT2a
 xhPJn47PIljpxlc0wi4TvANuAuTZ1u+JryeXZnmDc3YOVkqVO/jiYEBlc5/GXIHRJ7PK
 p7B7IjItaSZ3INMCgofvorHFLGTTu9MG5i71HeCxLS/iHXlCl99nlgA8MjypmPDSCuLD
 RD0ccjYaihJZfFnHbYddNhwPc7dKZOnZcTFsFJiS9nKKwUXzs+J/mx+NlgjR+ryl/R1o
 B/yg==
X-Gm-Message-State: AFuF++kpmqYeDtdWN5mUYXgbSlBcPSuXuo79U/1SP6wfXa62E9Ti62PY
 fCGifevhJwCNIwpfLXJMgheiKcv4I5nw9Y7KaTH9p0jnLDQdcPItdT6mNQvBiLCkffE1wf0gpMx
 rCvhH
X-Gm-Gg: AYBFou1nal17AwZIFwvmtSsZswUPZFYHsjHueGmGgQgG2GLNr7ykIXUh9v9xDX1owYl
 Ul30jiGCwhJuztojYbswxfwcyJ/J9U7sUINzqlCFOfhX65irg5Hzm7dx2Qyq/AYND8LU/O0hfSC
 pwo1mLzN4oB5DAu9lEtHtDD0080H0iXt9AnCujPctnkReGxdZMb6XxJAy/7m3C4VK/nkkBvvfLr
 kS24YV9aJlVWls+1JrpprBb0TnWbzTyAnu98cLI5dLx9hAOpUSAKudfjuSfrUoFkhJc4s166KJo
 Tt1J6xTWAgG2E8Y0C7LXXXy5F8WDy+YE9TV23qqh01JRGVF9x3yo6uC07/Fk0KjMlxAO9HHE54r
 BipA9talpchkJ+WcuhtBDjngadE/y+Kg5ZbWzvm346TSbGWj5WUP9Uu/C9ssk2Bx3tO+huk/XvF
 fi51ZXav4jorUwUGa5wU8bbVh3w2o/X3XX57g43O1vL/EqiTcDMBPh1Yj95wDYeBVlWRH3dTDO9
 npWl/PoKQxvAjwcdkZ9zJeAwrfKe8tEg83rLHYetYXl1N1HOeosgWjw
X-Received: by 2002:a17:907:a089:b0:c20:c5f4:e19f with SMTP id
 a640c23a62f3a-c29e53fe7fcmr173288966b.4.1789562433398; 
 Wed, 16 Sep 2026 05:40:33 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29e801cdfesm82430466b.58.2026.09.16.05.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:40:32 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v9 17/26] usb: gadget: fix up the last UDC drivers after the
 resync
Date: Wed, 16 Sep 2026 14:38:17 +0200
Message-ID: <20260916123826.517181-18-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916123826.517181-1-anders.roxell@linaro.org>
References: <20260916123826.517181-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 16 Sep 2026 13:08:33 +0000
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

