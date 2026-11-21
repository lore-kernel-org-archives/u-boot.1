Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32087606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 13:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MjF5toZ6;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sYfDrP4y
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E847607FE;
	Sat, 21 Nov 2026 13:15:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yR47uVMoglxg; Sat, 21 Nov 2026 13:15:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EE8B160E66
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795266890;
	b=XhD6hDDxGqSXDymY5J/NcJjQLxrh18UUb4EvHeKRnTsTPWUHQ4Es+q5xJqU+tcFUU+dR
	 bUGNvZHwHDsBfQ4LOaxhT2jJsCwWElx9oTfciwcu7KITS7XMCpkStYansTrAAm+1he10i
	 IYkEwEmXD3KS42LXTt0HtSZx7EwibSYRpzZre9zhzEeHAh5IlsZH/uARUH9yJiUUcTkzr
	 jueCk/PcfsLs5wTgAGfM01LYrBlgJ9/slt51EdsVmvMNHJ6dAWIm8luFw+HKKYJonEtM4
	 P4SUXVAo7SUY8xIPB/X6zDHMkP9HW3RelBkFqDkgLpxRUn1VQ49gHnG9CBJYoS6lpfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795266890;
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
	b=PwBqDyLFWIFSgKwED1KF/ch1olVvcX4otNeU0YavafgdxOVRo5Uf5AGfENpe37zpPU6W
	 Qg4mgWyLVL/H8j/qFL7mN920ds3zIsTGasPT7mgzDr80m1LPl170eD2BGul1xykmbm7/k
	 QMF9Zg20Lcikkzk9t3YymjopY7wLoQIyPN1PhnOkzSBb5mnZQ4SsTVaxosy4t8gGYHpC4
	 dhedUm/+DrFy36ted1nMn9ie0lO7XvwvxAWZ+3VtZ4LWX0ff+YlHYCHWWx1A6w1BIMCDi
	 ICrN7ph1DaxF8X5eS8p6z0+dJE3vmK1CeV9ejXNM30AdOKB4L+wbzTIExQDVkTngVmA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795266890;
	bh=XJBP/OsyhvPmRlM5/+2vHAdmuyX4mJ53lv5Z1YPCiPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MjF5toZ61Zurd3+6vn4m/h/KfLq7p4sWW3cCTfocGGKI2ISkUQ4Ix8tWbvldgzmtP
	 sRa470V/532Pl5KqMDK2dGIhb0q/CGYGLrylZX2xuaWKsynEJy+x3YqbrJOqmunZps
	 VgdJMsY58C9M4NOG2Yt15H63FKuFNWzLrAPNvFv3MaGr5P/q32JqDcDd7/nKqQQppk
	 5DjbxFWaWMVCBxSbWaz7efy1dyanSfLM7r7xLMfk2uySKgYaqYsAAJ70X8G8cSMkcj
	 FfwgogNJxgqPT3cVV2lJ+6KjTbj8OXk+WfZVtra/+KW2JD558apIl27EPTmMT84zJj
	 MoIZ0tlkFeZSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE8B160E66;
	Sat, 21 Nov 2026 13:14:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9DBB79C1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:55:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8F5CF409F5
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:55:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hJey4ETmoZMk for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 11:55:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 81A0A409D4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::635"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=sYfDrP4y
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 81A0A409D4
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:55:35 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c504d4cc6b7so17030066b.2
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 03:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795262133; x=1795866933;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XJBP/OsyhvPmRlM5/+2vHAdmuyX4mJ53lv5Z1YPCiPQ=;
 b=sYfDrP4y/YTZo4x3Uuu+QFmowaRanre65Yi7OqMC9Bl4iYTrIW9T3gPhxrJoy7w3nn
 XjZXyGpRtJ8W1FO11ciFJleM6bvetUiggceItlL2cN0FlgyLT3g+CP+ieXYKretbgGRC
 JaBbriagAeyb1Ed58AgTv84+kv1XGvodUGtgBOZ4BLf8u3NHF014+l6I+2fbMFdGy/Fa
 mDa3RJ97FZzu8kpJUKr18j3C3/afaoVJaRPYncukTISwup1zFTWomcXaztxK23t44Kl3
 9iwnoZWRUXxeOOZ9FzdJ2rjwxhhh0JSLBqgABG4Fi+v7h6ue2P1GMXLCLLGI7D4/CRet
 Wttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795262133; x=1795866933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XJBP/OsyhvPmRlM5/+2vHAdmuyX4mJ53lv5Z1YPCiPQ=;
 b=KlqmUJnU15gwEdfIcA4vtDZ6hiaijA9Ckphmj2IYyHo6JWjw7FlyTuTmoogA6dYMuI
 kd8N1HaJfcvp4bZWIxxUxDvuxzflgZMDdHx3VTNj6ZRo+KRcDGM6bVT4whPjYYCfXQzG
 xTeq1lv9SWllC+iHOmc8+m5iTF8DzhQaD10xh/bdWZXWx6FqXH92CatG7IowHK5XJBvO
 d8sc6c2Hh9Ocme/uv6radRf7FFW9YEk9r9QZgUyagh4pNY7lJgkMwMqsRrbVauOxn/PR
 UWOpN10TpVJMrc2YPBlooIMUeKxQ/eDLOHtKSjHg63dGT0hqBEJIr2RI5a7gM4pyg5P7
 D3rA==
X-Gm-Message-State: APuU4Z9ZGLOVxQ6aUDzAsxDojtO+jnBZB05byCCXdJYkFPVu3vT6det5
 17SIcYtFOyg79cM9w6U1JPlzxMhgP998UUKAC1+YZv5Vws/MbdfbhmbqEY3mk6CAq8oxARh1Bie
 6N8WV
X-Gm-Gg: AZFdTZdm4sTAJb0gQaUOvIb9ZMPC4E7ivVH7//LL0AtHJMlbeaLHzkV3W5ExYMRkkls
 bhDhAwSzsaeYY32PYMz6VEipcvNL/3JzR8YyVjOdGxCiIFBf2s+9ewABQKxg4qOJhypsZzMLwjd
 jtywv+jTpXiAv9/EDaH+Xs9HRKhJw5kBHNfzrOzEULSfBWJpR5nG9mqSfhvBG4evm6GFiXPMRvs
 fG9IHXK6O7BTGY6mxGIFDiKS7xEY83reVW08AgTQKEGKCKqSH3j1hxullEuO83EBlqeOJUsb1LR
 /GqCjqzPlpwLwKTLxoo1kR7QT8dGVGlpIShpJRCtp+5oroin8FCyPw9Op/r6itA4AEryMoqvU7a
 jS/9sE2yeyeUh0YYu6qNeT5KnolmCPBL7Q7vdVoQssO+yN9R0P1/iiApEvgSRyL74EECD05NWtl
 9F+Up21e8raY7uJy1hztYJmD0Vdotq5hq6oraFtgfCr0Fxm429i0tTncCeonhGOL2ApBPaCJKFX
 wlnsrBgK8VtmxRp2bXP81O3IanfHdZpKF4GNFg4OZP0PBQIPGLm+oQHC7IhleYzILpt2dKvZIzb
 3lzqSXVWLxtkdorXoJ6sOa7F6Bzi2GQP+rndDrgmwHrR3naN10mgQ9xImzfJRheDtBs6oBanOVU
 M/3aCGW4COQ==
X-Received: by 2002:a17:906:3e41:b0:c46:ae89:cd3c with SMTP id
 a640c23a62f3a-c513a3971a7mr494198166b.1.1795262133544; 
 Sat, 21 Nov 2026 03:55:33 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae6780esm194960466b.17.2026.11.21.03.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 03:55:33 -0800 (PST)
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
Subject: [PATCH v12 20/31] usb: gadget: dwc2_udc_otg: fix up after the resync
Date: Sat, 21 Nov 2026 12:53:24 +0100
Message-ID: <20261121115335.548142-21-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121115335.548142-1-anders.roxell@linaro.org>
References: <20261121115335.548142-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Nov 2026 13:14:06 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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

