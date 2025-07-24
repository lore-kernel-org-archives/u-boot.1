Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5352BC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 02:19:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8824B83600;
	Thu, 24 Jul 2025 04:19:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GG8Th3cc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D9B58317B; Thu, 24 Jul 2025 04:19:02 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B858B8317B
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 04:18:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJGt0r6T2LgoZPaDxg4b2LTrIWDrxdpYg7u5Em/AZn30Wdre2Q/UGJPty74ipupVkodreQP69xrRTCbZoedob1IttbplXKzWT54LLf7ccN+Ec9a7ktvDiLzRzYL1q65VFTGukO7EzhFCEHSIABabFOBlqXLWlq2ULm7X7O7hIu+mQbnsB0JLygHGhjIrIRSHU83/YuIaPBoCvjawk4ADjt5r9bml90COdwMU7Nzb9q5GhAJ7TqEOHvFn20J41f74NVRxLEZWXKkiP9JMqixrtZuEzkA9zTQ1nGKPissl8iKLXYZmZF/BxjTt46K1XJJPDb2sSEnTDPeS4LK5+J/0Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkCOSqTaTz8SROxGQ+3fv35jD/YYAoLkuI2zcnKPov0=;
 b=KsDQqjvnTLfO6/dQCJ0zcOhNSWKSOGOCZVPmkq1XAay2lnpvijavOYFbmecSf6vt36bBxJpBf0VkbHH0Xgw6WS9kds8LnAHPW1iFZ3OIebjU8SNsHrqtm4ovPAUuRN9kZUQAneXW/F0b4fJB4Ouriamnr8sDQTDeX942VZpipyW9wOtACSy3P9DCicd1PNzbijqbYbFQJfLvsokMurE3dL1/l30NAzT1MDqWN0Qkt6pVyDq3qaErJLcgFpD5YiaNEbMnvHi73pZZao29zkngF5kmhWJlPo63bh43eMmj3vHwBWgQ6wDxZvVscb7OgHJbPOE7I4cJ1Aw0oxmbOJJ7vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkCOSqTaTz8SROxGQ+3fv35jD/YYAoLkuI2zcnKPov0=;
 b=GG8Th3cchReRfXLckqxffr1I5idhGGUOno2qZhBmRQfhnW0t+EGZXpTA/8WbTiuFH3P93IGqhaz/RmlFJy9DE/onH1UeS2VbgtxeudmxWn80KGGY+U2xnEzwMAPQHPc7z4+MtZt7JtLOG7X2rVJ1a97MJIG35MEooZL1LMrnNI9cxkVIYuLMuHROy0teCR+6jmBT4ZIonTmUTHTfoexY4kH0aad9180NLXh9dZY+C0yUeB+Kng+/zsUJxS951HJF5//WIAZCjQrvyZuOgE3VRtYEiB5RrnHI8PVpX1KGszesBliG/4oSAGs65LioIZ7TbgVh9Ps1MC3pzYatzils0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7986.eurprd04.prod.outlook.com (2603:10a6:20b:245::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 02:18:57 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 02:18:57 +0000
Date: Thu, 24 Jul 2025 11:29:31 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de
Subject: Re: [PATCH] imx93_frdm: Add initial board support
Message-ID: <20250724032931.GD18395@nxa18884-linux.ap.freescale.net>
References: <20250722203736.1792103-1-festevam@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722203736.1792103-1-festevam@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA0PR01CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM8PR04MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d434b4-9cbc-4c51-5f7f-08ddca587157
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XAzld4ik0xb9xOpigC6CjE8W4ZMpfhDbGws/BNnInDtNkAS5V/89Di+24Xo4?=
 =?us-ascii?Q?b6YDroVsIej5X2t1Ucc9rZ2IqhxuGGaoaTzfA9irBvRjRNxcAWQh7NhI0Ega?=
 =?us-ascii?Q?pq9jjol2CqomdEnTVbpRScCbPMJg9xEo2KCao+Dhp03E6PIIfwHLHE5Qc1rG?=
 =?us-ascii?Q?8n5zL9RCNYCk4UCz8yIKpbgXyUkDoFP57HERNKoYV2mX4S8ZpedaO4adzxEd?=
 =?us-ascii?Q?v5oWm8Jrmqu54RQtjyXqhvd3Qc/AmTYHS/XwE5AL1KO5Zws4JIOe6tWxUjhT?=
 =?us-ascii?Q?eDdkJCHlThDSI5Ivii3pKr/iq6Am3pr9tQgBFDQAdGPRMn99o3Mx2QADTgwR?=
 =?us-ascii?Q?10ZR6j0JTf+mmQkmfhtomiBGr5eFLeyfHmJ0H1qQ9KaWEeaX5JcL4a3O9OIt?=
 =?us-ascii?Q?nZBAjr5CIkgK+c7fr1NIwoHeUtsQkeNb5aIqHp8HNiEZbWQqwHDQ/I8A/CAv?=
 =?us-ascii?Q?jvcOdZxY+Gss3ZibefeUSN605TFQf0cERx0Fjh84X/ArBgY4aUhRg0fDuxYG?=
 =?us-ascii?Q?JdgvMpUs1vS12PfLuak4TO9X09L2u3HXwYa/xdr9dhg+3AUYjX8819AefPYZ?=
 =?us-ascii?Q?EtkJKdSz7cT6DqKx3SLwyO0HRbFs94gvEQGDP7DDZdqdEGnICjyxNK0h5QEc?=
 =?us-ascii?Q?J9yF/JrRwMfqHT3YFtGciBFZFeHXXshpiaC6B1hP+Ebgf3n8VxERnw4RGDZY?=
 =?us-ascii?Q?pRoMYiURLxkWhYbv3VGTTa0VDpVDMMhKpWKeJVxLNQzFnfdbE2WaayjOjGfe?=
 =?us-ascii?Q?0DGtbWs/0UGNp3TwVk6qJ+z7yAdL4as0WBlEzcYhWdeSEnu6S0sEqxeqJ1KY?=
 =?us-ascii?Q?TchASaiY1Ak192URuq5EwS1hV35ZLa4NRgsxvteecZYnrVxG+74QCj68+LKl?=
 =?us-ascii?Q?MHttJgbVJGmjjOggfUYKw7/krMPit05APJRUv+IO600T7990E/txNCsv/XTj?=
 =?us-ascii?Q?JV8Ewc+bYImjv+L3EaHqDCoYBEYDGye3Sn/kHAngOKezGXkR4YPuiNcA0pW7?=
 =?us-ascii?Q?StllC8Fctz9FjBqgmIkenZbRPSrp8ESohzv7WuEneEiOITITihNgEjes9yA9?=
 =?us-ascii?Q?9CYJ6eB+zFW1mw/NL7tCFY+wE/m666rFUGpDSgKmgDIbH2PgjvTgKYgwMB7z?=
 =?us-ascii?Q?diwgEPHwT79fQz5Flpa4LuoyX0aBLvTgbpYNCZvC8TVtkThXyqOjcKkysJ4p?=
 =?us-ascii?Q?o44kGAKIhBMu6/Y7Q90rMsu91PdWsX+dpajcucmtchK7h5dxLyBSKTrJl9+O?=
 =?us-ascii?Q?0qdwZqjv1YD4v5A9c3HdJ7fo/bA/Ntc5fI2nIOsMScesJ7rhy9ekT8Ax9hPT?=
 =?us-ascii?Q?7xQqbMoviWeuFruoP45hfLDfQ7+6wNXeAFkWQcYeGrwLpZCZ9cegyYA7Re4P?=
 =?us-ascii?Q?VuRrIAIr3VDK09dbxTEk7qbTVeg1zptc2F9RPsnXTTMfFDhnTrKJ7FMtR6Pa?=
 =?us-ascii?Q?alc80Jy9/xqQJK1U4ylV+51VeIUmJ5fSPhGDQ+7j24/rlmthypgeOaVmPLE8?=
 =?us-ascii?Q?KbpU1SoEmN1cn5w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(19092799006)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xSVF2KdJqsr7eHCtrIXzynWnfMz9RDtydfAPup+GhCzISsAhpCjyZkzN56NY?=
 =?us-ascii?Q?CEmP+T7DLhjybLUbVf8m33J74Rx6eWT2MpyYk5Ndacxamk5awqjSXfhT1LHk?=
 =?us-ascii?Q?VhWc054psa58RNl9GthsuciffYrjFTKzFSLaH2EvdaUjO48TS8WozCDfaBXx?=
 =?us-ascii?Q?+K+elfKPrX71TXdRds78Zd3/spaRK/gVRkVnsHWBANRVP87T7SN3mhRkHX9+?=
 =?us-ascii?Q?M6pDm3ofCdFWU4+SzjKMkGR7QPOZyNtyWPyo8Y6nXw+9AK6HyYbIlLS+IbDZ?=
 =?us-ascii?Q?U9Pfdq9ZA+7V6xTjzDxH6D9c5Cw/nQBPKnvUyO5RF9N+tGJlUzqV2hPkPwev?=
 =?us-ascii?Q?woolg/PGpDG2Rtq8sjGjYBiIGQOnQN4kvuq294aR1AyijGWrVlZ7Xqfv3Xkb?=
 =?us-ascii?Q?fU/FvllcRTTR7yiFyuI3uVRo0mgoiIofw6UfIrd0UsUC7ousi25WirJ42KjX?=
 =?us-ascii?Q?FwMXPS7EhCsd/iXFNXQ0ipusXEllDDo/i+56cWOaylOSiAKQ3k0a5YG8APuk?=
 =?us-ascii?Q?i51ciKbROuQU3t9AGlXW7o+Bu/ocBIDhgKCFlXeZn0jq1rRwWT0Xufb7IuMI?=
 =?us-ascii?Q?Y5Mp5K8tsaSDZn4pgPZC/yzlRNAAuG8H/O4b6FYU0HlEftCKS2RtqnatvWjP?=
 =?us-ascii?Q?TuMuXGEGX8VoiL1rWXpY3G5EAQvQDbR1XoK207StWEtTXsl0zskhJIgR8KFW?=
 =?us-ascii?Q?c0wPkVLZ8ao2zID6MI0BvBeprjhu1qJSO8/lZvkqX4oMElQH31/eWXTt+CpI?=
 =?us-ascii?Q?oNVDGqCHOU65Q6Bqf3fD2w9exb9M57wZ0Exg2GObWFDLSXciE/laL+jKeZic?=
 =?us-ascii?Q?wDJTvuCRbd4BdKTgvKT4VF5d+GkLd4f/O1Xnbb6LmXoP0T57AS2BuaNs7G+h?=
 =?us-ascii?Q?F5lr2xEsX0qNofBIzlhyfETqnFFDj23QPUW6r19w64rgjq2ydJgTZ4dm29qC?=
 =?us-ascii?Q?hFfDoYXNLQS/dhj2e53oxXAr0Iy+NCeT0aJvdflDj9SrvI4D92AJGQ5RGsIQ?=
 =?us-ascii?Q?6LcBu9kw67IlNehnozYRd7VqUR3FYKJLHNuDyHkE0ughXBMpJz2ZuaX2F6Dz?=
 =?us-ascii?Q?9N5tw29/bamIXKh07sReXjYylZfpZrJ/cpsRExLkiSaVSnPDpWvDQbPQCEpj?=
 =?us-ascii?Q?1MXamYIeIoEmHmiT6rJp9OUxkFqqyxup90GybZmXY7vV1jeNDws+YOTxpPYw?=
 =?us-ascii?Q?ypw0/iTYDY4sbCR7SgweEAT0FKOWLYQdxdYitfzzGj+bwassJj35BV4BQEG0?=
 =?us-ascii?Q?vcG4Yc4ysdHrN5d4PZ1xO4dOnWeokJ5mZOnyxO/Je8ST0xJjeXj7TlhIiOYr?=
 =?us-ascii?Q?syVHLF1Wk/TIW7RV858sdjUeGFhihbWIz2s9nV5Vxw7b5I3aBjdc34J0wPE9?=
 =?us-ascii?Q?jfO/IZYrJzyBBrlWYjatTbJOm79lWstA2FP0LQe8aNzae3GMHNQLzXiYsotO?=
 =?us-ascii?Q?/ynHclQtNOxTiQZ0AvimfVmQrruwrwVBHNLYFFFB//QrWxSLW1Hi5mgzTDng?=
 =?us-ascii?Q?h6Szt/N5o+HGQcR8niAlUpAzKNDgU2sA1Y/Jm8tfc12eydFW2LVS3btvS9r3?=
 =?us-ascii?Q?7Kj1n3zARNUd1yQ/kaJEqFMOBqkjEGj0frkK3ags?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d434b4-9cbc-4c51-5f7f-08ddca587157
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 02:18:56.9506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AXg3+9wwD3i1tw3YAdPJKR4vBEFEh9r0B2cJ9MSJpxP/R0DugTaJ3HNppt73UEVb+SoCi3nYrjRO0AZtEaSgfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7986
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

Hi Fabio,

Thanks for working on i.MX93 FRDM upstream.

On Tue, Jul 22, 2025 at 05:37:36PM -0300, Fabio Estevam wrote:
>Add the initial board support for the NXP i.MX93 FRDM board:
>
>https://www.nxp.com/design/design-center/development-boards-and-designs/frdm-i-mx-93-development-board:FRDM-IMX93
>
>Based on the NXP U-Boot code.
>
>There were attempts to upstream the board devicetree, but it has not been
>accepted upstream yet:
>
>https://lore.kernel.org/linux-arm-kernel/20250526-fpg-nxp-imx93-frdm-v2-2-e5ad0efaec33@pengutronix.de/
>
>Once it reaches upstream, we can switch to OF_UPSTREAM.
>
>Signed-off-by: Fabio Estevam <festevam@gmail.com>
>---
> arch/arm/dts/Makefile                         |    1 +
> arch/arm/dts/imx93-11x11-frdm-u-boot.dtsi     |  212 ++
> arch/arm/dts/imx93-11x11-frdm.dts             |  603 +++++
> arch/arm/include/asm/arch-imx9/ddr.h          |    1 +
> arch/arm/mach-imx/imx9/Kconfig                |    9 +
> board/freescale/imx93_frdm/Kconfig            |   12 +
> board/freescale/imx93_frdm/MAINTAINERS        |    6 +
> board/freescale/imx93_frdm/Makefile           |   11 +
> board/freescale/imx93_frdm/imx93_frdm.c       |   59 +
> board/freescale/imx93_frdm/imx93_frdm.env     |   31 +
> board/freescale/imx93_frdm/lpddr4_timing.h    |   13 +
> .../freescale/imx93_frdm/lpddr4x_1gb_timing.c | 1996 +++++++++++++++++
> .../freescale/imx93_frdm/lpddr4x_2gb_timing.c | 1995 ++++++++++++++++
> board/freescale/imx93_frdm/spl.c              |  207 ++
> configs/imx93_frdm_defconfig                  |  124 +
> doc/board/nxp/imx93_frdm.rst                  |   75 +
> doc/board/nxp/index.rst                       |    1 +
> include/configs/imx93_frdm.h                  |   32 +
> 18 files changed, 5388 insertions(+)
> create mode 100644 arch/arm/dts/imx93-11x11-frdm-u-boot.dtsi
> create mode 100644 arch/arm/dts/imx93-11x11-frdm.dts
> create mode 100644 board/freescale/imx93_frdm/Kconfig
> create mode 100644 board/freescale/imx93_frdm/MAINTAINERS
> create mode 100644 board/freescale/imx93_frdm/Makefile
> create mode 100644 board/freescale/imx93_frdm/imx93_frdm.c
> create mode 100644 board/freescale/imx93_frdm/imx93_frdm.env
> create mode 100644 board/freescale/imx93_frdm/lpddr4_timing.h
> create mode 100644 board/freescale/imx93_frdm/lpddr4x_1gb_timing.c
> create mode 100644 board/freescale/imx93_frdm/lpddr4x_2gb_timing.c
> create mode 100644 board/freescale/imx93_frdm/spl.c
> create mode 100644 configs/imx93_frdm_defconfig
> create mode 100644 doc/board/nxp/imx93_frdm.rst
> create mode 100644 include/configs/imx93_frdm.h
>
>diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
>index 17795f8f746d..09e3edc4f8b1 100644
>--- a/arch/arm/dts/Makefile
>+++ b/arch/arm/dts/Makefile
>@@ -918,6 +918,7 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
> 	imx8mq-librem5-r4.dtb
> 
> dtb-$(CONFIG_ARCH_IMX9) += \
>+	imx93-11x11-frdm.dtb \
> 	imx93-var-som-symphony.dtb
> 
> dtb-$(CONFIG_ARCH_IMXRT) += imxrt1020-evk.dtb \
>diff --git a/arch/arm/dts/imx93-11x11-frdm-u-boot.dtsi b/arch/arm/dts/imx93-11x11-frdm-u-boot.dtsi
>new file mode 100644
>index 000000000000..558a43470e81
>--- /dev/null
>+++ b/arch/arm/dts/imx93-11x11-frdm-u-boot.dtsi
>@@ -0,0 +1,212 @@
>+// SPDX-License-Identifier: GPL-2.0+
>+/*
>+ * Copyright 2024 NXP

2025.

>+ */
>+
>+#include "imx93-u-boot.dtsi"
>+
>+/ {
>+	wdt-reboot {
>+		compatible = "wdt-reboot";
>+		wdt = <&wdog3>;
>+		bootph-pre-ram;
>+		bootph-some-ram;
>+	};
>+
>+	aliases {
>+		usbgadget0 = &usbg1;
>+		usbgadget1 = &usbg2;
>+	};
>+
>+	usbg1: usbg1 {
>+		compatible = "fsl,imx27-usb-gadget";
>+		dr_mode = "peripheral";
>+		chipidea,usb = <&usbotg1>;
>+		status = "okay";
>+	};
>+
>+	usbg2: usbg2 {
>+		compatible = "fsl,imx27-usb-gadget";
>+		dr_mode = "peripheral";
>+		chipidea,usb = <&usbotg2>;
>+		status = "okay";
>+	};

This fsl,imx27-usb-gadget is only in NXP downstream, needs drop here.

>diff --git a/arch/arm/include/asm/arch-imx9/ddr.h b/arch/arm/include/asm/arch-imx9/ddr.h
>index 0dd2d62b9ef1..a8e3f7354c7b 100644
>--- a/arch/arm/include/asm/arch-imx9/ddr.h
>+++ b/arch/arm/include/asm/arch-imx9/ddr.h
>@@ -118,6 +118,7 @@ void ddrphy_init_set_dfi_clk(unsigned int drate);
> void ddrphy_init_read_msg_block(enum fw_type type);
> 
> void get_trained_CDD(unsigned int fsp);
>+u32 lpddr4_mr_read(u32 mr_rank, u32 mr_addr);
> 
> ulong ddrphy_addr_remap(u32 paddr_apb_from_ctlr);
> 
>diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
>index 95bd18235319..4e0e194690b6 100644
>--- a/arch/arm/mach-imx/imx9/Kconfig
>+++ b/arch/arm/mach-imx/imx9/Kconfig
>@@ -66,6 +66,14 @@ config TARGET_IMX93_11X11_EVK
> 	imply BOOTSTD_FULL
> 	imply BOOTSTD_BOOTCOMMAND
> 
>+config TARGET_IMX93_FRDM
>+	bool "imx93_frdm"
>+	select OF_BOARD_FIXUP
>+	select IMX93
>+	select IMX9_LPDDR4X
>+	imply BOOTSTD_FULL
>+	imply BOOTSTD_BOOTCOMMAND
>+
> config TARGET_IMX93_VAR_SOM
> 	bool "imx93_var_som"
> 	select IMX93
>@@ -90,6 +98,7 @@ endchoice
> 
> source "board/freescale/imx91_evk/Kconfig"
> source "board/freescale/imx93_evk/Kconfig"
>+source "board/freescale/imx93_frdm/Kconfig"
> source "board/freescale/imx93_qsb/Kconfig"
> source "board/phytec/phycore_imx93/Kconfig"
> source "board/variscite/imx93_var_som/Kconfig"
>diff --git a/board/freescale/imx93_frdm/Kconfig b/board/freescale/imx93_frdm/Kconfig
>new file mode 100644
>index 000000000000..5f5ac7f8f048
>--- /dev/null
>+++ b/board/freescale/imx93_frdm/Kconfig
>@@ -0,0 +1,12 @@
>+if TARGET_IMX93_FRDM
>+
>+config SYS_BOARD
>+	default "imx93_frdm"
>+
>+config SYS_VENDOR
>+	default "freescale"
>+
>+config SYS_CONFIG_NAME
>+	default "imx93_frdm"
>+
>+endif
>diff --git a/board/freescale/imx93_frdm/MAINTAINERS b/board/freescale/imx93_frdm/MAINTAINERS
>new file mode 100644
>index 000000000000..59595bb21185
>--- /dev/null
>+++ b/board/freescale/imx93_frdm/MAINTAINERS
>@@ -0,0 +1,6 @@
>+i.MX93 FRDM BOARD
>+M:	Fabio Estevam <festevam@gmail.com>
>+S:	Maintained
>+F:	board/freescale/imx93_frdm/
>+F:	include/configs/imx93_frdm.h
>+F:	configs/imx93_frdm_defconfig
>diff --git a/board/freescale/imx93_frdm/Makefile b/board/freescale/imx93_frdm/Makefile
>new file mode 100644
>index 000000000000..b6fb121984ca
>--- /dev/null
>+++ b/board/freescale/imx93_frdm/Makefile
>@@ -0,0 +1,11 @@
>+#
>+# Copyright 2022 NXP

2025.

>+#
>+# SPDX-License-Identifier:      GPL-2.0+
>+#
>+
>+obj-y += imx93_frdm.o
>+
>+ifdef CONFIG_XPL_BUILD
>+obj-y += spl.o lpddr4x_1gb_timing.o lpddr4x_2gb_timing.o
>+endif
>diff --git a/board/freescale/imx93_frdm/imx93_frdm.c b/board/freescale/imx93_frdm/imx93_frdm.c
>new file mode 100644
>index 000000000000..097bc3d91376
>--- /dev/null
>+++ b/board/freescale/imx93_frdm/imx93_frdm.c
>@@ -0,0 +1,59 @@
>+// SPDX-License-Identifier: GPL-2.0+
>+/*
>+ * Copyright 2022 NXP

2025.

>+ */
>+
>+#include <env.h>
>+#include <efi_loader.h>
>+#include <init.h>
>+#include <asm/global_data.h>
>+#include <asm/arch/sys_proto.h>
>+#include <asm/arch-imx9/imx93_pins.h>
>+#include <asm/arch/clock.h>
>+#include <dm/device.h>
>+#include <dm/uclass.h>
>+
>+DECLARE_GLOBAL_DATA_PTR;
>+
>+#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
>+#define IMX_BOOT_IMAGE_GUID \
>+	EFI_GUID(0xbc550d86, 0xda26, 0x4b70, 0xac, 0x05, \
>+		 0x2a, 0x44, 0x8e, 0xda, 0x6f, 0x21)
>+
>+struct efi_fw_image fw_images[] = {
>+	{
>+		.image_type_id = IMX_BOOT_IMAGE_GUID,
>+		.fw_name = u"IMX93-11X11-FRDM-RAW",
>+		.image_index = 1,
>+	},
>+};
>+
>+struct efi_capsule_update_info update_info = {
>+	.dfu_string = "mmc 0=flash-bin raw 0 0x2000 mmcpart 1",
>+	.num_images = ARRAY_SIZE(fw_images),
>+	.images = fw_images,
>+};
>+#endif /* EFI_HAVE_CAPSULE_SUPPORT */
>+
>+int board_early_init_f(void)
>+{
>+	return 0;
>+}
>+
>+int board_init(void)
>+{
>+	return 0;
>+}
>+
>+int board_late_init(void)
>+{
>+	if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC) || IS_ENABLED(CONFIG_ENV_IS_IN_NOWHERE))
>+		board_late_mmc_env_init();
>+
>+	if (IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG)) {
>+		env_set("board_name", "11X11_FRDM");
>+		env_set("board_rev", "iMX93");
>+	}
>+
>+	return 0;
>+}
>diff --git a/board/freescale/imx93_frdm/imx93_frdm.env b/board/freescale/imx93_frdm/imx93_frdm.env
>new file mode 100644
>index 000000000000..528a953c8df1
>--- /dev/null
>+++ b/board/freescale/imx93_frdm/imx93_frdm.env
>@@ -0,0 +1,31 @@
>+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>+
>+boot_targets=mmc0 mmc1
>+boot_fit=no
>+bootm_size=0x10000000
>+cntr_addr=0x98000000
>+cntr_file=os_cntr_signed.bin
>+console=ttyLP0,115200
>+fdt_addr_r=0x83000000
>+fdt_addr=0x83000000
>+fdtfile=CONFIG_DEFAULT_FDT_FILE
>+image=Image
>+mmcdev=1
>+mmcpart=1
>+mmcroot=/dev/mmcblk${mmcdev}p2 rootwait rw
>+mmcautodetect=yes
>+mmcargs=setenv bootargs console=${console} root=${mmcroot}
>+kernel_addr_r=CONFIG_SYS_LOAD_ADDR
>+loadimage=load mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
>+loadfdt=load mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
>+boot_os=booti ${loadaddr} - ${fdt_addr_r}
>+
>+bsp_bootcmd=
>+	echo Running BSP bootcmd ...;
>+	mmc dev ${mmcdev};
>+	run mmcargs;
>+	run loadimage;
>+	run loadfdt;
>+	run boot_os;
>+
>+scriptaddr=0x83500000
>diff --git a/board/freescale/imx93_frdm/lpddr4_timing.h b/board/freescale/imx93_frdm/lpddr4_timing.h
>new file mode 100644
>index 000000000000..f185efd63bcb
>--- /dev/null
>+++ b/board/freescale/imx93_frdm/lpddr4_timing.h
>@@ -0,0 +1,13 @@
>+/* SPDX-License-Identifier: GPL-2.0+ */
>+/*
>+ * Copyright 2022 Marek Vasut <marex@denx.de>

Wrong Copyright.

>+ */
>+
>+#ifndef __LPDDR4_TIMING_H__
>+#define __LPDDR4_TIMING_H__
>+
>+extern struct dram_timing_info dram_timing_1GB;
>+extern struct dram_timing_info dram_timing_2GB;
>+extern struct dram_timing_info dram_timing_1866mts;
>+
>+#endif /* __LPDDR4_TIMING_H__ */
>diff --git a/board/freescale/imx93_frdm/lpddr4x_1gb_timing.c b/board/freescale/imx93_frdm/lpddr4x_1gb_timing.c
>new file mode 100644
>index 000000000000..0394a3d3c772
>--- /dev/null
>+++ b/board/freescale/imx93_frdm/lpddr4x_1gb_timing.c
>@@ -0,0 +1,1996 @@
>+// SPDX-License-Identifier: BSD-3-Clause
>+/*
>+ * Copyright 2024 NXP

2025

>+ *
>+ * Code generated with DDR Tool v3.3.0_7.8-d1cdb7d3.
>+ * DDR PHY FW2022.01
>+ */
>+
>+};
>diff --git a/board/freescale/imx93_frdm/lpddr4x_2gb_timing.c b/board/freescale/imx93_frdm/lpddr4x_2gb_timing.c
>new file mode 100644
>index 000000000000..630515a78f7b
>--- /dev/null
>+++ b/board/freescale/imx93_frdm/lpddr4x_2gb_timing.c
>@@ -0,0 +1,1995 @@
>+// SPDX-License-Identifier: BSD-3-Clause
>+/*
>+ * Copyright 2024 NXP

2025

>+ *
>+};
>diff --git a/board/freescale/imx93_frdm/spl.c b/board/freescale/imx93_frdm/spl.c
>new file mode 100644
>index 000000000000..8de70d2053a1
>--- /dev/null
>+++ b/board/freescale/imx93_frdm/spl.c
>@@ -0,0 +1,207 @@
>+// SPDX-License-Identifier: GPL-2.0+
>+/*
>+ * Copyright 2022 NXP

2025

>+ */
>+
>+#include <command.h>
>+#include <cpu_func.h>
>+#include <hang.h>
>+#include <image.h>
>+#include <init.h>
>+#include <log.h>
>+#include <spl.h>
>+#include <asm/global_data.h>
>+#include <asm/io.h>
>+#include <asm/arch/imx93_pins.h>
>+#include <asm/arch/mu.h>
>+#include <asm/arch/clock.h>
>+#include <asm/arch/sys_proto.h>
>+#include <asm/mach-imx/boot_mode.h>
>+#include <asm/mach-imx/mxc_i2c.h>
>+#include <asm/arch-mx7ulp/gpio.h>
>+#include <asm/mach-imx/ele_api.h>
>+#include <asm/mach-imx/syscounter.h>
>+#include <asm/sections.h>
>+#include <dm/uclass.h>
>+#include <dm/device.h>
>+#include <dm/uclass-internal.h>
>+#include <dm/device-internal.h>
>+#include <linux/delay.h>
>+#include <asm/arch/clock.h>
>+#include <asm/arch/ccm_regs.h>
>+#include <asm/arch/ddr.h>
>+#include <power/pmic.h>
>+#include <power/pca9450.h>
>+#include <asm/arch/trdc.h>

This header lists needs cleanup and keep in order.

>+
>+#include "lpddr4_timing.h"
>+
>+DECLARE_GLOBAL_DATA_PTR;
>+
>+#define SRC_DDRC_SW_CTRL		(0x44461020)
>+#define SRC_DDRPHY_SINGLE_RESET_SW_CTRL	(0x44461424)
>+
>+static struct _drams {
>+	u8 mr8;
>+	struct dram_timing_info *pdram_timing;
>+	char *name;
>+} frdm_drams[2] = {
>+	{0x10, &dram_timing_1GB, "1GB DRAM" },
>+	{0x18, &dram_timing_2GB, "2GB DRAM" },
>+};
>+
>+int spl_board_boot_device(enum boot_device boot_dev_spl)
>+{
>+	return BOOT_DEVICE_BOOTROM;
>+}
>+
>+void spl_board_init(void)
>+{
>+	int ret;
>+
>+	ret = ele_start_rng();
>+	if (ret)
>+		printf("Fail to start RNG: %d\n", ret);
>+
>+	puts("Normal Boot\n");
>+}
>+
>+void spl_dram_init(void)
>+{
>+	int i;
>+	int ret;
>+
>+	for (i = 0; i < ARRAY_SIZE(frdm_drams); i++) {
>+		struct dram_timing_info *ptiming = frdm_drams[i].pdram_timing;
>+
>+		printf("DDR: %uMTS\n", ptiming->fsp_msg[0].drate);
>+		ret = ddr_init(ptiming);
>+		if (ret == 0) {
>+			if (lpddr4_mr_read(1, 8) == frdm_drams[i].mr8) {
>+				printf("found DRAM %s matched\n", frdm_drams[i].name);
>+				break;
>+			}
>+
>+			/* Power down and Power up DDR Mixer */
>+
>+			/* Clear PwrOkIn via DDRMIX register */
>+			setbits_32(SRC_DDRPHY_SINGLE_RESET_SW_CTRL, BIT(0));
>+			/* Power off the DDRMIX */
>+			setbits_32(SRC_DDRC_SW_CTRL, BIT(31));
>+
>+			udelay(50);
>+
>+			/* Power up the DDRMIX */
>+			clrbits_32(SRC_DDRC_SW_CTRL, BIT(31));
>+			setbits_32(SRC_DDRC_SW_CTRL, BIT(0));
>+			udelay(10);
>+			clrbits_32(SRC_DDRC_SW_CTRL, BIT(0));
>+			udelay(10);
>+		}
>+	}
>+}
>+
>+int power_init_board(void)
>+{
>+	struct udevice *dev;
>+	int ret;
>+	unsigned int val = 0, buck_val;
>+
>+	ret = pmic_get("pmic@25", &dev);
>+	if (ret == -ENODEV) {
>+		puts("No pca9450@25\n");
>+		return 0;
>+	}
>+	if (ret != 0)
>+		return ret;
>+
>+	/* BUCKxOUT_DVS0/1 control BUCK123 output */
>+	pmic_reg_write(dev, PCA9450_BUCK123_DVS, 0x29);
>+
>+	/* enable DVS control through PMIC_STBY_REQ */
>+	pmic_reg_write(dev, PCA9450_BUCK1CTRL, 0x59);
>+
>+	ret = pmic_reg_read(dev, PCA9450_PWR_CTRL);
>+	if (ret < 0)
>+		return ret;
>+
>+	val = ret;
>+
>+	if (is_voltage_mode(VOLT_LOW_DRIVE)) {
>+		buck_val = 0x0c; /* 0.8v for Low drive mode */
>+		printf("PMIC: Low Drive Voltage Mode\n");
>+	} else if (is_voltage_mode(VOLT_NOMINAL_DRIVE)) {
>+		buck_val = 0x10; /* 0.85v for Nominal drive mode */
>+		printf("PMIC: Nominal Voltage Mode\n");
>+	} else {
>+		buck_val = 0x14; /* 0.9v for Over drive mode */
>+		printf("PMIC: Over Drive Voltage Mode\n");
>+	}
>+
>+	if (val & PCA9450_REG_PWRCTRL_TOFF_DEB) {
>+		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, buck_val);
>+		pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, buck_val);
>+	} else {
>+		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, buck_val + 0x4);
>+		pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, buck_val + 0x4);
>+	}
>+
>+	/* set standby voltage to 0.65v */
>+	if (val & PCA9450_REG_PWRCTRL_TOFF_DEB)
>+		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS1, 0x0);
>+	else
>+		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS1, 0x4);
>+
>+	/* I2C_LT_EN*/
>+	pmic_reg_write(dev, 0xa, 0x3);
>+	return 0;
>+}
>+
>+void board_init_f(ulong dummy)
>+{
>+	int ret;
>+
>+	/* Clear the BSS. */
>+	memset(__bss_start, 0, __bss_end - __bss_start);
>+
>+	timer_init();
>+
>+	arch_cpu_init();
>+
>+	board_early_init_f();
>+
>+	spl_early_init();
>+
>+	preloader_console_init();
>+
>+	ret = imx9_probe_mu();
>+	if (ret) {
>+		printf("Fail to init Sentinel API\n");
>+	} else {
>+		debug("SOC: 0x%x\n", gd->arch.soc_rev);
>+		debug("LC: 0x%x\n", gd->arch.lifecycle);
>+	}
>+
>+	clock_init_late();
>+
>+	power_init_board();
>+
>+	if (!is_voltage_mode(VOLT_LOW_DRIVE))
>+		set_arm_clk(get_cpu_speed_grade_hz());
>+
>+	/* Init power of mix */
>+	soc_power_init();
>+
>+	/* Setup TRDC for DDR access */
>+	trdc_init();
>+
>+	/* DDR initialization */
>+	spl_dram_init();
>+
>+	/* Put M33 into CPUWAIT for following kick */
>+	ret = m33_prepare();
>+	if (!ret)
>+		printf("M33 prepare ok\n");
>+
>+	board_init_r(NULL, 0);
>+}
>diff --git a/configs/imx93_frdm_defconfig b/configs/imx93_frdm_defconfig
>new file mode 100644
>index 000000000000..4f837ca92828
>--- /dev/null
>+++ b/configs/imx93_frdm_defconfig
>@@ -0,0 +1,124 @@
>+CONFIG_ARM=y
>+CONFIG_ARCH_IMX9=y
>+CONFIG_TEXT_BASE=0x80200000
>+CONFIG_SYS_MALLOC_LEN=0x2000000
>+CONFIG_SYS_MALLOC_F_LEN=0x18000
>+CONFIG_SPL_LIBCOMMON_SUPPORT=y
>+CONFIG_SPL_LIBGENERIC_SUPPORT=y
>+CONFIG_NR_DRAM_BANKS=2
>+CONFIG_ENV_SIZE=0x4000
>+CONFIG_ENV_OFFSET=0x700000
>+CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
>+CONFIG_DM_GPIO=y
>+CONFIG_DEFAULT_DEVICE_TREE="imx93-11x11-frdm"
>+CONFIG_TARGET_IMX93_FRDM=y
>+CONFIG_SYS_MONITOR_LEN=524288
>+CONFIG_SPL_SERIAL=y
>+CONFIG_SPL_DRIVERS_MISC=y
>+CONFIG_SPL_STACK=0x20519dd0
>+CONFIG_SPL_TEXT_BASE=0x2049A000
>+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>+CONFIG_SPL_BSS_START_ADDR=0x2051a000
>+CONFIG_SPL_BSS_MAX_SIZE=0x2000
>+CONFIG_SYS_LOAD_ADDR=0x80400000
>+CONFIG_SPL=y
>+CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
>+CONFIG_SYS_MEMTEST_START=0x80000000
>+CONFIG_SYS_MEMTEST_END=0x90000000
>+CONFIG_REMAKE_ELF=y
>+CONFIG_EFI_VAR_BUF_SIZE=139264
>+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
>+CONFIG_EFI_CAPSULE_ON_DISK=y
>+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
>+CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
>+CONFIG_DEFAULT_FDT_FILE="imx93-11x11-frdm.dtb"
>+CONFIG_SYS_CBSIZE=2048
>+CONFIG_SYS_PBSIZE=2074
>+CONFIG_BOARD_EARLY_INIT_F=y
>+CONFIG_BOARD_LATE_INIT=y
>+CONFIG_SPL_MAX_SIZE=0x26000
>+CONFIG_SPL_BOARD_INIT=y
>+CONFIG_SPL_BOOTROM_SUPPORT=y
>+CONFIG_SPL_LOAD_IMX_CONTAINER=y
>+CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/container.cfg"
>+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>+CONFIG_SPL_HAVE_INIT_STACK=y
>+CONFIG_SPL_SYS_MALLOC=y
>+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
>+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x83200000
>+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
>+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
>+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
>+CONFIG_SPL_I2C=y
>+CONFIG_SPL_POWER=y
>+CONFIG_SPL_WATCHDOG=y
>+CONFIG_SYS_PROMPT="u-boot=> "
>+CONFIG_CMD_CPU=y
>+CONFIG_CMD_ERASEENV=y
>+CONFIG_CMD_NVEDIT_EFI=y
>+# CONFIG_CMD_CRC32 is not set
>+CONFIG_CMD_MEMTEST=y
>+CONFIG_CMD_CLK=y
>+CONFIG_CMD_DFU=y
>+CONFIG_CMD_FUSE=y
>+CONFIG_CMD_GPIO=y
>+CONFIG_CMD_GPT=y
>+CONFIG_CMD_I2C=y
>+CONFIG_CMD_MMC=y
>+CONFIG_CMD_POWEROFF=y
>+CONFIG_CMD_SNTP=y
>+CONFIG_CMD_CACHE=y
>+CONFIG_CMD_EFIDEBUG=y
>+CONFIG_CMD_TIME=y
>+CONFIG_CMD_GETTIME=y
>+CONFIG_CMD_TIMER=y
>+CONFIG_CMD_REGULATOR=y
>+CONFIG_CMD_HASH=y
>+CONFIG_CMD_EXT4_WRITE=y
>+CONFIG_CMD_SPAWN=y
>+CONFIG_OF_CONTROL=y
>+CONFIG_SPL_OF_CONTROL=y
>+CONFIG_ENV_OVERWRITE=y
>+CONFIG_ENV_IS_NOWHERE=y
>+CONFIG_ENV_IS_IN_MMC=y
>+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
>+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
>+CONFIG_SPL_DM=y
>+CONFIG_REGMAP=y
>+CONFIG_SYSCON=y
>+CONFIG_ADC=y
>+CONFIG_ADC_IMX93=y
>+CONFIG_SPL_CLK_IMX93=y
>+CONFIG_CLK_IMX93=y
>+CONFIG_DFU_MMC=y
>+CONFIG_IMX_RGPIO2P=y
>+CONFIG_DM_PCA953X=y
>+CONFIG_DM_I2C=y
>+CONFIG_SYS_I2C_IMX_LPI2C=y
>+CONFIG_SUPPORT_EMMC_RPMB=y
>+CONFIG_SUPPORT_EMMC_BOOT=y
>+CONFIG_MMC_IO_VOLTAGE=y
>+CONFIG_MMC_UHS_SUPPORT=y
>+CONFIG_MMC_HS400_ES_SUPPORT=y
>+CONFIG_MMC_HS400_SUPPORT=y
>+CONFIG_FSL_USDHC=y
>+CONFIG_PINCTRL=y
>+CONFIG_SPL_PINCTRL=y
>+CONFIG_PINCTRL_IMX93=y
>+CONFIG_DM_PMIC=y
>+CONFIG_SPL_DM_PMIC_PCA9450=y
>+CONFIG_DM_REGULATOR=y
>+CONFIG_DM_REGULATOR_FIXED=y
>+CONFIG_DM_REGULATOR_GPIO=y
>+CONFIG_DM_SERIAL=y
>+CONFIG_FSL_LPUART=y
>+CONFIG_SYSRESET=y
>+CONFIG_SYSRESET_CMD_POWEROFF=y
>+CONFIG_SYSRESET_PSCI=y
>+CONFIG_DM_THERMAL=y
>+CONFIG_ULP_WATCHDOG=y
>+CONFIG_WDT=y
>+CONFIG_SHA384=y
>+CONFIG_LZO=y
>+CONFIG_BZIP2=y
>+CONFIG_UTHREAD=y
>diff --git a/doc/board/nxp/imx93_frdm.rst b/doc/board/nxp/imx93_frdm.rst
>new file mode 100644
>index 000000000000..a1f526fd4cca
>--- /dev/null
>+++ b/doc/board/nxp/imx93_frdm.rst
>@@ -0,0 +1,75 @@
>+.. SPDX-License-Identifier: GPL-2.0+
>+
>+imx93_frdm
>+==========
>+
>+U-Boot for the NXP i.MX93 FRDM board
>+
>+Quick Start
>+-----------
>+
>+- Get and Build the ARM Trusted firmware
>+- Get the DDR firmware
>+- Get ahab-container.img
>+- Build U-Boot
>+- Boot from the SD card
>+
>+Get and Build the ARM Trusted firmware
>+--------------------------------------
>+
>+Note: srctree is U-Boot source directory
>+Get ATF from: https://github.com/nxp-imx/imx-atf/
>+branch: lf_v2.8
>+
>+.. code-block:: bash
>+
>+   $ unset LDFLAGS
>+   $ make PLAT=imx93 bl31
>+   $ cp build/imx93/release/bl31.bin $(srctree)
>+
>+Get the DDR firmware
>+--------------------
>+
>+.. code-block:: bash
>+
>+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.21.bin
>+   $ chmod +x firmware-imx-8.21.bin
>+   $ ./firmware-imx-8.21.bin
>+   $ cp firmware-imx-8.21/firmware/ddr/synopsys/lpddr4*.bin $(srctree)
>+
>+Get ahab-container.img
>+----------------------
>+
>+.. code-block:: bash
>+
>+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-sentinel-0.11.bin
>+   $ chmod +x firmware-sentinel-0.11.bin
>+   $ ./firmware-sentinel-0.11.bin
>+   $ cp firmware-sentinel-0.11/mx93a1-ahab-container.img $(srctree)
>+
>+Build U-Boot
>+------------
>+
>+.. code-block:: bash
>+
>+   $ export CROSS_COMPILE=aarch64-poky-linux-
>+   $ make imx93_frdm_defconfig
>+   $ make
>+
>+Copy the flash.bin binary to the MicroSD card at offset 32KB:
>+
>+.. code-block:: bash
>+
>+   $ dd if=flash.bin of=/dev/sd[x] bs=1k seek=32; sync
>+
>+Boot from the SD card
>+---------------------
>+
>+- Configure SW1 boot switches to SD boot mode:
>+  0011 SW1[3:0] - ("USDHC2 4-bit SD3.0" Boot Mode)
>+- Insert the SD card in the SD slot (P13) of the board.
>+- Connect a USB Type-C cable into the P16 Debug USB Port and connect
>+  using a terminal emulator at 115200 bps, 8n1. The console will show up
>+  at /dev/ttyACM0.
>+- Power on the board by connecting a USB Type-C cable into the P1
>+  Power USB Port.
>diff --git a/doc/board/nxp/index.rst b/doc/board/nxp/index.rst
>index e7ec725cc04e..aa7d857346da 100644
>--- a/doc/board/nxp/index.rst
>+++ b/doc/board/nxp/index.rst
>@@ -15,6 +15,7 @@ NXP Semiconductors
>    imx91_11x11_evk
>    imx93_9x9_qsb
>    imx93_11x11_evk
>+   imx93_frdm
>    imx95_evk
>    imxrt1020-evk
>    imxrt1050-evk
>diff --git a/include/configs/imx93_frdm.h b/include/configs/imx93_frdm.h
>new file mode 100644
>index 000000000000..c2672fdc2365
>--- /dev/null
>+++ b/include/configs/imx93_frdm.h
>@@ -0,0 +1,32 @@
>+/* SPDX-License-Identifier: GPL-2.0+ */
>+/*
>+ * Copyright 2022 NXP
>+ */
>+
>+#ifndef __IMX93_FRDM_H
>+#define __IMX93_FRDM_H
>+
>+#include <linux/sizes.h>
>+#include <linux/stringify.h>
>+#include <asm/arch/imx-regs.h>
>+
>+#define CFG_SYS_UBOOT_BASE	\
>+	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
>+
>+#ifdef CONFIG_XPL_BUILD
>+#define CFG_MALLOC_F_ADDR		0x204D0000
>+#endif
>+
>+/* Link Definitions */
>+
>+#define CFG_SYS_INIT_RAM_ADDR        0x80000000
>+#define CFG_SYS_INIT_RAM_SIZE        0x200000
>+
>+#define CFG_SYS_SDRAM_BASE           0x80000000
>+#define PHYS_SDRAM                      0x80000000
>+#define PHYS_SDRAM_SIZE			0x80000000 /* 2GB DDR */
>+
>+/* Using ULP WDOG for reset */
>+#define WDOG_BASE_ADDR          WDG3_BASE_ADDR

Align macros.

Seems some use blank space, some use tab

Thanks,
Peng

>+
>+#endif
>-- 
>2.34.1
>
