Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C996D6EC00
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 11:06:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB8D3893C7;
	Fri, 29 Nov 2024 12:06:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="njQI07vP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45355893C8; Fri, 29 Nov 2024 12:06:50 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::604])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00D22891A0
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 12:06:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=We6IvfqI8UqwsKNaMfES58MZHf22YS8TxoYWxvShl+NtxUjM/+h9+xlSiPjp2iw7xlBPLXjlVrWRfFQjfhL9JNheDl1C1cb3JcHlLoZF1cZyjouQIv+Nj4bD8RNm21h/Iaz69MdRQtjenwnUOxkL9Wf5hi3Rz2S3YWxY7BXGhz/oCVNfMYvr/dLDLBtYsWe9son2nZevLocdB4It7r+i207PlFDqqypp8opcBF0JY/as4HJQauFU162MlF4w39MxhHy5V6C1BokHSEjVM5ZwOf68gZm/PTgDVCO0wfmfnfpfZs8Q5U2P3/FjvKR+TI0J6SDN3uuB1PGtX0rrdhYhWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lji6hskGrfDNduRUcZSwZwtBREiIb/Ju0iZIEFBEAho=;
 b=KjjW0gXrxcKNALO2Qmi0ThAeMyLlEGTW6D2BuC2fw+w0AA/TtI2+Va1WudnVZG2G6nSC3VfbzkXHbs5ZBf2K8CZy2F/hEsKQ6zo3mDbMfPgXItWpcsgnle+B5RAGhu+6E0/5OV85vUnyu7DhUbvZMAVnzhI0s0ti0O4rqvflUCw+SqSMoeASJzsduvSpI5etslUPFhyi5CNj6y9vhcHrvUvYVIFTBwOQiiOXikeaSNKoWceN/At9+zrT2yJyBcOGebK8ZTWR60ScX+GYvLJRekwqHkDiql9EtzRva6267jWRjLIliMitp1gCv+LqrbX0pO5E6SW6foMVVieDl2tiHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lji6hskGrfDNduRUcZSwZwtBREiIb/Ju0iZIEFBEAho=;
 b=njQI07vP7o2WTGduE3DI7jmlnK5FNfpTEi93FhTAX5zYHH/GEkpO4X8Atm4fdUWOAWS5dguIVpPwbpqM1j5x9krqnPoUWt1Fa/c410qyUoX7eZO2WMzr7giybEOcAAa+tfnCECExJHyPSZHx//nw0HrXRhwiFvpUGbZF1C899iM=
Received: from BL1PR13CA0447.namprd13.prod.outlook.com (2603:10b6:208:2c3::32)
 by MW6PR12MB8835.namprd12.prod.outlook.com (2603:10b6:303:240::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Fri, 29 Nov
 2024 11:06:41 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::3b) by BL1PR13CA0447.outlook.office365.com
 (2603:10b6:208:2c3::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.5 via Frontend Transport; Fri,
 29 Nov 2024 11:06:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Fri, 29 Nov 2024 11:06:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Nov
 2024 05:06:41 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Nov
 2024 05:06:39 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 29 Nov 2024 05:06:38 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>
Subject: [PATCH v2] arm64: zynqmp: Update the usb5744 hub node as per binding
Date: Fri, 29 Nov 2024 16:36:31 +0530
Message-ID: <20241129110631.672637-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|MW6PR12MB8835:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c094cce-46d5-46e0-0ee7-08dd1065e75d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UQVHIbCgFhT7YBY4SfTu6c/qlgj/UhlLJJphYL51WIBbm/KGOSIP+vPa5bqU?=
 =?us-ascii?Q?+oCHHH3NJ8DqCxy6A7hxYK6uXA4dzXiuwex7zt1GvLL3GqjxY6M7O3mLWe2+?=
 =?us-ascii?Q?tU6XZ1SgG9nUjXuU+2WrILoj8xTnKrIr+GVdd11PlRxvpis0bBIG8zhWUSki?=
 =?us-ascii?Q?DYznzZ8PknhfNzPf/odN2tqcL8y9ucbR2vmMc0S77+MmFoUTZWs8ksSsgUfB?=
 =?us-ascii?Q?J1P1iLPSWoFma9GEd+AE42NWfMUKZlTjwYV8uNRbiGFOJPaosSDortnrA6nA?=
 =?us-ascii?Q?jJRPIqnFPQsaIXaXN0pRdoNwPwFlfoXE1LtVjbHnlFJfWeySpFw5BpBARZh7?=
 =?us-ascii?Q?dkJ9DA44/Jc77quChdn6/Z4h0FgLaj2m1GIrKZjFDw9QJrCs2pvzh82o7YFa?=
 =?us-ascii?Q?IH4QCVndZGLFUzTymy5Nzw7tD6nMJeaR5Ej2miVhlI2Bq6o2eWBAmjIi1G2o?=
 =?us-ascii?Q?7WHerZ9kUr4Wn1R+HG5o/09e/gfEYBBW3byc4NJNWWzTZWBKwMLIMyUBnJX5?=
 =?us-ascii?Q?jBmIBlC6YxM4pBt9LM7qIHmN40JEsKTteNzvzV35x+wdbQVOaTTXa8vRmYWk?=
 =?us-ascii?Q?dUj8oNYwkZdkvcf2z3WtghDBDO1R/fszFYzoA4ZjNBITZl8s2b8TQZ3/NPll?=
 =?us-ascii?Q?b3tkvzrX5rv70BQ/w6fYhuuRjP3HSoRKqQj0taXxvlTXI5VVDoIGR3hJRVPp?=
 =?us-ascii?Q?YOJAzAv8qfhs7vI/IWzPOD5DSnahWFgVurOyIHk4mLNcnDxCSePDqhF8u/By?=
 =?us-ascii?Q?LYLEoO8mlkFfVgMBMnQx3ndFP10IOpNKNDhxcE/F4w+6rRIPccuU6bC4s76T?=
 =?us-ascii?Q?KVKEVsnoCGBZaLbujHAeqE+w6vwoD4ZJ11Ky1AE6vwkhuxlVAQka2mL6rv1S?=
 =?us-ascii?Q?/Xhut0YWs/FUsjHoDx2zWIW/gwwrGex2FV/oAZC8s9OB5Q5m2ohL18bWPqyh?=
 =?us-ascii?Q?lHaPBFepSZ8SY521CyV5KyLnamSMygIQJNdZT7NcMyLHV2y2o909xn3A8ZNo?=
 =?us-ascii?Q?E36stss4XGBD+otbt/2jYssdIwpsOrEXaPEDX/T0rZRSOukPKsZAJuefctDU?=
 =?us-ascii?Q?+jh3M+mtFvvgHfoX6ewJLWwz5KalDunA6DaDiaBRxiq1Mco5joBYitXJBR+O?=
 =?us-ascii?Q?aeW71fR618S19qCqb0P/EZhHUsm2mQMkIYLPaaxEax+S/Buv5mrgTWKw7MgC?=
 =?us-ascii?Q?elsPJIPc0eyHRIHrcEmZ8hWV48a4IIYvne6QIaOAbbUDVfhCjty53rOtk/kV?=
 =?us-ascii?Q?mBlL5B+5U4ewC5lKIoUhzHJi61rmGbPjy9+WM91PH38lB6wgFPwEcFmFyc7d?=
 =?us-ascii?Q?8FYRFUu6vxIE19SUGl0Ew/Kc1qTmSdlOpF0LlltlAlS58DvI2OjvNXbO/zLt?=
 =?us-ascii?Q?PMT9N8PkfW0iG1OP56NjFtmdbkIG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 11:06:41.5230 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c094cce-46d5-46e0-0ee7-08dd1065e75d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8835
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

Updating the usb5744 hub node as per the latest upstream DT binding
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/
tree/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml?h=v6.8.8

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Acked-by: Michal Simek <michal.simek@amd.com>
---
Changes in v2:
- Updated the hub node for KD board.
- Removed the #if code.
---
 arch/arm/dts/zynqmp-sck-kd-g-revA.dtso | 37 +++++++++-----
 arch/arm/dts/zynqmp-sck-kr-g-revA.dtso | 67 ++++++++++++++++++-------
 arch/arm/dts/zynqmp-sck-kr-g-revB.dtso | 68 ++++++++++++++++++--------
 arch/arm/dts/zynqmp-sck-kv-g-revA.dtso | 24 ++++++---
 arch/arm/dts/zynqmp-sck-kv-g-revB.dtso | 33 +++++++++----
 5 files changed, 162 insertions(+), 67 deletions(-)

diff --git a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
index 4de29d5d3f..d56e863ce1 100644
--- a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
@@ -80,7 +80,10 @@
 				  "", "";
 	};
 
-	/* usb5744@2d */
+	hub: usb-hub@2d { /* u36 */
+		compatible = "microchip,usb5744";
+		reg = <0x2d>;
+	};
 };
 
 /* USB 3.0 */
@@ -99,18 +102,6 @@
 	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
 	reset-gpios = <&slg7xl45106 0 GPIO_ACTIVE_LOW>;
 	assigned-clock-rates = <250000000>, <20000000>;
-#if 0
-	usbhub0: usb-hub { /* u36 */
-		i2c-bus = <&i2c1>;
-		compatible = "microchip,usb5744";
-		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
-	};
-
-	usb2244: usb-sd { /* u41 */
-		compatible = "microchip,usb2244";
-		reset-gpios = <&slg7xl45106 2 GPIO_ACTIVE_LOW>;
-	};
-#endif
 };
 
 &dwc3_0 {
@@ -118,6 +109,26 @@
 	dr_mode = "host";
 	snps,usb3_lpm_capable;
 	maximum-speed = "super-speed";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* 2.0 hub on port 1 */
+	hub_2_0: hub@1 {
+		compatible = "usb424,2744";
+		reg = <1>;
+		peer-hub = <&hub_3_0>;
+		i2c-bus = <&hub>;
+		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
+	};
+
+	/* 3.0 hub on port 2 */
+	hub_3_0: hub@2 {
+		compatible = "usb424,5744";
+		reg = <2>;
+		peer-hub = <&hub_2_0>;
+		i2c-bus = <&hub>;
+		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &gem1 { /* mdio mio50/51 */
diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
index 6349a0e108..9d0c0c2885 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
@@ -105,11 +105,19 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			hub_1: usb-hub@2d {
+				compatible = "microchip,usb5744";
+				reg = <0x2d>;
+			};
 		};
 		usbhub_i2c1: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+			hub_2: usb-hub@2d {
+				compatible = "microchip,usb5744";
+				reg = <0x2d>;
+			};
 		};
 		/* Bus 2/3 are not connected */
 	};
@@ -145,18 +153,6 @@
 	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
 	reset-gpios = <&slg7xl45106 0 GPIO_ACTIVE_LOW>;
 	assigned-clock-rates = <250000000>, <20000000>;
-#if 0
-	usbhub0: usb-hub { /* u43 */
-		i2c-bus = <&usbhub_i2c0>;
-		compatible = "microchip,usb5744";
-		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
-	};
-
-	usb2244: usb-sd { /* u38 */
-		compatible = "microchip,usb2244";
-		reset-gpios = <&slg7xl45106 2 GPIO_ACTIVE_LOW>;
-	};
-#endif
 };
 
 &dwc3_0 {
@@ -164,6 +160,26 @@
 	dr_mode = "host";
 	snps,usb3_lpm_capable;
 	maximum-speed = "super-speed";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* 2.0 hub on port 1 */
+	hub_2_0: hub@1 {
+		compatible = "usb424,2744";
+		reg = <1>;
+		peer-hub = <&hub_3_0>;
+		i2c-bus = <&hub_1>;
+		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
+	};
+
+	/* 3.0 hub on port 2 */
+	hub_3_0: hub@2 {
+		compatible = "usb424,5744";
+		reg = <2>;
+		peer-hub = <&hub_2_0>;
+		i2c-bus = <&hub_1>;
+		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &usb1 { /* mio64 - mio75 */
@@ -174,13 +190,6 @@
 	phys = <&psgtr 3 PHY_TYPE_USB3 1 2>;
 	reset-gpios = <&slg7xl45106 1 GPIO_ACTIVE_LOW>;
 	assigned-clock-rates = <250000000>, <20000000>;
-#if 0
-	usbhub1: usb-hub { /* u84 */
-		i2c-bus = <&usbhub_i2c1>;
-		compatible = "microchip,usb5744";
-		reset-gpios = <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
-	};
-#endif
 };
 
 &dwc3_1 {
@@ -188,6 +197,26 @@
 	dr_mode = "host";
 	snps,usb3_lpm_capable;
 	maximum-speed = "super-speed";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* 2.0 hub on port 1 */
+	hub1_2_0: hub@1 {
+		compatible = "usb424,2744";
+		reg = <1>;
+		peer-hub = <&hub1_3_0>;
+		i2c-bus = <&hub_2>;
+		reset-gpios = <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
+	};
+
+	/* 3.0 hub on port 2 */
+	hub1_3_0: hub@2 {
+		compatible = "usb424,5744";
+		reg = <2>;
+		peer-hub = <&hub1_2_0>;
+		i2c-bus = <&hub_2>;
+		reset-gpios = <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &gem0 { /* mdio mio50/51 */
diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
index b0d737d3ca..0d915d496c 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
@@ -117,11 +117,19 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			hub_1: usb-hub@2d {
+				compatible = "microchip,usb5744";
+				reg = <0x2d>;
+			};
 		};
 		usbhub_i2c1: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+			hub_2: usb-hub@2d {
+				compatible = "microchip,usb5744";
+				reg = <0x2d>;
+			};
 		};
 		/* Bus 2/3 are not connected */
 	};
@@ -165,18 +173,6 @@
 	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
 	reset-gpios = <&slg7xl45106 0 GPIO_ACTIVE_LOW>;
 	assigned-clock-rates = <250000000>, <20000000>;
-#if 0
-	usbhub0: usb-hub { /* u43 */
-		i2c-bus = <&usbhub_i2c0>;
-		compatible = "microchip,usb5744";
-		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
-	};
-
-	usb2244: usb-sd { /* u38 */
-		compatible = "microchip,usb2244";
-		reset-gpios = <&slg7xl45106 2 GPIO_ACTIVE_LOW>;
-	};
-#endif
 };
 
 &dwc3_0 {
@@ -184,6 +180,26 @@
 	dr_mode = "host";
 	snps,usb3_lpm_capable;
 	maximum-speed = "super-speed";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* 2.0 hub on port 1 */
+	hub_2_0: hub@1 {
+		compatible = "usb424,2744";
+		reg = <1>;
+		peer-hub = <&hub_3_0>;
+		i2c-bus = <&hub_1>;
+		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
+	};
+
+	/* 3.0 hub on port 2 */
+	hub_3_0: hub@2 {
+		compatible = "usb424,5744";
+		reg = <2>;
+		peer-hub = <&hub_2_0>;
+		i2c-bus = <&hub_1>;
+		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &usb1 { /* mio64 - mio75 */
@@ -194,14 +210,6 @@
 	phys = <&psgtr 3 PHY_TYPE_USB3 1 2>;
 	reset-gpios = <&slg7xl45106 1 GPIO_ACTIVE_LOW>;
 	assigned-clock-rates = <250000000>, <20000000>;
-
-#if 0
-	usbhub1: usb-hub { /* u84 */
-		i2c-bus = <&usbhub_i2c1>;
-		compatible = "microchip,usb5744";
-		reset-gpios = <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
-	};
-#endif
 };
 
 &dwc3_1 {
@@ -209,6 +217,26 @@
 	dr_mode = "host";
 	snps,usb3_lpm_capable;
 	maximum-speed = "super-speed";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* 2.0 hub on port 1 */
+	hub1_2_0: hub@1 {
+		compatible = "usb424,2744";
+		reg = <1>;
+		peer-hub = <&hub1_3_0>;
+		i2c-bus = <&hub_2>;
+		reset-gpios = <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
+	};
+
+	/* 3.0 hub on port 2 */
+	hub1_3_0: hub@2 {
+		compatible = "usb424,5744";
+		reg = <2>;
+		peer-hub = <&hub1_2_0>;
+		i2c-bus = <&hub_2>;
+		reset-gpios = <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &gem0 { /* mdio mio50/51 */
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
index 561b546e37..a98a888d13 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
@@ -129,12 +129,6 @@
 	pinctrl-0 = <&pinctrl_usb0_default>;
 	phy-names = "usb3-phy";
 	phys = <&psgtr 2 PHY_TYPE_USB3 0 1>;
-#if 0
-	usbhub: usb5744 { /* u43 */
-		compatible = "microchip,usb5744";
-		reset-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
-	};
-#endif
 };
 
 &dwc3_0 {
@@ -142,6 +136,24 @@
 	dr_mode = "host";
 	snps,usb3_lpm_capable;
 	maximum-speed = "super-speed";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* 2.0 hub on port 1 */
+	hub_2_0: hub@1 {
+		compatible = "usb424,2744";
+		reg = <1>;
+		peer-hub = <&hub_3_0>;
+		reset-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
+	};
+
+	/* 3.0 hub on port 2 */
+	hub_3_0: hub@2 {
+		compatible = "usb424,5744";
+		reg = <2>;
+		peer-hub = <&hub_2_0>;
+		reset-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &sdhci1 { /* on CC with tuned parameters */
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
index 64683e0ccb..7490efea98 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
@@ -92,7 +92,10 @@
 		label = "ina260-u14";
 		reg = <0x40>;
 	};
-	/* u43 - 0x2d - USB hub */
+	hub: usb-hub@2d {
+		compatible = "microchip,usb5744";
+		reg = <0x2d>;
+	};
 	/* u27 - 0xe0 - STDP4320 DP/HDMI splitter */
 };
 
@@ -131,14 +134,6 @@
 	phy-names = "usb3-phy";
 	phys = <&psgtr 2 PHY_TYPE_USB3 0 1>;
 	assigned-clock-rates = <250000000>, <20000000>;
-#if 0
-	usb5744: usb-hub { /* u43 */
-		status = "okay";
-		compatible = "microchip,usb5744";
-		i2c-bus = <&i2c1>;
-		reset-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
-	};
-#endif
 };
 
 &dwc3_0 {
@@ -146,6 +141,26 @@
 	dr_mode = "host";
 	snps,usb3_lpm_capable;
 	maximum-speed = "super-speed";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* 2.0 hub on port 1 */
+	hub_2_0: hub@1 {
+		compatible = "usb424,2744";
+		reg = <1>;
+		peer-hub = <&hub_3_0>;
+		i2c-bus = <&hub>;
+		reset-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
+	};
+
+	/* 3.0 hub on port 2 */
+	hub_3_0: hub@2 {
+		compatible = "usb424,5744";
+		reg = <2>;
+		peer-hub = <&hub_2_0>;
+		i2c-bus = <&hub>;
+		reset-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &sdhci1 { /* on CC with tuned parameters */
-- 
2.34.1

