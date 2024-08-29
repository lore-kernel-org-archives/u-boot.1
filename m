Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F863C83F2D
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 15:01:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16F8C88C88;
	Thu, 29 Aug 2024 16:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hk7Oq8/T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82FA888CCA; Thu, 29 Aug 2024 16:58:34 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7888988C88
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:58:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-39d3636e955so2677985ab.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724943510; x=1725548310; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=umguDeUwn9N9p/E+qVSByJL6Fw72fYu+qjzrR9ckJeA=;
 b=hk7Oq8/TDgdyxpv4MLQXFxIdmN+fmAfbZo8YjrKJj1HeRMybHZq1vxI2dCzagF0B1b
 yoQCWUucihniEyobWiI0XFCP+MsOe8iUq35cM/ZSuIohZsYpEC7a4N3ftWsjWQXt9mMG
 +Ga78tPRni55it5YS7Gha/c3OrnKewxrDjtwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943510; x=1725548310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=umguDeUwn9N9p/E+qVSByJL6Fw72fYu+qjzrR9ckJeA=;
 b=YsudIFTAKOAVYsN/xP8iNYnFkj3jLdIe5ZfYDlcivp5p13kEWEqTyRyNZ7M5T6rvKE
 5vlYYoYtTgfMh9FpkD4Iz4C6IDyREzPsjRU43n9vN1HR+V/7BZRd2lSbUNNtlrQgZja0
 jbprHGNb1KipJipPXZgaazcXQNU1l1UP1VIXSyIKWiyo7VHfxgkd+TwI6sbmCldjWRNV
 Tyvy+OYVBu0Umkfe89av7VMD7nO63UuZWtXbUxbtkPJ9IuGgOFhjzh3EE/tRui01hGbJ
 NNkJcaOoVpsZ2RJq+Rri+yo7GLKl2utCFt/nAwr3OAOx9/UKE64pEz8vq+e3F4xxDQ9N
 EJng==
X-Gm-Message-State: AOJu0YzjlzQZu92NeCuZ86w1Cn7TaC57GI1O2Px6xhtSmCD9hC9KNhVa
 o6qSimEpT+Uu80ewea4Jpwh1DTr0RDF5w6rq/nsvJNFSDt/AeYWbFzV6580ugzW58nAsMWw13ww
 =
X-Google-Smtp-Source: AGHT+IGYTS1/Ll+6HsE5nD+sEgrDi05BInDfaC+1P4B/hwcDGh7o5kn58VaQlnPZxy/Lz2L0sumz9w==
X-Received: by 2002:a05:6e02:1b09:b0:382:b3f8:9f72 with SMTP id
 e9e14a558f8ab-39f37820a2emr42453335ab.15.1724943509897; 
 Thu, 29 Aug 2024 07:58:29 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ced2dcdd2bsm284900173.21.2024.08.29.07.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 07:58:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 16/19] boot: Allow use of FIT in TPL and VPL
Date: Thu, 29 Aug 2024 08:57:59 -0600
Message-Id: <20240829145802.1827952-17-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829145802.1827952-1-sjg@chromium.org>
References: <20240829145802.1827952-1-sjg@chromium.org>
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

 boot/Kconfig                  | 69 ++++++++++++++++++++++++++++++++++-
 boot/Makefile                 |  4 +-
 configs/sandbox_vpl_defconfig |  3 +-
 3 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 7ac34574079..afe04c7327a 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -161,6 +161,18 @@ config SPL_FIT
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
@@ -265,6 +277,28 @@ config SPL_LOAD_FIT_FULL
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
@@ -312,6 +346,22 @@ config VPL_FIT
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
@@ -632,6 +682,15 @@ config VPL_BOOTMETH_VBE
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
@@ -710,7 +769,15 @@ config VPL_BOOTMETH_VBE_SIMPLE_FW
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
2.34.1

