Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E98C3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 13:39:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4547588860;
	Tue, 23 Jul 2024 15:36:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="mSJgr43X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A904887B4; Tue, 23 Jul 2024 15:19:02 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 552D38880E
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 15:18:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4279c10a40eso40207225e9.3
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 06:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1721740730; x=1722345530;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OT439pExSoYKY20APDUlMHlXpFMN3brwRzaTUhY/qC0=;
 b=mSJgr43XmIu/RySWbQxILIoWH2l5prMNtchlmbycOVq12NuiGaTG7HgO8QvOcKZR4m
 3ILSBYRXeVNWJl8++3T3htq9XCEUlR1Y6VcpR+tl3HOAvNEdB43oteLvN4i5/zD1Lj8I
 Jp/OLd+onbslg7Uc1z86tyEU/thIbUiDH5H++RPf3Pce8GBTUQK3e6uVpNpxiT7IcX06
 ZoxPMhfsWJ8EPMTIL5mdkxcD4RfBM8IoIPZioT1C1lwQ9eBFAGlRDMiD4w/6OtFfpJ3D
 ZWecGrR55kb0pjdUuBM9OmPEPpV2Q9cbkvK0wHxE4E49bRlMPZI8rlgyJblrMVYEsqIL
 eYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721740730; x=1722345530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OT439pExSoYKY20APDUlMHlXpFMN3brwRzaTUhY/qC0=;
 b=wBw13AW5/WOg3Zhz/Ga8Jfs+FlI/JKGUN093s3sOp3g+PjVavXyqJI/sEuKQXCql/K
 qDH+r8Ibnv6F+QVMuHSyW+R/0OkpTmy6jPhq+AbY0LTKRHmOoJd5hoKCquodr2eqHx+W
 YiWZv53Ds1MkIrMEpxGYagG0BySxmv+OT5TEItsY0e0DOXJ+DlWcPq7GpCG3ZEDSBZF1
 Eh7W/eiL6XC9COfIiAb0qp4AURIi6+JBKKc4QudDVh8+MUwr8WyVIah8uaCoGqOp2Jz1
 jxAqRFNdRuNzCIY3PuR/Q/1qoDNrHNtgylTtGGQErhiJHwez6Ge/Y9XAijlvrnL0cV7V
 bUzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGCT4VZs+DqLl+0/+/LaCAJFX0N/LI88P6suo0hqKE7QZorJYNJovESbi7do643jlkTUTJIoXL5omPO63WVa0vd629Tw==
X-Gm-Message-State: AOJu0YxZKRKk7f8oBPMhzHTEbDqsvUlohCrudkUz+9M6WQbBLpIuudD3
 ZxJl1ePOqHCxKHsCMk3ZthpyjMwFs7A+Lhnb4AS2oFHdZWo2c0oQZ2FQXbhtsWU=
X-Google-Smtp-Source: AGHT+IGs1RaFn1y9JZA9O+sxiCGnOAqao2gkuYKfzPD6uFEIMum9RFoal24RUq+Me/adUg8auGtwlQ==
X-Received: by 2002:a05:600c:458a:b0:426:66fb:fcd6 with SMTP id
 5b1f17b1804b1-427dc51600cmr60147425e9.3.1721740729839; 
 Tue, 23 Jul 2024 06:18:49 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427db2a4e3bsm140312545e9.44.2024.07.23.06.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 06:18:49 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
X-Google-Original-From: Zixun LI <zli@ogga.fr>
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>,
	u-boot@lists.denx.de
Subject: [PATCH v3 5/7] usb: gadget: atmel: Rename atmel_usba_start()/_stop()
 to usba_udc_enable()/_disable()
Date: Tue, 23 Jul 2024 15:18:12 +0200
Message-ID: <20240723131817.262596-6-zli@ogga.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723131817.262596-1-zli@ogga.fr>
References: <20240723131817.262596-1-zli@ogga.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 23 Jul 2024 15:35:56 +0200
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

Rename atmel_usba_start() / atmel_usba_stop() to usba_udc_enable()
/ usba_udc_disable(), remove atmel_ prefix to be inline with other
functions. Also avoid confusion with DM start() / stop() functions.

Signed-off-by: Zixun LI <zli@ogga.fr>
---
 drivers/usb/gadget/atmel_usba_udc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index a3d24501ba..ea9ad7585e 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -1153,7 +1153,7 @@ static int usba_udc_irq(struct usba_udc *udc)
 	return 0;
 }
 
-static int atmel_usba_start(struct usba_udc *udc)
+static int usba_udc_enable(struct usba_udc *udc)
 {
 	udc->devstatus = 1 << USB_DEVICE_SELF_POWERED;
 
@@ -1168,7 +1168,7 @@ static int atmel_usba_start(struct usba_udc *udc)
 	return 0;
 }
 
-static int atmel_usba_stop(struct usba_udc *udc)
+static int usba_udc_disable(struct usba_udc *udc)
 {
 	udc->gadget.speed = USB_SPEED_UNKNOWN;
 	reset_all_endpoints(udc);
@@ -1253,7 +1253,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 		return -EBUSY;
 	}
 
-	atmel_usba_start(udc);
+	usba_udc_enable(udc);
 
 	udc->driver = driver;
 
@@ -1279,7 +1279,7 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 	driver->unbind(&udc->gadget);
 	udc->driver = NULL;
 
-	atmel_usba_stop(udc);
+	usba_udc_disable(udc);
 
 	return 0;
 }
-- 
2.45.2

