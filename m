Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E2CCAC59A
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 15:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D242683327;
	Thu, 18 Sep 2025 17:55:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="mdoGycoe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 972948309A; Thu, 18 Sep 2025 16:41:22 +0200 (CEST)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c407::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCBE980B9B
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 16:41:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=biju.das.jz@bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lxh4nHbx6GwqqiUMd5HA1xUyPyNWJj5twIexgfxsbmhEEMsyf0PABJSckVslqZoabd2yq0FKs80nEpqAi3aiS9OXVexGjaPqYGNcs21GkYBSF2XywxR5waNBR2qd1Y8JRxQYuwnroQ6M0WzOzUf5Q0mFMDPEnTvmWDy1co1ua4gQ9zGlQX4ChveVJ7Kvovq+6OPgHH6K7khU2aCrNlXPeFndW44TEeKfUPltIRtZ5tBdoset66pKeJS4P865H4CsSAY/pdV6DRAIlGxxe/aJp/QuUJZUSxqO+b5172EzffWWY0Jbpz7WWzsDpX8EAZOSQczmOcMapLI8uVZOv2TiGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCcGVzGH8dQDd4Ps7UquuZ5YiESXAda0WKGmmLBZ8cw=;
 b=Me9bakiPdj6LIp3Muy56eZiTFwwOD0dn50z57MVjg9HPzSmtvXQvGdaWhKYNQ3/2tPpX13XOK9DAOEpnQWVKf+VLbZVyAiu+sikkVaOpZVFSvXeRhTHTwv+ZJBFyR+aGUf8laYjAjD52iDkWskNwxi9jhdapwcx0bknCo0XB5vUNts7EdKF5qLoAWd634ikmSeoKgALmPYmhipNi0pCAzzLakpJgt78+Luqp/zr8x15T8YATOOJJIGWYQbjdVE4UTR7zvtlS1IwLYjErvgO82xjECGdwgYEzuxBRFBSu08eiHO4C18vAoqo4rFJDAZ5GpqplruK9L/HNtu8Rj7U+iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCcGVzGH8dQDd4Ps7UquuZ5YiESXAda0WKGmmLBZ8cw=;
 b=mdoGycoeIaUlOcst3uFKvLo7NcMTy5xXAdZ+aJZ1yl6ySf1R27T1XN4w5YO0mNjnpKdxk8zD8XMKRJp30szOjlx2r2M3H7R5N9HS24dRgEJen6jALMUiniwLPxGPJEjvdsHjrJ73kRejetLhcFwfZZrmp7+CrLmIHgOgmeaXA5c=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB13740.jpnprd01.prod.outlook.com (2603:1096:405:18e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Thu, 18 Sep
 2025 14:41:12 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 14:41:12 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Mathieu Othacehe <othacehe@gnu.org>
CC: "marek.vasut@mailbox.org" <marek.vasut@mailbox.org>, "paul@pbarker.dev"
 <paul@pbarker.dev>, Chris Paterson <Chris.Paterson2@renesas.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "anton.reding@landisgyr.com"
 <anton.reding@landisgyr.com>
Subject: RE: RZG2L and DTB blob from TF-A
Thread-Topic: RZG2L and DTB blob from TF-A
Thread-Index: AQHcJw31BG8AYAUJK0KvkgHo6W3hvrSV1KeggAMULCqAAAGYAIAAGgEDgAAAP7A=
Date: Thu, 18 Sep 2025 14:41:12 +0000
Message-ID: <TY3PR01MB1134675D06BCF644BC578862D8616A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <87plbqd0kk.fsf@gnu.org>
 <56857fb6-e3d4-4069-afde-57b43c4d2442@mailbox.org>
 <TY3PR01MB11346F452EAE530A0931C9D228614A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <87plbnhqe5.fsf@gnu.org>
 <TY3PR01MB11346A6D8FCB6909AFD4EC5D18616A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <87h5wzhltj.fsf@gnu.org>
In-Reply-To: <87h5wzhltj.fsf@gnu.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB13740:EE_
x-ms-office365-filtering-correlation-id: 0a3673c9-9ce0-45db-1ff7-08ddf6c169d5
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?1adTfThy5amknOdTY3M6TAlhio4CmYhZ6YtsxOj+gKl6WLK1n93lh+36AbGq?=
 =?us-ascii?Q?3L1Mjr3aNS0uUbv6lCzc6VHMWYL4HvyjKFqtHQvcJ0pS7kQGWLfeoB2lTZmY?=
 =?us-ascii?Q?GCxYNjy4QLSUnUTpeZ24li9PewRfg3K3E+Jxhiw4rjD7ZZMAQfDXsDeaJ/cI?=
 =?us-ascii?Q?K56XrVEEg64W91xJIf+gziHme+Znv8uWzqMmQcao45On3MOriTOtZIk1qt6Q?=
 =?us-ascii?Q?Kea9YXuJAkmvKN57wnldIRvhzFgCX5XSGIYoahhhe9bgFE0t3/VJKQQ38zAj?=
 =?us-ascii?Q?X+wovfBhiuTq5JeCZCdp2ocafpqujNJMg5PkX18yCNZYLlbNwwJytDBBMEeS?=
 =?us-ascii?Q?f6E/5Gc/mzombclgnLiqj2b8wKHJEPQrNUa+nsSN2IMqLd/BRSkslOwPCYxf?=
 =?us-ascii?Q?vD8+hLF4uJnzJ+1mPQSjVhQqazudfWnY59RXbACLoly3T01uxPFsti0BFTAP?=
 =?us-ascii?Q?7uxWoHjBGuy42cUI33XdqoKo9r4kYilZOoY2Ntibe3tchzLTh5BhGMdtAkJp?=
 =?us-ascii?Q?Ekfd34CAhdPM8QqsgMyyQe5VaTqBQO/EJE3wr0VSXD6Q4fE1tiD5NYTRI91p?=
 =?us-ascii?Q?eLAZSR2ahPlJ54JJJ2dfGvqKn48KyTSzabOqtkRRFNux+ES7MKhPv++w8uQU?=
 =?us-ascii?Q?FL09CYc+Kl9MoCegIcTKxRy1F0TSn6mYIxbpwr6m1CXkTRA8zvpfxb+i4UZF?=
 =?us-ascii?Q?B7ALH9EVUhXHb48WWoz3LH0VKquNgmMicrDfpWY4gj/a8A/Mu6wzR3/TDg7C?=
 =?us-ascii?Q?6h1/mmwqq0ZcxVeYg/R1R/8/CzFeIF1AhRsWGReJNLlimhzKZ9KW7eE6WaCQ?=
 =?us-ascii?Q?thK/LqVz5mmfN7YTmB0A6hb6Bq0GSPQGusZhT/rQNaxOUV8yLOCapQe3uAWf?=
 =?us-ascii?Q?kFCsGYvvT20EJBAfBgisuxJzHfm1Kxvuf0G9EOJcEm9ZSuFUU8xJCpz/CLqh?=
 =?us-ascii?Q?B8grMH//4nowt3BaisoUrKyLolrC+0FUbbG/Q7Rfz6Kc4nTlWVkP6k6XNfII?=
 =?us-ascii?Q?E7Rrmm/HtpovJkx+NqeyIueVviLk8n/k6KpVdtbahwa3GW0chDB5Rw2JJhQN?=
 =?us-ascii?Q?aTLfPShiniEA1I4ASum0Jlgo5ODDCLeqsFQQJXmJEzVcnvZSApMIEXXcNloc?=
 =?us-ascii?Q?r/Ue0HkvQVsThdi/UW6OIds+1z/hAl2r1pjV0dp8iKW80e0bnWCrLq1O8WRY?=
 =?us-ascii?Q?r2RAp6Q5l3ZLE7SQ6IIkagKRRXf3AxoJ1FUjXGNjhfmMBZn5Ccz/8cURcgY+?=
 =?us-ascii?Q?rlie0nRbpPC70ksnZTtEyT9ReuActwjgRxgMh6I1d3GrGRzhQqzByi5t4LNx?=
 =?us-ascii?Q?VsB4MT1dzPTwZLpACkzbuXUavp8areFLa8Isl1pW3B3iZrF3Pnw822xlY1XA?=
 =?us-ascii?Q?hTnJiFSn/em1gSZpWZ2hVksXQFuPKeXGqXvbRrE4H+bN5ZekvhTz52BY0QUO?=
 =?us-ascii?Q?7z/ySYM2Aej642liKVYB+y+UWNJXFbwoXDjfFby9hpORxiW602aelClDJSu2?=
 =?us-ascii?Q?elw+y8DYPDLQU04=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TAfEgpAJtPDc5XPiGbR1c0DKdSPs41/IXOh8D1Fti2ogyzsI1nKCDDB5l0Ha?=
 =?us-ascii?Q?7T5P4n20NfXcvjYEFk3qPY+iim9+RUqx/oKfoVhUONHIX/hEQiZ1IfqFYKmE?=
 =?us-ascii?Q?R7CNGB6ZASvm4ZAMVRRiXOhjKQLrHaq1VNKStWPkOr7fmRNcATSZWW1S8xOD?=
 =?us-ascii?Q?M6TtiZRVLsNCjMdTt50YG0gCHOrggqBd7XSSmOBEmcVmZxrG2SM3z2+i0MB2?=
 =?us-ascii?Q?b657hmPIUx+a4ek0UY8Ym9u+jBETAqTIiQTjSC+74wZUmFBJoe1YcBmMOW2T?=
 =?us-ascii?Q?JnGPJJDyxibpjmpMIG+8H1GCQmi5Csib9txiHpR27KPWiEK9aYkUYMN5eyrJ?=
 =?us-ascii?Q?t7XapUuuL1KtU9Vi7BsRsijMp4wc5AjyUy9RM1UWwJrMYssCPDis4pNx3Slt?=
 =?us-ascii?Q?5veKui0s0opTI5fP4KwtlhFmwJ5HhZy+lrkmFwoXPKnbjkMnkCkprFenZjVq?=
 =?us-ascii?Q?U6NLJc9sEQoFMbi+s9BNY1jAAbMtQoo+8IQGcG7mCgNPQSs7jNfS5UOYJGKi?=
 =?us-ascii?Q?UBlkd3/NXYNsUvzW6JrMN0lepkPssxIAjjV/nbxkb+Blue3BwfeR8AU1WHjf?=
 =?us-ascii?Q?8eizQpZE3HiceYkBUE0f18bz7W3vSvSHFwD4iOX3wVar6vQb+zdnnZjOO76z?=
 =?us-ascii?Q?n1STUY3qTcGPVYM2wJhJ113gxJFfdh9v2yYGvl9Nd9vR/Q0DEpDpN2ple+pu?=
 =?us-ascii?Q?B6XJBNrNbOm8tIgtuXTCwstBZCRgUhEtLEelV1Oui8XzNPY03gPWSaL3m+tR?=
 =?us-ascii?Q?jZjQDE0pYrfWuDOkxD03BPgywP6EOwLW9IUOk8wn6miarvqpfxjMP7K7wXbC?=
 =?us-ascii?Q?9WuFDfUuOl//ad1VvQ6UCETx45rJc1ShEXCZGVQg52kdVhtYdd3/zcBs2gfG?=
 =?us-ascii?Q?8uZVdj5egLNOTnHj0N9H6dL/WSiJx/oeBHeZxaJlPto2EoNS3KxVdC3Bil95?=
 =?us-ascii?Q?1asQvwn+cqEmxlNsmBXDCBup/P0LXAgsVLVmE+raP5VLacnOiS0uaSrl0QR8?=
 =?us-ascii?Q?QzgSoMF0ZB6S2VvSplkyrj+RuwEd02Y5LP/LmArCWi09i7zG232YFPPZE02g?=
 =?us-ascii?Q?FmTXPNwJgUM8s7Bxf7toMVz9ksmNjRg5/jtKR6GYbN+v5g4HhqIK97gdO1BW?=
 =?us-ascii?Q?3u5nc4JTS0YaW+umyOTnumbfIzkwcvQ0T2R2lRMdBXw20+N2hvBU9J/Dg3hn?=
 =?us-ascii?Q?R+cuEzzgVqf/ERswPxLzPfBYrhCenAo/dsqUK81Ypy7eH95FaeXTj8S882Va?=
 =?us-ascii?Q?Ju/14013t0wweQRuCiofs/OwNmRUsKeOEmMECmk0AytxRqPxts/Gj8dRX26W?=
 =?us-ascii?Q?DYaAY0smENSS43bs3HjLSoSrYNz+xJhyM1rLmHYgxLCXlSkvAVVeJ9m3ULG7?=
 =?us-ascii?Q?j2DkDRE1Jy5Gu+PBLIDy0GuthOOx5GZKM9IHeOiexIt/KgHVMTf7xTyNJXQs?=
 =?us-ascii?Q?VvFxwH/ZedKlJs4ctJWMN4iFpjZzvB3mU9YpZYCrn7/PwlLg3DHOGmFpFQDV?=
 =?us-ascii?Q?Za26+cSpEkYGD6n41WZSDKo5u3spsMjYjPfDHLN4a6MnBPvoOebCn6pbLUr7?=
 =?us-ascii?Q?Z+97cyCG7oaJfA7sgey0QFmZTv9wCixMgqQec9Cixf2ttEpjdqWV8sA8mbsS?=
 =?us-ascii?Q?DA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3673c9-9ce0-45db-1ff7-08ddf6c169d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 14:41:12.0859 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4T22RZUlkiRjIkEfkSLa8VzJw72UU9qRymHJknqhicdDzVvNlwDh08WGxDr9i/bXqWUnxIX0Qyie2pX97gAKGjMYtWgyOz6CAB2VzWstpm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13740
X-Mailman-Approved-At: Thu, 18 Sep 2025 17:55:45 +0200
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

Hi Mathieu Othace,

> -----Original Message-----
> From: Mathieu Othacehe <othacehe@gnu.org>
> Sent: 18 September 2025 15:34
> Subject: Re: RZG2L and DTB blob from TF-A
>=20
>=20
> Hello,
>=20
> > For RZ/G2L that did not happen for some reason.
> >
> > I suggest
> >
> > push a version TF_A that works with mainline u-boot in github first.
>=20
> That seems like something that can be done first, so that at least there'=
s a way to have Renesas TF-A +
> U-Boot mainline to work together.
>=20
> > mainline the TF_A first for RZ/G2L, So that the mainline U-boot inline =
with TF-A.
>=20
> That would be the ideal but it will take more time, so starting by option=
 1. would at least cover the
> transition period.
>=20
> I can propose a patch on Renesas TF-A to pass a DTB blob on the RZG2L pla=
tform as well. From the
> snippet you sent me, it looks like you may have one ready somewhere thoug=
h?

Yes, I shared the details to BSP TF_A team to integrate with v2.9/rz and pu=
sh it to github.
This will enable to work on mainline U-boot as well for having single U-boo=
t for all RZ/G2L SoCs.

I will update you if I get any feedback.

Cheers,
Biju
