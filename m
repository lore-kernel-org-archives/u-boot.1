Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B1B606A32A
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jE/tx37T;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Yr+KH6E5
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E4A5C60716;
	Sat, 21 Nov 2026 13:15:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OWg9C5oX5yE2; Sat, 21 Nov 2026 13:15:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9B59060E8D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795266895;
	b=dVFT4pNQVDh9bDiFBIRY46wU5hw6lCTQz4TW1+RCLck2dfTdNavlKOKphn2EaJYvbmIR
	 0QDr+WOwp2CaxewRp9NNjZoGu6ukWtoB9OznPajZ4yE3CQ72WzPNM6U+oyfZpibJGZA5s
	 Ct4+xCkpRYr30sTsYuR46Anu1smQ+ukwy8sMZvI2D25lfQ4gEhIh7puI5uEt1QWV0ZFbh
	 bOa1rS8eJA1m1FZMKlh9GrCgnF+oh4+0dyTQb9VjKZ1SeOBHiKP0AgAMCG7kLLwaFP56Y
	 mPZ8ule5m1RiTdq4Ne12i9XVK4w0SuHTAoq/Qr214IROB8M/6MQboju5yzSHexgr5jQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795266895;
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
	b=IoWdcfJznzgaDUNSoZHMFLeek+249Zui6R28FpsIpbqamn58ERiEqxQzAIUvDh6aofKd
	 kqzUixfdhM50Zbk2DnXQScn6bGcjO2AgWEYGlQ+Vs0x+KrwbU25j9ZnUvDTm8W4T4OUkm
	 1SzBjvPpZKoqqiyAV7AriLIQ4O40z+AMLyPWoiLTuPWlQzLMIuBgFOdYsiICLsSyWs26B
	 y2zyhcVdz/wYR7CAE0H9WYap20j4qcaYzRzJ5eUP2wmWEwym1JN4faGpwOTf8usVAkIzr
	 atry5RSDae/x8K4SfJ5qcf5hfY6htXiGJRYRg01eGEyyZ9SJDe8bAEid4PHpZhMGn6g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795266895;
	bh=oUHGwzOzXHZrGFZzsVsmXz23Z9nOkvNHU+4DOPj8tMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jE/tx37T+wfhcMCF3MVhIgup3ZdAhbwv42tqs957zOocPaI8rmapEcYD3STfyuewO
	 9Or9AbsyW1vUfmiWjwMQNnJUSFXnDTFYp9lAFmP8PO22ZvsRKFw5O4a5lQWG7YDtRK
	 bHBVLUUYLnl0FupbXYZu5jzcWHlVaE/CM1K6B2cJGrhqejoKJGnYhVM9T4J3uXpyzd
	 HqdBI6m7l5BYaUVp8BkiG9FSsjH7w5Cuc5/TY72AlefJQc3ilgRW/hPko9rTby8n1O
	 Uh+TJAF51P3HVBalj6ALP+QFdi3TQHjTCiifWMZ+bqShND+HgFvy3EYxUGvo/9qqps
	 3O3cUbBGFHQJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B59060E8D;
	Sat, 21 Nov 2026 13:14:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A385015D
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:55:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8A07A81415
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:55:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d4T4zZRtrExR for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 11:55:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1E72081403
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::629"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=Yr+KH6E5
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E72081403
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:55:38 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c5062bcb857so24860566b.3
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 03:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795262137; x=1795866937;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oUHGwzOzXHZrGFZzsVsmXz23Z9nOkvNHU+4DOPj8tMc=;
 b=Yr+KH6E51VrXj06faiFNNUGi5iQiGKLpc49yV4iyrFUp7Ky0Qjp+HWEFWGtIMx6Ece
 HbpYfsytn2+55qhoFeYiYDr57Li4hywHBUDdgHELspRAe7dAarF9rXPXuEf7BR2TVnuK
 gSgLtGOEjF98peEbw71UdcPl/zlx9Ap6Lymrr5eKbUkNedBYk8gmgKWX4EiUP+R07OiA
 xHNw93vcru3VVnm4AOZtY4EIa3q73IumMOLBERvieF1wF+l5p+Y++Lb+rz6YArpcL/Qj
 HJwJ8SJgozRYLaNBoBgcTBaa6fbKejKFsogBLy/Arqd+b/BQDzzXj9jZJNxcY1Wpw6DH
 7URg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795262137; x=1795866937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oUHGwzOzXHZrGFZzsVsmXz23Z9nOkvNHU+4DOPj8tMc=;
 b=wseMXUD8t4yY1vmu1rm2sbpvOCMmQjM3u25qtFlcAs7hijX7nr5G613QhX5Keb+Y90
 8rfchD2DSzD535f/Yc8Xu+hx0XIDHLDu2HqvIrWMstFSjrydILBX5lbDY9KzoR/pVOjz
 l2waQNGKH1URCKWakMRSQuxHA1nMYk1Q/e9jKLUs2MYAyNeMO5Zkugo5PSS9ILgbMCrB
 jmlCMjWsiCT/3UZKdW6NoQOV6QGB/SbUWJipd0LISN+6MXvSXaYSM3objGr+A5j4TJsm
 2kRFgRFxrqqIH8XUSzC7ti0sHsbq7lE87ICaX7ITkKARZjVufb58zPxm3WQtvrLrBRJb
 K7EA==
X-Gm-Message-State: APuU4Z+2bUCns7SSQEtwoS2zy7P4PHb50U5PG61uq9y7My1fZRLoOu4m
 wJEPiYSDiyTL1HgdF55lpvEqRzX4Jgfd6i1+h1F98seCfgjUwjWLs5ih+tTJkIytYSwlDKelh5M
 KNhys
X-Gm-Gg: AZFdTZcIBCihby5CBkyKbYq5sxSl5oOPbFzx0oQS10t6WRIUuGSfFQuCm/bz3GqZzVt
 7jA/spAv/pmoDTb/M2f7zy7rbyNbD6jc9xV38/7/SMhzo436UNI+A5A422YRI1zbDbfgar24Inv
 TVijioQiUVAzYQMXUyjHKi5F0ObzKj6XD2ko/lfnJ7sBmyLyRfwkdUaHi+fTKtyxoVCky4HadCk
 YnsEZ1YjQzVwfqgJUteuXL731FK4hCoyQkvVMf8Sl9cxYHDBUpBBD+xucSe4xPTWHZI3neFHv92
 WlaxvGtXLVcmiyaVvDZL6nt+Cts82Hys327HAdPZ1+PM0Jp86RtlTlK1BO8dgqKP+K38GRTV4KD
 9Z9m93YWSgE9PtERKAnPSip90FmIDNlikvNgyhPhvt1FjNxnYtdN4Oar+YJCEzgjliUodBTx5eX
 W4UMC+MqUfnGGqgL7NY3c7wYAde1Xsoz78xHSODdNlh355+TZxmbCLSe23vSLWwEgiCELbIcXco
 gD/xOjDdxVh5ia6OJ0G9ZTPnBr2szM6gB/6MMZb1GNcdUXuKfNPSkML/QQ7L25FrNQo1fwh/TSh
 ezoUUXDFZOmxZ7kt3z+O6C4huMTewW8liEbI+qam6KjZzSf5KwDTjVAtMhuQ0GqB9PEBciadR0i
 tP1qPUb4Cbn9oeTLQCEo8EJRCXpEwmzI=
X-Received: by 2002:a17:907:7081:b0:c40:5ee3:8694 with SMTP id
 a640c23a62f3a-c513a84b292mr449073966b.4.1795262136855; 
 Sat, 21 Nov 2026 03:55:36 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae6780esm194960466b.17.2026.11.21.03.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 03:55:36 -0800 (PST)
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
Subject: [PATCH v12 23/31] usb: gadget: atmel_usba_udc: fix up after the resync
Date: Sat, 21 Nov 2026 12:53:27 +0100
Message-ID: <20261121115335.548142-24-anders.roxell@linaro.org>
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

