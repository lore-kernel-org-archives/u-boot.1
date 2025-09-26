Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C7FCAC5AE
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 16:02:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE2878389E;
	Fri, 26 Sep 2025 18:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ImvNJfFg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 465EE838A0; Fri, 26 Sep 2025 18:02:46 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0942683824
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 18:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-8eeeeb37cc5so170379539f.0
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 09:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1758902562; x=1759507362; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TA67DAjwCEhGdvmLHYccHic5lxDWlnUPOg2c4QUYQlU=;
 b=ImvNJfFg1cTNdvhN0Nulyt/f+CU5wMucEy/9GhLilBV6vocgkqkcMXJa8LUx2WwTG6
 Cx4Z0DqETmcHYz3ZLvrBvHcXKUWaV9kUySl9aZ/fVEKD3vD3keOvSyVIqGW8eXOFlOJV
 igyIjhoFQp66XBEILS7l6Y0BOTVYIV9yD/384=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758902562; x=1759507362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TA67DAjwCEhGdvmLHYccHic5lxDWlnUPOg2c4QUYQlU=;
 b=NIBlOqXlZsPRK7ycE0mBQZjSZKozkBXRBlEdqvil0AYCK/hs1T5eCu0aJIVhl7RZZt
 bU2xhYQD7pXoDHTyozo1jDDv/o0LM4HWM7ilbuOu8faLPXZ4ZM/0tsBcSRxhralRA65z
 1vGYNccOPNpUTfGYAcnXC6LfpuZ3/WV+IdJBzbVYaIqznaPpyegKTFR7F/R6Ctod3n7w
 m6GecARQzrlW3rWirHXLAzTHVGxIuEEr9KLOl2GIk9kD7JQnfNPB1/RiRE9I2loj5/Y5
 q5YaqbmEBQMt8b7xQ5cAf+47/tsMHZII64ttRZnT7Npz1dy73zq8FK88haz/Qsfqsd2/
 KMAw==
X-Gm-Message-State: AOJu0YwyLmsG9rca8LrYxiQwEirbxAUOC/G7qrY+BU9UWQyM3HPQhbjm
 LfTwDTjnEYErKGiQ96jH4fj6B6qhwZqKZ24TnQKEcFXWhTXsF/96Bl/upfwB8+0d1zJbReVub96
 NNY3VLA==
X-Gm-Gg: ASbGncusazKyZvZMX9XS2eE/LXQljqGuBNOXNWCvyul6E7314pZSpYIN34I0hCa4b1n
 7gnlMzty8VW+klasvvpabZPl1/CHoJdEFx21gEv6IJpB31g45+WETPUuH61pG4Eji5/JlRk0UTG
 8xyKkKphvQTBrcnckr+XJhhsAgw0CBVz17FF77MA+sJ4lrgpSGFs0i2jzbg8/aM8s/ScZOAGDzc
 M3VGm948QL1oDuUs1bksvQwgQtY6QWK6pQ/xGT9KsSe7eASNcMhufa1TpzeF83kcHJGapdFj1+i
 CyCtbb40C3vVa0trpRhJKhHRyohcigU59CgeS4wYJRPKc8kGKyAdv756Vv8aJ35oPFBn0WZEioq
 AfqpaxGrA0S7DnckxwUEuoIQJnJE=
X-Google-Smtp-Source: AGHT+IGCLPtUZVBB9UzAbNXk2WHsV3uQDw8CKaVzfkfeo6JFh+66nAFqT73yRMVeuTteUEuWxvfbXg==
X-Received: by 2002:a05:6602:1601:b0:8b8:50d6:36c1 with SMTP id
 ca18e2360f4ac-901369ca5e4mr1266728339f.0.1758902562013; 
 Fri, 26 Sep 2025 09:02:42 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-56a6a5ae382sm1997134173.64.2025.09.26.09.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 09:02:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v8 3/4] sunxi: Drop old distro boot variables
Date: Fri, 26 Sep 2025 10:02:11 -0600
Message-ID: <20250926160216.2157348-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926160216.2157348-1-sjg@chromium.org>
References: <20250926160216.2157348-1-sjg@chromium.org>
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
2.43.0

