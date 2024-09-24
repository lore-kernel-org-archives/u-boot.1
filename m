Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC5BCF9C6B
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 13:02:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12DFA8814D;
	Tue, 24 Sep 2024 15:02:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727182953;
	bh=dbTFt3FLAtOTlbrq/03zNU7icV9OEz+YxB0q5HQptUA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ITMprwoay/iDs36efJZFKJ1jZpiS1kUrr/pTQcEqURR3ayl9K8M7quRkWTmyS2a6u
	 8wJVtVJZPRPKu0SCuek3SBVo3Y4nUlKlFK2yEbHZoYrHl1AHNZAoBk5ZCLML+t/yWU
	 zbnVaNRfetVTULvziqfOP82gLzdiRJPQ+Z+c/6sFuXjAdocKdoarmNLvp8iVuS5I8E
	 3+TsHyrqBDQO1xa6KDfOcoMN2vEgWXzHsP4z1lR/qGor+4DgWzkwzRjKEIJ6Jf3mfw
	 oTZN1lnQVqcCvVbXR0zOl8A06Oq1BRRcx43yv9CBW47PBkQACPM5LbY/yTf/EuJNkY
	 13ax1bUZQ7wyg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 78A06881C1;
 Tue, 24 Sep 2024 15:02:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727182951;
 bh=dbTFt3FLAtOTlbrq/03zNU7icV9OEz+YxB0q5HQptUA=;
 h=From:To:Cc:Subject:Date:From;
 b=eLf5x4jFQl/sG4Uh6ZAC8mpgDHxdD/WNdY20Uyp1rwvPRLzfJPQ+FsU2gFO+zepbm
 /238tuje23tG0FLse0UX7dff7pFvjkuYlLRyq9a01QGUCA4swuXfxwJvgEPv12kZSG
 2lv33leR1knq6dnqJiN4jX5l3OKZbqleJYdbFk/4owN+SMPMpdgiQSETcAyHFh2b8c
 nBqoBMei4Gn9Pffp1DXLLArUEZW1Tmyjn6Ep6lt5Nvy+YhtrrATnowl1AmVy/QlXri
 JiQKQPYkL/qD1eRBmK2Qb/EZgsL9Wov9Ys8h75/kQV1bSLaZ3/PifLNSmO17b2ZiEB
 vpiA22MGKGJTg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Peng Fan <peng.fan@nxp.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Stefano Babic <sbabic@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: dts: imx8m: Always name the generated fitImage
 u-boot.itb
Date: Tue, 24 Sep 2024 15:02:09 +0200
Message-ID: <20240924130218.308845-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Maintain backward compatibility with pre-binman u-boot file naming,
the U-Boot fitImage used to be named u-boot.itb before, restore the
file name after binman conversion.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/imx8mm-u-boot.dtsi | 1 +
 arch/arm/dts/imx8mn-u-boot.dtsi | 1 +
 arch/arm/dts/imx8mp-u-boot.dtsi | 1 +
 arch/arm/dts/imx8mq-u-boot.dtsi | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-u-boot.dtsi
index c02e11def5f..d31bc822532 100644
--- a/arch/arm/dts/imx8mm-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-u-boot.dtsi
@@ -122,6 +122,7 @@
 
 			binman_imx_fit: fit {
 				description = "Configuration to load ATF before U-Boot";
+				filename = "u-boot.itb";
 #ifndef CONFIG_IMX_HAB
 				fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
 #endif
diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot.dtsi
index 732191f5205..6875c6d44ff 100644
--- a/arch/arm/dts/imx8mn-u-boot.dtsi
+++ b/arch/arm/dts/imx8mn-u-boot.dtsi
@@ -193,6 +193,7 @@
 
 			binman_imx_fit: fit {
 				description = "Configuration to load ATF before U-Boot";
+				filename = "u-boot.itb";
 #ifndef CONFIG_IMX_HAB
 				fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
 #endif
diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-u-boot.dtsi
index f2655a4d0c8..56749ccacd2 100644
--- a/arch/arm/dts/imx8mp-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-u-boot.dtsi
@@ -148,6 +148,7 @@
 
 			binman_imx_fit: fit {
 				description = "Configuration to load ATF before U-Boot";
+				filename = "u-boot.itb";
 #ifndef CONFIG_IMX_HAB
 				fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
 #endif
diff --git a/arch/arm/dts/imx8mq-u-boot.dtsi b/arch/arm/dts/imx8mq-u-boot.dtsi
index 9b895a63857..d7a83a78f4d 100644
--- a/arch/arm/dts/imx8mq-u-boot.dtsi
+++ b/arch/arm/dts/imx8mq-u-boot.dtsi
@@ -106,6 +106,7 @@
 
 			binman_imx_fit: fit {
 				description = "Configuration to load ATF before U-Boot";
+				filename = "u-boot.itb";
 #ifndef CONFIG_IMX_HAB
 				fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
 #endif
-- 
2.45.2

