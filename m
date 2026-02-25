Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFA1F5545B
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 05:16:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FBDC83D8A;
	Wed, 25 Feb 2026 06:16:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="j7AEdEHn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF5C183DCB; Wed, 25 Feb 2026 06:16:45 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azhn150100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d909::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AA5D83C39
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 06:16:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GAxcbymrn7J+e5q+lnv57asC7uzV36TkrOIUDW9qjwCXbhu9UOoS8YRKTjscIoQGouZDOFfvVSPAKVqsbKbJ3xXO0glc/Pt4/iYZFRKLxmM2tD+O0+XK+NJ9NPu0stwOZGD/jWoiRNEd1AC5VFhN46YyoGPis6wVlLp6Eai9u5NgJ5Z2UypL3tttZHcXQl2wBLTQg6zh/OVkrEQIYbeuN4Ruy3abD2V8vI5P0s9VgXR7Ju82tplh94RvL5h8blbJQ3KHKDmfWLLsmw6a//sEiR3l2y6UM1anFYCLpCFJw/IFKByec++ep2ArkjN3eayeDCxH0/IV3MiQ+ICTxFNXUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJwZnTIXwQ9UWAx5Xcpk8G/lSSrD/dhXkTc+L7rTWFw=;
 b=k0tIw7/rfe+7MJwJ5+XxUTI4HWx4cP8a0Jhps/ra8aJWaC020nWw0Jf8jmWoaUOIkmJYWxRjW/IcZkCrL1rljMwE957XMe/fS3unfYi1BFASgdr/01Ttm51z9acZ4Qz5CDJ0s5Wek51fnQHhznatr77/2zMYIKcQjBt5e231qTA7JrHsVdYVwVcCohFJNlt9aYi961P1+DdTz3TMuOnM6wYpmxjptaQP/N5tMCJRM6tI6wJhULXqN3jpOu20FtnJHZ6AM4cw2iuCen+BGWX6MToIhFuyoUguxK7dw8gE/2k+NNvuHDKDXot0DIOZpl0E1tJPpbaPSQjn3vMP0a1Q7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJwZnTIXwQ9UWAx5Xcpk8G/lSSrD/dhXkTc+L7rTWFw=;
 b=j7AEdEHnFCPuy7cGZviqtQA4T8sXFFT44bwCD7KkPwKL2EPGrPUOtQz9pgHcpuc3xCuLor9Z1ISAEZp5Wut3K/Y0EdiKsYTn2zl86lgEP796L3yq1Tuiyw4hHFtI/09aegIPZBSbANVuCYHRPUEsJzFWG0okdG2wUpytKyz4rF0=
Received: from CH3P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::16)
 by PH0PR10MB997642.namprd10.prod.outlook.com (2603:10b6:510:386::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 05:16:41 +0000
Received: from DM2PEPF00003FC3.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::b1) by CH3P220CA0014.outlook.office365.com
 (2603:10b6:610:1e8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 05:16:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DM2PEPF00003FC3.mail.protection.outlook.com (10.167.23.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 05:16:40 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 23:16:40 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 23:16:40 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Feb 2026 23:16:40 -0600
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.53.178])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61P5Gan44018051;
 Tue, 24 Feb 2026 23:16:37 -0600
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <nm@ti.com>, <heiko.thiery@gmail.com>, <m-shah@ti.com>, 
 <j-keerthy@ti.com>, <n-francis@ti.com>, <bb@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Diwakar Dhyani <d-dhyani@ti.com>
Subject: [v2 PATCH] mach-k3: Defer CTRL_MMR access until after TIFS version
 response
Date: Wed, 25 Feb 2026 10:45:59 +0530
Message-ID: <20260225051559.416445-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC3:EE_|PH0PR10MB997642:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ef877dd-d5f3-4bb6-351b-08de742d0f1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|34070700014|1800799024|376014|82310400026|12100799066;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LlEEogUC8Ee5eHmTmA3UwKl5z7tuVPYwM2DQzGJQ3aEjjf0ZHulQvj5XcNBX?=
 =?us-ascii?Q?S5Wm0BiuUGB+SRhWchqR/Rv0HsV/rXmccdA8tjquUZlA865LOljOvS6f0OKy?=
 =?us-ascii?Q?sXJYKC9mCZDwSRPOzbFroSY+qDjAnXD7E24zeJ62TNaRXqlklQPwgEVoTBHi?=
 =?us-ascii?Q?jWQ7eOEMVY6X1M8o755tZpEEJALCw/fNadbv4u2qMnfjFb++V7s8PHOJDm3/?=
 =?us-ascii?Q?vntFOapSD6BCEmuzFA83Y3MrjJOLlbRv7IGsfMSRtFgyrF1y3BLvoG2Q7qxu?=
 =?us-ascii?Q?cXJCixztzxDWNmDLb5KtGeNPxI68fSwOTXx2WkguR2SXHQ2QWcEZQgN+tKZg?=
 =?us-ascii?Q?96qJw9we2S4wiKIVlpDXHb+mkYmuIgusw8k9PMytv9j/FnwM7utfRDTNzIfK?=
 =?us-ascii?Q?8s6CixB152dkK4V0D7V1Qc6dihEadjyNbdBw1olVIexMPFJsdyLZzg/AkWwN?=
 =?us-ascii?Q?0xawoEPu9sxAWOMLEhxOH00B7I9HXysekPJDfVu3HQ5dxhCuCxW/yR6v5bu4?=
 =?us-ascii?Q?FIHeLsU93TSk37xymGjcJVY0XnD0P6HadQAx9Q6YKMmv4AsWXMAkarnoh9h4?=
 =?us-ascii?Q?/owWbxb0+GhIKAsHSBqKfQiXun7DClH64IBI954KOMsusKMKA0BJEnhvpsmu?=
 =?us-ascii?Q?72Y+nK1HvSHHPQSIfT07SnZcHp9AWaDr4rYdmKlLTSc5YuamNt1sD74UVo0f?=
 =?us-ascii?Q?vWzjtlai9w7/fPq1ABUgvfl4LElt5ywuzc9i1izs9Omg3uy5H5teHUzvD961?=
 =?us-ascii?Q?qkNnkIk+yeKPkmusjBuqi/kcFKs3SIkNbpTlm5UV6u0blS2YjadvrX33spFU?=
 =?us-ascii?Q?eK8FxIDZPQXkT8ET20Kf/HgkCntvQNh977QAakXmL8qbBGaceRQdpdD4affn?=
 =?us-ascii?Q?wLpNeqMZ8kKtNti1jTqlX+Yckmt7veHS1LlR4D7bpx0NgLqowtuD7yVZqzDr?=
 =?us-ascii?Q?radX2losbpsxptMUuWKNTlg3uhGREkWRR3Yen9NQnhu9oet0Z1c7yaoUAKtW?=
 =?us-ascii?Q?XMozIGHazqYa6Kr+FbxljNZ6z/gs7dgzKZvqypELkxw8VqnxC4VcDrJpqoQI?=
 =?us-ascii?Q?FGaPRY3CrBJ3GL3e4ReYcTIMsnosu0M8QvCoyd+88SqOyeMlTFQgsc0f9Pff?=
 =?us-ascii?Q?D/n3COqlHt6sbrb18TXSDsjwcYcHrrY8GPBvF2dBxxQ93emXeFd9XXiejpx4?=
 =?us-ascii?Q?fgGqAVkm8ERQQbe8eS7R8dErzU/dSG4OYQsIO79OGJ7a/LhecFw6/wrNK6a+?=
 =?us-ascii?Q?adVdVhj/p3TV/+e1FTL/0Na1n8PLYCcGCD2G5fkAYSMjMBxSKgBGPF7vK6Qe?=
 =?us-ascii?Q?uURTiTxqJ/VrqWYV59gKVW5E+HQA6MiCNAXMqy4+DzWWOyjA5VhAY3TqNP9t?=
 =?us-ascii?Q?cHm4KuRp9hFQsQSO+MxGrvXXv9fn1S5KvMfIaLYCl3fGJIJS5Atl7J6NpUap?=
 =?us-ascii?Q?XD6LfpjnQkG3sT82jZFs5M6Qa6pb3i+yGgTaj6AlQWZyLjERTUb7Fo6VplOe?=
 =?us-ascii?Q?EE8PqRgqnI0rD+nNeCIH/cArd5mS1ABtm56UdYPA1AoW0/0NDviS8a1rzSj0?=
 =?us-ascii?Q?Xk5jO/oQJmLfR++V4d/NoNX9yxIXAyxpnS0GVCGg977o/CUXRM3v2rULw9Dj?=
 =?us-ascii?Q?sx9dYCkWpuhRQyHwkAvMGTQ=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700013)(34070700014)(1800799024)(376014)(82310400026)(12100799066);
 DIR:OUT; SFP:1501; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: u4YTZ0yJNa7TgwY7KDybaiJNe3i17ckR7IZJ/llJDW5gazNQ9xYPfgjCUEsMaqMRUDVOicn3oFihg61//uWD8QplZyCNQjTMq34llz0gid4mfmnj4cldBdpH09s3ATsTX9LK/2icK5OmZktDRNq44AGzhfpFFI9Mg09VRbp3dpfPtj0LOIVSGV0yDNeyLJ8Rf3n1zcMeDLSLH7cmcUitPcVYsmYN9vPszos5in8uXZnRMCrzd7RzfoIUJ651cuivL7tMZOzro254z8zkEEhqDFAhO98AkgSPQXrOBON+IeMeDyNS7xhWFbg+IdzHNQBsDxi0LSoxftltJXhpOlKND+YQ6OeBQ7z8pP3r/ZiOwZH+p8+VFFrhcXoSVtLxvL8Uv438JeQfF2cCwsBmwY9EpqrR7Ol3ojz8LlYZu7RiS5kabP14kii+Ck3v8KvP4gpU
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 05:16:40.8089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef877dd-d5f3-4bb6-351b-08de742d0f1c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997642
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

The CTRL_MMR registers are firewalled at boot time, and TIFS unlock
them as part of the system firmware initialization sequence.

Current code assumes the CTRL_MMR space can be accessible at early
stage of board_init_f execution by unlocking them.

But on HS-SE devices, TIFS takes more time to complete initialization,
and CTRL_MMR registers remains firewalled and not getting unlocked.
Which results in any write to these registers are ignored.

So, move the CTRL_MMR unlock to a point after the TIFS version message is
received, ensuring that the firmware initialization has progressed and
CTRL_MMR can be unlocked successfully.

Fixes: 5e291ee34fd4 ("arch: mach-k3: Introduce basic files to support J722S SoC family")
Reported-by: Diwakar Dhyani <d-dhyani@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
Changelog:
Changes in v2:
- Moved control mmr after tifs version
- updated commit msg
link
v1: https://lore.kernel.org/all/20260223144558.395289-1-u-kumar1@ti.com/

Test logs of v2:
HS-FS: https://gist.github.com/uditkumarti/c66ecbe800b4b3549fec3e505fe26dbf#file-hs_fs
HS-SE: https://gist.github.com/uditkumarti/c66ecbe800b4b3549fec3e505fe26dbf#file-hs_se

 arch/arm/mach-k3/j722s/j722s_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/j722s/j722s_init.c b/arch/arm/mach-k3/j722s/j722s_init.c
index 1180c75f551..32a3eed40d4 100644
--- a/arch/arm/mach-k3/j722s/j722s_init.c
+++ b/arch/arm/mach-k3/j722s/j722s_init.c
@@ -84,8 +84,6 @@ static void k3_spl_init(void)
 	 */
 	store_boot_info_from_rom();
 
-	ctrl_mmr_unlock();
-
 	/* Init DM early */
 	ret = spl_early_init();
 	if (ret)
@@ -151,6 +149,8 @@ static void k3_spl_init(void)
 	/* Output System Firmware version info */
 	k3_sysfw_print_ver();
 
+	ctrl_mmr_unlock();
+
 	/* Output DM Firmware version info */
 	if (IS_ENABLED(CONFIG_ARM64))
 		k3_dm_print_ver();
-- 
2.34.1

