Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A28EC3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 18:04:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0CCE81DE3;
	Mon, 31 Mar 2025 20:04:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TbP483ZK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2671E81E6C; Mon, 31 Mar 2025 20:04:48 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A182E8129B
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 20:04:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2260c915749so65060865ad.3
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 11:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743444284; x=1744049084; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wMlU3s6Q9gQMvNHso7AajicL/XXkK1t1aKKdQEwSJHU=;
 b=TbP483ZKyWHnnVinXIy2b9Q/QBIWuiAWD2ZL0hyKThGuDrHVIUpuKFQhoZuRuRKOR4
 uXpU+xHax1OdCZFXCaZXraGmzAsPDXYzZogj+/dWW3Cc1uk7nWfk3I6fjPSBrKUTuPjS
 UkG2GMXSVf43SXJaqrUmgF5BgGxz2Pb10QsFoY07JFm0FQUSkyPf9PNfeUuD6omvPHG6
 fk5PbnjnAId+qE9Lz3CUfACw0Gz6dthb9eTOU8vlWwRXuYU2Hbd4mjSissCJkD/dHOMZ
 3S9ccyBv+l9ImrvUDBdIxs3CfSLNVeNTnZsMPQi+v5P/RWLuRLJmjj4hKT09vwEP1zge
 YOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743444284; x=1744049084;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wMlU3s6Q9gQMvNHso7AajicL/XXkK1t1aKKdQEwSJHU=;
 b=iBcXmt97WyWl066Ej6qAkXGhSiP1AdOsnB49OlLvuaFSjfogHJU/Im6vGW3KNRWsQj
 hpITIexyySitYkntDKEPVrHFSMVuNfnExPRrSEMu8inpaobcUXr+nmvWBxOw/QGGc4bz
 bILo1BsMxYPLxUrODFxLZRtfduJ9kkURigeGvj8MASyEPX/lg+qbObiQdPLJ6yGgtydI
 fZcEWg+irunALpwhTUJKGyU13YXDInoDtxkxuhlEaH/QMGx8XVvKwP21o28wb1zs+2yC
 1R8u5qmXUgYZuwtfX86Diip2rIH7GJ6TzRRujQ+ukw6HGWhmsTZZuLTKrPYCuM7nIupY
 CagQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX0DVOaot5WUgcr9uv0FzAKHTYqKNKAv5paFJRwVfu9bCkbhwV8i6QhSigPccKY5cOc2CxNQ4=@lists.denx.de
X-Gm-Message-State: AOJu0YwXROWl7GQ8PQrc5pVjN8mj2kDqatzY+bWloO+alL2mER88LoSw
 qMA2YfJassHOjXcbZDfJDi0eZJ8YyqIvNjqWvNH0lfMjT/o7oWd74NC8Lg==
X-Gm-Gg: ASbGnctVIcO/10XSIHxHDWPbSy3G7RPCMQGLqKpxYIy2nb+r6PUHfUaCo6leuX6KmKT
 8vzl0JSSg1sBlemF9d/UjdxM45lRgCYYQlmIOjq0nvn8ScPCkKmyDBA78A7O0kHob6Hy6a9+brX
 X9eV+p3SdtJ1zoYABTxUiZqR8ClzLrzkiZhzLl4RD+OStw0GiGOc64E2pa2n65h3iTj/91BTAAt
 0IBOR5ji3GfrNNkXp0do800p6PU8mmdUDtTDTGjVFVTya/i7ya0Y6dTo3ETfmq0HNTsVAZyG04/
 1/wyaAdz195CAM8fGdnPIjYCz2m+17XSh68bdyPRFfx6JFyRsPBBSStpwko=
X-Google-Smtp-Source: AGHT+IHaI5s7rCGWCtrMnyKo0dOIkZC5wywq9H8HIKebGA3N3v6WmUr8C1Vn7tobiN/VQZQp+C2+Tg==
X-Received: by 2002:a05:6a20:9e4e:b0:1f5:95a7:8159 with SMTP id
 adf61e73a8af0-2009f604133mr15909498637.10.1743444284021; 
 Mon, 31 Mar 2025 11:04:44 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:af57:ab0a:b12e:1ef5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af93b6d82f2sm6627096a12.40.2025.03.31.11.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 11:04:42 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: eugen.hristev@linaro.org
Cc: nicolas.ferre@microchip.com, trini@konsulko.com, greg@embeddedgreg.com,
 u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
Subject: [PATCH] sama5d27: Fix the 'reset' command
Date: Mon, 31 Mar 2025 15:04:36 -0300
Message-Id: <20250331180436.2305205-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@denx.de>

Since commit 61040097a9d1 ("reset: at91: Add reset driver for basic
assert/deassert operations") the "atmel,sama5d3-rstc" compatible for
the sama5d2 reset controller in sama5d2.dtsi is not handled by
CONFIG_SYSRESET_AT91 anymore, but by CONFIG_RESET_AT91 now.

This resulted in the following error, when trying to reset from the U-Boot
shell on a sama5d27_wlsom1 board:
    
 => reset
 resetting ...
 System reset not supported on this platform
 ### ERROR ### Please RESET the board ###

Fix it by enabling the CONFIG_RESET_AT91 driver in all sama5d27 defconfigs.

Tested on a sama5d27_wlsom1 board.

Based on the fix in commit e1ee52ca56fc ("configs: at91: sam9x60: Switch
to new reset driver")

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Eugen/Tom,

This is material for 2025.04.

 configs/sama5d27_giantboard_defconfig          | 2 ++
 configs/sama5d27_som1_ek_mmc1_defconfig        | 2 ++
 configs/sama5d27_som1_ek_mmc_defconfig         | 2 ++
 configs/sama5d27_som1_ek_qspiflash_defconfig   | 2 ++
 configs/sama5d27_wlsom1_ek_mmc_defconfig       | 2 ++
 configs/sama5d27_wlsom1_ek_qspiflash_defconfig | 2 ++
 6 files changed, 12 insertions(+)

diff --git a/configs/sama5d27_giantboard_defconfig b/configs/sama5d27_giantboard_defconfig
index ad1621a94dd7..0b7940f4fb43 100644
--- a/configs/sama5d27_giantboard_defconfig
+++ b/configs/sama5d27_giantboard_defconfig
@@ -14,6 +14,7 @@ CONFIG_ENV_SIZE=0x4000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="at91-sama5d27_giantboard"
 CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
@@ -84,6 +85,7 @@ CONFIG_DM_SPI_FLASH=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_AT91PIO4=y
+CONFIG_RESET_AT91=y
 CONFIG_DM_SERIAL=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_ATMEL_USART=y
diff --git a/configs/sama5d27_som1_ek_mmc1_defconfig b/configs/sama5d27_som1_ek_mmc1_defconfig
index bb29121bb156..2e5a4acf27d8 100644
--- a/configs/sama5d27_som1_ek_mmc1_defconfig
+++ b/configs/sama5d27_som1_ek_mmc1_defconfig
@@ -14,6 +14,7 @@ CONFIG_ENV_SIZE=0x4000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="at91-sama5d27_som1_ek"
 CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
@@ -93,6 +94,7 @@ CONFIG_MACB=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_AT91PIO4=y
+CONFIG_RESET_AT91=y
 CONFIG_DM_SERIAL=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_ATMEL_USART=y
diff --git a/configs/sama5d27_som1_ek_mmc_defconfig b/configs/sama5d27_som1_ek_mmc_defconfig
index 308aafc7dfe5..11a536d714c3 100644
--- a/configs/sama5d27_som1_ek_mmc_defconfig
+++ b/configs/sama5d27_som1_ek_mmc_defconfig
@@ -15,6 +15,7 @@ CONFIG_ENV_SIZE=0x4000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="at91-sama5d27_som1_ek"
 CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
@@ -93,6 +94,7 @@ CONFIG_MACB=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_AT91PIO4=y
+CONFIG_RESET_AT91=y
 CONFIG_DM_SERIAL=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_ATMEL_USART=y
diff --git a/configs/sama5d27_som1_ek_qspiflash_defconfig b/configs/sama5d27_som1_ek_qspiflash_defconfig
index ac14dd53838d..86cb5c287be1 100644
--- a/configs/sama5d27_som1_ek_qspiflash_defconfig
+++ b/configs/sama5d27_som1_ek_qspiflash_defconfig
@@ -15,6 +15,7 @@ CONFIG_ENV_SECT_SIZE=0x1000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="at91-sama5d27_som1_ek"
 CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
@@ -92,6 +93,7 @@ CONFIG_MACB=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_AT91PIO4=y
+CONFIG_RESET_AT91=y
 CONFIG_DM_SERIAL=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_ATMEL_USART=y
diff --git a/configs/sama5d27_wlsom1_ek_mmc_defconfig b/configs/sama5d27_wlsom1_ek_mmc_defconfig
index 6db27280f0fa..014f0093eee6 100644
--- a/configs/sama5d27_wlsom1_ek_mmc_defconfig
+++ b/configs/sama5d27_wlsom1_ek_mmc_defconfig
@@ -13,6 +13,7 @@ CONFIG_ENV_SIZE=0x4000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="at91-sama5d27_wlsom1_ek"
 CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
@@ -99,6 +100,7 @@ CONFIG_MACB=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_AT91PIO4=y
+CONFIG_RESET_AT91=y
 CONFIG_DM_SERIAL=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_ATMEL_USART=y
diff --git a/configs/sama5d27_wlsom1_ek_qspiflash_defconfig b/configs/sama5d27_wlsom1_ek_qspiflash_defconfig
index 765565265165..efe23115f620 100644
--- a/configs/sama5d27_wlsom1_ek_qspiflash_defconfig
+++ b/configs/sama5d27_wlsom1_ek_qspiflash_defconfig
@@ -14,6 +14,7 @@ CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="at91-sama5d27_wlsom1_ek"
 CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
@@ -103,6 +104,7 @@ CONFIG_MACB=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_AT91PIO4=y
+CONFIG_RESET_AT91=y
 CONFIG_DM_SERIAL=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_ATMEL_USART=y
-- 
2.34.1

