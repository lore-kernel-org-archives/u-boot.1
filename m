Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EFAC48297
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 08:58:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24FCE87E41;
	Fri,  9 Feb 2024 09:58:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="J/fYNh0P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4933A87E43; Fri,  9 Feb 2024 09:58:41 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33C0287E40
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 09:58:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33b189ae5e8so244651f8f.2
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 00:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707469118; x=1708073918;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=posx/ZxBxswvvlLYAmXzcIYEnem1fOJ4oCDk/8BThCU=;
 b=J/fYNh0PbQbTJyfFouQhVUGUxbycMF9gu8lyj3MsspGmpSZN+tzV8ynoso0MbUWvoJ
 NIWfWTOAPQ5mELEfb77BDoKcE7U2kIjneFswwZvYJjVVUQ8IQ0K4E7aJ9L/LLsEfp78K
 w/+orVJ7KTez+k/M5tnLShljNPHhQK+zB3663qmW6KwhVRvpUOufiKVcKcyNgTO7ntPu
 nQdw3zuKosZ+jg/5N3KIpbTDVwPjK1t+vR5OabrRdDQOHVg3bv4lmKKr3jvVVRY5XFP4
 DPYuhtCpqYcPrwjd3C/ZYWZ06hYVTYijHv8xO+0mzTDCq/GEJ4qHY4jiP7Q+7Ww+v5KY
 51IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707469118; x=1708073918;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=posx/ZxBxswvvlLYAmXzcIYEnem1fOJ4oCDk/8BThCU=;
 b=KIX2HoEcbWELOx7yJhVfBdtGyg2FYhRpRr4+HEc63KEbTSsL5nPW9W/ZMD0C9D6GR7
 0zcwFgTR1GxDKDEAgX2BJF04do92Wp/RyVqjgngBVTYL2GzYO0cOkFinmyPOvJ2BepOJ
 Iq+IYTXZlEIrKA9LMfVBX92sgQ+vNjBsH+yjSplgJe8JjXNYGWyxvJzDdjEDAa5AtITE
 JExTO+eeBMGnvXfLBbZzxng+qFrMiUKG4aqCOksBIQz8yynKKoWcfx3FLQ/UvARf5WCE
 /ythARgJ2CWXK0tJsltnKGmIpZJVmp9eq+BW6mjx5Vxwxb0lN0kW4MuUd4tYJMKxtbIA
 0PtQ==
X-Gm-Message-State: AOJu0YxAj3pmw8w+ScxjtNTEJeBAMZlQh4j1HBVTIBkuJvzoTMNYr+gX
 DUrYFvUsjC9Q7k0CRWtctLfZJ8PXbR0Q4PAPwF4mOPFW41PUyZhfymhHCdhuf8On9YRpr7V6eJs
 6
X-Google-Smtp-Source: AGHT+IGJ0rVata0KzDrNxRJORGGH1vmaiKugNhbRKNMrU0DFOAW3j2HgrdoCpEaT6cMWOQ6V0acIUQ==
X-Received: by 2002:adf:fc12:0:b0:33b:178a:6715 with SMTP id
 i18-20020adffc12000000b0033b178a6715mr628184wrr.24.1707469118511; 
 Fri, 09 Feb 2024 00:58:38 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXISbMGR5gasCj1D1pIsYAFgikNaPepnKxmW19tg3AvecjjGER3rcVapNhRMl+u7l68oXTpphCHKlIoz+E/s65ctXL6qVYz1ZhPLdiAzcZnEShJfhAtEdoBlz7Y17NfKnPjo8azQYxGq4BcBzn/UPe/6LqIeuIOxsu5
Received: from [192.168.1.26] ([2a01:cb19:95ba:5000:2b24:7f52:e3f6:e4ef])
 by smtp.gmail.com with ESMTPSA id
 o9-20020a05600c4fc900b0040e9d507424sm1937159wmq.5.2024.02.09.00.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 00:58:38 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Fri, 09 Feb 2024 09:58:35 +0100
Subject: [PATCH] configs: khadas-vim3*_android: fix AVB oom error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-vim3-avb-malloc-v1-1-91427d8c19ab@baylibre.com>
X-B4-Tracking: v=1; b=H4sIADrpxWUC/x2NywrCMBAAf6Xs2YWYVEF/RTxskrVdyEOSGoTSf
 2/a48AMs0LlIlzhOaxQuEmVnDpcLwO4mdLEKL4zaKVHpdUDm0SD1CxGCiE7JDKeb2b0d1LQK0u
 V0RZKbj66H9qcF6QY8iTuEL6FP/I/l6/3tu3H1TEaggAAAA==
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Guillaume La Roque <glaroque@baylibre.com>, u-boot-amlogic@groups.io, 
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.12.2
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

When booting Android with AVB enabled, an OOM is observed:

  => avb init ${mmcdev}
  => avb verify _a
  ## Android Verified Boot 2.0 version 1.1.0
  read_is_device_unlocked not supported yet
  read_rollback_index not supported yet
  avb_util.c:182: ERROR: Failed to allocate memory.
  OOM error occurred during verification

A custom malloc length of 128MB is required as documented in
commit 285a83b12bdf ("configs: meson64_android: increase SYS_MALLOC_LEN to 128M for AVB")

However, this 128M custom malloc length was not ported to Kconfig in
commit 7cfbba36e9f8 ("Convert CONFIG_SYS_MALLOC_LEN to Kconfig")

Add it back to fix AVB verification on VIM3/VIM3L.

Fixes: 7cfbba36e9f8 ("Convert CONFIG_SYS_MALLOC_LEN to Kconfig")
Co-developed-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 configs/khadas-vim3_android_ab_defconfig  | 1 +
 configs/khadas-vim3_android_defconfig     | 1 +
 configs/khadas-vim3l_android_ab_defconfig | 1 +
 configs/khadas-vim3l_android_defconfig    | 1 +
 4 files changed, 4 insertions(+)

diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
index b41c2660fff0..ee62fe36d414 100644
--- a/configs/khadas-vim3_android_ab_defconfig
+++ b/configs/khadas-vim3_android_ab_defconfig
@@ -3,6 +3,7 @@ CONFIG_SYS_BOARD="vim3"
 CONFIG_SYS_CONFIG_NAME="khadas-vim3_android"
 CONFIG_ARCH_MESON=y
 CONFIG_TEXT_BASE=0x01000000
+CONFIG_SYS_MALLOC_LEN=0x08000000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
index 88197f5f5e99..cecbe5061793 100644
--- a/configs/khadas-vim3_android_defconfig
+++ b/configs/khadas-vim3_android_defconfig
@@ -3,6 +3,7 @@ CONFIG_SYS_BOARD="vim3"
 CONFIG_SYS_CONFIG_NAME="khadas-vim3_android"
 CONFIG_ARCH_MESON=y
 CONFIG_TEXT_BASE=0x01000000
+CONFIG_SYS_MALLOC_LEN=0x08000000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
index 3381d2e92701..ec4e0dc72e22 100644
--- a/configs/khadas-vim3l_android_ab_defconfig
+++ b/configs/khadas-vim3l_android_ab_defconfig
@@ -3,6 +3,7 @@ CONFIG_SYS_BOARD="vim3"
 CONFIG_SYS_CONFIG_NAME="khadas-vim3l_android"
 CONFIG_ARCH_MESON=y
 CONFIG_TEXT_BASE=0x01000000
+CONFIG_SYS_MALLOC_LEN=0x08000000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3l_android_defconfig
index 3fa587ef1db5..206f8defca6b 100644
--- a/configs/khadas-vim3l_android_defconfig
+++ b/configs/khadas-vim3l_android_defconfig
@@ -3,6 +3,7 @@ CONFIG_SYS_BOARD="vim3"
 CONFIG_SYS_CONFIG_NAME="khadas-vim3l_android"
 CONFIG_ARCH_MESON=y
 CONFIG_TEXT_BASE=0x01000000
+CONFIG_SYS_MALLOC_LEN=0x08000000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000

---
base-commit: 076529725f16f07a5cb2d5feba25d62b5f5a5872
change-id: 20240209-vim3-avb-malloc-aa3de534d6a0

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

