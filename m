Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC46E95A6B
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 22:08:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90E5B86D83;
	Sun,  8 Oct 2023 00:08:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G8w4/4sl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E177186D83; Sun,  8 Oct 2023 00:08:38 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B00FD86D7E
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 00:08:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-59bebd5bdadso40085877b3.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 15:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696716515; x=1697321315; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kW7zjcDgXi4fw07jnNkeymPHcVXJRGlkWeGSOuJemKg=;
 b=G8w4/4slrmDCJkmyz5sNQObVwkGHs5Kj17JxHZEtuKOJ6zNM3Jox05ygkT0LCqmM4s
 WP2sgAunOSCpdEgdGv6sGr/pK2LcLNS3BrYdg+EuHa6usbinbEnezHVZwgwqP/vQ1wdK
 XY3zMRr2wKMRwO+TC5hxSWUN4fUZUke9Nn1dU8uDnLVxaPuCQkVlLDwb8DU54yw4HraF
 x+tBnpD07hCeoXZemU+KdluDR3A1pMVJ/bnT2IyAmYRboGZeINSpcQon4YpNZvPhsqj/
 30/mlqWxHzdX4ZbwhZTwjnt92nGmYFFtj07n1ZG+/TzcoLfn8EnZTwRkBsWNvM44eRUA
 8ACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696716515; x=1697321315;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kW7zjcDgXi4fw07jnNkeymPHcVXJRGlkWeGSOuJemKg=;
 b=kRHR6yoZLLDe93R7ZmE0rYGO3YAnwyx1MoKb3k0Tdl7UtIqT4RQgPgSES/4wejL2bh
 ljtQRIDA9FqBTxE7egmlDX5kyY1QKE1gOa3p8sfdgSj67b1vRgM9dvZgjcl6LjMVkn5E
 2rJ6QmMvLfqWjq70RmnNWnyx305oE59hTsy27z7XPPagFh4oGzDh+qXvC/0nMm1rDCea
 Sh7gMGTDm62+c0wYSDWJVy0VT8iVtRxOZwVHHdeoMJAKL/o4cm+CINt2hwYEJ7cRxee2
 /+G2tMdDGhgLfbC7RGJpeYujAM//qRjeS0sh53oh+t/Hvs3MMX73aEcYfaU3iHs8Gd87
 HNxA==
X-Gm-Message-State: AOJu0YwCYQNjJHtrX2DR9i7OkrQVE1pxqOZtqgkGMyY87VCudnm4dq3o
 bIYlUH7QPiZBKOtLwrnLmX6SBl3qLsw=
X-Google-Smtp-Source: AGHT+IGpTOpJZrUD9RiOUIoSFEep8YAkRP8IqBeJ/ieMAeK3fvkruewRnMioXOQ9jMp/hp1CBSoouw==
X-Received: by 2002:a05:690c:338c:b0:5a5:7cd:8014 with SMTP id
 fl12-20020a05690c338c00b005a507cd8014mr10747598ywb.18.1696716515034; 
 Sat, 07 Oct 2023 15:08:35 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 m4-20020a819c04000000b00595394ba941sm2330923ywa.81.2023.10.07.15.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 15:08:34 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>,
	Stefan Roese <sr@denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH] arm: mvebu: Enable bootstd for Thecus N2350 board
Date: Sat,  7 Oct 2023 15:08:13 -0700
Message-Id: <20231007220814.30783-1-mibodhi@gmail.com>
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

Enable bootstd for Thecus N2350 board, and remove distroboot.

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 configs/n2350_defconfig |  3 ++-
 include/configs/n2350.h | 12 +-----------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/configs/n2350_defconfig b/configs/n2350_defconfig
index 109f0e10e9..07135742d3 100644
--- a/configs/n2350_defconfig
+++ b/configs/n2350_defconfig
@@ -29,7 +29,8 @@ CONFIG_ENV_ADDR=0x100000
 CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
 CONFIG_AHCI=y
-CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTSTD_FULL=y
+CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_BOOTDELAY=10
 CONFIG_USE_PREBOOT=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
diff --git a/include/configs/n2350.h b/include/configs/n2350.h
index 92b2270236..d8a9814d3e 100644
--- a/include/configs/n2350.h
+++ b/include/configs/n2350.h
@@ -20,15 +20,8 @@
  */
 #include "mv-common.h"
 
-/* Include the common distro boot environment */
 #ifndef CONFIG_SPL_BUILD
 
-#define BOOT_TARGET_DEVICES(func) \
-	func(SCSI, scsi, 0) \
-	func(USB, usb, 0) \
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

