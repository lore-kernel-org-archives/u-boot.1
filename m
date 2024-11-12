Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9DFD41D53
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 05:13:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B638A893AB;
	Tue, 12 Nov 2024 06:13:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qG5K/5/t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9549E889D2; Tue, 12 Nov 2024 06:13:26 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DF52893C7
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:13:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYJV1niPLrGsMMZrVPOjIjhUhTdan6RKIBJbdaxAI+zpY54QdW+jyka2qKvLTZU7tK1N8Chy4UHEyVzn5KjQ5h6khDu7BJBbqrMlT/9B2quqbq15X4sBFvzFVYuZft5ot4acuNr+h6YbwEber0CJRh+kt76vRM677X1vfjIkmiWkKlscfg2bWM84TbUlzyRUr3ENdd2f5OarAAGLh8p1VKoq7WCwUhRVGGdDZ01KbLlONQwQsJsnoyPBAd3XmOxp8BEB2vYyliit/jLs17Sn0+EVvY7UIoxNswBKopZ5Vklj79D+4lIjYaSP/wLCAgq+CuV7GdP+QB76t3jtm1sjuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zhu+25n90FlcaBW3hto8wQIfk3wlk/choLOF14snj3M=;
 b=W6P9g7gb7TLWaXN/jKW0ssm2hOj8q3nvX1qi/YjNGkyV0Ox5q0fS+O/8IlAv1Y7oWUANCOhDBi5bHSYfHw2kC8qOBM5lEp96luTx8fV2PmiwzoI3DwwnzrOg6bOohp7vZwvivAUFM1Aeq5RQIyt4Qrle7FS+pAP4/s6CCFn1uX3vgkGL6DpIU/mtCeUfvGLcekQSROoUYrGgPdNJ6EKiBgLJnjgQpjnRaEfqiCHyYnS3u+oJen4th1/QMdXnaLadxWGOpdQZ4nflspz45mNTP0hYEi4EU4WjmrY+7RVFeX9Z50ezUBMgiSxwR8dB8IiITpDOw6SQYBuKXycua4W0kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zhu+25n90FlcaBW3hto8wQIfk3wlk/choLOF14snj3M=;
 b=qG5K/5/tBcFkG1fMjxD0XgQFQ/vdrmSz6Lwq7hQIC9EYXoSw3/wrgiA1OBgl3opW3uET4+hdgrm/HKFQFVB0GRk41QB1hmzp5ONmzyoS4LOQCe7jQTB/C+/opg7+pfNM5wuQcN25GwaDH8KMbAXZEH5YfscehnIRF/iH6O9Vg+A=
Received: from MN2PR16CA0042.namprd16.prod.outlook.com (2603:10b6:208:234::11)
 by SA1PR12MB8161.namprd12.prod.outlook.com (2603:10b6:806:330::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 05:13:15 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::c7) by MN2PR16CA0042.outlook.office365.com
 (2603:10b6:208:234::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Tue, 12 Nov 2024 05:13:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 05:13:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Nov
 2024 23:12:28 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Nov 2024 23:12:19 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v11 7/7] arm64: zynqmp: Update the usb5744 hub node as per
 binding
Date: Tue, 12 Nov 2024 10:37:40 +0530
Message-ID: <20241112050740.15343-8-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241112050740.15343-1-venkatesh.abbarapu@amd.com>
References: <20241112050740.15343-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|SA1PR12MB8161:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cef60b0-a786-4758-3382-08dd02d8b688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6P+xcO1FoemWgbV8bSVGc5DHP/+y/YvsDHtUuJhJo+FZlZ8WoHVLBDA+VAhE?=
 =?us-ascii?Q?NQ5w6j1qyxpHr6GHHKGIwjYuyj78r+X1WS0lGysCzKEuTPFPrfiSENYg+KdW?=
 =?us-ascii?Q?75jE0I+o44ggj8g2uU0vtYxEbz79dnmK4QwsyrYs+CQY6ABg7DXYKGoeYc8E?=
 =?us-ascii?Q?qMGJyf1BytYbMryXI5RlPyZiE0UySjcfCPweZJ2qFyLk2PLqX5zH4kCGKEGA?=
 =?us-ascii?Q?WrfKiz9mK/lhVpRuLxTrknz6RRGF64SGdaaLdlx0HQEbl+IsGGtoqGRd1o1/?=
 =?us-ascii?Q?rBrJke/nDzIuRwDKo2KN3IoD1y6/EGTqdNFzGzW3l3aFy1Cf6cPQMC5ZZaBP?=
 =?us-ascii?Q?6HTVjPwIf2+zkzz/xx09gPPZ3oJwC405blKnz6OLVg4H/Kisx0o7opZfOZ5A?=
 =?us-ascii?Q?Dw0I+fBVzuW35c0aaNwL5mbaCETkqCyxET+szz/8T/OCHQmWyUd8atQ2HCkB?=
 =?us-ascii?Q?4iBnYyQg68eAH1/rbUUKzdQnQH168hhl6avQklPEE1A0H3cMj/7tn1ANgRdJ?=
 =?us-ascii?Q?+neowDcjEilBm3bB3Mf5E4gruNqL/7V4d2JkS3Qez/bm3eFkXRKk+NQtdCpo?=
 =?us-ascii?Q?wbjC25NIU8V7TG887yLrSD1IIwQbf6J8KZvN+SjyycgTMo9mSHJkY52A0CaV?=
 =?us-ascii?Q?Ws2QPEpjIWPecOb6TN1G0S8PeblszXJnI1K2/zj1qeaUHUmR79UcF8wRZU5O?=
 =?us-ascii?Q?NVo8aCaKz8mihdj4iKQ1/IDbF7EmQoaLVOyDzIYar7wBk8PhOEKcvU1cihE6?=
 =?us-ascii?Q?y4JKt7B/gvFMeBx/wQKZpcBHTEhFJWy6a5gOHejvSD2417PnddHgCXrs+p06?=
 =?us-ascii?Q?xj+nszBw7VkazroBT1dsmRXjMXROD5fkw1atlWL2dGudYryExy4hsaTbm1U6?=
 =?us-ascii?Q?/u2rDqnrMYYQvUZYbNzZgll8ZYcxhPyZBGKvXUuIyemZhBxqNvqfMkS3VaCD?=
 =?us-ascii?Q?MdSdA7n8yBealC2z8PmEKFjKw6vCb6ZwRj9N9DY4UPvxoYlN+0g7I8TXPCaS?=
 =?us-ascii?Q?GWK/Q/z3Ac6Dj8/+lZ5TnsclH7dEz30yKatFhfrSlQCR3yOYvgca7VwM1hDd?=
 =?us-ascii?Q?zVf5RQMUFdU3RJXrpicN+I+7J0pMNc/BGApPlhRmvnDCY7yhXeG6yd67UVdX?=
 =?us-ascii?Q?73Fanssn9H6WyHYYIrihHF4m5bLiFTpwODoX3/JJGN6FurScb15NmOOqnY1y?=
 =?us-ascii?Q?ERgPrVeqv9HCeLNASDbxTLaUHaEmt4dJFLChZP2To9aC9GHezdq4az/m/j3I?=
 =?us-ascii?Q?fXP3KQs8bAA+H7RyJX2RsVsHn/xXHH+TvwhBQxAwlzOnskgjX67YFlZmhaG4?=
 =?us-ascii?Q?BNfasfPCCpWoYFr7jaG3Vnb0fAigaH7wXjUNs2nhApkb1LX4l2H//PXNkU15?=
 =?us-ascii?Q?0XagdfQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 05:13:08.3330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cef60b0-a786-4758-3382-08dd02d8b688
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8161
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

