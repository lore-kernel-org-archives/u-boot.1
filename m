Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04020FCD0A5
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 04:11:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EE9D84118;
	Wed, 18 Mar 2026 05:11:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="vPvTvzqN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC354841D5; Wed, 18 Mar 2026 03:59:30 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13612840F1
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 03:59:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhF2zRwtiLkTmPsZKazDunmYNfrzqpz/K/yt4a+XetMyZDasN3YUFeNGys28WczZX82RgkhIMpGTtWjJ0plBpYk6jYxBTSifEWnumk5afMIavaR7P3O+MrVjiDuMMPiQeX3ItCIwTW0G21cQaYGibOmwC2wYQ4l92gCpS0YqdWnBb3q90bpjZb40NA7+FAqZL7+lfPCpbxml06FNuhjVk46No0BzxInkmPeeTZ4rWr6NrWBS/xcwe34mnE/3MglTN/bT1T6aeLmzZ8L99f22GjoGu8wOuxfgRgZA5IVmsss5nwYMliXoEW70E+XKyTocPNDjmG5VS6VBE+mrfH30+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sn5bq5/31iDRseebcXz81GK+ydpWShTQdhJGS7SQds=;
 b=uF33htlNKrizf06l2pweIBms1ihqVSsYd9SkjtbR10vhaRxlb6r7SPCJGqnLNt6BfYMCNvBDlyxegdJGDxgeZI2U305CE8PUUwrCGbh3al83WK8pxzYfTALoLeXKBHW61S/Z/EhikPhQj5rycqaA1vsqz9n7DJyzvrgsTVInEsDR4z82PB6gE/hX8pcla1wGfyHSpYQSoDSBLxNp4xSwmjsT2i8HzzCibP7CQInv6j64HyFFjhtgSsJLUtpXjN2uSRSC6DyNf7XLJ5sutNfFMOzSn7PPtWp+RFWMhaF6pgHrnsMneL6VzkHhK7D/QD9P+s5MpcYx7p/+jWKFTJQyyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sn5bq5/31iDRseebcXz81GK+ydpWShTQdhJGS7SQds=;
 b=vPvTvzqNwKOrhf5RoAHsC5F+T/j0OgjCsx6TgW1sS3zm3wzSjO1FvWdCI40zAjdOrZKeIo2Ah9gZ0KklXnq9gkvasu9Apv27NOMvZ07IOqZ3gLsJYO/VqkJOFWwRRlN3kDXBHidFH6/j74TAEgyspwPZDXG3wQyBmxxDwbToceHrkeYSAoBoF20P7v0XNm7JtlMVBIb5TCaqd9fVnn0AioVNdXmvSuSnKMY8PBy4aRIMOk2djaFDzROA0Tqoxxr+tOjkZmHXHqyFtGoK9l+EM0jB1gHlV/SnwEO0a2ksYD8X1071XSZBORaBN3CcvIsuAd/W4kZQ+vwGje1mqxErtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by BN8PR03MB5092.namprd03.prod.outlook.com (2603:10b6:408:da::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 02:59:24 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 02:59:24 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Vignesh R <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v1] mtd: spi-nor-ids: Add support for IS25WP01GG SPI NOR flash
Date: Wed, 18 Mar 2026 10:59:05 +0800
Message-ID: <20260318025905.13304-1-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::15) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|BN8PR03MB5092:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e780a8-1e38-426a-ec6d-08de849a5c1d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|55112099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: GyofsfdNgyhMRHDulONMsIz5l89b7/NTLg3/kazG+0KE/va3kh0x20y3tbaGdll0z4AWEteJANgnKwIk5Smp8+AzGVf4rF7GuK5U2xbrpKCWS8x2ENdoFmiib8gbZxyzGW79jwzGFwfyW0IyosYOfUMtmbk6Lw8uSo83zBsTImQq5YpHerqobEixr4Qh63EarBZobS6Vw4044tYDfhtkgxznw54ODa++Q+TJfrgh/WAs+sMgrMjyRS8IxBsImftjdRDDmdwUo1GHh+2OKdJwUaLRnvY6XDFG7RtBTuOJly4+XUyRv4Dot6J93KHOnOglWe6oNzjMxnDiXspGS3PkknoQy7kTtdu8lVaqzfHCWxOo+2R++qvT4ueeUlLAMvyqqOtmRyl3bbfYG41rhCoIehrKNdZpvwFUhs6LzIPNLk9AtGsZijWt0uESmnsQeOGcSkCAkOkzVmm7ZI2lik+bAy9WbxIyC9OUa1CcdCVVtKUVnozLKTD6EPtlFqIBftXvriLQFPKhhoGsytLvOd7ts4n8tAMwec06XBhxP27rFsFC1w0ExYFU5mPapvaths4KXJJJO18SX/vugsJ4zh69lF52CFwir7p3qHnRLtjBToRWw8vDbIoWseSjMu8IaWqc7j6tU/xI3IgxQCVkIFzLixdAyYFytOQKdFeQI6VJIoCzdYBFPrlMjNS5WjNqjd6NFPTZpQm6zkk+tJpFKCn23cvqKPn2Ocl2Tn2J/N4MpO4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(55112099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?obws3xdFa2tq1adv991R0LVnstCrxKU5kv3SU5XA17avand0b4xhyDG5o1Y4?=
 =?us-ascii?Q?0bDFL5nY4FZOr1SX3fFY0vJ7bPWOFLbf7amarEataFIziiz8wosezTlNsSu6?=
 =?us-ascii?Q?UWEtBkZWxnQhCgOqVQXCXcUz3PqsJGZwLXv4jZ/TR7IwEicp90ds38T/czsd?=
 =?us-ascii?Q?JQUXJrxI3RFwgTIg3qYdBCn+i25hkslULJ6zu+oqzuHUUvdH5ncf4xXePeUD?=
 =?us-ascii?Q?Je37hLeMFVxKlz6mJ2Hn/SkQjJTpBtV5L9MytsWBl5bW8bTpYwGrulwE0zQ7?=
 =?us-ascii?Q?nH7LsDTYk5VONel8q/fA2TiPyyHMOwB17PminhCKIm6lF48Kxi94g2zpGNg/?=
 =?us-ascii?Q?XU4EXAQfJtrKep1aaMBC6GOEdabV1I4HhEZknu31rfmZCnTm/cTdnImClOyF?=
 =?us-ascii?Q?IQJRwoqtfGsA38RYIgFtxTV7eECqkXnsGU7/IkgncPi5IEZCWjpGOatrF6Br?=
 =?us-ascii?Q?aWUEZo1MRnUgQFjr57mS10taDQGT/XirlONJkb+ZZm5nZewZ7b1TOuxZS09H?=
 =?us-ascii?Q?/8HO19QuPUx8k21r+zgPJ64PHfGrr6z6EkNNSwVuVYtGZ2f69IFVGqT8Bfl1?=
 =?us-ascii?Q?2M82RqAg8wGGSGP66IF2sRCxFm7xigNKDgMrU4u3GTOrkM1DPXBeLioQtAx+?=
 =?us-ascii?Q?uHO+INXINpCuipYnmyNcKLMXd1bBhcsR4phU+GetzsxJnEwN9/Agjw9/S2lB?=
 =?us-ascii?Q?/baAooSTbbTsdatX4ntsZs1vGANlaByw0dbet2lE40yUZ4Bj9N7p/bMbUZbs?=
 =?us-ascii?Q?Zm+Bd3blXJw/u9M8u5KsApw0gspo35zfvHJqVPyZB8zQ/R03zEpFlaiTFORy?=
 =?us-ascii?Q?/paxA08pZsJUWWW15Fc5prjGBxCGgCsoF5fXSJ+HkoPFRaqGN8LmCuX3BtdD?=
 =?us-ascii?Q?Z2eL1oz41vCorKkibrckCQQxnoafbDN1C2Y5a48RaOlgrpKvqSiNrhAt4AaC?=
 =?us-ascii?Q?VjdYaKKcWvK1024aHNSGA6RISFEOdAvWwThFcwxDQvxmCQzeWTVlkcnWAdiw?=
 =?us-ascii?Q?6dzAb4YN6vLl3iJUp+zix9Qzb7gpeo+2sr2Kct7cMxY2DwifQezFYfjBmAvf?=
 =?us-ascii?Q?pHy/V92Cf5DMD2TPwxo0GVAqQQELx/uSeGRgcoBzWZGdUPBld4S5pFPeoxcg?=
 =?us-ascii?Q?pLQ15RAnPlEBI9fldVdTQF/5D5eHwq9d5r5299dYXgd13Vp/7IyhWDFuSUbl?=
 =?us-ascii?Q?SM0zbxnLcUO/r6RS94jK+uT5tLVqDN3dwEPf3R/EAl4kUdl+TvFILTz531fn?=
 =?us-ascii?Q?zuOZdw4GvcKadiI4fxFl/jMv8u9da89BkZy/uzF3H3wL4m3+/NQBS/yGfTNR?=
 =?us-ascii?Q?ebxyzUAs3iwH4ZF9VDkzKrwWIrMD0jsjp1JPWqqNOIJ1GDOQpqeTXV9zJTCu?=
 =?us-ascii?Q?VuWdRPQcfIyuEZ34z8P1Z6kl+Qgkh6K0YInfnKkUqrV5N0ySjQ+m7PQBX4Ii?=
 =?us-ascii?Q?p6CjEmUjo8fUARfiPRVNHj47RYLlQR0XRTTKnN+sK9gxal6lyaB1tSXPWNBQ?=
 =?us-ascii?Q?Mf+l99U51H7x98WckTZMZWffqWtxqcV+fruWjM4MDjJsxuLgpp24yC9lpETR?=
 =?us-ascii?Q?cYqL64iX7FbGAnloe1tsPtNx4gxPWPLfiLqRLAbeQ+fs6g715guRyLDcnVoL?=
 =?us-ascii?Q?PdotIIp6gLeiapJXsSooZ2YqtClu9ED3DEbh50jxxu+hqGG4AcmGxJUwPOAU?=
 =?us-ascii?Q?DxDoMMzmjgqSA7xoBGwiW35t2bB9LFCs6yuHO+tCYi+7OsLUAV8E8Dyx0Z60?=
 =?us-ascii?Q?PP47s5SrgJ5t+nbXWho/7O/EgAjp8q8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e780a8-1e38-426a-ec6d-08de849a5c1d
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 02:59:24.1663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLluEnU1kk2Hc25KcegX1QsTgAOeeW61OWyP78ipf35JKp9aQL9v93v3h9nPAEYpfGj4gN76lVJLsBRODEWaAsArn6HWda7szJ+rfiKNeEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5092
X-Mailman-Approved-At: Wed, 18 Mar 2026 05:11:17 +0100
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

Add a new entry for the IS25WP01GG SPI NOR flash (ID 0x9d7021,
64KB sectors, 2KB page size) with 4K sectors, dual and quad read
support. This flash is used and tested on N5X boards.

Datasheet :
https://www.issi.com/WW/pdf/25LP-WP01GG.pdf

Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index b6a07fa9063..3e82058e9df 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -237,6 +237,8 @@ const struct flash_info spi_nor_ids[] = {
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("is25wp01g",  0x9d701b, 0, 64 * 1024, 2048,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO("is25wp01gg",  0x9d7021, 0, 64 * 1024, 2048,
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("is25wx256",  0x9d5b19, 0, 128 * 1024, 256,
 			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("is25lx512",  0x9d5a1a, 0, 64 * 1024, 1024,
--
2.19.0

