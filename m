Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A180DCD4F39
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 12:35:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F79D8467A;
	Wed, 13 May 2026 14:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="woLQqGyL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2834A83E36; Wed, 13 May 2026 10:37:13 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2289B8341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 10:37:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jV546pVxARwqrb2Vcb470H1K3XikpuouFvcVQktRkMKG4sqf362LTpYudwTqWCM6wJ9EqPA/8gnQ3ZHHWeK8PHDWO3lIuACUhXIWks+UGD/aF0l+xDpo9PBQcVF6qb0zqs20dYqdkT1cTgP8I0Ps3udmJXV3A6Cku8S5fVc40TRZP6Wz5TSfEJ3Nw2NJYj8oF3AL4g3ui0/ivlJi8U+packOXny6yoov1Yv26JXoLJW6z3HkyvpS3VLeNFNgYYP6frQaWgt7XDDTfHSHdPdp21KkItJ16Gd+6YXMWieVIVveW37BJwiiqjOum504PsrN+k9MfHVzwj5QoaqY4nVALQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHgqLPTbpfd7msNVxAOQCvYUJxCMmcgFoPoK+ZfQYSg=;
 b=D5mRqK43P7QSWC9UhMi5NT8UeR0SHw2lgLq5fuHfllvog5tKSphU6bAjnwUN263vgWZyok3F9zXdgQa8vx35wdOoGDWoQB8eLQy0aLhaFZPWj1Qe776np23V7n2oRYBHskDpYrxq5m5I+vSEKUnP5keWCRDRsMfDsWFr4C4dVHmpz5EQh5X0wE+9b9HuQi9JIA/5lsrprQTks2+5FD78Khj2CQAXXTFooLBJhVKNTWk03cU0kBmRjV3Aswx2UUhoBTw87Z+mUUabD3J3Rdmk2GoQ+xEdv1faenMSRYaqn1cGQaLU8tbGC6zdO8eekCjAG4MHEUjSaUfmbbC/EeoRXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHgqLPTbpfd7msNVxAOQCvYUJxCMmcgFoPoK+ZfQYSg=;
 b=woLQqGyLXbbCgJnaI0quz0BU3jBLkV9hyVsG4LGAAcV/L/erclbcwgxTfDIFzSOBeIpcfqIcYXQcwtZhfnm+qsHlqfUEPfoPFbOluJihSUDMNEHMN37Q6TZ0tUEX9rxaJzIeI3yPOGKdKamDzBTRrzrULd7YUhWwsi/H5AVPxorY9Rbo6Tur+4+S7Edi2iCmz1RbdQroC+JJ33jE1CgW2hmPgwtXKvfYGMaOLjaWGAoViM1wvcYQXb/RUrDYjK40sopRBt0WjUQ97N/xL5lfFN0NokIO+eV8BFC2f3KszcdHspFdUAnoeA/UxWffp8iNOYThjU2TJY5fpv05q3WOLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by GV1PR04MB10488.eurprd04.prod.outlook.com (2603:10a6:150:1d1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 08:37:06 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 08:37:06 +0000
Date: Wed, 13 May 2026 16:39:46 +0800
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
Subject: Re: [PATCH v3 3/9] imx93-frdm: Switch to OF_UPSTREAM
Message-ID: <agQ40sJ0eEo8ZNHG@shlinux89>
References: <20260512-wdt-v1-0-0b9e1993557b@nxp.com>
 <20260512-wdt-v1-3-0b9e1993557b@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-wdt-v1-3-0b9e1993557b@nxp.com>
X-ClientProxiedBy: MA5P287CA0216.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::12) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|GV1PR04MB10488:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed4836e-de0a-4711-0262-08deb0cad0a8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|366016|376014|1800799024|19092799006|18002099003|22082099003|38350700014|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info: nUk3cjJsoeXC5tDXb0+IjIUlP9w5THfP3ZfkEEToguSJ4T0i5pZjPu7hufvuP/7ppH7Cm2SRnr2izviVGbZuzupywgrfWGsMffMQMuNMu253bOAoo3l8fRGxiVHdWtpWEcnXXRdzXqZdCvMrb2aXymcBkEqL9+wuuUrf9HjrYryock8/XNAXNrsQuq4CtZjxZm9tV02IO7niYtsK9UBWrj3XTDPjJ3AYhZF+IBMkbAoPhGWigJoJhexJZalTKPsjKT1XoaWwFa9hQIJwSUoQjKyRR3ouTs24gg3WWn2OgKjX1G/8PeHEZfpztgTxwSB1J70lYGVzsRkP7D47WjgsUwlJaOLH/YVK+AcP6dkrSbLj5ZZQC7C3xEgVrrUiMmY6PUE8pZ75+wQx2QS+OSEwdDj4FQvfSxdeqysJ2NBLrPHdHAPWAJv5SSQ/po6o5Hd8GBgJayubi0ZHgHUy8ePt2Do1Cqh35DTrq/R5EQsbWWl2G8rohmtwBe0UTdknuYszzAA+zn1t1ZDctCSzWT6He+103uh3mYx7LcbAJwqfr9Gum4GQh0Zohn0tsAcOeFfG1qxaWJcwPVT5awhTn/DryjoV9PxEpdSpATH6VCoj2/kFnTM0fe2YgvMnCR8ETLiPabSA/2XrX5+4PZjEChMS0y6MzqLwBygFEStDr68TzJh4ab4CrhMjs6XjLkkpYMywRx9XEguz54s6W/QY18XAbfPMEzzWjWvR9H46PKbentzAEnb4St+yb46J8K78E63q
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(366016)(376014)(1800799024)(19092799006)(18002099003)(22082099003)(38350700014)(11063799003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iGf8qHXAApohl/Ri0ks/aJ8DH065rA/h+ABI4n35F2+TPCk8qxEj1MewxJ/h?=
 =?us-ascii?Q?AqiPdL0XJpVHH8H+tIVKnCu7Ca+bQ4z7cW2Fih0jqJUHPd0bRkYTy65RNOm7?=
 =?us-ascii?Q?2aUDvqUVW+9Jm5xgEbfqVlC2Lu09/gAEgcqq7T3CHZxLdc8ZcyOhMHlUtq/Q?=
 =?us-ascii?Q?7vM+CC2ib7kgKfdctXzSMQslA1JlyiQkGbPpF9sGkJXsbpPhdGy20OrpVrcU?=
 =?us-ascii?Q?9V0eatsGN/vGyNn+MeZyN9UlTpYHz0a45PrSacO3UkgRWccdi0cgZmebd8PJ?=
 =?us-ascii?Q?ht88+vPK6IRXHpuw8X4n8DNy2Q9dyLcU+fZF31GfGuVxN7XYeh5TkX52KtBp?=
 =?us-ascii?Q?hjF1Xp1ADViPmBEdjq7s8qWqFfi41apyLZYlF5oRmsCETEIZCsahoMjqrQ6D?=
 =?us-ascii?Q?I3BPv0iEICNs5X/MQe4nFch47PdJFmibvFMyPHmLp1QX24lkYMTWdoG2whM9?=
 =?us-ascii?Q?8VTNzLSloo/5xWKkLvH1qgU3FdA0JSf3l4/7XcpnhkDpXgge3SeSixDHW1tF?=
 =?us-ascii?Q?6HZSVMoztiqQZmPE9MRaZXbWVxYwbSytfYc5Y2olZXjRNIekuumYs+L+Kmmz?=
 =?us-ascii?Q?UQO6rvi9V433j2Xcn+5YBDUsaSFNeHEBRICXCTr6GEm6RBrWVsq9N0uBdXbs?=
 =?us-ascii?Q?KlPuJO92xXbQk/CFfxtv6GjGB+XNui6UlTQn+bHwe/03mEvRGGqH4GLgqEXb?=
 =?us-ascii?Q?4VpVUP15BBwnHWX/gKFI7GLWtMZxboRUPd4Ea79yv7yGmWpRRKlyn5A14Egq?=
 =?us-ascii?Q?aWAeMr8LZCvSLP8NUtlVMFuCNVswKppr5uuzmz29dy60LT6UwRqGKH6xx4Tk?=
 =?us-ascii?Q?o4E9EaPrDkjpzj9WyR3HXtMHt8psmR76LKy8wtRjmn3VQY/HsMFi/bXidF8s?=
 =?us-ascii?Q?Jpo4vq9z7KzTXWD8ZoLTVyKbEYc3ojTTJpI4aUWTfCY4Dz3dKM9F2dkQiRmi?=
 =?us-ascii?Q?48Fn5wtEusd6wxlGBL/X6k1Ccac0vewMHh1+DdcLI0wL52Tr28SeXA4y02ry?=
 =?us-ascii?Q?BWygiXS12VPtSCSNlDudOsR1TPmqeoD7lGk1tUWkCTXx4hCi8zpw6mMlxxJu?=
 =?us-ascii?Q?aQNAK2bfcQGNjvoln/0gvQirUh+Dy6ELTXHiMEn4n7zbbtY6dmb6zThlfMOk?=
 =?us-ascii?Q?HNiCr6UhLwXfEGO2+4UIMpi8+dPakdnb7tKlSqGQT0qEK997+ubmgg7xOzZT?=
 =?us-ascii?Q?unkVp3yOsu1kBG7DI8BN5wRuY/QVF7O9QsZYHoYPIH+J+5rjGxXQ9/tYFclq?=
 =?us-ascii?Q?XFv1zV71hejVIyVjbJ8+sOBFNA/hD8jDi+eR6OfKAz9NngrPkWnbwnqNZ8zB?=
 =?us-ascii?Q?LoRRRSJPUttua8zLChOrXMP1VEeVGPuoEWX36C0R4rXjYdFikNc3Hb1yX6kP?=
 =?us-ascii?Q?RRIjCeNValDZCNUeJgzl5zuti6q7xNwJdN8dU3WKJ7t1hdyp/FoyLC2/rmCG?=
 =?us-ascii?Q?s0XQIxCI9BqQEe4t614Ew96Lwogn8HghOJ3lYuhuRmlhLTGx6UDNmFIrOzlU?=
 =?us-ascii?Q?etacP1sA80/d2QFRBdoLCRd1q0VwcyKU0eAnycSw8YOZyx4h/NSI1sMXCIKD?=
 =?us-ascii?Q?MmMq2LSGYzhitRCknXUaO41tBeiStdB3pYdow+5fE82qpINp20mjtFJ+5Svo?=
 =?us-ascii?Q?CZgaxsS7glsOZBbT4b9/7hIqmjYNqeL5WUmFsFiMX8ACHKSLoVVLdrnZ6XW/?=
 =?us-ascii?Q?YerEPTv4YCH3HsZU8GAJf6IHX7RWOaSH3BqbEzdjgWfh6vkPzmVawt2jwTw8?=
 =?us-ascii?Q?mty2Abp0DA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed4836e-de0a-4711-0262-08deb0cad0a8
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 08:37:06.6181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZuRGuoNWdgSQiZjSbzC+xqFkyYWr2cB7Zj22IhCYBGwUXLLRimm8xE6tXvma7YPRHvO3gZ8zPOL+Q0ksEy74Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10488
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

On Tue, May 12, 2026 at 11:10:10AM +0800, alice.guo@oss.nxp.com wrote:
>From: Alice Guo <alice.guo@nxp.com>
>
>Switch the i.MX93 FRDM board to use the upstream device tree instead of
>maintaining a local copy.
>
>Signed-off-by: Alice Guo <alice.guo@nxp.com>
>---
> arch/arm/dts/Makefile             |   1 -
> arch/arm/dts/imx93-11x11-frdm.dts | 603 --------------------------------------
> arch/arm/mach-imx/imx9/Kconfig    |   1 +
> configs/imx93_frdm_defconfig      |   2 +-

Reviewed-by: Peng Fan <peng.fan@nxp.com>
