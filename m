Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DAECA0EFA
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 04:20:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E346682DA1;
	Mon, 25 Aug 2025 06:20:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="JJ3JulHL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43F0582E37; Mon, 25 Aug 2025 06:20:26 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14AE4802C1
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 06:20:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2+Sz6SxEuDfZZu+A8DWtfOo6vCgkLcj8X1D9fkMqDEY5ozvo4s+tG6trbd6Ss67Hz+qFzs9kZjfwcOvFwGsK+Qpi9RHaNUVXfEcnaQmIcdgMddVYsh0TClGH6cadBE5HS8suAu7/2eWwXjvawySdhBgeOMn0aqPB4Ltc67B5cWvDpzshtAs1PGrsiQ1WbV4zhOFLhoL7G6GMH1WATyU1VLp70+r1iLmoAT25wMrEapHFh0NT+AOBCpjyXooOQHragRWXH2MB4nqpUoHSF5BUHrvKYgIvL8ncj5NrVlgOdANwjwN5omGqejX+AJF2SbnYKtX5EN1pde0s3HBpi+bHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8l5yPQtDW7i/e+2e/r+yPNYrPsvmVvm4KuhmTPB7sc=;
 b=rlOCefKfdTCt9Cm/HA9NpwvSRXzFQUcUyp0p5amixb4HOWNrI6gW0lQIkN9iez1CpHV/ZwxGKTPeMHMVf6CrbGvaYS5XhE4Q40Nw43tN4UxaO9fGRzndRnsY8QxIiyiouMLzI0cZycYRyyePngx/To++4oNE38cDJnClj/SVZxDMJfOZcNTOEpS6LIw3Y68OSNv9PvvLPwLEHRs7kbTlWGPuIPjCdBwhiQMkqkf7XZKIEZ/uDd0SrQf/oPehGZk4cEZpg1uQg52ZCnIMkU1Hw0Pj+Mt/TEXVSJawGR7O+X8bfnqCbVZxi0wddQDruSSQrtuL/Nc7dBweh0zwMiNZWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8l5yPQtDW7i/e+2e/r+yPNYrPsvmVvm4KuhmTPB7sc=;
 b=JJ3JulHLGtJGrioQlVVkP2r5xUc575ukWVe5krAzGcbqiIg7Wqb45rs9qdzc2VpuhdWW4u+/GhQR9SW6FMnfbxi5FzN94YM5d0lKalE3RGhEdp0YP+O+o5w92W8qqRPJPwglXNHvScMYQ2xzloPeX6qCIf50Z6NDWaL78VpXg4BwAXDejW0ueoG42az28ObJfbF2XEmz7SEwSzSp07TyclyKqyp2sCaZbgugl8+CbP2XoOsqdgPTnzJ/q4kI5H2SW6en0EeCs2yCQlY+Iwyp2JhVwyyEcqR+QyegZZimcRwGi+qG5tFECvbVm3lhu/YmxeO3MZfW2wwnJrGNG4FutA==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by BY5PR03MB5298.namprd03.prod.outlook.com (2603:10b6:a03:221::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Mon, 25 Aug
 2025 04:20:20 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9073.010; Mon, 25 Aug 2025
 04:20:20 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH] arch: arm: socfpga: Remove speed and mode from flash probe
Thread-Topic: [PATCH] arch: arm: socfpga: Remove speed and mode from flash
 probe
Thread-Index: AQHcEMFfVzGtNmhJy0K1jPg0lfFjNrRyzYEg
Date: Mon, 25 Aug 2025 04:20:19 +0000
Message-ID: <LV8PR03MB81379E64C6579F5CDD0C8B01A73EA@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250819042555.28113-1-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250819042555.28113-1-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|BY5PR03MB5298:EE_
x-ms-office365-filtering-correlation-id: 70126901-162f-4a55-b23f-08dde38eb3e8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?rPbsW00reOtTQ+ENmdpbhMu4I7xJKS1557zDng6frL0LfyHBqhThTqLB3B7S?=
 =?us-ascii?Q?S6MpO8YQrGW9Qe1GfbDp2CBfPO2HsVwdyAVzLjKi9GuKGw6kejUg9lvd/EKp?=
 =?us-ascii?Q?70zK9iXr95Sqb6D79llbHuQ0xEjsHdhjfgMz0M+3Lrh7mkdANyVEdZfgivR/?=
 =?us-ascii?Q?kXPTWE+67W6S2/IPIqx7V4bRPhzn8niRfwZm0DoFVug1vBONa6Y2Xznth+TP?=
 =?us-ascii?Q?2nVZDWU8/CK3JcrmF0bSHm3K4TzqlPbsxjDIIYSm+6g/BSGtnm0o4vuxoq9l?=
 =?us-ascii?Q?Pd0vUJQvcMCGYDVG3s7nsv1xxx/siqdJ3mHmvI8nTVdUDQnj0Wdv+Ux2oVhr?=
 =?us-ascii?Q?5qTajjo2EgYnOVJ+wk47T2IRUFi1LIk4dTMSwgMaMuyfVL7Vc/jiyYuqpx7i?=
 =?us-ascii?Q?NnMiNBqbaI5tXSnmlXI1i/xuPvxmXPov7ZMe5StPN1nLh+x3bKI2ZYta3RCn?=
 =?us-ascii?Q?t7lU6QVILJ+vuFqpTA+wywEuOQPj4mH2lVh+M/kfEB8PPmPgvUubf8AAZjZB?=
 =?us-ascii?Q?UBdPDBp5mypCp6b6j9nxCtsUVHhja+JYEP2edRdt/wHSvfjdbQoiby5viA6U?=
 =?us-ascii?Q?lYBFmUsK1AiF+fSclfarCMxZowcnzHMOpy9W2cnBt3s/ADiSJpgj1RaknIaG?=
 =?us-ascii?Q?fcFCtIw685rUoEzm0gKO14qtBj8BKLLC5zEH/kACBCUGssxZLsq8jQ70kw+P?=
 =?us-ascii?Q?iASF7+2OhJvxlsBKGpRvHFi092umaAwUQxBiOp5ykO7XoYuwo+mJZQC+zVgJ?=
 =?us-ascii?Q?WPSd9NzE7LxHrAtPRs+gbdr5DJuqFZAqvTm4wEZWyoBDVsrnVegrpVHOT4Kj?=
 =?us-ascii?Q?FOyxyN/1fOcUUtBfzBbaN2ZfoC+4p/hSo56vQ/FEthO8UZtIrzwA3MWFkEyR?=
 =?us-ascii?Q?p7SF3QhKGtZ4+Tk5n/7deFYNIKqVqtIgB+oxrN5bGLgbU/xy62Bl4ECdZe4R?=
 =?us-ascii?Q?Ok0+3Ll/FLwOSkGJK8JfHBLGN1y26a1KsN0clN7yKXJd8Mf2YwN9QbqffcDY?=
 =?us-ascii?Q?DH6MWY5RnrMkiIPx1yzo/ntmZx8OnnITtMS3g6cjX/I+0l9rrResN+Yft3Pp?=
 =?us-ascii?Q?HptZLuHzeaVz/Lpu/YF6lq1hD5r7hi+Kt534Mqo88WiZnNyVNAEJjLhHr0vY?=
 =?us-ascii?Q?mt3X+uOgRoJfBSf72MKsqPxj73Y1IwqSkxe/uCSyviwSW5exiQWfruz1rgji?=
 =?us-ascii?Q?FbzxstoVj4Lgfj64PEpvgXqdRJIy51Yk/PMVZ+NEiQ0xgpvxUhgOFxWMOx5L?=
 =?us-ascii?Q?s9dZkNv09f1IbckjV0yXrLhCRWBE4/Sza2eY1zzXKpaq3hFe9rrSoX4uL0tP?=
 =?us-ascii?Q?tjZJZgF7BEFJ/jjhlYFaF4LBk1d4ARPxzqx8liHxqncAWdtOasAIUMrZnztt?=
 =?us-ascii?Q?TC4c5SDkr5tiYxiifVNuA1Y9FqxERE3er0smkwTzkzaCCB8/ge+jOnfDPbCU?=
 =?us-ascii?Q?zLgeDBVEUAvL+5MYdIupfo1lyjV1IjwV3gbWbPv/gTSGw9upzESjHw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jHxAG6V0s2nGXUOsikLpVk71Q8NF3I6+Q2e/MeuXIn7vWeouN2kNmA/NmxTh?=
 =?us-ascii?Q?IXZMH4MGNGADVz23trRx6WUMetqO7yWTQxol1xuFhAGmSB3iB/bYBoZcLF+o?=
 =?us-ascii?Q?e4buv4L4Qj12mdcOQRJiw6b6VTmCU2f1B22x4sxkYOErLEryy6f1WNc/aIn6?=
 =?us-ascii?Q?U62H/VnmEVkbVEbElxJdw3fYBGtKODx1cCUP1c+dWFHNjzs0YFZUFkQ5yYhN?=
 =?us-ascii?Q?K7DVkrUwb/3UISeDrkoqqlBZ45tAjs+bExSA8uIitKoaBsE2VpDkvWMNv96i?=
 =?us-ascii?Q?z96nU+BjviQBOHLj5xWR5yx8Ir8xGzsMYGeU2fdtW5dA9gZyMbYd2fyAY74Q?=
 =?us-ascii?Q?CLB3EVRzB0WbtB1nH9u7WT9v65RWGw1wjh21CZXWwGnCiDOTfDW+wanroOgv?=
 =?us-ascii?Q?UtTBNPo6JXsVHWvPiunpf6Rj/BBMebPL2SmsmYtUX3jWxmqrTfLzbQpaqT98?=
 =?us-ascii?Q?qU15kOznzT918wJ5F//q4GD0LzSVaXrLhyszTiCh7jHaXAenOxW3YglayYOm?=
 =?us-ascii?Q?eAFejUFrozfvZHJORfe7xVe6DH+fan5E06UrBqCywYamFUH6i5BBms/K7Ug2?=
 =?us-ascii?Q?xBstWAlihUPHC9hfNKWQFxa5dnuK739RZ7+GnE87/HF6UcI4KGCtlK+wbUbm?=
 =?us-ascii?Q?EVfPqlMo6fQYz7vCClBmoiLVWbQ9XMykh0IXfOV96WLYdBdg3Ug2y/c5BPef?=
 =?us-ascii?Q?Y8laNbwmQr8yKUP9uh4vWtF1omYOKU6NcFcFL3b9dIR9CVV7RD/EzPSemQOi?=
 =?us-ascii?Q?7iGWDRX3pCUu349GjV4ak7jtC1IcpyoA7PwiFYajNNCfUNxGgxo6GBcLq02V?=
 =?us-ascii?Q?5jdHtA6Q+tDGOfrzTzLAu3D1BA2Kx6tqovk28e8u0TMqsdA2/7+0zbFvH0I/?=
 =?us-ascii?Q?bxoza55SCaNgAxcMHfvNkJczVdcgYDrUDzOqanb7j9mpK0qmYd8F3rA4N6dU?=
 =?us-ascii?Q?ahVpXjsnKD61ARfSa7sdeDWhBa25CaXvkz75PXbYMA54F8ohZ5dWyUbKLPlw?=
 =?us-ascii?Q?7OH6D2WV2l05hMzkaGHHfyrTnhykMbbTeQ8RmooY7/z/pJqi7/JNNuoPB07i?=
 =?us-ascii?Q?NBxEvr5IQPMVfX86N0jp+jfB9yJgYvCSMnH7mHmY+obWC0AnjrfYMI1l/nJ6?=
 =?us-ascii?Q?cV6So4eBVt9VmIaQuyhk4E7GC0aO8g1W6tWjzWnse7akovIQ161s1jXmSVZi?=
 =?us-ascii?Q?yrn86XpVdgsjChvrLVtWNKhl69UmgFwWD1FaTsVKK19JFp53hZDb6eUCkFtR?=
 =?us-ascii?Q?hTBiGvbPq37pXZmWpZ7whnNM95gFtHP5cVEuDZgVHziOrMWGRK3OBH5eUqgh?=
 =?us-ascii?Q?NCmxtJFlhHn6Kd+h75ktuuOAbWT9j8IDfaghA3dO+bgpsZ7xyxW+ihjoDnGZ?=
 =?us-ascii?Q?PGSRo1NmgR2fEdaMqsQAlHkSHDFxEgaWRu0T0N/sxooPAkj+NYTSuNsvDrtY?=
 =?us-ascii?Q?SDiGN8J3iK9YGA1iKrhngJLUZTGA2JVp0JXH3BsWySZrTE/BhZrkCCNeDUTw?=
 =?us-ascii?Q?sz+3S8veQJ8owK1kPXWIizjyZXxXh0CDjaRXwpbCFL2kl3FLcDSYbKEH2A3g?=
 =?us-ascii?Q?jVXuYsd/EZkCUgLnw9x0ZlX8vfsiXaTOhRgMczqU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70126901-162f-4a55-b23f-08dde38eb3e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 04:20:19.9622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LYtR0CWocSMcbOuvniH0cU06uy1aegdleTnEUgosO9moVVZLeYhYQdhNQCvvKBZVBCiSiZfcuyQE9avaHiVJNmCGa1SFzq27YXYyJ9lhiuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5298
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



> -----Original Message-----
> From: Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Sent: Tuesday, August 19, 2025 12:26 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Ravulapalli,
> Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH] arch: arm: socfpga: Remove speed and mode from flash
> probe
>=20
> Change is to allow the user to choose speed and mode values from dts or t=
he
> default ones.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  arch/arm/mach-socfpga/misc_arria10.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/arch/arm/mach-socfpga/misc_arria10.c b/arch/arm/mach-
> socfpga/misc_arria10.c
> index c442af02888..7e0f3875b7c 100644
> --- a/arch/arm/mach-socfpga/misc_arria10.c
> +++ b/arch/arm/mach-socfpga/misc_arria10.c
> @@ -214,10 +214,7 @@ int qspi_flash_software_reset(void)
>  	/* Get the flash info */
>  	ret =3D spi_flash_probe_bus_cs(CONFIG_SF_DEFAULT_BUS,
>  				     CONFIG_SF_DEFAULT_CS,
> -				     CONFIG_SF_DEFAULT_SPEED,
> -				     CONFIG_SF_DEFAULT_MODE,
>  				     &flash);
> -
>  	if (ret) {
>  		debug("Failed to initialize SPI flash at ");
>  		debug("%u:%u (error %d)\n", CONFIG_SF_DEFAULT_BUS,
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

