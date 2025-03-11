Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C073DC28B2E
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:13:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F13A9801FB;
	Tue, 11 Mar 2025 14:13:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="FIsiOndK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A7A1807D7; Tue, 11 Mar 2025 04:51:14 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::625])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E173E801FB
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 04:51:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZJDSRSoR4ma9NMkkSWEEICPXuBJswy7EVWBqwY2n7PRsDntzjCyl6JSfls4VDoruBUHgf2sGU8WkZTO8WMPWzlTIz1wG0NxL3EHlxJ3dYZWgxpGfvyDgTfCRHYL/8nS+cnS0OOZko4Tkr8Dq1npntKXjA4AtK4oWc9biBJzlA4ph+Iy9EPvI7AfwjaNRQjbmgfVwXeNK5l7vyJvCC+QMtbRSPAOfHxFLgMnGDXpsW8pp5gU3GWbiZ4SNdUPIRfiXMEvrYeBIHh1nMYVJ/anXUaqjdRTL71t/TR/zDAUSTL94Pgg9RwntXPAdgfTopL2aXtKG1mrRNlQQ7P1CWOlXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8TwEhbOqEGYVhoEOhUt1H0A7wIP1TENE8WOBEJnw18=;
 b=S7vkIzAcPo5ZNLxopeb2t7DicePrRKbQncpk6ZATscdRCcyTMg5VKFRMVvBfsrjIeGX3CjuoaHZUwFEeu8KrzL+X680GFarsUzBmEHtHFKosRbzNKfHmupH5e1n/Jbc5Q3DGa+9y0W9K5lr56ugQvaWtEl3gBGrPmCxk6ssRbFmkEmTS4rMpJPCded9nnMkJvKP6X4tBixUkb4iuTvqEShm1j0DL0P3fiq3hmVuvPUmTKHMNAbJMeJMYjIoPquGKg7WmKBATqxuPB37pHT4atG/SlvjVBJNBV5oZDDxzRvqDPr4BmHVdogpIfTN962lUkEnCBH4MFCZK4g8rkIjZyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8TwEhbOqEGYVhoEOhUt1H0A7wIP1TENE8WOBEJnw18=;
 b=FIsiOndKhoQuXa3cJ+L6mWGDIdPzj4yhDgupVcwtw1amnQ/kF2/QSG0460K3GnnNCnKm47EGDlx2SYKSWaGFC7yM5pxXYjryXmgi++Ck9gmk/QSJr1r6our8wqR1eEOmw1w3faXvmyXo2za/29I7TrbxttMeCaye9WPZfkdxpi/lhxgTLzvelP2CdnBbEODiKYGefCi9J6nF9GdEv0jxz6ZZ8VUY1Yi/fp7esYprbREnd4XQr3a3QNWV0IrEyRXt1uhBX0+47PGY18ghnhIbWrpUGHTq+9lnZvFVmweQjwgwQyIIu9Fp/9IjTZ+hI7qUWJ0l9xuGu7BnKmOJj9Gihg==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by PH0PR03MB6607.namprd03.prod.outlook.com (2603:10b6:510:b8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 03:51:07 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%3]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 03:51:07 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>, "Ng, Boon Khai"
 <boon.khai.ng@altera.com>, "Lim, Jit Loon" <jit.loon.lim@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>
Subject: RE: [PATCH 1/2] arch: arm: dts: Enable kernel itb file generation for
 Agilex5 SoCFPGA
Thread-Topic: [PATCH 1/2] arch: arm: dts: Enable kernel itb file generation
 for Agilex5 SoCFPGA
Thread-Index: AQHbjMNMhn19Fu8WZ0CwcIS3boVF5rNtV7RA
Date: Tue, 11 Mar 2025 03:51:07 +0000
Message-ID: <SN6PR03MB35839034E9E921241E7F2DC0A7D12@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250304050644.15174-1-nareshkumar.ravulapalli@altera.com>
 <20250304050644.15174-2-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250304050644.15174-2-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|PH0PR03MB6607:EE_
x-ms-office365-filtering-correlation-id: 65f998a2-8222-49e7-67a7-08dd604ff460
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?a6nDApojFyYvOHf3qPWI2wq9p5479HyaAj0WVN1k03xGt66u7pJh4gGHSH4y?=
 =?us-ascii?Q?5VN5o4/uLciqkd6hOedF/RR33U+zMQQ98jZg8+xoco5gs6RolLLz69GNZZw3?=
 =?us-ascii?Q?05lAxButsRKqIofb/bMgQ0+4QYCfka0hGtur44m92cj1zdbZrvqc3irHxITg?=
 =?us-ascii?Q?TEsyEHtMfKJFibHzZG+6ZTKZO1rAnataYzVE7zlVmmpYvuL6hWazkET3kDjG?=
 =?us-ascii?Q?LJ6dGJaXmAkqf6kkoIq9NGB4wBVpyQGnKrXNjcP0v8tGTLHsS/sBIuQ6hZ4t?=
 =?us-ascii?Q?fpjPnUELG+QqToVsABtW6dOnqK1aNpaMf4wCZy3qobFOHgnSNQc5VFE9U1Qi?=
 =?us-ascii?Q?mOtc3LvUHiVbbpxyNRtTl+YEVkmB96t/hiUZnq8ADi+ODPr+2lj8BQqd2GcP?=
 =?us-ascii?Q?S8TtyWkOJLWmE8AOGUnERo8sXgTAsX8REpum/Oqs2ImBT3e7jPoOPAqWQFKU?=
 =?us-ascii?Q?BCFtr1toPpnDoAH3OL1xh1Tt/4+ehr/nxCd27UjP/zYHleTWpyyGiNtIYygF?=
 =?us-ascii?Q?NvayCu9cKkwShaB78XhypgD+YrBMmhz7YtvdNQFPOvkxyh7RdqcE4K4xge6M?=
 =?us-ascii?Q?sxBJohSBWA7d0+pGrNLg9qsOrlEQq/7lwtsTZvuSlZ28gcorSLY68lQjBmkA?=
 =?us-ascii?Q?epSsKlL5L9Xv9tXWnohiobz9pamJcwO1YoWOlxiY9b/F77uZZZwaW6zAkG6W?=
 =?us-ascii?Q?e0CiX/3GiZ5Av9X6aB7/fgvgNyhIL7a3CbQs+Zc9iQQFPvekB5e6sdDHjLTa?=
 =?us-ascii?Q?IvMbQSIOl53lE+D6uWaSP4ev1cPiKe5IaYesjiLrD0/BU/NXX8KifkevO1xc?=
 =?us-ascii?Q?qE1y8G1NmQaRR9b36xugPUPr19CmqlK9E5rlwenTSyys5KckiITxG/DcQhpp?=
 =?us-ascii?Q?Lv395ocEUGy50JacGH4D1qB79Dy8eX4vX6fpUnXhUyeW0xfoa9inaFdzWQcb?=
 =?us-ascii?Q?uhM72IDvicyZYetO4rNLM4D1zCoS4b9TYgg5+68iQM0mNGtVIhPS+CPDh5s3?=
 =?us-ascii?Q?+j3Zr111yxqvHpZTOenCC32srbwg63UIUjzT5GmgkPPvM2tpPXwSFWYEntWB?=
 =?us-ascii?Q?jpphLiWEQ0Pbkr5wrhZ6kMxY0P4yjuJn+lfROzijhSSPTV7QM4x0CnS4ZO/t?=
 =?us-ascii?Q?Xjp8AdQ720YITApXdP5AsIXyQ3xIx7502hGoWQjtFYIVQ69JMH+cwYnAmLN5?=
 =?us-ascii?Q?a6hhHqi0+IjUXnywww0NcHcV21OXcVHzxmG3JxpB96bfVe/vq0nxyCuuuDJ/?=
 =?us-ascii?Q?wHXPCY3CuWMotX4kuCNCTMun9y5yFcdggN3M8JFUsKo8dl53ZcVeKy4h87Oq?=
 =?us-ascii?Q?PAcEBIzXAhbIcSCYMXSLuzA7KYGXQtB3pevsEoCkZnkokToTIvMjNHdpnqUU?=
 =?us-ascii?Q?pSjx9VOln1eDd1HRPuCPfTpGl5fAn+WuZZycs3VsUufkUy0ILQCPUW1RoOgy?=
 =?us-ascii?Q?EwzHbQcp6rQDlhf55iHUpYxRy9RzgWyt?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zact3TE6BVcLsYXa8NmZBqCZ6IxREg6cV4HyKuAK0yRPiBqs/AcD9AY+3+VA?=
 =?us-ascii?Q?Y+ui3NwLLzih87TyWeCK+B/h4zr2HhoBFKF/urbPsqG3ETsuE5zUbl4B9srg?=
 =?us-ascii?Q?+azjR9LZ05RhSB9qIwDKAdK4PtT/Gr8I0CQpi34TvMxT8nN8VOoSEDmIvufU?=
 =?us-ascii?Q?A+Wr34ee53jaDeU0Allo2nJ5doFQ6CDxVse+HfNaL/+IrjrBs/sQIJhdjO5U?=
 =?us-ascii?Q?RuT0uqQgQ48aK/ibwi9hvuO9wLKFG2xbK+cB6NGA+lCUkgYMvY0Rf5Tb9Mn1?=
 =?us-ascii?Q?PJs8OK5QCU1RS3CNbTEMmKkAr1h4vSOVpgosEDKkz8JBlrKCh6LU6pGAEQ2e?=
 =?us-ascii?Q?ijxYwJDyCRBSY2x/8QFI8W4y/oSpsOf0Z1XwZKYZ5LoH8QWjt1ETIFJXhkKk?=
 =?us-ascii?Q?mkRRKoGFbhh8oqmhbIKsfhIUVjioYjhzMQGX7yN/KanFVNyaJc3f1d06Foeh?=
 =?us-ascii?Q?FeiazFJz+cC4tIQPSv8s9WUuAyLZabP7+NdZ1o/8JRFECwL9MfYuldH9iTBM?=
 =?us-ascii?Q?KxQ6F65S/XYjTDIlMvJffUg+gRmBbaZOHHr4HG2uZ9o75lefhkLZXQ4OEU69?=
 =?us-ascii?Q?i8y7ScjPhX6aecStuXW/msK29O6FZUIw2h9U4SAEtU0UsobfGSUIDVXrw/ub?=
 =?us-ascii?Q?x+e+VvahtzWgnaKyq1IjL4B0uRrnuEspc0NwsuiDMxHNbz3LFh0OAfbtoBLr?=
 =?us-ascii?Q?+flp5DGB9PZ1TaSrSACFx+MAeBbKWWvDfHH7Tyq0e7X3z9NHy1gGWzCPcvmD?=
 =?us-ascii?Q?DyJ3Egi8JRWVi1x7XeIB+6v1xhbg3ywVzrAzACne+1IYU++7CINJP8zUnibs?=
 =?us-ascii?Q?3x1qIseWLKsTIn+H34PbRTmfXbfrc/emHh/589SXIkxQHQRru53OrMl5XT/O?=
 =?us-ascii?Q?+j/dujq0aOPqP97iXrSHU6S/OgGajPRqK1ABrSZDj/aF2GHb+j/L/2aNWv9H?=
 =?us-ascii?Q?ilJDiZ7hQZNq3Dzgf85B9tSKbP5KzX5roHjP35LG4hy6gzYYqXKrxL1+quSC?=
 =?us-ascii?Q?y3EOH6t55iycnYi/Hs5jG3+se5ca38laTVcQlji0DoyTT8JawfUx/UoIXIO1?=
 =?us-ascii?Q?Gw6Jbr7xLm6smMNRgpRHJ1W4+jspS9q2/0+qhvlXrtifXi4eM/0nyGQLshy0?=
 =?us-ascii?Q?bMzXmQ0uytrxWpBEUabcr4a7IJkPf8y3O6RxZWoVgPN3OCuD2BRP+ExMFa67?=
 =?us-ascii?Q?i7s5Gv/qnT1GcE8nTgrR7OC2LD7X4W3J2tDmwjCXA6Yuz8eYqyTcUBWoOcEF?=
 =?us-ascii?Q?wEMKkfR0Vxs53LW8qJUSw8Zsh7regoWSaVzeMCj8hv7Vk1wusYD91gbOZK2S?=
 =?us-ascii?Q?58Fwb1ZXIC3f85tLGJ+35TNnrOQPS/zz1ytAnXX28e+F6f9MSuioef2Sdoex?=
 =?us-ascii?Q?wnvQqbgRIsslts5mVKcczHYFLVnXvOA7Q5awZedraoPsll6GpAS3o2Pd5fKt?=
 =?us-ascii?Q?NqRSyurTItH2M4uXJJkLTY61UqD4ZUvki8eO2tOIB5XXPQwVtLHKqyfRTviU?=
 =?us-ascii?Q?Ax28c4ZgREYvSDMhF8/r07FQZRD4Cd/UKCqHc3O0Fj/ReApnnVBBs94ErUGH?=
 =?us-ascii?Q?+yjcRqmQPyjwxWoOZWKYCs6Mo4bGaY49q9QumUDb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f998a2-8222-49e7-67a7-08dd604ff460
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 03:51:07.4636 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +PzNcV7t1FSXDwgCSjs+o4x95XX32FIgwnXMT7NBnFuxQ75LWrJlAImXtssY9zGq6/zgBiwJVhuFAwlFwZyMCTBoLu0kX410J7GdgQNOua4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6607
X-Mailman-Approved-At: Tue, 11 Mar 2025 14:13:18 +0100
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
> Sent: Tuesday, March 4, 2025 1:07 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Meng, Tingting <tingting.meng@altera.com>;
> Tom Rini <trini@konsulko.com>; Ng, Boon Khai <boon.khai.ng@altera.com>;
> Jit Loon Lim <jit.loon.lim@intel.com>; Alif Zakuan Yuslaimi
> <alif.zakuan.yuslaimi@intel.com>; Ravulapalli, Naresh Kumar
> <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH 1/2] arch: arm: dts: Enable kernel itb file generation fo=
r
> Agilex5 SoCFPGA
>=20
> Load and entry addresses are corrected for Agilex5 SoCFPGA board which
> would enable to generate the kernel itb file with the right addresses.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi
> b/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi
> index 15306db600..93a8e0697d 100644
> --- a/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi
> @@ -106,8 +106,13 @@
>  					arch =3D "arm64";
>  					os =3D "linux";
>  					compression =3D "none";
> +				#if
> IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +					load =3D <0x86000000>;
> +					entry =3D <0x86000000>;
> +				#else
>  					load =3D <0x6000000>;
>  					entry =3D <0x6000000>;
> +				#endif
>  					kernel_blob: blob-ext {
>  						filename =3D "Image";
>  					};
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
