Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CCDC88E5C
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 13:09:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D0B7240780;
	Wed, 16 Sep 2026 13:09:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aXXaUjC2aoWM; Wed, 16 Sep 2026 13:09:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8FAC440763
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789564142;
	b=iBrDLJPfVw1gzTg2oNnufKheR/L/Y93VE7akR5+VdhA/d3wc2f112CNn4FJcLUmHtuVU
	 szgJqVPg4nSt0TAy557+gxjhVJXPu2v3b4kEJApEZiLKseOLCqw2jrmvnxG7Qnwl0s92M
	 7thx5gz7pFTnyvUdrOC6CSVMl2JJkbuB9GqICkdSWGi8D4df1gDyTc0AagdbSgs4+QldU
	 ZMVSsBOgZCuxAAvlEMgPim9q9DdaPSXBMeIIE5J4Md/mwVx2KsHug4dv7uqrJ5Kge/F3b
	 8JeW+/zWN8BfBqw4u98IAST7YNeadY1AT6Mr5flBkAq2IkPEIrxmr/hMtyepmM7T7Sw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789564142;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=a0skoXip4HNvsNuQzwOisKcXucwWRttVxVD4l0eDTSU=;
	b=oysya8J/6uB6GlefLh2yDFLVtgTunznVM504qfk3wbMuIPC1cpdfn+e5Q5v9hO2axlSm
	 57OffwMr80Hr6dEh20iG1l6rk5nQ+RsGEK+6/13k/KLN1yfM0m/wINBmzVzR/iOFnTZYV
	 yTSOncZ1ktw6OQeEf8bwNyN43/lxSHgIC+CislzH3QUEppyuynJG/X4GeREpiosZOURFX
	 PviQPkTnB2peR7qWyae/rfVMz7noFoIHcM7aP2F7DnWCqV/V7kmEZv6rI7rGHx+TgBOVl
	 Q59Hx9fwh9syq36hGuYWv/5q1+wRCSpD0xfkGTEgPwOEM9ynJOdvu2FQ4fR6wJ12nXQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789564142;
	bh=a0skoXip4HNvsNuQzwOisKcXucwWRttVxVD4l0eDTSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D9DC/fqKHG6CGPFUHBOBCxkhP+rWk/oKTpBeWEcZwQuNQYp5fQhp13/lHlW8bRbgt
	 v5/dE7wk4GDFmiQbh/D+ArYFAGxhIpTPVKTApFFHQ+oWwdWvM7+PkaeYeSOaZv4CaT
	 442byCwE1TsqrrulOiLOgD5c9w5aogKriDeEHE8uuzLB9pqS8pcEtGYZA2RKjIugFk
	 Utpnpph0xn757dmNEgUzxGbdOiUuMXdQ9Is+2R+x3seMGDViVvQas348NE7nmOPX3u
	 pwON7WnHZ/e/00B+aFXMoJBgWDORaQjO/um1xLzl0y5jrEHwSJNaBn9D3Sg6bauYZT
	 6XWXX6iGu3NSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8FAC440763;
	Wed, 16 Sep 2026 13:09:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9220929B
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:40:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8408E402DF
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:40:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y0X_0-s3f2-j for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 12:40:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8156140093
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789562431;
 b=Dq6kkKgBQns19snnHfwLut7UM4PUsVIngAyEQQyHuJdzxZZmUpi6tOsB3SvFChh3UwMh
 C7jdn1TsyybGpjukDRDvkcsObhIkcnZlX2y849uJv+RV2okNHTLeuD6b/dX+ZPRq66UjY
 s6IF3xKb1BoC6LvXzMpy4Vmc7s/k4hD4XMZM2DCGs7NhcpD9Y/yzZaH5+Up1SIPXwAz0v
 f2Zzs2mW3iIwfahxd2P0hHMqTxA4Aa0dQEHOTtBggH3L2/DgK8899Z/PW/qPqU/HL4LKK
 F0Ko6Ls3MzZFatk4cnzwrx3gTZUsi2K7mI8ZVNEpvdRtJ/zlpSuYpxdV/oog9BlaiaQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789562431;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=a0skoXip4HNvsNuQzwOisKcXucwWRttVxVD4l0eDTSU=;
 b=CgsB/XuNzDVUCMzaQuYuHwOXzbzlCFugxpYjiQX145tW5B+2giCyVJQ98gkz4Puv0A86
 5JnmoakYjRSd9Dcuf5rK8PHYaKQxsRFzA3khKA19I3AEJ2Uui6t8nyYvDIGleILSt+pdL
 MmNiLGIVWOK2lKPQ92Tt6Vw65Hwo/CLofddJ/PHbchMpGaIbA7WrBbEfXrs9rh1nJhjdE
 wzIM8NigpsUl+OzUScmaervikJHnysbyTrX2OWOjHccBdw441/JelovjnCA6bXUS7rrt7
 KBojcf4hvje1NyUWOEN/kQFS4KiaOyDqRJwxs0ZvGvAfmyuZoBdpy2v/zrbd9S4EWdQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=IrHbGJkO; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=IrHbGJkO
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8156140093
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:40:31 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c2939b2e4caso12182666b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789562429; x=1790167229;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a0skoXip4HNvsNuQzwOisKcXucwWRttVxVD4l0eDTSU=;
 b=IrHbGJkOPb2t9iPzx/nvU7iq/2vi0C37F4jF4/6KhJLeEP867VLJutjeliNSAIT/0r
 Ixy1fJYq707Y8PO2BBzaeFfEX6tmsSl5lP5B+Aco9aEwzdUq1xghayzHUrYSv+vfafvE
 Cmsj2h08nZ156ZanbjudVKGC0WWta8JOTc8vB/3YGy8qicP9w43LkmtyDGA8b8LqoPeL
 kKGP6q3DOCcDH24LlE1yBipUyhLY10c3Eb8lQT8iIcnqU/zXxVI70pjrSNj2xXUbFTfw
 HCq8qoJem10llfoWNIRU3Fkcefv4kU5Zqnhm9DsbRdRFMpdszXgd6nsUCJtmvNuuBhKy
 4wLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789562429; x=1790167229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=a0skoXip4HNvsNuQzwOisKcXucwWRttVxVD4l0eDTSU=;
 b=tVuzzSosEY43adutAj18i1VFrPgYMuDhxEq5dQVDFOF7PCXUqnNyxkuUqi+vMQIszu
 lK693JZ8OglCOVES808LOtJfRNGAhgrrSDdt+HFFP52iGINxlYArNSB7RRlQL7YfS7xq
 4fVpLhzDdBWfATxyLNaHF6Yjdq6fj1p0gGloO9lSfqtGW5Zb9LSybBweHLdONC6HCiuq
 k6KqY7+EHjOsnu/Hvvgv+dpzBtE5764ZkeckBWiUF5B7fTzbKeV0X770bLj7DrmB6fnp
 asttD+N7GLCp9ywdU42IsA6aVRtyE5/nsCBOc59GlHwk3JJMO4gHzj+yp8tuuJWtu1Tc
 gaeg==
X-Gm-Message-State: AFuF++mVKg0Kn2HigDuxWh59toxTpWMFBoxM5SehKU0jePkatPqZ6KL3
 CfdPRad9aZSdJ9ObQWSxyVlEF+vqLBnxts68V5kOYCE9w1DwCYiNxizTGXCV/JRhi90a/8AWYgJ
 HTkF3
X-Gm-Gg: AYBFou2iB+ZfbG8pPop7CtG7x4QGsmNAlYwAcQsc9fu4nCX9+8aOVo6+cH74jkzw6s9
 xoTXg+mom9ZsWAUGvElgTbu0xgHLeZqR4cc29J+WjpVJw2gM3G/o0SbZUiBx3GuqCbdtkx3wrWb
 JYyargST3C6WyGyX4I2xFWKUntaKoMG8pjGpjPsxzs9fCUYaEVSezmXQ1hlVmmULIdZkk49fhN5
 yVMt8u6NQidJywfsOJPhqA4QC15+ZAS8P9LhuRwlJvAg3ZpjSEtcqnH496QZ3gk8P+97VctjDWj
 7fM8RgMtlap03XvCFFG+WglyJAbwgWeL0RcJJ44KArezvS1Sf/Q8+5cuDH25tfceGhJ7hOCJcjg
 UM+0+bv16ESC5qAHc1xtkJU7DUVgO7MyM9NYo/R6WoHzo7xMpBHiIPjZrq41NjyIjEZh0iAAR25
 z6v13meLgaN6tVFhczyekMp0JI0wAQLqJ3TbR3cQX0EJMq1KpWOwnzOsNkLNVmZkwUlcumsFSbC
 OkgECM1GjuxKcB7yaAANS6Lg0FbgSScVEJ1ZH5jkBYkXEdhYEKMx7kb
X-Received: by 2002:a17:906:f59d:b0:c25:2fb5:e57c with SMTP id
 a640c23a62f3a-c29e5302b7cmr181587466b.3.1789562429221; 
 Wed, 16 Sep 2026 05:40:29 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29e801cdfesm82430466b.58.2026.09.16.05.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:40:28 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v9 15/26] usb: gadget: dwc2_udc_otg: fix up after the resync
Date: Wed, 16 Sep 2026 14:38:15 +0200
Message-ID: <20260916123826.517181-16-anders.roxell@linaro.org>
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

