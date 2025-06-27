Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1824AC7EE31
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 08:01:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FB6A82E27;
	Fri, 27 Jun 2025 10:01:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Ef1ZiUgQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E5D482E35; Fri, 27 Jun 2025 10:01:35 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 926F782B34
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 10:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LK8Pqef6zu9MtW4RvcqEaEMT3TulEQd7nLAfKkUSMc5agmCHrc3if6XdYTUdnH/+TYfAkZJXHwg0n0NhTXGrjJraEfow8t2nMAii2gSuJa5oSYsDzu8Jtw07+OLJzozPZpatTle4iOhOEBiA5dERh4XZsTFKv/YApho7AFnxm8qisxM7kvBDQGQqpVCtGiH9IjVwOzvCopUWFU/cvtSH46MeZPBwsTE/FtcHx3w42I57po3/ZDG6IKvA3YvnyAIoXY1BDIlAucvoCbtaazLK+XQ0kFTggoZPp+/SfzT9oUEhwzA377m+wQgo8yGzsi0LmwDErhkbsx27Qhdd6L2eNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6eeK+hUHfp6uqM+YtCHoUoqX93BpLnVddvtWmx3UYk=;
 b=IcxyLzBFbN7QLpXOw5oHW+620fH5NR/HykJt2drGf01Wn2jI8RAJJSVSz6FRBOhlp4RE1aCzil3E8O0kp1RQ6bpBDXaP9O36z9WqQFoWUZL4jLhdBLOD2JxqSAP+aLmNnvaAOABNRPoHGCLpZHK1uE98cdp5NveDmHtpT37W/tIbjiaAZkgewEJ0WDOic4yjK75Aib7Z/mJpfQeA0UQQcNIF/ZnrYcRUnOaeheFfPVftJTT6usZdShp53bIVIwNVGG2mhP2PwHxVFUICjfVdjzc8JFZoZI8c13sHxIbKXi8eUHJGdEiS1Do8eS0WQiOIXovAleQLhLsd31cRxIiG3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6eeK+hUHfp6uqM+YtCHoUoqX93BpLnVddvtWmx3UYk=;
 b=Ef1ZiUgQBAf+IKK14FdjgMs3QtBRTUPBv2zFHD12xcLH7q86NUNwEr5c73JZV0jW+LkUBOIB8HVxNJzb0gL0eAEO1FCvhcCnMyX2XrWvlD95ZFPfpQfQvsCh5UZQ/reyqMsYCn+xH970Zntkf6mSsfWyJBlcbbPjDCaqr7p4UawDT/xDZNuEHo8BF8pQMl3nHXqJnWdWG9NDUTFvzZdn1ao7iFtg0KsIJpTYOqGMI8h0vNjmddNBQUv21lw/m+AMc+ukIPoUiK6RrVC5DqFb3adMp4fKDMXCht2/m/HNyiXxS7uyOrU9pG8kzCFXaUmEhAVltEJM39WiVF8F4Yr8xg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7858.eurprd04.prod.outlook.com (2603:10a6:20b:237::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Fri, 27 Jun
 2025 08:01:15 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 08:01:14 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Lukasz Majewski <lukma@denx.de>, Fabio Estevam <festevam@gmail.com>
CC: Stefano Babic <sbabic@nabladev.com>, dl-uboot-imx <uboot-imx@nxp.com>, Tom
 Rini <trini@konsulko.com>, Gary Bisson <bisson.gary@gmail.com>, Jonathan
 Currier <dullfire@yahoo.com>, Marek Vasut <marex@denx.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, Jesse Taube
 <mr.bossman075@gmail.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH] arm: pinctrl: Define .mux_mask field for NXP's SoC
Thread-Topic: [PATCH] arm: pinctrl: Define .mux_mask field for NXP's SoC
Thread-Index: AQHb5ydXC1OcMsg4xk+p2u/jCQNAYbQWpM8A
Date: Fri, 27 Jun 2025 08:01:14 +0000
Message-ID: <PAXPR04MB8459B19D18F07AEF5B7D29928845A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250627054943.3140496-1-lukma@denx.de>
In-Reply-To: <20250627054943.3140496-1-lukma@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM8PR04MB7858:EE_
x-ms-office365-filtering-correlation-id: 863db03c-ee3a-4459-a6bd-08ddb550ca0e
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?RHTKZKrfYf2ULrTN/staxPJaxGorwAcFYp0VPKb1KrdKQVMd1DdQaaezjfhE?=
 =?us-ascii?Q?RkcJ644p0R4Eum3PGBn8eP1kPylbVe2y/yblTWRO+Ax25mzzpReCwdrV4dJ9?=
 =?us-ascii?Q?eqYUrOKeJ5+evjj6qlA+fjijeQ/i9veGUTuVASCGlswJGpTA+wUgbjVOMctq?=
 =?us-ascii?Q?jPmJTdyu06KzmOQX+tNf3puSyNAGRxAoXXzDSP+qR7sIl+diNvU50yoUPCun?=
 =?us-ascii?Q?ezq3Fc0hjixRsltupkj8sGy7MhT0WttnEhzejkSQkLQ1rmVLq3C3xlUBoCEC?=
 =?us-ascii?Q?7Mp+c7b81aPziq7SiKlC0i/b4IjhOf6Idh0kIgl43jNu2EkDH39SBQ9zQJhh?=
 =?us-ascii?Q?8zGRYsI40YHGPEb+JxIEbZfK5kNMj9MdBn2m6Y4wxb2fP+kFSZr9UiRvWpra?=
 =?us-ascii?Q?TvQU6oA5WGnnXaj+If1oZYE5pdklICi63NqDljQabaAnfagAScylUHsXBgOk?=
 =?us-ascii?Q?qzCSZRzrQaIAMAx1PWoaX014UO7JRJrBLF1/I9/ZBzZ7junCCRAGIvLWGYav?=
 =?us-ascii?Q?A+zJUq+kNK+OjSkpN93PSJbSr1962nOg++lqpQGWplGDsNqwuNwAIUyf98PN?=
 =?us-ascii?Q?zquRfwYRAFTg8vMfeWoyxEsDzKT00WvvZ2ap8MGox4ucyH6//dxAQnYcD/aF?=
 =?us-ascii?Q?41Kj2lpOzLC+l1V/dP8rf4QJp+hRWf2k5hyPcmrvNw3D5d0/BuZyWGuxEOK4?=
 =?us-ascii?Q?qdx9FBMKkvJPUgqjdt4zZ8/SiVVyGYr9ZYtAjUzZ3yc4wQJxelfc2rda9gje?=
 =?us-ascii?Q?1w7o3IgrUhxnL+8qL1GjyJa0brq/daNZbb5Bs1jKzWxQ7dxtTBmg7pIkbgMk?=
 =?us-ascii?Q?PfbNBpJswRqJiJaSSQEDubzxvYi7sysplcHkM9FrRAHAyft6g0RhaLR9FEx4?=
 =?us-ascii?Q?k7FeTyoxejDJXpN+0ClDSc51mR1XygIJOQjdh448sC0j20ax2xBRhXdTXy2h?=
 =?us-ascii?Q?V1jB6OZHx2wbv5vvD4g3ibRSbdjUv3+yLjVfg+Ur4LmYSnxRnbXOM3iSgh3n?=
 =?us-ascii?Q?QQQ0XXdPJdpKWTcRQB0MlieFxXYhr1rhmnbWUnGJvFPVUSDMsgjhoOhEmNGb?=
 =?us-ascii?Q?2qsVsNeMpptZcYZiSejACx4ZIKLtx2KKroukMMf+/6CLrOWdIOwuZ7PoS2+S?=
 =?us-ascii?Q?YltQbH+hnKZsaWqIUUMRpL/1Xk4oBn22+CU8JXurgsOfGgkXYJsEO58rNFa3?=
 =?us-ascii?Q?TBdIPXCP7+tU0xvjLcy3vqNOvWo4SqcNolhbLqmSL5IpVTtrAeuycrpHGcdS?=
 =?us-ascii?Q?3/biN0uHap6g56WDdnJKx/W864huK09A9aNpkgWpF2J9idw9L6xipMvBk6LP?=
 =?us-ascii?Q?BiSFU506Qp+Z0STVyMA7o76G0FegeLXHAlkQx9GiTGysBE1TV8PtqEsyc9lL?=
 =?us-ascii?Q?VtgLqRMd1ELo9lYF707AKtLn95kukvHngsw5v76qt9QKj6xG9kDSl7t/XjHH?=
 =?us-ascii?Q?FDp09zK3tTR6uefTa+6vEPtu8XTKVXbuKapENrpxug11uhbyHxS08A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xi/ESaDQkHu4iCIXep+pIrFJhtBRpqd5NqUtrIWaCzPw2d9O+fyUTacE49XI?=
 =?us-ascii?Q?ZjWXog44WBihNBIVKpB7lIQ6YAxu4jFr52syry9NJQhvMc0wu6efORE7AqQz?=
 =?us-ascii?Q?AUwHLGDzX44WPYaO7rusjtYKYIBJYidoVcH3lowbjPo58Tn8u9d7TO/l+CaA?=
 =?us-ascii?Q?XHD3LcSFkSw1lq+V6T9dwPuVi76toeQecP+5BLQsMNfiA9nJmcShzQgicJga?=
 =?us-ascii?Q?l44xhIlmS6eb6JvGi1XSpqTDCtLx8UAL19+cVN0KlYjgMq8OxEQDzV5llr0V?=
 =?us-ascii?Q?4LWhgtIV6JnbPoZhshbITov26D2+26ZUw7viKj1wxs+I0+Wwg5Hp/BdsIPXo?=
 =?us-ascii?Q?Z5VUgKEseRhtar2d5GSSi8sD3Ak2zITd3ugpyT+3K13ptijmlabpO9SgmB50?=
 =?us-ascii?Q?cOxmIkbv5OuL2jW/kN0vJh+YXcpoe9hpgNeIDs0VECk+jY5y5aU/t6CORNrq?=
 =?us-ascii?Q?Qzt4WE5m3r4itJFoBbnD9jvnkaqXyhVkKNe8Jvo1Lmd9lJsp1VUElp2h9RDD?=
 =?us-ascii?Q?8GlaPzYy16GnMw6sppci+4pzFxhQ46d+4p6kPG4TYVJziGNfOdDb3e1wAK69?=
 =?us-ascii?Q?g8y9rVTRCM7pjDD0PsSvViKxWQqsU1D8Guv71PTLyWy5DzVncBK6ErZhqdig?=
 =?us-ascii?Q?o6RQUMPSgrkwS8hcC3SNTGI6TOK1Hm7nsSEZxvX/LXmWLksVXm1T+14v3YiD?=
 =?us-ascii?Q?pojhyu7iFOIRqGrGXVyEn/LUZqwMk1p9OjbY8YrhIb2husp4YDRzx8MEcd8p?=
 =?us-ascii?Q?uO0OkwIKibnQ8ydZRQNjbe+upByYVoScO12/pvgYl33WGtgdHEB8ECxUA1vP?=
 =?us-ascii?Q?HszM0osmyLwo2HT1k/7mQxdJ/CaL+uZr9qYp/nPUdgWgx4YnZ0lDMH48kYq3?=
 =?us-ascii?Q?EC4HlQOJQ2XI80RfIo9M5eY6muRm2cT5J4jdoC8TwVnFNM5/ikpSXdpX41RM?=
 =?us-ascii?Q?B/3M7Ufvwyb54ep/943At6Ab73/tTsyTiBIIWg3GOnXdpEqOPYUsakfHhupO?=
 =?us-ascii?Q?RBvdPP2JpODCuiLxUn0Rb+9sxOiqiWu2poI/3mE6SuBlRSe2m871s1D4nYRL?=
 =?us-ascii?Q?T61dmOutVneA6bmeeuVizl+uaHH037CbJD4bTMatkSl8+xtYfgcfSueE0XYO?=
 =?us-ascii?Q?6s+TXbTz3LB7n5z7M/e8YTqQdrthzMywxD7ziQLfF1eKd5m8AnZnfz74Bpnv?=
 =?us-ascii?Q?xDHL/dY35C7/O2F+q6+Ww8+kVDAsrTEJqRyA0IvHbMXplaQ49vQqfQvA1s8A?=
 =?us-ascii?Q?bpR7Iw/eYm4lSb72wltvbqqS9NK+V2pdTtFcqQM1rahg7vZmG6EKKTlhmv4C?=
 =?us-ascii?Q?ix5ftHLjM9vcOiVeIDgNeH9hJ02Aq3uWVkRSOteUXabB0QTgTzhA0RATqBcs?=
 =?us-ascii?Q?z/nrVBXzslEuFqAjcuDkCpcVvZFmXiEn8BZnmRkML0UJrsbGtYd3TbbBXz4W?=
 =?us-ascii?Q?12LC/dCH9IUoSkf+d1dY/ij5sZerYvy2o/Fhhy4DZOr2sGpRvqJ2/ij4tvUY?=
 =?us-ascii?Q?IfM2DOAOITLzgJEUAPph+Hbe08rhCKSa8bZMRCl8hA1vIyhNZF/DkYwkJuy6?=
 =?us-ascii?Q?5L1tAd9vTH8NxTGQGXM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 863db03c-ee3a-4459-a6bd-08ddb550ca0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 08:01:14.8144 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l1my5zBGUqtibiJXZKEkE7yvN7K9HOdd7WsbfxIJOlhrwMkdpkmcLO60BDWXbFLBOcQVwbXq7OI38iGnFufSUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7858
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

> Subject: [PATCH] arm: pinctrl: Define .mux_mask field for NXP's SoC
>=20
> The commit e8a9521e649f
> ("vf500/vf610: synchronise device trees with linux") has synchronized
> U-Boot's DTS with v5.19 Linux kernel.
> It turned out that in Linux's upstream iomuxc node description the
> 'fsl,mux_mask' was missing, so the U-Boot's pinctrl driver for NXP's
> Vybrid SoC was not working properly.
>=20
> As by default the mux mask was set to 0, for example the vf610 based
> boards (like BK4) were bricked, due to misconfiguration of gpio at early
> boot stage.
>=20
> The fix for all NXP eligible boards is to define .mux_mask field for soc
> specific *pinctrl_soc_info structure and use it directly in pinctrl MMIO
> driver, without the need to read the "fsl,mux_mask" property from
> device tree.
>=20
> This change brings the NXP's pinctrl driver in U-Boot closer to Linux
> upstream one.
>=20
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  arch/arm/dts/imx8ulp-evk-u-boot.dtsi   | 1 -
>  arch/arm/dts/imxrt1020.dtsi            | 1 -
>  arch/arm/dts/imxrt1170.dtsi            | 1 -
>  drivers/pinctrl/nxp/pinctrl-imx-mmio.c | 1 -
> drivers/pinctrl/nxp/pinctrl-imx8ulp.c  | 2 ++

Reviewed-by: Peng Fan <peng.fan@nxp.com> #for i.MX8ULP
