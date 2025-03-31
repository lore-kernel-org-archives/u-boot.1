Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5ACC36016
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 20:38:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 790948129B;
	Mon, 31 Mar 2025 22:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SSCOORsr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE7C181703; Mon, 31 Mar 2025 22:38:11 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F3C180584
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 22:38:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ff694d2d4dso7792563a91.0
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 13:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743453487; x=1744058287; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6AKzZn0WtLwfwicXFzIHnW0p2vHwyn3W1QnB9gsVlsc=;
 b=SSCOORsrhlVCHyBaWZXww61MkBTB5kasM4Wv2vRZ/PAIsRUOSV7FeI1WXOWKwY7/rN
 6LapR1rZHaWI4tR+uekvpiBipj5x4bK0TjPpDwtVZkLsq7+WXhYNHnrp2reAAYKkis7o
 vhmifR3Ix/RsI8ADiUqtxWv7ALQpGsvJARVFbwlHjEzIpWGtexZmucff1u6Cn8Mtf8oE
 47hQZjWGbIKjQ6/kQt1vcKhunjDL6Bc7+O0mmCa9UpYyBsWijzEm8iBs/NJeAg6752Go
 NZYwNd2k7JiGWnufwHrQ48egUlkUetfVvKeVEJjPhupM2tGJC9U3+VUrTtLTRhd0/Zxu
 L3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743453487; x=1744058287;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6AKzZn0WtLwfwicXFzIHnW0p2vHwyn3W1QnB9gsVlsc=;
 b=hj+eSNG9RsJ/lAk00F8zhEMZQ60SnW8lqdhg0CmGQDgVCju3EYFM4X0MSaYPEs1AWL
 97CiTt41VIWk70KNZL1JFeFE1fk1C0QjYzAhpROOXZcozdoLsPRY4VZHQciBNNBiPfSa
 xg00e/AbWiQNsl9bufKGEfXZ1U9iFLh74idNMxPfwxRAdsohiv0eWYv3tzgbtQ7rzzYr
 NXvYndEomZOO0MsKW8CtgmaQZn0rdSQbrWxUNfws9M14zW5UKFIxDQOGKKuZVkzRjodB
 AbUee4Ip5hQGK3ICi4lxI4/PUtU2zZuHD/57DuYGAOzay3VTFE+ha2MAhp5CEeeO1PLH
 y1eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSElu0bnHFxVeatLYSTetFR+WU3+4cHIaQzI2mpDGJR4r6RWpoy3f+F2PGUQoWsROLR9F0hfc=@lists.denx.de
X-Gm-Message-State: AOJu0YyR9jFPgXmzGe9Pca+ivn7uluHPQY4C+nMmLaPWXVOBtcvGzSAj
 3JPtPkW6rApN0Po6qLuKZQJXpwtGCWc1M2Y28UZa+OvRQTyaxZeL
X-Gm-Gg: ASbGnctLaTZ7axPrlreyxsBl9saPI6nrG7rIaNWGll5uQ9HpkFEkM3yufxLyKYFjutn
 9Qbobo514dtD+a2Rjp4k/yzTBRpyZUElz/xuayO15aQEJlYhco8X6bX/ZiTW9lYslCYGNHC22zf
 7BhRKE53aAbdt1D51I9fQc0t6PlWsRkULu8HkyKB0yjUd4IaDQoI6tpkC7n3ZP5j5txCEmwb4bF
 8Ozi1ke5pMxa88HKTzjpL3zHWHEk2S/dwuedVyMdGXVEG5sEpVBSHO0Tn+TJYCntVZRG05RTqa+
 hMeLIjuCiWEi3g+c9zeZg+icGnBlJXB0UCcRbX+gOdVT/uozCUh8fwOUNLo=
X-Google-Smtp-Source: AGHT+IEwjgt+jHEHWaAKmW+MgyWk2XdAsgcCoZ0DWq9LdWi6h8WCzjJywgIqY/CqsSZjFozxBvj5MA==
X-Received: by 2002:a17:90b:4a41:b0:305:2d27:7ba0 with SMTP id
 98e67ed59e1d1-30531f7bc94mr15647859a91.6.1743453486787; 
 Mon, 31 Mar 2025 13:38:06 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:af57:ab0a:b12e:1ef5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039dfd38a6sm10017207a91.10.2025.03.31.13.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 13:38:06 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: eugen.hristev@linaro.org
Cc: nicolas.ferre@microchip.com, trini@konsulko.com, greg@embeddedgreg.com,
 u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2] sama5d27: Fix the 'reset' command
Date: Mon, 31 Mar 2025 17:37:34 -0300
Message-Id: <20250331203734.2792684-1-festevam@gmail.com>
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

Fixes: 61040097a9d1 ("reset: at91: Add reset driver for basic assert/deassert operations")
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Add Fixes tag. (Eugen)

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

