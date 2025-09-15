Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4B5CAC597
	for <u-boot@archiver.kernel.org>; Mon, 15 Sep 2025 19:05:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35019834B4;
	Mon, 15 Sep 2025 21:05:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Rhaydxd9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3499C834D4; Mon, 15 Sep 2025 21:05:54 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF2038344E
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 21:05:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-328466c2aedso4212953fac.2
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 12:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757963150; x=1758567950; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=dEWj5jR2Kbwmqs3l6nMDhj//9kn6Ef47Z1rPj8Sz8po=;
 b=Rhaydxd9n01cdfiFrzyVNH2WOZOzpbppe7muvtUTeHNpfa9Xsa+76ncc1oN4c+V2ys
 j5W/8GdgXFaaICIOhrVWg15bwCwi8sNln9nAErX5/eU+b1jazHQQdQUd3yW9b+s7Wk5c
 HNVV/CDUFc7H0ah5pPGMR9DDa32+7t34Arovo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757963150; x=1758567950;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dEWj5jR2Kbwmqs3l6nMDhj//9kn6Ef47Z1rPj8Sz8po=;
 b=d3OxO/BEPMh+MhLoV2QCpt7pemiIRD/p6mqapNliEiT4CTO8cbbA3xa4BsH3pg/yTv
 2Cv+F0xWEBxlV3VnlFq37dw2VFayIUAqe2XzLoXSt70Zi/7nSiw2gRu16WxYyFmwPT/I
 2fLGOByC6wFOmFEF38/rOjpAlFQAshJbbDhLXbeV3FKXQotJ/SYdNaF4kFi7BxW93OPu
 rg5qlqMdT7yzCcDxVRsPE+HdDkAhRbFazLMbZv4llGVhENpS8D5TNai8nYMw+VKreMZF
 YKxOQzo1wkRlTLnUVEq32hKbEHhViy14XLoFRUaKLlnU3ZQapZrONDSn6Bmn5Uwqs6Tv
 r9VQ==
X-Gm-Message-State: AOJu0YynwV17IjLSlOta/KRHDH0iRbc5g86W8zLiIp7eYNXHcNeWMO//
 lFFaoPx6bAKRVwFH7BYyHHAbkVZXSWzURWBvE3yHAjX7ieC0FPsCdDPJvBHrao+6s0W8YamgIE7
 Nv8b9pbc=
X-Gm-Gg: ASbGncsvbJ5k/EYLokvKV9gy2PkXWoIsB7hrE9tIrhMpbAIA4IFfFmsvng4lilGTSKI
 72Li5IRPoP2P1foNJcFxnU7ZwpzbP7VYpM+O+WrmN+vuq/sYYA90G/57qkJsKkc7I1I/zpzjOFK
 O4EvMkID7lXKeFhDtgtGFTpkcY/rfR3jFd5JsjBhZu7oyVNW0HPTfOcfcUGaq+OeHversQTasBB
 DnjSr0mNlBE0nyUKRf0OWGcQf4ZYjVDnAESFcXF4IBo+lbY/iaalanD0qB++3Kgz/EoH8LNOYUC
 ECryTC2LS14rMZ4dJZ2Qoad3fJ/t6NHO6Cl6YJVPxaUYSTpUfVGlH5XzYJKCOjr5pTsMPGqDN/Q
 9ZODPDvUUQwul7y1b8rzXaWti8pyXL7Co2T84OyE0gaX9dxE2Xl0QMankKsY=
X-Google-Smtp-Source: AGHT+IGX8dJTPCihtc5iLztcrwp5DGrrw5PUVGdJP/QHOS95drmcacc4bqBjjM1TODj2tJyLbv5fnA==
X-Received: by 2002:a05:6870:9a92:b0:319:c278:4a6 with SMTP id
 586e51a60fabf-32e578fb0e4mr7369171fac.44.1757963150345; 
 Mon, 15 Sep 2025 12:05:50 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-75955bd9a38sm452794a34.16.2025.09.15.12.05.49
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 12:05:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] cmd: spl: Remove ATAG support from this command
Date: Mon, 15 Sep 2025 13:05:48 -0600
Message-ID: <20250915190548.446942-1-trini@konsulko.com>
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

While we continue to have some systems which support extremely legacy
OS booting methods, we do not have use cases for supporting this in
Falcon mode anymore. Remove this support and references from the
documentation.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 cmd/spl.c               | 18 ---------
 doc/README.commands.spl | 14 ++-----
 doc/develop/falcon.rst  | 84 ++++-------------------------------------
 include/cmd_spl.h       |  3 +-
 4 files changed, 11 insertions(+), 108 deletions(-)

diff --git a/cmd/spl.c b/cmd/spl.c
index 379b512f1ffd..90193b43abf4 100644
--- a/cmd/spl.c
+++ b/cmd/spl.c
@@ -27,19 +27,6 @@ static const char **subcmd_list[] = {
 		"cmdline",
 		"bdt",
 		"prep",
-#endif
-		NULL,
-	},
-	[SPL_EXPORT_ATAGS] = (const char * []) {
-#ifdef CONFIG_SUPPORT_PASSING_ATAGS
-		"start",
-		"loados",
-#ifdef CONFIG_SYS_BOOT_RAMDISK_HIGH
-		"ramdisk",
-#endif
-		"cmdline",
-		"bdt",
-		"prep",
 #endif
 		NULL,
 	},
@@ -96,7 +83,6 @@ static int call_bootm(int argc, char *const argv[], const char *subcommand[])
 
 static struct cmd_tbl cmd_spl_export_sub[] = {
 	U_BOOT_CMD_MKENT(fdt, 0, 1, (void *)SPL_EXPORT_FDT, "", ""),
-	U_BOOT_CMD_MKENT(atags, 0, 1, (void *)SPL_EXPORT_ATAGS, "", ""),
 };
 
 static int spl_export(struct cmd_tbl *cmdtp, int flag, int argc,
@@ -128,10 +114,6 @@ static int spl_export(struct cmd_tbl *cmdtp, int flag, int argc,
 #endif
 			break;
 #endif
-		case SPL_EXPORT_ATAGS:
-			printf("Argument image is now in RAM at: 0x%p\n",
-				(void *)gd->bd->bi_boot_params);
-			break;
 		}
 	} else {
 		/* Unrecognized command */
diff --git a/doc/README.commands.spl b/doc/README.commands.spl
index ecfd3ca9ee58..54cc5b1ec421 100644
--- a/doc/README.commands.spl
+++ b/doc/README.commands.spl
@@ -5,24 +5,16 @@ SUBCOMMAND EXPORT
 To execute the command everything has to be in place as if bootm should be
 used. (kernel image, initrd-image, fdt-image etc.)
 
-export has two subcommands:
-	atags: exports the ATAGS
+export has one subcommand:
 	fdt: exports the FDT
 
 Call is:
-spl export <fdt|atags> [kernel_addr] [initrd_addr] [fdt_addr if fdt]
+spl export fdt [kernel_addr] [initrd_addr] [fdt_addr if fdt]
 
 
 TYPICAL CALL
 
-on OMAP3:
-nandecc hw
-nand read 0x82000000 0x280000 0x400000	/* Read kernel image from NAND*/
-spl export atags			/* export ATAGS */
-nand erase 0x680000 0x20000		/* erase - one page */
-nand write 0x80000100 0x680000 0x20000	/* write the image - one page */
-
-call with FDT:
+on OMAP3 with FDT:
 nandecc hw
 nand read 0x82000000 0x280000 0x400000	/* Read kernel image from NAND*/
 tftpboot 0x80000100 devkit8000.dtb /* Read fdt */
diff --git a/doc/develop/falcon.rst b/doc/develop/falcon.rst
index 244b4ccb5c2e..5689d5b93a7b 100644
--- a/doc/develop/falcon.rst
+++ b/doc/develop/falcon.rst
@@ -22,7 +22,7 @@ copies U-Boot image into the memory.
 
 The Falcon Mode extends this way allowing to start the Linux kernel directly
 from SPL. A new command is added to U-Boot to prepare the parameters that SPL
-must pass to the kernel, using ATAGS or Device Tree.
+must pass to the kernel using a Device Tree.
 
 In normal mode, these parameters are generated each time before
 loading the kernel, passing to Linux the address in memory where
@@ -117,10 +117,7 @@ spl - SPL configuration
 
 Usage::
 
-    spl export <img=atags|fdt> [kernel_addr] [initrd_addr] [fdt_addr ]
-
-img
-    "atags" or "fdt"
+    spl export fdt [kernel_addr] [initrd_addr] [fdt_addr ]
 
 kernel_addr
     kernel is loaded as part of the boot process, but it is not started.
@@ -134,11 +131,11 @@ fdt_addr
     in case of fdt, the address of the device tree.
 
 The *spl export* command does not write to a storage media. The user is
-responsible to transfer the gathered information (assembled ATAGS list
-or prepared FDT) from temporary storage in RAM into persistent storage
-after each run of *spl export*. Unfortunately the position of temporary
-storage can not be predicted nor provided at command line, it depends
-highly on your system setup and your provided data (ATAGS or FDT).
+responsible to transfer the gathered information (prepared FDT) from temporary
+storage in RAM into persistent storage after each run of *spl export*.
+Unfortunately the position of temporary storage can not be predicted nor
+provided at command line, it depends highly on your system setup and your
+provided device tree.
 However at the end of an successful *spl export* run it will print the
 RAM address of temporary storage. The RAM address of FDT will also be
 set in the environment variable *fdtargsaddr*, the new length of the
@@ -152,73 +149,6 @@ to the pre-defined address in persistent storage
 The following example shows how to prepare the data for Falcon Mode on
 twister board with ATAGS BLOB.
 
-The *spl export* command is prepared to work with ATAGS and FDT. However,
-using FDT is at the moment untested. The ppc port (see a3m071 example
-later) prepares the fdt blob with the fdt command instead.
-
-
-Usage on the twister board
---------------------------
-
-Using mtd names with the following (default) configuration
-for mtdparts::
-
-    device nand0 <omap2-nand.0>, # parts = 9
-     #: name        size        offset      mask_flags
-     0: MLO                 0x00080000      0x00000000      0
-     1: u-boot              0x00100000      0x00080000      0
-     2: env1                0x00040000      0x00180000      0
-     3: env2                0x00040000      0x001c0000      0
-     4: kernel              0x00600000      0x00200000      0
-     5: bootparms           0x00040000      0x00800000      0
-     6: splashimg           0x00200000      0x00840000      0
-     7: mini                0x02800000      0x00a40000      0
-     8: rootfs              0x1cdc0000      0x03240000      0
-
-::
-
-    twister => nand read 82000000 kernel
-
-    NAND read: device 0 offset 0x200000, size 0x600000
-    6291456 bytes read: OK
-
-Now the kernel is in RAM at address 0x82000000::
-
-    twister => spl export atags 0x82000000
-    ## Booting kernel from Legacy Image at 82000000 ...
-       Image Name:   Linux-3.5.0-rc4-14089-gda0b7f4
-       Image Type:   ARM Linux Kernel Image (uncompressed)
-       Data Size:    3654808 Bytes = 3.5 MiB
-       Load Address: 80008000
-       Entry Point:  80008000
-       Verifying Checksum ... OK
-       Loading Kernel Image ... OK
-    OK
-    cmdline subcommand not supported
-    bdt subcommand not supported
-    Argument image is now in RAM at: 0x80000100
-
-The result can be checked at address 0x80000100::
-
-    twister => md 0x80000100
-    80000100: 00000005 54410001 00000000 00000000    ......AT........
-    80000110: 00000000 00000067 54410009 746f6f72    ....g.....ATroot
-    80000120: 65642f3d 666e2f76 77722073 73666e20    =/dev/nfs rw nfs
-
-The parameters generated with this step can be saved into NAND at the offset
-0x800000 (value for twister for CONFIG_CMD_SPL_NAND_OFS)::
-
-    nand erase.part bootparms
-    nand write 0x80000100 bootparms 0x4000
-
-Now the parameters are stored into the NAND flash at the address
-CONFIG_CMD_SPL_NAND_OFS (=0x800000).
-
-Next time, the board can be started into Falcon Mode moving the
-setting the GPIO (on twister GPIO 55 is used) to kernel mode.
-
-The kernel is loaded directly by the SPL without passing through U-Boot.
-
 Example with FDT: a3m071 board
 ------------------------------
 
diff --git a/include/cmd_spl.h b/include/cmd_spl.h
index 51ec12edb906..45ea91e9bce6 100644
--- a/include/cmd_spl.h
+++ b/include/cmd_spl.h
@@ -8,7 +8,6 @@
 #define SPL_EXPORT	(0x00000001)
 
 #define SPL_EXPORT_FDT		(0x00000001)
-#define SPL_EXPORT_ATAGS	(0x00000002)
-#define SPL_EXPORT_LAST		SPL_EXPORT_ATAGS
+#define SPL_EXPORT_LAST		SPL_EXPORT_FDT
 
 #endif /* _NAND_SPL_H_ */
-- 
2.43.0

