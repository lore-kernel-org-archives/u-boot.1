Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF50C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 12:40:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 224C6806FC;
	Thu, 24 Apr 2025 14:40:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="PCbbn1ZJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D747B807AE; Thu, 24 Apr 2025 06:08:25 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E17F803CC
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 06:08:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2tsIea/TuaETOfMZw2Ia+dTDuT5xA0oBIcAAYzLprit/HLX4MsHM10mv4tmCnuiOTMhbXf9VOAXSorEeCOHhF7zPmF4j6TH0/213P4nb7znYnDobyVSbkWIZge7cDrdb8rQf0IpbR8QMVVNvXJ6WPvgs23xMfIcvsC5H1ipWloz2E2OPBfMinhSGg0QemCJEoVOrea2qs2UhmxlGnJkp4TGtYukbNo8TRvqNv+2MwamXT6e228sgM5CbByrf1VnK56q16vPqLcEBnOejh2wiUsW5kzbdPDGrsOhYFam3oyInYcNdZOORM01U+1xDiQnyBW0OuuzFZOtDAw6vdgMNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugYHXXh7daShyKsO1wM4OPeC5mTcMSbfDkLB8cTty5E=;
 b=THE3j3ksNYuMb07mBfU03BwKX2gb5+lZj33VprckSuolFhM5seplnZTMZw6Ma0EMJCLvTkKCEkNtpp3Qdv0vMVx8iJIuau4pl9AgZ+NxD9wMoNtsCIyoEiCuG0LiD3SET65HaUX2S4r9Aqg4hpGEmBsHxkykd7CxHAzsnNKbSuaRUBKQu0ni9nlNRHTIfEhivCXUVOzrQQQMLOspo6sgg9gG2r75xqZN446Lz5CMGlkeEbvcH9jOIxLi/PNw77AgFu6M77qGnY0rRzVm6k/oHGwDSPAAa84d6dYsrMa1ad9UFARwYeKHEcoouum5GOxjuQWDWk4P8zQX2I55fDOFpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugYHXXh7daShyKsO1wM4OPeC5mTcMSbfDkLB8cTty5E=;
 b=PCbbn1ZJGx+uF8U5q5pab+PE+VlMhdneggrbJimQ/MuhXQWc4xwz7XPXcsKgjSip5M5Wb/wW5flmd3VjJqXeu2N9acZOyy42lqYykaUcEVlcfiZQdjY2lJ8kh1tk9bWpe6C3zRsiZ7+79yTCjBV9FWoKILd38JdO977/f5NvJoHd53kaUyjI5hYloDoEcfZD+rXm2oQTsyGY6dLDetIWdv3zepuOPd7CHjvRoQQixx2lUgBJvIuulx/o5e2G06GvAc32xcrNTPT8oL7KU+1+pj47o1Fw4stiodPOIRG2wT8j01GevmWd/cyoB4H6idoYh6k4vLzsmC3W+pHjFiAzCw==
Received: from SN6PR03MB3421.namprd03.prod.outlook.com (2603:10b6:805:47::31)
 by DS0PR03MB7177.namprd03.prod.outlook.com (2603:10b6:8:125::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Thu, 24 Apr
 2025 04:08:21 +0000
Received: from SN6PR03MB3421.namprd03.prod.outlook.com
 ([fe80::6b26:9fef:479:95ec]) by SN6PR03MB3421.namprd03.prod.outlook.com
 ([fe80::6b26:9fef:479:95ec%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 04:08:20 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>, Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>, Dmitry Rokosov
 <ddrokosov@salutedevices.com>, Jonas Karlman <jonas@kwiboo.se>, Sebastian
 Reichel <sebastian.reichel@collabora.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>, "Ng, Boon Khai"
 <boon.khai.ng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@altera.com>, "Lim, Jit Loon"
 <jit.loon.lim@altera.com>, "Tang, Sieu Mun" <sieu.mun.tang@altera.com>
Subject: RE: [resend v4 00/12] Add Synopsys MIPI I3C Driver support
Thread-Topic: [resend v4 00/12] Add Synopsys MIPI I3C Driver support
Thread-Index: AQHbrz8mOJ72+p8NY0Sk7FhRzY9Wj7On4ryAgApbnDA=
Date: Thu, 24 Apr 2025 04:08:20 +0000
Message-ID: <SN6PR03MB34218D1E1C610529498E313EF7852@SN6PR03MB3421.namprd03.prod.outlook.com>
References: <20250417021840.6212-1-dinesh.maniyam@altera.com>
 <20250417135711.GU5495@bill-the-cat>
In-Reply-To: <20250417135711.GU5495@bill-the-cat>
Accept-Language: en-MW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3421:EE_|DS0PR03MB7177:EE_
x-ms-office365-filtering-correlation-id: 4a6954b0-1251-4aa0-853b-08dd82e5a660
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|10070799003|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?F99p6QXSdnFbEUj/oyUTAEWg6vxXicQ9I4gf3cGoMaFeUk+u4MKnKdwyLlTW?=
 =?us-ascii?Q?zjs+cm0oCYtoQQv9/g/3F1I4UgXUmQoNF1tQpIg1sVMk/zDGPSSf5qqFmvjW?=
 =?us-ascii?Q?SAbx1MWNvlnp66xKgxlizFwjsxwNYTlfurk9PbnUdaM8YubxOkP4TMAUo5Vb?=
 =?us-ascii?Q?Dua3rJFow2l7ArdGMvBSsmOm936ptiJ73wGmS6iYFxQSQAe/q9t96w1GAqXV?=
 =?us-ascii?Q?jiJAdt054gipP1dSCeq/81+Q0hJUmfma2xF6PHwKJEpgJBfMmSqH8SPVhjmb?=
 =?us-ascii?Q?tvn3nUyGwMe8radwqnRlEaYXJekov91xX9fZvqd3LLJ9KeDx/YEAF9QxLXxH?=
 =?us-ascii?Q?N0pH+cnDgdSKWe9SUA0lWX6uGE5cW3pZZD6AChSuwwt+tm/jkleT3pff0uu3?=
 =?us-ascii?Q?r2BJIs/jalLw4yLhe6KGAxRPqWM+epT2YlUJY+L6aHxMSN9ExTmhlueWcpx+?=
 =?us-ascii?Q?l2JCihi7Y1tirR87KNSW5Uechu05upTeKI2DNbM2uBqSyBepToJKr6bwAjtr?=
 =?us-ascii?Q?A24jhAngadpOWhlFeg7eOWFkAwCqmN2uDjhJ4nSEQcQqPGeCk+z+BnZZXODs?=
 =?us-ascii?Q?jZDycFCFaTYGJIe//z2uAtOV1/xu9wGmnZLo7/wORJdZrMmkq0HY3Ih62iLK?=
 =?us-ascii?Q?IgpARL+Dva3bH2Kw90zsmV0PHjoTPAR637TQi1HVN6idZCvJziK6qe2NPTSQ?=
 =?us-ascii?Q?9ayx2z+zYPypRupMPxaOuIv1lpDZ6I4gHfyE9X+BVPLwdo3rrAOqDsF+917k?=
 =?us-ascii?Q?V3DvV9ibtVQX0ccG7AoWjg8u9tQSAEQi7k/wMWBu+AVOaVy1pJuutcJMcyWp?=
 =?us-ascii?Q?z56F4nHIUdkdcJZFeFzCLjdlv1saD3ABkbXlryp0o/QvnD0LyLgV5sF+MELH?=
 =?us-ascii?Q?18lB9RofS6BqitK3iHNEhycgLT9fgq8GGKilM+bjv2hbPqVPgaeeya2q1KFW?=
 =?us-ascii?Q?skLQzigxaMuIEEaUdrZznwFp49zwvwHplh6528NDmDIUFrTNMoaLbH/zbcAt?=
 =?us-ascii?Q?XhbYaPsRqqZB2al3rmd2+Otr6flQMciYSWrLSedkHB9f0nO0K8r2+8JswomF?=
 =?us-ascii?Q?n9twpZWJBJmGPXRvgigeGBPjD2yyWlOOqTNX2EmLVruOZI2+jz7vdpY6rvFA?=
 =?us-ascii?Q?o/37T87+gttPGBsY8YtylOzgaVFzOm5/Eof1Xz1FraE155jUZvYJMA/Uqz0W?=
 =?us-ascii?Q?KEQAhb/EjyyGSVtibdBNHXubAQuYNSSc0PyIj70NKs1MlbESiiJ6J3T+XHiW?=
 =?us-ascii?Q?p+jD/5W+CwxPyVE/rYiUsOkMBkX4jsWafNwN8S16lWRQXgsgDxaBssMf+yMp?=
 =?us-ascii?Q?cxVGY77TDZGL9rXTeYN9RCTrOcPlA0azyrVhJv0/FT/VmDImo2k/CpaV34wA?=
 =?us-ascii?Q?tWVyN0ICuQ6dtXQ33NBzxRusf86ZrjFAac/7yJv6PVIEOuV35a7ove0BhF9M?=
 =?us-ascii?Q?d1z574B4/SAhB+hlTr2aPDbGRPlmyC/p0r1NYBxTVGzec3qqrW1MHA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3421.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FIgcSLZalUJTKhL7guneFegmUnDUrk/n7M1OUnCsfpt9/Ct4avCycQ1p6vSk?=
 =?us-ascii?Q?mKsu0hG18iX3XZRiQROZda6XKEJfYDTUELopTfWAYwIoue5Kf92T1MkKhFkh?=
 =?us-ascii?Q?gw/KkvvQW5kL1s4FwnwCQqfTNS7nPez+zSRtcQ9S1sjpGUlWQ7hQFBEnkbAH?=
 =?us-ascii?Q?VK2OqebxHgx/MbGGI2NSc1gSydhgRWuwLF+VztbfkOALV9WrHxgdGiSi9AW3?=
 =?us-ascii?Q?KEsqfDPUiUS5riA/rpVD6AAqsqb2WVaGcFvuzXUfR4t23zb2Q6eTOpylAMwJ?=
 =?us-ascii?Q?uJ0kXeZ3Uc5IVo5F+bC0wVTQZxfVjEqxy3UaVp+ZDelh9uhxTAr/zU+7so9C?=
 =?us-ascii?Q?JIZeZrBwWdjiq68/MecnDz84wKXOP6TY5db5OiOAgIOuXWwBgRJO2lbMSJ1o?=
 =?us-ascii?Q?nvipUKO2izaCB9/m5sdQ9f0H7NRtNSRPpuYOeTCuTGRiUDqL5asmDj7DFkdx?=
 =?us-ascii?Q?a1HwNxM07S0Mnvs0FLVamexy9rwHJ4AaIfQ76MhiNybWkB9R8indPArVx8Yl?=
 =?us-ascii?Q?QvyeN/J057M478R6yLs3bUdwJS8kEgRyencKFFHDPAECQYDzyR/p1ANVx00L?=
 =?us-ascii?Q?MXb9t7yv5nqK53qRg5U9dKSRl1IdtcWO/vuepdEziO0o3CiKt0wyu3lIaklU?=
 =?us-ascii?Q?hMole5WsviecI5lj1yzD97a3kM1CoyoDIgAQBFg50NQ2l3j/vvIoOxeHH48o?=
 =?us-ascii?Q?PKjPk3gaydRqUxnWvy2Rp/wa5QtmNWPJ2XnY7U2xkl39W270R/dLzEWuE4O7?=
 =?us-ascii?Q?Mz23NKcdd6WDT8pF+Hnu7QDmH1OW/wwL1TFjNKK7Yl/ScP3wqQD3KNqy2Gs7?=
 =?us-ascii?Q?nSrQT0MKKeVc40Q6b2A4Oxf9PhSaKVn+gpAgPuqCE8OgUpkZxEUgoFXIFblN?=
 =?us-ascii?Q?5PGhz1gTWVgCcp5euj9uqp2gRCE4Rd9zI6JfTi/RGSQnAMNqCbJu1YhPVUPP?=
 =?us-ascii?Q?ABwCh/+lR45udXPagt1PYyEUr83pMK/MJqbZwYjjsiD81gDeRt8sKznJGDiR?=
 =?us-ascii?Q?8+LOGPQi6nByhIEpKFoeEjIL0bB3jo8PFD/9ahm4BZaO1hceDD1J7qlFDGU2?=
 =?us-ascii?Q?l5VwEN2GBc0cv5Z7yudS2s+ZD+XwrhVWhhF8XaiRWCBr+GsJ9dKlAb48TA6Q?=
 =?us-ascii?Q?JJFgzGnW7iAu9AvsaYyXG8FQ5KOw5ViXn6EAzx0ovt69Tj65P4EOrxS2dAkY?=
 =?us-ascii?Q?+HEwKqSENTwyhIt136T68NR86aMrl6CK8ZRBsdPRZCvfeRFNPnIVLovPB/br?=
 =?us-ascii?Q?0vvBXw6H7Y52SiolB4XXTjuNTaro4VvzMQKSWHjuc3PXeYHOQ0RZdFghImtY?=
 =?us-ascii?Q?Gm3W2FytD/yLlL/t4eRMtRJyG4crcmzFP7gAGmi28Hf41cMJ2maKe5ltFX1G?=
 =?us-ascii?Q?Sc5CG95LcTjvwGwhcI6X6kTgm7maDprKRK5HVb7OEB8dV+Il7XAyKpryMb58?=
 =?us-ascii?Q?S/5pCaPrAU6JAxM3n7RjWQRAC7DC6XXYDx2q2Y9WP/CDKa8WzTTQcM6NcLN/?=
 =?us-ascii?Q?FsQ08hZ6JcVS+qecXQkiKffuOxBiI6qx1mk18LcZQfQlf2KzsoA1MVPvIKnh?=
 =?us-ascii?Q?izpxbJCXs185f8Lnc8ANUqRzY3PEwkV804kGVWYnyCqz/mgKj8mzglTmf1ma?=
 =?us-ascii?Q?Fd+ZNhrrpbw5JGyRMzTMBaiIn5pxfwFvbYOpQ52CETiW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3421.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6954b0-1251-4aa0-853b-08dd82e5a660
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 04:08:20.6658 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ibydE/W/ZeNbpbeGtpYEf38jDkZ077PvkZNsNEuTMCaPRzoT0iCfE+HHgI1hmZMybWivchxooJ0Sez2buEHBZ0UMsn497C9D5gYj3Gfjuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7177
X-Mailman-Approved-At: Thu, 24 Apr 2025 14:40:20 +0200
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
> From: Tom Rini <trini@konsulko.com>
> Sent: Thursday, 17 April 2025 9:57 pm
> To: Maniyam, Dinesh <dinesh.maniyam@altera.com>
> Cc: u-boot@lists.denx.de; Marek <marex@denx.de>; Simon
> <simon.k.r.goldschmidt@gmail.com>; Simon Glass <sjg@chromium.org>; Dario
> Binacchi <dario.binacchi@amarulasolutions.com>; Ilias Apalodimas
> <ilias.apalodimas@linaro.org>; Heinrich Schuchardt <xypron.glpk@gmx.de>;
> Jerome Forissier <jerome.forissier@linaro.org>; Mattijs Korpershoek
> <mkorpershoek@baylibre.com>; Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>;
> Michal Simek <michal.simek@amd.com>; Dmitry Rokosov
> <ddrokosov@salutedevices.com>; Jonas Karlman <jonas@kwiboo.se>; Sebastian
> Reichel <sebastian.reichel@collabora.com>; Meng, Tingting
> <tingting.meng@altera.com>; Chee, Tien Fong <tien.fong.chee@altera.com>;
> Hea, Kok Kiang <kok.kiang.hea@altera.com>; Ng, Boon Khai
> <boon.khai.ng@altera.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@altera.com>; Lim, Jit Loon
> <jit.loon.lim@altera.com>; Tang, Sieu Mun <sieu.mun.tang@altera.com>
> Subject: Re: [resend v4 00/12] Add Synopsys MIPI I3C Driver support
>=20
> [CAUTION: This email is from outside your organization. Unless you trust =
the
> sender, do not click on links or open attachments as it may be a fraudule=
nt email
> attempting to steal your information and/or compromise your computer.]

Hi Tom,

Sure, Noted.

Dinesh
