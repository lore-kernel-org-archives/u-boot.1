Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C803C79FB6
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 12:46:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CA14607C4;
	Wed,  9 Sep 2026 12:46:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WSwF-F8aWkgr; Wed,  9 Sep 2026 12:46:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 43431607B6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788957976;
	b=ZMjgQNnMpjLHMxlQHUTyOugOumfL5eneqSdbvQL94OE53UAa68F+pd8hVx2wNNMR6vzj
	 wUxCaPX1bcM4VaOOcelizh/RvGsecSjI+3dXjigmvQjVNvSa59PboUjYDPCFK2gSCoZNL
	 81V4lhCzYyddALN2kLxKu7bj1F7sapWxl1k732AkjWI4tOYD/YocbzTp0m6ojvAXQwSpE
	 Dv/fBVf9N26rGKKx+meFOhNBHBuahvVhws8twnQodIhU8gEimYhcx4UNqr0hrgrlanfmv
	 WgRK283x+wAKF2pYBoiSrCwSO9CKp1bBvFEpgQyJVdQuaucw2sUfk9FIwAEXtw94HRQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788957976;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XTkw99wHhMDKxohNnkz5GeHj5w+F7HqZ+heONCKVieg=;
	b=LQ91WFPvnwcsgEjzPrpZsnuPRKJfQWkm/3Jh3GYcjeeBpS/F3HK4mcpP5dDaqgfamdL+
	 Lzrv2PQxdZDp2OyYBku+3BMdHo2aGVdq5YhnFygnJXd+2rmOvQwHkpGwUYWLzANGAR5JI
	 0m38dtGqMZuDpMDu0eSl0ZxtU6m8Y4C0Qfxjo6viH/TzassrKwINJFWSYFtZRY1M79VV7
	 yHJ6414H9ekId2vRP0wKEIdWqiggxoIurUrzcy04gYinguFftJdqd7RyRRxJ0+iH/GGyg
	 s5I7vF9xnbSeugHP0IEnmXnVhmoSRyHqdg2v5x8z8II1fkMObJy908OMPKyIDEed+bA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788957976;
	bh=XTkw99wHhMDKxohNnkz5GeHj5w+F7HqZ+heONCKVieg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tt6txdG9bXO6ZntVJJc2hOCj00OidqTqlWRD0HnFYwB1RLyCQmbaMvykXN5NdhD0C
	 ajj5xAUcGqvQTLP/qlR9R+OMehv1qZfMOyDIW3a9L8o0dToKFI0BkE05cm1rgPa1OL
	 XZWkTQ00ivH9RjU04NDjahIqOpYb8T0c3H/ry1DfyEfrdsa3ZGwaPVFl66XeDc0q3s
	 90im5eUDs/X2tcrPcJ6Xv//0ZQilHrxVGspEE5k2dvmYKLJKKfHZBaJMLsk11JiRrN
	 S8CTFzetrzFw2pMzNIAoArlIRoaJPNVQO+gglqYMWihMlvXg1tav/9GV+5v9yy03Rg
	 vYKbu9Fr0JOzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43431607B6;
	Wed,  9 Sep 2026 12:46:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B37AD3AF
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:52:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A5C6F406AF
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:52:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0qiY4YXOnf-m for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 08:52:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B2B5F406D0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788943945;
 b=FyG7YrxfvhHcKf7I0EoH+CwfzUW6Fr4gbjM4WuwCvkeUe1aEnOEy8kZb5o6Yhd0bzCEB
 Dmrggqdevf54/SNCUbO7EjncDN0vIGHqt5DaIOoAcegbbcLbiGj4TkO/xs+ih2Fn3t3ho
 nbo7axL5UcWzTCZAgdfasEAVRj0N8gkqBuHETddXXqlAUAG0ZOgUQxINDdkT1MaLQcUZH
 wvZk2Cyz/0tDxND2MBpqrmUMpKanQXG9jyIuEbcLq6sEp9YSLmSAIfgKHyMrdD3I6hjSY
 QsCZRPr4RnXbHeV56gzwX9yh/kQMzcTeAaqX4W5eq3MtKV1eUZIkHg05CvpmiRp7/Og==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788943945;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=XTkw99wHhMDKxohNnkz5GeHj5w+F7HqZ+heONCKVieg=;
 b=oj4uPS4v/hbdpsIIT5OcHfWtLStVqSdvel1rc3qjLQpicDF937KHccrR3DZa7T2m1SwS
 4u2dgNQvW02xpIwHIvX1Fxf4EhGWdWKRxqSOF49lXb6vRBHi7mjf82rz+dE54vAd+eyCA
 4g8SxRMQ/CPjGOCShaKjyJXTMzv7BzxV+OrPcD7pV0f5wJo1F8QtKHNF61OJ+683Ww7fG
 Fnosck5uJ1NJRyV7ewQ/t6+R72jCHPFYZAXWEQ/AAE088ktd2TEtjD60msGkPEieKgODb
 x8zl+0fm/6iXasWloDhF3VbLdSonXZjdzthCOYXECNUo+jX0K+wvYXzCATHVdLf5EEg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="eUMfJ8/d"; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=eUMfJ8/d
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B2B5F406D0
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:52:24 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c29385fb97cso4189166b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 01:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788943943; x=1789548743;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XTkw99wHhMDKxohNnkz5GeHj5w+F7HqZ+heONCKVieg=;
 b=eUMfJ8/dRUbYRHZ7q0s2+IYxtnDl7yQeDoEg60SwVNv+lpSHRp4U4yUGjE1TV/qH6X
 vGqPCrHrNAkYPhv/geLfIyQ1IaEPnw+41QqIEcK8cjOJV+GdQ9s4HYhj11oYjL0KiQcK
 MIsF39pKSLe1roI/Yabn9KWjSVREeKQAIXnS5JMmoL6sXqQW5yK2UbbtgUlkExxyVOcb
 zEtG1gbeCLoYFrRUPHoYNnqs4t2tiuntCYuNuAxKYzSVOQ1a/dAg4/BHCb5LOSUMzdDI
 VYyx5Hv9CXM/m1VFNw/R65V5l4SwftIPZhqVTGROGKfTUVd4FS3ouNnwa0x7TTRSUVDn
 y8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788943943; x=1789548743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XTkw99wHhMDKxohNnkz5GeHj5w+F7HqZ+heONCKVieg=;
 b=aUs0NVDgQm17HkSgNEUy3t/6aixa30dMwNTIK4fzA+3XGhFHNTqHtmbRzzQ0To1pUb
 V3R7FEqL+kGzuqhVlwWA8r5xGtTo7EHWFu5hBefvDORDb93yqu/cpNvk/un4XySsAUrL
 YSwfgAKCqySBHO7KQ/m+35l7Vn0cJepzmzGh0Gjpp7DA6b5DfBfLWdUZeJg//ta3gyYl
 PNo0izMBYS13FWlTrZ/sDKtpRHur6tE96+qjuOC3PDDjyhEZ1Pgh14MsZcmJaPEXgnYb
 nzYTqxePCCKEk5XnIcT5/aFTM3ueE+BFkgeEGUX10qIAZ3Q0TfG6EPsMFnH56SyVQgo2
 en2A==
X-Gm-Message-State: AFuF++mKy+apVN63z9pU9wE0p1zm7cnU0nRKeePbUXeloYqWIRRl8b6I
 93JQ+XCDyfUoBwKNXUu7Eo2XrKbLV5pvFusgMVJm3A+RB9YSvvoFoQojjKF4D4NBTty/+QGhGeK
 rzoUv
X-Gm-Gg: AYBFou3uiSviAlsUHJP93nR2muTlH6HYcC1V51Xtwzpp05o5oCsqlvjDE4vov3R26SU
 6FBnGpItkXeANRmUE3QmAVwbrVUEh1ZnbDXCdxOovyEL1o1sjirOGpNBVd3H/p49ReY95BjkBfO
 FGWRlno8Ul7lAIofhp4NDUsuduJ5/jdhgarxqMrf8eodNmBY/UYM7EJ8JBHy2wuUCinwXs9kXoR
 pScd+r+csLtn+1D1YZb8xG2g/HRikvoAn5aGyQ/9fTytS0psFBgM+4dSObDLQw1bFdGZO1amoMW
 L5CXNKgI1uIfdPV6HHHE3PzC7sTtCu3xMah5cHMv6/lCK6Cpq9HQniSOmXUbz7YiCKn8TfjPKZx
 aCs+RC12Q9KdLcB4HUijb8pp90EDkWHDaQTfwVrEWVHHfwjm9U6tv5O7GDbADRPF+VjJaFXIcqs
 S6JPze5RQlKCC3JrspZWkk+0XOJLfOsDP4TglQooWqe9jXAbgSqi6JZLueJ0vLi3vm5K3XaiKH/
 bOGMqWxxHQkDgkHTAAL4QJQ2nlI2Fjq
X-Received: by 2002:a17:906:c115:b0:c25:3ec4:9e43 with SMTP id
 a640c23a62f3a-c2624d2422emr996460166b.0.1788943942547; 
 Wed, 09 Sep 2026 01:52:22 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d5b371esm730398266b.54.2026.09.09.01.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 01:52:22 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v8 12/25] usb: gadget: ci_udc: move to the udc-core
 registration
Date: Wed,  9 Sep 2026 10:50:02 +0200
Message-ID: <20260909085015.2480097-13-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909085015.2480097-1-anders.roxell@linaro.org>
References: <20260909085015.2480097-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 12:45:47 +0000
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

