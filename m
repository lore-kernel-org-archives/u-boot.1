Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2BEE95A6A
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 21:36:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 904E086DCE;
	Sat,  7 Oct 2023 23:36:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bhbf8lWA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6031E86568; Sat,  7 Oct 2023 23:36:09 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 522D08657B
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 23:36:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-59e88a28b98so29226307b3.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 14:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696714565; x=1697319365; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yzYGK/yQS9AEmiPcg7nijSK5S//WGwVAlh4JpZQsgpw=;
 b=Bhbf8lWA6AhkIYa7vj9KSXxF/JvG9slG7aCByRs69hfzZz2qtCtKZoLWcIfL1TlbBE
 cc2P7iaPbB9E09syRjdbieDcn2eY9xl0LB+ijlfcHdxCTMdzWj2mYMpjRcOWSvrF7qPj
 nzV39+p0VfmlvSBxzbp5Eo1vbv64ZGz1HAs1UNhOgx1rhTJNnffxWk4/VzMyVDG70nBM
 O05rCZG//6awXQ3daZujQPSMK1ZibB0fI9bFVzVOItYkIEPO1Sf6i3LTu2DtDcx1kCEN
 QFTie8EUTRiC4Wa7XZb86ynkRWvubrw0kRhh3lCmKph671BFINSrcfbIc8l9TdBR9xeZ
 97Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696714565; x=1697319365;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yzYGK/yQS9AEmiPcg7nijSK5S//WGwVAlh4JpZQsgpw=;
 b=hIK6HFl2jjdjsJl217X36qu0HTwDCkhU80Qg7laN2biO9uJ6WoyJyV5O6x+cbPEIZL
 kCcT+S8I3PTk/YbW/k+QMRrdBpUstUM5evXr8pZ0/2TDE9Vz7IMMo3yx0QObxV217Mgl
 EgYJHIsEpZwNwGTt6gki7GVRrGtqtZm9L78GnaFDXAUvN5kMLNVJU9nMNX+DsoanqEHY
 Lk08VN5QaGsVE9sCUdxx0wy1W1Nep97O4Mu1D7JILqlIu7R2aY3j+o3ZtJJoxO0TRKh+
 aTXsTQEPRcEvxWcFi7T1rUg5CPWXOYpsIoSnG/wpQ8r0tRjT2ROV4oHFS2ImtqZCt2iI
 hFqQ==
X-Gm-Message-State: AOJu0YzCdJgDfKGCgMZdStd+rTiXXKK4c2Cjdhi2/UY2JqSrPDhU9kjD
 z08afQZMSPC+qzdbC7qngNhAi8J3L30=
X-Google-Smtp-Source: AGHT+IEcnoKA2aqtwWN6SiNfQnWKv7gdi8rkHpQOl27zlNYIx1NuRA2QNP1/Ebk3/KHdEeSUQa+JYQ==
X-Received: by 2002:a0d:d5c2:0:b0:59b:d33e:40e3 with SMTP id
 x185-20020a0dd5c2000000b0059bd33e40e3mr5483773ywd.11.1696714565175; 
 Sat, 07 Oct 2023 14:36:05 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 n124-20020a817282000000b005777a2c356asm2306750ywc.65.2023.10.07.14.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 14:36:04 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>,
	Stefan Roese <sr@denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH] arm: mvebu: Enable bootstd for Synology DS116 board
Date: Sat,  7 Oct 2023 14:35:47 -0700
Message-Id: <20231007213548.20276-1-mibodhi@gmail.com>
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

Enable bootstd for Synology DS116 board, and remove distroboot.

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 configs/ds116_defconfig |  3 ++-
 include/configs/ds116.h | 12 +-----------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/configs/ds116_defconfig b/configs/ds116_defconfig
index 0cd546c223..2437be73cd 100644
--- a/configs/ds116_defconfig
+++ b/configs/ds116_defconfig
@@ -28,7 +28,8 @@ CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
 CONFIG_AHCI=y
-CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTSTD_FULL=y
+CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_BOOTDELAY=10
 CONFIG_USE_PREBOOT=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
diff --git a/include/configs/ds116.h b/include/configs/ds116.h
index 031f4f6afc..0883ec4d53 100644
--- a/include/configs/ds116.h
+++ b/include/configs/ds116.h
@@ -20,15 +20,8 @@
  */
 #include "mv-common.h"
 
-/* Include the common distro boot environment */
 #ifndef CONFIG_SPL_BUILD
 
-#define BOOT_TARGET_DEVICES(func) \
-	func(USB, usb, 0) \
-	func(SCSI, scsi, 0) \
-	func(PXE, pxe, na) \
-	func(DHCP, dhcp, na)
-
 #define KERNEL_ADDR_R	__stringify(0x1000000)
 #define FDT_ADDR_R	__stringify(0x2000000)
 #define RAMDISK_ADDR_R	__stringify(0x2200000)
@@ -42,14 +35,11 @@
 	"scriptaddr=" SCRIPT_ADDR_R "\0" \
 	"pxefile_addr_r=" PXEFILE_ADDR_R "\0"
 
-#include <config_distro_bootcmd.h>
-
 #define CFG_EXTRA_ENV_SETTINGS \
 	RELOCATION_LIMITS_ENV_SETTINGS \
 	LOAD_ADDRESS_ENV_SETTINGS \
 	"fdtfile=" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
-	"console=ttyS0,115200\0" \
-	BOOTENV
+	"console=ttyS0,115200\0"
 
 #endif /* CONFIG_SPL_BUILD */
 
-- 
2.39.2

