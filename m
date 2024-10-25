Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720C5D11704
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 06:38:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86E3F88F94;
	Fri, 25 Oct 2024 08:38:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="mgz2J40r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFFD688F94; Fri, 25 Oct 2024 08:38:18 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::62b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F279288FAA
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 08:37:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfvztpF6hfaKZX6qgPVcVFfn1nSn8iT9cWWu+HZJI9dGzFQnpGcfQ36uoEiCqF7mkxZEFzCTtIsEcokPxbTTfGU2POMs0nHdqTweEo40KrTJCVgrL1fqbX5Yt0WU4f51tcFstV6lleSCLErImJRdfDOHL2dOFwjMT8KqFG1N8PBbCNAa8wzQEA4QX9ccY8tB6EjEZr2VmS7Kn6c7aGZe7032aa2s8Z3644BeVoY+Ca9CAQ+SrC89zxVT7lLHucb4RHex3vpsMMOX0Y+fyi2Tw9JaYiZk7vgMy1brdc9R65gxrEKhKlp6CjFpXbUyHdhQ8b1+wWO3mGSCx8TzlZYoLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4VWwx7OPiUwtOMNS7DexQhrokWAx7TFaEn+TTOe3OE=;
 b=pdP7CYHMko91EvpiiVRIHfHKmw/Ll3uQzpUNl7ZFCpteyUj+AfqH2efgodulUEaQnUJspaDjJNZURkrqu2utmp3vblrEbIaCq7eyP7A3FUr6fJ9OYfBCR5xGa0pXwbWKzIRteEefrpCseabRqYnLJjL9YMpzaHKE/eITCiP6rfGt3SEsPhQJg4JA1mtAiK7dPlngaQK+El275RYnMOnOe3S/tycxhx6CUKz6GsQ8qwCH/HIzPwmv2hDM+btrYWRXprZyNtt/qZRDjdMVsgB6cjicjWG+gqV4LULX1myNs0SQG2Hoa0mMF7TAyYYLUufQXLE7BwWlGa5m6k/8bE0WCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4VWwx7OPiUwtOMNS7DexQhrokWAx7TFaEn+TTOe3OE=;
 b=mgz2J40rbmqodPaEU/PeKfaU8//KGbQV6mKYCmf3vdUDW2TJNOFqMsCLSVBJ1/bjkkWivmGzCV2SBfMDyi2Co6z0vnJZyeCvubN5CHA/zT0X98Srr4lrF0reZUnCxgPWWRAssdNZrjeV6K6pCxZTv8e26mXqeiKO1GzA+K1Cv9r7uRnhrOeY4GJ3Qwwf/BPcNby9GywdkoObSyvxCzCjyu3So3QYb3+hYiDU6eYqFrxaGD181aqb/G1u0Wch0uZdFfn/mRirxHFVfTSoa/xDYKTlDdbkcWPdQagIrPBYihIaFcp35PJ3HNFwdFnc1cvx7MuHNqfhn/u8krj9eyGbZg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9123.eurprd04.prod.outlook.com (2603:10a6:102:22e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 06:37:54 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8069.016; Fri, 25 Oct 2024
 06:37:54 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Jesse Taube <mr.bossman075@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, Giulio
 Benetti <giulio.benetti@benettiengineering.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: RE: [PATCH 2/4] imx: imxrt1050-evk: Fix missing clocks for mmc
Thread-Topic: [PATCH 2/4] imx: imxrt1050-evk: Fix missing clocks for mmc
Thread-Index: AQHbJoH3z4y1xeBcEUWVb882b3MVrrKXA7VQ
Date: Fri, 25 Oct 2024 06:37:54 +0000
Message-ID: <PAXPR04MB8459D91A7783651EABAB8702884F2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241025020228.1686306-1-Mr.Bossman075@gmail.com>
 <20241025020228.1686306-2-Mr.Bossman075@gmail.com>
In-Reply-To: <20241025020228.1686306-2-Mr.Bossman075@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB9123:EE_
x-ms-office365-filtering-correlation-id: 154619ed-55c3-46df-c9f8-08dcf4bf8e69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?i4ioEF861ZD687qkeBXF5psivfc83nruct5PwKeQ6Pqfedwxxf47j1yHYJem?=
 =?us-ascii?Q?meStHHtABv43GXTUtCZIiEUHVpTAli8OJPGRVOUldSjjMwjEAOunISc1HAXB?=
 =?us-ascii?Q?bXvmYCJGe0GWQtgNk+MyETll9DvEkOYG50fWUl4IucHcTxJKA00L/UeyC0k7?=
 =?us-ascii?Q?8q9N8f35cxTrGe7IbKkuX521RegWAoLSubPxvDdt2GoC5l77wtWTQQw/bo1W?=
 =?us-ascii?Q?cYFxbavJqCJn89+w1NvHptCudzY/cSg4/29jURvOLd9F6+2aey56uNtupbZd?=
 =?us-ascii?Q?R9WZICQhx1n+qfB0/5fEXqVtq7wiImUwPDBWkNyzx8mBMX2RCuvae28L3il8?=
 =?us-ascii?Q?VPTG6LeyFnWRTryrTGZKpyp8tiQvvKalvTkT6f+73L2jryGklO8u6Ld2SQ6J?=
 =?us-ascii?Q?IdyuM1NBjPCaCjrThYrqClvmsX28ubkLuToHcfzACC4TTaU9qx9DJ+RbsxVl?=
 =?us-ascii?Q?7xJ0EmTeJFehyZH2dOcgk82AL/zMFmsmACBKQ3GMHUJgykXELO5sqh8ANi/X?=
 =?us-ascii?Q?br8wN9EhOnwlMoHo/8+q8pguqbW4+QCT1gnVdZFXL7gNyJ3oFo2WpoCaS8BI?=
 =?us-ascii?Q?Z8eMo7KTc0TEDleA3DxGhu09og+yixKNWYy6HOFTgAxop6cjww/cFCTaPI1N?=
 =?us-ascii?Q?HcTymAO5/z/Xav9uqCDt3vW8w68sW8HVMXF2t2225NWwZU3IDpPTImaEYCCJ?=
 =?us-ascii?Q?ackUaz7WoDkTqSs+P8wNIv4d/kRdUDOur2mPvR5Lf+9Rqku/R+NMt+tXRfmm?=
 =?us-ascii?Q?JopXy2d4dUYF4zYyke/9Qbl4QkS6tuY7BGwyW1BeCktH+OKq+wfSwjTvZe07?=
 =?us-ascii?Q?mbok3hDNJSZeFX19YGeIp9g+v5S/jxjCfU/v1GYo6DR9rzXovURPQ9Ejt7XR?=
 =?us-ascii?Q?qPMT0pcl0L5Z+6Qykd7NcasvjfsTS7Ivz8Y0nB3BFowcqtHfKeTMTd/MPzgz?=
 =?us-ascii?Q?3rwwso2O9b061WDymDzEHxHGVW+c7kzWGPcTSfYJhHhqaZ1lwvV/PCXXT3NJ?=
 =?us-ascii?Q?i/ExZjiETlynPqR75+iVFxECKtDizdia9FYKwa5QEqR5yQAiKM3zti08MG0P?=
 =?us-ascii?Q?Wg0HswcTCyLlNGAUWKojLYmhDTA5AprXyzcKQUSt8uPyPoHrtbnUAPFMiUz3?=
 =?us-ascii?Q?BPw08BFSXoamVNIuKwdFqpHwNawqoFYYK6cmBR5Pd7W0HsNfsD+2JKpoCaZO?=
 =?us-ascii?Q?QCOFbD8XGKyDtwv/FZYhODCMLHbmCG0CQkH4JjaDpWeMVKfWnuXu59n4jz9M?=
 =?us-ascii?Q?mTYQ5Z9Z+s/Ca/TexfLhWas1dEYAR9a5vik86X0CKGwmJckS8ax3A9/kzHmh?=
 =?us-ascii?Q?xb8pYoKY4vbCbY4u4NWiDp+RUNsEWSxANZoXoE1oC90jo0M8KqJpC32BPtJa?=
 =?us-ascii?Q?rhUFapM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1q+YqoOkw1weeqP6yUq35H1ZY4BSaFgWyb15xLc83O6Yzq2kpOyvmoQ6NyJM?=
 =?us-ascii?Q?s3XC9DDEzPbhA0ACwKGtEXqA29L0+zv3lmrLmK47IA9fxwWGr3dfUqMpQ2mR?=
 =?us-ascii?Q?Cpm2BEO+I7nRQb3kCDZbx2J5GBhER49aflE3OQnha69pmFNTwnuvkR27e084?=
 =?us-ascii?Q?pSeJqrcO6K+izwcljyRqmVQxW4PSedN2/Ws/7t+1NaI1V7o8W/O8zLkwbVrG?=
 =?us-ascii?Q?S108N/rAxma463G4rHwO400IMpYjw0ZAbJvIzaiNu9UJEB3ekttCI8jf5u6c?=
 =?us-ascii?Q?gavmDvdNA5EVxOS5D2Tm/D01WC4kN7LtDZlLtn7C3SGeIa7jzI8ueXP0X9cM?=
 =?us-ascii?Q?SeL3AvijP91099msLuMoHN16u/FPsu40F9lq6I6kWod2DB2aDGd7VIvLOP/s?=
 =?us-ascii?Q?EDsjgO7rl/tyYxge6wpQU74f4ZGMuxijahuFy672ppFecK8RSZmLIOiNKaGI?=
 =?us-ascii?Q?BJIEAxc3nncMjIgIDRynUGvAig8XsoDKKzs7tRe0nbK8+ZuRABGRW0SsQwZD?=
 =?us-ascii?Q?/1lJmEKQNehiUrk8MhhnUEqDyGuJv+FFnjsiGDdHcMVv+yFP9n5PPsPZE1yt?=
 =?us-ascii?Q?v8VjwyHwAhGC62vepEu0Z3uiYRT6Q/vlEv6CnvkO+rB15VJT13XpVsWwKd4o?=
 =?us-ascii?Q?yukUmZ/GSDUh9qequqQlT0IqaLDIiC7/OLuWIZoEUdAsNtPtui6O7WFgIJIW?=
 =?us-ascii?Q?YhebT5cXar2Y+bw5Qrq356VEpJklCRxK0/g2MOcfXq88Lb1CGgpyxlc4WIuB?=
 =?us-ascii?Q?G0rQXrRNwNwqUtaOol4TMcUvCrDvViAva6H3e+3374h1aY7OZ5h4w22HaAeg?=
 =?us-ascii?Q?0XtnNwG0c/nVUFho/3l59UgjzCnnjoviDOqQvOQp7vCiyi9fTO13Q/tMVZrA?=
 =?us-ascii?Q?Nw0nMAxVBWbFk+De3xLPi5CL+cdLG2Oi/KfiWDvyw4Wleqgg0Y/Xpf8xJCDF?=
 =?us-ascii?Q?sA0bi87uIeBZSBb45SiQUVVBMs4SrKUb9UdFMiZvcKZ3vmR0i/IZojU75Nbh?=
 =?us-ascii?Q?b0WV+9M8QlfNbnqL6moNBvRJdOrlti2sfmme7XVbcy8WzzjxhM1h386piCTv?=
 =?us-ascii?Q?BFFsH0Ju87xzf4QDLS8sdkNT3owQWVGYDMmHn+aZpu3GNTW4bMIqMMkXs03n?=
 =?us-ascii?Q?DCHkmkohIItyyO/C8DJ2Eqdz12fFZGk47vCBSyeRpgVkbhYvUdaUqFZZ5gLF?=
 =?us-ascii?Q?P4OEoaX4dj1Iq2triPdQf/jpN6fXhnj8yGV4/iqLpI2FJmJwFZsCM4cLUFop?=
 =?us-ascii?Q?+7/ChFlRKdiCIYmquJKCkSZwIcaqAXHmJSQLiPOMXxg5cyC8fqATt5Qx22ij?=
 =?us-ascii?Q?i48j8QL+RqXTtxdws5V4tCn/ReSX57K9rXEjSUbcia1CDGYXSlagjNmXqa1J?=
 =?us-ascii?Q?RAqb30EKG8UFcvC2e0S2FqwiG3WIs3C5VFl5YS8OHsZKBidk7Z6Qxse5BeVV?=
 =?us-ascii?Q?+UxW+fct+XkqbJlCJI8x65q1RjlnXmUswyCACOY9n5ihjvV5XTOwdf9TzjYO?=
 =?us-ascii?Q?s5xQaYorasyFh3A5ZO9lyyfZHnr2M1xta8ZYzhUOyZsxjjeghF8CW0wIVb8/?=
 =?us-ascii?Q?mD50mHQCXcnU2Do8r+g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 154619ed-55c3-46df-c9f8-08dcf4bf8e69
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 06:37:54.4911 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V51DHApaT+S3gbQvPY5wQ9Y5NsKfd2D094wZZo9jyBy9VaXc81YPKwqu2n2rypROCOR3GZ8D2ey5i0/dXconRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9123
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

> Subject: [PATCH 2/4] imx: imxrt1050-evk: Fix missing clocks for mmc
>=20
> Two of the clocks required by the usdhc1 controller are missing from
> the clock controller node. A recent change enables all the clocks in the
> esdhc node, which fails as they are not defined in the clock controller.
>=20
> Fixes: 76332fae769 ("mmc: fsl_esdhc_imx: Enable AHB/IPG clk with clk
> bulk API")
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Peng Fan <peng.fan@nxp.com>
