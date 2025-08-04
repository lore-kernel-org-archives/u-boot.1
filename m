Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D821C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:30:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5FBB83E4F;
	Mon,  4 Aug 2025 03:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="QqwOh4gr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF51E83E70; Mon,  4 Aug 2025 03:26:10 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7440083DDF
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:26:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTysyWP8l8SwPZDSaAhmGIX4tymOlltJ1eZC3B3qtM+euHz5a8Dr7tmYbVP10lWRQC7Z0CrE4I9vERpvUbcTHrXtS92OhJGGf78Ovgk8EOKpm3xy8Od8FZRtkrUQfevTAWWY+pJpdZH1S5uNEESM+Yu5l+wRuaIxecHyt5xj7+mrLGx9HNqyHNQgAIA307cnMWO6k5CYkwpXAheqbO+qAL0kD1UtGgTfSNFqaaJuEGWc85UZxgnRPp3Nd9S1xcXmFiE2NPBluy9Kmsd4osQy/Nha/U9kUs/qL456M8uAwsny1NKqF+4k2st8mvnKZgqSRXK8q/6e6gsYywUdRM4h7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pc2+/VKyIVWJAPL/TSvgqwPAXDEFOGO6vCeDUliPbFA=;
 b=c+PsYrGg9YN4A8KrhI10YCIV1YgtaUAcbfyycsb9K8l1IxBK38IU++/sNgJaR9J86I+WN1QrrzoLgwVm5ifnqsjn7o3ut4mmDBycHj5CdxTyte8nGiKZzS++BTvOjt14eezcIwTApzPqDv3h0Xy1KFyTm6B7jfiptM4C0lALxJNug0fvxNXeeUYy5/xcGD98OHRNJdn0N/w/PRCS6sWJg3JMpa3ZqC+atCHPczr0nN+fWJy3z4KTZItuMh3UjSNLkvam92xAgZ3Nuh5LQgmOZpkmk2/IbFz9KpagxTr1Qwwa6Ib2uVoV2D9y34vP7DPl3/7IWNJ/n4QOlR4wLGXW3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pc2+/VKyIVWJAPL/TSvgqwPAXDEFOGO6vCeDUliPbFA=;
 b=QqwOh4grQjd2XrkZ7H2fzqmxqK80ijdshCi+JFFkxCvXyw4MvD6fpy0XPVr0oPC27vkPrIuFrYDbwTfJJL5AlK8zN/xuaWXHrt/sK8LyuW56d3XqO8vT65hZws93A5YVFqqvLQmb21cjVrr+1wud1KzwOPtTqPPkC3PbxilGCF2ueqAV6D28qhzp5i5IRTeCnS30uwe2MJow1QN/tF/ePGOzzsi0DROLIDouR7Eu86ZIN82nE1vNWmmn8UQ9Rkv76jeKie+51jf70wlcX7MrDvVVtuO2l2SANHeuyeUXpyiJz5jZGgK3BHxOEeOxhcjpWWuXYGNTjkswsmEPVybocg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SJ0PR03MB5613.namprd03.prod.outlook.com (2603:10b6:a03:28b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Mon, 4 Aug
 2025 01:26:05 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:26:05 +0000
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
Subject: [PATCH v1 30/34] ddr: altera: soc64: Clean up bit-shift by zero bit
Date: Sun,  3 Aug 2025 18:24:57 -0700
Message-Id: <20250804012501.21811-31-alif.zakuan.yuslaimi@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 013a1f24-dd6c-4acb-b400-08ddd2f5cfe5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jyeekUUCDYbB3VQmwf3DGJPuv224AQZMv7lB6QGACvf1mslxiau4V68hH3WK?=
 =?us-ascii?Q?y2Dyj+1XrsMQuqcPSxwHm+BIeYXSnkNQobOtSqaLKryAXJaPyyAc5HAXXOSv?=
 =?us-ascii?Q?RqLqDjh0WyfvW2KFO44a+FZxEJOk0C48EyhAHP/uXzRtlmUaaxGzDbzS890N?=
 =?us-ascii?Q?aY0Z/i1/iU8F4PO2UXRah1MczHAti2MCH4tr/OrHtT5qdnhTWFlkNRBq8e8M?=
 =?us-ascii?Q?1OOKgopnXLTccWLXHy+ZluNas7VVXQ2lwmmpQQ22kLu0hpv1nRM+UjdmH7NV?=
 =?us-ascii?Q?lPVl6+lT581CyYEAnVOm3M/1HAmXawtFnk4XbsNbZhJjgI1bdeiifwgESaK5?=
 =?us-ascii?Q?LSvG0/dpbYlkdfre8XLuKceGCWpwS4V/DVYa7+XoXYPJzlfL35pRIkUa3fUs?=
 =?us-ascii?Q?qZ+NLzu0l3Y8t7iK63s0h7JDELKud+my9UD3KAisHEHTCl3s2FHJvo1KsLE6?=
 =?us-ascii?Q?eUcOFhjOeLEAz90tuf7CNlmCOmwwjkogkkYcG1mVTXQDrBELOJ3fS1/q/pQi?=
 =?us-ascii?Q?/vW7HDXR23ISRKSSAGTfgZIw2xllHXoQz3rV1+rrPAm9C8coYuWsyAPquDWV?=
 =?us-ascii?Q?+3KU2XOrC0hMygdXL80OX7XhXfaWoiK+t74AaIB4NVa4N8zw5ISqAu4ZiLAL?=
 =?us-ascii?Q?MCThEdlnfY4bEt36duFvyo7ORvSBtbOWCXs07gB41nsYCOQB/iE0Jd7WgOsM?=
 =?us-ascii?Q?3j6ZpbBFvdqG0ZkChv8XTTI9a7RiQhBWNhm89lX3AvAIxFzlY4Msb0SY8MiA?=
 =?us-ascii?Q?IqDteccPj5m222O8Ma1tJ6tubprw29ONNaB/cwoesrrnJmYERsr0f3ehN2qV?=
 =?us-ascii?Q?NvaChNcCjqt8kIhNBLf9fi3SvYtV4Gm7mYiFPV+jchLEj770D87EHWgmCYeX?=
 =?us-ascii?Q?1Q3SnfCos9a5MP/1a7yl68wHj4y3PO3WrGpUJLHf7xmOkgoQbqZz3B+abbqm?=
 =?us-ascii?Q?XlYAUSufZyBDx+Loo+f+7ntHMcJuhGnvUgi6dXuOZ+Utvz5F6MvWvpV4M5lX?=
 =?us-ascii?Q?CQfQ14NrXKEAKd+P4MOZC5hfc1sJfZGeDmglsGyAuGUWSoNxKUGmVzqs8k/G?=
 =?us-ascii?Q?mnAl1P7r6P9QrYzfZ4IZYskf53uRvNASsnlReBRo8pimixW20lFmkJw+FX+9?=
 =?us-ascii?Q?4l1RYBtSmdxHSZobgb16Q6Ae6RNnon0oKvvI222IVfE5V7AYEd+gYqfw5G8h?=
 =?us-ascii?Q?oGvU50H4FPqOW7GX7alk+DNkvvgQGmS8gqZ/9ygOzfdHsuT8Q7C+CbaUwJmp?=
 =?us-ascii?Q?1n4FcNyflFkhdo0+p69B7jid6kcmuqIMCU9X3e+G3u7bK6wWWZ1dc5qX4NJN?=
 =?us-ascii?Q?hfpLj76JaxySD+vRgfff6CQBoE+w2OMUrtGpBSHzBAl7+i4gBP0VWN0UWLMX?=
 =?us-ascii?Q?Of+ZbgzntKzUw2V9S8ppsUkri81qu6WZbPYIzr6xg9gec/4BG4Yhw7LLCL+q?=
 =?us-ascii?Q?9LA1xJeht/o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RwaVjU2jmMmiic2fFH4CNpNjX4OwBKCCanbof1extQg/YqDB6v7Zg1wh+QUR?=
 =?us-ascii?Q?Xqv5qsduIpNzbkfl0Asr5pccKdYN0DZkGY+NQkWTPm7lbv1iM696zuQX6gxd?=
 =?us-ascii?Q?j0+YSq/BzIwd7pGAt7lO1TNuBAcyDi3boCX8PQL3gh+XwqD2nyhjETmQHVMM?=
 =?us-ascii?Q?mC4VdhSSW7O+AS6f07HVPbO53dNIvyGr7RIvIKeGtcwuE/B/+42gPPWejwXN?=
 =?us-ascii?Q?6zKsBvYP3IWLYEjW+shSQVuEwkKvpNt6DAehoRsQhFWIUqBswknyGQ9L1j5H?=
 =?us-ascii?Q?0mCmVgCiamLfsNATig66i5EoMR0quJqwFmQ7LxTJVAq/KEp0w+SXgN1SJlyO?=
 =?us-ascii?Q?B5QmlEzETNL0NqJip4R3W7SB4dkS8g2Um8KpWTqF/Q72xA6Vy2kAoxGjxWka?=
 =?us-ascii?Q?xLyncHCc0wWp5On7Sfl25Og6QUFpV03uhzWIFuEKFAMo0jeP+/sjTseWYFRX?=
 =?us-ascii?Q?eo3j3Mqr6246Xxqg3Ld0XoEbTb/aYqF/9d+R+Vx0w5B7gBylGBJhSI4oe+J4?=
 =?us-ascii?Q?PImi0jZaoHxnVCTHipgC+hbJcecrQwZDfu5izeGBbSKn5FGDp8u4aBFMDrmE?=
 =?us-ascii?Q?JqON2qMmuYuEsLgVL3To9lEw5JxxYzXV8D6Cm+b38JA2PYW7zgnmPDljQEzW?=
 =?us-ascii?Q?G66a6ZIzYb6XNMldtN2X2GMu2SWcJ1eilQtBZBX7dX1OXYEYVY5TXX26Yv5z?=
 =?us-ascii?Q?whl+I92cjSqwBcB7bK8mR45j4u1kdAKy50tzhjm2W2PSO/DuZwuQGdG/ltpX?=
 =?us-ascii?Q?lDr9+emFRJ8OLC1L7B3FfqvXMADNIBmt2mcXCNqi1X3bkJV3XTH+6nFoMZjE?=
 =?us-ascii?Q?Qks88smtM82fmU6XsnTAEGPfkFVwFVaSBfmrjDWNIqfV4zTZz3lqjPT+oMfA?=
 =?us-ascii?Q?jsTxBjrrwv8CxqpEI/Y9VGpmwszJ/L8OJX1Z7fgL8iwWz93auxZzLZ6HgcE7?=
 =?us-ascii?Q?cGztw55lZJfru/6JcsS1AIzjm1041WFRt8izPUwLuicaJZm1q+QPS4AlPtM0?=
 =?us-ascii?Q?BWtQ0I8y40B6GI/Ysw8rv3Og5UwUUrjXGRWXRXavJd3VGkq5Ou1zcBQ89/zG?=
 =?us-ascii?Q?GZNemk1hMrBAkPlvOsM03vRZiN7SWWgVvzlU9Fz8aNQ2fWpcs5aMBxpmIqRn?=
 =?us-ascii?Q?YqnWFLlGU5UWPjQPmbMzGtWgwIEmagM0dGi1JtjiTyoD1ks6zWKlCcOQIPXx?=
 =?us-ascii?Q?p/lelrqeRZQBQW480JO+WU8Uh+aascRqbFIUwEnYlDTXVASHDGGNosAYFMmf?=
 =?us-ascii?Q?0UAaEAX2U6fwoXAoZ0YvoLawKCrCD6lxsWLiCOs9HVaZrGBrfNMJOmvpQ+X+?=
 =?us-ascii?Q?HNaNWMAhHQUpuqWz7yk0ClBgvC1Nkz/8paUxOclHJXVD6BK0NCmzijdNSa26?=
 =?us-ascii?Q?rkwmMwd5IYM2b0WKMZBQlcfv+mtzGYp2F87BWP5QS3fsskHNGBw+gcVJGE9f?=
 =?us-ascii?Q?ofZKf581T9gBGC6jpJ/z58igA21HB4n67EhiRTtffwwMYFsOUPg6TDlTGV47?=
 =?us-ascii?Q?wPoDaCCOKkcssK1b0kWbIkt1uAlV7SQdHx5X2ohDLxbQ8fqkIVBx42T6DRgx?=
 =?us-ascii?Q?KroDqFJ4O3Z46FtREzjsPg2mRHDNTvNttKmuS2IoUTSLTV5wUMZir/XCWdAo?=
 =?us-ascii?Q?YGN9IyK85TTO2kBkK26ucFo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 013a1f24-dd6c-4acb-b400-08ddd2f5cfe5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:35.6243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCXQTnWsNIC4qmpJW9aKHIzVj7VXqDjJjH/jY2uyDgzihWGgshpOHpHULtAWWpCHsCjTNrXE3LiC8GMsndYsuXgmyCSRrY1LA6GSJ3QG6cY=
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

Clean up bit-shift by zero bit

Signed-off-by: Tingting Meng <tingting.meng@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 drivers/ddr/altera/sdram_soc64.h | 64 ++++++++++++++++----------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/ddr/altera/sdram_soc64.h b/drivers/ddr/altera/sdram_soc64.h
index 6783deadc26..5336ce3991c 100644
--- a/drivers/ddr/altera/sdram_soc64.h
+++ b/drivers/ddr/altera/sdram_soc64.h
@@ -76,7 +76,7 @@ struct altera_sdram_plat {
 #define DDR_HMC_INTSTAT_ADDRMTCFLG_SET_MSK	BIT(16)
 #define DDR_HMC_INTMODE_INTMODE_SET_MSK		BIT(0)
 #define DDR_HMC_RSTHANDSHAKE_MASK		0x0000000f
-#define DDR_HMC_CORE2SEQ_INT_REQ		0xF
+#define DDR_HMC_CORE2SEQ_INT_REQ		0x0000000f
 #define DDR_HMC_SEQ2CORE_INT_RESP_MASK		BIT(3)
 #define DDR_HMC_HPSINTFCSEL_ENABLE_MASK		0x001f1f1f
 
@@ -102,90 +102,90 @@ struct altera_sdram_plat {
 #define NIOSRESERVED2			0x118
 
 #define DRAMADDRW_CFG_COL_ADDR_WIDTH(x)			\
-	(((x) >> 0) & 0x1F)
+	((x) & 0x1f)
 #define DRAMADDRW_CFG_ROW_ADDR_WIDTH(x)			\
-	(((x) >> 5) & 0x1F)
+	(((x) >> 5) & 0x1f)
 #define DRAMADDRW_CFG_BANK_ADDR_WIDTH(x)		\
-	(((x) >> 10) & 0xF)
+	(((x) >> 10) & 0xf)
 #define DRAMADDRW_CFG_BANK_GRP_ADDR_WIDTH(x)		\
 	(((x) >> 14) & 0x3)
 #define DRAMADDRW_CFG_CS_ADDR_WIDTH(x)			\
 	(((x) >> 16) & 0x7)
 
 #define CTRLCFG0_CFG_MEMTYPE(x)				\
-	(((x) >> 0) & 0xF)
+	((x) & 0xf)
 #define CTRLCFG0_CFG_DIMM_TYPE(x)			\
 	(((x) >> 4) & 0x7)
 #define CTRLCFG0_CFG_AC_POS(x)				\
 	(((x) >> 7) & 0x3)
 #define CTRLCFG0_CFG_CTRL_BURST_LEN(x)			\
-	(((x) >> 9) & 0x1F)
+	(((x) >> 9) & 0x1f)
 
 #define CTRLCFG1_CFG_DBC3_BURST_LEN(x)			\
-	(((x) >> 0) & 0x1F)
+	((x) & 0x1f)
 #define CTRLCFG1_CFG_ADDR_ORDER(x)			\
 	(((x) >> 5) & 0x3)
 #define CTRLCFG1_CFG_CTRL_EN_ECC(x)			\
 	(((x) >> 7) & 0x1)
 
 #define DRAMTIMING0_CFG_TCL(x)				\
-	(((x) >> 0) & 0x7F)
+	((x) & 0x7f)
 
 #define CALTIMING0_CFG_ACT_TO_RDWR(x)			\
-	(((x) >> 0) & 0x3F)
+	((x) & 0x3f)
 #define CALTIMING0_CFG_ACT_TO_PCH(x)			\
-	(((x) >> 6) & 0x3F)
+	(((x) >> 6) & 0x3f)
 #define CALTIMING0_CFG_ACT_TO_ACT(x)			\
-	(((x) >> 12) & 0x3F)
+	(((x) >> 12) & 0x3f)
 #define CALTIMING0_CFG_ACT_TO_ACT_DB(x)			\
-	(((x) >> 18) & 0x3F)
+	(((x) >> 18) & 0x3f)
 
 #define CALTIMING1_CFG_RD_TO_RD(x)			\
-	(((x) >> 0) & 0x3F)
+	((x) & 0x3f)
 #define CALTIMING1_CFG_RD_TO_RD_DC(x)			\
-	(((x) >> 6) & 0x3F)
+	(((x) >> 6) & 0x3f)
 #define CALTIMING1_CFG_RD_TO_RD_DB(x)			\
-	(((x) >> 12) & 0x3F)
+	(((x) >> 12) & 0x3f)
 #define CALTIMING1_CFG_RD_TO_WR(x)			\
 	(((x) >> 18) & 0x3F)
 #define CALTIMING1_CFG_RD_TO_WR_DC(x)			\
-	(((x) >> 24) & 0x3F)
+	(((x) >> 24) & 0x3f)
 
 #define CALTIMING2_CFG_RD_TO_WR_DB(x)			\
-	(((x) >> 0) & 0x3F)
+	((x) & 0x3f)
 #define CALTIMING2_CFG_RD_TO_WR_PCH(x)			\
-	(((x) >> 6) & 0x3F)
+	(((x) >> 6) & 0x3f)
 #define CALTIMING2_CFG_RD_AP_TO_VALID(x)		\
-	(((x) >> 12) & 0x3F)
+	(((x) >> 12) & 0x3f)
 #define CALTIMING2_CFG_WR_TO_WR(x)			\
-	(((x) >> 18) & 0x3F)
+	(((x) >> 18) & 0x3f)
 #define CALTIMING2_CFG_WR_TO_WR_DC(x)			\
-	(((x) >> 24) & 0x3F)
+	(((x) >> 24) & 0x3f)
 
 #define CALTIMING3_CFG_WR_TO_WR_DB(x)			\
-	(((x) >> 0) & 0x3F)
+	((x) & 0x3F)
 #define CALTIMING3_CFG_WR_TO_RD(x)			\
-	(((x) >> 6) & 0x3F)
+	(((x) >> 6) & 0x3f)
 #define CALTIMING3_CFG_WR_TO_RD_DC(x)			\
-	(((x) >> 12) & 0x3F)
+	(((x) >> 12) & 0x3f)
 #define CALTIMING3_CFG_WR_TO_RD_DB(x)			\
-	(((x) >> 18) & 0x3F)
+	(((x) >> 18) & 0x3f)
 #define CALTIMING3_CFG_WR_TO_PCH(x)			\
-	(((x) >> 24) & 0x3F)
+	(((x) >> 24) & 0x3f)
 
 #define CALTIMING4_CFG_WR_AP_TO_VALID(x)		\
-	(((x) >> 0) & 0x3F)
+	((x) & 0x3f)
 #define CALTIMING4_CFG_PCH_TO_VALID(x)			\
-	(((x) >> 6) & 0x3F)
+	(((x) >> 6) & 0x3f)
 #define CALTIMING4_CFG_PCH_ALL_TO_VALID(x)		\
-	(((x) >> 12) & 0x3F)
+	(((x) >> 12) & 0x3f)
 #define CALTIMING4_CFG_ARF_TO_VALID(x)			\
-	(((x) >> 18) & 0xFF)
+	(((x) >> 18) & 0xff)
 #define CALTIMING4_CFG_PDN_TO_VALID(x)			\
-	(((x) >> 26) & 0x3F)
+	(((x) >> 26) & 0x3f)
 
 #define CALTIMING9_CFG_4_ACT_TO_ACT(x)			\
-	(((x) >> 0) & 0xFF)
+	((x) & 0xff)
 
 /* Firewall DDR scheduler MPFE */
 #define FW_HMC_ADAPTOR_REG_ADDR			0xf8020004
-- 
2.35.3

