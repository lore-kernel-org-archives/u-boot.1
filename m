Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E15CAC5B0
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 20:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1011832AD;
	Thu, 25 Sep 2025 22:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ak2ZxIXq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BE4B833ED; Thu, 25 Sep 2025 22:50:32 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 782D8809A5
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 22:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-3544c64380eso2003959fac.3
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 13:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758833429; x=1759438229; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BEDWtQT240TvAZmRki31plOM1+HH2BrrpDc3ZlxA+zY=;
 b=Ak2ZxIXqJW6k2b31aSMeC15GXaxM9HCUeGL8du9lJXI8ARxlRNp70TLoi8BbYaZQ6N
 5VsazJgkAmxCKM83rk4SNkKIbyQBvy+AVIixeIUeORDK7/AAhf+0ayvxL2OPb28/mM9n
 X74qhm4Rn4JCgzyzHSIg7juJD6XM+iBeHzxms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758833429; x=1759438229;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BEDWtQT240TvAZmRki31plOM1+HH2BrrpDc3ZlxA+zY=;
 b=asyIuwcIgZ7SkVx1KJ75fBghSAoL9kC6EYay5WApmfGojsYJMWXCUrS7uGaylkIasI
 cLlc5yrB3ojShYJCy99Am+2xUema4eayNPMLS7Ah8GlUZS9/OArT9/N0JjC39CdNmGgH
 bJpt9lhceiPFvIw5Ajvklm7pV5w89z8LO2p7KBIW0v6o2VzqxpO0YYfVro77au65b/Kj
 WcetsjztaYSvYEBSB51U+ZhwPPtUbV5Kh6BB6jyzmMdEUem+wlTuHA6HK6JNMfbW7xzT
 uLWpMXItjzeUo9QRO09IzPR1CYVUeLWMi9t2aKEKKx+mkF0kvhdo+9ez3vVaDBhuWy56
 4HLQ==
X-Gm-Message-State: AOJu0Yy/wan9Dxz+ru6ZtKMgNktvEWAEY1FbhHJHBKA4+MxSrDxYsmi+
 N8kJ543BqPWni0I17jW8SnRz0JSiwg/AlGa0UBvBgNvzfBCV8FeRJj+9M8X2/XHnWMJylHIazs5
 EpILWA1I=
X-Gm-Gg: ASbGnctsxgVrj+B8VxXdSRqfowc3NQlhgfkub8bsvAKaGwEiUmLPedvhvxUOV4rf73J
 jngOubcdTs2wafDYHyanw5/POeSfHS7p5MwQKBNpPsG0hpUzi8O8r9PXgP4WRiVJHoHElI87W7p
 ldefOLV3hYjILjqePDRux+QNPDFHOCsSzWVFEDQT22g93LS5NpWqatE8/fw36aNtoEv0ZyIqr1U
 QPRx7kI0F6f5uYaPwGwnk6VxNhB7BaF6ypF4fxJv2Y+vbGT1Y2kmHTSWiUCQG/XNKqFCbqXoAAT
 /VXkE3NbDI5wmw3GsJYwoz9EK4/ghh5X7jvmSemE4dKedhSU0rMnvAtIkoPfZ7Uqk/0RbpGMzyf
 QdYPvNsTKIAWah7BxpsYzqaL/SUhF6aI0oUtNTd0Gb64JuykrVhC5Mh+bZro=
X-Google-Smtp-Source: AGHT+IF88JsXzre9v9pV9W+Z7HbynSDX9dw3s4DDrs7Fzfo/LnFsh6cPPgiTCT96yoPF3c8DHE8Dmw==
X-Received: by 2002:a05:6871:7812:b0:332:3a47:9a05 with SMTP id
 586e51a60fabf-35ee91f4d7amr2938842fac.26.1758833429177; 
 Thu, 25 Sep 2025 13:50:29 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7a233315ea9sm610418a34.11.2025.09.25.13.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 13:50:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 1/2] test: led: Add missing ';'
Date: Thu, 25 Sep 2025 14:50:25 -0600
Message-ID: <20250925205026.3561694-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Some tests here had not been compile tested before submission and were
missing a ';' on the end of declaring struct udevice *dev. Add it.

Fixes: 9046279d92bb ("test: dm: Add tests for LED boot and activity")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Christian Marangi <ansuelsmth@gmail.com>
---
 test/dm/led.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/test/dm/led.c b/test/dm/led.c
index 36652c2833a9..f41a2fb73fc0 100644
--- a/test/dm/led.c
+++ b/test/dm/led.c
@@ -162,7 +162,7 @@ DM_TEST(dm_test_led_blink, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 #ifdef CONFIG_LED_BOOT
 static int dm_test_led_boot(struct unit_test_state *uts)
 {
-	struct udevice *dev
+	struct udevice *dev;
 
 	/* options/u-boot/boot-led is set to phandle to "sandbox:green" */
 	ut_assertok(led_get_by_label("sandbox:green", &dev));
@@ -180,7 +180,7 @@ DM_TEST(dm_test_led_boot, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 #ifndef CONFIG_LED_BLINK
 static int dm_test_led_boot_blink(struct unit_test_state *uts)
 {
-	struct udevice *dev
+	struct udevice *dev;
 
 	/* options/u-boot/boot-led is set to phandle to "sandbox:green" */
 	ut_assertok(led_get_by_label("sandbox:green", &dev));
@@ -200,7 +200,7 @@ DM_TEST(dm_test_led_boot_blink, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 #ifdef CONFIG_LED_ACTIVITY
 static int dm_test_led_activity(struct unit_test_state *uts)
 {
-	struct udevice *dev
+	struct udevice *dev;
 
 	/* options/u-boot/activity-led is set to phandle to "sandbox:red" */
 	ut_assertok(led_get_by_label("sandbox:red", &dev));
@@ -218,7 +218,7 @@ DM_TEST(dm_test_led_activity, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 #ifndef CONFIG_LED_BLINK
 static int dm_test_led_activityt_blink(struct unit_test_state *uts)
 {
-	struct udevice *dev
+	struct udevice *dev;
 
 	/* options/u-boot/activity-led is set to phandle to "sandbox:red" */
 	ut_assertok(led_get_by_label("sandbox:red", &dev));
-- 
2.43.0

