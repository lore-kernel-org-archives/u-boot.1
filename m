Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A70C43602
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 06:27:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D4EB807C4;
	Mon,  6 Jul 2026 08:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Quiytmyz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CDEC84105; Mon,  6 Jul 2026 08:27:21 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73A7180398
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 08:27:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VnKvFEeRBF/kjfIlzkRJWTexCKX1IRBthHPvmOPtn90JTOWbxa55RYzB8vFOu9CkijDzF9cu0W5h7bifDHE0Vt8KH6FJNbYFbmYktX3Jt+vHn8AYXjO6jK8ARevghEUk2t77P6JVb9BDIkD+6BQx8yj84mKUs4oxlR6YQHMdCcUUIHnHJKuFuYLn2LOGtSHlwwwt16nttbd5EqorRZoY2oX7qFIrGSHRqY0mLVLxcCAR2sUhOcLdzKKDHlHYRPSztZ59qQCaNcutYovimuMULFZnBqPhyVixhJ24M54K8vNB8x+XjhUghxBY6+OU3zbURaIXfIiXy8zrq0a3gMcvrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4T9HUgrTO5h6Z+SwtdepSiMSzxtEgyD73qD7Sv9d94=;
 b=Wxi9B2ctd8HuTeXaKMivzCnN5RG6XkQMzqhXv1dGur1Ufhl6d5py69sVL30tD+S0tpk8veYvf//q1b5k29z+nlwxUpg16HtmEAtlWcb2yTpmbFt8QLg9TduVAkrtIV7Q8Na4hNYUGjGBDvG5BcLkL06sxrUsHvFSfx7zUMs4aAyqDuHvsA241Tq4Kd7CYqROL/dpw/6iTB6FJjqtvciycVWoncKkNjwaTQoRmt/ieYpb1THV+NN59nVg8unv0Wbk4I15wkGovABhAd5w6A1u+dPIpvf0b4PcsX4Sl2nEhMH3jDrKwq5CfOsSW7ho1MySEJ7hB/m0daQ+GbDs+CKGMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4T9HUgrTO5h6Z+SwtdepSiMSzxtEgyD73qD7Sv9d94=;
 b=Quiytmyzv5mVcI9paA4Z3gt4wlpWsRRmvq/lXgLGPOFy9Q5CZcWvmSWKa1sDgqWksRFUYC/rW2ZPpkHKrPezxoHREUmXBT+SCjjooU/odCEnhZUxKLRrlxI1B2amvkvM64WabFRcE9/3IJFPjaCfZhaKrSGzppqq/B11WIPUlG6feFhMLFYEqvObWwvPSuu6b3Ca010hbuqSQjesuiXx34FYTSgCI11v9U/qRuSTFGF7/bXWi8GLC/3ZF1eQ2BtH97mhshcjGth7CAv0ar1qT1ikIqN2GH4LeRT1qZKyvpM5AxV2SOnd1xQpa64MZugMMqaq4UYnpKyXlcJhCDP9kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AM9PR04MB8780.eurprd04.prod.outlook.com (2603:10a6:20b:40b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 06:27:17 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 06:27:16 +0000
Date: Mon, 6 Jul 2026 14:26:02 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Mart?? Alonso <martialonso11@gmail.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Han Xu <han.xu@nxp.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Tom Rini <trini@konsulko.com>, Yanir Levin <yanir.levin@tandemg.com>
Subject: Re: [PATCH 1/2] mmc: detect illegal command response in SPI mode
Message-ID: <aktKeg8HrpWjhyRT@nxa18884-linux-1.ap.freescale.net>
References: <20260614000543.2098992-1-martialonso11@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614000543.2098992-1-martialonso11@gmail.com>
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AM9PR04MB8780:EE_
X-MS-Office365-Filtering-Correlation-Id: 10daf9f3-9575-4735-ca46-08dedb279f83
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|19092799006|7416014|376014|366016|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 9J56T6G51sqtDQwNZ6Zh8Q8KDpL3z+xEPavvNKHipiQt4lOANaV8tmxRn3LBrC7iMTluoO3hm8+XAHVHsQViN96GmnZCqxe2gTR8JBGxK4mpff6tkhsRsT8HOz5RI2cCck95u5DFLS6AGHqMKaIOQ1ySZQCMWVpYQ23ijw0otpnL2rM3jlOrpLvrupdVGeagJy6/itrY7zoJQ4bbCtHxn/oaCAcCauYCaaCoSXwCHoOmGMq7VoKie72JXkn+jFG8RJntrbHU+YC9ASgQF+18LlzUWTPCOI0t2eTVAY2PLRe89ItLdGzTVBRAo3ELgX6raa5e+kbH2MlhujH6RNECvXPWJgDWQnxTYqZXq7yZc0ca3tjvgFCAmAdIv4J0ZTzIkZKxWrQicVW0B79hGaKoQr8U7tuvuVSVRhcEMJCZLDNjQyICk6TRTvQa3bLmhToibNqc0xLGTJcC+TklGqo3DaZbD8B8zLNP7WvX8wknvuRN72vBEcsr6RA1JfVaRoPFlsRH6s0p9A+2sj7Tg83kbBaLorMP9HH76esJlnD3i8j5zMXO21a5aXOaXCCW2IUrZxTUfRJK8NspSYKqdGg9V+uUfClT381W+jfslR8+tkz6sub3vztY7ct4r3uBS8ctPqq9YkP4Z6J8wHYP8fVRx8lv1zpIZSAx/gi2JjsXLKI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(19092799006)(7416014)(376014)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iObVUHK6lxkMJj9ftGPc2ZvBS9EXrgKjf/ApEJvC7e/MuAocnUsF6oNdq7Af?=
 =?us-ascii?Q?2DFWX1X2n7Ga8Lnk69dMblLtQBwbTaJ3f/JOXwKuJy13A2VDAa+UJrGI+gjL?=
 =?us-ascii?Q?XaSXSwibBG9fmTv5LptBxSu5B1bwUtzTGC3rLHYuHuw7aFtK9AB+NO3x/LWb?=
 =?us-ascii?Q?AQ7TioEB/BhjvvsV0TleCJpaT3PP4YorfHIfEZqzzSkUsISjxNpvz9Hm7yVk?=
 =?us-ascii?Q?Mp5Z+VJ8W51AijFHMV4EG+MtCVN2C4ZEuLHzivAtsfJcLnsCWrdswY3TUL3Z?=
 =?us-ascii?Q?sjvJo2pJIedj6K9IT7d3MswHe8Aq/RyWcEvYfiv/scuFYo8z1/LVTRRaIdk9?=
 =?us-ascii?Q?hPB8Jk1MiL7yeLx8CPR2Pj1vKI+lYiagiTfRwbBkCpFrP3ddvLYfWZf3gL/A?=
 =?us-ascii?Q?L1ruH28OcSBLyLa/DQAxsZP7DssLVF9+SjIVTawWHOgUOuQMw69jr1QSqutx?=
 =?us-ascii?Q?Fapy4mv7Kogrl3wN9RcsrUJd97+IA9DlV9QcX6qCbwdVmCXb0kgIo1N0C45c?=
 =?us-ascii?Q?dTkmz/mlrdOdx6TzWk3HBKqEROTWozB6furm82i400go5yVWZtKtC1mBIgo8?=
 =?us-ascii?Q?hQxknib7BdnrVXUbnlLFD1J2jKuP2a7IgQwf4G3kGCLtcKyyC5Z+RRsp2dFU?=
 =?us-ascii?Q?anJMJtvGKiNY3DNY925L+x4vePzHKqqGV7vR4p0WR1gie3JDtbieo5uBZc/m?=
 =?us-ascii?Q?4fpukMC27lLl5qW9bKgREBrimMDHBbUrK/xw3y3nU1iS7grkYvlljcy4wMxI?=
 =?us-ascii?Q?xJuxZNPvotEIf5WbZ3HvFiO1MtYi1a5O9rK9p7tc+qLpC/yvyqw+9QiYBRVw?=
 =?us-ascii?Q?m4SyS8Cd72LwRugnIjXW54OnuQ7u5z8R8+fYK9XVWFk2bAmdBgVunC4L4tEf?=
 =?us-ascii?Q?KhQmBTwV/2jtlu54tLsWe9xyInRtvRdAXr3t8TsoIFIPrKNgrcjAqbk2qGTo?=
 =?us-ascii?Q?vBgG3JJ09y6y5ycca9NctZ45VxrIW5FzEWc1/klXb6JUzU2lJSytRqbDM9AU?=
 =?us-ascii?Q?DwXHgkc6zDg8grpeoPlZxhp4/FfVZBCA687KwCkGv98YGZEccUZZQdsLZA2B?=
 =?us-ascii?Q?ya5Atep2zxmLCVRAR4lMq2fIj0KjAz7bDJS6fV9P+gibAAEx1Esa+ukCVdZV?=
 =?us-ascii?Q?XRjLSbgqHkJFEGAgoczz08V7Hes7Koojm9FZqt3Fctf3DI0uC0QLL3YNuywM?=
 =?us-ascii?Q?jnT4xwBCxJKp+fbI9peGdIxxd+QpUpXU/RoZ/87mwwBrwg6DXhsxdd3EDlFe?=
 =?us-ascii?Q?MG8NEa01YuS83pMeeAD27dcN2HCgyMCGJLV5PvPackJVa4b4ciRApsWBCJss?=
 =?us-ascii?Q?tcdJHyTp5Et5DRYsSXM6r7xAOdZkiGDXVTgSFR0BKaC0j4SZ5Bet4pL4ckyW?=
 =?us-ascii?Q?PSHmG2B7PgRuseYfTARwzDS94JnZXw83zuwzLQYljByFOf1WzlEE7Jen/152?=
 =?us-ascii?Q?mphtCeiBazOIknxkc7icWEW40q8RWw9aNqBsy2OfTnyfuEyyRwIQ881RPgik?=
 =?us-ascii?Q?eHVxLgssHfC7gft+gRJFme+YNho46ngOIrOpMjogZsfZn6O30c0tEBbO7XIN?=
 =?us-ascii?Q?yIoJBxIsU3jFsTn/hhEwC4sW13znouTQxBFJ4o0TqrFGA1P72VlZL9sDWodE?=
 =?us-ascii?Q?O3A77uQGo7hFrZSD814WzQKXGvecYKGTcTRHm2QTWNeUM6DO3jfVv9gwfNKf?=
 =?us-ascii?Q?PrCGhu3eqvtaTUFwM8JuRY+vqkUoQHbwImiebfY/wLgNP0ymbNu1VrNkBxjW?=
 =?us-ascii?Q?01RBtVeYE3dDQfWk5cyE7pLaPLyCMcuJn71paKlZBuxTRaDxbfji?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10daf9f3-9575-4735-ca46-08dedb279f83
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 06:27:16.7363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qN+ZkI1MzySxmbyk0jajDUezdYms1whIZfyjuYs+pW43nmijqo6tm2EGGINIAt+M1O3UBj8P6BMDrYfSeOuzweTAtVBzUQVHlEeh5MgNbVqjT5OAV7VgLaKSdrGDzg6x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8780
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

On Sun, Jun 14, 2026 at 02:04:37AM +0200, Mart?? Alonso wrote:
>At idle state, prior initialization, MMC cards (not SD) will respond
>with illegal command to anything other than CMD1 (MMC_SEND_OP_COND) and
>CMD58 (MMC_READ_OCR). The MMC driver initially sends CMD8
>(SD_SEND_IF_COND) to check for an SD card, but this needs to return an
>error, if not an SD card, so it can later check for an MMC card with
>CMD1 (MMC_SEND_OP_COND).

CMD8 is supported in SD 2.0+, so this might break SD 1.0.

>
>Additionally, CMD55 + ACMD41 (SD_APP_SEND_OP_COND) can be skipped if
>CMD8 (SD_SEND_IF_COND) already failed.
>

Regards
Peng
