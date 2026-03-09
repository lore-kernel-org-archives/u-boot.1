Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3E0EA8558
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 05:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DE87839D5;
	Mon,  9 Mar 2026 06:22:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nK0TQw/D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76CBC839DF; Mon,  9 Mar 2026 06:22:40 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7E0A83952
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 06:22:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qP9D1PkIMg25QEpWaskIlwYVOYvBr7fgCQvB7JZodhi048n3iQkLHrZoSurUzNNpziGOHiBzx7HEF3SYoRwRjkDdI9K97DhPnmvPi5Tv6jvPvqJd2BwAyZY9suNbO+OBewsgSbuhAz9l1uIuaYHcSvFjZs7xbPlrBSroKfXmHqL27kudpf89jmg2ZvLXhllsFDHJzd7fW3V2cX7tclLFaSxrC+cucliVqfjrlFkgnScYW7clYES/TIdz9R8zeiJnqORGgDBRDoBJj8oNoS6t3s2AYKKxG/6Kw0JUpDT5dfP2DUBlH7ElFzYhC1J9J0fQKSW19o40XFEmEesJ6RWZmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQoQ6fdv/rFuRIHjTAIBiSkvDNCF6exQpHHMGvJJ9nQ=;
 b=e9DiRkl9hV2Ta8CtWTGf4vudk9TLav0yZGu9beFY04rbF8GH0L/V+wvpX5MTGLhwndPu6rUEbkIYyY2g9qNhaV8nJgBnnb9NLpxqO5fazxJpiaCHpuPavyELWOTQPu0nWeWydYyS9TQpcxE/aVK2FT8A26VW9xnjpF904D/KItG8uayVVPKGf/iSR70603bpI2dBAgebbSiINJc0qEDt82pGMBpJ0RaotTQ9Lr7cDcp/ORl4TGW5ovyethNDgKZMgph4W5DByH+GTtoT8edxrSRJ9hrQXDKXtLgh30GsBd+jmYZo8iTuAWEKDJba/xZ6Ctt2mrBmhaFDWQ55HfOOuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQoQ6fdv/rFuRIHjTAIBiSkvDNCF6exQpHHMGvJJ9nQ=;
 b=nK0TQw/Df9LQujuAEqyZG/eFKeZneKwctNCOVBQcACNInc2RbYoipno0hIYnO1+ldnjy51mTQYr0qpL7R0ILAUtLy5csiMDgQ36WgNEESqdlVfvmdKLWo7jdsgXRapdDl75qv+fMGjc+eDMvv8Dxo86tWBqQLt7lSbO6iToW+KbQ0LE7nUOf0HcStLUtU9ydLw3OJXdAS1Djh4IHI3osF1R9QY8b1zFNZh31VUrjoIeEsYaYZ7LXyDVAwc8Kc3DetFHVTW6dLiiUWBZJs4wMgybu1GUur3+nGH4il0i2q356jBiV0f4c5Fm3v9E4U1tR2NpRsetllnHVnKa29UM9bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10765.eurprd04.prod.outlook.com (2603:10a6:10:593::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Mon, 9 Mar
 2026 05:22:35 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9678.017; Mon, 9 Mar 2026
 05:22:35 +0000
Date: Mon, 9 Mar 2026 13:24:07 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Philip Molloy <philip@philipmolloy.com>
Cc: u-boot@lists.denx.de, linux@analog.com, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 0/4] Minor i.MX DDR init clean-up
Message-ID: <aa5ZdyTtUwe5NReJ@shlinux89>
References: <20260306085824.886254-1-philip@philipmolloy.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306085824.886254-1-philip@philipmolloy.com>
X-ClientProxiedBy: MA0PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB10765:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa1740c-477e-41e3-94a0-08de7d9bdeb2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|19092799006|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: jk2G48hPiv+Yxl1ZOuJRooDqoEWZk38swXbbON8GGfJIQkLHoLzb5bYJpfRQ8zTRccNsHGXbX6o/pQFbF71xgTZN5BpzWFcbxQiuGAAw1AsTUvhJZ3cWdH7nhOchcFH5vKtFulpI+kcVJ75VfrwN4slZw40f9f3qCDCYQ3p1YE9Z3GzxAAj1DFGoPRMOrbfiXIp5WUl7GaKMmm6ibgkaBhGwHyf6ZjaiXysYJK0u/7L+UgHpT8lXsTwD+QcylaaPy6c038MRBct/VHGPTXsCbcV+kL/mEirsxFvQ+ZWd0qrXF8mh9fPJxUrlS88T9r3bt20/TaMMoaApi3BtCsHv057g5jMmMOYNefvLK0NQu7ApU1N6QUP85IE1/3df6TPdwJ1AXkOwwxABlycRO8H++LR6iZk6GMv+++F1uRkBzHfFoVbOx25xrCJbXpPobjIdV6X/3wCQbwYSjcK5gWdcAMKSTXsoJS+Cto21B/2kU2LCKz7W/QUDSMb7Kg1AIEcBvaOX0VfpnQkSW+w8GmZemR4f1DWIlO2tGc5btCyzsb8q6fkPd++Uv04dm+okDq4v2dDvgMWURhrEZJVqSU5/oR0gd30mbbULp0LR3OviSLZcipC/Y371nlXe8mkudA3pWnX7iNZrC60ng/Z8WcByayfo3kKQi2mUIiyVeHyNItQH+OtePLnRUBNY4PnNwBS74NytP2j8LoP0zlDKj8DVkQHe693MoTpcnjRMlQIBsu8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mcmnG66zOZdSXzA2sqC5G0OjhtIbUVKLRy64KQmsswaEIGov0SNI953vKoU0?=
 =?us-ascii?Q?N0mJibUQOsceJCiDPBBIqV+m/9cEmIUVKT7sigShOQsAGRp4bn8nHctoaZfg?=
 =?us-ascii?Q?jNwyHyGvE19h5aB8nz2LKf4reJS2UcG/pKq48aWXSOv9uqxSqwL+EMyR//4u?=
 =?us-ascii?Q?qmmHEr6Iy+t19b7HZpHmRrxmaOkr9JnzDT2539JblqGYWvQCklne/DKwaRlI?=
 =?us-ascii?Q?E2/F212MC9t06qHMcEmJBhwLwG22N805IVm93H21C1VHUOoO15Sz13m2RqcH?=
 =?us-ascii?Q?NQxlfkYH8PzmWPrmggvgNl1oQD1CJdjubZ1leUc6j8VWPrJwp54Ax/5Lj7hU?=
 =?us-ascii?Q?jQydQxCAfIWEHvDccjqJn2+Qn6M+0NOf5OAafq7fpmSJa6EgixR6UpUC5jiF?=
 =?us-ascii?Q?UcyO4HGGtkUa3OOCXA56OFmP3SrERFPeMcnt3omfEjGhCXFu31E/fR6fVacj?=
 =?us-ascii?Q?ujZZ4sZZpfyY8GkPnhykunLF/IZ1fx3UBfKHPOw+1vsuef2vh4FNCK1r2XJz?=
 =?us-ascii?Q?tHzHNmslfvZD9WypOsKjfkTXqcs+XFWEpitD6SbaB5ikZ6OOekPq/6FVZ6uF?=
 =?us-ascii?Q?CdeEqkAYNzcuD/Ukv+Yqb/gJDpcQdgrwarqaOrMDmOhQTlv3qVr4Dm3UiQbo?=
 =?us-ascii?Q?QnQGg4a6AV4CrN/nwv+6wgG6/v26zHw6uzjB+FYtfk3eEdYpB/U3IV3fzYe7?=
 =?us-ascii?Q?YzsRWWYiNYPvRvMgwHuSgEgFsXm+oQVTjuiJ82UiHNBJmDEflgxgQeZ6V8/M?=
 =?us-ascii?Q?1RuALozRPoxz+vDMZgKch48jch4770+CxDi/UXHrcojH1jVmDuX89hjI0iGS?=
 =?us-ascii?Q?hfJJqYL7I0srAvNlecxJyiQnbieEGSRya5ud56lA5o1015qJVVFoaikoZiVx?=
 =?us-ascii?Q?XfAhOhgFlnnA5+mowkaxmtUzhd/YAmXnvnnnHyzdzvTMug0cWQFfAcGuqeIy?=
 =?us-ascii?Q?meNyYuYYGp+5OCv5QZD4y3EF1L1Hip4ptUcGijK/wEJOLHB/LaPXK0S9mz0M?=
 =?us-ascii?Q?DQ/puc//X9ZUCe/GAaEkGW1uHHzCxeGcP+3ennTwZyw45BY+0FtfiuGRVycX?=
 =?us-ascii?Q?nSY+QzBjDp9hwhnFFaJD6eJm9Tc6LAwyWrUPQFGZZeieuGGo1tcgtw3pZ6kZ?=
 =?us-ascii?Q?g+zGagMBw78ol3fKToqqRZf1D6JrhPCbCbkIMgfNY3rmruqiWU7f9f8VrMjx?=
 =?us-ascii?Q?7ICe29aL8afIvEflWxFTg+eHoNND5udiuDeK+Y55aB5MGRhvsXub9TvF2cqa?=
 =?us-ascii?Q?XYQIwuzQM1AShiSk/Uh25x0d0JHn0cO2sXu238aaAmj+NwOdARy25H1enL7k?=
 =?us-ascii?Q?T5K29pWCX+hUFPdgHKdmnCUdD2/+IW0oB7r+XD+i5nUutZPCLgBpCryVrGqt?=
 =?us-ascii?Q?uKQsDyxZ43qs65GZuXVmf86qqnCCAmNuNbMJOwHVSnT4OmL7AZT/CqzmMTOi?=
 =?us-ascii?Q?YZakTA1nnCgFNL+s4tSe7Ci+dV0Eq0wy3Z9T5Ih22YdxIUhGulUVaY1plW8r?=
 =?us-ascii?Q?zudZKuRh37iSvdhxqW6sxKMVRa/HrmReU55jpvpKLKlWz4XLOGzPE6TwbqYW?=
 =?us-ascii?Q?eCnIANiOV6m/UAWEl3S1oEBhcjciJVQwMFUQADTv54cawB1mxX4LKQqYkL5p?=
 =?us-ascii?Q?9bPLQ58Zjfb7Y+J6g9H6tg/+DV/C87pFtF2VCgOpx3C9asqBD5u3p+GXBHb2?=
 =?us-ascii?Q?VVo5F8hxsAKL8w5hmK2q6OQGkhYHRgsiEzNtPN9m2WkmREiZdo45KrEWRdsm?=
 =?us-ascii?Q?fy3eBgbU4g=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa1740c-477e-41e3-94a0-08de7d9bdeb2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 05:22:35.1396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKevs9YzLo+oFUJKk6qvD5qsMqB0MaozzvrEppCbMEkPECaJeKrtpHrzfgall+oFlFaNAg0T/E2TPBR5JbBeEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10765
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

Hi Philip,

Thanks for your patches!

On Fri, Mar 06, 2026 at 08:58:27AM +0000, Philip Molloy wrote:
>This series makes minor clean-up changes to the i.MX DDR init code.
>
>Unfortunately, I don't have access to any NXP hardware. I ran into LTO
>issues with my Fedora toolchain building imx8mm_evk_defconfig. And

Would you please share the error logs?

>binman issues because of missing binary blobs with some imx9*
>defconfigs. But compilation was successful.

Right, the ddr binaries are out of tree.

>
>To support an upcoming ADI SoC that also uses LPDDR4 and Synpsys IP I
>would like to leverage the i.MX implementation. Therefore this clean-up
>can also serve as a kind of pre-RFC. I would love to know if the
>maintainers are open to transitioning to a more generic implementation.

If most code could be reused by ADI SoC, that is good to have a generic
implementation to avoid code duplication.

>If so, I'll submit a proper RFC. I'll also be at Embedded World next
>week if anyone would like to discuss in person.
>
>Some additional context and a comparison of DDR init implementations:
>
>https://philipmolloy.com/ddr-init.html
>
>I reviewed the NXP i.MX downstream repo on Github.[1] The changes in
>this series are not fixed downstream. The only major difference with
>downtream for the PHY driver appears to be "Quickboot" support, which is

Yes, this is being prepared in internal reviewing stage before posting out,
should be soon.

>specific to the i.MX 95.

i.MX9[5,4,52] as of now.

Regards
Peng

>
>[1]: https://github.com/nxp-imx/uboot-imx
>
>Philip Molloy (4):
>  ddr: imx: Remove duplicate includes
>  ddr: imx: Remove undefined declarations
>  ddr: imx: Remove unused macros
>  ddr: imx: Remove unnecessary macro argument
>
> arch/arm/include/asm/arch-imx8m/ddr.h | 10 ++++------
> arch/arm/include/asm/arch-imx9/ddr.h  |  8 ++------
> drivers/ddr/imx/imx8m/ddr_init.c      |  8 ++++----
> drivers/ddr/imx/phy/ddrphy_utils.c    | 15 +++++++--------
> drivers/ddr/imx/phy/helper.c          |  4 +---
> 5 files changed, 18 insertions(+), 27 deletions(-)
>
>-- 
>2.53.0
>
>base-commit: 7995bf8dea2d5b3eb7fcb836636f4773924ec35d
>branch: ddr-imx-clean-up
>
