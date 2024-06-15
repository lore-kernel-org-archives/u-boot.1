Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266B0C27C4F
	for <u-boot@archiver.kernel.org>; Sat, 15 Jun 2024 22:07:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB7BB87E0D;
	Sun, 16 Jun 2024 00:07:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BFSWgpQo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B7C287DF1; Sun, 16 Jun 2024 00:07:24 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 286CA87E0D
 for <u-boot@lists.denx.de>; Sun, 16 Jun 2024 00:07:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6312dc52078so34890127b3.1
 for <u-boot@lists.denx.de>; Sat, 15 Jun 2024 15:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718489241; x=1719094041; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8oGCx6BEeFpFdsBAEbv4IvAvB9Yy1e8KX1TlEoaJszk=;
 b=BFSWgpQoNgxp5B5yW8fi6oK8YvBqxuR0aH8jW3VvWaHuKHyqcly/AfY+JZ0By3mggB
 8ea3FlnjDsPmcSr9lum66RHhv8yt6xpuRae+uMBJu7b6+bOddcJSu1lQTRUlaZKrEs53
 mCcCvS/VQNEVEeowQG+SuefuyTg2XwnugsRI3P1tNts1KErBiOG9MoXRKvFljBCfpuYf
 +UJ+jsvXlsBXx+lDuzCYkCqukkngZaIVpZEyco5l1LAxw3kFgtwrYRx/AoRxnABrKopv
 S7unzQnluQMRCdk4ob3+TPcJZoe4noThWIXtSoHrq64Ng7cp/EzRE1jAwWjN4/vLCvlo
 j9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718489241; x=1719094041;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8oGCx6BEeFpFdsBAEbv4IvAvB9Yy1e8KX1TlEoaJszk=;
 b=cPTrsf0PdXPSuxJWGENgi+yBrjMdNmqnejHVJeyGrfRWji8xUm9tvLktVAGnt9K3Wp
 KnvQU45Oz4gUp3RK5rakrFH+ymZ/bdBiR3gbw5UbLKS0tcl+Sx+bPbhNkAwb1jBDx7V9
 qQxqXnFuqJ+UGhHnk861COjEQHlocvH0lC6s6nfewh/leO665/HDYW04kDBWapEG/V7w
 5J93lHxGmZlwz5JOWM7nFBOt97da5azjAvlw+JUcJ4nyzj8aV/JPiXSPyoN9ZMlVFAOb
 QV2/Amfm3Bu52o0CVNdlpJ5ckoF/XUYDNltzexmojjF574MRzmYRWm/jifKMes6t/+5g
 NBPg==
X-Gm-Message-State: AOJu0YwlL5xcXFmT5OkzriSTz4LtVf7EJwV4JhWNqRxEl5jNAsbNxuXZ
 /V1PiFzzeWALxgEuqyk5CdC5TNsKcAmPfa4UIkI5eTyv1TdWWWiAJM17MQ==
X-Google-Smtp-Source: AGHT+IFSjMMTH80bh76vodF9gKbAkRe/d+xJun5rmdRjX+Zc+lRZmoGVAKGK8cUZxKnE3bZGt/1FDw==
X-Received: by 2002:a0d:e5c7:0:b0:61b:bd7f:c62b with SMTP id
 00721157ae682-63222263b36mr52310997b3.2.1718489240577; 
 Sat, 15 Jun 2024 15:07:20 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-631189a9f53sm8890777b3.47.2024.06.15.15.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jun 2024 15:07:20 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>,
 Phil Sutter <phil@nwl.cc>
Cc: Tom Rini <trini@konsulko.com>,
	Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH v2] arm: mvebu: Enable bootstd and other modernization for
 Synology DS414 (Armada XP) board
Date: Sat, 15 Jun 2024 15:06:54 -0700
Message-Id: <20240615220654.10648-1-mibodhi@gmail.com>
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

Changes in v2:
- Define EXTRA_ENV_SETTINGS_LEGACY to restore default envs support for
booting legacy FW.

 board/Synology/ds414/ds414.c | 15 ++-------
 configs/ds414_defconfig      | 20 +++++------
 include/configs/ds414.h      | 65 +++++++++++++++++++++++++-----------
 3 files changed, 57 insertions(+), 43 deletions(-)

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
index 9446acba79..89e55bf0d4 100644
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
@@ -38,23 +34,54 @@
  * L2 cache thus cannot be used.
  */
 
-/* SPL */
-/* Defines for SPL */
+/* Keep device tree and initrd in lower memory so the kernel can access them */
+#define RELOCATION_LIMITS_ENV_SETTINGS  \
+	"fdt_high=0x10000000\0"         \
+	"initrd_high=0x10000000\0"
 
-/* Default Environment */
+/*
+ * mv-common.h should be defined after CMD configs since it used them
+ * to enable certain macros
+ */
+#include "mv-common.h"
 
-#define CFG_EXTRA_ENV_SETTINGS				\
-	"initrd_high=0xffffffff\0"				\
-	"ramdisk_addr_r=0x8000000\0"				\
-	"usb0Mode=host\0usb1Mode=host\0usb2Mode=device\0"	\
-	"ethmtu=1500\0eth1mtu=1500\0"				\
-	"update_uboot=sf probe; dhcp; "				\
-		"mw.b ${loadaddr} 0x0 0xd0000; "		\
-		"tftpboot ${loadaddr} u-boot-with-spl.kwb; "	\
+#ifndef CONFIG_SPL_BUILD
+
+#define KERNEL_ADDR_R	__stringify(0x1000000)
+#define FDT_ADDR_R	__stringify(0x2000000)
+#define RAMDISK_ADDR_R	__stringify(0x2200000)
+#define SCRIPT_ADDR_R	__stringify(0x1800000)
+#define PXEFILE_ADDR_R	__stringify(0x1900000)
+
+#define EXTRA_ENV_SETTINGS_LEGACY \
+	"bootargs_legacy=console=ttyS0,115200 ip=off initrd=0x8000040,8M " \
+		"root=/dev/md0 rw syno_hw_version=DS414r1 ihd_num=4 netif_num=2 " \
+		"flash_size=8 SataLedSpecial=1 HddHotplug=1\0" \
+	"bootcmd_legacy=sf probe; sf read ${loadaddr} 0xd0000 0x2d0000; " \
+		"sf read ${ramdisk_addr_r} 0x3a0000 0x430000; " \
+		"run bootargs_legacy; " \
+		"bootm ${loadaddr} ${ramdisk_addr_r}\0"	\
+	"usb0Mode=host\0usb1Mode=host\0usb2Mode=device\0" \
+	"ethmtu=1500\0eth1mtu=1500\0" \
+	"update_uboot=sf probe; dhcp; "	\
+		"mw.b ${loadaddr} 0x0 0xd0000; " \
+		"tftpboot ${loadaddr} u-boot-with-spl.kwb; " \
 		"sf update ${loadaddr} 0x0 0xd0000\0"
 
+#define LOAD_ADDRESS_ENV_SETTINGS \
+	"kernel_addr_r=" KERNEL_ADDR_R "\0" \
+	"fdt_addr_r=" FDT_ADDR_R "\0" \
+	"ramdisk_addr_r=" RAMDISK_ADDR_R "\0" \
+	"scriptaddr=" SCRIPT_ADDR_R "\0" \
+	"pxefile_addr_r=" PXEFILE_ADDR_R "\0"
+
+#define CFG_EXTRA_ENV_SETTINGS \
+	RELOCATION_LIMITS_ENV_SETTINGS \
+	LOAD_ADDRESS_ENV_SETTINGS \
+	EXTRA_ENV_SETTINGS_LEGACY \
+	"fdtfile=" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
+	"console=ttyS0,115200\0"
 
-/* increase autoneg timeout, my NIC sucks */
-#define PHY_ANEG_TIMEOUT	16000
+#endif /* CONFIG_SPL_BUILD */
 
 #endif /* _CONFIG_SYNOLOGY_DS414_H */
-- 
2.39.2

