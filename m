Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB117D374B8
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 16:11:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12E25890A7;
	Thu, 17 Oct 2024 18:11:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mYY47vby";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FB6C88D5B; Thu, 17 Oct 2024 18:10:55 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA34289065
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 18:10:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-37d4821e6b4so724203f8f.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 09:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729181449; x=1729786249;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ygt+QlXmPz7QPvV/FOkEoevXTJvSaZYjqUPyEEMUWtE=;
 b=mYY47vbydfOtBVyGrtEww+LIgxCMp7kSYn0+ETK6dzXRea21EPKZHniDmBc/Lyt305
 EwSiBuH+3Y6g22wjyoWRoQX8Kf3rLkZfAr/kHUNEr3C2hpJArjveQtUotfKpDanYqarg
 RPVeT6eEaIHUQyLd8eTNaeHcnZ+r/qRsXfnJ7bWSFBxhaRx1Up1PlE0s2JObqpX6H+sq
 giNsepSfShQpL/2/14NVCoFkv0eyqC1MWFYx862A88ufJF6LjR4j+Et5ouv08qFfNxCd
 bYt8RdkphTvjhwIEYCDRykv6KpIT5jC8hwq3WPZhFAp/ph1Fa/oJYYYZMLOQAE+o8PCg
 09Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729181449; x=1729786249;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ygt+QlXmPz7QPvV/FOkEoevXTJvSaZYjqUPyEEMUWtE=;
 b=IzG7BxV37avaaeK3Bh+45vKfsAbziSxdBmyR/r+LE2s0L1EtRwvXR4oRpDeTxofICE
 KYhDe7rmaGjazGHog2BK4TRSLGD2u7igDQ8PFSVzMOqnbekBousFI2dTesLp3PBXrkyN
 a8vddFFXwY5Bh5g1K4nMYYRPUMSVlOfHRbOGMCYHAOSaKCQMNUJ6TbkI0RqE4tVcV+dy
 +B0geEIoFswm5RmT0GieqkwD+zx+ErFisioQtGQJwafY05fdhj6ars3yNTuIvhaZ1kFn
 QzAOeRu6vo1wjOTmXTtImlOQjU9vcSsfQFiQDkWwdG2M8RkCRtSM965mjws0j1nb4Hsr
 Iiwg==
X-Gm-Message-State: AOJu0YwrmYEjuaay1zJGp5jISddCv2hHJApRjxCd1B+TCZ7+XlWsIEuv
 1UhN7huiPn/iTe2IOIG4fsbKcFNpIKDmSPufacg45WPBhrb7MVRH4kBZIlFRCQ3r7/bmkdIOdZl
 7
X-Google-Smtp-Source: AGHT+IE7xXUS1THsS5Gj4Fay22Jjcvh2AWc8Xix4lHTywoo2brF9E6AVE0cXGMGZfIvkhce+ericUw==
X-Received: by 2002:adf:f591:0:b0:37d:482e:6197 with SMTP id
 ffacd0b85a97d-37d86bb873emr5638775f8f.17.1729181448677; 
 Thu, 17 Oct 2024 09:10:48 -0700 (PDT)
Received: from [127.0.1.1] ([2a05:6e02:10a5:e010:4754:2b9f:eb4f:125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fc42160sm7653993f8f.112.2024.10.17.09.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 09:10:47 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Thu, 17 Oct 2024 18:10:28 +0200
Subject: [PATCH 4/6] configs: khadas-vim3l_android{_ab}: move on bootmeth
 android
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-adnroidv2-v1-4-781c939902c9@baylibre.com>
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

Actually khadas vim3l use distro command to boot android image.
Move on new bootmeth android for A/B and non-A/B vim3l android.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 configs/khadas-vim3l_android_ab_defconfig |  7 ++++++-
 configs/khadas-vim3l_android_defconfig    |  7 ++++++-
 include/configs/khadas-vim3l_android.h    | 29 +++++++++++++++++++++++++----
 3 files changed, 37 insertions(+), 6 deletions(-)

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
index f39a3782d663..4455898b5262 100644
--- a/include/configs/khadas-vim3l_android.h
+++ b/include/configs/khadas-vim3l_android.h
@@ -26,6 +26,7 @@
 	"name=super,size=3072M,uuid=${uuid_gpt_super};" \
 	"name=userdata,size=11218M,uuid=${uuid_gpt_userdata};" \
 	"name=rootfs,size=-,uuid=" ROOT_UUID
+
 #else
 #define PARTS_DEFAULT \
 	"uuid_disk=${uuid_gpt_disk};" \
@@ -39,12 +40,32 @@
 	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
 	"name=userdata,size=12722M,uuid=${uuid_gpt_userdata};" \
 	"name=rootfs,size=-,uuid=" ROOT_UUID
+
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

