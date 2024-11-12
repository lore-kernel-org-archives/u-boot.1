Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0F0D41D6E
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 08:51:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D26F489447;
	Tue, 12 Nov 2024 09:51:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RvSHtyQV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EA3189451; Tue, 12 Nov 2024 09:50:59 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD6B989449
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 09:50:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpVN4syZZLdnf7K0PaNcsQvnCAxp0rF+Xf4HCnPvxnojs0NhFRZNCZFXQBLy7B1QRDTME3A/IS3v8uqmODC/fVFLn1PSaZ46KUCU5JzCCKUnaijHY/GqSWjh2AK+1vUlFh3sQoDLyZs6Nlocu6LJ3g0XGWfrvL3oWw5fDsoJYyk/bmHv6Em2C57904xwn8NH72a7hVUyBpM/DR5iapIKlw7ltEXlNXy133pb/7cjBoyrRZ0FRU1HfCBy2YeY5CNd4wZ4efTQDGZPswEvmYWUtYOvZstWfXW0oLlBl2EFJc37cdqQwUHq4x07I3P1KQlE0j03isaCWsiAzaHDWknv1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zhu+25n90FlcaBW3hto8wQIfk3wlk/choLOF14snj3M=;
 b=SPsHoT7mh2DGjFkpa6aKwA1abu9EBenF+SNWXuNZJXxe1GNc8dXEvcFVrVUcEG6mUWHjbBomI1wy8JvhFOb6vKRnQKIukqx47+0GGMq6qsZfpyY3SxNP/sPaImuC7FfL+TLWuD+Ljs6/PcVfg+Nn71yScQ8hFymsNNF+pc5W0mNZbQId6X/Oc1g7T8RKCFZgOeR8hP+OBTKGywfzytrgKsG+6XguOEYOi0HUJ3nu2otoUTRE+OGTO6bClczlJf+EGbjcOtuoCs0AO0WE0eXb6mScfB6ESxkSLLUnyOOHL4EBJANAgJEZmtnuCT8X78VFdQWPJW7FVe3X2KdzW3hRCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zhu+25n90FlcaBW3hto8wQIfk3wlk/choLOF14snj3M=;
 b=RvSHtyQVNRUfruxPRnuTsyndbhgk1+l9r94pcyfzkS9xhtczPAG5wikO1IEW8+SNgNZiS1nMk7vsl02QBU2VrCXHftsqNZfYr54jVpnK39hVsfZV/UITKa1155M9nwTblMVQTlzpa+NL8NxwFJuS8eeMYPTopR/EZvcOB3CY5GU=
Received: from SJ0PR05CA0172.namprd05.prod.outlook.com (2603:10b6:a03:339::27)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.26; Tue, 12 Nov 2024 08:50:52 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::ea) by SJ0PR05CA0172.outlook.office365.com
 (2603:10b6:a03:339::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.14 via Frontend
 Transport; Tue, 12 Nov 2024 08:50:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 08:50:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 02:50:51 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 02:50:49 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 12 Nov 2024 02:50:48 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v12 7/7] arm64: zynqmp: Update the usb5744 hub node as per
 binding
Date: Tue, 12 Nov 2024 14:20:27 +0530
Message-ID: <20241112085027.21352-8-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241112085027.21352-1-venkatesh.abbarapu@amd.com>
References: <20241112085027.21352-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b9b862-0606-4d2f-26a4-08dd02f71cf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HTkhjYhk42tx9ItmRHrofHemX3ebQbio0tGRG2/R+XGEcJGpixzcDocZfj7m?=
 =?us-ascii?Q?rd/D1CW4MDkOMyDYmS6mFpE4/eCIql6c9NTIF84pMR+TUtH75P0C8bhIIJi6?=
 =?us-ascii?Q?cb+3ttGNYdBVZdVTJcxF5NCIIxuSZYg/cKV8zZLZcsrowOw4HPBafZR03FEo?=
 =?us-ascii?Q?4cSeCyEuG0FyOuHa5e6ihVm8CcL6HrR6Jxjog/myhjO5PZF3mTP3PpPZKRir?=
 =?us-ascii?Q?t2ydSiVAJx79/yqKUUcBAHQXD2s4urO4712KSiiHuX5yyTGNw/16EpzImLm4?=
 =?us-ascii?Q?iRa7EKCFw7e/dozB+zCLgl1TUvMEeMGg484WYzkPPaX3LTYS/PleJ4vJzl0Q?=
 =?us-ascii?Q?fI54n/Uqv9MCvJI9DsNz1C++LnDC7Zwud0DftjIAz36nPEfoaUNNX1uVWM0w?=
 =?us-ascii?Q?6fgL6LLMhBM4uFdtbVg/pR6Np6E8mpl+sfO2DKxBz9XQkKGAOOmENhOFXR+d?=
 =?us-ascii?Q?5KFf+NTcP3FXNbuiPTHKvHlFh/en9kRwsqcRN7wGGf+BjWjk5AbxzwjatZxo?=
 =?us-ascii?Q?c7EPrk7MEjacU1YwDe26Ie/wkF5KEf9+zc7ytofxuWmbobSiYj8Rtkf5ZwBt?=
 =?us-ascii?Q?v0E5s12EUm/eXeMFwUjBxm1ySdzHHAlR4+VQo1JIdKLuOXzFeA0ntzSxlkre?=
 =?us-ascii?Q?K4qaWFqoHAvkkkrSaH/p0W1yyXT20lJZq9+lpOByxpxEcPX9/9dgguNvoNKJ?=
 =?us-ascii?Q?KVL9mPIS7+fOTHavSji4bXMN2B8sBd+3Z2sUTY1ws2fCyWL649gGqrZYSjZn?=
 =?us-ascii?Q?Z0KwY1cYSg0t902xgQ81QOm8bnyRW5ipZeZtfyUGrji+Dd4Yd/cUHVx/9C0P?=
 =?us-ascii?Q?OTxYi5ah6rNm1Z9skc6vEvxIVg0frQkdb7GBNfK2beLtu+FMswJug/dzeDid?=
 =?us-ascii?Q?MAJRu8eqeWUOTyfvC1eLbihLce4mNEvbwmTCw1n8WORRGmieLt+1E8RzJcd4?=
 =?us-ascii?Q?zpaT6VGRYXOGHmXCovx/kIpYUBP+lJPYDj+FHJ1X8mO3VZwSWOEPJ92RwJvw?=
 =?us-ascii?Q?9GIzTMBYvps6aurBI1ScvCF6BbnYwhMFWsmYJdgqYVrhz3K+FvVX8+JYZUFC?=
 =?us-ascii?Q?gl9vxPhpAfvJU4/OYw31uGiJMHJ9PYe92HlkJaCPj1H0RaRGZ2RDgdpOwwbI?=
 =?us-ascii?Q?rpKsn8R0DCDlw/ogabprrL6asf82EmMoI07SAlso2XZ1k0Bf12i4vt9lZgYo?=
 =?us-ascii?Q?L+aGP9hWf8983OZNKaMSpBQwRYfvg9hyULFwJef4nOfSXiSigXCJqqF4CFjI?=
 =?us-ascii?Q?xL4pgy3fYaDAu1F5Ok6kkj70Tj7RxducECrUyESwv/uI9eba12/38leSnMfA?=
 =?us-ascii?Q?l9qTu/Rspogp6kjIjeipav6Aa+0XHWwGvGFzw0LiWwWmo7fQF2NBzwJr2kur?=
 =?us-ascii?Q?km+1Mzk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 08:50:52.0896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b9b862-0606-4d2f-26a4-08dd02f71cf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392
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

