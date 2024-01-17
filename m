Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A78DC47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 11:14:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C68AE878A5;
	Wed, 17 Jan 2024 12:14:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ce0rbCwU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CC79878A5; Wed, 17 Jan 2024 12:14:10 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 809EA87B59
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 12:14:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5592d1bc4fbso3775067a12.0
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 03:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705490046; x=1706094846; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ZXg7dmwDkD8P5xnNl+ENqq/mz5fduHoo+s+Wyjk3ig=;
 b=Ce0rbCwUlMW8Ss6mzUC6ySBYe0pb+ITtfGuqHrl9dVri1qGKj+4sSSDN7HiN10pYwi
 V2FmWnm3TLMHWNp/86Il1+pp3oYpOFMhPvtS6npbtes4MHIyoGoOXusUzYzXLXM9v8a8
 493pwPwpLCylGQcuB6oFcyAxw1U0gBC0gvQBW6utzJYW3v9OZrP3XQ4Qh+bcTvEz6YOO
 yImXsF4NFYWNAqlvSk5GSR6TpmMBeSod//OHUVyaOGQF+EDAnR/EuTFKQ/4/1hwUAkq8
 lcMEQjh3XpMXtzAtTi9CFBM8IiXMexACdypgdL9i8XYhLp+gMJzP/EqYUicuvXHLvV5d
 7E/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705490046; x=1706094846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ZXg7dmwDkD8P5xnNl+ENqq/mz5fduHoo+s+Wyjk3ig=;
 b=rLqU7AQL09FLILtSU9iNQ7Fh9lizLTUvFLd1qGSKCmY7+tczfYurWKS/ctYq9ux1kr
 GqrKEHlseLnLTXX+HHEAOiJFwR0SOp5C5p13Dv34760KIc/uY2qqtS1I5HR4WognFW5D
 juxyY0F/C30DX9QrBxk2lCcLKe0Xnw4+WmOFiCgVUMqNJvfGWUGCkaUWQ0UtzJkKkNNh
 jKKH/M5CRf21I8xcgRb/a3z9Rq4Gr/Jwc3peVvwDyC5Xztf4aoMwVFYcJkwQTiHrBqkQ
 6WuTOl3gEPadoaxEOIZS0asE/efwzrn2+m5Fy9zbQhDgExblavIjQNRXZjbIs+NgofQn
 xTfg==
X-Gm-Message-State: AOJu0Yys5kWwkoGBN/vJa6JtYOUWiCm4lKV3N/g9E0W0+B5IBUsbA7bU
 mJiUys84qHBXitacNmXmvUk=
X-Google-Smtp-Source: AGHT+IFr0B3IaO3NLqgLmxM0eJ7KjBeCvmHVaRLfuzgqs3IGwDVDYcr6qrg6RKJkKEaTNZFXOz93ng==
X-Received: by 2002:a05:6402:430c:b0:559:46c4:7d2f with SMTP id
 m12-20020a056402430c00b0055946c47d2fmr3314490edc.60.1705490045922; 
 Wed, 17 Jan 2024 03:14:05 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 eg42-20020a05640228aa00b00559b1b070a6sm1794111edb.32.2024.01.17.03.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 03:14:05 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@chromium.org>, Fabio Estevam <festevam@denx.de>,
 Thierry Reding <treding@nvidia.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/2] ARM: tegra: move to standard boot
Date: Wed, 17 Jan 2024 13:13:52 +0200
Message-Id: <20240117111353.219772-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117111353.219772-1-clamor95@gmail.com>
References: <20240117111353.219772-1-clamor95@gmail.com>
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

Drop the distro-boot scripts and use standard boot instead.

Inspired by:
'commit 7755dc58af7b ("rockchip: Move to standard boot")'

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/Kconfig                    |  2 +-
 include/configs/tegra-common-post.h | 30 ++---------------------------
 2 files changed, 3 insertions(+), 29 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2d4458b7b5..467dc07c06 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1323,7 +1323,7 @@ config ARCH_ZYNQMP
 config ARCH_TEGRA
 	bool "NVIDIA Tegra"
 	select GPIO_EXTRA_HEADER
-	imply DISTRO_DEFAULTS
+	imply BOOTSTD_DEFAULTS
 	imply FAT_WRITE
 	imply SPL_TIMER if SPL
 
diff --git a/include/configs/tegra-common-post.h b/include/configs/tegra-common-post.h
index 0d0965ecce..fc74980f7c 100644
--- a/include/configs/tegra-common-post.h
+++ b/include/configs/tegra-common-post.h
@@ -7,33 +7,7 @@
 #ifndef __TEGRA_COMMON_POST_H
 #define __TEGRA_COMMON_POST_H
 
-#if IS_ENABLED(CONFIG_CMD_USB)
-#define BOOT_TARGET_USB(func) func(USB, usb, 0)
-#else
-#define BOOT_TARGET_USB(func)
-#endif
-
-#if CONFIG_IS_ENABLED(CMD_DHCP) && CONFIG_IS_ENABLED(CMD_PXE)
-#define BOOT_TARGET_PXE(func) func(PXE, pxe, na)
-#else
-#define BOOT_TARGET_PXE(func)
-#endif
-
-#if CONFIG_IS_ENABLED(CMD_DHCP)
-#define BOOT_TARGET_DHCP(func) func(DHCP, dhcp, na)
-#else
-#define BOOT_TARGET_DHCP(func)
-#endif
-
-#ifndef BOOT_TARGET_DEVICES
-#define BOOT_TARGET_DEVICES(func) \
-	func(MMC, mmc, 1) \
-	func(MMC, mmc, 0) \
-	BOOT_TARGET_USB(func) \
-	BOOT_TARGET_PXE(func) \
-	BOOT_TARGET_DHCP(func)
-#endif
-#include <config_distro_bootcmd.h>
+#define BOOT_TARGETS	"mmc1 mmc0 usb pxe dhcp"
 
 #ifdef CONFIG_TEGRA_KEYBOARD
 #define STDIN_KBD_KBC ",tegra-kbc"
@@ -88,7 +62,7 @@
 	MEM_LAYOUT_ENV_SETTINGS \
 	"fdt_high=" FDT_HIGH "\0" \
 	"initrd_high=" INITRD_HIGH "\0" \
-	BOOTENV \
+	"boot_targets=" BOOT_TARGETS "\0" \
 	BOARD_EXTRA_ENV_SETTINGS
 
 #endif /* __TEGRA_COMMON_POST_H */
-- 
2.40.1

