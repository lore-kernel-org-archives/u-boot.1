Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43396C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:13:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4920980FB9;
	Tue, 11 Mar 2025 14:13:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="vrjSTGKH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF8D0801FB; Tue, 11 Mar 2025 04:51:19 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::61e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 977F7807D9
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 04:51:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MctXTo+Cc8ktR7EeOXMQVYYrxPyROsru8IYVAph8Zzviu//+hD9/0oEbeSS3YFuRwSbWR+E9CXME9K/mmcr2n9KS0LEw6KJiDhb/fl7fOZ1/yXVIKoYukr+lB9pRxydkWSoOF/eVvJlfq1VDbhS6QipwMQQo854asy+6bKEXkEO6jpdWWVwXHo2mNA+Ej26/ZRh4qOU9NXOwx0EYEGGM41jnfqy3UD8bHmWNgD52zWrsbUa9CdqJO+WL4gpQlxvm7AMVeT29D5TT3FufJ+ltU0EFrhx8elymadgJ0+qlcvWLpI+7+4ElflnFOvvxwe6eeOU6lrBkOhG1k0GB7LqCGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3p2cYdtgZ5f06YG6pdxf1yuEY/OFel8ugjCFY5vmog=;
 b=WQ1luUB1wK9igfKW5OK+AF7bi9NxYfT4nCXrbBNUt5CgIxUfAxEBcCx9Ijnky/1BfLuS/G3WQGSmI+FvOikHFjUtNnt10dMPe7V9QNtFcyofKrLkt6OCS1aR+56XgbDRYonr+g01VRWQEWA6L/YyxDaU+JcPDEQsRbiSldXsCIbjFLieup5A1GcZdEvF6qX250wvv7dt1GQFVBg/q1gIJMRtDFXrQn5DO8l0f3QImA5nHTIhQrA3qqsW6agBaz7k+YHuooVRxeWvoLIV5QR2SUPOEUvpVnd8J0CFQV2LXJMwKiQvbY8KCuSFu3qQounaJyUpag8iuLP5+gEms8QSTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3p2cYdtgZ5f06YG6pdxf1yuEY/OFel8ugjCFY5vmog=;
 b=vrjSTGKH5cy0yvhPxmZKsvtnTZBFmM9i9WYYuIqxIbbEKnFfUEQdPXdSdEMCN0zAADyFer8KdEz0Nn/Hb1JZ+YC8fXbOkix4wzIwArbX0h/qDCB00UOuX4N22FKEWj4gxoPk9eIvFH+mXMYouMIG1YQ2XLHClJuHhQo3NAEH0WAQtOOSgxs3Bu5xKlsrDQkysmDTvO3DD7CllLM5UIUtbyBj4UiV/N3uloMOl/1iZ11IPLhso6Z8lXT1zmN8juukEnSZj54Re8/Pom/iFQ2nv8OuAXcu/hP/CEbx+EKjeiFRf0Us8BBZU89EdjGfxNkcmQkTVShwyV4sd/DHVXzwWA==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by PH0PR03MB6607.namprd03.prod.outlook.com (2603:10b6:510:b8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 03:51:15 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%3]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 03:51:15 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>, "Ng, Boon Khai"
 <boon.khai.ng@altera.com>, "Lim, Jit Loon" <jit.loon.lim@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>
Subject: RE: [PATCH 2/2] configs: Enable VAB flow for Agilex5 SoCFPGA boards
Thread-Topic: [PATCH 2/2] configs: Enable VAB flow for Agilex5 SoCFPGA boards
Thread-Index: AQHbjMNOb/tGvjw08k6eOEgRWUK3AbNtWB7A
Date: Tue, 11 Mar 2025 03:51:15 +0000
Message-ID: <SN6PR03MB3583F147E747711B3D87D587A7D12@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250304050644.15174-1-nareshkumar.ravulapalli@altera.com>
 <20250304050644.15174-3-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250304050644.15174-3-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|PH0PR03MB6607:EE_
x-ms-office365-filtering-correlation-id: c1216512-bc70-4c21-5f84-08dd604ff8f4
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?bS1AqQv/bi+habj4FkMrykRieKlnM9Zjh5d8Z0UwEjk8nClOaCQsQRHUBliB?=
 =?us-ascii?Q?Wv4E19qqHc7LoVKJJguBSXN15WKm+M8Oc4Ts6kh4LYFXCF6eGgaptvoj7Zqr?=
 =?us-ascii?Q?c5usdymtDDW0RFru157Ltq0rCOJY2WsBWTKhVTuPMEEjlc+TnQ+Uhpt2L6aI?=
 =?us-ascii?Q?z2ueQHVBF3HzwJfGzhRHYlsq9uIsnq5B3+BLE+rifeYT/y1313JG5hVr9zNB?=
 =?us-ascii?Q?l5CtlvITEDPN/CYSwcgK5FuqmcecCgneMmqvrG+CRt9JufguPEWm64iO7NEz?=
 =?us-ascii?Q?4EUsS+V3RnZ5zz3WZZyWXOMfi9ksj7omT6/aX4+2xr6/KaPrEY6PNgXqHPTJ?=
 =?us-ascii?Q?HLaZhyW4kFL7/4pXN7ekTZf5o0G0I0od1yQ02Xc/w3FlpmmgWwQD2ZPbbfow?=
 =?us-ascii?Q?4ONz/iKBeG+05/qrrGbqS5M7R3x+0Rs52fhoKe8hIye6zipQzLjSQ4gxfS1+?=
 =?us-ascii?Q?8utMlj3J1PM/F/cDGrt/dGoqAWt4nFLaNxmIs1J980sK4IkmyOD4Z6URlG3L?=
 =?us-ascii?Q?Qx8CBWxkseduJcnGY2v+OJiAgSKc+RCkuTa5XQAVC29neKP7OUvr+0jWkbxa?=
 =?us-ascii?Q?jhvpI5LskUGj8Ox08VW4yieKub70HpDzjmE2EPFfVX3HkqSEQt4/MaEU3hoR?=
 =?us-ascii?Q?Oc1CzY582mJkDA5crKHHwOnWdM4QJ0rDsz/9C4JzTbECu/cQft6vo83IGhjp?=
 =?us-ascii?Q?mQNga1psE9TxLmxTb7rLf0ub4vUEhuWr8l+k9uXjTCp0tHwVmi1VnECstNoV?=
 =?us-ascii?Q?PrK4ClFKGvAd67gHdGur+wJRZX4fUc+NGTNetuB6FLAk7p2z5IdVt8FSn/lZ?=
 =?us-ascii?Q?U+UPQoxOFrW6GWqOWK7PryAykjZrDMyp/0KE2WXpUB3WySSXo2qKnFhgqtn3?=
 =?us-ascii?Q?1DkIa5LBfQ+v0wqKa+ejzRfbT5oUY1P28u42QCjAmNRKnm3yHh0bcsiFhVTf?=
 =?us-ascii?Q?3GH0c/Tu/cibLJ6tda/UFVW/chs9jz7HPvjBHFS6utKpWViFEXE+xYYBvjNX?=
 =?us-ascii?Q?PeR8dI3fcbob9ohagKNVIRYjFQr95ceXB6VFR2XL+b+aweDsRAe2EHp5P5G+?=
 =?us-ascii?Q?sfnx0Id+8mWw1FEjMw207vjdOFsWyNbwjNrZb7eygmjjuTiuOW3cSmDSIyWR?=
 =?us-ascii?Q?Kl8QC9+Bcea8L5pD22Wc+JB9xapEuP/QQTqcVqyjUgXTcF6coZI+IoD2O+aD?=
 =?us-ascii?Q?outdsbPXaQ3wK1e+Ua0IMDmRboTSuDETvdFkKQrld4/WTdU6XEigkhOBcLEf?=
 =?us-ascii?Q?g86pYIfqWGaMCRJTr/Gh066qejK2y+u7x04if6IsAums6RMjNHMET3b0OfHh?=
 =?us-ascii?Q?Oulhqkp6SxYGQ0tev/nElirg2QXihqjnY3APNLOAzwHZcAPKs0n36MrKCnrk?=
 =?us-ascii?Q?Jpw5gqcjaL4sZoPoIVcbxOCghI/191zbMz8eaPBA5CRhmyP9iVme6FXVtEXX?=
 =?us-ascii?Q?GccZVTi46Ktf59zAirkhYr8VgBo4f9Mo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O1jawmRztZTmae6z1Wn51H5T69GZWXNMvvvR7HsNX66O6RM64h009gg+N0m0?=
 =?us-ascii?Q?qjVOtfPqLRduVQ9jtBN09mBXNcIwJUO2pL8uzhTjnZ71Ot9+kpLssuneHUd1?=
 =?us-ascii?Q?EabHF0onHkr6WZ85TTa40h83wjXbGE/7xKZrNyXJgYCZtJJBizNA+ZbsYEg/?=
 =?us-ascii?Q?zY9683/HNtC91co1EemIvqzc/fihggBQW09Pro+1Y2AdplGGgqgJEqYMBlye?=
 =?us-ascii?Q?ZYhE90irVcnmAqTt3FjNAnQuJNqBVNBW/QwUVEttN0PiWrpTKKo+HclSGynv?=
 =?us-ascii?Q?Ifo79vbJQEJ3gjRxDK7LBTaATcxPbRgKpBrDKWfULXbE9ZhOKnui8Q1WM6pQ?=
 =?us-ascii?Q?UZXe6XjF4/yvJaAupWL2VyJnh0SkZSsAKl2oUa9NvgIlNvzDzdTvB3xxRiTq?=
 =?us-ascii?Q?1FL2Km9p08PkbAYgB5iDKsoFNVKaDC+kXFnQY9bKNCelxLezAEYk+JeekZVj?=
 =?us-ascii?Q?33dpAnp4Wdy204ar4O//xi2eMOmoVnf0Qoh/xmRQnKgxAHpG58aZRXAVNvAU?=
 =?us-ascii?Q?2CQyKnpKQ9kIoP4Wzncn4nP2AQ7RKFf/C0K4rl9zpZmbvxXLdmwWMfxRG/GB?=
 =?us-ascii?Q?qD5NMpnIl/SdD+iLXCCay2UaVl5GJMRfoTovty+YBFO+pV3fP2yqjbl583GT?=
 =?us-ascii?Q?J4PqJLSS8uY3xU/NiVWwDEq0LDmMoaplcEFKMl66fEuNiB2xE7BPJjMX6Lke?=
 =?us-ascii?Q?vnFUZEyJ+mDo7Y2Aec5Q+BRs0hOcGqW0tz0GCW77Dww6HirgkUVhd/Z1VQpQ?=
 =?us-ascii?Q?ACQojXYyPG9sLfXQZmG3B1zcWeuxOn7SXZMF+4sO1BV+oVEryk1DRijzvly3?=
 =?us-ascii?Q?SKlPLI6tuThqP/0T61HMYVrHhq13XoLNNoR0Ahtv0dCIz1s1VDex1+C+E5/b?=
 =?us-ascii?Q?GziW3GrV/SWefCoZLn57jfvtAnXyC2BqTqK5eADi0UNoUAlEpiPCjPaAgZub?=
 =?us-ascii?Q?zT2OrtSlOQUtvDQGb8+vAVIjv1cyYKKExW909Ye2x8WmVgbOOE8ayDM+P/0J?=
 =?us-ascii?Q?k1VU6O5LKncHBAiNtl6XWPqVdTIG2x0rG59+xF6gmLxM779/08X+hsdL3MsO?=
 =?us-ascii?Q?ZjbQf81Gc6AvvUXEwWsvPZncirpnlQcBTVqx6h4Mo1Ys6vH+/IZ7GaNYyhzl?=
 =?us-ascii?Q?I3p6LiMK4P1diYYZE7x1Gu7o79vAu0eDZWD2WEm+RR14CbqgjCl7MJwuLbTR?=
 =?us-ascii?Q?K2tutxgxGZVeyPf0IYZRyNzCCuAU2o6nIH3jkb6hmWCcHoG2aJ8PAjF9ceED?=
 =?us-ascii?Q?UiCK530zNG+K2C/hS/hjmXV2HJSOw2sTe7DSHHdiR+uvDDOCJ8bcvVP0bPYx?=
 =?us-ascii?Q?6YthpllQSjVCFay06kk1++5JCI2bZ3O6hmlrqdPN9+8hY1fgu93aPXVxKPsb?=
 =?us-ascii?Q?NsZZLw0KNLVBzsc8+AXkrzZRzxvdOSgfFu7VkABVyqppov8hT/KBaOLmfjOY?=
 =?us-ascii?Q?reFxcr/DAx4VhUwazwGivqbmmFlPnsTFAVdEfIPdhEmh9yoInhZVd17U1CZ9?=
 =?us-ascii?Q?eXZw6Yp2RsAh1GyJkUvgkqyWGPR2ElIrRnCf93/l2rEvzqXryJeciHsOiR2m?=
 =?us-ascii?Q?H8kbbl7PZaxxeXAJ6k7jlBeX5qVkrRhrqb9MpaTS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1216512-bc70-4c21-5f84-08dd604ff8f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 03:51:15.1717 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +1cu5z1glBj6x2bICoJIPO20KhSCcADmp9d9XY35x1KAjkBpFOISTE8O50K8N7Brvuuhj3XIJpwbXOpNvVK8aXze8BvZ+i/m5o96KImVUWM=
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
> Subject: [PATCH 2/2] configs: Enable VAB flow for Agilex5 SoCFPGA boards
>=20
> Vendor Authorized Boot flow configurations are enabled for boards based o=
n
> Agilex5 SoCFPGA. Also, required changes are made to the SoCFPGA make file
> for building and linking relevant secure source code files.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  arch/arm/mach-socfpga/Makefile        |   2 +
>  configs/socfpga_agilex5_vab_defconfig | 102
> ++++++++++++++++++++++++++
>  2 files changed, 104 insertions(+)
>  create mode 100644 configs/socfpga_agilex5_vab_defconfig
>=20
> diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-
> socfpga/Makefile index 22d48dfae1..c43fdee4a4 100644
> --- a/arch/arm/mach-socfpga/Makefile
> +++ b/arch/arm/mach-socfpga/Makefile
> @@ -68,6 +68,8 @@ obj-y	+=3D altera-sysmgr.o
>  obj-y	+=3D ccu_ncore3.o
>  obj-y	+=3D system_manager_soc64.o
>  obj-y	+=3D timer_s10.o
> +obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+=3D secure_vab.o
> +obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+=3D vab.o
>  endif
>=20
>  ifdef CONFIG_TARGET_SOCFPGA_N5X
> diff --git a/configs/socfpga_agilex5_vab_defconfig
> b/configs/socfpga_agilex5_vab_defconfig
> new file mode 100644
> index 0000000000..a66add2b84
> --- /dev/null
> +++ b/configs/socfpga_agilex5_vab_defconfig
> @@ -0,0 +1,102 @@
> +CONFIG_ARM=3Dy
> +CONFIG_ARCH_SOCFPGA=3Dy
> +CONFIG_TEXT_BASE=3D0x80200000
> +CONFIG_NR_DRAM_BANKS=3D3
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x80300000
> +CONFIG_SF_DEFAULT_MODE=3D0x2003
> +CONFIG_ENV_SIZE=3D0x2000
> +CONFIG_DM_GPIO=3Dy
> +CONFIG_DEFAULT_DEVICE_TREE=3D"socfpga_agilex5_socdk"
> +CONFIG_DM_RESET=3Dy
> +CONFIG_SPL_STACK=3D0x7d000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
> +CONFIG_SPL_BSS_START_ADDR=3D0xbff00000
> +CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +CONFIG_SYS_LOAD_ADDR=3D0x82000000
> +CONFIG_TARGET_SOCFPGA_AGILEX5_SOCDK=3Dy
> +CONFIG_IDENT_STRING=3D"socfpga_agilex5"
> +CONFIG_SPL_FS_FAT=3Dy
> +# CONFIG_EFI_LOADER is not set
> +CONFIG_FIT=3Dy
> +CONFIG_SPL_FIT_SIGNATURE=3Dy
> +CONFIG_SPL_LOAD_FIT=3Dy
> +CONFIG_SPL_LOAD_FIT_ADDRESS=3D0x82000000
> +CONFIG_LEGACY_IMAGE_FORMAT=3Dy
> +CONFIG_DISTRO_DEFAULTS=3Dy
> +CONFIG_QSPI_BOOT=3Dy
> +CONFIG_BOOTDELAY=3D5
> +CONFIG_USE_BOOTARGS=3Dy
> +CONFIG_BOOTARGS=3D"console=3DttyS0,115200 initrd=3D0x90000000
> root=3D/dev/ram0 rw init=3D/sbin/init ramdisk_size=3D10000000 earlycon pa=
nic=3D-1
> nosmp kvm-arm.mode=3Dnvhe"
> +CONFIG_SPL_MAX_SIZE=3D0x40000
> +CONFIG_SPL_SYS_MALLOC=3Dy
> +CONFIG_SPL_HAS_CUSTOM_MALLOC_START=3Dy
> +CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=3D0xbfa00000
> +CONFIG_SPL_SYS_MALLOC_SIZE=3D0x500000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set #
> +CONFIG_SPL_SHARES_INIT_SP_ADDR is not set CONFIG_SPL_CACHE=3Dy
> +CONFIG_SPL_SPI_FLASH_MTD=3Dy CONFIG_SPL_MTD=3Dy
> CONFIG_SPL_SPI_LOAD=3Dy
> +CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x04000000
> +CONFIG_SPL_ATF=3Dy
> +CONFIG_SPL_ATF_NO_PLATFORM_PARAM=3Dy
> +CONFIG_SYS_PROMPT=3D"SOCFPGA_AGILEX5 # "
> +CONFIG_SYS_MAXARGS=3D32
> +CONFIG_CMD_NVEDIT_SELECT=3Dy
> +CONFIG_CMD_MEMTEST=3Dy
> +CONFIG_CMD_GPIO=3Dy
> +CONFIG_CMD_I2C=3Dy
> +CONFIG_CMD_MTD=3Dy
> +CONFIG_CMD_SPI=3Dy
> +CONFIG_CMD_USB=3Dy
> +CONFIG_CMD_WDT=3Dy
> +CONFIG_CMD_CACHE=3Dy
> +CONFIG_CMD_TIMER=3Dy
> +CONFIG_CMD_UBI=3Dy
> +# CONFIG_ISO_PARTITION is not set
> +# CONFIG_EFI_PARTITION is not set
> +CONFIG_OF_LIST=3D""
> +CONFIG_ENV_IS_IN_UBI=3Dy
> +CONFIG_ENV_UBI_PART=3D"root"
> +CONFIG_ENV_UBI_VOLUME=3D"env"
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
> +CONFIG_USE_BOOTFILE=3Dy
> +CONFIG_BOOTFILE=3D"kernel.itb"
> +CONFIG_NET_RANDOM_ETHADDR=3Dy
> +CONFIG_SPL_DM_SEQ_ALIAS=3Dy
> +CONFIG_SPL_ALTERA_SDRAM=3Dy
> +CONFIG_DWAPB_GPIO=3Dy
> +CONFIG_DM_I2C=3Dy
> +CONFIG_SYS_I2C_DW=3Dy
> +CONFIG_MISC=3Dy
> +CONFIG_DM_MTD=3Dy
> +CONFIG_SPI_FLASH_SPANSION=3Dy
> +CONFIG_SPI_FLASH_STMICRO=3Dy
> +# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
> CONFIG_SPI_FLASH_MTD=3Dy
> +CONFIG_RGMII=3Dy CONFIG_SYS_NS16550_MEM32=3Dy CONFIG_SPI=3Dy
> +CONFIG_CADENCE_QSPI=3Dy CONFIG_DESIGNWARE_SPI=3Dy
> CONFIG_TIMER=3Dy
> +CONFIG_DESIGNWARE_APB_TIMER=3Dy CONFIG_USB=3Dy
> CONFIG_USB_XHCI_HCD=3Dy
> +CONFIG_USB_DWC2=3Dy CONFIG_DESIGNWARE_WATCHDOG=3Dy
> CONFIG_WDT=3Dy #
> +CONFIG_SPL_USE_TINY_PRINTF is not set CONFIG_PANIC_HANG=3Dy
> +CONFIG_SPL_CRC32=3Dy CONFIG_BOARD_EARLY_INIT_F=3Dy
> CONFIG_BLOBLIST=3Dy
> +CONFIG_BLOBLIST_SIZE=3D0x1000
> +CONFIG_BLOBLIST_ADDR=3D0x7e000
> +CONFIG_HANDOFF=3Dy
> +CONFIG_SPL_RECOVER_DATA_SECTION=3Dy
> +CONFIG_DWC_ETH_XGMAC=3Dy
> +CONFIG_FIT_IMAGE_POST_PROCESS=3Dy
> +CONFIG_SOCFPGA_SECURE_VAB_AUTH=3Dy
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
