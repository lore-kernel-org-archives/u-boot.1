Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CEDC46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 14:08:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E17287DF2;
	Tue, 30 Jan 2024 15:05:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pvNtaIZZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59DE487E62; Tue, 30 Jan 2024 15:05:35 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D69187E2E
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 15:05:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40eacb6067dso53525785e9.1
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 06:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706623525; x=1707228325; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hedvLCBGTFqiZWiz4XRvF+evYWYUdkNfoVGfxo+rH6Q=;
 b=pvNtaIZZkinbOuUu9N/F2Yl9hv48M4QCG1cglG9ZnC9jnA3WVtNFdqxUnoGb3P8+Rn
 jthRD/RG9+kn6LyYrUCbCtelKbL/LgkyD/+JmqGSciC8rRpy5dbqDCY0kcSfMnVqzueY
 7go4BZDabPHm0OMAYX5P0AamvnrZou41+NG+oJPuvGlstptsdfAoWL8DazETgzZzW32q
 gjPSvF/dfN5GjVNox/BpQZzcGQ++fdJqld0bEsLY3hLwGi758T2FuVyOt3AoHcUjUFDb
 GsAtZeMiHc+/omcRYS51Br4wkMUtOeEwjVWXsR9L/ccvDjCrzsrPgISbuaFmxb2fKexB
 zz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706623525; x=1707228325;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hedvLCBGTFqiZWiz4XRvF+evYWYUdkNfoVGfxo+rH6Q=;
 b=cGmINORrPP3MgZN3AInuRTm7fAvKW95+0lUsnW74Tsc1FjIDw8TA59EQZVh1be4qOs
 WT9efa+7yiCRdgdffIagW2DXhQaulKWztb3zXgmcfpq4g6WQ/t6FKEUiGcE8StzJZdpx
 sVw3V07UlU9A8pogpxnKmc837IsRoqv6CeKxdb2xW701TtJcwZSsz4QJWXKGS4ScktQt
 2eVM+W6nxpX0Rc7zZq8zSQnMBTc2dH6jmUCPmpcIkAcnjWEbqdXtjVgbI53J5USSAK/a
 085QWMEzA6a8IzV1IpiOHKM8H8RzbLjgucjyTqWtSLcQl4plQxVYIN3VtpidTWKfwzIj
 DGSw==
X-Gm-Message-State: AOJu0YyeXP0zqlODXd+JoPCfIntDo3SFNM2jvlRASJMnsyWz0kwhTYQp
 SJzgQvDeDcCe3bDAEW3onbSs9omck+v3m3CCv7UAUE1WFKmyS5oY2X3A20iNrek=
X-Google-Smtp-Source: AGHT+IHWsSyO0nrHakLdcCISUxyf1apNXq29H6EmLiQuXfyjTe8wq5Ts3I5E9yffwcLPvcdk6GMZYw==
X-Received: by 2002:a05:600c:1d1b:b0:40e:a255:4bf4 with SMTP id
 l27-20020a05600c1d1b00b0040ea2554bf4mr6824740wms.22.1706623525146; 
 Tue, 30 Jan 2024 06:05:25 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a05600c310b00b0040f035bebfcsm1799017wmo.12.2024.01.30.06.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 06:05:24 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 30 Jan 2024 14:05:04 +0000
Subject: [PATCH v3 16/36] board: dragonboard820c: use LINUX_KERNEL_IMAGE_HEADER
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-b4-qcom-common-target-v3-16-e523cbf9e556@linaro.org>
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
In-Reply-To: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
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
 bh=eWkWlypoj8c0dGGrCiOqR8wkjpHHs4WYHdO0HeFbRZU=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSdTILG0+8zfVHy9HWd0divpsy785xFp2vcGpMt61mmB
 /7aJXa9o5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAExk/wdGhl1rcs8v6wp4d+rc
 xVNfdnJOyxVlDrh+unDm/FA1jmRJRzuGf2ZKcit1WgotNOotrnO6hczYlS/0eYG1a8qnfCFW1rq
 p+wE=
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
2.43.0

