Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951E7FA3737
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 09:30:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F11C88960;
	Fri, 13 Sep 2024 11:29:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KaalMj0s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FD6B88ABF; Fri, 13 Sep 2024 11:29:31 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31D49887FA
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:29:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lANpwFiWrMrO0AbuSylL2L18JORMLGxqI8auwmmzkAgjxohKIYcCx9JQk/U6WugmPRGroY7WJTr9tknIkR8GJZX5GknGoZ8ZisXNwo5XKKMDPwdDnKy0E1eEi4HmYEt95rPJPKCd5tckgMJqXFio6ck00hF4UjVfo9ShX+zNgy7ql8yyzgSdarZLEVqCo09PYas5UwpPq7eXRteoKYhymC2unlhLYo3qtTnVkhg2Qe5776IxkjfdkNJEog4+U5xP2carckiLVXfxnPbE6OxKQXPLrQJ77E90aQyeFANBQ+aIJfDn4roYtOwSJoVmnH/+2SUO3BItRHoI03LkiIeIUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/lWMzPlJmF0lgIBHv7EGfoLS9vxxlw/+0XcKa7rctg=;
 b=w7VxF9BolZrc/t2E4jLezkteBZy/5R4xiU2z+szRCT4R85vyOsSW5F70lpvr9Sbd1h3EOazOHU12ZbNrV3jzeUxS7erHgoSSaj6eig/udVoYO2afH+wjEhXNU8rjJJxQx8CfesDHFxsF0zOCsr6Szn6LpEVTnT3bwKPfHUsR4VKeMJ57pBrtIxNYdWf6F+maR4uhq0P6KEVpk8TNCnkf+Ci3MPfXZX+LvXW7RjcfKJNJP0DmcSSR505A+IjI4gkZZyL0IfS/U6KqFFgXVH9fl0nK16UXae7HyNpatP0opDSE9luLDr3KW6haCrC8sHHktS1pEUl8pzYZd4WvO2vMjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/lWMzPlJmF0lgIBHv7EGfoLS9vxxlw/+0XcKa7rctg=;
 b=KaalMj0s9lzarELRlX9m7cXpIzExQi9zyotaLba+/LN0UbDRsLRTQwhd69etuWAHLz4S7W8o0vTgmjYvCTatozbQMVS7p7C4iGo35jHNXXVos+DBcTp9n/oThpTKBWGc6HrfeWv776UVj4UZbX/88l9aw1dI80q7ZkoOfcWbzVE=
Received: from SN6PR05CA0001.namprd05.prod.outlook.com (2603:10b6:805:de::14)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 09:29:22 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:805:de:cafe::8f) by SN6PR05CA0001.outlook.office365.com
 (2603:10b6:805:de::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Fri, 13 Sep 2024 09:29:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 09:29:22 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 04:29:20 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 05/10] arm64: zynqmp: Fix comment style around gpio line-names
Date: Fri, 13 Sep 2024 11:28:46 +0200
Message-ID: <938a2658edf68665ef9e34d2584adacfa83dd01f.1726219714.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726219714.git.michal.simek@amd.com>
References: <cover.1726219714.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7183; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=wqxLMfJEvArySdvYRfLAMVGWtynUu8eWIb0nac7df60=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrQnrGf3XvN0eWFWKtT+4sPhMJdkHTfNlUGbPLSqs6PmH
 j8pHLe5I5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAExE041hnu08nsKQgh3+cQL9
 T+vTp2+S2L8/h2FBa+H33oXWb077up9ZOiX5u0Uw0yIdAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|MN2PR12MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: 42a53f6c-d291-47a1-0914-08dcd3d68d23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TBGpJH5+PpLTMZBCPCHr0pbMMDbGOJVe13l7QODdBnd8p1xus2GcByA/Aleq?=
 =?us-ascii?Q?jA12RZ5CMGQ9icTKM5JJ3LTSc1TRMy3ytbf/2i1KFzx1Zu0WwxeEpepekX+n?=
 =?us-ascii?Q?J2z+ct+40fpn4MKdhDPB3wQIYSltJjoFkrKFvmIjkMPqaG1aTHj0s9CNm9Yi?=
 =?us-ascii?Q?D3MRvZ3kJvqd42/kyrPbxLAF4pNh38PQ3kkAZ1zVzj871yVBW6ZtcMEpVMt9?=
 =?us-ascii?Q?iGubd3H2paCaJeEWHZAYNCLzX1CgKF50xLViBNnkeMxWh4fvzBOwU07y4zg3?=
 =?us-ascii?Q?zax/jx+Bcx0fyB/hUau9UuVB2JI5byGSvjmwN/fEjpht45Gmqs9cnYgf8AWM?=
 =?us-ascii?Q?GS7LXkNSulet/sqbaVhsGIBx9BqghHYCK/K4/F2EkqNDxBBVIwIatZRO279y?=
 =?us-ascii?Q?Q5eQU98w9jYefcZ/OZn8qTpIIGkJgFesSVKDN+zst/XUsK9SHoUf/4Gf4MUM?=
 =?us-ascii?Q?WKIvH5zUjf7YuYnnn9IPXGVw6Wr6VYw9hswemIATHS0r8fuxhMjU9kVKKZ9j?=
 =?us-ascii?Q?VAbH2n7U8ueiBl094DO2ELmjbcLnOA6n+wMMEWfVGSVbdSPweV2gzykNkFRU?=
 =?us-ascii?Q?3r5qWc3UZtNPrvLAl6Kq/khdLQwpL1xHsOIP6aAR0gGtOEMEseZQ2L5NjBki?=
 =?us-ascii?Q?4R/sd/wKL7TDpsGF4d3Z/L4sjaIhAHPJdcXizbbUMiqXUnwWi9xnnHSnPq3x?=
 =?us-ascii?Q?4xEwiGvvWT9twHBTvAcGfv4RSX9/0+zuLd/oVbzZcLPnrXD709AAyC0NoM9E?=
 =?us-ascii?Q?b7Mf33ns1sCnXIAwS1Zn28MbSEK8pAy62wNueTwMULVh4s7y7jwl9Hl30+39?=
 =?us-ascii?Q?KvEKtqmr2D6xKFvP+NzRi+fHZZ/JUCNpsZu1RSGWBnuUbh+6gK2WLjpMoEtF?=
 =?us-ascii?Q?fRQlAHb8xZsSSPT/ydmepDozFodcnM9chjGHbsBSzisR4xieIgjbSvAA6n73?=
 =?us-ascii?Q?UYcwbbkaQsXRGInh1zVcYZPkoaN/aBO8r9FqJQiIhHliK07mJUc4KC0nuWF9?=
 =?us-ascii?Q?ik90SRBcp30iSb/rBFm6rvdgP4F8FV4kChdesnFtBzMU2joj4r06feFGsvMN?=
 =?us-ascii?Q?m725tLVh0Us1+9JVU/hGIrGDtdlrs71gT62t2I9Xbdmuduu5XvF+vllz7u1F?=
 =?us-ascii?Q?D/8/1v0IiKisUuCwJm7vfrfR2NoIUHB2PAa19WO/rhLI6eVryFEXpHMlITxj?=
 =?us-ascii?Q?/Xpc9pqZVdBYmN+7iJFRIS7fu/XCgT9RSmoxs1/cabn3TvVvIg1jgGMjtTxf?=
 =?us-ascii?Q?B2hJslE1PZLPEbeAdZjQmm8FLtjdfI7NApMpyPEVb/bOsyNIQol3IfUSdcIm?=
 =?us-ascii?Q?XPFQXHaQkcB7vsRbgMu0ljtyX5KedA9A7Lx5RGXUqcYIbcPFs79yizq3v9IF?=
 =?us-ascii?Q?sdrnl63duDbPXy4Tld9e5InzkvPTIq4Aqn5qB1F9+EpRBlGlj7UIOayi7M7O?=
 =?us-ascii?Q?yp6ZzX2a3CnvQHZmEmE2G/IYWmA9PAcp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 09:29:22.3332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a53f6c-d291-47a1-0914-08dcd3d68d23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288
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

Just fix description to be aligned with other comments.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-dlc21-revA.dts      | 2 +-
 arch/arm/dts/zynqmp-g-a2197-00-revA.dts | 2 +-
 arch/arm/dts/zynqmp-m-a2197-01-revA.dts | 2 +-
 arch/arm/dts/zynqmp-m-a2197-02-revA.dts | 2 +-
 arch/arm/dts/zynqmp-m-a2197-03-revA.dts | 2 +-
 arch/arm/dts/zynqmp-p-a2197-00-revA.dts | 2 +-
 arch/arm/dts/zynqmp-sc-revB.dts         | 2 +-
 arch/arm/dts/zynqmp-zcu208-revA.dts     | 2 +-
 arch/arm/dts/zynqmp-zcu216-revA.dts     | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/dts/zynqmp-dlc21-revA.dts b/arch/arm/dts/zynqmp-dlc21-revA.dts
index 1bcf987d7b16..293d8e97b63a 100644
--- a/arch/arm/dts/zynqmp-dlc21-revA.dts
+++ b/arch/arm/dts/zynqmp-dlc21-revA.dts
@@ -117,7 +117,7 @@
 		  "USB1_DATA7", "ETH_MDC", "ETH_MDIO", /* 75 - 77, MIO end and EMIO start */
 		  "", "", /* 78 - 79 */
 		  "", "", "", "", "", /* 80 - 84 */
-		  "", "", "", "", "", /* 85 -89 */
+		  "", "", "", "", "", /* 85 - 89 */
 		  "", "", "", "", "", /* 90 - 94 */
 		  "", "VCCO_500_RBIAS", "VCCO_501_RBIAS", "VCCO_502_RBIAS", "VCCO_500_RBIAS_LED", /* 95 - 99 */
 		  "VCCO_501_RBIAS_LED", "VCCO_502_RBIAS_LED", "SYSCTLR_VCCINT_EN", "SYSCTLR_VCC_IO_SOC_EN", "SYSCTLR_VCC_PMC_EN", /* 100 - 104 */
diff --git a/arch/arm/dts/zynqmp-g-a2197-00-revA.dts b/arch/arm/dts/zynqmp-g-a2197-00-revA.dts
index 565b2273d67b..c439f778ca46 100644
--- a/arch/arm/dts/zynqmp-g-a2197-00-revA.dts
+++ b/arch/arm/dts/zynqmp-g-a2197-00-revA.dts
@@ -111,7 +111,7 @@
 		  "", "ETH_MDC", "ETH_MDIO", /* 75 - 77, MIO end and EMIO start */
 		  "SYSCTLR_VERSAL_MODE0", "SYSCTLR_VERSAL_MODE1", /* 78 - 79 */
 		  "SYSCTLR_VERSAL_MODE2", "SYSCTLR_VERSAL_MODE3", "SYSCTLR_POR_B_LS", "DC_PRSNT", "SYSCTLR_POWER_EN", /* 80 - 84 */
-		  "SYSCTLR_JTAG_S0", "SYSCTLR_JTAG_S1", "SYSCTLR_IIC_MUX0_RESET_B", "SYSCTLR_IIC_MUX1_RESET_B", "SYSCTLR_LP_I2C_SM_ALERT", /* 85 -89 */
+		  "SYSCTLR_JTAG_S0", "SYSCTLR_JTAG_S1", "SYSCTLR_IIC_MUX0_RESET_B", "SYSCTLR_IIC_MUX1_RESET_B", "SYSCTLR_LP_I2C_SM_ALERT", /* 85 - 89 */
 		  "SYSCTLR_GPIO0", "SYSCTLR_GPIO1", "SYSCTLR_GPIO2", "SYSCTLR_GPIO3", "SYSCTLR_GPIO4", /* 90 - 94 */
 		  "SYSCTLR_GPIO5", "VCCO_500_RBIAS", "VCCO_501_RBIAS", "VCCO_502_RBIAS", "VCCO_500_RBIAS_LED", /* 95 - 99 */
 		  "VCCO_501_RBIAS_LED", "VCCO_502_RBIAS_LED", "SYSCTLR_VCCINT_EN", "SYSCTLR_VCC_IO_SOC_EN", "SYSCTLR_VCC_PMC_EN", /* 100 - 104 */
diff --git a/arch/arm/dts/zynqmp-m-a2197-01-revA.dts b/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
index a5b61a8ca84d..adffd9e78607 100644
--- a/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
@@ -142,7 +142,7 @@
 		  "USB1_DATA7", "ETH_MDC", "ETH_MDIO", /* 75 - 77, MIO end and EMIO start */
 		  "", "", /* 78 - 79 */
 		  "", "", "", "", "", /* 80 - 84 */
-		  "", "", "", "", "", /* 85 -89 */
+		  "", "", "", "", "", /* 85 - 89 */
 		  "", "", "", "", "", /* 90 - 94 */
 		  "", "", "", "", "", /* 95 - 99 */
 		  "", "", "", "", "", /* 100 - 104 */
diff --git a/arch/arm/dts/zynqmp-m-a2197-02-revA.dts b/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
index 80829a120ecc..b679efa4a35e 100644
--- a/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
@@ -137,7 +137,7 @@
 		  "USB1_DATA7", "ETH_MDC", "ETH_MDIO", /* 75 - 77, MIO end and EMIO start */
 		  "", "", /* 78 - 79 */
 		  "", "", "", "", "", /* 80 - 84 */
-		  "", "", "", "", "", /* 85 -89 */
+		  "", "", "", "", "", /* 85 - 89 */
 		  "", "", "", "", "", /* 90 - 94 */
 		  "", "", "", "", "", /* 95 - 99 */
 		  "", "", "", "", "", /* 100 - 104 */
diff --git a/arch/arm/dts/zynqmp-m-a2197-03-revA.dts b/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
index 35a13f127d37..b2d477e6d052 100644
--- a/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
@@ -137,7 +137,7 @@
 		  "USB1_DATA7", "ETH_MDC", "ETH_MDIO", /* 75 - 77, MIO end and EMIO start */
 		  "", "", /* 78 - 79 */
 		  "", "", "", "", "", /* 80 - 84 */
-		  "", "", "", "", "", /* 85 -89 */
+		  "", "", "", "", "", /* 85 - 89 */
 		  "", "", "", "", "", /* 90 - 94 */
 		  "", "", "", "", "", /* 95 - 99 */
 		  "", "", "", "", "", /* 100 - 104 */
diff --git a/arch/arm/dts/zynqmp-p-a2197-00-revA.dts b/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
index 1ae96e34ee91..ae52e8e996a5 100644
--- a/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
+++ b/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
@@ -120,7 +120,7 @@
 		  "USB1_DATA7", "ETH_MDC", "ETH_MDIO", /* 75 - 77, MIO end and EMIO start */
 		  "SYSCTLR_VERSAL_MODE0", "SYSCTLR_VERSAL_MODE1", /* 78 - 79 */
 		  "SYSCTLR_VERSAL_MODE2", "SYSCTLR_VERSAL_MODE3", "SYSCTLR_POR_B_LS", "DC_PRSNT", "SYSCTLR_POWER_EN", /* 80 - 84 */
-		  "SYSCTLR_JTAG_S0", "SYSCTLR_JTAG_S1", "SYSCTLR_IIC_MUX0_RESET_B", "SYSCTLR_IIC_MUX1_RESET_B", "SYSCTLR_LP_I2C_SM_ALERT", /* 85 -89 */
+		  "SYSCTLR_JTAG_S0", "SYSCTLR_JTAG_S1", "SYSCTLR_IIC_MUX0_RESET_B", "SYSCTLR_IIC_MUX1_RESET_B", "SYSCTLR_LP_I2C_SM_ALERT", /* 85 - 89 */
 		  "SYSCTLR_GPIO0", "SYSCTLR_GPIO1", "SYSCTLR_GPIO2", "SYSCTLR_GPIO3", "SYSCTLR_GPIO4", /* 90 - 94 */
 		  "SYSCTLR_GPIO5", "VCCO_500_RBIAS", "VCCO_501_RBIAS", "VCCO_502_RBIAS", "VCCO_500_RBIAS_LED", /* 95 - 99 */
 		  "VCCO_501_RBIAS_LED", "VCCO_502_RBIAS_LED", "SYSCTLR_VCCINT_EN", "SYSCTLR_VCC_IO_SOC_EN", "SYSCTLR_VCC_PMC_EN", /* 100 - 104 */
diff --git a/arch/arm/dts/zynqmp-sc-revB.dts b/arch/arm/dts/zynqmp-sc-revB.dts
index c1d713b5d890..1fcb5bfb9286 100644
--- a/arch/arm/dts/zynqmp-sc-revB.dts
+++ b/arch/arm/dts/zynqmp-sc-revB.dts
@@ -104,7 +104,7 @@
 		"", "", "ETH_RESET_B", /* 75 - 77, MIO end and EMIO start */
 		"", "", /* 78 - 79 */
 		"", "", "", "", "", /* 80 - 84 */
-		"", "", "", "", "", /* 85 -89 */
+		"", "", "", "", "", /* 85 - 89 */
 		"", "", "", "", "", /* 90 - 94 */
 		"", "", "", "", "", /* 95 - 99 */
 		"", "", "", "", "", /* 100 - 104 */
diff --git a/arch/arm/dts/zynqmp-zcu208-revA.dts b/arch/arm/dts/zynqmp-zcu208-revA.dts
index a113e475082f..215908d4a3e5 100644
--- a/arch/arm/dts/zynqmp-zcu208-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu208-revA.dts
@@ -205,7 +205,7 @@
 		  "ENET_RX_CTRL", "ENET_MDC", "ENET_MDIO", /* 75 - 77, MIO end and EMIO start */
 		  "", "", /* 78 - 79 */
 		  "", "", "", "", "", /* 80 - 84 */
-		  "", "", "", "", "", /* 85 -89 */
+		  "", "", "", "", "", /* 85 - 89 */
 		  "", "", "", "", "", /* 90 - 94 */
 		  "", "", "", "", "", /* 95 - 99 */
 		  "", "", "", "", "", /* 100 - 104 */
diff --git a/arch/arm/dts/zynqmp-zcu216-revA.dts b/arch/arm/dts/zynqmp-zcu216-revA.dts
index 4d7d5d2e5eff..b5e11cc4ff45 100644
--- a/arch/arm/dts/zynqmp-zcu216-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu216-revA.dts
@@ -211,7 +211,7 @@
 		  "ENET_RX_CTRL", "ENET_MDC", "ENET_MDIO", /* 75 - 77, MIO end and EMIO start */
 		  "", "", /* 78 - 79 */
 		  "", "", "", "", "", /* 80 - 84 */
-		  "", "", "", "", "", /* 85 -89 */
+		  "", "", "", "", "", /* 85 - 89 */
 		  "", "", "", "", "", /* 90 - 94 */
 		  "", "", "", "", "", /* 95 - 99 */
 		  "", "", "", "", "", /* 100 - 104 */
-- 
2.43.0

