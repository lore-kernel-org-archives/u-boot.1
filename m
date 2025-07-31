Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24768C87FCC
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 11:41:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 159148386B;
	Thu, 31 Jul 2025 13:41:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1753962087;
	bh=ES0Udkq+0nfIg/FjhArOTvVXXwYjn3u9SqVDCw7hbjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nd0qHJMNAhnWR7PzcDO5N09f2uaGN8eapmYMrl0w310EgjCRw3faE8u6yqarjcJuA
	 3luaQ9yLVyOPBRdrZb73a7hdG3w38uYLCZhnypCMcvkzl8iY83eppf+r1uQR+P8Mid
	 5N1MvRYX7W58EeP5e3nnMnLfPlhQiUKLcXi4rAl6V2vSLUFPdo1cCFB4pe6oLrMBI/
	 znS5GC+qLdE7LzqSS3SNj8p21aluzUVWp7pi5MWTo8S9I98mKcOoWupPTewrr1oQ/W
	 DQt2hLVKvLGYmmzrpQycCL67I/VbhFRqpX8v/MJ4zhpbm4n8v83Qo9GhjmQhfTmr7l
	 QcSH8DdTZODCg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1441E83873; Thu, 31 Jul 2025 13:41:26 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8BCF83816
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 13:41:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Ej155P66"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 423FF1038C126; 
 Thu, 31 Jul 2025 13:41:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1753962083; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=ES0Udkq+0nfIg/FjhArOTvVXXwYjn3u9SqVDCw7hbjM=;
 b=Ej155P66VgdTVj790+pl53JsIEWLxup3YEcbtscxCizXx838Kj5dH41Gt3gnHj5lGjT/6R
 NJZ95tAE/tVeel45cSuLn47X7uGmrpc3DBPym36pYOFw9yBbHxxtDxhY0VHWsEGOKkkDF8
 uen/BCWwjY598OR7lCyB5wx+zjhSy+p/KsFFYbBEwqQUCAaxnCzgVBIpFAuvkTInhsq0tH
 5hvEfb65TE0+FrhRg8NP2GykoR4LgsCC3Tlld6m9oDhZ/Uv5EA+nRfGpFDi4XDcOYL2MOR
 lZE7P+MGaB9Ym9jlm9fasDg9kM5xqtbJTpzBdA1WFARkQOznbLbBewTDZ8IppQ==
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: Philip Oberfichtner <pro@denx.de>, Andre Przywara <andre.przywara@arm.com>,
 Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Gary Bisson <bisson.gary@gmail.com>, Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>,
 Ye Li <ye.li@nxp.com>
Subject: [RFC PATCH v1 3/3] Image size checks: Move all configs in one place
Date: Thu, 31 Jul 2025 13:40:44 +0200
Message-Id: <20250731114044.264745-4-pro@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250731114044.264745-1-pro@denx.de>
References: <20250731114044.264745-1-pro@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

How image size limiting works in U-Boot should be easier to grasp if we
have all related options in one place.

Signed-off-by: Philip Oberfichtner <pro@denx.de>
---
 Kconfig                | 59 ++++++++++++++++++++++++++++++++++++++++++
 common/spl/Kconfig     | 38 ---------------------------
 common/spl/Kconfig.tpl |  7 -----
 common/spl/Kconfig.vpl |  7 -----
 4 files changed, 59 insertions(+), 52 deletions(-)

diff --git a/Kconfig b/Kconfig
index d0c0a6a1d53..6435a4c3bcc 100644
--- a/Kconfig
+++ b/Kconfig
@@ -535,6 +535,8 @@ config BUILD_TARGET
 	  special image will be automatically built upon calling
 	  make / buildman.
 
+menu "Image size limits"
+
 config BOARD_SIZE_LIMIT
 	int "Maximum size of the U-Boot image in bytes"
 	default 0
@@ -546,6 +548,63 @@ config BOARD_SIZE_LIMIT
 	  include SPL nor TPL, on platforms that use that functionality, they
 	  have a separate option to restict size.
 
+config SPL_SIZE_LIMIT
+	depends on SPL
+	hex "Maximum size of SPL image"
+	default 0x11000 if ARCH_MX6 && !MX6_OCRAM_256KB
+	default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
+	default 0x30000 if ARCH_MVEBU && ARMADA_32BIT
+	default 0x0
+	help
+	  Specifies the maximum length of the U-Boot SPL image.
+	  If this value is zero, it is ignored.
+
+config SPL_SIZE_LIMIT_SUBTRACT_GD
+	bool "SPL image size check: provide space for global data"
+	depends on SPL_SIZE_LIMIT > 0
+	help
+	  If enabled, aligned size of global data is reserved in
+	  SPL_SIZE_LIMIT check to ensure such an image does not overflow SRAM
+	  if SPL_SIZE_LIMIT describes the size of SRAM available for SPL when
+	  pre-reloc global data is put into this SRAM, too.
+
+config SPL_SIZE_LIMIT_SUBTRACT_MALLOC
+	bool "SPL image size check: provide space for malloc() pool before relocation"
+	depends on SPL_SIZE_LIMIT > 0
+	help
+	  If enabled, SPL_SYS_MALLOC_F_LEN is reserved in SPL_SIZE_LIMIT check
+	  to ensure such an image does not overflow SRAM if SPL_SIZE_LIMIT
+	  describes the size of SRAM available for SPL when pre-reloc malloc
+	  pool is put into this SRAM, too.
+
+config SPL_SIZE_LIMIT_PROVIDE_STACK
+	hex "SPL image size check: provide stack space before relocation"
+	depends on SPL_SIZE_LIMIT > 0
+	default 0x0
+	help
+	  If set, this size is reserved in SPL_SIZE_LIMIT check to ensure such
+	  an image does not overflow SRAM if SPL_SIZE_LIMIT describes the size
+	  of SRAM available for SPL when the stack required before reolcation
+	  uses this SRAM, too.
+
+config TPL_SIZE_LIMIT
+	depends on TPL
+	hex "Maximum size of TPL image"
+	default 0x0
+	help
+	  Specifies the maximum length of the U-Boot TPL image.
+	  If this value is zero, it is ignored.
+
+config VPL_SIZE_LIMIT
+	depends on VPL
+	hex "Maximum size of VPL image"
+	default 0x0
+	help
+	  Specifies the maximum length of the U-Boot VPL image.
+	  If this value is zero, it is ignored.
+
+endmenu
+
 config SYS_CUSTOM_LDSCRIPT
 	bool "Use a custom location for the U-Boot linker script"
 	depends on !COMPILE_TEST
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index ab05536bd02..87a56bd8f8a 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -36,44 +36,6 @@ config SPL_FRAMEWORK_BOARD_INIT_F
 	  - initialize the serial (preloader_console_init)
 	  Unless you want to provide your own board_init_f, you should say Y.
 
-config SPL_SIZE_LIMIT
-	hex "Maximum size of SPL image"
-	default 0x11000 if ARCH_MX6 && !MX6_OCRAM_256KB
-	default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
-	default 0x30000 if ARCH_MVEBU && ARMADA_32BIT
-	default 0x0
-	help
-	  Specifies the maximum length of the U-Boot SPL image.
-	  If this value is zero, it is ignored.
-
-config SPL_SIZE_LIMIT_SUBTRACT_GD
-	bool "SPL image size check: provide space for global data"
-	depends on SPL_SIZE_LIMIT > 0
-	help
-	  If enabled, aligned size of global data is reserved in
-	  SPL_SIZE_LIMIT check to ensure such an image does not overflow SRAM
-	  if SPL_SIZE_LIMIT describes the size of SRAM available for SPL when
-	  pre-reloc global data is put into this SRAM, too.
-
-config SPL_SIZE_LIMIT_SUBTRACT_MALLOC
-	bool "SPL image size check: provide space for malloc() pool before relocation"
-	depends on SPL_SIZE_LIMIT > 0
-	help
-	  If enabled, SPL_SYS_MALLOC_F_LEN is reserved in SPL_SIZE_LIMIT check
-	  to ensure such an image does not overflow SRAM if SPL_SIZE_LIMIT
-	  describes the size of SRAM available for SPL when pre-reloc malloc
-	  pool is put into this SRAM, too.
-
-config SPL_SIZE_LIMIT_PROVIDE_STACK
-	hex "SPL image size check: provide stack space before relocation"
-	depends on SPL_SIZE_LIMIT > 0
-	default 0x0
-	help
-	  If set, this size is reserved in SPL_SIZE_LIMIT check to ensure such
-	  an image does not overflow SRAM if SPL_SIZE_LIMIT describes the size
-	  of SRAM available for SPL when the stack required before reolcation
-	  uses this SRAM, too.
-
 config SPL_MAX_SIZE
 	hex "Maximum size of the SPL image, excluding BSS"
 	default 0x30000 if ARCH_MX6 && MX6_OCRAM_256KB
diff --git a/common/spl/Kconfig.tpl b/common/spl/Kconfig.tpl
index a535b61ecd3..515bbeec685 100644
--- a/common/spl/Kconfig.tpl
+++ b/common/spl/Kconfig.tpl
@@ -1,13 +1,6 @@
 menu "TPL configuration options"
 	depends on TPL
 
-config TPL_SIZE_LIMIT
-	hex "Maximum size of TPL image"
-	default 0x0
-	help
-	  Specifies the maximum length of the U-Boot TPL image.
-	  If this value is zero, it is ignored.
-
 config TPL_BINMAN_SYMBOLS
 	bool "Support binman symbols in TPL"
 	depends on TPL_FRAMEWORK && BINMAN
diff --git a/common/spl/Kconfig.vpl b/common/spl/Kconfig.vpl
index 434562443ac..739f2805315 100644
--- a/common/spl/Kconfig.vpl
+++ b/common/spl/Kconfig.vpl
@@ -220,13 +220,6 @@ config VPL_SERIAL
 	  Enable support for serial in VPL. See SPL_SERIAL for
 	  details.
 
-config VPL_SIZE_LIMIT
-	hex "Maximum size of VPL image"
-	default 0x0
-	help
-	  Specifies the maximum length of the U-Boot VPL image.
-	  If this value is zero, it is ignored.
-
 config VPL_SPI
 	bool "Support SPI drivers"
 	help
-- 
2.39.5

