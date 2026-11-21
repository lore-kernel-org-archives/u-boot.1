Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE634606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 13:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Z6n4r5N5;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=TS7ryOgG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D640660792;
	Sat, 21 Nov 2026 13:15:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N7C0J17IRvEY; Sat, 21 Nov 2026 13:15:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DB44160698
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795266906;
	b=YWKuRktKDUD/k8f6Nect70JcuPOTYc3aBICv9gtfPNOMLfobUyh6zlw+Kz/Je+/uEHry
	 trID2U3qF94Sa2++xgwdEkryS65qZiUv64bShnfU/s35oDa3G3CxYcSDieSPkl0XyrB54
	 QXb+TwrQITLMHJsy9YUvGrisaR871xI5CaMlcBTnqBVf5lwDMYPc58p/aTOyytbSdSI5X
	 DNIXUWmlxLhxJW8BAtQZxUw2a+s/8q5zIIBd5bU83el6Y3kGMFEifp2URumK3Co2keaOP
	 WozlGKzIlbi1ZlmbE7kfoABztGuwu2qarpjHhTdbp2zyJFgIw4S1MiH2sEtGDfIS/ag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795266906;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yYV2SHJFnJrKxIggdbEFTP3NiK4Vx0/S6+xctXH25yE=;
	b=JHkEcv3XtiatiJyn/YwmM6XOxmo7Y5caOanBlDaRmVf5qQbiDiMdE6OecYVnWPBxfspn
	 JnXL1Wqqaj5Qwmzei/YkkaxJxbz6D7wS3OIETy621Nk/z2NmuN6vGYFXBA9FmRMWgR5EJ
	 jRVRjwkh9NwsjvQiElMwPoM7wFnxv2aN3SKSbAnnN23RXF6GitNSVUP7kHx1nU6ZEv51t
	 ipmaV2UIzTSuwZ2A3O1L1fp8ziMdFuE7/MVAaWpTzxYNmIGRppt/Fd/ilQe2J+B/VhUjj
	 dTM4ADCCeiQENGoK36CFtfgjqhTApQxZ9NWgRcppraAe8ubgqkegOBpwy/6TvfQ5hgQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=TS7ryOgG;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795266906;
	bh=yYV2SHJFnJrKxIggdbEFTP3NiK4Vx0/S6+xctXH25yE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z6n4r5N5SLzi8suguau3uVCjPjZU/bE8WsqN5cU21EtcI32bhoEeXhyphFnZaQ0g1
	 WQzcH/JdKusytZiHZKSFWLGz3Dwcqpj1nCCSEW73moJaM4QgckmqcyVDQbtosyTZ3p
	 BqhYlPqNwdc9Sn4+xoRBuw1HuYosM+3I4hUFFysz5K4FX/xtMNguwlFuOqNG4AvLoN
	 AKMp5oX5VRksQrDAhMy+MdwwH7XITfLlR5NIxjYjjcotcKugewjXUtB7rDTZfgVdRU
	 7cgoAtqJ30yMFyLd+feKVnuBh49YsCPPhuzXuUnzT1+BKZmU60LO8vk++yV/txMEVk
	 hV68QDYoyLS9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB44160698;
	Sat, 21 Nov 2026 13:15:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C41AA66
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:55:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6B31E60642
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:55:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yAhgdAX3QYiX for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 11:55:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6843160623
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=TS7ryOgG
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6843160623
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:55:41 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c5062bcb857so24860966b.3
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 03:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795262140; x=1795866940;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yYV2SHJFnJrKxIggdbEFTP3NiK4Vx0/S6+xctXH25yE=;
 b=TS7ryOgGaEzMpWDHnGoC6ubaCLTUyWFUqR7dZuQqD50y6b0zmdGs1fbybxSmK/YH20
 yDF/MTY9lBT8Oes43aJLaXFZhQV+p4BjrY/pb0VPmX21UR0i2nYeDx1xr577pZHt9FmQ
 vzNF0HLUBJzOPtynyWjyCRw8BeOr2lCg/CipbJoZ6UTeBoaj7pOZMYwZY0NxKakw/iiJ
 w8/WoiZnJTDYJmN40Y7z1dSTyblQdwzy+hH6WshvEPUZ2I8IbFfehIBqHVmfp0O6K3FA
 NJbDUXVlRh6kDn2HVj83pQsgEvMDZXBECjk1Dcw0IkBwLxcZyNDKGrACUh/p0apb1DcC
 QREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795262140; x=1795866940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yYV2SHJFnJrKxIggdbEFTP3NiK4Vx0/S6+xctXH25yE=;
 b=fjoHp2YFebbcY1IFWvgg+0arQ2p7sIr1KpbDdUtp0wrujv+rr0hiUfdyHybJxNouXZ
 nB9ZXN+wgAlaM/cJspTDXeX+eG7OSoquCeNcZuZFGumFZlpXMlgYlrBcsojbPSqR4yhR
 o+dj67MUQkgsYiSd0pX7xhkDFSUXW2sQpICL1NPXeDMdkGxCMmPEZ5pgftqYTYWwFVzS
 JwWTsxLm/hcVBmtiCpOBn2PzBUGqkl52U6m7NNnQNlFm3N/Fg0NelGzbSUIRreh2Kv7s
 tJ0KnMl7znopswYeCOuw9Yb9YdNELSf2sgH1q5c6yX+x3uTHBsIpEQn8mkTuf58orHeG
 TiWw==
X-Gm-Message-State: APuU4Z+bI+QZHrvlp3Mq2RjCT6g+FKwgYIQnLcwoxwzzwHHlIa0U7zXk
 u51/3qdgEyxcQJoeypCM/SOhQOB5nhAyVcezxA/sJGLa6HuoiLbmkQrtPcVyxMYJ8wDsH9sSnI6
 w3YoR
X-Gm-Gg: AZFdTZeZcwIUXiVHW7QyOn9Aw+xxR7i2AnveVHs1FMNiAa/2oPIWz5WgBRg4F+CUJz4
 KPsM4B+zt5TUpZIvJPAevSZ9NNyEsFKl4uJ2Rz4AP3WDzjhUWnh0JsH9sDryPP1sKivMzLMJCbK
 1p/1QGJ4YJkrrtYQFZZvpj0OQAjx0hV15TnzO8xq7O6J//qVMT9a+2f5n4k2bZ2xqfTnPJE9n0r
 G7QtzsvpC10QOSN8G7/jtkMnlXFtmiM7a5JXYjyqLuYuYUGqaD2K6OVnMCdLGReLu9CFOYfxTxo
 nTPfwK0eY6/5MtWfRwOl3ZJwwHIICCjvjAiiPpmz3RMVVlP1zhmUVsrIAgDb5NCGD9xD9brQ1nB
 85eUEmfVeOl9z1ET0BU91uVZSUR1uHqvIUO1WDKGNNWlJ6yH8jpae7KrOGO4+vblm9YnbsgdQMZ
 Kh8QJAw7CqGbe/NZGf+jegBAqW8WVaQxM3H6I+FS5hA0n+o7T1O8OYqS4Ooc/T1qWYBes6CByLA
 CetQMOmJuAlE1DWneqDZZ/WScu5ZfjjyPs6KdboHUgU3oE5rxwnNhQT2r5CjFhUq99I1Vz2lk+M
 BkVVqJJxz06ci+zkqOleJ7wwsJ8LIll+sU9VUH6oVO3DZihsUL1X8VAxg0CbueP6YW2qD9/7331
 tC3oKNQsLvw==
X-Received: by 2002:a17:907:2494:b0:c50:850d:7317 with SMTP id
 a640c23a62f3a-c513a531115mr471870866b.2.1795262140017; 
 Sat, 21 Nov 2026 03:55:40 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae6780esm194960466b.17.2026.11.21.03.55.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 03:55:39 -0800 (PST)
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
Subject: [PATCH v12 26/31] usb: musb-new: fix up after the resync
Date: Sat, 21 Nov 2026 12:53:30 +0100
Message-ID: <20261121115335.548142-27-anders.roxell@linaro.org>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adapt the musb-new gadget code to the new gadget API. udc-core has its
own usb_gadget_register_driver() now, so drop the local ones.

Without DM_USB_GADGET nothing adds the musb gadget to udc-core, since
the usb_add_gadget_udc() call in musb_gadget_setup() is not built in
U-Boot. Add it in musb_register(). Otherwise the sunxi boards and the
other non-DM users get "No UDC available".

bdata is a void pointer, so drop the cast on it in the
musb_init_controller() call too.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/musb-new/musb_gadget_ep0.c | 24 ++++--------
 drivers/usb/musb-new/musb_uboot.c      | 53 +++++++-------------------
 2 files changed, 21 insertions(+), 56 deletions(-)

diff --git a/drivers/usb/musb-new/musb_gadget_ep0.c b/drivers/usb/musb-new/musb_gadget_ep0.c
index 25b1de6e58f9..726864aa7979 100644
--- a/drivers/usb/musb-new/musb_gadget_ep0.c
+++ b/drivers/usb/musb-new/musb_gadget_ep0.c
@@ -320,51 +320,43 @@ __acquires(musb->lock)
 						goto stall;
 
 					switch (ctrlrequest->wIndex >> 8) {
-					case 1:
-						pr_debug("TEST_J\n");
-						/* TEST_J */
+					case USB_TEST_J:
+						pr_debug("USB_TEST_J\n");
 						musb->test_mode_nr =
 							MUSB_TEST_J;
 						break;
-					case 2:
-						/* TEST_K */
-						pr_debug("TEST_K\n");
+					case USB_TEST_K:
+						pr_debug("USB_TEST_K\n");
 						musb->test_mode_nr =
 							MUSB_TEST_K;
 						break;
-					case 3:
-						/* TEST_SE0_NAK */
-						pr_debug("TEST_SE0_NAK\n");
+					case USB_TEST_SE0_NAK:
+						pr_debug("USB_TEST_SE0_NAK\n");
 						musb->test_mode_nr =
 							MUSB_TEST_SE0_NAK;
 						break;
-					case 4:
-						/* TEST_PACKET */
-						pr_debug("TEST_PACKET\n");
+					case USB_TEST_PACKET:
+						pr_debug("USB_TEST_PACKET\n");
 						musb->test_mode_nr =
 							MUSB_TEST_PACKET;
 						break;
 
 					case 0xc0:
-						/* TEST_FORCE_HS */
 						pr_debug("TEST_FORCE_HS\n");
 						musb->test_mode_nr =
 							MUSB_TEST_FORCE_HS;
 						break;
 					case 0xc1:
-						/* TEST_FORCE_FS */
 						pr_debug("TEST_FORCE_FS\n");
 						musb->test_mode_nr =
 							MUSB_TEST_FORCE_FS;
 						break;
 					case 0xc2:
-						/* TEST_FIFO_ACCESS */
 						pr_debug("TEST_FIFO_ACCESS\n");
 						musb->test_mode_nr =
 							MUSB_TEST_FIFO_ACCESS;
 						break;
 					case 0xc3:
-						/* TEST_FORCE_HOST */
 						pr_debug("TEST_FORCE_HOST\n");
 						musb->test_mode_nr =
 							MUSB_TEST_FORCE_HOST;
diff --git a/drivers/usb/musb-new/musb_uboot.c b/drivers/usb/musb-new/musb_uboot.c
index 43ab3245e5c3..db399dd55a82 100644
--- a/drivers/usb/musb-new/musb_uboot.c
+++ b/drivers/usb/musb-new/musb_uboot.c
@@ -383,45 +383,6 @@ int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 
 	return gadget->isr(0, gadget);
 }
-
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
-{
-	int ret;
-
-	if (!driver || driver->speed < USB_SPEED_FULL || !driver->bind ||
-	    !driver->setup) {
-		printf("bad parameter.\n");
-		return -EINVAL;
-	}
-
-	if (!gadget) {
-		printf("Controller uninitialized\n");
-		return -ENXIO;
-	}
-
-	ret = musb_gadget_start(&gadget->g, driver);
-	if (ret < 0) {
-		printf("gadget_start failed with %d\n", ret);
-		return ret;
-	}
-
-	ret = driver->bind(&gadget->g);
-	if (ret < 0) {
-		printf("bind failed with %d\n", ret);
-		return ret;
-	}
-
-	return 0;
-}
-
-int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
-{
-	if (driver->disconnect)
-		driver->disconnect(&gadget->g);
-	if (driver->unbind)
-		driver->unbind(&gadget->g);
-	return 0;
-}
 #endif /* CONFIG_USB_MUSB_GADGET */
 
 struct musb *musb_register(struct musb_hdrc_platform_data *plat, void *bdata,
@@ -444,11 +405,23 @@ struct musb *musb_register(struct musb_hdrc_platform_data *plat, void *bdata,
 		return ERR_PTR(-EINVAL);
 	}
 
-	*musbp = musb_init_controller(plat, (struct device *)bdata, ctl_regs);
+	*musbp = musb_init_controller(plat, bdata, ctl_regs);
 	if (IS_ERR(*musbp)) {
 		printf("Failed to init the controller\n");
 		return ERR_CAST(*musbp);
 	}
 
+#if defined(CONFIG_USB_MUSB_GADGET) && !CONFIG_IS_ENABLED(DM_USB_GADGET)
+	if (plat->mode == MUSB_PERIPHERAL) {
+		int ret;
+
+		ret = usb_add_gadget_udc(bdata, &gadget->g);
+		if (ret) {
+			printf("Failed to register the gadget\n");
+			return ERR_PTR(ret);
+		}
+	}
+#endif
+
 	return *musbp;
 }
-- 
2.53.0

