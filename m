Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518F4CE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 13:26:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD85286D23;
	Mon, 25 Sep 2023 15:26:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="y3cmoxZh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 683FE86C48; Mon, 25 Sep 2023 15:26:31 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E0FF86C48
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 15:26:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j-keerthy@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38PDQRFE111897;
 Mon, 25 Sep 2023 08:26:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695648387;
 bh=pJXLF94GDhVvnVF5JtQY8RM/VAIYH4maIUfpkzOqyhM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=y3cmoxZh1JnzDAWn5JcgltMuJY9XXG/3a8XLrgaFuDkWCCGZ6sIcMtgK9RcIiq3At
 58ooIqWDaaOS9vjrHMaC0GjAWXc9RyFV+Rq8JtQ0SxNg3FtB1OkCZNH+So2iaWhees
 CfhXmiVAqkFcXqG8mcNOgKTHqjyq+yqAPlFc7WmI=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38PDQRrx035993
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 25 Sep 2023 08:26:27 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Sep 2023 08:26:27 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Sep 2023 08:26:27 -0500
Received: from keerthy.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38PDQMsJ023302; 
 Mon, 25 Sep 2023 08:26:25 -0500
From: Keerthy <j-keerthy@ti.com>
To: <trini@konsulko.com>
CC: <j-keerthy@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>,
 <vigneshr@ti.com>
Subject: [PATCH 1/2] arm64: dts: ti: k3-j721s2: Add ESM instances
Date: Mon, 25 Sep 2023 18:56:13 +0530
Message-ID: <20230925132614.3747-2-j-keerthy@ti.com>
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

Patch adds the ESM instances for j721s2. It has 3 instances.
One in the main domain and two in the mcu-wakeup domian.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/dts/k3-j721s2-main.dtsi       |  7 +++++++
 arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm/dts/k3-j721s2-main.dtsi b/arch/arm/dts/k3-j721s2-main.dtsi
index 976ba1e95a..859b5124ae 100644
--- a/arch/arm/dts/k3-j721s2-main.dtsi
+++ b/arch/arm/dts/k3-j721s2-main.dtsi
@@ -934,4 +934,11 @@
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
 	};
+
+	main_esm: esm@700000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x00 0x700000 0x00 0x1000>;
+		ti,esm-pins = <688>, <689>;
+		bootph-pre-ram;
+	};
 };
diff --git a/arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi b/arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi
index 7521963719..f28cf7df50 100644
--- a/arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi
@@ -299,4 +299,18 @@
 			ti,cpts-periodic-outputs = <2>;
 		};
 	};
+
+	mcu_esm: esm@40800000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x00 0x40800000 0x00 0x1000>;
+		ti,esm-pins = <95>;
+		bootph-pre-ram;
+	};
+
+	wkup_esm: esm@42080000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x00 0x42080000 0x00 0x1000>;
+		ti,esm-pins = <63>;
+		bootph-pre-ram;
+	};
 };
-- 
2.17.1

