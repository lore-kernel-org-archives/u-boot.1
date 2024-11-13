Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA373D462BF
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 15:10:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB6D689595;
	Wed, 13 Nov 2024 16:10:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f3U24yWe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD6C089040; Wed, 13 Nov 2024 16:10:09 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B25889595
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 16:10:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-83aba237c03so279077139f.3
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 07:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731510606; x=1732115406; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b5Ve6E7oWEnzyPygQkgA6GP6HSXp8JxBxPfPOExYwb8=;
 b=f3U24yWejsJBzSe0CnyVXkcOKMKroWHmw4ujktg5Ht8S/btJtPX2jFmnv6b2+kw3hQ
 Tyjg2ZGCeizqMo0yNwTKPI+b71pKWeCPdUEPZ0ukifjuwqY8sICN4q8WTYnHMI3TlY+K
 KGVMph1cyPUzgNxLwmZOSXXuuLuz5uvD8i8wU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731510606; x=1732115406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b5Ve6E7oWEnzyPygQkgA6GP6HSXp8JxBxPfPOExYwb8=;
 b=EfUsHxl4P/sabGThZLipjmyQ1hCzGE2BH/zdV4mf13IkHUNHranK/2UAdHVCvAaPMT
 IyW7DJVA83AQo9cubjtEG6hdR1Nlr4ostvzEi/df3RpHojEY2s+2dUmvIcdAE8TKez7d
 QQuiqmGjS7JEGKyUv6oyidQxeEvLPcNn1U2B4oF//mYANPXlaNG8YkuQopNL+4JXChJP
 BPVvN+NFx7lb09lQb/ca+syVvZ/PxFWEfCNuDGbjjYWjgroDeoVDzS4rx75BZ2ghW5lr
 t6g92BxNU5Pl7SlVkSgn5+fxf8t6qtZIVp6sHB8SkeJlkqapJNr8DbdZVJC7sYCDdWDn
 pbBA==
X-Gm-Message-State: AOJu0YxdtJsCQUmb8IBb/Anwe79sBKC+GqIKO0p9r59uGnF00JArcecP
 6jcb5sw5Vl6vuhR6G5ho588MfZ2gIqvG4RlyAgHrjC4DvyrwixNnjVrY7EZDEN5imR+wZTLIpYY
 =
X-Google-Smtp-Source: AGHT+IGDX0MtRUpOpW1f4FQkFyTalC7VC0lfRE1v+oUckdmE9ntjaj15TTkGobYFkUgDZKVaCbnHZw==
X-Received: by 2002:a05:6e02:3499:b0:3a6:c43d:1325 with SMTP id
 e9e14a558f8ab-3a7156fcb89mr39054555ab.8.1731510605670; 
 Wed, 13 Nov 2024 07:10:05 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a719d6b62fsm2710105ab.18.2024.11.13.07.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 07:10:04 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 6/8] sunxi: Drop old distro boot variables
Date: Wed, 13 Nov 2024 08:09:36 -0700
Message-Id: <20241113150938.1534931-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113150938.1534931-1-sjg@chromium.org>
References: <20241113150938.1534931-1-sjg@chromium.org>
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

(no changes since v2)

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

