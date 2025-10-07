Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D8ACCA470
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 13:19:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6862C84014;
	Tue,  7 Oct 2025 15:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="SOYFb1YX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95FC7838AB; Tue,  7 Oct 2025 08:41:27 +0200 (CEST)
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c405::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEEED8323A
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 08:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=biju.das.jz@bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Igee6DS9hJPH5f821rMzweIvz2f+DoVJY+39A0PNnZXsVYWjuZcsN5C3HFu7cWlmA95RhBxPdS60U+uqxtTGtjV2Ql/heagiLaxuj+at9RLipATBUVNjQUPHZV/zenImPEX1eM8JxR2TFyGG3RXVLKNxjG/UtmXOjaim/7NiDUx5VsE/tT6W+kFxVeGsAvPo2+HaDf9Td9FXwJcrOYVIU5Umq6vNu3WoZP6rJnfC2AQQSVV+R2JngF6Cpc8Rih1x3AqSDaXFVoONYpzQyzD+f+k7yNi5AM+9hkxYpqdlseaiNuVqFcJ/KxrkcXo6oLGMHSpMlX6XiCjKwA0hfRrjzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LEk2g9Daao1mwfMre6SxS59157u3OCCu2PmZpYlD7s=;
 b=Tz+HVNicz7iGpUKWCHdWemfD+I+ZWTJhEEGKsJIePFjn5bSSlaPPlW9oUEDn+yPZ2zm5wwsgvNeGzaEgnxy2Zib1/qsUbpTxOW/GxW9KbcJbXF1gmbqCZD5iVqNhSkeoBVWW50pHpbJFdPLmwZzt65PoYbOK8ik6V81/XNSxpU0+Ny4/uEqqE3ZJdnEj2Z4urRRkpGnSFojqRq2A9AJ/NM+6nrTEQ8LHdqZPDaSxEPJYgAmcb1QTkscjrKxYtpPmScaZtzXNAydbGQ//YiRRRI3wUhCybSQWrurBF0Vq4VWhwEPfalWhpdHlGMY209wvFxGmYky1hARsW3VNZiQ+CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LEk2g9Daao1mwfMre6SxS59157u3OCCu2PmZpYlD7s=;
 b=SOYFb1YXT8MYWqWgC54v3zIF0sa1TBW5I6XmhrsWn8Q2FvkBL50sZHzfaSJgwoBwkNdjgHhazAWQPcCntzU3iWlZMAwuu4nO2RKvGlwv6/I+H0tP6CjvJucFETolbgsmbVKH5upWXS3rjj5Fkm4DGqMKrfTSBpb8m5+d6BRdzr8=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYVPR01MB11261.jpnprd01.prod.outlook.com (2603:1096:400:367::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Tue, 7 Oct
 2025 06:41:18 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.9203.007; Tue, 7 Oct 2025
 06:41:17 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Mathieu Othacehe <othacehe@gnu.org>
CC: "marek.vasut@mailbox.org" <marek.vasut@mailbox.org>, "paul@pbarker.dev"
 <paul@pbarker.dev>, Chris Paterson <Chris.Paterson2@renesas.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "anton.reding@landisgyr.com"
 <anton.reding@landisgyr.com>
Subject: RE: RZG2L and DTB blob from TF-A
Thread-Topic: RZG2L and DTB blob from TF-A
Thread-Index: AQHcJw31BG8AYAUJK0KvkgHo6W3hvrSV1KeggAMULCqAAAGYAIAAGgEDgAAAP7CAHVcvYA==
Date: Tue, 7 Oct 2025 06:41:17 +0000
Message-ID: <TY3PR01MB113468B92EFA8BE0EE812128286E0A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <87plbqd0kk.fsf@gnu.org>
 <56857fb6-e3d4-4069-afde-57b43c4d2442@mailbox.org>
 <TY3PR01MB11346F452EAE530A0931C9D228614A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <87plbnhqe5.fsf@gnu.org>
 <TY3PR01MB11346A6D8FCB6909AFD4EC5D18616A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <87h5wzhltj.fsf@gnu.org>
 <TY3PR01MB1134675D06BCF644BC578862D8616A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB1134675D06BCF644BC578862D8616A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYVPR01MB11261:EE_
x-ms-office365-filtering-correlation-id: 6ca2b61a-5240-4e8a-031c-08de056c8502
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?soiOPGdrEl0O5N7On2DBwlKdjXfQwGd88PdNK0H2GhcYtq+p3Q02WpTXdImw?=
 =?us-ascii?Q?yCjl8f3Uz13UccyodnxNchAr/CocGjc74sYlIJsb9BzGwbe0dQVHorhi02+m?=
 =?us-ascii?Q?T3O6gtLiUpAs1grAsFMfeJyhvHjIXUwB1R9AtDHF6fiU73dTTaZzJchPak2c?=
 =?us-ascii?Q?nRYvf1BuiQGg4u8Cp1oNnsavbJHZk9oBPrTeOGpg2HnsyUDZ30X8j1EZ0YxP?=
 =?us-ascii?Q?vAbfQqfC+YklmbUPX7S6as7t7VlwmUyXsdCZpztTVLaLss8LxcnTv7bkj76M?=
 =?us-ascii?Q?xe3qZodwx5o3lzEyonNRIFT1ZgV5JIQwPWfzuYEIGc49tMPF89D9QITsLCd5?=
 =?us-ascii?Q?gRfz+Dy7J4jjBKbe0BPBAwQaRmsHn5qh1CcB5hEZMtC7M1u2V3OOuLBGaDEG?=
 =?us-ascii?Q?ad223fWb3O/De7WGvRXrFbYAfjAODSy3fpWVMV3olISOpa9zDW9A9k6TakRx?=
 =?us-ascii?Q?ZZIXGZZ2o6m++RXdOOTlltQmT1kRV7zPYViWMXT2DNB48vnctjATyka8Mn0e?=
 =?us-ascii?Q?GoD0h3tKy9rPoq8NLwT7k0+gDwgetPZEvSrP/wNL18uhKYsc17aP97uNcCxx?=
 =?us-ascii?Q?TJZpqvD1u6zZOutmMdBafXa3YgkgNUKef2kolqc63B38bnGxQyQkA6KFA1en?=
 =?us-ascii?Q?UTHb24grZ6rdpijuojBNmd3rdFeq1l0kjh/IiFvIfexjxqb/9FIYMCj985Y2?=
 =?us-ascii?Q?exQhfLskcVSSOXbINW2eOUswr11x0IKUO+JwEuq0RC6sgqYY7oaRyU5OK6ml?=
 =?us-ascii?Q?F2U36lAf0ogFovwmDrWcBslfIgCtru7KvyUHLAnfqGmifT2mNz4ZbW74FezX?=
 =?us-ascii?Q?vdvlW9svsSKLHsHqOKXBoD83W9ZTmYEUUAtpE6V8aF2jjrYQocc0+xG4fiwE?=
 =?us-ascii?Q?MC4jqLn3NNJ6MWwUBFjhVZCc9471+8oxxer3HExSBJdzyVp6wAfth+z/QFSs?=
 =?us-ascii?Q?HIN9y+bxGHwbAbueimI9K7pAew7X+R06Jrmh2jEWzaQXys/phxaZJo2IVv79?=
 =?us-ascii?Q?B+KN15lyf8lgzk5ohoLf+Km5sybzaKKjUqCu+uHPN34kZ25N0ID/7XtzSh7x?=
 =?us-ascii?Q?7XqH5QhodF0sq3WOb7hnF6UIx9YtAzx/U1TgFoBBch4KL/suDiqXcdSLfGFA?=
 =?us-ascii?Q?wKUL2Gv8n3AjhKNnl7oOfV5nSpnQ/IvIVhQ1Fem8a9nj79P3NjvK+pbcNWZ2?=
 =?us-ascii?Q?qQeZvFxSFBmEkdva3SFqaUpZ7hXvchFqhL3y6fWhH+tLCtvwU2zajqT+AVyq?=
 =?us-ascii?Q?BaRsFnOz77gisSNcIzgMz4g3XyR3OoKOYI0w+Zu8CBQHchLzrgo/5gYQHTN2?=
 =?us-ascii?Q?Uic1p04T5qWjQQZsv+mx7yL/LSOjHVTXv7z2NNyol+lh/12jEaYiqunprjx1?=
 =?us-ascii?Q?vZ5SF2Us/0VeFTC0/ZP6UHme2+yd+hNS+hJOgvE6mwYuFllfb2jcyLEq52H9?=
 =?us-ascii?Q?UARIImUlzWz4vEJSYAI2urxjqevj/yXbY+iusp5T96ngJTKSDzl+iyROPDG5?=
 =?us-ascii?Q?P7b2QPd/LGJXUulzVpM054xCTxYzOW1wgB3I?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?46AQAe4AOlkSbChPGrNCaQqgCj/SennHUg/dPWgirWfrBUkeH5XgpNgSE50y?=
 =?us-ascii?Q?Mb8hBnUFrseSyBT/Ciab66kTOXCYMEMxQ7sQHzzIP/z9we1Z6ZZ4blafmihQ?=
 =?us-ascii?Q?TUI+Rt66dxb9V1EVRjZObkhDTS8REowz2g7/8uqnYrVXwWUDxZ1FJIb6gi6l?=
 =?us-ascii?Q?vR4gAXVRm05o0wfEainFMyNMRRWei2+ug5MiDyC70PJHp3lMPktgkLkoQ9dY?=
 =?us-ascii?Q?pCyo13AZLXeyyek+7VIEGmJSfRHPpx4/4RJ4jjo+iDTqMuWU6pARrJVZE2eD?=
 =?us-ascii?Q?6CcNRV8XMgP3fYbcObw7jfqhQkm60Nz6Ac1H+GCAszXkAuZ1OikR/qtAd/1L?=
 =?us-ascii?Q?jJ92fv/H8Fy450ulp3kj8eae7lZauaUWHBWILHelGXpbBjwUBTzK5BoRL77C?=
 =?us-ascii?Q?cJWZoB4cbSTmG6gH97FPzvathnFVzJxrQDrSx//TtwJj1b4V4FDdP2kgIy+s?=
 =?us-ascii?Q?vuoUSwIGuIvPFQChRe+8yjhTvJvc1tbIB80i+tZJyOtLc0ieYSVqvirE3PMu?=
 =?us-ascii?Q?xXhgRCSRPqi2iNsOxI0dJ0mO3bZk3sFgsWt3PmUEIhe0c9thBpj9n7wu2roP?=
 =?us-ascii?Q?ju1p1amv4nfn1lTepX1Xijrei7cl85R4CrPHsc+tu7bn86adSONQvRLiOulv?=
 =?us-ascii?Q?NXFIGjOh0tv3bKJ2vwc+HmUulRvk0eHZYYvpWBVB8cT5zayktsCoZ5I1YmId?=
 =?us-ascii?Q?RR1uJqmol7zMUx4DzE03MfQn8e7ZzMX0jUAlIcR6GUXDFo7qmFAvWxqEPxLb?=
 =?us-ascii?Q?mSpGPILsMrNQQQK8BbBf9updzQduT0bQaCLk6enk0z2JsioBNFaB4kVrwmXE?=
 =?us-ascii?Q?cuMbq96KmB3cKR4T7Wi9bxRWJAdNQNZFDNV7WoCk6d48LeFZKcqbfZQX9mm/?=
 =?us-ascii?Q?bBGAEfIykHoSktXiYCOBZ4tHlb5LBCwyIVj0vhnmj8Sp4rFXvchdmYHt+Voj?=
 =?us-ascii?Q?1BHzc/dIniLKocu4EXevt+HoRimkR46/CvBedL3l5YPlCcZAWHPRMwnWLbpc?=
 =?us-ascii?Q?wTYUockpIpkZQ9c8kx0QThXeEn7pTQ5/7/p65F/r7PKrVAnkj7FkeWTTJ8WT?=
 =?us-ascii?Q?uREJWjpJSJUuPkUXHoQvYcwVug03PXvy6lmRnnXuHXPCGn942yVwjoXIuUGk?=
 =?us-ascii?Q?9h0OENOzlx3vE5Ia/mTR0sPf6/MHBOxNiaKxyeAicWBLinprBsxbpIYR/KcV?=
 =?us-ascii?Q?u/0PIxQ8FXioicaeHgxGAqfhaA/jFaAxoZIewqCbRiKvDDccmr+8I3uiAHWu?=
 =?us-ascii?Q?e+KHkYdQNwDxWKp3OC5XtdoNpvwO7QQHSSdvJcsOjS0kxdss2FpcYOz2Rnwt?=
 =?us-ascii?Q?R4r14V/JV3IW5MOECxM2/Bc9F99PpC0b+vbZEXAFd3zcvEVXNywzBLMOeAeX?=
 =?us-ascii?Q?zq0F7DxEKnMjF+fY0jlmfYhlBZgQJOwwitj4Ni2SSMg7Zses1Tc3r+FHs0Dl?=
 =?us-ascii?Q?Tt/w1ewHfbbLHPOFLPf+BFKNih5OkSAWi1tySvwocb0i80jIZJP0sLpCpKeF?=
 =?us-ascii?Q?BLst1Nz3pSC52QxUA3vlnfNmAhvcS9G9zf6IUs8ZvWO8//tvMlTvPlE6o0Km?=
 =?us-ascii?Q?2JCqaTzbFqPfkjOPLyrPnnaRzEPhKdxjkGDwPgaF1RIpCtn65MJUg8iyqO8F?=
 =?us-ascii?Q?KQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca2b61a-5240-4e8a-031c-08de056c8502
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 06:41:17.8945 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HaaHuVeYnYQNTj4thA/T6HGJ3yNR44rH0XGQiVBXPiAA3Nz94rGi1bDG3Ziv+ZNfuMsyIIAL3g5e+PAM3qquDXt8Nfu33hGLCGGVVnuYVu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11261
X-Mailman-Approved-At: Tue, 07 Oct 2025 15:18:42 +0200
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

Hi Mathieu Othacehe,

> -----Original Message-----
> From: Biju Das
> Sent: 18 September 2025 15:41
> To: 'Mathieu Othacehe' <othacehe@gnu.org>
> Cc: marek.vasut@mailbox.org; paul@pbarker.dev; Chris Paterson <Chris.Pate=
rson2@renesas.com>; u-
> boot@lists.denx.de; anton.reding@landisgyr.com
> Subject: RE: RZG2L and DTB blob from TF-A
>=20
> Hi Mathieu Othace,
>=20
> > -----Original Message-----
> > From: Mathieu Othacehe <othacehe@gnu.org>
> > Sent: 18 September 2025 15:34
> > Subject: Re: RZG2L and DTB blob from TF-A
> >
> >
> > Hello,
> >
> > > For RZ/G2L that did not happen for some reason.
> > >
> > > I suggest
> > >
> > > push a version TF_A that works with mainline u-boot in github first.
> >
> > That seems like something that can be done first, so that at least
> > there's a way to have Renesas TF-A + U-Boot mainline to work together.
> >
> > > mainline the TF_A first for RZ/G2L, So that the mainline U-boot inlin=
e with TF-A.
> >
> > That would be the ideal but it will take more time, so starting by
> > option 1. would at least cover the transition period.
> >
> > I can propose a patch on Renesas TF-A to pass a DTB blob on the RZG2L
> > platform as well. From the snippet you sent me, it looks like you may h=
ave one ready somewhere
> though?
>=20
> Yes, I shared the details to BSP TF_A team to integrate with v2.9/rz and =
push it to github.
> This will enable to work on mainline U-boot as well for having single U-b=
oot for all RZ/G2L SoCs.
>=20
> I will update you if I get any feedback.
>=20

There is a public TF_A [1] that can support mainline RZ/G2{L,LC} U-boot.
I can see fdt_blob setup in [2]

[1]
https://github.com/renesas-rz/rzg_trusted-firmware-a/tree/2.10.5/rz_1.1.0

[2]
https://github.com/renesas-rz/rzg_trusted-firmware-a/blob/2.10.5/rz_1.1.0/p=
lat/renesas/rz/common/bl2_plat_setup.c

Cheers,
Biju
