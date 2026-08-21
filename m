Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037ADC5DF87
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:16:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 873DC40D9B;
	Fri, 21 Aug 2026 13:16:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5KAM63ukPG1G; Fri, 21 Aug 2026 13:16:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318145;
	bh=XTkw99wHhMDKxohNnkz5GeHj5w+F7HqZ+heONCKVieg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vHZmByUF2jXKeqHG0Wb6OXwfy83T4mLUQ6EWA7dlGMDGZK0w7erM+LQHIj5orFb+9
	 CSHF8JK5XpQV/NJfg5gDGHrtXYwSb+9iCheWcRgJJmvqS9nzpf2R8VIa8LJMj7tStr
	 /ZUMMb1Ck2u0rJNcwh89H1Ac99e2hCS7MXHouPuu+dlKDGhm/HhopGlFvQSax/e2TP
	 kSWknNF0me0u8MOi1XxxbLxEWQeB+ZuDercA73ySuDQctIKM0OpHXvExkWrguVDZwd
	 ujYTIB+G0zVYD6RCRdCFp6Ci2lIdzX3KMEoGwyyF9LYB1Pm4Sz5lw152SZn9iIgI1t
	 lraPkXzxd6dYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 861D540DDA;
	Fri, 21 Aug 2026 13:15:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DD9294B8
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C3F6D4090E
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9-n8wfGn9zJK for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:52:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=eraO14Mb
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9099E40931
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:37 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6a09571dd5cso133286a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302356; x=1787907156;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XTkw99wHhMDKxohNnkz5GeHj5w+F7HqZ+heONCKVieg=;
 b=eraO14Mbm4RFsoYcrgka95/vdRidZPMKbamYwGsFQKKaYLVyqCE2JnFyQXwoJCFIle
 IKLJDsG8o9TBgMxt/GGQZ5qxBc8QdVE1B4EvPynUNf8XrIgmwsdRDh4uGR+5FIgqikkX
 Vp7V3gInj4rpyyRGmiYVcQ7YR2TqaMOsBJAixoCCSxe3XTrVsv5TiLAmNfh+90a9kc9C
 lkJjpbfzCzEnDv0wj77BgEzxA/01h0/S4gZWecP/LX4MvWTOnBZp9oIgJ/ph9ynIxvVH
 bmMXKkbUirv9A9D/M6Ul5MNtxfrdurpCQy3Z+k9PmjiKWhpcX33Y0I1BuSzxiKx3KdYn
 uYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302356; x=1787907156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XTkw99wHhMDKxohNnkz5GeHj5w+F7HqZ+heONCKVieg=;
 b=h7XS8ZmvSJ/pRaSzLBaAnRzt83w9gS0OpLC1JLM60l6HvurDtlb1vZPK+2pV70uJR1
 wkHVRGAHLam8oxe/t0XzNNQMguL/hxl9LDWYrHefFGLTZU+wlhHO9VHDlSSGGkrW3MtF
 rzQ7JEi/GfekiDCeJbj+ZpKjccVqaaBQT97mldJEIQa6Ln7lUvoqm63hE6J014Yo8E34
 N1nfooKbrHBofH9rHAlhTZKdgqplSvYinyu3YFskuwnkQ+ybBmtW5yPt1os0M3zeAQzo
 oxqtjfGgoJJwGu9SEZdp0rEUTrvruHzuYoPYehKWLp0owedge/6tj3o/7Co+59/LN1tT
 aqow==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQGsH6cDTtEFpj+j9Jgmw6AeWJ5ef7n93gJZhj8JygYKlbWyXObS4xTHzburpSMQ4gol43qqY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mS8XPvwJFtKAkZ6ii3QVgpVNjCEtqwRNdzRDl3p9toFnU4QIP3
 I6sXzGOfJ6XQHzUKVyGsxmbX3wtDPBqICVxhwqh1twy0CEOGbshFqjRCwBnFXC+R7nw=
X-Gm-Gg: AR+sD13o10JJiqLL1sO8WXOa6bZQU4hdcglprhsoKjOOTIndN+zieO4/dzHuE998So0
 lJEuh5K3FAPsqqbJMNDBEa7vG1TTZ8AJwyMf70tEuityfpFlem6lP1wVN1TE4p2z36T8cVHZpPz
 vu2dKWKWD1+WNEFYeXrPAjfCdWyn/kD+MVsb7t9PdKATXgpImHGcnuOYtFpA6FCqQAAoIwy+oMu
 nR8EYLryVSdOnyzU+dqM/LBhUb0AzDC+uH1jPyMSLGX5turq1NN1E46fb2syNUPEimsDNZwl7N9
 ThTn8OKqnIguqUtOMWrk0zutngS9EEpHLIYXKx8XM2u6RlNbXI5fq8+JR5j5Ff4iDPE4I5GrAd6
 y1OydMrAGDKwQNCw1Mb7W8v5wEbr8lAnokgtpZZs0Lyh/n26ei70ysMhyGARj3S5NqSJlJY7GXB
 Z/dvQTqzj5NGu2QJewojIGGHhwtlkg+xbPeR5H0E5KVE9XhIkRyXbd3hby3/ptjXrVUCqsVYAYY
 c7i5MaWERAcJV/E0Y43Ec8o
X-Received: by 2002:a05:6402:5d0:b0:6a1:de1:f739 with SMTP id
 4fb4d7f45d1cf-6a42f21945emr2673608a12.2.1787302355537; 
 Fri, 21 Aug 2026 01:52:35 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3feec9f4asm5587801a12.3.2026.08.21.01.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:52:34 -0700 (PDT)
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
Subject: [PATCH v6 74/87] usb: gadget: ci_udc: move to the udc-core
 registration
Date: Fri, 21 Aug 2026 10:47:50 +0200
Message-ID: <20260821084829.2070426-75-anders.roxell@linaro.org>
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

