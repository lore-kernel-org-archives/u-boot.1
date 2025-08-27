Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA83C8303F
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 07:06:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D314E83192;
	Wed, 27 Aug 2025 09:06:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EkpCWV/5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9612C83192; Wed, 27 Aug 2025 09:06:23 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E01F83189
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 09:06:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfg53sHReFhH67fwDiG6elnZb+3+Pg4qhuoEwUOThDyyFIbxhesY6a8Zkww8Q4wAx9sTuRju7sLLmPNhE4OsnDDkaniF6J+i76YjgYz+jU/q6mLWYAfvzXFLXk9CGbN9JRH47k4IzzAv+eV+gBA6rPG9kMqb+1pSvbB3vaLPnQcM1xjGSc+QJN4AiX9Xc7FQUPQeTQm/FnyW92Xewl7nTwYam0CCy58byEMXxNyZKYcG40NAfJt/pSKx3UsCvGaHXzwM6gzo8lPDqr8K+ZRhaf4J5OZpltHbId0GXkLwzHEpmNJo5+keulP6+2C7sEnprdTTgMEwBaWHAzyoZAC2Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JefgQEeiPGo+WqanNqdp8wCj/qijFlqG0yrJVn0nn2A=;
 b=SHOatRklGGYMYVuwhM69rxll3MvJhUj4/t75j0LH74zZb/Ebpuxz71e6y5/qCACb8Gaf5eI7cS85cQdeXCpiegnzsk2IE/l/OxWoGTntK2QB6ebc4OEO+9WKpdjysfgQOvV2HMcLkw56yRS6HA8JoGKdQmjINIxiONxzpK757G7A7kAxrw2b0IopZeBu3n6HRbm+hJnXfyZlAsajHUMOzkfNaC+svf9maN/cOPW+4xZThpf3gdFv+8rSCLkV5ihASYxC/8k4/TJkyBavMoRN86W8AO/KP7jQKuXg5KNYac9mVWM2XxbGgBqXsS8fdvYuOaGMTXm5ssRaLlhlg/jq/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JefgQEeiPGo+WqanNqdp8wCj/qijFlqG0yrJVn0nn2A=;
 b=EkpCWV/5QpeXyohlUAqKd/H+RA7OAdbWGAGegjmTd/p43WXLp6S97i6VplMDLu5DpCzr83x2h8GndnlQ7t9l5Jbvqu+6NIYoUsFCz+o7Bb7oU2lcoprK5rg2d5h4K77qAt1AzT6bb34/o6y92JRrVbbh9ya+LVNJe+3R6+wNaemTjih2Wzd2InivpKdSpqo9PGPqwD7DQooSHV2QZFUhsUoprOyaEE/q8Fm0YPtzWIieM29z02eNpWqkXZscaXFZ94p6JhA1eS5F/CUvBl0uOx8R2iVedAXGjeY5JE8pvCIh8+Ugry0jBaa9lbkjNd2T4MP7tMaSorE9Li+zJVo9qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7882.eurprd04.prod.outlook.com (2603:10a6:10:1e7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Wed, 27 Aug
 2025 07:06:19 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 07:06:16 +0000
Date: Wed, 27 Aug 2025 16:17:32 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: "Anthony Pighin (Nokia)" <anthony.pighin@nokia.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "gaurav.jain@nxp.com" <gaurav.jain@nxp.com>,
 Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] drivers: crypto: fsl: rng: Reinitialize job ring
 descriptor for each iteration
Message-ID: <20250827081732.GA22823@nxa18884-linux.ap.freescale.net>
References: <BN0PR08MB6951D0B436D20B1306B6AC818354A@BN0PR08MB6951.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN0PR08MB6951D0B436D20B1306B6AC818354A@BN0PR08MB6951.namprd08.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR04CA0203.apcprd04.prod.outlook.com
 (2603:1096:4:187::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBBPR04MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: 834d2f2d-e601-4074-345b-08dde5383674
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|52116014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uwbe3ReIJu+YvnLoBOvx7kkKBhv6Y3eh2Zc8ql8Cnybxp/Lw8dYgdiaINKim?=
 =?us-ascii?Q?weyW1xtbtk/qlHszPJ/UpoRcreYJcp5j9NNwqaUUxs8azpYUwQ6+ZIUrevaR?=
 =?us-ascii?Q?IL28NIx2k70lIAh0b41+srk99GC+W6eSwmXXEvrl/ToaqRk1g1pcHXrvL9zT?=
 =?us-ascii?Q?au7ZZoZQnXe+SlaJ8l5yHJF1xOv1mfi4C6ceqeAz1EYjCPBeHhJBks4d3CPZ?=
 =?us-ascii?Q?okZooHRLXdn2bdy4pYuxntGorW17jvjELvRNVBHjJLbNYBG5LUmZpr2/zV5c?=
 =?us-ascii?Q?YNs5tBqdk1omfYksEJKNKr0NRTBWEV/0wVwjwFDzHVsytNJmQ/mAR6MEEtCl?=
 =?us-ascii?Q?1IH6zTrCrSP+DL7pRYzE0VlNxopYzdLHT5L2kTPu0OrbclEGvJ7bev7OFsgY?=
 =?us-ascii?Q?sq6xEWq7+LRf60r56nvH0zCVu3kyzi280U5fly7croAartonDGteDGjogdnB?=
 =?us-ascii?Q?jJZlSVytaJFrjX2vLoPKJwYSn3f1o2wBxPul8tutz8vlZJO+NdBkb7DNEKNq?=
 =?us-ascii?Q?BDTDY6d0odJGsq7KB1zkIFUnjbFO8e3oLujHTnEL+AbtxaaTy3gpIh+WsXtZ?=
 =?us-ascii?Q?eBe2NFVlbWTEKB5g/P4NrfobwSsFqM1qWJ+TkRW2G8K1fePCyQNtnLQu7IQV?=
 =?us-ascii?Q?M7r69Fd7/XB0ejtEuRCPhDk+RwIJaV/YFsLx4X2YkXCjJUvQwhfzWyAudGcR?=
 =?us-ascii?Q?w4j7yIm0Xl1qZ7/UeUh5MHEZ6N7hoPsNzMqsoD6efAa8RIR7OLWL2KgyAHql?=
 =?us-ascii?Q?ZxjIMTVliZv3oCDd+AUkmyZ0mEPi3XlQCzemXKptee0/DDisEyqjMDIhD6C6?=
 =?us-ascii?Q?R2CMPUxLhOdFjg0tqlGWzNtnrEw7cuVn3DL/zSos9pdXH7TSg+u6XqQ/wx8E?=
 =?us-ascii?Q?YEAFHxaMaVxKAcV5KaPgHpFwa27Sca2UW3JrGa7lJSg+9G+a4EQmu8U/cqa3?=
 =?us-ascii?Q?oP3LWZUsdSokd8meCxCHE0eCXRLtBCtwNfO+slBfx+CGLa6bFXEE1w9CPu1O?=
 =?us-ascii?Q?qUf2qFF251SxMQ22wjFwII2+ejezU1mFD6fsRe8vBb46C5ikYal1+EjKT81j?=
 =?us-ascii?Q?hgRB2vqYkoHGWoKAXLGDVtMiiIMq2tO7SZpjLFuAqjCmXpDqxXgYrWje3gdR?=
 =?us-ascii?Q?Y2tMSyW+Jdd3PEjvcrokA6sJqMk5PRZMWHgXuepNaU2esYiFRFu1IU9G+y5d?=
 =?us-ascii?Q?zcARWBIQlAnwGpyBHoMOqO7wN2jUqQWJ6Uwh1VSrfN1l3FFyndbRhTFh0qfc?=
 =?us-ascii?Q?O28XjhNlbOSr7JBEVQgd3Skcqm9MSRKaDKLt06Lg/iI5sgiRPeISiXUTZcAb?=
 =?us-ascii?Q?j5+ZZVRU5WSr1goeXhMz7nmNA+OG4GDQ88YO7n7ZtXW5frfQORVBJQFBxyti?=
 =?us-ascii?Q?Q6oPlGWv8bgx8NtXkVGpB9gcBCYmcVDc4dltZbruaorS3SC4TZb6RepQ1pZy?=
 =?us-ascii?Q?+KbvSybvDzLxlTBlZL10Z2j1Z3hXyy9unblCxd22uiMcc1Pc/TCrRg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5AjmBYGOQQxnDtev1qHEegvujyo/o/hCZd2JnjwCm5S4io6MFnb7VbjTlYNi?=
 =?us-ascii?Q?DkawX/iMsigBZ7PpN1JGGLTBgMZxAthrwLG5ib9Hxlhu6f/CMi97TVvfKccX?=
 =?us-ascii?Q?Jodk0CguNFGYWaQmHtSRqTBoIvvN1IvOcET6uu2C1QuOqAk7wPx90XDvcCH1?=
 =?us-ascii?Q?Hw0N/f5tIRvAsYyXN8BHpoEGeo2Cp+WlqxEpx58ubX54oJHDt1UwTL0lOKJP?=
 =?us-ascii?Q?BXZta075vNeqqmIk1MrrO7y4dAvsY8IZnqpJOUO3s2spmouoRi2P4KaeakBh?=
 =?us-ascii?Q?NBfeQ2PGnjLib0cKfsRBWRS5RNt7YjKy/V2yD3w5utnEjhVAEm3QwhDeOdVc?=
 =?us-ascii?Q?zzCDDFnf1Mssvk+jsn22Ukk6LMPSWXZo9JJ+DzYiLrcajIcaFP0I7eEvTDw9?=
 =?us-ascii?Q?VkmGHTSztmkpxeZqXKTDtDYRFaXgZkFqzboKAp9LD+ey0YX9fhNt5zVWaEkT?=
 =?us-ascii?Q?Jy600xzBYH0wzgyGp+nhk89OW5QR2noJXze/FK6KsrGiXyWfkzKfn7sfs3ow?=
 =?us-ascii?Q?mA8AIB/9V8MUOp+52rrfL4Do2joxpjGU6gnRVK6UETp8S34ScQhSWV1GASsE?=
 =?us-ascii?Q?ZZl3ET9gJWYUqF6DHuIg1Fliau++Sbu+HNZqL0ejeeuXajdcZyEjMY9YqL4t?=
 =?us-ascii?Q?scU39hkwiZ3kKJjp0TQtpjExmC8fNNXpZogY8ah47McdtrMy4LEGspUZSB+B?=
 =?us-ascii?Q?p2jneCmR/R68y9cWmnqed0hBMHyz17KunCPYU4c3wVgA6xr9W1WtrL9uQNEE?=
 =?us-ascii?Q?BieuRraJc+OMDg2/UGpNU59yaMRDLxViAiINSqfeDhnUdw8X+q6SnC29y6My?=
 =?us-ascii?Q?8gY8zc1j6EwiEklnOQNWTxuuf8Vn558XqK31m2DpcuFXHsvM7ltuUjKoOoLi?=
 =?us-ascii?Q?ZxkbQD1L2RmGWpSvHntrTKzrHp93732/KNzuLpq1f4hHnUdC42FmNlIkyOPx?=
 =?us-ascii?Q?heURrCXttNLc7r9enrs1An+dUT5tLz0woXSb2myRq4DptiKpynqXfJtuMogM?=
 =?us-ascii?Q?RuV+T0dow7R8SH4GVuqAJe90CHg8gC/rkcFUI09iO7dmgS/SNVIpCfwFbauv?=
 =?us-ascii?Q?K16d2MM9K1piXOtFPHt8d9aVei5Mf80Spq7yB/rU6BTjjoV018YW4eFjz8Sz?=
 =?us-ascii?Q?OJJfNwY+nS1varxp5EBOQnlbbfZ4NBMIPSp3UknyzgekRv2e8ezSpRnOOoSV?=
 =?us-ascii?Q?qrnXjKne8wfFqESt1/Nw8erLDfOO/1urU1M8Z1kgyZu/+Q1RGkt65KM5aG+J?=
 =?us-ascii?Q?CJKuOJigdYKum3tZduDP3Z7s5aNwVusai+h6gSB6tkNy03fMiah0A1bx4bwj?=
 =?us-ascii?Q?eZfwywL+boQULHV7tp9gP7r73sTJ4smaXxiJnM6iRJB3hheK0NJfXcrHnnBS?=
 =?us-ascii?Q?dYDRxO9sTJPJACrM8FB+DdS3TQ8E7gx9GH3eBiUq8k9q4GTpBjkfo/7jNy2y?=
 =?us-ascii?Q?eHDoVwgtUuuAZbRPnZMhGT426tGnW3VXKE/kJR09r5zXIdiIGUpU0kTasKZg?=
 =?us-ascii?Q?MfcomIy1rZ+fZ4YXIRvy/+MHp27L1VYdKWG87J/LWViTTDcHd6O0oZWG3CqD?=
 =?us-ascii?Q?nsyTQyaBfF/cP8jyqIiCQ/ugpN3lKTHYaIfB72Px?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 834d2f2d-e601-4074-345b-08dde5383674
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 07:06:16.2401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9whlZnaxS0SAvoj7m6/jBsXvDBtco+CP6GPQc8QKy9kKEOC048GbbuFS3n4X8XnfDjmAjQ7h0CLxAVf+aPHjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7882
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

On Mon, Jul 14, 2025 at 06:01:28PM +0000, Anthony Pighin (Nokia) wrote:
>u-boot internals were being corrupted following an EFI callback to
>get_rng(). One of the many footprints was a corruption of the EFI
>protocols linked list.
>
>A request for >16 bytes of random data is broken into smaller requests.
>Those requests are fed in a loop to the CAAM RNG, which uses a job
>queue ring for interaction.
>
>However, the job queue descriptor is created only at probe time. That 
>descriptor may end up needing an endian swap (LS1046A) before being fed
>to the CAAM RNG. This corrupts the descriptor for the next iteration,
>since it will be blindly endian swapped yet again.
>
>Two issues arise. The number of words to endian swap is taken from the
>input descriptor itself. So on the second iteration, the length has been
>corrupted. This results in a corruption past the end of the descriptor:
>whatever is after in memory is endian swapped too. Second, some of the
>entries in the descriptor are DMA addresses. If the descriptor is still
>somehow considered valid after swapping, the data at the corrupted DMA
>address is now trampled.
>
>Linux properly initializes the descriptor for each iteration. This is
>what is now done with this commit.
>
>Signed-off-by: Anthony Pighin <anthony.pighin@nokia.com>

This patch has some format issue that could not be applied by tools.
Please fix your send-mail next time.

I applied this patch manually.

Regards
Peng
