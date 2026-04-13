Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF4AEBFD16
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 08:34:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5245E839D5;
	Mon, 13 Apr 2026 10:34:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="CDmBFQiI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A467839DF; Mon, 13 Apr 2026 10:34:00 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04B848352B
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 10:33:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwVYGH8jEszTkJ8x6ynBbXlOJyv+lF+fEdd6KYnP6EjEcPgClFw8qKwYw+mCh6wrPguW68X8F52j92L6kzTAZaJfBVjRTPKDWCMCk8YGh6+TEid9LBsXQCQyZnkynY1XiLeRqpYtk4xK/vihfL5BLkpz9If+q3a2SfL3pLIWGy+PbUi/Ear9IjWxHAs6MwLDZdXMjXctPY2CCPWo61s2nGOa/C2AwklAMRhyJuXY3VYNF21j+OX0xiKiO2ibKtULbJWLnWrPuNJK3qCuSt+3nA61oFrdKpmmlmMLNelvneamMPZBj3kV85qE7c9YHUmcLt0CX3mSvfVJ/8n30nS5rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dV/a5ocEKnTQJtwFhBKS0teJO5YUOOoIf8yZp3pUZHg=;
 b=icnQUnCtQpFoaQGpxySctirk46JRRy5j46ldCGcwmuOqMGbIa1CfzW1hPiQf/uyJaAT/l/s9yff7S7dDsOIHFjEfOZhRQoZwD/IHoYmWbk71R67q197mzE6WuLRNKYGoKsDcoUeTLVblbeBlQ76bO3FCNgarL6oagKCe1B7YenGOmbBC8/uG+yDxFVdmCgY6anBo9GzoqZLqeAFTargZzTALSOjObqBPKDgMuvjVPSXaQeZzGv0yXbnhHoixzABFfO4+AsuYF6HAgO/1rdS9wUVLF0hEZguGawVckYqsVWKue8lrHUGPiv4yQNztR5z9QxEZOmFmCVAlio/weKcP+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dV/a5ocEKnTQJtwFhBKS0teJO5YUOOoIf8yZp3pUZHg=;
 b=CDmBFQiI5MXj6TTOxdw5/mx4x4D3sGNFVjLEY3FQpJ2xVfGcoH/Sx/afEk2TqOL45bdXsPaas52GiZgntD7z3PMELDnq0B/0nmeu+N0vR0sw8/NRanpepU0EVmgP81OFZMfZsasPtGNq2nZdNhDJkS90rToF7n3cyCHSbrdkSSih83pBLLYR767NRvewYmldDpuFu9BshPE5SGQZavZ2DWaX22oOLIX/R7pDhYRJcQXmLRZkeJG93TOcp0F7inSIFG4BK6xmvJv4vHpm7uxSuEUMV4iwmUi2QLQFX/QGiH/2pqt0PXRGaDQv9uCk74pUtUSLMRTYNgkSbl06lLcNmA==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by DS2PR03MB8393.namprd03.prod.outlook.com (2603:10b6:8:333::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 08:33:54 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 08:33:54 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "LOK, CHEN HUEI" <chen.huei.lok@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>, "Rosdi,
 Danish Ahmad" <danish.ahmad.rosdi@altera.com>, "YUSLAIMI, ALIF ZAKUAN"
 <alif.zakuan.yuslaimi@altera.com>, "MANIYAM, DINESH"
 <dinesh.maniyam@altera.com>, "NG, BOON KHAI" <boon.khai.ng@altera.com>, "Hea, 
 Kok Kiang" <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v1] arm: socfpga: soc64: separate reset manager into
 common and platform-family parts
Thread-Topic: [PATCH v1] arm: socfpga: soc64: separate reset manager into
 common and platform-family parts
Thread-Index: AQHcmk2HRbd/hxlPkE6tJc5fAwf/OrXdAd6s
Date: Mon, 13 Apr 2026 08:33:53 +0000
Message-ID: <LV8PR03MB8137BA02FC8E03F7218A1C62A7242@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20260210052359.2644-1-chen.huei.lok@altera.com>
In-Reply-To: <20260210052359.2644-1-chen.huei.lok@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|DS2PR03MB8393:EE_
x-ms-office365-filtering-correlation-id: c71c4492-5d9b-4965-e475-08de99376590
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003|55112099003|38070700021;
x-microsoft-antispam-message-info: FQ9UfUvmUy0LLLRK0exWvH8in8ofkv/uzMEJ1wGI+DGVzeSY/0wI94/C65xuHcWtXZ8ModJ5pEMWFn8YJqjlTYLXl2W04mTZCNZ71LatiaJmRjhNrJCerfNSYffr4AAoYTtm8/q0786Lu9KYfllWykc/hp+xd5mTQURgWE1hc1MNdVASrcpeQf8pLYEEAit7PdrjQZpfdsMx0TBNxJf3OFXOCFHpNkpyKsCO8AufzQCpJUzQb5DWJhhycrsTVM+IrC37SzrE4OSwGwVzY/penxtQM15yNR2mRiQYmjlU041RZVIe/pDwLtnfk1Qd6H/Ve0l2cx6vOKnm0rCesVVld7J/wOOPKJ10aq+85QTc4lvdSqd1HbMdLLY/EdvkdnaNWKz1GkKiArvOjksInz1wAXW//4wV8z2gzMcNQNy5+QZ/60HSIUH7nL3y81RQnM6iWYF1obrAKVchrqBcukguX4W6v1AT8KLestxvkzL+giP3gyX4tVtWW/Yz1ui5fN258v+u3hGIxPBZR00JtXIjMBrFXTM+/s+mlpfqZIzPzEnc9OoH2aYwzBcwHv9x6ZUa0oUKc3YmTIU/LP6jtolFV7kpIuqIMvCcLmwP0AyQKZDfFwvNkOZrPaQVNE8ZW4KafMSWKdGeaRT/LpRq/DIIMMthMW/WAF8atXpTUUDLu5vYKD0e4dJB/D5Ow2+T2mYK3nj59JkQLqVNOXXLQUywebs7Sqdlk1Uk1+FE66HfFLb7zvaiSjFwwQpI5MotgsKJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003)(55112099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?u/LZ9mnwmsK3ma4vwRQiVGSi7OMsTg2vKyav4ztaD1+kO6aa3SCFzfft?=
 =?Windows-1252?Q?G74O+6YnGaZq8QGXlgS98aTlyxnBxwSAUmiODG7r5dxGKfZpLwJ/m9RA?=
 =?Windows-1252?Q?YMbsH0nHaykVEJpMrjsM7gMdBOPg+Pqs5jL35Al5yhN4Ns31GelGot/N?=
 =?Windows-1252?Q?v8WENDuCr4WmtGJlnuoAr2SSoQQsqYjFtOWogmt5txXGaDXoi1CvCGP1?=
 =?Windows-1252?Q?svPWMqYbY2ilkNtb4KegqS2/MhO0Lqoz/Y7OZy2CUdIKKT1tbXQbZPsn?=
 =?Windows-1252?Q?TrYSu6Kf3pKZYZH+nrf1m8/yccxuX+6eydrjFOoL8WoNRO5lOzPMf904?=
 =?Windows-1252?Q?oUYSkAdvHzVn4tBJKVBMvFS7JgpX36OYP+SPDQd2tsblyfQ9QYO094Av?=
 =?Windows-1252?Q?9pWrxYUFM48/OVdcZXndJeas0hDCs5n/yqVYWqfG1BRf1MAEJoRuy9j9?=
 =?Windows-1252?Q?lCj93+5IGTByggI++la9+VfDdwJrekn0pq9+YLGxKi+oznqQxJDf6OJ3?=
 =?Windows-1252?Q?TQWuEJuIeiW5r6iAMB9OUEDqQcDRNFR0OaIK6vO7bC0m2/s4Jy76lSHf?=
 =?Windows-1252?Q?L8u49TcGMLjEFuoWY1BNLL12LZ6uIa6HW2fKuVq49XHoOYZ7DPI/zS5E?=
 =?Windows-1252?Q?O7PRNvXG9EMLWQN/7uF6ZNuCNCgvOoqKfuNrdZ6rKoDzcN4J8DpNHCeN?=
 =?Windows-1252?Q?hZzjDN6it4+jUGvW+IicqH6GROzCD/aZUGCB+y5O0BLslGMl1NCGI0FU?=
 =?Windows-1252?Q?FOfU57uMSMXzD0FPuTTczDSgbnBR5KV1FVDJ7V7g6UTRWTGMWBNyLjYQ?=
 =?Windows-1252?Q?ZNOLLDrGtbvO3xqUBDVmIidcAd7DtHow0PTeYCanyYd6EPEgVLrIqmmL?=
 =?Windows-1252?Q?TuC/PZopmDmiseKmTgMw5cig/NitZTYce9auaJkq68iqVmgvnI/yzgyA?=
 =?Windows-1252?Q?yAqCu9Ra27QeW2dD3M2MR7qoif06w/mZoq4OZnbVxcLwDQ5Vx2oWV5/C?=
 =?Windows-1252?Q?ylLzYZzt0wDf3CZKffzBntDEgLrMEIYhejB/+Oq7Za8BtmoIhvmjQN/z?=
 =?Windows-1252?Q?LjgjJOy3j7FRx6UpQ9wWfTnd6AcvHmXCDcFh1nj8Cmw37jkbC6LMLuPz?=
 =?Windows-1252?Q?6qdDdnDVJK3ZjS5OHuIMOCp4eXnlfBKD3U1RJbWVs4u7u7uxoj9zz/KC?=
 =?Windows-1252?Q?zGhMQLJCNbUpvGP4aKpGllCGFvAHQbW+Lwk/g0FPWodTf9SnefAQt2lF?=
 =?Windows-1252?Q?btpvnyYyneo14kpbfHmDLKUm9OBaHw5AJuurCBlFkp3t03O3JyL3v+0R?=
 =?Windows-1252?Q?BvHrL+BMdpj+uAjtfhE6ZSyi2RQgohQ7Za1bqOqt/KgaxH+0jLvaVVQ3?=
 =?Windows-1252?Q?E+SPKcTkgBX204/YZMHaGvPzyTNUPR6HqXuMm9Qj+MqsQd52FHxCQC9h?=
 =?Windows-1252?Q?DxtsAI2uz43uufxB7vu4ufXP3hKX7KX3v9+MSH3v7DQmLFTr/KHjVssd?=
 =?Windows-1252?Q?KP6euxxd7Zst54Vmj4BtHpNV4GYDsuy19ez1clXgooSUcXPDiNBqbwFY?=
 =?Windows-1252?Q?eGP1q8RfN2OIPBbvZJbOZcLdDRsnsRd0oVZADQlsjiCA3durf5i4+kBo?=
 =?Windows-1252?Q?NME2bUOgfwzQyFJ1h9PAqPvSiVtUDZU0T9lHUj7pU95xlcDVkP0CGUTs?=
 =?Windows-1252?Q?qhNQ1rY4Jpn4NQhFZ66ypCKfDai4ZZWcAKMRobFE47xp9NRaf26CSIKZ?=
 =?Windows-1252?Q?FdlACyzvD6AmAq2VqE+OmFRJZmK5EjjyVP60aRmbCvHtXh0x7cD7zZHx?=
 =?Windows-1252?Q?hSyP5twaTpi2QNtw2UrCUGhkToRnYnOhjih2q6jdiBWlSvphJHweZQop?=
 =?Windows-1252?Q?Ib05Fju8e2mExw=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71c4492-5d9b-4965-e475-08de99376590
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 08:33:53.8980 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8CF+73QW0JVZSt28u+MY9++IYa9gdi3rfYaOBNpUSEDvjx538iFZmouUsHAgipfZkM2ydangPRv8QPvpFAGnPlxPOqZExqVIRZcgja2aoOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR03MB8393
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

Hi Chen Huei,=0A=
=0A=
> From:=A0Lok, Chen Huei <chen.huei.lok@altera.com>=0A=
> Sent:=A0Tuesday, February 10, 2026 1:23 PM=0A=
> To:=A0u-boot@lists.denx.de <u-boot@lists.denx.de>=0A=
> Cc:=A0Marek Vasut <marex@denx.de>; Simon Goldschmidt=0A=
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong=0A=
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Rosdi, Danish=
=0A=
> Ahmad <danish.ahmad.rosdi@altera.com>; Yuslaimi, Alif Zakuan=0A=
> <alif.zakuan.yuslaimi@altera.com>; Maniyam, Dinesh=0A=
> <dinesh.maniyam@altera.com>; Ng, Boon Khai <boon.khai.ng@altera.com>; Hea=
, Kok=0A=
> Kiang <kok.kiang.hea@altera.com>; Lok, Chen Huei <chen.huei.lok@altera.co=
m>=0A=
> Subject:=A0[PATCH v1] arm: socfpga: soc64: separate reset manager into co=
mmon=0A=
> and platform-family parts=0A=
> The SoCFPGA SoC64 reset manager code is currently built as=0A=
> reset_manager_s10.o even though it is shared across multiple SoC64=0A=
> families.=0A=
> Split the implementation into:=0A=
> - reset_manager_soc64.o for common SoC64 logic=0A=
> - reset_manager_soc64_platform_families.o for platform-family-specific=0A=
=0A=
Consider a shorter/more conventional name than reset_manager_soc64_platform=
_families.c=0A=
e.g. reset_manager_soc64_families.c=0A=
=0A=
> =A0 code=0A=
> This improves code organization and prepares the reset manager for=0A=
> additional SoC64 platform families. No functional change intended.=0A=
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>=0A=
> ---=0A=
> =A0arch/arm/mach-socfpga/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 | 15 ++-=0A=
> =A0arch/arm/mach-socfpga/reset_manager_soc64.c=A0=A0 | 94 +++++++++++++++=
++++=0A=
> =A0...> reset_manager_soc64_platform_families.c} | 75 +--------------=0A=
> =A03 files changed, 106 insertions(+), 78 deletions(-)=0A=
> =A0create mode 100644 arch/arm/mach-socfpga/reset_manager_soc64.c=0A=
> =A0rename arch/arm/mach-socfpga/{reset_manager_s10.c =3D>=0A=
> =A0reset_manager_soc64_platform_families.c} (78%)=0A=
> diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makef=
ile=0A=
> index 4e85bfb00d4..71587fd3caa 100644=0A=
> --- a/arch/arm/mach-socfpga/Makefile=0A=
> +++ b/arch/arm/mach-socfpga/Makefile=0A=
> @@ -34,7 +34,8 @@ obj-y +=3D lowlevel_init_soc64.o=0A=
> =A0obj-y=A0=A0 +=3D mailbox_s10.o=0A=
> =A0obj-y=A0=A0 +=3D misc_soc64.o=0A=
> =A0obj-y=A0=A0 +=3D mmu-arm64_s10.o=0A=
> -obj-y=A0 +=3D reset_manager_s10.o=0A=
> +obj-y=A0 +=3D reset_manager_soc64.o=0A=
> +obj-y=A0 +=3D reset_manager_soc64_platform_families.o=0A=
> =A0obj-y=A0=A0 +=3D system_manager_soc64.o=0A=
> =A0obj-y=A0=A0 +=3D timer_s10.o=0A=
> =A0obj-y=A0=A0 +=3D wrap_handoff_soc64.o=0A=
> @@ -47,7 +48,8 @@ obj-y +=3D lowlevel_init_soc64.o=0A=
> =A0obj-y=A0=A0 +=3D mailbox_s10.o=0A=
> =A0obj-y=A0=A0 +=3D misc_soc64.o=0A=
> =A0obj-y=A0=A0 +=3D mmu-arm64_s10.o=0A=
> -obj-y=A0 +=3D reset_manager_s10.o=0A=
> +obj-y=A0 +=3D reset_manager_soc64.o=0A=
> +obj-y=A0 +=3D reset_manager_soc64_platform_families.o=0A=
> =A0obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)=A0=A0 +=3D secure_vab.o=0A=
> =A0obj-y=A0=A0 +=3D system_manager_soc64.o=0A=
> =A0obj-y=A0=A0 +=3D timer_s10.o=0A=
> @@ -62,7 +64,8 @@ obj-y +=3D clock_manager_agilex5.o=0A=
> =A0obj-y=A0=A0 +=3D mailbox_s10.o=0A=
> =A0obj-y=A0=A0 +=3D misc_soc64.o=0A=
> =A0obj-y=A0=A0 +=3D mmu-arm64_s10.o=0A=
> -obj-y=A0 +=3D reset_manager_s10.o=0A=
> +obj-y=A0 +=3D reset_manager_soc64.o=0A=
> +obj-y=A0 +=3D reset_manager_soc64_platform_families.o=0A=
> =A0obj-y=A0=A0 +=3D wrap_handoff_soc64.o=0A=
> =A0obj-y=A0=A0 +=3D wrap_pll_config_soc64.o=0A=
> =A0obj-y=A0=A0 +=3D altera-sysmgr.o=0A=
> @@ -79,7 +82,8 @@ obj-y +=3D lowlevel_init_soc64.o=0A=
> =A0obj-y=A0=A0 +=3D mailbox_s10.o=0A=
> =A0obj-y=A0=A0 +=3D misc_soc64.o=0A=
> =A0obj-y=A0=A0 +=3D mmu-arm64_s10.o=0A=
> -obj-y=A0 +=3D reset_manager_s10.o=0A=
> +obj-y=A0 +=3D reset_manager_soc64.o=0A=
> +obj-y=A0 +=3D reset_manager_soc64_platform_families.o=0A=
> =A0obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)=A0=A0 +=3D secure_vab.o=0A=
> =A0obj-y=A0=A0 +=3D system_manager_soc64.o=0A=
> =A0obj-y=A0=A0 +=3D timer_s10.o=0A=
> @@ -95,7 +99,8 @@ obj-y +=3D lowlevel_init_soc64.o=0A=
> =A0obj-y=A0=A0 +=3D mailbox_s10.o=0A=
> =A0obj-y=A0=A0 +=3D misc_soc64.o=0A=
> =A0obj-y=A0=A0 +=3D mmu-arm64_s10.o=0A=
> -obj-y=A0 +=3D reset_manager_s10.o=0A=
> +obj-y=A0 +=3D reset_manager_soc64.o=0A=
> +obj-y=A0 +=3D reset_manager_soc64_platform_families.o=0A=
> =A0obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)=A0=A0 +=3D secure_vab.o=0A=
> =A0obj-y=A0=A0 +=3D system_manager_soc64.o=0A=
> =A0obj-y=A0=A0 +=3D timer_s10.o=0A=
> diff --git a/arch/arm/mach-socfpga/reset_manager_soc64.c=0A=
> b/arch/arm/mach-socfpga/reset_manager_soc64.c=0A=
> new file mode 100644=0A=
> index 00000000000..71e9512af49=0A=
> --- /dev/null=0A=
> +++ b/arch/arm/mach-socfpga/reset_manager_soc64.c=0A=
> @@ -0,0 +1,94 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +/*=0A=
> + * Copyright (C) 2016-2018 Intel Corporation <www.intel.com>=0A=
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>=0A=
> + *=0A=
> + */=0A=
> +=0A=
> +#include <errno.h>=0A=
> +#include <exports.h>=0A=
> +#include <hang.h>=0A=
> +#include <asm/global_data.h>=0A=
> +#include <asm/io.h>=0A=
> +#include <asm/secure.h>=0A=
> +#include <asm/arch/reset_manager.h>=0A=
> +#include <asm/arch/smc_api.h>=0A=
=0A=
Includes SMC + secure headers, but the functions shown don=92t use them.=0A=
Prefer minimal includes. This improves compile times and reduces coupling=
=0A=
=0A=
> +#include <asm/arch/system_manager.h>=0A=
> +#include <asm/arch/timer.h>=0A=
> +#include <dt-bindings/reset/altr,rst-mgr-s10.h>=0A=
> +#include <linux/iopoll.h>=0A=
> +#include <linux/intel-smc.h>=0A=
> +#include <wait_bit.h>=0A=
> +=0A=
> +DECLARE_GLOBAL_DATA_PTR;=0A=
> +=0A=
=0A=
[...]=0A=
=0A=
Best regards,=0A=
Tien Fong=
