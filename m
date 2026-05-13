Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13922CD4F3C
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 12:35:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E44380F0E;
	Wed, 13 May 2026 14:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="N6kOIj63";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CFEA83E36; Wed, 13 May 2026 10:36:17 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B024A8341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 10:36:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVnl7sT1NENYDOTTOG2Gbco0t/QfgNjrORvimzhgTCi+6EIUfDFt//ozVdyhUv9bivapEmUrX9vwqTHKlJ+Etx/3s4JJT5mtjn1xBQalIE8DTyDpJArGXOBwKcIXHVed7aj26rWfzsmzmBWfZZQ0xY7pNY0SFQQNtSVXdLeeeo3DxAR9VQBGsMKbiEYEW1qIUF6Fss9PRsvxBgN9G02QvVSjGh208jTqHKgsjuQ/IzSWBuGprQ57SucZBrjMKdxhi3sZnUByipDEBXzOLeq5CpCf9WbXgBeOQgAYjCfdnp4VgMrmi53YEMvJfU55DgbrWwy/9/40MkV0uyxD+tG1Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhqGx5+dWJaog3qXIBD9dLonFh9kNLJFQgPwHB37bTo=;
 b=LWyDX73/IZJsE2vTsBRjgHj76BYnd8f4e+Ms1bu5A5yh9lstxftkNuvjyh9AfItYGYeqGRIwp8/A7ts89/JTa2twU/jykE1Xo0f+dTQ1KX/ggJxJKEPr3tBkeG4QO7lEliG/HMBMe3lyBzR+GZECZ6+qoFtD9d7efdxqg24uallpjOFNtS8rs9PRmSATyOAVXQbAxJvY7VFXHzhApqMxzJidJjsnMvyjcd5IK0pN09uDc1alCKItoc6vdO3oW66DxZLhvCnzkhDatBmgdqEYLYhizlSZ1iz2Ait+Um7d+5lHiyU8sHlBqbfSj4i21cjNV74AMAhvj67DHrEfsydPbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhqGx5+dWJaog3qXIBD9dLonFh9kNLJFQgPwHB37bTo=;
 b=N6kOIj63P/AuD9br0pjbPZZm1DnBjKcmNmx4ASlVuEULnysYByzSFn1P54OAkQ7ZS9I6A6t9xNu2Fxctc1MGo8uMdDdOt7RwjeSCgHZl/0u2erB9z0PZG5S7KFCBhGQXEUno1r9K9qazYZRZFnUDD4SYyW1ZQIpPVQ4TKUg8685YdSFls9XjR/UXJmMf1zV1gs37Kz8ueVUSzvRPPpQA7rshVqmz4fuLr3cKLAiaZZ7D8xlWtt5dRNAVNRDvdlI+7UhYI0iWLpCKYrVNfMDEURHB3tdrvToJMUHbicSxwFDPmtr4IF6wgGUWXDxOmvkynRNSjIfmSdZoxGpBVCWvFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AM7PR04MB6901.eurprd04.prod.outlook.com (2603:10a6:20b:10b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 08:36:10 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 08:36:10 +0000
Date: Wed, 13 May 2026 16:38:49 +0800
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
Subject: Re: [PATCH v3 2/9] imx91: Switch to OF_UPSTREAM
Message-ID: <agQ4mY9xjxqxRO+x@shlinux89>
References: <20260512-wdt-v1-0-0b9e1993557b@nxp.com>
 <20260512-wdt-v1-2-0b9e1993557b@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-wdt-v1-2-0b9e1993557b@nxp.com>
X-ClientProxiedBy: MA5P287CA0244.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ae::10) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AM7PR04MB6901:EE_
X-MS-Office365-Filtering-Correlation-Id: 353025b1-c4ba-4a23-dee3-08deb0caaf30
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|7416014|52116014|38350700014|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: yUrLq4rSKs5Ow3BIBYNgVfUHnIbAW+5VAFPixc8Z6CnTmDM6dYTdacFyh3JbkZte+AF7371/puCihFNELJxfAMycwOI9Ec7ZnjIYlHFUCCqngt7NZOC7I47bLN7b3Gq+YKI9S0v+82mHtteuE+Wlp5liHbedXgyuQkcHiLECi+CFz2wKHIQxVs+4YUq6yHXRaGr5bG4IRE1WYq4UsylnE6r1kj28ROsWzjyUsar3JvuDb/xslmryIo6ELbVd6Tdfi9mw7WB6s/ASHXxhh8WsEwhE6jwCAM5ryc47lG4L9by/LT7n+G+OPMebWzFWj2Ntckg3/kGCtTojn+xyurS/k+5C/xUPoVfWm9aml+CozkX/sVzNwNY7uFvY+jvXbEX0RMNAI+mT4gCksE1no1MKFeFUbLOjdQeIWgg/P2Vrega3neXTF9HXlNF0NUFmRvrTrgGp1LrO+D8vtPe54wmeaYNmSL2jpoRq+m5tvJ3i8xJmD+nhTFZf2c7GO5AgxjJ3q0nmaSob5L8y3sASQv43HldUJLkLCRgnGd2Y7rzvGFyO9s6jGu4bwQsZQfaPv3zt/94YJWYT9pvltYBTATEvqao2ZfV6T8bJHsTPlA17q9WhYk5deOfce6+9O0wD9zjHw5ySfQAqmV3BhmGi7O7zOvw+KMOE2arBUA884Ucs6XHvTswgMRI14PBw2+ZqchFgGYhRnVhWtHovk63giQScW94yLMy7U/i1M8UjeBb1UetmOFjSKAIInZk28klNgutW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7416014)(52116014)(38350700014)(56012099003)(22082099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u0gODnNb/T8VlPFRW7y+3MspzlbuRKWBjb6k++WdRoGB5sSsrKlCQI1FVvfc?=
 =?us-ascii?Q?lFQnpObnmgAMBVqG54M+mTjsxE5K0A1l2M+Pqe8Vb+cBUy/IurEKyNjjGlLF?=
 =?us-ascii?Q?lX1cuS4I7kRDMdaTmdIH0xyn6ZZIiOjfr00eD55iFHe6xAlAIGtgtw4L8wT0?=
 =?us-ascii?Q?U/9tiSHGA/8L2o/rEXWmpr3OCuJ37OP7iB69D4RvbnSAkPxhg9zJxgcmRymu?=
 =?us-ascii?Q?h62u+yokhqzwm3/yxeMas+ILoDk6s2uFNPWeHPOLxP+7oTLdsZk7apJj0FD/?=
 =?us-ascii?Q?HvUOMSTmiC6F644fbYsGYvWjgAVkEdaXpFwWibD3OajGEyC5X52sdscc2rx7?=
 =?us-ascii?Q?L0Movk1XhcrzZkWUyZqoitIt3TBHpixyAOM7hKLcKG8SZ9YBa/YBSc6zSVw6?=
 =?us-ascii?Q?+TNyIvmOF1b/K+5ZOQp35SDktBKTuFSFfDn1d/02Kp19GriIoh2aQ10nBILK?=
 =?us-ascii?Q?wbEBhFD2lCsAW8RXhX0tt6EPrRMCI09KYglCFjzvuXOhsexTwQ3PGYSDoDe/?=
 =?us-ascii?Q?CyiiS632omPP/1HNR3xiuWYoBXsnCjk98CTwPdBKyAbh4gLUVfhcM3RJkrP7?=
 =?us-ascii?Q?SOP8658i0St/h6yeDxNPJcSEIVbEJN9gv6aq+D3Re7ONaf3UaVTqXClHcH0M?=
 =?us-ascii?Q?c0g22gquATcrSp8bZDqQpkxLMK/lyTWM6ASAne0cwTDZ10YUt8OWHOoE132O?=
 =?us-ascii?Q?7sSB9QGe5Hf9IGNfUx6rYVPmN/mlNWSVcnRYmRm1vf7g/1xQH0KD0v6UfWoa?=
 =?us-ascii?Q?ZJswTKsgPgE/JrFh1URIcoPeu+7zOH/X15ph65zZ1jef9vNtuR2ek0rdsnUQ?=
 =?us-ascii?Q?xKdfGbthUSQ4gPri4wE1WwS3ucVKLbdn/qcTaEA/b2YjP0m2DvqzE1/INPuR?=
 =?us-ascii?Q?pWSXibSkF4GxWweQ68ri3WYkEBsEcUKNJlws/BZU6BGFgCndyM1Ktt4VlkhH?=
 =?us-ascii?Q?9TZ2h2ky7xHBd5vQG/UstZSqLlMU+N4JEFvpJ4IBkyZ8kJ1k1laf0ewj2sXw?=
 =?us-ascii?Q?O+X5R++JJnUB9N6ctPX+gb7AzkuI271inWVO7Oyc9Oqk1pW8bal5w81wFnLO?=
 =?us-ascii?Q?Pl5Bc6snnV6a5rWYkN3inlpxmfxelMhYipxnIc5xhY/1MgPPqvSZIH1bX90H?=
 =?us-ascii?Q?NW3B9eqxq46yJUY25sJBb4ykcA2FDsJNZYLtKAJ5fUCWOxywwDsgH2ajD+pb?=
 =?us-ascii?Q?AV/K2DEHUikxc8boiDQNdVYHYo047Y0l4BYkdkfMwHPitPF/uPKLd+bm6YNX?=
 =?us-ascii?Q?RM+Gvafq8WI+LwQPoSucvd6Twiuvy40gWqlsRcRRBoukVhhMr1tmPTw7QuDP?=
 =?us-ascii?Q?Y+GUO+mzEP6qnrvXPwUMTGDWUR8zA1Xz2FnBuuoHbxpkQOf6ANow6HRji2mP?=
 =?us-ascii?Q?OVPGMLIn8H3SwY/UlBGwx0HZumA4VvUmKqafVUAwcJOL57aXP8+3Ue2TRpp7?=
 =?us-ascii?Q?5q8ADFKy9NXBJSPuk7R7Gp6zTMd/jKya9M9abl7LL2GOIAztaltleMH+qlNE?=
 =?us-ascii?Q?RbCQvMQj5ZSoDO8937gZLYmDzOG849hdErOSMHDtetTEctfQQ83LEN1auCCY?=
 =?us-ascii?Q?CDcA7/dHeadgkwthXTSoYQQx/RCczBMsn5KHBqGZw0QaEkcvEX+iLEP1oRzB?=
 =?us-ascii?Q?bVGkijtxvmVoWavyXJ/D5YAjg/jfXYt/1pqxJGPE3zZDc6ipRBYP9wLFBX/r?=
 =?us-ascii?Q?Hc9yAr4A3vDkPxyFsmZ7JQNN5tG7f8/asYzHkLNBYXWaGxhapDep4e97IvRF?=
 =?us-ascii?Q?Nswp4Tee5Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353025b1-c4ba-4a23-dee3-08deb0caaf30
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 08:36:10.3865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTtkLj5YtpwHyperPBMZ7zk4/7jXN7rgG38HzDmpjZjzXNQiAzGG8WZ6FLveP0lrVaWvvro99GiPXEwYE/KgtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6901
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

On Tue, May 12, 2026 at 11:10:09AM +0800, alice.guo@oss.nxp.com wrote:
>From: Alice Guo <alice.guo@nxp.com>
>
>Migrate i.MX91 boards to use OF_UPSTREAM feature, which allows U-Boot
>to directly use device trees from the Linux kernel upstream.
>
>Signed-off-by: Alice Guo <alice.guo@nxp.com>
>---
> arch/arm/dts/imx91-11x11-evk.dts             | 875 ---------------------------
> arch/arm/dts/imx91-11x11-frdm.dts            | 773 -----------------------
> arch/arm/dts/imx91-pinfunc.h                 | 770 -----------------------
> arch/arm/dts/imx91.dtsi                      |  53 --
> arch/arm/mach-imx/imx9/Kconfig               |   2 +
> configs/imx91_11x11_evk_defconfig            |   2 +-
> configs/imx91_11x11_evk_inline_ecc_defconfig |   2 +-
> configs/imx91_11x11_frdm_defconfig           |   2 +-
> 8 files changed, 5 insertions(+), 2474 deletions(-)
>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
