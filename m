Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86D6C87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 14:57:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E59284284;
	Wed,  6 Aug 2025 16:56:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AuhcfS4+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA7D183AB9; Wed,  6 Aug 2025 16:56:42 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F1DF8341C
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 16:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-43404e99955so30521b6e.0
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 07:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754492199; x=1755096999; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BhejirA81u67Zrk5s5SEn/tHGcJmu4KuklUfGXPjJyQ=;
 b=AuhcfS4+CK1tzGZPgXdBGyvVLhXf6jQH4gGsg6tlFYjfXe22XBe9wfzqM4CmetFM8r
 qMHVHfcWtJceHKLwkZhFpmejgooHHCH2zkgoNKzOAQBDcBTk60g+yvNidjYImPbb7+BG
 hfvTgd0i9cNLZqmXMQlPNLp3GxCQenUd9ZJzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754492199; x=1755096999;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BhejirA81u67Zrk5s5SEn/tHGcJmu4KuklUfGXPjJyQ=;
 b=f9eq1mP3IAMF+a31rWYKjukylWWMdXyWZBssu6fptQtJpW1yYzojUzF1iacEZJVAda
 P0JROP2MU745vwRXNEfjQlUYOIVYyfAno2VHe0gr/KD2g7O/BcBRFy7ooVO8gM+lxYHR
 fqCrsZG1T9/C8lvvsN5vdhuyyXmU0dZjGBfEnJL+IZINdO028MuXG0t1h1cGFMqzMcdI
 fZvCRhYYraXc392L9ccVIx24NnHnzIqq9spKXsN0v32TQ/4TNExmEKoZDStXsDqmxKRq
 bm5+ExjLvrt0XouttKuCSY7c41nOnHpxGa0lw7/10T4O4b3sMixXiNs7WjI8e91Qbmk4
 bHBQ==
X-Gm-Message-State: AOJu0Yw46LMsvmqfBZNMzTeKMeyyAGygz08ptiiCkKHnI7Ofp0Otz31s
 Pcum0nzhkkQNNRDCYjI2LlMyaGnwHyOQzwRIJJlwxUe6vYviZLMtsKC4PjlgaLWOoHy539/lKtb
 r0GhUAlo=
X-Gm-Gg: ASbGncvEa63oPTk+FyeVhNIsbNOS3DMcJnP8D5XMKxGrZ07c6A/6VcYQFYQMlTT7jEP
 LvDaguIOsBnlVtL89FTAIcoNSs7pM85R9g1UMQrgzu8XWzvy9FUSkGLzZixyKl284TS5F6dBNIz
 VO37HMxLJpujDinXR62/9GebPaxKVCbAurPqpa1S/FaL/2wR0q9xs/J7pelbZwUM8JMnowtJfk+
 fKcWhdtW0MFLGHyuhnAD8l0pQuX57kvg9ltNTOpqM3s5fYlf2zvHcnO6Yu5HvoyYs8Uf3h40RGK
 FvgECubJvnfUFP4JcIN130YIsfZ9L30fNKrVoQmkUc97PAVYW2+FXUf8ESBsY4T9G0yBxT30W5C
 9ZAN2hd5Vl+2Bgu67yO40Eqc291Td8HMZbPCypBoU6jlqz1mTMGbGJaCRR2Y=
X-Google-Smtp-Source: AGHT+IHh6UODYYZ08aZmVn4JazZRBCrLjHXyh73ecsJrWKAKrJ0RBaBXtrfoHPO3TlRV6F3rdnBxmw==
X-Received: by 2002:a05:6808:21a7:b0:426:6b0e:e999 with SMTP id
 5614622812f47-4357c614f44mr1529971b6e.29.1754492199093; 
 Wed, 06 Aug 2025 07:56:39 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-434140390e9sm1071299b6e.17.2025.08.06.07.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 07:56:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>
Subject: [PATCH] watchdog: Tighten some watchdog driver dependencies
Date: Wed,  6 Aug 2025 08:56:37 -0600
Message-ID: <20250806145637.1664675-1-trini@konsulko.com>
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

A few watchdog drivers cannot build without access to some platform
specific header files. Express those requirements in Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Stefan Roese <stefan.roese@mailbox.org>
---
 drivers/watchdog/Kconfig | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index e9ea874d0e3d..463f9249c611 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -43,6 +43,7 @@ config HW_WATCHDOG
 
 config IMX_WATCHDOG
 	bool "Enable Watchdog Timer support for IMX and LSCH2 of NXP"
+	depends on MACH_IMX
 	select HW_WATCHDOG if !WDT
 	help
 	  Select this to enable the IMX and LSCH2 of Layerscape watchdog
@@ -64,6 +65,7 @@ config OMAP_WATCHDOG
 
 config ULP_WATCHDOG
 	bool "i.MX7ULP watchdog"
+	depends on MACH_IMX
 	help
 	  Say Y here to enable i.MX7ULP watchdog driver.
 
@@ -116,8 +118,8 @@ config WDT_ARMADA_37XX
 
 config WDT_ASPEED
 	bool "Aspeed ast2400/ast2500 watchdog timer support"
-	depends on WDT
-	default y if ARCH_ASPEED
+	depends on WDT && ARCH_ASPEED
+	default y
 	help
 	  Select this to enable watchdog timer for Aspeed ast2500/ast2400 devices.
 	  The watchdog timer is stopped when initialized. It performs reset, either
@@ -127,8 +129,8 @@ config WDT_ASPEED
 
 config WDT_AST2600
 	bool "Aspeed AST2600 watchdog timer support"
-	depends on WDT
-	default y if ASPEED_AST2600
+	depends on WDT && ASPEED_AST2600
+	default y
 	help
 	  Select this to enable watchdog timer for Aspeed ast2500/ast2400 devices.
 	  The watchdog timer is stopped when initialized. It performs reset, either
@@ -136,7 +138,7 @@ config WDT_AST2600
 
 config WDT_AT91
 	bool "AT91 watchdog timer support"
-	depends on WDT
+	depends on WDT && ARCH_AT91
 	help
 	  Select this to enable Microchip watchdog timer, which can be found on
 	  some AT91 devices.
@@ -173,7 +175,7 @@ config WDT_CDNS
 
 config WDT_CORTINA
 	bool "Cortina Access CAxxxx watchdog timer support"
-	depends on WDT
+	depends on WDT && TARGET_PRESIDIO_ASIC
 	help
 	  Cortina Access CAxxxx watchdog timer support.
 	  This driver support all CPU ISAs supported by Cortina
@@ -219,7 +221,7 @@ config WDT_MAX6370
 
 config WDT_MCF
 	bool "ColdFire family watchdog timer support"
-	depends on WDT
+	depends on WDT && M68K
 	help
 	  Select this to enable ColdFire watchdog timer,
 	  which supports mcf52x2 mcf532x mcf523x families.
@@ -303,7 +305,7 @@ config WDT_OMAP3
 
 config WDT_ORION
 	bool "Orion watchdog timer support"
-	depends on WDT
+	depends on WDT && ARCH_MVEBU
 	select CLK
 	help
 	  Select this to enable Orion watchdog timer, which can be found on some
-- 
2.43.0

