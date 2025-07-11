Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6485C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 15:16:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EBE082AE9;
	Fri, 11 Jul 2025 17:16:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rmV+HS5i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C063282063; Fri, 11 Jul 2025 17:16:09 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DBD582AE9
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 17:16:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-611998766c0so1101180eaf.1
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 08:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752246966; x=1752851766; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=zMPEJG88qgELFh9g8VvV9J7xSKwNHbNsQRKgZ+Npggs=;
 b=rmV+HS5irdp4Uf+S6/LK9NdYCarGw92yAFPAr9m6WlQxxq6qDEfYPgBa/kgvr8u2YS
 OUigQGNVE/Uciu5CW1Xe7MppIj4BLzDRNTAfRz/9DVPe3f2QDHsVjyTnkJUINjhloY1R
 IUmeRKpYQLLhUkGSG02HX9Ww37JiPcksovrv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752246966; x=1752851766;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zMPEJG88qgELFh9g8VvV9J7xSKwNHbNsQRKgZ+Npggs=;
 b=nMVxCUGqWRXyRdubXP7bTBDyd69p+EAidzajNW876POvHPXxM592dYxmYH9DTdtMwD
 Po5iypDQQBxNRWMg9L1BYPOY6EalAjU11yWBoRNN+fgSPedHkteZEWkUMDBz7rnOuPQ2
 U/T1yoY/7wMhzCdl5UaJx/s2AA5qBH6Da0m7h8KDKiujhPWFi2HCl63jwhrwSqkNoxsv
 mJ/l/CH2y3itGCiQ74OOzvELeaOSW//B5GVnP7EmvacJR/seKw+H2krzaf9C8q7yBos+
 VnK4HrXcx2mUivmV9RqcPyXbLd5xUmqtNqaIhM/jRKpb3aQovLFOBlKp0LrMQFChhr1f
 pv0A==
X-Gm-Message-State: AOJu0YxFxQuVU2XzL35Ts7FybFbKG6dVNuULOfNhXS3UC+nqbSGkuKm0
 rnKTbzNOyu7oWW4UBXVHt/tWpxtvAwZ1TTa5LTeW0WwrWeoGAz4FlS8ahTlpjkA5ewGxPUVKGuU
 QbNxsyNw=
X-Gm-Gg: ASbGncuDcEFXKdtg1jNfByn29I537lumkSk9IhpNGjrw1qz8gQy2WWz9xPOEXQunwzp
 RYX4I2Wdy4TFwVc3m8QeWX5AAIUOHS2qHzN5QxcjR83TABexYbWzqhG7xgAvIj2VTRF5mgYtH7p
 Ksg6mj5dqaanaffwVJlWf46i/V0sk8fHA2tydzd+RCQtpEsnnf2o14Rpom1MJhM1hCuTIMSBXqI
 c5k1XqBvM2p/nt0JCIF+AhWfYqVq3LwMPAFCZQhIrW3kpsGwRCravsHERrtNXs7LqR0j1u7X4Qy
 aCaHIMDGoriGikCC0lCvZ25N+PhfetETf4IvdvLWWUbLparU5SbWp+CGFghSJFesyiOSt3tlVP5
 rj4gKlC9dVhoZx9flbvbbCgY6eakxOR/ynwS53DSN5pC0pNZ83fIrXOgtujENxzSUVeBtig==
X-Google-Smtp-Source: AGHT+IEnZX+pHFR7VjJjpTUIEMaQ9scpAtcQWOKlk5RW1LK15WCO/kemiIBPkIBBwKO9PFMBJKp/Sw==
X-Received: by 2002:a05:6820:984:b0:611:a799:cb65 with SMTP id
 006d021491bc7-613e5eee3e5mr2406505eaf.2.1752246965983; 
 Fri, 11 Jul 2025 08:16:05 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-613d9f00ceesm502575eaf.19.2025.07.11.08.16.05
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 08:16:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] mtd: Tighten some mtd driver dependencies
Date: Fri, 11 Jul 2025 09:16:04 -0600
Message-ID: <20250711151604.2224243-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

A large number of mtd drivers cannot build without access to some
platform specific header files. Express those requirements in Kconfig as
well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/mtd/Kconfig          |  1 +
 drivers/mtd/nand/raw/Kconfig | 14 +++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index f561b07e40b9..5d12dd3c7323 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -222,6 +222,7 @@ config SYS_MAX_FLASH_SECT
 
 config SAMSUNG_ONENAND
 	bool "Samsung OneNAND driver support"
+	depends on S5P
 
 config USE_SYS_MAX_FLASH_BANKS
 	bool "Enable Max number of Flash memory banks"
diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 492b577709d0..aa4bb2a0595c 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -49,6 +49,7 @@ config SYS_NAND_NO_SUBPAGE_WRITE
 
 config DM_NAND_ATMEL
 	bool "Support Atmel NAND controller with DM support"
+	depends on ARCH_AT91
 	select SYS_NAND_SELF_INIT
 	imply SYS_NAND_USE_FLASH_BBT
 	help
@@ -57,6 +58,7 @@ config DM_NAND_ATMEL
 
 config NAND_ATMEL
 	bool "Support Atmel NAND controller"
+	depends on ARCH_AT91
 	select SYS_NAND_SELF_INIT
 	imply SYS_NAND_USE_FLASH_BBT
 	help
@@ -114,6 +116,7 @@ endif
 config NAND_BRCMNAND
 	bool "Support Broadcom NAND controller"
 	depends on OF_CONTROL && DM && DM_MTD
+	depends on ARCH_BCMBCA || ARCH_BMIPS || TARGET_BCMNS || TARGET_BCMNS3
 	select SYS_NAND_SELF_INIT
 	help
 	  Enable the driver for NAND flash on platforms using a Broadcom NAND
@@ -147,6 +150,7 @@ config NAND_BRCMNAND_IPROC
 
 config NAND_DAVINCI
 	bool "Support TI Davinci NAND controller"
+	depends on ARCH_DAVINCI || ARCH_KEYSTONE
 	select SYS_NAND_SELF_INIT if TARGET_DA850EVM
 	help
 	  Enable this driver for NAND flash controllers available in TI Davinci
@@ -191,7 +195,7 @@ config SPL_NAND_LOAD
 
 config NAND_CADENCE
 	bool "Support Cadence NAND controller as a DT device"
-	depends on OF_CONTROL && DM_MTD
+	depends on OF_CONTROL && DM_MTD && ARCH_SOCFPGA
 	select SYS_NAND_SELF_INIT
 	select SPL_SYS_NAND_SELF_INIT
 	select SPL_NAND_BASE
@@ -233,6 +237,7 @@ config NAND_FSL_ELBC_DT
 
 config NAND_FSL_IFC
 	bool "Support Freescale Integrated Flash Controller NAND driver"
+	depends on ARCH_LS1021A || FSL_LSCH2 || FSL_LSCH3 || PPC
 	select TPL_SYS_NAND_SELF_INIT if TPL_NAND_SUPPORT
 	select TPL_NAND_INIT if TPL && !TPL_FRAMEWORK
 	select SPL_SYS_NAND_SELF_INIT
@@ -256,13 +261,14 @@ config NAND_KMETER1
 
 config NAND_LPC32XX_MLC
 	bool "Support LPC32XX_MLC controller"
+	depends on ARCH_LPC32XX
 	select SYS_NAND_SELF_INIT
 	help
 	  Enable the LPC32XX MLC NAND controller.
 
 config NAND_OMAP_GPMC
 	bool "Support OMAP GPMC NAND controller"
-	depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3
+	depends on ARCH_OMAP2PLUS || ARCH_K3
 	select SYS_NAND_SELF_INIT if ARCH_K3
 	select SPL_NAND_INIT if ARCH_K3
 	select SPL_SYS_NAND_SELF_INIT if ARCH_K3
@@ -430,6 +436,7 @@ endif
 
 config NAND_PXA3XX
 	bool "Support for NAND on PXA3xx and Armada 370/XP/38x"
+	depends on ARCH_MVEBU
 	select SYS_NAND_SELF_INIT
 	select DM_MTD
 	select REGMAP
@@ -489,7 +496,7 @@ endif
 config NAND_ARASAN
 	bool "Configure Arasan Nand"
 	select SYS_NAND_SELF_INIT
-	depends on DM_MTD
+	depends on DM_MTD && ARCH_ZYNQMP
 	imply CMD_NAND
 	help
 	  This enables Nand driver support for Arasan nand flash
@@ -552,6 +559,7 @@ endif
 
 config NAND_ZYNQ
 	bool "Support for Zynq Nand controller"
+	depends on ARCH_ZYNQ
 	select SPL_SYS_NAND_SELF_INIT
 	select SYS_NAND_SELF_INIT
 	select DM_MTD
-- 
2.43.0

