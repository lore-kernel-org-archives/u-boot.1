Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACFCC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 11:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5686083B95;
	Thu, 10 Apr 2025 13:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vYij0IV4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A01683B96; Thu, 10 Apr 2025 13:20:42 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4438983B8F
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 13:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9aJ/QvwXZyaP0oLEVguaPwyy9sCxAsVjIp9qq9Rjo33E/mBYFNvHYBUSLkLhW2Puc40krzciG4SHtRjlNZVfcohex4uChzrYqpsLh55C1lvVIvlfuJKXfJCO/DOzWf4/F5qQr2fQewh7tx2spYnhQogB/0ponvbwnBj1XmYxL1zSkaSsJLWPs8Di692nWKbtUFpYAd71hMSBdag6tejNV43d+2+z0lCg1KhMHBnlmbqCm6cNLfDEfUlbWk6deXBCZVdppuRVb9MaOBgXACLjanOjUoPwkEK8N8SiT4XmFaO5JV7aJOcDTeNnWXZ/3n8oT6RCRasnTytV2eh3TkeaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkPWJwOqXFXMdfVjnkQ5WXy9pXoE5+BAKNzvsBjJPXA=;
 b=hccp9QH177D7hcrje+MAyjX25mFF2QHPiDwP66wUhxhyuOLs8W/O0RVD6LAkDMVCQEHLSRy+7uEwZsD0noWG3kB/o+IAnCugZ+j7VFznoVV2JfPbWP2mCLb7FqYqv6Yaag8b8WiwlE5d/HZtfk6dzdpXm61h0E3U4dEt4SLeDtuawwfOmJXa26Zdv74ft9rChrOJOjEcry43wwZYJn73492J/JnOfZDZusga9isO/uaWXj/Jxznu3NDH0vw+mM8gCUyOB5Bcnx4ZwdvbGKyO5f4JTXgnSs5Q1e2DARgKVEXNy57d3st9f196Cvawlpa+eNy4AFlKA7yUn9iulXS8Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkPWJwOqXFXMdfVjnkQ5WXy9pXoE5+BAKNzvsBjJPXA=;
 b=vYij0IV4wMTc3H+AAQ40BGMOpVNdcvSTyu2Ugaox1PtXwhjqT0qu2CzwtEvUMKVpntpDdVvfMEQuShviISsfk7CTqbvpW861KOkJCzRSI/A4PqJmdDydaMUrakswnrLLC3+QhNmqgCVSqS5Pl3kts87EuS6OcZbQy3zrLwz5jmq3T/i4I5bqfRSJ2aHPn1dApohBgJthsnohX3TxywGBblGmbaKglXbmoGAo+zr28RCUTj9nZD7eaPNmh+fKDTJ+wwLV8obbA7PMcMjOwX1Y14zaKm5/KWWEYEs4QH0Z/dh6crOKSKm2Kp5gxgbS1fHYOpsSjLgwCAAQaV5vPjJOYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VE1PR04MB7326.eurprd04.prod.outlook.com (2603:10a6:800:1b0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Thu, 10 Apr
 2025 11:20:16 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 11:20:16 +0000
Date: Thu, 10 Apr 2025 20:28:44 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de
Subject: Re: [PATCH] mmc: sdhci: Fix possible Synchronous Abort using PIO mode
Message-ID: <20250410122844.GA311@nxa18884-linux>
References: <20250123214850.3085559-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123214850.3085559-1-jonas@kwiboo.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VE1PR04MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 3def568f-8250-47bd-973e-08dd7821ab57
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?muS1S7EPfiCBdtrifAJYvfH9tyF3G6SXJlt4AVvEEYcNXVfqhEKvbTQypJl7?=
 =?us-ascii?Q?2MJXHDGsfbMGJVbXBzO7DydZIr4t02P1MJAyX4f0Tvbw7+tnGbiMOD9lziZZ?=
 =?us-ascii?Q?Kn2dX60xDRt2P8ZnnFurhQQMl36eyUVvkmjnOvCZzk8Hvfz08OGpOZPogRVm?=
 =?us-ascii?Q?xz4b6racpregA859h2TwPpxNOleqHYqsks1eeyJLMsgZOhXJN0jYo3KWrPyg?=
 =?us-ascii?Q?pKw32wodWdZdb9WCcWukCk+IY3KNgatYlMNsUiaLAa8J/dmxmgoD//6rKAA1?=
 =?us-ascii?Q?girkGY4IQyYeDqLk1VXFPNNkztfFw8x8CNzrXFNjXKoOhz2fTt+C79Gba1cZ?=
 =?us-ascii?Q?I8ttOWgJPK0FWH6BSbMZzMtQHX7WKfqfA80/ai+VpT4KtQGN9Q3nj6wpXU9T?=
 =?us-ascii?Q?t1jmR13sQduPtXWtVsWEoNPq8je2nDlr4T7NYLu4wQjev79giP5kQnKyVhM8?=
 =?us-ascii?Q?+JXoXfHuKzJiWMtz4kcBG+UE4A6Ur9g27dXaYS/WMVtUZni94JSAC/xQkIO/?=
 =?us-ascii?Q?uYEvhEEpax91PncpczR7lifLPiISIjsp8CFwHithwRe37OESpA4ocN4hihnZ?=
 =?us-ascii?Q?gUzQumPGIO7nfV5t2wJGcHSOI3C5NI+wK0b2JM/1zML9pKXHt+l4duQh3yRv?=
 =?us-ascii?Q?P6WSwDIu2p6p1pGkMnYuezvaRikbavwHynPERD7gfZ8tghyLf5LKvfN/AiRZ?=
 =?us-ascii?Q?3L+4lRMK16iTw23kFfRDDNvUQS06UiR/a62rGR+m+3GLoMy8vqYvA8Oj6uZl?=
 =?us-ascii?Q?2/6slXcoX3DiAea9afFyki51fQFGeBSL5ZXCUzUfqxgxyWvK64Lxx04qfwCw?=
 =?us-ascii?Q?36f9JQ6Y95lxFoAkxMI6Nhm2Cj5qVIkOHIzr1w/RKElWqld1r+k6nPdAXnvt?=
 =?us-ascii?Q?RbViu5r+fSfcIZwSw6eA5E9T+JNdtIoHaZ2e1sxsAmM0cgHa01pboA/AvOBz?=
 =?us-ascii?Q?HLmPIVs0xGWXvvCcAxmoCFKJ2FdyIPUJvETuYjSjVwW9rmEMVx8z0xLLVhb2?=
 =?us-ascii?Q?R2TYP1BAm9Uiighz9iZTV+nwXo35jLzmfD/ae2chxiJ+F+yyIcTePOpInbFU?=
 =?us-ascii?Q?fjQdjcuomMDZHzXb2BQ9ZzAp/Arhgtexg7RY6wxYHBAW5Gv24XcX28MEEuIS?=
 =?us-ascii?Q?Qp91JXNPYtp+7TAFeQsRR9mXs0lyzoKSzO7XM+VtAQBzIeao7lq79KqJQUbd?=
 =?us-ascii?Q?2o7DeV1AGMMegVPXmpaHXagwL3lKO0V/YYHXkcNlUDM21nxNbX4B3Whwa4py?=
 =?us-ascii?Q?gxDeMbXIOPMGgGWQTZi6D10DSYdgQ68GvEpcxlo4uT4s1MDjwVeg5lZ/sXsX?=
 =?us-ascii?Q?OquMvlTWHYQ6EIO5S3KB7Ex7NmlL0uWEXu9i2Q01NLAEhizwsOXTNIj2He/y?=
 =?us-ascii?Q?P469441T4jZXgvsdQPuJJkTgCQoxPmeraDBnQpcxdEK1e6XKrdEIhTLrmeY7?=
 =?us-ascii?Q?Ydy9hYrLOYsL2a9rVitgvteLU4sQ36hHVDi2is7fY414D7Fsb+OQXg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Vn2TwJ3eOPGX1FJn9ih1IkkXHhao1pY9XJMzIK86+E87VjaNysqPN1CqEqe?=
 =?us-ascii?Q?CCH+3SJztLo4kszHkZsUplQANt7qUbs2LWTX5eDruB1xyGEI8v2Ff4ZYiOHs?=
 =?us-ascii?Q?dDt8+VWBiWtbUi2uUYleXyPmQ48eFnrDxHFHp+ereRz60vgskB2PgDCLhEb1?=
 =?us-ascii?Q?G5HapS9rSPA7/+ZKiP+Gm3F+SuTLa0pobZgTRrxHneOZorXHo7tunBQXk/yK?=
 =?us-ascii?Q?UAQ0Hy6hXemrAYVcmoFGzFs06GCH8bn4Yi+WhYWuncn8FBtw5WlLvvLKx+m/?=
 =?us-ascii?Q?1EY75At8cWm6TrkB4UjeGA1XqUnVJZZWzuOMPtPF4H+Gaoy+HmQPqHbUd3Om?=
 =?us-ascii?Q?a7Y/RgLCjmStQKi8aRA/giKgnLAAcGSiHuHbe5XEJ/tNOzLdElg18+URKDNC?=
 =?us-ascii?Q?w1r4HIFUTIC4Sq6qXNJA9RASvj8i/WqSl2tabJ8vA3SO6pstT0Mpc7agAjjJ?=
 =?us-ascii?Q?iYLp4jI1+Lr69dq+sVOwjEsYz4SUJtDcDx3oNrSuvkxXn8QFwrH0WeigVcYj?=
 =?us-ascii?Q?2KM4e6+UTuBfvZw7gZPbQF6Hidq2cDjhrtPQv/s1CzL/SrKDmqvwQOIx6l5j?=
 =?us-ascii?Q?yVNDQyzC2WYamjuFfSHb8iSJbVqGqsXRkNiVGZu4dZpGSi9kP0NumGfR+ejf?=
 =?us-ascii?Q?FK1ecOdwjz7V/hhZJBfYWyDIb2XB2+/uIkN4D/1WFWSZfLhLFhHe5Pq6FzgS?=
 =?us-ascii?Q?C13RnAM92Q2HPjS8Vh4Olp2BblHaD7MxaqU55PQVPw82XuSL+DtQyZbsTTiy?=
 =?us-ascii?Q?ODbUgBU2AAByJwHUAqa+sDQ8Ewe54pm4be91reg3uYb5/I0UUIHhtOD/v/bC?=
 =?us-ascii?Q?PtdsTylyKinECyhuYek8h8gMhTZ+m4BE2HSXZzA/gQTRpt8UgkHosDwpojJn?=
 =?us-ascii?Q?6mrxVK29hCM8ZxTahUJLcE3RM70Y54yYEraa62RDnjKtClfm4W2eQCXv7o5Z?=
 =?us-ascii?Q?FB6Zswua3V8TVy4znZNRal0afw+ue7+c9oiRTD8uM5OLC/EQIttoc07Sk82W?=
 =?us-ascii?Q?PpEvC/BKIuRf/TYCHGxIID33B8L/HGHhid9p21b1WznixXz1w/Ufc5IEr4wh?=
 =?us-ascii?Q?yUzosAbE7vgE2YCjEY+KHtqFlBm1bDd25RQ92lx8cTCD11+/me39G4t+7Ul3?=
 =?us-ascii?Q?PKC4KDjaL+320tlzDFYAnAhYo7QqrZRs5ycgm9GcrOSP313x93gYMSVX7Mlv?=
 =?us-ascii?Q?q4z+dmXl8RAM3+KuUH+Ydke5e/uA/DofAFC45/jB/qxt9jj5niTeC30U/GCL?=
 =?us-ascii?Q?euW2x3dMwrbwXgjrIB1wF8qwQBdidvju/8gMUBYY2oJXhV6UAVAKfXp8uudR?=
 =?us-ascii?Q?wzGsAojEErS6n79+XcXwYpVHLAqk04hNPhqQyoqxQ9+L2h/j6ZWgmcFY9L4w?=
 =?us-ascii?Q?XfUqDw9eKVC//zMPILNcPn3PKavpIEXWRg9lczXm+5P7Kg1acZDMiX+Tzy8z?=
 =?us-ascii?Q?ZdkC9aWZcDqm5ebgyJwGAQT7QioCepUr4di7Nk9aRmp3LkjEbqyMLZScQO6Q?=
 =?us-ascii?Q?RgDsZRCtLnB1Gr3iAun3g+pfFXZ5UHGgE6JbTWJiyvGSyXOnD4ZbwsnNUcpW?=
 =?us-ascii?Q?i8aY6xHWo6/TaGdaKOIN8bPYemxE0YKO+vtk1Gks?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3def568f-8250-47bd-973e-08dd7821ab57
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 11:20:16.2704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kx6ovYXUIZH6rAkaxwOhqrs7YsBc0z5MzzB8PDjEWU8aZF7+U46pVOTy99XMyen525E7CG/aWnyMJaygAmTejg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7326
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

Hi Jonas,

On Thu, Jan 23, 2025 at 09:48:48PM +0000, Jonas Karlman wrote:
>When MMC_SDHCI_SDMA=y or MMC_SDHCI_ADMA=y and PIO mode is used
>dma_unmap_single() is called on an unmapped address, 0x0. This may
>result in a Synchronous Abort:
>
>  ## Checking hash(es) for Image atf-1 ... sha256+ OK
>  CMD_SEND:16
>                  ARG                      0x00000200
>                  MMC_RSP_R1,5,6,7         0x00000900
>  CMD_SEND:18
>                  ARG                      0x00004005
>  "Synchronous Abort" handler, esr 0x96000147
>  elr: 00000000400015bc lr : 0000000040012b4c
>  x 0: 0000000000008000 x 1: 0000000000092600
>  x 2: 0000000000000040 x 3: 000000000000003f
>  x 4: 0000000000000030 x 5: 0000000000000001
>  x 6: 0000000000000001 x 7: 0000000000000000
>  x 8: 000000000000000a x 9: 0000000000000090
>  x10: 0000000043dffc68 x11: 0000000043c00440
>  x12: 0000000043c00440 x13: ffffffffbfe00000
>  x14: 000000000000031c x15: 0000000240000000
>  x16: 000000004001145c x17: 0000000000000032
>  x18: 0000000043dffef0 x19: 0000000043c00000
>  x20: 0000000043dffbc8 x21: 0000000000000000
>  x22: 00000000000f3d95 x23: 0000000000000002
>  x24: 0000000000000493 x25: 0000000000092600
>  x26: 0000000000000001 x27: 0000000000000001
>  x28: 0000000000000008 x29: 0000000043dffab0
>
>  Code: d2800082 9ac32042 d1000443 8a230000 (d5087620)
>  Resetting CPU ...
>
>  resetting ...
>
>Fix this by only dma_unmap_single() when DMA mode is used and
>sdhci_prepare_dma() has been called to map host->start_addr.
>
>Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>---
> drivers/mmc/sdhci.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
>index 4833b5158c79..dc7f0724a7b6 100644
>--- a/drivers/mmc/sdhci.c
>+++ b/drivers/mmc/sdhci.c
>@@ -177,8 +177,10 @@ static int sdhci_transfer_data(struct sdhci_host *host, struct mmc_data *data)
> 	} while (!(stat & SDHCI_INT_DATA_END));
> 
> #if (CONFIG_IS_ENABLED(MMC_SDHCI_SDMA) || CONFIG_IS_ENABLED(MMC_SDHCI_ADMA))
>-	dma_unmap_single(host->start_addr, data->blocks * data->blocksize,
>-			 mmc_get_dma_dir(data));
>+	if (host->flags & USE_DMA) {
>+		dma_unmap_single(host->start_addr, data->blocks * data->blocksize,
>+				 mmc_get_dma_dir(data));
>+	}

Many platforms have MMC_SDHCI_SDMA enabled, but I not see USE_DMA is set.

So this change will make dma_unmap_single not being called for the platforms.

Will this introduce any issue?

Regards,
Peng

> #endif
> 
> 	return 0;
>-- 
>2.48.1
>
