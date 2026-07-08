Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49690C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 12:42:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95CD084A92;
	Wed,  8 Jul 2026 14:40:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="G4viMy9l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F9398497A; Wed,  8 Jul 2026 03:13:49 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5583D838D7
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 03:13:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rEh3PMtCQ6MNVouWm9fZ7XKlv823F/55CkhqnjdyvH7zWyy5VDZZSeHHLl0J9x3aZf5GhqjjeD7cD+mKPlFOIsJrTPImgHRmB23WxbeBGiDP+B8QaP3mvmz4o9MHLvjpvXp5u3zvg85Cx2GDjj9k2qBwkNRWi8bg+ZiYrZJVXZMLqbI/dc7gqMvBgvs0OewxNDaTtsA2zx+68O7ywg4CblOgc6FI2lLhKIaXSXjn/ZIjmXo83idSFFRcqbEeh/tzlY54fY26UtPxz639ADXPLlCcAD9I8QA3OmBUg8kVGfS4v7Yco0FaVqDZn0oe0EbxzqDFBDBWmkRQgRHDBlSooA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dtfUiIJfkj9bgn7A7F5pOL3LaNz0kN8+OSMnNg/msQ=;
 b=Dw0lcH62DGaeelsLSvZ+9sVqCxoSVqXawmzrBvlnOzrJNBPD3HRP/m/Nmldojwp8ytPwkn4cUXiHyschnRHt0r9MvBt1cRlhxeNPc8t+5X6ZpjGcqM83sxz4zOSW8ula8YG3xvr4OV8N2jM+vwKCr6RwIRt00jUpwJrQiFixNRT4pGu62z/YPxJ5L1TgbDVp+4XOMX0K/oVIdbigN/bOtt2KHMwrJvJ66mcOn5wjV/1uiD6MZCytP128oJA3kSzvoaCE8E1WGHT2T8Q00mO+/MuxiYokI+3onRpaQy/Y1+4FUGhgDj3F5MEEXPWGh+SnHK+Vrz8KNZPEWSF4Z263nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dtfUiIJfkj9bgn7A7F5pOL3LaNz0kN8+OSMnNg/msQ=;
 b=G4viMy9lJhIe6gpnqLPFozzWzDA2StIDBVcKb7PJJ9sHCGO0qQGEmJl00cqFSzCBF8v0+GhovgUqLv7NKFQbRUVmsWXDwNfFWeDnbgPcFZ9iBD1Gev3ghQ/Kt69Io/isfCax4KE8ymFtxwOnrhJg+B4VmIspVmiVUUKRYforyjdqZLiqz0HME/WmJOWbDufef5pXOolxFF4/fhQPJGntnej/Kxp9xTAo8AmfRSUvZvmWatKVyX1jqOa2n7DZzzCtykiG2Z6GHcaru5Tz1o1rKaMDjlAalC34vtdl9qK3mJmoAiYpr+4gnsP5Fyw6hVB0ILZjF5eh7yVwFJg4jTJ6tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by MW4PR03MB6473.namprd03.prod.outlook.com (2603:10b6:303:120::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 01:13:44 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 01:13:44 +0000
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
Subject: [PATCH 13/15] ddr: altera: n5x: drop always-false unsigned
 less-than-zero checks
Date: Wed,  8 Jul 2026 09:12:26 +0800
Message-ID: <20260708011228.15613-14-chen.huei.lok@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: a6acb1bd-b8f8-433c-c688-08dedc8e2761
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|11063799006|55112099003|56012099006|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: BfAz4Dr7oRTlUF/LkFgsIGdzklFYfNoqJRnT0JwerY/wCd6xk42Xv5WdTzShbaY3RfNfxIaweTbZkNfLCF9NYbgsAmwPrTiG/0ja8mpeefzZwNZEP4SBDcIZ96J6KS0COLVjjav6P5kkKZTMo4nvqgTKfmj0235cn+zIFymrV83BE5MoJ6wVu1XZtNnbIEC4WhPSBWGXXJNW/mCKQpRmqKJWakAI4Uz0P99t6efe/KCLcze8htyHkjWUv1986Q8sLwfdq2lgCiHL/64ngg0SIvT73HJJ7C6luJWF1TxxEdl22dpdQ444f44iFB9LquNEK34aedhXnUEDpX+fCA0j2ST//78fRFoScBe1mfSqqZ5idr+klyW8IAgRlGZJc8dgC4LNLbGPv9NfXvQ/UOCwp8OmCml5tBEuaSV/MXuJr4O+RKDFtP2yEDrL0LM5IlAIiajWPAe2NllkAUvprx07+POFsHXAHTL0ujUiDSEMMlyqSHstqNmPD+2Ez2jhhtqt0cO9sygvSs5PiIIwAWSMEZXiGL4EtgEuW9qERn5fKKAt/cAFXXYl8aOXo9E7w5+UYHfnvDxd7kZKly9suysqNtH/94WvhyIzt07qY4HDCxg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(11063799006)(55112099003)(56012099006)(22082099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n2A/FJ534ntzcpQVWfVe+7WBwdkqpXx9HP+ih7kSASOM3iNsDf3BFHvetONB?=
 =?us-ascii?Q?rynXePJ0Lnz4G0kChIqO/Z/5GJRaoFafkn9UK81hzU3n3VRLoIx3txjpbssF?=
 =?us-ascii?Q?zUs9gReJ7aJGv+aX1gblgffI/HN64LinO6VrhiwD683twwAMnQnrKC/apgph?=
 =?us-ascii?Q?VqXavxWiA+7B2eG0DOkCjjcYilp9y7palywgT3JW3mNB3DaAONDMc0wXdwIq?=
 =?us-ascii?Q?rDGg/AjYvKRRF3uoFgz0aNsyMKaeM8aaruEMVmFkcMpZ5xiHOkJtOM5uDs6h?=
 =?us-ascii?Q?zpen4aQ7d+YqWFWCpGMCBZklM0lCJw7+LVRLt8B7hSrkpjxFG3GZ0/VJyi52?=
 =?us-ascii?Q?KV46fxvBnUMrPachm1NgLc7FQFULkHv6ff+UqJlLzejrvhlkVzAXzF3QAIBp?=
 =?us-ascii?Q?UWum0YF+znqcB5ZqBI8MIoxe8ZQmFqAsJL0g1/E57u/StWsYKS3cJZNaxxiX?=
 =?us-ascii?Q?rWwDonZmI2/JH4VP0UO8PuRH1kF1ZzrMXocSKm7CuokI866Tgqq/9XHAkJlK?=
 =?us-ascii?Q?uCT6uH9ZaYTwixjrfWkZhrhAZtHRbPXOymTx7gfv38izvDz8h5aspzsKZyYb?=
 =?us-ascii?Q?TkXNRchwMQGpddTPC8KO21NsS1eB3HtSxddgcO5aDWuGK8qMMoFHjS/oyQl5?=
 =?us-ascii?Q?XgZp7Hg1yb46Jsos9RRwhSUHo/3qUu8kYg7bkzZiJnssHLrj8WYOkBj+T4bJ?=
 =?us-ascii?Q?28XMI75wRznAzOyrFtt5RkMdBLyutYugofl1S2q6kFFk3TeesFUIcf0CGhu+?=
 =?us-ascii?Q?m4oqoaV5zc+9/riW7JvfkuX+dBToqFTs2ZKf4stOMQxRSrTtHjXPP/GWfrf8?=
 =?us-ascii?Q?Eb5AlGYFnqtOkPvcB+oFr4JMZc88XK1mMTrMGAFLyuD1+N5sARmN9pknUMhI?=
 =?us-ascii?Q?Du6lYpI4hcyiFLF2gkepInC8Ik7/exfgv13FC/+V05T+1TVuBD10VSYpdNVq?=
 =?us-ascii?Q?qZlyBsMrtmuMFwxXPjAAg/qwKJo/lDz0zzo0PZ1UvoH24XiUaHNmNIsJEic9?=
 =?us-ascii?Q?m6yjJZrX0MqPUH6aqNafGmCKp1iLuM7BzdmsvJoc9MF5rbNy1DLQ5b93lnMF?=
 =?us-ascii?Q?Zd/gXijO+os6YNdaOpGq0yGZ+DoNkyKc/q/+POPxC09p3IRy/MIwF9nca+wW?=
 =?us-ascii?Q?6x1k1SXwGTwjFDI+JnIs5kSsvvplrx271e4LjH5cImb1NnfiG8gedpENxnYn?=
 =?us-ascii?Q?De92JK6uQY0P+H/0gwoZaLVjyIwsnzAMPr4SySaFfweZ72E/1RWPblESM5Y9?=
 =?us-ascii?Q?vpO0ka0zkcOJSskKGoFa6BRmv0p1bA/wSy/kUpY7zJlcYFKFil8vV9WhsxO3?=
 =?us-ascii?Q?lUhTPElSiWNhzLqgIm3SCpQ4p8o52JOqqcNTJ4Et6raZ5vYu9GgLGCbBLyLc?=
 =?us-ascii?Q?UCpRzfrKblNVaFgkN0Hv2UiZQQ70DFGblUrVIIjyfzqyiO6Abtei6loBjIiM?=
 =?us-ascii?Q?+p9l/JkLD+dsrCxLGWUlyIHH3opLqw6AhaPygdd/poe7LYjUloKbL9UKEEVk?=
 =?us-ascii?Q?05cqGoCCnOmnXR67O3GnPkGCsx/ljK/Yaq7WkwjBwKXrrwNliGZvCA1c2+V4?=
 =?us-ascii?Q?Q4KFEMszeyJ8rjE5tUBiDcWp9A0w1mLKnjlCzGzWyUkkodipK4OrY1C/33G/?=
 =?us-ascii?Q?m9hFR9fDLojEJykM0CUzc/vPgrZcA1MZTc8aESQSLFX1hOqA0SkKu60wUonm?=
 =?us-ascii?Q?prjQ+MTxs/XCaSvmFlyMPWRHsadF2X8ROaiZTxVwjTmG3YRgWgWlFiAOaO7s?=
 =?us-ascii?Q?FnELdihUQlAsSy81GWQ8LQWi5V59/V4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6acb1bd-b8f8-433c-c688-08dedc8e2761
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 01:13:44.1067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVnUnmd2n/ecHHn4PX+TQeei4KAo8p8FmH/GbCRbmxPRq5j110e0Wb1i3msiT3xxsVuaOBcuKgsTflV5+yXsSFS4EtUONYKmu5V7xcUl4kw=
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

The *_handoff_length fields are unsigned, so the "< 0" checks on them in
populate_ddr_handoff() can never be true. Remove these dead comparisons.

Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 drivers/ddr/altera/sdram_n5x.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/ddr/altera/sdram_n5x.c b/drivers/ddr/altera/sdram_n5x.c
index d7f00b6d2f5..f7a26e07cf0 100644
--- a/drivers/ddr/altera/sdram_n5x.c
+++ b/drivers/ddr/altera/sdram_n5x.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2020-2022 Intel Corporation <www.intel.com>
+ * Copyright (C) 2020-2023 Intel Corporation <www.intel.com>
  *
  */
 
@@ -1726,12 +1726,6 @@ int populate_ddr_handoff(struct ddr_handoff *handoff)
 	debug("%s: Umctl2 handoff length in word(32-bit) = 0x%x\n", __func__,
 	      (u32)handoff->cntlr_handoff_length);
 
-	/* Wrong format on user setting data */
-	if (handoff->cntlr_handoff_length < 0) {
-		debug("%s: Wrong format on user setting data\n", __func__);
-		return -ENOEXEC;
-	}
-
 	/* Get the next handoff section address */
 	next_section_header = handoff->cntlr_handoff_base +
 				handoff->cntlr_total_length;
@@ -1784,13 +1778,6 @@ int populate_ddr_handoff(struct ddr_handoff *handoff)
 		      __func__,
 		     (u32)handoff->cntlr2_handoff_length);
 
-		/* Wrong format on user setting data */
-		if (handoff->cntlr2_handoff_length < 0) {
-			debug("%s: Wrong format on umctl2 user setting data\n",
-			      __func__);
-			return -ENOEXEC;
-		}
-
 		/* Get the next handoff section address */
 		next_section_header = handoff->cntlr2_handoff_base +
 					handoff->cntlr2_total_length;
@@ -1826,13 +1813,6 @@ int populate_ddr_handoff(struct ddr_handoff *handoff)
 		debug("%s: PHY handoff length in word(32-bit) = 0x%x\n",
 		      __func__, (u32)handoff->phy_handoff_length);
 
-		/* Wrong format on PHY user setting data */
-		if (handoff->phy_handoff_length < 0) {
-			debug("%s: Wrong format on PHY user setting data\n",
-			      __func__);
-			return -ENOEXEC;
-		}
-
 		/* Get the next handoff section address */
 		next_section_header = handoff->phy_handoff_base +
 					handoff->phy_total_length;
@@ -1870,11 +1850,11 @@ int populate_ddr_handoff(struct ddr_handoff *handoff)
 		debug("%s: PHY engine handoff length in word(32-bit) = 0x%x\n",
 		      __func__, (u32)handoff->phy_engine_handoff_length);
 
-		/* Wrong format on PHY init engine setting data */
-		if (handoff->phy_engine_handoff_length < 0) {
-			debug("%s: Wrong format on PHY init engine ",
-			      __func__);
-			debug("user setting data\n");
+		/* Checking DDR handoff is overflow? */
+		if (SOC64_OCRAM_PHY_BACKUP_BASE <=
+		    (handoff->phy_engine_handoff_base +
+		    handoff->phy_engine_total_length)) {
+			printf("%s: DDR handoff is overflow\n ", __func__);
 			return -ENOEXEC;
 		}
 
-- 
2.43.7

