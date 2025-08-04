Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706FDC87FD3
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 05:12:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 837E883E18;
	Mon,  4 Aug 2025 07:12:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="R+fStmnN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2CC283E2B; Mon,  4 Aug 2025 06:20:58 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::60c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB5F683E04
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 06:20:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNk94CWT445tcnUEQnogrOIjPAgtmNE+dLm3ERq+yuR5fMwIloQSGqcoSyKJ/aF1SCQCWHQzK7FP5IaMHEvBob4pA/EQcPmgGAr7BnDaV+qmAStzIgDQvEzuSt8sV+4lXrZ4QAArP19aV5ZW6875ZJ8twHo9uuuLO9q+BM5qkY+0IFV4HybVRmj3rYCSdKLX8U5HEvnBIwYtWRjDIWo7i3feWq1k/rWwtYpjtcpEUzbFldE3flUToZGlX9ccm8PoHNlKtHboseHipnpqODekT5ieq/Jo1kpXQ6LcF1nyumC0lYXUPHhm6WJ7e+qf6n/r40GN/CZxDD5NqRFL5OPvyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSEND5IbuBRsrVPqVf4AlWHyALhrrrTgUIErDYBcJ+o=;
 b=tlGRVJe1lMroWN3CrcGyzggnWVphBXZFglhAj6N4wWWe4GOl0F4DP93ZnGGpFer6IAb/O7foOzI46cQ9XNlGFpfnJjls+sOCxuf8ER08EbZ9s9Lwh4PktqdBWaFYdy85LPd/Jl0Fgxa9hTwFxCimeY0gGXVxftaa0PQ+RhUows0ocx9XEVKmB46h7FQ3DQgRZmrhxEJ4H+2Rgiba+bE5vEtdQyly8f2gNOkhBO0FuJRjZD/2H8+nduKmP5kmYnMqd40FkEu+EAuBkXD7TKAFHOwYfVV1knjEHXxCrmyfzcXK+mGfJ/iBrZd0Lkm3WWYCGUL0KZYX9r4TTMeR+uTmFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSEND5IbuBRsrVPqVf4AlWHyALhrrrTgUIErDYBcJ+o=;
 b=R+fStmnNdB96wvszKoHOJz8zMBASwDs371IQO5LDvqI3QtsTLzn0Xt+X6A8I8B7PEHreJOlo3qcf4r+RFQWfLZU1RddTr3dt/JYka3dsbxii9TrdWmns8lrjxiCxzBh3ft24BdaLuij7oq08ZtWrZf1Kk5yfJZrNXM+mRgucvrq9lZ8lkUYq52jlIUM0ZLrfOXFDg4cfKy5GYZ9jL5CHayzbWgaIIg67ZecjdLXKCpfQ8fBDXqPVnnmzJEsW/kwv6vT5GBwnV5YYlxe+iosFOfCf1FNrP0ML2x+ZUF+73oPGhfI4cJIBR4V/thJ4BsXpc8U6LGt2MHEAuUh3sEVW4g==
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SA2PR03MB5754.namprd03.prod.outlook.com (2603:10b6:806:11a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 04:20:51 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 04:20:51 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Heiko Schocher <hs@denx.de>
CC: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>, Dmitry Rokosov
 <ddrokosov@salutedevices.com>, Jonas Karlman <jonas@kwiboo.se>, Sebastian
 Reichel <sebastian.reichel@collabora.com>, "Chee, Tien Fong"
 <tien.fong.chee@altera.com>, "Hea, Kok Kiang" <kok.kiang.hea@altera.com>,
 "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Lim, Jit Loon" <jit.loon.lim@altera.com>, 
 "Maniyam, Dinesh" <dinesh.maniyam@intel.com>
Subject: RE: [PATCH v7 00/12] Add Synopsys MIPI I3C Driver support
Thread-Topic: [PATCH v7 00/12] Add Synopsys MIPI I3C Driver support
Thread-Index: AQHb/4y+/bqcqUbjXEihpMO3sLKgx7RHGuoAgArTeLA=
Date: Mon, 4 Aug 2025 04:20:50 +0000
Message-ID: <PH7PR03MB694215367A1A2EC1A66A755FF723A@PH7PR03MB6942.namprd03.prod.outlook.com>
References: <20250728065612.6039-1-dinesh.maniyam@altera.com>
 <PH7PR03MB69423C4746FB6E025F699C89F75AA@PH7PR03MB6942.namprd03.prod.outlook.com>
In-Reply-To: <PH7PR03MB69423C4746FB6E025F699C89F75AA@PH7PR03MB6942.namprd03.prod.outlook.com>
Accept-Language: en-MW, en-US
Content-Language: en-US
X-Mentions: hs@denx.de
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB6942:EE_|SA2PR03MB5754:EE_
x-ms-office365-filtering-correlation-id: 54ff7b5c-98c2-41f6-a498-08ddd30e4bc5
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|376014|7416014|13003099007|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Fr3X+Fke48uICvHsqVGvd5VBp3e1n3x1DUWAS42afKMlLR37716mf9HnXFWV?=
 =?us-ascii?Q?vJmhGJ17CaXdyeh7RV6PIzsFmRnyjBOcyDZqhsImLMWwDRwwAcPIE16BVTFD?=
 =?us-ascii?Q?vx2tbQy1YQbbvOYhVixOQSuuKscotjXnwnZgKU91fKyb0bJU+PDSNDnxN2XZ?=
 =?us-ascii?Q?5JUSA0FhduZZZsCAnOdYDTxgeusLZduQ0nFZs599bCXREsTtU7sJwWYjemmG?=
 =?us-ascii?Q?j7U6LY8vOBnKanXDTNKoezzBF0k0FrTlu5fcYD2iMDB6zH0xhvz1XQfYYqJx?=
 =?us-ascii?Q?cNlL3JuBCOGs9dgl4fQS7PJug/kqBA/CrdGr6ZZVZqXBgQW8XvtKJF/CgvFB?=
 =?us-ascii?Q?m/CXxydM/xtnm2lDl9TnW5qDnHS/F4Fg071MBMFm8IHqPoSgd++ukzpaRp4F?=
 =?us-ascii?Q?tsilyeL2oEiGqpDxT/yia1JAxow+JLCcGns/MMbQrE6LfoRTQw8CCNm1ntM4?=
 =?us-ascii?Q?fchGw2cmWurcCuDnlKJG8CtEHyzDy7vKsOOoBMYw2i503FgJ80DNFZlkEe3D?=
 =?us-ascii?Q?ycvfCoJiY7Gdnp09soc3f4Prd3bj8LuBh9gVbNBsTAJwymTEd42u2brDAhpQ?=
 =?us-ascii?Q?L/vFPWX/bOzllBbeT2rSWvHlWadj7XlJBPr6PjAlNtv8mKtl+vzAs5M9Cwtl?=
 =?us-ascii?Q?363JPfy9X4c5ngTOHTof7F8pf8cGX5qWv36I3eAneD0GotO0Gb2lQHHnpcEx?=
 =?us-ascii?Q?YqvLWqsoJ6yf1S81TNfb1QHW8993Q2vda6xQtoeIsSVFaPdKHbi70UxcRvpp?=
 =?us-ascii?Q?Vqi2wWoqZHOQDfO65C64ooHkPSweD54EAt9ahV8poWlWV/4NJ236fPZVNWK+?=
 =?us-ascii?Q?HHEGLTDAec/PTq8jVClFH0rbffbARoOy2AeDwJXsoO3ttuQuOaazsYj3VnnE?=
 =?us-ascii?Q?UrClNzkqWnlT5RlQrrbSbE/eq4WuL9Eihob2DWRISxsXjzJ8/PqhLcTHMd9Z?=
 =?us-ascii?Q?iC6PrN/O2xatn/MRdDsvZHFH+9wy3ObNIJlKgQaiZ6WEVlKAQZ0oFogXc5td?=
 =?us-ascii?Q?q99IrfCF8ARh3rej3s4HR8F3v0h5hFfwgptCtOXAwKDA2m9nyD7fceUoD5Ym?=
 =?us-ascii?Q?+p8Mj2SXaBTSTWZsGxX5IcxVl0cvaDUGSeQTcH4Vj6OWHUm9metI05UJ8C4s?=
 =?us-ascii?Q?RBvBYXrCCM6AOZ7KZZ2KmsxMOcBQLFtmMBppW9xk6mXoMPAVfaPbX9tW3np0?=
 =?us-ascii?Q?M6goRpwoMwYmOg8CZ8Z/8Qq+Y3JctcWITcFb4D7VnzSXUmjvkDYu983UW2fN?=
 =?us-ascii?Q?W6Ijp6NKkKAa4rocjDI4YZro2Z+n7hI73zuUNUa3GhlzUJOW9GFO1UUPa4k5?=
 =?us-ascii?Q?TBGShaIdWKNUjV+E1eeZ61xuDYTEgP5NmjeVo0Pzq9folqBYoRyMEUaDSOMa?=
 =?us-ascii?Q?EDsivTyV2SXhl626a2kyOwKwSEnut2aLZA367q7X7AdrC+VhfSrEXB+M7fJx?=
 =?us-ascii?Q?g9dKV0Ik06iJsNP/aJVVc1dygbZ417TZzOs53D/XokESBi9cqfR1IGxVeU8B?=
 =?us-ascii?Q?9bAkN1zSu2Upc0E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(13003099007)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U74zKtrhu7mMH9tQgIMiL5d955g8naJa+mmOzXq4VEH2ld1S94eHBmLIYWrp?=
 =?us-ascii?Q?2lkYl/YLvRkyU1S805agBUjxwpyFOYjIIlf+q3JCAH17MisLhrQPzF36I3xz?=
 =?us-ascii?Q?DOtzaIqZyr0bx88ipUoLT/g8wjWAbJrqe3IgPVWgiFkQF9npYDhY6+5QIy+o?=
 =?us-ascii?Q?6+biDwL4A2mTIEcs0sgOC0Qbken7g87UvvcDfhrC1LCk4aj2ftgQWe4EiSG6?=
 =?us-ascii?Q?vLNyrvDFFM697rRAtq6gsvKPPFz2hesRWBITllHAkdgJO7e/ZzeXX8y64ArV?=
 =?us-ascii?Q?8JafZI8LYpBnMOZzm/LWlSpraz21GJLpuecLqpQQ/4OmhreuOhV0EZVz735b?=
 =?us-ascii?Q?FPoRwoayhzisVULw/ZGhBok6l5KB/qa4dozYbDW+WDGrjI10C+JqIhN6abLm?=
 =?us-ascii?Q?gbMy1k8+c7qFdCe4Y+l2UvzSsxDVuR0VCaeEIDv8h3xN+8pEIgNzTlbNTEBd?=
 =?us-ascii?Q?qmP26q1aalGDnKmSKWHEYIyEGy/i+KK84iuZTZ7xenstYvUsXwSmolhy4vaR?=
 =?us-ascii?Q?37mj7qcteCGmKLF80/p7lW8i+QhTbFs2IlcCQ+Hg1PzrzjA6+O9r2tB0Zusq?=
 =?us-ascii?Q?aK1Qun2UmGMN09jkFtE5LzYKd3wNsP6uLtMSnC4t3DB+7q0pifsGJg6AtLKp?=
 =?us-ascii?Q?6L/myV3krrS05jbAR5kx8zn32k7AHspjaJfR8+oZdXxFWyfJ3FDEqNKnPkAn?=
 =?us-ascii?Q?0BbY9SUaja3TuNX+RdtNmKgXKH3xCeN/m0Odr59lVZf7jrbIQ+0wNTetAEB6?=
 =?us-ascii?Q?h7xmd/g3lMLO29B2p6QceBGcdTLYBJO0FF5I6IcNMHqNqXbq3YzRSM5lSc0W?=
 =?us-ascii?Q?uTrotBCXAESM1Y0z4Q/rAuLjzbfRpLeaWbyDzLn9hCrAg6vfMAEajbHoKLAY?=
 =?us-ascii?Q?kV2vhCZIN4DEfobw7oRnpvfuYpgmQ/pxHRFSWnXOWyg1AC9KPLE68InsgRlw?=
 =?us-ascii?Q?GxsE9PMjagtLCfICpik0OREiYLyZ92sCFIArSAY8410h5szleqpv7CabCIww?=
 =?us-ascii?Q?b9h0Jvjw9ab+Do1g4axqorYTjA9JawQdVS6236UYuw9fhO3BUEKmLRoagn6b?=
 =?us-ascii?Q?JpHDGAEBQdN+JgFqfY4BUxeY3iHac7iuf97YjtW/fKVkUAI4AqWZ0UUCyiob?=
 =?us-ascii?Q?RyycK/nABp36/G89cFaa0Ndr0OEXwl0laZwyIa2+uHIIUrGXNw9ftj0Kib0e?=
 =?us-ascii?Q?//WoiU6SAbfW0EuXT76ctBA3gXR5bACqUN7uRzakZsDLULU46TyAfIvGfNlW?=
 =?us-ascii?Q?9UaBJdM0/YvnN73dsXXhBmZ3bmUFOiuA75OI7wCxU1PeijxOxJjRlMZ36nWd?=
 =?us-ascii?Q?S/tqezWEGD9pmLpMdOJBUfct2etbJ1ZVUpuNPZPcNhf8Qhuq2M8A5XknMo/n?=
 =?us-ascii?Q?xKx0ZP+qecx15SO2zf+HNtz4zExBm1c9Joo3+uC+Bl+1ydk5ataqzqhuNsRj?=
 =?us-ascii?Q?o/glXFPIh5jO5r4HaQ4fRrbxZ9pGm0gkhtHgw3gGPDcbPBiNMVmRHaZwYvzx?=
 =?us-ascii?Q?HHeXDayCzQbbSnn+6tnTluluLs3zvj4TCcBVrDreoskuhbiRgqbhSBWGtCAO?=
 =?us-ascii?Q?DlMVsWhSXp+J1bPE8xoRYCSywWDi5SWsk5CnCSmB0PSGonRRxFouahKDzcut?=
 =?us-ascii?Q?7gDpV2DJv/Q3HInsH/SgSQ3vGk0sfixWb4yunXwsWB4/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ff7b5c-98c2-41f6-a498-08ddd30e4bc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 04:20:51.0291 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wWrT03Sn+u1BDImEUamHwEzO3f8mtWzHhmBRnxyhc7x+3vB5XrIm0vNNjnUFhEHiGc3qcYgx4nxmK1xEzqNVRHm6AU6AlMkunsHMeOEtcCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5754
X-Mailman-Approved-At: Mon, 04 Aug 2025 07:12:19 +0200
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

Hi @Heiko Schocher

> -----Original Message-----
> From: Maniyam, Dinesh
> Sent: Monday, 28 July 2025 3:01 pm
> To: u-boot@lists.denx.de; Heiko Schocher <hs@denx.de>
> Cc: Marek <marex@denx.de>; Simon <simon.k.r.goldschmidt@gmail.com>;
> Simon Glass <sjg@chromium.org>; Tom Rini <trini@konsulko.com>; Dario
> Binacchi <dario.binacchi@amarulasolutions.com>; Ilias Apalodimas
> <ilias.apalodimas@linaro.org>; Heinrich Schuchardt <xypron.glpk@gmx.de>;
> Jerome Forissier <jerome.forissier@linaro.org>; Mattijs Korpershoek
> <mkorpershoek@baylibre.com>; Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>;
> Michal Simek <michal.simek@amd.com>; Dmitry Rokosov
> <ddrokosov@salutedevices.com>; Jonas Karlman <jonas@kwiboo.se>; Sebastian
> Reichel <sebastian.reichel@collabora.com>; Chee, Tien Fong; Hea, Kok Kian=
g; Ng,
> Boon Khai; Yuslaimi, Alif Zakuan; Lim, Jit Loon; Maniyam, Dinesh
> <dinesh.maniyam@intel.com>
> Subject: RE: [PATCH v7 00/12] Add Synopsys MIPI I3C Driver support
>=20
> Hi @Heiko Schocher
>=20
> > -----Original Message-----
> > From: Maniyam, Dinesh <dinesh.maniyam@altera.com>
> > Sent: Monday, 28 July 2025 2:56 pm
> > To: u-boot@lists.denx.de
> > Cc: Marek <marex@denx.de>; Simon <simon.k.r.goldschmidt@gmail.com>;
> > Simon Glass <sjg@chromium.org>; Tom Rini <trini@konsulko.com>; Heiko
> > Schocher <hs@denx.de>; Dario Binacchi
> > <dario.binacchi@amarulasolutions.com>; Ilias Apalodimas
> > <ilias.apalodimas@linaro.org>; Heinrich Schuchardt
> > <xypron.glpk@gmx.de>; Jerome Forissier <jerome.forissier@linaro.org>;
> > Mattijs Korpershoek <mkorpershoek@baylibre.com>; Ibai Erkiaga
> > <ibai.erkiaga-elorza@amd.com>; Michal Simek <michal.simek@amd.com>;
> > Dmitry Rokosov <ddrokosov@salutedevices.com>; Jonas Karlman
> > <jonas@kwiboo.se>; Sebastian Reichel
> > <sebastian.reichel@collabora.com>; Chee, Tien Fong
> > <tien.fong.chee@altera.com>; Hea, Kok Kiang
> > <kok.kiang.hea@altera.com>; Maniyam, Dinesh
> > <dinesh.maniyam@altera.com>; Ng, Boon Khai <boon.khai.ng@altera.com>;
> > Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>; Lim, Jit Loon
> > <jit.loon.lim@altera.com>; Dinesh Maniyam <dinesh.maniyam@intel.com>
> > Subject: [PATCH v7 00/12] Add Synopsys MIPI I3C Driver support
> >
> > From: Dinesh Maniyam <dinesh.maniyam@intel.com>
> >
> > This patchset add Synopsys MIPI I3C Driver support for Intel Agilex5 de=
vices.
> >
> > The i3c driver is leveraged from the master/dw-i3c-master.c,
> > i3c/device.c and i3c/master.c Linux version 6.6.37 LTS And few header
> > files included to be part of the migration; i3c/internals.h,
> > include/linux/i3c/ccc.h, include/linux/i3c/device.h and
> include/linux/i3c/master.h.
> > Additional i3c uclass driver and command files added to support i3c
> > read and write in U-Boot.
> >
> > Patch status:
> >
> > Detail changelog can find in commit message.
> >
> > v7->v6:
> > --------
> > - Remove extra variable in struct udevice
> > - reuse the existing dev_ofnode to get the node in  master.c
> >
> > v6->v5:
> > --------
> > - Resolved documentation warning in include/i3c.h
> > - Move declarations to the top in cmd/i3c.c functions
> >
> > v5->v4:
> > --------
> > - Add header file to doc/api/i3c
> > - Rephrase function description for i3c.h
> > - Separated subcommand as a function for cmd/i3c.c
> > - Used memory address to transfer msgs from i3c
> > - Rephrase description in cmd/i3c.rst file
> > - Replaced int with unsigned for positive variables.
> >
> > v4->v3:
> > --------
> > Resolve ci test:
> > - Add i3c node in index.rst
> > - Formating error in i3c.rst
> > - Resolve cpu_relax undefined for sandbox
> >
> > v3->v2:
> > --------
> > - Squash commit 10 to commit 9
> > - Resolve index for new files to pass the checkpatch
> >
> > Commit: sandbox_defconfig: Enable configs for sandbox i3c
> > Commit: agilex5_defconfig: Enable i3c configs for agilex5
> > - use savedefconfig
> >
> > drivers: Enabled Kconfig and Makefile for i3c support
> > - Add maintainer for i3c
> >
> > drivers: i3c: Enabled Kconfig and Makefile for DWI3C
> > - Add empty lines for if/endif
> >
> > drivers: i3c: Add i3c sandbox simple test.
> > - Removed DECLARE_GLOBAL_DATA_PTR
> >
> > v1->v2:
> > --------
> > Reorder commits.
> >
> > Added commits:
> > - drivers: i3c: Add i3c sandbox simple test.
> > - test: cmd: Add simple test for i3c
> > - configs: sandbox_defconfig: Enable configs for sandbox i3c
> > - configs: agilex5_defconfig: Enable i3c configs for agilex5
> >
> > History:
> > --------
> > [v1]:
> > https://patchwork.ozlabs.org/project/uboot/cover/20250218025705.50051-
> > 1-
> > dinesh.maniyam@intel.com/
> > [v2]:
> > https://patchwork.ozlabs.org/project/uboot/cover/20250314040902.43621-
> > 1-
> > dinesh.maniyam@altera.com/
> > [v3]:
> > https://patchwork.ozlabs.org/project/uboot/cover/20250324083704.26259-
> > 1-
> > dinesh.maniyam@altera.com/
> > [v4]:
> > https://patchwork.ozlabs.org/project/uboot/cover/20250417021840.6212-
> > 1-dinesh.maniyam@altera.com/
> > [v5]:
> > https://patchwork.ozlabs.org/project/uboot/cover/20250513101913.30880-
> > 1-
> > dinesh.maniyam@altera.com/
> > [v6]:
> > https://patchwork.ozlabs.org/project/uboot/cover/20250513101913.30880-
> > 1-
> > dinesh.maniyam@altera.com/
> >
> > Dinesh Maniyam (12):
> >   drivers: i3c: Add new i3c uclass id
> >   drivers: i3c: Add driver for MIPI DWI3C
> >   drivers: i3c: Add i3c uclass driver.
> >   drivers: Enabled Kconfig and Makefile for i3c support
> >   drivers: i3c: Enabled Kconfig and Makefile for DWI3C
> >   drivers: i3c: Add i3c sandbox simple test.
> >   drivers: i3c: master: Enable probe i3c without slave device
> >   i3c: master: dw-i3c-master: Fix OD_TIMING for spike filter
> >   cmd: Add i3c command support.
> >   test: cmd: Add simple test for i3c
> >   configs: sandbox_defconfig: Enable configs for sandbox i3c
> >   configs: agilex5_defconfig: Enable i3c configs for agilex5
> >
> >  MAINTAINERS                        |    7 +
> >  arch/sandbox/dts/test.dts          |    8 +
> >  cmd/Kconfig                        |    6 +
> >  cmd/Makefile                       |    1 +
> >  cmd/i3c.c                          |  271 ++++
> >  configs/sandbox_defconfig          |    4 +
> >  configs/socfpga_agilex5_defconfig  |    3 +
> >  doc/api/i3c.rst                    |    8 +
> >  doc/api/index.rst                  |    1 +
> >  doc/usage/cmd/i3c.rst              |  146 ++
> >  doc/usage/index.rst                |    1 +
> >  drivers/Kconfig                    |    2 +
> >  drivers/Makefile                   |    1 +
> >  drivers/i3c/Kconfig                |   27 +
> >  drivers/i3c/Makefile               |    5 +
> >  drivers/i3c/device.c               |  262 ++++
> >  drivers/i3c/i3c-uclass.c           |   38 +
> >  drivers/i3c/internals.h            |   26 +
> >  drivers/i3c/master.c               | 2066 ++++++++++++++++++++++++++++
> >  drivers/i3c/master/Kconfig         |   11 +
> >  drivers/i3c/master/Makefile        |    3 +
> >  drivers/i3c/master/dw-i3c-master.c | 1062 ++++++++++++++
> >  drivers/i3c/sandbox_i3c.c          |   56 +
> >  include/dm/uclass-id.h             |    1 +
> >  include/dw-i3c.h                   |  252 ++++
> >  include/i3c.h                      |   93 ++
> >  include/linux/i3c/ccc.h            |  385 ++++++
> >  include/linux/i3c/device.h         |  286 ++++
> >  include/linux/i3c/master.h         |  698 ++++++++++
> >  test/cmd/Makefile                  |    1 +
> >  test/cmd/i3c.c                     |   50 +
> >  test/dm/Makefile                   |    1 +
> >  test/dm/i3c.c                      |   34 +
> >  33 files changed, 5816 insertions(+)
> >  create mode 100644 cmd/i3c.c
> >  create mode 100644 doc/api/i3c.rst
> >  create mode 100644 doc/usage/cmd/i3c.rst  create mode 100644
> > drivers/i3c/Kconfig  create mode 100644 drivers/i3c/Makefile  create
> > mode
> > 100644 drivers/i3c/device.c  create mode 100644
> > drivers/i3c/i3c-uclass.c  create mode 100644 drivers/i3c/internals.h
> > create mode 100644 drivers/i3c/master.c create mode 100644
> > drivers/i3c/master/Kconfig  create mode 100644
> > drivers/i3c/master/Makefile  create mode 100644
> > drivers/i3c/master/dw-i3c- master.c  create mode 100644
> > drivers/i3c/sandbox_i3c.c  create mode 100644 include/dw-i3c.h  create
> > mode 100644 include/i3c.h  create mode 100644 include/linux/i3c/ccc.h
> > create mode 100644 include/linux/i3c/device.h  create mode 100644
> > include/linux/i3c/master.h  create mode 100644 test/cmd/i3c.c create
> > mode 100644 test/dm/i3c.c
> >
> > --
> > 2.35.3
>=20
> As discussed earlier, I have made changes to pass the ci.
> CI is passing now for me.
>=20
> https://github.com/u-boot/u-boot/pull/802/checks?check_run_id=3D466618132=
75
>=20
> Thanks
> Dinesh

Did you manage to pull in my patchseries, please let me know the status

Thanks for your time!
Dinesh
