Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494C4C61CE3
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:45:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1DECD606F0;
	Mon, 24 Aug 2026 16:45:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NnfH-cSe9Tvw; Mon, 24 Aug 2026 16:45:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589955;
	bh=3SFnx7mHEBtVl8L5Ja4985xmjxwacWTdBthYAY7xw2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fi63WRqc6UqpKmcHdxopa2DDvErWciEupWBk8MtCEs8CBIgCIPyLMHPNJSYr5yFc8
	 Xo7+W0dH6kzNeefAXgFZwjxEQeXYTRZ7iTsi+qQpsjr+HhSXDizGkDS8TK95SDXJma
	 ZHG9h+QR4TdvVb0uzryFn9xz85VCsyryzBux2fZTI5uohsu6DTcmrIr24Q8LhDX1Pz
	 8oEjoFGLk97EST7nB9VSmXwxOWlJVBs/QX20OHLCH3+WbGs2YImNb8yGzXN4Wvo3JE
	 9ekEcKtlTJw6DtJURsSL9vT1MBKSdbd2YrDFCq1RBYZt2Gs7AYIldDln3THRwlbnjw
	 BfHS6A5B30UgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3602C60791;
	Mon, 24 Aug 2026 16:45:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EE44F396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D4FAC60626
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BalaQ9NhX1pA for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:43:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=YncwbbYA
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D4A02605F0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:18 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6a59ec8f530so207502a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787586196; x=1788190996;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3SFnx7mHEBtVl8L5Ja4985xmjxwacWTdBthYAY7xw2A=;
 b=YncwbbYA447tqYRmlfVe7AWJFgCURqKjvioQ2iLEUa9rynaQO7HTpYip757q2NmavJ
 Me6dgl8m+KAHlWjQ4rfsG67A/M2lj5KxrsGq1RV9cGDju1K3IYA35Z8yXCIijfoWmeoa
 SVbb5NNluJxhMknackuMCGNVZ4opzbB7hbMdmwlkNe1Fi6VWGGKKXGi2khgnpXfRweoP
 Aqw7hp8WfWMFegH+8ys+ptrF5ebdT1jds7wRuK+K7I9UpGFUDU0H9YMOGXz3eqbWvEJw
 Y99I0aXEPR+bJnXbz8YrZLWdWZIiK7qLrMKCVr0MuL9je0Cz0Mrhlw9Q1gIGB87ck9hD
 50ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787586196; x=1788190996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3SFnx7mHEBtVl8L5Ja4985xmjxwacWTdBthYAY7xw2A=;
 b=Zz04ArOtPA+bNL2p8zsM6GSK4MVC58uQnLQjPI+iItVLFvMLcxyWVoI961vIvCFSq1
 4T42R9PknpD2kVN/PKKl6TNzn5bA/EgW7GF6JV/ARdpflcqGVxYaoPllOTkBvSoLUKvK
 K283XzF69/+OfNjqjWg+TuDVtxTG8+4uIpqj1TKXpR63XE8XbvRaDW68eYSrF8XFyN1d
 wqdXRzJG7hrWltM+ahNlWN6eVzI2A145d/Wn4BsxBAnB+1OnoRDmNsLcZeK9H580gGfQ
 3/L/ojDOfZDDk6cEhRO/eiSJ0UssytuNDGL/ZiR8HogfcRS6HBhNPeohysfSxRbSoqRh
 3Q6w==
X-Gm-Message-State: AFuF++nn5iDyiYeG0BmxRhndM8n++GYjDyX76XG3jN3n7q/3HTKkA3TL
 3slFegiz2iTFqKAWRfWPQw38FGAM+L4bCQ+HmXHOOoGoWqqecE3/oRQtMxSKQ5oPOAdXl3/WGnq
 ehCSB
X-Gm-Gg: AR+sD11tE8aKBNR5olIqKh9ea8wIORcO2P1BBnqoKWzOLkOk8iWVzt8KGXiLiN3HAY/
 Ck2i/2+HhzgIvQvTyBR/oI2YGUDOTiWw8j68O7WeO2axCFF8DnE38ihBU6+XksBAc7sg+rIQx0b
 Cu9Yu62ibIiBE2hQaIziGz5UCcpJpJ3bJ1zJnSubgRFcXZbrG8tMPsqfL2eyXCLaLmLBIdrB56M
 oD5AKnk0jdQEgKPnAS1X5B5LJ7Rt/TUlGp701F39qPxLjpP97xb7usyYji509AivdQgO199KYqL
 qJ/pk6sAD+Lz4t3rMfn6tuMtwUA+NxJPj5gTt1uxtStH/iUx5MWMnc2uOVsMdzKJ9LbLA1xG/L+
 WdfeW+RsykgJQNnNDwI/QPmsxYry9WmsJJcb0PmedAE9xU9e/B2NY83TFW+BTt2vmk4LVyyj1/t
 B12M4g9cJcCY/OWVQBj9bPkzdxFEfAazV2ZZqiTD34ivI533U4D4aBd7SnNbgZotA9YAM/DnmsS
 tjiIaK+kaBauSA7nXe65A==
X-Received: by 2002:a05:6402:5d0:b0:6a1:d68:338a with SMTP id
 4fb4d7f45d1cf-6a42eeaf432mr15951543a12.0.1787586196307; 
 Mon, 24 Aug 2026 08:43:16 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e19a05bsm13368763a12.17.2026.08.24.08.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:43:15 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v7 19/24] usb: musb-new: fix up after the resync
Date: Mon, 24 Aug 2026 17:41:28 +0200
Message-ID: <20260824154133.217744-20-anders.roxell@linaro.org>
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

Adapt the musb-new gadget code to the new gadget API. udc-core has its
own usb_gadget_register_driver() now, so drop the local ones.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/musb-new/musb_gadget_ep0.c | 24 ++++++----------
 drivers/usb/musb-new/musb_uboot.c      | 39 --------------------------
 2 files changed, 8 insertions(+), 55 deletions(-)

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
index 43ab3245e5c3..16907c4681bc 100644
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
-- 
2.53.0

