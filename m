Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD97CA0EE6
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 03:22:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8F8381FEE;
	Thu, 21 Aug 2025 05:22:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="eOQM0RVV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F058282E34; Thu, 21 Aug 2025 05:22:18 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::622])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA6C081E13
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 05:22:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dkk2okyE6nO/qM/zyY+3AZyVxgUB43MX282r0p8gBknAFQiQQDKZfCk9hrSC4xuiCPE89npxU0uztTuGLIiV1EwHz5IY2KQdEpRsn9cUw9pPLFxPsN6qHhwqej+luVxG0N9oIiYfefFzXTOIblQcHW9mehbGehd4uhqoc1IPfiWjlKZInm/ht+xyzQnvsMyDxH9XaANgR63JbGd1jGtRitTqKjqUfZCrfPihNT4hZkJgkQSSmlpY9WqNS3G4TzBlqFlhXqph8QMbwgJR+EVNsYg5dQE6iiJzYH8TS1n4U8zDdHJZ2sVHdeGFx18M/Hgls97lPwsKwQgrA5fpMT0VEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oE36LhBhJkxmg9unFbz2lTEGeMfp2wiBvPyZgZPxc4Y=;
 b=FidKvUh4Md+5SjqkdgUiGhWkgR1NefPXqQkGk7SMgs5ficpEnGVNx+hXihXKlJokyhPCbCb87t+gHO713olQCCK93bmy3n6chcMZnA8LgZgBlsy6Mm/NWwJZVvyc5eij5wJaq+z0+08wnX+BdtZzFd5S21zPchMmtYMoPY5Vl7AYJcGB7V3CfxOYS65SXXnKKsdCFOxs12Eq1Gjqqidi4Ptbs4n6GxO9jLwMYwWlsWTT8Gbpcbh0ZoofCFj6hcDctaRSuppSHZtx+WmdCzQx3g8d/cTSvQz1zjMMIWIXXFOYCwfvfwO5CSNZbqpEtdDJiwwQ+laeug5kN095/TqRwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oE36LhBhJkxmg9unFbz2lTEGeMfp2wiBvPyZgZPxc4Y=;
 b=eOQM0RVVE7gg0SlCOGKdgle0MUb31X4UJ+A0F4dV0OvWSowilojNLuSNVbLaZfPue//aXUSS152I731qe3919EI9DRGCDkXYTbp5AQ9stoCzEeJ9waFiDxiU4KQgQ4CLDJJsCkHTHaxbotAGexivb/TkACUr/wvExmeLNHl/Gyi2IpKa/GElpPElZ4AWIBWCr53YyTlTo+FKAll3WW84ZBbQERB9E1+YDH/u+osCgIg7IZjhmucR1oUxGNNSQ3GE6RD8GzmMAdI3tcqNbBjm73NUu0Ugh7sarP7H+aehumnirb67F4JZRG+OsnQgsQecgFS8UrbjEfoDca30onI/qw==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SA0PR03MB5482.namprd03.prod.outlook.com (2603:10b6:806:b3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Thu, 21 Aug
 2025 03:22:13 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 03:22:13 +0000
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
Thread-Index: AQHcDMoMC7LUoiiAN0ClKX8ihT9a4LRse/EQ
Date: Thu, 21 Aug 2025 03:22:13 +0000
Message-ID: <LV8PR03MB8137D4F37297566E9CBA1847A732A@LV8PR03MB8137.namprd03.prod.outlook.com>
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
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|SA0PR03MB5482:EE_
x-ms-office365-filtering-correlation-id: b56da7be-9f7f-4446-778a-08dde061ec08
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?DFILQmXp8LmKlGFmS1Z0BDQvMyOKormNYNOw9Wvjz25t10t8m+1jkcJ9g/cf?=
 =?us-ascii?Q?db2zn2hHGpFUv3yGG5Sagjx6tm/QLf59010LvQZrsNWvhFu7pw/NV/iCagdn?=
 =?us-ascii?Q?tkKo2Pfekt/DMdglvgiSUH9AivUv7QliOTRaI8ZmArXvfoP2Y9AKVZVVT3Pc?=
 =?us-ascii?Q?nPuYOmjm9VCDBQmCEqO8qyjU/qhynXe3wQemNY2W2UhkVo2wIxq5TlVM0sIN?=
 =?us-ascii?Q?MOlHqelqcBd/L0MedSR/p4Sp/fpB3Fng9MnxP/wyS1pgMmNcwCXAjS/Jkyny?=
 =?us-ascii?Q?2zvgZDxxyo0KO21MEDhWiHHiHKy642NQ5zTn+QE7ErmM1rD0VdTAd50v/Zfy?=
 =?us-ascii?Q?KSN8sYAE0CRY/2DHVWJf1QJUeevIE8JBX5KO2VzJW9REWTxgWmUaj/f5pFu0?=
 =?us-ascii?Q?wFJBm5vqVHsFKqZU+M9k1PCHhFSHwYIxiityO9HLWgiQo1mV9WdgBD6YPBYf?=
 =?us-ascii?Q?8RVx4RzFPLUyEkx0xyUHrA47dzKM4jt/7vs+2WA1dOgLdVhJSPeaX+j6iI+w?=
 =?us-ascii?Q?8aPH6pNNhC/2DjyoDTGwS4BGq8Q4bAHb1bZEq/8qs1gvPMU3fN0grDA+fz0N?=
 =?us-ascii?Q?X1fh7nXuytiyVLpcfA3EJXR78sdMasR2V66vGXqi2az9F0Y5jV5G04zrS35X?=
 =?us-ascii?Q?G+CWdN0hjuSNVbEeJmch5W6Ntiis0JyQll7q+P62MOk9xHe89pgjpB9Wyc+/?=
 =?us-ascii?Q?4SIygmy3jphbusLL4JOfsKOYDVVS9SdLA2obKPT4vr5A9iTfC4alMxuamZ7k?=
 =?us-ascii?Q?1+6/6wmAd/wE1HwNLWuQxfoZRsFkFsdzq9Gqy0NdLisVd6qKvfdiCLbVBHhF?=
 =?us-ascii?Q?OCVIhs0GhpTY84/e737p6fSS6GfnyVOXQhN6+S2Dfd60j/nzgZkgj1qvZh0n?=
 =?us-ascii?Q?YWk78UbxdzcNDCFSDkfvyKWc6CmB2NZZ7LFUr0fgyIIhDHwXRjihO3ysZ5j0?=
 =?us-ascii?Q?Vn62rsfKZ6ArJKC9Biw9qKMVeQ5bwQitetXJkaOpo1+3tNEfx5QqGGFrrMw+?=
 =?us-ascii?Q?XbJ8p9+oT2ds/CtTjm8a6ks6OVXFju65bquL6lUQBIFKdLph4roxBLukLozT?=
 =?us-ascii?Q?wylyN1h8l5VTizwinLmbYUhQ4teZer7CXtYaQdTWhVqiapBxG+eUpU7lKYc9?=
 =?us-ascii?Q?lbOqUDCc+bKnxKqn2xjNaLBlXSN/QkTur88GSTrIBYmisWZeYSAjxlkvKoOP?=
 =?us-ascii?Q?Peq6IJhplmflm84h86pKDGSeqDaoodxsoDfuZ2EFz1Q/t2C6aWwFWVBeByi5?=
 =?us-ascii?Q?0F6OujrBoaAfkWMkYCnJZ2ugo40Qg92fT7G9zZlyRFQDrzcedBiuX96sceFq?=
 =?us-ascii?Q?BwAhGP/Su0Omt1eqjeteUI6gNRAOUFophPR52Hios8VsJy+ZZhlADMtuOFjO?=
 =?us-ascii?Q?ijzjrCxKGLPzQIerOQ8OuCb8E8YDGYeK3CPMrz8xioXXOnHMnv+wfPJKSVHU?=
 =?us-ascii?Q?YS+Gm00tFR3s5nIx2OyGqAOO1aVwM+Mn3EZbG64P/MyR30fWq8uNLA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K552Pn+RGArngqOb9EAAT5S2Ng3ckZBC5446Dto25LLjsJwI2s6dU9yth2uC?=
 =?us-ascii?Q?rc8efvN6DDmRrjFdcXu5IDioiPuwj1Tw1NTmYJ1LWQk/t71pRRmFFI+YwN3A?=
 =?us-ascii?Q?n6QZVjB1VlIeUu7BqQ69pGbcImzj8CzaZ/xaiJKtPjZft+D0Z0VoSOb6cN02?=
 =?us-ascii?Q?3yO6TMALAWYomZp7kODRd2t8UaAcYqfcub+15pBPsJR5u+Vvg26h0aNSE8o8?=
 =?us-ascii?Q?d8eHFbYsxbKeyOCyXgyLKN9nQuvof3RCUlYLFe9Q/Ni81VjXXmb22KQPOyAj?=
 =?us-ascii?Q?XRj+kytPS1ufqXxrfGq3Y/5A8r9Dp/lCc6XiDw1JyOo+oNFJ8iDseXOmwQRY?=
 =?us-ascii?Q?+HZB9NlsQy2IkhDfpUhNNZIAbk/tv5Fy1nsg5fMspFoA0+mFk/j4w5vxptz9?=
 =?us-ascii?Q?EwKNGMD1EYDZucVGmtPcxpyDWUKw4ZSwM0U8oALE/Vsn5RbslXHduDmj1SCo?=
 =?us-ascii?Q?wfTKWCV4aouI026xWYVLsDvOTErTj0yQd1viNtQ9ljXuXaD3/LTJzAYewBdb?=
 =?us-ascii?Q?9KbtlCnujt5CLkw6K+gOjgvyfOdzOTZzueI25VMblG0FRccHBr7+6r4DpnzK?=
 =?us-ascii?Q?TY2uMQ2LhTZHHExRhw9S+ZPZIu+yX31zzMWSfFnfMRmLu4YFPb49srQeReYE?=
 =?us-ascii?Q?BQo+lht2m7RHUacd3Wfaopc5QICShPWJjTWS8cVA3ekec6Y2hbmUIeSJENJV?=
 =?us-ascii?Q?eNMN7dzMNWaknOwMxYfexhBAsomICqhyml0AaSneTQZtjvqASeFv1buc7/98?=
 =?us-ascii?Q?T2ERmK8jwEtC+pg91b6F7w8572xNxzYk991FcrW4/8Na+x/Ri84f929y20gG?=
 =?us-ascii?Q?ijcoM1LX/1gVYumhQuuO0nIJLlcRqKCuuoXMqsykbBGzqqnIVCCS8zzdEEYH?=
 =?us-ascii?Q?sQitgRnk9Vq1WnVbfY62dSzmUtLys2a6Ub1dKPlEwKNoo0NQGV6YDq1FxQEc?=
 =?us-ascii?Q?o0QmC5fGqeCgxSsG2iQnKjNDTg06JEqZru+EUQ6WLbGIlPkIyqWMWVGkmehs?=
 =?us-ascii?Q?hUrxDA4FAFmFm34xaHNGSLphGNpgTsfAATFVxwQtHuDuA0a/N8xKp+Rc0DQM?=
 =?us-ascii?Q?JVO9wk1jM7kh6g64S4dnyvtU48fkdkB5LhhygHXa3jPF4CJv9WzcrRkqkYix?=
 =?us-ascii?Q?TuaLJhJqrfkS+iRH55E0oA0OD2SIOpQwCdSKtoPHe8a/b/A9oGjv7OjivjvO?=
 =?us-ascii?Q?xbVqIjJqkIN9Qr0u1K92p4/7bxLB/MYiyU5+JCWRNVaTkQC0pH7zZSnwRGDc?=
 =?us-ascii?Q?qSU1K6ssNxlHLXJxshcoFvWz2buZq791vdoID7OKua0bEvx9jGY2BIP7d5F+?=
 =?us-ascii?Q?KAxPoa3JOGyk7hpJWFbuj/8Tp5uhZH/cv12CIYi2VOxGFWvkWXD2plNWp8zX?=
 =?us-ascii?Q?XBrboi7JzGEOtFAAps5uZqymUwwWHr7sO0OTBldx47CmqKUcnJbQCxq1ITvV?=
 =?us-ascii?Q?hEATA7uRIDXi25w4QOhc9b++S/04+fV7WR7g6E/OOlA1FMy/W1Vqr4F0uxw5?=
 =?us-ascii?Q?v1XB07RBl57WIG8VAXTQSEgD4mEbEALLTpAhX9Zen/zl9mB4finRHNf3wvCy?=
 =?us-ascii?Q?40tgcyE9eoJp3kcCHCj+tMZ8BA60Bvq6EHI2k0wY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b56da7be-9f7f-4446-778a-08dde061ec08
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 03:22:13.2566 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fe+Pv2vE69QYwn7BIehgI7ubZkL+hGnPcd4qwJL4YN32xVE1AHc4DEXFjQfT005zq07aHPm+qjlBAaaO4xIvmD4du9bgtn5GcsI2JEH4mqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5482
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

