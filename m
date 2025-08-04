Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916E8C87FCA
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:27:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FD8083E57;
	Mon,  4 Aug 2025 03:25:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="nQCysQEL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7511683E42; Mon,  4 Aug 2025 03:25:28 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 200EE83E0F
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MC12w4vRQF+9KMj4rWIoa/BU6qcGJRZHZaTi0O4pQSydL0ItBqa0rC3D/nBKV+Pyoy/JVT8A0WR3T+MI+vqQP/SoA0bBEQFONXUAISUCwOAX1cMN8oLPGFgDmEjIx3zVbL9ie0XHS+/6c+N5EL3CyBPr1LK24w/4JbUmZJicvy4CPvO9BZmc6sK6NyTtyPbzAsiDo26ga9NhrIFZB9dom+HG9e/zwCAalCGXhYfZHAdZMmLD2yv6Vz9sK32/Adm47TKF7CeHuo3TviI0/gcmWX6Eb9QRbYAiSRSNcnHqndFv8yBWSyBQBm6J7UQXN+IRdXdlj9m1BmXsDFiws0/P8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rC4KH+biYBCb83Aknj1qyDbdappK9R074wcgCt28r4=;
 b=ZQEiKiJE1UbikgkLydQuX82oGIn8Xs4S6GXCYLgLGlbeQupgBRaNbQbVtgJUBavldjsVgga3MJUsx3geU2ZSa1N35+TJ9LMEwX9E9af/3LKf7ydFLRfkKnCMT011E9nsRtik8u1myiYIj3ihz2EGl8O3KlIWubaAFmgDqRjEMCBMSvGcc+wyVhtNeD+MdYPJ2Qp8F7x+gyJSwydH4S/mw1MtQpuNdo9mXRiWozgStKA/lUVH/xvXxYM7+G/8Zy3SYQEnkV6tyjmf3d+Et6rfjaSsd5nz30Zbj8ZvdLhaTpniT9nOUW3FNUbuJ1l9Tm3DaIJPlkpEy+64/zbYbAhuEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rC4KH+biYBCb83Aknj1qyDbdappK9R074wcgCt28r4=;
 b=nQCysQELQ5ijYj/f/c+Sd8skxKaoAYvNKVw/tNrPT83gGgj+EkPgoFMPqHKDsWcB1wYc6Rh6kRl3RWFegpZzpK3X402TyC+DaK0C1H5CvXO4Xe7t7x9hxqTFNmm4Xx2NlxJAKd1SdZF4kuDnwx9Yhko9H8zmp5ooAxAEA167gsflQ6M8UZO2aiuLjOihIgKt0BwYt5PDaMir5xLLb0lsZi0syImS2WE+B7Jqy2d4ZU5HnJHHYFO0JpmPugx3OjLHptHRl5jnTH8zeHIHrpHwIoIQKuN9I+iwAR/OpPxiKdRg1Krr8KMLC4bzI+ycSmuMjNVXwvoF5h9oFEHzBU46Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA6PR03MB7973.namprd03.prod.outlook.com (2603:10b6:806:42c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 01:25:24 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:25:24 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Naresh Kumar Ravulapalli <naresh.kumar.ravulapalli@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 14/34] ddr: altera: agilex: Get ACF from boot scratch
 register
Date: Sun,  3 Aug 2025 18:24:41 -0700
Message-Id: <20250804012501.21811-15-alif.zakuan.yuslaimi@altera.com>
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
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA6PR03MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: b565def6-d621-40cf-4c37-08ddd2f5c950
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5FC+1DyrwPueAfywNKPPyhC7c7uXHTDrUfFTZhoM4rtXNJYyg7VIoHjEzYQe?=
 =?us-ascii?Q?03Eg8IOLSzWAX8NSML3BT1QOLY+el8NLgLU9i/zMS96uFvk/eBbHe7PgCSge?=
 =?us-ascii?Q?ge8j9GnTxnndqxcWykvsMy2zPx0nCHiLt1HYHCOoAZSiejcz5ACk/iNh8jh9?=
 =?us-ascii?Q?w8BzADXOwW49cttWVEczYY2brpGjUop3eem31o4v59NE9xuZyuvwfcUX1Ae/?=
 =?us-ascii?Q?MWUWERcLmNZP1YeHbi42u3kKPgQgnDKOVowVfzKq3IdFubGdIA72JWQJDRwA?=
 =?us-ascii?Q?RiYI3+cNSSgiYjK6iUY9cK58QYX+yBHsWtZ3LpubgY4Jwl561K9HRVrn9Zuw?=
 =?us-ascii?Q?fbW9LVd2yyGVME1d2mMEZV0BQHkVKRSYC7nOQxe++tWzcL/FP/QeBcTywYSv?=
 =?us-ascii?Q?P5wtmjnLh9w2K+xCZHF1QYH9mQAKosOrTPLYUc8JvVqMiEN0iyj7pX6lGtUK?=
 =?us-ascii?Q?JvvCr6+QxzaCg3FSnh9JbZVlUpERqQF/rwVHD5cIpDs4Dh/jG2fhj7IhTQ3U?=
 =?us-ascii?Q?o8fBPML/Vb0hy/IdvK5kk9xg0QUGwUeo0BmW5kRjaZzTIzwMKUpV/iziYyMO?=
 =?us-ascii?Q?IE6JftgKy95P5WGulCfTim96Ip6f6mM0ui3XOfLFsmz5J1fNdRn2AyJfder5?=
 =?us-ascii?Q?YyXCKsA7L9KVxQOpQ5LJsA09ey7gYY3SIlMffVfQZwvHnW9cFYu/RiQwando?=
 =?us-ascii?Q?LLMj+QPPoTgAABXUc+s5fJd5ZndNuuGePqaM0k9NapKNk3sI7K0Zm2vtKxk6?=
 =?us-ascii?Q?MahEeIOs8ndrchXcR0Oj73Vv00l0c3iasGEW6+0hVrPmNQNymWbGwK3b+3ei?=
 =?us-ascii?Q?YJrn3/TaAaWkviKmMmHAfT7DqOqmywRmfq4PKU/iFDydB/vMm2k5OUc8YTbh?=
 =?us-ascii?Q?oHufSx1fgMSO+yPbK7m6H4Mkdcgrj3SLYIjI/Dm/iHmyEc1mT/E0Es8InR5+?=
 =?us-ascii?Q?imH/+hjUJOguGh8giYY/jGIwCdPeyZ/3LznNmlXq/cW/XoisQc7Ib9OkkxY0?=
 =?us-ascii?Q?2RF1H4YVtqjSdfOEKIl9jm+UPe8CxPm2/z5/aBrC5BkTcuQ2AxhffCXsaXN5?=
 =?us-ascii?Q?ESjH0/rj1O/cLdltQ0H1zra//UoUcfks5aCEt1nRD9dCl+EXwICRhz2Voepj?=
 =?us-ascii?Q?wLpQ7M58arDS5jagFP4rLIGeFhARfpWKGjdG0TSiDGBOPcCc2v0YtDw9Bh5H?=
 =?us-ascii?Q?PumZzFGzL3t5K6MmTq510pSSxtaewdVMqBqvvzYYb1e+qGwxuMtFyYjXkaob?=
 =?us-ascii?Q?zmoD/qwU7xqSg35QL+G7ozmAkJwsn0TTcuagpZH0VU7rv+1OvFAu6tKKBU18?=
 =?us-ascii?Q?7VNBU1tjaG/eTiAu1vcVYyGpwKSmJ2N7oHQZ/8QuifaRW8iDEbZUfphN5HQU?=
 =?us-ascii?Q?vEzM2uhM4iy7Kd0QSfZrrZSwrKrkbGjD2HGr6MFu6Rt8cfFoNUQLZIcqfnWy?=
 =?us-ascii?Q?E7y6Mv+Zzq0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VHDpraYJPxCeUvk6GtJLSI1Ye17vws27lnbHUAR/tpN0tK7fWSxrHrybHve8?=
 =?us-ascii?Q?YFnxvCQ4YdAkAZy90kO9yqBwgsCsvOKy5L/+mYnUv+W1gfYnZcQi1hQe9FLR?=
 =?us-ascii?Q?PTkHJ7K4lxDCZmlfTH/8bMxf/SjjOra5bnH6x8hUzWQWovTkpn5rrw6t5gtQ?=
 =?us-ascii?Q?XRHRk1sNBCeqdlDkLJ+6Wwcub3A6bmssFV/VOBt+mxa6Eu0n+ShS1fyFnI+0?=
 =?us-ascii?Q?meumqKeyKR6z1VLy1NPjKxQJxKbfFbgC3kGPunjNNfqscpYjjAiCxYlGGyTT?=
 =?us-ascii?Q?706XkHB+WJDCi0/rsZCg57WycTiLBzL1BCK5oN8MPhBsJLLNAO+q4VCsLgJX?=
 =?us-ascii?Q?Chq2FZypVeCxungsFSiQaLIQp5zDMECpuxkv3jU91W2b0yYRu8W2bEnZq7eo?=
 =?us-ascii?Q?/2UsoI81dgusGTzxpk60oCRCG+7qRxQFNxom+YYmnRq4RWwJDSLHICh51EM1?=
 =?us-ascii?Q?y6o+wfcGCNHt402UByG5rCTMPy1GUcHuPJPyshDJRNhyEI74lVPhQHIbTLKg?=
 =?us-ascii?Q?IsC3TsQTwaMdSIMG518pCpjgEGQOWIsBDH3Qrw16yMN1SbmNPhJ5cve7GIn+?=
 =?us-ascii?Q?9P+MpprB9M0ORx5zpExWJrL83dAapjtT/F3FJUbm8ObJMQNltc8EnYCtEIDh?=
 =?us-ascii?Q?K8crPZd5CJXqoiz+BK3TVuE/ZFUCkGlGkAEXUxQZ+6fjizetY3Zmh4145O1A?=
 =?us-ascii?Q?OrPeSOHju67EtiW/Uj9pWi/tOHnCukaiUGP4X0eaA3035/asVpZpqlWshVKD?=
 =?us-ascii?Q?t2IPuKjQcWBD6Hh3SZYvkXkbVPZfei/wA7pDeFZH74wEAuAWB7NHqgtKLUc8?=
 =?us-ascii?Q?ktC4KXsmKR/JuImABXf+B7ILqjFyYyNWRYyqI/TK5bnkbu/pT03TBuG0W8k5?=
 =?us-ascii?Q?TWaeWLu7knBa4qADvSIsFmjUMObBuzj3VCz/nFKYlRGL+zOlnYqaYhpCJgj0?=
 =?us-ascii?Q?37YoMUnGJUQbieuN1FHJwMP9sw21gSK3/+9xcu9+NA8YMrENVzAzF4V4qk5n?=
 =?us-ascii?Q?0q2Ha+KHOGZ56NAI5FyPDdH9oNMcCIdsAt9gsno8hBbNUW5vpzv3PqO2liCf?=
 =?us-ascii?Q?0KKHrIhXTtQkO+CbhXeOriEoybfH74F0ec1LC0xDAL/7XH26iJxu6ruC7rXV?=
 =?us-ascii?Q?gwkQCuKg0wGpKdSvf3e1QUztFREE38801aNjm+hOxt7rwfkCelUvCqK+iHzA?=
 =?us-ascii?Q?NLtW0a5htyncI0up4uoc/6Rwgf8m+haySOudKY9PAUwTnRj6j8k3n3dgjme3?=
 =?us-ascii?Q?Dz4kGRRXMJ91dfy04tmMunmgg7zDC1GeYpWjePTcIi3Dbqk4qCbRawYUVaLI?=
 =?us-ascii?Q?9JZDIliNdJdow4j3mA1AkVrQc9ulenWQWlmrjnAjYyGEhMOVs+926mERuFp5?=
 =?us-ascii?Q?60grojCEZu6EgspaBTLb3VEzN/YMh7oOGGvDz+TQ0aqqe3WqBcBOyGPOTDmd?=
 =?us-ascii?Q?0zZ57p/X9KNIbVIrFQb8SLO+nyCEEHc/s6Iva5vSspnhznklzGGF6XB29m9c?=
 =?us-ascii?Q?c5S3Ofiiop2na2YykJMBJbhVaHe975u4XX2hddc1j5df8Qsu7xAnuGOzE8wS?=
 =?us-ascii?Q?GZY6IJU4cCJs3aeUFX8VJI2IixtYR4eBEo5YBuCDkW5lfX8LhYA19iSeH9Pn?=
 =?us-ascii?Q?dvqyYBznySTK9MVUGiG8fZU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b565def6-d621-40cf-4c37-08ddd2f5c950
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:24.4571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHAjbSdEAzJ7ZpKwQ+XUFQVh5itLI0jlpT7n0eXHYRrYVFML0Fl2oUdYKcLnufoYYWcPqYs5sknqdq430pRE7yXOYVSpdy1wYlIeWv+o//A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7973
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

The DDR data rate must be set correctly in the DDRIOCTRL
register according to the Actual Clock Frequency (ACF) value.

By enabling the reading of ACF value from bit 18 of the boot
scratch register during initialization, the DDR data rate is
able to be configured accurately.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 .../include/mach/system_manager_soc64.h            |  3 +++
 drivers/ddr/altera/sdram_agilex.c                  | 14 ++++++++++++--
 drivers/ddr/altera/sdram_soc64.h                   |  2 ++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
index 8e12aeec011..0871cf949e5 100644
--- a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
@@ -148,11 +148,14 @@ void populate_sysmgr_pinmux(void);
  * Bit[30] reserved for FSBL to update the DDR init progress
  * 1 - means in progress, 0 - haven't started / DDR is up running.
  *
+ * Bit[18] reserved for SDM to configure ACF
  * Bit[17:1] - Setting by Linux EDAC.
  * Bit[1](ECC_OCRAM), Bit[16](ECC_DDR0), Bit[17](ECC_DDR1)
  */
 #define ALT_SYSMGR_SCRATCH_REG_8_DDR_DBE_MASK	BIT(31)
 #define ALT_SYSMGR_SCRATCH_REG_8_DDR_PROGRESS_MASK	BIT(30)
+#define SYSMGR_SCRATCH_REG_8_ACF_DDR_RATE_MASK	BIT(18)
+#define SYSMGR_SCRATCH_REG_8_ACF_DDR_RATE_SHIFT 18
 
 #define SYSMGR_SDMMC				SYSMGR_SOC64_SDMMC
 
diff --git a/drivers/ddr/altera/sdram_agilex.c b/drivers/ddr/altera/sdram_agilex.c
index e4655877a78..b36a765a5de 100644
--- a/drivers/ddr/altera/sdram_agilex.c
+++ b/drivers/ddr/altera/sdram_agilex.c
@@ -73,12 +73,22 @@ int sdram_mmr_init_full(struct udevice *dev)
 	 */
 	/* Configure DDR IO size x16, x32 and x64 mode */
 	u32 update_value;
+	u32 reg;
 
 	update_value = hmc_readl(plat, NIOSRESERVED0);
 	update_value = (update_value & 0xFF) >> 5;
 
-	/* Configure DDR data rate 0-HAlf-rate 1-Quarter-rate */
-	update_value |= (hmc_readl(plat, CTRLCFG3) & 0x4);
+	/* Read ACF from boot_scratch_cold_8 register bit[18]*/
+	reg = readl(socfpga_get_sysmgr_addr() +
+		    SYSMGR_SOC64_BOOT_SCRATCH_COLD8);
+	reg = ((reg & SYSMGR_SCRATCH_REG_8_ACF_DDR_RATE_MASK)
+	       >> SYSMGR_SCRATCH_REG_8_ACF_DDR_RATE_SHIFT);
+
+	/* bit-2 of DDRIOCTRL: Configure DDR data rate 0-Half-rate 1-Quarter-rate */
+	clrsetbits_le32(&update_value,
+			DDR_HMC_DDRIOCTRL_MPFE_HMCA_DATA_RATE_MSK,
+			reg << DDR_HMC_DDRIOCTRL_MPFE_HMCA_DATA_RATE_SHIFT);
+
 	hmc_ecc_writel(plat, update_value, DDRIOCTRL);
 
 	/* Copy values MMR IOHMC dramaddrw to HMC adp DRAMADDRWIDTH */
diff --git a/drivers/ddr/altera/sdram_soc64.h b/drivers/ddr/altera/sdram_soc64.h
index 183b1a33080..4c1205b63b6 100644
--- a/drivers/ddr/altera/sdram_soc64.h
+++ b/drivers/ddr/altera/sdram_soc64.h
@@ -48,6 +48,8 @@ struct altera_sdram_plat {
 #define RSTHANDSHAKESTAT		0x218
 
 #define DDR_HMC_DDRIOCTRL_IOSIZE_MSK		0x00000003
+#define DDR_HMC_DDRIOCTRL_MPFE_HMCA_DATA_RATE_MSK BIT(2)
+#define DDR_HMC_DDRIOCTRL_MPFE_HMCA_DATA_RATE_SHIFT 2
 #define DDR_HMC_DDRCALSTAT_CAL_MSK		BIT(0)
 #define DDR_HMC_ECCCTL_AWB_CNT_RST_SET_MSK	BIT(16)
 #define DDR_HMC_ECCCTL_CNT_RST_SET_MSK		BIT(8)
-- 
2.35.3

