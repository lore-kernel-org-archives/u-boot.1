Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC6CD4414B
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 11:38:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C9168957E;
	Tue, 19 Nov 2024 12:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IeMrmB9w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 533AB89548; Tue, 19 Nov 2024 12:37:53 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59CE68956D
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 12:37:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3822b77da55so2193618f8f.1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 03:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732016271; x=1732621071;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6DWLvb64bRnbCgK+UuoN3DG8lFNQurxwX39Of9id9ZM=;
 b=IeMrmB9wWOFRcrxnVrI3vsJ6UBq7CErP6CD/QdBE8ezkExrrilli2pSCekV/5/Qrbg
 5WrrNOKMZhO5VrfyF+DiPZTXF7tck1W5sfpFRuD/zzibnEHTyHVXHSgkMs9qhFw1mqZr
 cyC0NIgCEE6eo+NNUee6PO448YsKqAHPwAt3e4mAKLseZDN+/2Zg+8UbCit7qkaQZEOv
 Bz1wfhASNZs1OIzkJ+pjxLOce77I5G1ueXxaJZ6tLSwJxdPauVLeVkYsStu8EpTEDg2L
 E1NrvyJ5jtijZxsEbizU2MPzYLxZE+7IZf8E5U2agGugc4X2qTxhZIy0Amf56OGi+wBn
 8cKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732016271; x=1732621071;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6DWLvb64bRnbCgK+UuoN3DG8lFNQurxwX39Of9id9ZM=;
 b=A5NSbOSAeXFg05wJpULtDEJ9opV1v82wCkWtgNOBNeb6BZK4GaA6onBaNU/v7rK8a+
 u4PxthAV+6TGkGwXrM5n5cP7irLbWYvmYKy1zE1As2yadmS1BUNUPuiIs/gYGdZVm57h
 UDre2b4Zz3UK8zIej4vgkUmykojkTMpZMHwHXPdkTvsxMFAv7vUSCgytfbsFf2udYoud
 p77klcu5UrTeK1sDsmnkYwcr/LcwH9wmJ+VBuvYKb5ahan0rY+rXVgcEs/i0n/1XR84G
 brU7KB7VlQLEgT5rCBQtZd7wWvr7FFzPFW9n2uMkX6/uDkGGQC6ldjPUyjC3boTVgxe0
 Tdhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc00ipLZCtCvGuT6m1CZ7h8lgkPR/sv86aQnvqOys/b+4anKJD6RcxWGIqGJFDcJ/Go8RWS0E=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/lP6EejxfPDrdOYeine7CJ9bqaRSfDp9nlBGNMwkf/zFF+b/e
 PKuIbOAfh2QfZfKTrO7hBLsEFW08sprEZLnQorkiv4lFusViEIOci3NLeojY1eQ=
X-Google-Smtp-Source: AGHT+IFf0RhDwz2n6osvzJqMliyLQGt2UO9s39f0Sbxdjub4qVJOOXdHH+whCwqLHZh+Lr4qNecu6A==
X-Received: by 2002:a05:6000:2a8:b0:382:2e9e:d695 with SMTP id
 ffacd0b85a97d-3824cd34013mr1707362f8f.24.1732016270857; 
 Tue, 19 Nov 2024 03:37:50 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:cc39:27ba:4c6c:3c84])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3824259dda3sm7580388f8f.77.2024.11.19.03.37.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 03:37:49 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Tue, 19 Nov 2024 12:37:41 +0100
Subject: [PATCH v3 4/5] configs: khadas-vim3_android{_ab}: move on bootmeth
 android
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-adnroidv2-v3-4-45baa486fb31@baylibre.com>
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

Actually khadas vim3 use distro command to boot android image.
Move on new bootmeth android for A/B and non-A/B vim3 android.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 configs/khadas-vim3_android_ab_defconfig |  7 ++++++-
 configs/khadas-vim3_android_defconfig    |  7 ++++++-
 include/configs/khadas-vim3_android.h    | 25 +++++++++++++++++++++----
 include/configs/meson64_android.h        |  3 ---
 4 files changed, 33 insertions(+), 9 deletions(-)

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
index 0e2953fe71b3..551ab51c8813 100644
--- a/include/configs/khadas-vim3_android.h
+++ b/include/configs/khadas-vim3_android.h
@@ -41,10 +41,27 @@
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
index 37ef8b8f7a7e..d6ef0a83a686 100644
--- a/include/configs/meson64_android.h
+++ b/include/configs/meson64_android.h
@@ -104,9 +104,6 @@
 	"elif test $board_name = sei610; then " \
 		"echo \"  Reading DTB for sei610...\"; " \
 		"setenv dtb_index 1;" \
-	"elif test $board_name = vim3; then " \
-		"echo \"  Reading DTB for vim3...\"; " \
-		"setenv dtb_index 3;" \
 	"else " \
 		"echo Error: Android boot is not supported for $board_name; " \
 		"exit; " \

-- 
2.34.1

