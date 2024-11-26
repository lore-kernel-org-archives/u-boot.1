Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E103D5A6EC
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 08:07:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13ABB89C58;
	Tue, 26 Nov 2024 09:07:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EbPrcx8h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B56A289BEB; Tue, 26 Nov 2024 09:07:01 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 950F389C42
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 09:06:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4349e4e252dso18289955e9.0
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 00:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732608419; x=1733213219;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6DWLvb64bRnbCgK+UuoN3DG8lFNQurxwX39Of9id9ZM=;
 b=EbPrcx8h+8c4RZLo3fAtYLbuVIta67SshGYnpsoTrFKet8jc2gDG13Js9RIVnH6sRM
 qUbcPQ9N6rz7SuCKrAta5D8vqtq2yq/IHwZdszKGnCS2cM/smxNXW8LhxsFMyGxQEQbf
 NFEgtXX4G/siyDQts43QzagqhZeqeixAd6kegdFe27s4Kj0KibKM/3WWvlKGW1keja7F
 hCKAsLtQFUPlIbKCI+cioPiFHuO2LOt0qyFPe0rf1XRG1gWOjqEQlryLa6NfR+pVFRh1
 uM9Cu3WfZj+lGscl2G0UBcjnSf4zqb/yX6mmTDJsyMLZd+dTZv80dHEwf3oUp6klJbd9
 t3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732608419; x=1733213219;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6DWLvb64bRnbCgK+UuoN3DG8lFNQurxwX39Of9id9ZM=;
 b=mZZsFH9ggI1qV9P+V41j2As2oKBUnEJb1UjawEe84RJlPK2yUArsxrH4ZmGgpM5vS7
 eHdmFKxKvJ39gdCOcRTcj1ZY6PLeRAbXwPeuvt6v5X1wTJg9a1N/ySOynUvX8aGbhrDT
 kWf9mzgy19VD17hmxdfaMKqEWvD320c6KI+XkAPaD349v6/T4cdVSRz++rc7fSM1+G3B
 rwpDck6ruFrGSwAJhF7WkEFIHPe3b7RZq0gl0GAVJe4xJlgEzFtvQnTv2X9L0AyueJ3b
 k+soO0fQdG7oIbeT5mo3bQRVdgnJMfkzPnr3DXHCHFBcyv9lGhN5IyECWqZ/OC7ExbVj
 Yl3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0XWNvHaTKZG0QiC5yaPKp4AZqF2oVKd8ia9dNwxXvsSH8faomaS50NsgHh2way+k0wyXjOMw=@lists.denx.de
X-Gm-Message-State: AOJu0YyEa9PAxgU+mm8gnBjbqH717w4jItdYm/8pSe6A/F/pEYZmCLPc
 mEm4bVPg8fLBUQvRCWT15nZqn+UyY5CWiJanBSRx0+goCgcFRSdvzDSTevH1Vto=
X-Gm-Gg: ASbGncuWhAMRKlyAzE6ngdhT1qcTTVRzCC9fx3FGa/Q02fboGcz+WlOMYiO7NYNGQsC
 AgajEZzfZ6i/qbsdOnHMDJR2fnJrhWu03Sz7YFTiVoRpFeu/Nf3HO5y0NPxhcXOLJtTySBqbhKa
 aN+vfx+9UKMZm7Wc5mDLbw5+uIVUqH+BKI/RIh8m/4D3ru/oPh6c746UUsEA1nX+EEItzQSMyer
 MYba+LKFPBLvjWqcNPICh88rFZ8QqX9Z5ZaE1MdM9lT4fE8qWrDqA==
X-Google-Smtp-Source: AGHT+IEk8YFTSN+0QYxaFTbcAZYwTyrN1XV9QNgJGuVrL1D2z7KFtuGe+6VTqSFrwLU42h27V3eTPA==
X-Received: by 2002:a05:6000:18ae:b0:374:c847:852 with SMTP id
 ffacd0b85a97d-38260b806f8mr14209525f8f.29.1732608419050; 
 Tue, 26 Nov 2024 00:06:59 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:86be:4d54:1784:8cf7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb36612sm12513102f8f.59.2024.11.26.00.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 00:06:58 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Tue, 26 Nov 2024 09:06:12 +0100
Subject: [PATCH v4 4/5] configs: khadas-vim3_android{_ab}: move on bootmeth
 android
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-adnroidv2-v4-4-11636106dc69@baylibre.com>
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

