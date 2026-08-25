Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF7EC5DF94
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 07:57:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 422EB80D66;
	Tue, 25 Aug 2026 07:57:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zrPga4lKStf1; Tue, 25 Aug 2026 07:57:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787644642;
	bh=Gj9lkmiqVu7U/h6tPinG3Ie2p1lFpoWlEjnfrwMTNAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p9R7IkuPnsdAOP4i726mmQ1OHkW23Rnnr6wynn0W4r1Qt29Q7b0OnEEq2zFUhcDs8
	 ufQtCUm4clS8T/MJriSvwonT/DS7HIq3Xr4l69XRsU4LRXvWKQTJA+pqTkPRM3Fe5+
	 xf0ftK+sxWlYED25g0jJATyIBMi7faPoYqrbkPpFufw4Ncw4u8XQIPJmK3gxOEL+8k
	 iLR5o+BtO6PXEZ4dAnX6qpeNauL6qR2IN/f0+QWkKl2BHN+qA2vUn8W0kvCL9yFfjY
	 R7CMD3RMpMu99rABN0q0WE8JH29NFuDJxqj72E/7Z4QwkCBVMLMx3kxWANx2vDZi07
	 aYm5k+C41kwMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9561380D07;
	Tue, 25 Aug 2026 07:57:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7AF01118
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 07:57:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6CDA2606A0
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 07:57:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tWvp6PumtWNi for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 07:57:20 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=wQGFVRlF
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 342FB60618
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 07:57:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HeLvwUKoe+uaOpsyCPvnf/ZW9R/22dTkPfRkKDLO1q/JOAPX1TKoLa8dXtH1QzWFVIBhOO2Y2ZkSElqhFlbaUgnzqruFL3mAGSnaX/9dDaEgUoXi99vbUIYzLRcCothnxTE4ejU3S20Ua9PT0ay2X2QMBN3ZcihGcG9sYBK5ABTsjXUcTuai+drraGrMadGa3NUiBy9Bp+bgCFpORxNdRvRNkghdgBXYzJwHE7buxZtvWJdx51s210b/bxIDShMNptTjljwPbHZidrecgz4E71mSjc6Quc589aAiNDmlgKXvBxB3RgdjgyPNJhwAye8wF8f26mVTGpmbiX2U0L4iMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gj9lkmiqVu7U/h6tPinG3Ie2p1lFpoWlEjnfrwMTNAI=;
 b=WIs/b3WnzLru4dGcp0QAvG9RlSPaBKTPoAV3vrNAjNh+e2VY98EWUR7keGK8b45wlKKXdKuP5IzgSrXFCF6y50xhMY3SqpKRlhG2skiPvv9XzTf0E7amXEwq5AX1ADlCIHl5b0QRJfPnRSEHmorNgp+/ix/vzuaeLDBDiOrpS3Xiek8nd7SByelw5gBRasqCuS4EIm6BB1BRrkCXAd7G0N4K1RHreYCh4VfMY+4yR1UiCogV7q7PA+YK956bLAj7II8HtxZIyn1lNqsJcWqiR1OfPHishrOLQ99lDJKCLSoPm15rTPgNuldDagLyxl2k2JA2jsMAR0NUpKm3jiph5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gj9lkmiqVu7U/h6tPinG3Ie2p1lFpoWlEjnfrwMTNAI=;
 b=wQGFVRlFNi+ZldRqMEicDyZLr0XlobVJuAugUoKsCkJPzgwnPov1Qe+futBLV2X6bUaQWJQx6wwZdhHtKopD+IuUx6BZ2UJOKpzukuGtkoJsVhVerxHHzvKE2GbNB6J7zlJPTf9Ej/87Jq1SddR83dN89lG3GnstwpKemNNM4uO5Um8zE5EfGmZ6tVLaQ2EnNXgoZcItRChLJX1OLMf9dmVKpiXqilbG40phEIMNneRezBX082m1PQ685tbnFtc4nON45XxIvGSkw0/iVy+fM4DXfP/NVki3WCPyTluCVVXhO/v5TT8C+tXhiUAFKmkOGkPiFEEvUq8xgBcv4qkA1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AM0PR04MB11929.eurprd04.prod.outlook.com (2603:10a6:20b:6fc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 07:57:15 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 07:57:15 +0000
Date: Tue, 25 Aug 2026 15:54:54 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v1] net: ldpaa_eth: fix error logics of unconfigured DPMACs
Message-ID: <ao1KTqDpa5N2BObJ@nxa18884-linux-1.ap.freescale.net>
References: <20260824134759.2711989-1-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824134759.2711989-1-vjardin@free.fr>
X-ClientProxiedBy: SI2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::9)
 To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AM0PR04MB11929:EE_
X-MS-Office365-Filtering-Correlation-Id: 084cc7d5-d31c-4a6b-0047-08df027e7a3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|19092799006|1800799024|10067099003|22082099003|18002099003|11063799006|56012099006|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info: IWeIoWhrH2Vr1q/ScT6nAHrSBJAxA80UrAHuCqBI/sCr0HT8Gd3ZZd6IQYkUr5CYa8sTD7EzJYZgDPodtBo0yW5kGUm0AfrmoB3qm516VoZJizyHQhWTBPJRPuXMbemkaS9+7f7C6kH8+3f+GXmbQvMg8LKRSTgtnImZIMUvnoWmkBrosXJtgGULWmvrMK4l7fqfl4lZAe8ckvaNsd2SpPJwNw/cPhc1jwobjBLNkkydjFQWzVGc90ztnsRu1vtMeTwHlz/2echhWfVSF4vGqT5YyhLItkyCsBa0/ccaNpn4anvdvqVfi28Wvrkc30IpZj5d5+iDINXIhHfLZRiWNgDQ5MTv0FmpdEyz3YQDAux4kwS21Z6RGdKjk/VekEQkBXGNHZMTKUZbP9P1+c/exz68VwBvSFdRmTRuPum4XqSOuVJKu0dvzYIgk7y3D9O9Utd04B6NCUvpKrBX+saWHFdgPS7A9tEmjI4xWSMV35WEe17o21SAVKPpaJ9pV3RC8eo5xsfoVYCm4jTq9oPXhfKYo7YHm1G/w1HwRcr1fyVKaTlKW4GHk6KWUJXZJcGL2lKljyXlfwysmjvUNmjgYEFEetI8C8GLOUsiMBw8aLrZLl1+miDL4XCRfT43COL97CCxqp0Htieb/M2np9Y6GYsvGwqBHWEYlOUL5qaHEFIR1aq1RzIqsaOHv5KTIWEk3WQTkzvxWe6zXUnwMGFerzhDPqp/whyogH1VStBanMIeIBeJcSFyDEUIVex1bH8Z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(19092799006)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xtxNnK1+M27Cj4OAS4x8SrRtkf/myS+7exYeH57GPzKrODA9SBJumA4pOprg?=
 =?us-ascii?Q?3M7UkiDU8h9lC7q63oUDGG5Wkmtfl1+qta/7aMtRgAMs+tV03fd+80yEACD6?=
 =?us-ascii?Q?q6ZYa2FvpI4TQaVB4TyfKmnzwjKR1uVIie0MhSyOloBCfgUyXhNWnLFkY9/J?=
 =?us-ascii?Q?M0Zun443Zdbw/Be0l9xn8POy6K6y0SJtUeYlWiutRwMFmSvV6vcT+9qluUZV?=
 =?us-ascii?Q?sfR+FWqBALpd24f547Q1Ik92dLiz1QK7Jt6E4SbkAR7XM0mDrHOsmacpxrJd?=
 =?us-ascii?Q?2O0ANYurmneh2EQ87QJFy5AD4gdp0m5nrQvRYBHtEtw2+q0OAV9ToLAoZDb7?=
 =?us-ascii?Q?7KXQk4J1ppegVcNco5bE8dHMvkr6uybK9j9fUUwQAgO6m/txx8J3bLQIZLLJ?=
 =?us-ascii?Q?w1pYMr05FfbdEEDwRDaIi05Ki0i6NuoyJgwWRT4z+uVqVADRlCl02fMvsbza?=
 =?us-ascii?Q?YufzZLJ05IiesNB7ayrtx53kjAgac/uFEJbi/DkmY74lwJvXcNn2V4TN+YYf?=
 =?us-ascii?Q?YwlmtwGl/12H8B2UxGZ+twdKRQVBNJuAaW5ExvADRGSIeifXVeX0FFaME1TQ?=
 =?us-ascii?Q?YSblivUMgvtR35I1KwQrJZishBCebFDZZlqTsrtrRM7CGDpapgH4NEpsQPca?=
 =?us-ascii?Q?wXcgeREL8FCFYgvlBwXii1QBoMpkvehMGLsLG+2/vJL9qEHLN23MzxYgGoWk?=
 =?us-ascii?Q?xkck2Lclfwzu6cZIapCMCEeM139rupLsr6P6f3fpEXrCQuENhHXGnzrH7aoY?=
 =?us-ascii?Q?RAMTl4ZrFhbVpF9lqHc06lNtm2jNtrAYSYWP7yWIKqFOcOjiaBexpGjCO+5y?=
 =?us-ascii?Q?4aEajV9N21fjvyakTEXplQJNYtkQPU28ZKw1IPG87Mq261UjjAK7/N9A49jt?=
 =?us-ascii?Q?LlSThCUdIkNoUFd3OSpI+QBkKcSVm7dzP7JHLMd0OJKQE6tVSFwQNhX5etLw?=
 =?us-ascii?Q?t0SA7FLZvT+OLO4O1xbe3hlxC5mQkA4grg6V3moXyoCneFtbCy9Q3mta60Fh?=
 =?us-ascii?Q?a+Lzo90IBtEa/9zG5qUZac9swCn3qLL7JGqO5K9I7azEgiyKc2u0YCBpPzpP?=
 =?us-ascii?Q?DahHvMuq0fMJORFddrdbeQh/QWTlKaT27EK8byalm/FVwY759j9V8q0gB16M?=
 =?us-ascii?Q?j/9t+yNK0lyAapMry6/Ygvvbd2+GZDNttwH7MEhJ8Be3RFsFtXbPgdtwfszU?=
 =?us-ascii?Q?wrOmV2yiF6t6grwZGfZA4G4BQGAgU5CEwYh2r1wcfdZpIsNppNbcRiNHAcSk?=
 =?us-ascii?Q?zDUcd2Bo2HudbjDT9vUI+NZlw+Mim4zT3vX3eBRGa8QEU5Tx2juaX8+/S2tn?=
 =?us-ascii?Q?zMK4TnxmYYkwuBOcUPrOEhXjfPugC7DENMe3ujTudhWnRAudhOx1v5EjWY+C?=
 =?us-ascii?Q?By3HiXBVf5tPPeUZI3+KTwgwwOcdLXSBG+WYjUiiF5mNMUbFArTJ2m1j+xF+?=
 =?us-ascii?Q?LJJSHfn/OoFlOuUTpRDDFBLVv4sWPmuz1Tvj2P1Rznw4ArzpUXLiAqY7TjCL?=
 =?us-ascii?Q?F2yRarVT9kUzM9Syv7X9ee/eDqo4b9c36NlVldnQTENQBHbGHMzlsHn/qjpT?=
 =?us-ascii?Q?1NWHMdB0XmoYknY5wc/2el3xUwW7h6+7/xpm0Q86heiy71zPsC8El3fTSdxS?=
 =?us-ascii?Q?j6Kbkcc0Du8ZhoUuvRxPJ1bPYvrtiRo8YHQJPRvNYbBF2i/+9PtJfDVCkXI+?=
 =?us-ascii?Q?LkNwM55E69ClwsIY23X6tLL2OlpDNciQK9qdzNqqFd/sA0PYhIcfHq+AhRg+?=
 =?us-ascii?Q?wnO7JLS2e6Kk8BeYbbzvsgjSvFccLpW10s9RsGWdzXTvz6BeXzab?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 084cc7d5-d31c-4a6b-0047-08df027e7a3d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 07:57:15.1846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHslwIH7H3itdZNYKq6fU5KMwEptib+uUrSkWuPjJz+q+cfjhgbL2VEc6gm7OjoIEGBuiU2SKQBaLb5wd/P2FT3CD9MRBtVkMvPqXDiamksUIBZ4h3dsIxBUkpnC7s/5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11929
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

On Mon, Aug 24, 2026 at 03:47:58PM +0200, Vincent Jardin wrote:
>ldpaa_eth_bind() returned -EINVAL for a DPMAC node without
>phy-connection-type.
>
>That is not "skip this device", it is "the tree is broken":
>the DM core propagates it out of lists_bind_fdt() and
>dm_scan_fdt(), initr_dm() fails, and U-Boot stops before the prompt with
>
>  ldpaa_eth ethernet@1: incorrect phy mode
>  initcall_run_r(): initcall initr_dm() failed
>  ### ERROR ### Please RESET the board ###
>
>for a MAC nobody asked U-Boot to drive.
>
>Why it matters: device trees imported from Linux enable
>every DPMAC and leave the phy description to the board file, because the
>kernel's dpaa2 driver does not need one for an MC-managed MAC. U-Boot's
>own Layerscape .dtsi instead ships all eighteen disabled for the board to
>opt into. So the moment a board takes its SoC description from
>dts/upstream, every DPMAC it does not configure in U-Boot is enabled and
>unconfigured, and one of them is enough to stop the boot.
>
>Signed-off-by: Vincent Jardin <vjardin@free.fr>
>

Acked-by: Peng Fan <peng.fan@nxp.com>
