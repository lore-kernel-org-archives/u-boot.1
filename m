Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F8DCAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 09:34:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31E8F828A2;
	Thu,  2 Oct 2025 11:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q1j1Tv1O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60340834D4; Thu,  2 Oct 2025 11:34:49 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E30C080107
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 11:34:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVDoKVzq/YLItaQ21vszxVSNItEsNW8ObQWf+KVoolFDDi7JBJK6RsuH4tENZuxycMaz227fbmLoPlWKtOPSJaPX6AuM5kIah6Q9BUhzKGwoaNcaqJ8GjqmLmZeWD6rrEbkz884NqO+gwSCys4/SmbIqQtGfw4dJt83pi0UdRVcPmNr+svszHe9fAKxK5ZT1yfN2144HUsXIZoolcRzGcXqEDpnmBtfkwpElYSUWJ6Trqx7iPZ8an1B3J30jRVRXBB+P9q3p2y8RlClUStApLpeswTntD2yNCG09Zez5vjGfg5m4HtGcB3uIPHZSOunj3b5N4BLZfOfFz42VpfSneQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTKvqngDNy2oGR3G1DRW4XbvFpob2wSMujYJYVAqh64=;
 b=gzo/MPhzFvmotkJWFlITg/kddR0kg22KppBfR1wEaaF7i0t3zFcKzzPRI9pxvPvmoSsRJjDeJr9V1t8mezStBT/p6f8Yy8RgS/NQjZYFCMsiPCdNjV7RfZAWpFpHF9YzMoRIUANpT80eUEPpV9vxcMZS+8rqGXrcZx+L7K5LaVWU1I15JOKK8KCnkNAwUzmxoUYfe1p6V928Tw5OcpJPf1swTO7rjq/Lr3+vMGOrKnR1iNaPIpueTVLcFZdjMAblHZfyNVmyRlR3WkDq1SYKzn+R74V/xvpsFXfYRmvEjp8RmV+GIfFWswAaCFxHm12g8vWXEKC9FG4y8WGoHWAIQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTKvqngDNy2oGR3G1DRW4XbvFpob2wSMujYJYVAqh64=;
 b=q1j1Tv1OFqV2tNPRKcdOSqfDL6dfjBNWgFcX30ovFVe/JxVoDvD2gq9wYII273hT0EaDv7mpjRh/dpc65ERQAGIuRxM1layP5MXXae5QjbCbuukZ4WgZVNj348AZZaXHBZO3mVV4aDM0Z8Du3oXYGPXtWI4ZqZyl3hv7QW7TqJg=
Received: from SJ0PR05CA0086.namprd05.prod.outlook.com (2603:10b6:a03:332::31)
 by SA0PR12MB7478.namprd12.prod.outlook.com (2603:10b6:806:24b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Thu, 2 Oct
 2025 09:34:41 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::5f) by SJ0PR05CA0086.outlook.office365.com
 (2603:10b6:a03:332::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.13 via Frontend Transport; Thu,
 2 Oct 2025 09:34:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 09:34:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 2 Oct
 2025 02:34:40 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Oct
 2025 04:34:38 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Oct 2025 02:34:38 -0700
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, Marek Vasut <marex@denx.de>, "Tom
 Rini" <trini@konsulko.com>, <e@freeshell.de>
CC: Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4] env: spi: Fix gd->env_valid for the first write
Date: Thu, 2 Oct 2025 11:34:35 +0200
Message-ID: <803db0f01d568fcf702368a64eed007bde1d8bf8.1759397673.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2458; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=ETq1zCncdNeSGyE9sEBWbQ6RpFo3hPIHXKwIJgpbd08=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTcc9fh0LzyVHjRxJeHtz71Nf/yItz4ZyhXn6Zxu//72
 W8MS8yZOkpZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAiO0IYGa601rKz29UdE3pz
 POm6UP32sojK2V4rN62PfJOosH7qb1tGhiMZ4srBoe/n2NybyBIkLaShuzL/dlK5TPmV7Y/dEy+
 sZAEA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|SA0PR12MB7478:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f17a10f-74ec-4d0a-c2fa-08de0196e9ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LC3oDF2rU1swU2GtLo4Br7MEWedwo16oxr+q5jWjEj4psD9XOmB9i5EITH2x?=
 =?us-ascii?Q?6LDX+Wt2zzDQ20pVAQjI1fqHa0bCZ6j8YsfgTl4Fsmouy1lGPCi7bpymmYhj?=
 =?us-ascii?Q?P6xiURCzOMIW+oZa86YAfqmCxjFO3ab2wFkkyJY5ZhDQCGenZAZpqV3h0qRf?=
 =?us-ascii?Q?NQjRHQ45Ibii7Qe99/mySWThy4Aeh6mUral1OQbB6BoaLuIPtCJQrDuxw/Qc?=
 =?us-ascii?Q?LEwc/J9WQeC9giOPt3dVasAXhVSkT9j9f7uI3R8wxkS6/LUmzqA3aHzBZCgE?=
 =?us-ascii?Q?AyVLzt6s0Tz3seCWLkF0+8+jDrCjry51r8JHkFPNnQdXP3Q7CQlgjauZDg2B?=
 =?us-ascii?Q?HgMtODqe2mG1F601JlvthIZ6bye55lh9Zn/A9T5KYRO35TdPF+AThbzQjb0/?=
 =?us-ascii?Q?8gvEt2HqWoHADxQYZod+Y4UQyWSgk3v4lX4iXa8yHpBOTm/sOFm/lT+Wdiuy?=
 =?us-ascii?Q?CaSoQXBa+dhCf7t0omzhKrRHyfKyi5uG6npbSSqUQtiN6jZsZ8G4Pe+DEyVE?=
 =?us-ascii?Q?GmO2p+37Inh3BNtjISI836dKtofO9hxsarm7fWLgT70X7pnocqCwQczPqPdW?=
 =?us-ascii?Q?f1rzqDn1xjkHRYB0kk79nNQbB5RUCQhwvOy6T3wChiv7PDkoQTEG04KJ5C9N?=
 =?us-ascii?Q?Jv1FU4b74byJSOqe/zizfbXX9Th711fOHf5DPgQ0X/HbsGnWIaXzxAcZqR6t?=
 =?us-ascii?Q?+9seQKhguq5ylWdo3NAyNEJL3wkwmTZvJGBv24hF1upe94B8/CqAjuYGzFM9?=
 =?us-ascii?Q?LDcdAhhMBKf7A07Jkauiy4n6E+ga2gdA6q7GtRzbxz+4UXnRrOA/RPhl/e+h?=
 =?us-ascii?Q?KdEpz4/5nqKaz8u8QCDioFJBmmx+3Qux1nu2wcdCvW5HTtm5GlEPHoZth3At?=
 =?us-ascii?Q?dAvljZVWqA0igy2SVTvC8fhGAflZz24PtAhepgDP6gduc9E/7woXIEqcjHgp?=
 =?us-ascii?Q?TEjV+uI7kY7vWFfEvEApCvPv2JgLHNKRQ4zuBNH+RttImsdMQjXJJpGrkxKU?=
 =?us-ascii?Q?82GgdPd8Cu3junYTBacGACQ6zs6ERHOsBVgc+oiG9dKk994+OANak11e+lp4?=
 =?us-ascii?Q?tRYFOlvfBgbkrC6LZ1/fSxigyscN/FRduNRQMRNatyxivzbEx2VDEr2zHQNX?=
 =?us-ascii?Q?lJvJ73Cx8gOLzP4xikzlgp0IDmt2d+geFsKSTZaha9JmD/7nrELwmBlzlllQ?=
 =?us-ascii?Q?ZnXo3z9SaAW34NT48+poIjuXkDA90/PV6BbV16vDRkZa5mQMnEz9OZytFlUW?=
 =?us-ascii?Q?C6z5vtIeacJeFNPfvdf+hwMs8CkeiZpxlSTValJGz3rHIth6cXFTAzCpZ1IB?=
 =?us-ascii?Q?nOj/ZiZze39mDNLLmbUO+0PLORQOXMTU7f135SnyfpOEy55tdy0USDKRA9RK?=
 =?us-ascii?Q?TdjZiuyQlS/mdxtDNcq0Zdo/lXyyKGp42X4BXR2EaJBbOPcmRoISVrlcP2Pw?=
 =?us-ascii?Q?1CPjCmMVA5EektTu0LJGfEVEKcZS5sdiW3s3bTHoRwX1k6EaFxUVjhU82IBC?=
 =?us-ascii?Q?Gh5AkRVsHJre0EBwcwg8iBtJV5lH61JcIAg8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 09:34:40.9198 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f17a10f-74ec-4d0a-c2fa-08de0196e9ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7478
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

Update the environment location selection logic to perform round-robin
selection of the environment location based on whether the last write from
a call to saveenv was to the primary or redundant location. Ensure the
initial call to saveenv correctly sets ENV_VALID so the subsequent calls to
saveenv follow the round-robin pattern as expected. This keeps
gd->env_valid consistent with the actual storage location and fixes the
sequence from the very first write.

Prior to this fix the round-robin assignment of locations would begin only
after the second call to saveenv.

With this change, the "Valid environment" printout correctly reflects
the active location after each save, and round-robin switching between
primary and redundant locations works as intended from the start.

This corrects the existing behavior that when both SPI environment
locations are invalid (gd->env_valid == ENV_INVALID), updating
gd->env_valid is incorrectly assigned as ENV_REDUND and allowed the
subsequent call to saveenv to target the same location as the first call.

Note that data write operations are not duplicated or striped between
locations for any single call to saveenv. The location switching is
being done between completed saveenv operations.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v4:
- Polish commit message again
- Marek: I have removed your tag because description has changed. Feel free
  to send it again on this version.

Changes in v3:
- Polish commit message

Changes in v2:
- Simplify commit message

v1: https://lore.kernel.org/r/03aa59f72f47fe0ecafd1e1ca52cbb8a5a8f0446.1755613540.git.michal.simek@amd.com
v2: https://lore.kernel.org/r/7a6ffee423f45507af680c63a86cc50fb9e3a5df.1757489188.git.michal.simek@amd.com
v3: https://lore.kernel.org/r/7a6ffee423f45507af680c63a86cc50fb9e3a5df.1757489188.git.michal.simek@amd.com
---
 env/sf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/env/sf.c b/env/sf.c
index 0b70e18b9afa..0e27a020643e 100644
--- a/env/sf.c
+++ b/env/sf.c
@@ -148,7 +148,7 @@ static int env_sf_save(void)
 
 	puts("done\n");
 
-	gd->env_valid = gd->env_valid == ENV_REDUND ? ENV_VALID : ENV_REDUND;
+	gd->env_valid = gd->env_valid == ENV_VALID ? ENV_REDUND : ENV_VALID;
 
 	printf("Valid environment: %d\n", (int)gd->env_valid);
 
-- 
2.43.0

base-commit: cf8e61f78690f9081f335180607eabdca9970a4f
branch: debian-sent3
