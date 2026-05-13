Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3087CD4F24
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 12:35:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9B9C84683;
	Wed, 13 May 2026 14:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="paIXyyYr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46BAB83E36; Wed, 13 May 2026 10:40:51 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B41C8341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 10:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KusaapoESajUgKZeuLcF+Hxk6mf5vwosi0FETPsRq0J5U5Ryq0nmp33vlrxeH0f6IjH4NRJwgKFi2YY8R9G2ByezGPzSs+Mhyqpt23fXyuNnm7WV3COIr3Jy9djDk43b9SkHC94LQ+/L527pJUZDEseH1V8jTxs3ZioE7TYOaKyb4v/o+8xmUB1Gsh3+1hfxc8Tyjf0NEMThI/P+diI908DQWzJRCVieaD/4aA72fvl+RYc2jN+RghrOCPDiFUCkxjhps2x6FmMXpUXPtLp8AXjHrJ9JwCpuWTneE5EWXgBd0ghym67pCiYPqwTU+loHFLu2R3fUBPL4NplFopgnkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+D/DFywgcuAjiYdCUzBk1YQEt1e1ex6Pz9Wv6Dyymc=;
 b=rYZHh4ozA7rBavzuveAv7+pi2zwPK0kOEHkfHKuoSuoGnTL4V+S6akICPS573oHNpPnKJ2RPdhLUSCi1kL4PLs2QQc0+MeFhfPiAwoghdXCtRx8JJ5jQ9qcUc+mlU/oz29mmTUAJtzi4wblsP/ZD0hF7G6JVFdJAsVPa0Kt0D5l26BXQJOYPTdGzMmMrOoUm5NrhDKgvJvK1DBOO8wdnucfN7zGugzX43fekZzO+FQK73ipSfrs6l8+gSiVCTnfUXE4RUa/FzLrGo5Nm+megIyNBZV+0FDhpTJW6p3p4gI47v24x50TPexpmvQS9Wd8E/V/ogV2MNsX1YR057tPBKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+D/DFywgcuAjiYdCUzBk1YQEt1e1ex6Pz9Wv6Dyymc=;
 b=paIXyyYrsItYAYbmDEhojcplpdqE/8VY1YKdIU3DWOX6+beu2kuiC2TzKSWtD4uIHjH0Bhoc7YQGlkjMJJ0AxAyHSBFjadW34PLnYHn25wPY7Vi+BDqZjA5vDGXLmUrQo+Lx/NyOhhSu7A2DooxDnoarWa2f+72cS3Yc7+cpbY3OJOK37ohWhuvFzpJW2FZb7N9LUaGS8kMO622y/hoFImppEeIAtPTqqvocdz4qlcsW5LEIPK/Puo43wXg4haVGDZtyRZbRUZvJItdSU58AUWks0rODCobFfRIK4Zma6W3qEQb2rhAyUyG+6GhBjpXPRQuFczNcYKpH0bn5t++SEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AS8PR04MB8200.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 08:40:46 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 08:40:46 +0000
Date: Wed, 13 May 2026 16:43:28 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joseph Guo <qijian.guo@nxp.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Francesco Valla <francesco@valla.it>, Ye Li <ye.li@nxp.com>,
 Primoz Fiser <primoz.fiser@norik.com>, Jacky Bai <ping.bai@nxp.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Brian Sune <briansune@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 Hai Pham <hai.pham.ud@renesas.com>, David Lechner <dlechner@baylibre.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Ion Agorria <ion@agorria.com>, Paul Kocialkowski <contact@paulk.fr>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 David Zang <davidzangcs@gmail.com>, Simon Glass <sjg@chromium.org>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>,
 =?iso-8859-1?Q?J=E9r=E9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Stefan Roese <stefan.roese@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Lukasz Majewski <lukma@denx.de>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Wadim Egorov <w.egorov@phytec.de>, Martin Schwan <m.schwan@phytec.de>,
 Tim Harvey <tharvey@gateworks.com>, Simona Toaca <simona.toaca@nxp.com>,
 Franz Schnyder <franz.schnyder@toradex.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v3 6/9] arm: dts: imx: Update watchdog nodes for dynamic
 base address lookup
Message-ID: <agQ5sOrSvgTE6tmS@shlinux89>
References: <20260512-wdt-v1-0-0b9e1993557b@nxp.com>
 <20260512-wdt-v1-6-0b9e1993557b@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-wdt-v1-6-0b9e1993557b@nxp.com>
X-ClientProxiedBy: SI1PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::9) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AS8PR04MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: fade6504-3f8c-4d11-7134-08deb0cb53d9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|7416014|376014|52116014|1800799024|22082099003|18002099003|38350700014|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info: yzAx7vmYhJLKiHqRF1/tTftx1wywSlJq+fj+JqNdZ7A7uOM4dZEw8XlCPUhz//kKZy46ctjGgyR0HpSiEi4O5xVJAUCRmDyq2HVpco+MAVGMya9RGSzdVOa/+Pl6PA3g779kXfyJGGfv5NMdD7FJ5sHMvuYT4pxLolCOggwDsp9PZxDqHRczXEaqotQfWRZm/hmV2MWh41xW0qwpqzeu7dKzs0fE3pa1JYBMKQmed+xLcisC/NMvVtKFbmGJrcjYuVTz1cHEQeS0YLKf8IZiYrWRzTpSrvvvMexLyM/h94zt9VPEXf9jhbvkaxXBTYVDiYZrxelLU0X0bBJvnzMhe5pVcWxt6y02KoAB/Ez5uFfOSxSZQWCNwaIQ+R4/pN/UL15NXNhf5ZJ+TXsqIjpt8Bgy+c1tKeL85VFFru3UCVsFULZ22fG45MAYwhrMuYIT4iZiimv2rDU3XOVI84Y9+LYWPcJVqqM17bTGBieiLYVifdlujh8PzbKcFLKFXtqhUhzBD9KbKvDpvHw/YHNpfsMOCWNP9g5tcupeaJr5Npv2BRZo73ZxnCMrpAZpKLblpOZDmHJrfR6CkjD7DdtyZ7uvRgBXd15YjNdiCnT/icYIV2MUjqHHqyvRNSSCFoRodGnyzpSu3eiBbv1PsJxtvD18X9u3phIMnEugVCWjSxNPTvI60I4T1r5tdaeqi5RQ6GAG3Lv+xDvgTZPsDzNlbbPhGoPA5yvD91SobEhWHWrhn3qoMPxmU4fXQhhi4qb1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(7416014)(376014)(52116014)(1800799024)(22082099003)(18002099003)(38350700014)(11063799003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iLr1Vwew05JAb+5m6b5+UWLqrzEzHlvfhQZMjuwetRxwBcjni1BGxkq9n9IC?=
 =?us-ascii?Q?InaPpePwhHWvdGP4qOnVKjL1UVKnCCfTL5Zdmrfmp0QPHZ5jhS9vKEZApw7q?=
 =?us-ascii?Q?F//vEpcvScLRsLJ4Lm/uKLlmTXChWquOIByKFdkfOJovI5qHgzblIBlnKntD?=
 =?us-ascii?Q?NfZvJjRGzcuGc2opC967Q5vWUVmiNlQpN/pyYqp6LIk/ZEYr/i6936oz1Cm6?=
 =?us-ascii?Q?6RChcr5u/Egl5fR0ABlAUyqvM4udiHbIIzRW4G2OycNvofOuaJhswn4twKCn?=
 =?us-ascii?Q?6mOLUYzaLjPc3gqXjREcyyfV9omDIACac+cvLcsSktWxHPg+XXLP9Uhyp8PJ?=
 =?us-ascii?Q?Gcjgp07bCTANSBYmDlLfr/YKEQvBu5czfd0IuFYECERW16sniXcfa/iPWslV?=
 =?us-ascii?Q?Srl1rZmZMakPwq759iWQTtGY2TyrsOQDORAhEfZnTNRlkG/pY6BuREpjrlTh?=
 =?us-ascii?Q?8iq0RYSMILAGBzi6CTOwDWMNiVIeUwQEKVxO64pp5MkHRFY80fjOTeUgdOw/?=
 =?us-ascii?Q?GaWC7kC+Qn8LbRMJW088+KtQn9YvCaaaSsyd59zEHrX0E31IOXgB9hiCwO8/?=
 =?us-ascii?Q?UVQZseQNvCMpCeZDppRyBlhgzcQqFemQUncm7i66ZMMyYjDgI1Tcn3d4qve+?=
 =?us-ascii?Q?N2gGTtpwX4w8wsG4zc7Y2ewk7hkvJDME846rzwjEc34ar5VPVkR35uL9h8Y0?=
 =?us-ascii?Q?paJ4RHeVYJ0eAwaqvCskhn2WUjdRVi/957IlN/upie2PGz91rQrtgGhXf2sF?=
 =?us-ascii?Q?e1jD9HTwB52vFQJkuRNEvIDro8dDEOGX0uWd1LAGJ6QvTM5XQZloVJIF5mzo?=
 =?us-ascii?Q?fCtwXMC1VonwvZh10keihwT4JIHvvyxq+wYr/ssg7H6REjtISq8Ph+7xa/GZ?=
 =?us-ascii?Q?hL5tFCQQvFFrmzNcXZ1TbTAxQa54/NGE69jQeobdDzYs4t38gmXOdhLz791T?=
 =?us-ascii?Q?1bz5RDb2EVAcjVK/4ttcfMOsA9zzhz9rdxuBklXz8lFM1ZLMgUgWpkrpBQiY?=
 =?us-ascii?Q?87OKtT8ir0EmS2+xAjhc7YvBZK9px//lWEY8csPEbfAPxKqmi/159lsJjc8/?=
 =?us-ascii?Q?Xd+ZA7eyAShEFqsN/m2EPHXc+94RDrMxJ8AUy+b+SqrSerC0WqIUy+EwF4Br?=
 =?us-ascii?Q?dp49SPa1tEKL/+0HrEGlliOMv9xoJL9gui6w9euyaWO+HcS6jGtLCIWZm5pQ?=
 =?us-ascii?Q?atZNYr5zZ7/LR6DZPQn4XfEHHPyQ2ueq5Nua/GzIgBkgbhlWtFqO6xxDb8TF?=
 =?us-ascii?Q?0l6/M6V5vFsv9BR4NMi2lfyyh0T+3JoAU5aFMAzn6y5sXljll0wLy519eZ4P?=
 =?us-ascii?Q?6sgKWK/WNRkwZ7he0H9tFfliMKrub1kmD8K1ueL3iMuYW04pNYFVnvXHB+Qm?=
 =?us-ascii?Q?8d7FXFk6wvGI/6zITXmZCXG8nutp5FIMXh4+KF+y0s8XK4QkDe44XHeEXgSq?=
 =?us-ascii?Q?xAzlQrkgHGLp+tH3ahuhlaMlOXDG1v4NgqChkCuCilNqb80zmPPXSzjzejVs?=
 =?us-ascii?Q?3/C1EBXinz1Ms/BeEnYHTowfm6llaRSRQoR/Cw7PRXNhm1RFMpN8z9bzuwUs?=
 =?us-ascii?Q?d+Ky58VIqqfoD7RCanxmlXQOBHUES/WqxGs2iWttIrE2dCALHCYWNDGgzUSd?=
 =?us-ascii?Q?FJyGxUrF8R6v9U7CZ6Gk6omC4JkJ8RnzSinlr33jbXSEuXsbmBJ9ibMgQvDB?=
 =?us-ascii?Q?CAmXZlPGrnDw4zXN+y4OOb6aMzVS600B1vtxPLfmsaF30Rg518caqdSECUX7?=
 =?us-ascii?Q?nHFu5jVwhg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fade6504-3f8c-4d11-7134-08deb0cb53d9
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 08:40:46.7344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47Uh+jS8X67MZP+Oi72yb/Ed+sO8+0wAyEp+Ii0/ETU785LcdlE1k9sx9Qb81aS8Rrhp+GdxCbeBoSMx244M0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8200
X-Mailman-Approved-At: Wed, 13 May 2026 14:35:03 +0200
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

On Tue, May 12, 2026 at 11:10:13AM +0800, alice.guo@oss.nxp.com wrote:
>From: Alice Guo <alice.guo@nxp.com>
>
>Update watchdog device tree nodes to enable dynamic base address
>retrieval for i.MX7ULP, i.MX8ULP, i.MX91, i.MX93, i.MX943, i.MX95 and
>i.MX952. This allows the bootloader to obtain watchdog base addresses
>from the device tree instead of using hardcoded values.
>
>- imx7ulp: Add wdog2 node
>- imx8ulp: Mark wdog3 available
>- imx91/imx93: Add wdog4 and wdog5 nodes
>	       Mark wdog3/wdog4/wdog5 available
>- imx943: Add wdog4 node and mark wdog3/wdog4 available
>- imx95/imx952: Add wdog4 node and mark wdog3/wdog4 available
>
>Watchdog nodes are marked with "bootph-all" to ensure availability
>during early boot stages when init_wdog() occurs.
>
>Signed-off-by: Alice Guo <alice.guo@nxp.com>
>---
> arch/arm/dts/imx7ulp-com-u-boot.dtsi |  2 ++
> arch/arm/dts/imx7ulp-evk-u-boot.dtsi |  6 ++++++
> arch/arm/dts/imx7ulp-u-boot.dtsi     | 17 +++++++++++++++++
> arch/arm/dts/imx8ulp-u-boot.dtsi     |  4 ++++
> arch/arm/dts/imx91-u-boot.dtsi       | 12 ++++++++++++
> arch/arm/dts/imx93-u-boot.dtsi       | 12 ++++++++++++
> arch/arm/dts/imx943-u-boot.dtsi      | 19 +++++++++++++++++++
> arch/arm/dts/imx95-u-boot.dtsi       | 14 ++++++++++++++
> arch/arm/dts/imx952-u-boot.dtsi      | 14 ++++++++++++++
> 9 files changed, 100 insertions(+)
>

Patch itself LGTM:
Reviewed-by: Peng Fan <peng.fan@nxp.com>. But Patch 5 and 6 should be
switched order.

Regards
Peng
