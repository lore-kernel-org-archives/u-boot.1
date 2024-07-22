Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8A6C3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 13:36:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1CBB887FD;
	Tue, 23 Jul 2024 15:35:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="knmyaS3k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68F4888403; Mon, 22 Jul 2024 22:24:56 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EC4088511
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 22:24:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-426636ef8c9so33617275e9.2
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 13:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1721679889; x=1722284689;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0pNODCazGyMQ2INzDmL5q8sZ5AMXZbSU5GN/d66SfA0=;
 b=knmyaS3kv3Q7/uMzuEvaaclU0NEw6oXPgpul4xXMnL2N8mOlRKPItPyYNaKoOoosqS
 g/cTvqdO9fz5CA/hZkBCwXq+2bE6bvQnGFRp/iAicNHloVK2GQOyQDlttp6qMnrGzKlL
 GBZykoioW39N3uoJPAw7GIXrb1DKgb9/LjAlttKLR5FXFSe/zuO3lVbVtL+DOjbJQOy5
 mpyOyxPQkpDfj+fHk9pbVaxu2wIfC5xj7wq9sqfLVQFwSIZrpslePw1wgpCWt4ciZiQv
 ik096T/vDGj8uLHbbP4dS3BozXZx/s1X36yyD2IUulrCFcHZdahqzUtRsY8bGEWfLzgh
 rEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721679889; x=1722284689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0pNODCazGyMQ2INzDmL5q8sZ5AMXZbSU5GN/d66SfA0=;
 b=Epx9Ycoul7lyjZMZXzZ8c/N2AApfU/MueHxt3V48zCjMAERCH8FYQUAMVbAm753+xP
 FVCzl9H38NcGDZxFz9TzIxDL/Yg/NxtssNWL9/7SUFA+yESD03kJN678usUUujFM+cGU
 9RKKog2tzp7azcFQYdHJrk2p0oDEqrfkD9UCgG+OxShsEAbFylh0qhZ7lZwNBcp9poPj
 U4yLjJwJrbr47FpHwpN3aIYghq4XsDM4TDQOaz9eM2uhEaxX5p/cdDLdt7U/CcVDJ1iQ
 /jN+7LQ9QFmes2TSyRT9vRUeUoN+PIagq16rsRthwikL76ZgcQb17CILwm5tI0NhoTfo
 Yynw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdY9RJSlVY10TdUozbQhWf6xa/ycS89hrnfgZZYWr7IHVb3wjtvt/WiWZYZzYFwyFij3eJ0dXT3vov46nkVnrE7Gj/6Q==
X-Gm-Message-State: AOJu0YwRBdDSBaMwxFtup5XJBOt32gN/PF3ekVZxJ4BMf4yPDelKUKvM
 UscPwPzIQ3ES0nzElhfPZnZaH70WZgQVgiglPzPPBJ39VmXjP7ZwteRM8eEjv5k=
X-Google-Smtp-Source: AGHT+IFYLou2rSjjtnL+s9Ce+GZvJxlBwyUwNaWWlZK6f7SEFidSHgFWrVFzdHtMqo3hmtJkbknRIw==
X-Received: by 2002:a05:600c:46cb:b0:426:6773:17 with SMTP id
 5b1f17b1804b1-427dc569ffemr48900295e9.30.1721679889547; 
 Mon, 22 Jul 2024 13:24:49 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69071d0sm142982855e9.26.2024.07.22.13.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 13:24:49 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
X-Google-Original-From: Zixun LI <zli@ogga.fr>
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>,
	u-boot@lists.denx.de
Subject: [PATCH v2 2/4] usb: gadget: atmel: Code refactor part 2
Date: Mon, 22 Jul 2024 22:23:28 +0200
Message-ID: <20240722202426.190986-3-zli@ogga.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722202426.190986-1-zli@ogga.fr>
References: <20240722202426.190986-1-zli@ogga.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 23 Jul 2024 15:35:55 +0200
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

- Rename atmel_usba_start() / atmel_usba_stop() to usba_udc_enable()
  / usba_udc_disable(), remove atmel_ prefix to be inline with other
  functions. Also avoid confusion with DM start() / stop() functions.
- Replace printf() by log_err()
- Spelling paramter -> parameter

Signed-off-by: Zixun LI <zli@ogga.fr>
---
 drivers/usb/gadget/atmel_usba_udc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index 476e7ed619..3e3c5cb403 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -1150,7 +1150,7 @@ static int usba_udc_irq(struct usba_udc *udc)
 	return 0;
 }
 
-static int atmel_usba_start(struct usba_udc *udc)
+static int usba_udc_enable(struct usba_udc *udc)
 {
 	udc->devstatus = 1 << USB_DEVICE_SELF_POWERED;
 
@@ -1165,7 +1165,7 @@ static int atmel_usba_start(struct usba_udc *udc)
 	return 0;
 }
 
-static int atmel_usba_stop(struct usba_udc *udc)
+static int usba_udc_disable(struct usba_udc *udc)
 {
 	udc->gadget.speed = USB_SPEED_UNKNOWN;
 	reset_all_endpoints(udc);
@@ -1189,22 +1189,22 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 	int ret;
 
 	if (!driver || !driver->bind || !driver->setup) {
-		printf("bad paramter\n");
+		log_err("bad parameter\n");
 		return -EINVAL;
 	}
 
 	if (udc->driver) {
-		printf("UDC already has a gadget driver\n");
+		log_err("UDC already has a gadget driver\n");
 		return -EBUSY;
 	}
 
-	atmel_usba_start(udc);
+	usba_udc_enable(udc);
 
 	udc->driver = driver;
 
 	ret = driver->bind(&udc->gadget);
 	if (ret) {
-		pr_err("driver->bind() returned %d\n", ret);
+		log_err("driver->bind() returned %d\n", ret);
 		udc->driver = NULL;
 	}
 
@@ -1216,7 +1216,7 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 	struct usba_udc *udc = controller;
 
 	if (!driver || !driver->unbind || !driver->disconnect) {
-		pr_err("bad paramter\n");
+		log_err("bad parameter\n");
 		return -EINVAL;
 	}
 
@@ -1224,7 +1224,7 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 	driver->unbind(&udc->gadget);
 	udc->driver = NULL;
 
-	atmel_usba_stop(udc);
+	usba_udc_disable(udc);
 
 	return 0;
 }
@@ -1255,7 +1255,7 @@ static struct usba_ep *usba_udc_pdata(struct usba_platform_data *pdata,
 
 	eps = malloc(sizeof(struct usba_ep) * pdata->num_ep);
 	if (!eps) {
-		pr_err("failed to alloc eps\n");
+		log_err("failed to alloc eps\n");
 		return NULL;
 	}
 
-- 
2.45.2

