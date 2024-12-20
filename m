Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB46E7718B
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 22:27:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B24B880423;
	Fri, 20 Dec 2024 23:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aRs4Ykmc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 376FC804CE; Fri, 20 Dec 2024 23:26:30 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E36A80423
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 23:26:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6d8e8cb8605so12950636d6.0
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 14:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734733586; x=1735338386; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YxmaAd8g/NCQNqlpIkF5qrMTe5/K1fkvbRp1sV+iCp0=;
 b=aRs4YkmcuoDkh9k7a8tq4nHyFttc395UmJyKr3V8GxZBB/dktguDQCtagmj4IykapQ
 wJZ8t2m/xKyzBASQLB7Lp+2GPhMsBn7imKOzDrUwyyWRXwuu43+2ky215aEXVoz412ov
 XOjcypyGcCJ4RlFa5M1r1vTR3/wWXqy8ldi14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734733586; x=1735338386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YxmaAd8g/NCQNqlpIkF5qrMTe5/K1fkvbRp1sV+iCp0=;
 b=Er2BJtAAot7sQfbCYPIQoxYCtBqjyHgmF49lIfob9EaXp79zFTJt+b9kUckdfrZ3js
 xFfvbDSx92853bcHuiNncsPw3TgNclFkQM41abKSi4KVxpuS5h/GiCL9wn9EmqNytOqo
 odbFQI3wf1xSQE9iWgxJlf21kLtlt/x70+Hemc+JuKOwVgS/AVZW740VnlP+dnFwkX1S
 zVTnMFqvuw0TkPVRoNVZe2jZT252201M8fFr4Dewkgl6kCVo/NKJ+JZF6gaBnjZf/BSV
 OmvRcxrThB2fmarRAZJMOmRO+w5JZ70brg+Q2BlP1lb3xFXg16CknPS2YnESyO0yfuPu
 u0cA==
X-Gm-Message-State: AOJu0YzpDmQ7f1vhLRiXY5ALOXRS7xwml5mf2Spzp6YYfa6lLY7XnuR7
 RzEbVzHij5KK+s/D6043yQrbSZ4dGtBWnSGB+c95RLlVjipsg9gB8EENdXttlVKCQV6OJjYw6Dn
 99UY=
X-Gm-Gg: ASbGncucGSFhtTswPLg8VPxykO68OCd39Ww/5uKCp7Mtm9CVXC1xbzrxUiaH4F7lFwo
 6QFihZW9pVnCTNs3Qx2xN4tommwxj3unWTBnZ7C7w3/brnUvNLgaoeqeBBfLZBjBrAuVzWREPgF
 XpvQc0oT1ei9eBp1cLeg7SLsCWFoBKzUr02sWUs3p3y33pQsHJYr/mY0/8mUWxY1OXWahjN9QF4
 3wpatMAgMzRw14pNmNzANwYqD4QO9MiDKrUb1S/UhPM1hn5hzP2l97ldlyOOY+DGeq/MBXGx+4Z
 5UU=
X-Google-Smtp-Source: AGHT+IFzoleoxMFZr5Gd8stR6OFzM/qE5fizMJbk9005L6QczAaqlE7/Ckvsb9jVvb+1NHYxS7Nstw==
X-Received: by 2002:a05:6214:5004:b0:6d8:96a6:ec27 with SMTP id
 6a1803df08f44-6dd2339daf7mr76681016d6.35.1734733586066; 
 Fri, 20 Dec 2024 14:26:26 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181bb4desm21055606d6.87.2024.12.20.14.26.25
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 14:26:25 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 6/6] block: Remove "select BLK" from non-block drivers
Date: Fri, 20 Dec 2024 16:22:22 -0600
Message-ID: <20241220222612.1757884-7-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220222612.1757884-1-trini@konsulko.com>
References: <20241220222612.1757884-1-trini@konsulko.com>
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

Now that block drivers are all selecting the BLK symbol, there's no need
for other options to be select'ing BLK so that other required
functionality can be enabled. Remove these places.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/Kconfig              | 4 ----
 arch/arm/mach-exynos/Kconfig  | 4 ----
 arch/arm/mach-imx/mx5/Kconfig | 2 +-
 arch/arm/mach-s5pc1xx/Kconfig | 1 -
 4 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ea256f687867..86b37e8d5f8d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1371,7 +1371,6 @@ config ARCH_VEXPRESS64
 	select PL01X_SERIAL
 	select OF_CONTROL
 	select CLK
-	select BLK
 	select MTD_NOR_FLASH if MTD
 	select FLASH_CFI_DRIVER if MTD
 	select ENV_IS_IN_FLASH if MTD
@@ -1981,7 +1980,6 @@ config ARCH_STM32
 
 config ARCH_STI
 	bool "Support STMicroelectronics SoCs"
-	select BLK
 	select CPU_V7A
 	select DM
 	select DM_RESET
@@ -2028,7 +2026,6 @@ config ARCH_STM32MP
 
 config ARCH_ROCKCHIP
 	bool "Support Rockchip SoCs"
-	select BLK
 	select BINMAN if SPL_OPTEE || SPL
 	select DM
 	select DM_GPIO
@@ -2116,7 +2113,6 @@ config TARGET_POMELO
 	select AHCI
 	select SCSI_AHCI
 	select AHCI_PCI
-	select BLK
 	select PCI
 	select DM_PCI
 	select SCSI
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 7e6959510087..28193039cb84 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -18,7 +18,6 @@ config ARCH_EXYNOS4
 	bool "Exynos4 SoC family"
 	select BOARD_EARLY_INIT_F
 	select CPU_V7A
-	select BLK
 	select MMC
 	help
 	  Samsung Exynos4 SoC family are based on ARM Cortex-A9 CPU. There
@@ -39,7 +38,6 @@ config ARCH_EXYNOS5
 	imply USB_ETHER_ASIX
 	imply USB_ETHER_RTL8152
 	imply USB_ETHER_SMSC95XX
-	select BLK
 	select MMC
 
 	help
@@ -51,7 +49,6 @@ config ARCH_EXYNOS7
 	bool "Exynos7 SoC family"
 	select ARM64
 	select BOARD_EARLY_INIT_F
-	select BLK
 	select MMC
 	help
 	  Samsung Exynos7 SoC family are based on ARM Cortex-A57 CPU or
@@ -61,7 +58,6 @@ config ARCH_EXYNOS7
 config ARCH_EXYNOS9
 	bool "Exynos9 SoC family"
 	select ARM64
-	select BLK
 	select MMC
 	help
 	  Samsung Exynos9 SoC family are based on ARMv8 Cortex CPU. There are
diff --git a/arch/arm/mach-imx/mx5/Kconfig b/arch/arm/mach-imx/mx5/Kconfig
index 4d1e07b14d32..0dfd68496875 100644
--- a/arch/arm/mach-imx/mx5/Kconfig
+++ b/arch/arm/mach-imx/mx5/Kconfig
@@ -26,7 +26,7 @@ config TARGET_KP_IMX53
 	select DM_I2C
 	select DM_PMIC
 	select DM_SERIAL
-	select BLK
+	select DM_MMC
 	select DM_REGULATOR
 	select MMC
 	select MX53
diff --git a/arch/arm/mach-s5pc1xx/Kconfig b/arch/arm/mach-s5pc1xx/Kconfig
index b15b2e7b6a01..d8b85f80e631 100644
--- a/arch/arm/mach-s5pc1xx/Kconfig
+++ b/arch/arm/mach-s5pc1xx/Kconfig
@@ -7,7 +7,6 @@ choice
 config TARGET_S5P_GONI
 	bool "S5P Goni board"
 	select OF_CONTROL
-	select BLK
 	select MISC_COMMON
 	select MMC
 
-- 
2.43.0

