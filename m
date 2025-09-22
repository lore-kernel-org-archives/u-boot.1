Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06087CAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 08:28:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4786983390;
	Mon, 22 Sep 2025 10:28:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AK/34BfI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62C4C833E8; Mon, 22 Sep 2025 10:28:33 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 888A083211
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 10:28:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGrpjuQHQbF/eEFb+uLBNEUp2DA+TFIzqi3yUZzyxnizQFY2yjzUx3e4tfdUNyIo42myLWBdqvs2/pkbx7jRyahSUJbw1C7RwS5X2T852815hfVT+1+wdmx3Wcne6ss/qM8H1U+XL0d9aTSPADdonYCTiFcaGJU4xxAEs3QWGa1EdXmP+aV4WKjL41zbkTXNdfHAMB1FTnnET22lVzy14wgHQEyUAgWxlOC6r3iV9N0J/YGW7/Mr/A9C1ol/dIH9f2Zlv0wkhmZhdmymAXJtiu7vjwV3PgmKXt7kyj69QD2PI0VyMP1QOmydtoP4O6cG9ZzdPX0tvLAtIVxXrunn8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8cSDDqBhO09723+7XaFF17umVthIl93aDdfUvfy2WE=;
 b=tdMu7YwqBUWeo1WQSp7Bgef1cw0U4MvvwPC39wY3JkTsgDRkh61hi+tvbCYVtn4f+XY4D1i3iJEbOX/Ee701FwoEPcXrTmrgLXm4+1jhMqtUBvIqSEGv2QTwp4NTFugJWYbLvmwHcMKD8/7uDPlrY0/HLNXngCBQvjCcygJuW7eQ+qR8X0F6R5uwcYP2dyq+TZPLi9SgRKNU666toGdVsAvJctyviKhqNvu5jgekeZuDQ0n1lF/ApkaDmiokDyZ40opFDuLkogTZcWKcRwW9hLrB2G8FlNZUCDvPoCw05n0CUef4x/C7FivR0fiWLfhy8va4lOzA1P0kPhssre01KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8cSDDqBhO09723+7XaFF17umVthIl93aDdfUvfy2WE=;
 b=AK/34BfIhwAdq6JtYdclj8vEKdY+muBgl4Os/nXadB1fxHFzVnqi0D2VXuG1+1Bev05Ciij6PT1S2jn0mwaV8Gh7xHc6+d6nYBgHqqnojiaDrZ+cH8oco+x62cb717hIwudfFqYs/A6GsrWG7BHkMGDjvqWWx9ROluUK54/2Jow=
Received: from BYAPR01CA0012.prod.exchangelabs.com (2603:10b6:a02:80::25) by
 DS0PR12MB8041.namprd12.prod.outlook.com (2603:10b6:8:147::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.19; Mon, 22 Sep 2025 08:28:25 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::8e) by BYAPR01CA0012.outlook.office365.com
 (2603:10b6:a02:80::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Mon,
 22 Sep 2025 08:29:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 08:28:25 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 22 Sep
 2025 01:28:23 -0700
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 22 Sep 2025 01:28:23 -0700
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Nithish Kumar Naroju <nithishkumar.naroju@amd.com>, Rohit Visavalia
 <rohit.visavalia@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh Yadav
 Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH] arm64: zynqmp: Fix DTOVL warning about graphs in kv/kr260
Date: Mon, 22 Sep 2025 10:28:15 +0200
Message-ID: <576630cc9696e21bef15bd1f0ca35e396adc4eca.1758529693.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3802; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=lj4eLEmiX+el/3HOltQAbvdpo0j8yOB4SKSqaRzn7wA=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRc5FjAeL8vnLn38JUl0a8OZ7a9qGpsCXhXmPDGjOWF5
 uc/B36c7ihlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJrBBh+GfXLel6yeOnx6Ie
 yxWaekvnfolWz3O7nNN+Lee9yKL+z9sZGVZziCzkOXzGunLWrQ29pbOmc71YP7NKIrpT54Nc+vW
 5YlwA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|DS0PR12MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b6e12a-c356-492c-a67f-08ddf9b1fff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yvR8dVYVo32HHwCVZXHVJu5wKz0v15tmrZGM/uwF0o2viI1M9R7Y3NOw5x2X?=
 =?us-ascii?Q?sflpNfubnBH4lX2r5pWRsaMzX0T4MjT3QL/wIxbxX+Dtmb8xfV+U1y+EISPa?=
 =?us-ascii?Q?CO4nhrknFujyJ0f2rfZPLHHlJJ5vX7UKXfBgHWe6SLNSS/HKVdK5Z6yD5pMC?=
 =?us-ascii?Q?UaqMBxeStHm4KZEbqjf46AtYAlkpNUcGaweA9MGjDtrCudMHgwYlshAx3WSs?=
 =?us-ascii?Q?/Qs5UwttKMlOo5ALvDAq1TAm8Ix9w3hLBuzfUZwCZCGrMt2cb3IEEBChjFFA?=
 =?us-ascii?Q?b8gwypZwEBdw6pDsGGa/z4PzCkt3/jqilc5KuZ84Yhc4hDIV4G9HRXn3FOdW?=
 =?us-ascii?Q?iAsBwtkUKHbx197osEy99dpSldrgd1SjC6J+7Jea6wmCSmYrDxse4po0rOTw?=
 =?us-ascii?Q?uH3vsuZ/+HqDXW7ncBVENm3xhUHo7BMNx2pTkH3ew7wMzDw+hTbLtgFSc+Tc?=
 =?us-ascii?Q?xURxNWk4UUA4ZLGYeFAXITMWxaZYe0wlKWtyhw2UAAWbZPCl0n2Qs2IDACAE?=
 =?us-ascii?Q?8DeCMfo7Vbn+XPwogZeZYxLvltm/w70+QRet9MR2CBkyiRmyvsaG5R8qAzZ+?=
 =?us-ascii?Q?bOOJeav6agaMw8bAtQJjDz3jM7irsN47ARo0VXFMMKmACQYg5o8y9JYLwd83?=
 =?us-ascii?Q?rVAIpFJyOeOMPY75nvLAK0082gSCuKwHODi5zKMwIXbhmaNuUJ5d3x7AQRIZ?=
 =?us-ascii?Q?YckDYbf582WDy08Y+zwBdvyKzaMH1LFCu+rI/Dxzd1AvxPSD5ssjLZh/Tb2A?=
 =?us-ascii?Q?bjHzH+5/8snllNVvIcuWcoVQ4zE1tonEOiMEhG7CbpNasFHfNCdEBV508p7N?=
 =?us-ascii?Q?JVwo0MTwg9JbKzyZ7+sVZeJ05Z3OuOb1P8blsGBB15pnidETCYgzFvbGKSW3?=
 =?us-ascii?Q?TMJx4Z731brKaKxwu3BlUcj+pofGGSc+qwyt8xmpJV2XPLeZadYX0PaFriAt?=
 =?us-ascii?Q?CAC1ul8KHEg/jQm2Hp5sgu6uFLmJVOfYR+q20Y0XZO29gYi7cZwJSqj1dZNk?=
 =?us-ascii?Q?TbMhwahy0m2IMHNDBF2Zi2eVF+ZuCWj7kFfSMHtLEsab7OzK3kc9MysNmON4?=
 =?us-ascii?Q?ljOaUIv1K5oexjrqgVJ7nD4bIJVkce+8gd4EOdQU6nh87WoqsAAG+rGHfknw?=
 =?us-ascii?Q?TxdGHzOx4drc0HgPNrrCbwm2712bFVYh7bfLI25CKRS1dpHZlWlKogPcyBWN?=
 =?us-ascii?Q?fpKvoRQ6E4JcnVwMdEmWCXHcSRDWOM5CA2nNd+O413mhI8gwwSx6fiTEwiz5?=
 =?us-ascii?Q?Oz614lMoDcYDxLX9TZZ0eEy1x0xC0D+MK+BMke+rYatGlD2BEqCGONUQ7qmL?=
 =?us-ascii?Q?jw7MEEZYEjHF7/SoYZnYLjOgRqZVl/7XQw32NQfjnIGClkFSK/nZ5DICc9JB?=
 =?us-ascii?Q?bbcEhq/M7cYTs67HOtEuSqff+FvND7bASqEIzm2fZLkrfenyeW256RB+uCoc?=
 =?us-ascii?Q?AuNAaJhHc4LaimyZItYuewvumLZhMjf7dy0YFtWvMCDron5jKrX+AZFvLHlJ?=
 =?us-ascii?Q?n2qxfXGRBFYFunjrLVYsnI0TEHgG156HVjA/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 08:28:25.3350 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b6e12a-c356-492c-a67f-08ddf9b1fff0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8041
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

DTC is generating warnings about missing port like:
DTOVL   arch/arm/dts/zynqmp-smk-k24-revA-sck-kv-g-revB.dtb
 arch/arm/dts/zynqmp-sck-kv-g-revA.dtbo: Warning (graph_port):
 /fragment@5/__overlay__: graph port node name should be 'port'
...

That's why change description and add it directly to dpsub mode to contain
full description with also port.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sck-kr-g-revA.dtso | 10 ++++++----
 arch/arm/dts/zynqmp-sck-kr-g-revB.dtso | 10 ++++++----
 arch/arm/dts/zynqmp-sck-kv-g-revA.dtso | 12 +++++++-----
 arch/arm/dts/zynqmp-sck-kv-g-revB.dtso | 12 +++++++-----
 4 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
index b92dcb86e87e..88396d089f43 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
@@ -154,11 +154,13 @@
 	phy-names = "dp-phy0";
 	phys = <&psgtr 1 PHY_TYPE_DP 0 1>;
 	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
-};
 
-&out_dp {
-	dpsub_dp_out: endpoint {
-		remote-endpoint = <&dpcon_in>;
+	ports {
+		out_dp: port@5 {
+			dpsub_dp_out: endpoint {
+				remote-endpoint = <&dpcon_in>;
+			};
+		};
 	};
 };
 
diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
index 99ad220d13d6..e041a962d89e 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
@@ -155,11 +155,13 @@
 	phy-names = "dp-phy0";
 	phys = <&psgtr 1 PHY_TYPE_DP 0 1>;
 	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
-};
 
-&out_dp {
-	dpsub_dp_out: endpoint {
-		remote-endpoint = <&dpcon_in>;
+	ports {
+		out_dp: port@5 {
+			dpsub_dp_out: endpoint {
+				remote-endpoint = <&dpcon_in>;
+			};
+		};
 	};
 };
 
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
index d7351a17d3e8..fbbebbea80cb 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
@@ -3,7 +3,7 @@
  * dts file for KV260 revA Carrier Card
  *
  * (C) Copyright 2020 - 2022, Xilinx, Inc.
- * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
+ * (C) Copyright 2022 - 2025, Advanced Micro Devices, Inc.
  *
  * SD level shifter:
  * "A" - A01 board un-modified (NXP)
@@ -131,11 +131,13 @@
 	phy-names = "dp-phy0", "dp-phy1";
 	phys = <&psgtr 1 PHY_TYPE_DP 0 0>, <&psgtr 0 PHY_TYPE_DP 1 0>;
 	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
-};
 
-&out_dp {
-	dpsub_dp_out: endpoint {
-		remote-endpoint = <&dpcon_in>;
+	ports {
+		out_dp: port@5 {
+			dpsub_dp_out: endpoint {
+				remote-endpoint = <&dpcon_in>;
+			};
+		};
 	};
 };
 
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
index a4ae37ebaccf..87f94f8ef9d8 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
@@ -3,7 +3,7 @@
  * dts file for KV260 revA Carrier Card
  *
  * (C) Copyright 2020 - 2022, Xilinx, Inc.
- * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
+ * (C) Copyright 2022 - 2025, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -116,11 +116,13 @@
 	phy-names = "dp-phy0", "dp-phy1";
 	phys = <&psgtr 1 PHY_TYPE_DP 0 0>, <&psgtr 0 PHY_TYPE_DP 1 0>;
 	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
-};
 
-&out_dp {
-	dpsub_dp_out: endpoint {
-		remote-endpoint = <&dpcon_in>;
+	ports {
+		out_dp: port@5 {
+			dpsub_dp_out: endpoint {
+				remote-endpoint = <&dpcon_in>;
+			};
+		};
 	};
 };
 
-- 
2.43.0

base-commit: 221ab6313667165276ec87aad0fac3d58a91dd21
branch: test
