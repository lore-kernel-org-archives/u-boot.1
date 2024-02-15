Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF321C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 20:57:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C758887EF1;
	Thu, 15 Feb 2024 21:53:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ctwky/E/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 779EB87F2B; Thu, 15 Feb 2024 21:53:34 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3943A87EDB
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 21:52:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33d173acb98so76761f8f.2
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 12:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708030363; x=1708635163; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xgyenr9wkbe4ZW3R/61adtNJnLoKSyW7Ttu1HNLErK4=;
 b=ctwky/E/qH08AQYxaeea9vc3PIYB/Q699rO1MiwsWnvugsDWf6D8aYhNbolNLOC0i2
 yjV5jAze9mxdNbi90tD0cjV13j648ktFicVK29fxrXdon3PbHz59JpqPp9N6WX8vUe3l
 gREOuqEVDerbb5Qv8LsWtfmD+KypdN12+QvyB65xd4PI9Ehy/GIiQKwt63d8gm71jl+D
 qKlQYmK+IySs0YeKmAHkhUL5RoJcmnB2x83tlSbCKPwGAWmAIEvs7EgNn8f4uMWHBV1n
 uPpA7uMrbVV1DNQdMNUnmjo7JieI9l7lI5vDhoPJKX8nF4HVrqIEsg0qtga5grWuAU+M
 4wYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708030363; x=1708635163;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xgyenr9wkbe4ZW3R/61adtNJnLoKSyW7Ttu1HNLErK4=;
 b=LouhEtwDXwy6QBADcAKOIHEx/StluaOdmp95Uyb0iXT+ZuPpOZHxGcRwIhBvbPebvr
 /QPvaWclzx7yZqvuHzbJvaOA3Spmc72mq0dz6xdghW2roRvQ9et8rhXhXgA+1Zl/aW7T
 v7fUNemGlDarXtAQ68nOHYKIjEuCcj0ft+1cszA6PnuN492IKGvUgPY8uxuq7viY4JLR
 WUlJRlaN2b6eeDjheU48ooWQAbN+7jt/cBZ0z+RAOoLTNGhBkLCgANEEyu1hqPWr2SiE
 Ya1jDE+t3hEF5oFDUtII8nUMgpxJZwX1f+Dqu7SzyL35SWLRJeYsG+V4LyTzNFrFiLkb
 I/Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF3YNpGuCRZ6fqO5Kbmr3NoMB1aIF8cxvCDwzuEqZXP/SchJzRLLEfKQbt804gPPwNMbOtNXjPRoNNitVI6x8F2cSDOg==
X-Gm-Message-State: AOJu0YxsJrzvizkww07XTPmR7OZLtRNfRotDv0Gqbt2jQtEKVoKhAgEu
 JXH9SMAKbal5FoTltyexaxIv+Kug6MJkPtHzTzU9gIEJB8OEltUHDW3uFjDkK6GcudQSSKwzhPl
 o
X-Google-Smtp-Source: AGHT+IEa4x1T4uGHt0u8PSU2wRQWUVZTBPKfmTp61ugvXXv/zWO4aqbCIKaFi074R+86R3w32c/DwQ==
X-Received: by 2002:adf:ec82:0:b0:33b:1a39:e501 with SMTP id
 z2-20020adfec82000000b0033b1a39e501mr1974328wrn.28.1708030363546; 
 Thu, 15 Feb 2024 12:52:43 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 e4-20020adfe384000000b0033cfa00e497sm194025wrm.64.2024.02.15.12.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 12:52:43 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 15 Feb 2024 20:52:37 +0000
Subject: [PATCH v4 19/39] board: dragonboard820c: use LINUX_KERNEL_IMAGE_HEADER
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-b4-qcom-common-target-v4-19-ed06355c634a@linaro.org>
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=4839;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=TB+rEOKQi0BInDj0rjvhEg9UlCH4+k/WgcTWUfjAHXc=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRzla2rYlRuul0549da7f44dbPqtO6VntyJrHoc1i2Tj
 hl7/cvrKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABNZ1Mbwz5C1JDEo9d/m/ZvX
 zdF4X3++aPVdJ7WLm9aXnWTUdC2L/sTwP/5n+rUjJr+m+y93sjb3y+j0P+7vlOh10y154sRpCX1
 vhQA=
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

db820c predated support for prepending the kernel image header
automatically, drop it's custom linker script and head.S in favour of
this generic support.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/Kconfig          |   1 +
 board/qualcomm/dragonboard820c/Makefile   |   1 -
 board/qualcomm/dragonboard820c/head.S     |  33 ---------
 board/qualcomm/dragonboard820c/u-boot.lds | 111 ------------------------------
 4 files changed, 1 insertion(+), 145 deletions(-)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index ad6671081910..f897c393464f 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -45,6 +45,7 @@ config TARGET_DRAGONBOARD410C
 
 config TARGET_DRAGONBOARD820C
 	bool "96Boards Dragonboard 820C"
+	select LINUX_KERNEL_IMAGE_HEADER
 	imply CLK_QCOM_APQ8096
 	imply PINCTRL_QCOM_APQ8096
 	imply BUTTON_QCOM_PMIC
diff --git a/board/qualcomm/dragonboard820c/Makefile b/board/qualcomm/dragonboard820c/Makefile
index 643311f5b3ba..2ae6d16364aa 100644
--- a/board/qualcomm/dragonboard820c/Makefile
+++ b/board/qualcomm/dragonboard820c/Makefile
@@ -3,4 +3,3 @@
 # (C) Copyright 2017 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@gmail.com>
 
 obj-y	:= dragonboard820c.o
-extra-y += head.o
diff --git a/board/qualcomm/dragonboard820c/head.S b/board/qualcomm/dragonboard820c/head.S
deleted file mode 100644
index b052a858fd32..000000000000
--- a/board/qualcomm/dragonboard820c/head.S
+++ /dev/null
@@ -1,33 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * ARM64 header for proper chain-loading with Little Kernel.
- *
- * Little Kernel shipped with Dragonboard820C boots standard Linux images for
- * ARM64. This file adds header that is required to boot U-Boot properly.
- *
- * For details see:
- * https://www.kernel.org/doc/Documentation/arm64/booting.txt
- *
- * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
- */
-
-#include <config.h>
-
-/*
- *   per document in linux/Doc/arm64/booting.text
- */
-.global _arm64_header
-_arm64_header:
-	b _start
-	.word 0
-	.quad   CONFIG_TEXT_BASE-PHYS_SDRAM_1 /* Image load offset, LE */
-	.quad   0    /* Effective size of kernel image, little-endian */
-	.quad   0    /* kernel flags, little-endian */
-	.quad   0    /* reserved */
-	.quad   0    /* reserved */
-	.quad   0    /* reserved */
-	.byte   0x41 /* Magic number, "ARM\x64" */
-	.byte   0x52
-	.byte   0x4d
-	.byte   0x64
-	.word   0    /* reserved (used for PE COFF offset) */
diff --git a/board/qualcomm/dragonboard820c/u-boot.lds b/board/qualcomm/dragonboard820c/u-boot.lds
deleted file mode 100644
index 5251b59fbe76..000000000000
--- a/board/qualcomm/dragonboard820c/u-boot.lds
+++ /dev/null
@@ -1,111 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Override linker script for fastboot-readable images
- *
- * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
- *
- * Based on arch/arm/cpu/armv8/u-boot.lds (Just add header)
- */
-
-OUTPUT_FORMAT("elf64-littleaarch64", "elf64-littleaarch64", "elf64-littleaarch64")
-OUTPUT_ARCH(aarch64)
-ENTRY(_arm64_header)
-SECTIONS
-{
-	. = 0x00000000;
-
-	. = ALIGN(8);
-	.text :
-	{
-		*(.__image_copy_start)
-		board/qualcomm/dragonboard820c/head.o (.text*)
-		CPUDIR/start.o (.text*)
-	}
-
-	/* This needs to come before *(.text*) */
-	.efi_runtime : {
-                __efi_runtime_start = .;
-		*(.text.efi_runtime*)
-		*(.rodata.efi_runtime*)
-		*(.data.efi_runtime*)
-                __efi_runtime_stop = .;
-	}
-
-	.text_rest :
-	{
-		*(.text*)
-	}
-
-	. = ALIGN(8);
-	.rodata : { *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*))) }
-
-	. = ALIGN(8);
-	.data : {
-		*(.data*)
-	}
-
-	. = ALIGN(8);
-
-	. = .;
-
-	. = ALIGN(8);
-	__u_boot_list : {
-		KEEP(*(SORT(__u_boot_list*)));
-	}
-
-	. = ALIGN(8);
-
-	.efi_runtime_rel : {
-                __efi_runtime_rel_start = .;
-		*(.rel*.efi_runtime)
-		*(.rel*.efi_runtime.*)
-                __efi_runtime_rel_stop = .;
-	}
-
-	. = ALIGN(8);
-
-	.image_copy_end :
-	{
-		*(.__image_copy_end)
-	}
-
-	. = ALIGN(8);
-
-	.rel_dyn_start :
-	{
-		*(.__rel_dyn_start)
-	}
-
-	.rela.dyn : {
-		*(.rela*)
-	}
-
-	.rel_dyn_end :
-	{
-		*(.__rel_dyn_end)
-	}
-
-	_end = .;
-
-	. = ALIGN(8);
-
-	.bss_start : {
-		KEEP(*(.__bss_start));
-	}
-
-	.bss : {
-		*(.bss*)
-		 . = ALIGN(8);
-	}
-
-	.bss_end : {
-		KEEP(*(.__bss_end));
-	}
-
-	/DISCARD/ : { *(.dynsym) }
-	/DISCARD/ : { *(.dynstr*) }
-	/DISCARD/ : { *(.dynamic*) }
-	/DISCARD/ : { *(.plt*) }
-	/DISCARD/ : { *(.interp*) }
-	/DISCARD/ : { *(.gnu*) }
-}

-- 
2.43.1

