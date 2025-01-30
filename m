Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5809C02190
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 08:09:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C68282014;
	Thu, 30 Jan 2025 09:08:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OcYlDAXZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 651A481F95; Thu, 30 Jan 2025 09:08:53 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50FE681F0D
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 09:08:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtYbNrPHEwpoZJ0ndkDAk9yyOOy1QMvDW4jJMLb3QTyUpJVV1NKR3KZC0fLMIrKy9Y/QbR0q5IKHEPWWw58cpmrd5jr46rwUSjUqGi/xH2oPqCtxAJb8Lq0VEKGuM/FfXF3QOt40rdfOG2QqEbzCu6gqlvZK2ZPOrXw6byvbDfQ/DDluwq7/BMbU9pDKjPOpuqkodBOsXbJxyN0n0zejuOdJqXq/urE0I0QqdlTfBNO5hIogejSadT/REMeVXJU3sFjO3Q3QLqbUw9zdhZxKK2Fjvk2ROkuC7siCVPMkZqECSJt9Lo7fzeSH0CKqWOgFobXsOcsvhyi/p+4HWQoVnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvbjbGf3Yv03TdRu9B3d7wKgSzzUpKgLvMPgpIZ3vyw=;
 b=IHWn3HpdCw661GM5bNNJ+nanZostYU30xKXhHzPzjIK2IrS/+G7ObCjoHJJYjvz3tarvh9msJHJX4E5wxaQ7O+e4MagFJbfAPOvQrR/0kTWyaP4AI6dFGTsQ3ytdFxGyOPTDsxNh3ZZtRlMBVLSENZAiRAjZbqooNugVZPyHpKv0NFPAZUv5sEDZ2BnqZ6iciH4CdBHiafeBfDLgwN88U8Sb/Fqy1Lie6HUfjcXzQKNnpLGFqgcfTT20RTQbN513l4sYuTAingSygE1k4FI5epuJWQy/ffFn5Pi7343aPf9YArDx71dVQAPiFt7phhDMtgJZh8jiTB9Zl6AvqbFecA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvbjbGf3Yv03TdRu9B3d7wKgSzzUpKgLvMPgpIZ3vyw=;
 b=OcYlDAXZht86G2cKxQpaFlzYL9nshFwtSCwPuolMeXkms5gf5bTCrYP9CqbJ2GXRsvXguz9hkCxjUVeYcrH8Dqq+2topBOiH+q2IWlBZVsgvM29NdVmN/hsNS73eAIgbjS/q3pJVDje9eqvU3AZwQg2Yxf4g+1jYAnV41nECmeo=
Received: from BL0PR02CA0035.namprd02.prod.outlook.com (2603:10b6:207:3c::48)
 by SJ1PR12MB6148.namprd12.prod.outlook.com (2603:10b6:a03:459::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Thu, 30 Jan
 2025 08:08:47 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:207:3c:cafe::3a) by BL0PR02CA0035.outlook.office365.com
 (2603:10b6:207:3c::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Thu,
 30 Jan 2025 08:08:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 30 Jan 2025 08:08:47 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Jan
 2025 02:08:45 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] arm64: zynqmp: Use DTB address base from .config
Date: Thu, 30 Jan 2025 09:08:30 +0100
Message-ID: <8b694eb7a11c63e32f95de2f66b2cdf3bed575c8.1738224505.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738224505.git.michal.simek@amd.com>
References: <cover.1738224505.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1834; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=BnPvz6fERU7o0uv+RZrK7qjy+p4UKqIMIF7n2zpbnps=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTZxk1rRa97mRYsDAgxfVX5o+9T9Pss/STjD7+4P85ti
 5f2D1LsiGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABPxucKwYO6MtGtbDqh9VP+2
 eq3QvxUyKvIOfAwLZlSeNWboeNH0t+/qindR0+/t179gAQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|SJ1PR12MB6148:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d2f880-6aa3-4299-3784-08dd4105527b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xrzWbzBLsXGyrEnmJzVseF5I0WSED1b3S+C8AA+HO9wyjAjFMRLS8V24RC1t?=
 =?us-ascii?Q?JBEWSEhWCQcJgOBQ/5xA3rPVR+3Exm7gS3w2zNUj4J3tT013+BZMSh8wJfE5?=
 =?us-ascii?Q?PD6AKKPsGPP/3aofo8wUNJtiIsqpxKwaRfHxcBaJJ30FQUjT96LX+u42H71M?=
 =?us-ascii?Q?gDZGpiFnoRRSNylXzIv/o2xUqeulQCKniawvaZbs3b/u9twBdUSsHw3Kah0U?=
 =?us-ascii?Q?EziRHW5qZ8mzJF+sauzQWAHg12Za7NSpQjt7mLCJyTOYysNFWbc98osmcWuD?=
 =?us-ascii?Q?Nhw2PxI6gDU9KJtb27XZd8UVXXJbikCa6mRRMM1/kloFdYJXEW9UVaoGTvPs?=
 =?us-ascii?Q?PM0Z6dXvD3CExptzVwh9vkGzACPOknJiPvB/ScK90GwAGMlHP+/zYDG2XhXw?=
 =?us-ascii?Q?ef/vO8v/wv7mPHZvtGq7vansCnROnTGpeV5PzBQ4odY/7Q0l3PyAY1hNnVvT?=
 =?us-ascii?Q?JB7yeJzZnxiCT3mdiP9yU9YfLjEOi6EbR4IsoOHXKqlNXtfqNPwMBQ7Fahxl?=
 =?us-ascii?Q?o0JwXbuH5jJJjwrpIjZbp38F4KIJGQSHLLu5tMFWqeuDGDLFazM4Khzh8pHQ?=
 =?us-ascii?Q?gNOZS0DVFSKxDBcWv01Ph/r2iZd+/n6++6WDU92MIsA1pojsomfhZCj/ZSuS?=
 =?us-ascii?Q?qDwPGku8VLiNGCIPib4A7r25rZw6Otz1Rt6vcymZjf3D2yeG6cmMhjCWy/w1?=
 =?us-ascii?Q?Nr0kFhL8Dj7DProjsQE15LoR4K/IDHSIFnWjJlpckMBbQuzKCngFPl9eTYCq?=
 =?us-ascii?Q?3QZycC48wRHgoWTvOfWYfmZyiKq/x6vDhlCa6UvnFv7Bn0z9ol6sdPayZaro?=
 =?us-ascii?Q?Mkc4xDxkNMvqUCwq50DpMkk7LV/9XGewsJA3MLn3bssWrXPKn+4AjsJpbfaD?=
 =?us-ascii?Q?BnQNItia+eAFm5ORS3hlHtrwAHpVdBW5b1/scK0S2P/9DuGF1u2P0hCNj6Le?=
 =?us-ascii?Q?JYpD8Bc58YtlBtR0LE0sO4t5HZUAi4fIG7G1NhbtVdYHhzXKFyuSan5y1UV0?=
 =?us-ascii?Q?GYyz12qnW0iidVgfSaQTdu6s9D7VrLgeEYYcPNdRWJtCMAtgpqFzDaMqb2oV?=
 =?us-ascii?Q?5hPdN/jRBG+9iunhO9V5o5pBHUxvdCavfzXbKQ4hKdh1R7qbYHGTipg0wZ6m?=
 =?us-ascii?Q?cMZAqPK112WyCPiu+GnDRNj7gzBCi3OJQz8B8JFBIdYq1wgSXU/i8uOURIZc?=
 =?us-ascii?Q?HXBODAsZxOg6pL0BJuzJ9D/oFW7eZ041OQkMfdAX6JbIL0ZmLGcFEdip9zV5?=
 =?us-ascii?Q?AJzYq2520AsMprLxhzhlluwteshQ0qJx4KrB/R0He1O4vdyXJaYKB2aHrkyb?=
 =?us-ascii?Q?YqV6fF5XRJVnhukEiQoS9YUN40PNZJg5aTbfgNuewVi3TDVWvRTBlZFlCJkc?=
 =?us-ascii?Q?685zo4AuAFR1bZ9lC6ERr+5cvNpUAbkX0AM01rQRAba0V6IvTkyU/nVbK94m?=
 =?us-ascii?Q?+kOr+hc7Nii5HDxw4PG+T3KbboIk7SpBpvBVcttbm1cw2NPxanOvu+Ck9YeW?=
 =?us-ascii?Q?CjORlfXxN3qpYn4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 08:08:47.0146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d2f880-6aa3-4299-3784-08dd4105527b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6148
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

CONFIG_XILINX_OF_BOARD_DTB_ADDR holds DTB address which U-Boot is checking.
Currently address in binman match default value but macro can be used
directly.
Also sync node name (s/hash-1/hash/) and sync location to have the same
order load/hash/image.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-binman-som.dts |  2 +-
 arch/arm/dts/zynqmp-binman.dts     | 13 ++++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm/dts/zynqmp-binman-som.dts b/arch/arm/dts/zynqmp-binman-som.dts
index e8b7084521c5..b0100b23f7f5 100644
--- a/arch/arm/dts/zynqmp-binman-som.dts
+++ b/arch/arm/dts/zynqmp-binman-som.dts
@@ -160,7 +160,7 @@
 						type = "flat_dt";
 						arch = "arm64";
 						compression = "none";
-						load = <0x0 0x100000>;
+						load = /bits/ 64 <CONFIG_XILINX_OF_BOARD_DTB_ADDR>;
 						hash {
 							algo = "md5";
 						};
diff --git a/arch/arm/dts/zynqmp-binman.dts b/arch/arm/dts/zynqmp-binman.dts
index 6d28a5bdae25..b3cda8b59eec 100644
--- a/arch/arm/dts/zynqmp-binman.dts
+++ b/arch/arm/dts/zynqmp-binman.dts
@@ -74,8 +74,8 @@
 						type = "flat_dt";
 						arch = "arm64";
 						compression = "none";
-						load = <0x0 0x100000>;
-						hash-1 {
+						load = /bits/ 64 <CONFIG_XILINX_OF_BOARD_DTB_ADDR>;
+						hash {
 							algo = "md5";
 						};
 					};
@@ -151,15 +151,14 @@
 						type = "flat_dt";
 						arch = "arm64";
 						compression = "none";
-						load = <0x0 0x100000>;
+						load = /bits/ 64 <CONFIG_XILINX_OF_BOARD_DTB_ADDR>;
+						hash {
+							algo = "md5";
+						};
 						uboot-fdt-blob {
 							filename = "u-boot.dtb";
 							type = "blob-ext";
 						};
-						hash-1 {
-							algo = "md5";
-						};
-
 					};
 				};
 				configurations {
-- 
2.43.0

