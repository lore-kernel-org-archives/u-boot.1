Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79ABAC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 13:52:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 737B887A97;
	Thu, 14 Dec 2023 14:52:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sr1ePytq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C402A87A9C; Thu, 14 Dec 2023 14:52:25 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50D5F87A91
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 14:52:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d367494c96so2317445ad.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 05:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702561935; x=1703166735; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tZ0RqhubyDUCF2xX96gajzIW8IB+xNdVb3GHMNv714o=;
 b=sr1ePytqv1Bj8RQwqhHOHe2oatRXVJOCikJwrU3KjQHLvFF4uW21O7+JADnBAPLwS1
 5E5I/Tyx486NXhnbKLovgj0PQ/XCd5dltmNGu3UlLboJCJDRhFHxkj9bidGrF4+VVpRq
 2DN9kkQWeH50lt4/yoguQrRKKptoNGpiqAqH19SuI5hC3SCFHCGiV/AXwuMsjT1/DKLa
 WkM+AXYzohPw9+rkhNKbkXgZab7dwK81gFXr3tMCYwwcwbEf1TiVUG5HoNOpVMMZNjH4
 zcsctApY1yUoc3yDUMSipnI53UlC/rFrvazk7qX+xewROqAhz6CRnSIr8TOPlYXj/td/
 3WyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702561935; x=1703166735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tZ0RqhubyDUCF2xX96gajzIW8IB+xNdVb3GHMNv714o=;
 b=h+pDIjO/pk6jUlpo6G6rm+DLWuqb1uRuuX/jkGi/HgdHV2Q1RwvAy3nKHEEuAiwyww
 POD2CE1dgq/o0IzTxOTHIg8eOAs6n9ItY9qwHtyabyxZwEJ7Doje6aiXJwgs/PiBj5sv
 iIq1TFLmvGU+O3TOaTALnAju065zQla4OSna8KLQiAZ3fiVKrN5R1IkwtpRTEeYASntP
 VO6Yh67OoN+tXl4vQQGdEBOFKjrWkkwR2yTmToIXU+liw6VVZFgV10kyiZMuVDnWGSn1
 Xting/6Ou2MRGJyrr8ZYCyTvD3Goxj87AMrQm6dYrWhw9on7Fe4OjmBVRz2pupeixs2A
 wYcQ==
X-Gm-Message-State: AOJu0Yxa3m+goFKQC/+OhIs4wX/7BYo9OxqfpCJh34JtESX5G27ilxXz
 YlwD3pCHp44t7nZq3C8Ll0IAtDzmGtn6m5pgLLkWlA==
X-Google-Smtp-Source: AGHT+IGuD46A0H3yR3NVn91fsG2CSkjp2uFqtVWlSesA+6d3SsNpi+QkRTP8hihFkikl4YHqT1oFJw==
X-Received: by 2002:a17:903:189:b0:1d2:ffba:2d47 with SMTP id
 z9-20020a170903018900b001d2ffba2d47mr5376455plg.77.1702561935434; 
 Thu, 14 Dec 2023 05:52:15 -0800 (PST)
Received: from sumit-X1.. ([223.178.213.6]) by smtp.gmail.com with ESMTPSA id
 j3-20020a170902c08300b001cfc68125desm12474956pld.203.2023.12.14.05.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 05:52:15 -0800 (PST)
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
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 5/8] doc: devicetree: Updates for devicetree-rebasing subtree
Date: Thu, 14 Dec 2023 19:21:00 +0530
Message-Id: <20231214135103.1606605-6-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214135103.1606605-1-sumit.garg@linaro.org>
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
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
 doc/develop/devicetree/control.rst | 108 +++++++++++++++++++++++------
 1 file changed, 86 insertions(+), 22 deletions(-)

diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index cbb65c9b177..12ef55ed368 100644
--- a/doc/develop/devicetree/control.rst
+++ b/doc/develop/devicetree/control.rst
@@ -1,5 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0+
 .. sectionauthor:: Copyright 2011 The Chromium OS Authors
+.. Copyright 2023 Linaro Ltd.
 
 Devicetree Control in U-Boot
 ============================
@@ -22,12 +23,11 @@ for three reasons:
   hierarchical format
 - It is fairly efficient to read incrementally
 
-The arch/<arch>/dts directories contains a Makefile for building the devicetree
-blob and embedding it in the U-Boot image. This is useful since it allows
-U-Boot to configure itself according to what it finds there. If you have
-a number of similar boards with different peripherals, you can describe
-the features of each board in the devicetree file, and have a single
-generic source base.
+The U-boot Makefile infrastructure allows for building the devicetree blob
+and embedding it in the U-Boot image. This is useful since it allows U-Boot
+to configure itself according to what it finds there. If you have a number
+of similar boards with different peripherals, you can describe the features
+of each board in the devicetree file, and have a single generic source base.
 
 To enable this feature, add CONFIG_OF_CONTROL to your board config file.
 
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
+In order to maintain devicetree files sync, U-boot maintains a Git subtree for
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
@@ -81,18 +94,21 @@ Failing that, you could write one from scratch yourself!
 Configuration
 -------------
 
-Use::
+Traditionally, U-boot placed copies of devicetree source files from Linux
+kernel into `arch/<arch>/dts/<name>.dts` which can be selected via::
 
-   #define CONFIG_DEFAULT_DEVICE_TREE	"<name>"
+    #define CONFIG_DEFAULT_DEVICE_TREE	"<name>"
 
-to set the filename of the devicetree source. Then put your devicetree
-file into::
+However, it has become combersome over time for each SoC/board maintainer to
+keep devicetree files in sync with Linux kernel. Thereby, SoC/board maintainers
+are encouraged to migrate to use mirrored copies from `devicetree-rebasing/`
+into `dts/arch/<arch>/<vendor>` via::
 
-   arch/<arch>/dts/<name>.dts
+    #define CONFIG_OF_UPSTREAM=y
+    #define CONFIG_DEFAULT_DEVICE_TREE	"<vendor>/<name>"
 
-This should include your CPU or SOC's devicetree file, placed in
-`arch/<arch>/dts`, and then make any adjustments required using a u-boot-dtsi
-file for your board.
+This should include your CPU or SOC's devicetree file. On top of that any U-boot
+specific tweaks (see: dttweaks_) can be made for your board.
 
 If CONFIG_OF_EMBED is defined, then it will be picked up and built into
 the U-Boot image (including u-boot.bin). This is suitable for debugging
@@ -156,8 +172,9 @@ ways:
 Adding tweaks for U-Boot
 ------------------------
 
-It is strongly recommended that devicetree files in U-Boot are an exact copy of
-those in Linux, so that it is easy to sync them up from time to time.
+With devicetee-rebasing Git subtree, it is ensured that devicetree files in
+U-Boot are an exact copy of those in Linux kernel via mirroring into
+`dts/arch/<arch>/<vendor>`.
 
 U-Boot is of course a very different project from Linux, e.g. it operates under
 much more restrictive memory and code-size constraints. Where Linux may use a
@@ -170,8 +187,8 @@ constraints are even more extreme and the devicetree is shrunk to remove
 unwanted nodes, or even turned into C code to avoid access overhead.
 
 U-Boot automatically looks for and includes a file with updates to the standard
-devicetree for your board, searching for them in the same directory as the
-main file, in this order::
+devicetree for your board, searching for them in `arch/<arch>/dts/` in this
+order::
 
    <orig_filename>-u-boot.dtsi
    <CONFIG_SYS_SOC>-u-boot.dtsi
@@ -200,6 +217,52 @@ to specify a list of .dtsi files that will also be included when
 building .dtb files.
 
 
+Devicetree bindings schema checks
+---------------------------------
+
+With devicetee-rebasing Git subtree, the devicetree bindings are also regularly
+synced with Linux kernel as `devicetree-rebasing/Bindings/` sub-directory. This
+allows U-boot to run devicetree bindings schema checks which will bring
+compliance to U-boot core/drivers regarding usage of devicetree.
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
 
@@ -261,8 +324,9 @@ used it before Linux (e.g. snow). The two projects developed in parallel
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

