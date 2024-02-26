Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE01C5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 17:30:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31BAA87FFD;
	Mon, 26 Feb 2024 18:26:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tFOt39ED";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B54BA87FA7; Mon, 26 Feb 2024 18:26:54 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5385987FAC
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:26:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33de4d3483eso439761f8f.3
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708968400; x=1709573200; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1F1DchEk4xMXd8YkeR9HRNWocB7RAiAPE10uy1k/kTQ=;
 b=tFOt39EDwjr73YmKzaXuAhEklHoUWLNNuM65hWQ4vwEaXVEe8LsuYkbj8TiCHYq0Un
 uHzZVsATrgk0Sgq5Ob7IZJKeQ6MjmrqbhNediJEIrhVL6IHTNs1yKAGxDEEGXCkhVcsX
 sHD2UIqv7KDJ4Nfoh+OIixas32IxvwVgerxzlmT2X4pjpYEHaj3QicTtsXTeMPDIts+C
 B23TZWGGje/+GtGhcmvMfWcjkOYj1pS2vVfCat83y2lCLgoSzYxf8ywIcfvi8YBAp6dT
 lrMMf/TJUSzZY+xfVFqtaKBEltcJgddFFUvq2qoZ6fWKbAdnLCfeEO2NmbeUA9XwyJed
 tD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708968400; x=1709573200;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1F1DchEk4xMXd8YkeR9HRNWocB7RAiAPE10uy1k/kTQ=;
 b=lvUKAgl8LgWeXq6EWxlWH2tc0kL2kS0EGjPiTz5EN0CYYNXUqrE4TGK/u2cIOZCMUZ
 249Sqs54RFnn7E7zeyMdqu3rmof0XYvvzLWXa5Td61wBIKP6lBS6iZbCja3bk1JILt//
 jQvOKDycxz/rnm7sG/V0saI3H9y20VbRVpUFT/HXMbGurGrnw3GVvG2wjG3omOuuwikf
 YIGRoH0fYBOElZKLvlIFnFSf1Z5rsCbZ0FFIBm7/Evl52+jmC3NIACBlpoxxTIrZLYZY
 xJyjdlFpJ+0qD68SJiRerwZSNUxPpBKwA80KPVdgniJZgRAv3OiybCSGM70rdDkZT8vN
 S3uQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYZxfpWX38NEdY/98aFQVgjwzf+sWoUMHiiTSo8H3W9iQzJo3WUmaAanIgCtCl/qkjkqnEU1fqj007l/IBxjvNsp2Dqw==
X-Gm-Message-State: AOJu0YwVtiZf/PtUOsT2cIzzlEOH+APDYwlyEysZfjMs7IDbeiJJ1cia
 F6mge+0NtCSHeASjbrZKga2icdxxsZWN8oAWPOZkllDqZPjy5n0wRdtPd1YNUD4=
X-Google-Smtp-Source: AGHT+IHS/NK4chbCHD2/hak+Ws88zDV3C4sQMVjfO1nZccNa1s1AWAEPnxN/PpSB6vdbwTYFDB8DEQ==
X-Received: by 2002:adf:fd8e:0:b0:33d:7606:808b with SMTP id
 d14-20020adffd8e000000b0033d7606808bmr5169236wrr.68.1708968399866; 
 Mon, 26 Feb 2024 09:26:39 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bt1-20020a056000080100b0033d9c7eb63csm9142256wrb.84.2024.02.26.09.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 09:26:39 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 26 Feb 2024 17:26:23 +0000
Subject: [PATCH v5 19/39] board: dragonboard820c: use LINUX_KERNEL_IMAGE_HEADER
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-b4-qcom-common-target-v5-19-10c8e078befb@linaro.org>
References: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
In-Reply-To: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=5090;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=R4XlxVlro6ECBMNX/sibK5LqfXD3s/QQuWaBBVFDYjs=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ7J3e9/xTmobdsjdU1Af6sNZrJz4NVxEO937vtO2CZd
 m3dgnsfOkpZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBEyn8yMuxekjCx6O33W0bZ
 SnOMz3P8a1DmmujMFfXrHPutxywei9QZGdb/+Ol4olDZ15hRW3PS5Lt5QhnX4lWq5mzfvzNlaom
 /ngIA
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Sumit Garg <sumit.garg@linaro.org> #qcs404
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
@@ -44,8 +44,9 @@ config TARGET_DRAGONBOARD410C
 	  - 20-pin low speed and 40-pin high speed expanders, 4 LED, 3 buttons
 
 config TARGET_DRAGONBOARD820C
 	bool "96Boards Dragonboard 820C"
+	select LINUX_KERNEL_IMAGE_HEADER
 	imply CLK_QCOM_APQ8096
 	imply PINCTRL_QCOM_APQ8096
 	imply BUTTON_QCOM_PMIC
 	help
diff --git a/board/qualcomm/dragonboard820c/Makefile b/board/qualcomm/dragonboard820c/Makefile
index 643311f5b3ba..2ae6d16364aa 100644
--- a/board/qualcomm/dragonboard820c/Makefile
+++ b/board/qualcomm/dragonboard820c/Makefile
@@ -2,5 +2,4 @@
 #
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

