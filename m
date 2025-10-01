Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09365CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 20:31:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C387835B3;
	Wed,  1 Oct 2025 22:30:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CTHQXI3I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 929548361E; Wed,  1 Oct 2025 22:30:42 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76BAF8349B
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 22:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-35acca93e00so242624fac.2
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 13:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759350639; x=1759955439; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1QimOZmigLiidcG6jTTosoeAJu2ZRLF8PN2+3SH9Sw4=;
 b=CTHQXI3ITSrioOyEZHIp8RKosUQwDsDT2xZLwvVlIPHWc0scO335KhhGRdSPwDOo82
 JoqjwjrDYeeYSkPxjUTP/AWFpM+VRBUeGSpkS9Wa7mYsSLwEKtKVcWSvugx67xBB8vUH
 oMcgNv3PRUQ2r9JRu3TXvHFJo5n7RqesTJQdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759350639; x=1759955439;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1QimOZmigLiidcG6jTTosoeAJu2ZRLF8PN2+3SH9Sw4=;
 b=L3iaMGaPXhoACsWOlqWnSdyUf9tH53X3mHvRlKfyUS+sRBZkQpcDUsQOr2FNkTOava
 CFtyOtg3I+5tHm1uuBYC68dIzfOn2cwetcOuSxDKC2zsvrS4lH/w5YyaJbvvVM9Euqho
 VdyymfLP9XViSBXx2mRkJ7M+X1G5Iza22OX3QgczM9dkOZstW7zPCgSJ/A5MBZcJFJLz
 wCi7a06q/fbdp0yGntq/0zUtJnypY80B3CWmJrjCZn7vdoqOfCGbaPMdq1g5Y+pXcTGe
 aunjEWj9M31QKYTw51b2rSvUL9mg8U3nkp26jtV3mWuoZniaHfh1qiwtbMomcnHMGbqT
 Tu/g==
X-Gm-Message-State: AOJu0YzTE0KkYzZjRDyggoKikppQoTaUXtwxKG+BSV1O3D6Wnz7WBIzF
 s5qeza/nxypMvTvKOtuIHhzb9nm3JaXFYJ4AeoKKIUeNStWUPsGPJP04s6egYbu0T5ojO8mhTep
 XXEpfXII=
X-Gm-Gg: ASbGnctkhWNp+RxP+50bGiGvj4DCqwHB2t1GetTJ8gUDQfd9o2kZYFcrMpjOeA5pwhq
 h54lq/jLncnYcJ6h4HB9p2wx0MD70Id7Xnhen6anvfftec12nOUPxN59hvIXs+xi3AaiWzvdbQj
 9LEIAUrgKCILrMAOLWT0xFHnkKQxOydFUbSYqyNfan7+PInbWItd/mWBwc8GztiJa4C2Hc8Yd6s
 DPhVDHz9A3rKc7LitHUINlAGaGEnB8cpYFHChBDhMVt4oYgnisxGWsg6bnPARnk/OqfReMocv9l
 +eDObHzRDoG7Wh9CQBDA9KjdOvRB6oPawf4YxTCSWK9gtlHELYHhvdTmsdLKkyMMiGje4nkMYwU
 Jrsbp1cig0PDlX9FCW0oIqJjd7Yl7lVoTlgoBM5I4kDzIWEUKwNKZUeVpAQwxn56DSXDCHH5C5K
 WPjhp+b40=
X-Google-Smtp-Source: AGHT+IEGoD43OZrZsCiAwDzEAfCCulGJ9waA347arQXj7vEpc1R4/HRiZ7MTCVy/iSgQkS+HiGPv0Q==
X-Received: by 2002:a05:6870:8108:b0:2ff:8c8e:c222 with SMTP id
 586e51a60fabf-39b90fea260mr3407202fac.14.1759350639109; 
 Wed, 01 Oct 2025 13:30:39 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ab8df14250sm214977fac.18.2025.10.01.13.30.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 13:30:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Durai Manickam KR <durai.manickamkr@microchip.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Manikandan Muralidharan <manikandan.m@microchip.com>,
 Ryan Wanner <ryan.wanner@microchip.com>,
 Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH] timer: Tighten dependencies on MCHP_PIT64B_TIMER
Date: Wed,  1 Oct 2025 14:30:37 -0600
Message-ID: <20251001203037.2828258-1-trini@konsulko.com>
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

The MCHP_PIT64B_TIMER driver is not safe to compile on 64bit platforms
such as allyesconfig on a 64bit host. Tighten the dependencies here to
the platforms which use it today.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Durai Manickam KR <durai.manickamkr@microchip.com>
Cc: Eugen Hristev <eugen.hristev@linaro.org>
Cc: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: Ryan Wanner <ryan.wanner@microchip.com>
Cc: Mihai Sain <mihai.sain@microchip.com>
---
 drivers/timer/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/timer/Kconfig b/drivers/timer/Kconfig
index 5cac1dcf2be9..f9511503b027 100644
--- a/drivers/timer/Kconfig
+++ b/drivers/timer/Kconfig
@@ -312,7 +312,7 @@ config MTK_TIMER
 
 config MCHP_PIT64B_TIMER
 	bool "Microchip 64-bit periodic interval timer support"
-	depends on TIMER
+	depends on TIMER && ARCH_AT91
 	help
 	  Select this to enable support for Microchip 64-bit periodic
 	  interval timer.
-- 
2.43.0

