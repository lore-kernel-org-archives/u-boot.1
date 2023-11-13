Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DCFC4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 20:43:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 679C987084;
	Mon, 13 Nov 2023 21:43:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gHV/0vkr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A15786FB2; Mon, 13 Nov 2023 21:43:23 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A84F870B4
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 21:43:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=reidt@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ADKhJoJ106022;
 Mon, 13 Nov 2023 14:43:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699908199;
 bh=n1ZO4opICG+T5lYkCLzUx6+01PjsV/xjlIcLf0WhOSs=;
 h=From:To:CC:Subject:Date;
 b=gHV/0vkr/hl/qb9O90aV4qWeIKpYMT33dGCT8OHNrH7mIrBGYun+cWJ2ba6zEIR4p
 DKjCtsSLC0QGnoV0UnJ1Rt2pjzJvOJ2ERgqGOHwqqfDyOU+IGua0wJwPYZqSfrW+Yp
 p8Grq0T8zz/J7tIVTFPWhsg5OFgl2i1USiGwsWzg=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ADKhI9X090548
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 13 Nov 2023 14:43:19 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 Nov 2023 14:43:18 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 Nov 2023 14:43:18 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ADKhIo6126840;
 Mon, 13 Nov 2023 14:43:18 -0600
From: Reid Tonking <reidt@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <vigneshr@ti.com>, <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>
Subject: [PATCH] arm: dts: k3-j7200: Sync with Linux 6.7-rc1
Date: Mon, 13 Nov 2023 14:43:09 -0600
Message-ID: <20231113204309.3246434-1-reidt@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Sync u-boot device tree with Linux kernel 6.7-rc1

Signed-off-by: Reid Tonking <reidt@ti.com>
---
Boot-log: https://gist.github.com/reidt1/db5426f2a778369db8c3699cf293b94f

 arch/arm/dts/k3-j7200-main.dtsi       | 2 +-
 arch/arm/dts/k3-j7200-mcu-wakeup.dtsi | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/k3-j7200-main.dtsi b/arch/arm/dts/k3-j7200-main.dtsi
index cdb1d6b2a9..264913f832 100644
--- a/arch/arm/dts/k3-j7200-main.dtsi
+++ b/arch/arm/dts/k3-j7200-main.dtsi
@@ -91,7 +91,7 @@
 	};
 
 	main_navss: bus@30000000 {
-		compatible = "simple-mfd";
+		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges = <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>;
diff --git a/arch/arm/dts/k3-j7200-mcu-wakeup.dtsi b/arch/arm/dts/k3-j7200-mcu-wakeup.dtsi
index 6ffaf85fa6..3fc588b848 100644
--- a/arch/arm/dts/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm/dts/k3-j7200-mcu-wakeup.dtsi
@@ -318,7 +318,7 @@
 	};
 
 	mcu_navss: bus@28380000 {
-		compatible = "simple-mfd";
+		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>;
@@ -637,4 +637,11 @@
 		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
 		#thermal-sensor-cells = <1>;
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
2.34.1

