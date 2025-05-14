Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CD9C3ABD8
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 22:50:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 940D782B3D;
	Thu, 15 May 2025 00:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NzDFYPNn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B787682B19; Thu, 15 May 2025 00:50:18 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8E8482AC1
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 00:50:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6066c02cd92so199627eaf.2
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 15:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747263013; x=1747867813; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5iXnTgbVOW3fbG6yuQdiUmbiX5p9Mudw8xLN4VJl0ME=;
 b=NzDFYPNnyomW4WdqAaPsCGF5bt5xco0Hu+5wx3eAXAQhheGiXfmfGx/E9FfP1a4CWe
 wb2M7aX/cefIF3Jbf+fbInmlwYgs6rCNFBWsMVvdUS68bCnWrEgVHaaP3FIP31rP2IMO
 qUKPKmMVCVY/xHe2/rrde2YquzOuoBO/43N+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747263013; x=1747867813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5iXnTgbVOW3fbG6yuQdiUmbiX5p9Mudw8xLN4VJl0ME=;
 b=Ak8FkTMI4Fc6ljlUHV7DlHquwT/+K1DBOrros8wWmBdOq95xE/zDIY7fKwKr4kAKZG
 6DZ1rFFmdJCpvs78yfX3NOMnSii1fZ6fj+mmnpQkVjCotI870QYffThrfQu+hkhiFoKA
 dCCa6JV880QSw0Yt9KtB0DM6vtLZT3zDTNUZ35uzLB34EWP0D2oEfRqbQNb56OXUI+qL
 7uvqnYRIz9jyc/9Huuraw1v7YKgQa58dLk1PdqZ1P1rvZz+4HOOPKPbxwkmYX+1EKpG8
 g9tbr/XqhkgfF9HN/nb70INqiR8B8pYVK6wzBIiA8lmxTbUfcgv98At4R0y1TZuIszwx
 lwOg==
X-Gm-Message-State: AOJu0YwU/2Td9dWx4r4DKi+cGGyZencHv4uRVSvR8yeoTIDky3h8t3/2
 ig1TsWd1dPoBPzboUghtYLQ2IEOyWjjR77H3kPb4viHilwOFoP5pQbgfCn2XfIYM/Z7Kdcg79In
 C
X-Gm-Gg: ASbGncvz/GGdeT5cVgWScXOc2sqT/vsgf/3keaVhEyGBMwPzfV9I2ekCdsz7BGBcmjP
 WUHHTaePD4yFYQJrT6dfdWOPTLpLrwhzjc1g8yxyHcbp6LpFn1ExK+Ic375Eqm2zqdNxs8m6lTS
 /5uGkNgTgS4OVvQoFRdlOmAkr4Tkec0+qmu9zdGexXiit0WKQA83nTbTWiA+mhku8tbuu7TqLjw
 Z25VIAuvtyQMstwKo3rTrWeLHtYEw6RH1bpgCPZ/3bHSasL57h7iCYsXDYLVWWhNq1yStl0Pioq
 VCNsR6bPTO5EG36TgjwABSn/+triGO3r0J5Sg+w6SwSoZf0Hpv1MQZK6rjAy91PWNYuCu8RZTTI
 n6JrIeUuS/kyNEgc=
X-Google-Smtp-Source: AGHT+IGr+kf8uvWDm+4qGqpiNOXK1FxeOCrZWeQEAKG/hHldJtj5DmLuNuTJLALJ5I/byPzA0FImPQ==
X-Received: by 2002:a4a:ee0d:0:b0:604:5e57:80ab with SMTP id
 006d021491bc7-609df0836bfmr2727318eaf.0.1747263013482; 
 Wed, 14 May 2025 15:50:13 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6083fe52271sm2636530eaf.21.2025.05.14.15.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 15:50:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Simon Glass <sjg@chromium.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Stefan Bosch <stefan_b@posteo.net>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH 4/5] global: Avoid indirect inclusion of <env.h> from
 <command.h>
Date: Wed, 14 May 2025 16:46:03 -0600
Message-ID: <20250514225002.15361-5-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250514225002.15361-1-trini@konsulko.com>
References: <20250514225002.15361-1-trini@konsulko.com>
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

The include file <command.h> does not need anything from <env.h>.
Furthermore, include/env.h itself includes other headers which can lead
to longer indirect inclusion paths. To prepare to remove <env.h> from
<command.h> fix all of the places which had relied on this indirect
inclusion to instead include <env.h> directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Anatolij Gustschin <agust@denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Marek Vasut <marex@denx.de>
Cc: Mark Kettenis <kettenis@openbsd.org>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Cc: Stefan Bosch <stefan_b@posteo.net>
Cc: Tien Fong Chee <tien.fong.chee@altera.com>
Cc: Tingting Meng <tingting.meng@altera.com>
Cc: Tobias Waldekranz <tobias@waldekranz.com>
---
 arch/arm/cpu/armv8/fsl-layerscape/fdt.c             | 1 +
 arch/arm/mach-apple/board.c                         | 1 +
 arch/arm/mach-k3/r5/common.c                        | 1 +
 arch/arm/mach-socfpga/board.c                       | 1 +
 arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c | 1 +
 board/liebherr/mccmon6/spl.c                        | 1 +
 board/siemens/common/board_am335x.c                 | 1 +
 board/socionext/developerbox/fwu_plat.c             | 1 +
 boot/bootmeth_android.c                             | 1 +
 cmd/abootimg.c                                      | 1 +
 cmd/adc.c                                           | 1 +
 cmd/armflash.c                                      | 1 +
 cmd/bcb.c                                           | 1 +
 cmd/blkmap.c                                        | 1 +
 cmd/bootflow.c                                      | 1 +
 cmd/booti.c                                         | 1 +
 cmd/bootmeth.c                                      | 1 +
 cmd/broadcom/nitro_image_load.c                     | 1 +
 cmd/extension_board.c                               | 1 +
 cmd/hash.c                                          | 1 +
 cmd/mbr.c                                           | 1 +
 cmd/mem.c                                           | 1 +
 cmd/mmc.c                                           | 1 +
 cmd/sandbox/exception.c                             | 1 +
 cmd/seama.c                                         | 1 +
 cmd/spawn.c                                         | 1 +
 cmd/upl.c                                           | 1 +
 cmd/x86/zboot.c                                     | 1 +
 common/usb.c                                        | 1 +
 drivers/power/axp221.c                              | 1 +
 drivers/video/nexell_display.c                      | 1 +
 lib/efi_loader/efi_firmware.c                       | 1 +
 test/boot/bootdev.c                                 | 1 +
 test/boot/bootflow.c                                | 1 +
 test/boot/bootm.c                                   | 1 +
 test/boot/bootmeth.c                                | 1 +
 test/boot/measurement.c                             | 1 +
 test/boot/upl.c                                     | 1 +
 test/cmd/fdt.c                                      | 1 +
 test/cmd/hash.c                                     | 1 +
 test/cmd/mem_search.c                               | 1 +
 test/cmd/setexpr.c                                  | 1 +
 test/common/test_autoboot.c                         | 1 +
 test/dm/blkmap.c                                    | 1 +
 test/dm/button.c                                    | 1 +
 test/dm/fastboot.c                                  | 1 +
 test/dm/part.c                                      | 1 +
 test/env/fdt.c                                      | 1 +
 test/hush/dollar.c                                  | 1 +
 test/hush/if.c                                      | 1 +
 test/hush/loop.c                                    | 1 +
 51 files changed, 51 insertions(+)

diff --git a/arch/arm/cpu/armv8/fsl-layerscape/fdt.c b/arch/arm/cpu/armv8/fsl-layerscape/fdt.c
index ca6be3626fbe..e8d2339f1a3b 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/fdt.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/fdt.c
@@ -7,6 +7,7 @@
 #include <config.h>
 #include <clock_legacy.h>
 #include <efi_loader.h>
+#include <env.h>
 #include <log.h>
 #include <asm/cache.h>
 #include <linux/libfdt.h>
diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
index 2644a04a6228..2604c5a710ef 100644
--- a/arch/arm/mach-apple/board.c
+++ b/arch/arm/mach-apple/board.c
@@ -6,6 +6,7 @@
 #include <dm.h>
 #include <dm/uclass-internal.h>
 #include <efi_loader.h>
+#include <env.h>
 #include <lmb.h>
 
 #include <asm/armv8/mmu.h>
diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index 0b6604039f3e..fa146549f137 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+#include <env.h>
 #include <linux/printk.h>
 #include <linux/types.h>
 #include <asm/hardware.h>
diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/board.c
index 8506d5104134..bda123248033 100644
--- a/arch/arm/mach-socfpga/board.c
+++ b/arch/arm/mach-socfpga/board.c
@@ -7,6 +7,7 @@
 
 #include <config.h>
 #include <errno.h>
+#include <env.h>
 #include <fdtdec.h>
 #include <log.h>
 #include <init.h>
diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c b/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c
index 04640e476e6b..506ecac2ef08 100644
--- a/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c
+++ b/arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c
@@ -6,6 +6,7 @@
 #include <bootm.h>
 #include <command.h>
 #include <dfu.h>
+#include <env.h>
 #include <image.h>
 #include <asm/arch/stm32prog.h>
 #include <linux/printk.h>
diff --git a/board/liebherr/mccmon6/spl.c b/board/liebherr/mccmon6/spl.c
index b1f6881275d5..e612d9e9ce03 100644
--- a/board/liebherr/mccmon6/spl.c
+++ b/board/liebherr/mccmon6/spl.c
@@ -5,6 +5,7 @@
  *         Richard Hu <hakahu@gmail.com>
  */
 
+#include <env.h>
 #include <image.h>
 #include <init.h>
 #include <asm/arch/clock.h>
diff --git a/board/siemens/common/board_am335x.c b/board/siemens/common/board_am335x.c
index daf0bb930ec0..939ff81797dd 100644
--- a/board/siemens/common/board_am335x.c
+++ b/board/siemens/common/board_am335x.c
@@ -10,6 +10,7 @@
  */
 
 #include <command.h>
+#include <env.h>
 #include <serial.h>
 #include <watchdog.h>
 #include <asm/arch/clock.h>
diff --git a/board/socionext/developerbox/fwu_plat.c b/board/socionext/developerbox/fwu_plat.c
index a8b111477ef9..5d2f40f241ce 100644
--- a/board/socionext/developerbox/fwu_plat.c
+++ b/board/socionext/developerbox/fwu_plat.c
@@ -4,6 +4,7 @@
  */
 
 #include <efi_loader.h>
+#include <env.h>
 #include <fwu.h>
 #include <fwu_mdata.h>
 #include <memalign.h>
diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 654ebfdf1fcc..8c2bde10e171 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -18,6 +18,7 @@
 #include <bootm.h>
 #include <bootmeth.h>
 #include <dm.h>
+#include <env.h>
 #include <image.h>
 #include <malloc.h>
 #include <mapmem.h>
diff --git a/cmd/abootimg.c b/cmd/abootimg.c
index ae7a1a7c83b0..44de00fb9c97 100644
--- a/cmd/abootimg.c
+++ b/cmd/abootimg.c
@@ -6,6 +6,7 @@
 
 #include <android_image.h>
 #include <command.h>
+#include <env.h>
 #include <image.h>
 #include <mapmem.h>
 
diff --git a/cmd/adc.c b/cmd/adc.c
index 4d3b5b61f6f0..334ba7fdeca8 100644
--- a/cmd/adc.c
+++ b/cmd/adc.c
@@ -5,6 +5,7 @@
  */
 #include <command.h>
 #include <dm.h>
+#include <env.h>
 #include <adc.h>
 #include <linux/printk.h>
 
diff --git a/cmd/armflash.c b/cmd/armflash.c
index 83f616db4efb..cde275c881b1 100644
--- a/cmd/armflash.c
+++ b/cmd/armflash.c
@@ -7,6 +7,7 @@
  */
 #include <command.h>
 #include <console.h>
+#include <env.h>
 #include <flash.h>
 #include <vsprintf.h>
 #include <linux/string.h>
diff --git a/cmd/bcb.c b/cmd/bcb.c
index 16eabfe00f5a..d6d944bd6b31 100644
--- a/cmd/bcb.c
+++ b/cmd/bcb.c
@@ -8,6 +8,7 @@
 #include <android_bootloader_message.h>
 #include <bcb.h>
 #include <command.h>
+#include <env.h>
 #include <android_ab.h>
 #include <display_options.h>
 #include <log.h>
diff --git a/cmd/blkmap.c b/cmd/blkmap.c
index 86a123b1cd37..65edec899e2c 100644
--- a/cmd/blkmap.c
+++ b/cmd/blkmap.c
@@ -7,6 +7,7 @@
 #include <blk.h>
 #include <blkmap.h>
 #include <command.h>
+#include <env.h>
 #include <malloc.h>
 #include <dm/device.h>
 
diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index a1fd59a69f47..d4f7d3361500 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -13,6 +13,7 @@
 #include <command.h>
 #include <console.h>
 #include <dm.h>
+#include <env.h>
 #include <mapmem.h>
 
 /**
diff --git a/cmd/booti.c b/cmd/booti.c
index 1a57fe913977..7e6d94262993 100644
--- a/cmd/booti.c
+++ b/cmd/booti.c
@@ -6,6 +6,7 @@
 
 #include <bootm.h>
 #include <command.h>
+#include <env.h>
 #include <image.h>
 #include <irq_func.h>
 #include <lmb.h>
diff --git a/cmd/bootmeth.c b/cmd/bootmeth.c
index 2f41fa1bec6b..ea4b3f47db8a 100644
--- a/cmd/bootmeth.c
+++ b/cmd/bootmeth.c
@@ -11,6 +11,7 @@
 #include <bootstd.h>
 #include <command.h>
 #include <dm.h>
+#include <env.h>
 #include <malloc.h>
 #include <dm/uclass-internal.h>
 
diff --git a/cmd/broadcom/nitro_image_load.c b/cmd/broadcom/nitro_image_load.c
index 289b184e9afd..fe08679840ef 100644
--- a/cmd/broadcom/nitro_image_load.c
+++ b/cmd/broadcom/nitro_image_load.c
@@ -4,6 +4,7 @@
  */
 
 #include <command.h>
+#include <env.h>
 #include <vsprintf.h>
 
 #define FW_IMAGE_SIG	0xff123456
diff --git a/cmd/extension_board.c b/cmd/extension_board.c
index 6c14d0ddebdc..317b260bf36a 100644
--- a/cmd/extension_board.c
+++ b/cmd/extension_board.c
@@ -7,6 +7,7 @@
 #include <bootdev.h>
 #include <command.h>
 #include <dm.h>
+#include <env.h>
 #include <malloc.h>
 #include <extension_board.h>
 #include <mapmem.h>
diff --git a/cmd/hash.c b/cmd/hash.c
index 5b40982b098d..96d0e443a5b6 100644
--- a/cmd/hash.c
+++ b/cmd/hash.c
@@ -10,6 +10,7 @@
  */
 
 #include <command.h>
+#include <env.h>
 #include <hash.h>
 #include <linux/ctype.h>
 
diff --git a/cmd/mbr.c b/cmd/mbr.c
index 7e1f92a13bb5..7fe6c9e103ab 100644
--- a/cmd/mbr.c
+++ b/cmd/mbr.c
@@ -10,6 +10,7 @@
 
 #include <blk.h>
 #include <command.h>
+#include <env.h>
 #include <malloc.h>
 #include <part.h>
 #include <vsprintf.h>
diff --git a/cmd/mem.c b/cmd/mem.c
index e5b9cb293491..b8afe62e4749 100644
--- a/cmd/mem.c
+++ b/cmd/mem.c
@@ -17,6 +17,7 @@
 #include <compiler.h>
 #include <console.h>
 #include <display_options.h>
+#include <env.h>
 #ifdef CONFIG_MTD_NOR_FLASH
 #include <flash.h>
 #endif
diff --git a/cmd/mmc.c b/cmd/mmc.c
index fe7899ec793c..5340a58be8ee 100644
--- a/cmd/mmc.c
+++ b/cmd/mmc.c
@@ -8,6 +8,7 @@
 #include <command.h>
 #include <console.h>
 #include <display_options.h>
+#include <env.h>
 #include <mapmem.h>
 #include <memalign.h>
 #include <mmc.h>
diff --git a/cmd/sandbox/exception.c b/cmd/sandbox/exception.c
index f9c847d8ff28..e015acf60e2b 100644
--- a/cmd/sandbox/exception.c
+++ b/cmd/sandbox/exception.c
@@ -6,6 +6,7 @@
  */
 
 #include <command.h>
+#include <env.h>
 
 static int do_sigsegv(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
diff --git a/cmd/seama.c b/cmd/seama.c
index 3c8e81992340..d62879780906 100644
--- a/cmd/seama.c
+++ b/cmd/seama.c
@@ -5,6 +5,7 @@
  */
 
 #include <command.h>
+#include <env.h>
 #include <nand.h>
 
 /*
diff --git a/cmd/spawn.c b/cmd/spawn.c
index 37737b8627c8..8829aa9728d2 100644
--- a/cmd/spawn.c
+++ b/cmd/spawn.c
@@ -5,6 +5,7 @@
 
 #include <command.h>
 #include <console.h>
+#include <env.h>
 #include <malloc.h>
 #include <vsprintf.h>
 #include <uthread.h>
diff --git a/cmd/upl.c b/cmd/upl.c
index c9a823bbc064..ef2183d85281 100644
--- a/cmd/upl.c
+++ b/cmd/upl.c
@@ -12,6 +12,7 @@
 #include <alist.h>
 #include <command.h>
 #include <display_options.h>
+#include <env.h>
 #include <mapmem.h>
 #include <string.h>
 #include <upl.h>
diff --git a/cmd/x86/zboot.c b/cmd/x86/zboot.c
index 94e602b8a5b6..3876d1632362 100644
--- a/cmd/x86/zboot.c
+++ b/cmd/x86/zboot.c
@@ -8,6 +8,7 @@
 #define LOG_CATEGORY	LOGC_BOOT
 
 #include <command.h>
+#include <env.h>
 #include <mapmem.h>
 #include <vsprintf.h>
 #include <asm/zimage.h>
diff --git a/common/usb.c b/common/usb.c
index 7a8435296c67..6a4ad346f4ba 100644
--- a/common/usb.c
+++ b/common/usb.c
@@ -28,6 +28,7 @@
 #include <command.h>
 #include <dm.h>
 #include <dm/device_compat.h>
+#include <env.h>
 #include <log.h>
 #include <malloc.h>
 #include <memalign.h>
diff --git a/drivers/power/axp221.c b/drivers/power/axp221.c
index c22ca03f4694..f5daa2430821 100644
--- a/drivers/power/axp221.c
+++ b/drivers/power/axp221.c
@@ -10,6 +10,7 @@
  */
 
 #include <command.h>
+#include <env.h>
 #include <errno.h>
 #include <asm/arch/pmic_bus.h>
 #include <axp_pmic.h>
diff --git a/drivers/video/nexell_display.c b/drivers/video/nexell_display.c
index 7bda33fb16e1..ea3776258a00 100644
--- a/drivers/video/nexell_display.c
+++ b/drivers/video/nexell_display.c
@@ -10,6 +10,7 @@
 #include <config.h>
 #include <command.h>
 #include <dm.h>
+#include <env.h>
 #include <mapmem.h>
 #include <malloc.h>
 #include <linux/compat.h>
diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index d44dc09813e3..75501e215575 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -12,6 +12,7 @@
 #include <dfu.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
+#include <env.h>
 #include <fwu.h>
 #include <image.h>
 #include <signatures.h>
diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index 9af947868707..a5f3d4462a94 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -10,6 +10,7 @@
 #include <dm.h>
 #include <bootdev.h>
 #include <bootflow.h>
+#include <env.h>
 #include <mapmem.h>
 #include <os.h>
 #include <test/ut.h>
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index b261bd5f620e..a930d2cc309a 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -14,6 +14,7 @@
 #include <dm.h>
 #include <efi.h>
 #include <efi_loader.h>
+#include <env.h>
 #include <expo.h>
 #include <mapmem.h>
 #ifdef CONFIG_SANDBOX
diff --git a/test/boot/bootm.c b/test/boot/bootm.c
index 1d1efe71ad52..ed60094f3c1a 100644
--- a/test/boot/bootm.c
+++ b/test/boot/bootm.c
@@ -6,6 +6,7 @@
  */
 
 #include <bootm.h>
+#include <env.h>
 #include <asm/global_data.h>
 #include <test/test.h>
 #include <test/ut.h>
diff --git a/test/boot/bootmeth.c b/test/boot/bootmeth.c
index 577f259fb371..2ef3569ad837 100644
--- a/test/boot/bootmeth.c
+++ b/test/boot/bootmeth.c
@@ -9,6 +9,7 @@
 #include <bootmeth.h>
 #include <bootstd.h>
 #include <dm.h>
+#include <env.h>
 #include <test/ut.h>
 #include "bootstd_common.h"
 
diff --git a/test/boot/measurement.c b/test/boot/measurement.c
index 1d38663fc0f8..71f503f1567d 100644
--- a/test/boot/measurement.c
+++ b/test/boot/measurement.c
@@ -7,6 +7,7 @@
  */
 
 #include <bootm.h>
+#include <env.h>
 #include <malloc.h>
 #include <test/test.h>
 #include <test/ut.h>
diff --git a/test/boot/upl.c b/test/boot/upl.c
index eec89026fc30..e2dc3d51edaa 100644
--- a/test/boot/upl.c
+++ b/test/boot/upl.c
@@ -7,6 +7,7 @@
  */
 
 #include <abuf.h>
+#include <env.h>
 #include <mapmem.h>
 #include <upl.h>
 #include <dm/ofnode.h>
diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
index c11c181c807c..96a8488e1720 100644
--- a/test/cmd/fdt.c
+++ b/test/cmd/fdt.c
@@ -6,6 +6,7 @@
  */
 
 #include <console.h>
+#include <env.h>
 #include <fdt_support.h>
 #include <mapmem.h>
 #include <asm/global_data.h>
diff --git a/test/cmd/hash.c b/test/cmd/hash.c
index 296dd762b31d..bb96380c351a 100644
--- a/test/cmd/hash.c
+++ b/test/cmd/hash.c
@@ -6,6 +6,7 @@
  */
 
 #include <command.h>
+#include <env.h>
 #include <dm.h>
 #include <dm/test.h>
 #include <test/test.h>
diff --git a/test/cmd/mem_search.c b/test/cmd/mem_search.c
index df8938bdb6c6..61de0dfb9a98 100644
--- a/test/cmd/mem_search.c
+++ b/test/cmd/mem_search.c
@@ -7,6 +7,7 @@
  */
 
 #include <console.h>
+#include <env.h>
 #include <mapmem.h>
 #include <dm/test.h>
 #include <test/ut.h>
diff --git a/test/cmd/setexpr.c b/test/cmd/setexpr.c
index 85803eb54b8c..93b0c4b68f50 100644
--- a/test/cmd/setexpr.c
+++ b/test/cmd/setexpr.c
@@ -7,6 +7,7 @@
  */
 
 #include <console.h>
+#include <env.h>
 #include <mapmem.h>
 #include <dm/test.h>
 #include <test/ut.h>
diff --git a/test/common/test_autoboot.c b/test/common/test_autoboot.c
index e3050d02c605..5feff57c2714 100644
--- a/test/common/test_autoboot.c
+++ b/test/common/test_autoboot.c
@@ -6,6 +6,7 @@
  */
 
 #include <autoboot.h>
+#include <env.h>
 #include <test/common.h>
 #include <test/test.h>
 #include <test/ut.h>
diff --git a/test/dm/blkmap.c b/test/dm/blkmap.c
index a6a0b4d4e208..d04b68b50aec 100644
--- a/test/dm/blkmap.c
+++ b/test/dm/blkmap.c
@@ -7,6 +7,7 @@
 #include <blk.h>
 #include <blkmap.h>
 #include <dm.h>
+#include <env.h>
 #include <asm/test.h>
 #include <dm/test.h>
 #include <test/test.h>
diff --git a/test/dm/button.c b/test/dm/button.c
index 3612f308f029..f05f4ca27ceb 100644
--- a/test/dm/button.c
+++ b/test/dm/button.c
@@ -8,6 +8,7 @@
 #include <dm.h>
 #include <adc.h>
 #include <button.h>
+#include <env.h>
 #include <power/regulator.h>
 #include <power/sandbox_pmic.h>
 #include <asm/gpio.h>
diff --git a/test/dm/fastboot.c b/test/dm/fastboot.c
index 73c43f829240..5b51b6bf9dd4 100644
--- a/test/dm/fastboot.c
+++ b/test/dm/fastboot.c
@@ -4,6 +4,7 @@
  */
 
 #include <dm.h>
+#include <env.h>
 #include <fastboot.h>
 #include <fb_mmc.h>
 #include <mmc.h>
diff --git a/test/dm/part.c b/test/dm/part.c
index c5c4b3fdba1b..caae23bd4aad 100644
--- a/test/dm/part.c
+++ b/test/dm/part.c
@@ -4,6 +4,7 @@
  */
 
 #include <dm.h>
+#include <env.h>
 #include <mmc.h>
 #include <part.h>
 #include <part_efi.h>
diff --git a/test/env/fdt.c b/test/env/fdt.c
index c495ac7b307c..3652563f3304 100644
--- a/test/env/fdt.c
+++ b/test/env/fdt.c
@@ -1,4 +1,5 @@
 #include <command.h>
+#include <env.h>
 #include <env_attr.h>
 #include <test/env.h>
 #include <test/ut.h>
diff --git a/test/hush/dollar.c b/test/hush/dollar.c
index 820110799a20..b83a64d091d1 100644
--- a/test/hush/dollar.c
+++ b/test/hush/dollar.c
@@ -5,6 +5,7 @@
  */
 
 #include <command.h>
+#include <env.h>
 #include <env_attr.h>
 #include <test/hush.h>
 #include <test/ut.h>
diff --git a/test/hush/if.c b/test/hush/if.c
index 8939b7a6c86f..ea615b246a9a 100644
--- a/test/hush/if.c
+++ b/test/hush/if.c
@@ -5,6 +5,7 @@
  */
 
 #include <command.h>
+#include <env.h>
 #include <env_attr.h>
 #include <vsprintf.h>
 #include <test/hush.h>
diff --git a/test/hush/loop.c b/test/hush/loop.c
index 7154b9bc0ae3..ea72ac773bac 100644
--- a/test/hush/loop.c
+++ b/test/hush/loop.c
@@ -5,6 +5,7 @@
  */
 
 #include <command.h>
+#include <env.h>
 #include <env_attr.h>
 #include <test/hush.h>
 #include <test/ut.h>
-- 
2.43.0

