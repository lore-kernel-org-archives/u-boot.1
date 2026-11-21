Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0F6606A332
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FGs3uurb;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XGb0KVSR
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 40A8A607A1;
	Sat, 21 Nov 2026 13:15:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xbreWa39eVt9; Sat, 21 Nov 2026 13:15:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 157F2607C1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795266887;
	b=HfycMwsRWLZ5g8Qfgg/luD+6EuNPgG/IFbGwyUagHKBLefuF5FwBWB2BZ2bD7KvfFkC+
	 Cd4AuxDLjF5q+TYCTSUjuoKfv1G/1gsBVRtdKIGz3mc6+r+lbQLrfMa0VO4sXxIObxBdB
	 aPmFQhn57qewh+eqCdQkbaiKwkViPyfi0OIXzGAZ8kokuCu9kBXMJZwVHtpMrBzuEAWiU
	 gKsC12BtDo2vP+hK494vir6hHyZYiKeblU54cQv4XpR5g0Ed2IBGxh2Uf3OORGfnLFQ1Y
	 evQEy3AOsmxW9hrFeL4KwQaxykT25SOxgBH8jOL1YfadDLwht1v+SRyJTgV0hVwkFtg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795266887;
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
	b=a7FaogD1XENi4Xk92j9Dhe2rdObztxlnFJkNrzxj+kGww74O6poOkbQASY56ZcmiMccG
	 HjaO/21mfjnYmhQgcvIPvQQTr+0xHIUDMQpNw9L4fcVwshSrJvmAWUBn4zpiYq1+cxKZD
	 Xv/a/2ccOGFfDoK/ZTSDU/LZiY422mlolNtwMWstkWZqKOSbDtPcGRA/Dt9xV6IQH4pA/
	 OxHhXq5bmKofVKENQEr4Sv7xgS/2y3XiWFgWbOAAHSd2a0MUHU5/33tiVNkZlI1FfKKOg
	 q6gT+kuDX4gIA16+kfS9u5lhyoDe+hF8JSpUes07DUmTgEjmUloOWt1PpErYw5p/bZg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795266887;
	bh=EgExA5Udf5ajub+fJFDXn+pBrXNscb/om/qO1qpWaUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FGs3uurbJlcd1RU05lZew73hS+X4iR61nQzk1GYIO+dXox5NoZ+/pEj6s5hovw2UP
	 8O7tybYOUtJc7QZ99JL+qy/QVoUdTNETHPzZkLbQf2GC4xlX7i6ebLdCD5lrjAejpb
	 4/CTJKdsguVbmgFBViK8zN7/Ht7rd/BNFZ7J1NJ6GhmOjUJH9dy0j39OpvwAPVIW9N
	 CPUVmEXCTDDV0W9qNS6x2t3RQXMTVdhNdOujUTMmbxnrtFM769RuRPGnapSj2xVSMZ
	 MBkJ/aaN1ExqnCwx4R8/eqWSszsiQlgbLMObBu8g/bpzvEV1lASQO0Qf5nbpuFfabs
	 /t7o/HCJZpIHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 157F2607C1;
	Sat, 21 Nov 2026 13:14:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1BAE315D
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:54:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 027E681403
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:54:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A3SZ-5IhQeJi for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 11:54:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 02CF0813F8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=XGb0KVSR
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 02CF0813F8
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:54:52 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c504d4cc6b7so17020266b.2
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 03:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795262091; x=1795866891;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EgExA5Udf5ajub+fJFDXn+pBrXNscb/om/qO1qpWaUs=;
 b=XGb0KVSRkYfXX8yZdj+cftQ+nULcD0hUtBWql5oKD1rcNAYZJsAqTeX5rfPgNOBhIU
 TeXBI7iIkQe3e/GL8XkNu1CHeRXq8jtwqFz+hbhoJMm1eDJLRx+p56u6Gh6FyKzEECJo
 +dFfCIaQgnlizcpBFJfaMQHfCP/vamqIFEKih+pJFBWeE/jfIR6dWKT1Z9ngQqXtETs/
 2e45fLdDSjsjRdlSuCjAjOeYGIhbCNl64C/JOHSBqf2hw9yUH97XSwo+71qlmRob3Lku
 e9NNE9hBqG4CjCC/xLNFjHvooymNd4hgfNvpwzYqsOlf03RHxO/EDmyW7RIaURJEXoo9
 FsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795262091; x=1795866891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EgExA5Udf5ajub+fJFDXn+pBrXNscb/om/qO1qpWaUs=;
 b=GHcVCzje3ZrUvo38BAFTf7prTFMdrOhqnHnwBkE8BN3rV8h/2j8gYHMsSM2sfJ9CuN
 LX5Nu6UdJ4AGl+VKOEgiW+n0skNVBqd3rpVtjSVyIKgOEDY7BdZ7JZ5IdI9rdgWEqzrU
 NO8IGxpZg2vYzLeyeGLbfab1z5wje8e/6wjdZaLChG+wYCeWD8ZatQCzVlbUAClY/RSl
 p6sowGbs4t7rTxfr65KxGSbrZRw3SkwmXdWkqnZlRULslhMGL4E6R+WS3q6LOLC+fidl
 DG+vTnF7mvv4dKTBVLTaq3iEfvSpzADO6a5jGaqAqukAtMToeuasBHYRlZdaRmk5v1l/
 ZOLA==
X-Gm-Message-State: APuU4Z9S7oLipjttdxH9jqUsqSbtboJ0R/4zK33YI4qz5Ea0YeiMcegr
 rCwFr5y8gRbQiVL/6UBkozRPBfKsBirYEKMr6YRwJsYIjICtBToBswhzjB3p7s0e2UZm1COfHGL
 stIrs
X-Gm-Gg: AZFdTZecT7R7qUwEbz7V7N/XvoUjtJSjYwGm0n93WQUD9OCPn/Cl0lEOwIwcqPODtaS
 dB2IAEW02BLAYcnhF+zWhDyLWwh1Le3awWnQHhLzVRCYmX9nMfQVmZNzgZUHSzNKBcVzRm5WZwW
 Tt1Sck6OlxUh87aJoATytUM2ILSVkQ48bC/JJakaiHonH89ANqgdjqATizxrYRvdhLko4OuB6Xb
 lO9y8kG3xAhp8rDBnr8UtA58Q2DEAJ0W4mWity2a84nuVy5It+xUnMcptaG3217VjYc3M3Y7THU
 uo7FSapCQl3CSbwOGU95s+3KVhsdn9rjzMKB+y1nl0Mccm30laXRaTYSeTeOwOAy60EAO2iz2lG
 U7JNhH7cDuz4qDGTs8hFBO6W5bFdEEFLEShYfpDgtZiGCq4QVqIcAdqGDbzf8MpAKqZvxKM/oEF
 2c174GYoa11sr09Cb3EztWFRlPBRC/9eV883swdwaBr3qNfa87o9RYebwOWPcAgR4jgdfFLygtn
 2HnCNi85rnNsotdp68iZyrLfqNY4rzgmLOpkHDZujqEKfX63lELWxjX1vH7qj2O1CVTANWZsSwy
 2ZzF2/tpc8K6WKiLhE2Tb1v/rbTqfoNfa5wUV0dir770Lyey5T8sAQ+ycNAXnhOinLeKXI9gCS0
 497nvY0WMy2975jkhBE5ZNLO67MPiDUQ=
X-Received: by 2002:a17:907:e83:b0:c50:a6c8:2606 with SMTP id
 a640c23a62f3a-c513a1cf79fmr539809066b.0.1795262090551; 
 Sat, 21 Nov 2026 03:54:50 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513a8678cdsm186595766b.0.2026.11.21.03.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 03:54:50 -0800 (PST)
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
Subject: [PATCH v12 18/31] usb: gadget: ci_udc: move to the udc-core
 registration
Date: Sat, 21 Nov 2026 12:53:22 +0100
Message-ID: <20261121115335.548142-19-anders.roxell@linaro.org>
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

