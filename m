Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54784FD9E29
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 01:35:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88AAB83AA9;
	Fri, 27 Feb 2026 02:35:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ptlew1bl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7237F83BB1; Fri, 27 Feb 2026 02:35:08 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 573CC83642
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 02:35:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0FWL7KYXfqJNrI9zenZ68/Y8B+dZGiFPzhbBY8+gJqWujPD1YyyAoUAkpz7ZoYXwImGYP4Q8fitgSPXuQXLK0E+VuGb2osYbxivhHN7NG5QONlWfZUrzLJc45C6j/vgaj0b87z27xOIuCj7l4BLv5eZim1gHb0TJtIj8kbwnhkOICPrSWCDd9rULHu8NKEw8KXIEv/lXi9H68XuAXmPFA7LttFP9dRLzMLk//xssLbgim4yRWWnzHh40zV8aprakLR64wpB53nVaIWHvpS3+Ddu9DO53R14JlhFhdorqrVO3f7wIAVm1dASYFSd7hVxwmbrpI581tYNWZs6GQOHUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKeCPcqBMPRM4KMSXkzcuYOLCe3mkPVkNWKC+B/6Hpg=;
 b=maqnkdSQgB1bsT0VZ0t0o7a2TMeVlfalNua22BFesKgqNATPRVnwal/JOv3d7zJ0mYd98BQGkdHceDE8JZQMjQuAU2FbxrC7fLMp4YzDBXAnfQj8gAyI2/2QA+LkuOP0EP8eAT57nkbmqyMdccebXENKUXVEBkQ2rZFE6lpWleNcqJ6U8mJjn5IZztb/ny/j1PQNQT5qoULRLorEBSOUDR59wBA6x9QxDDuYAGgkmjAs6XzfvBMtCmWd4Va+/NlVTb9QvoWFpGLajvWI9EHJEyTAINRgyzTqNDI9ofpQIymS/YrSV/+ASSZG+RCiN0pekA1ceFTjH3LpulmFvrxmig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKeCPcqBMPRM4KMSXkzcuYOLCe3mkPVkNWKC+B/6Hpg=;
 b=ptlew1bl37wt3MrqkIu/FuM0za5nLEiNOyb3yr630WnMzJuk+E/mmbxw6TF9z0PnXJIorXd4vgnkSr4P9isZmK8L/V2gB0jXzCo4DosTL/pSBPGemn3isIBU3Fd89+8/YV7THRCzBczQfH17yrrv06UXhtJ3DAbF+byK2fqdarGKqQNdExcnnbdJ4Y+QCnHO4iPhxOaRvBMbNM1gaISBd128XdZbCi7/ORjhfAgRJBLx2ZEU4ps4tNqRNBo5nKADNyW+PiTBmr2ImCUhS0NUUPL9nId4I/LsdOogGWo/mlNSeeYX7dAUT41vR6ieXZe2fWPjcjoROKFDkVU8jt+Vew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB8775.eurprd04.prod.outlook.com (2603:10a6:10:2e2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 01:35:03 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Fri, 27 Feb 2026
 01:35:02 +0000
Date: Fri, 27 Feb 2026 09:36:58 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: u-boot@lists.denx.de, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v1] configs: toradex-smarc-imx95: Enable remoteproc
Message-ID: <aaD1Oql159HEwbDC@shlinux89>
References: <20260226092956.1098548-1-ghidoliemanuele@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226092956.1098548-1-ghidoliemanuele@gmail.com>
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU2PR04MB8775:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b92a68-5e4b-42f5-d9ab-08de75a06d90
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: KBHR0Cez1bjCEjeDW2XbfgqxVKQq/RDCaNqT31VFibohOMQzwkPgeK9apGZtbUtsn7Jb3+HZb2Yp/GOsnHrm4PHy4Tq6qOK189Pvbx7KtXurQ7XjgNUS+E4+khtb55BM7AuwTvjbdfizqrZLZ7BfVwvi1OEqMFcaZCMyW2exDTi4z2SxSMY6vRP7RKGbuoCswGdzlMgYG83ZqeoHWz2+pBiK5crCggbtzHtokADZ9ixXRE3W/jCIYgc4G7hfiYsksu8ncDiUFrwMTu13XERhyyIfGjp47+u97taCakw1+ar47kw3KqnWLxKffxXzxotdkDAUN1nXpk50IiFQp+H/UyDUXIU+TSMSiIIJ8q58L2JWZgW5U6dOy0fqu2CSW2ixdaeDUghm0s1Gi7hd3/uyshDyVwwbKe5z5WTVclryP/7jheGCx22OXQVd4PNxIuIGHwWhBx/Uakh9+Vn/Y6wAo6CMtcQWiBX4y49Ft+0K/TTGwLLrtwkqkEpEUoZfgoW9axeSHZ5ezfkh8WOybBPrcELZ/BlOe/Lzy1oHungQFMvbGsGFz531lUdvS6R1rhDY1aYxYY+hmzQjZUHURXlhSJUHaJI4jYstKBibPQ8us/KtOyEJ3HB3THooLny/yxODHW1zmXUW+ils8Eni5cX5AU0ulkwOTLQaMBf7Y42NYcqGi/z/ftkhCqQls6Hzc4HWgJyagaHM9t2OmhqDiu3G3xWFzwxoL5MtfzodccdAH7BRGYntTdschMLpGNPlwCvOdw9iqR4znvAqMUCZq2vboknD1pL6WyGu79ImMw2+gq4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0jtkXx+Pir/UnDqw5NwJA6S8NzmoBzdiu+wOXVMXSjkVfRVkFTqIg0KeznKc?=
 =?us-ascii?Q?yMX27VgRgZqmFdGL6FkWrNC/SZ8i58qtNWPDks5FsCeRGZj6A75GFhW69hrS?=
 =?us-ascii?Q?ixR2q1oJWO7gbAY9AHPg9A9RFsikXlljkLohJepJVDBBlUPL5kUDXkngQKTG?=
 =?us-ascii?Q?N0cOUyLr/XnIdSJwmCkg5dsD2F4p+j3liBQHxzTjuuVz8JUqX93Lqy47p7/G?=
 =?us-ascii?Q?pEa0CpKBe8pcst4XEKtM8OFsGsfTHWeCgX+GLI6UfikK7mMJCxHcz7FJgUit?=
 =?us-ascii?Q?heiWrhnRDJpnoRLSVDbmr8/0oZsnyWTs0TUQk6RfIEMRCRJHUuaEaDfcAQDF?=
 =?us-ascii?Q?CdqXbs/z9DB9pQvuyAZXV1I74xhDLu45lLfLDT6Plqm5D2faST7dHnbZamaH?=
 =?us-ascii?Q?az4pE4Ltjz3DxHUfeGFRBiD9liDcYBAn/nqDIf4F8iP3dKH5/VJPpF4vtEe9?=
 =?us-ascii?Q?sat7TIqBcwp7YM+kk1rfMhvQADE3SRRHgsjNdUTZT08iTBMR6/R4UP2ORxK2?=
 =?us-ascii?Q?pzj58Lu07c6mY9BerTi1PyLzoe9NCAqd6xhPtaRQ1FlDGRZwav7uPGaOwOGW?=
 =?us-ascii?Q?7NSkKcojF+5zAitWKOYM9S4aH52bCGL/qKshFvwa95IOMQNjYC8YZiPU3J2h?=
 =?us-ascii?Q?Ojqj8o5sjfW+PSZtY0Fv7yCNOdhzGNjAW5jvzCuRdXh+opq4U5cJ7hs8+b9Q?=
 =?us-ascii?Q?8GfaOicJSqpHa0FD7ap/u3U35PnZR+lPoGOJzq+zgtaG+pEr6AOPM4tf3F7Z?=
 =?us-ascii?Q?SLAkGiBAqa3F+nR3KcFD3Mm81BOxhTgEIh8K4YTkRDt+Nq3gdi1vVB5VE2IS?=
 =?us-ascii?Q?APJYYAiI5DdcnhEH/G6vCWp+X2gP1Ai/cg6IJgK5QA7FsYS3baJmNdaRweok?=
 =?us-ascii?Q?FitezBU6NyegI7tTyK28PLJB7C/EYVxjVp5BKAWtLECW6yI6RVMBaTA3o0dq?=
 =?us-ascii?Q?Z/TrZsSm7csRQsNay1E8RYxBEGi9O7nH3CPRz4ZSrU+38B1djfJihYIKatTe?=
 =?us-ascii?Q?OV9lGkX1wVT/LPtds15HAyjB56k09InrMxPCxv934bjVeFrycPwcXzm5cO8w?=
 =?us-ascii?Q?V9gWTJXlrAx9kB6nirUyYwl2HaGBwm1Aw71DaXgHbVL0j1JTqw1VDSzF4QPY?=
 =?us-ascii?Q?4KV/4Nn0mB122OP3Fdvl6NDHU2hRSg/4OYlUYWHB7lyAxQ906mF5L05rL9wV?=
 =?us-ascii?Q?esFlpsKsuTpHpOcPCbxe1XfCyuJlhyBwEz0Na1d2JGeaDJ6j/jc69NzecNbP?=
 =?us-ascii?Q?hHxoNrUOaR7G4Mp1MHFGmck0Zy8Rf9WqhI7mahI2o32B5PQZhKSjitSOgpqp?=
 =?us-ascii?Q?H/aEYlRTekkphTbyy6nP6Uot7glRJHJ6micKb2l+/XmS+NQr7+q9YsZKypBD?=
 =?us-ascii?Q?bAQzTK+ynH86YG9ZErwK56OWLb/M4WyOYz79swx5EP8L921AqBuwO10Mvrom?=
 =?us-ascii?Q?RavXno9sjsuS+wpAWHdh0ugTnrwWML+teT4Q1arE0+mLmcTiOwaTt61GCXVy?=
 =?us-ascii?Q?0/yOP7dSa+V4xAa903gePt75Ti1NUFxxJ4vUB7VzAC+rI+el8jRYVs4PqZp4?=
 =?us-ascii?Q?bBpwU4/OI0A/7NRMAX/tg1BBVsuX4NfV7iI1KQifPDivNYPWttRu8zg1XGTW?=
 =?us-ascii?Q?6G+D3Iy77hHlbiccDdq0RxoS5UmFAHJO8n2sZrdQCAemMIDLIhxoV89qD4Wu?=
 =?us-ascii?Q?bVi8YIrv8FJOyMqtExx8CURNINQYKFFRjpNyz13QOPKScT/YMSBdxEEu4Wem?=
 =?us-ascii?Q?pqqv/0k6AA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b92a68-5e4b-42f5-d9ab-08de75a06d90
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 01:35:02.8507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npzO0jSC44i27//ewe6PBP02UZZcwM5BKaJzfdIUl1lKFyyY5d2YuVCLMwTvX3y25cIGAWl+WBNWAUq59SBkJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8775
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

On Thu, Feb 26, 2026 at 10:29:53AM +0100, Emanuele Ghidoli wrote:
>From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>
>Enable the remoteproc command, i.MX remoteproc driver, System
>Manager SCMI CPU and LMM support to control the Cortex-M7.
>
>Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
