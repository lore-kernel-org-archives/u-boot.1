Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483FCCA1016
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 07:17:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84B8B8323A;
	Thu, 11 Sep 2025 09:17:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="CTBfBqpL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1F33832AD; Thu, 11 Sep 2025 09:17:39 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7591C83236
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 09:17:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GF1g10ORwpwhhWTfnBv2FiNfEOGf5NJILq90ZO+P/1HT/+QisARalmNE+7Tv5BFyxWx5YNlQRN6sfs45y1yZ7e39RLl+qfqMcL6GFNsU2v9DeCzK5BaZ6EwQYEVuQVYa1Nh2iORTX2lbJ/dYuMO6PyL25m2HHfGU3zWuIDsUQi6mxAmumwESfTd70UMrHlHkDMJFF8uj3AjD+aBIYqNfIPnAbNVKyXutXVoegGXxuiXpxvYx222nGvf3H6obGLMflJcRJSdsMbIEpq3HwQiPUU6Zvf57yqUYeLkCEsd1V2kyuRGp42Ds7LPFU/3yi81MYIkoesX0TANaEIgms4mMnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATcdH3YOHakkxpC+LgtwBTj+Hz16N9KASlith282NDQ=;
 b=NQO1adl4WOk9QPih2rqlgMeXQ1+/evGJwVq8tomURkluQRgeBRZItb+ieKzLgTyKpo3ol8Khbr1kcoYgbl9TOgo0S7wgxTqYqx6vBJXe+k4Q9W1VdvsyQJUpJxHg24zD1jjYcAJ8CUyS4/DaQ04eViO5AQJwYx2vGYGsw0gSeekKjInsnZ+x/bdW+JK3hGcfq8gXs45N3WejYwmtIIlvrfLYOEzKOdCCnD6n40QNr54XAQN/J3jC7Tbl2B7WV+uGXkmzv2Os2szw3yB4q8so4q7mfK8JRXhXzBPLUi4p4y7NTAweI1lzhX3Z8NsJZR5kmDer9NJsv3fib9itjxW/Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATcdH3YOHakkxpC+LgtwBTj+Hz16N9KASlith282NDQ=;
 b=CTBfBqpLfLTWUGuuoAgenYYvMgqoHyPOZa8Zv2q0PEzlZtcjvdH7i5z+Kf9gyqM1QiTHI4kWSqVSktkY/TgiTth7OSas7tdMrY5O2rPZdyW+4ZCc/ZqDNYLncGNT14qxndQI1dgYH59KO6twzTGuNj8BCppyPMtXLldgh7gHx63uwrBmE+27jG9dRqcZAqai9UvGf1RBglws48DcGl59Mxn7mo6POqcZRdAkny396/qs7ZLErobE2t57Foaza28mAHDsdhigftePeYA85LHz9yF63KmImQ8PoSAUqbWoaCUowE9clfScR0sSTkIJTDXu6TQK4DSR61OIxJS+AVG2nQ==
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by BY5PR03MB5031.namprd03.prod.outlook.com (2603:10b6:a03:1f0::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.16; Thu, 11 Sep
 2025 07:17:32 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%6]) with mapi id 15.20.9115.015; Thu, 11 Sep 2025
 07:17:32 +0000
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
To: Peng Fan <peng.fan@nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, "Chee,
 Tien Fong" <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>, Marek
 Vasut <marek.vasut+renesas@mailbox.org>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>
Subject: RE: [PATCH v2 1/3] include: dt-bindings: clk: agilex: Add Agilex
 clock definitions header file
Thread-Topic: [PATCH v2 1/3] include: dt-bindings: clk: agilex: Add Agilex
 clock definitions header file
Thread-Index: AQHcIS9EXK9rj2JvcESc/M/9iiybRrSNhoyAgAAL+bA=
Date: Thu, 11 Sep 2025 07:17:32 +0000
Message-ID: <PH7PR03MB7063972B766EC67BA14BA639AD09A@PH7PR03MB7063.namprd03.prod.outlook.com>
References: <20250909021116.12599-1-alif.zakuan.yuslaimi@altera.com>
 <20250909021116.12599-2-alif.zakuan.yuslaimi@altera.com>
 <PAXPR04MB84591699BEC41960D222BB6D8809A@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB84591699BEC41960D222BB6D8809A@PAXPR04MB8459.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB7063:EE_|BY5PR03MB5031:EE_
x-ms-office365-filtering-correlation-id: 07270b53-3608-41c6-8659-08ddf1034647
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?yi9mVm09R3W/9eKiuIrCt9AD/63Fbue7x04lQz8rfGZ4il8+lWi2fwZqs3z+?=
 =?us-ascii?Q?Pmav7pYzR9XnN0Si+93alfOsQESLptjEalEW/xFCISZS4sGDJF/RpM90TpnY?=
 =?us-ascii?Q?ICUVUDrBJykSUpwxTRbdR9LOLkR3CSEHw+nXYeqnzhG40WwFg/AxHpTmQTMg?=
 =?us-ascii?Q?aeD3mVr1mqDjm34FsX30+O0t36cbRIGNrMQGmB4j6i8xEIc3BK16LTSw4u4C?=
 =?us-ascii?Q?9RTOmf7ypqSmz6uM52AuBGxCIJJmPUVHaGrS3Afp8lF7JJNF0w/PRPO3ZH+g?=
 =?us-ascii?Q?epWTR0cj+gdqW/nHBYz2TlaAIfTGGbpNv3p16mtO5Fg8uprlJA/0EcyFQQHG?=
 =?us-ascii?Q?hMQFS4BCUiKVnwMQq8i1xSHYRqXqh849XhGCzDc6dWVQqB4TO4RdmYK5Lfr8?=
 =?us-ascii?Q?FBFc5epL3sot0f8uyCRDJKfH1IPtlgcyhz9Y9eyhbCP2pk3ToNrCnnOCbS0h?=
 =?us-ascii?Q?vCnFYlbbuoAYpneoME+XozrZvclB9JNU2bBwef1qXmK8kVJAKighTgK1R8W0?=
 =?us-ascii?Q?CI2bJp8L6HKe+pYAPDHeYwoFCSR0m9mIkc+uwUNnVeChL0xoL/mCQS4ILvU/?=
 =?us-ascii?Q?553pwq++1FA87UZYFDbyaVUH1ZNo6JUxhAoSgvS2YJ+S+dNsk80vPlJaNhku?=
 =?us-ascii?Q?E7f2hkgOzJXnMM00qat6/s5U4SgBy7kpvYj7dZAht5m3VEwWOi4HJxdZjPld?=
 =?us-ascii?Q?Ss0w6lxhN3mTqkrnVk4Fl/D/N2gXYJPCgoPrtZDXH4icjzhaMABbXNRCN4Kw?=
 =?us-ascii?Q?OD1QiUapziphJ8MV+bhgkR5hCQ7iyqD/ZeH2yABAkwx3XaIL46pYBAPpszeU?=
 =?us-ascii?Q?IvfnNJUwcskn2IhF7Lodbp1HFi0pDT01nOUTN60kUsupR9SWuyV1TTvWMXJL?=
 =?us-ascii?Q?5Qx0Xkq1w5x0v+WiED6pn9D7pmSWUGQoinEDwnYBZ4lqfj6RPA+Nr3XM/nmU?=
 =?us-ascii?Q?B+H4mOLYxGfZXnka2YUnVuDe9wDx8yeGuqbz3JRx2xkTyq+knKdV8KY4AZCg?=
 =?us-ascii?Q?Tb8JR+tKOibEStPqIU10s3udqH/Od17CXysMP3lv3aCf+46yqvDIWvgaWFUN?=
 =?us-ascii?Q?yihtFolLQi/xW3KY4fM4iTpi58xvPI6s0nGtJ5rYrU/fsAvwiELzy2mYlQSH?=
 =?us-ascii?Q?V/YyL/Qh0vcvLyFz3R7kURywiXvTvJFSkDbiKiwKXuYE2D/h6WwmwfLYEeMe?=
 =?us-ascii?Q?yKGvDxrMUAbPMsr2xyUTLTKllHan3aFSqQE6c7leaHMv2CrkJq6UVhEDaIqN?=
 =?us-ascii?Q?j6Ue8JEphIugR3GjY5VdT7k3898S8MFx7cfwatUlViShznSpuiH+joHy52i3?=
 =?us-ascii?Q?6XLe2Z/QIfEowUsnDLaZX/ClUZgyrZtg5caRIizIeSOqYP5jh1fq4GMHyIVC?=
 =?us-ascii?Q?FzmpmTggvkgoBnlPMCTAwIs6Jr9Ow1XPZOlj3MPcTVdg4naiLS1FnBLp0mnx?=
 =?us-ascii?Q?HZVb1m8s5oRcCYNp+d6tSlfs1S7U+AzlCY+s05sFeCnR4cLQmHj3LA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pLQ/Dr/z0TU74ocr6SRF0sO8iYSXr9oO+qcHyLn3AXU1EMx3ymkwsPucQ+oF?=
 =?us-ascii?Q?DjKW6zWfXU7PI4YkDn6DPcTJxzm+CIOeVgIQaKeSGbdIWRk3mdBoFXkcT/Kt?=
 =?us-ascii?Q?UHw4MNx8Mdrh6aK9clVpsRorlFuDnHKlh7dtJlfN849O0BUxL5U25t2Chc+Z?=
 =?us-ascii?Q?A3f2C+a6c4rixReIglqr2+4rstb7oTgMgFVnw2zq0OXoUnmxM28wK6TMl8fC?=
 =?us-ascii?Q?BZcAo68nXYaWEuJRDePfISH78XKBJiOi/oaDWhCz2vYINl3np9TxAVs2kyY7?=
 =?us-ascii?Q?tFY5xD74YB3dRvB/VpV8y344UPkH9tdOLjVYsFl8S6Yy14xi/NYM1tD16ErK?=
 =?us-ascii?Q?Ru77QjHbg1Ft3Wrsi7FUBxObHnmVpgqN966qzY2xTeL9XFLkjRe41kyKcq7t?=
 =?us-ascii?Q?zLUtYgEMXUdKFxPAbYQavjIIOBAQYP/iM8pe5lqMjCGkdHSjbLIJEopMatSF?=
 =?us-ascii?Q?t0gM2Hrlrd/EBg8LU1ihX/jP/dBJpX4VMjFrrA6eF5hFhXneD+OzPqr9trY6?=
 =?us-ascii?Q?X/95ZubOFkctTdOBd6kndVhMYTQSC2gKL/db8FP8p4M26/MYX9mRgtoSdixr?=
 =?us-ascii?Q?cODNPPIdNLS1GWQ+NRCX2DdnJ6U1Hd2J3sm5KFHcRBSHMHZO8z9355/cAuHG?=
 =?us-ascii?Q?RtrBR4Jik9egKcRoBYlH8yQ6MFNzMIfwLjxsLXH9gSKW1OwS+uCBItcKXGM1?=
 =?us-ascii?Q?Q8BoTlqntuDayWTM6F33cggP5g9Tyll5PRwSjpFtBwUFvtKf626wut4eVHn+?=
 =?us-ascii?Q?H1NzcAfQ8vFNwC68L6UEwsUhb/N4mg5rJcyN/5KA/Knt4cukOMMCigsm5oez?=
 =?us-ascii?Q?iVgIXFvqFKdq0R+Phke+YmD2US87AV6SZt0D+Xjc/NOxaIlfn3pq4upy78im?=
 =?us-ascii?Q?nI2p8FJstaHpiGgANhfYl1GpFRWMPx6W0xOMCKGS7ZrmBZ/p1PQAALIRRGdi?=
 =?us-ascii?Q?nbaC22hqGXNdl7UvgomkKC4DCV0aqSy3uTIefaNtXxnASYPAFb2t5BK6a3TN?=
 =?us-ascii?Q?OdZWtgT035s3JgFOf/XcLCfZMsT7ktuadci+TJUQRcsarTijmlmJPaYtD1HP?=
 =?us-ascii?Q?QbhAek2c1FqCiwakxxlI1O5Hd9L3C+214gpxNemTFNrYCFBTki5b7otcuZIm?=
 =?us-ascii?Q?JmkXkW9kIUTg079IO3aBsU4lOnRp4MlZ6ElyRGw7RPzZWeLUVXfVarrP1PWk?=
 =?us-ascii?Q?VcgXalL0D2DROxuyrakDDikpvGvavQEoLL2oiwhUU3gT7MzexYMmjveP2yTx?=
 =?us-ascii?Q?CMqNxrpsDAhw2I6BvmNftKI5kdL7430L9ysYOiMVYIexmOAbnbYta/eSUMCt?=
 =?us-ascii?Q?9739ItdNe9CjrFvtyw7Aol2k0cWfGfpihy5RCijNLjPYj4gWyiK9UctszUa3?=
 =?us-ascii?Q?lk1+VZty1r1p6fZwIMscfA9CNQstLZUWFwME2tuEvjL0ZGOiIgBN7js1dxNL?=
 =?us-ascii?Q?Xqhh73eAiY9pObyF1KMJwAclibCi//J2vc6RJ1P//ke3ZqSuESzlzQ3TGNdd?=
 =?us-ascii?Q?IeZpMaE5FvWAsuEou/F5yYPM+4FXaDd3R2EbPWbuoWjxr1O+bsFmbvn3cfmx?=
 =?us-ascii?Q?rQP5ZWMrHR/l6IA58C+hIIfPKvmBYyDk3o+sxGLCVtybU1UhVJBxmIE6I6Z3?=
 =?us-ascii?Q?hw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07270b53-3608-41c6-8659-08ddf1034647
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 07:17:32.2319 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dXRku/MlHrXc8mVPiO3g9e+7jmyR6WTv54ZZKEWb/RGbXbYR8rM7xUSt9qObHDOp27ZRzyl8/TTqjHhehIst57ncMoZHQvzX7hekx04oQew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5031
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
> From: Peng Fan <peng.fan@nxp.com>
> Sent: Thursday, September 11, 2025 2:23 PM
> To: Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>; u-
> boot@lists.denx.de
> Cc: Tom Rini <trini@konsulko.com>; Lukasz Majewski <lukma@denx.de>; Sean
> Anderson <seanga2@gmail.com>; Jaehoon Chung
> <jh80.chung@samsung.com>; Chee, Tien Fong <tien.fong.chee@altera.com>;
> Simon Glass <sjg@chromium.org>; Marek Vasut
> <marek.vasut+renesas@mailbox.org>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>
> Subject: RE: [PATCH v2 1/3] include: dt-bindings: clk: agilex: Add Agilex=
 clock
> definitions header file
>=20
> [CAUTION: This email is from outside your organization. Unless you trust =
the
> sender, do not click on links or open attachments as it may be a fraudule=
nt email
> attempting to steal your information and/or compromise your computer.]
>=20
> > Subject: [PATCH v2 1/3] include: dt-bindings: clk: agilex: Add Agilex
> > clock definitions header file
> > From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> >
> > Introduce header file to define the clock indexes for the Agilex platfo=
rm.
> >
> > Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> > ---
> >  include/dt-bindings/clock/agilex-clock.h | 71
>=20
> This not landed into linux kernel?
>=20

The existing Agilex clock header file in Linux mainline is outdated and
missing several clock ID definitions required by the current U-Boot clock d=
river.
=20
To avoid dependency on Linux upstream progress, this patch introduces
a self-contained copy of the updated Agilex clock header file within U-Boot=
.

This ensures U-Boot on Agilex can be built and function correctly with the =
latest
values for the clock driver.

We can clean this up later once the latest version of the clock header file=
 has been
upstreamed into Linux mainline and synced over to U-Boot.

Thanks,
Alif

> Regards
> Peng
