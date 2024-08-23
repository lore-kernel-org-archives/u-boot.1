Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE0FC5321D
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 20:49:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DCB888C73;
	Fri, 23 Aug 2024 22:48:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oQfuT3mG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 076B988C73; Fri, 23 Aug 2024 22:48:48 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0163688C4A
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 22:48:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-81fd1e05a5aso101541139f.0
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 13:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724446123; x=1725050923; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7YlvqTU+7iaCKO8cXZCpPZ8cKdNsWuW30LbujZ1j/dY=;
 b=oQfuT3mGo/EOk9nO1Xunc+9gsmb3rC3YYUnc5Dbj/RI+EtOe7O9BCJ2iYpfhwmDRG5
 MhfnhyFCP2767h/f8yyG9Ubs0Y1t0FxuNWLCE+ajm9TgFIm4Ph0dd+3oJVLBtToELZZK
 dYCYedIkCqlz3UIdX8ZkELK+w1YBjiF/Jkc1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724446123; x=1725050923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7YlvqTU+7iaCKO8cXZCpPZ8cKdNsWuW30LbujZ1j/dY=;
 b=QXWQIQLLe+JVfvx9EHvXeKrsKBHvnadiphwacvlvJy2gwmOoE7/ekXBXWQCm4FCFEo
 kCjNsHGMRKe9ZNXX+0h9CVjLKHtIr9CA984MAI0SThhr3Z+cQdfFRZJPjkcyYYUAz7Gi
 vhYNoJof2eKjWZX0RAlDWL7NTFUbYFGtU02E+0sJDDjnAxUAVEVcm7ILBEwlE7hEFMWr
 otxpsNK+lniu0MXe8UqQ6QedNu19Y2/YSQwbhAwLW/JDWODhwoaTFWf+iF9RrBD3Sp8n
 +OVvG3pwsl1ey3e76mXverZB6ZaeTrme/aa0zwxKQcxtzHDkKnxwSQOFVGRnAzaebgyz
 q+kg==
X-Gm-Message-State: AOJu0YxqL8EqtW+02yZ0QROm5jl2MOkpXkKpn0av2puBk0dSBiNs7cHV
 Z42yfw+tAiaZ/p2JtEoQrlQt3oRWbyrsy5ghoBLSXBcyvHYZutLT393tXfaK6gYPMinUBSnvCDU
 =
X-Google-Smtp-Source: AGHT+IGQn94UMZSeGOS31Ypcp7eePZhOcFG2BQSEVDW3pplhOmghx3bQYegHgK6OWJbeP5xK/BoNxA==
X-Received: by 2002:a05:6e02:b2c:b0:397:2dcd:80e5 with SMTP id
 e9e14a558f8ab-39e3c9ee72cmr33090025ab.27.1724446123583; 
 Fri, 23 Aug 2024 13:48:43 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e67addsm15698375ab.4.2024.08.23.13.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 13:48:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 6/8] sunxi: Drop old distro boot variables
Date: Fri, 23 Aug 2024 14:48:22 -0600
Message-Id: <20240823204824.443631-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823204824.443631-1-sjg@chromium.org>
References: <20240823204824.443631-1-sjg@chromium.org>
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

These are not needed as bootstd handles the boot now. Drop them.

Keep BOOTCMD_SUNXI_COMPAT for now since it does not relate to
distro boot.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Keep BOOTCMD_SUNXI_COMPAT

 include/configs/sunxi-common.h | 75 +---------------------------------
 1 file changed, 1 insertion(+), 74 deletions(-)

diff --git a/include/configs/sunxi-common.h b/include/configs/sunxi-common.h
index b29a25d5617..666553ccadb 100644
--- a/include/configs/sunxi-common.h
+++ b/include/configs/sunxi-common.h
@@ -156,76 +156,6 @@
 	"fdt ram " FDT_ADDR_R " 0x100000;" \
 	"ramdisk ram " RAMDISK_ADDR_R " 0x4000000\0"
 
-/****************************************************************************
- *                  definitions for the distro boot system                  *
- ****************************************************************************/
-#ifdef CONFIG_MMC
-#if CONFIG_MMC_SUNXI_SLOT_EXTRA != -1
-#define BOOTENV_DEV_MMC_AUTO(devtypeu, devtypel, instance)		\
-	BOOTENV_DEV_MMC(MMC, mmc, 0)					\
-	BOOTENV_DEV_MMC(MMC, mmc, 1)					\
-	"bootcmd_mmc_auto="						\
-		"if test ${mmc_bootdev} -eq 1; then "			\
-			"run bootcmd_mmc1; "				\
-			"run bootcmd_mmc0; "				\
-		"elif test ${mmc_bootdev} -eq 0; then "			\
-			"run bootcmd_mmc0; "				\
-			"run bootcmd_mmc1; "				\
-		"fi\0"
-
-#define BOOTENV_DEV_NAME_MMC_AUTO(devtypeu, devtypel, instance) \
-	"mmc_auto "
-
-#define BOOT_TARGET_DEVICES_MMC(func) func(MMC_AUTO, mmc_auto, na)
-#else
-#define BOOT_TARGET_DEVICES_MMC(func) func(MMC, mmc, 0)
-#endif
-#else
-#define BOOT_TARGET_DEVICES_MMC(func)
-#endif
-
-#ifdef CONFIG_AHCI
-#define BOOT_TARGET_DEVICES_SCSI(func) func(SCSI, scsi, 0)
-#else
-#define BOOT_TARGET_DEVICES_SCSI(func)
-#endif
-
-#ifdef CONFIG_USB_STORAGE
-#define BOOT_TARGET_DEVICES_USB(func) func(USB, usb, 0)
-#else
-#define BOOT_TARGET_DEVICES_USB(func)
-#endif
-
-#ifdef CONFIG_CMD_PXE
-#define BOOT_TARGET_DEVICES_PXE(func) func(PXE, pxe, na)
-#else
-#define BOOT_TARGET_DEVICES_PXE(func)
-#endif
-
-#ifdef CONFIG_CMD_DHCP
-#define BOOT_TARGET_DEVICES_DHCP(func) func(DHCP, dhcp, na)
-#else
-#define BOOT_TARGET_DEVICES_DHCP(func)
-#endif
-
-/* FEL boot support, auto-execute boot.scr if a script address was provided */
-#define BOOTENV_DEV_FEL(devtypeu, devtypel, instance) \
-	"bootcmd_fel=" \
-		"if test -n ${fel_booted} && test -n ${fel_scriptaddr}; then " \
-			"echo '(FEL boot)'; " \
-			"source ${fel_scriptaddr}; " \
-		"fi\0"
-#define BOOTENV_DEV_NAME_FEL(devtypeu, devtypel, instance) \
-	"fel "
-
-#define BOOT_TARGET_DEVICES(func) \
-	func(FEL, fel, na) \
-	BOOT_TARGET_DEVICES_MMC(func) \
-	BOOT_TARGET_DEVICES_SCSI(func) \
-	BOOT_TARGET_DEVICES_USB(func) \
-	BOOT_TARGET_DEVICES_PXE(func) \
-	BOOT_TARGET_DEVICES_DHCP(func)
-
 #ifdef CONFIG_OLD_SUNXI_KERNEL_COMPAT
 #define BOOTCMD_SUNXI_COMPAT \
 	"bootcmd_sunxi_compat=" \
@@ -242,8 +172,6 @@
 #define BOOTCMD_SUNXI_COMPAT
 #endif
 
-#include <config_distro_bootcmd.h>
-
 #ifdef CONFIG_USB_KEYBOARD
 #define CONSOLE_STDIN_SETTINGS \
 	"stdin=serial,usbkbd\0"
@@ -296,7 +224,6 @@
 	"uuid_gpt_esp=" UUID_GPT_ESP "\0" \
 	"uuid_gpt_system=" UUID_GPT_SYSTEM "\0" \
 	"partitions=" PARTS_DEFAULT "\0" \
-	BOOTCMD_SUNXI_COMPAT \
-	BOOTENV
+	BOOTCMD_SUNXI_COMPAT
 
 #endif /* _SUNXI_COMMON_CONFIG_H */
-- 
2.34.1

