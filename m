Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD7BC197BF
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 23:43:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F315B8166D;
	Fri, 28 Feb 2025 00:43:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="fG504NPE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE9268169D; Fri, 28 Feb 2025 00:42:59 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FDB181426
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 00:42:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7ski2PDxkdPJiaE+T3YdGXAjA9ryyTfKxTcBu6q8knt76YIuWqflzvGYhBVkiVuLwWqZiQ2+1sO6d3V86+SX7eRyBYLocJZxf5ZFFlE4FinqCBB+xhaHUDsaVAu0bmO3lKBckAPSlK1aFc2S7VKLF2bz2i5sjXWW1xC1RfPUCM3hVDRfoB8TMNecq6bhOlGjSuxOPn+ANmgqNiCsEuHurBuGx+izKJlbgzCQOOZQAqsnVOmWO+kQkQdohcNaWVb+bf2tHXZwJAur4fGh87vhbjwAJEvsKPwf+kmEaU5mvS/OZZjoQzqyZ43k7bOOqEdQ3nVOtaswJn2mCtDeo2oKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqdB3/uZdZGPQPS/1thedXqtBVbIdoIK92I0MN9urN4=;
 b=XXBBlQSwlC8IICsm8sk4MrUySpXNNc9KhXZGv9zV+Kt+W4kIUgnWw/xSXmbyW/vDD45wD18/KvuNvBKHK+gNPE4G/8HBMC2xDgrrooOQAaEN7q88V8Umd1O1DTykDNuB8CmBzJGfbjZef9UyjiBvrDB/Vsc/rx8RPd2xXTTzNDPiWYMIxLO1MmUQOsp06yEoNwpO7uVr0w0LMFVQeAzN9RYboVk2eRWNnz4YI6pzbHCNUB/aaO84zA3ACodolXNS99zfy+OzajOJi+VVpzVmODo8iQW5Wr+bqb8M/ni8SCCelRjRu7c7ZKoTuChDpCyUAzeazqilnicFLO9/kW2ZIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqdB3/uZdZGPQPS/1thedXqtBVbIdoIK92I0MN9urN4=;
 b=fG504NPELsAEUiIQCiEktmLU7CriS8Zd3qfykwBJC6UAJubNmXKL/pYU5loOk2o3OzfJsoNdExFeDgIyT8vMRhdTcu+wWSeMVOLCGY/2V0JNE8LoW36DlKdXe0bYkN4Iw1Z2qWu/mwsWE+fx3GcY9rvL0laSivzuCrNJB1hMI2+ufULlyKQHGCgbMyXJDwC6q1fq5HejfK40pN5fGWwW7RPbUim4u3i673fgZ8PYUnGYq6uonnvdXR0+wtJ5STvRBZaF9jQxy73eUlveW9T4XhrA6X9eE3mhHVMe24GbeYW8+peCXFcdpXVdYsVCDY6ZsiR2RpuMtvTxoSTA1dChGA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10182.eurprd04.prod.outlook.com (2603:10a6:150:1c2::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Thu, 27 Feb
 2025 23:42:53 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Thu, 27 Feb 2025
 23:42:52 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Jaehoon Chung <jh80.chung@samsung.com>, Fabio Estevam <festevam@denx.de>
Subject: RE: [PATCH] mmc: fsl_esdhc: Migrate ESDHCI_QUIRK_BROKEN_TIMEOUT_VALUE
 to Kconfig
Thread-Topic: [PATCH] mmc: fsl_esdhc: Migrate
 ESDHCI_QUIRK_BROKEN_TIMEOUT_VALUE to Kconfig
Thread-Index: AQHbiSxv+PFSr+oSOkiJK6eQwq35ALNb0B3w
Date: Thu, 27 Feb 2025 23:42:52 +0000
Message-ID: <PAXPR04MB8459889CB4F6BD3E2BC974B388CD2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250227152942.3966518-1-trini@konsulko.com>
In-Reply-To: <20250227152942.3966518-1-trini@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GVXPR04MB10182:EE_
x-ms-office365-filtering-correlation-id: e11bad7f-0495-4fa3-4c26-08dd578873fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?P1iNhBVM8qCHkvD5UiemQ7Yg4MBrpN2d1hQEHoMBWZj3b3+/mQnH39bGfb1o?=
 =?us-ascii?Q?fAmnMZ/VHzTkNzL9i8/PUBcjei079vGd8emFZ0nHhekPDSwaOEsqVbQbFyLK?=
 =?us-ascii?Q?efQGjIittQtQ1gXc5e1X+AAvTwEWSylSrx6HHlggZ8z/FQJaoeDAVk3gNb6L?=
 =?us-ascii?Q?1bzCgAVSESmlLAPz9HBmXQoSHcbM6B7zcZi1JJmYAm3hZlG7GI0bzuA9so0Y?=
 =?us-ascii?Q?UXFBKXF3WQxs4c7purzNK/tSeCet7r3zmyj42FQHgQklaihT/vJBHw6iLODI?=
 =?us-ascii?Q?tsEpUjnph+3uKKOQJddcIMYFPBfeH6PnRhLnYyUB0JAFBilfnYWB7aMoIY8c?=
 =?us-ascii?Q?eu2Lur6DUsHviPEMk8TpfkTy8QQDI4EaK2Xn54KzzswgrfLTJmU3riO7GQe/?=
 =?us-ascii?Q?GGk6fEZLZ5h9MBEFubGv8mlc4Yt8dVQhsBMx/pNXF+LBtTo6F5gwfr1ZRTMX?=
 =?us-ascii?Q?Xad9xbl0IxdZwzi740v+1rVO3RgcJOAO/fPcNbgRbLHk1YxTU8kuijl5ewHz?=
 =?us-ascii?Q?3TP5rNonwAbXNQ1IPQDw1YQQtNCzeb6HsgrxpgsaoVvyXgclWZMa1SgWUc1I?=
 =?us-ascii?Q?MgDqjIT2Mcc09ps9Oez+i9YbxJcBpfOTY0f1MTkg4ZipyV6tODhf6Jlhlu/m?=
 =?us-ascii?Q?AHvrrfAk8p7VgtPEII9O9fCibihqYDNzVVCaP9WHcszoceCDPhh8zq5kk454?=
 =?us-ascii?Q?llIixguD+iE6oPgZ1V+s3GS6MqtO07IgfhZH/aqzP0bm/kTHBv3Phi8b7gJ9?=
 =?us-ascii?Q?0nVILhpS5J85rDAaPeIR2QkxPaGzzVqXQ7SvvyMAtehPwSNOsIbIECcQ67c0?=
 =?us-ascii?Q?V2r2dmfgmKv6Uu92az/BSRAfJVX30P+8VaxCfZqmiGna6ckqQsyyfmJP/gCK?=
 =?us-ascii?Q?ZMcMei44Q1fZhxogGlZ6PkRols6w4iL4syr08SZEAqaIgx02e4e+EwPXnJoi?=
 =?us-ascii?Q?gcWkeDchUYTOKilR9BTzX2VnyVRrrDh1BQuLwHCSSM/7X+W57bxJ1J68cC18?=
 =?us-ascii?Q?EIEpzRxlXaTZJ95yFfHP5Jy6BLHmSUTIZnch98ttA4L32Pr3hXz+zySLKkAU?=
 =?us-ascii?Q?Z0qecO9J7Z99qZm5ZjfpZPn2RYZXWAReEijGAZL0MXZyF72L+14bMqIJQO69?=
 =?us-ascii?Q?l7NlXoYs1IivB0h4jv5qEKtvldciCee68CIA8wMYNzgDIvxjaABsi4JPxVjK?=
 =?us-ascii?Q?rMwcn3Yt6I3Nz0bgtQiBodZeXPAOWzu0FmBlr48uaMFqRAbgYzBhlCz5M+zb?=
 =?us-ascii?Q?L7NYfLtvH1sdzH2r4+OBNEzR/OKW8QdY6bGQ0ydH0ed0ATMlpo37ZPItLH5z?=
 =?us-ascii?Q?oM1MoQ8MMvS1EPF8mkv+gk/fMKWfoIUn0vXjkKLuhEIEU/3zzQQ1v+lIiy4g?=
 =?us-ascii?Q?8U2AljLYj9+DOQIB31FavBQtrLedbH7lDif+3p439ML2Yfh9yUq+GqSYWdv7?=
 =?us-ascii?Q?HfuY+JArXnVr4Box0/omBBifhN/WroCW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nnTLfxHy3zlA6tl7/l/+ibFSTIWsegtwqwqa8fpVqVNsCqoVG54ygOJTtDBD?=
 =?us-ascii?Q?/2YdkRvk8FRUzXbJFFtlvPx5KAQUsNcyxXRGBgAvUiY+sPsqeq+89E8iajX0?=
 =?us-ascii?Q?JkbXae1hWJqCDnk0TKpiSKxHUKwbEGf4rlW07GDvha6YL+vDdsBHmx5nV5sH?=
 =?us-ascii?Q?APfoLenQXvabtQqM/2YEgU2Q5HBYucgnK0GImb1pLw4xlxhD6Pki544YP5G6?=
 =?us-ascii?Q?IuMkOJxVitPzGPPYY7mDN0zoh1wQiBPP94NZ468ZxE575uYlcxAKcCyqfEp3?=
 =?us-ascii?Q?q0FcQku/lCsF4Ga1K+xI1ba4MMEQHOuKBxk+2++gQZDH+CyldF9yLBnmUonk?=
 =?us-ascii?Q?mghUOkGnd3zsuDgzHQrtWs34E/7W7luFb8Qr8TcM+gY01ppm2zOckHq+MrQU?=
 =?us-ascii?Q?nfw0/xusAlqNpftaRrecyuVHXm75TfgOTmTZLrJ+rxuaNSTOjY0xivOUE/fU?=
 =?us-ascii?Q?lWpfqZOcALFz/knUpmGHuOu1PFKM64OhV/z378c/s3X8icd+niPT+wznZCRm?=
 =?us-ascii?Q?6gaoRYGVa4TGO4RN9a2NVi2vCCPXZIiPTBR9tsq6z4GLnzbPiWT00wli+Fso?=
 =?us-ascii?Q?f1Iq1sHMsHMkQ9d9os7l0uBM7yti7vXt6RzYOWfjwjvoYskdVGqRf3krtSVz?=
 =?us-ascii?Q?Mtli8m5tvqqT3LghQ8xHcRd4TXo/0gx80snsaq2TAB5oPT41jubsSWOyqAzQ?=
 =?us-ascii?Q?eXl0hmJ20sFYIfIZ7D/dbkeLUtst1SCzrVfQW0fPH6GF7r921JftYedRljFG?=
 =?us-ascii?Q?M7zv2wu9sqMT2Kgi+bMDaBpduYHIheeTnvGlCYD/yG5KC1gKyiWLNq8jWm7h?=
 =?us-ascii?Q?tGHoNLKU2VhaztpAdOC+BFfdN6gTfCk3tTFixgFcoZIcRcCWGy5LnS4g9H1Z?=
 =?us-ascii?Q?IU4uY0gfwUqY/a6tPGD/xOoEV/cJFG9p/vRRtmNWFERGhrZGP/tJ51RgBJ0E?=
 =?us-ascii?Q?YfsntGoAPTIKIcgFhaVx6xBJ5nMvxE/LmaHnhGyxtAPGm/jfwdsoCJYzcgC5?=
 =?us-ascii?Q?abgYpCbcXaxUOMsL268xpR+hD+JBosUnuKxLcAVcE70SGz3+gyZWtoaSRhpn?=
 =?us-ascii?Q?5z7S9lXuKTFTnnk+04Ky9FhFEcYLii4oNn29W3V29j4nRX9z715aAmzt5BgZ?=
 =?us-ascii?Q?QUTw5+E0jOpZU0+hlgcNl79L/jll3uOedtXJlKZADIKLwCOHFM6OyBBHSYlU?=
 =?us-ascii?Q?SJDkoIH1fY5vvDWRC1YWhHDSmUeqsIIju2V2SHzIxf+Z6MI2V2x30b7CrD+I?=
 =?us-ascii?Q?HirIoJNA85OzwuAQYVa1uwujFo1WMwOU6/3MB4BQuqgmr3VWq+rkOdF5KBxu?=
 =?us-ascii?Q?J88ipviR2do4DNr9v70SiSURFgisTddf0pMQPWd30uPQR71+SxzXkzY+3UDT?=
 =?us-ascii?Q?6rMLMmTWLHDlx6d4gzOW3tfBAZRyV/E8EOAQApCNBhH0f+Kr///nTfTtwdma?=
 =?us-ascii?Q?x2gE1a+zokCUVpx+ahpOZUzJyLLMEEgToboV0Szlra4RnR6P7RPGCE4jFQn3?=
 =?us-ascii?Q?cAFW4SrdWUqanam2gZ/C+BCKzlSnirNBVQXg1IAWxuPcGsRIkz3tTVBp+pP+?=
 =?us-ascii?Q?190AgFptW3xG1jXP1tI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e11bad7f-0495-4fa3-4c26-08dd578873fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 23:42:52.9361 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lUeFQtnqC04kE2D+q6yA4k0jUffvbSkV3k0sKl9wdwQeumnt/p6nFN2pw2Zvk5ChStgYfNz5n+4ISpQ1HlGTqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10182
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

> Subject: [PATCH] mmc: fsl_esdhc: Migrate
> ESDHCI_QUIRK_BROKEN_TIMEOUT_VALUE to Kconfig
>=20
> The flag for enabling the ESDHCI_QUIRK_BROKEN_TIMEOUT_VALUE
> quirk can be handled easily enough in Kconfig. This lets us remove a
> function but not obviously correct usage of the IS_ENABLED() macro.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

