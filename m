Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C96C3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 07:01:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59B96831FE;
	Tue,  8 Apr 2025 09:01:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="PbBLaF8F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 487818312E; Tue,  8 Apr 2025 09:01:55 +0200 (CEST)
Received: from SJ2PR03CU002.outbound.protection.outlook.com
 (mail-westusazlp170130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9BE1831FE
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 09:01:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFCWATje+igMARP71ZyhWGn5B+ebfp++0BgaVhNlKyubiV2cxFkCufen77nuSOZG8zNfgXKUjTOPy5Xw3qCJGzFXOOxu60EOfcIQufy9p0O81yG1HJfS8ZtWWHTr2SEyuexk4XLZIT5w+ralxrYVIGH23QOSP+KwrzU2MS2lW9/URCC4nUaNXr+W3SBgsH875pQ2YZG5i+D+AgCG97kbi5iOj5CsHo5LFmyU9Che3bL7tRQKPLr9mEPrxDgM+FrdYZ1rbeo1DXJhro+uJnNQWRT+5mrmQugXTAktksXmdtgJheFrC9+xMCy99ee3D1rLAQ29M8t1i2u5F9x+ZE9bjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElqBV1UW+Dll+4E7wXOGO1cx0L8ogMDCMWqq2QaFH+s=;
 b=qEdb+I+7e5Em2vWu467mu8oZ0KgkUgrBw3u/VeZtLOqrhY85pq64JAzq6QK4Tg5pSIMYz3PeE8NfeTHlK4WOfKxMG3vZK8YoNBNLni2lhvHsZe2DI94Ni8U//Fh6iq4eqIroo4gC6fzt9//8Dlgfon0XK8K6JhmSBKYeDr2Q6JYt7bjklza7KugoyQlHYQsu+5uwLPdKXuX7yWJhbvYEHoEWMabNRAR5+t1djjfeUYiQnuL0qDA9K1vc5GJbT9brU+666N8UIumvTBmC6wJmVsVneDJOwCWLutqcryExDKicB8ZYT0lGf+6V5RR/6fc47f6RuUyMyR8POp2zOYmm9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElqBV1UW+Dll+4E7wXOGO1cx0L8ogMDCMWqq2QaFH+s=;
 b=PbBLaF8F98J9Brn3HvOtDHSwkrfSJx++WT8JnwLJWNV/+ek/6P9sk6eX2VHz4lV2FB7NMa5zstv3dWqRyyv+huHw499ibfcooPpvViDnoX6bTpM92KOT0e/4qx6rJ/tKe08/S5w3IXYJ3JhoXDwdmEfcNJhDwWpb6fN3VBxMqfr8+ox4X5yxf3mk/TRFpcHyY14SuqoaMpUX8tLfZ2Ig6QVrMxsBwdL2KKHSS+on+bjPZTeW4fLhIkXIwoErTCMuuiGVYeb414ZR6F2nhOQbp/pQNiAUdN3e8b3rY+/x258cfpq/nruHPnM7njchJ23coGUJTFs/d2sSdUnW7agFxA==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by CH2PR03MB5205.namprd03.prod.outlook.com (2603:10b6:610:9b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 07:01:49 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%5]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 07:01:48 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>, "Maniyam, Dinesh"
 <dinesh.maniyam@altera.com>
Subject: RE: [PATCH v1 1/2] arm: socfpga: soc64: Update reset manager
 registers for F2S bridge
Thread-Topic: [PATCH v1 1/2] arm: socfpga: soc64: Update reset manager
 registers for F2S bridge
Thread-Index: AQHbpQZIvw4Fi03nuEWQq5z6jMfTurOZXhlw
Date: Tue, 8 Apr 2025 07:01:48 +0000
Message-ID: <LV8PR03MB8137805719BCE6C3A513B7D0A7B52@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250404020703.4261-1-alif.zakuan.yuslaimi@altera.com>
 <20250404020703.4261-2-alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <20250404020703.4261-2-alif.zakuan.yuslaimi@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|CH2PR03MB5205:EE_
x-ms-office365-filtering-correlation-id: 5ca22b84-af51-4bf9-11ac-08dd766b3b79
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?JxfKc74WTkt021tmFMFuVK9zYrU0zAa7L4G6QugDQf8vRx0VU1OTlB051Eoe?=
 =?us-ascii?Q?tc2tTRZ1qgX5PdF0LVa4Kisw74CIFfpXP3YBOPFps9M+9CvqsZdtizn3OYz9?=
 =?us-ascii?Q?6BE+Op+bkSK1thOwL+kchbXwmj/djgr0Gu5xhIO93yv/BEgY+KmgMamAoydg?=
 =?us-ascii?Q?yF+2CNuiiIk/vmttuELY5Gc0EI/2NouPGRUfomeFIR6kfgBcVBcPYRNLD/Xi?=
 =?us-ascii?Q?O3EOIOPxu3o1PuG93DpAUOtDGJoQlRdg8oXdUyBER6xnKth33xIhpibrnXPs?=
 =?us-ascii?Q?VtDADr9DmgvGv+iBIIMHaDGaVwCvjtzKMNlYK9rGqGIwTfXzWrOnOrNc3A+w?=
 =?us-ascii?Q?oiSTLklBxkEs8WZ/nTyV2UnQEkBzSurQ0QiWM3ijLBRb25v+/58W9uH1UlIp?=
 =?us-ascii?Q?JIH33VoVW0A0qpaLM05M0w6XbGKScaGvGPFG1nWDCqy7dxFn7bctzxJxQJAf?=
 =?us-ascii?Q?WHdvYtUCP8/MRkNtyjAJLfHpDwEjmey0fI+FJLetmYzw1HQRv8/O0ML85MnM?=
 =?us-ascii?Q?hR0idtSZp/lBWpebMctS2bdt/+Vr0hrMMzjxmd6D+q4fRMFTiYXRIp4pLhXq?=
 =?us-ascii?Q?ozlseJ0OXLAaaonHbPjabydkTBc/xbtn4h6zVwY1w4ymXRmXjtY6DNYXHoey?=
 =?us-ascii?Q?O/e50X9riq+3N+Y2Ke9fNPl3cE0rZk0wJuPtXyGWfzrY+kQ1woZXQr4XMvnW?=
 =?us-ascii?Q?6zkVf8OPhCnz06qPNnMnZ4RyPiUAU0P9smySfIFFwa2+JGzHLEM6nMmBaOsL?=
 =?us-ascii?Q?KPFRoQZGA4riXKiycNBtcterlxuuhCI6mlas2YX48hyhUXPnNiNjfFYDfFL2?=
 =?us-ascii?Q?T+Ly2QY77/WQY8w/la0khJFyqkt5/TZlQgWZsyl0nPm5jm+1XLaIKHEx3/6C?=
 =?us-ascii?Q?fjwzaq5xe0oeuXyqBtjxmWkNwbT16eyC5zcZJVYYAwWfXq6vADxxM4nfyH/L?=
 =?us-ascii?Q?vhbxXh6ZOy/T64uflhCRzuRiF/y/10enBx/M2TFySuaKCBY9MSBUkLoPO0bA?=
 =?us-ascii?Q?ujdFO9bszYvMFEtcntTrtWXzw7eVuND2ZXAfd1IwBOpmj4rYiyB/CGLZwKkT?=
 =?us-ascii?Q?eCY51KuxTSYw8mpqW7STW2PqpQytGZ06fObm26ap2VDwmnbtZlRUhc4FfM4J?=
 =?us-ascii?Q?9wKMrNtooR5P2B/Pjc4FJLrE3fDrdtgMd5yInOYX8C+dAIbExOZ4pl1o9LtP?=
 =?us-ascii?Q?2OokFThbF171NC9XbcNIisW2ySN2lEamQNyyDfd/9B+N/+LOtp09oJQGGHf4?=
 =?us-ascii?Q?6R1sRFSVrGTvFkEdYN5lf6z6/+l75igi25JCdGIcmWFk8VOSSOr/OHqElQcW?=
 =?us-ascii?Q?7dsEmkGDnJdsr7hUeMO0LrasAkwdXEJgCAErcN0iLOJeRxhBgSABHMaTRvmW?=
 =?us-ascii?Q?X6n8403GdZDC4vzM9UCzzmXwl4m/UfIam2WCM0d1bv6xGOClyBD8apqM70I1?=
 =?us-ascii?Q?5Uz7wQH/GYw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F73rXiPO55v8n2Gs0gV4nfAxg7GdQrrSwmyeM/0e/wdvuUDgGM01gJh9qmvn?=
 =?us-ascii?Q?Ace+2nH8kkenoQY/sfuTFX67K4v+c4CRyMRmMrMLSovrUsW5GmQPndNQUqWt?=
 =?us-ascii?Q?X73O5jL7kPmkwSbx+FUnp+5ZwuYOPN4KuIEde8yF7PwqpM+ppnGf5JYrCSDN?=
 =?us-ascii?Q?j7GEIt9+7nz+dl/Orqbnf5F0PsZ5HEegN2utATFFOMIogIwEC48TZEZYeD4R?=
 =?us-ascii?Q?FEtiHBRGBFi5zBFpDFaFKb88xHJ5D/w61tg2GOSMWWkNufv/zYuDsV3RKmTN?=
 =?us-ascii?Q?lMJar52Q1cLS8FnFg9/wqaTZHqHhVuV7HY1kjoY7KyoYBoHX5iil7/bb3SBi?=
 =?us-ascii?Q?HG3/r7WhOL7QckJobx3WNFDX1jzMY720dqtFvxx9sTdJju32NA37MeyNcDKc?=
 =?us-ascii?Q?NKBL/vonAYwZRvcBZ5yQql+81cdQCg3KIBb2wGQm/tLRci4iL2ILH3Yi5tqh?=
 =?us-ascii?Q?WjvVh83a4p3BVsh4QdSlSgcTkwuLNyKnxTHyXx1q0Qu+HEopgXP38SMHNTiI?=
 =?us-ascii?Q?EkxfPeR4aBqvJS6pU/9AErtH5d4NzR8R7bceWjHBWD96O7xbq9kXODT96E+h?=
 =?us-ascii?Q?tnfC28+0vQwRH1hGC2NRQmCg+9edi9/LUW/NeFnxZONo+1PWwQeiExhV4PEr?=
 =?us-ascii?Q?jYwT2y71RVTLx+ztBkYBcC6oNzW8Y2x+R/pUPMDFOOOIJErgC772sJ4ZgY/7?=
 =?us-ascii?Q?gg4ALGvCAK+PDhVUGnWnO43ciUdrBGKG0On0oHkaV3C0FaUqHUoLPzFtAKTG?=
 =?us-ascii?Q?x5fpLx9e8uHjeM70eLAOvaV/3KKthg+QdTRqs2ohNaFrEMXvxNajFOHtbTdb?=
 =?us-ascii?Q?7TrO8SgObsZRBnX6BXKdAltjLhdzpHQmhhJO8Eoht2ThqpniTQUC9fxqxaeh?=
 =?us-ascii?Q?YvoigQVW8x4Kq/ltF28Ncy3HEzNjvHIV4OfsFOyQgleLDK27k7oGcMnkIIKE?=
 =?us-ascii?Q?/hLFKMr1AzEZHxIgrPYf9YLau+a55u4e1dasgvSf0B6GrJJyVhXLkhUU6QoM?=
 =?us-ascii?Q?M7GF5SF8flJ/E6q6ZPneLnf3hPXm7Z249yBYYndD90zigefTxgfI52E46gIP?=
 =?us-ascii?Q?8x2R0JeN/sV2bt7AfQHg+R4v3WedNyHHFXrZlbiBcj4TFU+TjFijDQz7CODC?=
 =?us-ascii?Q?j+qkRUbu9Womvx5K/O3n/qqNZREM5zyJS7I5VtWZrvI0v3PP0rquM1H5izTB?=
 =?us-ascii?Q?IWWkl/YE2z6DTQou4TLtO6Xz5NVOCICt6W1XSQtP0w/YdE65MfGh/1olDe5a?=
 =?us-ascii?Q?bymxcxSZt1uV2/+x2Ns4vFpCLJlwZIFHYMt7VIHo21Tp8D2ETKawQ5A1e3AU?=
 =?us-ascii?Q?Y2w6MzhtKXUFKuCFFF3TO8BFBpKSZEjdQOWTZ6J7jTDFy2sDobrDqa4W4mek?=
 =?us-ascii?Q?QG199Y09XmES26PPXf18Gy0bXlAd1hAtCSl19Zeqg+Pld6KEou1Xch4F1BNq?=
 =?us-ascii?Q?Ls9iHZ4IOaGIuV41cegEaRCv+SkzDDAMTUNbSgqucPLrkA7p8hXuhkTMlknJ?=
 =?us-ascii?Q?+TeonozLTs0i5neFvfQ5kFhjrIlTg8E2udne+HLCNVVL7eHji0ZKx6pMP4vZ?=
 =?us-ascii?Q?j9htfsa8aJ5hIqeXTCgIWaPWpxT2pluLHhpfOGab?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca22b84-af51-4bf9-11ac-08dd766b3b79
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 07:01:48.7382 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bJ3EuVsSlDCh4vzqUdM8DxTEMJOuYBTNlStW23q+O8r7lV77Wi73R7hjQAFztSD6Q9GpyInd8cyljazJ75wJEawZ/9JXyJiHKXlltOsU2qQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5205
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
> From: Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>
> Sent: Friday, April 4, 2025 10:07 AM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Meng, Tingting <tingting.meng@altera.com>;
> Tom Rini <trini@konsulko.com>; Maniyam, Dinesh
> <dinesh.maniyam@altera.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>
> Subject: [PATCH v1 1/2] arm: socfpga: soc64: Update reset manager registe=
rs
> for F2S bridge
>=20
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>=20
> Add reset manager registers in preparation for F2S bridge reset support a=
s
> well as the mask support to enable/disable the bridges.
>=20
> Mask value:
> BIT0: soc2fpga
> BIT1: lwhps2fpga
> BIT2: fpga2soc
>=20
> These bridges are available only in Stratix10:
> BIT3: f2sdram0
> BIT4: f2sdram1
> BIT5: f2sdram2
>=20
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>  .../include/mach/reset_manager_soc64.h         | 18 +++++++++++++++---
>  arch/arm/mach-socfpga/misc_soc64.c             |  2 +-
>  include/linux/intel-smc.h                      | 15 +++++++++++----
>  3 files changed, 27 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/arm/mach-socfpga/include/mach/reset_manager_soc64.h
> b/arch/arm/mach-socfpga/include/mach/reset_manager_soc64.h
> index 058fdd6e548..4b010be9ee8 100644
> --- a/arch/arm/mach-socfpga/include/mach/reset_manager_soc64.h
> +++ b/arch/arm/mach-socfpga/include/mach/reset_manager_soc64.h
> @@ -10,9 +10,12 @@
>  void reset_deassert_peripherals_handoff(void);
>  int cpu_has_been_warmreset(void);
>  void print_reset_info(void);
> -void socfpga_bridges_reset(int enable);
> +void socfpga_bridges_reset(int enable, unsigned int mask);
>=20
>  #define RSTMGR_SOC64_STATUS	0x00
> +#define RSTMGR_SOC64_HDSKEN	0x10
> +#define RSTMGR_SOC64_HDSKREQ	0x14
> +#define RSTMGR_SOC64_HDSKACK	0x18
>  #define RSTMGR_SOC64_MPUMODRST	0x20
>  #define RSTMGR_SOC64_PER0MODRST	0x24
>  #define RSTMGR_SOC64_PER1MODRST	0x28
> @@ -20,8 +23,17 @@ void socfpga_bridges_reset(int enable);
>=20
>  #define RSTMGR_MPUMODRST_CORE0		0
>  #define RSTMGR_PER0MODRST_OCP_MASK	0x0020bf00
> -#define RSTMGR_BRGMODRST_DDRSCH_MASK	0X00000040
> -#define RSTMGR_BRGMODRST_FPGA2SOC_MASK	0x00000004
> +
> +#define RSTMGR_BRGMODRST_SOC2FPGA_MASK		BIT(0)
> +#define RSTMGR_BRGMODRST_LWSOC2FPGA_MASK	BIT(1)
> +#define RSTMGR_BRGMODRST_FPGA2SOC_MASK		BIT(2)
> +#define RSTMGR_BRGMODRST_F2SDRAM0_MASK		BIT(3)
> +#define RSTMGR_BRGMODRST_F2SDRAM1_MASK		BIT(4)
> +#define RSTMGR_BRGMODRST_F2SDRAM2_MASK		BIT(5)
> +#define RSTMGR_BRGMODRST_DDRSCH_MASK		BIT(6)
> +
> +#define RSTMGR_HDSKEN_FPGAHSEN		BIT(2)
> +#define RSTMGR_HDSKREQ_FPGAHSREQ	BIT(2)
>=20
>  /* SDM, Watchdogs and MPU warm reset mask */
>  #define RSTMGR_STAT_SDMWARMRST		0x2
> diff --git a/arch/arm/mach-socfpga/misc_soc64.c b/arch/arm/mach-
> socfpga/misc_soc64.c
> index e0b2b4237e1..104b24241e4 100644
> --- a/arch/arm/mach-socfpga/misc_soc64.c
> +++ b/arch/arm/mach-socfpga/misc_soc64.c
> @@ -107,5 +107,5 @@ void do_bridge_reset(int enable, unsigned int mask)
>  		return;
>  	}
>=20
> -	socfpga_bridges_reset(enable);
> +	socfpga_bridges_reset(enable, mask);
>  }
> diff --git a/include/linux/intel-smc.h b/include/linux/intel-smc.h index
> a54eff43add..6455335bae4 100644
> --- a/include/linux/intel-smc.h
> +++ b/include/linux/intel-smc.h
> @@ -1,6 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * Copyright (C) 2017-2018, Intel Corporation
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
>   */
>=20
>  #ifndef __INTEL_SMC_H
> @@ -482,10 +483,16 @@
> INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_
> COMPLETED_WRITE)
>   * Call register usage:
>   * a0 INTEL_SIP_SMC_HPS_SET_BRIDGES
>   * a1 Set bridges status:
> - *      0 - Disable
> - *      1 - Enable
> - * a2-7 not used
> - *
> + *	Bit 0: 0 - Disable, 1 - Enable
> + *	Bit 1: 1 - Has mask value in a2
> + * a2 Mask value
> + *	Bit 0: soc2fpga
> + *	Bit 1: lwhps2fpga
> + *	Bit 2: fpga2soc
> + *	Bit 3: f2sdram0	(For Stratix 10 only)
> + *	Bit 4: f2sdram1	(For Stratix 10 only)
> + *	Bit 5: f2sdram2	(For Stratix 10 only)
> + * a3-7 not used
>   * Return status
>   * a0 INTEL_SIP_SMC_STATUS_OK
>   */
> --
> 2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

