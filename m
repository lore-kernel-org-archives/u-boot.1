Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AEFD5A6EC
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 08:07:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA37C89C53;
	Tue, 26 Nov 2024 09:07:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Dq9drhO7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C18BF89189; Tue, 26 Nov 2024 09:07:00 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB06689189
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 09:06:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-434a752140eso2173585e9.3
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 00:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732608418; x=1733213218;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h2AMdeq6Ux/l8kBptoW82ulQU6JaL3ZI9a0FGRdRllI=;
 b=Dq9drhO7lB+L21mkWEYz9hjkSrwL6awPCRErqdrz9bJQop7NHm7FvSOANA0I5OqIes
 JiT13bGDe2T4/Tp4At/rgIa9wwhVz0CaegcqQThtgoFOH6iqoSJXOfma4YOMYynI88eC
 HXanpsB9TlJbcKtuBlDgxOOtkNtIe1hhilAmB7zlEo5xWabRXoQj+wu1OFyru75cx6+X
 WcEz3AgYyyDZzVYag4QLAZk3tj8ovi8A4/brcsT1Ut9rjqqRgo75GrKSdYuSQrdjXaz6
 jljx/BUUzyJSBR5jAQwOL7XZTuMXJr90HtNGxgcpqybKVTPe3LxX+P626gkCggmfF4Bo
 e/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732608418; x=1733213218;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h2AMdeq6Ux/l8kBptoW82ulQU6JaL3ZI9a0FGRdRllI=;
 b=FYpBEHgEEUBVY8Yffu6coFdq5uS+Xtfz+3R8COo8UI7AAWfkuL7OY/lSzX26aGF5Pr
 dCQkrNdvkm2JgWAiMgvVwv0nOX1026XlYGD3JYDB73vIWTknZWHsXNzu8R78zuwpxUDO
 bkppk/fE16AWmIMdtzy5zGoks/PqJKUBiV0iDpeCjKoBYHBf4a1++Zrx6teBnvO6bbZH
 Jg9WrCwnLcLgcPJfSBdfD7FJx8KYqvyjCo2NcNPVpiWDRMttzeKEF0n6l9amU36vnM8Q
 7nDQnsvMzQ+t0lwhYdgRAYF8VS1LlZlRHk2xBXcS4ktfJOyBVMDH9G9h8AdCj27wfuQB
 9/lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaEZSDVN9vBMWq6B0LoS5PpumqMXPORakRLi/rx0k7xBPxL9xVC5P8dv8xKFeZ//dR0h9fwag=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1Q2smf+nHUzhp9Jv9a0+c8zRuMJzFxA3qqmF63Z5SCinknEGY
 jy8uLKraxFcRrrsNgGjMXBpBB2VpaB2esZQkQiHrxwSfg0FIK7/LOlIHesK1CjI=
X-Gm-Gg: ASbGncvKjvcAZ9MQgGy8xCYC4YO8Lu457SHhpydA7eP/TgRg7zpa177xPdqObJNHNvx
 Db2u06aNlyWdlHUP/MoiPteXr5rw2PAXytdNgNd4eZefuVzgGF4kX5LhD1nyGhWxwkTSwrxoSs6
 4NWTmrjjjAybq4tPAfV+sdFbflee8PubF0U2xV8qlI/jKJlwPUUIyyw0qHBGHsKHYqddj3XUrTN
 8yEAT4sa1EaXUWSNt+yAxf4TPyBkIqeVTQLVFg7q/k/D+YNcFch1A==
X-Google-Smtp-Source: AGHT+IGeSfFme87wY8h9zJjOPAIhwCvNmqre2uOfc3DOi+CUJOHPcQSYIlU59S2Lmy02eOIvWevQfw==
X-Received: by 2002:a05:6000:4402:b0:382:4300:34d1 with SMTP id
 ffacd0b85a97d-38260b6e937mr9711368f8f.31.1732608418200; 
 Tue, 26 Nov 2024 00:06:58 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:86be:4d54:1784:8cf7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb36612sm12513102f8f.59.2024.11.26.00.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 00:06:57 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Tue, 26 Nov 2024 09:06:11 +0100
Subject: [PATCH v4 3/5] configs: khadas-vim3l_android{_ab}: move on
 bootmeth android
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-adnroidv2-v4-3-11636106dc69@baylibre.com>
References: <20241126-adnroidv2-v4-0-11636106dc69@baylibre.com>
In-Reply-To: <20241126-adnroidv2-v4-0-11636106dc69@baylibre.com>
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

