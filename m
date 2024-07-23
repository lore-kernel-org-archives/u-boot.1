Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C615BC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 13:38:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 549AC88842;
	Tue, 23 Jul 2024 15:36:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="Yj4bk85i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AC09887D2; Tue, 23 Jul 2024 15:18:58 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62407887D6
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 15:18:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4279c10a40eso40207055e9.3
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 06:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1721740728; x=1722345528;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3sYTjDtZGoMz/GaMNdnG+ErxJENySlKtvUc5CR1r5sQ=;
 b=Yj4bk85i2ojIUHNzseAb2R+LqZwYeQM3SYQJIJxX9Y7dHQyHYH1KhHRguodTOHFblV
 eVTd3FWtTkPZditPitoIeMop9OPgcw1nxv9aAgfwb8bp5UI9V5qVFgQ7LrCUpbuzFiuG
 A5DpUEL8naBiHE6DxfvxyZYPhz3lBV0OO7Yq5L1Ur+ibVPwrgeIGAJyd6ouZ4YHEuBvs
 2i2Ge9cc63WITCTz+XCRVIkeT3pEyo1AXR/UkBcF7YdnMerrHtWZTXl4ka08rIeKzY9e
 Yxii29wjNTO/S5lUr2WLwNhnC3YffIcRHEO++vdeRto16mhmfBpd0iMojn1qDMd3b6l7
 PJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721740728; x=1722345528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3sYTjDtZGoMz/GaMNdnG+ErxJENySlKtvUc5CR1r5sQ=;
 b=RWo3IqSnYteEytSe/Nc/eeiLXZ/HgeXMpHsdqe3AO1JBZgATQhj7+capCowadMIpB2
 YoeuPmMyswcGnXv+/74pcLc/uO9DwM75OAUmJR7lH6JE9N3kD/spFZg5rXU1UrWtFm04
 pPjezkNA6H/zQTWhOXq9bROTNdSZBVdASo4gI94OfWiKIwud8KlwYDB2aOu4r1x/l2Us
 f8g2h4SMfJT/EMlaBpR4wSDu7luERGu/GCVE9GFFv8Rdk4ZyVh+WkulUHAcVI8N2mxH6
 pTRaK6U6cYOhDku/XQC3ijUyZz4wvjb7CPzQILc6bOzlc9VmAvNtn9+r6jXEmaFg5YBl
 bmsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUoW2d1d1m1R1SpBjLbBFnug67KB2OM2I6GYpmVjtouxx+H512kJw8cPhP+SyX8diI5jeBOwjXWB3Cj4WCWW3XrSef5A==
X-Gm-Message-State: AOJu0YxYZ+/16w+ee5nRxPmwvsN3z1jtDEGMFhBM8enfw3YPSIzQOR1W
 eS7Cqjzm0H6/5uEj0OgH7X+5OuVk2vrvmUXXkt/tpUbIkpI4fAHfhvnFQI0VaoM=
X-Google-Smtp-Source: AGHT+IFoOwjzZb0515G9Q+jwOXzU6CPjM7uijRaXP04tsvPDN3kKsKXK9mRr6Pjj6YN1FzlkZap17Q==
X-Received: by 2002:a05:600c:198a:b0:426:5ef5:bcb1 with SMTP id
 5b1f17b1804b1-427dc516030mr64487495e9.6.1721740727922; 
 Tue, 23 Jul 2024 06:18:47 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427db2a4e3bsm140312545e9.44.2024.07.23.06.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 06:18:47 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
X-Google-Original-From: Zixun LI <zli@ogga.fr>
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>,
	u-boot@lists.denx.de
Subject: [PATCH v3 2/7] usb: gadget: atmel: Replace printf() and pr_err() by
 log_err()
Date: Tue, 23 Jul 2024 15:18:09 +0200
Message-ID: <20240723131817.262596-3-zli@ogga.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723131817.262596-1-zli@ogga.fr>
References: <20240723131817.262596-1-zli@ogga.fr>
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

To have a uniform printing function, also drop linux/printk.h as no
longer used.

Signed-off-by: Zixun LI <zli@ogga.fr>
---
 drivers/usb/gadget/atmel_usba_udc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index 5f78251fdb..83fdc36870 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -7,13 +7,13 @@
  *			   Bo Shen <voice.shen@atmel.com>
  */
 
+#include <log.h>
 #include <malloc.h>
 #include <asm/gpio.h>
 #include <asm/hardware.h>
 #include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/list.h>
-#include <linux/printk.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/atmel_usba_udc.h>
@@ -1204,12 +1204,12 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 	int ret;
 
 	if (!driver || !driver->bind || !driver->setup) {
-		printf("bad paramter\n");
+		log_err("bad paramter\n");
 		return -EINVAL;
 	}
 
 	if (udc->driver) {
-		printf("UDC already has a gadget driver\n");
+		log_err("UDC already has a gadget driver\n");
 		return -EBUSY;
 	}
 
@@ -1219,7 +1219,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 
 	ret = driver->bind(&udc->gadget);
 	if (ret) {
-		pr_err("driver->bind() returned %d\n", ret);
+		log_err("driver->bind() returned %d\n", ret);
 		udc->driver = NULL;
 	}
 
@@ -1231,7 +1231,7 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 	struct usba_udc *udc = &controller;
 
 	if (!driver || !driver->unbind || !driver->disconnect) {
-		pr_err("bad paramter\n");
+		log_err("bad parameter\n");
 		return -EINVAL;
 	}
 
@@ -1252,7 +1252,7 @@ static struct usba_ep *usba_udc_pdata(struct usba_platform_data *pdata,
 
 	eps = malloc(sizeof(struct usba_ep) * pdata->num_ep);
 	if (!eps) {
-		pr_err("failed to alloc eps\n");
+		log_err("failed to alloc eps\n");
 		return NULL;
 	}
 
-- 
2.45.2

