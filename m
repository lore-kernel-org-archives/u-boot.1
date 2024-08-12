Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2F4C3DA7F
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 11:50:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27817886E7;
	Mon, 12 Aug 2024 13:50:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="W4AkQhix";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E77F88829; Mon, 12 Aug 2024 13:50:03 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D80D87B77
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 13:50:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47CBnm1X023030;
 Mon, 12 Aug 2024 06:49:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723463388;
 bh=rZ5Pgb1DNnHNhbBOpJqd5a9+/mfSE/N8Xo9+Q9j/wTs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=W4AkQhixj6jR7N/bGqVe+fDY89klyKPe6iSKdnYXXt1LHjGBrOyTHSqWlAa9ZHTKk
 8L0aoBCJ+HMmYNXvtXxgzhfD7/xBeBXdplXb+6blPkBGqtYZPLxiPiyPc36+S5ReUc
 AQhO4PwwecAVf0dquMMW0nboy6BZzQOX2Hdgtx3k=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47CBnmjT091834
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 12 Aug 2024 06:49:48 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Aug 2024 06:49:48 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Aug 2024 06:49:48 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47CBnlJR060153;
 Mon, 12 Aug 2024 06:49:48 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Michal Simek <michal.simek@amd.com>, Bryan Brattlof <bb@ti.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 "MD Danish Anwar" <danishanwar@ti.com>, Ravi
 Gunasekaran <r-gunasekaran@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>,
 Andreas Dannenberg <dannenberg@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar <devarsht@ti.com>, Sean
 Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Kishon Vijay
 Abraham I <kishon@ti.com>, Andrew Davis <afd@ti.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Wadim Egorov <w.egorov@phytec.de>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Dhruva Gole <d-gole@ti.com>, Chintan Vankar
 <c-vankar@ti.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Nishanth Menon <nm@ti.com>, Sumit Garg <sumit.garg@linaro.org>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v4 10/10] dts: upstream: src: arm64: ti: k3-am62x-sk-common:
 Sync DT with Linux v6.11-rc3
Date: Mon, 12 Aug 2024 17:19:45 +0530
Message-ID: <20240812114945.3844224-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812113621.3840652-1-c-vankar@ti.com>
References: <20240812113621.3840652-1-c-vankar@ti.com>
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

Sync Device tree nodes with Linux v6.11-rc3.

[ upstream commit: ba50141137fae205a731005e70687f4a52289050 ]

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v3:
- This link is for the patch which was equivalent to this patch, from
  this version the node is moved to DT file equivalent to Linux as a
  part of DT sync.
  https://lore.kernel.org/r/20240705045030.1141934-11-c-vankar@ti.com/

Changes from v3 to v4:
- Updated this patch by syncing "k3-am62x-sk-common.dtsi" file
  with Linux v6.11-rc3 compared to previous version.

 .../src/arm64/ti/k3-am62x-sk-common.dtsi      | 32 ++++++++++---------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi b/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
index 3c45782ab2..44ff67b6bf 100644
--- a/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
@@ -48,6 +48,14 @@
 			pmsg-size = <0x8000>;
 		};
 
+		/* global cma region */
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x00 0x8000000>;
+			linux,cma-default;
+		};
+
 		secure_tfa_ddr: tfa@9e780000 {
 			reg = <0x00 0x9e780000 0x00 0x80000>;
 			alignment = <0x1000>;
@@ -128,6 +136,10 @@
 	};
 };
 
+&phy_gmii_sel {
+	bootph-all;
+};
+
 &main_pmx0 {
 	/* First pad number is ALW package and second is AMC package */
 	main_uart0_pins_default: main-uart0-default-pins {
@@ -156,6 +168,7 @@
 	};
 
 	main_i2c1_pins_default: main-i2c1-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x1e8, PIN_INPUT_PULLUP, 0) /* (B17/A17) I2C1_SCL */
 			AM62X_IOPAD(0x1ec, PIN_INPUT_PULLUP, 0) /* (A17/A16) I2C1_SDA */
@@ -335,15 +348,9 @@
 			self-powered;
 			data-role = "dual";
 			power-role = "sink";
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port@0 {
-					reg = <0>;
-					usb_con_hs: endpoint {
-						remote-endpoint = <&usb0_hs_ep>;
-					};
+			port {
+				usb_con_hs: endpoint {
+					remote-endpoint = <&usb0_hs_ep>;
 				};
 			};
 		};
@@ -470,12 +477,9 @@
 
 &usb0 {
 	bootph-all;
-	#address-cells = <1>;
-	#size-cells = <0>;
 	usb-role-switch;
 
-	port@0 {
-		reg = <0>;
+	port {
 		usb0_hs_ep: endpoint {
 		    remote-endpoint = <&usb_con_hs>;
 	       };
@@ -504,8 +508,6 @@
 	       0 0 0 0
 	       0 0 0 0
 	>;
-	tx-num-evt = <32>;
-	rx-num-evt = <32>;
 };
 
 &dss {
-- 
2.34.1

