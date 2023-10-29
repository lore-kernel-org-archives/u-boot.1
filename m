Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD284C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 03:49:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3A2B87C6C;
	Sun, 29 Oct 2023 04:49:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aoM7NO1e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58B6787776; Sun, 29 Oct 2023 04:48:59 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 922CF87738
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 04:48:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-41cd6e1d4fbso22828751cf.1
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 20:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698551332; x=1699156132; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Foqj0mNovbBO3riAm0XJlxYuTwOnVicIEoNaj14Mps=;
 b=aoM7NO1eIDNMlhP3DCXIx/A/22PjeskVItr73aioTeAft+FymjGYUTqJrirV0H4wBG
 /WMRBSqTmIWMb1XD8FlHm/3GkagaV48fcXSFZp302aS37URsikk2LVFqiMP1G9LUpsYI
 EqsP0WQqyHLtVGJ1sl5KvZwEDMGpDSdxHbjrfMZqfU8Sr8f5KUUTgKVvF8hRNJxBNDFj
 ONDnJGuqtZg8dOrgSVIgBHamKi2AqvQohOKBWvoSA+UAg6q+gyNTMKClOO/OQwjU/a0Z
 TAdoPADz1MCAoHh7O2Njo218WyuNuY4WuTV/e/hA8im//wOvK530biDXd+THX/LsCes+
 Yf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698551332; x=1699156132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Foqj0mNovbBO3riAm0XJlxYuTwOnVicIEoNaj14Mps=;
 b=BYnOzxedJ21K3yIOlvY5G9OUllUBC87SLb2s/8odYs+YeWAPjIuVcKJCKbInNxMLyD
 eLv+j89xX0tdX5DlTE4tfD2BiZgzOmZqP4XCisCUh/Mq5KZVmijGitQnP0oF1X4FJ9VD
 Y2YDW5+KmdwKutzG2DcH9oUBJYcQzYIPxcjKBVrL2p2s7MkDVemF2y63QgFaLnJPqQCM
 uiWoOhS8sVu2a6eV2IrXS/O7Hsj1jHw81JdFCHH0SqVcXpIT1xPMDLa34Y/a28X1Jvc4
 yHzRyC2Z3i6sR1w778bV3zYEK5WiZwOxn6dc4vlAd8VtdU9XQHpuW8u0GIL2cI0iob1c
 OGlg==
X-Gm-Message-State: AOJu0YwtcbMP1mLqvIVI8a7ok/aBx8x7UEIUKq313TY3/c4Ds6jhFeqw
 KOmN0+G5Snw1h01yva6JbT/gJS44jDCTVA==
X-Google-Smtp-Source: AGHT+IErqKI+yUpg5ff0FgNKJKiXJ3cWZgOypBDoNVG1CS5WRNNxNpHqoXY61s5GXHjSsfe1CAcx0w==
X-Received: by 2002:a05:622a:8d:b0:41e:24d9:596f with SMTP id
 o13-20020a05622a008d00b0041e24d9596fmr7444921qtw.44.1698551332525; 
 Sat, 28 Oct 2023 20:48:52 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 g13-20020ac84dcd000000b00403cce833eesm2153408qtw.27.2023.10.28.20.48.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 20:48:52 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>,
	Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 03/15] nand: Calculate SYS_NAND_PAGE_COUNT automatically
Date: Sat, 28 Oct 2023 23:48:33 -0400
Message-Id: <20231029034845.1169614-4-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231029034845.1169614-1-seanga2@gmail.com>
References: <20231029034845.1169614-1-seanga2@gmail.com>
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

Contrary to what the help message says, this is the number of pages per
block. Calculate it automatically based on SYS_NAND_BLOCK_SIZE and
SYS_NAND_PAGE_SIZE.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 README                                          | 9 ++++-----
 configs/am335x_baltos_defconfig                 | 1 -
 configs/am335x_evm_defconfig                    | 1 -
 configs/am335x_guardian_defconfig               | 1 -
 configs/am335x_igep003x_defconfig               | 1 -
 configs/am3517_evm_defconfig                    | 1 -
 configs/am43xx_evm_defconfig                    | 1 -
 configs/am43xx_evm_rtconly_defconfig            | 1 -
 configs/am43xx_evm_usbhost_boot_defconfig       | 1 -
 configs/am43xx_hs_evm_defconfig                 | 1 -
 configs/axm_defconfig                           | 1 -
 configs/chiliboard_defconfig                    | 1 -
 configs/corvus_defconfig                        | 1 -
 configs/da850evm_nand_defconfig                 | 1 -
 configs/devkit3250_defconfig                    | 1 -
 configs/devkit8000_defconfig                    | 1 -
 configs/dra7xx_evm_defconfig                    | 1 -
 configs/draco_defconfig                         | 1 -
 configs/etamin_defconfig                        | 1 -
 configs/gardena-smart-gateway-at91sam_defconfig | 1 -
 configs/igep00x0_defconfig                      | 1 -
 configs/m53menlo_defconfig                      | 1 -
 configs/omap35_logic_defconfig                  | 1 -
 configs/omap35_logic_somlv_defconfig            | 1 -
 configs/omap3_beagle_defconfig                  | 1 -
 configs/omap3_evm_defconfig                     | 1 -
 configs/omap3_logic_defconfig                   | 1 -
 configs/omap3_logic_somlv_defconfig             | 1 -
 configs/omapl138_lcdk_defconfig                 | 1 -
 configs/phycore-am335x-r2-regor_defconfig       | 1 -
 configs/phycore-am335x-r2-wega_defconfig        | 1 -
 configs/pxm2_defconfig                          | 1 -
 configs/rastaban_defconfig                      | 1 -
 configs/rut_defconfig                           | 1 -
 configs/sama5d3_xplained_nandflash_defconfig    | 1 -
 configs/sama5d3xek_nandflash_defconfig          | 1 -
 configs/sama5d4_xplained_nandflash_defconfig    | 1 -
 configs/sama5d4ek_nandflash_defconfig           | 1 -
 configs/smartweb_defconfig                      | 1 -
 configs/taurus_defconfig                        | 1 -
 configs/thuban_defconfig                        | 1 -
 drivers/mtd/nand/raw/Kconfig                    | 8 --------
 drivers/mtd/nand/raw/am335x_spl_bch.c           | 3 ++-
 drivers/mtd/nand/raw/atmel_nand.c               | 5 +++--
 drivers/mtd/nand/raw/mxc_nand_spl.c             | 5 +++--
 drivers/mtd/nand/raw/nand_spl_loaders.c         | 2 +-
 drivers/mtd/nand/raw/nand_spl_simple.c          | 5 +++--
 drivers/mtd/nand/raw/omap_gpmc.c                | 3 ++-
 include/system-constants.h                      | 3 +++
 49 files changed, 21 insertions(+), 62 deletions(-)

diff --git a/README b/README
index 60c6b8a19db..00d422737fb 100644
--- a/README
+++ b/README
@@ -1191,11 +1191,10 @@ The following options need to be configured:
 		Support for a lightweight UBI (fastmap) scanner and
 		loader
 
-		CONFIG_SYS_NAND_5_ADDR_CYCLE, CONFIG_SYS_NAND_PAGE_COUNT,
-		CONFIG_SYS_NAND_PAGE_SIZE, CONFIG_SYS_NAND_OOBSIZE,
-		CONFIG_SYS_NAND_BLOCK_SIZE, CONFIG_SYS_NAND_BAD_BLOCK_POS,
-		CFG_SYS_NAND_ECCPOS, CFG_SYS_NAND_ECCSIZE,
-		CFG_SYS_NAND_ECCBYTES
+		CONFIG_SYS_NAND_5_ADDR_CYCLE, CONFIG_SYS_NAND_PAGE_SIZE,
+		CONFIG_SYS_NAND_OOBSIZE, CONFIG_SYS_NAND_BLOCK_SIZE,
+		CONFIG_SYS_NAND_BAD_BLOCK_POS, CFG_SYS_NAND_ECCPOS,
+		CFG_SYS_NAND_ECCSIZE, CFG_SYS_NAND_ECCBYTES
 		Defines the size and behavior of the NAND that SPL uses
 		to read U-Boot
 
diff --git a/configs/am335x_baltos_defconfig b/configs/am335x_baltos_defconfig
index 16993ef5386..3891e48e9c7 100644
--- a/configs/am335x_baltos_defconfig
+++ b/configs/am335x_baltos_defconfig
@@ -67,7 +67,6 @@ CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
 CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
index f048e60f7f3..73f221d55bc 100644
--- a/configs/am335x_evm_defconfig
+++ b/configs/am335x_evm_defconfig
@@ -84,7 +84,6 @@ CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
 CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
diff --git a/configs/am335x_guardian_defconfig b/configs/am335x_guardian_defconfig
index 01d848ceede..5369e46bc1b 100644
--- a/configs/am335x_guardian_defconfig
+++ b/configs/am335x_guardian_defconfig
@@ -99,7 +99,6 @@ CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_OMAP_ECCSCHEME_BCH16_CODE_HW=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x40000
 CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x1000
 CONFIG_SYS_NAND_OOBSIZE=0x100
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
diff --git a/configs/am335x_igep003x_defconfig b/configs/am335x_igep003x_defconfig
index 4dd6366ef67..4c5c82f9bdd 100644
--- a/configs/am335x_igep003x_defconfig
+++ b/configs/am335x_igep003x_defconfig
@@ -85,7 +85,6 @@ CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
 CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_MTD_UBI_FASTMAP=y
diff --git a/configs/am3517_evm_defconfig b/configs/am3517_evm_defconfig
index 0a83ac9378c..111929fb912 100644
--- a/configs/am3517_evm_defconfig
+++ b/configs/am3517_evm_defconfig
@@ -75,7 +75,6 @@ CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_OMAP_ECCSCHEME_BCH8_CODE_HW_DETECTION_SW=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_BUSWIDTH_16BIT=y
diff --git a/configs/am43xx_evm_defconfig b/configs/am43xx_evm_defconfig
index 6571afd345e..5f2356bcd32 100644
--- a/configs/am43xx_evm_defconfig
+++ b/configs/am43xx_evm_defconfig
@@ -72,7 +72,6 @@ CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_OMAP_ECCSCHEME_BCH16_CODE_HW=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x40000
 CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x1000
 CONFIG_SYS_NAND_OOBSIZE=0xe0
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
diff --git a/configs/am43xx_evm_rtconly_defconfig b/configs/am43xx_evm_rtconly_defconfig
index e84aed4d54d..30681e7eeb6 100644
--- a/configs/am43xx_evm_rtconly_defconfig
+++ b/configs/am43xx_evm_rtconly_defconfig
@@ -62,7 +62,6 @@ CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_OMAP_ECCSCHEME_BCH16_CODE_HW=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x40000
 CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x1000
 CONFIG_SYS_NAND_OOBSIZE=0xe0
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
diff --git a/configs/am43xx_evm_usbhost_boot_defconfig b/configs/am43xx_evm_usbhost_boot_defconfig
index 0cae3242b04..6c4cc99e5ff 100644
--- a/configs/am43xx_evm_usbhost_boot_defconfig
+++ b/configs/am43xx_evm_usbhost_boot_defconfig
@@ -75,7 +75,6 @@ CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_OMAP_ECCSCHEME_BCH16_CODE_HW=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x40000
 CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x1000
 CONFIG_SYS_NAND_OOBSIZE=0xe0
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
diff --git a/configs/am43xx_hs_evm_defconfig b/configs/am43xx_hs_evm_defconfig
index 370ee967258..49ecb4c9e66 100644
--- a/configs/am43xx_hs_evm_defconfig
+++ b/configs/am43xx_hs_evm_defconfig
@@ -68,7 +68,6 @@ CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_OMAP_ECCSCHEME_BCH16_CODE_HW=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x40000
 CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x1000
 CONFIG_SYS_NAND_OOBSIZE=0xe0
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
diff --git a/configs/axm_defconfig b/configs/axm_defconfig
index f9c02144c4a..e1a01b24b88 100644
--- a/configs/axm_defconfig
+++ b/configs/axm_defconfig
@@ -86,7 +86,6 @@ CONFIG_MTD=y
 # CONFIG_SYS_NAND_USE_FLASH_BBT is not set
 CONFIG_NAND_ATMEL=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
diff --git a/configs/chiliboard_defconfig b/configs/chiliboard_defconfig
index 06642d282d1..0cd649d643a 100644
--- a/configs/chiliboard_defconfig
+++ b/configs/chiliboard_defconfig
@@ -63,7 +63,6 @@ CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
 CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
diff --git a/configs/corvus_defconfig b/configs/corvus_defconfig
index ecf61f0d1e6..5eaa6dbb5fc 100644
--- a/configs/corvus_defconfig
+++ b/configs/corvus_defconfig
@@ -81,7 +81,6 @@ CONFIG_SYS_NAND_DRIVER_ECC_LAYOUT=y
 # CONFIG_SYS_NAND_USE_FLASH_BBT is not set
 CONFIG_NAND_ATMEL=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
diff --git a/configs/da850evm_nand_defconfig b/configs/da850evm_nand_defconfig
index 5f6f5d788d0..62b8edde248 100644
--- a/configs/da850evm_nand_defconfig
+++ b/configs/da850evm_nand_defconfig
@@ -88,7 +88,6 @@ CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_NAND_USE_FLASH_BBT=y
 CONFIG_NAND_DAVINCI=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
diff --git a/configs/devkit3250_defconfig b/configs/devkit3250_defconfig
index ec4031da51d..569b156c997 100644
--- a/configs/devkit3250_defconfig
+++ b/configs/devkit3250_defconfig
@@ -73,7 +73,6 @@ CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_NAND_USE_FLASH_BBT=y
 CONFIG_NAND_LPC32XX_SLC=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 # CONFIG_SYS_NAND_5_ADDR_CYCLE is not set
diff --git a/configs/devkit8000_defconfig b/configs/devkit8000_defconfig
index ef16da176a9..a7f82442eb0 100644
--- a/configs/devkit8000_defconfig
+++ b/configs/devkit8000_defconfig
@@ -77,7 +77,6 @@ CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_OMAP_ECCSCHEME_HAM1_CODE_HW=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_BUSWIDTH_16BIT=y
diff --git a/configs/dra7xx_evm_defconfig b/configs/dra7xx_evm_defconfig
index 19ca89fa867..c3a3ec2cd42 100644
--- a/configs/dra7xx_evm_defconfig
+++ b/configs/dra7xx_evm_defconfig
@@ -104,7 +104,6 @@ CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
 CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_BUSWIDTH_16BIT=y
diff --git a/configs/draco_defconfig b/configs/draco_defconfig
index ee19920a703..2a82087ab31 100644
--- a/configs/draco_defconfig
+++ b/configs/draco_defconfig
@@ -100,7 +100,6 @@ CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
 CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
diff --git a/configs/etamin_defconfig b/configs/etamin_defconfig
index c0ce7a33569..4ac0abc56b0 100644
--- a/configs/etamin_defconfig
+++ b/configs/etamin_defconfig
@@ -104,7 +104,6 @@ CONFIG_SYS_MAX_NAND_DEVICE=3
 CONFIG_NAND_OMAP_ECCSCHEME_BCH16_CODE_HW=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x80000
 CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_PAGE_COUNT=0x80
 CONFIG_SYS_NAND_PAGE_SIZE=0x1000
 CONFIG_SYS_NAND_OOBSIZE=0xe0
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
diff --git a/configs/gardena-smart-gateway-at91sam_defconfig b/configs/gardena-smart-gateway-at91sam_defconfig
index 439fcc05753..0fb92ff1638 100644
--- a/configs/gardena-smart-gateway-at91sam_defconfig
+++ b/configs/gardena-smart-gateway-at91sam_defconfig
@@ -99,7 +99,6 @@ CONFIG_MTD=y
 CONFIG_NAND_ATMEL=y
 CONFIG_SPL_GENERATE_ATMEL_PMECC_HEADER=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
diff --git a/configs/igep00x0_defconfig b/configs/igep00x0_defconfig
index 993bbe29c6b..3b1af07f057 100644
--- a/configs/igep00x0_defconfig
+++ b/configs/igep00x0_defconfig
@@ -78,7 +78,6 @@ CONFIG_SYS_MTDPARTS_RUNTIME=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_OMAP_ECCSCHEME_BCH8_CODE_HW_DETECTION_SW=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_BUSWIDTH_16BIT=y
diff --git a/configs/m53menlo_defconfig b/configs/m53menlo_defconfig
index ef9e15d1520..e1ddc0af5db 100644
--- a/configs/m53menlo_defconfig
+++ b/configs/m53menlo_defconfig
@@ -90,7 +90,6 @@ CONFIG_SYS_NAND_USE_FLASH_BBT=y
 CONFIG_NAND_MXC=y
 CONFIG_MXC_NAND_HWECC=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
diff --git a/configs/omap35_logic_defconfig b/configs/omap35_logic_defconfig
index 539b0cfa4f7..3a656072534 100644
--- a/configs/omap35_logic_defconfig
+++ b/configs/omap35_logic_defconfig
@@ -74,7 +74,6 @@ CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_OMAP_ECCSCHEME_BCH8_CODE_HW_DETECTION_SW=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_BUSWIDTH_16BIT=y
diff --git a/configs/omap35_logic_somlv_defconfig b/configs/omap35_logic_somlv_defconfig
index f14ce3d23db..868e89114b7 100644
--- a/configs/omap35_logic_somlv_defconfig
+++ b/configs/omap35_logic_somlv_defconfig
@@ -83,7 +83,6 @@ CONFIG_SYS_MAX_FLASH_SECT=256
 CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_OMAP_ECCSCHEME_BCH8_CODE_HW_DETECTION_SW=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_BUSWIDTH_16BIT=y
diff --git a/configs/omap3_beagle_defconfig b/configs/omap3_beagle_defconfig
index cabd3659385..7f0b927528d 100644
--- a/configs/omap3_beagle_defconfig
+++ b/configs/omap3_beagle_defconfig
@@ -83,7 +83,6 @@ CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_OMAP_ECCSCHEME_HAM1_CODE_HW=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_BUSWIDTH_16BIT=y
diff --git a/configs/omap3_evm_defconfig b/configs/omap3_evm_defconfig
index 33ff39ff548..3434783d45b 100644
--- a/configs/omap3_evm_defconfig
+++ b/configs/omap3_evm_defconfig
@@ -74,7 +74,6 @@ CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_OMAP_ECCSCHEME_BCH8_CODE_HW_DETECTION_SW=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_BUSWIDTH_16BIT=y
diff --git a/configs/omap3_logic_defconfig b/configs/omap3_logic_defconfig
index 7d3d602c9d9..78bfbbd1a22 100644
--- a/configs/omap3_logic_defconfig
+++ b/configs/omap3_logic_defconfig
@@ -73,7 +73,6 @@ CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_OMAP_ECCSCHEME_BCH8_CODE_HW_DETECTION_SW=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_BUSWIDTH_16BIT=y
diff --git a/configs/omap3_logic_somlv_defconfig b/configs/omap3_logic_somlv_defconfig
index 0141a425e07..aefd8861db3 100644
--- a/configs/omap3_logic_somlv_defconfig
+++ b/configs/omap3_logic_somlv_defconfig
@@ -84,7 +84,6 @@ CONFIG_SYS_MAX_FLASH_SECT=256
 CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_OMAP_ECCSCHEME_BCH8_CODE_HW_DETECTION_SW=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_BUSWIDTH_16BIT=y
diff --git a/configs/omapl138_lcdk_defconfig b/configs/omapl138_lcdk_defconfig
index 47feff21bd4..63554d56016 100644
--- a/configs/omapl138_lcdk_defconfig
+++ b/configs/omapl138_lcdk_defconfig
@@ -84,7 +84,6 @@ CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_NAND_USE_FLASH_BBT=y
 CONFIG_NAND_DAVINCI=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_BUSWIDTH_16BIT=y
diff --git a/configs/phycore-am335x-r2-regor_defconfig b/configs/phycore-am335x-r2-regor_defconfig
index 4bdf8822181..85d53d06357 100644
--- a/configs/phycore-am335x-r2-regor_defconfig
+++ b/configs/phycore-am335x-r2-regor_defconfig
@@ -76,7 +76,6 @@ CONFIG_DM_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
 CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
diff --git a/configs/phycore-am335x-r2-wega_defconfig b/configs/phycore-am335x-r2-wega_defconfig
index 7644fbec273..60607548a25 100644
--- a/configs/phycore-am335x-r2-wega_defconfig
+++ b/configs/phycore-am335x-r2-wega_defconfig
@@ -76,7 +76,6 @@ CONFIG_DM_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
 CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
diff --git a/configs/pxm2_defconfig b/configs/pxm2_defconfig
index 2ea007d0de5..e1d1066815b 100644
--- a/configs/pxm2_defconfig
+++ b/configs/pxm2_defconfig
@@ -99,7 +99,6 @@ CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
 CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
diff --git a/configs/rastaban_defconfig b/configs/rastaban_defconfig
index 9f538a2f83d..21495341e26 100644
--- a/configs/rastaban_defconfig
+++ b/configs/rastaban_defconfig
@@ -100,7 +100,6 @@ CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
 CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
diff --git a/configs/rut_defconfig b/configs/rut_defconfig
index ccf25667b50..248073be1f2 100644
--- a/configs/rut_defconfig
+++ b/configs/rut_defconfig
@@ -99,7 +99,6 @@ CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
 CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
diff --git a/configs/sama5d3_xplained_nandflash_defconfig b/configs/sama5d3_xplained_nandflash_defconfig
index a1b6122f8eb..a0802f9c5fe 100644
--- a/configs/sama5d3_xplained_nandflash_defconfig
+++ b/configs/sama5d3_xplained_nandflash_defconfig
@@ -86,7 +86,6 @@ CONFIG_PMECC_CAP=4
 CONFIG_SPL_GENERATE_ATMEL_PMECC_HEADER=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
 CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
diff --git a/configs/sama5d3xek_nandflash_defconfig b/configs/sama5d3xek_nandflash_defconfig
index 6278a6c68a7..d96bb91e65d 100644
--- a/configs/sama5d3xek_nandflash_defconfig
+++ b/configs/sama5d3xek_nandflash_defconfig
@@ -90,7 +90,6 @@ CONFIG_PMECC_CAP=4
 CONFIG_SPL_GENERATE_ATMEL_PMECC_HEADER=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
 CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
diff --git a/configs/sama5d4_xplained_nandflash_defconfig b/configs/sama5d4_xplained_nandflash_defconfig
index d12f749d7f4..68101a12fc2 100644
--- a/configs/sama5d4_xplained_nandflash_defconfig
+++ b/configs/sama5d4_xplained_nandflash_defconfig
@@ -84,7 +84,6 @@ CONFIG_PMECC_CAP=8
 CONFIG_SPL_GENERATE_ATMEL_PMECC_HEADER=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x40000
 CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x1000
 CONFIG_SYS_NAND_OOBSIZE=0xe0
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
diff --git a/configs/sama5d4ek_nandflash_defconfig b/configs/sama5d4ek_nandflash_defconfig
index 27bfcdf0084..b8062db775d 100644
--- a/configs/sama5d4ek_nandflash_defconfig
+++ b/configs/sama5d4ek_nandflash_defconfig
@@ -81,7 +81,6 @@ CONFIG_PMECC_CAP=8
 CONFIG_SPL_GENERATE_ATMEL_PMECC_HEADER=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x40000
 CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x1000
 CONFIG_SYS_NAND_OOBSIZE=0xe0
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
diff --git a/configs/smartweb_defconfig b/configs/smartweb_defconfig
index 10cbccb69b0..80d2c0f1cc1 100644
--- a/configs/smartweb_defconfig
+++ b/configs/smartweb_defconfig
@@ -84,7 +84,6 @@ CONFIG_MTD=y
 # CONFIG_SYS_NAND_USE_FLASH_BBT is not set
 CONFIG_NAND_ATMEL=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
diff --git a/configs/taurus_defconfig b/configs/taurus_defconfig
index cc5755178b7..9be30c8d8a4 100644
--- a/configs/taurus_defconfig
+++ b/configs/taurus_defconfig
@@ -94,7 +94,6 @@ CONFIG_MTD=y
 # CONFIG_SYS_NAND_USE_FLASH_BBT is not set
 CONFIG_NAND_ATMEL=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
diff --git a/configs/thuban_defconfig b/configs/thuban_defconfig
index 116700e0df0..1134624f9d2 100644
--- a/configs/thuban_defconfig
+++ b/configs/thuban_defconfig
@@ -100,7 +100,6 @@ CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
 CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
 CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 72547f00fbe..ee484dc0f51 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -660,14 +660,6 @@ config SYS_NAND_ONFI_DETECTION
 	  And fetching device parameters flashed on device, by parsing
 	  ONFI parameter page.
 
-config SYS_NAND_PAGE_COUNT
-	hex "NAND chip page count"
-	depends on SPL_NAND_SUPPORT && (NAND_ATMEL || NAND_MXC || \
-		SPL_NAND_AM33XX_BCH || SPL_NAND_LOAD || SPL_NAND_SIMPLE || \
-		NAND_OMAP_GPMC)
-	help
-	  Number of pages in the NAND chip.
-
 config SYS_NAND_PAGE_SIZE
 	hex "NAND chip page size"
 	depends on ARCH_SUNXI || NAND_OMAP_GPMC || NAND_LPC32XX_SLC || \
diff --git a/drivers/mtd/nand/raw/am335x_spl_bch.c b/drivers/mtd/nand/raw/am335x_spl_bch.c
index 6ab3f1f42c5..3843ffc9a24 100644
--- a/drivers/mtd/nand/raw/am335x_spl_bch.c
+++ b/drivers/mtd/nand/raw/am335x_spl_bch.c
@@ -11,6 +11,7 @@
 
 #include <common.h>
 #include <nand.h>
+#include <system-constants.h>
 #include <asm/io.h>
 #include <linux/delay.h>
 #include <linux/mtd/nand_ecc.h>
@@ -32,7 +33,7 @@ static int nand_command(int block, int page, uint32_t offs,
 	u8 cmd)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	int page_addr = page + block * CONFIG_SYS_NAND_PAGE_COUNT;
+	int page_addr = page + block * SYS_NAND_PAGE_COUNT;
 	void (*hwctrl)(struct mtd_info *mtd, int cmd,
 			unsigned int ctrl) = this->cmd_ctrl;
 
diff --git a/drivers/mtd/nand/raw/atmel_nand.c b/drivers/mtd/nand/raw/atmel_nand.c
index 6b17e744a69..cfc6578ae83 100644
--- a/drivers/mtd/nand/raw/atmel_nand.c
+++ b/drivers/mtd/nand/raw/atmel_nand.c
@@ -12,6 +12,7 @@
 
 #include <common.h>
 #include <log.h>
+#include <system-constants.h>
 #include <asm/gpio.h>
 #include <asm/arch/gpio.h>
 #include <dm/device_compat.h>
@@ -1258,7 +1259,7 @@ static struct nand_chip nand_chip;
 static int nand_command(int block, int page, uint32_t offs, u8 cmd)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	int page_addr = page + block * CONFIG_SYS_NAND_PAGE_COUNT;
+	int page_addr = page + block * SYS_NAND_PAGE_COUNT;
 	void (*hwctrl)(struct mtd_info *mtd, int cmd,
 			unsigned int ctrl) = this->cmd_ctrl;
 
@@ -1359,7 +1360,7 @@ int spl_nand_erase_one(int block, int page)
 	if (nand_chip.select_chip)
 		nand_chip.select_chip(mtd, 0);
 
-	page_addr = page + block * CONFIG_SYS_NAND_PAGE_COUNT;
+	page_addr = page + block * SYS_NAND_PAGE_COUNT;
 	hwctrl(mtd, NAND_CMD_ERASE1, NAND_CTRL_CLE | NAND_CTRL_CHANGE);
 	/* Row address */
 	hwctrl(mtd, (page_addr & 0xff), NAND_CTRL_ALE | NAND_CTRL_CHANGE);
diff --git a/drivers/mtd/nand/raw/mxc_nand_spl.c b/drivers/mtd/nand/raw/mxc_nand_spl.c
index 309e75d01e5..059bf38f50e 100644
--- a/drivers/mtd/nand/raw/mxc_nand_spl.c
+++ b/drivers/mtd/nand/raw/mxc_nand_spl.c
@@ -13,6 +13,7 @@
 #include <common.h>
 #include <hang.h>
 #include <nand.h>
+#include <system-constants.h>
 #include <linux/mtd/rawnand.h>
 #include <asm/arch/imx-regs.h>
 #include <asm/io.h>
@@ -304,13 +305,13 @@ int nand_spl_load_image(uint32_t from, unsigned int size, void *buf)
 		 * Check if we have crossed a block boundary, and if so
 		 * check for bad block.
 		 */
-		if (!(page % CONFIG_SYS_NAND_PAGE_COUNT)) {
+		if (!(page % SYS_NAND_PAGE_COUNT)) {
 			/*
 			 * Yes, new block. See if this block is good. If not,
 			 * loop until we find a good block.
 			 */
 			while (is_badblock(page)) {
-				page = page + CONFIG_SYS_NAND_PAGE_COUNT;
+				page = page + SYS_NAND_PAGE_COUNT;
 				/* Check i we've reached the end of flash. */
 				if (page >= maxpages)
 					return -1;
diff --git a/drivers/mtd/nand/raw/nand_spl_loaders.c b/drivers/mtd/nand/raw/nand_spl_loaders.c
index 156b44d8358..8848cb27db9 100644
--- a/drivers/mtd/nand/raw/nand_spl_loaders.c
+++ b/drivers/mtd/nand/raw/nand_spl_loaders.c
@@ -12,7 +12,7 @@ int nand_spl_load_image(uint32_t offs, unsigned int size, void *dst)
 	while (block <= lastblock) {
 		if (!nand_is_bad_block(block)) {
 			/* Skip bad blocks */
-			while (page < CONFIG_SYS_NAND_PAGE_COUNT) {
+			while (page < SYS_NAND_PAGE_COUNT) {
 				nand_read_page(block, page, dst);
 				/*
 				 * When offs is not aligned to page address the
diff --git a/drivers/mtd/nand/raw/nand_spl_simple.c b/drivers/mtd/nand/raw/nand_spl_simple.c
index 2f3af9edd4c..2ebcac56900 100644
--- a/drivers/mtd/nand/raw/nand_spl_simple.c
+++ b/drivers/mtd/nand/raw/nand_spl_simple.c
@@ -6,6 +6,7 @@
 
 #include <common.h>
 #include <nand.h>
+#include <system-constants.h>
 #include <asm/io.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/rawnand.h>
@@ -27,7 +28,7 @@ static int nand_command(int block, int page, uint32_t offs,
 	u8 cmd)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	int page_addr = page + block * CONFIG_SYS_NAND_PAGE_COUNT;
+	int page_addr = page + block * SYS_NAND_PAGE_COUNT;
 
 	while (!this->dev_ready(mtd))
 		;
@@ -59,7 +60,7 @@ static int nand_command(int block, int page, uint32_t offs,
 	u8 cmd)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	int page_addr = page + block * CONFIG_SYS_NAND_PAGE_COUNT;
+	int page_addr = page + block * SYS_NAND_PAGE_COUNT;
 	void (*hwctrl)(struct mtd_info *mtd, int cmd,
 			unsigned int ctrl) = this->cmd_ctrl;
 
diff --git a/drivers/mtd/nand/raw/omap_gpmc.c b/drivers/mtd/nand/raw/omap_gpmc.c
index 1a5ed0de31a..6e99538dea1 100644
--- a/drivers/mtd/nand/raw/omap_gpmc.c
+++ b/drivers/mtd/nand/raw/omap_gpmc.c
@@ -6,6 +6,7 @@
 
 #include <common.h>
 #include <log.h>
+#include <system-constants.h>
 #include <asm/io.h>
 #include <dm/uclass.h>
 #include <linux/errno.h>
@@ -1298,7 +1299,7 @@ static int nand_is_bad_block(int block)
 
 static int nand_read_page(int block, int page, uchar *dst)
 {
-	int page_addr = block * CONFIG_SYS_NAND_PAGE_COUNT + page;
+	int page_addr = block * SYS_NAND_PAGE_COUNT + page;
 	loff_t ofs = page_addr * CONFIG_SYS_NAND_PAGE_SIZE;
 	int ret;
 	size_t len = CONFIG_SYS_NAND_PAGE_SIZE;
diff --git a/include/system-constants.h b/include/system-constants.h
index 59371568d1e..c50d54f37a4 100644
--- a/include/system-constants.h
+++ b/include/system-constants.h
@@ -41,4 +41,7 @@
 #define SPL_PAYLOAD_ARGS_ADDR	0
 #endif
 
+#define SYS_NAND_PAGE_COUNT \
+	(CONFIG_SYS_NAND_BLOCK_SIZE / CONFIG_SYS_NAND_PAGE_SIZE)
+
 #endif
-- 
2.37.1

