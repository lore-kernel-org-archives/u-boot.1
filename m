Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B0CC54F5F
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 07:25:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54AA983D17;
	Fri, 20 Feb 2026 08:25:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WFokgNQT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 860CC83D2E; Fri, 20 Feb 2026 08:25:26 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18E6083AA9
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 08:25:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xp7ZyuiKEoz3eGUJ4Ub7k9fQYQcq3MNg3kcn7dZVFz9GbUzKjQ7rPGFZjO2qdlr3xd/EFNrepJ8rOy2Z0/t8EqJjz1mNfSANV9O9MsLAMJRgp1xXWLUV+w/siYyi6bsrI+Y8JnVuep+ZeQPeVbvAfvIovzf6BzJ6Te/w4x3BH0G6qg0YbCh/EsMTzpWX2PWYB1Gh5zbhKxuEQePjwCjlKDz4VyXbloq0Lq9Dph90UfbpOV+srJoXJEC1STJsOnlBW7OHDe9o8TNfJX6yiRXvRLo9UxJ3oST2aisOzZNQH+w1oPgAI55tNATx5VzMCUeB2iJufZnBoZ1weCb5FZnDPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pV6f8hOTx50BFMjN9VnRgVa0PgXbbLyKMO0Nn8hg98=;
 b=jlHmzSvkS1W6zF7Npyrg1YJWWfpTVycn29tXiYfqz5Ef2LCZZj4nzPsFgXI95wh3CCiwUOaxLsVqg2S1j89KPIX2+PeIB7jPcp5eRE7o4uQ3UEW70pnNBUQGQEVTCRPPAtw+jTs1eicBvO1tU0wWGAfJbKCXVePBR3wg7xP77OkY6QNy3ASy+ASu60D+YvkHGU3r0dNJBBlNJ56G/a8gtLjSon7cZm7MVf2A7xN9AIq+myd/FMVLVcP+HLOeGcdrtenGGK7Vm5LTLgvgN75TfwMLP7QBmPQj2YBNNAqsLW0l1hzXOaY/myOyIMtKr0ejcuQ+RRwwVWrA6LN7c4LOZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pV6f8hOTx50BFMjN9VnRgVa0PgXbbLyKMO0Nn8hg98=;
 b=WFokgNQTthYf2VifbtUwvleFm/2gl9PBZHHi2Bq+JDtCq2xYUeb4cQPo8VYLWmda1eJOfoB8J9x73kku+JgZXTeS3p0wI0QD32UQ0AegdGH2w2Nso+M7KeiMGaZo6YpsBFjuRxYWOT+Qm5tZo0DyVY+F9y0A+O7FR2xNuXzb1wg=
Received: from BY3PR05CA0030.namprd05.prod.outlook.com (2603:10b6:a03:254::35)
 by MW4PR10MB6420.namprd10.prod.outlook.com (2603:10b6:303:20e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Fri, 20 Feb
 2026 07:25:21 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::77) by BY3PR05CA0030.outlook.office365.com
 (2603:10b6:a03:254::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Fri,
 20 Feb 2026 07:25:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 07:25:19 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Feb
 2026 01:25:19 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Feb
 2026 01:25:19 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 20 Feb 2026 01:25:18 -0600
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com
 [10.24.50.20])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61K7PGsj3484847;
 Fri, 20 Feb 2026 01:25:16 -0600
From: Moteen Shah <m-shah@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <gehariprasath@ti.com>, <m-shah@ti.com>
Subject: [PATCH] configs: j722s_evm_a53_defconfig: Allow configurability of
 MMCSD speeds
Date: Fri, 20 Feb 2026 12:55:15 +0530
Message-ID: <20260220072515.143720-1-m-shah@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|MW4PR10MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: da199859-c7e4-4c82-2e5d-08de705133e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qsZBk4ezO9J5BJ7+zSr7OOl4pY0keiP5wbgTXlxjrMlIAu+5I2JIvqme7Z01?=
 =?us-ascii?Q?4iKnSCicTNTxynUqwrxzC6nQ46gr15xIUpN12DZsE+8srjLlkLeJmg8YJz2l?=
 =?us-ascii?Q?jL7vPxxZzNgqO0YDWirLKs8EY9JvSODzksu3v1r9ic/XRK9H7IMMYOBAr3rw?=
 =?us-ascii?Q?J5YEcTCRZ0cBQoxg8ryZSDoqSe1vDW8lzxjUFpMu08zaT7XNNjoPtlAvwsNk?=
 =?us-ascii?Q?KD+ux0y65gamU0kGer5tZlF0JhZkwVvAqanBu/O/HJJhaWWs8VcMLhEjQ899?=
 =?us-ascii?Q?A6OE2GD4RyBbp+momVjP6uokNJt6GgtxqqFdjfzQAOfAKA3IuCun76WBFitb?=
 =?us-ascii?Q?8ZJxJ52BWixOZqKV3y92kkPYi8kq/BtuyadRyKxtbXyMe5FZTYvfe/0qpsPq?=
 =?us-ascii?Q?gjZDEbMngL3Yjr2LvAU6FPGqkjCoUoltWj4Zf32VNG+nYZc2RvHn3QWKOa98?=
 =?us-ascii?Q?1HrpNDoVRPIaNhWLig0A3r5dInQRP/NM5y3hjaK4KeA12X9YJOvE7FOK4RHc?=
 =?us-ascii?Q?ILHsPoRK0AAVb5EjR4OzrogRAfIlDjqS6WXK9UTRys/J5n192fYbZBNMTpLd?=
 =?us-ascii?Q?asN6xizOG9p11dvzLZEP1mbjDrn6Ct4bnoeKByHytoy7mRcxQATK6PSgQmYg?=
 =?us-ascii?Q?ultdUa2Iakf3ot8lTJezIRb5j3/37eG25Wh/QrW+kd8Or2jOCj+YbWDnYLcq?=
 =?us-ascii?Q?jIHn+6YJdVjsmtitQFtr55j+ynfMENbtfEunQBf+OrHy7VJ1+23TIoh9DSYe?=
 =?us-ascii?Q?TgrbcY3042pHS9KRT9+gK8t+et4UslVjTLs33GfKTBbyIfDi5drzYvBsQoRm?=
 =?us-ascii?Q?j1W8Aq67VW0Q03/BmghSv038TUme0fitbuI13LwyT+ghYfF5WdojvwTPde9r?=
 =?us-ascii?Q?60lLnyOgXA6EXqbK6WHMH/HmISQaS1ihnYv4ZZmqnJ1j8tV63p5HxVmyLUdW?=
 =?us-ascii?Q?/KF4acj512K1vjXmdSQp1zjVKB1/oJw/qwQT5ykP422TNCS/y1rLOTBAhRvy?=
 =?us-ascii?Q?WLff6/eKE6esVZ2Y1forwo69OyBAlpMtrSUdoA8y8mzM/GJZss8wwdAYg0eD?=
 =?us-ascii?Q?E5bDdYpT7ESqIk0EsKF5afchRlk8YWdk6HtnR5Lwo25S3zh9BlI6Csg+2j5N?=
 =?us-ascii?Q?YKmwsLMtFTXxTcYOR+GxQwS+RFGfaPeggx53k+aPXf2huyTMu5SkYrFZh6Hf?=
 =?us-ascii?Q?tLRzEQca6IntxKPIv5tq19AD8c7RxkWUIVypB2Y7qo5iIrHFdQUUuxxb1EWh?=
 =?us-ascii?Q?N2gaKKjioQbJnTxd9XFwn1iJhCwW/vBDJiget3wPILExcNUAM/IHsPBbz1Kc?=
 =?us-ascii?Q?Vuf7YgOjfSoxYOK8idZgLp2V6wIp9GqXbE/Ez9fObtOqKJ3i3AnI5U7pimw+?=
 =?us-ascii?Q?APJC0sFnNadHoHfp26f96YaDqQ+Gee2vtKjWhxisS8Hw6Y/Wxv/p1FgIDnLR?=
 =?us-ascii?Q?OIrV3hreTJBVFpA62tgS4GBfmD8vU+pds5mjUbwoqIJiu32lMTJDIPUtZY0R?=
 =?us-ascii?Q?tSW/daHUkMwsEMIrkCKmrpQuVm7Lt92aHC9GcXP6WMlfJtsAqbtE7R0DpPtM?=
 =?us-ascii?Q?CMyzobA0JFgOLV6sgwqi9yUKJ5pGKW6uPHhOGtlCoevBYB26N2lNejY/VVsV?=
 =?us-ascii?Q?MWRZyUInyNGAXpeoZOISSAY=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Mk1JLrsIAMYcoYw0Lwj8KCyM5O/j+RBIVbJE3HUz2Ia1rb+a4lyh5iumea7kKRF+G8v2Sw/pOjOMQ9jnrvZAqYFR09t02NG4Pv19F9kSknU8CNDPrZNsyPoDxu9cThCelRuPNH6zV5J6ZDtmxeFqT9aa2+Djsi4Wag/pT7sog2t+y1HUs9PrwN9LSBjw7ng4l2aRjGBdFeOHaiZ5fV52eG5rayybQqqWttvjZ09GFXZuzpAUK9ZWNt+K5ZrrYV+bthrQY3Z3/sHY9ZEL2OU89pqaNLNvRg22J+L2Uq4GYBojscOUYjFfVD04a0WAzvDM3Ubk4/K2+fMZdPjV6T2K+ALryVP43Np6pPIIjw0iltan5PjNTC3Y11wAqo1WvW53qZutzDFaxiures+kO6lwd7pc7cjjmF7hBCSuWKvRc57ECczn0r9HIedUZb5gm1Uj
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 07:25:19.7417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da199859-c7e4-4c82-2e5d-08de705133e8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6420
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

Add config to allow UHS support, in turn allowing to select
UHS speed modes for the SD card

Signed-off-by: Moteen Shah <m-shah@ti.com>
---
Test logs: https://gist.github.com/Jamm02/e8b8b8c95cb62a7145d73f7ef50b2d8e

 configs/j722s_evm_a53_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/j722s_evm_a53_defconfig b/configs/j722s_evm_a53_defconfig
index e84670c75ed..24ee293c803 100644
--- a/configs/j722s_evm_a53_defconfig
+++ b/configs/j722s_evm_a53_defconfig
@@ -107,6 +107,7 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_SPL_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_AM654=y
+CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_SPI_NAND=y
-- 
2.34.1

