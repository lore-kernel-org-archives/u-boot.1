Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789F1C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 11:59:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ECFF86E7E;
	Thu, 28 Dec 2023 12:59:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PqcKnigv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42FDB87A22; Thu, 28 Dec 2023 12:59:14 +0100 (CET)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 649A387A11
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 12:59:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6d9b267007fso1077346b3a.3
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 03:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703764747; x=1704369547; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9fnRfxkxSsxcAEkG5fxcSAf+mHYUbmMIqsTErXyQnw4=;
 b=PqcKnigv8uLGphMSIRAwH8X5GsXoBnwsopTR46DWXF9EnBkCO8z6r36gvgNVRwubcx
 W5Bcc6SRZik72mRK9N7mCNG4uknxSZARSYYbC/UrMd4iGVlSCBvKpYY0pkO9B2Q54J1J
 x73W+hb5BuG/Ypf8BWHuEelaR+biYHDGPZ1prY2zD0UweAYQBusAY3rXodsRBLW4paSh
 h3GrfhfyNsbGk5eDAfPuKlYSlinjcqD0cZNJSPHMuK8ppOApun6rks4Wcb8qJIHl1THm
 hJxvVKLEUgkbMhPZZvguET6lSrWYspuQ+YfXi225ijEzQh19WQMBb4sLGAiiNQEtmIvj
 AEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703764747; x=1704369547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9fnRfxkxSsxcAEkG5fxcSAf+mHYUbmMIqsTErXyQnw4=;
 b=fKiH0yVSdf8JQLlXYLW7wq+ZeBfWpekBEh3Km1IHt0ajz9vimc+Fn7uAkuEHRIKKEC
 Nt/xwvQtz9H7creqT0MiXhHOOVz3R1Em8MVMI+lh11/VVd+BAVrol4CrHoKFy1mG0d1w
 kMTNhvuD2xyYjW6rv/ouIRF7iwLB1Jv0kwW0cGA1Dn327QEW6oKxrtT9dVQXnB9jvhsx
 CxerO/0zjzRjWqayQfFuLaN2rv1WYeLlI9f/MlY4wSCfrxLVmGlXOo0q4T5KR7QY9cXE
 0lw7R6fbIi/UsksH6vC9W/Vd/o64TNx3pRUMlZYyzugYyHJNRh9AlWs2lehnTV0V0viF
 3LOA==
X-Gm-Message-State: AOJu0YwlokS1tUXlmWCmARFlQEZ0mAQC8jZTbK9gQ8Yp9xIlG9tq7IUm
 P8ISIihL1HQeocFxoZkruY8HG+1gAm/IVA/bTZItcfsrmvdTEA==
X-Google-Smtp-Source: AGHT+IE2EiVGl8Gd3U4Ly2pBoAcHSEHxNu5+kP2lpO8CluEAWqklRBuKUYSUg5Obr3LJgGcV4xHewg==
X-Received: by 2002:a05:6a20:bb1d:b0:195:34a:2089 with SMTP id
 fc29-20020a056a20bb1d00b00195034a2089mr4746986pzb.9.1703764747457; 
 Thu, 28 Dec 2023 03:59:07 -0800 (PST)
Received: from sumit-X1.. ([223.178.209.202]) by smtp.gmail.com with ESMTPSA id
 r4-20020a170902ea4400b001d3f285157dsm13700579plg.124.2023.12.28.03.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 03:59:07 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org,
 b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com,
 seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com,
 jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de,
 mibodhi@gmail.com, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 5/8] doc: devicetree: Updates for devicetree-rebasing
 subtree
Date: Thu, 28 Dec 2023 17:28:01 +0530
Message-Id: <20231228115804.3626579-6-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231228115804.3626579-1-sumit.garg@linaro.org>
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
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

Encourage SoC/board maintainers to migrate to using devicetree-rebasing
subtree and maintain a regular sync with Linux kernel devicetree files
and bindings.

Along with that add documentation regarding how to run DT bindings
schema checks.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v3:
--------------
- Replace CONFIG_* with Kconfig options

Changes in v2:
--------------
- s/U-boot/U-Boot/

 doc/develop/devicetree/control.rst | 131 +++++++++++++++++++++--------
 1 file changed, 96 insertions(+), 35 deletions(-)

diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index cbb65c9b177..65180d33e8d 100644
--- a/doc/develop/devicetree/control.rst
+++ b/doc/develop/devicetree/control.rst
@@ -1,5 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0+
 .. sectionauthor:: Copyright 2011 The Chromium OS Authors
+.. Copyright 2023 Linaro Ltd.
 
 Devicetree Control in U-Boot
 ============================
@@ -22,14 +23,13 @@ for three reasons:
   hierarchical format
 - It is fairly efficient to read incrementally
 
-The arch/<arch>/dts directories contains a Makefile for building the devicetree
-blob and embedding it in the U-Boot image. This is useful since it allows
-U-Boot to configure itself according to what it finds there. If you have
-a number of similar boards with different peripherals, you can describe
-the features of each board in the devicetree file, and have a single
-generic source base.
+The U-Boot Makefile infrastructure allows for building the devicetree blob
+and embedding it in the U-Boot image. This is useful since it allows U-Boot
+to configure itself according to what it finds there. If you have a number
+of similar boards with different peripherals, you can describe the features
+of each board in the devicetree file, and have a single generic source base.
 
-To enable this feature, add CONFIG_OF_CONTROL to your board config file.
+To enable this feature, select `OF_CONTROL` via Kconfig.
 
 
 What is a Flattened Devicetree?
@@ -68,8 +68,21 @@ a binary file. U-Boot adds its own `fdtgrep` for creating subsets of the file.
 Where do I get a devicetree file for my board?
 ----------------------------------------------
 
-You may find that the Linux kernel has a suitable file. Look in the
-kernel source in arch/<arch>/boot/dts.
+Linux kernel Git repository has been the place where devicetree files along
+with devicetree bindings are stored and maintained. There is devicetee-rebasing
+(dtrepo_) which maintains a forked copy of devicetree files along with bindings
+at every Linux kernel major release or intermideate release candidates.
+
+In order to maintain devicetree files sync, U-Boot maintains a Git subtree for
+devicetee-rebasing repo as `devicetee-rebasing/` sub-directory. It is regularly
+kept updated with every new kernel major release via subtree pull as follows::
+
+    git subtree pull --prefix devicetree-rebasing \
+        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
+        <release-tag> --squash
+
+You may find that the `devicetee-rebasing/` sub-directory has a suitable
+devicetree file for your board. Look in `devicetree-rebasing/src/<arch>/`.
 
 If not you might find other boards with suitable files that you can
 modify to your needs. Look in the board directories for files with a
@@ -81,34 +94,34 @@ Failing that, you could write one from scratch yourself!
 Configuration
 -------------
 
-Use::
+Traditionally, U-Boot placed copies of devicetree source files from Linux
+kernel into `arch/<arch>/dts/<name>.dts` which can be selected via setting
+"<name>" when prompted for `DEFAULT_DEVICE_TREE` by Kconfig.
 
-   #define CONFIG_DEFAULT_DEVICE_TREE	"<name>"
+However, it has become combersome over time for each SoC/board maintainer to
+keep devicetree files in sync with Linux kernel. Thereby, SoC/board maintainers
+are encouraged to migrate to use mirrored copies from `devicetree-rebasing/`
+into `dts/arch/<arch>/<vendor>`. To do that enable `OF_UPSTREAM` via Kconfig and
+set up "<vendor>/<name>" when prompted for `DEFAULT_DEVICE_TREE` by Kconfig.
 
-to set the filename of the devicetree source. Then put your devicetree
-file into::
+This should include your CPU or SOC's devicetree file. On top of that any U-Boot
+specific tweaks (see: dttweaks_) can be made for your board.
 
-   arch/<arch>/dts/<name>.dts
-
-This should include your CPU or SOC's devicetree file, placed in
-`arch/<arch>/dts`, and then make any adjustments required using a u-boot-dtsi
-file for your board.
-
-If CONFIG_OF_EMBED is defined, then it will be picked up and built into
+If `OF_EMBED` is selected by Kconfig, then it will be picked up and built into
 the U-Boot image (including u-boot.bin). This is suitable for debugging
 and development only and is not recommended for production devices.
 
-If CONFIG_OF_SEPARATE is defined, then it will be built and placed in
+If `OF_SEPARATE` is selected by Kconfig, then it will be built and placed in
 a u-boot.dtb file alongside u-boot-nodtb.bin with the combined result placed
-in u-boot.bin so you can still just flash u-boot.bin onto your board. If you are
-using CONFIG_SPL_FRAMEWORK, then u-boot.img will be built to include the device
-tree binary.
+in u-boot.bin so you can still just flash u-boot.bin onto your board. If Kconfig
+option `SPL_FRAMEWORK` is enabled, then u-boot.img will be built to include the
+device tree binary.
 
-If CONFIG_OF_BOARD is defined, a board-specific routine will provide the
+If `OF_BOARD` is selected by Kconfig, a board-specific routine will provide the
 devicetree at runtime, for example if an earlier bootloader stage creates
 it and passes it to U-Boot.
 
-If CONFIG_SANDBOX is defined, then it will be read from a file on
+If `SANDBOX` is selected by Kconfig, then it will be read from a file on
 startup. Use the -d flag to U-Boot to specify the file to read, -D for the
 default and -T for the test devicetree, used to run sandbox unit tests.
 
@@ -142,7 +155,7 @@ Build:
 After the board configuration is done, fdt supported u-boot can be built in two
 ways:
 
-#  build the default dts which is defined from CONFIG_DEFAULT_DEVICE_TREE::
+#  build the default dts which is selected by DEFAULT_DEVICE_TREE Kconfig::
 
     $ make
 
@@ -156,8 +169,9 @@ ways:
 Adding tweaks for U-Boot
 ------------------------
 
-It is strongly recommended that devicetree files in U-Boot are an exact copy of
-those in Linux, so that it is easy to sync them up from time to time.
+With devicetee-rebasing Git subtree, it is ensured that devicetree files in
+U-Boot are an exact copy of those in Linux kernel via mirroring into
+`dts/arch/<arch>/<vendor>`.
 
 U-Boot is of course a very different project from Linux, e.g. it operates under
 much more restrictive memory and code-size constraints. Where Linux may use a
@@ -170,8 +184,8 @@ constraints are even more extreme and the devicetree is shrunk to remove
 unwanted nodes, or even turned into C code to avoid access overhead.
 
 U-Boot automatically looks for and includes a file with updates to the standard
-devicetree for your board, searching for them in the same directory as the
-main file, in this order::
+devicetree for your board, searching for them in `arch/<arch>/dts/` in this
+order::
 
    <orig_filename>-u-boot.dtsi
    <CONFIG_SYS_SOC>-u-boot.dtsi
@@ -195,11 +209,57 @@ As mentioned above, the U-Boot build system automatically includes a
 `*-u-boot.dtsi` file, if found, containing U-Boot specific
 quirks. However, some data, such as the mentioned public keys, are not
 appropriate for upstream U-Boot but are better kept and maintained
-outside the U-Boot repository. You can use CONFIG_DEVICE_TREE_INCLUDES
-to specify a list of .dtsi files that will also be included when
+outside the U-Boot repository. You can use `DEVICE_TREE_INCLUDES` Kconfig
+option to specify a list of .dtsi files that will also be included when
 building .dtb files.
 
 
+Devicetree bindings schema checks
+---------------------------------
+
+With devicetee-rebasing Git subtree, the devicetree bindings are also regularly
+synced with Linux kernel as `devicetree-rebasing/Bindings/` sub-directory. This
+allows U-Boot to run devicetree bindings schema checks which will bring
+compliance to U-Boot core/drivers regarding usage of devicetree.
+
+Dependencies
+~~~~~~~~~~~~
+
+The DT schema project must be installed in order to validate the DT schema
+binding documents and validate DTS files using the DT schema. The DT schema
+project can be installed with pip::
+
+    pip3 install dtschema
+
+Note that 'dtschema' installation requires 'swig' and Python development files
+installed first. On Debian/Ubuntu systems::
+
+    apt install swig python3-dev
+
+Several executables (dt-doc-validate, dt-mk-schema, dt-validate) will be
+installed. Ensure they are in your PATH (~/.local/bin by default).
+
+Recommended is also to install yamllint (used by dtschema when present).
+
+Running checks
+~~~~~~~~~~~~~~
+
+In order to perform validation of DTB files, use the ``dtbs_check`` target::
+
+    make dtbs_check
+
+It is also possible to run checks with a subset of matching schema files by
+setting the ``DT_SCHEMA_FILES`` variable to 1 or more specific schema files or
+patterns (partial match of a fixed string). Each file or pattern should be
+separated by ':'.
+
+::
+
+    make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml:rtc.yaml
+    make dtbs_check DT_SCHEMA_FILES=/gpio/
+    make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml
+
+
 Relocation, SPL and TPL
 -----------------------
 
@@ -261,8 +321,9 @@ used it before Linux (e.g. snow). The two projects developed in parallel
 and there are still some differences in the bindings for certain boards.
 While there has been discussion of having a separate repository for devicetree
 files, in practice the Linux kernel Git repository has become the place where
-these are stored, with U-Boot taking copies and adding tweaks with u-boot.dtsi
-files.
+these are stored, with U-Boot taking copies via devicetree-rebasing repo
+(see: dtrepo_) and adding tweaks with u-boot.dtsi files.
 
 .. _dtspec: https://www.devicetree.org/specifications/
 .. _dtlist: https://www.spinics.net/lists/devicetree-compiler/
+.. _dtrepo: https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
-- 
2.34.1

