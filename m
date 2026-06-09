Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5725CD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 07:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D97E7848A9;
	Tue,  9 Jun 2026 09:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T92vp+eE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D21D4848A9; Tue,  9 Jun 2026 09:49:30 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D0A58493F
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 09:49:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLUCgN+0SkCQZG3yylDNFhgmPyWnDInVGc3tHg/fYUmqHAvcGAmWXntKZgqiAxbiSqAAxqoTPPctls9C/3Qb0vQglJU8Bw3+6oO+O9/CtPrYCv+VGc4fM7sUT7rg5w5sHE0Nw8/nDHAPzNmmnCOu4HPRl53z33eYGc9u35ze4xnxTO8jaYLWfhNLeN25tTiO3oaoaiStthKKnxiUaauWpsLyhhZXVZR2XpYacPb71LdHdX8M/EKmKhaI7U12KEQYaq7iEGS+JpCnUKfNVjmVbASZGqBde8vmxlbxUlrUvKW/RY6AwVpESV/4/xwQCTETZH6o2m9KGxzYuVKcnpiq2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWo0sGypt5/v66JAobMWvOt0w5cTxOwx1cXn9MGvjBc=;
 b=d6eQ+o4y/5qgswe9kEKWvyylClev07TAAnjzwY4UfsqtrX0sWEKeE6uRVe4sbEypD+nmlRwklP6kWSY4TXYZxTNZ2atKtAiwzPcZhVJRdIamb6oiZMmHIFVqP/lXLX/qsGwMBNEjJ9rsA8WQypH25JfpYs12chBGtZZpmFsiUjX9le9QQ4+cO5ZYKqdMl1vwpGvztATtV5n7zpmK5kezGKA4MNaMrGsCCbpD3J7AaIkJKN9bcmOta1rp5GppOdMZM20t15OhRTXJQyA76EI+52HrP0e2fS4Msc3EtPSahsts/PLhA67JaIKbC2T+9QCFVG54+G5ZM08iTICvtapd/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWo0sGypt5/v66JAobMWvOt0w5cTxOwx1cXn9MGvjBc=;
 b=T92vp+eE0obQlhnqzkWw7GEai0775IHFmMKm1zfHfDJ538KuJAxGaV+wYqEsU38hQxXAsMA1q/KEPmrNc0EJZ2ZtiAgtx/ozDTmcB5bo+i2FaRdxJFuLID64HG/5lSqyh96/DJ5E9p6F2fGjMm95GkUrJvhcL5HChiVnc1VJY64=
Received: from BYAPR21CA0030.namprd21.prod.outlook.com (2603:10b6:a03:114::40)
 by DS0PR12MB6488.namprd12.prod.outlook.com (2603:10b6:8:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 07:49:23 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::50) by BYAPR21CA0030.outlook.office365.com
 (2603:10b6:a03:114::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 07:49:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 07:49:22 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 02:49:18 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 02:49:17 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 9 Jun 2026 02:49:16 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 9/9] arm64: zynqmp: Sync compatible string format
Date: Tue, 9 Jun 2026 09:48:23 +0200
Message-ID: <4192927ae769e74e4ddbc1cc9814ed0305b64a5d.1780991287.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780991287.git.michal.simek@amd.com>
References: <cover.1780991287.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5325; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=bnJ4IOz6GlxFVEXLAhhdcRIOPvQmQTVQEx83rPhswZ0=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSpH/Wcm/S1d79Vt11FZNlxnstCpi0hl04fX8FjVKOoY
 qz6UPNdRykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAExk312G/yVnuZK2BK8tFI3J
 ftd67qf74jv7Pt1+u8X/eLXYuhdXBXQZ/qeLdv251jlX+fO/t0dmR83+8jnpJb9u9aMZrwvN2Xd
 GaLMBAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|DS0PR12MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: 29562a16-1130-42c4-587a-08dec5fb9eea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yMyeCFKQxZkfYLbTJWskz6ucIXM5U8KJw0pBXZKKTq7qdu1+HCcLpxRFpo5aq70NyapiK/Lj4r+RmHQTIiXyIFUDyEbMu/A6NvlnBpWbLJCLuwIPrNjYSKsPw2fgYKv0oEK6Xbu0vokNdz7m+ZkgVPzTooMrdburHUPhpwMISWa/DvXONqS1N0n337fyfPHA8z+t8zwyAndrxhSR2vJY6vAoRffBWEjWzMsz+Xj1vvZIc2lKXAsHC/XukqYwnMRkxHtPmW6HDxUO8aZupW/E1RG/xDI8/xw8JUx8WqKTYKn6sYuicDbm09aJOWlkx4GzBXbNb6OFf+dmck+PiHfcHcDVwjMD/g4Kb340xa0EGX7c2layoygfxlzHqUDPYFXEnHV6b6aaFPH4v3PzwUdcfJnGK/peiFHSH4v4N++Et2FILGgj2gg5uuzE1xVfPITTsXe9t7WL4s8vw97i/oj0gNOTShPv3X/Matzwt+2AIN/G9Kw68bcCnus0gidBRmcj5WYc1QznZ3rUxX6QwaA3XsxNl5qFkZcGtwBWWpNFlJYc5c0S57Kv0m+JRGs9diYJfHNiY2S+D0L2ORyJG9bHFbfe8NvgLdZIbvl8eQM4+3wkrbQ1tjGNfa7tWWgcl3Kn9MyVdMpJLZF9nOWJ1/BrSMrZxkVCOfP3N5PgZPoN/zIUnR6xltC4bbXQyUcXhjEVfn1t7c71FCdNO9bZcsTz4yUmTJURwKvym7YX98kazQg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0rS74ehCqb4MXZ0MLzQ/hgBlNJeiULsCrDCEgIcM42kxzJDM+WFUmVqL8wAPnpGNgJKfu6R3T8S8JlWgylahMIG8hRyukfhU31gT/XeII0fdJAO+yqmfqKqbWeU0wd8TMhJKi18f5FbVM7oN0pbvIde+xXcB9SWD6DZ2q+rFzlLnAAObOzkjfaBaJRAIURoYfU5PtX7JgPCFYBOsBGY5nBGfy5neoLTPXnKr/mx6ZZ/LDUl64Op+OMsWZVPGCwNaeQupZq2cdo81Q68X8AYOmKGSYXysFRwXoKzUM3FC+mgec8v2ZwTXBHnyobKSf4w78PQgSAgtJDbynTWhuEmZNSeZyf7uIKZe16V+C1mTUNr7vWVvdTv7SGYX16ypQP+9Q2VcFzLsBaJXsGPOkMb6J2yLohpqly4v07qo3fzbI3fWdgp3iPs/nk4Y544Mm+OP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:49:22.5874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29562a16-1130-42c4-587a-08dec5fb9eea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6488
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

There is no reason to have non zynqmp-sc compatible string for overlays
which can be applied only with SCs.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sc-vek280-revA.dtso | 5 ++---
 arch/arm/dts/zynqmp-sc-vek280-revB.dtso | 5 ++---
 arch/arm/dts/zynqmp-sc-vhk158-revA.dtso | 5 ++---
 arch/arm/dts/zynqmp-sc-vpk120-revB.dtso | 5 ++---
 arch/arm/dts/zynqmp-sc-vpk180-revA.dtso | 5 ++---
 arch/arm/dts/zynqmp-sc-vpk180-revB.dtso | 5 ++---
 6 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/arch/arm/dts/zynqmp-sc-vek280-revA.dtso b/arch/arm/dts/zynqmp-sc-vek280-revA.dtso
index e94b784e8e1f..7212ee9df86b 100644
--- a/arch/arm/dts/zynqmp-sc-vek280-revA.dtso
+++ b/arch/arm/dts/zynqmp-sc-vek280-revA.dtso
@@ -2,7 +2,7 @@
 /*
  * dts file for Xilinx ZynqMP VEK280 revA
  *
- * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc
+ * (C) Copyright 2022 - 2026, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -13,8 +13,7 @@
 /plugin/;
 
 &{/} {
-	compatible = "xlnx,zynqmp-sc-vek280-revA", "xlnx,zynqmp-vek280-revA",
-		     "xlnx,zynqmp-vek280", "xlnx,zynqmp";
+	compatible = "xlnx,zynqmp-sc-vek280-revA", "xlnx,zynqmp-sc-vek280", "xlnx,zynqmp";
 
 	vc7_xin: vc7-xin {
 		compatible = "fixed-clock";
diff --git a/arch/arm/dts/zynqmp-sc-vek280-revB.dtso b/arch/arm/dts/zynqmp-sc-vek280-revB.dtso
index a3983f330d07..a57e9b50b20c 100644
--- a/arch/arm/dts/zynqmp-sc-vek280-revB.dtso
+++ b/arch/arm/dts/zynqmp-sc-vek280-revB.dtso
@@ -2,7 +2,7 @@
 /*
  * dts file for Xilinx ZynqMP VEK280 revB
  *
- * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc
+ * (C) Copyright 2022 - 2026, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -10,6 +10,5 @@
 #include "zynqmp-sc-vek280-revA.dtso"
 
 &{/} {
-	compatible = "xlnx,zynqmp-sc-vek280-revB", "xlnx,zynqmp-vek280-revB",
-		     "xlnx,zynqmp-vek280", "xlnx,zynqmp";
+	compatible = "xlnx,zynqmp-sc-vek280-revB", "xlnx,zynqmp-sc-vek280", "xlnx,zynqmp";
 };
diff --git a/arch/arm/dts/zynqmp-sc-vhk158-revA.dtso b/arch/arm/dts/zynqmp-sc-vhk158-revA.dtso
index fd25731b0b43..2fe35596143b 100644
--- a/arch/arm/dts/zynqmp-sc-vhk158-revA.dtso
+++ b/arch/arm/dts/zynqmp-sc-vhk158-revA.dtso
@@ -3,7 +3,7 @@
  * dts file for Xilinx ZynqMP VHK158 revA
  *
  * (C) Copyright 2022, Xilinx, Inc.
- * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
+ * (C) Copyright 2022 - 2026, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -14,8 +14,7 @@
 /plugin/;
 
 &{/} {
-	compatible = "xlnx,zynqmp-sc-vhk158-revA", "xlnx,zynqmp-vhk158-revA",
-		     "xlnx,zynqmp-vhk158", "xlnx,zynqmp";
+	compatible = "xlnx,zynqmp-sc-vhk158-revA", "xlnx,zynqmp-sc-vhk158", "xlnx,zynqmp";
 
 	vc7_xin: vc7-xin {
 		compatible = "fixed-clock";
diff --git a/arch/arm/dts/zynqmp-sc-vpk120-revB.dtso b/arch/arm/dts/zynqmp-sc-vpk120-revB.dtso
index 29b3a73fde01..ae0691c01271 100644
--- a/arch/arm/dts/zynqmp-sc-vpk120-revB.dtso
+++ b/arch/arm/dts/zynqmp-sc-vpk120-revB.dtso
@@ -3,7 +3,7 @@
  * dts file for Xilinx ZynqMP VPK120 revB
  *
  * (C) Copyright 2021 - 2022, Xilinx, Inc.
- * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
+ * (C) Copyright 2022 - 2026, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -14,8 +14,7 @@
 /plugin/;
 
 &{/} {
-	compatible = "xlnx,zynqmp-sc-vpk120-revB", "xlnx,zynqmp-vpk120-revB",
-		     "xlnx,zynqmp-vpk120", "xlnx,zynqmp";
+	compatible = "xlnx,zynqmp-sc-vpk120-revB", "xlnx,zynqmp-sc-vpk120", "xlnx,zynqmp";
 };
 
 &i2c0 {
diff --git a/arch/arm/dts/zynqmp-sc-vpk180-revA.dtso b/arch/arm/dts/zynqmp-sc-vpk180-revA.dtso
index 10466ce99de6..9b6534f6383c 100644
--- a/arch/arm/dts/zynqmp-sc-vpk180-revA.dtso
+++ b/arch/arm/dts/zynqmp-sc-vpk180-revA.dtso
@@ -3,7 +3,7 @@
  * dts file for Xilinx ZynqMP VPK180 revA
  *
  * (C) Copyright 2021 - 2022, Xilinx, Inc.
- * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
+ * (C) Copyright 2022 - 2026, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -14,8 +14,7 @@
 /plugin/;
 
 &{/} {
-	compatible = "xlnx,zynqmp-sc-vpk180-revA", "xlnx,zynqmp-vpk180-revA",
-		     "xlnx,zynqmp-vpk180", "xlnx,zynqmp";
+	compatible = "xlnx,zynqmp-sc-vpk180-revA", "xlnx,zynqmp-sc-vpk180", "xlnx,zynqmp";
 
 	vc7_xin: vc7-xin {
 		compatible = "fixed-clock";
diff --git a/arch/arm/dts/zynqmp-sc-vpk180-revB.dtso b/arch/arm/dts/zynqmp-sc-vpk180-revB.dtso
index 6a5ada34ed71..941d26c025a8 100644
--- a/arch/arm/dts/zynqmp-sc-vpk180-revB.dtso
+++ b/arch/arm/dts/zynqmp-sc-vpk180-revB.dtso
@@ -3,7 +3,7 @@
  * dts file for Xilinx ZynqMP VPK180 revB
  *
  * (C) Copyright 2021 - 2022, Xilinx, Inc.
- * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
+ * (C) Copyright 2022 - 2026, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -14,8 +14,7 @@
 /plugin/;
 
 &{/} {
-	compatible = "xlnx,zynqmp-sc-vpk180-revB", "xlnx,zynqmp-vpk180-revB",
-		     "xlnx,zynqmp-vpk180", "xlnx,zynqmp";
+	compatible = "xlnx,zynqmp-sc-vpk180-revB", "xlnx,zynqmp-sc-vpk180", "xlnx,zynqmp";
 
 	vc7_xin: vc7-xin {
 		compatible = "fixed-clock";
-- 
2.43.0

