Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594E9606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TtNDgSGZ;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Wrup8d4Z
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D04C8166C;
	Sat,  7 Nov 2026 12:50:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7IP37ZReRp00; Sat,  7 Nov 2026 12:50:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 69B4A8159B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055823;
	b=qAYNBHcbVx9BBDdDMrV+/SHa2BHwOHyAEqxTAI3ajPv+Ji/mkEUU/JvdZvkUChPVvPgK
	 xBj6XWhdR8VWbXuYR1XEasn0KwjvPHM2ZqTDaYewxSN7C1X4f3yRmbFhYGRbD+AMto/18
	 /XTDP0k4Tlc8/fReWbvAhnNEQ3tBg6vhdBtmf5L0W+w6ZZSNB8RPFWy6hagyzGoWHfCd0
	 TZMGNz+hZYZnM76b5QVhvP1gSeNNEDW+WKNFLjVb0zF3RupblFoqLA+UPHgFv+/Pncor3
	 6uud8DFNsa9Dx3axgFZrDGF2n5sGCy+EKLuCcZhenwxk7wwEE4apG6L/uSr5U/UwOQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055823;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EgExA5Udf5ajub+fJFDXn+pBrXNscb/om/qO1qpWaUs=;
	b=hGdsV8KPCcxFXfKUXtfToMNc8euWjxm9CvGQzqkTSyWKqEnnE6fagt5Odis0a0oef4Ml
	 j38GtHxtH/v8veN/9NAOmLvtkHiBX2hM2V//5SxKxXVRXo07RvEMJC9Kds0e/a3cZMjaf
	 zYQhoc73AbeJX/S3z9rbutV5SCknrb/uHKXU9cNoXANPYG4kpiNf3T9sMXsqFkx7gEsbz
	 pky0TKrRfVMuh7AOOtmUMPl6hoPaWhfV6J6nCriJRnDSIIDlQvdGkqunp8w4u5CEuuKFS
	 dZBxP22Gj5G0VPbKbE4EVkqGIjiV38Jh/hKbnkCF/+/loqJdQMZVbYXpgqRqMMISiEA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Wrup8d4Z;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055823;
	bh=EgExA5Udf5ajub+fJFDXn+pBrXNscb/om/qO1qpWaUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TtNDgSGZOQVQDHeepbqjJ8gWLnwwMcRiWIOD6ygZKU2d7AOpcKot8XLlKtHJvxai6
	 9bNxvUwSVI//uwinB7VkFyeUIoGY00Lv/vHumSvWQtuLqucMYFtf2jGUn+UoXnGJ5p
	 VNElGOeBwvv4cSaYdwH5fWUVfoODpeY9WUpmqg/4rXUhLVuPjmjrhuXnUionLHho2P
	 d9YYQPKoc6V4waX8bqkOjhWrE3/XvXeKCyJ3HlTqKbE6LKdm34pUYMdg+DnlgFr0Ms
	 uWzRkO01Ijc2i/Zsf2qZCe3FLlvhqr3x9iN6WiaaB3SUV84QNdw8SeYBnv4YBUrfuV
	 /XD6eVsekvTeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69B4A8159B;
	Sat,  7 Nov 2026 12:50:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E92F34D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:23:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 509C381218
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:23:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RTFDeaa2NI9F for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 07:23:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4B234811B9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=Wrup8d4Z
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4B234811B9
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:23:27 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6b5785aea56so228318a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 23:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794036205; x=1794641005;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EgExA5Udf5ajub+fJFDXn+pBrXNscb/om/qO1qpWaUs=;
 b=Wrup8d4ZQkEwvBCKcwt/KyoY2YwO3/HkqgbqNmB6TvnGYD7ZeQ2Cu8RQ8/VDFpdRjK
 FrWqpEIqqe446Q1byDzk1foXuANVlM1FrjIKocpfkkVydfLVKysnFtOooeYY/6R1ujCa
 Y7V5ZkoKKtUMCxU8VwwPpQ7l6TrTkjOWb9GuCfhMO4bhykzMbBSkyZW+bUAEKmoMUsSv
 TYzMzvJjAL/OrJqG30P6nJuaadVaCHnsDeX/C1fpOGG/ZI1CzW46y/HkACwXlDEpPYCN
 8Nc8P1YGQPw+aOaSMcWMaI9rb2iWW1U042ceF8kZinUsZNjAqBHeU8oH4O3bj4g7kL/T
 hv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794036205; x=1794641005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EgExA5Udf5ajub+fJFDXn+pBrXNscb/om/qO1qpWaUs=;
 b=0QaZu/AAijDd5vQurt63i9iRDrUq/hbhJYGOK3GsW1fplXgv+dI7SxCUANLhZCobxX
 KL3zWDz/+kuHxSaSuhDV6Dl5qWpO8JSSEO9sU0VWrilKWvhuuYe/8kE5CIDfEPYIwpWb
 t0lPgBNbkYTI1VBpbXWVooEXJG5byg69CGg3O8A7kQ22emc6wK+MKwA6ZN0nZAeiow19
 gE+9HfhbSmEDFjjoVxcDKLTNpFViyic+yBfFOjHCC+ycYVTYFlYEi1sj9QYWg4mNAH7e
 a+JfA+XyEtTIzZ3C/OAY7QVwATD+ibU9DxevYoDAQscdBguYZiyBHjMdbfPb7bfmpZ+d
 zcPw==
X-Gm-Message-State: APuU4Z98NMHLDiOpKuLrG0meqwVQszUj4rG7g8x0XrWs7tr8qqI9M8Wb
 LTKFlh3ENL9pxECkfbp9vIQHxavd4nCiDf0/y9KnSiC3RPo31PLG90XKJUtX954DKdtc85ojeno
 5LKcz
X-Gm-Gg: AYBFou3Vo1q+S0RYT9qTkicIVziVhXlqG0r0BtiwjTV8booFg6p/onhBBMhKciLF5pf
 vJnBsVkbq3KBEX71qeZgcv2fNc1RpnzDFs9KQKzsQTkFRc5fh3etH2Rn9ZuHcqt6KlPCFWdtQPL
 xdGDsuDTJgnWOqVAvuP/kAHQ2+JhNez/1VIHdprPH3JPijvmZiONSQ/nrSRboFyXK+Q+m8ra6NS
 mPMibWcOOAagy83DISHuao8SzaNry8e+dcqlLtOq/jy625kB8dEy9btUyFItbYF6HylusnIGGPY
 gyYojrfWVLXWqmK2h2BImurkLsN0wP6k/v8C9b/iM28RQwAeenVtHGDyGFpXZxeeE1mV2QNLzPw
 Jr+3chlSdZVZYyMouBNujA39u1S92POJnKlXCMYWKoJItXZcAzPtafGwkF6257xV+sdcrEwGDRK
 2y4kbOPcUM6fe3M6Hmb8Lm4tALhT6F3BK0CvDVND3NboXccUxoNa7Zu8XlRxnTq0fk7fwvy/RkP
 bhAgv6ig1/8y4BGyAYZKpvXkcDlIhKywiYNj2LnzQkXvCDMDOCIbuuOpD3WsbVH4UoX8BnZyvRw
 kbPhvUk9S+EsVKVNT50bfSQf/3o10MjsGwQjKew1IFfCLqQRvbtrpW4jvYbATd84JXRX6k58+AI
 4yAXM/Bn8Sw==
X-Received: by 2002:a17:906:a255:b0:c4d:1768:48eb with SMTP id
 a640c23a62f3a-c4d34c5a0bfmr424112866b.2.1794036205015; 
 Fri, 06 Nov 2026 23:23:25 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b664afe545sm1490649a12.23.2026.11.06.23.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 23:23:24 -0800 (PST)
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
Subject: [PATCH v11 17/30] usb: gadget: ci_udc: move to the udc-core
 registration
Date: Sat,  7 Nov 2026 08:22:11 +0100
Message-ID: <20261107072224.3492260-18-anders.roxell@linaro.org>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

udc_stop() now frees the queue heads and gives the controller back, like
the old unregister did. So the next gadget command takes the controller
over again in usb_gadget_udc_bringup(), and the gadget is only added to
udc-core the first time. Before, ums after usb reset used freed data.

Tested on an i.MX93 board with ums, the host enumerates the SD card as a
USB disk.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/gadget/ci_udc.c | 63 +++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
index 53796887dac9..9291cf9e61ef 100644
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
@@ -1139,44 +1145,15 @@ static int ci_udc_probe(void)
 	return 0;
 }
 
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
+static int ci_udc_start(struct usb_gadget *g, struct usb_gadget_driver *driver)
 {
-	int ret;
-
-	if (!driver)
-		return -EINVAL;
-	if (!driver->bind || !driver->setup || !driver->disconnect)
-		return -EINVAL;
-
-#if CONFIG_IS_ENABLED(DM_USB)
-	ret = usb_setup_ehci_gadget(&controller.ctrl);
-#else
-	ret = usb_lowlevel_init(0, USB_INIT_DEVICE, (void **)&controller.ctrl);
-#endif
-	if (ret)
-		return ret;
-
-	ret = ci_udc_probe();
-	if (ret) {
-		DBG("udc probe failed, returned %d\n", ret);
-		return ret;
-	}
-
-	ret = driver->bind(&controller.gadget);
-	if (ret) {
-		DBG("driver->bind() returned %d\n", ret);
-		return ret;
-	}
 	controller.driver = driver;
 
 	return 0;
 }
 
-int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
+static int ci_udc_stop(struct usb_gadget *g)
 {
-	udc_disconnect();
-
-	driver->unbind(&controller.gadget);
 	controller.driver = NULL;
 
 	ci_ep_free_request(&controller.ep[0].ep, &controller.ep0_req->req);
@@ -1193,6 +1170,30 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 	return 0;
 }
 
+int usb_gadget_udc_bringup(void)
+{
+	int ret;
+
+#if CONFIG_IS_ENABLED(DM_USB)
+	ret = usb_setup_ehci_gadget(&controller.ctrl);
+#else
+	ret = usb_lowlevel_init(0, USB_INIT_DEVICE, (void **)&controller.ctrl);
+#endif
+	if (ret)
+		return ret;
+
+	ret = ci_udc_probe();
+	if (ret) {
+		DBG("udc probe failed, returned %d\n", ret);
+		return ret;
+	}
+
+	if (controller.gadget.udc)
+		return 0;
+
+	return usb_add_gadget_udc(NULL, &controller.gadget);
+}
+
 bool dfu_usb_get_reset(void)
 {
 	struct ci_udc *udc = (struct ci_udc *)controller.ctrl->hcor;
-- 
2.53.0

