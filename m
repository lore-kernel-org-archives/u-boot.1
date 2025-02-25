Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D344BC021B8
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 09:49:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1497A80F53;
	Tue, 25 Feb 2025 10:49:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740476973;
	bh=sBkPsxs5vIUIgAXTzilh9MAtYn5SFUr4VfOrw00bGT4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=d5oLG5qBlMRu8eO/0h/2rP9Xyk/6gj/Htf9dspwXHWLPPBctnuwki28Xz9IgGZn0U
	 bS9npOsG1k1t/+ZCpq57wqjeclKlwtIuKFQRw5VXfUFLw5DzA7Cq8Xluij1h1lLolo
	 vqSSKfnooLaU7o1hDigLN848CPnYeKYvfiYj4QHYDFnwN+YEton+agPoyN93hLCZ3j
	 4g/teponz08RjOsvDB8hK4Zg6H6oQymg6r/160Fjf4/IVvQPC7/vawtd8irbrtHlkr
	 a5kn65N++iH3YuQmvruyVLl9v/ZenWp7O7LrbEKiEXVwcwOBivWpCOxboQl8ELzPA8
	 TJLV4+yIAiDOQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCBEE80F56; Tue, 25 Feb 2025 10:49:31 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94DD280EC0
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 10:49:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="eUOvh0QZ"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C102010382D03; Tue, 25 Feb 2025 10:49:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1740476968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=sBkPsxs5vIUIgAXTzilh9MAtYn5SFUr4VfOrw00bGT4=;
 b=eUOvh0QZNMhEyiVoVvCRmk+WM49PdrKLYwUr/agxAdBAjxYnCXufEH5iUOnpwGjJOEMIdF
 aS+RyS92mv2QcQcbgszoLkzx0i5H/S9hloCiVwcr83bSM3WS4uLjYwWAZT9A01piVhnvBY
 5zBB8swWg5KwJ5/W4KvyXz0rb1B8aqHGuwM/xtN4mkm4PzGGW7nC9HYVooox6V8Ie+ifRb
 zGF+mNqnc3t9VFBNdbAYnI6W1C82MssQqcy5i5FdyO6JqjIsdiFUI69qcgM3JhIiMD/6Dm
 UpBtbuDa6xbmxJ+g5C360/N4mP4q8BdI/j1FTfFiGgAkGzYVIrteYMmnyBhKag==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@denx.de>, Christian Marangi <ansuelsmth@gmail.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1] led: fix next coverity scan error
Date: Tue, 25 Feb 2025 10:49:23 +0100
Message-Id: <20250225094923.71364-1-hs@denx.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Tom reported the following covervity scan error:

*** CID 542488:  Control flow issues  (NO_EFFECT)
/drivers/led/led-uclass.c: 277 in led_get_function_name()
271                     return uc_plat->label;
272
273             /* Now try to detect function label name */
274             func = dev_read_string(dev, "function");
275             cp = dev_read_u32(dev, "color", &color);
276             // prevent coverity scan error CID 541279: (TAINTED_SCALAR)
>>>     CID 542488:  Control flow issues  (NO_EFFECT)
>>>     This less-than-zero comparison of an unsigned value is never true.
"color < 0U".
277             if (color < LED_COLOR_ID_WHITE || color >= LED_COLOR_ID_MAX)
278                     cp = -EINVAL;
279

see:
https://lists.denx.de/pipermail/u-boot/2025-February/581567.html

Fix it.

Signed-off-by: Heiko Schocher <hs@denx.de>

---
Azure build:
https://dev.azure.com/hs0298/hs/_build/results?buildId=171&view=results

 drivers/led/led-uclass.c                       | 2 +-
 dts/upstream/include/dt-bindings/leds/common.h | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
index 22f61d12d38..e2edcc43f30 100644
--- a/drivers/led/led-uclass.c
+++ b/drivers/led/led-uclass.c
@@ -274,7 +274,7 @@ static const char *led_get_function_name(struct udevice *dev)
 	func = dev_read_string(dev, "function");
 	cp = dev_read_u32(dev, "color", &color);
 	// prevent coverity scan error CID 541279: (TAINTED_SCALAR)
-	if (color < LED_COLOR_ID_WHITE || color >= LED_COLOR_ID_MAX)
+	if (color >= LED_COLOR_ID_MAX)
 		cp = -EINVAL;
 
 	if (cp == 0 || func) {
diff --git a/dts/upstream/include/dt-bindings/leds/common.h b/dts/upstream/include/dt-bindings/leds/common.h
index 4f017bea012..9e5ac5196e2 100644
--- a/dts/upstream/include/dt-bindings/leds/common.h
+++ b/dts/upstream/include/dt-bindings/leds/common.h
@@ -21,7 +21,10 @@
 #define LEDS_BOOST_ADAPTIVE	1
 #define LEDS_BOOST_FIXED	2
 
-/* Standard LED colors */
+/*
+ * Standard LED colors, LED_COLOR_ID_WHITE must be the
+ * first one and start with value 0
+ */
 #define LED_COLOR_ID_WHITE	0
 #define LED_COLOR_ID_RED	1
 #define LED_COLOR_ID_GREEN	2
-- 
2.20.1

