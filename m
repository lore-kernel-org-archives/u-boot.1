Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8C9C83038
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 01:05:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4BF582CFA;
	Wed,  2 Jul 2025 03:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BHXT1jJ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4115E82103; Wed,  2 Jul 2025 03:04:28 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 210C082FE1
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 03:04:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-40b54ee16ddso1888539b6e.1
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 18:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751418265; x=1752023065; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=FYQzl36XBxYwmvbqzgc2Kxro0MxR9zWsmp93cVOYyZI=;
 b=BHXT1jJ54sK/jV6gB1sSMAS07doyuS37N3Wl3TMGkSb1mnodZaGKS3Tthbk/U4+TfE
 qZbX3EQSYkXEnBB140P+8bIA3nMHKLf1Cd9Bpgj/ALsmsznKlvkK0Fy3HeX/+R1fYxJ5
 Q8ZySJpZJ2WhsAArEaNIgNGu/niOAtW/sjwmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751418265; x=1752023065;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FYQzl36XBxYwmvbqzgc2Kxro0MxR9zWsmp93cVOYyZI=;
 b=hBkMiMNfezzFKZUuHO5wcaqakTQMHKylAw6duC1T0RiDbqwlHf8PeZL5zJyPBwKsF+
 6jUhIKxJB/II6lfAMR3op7rKJxGPgCZdx8l0G9bFcYLjz70a17gZ4eKnWkE+QdiEmmLA
 7T4ca3ntXGHNG20Y6OV2oL/zg+Ti1tX/AZiuQZ4E9rEJ1Ty48bY0VHoKHLIGpmu3H8yz
 BUSz62mwAuDptjpDaIFSzFBK2SPb4OzhgwhsauVEd1BgjDoKXEXgrUQz85ZVC5Fs5PRB
 OVMXO8cqrQYT5XvyH8gjrKqqN0lQ4DvC/WXiD6k/ANbo0EcJ8wghC7rPnKQttj0+xshw
 0Ubg==
X-Gm-Message-State: AOJu0YxP63jNxvjoOgwuem1rMJbE6NiprKxfo8gceHZlEbApj/UcmvGr
 oHGT92kJluR7aznExTvjerbR8wN8YN8/B8fE7TNbfZRvUMr40DuJyOEeGhBjwbsJUykQSPf9Azq
 sW+/KZbA=
X-Gm-Gg: ASbGnctnUsw8CA5HDxc3oRt5y8ioTegTzXSt/6BvjyBLEEvJraHw8Y6Oa4G7QmilACu
 AzNRYt92WCGC7M37SjD/GEatNiNZ2o+2OlDSnuCOsyGaCEvcApfLrI9pGObgOPywLhIbjJYMrts
 +fTvFOfKXNFJXkbw0IyX9J3Sa7ugRsT5C8ne3IORLje8tXwBAK+z+S6S+8GDj1K5CaZShG6P03t
 P2pqkoJJUi1KbJRkft//y4K1hZIImsthNl3sm17mACvMqTLCnYgy6B3HuiWG0xfjh6TyXKaPXJm
 83SELBygXcmMwf2MoHjxWsIJ2wawUMx3xezEnZsxxOisSL6g8nwP5qqxpEXguRaQeAOHPxmJgdv
 /0xRZjmWmbp9q7jdqr3475xQ=
X-Google-Smtp-Source: AGHT+IF+lUV5uXGIqlQQ9nl0no7zCYde98Vj2G0CmCZ0LtaEt2isFQ0D2vfZuSQ45dLwjRGmPLtmzQ==
X-Received: by 2002:a05:6808:4f65:b0:40b:4230:387f with SMTP id
 5614622812f47-40b89137d1fmr574651b6e.32.1751418264735; 
 Tue, 01 Jul 2025 18:04:24 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b32438b2dsm2318171b6e.45.2025.07.01.18.04.23
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 18:04:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] crypto: aspeed: Tighten some dependencies for the aspeed
 platforms
Date: Tue,  1 Jul 2025 19:04:22 -0600
Message-ID: <20250702010422.18911-1-trini@konsulko.com>
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

Some of the aspeed platform drivers cannot build without platform
specific headers being available. Express those requirements in Kconfig as
well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/crypto/aspeed/Kconfig | 4 ++++
 drivers/crypto/hash/Kconfig   | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/aspeed/Kconfig b/drivers/crypto/aspeed/Kconfig
index 6efcd7da7382..401225b8528d 100644
--- a/drivers/crypto/aspeed/Kconfig
+++ b/drivers/crypto/aspeed/Kconfig
@@ -1,3 +1,5 @@
+if ARCH_ASPEED
+
 config ASPEED_HACE
 	bool "ASPEED Hash and Crypto Engine"
 	depends on DM_HASH
@@ -38,3 +40,5 @@ config ASPEED_CPTRA_ECDSA
 
 	  Enabling this allows the use of ECDSA384 signature verification in hardware.
 	  Note that only ECDSA384 is supported by Caliptra.
+
+endif
diff --git a/drivers/crypto/hash/Kconfig b/drivers/crypto/hash/Kconfig
index aa355c44be85..72b955ac791a 100644
--- a/drivers/crypto/hash/Kconfig
+++ b/drivers/crypto/hash/Kconfig
@@ -18,7 +18,7 @@ config HASH_SOFTWARE
 
 config HASH_ASPEED
 	bool "Enable Hash with ASPEED hash accelerator"
-	depends on DM_HASH
+	depends on DM_HASH && ARCH_ASPEED
 	select ASPEED_HACE
 	help
 	  Enable this to support HW-assisted hashing operations using ASPEED Hash
-- 
2.43.0

