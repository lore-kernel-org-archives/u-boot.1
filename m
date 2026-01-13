Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9BAD2D0FB
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 13:14:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 930DE83015;
	Tue, 13 Jan 2026 14:14:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SNXuv492";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FE75835B3; Tue, 13 Jan 2026 11:16:46 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E8BB82B20
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 11:16:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSJD++brYiMgIIhZ68MuKNdwgEgS0USd0K2AEWoST6k8RFuIP3GkgnNsvi0nTC2c/IVJG1mVWUSkWj5NMXohDODCFjsBIWs359zrnl/EWmx2IDbkgebgfGR5Droi55YMskQIyOcFljnhyPIyLufNEtjxrBkDhZv+Vtu8VQqZzE3Bvj5ZQn9lwSPuYmVcC8ouSwJ2+BDNCtAq238EUsJfOLWCVugwK1wT6nNjLh9m6sjzY/8i/fuKUQIeGoUcvkWZQ/ghdoS6fkL4KDDuS8XOie1TgrUWwhyfoBQolgkPzqkR5jykZ9rC7i/bI8DihsJF+C0BYOfzoGzY/ITa1qi7Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfkdKuNiICgO/6OkKaJ5Jqxz5INKjLOz07p4eF/9HaQ=;
 b=jD1NjzrVdzq05xfdVXTg0R+MXYW7Y1mlW7R4WwBXQezzi0zCY51ds2wDq9Ti08oNLmFDltdSluxxLzZdgV/c9oSai4NvZujrcjxLKK2yL91h5xRdxTKHPBtQyoeNxWog4x4FPlSfYoUfj3NQ/yihyYAWz3sHJ2CMkXGWw+aioJFC3MZ8zcWz/eANfQsist1TOag2nIWZe9qLEugErAZrV9Nb8keVr+n25PZgyY/JY2pjA65zNjF1GKXtRL28aVi0VQ6wTDOdGrguhtJhTaDoBENSxLiszuRM1Ly1KM5yZDcHSIYGx1dtdz2YdQOMMVizFZiJ95bFUPxd8r6w/ZOF5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfkdKuNiICgO/6OkKaJ5Jqxz5INKjLOz07p4eF/9HaQ=;
 b=SNXuv4922cqZKK5rNv02N7njA0q6ARkMJIVyefJ2qtIOOl/fwAkRni28X6RDz9/s9busV3r4j16jV0YHVyyD0FG6VCVh40V45S/PcNUVzUi7J0VmTWGfQ9Hb1n3lCikZzd8IMQksieXrY+opV52jTJiLnCZ1WqYUuzD6UalsE7MzAsQGBFtB8GeT3NHTlW5AguWKImPvrqA/iliTDtFkHxOV0qV9Qp/u55H9DlguRkjReI1BXtSH3IoE7k5b8V211Go5x7dW2l6vYreqmOxFygRgM+RdZ9u+aZJcVqIr2W7A9F+0iDGe1JwDizAocHOlTpny4LzqhFXdWjHu6OqKNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by AS8PR04MB8770.eurprd04.prod.outlook.com (2603:10a6:20b:42d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.5; Tue, 13 Jan
 2026 10:16:41 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 10:16:41 +0000
Date: Tue, 13 Jan 2026 19:30:58 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Yanir Levin <yanir.levin@tandemg.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 Eran Moshe <emoshe@gsitechnology.com>
Subject: Re: [PATCH] mmc: Fix retry logic in sd_get_capabilities
Message-ID: <aWYs8qJ7bOi3_2L5@nxa18884-linux.ap.freescale.net>
References: <FR8PR06MB1055045DDF7D84047F34D2D6DFE80A@FR8PR06MB10550.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FR8PR06MB1055045DDF7D84047F34D2D6DFE80A@FR8PR06MB10550.eurprd06.prod.outlook.com>
X-ClientProxiedBy: SI2P153CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::19) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|AS8PR04MB8770:EE_
X-MS-Office365-Filtering-Correlation-Id: 340d1057-07f4-4346-8d9d-08de528cd877
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|1800799024|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KY1dh6HYK/wRUNwkofDR20/zlgHNwsReQH/LNEKmE5Ya1AVN8+3Rbg3Tl3ub?=
 =?us-ascii?Q?9M+v/FB7nLHo94m8RK2YOuSnagPxYlxJAQLD8V4sz8oTMma/zzcESyLPvS11?=
 =?us-ascii?Q?dGp/xH/pzaKI9GEVrW23+ivbfD/2RGLf1+4DliOJOzqO37EetQfN4qhuwp6u?=
 =?us-ascii?Q?UlgMTuRa77ufQq+kwyO1QoI8ckK8HeHSK1HzCx84QKBrxb4SCso3C1q7j8L3?=
 =?us-ascii?Q?UwzSrb+Job/9uytIwHdUsNLfw/OQclUejl1/Zxwm7YOhBKWpHRBck8yav7Mf?=
 =?us-ascii?Q?EnNriQbT/HinTShR7Ao/6HssoyskSa+v5zHEwsNRS+X+FukxpY4vreLJoaRD?=
 =?us-ascii?Q?6auSmXWZG1q8P9JXstgxNYlyIOCbfWcVBbqTY2U7VSENs1r9czxCMOJe/D0F?=
 =?us-ascii?Q?Yio9p98Z7jS57Vf5IVhMhbPaWjPKLhApaqUtFwl3cHkxwtdWDjaiOP5JvMgb?=
 =?us-ascii?Q?2AWkmzpoPKTm30AyNuUSpRs+UlPPD2wovUpPelTQvxhjwtNUDDy2xv1Rk6TI?=
 =?us-ascii?Q?QGt5D4GPs7mvr5BJrdz/9S+H9GHaXadC4L6AZOtUQXXku++BmkydMEEb+dZj?=
 =?us-ascii?Q?43evmY16FrfjiISCyB36Ys9ifhO/eX9XJJi1SWp73bcQd6ad4dxjol78y5Rz?=
 =?us-ascii?Q?B2kqrH94n3oDxhTV2jfklHQaUxtOHWl8vgjcFanacEd4dFV55sMkGe2SW3j8?=
 =?us-ascii?Q?MjpG9aNlK/EaKrin24GqoDycHIpG4xcc9mLTEiZFyUFSyC9cvo9NA1IymqwG?=
 =?us-ascii?Q?y8+WSlbXb2aqT4fhLrQ9ZfS3UHJz86jubVopOjoCtQ2oZHpwDL2QK3am2YuO?=
 =?us-ascii?Q?IM3NB1x4WRxNVNTAujSqI+f3KIMLxtEGlTe0ULeGW4NJDHaYMGJjhaqSQGUM?=
 =?us-ascii?Q?lp+zVcShSPB5Edi94SsDjJSqB5HJBV/2cmH4F5SCuIOxza3k+17E+dyOm/nF?=
 =?us-ascii?Q?sH/zgjynlm2X++t6Z3q8qra4Y+1wB9k4XcDVPC07hnQlOhYiWAwYZfO5JEvv?=
 =?us-ascii?Q?PO6mzpADvJyifK4UUJaOuZ1+RtTpLPwsTAztpks8B52ZxM2lLSbV+8i3IQCD?=
 =?us-ascii?Q?PfqtpuzH4RORTCcAAyVeHl3rfnicG6ca8Pw6DpmlcbI+b7RvoVSe2yDWYIMy?=
 =?us-ascii?Q?IxDCtwW1TqSyNL8ruhHZarFqXkTxqWzzgZaIJ7Fcyf9712mTtQnByONr+gQy?=
 =?us-ascii?Q?WnQ3QlJ1QJ2t71GLxa6EqSOApkoRnqcJZipGx57WwteZcZmAMsRfUavUFaWN?=
 =?us-ascii?Q?QHLWs/cvEq2lSBvtLLqSF9QuJa1I+ZvtAzzlHJHseGqj9vtfWPI70Dfzjrp9?=
 =?us-ascii?Q?c8wFNcd3DTIeUJPDrhUz6gvm+jd/VJWkWS6t4BuZVSsr8gz5hXIIb8k+40SO?=
 =?us-ascii?Q?lms2eZLXspgLjzXgKepPUyoO131Rk6bDSrmQ8hShF7g03CJO1x5lyOU/Zfm4?=
 =?us-ascii?Q?iFHrDTBtpF+aFOQ7kelNRQJJK5KAifcRcFaEqF9mzlhdxt/Ejk7APgf83g84?=
 =?us-ascii?Q?0xgh8tvlyQ27Tv34uiUQDe2fPYxMOoxmq4Lv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(52116014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J5G0TgXwHNWzUAl7XOpOjlANwobnvKBZ7N5HKHsV1mb3kR60QtwBH9eku/Bo?=
 =?us-ascii?Q?DSxaFZcDLD2xwX/kxGEOyXxtIIyDjLVMKF3oSbmqk1tf9lN+BXNkR3I2sBaW?=
 =?us-ascii?Q?/wpWyANfb+zoGShWkxTFswyF2QyNGJVvNs3ozsrR/jbGUcOvTMMPYqkziGyu?=
 =?us-ascii?Q?9WyGLKQexrTY6iWh8QDjMlaEVPvr71KmxORu8/kHphG81Cxl7caz7uy4z5BL?=
 =?us-ascii?Q?Nt4DbfJszY7lrAUHobbp/CHPnhuQDfYKACoP441jaB6x4IV8EGZy7QG5Xwic?=
 =?us-ascii?Q?07e9PJaJ7Lcf/B+M/QNUPwzkVP+SY5XRMnoQgvlDQbyvfr5TgR8OruZrWhIX?=
 =?us-ascii?Q?fUNA4t2C3lNm7tLuhyJX5LqHFGw54dW4P/1I+OuGdZUwziBO/c/vDOK4mI+X?=
 =?us-ascii?Q?NIc/LyOM3Li5oLShNw+cjwRYKAOFa9+YcLw1ZqwQk4q5k6KFALHfSi5fKu3V?=
 =?us-ascii?Q?SidRk5g3qxydiexyXWnj5BR+a+QvPCtaEHIVp4B298cwLqeirhAexmm9A7wC?=
 =?us-ascii?Q?Y1Cs2tf43I2aXp8TJ2fGR2ApoWZQMvF5sczvwomTLTSobOVogMhFvdnbWc/h?=
 =?us-ascii?Q?Ms0ZIbawP6jlzfWl1L8mK0o2BhInqxehiYQt+xuku+LUcpTfW6q/eoAqCCO5?=
 =?us-ascii?Q?IaP6t4rL/JwOrGlvJhTlHTbHgvUGx261rqYpnqm+bMCmGlOYyBYzpesaV41v?=
 =?us-ascii?Q?UpMMQpqyqJdBjIDP3cFdGTeZtGM20BWWOJrYl2pe4c/WmWEvPOe/F+6HIg/F?=
 =?us-ascii?Q?b7onWB780I1nZHSDK9ZPIuXTFfXQEilkvK9lFBXEjOyjjHedZfVwDAwZLmUp?=
 =?us-ascii?Q?Wywkw9p2wzrStFBkvKy9C5XOVsI2XFxErY33ffEyNDCNgDM25y2e1S8kKdlP?=
 =?us-ascii?Q?P/F1XoVM75OGJCD4sxxdqDchj/JFsw7UXpr+a5Rf1Z5HuWig0M2PTyA7xENk?=
 =?us-ascii?Q?6Vyuwcs/HpCZawYQvb2YHBrtM8AwYP3FHQ9R/AM24e6LAy0KsTIyuGnWDTAU?=
 =?us-ascii?Q?ciUUbBd4eWEs0u/820I/3LEipOctQc0hk2F6zwohxV7wN3TPxC3Sc1jEjzjb?=
 =?us-ascii?Q?9txAP/AWuxjwqrxkQU/lufxCw2dear0ar4GWBshuAciInauW4aYHvO4ulxxO?=
 =?us-ascii?Q?F5oVu+LBRV52aG90+2R6tIcz++Si5W64a1gwScOQf81o/ClLtPQ/gT1FZtEY?=
 =?us-ascii?Q?ECOMJA5IPnPeJH1hbd3OkSTA12mDpDFKPP1Twlw/nf8DlRrvYGxTX7R9BrbP?=
 =?us-ascii?Q?B19i2qkZTXTUOq0Lg/j9kf6936eqyVZAuJ8iGe1QtIEhpDhLczAyPhhxrsKM?=
 =?us-ascii?Q?mQ1+qeoGgget26mYgCUvErtBQHid4rFBTByupS2r47QZmw7QfXnAJ2nmLjjt?=
 =?us-ascii?Q?9LwCoqGlst3EyxhZph4Hv/czEG0wnLk9kFzQ/3fZjTluScROFBiUkpc7uTeM?=
 =?us-ascii?Q?DK4DW+AHjxI7aXngWkNRa3rTGQJgcVjo76xQ5AsVsQxgOfR09CSusBJnIIJT?=
 =?us-ascii?Q?vKeR3yPe+Q2qgS/LAmZeKs62nhNDBhnj9ttxhEoGB0t6F9E8l4QQrrpgYD+N?=
 =?us-ascii?Q?8udTnN6Dlrd7sltr/UeOBbxZDA693yDAMoCkTkBDPfdvf7D0NCYUoX4jscdh?=
 =?us-ascii?Q?i1NxphzkaS1S+LEegol/W8Z/QsejerHv4jRVZiVW+ymWfwUl82ggqGqk3ZCO?=
 =?us-ascii?Q?uXX35q1AzTaKIpWYVSZCJP1ERT/n0EuE7cQi6RSGj5PtI3Uvo9s5RiCZ87+l?=
 =?us-ascii?Q?YnN2Hyvlcg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 340d1057-07f4-4346-8d9d-08de528cd877
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 10:16:41.6176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxreSj/1kbVOsrUarafYNTmI4Y7/W2VpxiskS+ZwVmvt5CzpzwtLForbIuPoKEdfOJPJiZSgCIK6yIFtDM88kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8770
X-Mailman-Approved-At: Tue, 13 Jan 2026 14:14:11 +0100
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

On Sun, Jan 11, 2026 at 08:21:13AM +0000, Yanir Levin wrote:
>In sd_get_capabilities an ACMD is sent (SD_CMD_APP_SEND_SCR),
>which requires sending APP_CMD (MMC_CMD_APP_CMD) before.
>
>Currently, the ACMD is retried on error, however APP_CMD isn't.
>In this case, when the ACMD fails and it is tried again,
>the retry attempts will not be handled as ACMD, which is wrong.
>
>The fix performs the retry attempts on the sequence of
>APP_CMD and the ACMD together.
>
>Signed-off-by: Yanir Levin <yanir.levin@tandemg.com>
>Reviewed-by: Eran Moshe <emoshe@gsitechnology.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
