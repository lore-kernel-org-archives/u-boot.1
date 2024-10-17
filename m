Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F8DD3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:31:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98317892D9;
	Fri, 18 Oct 2024 01:25:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gJnIH9T5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E4AB892BF; Fri, 18 Oct 2024 01:25:45 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D0A38912C
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3a3b1aa0e80so6261655ab.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207542; x=1729812342; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b5Ve6E7oWEnzyPygQkgA6GP6HSXp8JxBxPfPOExYwb8=;
 b=gJnIH9T5Rnlkz6yRdLsKr+KuUO2hxcyW1wZk6Ei+OMrhQviZX00xOhbmPbjTU/Eyrz
 1ZNIL/qtl2dn3PIAZqDiDHHgRX/IsLmIxgK2Mb529P/6KUKO/o9Gkq2By+J7XMrwU/Es
 b7FHi6vRgNe6/pjbLYIgrFVG6LNmpYUe9B7PQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207542; x=1729812342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b5Ve6E7oWEnzyPygQkgA6GP6HSXp8JxBxPfPOExYwb8=;
 b=d1Jr5Y9c9/zgnGJMyHCEeRX7QqI6Fq2/7+Re4Wwk0C5ZNyFBcztZUcgSmgHjccJZ+d
 HFJbp8exkXQ9rZInV61hN4WFBhL5jnpcV0q48acZ8F/aQG2RtDde1W1SMFsaF4g1Cr8+
 MZBzazvwMeblUCNpIgE65OXo6Y9oZUPyWA4O9fmjmTJXphVGC+Tqm/x8R0rtXYPRwNhQ
 FYoGYt4EvobhoTPz1O/do/eul4P8SeNsLwDdDrvENDXytigt87NFBlNGsnwT/jdPthcC
 L9GEWfinzVwaJnAibrpc7YmaGg/zoRCf9U15b23be1ZCILTnNj+XJg2Tz4PHaItWPokp
 eEtA==
X-Gm-Message-State: AOJu0Ywztng7luLwLdbTBbSTero413R5u/1HIzcwB1dcHpyIklya59rf
 rkUijS8B/y2+4VNBkYp7Im3DE5j2SnSPhJVbJ0zotQOMJI5a+/yznjptNwazdh9E27wgpXKCkOs
 =
X-Google-Smtp-Source: AGHT+IGKU0uQKo9j3PFTSqWQD47RHxOQhRHLFsgfRWl7WcYOzownuQ2UKfMlH8dV8YeG4z0xFRM/bQ==
X-Received: by 2002:a05:6e02:1a81:b0:3a0:abec:da95 with SMTP id
 e9e14a558f8ab-3a3f40ad623mr3736315ab.22.1729207541855; 
 Thu, 17 Oct 2024 16:25:41 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b5ac9csm122057173.29.2024.10.17.16.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:25:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 6/8] sunxi: Drop old distro boot variables
Date: Thu, 17 Oct 2024 17:25:29 -0600
Message-Id: <20241017232531.726559-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017232531.726559-1-sjg@chromium.org>
References: <20241017232531.726559-1-sjg@chromium.org>
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

