Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84939C27C53
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 10:03:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A42088369;
	Wed,  5 Jun 2024 12:02:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zw596LmR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C05188354; Wed,  5 Jun 2024 12:02:56 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BB5E8839C
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 12:02:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvsiUJ4ALbM7y0myyIxw9gQfN1D+sga+yjYqogH0wtjif/mHMiq8D4UgXKRfoctWU3HBOr7/icyTj5EcmHkgbM/r5c+DvwLmOFzxsZdPsxozmxw6Yedqj1hEyWntHvXtyWJrFgCbDC5mrtEni4BEVUQ1dv5xKqNRvrgMyQfJ//NtJbvv/FvxnIlYh58vCpBcmggpUokWCJnY0BM+POofsUAbfJtnJDXe9GTGZcehNiO3KZK07f0kfzWZ5VbX2IiXIcQXoRfG49zFr4u3/ViRs4NYeQhcjWqqG5xbdCiF8/edA6sxBMsyAxXXujHm47UmucNhuO1Z1LNMFSSXuisPSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdqQ0IB6YH6BBYCtkokSkuTIPadPRz5QBNzeMqZpp4Q=;
 b=AX2hgRiYnxBeKB4cHgnzfNxMQGpCFvSZ3x3apvL+Hnl5Ua8PRFopMIK/i4tERiy/Mo9QvYYFiRbjbVPBZslsf8MajStlwKlFXMuNVDxmcozPOnrbppDveWyvhRNysYb4hVpSKd+rzOAOQPVjzy8rM2/nuYUnXHLVANOcBJM00K8kvv5g1lg8TOQ3rS4nkTbaFNFzd+2zu4W8XnjbMFK4EdHW0twxum4l4EhUT6PUlfcMrt6aMMSnCxNb8ysW/jIK+zhr7PO76UdlRCJfNCKKyi9h8CtF+K66ZEeD/VcAQdlqlaypuvm4x7Cf8swog8iS6YEDCcGannG98XerCkYU+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdqQ0IB6YH6BBYCtkokSkuTIPadPRz5QBNzeMqZpp4Q=;
 b=Zw596LmRI7FAr64Z89YF4xrecBDDwKqYx9/YFimd8ylj+GVddm/IQp/kluaeEjA3TdTZ+reAx8dOjbQOHVxhwvnNMSrvXE209S8VlcWKZzYzDULMlu9s9ni41wps3T72yxhpQpgjL3l6wVLJTsGpTAcmbH1eg41n0x+uu4UxMs4=
Received: from CH0PR03CA0432.namprd03.prod.outlook.com (2603:10b6:610:10e::20)
 by IA1PR12MB6329.namprd12.prod.outlook.com (2603:10b6:208:3e5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Wed, 5 Jun
 2024 10:02:45 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::e2) by CH0PR03CA0432.outlook.office365.com
 (2603:10b6:610:10e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Wed, 5 Jun 2024 10:02:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 10:02:45 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 05:02:44 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 5 Jun 2024 05:02:42 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH 7/7] arm64: zynqmp: Update the usb5744 hub node as per binding
Date: Wed, 5 Jun 2024 15:32:21 +0530
Message-ID: <20240605100221.3571-8-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240605100221.3571-1-venkatesh.abbarapu@amd.com>
References: <20240605100221.3571-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|IA1PR12MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: cb1aff41-78dd-48aa-4c64-08dc8546a5b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FejFd4yRRZ/GXrnNF7MpvRCPOV1SxeKWybxMnpGFnWCQonS0LlDds1NlgMgb?=
 =?us-ascii?Q?BejZKygCsOr1iuLo5WX+GOL3oIpZrEKwVhV8P7M+0VERKDzE12D8GViVriu0?=
 =?us-ascii?Q?YXxkw25+2erKLEc0fWjJ9mH0tBHV23GNblkE9b9s+OR5Z4B68g7nogA/Oca/?=
 =?us-ascii?Q?3vK7bzomC0EapfpRaPzqaGj9YVfUyAPg0ackqKYmT9lmbHtKjT/rQV7bidwI?=
 =?us-ascii?Q?ZS9JdkkTNdJAbiOptg1VH9XeipcfNN93S4MuZcwh784UL21nrF7eIUfOj+a6?=
 =?us-ascii?Q?GIID1MoVUdeMJgVVrhm29m3Fn8mdJLSe9L8T3pM0rOC4TC00bSlt8/ZnIK0a?=
 =?us-ascii?Q?vCxKy9SYGnpZ0F8B4CZavvFihhO3y2yVDFCGCJFPbGCB0vEoor0L04X/S4iR?=
 =?us-ascii?Q?jabQ+TXh2oWNmmoIWttcMfMcAmQqHK2PsUr/2KTQ/ohFd12+tv1TE7fC0gBO?=
 =?us-ascii?Q?856+Aubci2EaLsBwDc5rfwtlvX5kiiTWmRtBKTaLZZ0khMdpNfIpqjHM2LTL?=
 =?us-ascii?Q?gQbMc3cl13zhBR2xICQ0vm+D8mPtpsoUH8l3ZGyqbPIE3olFRR2bbTu97KQo?=
 =?us-ascii?Q?WwM+u6Ap837V4bkH9rcp10+4bRuOx9gxviiBV99Q/itZ0jBwjYJfYONbcWUX?=
 =?us-ascii?Q?7/TevZAa/+nIFeXE/v3DPqsKR3HnD9zkBauaCEvWqSSis40LWqA+zPIz7cFd?=
 =?us-ascii?Q?DEmoQFfUTaFC0jnFaSQ6bzIoJF4oBe3XjqREflF8pfki8gv9oXqHIcKsEB7G?=
 =?us-ascii?Q?+fFFjWEQL0wq/LEq2G1cTj382RG69jwFH2Mawh7UqEILwq6J3rxCaivrgOnU?=
 =?us-ascii?Q?EXlcpVUcXq7eC7cvXz1oZYBTmFY49MK7095vLOOVSX4MNzl0Z0mn8DwKno4b?=
 =?us-ascii?Q?eT5waDmuv14UdHZ/KVdVlGva0BhPvH2ysxE7r51Y2qoWwWG1IECqb7kzMU6s?=
 =?us-ascii?Q?B9MNumCf3Z7hIi9KDrmRFBKVSeu2/vTciBdZvweSFskzyCZETmUp8lRDIyzC?=
 =?us-ascii?Q?G7Riq+2N/siDX25YMEHBhuUQCw/VOzttQqLgia90tnKa5AMwBXtXHhPiZFRE?=
 =?us-ascii?Q?GaGLpSEEIfVg7JK6oU9o4qVx3MQJA0Gw5YtIj39EQWIc0QkuRkWIJnWKcNcX?=
 =?us-ascii?Q?UHLGW7CRT9JM4TgEJqDoEMCNtU+DEkeqF37SYzFfqwUTpD0e7617+Ie5iZ0q?=
 =?us-ascii?Q?bpjaWDthkIF1ApvdiveNVOWi/DRuhRzy9PAefQ0tHfrqK9s6ou9rLGxcegxZ?=
 =?us-ascii?Q?lIYT6FonZ/eFU0xvftU926tZBL9rf7SlRP3k6Hca8bIyc6iBFeq+oM8zGb3j?=
 =?us-ascii?Q?jvk6lKN3t6U1zctY+nQfomTi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 10:02:45.3066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1aff41-78dd-48aa-4c64-08dc8546a5b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6329
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
index ce7c5eb6d34..18e9d308de3 100644
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
index 0a0cbd2b69a..5261e793c14 100644
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
index 561b546e37f..0ef0357bd29 100644
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
index 64683e0ccbb..92d8851eb8a 100644
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

