Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF37BC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 08:41:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0941484942;
	Tue, 30 Jun 2026 10:41:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="BN20Hx75";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 589D784A1F; Tue, 30 Jun 2026 10:41:24 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2001584942
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 10:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3F4821168CD; Tue, 30 Jun 2026 10:41:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1782808880; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=icyjja2cHzdGwdHQy2FiPhpSSbLvBrtn3Xe6x7mKkis=;
 b=BN20Hx75dcZQMm8m+BUrl/UY+H2cx29BtrMRhWGLsvw7ABTCw4Hoy9bxsTZeKq8rKBP9rO
 NgBaFfcqrBGBIoQu4glZviC/r7ys/tNd/xOZH3GEQJfcOIg+GKmubxKmj4+kUc2UOnmHRh
 bcriZmqvFBPL5/0h/IG4dT5RTONeJV8pEUpoj6kDQhL925XBJ1/WN8/EjrEH6475/FcGdI
 AtJistNI5SC2s/p22qDkFbFErayDUXzsR2bISxjJJyL6PVhAhzTTJi/O5KRuvFDlebtF/D
 RSc9It73Z9hb7FvtdrGwHjDNTwpwkKjOFkNPoqhz1foq6mjUPtCVvHrLfNDebg==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>, Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v2 3/3] arm64: dts: imx8mn: Drop nxp,fspi-header-filename
Date: Tue, 30 Jun 2026 10:40:48 +0200
Message-ID: <20260630084112.13259-3-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630084112.13259-1-marex@nabladev.com>
References: <20260630084112.13259-1-marex@nabladev.com>
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
---
 arch/arm/dts/imx8mn-u-boot.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot.dtsi
index 8993605af3c..60e222ef970 100644
--- a/arch/arm/dts/imx8mn-u-boot.dtsi
+++ b/arch/arm/dts/imx8mn-u-boot.dtsi
@@ -116,7 +116,6 @@
 				filename = "u-boot-spl-mkimage.bin";
 #ifdef CONFIG_FSPI_CONF_HEADER
 				nxp,boot-from = "fspi";
-				nxp,fspi-header-filename = CONFIG_FSPI_CONF_FILE;
 #else
 				nxp,boot-from = "sd";
 #endif
-- 
2.53.0

