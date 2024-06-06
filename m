Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9C4C27C52
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 23:45:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF2368826B;
	Fri,  7 Jun 2024 01:45:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bvdRMTlm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A15088444; Fri,  7 Jun 2024 01:45:01 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F66B880F4
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 01:44:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3d1bc6e5f01so844786b6e.0
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 16:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717717497; x=1718322297; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s4TAKFSoDTAHtUH3hIWH5R3GBtZkB1wzbBk72rB0aDk=;
 b=bvdRMTlmKPsVbL4sHRXHg9On4a/jvHMwUfsR8tpADZYF/OaBUxyQjr3+VNX5krvu2G
 pDk7YffPg7PGF/aXNEHL73ho5rKaOPaAFaoZ7o9BSS+CGASKIoZRFq8X7mDvdGIrJtXT
 DftlAbl8SLumpfMeo2Ur3u8bFcpbgpeMxGwyIxPjSF4env/HSqb8bbse6yTXOm+5Vo4k
 3cc0K7nEL0VrnBsgjlnfldoPV9FDuvsp8gWhxTvxrE0xFQAH3Uz27/Zic8VMRgGrtHmI
 qjDbApMrSG8N2zrxGAPIoxevDWYhso9beau94OuzhqfaFwMPVj7w5O1EHgHB4764HTjB
 2K8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717717497; x=1718322297;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s4TAKFSoDTAHtUH3hIWH5R3GBtZkB1wzbBk72rB0aDk=;
 b=Q+RTO2o62XQ/EVcOOkud1JUI41yOOhHfhWPyh05eX1VVBRCkfbGWm/Kruq3rU02Kug
 iggLo7IfaUdvukCkjBvEaGOrrQfynXDYddE2qyrL1v/5/k3jT79S84Jk1p6Rzlii1Ptc
 mSk5WzBN0flCMcnIefGWGchlPv+q+ZYaE0VAUu1Ip7k05QD3RSayp0kprYIbPr/TP8AP
 qmaQ0RGktiv4P6HSOkJYqHiM5zD/9jiVQPUz5ZdQk2jSnSpJeoEc8QGpkQuEqwQDJ4Wm
 bNY9YxXU3MHduzvDGEVe2d/PO1yjlKZmNjTusGzaC6MtIIb+DKQDrUH2oEDhIg5lwzle
 v/wg==
X-Gm-Message-State: AOJu0YxKZUlJzUImRlI1v2oRnfCfNV2GqtE3jdq9vbY5S7UfpIE/ZNok
 wlfNnYVYk1sYZwEQQaolPmZ6mDM16NSQI1qPiBpinsybMLAhU0xh2dZQfw==
X-Google-Smtp-Source: AGHT+IEI9kpWicQ26rEWf45vhvLXmSW78CFCeYXoYa3tR5uS3DsNV0CzAszIoZvTpOEB2Sv9EN9bmg==
X-Received: by 2002:a05:6808:7c7:b0:3d2:31e:8a48 with SMTP id
 5614622812f47-3d210f23185mr903298b6e.40.1717717496785; 
 Thu, 06 Jun 2024 16:44:56 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d20b66cb63sm447866b6e.6.2024.06.06.16.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 16:44:56 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>,
	Stefan Roese <sr@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 Phil Sutter <phil@nwl.cc>
Subject: [PATCH] arm: mvebu: Enable bootstd and other modernization for
 Synology DS414 (Armada XP) board
Date: Thu,  6 Jun 2024 16:44:36 -0700
Message-Id: <20240606234437.24549-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.39.2
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

- Switch to standard boot (in include/configs/ds414.h and
configs/ds414_defconfig)
- Implement board_late_init() to ensure successful enumeration
of USB3 devices
- Remove unnecessary misc_init_r(), since NET_RANDOM_ETHADDR is now
configured in
- Remove unnecessary checkboard()
- Updated IDENT_STRING to indicate this u-boot supports both Synology
DS414 and DS214+ boards
- Add SYS_THUMB_BUILD to reduce binary size
- Add NET_RANDOM_ETHADDR
- Add CONFIG_LBA48 and CONFIG_SYS_64BIT_LBA to support >2TB HDD/SDD

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 board/Synology/ds414/ds414.c | 15 +++--------
 configs/ds414_defconfig      | 20 ++++++--------
 include/configs/ds414.h      | 51 ++++++++++++++++++++++--------------
 3 files changed, 42 insertions(+), 44 deletions(-)

diff --git a/board/Synology/ds414/ds414.c b/board/Synology/ds414/ds414.c
index abe6f9eb5e..f0b55fa095 100644
--- a/board/Synology/ds414/ds414.c
+++ b/board/Synology/ds414/ds414.c
@@ -181,18 +181,9 @@ int board_init(void)
 	return 0;
 }
 
-int misc_init_r(void)
+int board_late_init(void)
 {
-	if (!env_get("ethaddr")) {
-		puts("Incomplete environment, populating from SPI flash\n");
-		do_syno_populate(0, NULL);
-	}
-	return 0;
-}
-
-int checkboard(void)
-{
-	puts("Board: DS414\n");
-
+	/* Do late init to ensure successful enumeration of XHCI devices */
+	pci_init();
 	return 0;
 }
diff --git a/configs/ds414_defconfig b/configs/ds414_defconfig
index ecf9501ba5..501ed51129 100644
--- a/configs/ds414_defconfig
+++ b/configs/ds414_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_CPU_INIT=y
+CONFIG_SYS_THUMB_BUILD=y
 CONFIG_ARCH_MVEBU=y
 CONFIG_SUPPORT_PASSING_ATAGS=y
 CONFIG_CMDLINE_TAG=y
@@ -25,44 +26,40 @@ CONFIG_SPL_BSS_MAX_SIZE=0x4000
 CONFIG_SPL=y
 CONFIG_DEBUG_UART_BASE=0xf1012000
 CONFIG_DEBUG_UART_CLOCK=250000000
+CONFIG_IDENT_STRING="\nSynology DS214+/DS414 2/4-Bay Diskstation"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
+CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTDELAY=3
 CONFIG_USE_BOOTARGS=y
-CONFIG_BOOTARGS="console=ttyS0,115200 ip=off initrd=0x8000040,8M root=/dev/md0 rw syno_hw_version=DS414r1 ihd_num=4 netif_num=2 flash_size=8 SataLedSpecial=1 HddHotplug=1"
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="sf probe; sf read ${loadaddr} 0xd0000 0x2d0000; sf read ${ramdisk_addr_r} 0x3a0000 0x430000; bootm ${loadaddr} ${ramdisk_addr_r}"
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_MISC_INIT_R=y
+CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x1bfd0
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_I2C=y
+CONFIG_SYS_PROMPT="DS414> "
 CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_I2C=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
-# CONFIG_CMD_SETEXPR is not set
-CONFIG_CMD_DHCP=y
 CONFIG_CMD_TFTPPUT=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
 CONFIG_CMD_TIME=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_FAT=y
 CONFIG_CMD_JFFS2=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_UBI=y
-CONFIG_ISO_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_SPI_MAX_HZ=50000000
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_LBA48=y
+CONFIG_SYS_64BIT_LBA=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MVTWSI=y
 # CONFIG_MMC is not set
@@ -83,4 +80,3 @@ CONFIG_USB_XHCI_HCD=y
 # CONFIG_USB_XHCI_MVEBU is not set
 CONFIG_USB_XHCI_PCI=y
 CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_STORAGE=y
diff --git a/include/configs/ds414.h b/include/configs/ds414.h
index 9446acba79..bbefe632e0 100644
--- a/include/configs/ds414.h
+++ b/include/configs/ds414.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
+ * Copyright (C) 2024 Tony Dinh <mibodhi@gmail.com>
  * Copyright (C) 2014 Stefan Roese <sr@denx.de>
  */
 
@@ -16,14 +17,9 @@
  * U-Boot into it.
  */
 
-/* I2C */
 #define CFG_I2C_MVTWSI_BASE0		MVEBU_TWSI_BASE
 
-/*
- * mv-common.h should be defined after CMD configs since it used them
- * to enable certain macros
- */
-#include "mv-common.h"
+#define PHY_ANEG_TIMEOUT	16000	/* PHY needs a longer aneg time */
 
 /*
  * Memory layout while starting into the bin_hdr via the
@@ -38,23 +34,38 @@
  * L2 cache thus cannot be used.
  */
 
-/* SPL */
-/* Defines for SPL */
+/* Keep device tree and initrd in lower memory so the kernel can access them */
+#define RELOCATION_LIMITS_ENV_SETTINGS  \
+	"fdt_high=0x10000000\0"         \
+	"initrd_high=0x10000000\0"
+
+/*
+ * mv-common.h should be defined after CMD configs since it used them
+ * to enable certain macros
+ */
+#include "mv-common.h"
+
+#ifndef CONFIG_SPL_BUILD
 
-/* Default Environment */
+#define KERNEL_ADDR_R	__stringify(0x1000000)
+#define FDT_ADDR_R	__stringify(0x2000000)
+#define RAMDISK_ADDR_R	__stringify(0x2200000)
+#define SCRIPT_ADDR_R	__stringify(0x1800000)
+#define PXEFILE_ADDR_R	__stringify(0x1900000)
 
-#define CFG_EXTRA_ENV_SETTINGS				\
-	"initrd_high=0xffffffff\0"				\
-	"ramdisk_addr_r=0x8000000\0"				\
-	"usb0Mode=host\0usb1Mode=host\0usb2Mode=device\0"	\
-	"ethmtu=1500\0eth1mtu=1500\0"				\
-	"update_uboot=sf probe; dhcp; "				\
-		"mw.b ${loadaddr} 0x0 0xd0000; "		\
-		"tftpboot ${loadaddr} u-boot-with-spl.kwb; "	\
-		"sf update ${loadaddr} 0x0 0xd0000\0"
+#define LOAD_ADDRESS_ENV_SETTINGS \
+	"kernel_addr_r=" KERNEL_ADDR_R "\0" \
+	"fdt_addr_r=" FDT_ADDR_R "\0" \
+	"ramdisk_addr_r=" RAMDISK_ADDR_R "\0" \
+	"scriptaddr=" SCRIPT_ADDR_R "\0" \
+	"pxefile_addr_r=" PXEFILE_ADDR_R "\0"
 
+#define CFG_EXTRA_ENV_SETTINGS \
+	RELOCATION_LIMITS_ENV_SETTINGS \
+	LOAD_ADDRESS_ENV_SETTINGS \
+	"fdtfile=" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
+	"console=ttyS0,115200\0"
 
-/* increase autoneg timeout, my NIC sucks */
-#define PHY_ANEG_TIMEOUT	16000
+#endif /* CONFIG_SPL_BUILD */
 
 #endif /* _CONFIG_SYNOLOGY_DS414_H */
-- 
2.39.2

