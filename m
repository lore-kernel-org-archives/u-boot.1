Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A69EE6428
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 14:14:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05BED84056;
	Wed, 31 Dec 2025 15:14:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="DsdA+6jF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 983618405F; Wed, 31 Dec 2025 15:14:11 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FB778401F
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 15:14:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D55813F861
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 14:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767190448;
 bh=Kk5RSo/GTX0k7kJIyvqc8aLO/cfxDyqGKng8pxbp1io=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=DsdA+6jFKI0GkVOrBCfVmgo37E30E/uIY/m4HmlPbEPcMWV6YdLB+Y50Bb1WHn4RH
 PMktbQPpPXVwc9NEV5+Icl0M8fmTFMHg3sJFKqWCzNKRl+wI7VsMdDSlJ7E4lUNaTD
 69/5SCf3PY7SAUKjWdQtNnPJmQKYCV8KkTHv1ZdL3VVS33FpW2PCoIrxVVoed/fEIc
 pAkkDXYc6hZy+jOyBG5P/iUz/0ZrvH4RLN3QpsnP2S6AQpFpW/UNIXHTYlMxGlS3/l
 aCjfdVIcw3qAUwMbFNPA8aVHiEuUcP4vzcDAAqxc1KP1ES9c5iJ+z2AwXyvPPZLpHG
 RjN35zwZbD8aJoUIcgAuXbJBKPsXPEHhI62UlVljgCl6kAmk55V4LoYo2mEL3NMUPI
 Tmo1qQbxg1XmQKPuabvYjvwkBOriCmiJEz//9Bj/qtt6WncurOBpYvGs4ClTgmQMoc
 jyVCvGW8sbBuvWhXkxYtvZBOi3vBXQpPLIzuAtZ957NMZaKYw6h3yEFDYUwRbMbCEx
 dV2oprMQWL+xYjcH0L0+VZuGBNkwWT9rjK+ppzSu9J7Fxuee/JAWRaLMm9RQVKg3NG
 zMcFAV37Xdwtq1jnL8a6zU3gMHb+cx5IGJWUnWza52rFqWz6cKVhUub+qdT0lzInfx
 /GG8v0Qi5X3CI1ajoB+AncIo=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4779ecc3cc8so77651725e9.3
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 06:14:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767190448; x=1767795248;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kk5RSo/GTX0k7kJIyvqc8aLO/cfxDyqGKng8pxbp1io=;
 b=ZslPtfvuJDaREtgYLTG44ayTFQQ5y2GvCFSDuEuL1KISWxLETSXWHVxeKOjCCMCbif
 qteMnPRaV+Jh1g5ij3f0bc5Sf90bZCM5EF9uJ0HZj1+YO9Af3RACu7G0cIWju92z0/cx
 WiS7wAjVmIAhSb1W913ASEZeCYfhbDoruc6sb3FPmB2hdXzociJhrFiiBixRocAiCMeJ
 aKi/zlNTmp9/VOzaOScdXFBMwbotw8Uxz/7Zc/2pxfPDRiC3xlPd3XLxcw6L1ztV0/kw
 vagnt4YFr714hX17iAyZw0195Xwko9BaklUYGtcetcKN1/6ZmVj8j0LhkGL36kOU0SIQ
 zLvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr1BLJHa1ffLbYP3+o8MIr0uyr9QVS70q3ZwAJoGUJ+/WQjSSVx/ZCgyYiuNeFTbmV6uc3eJg=@lists.denx.de
X-Gm-Message-State: AOJu0Yygg9vp/+bGB/M5c9SfqRzeGKVkMV/hFVnu7x1MZzbsQTQq+s2z
 oHqliAFyXHRrawtBJkKUxaa4P1If79vcPl8VN1apyUrtF+6tBgkMfdkCOLn7rwCiGvSka4DMQ13
 r+hNr0U2VArufSXzXsDIkt2fwr40y4Vc0ZJsmT/zm6c1dTL9Qox4lLWWPzZkB7VQVOBXp12A=
X-Gm-Gg: AY/fxX4oWOXN9LRiBbAtpu0cF/ODEL/bq8VE8kNDRMItKdYit4yRjHgbrVuhcBAySWo
 SBOFSNQjPvaKaGFHWWr/n95BVobQz1dBvkCfdjGlnN2rZ3yZcv5sH8EeiQjoXh73CT/Vop6hqD2
 kEluo8obdbOByIjYwGTIOK1cqZicrC60gYElqs2/VX4cM14Z9N2qtgK1GEKiDZd7l8OsAaAeX9m
 PC43mb1n2ZOM6wZPHkJpy4bVcbvZUp1tEv/NPO7Cv3RBWyaBTC+K6c62CtjRqCuhpgv6ky7VCDv
 f9QNKGg3Crmbheyoxo2axaF4x1MhXZaeqhoW3Fsz4eAwZhjXfUgu2E0JcDQ0XCaglDuyTQ5PduA
 hTPutCgWBCkJ9BMJ4HCZ5JUPl/TN0LcJksZhqynQAWI3RTTbtFqKcj6ajZ/Th54/dmrhOUnpFHr
 mG
X-Received: by 2002:a05:600c:8107:b0:477:6374:6347 with SMTP id
 5b1f17b1804b1-47d19594ce3mr429322595e9.22.1767190448258; 
 Wed, 31 Dec 2025 06:14:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/FBDB/RlaHNO1apuQmNok9m6J0eKxqgBrtJlfJOHGiB1Wq3jDyWacfoALqNHxOEBiE0ZnmA==
X-Received: by 2002:a05:600c:8107:b0:477:6374:6347 with SMTP id
 5b1f17b1804b1-47d19594ce3mr429322185e9.22.1767190447867; 
 Wed, 31 Dec 2025 06:14:07 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d28a33adcsm213457085e9.18.2025.12.31.06.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 06:14:07 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Anatolij Gustschin <ag.dev.uboot@gmail.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Ion Agorria <ion@agorria.com>,
 Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] video: menu "TrueType Fonts" depends on TrueType enabled
Date: Wed, 31 Dec 2025 15:13:44 +0100
Message-ID: <20251231141344.64052-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

The Kconfig menu "TrueType Fonts" should only be shown if TrueType is
enabled.

Put all TrueType dependent customization within one if statement.
Remove `depends TRUETYPE` clauses.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/video/Kconfig       | 10 ++++++----
 drivers/video/fonts/Kconfig |  4 ----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 0fc1c161541..566942e16f3 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -211,9 +211,10 @@ config CONSOLE_TRUETYPE
 	  With this option you can adjust the text size and use a variety of
 	  fonts. Note that this is noticeably slower than with normal console.
 
+if CONSOLE_TRUETYPE
+
 config CONSOLE_TRUETYPE_SIZE
 	int "TrueType font size"
-	depends on CONSOLE_TRUETYPE
 	default 18
 	help
 	  This sets the font size for the console. The size is measured in
@@ -226,7 +227,6 @@ config CONSOLE_TRUETYPE_SIZE
 
 config CONSOLE_TRUETYPE_MAX_METRICS
 	int "TrueType maximum number of font / size combinations"
-	depends on CONSOLE_TRUETYPE
 	default 10 if EXPO
 	default 1
 	help
@@ -239,6 +239,10 @@ config CONSOLE_TRUETYPE_MAX_METRICS
 	  font metrics which are expensive to regenerate each time the font
 	  size changes.
 
+source "drivers/video/fonts/Kconfig"
+
+endif
+
 config SYS_WHITE_ON_BLACK
 	bool "Display console as white on a black background"
 	default y if ARCH_AT91 || ARCH_EXYNOS || ARCH_ROCKCHIP || ARCH_TEGRA || X86 || ARCH_SUNXI
@@ -309,8 +313,6 @@ config PANEL_HX8238D
 	  It can drive a maximum 960x240 dot graphics on a-TFT panel
 	  displays in 16M colors with dithering.
 
-source "drivers/video/fonts/Kconfig"
-
 config VIDEO_BOCHS
 	bool "Enable Bochs video emulation for QEMU"
 	help
diff --git a/drivers/video/fonts/Kconfig b/drivers/video/fonts/Kconfig
index c692fa9602f..5233a277bbd 100644
--- a/drivers/video/fonts/Kconfig
+++ b/drivers/video/fonts/Kconfig
@@ -6,7 +6,6 @@ menu "TrueType Fonts"
 
 config CONSOLE_TRUETYPE_NIMBUS
 	bool "Nimbus Sans Regular"
-	depends on CONSOLE_TRUETYPE
 	default y
 	help
 	  Nimbus Sans L is a version of Nimbus Sans using Adobe font sources.
@@ -20,7 +19,6 @@ config CONSOLE_TRUETYPE_NIMBUS
 
 config CONSOLE_TRUETYPE_ANKACODER
 	bool "Anka Coder Narrow"
-	depends on CONSOLE_TRUETYPE
 	help
 	  The Anka/Coder family is a monospaced, courier-width font for source
 	  code and terminals, in two styles and weights. Anka/Coder Narrow was
@@ -32,7 +30,6 @@ config CONSOLE_TRUETYPE_ANKACODER
 
 config CONSOLE_TRUETYPE_RUFSCRIPT
 	bool "Ruf Script"
-	depends on CONSOLE_TRUETYPE
 	help
 	  A laid-back handwritten font.
 	  Font: https://fontlibrary.org/en/font/rufscript
@@ -41,7 +38,6 @@ config CONSOLE_TRUETYPE_RUFSCRIPT
 
 config CONSOLE_TRUETYPE_CANTORAONE
 	bool "Cantoraone"
-	depends on CONSOLE_TRUETYPE
 	help
 	  Cantora is a friendly semi formal, semi condensed, semi sans-serif
 	  with a hint of handwriting. Perfect for headlines.
-- 
2.51.0

