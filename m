Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A422C83F25
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 08:40:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AC5A8331D;
	Tue, 22 Jul 2025 10:40:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="MdGeO68F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 655B683327; Tue, 22 Jul 2025 10:40:25 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::61f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5283A832EB
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 10:40:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5ZSnTvwp3qmvnk0zt6ezGH0sfdgVFTv7VVJ32E2clKuWCcTR3i6rmq6tmUItUsbvNJq37ri9nZ447IpKa0OL4B7ngA5BxIHkoKP9o907kR0SjqxBsByrnzwRYczJYVLMsdyS1HxUbmq9FopxM++1z805hm9S15RA1GOAa1hXe/GtBr+y83gT1Qo6nVwWYKBqmW8DjqbsKIeSzen4OYwu5/QcXeIwr7aS0fOK2gAp1O2b7OFANMX0icKTpgwcjzWiPouACheUfW0Tst+YOwtd0u8R92ePch3rZ3ny/mRquai6XGZXCu9Q9aJsNHyZ777wWOqqem5LpEIikWyjdfeAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nllu9K1ccT1UpJhxvk7tEJscbO2AB8dpClUX02gUc/o=;
 b=urJzt7bJIpmsH9qh73bzex5wsprJN0xjclBYk6cc+sTZueVh0lMFJ9OSb/BONT/EqDIb3L1BzKG0/QyyzJ3trEYU1GnV4YZBmto/+jJQQ43PawAkiQlRlx7oGULA27Adthd9amCclPeYviDc+WW3EJF8dI+u43g4TJ5w+tKpa8x5prr0sqBg4Mbaum0Oze3/8QOmN1j77Qu+lA/yH4qCaEOAGVpMCIeIMbadsDyFaiZa1A23mddOBhzCluYFF4rRXQ/vQr8uTFznTdFHYQ0KI4tj8SIm5uBHEYODnHN7DKUYhoQxKMAoxb+fMAJqC8p/hn8yG5su4cHcU3m/RN01OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nllu9K1ccT1UpJhxvk7tEJscbO2AB8dpClUX02gUc/o=;
 b=MdGeO68Fp5KaXCJsteLwLA9/rfBav5rVNeAoIIvuLNtGFC8uhwIe5sb+ITcxMtcjalnEC6ez147gML2f6Z2MDinMxP/m8lzBOa1kXZVj/0Nj3i5+s7tXlWpOArBM5IzWt1N7MpyKqYvddiLTImzDPySHrYyeEAN19KVWWHFBSXOpMTNH5KLLOcxeRQgEl5qLsN3bQBUAoL/72+V+8qsph2cZgqg9vLgIPhsSDmFEFCqSVyG8WAGSXn70ar325q/vKDCD3N+Ay0Qzrlllu1DawfKlDVDvy2ilyxKj276x02BiRxSzMOOYrCS1o+5sTPxd15uvk1kdQzG3mTwue1ybEw==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by CH0PR03MB5970.namprd03.prod.outlook.com (2603:10b6:610:e1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 08:40:19 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%5]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 08:40:19 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH] arch: arm: socfpga: Include BSD-3-Clause as license
 identifier
Thread-Topic: [PATCH] arch: arm: socfpga: Include BSD-3-Clause as license
 identifier
Thread-Index: AQHb6kSP6USILS3+N0myvYrr/CRIrbQ98+lA
Date: Tue, 22 Jul 2025 08:40:19 +0000
Message-ID: <LV8PR03MB8137A05BB017CEA0D6038C5AA75CA@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250701045644.10270-1-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250701045644.10270-1-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|CH0PR03MB5970:EE_
x-ms-office365-filtering-correlation-id: 7d431f85-40d6-43d2-4036-08ddc8fb63e6
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?L+9YUjjgnsfmUMI8T2acNHKu3pHiDY/gq9TFNCkXVCHZ7l/SkMOgBcPvbRT3?=
 =?us-ascii?Q?sOMobO0RJt17D6gSE2jAD3Q6R9R0mVCl31N7KmQlQUAOMkaR+luVHUTvceh1?=
 =?us-ascii?Q?LvfyIFUGEWV56CGYjhdCvI1oKTIdh3K+VUWNS1RK98Fiwr0EklzF1rnoOnXx?=
 =?us-ascii?Q?epq1Oha/+jQbnvoAq2YoPAUrjEJZQFNj9I8ljXxx7jznVALSwcg9Oa+Cfsvi?=
 =?us-ascii?Q?g1wdIzYw8KOq/KtAifMiv7aEWCAYtP2BVaVHpZPymTm3D5uYI/IDqC0EBvr/?=
 =?us-ascii?Q?IAyZz1naPE3YiBCUP7LBc49D1KHvgTdgLAy8c3vtI/5PH0Lx315+qUXejQHr?=
 =?us-ascii?Q?t+PBVXkPOF1XQBzZLY1BoWndbTz6uSijewAwu/R3Xr8eWyHii2Dxbm8t0ZcT?=
 =?us-ascii?Q?hWwUx3aYZJNvZkd5ib4GkIZthAxZ86PG8EtoLbxA1r9OL6RdrQxD0oL40nso?=
 =?us-ascii?Q?MiZEgXx8s9SrBUydiLJwJoB35kSe2C5pEIl0S1jfR2L3xLHq/Mh18STzjxkW?=
 =?us-ascii?Q?T9FHq5ZM8RMfEpjqHCuPCmWVhDHakm6wAsf8f104QLSPdG08LZPzHTT11pSg?=
 =?us-ascii?Q?YA7Pn4yrtSoGHHUVETwBWvZKWlpufkgTw+O6Hw2+Hckuwe+u9UjtFK3N0k1k?=
 =?us-ascii?Q?XnUzYrxBJLYjI3U0f/BZsjvgQHY8VIESDKCLY2IOahgs3saR6npH6/EdALsc?=
 =?us-ascii?Q?yct93TbCP031046KpBfDbvEgKpXK8CdFJQIFNevZPQTXsijVf29g2SrIXy7v?=
 =?us-ascii?Q?V8z3YmWaS8vxzLL5FWu+fUZpWMrfhVVVZ/U4KeuNlyM1cxF97UzQZH485dzq?=
 =?us-ascii?Q?bDOyRAgGL5oMZChWwP01BMCixnVBpr9HtLT/PKOXrq3MNBoTPV4c+EaCmZeu?=
 =?us-ascii?Q?BZs4cEyjBTw9cQ901dV6zW/14BEgrF2HrGDWgRWfBhh9iv5rI46obpaLsgbJ?=
 =?us-ascii?Q?eaQpGPyWU0SQeCiI7TrcssQeazewDTSVR5f8L+4V3uh3VJ9MIcfJt6MmXC+5?=
 =?us-ascii?Q?UUGs8GfwKdEUmX3L09piMt1MQMBof3qumb+emwqPtO54X1hI1Wzl6sJCITnh?=
 =?us-ascii?Q?YykweqBTJJVCzoaxGSzD8Sl/nhFfg8G6GAXRB3ZYxqgP377thrh/f8jy6xT5?=
 =?us-ascii?Q?5P5JnyrgO6iRmfccX8oh1vBS+PHZ7EFSLuI4Uv6OrW5baiyNRlzOeYdMzcFm?=
 =?us-ascii?Q?vy8P0ohg7+MdcIQ0M7cqenjgwSU5e0eDoEyhfVWreJ5zaR7i6Seb71rng2Cp?=
 =?us-ascii?Q?GbTkImO+ubsXUcAbMVRlwMz7eBd3oUgPhhqjX8xC1NCp3VItfyxE5hIuwuCo?=
 =?us-ascii?Q?onfA9Owa35fR6VyCdpbeHc/rPmNwdzbxIdBBh69GoaaovuACkGN7wf7RY3Tm?=
 =?us-ascii?Q?0kDM/DgUEgKcQo/PD64EpGDyraj5P7xcwNwf1f29V03/RNVxEF13/mEFpgnA?=
 =?us-ascii?Q?pgcWZ+fM9FqdwGaA+3+Kj+kAYS51riUp/ONEF88+njWoU7vP/TOAsQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(13003099007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GhYfxojQegu63ip4RQ9cF4ELyQL4PQbY5Pc6CKXkHCkN9kbxviH/n1XrdvPO?=
 =?us-ascii?Q?mgieGfAvNXp2C0CMVB3HHHnrt2sVu8DnxOqw/CVbUUzn56ooaTz2zwOdk/ZW?=
 =?us-ascii?Q?syntNEOQxjcxv4Gs3vPqUgcTzVBNdgf17t+089sfgOJlYqI6UBcunusz+BbE?=
 =?us-ascii?Q?nIlzGBde/QCLsGi5EnlpSWnbHrXTyypXWHw8ope10jSL/SXq4s2VMeUBu84x?=
 =?us-ascii?Q?YIrD6+VFeJpBJhUsAmjLOFjl8L8qWHSw7bc04oTxZ2SEOOb4+EoqI+PLVoAQ?=
 =?us-ascii?Q?It8loEPhRWnNQurL+NlN9bqib2shqjCR9c8pQshWhVLIyiNwEyUpkzoahFQv?=
 =?us-ascii?Q?YTAbxD0B0sXJAn3jOYE9/h0Q6nxUJcWJmXFagsJaoyFpudmowQ3T+XkKomza?=
 =?us-ascii?Q?tE9zSAzbZ0fntUAq5h1e5PhpPTGOV8Kbq/KieK3XwuetFsodt+USmJ5ysI7o?=
 =?us-ascii?Q?GVV/fFRlhEXD7rdHf+2FemISgCWaelOIArefKpMmCgcBllCjhFAJ5L+3Y/Z2?=
 =?us-ascii?Q?48UKR/nqugBZCycp5LbSGEVT27M0DC7Y5LM+Do+C4RZdKINk7vaTJjqBzQlK?=
 =?us-ascii?Q?yQ7kKXLdCxuO5ZLFBLZMx8DorE1AbGGBXAgTDjzEwhzNgfR6aNmG1lF73+8U?=
 =?us-ascii?Q?hjp4sAw26Wd11EXY/IROqjZNaM6/jWKA1hPMmns9NHmDv4nPhbC39YYKkro0?=
 =?us-ascii?Q?9Xs4QDtN6SvcpQnfLcMnB+BMxwElV/OlggZiEyy6hX7M3s8UIea0S0CMEX17?=
 =?us-ascii?Q?IoeMKo1vUW7mUDukRl2TLP/52WFhXbuUKp4LDBIYh5BNBRCd7NGFfvhrfE1Y?=
 =?us-ascii?Q?WxGBjoqs9UTZ26qFuOE3L+pqL/ZB4DAdNcQEQj84hSHbfz6PHTbiYZ9HkE5u?=
 =?us-ascii?Q?QFOcw4y+wbFXIPAaIglWj8qm5wH0lIv6W4IUusNKUCXe98Dg5MDSMmiMA3Wc?=
 =?us-ascii?Q?Vr6o4elcMmYve1hi0Yfi2tRrR8VTmjLdelEQbTU7sgB8xgvwHDazxKyHuOQH?=
 =?us-ascii?Q?dzvEwA1ABG34aze3V9hY57r+2dJAslXIjVaXLCpx4lOT1aHcE5eXFYC2l4wh?=
 =?us-ascii?Q?WXw4JZQpRZ9R1HWKVT/dpW7jUHvSzwogxxHIrtpq4qwQu5uBdk5l9XIsfRJ1?=
 =?us-ascii?Q?W3z3gIYgFzra2/vduYV7tOhErYnd210Q8rQRcjimcYCPq+5g/6cVa3dxWA9p?=
 =?us-ascii?Q?uATWT/5MewYMIKZ65uOwdH3Yb4p84M1W6aByuEOnI9PyArKVwLDlUOIYmzUa?=
 =?us-ascii?Q?kRgNnEUalgbnCStWTiyUfToWgJhp5/ETicJRnLc9Ba/8/9qiNzRIl/33a2VC?=
 =?us-ascii?Q?K29g4dfvZabbqnlHCM5fZ/YP8dNbsk38aVY4OJ0QuFcFtrXlYmz8wHMpZ49T?=
 =?us-ascii?Q?67qFm2uu6IC2bn5F1x8HKGh2VIpUn35RIr/4/eytf/d0Ua3nGeC6OCxibIza?=
 =?us-ascii?Q?5iSJNzTzDBHT58zw10WxvaErV1epbTBnwVnfIwcfHHZb3JYNAyOqcv7tWZRS?=
 =?us-ascii?Q?G/4ZN28UY5n7XcX3L5r75CwqOi+mYWYUe6gzXvnVPjRgdrcVMtN0cEa5PIF8?=
 =?us-ascii?Q?N0jOCtQcEi1xmnToZ8rqCwhyebgEunToardQNAz8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d431f85-40d6-43d2-4036-08ddc8fb63e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 08:40:19.4461 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bpxbCl0rWnY+HLl00e0khar7G4DjAEMycwJbQDVaHMnDAtBJ6PPVeHg//qwOmGbl/z3XcBKcwhh7EA70nF8VPlkgU7BSCOyz6TAYzlh68vo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB5970
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
> Sent: Tuesday, July 1, 2025 12:57 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Ravulapalli,
> Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH] arch: arm: socfpga: Include BSD-3-Clause as license
> identifier
>=20
> All the source code of secure_vab.c and secure_vab.h are from Intel and
> Altera. Updating the license to use either GPL-2.0 or BSD-3-Clause becaus=
e
> this copy of code may be used for open source and internal project.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  arch/arm/mach-socfpga/include/mach/secure_vab.h | 4 ++--
>  arch/arm/mach-socfpga/secure_vab.c              | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/mach-socfpga/include/mach/secure_vab.h
> b/arch/arm/mach-socfpga/include/mach/secure_vab.h
> index 42588588e87..1be0cb61e7a 100644
> --- a/arch/arm/mach-socfpga/include/mach/secure_vab.h
> +++ b/arch/arm/mach-socfpga/include/mach/secure_vab.h
> @@ -1,7 +1,7 @@
> -/* SPDX-License-Identifier: GPL-2.0
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>   *
>   * Copyright (C) 2020 Intel Corporation <www.intel.com>
> - *
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
>   */
>=20
>  #ifndef	_SECURE_VAB_H_
> diff --git a/arch/arm/mach-socfpga/secure_vab.c b/arch/arm/mach-
> socfpga/secure_vab.c
> index 9bad2873a49..d5ff47a142c 100644
> --- a/arch/arm/mach-socfpga/secure_vab.c
> +++ b/arch/arm/mach-socfpga/secure_vab.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>  /*
>   * Copyright (C) 2020 Intel Corporation <www.intel.com>
>   * Copyright (C) 2025 Altera Corporation <www.altera.com>
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

