Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EB2C7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 21:00:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B50508210D;
	Mon, 23 Jun 2025 23:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J8jUyxno";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F8CF82CBC; Mon, 23 Jun 2025 23:00:24 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9A7D81E13
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 23:00:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-747e41d5469so4954677b3a.3
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 14:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750712420; x=1751317220; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gG0bMLUk3R31ZE/1bt3ctr7tjbSRr8Cys9MX21shvSc=;
 b=J8jUyxnoLOInvqAsT8m61In/jttEClkxA/ZLWktdPzqe4GvnPQs9nmF5Y741RgJsG5
 D0MSS6fbkSl9agOGwh6kDMnqmNqRrQ0f8mOR32oxNt1InCLXNzDO3ku0ORWv8W+EvURy
 eu+JBVk7lmfNE9iN+bcB1t/36gpi+Df8kEmfkgNdlpxSw7psHtBL+M9XDs7wl5qHRWrN
 yZlViNQ9pTZrrhjcviESddUSgSGpmt3dMh0D4rza6+8mTs5LUhv6DwkyrW5wK0sKWIxO
 Ml/CdIXxJ5boly3nz05fCbzW6GU5D+yBG6GMzT958kMN4VeX/G+jmsB28PT4uPo4Etc+
 v5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750712420; x=1751317220;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gG0bMLUk3R31ZE/1bt3ctr7tjbSRr8Cys9MX21shvSc=;
 b=T91kw8UAxeP8BTHS/7Pnjjd0MArnJ8vTGMfLDvDaNtpluyXi2jZNYgw56bJKX92aOH
 g994pzAK2mOdEvGFh0v0WL/C5Ih3dkZkAW3uMaqMxXBBPOOgyarc3rDnQ5dnfBPY3Fpf
 NVzG26XjxGTy+oVNvYezD2wrGug4UBecYXo6GENlACH+Nc26YJyYZ093LEaE+fFsO4it
 qcUBkJNj5R9SzdFi6/Aj5Hhj63CuAN7tm3KAmczVLHTEjcyt7Xv9QPLEJjHML5gJpos+
 oIsBrpQYVEc0DXp6exOGaVnpoKhnm5qoe3SHrfOYs/DOCrEjfOnGYoMRCLs2hj9mQRm5
 Xnew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZYuP05MaXE+ItrZtBmzZHoW1EyQRQ42XxWc0LKm8TZq5aOstXU1axfHEYFJhKufhL9oXxeAQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyLhfttzCzndqvoWL3X9rQJE1lhyF68gkhso9n4+13LKLvDUUUL
 oo8inS73PDqDu21vX5enw60fKdMoh9QnV5uBlQSdWj/nq4m0HvCbas1Q
X-Gm-Gg: ASbGncsQk6a52JnwqoXt9laGVadGVBDjnlSo93A2Gfam9MUxio3bkzQBqmFg+v2G0mM
 6hanH1BbrvuPQ9+7Nb9vC010m9PnyEduZaj+me+PnYsGZ+ofi6V/kgrf3eyEEqxFrDTvTEosLPb
 sPd36f1If6vsEdebB4h/IFXmrQCE/izxhR+5TRgigO9Loe/GTaFBl7ISDAnsJlHdVtjvlBMNkyD
 c0+1o8Ix3ObxwFc6RsmqDdsb1uC5JMPzOncTuKVt95OhJwjgmN7arZitRQzW2YjvlasGQpUD6Sw
 yNtY4Hs4GS7qpoYZFHUjVWMQKLHIn9lC8LE6IbcxZtixjG0C+In9pseQ3s7l0UU1Bw4MsmT9pAh
 2Ce60qvRRtVptL7V6RowfhAgN9fpZRQUqrdMCswhic3VGl0cKyQ==
X-Google-Smtp-Source: AGHT+IGt36amP73OrxPagVZrwRbFbwYH9vGxYF3BORPzKc4fGg3MMucygKE4YzM37O5A25ymlR8PKg==
X-Received: by 2002:a05:6a00:2e99:b0:742:b3a6:db16 with SMTP id
 d2e1a72fcca58-7490d67f737mr19367798b3a.20.1750712420292; 
 Mon, 23 Jun 2025 14:00:20 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749c8852f0fsm43678b3a.117.2025.06.23.14.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 14:00:19 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: Stefan Roese <sr@denx.de>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH] arm: kirkwood: Enable bootstd and other modernization for
 ib62x0 board
Date: Mon, 23 Jun 2025 13:59:43 -0700
Message-Id: <20250623205943.11889-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.39.5
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

Enable bootstd.
Update defconfigs to the latest u-boot requirements.
Enable SYS_THUMB_BUILD and LTO and to reduce binary size.
Enable NET_RANDOM_ETHADDR.
Disable JFFS2 support.

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 configs/ib62x0_defconfig | 16 ++++------------
 include/configs/ib62x0.h | 28 ++++++++++++++++++++++------
 2 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/configs/ib62x0_defconfig b/configs/ib62x0_defconfig
index 1beb5837bb4..0c14ac06e92 100644
--- a/configs/ib62x0_defconfig
+++ b/configs/ib62x0_defconfig
@@ -2,48 +2,41 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_SYS_DCACHE_OFF=y
 CONFIG_ARCH_CPU_INIT=y
+CONFIG_SYS_THUMB_BUILD=y
 CONFIG_ARCH_KIRKWOOD=y
 CONFIG_SYS_KWD_CONFIG="board/raidsonic/ib62x0/kwbimage.cfg"
 CONFIG_TEXT_BASE=0x600000
 CONFIG_NR_DRAM_BANKS=2
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc8012000
 CONFIG_TARGET_IB62X0=y
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xE0000
 CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-ib62x0"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_IDENT_STRING=" RaidSonic ICY BOX IB-NAS62x0"
+CONFIG_LTO=y
+CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTDELAY=3
-CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="setenv bootargs ${console} ${mtdparts} ${bootargs_root}; ubi part root; ubifsmount ubi:rootfs; ubifsload 0x800000 ${kernel}; ubifsload 0x700000 ${fdt}; ubifsumount; fdt addr 0x700000; fdt resize; fdt chosen; bootz 0x800000 - 0x700000"
 CONFIG_USE_PREBOOT=y
 CONFIG_SYS_PBSIZE=1051
 # CONFIG_DISPLAY_BOARDINFO is not set
-CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="ib62x0 => "
 CONFIG_SYS_MAXARGS=32
-CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_IDE=y
 CONFIG_CMD_NAND=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_JFFS2=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=orion_nand"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=orion_nand:0xe0000@0x0(uboot),0x20000@0xe0000(uboot_env),-@0x100000(root)"
 CONFIG_CMD_UBI=y
-CONFIG_ISO_PARTITION=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NETCONSOLE=y
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SYS_ATA_STRIDE=4
 CONFIG_SYS_ATA_DATA_OFFSET=0x100
 CONFIG_SYS_ATA_REG_OFFSET=0x100
@@ -58,6 +51,5 @@ CONFIG_MVGBE=y
 CONFIG_MII=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_STORAGE=y
 CONFIG_LZMA=y
 CONFIG_BZIP2=y
diff --git a/include/configs/ib62x0.h b/include/configs/ib62x0.h
index e1b62f78b21..01ab6edb05f 100644
--- a/include/configs/ib62x0.h
+++ b/include/configs/ib62x0.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
+ * Copyright (C) 2025 Tony Dinh <mibodhi@gmail.com>
  * Copyright (C) 2011-2012
  * Gerald Kerma <dreagle@doukki.net>
  * Luka Perkov <luka@openwrt.org>
@@ -11,19 +12,34 @@
 #include "mv-common.h"
 
 /*
- * Environment variables configuration
- */
-
-/*
- * Default environment variables
+ * mv-common.h should be defined after CMD configs since it used them
+ * to enable certain macros
  */
+#include "mv-common.h"
 
-#define CFG_EXTRA_ENV_SETTINGS \
+#define EXTRA_ENV_SETTINGS_LEGACY \
 	"console=console=ttyS0,115200\0"				\
 	"kernel=/boot/zImage\0"						\
 	"fdt=/boot/ib62x0.dtb\0"					\
 	"bootargs_root=ubi.mtd=2 root=ubi0:rootfs rootfstype=ubifs rw\0"
 
+#define KERNEL_ADDR_R	__stringify(0x800000)
+#define FDT_ADDR_R	__stringify(0x2c00000)
+#define RAMDISK_ADDR_R	__stringify(0x01100000)
+#define SCRIPT_ADDR_R	__stringify(0x200000)
+
+#define LOAD_ADDRESS_ENV_SETTINGS \
+	"kernel_addr_r=" KERNEL_ADDR_R "\0" \
+	"fdt_addr_r=" FDT_ADDR_R "\0" \
+	"ramdisk_addr_r=" RAMDISK_ADDR_R "\0" \
+	"scriptaddr=" SCRIPT_ADDR_R "\0"
+
+#define CFG_EXTRA_ENV_SETTINGS \
+	EXTRA_ENV_SETTINGS_LEGACY \
+	LOAD_ADDRESS_ENV_SETTINGS \
+	"fdtfile=" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
+	"mtdparts=" CONFIG_MTDPARTS_DEFAULT "\0"
+
 /*
  * SATA driver configuration
  */
-- 
2.39.5

base-commit: 926d8b9eea89b9a90450f7723d66fba4184f586e
branch: master
