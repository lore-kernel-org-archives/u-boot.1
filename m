Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618A3C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:06:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29B8D87896;
	Tue, 19 Dec 2023 17:04:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kwQky+W3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C73A8787A; Tue, 19 Dec 2023 17:04:51 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C401787527
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:04:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50dfac6c0beso5858112e87.2
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703001876; x=1703606676; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9imF+YbrKT9/xfJzuapVm/9Tvcy100kolJOoerob2SU=;
 b=kwQky+W33BrL4MwZxA+zQ7aLOChVkfE1r4FCHjy9B9mjv6kaYpAzSCIk6L5SSB0yyK
 Uc3VVSzgDvNtefN2wZhNRIbbw4OjO98lwYYSQOKvHT+4EXWrrGv6FQ9F56kmTWatYQa/
 lUpkvpOMTOUehWxJxH+faF4Z5VuCJbtkHZ8wRqo1+Zb5gHTUEehus/Ez4ro1ruCbMd3Q
 1vGu1/+h8MfoHnFv6j8100hzO0tj7DxZG9aDCyL7yYDgTs5cKnW7aIQcAyfwMhUMhUsb
 QP/CJ8RRDd4HlVQXzb4MlJYPx2OxeDoDXPtpbc7bsq7KmrNMkzCrQ/NV5KM/pwbIuQP/
 90Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703001876; x=1703606676;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9imF+YbrKT9/xfJzuapVm/9Tvcy100kolJOoerob2SU=;
 b=p6sB2p3P1L4ZpO1O2x5Pr+hZApOpmRXunUW3YRgJVsMp+rL8Y1qAKx2PlroeuGBai+
 fuyFqGQWEvPAMaLwDh3UPoZGAiYtq8LY9+0Hde2OcrFM3Zx9d86p8a1NKZTnlXlHj9ok
 3Sdeuoy4/8V3ahm375E80JD1RkEXMtvdysZcgViKDHkZttnx3VaV/rvRu1gB661J4Lz2
 xNlYNQecq5xeJpIbtjicweVp//e5tdZI4zUgMQVosnB0oD4Fvkp+/0/avBL0P9660TBQ
 JaO+7q0a+6WPLZXkntG8pKD8l5pVNsxcmxzfo52DtNcrV3HMHiNsrfAfzrwkD+l4Wosu
 WWqg==
X-Gm-Message-State: AOJu0YyZZ/lVcfRevYfWOjSNnQXleUrlD4m/gQQSsJy5RIEPv4pAfsGK
 viXVyUuhersuVLZV5drMAjJdSw==
X-Google-Smtp-Source: AGHT+IFgI+tAroexp0SvnlnoN0KHXD9m5kLh1/D2K3vippyyieGM797+Davs3Q4rHoPbPn3CMJehKw==
X-Received: by 2002:ac2:4c4a:0:b0:50b:ef70:8d66 with SMTP id
 o10-20020ac24c4a000000b0050bef708d66mr11774792lfk.26.1703001876309; 
 Tue, 19 Dec 2023 08:04:36 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 je17-20020a05600c1f9100b0040d1450ca7esm3429723wmb.7.2023.12.19.08.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 08:04:35 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Dec 2023 16:04:15 +0000
Subject: [PATCH v2 14/32] board: dragonboard820c: use LINUX_KERNEL_IMAGE_HEADER
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-b4-qcom-common-target-v2-14-b6dd9704219e@linaro.org>
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
In-Reply-To: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
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
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTG/UzZ1+6WFN/ctsh7YQjXF5buwrPv3puX3G3Y/s3hX
 l3lN7VNHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAif/gY/ld8MTo8weDp4oIW
 wQ+WIYe+zdv11+f8z9QLHO9mib7R1PBgZFijWN3V77a240NGwyn/mf2+MV0amnt67lp97Jwut2P
 Dlc0A
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

