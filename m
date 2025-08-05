Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8643C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 08:19:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E11C84199;
	Tue,  5 Aug 2025 10:19:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="QZDjCWk5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A45B88414E; Tue,  5 Aug 2025 10:19:16 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FBE88419C
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 10:19:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BE75dix8TczTp09BnkWaIXtAAwntC9qrZwz2LSklmiPh78Dxr1j/PSuI9zGcmvWCoaxSkQjznkTzzGiseIaegmzunv1ewA4TWf8MMCiHTNGm4u6OXt0c/4LapZ4B8TbX7z/CNAjcQxJ1e/9EKvMukQP/J2CDEXz0zLjSlSMvO5LU9h0kmep2DvbhJynhE08DN2Pc1tkzAE4KulYroiV73AWytuj6H18tYK46VwKgpda4n0zSEx5X0V21wUiN6a22WnXvUX4LF2ErKdqG416djAjspzQFAVSb9qk8Q/3Z4g6x5l+bWlT7SFh24kyLRxH2JP11IXtKxM1uoWDEuSEecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYDDdbIgVzb6ApTvdv/bsB+1bDt4Z1RNijsMx2/ZX6I=;
 b=IGNyyMt8zV6B6BWAv73He48cVzIHgkAxlRjSOoztPIFUCoNCtywkjBBSsdlUGOkurOs/pWgGj0XXBX2TEMvbD7WZ/dPwUw6G4lZ+mQO39CJLmwaNHmYoFk45p7vfncT5Ux6Iz+lO2sq/lgNVn4TWiyJr07g1zRkwcPpRbT0nzLTgMXwh0Z3/ahRIRs1iUH070cfPnWfO7SZEJB9WmrIgqolwKuM+3MdQkQSpLOsjZzr76VInewMruN7vvSTg7wuP34oCSOzT4yY5CK203tAGs8yRSGYWH1NAKeREwxZPhXAvRtl0ak+dgvN4G4/gVbkIycAW4ZTGiDzm+6wrI4yPug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYDDdbIgVzb6ApTvdv/bsB+1bDt4Z1RNijsMx2/ZX6I=;
 b=QZDjCWk5/Z72x3hwuD+TMn8MIreeplhPqGzXatXIDev8ytCV5GASQzWdxK1PviEJwq0z+5Y0jhaGJQl4L7QZw5RJDhMqhRCSxZru18HnCPosUyR06td5Nr1pamIwyXf0BfXGtD11FBxANX8z9xWFurge4T+4qFNKwsbxdd5EXzdCiKDomVa97NQdtpeE/pdaBJu7oLLEWvntRyEJXD4sl7VdwnvuS5e4rM+vZ0MXfCTSTnddQzRxdbmGLOEQOAIVZhlY2uziUNncGMMak/Rtm1sdFazghDbuyrUE6ZZMvGM5BoP0IrP6i0+ga2NgSyec4VDAyHpiZlZeb1eADoPe5w==
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by CH4PR03MB7601.namprd03.prod.outlook.com (2603:10b6:610:23d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 08:19:09 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.020; Tue, 5 Aug 2025
 08:19:09 +0000
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, Peng Fan
 <peng.fan@oss.nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Peng Fan
 <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>
Subject: RE: [PATCH v1] mmc: socfpga_dw_mmc: Retrieve clock manager address
 via clocks phandle
Thread-Topic: [PATCH v1] mmc: socfpga_dw_mmc: Retrieve clock manager address
 via clocks phandle
Thread-Index: AQHcBNlbuv8x1LOuUUKxpoyYzAEHfbRTc1EAgAAeuLCAABsBAIAAC6KQ
Date: Tue, 5 Aug 2025 08:19:09 +0000
Message-ID: <PH7PR03MB706329E728D62259EB67B396AD22A@PH7PR03MB7063.namprd03.prod.outlook.com>
References: <20250804004710.10222-1-alif.zakuan.yuslaimi@altera.com>
 <20250805040750.GF29103@nxa18884-linux.ap.freescale.net>
 <PH7PR03MB7063F3EAF4F0BEC770E333D3AD22A@PH7PR03MB7063.namprd03.prod.outlook.com>
 <LV8PR03MB8137179BAE53AD6A8DEDE13AA722A@LV8PR03MB8137.namprd03.prod.outlook.com>
In-Reply-To: <LV8PR03MB8137179BAE53AD6A8DEDE13AA722A@LV8PR03MB8137.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB7063:EE_|CH4PR03MB7601:EE_
x-ms-office365-filtering-correlation-id: ab94ece9-7bb8-45bf-4d4d-08ddd3f8c0ba
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?vcn3FGorNLkAfgGw1TO1rSVi2ccWUvYFmUavFavDHYNCAGozIz0K2CA7gPua?=
 =?us-ascii?Q?EgslFU99jhdn2G3r1n3r2BEETgxdrWFLLulP65+sRM5h/GPoUfswKHuwrjhD?=
 =?us-ascii?Q?e5Q40TVCSWHlGbgjECAWIJwDqazI+Up0Wogi64thwrP33NfFYvfm3G1iH3rG?=
 =?us-ascii?Q?BQBSfTFydX7htrMzuLUIGbUBj+j5h4ST+rTU2TmJDMbuK2QFvJHcEeWDT4VY?=
 =?us-ascii?Q?eLmfWG+FP6zu35zToJMeAZ7DEWvJqD0GqK5veKHb9zwzp1zjPCGeqdLCNu2N?=
 =?us-ascii?Q?Egnigv369Yzr3jW5L/JVggua0q1d6cBGypO6xIn4/fVld7oY77bRWIK1PSsQ?=
 =?us-ascii?Q?5AE2DZu2efyoX1XUVng5TOq/9sg2oPMyEaEVc5rOGff0LCmmPI4NUsiPiJUW?=
 =?us-ascii?Q?b3eXwsHSf1UicNFc7q/H3c1FW5Yd5w+2b9EFNRu6g996bh/NR3mYMnay43Py?=
 =?us-ascii?Q?fJQihhc+E2w32m6WvCNrN0CWYTtgIGZLuUxKu2QqNJBhAgZzZ86Ozjfxv7ia?=
 =?us-ascii?Q?yCDu02Ez8kcGO2yNfc4bTck0Rt/HAj2xe/6SmO5FtI7BTAx3I8eFsUzcZxLp?=
 =?us-ascii?Q?Dn1ZYVNvvf6l+082zSfw6QGVF894+w0DNJHzpSnHaWAY1xxxRZh/PUr7wO6t?=
 =?us-ascii?Q?XUtniyhy4S6nIbB3iFnMOISXKI4ZXnkZjV3XDXrpq03mTlou/qx6610WWGN0?=
 =?us-ascii?Q?qKu2fqht9gmKBp1BCWfw52OfGFGJXb9Sd3wW+QkzfHe12otCYTy68ZEMmQib?=
 =?us-ascii?Q?Dn610S6bim65kEKzc72R9ObEe6CyChnfgKiOb1xdjkqVjmtnixQYnK8hLusG?=
 =?us-ascii?Q?X6wjJWumFw3ZVnX5sfMjYenzdydqzCAf0zGmCLdLQViNzOfLRIkxU7RiZm+7?=
 =?us-ascii?Q?4gkz4UgtUsu9dBHwoOubsvxxjX2dFApsusYP8qdw3kKmlpJ/0Lg5JdsKIP9F?=
 =?us-ascii?Q?rQ8mO9jiXoGuvTtd1EcGL/ra4McU1CahgdtYiL+x8eev21qfBPp3iit5vPEH?=
 =?us-ascii?Q?5qomxJQzT3W295VBm1FrREfZUut1EkYu6/SnEA0WK1tWSQEwKRUiRXyLFIZ1?=
 =?us-ascii?Q?upjFnI94e/FDaQdC4dTAI7xlJMD8oTJKLJarRDziCFSn6E0sT4d1fqOz3gha?=
 =?us-ascii?Q?lEvoANNvETR1apmfGtxxYpj95JpFWt29XFqRlsygCm1ixzEx1EJ0cc8X2bSo?=
 =?us-ascii?Q?y+DnEIu5mCEov0IXH8pTSjU2DEbjPugNBa3ctcMyWt2ZkrnGwWvqck5XBu8t?=
 =?us-ascii?Q?mx1U3nfyd+MQZBVRSQBpF/ZWz8PI9T2mVgIdIf0DotawlKTliqqMEu3aBnV4?=
 =?us-ascii?Q?BZ4IvWgNayrvZcjnP4/h5sTuIP4OT3t1ktcQdFbZ0kKs57kVz2PtmuMLdOGb?=
 =?us-ascii?Q?0wNhtwkebyYjC0T94Fctfv8/+emJyH7suQrSxlOhc2u7BMgOu4Z4tYZXu+uI?=
 =?us-ascii?Q?Oua9p9j+psZZyxrAKYqtaxNYkkTHAaTid9UKCzfwItsTCfQrynn7eQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?By7RJ+DTUCQTPlHQYC/95hkQ1FEo6wKvF16EwfHw+O9V5AN4rMJ4kxrrH8KC?=
 =?us-ascii?Q?E6nHhhC/pBg24tOTuSQ/BRjA2hI1pluDw4Oyj9xgQdnatR/N3uOfSezzsN0J?=
 =?us-ascii?Q?duNlyOyYwaiB6PXbA/a3RK+UESUizgrYPmYwFOWBC0s2PDY65bt6d9muZT00?=
 =?us-ascii?Q?UKHSbnHtUhrPqiyUd7lMnUYOK6VuaF6UEXlEilx522AKmKywjwEwutd3Yt1C?=
 =?us-ascii?Q?EpFAjwXuEnm4Jrij2+cyM1b75qVraTMqhLd1GCjS81hSU3NVCRDAmCfZ/Y8p?=
 =?us-ascii?Q?NGS5qW1ndocrUlgULE1W3xRhp04zSlauGR1qFhq+daHVuO6x33yluWYpqERI?=
 =?us-ascii?Q?HijGvMuiHlQUEhnAcMulh7uAkZhXdZwpTxeUB7wIHIGM+oxMKd8e9lGbBuLK?=
 =?us-ascii?Q?+i7nO1EZTE6livvdYCIgSWw5NY5kh/iLpO4EGA+o6knRK7/y06YIS+0RgY7a?=
 =?us-ascii?Q?+NR96+b2sir7uz8sixOPF4Uo0O9Qd0/kOu8OxyUyTDnHobKPVB87ioK3UO26?=
 =?us-ascii?Q?pzljCbVj0GqvVpfFmdLeek3K+/WqiZZCv1Ru7Rs6jlaCauriTvVflH1WJ2Jc?=
 =?us-ascii?Q?ENrI3hwBpSFE/8oAIyOP0siVTRLpNmOsx5Zni+itgW9GncVftNJhRBsf6Irl?=
 =?us-ascii?Q?tPfrwhOjwBic5gw1PsqMB0kbCZwdGN7fPD9ge2eGIY56k0DQjCRCRyTx/rw0?=
 =?us-ascii?Q?QO4/5MBBH8M1oK98rolE1s1z164tAF8diPLLNJaIJa4Rn5RKMEurx7eSwZ7V?=
 =?us-ascii?Q?8JE6ipD8SImsLMw0Hz/8hJm9W/yMZlijlHFoISGJ32yDIX/sB+CpqsSRmKOU?=
 =?us-ascii?Q?WhFCv50elDVos8VlOVkoHjMAbJZGzQw/HT0tqjFrYO/WxYn0HVNG4rV0FbZm?=
 =?us-ascii?Q?yP9jz0tfLHKXRdK5vrfEsdHq+KUE1niTYrBiwRTTePZ+sGhFbzeaVRlJTPkr?=
 =?us-ascii?Q?sZj5GwD/I8+HSuPqvpvEYBiaJ4TtzHsZZjId6VS4USINBIcJDpgw56eHHWr4?=
 =?us-ascii?Q?nQwcPD+gxe30eXELJpkfbPWLExolvR+4bpUsN+Sr6cRxjVlOkprsxUrwOpYX?=
 =?us-ascii?Q?XlPkz0RJGOKF/8fmvKFyMQhKLTW4iCUFTm00Pfuv+XaDSDKaQ0D9IzR+N2SD?=
 =?us-ascii?Q?7FDwU9c/QAOnvVGCL/DZQhJc9/I0eCmwPr+ZvHfQaExGOG/o7RuDmhxFyYz/?=
 =?us-ascii?Q?WHw76Wz1ti4+6lt7mG5yGUS1RRxpXcl70z9CraVMQvjI7HiEVbZaHkbpuegb?=
 =?us-ascii?Q?JFyaDAxmq/oqN+TVnz7oWd+TZWgS8CJ+0aKZEGIW0GUYrSKrtx1B7aeuXUau?=
 =?us-ascii?Q?J7gNG1PJljZHPQ9eJ7DLWSYpvcvJp0AaholUU3TcZB4to51BGaVZxGFvPzkS?=
 =?us-ascii?Q?HM2qEUNz81uFeK6R6X5+ADeHdnJa9hgDT7bq3gWj7+MfxyV262U5Z2me55a3?=
 =?us-ascii?Q?kctsxgYZhv9ns6YK4ttG2bmm3waKTLWh7tJKPEYyy/aoX/mvlNzNq8AgVAVq?=
 =?us-ascii?Q?vg4mHt8055nNf8pzM9RpUlgfaoV0TtVZLVQGhVXLR1wzhrtTaQKP2E5M5YPL?=
 =?us-ascii?Q?DPA6j8JZZ2K1Jw11xXmnGocHnwIVDmgsieta6kb4M0alJXlAf4V7WYnBPF+U?=
 =?us-ascii?Q?TBEVaitby0hSGQ/T09+ZRr6MJfOphDRl1p7teMW6yTv8Ia2RcXdyKbItE+Ei?=
 =?us-ascii?Q?TYaR9Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab94ece9-7bb8-45bf-4d4d-08ddd3f8c0ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 08:19:09.4716 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1W5D1EwtbAg7/ZBQQ/GH+9QAbxQYBEiP4bk7k4L53w+GPUSEjpnZWJ81ZS2dRGeN8G5cBvPyti3d2p4/VVJBmu4WCWjgfX/GRO5urffJr+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7601
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

Hi,

> -----Original Message-----
> From: Chee, Tien Fong <tien.fong.chee@altera.com>
> Sent: Tuesday, August 5, 2025 3:34 PM
> To: Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>; Peng Fan
> <peng.fan@oss.nxp.com>
> Cc: u-boot@lists.denx.de; Peng Fan <peng.fan@nxp.com>; Jaehoon Chung
> <jh80.chung@samsung.com>; Tom Rini <trini@konsulko.com>; Marek Vasut
> <marex@denx.de>; Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
> Subject: RE: [PATCH v1] mmc: socfpga_dw_mmc: Retrieve clock manager
> address via clocks phandle
>=20
> Hi Alif,
>=20
> > -----Original Message-----
> > From: Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>
> > Sent: Tuesday, August 5, 2025 2:03 PM
> > To: Peng Fan <peng.fan@oss.nxp.com>
> > Cc: u-boot@lists.denx.de; Peng Fan <peng.fan@nxp.com>; Jaehoon Chung
> > <jh80.chung@samsung.com>; Tom Rini <trini@konsulko.com>; Chee, Tien
> > Fong <tien.fong.chee@altera.com>; Marek Vasut <marex@denx.de>; Simon
> > Goldschmidt <simon.k.r.goldschmidt@gmail.com>
> > Subject: RE: [PATCH v1] mmc: socfpga_dw_mmc: Retrieve clock manager
> > address via clocks phandle
> >
> > > -----Original Message-----
> > > From: Peng Fan <peng.fan@oss.nxp.com>
> > > Sent: Tuesday, August 5, 2025 12:08 PM
> > > To: Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>
> > > Cc: u-boot@lists.denx.de; Peng Fan <peng.fan@nxp.com>; Jaehoon Chung
> > > <jh80.chung@samsung.com>; Tom Rini <trini@konsulko.com>; Chee, Tien
> > > Fong <tien.fong.chee@altera.com>; Marek Vasut <marex@denx.de>;
> > Simon
> > > Goldschmidt <simon.k.r.goldschmidt@gmail.com>
> > > Subject: Re: [PATCH v1] mmc: socfpga_dw_mmc: Retrieve clock manager
> > > address via clocks phandle
> > >
> > > [CAUTION: This email is from outside your organization. Unless you
> > > trust the sender, do not click on links or open attachments as it
> > > may be a fraudulent email attempting to steal your information
> > > and/or compromise your computer.]
> > >
> > > On Sun, Aug 03, 2025 at 05:47:10PM -0700,
> > > alif.zakuan.yuslaimi@altera.com
> > > wrote:
> > > >From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> > > >
> > > >Improve the current clock manager base address retrieval by probing
> > > >the clocks phandle under the mmc node in the device tree instead of
> > > >probing the clock manager node name in the device tree.
> > > >
> > > >This will help to make the driver more scalable for more families
> > > >as we no longer need to rely on the exact node name in the device
> > > >tree to probe the clock manager driver for its base address.
> > > >
> > > >Signed-off-by: Alif Zakuan Yuslaimi
> > > ><alif.zakuan.yuslaimi@altera.com>
> > > >---
> > > > drivers/mmc/socfpga_dw_mmc.c | 19 +++++++++++++++----
> > > > 1 file changed, 15 insertions(+), 4 deletions(-)
> > > >
> > > >diff --git a/drivers/mmc/socfpga_dw_mmc.c
> > > >b/drivers/mmc/socfpga_dw_mmc.c index 3b86bc9b18c..ff1dd0055f8
> > 100644
> > > >--- a/drivers/mmc/socfpga_dw_mmc.c
> > > >+++ b/drivers/mmc/socfpga_dw_mmc.c
> > > >@@ -54,17 +54,28 @@ static int socfpga_dwmci_clksel(struct
> > > >dwmci_host
> > > *host)
> > > >       u32 sdmmc_mask =3D ((priv->smplsel & 0x7) <<
> > > SYSMGR_SDMMC_SMPLSEL_SHIFT) |
> > > >                        ((priv->drvsel & 0x7) <<
> > > >SYSMGR_SDMMC_DRVSEL_SHIFT);
> > > >
> > > >-      /* Get clock manager base address */
> > > >+      struct udevice *mmc_dev =3D host->mmc->dev;
> > > >+      struct ofnode_phandle_args clkmgr_args;
> > > >       struct udevice *clkmgr_dev;
> > > >-      int ret =3D uclass_get_device_by_name(UCLASS_CLK, "clock-
> > > controller@ffd10000", &clkmgr_dev);
> > > >+      fdt_addr_t clkmgr_base;
> > > >+      int ret;
> > > >
> > > >+      /*
> > > >+       * Get the clkmgr device from the first phandle in the "clock=
s"
> > property.
> > > >+       */
> > > >+      ret =3D dev_read_phandle_with_args(mmc_dev, "clocks",
> > > >+ "#clock-cells", 0, 0, &clkmgr_args);
> > > >       if (ret) {
> > > >-              printf("Failed to get clkmgr device: %d\n", ret);
> > > >+              printf("Failed to parse clocks property: %d\n",
> > > >+ ret);
> > > >               return ret;
> > > >       }
> > > >
> > > >-      fdt_addr_t clkmgr_base =3D dev_read_addr(clkmgr_dev);
> > > >+      ret =3D uclass_get_device_by_ofnode(UCLASS_CLK,
> > > >+ clkmgr_args.node,
> > > &clkmgr_dev);
> > > >+      if (ret) {
> > > >+              printf("Failed to get clkmgr device: %d\n", ret);
> > > >+              return ret;
> > > >+      }
> > > >
> > > >+      clkmgr_base =3D dev_read_addr(clkmgr_dev);
> > >
> > > I see this driver use clk api, so why still directly map the clk
> > > manager base and configure it. Shouldn't clk api be used or
> > > assigned-clock-
> > parents be used?
> > >
> > > Thanks,
> > > Peng
> >
> > Hi Peng,
> >
> > The direct access to the clock manager base and offset in this driver
> > was inherited from the legacy implementation before we had full driver
> > model clock support. Currently, both Agilex and Agilex5 have their own
> > clock drivers under the driver model, but the `clk_enable()` and
> > `clk_disable()` operations are still not implemented.
> >
> > Because of that, we retained the base + offset logic for disabling a
> > particular clock in the SDMMC driver to preserve existing
> > functionality. Once proper enable/disable API support is added to the
> > clock drivers, we can clean this up to fully rely on the clock API or
> > use `assigned-clock-parents` in device tree where applicable.
> >
>=20
> I think SSBL has no privilege to direct access clk mgr register, so ATF-m=
ediated
> access is required. I agreed with Peng, these issues can be solved in clk=
 disable /
> enable API by having the right API access at both SPL and SSBL boot phase=
s.
>=20
> Thanks.
> TF
>=20

Thanks for the comments, I will update the clock driver to support enable/d=
isable APIs
and call those APIs in this MMC driver as recommended in v2.

Alif

> [...]

