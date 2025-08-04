Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60FD2C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:30:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68EDB83F4F;
	Mon,  4 Aug 2025 03:26:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="BqXp76hO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1973A83E7A; Mon,  4 Aug 2025 03:26:14 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 489A783EC8
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:26:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PrJ1/p5LXdnhULVJywbJUGQo0EvMkOc8KILHzogXJn60ve6U1rGFGRvWZVFEzrU0BPSdvBZa07STCQblPv0Zm6EyonBLIiF46N/4spfdUtN8RfdgdEYZpNoHj438ENg1Ki6IKPPzw0SHmEzBYi6K2QF1LiReChsS7Y7cbyKybd7uDpyhRqdvFXIb2qw59EEQJwNhx31NLEcss9qwbGjvl0ZrYV0Qi1tYGbwETlOVLQ5bT0pq6reuZAEzEnqL6RzRD6hUlxiWbG0R0Q06GIEQlU/unN45epkqFu98KZrR9KlTVSZ/QZmSqxxGxJcH965ZnZ5LAQV4N7R0f/Ym7f/cSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ceTV4Wa4crgyWXoMTxabBIo5felDEpZPf9oXdb6THvI=;
 b=nBedcPB56iLMNvZFrCdamudciAaK33mQ7HGbxHtXRTsYBGbKoI91fimSK5deJ/194QEyzuyXuYzKZCppy02P9oCXrgi7GxfhlnHyNOVp4kNBF9lEhVmF2jeA+3rFj7JhankhLPJtHJ0cyfa2jygVZmHJGpOO8fVwNSiR5jJRCj1y+tPjwSCoIgjW8QwbHWecn3lRRAy161GFYSNG51+CfERCOuQ07NYpqTdDSFxS/GOeI0hTvx7iqFj/aXRoJ79GMorRu4kjzpoMpEOcV953pup1CZl/q69ZvCW3+StoIojHfPTK3ycU6i5Lj8X0kl9hTWYIQOYiMC5SzA2RuGYbFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceTV4Wa4crgyWXoMTxabBIo5felDEpZPf9oXdb6THvI=;
 b=BqXp76hOXqBZGA8q8nDLM3Lhso6bxKKrFLbzWB9I7eDt52X8XhRQT7Hr1X666Q8NHaXch2qUROZHvFoE7l4StQrT2uMXACTThflsNqKlinynIWr3NHUSdHEz5NqTS3U3aGs2zrEXhvsqJfwcyAGcIBzZMZUBYM7Zm+5txvy8RcHfJjOA35lNgb55rqsI6D5NodBLS0tmxKrkEYjWiFXro9EPYSyRk4YW6R9YJZpW65CRiI5scwPjRY6ya3BORTVg2Tila0YhH6K7bFYwBqsjfB8os9R0qEmWjH4N6cH4wcNsscg75bmpUvRcbO94TuSTUipFoCVg2O6Fpxb3Xk44+A==
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
Subject: [PATCH v1 34/34] configs: Add defconfig for Agilex7 M-series
Date: Sun,  3 Aug 2025 18:25:01 -0700
Message-Id: <20250804012501.21811-35-alif.zakuan.yuslaimi@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 60d67428-9d89-417c-ace5-08ddd2f5d185
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ItJc7Auu5zkQsQ3+jM6LUHGtg2y5cO9Xze7fZQ6Ab9AnPbUPfGIa1q07vrow?=
 =?us-ascii?Q?mN+wcLpkMqaxRkid6zcXi+ipNTlrijEpgtF3kigPe/uicHoItJGsB/uhKHJF?=
 =?us-ascii?Q?6K6twnhwkntFrWLHF5qnKIG4eLeZBeaXF+t5LA4P1pARcJGKaXRBpLSh0ctM?=
 =?us-ascii?Q?dseMjlMGlY5persVWYUg2IYIMWtj4K451jsAKAk/zG31S1HkWHvkajpRqrrU?=
 =?us-ascii?Q?SVPAr0lbAb/rh/+ZyY+m7KprLa5MM6cE0N11eDz4o1yAj28xdx3gUW/nb2JO?=
 =?us-ascii?Q?VBVL+jRHgQJGJXcgsR2g14RM2WUKkJtecz8Ek+heTFpNBU2dGjLHHOiuzsxr?=
 =?us-ascii?Q?f5cYwnEuWTi93w0Zdt8m0mFGpUFzgax3hMch3ohohKSQ610mckad/6X4obP1?=
 =?us-ascii?Q?/hvsK3DPG0YqIpJMdek03NNTreGVabtnBZtAGG7XkCzkljrWLq2/+V7oMjll?=
 =?us-ascii?Q?YswkEFN2gN87xc/r5ubjJLxuge+7qHYfvgfa0FAf1Wb9+vrpmYhaqSAX4lTh?=
 =?us-ascii?Q?HNF7qjSayY/K1lsZ6XiuKOmgjETV2Ccg/1h16/gZusPxWRK8HNGdfrBu75Qx?=
 =?us-ascii?Q?5KA7poWeKuxP4c03laXt4vXkA0B7ouJ9UOjA+ZatjE7VeZn3PgkBQ5FJwMcR?=
 =?us-ascii?Q?pkfSqyBL+NTwq10why+tU+3j98VkIOTzy4xpYolew0gjvgUtGAP3RtxPBWpL?=
 =?us-ascii?Q?7A3iTrUsdvZqfYm99S2YUW74MSMlwkyorDKxhxALSx1KmdCenqf8wWnLPo8z?=
 =?us-ascii?Q?dONTp85vAB6Zlk4CoEdw1oDAm+MZd3F3iEEw+ItrpPcPeHTiS+A8cyG2gIQr?=
 =?us-ascii?Q?hzEyCiDzMTGc6mX94OWoX+J9g4nZweXV/CuAZ35eef7epIzjd7DZTFvPUW7Y?=
 =?us-ascii?Q?8t8jgLD4bM1PrHvONhbouSdGyZwX7/UdxkM5q3Vo2rbpu7v/9+Cs2+cSsP6k?=
 =?us-ascii?Q?AcoMZe+iKF0D4330g+XSCSXPe1BURMzREmCyjXi2YtMvjNyfnnCzYen/Oy1d?=
 =?us-ascii?Q?fSjcmi/T0z1ND6nEr3nOW6Q6S3c1AnNTTAq8SLEeEtMZELeptBcfbxPM7GeX?=
 =?us-ascii?Q?U6tRNcaCJ7XfwNLWNclK4GikZRqHk9tiLV9O+mgsuE8ql6ezVcMVuox8GCGj?=
 =?us-ascii?Q?R3cxpWQ0Nt7Q2IlqBxC1vIU43PSAh39kLMJHhqjofbqyHbmYuYUStAWZEdmT?=
 =?us-ascii?Q?7KyWBeNp8G9a1+wgobv6+c+/XzUZwrfzrZ9GXiqGbQxvgAZw0XeOioqPeUPB?=
 =?us-ascii?Q?eJQ8DzpD8IkqhGBqjdlHf1K1Uc+yydXQsjJOoT7C4I2j9vBEjezOlrHfDoNn?=
 =?us-ascii?Q?4aQSy0Yr8nN3JVWsHbf1v298bJNWKnb2h/3kTxYmTTK2JERfUYgOrxotm4EI?=
 =?us-ascii?Q?6beYNW4U3mkWcgoRLqOTC4D5bqo80UHtPzOcwf6oAfNxTP3cP1bhfhdx04Pj?=
 =?us-ascii?Q?BUaApER6hQw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o65C2HLcXPjlo5oZ65U9Qjw1HKrPAz0TPTy3eWX77FYhPBWatIerrsSFxJeA?=
 =?us-ascii?Q?zWqdD1BI1+GU5VGMkImfOllPG5FottTmVwTe1TOB5Fxr0X6l/cmyb84Gp17B?=
 =?us-ascii?Q?gfFgMQI2beBVjG0E1Jh8bmqOa6MvAaPl321elC+YRmiAhzDkmKNHHP6OECbe?=
 =?us-ascii?Q?GXgjVKyJOQsd1IY4pjojZ/hvOMQk8ErI1LxsNrhECPO4nQ0B2QyplevzjoxX?=
 =?us-ascii?Q?cYFtZkHoSCge1q5EbmQnkn9ypmUnqyDWZFGiDaFLORo/whx0eixfp+xdq1T+?=
 =?us-ascii?Q?0cotASnJ51Nuog6MBDMJmFgqRiZVreSLqzbHN7Elo5iR9ln1ezN8VN99Gw0x?=
 =?us-ascii?Q?MjEJiKIpD5ziUDzd8fALzdjAe6HCnysS49//KfjIQhcHP0wORRdKQA+3664J?=
 =?us-ascii?Q?zXhLKp4THjE3xTqGCfViGnR5ULzuBVnNkOvln36tWrt3jM1hLhrjTPvmcjBP?=
 =?us-ascii?Q?OPSTrm58/xSTBDV7aI789Rd9JbtVi47N/6u5ou0fzynJu+AKpdpKa4CDgpHr?=
 =?us-ascii?Q?A4fvrgH8J9m7qyyuxEVq4lty9jNYb6THytduf6Fv3PSg8eri6QS6yzIV+lLQ?=
 =?us-ascii?Q?j/KOS3JEgdHwJAi2/8yg+rJpuPhZ0GfELO48t5zSNC1cH7BXcD9ZRxnxDaFs?=
 =?us-ascii?Q?+MK0Cpj5Rk6TffxX3gqb2x8GPTz1Tuuu8OCvE7NTY71JX1MyGHzKcT9/KFR4?=
 =?us-ascii?Q?PsUS1XpH67eRFeuS8/ezwdPvHpfqGOtzJneEhXXlZ5q3SXNtD/2VYYvUYrM+?=
 =?us-ascii?Q?5QXK/H3Uk+zda/8Vb+YOrmdiGIgjeDnrNxuTEE2o47VYmtRmlz7Dn2PyEfUC?=
 =?us-ascii?Q?Sp+wi/XS3GQbPT3j9jtqt1D9bleQ/wWqiH5L7RaVmHOK88AA15+IBmVIdYSc?=
 =?us-ascii?Q?xodjBoTzHa7LwGxWDi6WniKhK9io2j5d04j4ko9uRQ95A8VYZPju82AEGC44?=
 =?us-ascii?Q?kOeFt8pfX6RlmL7+gmii+VVpIA1pVPGuuYmXhSErlBF/CkrYLtLx/1dGoehQ?=
 =?us-ascii?Q?VivHhnsHIBoSG9ln84A4ToAyCK+mPKgpQvPtJ7aTRYJzIoXJ6yv067mTMNqZ?=
 =?us-ascii?Q?Lfn9XZdcgt+tPfwDiEBeR6Ly3cTkIFBnZN5aS83qRCZ8f/F9PidI7/r0RlL+?=
 =?us-ascii?Q?Ut3dBqoKqQT0W4TDt/kvfozbOa3tIqWKxamHQUS8TzgAkv16q8DwwEjAK984?=
 =?us-ascii?Q?IatEe0aNLeG1E53HUVmTk0gOm93ITUlEhDDwf0Q6BbzlxLsLgLzrCw8YLYyK?=
 =?us-ascii?Q?tu+JLgAaronyan8lZTKBVMHWozFmhbc9LGhqPmb+aV+FjrXEcPPt4xs3weD+?=
 =?us-ascii?Q?8rkYqi134aZCxNeJ6xtZFgj2Vi8t1oW6gS/mE+ShuCfyVtlcz7NOa0kSXMX+?=
 =?us-ascii?Q?H9j4uZalmnV+NltLkg8RYYkLauayVzun3n7C7NCPtCPtjDJ6xOmH3rvvQdTD?=
 =?us-ascii?Q?/5uMS2iH34h759g8eWw51WI4SsyfKhjbeIt6/GEYgTKMqfbyuma4Tt/HeUlV?=
 =?us-ascii?Q?7TH1BZzkfQ92XnbrtaxuhzgrRcxEhfgZv/fju5ev7th/r+xjUKzuhgO8TG17?=
 =?us-ascii?Q?1v51tFa+iJq+C3SAmTNSAMCRWQLlgB69+6nkl0bKeKwucrRM9THcPyJpl7R1?=
 =?us-ascii?Q?9vV4HRcSp7ya1zPq107GmeY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d67428-9d89-417c-ace5-08ddd2f5d185
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:38.2224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWc4GtvXWEerClXiZ9LXMM9bs5O8FXRlF2gPX/BsPZuz4+96Z4eqFcfrzdlsF14Xpt5i0SKBpAJAVf2xNvGWb/YXkPNCqXa5JIghhwmYYrk=
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

Add defconfig for Agilex7 M-series.

Signed-off-by: Tingting Meng <tingting.meng@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 configs/socfpga_agilex7m_defconfig | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 configs/socfpga_agilex7m_defconfig

diff --git a/configs/socfpga_agilex7m_defconfig b/configs/socfpga_agilex7m_defconfig
new file mode 100644
index 00000000000..0a8c58234b9
--- /dev/null
+++ b/configs/socfpga_agilex7m_defconfig
@@ -0,0 +1,19 @@
+#include <configs/socfpga_agilex_defconfig>
+
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_SPL_LDSCRIPT="arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
+# CONFIG_TARGET_SOCFPGA_AGILEX_SOCDK is not set
+# CONFIG_IDENT_STRING is not set
+CONFIG_SPL_BSS_START_ADDR=0x1ff00000
+CONFIG_TARGET_SOCFPGA_AGILEX7M_SOCDK=y
+CONFIG_IDENT_STRING="socfpga_agilex7m"
+# CONFIG_QSPI_BOOT is not set
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x1fa00000
+CONFIG_SYS_PROMPT="SOCFPGA_AGILEX7M # "
+CONFIG_MTDIDS_DEFAULT="nand0=ffb90000.nand.0"
+CONFIG_MTDPARTS_DEFAULT="mtdparts=ffb90000.nand.0:2m(u-boot),-(root)"
+# CONFIG_ENV_IS_IN_UBI is not set
+# CONFIG_ENV_UBI_PART is not set
+# CONFIG_ENV_UBI_VOLUME is not set
+# CONFIG_USE_BOOTFILE is not set
+# CONFIG_DESIGNWARE_SPI is not set
-- 
2.35.3

