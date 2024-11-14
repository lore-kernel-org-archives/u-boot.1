Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E59CD6A230
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 21:30:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60A71896A3;
	Thu, 14 Nov 2024 22:30:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="g7k2fq2j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F5C289696; Thu, 14 Nov 2024 22:29:59 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE7D28968F
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 22:29:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-382171fe8b1so773780f8f.1
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 13:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731619796; x=1732224596;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D2GbAZq2WyogNnCPCqG20p+Ar0pP5Zd1VvJjZDymhh4=;
 b=g7k2fq2jEnWMhnIohfhBajHgTYyj4TeiU+oibtEKb7tROuMEWVhulR5Uy/I7vRJghv
 bAhqqqWTtFjVa9TpJQajPEBo1vYzD8ovXjgFmzSEQWFVQiiUgs5hDpqkbNhnYOXGU93P
 tZm+4cm7PCVUBeMphr6enqpyKOajPj8EhENxDtVo2Xi+t3yirlyN3DdwX8iXszs0Q7xJ
 59zigG+5g685XQY/fAYOVisAuPMAmL1WjJ9k2ckX+uI+/r1YhNasVvlbOWcq+BBuTXVG
 NFLaqJR23+jRRHCkJHjGoCXIEfXXyqvN/v30gfuMiI7zi4Z7LwiqJl1TPGstWlZhh2wL
 1qQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731619796; x=1732224596;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D2GbAZq2WyogNnCPCqG20p+Ar0pP5Zd1VvJjZDymhh4=;
 b=FxDC26izT6O9F1hKzI3Qq+h+S83mO285uxCAWvQRIdFslcPCE+cHQMNWMPWy+Hf9tx
 RWYw0oT9S2noPlLzx+9LP7fs4LJ8d91fp499HzY3rGbQvgC86wQHzR34TpJooxHaIOkw
 bQSfBA4He1cQvWnM2fMdjbsYwG0XnYaId/4DSp/BM8DaVCVTi1kEutLObKngmvSg8Ugn
 XPAujqVC1gqM0OyUXBE1eqL2j8oM7saoBRSTOQoZWSlgZmzF5lk6g+2Rlb8rrkE0USYh
 3PjcMSIFse6nwTE6cKmcV5b2PIjcWF0D5R6mMM9dZWokWC9PmwI4uwRBw6D/e6qbG6o1
 MZRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaAtPIlkfhpUnt5bPWBFoJkxwDoLI2lmG1CQW9HAFI+HH+QHL/LoaPWUv6wfW816EJdQFugAk=@lists.denx.de
X-Gm-Message-State: AOJu0YzqbepfKhWsRJjr6bZeK4DVNEcDcSuIZjILuErdmPYUNTnmxFJ+
 V0H8NA2xowdBtdaIAk6BsDJ1i4pdp7gq7IQ08j0z+xSspjspxf3aHdqW9XbAXT0=
X-Google-Smtp-Source: AGHT+IG9GCgLM1EbPsDM1gLbgpf/aloH98QNQiKb6YJtpv9lgcDziUXK6XWXPEdE30gUxK1KVmPldg==
X-Received: by 2002:a05:6000:1fa1:b0:37e:eee5:80dc with SMTP id
 ffacd0b85a97d-38224fd0506mr412941f8f.28.1731619796284; 
 Thu, 14 Nov 2024 13:29:56 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:89e8:c8e2:1fe:645])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ada3febsm2459782f8f.19.2024.11.14.13.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 13:29:55 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Thu, 14 Nov 2024 22:29:46 +0100
Subject: [PATCH v2 3/5] configs: khadas-vim3l_android{_ab}: move on
 bootmeth android
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-adnroidv2-v2-3-015bffb1373a@baylibre.com>
References: <20241114-adnroidv2-v2-0-015bffb1373a@baylibre.com>
In-Reply-To: <20241114-adnroidv2-v2-0-015bffb1373a@baylibre.com>
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

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 configs/khadas-vim3l_android_ab_defconfig |  7 ++++++-
 configs/khadas-vim3l_android_defconfig    |  7 ++++++-
 include/configs/khadas-vim3l_android.h    | 26 ++++++++++++++++++++++----
 include/configs/meson64_android.h         |  3 ---
 4 files changed, 34 insertions(+), 9 deletions(-)

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
index f39a3782d663..31068c59d5ed 100644
--- a/include/configs/khadas-vim3l_android.h
+++ b/include/configs/khadas-vim3l_android.h
@@ -41,10 +41,28 @@
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
+	"gpio_recovery=88\0"                                          \
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

