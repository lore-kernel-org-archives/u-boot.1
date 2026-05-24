Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB90CD5BB1
	for <u-boot@archiver.kernel.org>; Sun, 24 May 2026 17:24:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2B41848D8;
	Sun, 24 May 2026 19:24:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="MwSg7wD6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1130C83EF9; Sun, 24 May 2026 19:24:20 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC1CF84874
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 19:24:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 25E651164B5; Sun, 24 May 2026 19:24:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1779643456; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=WpVIkBQwWmk7W4WP25vdtOwAtDVNNOSyjRf1AU4duZs=;
 b=MwSg7wD6OpUr3YFC8DuWivGJ734Qycy52uP2zJ/ige6lqEcyHwKUS+146kQmzbW8OGrX9O
 c8VhtO/PqfYN/YrIO1ttPFhPJtT9X1cBc7STrBWjkM1tQsKFs5ex/6NA095FEFE0T1UF21
 qPzHI8D42rtMHlnO63aDfqEcLBnlPBv2cQCM0pQ6S9uYyRtOu4jqXXpKPpJUdEIn5iOn5F
 J18Q5tPDu519/NO1s/eXWISYUsWteJyAFzuNqA1yv2bJBzMF6cF8iD+X7gnvQjoLt+xXqr
 CMibaa8x1fA3jBkKuz1Dq+mKRX2no8PbniTn67RjIyPDFkDfHjzZx0uKN+dWNg==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
 Alexander Koch <akoch@initse.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] arm64: dts: imx8mn: Generate FSPI header using binman
 imx8mimage
Date: Sun, 24 May 2026 19:22:56 +0200
Message-ID: <20260524172402.119517-3-marex@nabladev.com>
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
 arch/arm/dts/imx8mn-u-boot.dtsi | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot.dtsi
index 29eecd6d70d..8993605af3c 100644
--- a/arch/arm/dts/imx8mn-u-boot.dtsi
+++ b/arch/arm/dts/imx8mn-u-boot.dtsi
@@ -104,14 +104,6 @@
 	section {
 		pad-byte = <0x00>;
 
-#ifdef CONFIG_FSPI_CONF_HEADER
-		fspi_conf_block {
-			filename = CONFIG_FSPI_CONF_FILE;
-			type = "blob-ext";
-			offset = <0x400>;
-		};
-#endif
-
 #ifdef CONFIG_IMX_HAB
 		nxp-imx8mcst@0 {
 			filename = "u-boot-spl-mkimage.signed.bin";
@@ -122,7 +114,12 @@
 
 			binman_imx_spl: nxp-imx8mimage {
 				filename = "u-boot-spl-mkimage.bin";
+#ifdef CONFIG_FSPI_CONF_HEADER
+				nxp,boot-from = "fspi";
+				nxp,fspi-header-filename = CONFIG_FSPI_CONF_FILE;
+#else
 				nxp,boot-from = "sd";
+#endif
 				nxp,rom-version = <2>;
 				nxp,loader-address = <CONFIG_SPL_TEXT_BASE>;
 				args;	/* Needed by mkimage etype superclass */
-- 
2.53.0

