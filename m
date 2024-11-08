Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CE5D5E12D
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 05:24:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6664389221;
	Fri,  8 Nov 2024 06:22:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731043328;
	bh=+E8z6YVZNtMaEMjGM3qDrYIPNgjH1FykNqF+oM9Mq0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hiaLlOtlPFyv8/bMjwY6tOmQEoSFSZDYlYaSF99fFhLq8n385BNjyqE9vZg4vC+3U
	 GOEqIdHaRsJFNexmficDz1uM7QRij/JemRHpQMVNafNyLxMhp9DCt/Axpoif1/EVUA
	 l+KS0MDMZfWXaZ5ds4Verys5xLM0Wi4R9r8AKM2iC+SARanFQEu8dXl2lHnznB6Iek
	 WyzPIFG0J4YSUPW2dSbdq0KgALtlrktGXOTYg+ooqdFUyd4Hon1+9A3h+D78IW7IBJ
	 x5KbxShhzMnHncyKml2Yh23OIKrP9UziC1abGeKn7VE/ZfYso/WVFXguyCmNeR2tj2
	 He5JJfrX6cxMQ==
Received: from localhost.localdomain (87-97-112-21.pool.digikabel.hu
 [87.97.112.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5B2A48909B;
 Fri,  8 Nov 2024 06:22:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731043325;
 bh=+E8z6YVZNtMaEMjGM3qDrYIPNgjH1FykNqF+oM9Mq0Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vqHikNB7mVcOCYaWj4fqvpy9kjM8PuaXIc5i7pyOJCZHobrSr4MT+jDCzcBgFZ/0t
 oq1QnVBldoLl8i5+1vrg7Q3YTdXoXwZREeYzF2KmCBJBVcVTeGFrD+ChyV8xAgf6l/
 j6PpK4hS5Sgs3n1Qo7m2NmYH1LzlAJfj2/4gqf/hQWeu9+5LKWM3mBL1op036FHc/1
 lLki4IAvtEW0fNtv5VKDfgJ+7Ze3COdyRn2QVfnHjqkgvE5zmNW705JcgKMCVNB4Bz
 xI9dCFxELSyNmFZ0ciW/uP71Gw+/hJ5H4ylpoIaMajTigFv76dhXQ1zrJNkungoiPx
 i4ZlPgqMuzHOw==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Enrico Leto <enrico.leto@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@denx.de>, Anatolij Gustschin <agust@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 15/22] siemens: imx8-capricorn.dtsi: small adaptions
Date: Fri,  8 Nov 2024 06:21:36 +0100
Message-Id: <20241108052143.26874-16-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241108052143.26874-1-hs@denx.de>
References: <20241108052143.26874-1-hs@denx.de>
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

- remove DMA for console
- add wdt device

Signed-off-by: Heiko Schocher <hs@denx.de>
---

 arch/arm/dts/imx8-capricorn.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/dts/imx8-capricorn.dtsi b/arch/arm/dts/imx8-capricorn.dtsi
index 4918bf8f567..f6f9dc7df19 100644
--- a/arch/arm/dts/imx8-capricorn.dtsi
+++ b/arch/arm/dts/imx8-capricorn.dtsi
@@ -17,6 +17,22 @@
 		stdout-path = &lpuart2;
 	};
 
+	/* remove DMA for console */
+	lpuart2: serial@5a080000 {
+		power-domains = <&pd_dma_lpuart2>;
+		dma-names = "";
+		dmas = <0>;
+	};
+
+	/* create device for u-boot wdt command */
+	scu-wdt {
+		compatible = "siemens,scu-wdt";
+	};
+
+};
+
+&A35_0 {
+	bootph-all;
 };
 
 &iomuxc {
-- 
2.20.1

