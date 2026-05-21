Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53456CD5BAB
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 02:13:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87C28846DF;
	Fri, 22 May 2026 04:13:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile.com header.i=@hifiphile.com header.b="LRM+uT8U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 392758484C; Thu, 21 May 2026 22:01:13 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 516EF846FA
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 22:01:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso48548705e9.2
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 13:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile.com; s=google; t=1779393671; x=1779998471; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2A6OAx2GaQvgFuRjcGQ/GGOLNvUW9uYtI8Mfz9k2PnI=;
 b=LRM+uT8UJtY0KDWxL6foT6Y2/+APTJi0fQISgzCxtFwsNJu5zC6j3xcENH46XpqwQN
 rjPimzBafL3TM+Ag88xZoJr8DbSahW9cMO+uAFDiO6MRadK6xkphtzSxmuLOyUKcLoi5
 4O1/8SG6NQgLrr3FvoCm8qqYCTTIS1f7ql2zZmzTnwfioBnW2jfrGRYsdD8MAZ9ksYbc
 3rxGM58ypnWjcQYGlF8iPRziis6I/yhIfVjturQtRTxo1KM0O4y9BZMJ+js1VruJwcHF
 JrYlnKtl1wVGXCES5qxnkIahcH4CrbTGrr2VlyCFeSuetLUok6KtkVAUT8w08/i4tfOx
 wINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779393671; x=1779998471;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2A6OAx2GaQvgFuRjcGQ/GGOLNvUW9uYtI8Mfz9k2PnI=;
 b=UncnizZ24r7pO8isBdzweRP9mhOf+gyny6wA+pSB8TxxsD3D9QZPnANkLdlBYLVmWP
 mYnrCcN4uVyh2mqbs9w+owimPxiK/v8YDvuZn3k4s4O7jXeCeuPpKgQRNmSJHe5fYTnM
 xGYon3+8iTHy4dAlLD6/3yhhRNAW5xO5SCkfVTYzMYd58wBN/GAqsCrY0UjvgADQccwl
 RuGE4/6njLAX4md0+Mb3kJSw34GuRTLD6MB90Mxe3KJtv+dFaFv4mZirkKncWYL0+4Nz
 ZsEK5EIZ2rmPuHXB5PYG5sdpSnmi0v9GzudaxDoQeAMgalKRluUsO1YYIO41IrR0vZSx
 Txgg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/7oWo+8nDZzeH9goa5bS6nhJcaJzYCH9m9VLDM2zBfk/pys6o1qyr6ul0tX05AH5C6q8gV0rA=@lists.denx.de
X-Gm-Message-State: AOJu0YyVmnlb8d1+1Aw4GAPUTrTONT2lFuDZA2FJdl/InhvUTwTiElO1
 6xNgqd14nAMiJgEWLgVTwbPDrwSp1X7C1tSxiM81iQAMX5xdxGcq/DgiUlaI1vIHjCg=
X-Gm-Gg: Acq92OEMHWylM8EnqaRlI+A3qxukea/62Ps2i4nJvzvAFb+RvIOlVTBYBq9NJaCe4Ja
 W9PTFWZR85PVUo4VF2eMkom6qkGJLgMYDFzsyLx0FZj8c7yo1zWDD6tHdAg0DxOWpCwIWfjKSGP
 rzzirYlp24rUlt5LfyuM4yJi67E7QDqAQiruOLFD/8SIhIkcrrLYN7atS6zB090TsQV3TeenC+d
 N7dUVzBUf/qk8okHUTJZtjbAtAnzb3K35r7kHJfuSyZFCpDpI8bNBflnapcViHYzHTgvA/JXZPc
 fRZNzZinrh8b32j3jr/VvzG9NS3fZ0LDPFxporAXfCZy5ZRYyoVwEbGgAAs8+oHujEjBeLODAPC
 WkSXKQK5jpX7Czn+tyL+ug+rmcEaE6JzAq/CoJqqweZuLh8CLC4lrHOwAlp621SGQo5F/hMf7Uv
 SRrE7ER9NYjfkM1AsyVKq52A==
X-Received: by 2002:a05:600d:4448:10b0:48f:f7cc:f6f5 with SMTP id
 5b1f17b1804b1-490428e9154mr2151425e9.31.1779393670341; 
 Thu, 21 May 2026 13:01:10 -0700 (PDT)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4903cae778asm43087065e9.13.2026.05.21.13.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 13:01:09 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
Date: Thu, 21 May 2026 22:01:07 +0200
Subject: [PATCH] usb: gadget: atmel: use calloc() to allocate endpoint list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-udc_malloc-v1-1-b6118f809ada@hifiphile.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqAIBBA4avErBPMMKSrRITpVBP2g1YE0d2zW
 n6L9y4I6AkDlMkFHg8KtMwRWZqAGfTcIyMbDYKLgkuRsd2aZtLOLYZhq3IpLVe6Q4jB6rGj85t
 V9e+wtyOa7T3AfT9EJn98bgAAAA==
X-Change-ID: 20260521-udc_malloc-eb8355d08afe
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Zixun LI <admin@hifiphile.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Fri, 22 May 2026 04:13:03 +0200
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

malloc() doesn't zero out memory, leaving ep->ep.enabled uninitiated.

Fixes: 59310d1ecb9f ("usb: gadget: introduce 'enabled' flag in struct usb_ep")
Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 drivers/usb/gadget/atmel_usba_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index f7a92ded6da..a5a2252dee9 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -1219,7 +1219,7 @@ static struct usba_ep *usba_udc_pdata(struct usba_platform_data *pdata,
 	struct usba_ep *eps;
 	int i;
 
-	eps = malloc(sizeof(struct usba_ep) * pdata->num_ep);
+	eps = calloc(pdata->num_ep, sizeof(struct usba_ep));
 	if (!eps) {
 		log_err("failed to alloc eps\n");
 		return NULL;

---
base-commit: 5732bd0f457b4c671e46574d64d4acb099c0f0a5
change-id: 20260521-udc_malloc-eb8355d08afe

Best regards,
--  
Zixun LI <admin@hifiphile.com>

