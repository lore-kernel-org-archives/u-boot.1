Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE45CEB2FE
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 05:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D1E28912A;
	Tue,  1 Oct 2024 07:49:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dcul9qrU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC1A08912C; Tue,  1 Oct 2024 07:49:52 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::611])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DD6B89121
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 07:49:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltrZrBBlh0nBrnGXNLWhN09nVkdnV5FU74zxURATXz0aEbJ4KKlx6qoeHflxCucK5d6zexiC3ji4ULg7IbVf/1j+iQyWEVSxxb8tuJA+50GBNk2XXrgUyTHYZV6NGMns56/UynLpSKmoZR9VycpdJVYWWV46gMmwjpD2i2+DvNf3TtlKjbO0sh2WCZp93rKyYCWFw0CgEjxnqDnVKXWPY8PHf1CEhXykxuvwGrE2JNQi36seCg4CMGRLdPOaWtG/TbHk83DmSzos5MqaGZ4RrYhKaUucv0tGLxtbukiMWcDbtbV3cN+coNnewDVJIr9b39Wq//pRsJkqXtyYfE2d8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+IAosZWM9uxoJAGh5Mh4ubvKfPHNz3dFpvu6aydAmU=;
 b=Aq7+1hHAkDIdXednRRCU9zPb1ZhJ9WIWJMw3D6A198DHd23RWMkoM5REMqGawTF24Q5vYPgdyZFrrV35dk3a/1BcAQ7zNwy1YdGu6ToDvAf6TH2QscziH2Ims+CzRsYNcNa++KrFDPlTWptEDpG9VAUFDbDUIEsjk5gFYtTIwSN1m2/KldFrnodRMCreNv88YVo/UWohdDfZ1GrgV74bnsrAuBdgzqACwbhRxbNWKQjrY89LySCe9ukp2z7BqW2D2NTLeOiT6QsndBkEDZdLKZdHDtplBocyAmK8uJ5ZOo+N0ouosNauXDaexQiZrw8glmz1LUgG2EzkuN7dw4jWMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+IAosZWM9uxoJAGh5Mh4ubvKfPHNz3dFpvu6aydAmU=;
 b=Dcul9qrUsjVJEch5OFzAzbeDbhyWdJ7Tbp4LcaUeDESBJscBfJtBr5NOZtaHeVoGl6h04dilZLZAY+m3VEza9bp7wnHmcr8URMEuMWqGLxtFTL0Bz5EdODF/8l9QpqaaCoVvcoJsEAsu7HxMUPMq/RTjNhRNkQlrClCnIculhtU=
Received: from SJ0PR03CA0081.namprd03.prod.outlook.com (2603:10b6:a03:331::26)
 by DS7PR12MB5837.namprd12.prod.outlook.com (2603:10b6:8:78::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.26; Tue, 1 Oct 2024 05:15:30 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::b2) by SJ0PR03CA0081.outlook.office365.com
 (2603:10b6:a03:331::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Tue, 1 Oct 2024 05:15:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 05:15:30 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 00:15:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 00:14:51 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 1 Oct 2024 00:14:50 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v3 7/7] arm64: zynqmp: Update the usb5744 hub node as per
 binding
Date: Tue, 1 Oct 2024 10:35:29 +0530
Message-ID: <20241001050529.17922-8-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241001050529.17922-1-venkatesh.abbarapu@amd.com>
References: <20241001050529.17922-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|DS7PR12MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a92fd49-7ad8-4096-7f6c-08dce1d81188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BtQkAhfftMbSwti0lIPPAmUWjrGXDV5tfQpRLsAh/g+qv8qAwb3g/o4sZlXy?=
 =?us-ascii?Q?CMp3W7q+VBAuwT078msrU9efNkrr/ELsXksFlOFmuey6B2itSVPD/bDdC6od?=
 =?us-ascii?Q?OqUSXRziy2s0kawFjDinAwNfih0IfZcXGfBjOMewKeyfZYnswtK4zTYySZa9?=
 =?us-ascii?Q?8Ux+EnpAvJBtAEcK7aOCL0hHx4r2XVORDYEQHmCiSucxjlQsGLTdRX2/i/Ku?=
 =?us-ascii?Q?Y0HEtCQtNUE7TDvp0ex7nT+yFLo+cp1wgUD0U8itI3qIzyoe4HDC8tezhRUg?=
 =?us-ascii?Q?7aMU3+/7DnjLRFu779eSfZDYs2w9HBiLShQuPuyXpmT6142rTKCOU/KP4Xqf?=
 =?us-ascii?Q?6DfrUYv99SgR22CK/EKTvg3SkWlWUtGqUAWjfRcbECJN8+BnAJ1afxK7pGWB?=
 =?us-ascii?Q?7UmU3AkxkE/tAEp3rOg34jVPpZRfEGz0gXG8+8unwTH1JVMAJhFrbYe26FZQ?=
 =?us-ascii?Q?m06QZ+lWNKPKeaDvYqrTwLYM7FCfECj+qEU8O0GMOXPPHUtDCenIminLVeqi?=
 =?us-ascii?Q?kiCSoHkoBPPkgdtc8wDc8MY4sIL7Qo8RDZrzUH7N1b8qX1bj+pMKXqyulsI1?=
 =?us-ascii?Q?idPNBwgHnIpROKjpVuZopVbrqMRwBjgy4l1c/kEQlZCrCJBxQG7f/TqNmiRV?=
 =?us-ascii?Q?56rgj3Ypqs1JHnO04K5/m/mbe/wAMKorzSBHMs/Zz12kl7U3TO5i1lxHxiG+?=
 =?us-ascii?Q?uH3MIsZ4t3yMYSeRu51bliXK/M2DFuRrHQOsT7ZTkl3ajqbSUvUWyykPilDB?=
 =?us-ascii?Q?PZb+o3IHHZ8wa2huqaZvjvVVeME2OvAk+D4W71nHl4C/v/UbRmTSA0yBZDbG?=
 =?us-ascii?Q?n6+vGBcoss+5C0Ga7gq1dMMqxREXCFI2m8xlGDqRZ+LqsELpIv4A9+WyQeA3?=
 =?us-ascii?Q?EWQitnyNePp+4R2Zbf8e5Kt+cO80CIvL+NmSfXpAqlFtUISVhP3znH9MDgKv?=
 =?us-ascii?Q?UsOsizrQ4IKRTkE5K5ZV8J+6Jpxb9uHxVLWGJvjoyy1WwCUV0yFcMkwfiisW?=
 =?us-ascii?Q?E9V5uuN8sqRK4Ng33D2Gau+9n9tqsPprs8Jss8u8UQrJL19T/WGoKoeLyBDz?=
 =?us-ascii?Q?Repfy9XMLTVFfbca59NYi/E14ZbgNhF31nnU479CyDyh/AKNeahniNlvGfFb?=
 =?us-ascii?Q?J0DAHXSba5PH6YfZFVWxf61Z/urTnNwIVABhb55RgtZkYNInNBAMnxSYxmwE?=
 =?us-ascii?Q?jzLGen4VVOhySozKA0Uqj/79JKMvpDTMQyUxzXZ7bwhiftjmeB78s1JLozw6?=
 =?us-ascii?Q?ETA0ENRbcI+BexGQe0kRtYdIDO4eRxxZkOhxLJaD6bRz6bKox4dZ6+YtXABD?=
 =?us-ascii?Q?Uu6ZmlS2UYEQC+HVEKCQxStL/f24ixYPt+oZMOD1YJpO2+p56WtIBRG33kqA?=
 =?us-ascii?Q?frNE/K+zfhS3A6IO8TV/3Kzw2pAe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 05:15:30.1392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a92fd49-7ad8-4096-7f6c-08dce1d81188
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5837
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

