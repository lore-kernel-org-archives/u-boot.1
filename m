Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93C5CAC59A
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 15:56:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80C42832AD;
	Thu, 18 Sep 2025 17:55:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Vw4nUxeP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A201C80B9B; Thu, 18 Sep 2025 15:11:17 +0200 (CEST)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c407::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EFB08003E
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 15:11:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=biju.das.jz@bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dp62/xluOrQyQWhNU+3djymifwJO3UQ86lrLOVn+nEkc4o8IDofmqQjXFr82uS1qnLvMKzjtq+KGli2EUG0TrFMFkzZXb0pCRi86ynbDaqvViQe2u/8wBsS8+OLWWLdZwOKgHNnkNN0HXdtGALORIbd97vHWxFxKjffiUiu6L5t5qX3dxgHEGBsnDQVA0I3OW3XFFFs23ExRf1SAJTt1qEuWx/+Dci0c/9CmGG1gGxdrHqoV0gOqxQw1Oip6+EW4Ed+drVmavGlWRs3DJQ53RY+WdRAuMJjKs6bSE7ymGYn/xMpm0Qr6XhU8w9LknE+fmdZOTsFwUGUoGwjik30XDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5y9mrD0BMmq6hBiAK9julQFW9nbGSFb4izosRYRn1k=;
 b=EkTdstZXLRc3IeHWgMfNim6aiHu29LrAQkGrANsm5xpivABLX0jVtU5FOBEujfpRC6OI39FGyo86zX55zxGBvCkbfAHA6y9Ukx55ft5tT3erPIey/Ner/NBBgX2BCHeBP9vKW+DGet234smnzV76V3VJTxmVl7eMqNLU2sfdKtsKfDcpTZkD/3+DEv5flZlogVtGdRrOOVBOxrBxcD6wCfTWwiF7tiwW4XZLDNnrJ8z5BMcncOMoFchpk+Lda75jylFaZawgXAfs35ECt6pK05W4ffVVXR3Dkz/CrtO02Evr4vFtpocjuCiDEdFE4Qn+8VUKd2lgPMGaiSuKslKhaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5y9mrD0BMmq6hBiAK9julQFW9nbGSFb4izosRYRn1k=;
 b=Vw4nUxePVoa2RBubAjX21vtbk8XLOQCzayQG7c171OP3pD/hhQ/LcZqespPT1K2JjE//hHfsD7w0oo2YJQVOXd+3yM0EVaEVTbq8HNXuPFcXE6A6YSOrJWZPoqWV0/gKfvQTapUYCL+rUTYKs8r5yrpRAV1DIUWmGLdVOlp30BY=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB10393.jpnprd01.prod.outlook.com (2603:1096:400:24a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Thu, 18 Sep
 2025 13:11:08 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 13:11:08 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Mathieu Othacehe <othacehe@gnu.org>
CC: "marek.vasut@mailbox.org" <marek.vasut@mailbox.org>, "paul@pbarker.dev"
 <paul@pbarker.dev>, Chris Paterson <Chris.Paterson2@renesas.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "anton.reding@landisgyr.com"
 <anton.reding@landisgyr.com>
Subject: RE: RZG2L and DTB blob from TF-A
Thread-Topic: RZG2L and DTB blob from TF-A
Thread-Index: AQHcJw31BG8AYAUJK0KvkgHo6W3hvrSV1KeggAMULCqAAAGYAA==
Date: Thu, 18 Sep 2025 13:11:07 +0000
Message-ID: <TY3PR01MB11346A6D8FCB6909AFD4EC5D18616A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <87plbqd0kk.fsf@gnu.org>
 <56857fb6-e3d4-4069-afde-57b43c4d2442@mailbox.org>
 <TY3PR01MB11346F452EAE530A0931C9D228614A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <87plbnhqe5.fsf@gnu.org>
In-Reply-To: <87plbnhqe5.fsf@gnu.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB10393:EE_
x-ms-office365-filtering-correlation-id: 3843328d-9e66-45fa-834f-08ddf6b4d4b9
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?19krljFXgMzPmGHZuhegD7/OfG5UsnlQvElt8lZZ5BN/iXAerdxsh6ngnW26?=
 =?us-ascii?Q?xzeGdXjKvYsz21s5EyDu9fnnsdTyO+OAfh83OSISmvfSCUMc9BkwRYTG0JMK?=
 =?us-ascii?Q?ZIgLahyU5KGfSEivnCTyOzmcLbd3ai8+Z2hOF8PzCDBcX4YH2naM2GShnVCk?=
 =?us-ascii?Q?rwDZYY9EYiix7lhEb21W7fWFKx3umYXtnR6TNVoHJBlr7OJNxLhJcIWz/ToK?=
 =?us-ascii?Q?IrBth2ISgc2aLbJCGbH5iqCgexNACUC+hC6Mcp42o5LpNQ4aoYIDdnBhDdKG?=
 =?us-ascii?Q?aascWENT+cjjE0VRjFjT4KKeijNjMSwME4PNw8qUh8oTOmmmJ0oRtFX7Z97x?=
 =?us-ascii?Q?vyYshle9Ztph3OtHNjguNgESI72Z85pBzGMyT5vTLYGKnpJ50f+H4yxb4Mn/?=
 =?us-ascii?Q?Kyg7KnuuSTAwMfW8W0BESyqaC66ud2dfTMJqSWy4pNIvu4DViAblCnG2PYff?=
 =?us-ascii?Q?AISnqV5NFp7brta4lCj8TVwu6cUCZJb0HzYoFumAyK0ELLM+G3Upgumk3Y1U?=
 =?us-ascii?Q?DDF9+DO6xWaaOuN8Au+xkdm1G2C96kHf/1IWkHr9iZxqZsKoCBtZkIJh0Zay?=
 =?us-ascii?Q?91OEQg8u9aEQF76ftHjsYN3kHNuCFoBEg1af2MIeptBaXFQmwBBFEiG96HAl?=
 =?us-ascii?Q?bx4sRaxx3x2bsIbmVL4qPdfOFHnrJQ5COsx4nvd4iMfwC85XbPPIKExd2Daj?=
 =?us-ascii?Q?i0u5Jb2RJ3uo15sIyppTwB+NfvCgbGka+8tbCjKojbwx5ZMluEAozrH7KexU?=
 =?us-ascii?Q?dnTuK293uAuA5uW3hbeh3jrPQN/AOE7yxlSh4uB6ZimNiBLC69FWhm62mcKk?=
 =?us-ascii?Q?qHce3qGhKiPWnRoOcR9hDJbbWYSsaWqg6RpzIOPC2ME8MlQ++/Mjn9QdShvN?=
 =?us-ascii?Q?tuLJuJbgs9et310o2BakCAxWuotI9dzBXBapQa9FaG1D0FCGZALVLkE5nXsJ?=
 =?us-ascii?Q?ovywYP0+Mkw98CW7knidrqpGrRxmzogk8jfM7fcwFuSRh4w+ZjYwkZ8BbayW?=
 =?us-ascii?Q?+vdbVxgZNJigjRlBcIyBy1H8IYbZu8yAlma334cVLrMbmUDvbq107gOUg85y?=
 =?us-ascii?Q?/3zAj78qU9g67PGItJAgumzj1d6LuHRvSt4nDplxeUe0YYf6hgFasCeryrrY?=
 =?us-ascii?Q?U/6hhS+edW5vYIM9kbCXNWpQW9HAtEfXQ9wYDaLb4Pb6GqmDWiyqjKB1BA//?=
 =?us-ascii?Q?wo0sAmGo21uEJU9SGmM38Em4uPQNW94Qd7qeBDzgaM/1gyxWa7eOJeIABgei?=
 =?us-ascii?Q?Bz7BDvYh4aYcHIm6Sw8gYabb5CLGD0J9umpVAi2E0GQOFLoz3T5ZS5mUqNJe?=
 =?us-ascii?Q?OfGs0FGY402QuQoM09e2ST7IFy4bUPnFAj8OCNb228Z//II/VPDfKK+76EXK?=
 =?us-ascii?Q?Lr0waq4wRlQ0umUNSLTKsBsXPOgvDRQBQkxZcLHzNmIGn6iCnnTyB4LqnN0M?=
 =?us-ascii?Q?6eccAb0eozw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c+IiojyvKktqmLIoCPLZBXp1pwi13g1cOGfQRcbmy1zd/Nxi3YKwfOsaybKC?=
 =?us-ascii?Q?hIw0hsLoN2mDsgt0JOfE8X7wJwzyo9Imh0IlVXJCxC77e79TruoSo53nYExM?=
 =?us-ascii?Q?+UxNg3ttXXHhS02e8h2unTBQfqBzIfCaGsDaAkIf5a34+llWdRIOI6KR0SWS?=
 =?us-ascii?Q?PpJ20+JdU3EJFnpsAtY6xlxhIKQnl4TFIREmKTZnrGn4vgUXO3Zn1NjoiE4O?=
 =?us-ascii?Q?+N0cYxVi6eGQdqMqOz538Dy7ZgscQUjGgKfpibECiIhYeWUtmPs9E0NcIyWx?=
 =?us-ascii?Q?Zx5pce4zK6T3VcPn+uhMUjJ3L6qzKw4IX2RQ4JTlDpjZihAwNsExPL/OAeF/?=
 =?us-ascii?Q?SYSyxt03FSuiXa6PVan1pyKL9E1Zcuzip6XHPfGmpmmC9Pkf7TF6wDFv5t1j?=
 =?us-ascii?Q?h+Xq2uSPoX6qFCn+g4CsdYFz+ixQxfgOZiV0ytk3SxF226D7QSP3B3klfsmp?=
 =?us-ascii?Q?eBrcE5BXOMyus8j9/W2gVladDV4PJ2jL2+yzimU0lDPi+2zVGa8dnPGWB6g9?=
 =?us-ascii?Q?1ZgxCaXj12Ev2Kw7XzWhgdkwxvc8e89G+Y8rMcSwBS6hy3GOwU80jcMdjY5/?=
 =?us-ascii?Q?HT8RoAWa/q5XexWFChflLOkLdFYWdVxABTiXDHhIQ1pE+V8jJp32p3Jmb7DF?=
 =?us-ascii?Q?QDQ+QXa9hX4sDVsZxSr9ioiZn03ITVGehkODXqyoCyTG/gYwbnAPrSxHeZmT?=
 =?us-ascii?Q?CxuH7+iIR81pGnt56Tf1s5LEn27LU1OcZ7NAGspv4/dY7ndToWpgh/LB6QHo?=
 =?us-ascii?Q?iSGIVoC8GtA8lPcz6ZxTYp08Pai9MtCuR5HkIg0x+t9olezSFPOBAubZlFQk?=
 =?us-ascii?Q?P6e8mTBcVN+OpRaQROgeaf+R6mAi7UDv1fLYBypjA2+7qFrFI7q1KpzAuu+H?=
 =?us-ascii?Q?Q/WN0Ry1sh5/aSQkRSKvgzz7iTHMhvzvSOA/ZTFnIcANoWXoCpEZTcc6rNHa?=
 =?us-ascii?Q?G2jIbIe8feRU7AM2YNyPyXs81XClnVOxosEwO21uun97pVFOH+j/vq6eWMMu?=
 =?us-ascii?Q?XKr85zK8nsdtelwDrOcXIob94QBdnbdbwWDK9FUFAQCanbfqcUlTqZikgeNj?=
 =?us-ascii?Q?NYjvqVTIl5XrjOFicjTEsV49ZAJjKzScZvymvdz+5JngZ5PU5nqSmyH1QrJ+?=
 =?us-ascii?Q?KGtRsg56+1U91mjp59bmUpCyPrZQxAPkI0m03f1YJLtDfWD9603WQE5G7fG/?=
 =?us-ascii?Q?+j9Cy5IYYmp6IJBAs8UAlkiJts/wLiSrP4ggZ53XT4JsqsjojftmTE1nQhFj?=
 =?us-ascii?Q?bxqQDFznQHvDgoHY3N8XHv0cCNBIOsQsbhA4tJjYGoP6CDVeTIKcBgSespJ6?=
 =?us-ascii?Q?aTRmPiJg61PPEqFN2cVUtstwlJWyU+IdhiJvyWsI2iomHxb7EWIbByumTtPJ?=
 =?us-ascii?Q?b9Z6moo8iW4DWIg+4N5f+Z6Cf2aftMjdYIV4ef1RL9EbAgy75h74wIorHmAY?=
 =?us-ascii?Q?aNzvrV0MDAtZM7JSbsyC23CBXEthRCd1klsxV0iQfJSjasvLd11tC62tqNxo?=
 =?us-ascii?Q?7mo4z/bJjgMzZQ89C8DQp+D+dpQPCCCyRerYSz7JVjm1bcv4x6RkyLuqpyh0?=
 =?us-ascii?Q?xCnJycvo3uQzbfu8rwlP8RjrjpcZ8ACS15330+bK9iIKkadyBPlHHhjQ1cTP?=
 =?us-ascii?Q?Gw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3843328d-9e66-45fa-834f-08ddf6b4d4b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 13:11:07.9370 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZlKqPT6StCI8qWFvmISRJ9qQ6PV1TKxfD0gT6bS2uUEp42kZB2I7Z+1oFLO4UWnnhHQcAi7Ji1fO4K29xreO5s216aOZZrypLUBtjBztQdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10393
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

Hi Mathieu,

> -----Original Message-----
> From: Mathieu Othacehe <othacehe@gnu.org>
> Sent: 18 September 2025 13:55
> Subject: Re: RZG2L and DTB blob from TF-A
>=20
>=20
> Hey,
>=20
> > Also, you need a patch to identify the device and pass it as blob to
> > the mainline u-boot
> >
> > On TF-A:
> > .ep_info.args.arg1 =3D (uintptr_t)fdt_blob,
> >
> > Also you should fill the memory blob(fdt_blob).
> >
> > Hope you can take over from here.
>=20
> Thanks Marek and Biju. The current state is still that people will take t=
he forked Renesas TF-A, the
> mainline U-Boot with the renesas_rzg2l_smarc_defconfig configuration and =
expect things to work out of
> the box.
>=20
> Currently, before figuring out that the TF-A needs to be patched manually=
, U-Boot is just crashing
> without outputing anything, which is painful to debug.
>=20
> As the only RZG2L supported by U-Boot is the r9a07g044l2-smarc, and we ar=
e not receiving any blob from
> the TF-A, I think it is fair to assume that we are booting from the platf=
orm we are compiling U-Boot
> for.
>=20
> I have proposed a patch here:
> https://lists.denx.de/pipermail/u-boot/2025-September/598712.html

We need common TF-A implementation for Renesas R-Car and RZ/G2 based platfo=
rms

Also single U-boot for all RZ/G2L family. To achieve this, you need to pass=
 fdtblob from
TF_A.

Marek previously suggested on RZ/G2M that to upstream U-boot, you need to u=
pstream
TF_A first.

For RZ/G2L that did not happen for some reason.

I suggest=20

push a version TF_A that works with mainline u-boot in github first.

Or

mainline the TF_A first for RZ/G2L, So that the mainline U-boot inline with=
 TF-A.



Cheers,
Biju


