Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF07C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 15:38:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D6D882FC7;
	Mon, 14 Jul 2025 17:38:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jOvUpSSP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E00DE830A0; Mon, 14 Jul 2025 17:38:56 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEBEF82E37
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 17:38:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4560add6cd2so14235215e9.0
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 08:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752507534; x=1753112334; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z0lgFAey/yucvcb89wqXRtsnZ0nMnUIslRikiNShf0c=;
 b=jOvUpSSPnssUlCSn6+LLIWERI2tPF5XQc8INS29mUFlq6KWZpxeirdXU1xvBb3XfHS
 NId/0+p6Prj9HyQi2MgB7U9pfyGgNgeigbaW3Uu5FR6hF8AOm6JA6AJTP0tmiMogKnDx
 dhUGvqEybA0X2yr9K4cubbaE+xF6wIU5ItK7SvWo5p2X8NnjQVL/DbeZcOllPFrg8+wS
 g2Axvzhjh/XrFqidn7YTSJ6sN6g63VfSUOhOXlkMAF4/kvwnggk3su3fFAI5/xmEsDM6
 rpTcKSGf0SKKA3ptc6YoQZIUI6nCfscQbjuT3vAb9bNNLtTfkf+BSL5S6uSwIBwRdUpf
 hHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752507534; x=1753112334;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z0lgFAey/yucvcb89wqXRtsnZ0nMnUIslRikiNShf0c=;
 b=JNz2Rss6Al6TOTj62PW/4y487qSgp1kAP9Qf4TelEOqw4ygr3ZDlX4zuOq3OG9Ltlu
 AtsKpCm7GjRRU0D/ZeJLQnj0dfdvDSC9H0SifZJjvM1Uvyd5hSSHmEhUoU0FvHTpP0PM
 ija6/rvwPX/Di511L30hnhBq10iPHgtKeHRiGqBQuuIc9E+ppJ5KkEpuPRmONAjOj1eb
 M/3i9LIv3VtPUZfuFKnzxtKt7qv1QtDUbWUzhsQRN1m9Rok7F7Lau2i3pAJeE5kscN1r
 UuUtw8/0DxxG4nWDGs2AYYAoyvDIh0x79D8RbeAyyVmAhqE4IcKjwTMQ62mrHCX7cBXH
 4h8w==
X-Gm-Message-State: AOJu0Yz1/j004JqTzuDFlnr5eDyj/Icr9z2m1mqz8kJPrXjyHxzR6LMU
 u5vg+ynYvSVnLFs72yoYkO/nDEdR6aJwevWDz7OLH/MVcubgEg6Y1xTqViDcVRbWi6s=
X-Gm-Gg: ASbGnct49+8VEvqeWUMCQfornBsBqSZqmuZREWjfO/M0khyFF44HayZaPWjhMYXowv4
 7UbKAWHqA7t8V6+syi8YF9/GITqnKb3+15kZ+kfpKjDQbAg7tCbM2MXZSXmcXjA2CKvEEHIj7Rx
 t1WFm5V3x5nIg64XJVM7V+QuGQIon6XPK+jAj4Vx3NMGpJshO0gkt5t4nvM0P88Dt/Kup8wqoBX
 OzRFREZDY4ELAtf8j3JieI44xFVMxEEriF1FrPNqWDYQkdUVAP2PnuRM3y3O/KgF9ztNIO27dfF
 WE/Vuy/ij0W5E+IHnsyeLp5nS8/VrdMKRSae51IUv7bZoUpAJLNRNy058iT450eS0tzWleXmfWS
 PlPt1yengUBQXjKMSJiG5zpX0AD+7pMNxn2a5mhy9na3CNOiH9Sb6XSnoIKF4
X-Google-Smtp-Source: AGHT+IHsEQSst2zF5fg62MrpbHTjoK61tPm1sZR8gXEeNglb2LmMXkrdqKwEaBlHATKkvFY3cIEfWw==
X-Received: by 2002:a05:600c:1d8a:b0:456:1122:8342 with SMTP id
 5b1f17b1804b1-45625e2a951mr440855e9.5.1752507533722; 
 Mon, 14 Jul 2025 08:38:53 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:3743:80cb:93ed:a9a8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e1a5sm12525168f8f.74.2025.07.14.08.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 08:38:53 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 14 Jul 2025 16:38:53 +0100
Subject: [PATCH] block: Remove unreachable code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-blk-uclass-v1-1-d21428c5f762@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIwkdWgC/x2NQQrCQAwAv1JyNrBb1yp+RTxkY2qDdZVES6H07
 249DsMwC7iYisO5WcBkUtdXqRB3DfBA5S6ot8rQhvYQjjFhHh/45ZHccZ+6U+IQ+y4w1CCTC2a
 jwsOWPMk/Ypt4m/Q6/y+X67r+AKR920d1AAAA
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

The two functions blk_find_first and blk_find_next use a for loop with
the content being a 'return 0' which means that the 'increment' code is
unreachable so remove it and also remove the variable ret which is
assigned to but its value is never used.

This issue found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/block/blk-uclass.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
index f3ac8db9464..b38c21ffbe2 100644
--- a/drivers/block/blk-uclass.c
+++ b/drivers/block/blk-uclass.c
@@ -613,11 +613,8 @@ static int blk_flags_check(struct udevice *dev, enum blk_flag_t req_flags)
 
 int blk_find_first(enum blk_flag_t flags, struct udevice **devp)
 {
-	int ret;
-
-	for (ret = uclass_find_first_device(UCLASS_BLK, devp);
-	     *devp && !blk_flags_check(*devp, flags);
-	     ret = uclass_find_next_device(devp))
+	for (uclass_find_first_device(UCLASS_BLK, devp);
+	     *devp && !blk_flags_check(*devp, flags);)
 		return 0;
 
 	return -ENODEV;
@@ -625,11 +622,8 @@ int blk_find_first(enum blk_flag_t flags, struct udevice **devp)
 
 int blk_find_next(enum blk_flag_t flags, struct udevice **devp)
 {
-	int ret;
-
-	for (ret = uclass_find_next_device(devp);
-	     *devp && !blk_flags_check(*devp, flags);
-	     ret = uclass_find_next_device(devp))
+	for (uclass_find_next_device(devp);
+	     *devp && !blk_flags_check(*devp, flags);)
 		return 0;
 
 	return -ENODEV;

---
base-commit: 074e05952705972072f52128cf2e3ec2d8f35de6
change-id: 20250714-blk-uclass-34684c01f60c

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

