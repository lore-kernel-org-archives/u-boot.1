Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0FCBC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 06:30:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0272888AEF;
	Wed,  1 May 2024 08:30:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="lIwYJbtR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E43A88AF0; Wed,  1 May 2024 08:30:01 +0200 (CEST)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (mail-os0jpn01on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:201a::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6923388ADD
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 08:29:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=biju.das.jz@bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+d4uK1A4YbV6w2ytniOOHz74KFEG95dloXcXR4GvUpgCAfQ3IA6aJlew28BaSEPQ9AATkplRj2sWSCVEvxOfgaSXtFX9zTWst00iO2p4uo4qoMPNVHGA3AtaVb+skxGadbmpkPPCQ6gP3KJEzw9xqxcQVEkHfZ3mN2RVqjACWRuAk2oXSHHivt+3e4GLa04eQIDycf6TTJhKu0i+kKqsfW9jiTKHyHt8Iw3ABMCPiBHwoNFNgrQF4Yd8oNrMncCwl42DLWKw8YVZ5+ossZl2WidR6hJi4QrfihYA/PA2X5JsHQ8QflGA7y5IiwiEqz4NWaThHlHPPJkJIg2eMF/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEFzM75BwsHdw7cruz+Ts6u11PkN7JghUPBLHV9Rh7U=;
 b=GLWdqn1sTITKhm4p+8nV0Kj9jPUXt0v2UF7S1NIYP0VaRxaAc6vr3R4TgbdV+Ewnt9WVKlJ0z+GC6GDFK4Gg0J/lmbCflgJRkj34xJ4zUl61QiqOXUoDjVbau5fTyp01nanrubRZYrDcczb0cYbe3YR2nmzmMmj0eSVP4bJAEPsmTWPq3FjqIS8zd4kId9oClq63X5IM1TgqxxfrCjZatCPelAuIawJeUrhykN3bBs1+kZdnZc0OOK1w9TzPMZKpCwZx3cgEvrC6KiFR0aUyY1+gRgEIA2b7RtPYGjakPJca1VQ8oasGU1eegzppKD/wDnFe7H7UNTTptVUeOe6SzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEFzM75BwsHdw7cruz+Ts6u11PkN7JghUPBLHV9Rh7U=;
 b=lIwYJbtR77zsicFMUX9EIm9rDnAhOE+QX1YaBHfWSHLHw8YYm7bSQpn1iJiEMtsG5zgwPASl6zWxQoF0b7KEwwSrOlOedYSKzKClHXDpyhOMkxMEdHSxOk3BK7etSIBdYSD2NVxRzfCykEU36BALWUznOX4Cw9ukA/wQh9O1ERs=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB8746.jpnprd01.prod.outlook.com (2603:1096:604:152::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 06:29:51 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::500e:ab62:e02b:994e]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::500e:ab62:e02b:994e%4]) with mapi id 15.20.7386.025; Wed, 1 May 2024
 06:29:48 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH 071/149] board: hoperun: Remove <common.h> and add needed
 includes
Thread-Topic: [PATCH 071/149] board: hoperun: Remove <common.h> and add needed
 includes
Thread-Index: AQHam3GHW461turPA0OimvVhmsclQrGB6sqw
Date: Wed, 1 May 2024 06:29:48 +0000
Message-ID: <TY3PR01MB11346927FEC8FB5FC41E4E4F986192@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-71-trini@konsulko.com>
In-Reply-To: <20240501024316.1767971-71-trini@konsulko.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB8746:EE_
x-ms-office365-filtering-correlation-id: 9e52e603-9f77-4474-6072-08dc69a81981
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?ucOIDoFFPaQlZFj1DTAzeq918aslfKYwNqU01iHmp417/WjTmTqkmk+0kp9N?=
 =?us-ascii?Q?nrdEcfHjfjB7CmQ8tp3fhcPpXzIwad7h0ICP3riFwOygfwHMSD/IivxkbYLW?=
 =?us-ascii?Q?7uecGhGdovpx0OTynSxjJxINHlGdz8fTo8k4VAS2Q0b+QhvhS9zTKhgKDvYf?=
 =?us-ascii?Q?a2NLMB9hG0UmTT2x2Yjgyk6bCeq9rJQsQpg5b8AbajBQySrnj4CNb5RF3zTB?=
 =?us-ascii?Q?Me80GRfN1XLQdbd96Y7b9weHsoHi0I3dMDEO2vbqiRbvlgXeQNu8VKrvcoeU?=
 =?us-ascii?Q?rbWdIkooBYhNXhHU8g6g49LB0n670pITHHlQJmPZR0udmbJgTzBI0KZu+/2f?=
 =?us-ascii?Q?dYFTq6Jsut01O32sZYEVOzyoDj6EUQDCVZOcyqiRND2IX7yFn6MR8wiDBx3f?=
 =?us-ascii?Q?so1gFYwauCW7d1CG+AhcS4YDHBNbTPvfX2rIfQKHsdAtrpcwuYv1dTplFwVI?=
 =?us-ascii?Q?RTQE93JZUB2f7ce0aWvFp3E/ac1x/+Kzy6/WK/A0zae456Hgzgtap2eseZl5?=
 =?us-ascii?Q?qwvb+pAUmguRmm1XS1cjze90SGAFPYAkUcIy2oQiDjps21cQtrIi4E4UMSew?=
 =?us-ascii?Q?TQ41mcvkYY9iUFqdGVzl8CcOgph01xYTXeSkGiMhNDNwRvk7la0fEEeil77u?=
 =?us-ascii?Q?6dtOK954W05OqQ2vQjOQCwf0jkuo3NtbZB5zmh1bjfLJYUgN6RvZTEuZSXui?=
 =?us-ascii?Q?PJo6TlGiQYQsPY/cvqZtfyY+3/ankME/rCTrjfVEzeDz1MMGO/HqxGYEpwFx?=
 =?us-ascii?Q?Y4A51eCI+i1mPkW28EL1KNwVBSVQWZhWP+cTSfBOqEX3+ZP09G+8/qMCySqJ?=
 =?us-ascii?Q?7bX1sSnS+9AZqJQe/OSvoBxRzS7lYY3hDeF6RCX4kD8RbksiPlb0ztAlXoeg?=
 =?us-ascii?Q?oRvKQd2NQMGGyDLXOiuGuRnOKhs3nZmZ9Eb5X0zKr8r1N+qR/BmvkCeY8aSb?=
 =?us-ascii?Q?YUJi9KsxiCZ5NliccXclX9vjpLXV5EbP9mZBprQ7GVl2DUSruSJYngTwarTe?=
 =?us-ascii?Q?9v4OVC6NNWahQ6y+KBFX+3Kx/hUPi59VI3tVmWsgmYgvxYlmHduaCuU6uV0k?=
 =?us-ascii?Q?D1sLWgWwxvheMrU3Lic8R7zHaG1upZ0YrYjP1ixiYNLUc4AneHuHicvmak0B?=
 =?us-ascii?Q?K6Uj0gC5pKL5NuCFC/1aX0xaN01m1/iIbsKOUqIKUFylKz7s9dgPA9Viz9Lp?=
 =?us-ascii?Q?1mQn+2A0i3Tm1+Xdv5zp0gZ2JN9SqrPw5f1q3oOjO9Xb28CWCH9CXg1938cA?=
 =?us-ascii?Q?iYu+lJkor6ua0aIN6velIvA8/K9Si8wPu5dRplesE6rG4snJ09/lWbxhTwCQ?=
 =?us-ascii?Q?RPsgvvPMWPMYuVl1Pk/l0YDtQXYabtsdm3M0dxaQp3PqvQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7wFpfeek8s8Meup92+NbfG1vJ3yZkFS032oeEnZVj1O4Pn/CkjjRWFdUIKz3?=
 =?us-ascii?Q?sCm+0QpcM7KpqJBiDchmf0kcX4kSQFV29tRbHikU68woiP9VxkuUivcqc9OO?=
 =?us-ascii?Q?sBH3OJcmQHR+sz+ptBtcF3Q5fEjb6mdKqJarCzgT/Z90FU5y3JBanGNx6wu8?=
 =?us-ascii?Q?w0NOE1yEZ3WTQCMqROyEvlWMSBzkKONENZvcAllR2xto2hSYe2T09aKj16gm?=
 =?us-ascii?Q?YlvYzynkPQVVs/5opFZeM0prJQq2OV3ZTHgEMb+kpIDlbfnSCNom2hesLGVO?=
 =?us-ascii?Q?J/3key14mkwv1rdhHfGXwlvryu57qMC2a8p31dxipLlo3bUbooKEyPYF7KtH?=
 =?us-ascii?Q?TwNv3ztCd2Qm2EI7o74gIvzeJrqqMD7crRAsohtEtPHM+i0bc+Tem8ft7iCc?=
 =?us-ascii?Q?YYfFvIffBKSGI9l0zwYtX0SC3Xyaj84mNl4KG4qCpiws14pobkwDVEvz9eT5?=
 =?us-ascii?Q?CRU7xDL4+VjGT79fe4XDvZEu8DqN9ePnMrQZliuk+tGxI+Io/IjF2hP4ExiJ?=
 =?us-ascii?Q?Kvfz69KTUT7IDISKPyzVkyhriP1IU+O/BUVh9ImSavrfoqdzmtH6HlCx+M0P?=
 =?us-ascii?Q?aba862RyMcF2XCx0CUOH2vkAjcVo4NAY0XX+jmJPT0GM7cF8Fx0G1ta049/l?=
 =?us-ascii?Q?qrj4gcOLGQDFfjuf7mSDFk+FVjRpNs5XAf897Rn4q1XamUxFQzlWILBXlMbm?=
 =?us-ascii?Q?RouXb9RcyWBJLMj04u6C/JrKt0qpHGQvsLQzTPmfhDyI3qMEba+nP/fy0QIP?=
 =?us-ascii?Q?QcwruTsfsSmF8HVHjrzrWO189a8OHWY66J/chFbZtPO2RaPIMmqlYZscj48o?=
 =?us-ascii?Q?TlicUezkFSXRU6q8ojMI7hYWXrfLyFjyagqSDVcWTUv88HyglLIj1PB6RNpz?=
 =?us-ascii?Q?zrbUfhM4PQ1Qks0cJ8+J6PYsJVR5IRfE9KxJZfud5MyQyRYosuGMwAId2fXS?=
 =?us-ascii?Q?GwzK2ywU391p4KRkcOKTEeZ0KLYntqBneHO3EUexucWSpXC7jbMPTLYhPdk8?=
 =?us-ascii?Q?IdyyoY64qWHrFRHpUHpK0ItkkOV/a83UokFDdEkGB8tS2i8vWLfbgRCXIooy?=
 =?us-ascii?Q?Gh17pp9wQr8+GidfE+EKjS+2LD/0OqPHgY/qG8ThKg65A8Gtnr8DNvprGryz?=
 =?us-ascii?Q?1hfiz8zBmGlbKqvLZjEPyCZilv7uXL2bhFzPRwBCQdSKA2bfjaEZyoUkUsuF?=
 =?us-ascii?Q?d8O6XWE50nQZU6ngu24M96h3IIrzBi6VrSsiYNcoUE/D7dMvlYCj23BLvk3C?=
 =?us-ascii?Q?0cZAJgyPvPi6q4LOmIN5loqqiG/X3I3qRKYbY905nB92fe3j2epmA+DxBGuX?=
 =?us-ascii?Q?t6QPEa1wJ7Z609NH0SlLJYz6WInDIZVh3MR0Oh5al8ztGH6lrRmgRQWLJ34L?=
 =?us-ascii?Q?R99INPpRq5Fr53zA08Eu70aOE2Dj5qZly6NURq1ErpDapFKyDlqYDMnBVzEW?=
 =?us-ascii?Q?axcgdMAjQUN9eQoL3QJaZ+wXCp/dWNTEYnTv4cqxTA5Yix6kZi9skw2CjmPL?=
 =?us-ascii?Q?mTlevxjSELA2kMNBsZ7Ss2ohdD4qyOpqR4aGiB9VUyxklwsW+f07MMelB5YU?=
 =?us-ascii?Q?7hoHP0/UQBuzKz/oPA05qPoyv7b/XPjvYWSQ7YmD+sJ0/ADb+T75I/xtyy+O?=
 =?us-ascii?Q?NA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e52e603-9f77-4474-6072-08dc69a81981
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2024 06:29:48.2927 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hx43CmLcyQSQWzqDmxzodSGeV8xxdKRHOvWrRCi3sXuTMpLW08IPO5qi0Qsio4+rd2Ydz791tU+btpxnLR08mES9cAcZW5g/Y7GSAXxIJw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8746
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

Hi Tom,

> Subject: [PATCH 071/149] board: hoperun: Remove <common.h> and add needed=
 includes
>=20
> Remove <common.h> from this board vendor directory and when needed add mi=
ssing include files
> directly.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

> ---
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  board/hoperun/hihope-rzg2/hihope-rzg2.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/board/hoperun/hihope-rzg2/hihope-rzg2.c b/board/hoperun/hiho=
pe-rzg2/hihope-rzg2.c
> index 68d3d300dc40..0966e257464a 100644
> --- a/board/hoperun/hihope-rzg2/hihope-rzg2.c
> +++ b/board/hoperun/hihope-rzg2/hihope-rzg2.c
> @@ -6,7 +6,6 @@
>   * Copyright (C) 2021 Renesas Electronics Corporation
>   */
>=20
> -#include <common.h>
>  #include <asm/global_data.h>
>  #include <asm/io.h>
>  #include <asm/processor.h>
> --
> 2.34.1

