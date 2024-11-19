Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4402AD4414B
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 11:38:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D0678957F;
	Tue, 19 Nov 2024 12:37:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dYFsG3zz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A0E889547; Tue, 19 Nov 2024 12:37:52 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29F1689565
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 12:37:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-381ee2e10dfso1878910f8f.0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 03:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732016269; x=1732621069;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h2AMdeq6Ux/l8kBptoW82ulQU6JaL3ZI9a0FGRdRllI=;
 b=dYFsG3zzgtfBvURme2Xk1KKhy2UAsXA+T3ONXAkpjpJUrsE0ov0fcpYY7ABJfrN3np
 ThlsIOmZTrqXovC4YBRkWAf/O4i1gIuDLHq4dLAHtDhcXFjDpKtTnrzP3tgXCKGbTLf0
 CdBXy6e4eti+sbMtvX1Wc/lg7pX/s5LvQ5v5I3SPxe01C/ND70Ur+UgIvkzO1iOT1Q+E
 prF8CW6Xu1HcWAy5Or20nWhxNyPZMdHx9HS/jg6cRtpWXsUsy/c3/Kie+WULHNHCT+Uc
 1zvpXa994v4yVi2xs5OK+oD+V4OT03UxhmwRIJK+2OK67RsVhxmLBmYOs05ZeS7jutsT
 u+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732016269; x=1732621069;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h2AMdeq6Ux/l8kBptoW82ulQU6JaL3ZI9a0FGRdRllI=;
 b=jDw6NRPsxJCXDWTrUTVbhgBNY30lrf6ZXVrT3lTXFicPNODnH/8LgHyofkGn6FBksb
 lenvrtvpjDRvjRJhiCErr9/0JTNOo2SgN2xx9HM3Ye/EnKsrg5vwokwLjKUvw/VN4yY0
 28vCj0GSqMv91fGlZunN83gzNPGHuI9k62BbMCOdrrXBEQUr5tRvqm4kwolR3eo0HWET
 VReZeKcTS+/ONS/CJbBihG8t9UUhubkqoQQBxXNz/Fl2bTx1K17lUf2OSxgONY08Q/lv
 8+bKj4DYafhTV4P6xgrgG3JKsamjVw/cGrg3DVfnuTb8gw3vqE6POgkao/BzTXLPvjyI
 CpoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjXZOK/CQjpMUcj6iIsbOti0uADJJivjSJhGnUuduFX29fKSL6+UtASJ3NgaLSLEln21IASfY=@lists.denx.de
X-Gm-Message-State: AOJu0YzFbyvfas8lRGvRhjf+0xhAYPmtiVGAA8i4IxoskgXYW1hu5LeH
 z6GuHymeTxQ/kcOs1CT/gxsDrcsu/lgb1Pmk+VjnEsvg8zQCwefRMkzYI9/LTN8=
X-Google-Smtp-Source: AGHT+IFJD7Y6QHDgERzPvIonfz/heCYslK7Aeq7hlOGonUZB1mkCcMgK3PeQPX2PHoWo7mJwnobopg==
X-Received: by 2002:a5d:47a4:0:b0:37d:46fa:d1d3 with SMTP id
 ffacd0b85a97d-38225a931abmr13711831f8f.34.1732016269588; 
 Tue, 19 Nov 2024 03:37:49 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:cc39:27ba:4c6c:3c84])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3824259dda3sm7580388f8f.77.2024.11.19.03.37.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 03:37:49 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Tue, 19 Nov 2024 12:37:40 +0100
Subject: [PATCH v3 3/5] configs: khadas-vim3l_android{_ab}: move on
 bootmeth android
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-adnroidv2-v3-3-45baa486fb31@baylibre.com>
References: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
In-Reply-To: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1
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

Actually khadas vim3l use distro command to boot android image.
Move on new bootmeth android for A/B and non-A/B vim3l android.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 configs/khadas-vim3l_android_ab_defconfig |  7 ++++++-
 configs/khadas-vim3l_android_defconfig    |  7 ++++++-
 include/configs/khadas-vim3l_android.h    | 25 +++++++++++++++++++++----
 include/configs/meson64_android.h         |  3 ---
 4 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
index 4d7b90f23002..43db61056baf 100644
--- a/configs/khadas-vim3l_android_ab_defconfig
+++ b/configs/khadas-vim3l_android_ab_defconfig
@@ -24,6 +24,12 @@ CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTMETH_ANDROID=y
+# CONFIG_BOOTMETH_EXTLINUX is not set
+# CONFIG_BOOTMETH_EXTLINUX_PXE is not set
+# CONFIG_BOOTMETH_EFILOADER is not set
+# CONFIG_BOOTMETH_EFI_BOOTMGR is not set
+# CONFIG_BOOTMETH_VBE is not set
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
@@ -35,7 +41,6 @@ CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_ADTIMG=y
 CONFIG_CMD_ABOOTIMG=y
 # CONFIG_CMD_IMI is not set
-CONFIG_CMD_BCB=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3l_android_defconfig
index 4ec27262cdc7..32d57a5b9090 100644
--- a/configs/khadas-vim3l_android_defconfig
+++ b/configs/khadas-vim3l_android_defconfig
@@ -24,6 +24,12 @@ CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTMETH_ANDROID=y
+# CONFIG_BOOTMETH_EXTLINUX is not set
+# CONFIG_BOOTMETH_EXTLINUX_PXE is not set
+# CONFIG_BOOTMETH_EFILOADER is not set
+# CONFIG_BOOTMETH_EFI_BOOTMGR is not set
+# CONFIG_BOOTMETH_VBE is not set
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
@@ -34,7 +40,6 @@ CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_ADTIMG=y
 CONFIG_CMD_ABOOTIMG=y
 # CONFIG_CMD_IMI is not set
-CONFIG_CMD_BCB=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
diff --git a/include/configs/khadas-vim3l_android.h b/include/configs/khadas-vim3l_android.h
index f39a3782d663..1869249e7c9e 100644
--- a/include/configs/khadas-vim3l_android.h
+++ b/include/configs/khadas-vim3l_android.h
@@ -41,10 +41,27 @@
 	"name=rootfs,size=-,uuid=" ROOT_UUID
 #endif
 
-#define EXTRA_ANDROID_ENV_SETTINGS \
-	"board=vim3l\0" \
-	"board_name=vim3l\0" \
+#define CFG_EXTRA_ENV_SETTINGS                                    \
+	"board=vim3l\0"                                               \
+	"board_name=vim3l\0"                                          \
+	"bootmeths=android\0"                                         \
+	"bootcmd=bootflow scan\0"                                     \
+	"adtb_idx=2\0"                                                \
+	"partitions=" PARTS_DEFAULT "\0"                              \
+	"mmcdev=2\0"                                                  \
+	"fastboot_raw_partition_bootloader=0x1 0xfff mmcpart 1\0"     \
+	"fastboot_raw_partition_bootenv=0x0 0xfff mmcpart 2\0"        \
+	"stdin=" STDIN_CFG "\0"                                       \
+	"stdout=" STDOUT_CFG "\0"                                     \
+	"stderr=" STDOUT_CFG "\0"                                     \
+	"dtboaddr=0x08200000\0"                                       \
+	"loadaddr=0x01080000\0"                                       \
+	"fdt_addr_r=0x01000000\0"                                     \
+	"scriptaddr=0x08000000\0"                                     \
+	"kernel_addr_r=0x01080000\0"                                  \
+	"pxefile_addr_r=0x01080000\0"                                 \
+	"ramdisk_addr_r=0x13000000\0"                                 \
 
-#include <configs/meson64_android.h>
+#include <configs/meson64.h>
 
 #endif /* __CONFIG_H */
diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
index 77364bbf9cf0..37ef8b8f7a7e 100644
--- a/include/configs/meson64_android.h
+++ b/include/configs/meson64_android.h
@@ -104,9 +104,6 @@
 	"elif test $board_name = sei610; then " \
 		"echo \"  Reading DTB for sei610...\"; " \
 		"setenv dtb_index 1;" \
-	"elif test $board_name = vim3l; then " \
-		"echo \"  Reading DTB for vim3l...\"; " \
-		"setenv dtb_index 2;" \
 	"elif test $board_name = vim3; then " \
 		"echo \"  Reading DTB for vim3...\"; " \
 		"setenv dtb_index 3;" \

-- 
2.34.1

