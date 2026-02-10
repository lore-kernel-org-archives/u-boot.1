Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027A1EA3F3E
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 11:02:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1747783CB5;
	Tue, 10 Feb 2026 12:02:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5ojZ2pKv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 348C683CBD; Tue, 10 Feb 2026 12:02:57 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E72868341A
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 12:02:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owklqx0G4o91ykot76KOBJrI15BpvOGg/Z6mqprXtjfncYe/XA6j1ynGxOpccIf6cLqAC0GGNZKp0VWOh3HjQIxEW8UOEmJE7dN0EFsgJ6Hq2iChTNFkzjLZShryzzOedWqyXBQ06SkS36N8AF3/YHk4ookorrwMUy4tXwkVHPzKXlOY7jw7WxTEG2fkOX8FaMJ8H7JTm45fmD1T8Ct4LbwxF9SQd0MagmESblps2DtMkCM/6A7T27dLSUUYXzUt597Y5gubzEA6VFgqwJLbVuYyQHaSGrku07KAkhIyHYk7OJm2AdQGdf5iyENT51V/D2tOsHL6J6Nipfy7USzEvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIb0/Wq2CXzym8XdUZRgnrQE2mIZKjxAz86aETo7+Ms=;
 b=dE+WI+hu7tACRSyzapbYdcuq93xlm000rXJsylvUOhntCI1ojcgbAS/L4dZ9dvfTOGZJ42lbw30HBWAUNRxxVPGCgeI8IeG9Jy+s/WPvw0gnnIBzuQgVeif6clqlEEgAbbHF2P0YfsMyxX+3MCSSJmXPdpoKlHG7tXVDCIwC7J6Qumgers3unOJ5UCd69vJrszerZY7SP018jRLt+R6HeCLYKUuYDULZKvw+3ZeA1rWNVa23GKnq+8Qvb0ppvTOm5QJp4FVVqeQzyPJ38zmQ6ahDFd9E6yypDrq3FyJVj6WXtkEDiUpvuS/+io7bZVlq2ZUUuyOqsBtvQ76mK122uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIb0/Wq2CXzym8XdUZRgnrQE2mIZKjxAz86aETo7+Ms=;
 b=5ojZ2pKvOFK8QwImy/NCHax4Stcn9NEmO82MiioFBQF4fNepIofLVFCzDARBTeKwkvEjWc0hAovQlSxcMcQHe2Mcz31cX5beMb/Bz02YOhB+V57zJ2if4T6GoB0ZrrER4iFk+PlUQb5bmKXNcq53uJuSbwfUeUQDoR9wg3kRaP8=
Received: from BL1PR13CA0305.namprd13.prod.outlook.com (2603:10b6:208:2c1::10)
 by CH0PR12MB8462.namprd12.prod.outlook.com (2603:10b6:610:190::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 11:02:50 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::34) by BL1PR13CA0305.outlook.office365.com
 (2603:10b6:208:2c1::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 11:02:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 11:02:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 10 Feb
 2026 05:02:22 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Feb
 2026 05:02:21 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Feb 2026 05:02:20 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Maheedhar Bollapalli <maheedharsai.bollapalli@amd.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] arm64: versal2: fix GICD/GICR base addresses for Versal Gen 2
Date: Tue, 10 Feb 2026 12:02:06 +0100
Message-ID: <d0bc3fe1af8409fcfe505e55fb7042a33b845a4e.1770721325.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1167; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=sTV0kRYpFlpRFknm9mYVeiHXhqpZj6VFVlNSoxDhw8Y=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWR2CxhWByX82rd4zr4vjDU7oxMPZ6b9miLE2pr6VdBNK
 GXJm39FHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCRH42MDDMeBoe+jzqU131Y
 65TbvS1uVn/rFy4TnNvA8kn6/n53z4eMDIduTi2ayXM2o4Cl5zz7pqe3lr9a2l9YYvIqwKBQTj7
 4GAcA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|CH0PR12MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: fa13092a-da4a-4c46-a926-08de6893ee8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BK6r/fJh1KQRkrB73roJzT6outUA2L8MrZsZjl4myXPEfn2VDp8lwuZAVoZk?=
 =?us-ascii?Q?67xmF2DOfaOxDaAjCBOmlEPhfXGHcK7LjUqE1K3YzYBbBVRUMuQQ1yiLGbtA?=
 =?us-ascii?Q?+rrE5cF6Bvhi/LaWWazFA9AR8zKBCA8FnvOJjP/XarDeHzszv3SQM8p5RT3U?=
 =?us-ascii?Q?I1t+pOl+hy35ssiA82wh3IGLC6copkvmTFOmnMfWpD6iLaJPztZIsC7gmmRl?=
 =?us-ascii?Q?GS2FlicrPZ5F1otue2V6Olo8+VNKdtCJGCrGPOxGNr8clkGGPVsObh6g5xWV?=
 =?us-ascii?Q?OQDFOJc9W8Q7xpj/NHxsEXZBRSkQX2txlZ7QWG3AgiLRiaSHLxfikNYxDmD3?=
 =?us-ascii?Q?LgEfBpVvIkYR1aZkjzlYlHAzE0MdmuQA94Jv2aZ/rKbiBDWAEGf989Y1AWU3?=
 =?us-ascii?Q?ZwXNlxN6iCPHTwmD/buTSZwH7sYvq1Y849s4fgyjeHRUZEQw+qGikH+ehQu1?=
 =?us-ascii?Q?HbELhJvPOsCCKX3BVyjwWjwysRfIrYskOtG9DGN+N5iJrSE08kDXiajXe/IV?=
 =?us-ascii?Q?4HnYN5Y+EnDqe+vFj9kcu1lA9ttgpuUZH9t9cd0D/kYLtKa+Ch3ZT21Vutve?=
 =?us-ascii?Q?VePh3nfIAvthzJU69Twaq+M4Y+Rq2cKRE/AJJNzO4aoKJ9IjLUkm42ECYt+G?=
 =?us-ascii?Q?PYi/ztLK6BpaFtl52yxyU62gHquewWr8sW029cOGlKXblAqv7ZjETvbyUkC+?=
 =?us-ascii?Q?JwZgIj1A+/fp9VuZ5KuIxi2evlK5j5vjip0wRIpXl929bgMA6vXWpxVjKQ/S?=
 =?us-ascii?Q?Xs/MRmCfna386CpFerVXYc7wSJP8CeQd05q2QeiWpHThCeF8goNpRL/jZiN6?=
 =?us-ascii?Q?V0Wvh2VFKHz0CG92pYBB2wd3BxIabjRV9O/kQtH24Zhp2qBrp8tySkVmPLLY?=
 =?us-ascii?Q?kGNqfhz47lTAK2b7HPCAYYglI5/RE5ZGty+4RqDmMP70keUefFZOtzEhgJ0E?=
 =?us-ascii?Q?n7S1B0XrcogYknHfgSyNDpWtjzIuWcCsN3v5btSAvddAWwGBR7ukWxJkuz8/?=
 =?us-ascii?Q?3zVuYwrZy76kWOehJm7NU+2twiuoKUJPHt78FjL7A4JfQyFeCs+CzYX4isCO?=
 =?us-ascii?Q?iHjhZebldNfgorDp9qf7sc3Bw58Vo4ZjWtKTrOTDYDaKZaJ/zIH7dMPFzk/3?=
 =?us-ascii?Q?oKKUWVU8UpfyANLlyMynExpP/hIqgbbQXmxV9gSoyWf3wViLjpsqHsdIswVo?=
 =?us-ascii?Q?xJBZwBwz9IvQkgLfaQB0G/3UXuR8Xm3x9Xik3Aq95cbzM7JM6bCd6E6yGB+v?=
 =?us-ascii?Q?YUCf2YrWslT9frt1qxuacxba/Jwm2m+b9tP2BXvnuWx0oBmLbJKt8s00vTvF?=
 =?us-ascii?Q?QppoqbLbEJFZYuvUb0U+kGBtHdGCNOFM6aerh5x+PddO2d3gQin7Ov2DH798?=
 =?us-ascii?Q?66FskmTOG2TtikZXaygSZ0rYDHP1d6OUE3UwDxaoy2lo4JICr211QLMrf0ft?=
 =?us-ascii?Q?UwGDrWtC5tPKd71IWwwlnMDS+LzXlam+mcDOvxnF9/O1zmnK4c5J58mEx5MX?=
 =?us-ascii?Q?2O+Jzwo4TDC8FPgtP5oHha8QAX3VFXrdiCtYdPB8eDr4fq/JfcZHM0HoCJp6?=
 =?us-ascii?Q?48zsk+xomgalkOECKcEh5/UxCZFXA3XoYFxexSrJQY155yjhLb6c33g98p+i?=
 =?us-ascii?Q?vmu0OGuHPp0aS0f4l/hMpCI1SijgEvaEikBQb6gWL4OxguHGxMb3SFZBBPVU?=
 =?us-ascii?Q?IfWxeg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZdGTDeiDge1DviIGfRIPoIuLibf0kmUoujteHVK/XhI6StaPxmQiImmgxDu7od6v1WoywcilWksxYa3bMG9lnjSgNRcjmjcIGYG748SHhXRu/DsfFYE8VpV/6OubmOnYSdLJAeNELKOOo4O4im16HUYeUzVzAlsNDSmZq6978cGoO8xbs9edn6KJ5qHV5p0PpVtzNj+jOsUpW7WS+/LqpkX7c700IKiYDqxFm04UZ9fb4qmUtS546PWf7CAoWvgDUD/zC1Rx1+rEZPFTJbd+37nemCCogoUc/HaDRMECbURNJbaQbtHkwO57aUIHaRUD8YBNEgxcj7VaRRCM/8U0d4g4HJXEhPs9EfJuBa8zWdtrWmIdyAxfmXTyX27zxqyW8GyfFahrfFGcxpmupGT+3faF6YpXJnDLzsZ3Q4yHDMCsabR2iuykmcQzu+9ufcRi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 11:02:50.4700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa13092a-da4a-4c46-a926-08de6893ee8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8462
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

From: Maheedhar Bollapalli <maheedharsai.bollapalli@amd.com>

Versal2 was using wrong GIC base mappings, causing GICR_TYPER reads to
not match EL1 MPIDR. This led U-Boot to walk beyond the per-CPU GICR
frames, access out-of-range addresses, and hit a synchronous exception
during early gic init percpu while booting up on alternate core
i.e., non cpu0.

Update Versal Gen 2 headers to the correct Versal Gen 2 bases.

Signed-off-by: Maheedhar Bollapalli <maheedharsai.bollapalli@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 include/configs/amd_versal2.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/configs/amd_versal2.h b/include/configs/amd_versal2.h
index 05ddd4eabe16..404af2cd4c65 100644
--- a/include/configs/amd_versal2.h
+++ b/include/configs/amd_versal2.h
@@ -16,8 +16,8 @@
 /* #define CONFIG_ARMV8_SWITCH_TO_EL1 */
 
 /* Generic Interrupt Controller Definitions */
-#define GICD_BASE	0xF9000000
-#define GICR_BASE	0xF9060000
+#define GICD_BASE	0xe2000000
+#define GICR_BASE	0xe2060000
 
 /* Serial setup */
 #define CFG_SYS_BAUDRATE_TABLE \
-- 
2.43.0

base-commit: 981c38dcbf357e8929a0c95fbd34cfc310fb6cd3
branch: debian-sent3
