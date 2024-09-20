Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28E4CF58E7
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:15:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4115C893C5;
	Fri, 20 Sep 2024 10:13:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cxO/otw1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C3F189448; Fri, 20 Sep 2024 10:13:48 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E74189382
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:13:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c44e1cde53so2088638a12.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726820025; x=1727424825; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+6FBUOoyMCwX1WqvoSOMxqamLObA4Msus+qAPD9t0YU=;
 b=cxO/otw1nkitZiZfSdBWzlU6S3fQyyi93CDceYcZfrdaqaIcfRGOf82hSSeA4nFBbp
 s7UI8CENHmDizNklqicW9X1pdSxrLJq9fV9nfKS38eK1Lsu06L7Ecv5wf4m9z+a5IUU9
 I3iD/XJ8SBR4sRj8ZiOPuw70Z9MUG+DEoQ3Ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726820025; x=1727424825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+6FBUOoyMCwX1WqvoSOMxqamLObA4Msus+qAPD9t0YU=;
 b=rfnVKEMyTGJ39GBP8xEIm3YeQZFNLz/TGAQJVoDIbrIpyIsbYZdfcRPACo6OvR1MkU
 ILDZliuQwATVNZsjW/FKK0fBouKP8dqPpFO9Q5DCglf5poA3NPvgF8kmqSKGrofL8Ia1
 k+0ZVHhyVKMO9QkB2/duW5/lwj2kwEtKfjVXaSYamWER9BYugTplTQrTO9eiORQl7fLd
 Jqf5OUPpoUl8pCcRtcxFwS2+6533J4+0Ntuonb+R97yXsuXOtPdDpeJgYej57CigqUwn
 6/IngYEkMWU7gKqjiTv/0avrdBEx5MsUIr+AquPiJzqiwHYCED3Yd5qolSZdS6u/QAFh
 Wzhw==
X-Gm-Message-State: AOJu0Yyh3OqNY5pXhFauX1S+v8dNC+oQqCx2frKNuV0xXhNdvjOh5Pcs
 uKTyBkeD9/iqJZOo2jYZAoORBodrFDPqKSkf/FdXcHTbaoW8rjYx5TUaQB4A0JQ6UPcH7Z6DNEE
 +GUwm
X-Google-Smtp-Source: AGHT+IHhZPIfaWL+L/2IVqXgjR1xss1mfXmpVSyYwOYiYjwdHBPRSupD8ieNNflaujuN0nh//1Bb5g==
X-Received: by 2002:a05:6402:2101:b0:5c4:2d7d:9759 with SMTP id
 4fb4d7f45d1cf-5c464a3a1e4mr1628101a12.10.1726820025223; 
 Fri, 20 Sep 2024 01:13:45 -0700 (PDT)
Received: from chromium.org ([83.68.141.146]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bc88cf7sm6804447a12.90.2024.09.20.01.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:13:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 15/18] boot: Allow use of FIT in TPL and VPL
Date: Fri, 20 Sep 2024 10:12:54 +0200
Message-ID: <20240920081309.140426-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920081309.140426-1-sjg@chromium.org>
References: <20240920081309.140426-1-sjg@chromium.org>
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

With VBE we want to use FIT in all phases of the boot. Add Kconfig
options to support this.

Disable the options for sandbox_vpl for now.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/Kconfig                  | 69 ++++++++++++++++++++++++++++++++++-
 boot/Makefile                 |  4 +-
 configs/sandbox_vpl_defconfig |  3 +-
 3 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 925afe06a19..9fd1424cd1f 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -163,6 +163,18 @@ config SPL_FIT
 	select SPL_HASH
 	select SPL_OF_LIBFDT
 
+config VPL_FIT
+	bool "Support Flattened Image Tree within VPL"
+	depends on VPL
+	select VPL_HASH
+	select VPL_OF_LIBFDT
+
+config TPL_FIT
+	bool "Support Flattened Image Tree within TPL"
+	depends on TPL
+	select TPL_HASH
+	select TPL_OF_LIBFDT
+
 config SPL_FIT_PRINT
 	bool "Support FIT printing within SPL"
 	depends on SPL_FIT
@@ -267,6 +279,28 @@ config SPL_LOAD_FIT_FULL
 	  particular it can handle selecting from multiple device tree
 	  and passing the correct one to U-Boot.
 
+config TPL_LOAD_FIT
+	bool "Enable TPL loading U-Boot as a FIT (basic fitImage features)"
+	depends on TPL
+	select TPL_FIT
+	help
+	  Normally with the SPL framework a legacy image is generated as part
+	  of the build. This contains U-Boot along with information as to
+	  where it should be loaded. This option instead enables generation
+	  of a FIT (Flat Image Tree) which provides more flexibility. In
+	  particular it can handle selecting from multiple device tree
+	  and passing the correct one to U-Boot.
+
+	  This path has the following limitations:
+
+	  1. "loadables" images, other than FDTs, which do not have a "load"
+	     property will not be loaded. This limitation also applies to FPGA
+	     images with the correct "compatible" string.
+	  2. For FPGA images, the supported "compatible" list is in the
+	     doc/uImage.FIT/source_file_format.txt.
+	  3. FDTs are only loaded for images with an "os" property of "u-boot".
+	     "linux" images are also supported with Falcon boot mode.
+
 config SPL_FIT_IMAGE_POST_PROCESS
 	bool "Enable post-processing of FIT artifacts after loading by the SPL"
 	depends on SPL_LOAD_FIT
@@ -314,6 +348,22 @@ config VPL_FIT
 	select VPL_HASH
 	select VPL_OF_LIBFDT
 
+config VPL_LOAD_FIT
+	bool "Enable VPL loading U-Boot as a FIT (basic fitImage features)"
+	select VPL_FIT
+	default y
+
+config VPL_LOAD_FIT_FULL
+	bool "Enable SPL loading U-Boot as a FIT (full fitImage features)"
+	select VPL_FIT
+	help
+	  Normally with the SPL framework a legacy image is generated as part
+	  of the build. This contains U-Boot along with information as to
+	  where it should be loaded. This option instead enables generation
+	  of a FIT (Flat Image Tree) which provides more flexibility. In
+	  particular it can handle selecting from multiple device tree
+	  and passing the correct one to U-Boot.
+
 config VPL_FIT_PRINT
 	bool "Support FIT printing within VPL"
 	depends on VPL_FIT
@@ -634,6 +684,15 @@ config VPL_BOOTMETH_VBE
 	  supports selection of various firmware components, selection of an OS to
 	  boot as well as updating these using fwupd.
 
+config TPL_BOOTMETH_VBE
+	bool "Bootdev support for Verified Boot for Embedded (TPL)"
+	depends on TPL
+	default y
+	help
+	  Enables support for VBE boot. This is a standard boot method which
+	  supports selection of various firmware components, seleciton of an OS to
+	  boot as well as updating these using fwupd.
+
 if BOOTMETH_VBE
 
 config BOOTMETH_VBE_REQUEST
@@ -712,7 +771,15 @@ config VPL_BOOTMETH_VBE_SIMPLE_FW
 	  This option enabled for VPL, since it is the phase where the SPL
 	  decision is made.
 
-endif # BOOTMETH_VBE
+config TPL_BOOTMETH_VBE_SIMPLE_FW
+	bool "Bootdev support for VBE 'simple' method firmware phase (TPL)"
+	depends on VPL
+	default y
+	help
+	  Enables support for the firmware parts of VBE 'simple' boot, in TPL.
+	  TPL loads a FIT containing the VPL binary and a suitable devicetree.
+
+endif # BOOTMETH_VBE_SIMPLE
 
 config EXPO
 	bool "Support for expos - groups of scenes displaying a UI"
diff --git a/boot/Makefile b/boot/Makefile
index f4675d6ffd5..40e2337de0f 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -58,9 +58,7 @@ obj-$(CONFIG_$(SPL_TPL_)FIT_CIPHER) += image-cipher.o
 
 obj-$(CONFIG_CMD_ADTIMG) += image-android-dt.o
 
-ifdef CONFIG_SPL_BUILD
-obj-$(CONFIG_SPL_LOAD_FIT) += common_fit.o
-endif
+obj-$(CONFIG_$(SPL_TPL_)LOAD_FIT) += common_fit.o
 
 obj-$(CONFIG_$(SPL_TPL_)EXPO) += expo.o scene.o expo_build.o
 obj-$(CONFIG_$(SPL_TPL_)EXPO) += scene_menu.o scene_textline.o
diff --git a/configs/sandbox_vpl_defconfig b/configs/sandbox_vpl_defconfig
index 96e9211bd19..d18bb7a0353 100644
--- a/configs/sandbox_vpl_defconfig
+++ b/configs/sandbox_vpl_defconfig
@@ -27,9 +27,10 @@ CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_FIT_BEST_MATCH=y
 CONFIG_SPL_LOAD_FIT=y
+# CONFIG_TPL_BOOTMETH_VBE is not set
+# CONFIG_TPL_BOOTMETH_VBE_SIMPLE_FW is not set
 CONFIG_UPL=y
 CONFIG_UPL_IN=y
-CONFIG_SPL_UPL_OUT=y
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
 CONFIG_BOOTSTAGE_FDT=y
-- 
2.43.0

