Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2D6C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 08:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F34BB876B8;
	Wed,  1 Nov 2023 09:01:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3d/eiV+d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D18D787156; Wed,  1 Nov 2023 09:01:19 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::61c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE098876B8
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 09:01:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ue4TnmxvbiVE8+KDIVYaiNVALCMnVHzLQ2iG8FqmGC6ibq2VVhEqclxFJxCW4YcE0U1VWgNEBIdbw/XIcO4mVJZGoQ8ljdASea8da3TrT+hxVlMi5lRrxt3tGWAY4IXtnMGaVPRqvn/pK+nciWomRJ+vTlPB477Cw7PnfNfs4oXEzkIxEMejpItO99bxmHRliLvV5rFlKLnrO5jfvjehqeVXxh0c5QxXpNwTyNWJl2bHWPYq7jvzpyGoWESN3dm0b6unjHIgeFOF45pox1YFhHUZLkdGqWZG3Ul0u9Dia/dYlzTCx4iiA+mU1Ew1z07M3ImudEfIj35YGOh4tttggQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRKHJl409gJpXqmmnGUVRgNYirW3uDbQwkY1aupeG2I=;
 b=FnEarZGjgCmZfBUrHL8i7+bWXZDlH8RNQ6qo6tDfT6gQSSTlc9jZXrqm+mo6UHv4FEEXuUOn8RKcpp7xDZVpkzn6H/7i/aC63c/U50uj3j/R/YBA7SngNQRMclvfT4mTemIJG4SQrv+gW32f6Cf8j4aBrMHxPtoX5A9AOuHWgUBgS+av2AqT1RCf3Nt3kwygv1u0v6l55xpRQvcL/my1bRNCb7l/YK8z02tDYECGfTpIa83vTmbrt2G8diYCTWexp4GyChIomoOmpymrJGTs33Z4pPmXSP51kW7UXiJZ6+zKwPaXgf1dg0NYboFZdQjIk7Kgp0HXrt1QCX8GfslGmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRKHJl409gJpXqmmnGUVRgNYirW3uDbQwkY1aupeG2I=;
 b=3d/eiV+dbtCNUA1PWazY7z676rZOYm4GnczV2RwT5dMFcAtkt4QhckjOVf8+lCW3M6UtFPzAiz8EtzL0BvHJiAXnuU/nj7Nz8THFHWW4oAoYEZdk6ropEZ4O+Z+jqXi3dehYVM/tDCkqobgUTUpw0OodNiqI57FBhIVnAVu7eOw=
Received: from MN2PR04CA0022.namprd04.prod.outlook.com (2603:10b6:208:d4::35)
 by LV8PR12MB9230.namprd12.prod.outlook.com (2603:10b6:408:186::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Wed, 1 Nov
 2023 08:01:12 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:d4:cafe::5) by MN2PR04CA0022.outlook.office365.com
 (2603:10b6:208:d4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29 via Frontend
 Transport; Wed, 1 Nov 2023 08:01:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 08:01:11 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 03:01:10 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Piyush Mehta
 <piyush.mehta@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Robert Hancock <robert.hancock@calian.com>, Simon Glass <sjg@chromium.org>,
 Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v2] arm64: zynqmp: Comment all smmu entries
Date: Wed, 1 Nov 2023 09:01:03 +0100
Message-ID: <e868c27c52ded5d8ef25f75ba394b1ab3b31b80a.1698825657.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9149; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Jjnspc+Y6jixVsZT9b7u9u6tr32oEEnjbM4C/Bm2f5I=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlQn1l2W90/N1/uRFxOzWrNi4Zv/xxbabdeQeKA2efvFz
 ZsnpZexdcSyMAgyMciKKbJI21w5s7dyxhThi4flYOawMoEMYeDiFICJXMhlmJ8cz3ndNTOgw7WZ
 8wL//jKDYCfTVwzzPRtq9P4IH3wUoa+S7v92knpeeIwAAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|LV8PR12MB9230:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e55dea7-0236-4bc0-d7aa-08dbdab0b6c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S5GQhDN/rJZgE2IBvLP1tulGbFpfDWYmlJkuB8kPzQPSzyTEqaPCb8dHeC4/KZllIGnhkKHz3cglHxizHlCgV4AlCPW63y4Dth1wJ7b4MeQBcoqPwO5rF9PYAH9E4lM/nLoQRCxuoqFHwjDxEN00fc32JvUVOxIPm9CoGjUyG+LskL1nUO1aUWrSR3A6pxbNVOa2L6gwZldJGD2QrT09ipcjMFizwnU/FYB2JdanJZl0gOB4EB/jEPLa7Z9IpO1/QJW1cj4Jtsn6z6bFFvstQmzRlGkGLcrPd7LjbR4PokueEjY/CIftVAPSu0V69VuIl8OmgTwkTDdudgbCvlAEts2SAFw3HCczCHWrrTVM4gaOj9z2y2hfaZhlaFXecv/jyNqv5ooInSLve2DW0q3cGU04gZ6/U4HCz3MqGiC9BPNf9tKBUdH256g0qLYACHJNuk3f0TMvLKFxFFuEKrSt/NA2uZjfar6NGbsTv+OuHlB4FkHuoWVMf/OxOHpk4LDVk03Q4xAw3dFX4uW3gU1boE5VlAq2Gf3JY4dD9e4SeTks+9+8Qr3EsqWsQFLgblsQ/zgsV56gUZsxpaiWJ1JO3UzCuuiVsNg84fx7Mo3a1iJ3il6fxknE9kAdTFrgoYIWai85Aktx0e0CqWhnrRQG2B5IaTbIz79gmFxpQrpvNVjML2BNy9Pb3qPCdhwX/a21STPS6XpmjC9Kd6XlVdnae7QIoiFW2TH8TqsWLkM7l15Q6MPIsLEtf2yNr73LUfvvxXfZW7p+rIivIJ9xQ0nBsQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(1800799009)(186009)(64100799003)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(16526019)(2616005)(26005)(40460700003)(316002)(82740400003)(40480700001)(36756003)(86362001)(81166007)(356005)(426003)(336012)(2906002)(4326008)(83380400001)(478600001)(36860700001)(6666004)(47076005)(8676002)(5660300002)(8936002)(41300700001)(110136005)(54906003)(44832011)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 08:01:11.8368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e55dea7-0236-4bc0-d7aa-08dbdab0b6c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9230
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

SMMU is disabled by default and not all masters can be enabled at the same
time because of limited number of entries. That's why comment all iommu
properties but keep them for reference in DT. In XEN case they should be
added back and Xen should have SMMU enabled by default.
Also add IDs for DP and DPDMA.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- add missing one for DPDMA
- update commit message to cover DP and DPDMA

 arch/arm/dts/zynqmp.dtsi | 59 ++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index 2253e773d386..66d53359d83d 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -339,7 +339,7 @@
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
-			iommus = <&smmu 0x14e8>;
+			/* iommus = <&smmu 0x14e8>; */
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
 
@@ -352,7 +352,7 @@
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
-			iommus = <&smmu 0x14e9>;
+			/* iommus = <&smmu 0x14e9>; */
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
 
@@ -365,7 +365,7 @@
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
-			iommus = <&smmu 0x14ea>;
+			/* iommus = <&smmu 0x14ea>; */
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
 
@@ -378,7 +378,7 @@
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
-			iommus = <&smmu 0x14eb>;
+			/* iommus = <&smmu 0x14eb>; */
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
 
@@ -391,7 +391,7 @@
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
-			iommus = <&smmu 0x14ec>;
+			/* iommus = <&smmu 0x14ec>; */
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
 
@@ -404,7 +404,7 @@
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
-			iommus = <&smmu 0x14ed>;
+			/* iommus = <&smmu 0x14ed>; */
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
 
@@ -417,7 +417,7 @@
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
-			iommus = <&smmu 0x14ee>;
+			/* iommus = <&smmu 0x14ee>; */
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
 
@@ -430,7 +430,7 @@
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
-			iommus = <&smmu 0x14ef>;
+			/* iommus = <&smmu 0x14ef>; */
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
 
@@ -475,7 +475,7 @@
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
-			iommus = <&smmu 0x868>;
+			/* iommus = <&smmu 0x868>; */
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
@@ -488,7 +488,7 @@
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
-			iommus = <&smmu 0x869>;
+			/* iommus = <&smmu 0x869>; */
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
@@ -501,7 +501,7 @@
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
-			iommus = <&smmu 0x86a>;
+			/* iommus = <&smmu 0x86a>; */
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
@@ -514,7 +514,7 @@
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
-			iommus = <&smmu 0x86b>;
+			/* iommus = <&smmu 0x86b>; */
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
@@ -527,7 +527,7 @@
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
-			iommus = <&smmu 0x86c>;
+			/* iommus = <&smmu 0x86c>; */
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
@@ -540,7 +540,7 @@
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
-			iommus = <&smmu 0x86d>;
+			/* iommus = <&smmu 0x86d>; */
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
@@ -553,7 +553,7 @@
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
-			iommus = <&smmu 0x86e>;
+			/* iommus = <&smmu 0x86e>; */
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
@@ -566,7 +566,7 @@
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
-			iommus = <&smmu 0x86f>;
+			/* iommus = <&smmu 0x86f>; */
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
@@ -586,7 +586,7 @@
 			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			iommus = <&smmu 0x872>;
+			/* iommus = <&smmu 0x872>; */
 			power-domains = <&zynqmp_firmware PD_NAND>;
 		};
 
@@ -598,7 +598,7 @@
 				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff0b0000 0x0 0x1000>;
 			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
-			iommus = <&smmu 0x874>;
+			/* iommus = <&smmu 0x874>; */
 			power-domains = <&zynqmp_firmware PD_ETH_0>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_GEM0>;
 			reset-names = "gem0_rst";
@@ -612,7 +612,7 @@
 				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff0c0000 0x0 0x1000>;
 			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
-			iommus = <&smmu 0x875>;
+			/* iommus = <&smmu 0x875>; */
 			power-domains = <&zynqmp_firmware PD_ETH_1>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_GEM1>;
 			reset-names = "gem1_rst";
@@ -626,7 +626,7 @@
 				     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff0d0000 0x0 0x1000>;
 			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
-			iommus = <&smmu 0x876>;
+			/* iommus = <&smmu 0x876>; */
 			power-domains = <&zynqmp_firmware PD_ETH_2>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_GEM2>;
 			reset-names = "gem2_rst";
@@ -640,7 +640,7 @@
 				     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff0e0000 0x0 0x1000>;
 			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
-			iommus = <&smmu 0x877>;
+			/* iommus = <&smmu 0x877>; */
 			power-domains = <&zynqmp_firmware PD_ETH_3>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_GEM3>;
 			reset-names = "gem3_rst";
@@ -719,7 +719,7 @@
 					<0x0 0x0 0x0 0x2 &pcie_intc 0x2>,
 					<0x0 0x0 0x0 0x3 &pcie_intc 0x3>,
 					<0x0 0x0 0x0 0x4 &pcie_intc 0x4>;
-			iommus = <&smmu 0x4d0>;
+			/* iommus = <&smmu 0x4d0>; */
 			power-domains = <&zynqmp_firmware PD_PCIE>;
 			pcie_intc: legacy-interrupt-controller {
 				interrupt-controller;
@@ -740,7 +740,7 @@
 			      <0x0 0xc0000000 0x0 0x8000000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			iommus = <&smmu 0x873>;
+			/* iommus = <&smmu 0x873>; */
 			power-domains = <&zynqmp_firmware PD_QSPI>;
 		};
 
@@ -772,8 +772,7 @@
 			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&zynqmp_firmware PD_SATA>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_SATA>;
-			iommus = <&smmu 0x4c0>, <&smmu 0x4c1>,
-				 <&smmu 0x4c2>, <&smmu 0x4c3>;
+			/* iommus = <&smmu 0x4c0>, <&smmu 0x4c1>, <&smmu 0x4c2>, <&smmu 0x4c3>; */
 			/* dma-coherent; */
 		};
 
@@ -785,7 +784,7 @@
 			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff160000 0x0 0x1000>;
 			clock-names = "clk_xin", "clk_ahb";
-			iommus = <&smmu 0x870>;
+			/* iommus = <&smmu 0x870>; */
 			#clock-cells = <1>;
 			clock-output-names = "clk_out_sd0", "clk_in_sd0";
 			power-domains = <&zynqmp_firmware PD_SD_0>;
@@ -800,7 +799,7 @@
 			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff170000 0x0 0x1000>;
 			clock-names = "clk_xin", "clk_ahb";
-			iommus = <&smmu 0x871>;
+			/* iommus = <&smmu 0x871>; */
 			#clock-cells = <1>;
 			clock-output-names = "clk_out_sd1", "clk_in_sd1";
 			power-domains = <&zynqmp_firmware PD_SD_1>;
@@ -951,7 +950,7 @@
 				interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
-				iommus = <&smmu 0x860>;
+				/* iommus = <&smmu 0x860>; */
 				snps,quirk-frame-length-adjustment = <0x20>;
 				clock-names = "ref";
 				snps,enable_guctl1_ipd_quirk;
@@ -983,7 +982,7 @@
 				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-				iommus = <&smmu 0x861>;
+				/* iommus = <&smmu 0x861>; */
 				snps,quirk-frame-length-adjustment = <0x20>;
 				clock-names = "ref";
 				snps,enable_guctl1_ipd_quirk;
@@ -1043,6 +1042,7 @@
 			interrupt-parent = <&gic>;
 			clock-names = "axi_clk";
 			power-domains = <&zynqmp_firmware PD_DP>;
+			/* iommus = <&smmu 0xce4>; */
 			#dma-cells = <1>;
 		};
 
@@ -1057,6 +1057,7 @@
 			reg-names = "dp", "blend", "av_buf", "aud";
 			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-parent = <&gic>;
+			/* iommus = <&smmu 0xce3>; */
 			clock-names = "dp_apb_clk", "dp_aud_clk",
 				      "dp_vtc_pixel_clk_in";
 			power-domains = <&zynqmp_firmware PD_DP>;
-- 
2.36.1

