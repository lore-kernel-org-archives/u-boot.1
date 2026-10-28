Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370F8606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Fvhb1RCF;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Gl9qzBVs
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F362E81098;
	Wed, 28 Oct 2026 14:50:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tq4EunUfSt7P; Wed, 28 Oct 2026 14:50:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 78B08812DF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198913;
	b=Jhe8Xrnk3mI9tj+npZGfS2SxIW+nnT+vPKu08vuWBy6ce8Skd5t3O5fsozP/lswXonk8
	 3vELpCnsnBueJMqeAJIrMS4DZtvPFta9jByYYEY6qBS7iJmezvd7IgI+QB/tIV/FWC8mc
	 +qAV9EIJ9qLUzytFnXAZXpKqluZ35UxzYj2b6FKXbLYk6FmmTu4qYP+f1Lg8Gszxfxf7Z
	 TSJBZdLOuUFWQvQenNwXf5Dciw7lA2r9+1B9Dhf2INQLDGGu4JSSsTLFG/XLWs1hKmkLs
	 Gb/klR0H1vHwaRhKshDxGT5sOD9jjZa2wdcaL4HQxScvguhSUPyzWQssXajCGw4PoTA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198913;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=K/e8H6l2vQmOk7e5ZJUyx6PHJ2H/nUBBf+ulxImSWTM=;
	b=HTZyCjGB20K5qD3y6+Lc5/M5CNomqgbK900SDstS/1gp1pgnbMqjGfepD+7b5vVgq4cz
	 MzsnwXHWQOP5VYi1F6AU1Mzae37qj0X2NyUY3bECMiNRytau6bG6t6GPlumrk6h8H+3fZ
	 PXkvEfXfHdCEarwSSMkAo0yPL36uWGnz5mDx5RqDqLevD00bPqpgs6ZDC72e5Ab8sUDZx
	 L1/DGAMTP48aETxwIzuVMHKUuLdj3PW0IeMlIuhWDfm7WEyxvahLXMoZ8sBm5eC2Ilsqo
	 yj2cxkYOKSCbdem3wiKFUHTV8ahUAY2ybA4I9CDgc0hT64G2l3ttH3k/OeIrmsjjgBg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198913;
	bh=K/e8H6l2vQmOk7e5ZJUyx6PHJ2H/nUBBf+ulxImSWTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fvhb1RCFBTcPyVlWz5VAqBIpTN9k5txks4qt5mrB0cTsI0MDMDCW0ZwT9ANJYia6x
	 DQmdjiX8iGf8c3CYnKtIQ32Hl6nafKfg6L9h3FrPL/z/L27g+ixu7w6YmloaAoWiuA
	 EWu84Z75MOneF4JHE/0rOOoHFGOkgH+tQHczaHgAN8V61zPsYeq2aXC6WJ3P5DjfWl
	 WFO6BMxpili0VvORzZkx1ZCWw5fa+bGUAExq7f2g0lBk34vGFx2gtXasEPNQEVMwsk
	 T9xq+FnqoEO6iJ21fvaWvVF7EG2uFSM8ohxhjWAU+k+pDe+FGb6BRMNuLEoWTMwMSd
	 rvzi08xyJQnGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 78B08812DF;
	Wed, 28 Oct 2026 14:48:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B2380972
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AFCF640557
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dUdxf_BiO-nM for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:17:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9819940550
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793197062;
 b=b3v3/KMyqnu6NBwCm4E29n2c8eXa7pn97U5t+/bx8qS1guTDuvN7FKWSHv7qTjMIDQDJ
 lpTPGpcY/eePKNeQYZ/gqAapkCu/25Zyk90R/OfFTewqJyoUgQ/h+5sNu58jtDCEY9wyS
 psB9hPkw/iKX5pRP9tS3RjFVhtpGEmQ4KePLeveq8evHqf16o2QMW3Ob4Mens1gMjZQVx
 eppA6aVQ5YD+E9+1lnDZck4YxsHLMVP21N2PV3Mdx6g+FDEnXBpMKOccLIlKPPGhztZV8
 pNWppEmzJEKx8s+jha9Ya7V/XtQwSZ2tUsEgX1iK2lrkl1F6tg6wlxEBVrgNg1H1/+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793197062;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=K/e8H6l2vQmOk7e5ZJUyx6PHJ2H/nUBBf+ulxImSWTM=;
 b=R/K1QWckWyGv12QpyFxe1vN2MqCCIKB2gthigjUjpVdeRgPu+MiOqv3KwKE647hKsgs+
 dRz+bRRDtX3M8VIilk5pswNuLl2ut5AndbCrqw44m1bxmwRvByu2zUJ3I4xBUaLCdEyAv
 FU5ITt4E864MS1wKkIi5uMlblLUfqG+QlM8q3tjJW6KgKoWTrympnbuaft5u0OHrXscZk
 cTN/ns2k6hpeCgy/YeVXsew0yEJRSIo+0gSkiJruuWJYIPR1xWE5kLeAHldTrMDSgXOCD
 lIDJIHIEY1tv9NUyIhuB/gygbiMzz544XJ+VBgzfGgAihz/6M0ib4rOKgeQ/y+m1lSQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Gl9qzBVs; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Gl9qzBVs
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9819940550
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:41 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c499e0e43a9so13456666b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793197059; x=1793801859;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K/e8H6l2vQmOk7e5ZJUyx6PHJ2H/nUBBf+ulxImSWTM=;
 b=Gl9qzBVssuL5eYPsnQThffCW+yvmNGc4M0xCR9UwfSHWiSK5pQOxnB+HYWtxb8GyjE
 tidDCnZgcBY5XKWXmngMr3Mf9PqnyM9YOQJBwe2LHqHq1s5uhnRZ58hYxYsLrykxwxLP
 4x78T/g1g+I1D+GayjZHzRdSh2zUfAsTDvwyQB6w0L7DmzZLH2qQeRbSslWjtZ9UFYN6
 7fspGBs62f6+RWvO25x6n6Ax+SWgNtutUumJrsPjl8uMmkFwuSR1lVshL0BT2Ol9Y7JR
 B8VnFQ3RfsvLo9YGVoUPet25Jph6NMg47Rrwrh2GaSneB8lOQey5soSGUOzl97VJ8QQp
 2qbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793197059; x=1793801859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K/e8H6l2vQmOk7e5ZJUyx6PHJ2H/nUBBf+ulxImSWTM=;
 b=vK4mtLLR4BCvUqi5LLngw1eL8kdEzJYIr7BTncmzqpVsX6mUtOL89L9QSd0IwXO2jg
 5krQQQ0tIFXTED55/xlIqhfE1MlZAlAqwlmHarDWIVobKMFuOHxV6iQD+Cjc5MamopVs
 iykQYrBPWez0oSEM+tsKPGtqP+nUJSuXOycpW1Czrv13a/b85e5p6Y95YrdtsJ6J74Kg
 AuLZNNmN9r/mrF79CAk++QeUncPZISqn8YZlXxJfWE93b+WrxjJTa2Kbo3/i27jJF06C
 gdlkb3BJQczhK33BnA/tx2vjL2wExE9t7KPdVxVLCnEySZW5PxreX9xQnJYv+Gl2IGRI
 vYVA==
X-Gm-Message-State: AFq9FYLVBDolJIhVkmoy+fVnSISPYFf9GlVxmnojpDpQfKxDhD6CtO45
 PJ5iSFDCSWtTVQwHLf3LogEyh8UhbnaRjolgaO4GKUBziKWRXP4KjIgFBBRXvdNt7QFKjUApBRw
 dVq5S
X-Gm-Gg: AYBFou3qu/hAOVQznv8YBluM8GonMT96zdUNA3V3vc5HJTqNng4bhnVBQKV/41sT09S
 GGPQkEP1oUX4shAgmgY67Z7h0tzgbChPEeB+hTUKjLvJuuog9MnqwCn+CVDfZb+C954kD50ZG/z
 7g5a7uM0xuDt1a5oRgOCthofH+t7/lCu0TpFdzokPc/qQkPk224roAnMZbpUOwi5KD7l8uLSFs0
 2t5yG5PLHDLv4VssyD23Q/2pzl/eIYugI0RPJjaGNvgw+x/G+xzZc5bRv33jZ/ekaEbfsgyIKda
 q2zGo3ZEnv1NrDbmzqH8MGHQ4CuwVqBqCI5D8xOfXxk9GtGFcPGsIfMbgJqurNjKnnxdP07OdZS
 tDc4iSnu9kn2QK/ZktLFgrNnizLOo4tn6B/9KQI6SCdEYNLWFs5fnjCYQvepXwPAYCDo895QCG5
 EWntcascSV6qzvqlqDp8OMmUJhZS62qTh1w8/BXSwhugDOjXQ7jY8OXC1muk93pGlHJqV0YaRfh
 CizcXkfPss96YDn9I5c97fU6CgUkt4msG2T+Z0Ykbx2ebVr6pS19cC50OaK2Cw8Qgv/wII55ayv
 E//2IrLMgqix1TOpa2zoBaohPHISl1YIG2Jv2wHT/KbPLZ1OY1J3beeQMBcY2D3SKgaNa/8ezdD
 OfPqGzHzFug==
X-Received: by 2002:a17:906:d932:b0:c43:f1ab:167c with SMTP id
 a640c23a62f3a-c49bdd9ab19mr230685366b.1.1793197059313; 
 Wed, 28 Oct 2026 07:17:39 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd0f6f1asm618675366b.0.2026.10.28.07.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:17:39 -0700 (PDT)
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
Subject: [PATCH v10 20/30] usb: gadget: fix up the last UDC drivers after the
 resync
Date: Wed, 28 Oct 2026 15:15:44 +0100
Message-ID: <20261028141554.3073545-21-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028141554.3073545-1-anders.roxell@linaro.org>
References: <20261028141554.3073545-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:47 +0000
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

Adapt at91_udc and atmel_usba_udc to the new gadget API. udc-core has its
own usb_gadget_register_driver() now, so drop the local ones.

That leaves vbus_is_present(), usba_udc_enable() and usba_udc_disable()
used only from usba_udc_start() and usba_udc_stop(), which are
DM_USB_GADGET only. Move them under the same guard.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/gadget/at91_udc.c       |  46 -------------
 drivers/usb/gadget/atmel_usba_udc.c | 102 ++++++++--------------------
 drivers/usb/gadget/epautoconf.c     |   2 -
 3 files changed, 28 insertions(+), 122 deletions(-)

diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index b3c780a4e35c..5b0c55d59c8d 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -1435,52 +1435,6 @@ int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 	return at91_udc_irq(udc);
 }
 
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
-{
-	struct at91_udc *udc = controller;
-	int ret;
-
-	if (!driver || !driver->bind || !driver->setup) {
-		printf("bad paramter\n");
-		return -EINVAL;
-	}
-
-	if (udc->driver) {
-		printf("UDC already has a gadget driver\n");
-		return -EBUSY;
-	}
-
-	at91_start(&udc->gadget, driver);
-
-	udc->driver = driver;
-
-	ret = driver->bind(&udc->gadget);
-	if (ret) {
-		pr_err("driver->bind() returned %d\n", ret);
-		udc->driver = NULL;
-	}
-
-	return ret;
-}
-
-int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
-{
-	struct at91_udc *udc = controller;
-
-	if (!driver || !driver->unbind || !driver->disconnect) {
-		pr_err("bad paramter\n");
-		return -EINVAL;
-	}
-
-	driver->disconnect(&udc->gadget);
-	driver->unbind(&udc->gadget);
-	udc->driver = NULL;
-
-	at91_stop(&udc->gadget);
-
-	return 0;
-}
-
 int at91_udc_probe(struct at91_udc_data *pdata)
 {
 	struct at91_udc	*udc;
diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index 0caf8b8b7b45..52900ad654cf 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -32,12 +32,6 @@ static int usba_udc_stop(struct usb_gadget *gadget);
 
 #include "atmel_usba_udc.h"
 
-static int vbus_is_present(struct usba_udc *udc)
-{
-	/* No Vbus detection: Assume always present */
-	return 1;
-}
-
 static void next_fifo_transaction(struct usba_ep *ep, struct usba_request *req)
 {
 	unsigned int transaction_len;
@@ -1169,32 +1163,6 @@ static int usba_udc_irq(struct usba_udc *udc)
 	return 0;
 }
 
-static int usba_udc_enable(struct usba_udc *udc)
-{
-	udc->devstatus = 1 << USB_DEVICE_SELF_POWERED;
-
-	udc->vbus_prev = 0;
-
-	/* If Vbus is present, enable the controller and wait for reset */
-	if (vbus_is_present(udc) && udc->vbus_prev == 0) {
-		usba_writel(udc, CTRL, USBA_ENABLE_MASK);
-		usba_writel(udc, INT_ENB, USBA_END_OF_RESET);
-	}
-
-	return 0;
-}
-
-static int usba_udc_disable(struct usba_udc *udc)
-{
-	udc->gadget.speed = USB_SPEED_UNKNOWN;
-	reset_all_endpoints(udc);
-
-	/* This will also disable the DP pullup */
-	usba_writel(udc, CTRL, USBA_DISABLE_MASK);
-
-	return 0;
-}
-
 static struct usba_ep *usba_udc_pdata(struct usba_platform_data *pdata,
 				      struct usba_udc *udc)
 {
@@ -1255,69 +1223,55 @@ int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 	return usba_udc_irq(udc);
 }
 
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
+int usba_udc_probe(struct usba_platform_data *pdata)
 {
-	struct usba_udc *udc = &controller;
-	int ret;
-
-	if (!driver || !driver->bind || !driver->setup) {
-		log_err("bad parameter\n");
-		return -EINVAL;
-	}
+	struct usba_udc *udc;
 
-	if (udc->driver) {
-		log_err("UDC already has a gadget driver\n");
-		return -EBUSY;
-	}
+	udc = &controller;
 
-	usba_udc_enable(udc);
+	udc->usba_ep = usba_udc_pdata(pdata, udc);
 
-	udc->driver = driver;
+	return 0;
+}
 
-	ret = driver->bind(&udc->gadget);
-	if (ret) {
-		log_err("driver->bind() returned %d\n", ret);
-		udc->driver = NULL;
-	}
+#else /* !CONFIG_IS_ENABLED(DM_USB_GADGET) */
+struct usba_priv_data {
+	struct clk_bulk		clks;
+	struct usba_udc		udc;
+};
 
-	return ret;
+static int vbus_is_present(struct usba_udc *udc)
+{
+	/* No Vbus detection: Assume always present */
+	return 1;
 }
 
-int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
+static int usba_udc_enable(struct usba_udc *udc)
 {
-	struct usba_udc *udc = &controller;
-
-	if (!driver || !driver->unbind || !driver->disconnect) {
-		log_err("bad parameter\n");
-		return -EINVAL;
-	}
+	udc->devstatus = 1 << USB_DEVICE_SELF_POWERED;
 
-	driver->disconnect(&udc->gadget);
-	driver->unbind(&udc->gadget);
-	udc->driver = NULL;
+	udc->vbus_prev = 0;
 
-	usba_udc_disable(udc);
+	/* If Vbus is present, enable the controller and wait for reset */
+	if (vbus_is_present(udc) && udc->vbus_prev == 0) {
+		usba_writel(udc, CTRL, USBA_ENABLE_MASK);
+		usba_writel(udc, INT_ENB, USBA_END_OF_RESET);
+	}
 
 	return 0;
 }
 
-int usba_udc_probe(struct usba_platform_data *pdata)
+static int usba_udc_disable(struct usba_udc *udc)
 {
-	struct usba_udc *udc;
-
-	udc = &controller;
+	udc->gadget.speed = USB_SPEED_UNKNOWN;
+	reset_all_endpoints(udc);
 
-	udc->usba_ep = usba_udc_pdata(pdata, udc);
+	/* This will also disable the DP pullup */
+	usba_writel(udc, CTRL, USBA_DISABLE_MASK);
 
 	return 0;
 }
 
-#else /* !CONFIG_IS_ENABLED(DM_USB_GADGET) */
-struct usba_priv_data {
-	struct clk_bulk		clks;
-	struct usba_udc		udc;
-};
-
 static int usba_udc_start(struct usb_gadget *gadget,
 			  struct usb_gadget_driver *driver)
 {
diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index 4fbea9137240..5128d147c168 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -7,9 +7,7 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/types.h>
-#include <linux/device.h>
 
 #include <linux/ctype.h>
 #include <linux/string.h>
-- 
2.53.0

