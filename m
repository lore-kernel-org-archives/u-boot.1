Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08007C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 16:43:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5338487775;
	Wed, 20 Dec 2023 17:43:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VGs+DING";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F03CE87775; Wed, 20 Dec 2023 17:43:07 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE1EC8773C
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 17:43:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40d31116dbeso12380365e9.3
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 08:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1703090585; x=1703695385;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/NQHeLLqjmke5tkVBkXHUoc+EBv/Qq0QLTA/u4i5wdk=;
 b=VGs+DINGcLPAXk7K6ENKLTC948fj35npjeeUDNRcJHtLaxMNmifNxbiN8uGcoo5AQJ
 a0nyIjx3D3qR/pwviidSaxQubF+d+5hD9n3IT+RnaPruIXjICAG9OVlmtoyw1ubaAJl5
 xdlyQeL3VxCWyivWnB2dyHVI/Ol8eLsKAGbrscVkjonfHAzgqUc2yB+W3uEhtxmfLtmc
 UKi7fdZclOxRmyEnP2dhl5B0JPXbBQh9fSpW+W960Ldcq+T8mYLzFCnL2rQHMRe+XbjW
 bCE2SpxgcFXSj1LQs4vTc8YK9flJcXoRZ0vqNv0lv6gmLstQ5C1RahDGcqwAR8o6oYMQ
 y3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703090585; x=1703695385;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/NQHeLLqjmke5tkVBkXHUoc+EBv/Qq0QLTA/u4i5wdk=;
 b=bemJezC1UV7b32Lyh5AmyXQH6leSYhlj/90ppH+cI0s7baN3/QcxDixMfCxULVV5bz
 lJN4J8rYIbdYYuo6Le9lCIVy0VlEuHkgbXRwc9Dt8hjXzXIP7QjQYVnA+fPexo684WbQ
 R4aemcw8PGbwtFIop05jjPZXGtIFNhc2IsRMWzYj04rEiCxkd2YVn9GyyDKbAr660S/F
 Kzo5B2TIZhpWaSeVDT56Jr//IjfIQ028EIep62gcv3GccpNZ6HMQlWePruo18OuvJamt
 UogFxcnayrCRrrsQ4Jug2yaXt3jSL2OskfZfn5SFuDfld61+CkSPZgPMT15O6+8WuT+D
 whMA==
X-Gm-Message-State: AOJu0YyP9S9RirAiVmW2S+grfkYVPT+d5Y1fJdYbHYNzG1RdmNpgLNyB
 j5dq1ooeKkv22bGxnu6155Lepw==
X-Google-Smtp-Source: AGHT+IFVaBApBsf9shFCyC+/CAVz8mFV815aUg7jkvL5/2kwhahcBkh2jJjtvZx6I7E8xELNKQVOyg==
X-Received: by 2002:a7b:cb4d:0:b0:40c:50d5:f7ac with SMTP id
 v13-20020a7bcb4d000000b0040c50d5f7acmr8190371wmj.60.1703090585226; 
 Wed, 20 Dec 2023 08:43:05 -0800 (PST)
Received: from [192.168.1.20] ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 o10-20020a5d408a000000b00336614e25d0sm11037466wrp.56.2023.12.20.08.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 08:43:04 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Wed, 20 Dec 2023 17:42:58 +0100
Subject: [PATCH] MAINTAINERS: Fix ANDROID AB unknown file entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231220-maintainers-fix-ab-v1-1-dd16fc5285ed@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAJEZg2UC/x2MMQqAMAxFryKZDWgcil5FHGJNNYNVWhGheHeDw
 xsej/8LZEkqGYaqQJJbsx7RpK0r8BvHVVAXc6CGupaowZ01XoakjEEf5BmJAzsv0rt5ARueSaz
 8p+P0vh9+shKmZAAAAA==
To: Tom Rini <trini@konsulko.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.12.4-dev-6aa5d
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

Commit 19a91f2464a8 ("Create a new boot/ directory") moved the
android_ab.c code under boot/android_ab but did not update
the MAINTAINERS entry.

Update it so that the maintainer will get cc'ed again.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c1cb2dc4dc0..f6de883a7d8f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -60,8 +60,8 @@ ANDROID AB
 M:	Igor Opaniuk <igor.opaniuk@gmail.com>
 R:	Sam Protsenko <semen.protsenko@linaro.org>
 S:	Maintained
+F:	boot/android_ab.c
 F:	cmd/ab_select.c
-F:	common/android_ab.c
 F:	doc/android/ab.rst
 F:	include/android_ab.h
 F:	test/py/tests/test_android/test_ab.py

---
base-commit: 9e53e45292ee2f1d9d2ccc59914b161bef9b10d7
change-id: 20231220-maintainers-fix-ab-2afa7cee97bd

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

