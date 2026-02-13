Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF8CEDF160
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 13:24:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D30B83D5D;
	Fri, 13 Feb 2026 14:24:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="gGJQVrZg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92B6D83DCB; Fri, 13 Feb 2026 09:50:14 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EE8C83B9D
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:50:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUVOkZVLbYs/yMCecX4kUFINfPPvMrlWlCk8F6b6Sn9UALV8ANmvzU2ApVkuTRccJew265atcXW9wJj9RzPGnn48PV+UgbrGS8KAfKNcCVZsMkYKGFZLpnlwCTMWWwfkUHxT5PlkM5Jm7hSxnycJEAxVXDCCP+XVK3SH3lA/5g/UJsemco5hvjU+MRitk5PQ9ER6zeNcOQBUKAIY7oDUnVDCD5/ScOlTjRsLF+7ncguoXWPHePL1l7ld7EuLztyOflwykRhMTsbdMy+IanfW0IYnzRxhdz0GOef9JMFPq4NU94bM3kBdeTu2E4bQGOmcCFiFbAEbQ6NSmjk5CtCy1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSxlFbmWV3n47bOr4IvYGKZY0lHCVk3Z8t1deBH6w+w=;
 b=mcYfKtQQ6d1jlplu2HLnuoRMyziyv+VKvgqtODuaKvya113H8NaHHnnQwzyF9dvJxH2sSnqsvpLgQBCT4y4I7WC4MgJ44bpJo9ikiSyPl9Z7jyNcXRn/MeZCjuXB+SEFkqCBHSSRt14OpUoxvcyBdDftKv9/WsVYso24j/2BwOWTPYTocnpCHnHjnMds4IwA8fKI+1etzEkM/IS/4urXyH8w0OTvzUoB/jmDYmfPknuFDDWqM/Dm/tI5D90Zp/LFVpH1M/9OSJzYkSIqLbpOSlSZ8Tr4guNYPiBtYxNcoP3Dq7DTXvnXr4v1z99clKqacEMxRXaedw0PhXuU/2i7pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSxlFbmWV3n47bOr4IvYGKZY0lHCVk3Z8t1deBH6w+w=;
 b=gGJQVrZgfIMDIz6I2SrGR7gqJMWH6zEVgtRAJSaIM/zgaG0elJbxQrJp85OwjL/pnfN7vXuu36Lucw/kxPruwHqqYs/us1FavSZMGI6w+x6B4ggDuRmHLpZkr+fPRdi72PIWFEMcmel5PxEHVsB4LO5Kk0I+xVT3Hf3QbWSVNQgkDOgSKBG28anRsDNUUuSfXxH8Lkn7fJND4N4IGzYKqTXPr+3hQA4ERCSAOekc79OBNKFyYwKtQHPQ31cqPRbHhhn+M6ottex9ZZclJyBDEpOfDmiBp/xwZWp6kiNDaTl/hzgV2gQ0q4Lkaw2938XbYEwD3Sn470hr3LcXTFvMRg==
Received: from MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37) by
 SJ4PPF5ED8BD012.namprd22.prod.outlook.com (2603:10b6:a0f:fc02::fa4)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 08:50:06 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:10c:cafe::8b) by MN2PR01CA0024.outlook.office365.com
 (2603:10b6:208:10c::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.13 via Frontend Transport; Fri,
 13 Feb 2026 08:49:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay1.compute.ge-healthcare.net;
Received: from atlrelay1.compute.ge-healthcare.net (165.85.157.49) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Fri, 13 Feb 2026 08:50:05 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 86B03F2E7B;
 Fri, 13 Feb 2026 10:50:01 +0200 (EET)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Brian Ruley <brian.ruley@gehealthcare.com>
Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Alison Wang <alison.wang@nxp.com>, Andy Fleming <afleming@gmail.com>,
 Angelo Dureghello <angelo@sysam.it>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 David Zang <davidzangcs@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mario Six <mario.six@gdsys.cc>, Michal Simek <monstr@monstr.eu>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Scott McNutt <smcnutt@psyent.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Thomas Chou <thomas@wytron.com.tw>, Wolfgang Denk <wd@denx.de>
Subject: [PATCH v3 1/6] arch: imx: fix incorrect shutdown call for inactive
 video devices
Date: Fri, 13 Feb 2026 10:49:50 +0200
Message-Id: <20260213084956.1031000-2-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260213084956.1031000-1-brian.ruley@gehealthcare.com>
References: <"aYtUi1WdLPLEnv2X@zoo11.em.health.ge.com">
 <20260213084956.1031000-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|SJ4PPF5ED8BD012:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 21a5d859-0ad9-4eab-4182-08de6adce29c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ekriRu7I4qLGan04STv1M8Y7A2SoPe0jq62xyw4h95FI3IprLX9uYB35BP+/?=
 =?us-ascii?Q?oTbvlyJ/waoUtGMp3jsL2EGp8/ET7PqYpQJqAUexqqkaCmQVNSIbe91ylEf7?=
 =?us-ascii?Q?qcOpqEx//G7baQYeMRxFxTAAol/uzi8mOcX/3o4+9mbr9zSRgcPziJiMZVit?=
 =?us-ascii?Q?S4CMNbur59xT/LjDso7u60e9QsLU4lvIlSSa8bH6yWma8Ul33W/d3BgWlTEO?=
 =?us-ascii?Q?jKEU39a4uMxvjW/OovLUKdJt4+h7WCBHpATPnkBO0sDno8HuPdAawO8n+CQ1?=
 =?us-ascii?Q?yhanNuFoQ+H4w/Q5YPLRSQR0xlfy8VtOvGKPJDW77E0y0TV7xexXam9gjCtB?=
 =?us-ascii?Q?I0epFTQvUALe1C+3occvXx4NZX2hgSOnzG1dMEYMst7pj8x95oBGHsdIVaxN?=
 =?us-ascii?Q?XwnXTSI8lL6VObnOL2sf121/miXwISNlxs5DRj5RwrDr2TsAllGdGZFuVJur?=
 =?us-ascii?Q?Uw3vNJWx9ee+M8mwm5gpAaqDqnQN2iO95J5SoSjIwrgErK1TmnWLCmxIBhK3?=
 =?us-ascii?Q?aEMr7Noywj1liGcGuVVWAeMmMl4cgMownw0r2LSFyidvCBSJdqH+bvP79q9G?=
 =?us-ascii?Q?GL9Wym6T53F9FX8v8BgEAOBptQYFx11/+V9Dc+caeVUgHbNhTzzVW1bF1o9B?=
 =?us-ascii?Q?er0vud+EEN7+JnOvThmT2Za2+zbTCIocaeh9LOsY/Sx/P/b2c2eoyzZOh4D0?=
 =?us-ascii?Q?M4FlzyuRy3MML5BjtoFwL57txO0iy0/cy5GSmsG21/L//BWd5NCNYTLQ1A2J?=
 =?us-ascii?Q?2Fi3NOdCuxPalGg/0FlcGG805j6DDofWkrASscIjGk3CT7XJ9NKZacVOeKXw?=
 =?us-ascii?Q?oxngjRgO3docxSfz9FHGGzYTuqmkYjcQJNlhZFm6p9Bw98anTWw5hu8CiGHN?=
 =?us-ascii?Q?Srv0nh9R6nVqwctcFYlzCS5hgHkZ8HiIMWncaNF5EJaW7u94BPQo1HmMS0wT?=
 =?us-ascii?Q?f2m1zJYzGFfFDnxEdtvLp2e+RWlq9uby61lLry40GsobdClDbGr+qyiOvjn4?=
 =?us-ascii?Q?ccsOcZQGpHqSaOyt3Pq42neyf7s0pqhAasTc7JrXxEWLBKUH8Z4BqzczuHvE?=
 =?us-ascii?Q?xkkuSvVIgjMLSxskSA/Szv2NGRiUySExs4i63SeTy6dI6XtHHaSHvECHa++g?=
 =?us-ascii?Q?YcQLcbyGrY0xWzEigyPK9xim/l3tI2tVaOSYGB7flswrtcHqYaq5pIEovIrK?=
 =?us-ascii?Q?q/skGIPLJnwh5C4JwczF3ZRcnexakuMR/8NafGRnXGmob0bHp9210CG4uJ0C?=
 =?us-ascii?Q?FdTd89Q9WMFnQ8hAW2SJH/sgLQ9upooFOTwo7AyRdc9Nnyz34+iYjAIdX7bY?=
 =?us-ascii?Q?toJfrIMWB/+wBkUt1FuyI0pWGrnORgYweVoKIUCe1vn4p6nXI0XXvPT+Nvpi?=
 =?us-ascii?Q?3M7l5rHUpuqoRn1FRLP28KlRtM/rXhsz6EHjCl3CnonFNn+JgcF11Z4haEzy?=
 =?us-ascii?Q?DnbnSaObQ8sRKIPme35MF8WtubyZHwwOFAXN8IhX7eRRIhVeOujsOt+MQAZf?=
 =?us-ascii?Q?XXmxRJH/Qq8iN0N+Ps/xJMdJs6ZcGFSbW/WD+f4WFf6DolXHOr25T846YzP5?=
 =?us-ascii?Q?0h3GOr383l6i6hMtXKYqL2Td058YAMRnEF7ASFD+B0wqhSPakhZcTAcWmHOZ?=
 =?us-ascii?Q?CEw0s9v7iwwAy3gUtgkpPN927Lk3LfXPqW2jXPKQwRkx2LOcSj48MFGZloJe?=
 =?us-ascii?Q?kgc0LQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:atlrelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fk6gbiyWhmqWmFN03VYHC/7NS/ddGPr3C2Pf+xQDUEOOTjEiYFcLWlgeVMbg7JXCGJbAzQB1vCqresxPDFmj2tfmVcVKHHGQBfn/N0F+xBcA0aUt5ObG/JzKfn3umcCuTvvNydQWPzx0TOmtDhUiyKuXoczXbB3D3hHwQ4jPnmZlpSwfXGcfdDXsX5M5trt2nsUGOwzJoyZnRpMN30PiKCbtt9q+F6e9QgLTvxOquVgr6ndzOMLaK3cxq+NV0tuH5oMas4StdzoQ9RebJlaQaP+WdHclR2HHAHwoUXwpyp4I9vRk4eBeMpxI4sg/c1aOw/BBoO+2Z5ASzYWT4WQ+rlDGZPFUPUGg700o6DBHD6mzynrNNo4n5eC4ijt6qjo0RoLyKSxCcfZy8wNQ57yaQKp1+HjQfgJ91q8xbgMbMnKIZxA0kw6lwPDuZQ9WqJ+Y
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 08:50:05.7864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a5d859-0ad9-4eab-4182-08de6adce29c
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[atlrelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPF5ED8BD012
X-Mailman-Approved-At: Fri, 13 Feb 2026 14:24:08 +0100
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

Somehow I missed that ipuv3_fb_shutdown() can be called for inactive
devices, resulting in invalid memory access and preventing the kernel
from booting.

Fixes: 32da6773f62 ("video: imx: ipuv3: refactor to use dm-managed state")
Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---

(no changes since v2)

Changes in v2:
- New

 arch/arm/mach-imx/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index 20c741283cd..8af45e14707 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -310,7 +310,8 @@ void arch_preboot_os(void)
 	/* disable video before launching O/S */
 	rc = uclass_find_first_device(UCLASS_VIDEO, &dev);
 	while (!rc && dev) {
-		ipuv3_fb_shutdown(dev);
+		if (device_active(dev))
+			ipuv3_fb_shutdown(dev);
 		uclass_find_next_device(&dev);
 	}
 #endif
-- 
2.39.5

