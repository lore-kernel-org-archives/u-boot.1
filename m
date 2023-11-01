Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF5FC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 16:31:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEB7287D37;
	Wed,  1 Nov 2023 17:28:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Dheslrdf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BC4187710; Wed,  1 Nov 2023 17:28:50 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B63287D30
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 17:28:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7788db95652so486871185a.2
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 09:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698856119; x=1699460919; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=anRzmELyUFPWR+STigDK/Qk4fDUU7S/Xw/VrOMpcmdA=;
 b=DheslrdfVFXgRNlIrJnWveOf5GyIDA/iF+4hAMTYDCroW504hSSISRZ3bUQZZuZ/kD
 WtcgmlaQ7PeZNksNbzyd4NZf01hUTeBH90vPrct+1jFzkswoW9vWGmwPJ8/PxsD2uQ+A
 lyZQUqQp/Qz7lx+VMx5U1kyrVEoO5AkNLaeqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698856119; x=1699460919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=anRzmELyUFPWR+STigDK/Qk4fDUU7S/Xw/VrOMpcmdA=;
 b=Ywd9k8IGSPPpN3OXn+fNsrdymqjzyYGYoUJkSCmRbFcNxaJGeMyQrXOWWfSn96FW99
 oSYFim+zIsBFvGIiza00FGdNyB5FRuTznzBA5MWTMvD8IYOXp4rbKFT51MMZx4tShGjA
 R75+4kcrYJ5ZnoHZGfAVMaslYOwFX4+tqg1SADxa71H/DbLGRP5E/F6k7SfKCTHGPKye
 ZIkXaGZrohSiyU87MCb8ru0V/CuC8sI1yoJznINA3ZHqENuvzxCp5JuBVX0S5OvPfKJK
 q4p/po8/1YRxicg3RnukmeNqTlRaR5fSwcd4+0FOi/NHdL0Vcfz/0NeyY6U2YhVL7tYf
 HGsg==
X-Gm-Message-State: AOJu0Yy3IIf/97rmn7lTrYvtqX7W5eckvLW2ytZtKFk+99RwtJd3pMxr
 O6tMpgz+qMJlbyNOwHCF5RCqfGUfqr3HyDp/j7ZFKw==
X-Google-Smtp-Source: AGHT+IE03/uymOz97SAQeZ82IxYGJzZrnRiVFjS1HTdpKNeuXOjyLhmsZybxIBRABIqJVQiNZWfP+Q==
X-Received: by 2002:a05:6214:252a:b0:66d:603b:9a0e with SMTP id
 gg10-20020a056214252a00b0066d603b9a0emr18109161qvb.16.1698856119084; 
 Wed, 01 Nov 2023 09:28:39 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 o3-20020a0cecc3000000b0065b21f1b687sm1610238qvq.80.2023.11.01.09.28.38
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 09:28:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 16/20] include: Drop <common.h> from include lists
Date: Wed,  1 Nov 2023 12:28:20 -0400
Message-Id: <20231101162824.3755579-16-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101162824.3755579-1-trini@konsulko.com>
References: <20231101162824.3755579-1-trini@konsulko.com>
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

At this point, we don't need to have <common.h> be included because of
properties in the header itself, it only includes other common header
files. We've also audited the code enough at this point that we can drop
<common.h> from being included in headers and rely on code to have the
correct inclusions themselves, or at least <common.h>.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/bootcount.h           | 1 -
 include/dfu.h                 | 1 -
 include/efi_loader.h          | 1 -
 include/efi_selftest.h        | 1 -
 include/fm_eth.h              | 1 -
 include/fs.h                  | 1 -
 include/fsl-mc/fsl_mc.h       | 1 -
 include/fsl_errata.h          | 1 -
 include/fsl_ifc.h             | 1 -
 include/fsl_sec.h             | 1 -
 include/fsl_sec_mon.h         | 1 -
 include/fsl_sfp.h             | 1 -
 include/iotrace.h             | 1 -
 include/key_matrix.h          | 1 -
 include/libata.h              | 1 -
 include/linux/mtd/spinand.h   | 1 -
 include/linux/usb/composite.h | 1 -
 include/miiphy.h              | 1 -
 include/mv88e6352.h           | 1 -
 include/net/ncsi.h            | 1 -
 include/palmas.h              | 1 -
 include/post.h                | 1 -
 include/spi.h                 | 1 -
 include/tegra-kbc.h           | 1 -
 include/twl4030.h             | 1 -
 include/twl6030.h             | 1 -
 include/ubi_uboot.h           | 1 -
 include/usbdevice.h           | 1 -
 28 files changed, 28 deletions(-)

diff --git a/include/bootcount.h b/include/bootcount.h
index bfa5d4642764..bc06e17c9fb7 100644
--- a/include/bootcount.h
+++ b/include/bootcount.h
@@ -6,7 +6,6 @@
 #ifndef _BOOTCOUNT_H__
 #define _BOOTCOUNT_H__
 
-#include <common.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/byteorder.h>
diff --git a/include/dfu.h b/include/dfu.h
index 07922224ef19..68b5ca46ce54 100644
--- a/include/dfu.h
+++ b/include/dfu.h
@@ -10,7 +10,6 @@
 #ifndef __DFU_ENTITY_H_
 #define __DFU_ENTITY_H_
 
-#include <common.h>
 #include <linux/list.h>
 #include <mmc.h>
 #include <spi_flash.h>
diff --git a/include/efi_loader.h b/include/efi_loader.h
index e24410505f40..247be060e1c0 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -8,7 +8,6 @@
 #ifndef _EFI_LOADER_H
 #define _EFI_LOADER_H 1
 
-#include <common.h>
 #include <blk.h>
 #include <event.h>
 #include <log.h>
diff --git a/include/efi_selftest.h b/include/efi_selftest.h
index 7c69c3f37610..5bcebb368287 100644
--- a/include/efi_selftest.h
+++ b/include/efi_selftest.h
@@ -8,7 +8,6 @@
 #ifndef _EFI_SELFTEST_H
 #define _EFI_SELFTEST_H
 
-#include <common.h>
 #include <efi.h>
 #include <efi_api.h>
 #include <efi_loader.h>
diff --git a/include/fm_eth.h b/include/fm_eth.h
index 8b133e703b40..f30110817c78 100644
--- a/include/fm_eth.h
+++ b/include/fm_eth.h
@@ -7,7 +7,6 @@
 #ifndef __FM_ETH_H__
 #define __FM_ETH_H__
 
-#include <common.h>
 #include <phy.h>
 #include <asm/types.h>
 
diff --git a/include/fs.h b/include/fs.h
index e341a0ed01bf..ef540e7c23de 100644
--- a/include/fs.h
+++ b/include/fs.h
@@ -5,7 +5,6 @@
 #ifndef _FS_H
 #define _FS_H
 
-#include <common.h>
 #include <rtc.h>
 
 struct cmd_tbl;
diff --git a/include/fsl-mc/fsl_mc.h b/include/fsl-mc/fsl_mc.h
index de2bba93ecf4..71907bc73c5f 100644
--- a/include/fsl-mc/fsl_mc.h
+++ b/include/fsl-mc/fsl_mc.h
@@ -7,7 +7,6 @@
 #ifndef __FSL_MC_H__
 #define __FSL_MC_H__
 
-#include <common.h>
 #include <linux/bitops.h>
 
 struct bd_info;
diff --git a/include/fsl_errata.h b/include/fsl_errata.h
index 88f4268658a1..44547645df87 100644
--- a/include/fsl_errata.h
+++ b/include/fsl_errata.h
@@ -6,7 +6,6 @@
 #ifndef _FSL_ERRATA_H
 #define _FSL_ERRATA_H
 
-#include <common.h>
 #if defined(CONFIG_PPC)
 #include <asm/processor.h>
 #elif defined(CONFIG_ARCH_LS1021A)
diff --git a/include/fsl_ifc.h b/include/fsl_ifc.h
index de1e70a6d0ba..f9a0a7017d4a 100644
--- a/include/fsl_ifc.h
+++ b/include/fsl_ifc.h
@@ -9,7 +9,6 @@
 
 #ifdef CONFIG_FSL_IFC
 #include <config.h>
-#include <common.h>
 #include <part.h>
 #ifdef CONFIG_ARM
 #include <asm/arch/soc.h>
diff --git a/include/fsl_sec.h b/include/fsl_sec.h
index 9dad1d1ec473..8c5e59c5b1ca 100644
--- a/include/fsl_sec.h
+++ b/include/fsl_sec.h
@@ -9,7 +9,6 @@
 #ifndef __FSL_SEC_H
 #define __FSL_SEC_H
 
-#include <common.h>
 #include <asm/io.h>
 
 #ifdef CONFIG_SYS_FSL_SEC_LE
diff --git a/include/fsl_sec_mon.h b/include/fsl_sec_mon.h
index 3092a0ea62a0..248d5b6d4211 100644
--- a/include/fsl_sec_mon.h
+++ b/include/fsl_sec_mon.h
@@ -8,7 +8,6 @@
 #ifndef __FSL_SEC_MON_H
 #define __FSL_SEC_MON_H
 
-#include <common.h>
 #include <asm/io.h>
 
 #ifdef CONFIG_SYS_FSL_SEC_MON_LE
diff --git a/include/fsl_sfp.h b/include/fsl_sfp.h
index e7674c1bff2a..0dec69a7235d 100644
--- a/include/fsl_sfp.h
+++ b/include/fsl_sfp.h
@@ -6,7 +6,6 @@
 #ifndef _FSL_SFP_SNVS_
 #define _FSL_SFP_SNVS_
 
-#include <common.h>
 #include <config.h>
 #include <asm/io.h>
 
diff --git a/include/iotrace.h b/include/iotrace.h
index 7ff2e8332b0b..d5610426cc84 100644
--- a/include/iotrace.h
+++ b/include/iotrace.h
@@ -6,7 +6,6 @@
 #ifndef __IOTRACE_H
 #define __IOTRACE_H
 
-//#include <common.h>
 #include <linux/types.h>
 
 /* Support up to the machine word length for now */
diff --git a/include/key_matrix.h b/include/key_matrix.h
index e7420b9d7956..17f5d12cdd9f 100644
--- a/include/key_matrix.h
+++ b/include/key_matrix.h
@@ -8,7 +8,6 @@
 #ifndef _KEY_MATRIX_H
 #define _KEY_MATRIX_H
 
-#include <common.h>
 
 /* Information about a matrix keyboard */
 struct key_matrix {
diff --git a/include/libata.h b/include/libata.h
index b03b29960df5..a55e9315a730 100644
--- a/include/libata.h
+++ b/include/libata.h
@@ -10,7 +10,6 @@
 #ifndef __LIBATA_H__
 #define __LIBATA_H__
 
-#include <common.h>
 
 enum {
 	/* various global constants */
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index e8d6feb9705e..6d68514e07af 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -17,7 +17,6 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 #else
-#include <common.h>
 #include <spi.h>
 #include <spi-mem.h>
 #include <linux/mtd/nand.h>
diff --git a/include/linux/usb/composite.h b/include/linux/usb/composite.h
index 935e5c0cbb1c..bb1eb93bd20e 100644
--- a/include/linux/usb/composite.h
+++ b/include/linux/usb/composite.h
@@ -21,7 +21,6 @@
  * the composite model the host can use both functions at the same time.
  */
 
-#include <common.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/bitmap.h>
diff --git a/include/miiphy.h b/include/miiphy.h
index c66a1845b585..5abffd8fb6ba 100644
--- a/include/miiphy.h
+++ b/include/miiphy.h
@@ -14,7 +14,6 @@
 #ifndef _miiphy_h_
 #define _miiphy_h_
 
-#include <common.h>
 #include <linux/mii.h>
 #include <linux/list.h>
 #include <net.h>
diff --git a/include/mv88e6352.h b/include/mv88e6352.h
index 2e810c8183ed..152a0774fc0f 100644
--- a/include/mv88e6352.h
+++ b/include/mv88e6352.h
@@ -7,7 +7,6 @@
 #ifndef __MV886352_H
 #define __MV886352_H
 
-#include <common.h>
 
 /* PHY registers */
 #define PHY(itf)	(itf)
diff --git a/include/net/ncsi.h b/include/net/ncsi.h
index 2800c842b72e..7aec457562d0 100644
--- a/include/net/ncsi.h
+++ b/include/net/ncsi.h
@@ -5,7 +5,6 @@
  * Copyright (C) 2019, IBM Corporation.
  */
 
-#include <common.h>
 #include <phy.h>
 
 bool ncsi_active(void);
diff --git a/include/palmas.h b/include/palmas.h
index e259a4d04ba4..c13b67a84d9e 100644
--- a/include/palmas.h
+++ b/include/palmas.h
@@ -6,7 +6,6 @@
 #ifndef PALMAS_H
 #define PALMAS_H
 
-#include <common.h>
 #include <i2c.h>
 
 /* I2C chip addresses, TW6035/37 */
diff --git a/include/post.h b/include/post.h
index 6e88d5507224..da851e37fa2c 100644
--- a/include/post.h
+++ b/include/post.h
@@ -11,7 +11,6 @@
 #define _POST_H
 
 #ifndef	__ASSEMBLY__
-#include <common.h>
 #include <asm/io.h>
 
 #if defined(CONFIG_POST)
diff --git a/include/spi.h b/include/spi.h
index 1bc18e65525e..7e38cc2a2ad0 100644
--- a/include/spi.h
+++ b/include/spi.h
@@ -9,7 +9,6 @@
 #ifndef _SPI_H_
 #define _SPI_H_
 
-#include <common.h>
 #include <linux/bitops.h>
 
 /* SPI mode flags */
diff --git a/include/tegra-kbc.h b/include/tegra-kbc.h
index f331c79c9d54..1208b75ee784 100644
--- a/include/tegra-kbc.h
+++ b/include/tegra-kbc.h
@@ -7,7 +7,6 @@
 #ifndef __include_tegra_kbc_h__
 #define __include_tegra_kbc_h__
 
-#include <common.h>
 
 #define KEY_IS_MODIFIER(key) ((key) >= KEY_FIRST_MODIFIER)
 
diff --git a/include/twl4030.h b/include/twl4030.h
index 0a6d85a7c1c9..ee80bb1f6b9b 100644
--- a/include/twl4030.h
+++ b/include/twl4030.h
@@ -11,7 +11,6 @@
 #ifndef TWL4030_H
 #define TWL4030_H
 
-#include <common.h>
 #include <i2c.h>
 
 /* I2C chip addresses */
diff --git a/include/twl6030.h b/include/twl6030.h
index 05d476f80485..e3a1058091ae 100644
--- a/include/twl6030.h
+++ b/include/twl6030.h
@@ -7,7 +7,6 @@
 #ifndef TWL6030_H
 #define TWL6030_H
 
-#include <common.h>
 #include <i2c.h>
 
 /* I2C chip addresses */
diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
index 6da348eb6285..d7a8851094bc 100644
--- a/include/ubi_uboot.h
+++ b/include/ubi_uboot.h
@@ -14,7 +14,6 @@
 #ifndef __UBOOT_UBI_H
 #define __UBOOT_UBI_H
 
-#include <common.h>
 #include <compiler.h>
 #include <linux/compat.h>
 #include <malloc.h>
diff --git a/include/usbdevice.h b/include/usbdevice.h
index 80c5af0cbcd2..e59f5587eea5 100644
--- a/include/usbdevice.h
+++ b/include/usbdevice.h
@@ -17,7 +17,6 @@
 #ifndef __USBDCORE_H__
 #define __USBDCORE_H__
 
-#include <common.h>
 #include "usbdescriptors.h"
 
 
-- 
2.34.1

