Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4266CC8303F
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 04:56:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C10783443;
	Fri, 29 Aug 2025 06:56:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="EPtm8jyL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90F09834E5; Fri, 29 Aug 2025 06:56:23 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47A5D8341A
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 06:56:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8H0oWIaY167x1exfcexOdYCqVzFf0l6ZmxK3c2ItZIpisFJ4Cw/R4ZDKc8RfO9YLUJPJ6J9CUJSN4HHEyS4X+4yhuiaweD8eoNTcfihzcFPb95RXLVD7QxwEqEeulLXTnWvOUf70oFgBeN1znuv7z7WhfLy/8pYmULpwtUB+TL+38tdz+E6WNCzKW5gG2OjDHH5+dAysxKurKc+wT0/icbC4XA2ZgqxcvBtaYnvgK56eJVJ55AQBlH6/HM2een4FKiRgmBvEhrTCA0riu0uIDMPPmwr+zbFpcq608d5bBCRnHVCBs7Xwxy4p5GCGI3+sql834XPIJQFy4T1AREhrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxCdwHUfGszFfEu9O3sN65dcMtF7lEfVGoWZsp9ApAA=;
 b=Mpcth+CM9JHrp720VPzJzBgsLY1WNftEYtdXBIgmu5PUpJKGvybhTf7gnmZFy1qvA0B1LAcC5PWKOK5PIc9LRPzMuaMj/gOOGNjUgjzUATg3pt5EeQuuWexphTKyooABthQ//TIG5npg6p3z49ZeS4HG6DIXlUi+2nVoPljeFr+v/pql6yUqQpGLV3jZguvNk90pxPeCU/TBOdPlvE9SxeIplxgTBhEbVrlxSQI3ERfhf9VQZBztR/cbYKxSTNgV/yCSCMRKQn3CkCcYjB4s1UX+wSBhtstljQoOB602lmthfnALTE3ybUFTZgZSfKYpnBGoK2oUC/8U/TLi58xHHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxCdwHUfGszFfEu9O3sN65dcMtF7lEfVGoWZsp9ApAA=;
 b=EPtm8jyLRkyqoJRkZSQNonGxEyz2OfO2roAwDGKrryV0e+N800+mfhEWvWnKrS+aPT3uqAEpgDzKkoelppsG+W8juOpBjdFFIzvfzRt9tW//HzaEIwT9vIeN//JO/4EBdUJ0Se1eSHUC7BZrU5O6/H462oGM8Ur36xm/xV5HWCPqeSbNNZn5YMH+o1mLECHyJHIFjE/T9VL18thssQm7PRaWtnxHCycj809Kr3mybE27qFk39A9CkwXzv3vJZN4FNZ7vnmmXzIzIPMpGycEvfVSqkJr13HFMgJAKiOHJdDGv/c1KhY2qh7r52/MhBFHA2DiW6hNVar4+fwIJ3vr9GA==
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by DM4PR03MB6126.namprd03.prod.outlook.com (2603:10b6:5:395::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 29 Aug
 2025 04:56:13 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::7b6d:7517:b2b0:bca0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::7b6d:7517:b2b0:bca0%7]) with mapi id 15.20.9094.006; Fri, 29 Aug 2025
 04:56:13 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marek.vasut@mailbox.org>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH v2 4/4] arch: arm: socfpga: Configure USB3 System Manager
 registers
Thread-Topic: [PATCH v2 4/4] arch: arm: socfpga: Configure USB3 System Manager
 registers
Thread-Index: AQHcF+RpzA1AEUFTR0K37t29VnYUsrR5Efkw
Date: Fri, 29 Aug 2025 04:56:13 +0000
Message-ID: <CY1PR03MB81219D8B30F67DA4CB4D115EA73AA@CY1PR03MB8121.namprd03.prod.outlook.com>
References: <20250828062418.17945-1-nareshkumar.ravulapalli@altera.com>
 <20250828062418.17945-5-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250828062418.17945-5-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY1PR03MB8121:EE_|DM4PR03MB6126:EE_
x-ms-office365-filtering-correlation-id: 25fe51a4-4a8f-4479-897f-08dde6b86128
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?WUvrPtDCPQGyfacBw3a4UPZ0KWxTq54XkLjgauu8935DIay8xq6COmmrrX2/?=
 =?us-ascii?Q?U7FkRcCvvtOBg4Ls7iag5+GxZQOM0Y1Too3D5u6KDdGkLEM9Yi/CqO0gEpqw?=
 =?us-ascii?Q?FRSCql0Dz+eUcBzCF7Q8Xf74uDK4cH9+NITgEbMw9XzvMvR/bK3VSL140xcT?=
 =?us-ascii?Q?lv6jbc+jZisleo9Lk0dGWI3XE2buNRsg4IIDqxSJFkzAmyWf/EAgaXQzBSbj?=
 =?us-ascii?Q?EWCj4SYKfMqvFXBIK+n6WqiR6raoaklLTnjxcahHStlsPBEmZUFgfLURfSQg?=
 =?us-ascii?Q?LDeJe9DJOdAPz2mSrX6KdETSjjCdAV9ziHNQR59rZeIuA1gnA0jHngdFQk/N?=
 =?us-ascii?Q?BAEVDnoO3w0Pe0j8LhUrs9we6Qp1vRUZNLq3LM8PFfVagBIwLDWsZX9nApki?=
 =?us-ascii?Q?Fpa/naHpDdi7z3jCkIdJa+JVMZ1PQm11vJMScNB6TEIlPP78Shga1WjuzefP?=
 =?us-ascii?Q?EwSF1mqgB12QA5g8A6GsAPRm3Na/G4TVUKIq7ir3cVzsajC7jxWMisghFTTJ?=
 =?us-ascii?Q?jT7fttLY0HAd3RaWDUGH4RgY4tPT8k71w+YTxzcp55i21ZRkYyTPnzqJ3cpq?=
 =?us-ascii?Q?BAkxQBDk8aS1UX0DxtuBqYmJP+Ga1I4rNePHIp+Ww1gIjJI9WDHNrBBVTZgl?=
 =?us-ascii?Q?C0/+AgBZDZLOBwr/n9JVsiR4AyP6IweAnaCIrqCVSLFcFy5n+I9z9r88zn8X?=
 =?us-ascii?Q?h4IASOME4QjTC5auV3Vew4CD+EwVGzMjHliKYMH2sWjTw3yaMptVUWNtqlB+?=
 =?us-ascii?Q?PJkc8TdUMwBskqFQwH2TS1sd5+PXDNeQW8nx1VKNak3Ec8jRkX6eH4gk6WLB?=
 =?us-ascii?Q?vEeVbZFmA6JwXMQ+LYQ0ZuBTIYXDr1gqhhYB3m+C+yz6Lq2Eq+PaOkM9reOz?=
 =?us-ascii?Q?XBEOWZHpz6UIWg+S0YTAJw3Arv3rnwT/5IBXdfe5cgsUNVo0nYL6vSjEDJJj?=
 =?us-ascii?Q?GKNBgonap6/KIHJzz5peMA+xoGM5JnKwU7cnUUCP80eFcHjblj535P2r7mhi?=
 =?us-ascii?Q?pIol4a9ryZ2SC/bsgYNkOZDVhxqOr5D6tb/diasoioiDUBGPPmUTAx+eqYth?=
 =?us-ascii?Q?0yzuI07gJ+CeMJTPH1J3DueyWIGuwaRUqmWlzzDeq1Z3zx1n/gsyy+HL7Y15?=
 =?us-ascii?Q?I/+NgqVpmAZ9J62jVAs1k/vcU/NuKhCalyvaIbVS0hlZWHR/Kjp0x+h2AdZF?=
 =?us-ascii?Q?QFzg2MbO+3SDax/x2Q4aLmdAFWqp3gw+T7aGarHfGYgt7E9509WRLJzCh5Ho?=
 =?us-ascii?Q?MHVlYher3Y3kuODK544BvcEECjZfB0voHzaBFUfBxUPtFpfzQCZd6X0C6gId?=
 =?us-ascii?Q?HD2XR++j3SrLF+kUkAZFfTqWZkzz45xsytsstYLBdQZWtU/lpjMJPIJmq+N9?=
 =?us-ascii?Q?VZQUcirWcIO4hMNvQL+2QpF1+LZfK2judtoV90qAxxjfX8qx/jG5vsTGMYr/?=
 =?us-ascii?Q?nKPWHmdC+i0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VatvePEbGcrvs7UXHOWqTA9x6ws2UjuLv6nsv6zSwGYAEZnzLFfgTas9gLka?=
 =?us-ascii?Q?+vkiK9kyMsey+XexZxUJ8UsPsxoUUfC4XxM7K/RVzdWfly5anf+42FTFj8gw?=
 =?us-ascii?Q?QrHtK3x6HKDZ7wYVm3XtwRMs0r9TEiJp0xQDmGGY8FBiO9MeP4V0GjhULBTa?=
 =?us-ascii?Q?aZpKP8LhUSP9LS7lpkv8aU7Qr2uMNAkvd1ULENegmHRZ3H61AAQ2lwf7uoiN?=
 =?us-ascii?Q?Bov42Ktp0q+1MFkazxjKtfvuprkJnIs+PbKNY6bnmbgYt9Bf4u5QlZTztnTC?=
 =?us-ascii?Q?5Yc7EBeWcYt268yVoSilzPwvh33I6qbSbfHim2PN+vrbttFvmcZcDEOu3cIA?=
 =?us-ascii?Q?ODrL/x5Gwt5XQ1KUR2PafDx7dduaP8sBG2ayq4nnu9IZ4o+b65d4fM21qW6V?=
 =?us-ascii?Q?Nl5jmAXhhm9X+Jp0gd1uLNhVXnYZVufaVm7nH5SJS3TRJEEA8YPpd90udq6d?=
 =?us-ascii?Q?gDl7CPTKJcB14DEB7a1k3geZ4uHrIHvJE5bz1wmRTPQ7Y5/beZgHVAlH6dKO?=
 =?us-ascii?Q?2PwxOdTMOPSinIhui83f+04FkBzJgFfqW+YYXL0pumx0cnS8zmxLPOqTfe5J?=
 =?us-ascii?Q?pXd6D0cJEJUuzU4ziCRJu8ZaGnLCdVD5nS0FNlGtWOUj4POmkcLsygWT/kjJ?=
 =?us-ascii?Q?VA+zvvnMkMh8s9FBA1lHci3tQ9K3vsn8Kf91cldJsRHJyeR7LWH8AXh2EkQY?=
 =?us-ascii?Q?knVhxxOdeEnMzK7pdX4n9xZIbeWL67rmFwLvwS2iEXG9Y435XRbd7sqrTX91?=
 =?us-ascii?Q?uorK3hlPmr3iGR+C3HahhdJ3uJtKbsR3GKzTNW3TgZ3rwvrJNrI2l5Mm1cLa?=
 =?us-ascii?Q?OLIF/K1HM2SQA83biZE4Sqgb1dnojYHm4YxsQDIg6sa7afrLrgUrcs9CfBxc?=
 =?us-ascii?Q?2zKBYWRWrLh/59ux7T468zIDIulGUKMjWCJ0XTzf9qVEROt0hAK7dCN1vEfD?=
 =?us-ascii?Q?dXLNvjZzVG9ldRcwtEoghdSckkCYLgl5KQm+ejlSQfNMmaAS+51J3lstn7XU?=
 =?us-ascii?Q?zbqzxo9E0opmkvlfguNcIiJO+fmJ7Q3aWtrjfws0SyqjcZF0rNb34Do5XqBY?=
 =?us-ascii?Q?14Uu1CxlMR0Tnnd+NjRL4nyd30s+qiofX2zTJQ8EIF5DH1k+2xzFgzIvOI/J?=
 =?us-ascii?Q?za4iRod9AWw2PwQHArzZw978Os5lgMopMgC2IfLZ4A1dg5GuvHS15s69vBEM?=
 =?us-ascii?Q?2imRK/jmdY+uuh5YVzWLsYPT+fxxmHX2wmyscPvRpR0R0QHHjJdWwicT8d5a?=
 =?us-ascii?Q?wp9N4crHiOER+BYrGMh16gQdvYtlC6kAxwJTXeBmlc8aFqJRXLw6w+aW68Na?=
 =?us-ascii?Q?W6fHa8WsFevs6Of5r3d4BCBEP1CFjxScv7LPaPgwE+9e+GiMbpN6ehzsRhtY?=
 =?us-ascii?Q?jvQ4we0PDNyOXu5F7CkoxUhUyW+Fb6S6h1SblwoEPPq24R0O+O/jIH4Rr5rE?=
 =?us-ascii?Q?npGIBfcwpU3pjxkhaV1LHumeWEF0+waovx1T39vIue057UiPPxXx0x14eObS?=
 =?us-ascii?Q?q5oiCssH8ZHQO67Zh/QAgJCz84AYninTvYZHSASim5FXPSBCO8l9a+KSJS6J?=
 =?us-ascii?Q?MFj5zOjNbtrY/IHqOBhgy8gu/S9pNTsfAc7ny1+N?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fe51a4-4a8f-4479-897f-08dde6b86128
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 04:56:13.4258 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T35XPxUOpy5Y5EDDocxhfKYBrsT1qbZVMgz8MzZpOwYcB3i83plTkuw+q1nHOvORYAVt3LnRM3/DY6hVHml0pxiu8+XnTuww8MVOibnimtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6126
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
> Sent: Thursday, August 28, 2025 2:24 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marek.vasut@mailbox.org>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Ravulapalli,
> Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH v2 4/4] arch: arm: socfpga: Configure USB3 System Manager
> registers
>=20
> For successful reset staggering pulse operation, reset pulse override bit=
 is set.
> Port overcurrent bit 1, which in reality reflects PIPE power present sign=
al is
> set to avoid giving false information of Vbus status to HPS controller.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  .../include/mach/system_manager_soc64.h       | 12 +++++++++
>  arch/arm/mach-socfpga/system_manager_soc64.c  | 26
> ++++++++++++++++++-
>  2 files changed, 37 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
> b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
> index c2ca0a50e35..c0392d99863 100644
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
>  #define ALT_SYSMGR_SCRATCH_REG_POR_0_DDR_PROGRESS_MASK
> 	BIT(0)
>  #define
> ALT_SYSMGR_SCRATCH_REG_POR_1_REVA_WORKAROUND_USER_MODE_
> MASK	BIT(0)
>  #define
> ALT_SYSMGR_SCRATCH_REG_POR_1_REVA_WORKAROUND_MASK	BIT(1)
> +
> +/*
> + * Bits for SYSMGR_SOC64_USB3_MISC_CTRL_REG0
> + * Bits[14:13] Port Overcurrent
> + * Bit[12] Reset Pulse Override
> + */
> +#define SYSMGR_SOC64_USB3_MISC_CTRL_REG0_PORT_OVR_CURR
> 	GENMASK(14, 13)
> +#define SYSMGR_SOC64_USB3_MISC_CTRL_REG0_RESET_PUL_OVR	BIT(12)
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

Best regards,
Tien Fong

