Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA13C61D92
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 17:11:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFEE6875A4;
	Tue, 21 Nov 2023 18:09:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UQPDAd1w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC1DE87637; Tue, 21 Nov 2023 18:09:52 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6194B875AB
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 18:09:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2c501bd6ff1so72211741fa.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 09:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700586581; x=1701191381; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9imF+YbrKT9/xfJzuapVm/9Tvcy100kolJOoerob2SU=;
 b=UQPDAd1w8eXiKZbgBQsvWDQ/J/9jciGtaFdaD/GLk9o+db8WUBxL5j1/Q5cknm/IIq
 4YZYFkU2eySAJAqxFUDPJ6/7/anzwQaTvlvVlLjfT6xC91l0fU3UiJkeMmlIp1OkKIB6
 VtO01CJHCyC4JDY7BGhG4fzgdWh1QoszwUaiLvARtl6utWFhEPUv1wJmDt7eNXnsajF6
 6ueiIKKhA8YOEuAm54FVcDgc/Zlb2N8mSAFi9nhWcsi/ioBgFWtyQopf3DgHmVZ6qKwn
 SRmkv7lEj4IsuafsK1/vtaqFg/i/y5ZV9FuAzvfKH9kdvgA6KOToTlvnhtQ+nX24yX5t
 BqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700586581; x=1701191381;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9imF+YbrKT9/xfJzuapVm/9Tvcy100kolJOoerob2SU=;
 b=sy5Tqpl96oj6wMmEnb6JzaVzte1Lc3y/auI6JOeNwmF0PHUOnY8wPcX/FNDR2ecAMJ
 8V1YsXKJzWOl7WKXuES/kXMH3DS6toJH1mcY95IDf9kMLVq/Gkr9EMsrDkT1Uwn548S2
 rPI35orkpakcuh3rlxJo1R/LbsxkJeUqur7nE6YY7oLghOLcpfihio3xfAkisPsbv078
 Tglquh52pnnjdNU/+SFf7i7/T/hHtaDeYUqtgBvxY7OC9eIhZl78ozlQxaBFk0ROQ1RU
 8WkDf0PcbUXgmRc5Lgq2VJHG8zhsGielK4AZpGkfJwAjDm6xkyjq8BkSWUheRWyTBuh1
 yT4A==
X-Gm-Message-State: AOJu0YyFuTaSAWr6u0e40lRCztoWW10elUCbec8S59aVP4ZXdX+Kyt8g
 lByFvtOHbkqiYdaN1Dm+nnvCDQ==
X-Google-Smtp-Source: AGHT+IHWkc6yxFWl1zbv4Jjlfbwsrst9HrXy1XoDEkNxFgEHzChlIwxzaYhK5yWBU4KWwd2oMn0VPQ==
X-Received: by 2002:a05:651c:10af:b0:2c6:eb44:2e12 with SMTP id
 k15-20020a05651c10af00b002c6eb442e12mr7538829ljn.43.1700586580764; 
 Tue, 21 Nov 2023 09:09:40 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 1-20020a05600c230100b003fefb94ccc9sm17345812wmo.11.2023.11.21.09.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 09:09:40 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 21 Nov 2023 17:09:35 +0000
Subject: [PATCH 12/21] board: dragonboard820c: use
 LINUX_KERNEL_IMAGE_HEADER
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-b4-qcom-common-target-v1-12-9492198e0c15@linaro.org>
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
In-Reply-To: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4782;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=U0b2nNmR3fgt8e8auYahMhinsHk+zS8tzZkNflPHqRk=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSYJ25tbmum/BW/mVi3Zkbwv9au9qUxdxO4btzYH1i/u
 XKXnfiajlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCR2VkMf8XVTKyF9yxjbWDO
 Xxp4+kWX84eiiY+mPBL8uyjY3PvjwcMM/8ultdJsZ/Ef13jjvStrmvZi2/cXu88LVpVdcIx5wyW
 +bB0A
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
2.42.1

