Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE8BC3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 08:36:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ADF3884CC;
	Fri, 26 Jul 2024 10:35:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB6E387CF8; Fri, 26 Jul 2024 10:35:57 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20715.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::715])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EF5F884CC
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 10:35:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYklh68HNF9ncbonYCN74FBXCyAYbtXdRxLfKBAIf49Ee4LYqv58j1va1ueOj7NfsrLUPteyEQ/JLUnNFv4uyTbhvgiVHr9E2NdKlgbIm9FGwyu6HTMoC1THWYVvub2HExyy+53lMFZGY5rk7A51mvNEOIajFfw/ltokx6kn8HnC4qNjjGEpwJDvfUo6Bg1owQ+p//RFdpeKb91zHjYQDUI0smHTOzHOHrF9MMhITon4sG9OEMEML1X3OruhYOIRv4UBU1eVjR/deEsjMFo0cdm/i0eAm5q7zYJU8nklN9sYJgXgNwxsi+uUKnmZ00tACyQ9/1wbje/INg6rAFj3Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+VzXf1BNPcASADY7GKVnIZk+d22ufI84YvvQUZ3aYk=;
 b=ENuKZIIu4PIJzpaiR++OuiB5Jg6A7HnVT2Ct+poTdDyJe4AtQ+V47cEeREXEbJA+BOxJNczYKBEtjwL0i6yfUmlumzC8AlO2vHWBs1oD55GVP1H6c01N82wOQmsFPyFlHWyt8b2f17VxHLbAss9FBmvBZtUISYw9cUMxoynxZ74C/2CSlfIIAF0Wr4Ym7ktGHP/E/gttE+hQLvkRt7E+AAdgIeLC6q2krndnwllw3k19N9b7hNcBR4d0vuS6Gq5Aoz6HrgPk/66TtTH6PZhO/gSiGM29ETr4ZB4MCudXUiGRVYU9otvrhkvsyR6it8cMEELcxGQMYntQCB+57K0oPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0592.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.46; Fri, 26 Jul
 2024 08:35:49 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::bd9e:fb57:ebf7:9d71]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::bd9e:fb57:ebf7:9d71%4])
 with mapi id 15.20.7762.032; Fri, 26 Jul 2024 08:35:49 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Roger Quadros
 <rogerq@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Alexey
 Romanov <avromanov@salutedevices.com>, Sumit Garg <sumit.garg@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Nishanth Menon <nm@ti.com>, Rick Chen
 <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, E Shattow
 <lucent@gmail.com>
Subject: Re: [PATCH v3 5/8] pinctrl: starfive: Setup USB default disable
 overcurrent pin
Thread-Topic: [PATCH v3 5/8] pinctrl: starfive: Setup USB default disable
 overcurrent pin
Thread-Index: AQHa2XxftJB6J5MFEUO2rWpXlpSJCLIIuqgQ
Date: Fri, 26 Jul 2024 08:35:49 +0000
Message-ID: <SHXPR01MB0863CDB8BB20F8B851A0371BE6B42@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20240719013822.101374-1-minda.chen@starfivetech.com>
 <20240719013822.101374-6-minda.chen@starfivetech.com>
In-Reply-To: <20240719013822.101374-6-minda.chen@starfivetech.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0592:EE_
x-ms-office365-filtering-correlation-id: 78b2132d-57e9-4316-2c95-08dcad4df40c
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|41320700013|366016|1800799024|7416014|38070700018|921020; 
x-microsoft-antispam-message-info: 8ztxssPPivQlp79AX1FWllHinCUZhgmKndlcZRhhG6IQnDQPG7PS3HVZ7FfrDgMRjEvfU1jFQ88rP0MRVcqAHuEKxhelWRZCZkKtIA2aPdTnLsVvLYFebBqi3F4ogzYRoeiQMWTGksAvG5tRnY+/QjKgEIgrny+gmFnblpUf3MVht0Bubg0h25Fg4ojPOkDLalRJS0EiN3XOvNnEKLI7J1KEK3LQ8pK5T2HekII7C7Tz2/5Pqumsp8QLxjFmw2rGhWwtfepY4RhddH9I5yBG8D28/IKaHxvCCS9jpLlpY8V7/oak5UpQFzkIg4Wb6fetYHRFcF1XfLe96hM8FPtv/jMddOxRWQQRekfGc25GexRjhSMP5SQhfH/4Q0+B+e2o85UIDJl/ZXRYPA8ufBvAJIlE/E1zHX7M7P93OnnYdWQggfbTSC5lUAaaqD7j93rOaIP1nYHG306lQ2E+P/UOgE4YHYTQMcbbO+e1glLX3znr0seNLfkNJ1GCeMJglOHtyKNZQZoK1uaVBXCZD4BAY8LpMBlSgNIFI6GkM95QGclRaX0RQQGCj7ABe4VxAAxdMOYOmJVz/sCWJmLuy0y/Kv4GnlIda2ETaNdaeNvGVVcaz3rgJ0n6at+IZAnIxXsfSyIve++Ud/olvWqkJW9qeA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(41320700013)(366016)(1800799024)(7416014)(38070700018)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4qRcA76X5isOP/iNTzAWMqKjfLGK+U90owgyHUcJa2g1fPqnkQLynPHH+j2s?=
 =?us-ascii?Q?8lEGWsz+0+XnHPE3BYvPue7iWh9H+SpoRMYry8xaw64PyjLIyxEgDhLsmYLm?=
 =?us-ascii?Q?zb2j4+EG+RTybb5/Q/KEZhrSn7uiKt0uLE2l6/lmpLSo3guYk3VOeB9qq88q?=
 =?us-ascii?Q?f/eZhs3fkhqx9Xnq+RjBI3ck6zLOX3nyj6d+i/LEpf7gUQOwpKw58OCwVeHM?=
 =?us-ascii?Q?ShnDT2NHiKFKjW2i1/P+6IVmpIYKOQvXmZDTPkfkD5rt9wNZyMfWEzcaN/ze?=
 =?us-ascii?Q?Jp9ZD63sfSvgLHc/YE+792Mf2yMJGAySRMdRd/0TDyf8vin7UYQ7PWWYhdwa?=
 =?us-ascii?Q?b76KX/o9YESc8uBkKNwgdkH6oUuZ5BqqrTs7RMUsfYtqJNMzrlBfMqMWVRp7?=
 =?us-ascii?Q?lZm/4+xuM2w5qiAn81L7AsOmp14x2kok9ObGEbyfVkUWV6NUTCcSwwpmNjgE?=
 =?us-ascii?Q?TYX5ohVGXt2nJt2lrJrMETDviBE3crkiUDHAHonh7OD/2J8eoDv+KjZD5ap+?=
 =?us-ascii?Q?tnkT4p3VPkoffCnV7uZrwAQvguyZ8OGZ9dzXOVlZ+IiOjO8gP08nfIhi8/2W?=
 =?us-ascii?Q?yNo0+S++z7aGSNn9AW/8N8QYtlebF/7wa1RaOk+Y87Ar8+L9EYiWaPnlsS+U?=
 =?us-ascii?Q?9ENz7tgyml8kJSII8jgN8cJSG8hAoqJ7bk3PSEhR9U2WMEtCr3c5LSJGE7iH?=
 =?us-ascii?Q?102FDXAUyxC23k4cB7Wf2e2KZVsEmEKlKTz8UDV+3ACuC7md98dsgfWdn/aX?=
 =?us-ascii?Q?Uh376ulYnFCIwBxI+yNgtFJcKaVYsoPJQtaJ/95ebdd8AK3psC9+FgDxwbtb?=
 =?us-ascii?Q?hHAsK2P3XBgNqFoB4EL20H818E0eVpTyWpn77FLwEfgQJFEeGEArA1CrxjDH?=
 =?us-ascii?Q?4CcmK3Fmc0QghHAFXVc7cOKu27uNSMkYcUd+Oa5QL1sGWK6C8V0UXIX+Xdm1?=
 =?us-ascii?Q?eYHmmXMfb/3+Fv8gYQw4AqJ0cpbz82mbuZSq0/jpExUQ1MWNLJkvQqFtOTp0?=
 =?us-ascii?Q?d7DqOnySqq7KnIRbVRRLoaOnHKAql6+3dMC0k/uP2hZSsM/0K5Kn+OaWXg/b?=
 =?us-ascii?Q?pfAbOKmOcnVfdT21xYJATqa1xnteZf1cD3SXzKgkg1hvHQcW3Jl7lvyZWsIr?=
 =?us-ascii?Q?LPKmVmB9SXY2r33nv+PMB7kBGS3xE2t2J2znd9enrauEFkx64hM1iacCPAt9?=
 =?us-ascii?Q?lTUH5UXv6is3EwQj8a+4PShiuOSgjKG3cHXATW8cV69r5Hbp6clEnk3x185g?=
 =?us-ascii?Q?qGLglSiwPlvWBGp0UgPMQQ2o/QOpwgdweybAqLwL6MUlwlLW+FEF/TWGy3El?=
 =?us-ascii?Q?oIYC1Vj56DoefPgAB1KMo+rv4KiKI3LGEqXPI67fgZTiBVfYaDUFpbYDLJdN?=
 =?us-ascii?Q?aC8K5SuIsM5IoH5KK7VjtVQ7sVqRQIxpdgbjddBD/8doYtYZVfoBPyQ5Jq41?=
 =?us-ascii?Q?5woryRDuBwIxjm2gkFa9MK6TkoRXLcBn3y2S558gtvhoajvTmTpR1MU6evrk?=
 =?us-ascii?Q?KaK/TRCX9mXc2U+A0HLvGUgPUn1r82/hqtShaq1fokqRCCkBPI7K7yWOpHO1?=
 =?us-ascii?Q?Cr1zCF2Oeq7Js3Rc2j3zzsnXLP+2M7+4LRZygFQd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b2132d-57e9-4316-2c95-08dcad4df40c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 08:35:49.8227 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BuwMg2dhnVy8SHm72Rw340VfxEHLvz4bGz0fJfkuHNGTWetaQdyJZ27FAHHKKQiQ+xFYrfpMw6rWSa64FJd+Hs3IFl4r1Qy5Zc5gssn7CwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0592
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



>=20
> For some JH7110 boards, USB host overcurent pin is not reserved, To make =
USB
> host work, overcurrent pin must be disabled. So set the pin default disab=
led.
>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  drivers/pinctrl/starfive/pinctrl-jh7110-sys.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pinctrl/starfive/pinctrl-jh7110-sys.c
> b/drivers/pinctrl/starfive/pinctrl-jh7110-sys.c
> index dafba65eae..1102985ab9 100644
> --- a/drivers/pinctrl/starfive/pinctrl-jh7110-sys.c
> +++ b/drivers/pinctrl/starfive/pinctrl-jh7110-sys.c
> @@ -378,8 +378,15 @@ static int jh7110_sys_pinctrl_probe(struct udevice
> *dev)  {
>  	struct starfive_pinctrl_soc_info *info =3D
>  		(struct starfive_pinctrl_soc_info *)dev_get_driver_data(dev);
> -
> -	return starfive_pinctrl_probe(dev, info);
> +	struct starfive_pinctrl_priv *priv =3D dev_get_priv(dev);
> +	int ret;
> +
> +	ret =3D starfive_pinctrl_probe(dev, info);
> +	/* Set default the usb controller overcurrent signal. */
> +	if (!ret)
> +		clrsetbits_le32(priv->base + JH7110_SYS_GPI,
> +				GENMASK(22, 16), BIT(16));
> +	return ret;
>  }
>=20
>  static const struct udevice_id jh7110_sys_pinctrl_ids[] =3D {
> --
> 2.17.1

Hi Rick and Leo
  I think move this to spl is better.=20

