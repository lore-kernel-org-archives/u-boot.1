Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 712EFC5DF8E
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:16:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 44BA140F2B;
	Fri, 21 Aug 2026 13:16:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EY9iQbmoQ9vd; Fri, 21 Aug 2026 13:16:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318167;
	bh=3SFnx7mHEBtVl8L5Ja4985xmjxwacWTdBthYAY7xw2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=byNsPo0De59yVzKFb/rVvwCvkdSZitaikvU1Ii1vXbbr8e8jpahmzZH+LLYyMUXgY
	 injM874izl7rI/Imf367DKAK49X1mzMb0X1uga38nYVmiQnazc6CzXiEyFrJJJbrl2
	 0PpQq0ccD5QBoVUqm7/ckAz45CeAGL8cJLvIMi3Mhi+/7+psTTUUoprpVvBXwoaDbd
	 WjC6asQRL+xDyEFh7bZSehyLkp7mYbB1SGXYHlmT49/8I49V8hSvUbbmff57M/vAMC
	 mEUBvBm1BJ3Bywn+7ZPMa5uf8t8Olb7BrhsIZikDybR+n2s/tO9281r2ib/aFNR97W
	 51YQnACRefw5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2CF440E32;
	Fri, 21 Aug 2026 13:16:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C4D3EA3
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 824EC40071
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z2Y_eT2T7tSG for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:52:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=ARt305M1
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 41AC64006A
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:48 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-69a1c7ce59dso158729a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302366; x=1787907166;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3SFnx7mHEBtVl8L5Ja4985xmjxwacWTdBthYAY7xw2A=;
 b=ARt305M1GZrn4zSEmn1djkQutTp6SftOzFf/mUI0U1DfYARLcq7Ohq5Zeqj4vctvpv
 NdVvjG08j4SfEk4DOncaS0tHSZXXRAzms6zQ8N8YEG3qHKl1yvqaoS/X4jAgiqg05aq6
 VrSSWeKcQU/+q5BLzmFO08r4YO3PEW4eEQKqnu0X630DPCTLy+aaYgZFzFT+DGjaLx6f
 cnp4c/4J26CanA6bUf1e5Lg9GIUi5uTZeZebZY1nYObkWtnu0EBGU2MOEAJhcgZO4yr/
 hINCe2InU0RCj6Qwolx1RT7rlNsA2czhJ4cwf7gqnfHCEZP9MnZkagVfKs5Mqz+FqZ/G
 Lzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302366; x=1787907166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3SFnx7mHEBtVl8L5Ja4985xmjxwacWTdBthYAY7xw2A=;
 b=j9OdcN7XcTaWiahP85wUsiD7jqsVnrGmXLrexZN9BYe1z7mZXFyFTE8vKrCig/UYtb
 yUYYNCqBqufwZuKMirjrYxfj5OcBMHQIgd6uhgcwhkYXLjUNGZ1ilmn/6JpFc3hjMbl4
 uUBu8NjBDLq/lGcXbo/v7BM6/GIhmiXxLq4R70f+7o4Rhx64/otYAUkvLHEHrj3Ioqo0
 mpmZOLS30HaX/KdEpTzI7G9aAPgRNmfCenTq6Sr8dC8jbfJaCPt0DAVmYyKDnN8SU9lR
 2ezv3PPukAguKg0CMo9T0pix5sO5TvSgXWqOYdVSQZFsMOzyMiZ48hN7NAWA/070SrCb
 8OjA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpW9taxu2bx7i4t24T8+kaq8spb9eav/E9mTC7Bmu/pi58wU3jYb1FzGehF/q7FgXuSPf02L7M=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lencEHNf2Ucg+fcfzB4iQ2awucD45+Qx9Gt/h5AO572kGzmaCj
 1/6+y4Po5qQ2b8Xp6IMyTgI11uApaUb+/Eypo6oZGKYQFF9m9AiHQfWu8mfJNKJ/jc8=
X-Gm-Gg: AR+sD13PthLH8YvaN0mNeTyZtvOuPlYT1uZGrrZ9h9qxvgLa3sG3tvhG28Kh4+nbVBh
 bjb86SRPV7b3G0II3684wfxsMMBrEkePeV38nS7h0p7+knc7aBq1m3TIAkuB7Y+LYSYShiZjDyI
 DQ1ldz7b4VPX9+3i9A5gItVCHCvK8aLqKu76v0wuLUnNFsfOW2Ma76g31QiHBnBsYlsbEwTY3jV
 L0U0lmGfBO7yWTgHoTtVHqxKOrFnW9sO8mvxgO7LcygEaMtsBgC0Ys22KKuD6Q8SRVZq0yAcZKL
 7OFwBOcLI/19P+KzGVIA3oVUaiG8Ipjv9OLqwzKqFqtdjNcrsReM+0jz1drHdgr2VYpxtkpo8/w
 FjY31WgGJfRtnmmTsSrfkxxemG789w2U/5xT1mNUlhc+uB7I7zLag5u9CIdh1QBhFj41buxIQs7
 MgCpXZWts0DhrN9D4tUJ+3FIk6Ki+kAuiQMs2uVXp8C3iEDsVrDbI0TuwH6mhxijO4mm0SFzhpa
 8mtohJ6Zyg64s3hUrT1N2fAVIpzIukNB60=
X-Received: by 2002:a05:6402:4597:b0:6a0:f1d5:deb8 with SMTP id
 4fb4d7f45d1cf-6a42eea451bmr2799434a12.0.1787302366035; 
 Fri, 21 Aug 2026 01:52:46 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff0d362dsm5240694a12.12.2026.08.21.01.52.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:52:45 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marek.vasut+usb@mailbox.org>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 82/87] usb: musb-new: fix up after the resync
Date: Fri, 21 Aug 2026 10:47:58 +0200
Message-ID: <20260821084829.2070426-83-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:11:41 +0000
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

