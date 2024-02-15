Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68C5C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 21:10:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E69B87E01;
	Thu, 15 Feb 2024 22:10:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tatvixqq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E921E87DC7; Thu, 15 Feb 2024 22:10:35 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56AB587E22
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 22:10:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-607aafb2cb4so467447b3.0
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 13:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708031429; x=1708636229; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qo/a/jU6oKk9kDWM0cM5CWKPBMaXTbIuoKw8/l+Jbis=;
 b=tatvixqq7ZhtEZTQbE/KoJX3ImmUWE6LCj0CDKnhsBUlHgQVwAxaWeQy5NtTFDRBGl
 VvIcWDs/LZm8xTd1SAx6S2UAOluCRHneSrzuUtgnbf6J/HVgPuIWcz/mYfUu4bwLLSaJ
 ujHzylk8kRZMQHdC8NTZhUvkeNXDz58xUp8og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708031429; x=1708636229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qo/a/jU6oKk9kDWM0cM5CWKPBMaXTbIuoKw8/l+Jbis=;
 b=BgYeQawcm/i8xQzxowb3LtXZ2cV0rn2oYWFsP6zMo+QiqQPQLVeLP8VifvVSch3FNQ
 GrtBPHsJR12uUsV4JYabq3HS6wtqKlWIj0eR+OLxImvkB5dfhNeCRDCwsg1V/OQbRkUJ
 7jDaJnoCYptpKC1PRowIGB9pPdoU7vBr2F68JMM9CJB6yaPd1ds3xp7moQnZASFLdSU6
 Om4tDL/TSQZShJCBGTGDYBU+PSHWZhGXAnDm7tQ2ArKFRzZSoIKj/WM/rTclvhc3eZdU
 eKOCtMAjzTdUexFt7ol16+ym7JSeFnXqeEReTX/VOOKpDlRdvqbVwuMw1FNtwxPBR37d
 3U/Q==
X-Gm-Message-State: AOJu0YyB3XtYlksguCOM3aW2MOMelM/6VseXJ6xUn2P42g7CSz9Db4ad
 efl019u0YmOFUj5WdtEK7rQ+2uE6Pxl0NbCbpNho8GVuGBMk7AjbxOple7FuAJ3EjPt2t8Kg7Se
 1
X-Google-Smtp-Source: AGHT+IGS1EWNNZwm834yJ9o5G5gWLFZI8OayxzrXoJN88mkxPNQlxTWwY1x/ELZsCXdA1ueRGnMxkQ==
X-Received: by 2002:a81:9b02:0:b0:607:9613:2afa with SMTP id
 s2-20020a819b02000000b0060796132afamr2916119ywg.0.1708031428763; 
 Thu, 15 Feb 2024 13:10:28 -0800 (PST)
Received: from bill-the-cat.. (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 w84-20020a817b57000000b006077c89b001sm45484ywc.83.2024.02.15.13.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 13:10:27 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 2/2] doc: Rework the gcc section to reflect general build
 instructions
Date: Thu, 15 Feb 2024 16:10:25 -0500
Message-Id: <20240215211025.690964-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215211025.690964-1-trini@konsulko.com>
References: <20240215211025.690964-1-trini@konsulko.com>
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

The first big issue is that the "gcc" file talked a lot about the
general build requirements as well, but was titled in a gcc-centric
manner. Solve this by renaming the file to compile.rst and more fully
reflecting that it is general build instructions. Next, add a section
about the prebuilt toolchains that are recommended (as they are the ones
we use in CI), and update a few places to reference these vendor-neutral
tools.

Next, we can include the reproducible builds section directly in the
compile instructions rather than as a small standalone file.

Finally, we update the sandbox document to reflect both the name change
as well as what is specifically required to build sandbox.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 doc/arch/sandbox/sandbox.rst       |  5 ++-
 doc/build/{gcc.rst => compile.rst} | 64 ++++++++++++++++++++++++++----
 doc/build/index.rst                |  3 +-
 doc/build/reproducible.rst         | 27 -------------
 4 files changed, 61 insertions(+), 38 deletions(-)
 rename doc/build/{gcc.rst => compile.rst} (73%)
 delete mode 100644 doc/build/reproducible.rst

diff --git a/doc/arch/sandbox/sandbox.rst b/doc/arch/sandbox/sandbox.rst
index 5f8db126657f..f2ed5a25c115 100644
--- a/doc/arch/sandbox/sandbox.rst
+++ b/doc/arch/sandbox/sandbox.rst
@@ -39,11 +39,12 @@ integers can only be built on 64-bit hosts.
 
 Note that standalone/API support is not available at present.
 
-
 Prerequisites
 -------------
 
-Install the dependencies noted in :doc:`../../build/gcc`.
+In addition to the normal dependencies shows in the :doc:`general build
+instructions <../../build/compile>` to enable display support SDL2 libraries
+need to be available.
 
 
 Basic Operation
diff --git a/doc/build/gcc.rst b/doc/build/compile.rst
similarity index 73%
rename from doc/build/gcc.rst
rename to doc/build/compile.rst
index 3c6465772729..ef9c8545835a 100644
--- a/doc/build/gcc.rst
+++ b/doc/build/compile.rst
@@ -1,11 +1,19 @@
-Building with GCC
-=================
+Building U-Boot
+===============
 
 Dependencies
 ------------
 
-For building U-Boot you need a GCC compiler for your host platform. If you
-are not building on the target platform you further need  a GCC cross compiler.
+For building U-Boot you need the general build tools such as `make` and a C
+compiler for your host platform. Next, if you are not building on the same
+architecture as the target platform you further need a C cross compiler.
+Furthermore, some target platforms require additional host tools to be present
+and their package names may vary slightly dependinng on the naming scheme used
+by a particular host OS.
+
+In general, GCC should be used for both the host and target C compiler. Using
+:doc:`clang <clang>` is supported but please see the documented issues for it as
+well.
 
 Debian based
 ~~~~~~~~~~~~
@@ -69,6 +77,17 @@ Depending on the build target further packages may be needed:
 * riscv64 S-mode targets: opensbi
 * some arm64 targets: arm-trusted-firmware
 
+Prebuilt
+~~~~~~~~
+
+Another option, which the project uses for CI for example, is to use a prebuilt
+toolchain. For the most part, we use the latest `kernel.org`_ prebuit binaries,
+but there are a few architectures that require their own specific toolchains
+still.
+
+In general, examples found within the documentation here refer to the tools
+found here and exceptions will be noted where relevant.
+
 Prerequisites
 -------------
 
@@ -112,11 +131,11 @@ command line or export it beforehand.
 
     CROSS_COMPILE=<compiler-prefix> make
 
-Assuming cross compiling on Debian for ARMv8 this would be
+Assuming cross compiling for ARMv8 this would be
 
 .. code-block:: bash
 
-    CROSS_COMPILE=aarch64-linux-gnu- make
+    CROSS_COMPILE=aarch64-linux- make
 
 Build parameters
 ~~~~~~~~~~~~~~~~
@@ -131,13 +150,40 @@ You can speed up compilation by parallelization using the -j parameter, e.g.
 
 .. code-block:: bash
 
-    CROSS_COMPILE=aarch64-linux-gnu- make -j$(nproc)
+    CROSS_COMPILE=aarch64-linux- make -j$(nproc)
 
 Further important build parameters are
 
 * O=<dir> - generate all output files in directory <dir>, including .config
 * V=1 - verbose build
 
+
+Reproducible builds
+~~~~~~~~~~~~~~~~~~~
+
+In order to achieve reproducible builds, timestamps used in the U-Boot build
+process have to be set to a fixed value.
+
+This is done using the SOURCE_DATE_EPOCH environment variable which specifies
+the number of seconds since 1970-01-01T00:00:00Z.
+
+
+To build the sandbox with 2023-01-01T00:00:00Z as timestamp we can use:
+
+.. code-block:: bash
+
+    make sandbox_defconfig
+    SOURCE_DATE_EPOCH=1672531200 make
+
+This date is shown when we launch U-Boot:
+
+.. code-block:: console
+
+    ./u-boot -T
+    U-Boot 2023.01 (Jan 01 2023 - 00:00:00 +0000)
+
+The same effect can be obtained with buildman using the `-r` flag.
+
 Devicetree compiler
 ~~~~~~~~~~~~~~~~~~~
 
@@ -176,6 +222,8 @@ builds during development, you can disable it by setting `NO_LTO` to `1`.
 
     NO_LTO=1 make
 
+Note that not all platforms which enable LTO support disabling it however.
+
 Other build targets
 ~~~~~~~~~~~~~~~~~~~
 
@@ -195,3 +243,5 @@ Installation
 
 The process for installing U-Boot on the target device is device specific.
 Please, refer to the board specific documentation :doc:`../board/index`.
+
+.. _`kernel.org`: https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/
diff --git a/doc/build/index.rst b/doc/build/index.rst
index 7a4507b57461..5262b4f3c1b9 100644
--- a/doc/build/index.rst
+++ b/doc/build/index.rst
@@ -7,9 +7,8 @@ Build U-Boot
    :maxdepth: 2
 
    source
-   gcc
+   compile
    clang
-   reproducible
    docker
    tools
    buildman
diff --git a/doc/build/reproducible.rst b/doc/build/reproducible.rst
deleted file mode 100644
index 8b030f469d7c..000000000000
--- a/doc/build/reproducible.rst
+++ /dev/null
@@ -1,27 +0,0 @@
-Reproducible builds
-===================
-
-In order to achieve reproducible builds, timestamps used in the U-Boot build
-process have to be set to a fixed value.
-
-This is done using the SOURCE_DATE_EPOCH environment variable which specifies
-the number of seconds since 1970-01-01T00:00:00Z.
-
-Example
--------
-
-To build the sandbox with 2023-01-01T00:00:00Z as timestamp we can use:
-
-.. code-block:: bash
-
-    make sandbox_defconfig
-    SOURCE_DATE_EPOCH=1672531200 make
-
-This date is shown when we launch U-Boot:
-
-.. code-block:: console
-
-    ./u-boot -T
-    U-Boot 2023.01 (Jan 01 2023 - 00:00:00 +0000)
-
-The same effect can be obtained with buildman using the `-r` flag.
-- 
2.34.1

