Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7631BD69114
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 14:49:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC794891F5;
	Thu, 28 Nov 2024 15:49:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wCHctTF/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4884B891F5; Thu, 28 Nov 2024 15:49:35 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::61d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BB9388F28
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 15:49:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRtUzcBtRSx6dzunRtUfDqkzVwY0+x9k/eJwZUE79Up6+tdzmLdiSOM776oMV1XDbuB/PBuSzps3W/O02hIVcFUVJlLNxOiyCT7W6KlECmGbRM92DCNDwMNrS3NC4Dw1F8IJnpevmvPrmjSTh6BnSsrjhVuKBgQ1oy4IB5k8Rkv8pwZ7Q9s9cXQWjv1oDi0t7O51o3PGilONPshSAG0W2doH/1rCTYF5Yr7PKzETtQNUENTcVw+Z/TEvSmh9mKDp46uc7+c0JCkd5lZeR5UH6Y+31Y5mE2lOviAwJz5k3LCzeY8NCvyCEHngr64cNPMekVaNQ+5DrEO9u6Sxx0JTEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSgEXlAMOdIWHA+bjxdOzdaH55zZ4EHcd4zvINDVJ3A=;
 b=kLfwzqGSt/wfoPfRC4J2Y5D/IPMdLQ4Aj0n8nJNdRoRA9BUTZcAwobl7XW84ITCBaO+OOowH0HQbPWtd+5j5N5FCTqVAgVcSqsDSSGATzmidMDo9sUv80WfvTQmOThYB81zswi6razSAAAQXPA2O6S7/5iD/A+Fuz/bT1ec+iDR7XDg8XMspmkvnTGCmJmGJKoKNZjggI6KpCreJ/iJ/SKxanRCtjjIV1Q7U5Z3il40WV4cYd7fmhOOC9WV3LlwnSQ1tlKftQqmAADrFq9dGGTvkvs87on1kVC3bxSQuVTAhahCDE300UdWhORQWOlHIbD/a22UK98W1wNyZ5J3pJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSgEXlAMOdIWHA+bjxdOzdaH55zZ4EHcd4zvINDVJ3A=;
 b=wCHctTF/IsXKFYeLSxMn6yok74Hkz0V7Sz8YgNgjJPcxPyzNrgpf1Z+6RwUxq+gel+DFESa3WEFMU0knGzvDKdGQ9vux+q9bEB4VYiRj72p1lgS1JxNf63dNIgjP3/TYxdCbQjSGLaP35s7t15PFBDwVKppoTtqdxiUfSBcfkmk=
Received: from BN9PR03CA0191.namprd03.prod.outlook.com (2603:10b6:408:f9::16)
 by LV8PR12MB9082.namprd12.prod.outlook.com (2603:10b6:408:180::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Thu, 28 Nov
 2024 14:49:26 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::b9) by BN9PR03CA0191.outlook.office365.com
 (2603:10b6:408:f9::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.13 via Frontend Transport; Thu,
 28 Nov 2024 14:49:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Thu, 28 Nov 2024 14:49:26 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Nov
 2024 08:49:23 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Lukas Funke
 <lukas.funke@weidmueller.com>, Manikanta Guntupalli
 <manikanta.guntupalli@amd.com>, Paul Alvin <alvin.paulp@amd.com>, "Srinivas
 Goud" <srinivas.goud@amd.com>, Tanmay Shah <tanmay.shah@amd.com>, Tom Rini
 <trini@konsulko.com>, Vishal Patel <vishal.patel@amd.com>
Subject: [PATCH] arm64: zynqmp: Sync with v6.12 kernel
Date: Thu, 28 Nov 2024 15:49:14 +0100
Message-ID: <cf37760117765c4cece94736dc2a7b583d5987de.1732805351.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5995; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Vm8TEcPhz4RnXZ6rnhnZfC9+tQyElOctQznfNtMbT50=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhnSPptehVizzr0/Y2brbbbJW/kaf4icXOuMMzh+LeTe5I
 W3dk+O7O2JZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBErtxmmKcXtP//AoW9v0v/
 axncy+f2P3BNWIhhflD/9k1OF/q1S7sWfVbuuKfytH3GKQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|LV8PR12MB9082:EE_
X-MS-Office365-Filtering-Correlation-Id: 414e37ce-cfe5-4ad9-41c9-08dd0fbbdb17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CKXNAUfpVU9VG4alXTj+Wpo7Vr5uzZR/g4cmP3+8I66CFaZ7kIMVIk8ww2zq?=
 =?us-ascii?Q?r7GzuaVNIu6RupF4fHOd7urZri4mA25DhqgoeiXdYIhqg+RDFxsQVGO9g0Pn?=
 =?us-ascii?Q?/e16n+Q+BYORIMWmkZzPK0sjVBe/MGaa6uwcihNqR87rx9Cbh2TXX9eALcZ0?=
 =?us-ascii?Q?ZwlHC1irjn0/wPC9MAEK0iF2PvehHA3HuTqJ8N7js8kgQyZ9+eHXiqWH8WFP?=
 =?us-ascii?Q?44PlKdrA1kLBN8JK9tlb4EBvc/3FyW1icBkeag0E9+40YxrP+EfePhcPdkhN?=
 =?us-ascii?Q?d93MqXl1l+wkPjxkjTPzQRMTMKcHRppkD+rWQ3tLwwLxlbuwbNvTW4jiEHci?=
 =?us-ascii?Q?Su8qh+vSGci3rT7YMD6G0svvBed0KeTa/FHh+12VyhGuD0x6IypNyJq8iPOt?=
 =?us-ascii?Q?52g1smZsRfDJ+KEDMMzNoLEZKEj89Fq/ZGqRlUT+K2sverBC1zuJ2zI/thy+?=
 =?us-ascii?Q?S3gc3HhL8HRsW7trGFcCZFU80p5FR0uQyFJXYK8P9xOXsr3NbWgxbvR+umXp?=
 =?us-ascii?Q?RBC7e0qq67ZCwqRCFaBvw8gekweexQgfnPnhkCHgqnwdvwL+i/+d52Ln/Yuf?=
 =?us-ascii?Q?TwG2KPd4qLfRId3WHuPo8OEEULFHQs7P9ZhejGQPlSDvphNJWu85wMFGK/CG?=
 =?us-ascii?Q?p9qzvPHj660p4v5f2+VtjcBYA1rxjaAAKPMiFQ/WmLBSvPWHDuo+T/iUqr+3?=
 =?us-ascii?Q?Rv/zCsdvf++LMyzzAk9fNqM+sNJGJlVEVi2XE2n/gIgXKgBOvkquDMBvZgN6?=
 =?us-ascii?Q?gh+ifvr8xKtLFQVH7IrhLWcYBU07Sym0MdqxYzN/0HnaG3hV8he39K9uVOvx?=
 =?us-ascii?Q?g8QAHSDsNMGX9JMvCwOS7m43crHWPedly0o4zRh3gqTssxXgaR6vi/vR8eX5?=
 =?us-ascii?Q?uJz6zIvs2r8r9OMRUj+RAxjkbp8q7wy2qoMsTBCl8eTfJukq94U2gK8H2YiN?=
 =?us-ascii?Q?iAvDw6svx5KMK+H4bHMXAdyC13kDE9CKCFDCxXotWle+9upA7nhZsEkHwcCb?=
 =?us-ascii?Q?o7JKtbg5sXkfFA/xhcWO0ZjvMyfPHJhbGUnEsFEG5HDsH9tMDt47bD/byLqv?=
 =?us-ascii?Q?Hi4XXIiLoAMG418JEb70wNLBEwamTaWuNdhr9EVw9D7WB4Wg4o306gVfol+l?=
 =?us-ascii?Q?MBNZ4b683hd9i/qloVx4x6sJFNzhm6Y6Yl5TEEsC/7N5NHE/IZfNxnSzbseD?=
 =?us-ascii?Q?6nFDleJF+c3YfqshkxoPQhbCh+LmT/UOrlaFm/2blDlULwzFFN4MDMT23fPJ?=
 =?us-ascii?Q?u60HyS+XZTsL5WR1eE+Zfhsv58Zn+QEbxECrvHzbxq9iZ8Q2QfCpXJ1/bXR4?=
 =?us-ascii?Q?y4ms2fqlieJM7oGvbb9fIGMSTprgc+fqX1Xpexu07b3F327P8eR8TR0U3Ya4?=
 =?us-ascii?Q?ibcx9/g7HddAvfYYRChFKWjNhCPqg2Ph9+wMuR3bnzboy+W1/bPtrZJ7tV0X?=
 =?us-ascii?Q?pB6H5BhchKyskdvvusPet/ws+lvk/GCD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 14:49:26.4732 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 414e37ce-cfe5-4ad9-41c9-08dd0fbbdb17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9082
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

Sync zynqmp* DTS files with v6.12 Linux kernel.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Hope that we get soon to be able to enable OF_UPSTREAM instead.
---
 arch/arm/dts/zynqmp-clk-ccf.dtsi     | 16 ++++++++++
 arch/arm/dts/zynqmp-sm-k26-revA.dts  |  2 +-
 arch/arm/dts/zynqmp-smk-k26-revA.dts |  2 +-
 arch/arm/dts/zynqmp-zcu102-revA.dts  |  1 +
 arch/arm/dts/zynqmp-zcu1275-revA.dts |  3 +-
 arch/arm/dts/zynqmp.dtsi             | 44 +++++++++++++++++++++++-----
 6 files changed, 57 insertions(+), 11 deletions(-)

diff --git a/arch/arm/dts/zynqmp-clk-ccf.dtsi b/arch/arm/dts/zynqmp-clk-ccf.dtsi
index dd4569e7bd95..60d1b1acf9a0 100644
--- a/arch/arm/dts/zynqmp-clk-ccf.dtsi
+++ b/arch/arm/dts/zynqmp-clk-ccf.dtsi
@@ -70,6 +70,22 @@
 	clocks = <&zynqmp_clk ACPU>;
 };
 
+&cpu0_debug {
+	clocks = <&zynqmp_clk DBF_FPD>;
+};
+
+&cpu1_debug {
+	clocks = <&zynqmp_clk DBF_FPD>;
+};
+
+&cpu2_debug {
+	clocks = <&zynqmp_clk DBF_FPD>;
+};
+
+&cpu3_debug {
+	clocks = <&zynqmp_clk DBF_FPD>;
+};
+
 &fpd_dma_chan1 {
 	clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
 };
diff --git a/arch/arm/dts/zynqmp-sm-k26-revA.dts b/arch/arm/dts/zynqmp-sm-k26-revA.dts
index 8c43ade94053..620f5185cc46 100644
--- a/arch/arm/dts/zynqmp-sm-k26-revA.dts
+++ b/arch/arm/dts/zynqmp-sm-k26-revA.dts
@@ -3,7 +3,7 @@
  * dts file for Xilinx ZynqMP SM-K26 rev2/1/B/A
  *
  * (C) Copyright 2020 - 2021, Xilinx, Inc.
- * (C) Copyright 2023, Advanced Micro Devices, Inc.
+ * (C) Copyright 2023 - 2024, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
diff --git a/arch/arm/dts/zynqmp-smk-k26-revA.dts b/arch/arm/dts/zynqmp-smk-k26-revA.dts
index 719a4e49b574..b804abe89d1d 100644
--- a/arch/arm/dts/zynqmp-smk-k26-revA.dts
+++ b/arch/arm/dts/zynqmp-smk-k26-revA.dts
@@ -3,7 +3,7 @@
  * dts file for Xilinx ZynqMP SMK-K26 rev2/1/B/A
  *
  * (C) Copyright 2020 - 2021, Xilinx, Inc.
- * (C) Copyright 2023, Advanced Micro Devices, Inc.
+ * (C) Copyright 2023 - 2024, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
diff --git a/arch/arm/dts/zynqmp-zcu102-revA.dts b/arch/arm/dts/zynqmp-zcu102-revA.dts
index 3132fa533b8e..dd63d22f45e7 100644
--- a/arch/arm/dts/zynqmp-zcu102-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu102-revA.dts
@@ -960,6 +960,7 @@
 
 &pcie {
 	status = "okay";
+	phys = <&psgtr 0 PHY_TYPE_PCIE 0 0>;
 };
 
 &psgtr {
diff --git a/arch/arm/dts/zynqmp-zcu1275-revA.dts b/arch/arm/dts/zynqmp-zcu1275-revA.dts
index 095c972f1322..b75b2a796eb3 100644
--- a/arch/arm/dts/zynqmp-zcu1275-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu1275-revA.dts
@@ -15,8 +15,7 @@
 
 / {
 	model = "ZynqMP ZCU1275 RevA";
-	compatible = "xlnx,zynqmp-zcu1275-revA", "xlnx,zynqmp-zcu1275",
-		     "xlnx,zynqmp";
+	compatible = "xlnx,zynqmp-zcu1275-revA", "xlnx,zynqmp-zcu1275", "xlnx,zynqmp";
 
 	aliases {
 		serial0 = &uart0;
diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index 6a29f6101534..70ca5e6379fc 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -168,8 +168,8 @@
 		bootph-all;
 	};
 
-	pmu: pmu {
-		compatible = "arm,armv8-pmuv3";
+	pmu {
+		compatible = "arm,cortex-a53-pmu";
 		interrupt-parent = <&gic>;
 		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
@@ -441,6 +441,34 @@
 			};
 		};
 
+		cpu0_debug: debug@fec10000 {
+			compatible = "arm,coresight-cpu-debug", "arm,primecell";
+			reg = <0x0 0xfec10000 0x0 0x1000>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu0>;
+		};
+
+		cpu1_debug: debug@fed10000 {
+			compatible = "arm,coresight-cpu-debug", "arm,primecell";
+			reg = <0x0 0xfed10000 0x0 0x1000>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu1>;
+		};
+
+		cpu2_debug: debug@fee10000 {
+			compatible = "arm,coresight-cpu-debug", "arm,primecell";
+			reg = <0x0 0xfee10000 0x0 0x1000>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu2>;
+		};
+
+		cpu3_debug: debug@fef10000 {
+			compatible = "arm,coresight-cpu-debug", "arm,primecell";
+			reg = <0x0 0xfef10000 0x0 0x1000>;
+			clock-names = "apb_pclk";
+			cpu = <&cpu3>;
+		};
+
 		/* GDMA */
 		fpd_dma_chan1: dma-controller@fd500000 {
 			status = "disabled";
@@ -885,7 +913,6 @@
 			power-domains = <&zynqmp_firmware PD_SATA>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_SATA>;
 			/* iommus = <&smmu 0x4c0>, <&smmu 0x4c1>, <&smmu 0x4c2>, <&smmu 0x4c3>; */
-			/* dma-coherent; */
 		};
 
 		sdhci0: mmc@ff160000 {
@@ -1065,9 +1092,9 @@
 					     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+				clock-names = "ref";
 				/* iommus = <&smmu 0x860>; */
 				snps,quirk-frame-length-adjustment = <0x20>;
-				clock-names = "ref";
 				snps,resume-hs-terminations;
 				/* dma-coherent; */
 			};
@@ -1097,9 +1124,9 @@
 					     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+				clock-names = "ref";
 				/* iommus = <&smmu 0x861>; */
 				snps,quirk-frame-length-adjustment = <0x20>;
-				clock-names = "ref";
 				snps,resume-hs-terminations;
 				/* dma-coherent; */
 			};
@@ -1176,11 +1203,14 @@
 				      "dp_vtc_pixel_clk_in";
 			power-domains = <&zynqmp_firmware PD_DP>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_DP>;
-			dma-names = "vid0", "vid1", "vid2", "gfx0";
+			dma-names = "vid0", "vid1", "vid2", "gfx0",
+				    "aud0", "aud1";
 			dmas = <&zynqmp_dpdma ZYNQMP_DPDMA_VIDEO0>,
 			       <&zynqmp_dpdma ZYNQMP_DPDMA_VIDEO1>,
 			       <&zynqmp_dpdma ZYNQMP_DPDMA_VIDEO2>,
-			       <&zynqmp_dpdma ZYNQMP_DPDMA_GRAPHICS>;
+			       <&zynqmp_dpdma ZYNQMP_DPDMA_GRAPHICS>,
+			       <&zynqmp_dpdma ZYNQMP_DPDMA_AUDIO0>,
+			       <&zynqmp_dpdma ZYNQMP_DPDMA_AUDIO1>;
 
 			ports {
 				#address-cells = <1>;
-- 
2.43.0

