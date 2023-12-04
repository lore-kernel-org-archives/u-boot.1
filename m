Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410AFC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 08:22:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC51F87896;
	Mon,  4 Dec 2023 09:21:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZcOtOoKQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97C2587904; Mon,  4 Dec 2023 09:21:18 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94079876A3
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 09:21:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50bc8a9503fso5513621e87.3
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 00:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701678076; x=1702282876; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XeUyzu3ADyr+TC+JbeIh/FrA5bRXKCIK0NFX+bgQz4c=;
 b=ZcOtOoKQnxw77EEum8qknpqZgParwRw2YcZV5SgMQyjeZnBvG62llv2fE7uB7N0Y2W
 NjYLXY4AP6OPkd0qrSfzrr9YAsRK7g8OyCTOZa05Xp6ityJ/JaZc0EBvEvUbykzC+yk4
 v+N3xhRKbE9Eq+rcTDqdV5qGJf0fcDbTLmPDWvY+HsdV0UAhqQMX7hOBwl5MsvCM31yy
 mITXSGtDbz8aCPYZ89i7wbrKtnTsiL2012hLtQ7c61nc2rrP3irdC7cCXyw9JUjVCDrK
 kqMtBwV0K5TMqVevRgbuAinMFtQm187KSbkvpjxEdLRpsNteAiIaL2BJoTmCJcCcPBZD
 OhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701678076; x=1702282876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XeUyzu3ADyr+TC+JbeIh/FrA5bRXKCIK0NFX+bgQz4c=;
 b=XkzdQKZzKYTe8z2VK76C8yzw3v+nR+iQjcSxOYJMFjkvKwvrdhV9xRUfOulMMR/OJ/
 hNncAQuaqtyOn/2byzVQL0V/nXlZjraHW///JT7a/Ivhl+QE5HIrbB0i9bG2VIbKp5yo
 s9RgTDW68UN6Z9OPQyeuJgFpHxmAI3KeWagHDXtZLAj6h2VDccTr88ESY69oh6bJRvUq
 /YX79p2D4rDhqfSc6GG6PkHWAY/TUWWPasHr1tSQqxATXR/FvI9Tc/vqfGX5CRf5dvL8
 FRMmXpC0pIWxcj4WyQWsnyclvnWGHjB2SVH/8eMehHbrHab5HPH9huSVvLBzuK2vTcDj
 Nm6A==
X-Gm-Message-State: AOJu0Yyt6g6rEuQjaeHF7/j4o6eyLxMlex2/QFkF1aDmfLzP9R4/xmkV
 58yfZpGYQ8G6ZDzgfOBTlZM=
X-Google-Smtp-Source: AGHT+IENdCGAM+Ckl1X6uTeh52d+d7stZn9oAMBM2aR4Iffld9ZJAA2D9/l10Vn52yjO12Fk11a9aA==
X-Received: by 2002:a19:4f1e:0:b0:50b:eab2:973c with SMTP id
 d30-20020a194f1e000000b0050beab2973cmr1105319lfb.57.1701678075796; 
 Mon, 04 Dec 2023 00:21:15 -0800 (PST)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 q16-20020a19a410000000b0050bfe62b073sm3655lfc.170.2023.12.04.00.21.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 00:21:15 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Ramin Khonsari <raminterex@yahoo.com>,
 Jianlong Huang <jianlong.huang@starfivetech.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Emil Renner Berthing <kernel@esmil.dk>,
 Kuan Lim Lee <kuanlim.lee@linux.starfivetech.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 8/8] board: compal: paz00: clean up the board
Date: Mon,  4 Dec 2023 10:20:54 +0200
Message-Id: <20231204082054.4943-9-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231204082054.4943-1-clamor95@gmail.com>
References: <20231204082054.4943-1-clamor95@gmail.com>
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

Since implementation of pinctrl driver for T20 Paz00 can switch
to device tree pinmux setup along with remove of board pinmux
and some minor device tree and defconfig tweaks.

Tested-by: Agneli <poczt@protonmail.ch> # Toshiba AC100 T20
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra20-paz00.dts |  4 +--
 board/compal/paz00/Makefile    |  8 -----
 board/compal/paz00/paz00.c     | 53 ----------------------------------
 configs/paz00_defconfig        |  3 ++
 4 files changed, 5 insertions(+), 63 deletions(-)
 delete mode 100644 board/compal/paz00/Makefile
 delete mode 100644 board/compal/paz00/paz00.c

diff --git a/arch/arm/dts/tegra20-paz00.dts b/arch/arm/dts/tegra20-paz00.dts
index 5d8f21059f..5cf604e865 100644
--- a/arch/arm/dts/tegra20-paz00.dts
+++ b/arch/arm/dts/tegra20-paz00.dts
@@ -522,8 +522,8 @@
 		power-supply = <&vdd_bl_reg>;
 		pwms = <&pwm 0 5000000>;
 
-		brightness-levels = <0 16 32 48 64 80 96 112 128 144 160 176 192 208 224 240 255>;
-		default-brightness-level = <10>;
+		brightness-levels = <1 35 70 105 140 175 210 255>;
+		default-brightness-level = <2>;
 
 		backlight-boot-off;
 	};
diff --git a/board/compal/paz00/Makefile b/board/compal/paz00/Makefile
deleted file mode 100644
index 22c26ed1f6..0000000000
--- a/board/compal/paz00/Makefile
+++ /dev/null
@@ -1,8 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Copyright (c) 2010-2012, NVIDIA CORPORATION.  All rights reserved.
-#
-# See file CREDITS for list of people who contributed to this
-# project.
-
-obj-y	:= paz00.o
diff --git a/board/compal/paz00/paz00.c b/board/compal/paz00/paz00.c
deleted file mode 100644
index d92eb16224..0000000000
--- a/board/compal/paz00/paz00.c
+++ /dev/null
@@ -1,53 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2010-2012, NVIDIA CORPORATION.  All rights reserved.
- *
- * See file CREDITS for list of people who contributed to this
- * project.
- */
-
-#include <common.h>
-#include <log.h>
-#include <asm/io.h>
-#include <asm/arch/tegra.h>
-#include <asm/arch/pinmux.h>
-#include <asm/gpio.h>
-
-#ifdef CONFIG_MMC_SDHCI_TEGRA
-/*
- * Routine: pin_mux_mmc
- * Description: setup the pin muxes/tristate values for the SDMMC(s)
- */
-void pin_mux_mmc(void)
-{
-	/* SDMMC4: config 3, x8 on 2nd set of pins */
-	pinmux_set_func(PMUX_PINGRP_ATB, PMUX_FUNC_SDIO4);
-	pinmux_set_func(PMUX_PINGRP_GMA, PMUX_FUNC_SDIO4);
-	pinmux_set_func(PMUX_PINGRP_GME, PMUX_FUNC_SDIO4);
-
-	pinmux_tristate_disable(PMUX_PINGRP_ATB);
-	pinmux_tristate_disable(PMUX_PINGRP_GMA);
-	pinmux_tristate_disable(PMUX_PINGRP_GME);
-
-	/* SDIO1: SDIO1_CLK, SDIO1_CMD, SDIO1_DAT[3:0] */
-	pinmux_set_func(PMUX_PINGRP_SDIO1, PMUX_FUNC_SDIO1);
-
-	pinmux_tristate_disable(PMUX_PINGRP_SDIO1);
-
-	/* For power GPIO PV1 */
-	pinmux_tristate_disable(PMUX_PINGRP_UAC);
-	/* For CD GPIO PV5 */
-	pinmux_tristate_disable(PMUX_PINGRP_GPV);
-}
-#endif
-
-#ifdef CONFIG_VIDEO
-/* this is a weak define that we are overriding */
-void pin_mux_display(void)
-{
-	debug("init display pinmux\n");
-
-	/* EN_VDD_PANEL GPIO A4 */
-	pinmux_tristate_disable(PMUX_PINGRP_DAP2);
-}
-#endif
diff --git a/configs/paz00_defconfig b/configs/paz00_defconfig
index 9f3893dd60..c698493ad2 100644
--- a/configs/paz00_defconfig
+++ b/configs/paz00_defconfig
@@ -46,6 +46,9 @@ CONFIG_SYS_NS16550=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_TEGRA=y
+CONFIG_USB_ULPI_VIEWPORT=y
+CONFIG_USB_ULPI=y
+CONFIG_USB_KEYBOARD=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_VIDEO=y
-- 
2.40.1

