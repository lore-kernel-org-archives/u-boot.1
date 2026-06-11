Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58057CD98CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 12:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6145839A8;
	Thu, 11 Jun 2026 14:10:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kj/wd2oe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45F708407D; Thu, 11 Jun 2026 14:10:42 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9563F838D7
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 14:10:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBdl6cNzTzFZZyAhTyqiO2s9lWg7+6k8nhAp9y57n3evYZeLR2uuWuK0P9z22NihL5zd2oYuyqI8ohH2+IekOc9zcCw3X4NXVfNoKZcQJR/GWpU8bBpUY9N4wwncHhA3Gh/9542oWYheb+DcKrI7GJ/9N+grUrM8xdJzc3O0dbgpGeP9k7Vhck9Wmn8bVDKS2FxJPnyUqjljFLzda7P3VUdkbnb9/ee+x+0c8olDqdIFzfRSAmOh3z87hdNfiXt36n+Fi/icbfm3CozK3xNqbbuP8scDQ2pcnhRQRmu9mfoKT05UxDoZWDKiW0PPgF/r6nb8FFrIJxYIx1HPw2Wynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmZnQalvW/UWI7nVH4w48VI6mLHAQchFKw95piXuJ3s=;
 b=oMZLBznD7syDd1s4uyO2kS6VNfrfadpsbhWJm/tWX1AWMreeM2iXgE3Z1Sp3m0o2avmUzsZKka/uzLO8LLA6Dst7blwSy61SXjaeSU0c9TZWVTn3X0Qc834vN1CQSL2o8WNShKiPFDFvJ0KXdkdMR7paNF4R325WezJ4eOG2gMF/YIVforUK5JApFvYdBcN5qp1bv9hvWOVxk05gRezvkhSuTEWKX6+rF3hKwmC9/PfoCCqW99ste4yi3zHn16A1x7vACznrOyX8K9TJR8DfVsCgTQ2q3Nc/zUw/GjuZqkrbPjjC+u8/n3cq2vM7lS/05hnhz53hPwLpcy+XQZXOHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmZnQalvW/UWI7nVH4w48VI6mLHAQchFKw95piXuJ3s=;
 b=kj/wd2oer6tst/PlCI+g5pyZ7LMPXGF0nHo1VrwmdX1o8EFb3Ea2GKLHqJ3+A1BGBEjwuzl7Nyx3iDszBcCC6UvvMt/Bl8wCJ0bPrVIoErqGarDeLg6Lq9JkuY8kwwkz8Iw+7dno4aR7N5uPtoXpPMCUW4D1mcSsw8DkwVq80ks=
Received: from DM6PR02CA0141.namprd02.prod.outlook.com (2603:10b6:5:332::8) by
 LV2PR12MB999071.namprd12.prod.outlook.com (2603:10b6:408:352::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 12:10:36 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:332:cafe::6d) by DM6PR02CA0141.outlook.office365.com
 (2603:10b6:5:332::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Thu,
 11 Jun 2026 12:10:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 12:10:35 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 07:10:33 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 07:10:32 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 11 Jun 2026 07:10:32 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Pranav Sanwal <pranav.sanwal@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] arm64: versal2: Drop static DDR MMU mappings
Date: Thu, 11 Jun 2026 14:10:25 +0200
Message-ID: <156e48d8228acfeba8866618038b48cd51490ea7.1781179823.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1575; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=L9GYyJxAvQFWavbqXcmjRcnJyNLV4a4q9AZa5Z9DzPU=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRpLd20+3Ze17x192anrel8tzj5mvrE1u8Ms//sUrz+z
 6nxcNkmk45SFgYxDgZZMUWW6Uw6Dmu+XVsqtjwyH2YOKxPIEAYuTgGYyDI1RoYz28RVynR37f45
 p3mziUN3ZyPbjpwqRvl1hc81fkdXv/NkZJi/dOqbhmy+h4fkSk7wVeRa31yRvn7V5Z61nkonZJT
 3nGcBAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|LV2PR12MB999071:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d9e14a8-f449-43ee-adf3-08dec7b2718c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: XISVJ7nxsw+P2RSxcLCrbkzk3ysoJcUfPZMZ0Et1t8GdL+9jFJFYXY5XIC3f0wMoULRov09KJoi9+2RRt1beia7sQlD68MioVz9iDABUb0dDAMHjUhinm9QFfrPtB7SoqFjxNN7ytVy86sKfXd2HjNFCNlbQfBrhO7+y/+5cWquXIMSqsnxDQqq1ELtM28uTzU/AZlCTUBTqfbjVy8/ieOgrfRcD2ondbpLx1Dx8iYmkEetx6Sg2/vZH9KvFsomLe5BLawkXqNh85tI9jZ8bwrqVGhLXBTrWw4oyq0KMBTM939VzHmOO2gkkxBtZF91wItJn68yA1VxhVHlgcwO3jyVs2kItFrq9r2HhMaVYwroMfJxKF/VG/jCHYXcXKz2RCxkrG3PgMSJHQ0dszJUOCiINbPvMrizgMCGmRlxawB6acxIRHk89nV9wlG/vg2EeyLbZNl8i7fEKSd1gPH+FQXGYnUzdI4ZrszhM48F6w9ujN2LJxQ3GqMOSvodfgg2StYSnHbzCnRMDGOH2EzNBTASFGxw55pihzkuKGlh1z51f/MUzroDGJFiDYS4+WyKFNAoYJERtZ2MCiB1D4jJoaGY2iyzuvuRdJcOF28oK2j2pW0KJQ06CW4EG2+oBXxThM6LPTUDYMVvnX3oxw3P/7DazFCyCOo9oWNzJv7j663pH6lUm+865JPKLvr4KyhlgW+75D8tJG1agyeGMODH+lW/D2lPfdwiJeIYm3JxgpFs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ccmakyH61qMcj1bC2x8PG+aGPTEVBOXi2FsXGr2eSBAnQyQ9LZwDBeIMY6nTNq1D+YmcCDK+wMTV6oB+/+KZUeEno0aSY3oIThTR9Ld5DDqQY/IXrB7Irwsb0sJenNIr0Tws7hbH0hjBf1O8OPQttxCfBqMGdolXKhyrZu/81Unf8r44FJfXcHrWSR7oyMR0Cu5EV0Pm54wbN4rzjv7qdim8p5UMCxTVNqRZBDr9PYHmmWLa9VjJJffbTZCZpPuILoMMiOems6A5d4jjPFubYIUGq91x+h7LPEeLVY9ZNuKjuUz/pcXC4AdSePgrwP/B3v43u1JdDHDDSsuEy1faTyJsml2m3g9NMTLqN1K+TaXb+27juOVK/iIysYoZh7n1CIsG2+tbzbnReFQLjGMTYCB2ayQIYENUGrGbiNHIzGv/9nLNj6yusdXT5p3kPAcJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 12:10:35.5812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9e14a8-f449-43ee-adf3-08dec7b2718c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999071
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

DDR coverage is already populated later from the DRAM banks discovered by
mem_map_fill(). Drop the stale static mappings so the MMU table matches
address map more closely.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-versal2/cpu.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-versal2/cpu.c b/arch/arm/mach-versal2/cpu.c
index 3f3bfc949360..f5db0660ad54 100644
--- a/arch/arm/mach-versal2/cpu.c
+++ b/arch/arm/mach-versal2/cpu.c
@@ -27,9 +27,9 @@
 DECLARE_GLOBAL_DATA_PTR;
 
 #if CONFIG_IS_ENABLED(PCIE_DW_AMD)
-#define VERSAL2_MEM_MAP_USED	6
+#define VERSAL2_MEM_MAP_USED	4
 #else
-#define VERSAL2_MEM_MAP_USED	5
+#define VERSAL2_MEM_MAP_USED	3
 #endif
 
 #define DRAM_BANKS CONFIG_NR_DRAM_BANKS
@@ -59,19 +59,6 @@ static struct mm_region versal2_mem_map[VERSAL2_MEM_MAP_MAX] = {
 		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
-		.virt = 0x600000000UL,
-		.phys = 0x600000000UL,
-		.size = 0x800000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
-			 PTE_BLOCK_INNER_SHARE
-	}, {
-		.virt = 0xe00000000UL,
-		.phys = 0xe00000000UL,
-		.size = 0xf200000000UL,
-		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
-			 PTE_BLOCK_NON_SHARE |
-			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
 #if CONFIG_IS_ENABLED(PCIE_DW_AMD)
 	}, {
 		/* PCIe DBI (1 MB) and config space (255 MB) are contiguous */
-- 
2.43.0

base-commit: 19d429b48dc3eaea37494e69313d58ba1c1da24e
branch: debian-sent3
