Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BBCEEB562
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 17:30:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76DD986AAF;
	Fri,  8 Sep 2023 19:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QH3yn9kk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14D5F86AAF; Fri,  8 Sep 2023 19:30:39 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0461B86A97
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 19:30:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 388HUX4s114689;
 Fri, 8 Sep 2023 12:30:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694194233;
 bh=YuF7auLPTghu0m4jTvOqEoTxx3wHgjiagPMq9EZDe0c=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=QH3yn9kkjd0NOJE0DupxwTlMuZvWEjb9oD6dcbxlaA254vBRbeHlDA/yVqUsj3YL2
 r34wPgebWlUENAbwLp90yAo04cJZdHiRTI8rCW1Zp2NGu+3crEx7Mie6AA/A3jVJVO
 aHx+/vcOZUuODOYVsOINEqcdyVK1Ok8IoKjIMihM=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 388HUXZS054595
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 8 Sep 2023 12:30:33 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Sep 2023 12:30:33 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Sep 2023 12:30:33 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 388HTfxL052571;
 Fri, 8 Sep 2023 12:30:30 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <sjg@chromium.org>
CC: <peng.fan@nxp.com>, <ye.li@nxp.com>, <robimarko@gmail.com>,
 <u-boot@lists.denx.de>, <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [RFC PATCH v2 3/3] arm: dts: k3: update device tree for vtm node
Date: Fri, 8 Sep 2023 22:59:17 +0530
Message-ID: <20230908172914.436194-4-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908172914.436194-1-u-kumar1@ti.com>
References: <20230908172914.436194-1-u-kumar1@ti.com>
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

Update device tree for vtm node and update driver compatible too

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
Kernel DT sync is happening in other series. So this patch is added
just for testing and make sure functions are working ok

 arch/arm/dts/k3-j7200-mcu-wakeup.dtsi          |  9 +++++++++
 arch/arm/dts/k3-j7200-r5-common-proc-board.dts |  6 ------
 arch/arm/dts/k3-j721e-mcu-wakeup.dtsi          | 10 ++++++++++
 arch/arm/dts/k3-j721e-r5-common-proc-board.dts |  7 -------
 arch/arm/dts/k3-j721e-r5-sk.dts                |  7 -------
 drivers/thermal/k3_thermal.c                   |  2 ++
 6 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/arch/arm/dts/k3-j7200-mcu-wakeup.dtsi b/arch/arm/dts/k3-j7200-mcu-wakeup.dtsi
index 1044ec6c4b..217bb0c821 100644
--- a/arch/arm/dts/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm/dts/k3-j7200-mcu-wakeup.dtsi
@@ -375,4 +375,13 @@
 			ti,loczrama = <1>;
 		};
 	};
+
+	wkup_vtm0: temperature-sensor@42040000 {
+		bootph-all;
+		compatible = "ti,j7200-vtm";
+		reg = <0x00 0x42040000 0x00 0x350>,
+			<0x00 0x42050000 0x00 0x350>;
+		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
+		#thermal-sensor-cells = <1>;
+	};
 };
diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
index e62f9218e8..bcd5f15eb5 100644
--- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
@@ -91,12 +91,6 @@
 		bootph-pre-ram;
 	};
 
-	wkup_vtm0: vtm@42040000 {
-		compatible = "ti,am654-vtm", "ti,j721e-avs";
-		reg = <0x0 0x42040000 0x0 0x330>;
-		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
-		#thermal-sensor-cells = <1>;
-	};
 };
 
 &dmsc {
diff --git a/arch/arm/dts/k3-j721e-mcu-wakeup.dtsi b/arch/arm/dts/k3-j721e-mcu-wakeup.dtsi
index 22166c7942..dee824e548 100644
--- a/arch/arm/dts/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm/dts/k3-j721e-mcu-wakeup.dtsi
@@ -408,4 +408,14 @@
 			ti,loczrama = <1>;
 		};
 	};
+
+	wkup_vtm0: temperature-sensor@42040000 {
+		bootph-all;
+		compatible = "ti,j721e-vtm";
+		reg = <0x00 0x42040000 0x00 0x350>,
+			<0x00 0x42050000 0x00 0x350>,
+			<0x00 0x43000300 0x00 0x10>;
+		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
+		#thermal-sensor-cells = <1>;
+	};
 };
diff --git a/arch/arm/dts/k3-j721e-r5-common-proc-board.dts b/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
index 32f71e9b6a..93a6baea2c 100644
--- a/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
@@ -71,13 +71,6 @@
 		mbox-names = "tx", "rx";
 	};
 
-	wkup_vtm0: wkup_vtm@42040000 {
-		compatible = "ti,am654-vtm", "ti,j721e-avs";
-		reg = <0x0 0x42040000 0x0 0x330>;
-		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
-		#thermal-sensor-cells = <1>;
-	};
-
 	dm_tifs: dm-tifs {
 		compatible = "ti,j721e-dm-sci";
 		ti,host-id = <3>;
diff --git a/arch/arm/dts/k3-j721e-r5-sk.dts b/arch/arm/dts/k3-j721e-r5-sk.dts
index 6986292e37..f146ba1314 100644
--- a/arch/arm/dts/k3-j721e-r5-sk.dts
+++ b/arch/arm/dts/k3-j721e-r5-sk.dts
@@ -204,13 +204,6 @@
 		mbox-names = "tx", "rx";
 	};
 
-	wkup_vtm0: wkup_vtm@42040000 {
-		compatible = "ti,am654-vtm", "ti,j721e-avs";
-		reg = <0x0 0x42040000 0x0 0x330>;
-		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
-		#thermal-sensor-cells = <1>;
-	};
-
 	dm_tifs: dm-tifs {
 		compatible = "ti,j721e-dm-sci";
 		ti,host-id = <3>;
diff --git a/drivers/thermal/k3_thermal.c b/drivers/thermal/k3_thermal.c
index de6d88abf0..c34b69ddca 100644
--- a/drivers/thermal/k3_thermal.c
+++ b/drivers/thermal/k3_thermal.c
@@ -913,6 +913,8 @@ static struct vd_config am654_vd_config = {
 static const struct udevice_id k3_avs_ids[] = {
 	{ .compatible = "ti,am654-avs", .data = (ulong)&am654_vd_config },
 	{ .compatible = "ti,j721e-avs", .data = (ulong)&j721e_vd_config },
+	{ .compatible = "ti,j7200-vtm", .data = (ulong)&j721e_vd_config },
+	{ .compatible = "ti,j721e-vtm", .data = (ulong)&j721e_vd_config },
 	{}
 };
 
-- 
2.34.1

