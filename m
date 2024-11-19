Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17C4D6C28E
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 19:50:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40725895BD;
	Tue, 19 Nov 2024 20:50:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A0GnnuZm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A5668959B; Tue, 19 Nov 2024 20:50:55 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87F3F895B9
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 20:50:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-296b0d23303so809931fac.2
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 11:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732045851; x=1732650651; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=owgozaR16LhJvyiYIp6yrzXsVFmjh5Q8NGzOHXeDOug=;
 b=A0GnnuZmOMCtTaDNOwZ+PbDwVD4Kkg/qyoFCykfgwKN5cPnenlRNBxPxzyuEWA3N7e
 eRZK8pJCYzCzZwBMWbscpK6pwraW2TJgQW+fT2uQrqU5jCAMwDsCCG9i8lwY8KOLtt31
 l/gbEjvPAbjZ57660T8WW/ggs0X9B4+TxjkPn8UGJWG0rL+HOcOD0KsjBDn4iPhaKbww
 Lr3JFIwwkU+Yv5gvSWTf/JFXCLyold8YKXUfxTfwKjOAVA4HGkBjI5VH5X57g1eHKVV8
 WNeidmk071qFCyyMyJs0E+2a6gO18RXbiLLFeJOKtb8qdyq+YF2CDW3Ks4urvcxGG4+T
 pRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732045851; x=1732650651;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=owgozaR16LhJvyiYIp6yrzXsVFmjh5Q8NGzOHXeDOug=;
 b=DGy2n9zJBcFWa+Ho00rDX0QzU8JMD3d1rT96vf+B4FCYe5uE7GzT5NHzBb0lMSOzJY
 HPva1qE/2r2txKIK6uMAigz7fXJW2ha60kCmOiX2TRSFs8cF4uTZ12Zec/GmFbQ2DZpd
 lxYVJwpDII3YFE3f8CTpzEjCsp0bitJf7IXoV4+AyoQGrJimN2gECORQ1V9A9UGADs6w
 erpjX3LE2Kjcxb/3+9Stvy1em1Hc1JAVqd9S5YITF3pLiHhOuAFvLOsg9Kvd5BsCJq9s
 MR9wb7JSqq88L0uvIib3EEbtTt15ZIzRBNIXrTGzBnfpggzC9i7CyuypR/7Q1j+DChHB
 CDjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1v+TdXS1fKgVQsLcG57xBVMwaLD21Grrc1IhqLM9rMq6ScSPQZq1tEUvrw4KDA/dFwhxeicU=@lists.denx.de
X-Gm-Message-State: AOJu0YwafvpoMq0z5lcRf/jjLKzW0upPfeyi0nudd7W/ODCNQNPrTTOn
 QrkBUWczlzs32Pn5TDOycbjyXK4x24SNSqQjUiFsVgIBO2w85QbN
X-Google-Smtp-Source: AGHT+IGhIKemQ1s7OWnZhWvL8NWGpY9kTCVOljeDoLjtWfKhrn7sI6qK7AFW6SBHzctVkgKuSjjoXQ==
X-Received: by 2002:a05:6870:2495:b0:296:a768:9ef9 with SMTP id
 586e51a60fabf-296d9f4b9ffmr83429fac.42.1732045851248; 
 Tue, 19 Nov 2024 11:50:51 -0800 (PST)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71a781a27ffsm3614667a34.49.2024.11.19.11.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 11:50:50 -0800 (PST)
From: Tony Dinh <mibodhi@gmail.com>
To: Stefan Roese <sr@denx.de>
Cc: Tony Dinh <mibodhi@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH] arm: kirkwood: Enable bootstd for Sheevaplug board
Date: Tue, 19 Nov 2024 11:50:38 -0800
Message-Id: <20241119195039.15177-1-mibodhi@gmail.com>
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

[1] https://lore.kernel.org/u-boot/20241114233005.GN3600562@bill-the-cat/T/#m2fc25da1d2c019bc3cd8676991fdd64b8a21aa9b

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 configs/sheevaplug_defconfig | 16 ++--------------
 include/configs/sheevaplug.h | 20 +++++++++++++++-----
 2 files changed, 17 insertions(+), 19 deletions(-)

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
index 4e0b3c663c..c08d29892c 100644
--- a/include/configs/sheevaplug.h
+++ b/include/configs/sheevaplug.h
@@ -12,13 +12,23 @@
 
 #include "mv-common.h"
 
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
 /*
  *  Environment variables configurations
  */
-#define CFG_EXTRA_ENV_SETTINGS	"x_bootargs=console"	\
-	"=ttyS0,115200 mtdparts=" CONFIG_MTDPARTS_DEFAULT	\
-	"x_bootcmd_kernel=nand read 0x6400000 0x100000 0x400000\0" \
-	"x_bootcmd_usb=usb start\0" \
-	"x_bootargs_root=root=/dev/mtdblock3 rw rootfstype=jffs2\0"
+#define CFG_EXTRA_ENV_SETTINGS \
+	LOAD_ADDRESS_ENV_SETTINGS \
+	"fdtfile=" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
+	"mtdparts=" CONFIG_MTDPARTS_DEFAULT "\0" \
+	"console=ttyS0,115200\0"
 
 #endif /* _CONFIG_SHEEVAPLUG_H */
-- 
2.39.5

