Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 656E9CA0EFF
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 05:46:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88DC683145;
	Wed, 27 Aug 2025 07:46:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="MkCCHpsd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D06383189; Wed, 27 Aug 2025 07:46:10 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A69B830F6
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 07:46:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOwsmpnS97J+T2pRiw/JeJMpjtmSwndS+ZRXNnhxm+fk1e+wohIzpU+14DjYWZ6Apogqe22iNVVqMS5AdDdg4Jn8Evv6Nluq5150MmRkKGmxjO1aK5TwVT1waffaBo3FeAwERMYNOWFt6xK7zszYzAI51m+qA9Ljdnk/s3SN192XiggLF1JnsINe3JDwjRcgcBfwwDWA2KEeWaqaM6EkyoQS92eONdF8nyE1ENC2VMTs8drI7Qin0su4Ldq11ZbZSXBmMTqA8quwLaFwWvKKyeVhC01vV3FWpPjyc7+vXzEPKGZnQfwKdU/DD1aLAlJojgww256OU4EhoXBV+CvLZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9M+QMewM/fkgjsjSqmCX5gHUWMAj3s2GPw2aEJrD8rg=;
 b=R5BFQEqYNiDY2+InqfdNAbV73HbqRG1c8OWzTjfmqdUbCdVnQFF1/cMoYJ3WhjxIo2Ut81mzV+PjyUpkXJqHj0S+TJ2k4hfPd5Y57ojxQGWpHPap4J4CwBt3aReHgAC8EyIuPq00+feJU4izVUkNCMeHyv243YdUrtBc6dQmI1zL9M3gAx0fIbymS1sEZBnQ0mHAzIcbVzTS1zcT7eGGCDhx6QNBdXKD2tHBwes6akgMgfFSCmDUYIYu2G46wrDNYtb8G37G3F1kajiAyAzJ/2+PwldB1HQ6YJrTsE0ACqSwXZ/I8UeHrgxlHMMDq2ph6WpQh5db/tAXPPoaWPV/cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9M+QMewM/fkgjsjSqmCX5gHUWMAj3s2GPw2aEJrD8rg=;
 b=MkCCHpsdrdC8So0PjbJe7zjml6SmVomShgWAliB03WaQc4BXCcShDizj+ywadEv1nhdbDkr6b7ZDcRrdbKT3arNBTNYpA4iMwX6lojfyQWvXXEYMDdkyek7KxEUyjMcCrpjq26ZXRUmFdLAJMa7TSk0Xy+P91cLu/jPZSqVKu+wS7ELA0LAZiP2SJipFk/7RPNRu1eI0EK04oT2QL8qkEXRAo9Cn2zXRc8mK6lIgVmyEzMbOyXuzpBQfnYSzC00nlRdn2A1/6RvzhNBppKLZgeYbmYRmVcDFhL72z8OOVAeA5WwI9T2Q1NtpT3Rr0H5lEFctayCimIuDI/Xtl7YfBw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB9927.eurprd04.prod.outlook.com (2603:10a6:150:118::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Wed, 27 Aug
 2025 05:46:03 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 05:46:03 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Frieder Schrempf <frieder.schrempf@kontron.de>, Jaehoon Chung
 <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
CC: Joy Zou <joy.zou@nxp.com>, dl-uboot-imx <uboot-imx@nxp.com>, Stefano Babic
 <sbabic@nabladev.com>, Ye Li <ye.li@nxp.com>, Fabio Estevam
 <festevam@gmail.com>, Fabio Estevam <festevam@denx.de>, Frieder Schrempf
 <frieder@fris.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Marek Vasut
 <marex@denx.de>, "u-boot@dh-electronics.com" <u-boot@dh-electronics.com>
Subject: RE: [PATCH 0/6] Use correct LDO5 control registers for PCA9450
Thread-Topic: [PATCH 0/6] Use correct LDO5 control registers for PCA9450
Thread-Index: AQHcCsGccnZRDVGKWEavLq8C9HIT7LRzIm8AgALzOSA=
Date: Wed, 27 Aug 2025 05:46:03 +0000
Message-ID: <PAXPR04MB84595561F74B01EEA36C020C8838A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250811131213.211124-1-frieder@fris.de>
 <42ae44e8-b368-44a9-a828-578c77d4d15c@kontron.de>
In-Reply-To: <42ae44e8-b368-44a9-a828-578c77d4d15c@kontron.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GVXPR04MB9927:EE_
x-ms-office365-filtering-correlation-id: 87713b10-cea6-4dcb-0d23-08dde52d028c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|19092799006|7416014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?+Dn0j6lVnm22UkISjO9e+fMUjUA4/3HWRZBqC80awfU66Ozo3oxaU+hcVL6T?=
 =?us-ascii?Q?D5z/BVmDeXMORrmEg+65JH/6S1dpNxf1vnrMpygNLjZVVIWFSpCQv9rhkAXX?=
 =?us-ascii?Q?pjPieQcr867uINY6eEDUnHAtRyynHaVNHlRq1BFgGSHmEC7PCohsXqiLcexK?=
 =?us-ascii?Q?841W+RJB5bKbrdVefbsTgURlbIvHMUlZ2yOvjBze52B8s7VK9xIjGGUE+m7p?=
 =?us-ascii?Q?cBD7vJLTc6K3oWd5ElHzraBGglm1Lqe5stLDEFFTTtj1/LCSK1JKg9nnz9Fp?=
 =?us-ascii?Q?jZMesk2eWxnkX2Dn0MKvX6fFdqmiXynDTx7wx1hfAwu2/SQ5cdPIHq27kVHE?=
 =?us-ascii?Q?bLblgq00Ttpjy+oh7iXq7wbaejTgX4Mw/c20C+zClVKGomQCWUZsgaf0fgcH?=
 =?us-ascii?Q?n+xfVj7oZsiZnTNANzaeJYPbRT7pie+xTKVFLzQa263Oun6WVL84tMpPB0TI?=
 =?us-ascii?Q?Rrb7V3hzxzEWVvpLszeyX6Tfb6qi+M/mL22nwbvITUq3Kxova6hQNYoWI+/X?=
 =?us-ascii?Q?LXE9ns0/0sFr8Cth+mKLMyCmeVP5+wdr/cGF5NA619I1WIu2jBlN2cGEcwXh?=
 =?us-ascii?Q?dBB7On0zJAJwL0SS7BtJFJXDqWZiS4C/cuu/Qhj2/bfbSzhwhb+WZHmsxmZ/?=
 =?us-ascii?Q?P5puV7hPfFjCQ+OLAJIbcTqSTu2xsZzSjv+PUL1c5UNskUlGsHD9UmoTifOL?=
 =?us-ascii?Q?sYU1xbJE3Jwb6FGLlu+HGUPcLv0dIIjB9gKMPzk8hUtFdkO/NbfNgRg/pC76?=
 =?us-ascii?Q?y7p158qxt8RJheuthVP5T37Up/jwOT58Xex0CiB42OtiuBJivnXuemMxtDBo?=
 =?us-ascii?Q?AVQFgadcV88v8DJeiilbVV5HylOCS/yuxH7aGvQtP59vjkRycays6u2L2dil?=
 =?us-ascii?Q?cu9sns3JuL7oOr1K8t6Zvv9m1sMPXDFgrc1ilIdAQBO95ygMUNeItCCgNz9s?=
 =?us-ascii?Q?n51kxmKjtDOGe8j7BN8qhqWImhSRuOudOX7Lc7vE1qXlB/amh5zfaDcX0m5H?=
 =?us-ascii?Q?gVaujZRslHI1Y13fenQbl7YUdWmfsKyfLztjNCNjcZJdvSLvuj9wqPstWIXA?=
 =?us-ascii?Q?QhaDCnqMVyDOZ8boZ3PygpRYCt/TMI82UUhLSL6+BxWn+mJ8XOc1dkTVahpw?=
 =?us-ascii?Q?UUt4k1r1RGgyw13uOcNJd9xBevydFHj8BV3L/ubwOq2g1ZkGlwF63SqMoIfa?=
 =?us-ascii?Q?MjmZC/Lx7iaj5ma7vNzSA9fThAMKlQkelKLazhYx84uXmlQWZxn8PEYLH4xJ?=
 =?us-ascii?Q?mzWTOLXLPmoImoJtJDcy01Xw2I5x7290vkcK563YM93iYiThqJqKyW2CBrAR?=
 =?us-ascii?Q?9JGSZI7xt+n1iD/9HWvxp3j0KeunghAXu/b8AGXQTWSzchfXWLc5gsK30jfF?=
 =?us-ascii?Q?bizqw1sM/hJ4e1YosRZ7rt8pawFvD7PS2/P3d9WiJ0tPAr+1mKQgejbn8Xhp?=
 =?us-ascii?Q?xJJMFyCjgCc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(7416014)(366016)(1800799024)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zNawmNI0Gk22mj3W9zbLZww774NHqO/ILwhPILRI2FkR54nMuTk0ugYV8Lvy?=
 =?us-ascii?Q?kV4JKTgUDlA3hx47HsVuRWtIzm5bx0F19WSchzuicJ174fXpEhkxnzHYUet5?=
 =?us-ascii?Q?tjPLBkNMzX7CDrjfptXH5OTfB3dgbZA7rX9faFLra72DscT9lxpkzPz1cBCH?=
 =?us-ascii?Q?XwBVdOKwvipDVc9ZhNlXXScabm1+MBDRislav98BeQntg0lf+cgBfKJUnMqH?=
 =?us-ascii?Q?ev5AG9iGiXoJ5wWUf+r86CUilaojaW3g9NyBm31tPPrLk9soyD8bBISfui4W?=
 =?us-ascii?Q?5X+hS/XYBvy92O57bCF6M14SJxIyuh93EYlVRbUUaoANoDCOCI2QGWVLvATZ?=
 =?us-ascii?Q?gGj33hYdCv8c7cBr7Zk0pfZRUb90w67BT2nnYo8SJ4Fprju+TS4qEMQyR27N?=
 =?us-ascii?Q?Y36qGrtAa+TNombtASupW9vQDTq5hR/YW6UR/zRskciLqa9K+DEM4QHLBZcM?=
 =?us-ascii?Q?c24XqXG7XzYdMqmbhG3cNWDwEIjQD43/BvisfbcDPd1ZP6NcIxx9J6rW5wRx?=
 =?us-ascii?Q?LQiaWeUqgNwBOp+/KM3AfC4z8EKdh96PJJ6A1h0f8x5aK3MQ94pbExCs1Qb8?=
 =?us-ascii?Q?xRPlx8XYtFmKgMVym8iQtnpaoOSg+GB0R8AO6Sz2UJe3B1MvTk5v2sWDMPXf?=
 =?us-ascii?Q?2SvmY6D5zDgLe/U+fvDgJOak35iKwpnRvBRoSRsazfz1PJQg8ROEhtDyGOxe?=
 =?us-ascii?Q?LL95VahfwlUhVVby6LO/dss9/9kJS6kuR2vamhudwruvSqhpKyqhY64ixI9I?=
 =?us-ascii?Q?fJwEcnANs0VCFoulwI4Z9Lc8s0Td266dUQKL3pIbufP4vJswQ+hk1py8yDqw?=
 =?us-ascii?Q?GDwKF8yuGBRQahIrr3OdcTVVsnsqfcnEhx6G3+lhBpjtj20sOtvugeF7vzkn?=
 =?us-ascii?Q?AQxyaWgS39j3vckjfbLdmCC9M6uYiVmML41tB7lfdyfSXWLQdchoP9c3BogG?=
 =?us-ascii?Q?kK5tusE1D5eCun3jCUbYXsHp5Q/ruhdLx5SgjQVHVc0uGN8f9EJ8THE3UwY+?=
 =?us-ascii?Q?3lvEEn2mOe2B1c0gI89EJkhXdQ3nZ99p+HuRAdsVwwsOJLjvKj7EJWhVaI01?=
 =?us-ascii?Q?Gy+eD4gonOeBHjp+MVdw8B2yWmBWD5Hc+RNcluaBkGnAuIrnAU8qhVZv0SgD?=
 =?us-ascii?Q?QSs8lkDT3um5azWb/U88q8NTlYKQynqQ8QTJldse9rACXykMtMHiNC4yDNmC?=
 =?us-ascii?Q?6CwcVIW6oGVMQV34dvXzQOyGvTELJyNXJhsNJ1ea6A0Sg6obPqOkMq2RRz7m?=
 =?us-ascii?Q?mFJRO9+2kgW/DvbfyCMZp+KVwpR75Typ+68JAMHY6MoIHKvD/XeAf1asj9zh?=
 =?us-ascii?Q?xCh8zo0xHLDKbywbKU/FbkfZZrPPHHzrfr/MJEsROJQ9zJ5o9kQr2tV4YlcE?=
 =?us-ascii?Q?BxO3t+A9N4W8myAQU2rn6bM7YxQJKOd4hIE9sWqJcjFSB+U+7JSbV7LBTvhT?=
 =?us-ascii?Q?3+sKbxDZISR5zNbBxCqNiBqfDWIQGIE7iVUR0At8wi0fRctM65ofCMRHqBss?=
 =?us-ascii?Q?xN4YiDOK19GFzmpnvyY9HpB0awWnnii+gskQZGwFr9MfDNqb+EMMSBJpuuQn?=
 =?us-ascii?Q?j/Ku4F8nSUiLxcOuEtA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87713b10-cea6-4dcb-0d23-08dde52d028c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2025 05:46:03.4944 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d+fmv7gy8ZcZcnHNmORIoZVNvafL/koriAI+7D/L+Rs9Objw54igEtfaVS/K9/PypdFVV1PFZA2xQgjLafm+Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9927
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

> Subject: Re: [PATCH 0/6] Use correct LDO5 control registers for
> PCA9450
>=20
> Hi Jaehoon,
>=20
> Am 11.08.25 um 15:11 schrieb Frieder Schrempf:
> > From: Frieder Schrempf <frieder.schrempf@kontron.de>
> >
> > This is a port for the following series in Linux, which is already
> > available in mainline:
> >
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> patc
> > hwork.kernel.org%2Fproject%2Flinux-arm-
> kernel%2Fcover%2F20241218152842
> > .97483-1-
> frieder%40fris.de%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C51
> 6d
> >
> 65c0706c4d71292d08dde3b31d9d%7C686ea1d3bc2b4c6fa92cd99c5c
> 301635%7C0%7C
> >
> 0%7C638917080648452454%7CUnknown%7CTWFpbGZsb3d8eyJFbXB
> 0eU1hcGkiOnRydWU
> >
> sIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%
> 3D%3D%
> >
> 7C0%7C%7C%7C&sdata=3DneJx6WZU4iZWjSUcsnzOVQvFiaCTKLChE8srEx
> 6cwEQ%3D&rese
> > rved=3D0
> >
> > This aligns the PMIC driver with current Linux and allows to use
> > upstream devicetrees in U-Boot.
> >
> > Frieder Schrempf (6):
> >   Revert "pmic: pca9450: Add optional SD_VSEL GPIO for LDO5"
> >   pmic: pca9450: Fix enable register for LDO5
> >   pmic: pca9450: Fix control register for LDO5
> >   pmic: pca9450: Handle hardware with fixed SD_VSEL for LDO5
> >   arm: dts: imx8mp-data-modul-edm-sbc: Remove deprecated sd-
> vsel-gpios
> >   arm: dts: imx8mp-dhcom-som: Remove deprecated sd-vsel-gpios
> >
> >  arch/arm/dts/imx8mp-data-modul-edm-sbc.dts |  1 -
> >  arch/arm/dts/imx8mp-dhcom-som.dtsi         |  1 -
> >  drivers/power/pmic/pca9450.c               | 22 -------------
> >  drivers/power/regulator/pca9450.c          | 37
> ++++++++++++++++++++--
> >  4 files changed, 34 insertions(+), 27 deletions(-)
> >
>=20
> I saw that there are several patches on the mailing list for
> /drivers/power that have received no reply from a maintainer for
> several weeks (see [1]). I just wanted to make sure that you are aware
> of this and kindly ask to have a look.

I could help handle that via mmc tree, if Tom and you are ok.

Regards
Peng.

>=20
> Thanks
> Frieder
>=20
> [1]
