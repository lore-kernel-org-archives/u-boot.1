Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767B2C5DF9C
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:47:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0643981160;
	Mon, 24 Aug 2026 16:47:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BbimCM9ga7mB; Mon, 24 Aug 2026 16:47:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589946;
	bh=XTkw99wHhMDKxohNnkz5GeHj5w+F7HqZ+heONCKVieg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ghl2hWxfGPtMuS3ITLqhpuA2EH40BPkBZHbDkn/DhfQyeGZ/8km2cpOwRejbXiSkg
	 69SGaiGocaBqzJngfFJiDWxTbUYgmr5peMdFkC6f8S0C4sHJdBF0eUhFVzOS6JkYug
	 jXUBNNaG8NyWflR5zQUV80coFENfwsRPQ1xyb1DVt020RQnJd5tig/wMCFTzKUl74j
	 P0byJwQNcAJbfFVt4Jcg36I0UF3bJ3nZH0RwTHiZ0/fQufzzBlwdgxcnd6gyOk59il
	 a1R2fsd57qENg47NMruLqO0i3KRT9CmY5prquYnTh5OGlajLjtYOi2pTmgQkes68sF
	 zAWSgcDlLHXYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DECCF80F6E;
	Mon, 24 Aug 2026 16:45:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 13E832FD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EED4C40068
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Iw8R9_mUGfCh for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:43:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=H7UtB3jZ
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B260340029
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:43:02 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6a1541ea780so596958a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787586180; x=1788190980;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XTkw99wHhMDKxohNnkz5GeHj5w+F7HqZ+heONCKVieg=;
 b=H7UtB3jZIwt+kQntAH8AnqojNWdLUJTPwUaQZwOVX5JagqRqWf/3I0MuMZfEPNLwoe
 rwYnW3Sszs2II3YNIBxY9ZxzpNOe6+LomoMkkxXrdTaWsC6+JR02SYgMYwu2G4wfHWv3
 MQ2bnCi2BMbKPiTJpcdYo7PeuN9u8oBUJRYcZoRdLOh54JiBXHbJY/NgiAWAbawZY1LR
 3fIiCbOeaqPML3xdY39u5UFJMw/rYwl+MrFfyIky/UD4DEzHuy10wFkon9lhrECHS7l3
 O3Bw+3p4bBXiKqk3/ybFWSXTXS9tRsZKo5rOE70o4uefJUNz7iR80NXzMLmayrv7235x
 nKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787586180; x=1788190980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XTkw99wHhMDKxohNnkz5GeHj5w+F7HqZ+heONCKVieg=;
 b=krgn/YxAPNeM3YkbQzdqEvqqlV3nQvsmw8vtl0uCqtOv+SetT+rA9TMeyY9YPkw7MM
 /IDkHykhGjMPn7No7jwHcgWuNwB4tWWXmfUwp8OSGz5fRcdjZtm7SInBBQ9Ei/hXdIse
 cLgy2YQWk/FUtE1yItDPfqywz02rVbx2wk0LxN7o7P6ISCOn7TG3aqgRJ0v2oeWVKnIU
 j+s7G4coVkghHkDWn9jQqEQfkanZ4NMEWGvtyjnlYyeeKO2lyS3czNYMa8ptwEXfk++h
 uWOsVyPRKT3XkN9hYkRmZ2FyCZ6Bsgu0bT1UjHCEBVjgplO8HPXBUENLsTrPPMWPYtvf
 qA4g==
X-Gm-Message-State: AFuF++m9Wn9ylTO9p2HPEaGEonS2jIUB+2gDpdqBo5rvPmxqJovsxpYy
 p41nIDpVhuKatU77G5j0fgmYO3D6UQ0517vUq28eIIJAunLSYVsS0YTsFID+tQlUCNATO+gwg+2
 tMotu
X-Gm-Gg: AR+sD138tXwq7eQqNOhH+/wf1qE7HlKgeZkN2deXA5OjUcgd+vNPt9wC+kCGYilZBvT
 n0hw3ZM3HWE0GWBf10lEcgUyuDmQ5ibepV1gNM4GIAb3r1FPSpOfn6u1I3XqCX/WL/syawUtqsN
 oCRThPIpUBwcsn3c4p+JzPKZ++5BL0G3S2eRIjr2lQM7UKrTvBg7aNMeC6JERSIH1sALGGWAqIF
 kdL1ZoMZbISPT1jyUboow6I9FrQewcTL925jE4KaNF23cH787inoX/oOinmihc8Ne2keSvUK2TE
 +CXNEhpBQ+W85pzlI6zlnihhvMn/J2O8BMFowaeHJldvBN4z//neAsPVI/2TCj5RAvh8OUmT4Xm
 AlsAlRbGY7d9TGVwMWJxaYW/nUceXN8JAWekRwG3L7mrPKkaB1geFfzp72SxgTr9EA+WpEUuybC
 8aIAo1rEVDBu+B33e5GouMcpB58YERvoNzFSPRipoOsshYPKcoJR7AANQ4XqtKnkWkRA63tzc/I
 7LCxnpmKglmF2tFkswp+g==
X-Received: by 2002:a05:6402:5d5:b0:6a0:d5f8:9ebd with SMTP id
 4fb4d7f45d1cf-6a42f1bfb5bmr16293259a12.2.1787586180090; 
 Mon, 24 Aug 2026 08:43:00 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e19a05bsm13368763a12.17.2026.08.24.08.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:42:59 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v7 11/24] usb: gadget: ci_udc: move to the udc-core
 registration
Date: Mon, 24 Aug 2026 17:41:20 +0200
Message-ID: <20260824154133.217744-12-anders.roxell@linaro.org>
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

udc-core has its own usb_gadget_register_driver() now, so drop the local
one and the matching unregister.

ci_udc has no probe and no board calls into it, so there is nowhere to
call usb_add_gadget_udc() from. Take over the controller and set up the
queue heads from usb_gadget_udc_bringup() instead and let udc-core bind.
Without this udc-core never sees the controller and gadget stops working,
topic_miamilite for example. It still builds, so nothing catches it.

udc-core calls udc_start() when it binds the gadget driver and udc_stop()
when it unbinds. ci_udc had neither, it set controller.driver from its own
register function. Add them and keep that assignment there.

Tested on an i.MX93 board with ums, the host enumerates the SD card as a
USB disk.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/gadget/ci_udc.c | 57 ++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 35 deletions(-)

diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
index 53796887dac9..87194601f67a 100644
--- a/drivers/usb/gadget/ci_udc.c
+++ b/drivers/usb/gadget/ci_udc.c
@@ -94,8 +94,14 @@ static struct usb_request *
 ci_ep_alloc_request(struct usb_ep *ep, unsigned int gfp_flags);
 static void ci_ep_free_request(struct usb_ep *ep, struct usb_request *_req);
 
+static int ci_udc_start(struct usb_gadget *g,
+			struct usb_gadget_driver *driver);
+static int ci_udc_stop(struct usb_gadget *g);
+
 static const struct usb_gadget_ops ci_udc_ops = {
 	.pullup = ci_pullup,
+	.udc_start = ci_udc_start,
+	.udc_stop = ci_udc_stop,
 };
 
 static const struct usb_ep_ops ci_ep_ops = {
@@ -1139,14 +1145,23 @@ static int ci_udc_probe(void)
 	return 0;
 }
 
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
+static int ci_udc_start(struct usb_gadget *g, struct usb_gadget_driver *driver)
 {
-	int ret;
+	controller.driver = driver;
 
-	if (!driver)
-		return -EINVAL;
-	if (!driver->bind || !driver->setup || !driver->disconnect)
-		return -EINVAL;
+	return 0;
+}
+
+static int ci_udc_stop(struct usb_gadget *g)
+{
+	controller.driver = NULL;
+
+	return 0;
+}
+
+int usb_gadget_udc_bringup(void)
+{
+	int ret;
 
 #if CONFIG_IS_ENABLED(DM_USB)
 	ret = usb_setup_ehci_gadget(&controller.ctrl);
@@ -1162,35 +1177,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 		return ret;
 	}
 
-	ret = driver->bind(&controller.gadget);
-	if (ret) {
-		DBG("driver->bind() returned %d\n", ret);
-		return ret;
-	}
-	controller.driver = driver;
-
-	return 0;
-}
-
-int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
-{
-	udc_disconnect();
-
-	driver->unbind(&controller.gadget);
-	controller.driver = NULL;
-
-	ci_ep_free_request(&controller.ep[0].ep, &controller.ep0_req->req);
-	free(controller.items_mem);
-	free(controller.epts);
-
-#if CONFIG_IS_ENABLED(DM_USB)
-	usb_remove_ehci_gadget(&controller.ctrl);
-#else
-	usb_lowlevel_stop(0);
-	controller.ctrl = NULL;
-#endif
-
-	return 0;
+	return usb_add_gadget_udc(NULL, &controller.gadget);
 }
 
 bool dfu_usb_get_reset(void)
-- 
2.53.0

