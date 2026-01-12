Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CDEC9EC8B
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 13:13:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 648EA83A1E;
	Mon, 12 Jan 2026 14:13:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="IyYVKrvO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C4B0839A8; Mon, 12 Jan 2026 14:13:09 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28A2E83935
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 14:13:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-432d2670932so2678494f8f.2
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 05:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1768223586; x=1768828386; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ICpEspmn/5kZhxyZsi8gRDuxpUAQvFZqgkWR59/jng=;
 b=IyYVKrvOnsMwnJeuOMiA7tqA8TIHR5k60JZJ/s0ytQcXIOpqy9uJS7bCuvp4ERGe3s
 y7A9sYb+RMtaCBV1Y2EQ4ed+pdvcrwd3QXBju4DIkLSDKXuT3yTXjbcNKSWspQDcSWjc
 kW6FaR9xXf6HEa7+HH6mugmkQCDrO8ATyPNoYOagNKtuzjT+MRqnvT/yyBe4hERwP9IF
 QI4hhi0M9nA6v2HQscDG8Pg7Bnezqo4qaQmz95bTJhgXWKojVOixebvDBLPkl0bmeZ7w
 pnWbDpf3270DSpF3CHVyDoJwq8Jz4QBn1aAZP5HT9Ob6zh4kKlqu7eq6o0bIWb62ufX9
 Fggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768223586; x=1768828386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4ICpEspmn/5kZhxyZsi8gRDuxpUAQvFZqgkWR59/jng=;
 b=qM0gRCjNIbm0FzodAvUzvyVBcfNL8QoTZvYdpukrGt6v2MNglHy/OFr7LzHltd6o/N
 10V/UhOZFp+OyZwXrnt4PcKyGyy1fd+hVC9Tt3s4t2HPUyem9zzlQFE9VDuuyxRu5lts
 zAYFv8fBB4biL13R6xGU1BKIXPmV929ikQzJZETY0zF6G/I1abTg8pClhIZeQBxSb98s
 5z3Lsbg0G5nthqrgwxrofEVs0f1lWZWBRDi0DXYtZDyGw6K/BujIKUABNOH0sSYHTVMt
 Z0FWvgki7nOrFI4vbeLeEnVWmtgR+PcO29p1FHybCr6xvaxO/2NhLtSTBJpMxShhE3Ub
 FNwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV1usffIrng8Soz8PkDeyKk+k7fnTrMCuAiFvqJkWccjirogqjtujEJlZEBIp1WIo3mFVXOpA=@lists.denx.de
X-Gm-Message-State: AOJu0YyCnSMKpR10Vi3tKN6xjezPCiabhPSTxQ9O3REPNFTa68/qeTOj
 kQmCvqauX4zQGo9PINNE6JkPHAaiY1Abc/mNX6g+QstVgdHt1q9ZKwCGee4KiCrFrGo=
X-Gm-Gg: AY/fxX7Th7hQpITY7fYl15ZP2VKVgl90ypNW/uUsucLyfxjGsT2kzwkEmb83WAdVICU
 NCin2Kjc6J3Y51lfty0gzTPs0JzE4kWL3jLWIHdU20JwI2cweCwrQfcSNzf/c6pIlsC3nsMTed5
 nUyXKP1IIuFr9kvAUxqKYnwjprvRqCh3zrJeASztKPramcqlPmi856La35OOjHLbqekSoFciKGP
 0nwvyWSPVlkhUY00G8mG9HGuPEbDN/DK3CUxB43ycxKySkhixaLWkv5KQFqAY6WnF5iTcY9LXXT
 B4GeNkhNSmR/UGEdykdCdrizC57RqT1Vk86AYr1+8BNbWcjYavgedSdncxhA7cfnG+rGSh7Hw2Q
 kRHMkLpFiskYA4IvAo6XdG7QB0UW8Vv5g0Txv9WmdmH/xp8sCTCWKgHvOm8YtGzd6woosBI6m7I
 TbmGBVTjaLpCleEGH9aWziCSZOkhv6iKj8VmRbB/qzDX8upFKzXS2/L6eluINyIpgob51myZv2f
 X2hfaJy
X-Google-Smtp-Source: AGHT+IGF0FqVswQ4ZbBSxEZB0PCVQ+1akEx7OGLeiSEDRD6kMimC7DI67XKgvoKQneLJLj8qU+4EhA==
X-Received: by 2002:a05:6000:2007:b0:42b:396e:2817 with SMTP id
 ffacd0b85a97d-432c37c86c2mr23543910f8f.40.1768223586520; 
 Mon, 12 Jan 2026 05:13:06 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df9c5sm39635162f8f.22.2026.01.12.05.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:13:06 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: eugen.hristev@linaro.org, trini@konsulko.com, sjg@chromium.org,
 hs@nabladev.com, u-boot@lists.denx.de
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 2/4] dm: platform_data: atmel_serial: fix build warning on
 64-bit platforms
Date: Mon, 12 Jan 2026 14:12:40 +0100
Message-ID: <20260112131258.182173-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112131258.182173-1-robert.marko@sartura.hr>
References: <20260112131258.182173-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Pointer size cannot be assumed to be 32-bit, so use uintptr_t instead of
uint32_t.

Fixes the below build warning on 64-bit builds:
drivers/serial/atmel_usart.c: In function ‘atmel_serial_probe’:
drivers/serial/atmel_usart.c:275:23: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
  275 |         priv->usart = (atmel_usart3_t *)plat->base_addr;

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 include/dm/platform_data/atmel_serial.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dm/platform_data/atmel_serial.h b/include/dm/platform_data/atmel_serial.h
index 5d142693640..96da6f50287 100644
--- a/include/dm/platform_data/atmel_serial.h
+++ b/include/dm/platform_data/atmel_serial.h
@@ -8,7 +8,7 @@
 
 /* Information about a serial port */
 struct atmel_serial_plat {
-	uint32_t base_addr;
+	uintptr_t base_addr;
 };
 
 #endif
-- 
2.52.0

