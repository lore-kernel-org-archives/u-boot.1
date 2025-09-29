Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B94CAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 16:25:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62D198319C;
	Mon, 29 Sep 2025 18:25:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v8kGeA9l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9ACB832AD; Mon, 29 Sep 2025 18:25:27 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAE9182A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 18:25:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e4c9083a0so16211255e9.0
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 09:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759163125; x=1759767925; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eyz6rem9K2WedUjB6RgHwB0oizrcf0CCsbJKmtUL378=;
 b=v8kGeA9ljeU1oBDhstWN3Cu5XO/jZ296e6G74C1gomZ06WxoYU9vo5KYJghVlHHs6x
 aYaRkrAD//OryeQRrJ3gVOkbkROB9m3YsMfKXrgeqDsb28p+B1lEIou/ezW78lhcrAK4
 oWlibIZNFntM04jIar6QVbkSOBC0MfYpXPUT/sa0uFiVGETi/0PHBSo634m+0tmvUPgs
 53w5h3rg7+n1oKjX0jdrRuEsIkFCr4YAs5SbZx9KciL8BDmMl1ni5dlQEdP8UJ3jMZAh
 sz5kA+SWlKl4YrHTMT89OgeZdfkyyOGvg5dOQz821uAQSLHeHJmpmhfZ1T12JBYrA1+K
 NKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759163125; x=1759767925;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eyz6rem9K2WedUjB6RgHwB0oizrcf0CCsbJKmtUL378=;
 b=wi46v4gbeoX51ljBPrAza2lPq6R9xmRqfRHp2f/34e5tSCE8rbuVX6eFzv8BNZqQ1Y
 1hnVzB+NnxyA8+GKMosMDFCGO+ld0HKdt+CXqBs/uy3wyYlZ/mzmB1cQlvoRgsiQ24Je
 S98TimCHSpAIvEcA8HDMdTJxxDQsHZFtRMEeTFAEdW6bno034fGZ1bntqz3lC5lY4XUA
 0DIN4Lm7FQo5ZRjdRqPewX2BxsFQhDbOBTKOGxGFPlHAXOtUV9VPgAk+wmI5GQeEh/kk
 4XtoiFYWUSK2cngEgZCZexQ/RMEs3II7WoBXUuoSiQYJX2C56uw3CoEPmuSY7no70JMl
 P/Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMM+IrUwtHoZxK2uvzD30GgWxxywOv1bdHxe0Fz3TOV0wSBEDA9FtNYb86Uzdphp8LLEEM6zE=@lists.denx.de
X-Gm-Message-State: AOJu0YzWAdYyRLuA0y2CMwLhjZlji/pNJblhWZuXKBWPT1WESrlYOPge
 c+90MzYZEO5fG1WD+JjqoVXv1ylZYrkJaLhbfApcWYM1E1aEyn4GYAkmVkFvgRs2h41i8ufr55P
 +BdlP
X-Gm-Gg: ASbGncvZrzCB43RNnlHarMA6HKJ7dJ2T+E5hFFInOiOGxzBSUlaCsz3cmK7bkMqaoks
 rWkaQWEgexuO6qiBp75d3mUcOI/xWp+T7I5g1RHXUP8835rhyMEJyqaolk2DzN+x9bB2c/kB94u
 oW+CugenXtsFrgmd119wdN1/lp31re3csz1YNKRo2KGcaEvJl3RTHZfKTQ04NvGzN2hs+qErJie
 KY1wuqVbuF8lOKBqgrQ4wiq+8DtIWQRoFLlC74UGXqkruN3QcB8/L8503Dw3Ja+P06olfbv8i3f
 0K0gDO1jJVoGFsuQvjugNwwcoFqgoOOXRZADYXBtAsGceUsY2mkJy/JOFBr3R/QEfRGEwPaGX+8
 F5N0KdteoBO8akOJl3PMBW6eArD2icQBoJd83OL/q46nD4uCgHg==
X-Google-Smtp-Source: AGHT+IGttufobb1GHH3gcBOMV/6SgRzs2y//AGvNm7pyp86blV21JYL8/xvPh9ijW4S4kmaTnkrQdg==
X-Received: by 2002:a05:600c:46cd:b0:46e:3e50:e0e6 with SMTP id
 5b1f17b1804b1-46e58ad362cmr12410005e9.17.1759163125356; 
 Mon, 29 Sep 2025 09:25:25 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:4bc3:3107:fbfe:562])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab31f1dsm230630035e9.13.2025.09.29.09.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 09:25:24 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 29 Sep 2025 17:25:23 +0100
Subject: [PATCH] usb: gadget: atmel: Add missing null check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-atmel_usba_udc-v1-1-e1426271e12a@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPKy2mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyNL3cSS3NSc+NLipMT40pRkXQMTMwNTS1NLc0sjCyWgpoKi1LTMCrC
 B0bG1tQAs0WusYAAAAA==
X-Change-ID: 20250929-atmel_usba_udc-046059597928
To: Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>
Cc: Zixun LI <admin@hifiphile.com>, u-boot@lists.denx.de, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Add in the missing null check for udc->driver that is present at other
points in the function before it is dereferenced.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/usb/gadget/atmel_usba_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index 72f68dba3a741b7f0aac8ba89b83eefb5e0cce4f..f7a92ded6dab187475249874db37d81a07bf5b9e 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -1147,7 +1147,7 @@ static int usba_udc_irq(struct usba_udc *udc)
 		reset_all_endpoints(udc);
 
 		if (udc->gadget.speed != USB_SPEED_UNKNOWN &&
-		    udc->driver->disconnect) {
+		    udc->driver && udc->driver->disconnect) {
 			udc->gadget.speed = USB_SPEED_UNKNOWN;
 			spin_unlock(&udc->lock);
 			udc->driver->disconnect(&udc->gadget);

---
base-commit: 9710d98e8942151fc0c62d54100d9d27e8263d04
change-id: 20250929-atmel_usba_udc-046059597928

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

