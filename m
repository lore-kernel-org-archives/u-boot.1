Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18AAD5E393
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 06:29:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6812F8945A;
	Mon, 18 Nov 2024 07:27:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731911259;
	bh=e37g32Z0fu8ktwzSh+/27tEtJttcCvrcOOtJFoUndTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gD3uDpe6CR0h1W6LhLMsgvpnbYhUh7pa/o3uNQjLlAaZezwkIYxsNC0i59s6gk9KV
	 oKVVBWwxWbj+Xog/SWe3SPIIcvtb+t83GdNSUAJoP8REYkSC6fe4NLg13cTYH01enm
	 3ZbDyDXmDtfKD/rsLb51yBL/bm2kYwma+9S/OkOxGZfHyhtFn+f+pmSmo7kbWMbXQ9
	 Ej/UgiaakGF6Ho1PchI1MLc0uP7eH8ByHl855Tjls8CYYhqwnpHjMNaG9C7lBeWM0F
	 d7A0l4pIqt5J43oDQIH4/FDKjmt3mjsnj7OUszcu35CCMrU0aQzLFDqIM3KclblP6P
	 xjseF8Byk9KKQ==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0CE06893E2;
 Mon, 18 Nov 2024 07:27:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731911255;
 bh=e37g32Z0fu8ktwzSh+/27tEtJttcCvrcOOtJFoUndTA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qg0BpkVALI/VNgPprPzlWJasb+teUJu7NoGYOdFufYTqFn7gnrghvY82z8HTV4T34
 Y91P7TWcnpt/XYMgVQZM8tyhaiMzFaTsq9FsKp4Ca2PK3juKKYfH3ildDk+DmSiBp8
 gHori4BGpmOXQYUSWY51suxtW9dsJSVLgXda2nb7+RkxURyi08XURbQ6wSTg9eYgUO
 xPD44ihfgb66cdp9qIhIcH0GZrnD+WtZDrUEnsYAms55H8fRqLA96/IbIPNe+AFHXc
 jEfizs9N3L6+sBpaExawHZIE6lt1oKpZXFjw96h0P5ULCrB3wgbRZW0ZJQeODCPFx5
 zUlPP+p3vTlDQ==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Walter Schweizer <walter.schweizer@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@denx.de>, Anatolij Gustschin <agust@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 13/20] siemens: imx8-capricorn.dtsi: add wdt device
Date: Mon, 18 Nov 2024 07:27:07 +0100
Message-Id: <20241118062715.32989-14-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241118062715.32989-1-hs@denx.de>
References: <20241118062715.32989-1-hs@denx.de>
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

add wdt device

Signed-off-by: Heiko Schocher <hs@denx.de>

---

Changes in v2:
- add comments rom Fabio and Enrico
  do not remove DMA for console
  remove u-boot specific property addition, instead
  add it in arch/arm/dts/imx8qxp-u-boot.dtsi

 arch/arm/dts/imx8-capricorn.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/imx8-capricorn.dtsi b/arch/arm/dts/imx8-capricorn.dtsi
index 4918bf8f567..3734a9d21f1 100644
--- a/arch/arm/dts/imx8-capricorn.dtsi
+++ b/arch/arm/dts/imx8-capricorn.dtsi
@@ -17,6 +17,11 @@
 		stdout-path = &lpuart2;
 	};
 
+	/* create device for u-boot wdt command */
+	scu-wdt {
+		compatible = "siemens,scu-wdt";
+	};
+
 };
 
 &iomuxc {
-- 
2.20.1

