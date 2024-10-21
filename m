Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7785D0E6D5
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 09:23:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52D2388B5D;
	Mon, 21 Oct 2024 11:23:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="fECnq2cA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB2B48841E; Mon, 21 Oct 2024 11:23:51 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::60f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D86B688B5D
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 11:23:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNMrwk+n5Yj1zRks4R8Ntuo23qaoRcM8Wivh1d7bzKeBviaM5LK7ypridfS6FF/9z64Xi/VadAk5MJJAquwF8liA+IBtQKjqcyfN5HiOdaE9/KUpB1cxl3I9cZ23ordcvx9VGBfWDtQqvRNoAfWmLRrAzZdAuB5UeL97aeKE4KUbyWfqGdr/4pIDUfKQg3+fh1y4sEMVHpJrxfUUZMUsxmo5O7p1UOAA7naCtsYcie3I7p5a/dI4gJZTR+xmM1LbuEOm/LV8KEsU90mGPjxMD8+GK9wmGpF58nLkhr721FiHpl2dJKPLryt+6OwWq3I7OiYpwI7IGrva6GvL1RpHeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxzNYV5nTFOmZ2aULNR671oSIrAzWlNg01ZNbVSisL8=;
 b=w05129hcn7GX0icF3iEW8zfQhDXrszyV+vdlJk/A+FKIr9urtfxmJD8+J9e52U/etgibDhAdyduJnttygsi13Io4SkgkyAXaKjYaeoJy+Ga5Ypj8KqxsXbs16FnYu+lcdcPVjddB0EIgwfkkOVaHvvELEO4bBRlhpTFrz3DKwxYOQEKIA+1jz0vL6ufECWelxdPw9U7awBoBT+yGVDkeiDLLQjVlrFJiLhVX/ZD24Ve0fXduGgxuMGtBWpTcSi7fd8wSHexfKc/7+sRKgWGjNlOwUNJSXydq7BLjAvrp7sIHYwto0Nfj5muflIj3D+fGdQ+W0ck+01/cpefnogdVSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxzNYV5nTFOmZ2aULNR671oSIrAzWlNg01ZNbVSisL8=;
 b=fECnq2cAWZVPM9PHbKGD37FdG9XbtOFQ/iQmrPx2T0/kaZqR6avxb2i3lMKzH/sOJ4jRMvVJdPzNM4PMNVDMsbTpMYgBI7bZK0RBm3cKn51fULJ+J87dzG4gu7/qPCarBGeNVt+XQO3jzs2DkXiNw4lfOZTcct7lFMyfqEXsNYxQmpFaKMfiuCwsnZtZicCTCPPevLIR/DU8iVVIPWhxHcfb/gUbvpdlrDOxTZC4BsS4sdwo0yMQKGF1rv+WQXZZ0P+U0EWpZ0vVNqVcd+1azb4CFI/hsNXavYvEjkQrBaWtGmE7V4Pa1SEEwU77RyyGe7/vYUgLZM+byFup4DfmQg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB8042.eurprd04.prod.outlook.com (2603:10a6:10:1e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 09:23:47 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8069.016; Mon, 21 Oct 2024
 09:23:47 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: dl-uboot-imx <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, Fabio Estevam
 <festevam@gmail.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Igor Opaniuk <igor.opaniuk@foundries.io>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Michael Trimarchi
 <michael@amarulasolutions.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, Tom Rini
 <trini@konsulko.com>, "u-boot@dh-electronics.com" <u-boot@dh-electronics.com>
Subject: RE: [PATCH v2 2/2] ARM: imx: soc: Move default TEXT_BASE for i.MX7
Thread-Topic: [PATCH v2 2/2] ARM: imx: soc: Move default TEXT_BASE for i.MX7
Thread-Index: AQHbIzNCcIcZNHLBdEKFLazsufrHOLKQ71MA
Date: Mon, 21 Oct 2024 09:23:47 +0000
Message-ID: <PAXPR04MB845933F967E651D57F143E5C88432@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241020210113.1248062-1-marex@denx.de>
 <20241020210113.1248062-2-marex@denx.de>
In-Reply-To: <20241020210113.1248062-2-marex@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DBBPR04MB8042:EE_
x-ms-office365-filtering-correlation-id: 18cfa932-4f35-4bfe-c429-08dcf1b210f9
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?FHuXjGOnEsJQZmeHGtXRPSGEHzP2awIjwdh5UIebKarb1lbmQmLHBN/GkSiT?=
 =?us-ascii?Q?xzfCcfbCZb8bbpA9kgT/Q+jMxSbcsiyPBy/1bcraXyU/KLOZIvF+OXrxbpIM?=
 =?us-ascii?Q?93Z2nhwYH5JxpyEtCKQZA+sxn8I0FJ3vNJwFT4tUGX9kXeq06YDLWRYEexjN?=
 =?us-ascii?Q?VnJKvUwh2gt5bfDmXs75F3BOXEBPQerLhf0FtUJsDMJFvyB+/x2E5MLG2UFC?=
 =?us-ascii?Q?K6e7e61SZRyRgQ9Zp7+TzNGhVNzE8da2FNUmeTvdn2ZOwan/uyJ4639Kk7Jy?=
 =?us-ascii?Q?59SzEZnX98UhjGmOkJhKMHeqDGIZKjkAjPFEncAwRB+21f5IdcZNHOdx1EXn?=
 =?us-ascii?Q?5Nhidi0T2zcKZw6zI/dbebwbZJfeOGG1FvuJP3AeqUs/UVYOJbq+Z2ZBYr87?=
 =?us-ascii?Q?PD4TxMcIk5tyJWyB8ovSGtIIisIU1uCmMhEdoOxU5/2KiLbYi1697VzY0RZ9?=
 =?us-ascii?Q?z2qogD7CMacdwq2/w/a69QMXvQM4/35BkvCNM3IN78C7oRF0m95M7r/NqZKR?=
 =?us-ascii?Q?B13yuE58lnhaIO9hUfWXEknTll6b0GHLUyqKmb2A5xfUriW0DIsW+PAcNZi9?=
 =?us-ascii?Q?fHbEzxEYf5nRwhRHYHOslllHwbEPFQ4gfE+NXM8ksFczQSmTUjsQAHkmWNYp?=
 =?us-ascii?Q?tTy9zdfJlUlku+raaMULRyJjPmvxK8yZVhEkeV061FR6mgLQzqQQoZqphZ+M?=
 =?us-ascii?Q?oniT4TrkX9w7ZpRj0aJgVAGzh59uwDKxsTMB/6Q6PD6Q7tY3QGNdLwQVmiyJ?=
 =?us-ascii?Q?ly6tQEmKGFUJc7O/zWW1MuZUmMHTqQ+7O7rJAlSY1CkTOoE54apl2ctNMBCy?=
 =?us-ascii?Q?BSGIxIoSfA3GasXrTl4k5NWRtVTXMdsylpcIt7V1Ff3MciHulXWWq9tX+pua?=
 =?us-ascii?Q?xOrrtLC2gExrAjvKjib5e864l397sgYB8QOaKa0jl4qFecdgyYyc5QizzzfS?=
 =?us-ascii?Q?lacc753DtLm6vn4A0zHL5WBprtDt4eA+MRNn/B29Tuygc8PTMTlE+/+dJWZg?=
 =?us-ascii?Q?z4iJetHOPJ4neockgSM9M706rzTxwMBOtJ9x4/i7qh299Q1YoVurn+j2YH34?=
 =?us-ascii?Q?GNp2FfKSz1Ioldo+T0fgldiN9I/byK9Zdoi2FcPRBq60DviGil2tIQ0Crk9v?=
 =?us-ascii?Q?RciZ/Yf2blz2c6XrrcgyPr4Jt0MfPruUj5jknn3k9F/23wtSvnDHZGtsrZWx?=
 =?us-ascii?Q?Vy0+BdVi95Tn0EWoOGOuz/kZl/Fd/tjnCrQ8H06d0DJ6a7bUmW0N/nFhlD44?=
 =?us-ascii?Q?LvRviDfOHAz4wL8PW5damFXkHTQMYpNKlzR/gxwPaSSjqgDWBerrckiAO+8i?=
 =?us-ascii?Q?eNOYvkrgmMfz6AWijxWAjGftG0ryqIsEn1SRMbby0rPrExWzd0moqm4iF0ce?=
 =?us-ascii?Q?z4hgF8g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xFK36rla8cOeuOqeBq8R0kuRZrn108EyOduJAlgWi7nhsMa12p78GWFOE14O?=
 =?us-ascii?Q?eA5Cu0ik1gIYhwUvNjgMwAk3TCZTqvmXKICPiFyE66mdfPBOJejgF38KvsTY?=
 =?us-ascii?Q?q1Uv9HQq4FzqYew4YPjcGOd0NNzcUqkM33xZUYYnnvAP4fsLZVmd7RzcVYhE?=
 =?us-ascii?Q?+/tA6x6086yxIDBCP32MZ4Sz4Rc9CQDLQ56rwqG1/uVCRjR83fGagyI+T4FC?=
 =?us-ascii?Q?lwOuL7Uvm0aQzlwIM/bj6dVarB3d5DyJ26uSTPbRBj6gfz5B+JkKxXBuwvS4?=
 =?us-ascii?Q?nOs2TsdRsQizn1C0rFraFlQWe2ezSt7e5wn1IMUZaHNTYUuBkFEnrU7Yyk5t?=
 =?us-ascii?Q?azURRVm7RtgWEM4YMWXnkX688qoUIL2a/StfnBpGbegZnOwRFrpFLnsjvS2S?=
 =?us-ascii?Q?Plr8g3ItV3H+4LBmJUHVDDVD9MXBkZdM+X9TvN5oDFC92mrhLdONSCLN3gKp?=
 =?us-ascii?Q?dsqeyfwmU4UcQoC+WeoorfCTEd5ZtGlohQWuYyMoy9yn1nAH7LPwGzx8CCtR?=
 =?us-ascii?Q?7VN2rse0eXVDlRZMK3g9v2FA8bbIvOxjTP5GpXOkiejoB4f0vH2EA51RkT7w?=
 =?us-ascii?Q?LvhN2UI9L9zHaZT9ZHhcx+rTKndEijonMzsvMYgkRaJwDyGel25EhnQ6QW8b?=
 =?us-ascii?Q?oo7xgtiJlkL2bHil1Cv+ss2Qns5Gz7xQkZHdCng/iVVFokdAPG7XkfOtFmLY?=
 =?us-ascii?Q?mMLwTesf6LXZTQ+wNHoJjcbY19VzEP9vhz1HAiQ8gjlIkOfAS9YYIlnFvG1c?=
 =?us-ascii?Q?b46EbMJTuvsys2/sW4KkXIXNG5kfhcIKcJD3Ba45MrUFvFglrrrUWq0I9Twe?=
 =?us-ascii?Q?evMGd7BHaLFjMy9g3/RwHRLkjh+OpIxE5CNam62WpZJRP08Joxhbjio+mEak?=
 =?us-ascii?Q?1an6DobpSyTyPMD5ulCh4ixdPakFMWfPlYjw2ZqXeexTC55QGiUQVU+KerNE?=
 =?us-ascii?Q?LMN1mIquJfx/LyJjBsCrVZoZQnczY0IXtR8u+svV4ynflMzZIsLpn7Z87wMX?=
 =?us-ascii?Q?B3DqQbjYnGKLBH4Ao1vatflNtEZGQPlod9LHlo4gbyvPhUEz7l6AUnvqdZ80?=
 =?us-ascii?Q?MlDjp5SlPpqsfLA3GI8RhHRsS5p7Djvh2x+Nk7/VjVJV3zWPs62yUDH5Xqvh?=
 =?us-ascii?Q?rTUUtoo67EePkrwxLGRBQk4Fst3443YRJzivq++tWyDCOu7/gFzcrJ4XlRYG?=
 =?us-ascii?Q?ouNEKClBjA6u8JfFEss90misGevgaCEU0fTn+o2LabssxwuJvq21Gly1OkTg?=
 =?us-ascii?Q?hJlAAsTxniWXyu3HW2TzGX+3G5OkoMh/IaJPY7Ep3a6O3ko4g5TMKbx+U7/1?=
 =?us-ascii?Q?8FPd6mqen6Kg1BykjJnah4Tg9qNOyzhnAjsJl+Jn81Vf5B62FqZYsmoR0/h8?=
 =?us-ascii?Q?8e8Wrh4ArfP5waGYLxF7UcOHfWyKH/uHthTB7jpUjvrl8GgysPZzevXz6cqn?=
 =?us-ascii?Q?mZKBis76qjDDb71YGxugLFfnO4wlP1VaHH2/1AgBIElo5yE7+GqzcZzVmQz5?=
 =?us-ascii?Q?xvdYtL8gA24+CjJ29RwXrCo5jddX/DxMuT2zUL9oYAR2ogY023+FwThrfwEK?=
 =?us-ascii?Q?IH6HGo4YucR6t3Rbk4Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18cfa932-4f35-4bfe-c429-08dcf1b210f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 09:23:47.0586 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +f66VyVvMUzATvtMoSbtXaOXB4ENJXi9BSqmlIUDn+4rEt6xJwkwIuE0TU27vXzjnCkgBx6cJJ2dY0Ib7s+hCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8042
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

> Subject: [PATCH v2 2/2] ARM: imx: soc: Move default TEXT_BASE for
> i.MX7
>=20
> Move i.MX7 TEXT_BASE/SPL_TEXT_BASE to Kconfig and
> common/spl/Kconfig which is the best practice.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
