Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A474C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 17:14:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DC8D88263;
	Thu, 25 Jul 2024 19:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="sh0cYpBh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DFFF88373; Thu, 25 Jul 2024 17:32:31 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9451A880A7
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 17:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-368440b073bso703101f8f.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 08:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1721921546; x=1722526346;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oUfScaNo5LAD7/5pOsCET7dTvRx2i0h5Kmb93VGWQFI=;
 b=sh0cYpBhVmajmdfaaYerUuJ6nERnpXa8wJjHHU5Ln8MBrvmRc1pq+22qrW4AEd0BR5
 Ea0AUgpU53EzJj6qxX5XdEQC6Ubs2FN3qOfsCVk7yJxQDXzNk79DRalH/k1lXqlxhSfJ
 6tCQcYbvKSCzZiMV2j0RA6/otUm3EZ19EA4zSH3SV9kJodDLfnBRhxrshc6y8N6tuAyy
 55CWelL+hdbN9bba4E4sJSrqoyYemVzv6UwSCg2cjR34PfCFN1rACtJtBNqDyMnJCJeS
 tQsnnO5Cj/q6wx4dNmL1qalxZkI/a3g4kombZBV4oEgnTj+qbRzqTxn1jorF1KcvGSXI
 6LFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721921546; x=1722526346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oUfScaNo5LAD7/5pOsCET7dTvRx2i0h5Kmb93VGWQFI=;
 b=XwZSvn0Sbtq8EwIr65/SO9y3FX4IkqNsIl+wBOitLhdxi4gfaaQc1ifB/dZH/rsOSO
 MjiOM16WoSDK7MCxYXMdn55uyNXIiant7wiO2FYoDOPvT5BFwl3ZhA+Q2TEvlHjjjHPo
 7w9td6AgR8O1a93FpywwrVvDg1RFNjnAhOzJXQcSa58C3LiWw4TmcjvXTPnN3/jZsZOC
 A9hUIQpiQjOMfXfROQe9DKmKVpuy7ZfKJUSKHy01yADJZrA/ucFHuQJrlZ7CqM88MZOh
 kODKs+PmcRosxbwf7qAgVaTSCAUW4UKe0LCuD/nHL633U7uKMdAWHgUvzo3T87znApeh
 CZmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMADajX5CQzW7cjTR05eNoFY+jZPlTtOCoIsyHmvetKp9BQLv02GXhUZJ7YwY554vwLqIlIzOj474Zmb1iokCBhQbK1Q==
X-Gm-Message-State: AOJu0YzjJGa5Ul2WzNQQOYTkpoOMZgvcxsJGMJfYzBYkXgYC5PuJu5sZ
 rNFKBacKwe5eUIW5tHqAKaTuPEI1cO5CiUE6L9KcUXdOgVYwoo0QzL4x5O9KdJM=
X-Google-Smtp-Source: AGHT+IHhkXya1KM5+8iZaj0kipUzZJafOkrtVmXGC8ZSY/x6iSeolXjubxZ8yDbaIs/+enyKzY9ZnA==
X-Received: by 2002:a5d:644a:0:b0:360:9500:9bbb with SMTP id
 ffacd0b85a97d-36b31b4117dmr2528909f8f.12.1721921546058; 
 Thu, 25 Jul 2024 08:32:26 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36b36861b54sm2530805f8f.95.2024.07.25.08.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 08:32:25 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <admin@hifiphile.com>,
	u-boot@lists.denx.de
Subject: [PATCH v4 2/7] usb: gadget: atmel: Replace printf() and pr_err() by
 log_err()
Date: Thu, 25 Jul 2024 17:31:56 +0200
Message-ID: <20240725153204.358925-3-admin@hifiphile.com>
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

To have a uniform printing function, also drop linux/printk.h as no
longer used.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 drivers/usb/gadget/atmel_usba_udc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index 5f78251fdb..4641638412 100644
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
+		log_err("bad paramter\n");
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

