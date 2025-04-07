Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528CFC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 17:01:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4722582FB8;
	Mon,  7 Apr 2025 19:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZRao4rBT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6086182F65; Mon,  7 Apr 2025 19:00:07 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 206F782FE1
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 19:00:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac2bdea5a38so763074966b.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 10:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744045204; x=1744650004; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qAT47udz9UUgsd3UzSo+9NwLoO+3p8Fgy65Uj+u7kGM=;
 b=ZRao4rBT706STQNXp+/oakEr/eo5RkZiN6BRbCuFOtupk59I07i69n4DrOz0VacIpZ
 1TawDNcm/TywJpxm04yhoMsJq3qjyLvXNIJntVrDy+jk/cIDMWGDrpcLOdlVJsaVtJ2b
 FwK+JfnbChWkQRtkIOfKlxlZNeclTdhdV1God1xrE77u9l1j/pZnKHep2tbfEYrukYQi
 eXaQE3mrV58WKwkOjQEb3qkFIN/R18JIWDNfr2nfUU7IUaEEx++4qlqtIherNJHsA4sH
 RJfHqYct9nuDClZiQ/G8EzIzNAn+Ad0Rl2MlVwI1EwaCqkARdBZLszH8R7hcZw2UaKWz
 XsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744045204; x=1744650004;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qAT47udz9UUgsd3UzSo+9NwLoO+3p8Fgy65Uj+u7kGM=;
 b=dm01pbr+KQ+eyvNNHpSeU2YT7B39uz4KGWtp5h9ypiCXt4ZHyOTtoDIBeT8ANU2zRL
 PXtKyGORiPIUWJ3du46DCNv+6sPfc5hKzSmEkcwribmQ+hMpcfX96A7th0RZ//Bm+tJj
 w0vmTKgMrSPFldt4Qx9eE9wqrO/cP8KWrRxsZZ6LgQvnWre0ikWyvepgoleqEzonA7ts
 ALvb3WWlG5UjLXYHZ7Quvv3KFi4XZ+ceBy1N0NNk16HzUv2RVOd/s5iyKyZIXiwQb9Mo
 l63G2ito7H6hVLtpJu2Z3RYCO893dzIbKdVMdz4zZd4FGefuDJdy7wqwUjEHcL5AiDQO
 +/rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIJmkSqbKntlmEsvpq0z/igHSEw33mnYaTjFI1UXRzsG87CkyLablstZ0HjQBysMgIlolhC5I=@lists.denx.de
X-Gm-Message-State: AOJu0YxoCiRRndjLOoyAkRq0haGsV3lGDJNwcRUccwt4UqKRUSC9zbGF
 H8TOuo00Yh4Myc8AGQZMnaQuYfEXveXFRFpyynKcmXis5E9VFOlZnxZD8DgYbBg=
X-Gm-Gg: ASbGncvHnoUYni5JcwUKpKoSlJjZDm8e7ePQ6PuuYX4+g7FnC/m0iRI02sFuowjK6i1
 YIH4f11PpqGr2TvAhYrUIxTWfmpzU9WWpFY6FQi3eiHD6tYJ2neyfsYoo0Vea0VPE1YTmZjPjVS
 rwbH4wfG4Y081kQZOIdstisIvfaU9PNrLThHrNwCvl4Z+7WQAhzze0if0BVttv33vbyHVH6Zi56
 9F/Qfgd4bYRtRvZg5hndzGxzJEtF5AYJXb2Fiwd7GtbS+Cf+bySUdyXv4sYclE4GWZ4msU9/X5W
 nqfPUuAmN6CFlIGnGbc9oZRa1w/YAf0nn6HGy8gmZrY5b4VwUaR9iiqQtA==
X-Google-Smtp-Source: AGHT+IGcCixXfDxOfigh9+D/VOR8fb6RA/wP4TO6XspshGaLLaK7tplwuOe+bg67EJNleDYKWPBt6g==
X-Received: by 2002:a17:907:1c13:b0:ac7:3817:d8da with SMTP id
 a640c23a62f3a-ac7d6e951dbmr1133464966b.52.1744045204495; 
 Mon, 07 Apr 2025 10:00:04 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:b2e5:7ea8:e86c:3f99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfea16aesm773603666b.70.2025.04.07.10.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 10:00:04 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 07 Apr 2025 18:59:31 +0200
Subject: [PATCH 10/13] board: dragonboard410c: Use BOOTSTD instead of
 DISTRO_DEFAULTS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-db410c-fixes-v1-10-524aefbc8bb4@linaro.org>
References: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
In-Reply-To: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.2
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

Reduce the environment size by using standard boot instead of distro boot.
It uses faster bootdevs first by default (eMMC -> SD -> USB -> Network), so
set "boot_targets" to keep the current ordering (USB -> SD -> eMMC ->
Network). Perhaps this should be changed for consistency, but for now this
keeps the behavior similar to before.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 board/qualcomm/dragonboard410c/dragonboard410c.env |  1 +
 configs/dragonboard410c_defconfig                  |  3 ++-
 include/configs/dragonboard410c.h                  | 11 -----------
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.env b/board/qualcomm/dragonboard410c/dragonboard410c.env
index 0032dc3592a1021e4bb422357867cc26b4b30551..71f929b646cc305cf5223cd3462fe2350bc8093e 100644
--- a/board/qualcomm/dragonboard410c/dragonboard410c.env
+++ b/board/qualcomm/dragonboard410c/dragonboard410c.env
@@ -1,3 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 initrd_high=0xffffffffffffffff
 fastboot=fastboot -l $fastboot_addr_r usb 0
+boot_targets=usb mmc1 mmc0 pxe
diff --git a/configs/dragonboard410c_defconfig b/configs/dragonboard410c_defconfig
index da1ec4bfc60cdf4a2a9077efb081383b5b39301a..62fc42c9460d075fd27c3e2823eb8eea2a559772 100644
--- a/configs/dragonboard410c_defconfig
+++ b/configs/dragonboard410c_defconfig
@@ -16,7 +16,7 @@ CONFIG_IDENT_STRING="\nQualcomm-DragonBoard 410C"
 CONFIG_REMAKE_ELF=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTSTD_FULL=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_PREBOOT=y
 CONFIG_SYS_CBSIZE=512
@@ -35,6 +35,7 @@ CONFIG_CMD_USB=y
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIMER=y
+CONFIG_CMD_SYSBOOT=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
diff --git a/include/configs/dragonboard410c.h b/include/configs/dragonboard410c.h
index 00102cd5c4f54236366e4b6380a9c9537f9b4614..c31c6c57c1a4bebde740bc3fe535ca9610af043e 100644
--- a/include/configs/dragonboard410c.h
+++ b/include/configs/dragonboard410c.h
@@ -18,15 +18,4 @@
 #define PHYS_SDRAM_1_SIZE		SZ_1G
 #define CFG_SYS_SDRAM_BASE		PHYS_SDRAM_1
 
-/* Environment */
-#define BOOT_TARGET_DEVICES(func) \
-	func(USB, usb, 0) \
-	func(MMC, mmc, 1) \
-	func(MMC, mmc, 0) \
-	func(DHCP, dhcp, na)
-
-#include <config_distro_bootcmd.h>
-
-#define CFG_EXTRA_ENV_SETTINGS BOOTENV
-
 #endif

-- 
2.47.2

