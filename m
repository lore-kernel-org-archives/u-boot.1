Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD45D6C2B9
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 00:27:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1002D895F0;
	Wed, 20 Nov 2024 01:27:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gfpgVecA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 623CE895D6; Tue, 19 Nov 2024 23:29:02 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EA9788FDE
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 23:28:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43152fa76aaso5945535e9.1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732055338; x=1732660138; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oWtOLtmi2NoqCSvsRhgs5EWxsQeCtiTRaMqDR2pGJm8=;
 b=gfpgVecAmfsqz1CI2LML17Emv0XqTlleWUXwubf5eCSjlkNYa2bJmaxVeGt3F+aoyt
 NUWBFaO4vtI805aPaghs2xi4iMsYR1lgGPojH/WrScB2yYE9oaBFA3RUWYPWMo85y5JA
 GrXyO8+68/Y6wtxpS50lvj2A5knSxrnrO/b+ddTE1xU5HfY7Ik5cqIqVq0bfRmDEcZO0
 rIP5v5J9Te4tIeQ14dmSyoGSVk5qW01J4k3eXhio2YI93KQVTfkhupvax/Py1JbCMKV9
 eFQAViA4ZOoM5dt5RIQON0xyUcvrAOs8Y8MvbAE0eJ30FAuW4zppw6dXz7ydw4hqGwbW
 7WIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732055338; x=1732660138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oWtOLtmi2NoqCSvsRhgs5EWxsQeCtiTRaMqDR2pGJm8=;
 b=gaX0TwZOYAEe8joRHC64GwTeC9AiCyNyBkwXvb+fWqP0rohefeMFGdbq//1gK1Yo0/
 Thtx8qTxjvd7r7l7uZ/4LxjcbCOQB5HDGeP1uMhRNJsJnk4QRCb8VzeTW6cI3iNCrhfK
 GgC1Lm0KGYsxhQadg8BJoNCnvRQQ5u9I0PuJopBPWz8K5cHkxshDuvs4kEn3PJikbiaH
 IlrGNDm1S1MfLRXZ0cXL8ejUQIf5dkNjV8j29Fr8JPT6gH6cbf6TfoX9+NUrJ7AOkxdb
 nAL90qfTwTM4kNSzZWiT3+OxbDKYzduHr8Nq378EzG5H1mHIEeAbe3GHpfbtrWNF3IDX
 ug7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzCAF/hg0ALi+DXh/ZNB1ztumZqKgyUjGKjGWkmLtC5l8XJ6k0GKC5f1wCMzi+qiWrIEvGWGs=@lists.denx.de
X-Gm-Message-State: AOJu0YzBCLeRz7DjkJ5LPWffdUvCoVSAB4duH4rH5m5ar3T8xEIrS/MF
 0apvchcCGvhCnCI5oaUPRcyQdpZDqG8QODE1Ow22nJyCA0DWSXPM
X-Gm-Gg: ASbGncugrRGRTAfvYW/jQr28A0MBtH6MD8cy341OXz1nXylGo5r1iaKd4byeWIPAZ/A
 w6jReZCLq3WL/QpZvFaEPRU6QGnCkmr2ck1sMN/k4/n7lmc74cVo3l4V1cRhMag7+bcIWnOMdz+
 vBg6k+8lufRAVk+B2Sn1mEqBz3O1f/THSzM9gmY2E5btJCdhY9Fk9Can7FhUo9D5fycdwYmKRCP
 zqnsRJ2gWaY+ya86fqC+jIQCoIN08NBxB7k3SKEyG/y11PDPw3U74wXpjPyWgaj00ijPt84imm5
 pjHFD7IBwt4HX3O0ZAp9+cvotXBc
X-Google-Smtp-Source: AGHT+IFSoXxzF6j/gANs3/4WGEiXa8llr8ESBDhuPFGSOfdNyPsSCwSsiohVbD/Iw8Q3yXQrLvvY1Q==
X-Received: by 2002:a05:600c:444f:b0:430:4db0:3ffd with SMTP id
 5b1f17b1804b1-4334f013d8cmr1821045e9.4.1732055337836; 
 Tue, 19 Nov 2024 14:28:57 -0800 (PST)
Received: from d71e1d1a2016.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac1fb7asm208058655e9.42.2024.11.19.14.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 14:28:56 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: sjg@chromium.org, trini@konsulko.com, alpernebiyasak@gmail.com,
 ada@thorsis.com, xypron.glpk@gmx.de
Cc: mkorpershoek@baylibre.com, dario.binacchi@amarulasolutions.com,
 pbrobinson@gmail.com, n-francis@ti.com, afd@ti.com, al.kochet@gmail.com,
 u-boot@lists.denx.de, l.rubusch@gmail.com
Subject: [PATCH v1 1/3] doc: develop: Fix typos and wording in
 binman/binman.rst
Date: Tue, 19 Nov 2024 22:28:35 +0000
Message-Id: <20241119222837.27550-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241119222837.27550-1-l.rubusch@gmail.com>
References: <20241119222837.27550-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 20 Nov 2024 01:27:55 +0100
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

Fix some typos and duplicate words in binman.rst.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 tools/binman/binman.rst | 238 ++++++++++++++++++++--------------------
 1 file changed, 119 insertions(+), 119 deletions(-)

diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index 381e55686f..620b5fa048 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -5,7 +5,7 @@ Introduction
 ============
 
 Firmware often consists of several components which must be packaged together.
-For example, we may have SPL, U-Boot, a device tree and an environment area
+For example, we may have SPL, U-Boot, a device-tree and an environment area
 grouped together and placed in MMC flash. When the system starts, it must be
 able to find these pieces.
 
@@ -19,7 +19,7 @@ together.
 What it does
 ------------
 
-Binman reads your board's device tree and finds a node which describes the
+Binman reads your board's device-tree and finds a node which describes the
 required image layout. It uses this to work out what to place where.
 
 Binman provides a mechanism for building images, from simple SPL + U-Boot
@@ -31,13 +31,13 @@ needed.
 Features
 --------
 
-Apart from basic padding, alignment and positioning features, Binman supports
+Apart from basic padding, alignment, and positioning features, Binman supports
 hierarchical images, compression, hashing and dealing with the binary blobs
-which are a sad trend in open-source firmware at present.
+which is a sad trend in open-source firmware at present.
 
 Executable binaries can access the location of other binaries in an image by
-using special linker symbols (zero-overhead but somewhat limited) or by reading
-the devicetree description of the image.
+using special linker symbols (zero-overhead but limited) or by reading
+the device-tree description of the image.
 
 Binman is designed primarily for use with U-Boot and associated binaries such
 as ARM Trusted Firmware, but it is suitable for use with other projects, such
@@ -55,14 +55,14 @@ Motivation
 ----------
 
 As mentioned above, packaging of firmware is quite a different task from
-building the various parts. In many cases the various binaries which go into
-the image come from separate build systems. For example, ARM Trusted Firmware
+building the various parts. In many cases the various binaries which go into image
+come from separate build systems. For example, ARM Trusted Firmware
 is used on ARMv8 devices but is not built in the U-Boot tree. If a Linux kernel
 is included in the firmware image, it is built elsewhere.
 
-It is of course possible to add more and more build rules to the U-Boot
+It is of course possible to add further build rules to the U-Boot
 build system to cover these cases. It can shell out to other Makefiles and
-build scripts. But it seems better to create a clear divide between building
+build scripts. But it seems preferable to create a clear divide between building
 software and packaging it.
 
 At present this is handled by manual instructions, different for each board,
@@ -82,7 +82,7 @@ Benefits:
   - Avoids cluttering the U-Boot build system with image-building code
   - The image description is automatically available at run-time in U-Boot,
     SPL. It can be made available to other software also
-  - The image description is easily readable (it's a text file in device-tree
+  - The image description is easily readable (a text file in device-tree
     format) and permits flexible packing of binaries
 
 
@@ -102,7 +102,7 @@ You can install binman using::
 
    pip install binary-manager
 
-The name is chosen since binman conflicts with an existing package.
+The name was chosen since binman conflicts with an existing package.
 
 If you are using binman within the U-Boot tree, it may be easiest to add a
 symlink from your local `~/.bin` directory to `/path/to/tools/binman/binman`.
@@ -116,9 +116,9 @@ load / execution addresses, compression. It also supports verification
 through hashing and RSA signatures.
 
 FIT was originally designed to support booting a Linux kernel (with an
-optional ramdisk) and device tree chosen from various options in the FIT.
-Now that U-Boot supports configuration via device tree, it is possible to
-load U-Boot from a FIT, with the device tree chosen by SPL.
+optional ramdisk) and device-tree chosen from assorted options in the FIT.
+Now that U-Boot supports configuration via device-tree, it is possible to
+load U-Boot from a FIT, with the device-tree chosen by SPL.
 
 Binman considers FIT to be one of the binaries it can place in the image.
 
@@ -140,7 +140,7 @@ Relationship to mkimage
 -----------------------
 
 The mkimage tool provides a means to create a FIT. Traditionally it has
-needed an image description file: a device tree, like binman, but in a
+needed an image description file: a device-tree, like binman, but in a
 different format. More recently it has started to support a '-f auto' mode
 which can generate that automatically.
 
@@ -173,7 +173,7 @@ build system.
 Consider sunxi. It has the following steps:
 
   #. It uses a custom mksunxiboot tool to build an SPL image called
-     sunxi-spl.bin. This should probably move into mkimage.
+     sunxi-spl.bin. This should better go into mkimage.
 
   #. It uses mkimage to package U-Boot into a legacy image file (so that it can
      hold the load and execution address) called u-boot.img.
@@ -193,7 +193,7 @@ can be replaced by a call to binman.
 Invoking binman within U-Boot
 -----------------------------
 
-Within U-Boot, binman is invoked by the build system, i.e. when you type 'make'
+Within U-Boot, binman is invoked by the build system, i.e., when you type 'make'
 or use buildman to build U-Boot. There is no need to run binman independently
 during development. Everything happens automatically and is set up for your
 SoC or board so that binman produced the right things.
@@ -208,10 +208,10 @@ invocations as well, but these should be dropped when those architectures are
 converted to use binman properly.
 
 As above, the term 'binary' is used for something in INPUTS-y and 'image' is
-used for the things that binman creates. So the binaries are inputs to the
-image(s) and it is the image that is actually loaded on the board.
+used for the things that binman creates. Hence, the binaries are inputs to the
+ image(s), and it is the image that is actually loaded on the board.
 
-Again, at present, there are a number of things created in Makefile which should
+Again, at present, there are a few things created in Makefile which should
 be done by binman (when we get around to it), like `u-boot-ivt.img`,
 `lpc32xx-spl.img`, `u-boot-with-nand-spl.imx`, `u-boot-spl-padx4.sfp` and
 `u-boot-mtk.bin`, just to pick on a few. When completed this will remove about
@@ -222,15 +222,15 @@ are needed, in that one invocation. It does this by working through the image
 descriptions one by one, collecting the input binaries, processing them as
 needed and producing the final images.
 
-The same binaries may be used by multiple images. For example binman may be used
+The same binaries may be used for multiple images. For example, binman may be used
 to produce an SD-card image and a SPI-flash image. In this case the binaries
 going into the process are the same, but binman produces slightly different
 images in each case.
 
 For some SoCs, U-Boot is not the only project that produces the necessary
 binaries. For example, ARM Trusted Firmware (ATF) is a project that produces
-binaries which must be incorporate, such as `bl31.elf` or `bl31.bin`. For this
-to work you must have built ATF before you build U-Boot and you must tell U-Boot
+binaries which must be incorporated, such as `bl31.elf` or `bl31.bin`. For this
+to work you must have built ATF before you build U-Boot, and you must tell U-Boot
 where to find the bl31 image, using the BL31 environment variable.
 
 How do you know how to incorporate ATF? It is handled by the atf-bl31 entry type
@@ -267,29 +267,29 @@ nor is there any need to provide a real ATF BL31 binary (for example). These can
 be added later by invoking binman again, providing all the required inputs
 from the first time, plus any that were missing or placeholders.
 
-So in practice binman is often used twice:
+Then, in practice binman is often used twice:
 
-- once within the U-Boot build system, for development and testing
-- again outside U-Boot to assembly and final production images
+- Once within the U-Boot build system, for development and testing
+- Again, outside U-Boot to assembly and final production images
 
 While the same input binaries are used in each case, you will of course you will
-need to create your own binman command line, similar to that in `cmd_binman` in
+need to create your own binman command line, like that in `cmd_binman` in
 the Makefile. You may find the -I and --toolpath options useful. The
-device tree file is provided to binman in binary form, so there is no need to
+Device-tree file is provided to binman in binary form, so there is no need to
 have access to the original `.dts` sources.
 
 
 Assembling the image description
 --------------------------------
 
-Since binman uses the device tree for its image description, you can use the
+Since binman uses the device-tree for its image description, you can use the
 same files that describe your board's hardware to describe how the image is
-assembled. Typically the images description is in a common file used by all
+assembled. Typically, the images description is in a common file used by all
 boards with a particular SoC (e.g. `imx8mp-u-boot.dtsi`).
 
-Where a particular boards needs to make changes, it can override properties in
-the SoC file, just as it would for any other device tree property. It can also
-add a image that is specific to the board.
+Where a particular board needs to make changes, it can override properties in
+the SoC file, just as it would for any other device-tree property. It can also
+add an image that is specific to the board.
 
 Another way to control the image description to make use of CONFIG options in
 the description. For example, if the start offset of a particular entry varies
@@ -303,7 +303,7 @@ by board, you can add a Kconfig for that and reference it in the description::
         ...
     };
 
-The SoC can provide a default value but boards can override that as needed and
+The SoC can provide a default value, but boards can override that as needed and
 binman will take care of it.
 
 It is even possible to control which entries appear in the image, by using the
@@ -317,15 +317,15 @@ C preprocessor::
 
 Only boards which enable `HAVE_MRC` will include this entry.
 
-Obviously a similar approach can be used to control which images are produced,
-with a Kconfig option to enable a SPI image, for example. However there is
-generally no harm in producing an image that is not used. If a board uses MMC
+Obviously, a similar approach can be used to control which images are produced,
+with a Kconfig option to enable a SPI image, for example. However, there is
+no general harm in producing an image that is not used. If a board uses MMC
 but not SPI, but the SoC supports booting from both, then both images can be
-produced, with only on or other being used by particular boards. This can help
-reduce the need for having multiple defconfig targets for a board where the
+produced, with only one or other being used by a particular board. This can help
+reduce the need for having multiple defconfig targets, for boards where the
 only difference is the boot media, enabling / disabling secure boot, etc.
 
-Of course you can use the device tree itself to pass any board-specific
+Of course, you can use the device-tree itself to pass any board-specific
 information that is needed by U-Boot at runtime (see binman_syms_ for how to
 make binman insert these values directly into executables like SPL).
 
@@ -341,14 +341,14 @@ Producing images for multiple boards
 When invoked within U-Boot, binman only builds a single set of images, for
 the chosen board. This is set by the `CONFIG_DEFAULT_DEVICE_TREE` option.
 
-However, U-Boot generally builds all the device tree files associated with an
-SoC. These are written to the (e.g. for ARM) `arch/arm/dts` directory. Each of
+However, U-Boot builds all the device-tree files associated with an
+SoC. These are written in the (e.g. for ARM) `arch/arm/dts` directory. Each of
 these contains the full binman description for that board. Often the best
-approach is to build a single image that includes all these device tree binaries
+approach is to build a single image that includes all these device-tree binaries
 and allow SPL to select the correct one on boot.
 
 However, it is also possible to build separate images for each board, simply by
-invoking binman multiple times, once for each device tree file, using a
+invoking binman multiple times, once for each device-tree file, using a
 different output directory. This will produce one set of images for each board.
 
 
@@ -429,7 +429,7 @@ build.
 
 (Future work will make this more configurable)
 
-In either case, binman picks up the device tree file (u-boot.dtb) and looks
+In either case, binman picks up the device-tree file (u-boot.dtb) and looks
 for its instructions in the 'binman' node.
 
 Binman has a few other options which you can see by running 'binman -h'.
@@ -441,7 +441,7 @@ Enabling binman for a board
 At present binman is invoked from a rule in the main Makefile. You should be
 able to enable CONFIG_BINMAN to enable this rule.
 
-The output file is typically named image.bin and is located in the output
+The output file is typically named image.bin and is in the output
 directory. If input files are needed to you add these to INPUTS-y either in the
 main Makefile or in a config.mk file in your arch subdirectory.
 
@@ -476,19 +476,19 @@ You can access this value with something like:
     ulong u_boot_offset = binman_sym(ulong, u_boot_any, image_pos);
 
 Thus u_boot_offset will be set to the image-pos of U-Boot in memory, assuming
-that the whole image has been loaded, or is available in flash. You can then
+that the whole image has been loaded or is available in flash. You can then
 jump to that address to start U-Boot.
 
 At present this feature is only supported in SPL and TPL. In principle it is
 possible to fill in such symbols in U-Boot proper, as well, but a future C
-library is planned for this instead, to read from the device tree.
+library is planned for this instead, to read from the device-tree.
 
 As well as image-pos, it is possible to read the size of an entry and its
 offset (which is the start position of the entry within its parent).
 
 A small technical note: Binman automatically adds the base address of the image
 (i.e. __image_copy_start) to the value of the image-pos symbol, so that when the
-image is loaded to its linked address, the value will be correct and actually
+image is loaded to its linked address; the value will be correct and actually
 point into the image.
 
 For example, say SPL is at the start of the image and linked to start at address
@@ -523,7 +523,7 @@ each entry in the images it processes. The option to enable this is -u and it
 causes binman to make sure that the 'offset', 'image-pos' and 'size' properties
 are set correctly for every entry. Since it is not necessary to specify these in
 the image definition, binman calculates the final values and writes these to
-the device tree. These can be used by U-Boot at run-time to find the location
+the device-tree. These can be used by U-Boot at run-time to find the location
 of each entry.
 
 Alternatively, an FDT map entry can be used to add a special FDT containing
@@ -556,8 +556,8 @@ Passing command-line arguments to entries
 -----------------------------------------
 
 Sometimes it is useful to pass binman the value of an entry property from the
-command line. For example some entries need access to files and it is not
-always convenient to put these filenames in the image definition (device tree).
+command line. For example, some entries need access to files, and it is not
+always convenient to put these filenames in the image definition (device-tree).
 
 The -a option supports this::
 
@@ -594,7 +594,7 @@ This requests binman to create an image file called u-boot-sunxi-with-spl.bin
 consisting of a specially formatted SPL (spl/sunxi-spl.bin, built by the
 normal U-Boot Makefile), some 0xff padding, and a U-Boot legacy image. The
 padding comes from the fact that the second binary is placed at
-CONFIG_SPL_PAD_TO. If that line were omitted then the U-Boot binary would
+CONFIG_SPL_PAD_TO. If that line were omitted, then the U-Boot binary would
 immediately follow the SPL binary.
 
 The binman node describes an image. The sub-nodes describe entries in the
@@ -606,7 +606,7 @@ Entries are normally placed into the image sequentially, one after the other.
 The image size is the total size of all entries. As you can see, you can
 specify the start offset of an entry using the 'offset' property.
 
-Note that due to a device tree requirement, all entries must have a unique
+Note that due to a device-tree requirement, all entries must have a unique
 name. If you want to put the same binary in the image multiple times, you can
 use any unique name, with the 'type' property providing the type.
 
@@ -622,7 +622,7 @@ offset:
 align:
     This sets the alignment of the entry. The entry offset is adjusted
     so that the entry starts on an aligned boundary within the containing
-    section or image. For example 'align = <16>' means that the entry will
+    section or image. For example, 'align = <16>' means that the entry will
     start on a 16-byte boundary. This may mean that padding is added before
     the entry. The padding is part of the containing section but is not
     included in the entry, meaning that an empty space may be created before
@@ -639,7 +639,7 @@ min-size:
     ('pad-before' and 'pad-after'), but not padding added to meet alignment
     requirements. While this does not affect the contents of the entry within
     binman itself (the padding is performed only when its parent section is
-    assembled), the end result will be that the entry ends with the padding
+    assembled), the result will be that the entry ends with the padding
     bytes, so may grow. Defaults to 0.
 
 pad-before:
@@ -647,8 +647,8 @@ pad-before:
     that the contents start at the beginning of the entry. This can be used
     to offset the entry contents a little. While this does not affect the
     contents of the entry within binman itself (the padding is performed
-    only when its parent section is assembled), the end result will be that
-    the entry starts with the padding bytes, so may grow. Defaults to 0.
+    only when its parent section is assembled), the result will be that
+    the entry starts with the padding bytes, so it may grow. Defaults to 0.
 
 pad-after:
     Padding after the contents of the entry. Normally this is 0, meaning
@@ -656,7 +656,7 @@ pad-after:
     other properties). This allows room to be created in the image for
     this entry to expand later. While this does not affect the contents of
     the entry within binman itself (the padding is performed only when its
-    parent section is assembled), the end result will be that the entry ends
+    parent section is assembled), the result will be that the entry ends
     with the padding bytes, so may grow. Defaults to 0.
 
 align-size:
@@ -664,7 +664,7 @@ align-size:
     that the size of an entry is a multiple of 64 bytes, set this to 64.
     While this does not affect the contents of the entry within binman
     itself (the padding is performed only when its parent section is
-    assembled), the end result is that the entry ends with the padding
+    assembled), the result is that the entry ends with the padding
     bytes, so may grow. If 'align-size' is not provided, no alignment is
     performed.
 
@@ -675,7 +675,7 @@ align-end:
     of the entry, so the contents of the entry will still start at the
     beginning. But there may be padding at the end. While this does not
     affect the contents of the entry within binman itself (the padding is
-    performed only when its parent section is assembled), the end result
+    performed only when its parent section is assembled), the result
     is that the entry ends with the padding bytes, so may grow.
     If 'align-end' is not provided, no alignment is performed.
 
@@ -708,7 +708,7 @@ extend-size:
     entry.
 
 compress:
-    Sets the compression algortihm to use (for blobs only). See the entry
+    Sets the compression algorithm to use (for blobs only). See the entry
     documentation for details.
 
 missing-msg:
@@ -725,23 +725,23 @@ assume-size:
     size if requested.
 
 no-expanded:
-    By default binman substitutes entries with expanded versions if available,
+    By default, binman substitutes entries with expanded versions if available,
     so that a `u-boot` entry type turns into `u-boot-expanded`, for example. The
     `--no-expanded` command-line option disables this globally. The
     `no-expanded` property disables this just for a single entry. Put the
-    `no-expanded` boolean property in the node to select this behaviour.
+    `no-expanded` boolean property in the node to select this behavior.
 
 optional:
     External blobs are normally required to be present for the image to be
     built (but see `External blobs`_). This properly allows an entry to be
-    optional, so that when it is cannot be found, this problem is ignored and
+    optional, so that when it cannot be found, this problem is ignored and
     an empty file is used for this blob. This should be used only when the blob
     is entirely optional and is not needed for correct operation of the image.
     Note that missing, optional blobs do not produce a non-zero exit code from
     binman, although it does show a warning about the missing external blob.
 
 insert-template:
-    This is not strictly speaking an entry property, since it is processed early
+    This is not an entry property, since it is processed early
     in Binman before the entries are read. It is a list of phandles of nodes to
     include in the current (target) node. For each node, its subnodes and their
     properties are brought into the target node. See Templates_ below for
@@ -751,7 +751,7 @@ symbols-base:
     When writing symbols into a binary, the value of that symbol is assumed to
     be relative to the base address of the binary. This allow the binary to be
     loaded in memory at its base address, so that symbols point into the binary
-    correctly. In some cases the binary is in fact not yet in memory, but must
+    correctly. In some cases, the binary is in fact not yet in memory, but must
     be read from storage. In this case there is no base address for the symbols.
     This property can be set to 0 to indicate this. Other values for
     symbols-base are allowed, but care must be taken that the code which uses
@@ -759,14 +759,14 @@ symbols-base:
     address is used.
 
 The attributes supported for images and sections are described below. Several
-are similar to those for entries.
+of them are like the attributes for entries.
 
 size:
     Sets the image size in bytes, for example 'size = <0x100000>' for a
     1MB image.
 
 offset:
-    This is similar to 'offset' in entries, setting the offset of a section
+    This is like 'offset' in entries, setting the offset of a section
     within the image or section containing it. The first byte of the section
     is normally at offset 0. If 'offset' is not provided, binman sets it to
     the end of the previous region, or the start of the image's entry area
@@ -799,7 +799,7 @@ sort-by-offset:
     the 'offset' properties are set by CONFIG options, so their ordering is
     not known a priori.
 
-    This is a boolean property so needs no value. To enable it, add a
+    This is a boolean property, so it needs no value. To enable it, add a
     line 'sort-by-offset;' to your description.
 
 multiple-images:
@@ -842,7 +842,7 @@ skip-at-start:
     Image size != 4gb.
 
 align-default:
-    Specifies the default alignment for entries in this section, if they do
+    Specifies the default alignment for entries in this section if they do
     not specify an alignment. Note that this only applies to top-level entries
     in the section (direct subentries), not any subentries of those entries.
     This means that each section must specify its own default alignment, if
@@ -883,7 +883,7 @@ elf-base-sym:
     be read correctly. See binman_syms_ for more information.
 
 offset-from-elf:
-    Sets the offset of an entry based on a symbol value in an another entry.
+    Sets the offset of an entry based on a symbol value in another entry.
     The format is <&phandle>, "sym_name", <offset> where phandle is the entry
     containing the blob (with associated ELF file providing symbols), <sym_name>
     is the symbol to lookup (relative to elf-base-sym) and <offset> is an offset
@@ -894,7 +894,7 @@ preserve:
     flag should be checked by the updater when it is deciding which entries to
     update. This flag is normally attached to sections but can be attached to
     a single entry in a section if the updater supports it. Not that binman
-    itself has no control over the updater's behaviour, so this is just a
+    itself has no control over the updater's behavior, so this is just a
     signal. It is not enforced by binman.
 
 Examples of the above options can be found in the tests. See the
@@ -905,16 +905,16 @@ either by using a unit number suffix (u-boot@0, u-boot@1) or by using a
 different name for each and specifying the type with the 'type' attribute.
 
 
-Sections and hierachical images
+Sections and hierarchical images
 -------------------------------
 
 Sometimes it is convenient to split an image into several pieces, each of which
 contains its own set of binaries. An example is a flash device where part of
-the image is read-only and part is read-write. We can set up sections for each
+the image is read-only, and part is read-write. We can set up sections for each
 of these, and place binaries in them independently. The image is still produced
 as a single output file.
 
-This feature provides a way of creating hierarchical images. For example here
+This feature provides a way of creating hierarchical images. For example, here
 is an example image with two copies of U-Boot. One is read-only (ro), intended
 to be written only in the factory. Another is read-write (rw), so that it can be
 upgraded in the field. The sizes are fixed so that the ro/rw boundary is known
@@ -947,7 +947,7 @@ read-only:
 
 name-prefix:
     This string is prepended to all the names of the binaries in the
-    section. In the example above, the 'u-boot' binaries which actually be
+    section. In the example above, the 'u-boot' binaries which be
     renamed to 'ro-u-boot' and 'rw-u-boot'. This can be useful to
     distinguish binaries with otherwise identical names.
 
@@ -955,7 +955,7 @@ filename:
     This allows the contents of the section to be written to a file in the
     output directory. This can sometimes be useful to use the data in one
     section in different image, since there is currently no way to share data
-    beteen images other than through files.
+    between images other than through files.
 
 Image Properties
 ----------------
@@ -970,11 +970,11 @@ filename:
 allow-repack:
     Create an image that can be repacked. With this option it is possible
     to change anything in the image after it is created, including updating
-    the position and size of image components. By default this is not
-    permitted since it is not possibly to know whether this might violate a
-    constraint in the image description. For example, if a section has to
+    the position and size of image components. By default, this is not
+    permitted since it is not possible to know whether this might violate a
+    constraint in the image description. For example, if a section must
     increase in size to hold a larger binary, that might cause the section
-    to fall out of its allow region (e.g. read-only portion of flash).
+    to fall out of its allow-region (e.g. read-only portion of flash).
 
     Adding this property causes the original offset and size values in the
     image description to be stored in the FDT and fdtmap.
@@ -985,7 +985,7 @@ Image dependencies
 
 Binman does not currently support images that depend on each other. For example,
 if one image creates `fred.bin` and then the next uses this `fred.bin` to
-produce a final `image.bin`, then the behaviour is undefined. It may work, or it
+produce a final `image.bin`, then the behavior is undefined. It may work, or it
 may produce an error about `fred.bin` being missing, or it may use a version of
 `fred.bin` from a previous run.
 
@@ -1045,10 +1045,10 @@ value back to the device-tree node. For example::
 
 Here, a new 'value' property will be written to the 'hash' node containing
 the hash of the 'u-boot' entry. Only SHA256 is supported at present. Whole
-sections can be hased if desired, by adding the 'hash' node to the section.
+sections can be hashed if desired, by adding the 'hash' node to the section.
 
-The has value can be chcked at runtime by hashing the data actually read and
-comparing this has to the value in the device tree.
+The hash value can be checked at runtime by hashing the data read and
+comparing this hash to the value in the device-tree.
 
 
 Expanded entries
@@ -1078,14 +1078,14 @@ which in turn expands to::
         };
     };
 
-U-Boot's various phase binaries actually comprise two or three pieces.
-For example, u-boot.bin has the executable followed by a devicetree.
+U-Boot's phase binaries comprise two or three pieces. For example, u-boot.bin
+has the executable followed by a device-tree.
 
-With binman we want to be able to update that devicetree with full image
+With binman we want to be able to update that device-tree with full image
 information so that it is accessible to the executable. This is tricky
-if it is not clear where the devicetree starts.
+if it is not clear where the device-tree starts.
 
-The above feature ensures that the devicetree is clearly separated from the
+The above feature ensures that the device-tree is clearly separated from the
 U-Boot executable and can be updated separately by binman as needed. It can be
 disabled with the --no-expanded flag if required.
 
@@ -1117,11 +1117,11 @@ which in turn expands to::
         };
     };
 
-Of course we should not expand SPL if it has no devicetree. Also if the BSS
+Of course, we should not expand SPL if it has no device-tree. Also, if the BSS
 padding is not needed (because BSS is in RAM as with CONFIG_SPL_SEPARATE_BSS),
-the 'u-boot-spl-bss-pad' subnode should not be created. The use of the expaned
+the 'u-boot-spl-bss-pad' subnode should not be created. The use of the expanded
 entry type is controlled by the UseExpanded() method. In the SPL case it checks
-the 'spl-dtb' entry arg, which is 'y' or '1' if SPL has a devicetree.
+the 'spl-dtb' entry arg, which is 'y' or '1' if SPL has a device-tree.
 
 For the BSS case, a 'spl-bss-pad' entry arg controls whether it is present. All
 entry args are provided by the U-Boot Makefile.
@@ -1749,7 +1749,7 @@ Options:
 Options used only for testing:
 
 --fake-dtb
-    Use fake device tree contents
+    Use fake device-tree contents
 
 --fake-ext-blobs
     Create fake ext blobs with dummy content
@@ -1789,7 +1789,7 @@ Positional arguments:
 paths
     Paths within file to list (wildcard)
 
-Pptions:
+Options:
 
 -h, --help
     show help message and exit
@@ -1899,7 +1899,7 @@ Options:
 
 -P PROCESSES, --processes PROCESSES
     set number of processes to use for running tests. This defaults to the
-    number of CPUs on the machine
+    numbering the CPUs on the machine
 
 -T, --test-coverage
     run tests and check for 100% coverage
@@ -1974,13 +1974,13 @@ Image creation proceeds in the following order, for each entry in the image.
 1. AddMissingProperties() - binman can add calculated values to the device
 tree as part of its processing, for example the offset and size of each
 entry. This method adds any properties associated with this, expanding the
-device tree as needed. These properties can have placeholder values which are
-set later by SetCalculatedProperties(). By that stage the size of sections
+device-tree as needed. These properties can have placeholder values which are
+set later by SetCalculatedProperties(). By that stage, the size of sections
 cannot be changed (since it would cause the images to need to be repacked),
 but the correct values can be inserted.
 
-2. ProcessFdt() - process the device tree information as required by the
-particular entry. This may involve adding or deleting properties. If the
+2. ProcessFdt() - process the device-tree information as required by the
+entry. This may involve adding or deleting properties. If the
 processing is complete, this method should return True. If the processing
 cannot complete because it needs the ProcessFdt() method of another entry to
 run first, this method should return False, in which case it will be called
@@ -1989,7 +1989,7 @@ again later.
 3. GetEntryContents() - the contents of each entry are obtained, normally by
 reading from a file. This calls the Entry.ObtainContents() to read the
 contents. The default version of Entry.ObtainContents() calls
-Entry.GetDefaultFilename() and then reads that file. So a common mechanism
+Entry.GetDefaultFilename() and then reads that file. Thus, a common mechanism
 to select a file to read is to override that function in the subclass. The
 functions must return True when they have read the contents. Binman will
 retry calling the functions a few times if False is returned, allowing
@@ -2039,7 +2039,7 @@ what happens in this stage.
 11. BuildImage() - builds the image and writes it to a file
 
 12. WriteMap() - writes a text file containing a map of the image. This is the
-final step.
+last step.
 
 
 .. _`External tools`:
@@ -2049,14 +2049,14 @@ External tools
 
 Binman can make use of external command-line tools to handle processing of
 entry contents or to generate entry contents. These tools are executed using
-the 'tools' module's Run() method. The tools generally must exist on the PATH,
+the 'tools' module's Run() method. The tools must exist on the PATH,
 but the --toolpath option can be used to specify additional search paths to
 use. This option can be specified multiple times to add more than one path.
 
-For some compile tools binman will use the versions specified by commonly-used
+For some compile tools binman will use the versions specified by commonly used
 environment variables like CC and HOSTCC for the C compiler, based on whether
 the tool's output will be used for the target or for the host machine. If those
-aren't given, it will also try to derive target-specific versions from the
+are not given, it will also try to derive target-specific versions from the
 CROSS_COMPILE environment variable during a cross-compilation.
 
 If the tool is not available in the path you can use BINMAN_TOOLPATHS to specify
@@ -2077,7 +2077,7 @@ to build the final image, no matter what steps are needed to get there.
 
 Binman also provides a `blob-ext` entry type that pulls in a binary blob from an
 external file. If the file is missing, binman can optionally complete the build
-and just report a warning. Use the `-M/--allow-missing` option to enble this.
+and just report a warning. Use the `-M/--allow-missing` option to enable this.
 This is useful in CI systems which want to check that everything is correct but
 don't have access to the blobs.
 
@@ -2172,7 +2172,7 @@ symbol tells binman the size of the BSS region, in bytes. It needs this to be
 able to pad the image so that the following entries do not overlap the BSS,
 which would cause them to be overwritte by variable access in SPL.
 
-This symbols is normally defined in the linker script, immediately after
+These symbols are normally defined in the linker script, immediately after
 _bss_start and __bss_end are defined, like this::
 
     __bss_size = __bss_end - __bss_start;
@@ -2186,7 +2186,7 @@ Concurrent tests
 Binman tries to run tests concurrently. This means that the tests make use of
 all available CPUs to run.
 
- To enable this::
+ Enable this::
 
    $ sudo apt-get install python-subunit python3-subunit
 
@@ -2202,7 +2202,7 @@ See :doc:`../binman_tests`.
 Debugging tests
 ---------------
 
-Sometimes when debugging tests it is useful to keep the input and output
+Sometimes when debugging tests, it is useful to keep the input and output
 directories so they can be examined later. Use -X or --test-preserve-dirs for
 this.
 
@@ -2363,10 +2363,10 @@ blob can come from any suitable place, such as an `Entry_u_boot` or an
 
 The `soc-fw` node is a `blob-ext` (i.e. it reads in a named binary file) whereas
 `u-boot` is a normal entry type. This works because `Entry_fip` selects the
-`blob-ext` entry type if the node name (here `soc-fw`) is recognised as being
+`blob-ext` entry type if the node name (here `soc-fw`) is recognized as being
 a known blob type.
 
-When adding new entry types you are encouraged to use subnodes to provide the
+When adding new entry types, you are encouraged to use subnodes to provide the
 data for processing, unless the `content` approach is more suitable. Consider
 whether the input entries are contained within (or consumed by) the entry, vs
 just being 'referenced' by the entry. In the latter case, the `content` approach
@@ -2378,8 +2378,8 @@ History / Credits
 
 Binman takes a lot of inspiration from a Chrome OS tool called
 'cros_bundle_firmware', which I wrote some years ago. That tool was based on
-a reasonably simple and sound design but has expanded greatly over the
-years. In particular its handling of x86 images is convoluted.
+a simple and sound design but has expanded over the
+years. In particular, its handling of x86 images is convoluted.
 
 Quite a few lessons have been learned which are hopefully applied here.
 
@@ -2387,11 +2387,11 @@ Quite a few lessons have been learned which are hopefully applied here.
 Design notes
 ------------
 
-On the face of it, a tool to create firmware images should be fairly simple:
+On the face of it, a tool to create firmware images should be simple:
 just find all the input binaries and place them at the right place in the
 image. The difficulty comes from the wide variety of input types (simple
 flat binaries containing code, packaged data with various headers), packing
-requirments (alignment, spacing, device boundaries) and other required
+requirements (alignment, spacing, device boundaries) and other required
 features such as hierarchical images.
 
 The design challenge is to make it easy to create simple images, while
@@ -2409,7 +2409,7 @@ To do
 Some ideas:
 
 - Use of-platdata to make the information available to code that is unable
-  to use device tree (such as a very small SPL image). For now, limited info is
+  to use device-tree (such as a small SPL image). For now, limited info is
   available via linker symbols
 - Allow easy building of images by specifying just the board name
 - Support building an image for a board (-b) more completely, with a
@@ -2417,7 +2417,7 @@ Some ideas:
 - Detect invalid properties in nodes
 - Sort the fdtmap by offset
 - Output temporary files to a different directory
-- Rationalise the fdt, fdt_util and pylibfdt modules which currently have some
+- Rationalize the fdt, fdt_util and pylibfdt modules which currently have some
   overlapping and confusing functionality
 - Update the fdt library to use a better format for Prop.value (the current one
   is useful for dtoc but not much else)
-- 
2.39.2

