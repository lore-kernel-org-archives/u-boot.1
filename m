Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CD8606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lpovIl6u;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Q6pK9BSY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9EDE381414;
	Sat,  7 Nov 2026 12:50:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9hBB_XW7jSgH; Sat,  7 Nov 2026 12:50:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0CAC7814F2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055830;
	b=k3MwRilXv8I0umhU5IcNUdN9noI/37j/sYmvnoZy/gsyIzj9Gm95tNm8Ry6ISTz8WRo2
	 ANcjztd3o7cNKl72gGK0VZB0mC2cB5/VszDKBg5gHRZ3Z5tb7zlDPSAAtrNyMbirtcD6y
	 LElStP4VijCdFcw7fy6EGZnNGX290V04Bbz5PZ7kFbBetV2wqoGGIpQtzwakKqBfjho+Y
	 /iO1VrN/fyVdVnGWLEw49xTwb4pVgBcIQXDm1tbfcKe5mWXs2HjKHi0Lc/CCLRbGqI8kb
	 hR4ujoSNSBrhnwJfH4PYK4GQkgrg+/8EHcs4Y7pvOarrbHnp/YU2PPlzeHYdpDsPlSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055830;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XJBP/OsyhvPmRlM5/+2vHAdmuyX4mJ53lv5Z1YPCiPQ=;
	b=Jg1i5Lp10agFaS24vHvF1OY1nJePopvEFobuCWjCplO5cFmq95b3581uG2O/dwz8Bjul
	 yno3OBq3Vq2lYqHQtL+zHqbTmhccrRUAHFPx/wJDs/941M/xzhBBdd3r8xCHAD2MLOXcr
	 2iPchZNDxWgGeeOXb2/pYB4dXImLCgw8+5VxjblkN4+14m5ZFy/FIISxJue/Hjstzeq83
	 GzTcGjDZYOmIAjWrqNXcmIGnTCRW3onPjmeRj5OaAdxsapwTkWUDnc0osRzbFv2R0hxo1
	 FYlGLBonDVlU/jGKGjTDpDY3OKZZnszsgfvNSRJwWVi5CqXDS67iv8K3E6d7EJ7zlWA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055830;
	bh=XJBP/OsyhvPmRlM5/+2vHAdmuyX4mJ53lv5Z1YPCiPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lpovIl6urKoVwBQrneSR9ewuhUoNJoL6x8wkxo0C5tVc3dLwGPGtNiQDjQ/fpijXC
	 vDipv7W4UJUvJpLK3bNfRcTdQaZkAJAJ8nM8K6Dmoin+fkn4++TAYCzPGX1lRLXqmF
	 rZW2n2oMmHePpzBHYYZrvWGsPfZMY7jNXYku0fj8g43iRHnDIS4/oe+SD62X69pFzv
	 cS0ccT2UD7/7x+4OByL42SEhNIKMij7LZhPO8tnLPXCAFLGFhPMHWnr3CUPKzlHkZ0
	 Gw5gfUr+50AygMrcz7E5WIU/0ozzkOGUQ4I5tZYstyVHXheFhSuXI/1S2KKioI9WhO
	 OllasJHikSeWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0CAC7814F2;
	Sat,  7 Nov 2026 12:50:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 100481C6
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0DAF24005F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:23:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kcERI6oOP_9g for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 07:23:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0ED4640042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=Q6pK9BSY
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0ED4640042
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:23:28 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6b7073ddb15so15035a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 23:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794036207; x=1794641007;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XJBP/OsyhvPmRlM5/+2vHAdmuyX4mJ53lv5Z1YPCiPQ=;
 b=Q6pK9BSY7F1gHCO+XriApaXNtU4x5RfsOJjQB8meR7XshTIeqE0V9syouat5n0P216
 /Cmb50/sud/IVWM3GQJEaeQE4oCcU02cc7TLfuLHFUQesKhCSvWJ6ba5pzDzgVyewbrN
 S2/B3/7rc53W/FV+F51fl5UCNCvHx31izhBR3xvLUU+M4Et7qYEbvDFXnyJRSj8OPEcw
 4R7e8LZFYjvritSVSzrBvFPDX6o/254+UHH/HpQPWEFWEiYGgHShTEAidB3hsf3xRjLw
 eLTQLhEabacCiBn5/DMROd5uoXqvzWPcta0W+m3SPYmieqAgWbWBO1eiLrE3YayK+6U+
 oFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794036207; x=1794641007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XJBP/OsyhvPmRlM5/+2vHAdmuyX4mJ53lv5Z1YPCiPQ=;
 b=DVba7UEPPjVTG8XGuJ5NYwKJfcIb5x4DjOTnVdaarTCVyvQZ2WUBqtfF+nqrm20p/9
 KT8+uO+R1Yf8mG/IAkq0MZZfu0TgU43PEjNTOEIqOpHru0VCpuecc9uITzSPutO4O50H
 QrAd39ILSljijIc/uJdXw9EeDusn3MUeOr7FcXr2skEYdrGLmKCGZ/M48GP04ir4sJ5u
 m33FL27SReyrLwd6ZvY0uB6fNvR3pJil1B/8ZkkvTdhhaKhu1sis8v5nh/auwtS3Q/TP
 xJyomtjtG1mrWKPxLIBPQpZHGEyEu+r/7QSyonp+GLM8R9TPqGY9uJU3iZTIh6REj40V
 7fwg==
X-Gm-Message-State: APuU4Z8cToJRA0NTqC0I0DWNCSEWyYqEOxRgAxC4RObviX0P9+5a81tp
 sxVxX4G/YpQArOTdTtscUavkqGKwTFj30eKYTIYOoVWgzEpgmUihn7HXHVUpvbblMupDloSjiTa
 ND7mZ
X-Gm-Gg: AYBFou3nYhm/HPudcBFjZ9Tk2QnjZbhaE4/qr3ivDQOjayLt8yhJ2bDjd+Z1l7Aqni+
 A6yBKA0gh3r5FLlJ04vvMNCKZX9XN4gkbbm3FduU40J7TEZ00/IKMcBKVEwYGp34C1AAmxRzg0y
 p5eZqKWmTiqkzX116gW2HYEOAH8RTQWkS8U2AIu6m1eF+2r/k5ey2gzeHjl32PCWQnkgimg/ZJL
 O+xcawDRF/SEx7inpbKiUeJkRjVkG9VmR6RTT6YMkCEgCpRf7in2ruh+t++KbKs/b9CgJpI/V7f
 T7ym5xV6D41d+KFl0xHfGLe7iyLszPdpTQdXxtMz/tNFGXy0yQEw6CwqHIH0WSTaroJghEKu/y1
 /+KHzWjtCLWl3M6mZth+069r85kagjK55/0DhwiBC7QYqrZ7XUmAoZa7X+8zOPrfaz5nkaZmgaI
 qM/DTj4JaNdObG/DlkGeWIkrqX6yHRVL1OkZ0NggRMkCLE3pmSQuICMaM7b2RSj+gPwfOXc72J3
 /EtwSiynmGLnLr1eqyMbB7Q9KNdgxA/nht/HEv94cX/uhddCcrYGMQ6QYthviJfckJ8hOAaI1hd
 WKm4mIO6H+q65AgnyUo91Ry3SV6hEQ9+GtqztY89PJLxApxtKkIjb7KCabJpDM5oiXaAcIODiFa
 PhWo3Gphfvw==
X-Received: by 2002:aa7:c1d3:0:b0:6b1:b5b8:b695 with SMTP id
 4fb4d7f45d1cf-6b597476470mr3670300a12.0.1794036206910; 
 Fri, 06 Nov 2026 23:23:26 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b664afe545sm1490649a12.23.2026.11.06.23.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 23:23:26 -0800 (PST)
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
Subject: [PATCH v11 19/30] usb: gadget: dwc2_udc_otg: fix up after the resync
Date: Sat,  7 Nov 2026 08:22:13 +0100
Message-ID: <20261107072224.3492260-20-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107072224.3492260-1-anders.roxell@linaro.org>
References: <20261107072224.3492260-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 12:49:49 +0000
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
call usb_add_gadget_udc() there too. Only do it once, since the board
code runs for every gadget command. With DM_USB_GADGET the driver model
probe already adds the gadget.

Build tested on trats2 and socfpga_cyclone5, both keep their UDC.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/gadget/dwc2_udc_otg.c | 89 ++++---------------------------
 1 file changed, 11 insertions(+), 78 deletions(-)

diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
index 4dc049d64b14..f005e05b7eeb 100644
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
@@ -939,6 +861,17 @@ int dwc2_udc_probe(struct dwc2_plat_otg_data *pdata)
 
 	udc_reinit(dev);
 
+	/*
+	 * Without DM_USB_GADGET the boards call this from board code for
+	 * every gadget command, and there is no udevice for the parent.
+	 * The driver model probe adds the gadget itself.
+	 */
+	if (!CONFIG_IS_ENABLED(DM_USB_GADGET) && !dev->gadget.udc) {
+		retval = usb_add_gadget_udc(NULL, &dev->gadget);
+		if (retval)
+			pr_err("failed to register udc: %d\n", retval);
+	}
+
 	return retval;
 }
 
-- 
2.53.0

