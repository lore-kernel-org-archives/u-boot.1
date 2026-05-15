Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B76CCD4851
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 12:27:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8731484609;
	Fri, 15 May 2026 14:27:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile.com header.i=@hifiphile.com header.b="B2Ty5e0V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13C0B83FF5; Fri, 15 May 2026 12:05:56 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B47818341A
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 12:05:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488b150559bso70738005e9.1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 03:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile.com; s=google; t=1778839553; x=1779444353; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fmPPY/owvD99lC4E1KxDKEJvf0Zecgg+c0gkLUA+pGU=;
 b=B2Ty5e0V+qgeG6s8ACzObmIk/q6pnQ6Mj5RC/zQ8dzb+yuTxpVJ0qqJGJwIbNjcxmh
 8m00HOJ0SAukf2AEtP6sNiqliLeYXtRl1LRuvNdvNLM7rH7H9+dBQL8Nvc78VBwDNQXE
 NeVvTyM2nuQ4qeKjMm6O7A12Na+rOIP/mk8k/s1jO0pEyexgNi8ZG6hqMkKMTGm0csvq
 3/DFkYnMdEAA9USZYszlsDynW3nKGJvRdGvWC4BTgn+Ai53bWZgmIY2g9e6+vUYn8qDt
 he8psGYcjezFQPo83VyLKwleuFgQhNUE9Rko6UTdYTQeF9qbod2h54Y+vNRdXhsseW2j
 ZrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778839553; x=1779444353;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fmPPY/owvD99lC4E1KxDKEJvf0Zecgg+c0gkLUA+pGU=;
 b=lgxeaBvWj6SkOLClZHwB6DOG8QhtdkzyjAx9iZjgk4pu/4iMcMz5TXC+Hz2HhiriI6
 B1PGM0QjOUvMkkRukkO+mC0VqZIDZbYbcVAjWL65Ztx8LyxyG6lXgLa6qW/23wd3t3jY
 1TqC0+cfuP9fEIT91/uu86H9W3nDYVO6kIZ1MlYcVWPaPtlGkLRAO8IL8zgzFkzbp+Sw
 JxBwbs6hIhdkiaHCqMPSllSom1F6/G6waBpISkmu+hxCvue7u3ogxGZIVVE/+WG5CrQ9
 vNE7Hg4WOgBN8a+C1IwpHCF8qifKt0AFPG0hgkymPJK9en13/Hpt/BcDjGlr7aAGZL8m
 F+cA==
X-Gm-Message-State: AOJu0YwvqqRw2NdoTKPzNEVWDovtWR6asTfRrukz7kI21b5fJowkLwWM
 /oaSgiNTWBR8+GrkIHXbR0JQjxgasSmX/KliuOgxySnjgpJmohO+VI8LEysHjYuoWAbSEA77BXe
 spHfrIVsn5Q==
X-Gm-Gg: Acq92OEtfi8kBx5Y+9rSWj4sbc97qLHeeGQW+XGB4YbMZTPsQ3QUNplOLmN9Sg7uG3k
 T+tgWifhgVZgmh98mC31on0fKqzNq+HpS4CM/3JmZyn0wn6Px74Tpf+WFhwTv4m0+ZztkGbnFBt
 5oAr57Up99Fxl21K5mrOHo6Hql4VYJt2cQ64eAZKqUDOB0kFLLqQBVmbyypEt1T2RTLY64w+SDb
 TOR00jrsiRBnOBX9UZSrydtJVcRyf2emfJZk2HOwzH+mOoCKDFcWm/FlmGy93oL/fb8OEWSIZ0N
 si+jukLUgR76rIHz32PmThSGYLqlslqpTQzeGpMcQncwyRd+AKvaWUDKQ3TPPQ0zhHGWXmuX47J
 ooHCGCznxPJ3c2Zb0Eo137qIVmSyPamX7q28dg29Mmki0d6xOzrxkOp5DFdb7bFhnhiBJAqPAln
 c6d8NM9MjooZiI+1TYJbzmOQ==
X-Received: by 2002:a05:600c:4e46:b0:488:bc6a:528d with SMTP id
 5b1f17b1804b1-48fe632243cmr46320865e9.22.1778839552810; 
 Fri, 15 May 2026 03:05:52 -0700 (PDT)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-48fe5694f2csm50430365e9.4.2026.05.15.03.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 03:05:52 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
Date: Fri, 15 May 2026 12:05:41 +0200
Subject: [PATCH v2] usb: gadget: atmel: do not disable endpoints in
 reset_all_endpoints()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-udc_ep-v2-1-cd335b4e62e4@hifiphile.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNyw6CMBBFf4XM2hpannHFfxhiSpnaMUqbFoiG9
 N8tuHR5knPP3SCgJwxwyTbwuFIgOyUQpwyUkdMdGY2JQeSizisu2DKqGzpWcVnoRtYD6gGS7Dx
 qeh+ha//jsAwPVPO+3g1DYbb+czytfPf+oitnnLWyaQssS6Ub3RnS5Aw98azsC/oY4xcaY7xBs
 gAAAA==
X-Change-ID: 20260512-udc_ep-51a3f7a6befb
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Zixun LI <zli@ogga.fr>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Zixun LI <admin@hifiphile.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Fri, 15 May 2026 14:27:19 +0200
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

Endpoints should not be disabled on bus reset inside UDC driver,
otherwise a race condition will happen between gadget driver. Gadget
driver will free the requests and disable endpoints in disconnect ops.

Also remove outdated comment about it in usba_ep_disable().

Fixes: 59310d1ecb9f ("usb: gadget: introduce 'enabled' flag in struct usb_ep")

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
Changes in v2:
- Remove outdated comment in usba_ep_disable()
- Reword commit message
- Link to v1: https://patch.msgid.link/20260512-udc_ep-v1-1-8a783e44cf7f@hifiphile.com

To: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: Zixun LI <admin@hifiphile.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/usb/gadget/atmel_usba_udc.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index f7a92ded6da..a2eee2bca2c 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -289,10 +289,6 @@ static int usba_ep_disable(struct usb_ep *_ep)
 
 	if (!ep->desc) {
 		spin_unlock_irqrestore(&udc->lock, flags);
-		/* REVISIT because this driver disables endpoints in
-		 * reset_all_endpoints() before calling disconnect(),
-		 * most gadget drivers would trigger this non-error ...
-		 */
 		if (udc->gadget.speed != USB_SPEED_UNKNOWN)
 			DBG(DBG_ERR, "ep_disable: %s not enabled\n",
 			    ep->ep.name);
@@ -571,20 +567,6 @@ static void reset_all_endpoints(struct usba_udc *udc)
 		list_del_init(&req->queue);
 		request_complete(ep, req, -ECONNRESET);
 	}
-
-	/* NOTE:  normally, the next call to the gadget driver is in
-	 * charge of disabling endpoints... usually disconnect().
-	 * The exception would be entering a high speed test mode.
-	 *
-	 * FIXME remove this code ... and retest thoroughly.
-	 */
-	list_for_each_entry(ep, &udc->gadget.ep_list, ep.ep_list) {
-		if (ep->desc) {
-			spin_unlock(&udc->lock);
-			usba_ep_disable(&ep->ep);
-			spin_lock(&udc->lock);
-		}
-	}
 }
 
 static struct usba_ep *get_ep_by_addr(struct usba_udc *udc, u16 wIndex)

---
base-commit: 5732bd0f457b4c671e46574d64d4acb099c0f0a5
change-id: 20260512-udc_ep-51a3f7a6befb

Best regards,
--  
Zixun LI <admin@hifiphile.com>

