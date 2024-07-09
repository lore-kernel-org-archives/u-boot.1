Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14224C3271E
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 02:39:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAF3F883F6;
	Tue,  9 Jul 2024 04:39:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aiasvRoy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAB4E883AC; Tue,  9 Jul 2024 04:39:09 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91E7E88405
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 04:39:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7fd3dbc01deso80339639f.0
 for <u-boot@lists.denx.de>; Mon, 08 Jul 2024 19:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720492745; x=1721097545; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sYICwdHKlPgo/6WlKyEHoBH54dmCAG56kMtMW/Kuij4=;
 b=aiasvRoymUAby52XfXzWLIVTqafbj4/zjcBSuzaZ+wiCy9ktwebctfF8KxHdb2WEgs
 d4CtEkGeWfSZYDfNvtm7ain0lxdlXFZZ62/Ho/AebrDMovb5t4ykVCN+wQAWQWcOawJL
 hEf1eBOPTFPW5FuhrrImZMpurjWiLU+DdL/OpC2aBX7TME7mPeBd19JySDGT0xZ3NUd+
 KCCgw4cUvcZdnPtAa2dMB+lN70ogaKJh3Y92wGkmBUkLH3pTjWgcanfV6rdf39Mhjd7p
 fUBSzwzx3nR63NZKGl8qyDsMQOjS+v4163/oATGCATDuYIe8cFOQXfWgXETbdJWYQaj4
 BlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720492745; x=1721097545;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sYICwdHKlPgo/6WlKyEHoBH54dmCAG56kMtMW/Kuij4=;
 b=AQgVr0o/ScbnyTDNAnkfEVPpOUqv0IpqmjAA5pIRRcBXYXUcw3DSEYfCwAC3FO1T11
 MGXrE2g2mLHIZll4WgE7oGsyNcp8C4JcFy4S4aq6OTHX6jSj5AaO7wk3W1LYsAFdzZwn
 7e/mmRtvjw+I4cLJz5S8qPdx4X0mlS0Za13NwyV8k2Y2blumGcNd2atWh6VIYuCvltCk
 G25KHLIsfQ7l2nK6Vm+cCpaHabtUve6I1nkYZ3zDQYxoPUjvGeRxh7XpWkQRrMGtpueA
 MsLzhURMnrHwTdyxO9pDz6hENISXaZ93JlDYGageD91X9Cz6XNf9s4B/shKhxACjMcnx
 e3bg==
X-Gm-Message-State: AOJu0YzdKxFCfWVLwcWHGoiaI7DRnrnWC/om3OPlKhxMol7PFyRmaZfp
 O3bIP+/DxSLyB+mmUFMP/IVKay3Elg80lF8C8lwcNsHiPQybLr1cBlH9hg==
X-Google-Smtp-Source: AGHT+IHlBw+I8ZVQTzRXCp/HbKBhRd7a577pZG+QLxYkjYPye6ybcucwtoHDuPYsDVeWqbKtqHAHeA==
X-Received: by 2002:a5d:9703:0:b0:7fd:5a50:b217 with SMTP id
 ca18e2360f4ac-7ffff7672b3mr167597539f.3.1720492745392; 
 Mon, 08 Jul 2024 19:39:05 -0700 (PDT)
Received: from aford-System-Version.lan
 ([2601:447:d002:5be:7a2b:7dd6:f688:8ee0])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c0b1b10a3esm271476173.67.2024.07.08.19.39.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 19:39:04 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, woods.technical@gmail.com,
 Adam Ford <aford173@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH] ti: omap: am3517evm: Move environment definition to env file
Date: Mon,  8 Jul 2024 21:38:57 -0500
Message-ID: <20240709023858.27747-1-aford173@gmail.com>
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

Instead of cluttering up a header file with a bunch of defines,
move the default environmental variables to a file called
am3517evm.env and reference it from the defconfig.  Also
remove dead comments.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/board/logicpd/am3517evm/am3517evm.env b/board/logicpd/am3517evm/am3517evm.env
new file mode 100644
index 0000000000..77bb31c416
--- /dev/null
+++ b/board/logicpd/am3517evm/am3517evm.env
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+console=ttyS2,115200n8
+fdtfile=am3517-evm.dtb
+fdtaddr=0x82C00000
+vram=16M
+bootenv=uEnv.txt
+mmcdev=0
+mmcpart=1
+mmcroot=/dev/mmcblk0p2 rw
+mmcrootfstype=ext4 rootwait fixrtc
+mmcargs=setenv bootargs console=${console} ${mtdparts} ${optargs} root=${mmcroot} rootfstype=${mmcrootfstype} ${cmdline}
+nandargs=setenv bootargs console=${console} ${mtdparts} ${optargs} root=ubi0:rootfs rw ubi.mtd=rootfs rootfstype=ubifs rootwait ${cmdline}
+loadbootenv=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${bootenv}
+importbootenv=echo "Importing environment from mmc ..."; env import -t ${loadaddr} ${filesize}
+bootscript=echo "Running bootscript from mmc ..."; source ${loadaddr}
+loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${bootfile}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdtaddr} ${fdtfile}
+mmcboot=echo "Booting from mmc ..."; run mmcargs; bootz ${loadaddr} - ${fdtaddr}
+nandboot=echo "Booting from nand ..."; run nandargs; nand read ${loadaddr} 2a0000 800000; nand read ${fdtaddr} aa0000 80000; bootm ${loadaddr} - ${fdtaddr}
diff --git a/configs/am3517_evm_defconfig b/configs/am3517_evm_defconfig
index 70498ca7fb..3236f1dd67 100644
--- a/configs/am3517_evm_defconfig
+++ b/configs/am3517_evm_defconfig
@@ -6,6 +6,7 @@ CONFIG_TEXT_BASE=0x80100000
 CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SOURCE_FILE="am3517evm"
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4020ff00
 CONFIG_DEFAULT_DEVICE_TREE="ti/omap/am3517-evm"
diff --git a/include/configs/am3517_evm.h b/include/configs/am3517_evm.h
index b75c648388..e3432ebeaa 100644
--- a/include/configs/am3517_evm.h
+++ b/include/configs/am3517_evm.h
@@ -15,7 +15,7 @@
 #include <configs/ti_omap3_common.h>
 
 /* Board NAND Info. */
-#ifdef CONFIG_MTD_RAW_NAND
+#if defined(CONFIG_MTD_RAW_NAND)
 #define CFG_SYS_NAND_ECCPOS		{ 2,  3,  4,  5,  6,  7,  8,  9, 10, \
 					 11, 12, 13, 14, 16, 17, 18, 19, 20, \
 					 21, 22, 23, 24, 25, 26, 27, 28, 30, \
@@ -35,61 +35,8 @@
  *  DTB                  4 * NAND_BLOCK_SIZE = 512 KiB  @ 0xAA0000
  *  RootFS              Remaining Flash Space           @ 0xB20000
  */
-#endif /* CONFIG_MTD_RAW_NAND */
-
-/* Environment information */
-#define CFG_EXTRA_ENV_SETTINGS \
-	"loadaddr=0x82000000\0" \
-	"console=ttyS2,115200n8\0" \
-	"fdtfile=am3517-evm.dtb\0" \
-	"fdtaddr=0x82C00000\0" \
-	"vram=16M\0" \
-	"bootenv=uEnv.txt\0" \
-	"cmdline=\0" \
-	"optargs=\0" \
-	"mmcdev=0\0" \
-	"mmcpart=1\0" \
-	"mmcroot=/dev/mmcblk0p2 rw\0" \
-	"mmcrootfstype=ext4 rootwait fixrtc\0" \
-	"mmcargs=setenv bootargs console=${console} " \
-		"${mtdparts} " \
-		"${optargs} " \
-		"root=${mmcroot} " \
-		"rootfstype=${mmcrootfstype} " \
-		"${cmdline}\0" \
-	"nandargs=setenv bootargs console=${console} " \
-		"${mtdparts} " \
-		"${optargs} " \
-		"root=ubi0:rootfs rw ubi.mtd=rootfs " \
-		"rootfstype=ubifs rootwait " \
-		"${cmdline}\0" \
-	"loadbootenv=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${bootenv}\0"\
-	"importbootenv=echo Importing environment from mmc ...; " \
-		"env import -t ${loadaddr} ${filesize}\0" \
-	"bootscript=echo Running bootscript from mmc ...; " \
-		"source ${loadaddr}\0" \
-	"loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${bootfile}\0" \
-	"loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdtaddr} ${fdtfile}\0" \
-	"mmcboot=echo Booting from mmc ...; " \
-		"run mmcargs; " \
-		"bootz ${loadaddr} - ${fdtaddr}\0" \
-	"nandboot=echo Booting from nand ...; " \
-		"run nandargs; " \
-		"nand read ${loadaddr} 2a0000 800000; " \
-		"nand read ${fdtaddr} aa0000 80000; " \
-		"bootm ${loadaddr} - ${fdtaddr}\0" \
-
-/* Miscellaneous configurable options */
-
-/* memtest works on */
 
-/* FLASH and environment organization */
-
-/* **** PISMO SUPPORT *** */
-						/* on one chip */
-
-#if defined(CONFIG_MTD_RAW_NAND)
 #define CFG_SYS_FLASH_BASE		NAND_BASE
-#endif
+#endif /* CONFIG_MTD_RAW_NAND */
 
 #endif /* __CONFIG_H */
-- 
2.43.0

