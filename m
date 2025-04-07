Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D126C3601E
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 15:00:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 987ED82F4E;
	Mon,  7 Apr 2025 17:00:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P8SLmmpK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 637FC82ED4; Mon,  7 Apr 2025 17:00:00 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5688782ED4
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 16:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-abec8b750ebso759313866b.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 07:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744037998; x=1744642798; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jjvSelmjT/q91LltbV1Tt+24ieZ3bMT0TJinsbbJPu8=;
 b=P8SLmmpKZbeR3qOWu7iRo/0TEVgvt6J1uo6+66S8NX2FF7RNu6rtAdp8X6SxdY5gkq
 Dvviy+S7GPc0VT53PzQ1c8EOiucgXCvg/Ju1+ITQnS6e8N1n+cXu53B2SB0OT5u9FyWI
 okaRp99d/IvM/9ijjFw9kWPBZHI+IncbQTYCIMcDZYtNZc3BL3DG6P8shseJtFSYflGd
 dllEoD6qQpmgS9NVmyYdJITr4ixfH2nou7B7IuYzv9ohOAzufzqS2yNwUPFb9L1Cs6hW
 J6PIiszHWGXLnn+rNtfVYpRWjo5k1NplnaXFBJIDlE3QCMIi9kjHfDyeIUMgqkZdDhUg
 fWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744037998; x=1744642798;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jjvSelmjT/q91LltbV1Tt+24ieZ3bMT0TJinsbbJPu8=;
 b=ouqmru2n1yh5weyJ8vKnXPXMmw5BvVTPMxDZOjcNGd4K6ma0lceX8C0/vxWjCVs7Gv
 KnyklOGuD6sDKlWjf3YKz4mr+xJm3lXAnNzTw7A5dMCdYohXrLRnzFiil+qkqQMhX1J4
 Jq6UnKiuRkXOvGDcoq8mveS3LXfPnFOQJvJK/TtE+qSTtZHBd9cqrpdfecZlpYI8XHba
 rZrN5NNHTSAoQVQwc6z4qh/PA9btTObe/gJ06ZH1ivHrUoWLMWyz8G3/GtQEbz9UC4Eh
 DDn9f1PAe2sPNDJFhxmEIEGsPsZC7qV91nnDMxuHK1zgxhrgoy+7p1p+H/TMTL+8smYU
 s5jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpUfL09HiRgHtP6YOTy/kmlG/lIWesCQpYqZX/AHxTfuAGqHVa2gyQYG9S6HqCF8ZDjQ4lTbI=@lists.denx.de
X-Gm-Message-State: AOJu0YzmsWEP4PhrgcDIyslW8RSkbGR6kCCzGKJeu5DnOTEpOCvJD+DT
 sPF+Jrk9vGtE/axyTb5FqdHWH5ZzMiVtrHXFcuvpUHAECbdkTQknrz0r2Ti06vk=
X-Gm-Gg: ASbGncsIOtnuGZbIq2V4OIBte62fTDLq7jTMBoo3kEoG5gkf0pPDhQ9/nRfgFmYhLPH
 v5UFuEvRl9CnWmAdXBsuhf7Oura0OATCO2K2e1yBb68z5ZIgnL9nBH8HFBygadOMRNTPsAy/f8r
 qrlr0fAYNJLAj94+3hmVe//rjH+WjXpgI/HNjtwFa/3ae+HQb0AJaSah2u/VdByVIG16dinClbH
 5NtW5a7KU9lIEjU3yAeBuQLd64Vgc7CqcPc1g7DGGOLrSbRdP4c/ndLAoX59QDmgB7ss9v1gkvN
 5mm+uLwIsY10jcm+kQLr+80gL6Uwv0HEqboqlRX4jC0Opc4xr0l9ukZiU+TpU6F6bLHG
X-Google-Smtp-Source: AGHT+IFi4GSZ7xVPJScO/yii216Pzi4Y/ZBmrHAjvP4NP1WeljwrrtXEH/+Fg0RAihJXcsEnx5XLJQ==
X-Received: by 2002:a17:907:7f0b:b0:ac7:7f1f:c3d9 with SMTP id
 a640c23a62f3a-ac7e729ddddmr1001021866b.30.1744037997638; 
 Mon, 07 Apr 2025 07:59:57 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:b2e5:7ea8:e86c:3f99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfea2224sm751585666b.74.2025.04.07.07.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 07:59:57 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 07 Apr 2025 16:59:35 +0200
Subject: [PATCH 1/3] usb: gadget: f_acm: Claim requested USB endpoints
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-acm-fixes-v1-1-e3dcb592d6d6@linaro.org>
References: <20250407-acm-fixes-v1-0-e3dcb592d6d6@linaro.org>
In-Reply-To: <20250407-acm-fixes-v1-0-e3dcb592d6d6@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, u-boot@lists.denx.de
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

U-Boot has an older version of the Linux gadget API, where USB endpoints
returned by usb_ep_autoconfig() are not automatically claimed. As written
in the documentation comment:

 "To prevent the endpoint from being returned by a later autoconfig call,
  claim it by assigning ep->driver_data to some non-null value."

Right now f_acm doesn't do that, which means that e.g. ep_in and ep_notify
may end up being assigned the same endpoint. Surprisingly, the ACM console
is still somehow working, but this is not the expected behavior. It will
break with a later commit that disallows calling usb_ep_enable() multiple
times.

Fix this by assigning some data to ep->driver_data, similar to the other
gadget drivers.

Fixes: fc2b399ac03b ("usb: gadget: Add CDC ACM function")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/usb/gadget/f_acm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/f_acm.c b/drivers/usb/gadget/f_acm.c
index f18c6a0a76110df62e925de1882316eed463b343..2665fa4168f99b35a8c595aa24cb3fc4e8ab8529 100644
--- a/drivers/usb/gadget/f_acm.c
+++ b/drivers/usb/gadget/f_acm.c
@@ -238,18 +238,21 @@ static int acm_bind(struct usb_configuration *c, struct usb_function *f)
 		return -ENODEV;
 
 	f_acm->ep_in = ep;
+	ep->driver_data = c->cdev; /* claim */
 
 	ep = usb_ep_autoconfig(gadget, &acm_fs_out_desc);
 	if (!ep)
 		return -ENODEV;
 
 	f_acm->ep_out = ep;
+	ep->driver_data = c->cdev; /* claim */
 
 	ep = usb_ep_autoconfig(gadget, &acm_fs_notify_desc);
 	if (!ep)
 		return -ENODEV;
 
 	f_acm->ep_notify = ep;
+	ep->driver_data = c->cdev; /* claim */
 
 	if (gadget_is_dualspeed(gadget)) {
 		/* Assume endpoint addresses are the same for both speeds */

-- 
2.47.2

