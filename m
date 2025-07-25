Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037F0C87FCE
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 12:03:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 198A38396C;
	Fri, 25 Jul 2025 14:02:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yy6YVDe5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1863B83959; Fri, 25 Jul 2025 14:02:48 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::61f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC8B38393F
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 14:02:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+BnH4ih8SnHWr07iPRs5UCJIHclg2IW5DuPY1uZ8JDijqX5izFuFj8uVRY/C3d0aowHlj3epaovArjMCYpHDS1Nz6ZYAgmdnMCotpXtJA0jSUwjNZKPFWfOxPLxt/UGSUl/6FbapELJQ7AErCQUKAWPp92VulurtcHttz24sCrwRXysiF+Ucokt+9UZ6hCYJMxnK6xD6Lu59Kifq4I0tR232G3mAmQcXGaT0ztFWRavd+OihHLOr3DiaCPPzXwMMKJJAaHnfvlOuz56B2CgP1Dj4MsXiSo3Ef2+xFn+KYdfuPDWnQFih5RzLGRTGMniZc6C8Ole7bzRMSB7hHXs5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFe0iENctIWqBtfnt6dO/hPPbuoJ5wkMm5JzsBIe2Qc=;
 b=fYosUifA7LRQ2Xwa7gUeplC9xnbBhLcxrsvQkq6yNvBmcfYzR8LpChVGq7MQ0CscOiT2FrypRfgOVCDcF6B2JGKAr36nRYx7joJJPLCPGyOGMo6RU4I3EaWpt8RX2BjPpSddAdEz30wGsp6NtgjOw1lN8q+wJJo+/n5YUerHhWbL9L0xhljdelizEPvodfS64NRSsKK7V1sOZRUR4YVjWLtXE4B3cKzcjx4RkNyu4n5EN0sJy2tDAC/0WOeXmnbdIMG7Fz06YqA5ZnPFU0XmkTox+sjQpFFdZKDR+5APGDWRntOiwpEeyp3bIYd3tKRZ1A5yXSLLLGKQaOZhkBrXcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFe0iENctIWqBtfnt6dO/hPPbuoJ5wkMm5JzsBIe2Qc=;
 b=Yy6YVDe5L5WPufTrPEuzJqmbJ61XZg/YXPYqepho8UFcfUhmmztCBJ9Vq7S3TwFE70azyEgi3QlVtDDxZhUB61zCihkrABjPs8hJwppR3LiX49hUcZ84v79uMK9pIXUvzgaCDOkLM7i1Ra6Z0IP5e4HvNhfzt4c71xM3p1sUEDM=
Received: from DS7PR03CA0201.namprd03.prod.outlook.com (2603:10b6:5:3b6::26)
 by LV2PR12MB5775.namprd12.prod.outlook.com (2603:10b6:408:179::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 12:02:42 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::38) by DS7PR03CA0201.outlook.office365.com
 (2603:10b6:5:3b6::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.23 via Frontend Transport; Fri,
 25 Jul 2025 12:02:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 12:02:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 07:01:35 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 07:01:29 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 25 Jul 2025 07:01:28 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Casey Connolly <casey.connolly@linaro.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] mailbox: zynqmp-ipi: Mark zynqmp_ipi_dest_mbox_ops as
 const
Date: Fri, 25 Jul 2025 14:01:21 +0200
Message-ID: <b7e5dc8841f6e904a7365f2ed45248609c007ddd.1753444878.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <92eb9e90189d8b96246966633478662076da7185.1753444878.git.michal.simek@amd.com>
References: <92eb9e90189d8b96246966633478662076da7185.1753444878.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=876; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=8ye0SuIWW5bX/HB1IeEewGB9z83b2NklyA5YlOQAJww=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ0FwnJWK56XDq999d0kZ2tC5m6uRPOXGh3nrUvfMnV1
 Qc8A3w9O0pZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAiO7IY/or/PBY5tf7BxRm7
 SkV29p7RNirn6HVqYTTTtKyVjWUxO8rwV3CWem594t65Ra21e2auUnul8VYpzt6hZN6DsAOsG9I
 XsgAA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|LV2PR12MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e9e293f-aa06-4675-8677-08ddcb7327dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v2sOADqJ3Y100zSkmmDUDfruzcf9yQugU4ooadkBmvbT3UqqALqoC+6U/AAX?=
 =?us-ascii?Q?gSKHF8IZrcjWEXAR8DpaZuAsg9QUs2d/ioSng9TNrfDGnY3IH9fiTwc8IXyS?=
 =?us-ascii?Q?/KIuPgb1E/ZwPYoaJiMFuM8a0niC4JiBXzCwQV787OX9Q1FNOAimkMQyetbu?=
 =?us-ascii?Q?7tFqU/MlIL3kHbHIldtldRN0MTqaUm0VjfDzVPl8nCQ25mkm0o3q0hM1dnZA?=
 =?us-ascii?Q?DfaZbg7Uaf2DSDYxhatNcZuVNIfS17KTymEXrKxOdInu2VI4TjbwXMYlkpzc?=
 =?us-ascii?Q?4eC1pgC8IcwMN9XNT4xtEWWj2qTu17PgpTluT8Uo8IZjaR8aOwl9xBylKWIX?=
 =?us-ascii?Q?M2pTZFhE4iCZDeOgtj04Vu93DW/hV7brRcaNpyHZ3/BsT06NF90B7D5E7jwB?=
 =?us-ascii?Q?+XgaGvlrtGIeLbrzEznybLhxSkBXltu1o4jMMFOjd+lNGzfAK8Vbar5BoUPu?=
 =?us-ascii?Q?T3ZzNWnC7xkG0zpmPRuXcZTVk8obFs9e2Oqv7hEXfPYwzjXYfacPyWzFDlT5?=
 =?us-ascii?Q?G6TWYeptOPY9Imb5vUqCCgiXUC1WStcRixCsRjdizFnlDwIu7Q3EZb6sOkFM?=
 =?us-ascii?Q?92gz/we+Cq+Ti50VFusQ0AESBdn0eKbRpGhZ5SWlpp+lo6o5dEXW19abagsh?=
 =?us-ascii?Q?wdqtMUH/035pzF5oFS3MSOxaFdKYYhQGWbMq7BnjRkz+HcpA5iPLAN16D5l5?=
 =?us-ascii?Q?YyaQfLPvyGEsViZ4iSZA669zZd1rjdZ28qQcTidnGYoWYgGx8n9pmab+cjob?=
 =?us-ascii?Q?vyXefU4d2c7EIM4IvIXo0dSEhfYGU+QaXE7gMTsJdpDYmpu6MDxu067kMaT+?=
 =?us-ascii?Q?ggtogdwR1y0fB1xj3768o1FZytOLxCMz5LzTrao0mi3HbzSC/tTft+hWr6YX?=
 =?us-ascii?Q?nSaOr5Jd8Pt15qODckwIIIaIH67I7BheENtXBfOWzr1ozlYz4Dc3mWGRC23/?=
 =?us-ascii?Q?7/A+yCFhokvCzGc1CryQQ4n4DHTU9mJuh9DuPD2DOpjhyh8cYJVZAl/k7vA6?=
 =?us-ascii?Q?jwqj+mSsRiodNsBVytwsMUgVMVUEPYA8GJ05oovL4FIFhFu33cSDEJ4dTCnh?=
 =?us-ascii?Q?fXXuroxWAshBWB8DVcq5ANjOgKB9xvPJaee2xP8z5GvdnBxnn+RJWK4B/p/w?=
 =?us-ascii?Q?KkihO9bRx6fMBbdWc39YUbYnwsZJU4jBi5NpoFP8xLyRf5XSGFGAvZlywjRT?=
 =?us-ascii?Q?PtzoWzWvWPHMgyspIShORysjDSnUWLywErEkJC385EZ387uKFXNfOjG6MRtz?=
 =?us-ascii?Q?m0e4MJ1l/YrbSb7Hhi3XZDkYm4oBSoOa1dIsOsFJSSF2RjTXf/LhiF+D8k8N?=
 =?us-ascii?Q?LyelB+8v6Ba7xUij4N/MUGexR80xBP6PL4Ud1vfn8f99HlVp2izQHvwL0eN/?=
 =?us-ascii?Q?5ssfE5zqLx2t8ljVX2BXEYITNJInehWeayxZFp/U7K4weROlV5VKh6Q3LY8x?=
 =?us-ascii?Q?iqT96R43rHTvILG4iR9PQfK+X+nVWLPw8z8KV4VVd0OiaJGW7gqGhGx4niRZ?=
 =?us-ascii?Q?VH20XT7Nox29jByUPHhP/GKt7x9GJ0YP0vrF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:02:40.6162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e9e293f-aa06-4675-8677-08ddcb7327dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5775
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

Operations are not changing that's why mark them as const which ensure that
structure will be moved from .data section to .rodata section.
Also mark them as static because they are not used out of this file.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/mailbox/zynqmp-ipi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/zynqmp-ipi.c b/drivers/mailbox/zynqmp-ipi.c
index 851aa737c03e..7016653ddfe1 100644
--- a/drivers/mailbox/zynqmp-ipi.c
+++ b/drivers/mailbox/zynqmp-ipi.c
@@ -241,7 +241,7 @@ static int zynqmp_ipi_probe(struct udevice *dev)
 	return 0;
 };
 
-struct mbox_ops zynqmp_ipi_dest_mbox_ops = {
+static const struct mbox_ops zynqmp_ipi_dest_mbox_ops = {
 	.send = zynqmp_ipi_send,
 	.recv = zynqmp_ipi_recv,
 };
-- 
2.43.0

base-commit: 7178360d325a7ea5356b993a7f4156e4e1e80719
