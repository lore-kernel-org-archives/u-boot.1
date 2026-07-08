Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00A1C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 12:42:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2425084AA2;
	Wed,  8 Jul 2026 14:40:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="TqIhvJte";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B13B384118; Wed,  8 Jul 2026 03:13:57 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9087A838D7
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 03:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWNKZc/qA9/q59BVWXetuV+ftXNICLqqlxMVqYV2Dt9UIgQjCYeKIXYIv1QIAw/CteNsWu5JS/5FfKOqW9RX5igY46rpLu3c/yoCXv3WGifVVY0Sx1ZMAP7893cUh8FA6GI2PEJgIyOHMN7PnLHGR8xWsSUBjFSMxTOg7cSUF3zMdZKD4ts6LswRpmL3+DocKPY+5q86X31uRT0M9EEiT1VjMDVXsk8rX1aiwGm1jA0RVQ/0GbdGeBTdR7hvPgoDVejBJrMPAIUAhygSVzyIuNXCkfs2ISDnOJevgn/cOU1UG5C6eQ9LOrkutEvPpSedz+52uxHSPDJ1zTkIoOZJyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OX9JYJXc3Ph2pPlQmqnJhiR27TTz8LMBJNalyLCvsIk=;
 b=W3Avtkz8vMUgt6PbusNcyUQF01X/6pk1EO8v/h1Bonq83y1V9E6Hp8/B1NRka+NyAi+bRajSd+ArZPJ/yYlxjGQgS2sPVoSpzNJSLV2Mfu4An0NgCZU6nw2xPa7UTp84dfamhD5vQjxCh2u8xmG/LyGDTjCsXvgiT8qenz7H4NqRNe5WVLd1hHBVenG+zKflMAf7cidmT1L5ipz9o+5Oyt0Hl5UBSBuBxrBmFSvth/fCta3pBHM4IYMQgAOgXsTIHEKR5z5T6TWqtqTdoapiYynf0gUj19uruldZ6T01HLyTw77r+rHWqO0QvIAfT9MwBRCxyNvsHQaBP2qNkvStNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OX9JYJXc3Ph2pPlQmqnJhiR27TTz8LMBJNalyLCvsIk=;
 b=TqIhvJtecmdehpswKnSaZ1Lt9HNw1uRkEVDWP/2/avdh7WUiGvIXaMUyFbGEDLvUR/OlfMNktoFmS027ZwxOP2nvkpkOuXWR1x5t869OecC8KIHiM1rscG+DEyGZQemm/KB9PUj3exGbIzTp9YQksPIgjJ9uLThl8fNQCnpjuTzgbfKXBSBNxhXO7vSwEy1wIV7GhRoLogluDB4nhshUzaUD2MeFpSN/pTDX3M/8GdZXZKpKRDdlw4EPXw1Ky5h7Hy4brnrpFf3u+v9D85fbcNanAxNL8iNQIpc6DAI/eg77ipbG+bsCyMg0DEsNT3O5t/qKkUj8lrcsQRWvFuBL3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by MW4PR03MB6473.namprd03.prod.outlook.com (2603:10b6:303:120::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 01:13:52 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 01:13:52 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH 15/15] ddr: altera: n5x: Replay PIE handoff on DDR retention
 restore
Date: Wed,  8 Jul 2026 09:12:28 +0800
Message-ID: <20260708011228.15613-16-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260708011228.15613-1-chen.huei.lok@altera.com>
References: <20260708011228.15613-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:a03:331::7) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|MW4PR03MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: d60c1cc4-1c3a-41f1-5679-08dedc8e2c1f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|11063799006|55112099003|56012099006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: rfXjDYU0XyGrOqKlrBNPCiXQJ9S954xoWgpqdnnM3UQD1yOznoOBcSwrLMNe130qXL/iFvM8cSeNN4EuXHZrGy4IOeZFESbXIopC7VbdYw51eNUq3kBGRxBh827fB+Q9BNNbbnBwqIOTTzZeno1k64Ho1CE9okyCWfvHL1xFBY3O6gqmZ0U2ci3KQ38xwKcNvESIOqCr5efrHfGf4Zcyz7MvDLzUrM5mThHahJPQvq6VTWvBy+NotQVeUOh8poUdK049+JI9othpkJdgtFTV/oGXwNRPM7TKWsYVFQQ3BxouEqfgchtsRksxXBD/W1Lm81arA5r71MAFKG4aSRkWrw5BN42tz/WLtrk7Jgpmr7+VDym++mKDlUcviJB187hAsHQc+g4YVzXjk+haHJKs8+NZeEMueMU/+hxyvj1QLimTgk+41ECzYdmVU1u2ZKbZYj1KF8vw4icJNXNhHJTfIY7MykgyvTelwseUjAXhS0PEHvCrLf6in5bKO58m7zNiomKdgp+HQZIZijd1EYc5dT8cMkkNrwmdnlJ/vwlzK+Bhl4S7auPIeY2qcjKXOpDhTR9Ut6R5GQYNYacLVHphcC1nYJuTiLQBYId56ly2O1XqI9WS7m75ENjrbCfL/zX3twLfID/1sqpfmxzamYKSUzghCtFDmNEWPRyRH7RoTtc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(11063799006)(55112099003)(56012099006)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qRmpwR1vZfnm2C2GRS2ZFHhAqc4ykRWpEH05z4oRXhLTzYr+xn/ZIUlBQ5D6?=
 =?us-ascii?Q?y7f6emNq3kn/3X4m45acVsF+95k3ENzhT3eAoWXdIRiXF0hZ7eFHPnrcsqG/?=
 =?us-ascii?Q?wNSorFpImfmuVYWYjb1ZssylJkWMsNy+i6dRnJnIGEk3tzHwGLejNmFtCdp5?=
 =?us-ascii?Q?Przeu499WaSf/wcSRSP1dcBbg8N9k4Qvt/BvsuSoyenokb7ik2CduOTUDLRs?=
 =?us-ascii?Q?yYL9pMhjS3ZgxAeWhhrdc/KcUBHkIEy4sStJMFKb/Ozm0BlSTvsOp1sYLwkE?=
 =?us-ascii?Q?xTLYYn6s1Dp9BdP0SS9Q5H6XceMthOXX976qtVeqq2wllTigSyx3+IYVbdQH?=
 =?us-ascii?Q?s8jfWWuLUnVcXCMCBti2WW/ZVfDbv8GRE85Vfczg3wZYlAxHajB/BfTjrZBv?=
 =?us-ascii?Q?ooZYMLlkciSAWLtoYq61xDCbn3usDrrX4lXwVCo0oLl1I7ql40591dy+NBdC?=
 =?us-ascii?Q?gaquaosjRvYvkfLk0WO1ARfpppWXBnVDIrZ/0DbE6VUdl+ATzlVkpEsi8q1y?=
 =?us-ascii?Q?q/g2ScBWUOmpv+pfXcyLs8vNcJLIy1gTN+5vfwuKMEU+cD7cBMHblh+mHeps?=
 =?us-ascii?Q?wYLlnj0gzBMU3h6GjzMVLLMOB7l5ZanMxXb3FlwP0CBm+BnQQ2odNtCbMU5U?=
 =?us-ascii?Q?RbnI3itlhydLzwG/d4We4BPyUS5z7LCSmHF3hUnayFfpbXjw4SO/MyaJoMa6?=
 =?us-ascii?Q?t6z+byRd6KGg+KtUyFWUwTxWgfH9UPT85uGrAeYXZBL+oWfUV2xGslLKDsuV?=
 =?us-ascii?Q?KzKiPBtMmZQvzF4sVkvyXnk8Oxv/WdsTaGVaqB7NRjn4qWytQQm+tJzCiJEx?=
 =?us-ascii?Q?rCc3xKCFMxZIUlRftpEbFpY/EhPzj3azX0a6BbGsUPCreuvXuDBkWdQ2n2uj?=
 =?us-ascii?Q?iX1A+HZ0640aaS5FmpLKKZFBqti7tr0LhH1XhlhBdyrSJvFZri7h5tHsmGHM?=
 =?us-ascii?Q?QxNlCj995llPWyHRcr0hW+CYGTyKy4QG6XA9fxT0K6HoV4rPrCOMFBGCPpKN?=
 =?us-ascii?Q?1418kGvkYab4ymfRmOhMqEg38sSY4h12aRuUe+yvuJA8sQ6q3gl/FNWoyFlR?=
 =?us-ascii?Q?qcOx3GQsq1ON9E5r6WI7nQ3o2CixZgvo7ovcbC5IsqjX9QnX+VD6ANi+OQLM?=
 =?us-ascii?Q?pux9TwpzUnE4YyZc1uH5mif6qEk27mrD9HcjFFq7DykphSHuAmcPvHJkK131?=
 =?us-ascii?Q?WVzgJEidBzQE7w5FWxNI7CyjzbKWsbmNUbJIR3geTyjBuEeXc75XzmfmbDF2?=
 =?us-ascii?Q?s0+lI0RAC9fkN42B2QLKd50pfVCvqAADStSAEVNQGDwNtbuisbz3frXPIpBq?=
 =?us-ascii?Q?Pf6o/TlLxiNqFVHSHRo1J8amG4x90m5B8t7kM8/ldiM5mqfeKfS0hbvQWHdZ?=
 =?us-ascii?Q?kI9iV0R3CsImpgbjLUdUFQOknCtPgK/P49eHTuHsr+403UzBMVvreQx1OtYG?=
 =?us-ascii?Q?kZ/D0WdNCS9tbGhMxxsci580HQr7/Jy1jCauDGHaA51GgW6wHGXjErIwQpTF?=
 =?us-ascii?Q?YR83SrgJKtdKJabEsEsi9LBsZo0mk2kGSwhEglF1cc45hx+WYCKDETYCtZgY?=
 =?us-ascii?Q?nTxyDGsALqVkGILZ7vEA7v1yVpy29S2UbqTnlk+AkEI6v1VZrtp6EicihiWA?=
 =?us-ascii?Q?kGC+xO7bOJCNTT6e7WXutjoC924AoY/JSqlnTWBcR1pU4+i9wLtYVLguL80n?=
 =?us-ascii?Q?RZDYabJ3dBJbqPUw+Sw5UsauhWP6pWkj/oL+SEuLDquEhQMvhe/vOD8DYLrG?=
 =?us-ascii?Q?XXn2ChebjsMUCjU3vcYQgBKcweIE3vU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d60c1cc4-1c3a-41f1-5679-08dedc8e2c1f
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 01:13:52.0786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54BmgaGmynAS6YkKLE6cSyYfrGTW0BVyEu4RuyEjQR47DefrMyY7G8HQn7JPaWWJotV8ga9tHvXq34Aate+Xt+4p2RVlm1tBGnUxBLlbl1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6473
X-Mailman-Approved-At: Wed, 08 Jul 2026 14:40:34 +0200
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

On the DDR retention restore path the trained PHY results are reloaded
from the calibration backup by cal_data_ocram() in init_phy(), which
leaves the PHY microcontroller stalled. Running update_training_result()
there reads back results from a PHY that was never freshly trained and
fails the DFI handshake, so DRAM init returns -ENODEV.

Instead, bring the PHY microcontroller out of reset/stall and replay the
PHY Init Engine handoff to return the PHY to normal operating mode.

The PIE handoff table shares memory with the memclk hash scratch area
(DDR_HANDOFF_IMG_ADDR + DDR_HANDOFF_IMG_LEN - SZ_512) used by
is_ddrconfig_hash_match(). Snapshot and restore those bytes around the
hash computation so the replayed PIE table is not corrupted.

Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 drivers/ddr/altera/sdram_n5x.c | 48 +++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/ddr/altera/sdram_n5x.c b/drivers/ddr/altera/sdram_n5x.c
index bfa08f62ad6..d09cea5d2ac 100644
--- a/drivers/ddr/altera/sdram_n5x.c
+++ b/drivers/ddr/altera/sdram_n5x.c
@@ -1496,6 +1496,9 @@ static bool is_ddrconfig_hash_match(const void *buffer)
 	u8 hash[SHA384_SUM_LEN];
 	u32 memclk_table[4];
 	u32 size = ARRAY_SIZE(memclk_table);
+	u8 *memclk_hash_dst = (u8 *)(DDR_HANDOFF_IMG_ADDR +
+				     DDR_HANDOFF_IMG_LEN - SZ_512);
+	u8 saved_handoff[SHA384_SUM_LEN];
 
 	/* Magic symbol in first 4 bytes of header */
 	struct cal_header_t *header = (struct cal_header_t *)buffer;
@@ -1512,14 +1515,26 @@ static bool is_ddrconfig_hash_match(const void *buffer)
 		return -EFAULT;
 	}
 
+	/*
+	 * The memclk hash is written into the tail of the hashed handoff image
+	 * (DDR_HANDOFF_IMG_ADDR + DDR_HANDOFF_IMG_LEN - SZ_512) so that the
+	 * whole-image hash covers it. That location overlaps the PHY init
+	 * engine handoff table that phy_init_engine() replays on the retention
+	 * restore path, so snapshot the original handoff bytes and restore them
+	 * once the hash has been computed.
+	 */
+	memcpy(saved_handoff, memclk_hash_dst, SHA384_SUM_LEN);
+
 	sha384_csum_wd((u8 *)memclk_table, (4 * sizeof(u32)),
-		       (u8 *)DDR_HANDOFF_IMG_ADDR + DDR_HANDOFF_IMG_LEN - SZ_512,
-		       CHUNKSZ_PER_WD_RESET);
+		       memclk_hash_dst, CHUNKSZ_PER_WD_RESET);
 
 	/* Generate HASH384 from the image */
 	sha384_csum_wd((u8 *)DDR_HANDOFF_IMG_ADDR, DDR_HANDOFF_IMG_LEN,
 		       hash, CHUNKSZ_PER_WD_RESET);
 
+	/* Restore the handoff bytes clobbered by the memclk hash above */
+	memcpy(memclk_hash_dst, saved_handoff, SHA384_SUM_LEN);
+
 	ret = memcmp((void *)hash, (const void *)header->ddrconfig_hash,
 		     SHA384_SUM_LEN);
 	if (ret) {
@@ -2956,10 +2971,31 @@ int sdram_mmr_init_full(struct udevice *dev)
 			}
 
 		} else {
-			/* Updating training result to DDR controller */
-			ret = update_training_result(&ddr_handoff_info);
-			if (ret)
-				return ret;
+			/*
+			 * Retention restore path: the trained results were
+			 * already reloaded into the PHY by cal_data_ocram()
+			 * (LOADING) in init_phy(), so update_training_result()
+			 * must not run here (it would read back results from a
+			 * PHY that was never freshly trained and fail the DFI
+			 * handshake). Bring the PHY microcontroller out of
+			 * reset/stall, then replay the PIE handoff to return the
+			 * PHY to normal operating mode.
+			 */
+			clrbits_le16(ddr_handoff_info.phy_base +
+				     DDR_PHY_APBONLY0_OFFSET,
+				     DDR_PHY_MICROCONTMUXSEL);
+			setbits_le16(ddr_handoff_info.phy_base +
+				     DDR_PHY_MICRORESET_OFFSET,
+				     DDR_PHY_MICRORESET_RESET |
+				     DDR_PHY_MICRORESET_STALL);
+			clrbits_le16(ddr_handoff_info.phy_base +
+				     DDR_PHY_MICRORESET_OFFSET,
+				     DDR_PHY_MICRORESET_RESET);
+			setbits_le16(ddr_handoff_info.phy_base +
+				     DDR_PHY_APBONLY0_OFFSET,
+				     DDR_PHY_MICROCONTMUXSEL);
+
+			phy_init_engine(&ddr_handoff_info);
 		}
 
 		/*
-- 
2.43.7

