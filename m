Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05A2C83F25
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 11:04:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E4BE8382F;
	Tue, 22 Jul 2025 13:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I68St7q4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D32528376C; Tue, 22 Jul 2025 13:04:18 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::609])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C718F8383E
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 13:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHK8vRUulJxBZmsAO+55t1FejnxTp1e/WvGHIHlu8xk9evYoDqDs4dd1wTItX6cmFFbmPoFodGngpgcZuoxF8va4vRIZtOAbPU5CXyd5s9HydRgYvMeaE6iTPjDRcI/cUO4+Qt+slJaEznWmHW/VwXanGS8Y1Y9JhigBlkykDeTbyvLLK7m4IiKmzfpS0d4lsVNNVEYKfl6Kag/8fQmrm/ylyV3oTfqkX3OfQEgmSlXeZeKpUGK0KPOFJ4E24Xg4mMTwpB7nsFaGYRTJOrqnWkIrobqF6CdGKKWE8Ct908a/IrGHPj7hBmiPiIWal+rhvg4iOAm2vFzLYXpEc3/W/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdlTkaehn43oT9vmNw5SVP5Q2XLaJCdNv0Qa/Xr5O3w=;
 b=btze9efvGYmnwY2G9RHtAK7sNTTbhHrNzkAhxqGDifEtPIjn5U8uSAOJM9xi83z79//mj89qUd5aRLEJIOZxGT0tQvPs88nNdVpwuVtQcAuyoldRGtVfj5qYVzEbeReEjj+9knC1l+9C2HbbsdRclMNqsBl3daQnnr750rHob6ESGsikmWm/SmblZblr3FHjNn8oCiogq9MCwZDxR2W4lt723qQI6bHG/UT2tTcUvMbIFbva7Deq1/L9F/Q5cnDMFN1CfSO/9EhFwFHnd8ZC/nOuWIWLiuogY9JuPZYwehXEJGl/hrteFh6vKf0z2n9aGS7nizZ3uorpiwbRJvhxmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdlTkaehn43oT9vmNw5SVP5Q2XLaJCdNv0Qa/Xr5O3w=;
 b=I68St7q4t4IW2P2yIyo62S855Nkf9OxILTWEpQxImlL9OJkGqhhcff3rypnJi78ejXlHhhrlScCaNfbP3s/YDwXbsfr9HdXnNzZINcsvcGlMmNJqgP9+Ja3QNDVy0S28fInmdJIH8VmGsGFUR8KahKx/079Yc+u9XB5bHj2gtsE=
Received: from CH5PR04CA0018.namprd04.prod.outlook.com (2603:10b6:610:1f4::29)
 by CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 11:04:14 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::5a) by CH5PR04CA0018.outlook.office365.com
 (2603:10b6:610:1f4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 11:04:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 11:04:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 06:04:12 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 06:04:10 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 06:04:10 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Leo <ycliang@andestech.com>, Padmarao Begari <padmarao.begari@amd.com>,
 Rick Chen <rick@andestech.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/4] xilinx: mbv: Add missing mmu-type cpu property
Date: Tue, 22 Jul 2025 13:03:44 +0200
Message-ID: <e597b722b033d3c1d4f0d41f5f1644cb150fbb09.1753182218.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1753182218.git.michal.simek@amd.com>
References: <cover.1753182218.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1643; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=kj0n7NcKs+5+e+KgLz6hsSD9o1OmaxI8FzVCRNXmhXk=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTUF4je+DprWlr8pTM1F4+eFHoYZsu+nfN96MHkC6cL/
 YoL1jiEdpSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBEtJ8zMlxf1rDnhWpfyKe+
 55+0rwVxbX3P5vffipOtMJTD6svVDa8Z/lnNKdty9ktIk4OOcubTTwwPZsZPVHTZqPFV6Z/ax1D
 Zg2wA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|CY5PR12MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ee89036-28b3-4a87-fa04-08ddc90f7e7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cNoQcoWN9boX/UlQKqdsZP8Tb5LP7MKHaYustA1HyzzcmpA9t3lTFGNsX1IY?=
 =?us-ascii?Q?G2eRNkMPwBc6jUr/8ycHohU9wcvrCbYo+tSHhtZmsVggyRZ0bMGqFA/saBIw?=
 =?us-ascii?Q?aUKUrnlNOo04UYcSNgPHFcXPGlJ+Lh5P4vFOhxcBw32Uz9r7Js69/ZY6FC9g?=
 =?us-ascii?Q?opevx6WPu6eb7dclj4NTlKfH0PZWZt1efe27EK4Gvd0UnE8itWWUByzUMQq2?=
 =?us-ascii?Q?kX8G2ofXfTk2FGghIOLr7Cy6b1JYU8GQ+fj8AQEt2Z6dPWEpIxqbkK4EtzAM?=
 =?us-ascii?Q?JlUVwHTtsy3Jy7BzhQ9zDsRE6NM2/99SBLGCmYyV08jasG0VIY7rRdLSiUt6?=
 =?us-ascii?Q?gYGO+Q44n9YQrt3BrT9/BCy3uVt/QV8ejHV/q+RZ4r1XP/CsmoYOfmG5DfNc?=
 =?us-ascii?Q?yW9umWeJZA+GtF/gHznrvKWVRPeENEXxTCG6EitZlw0DAvkESESB3/4QNGzg?=
 =?us-ascii?Q?lq9tJCc0mNtWEwocfHc5DpGF3Ml7OQO/7hI0RLC3rcIaFKOa9M/LdLCebLnP?=
 =?us-ascii?Q?XYXyT7xEM2zlciLoRY/FbXOKZ9SeeQmQpSnqHcwiiUnXgQYR/4WsZV1nTs9L?=
 =?us-ascii?Q?r1hVmFcyUFG8MQO/7ugCfo5znEfW8Ke9WE4uIlCIQ9CeRucC/xxZatQG0Xvh?=
 =?us-ascii?Q?nz7ABvFfX+7HbznNZUhs2YLTO8nFAe3SAExtPKyYxMYHDqyrSUZD3NEGud93?=
 =?us-ascii?Q?Yhuc0PkmHYNOHxLsVF1JoJpQ+mBojJ/4OImwflRO69QiLPWBuQRxA0pBciIo?=
 =?us-ascii?Q?mkSOzt2TPQ9QJrogcKQ3EpRSz0JTe+6Qj3VxluinIW99vnVBNX9ZkRbrzI9v?=
 =?us-ascii?Q?zneln/qkhr4GomyxS5aReDS/EqANmBf3lohYruYwHsFUypagma+/YG2h3xzz?=
 =?us-ascii?Q?5mQMEtv6qVwJRqeIx9tdyfzkHIfAlu1LmbaXZ6k9GPl4YCp44r5n/txe8n8T?=
 =?us-ascii?Q?q0iqiiqOUOiOmWLWhI2bYRQtAevpaEHaPGbvW1ijwm9gr0qD43S3lzWT9omN?=
 =?us-ascii?Q?wKedwV/f1jdpttHF4/ycMK0KkK2ut9uM3i//0wqWBxQhXB9L279ihDxcMz95?=
 =?us-ascii?Q?SLTbIAFLuIONMTYLYudGBWEZMi2grwMiaJ3FP+4zsxKSLC0kC0GKg6G//Ff6?=
 =?us-ascii?Q?0TGAHCEud3kyVBc3ELkYdO0w1M6jjFVSSH5Hx0bGOKHy2ChNAhvZveeTMz5J?=
 =?us-ascii?Q?J0UAPNxt2dgeH3nQOoWg4TW9EfXY+7e+K6hsduVJvo3kY7rPINpK9wDsaQSE?=
 =?us-ascii?Q?5ti2T+ui4Vxz/1/bYSaRepQtKm/KdI4Fy0B3bRhKSSlfDjBm3HVLmezlXm6G?=
 =?us-ascii?Q?LSd57+GeLPqBzEQPhZOM+FIsFarmlQnV/L16O5px103pvRbM28SeLx+M6xVA?=
 =?us-ascii?Q?0DrEarMAHea0qxLfUfkfyeB8loG5qDTOfIlmIHGj57wr8y8tWwv0UE3pki6o?=
 =?us-ascii?Q?qvhnOhmHbijHZJmEpsf5NrFijLRSa7iEt1VxqpsC+2x5kxlwPYjZtOIQ+77I?=
 =?us-ascii?Q?Y5AAcFRldMwu/km5ttz9kebn5mDyg48J7TNt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 11:04:13.9804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee89036-28b3-4a87-fa04-08ddc90f7e7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6179
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

OpenSBI expects mmu-type to be present in DT that's why add it. Without it
OpenSBI disable CPU node which ends up in not working boot.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/riscv/dts/xilinx-mbv32.dts | 3 ++-
 arch/riscv/dts/xilinx-mbv64.dts | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/dts/xilinx-mbv32.dts b/arch/riscv/dts/xilinx-mbv32.dts
index 4050ce2f051d..96e428062442 100644
--- a/arch/riscv/dts/xilinx-mbv32.dts
+++ b/arch/riscv/dts/xilinx-mbv32.dts
@@ -2,7 +2,7 @@
 /*
  * dts file for AMD MicroBlaze V
  *
- * (C) Copyright 2023, Advanced Micro Devices, Inc.
+ * (C) Copyright 2023 - 2025, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -26,6 +26,7 @@
 			device_type = "cpu";
 			reg = <0>;
 			riscv,isa = "rv32imafdc";
+			mmu-type = "riscv,sv39";
 			i-cache-size = <32768>;
 			d-cache-size = <32768>;
 			clock-frequency = <100000000>;
diff --git a/arch/riscv/dts/xilinx-mbv64.dts b/arch/riscv/dts/xilinx-mbv64.dts
index 4d65d338ecb6..5a989c1697e4 100644
--- a/arch/riscv/dts/xilinx-mbv64.dts
+++ b/arch/riscv/dts/xilinx-mbv64.dts
@@ -2,7 +2,7 @@
 /*
  * dts file for AMD MicroBlaze V
  *
- * (C) Copyright 2023 - 2024, Advanced Micro Devices, Inc.
+ * (C) Copyright 2023 - 2025, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -26,6 +26,7 @@
 			device_type = "cpu";
 			reg = <0>;
 			riscv,isa = "rv64imafdc";
+			mmu-type = "riscv,sv39";
 			i-cache-size = <32768>;
 			d-cache-size = <32768>;
 			clock-frequency = <100000000>;
-- 
2.43.0

