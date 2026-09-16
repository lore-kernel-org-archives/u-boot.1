Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B151C982C3
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 13:09:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 15EF64075F;
	Wed, 16 Sep 2026 13:09:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sWBjbBu-gjpM; Wed, 16 Sep 2026 13:09:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 514E740774
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789564154;
	b=n2v8Q0Kq84ZMfsfK2t2QJVUgs/K3bJBnwXJESBx9+4D/9ws1titg1WPo7pmDFM1xaKy/
	 7Ul2opcicJg4U4qfd8JZHly2U/k5es8QQvNqlPfmDXsrol8nLanNJbuwZzXR7F5HfKUox
	 /wPAhhPX5Sku01vetj1VuHO48f/fvhdr1sAmT0hVXJWyEjieZ1vekIRE9lYmzI6g+iTKQ
	 /ZMl2IDWo3a9wkOZ1jKVomRN4WVc1jxP3+fCeApczCVAkrA0vy2xgnp/jY0Gis9OxvvjV
	 TijN9WDf0/D9/JUvi3nAHBUmh4I1fdvPZ9OFZC8wdYRyEogfHatrUJ68TERocyPf23Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789564154;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3SFnx7mHEBtVl8L5Ja4985xmjxwacWTdBthYAY7xw2A=;
	b=OdLbA3M5TyIg1eo1lF0u0Ob+/cCjab1uZtZZ/4Q5pel7WTBNeuJxZ/sntUJn7BGJwrTy
	 7hrlgmu70celTGrK4YaQQBWIFWpxZn9WZjm8Rly+8JW91sLE/+/0JfS+hG4iX7sAzduCg
	 rujxiV4MwUWOSoZ55FYemO3eLEtsjzjIapu4HsbBfd+2+64I+kHIMOKsdCZ7XxHDnUHiQ
	 OhsrQ9DlqgubcWbaZzDdbqXlr3BSKhhsSNGE89ci6iGW3q6b8QcTRle99z1T30bGtosk5
	 Vfa8K/Q9hX5vBhvup3KySO3LFFZKRT+zYUqZhiy7Ui7o93BEy5c86OHyczK657xEPGA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789564154;
	bh=3SFnx7mHEBtVl8L5Ja4985xmjxwacWTdBthYAY7xw2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x+Clkx4/uJNc4hh0U5NYA3vhUM0ARbFnMUGuw1ZR24Zoe/sPhN3RkyRTj1WURfmmg
	 D4qhXkWDOVAYm2eucAELAwPxqJdgLcpj4eE0QIkp52iD4ll4nVSM5dGDcSsGLoqmOk
	 ZXdkj3UKZTAS8Jp9c+cP/1cjLDZpXPj+eco5ZgoDJX741s5iO99BQQ8lJ9zuNHfIhB
	 zxaK4LIWhOSzzImGjfd4CoxnsgSY+z7kg8IECnkxyTWAK4swmrwEa9KKMzAE7MSHKe
	 r1ZnZRXxQ6CtQtFvUXNe3CTAj71Lgs8dEPjoazP0G0irGHVQS7yAE/1KyeMlGXOU5g
	 ytgqV409ztiMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 514E740774;
	Wed, 16 Sep 2026 13:09:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C27EF29B
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:41:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B3F7280E46
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:41:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hKRxGSo5L272 for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 12:41:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B611C80E3F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:33::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789562488;
 b=F/CYlN3YCWgQ3PLQrLHtdU632ozV4I+buRfhUx/DnKueecgUZoHgFCA80ZRYQz7Opsjz
 V2WYS3x93xtMJihxRWx9S9x4ODC6Hnaz4QxyfQce47up8h/7760qzYj1WwfUYFFZGSU3l
 AJ885SjG+x9hUgu6LoBYa3aE9No4kC6DyUikEJtd3cSIJq+n/uRxTT7DSsvT9PeVCW0xJ
 zajqAEgpOFOYxWRj8zCytBqawEkD7bvQ+LOAyCjDHkFqp+Yspqwic2SWA5M4KbHShpWNd
 QgAFqALCMH3qT3VERmesehsu6svuoLqBDIOQiygpG7lHOcqLqkmU6DheOCzp5ovZTLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789562488;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=3SFnx7mHEBtVl8L5Ja4985xmjxwacWTdBthYAY7xw2A=;
 b=Amzp2um7n6Qi4dlB6+tr4IEI1erqqb9cc4f1NeVmE4Z0WEwYbGs1NsZIwR3B123KqzwR
 X/Zbkc1Belc0mJhlQGHstgxAuvlMDms+8lFa7aTeF6LsUahjNn8NrW4j4b1+DUEMIcPvC
 pTCyjIuwcUirl2WVjMA6A+zDS2ubDafBrQI5yIvUzMNHuDuovd1LNZ1rqSYTErKoWDOGn
 aJMwDxZayWw0oP/PZfSqf1Js30eq5OIcOr2z89707T9Z7ifmFeWPxIkXjCGDg9AROmjZY
 1c0TWjE9zhqJElqsCkP3S66yLlFtYYdjn+1rZN/UisiLa7OlgxSL6r2an06r2Xl/OJg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=BVO3vdlz; 
 arc=none smtp.remote-ip="2a00:1450:4864:33::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::f;
 helo=mail-ed2-x0f.google.com; envelope-from=anders.roxell@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=BVO3vdlz
Received: from mail-ed2-x0f.google.com (mail-ed2-x0f.google.com
 [IPv6:2a00:1450:4864:33::f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B611C80E3F
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:41:27 +0000 (UTC)
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6a5d8ff762dso135744a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789562486; x=1790167286;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3SFnx7mHEBtVl8L5Ja4985xmjxwacWTdBthYAY7xw2A=;
 b=BVO3vdlzCh7ct3gvoVx7Ecomhz7kFf53xD7FquDHCTIeWiMTLU6GKM86N2gWNXn2SJ
 OYdZWIYNJlNsANocc26wMXC8/SzsdO6OQIVtVtgIjrFxLyQ1lFktvuPIHP9IU23EDDbc
 lI1iduqyNkMVRummhqK1XaBXQjAQAKUOHezEk9OHFHNobTdHVEGsFRtnl6RBZ4WUojuk
 LX1GBLwHkQ1GQ/5lYfMEAq7bVvIcdhXkgXcbT8rdOEGUiiJeCKx8vY6HDgnCc4/2DuKN
 wjWghQRv3d+Nj2I4VrouXqA+3Kyx2wtPHKdN2LdgqLlGiH8HE8JpP0KHPIMG3xhkGi8M
 +hKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789562486; x=1790167286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3SFnx7mHEBtVl8L5Ja4985xmjxwacWTdBthYAY7xw2A=;
 b=qODlXClXL/U59oRInnwk+gF4E81xRkHeBpdVLEzmGXkOP89GEpYekHWFl2EzWjGmyd
 aFeWl/T47Tfdqn5T/NFdCTkg47PjtYBFu/yBD/jw1njeVjisoyD6GElT1RDYyWYSfs8s
 8rgJIj6xJGGcw5nCF1kYjjh4sxzHJAlAfGOuhmuDtgFbAjrgHucNTW/DpMYTl22zvs5B
 2vqo/7LTlnCx70QiUaXwcFuUP/qgSTBdrhgCE0wMtmAoCXtnGJEEyfkKyEJJAAxGulGl
 Evy+A06uyNGrlxPOBl6KL5scR1PXhyvy4FF2IYGRrKBnhKLkOTPc2ImuvaT5sNHAQqvO
 13Rg==
X-Gm-Message-State: AFuF++nclroACgqDw7fhx5iBYv8rQY3WKoaMMIWTPtrSDn6yJujUrUF+
 ovg2CKVv3GU053dz7sciuMQ58d+puqbxWX6XVeKstqzKTQm6x9GsQnrR5ykIQWdF1R+EYxSv9JS
 wlGiS
X-Gm-Gg: AYBFou2wO6MWrAx+fC1+w+yIt47n5ZI6o+yYgvGgU/ovP+Wal35KpnpI3hNkGYa0IvV
 JIzxtJBK4w8YDzQPQcMoNjCw6mn8yWKqrmboh0AD8biTjkKM8cPI3N2YqHsTnmJgZElswayE5Lz
 zTQYctXSpW4gU0138r9Tc+AHLJZi2kzRuV9kK9hH8FT9roEQiCdt1aImeSF7MqV4SDqHGS04no1
 CjJwu5+1fZO4/UjpcmPNBMlpI+fU/08yzN/v6FbfcZeR8m/yGUzvWcz/6C5sVsmdai9wFYA6wAy
 UTe73PZyq8uoJ7MAKdr1DIO2BCiVXq4B/anpnfkt+TEiYyzVyvyLeGpcwn5AWVFUTtz2ipjiAiw
 xQxSFoGNkx3og7FpYDiUNXcWacZrLwZHYdD2UTshXqsJzxrGc9g5w9ghbwGzAVUP2pqbWVLQjh8
 sqjKPFy9L20aL7EFkPVCcLdcN40esnsp98/ALJt1YqGr4gkbp4OnQKUGJkU+IiW9Wgv9tEnc1Oz
 FcBkkrmgWcvYQFmnrb8YGiOH5SMsf9BU3iRYrub2/TEPboNv8MhcXhbDA==
X-Received: by 2002:a05:6402:1e92:b0:6a9:a2f0:9b50 with SMTP id
 4fb4d7f45d1cf-6aa221888bcmr1919113a12.0.1789562485469; 
 Wed, 16 Sep 2026 05:41:25 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa1d2a1289sm1487519a12.27.2026.09.16.05.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:41:24 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v9 21/26] usb: musb-new: fix up after the resync
Date: Wed, 16 Sep 2026 14:38:21 +0200
Message-ID: <20260916123826.517181-22-anders.roxell@linaro.org>
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

