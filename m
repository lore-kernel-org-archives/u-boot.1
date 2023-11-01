Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7549FC4167B
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 11:22:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 215728770E;
	Wed,  1 Nov 2023 12:22:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KG0VUoXO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2003F87679; Wed,  1 Nov 2023 12:22:42 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A50C87521
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 12:22:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+KrrZuQT87fH3k2lEkg34XQRh8DL0pAJKeAVR4NX2sTcekLHsSHPMvXVFkHzMTsbby4i3cMOcFgV+1Qky0TPVaJdn/dBQ0y0EjJOmVg1yKWbI+psvE0OIXTkYNSYzhvYDFmhK9vq2DGbnO8PrFVuZnCCe619HoYVxYx5c8lv8/5/2tEZIRYRYsXryQGxQkjquVU7hUZ0pTMcn4pT/8A5uV2ogrdV/BoSF8kTtydktnGxmF0wQ+GnpQRAMS+ZDBFjLMpXzhWht23K8y7pdIsWUVBVSLWZnbE/DP1edmub6ljqUSIkxmfoijPoxkDgTTIvEDWvfXRRDYM4++kTg2iRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZbC2CcWBBWJEkQ5rjHWctIqysS6CW3gPV0z/cEkUoM=;
 b=fWhnQLC+lS/hMIHrMrSKLQy3HFlYDnpT/+ryfsROLUKI5nHPg8+6sDRjnS7c7QrtrpAya3HlGccY0yasRZuWirQXES+QSNxUqeIiD3rL5iv5Oatr/K0mT/sJrt2WL54Z4QNX7de8Eqq/nQRJ+cXMyIQ2pF1Tu8REdm/JKPpjyWLwiRd+Y+kRw57tASAm33HAMB6VWAOkBc0bESNxhqmqiSGknzIt9uUxizu0hMM/5wWW2E25xfvoejWClwky/ywCiV1mBCTpznDM22WAgsLL1OMvKLNRUZ5ud/Q2J6U0srFN+Tjxl+GfxDWyxHXc7Y3YwcMMMZgI/Xc86rUAgyCK3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZbC2CcWBBWJEkQ5rjHWctIqysS6CW3gPV0z/cEkUoM=;
 b=KG0VUoXOFCDt6jkBJrP4+mrel55nw2TDbTli/GYW5LV9hux3U97BvQ7yEtTo4HsPbpJ0/Qp9WghCikL8JVpz3Je92NUmm69s76KT19N8v3y5FyRD7hmS2ZwnpmSWZDslEQekVfWwZooPuCaiWseB4d+1IctKZCu9jT6SUbPr7Mo=
Received: from CH5PR02CA0001.namprd02.prod.outlook.com (2603:10b6:610:1ed::17)
 by CO6PR12MB5441.namprd12.prod.outlook.com (2603:10b6:303:13b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Wed, 1 Nov
 2023 11:22:34 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::1f) by CH5PR02CA0001.outlook.office365.com
 (2603:10b6:610:1ed::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 11:22:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 11:22:34 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 06:22:26 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/2] ARM: zynq: Add partition description
Date: Wed, 1 Nov 2023 12:22:14 +0100
Message-ID: <4c3348981bba32d3892194420d78fe8621c47534.1698837725.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <b3c4a3eddb71aab9535b034380d0dbae770828d4.1698837725.git.michal.simek@amd.com>
References: <b3c4a3eddb71aab9535b034380d0dbae770828d4.1698837725.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8219; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=c1SNK11HoroCzDw4ervSLY0p5pud6lDXjFIf/tzexK4=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlQnk0frMgKrYgTkeZtf33Guqk1OeG8yb9pUv64N7Ts1X
 qjUzvLuiGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABP5lMIwv6RlaYr284zGhWdF
 Uie80//j8vFDFsN8x0XCei3W8saLfiorz/tY8TyKo9UQAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|CO6PR12MB5441:EE_
X-MS-Office365-Filtering-Correlation-Id: 9256fbac-8fba-41fe-9093-08dbdaccd86f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jQ+KsIczwhN03OLRsnjegJd1fwZAc8/S+cpvai3rlln0uTj5cWWLWWfcEL4vHsXquGtYjbJKYYjurlsjPffC+P780rDv5fQ47e7OoIcMS+YNBXIDQyDbcIyf3YIexrPpf5B18U1HFPtQgpaCUZU3Qx6qvZ2TrBdJ7pJqehE584fgoCcX2nTHTO/h0pAUwyX3r0YMsbDybd5RDRpp71qk14zLR0C7GcE1yTDajThtJh+ZPacS9Sc+lHGSHl6G7vkGWpDTKruUG7hDk2Epci1lSZldthlsjDCVRfnyRhvjCWmnfed7afdoTGfuzTVrCwTBKDKiRAjzpKr3S95bAL+kWt5YBsRfdZRORN45KUReQChFvb1IAbCOCsgYpI00IE9raKytSSH5CEXMtKSxu54G3mm2+HHwPxKnRSTfs77C/ZuAYVX038sUyoKaKEg+a+zarpbgvmk1lcYJRXIJLKXGwuzreVPT2FCRJlvPJaxXntb/MfyjDNgeke3NPyccJcMmBuNEPfMGGOPnOBNNi9DU5XR20uOm1UUwEeOt63AZTuOXkIg/+axA7sJFJ/CKl9roGiej5WnrQGdEe7nTDfcAsFN/cbWVaWT5BBrm+472es+7zPiNtMBMCuv4BCz7KVkiYiNdOyLugDDRRHMW9+u/B/hEc9maviIpI+/ox2HgSdKZwh4KNwZDSYI31x654jmftvlGA9YQdu7klsBkKIN+K+qpWxgngggY1/6meoyzNLZXnKZMHMCgd7WH+4NSIF1lbjlMyb6NnvPUxVKbIClx9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799009)(40470700004)(36840700001)(46966006)(8936002)(44832011)(8676002)(40460700003)(86362001)(82740400003)(70586007)(110136005)(6666004)(316002)(478600001)(36756003)(36860700001)(26005)(336012)(2616005)(426003)(47076005)(16526019)(356005)(83380400001)(81166007)(70206006)(40480700001)(41300700001)(2906002)(5660300002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 11:22:34.1493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9256fbac-8fba-41fe-9093-08dbdaccd86f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5441
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

Xilinx is using standard mtd partition layout for quite a long time. It is
used for testing purpose on evaluation boards.
Also #address/size-cells shouldn't be present without nodes which should
use them that's why move them from zynq-7000.dtsi to nand/nor nodes
directly.

The patch was tested on zc706 and zedboard(with also increasing max
frequency and rx bus width).

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/bitmain-antminer-s9.dts |  2 ++
 arch/arm/dts/zynq-7000.dtsi          |  4 ----
 arch/arm/dts/zynq-zc702.dts          | 25 ++++++++++++++++++++++++
 arch/arm/dts/zynq-zc706.dts          | 25 ++++++++++++++++++++++++
 arch/arm/dts/zynq-zc770-xm010.dts    | 25 ++++++++++++++++++++++++
 arch/arm/dts/zynq-zc770-xm011.dts    | 19 ++++++++++++++++++
 arch/arm/dts/zynq-zc770-xm012.dts    | 25 ++++++++++++++++++++++++
 arch/arm/dts/zynq-zc770-xm013.dts    | 25 ++++++++++++++++++++++++
 arch/arm/dts/zynq-zed.dts            | 29 +++++++++++++++++++++++++++-
 9 files changed, 174 insertions(+), 5 deletions(-)

diff --git a/arch/arm/dts/bitmain-antminer-s9.dts b/arch/arm/dts/bitmain-antminer-s9.dts
index 0228b4b30e5b..f5ad95a276b6 100644
--- a/arch/arm/dts/bitmain-antminer-s9.dts
+++ b/arch/arm/dts/bitmain-antminer-s9.dts
@@ -52,6 +52,8 @@
 
 &nfc0 {
 	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
 	nand@0 {
 		reg = <0>;
 	};
diff --git a/arch/arm/dts/zynq-7000.dtsi b/arch/arm/dts/zynq-7000.dtsi
index fb61fe98e3de..f8c786ab0b7b 100644
--- a/arch/arm/dts/zynq-7000.dtsi
+++ b/arch/arm/dts/zynq-7000.dtsi
@@ -306,15 +306,11 @@
 				compatible = "arm,pl353-nand-r2p1";
 				reg = <0 0 0x1000000>;
 				status = "disabled";
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 			nor0: flash@1,0 {
 				status = "disabled";
 				compatible = "cfi-flash";
 				reg = <1 0 0x2000000>;
-				#address-cells = <1>;
-				#size-cells = <1>;
 			};
 		};
 
diff --git a/arch/arm/dts/zynq-zc702.dts b/arch/arm/dts/zynq-zc702.dts
index 8d47f24b757b..0106d7bb1778 100644
--- a/arch/arm/dts/zynq-zc702.dts
+++ b/arch/arm/dts/zynq-zc702.dts
@@ -406,6 +406,31 @@
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <4>;
 		spi-max-frequency = <50000000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "qspi-fsbl-uboot";
+				reg = <0x0 0x100000>;
+			};
+			partition@100000 {
+				label = "qspi-linux";
+				reg = <0x100000 0x500000>;
+			};
+			partition@600000 {
+				label = "qspi-device-tree";
+				reg = <0x600000 0x20000>;
+			};
+			partition@620000 {
+				label = "qspi-rootfs";
+				reg = <0x620000 0x5e0000>;
+			};
+			partition@c00000 {
+				label = "qspi-bitstream";
+				reg = <0xc00000 0x400000>;
+			};
+		};
 	};
 };
 
diff --git a/arch/arm/dts/zynq-zc706.dts b/arch/arm/dts/zynq-zc706.dts
index 18963a395156..ceea982546e8 100644
--- a/arch/arm/dts/zynq-zc706.dts
+++ b/arch/arm/dts/zynq-zc706.dts
@@ -317,6 +317,31 @@
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <4>;
 		spi-max-frequency = <50000000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "qspi-fsbl-uboot";
+				reg = <0x0 0x100000>;
+			};
+			partition@100000 {
+				label = "qspi-linux";
+				reg = <0x100000 0x500000>;
+			};
+			partition@600000 {
+				label = "qspi-device-tree";
+				reg = <0x600000 0x20000>;
+			};
+			partition@620000 {
+				label = "qspi-rootfs";
+				reg = <0x620000 0x5e0000>;
+			};
+			partition@c00000 {
+				label = "qspi-bitstream";
+				reg = <0xc00000 0x400000>;
+			};
+		};
 	};
 };
 
diff --git a/arch/arm/dts/zynq-zc770-xm010.dts b/arch/arm/dts/zynq-zc770-xm010.dts
index 17680d7f8ec8..199384bec967 100644
--- a/arch/arm/dts/zynq-zc770-xm010.dts
+++ b/arch/arm/dts/zynq-zc770-xm010.dts
@@ -69,6 +69,31 @@
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <4>;
 		spi-max-frequency = <50000000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "qspi-fsbl-uboot";
+				reg = <0x0 0x100000>;
+			};
+			partition@100000 {
+				label = "qspi-linux";
+				reg = <0x100000 0x500000>;
+			};
+			partition@600000 {
+				label = "qspi-device-tree";
+				reg = <0x600000 0x20000>;
+			};
+			partition@620000 {
+				label = "qspi-rootfs";
+				reg = <0x620000 0x5e0000>;
+			};
+			partition@c00000 {
+				label = "qspi-bitstream";
+				reg = <0xc00000 0x400000>;
+			};
+		};
 	};
 };
 
diff --git a/arch/arm/dts/zynq-zc770-xm011.dts b/arch/arm/dts/zynq-zc770-xm011.dts
index d1e971254e51..f9a086fe66d3 100644
--- a/arch/arm/dts/zynq-zc770-xm011.dts
+++ b/arch/arm/dts/zynq-zc770-xm011.dts
@@ -49,8 +49,27 @@
 
 &nfc0 {
 	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
 	nand@0 {
 		reg = <0>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "nand-fsbl-uboot";
+				reg = <0x0 0x1000000>;
+			};
+			partition@1000000 {
+				label = "nand-linux";
+				reg = <0x1000000 0x2000000>;
+			};
+			partition@3000000 {
+				label = "nand-rootfs";
+				reg = <0x3000000 0x200000>;
+			};
+		};
 	};
 };
 
diff --git a/arch/arm/dts/zynq-zc770-xm012.dts b/arch/arm/dts/zynq-zc770-xm012.dts
index 6e36634e3d4e..24520e7d3965 100644
--- a/arch/arm/dts/zynq-zc770-xm012.dts
+++ b/arch/arm/dts/zynq-zc770-xm012.dts
@@ -56,6 +56,31 @@
 &nor0 {
 	status = "okay";
 	bank-width = <1>;
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		partition@0 {
+			label = "nor-fsbl-uboot";
+			reg = <0x0 0x100000>;
+		};
+		partition@100000 {
+			label = "nor-linux";
+			reg = <0x100000 0x500000>;
+		};
+		partition@600000 {
+			label = "nor-device-tree";
+			reg = <0x600000 0x20000>;
+		};
+		partition@620000 {
+			label = "nor-rootfs";
+			reg = <0x620000 0x5e0000>;
+		};
+		partition@c00000 {
+			label = "nor-bitstream";
+			reg = <0xc00000 0x400000>;
+		};
+	};
 };
 
 &smcc {
diff --git a/arch/arm/dts/zynq-zc770-xm013.dts b/arch/arm/dts/zynq-zc770-xm013.dts
index 582aa1f1b873..add75999f47a 100644
--- a/arch/arm/dts/zynq-zc770-xm013.dts
+++ b/arch/arm/dts/zynq-zc770-xm013.dts
@@ -69,6 +69,31 @@
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <4>;
 		spi-max-frequency = <50000000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "qspi-fsbl-uboot";
+				reg = <0x0 0x100000>;
+			};
+			partition@100000 {
+				label = "qspi-linux";
+				reg = <0x100000 0x500000>;
+			};
+			partition@600000 {
+				label = "qspi-device-tree";
+				reg = <0x600000 0x20000>;
+			};
+			partition@620000 {
+				label = "qspi-rootfs";
+				reg = <0x620000 0x5e0000>;
+			};
+			partition@c00000 {
+				label = "qspi-bitstream";
+				reg = <0xc00000 0x400000>;
+			};
+		};
 	};
 };
 
diff --git a/arch/arm/dts/zynq-zed.dts b/arch/arm/dts/zynq-zed.dts
index 5320b4b233ae..70bc41822e36 100644
--- a/arch/arm/dts/zynq-zed.dts
+++ b/arch/arm/dts/zynq-zed.dts
@@ -55,8 +55,35 @@
 	flash@0 {
 		compatible = "spansion,s25fl256s1", "jedec,spi-nor";
 		reg = <0>;
-		spi-max-frequency = <30000000>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <50000000>;
 		m25p,fast-read;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "qspi-fsbl-uboot";
+				reg = <0x0 0x100000>;
+			};
+			partition@100000 {
+				label = "qspi-linux";
+				reg = <0x100000 0x500000>;
+			};
+			partition@600000 {
+				label = "qspi-device-tree";
+				reg = <0x600000 0x20000>;
+			};
+			partition@620000 {
+				label = "qspi-rootfs";
+				reg = <0x620000 0x5e0000>;
+			};
+			partition@c00000 {
+				label = "qspi-bitstream";
+				reg = <0xc00000 0x400000>;
+			};
+		};
 	};
 };
 
-- 
2.36.1

