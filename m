Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E955DC25B48
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 23:22:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0FDE87A4D;
	Wed, 25 Oct 2023 01:18:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jva6h7Rq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8606686FB9; Wed, 25 Oct 2023 01:17:44 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06C95879F3
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 01:17:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5a7eef0b931so52242437b3.0
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 16:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698189443; x=1698794243; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qOnMYomXkFQsRnavv8idyBHGfN0A7SCqYJydre6ApqU=;
 b=Jva6h7Rq5y18ewZIkupjvhNXMn2SHGzBc4rAC0y+DfM+4zYizP+roI9GFK8S8Mkg7N
 MF9JaVc+ldEidyoyyQrUuFHE0YU+5XBeEwEScC/CMV0ByLELiApC0OvHNM3geJrhY4MW
 G3w+7cYxr0slBb0D8qaiGxxT/pecmMbKLaKSIJJm99NTCX2uNtTN/KCRI8/sGPAWDzRs
 oFQPirQUB3SbXHhUFCBuj317kR6BOcwm7hpW+vkI10SLvnjp708W2GaYcdo61UDnLflc
 QotG+qcP0noA3R0rr9sLasOD6LB1j0zaz7RvNj+O+K5zxq0iw03VfXC1qJdBOyMnXTyV
 h7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698189443; x=1698794243;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qOnMYomXkFQsRnavv8idyBHGfN0A7SCqYJydre6ApqU=;
 b=sTODQQr+Nb7Isb8FBEtfB9VGbZV40A08Th54LXgZko1Oy58ABp6LjJCHQgVEPV1AyH
 fIMp7ld6EuSnqPQukJ/ZHVbcz6KxNc5bhDP+vxIbQ05f2WqzLaPpXIROg2+/o0/CQoXn
 b/nMzAy1LtZ1cmVWK4/zAN3wrUt5SJTTYaH5FiUJiDsS0/IHfJvUjoks+1U4G47tEJqT
 pNpdoVyy8DgiPa0p6coxD45z4F2rOPckaRMDBsEGLJwX/eRN7kTT/oP6MMjkNtHI8FHh
 1o6d7cJmvOPup1CwuRk2IEgFiXc8J11AFT60WPtXkn+dO59npsn0BOKDcu0XKI7ZHadl
 ibjQ==
X-Gm-Message-State: AOJu0YzXy0p+0yJoHirSvyYGrchAY+aWOs57+cr8fffQBwEXNJ/3JEe0
 NBcdG0SrQSmQoD7tKOxIxNSxii5dDCk=
X-Google-Smtp-Source: AGHT+IHKcAje3on1jZdqtqwq1WxVoqws02RPCxGOH33tU5EMo42F9nDIEE/oWGMDWf0dDg91RVstxQ==
X-Received: by 2002:a05:690c:dc9:b0:59f:61b6:f584 with SMTP id
 db9-20020a05690c0dc900b0059f61b6f584mr16669048ywb.9.1698189443534; 
 Tue, 24 Oct 2023 16:17:23 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 a66-20020a0df145000000b0058427045833sm4493509ywf.133.2023.10.24.16.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 16:17:22 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>,
	Stefan Roese <sr@denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH] arm: kirkwood: Enable bootstd for Pogo V4 board
Date: Tue, 24 Oct 2023 16:17:08 -0700
Message-Id: <20231024231709.21861-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Enable bootstd for Pogo V4 board, and remove distroboot.

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 configs/pogo_v4_defconfig |  3 ++-
 include/configs/pogo_v4.h | 35 ++---------------------------------
 2 files changed, 4 insertions(+), 34 deletions(-)

diff --git a/configs/pogo_v4_defconfig b/configs/pogo_v4_defconfig
index 2747c3c72d..ff6411d894 100644
--- a/configs/pogo_v4_defconfig
+++ b/configs/pogo_v4_defconfig
@@ -17,7 +17,8 @@ CONFIG_IDENT_STRING="\nPogoplug V4"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_PCI=y
 CONFIG_LTO=y
-CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTSTD_FULL=y
+CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_BOOTSTAGE=y
 CONFIG_SHOW_BOOT_PROGRESS=y
 CONFIG_BOOTDELAY=10
diff --git a/include/configs/pogo_v4.h b/include/configs/pogo_v4.h
index 3371579023..d5003538da 100644
--- a/include/configs/pogo_v4.h
+++ b/include/configs/pogo_v4.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright (C) 2014-2022 Tony Dinh <mibodhi@gmail.com>
+ * Copyright (C) 2014-2023 Tony Dinh <mibodhi@gmail.com>
  *
  * Based on
  * Copyright (C) 2012
@@ -21,33 +21,6 @@
  */
 #include "mv-common.h"
 
-/* Include the common distro boot environment */
-#ifndef CONFIG_SPL_BUILD
-
-#ifdef CONFIG_MMC
-#define BOOT_TARGET_DEVICES_MMC(func) func(MMC, mmc, 0)
-#else
-#define BOOT_TARGET_DEVICES_MMC(func)
-#endif
-
-#ifdef CONFIG_SATA
-#define BOOT_TARGET_DEVICES_SATA(func) func(SATA, sata, 0)
-#else
-#define BOOT_TARGET_DEVICES_SATA(func)
-#endif
-
-#ifdef CONFIG_USB_STORAGE
-#define BOOT_TARGET_DEVICES_USB(func) func(USB, usb, 0)
-#else
-#define BOOT_TARGET_DEVICES_USB(func)
-#endif
-
-#define BOOT_TARGET_DEVICES(func) \
-	BOOT_TARGET_DEVICES_MMC(func) \
-	BOOT_TARGET_DEVICES_USB(func) \
-	BOOT_TARGET_DEVICES_SATA(func) \
-	func(DHCP, dhcp, na)
-
 #define KERNEL_ADDR_R	__stringify(0x800000)
 #define FDT_ADDR_R	__stringify(0x2c00000)
 #define RAMDISK_ADDR_R	__stringify(0x01100000)
@@ -59,14 +32,10 @@
 	"ramdisk_addr_r=" RAMDISK_ADDR_R "\0" \
 	"scriptaddr=" SCRIPT_ADDR_R "\0"
 
-#include <config_distro_bootcmd.h>
-
 #define CFG_EXTRA_ENV_SETTINGS \
 	LOAD_ADDRESS_ENV_SETTINGS \
 	"fdtfile=" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
 	"mtdparts=" CONFIG_MTDPARTS_DEFAULT "\0" \
-	"console=ttyS0,115200\0" \
-	BOOTENV
-#endif /* CONFIG_SPL_BUILD */
+	"console=ttyS0,115200\0"
 
 #endif /* _CONFIG_POGO_V4_H */
-- 
2.39.2

