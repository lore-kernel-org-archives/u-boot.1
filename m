Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E17CA0EE6
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 03:27:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E55781FEE;
	Thu, 21 Aug 2025 05:26:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Px7DZet3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8733482E37; Thu, 21 Aug 2025 05:26:57 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E59981E13
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 05:26:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxoCMfa+OhTOJ7HaiOz2TuTqUTFAVg+9OTANdf21tYxtd+CTMMDcxX1J/2TblW43MleyLUd4Yp6EcVaWZRVAdmW3jZTmxhihif5wmbUWqv9+KrHbZWuwe+2AXwbO9/Se/T3JpDytohoNA8e8TMUijqYNcknl8z2EnsZcgSKij3qnFloEaS5wcwLbqZC650FoQ9qXiCoN3/vKzgywMg13QGU/yrdKFscvLRHRsnnuhRrx0N12EwyPmx/r5Jig+dynSpu5H7+HnRtniYtvvYF00WfodE+rMFKDw1ODIDdUz0bi3YteJBEMlPZXsL7l13Fd/T5s4gm+Ia5BVrwSHLYC1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oE36LhBhJkxmg9unFbz2lTEGeMfp2wiBvPyZgZPxc4Y=;
 b=TrdREjYarGmbdMmHAJkjv/HtIrx9sl+8VqwMNwQS5iYz4KLkvYolmm1lI7i8fBa9o0wxs3kMMnMSjbhycbGvAV6c4Y4/1g6q9lKJLSBL1KpwZkeD1aDaNgSPmBrquD/UEIdu6YyzMFZjNLaA9ZtKpLDqAnt/9kVQajOXRHPQQ0zeU07Ll/3jT1Bc6xiv/yKRLWy2CHSA2epFtwoIkKfXdnITsmjqygg+xZTBET4n/I4+g8MGFGkS9RrkY+y5kvk6OSOpE+Fz5MIbenkjJAit9PGC+Foe/osyHmI226XAGKfCQHsJtJWF0cBkqk5MHrq6n0x9s0CqoRww9obkQAxZGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oE36LhBhJkxmg9unFbz2lTEGeMfp2wiBvPyZgZPxc4Y=;
 b=Px7DZet3zVt9ICBYJHH8YuGGWPlF0E/YZimF8PA7VI3prK0RnHHkvwuTx596d6zv2kcYiKZFG4/Ciwk4aPK+76hpVO9fnN0A0YMoMBugtd70mI+op4/wHIM9fvu1nOlT1eV3kKEBO/ig6B+f52GWShaeCHEmEnX+psNI2NV+z9guB9+Hc9CeJ+ejkpaBg6JtWRQ/DKylSBneZ4SzAFoNoun0vPn96z1ta41h32cCz5uu1OrHby7dqgZujlK013qOg551Xm0Smvym/EJGXwEvibFx+pjvBW5R8+Vx/ocAs8CZmTTKpxi7ui6sIij5+p7mnlhrCpnBN9Tk0fw/9i3Sfw==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Thu, 21 Aug
 2025 03:26:53 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 03:26:52 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ng, Boon Khai" <boon.khai.ng@altera.com>, U-boot Openlist
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Marek Vasut
 <marex@denx.de>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 "Maniyam, Dinesh" <dinesh.maniyam@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Lim, Jit Loon" <jit.loon.lim@altera.com>, 
 "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, "Rao, Mahesh" <mahesh.rao@altera.com>
Subject: RE: [PATCH v2 1/3] arch: arm: mach-socfpga: smc: Add dcache flushing
 and invalidation in smc_send_mailbox()
Thread-Topic: [PATCH v2 1/3] arch: arm: mach-socfpga: smc: Add dcache flushing
 and invalidation in smc_send_mailbox()
Thread-Index: AQHcDMoMC7LUoiiAN0ClKX8ihT9a4LRsfTxw
Date: Thu, 21 Aug 2025 03:26:52 +0000
Message-ID: <LV8PR03MB81371BCF7FA9DC9FF8AD17FBA732A@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250814031741.4887-1-boon.khai.ng@altera.com>
 <20250814031741.4887-2-boon.khai.ng@altera.com>
In-Reply-To: <20250814031741.4887-2-boon.khai.ng@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|IA3PR03MB8021:EE_
x-ms-office365-filtering-correlation-id: 9175041d-9689-4403-884f-08dde0629253
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?1tSPLnNX45T4nrHkh9VxJwaaPZtNlSc3ZxMVqqfTyahshMh7ZWL1oPQei/1C?=
 =?us-ascii?Q?q7DR5C1+1l87ZiEGPGb2ftIHM7G+GI5W0zE2mAqEY7enhvgXU5b/JqyA6SPr?=
 =?us-ascii?Q?bJTGvfCPdT99/xdo9txbC1JCmAf02xd4Rx68miKDmRdGOZaok70XbbFsoiXX?=
 =?us-ascii?Q?DZcTG5Mj8ApqSUYLmCYlpD7g7iUskWNcphciTjYRSsHvTPc86b0L0Q1WZtLl?=
 =?us-ascii?Q?xFirOc2/IfFFBnK66L5hkaPsgTB7xR+w7unCk2b7pG47PTBeVNnrHxRrI6HC?=
 =?us-ascii?Q?dsQ9G926mQTWP5zd9kKl4Gz2RXt3ujT+xpv1bSYlEu9XBLDnEIP/su5jOOM7?=
 =?us-ascii?Q?2r8t8dtiDHoct0o0zhj9inVPdqx6QNVNSvVrxfev1n5fPzbp+l+x0wrh8ZCa?=
 =?us-ascii?Q?Hj+vGcA6Pz9eoKFI2J9SxlykCu3WbS5ZboEIdP0CvS8moay7PYT1FZPG4GVv?=
 =?us-ascii?Q?17+BtjMi0D9EGwteuNM/SYapy6WTl1OmCHeh6oICBLE5lAmXR/p77hYSyO3x?=
 =?us-ascii?Q?zDj8mmvo7LAzFwghSjnm5f5Y5hbgGmg3DtuFtUuBr+rYmOklV9oiJBgupdZ3?=
 =?us-ascii?Q?NnyxVSO/vX/oLerg5rX19q8oyefe1U7n7W7AabiYIGEFJhN9s43j2xu70/Av?=
 =?us-ascii?Q?x9aY/+39XPza0wzeZnfrFMLLXf6ra7S46dIaRhYI0eq4L8pu3Sqr5ZSs3RTy?=
 =?us-ascii?Q?pFwwVpz3ssLPMG+fpSBgoVosacrSOBvIPqr/XKtR62O5tqUBtFDtfBH52N8D?=
 =?us-ascii?Q?XfSQNWEAaBZGvapIEgd7XqT+OuI0eitQkxgFWxXGdqKeU5fcgqAanK7asB+3?=
 =?us-ascii?Q?boBkUL50s0JhdFkYAy8oBtVJ69zvD6mjMNTmXi0fDBT6jnF9yK8inXXqL4fM?=
 =?us-ascii?Q?Z/bheAl5h3SxFZ8WD+L24WA6RM1WbRz0aR+F4WI4WtvoloE5VzC3fKzx84pr?=
 =?us-ascii?Q?MUrePGSQLDdxhWhIg+Wsv+wq6Qqjex6wgbVvWi8vX8KLf1dzYCFLag2t1amp?=
 =?us-ascii?Q?do5D3Q0wEPHgvzUjDW3qLyoWXq9S6rwzlmX+iz1Qs5qgIaaOJPrPGjQb8CoA?=
 =?us-ascii?Q?tlvIdyWlHA+YXOhQgCSuG67HBHqTH2ZgwgC+1G2Pyo6v3QHhnFkViL9S2C9r?=
 =?us-ascii?Q?NztVOyGB7oFMUwz1bTHdCFjflR9koLpZhlCUU7t5BGldkHptH+zrCY/pHory?=
 =?us-ascii?Q?JYngLaYD78JcsPaLzvrCXtnkDPy42lKThyB2J/Ogz9ULB5ZnLpWrHtSKnFbZ?=
 =?us-ascii?Q?C8bfDQtneCdBzbwlDdnf9imySaKepm5YFpiyqnzNgQE+7koslo87vCN5VIiN?=
 =?us-ascii?Q?XD3faUp/FgTSCxuRVpg/Cn7NcB1S1Yj3rZBGj1vZlVN49y1b09jMZbnwdZkE?=
 =?us-ascii?Q?1/Ko592zh2ru2W+yuIPum4JEJ67Knf4KOPwImGkIR9IIQM+XwmHIjfxrd3pl?=
 =?us-ascii?Q?4BMal0MdwiUvfZtvYxmbMsP5qVfVNlxt4S9dihVNsVmahs1QYy8QaA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gxYDIgzsohMc1nbJoi7bpO3q0Gg/2OzFVizCcvwtaJrmU3a6t+dWkhrXJmKO?=
 =?us-ascii?Q?IU0Zc73okYpiaqwzJnRWWVnR8Duzj0yooVm+RbJPXPpCFB8qTlYmN7pgV/fZ?=
 =?us-ascii?Q?9i6EHgTHzaBcDRK7NaIAcibpUxOSvUvhxJiGGx6YcITdKKNdtS5zzXpMhdUe?=
 =?us-ascii?Q?cuM0v9Xsx4IrMb/rSUUJFPMkxJG8BiM03TTgwL3DBXFH2MUyPtKDwDLxlTbY?=
 =?us-ascii?Q?uYUomKrqINYt35iLft/d3bhBZbWrSNo5fncMSHNSBjddRSGjCrGLLJp+s+Eh?=
 =?us-ascii?Q?8t1nChsa9A4MUWxXOZ4h2aNK57GQB4Qkf1EwH4kNWLcSoGbIqrVeH4u7BrJV?=
 =?us-ascii?Q?VUBRdUpdA37+XyoZHUIosUEksn/cMaAeYmRnFEPx6ONJCU/c97ZMoPs4bfz3?=
 =?us-ascii?Q?B2GjfYJ5iYA1+VOfnZLryLYXvtLxfNpslkPWGCRShReWnstUJqL6jgOWk4oM?=
 =?us-ascii?Q?PjDdn5Ef5oYeDHfX65fn/lpmrywODp+aPGGlI1lNuvhUqcxOjpxnPtCYRITs?=
 =?us-ascii?Q?7SIVAc63Fupf+OK5ya4Srj9W2wyw6fDZg1PdSDylycusTeuUPqYosKTE5eie?=
 =?us-ascii?Q?LkufSV/Gdmb6uBkhUocSYl8oX0wCxOM4wQkUOx8ezL3fP7loqxfIGd0C2J6t?=
 =?us-ascii?Q?VNjuIAVsbL5Ywk2ltM4uGkDKN1XiY2fJZXl8m5Eqgri47qgPgbxIluiuZSgt?=
 =?us-ascii?Q?ZPty8s02GS8HWq5ZInbkgo0hGhiX21BqDKIVJSm5Y6kLq2xWRXIrWLNJXtul?=
 =?us-ascii?Q?nLuybzyF+QehwTIvGuqhhs1h81zm2tn1y+ydHSxZb3+0dMzHI1eXXGFDpzES?=
 =?us-ascii?Q?1mcrbWKi4i58c2ssRreMDcDMIKPFnIUk0aVD0arsyAfrKUhGcTlHC6SnGhMZ?=
 =?us-ascii?Q?yhJ/0FvGFuhWIFf13p9SlHJMEhKLJalr2yy+3evKrxzT7cxZ3HjTcXFg5RMo?=
 =?us-ascii?Q?XKDBH95Cv/NHr6BrD0mo8jklq0F7gjcYw2QF8FIAK07+xJSguceau7h6cdDS?=
 =?us-ascii?Q?jtg7nY31imJY8ArQHINl6pFveXXNVwNnTBV9wdpDIuOjmA9sC6+kO2q1ZIqG?=
 =?us-ascii?Q?Nq1bfS0q5Of2yEsE1cMVZiRV/uNW9j2NTD7bKSileaDpNB7BBMF0cCLP8BSF?=
 =?us-ascii?Q?HA5YairhllbK+eo9EHSSk7RgnJ430YUQJJ3uKAP4yjxp1fLOt0g1z1aHOpAK?=
 =?us-ascii?Q?ywY+74rgFvpkxEYfr1kU1JRIXpORCSxqGzsXgR80AyTuEhbkN9zg9XCMz5c0?=
 =?us-ascii?Q?raJfB8oK2BJBrDsijJUUQcvkyWpdw59IxoXIxRWOVMmaiFoPl8E2BkprL/12?=
 =?us-ascii?Q?H2remTsAEUzwL1CMCBKcCYL9uddh9zOA+cZi7beIDRVBTV1pe/CMimEvIaJx?=
 =?us-ascii?Q?AEglvug2efEDi4m+VX51C2jLxhEJolWK9w7wUvOeL3xq5lXxjTik6gUdEPkm?=
 =?us-ascii?Q?+pDhzx7a5TFNfbPfH1JYOTscNOYnIrnnoRq3wpBw1QfPLHpZpOXuI6MyLF7n?=
 =?us-ascii?Q?e6GkSpgu8nYqSnqag47OB8+qjPU/OWY5cXxvsJ5EAWQvh2kEhAUK9165AO79?=
 =?us-ascii?Q?BMNNnGbclmOndKdXBpk+d9xJJSOFlX/Bds/MdE08?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9175041d-9689-4403-884f-08dde0629253
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 03:26:52.2267 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Opew6Mm/a8eF3t+XIT6mpl8ZdEa4PioyopY7EFPffcIGNFuIENPNSHT7Ti/raEPlVeuESFtP6sRrB8bhNCqjytx3XoteQRb6uo9ZEZkVZhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR03MB8021
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
> From: Ng, Boon Khai <boon.khai.ng@altera.com>
> Sent: Thursday, August 14, 2025 11:18 AM
> To: U-boot Openlist <u-boot@lists.denx.de>
> Cc: Tom Rini <trini@konsulko.com>; Simon Glass <sjg@chromium.org>;
> Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Maniyam, Dinesh
> <dinesh.maniyam@altera.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>; Lim, Jit Loon <jit.loon.lim@altera.com=
>;
> Ng, Boon Khai <boon.khai.ng@altera.com>; Kathpalia, Tanmay
> <tanmay.kathpalia@altera.com>; Ilias Apalodimas
> <ilias.apalodimas@linaro.org>; Jerome Forissier
> <jerome.forissier@linaro.org>; Rao, Mahesh <mahesh.rao@altera.com>
> Subject: [PATCH v2 1/3] arch: arm: mach-socfpga: smc: Add dcache flushing
> and invalidation in smc_send_mailbox()
>=20
> Adding the dcache flushing and invalidation in the smc_send_mailbox() At
> the same time replace the use of u64 with uintptr_t to ensure compatibili=
ty
> across different architectures and correct the pointer arithmetic for buf=
fer
> end address calculation.
>=20
> Signed-off-by: Mahesh Rao <mahesh.rao@altera.com>
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
> ---
>  arch/arm/mach-socfpga/smc_api.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm/mach-socfpga/smc_api.c b/arch/arm/mach-
> socfpga/smc_api.c index b212a94b321..a531030f5be 100644
> --- a/arch/arm/mach-socfpga/smc_api.c
> +++ b/arch/arm/mach-socfpga/smc_api.c
> @@ -57,6 +57,7 @@ int smc_send_mailbox(u32 cmd, u32 len, u32 *arg, u8
> urgent, u32 *resp_buf_len,
>  			 resp, ARRAY_SIZE(resp));
>=20
>  	if (ret =3D=3D INTEL_SIP_SMC_STATUS_OK && resp_buf &&
> resp_buf_len) {
> +		invalidate_dcache_range((uintptr_t)resp_buf,
> (uintptr_t)(resp_buf +
> +*resp_buf_len));
>  		if (!resp[0])
>  			*resp_buf_len =3D resp[1];
>  	}
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

