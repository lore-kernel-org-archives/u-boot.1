Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CCFC61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 06:34:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3766E40565;
	Wed, 26 Aug 2026 06:34:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M1xjznJSCOYm; Wed, 26 Aug 2026 06:34:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787726041;
	bh=KNib2LwCcUfueiAyMG/2ZxKAQOPWaZ49n09ie1PMGG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OeZUF9eFH0lssZtfg+rgT6EpQYDNSs7Yjn6dE7OqEOkwfm+YDnRWw3OEvkMjmfJWe
	 l1mdq52mLljOI41yZEoUBp8oxMXWSmYvPC35k9q5KGTOiumcuGBwR5RJNpl7+Fal22
	 3CTqXHuXM0Wb3rVC85vKhgWY9cDc4iT0kBYJmUPaMoDNCJE7z1AmOROeRiYnpkXAMv
	 owBKzB3YMx1n9YtR4TqaOAvx+jmZHvaX9ihDzY/l6REtDua6oOd3Ynxb/F+gzVywFJ
	 3obX+soHZxeEtTtx0a8xG8QR17IKFDVJj/BeG19J9ILJFNVYrHvN8/FAbNqpKKiMyu
	 WBrbWL6B2qzdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90E2B402A3;
	Wed, 26 Aug 2026 06:34:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1AC3C39E
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:34:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0CE74400D8
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:34:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BS4GgjZd2pbV for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 06:33:59 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com
 header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-NXP1-onmicrosoft-com header.b=Li1zsZM4
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E89964008B
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:33:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQ9u0jG8WPpjE+Hu2pdhQzOpb7P3MucirSou+oea2JSoAA3xRpwAal2rgJX40X8ykllNhyKrGKX1Pmv+pE8FyB9Gbo36UAY/nFLEDB2PFUKXyM6i7aDz9aDr3i7P0kEMcxGx4F1UmqjXR96Czp7vwBJZv1ys+c+ciunoKW3SY4VmLbPGBqNIjTh1ptjtTDXqVWiuecgrvle9EiZNBxxwwP32E2wyaA33+fry+8NLNIqUAe6tGrnWtGE6KBGc1ly3/UsdF1IBJ92dZdZBD3U4pUfVFRxiILhmEt50B0cQ4qluyabzAbQe7m3PFZ0AF7TAeV8rYZsnYU0phENdCInWTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNib2LwCcUfueiAyMG/2ZxKAQOPWaZ49n09ie1PMGG8=;
 b=xCEaDKxD7EJTPRtsHJfHNVhyhsijDNf3SQ5NrBZ3ErC3Am5cSxaD5T2a7epvpJMVoEOPfBqGqYuIoMzcNg3gFFPTGvKbKAYdXkh8HVP2z4dJVrpoxSUF40C9x3DRM0f1bWc19GFN/Fn/PJE3Gdfd+UO/pL3wV5L3+jRyI404R8Eb60ewYlXMhukRoHZLFrqWLy9Li31f1Cs4Ty5OAV2BzRZL9nHJ4KmZeycDts5VN8n0HiZ/yw+6549h8KhDo5welbrg8SsnR/rdzmDsiAp4+twkU58o4iiSKRYVLE66u4sgdVPJwq2dqa+dlQURwcDv7EeVynNMmMVNOE6ch/FRNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNib2LwCcUfueiAyMG/2ZxKAQOPWaZ49n09ie1PMGG8=;
 b=Li1zsZM47RcVTh5DJYuiJKfWtWJcoq+TOC8p0l8hnlkvLznjF5a0/Hm+iQtNQxan0yA6OwNUEw/JJC6uuzyCXywK92uOWRqgZx05hPcljqSVnRlMInYcYGGu899UsfGnThHduqkXUCdn5DHoydYSj0RMoknaZucw8DMRsQ3BhP7LIZXB9nSiWoqqvs058dTA5nVkGvVAJoumKMt+F2z6+c5vIGxFL8rgsKcNRb0hSjHV53z+aKTEQheNcHt+saL91grm2oN/k+qB9ZHgw5aqLiJh/VYtybu/2zvQ073rvj5ztgS7KfKvle1AYft8BOhw5Xp6h0LVGlqsiasmdR0bIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AM9PR04MB8923.eurprd04.prod.outlook.com (2603:10a6:20b:40a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 06:33:54 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 06:33:54 +0000
Date: Wed, 26 Aug 2026 14:31:32 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Linus Walleij <linusw@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Stefan Hansson <newbyte@postmarketos.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: Re: [PATCH v6 03/13] mmc: arm_pl180: Gate idle card clocks
Message-ID: <ao6IRP652kMxc7s7@nxa18884-linux-1.ap.freescale.net>
References: <20260825-ux500-external-sdcard-v6-0-61446b6c289e@kernel.org>
 <20260825-ux500-external-sdcard-v6-3-61446b6c289e@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825-ux500-external-sdcard-v6-3-61446b6c289e@kernel.org>
X-ClientProxiedBy: JH0PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:990:5::11) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AM9PR04MB8923:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e5a49ab-9f6e-4113-4747-08df033c0033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|23010399003|1800799024|376014|10067099003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: rprmokhea2+rGZO/aNA+4/Wse4+lTaNwNqJrN29M+v8/Rgq5OLaFBfOwaISYeaHjjC1/YCJ1SA8Ud6daysRe1iv0qtvVl8C6UvnEQIZHvKaVIW2od/Rr4nwCwXcwzhQXsxUlSFtwfa7QgoEMstM0vN+ohrnht5xM8+5XrMRQREedIjDvBTv9PX5vTnRxJ7UnvK4Wt/IVVHR3/b0PNOWRO9lBwoan+LVJK/FptPxleTjxRLKY505Rg98BBY0DMyJgWEilW/AIxMysy/Ogjmc8i2qvPQmkwEKJcxKgtTOtBtdNjrNXMWKc5e22RXEw3CY0LUaJGgjvlwnQlWL5IiXhbxhQdXH4PXXnJvLoHqNQtoy/7su3IUNh6EOaZejcH+IhOh96wmB0MWWLTlBJgwu//GVfe8J9FEFmprKTCT3BwrZKaQ7rDwihGiPTg98bptT/ut3ISU7NIRbV8c9RbOSAFWfs2xHdjj5MCgjhdsqObSlfJ682U6GIcv+AyDX6VYCbUz25lMXVAF4KhDxle54SzO053grPkowqSNJZxfgjowPEzx3UKB6KJLxub+z545lF6OwP2vJKCOdt4Q/1rsN3QJ6Nh00MLzLJImWuk3yoMu/8EQcdWnwPfKtU7dKn7AIMeL4NTP7O+oMhMNSk/IJ3Vr2F8DCtRXk5Ms+OMW/dlaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(23010399003)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fzhvSCp8H5luZv6yCgmAAXmVQ79GWbGCuMh0M9KyWC0Y0aJ6WETCC1n97QVq?=
 =?us-ascii?Q?5jTq/nF5ihal77U43LrqJ8IUFNjOJ6fyWKreB09ZCOg8oY5GtdFTpTeAP1Si?=
 =?us-ascii?Q?9UkndcjLICephFHhuvOem7es8clMnpLT6vcm4N8z/x3KAGPvXif7XFOpDwf8?=
 =?us-ascii?Q?E8//mT59s3WbEs2YpIVbd3j2gUEiIE5oISDJFhp0BbedBVguuzQ6DzzJDdQ0?=
 =?us-ascii?Q?A5gvTyNZHcbYA1Xi/EVGuSBd9Jw1Hrp2oWiXx2+58eT9p4x7OtwuLqSyzEvK?=
 =?us-ascii?Q?l86ezasopUonJmUHHpLnuC+vWFgxvcirgvrs5C0FiAi+guD8JUPLJItMEj3A?=
 =?us-ascii?Q?6MZMVOt1My4LjSSJ69oZmqdmf3b7BOO07P4OnmykdMRT6Xy9KPt2BV9R8Pgw?=
 =?us-ascii?Q?cE/HZkcQdAsWcdRE3Hos6CnbaFkyKanG6M8Tf8Yzn5SKmRMEm80OJRouokj1?=
 =?us-ascii?Q?GPM5ctLUtVxcu3ylRoOjwbbz2pyC8RTP6AXABDxktmTJa4SMlWF0FTfFw48J?=
 =?us-ascii?Q?aiJDxYFHKOaGWLzJolm4mSOok2zQKF1W/5I7DttrljOqz+m4QOx0SpHgBxBF?=
 =?us-ascii?Q?0AJEdJry1Gm6XB0eUtEvG2wtitUy7SkqhDiP0IWEAF9wimgtcfmpZZ31u035?=
 =?us-ascii?Q?NSzUuVW5QaRacDQpSNKrtRCizliMwR8AIYZ8Ur7vZwTWq0Te3sbpDbMQge8u?=
 =?us-ascii?Q?W6LfNfkQrVSpzmV0gmDH7JWgUY2gd4fVE54qNi6DeLACeA/FP6V6FaFN382p?=
 =?us-ascii?Q?UpLUFOttja4UFX9+2Dzf/0t3X7NuZENskJnO/t3uWI1ZTmdx4XiML7DjoWlQ?=
 =?us-ascii?Q?j9g7zgd1+EPuJXmkXiS7LO8S/JcmYIE5FIpH6wcVV/acDhsXKsf8OilGjiYh?=
 =?us-ascii?Q?I47etUGthBtiBzxnwKp9/5UC/4lzMB7nfsSiFQmFMKsK/T/MDhVOGvd1d219?=
 =?us-ascii?Q?z+UYq/BEG4FA4JbRmhP8NYyB57trqXapoPQHFNpun2t2O4kA3Zihufkj/Pv5?=
 =?us-ascii?Q?DLBcN6AdBg9pCO38KOuUFUfVd+jSmYzpovqkyaxWL5LOL/0SvI08ndCgNe1Q?=
 =?us-ascii?Q?pvqf/szyFgmcAP4AJ+iQKpUNpwfsMLmmrJHrAF7UuuiuY/MFEK8n/S3arHX9?=
 =?us-ascii?Q?P0saVzyEsZjXacbwQ6prfr57Fekj+oqV278M/YrMONT6OhCIG2T9HPZKUqee?=
 =?us-ascii?Q?CeS2oaIwX2ue3MVdeql494VzcOldlujfX5Z+skNZFx/kK1EzvLFZ+JqU6Nmh?=
 =?us-ascii?Q?bYMgwTk4Xddb6d+4rZvZi6vaMWa/adhWZVIy36ESC8qx/3G1dmtugJLBCIfs?=
 =?us-ascii?Q?Zm/LNHCM8Fu0qKA9GoXZXNqWYLA6pH3zVh0qFKw1hz/UUGu8COql0WJp63Qa?=
 =?us-ascii?Q?wG6Je8sCsHgivQnZmX74ygmFncv/AjEBOietTvOW1Q4FFHyO19U82+biBdT4?=
 =?us-ascii?Q?F2m+kuABMKrns+Er+Ato7MbttEBIsczcnIU9Z6OM3lS64XgopUpxJlEZVvGU?=
 =?us-ascii?Q?OHkxsGriOn44XmB5iAfj/1yGKnMMDZE6YdsdSYbKzfrQQbjjGZmtz04/3zVl?=
 =?us-ascii?Q?jfm5dsDjUkmc1IiIXOY2wBUlupkKHKbW0gcf1nFwxtCJK7CzxZ4o445irgpE?=
 =?us-ascii?Q?pcEwEnyFvKvrRAyAsfARBdZF2QtRLbIWVN2pljyKMhhljixs+NwQjZ6c4Xcq?=
 =?us-ascii?Q?efehtVytA/JwjbkJ2LHql1uBPyZ0soWs6TLuYuJaHw/QpMiPzsSfliSxvdjD?=
 =?us-ascii?Q?LmKAPqdF+J5aI3US73UMeSiqVckpS3Ugnw3gGsTz4Hw3O+ybJxam?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5a49ab-9f6e-4113-4747-08df033c0033
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 06:33:54.7277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E94/rD9ccq6jxhlJcCubapT13mcwxS+2jN2MI2VwoyzinMIGjsM9uh0h93UyCNwBzeqcT1RPz/S9/3bMUW/0H7ztkSogcJm0XtzAjtDOcX8RvStSDRHJui4ss6tYHC68
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8923
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Tue, Aug 25, 2026 at 09:04:03PM +0200, Linus Walleij wrote:
>The MMC core uses mmc->clk_disable to request that the card clock is
>stopped, but the PL180 driver leaves SDI_CLKCR_CLKEN unchanged. This can
>leave inactive hosts driving their card clocks.
>
>Honor clk_disable when programming the clock control register.
>
>Signed-off-by: Linus Walleij <linusw@kernel.org>

Acked-by: Peng Fan <peng.fan@nxp.com>
