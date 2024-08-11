Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673BFC52D7C
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 12:29:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA76788617;
	Sun, 11 Aug 2024 14:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="htTxPyx6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B21E588617; Sun, 11 Aug 2024 14:29:38 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A9868845A
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 14:29:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-81f96ea9ff7so178479539f.3
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 05:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723379375; x=1723984175; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lu/Nj0jE9Wufr5wvpmMDJYEoaKaGN0F2eMevXRXdlsU=;
 b=htTxPyx6Iey5/4c6mxeEbEQiVeulDIUxJ1XlVjGE+IghwDSM2g23wEkTp7JxXbaXjr
 JcU8obWOzhuXkeCRiTffhr7yMMEPeBrLTGTMHO14I42dFHRz2j3UwFSnH5T9JCiRPS/o
 o93GaIWTfuwR/jk4nVSzSdGg8EIs099YJsAqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723379375; x=1723984175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lu/Nj0jE9Wufr5wvpmMDJYEoaKaGN0F2eMevXRXdlsU=;
 b=hzuiujiNFkAL5jDLmZWtyBTc+ARAgRHTt6F2QwpgK5sri1Zu/pAWN2WnJxQx3l1EqH
 TEAZ2vzVm6wArM4rIGEF+Zd3aHqpQIMQkjwC7k7fGpFfcRcZqBZct/3zWWL/e2qLtnW3
 72VPqoliASCKtH9kpNPqRaAQkD4ruBDcnB3i1YHcZAWKZJ/0+3V2xSY1PDypB9BQ30kc
 dL0FvPILm0e1Kkmu9VNy7zWcZ06X7U041BBRHnDsaEi+m2DYxQJI1fa1jU0t155ymV8K
 lbsS6uSFF9WzJEg2n+FExMB/YzjHWYk0EVgiRGJxSak3uqSCo1T2a8oCOyRxZdUn43QX
 pCxA==
X-Gm-Message-State: AOJu0Yzg+HJOcaU02Zf59zCsBTBM17cfK4ZD4CAAQ9P+lGY+wpBng35E
 1DpOkGc40SmFFcvO9FPOHr8AlEQLQlbv5vtOXMWjdL25pDwsNPqhuGlCgk/Fsv8wAVCAqkSQHAo
 =
X-Google-Smtp-Source: AGHT+IHtG+RnTGAFlOQ65Cz7uWHEQ+W8cdlLfQSWgpjHnPPw9D8HZtjZ3USflyVVFo+Pmeu03GdmaQ==
X-Received: by 2002:a05:6602:2c82:b0:81f:938b:f0cd with SMTP id
 ca18e2360f4ac-8225ee392afmr1220001739f.13.1723379374954; 
 Sun, 11 Aug 2024 05:29:34 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca76940448sm1017935173.45.2024.08.11.05.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 05:29:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 01/15] configs: Resync with savedefconfig
Date: Sun, 11 Aug 2024 06:29:10 -0600
Message-Id: <20240811122924.4035982-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811122924.4035982-1-sjg@chromium.org>
References: <20240811122924.4035982-1-sjg@chromium.org>
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

Rsync all defconfig files using moveconfig.py

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/am62px_evm_a53_defconfig           | 4 ++--
 configs/am64x_evm_a53_defconfig            | 6 +++---
 configs/j721e_beagleboneai64_a72_defconfig | 4 ++--
 configs/j721e_evm_a72_defconfig            | 7 +++----
 configs/j784s4_evm_a72_defconfig           | 4 ++--
 configs/kmcent2_defconfig                  | 1 -
 configs/kmcoge5ne_defconfig                | 1 -
 configs/kmeter1_defconfig                  | 1 -
 configs/kmopti2_defconfig                  | 1 -
 configs/kmsupx5_defconfig                  | 1 -
 configs/kmtepr2_defconfig                  | 1 -
 configs/pg_wcom_expu1_defconfig            | 1 -
 configs/pg_wcom_expu1_update_defconfig     | 1 -
 configs/pg_wcom_seli8_defconfig            | 1 -
 configs/pg_wcom_seli8_update_defconfig     | 1 -
 configs/qemu-xtensa-dc233c_defconfig       | 1 -
 configs/socfpga_secu1_defconfig            | 1 -
 configs/tuge1_defconfig                    | 1 -
 configs/tuxx1_defconfig                    | 1 -
 19 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/configs/am62px_evm_a53_defconfig b/configs/am62px_evm_a53_defconfig
index 87005d03dee..30d48340249 100644
--- a/configs/am62px_evm_a53_defconfig
+++ b/configs/am62px_evm_a53_defconfig
@@ -180,5 +180,5 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
 CONFIG_SPL_DFU=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
 CONFIG_EFI_SET_TIME=y
-
-#include <configs/k3_efi_capsule.config>
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
index 5b01002dfc4..66792595711 100644
--- a/configs/am64x_evm_a53_defconfig
+++ b/configs/am64x_evm_a53_defconfig
@@ -70,6 +70,7 @@ CONFIG_CMD_DFU=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TIME=y
@@ -150,7 +151,6 @@ CONFIG_DM_REGULATOR_TPS65219=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_REMOTEPROC_TI_PRU=y
-CONFIG_CMD_REMOTEPROC=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_EMULATION=y
@@ -187,5 +187,5 @@ CONFIG_USB_FUNCTION_MASS_STORAGE=y
 CONFIG_SPL_DFU=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
 CONFIG_EFI_SET_TIME=y
-
-#include <configs/k3_efi_capsule.config>
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
diff --git a/configs/j721e_beagleboneai64_a72_defconfig b/configs/j721e_beagleboneai64_a72_defconfig
index 86c565a9211..ead1d8389c6 100644
--- a/configs/j721e_beagleboneai64_a72_defconfig
+++ b/configs/j721e_beagleboneai64_a72_defconfig
@@ -172,5 +172,5 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x6163
 CONFIG_SPL_DFU=y
 CONFIG_LZO=y
 CONFIG_EFI_SET_TIME=y
-
-#include <configs/k3_efi_capsule.config>
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
index f99315789c7..acb6e9c556e 100644
--- a/configs/j721e_evm_a72_defconfig
+++ b/configs/j721e_evm_a72_defconfig
@@ -88,7 +88,7 @@ CONFIG_MMC_SPEED_MODE_SET=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_LIST="ti/k3-j721e-common-proc-board"
+CONFIG_OF_UPSTREAM=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
@@ -101,7 +101,6 @@ CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
 CONFIG_SPL_OF_TRANSLATE=y
-CONFIG_OF_UPSTREAM=y
 CONFIG_CLK=y
 CONFIG_SPL_CLK=y
 CONFIG_CLK_TI_SCI=y
@@ -211,5 +210,5 @@ CONFIG_UFS=y
 CONFIG_CADENCE_UFS=y
 CONFIG_TI_J721E_UFS=y
 CONFIG_EFI_SET_TIME=y
-
-#include <configs/k3_efi_capsule.config>
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
diff --git a/configs/j784s4_evm_a72_defconfig b/configs/j784s4_evm_a72_defconfig
index 520a53b12f6..d6505f60c57 100644
--- a/configs/j784s4_evm_a72_defconfig
+++ b/configs/j784s4_evm_a72_defconfig
@@ -162,5 +162,5 @@ CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_TI_SCI=y
 CONFIG_DM_THERMAL=y
 CONFIG_EFI_SET_TIME=y
-
-#include <configs/k3_efi_capsule.config>
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
diff --git a/configs/kmcent2_defconfig b/configs/kmcent2_defconfig
index 61a3ae23554..a50822e0906 100644
--- a/configs/kmcent2_defconfig
+++ b/configs/kmcent2_defconfig
@@ -111,4 +111,3 @@ CONFIG_BCH=y
 CONFIG_PANIC_HANG=y
 CONFIG_LZO=y
 CONFIG_POST=y
-CONFIG_HUSH_OLD_PARSER=y
diff --git a/configs/kmcoge5ne_defconfig b/configs/kmcoge5ne_defconfig
index 99ed7171694..7769ed8d11b 100644
--- a/configs/kmcoge5ne_defconfig
+++ b/configs/kmcoge5ne_defconfig
@@ -202,4 +202,3 @@ CONFIG_QE=y
 CONFIG_SYS_NS16550=y
 CONFIG_BCH=y
 CONFIG_POST=y
-CONFIG_HUSH_OLD_PARSER=y
diff --git a/configs/kmeter1_defconfig b/configs/kmeter1_defconfig
index 506a036bd49..d6f3284fe41 100644
--- a/configs/kmeter1_defconfig
+++ b/configs/kmeter1_defconfig
@@ -173,4 +173,3 @@ CONFIG_DM_ETH_PHY=y
 CONFIG_QE_UEC=y
 CONFIG_QE=y
 CONFIG_SYS_NS16550=y
-CONFIG_HUSH_OLD_PARSER=y
diff --git a/configs/kmopti2_defconfig b/configs/kmopti2_defconfig
index 0708067694d..ef51a7bce80 100644
--- a/configs/kmopti2_defconfig
+++ b/configs/kmopti2_defconfig
@@ -183,4 +183,3 @@ CONFIG_QE_UEC=y
 # CONFIG_PINCTRL_FULL is not set
 CONFIG_QE=y
 CONFIG_SYS_NS16550=y
-CONFIG_HUSH_OLD_PARSER=y
diff --git a/configs/kmsupx5_defconfig b/configs/kmsupx5_defconfig
index d241f72fd40..6542d993027 100644
--- a/configs/kmsupx5_defconfig
+++ b/configs/kmsupx5_defconfig
@@ -166,4 +166,3 @@ CONFIG_QE_UEC=y
 # CONFIG_PINCTRL_FULL is not set
 CONFIG_QE=y
 CONFIG_SYS_NS16550=y
-CONFIG_HUSH_OLD_PARSER=y
diff --git a/configs/kmtepr2_defconfig b/configs/kmtepr2_defconfig
index 26480b73cf6..ecd1778b922 100644
--- a/configs/kmtepr2_defconfig
+++ b/configs/kmtepr2_defconfig
@@ -182,4 +182,3 @@ CONFIG_QE_UEC=y
 # CONFIG_PINCTRL_FULL is not set
 CONFIG_QE=y
 CONFIG_SYS_NS16550=y
-CONFIG_HUSH_OLD_PARSER=y
diff --git a/configs/pg_wcom_expu1_defconfig b/configs/pg_wcom_expu1_defconfig
index 2f3ff9ac9c5..0c72360011f 100644
--- a/configs/pg_wcom_expu1_defconfig
+++ b/configs/pg_wcom_expu1_defconfig
@@ -106,4 +106,3 @@ CONFIG_SYS_NS16550=y
 CONFIG_LZO=y
 # CONFIG_EFI_LOADER is not set
 CONFIG_POST=y
-CONFIG_HUSH_OLD_PARSER=y
diff --git a/configs/pg_wcom_expu1_update_defconfig b/configs/pg_wcom_expu1_update_defconfig
index d7ab3c86fd6..e51c9a27aa5 100644
--- a/configs/pg_wcom_expu1_update_defconfig
+++ b/configs/pg_wcom_expu1_update_defconfig
@@ -104,4 +104,3 @@ CONFIG_SYS_NS16550=y
 CONFIG_LZO=y
 # CONFIG_EFI_LOADER is not set
 CONFIG_POST=y
-CONFIG_HUSH_OLD_PARSER=y
diff --git a/configs/pg_wcom_seli8_defconfig b/configs/pg_wcom_seli8_defconfig
index bd3ac2e18ac..c5876223f04 100644
--- a/configs/pg_wcom_seli8_defconfig
+++ b/configs/pg_wcom_seli8_defconfig
@@ -106,4 +106,3 @@ CONFIG_SYS_NS16550=y
 CONFIG_LZO=y
 # CONFIG_EFI_LOADER is not set
 CONFIG_POST=y
-CONFIG_HUSH_OLD_PARSER=y
diff --git a/configs/pg_wcom_seli8_update_defconfig b/configs/pg_wcom_seli8_update_defconfig
index 733050110b1..8cfeab77c9f 100644
--- a/configs/pg_wcom_seli8_update_defconfig
+++ b/configs/pg_wcom_seli8_update_defconfig
@@ -104,4 +104,3 @@ CONFIG_SYS_NS16550=y
 CONFIG_LZO=y
 # CONFIG_EFI_LOADER is not set
 CONFIG_POST=y
-CONFIG_HUSH_OLD_PARSER=y
diff --git a/configs/qemu-xtensa-dc233c_defconfig b/configs/qemu-xtensa-dc233c_defconfig
index e6f40b37ed8..9fc74bc48e7 100644
--- a/configs/qemu-xtensa-dc233c_defconfig
+++ b/configs/qemu-xtensa-dc233c_defconfig
@@ -7,7 +7,6 @@ CONFIG_DEFAULT_DEVICE_TREE="virt"
 CONFIG_SYS_MONITOR_LEN=262144
 CONFIG_SYS_LOAD_ADDR=0x02000000
 CONFIG_TARGET_QEMU_XTENSA=y
-CONFIG_REMAKE_ELF=y
 CONFIG_SYS_MONITOR_BASE=0xF6000000
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_SHOW_BOOT_PROGRESS=y
diff --git a/configs/socfpga_secu1_defconfig b/configs/socfpga_secu1_defconfig
index b8d9c849bcd..a08ba22fdb5 100644
--- a/configs/socfpga_secu1_defconfig
+++ b/configs/socfpga_secu1_defconfig
@@ -111,4 +111,3 @@ CONFIG_DESIGNWARE_WATCHDOG=y
 CONFIG_WDT=y
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
 # CONFIG_GZIP is not set
-CONFIG_HUSH_OLD_PARSER=y
diff --git a/configs/tuge1_defconfig b/configs/tuge1_defconfig
index ab221de25a1..cf0ea9a6334 100644
--- a/configs/tuge1_defconfig
+++ b/configs/tuge1_defconfig
@@ -166,4 +166,3 @@ CONFIG_QE_UEC=y
 # CONFIG_PINCTRL_FULL is not set
 CONFIG_QE=y
 CONFIG_SYS_NS16550=y
-CONFIG_HUSH_OLD_PARSER=y
diff --git a/configs/tuxx1_defconfig b/configs/tuxx1_defconfig
index 22c5d487a4a..b52e2b7cf4a 100644
--- a/configs/tuxx1_defconfig
+++ b/configs/tuxx1_defconfig
@@ -183,4 +183,3 @@ CONFIG_QE_UEC=y
 # CONFIG_PINCTRL_FULL is not set
 CONFIG_QE=y
 CONFIG_SYS_NS16550=y
-CONFIG_HUSH_OLD_PARSER=y
-- 
2.34.1

