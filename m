Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6C6C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 04:31:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0357686C72;
	Mon, 13 Nov 2023 05:30:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iPXszav4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B0CE86FB6; Mon, 13 Nov 2023 05:30:40 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76A4786EE0
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 05:30:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AD4UXxv128766;
 Sun, 12 Nov 2023 22:30:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699849833;
 bh=PY2W1xHxbCgFEE1qIIbFFfMeh+r9GLtQujlFZ/s22qg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=iPXszav4mtiNI1IoXKwy4s78zINb6KnouLN2h2iY7+p0jvmTm/FLEfJpC1H4/AP3d
 GLymIsFv+ZKlBYm5NdQFn9d+MVVJtrGG2fgMHWa8IJ/SUg5JM741cbuVl2uqHYEB81
 s2JosJMcl8hDy22tpbD0dwBFaJaXCya2jOHzN9h4=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AD4UXOW040044
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 12 Nov 2023 22:30:33 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 12
 Nov 2023 22:30:33 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 12 Nov 2023 22:30:33 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AD4UOX7119664;
 Sun, 12 Nov 2023 22:30:30 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <nm@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <reidt@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>
Subject: [PATCH 2/2] arm: dts: k3-j721e-*: Sync with kernel v6.7-rc1
Date: Mon, 13 Nov 2023 10:00:23 +0530
Message-ID: <20231113043023.2126690-3-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113043023.2126690-1-n-francis@ti.com>
References: <20231113043023.2126690-1-n-francis@ti.com>
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

Sync the U-Boot DTS files with those of Kernel v6.7-rc1.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm/dts/k3-j721e-main.dtsi       | 2 +-
 arch/arm/dts/k3-j721e-mcu-wakeup.dtsi | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/k3-j721e-main.dtsi b/arch/arm/dts/k3-j721e-main.dtsi
index f6c7e16145..746b9f8b1c 100644
--- a/arch/arm/dts/k3-j721e-main.dtsi
+++ b/arch/arm/dts/k3-j721e-main.dtsi
@@ -181,7 +181,7 @@
 	};
 
 	main_navss: bus@30000000 {
-		compatible = "simple-mfd";
+		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges = <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>;
diff --git a/arch/arm/dts/k3-j721e-mcu-wakeup.dtsi b/arch/arm/dts/k3-j721e-mcu-wakeup.dtsi
index 05d6ef127b..f7ab7719fc 100644
--- a/arch/arm/dts/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm/dts/k3-j721e-mcu-wakeup.dtsi
@@ -440,7 +440,7 @@
 	};
 
 	mcu_navss: bus@28380000 {
-		compatible = "simple-mfd";
+		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>;
@@ -671,4 +671,11 @@
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

