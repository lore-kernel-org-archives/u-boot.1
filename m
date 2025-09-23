Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F026CAC5B0
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 13:04:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DFE78349B;
	Tue, 23 Sep 2025 15:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="B5E81CAU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A21B80C93; Tue, 23 Sep 2025 09:58:51 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDA2F8004F
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 09:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXTo+CaCuA/z3en47TgKfSItkjPTbuBGEidw+gktJcv2Oo9qBwnb03lk7pjrYHtSWwR9utKWNnze3vob9+60yWgDkSHvWqXWrPuf1XQZq+vRqr1ynpmSdU94367MqiZYz3NNyVcd4Q+InztgtLMFJXhMXsQ23dWOi4BA1ZVFgfv8nKJVOMviPXE5LVr3IOX64uBvwbWX4Y00cAQOL3kcgbGfPXTTj63zA3WsT2wxMcFEDjyAbH1cvRoUn0tHgFMMHNcZNwzbapkvEH39Sa3CqjNnEY5tzpMvOlHgPzkGITmxntDsDX1U9z7tr7pwuVUwu5jx4cmx2wDLs5sjJMqo1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwJSJN5Sh/4feM4M/mMDJYqyLR4wzKRdUw1h5vC3NQg=;
 b=tLqlQimj0Pte7LabBoara3KKODOLB7Cnm3PffumHUNkp9GZI1ePwq5qQA3VxaYjQCJ1JmQpPWQIjirmS6LSwxqjn9m+qjblYMY7utaTfBmxmivtcoYt36uqpkp+gwkmyd98kYVJtAmmtYBSV2/i5zBgsDWpcGLi/Y1NHosqb+2RZhH/vKTb0X9dmH9xVEwLG68pN5mThtpcq/rDDmFnx6BOH4mCVuwiwU9JoYIzBBJ0rsyJ8rcuzm5yfuLMtAAPchDP7QT3pqMdEXP9VamlGF2FhJ6f5jSoKgdoh6lgmg1cTe6bIioES9Ohqofus85sQNtJL4JVvY1lhFZUXTSwX2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwJSJN5Sh/4feM4M/mMDJYqyLR4wzKRdUw1h5vC3NQg=;
 b=B5E81CAUHhoOYYWvJtH3znL5AdNtQ1/7gbJlC15AZI9p2RoF6fp6awyth/kqLfkALbAi5yiu99I1F69zIEyZi22uTW0UmQLu1PwuWzVc/PNbl11UYwtHVhJpaoBFUrbRXa4XIoYSTrKfTWdP26tsSISnYt+hVA4PgzINqBLh9ZQ0qJ+jEVxzOoNv9+ofRfeFQNDkZs9aY8DXJYOP8G9KeEElmj5gaND6Mn901gZGnTcymOdXSO6HiVcH7rBfOD0cDDJw2UBH2Cvx+ESIlgCTtjtkD1GuxV7ysk3hNRcXFf1JScbfBGdkTbzju0Mbhhrs/qDLyHdg2D78pfdbetIxpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8926.eurprd04.prod.outlook.com (2603:10a6:102:20d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 07:58:47 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 07:58:46 +0000
Date: Tue, 23 Sep 2025 17:10:34 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] mmc: core: style fixes in mmc.c
Message-ID: <20250923091034.GE31170@nxa18884-linux.ap.freescale.net>
References: <20250901134410.34344-1-bhimeswararao.matsa@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901134410.34344-1-bhimeswararao.matsa@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8926:EE_
X-MS-Office365-Filtering-Correlation-Id: 01798871-9b16-4d69-b74c-08ddfa7705bb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|52116014|376014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W4rmInhmJZbRiusgQCJdxXYG+CN862QRfPyJM9RqpsbF/EyBU1a3ywe6CwAS?=
 =?us-ascii?Q?AnaGHwgUc8eZ0A7vvnKbe9lGRdfECHdmKU/Bi9L5qbbcrdDUM8P3zHtoKuSs?=
 =?us-ascii?Q?4s9ibwr9Ruw0avpC/QwBe4ra5VDEpcxd8EvEUG5G4Qdm0S/EOb/Qc1Ekuqv2?=
 =?us-ascii?Q?x813tfikmDbD/uDHB2UWyFqL1/xbRFjt+ETKyJ2sJnJ4VY4DW0JJB8bQ8la2?=
 =?us-ascii?Q?3j8fLgTrbDKR5RTOI1hO2nwx8PhnTEgpgG3F2dj9CTnuW5Q35zFw94EFBcBK?=
 =?us-ascii?Q?gIay3uCf87ELaB9mFHSkBj1Mz6Uu3f7jcrVQUfwx+DHAUwCRy0u1mgxwPdf0?=
 =?us-ascii?Q?jXZukwYDkEOjIE2xbXy8FvarOgG7siZ81PAKIRaoYqro0UdL9zhdkPyXG1Lg?=
 =?us-ascii?Q?Lfklrewg2/af+rkCIPv8R8WlV5k+77CA7BLenY0W1+gSGr4M5iPvi+7T92tP?=
 =?us-ascii?Q?z/RAK533dxnQt0XmPbr57SwSpXuw2g5AnAJL/XG4zSDB2KR9p7Z/94v/zUVB?=
 =?us-ascii?Q?KW8+9H3S9U8RnckDH2C9Pr6kLUsb+UC+Tm3zAJdCsbpi+E80S+OX9nue3juU?=
 =?us-ascii?Q?VhXdlG3Fluuiqrojgz6/b2CJideW2tqAVKgKWywxwtLA8h6u4X4opLzU3DJy?=
 =?us-ascii?Q?Ny5lDOvUKg3MSg6/V9DmPomtv99mMBGtyHI4eAx2RLj+yFgzqfeiZuDHbEXM?=
 =?us-ascii?Q?bhAXI+X55hokORRadZedu0aC2/FdNswpHDCusSpDuqrVt8ag6anc1ZWZ4Krk?=
 =?us-ascii?Q?cZwOhpVLHFyCg6ev0QI6YgmqAHv/yjs+x8S9w60X7VgqPAtcjRm72N0BZ2z2?=
 =?us-ascii?Q?l3ndKy4T4YddjtR+RTcQy5+XZ8WEhw/k4/o7S1vk/o2Mc/18koR/4FytRrBp?=
 =?us-ascii?Q?qdDdyQCd+xqNqfCHSYTmE96vYe1aQrHpZIYpTtKJjx3LLd9sConWjPcwXw23?=
 =?us-ascii?Q?63o8VnB8zgJpiYJJcptm1h/J+9wSCvvfTDFKXD/aNP4TH3K3vbDF9r7yS3YA?=
 =?us-ascii?Q?7Z2jbSKKucmgyPCqjjxhqzBu+5QCBInUIxrUfuvpZvt1RNsNpL/KxWrUZSfV?=
 =?us-ascii?Q?WFOxBHPaEbWBCPIUNahpsvCf3e+PoEBfbp+jS6Rj23ywHElMsiUiiOlA4MgQ?=
 =?us-ascii?Q?hH0lsrKEm06urhqDf+bpzZNUXGjKiy1fpKaFww1oY+y8cEC7CUMfA6iexHkl?=
 =?us-ascii?Q?pHH/0yQ1ghg656ql6EUQ9Yl9ZlS6O5gLro6ISgmTnIpbfPNIEOHCFWHKJthC?=
 =?us-ascii?Q?g0GvzPi5JapTywO/jNYHhbu+jA+KgXSNYobr4fynRvYeva5WBWQJltZ1sDIW?=
 =?us-ascii?Q?rYdcuIlkf/a0Adq1ZdTupgS+jq8nMBPkfcoYzxXYX6g7V5Y0okOwo31JGlA5?=
 =?us-ascii?Q?j5bhTeG+dDjz0K8FIus8obzpeORZwTBlFwMOh5FXqVoN1TrjeUw76ZMVP4mb?=
 =?us-ascii?Q?EE6dRyFFhRq8T0g5WhFgIJSRXoHVlKt5Ewz65sfvXKJu3MU75gcLKYCiP4LB?=
 =?us-ascii?Q?s2Cz7S8+ZGzzP2U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?32rzoqKRom5UGUA+8GJD7AOO3Yd49Zo+zgviKaa6LpJfzq4SVzpntiQak7TT?=
 =?us-ascii?Q?a3SZgiruj1wbfR2Mh8PJnPYhTzLsXRPrmflwoOTb8bfZecaLGF3OsTF9kjYP?=
 =?us-ascii?Q?ifqI+qJGIJScfl65yv2HVAYfaHvxXHCjwmgphtOrZNfLcdwDiGmhlz1zctOr?=
 =?us-ascii?Q?eNi9wJO1JeAjDhfKUQ5vZvxtdZAAhSCVKhngUYSx6S023qec0hCCTuBzthN1?=
 =?us-ascii?Q?MxDUjNXKChPyly0izoOEAsO2KXmsyVySpv2eC5xD1WGneFm6UyTFjf9QGdyl?=
 =?us-ascii?Q?ZE1Xg6gAvNH2epOLo7nr3lOUP5DlmLD82NVYJx/r3z/90syQNSY9UiUSiCCq?=
 =?us-ascii?Q?DntJMd2QDgXqOT31bUdEk1xGbRE/NEIvjwbLke6PXZS82tB238u84B1baPfg?=
 =?us-ascii?Q?VyT+p/iCpWD0NavtOoyuoYgvQ11dsMEGR/h/5B3UhvJNAeQQJNt/EvVQAKBa?=
 =?us-ascii?Q?u1i3f2HtT8MC23nSwLvPmswISQ/HmNu7VAkZ7buhnpX04ZlzP6Ckp263eTHP?=
 =?us-ascii?Q?4Od5T4YNUEeGTiaJnmWNND73CL//cob9I7JJcVZtmLZ/wieEAqVloEikSbBy?=
 =?us-ascii?Q?+BcE7vt0sR/5h5wQyxaYWwTbjCYSKR8lsrZuS0chWbflnilpT83oaVVqxmKb?=
 =?us-ascii?Q?sK40EJpmWAdJ/dufbig+CI1C5coYA5YD0RryGYOvsB4EyIwt8FGQJmljdau+?=
 =?us-ascii?Q?0bohIM7tVf1IUaLLlJrypxM0pPfOATj/pmRuxa/yNypmzLTYesCIN2sAVITs?=
 =?us-ascii?Q?lrX0y8S9HinNbBarcOBXXYtlASKGFE4VUrT2EroVXK+33RHT65Fi1wCzW4v8?=
 =?us-ascii?Q?8ZKgt6ApVZsuckI4ty1WvQkFwxSdVWHDJPjcJ4G5J01OBq0olnchjYr/iVo0?=
 =?us-ascii?Q?OJJyNzc2OI1J7C8xU498OTYqffDT0KioFK4Ebh/h8T9p6xB6UJQG/2+mZFSS?=
 =?us-ascii?Q?Eaqof0KcP3XD8JNbTKcSyF11STNxnQa6oj3dGBOhtFmWbzPXc8M+jq4EUuSo?=
 =?us-ascii?Q?oKXM/bEA9BXTnhc8C2m4FQX4htBhz69URVd/ug1ZlUoF6IG8CVyWbZffxiRO?=
 =?us-ascii?Q?+hVC7exgOGtXKbPLiTvMzaadUkPRYvW+gFzNUuBEgd0oB5LRX8k+/tAX+jJn?=
 =?us-ascii?Q?lrp/1pbBnbrFbP1mo96gJNX/6P/pqL4u+Qhe9LM/l6cz0ACfhYPB04XWkEIu?=
 =?us-ascii?Q?loS2185+R6RHH4C/w88nr4y7caymeAJyNK7VpF/YuzCoOWFXZzkJ7YGstAPh?=
 =?us-ascii?Q?W6F+gbC75n/n4Ecg1uK99x80dZNVlvj9qMgEHeejvh3P4RvlwHVF5WBJlIb4?=
 =?us-ascii?Q?k9wvPsO8k5LASq9mcfMcYJnmzAGg5oLwEjyy4WdP8w42Cm6+1Pb78Ff1+IDM?=
 =?us-ascii?Q?kRl4z9L5KvIV2BsmjFUiHnWOGZhRF3D0db04a/Zkyu7YqEIoPDAW8DImlXuL?=
 =?us-ascii?Q?j21TFEp3AJhqhEjcMszkFnjENct5KMR1JM8zmZ4rFpq97vWq1Lbfy3foiwdH?=
 =?us-ascii?Q?/1V5zdLoIXn3TqsnSvkmj84dDOm/fwEvLabLhmJ2HmWH/H2VohJFxuuF6X48?=
 =?us-ascii?Q?r4rhiiITCHOknx4JyDiEFT0QU/hmidWQlxyBVVGd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01798871-9b16-4d69-b74c-08ddfa7705bb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 07:58:46.3702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSY1fM66j/R42VKAT5MlwkEWXYdjzj1TgD3KVDNOGVJvg1dWKlLQP3DdJRtRd/c1g/8bvLW8PD+UjvVViVVaVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8926
X-Mailman-Approved-At: Tue, 23 Sep 2025 15:04:30 +0200
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

On Mon, Sep 01, 2025 at 07:14:10PM +0530, Bhimeswararao Matsa wrote:
>Fix a couple of style issues reported by checkpatch.pl:
>
>- Replace `#ifdef CONFIG_MMC_TRACE` with `if (IS_ENABLED(CONFIG_MMC_TRACE))`
>  to follow the preferred kernel style for config-dependent branches.
>- Drop explicit zero initialization of a static variable.
>
>No functional change intended.
>
>Signed-off-by: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
>---
> drivers/mmc/mmc.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
>index 5f2efbe6df9..54ee6d40a75 100644
>--- a/drivers/mmc/mmc.c
>+++ b/drivers/mmc/mmc.c
>@@ -104,8 +104,7 @@ __weak int board_mmc_getcd(struct mmc *mmc)
> 	return -1;
> }
> #endif
>-
>-#ifdef CONFIG_MMC_TRACE
>+#if (IS_ENABLED(CONFIG_MMC_TRACE))

No need the outmost ().

I will fix when apply.

Thanks,
Peng
