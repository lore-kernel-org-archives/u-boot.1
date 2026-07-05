Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE4CC43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 21:20:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 378ED8486A;
	Sun,  5 Jul 2026 23:20:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="PDu7picD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E47BF846F8; Sun,  5 Jul 2026 23:20:46 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F28A6847C8
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 23:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DCCD011740D; Sun,  5 Jul 2026 23:20:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1783286444; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=oevHkN7zA32ft7fCC8pNaNSaEOCCRRgvWtYt/ocEaiQ=;
 b=PDu7picDBQnIou3o7/4DTs3VA3LCbbHESRuXRskvVxRB6Dayavq7kLQC1CHvhM/vaolucj
 Stqt2BQMez0KAxqF9+FNRGuhICo++/fZtYNQ+2RrtPayznJb1rACWANzz9XYOqAfKojFcP
 N0WK1TOirRqtJxqS53PgFHU/Yo7QV5vKQzHiG9NUIlLolM7Krc4+qmLNTtQZ9tECME38cn
 AOa3AwLvJ1N1FykJi0IZXnJuCc2aFNHNSsu0zrowGxwI+NRqR6ZNd8dmRFCVd2Y58GUsbP
 IdBLWd4j8kcC+JrSt6NLU5NOTCqPOQl9WUMVBS2fatEHG1WSsWKspVTrfxHfhg==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>, Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v4 2/3] arm64: dts: imx8mm: Drop nxp,fspi-header-filename
Date: Sun,  5 Jul 2026 23:19:06 +0200
Message-ID: <20260705212037.319801-2-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705212037.319801-1-marex@nabladev.com>
References: <20260705212037.319801-1-marex@nabladev.com>
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

The FSPI header is now generated purely using binman, drop no longer
supported nxp,fspi-header-filename property.

Acked-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Cc: Yannic Moog <y.moog@phytec.de>
Cc: u-boot@lists.denx.de
---
V2: - New patch
V3: - Add AB from Peng
    - Add RB from Simon
V4: No change
---
 arch/arm/dts/imx8mm-u-boot.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-u-boot.dtsi
index 56ab70e54ea..2e00cc388cd 100644
--- a/arch/arm/dts/imx8mm-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-u-boot.dtsi
@@ -62,7 +62,6 @@
 				filename = "u-boot-spl-mkimage.bin";
 #ifdef CONFIG_FSPI_CONF_HEADER
 				nxp,boot-from = "fspi";
-				nxp,fspi-header-filename = CONFIG_FSPI_CONF_FILE;
 #else
 				nxp,boot-from = "sd";
 #endif
-- 
2.53.0

