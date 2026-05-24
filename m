Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48091CD5BB1
	for <u-boot@archiver.kernel.org>; Sun, 24 May 2026 17:24:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FFC984886;
	Sun, 24 May 2026 19:24:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="NVawyxCx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44A6983EF9; Sun, 24 May 2026 19:24:18 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ABD0846D3
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 19:24:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 769B51164D7; Sun, 24 May 2026 19:24:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1779643456; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=WYWRk5ScrZvlZh4IYrQzbdrIjD/oozRFOBZLOVRRipc=;
 b=NVawyxCxEfnhNA2wFUFvZllgC01AK3KY9ctcVgkcv78k3fTHzFiXwBERiagCorPk4MVkAK
 lwHIatRafj8C88ftmINSOq+2UuGLUV6oY8/2vOjlVGf98S3ogyi2E7zGwOQ87XLRgl9ihB
 5pQn8OPP2LS6fxhJFNYVku9vz6bqL+bVK2DIxzAZt3N12y3TLRLwEHNtA8esTAPp/VbJ2R
 59b5t8tl+llpXNwa2dnL5/XGOV8DYcF6Ce5gVsIyP6qyXbwlKgKtpt2ZNhYrVk89CZTqkO
 W8oN5aFC2PNiSqUg6TKFaijmguu+KZSfFPN0/HNQMHVjPKm7N5Kegb/pi1Vd/g==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
 Alexander Koch <akoch@initse.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] arm64: dts: imx8mm: Generate FSPI header using binman
 imx8mimage
Date: Sun, 24 May 2026 19:22:55 +0200
Message-ID: <20260524172402.119517-2-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260524172402.119517-1-marex@nabladev.com>
References: <20260524172402.119517-1-marex@nabladev.com>
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

The binman imx8mimage now correctly handles generated fspi_header.bin
in its imx8mimage etype. Make use of this, remove fspi_conf_block in
favor of generated fspi_header.bin, and configure imx8mimage accordingly.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Adam Ford <aford173@gmail.com>
Cc: Alexander Koch <akoch@initse.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/imx8mm-u-boot.dtsi | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-u-boot.dtsi
index d891e8062fe..ab135fc8a47 100644
--- a/arch/arm/dts/imx8mm-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-u-boot.dtsi
@@ -50,14 +50,6 @@
 	section {
 		pad-byte = <0x00>;
 
-#ifdef CONFIG_FSPI_CONF_HEADER
-		fspi_conf_block {
-			filename = CONFIG_FSPI_CONF_FILE;
-			type = "blob-ext";
-			size = <0x1000>;
-		};
-#endif
-
 #ifdef CONFIG_IMX_HAB
 		nxp-imx8mcst@0 {
 			filename = "u-boot-spl-mkimage.signed.bin";
@@ -68,7 +60,12 @@
 
 			binman_imx_spl: nxp-imx8mimage {
 				filename = "u-boot-spl-mkimage.bin";
+#ifdef CONFIG_FSPI_CONF_HEADER
+				nxp,boot-from = "fspi";
+				nxp,fspi-header-filename = CONFIG_FSPI_CONF_FILE;
+#else
 				nxp,boot-from = "sd";
+#endif
 				nxp,rom-version = <1>;
 				nxp,loader-address = <CONFIG_SPL_TEXT_BASE>;
 				args;	/* Needed by mkimage etype superclass */
-- 
2.53.0

