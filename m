Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331B5CCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 09:13:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82F45839DF;
	Mon, 10 Nov 2025 10:13:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1762766021;
	bh=HY5+bfafCZC5cM+IZilntVIS5Vz2zxb1pBBh8AwqwAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a5yGBFJ4436zEdWp+HM8PAb50+9n07ln69M/MmXLItVpBIXj8TbSIBGkgn2WPeR5w
	 6OFRkIuJiusbrv8lLR4k9tR6TlROcia+pJ75G4U8V95ilICHscj8/uwlp/PPQHowah
	 4rBbZT+pK79/oJMXQPd/j7tiB+MtvF+NaBsva67Y3QTvudN9q4h85HJZ2nlAGa10Ay
	 1SHWMRiLoIMNZPYeawKh7mk+W2FM0/QsUCS2VaqfL+LpsSnjGInruI9V8lUrxtyuLh
	 5jSZYU2XcoT4wMo9T8VpGL8vZ2knNcRdxp43mmmXD70V4fPAFJZiaJlIiaFDp+8xZ2
	 Wgk5VMLT/MiWQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A81EC839E8; Mon, 10 Nov 2025 10:13:40 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B73C1839DE
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 10:13:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="OKjfAaSY"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3E3801003CE1D; Mon, 10 Nov 2025 10:13:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1762766018; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=HY5+bfafCZC5cM+IZilntVIS5Vz2zxb1pBBh8AwqwAo=;
 b=OKjfAaSYRABrAjFnE3Wfs3w1X6RZ3ukmwS7f27pATnQBOZa4s4osCla2oT+P90On0ELCvD
 3Y5WRusLedjvSdNztNhCVAlnwaGhjSjZXw3pK8VbVwVi/PJAnWnNcjMf4qRNjNXs9bvE4N
 K5QSWs+jjPTojd67JcVOWw7or2z0dzvfc6WIMC36bQhP3Gg+UjbshNlMEQRVBuGYIvpUu1
 +rfX3dUD6wlJWoSRkW3tanyO0mnER7tAthoGtNE5xrfPqttzoyG2OohVn0KQ5kEryUUVYL
 Y9VzmZEE1q+ORWRYLrj33ZO/B5V3bRXhr7V+NBB4OqDiJh4EqgzLYay+gaFcug==
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
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH v5 2/3] Image size checks: Clarify help texts
Date: Mon, 10 Nov 2025 10:12:55 +0100
Message-Id: <20251110091256.2422534-3-pro@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251110091256.2422534-1-pro@denx.de>
References: <20251110091256.2422534-1-pro@denx.de>
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

Adapt help texts for CONFIG_XXX_SIZE_LIMITs to their new logic.

Signed-off-by: Philip Oberfichtner <pro@denx.de>
---

Notes:
    Changes in v5: Polish help texts

 Kconfig                | 10 +++++-----
 common/spl/Kconfig     |  6 +++---
 common/spl/Kconfig.tpl |  6 +++---
 common/spl/Kconfig.vpl |  6 +++---
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Kconfig b/Kconfig
index 1d600342685..10c3e49de0e 100644
--- a/Kconfig
+++ b/Kconfig
@@ -537,7 +537,7 @@ config BUILD_TARGET
 	  make / buildman.
 
 config HAS_BOARD_SIZE_LIMIT
-	bool "Define a maximum size for the U-Boot image"
+	bool "Enable size limit check for the U-Boot image"
 	depends on !COMPILE_TEST
 	default y if RCAR_32 || RCAR_64
 	help
@@ -550,10 +550,10 @@ config BOARD_SIZE_LIMIT
 	default 1048576 if RCAR_64
 	depends on HAS_BOARD_SIZE_LIMIT
 	help
-	  Maximum size of the U-Boot image. When defined, the build system
-	  checks that the actual size does not exceed it.  This does not
-	  include SPL nor TPL, on platforms that use that functionality, they
-	  have separate options to restrict size.
+	  Maximum size of the U-Boot image. The build system checks that the
+	  actual image size does not exceed this value. This does not include
+	  SPL nor TPL, on platforms that use that functionality, they have
+	  separate options to restrict size.
 
 config SYS_CUSTOM_LDSCRIPT
 	bool "Use a custom location for the U-Boot linker script"
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 97c7bfdad47..0cabc4e8019 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -49,7 +49,7 @@ config HAS_SPL_SIZE_LIMIT
 	default y if TARGET_SOCFPGA_GEN5
 
 config SPL_SIZE_LIMIT
-	hex "Maximum size of SPL image"
+	hex "Maximum size of SPL image in bytes"
 	depends on HAS_SPL_SIZE_LIMIT
 	default 0x11000 if ARCH_MX6 && !MX6_OCRAM_256KB
 	default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
@@ -57,8 +57,8 @@ config SPL_SIZE_LIMIT
 	default 0x30000 if SOC_MT7621
 	default 0x10000 if TARGET_SOCFPGA_GEN5
 	help
-	  Specifies the maximum length of the U-Boot SPL image.
-	  If this value is zero, it is ignored.
+	  Maximum size of the SPL image. The build system checks that the
+	  actual image size does not exceed this value.
 
 config SPL_SIZE_LIMIT_SUBTRACT_GD
 	bool "SPL image size check: provide space for global data"
diff --git a/common/spl/Kconfig.tpl b/common/spl/Kconfig.tpl
index 82ed0a06c89..87aaf1132e6 100644
--- a/common/spl/Kconfig.tpl
+++ b/common/spl/Kconfig.tpl
@@ -8,12 +8,12 @@ config HAS_TPL_SIZE_LIMIT
 	default y if INTEL_APOLLOLAKE
 
 config TPL_SIZE_LIMIT
-	hex "Maximum size of TPL image"
+	hex "Maximum size of TPL image in bytes"
 	depends on HAS_TPL_SIZE_LIMIT
 	default 0x7800 if INTEL_APOLLOLAKE
 	help
-	  Specifies the maximum length of the U-Boot TPL image.
-	  If this value is zero, it is ignored.
+	  Maximum size of the TPL image. The build system checks that the
+	  actual image size does not exceed this value.
 
 config TPL_BINMAN_SYMBOLS
 	bool "Support binman symbols in TPL"
diff --git a/common/spl/Kconfig.vpl b/common/spl/Kconfig.vpl
index 1945fa22b6b..67ecd78a225 100644
--- a/common/spl/Kconfig.vpl
+++ b/common/spl/Kconfig.vpl
@@ -226,11 +226,11 @@ config HAS_VPL_SIZE_LIMIT
 	depends on VPL
 
 config VPL_SIZE_LIMIT
-	hex "Maximum size of VPL image"
+	hex "Maximum size of VPL image in bytes"
 	depends on HAS_VPL_SIZE_LIMIT
 	help
-	  Specifies the maximum length of the U-Boot VPL image.
-	  If this value is zero, it is ignored.
+	  Maximum size of the VPL image. The build system checks that the
+	  actual image size does not exceed this value.
 
 config VPL_SPI
 	bool "Support SPI drivers"
-- 
2.39.5

