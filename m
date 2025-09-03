Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A705CA0FF2
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 10:57:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1939B8350A;
	Wed,  3 Sep 2025 12:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1756897048;
	bh=vQ+ci0DbFPbje2NR0ZVjzSP/LA/7N1UgRpc+pZlODjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xth4VX0jrxeWtLQ9D1/cYKh1fDyJ7aDV1z93fqad7R9tEykR/nZ+KDYXLoE/lNe4t
	 h080K7Dct9MS2h0HfcObO6w5Oa8MO4CPOM4YZzV/P2T+ZMt0ValQSJovpMK2qutWX8
	 /OIF2htt9uDX4aaisP0qsGNe3x0b/htfnh0ZD+7C2mmNxnhX4rl2JDEYH9c8lj4UHZ
	 hXidJ2FF+coUo5WYuMUPet5afL5YviqOr/eVvKFIU5r1WubsMAtNLBcGSbhmnvBrc6
	 fifHVYeyMlTtIOHbF8mMra2PeTE4GV2Exdz344yMCRHkrXHnfy/+4RP7tPrM0iKTGI
	 Gw03fDscXWlHw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A62683510; Wed,  3 Sep 2025 12:57:27 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC22B83390
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 12:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="VK+bzFHs"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BEA8710246D8B; 
 Wed,  3 Sep 2025 12:57:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1756897044; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=vQ+ci0DbFPbje2NR0ZVjzSP/LA/7N1UgRpc+pZlODjA=;
 b=VK+bzFHsRNFeUNJ1qX+oejNtY/jpgiyEdAsTdcrzCMd8hbfPsLcvwDm25V/J+DsqWtxeM/
 6ribNOhnE96Ald8od38Z1fIuOJXujt3lERGRK4BDzVIO7/NCB+XhJalsixZr6oOk8UKtOV
 kiCK9ZIRKhtwVgyjmBlr3HfZzchoqwiFdaY88uKGsLLlfxBSvwD3+bIMyhsMuTxMerDanf
 30hhQF/886WHPxvJjsBWQB3qHwUUaZq6M9r6WWF2c6fI+JVG8tuFhdaKFXXkFj41tSc3iR
 sSp4fXco7KA9YXqaomyRSzLOMIHePj3Gi05SuUtmA+qDUxkj+4XwwzKtgs2bGQ==
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: Philip Oberfichtner <pro@denx.de>, Andre Przywara <andre.przywara@arm.com>,
 Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Trevor Woerner <twoerner@gmail.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH v3 1/5] Image size checks: Move all configs in one place
Date: Wed,  3 Sep 2025 12:56:49 +0200
Message-Id: <20250903105653.335417-2-pro@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250903105653.335417-1-pro@denx.de>
References: <20250903105653.335417-1-pro@denx.de>
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
index 70125c4e5a6..f1a6be299e8 100644
--- a/Kconfig
+++ b/Kconfig
@@ -535,6 +535,8 @@ config BUILD_TARGET
 	  special image will be automatically built upon calling
 	  make / buildman.
 
+menu "Image size limits"
+
 config HAS_BOARD_SIZE_LIMIT
 	bool "Define a maximum size for the U-Boot image"
 	depends on !COMPILE_TEST
@@ -554,6 +556,63 @@ config BOARD_SIZE_LIMIT
 	  include SPL nor TPL, on platforms that use that functionality, they
 	  have separate options to restrict size.
 
+config VPL_SIZE_LIMIT
+	depends on VPL
+	hex "Maximum size of VPL image"
+	default 0x0
+	help
+	  Specifies the maximum length of the U-Boot VPL image.
+	  If this value is zero, it is ignored.
+
+config TPL_SIZE_LIMIT
+	depends on TPL
+	hex "Maximum size of TPL image"
+	default 0x0
+	help
+	  Specifies the maximum length of the U-Boot TPL image.
+	  If this value is zero, it is ignored.
+
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

