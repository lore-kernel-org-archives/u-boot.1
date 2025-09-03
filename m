Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFA0CA0FF2
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 10:57:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A56268353A;
	Wed,  3 Sep 2025 12:57:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1756897056;
	bh=YCdvl+PfiCvRGPT2CxtutYgEE/nQmTPa1U08HkenF1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U1IimSPZmoZcP6Uva2S5weoBsNYZRCi2gHIr4brt+4Jg3GFqEaKlZXbWgWiDdRcsz
	 i3cTU2YO/inm6clyXxi5gNQ4moDeqVOZiBzqr0Y7uhitn/rWpsiOIaSrxxrWMSeDcN
	 5q3bB5Twl4qN+eFIYj0pAsi5UsK4NW+m0fHBV3IU1JNmkB9l50qz6mnO3ItKD8Kjzm
	 XCHOb4vc8iGY6USf+lLpnIRqJAYgsEWQVK5uLRZ13PO1Kw0AEO+MBHxoAT5E5QeUA6
	 mbL0Wtm/WjB7qcPYBT0OUN8V2Rjhe9Bol01DnHJyX7fI+W0PbWcXtsY23KLxCE9W+H
	 kFpFC3XBhe1kQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A534833BF; Wed,  3 Sep 2025 12:57:35 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6602283564
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 12:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="X9X/wNmJ"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BAE3F1026E148; 
 Wed,  3 Sep 2025 12:57:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1756897052; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=YCdvl+PfiCvRGPT2CxtutYgEE/nQmTPa1U08HkenF1Q=;
 b=X9X/wNmJVRf98uQHhauWRoViq6GPS7Ods3p74N5EhRU9Kb7pVLYXjklQs/d/E9aQG/qN7f
 b5CVxMU1d673BVpvu5QW/NfOHz+ApRivLhAu4ZZWMvMaHkWsst3CPB1EDUNaKax0+fUbSd
 CsYc8TAtQ37lJJd4a/ktYSaAHVy12jjaN5Fof7PEml0D6ehYJM7PqOlVCiA5C4qmwOQS3B
 o0JTOfQxsbGaTbMyPKum+8xGBupOxjc9Ut70wKJOG5UM7b2Y/MBLSbsw2V8iecHoOrmH/C
 Mr0eO2qvdxg8gQ8ssw8xbTPc8JdYgIQoFroGBckF56AfVV5f9SJPhNPsl+cJOw==
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
Subject: [PATCH v3 3/5] Image size checks: Use consistent help texts
Date: Wed,  3 Sep 2025 12:56:51 +0200
Message-Id: <20250903105653.335417-4-pro@denx.de>
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

The multiple XXX_SIZE_LIMIT options use slightly varying help texts.
Their similarities and differences should become more clear if we use
consistent help texts.

Signed-off-by: Philip Oberfichtner <pro@denx.de>
---
 Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Kconfig b/Kconfig
index e73dd91a408..aa00669ba20 100644
--- a/Kconfig
+++ b/Kconfig
@@ -538,7 +538,7 @@ config BUILD_TARGET
 menu "Image size limits"
 
 config HAS_BOARD_SIZE_LIMIT
-	bool "Define a maximum size for the U-Boot image"
+	bool "Enable size limit check for the U-Boot image"
 	depends on !COMPILE_TEST
 	default y if RCAR_32 || RCAR_64
 	help
@@ -562,11 +562,11 @@ config HAS_VPL_SIZE_LIMIT
 	depends on VPL
 
 config VPL_SIZE_LIMIT
-	hex "Maximum size of VPL image"
+	hex "Maximum size of VPL image in bytes"
 	depends on HAS_VPL_SIZE_LIMIT
 	help
-	  Specifies the maximum length of the U-Boot VPL image.
-	  If this value is zero, it is ignored.
+	  Maximum size of the VPL image. When defined, the build system checks
+	  that the actual size does not exceed it.
 
 config HAS_TPL_SIZE_LIMIT
 	bool "Enable size limit check for the TPL image"
@@ -574,11 +574,11 @@ config HAS_TPL_SIZE_LIMIT
 	depends on TPL
 
 config TPL_SIZE_LIMIT
-	hex "Maximum size of TPL image"
+	hex "Maximum size of TPL image in bytes"
 	depends on HAS_TPL_SIZE_LIMIT
 	help
-	  Specifies the maximum length of the U-Boot TPL image.
-	  If this value is zero, it is ignored.
+	  Maximum size of the TPL image. When defined, the build system checks
+	  that the actual size does not exceed it.
 
 config HAS_SPL_SIZE_LIMIT
 	bool "Enable size limit check for the SPL image"
@@ -586,14 +586,14 @@ config HAS_SPL_SIZE_LIMIT
 	depends on SPL
 
 config SPL_SIZE_LIMIT
-	hex "Maximum size of SPL image"
+	hex "Maximum size of SPL image in bytes"
 	depends on HAS_SPL_SIZE_LIMIT
 	default 0x11000 if ARCH_MX6 && !MX6_OCRAM_256KB
 	default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
 	default 0x30000 if ARCH_MVEBU && ARMADA_32BIT
 	help
-	  Specifies the maximum length of the U-Boot SPL image.
-	  If this value is zero, it is ignored.
+	  Maximum size of the SPL image. When defined, the build system checks
+	  that the actual size does not exceed it.
 
 config SPL_SIZE_LIMIT_SUBTRACT_GD
 	bool "SPL image size check: provide space for global data"
-- 
2.39.5

