Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27ABC46CD2
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 06:13:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 117EB876F8;
	Fri, 22 Dec 2023 07:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LberaMXs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3447787845; Fri, 22 Dec 2023 07:13:12 +0100 (CET)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C85987830
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 07:13:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6d98f6e8de1so17001b3a.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 22:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703225586; x=1703830386; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/YVRIQq32pYck6P/1/Tfv6F8JFsDepHqPB/35AbgzKE=;
 b=LberaMXsTbp0EnbLyuB0pnSDCEtXGlN9FQb+dcBYLtOiTDUZV0SgOHcbWi3rbavDui
 GdKbxtpVgPlttLntta7o992pPROJTmC3fFxoEgjCT3agljLeGaAV/l+KyqStaHA9VoN4
 qBj9IhUJc8kHVXGu9U1TuF7lYUJSyigqDQNyH0Zcb/EbX84zZni6Z93SjKvXvDXNkLvs
 Vv9fqLbjdNuhi80hWn5xp+IufH1sdBndHlB3T3Y7+p/xfRql18KK86YPJ8T10stlFGWP
 ZCf6SeVdDeqTJ7U2LIZBapduKelwwSbB5NFxsTVjlTc9aS/f/8UW6zieou3QxzZd4gPJ
 rWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703225586; x=1703830386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/YVRIQq32pYck6P/1/Tfv6F8JFsDepHqPB/35AbgzKE=;
 b=Dso+hutTimCuzw6acHKNfeKS4eLb1uLogcZFL6RZa10TLKUjWA3+SKg5dvPo1QrEXL
 ZphhQdiU+/opiT3/WumV6YCi/5jFjKT4lsm5qLFomZpYDUaarzYxiVtnYHkTtfKUpAos
 veTepo4HhY8Zq1lw0FuznnFS4mQDMsZNHW1j1clnjxCWTP4GEgbA/PPhBA46hPI6BZaX
 z5SoiFRxfYz1A24zBaVJnEj6O5ItBYIebnxaxTpDS675WiKJ4+pPGzH9TnWu86I6T41D
 oejv+iY+6xlSiJ0K1ZBTGzTGagt6oQ4FwGq+PsDvnXe/xQb1WhHkhRmoiDfw9N0ZLPWO
 EtXg==
X-Gm-Message-State: AOJu0YzZoamWxl/EoGuNgfcCCZNm+OHH/Jja9z2rgKhzQx/SS4I0+aWd
 6rzd0HjiaFkPPPPyI4JdTZ7rWVDq8EnD80VoDgkYsj6h3xL1IQ==
X-Google-Smtp-Source: AGHT+IG9+eS/3PBKAfzpirt1Yc9LMbXCAlCudKOZz3g5hF0B/WevOx5a0NWt15n8sA3IG1o9CrwQkA==
X-Received: by 2002:a62:e809:0:b0:6d9:9058:1a7e with SMTP id
 c9-20020a62e809000000b006d990581a7emr14658pfi.66.1703225585542; 
 Thu, 21 Dec 2023 22:13:05 -0800 (PST)
Received: from sumit-X1.. ([223.178.212.219]) by smtp.gmail.com with ESMTPSA id
 h6-20020aa79f46000000b006ce835b77d9sm2602883pfr.20.2023.12.21.22.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 22:13:05 -0800 (PST)
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
Subject: [PATCH v2 5/8] doc: devicetree: Updates for devicetree-rebasing
 subtree
Date: Fri, 22 Dec 2023 11:42:05 +0530
Message-Id: <20231222061208.3009970-6-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231222061208.3009970-1-sumit.garg@linaro.org>
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
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
index cbb65c9b177..7c15f6d8c19 100644
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
+The U-Boot Makefile infrastructure allows for building the devicetree blob
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
@@ -81,18 +94,21 @@ Failing that, you could write one from scratch yourself!
 Configuration
 -------------
 
-Use::
+Traditionally, U-Boot placed copies of devicetree source files from Linux
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
+This should include your CPU or SOC's devicetree file. On top of that any U-Boot
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

