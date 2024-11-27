Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8A7D66BA5
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 00:57:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90D3089688;
	Wed, 27 Nov 2024 01:57:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MbFzcwmu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D1848974C; Wed, 27 Nov 2024 01:57:39 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C48488BE3
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 01:57:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ea304ce809so5250424a91.2
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 16:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732669055; x=1733273855; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fcLXDjHeo3/gkyacVIeiSamFsp16si+PLZ/IxxsPMro=;
 b=MbFzcwmuFu0hn0rRm2Jte5SPmZdBUxubpdeZgrtJWUCKNTsj/86MBdNyntwYcS24TW
 VCJEeMdJZxu1pukKQ4MIIy9QRjpQHvOL9T33dn41glVhiQiaqvJf4i5adR0C/4bHEeMn
 pbX0FjBPLZck/1mm3Mrz9FV/aAAiqiKMSFAPouEYtjcVYbYacij7s1E8mrnypmWbBaFw
 cJOHat9xjqUrm/WiBgRFkOdNR2Zde305wxZBXWOfgEJKj3JzLWpQ4ERqi8bivT+D8KbP
 TaPgk6RUQ6xZO+7OhPtzarXxFTbMga0cqC8qOFeyWoRucIod+2guv8QeZLCt3i+b89yt
 G7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732669055; x=1733273855;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fcLXDjHeo3/gkyacVIeiSamFsp16si+PLZ/IxxsPMro=;
 b=ONdBP9kQOcDSFSnYrL/M1CVJgvu95UN/fIWhGbVaFpc7vMXvC+25lCAplWPbxqW7ka
 fYxVaa/nCxmpp1peU7L0C42g8zNW1WV5KGMoQVM27E9tJ5ESgAY/UAEnsxUBTPKww3K+
 EzQaePse/8WMQBMshTwCVZf3RH28yXiKqthRq2K4pYqR+z5NeYxeFRgVX4OrRb9BKiGV
 N1KpXo/U4fS2aUV+d51pXE1os2HSUyUcxd1xwS0r5EuVnKxZZrjnWFd6C9AP4yaGorZ2
 rx+8SpqIo6l5XFcppfDQ4BPMeiz7jG9sVcceTvxUxtaU/IfU6frEh9PFanpzHHOyMbYV
 mYqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6v9L7XqBs3UOA+MA1nbl03djhR0uWfz+p0Lcw5g67WDZBnsAcOLnssaCCp2vwNSyZ6o/+mY4=@lists.denx.de
X-Gm-Message-State: AOJu0YztnO98187W/9rVaWUcEeW5vluHuntkaagaJim9xxnherGQ8GUt
 x1kX+IP/LgNiPjdTUGKZ8pn/xSDNlrMC/oEjuDn7Co2giYQuxVioxeuUyQ==
X-Gm-Gg: ASbGnctuWSMMEuGKH81UpM1HX9r8QdawjSFEirvyvyiuemZDCoXj7keUTS06mHtjesP
 w4Rw30BzNXTxY/um9kFvEjF5NN7E0m1A5Lpg1bKm5SozWjguLH5bfLXyWcMHP1hEZQkUk2aeT/D
 57O8HbykjhVO4BgNnrUG5ZdroywQNc2QPBP6PINJxEuVDH78kwVr/YOUEaTFqPpMqALQ60UiJl5
 bda/fyF1TgVRACS20AlT8kprnKnYUZiaNZTgvc+Ujx+bb11rl3voxTh/RGH9csPs0UY2sou1Bjv
 JO+DWSvmyiaC5xsOYwOaroDsXXTm5VmWib3VsA==
X-Google-Smtp-Source: AGHT+IFyCJNT8fnT8Ab9bkFTS6q7+OP2sIEBvhhGt8H5YoSdz8eoUWAc9ImC4+NYDKJ67krOUe5kOA==
X-Received: by 2002:a17:90b:3887:b0:2ea:77d9:6346 with SMTP id
 98e67ed59e1d1-2ee08e9fe11mr1706212a91.11.1732669054926; 
 Tue, 26 Nov 2024 16:57:34 -0800 (PST)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ee0fa5fff0sm192931a91.21.2024.11.26.16.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 16:57:34 -0800 (PST)
From: Tony Dinh <mibodhi@gmail.com>
To: Stefan Roese <sr@denx.de>
Cc: Tony Dinh <mibodhi@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH] arm: kirkwood: Enable bootstd and other modernization for
 OpenRD boards
Date: Tue, 26 Nov 2024 16:57:16 -0800
Message-Id: <20241127005716.6234-1-mibodhi@gmail.com>
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

Enable bootstd for OpenRD boards
Update defconfigs to the latest u-boot requirements
Remove JFFS2 support. See JFFS2 Vulnerability[1].
Move default envs to text-base environment

[1] https://lore.kernel.org/u-boot/20241114233005.GN3600562@bill-the-cat/T/#m2fc25da1d2c019bc3cd8676991fdd64b8a21aa9b

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 arch/arm/mach-kirkwood/Kconfig    |  1 +
 board/Marvell/openrd/openrd.env   | 20 ++++++++++++++++++++
 configs/openrd_base_defconfig     | 18 +++++-------------
 configs/openrd_client_defconfig   | 18 +++++-------------
 configs/openrd_ultimate_defconfig | 18 +++++-------------
 include/configs/openrd.h          | 18 ------------------
 6 files changed, 36 insertions(+), 57 deletions(-)
 create mode 100644 board/Marvell/openrd/openrd.env

diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 031d4e5ecd..6761a9cb39 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -38,6 +38,7 @@ config TARGET_OPENRD
 	bool "Marvell OpenRD Board"
 	select KW88F6281
 	select SHEEVA_88SV131
+	select KIRKWOOD_COMMON
 
 config TARGET_DREAMPLUG
 	bool "DreamPlug Board"
diff --git a/board/Marvell/openrd/openrd.env b/board/Marvell/openrd/openrd.env
new file mode 100644
index 0000000000..70ca704b73
--- /dev/null
+++ b/board/Marvell/openrd/openrd.env
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2024 Tony Dinh <mibodhi@gmail.com>
+ *
+ *  Environment variables configurations
+ */
+
+kernel_addr_r=0x800000
+fdt_addr_r=0x2c00000
+ramdisk_addr_r=0x01100000
+scriptaddr=0x200000
+fdtfile=CONFIG_DEFAULT_DEVICE_TREE.dtb
+mtdparts=CONFIG_MTDPARTS_DEFAULT
+console=ttyS0,115200
+
+/* Standard Boot */
+bootcmd=
+	bootflow scan -lb
+failed=
+	echo CONFIG_SYS_BOARD boot failed - please check your image
diff --git a/configs/openrd_base_defconfig b/configs/openrd_base_defconfig
index 708bf5eefd..1ca0b45d93 100644
--- a/configs/openrd_base_defconfig
+++ b/configs/openrd_base_defconfig
@@ -4,22 +4,22 @@ CONFIG_SYS_DCACHE_OFF=y
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_SYS_THUMB_BUILD=y
 CONFIG_ARCH_KIRKWOOD=y
+CONFIG_SUPPORT_PASSING_ATAGS=y
+CONFIG_CMDLINE_TAG=y
+CONFIG_INITRD_TAG=y
 CONFIG_SYS_KWD_CONFIG="board/Marvell/openrd/kwbimage.cfg"
 CONFIG_TEXT_BASE=0x600000
 CONFIG_NR_DRAM_BANKS=2
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc8012000
 CONFIG_TARGET_OPENRD=y
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0x80000
 CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-openrd-base"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_IDENT_STRING="\nOpenRD-Base"
-# CONFIG_SYS_MALLOC_F is not set
 CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=524288
+CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTDELAY=3
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="${x_bootcmd_kernel}; setenv bootargs ${x_bootargs} ${x_bootargs_root}; ${x_bootcmd_usb}; bootm 0x6400000;"
 CONFIG_USE_PREBOOT=y
 CONFIG_LOGLEVEL=2
 # CONFIG_DISPLAY_BOARDINFO is not set
@@ -30,23 +30,17 @@ CONFIG_CMD_MMC=y
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
 CONFIG_MTDIDS_DEFAULT="nand0=nand_mtd"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nand_mtd:0x100000@0x000000(uboot),0x400000@0x100000(uImage),0x1fb00000@0x500000(rootfs)"
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
@@ -59,7 +53,5 @@ CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MVGBE=y
 CONFIG_MII=y
-CONFIG_SYS_NS16550_SERIAL=y
-CONFIG_SYS_NS16550_REG_SIZE=-4
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/openrd_client_defconfig b/configs/openrd_client_defconfig
index 82a9c77761..e0cc2e65db 100644
--- a/configs/openrd_client_defconfig
+++ b/configs/openrd_client_defconfig
@@ -4,10 +4,12 @@ CONFIG_SYS_DCACHE_OFF=y
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_SYS_THUMB_BUILD=y
 CONFIG_ARCH_KIRKWOOD=y
+CONFIG_SUPPORT_PASSING_ATAGS=y
+CONFIG_CMDLINE_TAG=y
+CONFIG_INITRD_TAG=y
 CONFIG_SYS_KWD_CONFIG="board/Marvell/openrd/kwbimage.cfg"
 CONFIG_TEXT_BASE=0x600000
 CONFIG_NR_DRAM_BANKS=2
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc8012000
 CONFIG_TARGET_OPENRD=y
 CONFIG_BOARD_IS_OPENRD_CLIENT=y
 CONFIG_ENV_SIZE=0x20000
@@ -15,12 +17,10 @@ CONFIG_ENV_OFFSET=0x80000
 CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-openrd-client"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_IDENT_STRING="\nOpenRD-Client"
-# CONFIG_SYS_MALLOC_F is not set
 CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=524288
+CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTDELAY=3
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="${x_bootcmd_kernel}; setenv bootargs ${x_bootargs} ${x_bootargs_root}; ${x_bootcmd_usb}; bootm 0x6400000;"
 CONFIG_USE_PREBOOT=y
 CONFIG_LOGLEVEL=2
 # CONFIG_DISPLAY_BOARDINFO is not set
@@ -31,23 +31,17 @@ CONFIG_CMD_MMC=y
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
 CONFIG_MTDIDS_DEFAULT="nand0=nand_mtd"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nand_mtd:0x100000@0x000000(uboot),0x400000@0x100000(uImage),0x1fb00000@0x500000(rootfs)"
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
@@ -60,7 +54,5 @@ CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MVGBE=y
 CONFIG_MII=y
-CONFIG_SYS_NS16550_SERIAL=y
-CONFIG_SYS_NS16550_REG_SIZE=-4
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/openrd_ultimate_defconfig b/configs/openrd_ultimate_defconfig
index 10b46e2ec1..a115691daa 100644
--- a/configs/openrd_ultimate_defconfig
+++ b/configs/openrd_ultimate_defconfig
@@ -4,10 +4,12 @@ CONFIG_SYS_DCACHE_OFF=y
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_SYS_THUMB_BUILD=y
 CONFIG_ARCH_KIRKWOOD=y
+CONFIG_SUPPORT_PASSING_ATAGS=y
+CONFIG_CMDLINE_TAG=y
+CONFIG_INITRD_TAG=y
 CONFIG_SYS_KWD_CONFIG="board/Marvell/openrd/kwbimage.cfg"
 CONFIG_TEXT_BASE=0x600000
 CONFIG_NR_DRAM_BANKS=2
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc8012000
 CONFIG_TARGET_OPENRD=y
 CONFIG_BOARD_IS_OPENRD_ULTIMATE=y
 CONFIG_ENV_SIZE=0x20000
@@ -15,12 +17,10 @@ CONFIG_ENV_OFFSET=0x80000
 CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-openrd-ultimate"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_IDENT_STRING="\nOpenRD-Ultimate"
-# CONFIG_SYS_MALLOC_F is not set
 CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=524288
+CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTDELAY=3
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="${x_bootcmd_kernel}; setenv bootargs ${x_bootargs} ${x_bootargs_root}; ${x_bootcmd_usb}; bootm 0x6400000;"
 CONFIG_USE_PREBOOT=y
 CONFIG_LOGLEVEL=2
 # CONFIG_DISPLAY_BOARDINFO is not set
@@ -31,23 +31,17 @@ CONFIG_CMD_MMC=y
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
 CONFIG_MTDIDS_DEFAULT="nand0=nand_mtd"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nand_mtd:0x100000@0x000000(uboot),0x400000@0x100000(uImage),0x1fb00000@0x500000(rootfs)"
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
@@ -60,7 +54,5 @@ CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MVGBE=y
 CONFIG_MII=y
-CONFIG_SYS_NS16550_SERIAL=y
-CONFIG_SYS_NS16550_REG_SIZE=-4
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/include/configs/openrd.h b/include/configs/openrd.h
index 1e6b16b4e7..f91e62a2e4 100644
--- a/include/configs/openrd.h
+++ b/include/configs/openrd.h
@@ -15,22 +15,4 @@
 
 #include "mv-common.h"
 
-/*
- *  Environment variables configurations
- */
-/*
- * max 4k env size is enough, but in case of nand
- * it has to be rounded to sector size
- */
-
-/*
- * Default environment variables
- */
-
-#define CFG_EXTRA_ENV_SETTINGS	"x_bootargs=console=ttyS0,115200 " \
-	CONFIG_MTDPARTS_DEFAULT " rw ubi.mtd=2,2048\0" \
-	"x_bootcmd_kernel=nand read 0x6400000 0x100000 0x300000\0"	\
-	"x_bootcmd_usb=usb start\0"					\
-	"x_bootargs_root=root=ubi0:rootfs rootfstype=ubifs\0"
-
 #endif /* _CONFIG_OPENRD_BASE_H */
-- 
2.39.5

