Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43873C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 14:37:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 462D387069;
	Tue, 31 Oct 2023 15:37:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f7bBPCuh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B05B086F46; Tue, 31 Oct 2023 15:37:28 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3C3387B5A
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 15:37:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwD+sITz1YYh7JUX6Vllp3HhR/qST4UEPoEbxcFRsIxSkft1e0Nw9fSR7Wv83f86QnmnMaRbbHtkVXC+8VagqLRBFp04SD9TpjdX1T2jTcEWJVm4NaDhadTpyvfgX8zPdzjooxw/Fep2rR8ru2I8PzpK3H1Sv+oZKv5tQrHIMCRm0aA561zqtcNJ04Rmmfc2ltN7uFcarI10CJIat3N5V9fTWHwJN0lRsmBUcXes7ZucfCM2e/nKP78X+BHxbDm7uotYR2zhwuod7triV67QYNVrqHHrzyDMp8yO/c7IQPUliNUU4tn34JtnR3gFekwVrQkw6CNXxlZyBwfnTCFxBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIHBgTnWkxCJ6FJSJ2D6M6xAFnlu59jyRdOh4g72Ba0=;
 b=Yo9CbimqCRtbsFC/aZa/OckvfcoqnfeveUOqzOQKOQOxIFauiegXUtI08te2NPRh3FOkKl6y1r+2a8tm0XYiKSs4Xw2KMmIjKOhV9K3WQ+NZPucY+oBqwhgDxMD1R6Rhvppi/hb3ZicNlPpzzCTtp8RsnF81kUoMEQkU34w3OGz5lL8uybFJlYJni0ljxAyUYLBlsgEMtR4ZwVdBe1wHnHhzvw63SA8wQqkfq1glHmJZk/T/4652PIlZ73OVJbUXRuCnGF88yxTyRIzvDJ/fGr5FtyO3E+gY7RaK6Ez3hIAarBETJCYD5yQCbz3xnhpvnxJhcFNunPVaywaB369Riw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIHBgTnWkxCJ6FJSJ2D6M6xAFnlu59jyRdOh4g72Ba0=;
 b=f7bBPCuh4JowBGjIcsHvUFAWBStWIbhZg0vMoiz8Qz9P0LQsWRI3oqg0tNoQhuopTWPuVCQm27Vr/G7AbwDLwH8WnlOg7x/6trQyaP40Qn7SXPX/hf+RPGXS1e+VYw+k7t78GLWXXYbcUX4k4mbw8N0Wi97/oNdkKMnanhtIPns=
Received: from CYZPR05CA0027.namprd05.prod.outlook.com (2603:10b6:930:a3::10)
 by DM6PR12MB4434.namprd12.prod.outlook.com (2603:10b6:5:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 14:37:20 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:a3:cafe::8f) by CYZPR05CA0027.outlook.office365.com
 (2603:10b6:930:a3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17 via Frontend
 Transport; Tue, 31 Oct 2023 14:37:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Tue, 31 Oct 2023 14:37:20 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 31 Oct
 2023 09:37:18 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Piyush Mehta
 <piyush.mehta@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Robert Hancock <robert.hancock@calian.com>, Simon Glass <sjg@chromium.org>,
 Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH] arm64: zynqmp: Comment all smmu entries
Date: Tue, 31 Oct 2023 15:37:16 +0100
Message-ID: <705874a0f91ebdec936968890df5a51685f2ced5.1698763020.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8823; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=QBG+CgBg6iV4XmFTvNXYZnz/4RjvQ/vffoKW6Tq3dc0=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlRHQd67x/Y+uPPgyQadTec/rVjbwHFpTvS19qqsvOZ5Y
 kd2c7Ke7YhlYRBkYpAVU2SRtrlyZm/ljCnCFw/LwcxhZQIZwsDFKQAT+e7MMD+GRZzrkPpLtem/
 WTLdGrZ4HNPWUWKY7+W4NMXykpo/Q+6dn2V/d7Ty8lu3AwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|DM6PR12MB4434:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a20bfc7-e27f-4e2e-7fd1-08dbda1ee38b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i0ydtxBYmrtLSXNagSKoQt5l7gmzsgjAuSHNs++Sf+90IrpEt4G6I8zbeIAiHj/eIi9yX1CLWjZPpzb3RSGBaiTPdDDVXzYtjGXvYnlwdW3QPgVWvF6B2I0n2SgK+azqT4OK7UBmX/TkVMIynS2hZnEn3yQnbGsU9/k4zza9EcTFXVKK+Ffxyx0zLXRjtsCK7KLLJz2IW8NzWIlWsbjQsdyekp5Hduv3H4CJ1ATEngS9uvqRdVMaCzwfMlr+8XzKxjLU/Qn55NapvucgMifTuTOchURYCY7Y8U5ZJy2cHY+vpd1uZ30WKTP01/xEEe4LptSBfxuPKUGGk6upWkfDw2rH2PhvbFCqYcIPbr5OBLQSf5t0HCM+omT8fpQZAZ/4RQRnMNAcUb9tIv6w9giGX9uLimp15+lQJhcA9eiGl5rZwIr4E00AAOUYrYT45BBgW8clR5qNkrlHSpObGoHUTSVRFeY/x0TR1RFgWr27VC54FHNb5aWRdjKsHFyCTMCRm42TH4A5YLDx9hdKYQlaOdy6ChQpjUMN5A4cEmqKKhLcg6Oz5EZFv9mr92fpCIeGCsPxAq1qQcj3eLg2n9/I8MDSBZAss59EGyYnzJMg7N4DpenynrdIDtIkrmPB7ie4MMvnjHHE3h61HmUBY6dOP/YHIwMbZYmbtMNDs9+U9oupFs6aK1f7w4AtcaGS/Mbw5iJmMWdu2AhdIpZMO7xl//8reLaqv4lP44f6y4h7xQ49p0TfSDI+l4wI6TsnPpHLaiTR4ech2KL01sAQOEG4Cg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(82310400011)(64100799003)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(16526019)(26005)(40460700003)(36756003)(86362001)(40480700001)(356005)(81166007)(82740400003)(426003)(336012)(83380400001)(2906002)(478600001)(36860700001)(47076005)(44832011)(8936002)(8676002)(2616005)(316002)(4326008)(54906003)(5660300002)(41300700001)(110136005)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 14:37:20.3563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a20bfc7-e27f-4e2e-7fd1-08dbda1ee38b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434
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

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp.dtsi | 58 ++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index 2253e773d386..dddcda91cf28 100644
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
@@ -1057,6 +1056,7 @@
 			reg-names = "dp", "blend", "av_buf", "aud";
 			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-parent = <&gic>;
+			/* iommus = <&smmu 0xce3>; */
 			clock-names = "dp_apb_clk", "dp_aud_clk",
 				      "dp_vtc_pixel_clk_in";
 			power-domains = <&zynqmp_firmware PD_DP>;
-- 
2.36.1

