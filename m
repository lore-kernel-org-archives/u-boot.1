Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180EBC43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 21:21:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74CBA84857;
	Sun,  5 Jul 2026 23:20:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="K6LUaO2y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACB52848D2; Sun,  5 Jul 2026 23:20:48 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3B6A8484C
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 23:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B456E117467; Sun,  5 Jul 2026 23:20:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1783286445; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=vvlxVpljNugCc+tb1+i8yVNBCR0e+2cisBiWWTWz47w=;
 b=K6LUaO2ytPQx4kfFOUuViTSTn60Rho++X17p4Mg8DZb2h3DJqNpmt2q9vcz2/YoBz9v+wM
 rL/D7HlCtkBMSOXFuVkKYkwSm8OdKs2h/69aMGecsIAbdnMQcPv1h4E3ERRP3sNhYpggVw
 1+66WqRpnkrfWL4AWq6dyK96juyrGohMVB/iGe3EWgvAE5XVtYBnAfxSqxjBeeCWRAXB5d
 kNkJ85Bt3DEqZXa7u4rB8HXRDZS9iwDKOI/oH5txFE/ptIymiRZocaZ6vGxYrEu00esAFw
 KIBNivN3HrwtaGiuF9EzdYYL3L8s26c4EvAPGho3/TiMGvHJQpSFnGHarSaYSg==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>, Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v4 3/3] arm64: dts: imx8mn: Drop nxp,fspi-header-filename
Date: Sun,  5 Jul 2026 23:19:07 +0200
Message-ID: <20260705212037.319801-3-marex@nabladev.com>
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
 arch/arm/dts/imx8mn-u-boot.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot.dtsi
index e4918bf5975..9840ff56da6 100644
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

