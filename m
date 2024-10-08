Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90AACEFC26
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 15:43:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C12FC88EC4;
	Tue,  8 Oct 2024 17:42:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jXXntscu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBB0688ECC; Tue,  8 Oct 2024 17:42:21 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9C0588EFE
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 17:42:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRawGq506UQImxLyioN07bwaMHX7I08jCGUnCXc+leR+Zjya5e3uw2OoX02TkyIS/Qdv/riX6CmGdFtAnryvOTiLKV0iKkkLy3MCxvLf67lc+Sw7UVjJHA+4m1EYZs1OFUsJQQXObdmiLKlXZQKRlwNSukgAq2L8g2tHWQbO3G8F4+X10BWH0P7ajETeBenIFIFJeyDNRbTxM5X6vMaFgYTyvVqEKDpRAhcCeYXarcrOcWfwCMn/ckCwfrHcihz/gE/qRhQ16iCVDI3w3QgFnuRQWsKNPMoODgrOqWTf4jjAccHXkPB13rMUcT0S1P3ipH3NfjiYOFRv72fZVwFy9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zhu+25n90FlcaBW3hto8wQIfk3wlk/choLOF14snj3M=;
 b=j6VMSJ1NT+SU+cJTNs1XDhk4GOuWFflkeNk6vaTt8o0CvBs9DAwmDTzvArOzsfCvZe190JsuOm82xD02gDrC83qkN0kkrSZYzzraJYFCwdGqH/3qLIKezRTB7Rs7FHTf+ItlhNCaIQCXO3Kbkc6Roe5pM1Lq4mL47FxRuB2YhKq6bObLuAo3HjATteBVF5No242HtOUPEF7o8zRUHZ+zAy0j6KGqZQJXLY+yo3/s0ky3PQxA7Zmb0D/yd+qlu8osl+00LmlsjT/eVrR+yy7EIlygfuxjCb+vVQx79PDihG8oJo+c8rvVeg2O4+n8X3Rd2OUCINe0NC2jJ04ijbVucg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zhu+25n90FlcaBW3hto8wQIfk3wlk/choLOF14snj3M=;
 b=jXXntscuRkat4lBGVUNQX12W50My+3dQZBBBrcm10e7oCmisUqtEbR4h8fByBDRQmiChpX8ZBpahNRvV/Zfu/4kPjVFBweNTOmD349bKETB6P5urDHtgaMM5Nswy62Ubouok3GIZQ6VfBI4Hmi0Xm02NFhDLxrDj4kf1W8HtNlY=
Received: from MW2PR16CA0054.namprd16.prod.outlook.com (2603:10b6:907:1::31)
 by SA1PR12MB7248.namprd12.prod.outlook.com (2603:10b6:806:2be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 15:42:15 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:907:1:cafe::19) by MW2PR16CA0054.outlook.office365.com
 (2603:10b6:907:1::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Tue, 8 Oct 2024 15:42:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 15:42:15 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 10:42:14 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 10:42:13 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 8 Oct 2024 10:42:11 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v7 7/7] arm64: zynqmp: Update the usb5744 hub node as per
 binding
Date: Tue, 8 Oct 2024 21:11:39 +0530
Message-ID: <20241008154139.31204-8-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241008154139.31204-1-venkatesh.abbarapu@amd.com>
References: <20241008154139.31204-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|SA1PR12MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c2539b3-8699-4ab1-57d3-08dce7afc8c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JQYTxpbdHMFAqr+z9mzu1+sWsBkauAYwfDFAiddtyY09HVYt9qMbqgVIHrBb?=
 =?us-ascii?Q?80qOgjz8GWIayhNeFUmjBxyJE2AHbmJiSKuk7pl1I51F1UK00+jbql9oP2RM?=
 =?us-ascii?Q?j5+63AdIL4H7BUGQKq1IkzlC3LGDnGoGskogJgDmnOAT1EMCqWSfslxxk2Lv?=
 =?us-ascii?Q?mOijaM0H7wTCepTUXKhjRMALRzdi4rGFln8r0YFSp5ToZFEQf3tzZ0Cjq5Dg?=
 =?us-ascii?Q?0l6Ly9OPmjcJ075lKTtNzobOG7WB29vHMnbx+6I5J/m5G+1aKLoHILjUn1K9?=
 =?us-ascii?Q?n9nU911J7pJz29tClH3b07evmjv0lXHvnoUjoXmdPiH50FniMPEQpqDZ4+4r?=
 =?us-ascii?Q?RUOa7//h+XJp33NSQTZtvx4BjUAln8qEOgUbG8QjIopzROXKn1JpXWN3dsCS?=
 =?us-ascii?Q?zVWFPe+ncLMtBzGpm2ojeUijG2kHs3sNZ9j508MxIKD7jOJyDG592jVxNYEE?=
 =?us-ascii?Q?+fOdjUFp4rXTB65YRzk/4JlkeT9k6pzE8jY74l7dKO4t/kYy8sj1dk1jGn2j?=
 =?us-ascii?Q?/hJMQW+RLVfFEeXp7Uy8qL/kz3I3wypwEJSzcrXROOn0tys5wTvWFIN1pBpI?=
 =?us-ascii?Q?h4TbXVxtyrXMuDyV9LHPAAWmVbbTsY8OZskzgJEVxBK1oJc1dyjueavKESAD?=
 =?us-ascii?Q?nIymlb1rReKXEXKpLIshV6xlOYgxn8HLwap+mH+x0ROtqlgv2z+RErLddeEC?=
 =?us-ascii?Q?QttXWzayvt6fa+Ty8r30NtyyM6wgpNWY2gy8iJmppwGaMYn+LjQ8iz1rdhfd?=
 =?us-ascii?Q?9rbSFPKUfDYa4fFakPqeGrGq5FRsXWQSXb3gzY4G18QC6YQEAuwpFNt+sM5C?=
 =?us-ascii?Q?b5Uh9Ix8Bjut2b+XesSGZdfgDjZ3qYesAR4ekJZDSf6wjIGgE5bTyv0uxaZP?=
 =?us-ascii?Q?IMHOMaqk46vqBjZ5a7we5JPl/MeygN6aTfUk2+xsGnGOlaglNAhEJzAwO5hz?=
 =?us-ascii?Q?hMOXv/iJkIVUSllJIoGMReI8feIV9rRSOUShbowxq4IrpCR1PQEKe8bC96Hc?=
 =?us-ascii?Q?9Mr6yisaaQjlb+SXbF+F8vOZjSdr75XThFRgIauFk6GbCyeiFh/gYmSVQsep?=
 =?us-ascii?Q?RWTRNnxOENF/q7e2Q62X8rMPY9lX4wx057cjlO1/wK6aoPLZl09tUSZyo3+d?=
 =?us-ascii?Q?9GWLH+9KtypOeSD/pKrCjCieu85vpe/kCd536lF+Q9HgjI/B+bNEPB5qrtiH?=
 =?us-ascii?Q?N9bmg2U/P8QItoofoX/2GaOF3BVuBE0MVL1H0PRXm6sH5ATi2I245bn3gRho?=
 =?us-ascii?Q?/4S+/BBTUbmOsuFD40Zflyi5PAKXOpkm9diiBSuWG3JPhn4D9txOCT4Kb0ip?=
 =?us-ascii?Q?x0nFf5z4SZC5singYSr8ua1b?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 15:42:15.1768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2539b3-8699-4ab1-57d3-08dce7afc8c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7248
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
 arch/arm/dts/zynqmp-sck-kr-g-revA.dtso | 48 ++++++++++++++++++++++++++
 arch/arm/dts/zynqmp-sck-kr-g-revB.dtso | 48 ++++++++++++++++++++++++++
 arch/arm/dts/zynqmp-sck-kv-g-revA.dtso | 18 ++++++++++
 arch/arm/dts/zynqmp-sck-kv-g-revB.dtso | 25 +++++++++++++-
 4 files changed, 138 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
index 6349a0e108..e40840acb8 100644
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
@@ -164,6 +172,26 @@
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
@@ -188,6 +216,26 @@
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
index b0d737d3ca..ce1ad2b765 100644
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
@@ -184,6 +192,26 @@
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
@@ -209,6 +237,26 @@
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
index 561b546e37..0ef0357bd2 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
@@ -142,6 +142,24 @@
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
index 64683e0ccb..92d8851eb8 100644
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
 
@@ -146,6 +149,26 @@
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
2.17.1

