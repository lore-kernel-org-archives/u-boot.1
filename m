Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15483C36010
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 08:16:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54E3281DED;
	Fri, 28 Mar 2025 09:15:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qKK1Alfk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4908581273; Fri, 28 Mar 2025 09:15:52 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 459EB81951
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 09:15:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso13239015e9.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 01:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743149750; x=1743754550;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oVJIwXVg4Fn6wXUhB8kxZaZwvsZrZ1vTceLF7ivv+zY=;
 b=qKK1AlfkqRFsbPWwXq045iILmH90HkJ29kh5DllZSuIJ7Py1/1/ABDMOpvoIFGV5Nq
 /CJGk2WRUw+uufYA0mwv0NT5R1ad1AIl8JyP4pUSN9asZeTtMxFBQvTGVsz2ieH8SSGm
 9Ra/tR6mASEXAkxRXesCKkqu6o6ScLJb3UWwp60a/Z6G2MuCpWk9WTAbCbDBnkEyzAu/
 0/PhoUWv8Ihqz04WLF5g1hrBK7U6sHt/dA2/rvKggPQZOOQzg19ZiGUjMiv9YjESPryF
 UgbH8aQDHnCaQmhTDFyAwEMMMfghikDEa2h3uiYBoJndDdKX/MCKFM9yrq2KdOyVdG4p
 71MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743149750; x=1743754550;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oVJIwXVg4Fn6wXUhB8kxZaZwvsZrZ1vTceLF7ivv+zY=;
 b=dwcB/y2Lv121JJx0eL8bhwTavOtxDWDxneWAuxNttGsndpCqE67m0Ju1ku31OCVepR
 3ye9tkxBS4t6uQpFm2SYwb3+UboM49beDhDvlOPznvgUgPKoIIqKdc60oUlwXas0OT9z
 xV3SlbYhxrWY3L3CSpbr5Sompp0AjAVk0lTZHPzipQr+UsYOFWhcSLhzr6OgT+t7s+jo
 vL9xoT5JSBrdgIYJmX8WK2mXJ+z7CkYKcVHmXkaSrayW6TORseFqFnrgc4QyUgE3ba2c
 Q0J4nRRTYsEq+Cm2awzEY93QBxf75QldoH/38uORa4oCpfaYm0VPOUHnW1MTfZi0mDmW
 tjZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUA0oXP7VVUcnxz4/5MqeRdtEnuCSTwYG6qE7hyAnCCkPwT8KvHdYyMEYqRYAp8hhjaUKt7K4=@lists.denx.de
X-Gm-Message-State: AOJu0YwPT/Fiys1fzmZhlwmHzWYthM9vhdXMsqokeGAei4Qlwj05ePCa
 ghrjs2Ewc6zbs/6i7NYwPh7qmuWxIOz7Bhl6GbKDOT5IAjMevGxiKIVk9KLSgto=
X-Gm-Gg: ASbGncsoQ0/cygJ9G5cfshQzFvDncaxv9GmMK0djdVl40pZVqTLRSbvEyLbPhHUCq3Q
 mMXqNvYRoDn7viXFVQSU98MfK0IzPv7nSI9VmFSXWot9k1AD9+YioH/Peq3uKUQYyLegye54SyI
 6USsbBkMZXkGT8v72vXfXQjWoiTqjnydVW4kSKHV6jEwr9Mbtdab2qlVPe49bYMix/ysdRvZACa
 9Wm92NM1xd1X31pxHFVXbM/Mn7NzJwpIgXhqedAxgrFwVpnTRpakYG9JP3QwLjreJLQmyNk8i77
 0UhEUaFzGaeAE0Dzzp6qq6Utj1QBrJM19pcDStSGmqWT3ahqQSBZUDC8/QIc7ls=
X-Google-Smtp-Source: AGHT+IFl01J3AJtMN6G15FMTMF0DtBG6x5bzEAN/BvN+DQZKX1NlmwqNMMDIEcZp4beJAYi8pP3cTw==
X-Received: by 2002:a05:600c:4e05:b0:43d:26e3:f2f6 with SMTP id
 5b1f17b1804b1-43d84f5e5bcmr75979185e9.5.1743149749641; 
 Fri, 28 Mar 2025 01:15:49 -0700 (PDT)
Received: from [192.168.1.116] ([2a01:cb19:95ba:5000:2b24:7f52:e3f6:e4ef])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8fba4c29sm20352065e9.5.2025.03.28.01.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 01:15:49 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Fri, 28 Mar 2025 09:15:41 +0100
Subject: [PATCH 1/4] usb: gadget: f_mass_storage: Remove kref structure use
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250328-ums-gadget-leak-v1-1-3b677db99bde@baylibre.com>
References: <20250328-ums-gadget-leak-v1-0-3b677db99bde@baylibre.com>
In-Reply-To: <20250328-ums-gadget-leak-v1-0-3b677db99bde@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Marek Vasut <marex@denx.de>
Cc: Zixun LI <admin@hifiphile.com>, u-boot@lists.denx.de
X-Mailer: b4 0.14.3-dev-94c79
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

The kref structure is locally to f_mass_storage and is not used
anywhere beside in fsg_common_release().

Remove it and use struct fsg_common* instead.

No functional change.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 drivers/usb/gadget/f_mass_storage.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
index d3fc4acb401a..bd749c033f9a 100644
--- a/drivers/usb/gadget/f_mass_storage.c
+++ b/drivers/usb/gadget/f_mass_storage.c
@@ -284,7 +284,6 @@ static const char fsg_string_interface[] = "Mass Storage";
 #define kthread_create(...)	__builtin_return_address(0)
 #define wait_for_completion(...) do {} while (0)
 
-struct kref {int x; };
 struct completion {int x; };
 
 struct fsg_dev;
@@ -345,8 +344,6 @@ struct fsg_common {
 	/* Vendor (8 chars), product (16 chars), release (4
 	 * hexadecimal digits) and NUL byte */
 	char inquiry_string[8 + 16 + 4 + 1];
-
-	struct kref		ref;
 };
 
 struct fsg_config {
@@ -2436,7 +2433,7 @@ int fsg_main_thread(void *common_)
 	return 0;
 }
 
-static void fsg_common_release(struct kref *ref);
+static void fsg_common_release(struct fsg_common *common);
 
 static struct fsg_common *fsg_common_init(struct fsg_common *common,
 					  struct usb_composite_dev *cdev)
@@ -2548,16 +2545,12 @@ error_luns:
 	common->nluns = i + 1;
 error_release:
 	common->state = FSG_STATE_TERMINATED;	/* The thread is dead */
-	/* Call fsg_common_release() directly, ref might be not
-	 * initialised */
-	fsg_common_release(&common->ref);
+	fsg_common_release(common);
 	return ERR_PTR(rc);
 }
 
-static void fsg_common_release(struct kref *ref)
+static void fsg_common_release(struct fsg_common *common)
 {
-	struct fsg_common *common = container_of(ref, struct fsg_common, ref);
-
 	/* If the thread isn't already dead, tell it to exit now */
 	if (common->state != FSG_STATE_TERMINATED) {
 		raise_exception(common, FSG_STATE_EXIT);

-- 
2.49.0

