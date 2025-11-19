Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BA6CF34C3
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 15:21:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86F5683F7D;
	Wed, 19 Nov 2025 16:21:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="QmTcwL/1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11AD583FA4; Wed, 19 Nov 2025 16:21:50 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FFF283F50
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 16:21:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjgHrHSVfOEPYaEQ4sOuluF6Wj40H547/oNRA97GRG1bZ+8EIru03XGO0lTPrEyOERaZaYN+6nfPjzjJj7wRq81CtGiz1uJii0wl0F0mdedQ6KPETMk1Df5XGkg+r00yo1LoO9UKn+pcRu9jRpmiQxQ+Qp4KxuJtwPj0nsxSsl3xNjxDi1+vqV1smO9HhUg72K+LMIV9tyyWrc02yg4Rp5a27Lr4LnvcxMtCtyB5Hp94+oBZGCKw0L4gY33IHKJz+L6aTxeoOJHgnr/VuQ0GGo9bOY+OH1B/NDYgbeD5GU2pf3A2V6bnGNXWvVF7bghrSDQ0ZjHW0bAaEPB/XV6K7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uORbIQxdHBq2599hi7Xmp/21NnwaFddQxoc5N9jjBzA=;
 b=UkXagzyAEPYo6SuUJC8SXsx3EURvaqdCeoG9Zd3WU3Qlu7phBVra2jbywNCYHiWuUXuDHu7H3XUcfhZq/TDgg+liRcDhWbrO1I3Qaaf2bOAiIfyQiyLmbF6WDShdvL2gqBoNfUNewJZbS8t/zR8d1hMKz8OxsZWSkfI78S5mAESZO+bIo5PJ4GWF+wx+N4Flp8ShBDbccUEUIQVVfo/LkArpBS8J0i5WzLi2QW1Kn9pzfKNQPoCaO/QV47wE1gnJuQaWDBW7yGGT2pxdLHsbn/YmzQNVGFoMUrWrZR2E7yP3cDeArOp/74e+tIBEJq3fnhYdNjTYrpP+TIc7EMK7uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uORbIQxdHBq2599hi7Xmp/21NnwaFddQxoc5N9jjBzA=;
 b=QmTcwL/1P2qXte2dWX/sWomTey2SURwPBw482Q/xcQQc/SCHWFcu2ZgMGen3S9oldErTtoLNNbKzPyBlQK3qxqwQI1CLCTK7bcLLhlb1zZg+tOgXMn9CpbEwamM45D/4LzKoDCUtOgoI+L/hO49NNzkID8y/BxS43nWI5RaJJEqyJ/uKsk6SVvnfo0QM1j7lzpxHXHWTKTO/OEp/dQj/D8TLVfW58vLBUfnCY9HC122Jgd+bTHucarZ6IroFbhFUM72Aw/rcEXJ4DylaD/4EK/IQdGkHC5yNMZrRupR2ftnfcyjlvqaQYkZhc6AfXh8YUXQ4TiOi5q+eSmVYkJMz8Q==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB8379.eurprd04.prod.outlook.com (2603:10a6:10:241::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 15:21:46 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9320.013; Wed, 19 Nov 2025
 15:21:46 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH] mx6ullevk: Stop disabling device tree relocation
Thread-Topic: [PATCH] mx6ullevk: Stop disabling device tree relocation
Thread-Index: AQHcWLXEPcu84X0GEUmVbQE3ngAxpbT6HvNQ
Date: Wed, 19 Nov 2025 15:21:46 +0000
Message-ID: <PAXPR04MB845976C5102794FC803EC75A88D7A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251118180418.591271-1-trini@konsulko.com>
In-Reply-To: <20251118180418.591271-1-trini@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DB9PR04MB8379:EE_
x-ms-office365-filtering-correlation-id: 42cf7e2f-7da7-438f-2d68-08de277f5a9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?DkUd/dTbZg7fUat+gLrDPfDKslz3juTmrcVMsqVQj2oy5Omuslt6+9Vtnmab?=
 =?us-ascii?Q?kfGfJFNvL0j+3f2bD7vrJM2XsXrXKKppmVr2GuZ9qSlI+rciI779BItm8G1L?=
 =?us-ascii?Q?vBQE9jhtLLBFD9Mqx5/XfaoKGQfkTp85u5/3+W0x2aYajkL3+m59wA/GNn7B?=
 =?us-ascii?Q?W38DSK+KEVF5lq8Byny0/c9VeuDT1iMTO3GsNZ3CM2kgpZe9XtULrsw9bKdX?=
 =?us-ascii?Q?CeTW0n100yYY4wwBa4tEojgJUWGatxcGA3pUgPF666ST/ttibmPmh7NtyAf8?=
 =?us-ascii?Q?XSidxAYVMqn2Xe+bhSd3+TRZI2FUMALzstdFOrtocgxkN7DwI+CAUIQnoKbI?=
 =?us-ascii?Q?VoQrDhy7JnvA35QmEm7+QcKe8bgsts2kJbn56qcdYCK3nscAqNAUs9ZgSqeR?=
 =?us-ascii?Q?vOar/Em9sykof20zxr6S9c4c1KoiP6q4qlk/HVGeYoKZlhy1AR8eKCFnp755?=
 =?us-ascii?Q?35uZ7LtyxFbidwn+ncCYTuNGiI9rbQzW+vRepKL7XEFdtEs43/bI+O/e8BYQ?=
 =?us-ascii?Q?8OWWgO1olsZlM/X8Us4drtTMLakMBNREiqT2qIws0rhqZZZ0AiLAVPLbvF0B?=
 =?us-ascii?Q?eaY451ljHGIALEN6QzAgdkzERUjd7I2kr6f3IHyDQRmgbO27moOLLRBo8WZS?=
 =?us-ascii?Q?SzqXDUZbW2q03dNBH02Rc+rnRnwQ+xqEOeveV0905QwYJ1RZW2aWx3U5Jyy9?=
 =?us-ascii?Q?IMPL7xbkfnPX17rs5KnRj7XF4TBES6k/lxCmpojbp8nP9NWPCcSZZAte/Yfi?=
 =?us-ascii?Q?yPxsaQnv4tUKXm/tX+O0h+iUL1QADC/y5YfXmFbki3aNAGDTmCVw/tFTVKh1?=
 =?us-ascii?Q?spRjq8Hkn9Sw+N7y30ATcq22cVEp4QC9NlSyUn4kBQXPKEbt3XQSKbDVtTgQ?=
 =?us-ascii?Q?zccaSVobc92KNpsMtktuHp2/5TJL7p1mPBRTjYyhy6WJQfTd5IO10z8eX7dy?=
 =?us-ascii?Q?Lh3959KQ7Hmd7u0jU4qGp/c3Qdact48HFE+oPNgoDfflrn4WZvZi6HDwNpSl?=
 =?us-ascii?Q?4ubrQjPnUGhvDNnp7SK+1yF8ETxYo3THAFu7C3Ea/Xan6FdjIBLcnjWRpIdb?=
 =?us-ascii?Q?mmDcSNymCfI51q+fQpdWjjkPVtyxyv0KS5x37sopp4NFwNMJo532AhfLLapr?=
 =?us-ascii?Q?XVhyToY4vGQiPgb5iaXk8aAfliATwKaYRPWMkOwy7vHvrf5bFw66KoCATxDI?=
 =?us-ascii?Q?HPnpaEFO3OvBcpML9AzXBiqhb4yu7cvH2OWvqP5FqZZGz8AwspDp9OwJ1ayp?=
 =?us-ascii?Q?66pPsgAn/jCE7vj6pEkgSi9Cr8OF7Ceq6YGNEPC5XJf571xiN+/sTAzW1Jn4?=
 =?us-ascii?Q?sCISTuB4MzAfEbGHXEf70lc6bxdsF6TGSja0q5voYlJHhsw9dYy/b8fH01V6?=
 =?us-ascii?Q?Ikx6ZixLXBsBHuXENKn593JqJYMJiOL+T9kC/C29mlvDWPe/+25RLHMm1exo?=
 =?us-ascii?Q?PuXW86Grd2Rcl2hmWwsEn4/6zUGyif8UWHcSV08S4dyAZglgjRz+AJ6JvBwF?=
 =?us-ascii?Q?x4RV4KY6+v6ZBumbnYbp8603xIuHoQm8j0yq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ezvyVm5CreY3UuTmjUzJ0T52mBtjbpHi5E8/dtydqmwahtrkjiU/9OjFeIB7?=
 =?us-ascii?Q?mhoOXfKh3TVcJEAqGSP/Dm75uWE10YOz4qKhlT7ujcnps6o9r7xFzPa4ZX6Q?=
 =?us-ascii?Q?T0FzyOr5gpZrsZMwQHf6vptWi9AhMgWZA1TpfqNZZhTaWfnpT/TWpe3zGZq+?=
 =?us-ascii?Q?QtW/T1rYYLosd/rsjLSXoczxDa3HPf1I8tMF3hdliUMoR5z8J7iApuPnlbLk?=
 =?us-ascii?Q?HRGuTOLmAkVKMF+lxXsUB3MdnDYl7Bt0MvoHg3IMDMMxJPI3rfxJdkYvPFoD?=
 =?us-ascii?Q?9AliLSYZT51KyGhEEu4G9n90CKfl3i7Hfx8ld4tfphKdmswRpk2/mQyrwF0k?=
 =?us-ascii?Q?sXzSLqrUBq56D/hVc4+uGlQSjkPRVHCaUiIwkqJ8DsC0IrMgY7LlFsvpE0HC?=
 =?us-ascii?Q?mSRnvobMP+S+/CpV3Jdjt9HGV053700pZvrkNtBySbDHcq0A2aNMH5RLbhVx?=
 =?us-ascii?Q?GJpu5WNuVGl0Dy5y6At4lntegYXCbl/WdjdFR6I9qgvHFLvS809kq92el7Ni?=
 =?us-ascii?Q?aaEqkcxueCD3UBI0B7oV6g7tNinHjQeKwpyGD8ZYjKinDu+wA9yD74cEiLdg?=
 =?us-ascii?Q?aw5q7+jlYUhSiU8E62VTh5JINunsHafRXsT620FG0Z+YDZJBv1sznaACmn+T?=
 =?us-ascii?Q?AgvqWbd5Wqu2qbFBCSzPfnmjOUW+A0tj55RmORm+a+WCWW0eUZzEPC9lyXv1?=
 =?us-ascii?Q?Ajxs81ibAsWZmzwTvTp8EH0nRUxbN2cUNmBOZDVYQxLA1ASGxXxqCOLOCi6K?=
 =?us-ascii?Q?bRXAdNIt7IVvyXq2yeJjt9/IVsnrGc/441lut8Y2FOI2qfDXjKAkQxCxId09?=
 =?us-ascii?Q?MvynUDrOYNtw1YxmZjziaCLvX6ocdqzefwGZm/0tTuhB59yy00hXwZcV+QZl?=
 =?us-ascii?Q?TIk4BCdiHxHN2tPtKFmfPG2w82+txxf3WNxN2UVghHNP2niZn46UWRrfAlRk?=
 =?us-ascii?Q?LX13rWdWCItackiolFAk1xDpoxOwMm8EuCxBdJ/kBl7pLPqesbIYISh3plDU?=
 =?us-ascii?Q?/JXlW2VsFt2py6NOvQQ39qb1aDAE2ih90kYfSZdIoD/PWPVh5NirRzL3ay86?=
 =?us-ascii?Q?8xoXJGkcgeDMb/JtNtnx14g4z/2zs/B7jP5OQnPLg1+tUIseY6a1ttFGBFLh?=
 =?us-ascii?Q?Kd4J979eYNqnSP39m0Ji9bKm5mOG8F+3RAHcrP84sRslN8BvEdf1UOe6mIxp?=
 =?us-ascii?Q?JEqST0SaqK4Kr0fRdb9y2iUfq+D1YWIsrXAlDiWVOTlX08HFXcWtbV7aQ4yA?=
 =?us-ascii?Q?d2V2ZUuMU8CuRW4GguQDKLR8FrA1QiVM5trRGt6s2UHYKttrhucwINOiIsCb?=
 =?us-ascii?Q?Zdw2E4EH2MPceUBvG+Q96rUmhyyJpsJkNOG0GJAHdLAtvUiCQOtdHZ/+wCC0?=
 =?us-ascii?Q?JKRp3LWy3rEFOBTeSAnQ25FdDbj9eKd8QJNW75KCATqZMwIHoEZXmAWPamAh?=
 =?us-ascii?Q?fQ3++0WCDDL0qY6Loz+Sqryba3wXvai6X6AnvUNVct1Safo+MLL5tJs6PTCs?=
 =?us-ascii?Q?j9mJqB250n8RclRDOfVYh25mq0AEFizH+bp4h2BXlh2UTGHaKUVBljZurjuT?=
 =?us-ascii?Q?fR64pLwG0Y8SWp4K2a0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42cf7e2f-7da7-438f-2d68-08de277f5a9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 15:21:46.7508 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V2q9E/C/FyYlxodwomCKQuS6s4SeK+r3phd2hYvXYSfyQWCS1y2yFX+ezrOP7I3GKHzjUpwhji2YDHU8FUv8rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8379
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

> Subject: [PATCH] mx6ullevk: Stop disabling device tree relocation
>=20
> Remove setting of fdt_high to ~0, which disables device tree relocation,
> from the default environment. Doing so prevents U-Boot from
> correcting problems such as having an unaligned device tree and leads
> to various failure modes in the OS.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
