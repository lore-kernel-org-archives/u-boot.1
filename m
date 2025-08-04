Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6CEC87FCA
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:30:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43BE083E7A;
	Mon,  4 Aug 2025 03:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="g2MOMxBf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFEE183EF1; Mon,  4 Aug 2025 03:26:12 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F68D83E76
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:26:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4Rs+C5jsJloQff6163HUcAywGeWWuvhQ9lV1EIYsMdFtsNypTeTVqDdRBvo1fn5tzGSTKEB4u9shtJwztxu4BJ4zlRYStm/8dWdxKRUFN6mjTV+xCns/y888reZArCYi6n8MoECWHrZ3CErvXeO1PYrbzT5nLwQFtdGihPEqmX0BV0CFVaX3Sw6aw1WHzEXhdl1ZJjy6EjGJNCdG2OxorS5PNQXqmZGGXW1e2vwnwQ1ppyRQd2GXC5Rnb8NVd6CPyUh2b1UjcLkqvJqg9RiWQk0b97iQNgk3mWo8mlcDwWS7cnaJr81PMkRHaMTb+gAL3Qj1Gp8ycnDIxTqk+gpeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ua7xXnZrn101VKEzcGG7RSrz8VZe0x4DyiRkhn9EyX4=;
 b=KM6kFwcfjJ7Z+lUP4wKyOuS1oSVzbhxpSYOAvYD9s1xfIBBPTWrT63FA8h5hTaHHjkeIvF5VcfQRNn7N0OqoBC2vM09cybgcnxQguNjJJP4QzuHAkiy06z/MaYY41iffGqIDinStAMvyh6h9Nvt8T5jKaFk8VXiSt0eHi9OqKB6vNNmAOiXuBgGN2QefEvU+lMrCxzJbOrraF4cK3vzoantsBu+3h/Ebcyiab3a7DINKIHB6HKC8hCiyn4euxpIcd7TYDiTMGnQYBQxkGMaYpqK4Z41wHBNgMM0KB7uyNRsJhEDPllRMPO9vINDxlZJGNLzzzzLAWzd4xx5Aahnl+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ua7xXnZrn101VKEzcGG7RSrz8VZe0x4DyiRkhn9EyX4=;
 b=g2MOMxBfnZPIBib2vDR4E5EdFVwGgktVvmtlBeMfd8IVMIHdLIGmK/qAo/QeMuCOsKY9cP1xHwDLTFLj4DwKjyxkc1Jtz/Z14o4oxuy+K2f/u5M6r5vsWOuyPhNvWXW9ltupo+B2Ejd6lBbUDM1OHf2uw9al/0BvzAlA2WjKo78eKGLWCL8RZEKz6a2KXkWel13I2McO3a/W67Yhq90+XO7Xpb4CvnJFnZaKvmhLyQUSGzEmU+KPag/WjfYXTEceF0OncVbnDcmJqjDcQyARrp6Vlz4vV/pBp1r6xOMK2y4otqfakSVflfZFS9yMucBBZYh5Ib7FjPRkMzEzSQoTfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SJ0PR03MB5613.namprd03.prod.outlook.com (2603:10b6:a03:28b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Mon, 4 Aug
 2025 01:26:06 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:26:06 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Naresh Kumar Ravulapalli <naresh.kumar.ravulapalli@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 31/34] ddr: altera: soc64: Fix dram size calculation in
 clamshell mode
Date: Sun,  3 Aug 2025 18:24:58 -0700
Message-Id: <20250804012501.21811-32-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
References: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::48) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SJ0PR03MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: c7546035-a9a6-436f-bde2-08ddd2f5d05b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fU+JXoE/JkH1hH5h0B0uWX28uRZ0wLIffT0We++ntxWcYZ/HHKWcLsNke+IH?=
 =?us-ascii?Q?66VPkzCuIGQOJhafCWTaeWhBgYz7HM1Wso4LHzo0GgcNqfbYB3Cad5fQGVHV?=
 =?us-ascii?Q?EA8gaGQAtxqKPPEOlBTyoQD8h8damrcfkeM479hMKAI2igLBUCTOFbds/AOK?=
 =?us-ascii?Q?JVYsKlNFN8dJ240wScpnnURsgeeW9HPMlMQkqw4UyEpaFpL4/mZQmHglcJF3?=
 =?us-ascii?Q?/Uv2n6ppYAzOHUitwjwHGree/uW5qVZnEr5S4qHEUyP+GJ9ox9XGkXWiK6KU?=
 =?us-ascii?Q?s7uWl3waAh9n9S2cFCtmuRn14RLmvjU7Kt0z2mIZd16H82zHLzqXjBKFyVak?=
 =?us-ascii?Q?B7CIRiM3JmFQNL1/PYL9nWUOyLSNJUFULnfmQNtNE/t7oGuqNUz9iG93MFOQ?=
 =?us-ascii?Q?zy2ymCgAo6c8XHu8QziXa4c+LLao7Zt+bnPflX4OBVAueAFuKjYvMOlGR8VA?=
 =?us-ascii?Q?WuKxa5S1KdNcZu1qDiQey/pgEpKyymDiPeYJhEEQhwW+aLYyZGABEDWVXAaA?=
 =?us-ascii?Q?qEjxOxk2JaMblge1EaoRgeeHzuyIVxWlHUkhmaSkwWj34lPSVIMxL+PuM3gP?=
 =?us-ascii?Q?DVY7gPLm0YlDsHBOp/uxqx0n/vUVH5brudfflr1V1zoB8Fji7mNsMkyXxrOq?=
 =?us-ascii?Q?0wwJpF6W7DNnABxd+/Sk30T9CeOJkZenQy7+PlvsZdfbn67Tr15a2yD9Qjjl?=
 =?us-ascii?Q?XKzRf2VmwY4TwBqeYFLs3wjHPnaGmzYYTvG5OQKshMHZjKawKQYFLXMjreWV?=
 =?us-ascii?Q?zuZ0VD7xaUDZIYULbhjGk8qtd/grvrwBOGFt9T5D0vU60O/PxDxzXyQZOr+W?=
 =?us-ascii?Q?6EyaB2/XxygDQ5G6k3sgNYZaDXl8JwVqn8E7j+f6GwFXwdXWWEGY7lQOJeOj?=
 =?us-ascii?Q?W6MvggE4E+mf/XPVVg4oBnVgLuBdrvBUjK08WLFFDAYJTC1XWhG2lqxOCQr9?=
 =?us-ascii?Q?McGdpXtdMJKHXkHUv9CTtpDQJlfE4Dt8kwYi/zdpEEs+lYrqP1bmeDUR0YmF?=
 =?us-ascii?Q?ayxOcalh/JUpiilLhh8iisCouop24nrqi9lzM7Og3OgrvhSRgsUfFYPmsdrg?=
 =?us-ascii?Q?sPrMloy4a6zKwVb0w/54mmQEeFvYQLM9lDuPWaOorGVvSYmG/QFixJFD3awI?=
 =?us-ascii?Q?GidEnCfNektuAyUnPr8zGZegXcm0rhh2QcMujpCcYymRhE9EYskUBcPxUUFs?=
 =?us-ascii?Q?xuu/gs2+5OCLCntZqIZ4ouCM58kBnXD/VC1vScYU4axbJfV6/i5AitdreuBj?=
 =?us-ascii?Q?cn5Uvr1TBJs7w36hAfeI3Fqsl7rdIaeLFkD8ROk0xAuv3Tdbn/+/fXF5nNdZ?=
 =?us-ascii?Q?s8taV+Wb0IYD2BLryAYyDAjIrMylrdZBhm7wxoNE+XZaefWkmnbr/Zjrbud0?=
 =?us-ascii?Q?YHC+c0s1OfJFqtVpztFaCPJKcHePa8FUQgo16BXQ5tv1h4WosKxnh6xDYPzu?=
 =?us-ascii?Q?5zfNZB655tU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dTjYCM3VGnyCohRcXnH7osQU8VKMq5VoCSDEUM+RQsHbTTHpHVgboAh9WNDb?=
 =?us-ascii?Q?vIcJkBlDPl8pO1HivgnDuWjuOCqdtX92tk0r0EDNdMlLvYysedjlh7jRwMoh?=
 =?us-ascii?Q?daRb9SLFYZ8vnhZB3zvaK9Xz0oRpjG54BAOF1zuUvPH0Urk5GAeQsLmjZLgg?=
 =?us-ascii?Q?+BhzilA801gBOWi0YXIscTqOIMv8LvzUeP2/e3lKy1XJJT0lquf2O72spV7j?=
 =?us-ascii?Q?CeHVmY1EUXNPIyUx3adACaXj4+GZ3uspZ0VqHSkKk4wC5+jGDw3v+JL7zDYx?=
 =?us-ascii?Q?D7t3M16vot71GGnhgEaF6gMoFXiLX6GHVRl14QucCG9LaeJYOUg24RpR5Uqq?=
 =?us-ascii?Q?fKaI0o8D7KvArz3/FvYLO5VnBGDOOE87heiE0acjIRik5xTtc2t4PaHTPPDr?=
 =?us-ascii?Q?72AW3pZnIty0vDpqUF/fAiwp5k66lVei40aGmsNK1pGMO0D1FHll/TyRdBQ4?=
 =?us-ascii?Q?LhBRVqJCE8NzdPzZtHguyPl45Db0kDrlnxvfBTg8htevmvsbU42lCgi/wyup?=
 =?us-ascii?Q?eC4K1Xd3K0kUwO7A7scKD5E6MKccLdIbJiPyTuPzet29DrbY1x85u9O/c3vn?=
 =?us-ascii?Q?Ofx/LxXJwUJaSnm9SZrggtlacK5rBpYQeY7IFcBn7GVKUgU0BdCDsFaIxHSb?=
 =?us-ascii?Q?9X3evcQCov6b7rpby8IsPUJ/q9LwoHDwveDRWj723cxl/AYfmLbTO7o9EXLj?=
 =?us-ascii?Q?4s9DpJ8qyaepmbdBNXS/KQBjzWiGSs88rtsvatIpFFD/rCPtOiT52opkT1iR?=
 =?us-ascii?Q?rwNLTqtXXLSUly1yCgKzn8+NOCiiyouhpUKfAvRZC0fjQQNj14QgOUV/kaw7?=
 =?us-ascii?Q?JjDfBBWl5BlcR/G997CE9+lg3dA3KfKkAoPvGq29JEPjemjGMc4YKUN7Blfj?=
 =?us-ascii?Q?87JwLh7si9mdAEv5wDDmDT6CAcYzCUfiLosyxaNrDlmvcOCPNntyOzOgpzqf?=
 =?us-ascii?Q?dVdePY+2rNNIrqYgH6qNXscNiPN8VqFYFDiHMq+vvuX+ZKY6jFQB5pFTb1oj?=
 =?us-ascii?Q?XXtHYmu3jYlfevUXBeVyEUqge+6ZMpDSctDbxkVlKb3PJW0txFFoUDhtZgTq?=
 =?us-ascii?Q?s3bu8BeQiPwiiUb53FeECLSfsbPdurBeXFCnOyVTDBVeIevAUHARB+050B8C?=
 =?us-ascii?Q?4UbYCsfF9Yer5tQ0vY8lnvNRDK160p96tIRQR3SFZMSpeIDA1C8q6WuKhm58?=
 =?us-ascii?Q?HTEkb/DdoyaT4TRTYCaSsYnJRuoY577hRDi3+dhwrZ7JjoAu8PQX79/VxCJc?=
 =?us-ascii?Q?4UpCLYkLMOZE3APaa9UfcLzziqoWxhYyLaCn7dhe7cx3/tChJZCHOSIAysm4?=
 =?us-ascii?Q?nW7mrXEmZBjtxtbYg0WBxBDgCUVbPutrQ2mUZezmHHGLvj9MAkuZWkMhS+i5?=
 =?us-ascii?Q?pLuBJPQBsPFUJMCfAC3UsHV4VrSgBmdwxcKWQKTBbV5tZXvfDQsCYP7JK8qx?=
 =?us-ascii?Q?fPypzw6kAABv4DJQpg0brf02RfXCsMy5uDjbrY6tWud7KCvQI8YS0L780gg3?=
 =?us-ascii?Q?VpBLd4h/MWhmEo0j9gl2CYkIGi6Gg/UPg9wckssjagoVFGwzfyVFfUMSmOiQ?=
 =?us-ascii?Q?eYOPF388zmbQ5vWN1OTZQYt4US9Hvyz59na2qA5tnFTyfrZqPr7gcaoN9+4K?=
 =?us-ascii?Q?e7jPNPyIafXfXatWuxOAvvM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7546035-a9a6-436f-bde2-08ddd2f5d05b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:36.2611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eW19amzy4OkpvwuNEAnIBcVnpYGLJq1eEmcnIIsNvJdFuVhMqZnIZ9XvLlnnQZqnyluv+htHmj7pLTsdaOt4MLGDi3R00xQdc1UV1rKtsac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5613
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

From: Tingting Meng <tingting.meng@altera.com>

Fix wrong memory size calculation in clamshell mode

Signed-off-by: Tingting Meng <tingting.meng@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 drivers/ddr/altera/sdram_soc64.c | 16 +++++++++++++++-
 drivers/ddr/altera/sdram_soc64.h |  5 +++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/ddr/altera/sdram_soc64.c b/drivers/ddr/altera/sdram_soc64.c
index 81cb79f35a9..f8fc92060db 100644
--- a/drivers/ddr/altera/sdram_soc64.c
+++ b/drivers/ddr/altera/sdram_soc64.c
@@ -29,6 +29,9 @@
 
 #define PGTABLE_OFF	0x4000
 
+#define SINGLE_RANK_CLAMSHELL	0xc3c3
+#define DUAL_RANK_CLAMSHELL	0xa5a5
+
 #if !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5) && !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M)
 u32 hmc_readl(struct altera_sdram_plat *plat, u32 reg)
 {
@@ -258,8 +261,19 @@ phys_size_t sdram_calculate_size(struct altera_sdram_plat *plat)
 {
 	u32 dramaddrw = hmc_readl(plat, DRAMADDRW);
 
+	u32 reg_ctrlcfg6_value = hmc_readl(plat, CTRLCFG6);
+	u32 cs_rank = CTRLCFG6_CFG_CS_CHIP(reg_ctrlcfg6_value);
+	u32 cs_addr_width;
+
+	if (cs_rank == SINGLE_RANK_CLAMSHELL)
+		cs_addr_width = 0;
+	else if (cs_rank == DUAL_RANK_CLAMSHELL)
+		cs_addr_width = 1;
+	else
+		cs_addr_width = DRAMADDRW_CFG_CS_ADDR_WIDTH(dramaddrw);
+
 	phys_size_t size = (phys_size_t)1 <<
-			(DRAMADDRW_CFG_CS_ADDR_WIDTH(dramaddrw) +
+			(cs_addr_width +
 			 DRAMADDRW_CFG_BANK_GRP_ADDR_WIDTH(dramaddrw) +
 			 DRAMADDRW_CFG_BANK_ADDR_WIDTH(dramaddrw) +
 			 DRAMADDRW_CFG_ROW_ADDR_WIDTH(dramaddrw) +
diff --git a/drivers/ddr/altera/sdram_soc64.h b/drivers/ddr/altera/sdram_soc64.h
index 5336ce3991c..6031cef560e 100644
--- a/drivers/ddr/altera/sdram_soc64.h
+++ b/drivers/ddr/altera/sdram_soc64.h
@@ -88,6 +88,8 @@ struct altera_sdram_plat {
 #define CTRLCFG0			0x28
 #define CTRLCFG1			0x2c
 #define CTRLCFG3                        0x34
+#define CTRLCFG5                        0x3c
+#define CTRLCFG6                        0x40
 #define DRAMTIMING0			0x50
 #define CALTIMING0			0x7c
 #define CALTIMING1			0x80
@@ -128,6 +130,9 @@ struct altera_sdram_plat {
 #define CTRLCFG1_CFG_CTRL_EN_ECC(x)			\
 	(((x) >> 7) & 0x1)
 
+#define CTRLCFG6_CFG_CS_CHIP(x)				\
+	((x) & 0xFFFF)
+
 #define DRAMTIMING0_CFG_TCL(x)				\
 	((x) & 0x7f)
 
-- 
2.35.3

