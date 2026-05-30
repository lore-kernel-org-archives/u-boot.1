Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB441CD6E49
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 17:10:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF1B1846FD;
	Sat, 30 May 2026 19:10:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="IBhmwg0F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ED2D84671; Sat, 30 May 2026 19:10:08 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4AE0846A5
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 19:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B9CD91169C1; Sat, 30 May 2026 19:10:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1780161004; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=om5UEDp1pKXlu1CRC3ZZTo1GKeXToz1IubOX8THJVOg=;
 b=IBhmwg0FUIfxnEdO/n4KYMEj4bvh8Vnl6bGeE+D7YPO9z4dy+DTiWcEmvApA8lJM29TiFB
 27a2dk/VcRFSo3+h21dw4i6O/J30Et81PGiTdaJ/ChYfEbeadODIiijidQFSLCjNlbDTjA
 RY+ydZMfQWkONwkAe0jMuzuqDbrp9yvGGyikRzDqPFxaAwl/EXrAJkyd7ZUqU5Wp5v6hXA
 FfmHd35I4AnotXEWZZfHCd5dLnoYT2j2Hm/ysCE8H1k7zoCUPJbkp8uMYe0H65rJStNdPZ
 ITlhk5QHNIZSRrRuRQ9zx5qw+0BH0WdigJaRETFtlY3UGRWeaCUFPQWLj9hQRQ==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
 Alexander Koch <akoch@initse.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 3/3] arm64: dts: imx8mn: Generate FSPI header using binman
 imx8mimage
Date: Sat, 30 May 2026 19:08:26 +0200
Message-ID: <20260530170954.239682-3-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530170954.239682-1-marex@nabladev.com>
References: <20260530170954.239682-1-marex@nabladev.com>
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
V2: No change
V3: No change
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

