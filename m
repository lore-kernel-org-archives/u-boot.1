Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE7C105A594
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 12:48:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DD5584221;
	Thu, 12 Mar 2026 13:47:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hQ1shQpm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1292B83F9A; Thu, 12 Mar 2026 08:15:58 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24EB583F14
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 08:15:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOb1NBSX2a67NsrTNRNrKyudN7PieOYIzQPDh03cMjloNgg9q3w86WN9EVEo2NEC8HdanK8kHxm9/HYP13iYP9p36aJaB2P5v7VubO4O2Mb+0k51EI20OtGX4L0W5TPrU2U5oDbHm8/559wpfJARTPUSDI/4F03fRqVqlqt3LFK7JUlN3g0LOirF6Xux0mPXkhSphW1VASPwcZ5LSFRbnkeWAqWrG47NmWyyrpMeVnMn/L7lmZNnyhkoOgTj9/8xAKPrHJPqoqSTNLRytYm/rG7Ox9eUUcl424iIk/U74eb0TGEpdnAk/OqNUITbOsPfoj5iOH5B6ItvHR9g8cBSEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNHImrx1RTqFg5BdpqbJWDXUjN7RgxZlL7y8qqR2VFI=;
 b=NaQ25FUnsARP4HVEjbzhjNumRod3/BH2Az1M3xLxmyr/fcOpdxWtkB9csu531OXD+NNT/BSm0h2uGd4Wc+RYkmferssb8lXkDL46XHB/SnzOfj8eI8qdcBiqh+nhmmHBqpDXP2kN2JXWrnpXXYm61X0CP6Sx58AUcoYxbT6ur7NWLk0CNuffOjmsDdsUGl6g3Zv01MBRkGUPNr6WSuEVHqYP0nPpFIQABW6qP2gf2z9PLBC/2vK5DT2GNFJGoEosXlkz7e1iXymA2QqcLbhgUBTn/X4+sNF/KsQtuewAp34JkWtWGg+aZMC9S3xNF84Q415XPhJGXtdvqREox6N78w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNHImrx1RTqFg5BdpqbJWDXUjN7RgxZlL7y8qqR2VFI=;
 b=hQ1shQpm0TbuCbumXM6nOntXtGVieI2oC3shedizdwOy/xnrsTosCcjTAhGKmVoemuEpgt6lrjghtBd9NOQX4W0J9npfxCoEuggR55y0v09MYYMU68gPfDXY+1K+N32/4ZdHr+xnWCsXM7jcjH2uqjC+l3QGZJbN9oE97efjOoQAREL1KtsDnMTnDgHhbGsHBDNLDfNRqJupAp6tp9pe7659S4+cXOgcApr+RnRAyWGzGEAReBGUzjSEni4x49AQZdni67RT4PVq8RK7zwOBOjRZzjHP8vjKFQFXHw3UlZun8ttbBnoAit7Qmcf195pazOhQaJzS4PqsmBTNEgXHcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7892.eurprd04.prod.outlook.com (2603:10a6:20b:235::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 07:15:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 07:15:50 +0000
Date: Thu, 12 Mar 2026 15:17:43 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de,
 Joseph Guo <qijian.guo@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
 Ji Luo <ji.luo@nxp.com>, Marek Vasut <marex@nabladev.com>,
 Jacky Bai <ping.bai@nxp.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 David Zang <davidzangcs@gmail.com>, Simon Glass <sjg@chromium.org>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Primoz Fiser <primoz.fiser@norik.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 =?iso-8859-1?Q?J=E9r=E9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Jindong Yue <jindong.yue@nxp.com>, Frank Li <Frank.Li@nxp.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v1 01/10] imx: Add helper to get watchdog base address
 from DT alias
Message-ID: <abJol9LRGVDhfAnO@shlinux89>
References: <20260310-wdog-v1-0-2ee21e890634@nxp.com>
 <20260310-wdog-v1-1-2ee21e890634@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-wdog-v1-1-2ee21e890634@nxp.com>
X-ClientProxiedBy: SG2P153CA0038.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::7)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM8PR04MB7892:EE_
X-MS-Office365-Filtering-Correlation-Id: 67065c6a-2cf4-4b7b-374a-08de8007303a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|1800799024|19092799006|366016|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: uboL/Lb7P7mLt0cYuwq8rTkQn4hKVK/b0m4sEJXO5Mrmvp4rSTGN13yXXMqeJ6q3UbuMFdAcntfxWMf2nJ/9a3SFoj+tONro1bIR3ThPDu7Lqhx/4R6lq1gKz8UN/goHIg/EC/8EXdah1uPHV0rZsHJO2g9DSVvrOMXyG98/8D+qjiHxPA/IRnNUoc8gDbr5AadGGhl+EhHQVDQrK6sIRnsUTnwJGAfA5TK1piGFjaHRdi69QZihlktERN8FfPfyU9JgnJ7Z0Thru9Qerg+LV7JETcY+b2IkWEdhnU0rPZnUPnJGuYGRHFJy5irs/+GBhj6m7AGH+mvvJZhiOYo1qlP/JYjXrWkPQRF2N3GKepFDLy4VbyY7rMikhaIxSjR31zIXib6kvLTI3Laqdm9DOH/PYnlH5foeT3n6GAiq/sz4116e2juDCwczXQe4s3+VZvmXc/9M4yyQ8Vh4W15aac1KxBaa/3tEtSjXBFCU84P1mYtFA1YeOSkZihRES07M9dmTgaBQr8ksw3ysyjViQc12s5VO/UFR9a39QaznNsUEyh8Aw2sg993UW0Y3JEdqQFGK0eiEWQOyHR3i9AkpaZ17ROBU8FJz4nW0qfpcPRGR0dtkSHSi+eXkh0+AETRRZpCtWCrJiUGmGWlYECT8utLIEIfs5FXFEkueEspoMqj2FyoWdS/+9N6COLE1s4RVHXbs+LceET9IRB49yISUboHjR/MRW/QeKW/GzPu/SgW04ofkkNltJ/DOuGiTiMGEbHly0mVYbeczFIaWYZX7lk6uB49YwrUKlUXT40fDCBc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(19092799006)(366016)(38350700014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A7oeq0FZo8OF0B/tBDvJQmVnknNRxMDmcJWYmDXg8JuiH47L6ucyNw16mVZ/?=
 =?us-ascii?Q?ypXEyBnEASF3ZvNjeJQJeIdyup+JXQuq1vVjR4onO2Eu+N65a96bBSnqSEFO?=
 =?us-ascii?Q?E6nVUkW3hw0v9q90Y55bZbObx44duEK7iXp0OOcM/LITmRiZVB2+MHEtN1ho?=
 =?us-ascii?Q?Cc5q/T8i6AmrEmUzQCgaD2pT4sRD/8w43JrVfTHGXrzbNKr7No6OakgXpAeC?=
 =?us-ascii?Q?ElnQA3sIMILAsbDU0lsFjIM5YQ8/V2p2bb1aOJHPIqVCSm+XeYQxbgoogsX1?=
 =?us-ascii?Q?z8uwbqu0AkWprtNgDPVixRACIdm62jan7t0XTWz48NpBeaQNdOQuizS+Eaz0?=
 =?us-ascii?Q?ClIIu2T9wRHqfhwL8+dgGjhkCfYciA6uZ+GNk98XrtvIHz6vAOC1ER2ZqlV4?=
 =?us-ascii?Q?pvI9DbEBAq0ljP4D53lkU5Zidr/f9v8t8nYPgokObimhO65evUxqeBboK/TX?=
 =?us-ascii?Q?ZnEYpKAUKdJ2SVCxB8I6XQU1BtJd1zQBP3Oea7dl2z10kYoeiRLt1M6MZyVd?=
 =?us-ascii?Q?IUWk5LY4+bVcoZZxIuXpP1KzhE7sVR4UG3LIIQDWsFmwFu9O5C7jhN8LEBcS?=
 =?us-ascii?Q?sfc2ugNehSBKxABcOsLy6gfhRPbYf03YRyfeHkLCzgMLFAZmMEp9HtKZnYk1?=
 =?us-ascii?Q?o0RwJ171WVckxJwr2As7io50r3PFkfaZbkT5ZAufto2yNxCUnD8ZeFqs6Qcg?=
 =?us-ascii?Q?9Lzd5AZaTwIIDbM/uIsOBv/9o6tPeA/qcRSHFi2CDQabhTGYsVW9lD7XAGRa?=
 =?us-ascii?Q?rMyju4wEjT9YP8ofx/nE0elBE8wJqE1VoM9XsEcb9562cWrJrIVgbOb1SiXZ?=
 =?us-ascii?Q?8l4L0TfZXCHJArVf04VNlf/n88gCmPNRiDYNQW3YwBWpV5ufnIU+aLZreBYk?=
 =?us-ascii?Q?BPm8Ty4tG5MJjBjch0gjWdxtbZYuEl7h465c1OlAIPBD9S2nLJ+TkmG/uHPo?=
 =?us-ascii?Q?dG4YRAuCPpuW/hCBBQwaso6rAq0rUgiGBa2zMMP4FbgWj6fVqpmfEhrGziFS?=
 =?us-ascii?Q?/IpB4+V24cSqdiNgC/7nJAjkSoEqX/fTRsD+zvUoV2u73pt/cxzTrk2pCtJk?=
 =?us-ascii?Q?6jjgawGZqABPPLqNUSGlHGTrZF+N53NNdetxxTiTor39TOSZa06JWT5xXALv?=
 =?us-ascii?Q?lRi4fSahfDhdHe+VWy9Xbhh2pKr/SXMQFLHXJ2RS2nhNtGr0aQGh/ZV28Zv3?=
 =?us-ascii?Q?mtO/2v8DYpehNxGFrPVWLvul2gDqRM1Kzkj2d9ioUyGeZ9IbKJjRr/iQ6LL9?=
 =?us-ascii?Q?mdLSBHCz+tgLLiGNfvK7QO2vuY8823skx1sp+aYANCDD6ziuN3LuJBQ+DOBw?=
 =?us-ascii?Q?xRVMAtmfga1zsa3m4mgFAzomHQqlffLw2+3uBWTrMJZCOgGpqm+E2HsdI9iT?=
 =?us-ascii?Q?7UsmWJUZrz8uFWQ/x6yQx1bEBb8Qvqb2vYD3OHD30ZwPJp9Uw5/ZuWFTvKxe?=
 =?us-ascii?Q?xSKXZCiPKfZh9uxpg9okFlEue9zOQdWQtWM0FkfonG2O21U8SkSjMqDmS34V?=
 =?us-ascii?Q?uaZzeDD0JuqGQmcDNECXy3iycLzxT3j4qQTLkvbZ3RexAH5/w6w/gtkoyGJo?=
 =?us-ascii?Q?g7+4I/s7dDUVAqwk07eVqQyCI0ZlIMG0Tfs8acG0pvvv0mgPCKxw089EXsdu?=
 =?us-ascii?Q?WojE+tiPOE5GBcpzntbYU184LnhAywTBMWhFNfQ3FHcjZI/uhbwppc2mbcp2?=
 =?us-ascii?Q?e8pVDECKl79i0kCEY2eWvJPGUzyepCh/bou0hfbDpkegQVuxBRqVh177xfKd?=
 =?us-ascii?Q?Ged91Ba5pQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67065c6a-2cf4-4b7b-374a-08de8007303a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 07:15:49.9582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Jc5nXYpNtf8KBemJfW7Ygrn1YEd5SzATIap1GmixSh9TtR3cHrUPQ3+B6OU14q91UI4djRgI6yUkXLgkIjQbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7892
X-Mailman-Approved-At: Thu, 12 Mar 2026 13:47:43 +0100
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

On Tue, Mar 10, 2026 at 03:53:35PM +0800, alice.guo@oss.nxp.com wrote:
>From: Alice Guo <alice.guo@nxp.com>
>
>Add imx_wdog_alias_to_addr() to get watchdog register base address from
>device tree aliases. This function is used by mx7ulp, imx8ulp and imx9
>SoCs to locate watchdog hardware.
>
>The function supports:
>- Matching specific alias (e.g., "wdog0") or any "wdog*" if name is
>  NULL.
>- Optional device tree status check via check_status parameter.

I not see wdog alias is used by anyone.

Is it feasible to iterate the dtb by searching all the wdog nodes?
I think it should be fine to iterate all the wdog nodes and configure them
as disabled, no need to check which is wdog1 or wdog2.

How do you think?

Regards
Peng
