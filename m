Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE63CE63C9E
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 01:22:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A2F083DB6;
	Mon, 26 Jan 2026 02:22:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wHCDdCNM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BDFC83DEE; Mon, 26 Jan 2026 02:22:24 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A54ED83CF5
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 02:22:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9P0V6UA/bs4Js3lD/4JHUCtNeBCA8V3pPparCO4avGA/ZZOszMGAdxUtn8uNi9ZcDSkxOMZs+HOMSrteCWDMf+zLzXbqDCddRLhP969htUW7nHwCOgMcrG+o0eD1PREBk4ldJG2EqTxqWVxpu/fIYAEJf2dzGCTD7dnXAyfV/a0ga+bmvKT12aNITVj90vlSBMc7knTf6LpdjzI7YRlacOqZz6y1Q7Qij1aImnCD8rdVFevQwIVpJGe5LHwH1SkUl2yr20ZL7MtYuSF6uA6CGFmVExAJBvtFqnaLpqhgSuWN7BPs+eVUPjyLcpIh/hy92tsHyAFWiLXIJphvdaVIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIcXGk4TnsJRVfnNULXOYz2JJDG69d0ZGNy5BZdouTQ=;
 b=AAZVO2prf2DDRItH6tNWyYc2qhVn1LfeDWp9zY3NpAPuw9PnYIWoFMhiCdybCnsWSBVyVKGpu43FqvJsrXmjZr7w9DQR7lDPNjMV5IMNiVoQM0i54iz6EqK7SoIrr5k+BgUjAFjnlf5rNDb9zca341amVOJkpIcvG9bduXeT9RX4vALpa+zY0CVp8pfUDL3qH0Arf1PTe0eJpIbm/5eHiFUPK1+JbdUz2aw+JzBGcuiDsVjgRm6lXWYiFL3EwdOOpD2MaBQXHlrW3VRY/H70tA5jS5MEv5YBc2OZE3n0bBxp1hBbQShT5OHv11YabWy7QC6KVwtirnA2HiB7zOCd3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIcXGk4TnsJRVfnNULXOYz2JJDG69d0ZGNy5BZdouTQ=;
 b=wHCDdCNMIO4t2CjjUtdj59voOM+oVo78Js8j3yNbEJHN34vU+VsHyRjcP5hNlin4ZiBmm35x3VhmZKyc/Ny26NJhidLrymWwuPhaXydyL06Bq4aP3PFxwIK6I44tEcWSIwfBaGussMeW+beFwXRRgR87A0KcrtwFcrG94eXbXO4J29g4sPAIXRQWf+Xze/kxynnSMSVK+ooGz8qmixOwen/4j84cbaX5wlLzwtVwD0IiiPZQ8ruubw+w0ySg6xwbD9QrjeyfMBezMF+gK0QhyNfifRkT9fvQtgSFzlMRoebbwt+dyyhXME9pDWZ84+571ws1kwRLzVDlUPljCmblig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by VI1PR04MB6861.eurprd04.prod.outlook.com (2603:10a6:803:13c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 01:22:21 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 01:22:21 +0000
Date: Mon, 26 Jan 2026 09:22:18 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
Subject: Re: [PATCH v1 06/11] capricorn: config: add bootcounter command
Message-ID: <aXbBysE1PO7yhukL@shlinux89>
References: <20260124055452.8799-1-hs@nabladev.com>
 <20260124055452.8799-7-hs@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124055452.8799-7-hs@nabladev.com>
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|VI1PR04MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 41a887d3-1f8a-4a87-9193-08de5c795a8f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|19092799006|376014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7V4WfLzFYyFOwlSrByOIz1rMFuNmakObuztc9PRdihkcotV3k1+ujkyq17e3?=
 =?us-ascii?Q?C5OLnarGgxfxDqeQfNZoTgBBna91JRtdM5NNWfNPxlBRwSYewH46xU7S0/rd?=
 =?us-ascii?Q?bK8e+TSjz6d/otXsYoT3RkbxunUL7nPbyxmr0/9L7Qzgcq4eSWgYelgLdS4F?=
 =?us-ascii?Q?2COCEtLT+vw6hxlUXW3py2zwRPpHdfhEtF8VU0p33NxXM7vtRcQw//GjHSEV?=
 =?us-ascii?Q?vAxg5rUov7io3qIKRKnWOkzS7HTJFbSBonRXmvLDBii5tJlWtV1LoUIK/9Cr?=
 =?us-ascii?Q?1jVJNOUvLFJHY0SUSU1N7w8bHpVo+ykPcJtYP0hPw1IyXHLzeZ7dd3Lrumg5?=
 =?us-ascii?Q?G2ZeFYJ3YBzRo/Tlwt8OEWTiHC6obiKgYej/uFaXk6pxSzP5eH07AqhhTWwc?=
 =?us-ascii?Q?NKJWlvIJGQMfLB/pc5+GJY/NJfirXw4wfOM18QYmKaZmdadmQGwqf+Vhb/MJ?=
 =?us-ascii?Q?l2BvNlxhdh09AGpEyCsinVZxjColdu9S2+FaoRUXnMjg3WoaVnbrhblUZ/ff?=
 =?us-ascii?Q?XmESiIqc3e45A6wOUKioIG5xrMC6veR3vc8uoqKV7nEVVd4AgcClRNl5glmj?=
 =?us-ascii?Q?I9Lwufkm1e0oZFlh1uoIq/Fbgn47Dg6lr3lZUx0093NThlLBf+DnRhAsCg4w?=
 =?us-ascii?Q?VIBOybi5VwC/N5v5BLbDR+JvrM17Dum/4+hzFxDBs9J0lAy5RdyweFMZ62+z?=
 =?us-ascii?Q?aHRbK10Eesua1TYPwKmZCPTqkC1AO0+MEy+wp6s1RG3heICJIbMXUrRDs8tR?=
 =?us-ascii?Q?pom9b3WlcnY+eh75bE1IgBUuhJ86houL/2auMXsc8fleFmE/GqztlzTpC1hp?=
 =?us-ascii?Q?mwj87MdNJwW9h0rQeoXtLHpKR7aWT06MBggwDOUnIjbKZAy2ktRLelsFEonL?=
 =?us-ascii?Q?6J0CGgVW1e4ZgGq6I9nttG9W4QueVGO+Wu2QrwpzUaUIulmgAJd/4ypeQv9h?=
 =?us-ascii?Q?ULptiNMHXn7A7eGfBbzoR8xpD73fp4YYeGGyLJxbuXuZ25SD/cT96DRI+8Qh?=
 =?us-ascii?Q?lGXWuTf77FaSEj5j9bYUl0PJYKJeo+ZsHyS5urktElGJhhPAqofho+rchNiv?=
 =?us-ascii?Q?d6MazC+4HSteifTuFDztpwZapeHzNrp/wXQx6WAgCGch5aXnHyTlKY//aHJu?=
 =?us-ascii?Q?siiGVM5ursvxbbx6yWnOXfrGmQ0GalDcHBgUbvGABYd8arY3rk8qtcUB5DKx?=
 =?us-ascii?Q?FzGmE7soK21MsjMmLhv011JoSI/Q5CohFQzsflUZSP6zOW1zbG/qiv8HUEo9?=
 =?us-ascii?Q?4XwPI+02BH2oSNEEwDmwPdV3Sz9N12NS1xrZL19zsGRpBk8SKSA2aA3K65wP?=
 =?us-ascii?Q?wM8HsJ/GxVs/jtRShrsxaW6hxYm1zEWSNFgl+W8I+la3lXTTBFFWmn9eirnA?=
 =?us-ascii?Q?dBhOPxpqglD/UYWUv6Cj3J/6Ocjex4bxhzZS3HAg91y0uSKFlJ7JHgsxbnS2?=
 =?us-ascii?Q?0muVo1elJIxZtRsIc6sTcP+R4+qFwvvDka6ZOGUnpUYANADkdrLgdOnpZs5d?=
 =?us-ascii?Q?W3HoqEGQAenYqa4/zeDBPWtCdPsD96mPyRwvHPNEnWEFP3qd8xBBeXH62N7j?=
 =?us-ascii?Q?I9HRo1SwkIqHR9Vx1d821UOzKiSQzGpfrsDKwDwuun3uEK20vtzcDuQBFn9N?=
 =?us-ascii?Q?4J+kgcwctOqNKLdJ7A1Jfus=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(19092799006)(376014)(366016)(1800799024)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S+tMH3zKzfI9tQq3G1tpDSIUoMbrd6dPMExExBkgqCXOxA6WlSih8fvjSU8R?=
 =?us-ascii?Q?hIX763B+W5SP4QW/iyE7LU1AdsnnzXLFEN3ZA357EeZLoyxAAAnIXX4XvOy/?=
 =?us-ascii?Q?dHpTC5j0apak10c2EYWwGjcHTRmeaflDoaXuUc1F/Ikwzcv3fP2iDUwJQFUq?=
 =?us-ascii?Q?xlugdCWDDK+Mhs3Q7bRq+glrgs+PMtGNRWuvihWJKLgfxueJAyj+TS8CsiZU?=
 =?us-ascii?Q?JPKVdndEUhnl6wPaNBHuOUFT6qRYYb8w8+aJvu1o0l5gx/VfedZuCYvfBrZ5?=
 =?us-ascii?Q?M/UUucnSHc/4/cGAViBzs/35Jl3pS4ALsXXd53ZkZkfj+JOikNEtAnMEpl/t?=
 =?us-ascii?Q?QcNsgFlxVvKSgIros6Q7Bnj7Vx8vyIrEgS2SMjvDCWEcxt3y2WULdZ1kDdH3?=
 =?us-ascii?Q?Ztpnx0RmwR8W0FjR2A1hW/L3WlYk9NDvH2h2v2GOU9x75qSBNtp6qAwD4NxY?=
 =?us-ascii?Q?s3Y019eNT0XUr9ZiwU80JF69el7FYi8AGD6HUyDx8a6iq8/ajgfJdQ3HiWn3?=
 =?us-ascii?Q?rx/I4qtIvNjRObPLkapC/fLm6n7pkfLVrWteJHLB0jtskcnQsuoB21A5Fyy4?=
 =?us-ascii?Q?VChdwPMXPPrHbxHZsNx39QNESFqqCTan52aaP/aCsP9Ru+bhxCsOLYF5RUdt?=
 =?us-ascii?Q?Vsk5zSQ71MDrsVhb/H+xb1LObS5D3lbpJK3psSKeet40raohuCUtUto+JO/F?=
 =?us-ascii?Q?5gfoPI8eCs41kg9Bqc8mSCcMcgub9aojY4dh6/70D8MFmiaEbetTw5ojkFvh?=
 =?us-ascii?Q?srh5ZT4USrHwe26sx+TFw6HALtGV66m8YNYJcPXvjF/lx+g1k6uvSl2lnKd+?=
 =?us-ascii?Q?47CCYxTkIfJv2WIyCz8cQ5Yr17ipJ518kYVdIrpWefoGBpsf+33ZuU1sP4Fi?=
 =?us-ascii?Q?/8Wns+HIJGUh615jAh90yRI7Gl4fGeTafBIrc+XrYAE5rn1t8Hff2+cUiglZ?=
 =?us-ascii?Q?0BaxO3gnhL/EZya4WEd7deQb1UJeXv/DSs6s9fLSmH99NSNIPMGS3uJem4zi?=
 =?us-ascii?Q?BTTjcT7mmSpaKFxPF9OORoEGoyqacnLgNr6SvVXw29dOxr9YXvI+xEeLF4s3?=
 =?us-ascii?Q?vBIT9OzAWbV9XHl2aBp9LqyvzDxTYqmRQp34gXWN9v/8tGusAAgfgbNZIR7n?=
 =?us-ascii?Q?0vWeLdHkw6fa6Kkooh00J488rOCpNUBlqpQFW8N4ppt2Y7oBCivFgh29ofe/?=
 =?us-ascii?Q?O90JtzA0a1Gy7UwwM9DUCnCZX6kPCYHZWG0uogXqa5HBWk2KgrOV14Bm0LLM?=
 =?us-ascii?Q?AUfIJTpLW1FvlQszu9+m6J9bnpToz5n8GXKfmOMXu2A99an+LlJBidMa2SVG?=
 =?us-ascii?Q?NqRnsIYw8PssaALvwRSYpDGIer7wjzP5enTdQyGmDgMwG6RUmEm/wUY8Hvtt?=
 =?us-ascii?Q?epJPeTgE/KOFjFgQVwiXPLW3d1LHW6jTpO6XSQkkbPywoHuPYwFDIfQ4/hRG?=
 =?us-ascii?Q?D14IhcJR9dCIiYcHV0+53fpheaoE7qR297eSJkYSxfTenloFRl/GoFRgps4J?=
 =?us-ascii?Q?SF5XDj9x0jak+0uq7QSN5PgVVqYDtbVu4XCRRQlq5x3jvdx6kg5N3x8JOJrp?=
 =?us-ascii?Q?9oSV8eRYPKrTPhn7CG/8c9al92jMzDxrZv8Eh+wqVXoYhbaecrbCk+Xmb+tF?=
 =?us-ascii?Q?455GzdO1Cg0Ta8bg+myAZZgJu83U8iap/g8QZV1QGG6EXRPKlObiWSwPX5rD?=
 =?us-ascii?Q?QI3PvcNmzVBcwl7ibQBAu1pOvYOczWCJuZE1wQ+CL92eI1LEfjC+buizf/7n?=
 =?us-ascii?Q?RwW45sv7TQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a887d3-1f8a-4a87-9193-08de5c795a8f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 01:22:21.6874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ph4rGG2DbH9jaIuVmySUahKnSnzg+uUq1RM8ove8RgZO7G3CFy91tJJND91D+bebeyHPBAmm3od3umHLxPlnpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6861
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

Hi Heiko,

On Sat, Jan 24, 2026 at 06:54:47AM +0100, Heiko Schocher wrote:
>enable
>CONFIG_CMD_BOOTCOUNT=y

If my understanding is correct,
Nitpick: Enable CMD_BOOTCOUNT to count the boot times

Acked-by: Peng Fan <peng.fan@nxp.com>

Thanks,
Peng
>
>Signed-off-by: Heiko Schocher <hs@nabladev.com>
>---
>
> configs/imx8qxp_capricorn.config | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/configs/imx8qxp_capricorn.config b/configs/imx8qxp_capricorn.config
>index b5c9fdbc9b3..626634cb09c 100644
>--- a/configs/imx8qxp_capricorn.config
>+++ b/configs/imx8qxp_capricorn.config
>@@ -74,6 +74,7 @@ CONFIG_CMD_CPU=y
> # CONFIG_CMD_BIND is not set
> CONFIG_CMD_WDT=y
> CONFIG_CMD_WGET=y
>+CONFIG_CMD_BOOTCOUNT=y
> CONFIG_CMD_CLK=y
> CONFIG_CMD_DM=y
> CONFIG_CMD_FUSE=y
>-- 
>2.20.1
>
