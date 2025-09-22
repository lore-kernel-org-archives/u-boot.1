Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113A3CAC5A7
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 04:21:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5443883390;
	Mon, 22 Sep 2025 06:21:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="XK396ZrB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77A94833D0; Mon, 22 Sep 2025 06:21:29 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5594583211
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 06:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEb5KOBEOI079OUBDrcmhqYV9WiERyhdSLfs0dNCRGHcwakwogS5psC+WaM2qR07ZjSnxLOBk/i2f4a3VmFwYclVLdFMLpJwSzzCFYgZdzkz6SseQ3QaRmFbWs2vBHpcDx9MWCuOrQo6pIgvoE/sOTv5BCRL5I3uS3YhPLt41LXS8ONs4+5JmDvQbDpuOIcHlH3CQWLExjjtd7Lo9rkctoVsdLBbfK9LFXieNOe7TOBGz5GdDnW5ymkbcbiyX4uyTIoHI/wI8wWlFmH5Km1gzkSgGnLB04rsYx+2VKY2Yv5S3KnpeXj1m3SE7Ybxz1YKYlgpxxCkmPJmfrVXXKPMow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Emha+r8/mwvi9mZKPJWvVPfEUVvPwK63W9YqpSHBdg=;
 b=ENigv/CK6uhDYSsSyVItme0IE8MpB+5USUGS9TOhPtH8bvInWFpsa0m1A2QCW0oB0CATsBVn365+ufPEE2d3mKDHVJ7i0h2cQIg8JCYbf3u/iZokR1M+2DAWnakk2zraFckkd5fimTW+SJBzCZzVXP4ShxMSrhbq6nuw/tgp66GR1E0K9keFuRmxe1pANSNv4duIHQBt/RI7SMohsH85WDoEjc1iutdZSagtU92YrRWWvWksuVUZI21H4zVST2n+aSSqIwEZL8Eapm6K1sZkg/XIEnrGDWBGz09ttUEv5B6FOIqrbC03pe3AijZ987Ldz24SlvWEWemkSLysDG8D5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Emha+r8/mwvi9mZKPJWvVPfEUVvPwK63W9YqpSHBdg=;
 b=XK396ZrBIcqbbL4Qiw5vumqvk9TiVUNrIMHsbpIvZys7PbyphFx+0DGMwHOx66FGw8tJvBlm+K1JXY3wQdwNHbcsVyEATj3PNFdiSF/KBaThkD3ODuFxErfri77xwr7hCSmYyzmmOxq+B7Rpx9O+4M+pkdm/ezCT1JpA1bc1mHJH0DIl90ws7ZAuU3BoWJICdwBGXDALuZy/PaVlWjvUIwShKnVSVDlyAc/p2E48IAGZFGfUOXiW70pgeXMOiPXDOsUh8VLL0I8ybd/QJYAdB/Cb6niTWzERSC4Y3eGjB/wdrPeO/ceygtiqbx5R1iE6vd1iybQ+NUVjIVfhRKTD1g==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by DS4PR03MB8132.namprd03.prod.outlook.com (2603:10b6:8:281::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 04:21:22 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 04:21:22 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marek.vasut@mailbox.org>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH v3 1/2] drivers: clk: agilex: Fix EMAC clock source
 selection
Thread-Topic: [PATCH v3 1/2] drivers: clk: agilex: Fix EMAC clock source
 selection
Thread-Index: AQHcItvnOs8Wj2b09UmO2yCGYlKzrbSeqtUA
Date: Mon, 22 Sep 2025 04:21:22 +0000
Message-ID: <LV8PR03MB8137879174230B145443C464A712A@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250911052112.15383-1-nareshkumar.ravulapalli@altera.com>
 <20250911052112.15383-2-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250911052112.15383-2-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|DS4PR03MB8132:EE_
x-ms-office365-filtering-correlation-id: 66437e7e-d29b-48bd-124f-08ddf98f7cb0
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?JiQIYkErYOLNIyBmlQqzXwHUMOv9IWYFUte5JmAIFCWNcfCb0n9/3EWKdDjE?=
 =?us-ascii?Q?JySQxmeHOamiNLQIYY7fp4a0JYc0V8u+Tu9uuCTVGFPGpE2xDajBX0Lw8jw6?=
 =?us-ascii?Q?tz7Gibwvgul1gX0T0H8QOmb79Q+hzUl2wK4EX/pCfyipoSl+eyT9rR33+GAH?=
 =?us-ascii?Q?C/OS5GQojuSU8VT453XLKdi/mYQzwkXn4bZVYCyeFSv02UZjnSqLhrJ4q1a1?=
 =?us-ascii?Q?YF8KJYrkdHMSq/Q4raqwLmctBCvsg2UvBPfXI1+d1/NqcnvD9/CFP79DoFkd?=
 =?us-ascii?Q?RxVXjamlE76V+pv8CUFi+amHq2wZaT/L5+g9xWhTocfZFyVyQzRSwnzyTzTm?=
 =?us-ascii?Q?i1r1ChZsCXhpKGJSwMdWnFmZqXyW28hlYlVELNa8IlUOPcBKnZ5aH/rwSmVA?=
 =?us-ascii?Q?oS5aRUHzWhOa6sTYXya/pzYLxNiKI5fUt/LzB27LVwamH1ug8DJz/Bl87eab?=
 =?us-ascii?Q?GEeTmCfQa/h60oD9wMC8fU9W8AGsGsREIyjBtjuN4+iMtPrB1ExGsTN69Rvy?=
 =?us-ascii?Q?nso6VeztkTFqOT989u1QeIKAMj18xtkHmt0uSZWsC/FsK/BhR8uSEX87vSS4?=
 =?us-ascii?Q?3lKm7DLRkI/+ss8rID0lpaULm3Rqza4L/DCNHEtGJA02jMRzVAX7DEsuadPt?=
 =?us-ascii?Q?YcQva/c3sU306jpeLMvxN0q6rAHvFVy3YXo8D6Iw3sPL0Gr0HJJrDrVabGIo?=
 =?us-ascii?Q?1w2rmSqxf0SqYKKHGAGgRCiMCFNL+2f1Ch7K07FFf0IOaECbgJtce3DWrvuj?=
 =?us-ascii?Q?J6b8DpuOdZB7P5jQMQTo76pkRpaiujmV+R9+ceUxBpiqht8mRqyavbd/EDFq?=
 =?us-ascii?Q?tcgAu4laa7wNeWd7/PahiImFYUzZNLzTQHPi9Ep/XxeVeJmSRZm13QkdufmU?=
 =?us-ascii?Q?z7fXYYzAtXwJ+qlgDgVErc//Gqw4dwBajUKmbXo7BlqfS1vcKI6ZKi1Zfq9B?=
 =?us-ascii?Q?JCQ/GSiQ7zijauiBnlIxRdhFVpG0iXD+m9TkVHBBg75B7ThAJHY3qs6eLdUm?=
 =?us-ascii?Q?56aFJtqjW+2H7rVpfs4HeBxpRshoEcSQIfRGhdArOoTt+e3/k+MXAD3lSAUk?=
 =?us-ascii?Q?9DpVT87n3N+5+h8G821V+GHhZZupvoYw67r1wptYhgWh0U8NDrCxrsuxGRTF?=
 =?us-ascii?Q?XpNDXBuHDbOWsMEu2EanmtEiuDV8UioC3RgYyyDCjobq2IfUGstxzJpAvyqK?=
 =?us-ascii?Q?iP6YpzcIGmP4xrFQGe4AINWpo8/2alRXXtcm+drphSMoG2wTQQsQvaNTyVYD?=
 =?us-ascii?Q?tiNKVLorCr4ZP9mti/Q0aHde1c72lJxmNTeF0DvGMJ9nkoubla0fXZsew+V6?=
 =?us-ascii?Q?lPP1GFaVz/ZlovmhZXb6OrTciZQtEPhihaOYh0h1u+4Dno23ovkH5Sf5YkEj?=
 =?us-ascii?Q?HaVuL/8oxC4Vxg94TQ54NeRh7N+tZGBgHytzfw4hmg6rcLCktdCPt2N2Ia57?=
 =?us-ascii?Q?0c9Q1+JAWx/7JP0m7PACjt9nw7zWxcB4PrUBmfATS0SAnB02ncqmQpbf+hjm?=
 =?us-ascii?Q?5U50qyupobyujXo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jtRSSIbIYE+zfErik5/ZBR1rENabyRly/UMVuIHYlYRX8ZPcxD6CUH+aZoHA?=
 =?us-ascii?Q?vi2ujxpoLoRz58nj5kNc1RB0WgHoImXLw3buc88hrJ2ODBuDx1yzqLelm7RJ?=
 =?us-ascii?Q?o4ZAlWhDBNOnJCYrFB+IqLAvTwQtmqqIkNvR61IIfPF3mJ7E2dNc+8uBfi+X?=
 =?us-ascii?Q?ceXKMKhzAwbanT/hzdY/AG6PSWZ3kPxfnVafI2xpyLTnZIV189Rx0s4NILhe?=
 =?us-ascii?Q?kNPqIAeaE7TsuYfPKcmS8VqPNb/LUYaYEpwPGoVZ3+54p3gidzV3RijwFUvv?=
 =?us-ascii?Q?F29bUwTvjNo82kf7U2GT6kjyhwLgclNdhXLiTafF+lKK4GgUR9vFRgX+QseL?=
 =?us-ascii?Q?KLeuYNrTYBZdPvKtO6try9kg70tJKAFiHdzTfGTvu2n4Da4MiRsaDFcKdVnN?=
 =?us-ascii?Q?IYIvCc6DR2wPlxQ0EmbJRM5KDmSdEhZhO3gyOue8MbrpXTSj3G7+UIq9veLe?=
 =?us-ascii?Q?hWs0WnWZYLkJC7CvZpusiLMcpPwpx7KGR83R/I8VpebqyWEfq5wchCsFmo7B?=
 =?us-ascii?Q?nFwDQZFlOJjSX8Z0MHlNcX2zBbtcI9kX3SGQLvyaZuzhV2mofOMTpGiCSqj1?=
 =?us-ascii?Q?+48dM43mGfvppkdp7DgENYtBblt8rtI3fICMxWiGF8bCzXk0KMVcXxql5NDK?=
 =?us-ascii?Q?ficQQg2YgB7yzcVzttlplFGnY0HsuAW4n1QsP186OOBeNWJU6XH/7K8ZivyV?=
 =?us-ascii?Q?JAKLT5EvjMt92XAZuTnjEs1m4wGXnWuNlUl2P9R/oRk20bqT+BGjt0UzAeMe?=
 =?us-ascii?Q?TGTcCgbxqvA5VTsSkGTyttYx+gVfwlN3XSrzmzpMgg6QDP6Wty9jSq9K/l4d?=
 =?us-ascii?Q?atn9wHbgNAwZy0CH+xqkWI3C4As8ZWl6dYnsbRsxR6vmaGNUUgSG031VzxUh?=
 =?us-ascii?Q?WETfxAMdcUdNGSpTNzKmx8ldiVXyOn59dIWU5U4ZgUKCJIYc9zQ2pIlEdctT?=
 =?us-ascii?Q?Gfio4th1iLCZK/veLj3RWJVIUYlHLW3K3mbSdEJayW8hjsnplVXiDPNCKZRd?=
 =?us-ascii?Q?pV2D0RsBi967TN89PNgmY6bS9LCtNRy08QH7/HgcozjBwUwwmGPD6Br70l55?=
 =?us-ascii?Q?DVu1kRWVvIpbQPDcExSuumgWEXgbKH4LdzPqFk8PTOFfrkz8773dC3AgLSXf?=
 =?us-ascii?Q?YGk37MtGFOj1EFOc7M0UvKR0e1HVzrClWARbGF3QYFQ9mN9emAPVEm+LQ2WM?=
 =?us-ascii?Q?bNNJOcXcyKX31UMHCXgO9LU9dahZbqtFOA7c7qI3XOkAwk4h/KFLZ3tN5LMQ?=
 =?us-ascii?Q?2UmG3qZQlNMIJpj0cPRwGWHkz6q9IlhMyyD0oYZwmJVjGoAJFEL/Qb8S6q94?=
 =?us-ascii?Q?cJlMZjbMNw2aP3cqWQNUCnaa9LhE87c3W3pENxHpwP2SbGRmsKnE10COoe8G?=
 =?us-ascii?Q?ZbCPL3W2qyG7e3ZLnOsOkGULv2JgKf1vxmMrwaW+e/w8yFgWqyBoLM6od63p?=
 =?us-ascii?Q?66TbtpB/ukLIoRzVFW4kE00fsriLTdU7WwMJPz6IQOyIyGLh7A0TRwJnsTRz?=
 =?us-ascii?Q?jBaxDcyVrApcQWjguzBa/vJpTLC8FqDJv2R+Vf6EypBvq+wU9iyESEVBbFRi?=
 =?us-ascii?Q?2A1APNOyIUJZyHJXDCpBGP9vXUzlOV2xs1NS4NzM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66437e7e-d29b-48bd-124f-08ddf98f7cb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 04:21:22.3789 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pUb4+bAdh9P2JYcaq3GfhKJUBscyuP4d5Cdw7iQH9X2eR3isXppi26xCFvCAvNMaURNVjCfTpuT4mvw975PFxZVvBb/jLENylHDGsjjHEeQ=
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
> Subject: [PATCH v3 1/2] drivers: clk: agilex: Fix EMAC clock source selec=
tion
>=20
> Fix the incorrect bit masking and bit shift used to compute EMAC control =
which
> in turn is used to select EMAC clock from EMAC source A or B.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.c=
om>
> ---
>  drivers/clk/altera/clk-agilex.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/clk/altera/clk-agilex.c b/drivers/clk/altera/clk-agi=
lex.c index
> 242740a4b00..16a37b962cd 100644
> --- a/drivers/clk/altera/clk-agilex.c
> +++ b/drivers/clk/altera/clk-agilex.c
> @@ -544,14 +544,14 @@ static u32 clk_get_emac_clk_hz(struct
> socfpga_clk_plat *plat, u32 emac_id)
>  	/* Get EMAC clock source */
>  	ctl =3D CM_REG_READL(plat, CLKMGR_PERPLL_EMACCTL);
>  	if (emac_id =3D=3D AGILEX_EMAC0_CLK)
> -		ctl =3D (ctl >>
> CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_OFFSET) &
> -		       CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK;
> +		ctl =3D (ctl &
> CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK) >>
> +			CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_OFFSET;
>  	else if (emac_id =3D=3D AGILEX_EMAC1_CLK)
> -		ctl =3D (ctl >>
> CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_OFFSET) &
> -		       CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_MASK;
> +		ctl =3D (ctl &
> CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_MASK) >>
> +			CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_OFFSET;
>  	else if (emac_id =3D=3D AGILEX_EMAC2_CLK)
> -		ctl =3D (ctl >>
> CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_OFFSET) &
> -		       CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_MASK;
> +		ctl =3D (ctl &
> CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_MASK) >>
> +			CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_OFFSET;
>  	else
>  		return 0;
>=20
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

