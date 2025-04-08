Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8069C369A2
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 14:21:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 928078340C;
	Tue,  8 Apr 2025 16:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="jK43wBbB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB63782FBC; Tue,  8 Apr 2025 10:14:52 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23AB082F5A
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 10:14:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5Kk2YCQzS6JHH9dQgW+IcwbCIO7aTMaWWpE+SeAH9GDxfxsW/M1cf8fxRGp1Y6uar9PSkKwztV2B9mZJL2ZcWv4KjBngfHv4ykH7HeVPh8EDUl9v4wcODQZGX9vxs4TiwJFvkJPRx/jJN7rRKarCvGWbd5nze7yBN4wPGSbW87x6NeyvSXbSHq8jtEdhakbeBIM9lnk9AUc5GFeAWN3KJFfnAfjgsVGq0pfHWPWMEMj+hL6igRo/OQ35GyWB5CgnAVJgEUQSspqZ2Gq35VA6nQZVdFEndKHF0zf+ceMe4WMSNDCsPAee4jvrboPvXre7E/INw+PiheFxIotYCGpBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ag0DgDz5IByjylclxCxrX4o3oz7zuJaNslXsAAxDOOE=;
 b=Hl8kuNImvNEwYPU8ic8QhDlGX1v6NL4TQbLmdMEAIjLSq/J/H86A71mIwbY2fEwxVMbobPc5hFsXqCvne84HJFpcOdbIDYeqb6g4zf1bNIPqFqPWUClO2UjdF25Q+2wfLOGeZOJDUS4YlX/kA6aKxFbVQARXrVGfUUvQ3jGdBRkSLXEzBjVIpp7eTcGFV8IEyTkufhYMm5fMPApOCFU7Z1QsbHsYOagrWUQ6L8AcviFkaS01v9GCNHYtVtPqoMpNXXmlPoxifGt6LLRgAIxILe0GKGVOkO/i9NDtiWnb+xdxQlG8KYCZROcWkPYgGf/pZTGcxw7Q5wyAsFABIYYhoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ag0DgDz5IByjylclxCxrX4o3oz7zuJaNslXsAAxDOOE=;
 b=jK43wBbBHfnvTiT2EbcCckZcrcw6DGWuNI46TylcUAXoebZgwnEh7BU953NedFxK0S0N1GgSos4pKpdk7qbt/v+kyuWvLg+V45W4GGSGY2aRy1UOm0kBjlJJovLg1tiCB+SjmFlX3mN8uyB2iXAMTqLDq+CP8t7jSWxd3jpWYsQpYYFTDdE25Ri+oEwxHLAic2R5OH/mkuy2/qzbPKJ86qupMv/CQNYpxnJNRweF380xl3wNBZDUm8AsYWeYgtDybkBQKcKb/9yA1EJzYBOf7ho1epXAtzVzNVs915UPUOzGdIBDnPiRmDzNANmaTpXvFdLSd4vJoSiPNK1jsNWPAg==
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by DS7PR03MB5592.namprd03.prod.outlook.com (2603:10b6:5:2c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 08:14:46 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8583.041; Tue, 8 Apr 2025
 08:14:46 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Ilias Apalodimas
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
Subject: RE: [resend v3 00/12] Add Synopsys MIPI I3C Driver support
Thread-Topic: [resend v3 00/12] Add Synopsys MIPI I3C Driver support
Thread-Index: AQHbnJhPL6oic8rJyUK393me9B/PZbOZcsMw
Date: Tue, 8 Apr 2025 08:14:46 +0000
Message-ID: <SA1PR03MB6370C3D360FC1E92B4766F3CF7B52@SA1PR03MB6370.namprd03.prod.outlook.com>
References: <20250324083704.26259-1-dinesh.maniyam@altera.com>
In-Reply-To: <20250324083704.26259-1-dinesh.maniyam@altera.com>
Accept-Language: en-MW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR03MB6370:EE_|DS7PR03MB5592:EE_
x-ms-office365-filtering-correlation-id: dfed8713-1fc5-4b7f-05ab-08dd76756c9b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?sd0vOCEjDomfRPbgogro+Bdv7xZM7bqEMyALJP04QUu0+6Fk0B7GJrUCRCjN?=
 =?us-ascii?Q?3CBRbUNlsEofVD2cwOL7myay1VgDIrDsdapBncmd0YKE4lnSM4bXtjd5Hktg?=
 =?us-ascii?Q?zlcODaL+szEGe1zXgdCwrLAJEu/7QP763g7JL+iKn7h5TqAUKSuIZgvRWVv3?=
 =?us-ascii?Q?mGbXNB+hhhpg1j3M9rlIHDz3NC8JKB8ud+ia5N4ghzri7+9m9Bns47pxh3WI?=
 =?us-ascii?Q?Xzq97otVXz4QinClfXZnYpFcdfTs2p7X50o45JYU9TMDblbDBsNfZzUJsZTr?=
 =?us-ascii?Q?iQXifilgoX0nxvTOCpu85eEH4zT8MuirY71WPKtyHVQ+1JvWGRUDnN4qFPIt?=
 =?us-ascii?Q?onA0D1McZnrDlOk0Htd56uguGdY1+OcDC527TJ1BoNUpWWX26htoaGyjItJp?=
 =?us-ascii?Q?Cxxsia9gZDEyGgrTMUGPkkM7dX/spIA1OxcjGM+ErQNpvzTQKCFGbVCVoOWJ?=
 =?us-ascii?Q?YNgVD04rQ6gZ7FAMKqVX1foIsh3astQj4MqpsoeGoqBW8yKnE1uNLJFGwZIl?=
 =?us-ascii?Q?oDoNSKygvM18MmBJ6V2yg2igWwydqdUTlC24Bm0BDT6TQdTgBqf/m6cbedHt?=
 =?us-ascii?Q?2I5dpWt16UMlDsmeWKbq+LpqrvZzTiuy2zpE+c3OdzgBzoiS0ALYalT5F9os?=
 =?us-ascii?Q?NWJOxsJQReixRTilNpoIhXVq4NG/fJRnzZwErszZaTfM056XSUH1W6QbMapQ?=
 =?us-ascii?Q?C5/rqIh0FrCmtzfbSViHPh6ju8d6ike4zrzN6QiydiWdvns5CUlumAcmLHCo?=
 =?us-ascii?Q?81mfQXYgb5W7NQkR5GujsEnX1s6KQ76e7WBKwXvSLQCXLciRCT59S7Dv6v5q?=
 =?us-ascii?Q?WHXvY5R5QfnvzTvOS358zwSScYRLna3uqPF8VbN/VvO56Yg3yeZdooMeKG/b?=
 =?us-ascii?Q?ab1hoWAO7rHA/9erATgozXNOi6FoGBRW5qtRNdGA1BiORPshKJ6DuoPaRMja?=
 =?us-ascii?Q?HCucKHmANVzw1Jlqitocas3x4MZ9BEBHfisW0nLveek5Pd0pGOiuC5EmRp6X?=
 =?us-ascii?Q?qtsLmSg5YxYu6lgQwvyqq+aBvrwfBdEf8/zgZb4jFBSgZElVTsXLUCdJa6Xt?=
 =?us-ascii?Q?lJ2pRRdvQatmo5dxcYFpxQWsCZPTgfksLd2l8xyciNEj6ECYdb2bpfd4emrW?=
 =?us-ascii?Q?6ul2wRLWvl4o7KGjfIz1FCkfzmK5W4uF2yQu8tSKqeLdpCAZhRyXt/Bpxbdj?=
 =?us-ascii?Q?uNqQ09oTjvMgg4xisJ5YkuUa4JtKzJzZJqyZ00Vax7rr9T1Tgm9tiIaiGAfZ?=
 =?us-ascii?Q?EC6Ll7N0JPCteFt/y6qJB45a7jOdSPRUx9ErSraSib0mCuEr/xzIZrbios9m?=
 =?us-ascii?Q?f1OpQhIzRlfog+SJ19RXbqJOwO42VJyKwx+TSEsyd0VZM4IWiSDxCILAiVdl?=
 =?us-ascii?Q?sDKAbt0xPYvdGSLCzYhJhCuvItZa8tovPLxVlSXxK0/E+dHsBG8SMCvEIZAG?=
 =?us-ascii?Q?zTKRBRnj48miPe0rju4QU/5e8+SuCtpB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uFSMQoIvhblRck3OzzrBnRkpwGMVm0gmO9xDNszPCiEhxqvz6etXvbUQzSw6?=
 =?us-ascii?Q?CY3YHMoPyk2GkhbUrGMERCYAPtswQVRZFKrW0NHWX+0Sk7IOAOI1x2tLuoPh?=
 =?us-ascii?Q?jxX3M0uSTsKd51vt1cqYAfhfPRuXzk24YPPuALL/TpjsScsClRvfcgwvqQfu?=
 =?us-ascii?Q?74H7B5yFsj7e+lLQ1hsrF7zjaHTqBylJmcsl1BYUpjS9+sWjTi4i59tv8Wog?=
 =?us-ascii?Q?VMk+2LNpdXySOHVZ6YGAHmfd8l1TLbTi3SKJNDyXbUGXcc/jFmXCYWRxhDol?=
 =?us-ascii?Q?y4hVGoQpJnAIC+Cxkb/ltqAKJG2egXum8Eey7WIGevSZaBIjM8fkNLVUkJ6T?=
 =?us-ascii?Q?hBnuDjlDQhn/Ly9vgPxB/HSZecXtNv7oOAnI/T/vEdpLf3gkelMd5CDipT2w?=
 =?us-ascii?Q?d8DRt6HwjgfoN4vG44Wp7es1DZl0oYZykED5sywM8Q8Leqo6GIMLmZDod9ia?=
 =?us-ascii?Q?Sep+sibAPRq8EXuZTZIwtYMFLKJBoiumnxq7CEFHycF83E5/fGO73cqIA3H4?=
 =?us-ascii?Q?CuKcciEC2Ki2SJQ2HTmiHVT1c0wMVeuudlZIRofqzX50279O7y6g80hTSxQx?=
 =?us-ascii?Q?I5bczqcM7foP4X1DLLq1OyWrVBcLcWJtecUyU20vwJ1yefc1XYSanAcW/MG7?=
 =?us-ascii?Q?EL2Kx7x8xOwwjlAibsvdZsZY3PAf4ZjgvzSCrAtOR+dwGfoiOrQ/Hxkm0yj0?=
 =?us-ascii?Q?neDlDiNPhJMe06SZ6hFJBBM33CYlOocidEhitfjcND23E8JuOwd9rT7V/MlF?=
 =?us-ascii?Q?yZve1RzGRTsyi3FerqNf0GTAecQMf2NmhKCdMdhWur3HzE3eqQvy9UVeXaWM?=
 =?us-ascii?Q?AbKL6uWvBwa33zVsQ2qtTERGOnAkxXpgVcIxy5GqioX2DrYq/qQMODW2oQtI?=
 =?us-ascii?Q?xip+eDwvRKoHl8TeyH5/eqHxe1HnaCg7JQ1wzBYGgMd1/8rm1AEVxg9fTYDK?=
 =?us-ascii?Q?e1bT+x8RcjCtlabwJB9OPYppRt0yEYaA5e3tvPgYq6b2UOFoJRqy5jT5nGGk?=
 =?us-ascii?Q?eBOzPzdzFAnzu0sJt/JxdQ1lMhhc752h4NktIf+tr0VxwxTYn4eY3eKumV2e?=
 =?us-ascii?Q?dXXYPMZbYcq1m8nfSvYf4MZygZwlX8MivmkNyk1jFGjjAztteJNEn4JmPtHT?=
 =?us-ascii?Q?QRIntzZWFg09bq2iOj47A1AUAkrYwXWgLV/SdhRmfsx5XDuyayGsKUeXLRhl?=
 =?us-ascii?Q?zEgUVKir3N/34SqNkUuMexyFJ4UKMr7uRej5j5BrKR81bmMM9rsaj2IfCLyI?=
 =?us-ascii?Q?LoFAWZUe3Kpx0ntKZR/QcmGEwghLjzMHdbS/A/or3SMFY6fH5Bz/xRlBnZhr?=
 =?us-ascii?Q?4GlJw6zzdy3O6k5YFMbXm+puAeHYrbaCtU5mydPp2Cbe0BHcDR+GLZQjoeLj?=
 =?us-ascii?Q?m6cdponQPmSISrG0pcrU7OiUQSE40NVTGLRga0z7Q3KjxMeK32TztqF9+zD+?=
 =?us-ascii?Q?0DzHkEpVCWgUhKJ3gDG+7rSY9xHwAwzAPvRYeWgFZ8oH8mek52vCifSTdqK+?=
 =?us-ascii?Q?WiTS7j8/eYgDTv/U1+BRIA4Ln/BnM01aFjlrSrvEebVXo6kz6sMxFVVD2T1U?=
 =?us-ascii?Q?vuv8UtD5gAJdAzXY+B32j24QxUTfPzb3RKQGTAL8BJqMobB6TcKWCANpwqTv?=
 =?us-ascii?Q?XOO5iTe2X7nzuIW8lHEG1td/eCcnvL7ZVKG/GtSwM+q4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfed8713-1fc5-4b7f-05ab-08dd76756c9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 08:14:46.1550 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OcZBK6AYRgq/5Rt7xz7fgbK1jir+YTglxX4xVCRffjQzdBdE+2vqlv+hBE2JxT+1PFx7qMSeY4gqJWmkbg0ODhKHYdL9dfMWWOmY3UeF+V8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5592
X-Mailman-Approved-At: Tue, 08 Apr 2025 16:21:49 +0200
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

Hi Tom Rini,

> -----Original Message-----
> From: Maniyam, Dinesh
> Sent: Monday, 24 March 2025 4:40 pm
> To: u-boot@lists.denx.de
> Cc: Marek <marex@denx.de>; Simon <simon.k.r.goldschmidt@gmail.com>;
> Simon Glass <sjg@chromium.org>; Tom Rini <trini@konsulko.com>; Dario
> Binacchi <dario.binacchi@amarulasolutions.com>; Ilias Apalodimas
> <ilias.apalodimas@linaro.org>; Heinrich Schuchardt <xypron.glpk@gmx.de>;
> Jerome Forissier <jerome.forissier@linaro.org>; Mattijs Korpershoek
> <mkorpershoek@baylibre.com>; Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>;
> Michal Simek <michal.simek@amd.com>; Dmitry Rokosov
> <ddrokosov@salutedevices.com>; Jonas Karlman <jonas@kwiboo.se>; Sebastian
> Reichel <sebastian.reichel@collabora.com>; Meng, Tingting
> <tingting.meng@altera.com>; Chee, Tien Fong <tien.fong.chee@altera.com>;
> Hea, Kok Kiang <kok.kiang.hea@altera.com>; Maniyam, Dinesh
> <dinesh.maniyam@altera.com>; Ng, Boon Khai <boon.khai.ng@altera.com>;
> Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>; Zamri, Muhammad
> Hazim Izzat <muhammad.hazim.izzat.zamri@altera.com>; Lim, Jit Loon
> <jit.loon.lim@altera.com>; Tang, Sieu Mun <sieu.mun.tang@altera.com>
> Subject: [resend v3 00/12] Add Synopsys MIPI I3C Driver support
>=20
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>=20
> This patchset add Synopsys MIPI I3C Driver support for Intel Agilex5 devi=
ces.
>=20
> The i3c driver is leveraged from the master/dw-i3c-master.c, i3c/device.c=
 and
> i3c/master.c Linux version 6.6.37 LTS And few header files included to be=
 part of
> the migration; i3c/internals.h, include/linux/i3c/ccc.h, include/linux/i3=
c/device.h
> and include/linux/i3c/master.h.
> Additional i3c uclass driver and command files added to support i3c read =
and
> write in U-Boot.
>=20
> Patch status:
>=20
> Detail changelog can find in commit message.
>=20
> v3->v2:
> --------
> - Squash commit 10 to commit 9
> - Resolve index for new files to pass the checkpatch
>=20
> Commit: sandbox_defconfig: Enable configs for sandbox i3c
> Commit: agilex5_defconfig: Enable i3c configs for agilex5
> - use savedefconfig
>=20
> drivers: Enabled Kconfig and Makefile for i3c support
> - Add maintainer for i3c
>=20
> drivers: i3c: Enabled Kconfig and Makefile for DWI3C
> - Add empty lines for if/endif
>=20
> drivers: i3c: Add i3c sandbox simple test.
> - Removed DECLARE_GLOBAL_DATA_PTR
>=20
> v1->v2:
> --------
> Reorder commits.
>=20
> Added commits:
> - drivers: i3c: Add i3c sandbox simple test.
> - test: cmd: Add simple test for i3c
> - configs: sandbox_defconfig: Enable configs for sandbox i3c
> - configs: agilex5_defconfig: Enable i3c configs for agilex5
>=20
> History:
> --------
> [v1]:
> https://patchwork.ozlabs.org/project/uboot/cover/20250218025705.50051-1-
> dinesh.maniyam@intel.com/
> [v2]:
> https://patchwork.ozlabs.org/project/uboot/cover/20250314040902.43621-1-
> dinesh.maniyam@altera.com/
>=20
> Dinesh Maniyam (12):
>   drivers: i3c: Add new i3c uclass id
>   drivers: i3c: Add driver for MIPI DWI3C
>   drivers: i3c: Add i3c uclass driver.
>   drivers: Enabled Kconfig and Makefile for i3c support
>   drivers: i3c: Enabled Kconfig and Makefile for DWI3C
>   drivers: i3c: Add i3c sandbox simple test.
>   drivers: i3c: master: Enable probe i3c without slave device
>   i3c: master: dw-i3c-master: Fix OD_TIMING for spike filter
>   cmd: Add i3c command support.
>   test: cmd: Add simple test for i3c
>   configs: sandbox_defconfig: Enable configs for sandbox i3c
>   configs: agilex5_defconfig: Enable i3c configs for agilex5
>=20
>  MAINTAINERS                        |    7 +
>  arch/sandbox/dts/test.dts          |    8 +
>  cmd/Kconfig                        |    6 +
>  cmd/Makefile                       |    1 +
>  cmd/i3c.c                          |  193 +++
>  configs/sandbox_defconfig          |    4 +
>  configs/socfpga_agilex5_defconfig  |    3 +
>  doc/usage/cmd/i3c.rst              |   98 ++
>  drivers/Kconfig                    |    2 +
>  drivers/Makefile                   |    1 +
>  drivers/i3c/Kconfig                |   27 +
>  drivers/i3c/Makefile               |    5 +
>  drivers/i3c/device.c               |  262 ++++
>  drivers/i3c/i3c-uclass.c           |   38 +
>  drivers/i3c/internals.h            |   26 +
>  drivers/i3c/master.c               | 2072 ++++++++++++++++++++++++++++
>  drivers/i3c/master/Kconfig         |   11 +
>  drivers/i3c/master/Makefile        |    3 +
>  drivers/i3c/master/dw-i3c-master.c | 1058 ++++++++++++++
>  drivers/i3c/sandbox_i3c.c          |   56 +
>  include/dm/device.h                |    2 +
>  include/dm/uclass-id.h             |    1 +
>  include/dw-i3c.h                   |  252 ++++
>  include/i3c.h                      |   67 +
>  include/linux/i3c/ccc.h            |  385 ++++++
>  include/linux/i3c/device.h         |  286 ++++
>  include/linux/i3c/master.h         |  698 ++++++++++
>  test/cmd/Makefile                  |    1 +
>  test/cmd/i3c.c                     |   52 +
>  test/dm/Makefile                   |    1 +
>  test/dm/i3c.c                      |   34 +
>  31 files changed, 5660 insertions(+)
>  create mode 100644 cmd/i3c.c
>  create mode 100644 doc/usage/cmd/i3c.rst  create mode 100644
> drivers/i3c/Kconfig  create mode 100644 drivers/i3c/Makefile  create mode
> 100644 drivers/i3c/device.c  create mode 100644 drivers/i3c/i3c-uclass.c =
 create
> mode 100644 drivers/i3c/internals.h  create mode 100644 drivers/i3c/maste=
r.c
> create mode 100644 drivers/i3c/master/Kconfig  create mode 100644
> drivers/i3c/master/Makefile  create mode 100644 drivers/i3c/master/dw-i3c=
-
> master.c
>  create mode 100644 drivers/i3c/sandbox_i3c.c  create mode 100644
> include/dw-i3c.h  create mode 100644 include/i3c.h  create mode 100644
> include/linux/i3c/ccc.h  create mode 100644 include/linux/i3c/device.h  c=
reate
> mode 100644 include/linux/i3c/master.h  create mode 100644 test/cmd/i3c.c
> create mode 100644 test/dm/i3c.c
>=20
> --
> 2.26.2

Please help to review the v3 of the patches.
Thanks for your time.

Dinesh

