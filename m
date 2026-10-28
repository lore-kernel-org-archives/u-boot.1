Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBDD606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BCUaQU0A;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Og75G54Y
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A6214089B;
	Wed, 28 Oct 2026 14:48:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fPiD0cx3cvQr; Wed, 28 Oct 2026 14:48:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 78121408D2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198909;
	b=ii1jh6xHIg0E6OuLxsGN6XxWSDVr2+H0WBYYBNLByLm1WbTZcJDSWi/sxGfLtjMDAFI8
	 3pibdp9KUv/ChUU6dwp1yqykIiODHVCMqUtAVqgCQuT8JqFJyXGYYC+U8c6U8iY600Btn
	 2wfbtj6bn4uMWw2YuvfAJNpheIPQQDqw5KhsDg7OXk1rquV8/hd1GXcBW+qW2QE5djn5M
	 ThosSNAHFopjFl6mSHvvg/cGFRFDsj+JjQyWFs9zy3ZHAf5iBu7f2A/GC+UFn7HYw4Keo
	 PDHePgn5scgItFrJzMn43xX+7QvQ5BoBeRY6roLxewSHstazBrrlGuG8t/musLqOtiw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198909;
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
	b=UblQhls92XpYOwcyKGQZ6FkWTqa8OyfkXfEzFBWmU92X6gDDXaF1iqYDlOlxGGKlN+2H
	 o9BcoDFcFFoARsCNlnO43CPMJhJIH90eFC/iHVu5s9ojQMWh1DARC7XeWidQB4qtVFicK
	 5MH66Cfhl3lOU2I2mg/4Ojuv4doe6vqucOKp3WTkbx+A9Fjw88MGnsmNtmrjn3YGZa77H
	 F7tI57eIH1jag5aElIYumZWdogfir7tA6BVh7ojidlCsdIGcc/Wg6sQR5A5wEvnjUhQ29
	 aVOaOUri8urPXUzRlev9fMJZUWjQWeIHk9TsH6GcDLV1RtRuTiytIZPFApNzIFAf4wA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198909;
	bh=a0skoXip4HNvsNuQzwOisKcXucwWRttVxVD4l0eDTSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BCUaQU0A2xiiv4lQlm+kIL1d60mfT9qkUpz+QuzogLLIs+3Qy0aoH3x6SGHHrpZdN
	 xKze7AK4FFPxP5Xf6u4MYcW3MTweTaBqS8kiDOSMbSFxIHYpuyymn0+4prV9kwx4fc
	 jfqOeUXD78HjWuRQpxKL/5NW/qPu/8NUwf9fvdAprKMChf3tcF9jT3kgqCcT3G/F7k
	 wjV8r9kEbuHiRNyaUVSTl72hTT423kFverMnm9jN/0BslIXGgwstbDsvcIoRUGmHwk
	 83/6uzqNw97BUZP3hhlR8JqzKOEz+aZpcJD9MdqAeVeeAGpYHGujyJVlnPjnvsC4jl
	 4qYUtK1p5I0jg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78121408D2;
	Wed, 28 Oct 2026 14:48:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 18C61235
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 164D0605EB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fkmxhd9yjUwz for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:17:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 38F49605D2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793197025;
 b=SGAJzZYKoQYrGmhlhJ2C6K9GjlCleNEOAT3kmPvcJVQ6Oc/alLxfZVTQJo2UPZcgHKl8
 44WhFGOSCWVTHcvQxUhuxWIukIeomw0L3IPMt10yOTgs1TiYu4Y5wbWcyfdDawz2cIyZX
 FPTQ0GlHqbYalcQrIbZ4u6J0QqraZtLvw5NerLqf+zSWJpYgQSrfVnQz4Doyt33rBULxX
 +HVbpE/wPZySKuzZsu+Kr8HcqoJgT5UzlWX2ZMZ3r2sHn+j91sDChOLUIIcZIn2JFD5HH
 HgXspRrf9JyR0KZfLPoO9VbImYk5aoTlB0lZZdI33C8BiheWQrjzNQMfaC272L/Ftdw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793197025;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=a0skoXip4HNvsNuQzwOisKcXucwWRttVxVD4l0eDTSU=;
 b=JacXAAgzj2qvMcyRWvNjAA6Gq7MnNvvXrydkUDXxBJNL4mcSOopKHk7O5xsvIC6oSyLR
 YC4Lj7guUomynvDhMYp6N+kxdvx3YUW7AxbX/jZXzVuBPtnmQEjDkem18DtKygrbna++S
 N1o9Zd+YTkovLkO4tLS57eXjxBpZgjI3qqPH5vgtxR9x6REPfZElp3iydKGa4s8MGUDes
 p4tV1Xh/UxZpOwIvNznE4gN0cK4zN64wtgPk7odad+N3ZfgQlHF6vDMch4Kb2KvO06aHZ
 VCAx2GF7vgL8Iu2GmtZAP7y3LAgI9YdbCP+W2wl5EGGjpwV8cbDwmyjCHJijzDPyVRw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Og75G54Y; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Og75G54Y
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 38F49605D2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:05 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6aa77d4d968so216660a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793197023; x=1793801823;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a0skoXip4HNvsNuQzwOisKcXucwWRttVxVD4l0eDTSU=;
 b=Og75G54Yf7KjdJLcA4joeM5D4opCXCATOvFUIU7ls3RKTAP0M4Vnk92XUX2YD1K0DW
 rmu8Ih38T3KYMweT3yO52Zu0q5Ntt4UujmFtSTIpr/Dx0louWWg1VKTSDCnQiKkMa26w
 4N1iY4VlPQm3XF7Cin07M+WCsYt5s+8soQV72U4GEvoBZ3o9DZac3hFYBc6y9arBw3jw
 YBadR/ujK4SWCvgN9jKEtwkVNGf5NN1hlK6/JjS5i/qSJc8tV4jeRnNuH+zDZ2SGd6KG
 Dj2osW2PbWg36AGqMbVBAsjGRKbKuJYRDJoXaX5QbM/GCHHMNqLw9gfwtGGXlni1R9IV
 zfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793197023; x=1793801823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=a0skoXip4HNvsNuQzwOisKcXucwWRttVxVD4l0eDTSU=;
 b=J+S9ygvLg8LyDisUOR3UoD6mIKDWsMeTo80hFzdns7iZQk++AzHoyL30yj78C+NzKD
 3JcoViJfvyJ/G7H8kZRMEAXALjPxwRReqxhO9laq7lJvZAxRQEVKLP7qcnYo9tZ4W142
 g0Ecui/t6XG910ZuMyYYHVyJGR1HXdgp6PgkI1f9kpDznyPlhJmOiiCS/+G4PN6bcwzh
 9GZO+dsRSvk77R7XHNY1qaZPKlGvZ+tuKw3V1lPlJpI4uwKH71Z/TUfM4ROQUhU7nor2
 fWna9KwntenecxM2NmhL0Zkb+7fcYcOMekI0r6Bq1UxFoXQVpZ3kLfbX2lO1eiV5GuJO
 IjlQ==
X-Gm-Message-State: AFq9FYJ7oxSrgpbEKDZ55WIY7TWxStI7GB8qGTIOmMsCEULuaQZee5ZO
 M4+q4r5mxZ7hHMeW+bEk0BhACaT/MoRID9obC1Fo7A0MqTW8+h9/mb+iudU209rlaDG2xVdgQC5
 WD5bZ
X-Gm-Gg: AYBFou15riqUd3QLy3bq1XPK6O+3gGmq8mhHfij5mIa+Cau5Evu7j/MhmFhVNXK9DRN
 htSmXMamo3OykIvvW41hJO7vzVv0yeId+pDtA7YF+lSCF5KsQz5rCjXn60WmdEzbDy0HlOERAtE
 WbD2+LpAQz5x0LBk2uc/hC3HEceynvwybb2kPygzLRCIgdZ1uSPPWbwYLjuwArgNlP+8MRTIR/R
 j/SFlZYJVsJCvp4tl6lY92GxNUnzS9f0/ZsNx7VgPyCVCgrb/EWvqMP9LuDZ2IpWsJJwDwpPK4d
 0WVj6VZ3lxAHZ8yjB/fbBVjjpg9H8bw7j4nNYQuGOxuNhqedWWGQhb5hJ1T+/yqpapvV5RkBehf
 JmAIcQ+ismUiSV/8kLUZgy676XwH9QJNxma222fYkT/UppclsGWc5QDr54BD7V73uaFjDrG5+oa
 nVuKQBs+IzBskyYnFSXsnkuQ2iaEXyP8MBRMNY6chw8WvWel803S/yUe2VShdqGlkACEkccsImz
 /E+topARX8uju3ONtoLpKoCJhuyNioJsOOZrFlv4ctLIrz4oNLUw9WmGKd0cTNHATUpY5xJYDCV
 hE+2IpMKkcpkG2Pfyw4O/UJdev/seYeD8SAUh6SMF7dEHQe3AJvLjTIZxZxjD3G6JEVYsFppR0b
 NdFncsDrVxg==
X-Received: by 2002:a17:906:d932:b0:c43:f1ab:167c with SMTP id
 a640c23a62f3a-c49bdd9ab19mr230497166b.1.1793197023184; 
 Wed, 28 Oct 2026 07:17:03 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd524266sm630412866b.38.2026.10.28.07.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:17:02 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v10 18/30] usb: gadget: dwc2_udc_otg: fix up after the resync
Date: Wed, 28 Oct 2026 15:15:42 +0100
Message-ID: <20261028141554.3073545-19-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028141554.3073545-1-anders.roxell@linaro.org>
References: <20261028141554.3073545-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:47 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

