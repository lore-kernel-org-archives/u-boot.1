Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21758C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:28:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E47C869EB;
	Thu, 24 Aug 2023 21:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QB0LVFIw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E652D86995; Thu, 24 Aug 2023 21:27:01 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52E198690B
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:26:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-52a39a1c4d5so318532a12.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692905219; x=1693510019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VtuZa1yDI4jU6hOW/P1KFr1PEN+hHWyFrCubcZCbl1E=;
 b=QB0LVFIwUEnPKNNmESUTQsfXnYSpvyYFskmkeMNP4fuov/PyPFs/KruAtCLNiqzNoq
 KkacNw3lhhrGs76yYBsxhreGjzhMa6gN9FaxIMkGgyk256MCtG88Y/SO6lXFFN1qAdS/
 8Ecl1C2YsI3fn5bAg1C5z2u9cpXr21Rjjc4HOZ7D3mrFGgEJzs8smsZztHSKXJI8//L+
 jzoV8Ktc0bEiX8FFRhSPsPFgeWWIO/HpAMBxI8PQrtqNzmZuxsFLyCYi+UeX4qV+7vLY
 UpVnHoif6bFgAR3nCeNrS2VWPj5kWGIhiQiTJO4yvPknUbRVYhu4GhAEjhFI4+bf28j7
 SZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692905219; x=1693510019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VtuZa1yDI4jU6hOW/P1KFr1PEN+hHWyFrCubcZCbl1E=;
 b=I2bZLUe+04MmOR5ThnnLbONE0g7Jw9ekcOTIvCQjPpNolUdoKY9w4MEDXxJxoLof+w
 JMNen6xsgiHpXcmcPA/fr06URYCpcbsLF55wsNUXnVr/9YDGBFColInNFI0yOeAMIHep
 XxRdmSpY/1J39XO7QD9VKLiEfzZQph711lf85bZZnGEGwDqF8OrRRp2jAo+vqJOhJ+YJ
 hYhRVWATpIeyKWd8364ri+uovhYx9j72ymSUgB2bLYc0QvO1ZWMDekwxnnLbok2UzRW+
 0ZYMD1BllxTZnHD6Ud5a9BKplhqRz1dnfZiKWcRz+Wt58F1eL4GNx2j0LCRqE82POB3D
 IZ9Q==
X-Gm-Message-State: AOJu0YyFauck5w0ButsuNp1exCAFJPHWGZbfRRg+hcje0eATWAR89+PO
 SiP57bIQxafETs3xsrOKcWY=
X-Google-Smtp-Source: AGHT+IGZ6NUkkx2+RKXCH5HdYfpNb2jWcZFjN9XrInR9kGUxwfK+v2xIVXtf5TbIeF9rU1ydf/arTA==
X-Received: by 2002:aa7:d058:0:b0:522:4c7a:d5a9 with SMTP id
 n24-20020aa7d058000000b005224c7ad5a9mr13581172edo.3.1692905218854; 
 Thu, 24 Aug 2023 12:26:58 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 be20-20020a0564021a3400b0052a1d98618bsm96033edb.54.2023.08.24.12.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:26:58 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 11/16] configs: transformer_t30: grouper: lg-x3: endeavoru:
 sync defconfigs
Date: Thu, 24 Aug 2023 22:25:58 +0300
Message-Id: <20230824192603.240104-12-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824192603.240104-1-clamor95@gmail.com>
References: <20230824192603.240104-1-clamor95@gmail.com>
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

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 configs/endeavoru_defconfig       | 2 --
 configs/grouper_common_defconfig  | 4 ----
 configs/tf600t.config             | 1 +
 configs/transformer_t30_defconfig | 2 --
 configs/x3_t30_defconfig          | 2 --
 5 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/configs/endeavoru_defconfig b/configs/endeavoru_defconfig
index 38f26f2dcc..feb481170a 100644
--- a/configs/endeavoru_defconfig
+++ b/configs/endeavoru_defconfig
@@ -21,7 +21,6 @@ CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTDELAY=0
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_KEYED_CTRLC=y
-CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="if run check_button; then bootmenu; fi; run bootcmd_mmc0; poweroff;"
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
@@ -44,7 +43,6 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_UMS_ABORT_KEYED=y
 # CONFIG_CMD_SETEXPR is not set
-# CONFIG_CMD_NFS is not set
 CONFIG_CMD_PAUSE=y
 CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_DOS_PARTITION is not set
diff --git a/configs/grouper_common_defconfig b/configs/grouper_common_defconfig
index 8dc88851f5..36ad0980e7 100644
--- a/configs/grouper_common_defconfig
+++ b/configs/grouper_common_defconfig
@@ -21,7 +21,6 @@ CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTDELAY=0
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_KEYED_CTRLC=y
-CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="if run check_button; then bootmenu; fi; run bootcmd_mmc0; poweroff;"
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
@@ -43,7 +42,6 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_UMS_ABORT_KEYED=y
 # CONFIG_CMD_SETEXPR is not set
-# CONFIG_CMD_NFS is not set
 CONFIG_CMD_PAUSE=y
 CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_DOS_PARTITION is not set
@@ -61,8 +59,6 @@ CONFIG_FASTBOOT_FLASH_MMC_DEV=0
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_GPIO_HOG=y
 CONFIG_SYS_I2C_TEGRA=y
-CONFIG_I2C_MUX=y
-CONFIG_I2C_MUX_GPIO=y
 CONFIG_BUTTON_KEYBOARD=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_REGULATOR=y
diff --git a/configs/tf600t.config b/configs/tf600t.config
index 18ab4fbd87..ee1b827bea 100644
--- a/configs/tf600t.config
+++ b/configs/tf600t.config
@@ -2,3 +2,4 @@ CONFIG_DEFAULT_DEVICE_TREE="tegra30-asus-tf600t"
 CONFIG_TRANSFORMER_SPI_BOOT=y
 CONFIG_BOOTCOMMAND="setenv gpio_button 222; if run check_button; then poweroff; fi; setenv gpio_button 132; if run check_button; then echo Starting SPI flash update ...; run update_spi; fi; run bootcmd_usb0; run bootcmd_mmc1; run bootcmd_mmc0; poweroff;"
 CONFIG_USB_GADGET_PRODUCT_NUM=0x4d00
+CONFIG_VIDEO_DSI_TEGRA30=y
diff --git a/configs/transformer_t30_defconfig b/configs/transformer_t30_defconfig
index 802dcb1786..eaff0697bb 100644
--- a/configs/transformer_t30_defconfig
+++ b/configs/transformer_t30_defconfig
@@ -21,7 +21,6 @@ CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTDELAY=0
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_KEYED_CTRLC=y
-CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv skip_boot 0; setenv gpio_button 150; if run check_button; then poweroff; fi; setenv gpio_button 131; if run check_button; then bootmenu; fi; if test ${skip_boot} -eq 1; then; else run bootcmd_usb0; run bootcmd_mmc1; run bootcmd_mmc0; poweroff; fi"
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
@@ -45,7 +44,6 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_UMS_ABORT_KEYED=y
 # CONFIG_CMD_SETEXPR is not set
-# CONFIG_CMD_NFS is not set
 CONFIG_CMD_PAUSE=y
 CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_DOS_PARTITION is not set
diff --git a/configs/x3_t30_defconfig b/configs/x3_t30_defconfig
index 540c43096d..98744ec89d 100644
--- a/configs/x3_t30_defconfig
+++ b/configs/x3_t30_defconfig
@@ -22,7 +22,6 @@ CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTDELAY=0
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_KEYED_CTRLC=y
-CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="if run check_button; then bootmenu; fi; run bootcmd_mmc1; run bootcmd_mmc0; poweroff;"
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
@@ -45,7 +44,6 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_UMS_ABORT_KEYED=y
 # CONFIG_CMD_SETEXPR is not set
-# CONFIG_CMD_NFS is not set
 CONFIG_CMD_PAUSE=y
 CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_DOS_PARTITION is not set
-- 
2.39.2

