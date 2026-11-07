Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12B1606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TD4TZ9Mr;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ceZl++xz
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B7D30816D4;
	Sat,  7 Nov 2026 12:50:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wVWwGFCiGIOf; Sat,  7 Nov 2026 12:50:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 80530815CA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055834;
	b=A7XRINZ1Tf2LMzdTSmQ6TFhtlPmHnZU1fGHeOwWcHrFhEeorCaPHi/+5gDiWoQLs0onN
	 v+K0iucKaJ84vX6pCrBQ8HZK368nGHdOsKcXJBXpRYE70Lz9yEooE4HIlWKCWhV0QPXsh
	 bMpoebO8NDgylg0gOyrjAGslNqZVzYWamQhqWx4nshwZ2m7hv+2feJHw3PjbSQyikd6Qd
	 +mq09BM0puUnHIqQSREpuX956hk0aMOEIjkKSP8FVhBwBtUFgOp3OIhpAhOVbMvH3SO1D
	 jtDxZbcuZbPHi5VZeq6aQysqMcFrgOH0UZ9vlvRQQCjHNpCVYt64LyiIy4j9Wy54GPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055834;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oUHGwzOzXHZrGFZzsVsmXz23Z9nOkvNHU+4DOPj8tMc=;
	b=KwVpAqO9VoBvpnHNaV0KILvLHP8nV9yszPGBShsV+L3ZC4PY7F/xURxlSp5UW1JKzVD5
	 p208HJjh6TbPLYFmHH+509Te4XI+xANov2K4k0VDKEsscjHecwNp8kuYH667hJVQphdab
	 tA6pVN+/AtimnoQ3ay62xiLyvmXwEPLCIyMb8SX6RuYfG63lW/2ZzQNcsDgT3ZrrOgQax
	 1UOXdVub4a0JDQdFiqrUvusmlGhH+Vk746oxMOodrIy6hbZbVO2We3mreoO3lPWFjChPN
	 JSQc6tJOWj+EjAOd0OdSFf7lp8G+1clYloyVLxN6zCvPTti8L+WI7wG3o3OSxVwlAyw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055834;
	bh=oUHGwzOzXHZrGFZzsVsmXz23Z9nOkvNHU+4DOPj8tMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TD4TZ9MrHBOzqNPW70gFv7DpHCTf4t9wyd9EsGRToWUKBYmUqW9uv2JgB29uftu39
	 CIfp/6/wPn1fj5Esl2yx9NW0M8/LidhCglQef7N1KorFBEr7DRy3AaM88nGPpGbXZy
	 11OFDl85SYP9wA3RLErBqyH2yd81TxaN+Q0cs1Ys8XbEtJOtL7dfKwoC6FD7bJIz0k
	 08atTKQViPnD5M8advP/MBrq3f8Iq8sFEM+vriQPERKnE6skMLIXCkMO3nris49Sew
	 ZQadVh+Nx/8rNl9VO2PvEfpBbNspDbGYxvJa7IxNiOy4pqu1KvI4HilIU++8V1jw1c
	 ALYjrAXb8lD+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80530815CA;
	Sat,  7 Nov 2026 12:50:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C4DC331F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AB35640800
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V-BeYeGIfElL for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 07:24:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AE564407EE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=ceZl++xz
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AE564407EE
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:07 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c499b5be0f1so13483966b.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 23:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794036245; x=1794641045;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oUHGwzOzXHZrGFZzsVsmXz23Z9nOkvNHU+4DOPj8tMc=;
 b=ceZl++xzWiwF9eXCgFEssirRP93MYtUNBnhxKsoYF4NPfmm+6tXHRCRdSueCkY2N/Z
 o/E4+ulx2c+gsTcv3wzL7jy191VgpdY3XeUZJe8ii4CbR9lb5syrwF3BRIcX9TPNJqrN
 dIqw6Oh0hEN93TxL9GkSf+c/7+0PojDFMyXUc3AOD8+5soxtSQ5/q//eclWdPxSNbi4j
 5WHwTaLWy8YaQweBTQGDqaTdbEEvaBWS1Aa4cG+yNn6IEEs24adckbkSDiqrukD7JDb3
 PQRMQXcD5ttWuyCLnTrKWPBcHkGsrFOMqZs4hxksZiRTg4jNUxubssCaNtT/3v8QHQEX
 XGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794036245; x=1794641045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oUHGwzOzXHZrGFZzsVsmXz23Z9nOkvNHU+4DOPj8tMc=;
 b=NVvIyXqF9hb75azdyASg9RRyiuFBoHgyZvs/ycj3B90qOU4IHZ993o2YLtcwSOpzLu
 ScuH1QnQIQidQZIrXoqz80dXoBhkrni5jYW5bKLN6b5xoOj3nv5zOFrOWs5R7yIdfRXA
 vG2Z8q0OJXYeZAruwKR+WFm11eMqhcpg3g0etbsSCQB6RmwPvFtzJfxtOV2WHWCiOOU8
 M9QLHSW4L0rRnEhLp5H9XpMm/0sjk76EGs3IDjGvcfR+gM01iRQ2uKA3RDga1hkZmKrM
 EtkXw+6Rq8IrmRN4SPRAN3zCRyjcjlgaGtzjoF9eIT0ItJt9CMA8q+PGVdeM2OI4US4B
 HN1g==
X-Gm-Message-State: APuU4Z/jYFBkSDWt6IReC4AkTA3LKdt4pSBxJ1TU9CWVp4jbrmusAgwn
 +Phs3kDD/qaaUQwglHT7vAho5LmpDlYvNL7X13ucDNFqrTK/8amiLOgsHaHbsnsg2SDz9HYHa/k
 cGMNT
X-Gm-Gg: AYBFou3/rWV9dbZ1uJo8Fn95ske5Wk4POSf4id3f3IDhFWkRVpQNZKHzIS5PWZwh5qe
 TnnGLOoEDNUlOwkBFV/7mOrSPTJ4+wa3+37oPMnMfFZdvxZNm32sglB+bSgibNzCy1QNTz0WGDs
 jMonswd2NDSRlxqmQPEY1GeIjtoTfgjif0WZQ0tlYXoKdmlbfI08aS1ReShbncPRhFQFWouJYSD
 9V/4sxnwiML90hYY8E+qJzwfQA8uA/83vYwYnhxi0nM4iqMZCbM/VJi93JtUje+M6Ew/WplCMco
 O98SKR/ZQYl28GwB+l7NJk2z9KbCnIWKD0rR1TzVC6mdcSww4s7fbbwNaLFc+BlWjar5MCaAq7p
 8rzYCoINJzHb/MrQI5XK16UjA4ZBPE7jl5o3j4Y5VyQT9PE+uJQEUGCWm2xg5XG9zZF9DaTRAOx
 DqWOVL6SKHHka3eXD4Av1CtZ6YP35I4CgJDSkEz0BqXTSd8vVJxB/HXY/Uka2OLxoHVAG0ZMXYz
 UcT7iYk+Gf8jnYhrugzu2pj9sM3oufX8S8sZc0/QE9NhPiBgoo4uUPgvxY0fYXahGoDzdeU3+Aw
 J8eNtryb9uesKv5fldc8NgihPZaEYgLf3cosBk16SEvIasoSL1mY8/Tc5GTogAGTDS66XpKXijJ
 0TObipyGliGQrFTVjd8AytAs3cxRsrhU=
X-Received: by 2002:a17:906:a84a:b0:c4d:3543:336e with SMTP id
 a640c23a62f3a-c4d35435267mr372645366b.0.1794036245383; 
 Fri, 06 Nov 2026 23:24:05 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d3562ea8csm130129166b.22.2026.11.06.23.24.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 23:24:05 -0800 (PST)
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
Subject: [PATCH v11 22/30] usb: gadget: atmel_usba_udc: fix up after the resync
Date: Sat,  7 Nov 2026 08:22:16 +0100
Message-ID: <20261107072224.3492260-23-anders.roxell@linaro.org>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adapt atmel_usba_udc to the new gadget API. udc-core has its own
usb_gadget_register_driver() now, so drop the local one.

udc-core starts the UDC with usba_udc_start() and usba_udc_stop(), so
build them without DM_USB_GADGET too. The non-DM usba_udc_probe() adds
the gadget to udc-core, otherwise corvus, kstr-sama5d27 and vinco have
no UDC.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/gadget/atmel_usba_udc.c | 94 +++++++----------------------
 1 file changed, 23 insertions(+), 71 deletions(-)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index 0caf8b8b7b45..4df013bf215f 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -24,11 +24,11 @@
 
 #if CONFIG_IS_ENABLED(DM_USB_GADGET)
 #include <mach/atmel_usba_udc.h>
+#endif /* CONFIG_IS_ENABLED(DM_USB_GADGET) */
 
 static int usba_udc_start(struct usb_gadget *gadget,
 			  struct usb_gadget_driver *driver);
 static int usba_udc_stop(struct usb_gadget *gadget);
-#endif /* CONFIG_IS_ENABLED(DM_USB_GADGET) */
 
 #include "atmel_usba_udc.h"
 
@@ -536,10 +536,8 @@ static const struct usb_gadget_ops usba_udc_ops = {
 	.wakeup			= usba_udc_wakeup,
 	.set_selfpowered	= usba_udc_set_selfpowered,
 	.pullup			= usba_udc_pullup,
-#if CONFIG_IS_ENABLED(DM_USB_GADGET)
 	.udc_start		= usba_udc_start,
 	.udc_stop		= usba_udc_stop,
-#endif
 };
 
 static struct usb_endpoint_descriptor usba_ep0_desc = {
@@ -1235,6 +1233,27 @@ static struct usba_ep *usba_udc_pdata(struct usba_platform_data *pdata,
 	return eps;
 }
 
+static int usba_udc_start(struct usb_gadget *gadget,
+			  struct usb_gadget_driver *driver)
+{
+	struct usba_udc *udc = to_usba_udc(gadget);
+
+	usba_udc_enable(udc);
+
+	udc->driver = driver;
+	return 0;
+}
+
+static int usba_udc_stop(struct usb_gadget *gadget)
+{
+	struct usba_udc *udc = to_usba_udc(gadget);
+
+	udc->driver = NULL;
+
+	usba_udc_disable(udc);
+	return 0;
+}
+
 #if !CONFIG_IS_ENABLED(DM_USB_GADGET)
 static struct usba_udc controller = {
 	.regs = (unsigned *)ATMEL_BASE_UDPHS,
@@ -1255,52 +1274,6 @@ int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 	return usba_udc_irq(udc);
 }
 
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
-{
-	struct usba_udc *udc = &controller;
-	int ret;
-
-	if (!driver || !driver->bind || !driver->setup) {
-		log_err("bad parameter\n");
-		return -EINVAL;
-	}
-
-	if (udc->driver) {
-		log_err("UDC already has a gadget driver\n");
-		return -EBUSY;
-	}
-
-	usba_udc_enable(udc);
-
-	udc->driver = driver;
-
-	ret = driver->bind(&udc->gadget);
-	if (ret) {
-		log_err("driver->bind() returned %d\n", ret);
-		udc->driver = NULL;
-	}
-
-	return ret;
-}
-
-int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
-{
-	struct usba_udc *udc = &controller;
-
-	if (!driver || !driver->unbind || !driver->disconnect) {
-		log_err("bad parameter\n");
-		return -EINVAL;
-	}
-
-	driver->disconnect(&udc->gadget);
-	driver->unbind(&udc->gadget);
-	udc->driver = NULL;
-
-	usba_udc_disable(udc);
-
-	return 0;
-}
-
 int usba_udc_probe(struct usba_platform_data *pdata)
 {
 	struct usba_udc *udc;
@@ -1309,7 +1282,7 @@ int usba_udc_probe(struct usba_platform_data *pdata)
 
 	udc->usba_ep = usba_udc_pdata(pdata, udc);
 
-	return 0;
+	return usb_add_gadget_udc(NULL, &udc->gadget);
 }
 
 #else /* !CONFIG_IS_ENABLED(DM_USB_GADGET) */
@@ -1318,27 +1291,6 @@ struct usba_priv_data {
 	struct usba_udc		udc;
 };
 
-static int usba_udc_start(struct usb_gadget *gadget,
-			  struct usb_gadget_driver *driver)
-{
-	struct usba_udc *udc = to_usba_udc(gadget);
-
-	usba_udc_enable(udc);
-
-	udc->driver = driver;
-	return 0;
-}
-
-static int usba_udc_stop(struct usb_gadget *gadget)
-{
-	struct usba_udc *udc = to_usba_udc(gadget);
-
-	udc->driver = NULL;
-
-	usba_udc_disable(udc);
-	return 0;
-}
-
 static int usba_udc_clk_init(struct udevice *dev, struct clk_bulk *clks)
 {
 	int ret;
-- 
2.53.0

