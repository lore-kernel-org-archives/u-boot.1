Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F73CAC5A7
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 04:22:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA07383390;
	Mon, 22 Sep 2025 06:22:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="a7c5K4DN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4607D833E9; Mon, 22 Sep 2025 06:22:30 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 373F783211
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 06:22:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTAH5CfABf2T1sA1OdipqTYpWKGhvSioKBCQwTnBy7HGXKf2iDCwImIbNtbFNx4ZbvcanXrfKpTano+1rTxWeocTa+bEp4a4UA+0t1CdcKh//AQBXsp8r/NsQn3k+MeJBxtVnyZCLM52NIceGw9BUE+0/ac/Q03L7DTT1XlkKm6EjU6ktkwtsgwYevRiBSMdXq4LuPRcKwt4TgqWRMfFS4iBZZFnVNGQ7V0XBde/ZbjXjzr0iLXPsLW27Whbg9JIVSWCD5XnASZE61bfeCdmSb99sebutreEZLEMGrrkLBpkCnwFtvnosQonP+Gc8yeztqvRK5sGq4vUHBi0iHk15Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USgyTyp70FJhWhFu1k5aDbtUxCXAxGPyHaeVISZWjvw=;
 b=nAImeG/n+2zsemwSDW1tRXVEH91LzBYLevzsJWhpY63s1taeW79seRI0r8Ac03kB5GgiWZI7AlgYG9Z/ztckM9QhdhwUwxaqjbkKXNiDsZKg/sPdLXSl59W7xpOBk3xfZAMBJE6ISE1zbrhnF69YNktoFk180R5isobtxeag7wfVmy16Ktg6g6dK6HPJv8v/0IbpDcAov9r3AUd9NnrNvD4rXUXtgkx0rtPCtlxzSav3J29toub3bJ44fu0R0u+5BxNpgFtq7TDloTpJqW/8AfW2zLad60po8mcwgh14MtCR78UYvGWho0O0RLekAy3HNxuFnRwhzC2r/Bh9Lu6SGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USgyTyp70FJhWhFu1k5aDbtUxCXAxGPyHaeVISZWjvw=;
 b=a7c5K4DNZkgldg44VvVIV6gHgbR+iBwBEyG4wjznVDw1Q+Nzh+PXCNTTQKFNO6XU43L2z0vrb5Zu46EGMlQ0Q4fQwoDi+QHa6OcnBuL1GRWkAur6D3Gc1dFbpTgS/0YsVKNR1OW9cfIwsMj7BOs22ZetoHhZoacdMV4qISmQ4Q+yvO84jz1th4C5+jkJgebu3mQXeirXXw86wZFr7RxBagZ0h5oGwb+kv1YbpfN/F72Ta829B43Ga1tbN1XqFnFuY/xLa7PdwPupT4TjlVZYAlsCHQ3L++l883K38g/pam/FWUF1tXjqZnljv/bHGN3kq557qOQas3MqiA6EUm3kiw==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by DS4PR03MB8132.namprd03.prod.outlook.com (2603:10b6:8:281::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 04:22:25 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 04:22:25 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marek.vasut@mailbox.org>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH v3 2/2] drivers: clk: agilex: Use FIELD_GET during EMAC
 clock selection
Thread-Topic: [PATCH v3 2/2] drivers: clk: agilex: Use FIELD_GET during EMAC
 clock selection
Thread-Index: AQHcItvnrbOfihyQP0iHJAUT+CJwGrSeqx8g
Date: Mon, 22 Sep 2025 04:22:25 +0000
Message-ID: <LV8PR03MB8137E07D2603ABF7A6225BA3A712A@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250911052112.15383-1-nareshkumar.ravulapalli@altera.com>
 <20250911052112.15383-3-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250911052112.15383-3-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|DS4PR03MB8132:EE_
x-ms-office365-filtering-correlation-id: 87563d3e-7a8e-43e5-7d8f-08ddf98fa231
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?loay3NMT/fTV8KpN8/bXh635ycGxM1I0DDaEWdWVWdtfRDxccX4xqPS38EUg?=
 =?us-ascii?Q?OWKl4ja18w9hu4b66OfKEauTibWwXnAmEtSxWAD6Q5HGIfc5Cjn6GnR121AF?=
 =?us-ascii?Q?4GO26tmt4oc50GbBhh/r5dNnXQFFe8wyoMog93XmA+5qpp8QbNGKup2x3PHK?=
 =?us-ascii?Q?wfN4Zvavde0E7fF+wFRw2d6pTUXFJPeidXIGH23Fx1iJ6duuc33GcmuV4ZQF?=
 =?us-ascii?Q?/4hS849cym5aeC8dGwPHLtcNOUijp8MtjRCtPdvfzR06xQMkwn5G112hYTtM?=
 =?us-ascii?Q?p8HupLoREErilTj77D3VWg16p+sahQBb5Rn6Xl1KNb4MItLRtQiYjYewQJ9C?=
 =?us-ascii?Q?AENJ4e+QDQXMpaq8tZ64NQLq/AI+sj1JtE+hLCF5NFb782Y9WCFU0zDzjdHs?=
 =?us-ascii?Q?BJxei9+J1xnIU0fD8DTjFyaWFGaytvjLpFxI+ylZ/UT8SPSeVg/1cA5HF6+K?=
 =?us-ascii?Q?cTtty4vKLn7FyMPODb7Fw2diAFr7Xd+Xdbs6UA8/QSFaIC5b65nkQfO1vgiV?=
 =?us-ascii?Q?keANJmkZYL7ttBOylbSLc/53g4jO7MDdUHm78cSQfCtHH2TX5SJoXkXAxocA?=
 =?us-ascii?Q?a4bpXpy/eckE1GpgYBuJzpj7j0Q9VOMzFBxNfTKFH6tN1FsQBzw/+r/QWnof?=
 =?us-ascii?Q?Yi0IWB0w3NkKciuIWrrVZwN4MgjuDaV+9HOmEZyL4NhMNUdBYs2i8SA0m002?=
 =?us-ascii?Q?LbLhW4iQ4F41Sae1M1bKDDniMXdYV90qGVR4/vlBsL0bEKhIiVpUnm7tNXGd?=
 =?us-ascii?Q?uL2x6cqDL4yIFMRxg/ocHTVqIjLcVZPD+D7j8ga/lDTISvC+iwAUIGw02tyA?=
 =?us-ascii?Q?duYk0O7iagemlqVGIFUFQUz9leNTyDFC5xUtwMkZHKON1vZuJ83pYzsfOEEn?=
 =?us-ascii?Q?SvxIw+A1LpMIhnX2qNZmPKEDksEi2tHu2ET2XQvbXaOow1mL+WXldNDlONTC?=
 =?us-ascii?Q?qVyet2yibKONRzFYPuss0PZgTraGznt+SqVURfMsRrYf2J+zo5SUDJEKAmiK?=
 =?us-ascii?Q?/VzWiyCeDIzbUxpvp2rByRVkscXmvfzsuc1U84fsl3Ve8Lhd+qe9dP3lAbj0?=
 =?us-ascii?Q?Q8Hxy8NP99EP7uyE6ugvsG11a8ZTjY2CjI9Ye3/NVMtviLAGAuggI7jlcuMK?=
 =?us-ascii?Q?eHxz66jWSsQn5psQ+vbU/6Bn7l16JM314RzSFXd62jNcAQa/4Q0iSZDt36IR?=
 =?us-ascii?Q?iGbbHDOvJum9FctmwVpiTbeYgZ6G9MiFO/TKxwu7IgeqFUukhRyBbdHkix9/?=
 =?us-ascii?Q?ybDfOwjVyDy1ed0Bjg0yp+qGGki2vVxQZ+SJQN91pGX2RyE4Bkp2fzRQflII?=
 =?us-ascii?Q?EiTQD1oPXGmXj8/4KLqjW22+Eeqjtf4kmqkzy94OGGv2Pbl3szfvgxUN1oK/?=
 =?us-ascii?Q?F4w+rihyurDbUVUoHHO0MmSyIOTFm36kTozpHy6Syvl627GPukCJGHSi7ror?=
 =?us-ascii?Q?whzhG+TUdYRlTun5y3+a8gOdLDW3/Y7aEezspW+tJEyZUeCwiEw8qw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f6NXoiwtCr4yLj6kBdsFBlT3zILNcdM0VPSh+59d5scjb7KBJkzHBxuSPfYj?=
 =?us-ascii?Q?i+STS5OLGtYTOrpvg4/oHmcdpYVcTEtCI5HtFfc9USBms9MGmOVxBQSGgxi4?=
 =?us-ascii?Q?kxKHSS7dVUPCj3cVoTyO86fgRaQJAkxteTDwisPXJpx6AsDXB033ICH2Lsxc?=
 =?us-ascii?Q?meAmGTRviVMiCnn8p/vidouLqcVdlhrwgRb1YY5UU/8C7h6FxqcymS07lyzt?=
 =?us-ascii?Q?Qe5lYhnOjkCxEnnSO6o8uFC5R1gILfqKrS0zGbtne14Ce176Pm7XIrt3hFK0?=
 =?us-ascii?Q?z2RDT2xwI+YubVVBSV8v0CE2G89nqGjZtZji+fVWS3HyP9ySM0SlGktojCov?=
 =?us-ascii?Q?eB0SMqkhZ3rvjR250nAoEMePY5gO3n6Z05XEYHycbL7hhMBs8JoH7DOxnYi7?=
 =?us-ascii?Q?fm38dx9gjhDqFnrmwMRT7tsjLvrbPwkeiN6WoMLElk/fQgswC2s4Hyukugb2?=
 =?us-ascii?Q?wa38RNhoMlVmSJ/tNv2u2GZgmvBGSJoaUcVLJQqRm5yPxbN2vprbNPuOMW4B?=
 =?us-ascii?Q?ydBagxA4waYnRaf8KGGY7EbZ9JUfkmo3uUqxGcwni9pEAT+bdTOXHUwDWNWN?=
 =?us-ascii?Q?+Bz8WEgSgyTTBHm+g5TvWq5YPmghfTJpW802lG0ttxR8VsGhIo3wGyDcKHOB?=
 =?us-ascii?Q?23WfFTVOREixMQtAA+7Btb+lCjVh9OWHIQ4OLjfHeMr9wcwFAeQzgOoj9IGW?=
 =?us-ascii?Q?Tfe8cpSkde9hf2U8+4WYLAXqMsIKPYMWWv4WxbjwinQiQ8KggzAEFYfofGQy?=
 =?us-ascii?Q?gSkp1XMvqa3lFgeeH2VAkECcmpjlvbCJFq7ItFpHmQYgyPVyjNh2vOqIUUnn?=
 =?us-ascii?Q?B8UQpd8OTr1p4CdRQyITb6UbXOdpez5kU+RLLjz83O3wJLjltzUXynL4Unwp?=
 =?us-ascii?Q?pDVOLFXNPnhiSielBJuSUh11jbDsGXfIBsQUynkxnugL8fWMwFjihBWNCjYC?=
 =?us-ascii?Q?YBT4ugU/aM63YcUpRoJGKBhaMY/CJwGHX1RCmnW4ISqo7qjLB4XNBLLtk6YU?=
 =?us-ascii?Q?YCe1MF3zAg6eO3jYffIsFUaOm8/MkfkqsehN0sJxjiO4yCjYHivtkjB5UWh9?=
 =?us-ascii?Q?Zb6d6TXtrw5uBJILelcmxiicMweEvcpF8X83cdH7002EOriEhi6AextPTonz?=
 =?us-ascii?Q?LvDlxyb48r1znulvkvayOGLLCxylSuy3E7+kSgSopttx2V1Ak08Zq9x+QNpJ?=
 =?us-ascii?Q?GkHWS3z4o7I//JShL9tD8qOoMLfWq9npcgvypMNReNiAFcOJ5IrFtWvHIeWn?=
 =?us-ascii?Q?585u7VR5yBlARjZYulBjWw+pz5T0GFkAyiDuC3ELkiHugyu/H8s+pwKPJXR0?=
 =?us-ascii?Q?0p/3gVTeMd05z08WwOoMYT1xwBQyf/tSMFlmjjswzOiVXzoV8YUriGBYkNbj?=
 =?us-ascii?Q?aQdKNL+rg6AzTtbfpmiaa+TJsrV11ohHyJdDdsZlqtSBx2TahUUAHUSefFxN?=
 =?us-ascii?Q?VaA1zkKl7IVI0qAtI1TL95NMxHEdK9p4yE2bg7KsbOteOIbcRVGcYmrOQekf?=
 =?us-ascii?Q?Jrf50IzbDkh9pJC/wWtnve9+H/oEYGvt4/6lwAZwWr66IMg4NWENzmne1piX?=
 =?us-ascii?Q?1ItRb8fvWDLKQkECBvV8ntOzQKFIQosiY8JBePT2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87563d3e-7a8e-43e5-7d8f-08ddf98fa231
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 04:22:25.2704 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: huEqQe2RgbzAeHOPxozshh/B5C4YyrfG0izR9MzlEoitwvI+ftTBQjY40bRXlg6o9Vuys3u7qEX2jQgvP/azjp7UtRxKIMnkBaCYAdKiry8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR03MB8132
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
> Sent: Thursday, 11 September, 2025 1:21 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marek.vasut@mailbox.org>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Ravulapalli,
> Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH v3 2/2] drivers: clk: agilex: Use FIELD_GET during EMAC c=
lock
> selection
>=20
> FIELD_GET() macro is used during EMAC clock source selection for better c=
ode
> readability and maintainability.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.c=
om>
> ---
>  drivers/clk/altera/clk-agilex.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/clk/altera/clk-agilex.c b/drivers/clk/altera/clk-agi=
lex.c index
> 16a37b962cd..6dff4cd9c74 100644
> --- a/drivers/clk/altera/clk-agilex.c
> +++ b/drivers/clk/altera/clk-agilex.c
> @@ -14,6 +14,7 @@
>  #include <dm/lists.h>
>  #include <dm/util.h>
>  #include <dt-bindings/clock/agilex-clock.h>
> +#include <linux/bitfield.h>
>  #include <linux/bitops.h>
>=20
>  #include <asm/arch/clock_manager.h>
> @@ -544,14 +545,11 @@ static u32 clk_get_emac_clk_hz(struct
> socfpga_clk_plat *plat, u32 emac_id)
>  	/* Get EMAC clock source */
>  	ctl =3D CM_REG_READL(plat, CLKMGR_PERPLL_EMACCTL);
>  	if (emac_id =3D=3D AGILEX_EMAC0_CLK)
> -		ctl =3D (ctl &
> CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK) >>
> -			CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_OFFSET;
> +		ctl =3D
> FIELD_GET(CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK, ctl);
>  	else if (emac_id =3D=3D AGILEX_EMAC1_CLK)
> -		ctl =3D (ctl &
> CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_MASK) >>
> -			CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_OFFSET;
> +		ctl =3D
> FIELD_GET(CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_MASK, ctl);
>  	else if (emac_id =3D=3D AGILEX_EMAC2_CLK)
> -		ctl =3D (ctl &
> CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_MASK) >>
> -			CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_OFFSET;
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

