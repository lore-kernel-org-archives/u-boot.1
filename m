Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2258BC8303F
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 04:58:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 980328350A;
	Fri, 29 Aug 2025 06:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="WI0pqsX4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DED2683510; Fri, 29 Aug 2025 06:58:15 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::609])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B884083443
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 06:58:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/dC1I6AXSnqgZ/EjxakZP1CvZVzqdt8zlxsx3hW6Hjnd6iH+XOTw/3H25SaK0bi+ltm9UywbRcz80QonZM5iBHxKPeEoyizi8Dx1CfLA2v5/FrTjcemO/DDiBZnzDJBbZvGaoKHGr7eSdauYdbnR3CEgKxa4A+sfLxI0P08tWhxCh8xP+wxz8ynbFjNgEwdv4ugnMZ+7hOInSnHyg6bk9dBG8DmA8uBySEA0RLJ9wUM63Yjzb4dZbhS2cLYsl4dHvINXIrQZpxn37Udp0Vf+Jk5QwDzUQUrlwkiJ1ZwbRhGUP1nCTXpwmTTA9k5gTqlvcI41rAIHzgThX73MLa0DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11Vm4b5ZXcxExy4JgRv7vymclqmuAAYneVsaYv8SG4I=;
 b=IukBPLEkAh9/4LoxXjs6TYSesxD4a/xLbNev8MA9GKPypUFZp7FyVYVzMGVWwfj6XHYYWAYSZJrJR4LVG63C+OJnYkitncmLXYq3WUfifW2pNb0J6E6TflWnFobsMBRO3t/KsfNWWQ5XGtWiY6QJKat/Df+m3R3++PqLu3PTL5VosS3V3q9dG01xAw8HbBP8PB7SFQJsV02KVUd2Q/YiSeg120oPjEIa0jvT0MnMHIt3S82wTjQMDwk6yuvSbIUrJ44TWmhtaVoIUiRgc5uKAiAl3iYEjcI+rKzD3hWSgxsyBZjade4u7NyCkX9fS4zljaLcjq3yh21U3CWvHd1yMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11Vm4b5ZXcxExy4JgRv7vymclqmuAAYneVsaYv8SG4I=;
 b=WI0pqsX4gjUmj7fcohov5zNoCnDwa5N+fFeEevA2UpU6WvbYZzyee4gzQ1sjXgkMF6V82oDnRQwenf0P00Og4HBdYk5tRzBvUrFAgw6ib+mCvBLdKHqmPscLh0U11yKr4haGXJ9GxqbyPfUpTZwL0/oLgX2qryMwjy7lBEoD07aMtwbaaLXPEnxcbhlD66hziRMQaa0rI5QFRNAQ5IULFvDOVY1oLeZa7PqGuNnqUWuHdGMuNM7psPtikqxHuZydRxI2Q3pzK05C5G47xQJCXVCadbyHKhmXLmUH80POlmYhHAXNV0JmFCuBqu0QKs3nYit4Rwai4fQBTfvGQGTORQ==
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by DM4PR03MB6126.namprd03.prod.outlook.com (2603:10b6:5:395::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 29 Aug
 2025 04:58:07 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::7b6d:7517:b2b0:bca0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::7b6d:7517:b2b0:bca0%7]) with mapi id 15.20.9094.006; Fri, 29 Aug 2025
 04:58:07 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marek.vasut@mailbox.org>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH v2] drivers: clk: agilex: Correct EMAC clock source
 selection
Thread-Topic: [PATCH v2] drivers: clk: agilex: Correct EMAC clock source
 selection
Thread-Index: AQHcGCL23XsKlLa9x0WOwqpNp9cKcbR5Eq5Q
Date: Fri, 29 Aug 2025 04:58:07 +0000
Message-ID: <CY1PR03MB8121C31811D7EA295EE697C2A73AA@CY1PR03MB8121.namprd03.prod.outlook.com>
References: <20250828135152.8680-1-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250828135152.8680-1-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY1PR03MB8121:EE_|DM4PR03MB6126:EE_
x-ms-office365-filtering-correlation-id: 9776a4fb-4757-4ca3-89b1-08dde6b8a517
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?lSAKy2e80NVgH8acyligsVr2IX2F6CGqAPZsVC15eyq3HPPkginZI7dX9qzs?=
 =?us-ascii?Q?6o3KAWdUrNrn1z36U8wiVo2v8/i5Td4YyOMtuHyPwj8AxIuS9YDeh6rq6iGu?=
 =?us-ascii?Q?lrjnSeatRrNGYsZSeqoalp3/VknB5daWJfCYUhDSkNsBr4cut8alRzWrTdGc?=
 =?us-ascii?Q?xTjFzZq+8K5pZdrv/REZnC0q6uGGQMzSpIoOZ9Rtnj1BuP+nj7J9KnbNU32I?=
 =?us-ascii?Q?n37nQ8Do0McRPSxjpXCwiH0E1UfzOQ7BACMuHY8rfBoBxSZ1NL6qlNgn/rDI?=
 =?us-ascii?Q?cHRuG72bMEdXfkogjJiOLlPxJlgI7oKo0G34lYURMANAz4uGfQecGo0tilG9?=
 =?us-ascii?Q?Ij/BsT7dsXnxF9PMu9k5smVThZ7Fy+AnRHqPmzj6yqgF56iqyIQl9so7ql2M?=
 =?us-ascii?Q?55bI4eQM2FvPvxr/meD7h8fFw/LhqwvaL6lBfMwZijEacsfHrh98TSvGOfdg?=
 =?us-ascii?Q?QNgHHFlglgvawyfWmVLXpzT1KCWi+OqJraBSnu0+dCPpPSLVYQbBaCEIOPBK?=
 =?us-ascii?Q?WdLo5vRUT2HOXf+UmVhb0I+6zp1KjEBJiXulKaO5qyZT7VcQI8wEkbmDCXwh?=
 =?us-ascii?Q?/kZpAR9Itl1fJiesymZj3wBQyIVbxaZ3G+CNqGh17wJ/VZjw2cdOiA/krmAi?=
 =?us-ascii?Q?/nu+l6zvGYW9WygfML0LGcB4IMLRKKeCOjHTfgQO3SWCKr7aub6FykXdNzFF?=
 =?us-ascii?Q?5dxiisrqELXCfyDWttX4bbnCvYTCVgRl6j3EViIJVVIHVs/toFztkk+MXeGe?=
 =?us-ascii?Q?BZrwHMx3Ov7sWMZcIdfnTZsyE39ljyAiIO1QCPxNB6kfMNChdy5PORuRcNDd?=
 =?us-ascii?Q?9h6HKs93m2P5CBbxMku1nUyW4H1EsUuPnhOtlxaSe33182vNhnb+yDNLcfQR?=
 =?us-ascii?Q?qt0Gw8XobePhwpLRmvJkmQ/VxwTnqAC4YwKkSBYSKjbXDnnqQiiWvBUVIv5n?=
 =?us-ascii?Q?3qelbs68OSbEvJKoNM8qflGcO5PfWlq8ZEI6XfK1CxKo02bhK+l00gEj57Z8?=
 =?us-ascii?Q?RWPS1B76XOKiiqjrSFBcAXBaYMfW3lh/7uTE5Ep92cAGvBl5H9ekWWgVGyXI?=
 =?us-ascii?Q?QzKvHDVWjiz3yq/tdoWpTCyJEIlpgBCEf0J/Obt5e77EEOyUy6rmJ3FUA1RJ?=
 =?us-ascii?Q?yiB2tUOihRte0XsVyTFE1UbVVd7N2AF7cy018Zz2/K/VCGIVctqqaFdIZOJH?=
 =?us-ascii?Q?IL1TC64pLgyPFuN5ilVHe65gcsSexxzS1RUEEaPPR2bvPe2aRKhl0A1GGs5U?=
 =?us-ascii?Q?iyfzbtJKdqAj7reoMKO+z9GYr/v9duX62vNjwaSt+XTIYYOaX8IFa7VFOFJJ?=
 =?us-ascii?Q?msI4MfL30VulF4Qz56TOYhih6A0FlwlTxMbtVNt+xq9CXIePPEDZaemA9nYO?=
 =?us-ascii?Q?QqVA2RQdkAbo5ufae3plcy233yS7wHq6a0db+n2XRbDZZBgdebyuQRkqaw8l?=
 =?us-ascii?Q?uFW02m/BFqk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3e8K7u4ncDyIDs6cC6seRSEunvwPjnS10BweIK7Sr/119sjQBHRelfDXieZm?=
 =?us-ascii?Q?GwtHLe7pr/24M8MF3Z86atqIDnBXnBqUSNpZVXBTNcGCtaP8Ys/YHyXnbwfw?=
 =?us-ascii?Q?d0BD/4Me8ELUhU9+wafdYUpY8o0HbzVM59Zcr9ZFIEPY5Hjfg4Et/YPkxfMA?=
 =?us-ascii?Q?/k+OUFh6f8L0AqOtVjOsh0Jb9HRj19c6Qd/vgAUOABISIRFsgT0ndwC+INmr?=
 =?us-ascii?Q?oSqaComOPdOXG6uk4uETZGYfFYQ22d5+V/M+WqSnDiU+YXGg2tDY2qMrOPo6?=
 =?us-ascii?Q?XezO8EB8znv8EMbVL6+CJ0j7U8eLK76KHIlhvh2qY/dsj7JwQmtxfdqNRu/j?=
 =?us-ascii?Q?cQibWnpmtZs6X/4kLjhUcUPjq9W7hL8NqzQg1W8vY/LqXhfMx/o7uNapQziP?=
 =?us-ascii?Q?AbOOc9aH7FcSlBmlUVEtkdLOEw8/huGOh7+jdN/0cwoREhOYgHPqObXxKIXG?=
 =?us-ascii?Q?rX6UDArRYNdd6JomQnYdvatpGeNDxIPSMCMylkVpAsUgtb7CRDOFKyv/Pelw?=
 =?us-ascii?Q?nhEoxvw9CBdZHtYbOkyjNsc0SQPK1gQEKtlu1Pu9juupLJ9M/KDiJ9FwMsyV?=
 =?us-ascii?Q?ztnJ3OeWvl+b1KrBe5PN5eDbKP1FOyNav+JVuqkzhgy83Y5ryPx4/uJ/0aVl?=
 =?us-ascii?Q?lQMQwhIeVOutVeadbjOCH451naITzRSGZGSEhc3dIIsB2gZtILMOq9zDbZzV?=
 =?us-ascii?Q?CyvBCb+xrNq6viWQnqR6J0BzzgXDAbeiy5GgUzUbtuVKxxX3AYQrlpjeCzYr?=
 =?us-ascii?Q?tsH/PtoA7qvVNGpanTsph/Yed9edi7q4rBmZrJ1iUYqRO5Fy3VQ1Mwnj71As?=
 =?us-ascii?Q?uJla7rXSol5PM+d+5UrMM7dv6sNODPmk1xnEAYWdPjAh0rFwg9PwbqbowG/4?=
 =?us-ascii?Q?Bip+OI0lDPoPRRCqJcdaB+xvZ67XVkFwU6uFXDU0JABYNBqCfFCHwZ0IcJpB?=
 =?us-ascii?Q?chrHyQEywnP0IcxYRM0EmjMJXsb4jZsjQweML4z05UUtUOuNHZX2taMNxxeF?=
 =?us-ascii?Q?K5PUX01OdNcSot8O/YtYEQeqFcSBU1dujQD275yMLgoILdxBB0gyHv+EESKN?=
 =?us-ascii?Q?FcgqkAdpZB2j2v5BCePrZiWPSCr7wVEY/IrNw9kSk52wGMY6aT+rV5lq8F7T?=
 =?us-ascii?Q?adAhk2lCfuRw6P+F4nXqls3zs2T84Q34Zj0SjW7p/wXG9n5sXLfvHz0Z0rfj?=
 =?us-ascii?Q?4dXrVwRIbSn2/PqdcZibik/Ffo+A3mLMV5Zx01J20f1HZPOt08ht8v0/mhOx?=
 =?us-ascii?Q?M/Umt8LCK2mD+5LPwyQ29Yps8qyj6wPGhPS8CP97w5sakkE4V8fTgNeZ61y/?=
 =?us-ascii?Q?+xYINJ9fYF+nn8Y3Cl495teYfkN5A2btuQLkBGPwYn76s2ON4GGidZAjeSiG?=
 =?us-ascii?Q?clXEipzkhJzvdydd4gxICZlq/98ngYYgWmyoIcRZb7x/oTMyzzDjDVMrTA06?=
 =?us-ascii?Q?Bhah5YSQxXyhL/78ikjO7i5i0ajolYiO9xqnQOp2FhJJd3vaIeq/kElDION4?=
 =?us-ascii?Q?1IwOLKqq1yrhHG6jHlO8F3+NhhB+I5sUHALOxoQiNWTicYAlVVl9ugE/8SwJ?=
 =?us-ascii?Q?1jM+ccfYpWgTPq0fpfxYg/SYMQ7FWgsHk1wGodLB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9776a4fb-4757-4ca3-89b1-08dde6b8a517
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 04:58:07.4582 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F2Ks763GdZ1XX+7MpvKLy7zSLszvCQRPDchKJQEGm/gncIUE+DbegcSqRIBprn4NpzP9kZPF5hS3J6yf1q8TyUTAJdbm+scWFtXj8gBoZ4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6126
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
> Sent: Thursday, August 28, 2025 9:52 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marek.vasut@mailbox.org>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Ravulapalli,
> Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH v2] drivers: clk: agilex: Correct EMAC clock source selec=
tion
>=20
> Fix the incorrect bit masking and bit shift used to compute EMAC control
> which in turn is used to select EMAC clock from EMAC source A or B.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  drivers/clk/altera/clk-agilex.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/clk/altera/clk-agilex.c b/drivers/clk/altera/clk-agi=
lex.c
> index e1ddd02f356..2ad8cfd8856 100644
> --- a/drivers/clk/altera/clk-agilex.c
> +++ b/drivers/clk/altera/clk-agilex.c
> @@ -1,6 +1,7 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Copyright (C) 2019 Intel Corporation <www.intel.com>
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
>   */
>=20
>  #include <log.h>
> @@ -11,6 +12,7 @@
>  #include <dm/lists.h>
>  #include <dm/util.h>
>  #include <dt-bindings/clock/agilex-clock.h>
> +#include <linux/bitfield.h>
>  #include <linux/bitops.h>
>=20
>  #include <asm/arch/clock_manager.h>
> @@ -515,14 +517,11 @@ static u32 clk_get_emac_clk_hz(struct
> socfpga_clk_plat *plat, u32 emac_id)
>  	/* Get EMAC clock source */
>  	ctl =3D CM_REG_READL(plat, CLKMGR_PERPLL_EMACCTL);
>  	if (emac_id =3D=3D AGILEX_EMAC0_CLK)
> -		ctl =3D (ctl >>
> CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_OFFSET) &
> -		       CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK;
> +		ctl =3D
> FIELD_GET(CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK, ctl);
>  	else if (emac_id =3D=3D AGILEX_EMAC1_CLK)
> -		ctl =3D (ctl >>
> CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_OFFSET) &
> -		       CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_MASK;
> +		ctl =3D
> FIELD_GET(CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_MASK, ctl);
>  	else if (emac_id =3D=3D AGILEX_EMAC2_CLK)
> -		ctl =3D (ctl >>
> CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_OFFSET) &
> -		       CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_MASK;
> +		ctl =3D
> FIELD_GET(CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_MASK, ctl);
>  	else
>  		return 0;
>=20
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

