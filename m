Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DB5E64002
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 19:02:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFB798919A;
	Thu, 21 Nov 2024 20:02:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AdECTgrA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3698D890B9; Thu, 21 Nov 2024 20:02:53 +0100 (CET)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADFBC8919A
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 20:02:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7fbc1ca1046so753747a12.0
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 11:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732215769; x=1732820569; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Mxn+yQEbxkxo1pv8xfAYUdCmQ9mAxNFGUTFAD0vGaWY=;
 b=AdECTgrATn1G/7B4cPmzzHKCBOn76MdnwvAC50qKUTuE2m17zanKMipMtKnsAXQ08H
 Mpwp/KAaHKqArpfJchMy6FtZrLzE9j1DXttKpJM4HkN5ANXSEXRCPxScIssiyTv9p97O
 7Juc5e4gHstMkdGTMii6DdaPpw/Kc3HAo5ihT7IacBq0F3k8f9iYR469zuolp8n8RxtJ
 LFUh/Iy0CTlfXQlOFVrBa5fEofhjw8aY9vpIEwi0sh/OQow3L2SPVCkGq4JGLLswRLIm
 MZNXnx1DKsHcJaQ31yiCRFEOEFBmOEgsyOX0whadKmrQ9oMlroyjXLxu/Ja9uo5ZJrrE
 5lsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732215769; x=1732820569;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mxn+yQEbxkxo1pv8xfAYUdCmQ9mAxNFGUTFAD0vGaWY=;
 b=AragXnZQMZ4ZXNWfbIWug+fAoUCnb89mtN5dOOhjJEMd2pOikwBTuIqljdAwRNPXBh
 QTYQzyhiDaxsM+KOWqAfw+Y3sAYZt5nKCFrTBYOhZ/Qi20W1Wkex6zc/olFuKqlxms6X
 Up0aGRaiQfbw5S1SjwtpwKlmCsRcxyp0eprWRP7mUjBXePdcD5yfVnbJ3kREULcxTU0y
 JFzQYYAoaVZkb1iFYlzvBAFESFXarhtJKtCqDy1pzaZhWEHSBUA/TpoRLe335iZGgSxO
 95VDdCjyXsy28Q/Ql1xjxlNeqnolzFV7np53nVwsMroA0xx+hvz7H4hAfq+fpUWzBt7W
 eUMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFeKTy07OXs2lTMPn1PNPx163gTJdrqhHk1VQW228OEYSue8LWal0dRUkTHt/A+jK3WrTjB7A=@lists.denx.de
X-Gm-Message-State: AOJu0Yzy1jmAWQCZomFSQ7bvgzSRMcZecoicdMGN3cnixSPeKFyEiNtA
 FT8s4Myf5zB2z7ic6skcr+vszdBCtvmVjPaPwJehQWZNN0zk+7fmanhS6Q==
X-Gm-Gg: ASbGncsxoAa0ZsDi2yYf1M0/k0x0ssTERHrj55M3ugiPHxNKrKYDNaTLy4nUKAnA2w9
 R53ELSwNPLL/f+U8CVfPRi7wUNRvsLxgR2ebgcam0CMfz56g3YPkm79zpGTPBvrbrUwbbpaTaQM
 tGOCMM1OFOPTXaRKyEKFSplm19kGn50GRZZ3VfLGJwr/B1JYOy2keawTkaF8VMpM8P/1qPMZWWY
 DQ7Xm3bzDCo2+lzJQXPLgFuLHrfl64GjYWGPyV/dFDuS+7pYwIkfbTLTm176kt4B6/3+DW+SOdV
 EMP0TQaLhaLVmjZq6LMNzZntWx4GrCrVKB7d9A==
X-Google-Smtp-Source: AGHT+IGmcdQGtYHO+Royk+CrlK1Bc1fKPNmbT8Z3vONnbU9ALAzwR6Dh8u58L7AXPzy1HOXNYcXrQQ==
X-Received: by 2002:a05:6a21:1789:b0:1dc:c433:144b with SMTP id
 adf61e73a8af0-1ddaf2a2836mr11086554637.27.1732215768934; 
 Thu, 21 Nov 2024 11:02:48 -0800 (PST)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fbcc218527sm93058a12.38.2024.11.21.11.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 11:02:48 -0800 (PST)
From: Tony Dinh <mibodhi@gmail.com>
To: Stefan Roese <sr@denx.de>, Simon Glass <sjg@chromium.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2] arm: kirkwood: Enable bootstd for Sheevaplug board
Date: Thu, 21 Nov 2024 11:02:27 -0800
Message-Id: <20241121190228.29641-1-mibodhi@gmail.com>
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

Enable bootstd for Sheevaplug board.
Remove JFFS2 support. See JFFS2 Vulnerability[1].
Enable LTO to keep board size within limit.
Move default envs to text-base environment

[1] https://lore.kernel.org/u-boot/20241114233005.GN3600562@bill-the-cat/T/#m2fc25da1d2c019bc3cd8676991fdd64b8a21aa9b

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

Changes in v2:
Move default envs to text-base environment

 board/Marvell/sheevaplug/sheevaplug.env | 20 ++++++++++++++++++++
 configs/sheevaplug_defconfig            | 16 ++--------------
 include/configs/sheevaplug.h            |  9 ---------
 3 files changed, 22 insertions(+), 23 deletions(-)
 create mode 100644 board/Marvell/sheevaplug/sheevaplug.env

diff --git a/board/Marvell/sheevaplug/sheevaplug.env b/board/Marvell/sheevaplug/sheevaplug.env
new file mode 100644
index 0000000000..bcd62dbeb7
--- /dev/null
+++ b/board/Marvell/sheevaplug/sheevaplug.env
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2024 Tony Dinh <mibodhi@gmail.com>
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
diff --git a/configs/sheevaplug_defconfig b/configs/sheevaplug_defconfig
index 9ac40b9e57..a7f6c73ecb 100644
--- a/configs/sheevaplug_defconfig
+++ b/configs/sheevaplug_defconfig
@@ -16,16 +16,14 @@ CONFIG_ENV_OFFSET=0x80000
 CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-sheevaplug"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_IDENT_STRING="\nMarvell-Sheevaplug"
+CONFIG_LTO=y
 CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=524288
+CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTDELAY=3
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="${x_bootcmd_kernel}; setenv bootargs ${x_bootargs} ${x_bootargs_root}; bootm 0x6400000;"
 CONFIG_USE_PREBOOT=y
 # CONFIG_DISPLAY_BOARDINFO is not set
-CONFIG_HUSH_PARSER=y
 CONFIG_SYS_MAXARGS=32
-CONFIG_CMD_BOOTZ=y
 # CONFIG_BOOTM_PLAN9 is not set
 # CONFIG_BOOTM_RTEMS is not set
 # CONFIG_BOOTM_VXWORKS is not set
@@ -35,19 +33,10 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND=y
 CONFIG_CMD_SATA=y
 CONFIG_CMD_USB=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_EXT4=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
-CONFIG_CMD_JFFS2=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=orion_nand"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=orion_nand:512K(uboot),512K(env),4M(kernel),-(rootfs)"
 CONFIG_CMD_UBI=y
-CONFIG_ISO_PARTITION=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
@@ -68,6 +57,5 @@ CONFIG_DM_RTC=y
 CONFIG_RTC_MV=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_STORAGE=y
 CONFIG_LZMA=y
 CONFIG_BZIP2=y
diff --git a/include/configs/sheevaplug.h b/include/configs/sheevaplug.h
index 4e0b3c663c..0a5f23e4c8 100644
--- a/include/configs/sheevaplug.h
+++ b/include/configs/sheevaplug.h
@@ -12,13 +12,4 @@
 
 #include "mv-common.h"
 
-/*
- *  Environment variables configurations
- */
-#define CFG_EXTRA_ENV_SETTINGS	"x_bootargs=console"	\
-	"=ttyS0,115200 mtdparts=" CONFIG_MTDPARTS_DEFAULT	\
-	"x_bootcmd_kernel=nand read 0x6400000 0x100000 0x400000\0" \
-	"x_bootcmd_usb=usb start\0" \
-	"x_bootargs_root=root=/dev/mtdblock3 rw rootfstype=jffs2\0"
-
 #endif /* _CONFIG_SHEEVAPLUG_H */
-- 
2.39.5

