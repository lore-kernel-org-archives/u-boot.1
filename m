Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E11CF34C1
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 14:55:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 698E883F93;
	Wed, 19 Nov 2025 15:55:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oOKMEDKf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9F4683F69; Wed, 19 Nov 2025 15:55:20 +0100 (CET)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3F1783F42
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:55:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-65763315216so926091eaf.0
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763564117; x=1764168917; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=kl517FnGId5SZ+4j1QsvMRngeubHv7e7VqtM3+hRGp4=;
 b=oOKMEDKfjVkZ21w4JygpCig0ob52UAlARp6ZzCWSM1bEVYSXqNdC8B+iHXxGAr7LC8
 vyAeCRV3xdCsSAdeYS52fK5do/2XRCi7bT3Rq6NqgrDOvAaENaeGKYgWzm5sRuJ4Twhq
 FJ+7etmHJ3f1GL8TqpBcHELApNXNTJyYaYmDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763564117; x=1764168917;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kl517FnGId5SZ+4j1QsvMRngeubHv7e7VqtM3+hRGp4=;
 b=F4oRgg/yBKKRz0tubhVP9ppof0VEtZgs6dN84U/s/zFOtwN+kSj51wDMP8gCW5sAz0
 +QsjFVJBp7fvG3HEFF1Z4VwjsU1tROxzvbpyvcnyr1M8uTRpUreWNjJazhRh8TtV4O8E
 0VHI3AM7uGmFGPinGaBfrkG9yQHHOZBKSaIgn6X5IYk4NRSRtg5IbFh2sO2+xeMCTrDP
 JLDj34M9a7BOB2U22jN2g4dzW/muXt5fLqtdg40IVsziaflpZOhBNwo9zk4VkSxfX6w4
 QKeh8gJBnSgru8lZrlDeqVihO9E9OJjXef+NWoluRcPlwldQCtosAyBwP/OpDHcaTRhd
 D5GA==
X-Gm-Message-State: AOJu0YyM6bYd2BTUIrZaPUw9QxDJH9rEwY8olr4MIxWvikxkElJuh3Et
 Krcmra8bVFaGglnoSrd5kJ5uN4TQCWxttC7yyhRbywaf63g0CVzFzvjnuJys4u2pXcH2ltAepTl
 Jr3fgMibEIA==
X-Gm-Gg: ASbGncsp8nO6RsgxlYXRA1ZuOcb5pxWqiSVWjUnwW3QGxj3a4LNd+NKEpqIxMJmmPNP
 BvVaBnSuKAP+ySuKaE0V/VR3KJzPnVGGlZ4RvqUtp53voxjJcSaRHtKCMVlt3rKHD+/SBoLRfFU
 oAjEGcQItN8ZyEtmsRTjgaZOj9XW9MerufZFdsZhLd6kfmzCnEtQRdpf//uUceHXBsGWAjzsqNw
 nMDHPPUamkTifyw6Oy1+oPaBM5sasmPgbPX6Uy7QgXQPohTN5hvC93t4P2Tcjqg7n2T7Kr/LUAY
 CfJcP/9wNAfvWv3rTRWp3xFFkjzwxrYb/2UQpcddHROnCudoeSznXCgfLnOLrDp42vCiLTW1l5P
 61okXsKoGp3zoqxsS78cSBMQYtQtT2/bjoxqk5LBgYKhMxT0NQeg+GNpZLreOLmpUAhCbS+1kqL
 5LABRjlzKGWtFm2YSuMI0zXfBO+V+Og8K5BANWqp6AHJlCXc2wD7y5
X-Google-Smtp-Source: AGHT+IGKxy3eRI3ao/Cm3AfaMFjogoYuVFZ/o++WtfCyWlNUPHUV2zUJihwQW2kU5DNGfsjk6csFlg==
X-Received: by 2002:a05:6870:64a2:b0:3ec:2fa7:8180 with SMTP id
 586e51a60fabf-3ec2fa789d9mr6279661fac.0.1763564117231; 
 Wed, 19 Nov 2025 06:55:17 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e8834111c5sm5431170fac.13.2025.11.19.06.55.16
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 06:55:16 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] arm: Remove remainder of xpress board code
Date: Wed, 19 Nov 2025 08:55:15 -0600
Message-ID: <20251119145516.843145-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

When this platform was removed the config header file was missed. Remove
that now.

Fixes: ddfc00400965 ("arm: Remove xpress board")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/configs/xpress.h | 86 ----------------------------------------
 1 file changed, 86 deletions(-)
 delete mode 100644 include/configs/xpress.h

diff --git a/include/configs/xpress.h b/include/configs/xpress.h
deleted file mode 100644
index aa4dd3e9b8d9..000000000000
--- a/include/configs/xpress.h
+++ /dev/null
@@ -1,86 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2015-2016 Stefan Roese <sr@denx.de>
- *
- * Configuration settings for the CCV xPress board
- */
-#ifndef __XPRESS_CONFIG_H
-#define __XPRESS_CONFIG_H
-
-#include "mx6_common.h"
-#include <asm/mach-imx/gpio.h>
-
-#define CFG_MXC_UART_BASE		MX6UL_UART7_BASE_ADDR
-
-/* MMC Configs */
-#define CFG_SYS_FSL_ESDHC_ADDR	USDHC2_BASE_ADDR
-
-/* Miscellaneous configurable options */
-
-/* Physical Memory Map */
-#define PHYS_SDRAM			MMDC0_ARB_BASE_ADDR
-#define PHYS_SDRAM_SIZE			(128 << 20)
-
-#define CFG_SYS_SDRAM_BASE		PHYS_SDRAM
-#define CFG_SYS_INIT_RAM_ADDR	IRAM_BASE_ADDR
-#define CFG_SYS_INIT_RAM_SIZE	IRAM_SIZE
-
-/* Environment is in stored in the eMMC boot partition */
-
-#define CFG_FEC_ENET_DEV		0
-#define CFG_FEC_MXC_PHYADDR          0x0
-
-#define CFG_EXTRA_ENV_SETTINGS \
-	"script=boot.scr\0" \
-	"image=zImage\0" \
-	"console=ttymxc6\0" \
-	"fdt_high=0xffffffff\0" \
-	"initrd_high=0xffffffff\0" \
-	"fdt_file=undefined\0" \
-	"fdt_addr=0x83000000\0" \
-	"boot_fdt=try\0" \
-	"ip_dyn=yes\0" \
-	"mmcdev="__stringify(CONFIG_ENV_MMC_DEVICE_INDEX)"\0" \
-	"mmcpart=1\0" \
-	"mmcroot=/dev/mmcblk0p2 rootwait rw\0" \
-	"mmcautodetect=yes\0" \
-	"mmcargs=setenv bootargs console=${console},${baudrate} " \
-		"root=${mmcroot}\0" \
-	"loadbootscript=" \
-		"fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};\0" \
-	"bootscript=echo Running bootscript from mmc ...; " \
-		"source\0" \
-	"loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}\0" \
-	"loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr} ${fdt_file}\0" \
-	"mmcboot=echo Booting from mmc ...; " \
-		"run mmcargs; " \
-		"if test ${boot_fdt} = yes || test ${boot_fdt} = try; then " \
-			"if run loadfdt; then " \
-				"bootz ${loadaddr} - ${fdt_addr}; " \
-			"else " \
-				"if test ${boot_fdt} = try; then " \
-					"bootz; " \
-				"else " \
-					"echo WARN: Cannot load the DT; " \
-				"fi; " \
-			"fi; " \
-		"else " \
-			"bootz; " \
-		"fi;\0" \
-	"uboot=ccv/u-boot.imx\0"					\
-	"uboot_start=0x2\0"						\
-	"uboot_size=0x3fe\0"						\
-	"update_uboot=if tftp ${uboot}; then "				\
-		"if itest ${filesize} > 0; then "			\
-			"mmc dev 0 1;"					\
-			"setexpr blkc ${filesize} / 0x200;"		\
-			"setexpr blkc ${blkc} + 1;"			\
-			"if itest ${blkc} <= ${uboot_size}; then "	\
-				"mmc write ${loadaddr} ${uboot_start} "	\
-					"${blkc};"			\
-			"fi;"						\
-		"fi; fi;"						\
-		"setenv filesize; setenv blkc\0"			\
-	"update_bootpart=mmc bootbus 0 2 1 2;mmc partconf 0 1 1 0\0"
-
-#endif /* __XPRESS_CONFIG_H */
-- 
2.43.0

