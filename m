Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA0CC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 17:15:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9E3888395;
	Thu, 25 Jul 2024 19:14:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="ITXeMiMB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4925888100; Thu, 25 Jul 2024 17:32:33 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF9EC882E6
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 17:32:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-36844375001so604525f8f.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 08:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1721921548; x=1722526348;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eTIIwnKIn6tCwlDIS8k2B4LnNUMLkIT2IPRCe+2muaM=;
 b=ITXeMiMBWrS2zlFldHlS/xXtbHHIrRLbgIMLXZ7K4bzXOQLUnnbiGnKGAa/BWhupOo
 mtYqkpYi5N3LInAUp6UuSyNp/L6ZggndRmOreEIr6y22VRebz3FNOqXxau0E9OE/Ws8N
 jkMzrwViBelCJqz1X95MhzHXq6GD6POYORdVdEJGZ5etJdXHgiGk9lratHrOljHUAJpa
 id++4anSQiwUNa4ndGo7sa0SdaG17lZ2H5+2yc7NHMHXfixpeJLRLQ+aehLFGSFUsaF+
 8igUlVHers4La/M6tSfgKlB+Su8h0ewOis31DTU8tPKSbM2M5gTf21dF+k6Lm78wEiba
 j6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721921548; x=1722526348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eTIIwnKIn6tCwlDIS8k2B4LnNUMLkIT2IPRCe+2muaM=;
 b=IAjZmOfGHIgcvbpkCbJhdJ+YgsVkrbB/2eNfkgAJWtJceltfV9l6JvsXIEJrvZ75U/
 rD0dNOOW7TeTnOx+elyMhgyTJze2dvwHWveQygq/3XzYwRCXX8Uw5bhqOJdTd4VoCL+5
 AXYMI08PCdVMcRdB3RD44q1LKwnKSJlG5eQmupmkQAyQoANNDCLNac6QUw5frwkkHFrp
 ljc8z0Wgc+QRb0lGKgZL8qdT4aaUIhthOwTU7SGcKOMnmLUSX+vrInQM1qS5OwR0JtTo
 VU5OZuPe/Y6Bd6+LT9d32zxk5zxtPbV8f5BxMcHe6wv6voM8vdPZCeE8n92Y1EgU2W5K
 y1Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXL8FVdBYCzCv29hRjb09cHL0Q2xznB1qs+aWW9nVlQiH6O429mmqdhLSdtZNh6y+EyxYpFIVTtCh0zo5E5iwPb0nQNoA==
X-Gm-Message-State: AOJu0YxUN3e/SstzeQC8UiJD8w0DycVRK97WV/3pQZgkmAM4mKijnyzs
 5vBcLHXo8e2ohgwQ0jUazrxscdnmqXu6pN1xOPhHDqk8YBd/lVaMQE3WILFS55U=
X-Google-Smtp-Source: AGHT+IE3jp1B9buMFGkGzKn0LCUMmKgEVqKQvK7YqjOkYhW09cGkHh48+6dL+7172Qi2DjiaFGlUBg==
X-Received: by 2002:a5d:64c4:0:b0:367:8876:68e6 with SMTP id
 ffacd0b85a97d-36b31a41978mr2982159f8f.48.1721921548535; 
 Thu, 25 Jul 2024 08:32:28 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36b36861b54sm2530805f8f.95.2024.07.25.08.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 08:32:28 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <admin@hifiphile.com>,
	u-boot@lists.denx.de
Subject: [PATCH v4 5/7] usb: gadget: atmel: Rename atmel_usba_start()/_stop()
 to usba_udc_enable()/_disable()
Date: Thu, 25 Jul 2024 17:31:59 +0200
Message-ID: <20240725153204.358925-6-admin@hifiphile.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725153204.358925-1-admin@hifiphile.com>
References: <20240725153204.358925-1-admin@hifiphile.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 25 Jul 2024 19:14:03 +0200
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

Signed-off-by: Zixun LI <admin@hifiphile.com>
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

