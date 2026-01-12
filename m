Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED5CD277C9
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 10:11:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 684D783D7A;
	Mon, 12 Jan 2026 11:11:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qoBT/YsC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 268A383D8B; Mon, 12 Jan 2026 11:11:24 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazhn150100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d902::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C496A83D7A
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 11:11:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJofI+OAlnaM1hXnKDlc4f4XHdUC5ISwQCwBf6P2nh5ChXcXDQBoC+RlAep4fnm2MWlohjFNymvq/1hBNAi2PdY8LHHnkeb8GgxgxMJj4LXoZGFXxcUQyCykL1hhZVelgTznPGoZNvFy7HYBMyInF9/uEOk8IygUQDRT1gwInb7sZjTNRq0YNIYxo2l19xTZ+p0DF3flPRozVb1LqCEktqC/fHp9Wo26SufcUs9kHMA1vE7ZCv+TALvpzRftQjVwCmVnWy5t3cJKseYJHW9LWaHRfl8Rs69b3bhM23tNFeWTlG+bnXYFatUSZl/N7vPlft+1PiBhzEkpvvjzyR3omQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzisKC61Udp8OP5mlT0ngk2VSg4vjx4GXIo7/fNmE2g=;
 b=R995UCFdSpXN7g2QZYMbly394wcME/x1x4RrvmizeVuNcDEaU+bHhqzMb0/KWs36l/Y2VUP7kSudTCG1wpEkBWlbSwgzc6mXH6iAIFKb48QtcgI8LobYMxHFiLTyM1V4Nq4dnSrbfQmmE41T0oCKk4Y8VGjQq4d6OJvM+Hn8Bj3YoDEMNfSZBnFG2jiyB3mzqwFfgwzM1EG6ZjVYWCJbrA9BLK+a/ytwOM96VoK6ML028/nj7KQtiHG+7U3G5+JzjdXVH6c7CvXTOWhrP4FUDc2WBJQ8uQk5mVzT8u+BO/FAfj7Vm6KF8nb/FFCsgSQodO8gPaioYhZsYMito3YFoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzisKC61Udp8OP5mlT0ngk2VSg4vjx4GXIo7/fNmE2g=;
 b=qoBT/YsCqpSMu58b0zUNQNkIyG6SF/G8qX4UEwmcAmFPe+U1b0KHuFmbKFuS9ZPvl48h+osa3ertOGdD0g/Npzix46vwGSKYFE+s5A61q7WYGC7IV7iOik1lrIT6Bb6rOI++UAr97InKxryoBcUKdn+gYzIvdcNwTTU0HNlQ6fo=
Received: from PH7P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::14)
 by CY5PR10MB6118.namprd10.prod.outlook.com (2603:10b6:930:36::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 10:11:19 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:510:33a:cafe::a6) by PH7P222CA0001.outlook.office365.com
 (2603:10b6:510:33a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 10:11:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 10:11:18 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 04:11:17 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 04:11:17 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 12 Jan 2026 04:11:17 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60CAB2fv322683;
 Mon, 12 Jan 2026 04:11:13 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <ilias.apalodimas@linaro.org>, <malysagreg@gmail.com>,
 <sughosh.ganu@linaro.org>, <philip.molloy@analog.com>,
 <marek.vasut+renesas@mailbox.org>, <james.hilliard1@gmail.com>,
 <anshuld@ti.com>, <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <b-padhi@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH v2 2/2] ARM: OMAP2+: Pad SPL binary to 8-byte alignment before
 DTB
Date: Mon, 12 Jan 2026 15:41:02 +0530
Message-ID: <20260112101102.1417970-3-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260112101102.1417970-1-b-padhi@ti.com>
References: <20260112101102.1417970-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|CY5PR10MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: 133abf9b-65c6-4013-fdb2-08de51c2edb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|34020700016|376014|12100799066;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nRSqcJf/avfyWGCdYTNou96fhBin+bqiYaVqwBy3dKbTCg28teGU2MWRVJ5Y?=
 =?us-ascii?Q?VlBuEpPvNbihT/0ZAPEW4oTDTte/HbEz3Ukp0jFYhom7lF3DNlibiRVg7G2J?=
 =?us-ascii?Q?/dBk9g0zEbofoETEAJHNKTbv8uB9Gm7INOYN8xA567UcW0/zsifj70vTR42K?=
 =?us-ascii?Q?l6W6iDDgYb8vzB6lXE1VjA9tfTGu6r9Gn49zO9+O7T80xjCfQ3mxIkSJS/XP?=
 =?us-ascii?Q?00/TDOoFyW6t4XT6J/RqWpsNLESxNSNaCL4t6nmN5dJ7vkbdwVTSChREY7+V?=
 =?us-ascii?Q?vHDTaIhkqapnQzWlPmIVJ9b5Wi753dCOgZLSC4Ti1n+CDsdt70VXSl2jveBu?=
 =?us-ascii?Q?DUDYVGDElt6yGUQHzEYLctUM7Fwwlko39GddBLeFL5kXlH9dJLnIeNrguuHb?=
 =?us-ascii?Q?33qm/9NflkQr9rXlJiQxdvYV/HEDoMnIItFXKYaD3nwWyd1U6PUnwjjuURL2?=
 =?us-ascii?Q?H6XnEwqMhwNGWrQiMvoqpERc0ITZzhykHEKcKaGmPLCk0PLZEDeoVX8EJJ95?=
 =?us-ascii?Q?/45DpFbsjrDSoHWF3wATa6ww+lDxTLn7akpkmNr2tC2JyLXubuepYHnzqx7d?=
 =?us-ascii?Q?+tOXU4MfiZ4g/Jxc5+TxNRauFFMuDr8yfCGwp8l70sZeR7T+AN5s+/4Ci6MH?=
 =?us-ascii?Q?iL/XEV8HzqMxiqNDnjDC6z8o2MDcXBkLVbLb4ajiXExZY0WHU4qb+byPzV23?=
 =?us-ascii?Q?DJIBajFn5tJDrjHMItRAO7HsxtHIyKSZk340SrrE1OhH/oporkcZ4nzGP1+8?=
 =?us-ascii?Q?JMVM+nczuPNy9nsqyJ/2BSbFCfxgejZlIMUbMJCe5zfXK9c5GCpXiBg98ntq?=
 =?us-ascii?Q?xqaG0heHEBVfD4LleCYR+lyK7rpu+ri5zZubZzLxvvJt98vQ2soJ+AZyT8Vr?=
 =?us-ascii?Q?gBM0SP1zudbqcfoWTW6BbK6+ugIrunzdad7t7hDbtVFT4SjItkkicE6gF598?=
 =?us-ascii?Q?lYAmQwkiZpeTstsiwd/jQp5HlApyAnAV5wCIYBZJ/WWhl9I2l6jz5YQ1R3z8?=
 =?us-ascii?Q?EXr0fCb5VYZyHg0e1ttY5ctaS406Eg3b0thR5Kk8ypGLPGogsAbM6SgeFLC4?=
 =?us-ascii?Q?GqkvqA7KcJ4+K4aLwI4NqAgSjqn/xPLPbB/TND0blNNlevxturBBRINjtqSp?=
 =?us-ascii?Q?6TSthgME4c8cfckL8LIdmWA8O7rRsrITL9m/XWtNMhEBSD5vKXuBaIoNYbzI?=
 =?us-ascii?Q?Z0qQGh4b8z2rOq458iBh0D2qmQZ8tCffRQqBv88P71z5xTX5i+2PML+LTgZH?=
 =?us-ascii?Q?ZpqY272qShFftqhqmwAzPlbTkwm9M73WC0l3rH35D7b0e+VxfLdp8n8vF3U6?=
 =?us-ascii?Q?EQ08QzIqbUW0wGdpBG0C1ty28FJFDC5QfwtWJ6om8LLwxvGOsfb301JTtCN1?=
 =?us-ascii?Q?byhIrHjbJ+v80eKXwGbk1FJK6gya9iH5mVO4DRxuuc2ozHlnLxs/U79jNhCg?=
 =?us-ascii?Q?WWBs9S7uJdpWUetwdZsimXKNiHSCdGnJi2lNAsWC1A0g1B5rO7xNIVfGgK/A?=
 =?us-ascii?Q?YLS22hkfYfcF5guTTEoksCpaBaEOJvtxlL/zuGpAe1NM306GzLsE53t1fHr6?=
 =?us-ascii?Q?LhuO5yZNIAHvp0tw7KVmGKAszfypkdNNH1RiPl6D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(34020700016)(376014)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 10:11:18.5564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 133abf9b-65c6-4013-fdb2-08de51c2edb0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6118
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

The OMAP2 SPL linker script (also used for K3 platforms) currently uses
a 4-byte alignment directive after the __u_boot_list section. This
alignment directive only advances the location counter without padding
the actual binary output.

When objcopy extracts u-boot-spl-nodtb.bin, it includes only actual
data, stopping at the last byte of __u_boot_list (e.g., 0x41c359fc),
not an aligned address (e.g., 0x41c35a00). So, when the FIT image
containing device trees is concatenated to the SPL binary, it gets
appended at this unaligned file size, causing libfdt validation failure.

To fix this, move the alignment directive into the __u_boot_list section
itself and make it 8-byte aligned as per DT spec. This forces the linker
to include padding as part of the section data, ensuring objcopy
includes the padding bytes in the binary and the appended FIT image
starts at an 8-byte aligned boundary.

Reported-by: Anshul Dalal <anshuld@ti.com>
Closes: https://lore.kernel.org/u-boot/DFJ950O0QM0D.380U0N16ZO19E@ti.com
Fixes: 0535e46d55d7 ("scripts/dtc: Update to upstream version v1.7.2-35-g52f07dcca47c")
Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
v2: Changelog:
1. Get rid of extra ALIGN() directive, replace it with a comment
2. Carry Reported-by, Closes and Fixes tag.

Link to v1:
https://lore.kernel.org/all/20260109190026.58464-3-b-padhi@ti.com/

 arch/arm/mach-omap2/u-boot-spl.lds | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/u-boot-spl.lds b/arch/arm/mach-omap2/u-boot-spl.lds
index 3bb759d8a1c..5ad169a37b7 100644
--- a/arch/arm/mach-omap2/u-boot-spl.lds
+++ b/arch/arm/mach-omap2/u-boot-spl.lds
@@ -35,9 +35,13 @@ SECTIONS
 	. = ALIGN(4);
 	__u_boot_list : {
 		KEEP(*(SORT(__u_boot_list*)));
+		/*
+		 * Ensure 8-byte alignment at the end of the last section before
+		 * DTB is appended, to satisfy DT spec alignment requirements
+		 */
+		. = ALIGN(8);
 	} >.sram
 
-	. = ALIGN(4);
 	__image_copy_end = .;
 	_end = .;
 	_image_binary_end = .;
-- 
2.34.1

