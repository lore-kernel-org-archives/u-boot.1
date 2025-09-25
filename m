Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70F5CAC5A5
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 03:05:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62EDC836A3;
	Thu, 25 Sep 2025 05:05:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="sF7yPbuP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BF61836A4; Thu, 25 Sep 2025 05:05:47 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C091383678
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 05:05:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXVrGZBX3hajiX20333BRSR58aDBS6Bdtd0DjbYh0DIK3A6QF+rbDyuEmGnTHRv6Rd3558N3wGMyEteaJe8fuqNHY3lt+j8ELaJcUDOGRG1XspnRLNQ7CQUSXvMpj9x4CLAwZ8DoCjB477d9PI9uzMeCqlKd/HCaEk0fO2oNw1h/UsfAGjuiBlb9zlMPeA1KtNtqU5jG9Ar5FAxZ+bfNeC3nJad4yCT0aCWRdzkLa3/R6aujsrN9k8Qil2FyPOZ1dSmikp4cPEXfaVYAT4gLy+Dmy2lu7PnSG5CufRuGpB/cacZSEiE4wc/Fdajz5WC7xzSOdJxk5Quy95vb0Z3ZVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCGAMdL+97ncznvc7UZN02WTyyypAWZx68DseaizMaY=;
 b=o6Yi1O6aqmIbdxIL0i+ejkavKjup/Wx77cbPxkCuUY+ZmlvamH480xMW4ojlljlPV+MwirdbGkmovJA/Ppy5UoRwz9vfxmtzzlv3z1cDBY+Pr5m0YspdpY6gxAYRY+Iy+h4Vr9nmt/iToUyXXMMKbImhrpno+GjoSeHeYaisl+EAE4zLGLfvvFkXPZIzMEya9vLOh7agW2OBnXg1cGV5Qg93esJ7scNFtL7H0M3ohR0HiEcT2CFdI652583+KpuJMLWrBUTTnYNH4/ixas8FW5SKkIk9xWJEwuHS05opHHggUU9VlP8ynQn5Ve4hw+QZiEJGgUA21MRb7OQUroseRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCGAMdL+97ncznvc7UZN02WTyyypAWZx68DseaizMaY=;
 b=sF7yPbuPJiP6p/x3dRUR5lYL61Qmw8uoRzWMaabw4jBGGOJLnFUDSIeV8Gnqw1fOtHuAStI25XTp4wK+bCrpbhQ9zrquMHgGqdKCzQEPWDA2/7QpbhN2/G3r+/4KW6r29S5rdQ03Jv4+8dKnE1Fh+8KmW+GaQSUJWJddvK5OxwumAeCwaAYcEtS7GrTNz273UNiAI3cRJfD6ddfQoccFuTn015rjXHXC1JrNKHlI2I3Oao14yAazN79tZEBviNW3EL38Tlx5FnbDYr0k8Pb3kRj5gYHWp2NF29SF17UOGlnXlTntOv/Vn0g4V2kNjSmU5vArDhynW9/eGb2ZNtKZ5w==
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by LV3PR03MB7657.namprd03.prod.outlook.com (2603:10b6:408:291::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 03:05:41 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::7b6d:7517:b2b0:bca0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::7b6d:7517:b2b0:bca0%7]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 03:05:39 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marek.vasut@mailbox.org>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH v4 4/4] arch: arm: socfpga: Configure USB3 System Manager
 registers
Thread-Topic: [PATCH v4 4/4] arch: arm: socfpga: Configure USB3 System Manager
 registers
Thread-Index: AQHcLSfaVXhF72tOJUKVfGYnrTr+OLSjOCpg
Date: Thu, 25 Sep 2025 03:05:39 +0000
Message-ID: <CY1PR03MB8121BC57BD5141FE1CBC4E1DA71FA@CY1PR03MB8121.namprd03.prod.outlook.com>
References: <20250924074911.15538-1-nareshkumar.ravulapalli@altera.com>
 <20250924074911.15538-5-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250924074911.15538-5-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY1PR03MB8121:EE_|LV3PR03MB7657:EE_
x-ms-office365-filtering-correlation-id: b18bc0e7-0183-46ae-0435-08ddfbe0683e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?NdYNerPLUBFNVgwimsFgHJy++QBITaoOd/NfSi44CNtXQKY8jPNTxvZnRlkE?=
 =?us-ascii?Q?cfpD/r16L8NPcZTfSc1metkyV7HXyA+EhcfSgQou9veJdEVEG9iHuyFPb8cO?=
 =?us-ascii?Q?ROSRCQX+WpEq5L8m7fwD8E9pYEenvwMJJCBIcIMJIt03J8LY+4Nz0ip6x5NH?=
 =?us-ascii?Q?KAL5oLWBdaFHTdHZpdSJqp2Csm4iqQwvXfQqqkD2zDB1FH7h7faEPP+5PX02?=
 =?us-ascii?Q?TZ6yuU2CuP/Bk12PsWrUoWCMv2B3koUCm+E4z9S3DWjPOIYSja9kEwyNl69x?=
 =?us-ascii?Q?o5P2XX+IdZ1U+3p6VStxEFWelwq1TOnqyo56gJIvZBThs0mk3vE16yk9fqo0?=
 =?us-ascii?Q?03BSi202f4cjTrAyj48cb/0kqSPTdVF9H1VQf/HBsTPbnq3udD/dcJQov6Hl?=
 =?us-ascii?Q?2BRDi10wUemIm/FDCYXMDu182xHw/lR5NbbXomEonYp5iUn8WRcLd5npDPY9?=
 =?us-ascii?Q?faP52j0ojJWo1MBd51ArnGqzFMMb8vlswLpxXM15aYJ5OXkwUSm6j92EsUGi?=
 =?us-ascii?Q?IRUtNLYpaLx7SMdKX1T3TWrI/K3xqZ/3Lmw3hwUoBJikUmK4CropqHdVc7wz?=
 =?us-ascii?Q?jNdkh6nBoIaahFh+U1jJOI318A344obSsbkV5F7DygGYtBAUJ0cZDhRjkc8P?=
 =?us-ascii?Q?m0Ih2BmQJ9bZNWyt+Qh/oX2uIVQrOX/KIpk5kSvdKb/5Z/+VgpDjYXa5+AzH?=
 =?us-ascii?Q?fkIyP+KOsAY/qgb7GxaPtGiU34GIu8b/4nQWDAiqY9DBAMmgHa/nUqE0qZSk?=
 =?us-ascii?Q?0VcaHAZfQdVrpfvNSc5IKk6w6A4QOXYGGtR6spvQZbNwAnY6MTWWTfMBAJxL?=
 =?us-ascii?Q?lX8DAomh4MN6vja0/w0pnysI2sZWTq7jLUpL+mlgAivZVrv/FGCylo2qkylc?=
 =?us-ascii?Q?F0KynQ9jBRoO9WXWRKS5b0rZzAerqRbSObKJK28ZGggKgeXL78jpk22HzE4F?=
 =?us-ascii?Q?AFHoBOW80VjUxhkFZyWEuVd/dHpUI8veFacBEzAUWtCTFMGtvJGHr1c3niGX?=
 =?us-ascii?Q?QFMwZR7MISsRTGmq+AkODcj8cK8n2t5IicMtZw7loMOBFwl7AvTlEamCtoRJ?=
 =?us-ascii?Q?yXFZz53PT7maAyrOBhYS/v1sT0JudOhcmXAWQ/nz97fylZsFXXVSRxbq53Qr?=
 =?us-ascii?Q?XXheFTiRtJCoxcxYou8JNjCgFz3DhdYE3nJgAPwmeYR9hm6d/yQpGqAvzNsw?=
 =?us-ascii?Q?sd6RgNpGJcn3A2qL21i4AzekFSksiyX5j5PjjOL6P+BPGmiZKGdmn3WI2bEE?=
 =?us-ascii?Q?yKLkCcRi8twGr0LwHWYAqa9pHDCdhwo/meT6ckQtj3Xm5V8loHeoTeexERLu?=
 =?us-ascii?Q?KIAsYs6rU8Y96+7s+d/e7htSBLmcmA/lSY1xS85+jZA1zjWJKDo8i/bDB9GC?=
 =?us-ascii?Q?9TnX00dk1o/82cQzsKMDK36iVMVIeM7eIQz2BQ6lQnAHu3kpf6t/ATWy9vwQ?=
 =?us-ascii?Q?66qfDemYL6k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?La2B1EIrsTRNesMsH3fZM5QvS7MHyn2wN8ufAwNBXIH0uS5Vux6iQEwLEpc7?=
 =?us-ascii?Q?sAwzGWhjn/VUX23DMpJINWOzHfB8USnMM4ubCPmn38e0Ipq2oRaarkFxpTGV?=
 =?us-ascii?Q?1KFuR06PDWMsmAkfzaMV1oUf0uh8AASEKvQoKSuce815SF7aP28GyB6k6I/s?=
 =?us-ascii?Q?HCTZeNcXHLurtK+uVXripZ2qn2rz70vA/HPteJvIvNbbUWgfE4l3SSsKnoHU?=
 =?us-ascii?Q?PGqEPQTSScz5LLkUJT6Stf8mBv0Dv5EDFkEdWraf+fE6SuaLZimOZ9awGJRm?=
 =?us-ascii?Q?7F9Q5Li22XApgRgGWrdLuZWEAZ5HPLlOj6Mz8bZQ+lUKtV8wUHSNntfNZP4f?=
 =?us-ascii?Q?lb/MVXMxPKMwT6NKPi/zQpVUXcoAXxipw7oA6VPUZQJMKGV4O9VIK/cTqf/p?=
 =?us-ascii?Q?QYdwiu86Bhq+GSagbgQ0t+LR4iKLBVC+1d+4sBRJHV1Nwfh21JjMEoToyRa2?=
 =?us-ascii?Q?m+C0nfopeIjchGKP8tfX9b1UKAoEVfg/Xc9TKFW4VK/U1kHlXlQf31NW8vHl?=
 =?us-ascii?Q?MJSNJNFqaJzg5cWHCB0fTCfT8zQmWoo21pZtnWa2kV+TM3C/cZhqnbs4KdVr?=
 =?us-ascii?Q?b1lDrvQz+3LXtlAiuOhbBR5Lo3JKaRBpXX2Z5HIu9S7IrL8H40jVpDBN4SW9?=
 =?us-ascii?Q?4UsVSSOjv1UdAJOccX6PlJNIbQK1A1+U3wzMWlhyJl7BL5YcfT808dy4lQES?=
 =?us-ascii?Q?x0J47eN0YAiWczP6w6hdvQbTHc8JsyiEokQuor8m+bplXhr+cj8F7Cf314Sc?=
 =?us-ascii?Q?U+62+I5EIHbAVQuUO3geH7yvPWjcffspjAO9stoEYihHA2Ho0T8diecSpSsF?=
 =?us-ascii?Q?hvHIRUF0MIOa6cUHtrq28znF3hRhVi0u8bC13L9h7P2sgkaDUEDqPR6oR9nr?=
 =?us-ascii?Q?PRRoCjYNRxG+/UoFbtGcbwseqx0fE2/1jXYfQHEdhIXgm75OzlXeG6xi47bF?=
 =?us-ascii?Q?ozbnJBK7DNkYCkhgqPb/BUWipTg32UIeLQWcnZkuZWnUlBDc/+yzLtlU6fPD?=
 =?us-ascii?Q?jaLvlsu3xqsLco/PQ1zdW85l3J2AyKuNFgXd7Oz9UeAVtRJP8sTI4Te6D4IT?=
 =?us-ascii?Q?fnjDo4swBgtJ6NO9ErOoV3zn2EK02jrIep5fduYt5akWGXZM2MyN25yTWSAr?=
 =?us-ascii?Q?+EKSYHVvYY+LFlqfWjnaSc80hZIO9NOOCD1bENVPjeB51BJJIxuXFSO/Tf5a?=
 =?us-ascii?Q?zz6U64+vqoPGVAovPt+XRCpaXe3bGpstsuD4r4IT5+L0Usq4CIiTDKWQMYlx?=
 =?us-ascii?Q?c3aZ6QLpHxhA1w6wl8/HdiQ+1/y0cyQW4bGcYCwYmcX8yTqQQOdC101HjuWM?=
 =?us-ascii?Q?4ocN1DB9ggSDaeV5EShUvDyPKiANCrhT4V1XDeuIlbb4B+SiCZ9Vod0Od+fT?=
 =?us-ascii?Q?2bVcmMiAkeKdVuvIitzTmUEc7EXs7ZtK8X4BJma6dpizaiS2Zz2k7REBztKB?=
 =?us-ascii?Q?2wEsOpvDzGyVdU00FtT0L+Gwc+fUIliZq7wEbYBYfm7Y/mXUMrMhQ0c3pmTM?=
 =?us-ascii?Q?C+bCAl9+aE5yONlU0jb6zATDqRbmcRDRmfFX5055pclo2gvwpbXZYus5D70z?=
 =?us-ascii?Q?L/Bn0vdHNijPG7uvgr2QI87Wx0ablGPjhQpSq+Rj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b18bc0e7-0183-46ae-0435-08ddfbe0683e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 03:05:39.6283 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cmgttMkg40G5mOhoEXOayBGshdW7AxzLu44u2zQyJOckZYHhBBmbb6oCyZrD6ZXEZsrvOVQaQdE1w5GaAafqfI1mDa2D+tr+e50ioNU9NUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7657
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
> Sent: Wednesday, 24 September, 2025 3:49 PM
> To: u-boot@lists.denx.de
> Cc: Chee, Tien Fong <tien.fong.chee@altera.com>; Marek Vasut
> <marek.vasut@mailbox.org>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Tom Rini <trini@konsulko.com>;
> Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH v4 4/4] arch: arm: socfpga: Configure USB3 System Manager
> registers
>=20
> For successful reset staggering pulse operation, reset pulse override bit=
 is set.
> Port overcurrent bit 1, which in reality reflects PIPE power present sign=
al is set
> to avoid giving false information of Vbus status to HPS controller.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.c=
om>
> ---
>  .../include/mach/system_manager_soc64.h       | 12 +++++++++
>  arch/arm/mach-socfpga/system_manager_soc64.c  | 26
> ++++++++++++++++++-
>  2 files changed, 37 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
> b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
> index 054a28d845d..f768a3a55cb 100644
> --- a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
> +++ b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
> @@ -33,6 +33,7 @@ void populate_sysmgr_pinmux(void);
>  #define SYSMGR_SOC64_ECC_INTMASK_CLR		0x98
>  #define SYSMGR_SOC64_ECC_INTMASK_SERR		0x9C
>  #define SYSMGR_SOC64_ECC_INTMASK_DERR		0xA0
> +#define SYSMGR_SOC64_USB3_MISC_CTRL_REG0	0x1F0
>  #define SYSMGR_SOC64_MPFE_CONFIG		0x228
>  #define SYSMGR_SOC64_BOOT_SCRATCH_POR0		0x258
>  #define SYSMGR_SOC64_BOOT_SCRATCH_POR1		0x25C
> @@ -47,6 +48,17 @@ void populate_sysmgr_pinmux(void);
>  #define ALT_SYSMGR_SCRATCH_REG_POR_0_DDR_PROGRESS_MASK	BIT(0)
>  #define
> ALT_SYSMGR_SCRATCH_REG_POR_1_REVA_WORKAROUND_USER_MODE_MAS
> K	BIT(0)
>  #define ALT_SYSMGR_SCRATCH_REG_POR_1_REVA_WORKAROUND_MASK
> 	BIT(1)
> +
> +/*
> + * Bits for SYSMGR_SOC64_USB3_MISC_CTRL_REG0
> + * Bits[14:13] Port Overcurrent
> + * Bit[12] Reset Pulse Override
> + */
> +#define SYSMGR_SOC64_USB3_MISC_CTRL_REG0_PORT_OVR_CURR
> 	GENMASK(14, 13)
> +#define SYSMGR_SOC64_USB3_MISC_CTRL_REG0_RESET_PUL_OVR
> 	BIT(12)
> +#define SET_USB3_MISC_CTRL_REG0_PORT_RESET_PUL_OVR	1
> +/* BIT 1 actually reflects PIPE power present signal */
> +#define SET_USB3_MISC_CTRL_REG0_PORT_OVR_CURR_BIT_1	2
>  #else
>  #define SYSMGR_SOC64_NAND_AXUSER		0x5c
>  #define SYSMGR_SOC64_DMA_L3MASTER		0x74
> diff --git a/arch/arm/mach-socfpga/system_manager_soc64.c
> b/arch/arm/mach-socfpga/system_manager_soc64.c
> index 4b42158be9d..88d538cdcda 100644
> --- a/arch/arm/mach-socfpga/system_manager_soc64.c
> +++ b/arch/arm/mach-socfpga/system_manager_soc64.c
> @@ -1,16 +1,36 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (C) 2016-2021 Intel Corporation <www.intel.com>
> - *
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
>   */
>=20
>  #include <asm/arch/handoff_soc64.h>
>  #include <asm/arch/system_manager.h>
>  #include <asm/global_data.h>
>  #include <asm/io.h>
> +#include <linux/bitfield.h>
>=20
>  DECLARE_GLOBAL_DATA_PTR;
>=20
> +#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +/*
> + * Setting RESET_PULSE_OVERRIDE bit for successful reset staggering
> +pulse
> + * generation and setting PORT_OVERCURRENT bit so that until we turn on
> +the
> + * Vbus, it doesn't give false information about Vbus to the HPS control=
ler.
> + */
> +static void sysmgr_config_usb3(void)
> +{
> +	u32 reg_val =3D 0;
> +
> +	reg_val =3D readl(socfpga_get_sysmgr_addr() +
> SYSMGR_SOC64_USB3_MISC_CTRL_REG0);
> +	reg_val |=3D
> FIELD_PREP(SYSMGR_SOC64_USB3_MISC_CTRL_REG0_RESET_PUL_OVR,
> +
> 	SET_USB3_MISC_CTRL_REG0_PORT_RESET_PUL_OVR);
> +	reg_val |=3D
> FIELD_PREP(SYSMGR_SOC64_USB3_MISC_CTRL_REG0_PORT_OVR_CURR,
> +
> 	SET_USB3_MISC_CTRL_REG0_PORT_OVR_CURR_BIT_1);
> +	writel(reg_val, socfpga_get_sysmgr_addr() +
> +SYSMGR_SOC64_USB3_MISC_CTRL_REG0);
> +}
> +#endif
> +
>  /*
>   * Configure all the pin muxes
>   */
> @@ -18,6 +38,10 @@ void sysmgr_pinmux_init(void)  {
>  	populate_sysmgr_pinmux();
>  	populate_sysmgr_fpgaintf_module();
> +
> +#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +	sysmgr_config_usb3();
> +#endif
>  }
>=20
>  /*
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

