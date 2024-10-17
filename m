Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B570D374BA
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 16:11:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C37958907E;
	Thu, 17 Oct 2024 18:10:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rOMVgc9+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F93D89057; Thu, 17 Oct 2024 18:10:54 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54D3B89067
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 18:10:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-37d4fd00574so791011f8f.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 09:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729181449; x=1729786249;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5jMPduaHSnMoSJU1wxTBgjV7EM8SwG+3sbFMb1YVjfM=;
 b=rOMVgc9+/rX/yKfLvx3YK6fwOIM0qqtpIR9w2R4kAEVMJav5wjzZ59AJzB203InqFr
 YYFH/YLNyWr5zs/lM9e1j7m7r4Zm4BL1xZ1blzLQqNS/UMkbets024ifrLOM8PxSK7y3
 d+lxh8zbihLM+awhd5lKkcpQrhORDY6EifGhbGmuvOYBpH5e2QfaECnJuTOnCln2czP+
 KspNRgvLQ7MFKeMg27rNwglmD21t9rIklleSnfqeii0fFBoBDDTLp8odwAjFxDXFVcXY
 GPb6ZnG1WTkZYrXImwiVFLU+lczD1PXdsXQKjOLu3+gKAThSLmZ8yIYQ+RMo+IdFDTub
 WNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729181449; x=1729786249;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5jMPduaHSnMoSJU1wxTBgjV7EM8SwG+3sbFMb1YVjfM=;
 b=gGdy8PHiDbKu8jtbFDPi7MWjdGzXeSur138vTD6L+uildiT5IC02VwevMg/h39SJ65
 l/RfEXNUis2xMww3tM4xFHTvrlWUn9j2oy4O/UWB19eB4WWBZNEj+QP8tei2ZF1bsUPS
 ETHf8l2xQpLOfehtgpRbawIvvEG9WTCW8SjYSWTzKzXdNPgDXkYNlsxjZE9uS8coM2k5
 q2WUX7NCJFrf9/q6odBr/3/Il3sGyLCgnZPAMugNqP9ao3as49ez4FQ9VKxdJuv9pAB2
 vcRDN0OrOzHyDQFPkTk4y0dRePOSqnF8FwRpTy31JO1gs2iwNF99lRYVc1pomRYqT+LX
 acig==
X-Gm-Message-State: AOJu0Yz+oC5ff5TgkNrBztfbYBbVw30136Pbtx5ncTEs4oSUex5RhvRe
 cXm6ymAF5O+ypFwZRbKZYXSLblwGwdUSCFoIcT4jnQo03IC7UtB/Q26kmtQmErM4zoHs8hEdO2d
 5
X-Google-Smtp-Source: AGHT+IEDxzKg/75P+DbakFyTokzsakG6zyx488jXHOowit/cI4jtM/5UmIZi1jmkhFuryt2+xomcrA==
X-Received: by 2002:adf:a192:0:b0:37c:ffdd:6d5a with SMTP id
 ffacd0b85a97d-37d93dcc0e0mr2828546f8f.6.1729181449350; 
 Thu, 17 Oct 2024 09:10:49 -0700 (PDT)
Received: from [127.0.1.1] ([2a05:6e02:10a5:e010:4754:2b9f:eb4f:125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fc42160sm7653993f8f.112.2024.10.17.09.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 09:10:49 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Thu, 17 Oct 2024 18:10:29 +0200
Subject: [PATCH 5/6] configs: khadas-vim3_android{_ab}: move on bootmeth
 android
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-adnroidv2-v1-5-781c939902c9@baylibre.com>
References: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
In-Reply-To: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com, 
 20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org
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

Actually khadas vim3 use distro command to boot android image.
Move on new bootmeth android for A/B and non-A/B vim3 android.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 configs/khadas-vim3_android_ab_defconfig |  7 ++++++-
 configs/khadas-vim3_android_defconfig    |  7 ++++++-
 include/configs/khadas-vim3_android.h    | 27 +++++++++++++++++++++++----
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
index de5357c45cbf..a078c5d363ae 100644
--- a/configs/khadas-vim3_android_ab_defconfig
+++ b/configs/khadas-vim3_android_ab_defconfig
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
diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
index a0d9c423c3c3..b77a44ce859b 100644
--- a/configs/khadas-vim3_android_defconfig
+++ b/configs/khadas-vim3_android_defconfig
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
diff --git a/include/configs/khadas-vim3_android.h b/include/configs/khadas-vim3_android.h
index 0e2953fe71b3..498afd0287f4 100644
--- a/include/configs/khadas-vim3_android.h
+++ b/include/configs/khadas-vim3_android.h
@@ -41,10 +41,29 @@
 	"name=rootfs,size=-,uuid=" ROOT_UUID
 #endif
 
-#define EXTRA_ANDROID_ENV_SETTINGS \
-	"board=vim3\0" \
-	"board_name=vim3\0" \
+#define CFG_EXTRA_ENV_SETTINGS                                    \
+	"board=vim3\0"                                               \
+	"board_name=vim3\0"                                          \
+	"bootmeths=android\0"                                         \
+	"bootcmd=bootflow scan\0"                                     \
+	"adtb_idx=3\0"                                                \
+	"partitions=" PARTS_DEFAULT "\0"                              \
+	"mmcdev=2\0"                                                  \
+	"fastboot_raw_partition_bootloader=0x1 0xfff mmcpart 1\0"     \
+	"fastboot_raw_partition_bootenv=0x0 0xfff mmcpart 2\0"        \
+	"gpio_recovery=88\0"                                          \
+	"check_button=gpio input ${gpio_recovery};test $? -eq 0;\0"   \
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

-- 
2.34.1

