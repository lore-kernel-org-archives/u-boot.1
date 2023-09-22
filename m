Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F576CD4F49
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 10:37:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 233CC86B64;
	Fri, 22 Sep 2023 12:36:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DO80XEuN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01A4386B3B; Fri, 22 Sep 2023 12:36:51 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6F3586B08
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 12:36:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7UCn+uU/tZ4Y7cLWii7SowRd5j4h0kM5KUk0MYTDidIyGFES1GS2t0R8JwVmJall4uVs3XIaohNr8frWwI1E1f4nkfga3d/5cisTxBZOWf3DpOYdlG5Pjz7aLKiRPAnMfsI2+pz7FpNkRNvmG0oP2yfIjDshieK5z/iYBBQUGwWe/2sVcWEdBT6SpQZ9E/oCBgTb+/dO0sSmaG9TCPSKfNDTogqG8UBNvb5TRqoEbd83KakwLOs1q07w42BnXidLlK2TWcAsBAEqhPeHI1oys1BmRmd/ioj8OeZmNkk2mEW/rwdSLy4UOOr1zER7w5aoMuRxLUzbZwikGtnSiCASg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyL8qdXczMlsS1DeWuyhGLzodu1Up9c6wcScsIsKs7s=;
 b=jzNx7dHoCpgcGObLoBDlxmJaokib77MFaRcU+iiUIpRh9QW2WaKnfD+gqCV1cbpHoFekk7vs+o5RBT+gRPFfeYVAeROVTCCMB/Ik1RoYWFTxy67hSMGwZGd5zRNrbYx73ZokToaAXb0Kp0U/VI1cie9vaIu27NcNfNNc51EYQ446ExsYNt5LCN9CG1cgoSBPCzymyljuHi7JcT/YcUkV8AI0q3x5M/hd7xQF45hokOV2xU3pJOwEkQnu8PwdZbikDJHwzehbgp1txRwX7spubzwZQHi0TgfiqvGJSKVyc7Af17mTRb7a0dZBlXA7v7eaigeUxBycpbqb3aLQU0+2zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyL8qdXczMlsS1DeWuyhGLzodu1Up9c6wcScsIsKs7s=;
 b=DO80XEuNZqGlVFiucNRDSXRVFecvLR1Dw1izAJhMxRiylCD8vy3140PJ1DLwKm6enBb+LEjJ0w0etWfGsP36LtseNJ9w8M/QTEi5jwZdsV/qurms1D2t1OGy6h+w97ax0CmW4J4yH6aUtXXtQvR2VGms2yPrSOY3frXxBgyMtY8=
Received: from DM6PR08CA0049.namprd08.prod.outlook.com (2603:10b6:5:1e0::23)
 by BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 10:36:44 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:1e0:cafe::e5) by DM6PR08CA0049.outlook.office365.com
 (2603:10b6:5:1e0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.32 via Frontend
 Transport; Fri, 22 Sep 2023 10:36:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 10:36:44 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 05:36:43 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>, Robert Hancock <robert.hancock@calian.com>, 
 Simon Glass <sjg@chromium.org>, Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH 08/14] arm64: xilinx: Remove address/size-cells from gem nodes
Date: Fri, 22 Sep 2023 12:35:37 +0200
Message-ID: <02f308c774d4f2a798a9a8c066824114a19841a7.1695378830.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1695378830.git.michal.simek@amd.com>
References: <cover.1695378830.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2176; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=eqmNQyyl+lR4jRDgyMdpkCP050irUQ5ZPZyEPNDxndI=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlTe3Gm1ZVt2yxx/7rDvfO55sVer1t6ew14h/CEqLnRSt
 Jy0f9DRjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCRPTcZ5geqCqoeiZ5px9HT
 2730+aPjbfJBpgzzLMyUQnjcEiYkJFwwcpzRt+6OeXMTAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|BL1PR12MB5063:EE_
X-MS-Office365-Filtering-Correlation-Id: f6112a98-bfb3-4307-97a6-08dbbb57d115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 68Gpnp0uCwScaGGiKgmHbsm7BLwhNpaR0iCxkfmu7GCqgBpsrEYJbJPztx/z6gPe3kCWkQLbMZylOi0oWnxakYhIaQf9Z+QzbDRCv7cPVdBhf0fIckg/8MxB3TvZc/4rnOwcWm/0owm/VUnGGEQtw0B3HYepOnTHWZpX3DrzirY777/fFzY9ihK7iVo6oPuqtAozQakOodZ/q+3o/NLwzdhEhGPCitpkm+DmaDeaBJmXEG6QVnBvhBLQ0SK5fv3HFqLQUUI7Hk7shMGl4wClCGegbbbVTdHJO9FXm20Q+AN2oPub1Wlbfck/HYVSUDIQ0JXmr2ihxTt1R+yX80fbEjlBpDxOjzg+vSk/AbHyfZZMoIyRZjsCjZwg/WGFwtNzmx32QX1UgMKgYmgT2ezjtPnKVT+/a4GqhwlFsDOpq/sofQuUoy0HbGsrLkUMM75iny2UdbxJv0ACtBxH2QDm02rRuqVz1kGL1om0QtRWyGUfsLwmnTTIhba1z/T0i0GGIeTOMDXZAA9Pfe/USYCxPnqO/k3d8CfqylhYHNvE62LgP+Rt5vrfWuyKpy6kLHZPjOwazUhwYCjX+5gcNfH4InTg1SS8e2VMHC0o/AKiWxUgm1UlGqOEP62g6ZUKVW7Z9tpMAPQtdFFuA+5YtMKvy68TIAyYp9eKK+O4ZcpBWr8XhYpuTyDc7uzhubyF24qWQDoFhu+mX9tz7960VqrrXRnXTjbMa1OEE7fMX1PguqeK32PunKueAvj1YHGpCmdwuqauOd/dJspyfda12cRgQh7YuJZa5bcUv7euJiDlWIUCgfjGknjIt5BUXGUz9sUN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(186009)(451199024)(82310400011)(1800799009)(230921699003)(46966006)(40470700004)(36840700001)(40460700003)(6666004)(82740400003)(26005)(336012)(426003)(16526019)(70586007)(70206006)(110136005)(2616005)(86362001)(478600001)(47076005)(36860700001)(81166007)(83380400001)(356005)(36756003)(4326008)(8676002)(2906002)(8936002)(44832011)(316002)(54906003)(5660300002)(41300700001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 10:36:44.6365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6112a98-bfb3-4307-97a6-08dbbb57d115
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5063
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

Some boards are using one mdio bus which holds multiple phys and also
boards are using mdio node for bus description. That's why there are cases
where address/size-cells are unnecessary which is also reported by make W=1
dtbs. That's why remove them from zynqmp.dtsi and let board DTSes to handle
it based on used description.

Error log:
/axi/ethernet@ff0e0000: unnecessary #address-cells/#size-cells without
"ranges" or child "reg" property

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index 5c67c6f602f2..20a954e69db0 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -603,8 +603,6 @@
 				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff0b0000 0x0 0x1000>;
 			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			iommus = <&smmu 0x874>;
 			power-domains = <&zynqmp_firmware PD_ETH_0>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_GEM0>;
@@ -619,8 +617,6 @@
 				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff0c0000 0x0 0x1000>;
 			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			iommus = <&smmu 0x875>;
 			power-domains = <&zynqmp_firmware PD_ETH_1>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_GEM1>;
@@ -635,8 +631,6 @@
 				     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff0d0000 0x0 0x1000>;
 			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			iommus = <&smmu 0x876>;
 			power-domains = <&zynqmp_firmware PD_ETH_2>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_GEM2>;
@@ -651,8 +645,6 @@
 				     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff0e0000 0x0 0x1000>;
 			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			iommus = <&smmu 0x877>;
 			power-domains = <&zynqmp_firmware PD_ETH_3>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_GEM3>;
-- 
2.36.1

