Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB35C3DA70
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 13:36:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42454887E6;
	Tue, 23 Jul 2024 15:35:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="eDDKg6Z9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4CF58845A; Mon, 22 Jul 2024 22:24:54 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B38787F82
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 22:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42660b8dd27so33610515e9.3
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 13:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1721679886; x=1722284686;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XGrPkQGQgBNeiqM+95Ef10zl3y1GW6QJFZow6A3e+Ko=;
 b=eDDKg6Z9bWM18MYVjyT+AzZLZkvMEBCs8W2D8mzFu/Orh2dxqD6jfZ/RqFo7yHo49T
 NErHM1HAe73+NMaISWMHFBeTlC77x9yPhHQQfvgMfvXodde7soUzFZcwZsOqdWJIoeju
 0al4ssKIOfZHjPeztZTHMnfX4hlAT7geT3vjIuDPe7vc8He5X+z0APt+9VZYYeYuFPDK
 zzItesuQypcIw3jFInBFeHpx7aIdopxg7qQFMYM7iZdF3RrvMOZs36zxtpGAT0nPc2fu
 fAe0tYD3J0YW6mkESPoTFB28SKmn0lJqJrQuWeOhCXY79jmpKoDrUQK0N5xB5ms+x8Ux
 KBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721679886; x=1722284686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XGrPkQGQgBNeiqM+95Ef10zl3y1GW6QJFZow6A3e+Ko=;
 b=LZa8DhS0EEGTyvLTQeZEfjLbokLU5vKR7sGq8HknCf2xMJ+cyTidTp6WzclXCJLFOE
 uh4AAQsIjq6IIATBcqB2OBpvuCVfOkch2VsaSj0l/X0teAIcDYmVfcGpW6mLhibAbalz
 Lk/QX5J5bcMRzLtyi+KkIyZqyVwHbTlVUBcZ2QaVg79PL+TaAppbTeCi6Mm/xbLFRbRJ
 8oZzIguPo3NWJgfk6PCasXCMV6jkqohTQ8qGTwCVwP+3cP2aKChn4utKxzdP7KoCf+C5
 pTCj6YpTOwR9gPhu7sT549dD3n5tt2LwAfkz6qZgXPwXNhS6UHtcvOIpS1wK2eXI5XJ8
 1MbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxMR4Tk/SeJkKGR/vsTeyduz/eo27MIIOFkpmLZIPA6Qu/Dd0PdLiV6+BzHLrC4kBtHa4aTlkr/sQ63HFGWTCftDNqPw==
X-Gm-Message-State: AOJu0YyNdl+/emdhX5/tlusxqpFaGg8yC3GTF+i5N2iwuxE+/cpUiqGw
 GQJubaKTYLj2xvNATVDjcMNCKjbCqwyhkk4JEHWcvckj36ahz03uHbtRWX/6wGMQwg6m4JWk/gP
 S4pWtyQ==
X-Google-Smtp-Source: AGHT+IE0aMML5tlLiPad59CfZ4i6w1jKLKJWEM/wplBEjxLCMixVgISK6Kd4L1El15i5YityPPWeGg==
X-Received: by 2002:a05:600c:3542:b0:426:5c36:207c with SMTP id
 5b1f17b1804b1-427dc569de8mr48664705e9.25.1721679885811; 
 Mon, 22 Jul 2024 13:24:45 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69071d0sm142982855e9.26.2024.07.22.13.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 13:24:45 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
X-Google-Original-From: Zixun LI <zli@ogga.fr>
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>,
	u-boot@lists.denx.de
Subject: [PATCH v2 1/4] usb: gadget: atmel: Code refactor part 1
Date: Mon, 22 Jul 2024 22:23:27 +0200
Message-ID: <20240722202426.190986-2-zli@ogga.fr>
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

- Sort includes
- Forward declare controller structures

Signed-off-by: Zixun LI <zli@ogga.fr>
---
 drivers/usb/gadget/atmel_usba_udc.c | 59 +++++++++++++++--------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index f99553df8d..476e7ed619 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -7,19 +7,22 @@
  *			   Bo Shen <voice.shen@atmel.com>
  */
 
-#include <linux/bitops.h>
-#include <linux/errno.h>
+#include <clk.h>
+#include <log.h>
+#include <malloc.h>
 #include <asm/gpio.h>
 #include <asm/hardware.h>
+#include <linux/bitops.h>
+#include <linux/errno.h>
 #include <linux/list.h>
-#include <linux/printk.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/atmel_usba_udc.h>
-#include <malloc.h>
 
 #include "atmel_usba_udc.h"
 
+static struct usba_udc *controller;
+
 static int vbus_is_present(struct usba_udc *udc)
 {
 	/* No Vbus detection: Assume always present */
@@ -506,12 +509,6 @@ usba_udc_set_selfpowered(struct usb_gadget *gadget, int is_selfpowered)
 	return 0;
 }
 
-static const struct usb_gadget_ops usba_udc_ops = {
-	.get_frame		= usba_udc_get_frame,
-	.wakeup			= usba_udc_wakeup,
-	.set_selfpowered	= usba_udc_set_selfpowered,
-};
-
 static struct usb_endpoint_descriptor usba_ep0_desc = {
 	.bLength = USB_DT_ENDPOINT_SIZE,
 	.bDescriptorType = USB_DT_ENDPOINT,
@@ -1179,28 +1176,16 @@ static int atmel_usba_stop(struct usba_udc *udc)
 	return 0;
 }
 
-static struct usba_udc controller = {
-	.regs = (unsigned *)ATMEL_BASE_UDPHS,
-	.fifo = (unsigned *)ATMEL_BASE_UDPHS_FIFO,
-	.gadget = {
-		.ops		= &usba_udc_ops,
-		.ep_list	= LIST_HEAD_INIT(controller.gadget.ep_list),
-		.speed		= USB_SPEED_HIGH,
-		.is_dualspeed	= 1,
-		.name		= "atmel_usba_udc",
-	},
-};
-
 int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 {
-	struct usba_udc *udc = &controller;
+	struct usba_udc *udc = controller;
 
 	return usba_udc_irq(udc);
 }
 
 int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 {
-	struct usba_udc *udc = &controller;
+	struct usba_udc *udc = controller;
 	int ret;
 
 	if (!driver || !driver->bind || !driver->setup) {
@@ -1228,7 +1213,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 
 int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 {
-	struct usba_udc *udc = &controller;
+	struct usba_udc *udc = controller;
 
 	if (!driver || !driver->unbind || !driver->disconnect) {
 		pr_err("bad paramter\n");
@@ -1244,6 +1229,24 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 	return 0;
 }
 
+static const struct usb_gadget_ops usba_udc_ops = {
+	.get_frame		= usba_udc_get_frame,
+	.wakeup			= usba_udc_wakeup,
+	.set_selfpowered	= usba_udc_set_selfpowered,
+};
+
+static struct usba_udc udc_controller = {
+	.regs = (unsigned int *)ATMEL_BASE_UDPHS,
+	.fifo = (unsigned int *)ATMEL_BASE_UDPHS_FIFO,
+	.gadget = {
+		.ops		= &usba_udc_ops,
+		.ep_list	= LIST_HEAD_INIT(udc_controller.gadget.ep_list),
+		.speed		= USB_SPEED_HIGH,
+		.is_dualspeed	= 1,
+		.name		= "atmel_usba_udc",
+	},
+};
+
 static struct usba_ep *usba_udc_pdata(struct usba_platform_data *pdata,
 				      struct usba_udc *udc)
 {
@@ -1286,11 +1289,9 @@ static struct usba_ep *usba_udc_pdata(struct usba_platform_data *pdata,
 
 int usba_udc_probe(struct usba_platform_data *pdata)
 {
-	struct usba_udc *udc;
-
-	udc = &controller;
+	controller = &udc_controller;
 
-	udc->usba_ep = usba_udc_pdata(pdata, udc);
+	controller->usba_ep = usba_udc_pdata(pdata, controller);
 
 	return 0;
 }
-- 
2.45.2

