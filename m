Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04CEC79FBF
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 12:46:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73BB040762;
	Wed,  9 Sep 2026 12:46:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v544xUGg1g0j; Wed,  9 Sep 2026 12:46:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2923A407BC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788957980;
	b=juWiqyxThTF+Wq67U4pe6IS41SMmZPZ2zetVRO0EhvjwJVHzjjx0l909gznIxEiq5W3j
	 ryHb5qUJSq5XNHM1sjLQCQkBnRm+Dz/UBJ7zoNPhpwgNcwKQgmWIGDFTuUVqYSSYUUosa
	 7HkhGg0prULzGnNRwYCBnZ8jTW4jPo8GxtGC0XUZ0eHiEs4vYFbiaT6h2kmOSklWfM6KX
	 PPYSb4cNAlhGY53TWO5XRP+/AABRFuE/dJ37vrYJUy5BrZXKhT11P9ly8q9th99cGltnH
	 z/XSXDk2kM0Sf2qK6CjcjgupeCxC304u5kphPEGciaHfk4O7OaBb6NSAo36TmVGZTtg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788957980;
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
	b=oHjfpOaOh6R/BOTAQ1SuBxbmOO6IfjJZCU/5j5+3C9zLltpMki4IKgeKqZbQuaF6iwk7
	 piUETb9toEpKU81sZeLFDW5r14z2eFJGULLxVjNh3do/Lj4Kf1bR4gSen2zCdRgqz/c8B
	 qQ9HIzxN4UszIVpiemtP1s7MoFFMHFXTP9+d8LhJr9pOZfAeB4QHvJKT24+Ophx6aqlqm
	 sei66zpKPgxVIRf3gMF6jgrgKoKLzghmSsh/Zur2pAN0WZSR3McsHoxHHIKYfqjmV+lwK
	 XZUA6PG3yqfGnTvFEpKrCjevifiC0jNLIuP/CJqzP/MvKbFTPVEYVDLVUCBO3PdW8jw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788957980;
	bh=a0skoXip4HNvsNuQzwOisKcXucwWRttVxVD4l0eDTSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A5lCoRRP1oaMs9R6WFGDYZKuPfypb3zlOItLM6vNdlruEkMWyQ5LnkT9mMRC0+4AS
	 8I2bsuSmxjLoKbBD8sJB1DZq2SZ1sn/3kLB7VrjV3G5MCt3z3own/2m/0NbNNozkE7
	 GBI2aHeMGu+7JaGoaqZGvNbz/EJgyF8bAdELHQf5wjJrJ5vyg6JUxTVw+9SGZ9/alY
	 nPYUpTDyJKutZMBSDfabiYwVPbqn6MTvyU8RaEkUZCZIfxJC9RLzRKSedx0r3VlRzO
	 aDUkOmctVIjwiF0vd3L+w04in6yfuN3zJoUZwSZpyIcjybjWm6E5u7Rzwapxy3spco
	 wmbWDrYeW3R8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2923A407BC;
	Wed,  9 Sep 2026 12:46:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BCB7F268
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:52:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AEB91606CE
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:52:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i9_DRoTwDFqH for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 08:52:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B894E60639
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788943947;
 b=quJH2TIJXFb2kvALgELKF64mQUtbTfc2VGf7GHi4nx8CeR3NdPvWwNuPGGnWM2UmWy47
 xJuSUAMxc3K9a7AKvCCyf07dKIHG7N4tIJpATo2svNEG23HjHylkcj3WBfELfrEvPVlya
 MbT/xKjZSMKvfEj59QRM9gFUp7pkJWa0NSdgzAdFFfRb6kCllprJ7LA+sVZCPt9iP6Mtk
 VHGA2hxTm/dMBRkBIE31tfeIhC6JyX0+WWEryNSWnGvSwChBaFWZe4gu2JUgK4iGklqZy
 zwY+V3xrKTJ0DZWWqWoaPko+YyBSSrjYleFFRL+97OJFOXuUas0/sYEgG1gTg3UBrbw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788943947;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=a0skoXip4HNvsNuQzwOisKcXucwWRttVxVD4l0eDTSU=;
 b=Hlr6LNrQe/2rk+mD+MKSdNL8gmge31ELpeAtg/RS4CPP1YRpVeutRr916yj/R/GVCKjv
 rQpeTrUYUjJ3EkeNqxDOoFfdmkstm2BZAnBCt4SMBRNnSs3qCfDniB/29tiVSP7y+SMnu
 gJCNuCz80B4xopf1ehAvcfbxSreyt2H5/5EW1CUNa8KorckUQj1U00r8UZ4gofC4vuAgF
 Axx9y5txIoDqfHIycR1ojv1hxHLFHWGxTVinueVn8eQGa3j1vOAIfgxthfoFTjEN9f2di
 mFBUGxqFA0cbOibaVfxsBDxsCSu+MMhzt1h8ph8D4TZF7vN7kBO1kkrBWE7M+/Hx7Zw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=zj8n0sm9; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=zj8n0sm9
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B894E60639
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:52:26 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c250848d11cso74822266b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 01:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788943945; x=1789548745;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a0skoXip4HNvsNuQzwOisKcXucwWRttVxVD4l0eDTSU=;
 b=zj8n0sm9rmYNfR3XdKr+04pEgWOwnw1F5qEZwmIe8YdJawTHO0IT1MAM6x4Wk1nk0A
 P059ezLxUi2TEL16X80wR+4F8FQxiv3I+RokRlER4E9eq7NiYyxMl6coREZnbm/hE8P4
 JV/iNQQAF71vhMKjeb/hyczdraVpoT6pOJ1Lw4nuCWbSeIlRCgJ9oabj1XKu8DaoDfiE
 NcWHYecTFmAaXIq/q5OlrK+9kTL5o3DPuC4En80yJcQDTDu+CWyeM2DiIM9iW5yHuneZ
 dHf1IyveG0rCETtfQHWGMe+S+S2tUWuYmHNffLxvg5TzoM4hXfDKEdRjjRvuGVzqW67J
 CvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788943945; x=1789548745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=a0skoXip4HNvsNuQzwOisKcXucwWRttVxVD4l0eDTSU=;
 b=niyJ4ywCs3XLsQaRGs6oPrS22L5iKVX1bZFGEerz1EbPVCww+gfWA/pEMhXdJ4+vKm
 o75iLduUStJDVtiHpKMrPM81Li0v2FzeRpCpBPwl1jphFtRPCRmGgAlxjnaCfzhij7Jm
 ilPCHlE3AFcyImdxx+ImYBrPBJDHsSD2f1+cn+GGzIf5D7ICr3MPafoc7LLtJZ8oq2yQ
 itlU+c3LS7ouVW1Uhd9CBwfJjpbEeHXb2ljAT1nkWLSg+Wq9BuBhh2kP9xRFwJtSMa89
 KfL+pyS8aI7ERXfPNmmaWupwyzvDAAX3k06EX8Cz/9sjEJcUoH9RU7LUWYa524Ya4+Gs
 Z0Gg==
X-Gm-Message-State: AFuF++n4OXZoCbNhxz3EQvqvvtxV1IF8HfWKaiAMMjMV8jFAvkVuzKGW
 NHAg5sY+TZQUyplDLETsZp+Ao/6AJdxAX4DxD1Ut/24TJ1rFYE2/TVmLCg52NtDf6TVaQ7CMHsg
 qcFf5
X-Gm-Gg: AYBFou28MBy2eVHzjuyphdMTqQadWQJ2DqJuM1sEQ7pmZmODhO3zgH3EdhESaPtGxAL
 EdDD8LJY2KpgGRzjnH46SOEroDMbtVkEKdLWAWG6t7JQkOyMchI8vDPlTiep7TckucU7nlFOdbn
 tgaObPdkwPeSkpTo+XzAv1OILTNyz1ADGykfKT6v1DWiKZ9JKz7qBz9BTCmHTe87nRm8ZD5k3Rv
 1ZxC+swbADGcsL/O+PJkKw5VMFsXsHLEHGdqwR14RR9D64B+yDjxVYq2yPDouNRkbC1JD2IOCgK
 aPvurMTyvmSQu9imrRM+0ridmC+sy7W1LWEeNU9gPWewSuUYSyXLRqapEMqUN86NuZGi8oFfUhI
 d5gUnqoIa/OuuwaN0yWbEZWPe2rnE2HRcEHQtTM2KC8kEPvJXawEzspvrlcs4n42FgW8Jh71tjF
 CoGreX7sibaQshYLfue7vEmCLllnbQNq8rg0rkzz2Tltyq04bnI5Q9mVbOj3mHHGQqJrpvYHTCL
 JIkJj1zW9vzTyhD/Y3p+HXubUcuoUgyK2x5HBLS7LA=
X-Received: by 2002:a17:907:94d3:b0:c16:1290:11a7 with SMTP id
 a640c23a62f3a-c2624f0a534mr1117706466b.1.1788943944573; 
 Wed, 09 Sep 2026 01:52:24 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d5b371esm730398266b.54.2026.09.09.01.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 01:52:24 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v8 14/25] usb: gadget: dwc2_udc_otg: fix up after the resync
Date: Wed,  9 Sep 2026 10:50:04 +0200
Message-ID: <20260909085015.2480097-15-anders.roxell@linaro.org>
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

