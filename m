Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AC6CD98F2
	for <u-boot@archiver.kernel.org>; Sat, 20 Jun 2026 01:07:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66EEE849AC;
	Sat, 20 Jun 2026 03:07:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="V+atsIV2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F3DA849AE; Sat, 20 Jun 2026 03:07:21 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7128A84901
 for <u-boot@lists.denx.de>; Sat, 20 Jun 2026 03:07:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ShkjxjtOwzlo69XMwpm2gubJJfu5JeqT1aAZ1PGAYiQVXbreFHUiS17qdXbw9dO2oifvBtLK88QK8/R9neHWHBN/EwAONkX1JMOZxhRaBblJjWpQgZdSlpc6OaiH9JSz5zwvOO9JcMzfTTFTatNTbNn65BNofUDxQkgdcyZ7MuqaKNgjcye/s59muu4VEjZ6lay6OS275Z6vMDMknzgo4xJfR1ttysvTyO1pvtzKUBqCkYQDeRw+YohAzdHUREEjyZ9Cbn1si6qmcLgn5tbbO8za1STJ1z+SQVtQ6uaLI1HOh4iamOVxt2kQD9NY2LXxjsBRl3lLNTe20//TduxTVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRdFrdU0pwuDShpUINc2ouMkE14BvmsHhQjZP/Uxg4s=;
 b=q3vFkrj95I7cLGZez7cY9gOQtM4xoKuANrRKO9gYFmF0l/kbUAUCa7eI4zIFEKztkiZBMeqh7FnlRGJQr7oTzQSlS7aQKu4ME9e/F/Xo+D1tMjtjOdApqcNT3dl/2yI+FtlXhPve4jIARFN+QmmIxGTT/DTdnL8uMvHthHKcG4q9xP8BHttU7NfJqefRbohGEDSMjiWP59ydxBCiZwXHieAv3dUO9/z44QfJ27l1O3Uf5v5lBCW4aQeT9j+9vhIs4TwWUrTEUqlExc5wWfNkszEZ3YAuJZp3Dh0J7mwnnLkJtD5dGd+eLH0UREzVqRmgf/I1ivN7UWj63Fhz/VSY9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRdFrdU0pwuDShpUINc2ouMkE14BvmsHhQjZP/Uxg4s=;
 b=V+atsIV2U0VDgIPmUZr2JJwToYIwEvww6oxIn/CvKyEkXdnzlwNI8TzYwQAOLqvR0yf+h+3UX6BpY/PnRepbKn5YJ/a1fnsRfMW2RHm6is00rFoY0TAd9sAJHSkfuIPlnKTtj98l8mPUqXcLbq+jnCRX2QgGcSHybGwXHA4N5okx8g6TakWS3sRq9WC4/TWwo767/qJeMlGdK6gZo4Bm6eXRZ4CSFl6cK1PCcth1esv/IAZlBVXGVKLRIQA9SF/7ubY+X3O/XiXO9c9hK5OeRZJktY4eay6Q9H0CpF2JRgl1rtIYVbbVVqZdt3RfrQ/qaAvHIwUgm/hbnqOBTi8tSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DU6PR04MB11231.eurprd04.prod.outlook.com (2603:10a6:10:5c3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sat, 20 Jun
 2026 01:07:13 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 01:07:13 +0000
Date: Sat, 20 Jun 2026 09:10:30 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: ye.li@oss.nxp.com
Cc: lukma@denx.de, festevam@gmail.com, u-boot@lists.denx.de,
 peng.fan@nxp.com, uboot-imx@nxp.com
Subject: Re: [PATCH] clk: imx: imx8mq: Fix iMX8MQ PLL issue
Message-ID: <ajXohj6KBRx+toe+@shlinux89>
References: <20260618055856.3185658-1-ye.li@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618055856.3185658-1-ye.li@oss.nxp.com>
X-ClientProxiedBy: MA5P287CA0141.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::6) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DU6PR04MB11231:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e25259-0053-4c50-5135-08dece684307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|366016|1800799024|376014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 69DZ/1U+LIsI5JX13Vhw1674XAKS1hjLEEODLx1yTocxCpqP0+M84F4UNOepZqW/Ww8JTVTiZUhlzsDjeACyLbVsXFDrppD5NC0aznh727EaYj0qvMh1WKRPCMWg9CsVdBSRUP+WXUBilwgOtpj2PakmpmDVlQ6hisBn5l3cdKR28HNXGD9PveqmGylojLXHDItSncUN3/IGqYpcmIDPCIu2T3mbU6U9StqljNeg/nKPYIK5tSZyyG9pcDDOdbm7IyZrGdD9szlxAvBMLfJfREeZPqHr55OSvRy2GvohGyDR7WrpTavf6e58NbibNAvW7t5g6FEfQoCgAM6HJ9+b1u19bgTLYG+m17++WDwrXL6TRDl/y5w/U/bplTumdH8kkhwNruirqndWle//IcqaXJ2eKXLebNaDao+wqTnancWrvloKlNmg4XHSMlyw8kIkFVmnwlbIy3QEQO/9rTZvgxpr9GcUexy6WGZHxUGeAdXW8uUcm8dNoBtXUUEik3hNrjeue6VOedhapkjX/nNno0o+CLMvfutufXRSEz6VdnMFP6Y//4Ok2ZsAqqMsUih3seRHdlguMwjh2J/XhN1+eOgmtlCYilaMNWtD6O64ptpd0MXlMoPD4R8b6KIT3Wsb38/eN2nQoM9g+8qTsZ92lX2n3bqtAS/V3xnLlhL4thc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KNOPyGQlnjIwdgmMEMQCxabyvrCXnizyB8ctDX03GO1gd21inv9Yp9dqGJWK?=
 =?us-ascii?Q?26EUf00+MR4JJJCU0weir2C95XX9lmpZ+S0lH4f0+E8PSc1i+2HkSTk7v1OQ?=
 =?us-ascii?Q?CuSoj8Gxpb7wcaNsmSx3vdSL4cQGBNRE/oBW5wTj75kZ3PNEKrdBCWkhXo96?=
 =?us-ascii?Q?XsGPdJiZfEVa/4Qc/8clj0RaVVVdfVk8eUU7NwO3MsbuOEJsXw2ETp5lI/3n?=
 =?us-ascii?Q?htQ6kY+TlXoAiPjjDi+UVrpbmU2Hqunn1mmnjfQMvx0CLCcJAsKLSKjUH4+6?=
 =?us-ascii?Q?ZO30KwDeQfiHR+ridrasziswxrIr58mNCf9QwE7+Zar+l6oGMdNrWL6+JJVV?=
 =?us-ascii?Q?DlEWUc/H0OsXvxW2tRsZkVKHMPej4pUnWsUunyOzP4jJWepmNfNMkTtYBRX5?=
 =?us-ascii?Q?T2DNPLMxndsI0kOiVOenziwLta/5xdlfiP7+6ACtH+hi2+3lF9BQQe01VG5/?=
 =?us-ascii?Q?cT8t7bj0KUj83GcjUjM4zQ/In8nnbb0maZRCYmgFpfYDnB1cVcCbdBwf6LyV?=
 =?us-ascii?Q?rJEQdiS7XGz2dxhB1HRHmwvqouAKsgXgFt6sCLiRlDgWIB5dgB4S0WkKVPRg?=
 =?us-ascii?Q?zriafI3sK6c3BNRMreqpzE0Y1d4RTAdAahGFKAkrQf/jC26cAux+SNM6XV8H?=
 =?us-ascii?Q?0SmDZJnB85gbNIlVX4H0FSYku//erc9IYoZqWFqYKdz54lzqlqiiN8V6iqD0?=
 =?us-ascii?Q?egpFNUiZIVwmUV6ETP1LBdL9pZyKCC6KWoGVF9Lx6jxnd1g2Ftq2ULxJgd7g?=
 =?us-ascii?Q?WLKAi56NZ+yFYZGrdGFPkgPbDDratVbdXxC8Z5byxen2RSIkyHo2Psj9YGkt?=
 =?us-ascii?Q?fTEKNvCIdJBPD3BUcStfzFeFMvaXmueGT+xbn+Xu6Qwc7DtFbO9xxaa/eSEc?=
 =?us-ascii?Q?1AU8QQnFrUT46wLzUX+I3KFvNSjkSPZBD02AStn6Qd28rMouCD36eyZUqNXD?=
 =?us-ascii?Q?z/3+Wz63+DR4tOt40/C36kVSg9ZXVvrW3TlaVGku2FoQ5178brJ67dmV3Jms?=
 =?us-ascii?Q?Wi15eyD+2Z8PLpkPXUfIF/COsZ+84LONkmdhnvS19IqWkGazRICVa08H6PBa?=
 =?us-ascii?Q?XkUAlcTfBeMR37y9RNbBnbk3Q10bYbRS0MhxiDmMxrF7w7+9x8g4HJR/EEot?=
 =?us-ascii?Q?NMlAirAOtT/RsidO/X4YNKEAVAxMmvJiz23l1YXKtXZWt8YcL8RWzRrs+Tny?=
 =?us-ascii?Q?7RqOqop1QePf/MNo7AQb8akpBT+Q8lRllYDBdTOVtybTmwowVflpSik+p0bd?=
 =?us-ascii?Q?8zP0YAQZ4ukOMfNCoVwQZFz92Z4rsRWoW1q6eMEViBWkjyhZ3VUOe7OAK15X?=
 =?us-ascii?Q?QaCMPac+4TLfhmd/TsF2FVen+V16rhEEfensq3G0VXaExY/Olm3UYyWr7VyR?=
 =?us-ascii?Q?vFikJn0+T7eWZ9SKykdkXHAn2STUpa5dgWhH2y1D58kSsRbqv+YdyQ8sjOsi?=
 =?us-ascii?Q?7valK03wHEjUIORd7IiR+A/4XDLM58S3GKKeGskBfChei0txGHDSJpyRdCkB?=
 =?us-ascii?Q?8Grny3ogLhKeNNCo3Upx7GiKIoD109063PCcJE75KCIfNBdCU7LajtH0E67V?=
 =?us-ascii?Q?Wjd63bA6j/3kiwDYq4elyt4r4JLdwNmOpyySRtj2weC7vVXni51O/sPlEzg1?=
 =?us-ascii?Q?m6M2AGum2MPTGYkpMzdvEiDf4Iug1GGKDA/agVgLoPl72EWKQDSXgTKC7e8b?=
 =?us-ascii?Q?oHB2CT5ebEo12MkvmoWMaUoavkBwPqSjlU+Q0+k6fYb9NCRUpvFgb8BYA2T/?=
 =?us-ascii?Q?zueDTpF6TW7HCRq8wHNY0joKGlOgBn3YdSfWXI0u7ZlNusHc1Z+N?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e25259-0053-4c50-5135-08dece684307
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 01:07:13.0944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: COEHiI7VoicuZ5XI9nm7Vzyw3bZS5wMTi+mUwDpIimLRPxvavkxjLoECvINNdeBWwi9xcE+1AysFaL5JRjdMv+n4UEnlBhAWaZHDY0iZxTcyD12Z+pbeYNbJRnNwcklO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11231
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

On Thu, Jun 18, 2026 at 01:58:56PM +0800, ye.li@oss.nxp.com wrote:
>From: Ye Li <ye.li@nxp.com>
>
>The fractional PLL used on iMX8MQ is not pll14xx, it is different
>PLL and not exist in u-boot. Add this fractional PLL driver and
>update iMX8MQ clock driver to adapt this fraction PLL.
>

Better add a fixes tag.

>Signed-off-by: Ye Li <ye.li@nxp.com>
>---
> drivers/clk/imx/Makefile       |   2 +-
...
>@@ -0,0 +1,199 @@
>+// SPDX-License-Identifier: GPL-2.0
>+/*
>+ * Copyright 2026 NXP.

Nit: Copyright 2026 NXP

Otherwise:

Reviewed-by: Peng Fan <peng.fan@nxp.com>
