Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF438CA0FE1
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 08:28:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B19F81E13;
	Mon, 25 Aug 2025 10:28:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="f5BWQgRe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 915F6828A2; Mon, 25 Aug 2025 10:28:38 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53C76808AF
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 10:28:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDae5GX4aa90tz3eiwWNl8L9zwdKx9MRdgjAsrkLoRqt/n1R6EEk+0fGij5GrAalk2Ej4WQW6Y3XbiOFA5ukXA4NjMxWTAjQfw15bbjeeyaJAScLvP/mBBYfkpLQsA9xIYNGDe/A3Xa6JY5g1OQwjPvLwfE+73vNyOAjnaxD2QQTMg4vF5AEzO3L46s0H1VeXl14TQN5UQhjjdRLGRzpK3AYswRy1TY47P4DmaKBblaRymep1zVhidikPEqVnQ4WYtEDxW2YZPa2piCEN2Sd9sTjqK6SrVfwhmFIozqdnjiOqUiCwcmTeYbZEjGuUorM+rj3Me2BpShaymVdK0aIOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ph7mctsHfUOEBlJxgRjPz9lMJe++W/JFXVJbuIpA+MU=;
 b=K+piLDPV7JJ8KNs40CBzyuoO/oh9+2kU8DgYNaxSqQnCOgd9WYdkfnTmNFl5NPAr6vq9DkYDT56ZwlaIKQsQa6Ax0SVk34zQZPUCjk0jUV31hx/720LQT5RL2d+EfjYksoUxLFafPpYUoxyiZM4JPCFqaXtsBioxJLGJAJdznkXkwcVLowVSEVF6vlC6m3h1cxpDnXftK9gJrJjCcjPzLe1CAaoEBLQXMMi/sRn615YC0pjnm9+BkPNsZdmNa807/BETQMIdU3/0tlr/8mTxDnf44JlId57JM9k+2urGmjI/BxSHdJcjkQfZ0pmHi86BT3FduWd/3CWXQPFxZxglkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ph7mctsHfUOEBlJxgRjPz9lMJe++W/JFXVJbuIpA+MU=;
 b=f5BWQgReb6MZaT14PSgVkv+p0xiwg0Waryueeqvcy5xc2vC2tVVrzzotTzGozg9FQb7JygB5RWiHfBWIrX5BgzO2FAT3FA1KsTP6oF7vYMrh8W4ruBkwsjUGE6kS6Rr8gqMxW1EVXguTiU+JP48As7CZr0M7wrbH9sIkEZYRR/0T52efKYBq0wJfs1TGcsA0uf8goG+9CyJNMvS8QVL5+ZLpuWVhvZYhcH3rl8MQ7M/fQ4HPWGrlgupQIE4iDx6DVNKZPliOgWPpvE/6z6RHdAFDSFEXktG/aFNV8MLDixbvPakFjzcBczgAnH/92W8KaeM6Vb4NUZ7JO+PhAvFGZA==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by CH4PR03MB7724.namprd03.prod.outlook.com (2603:10b6:610:244::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Mon, 25 Aug
 2025 08:28:32 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9073.010; Mon, 25 Aug 2025
 08:28:32 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Lukasz Majewski <lukma@denx.de>,
 Sean Anderson --cc=Tom Rini <"seanga2@gmail.comtrini"@konsulko.com>
Subject: RE: [PATCH] drivers: clk: agilex: Correct EMAC clock source selection
Thread-Topic: [PATCH] drivers: clk: agilex: Correct EMAC clock source selection
Thread-Index: AQHcEMMGMf4bQUpr50S3f5X8k+adb7RzEo5A
Date: Mon, 25 Aug 2025 08:28:32 +0000
Message-ID: <LV8PR03MB813799171F17A527BC37322AA73EA@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250819043743.8000-1-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250819043743.8000-1-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|CH4PR03MB7724:EE_
x-ms-office365-filtering-correlation-id: 61b1f5ee-6317-40a5-eb7e-08dde3b16075
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?k673ykRFJrOEW/Qlyfo7BbzaDvRrahacZvoNjp5S5J8Y1j7MKQqJPy/O1ycq?=
 =?us-ascii?Q?Ror3v9M20E+4zXzq6KYElPlYLWU5PRdY8jxXqPNyIzUo+PANgfIp57wp5XfS?=
 =?us-ascii?Q?wpjf3vvpuHpjg/I+BLOCjSKT7o2fFjfJ6dRAfrdZPQ9sjNu6He+gW8/SnbTS?=
 =?us-ascii?Q?bgLD5N42Bqt4HWtHHsgcXG1XpfTb2HBFRSbyEqTtliTYTtm0kL1zDGj4siCT?=
 =?us-ascii?Q?zBR05bVn8hz9VclABZDWZqY91wTVbmUCpaGKM7/klc6/4jq5ouNKxrHQNEsL?=
 =?us-ascii?Q?DtFAdz8famwfOSWtkDoqn+Fg/EMoQjgpiyjpHHIiyM7UKgQ2OItGhv2uu9cL?=
 =?us-ascii?Q?eE1qGcBvVt2z93O3Ov+z3tTZOx5j55rNQyaT7cSGr1+lK1Hp1lpFTNc3n+c9?=
 =?us-ascii?Q?wp5EY49Bkmd4Hd/X5a2i3XwqCKrm580fclQnP/s4Olp3hSOZA0CrGzQKWZ5p?=
 =?us-ascii?Q?1Ctx/yWKE2bePEqrwqoodDmPmNI+PX5KkMxPYyk4A9phwDlmYBMQX/pNA5C4?=
 =?us-ascii?Q?tWQN5f7Eo0xa0ux7WWjNOZkYwnMTqJqUqjZy3psQ/Mg+Cv5sWmXr3Ws3givA?=
 =?us-ascii?Q?K6gzkAVfH4CfRZY6SqXAhPTV9yvYKAU9JYBWagWpIGRy6bgdtOc0jI632125?=
 =?us-ascii?Q?cAubEoAXTK+4GggdCZ9tjxDDdeJSdtGRM01Z2Gnwf7BV37n3VxJW2xvdM7+h?=
 =?us-ascii?Q?5TZBULIL4WPe86qnk/KpZ+WzU1Xnlk59yZlJFZ/SfuQLBGP4kR5E9zSM9+jb?=
 =?us-ascii?Q?hKwPqxwDixDzlUARelx8WLudBCEZO8uPg/DZJ4mFPlWBlJRypiRTe4BxKFZ6?=
 =?us-ascii?Q?Idyn/XDTeMNuq5RHWh0FvIk/0QzoFKa4DJVkGz5wrM/HeKe099uX0b6arrGC?=
 =?us-ascii?Q?DDrZsO+wiQIy7+jSr7CgN3P8Xh4PLdYyH9DrpGZQvJHPlCCzlmlFdnnHA5v3?=
 =?us-ascii?Q?wu2nqULb/8yvkzDbXynkBLw4CGBt/75n1m5o77aX/vUNajQtjXo6a8+veZzy?=
 =?us-ascii?Q?A0Nl5H+MHSGnXLAQ8OI1K5w9yiiCwMvurlamW+/wkRktjrMN26ntSAecmBWr?=
 =?us-ascii?Q?WFECwAxuGnVz8XCjWtgWByBQtbi2ijd8CFxdTgMRie0YFowkaQ07nrVVsSko?=
 =?us-ascii?Q?4haPLH/tTLzSx4H4hBKuzc9cJg3WxUNs/klsO8xa5GM8LaMKfkpPKCzdRTm1?=
 =?us-ascii?Q?yGGFDxgkBcqd53QvhHgIQNJ5+pA+xmWZ+Fa9XFYVA88Q6r8BlEkNQRZcbbbH?=
 =?us-ascii?Q?CR5wr+vIiDRWr9vq30wfqQjkau7SrOCxupMsi+qAeZCOff96WJai0QKC2zII?=
 =?us-ascii?Q?WKy3ukB1S8m98+XXqDKj29twFGwTNdpV3fOo1m/Q13/52ZaA46Yzigj8Oeyu?=
 =?us-ascii?Q?/1K6lK+H4ZdrwxVdGb2D4BEpcI/RMLCm6IAm7BZSnamhXoe1hkS8e4Dr+tkq?=
 =?us-ascii?Q?0rPho0ZxBPc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(13003099007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BuD4m4LDXoo/AOf2Zye1jUPeeGGBQ6w/iprVpahdcx/YaSi4fDfOsIWtjZys?=
 =?us-ascii?Q?0kFeFtt3wqyBsIopbjUB3uDqLTRZO5Dht5Nq/b3uF4ZOU3dMcnbrW+IjkUJY?=
 =?us-ascii?Q?HQzPtNBBw3snjdpsIQSf/355Q/EhR78Eyxmbam1khR43H3TeCf0rj/iforzZ?=
 =?us-ascii?Q?Yjrg+BPWVTZDjxEOq7XZJ6sVyKwZ6qKBpHBPLWsFuM1C5tSjdTI3hDp5DRXm?=
 =?us-ascii?Q?laJkEImmKectdzwbCryhuarZQXHNojRkCakAhp//HEIgSwBc/PDKConWjQo0?=
 =?us-ascii?Q?y+a9OHyLuuy7oN0Y3PhgC1Au8xYHnupsxvREaKK86GdiaE6eqm0temo0/5Xf?=
 =?us-ascii?Q?kClma+j327fJB2tPk83rrj3iYhf4xPtyVvY9gwIj9N6eGi2hh4tZkvpLoUZ3?=
 =?us-ascii?Q?vINyTfOT26XcHKFbw1QzISMyJj+vCjti++eG3y0A2gPAfvJrDd9TkYzf9l2T?=
 =?us-ascii?Q?p4ubsPR/jNXHxZdx/MCONwpuCiffeqHtCIOP/qkSNiYnXeHqFOSiMtknZgBC?=
 =?us-ascii?Q?cn4N7FOw+jdwAqLlq8OAQU+O2laxFJ/7jnB+YM/9ZC1OL7VTieLpunhElTEL?=
 =?us-ascii?Q?JA72D7x+D+ylFOKYi3pEWHxnQ5XEpFzbQ8Dknuc3LFQuEXNIy4fmSEqCWPZL?=
 =?us-ascii?Q?b8TD/gytOcFI4UMRfsvwLFFA/RxNW74FaMlIs5pVxgMj2mpui943dnfK3KkM?=
 =?us-ascii?Q?Uaujo/Wa/EEzpV4PF3VBocdlOBb6owbi1DAo8O9/7EjSgPgFsGBlBhJQqjKX?=
 =?us-ascii?Q?rzTQAHYs7gxEo+/zj9GinB5qQjwGjzHx/Qcu3sGova7iQS/O4zQlZk925EeN?=
 =?us-ascii?Q?aE6QHI08Fg23rQAidN7RqnFD98J86v+x9c8Y2e35fkyM+MEaD2BV670/GrmK?=
 =?us-ascii?Q?qaqzQaDl6OaUqTJpkROnVsxdOskQcL8j7evM8wlIcLXLiGhGy5vYW/m4SvYq?=
 =?us-ascii?Q?4XkaZbUoK95z+4DS30Ol3WSgs5wkAy7SinWKNDJsO3cjrYVpp96Sn+TZ+IY/?=
 =?us-ascii?Q?x1IRstj5ml25RsaGeytxLfSGdmVU5DorsRi3dlE4MxogB1Hrmy/0fMqd6dYb?=
 =?us-ascii?Q?RHBNg/NcAEH39Hj4JvinH10N3jBSNtZ0jvXtMcSXRHlO98TwQ9/mNk00NuMx?=
 =?us-ascii?Q?ocAQgiedGzgNdDPvzG6f26CrFiSkrjJ2vN39Utqz7F8eEuOx3T0RzzqR4Sxf?=
 =?us-ascii?Q?LzCaVNlh2wiJEz4uI2PSQEk+eTB020gj70MlN724CZWEfblAC2fDTmPp9m+C?=
 =?us-ascii?Q?0Ut7/HnHvcNAj1iZZs8d5ZKgf0D5ha93+sRZt8riSY5jf2AXLLb4WqRHWqEp?=
 =?us-ascii?Q?vApqYeKwLj+Ll8CWRR/MJfm+KSGXYPPSVG+4b+CT2Zh0ww5WA1tDO+FzARom?=
 =?us-ascii?Q?UR5lS8z7aARu7DS8E2ZpZDLGAErBe1717IGGaCmkaWKlPV4bxlHum8qwA8Kl?=
 =?us-ascii?Q?7PYLDFJFRCoAJtrzZYNNPhDtalSP/iDxwu/dkLTUU3PlXsTtmXULsY/934f3?=
 =?us-ascii?Q?+u6lEX5x7lFNORBO67egwSsp6oUu1v3eBWeheHWwDq5Fc3xMBffYIZnyo/i6?=
 =?us-ascii?Q?bt7f3Yn2JrjqINn7Eq1xOtkOfU48cG9XgHUpYNqU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b1f5ee-6317-40a5-eb7e-08dde3b16075
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 08:28:32.3236 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ffx0Mcd6HHfLYJff8DtMX+c3nn+xrh8YGfmJb2cTimUl04faKkPhrDV4mmwS5YLYoNfD6vIr1qFJR+lDXjwoYYJXmRUwpeplVXte0fqqEaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7724
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

Hi Naresh,

> -----Original Message-----
> From: Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Sent: Tuesday, August 19, 2025 12:38 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marek.vasut@mailbox.org>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Lukasz Majewski <lukma@denx.de>;
> Chee, Tien Fong <tien.fong.chee@altera.com>; Sean Anderson --cc=3DTom Rin=
i
> <seanga2@gmail.comtrini@konsulko.com>; Ravulapalli, Naresh Kumar
> <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH] drivers: clk: agilex: Correct EMAC clock source selectio=
n
>=20
> Fix the incorrect bit masking and bit shift used to compute EMAC control
> which in turn is used to select EMAC clock from EMAC source A or B.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  drivers/clk/altera/clk-agilex.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/clk/altera/clk-agilex.c b/drivers/clk/altera/clk-agi=
lex.c
> index e1ddd02f356..967d8a41272 100644
> --- a/drivers/clk/altera/clk-agilex.c
> +++ b/drivers/clk/altera/clk-agilex.c
> @@ -1,6 +1,7 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright (C) 2019 Intel Corporation <www.intel.com>
> + * Copyright (C) 2019-2023 Intel Corporation <www.intel.com>
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
>   */
>=20
>  #include <log.h>
> @@ -515,14 +516,14 @@ static u32 clk_get_emac_clk_hz(struct
> socfpga_clk_plat *plat, u32 emac_id)
>  	/* Get EMAC clock source */
>  	ctl =3D CM_REG_READL(plat, CLKMGR_PERPLL_EMACCTL);
>  	if (emac_id =3D=3D AGILEX_EMAC0_CLK)
> -		ctl =3D (ctl >>
> CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_OFFSET) &
> -		       CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK;
> +		ctl =3D (ctl &
> CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK) >>
> +		       CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_OFFSET;
>  	else if (emac_id =3D=3D AGILEX_EMAC1_CLK)

Using FIELD_GET()

[...]

Best regards,
Tien Fong
