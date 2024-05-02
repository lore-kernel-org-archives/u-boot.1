Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5187C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:40:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADB8788CD0;
	Thu,  2 May 2024 03:33:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RQ7gDLlu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8C7688CA2; Thu,  2 May 2024 03:33:49 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45AF688CC1
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:33:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-43692353718so48067701cf.0
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613626; x=1715218426; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dnNuvpUxlgYlMb94jIYMWg3LneSZiMMn2nlUJn5/m40=;
 b=RQ7gDLlucuykbOgVMGQpeJFJGxuBHy0kIuIjQhm8OsiwcgEsyl5bwNJlrcS8La1cWB
 ZcnWfQGoRSTBIDx87Vo2HYg+/fJoKtrwqcYvKgNoJNhjz1nXVptUPB5+auZ+0rx02bB7
 fhmQLlDnIgLyxxjUz0jBN/p40KlJ6A3OzPbvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613626; x=1715218426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dnNuvpUxlgYlMb94jIYMWg3LneSZiMMn2nlUJn5/m40=;
 b=KFKIgrDVnj0IYmtASYpNarMGAbusyf52nBUkYRjZzfpGrmzqOYv3UBfdKoj+p95ACR
 eiXztlBQB16ScyewphozrJxijqyh4w1RHCLOmufZQV7D/41KvMJIJCirz5uVhB/p+YEO
 JGGfMzsbA+JEgXzidFF6fBRPcxgogw3T7TMpwlLLK75FtSVhjHuP9FUlrmOrBFuMwL+T
 nKIYyTcb3m9hXFxfYxSOlXK4TCqtbjtT1cicjwvgbip/Iw91TelwQPrELrQekp7qGpka
 NVOTl0SBQ4n6EedETas6n8d+Ocf0nDaG87UAJCIbyoaIN9DyQVsLXqIkyC1qbWdSKA4n
 vveg==
X-Gm-Message-State: AOJu0YwK2LoAm9Kb5iRe1f/tAHLSGRcMkph8W7zOS81tZ1E8F2nPmJGD
 IJV57hQwM3qzmovZfskNnlQzvNGgAGOGOzTTFNgmfhkeINoCwxSFDYwSqFXMn4oT7elnOknt5X1
 gAAW7Yhor
X-Google-Smtp-Source: AGHT+IF7lOGkmTUX24RnKxThr5oAKsPd6ixbRxQ5cU+81nRqtRYhpZ138aPowKzK9mNeolbsNTpFLg==
X-Received: by 2002:a05:622a:202:b0:43a:e2da:2b78 with SMTP id
 b2-20020a05622a020200b0043ae2da2b78mr5086439qtx.29.1714613625628; 
 Wed, 01 May 2024 18:33:45 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.33.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:33:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH 64/81] sound: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:31:21 -0600
Message-Id: <20240502013138.2383421-64-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
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

Remove <common.h> from this driver directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/sound/broadwell_i2s.c   | 1 -
 drivers/sound/broadwell_sound.c | 1 -
 drivers/sound/codec-uclass.c    | 1 -
 drivers/sound/da7219.c          | 1 -
 drivers/sound/hda_codec.c       | 1 -
 drivers/sound/i2s-uclass.c      | 1 -
 drivers/sound/i8254_beep.c      | 1 -
 drivers/sound/ivybridge_sound.c | 1 -
 drivers/sound/max98088.c        | 1 -
 drivers/sound/max98090.c        | 1 -
 drivers/sound/max98095.c        | 1 -
 drivers/sound/max98357a.c       | 1 -
 drivers/sound/maxim_codec.c     | 1 -
 drivers/sound/rockchip_i2s.c    | 1 -
 drivers/sound/rockchip_sound.c  | 1 -
 drivers/sound/rt5677.c          | 1 -
 drivers/sound/samsung-i2s.c     | 2 +-
 drivers/sound/samsung_sound.c   | 1 -
 drivers/sound/sandbox.c         | 1 -
 drivers/sound/sound-uclass.c    | 1 -
 drivers/sound/sound.c           | 2 +-
 drivers/sound/tegra_ahub.c      | 2 +-
 drivers/sound/tegra_i2s.c       | 1 -
 drivers/sound/tegra_sound.c     | 1 -
 drivers/sound/wm8994.c          | 1 -
 25 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/sound/broadwell_i2s.c b/drivers/sound/broadwell_i2s.c
index 7f754e656761..bc44b5ec7e1f 100644
--- a/drivers/sound/broadwell_i2s.c
+++ b/drivers/sound/broadwell_i2s.c
@@ -9,7 +9,6 @@
 
 #define LOG_CATEGORY UCLASS_I2S
 
-#include <common.h>
 #include <dm.h>
 #include <i2s.h>
 #include <log.h>
diff --git a/drivers/sound/broadwell_sound.c b/drivers/sound/broadwell_sound.c
index 6e083fe1f696..473f8d8f9771 100644
--- a/drivers/sound/broadwell_sound.c
+++ b/drivers/sound/broadwell_sound.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY UCLASS_SOUND
 
-#include <common.h>
 #include <audio_codec.h>
 #include <dm.h>
 #include <i2s.h>
diff --git a/drivers/sound/codec-uclass.c b/drivers/sound/codec-uclass.c
index 2cb233bd3060..1c1560619ea5 100644
--- a/drivers/sound/codec-uclass.c
+++ b/drivers/sound/codec-uclass.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_AUDIO_CODEC
 
-#include <common.h>
 #include <dm.h>
 #include <audio_codec.h>
 
diff --git a/drivers/sound/da7219.c b/drivers/sound/da7219.c
index c1edef443608..5b9b3f65263f 100644
--- a/drivers/sound/da7219.c
+++ b/drivers/sound/da7219.c
@@ -6,7 +6,6 @@
  * Parts taken from coreboot
  */
 
-#include <common.h>
 #include <dm.h>
 #include <i2c.h>
 #include <irq.h>
diff --git a/drivers/sound/hda_codec.c b/drivers/sound/hda_codec.c
index af6148ef7240..da8bde67de65 100644
--- a/drivers/sound/hda_codec.c
+++ b/drivers/sound/hda_codec.c
@@ -7,7 +7,6 @@
 
 #define LOG_CATEGORY	UCLASS_SOUND
 
-#include <common.h>
 #include <dm.h>
 #include <hda_codec.h>
 #include <log.h>
diff --git a/drivers/sound/i2s-uclass.c b/drivers/sound/i2s-uclass.c
index fc4f686b516d..6263c4d70719 100644
--- a/drivers/sound/i2s-uclass.c
+++ b/drivers/sound/i2s-uclass.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_I2S
 
-#include <common.h>
 #include <dm.h>
 #include <i2s.h>
 
diff --git a/drivers/sound/i8254_beep.c b/drivers/sound/i8254_beep.c
index 5572dc4d265d..7234ad4a07e5 100644
--- a/drivers/sound/i8254_beep.c
+++ b/drivers/sound/i8254_beep.c
@@ -3,7 +3,6 @@
  * Copyright 2018 Google LLC
  */
 
-#include <common.h>
 #include <dm.h>
 #include <sound.h>
 #include <asm/i8254.h>
diff --git a/drivers/sound/ivybridge_sound.c b/drivers/sound/ivybridge_sound.c
index d982219e06de..aeeba1d267ec 100644
--- a/drivers/sound/ivybridge_sound.c
+++ b/drivers/sound/ivybridge_sound.c
@@ -12,7 +12,6 @@
 
 #define LOG_CATEGORY UCLASS_SOUND
 
-#include <common.h>
 #include <dm.h>
 #include <hda_codec.h>
 #include <log.h>
diff --git a/drivers/sound/max98088.c b/drivers/sound/max98088.c
index c0463b8e8a62..d9037641ca46 100644
--- a/drivers/sound/max98088.c
+++ b/drivers/sound/max98088.c
@@ -8,7 +8,6 @@
  * following the changes made in max98095.c
  */
 
-#include <common.h>
 #include <audio_codec.h>
 #include <div64.h>
 #include <dm.h>
diff --git a/drivers/sound/max98090.c b/drivers/sound/max98090.c
index a798762f1ee7..18a3ffa85c8e 100644
--- a/drivers/sound/max98090.c
+++ b/drivers/sound/max98090.c
@@ -5,7 +5,6 @@
  * Copyright 2011 Maxim Integrated Products
  */
 
-#include <common.h>
 #include <audio_codec.h>
 #include <div64.h>
 #include <dm.h>
diff --git a/drivers/sound/max98095.c b/drivers/sound/max98095.c
index d0f701aaf105..96e772cff21b 100644
--- a/drivers/sound/max98095.c
+++ b/drivers/sound/max98095.c
@@ -7,7 +7,6 @@
  * Modified for U-Boot by R. Chandrasekar (rcsekar@samsung.com)
  */
 
-#include <common.h>
 #include <audio_codec.h>
 #include <dm.h>
 #include <div64.h>
diff --git a/drivers/sound/max98357a.c b/drivers/sound/max98357a.c
index bdf6dc236ec3..da56ffdd6bb4 100644
--- a/drivers/sound/max98357a.c
+++ b/drivers/sound/max98357a.c
@@ -6,7 +6,6 @@
  * Parts taken from coreboot
  */
 
-#include <common.h>
 #include <audio_codec.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/sound/maxim_codec.c b/drivers/sound/maxim_codec.c
index 6553d9590472..98f094c0e9ad 100644
--- a/drivers/sound/maxim_codec.c
+++ b/drivers/sound/maxim_codec.c
@@ -5,7 +5,6 @@
  * Copyright 2011 Maxim Integrated Products
  */
 
-#include <common.h>
 #include <div64.h>
 #include <i2c.h>
 #include <i2s.h>
diff --git a/drivers/sound/rockchip_i2s.c b/drivers/sound/rockchip_i2s.c
index 4e9e68aaac81..5078dfbed07d 100644
--- a/drivers/sound/rockchip_i2s.c
+++ b/drivers/sound/rockchip_i2s.c
@@ -7,7 +7,6 @@
 
 #define LOG_CATEGORY UCLASS_I2S
 
-#include <common.h>
 #include <dm.h>
 #include <i2s.h>
 #include <log.h>
diff --git a/drivers/sound/rockchip_sound.c b/drivers/sound/rockchip_sound.c
index 94058e603d7d..418d2efd4526 100644
--- a/drivers/sound/rockchip_sound.c
+++ b/drivers/sound/rockchip_sound.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_SOUND
 
-#include <common.h>
 #include <audio_codec.h>
 #include <clk.h>
 #include <dm.h>
diff --git a/drivers/sound/rt5677.c b/drivers/sound/rt5677.c
index b655bb40b642..b5c997c6dd53 100644
--- a/drivers/sound/rt5677.c
+++ b/drivers/sound/rt5677.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_SOUND
 
-#include <common.h>
 #include <audio_codec.h>
 #include <dm.h>
 #include <i2c.h>
diff --git a/drivers/sound/samsung-i2s.c b/drivers/sound/samsung-i2s.c
index dc5a2789aeed..42175fd7d28b 100644
--- a/drivers/sound/samsung-i2s.c
+++ b/drivers/sound/samsung-i2s.c
@@ -4,11 +4,11 @@
  * R. Chandrasekar <rcsekar@samsung.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <i2s.h>
 #include <log.h>
 #include <sound.h>
+#include <time.h>
 #include <asm/arch/clk.h>
 #include <asm/arch/pinmux.h>
 #include <asm/arch/i2s-regs.h>
diff --git a/drivers/sound/samsung_sound.c b/drivers/sound/samsung_sound.c
index 473cedf7e974..9150ad4a63ba 100644
--- a/drivers/sound/samsung_sound.c
+++ b/drivers/sound/samsung_sound.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <audio_codec.h>
 #include <dm.h>
 #include <i2s.h>
diff --git a/drivers/sound/sandbox.c b/drivers/sound/sandbox.c
index c6cbd81fdbce..31ae153530e8 100644
--- a/drivers/sound/sandbox.c
+++ b/drivers/sound/sandbox.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_SOUND
 
-#include <common.h>
 #include <audio_codec.h>
 #include <dm.h>
 #include <i2s.h>
diff --git a/drivers/sound/sound-uclass.c b/drivers/sound/sound-uclass.c
index 2ffc4fc7c1db..b8a3dab447d9 100644
--- a/drivers/sound/sound-uclass.c
+++ b/drivers/sound/sound-uclass.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_SOUND
 
-#include <common.h>
 #include <dm.h>
 #include <i2s.h>
 #include <log.h>
diff --git a/drivers/sound/sound.c b/drivers/sound/sound.c
index c0fc50c99dac..4fde2989e04f 100644
--- a/drivers/sound/sound.c
+++ b/drivers/sound/sound.c
@@ -4,9 +4,9 @@
  * R. Chandrasekar <rcsekar@samsung.com>
  */
 
-#include <common.h>
 #include <log.h>
 #include <sound.h>
+#include <linux/string.h>
 
 void sound_create_square_wave(uint sample_rate, unsigned short *data, int size,
 			      uint freq, uint channels)
diff --git a/drivers/sound/tegra_ahub.c b/drivers/sound/tegra_ahub.c
index 495a29c5137c..8f1b0c009a88 100644
--- a/drivers/sound/tegra_ahub.c
+++ b/drivers/sound/tegra_ahub.c
@@ -7,11 +7,11 @@
 
 #define LOG_CATEGORY UCLASS_MISC
 
-#include <common.h>
 #include <dm.h>
 #include <i2s.h>
 #include <log.h>
 #include <misc.h>
+#include <time.h>
 #include <asm/io.h>
 #include <asm/arch-tegra/tegra_ahub.h>
 #include <asm/arch-tegra/tegra_i2s.h>
diff --git a/drivers/sound/tegra_i2s.c b/drivers/sound/tegra_i2s.c
index 932f737900e4..357aac36ceaa 100644
--- a/drivers/sound/tegra_i2s.c
+++ b/drivers/sound/tegra_i2s.c
@@ -5,7 +5,6 @@
  */
 #define LOG_CATEGORY UCLASS_I2S
 
-#include <common.h>
 #include <dm.h>
 #include <i2s.h>
 #include <log.h>
diff --git a/drivers/sound/tegra_sound.c b/drivers/sound/tegra_sound.c
index aef6a2eb1475..152c929146f5 100644
--- a/drivers/sound/tegra_sound.c
+++ b/drivers/sound/tegra_sound.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_I2S
 
-#include <common.h>
 #include <audio_codec.h>
 #include <dm.h>
 #include <i2s.h>
diff --git a/drivers/sound/wm8994.c b/drivers/sound/wm8994.c
index fd646479b315..6b3091aa5de1 100644
--- a/drivers/sound/wm8994.c
+++ b/drivers/sound/wm8994.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2012 Samsung Electronics
  * R. Chandrasekar <rcsekar@samsung.com>
  */
-#include <common.h>
 #include <audio_codec.h>
 #include <dm.h>
 #include <div64.h>
-- 
2.34.1

