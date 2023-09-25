Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA81CE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 13:26:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 193A286C67;
	Mon, 25 Sep 2023 15:26:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LDK6NgJQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 986FD86D2D; Mon, 25 Sep 2023 15:26:33 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90B6A86C48
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 15:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j-keerthy@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38PDQTRM006615;
 Mon, 25 Sep 2023 08:26:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695648389;
 bh=ENF6vit6CzwrgG22Pldl4E6zrG+4kCiXPKFlcFFNh9k=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=LDK6NgJQRhwu+vf3TMbSLTjkc/lst1feOn/i0Bkghoo+EF4JpqP+/RYBJPDnryG7W
 8/YHwf1H1eJeDyr7zaDRq1rJ2rh07aTi2jTnpaAWht7Nf7CXzS+9OXpnBb7C1KHIKo
 S6wLuAh0rWKN2yPbOWpNdWEt50cMBJMibuH+NIqk=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38PDQTFL022162
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 25 Sep 2023 08:26:29 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Sep 2023 08:26:29 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Sep 2023 08:26:29 -0500
Received: from keerthy.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38PDQMsK023302; 
 Mon, 25 Sep 2023 08:26:27 -0500
From: Keerthy <j-keerthy@ti.com>
To: <trini@konsulko.com>
CC: <j-keerthy@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>,
 <vigneshr@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-j7200: Add MCU domain ESM instance
Date: Mon, 25 Sep 2023 18:56:14 +0530
Message-ID: <20230925132614.3747-3-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230925132614.3747-1-j-keerthy@ti.com>
References: <20230925132614.3747-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Patch adds the ESM instance for MCU domian of j7200.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/dts/k3-j7200-mcu-wakeup.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/dts/k3-j7200-mcu-wakeup.dtsi b/arch/arm/dts/k3-j7200-mcu-wakeup.dtsi
index 1044ec6c4b..2b185fa350 100644
--- a/arch/arm/dts/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm/dts/k3-j7200-mcu-wakeup.dtsi
@@ -375,4 +375,11 @@
 			ti,loczrama = <1>;
 		};
 	};
+
+	mcu_esm: esm@40800000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x00 0x40800000 0x00 0x1000>;
+		ti,esm-pins = <95>;
+		bootph-pre-ram;
+	};
 };
-- 
2.17.1

