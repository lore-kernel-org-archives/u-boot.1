Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436CACD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 12:36:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB2B6845E3;
	Wed, 13 May 2026 14:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="C5zL380n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EB21838BB; Wed, 13 May 2026 10:51:27 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 406948341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 10:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zmh+fTQLH8VGcQUb6m4Qs9v76wx4z1TLoXV5hv/y4eKgiyKVZQv4vX7g3vW5o3aUsGdWtkKQ1gJHttFJ8yDSQEvtED6esmMIeG423vv11h4+c3nEoCAAcQGXRkEAtV/VIGdHh9COx9I6DlPb5rVpraf2Tfb0tpvuXzqgNT8b+DGXyi35wz+EKRMDwo3zBbtx3D6CJsuAM9IuFdYM6mpN9nmFxVIKpTOsLLmn83XJS/eb8zBG4nAKC4OPD8FSAWo2Lkjl1LDz0Mrwx/0fiW90mupy4fTNlgG2dVgd79s5Eh2ZUs4D5KJNE3DyToEIgIDB8Hj9RFbDWyqjE/RypbKSBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXQoEa4wzlH+pcKqVQEzDGIV3uNwFkokEzG2C8QuhUU=;
 b=cTtRQ2r7ggrKhJErclXED/iXxif/pXstvoYdYyj6iXsz8JSywm09Xje7ORssLr0ee0VZj6I0MZmP09JGdPkcabpeyvdJY38O57gzBZKIi2NnZ0E/diD6RpfYaXax/rwk1pmwBUTyxQG18shMlm0NiNGnvXpI3ygLw1O4zvlV4EY5iSrva3f2ZXwowpqhdwbU+S5QYrd0j2qC8NpFayOODRzCINuLQWrYEivGey4usgkCwegxD9lyKDe3hojyHhYI/39o7FUUbEDiZgiwNy7Xwgr18AoxgIGPkSiE/3HvWle4hk3PB1mczwB1fJtBI/JGclPBcpcHcies8Hsf6oeUpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXQoEa4wzlH+pcKqVQEzDGIV3uNwFkokEzG2C8QuhUU=;
 b=C5zL380nEgTkYytAJIgtYp/O+Xi4vHuXvGDa3RJOpTdHnw38Nqk0Zrg7EwGE+90tuO70DoyCfbGLVd5B9FVO3elUZmLGf31toZ3hte+rA0yAgxfGvLTMDk7tlSWgKXwsT04pAY/4V/U8HmnDyGuz1cfeyQnG4eVQqXXyYzW+i3bcYXGyPr42ZQ8jGPxwExKihPVlcPtVRsDtR3S95GGoNCw+LJjEd4D4h50n4g+E5Mtdt8NfsAdUZR+aaM1ievaBOUxEbv+Pu9TW6E+43o4jumHTsOP/HjS59wke6kRIx792Ali3jXlXmK/QaAhsoKIFq3kENGXl7TKq+KMb9fqVhQ==
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA1PR04MB10443.eurprd04.prod.outlook.com (2603:10a6:102:450::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 08:51:21 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 08:51:21 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>
CC: dl-uboot-imx <uboot-imx@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Christoph Stoidner <c.stoidner@phytec.de>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Joseph
 Guo <qijian.guo@nxp.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Francesco
 Valla <francesco@valla.it>, Ye Li <ye.li@nxp.com>, Primoz Fiser
 <primoz.fiser@norik.com>, Jacky Bai <ping.bai@nxp.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Sam Protsenko <semen.protsenko@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Andre Przywara <andre.przywara@arm.com>, Brian Sune
 <briansune@gmail.com>, Johan Jonker <jbx6244@gmail.com>, Hai Pham
 <hai.pham.ud@renesas.com>, David Lechner <dlechner@baylibre.com>, Emanuele
 Ghidoli <emanuele.ghidoli@toradex.com>, Parth Pancholi
 <parth.pancholi@toradex.com>, Ion Agorria <ion@agorria.com>, Paul
 Kocialkowski <contact@paulk.fr>, Ernest Van Hoecke
 <ernest.vanhoecke@toradex.com>, Mathieu Dubois-Briand
 <mathieu.dubois-briand@bootlin.com>, Mathieu Othacehe <m.othacehe@gmail.com>, 
 David Zang <davidzangcs@gmail.com>, Simon Glass <sjg@chromium.org>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 =?iso-8859-1?Q?S=E9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>,
 =?iso-8859-1?Q?J=E9r=E9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Lukasz Majewski
 <lukma@denx.de>, Max Krummenacher <max.krummenacher@toradex.com>, Wadim
 Egorov <w.egorov@phytec.de>, Martin Schwan <m.schwan@phytec.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, Simona Toaca
 <simona.toaca@nxp.com>, Franz Schnyder <franz.schnyder@toradex.com>, Alice
 Guo <alice.guo@nxp.com>
Subject: RE: [PATCH v3 7/9] watchdog: ulp_wdog: Use driver model for
 reset_cpu()
Thread-Topic: [PATCH v3 7/9] watchdog: ulp_wdog: Use driver model for
 reset_cpu()
Thread-Index: AQHc4by49fXTB6fBxUSh9rbk39C3+7YLqDkA////fyA=
Date: Wed, 13 May 2026 08:51:21 +0000
Message-ID: <MRWPR04MB12330EE1FE6EE0A5AA9E6EFF088062@MRWPR04MB12330.eurprd04.prod.outlook.com>
References: <20260512-wdt-v1-0-0b9e1993557b@nxp.com>
 <20260512-wdt-v1-7-0b9e1993557b@nxp.com> <agQ71g1bV8Obvput@shlinux89>
In-Reply-To: <agQ71g1bV8Obvput@shlinux89>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRWPR04MB12330:EE_|PA1PR04MB10443:EE_
x-ms-office365-filtering-correlation-id: c40105ce-c6c7-453b-86dc-08deb0ccce62
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|7416014|1800799024|18002099003|22082099003|8126099003|38070700021|11063799003|56012099003;
x-microsoft-antispam-message-info: fd/UJPMCSwhX2XQW0Uev9qdT89CNGDw8aliK8iKRxLowJ7XJEsZlegJeOU6ajPKBTc+thMRE6rSUr9KTiDqz7NvYVHaVSCyfn05dyD+PL69NDaLUv/x5xJwVxX326dzmpn5cJAnGgSG8C2Va5gyjNlWfi5yf86DS/CnsvCBacyUDKW9Gn4h7jrRJf5wITfWTzlChi2nOLRzfEeyZLIlepwOGl3ZXC4IQwcugWVcrQTYCo/YsbhfO9UVYHkLcBReVIZwJriRynzjx1iTmj1TGBtyRIeaLUCCJyotpu7lNXU97aWityFNfvBMLBiVjHg7l4/1Mret1YFk4/I3fQuT1stwJNNp4c1a8rFhaqoqlweAWL53hugbesKpgeK76918h+HHBoHHTAcsba/pVy9FIxPnMKxJnDJRNu7ID95o34i2AtzX8Hh8/ViR/frdP14Pz2sFyDHwNm/kI8dsujWxOGFsT71NwX1msVsTQW81sP0QHi+Ml8m2IQNjPUl5KrylkqHG/S7UkmreAVftRLfPKS/2/rW36ZQt5/nTUCBl1T1u8D6tEaMY+1uMGOIS98Y7UZh4SG+We3x6bdmXu9xe7y8oltFhnYeiATkXThsV/1EGmyMpIgUAA+rhKS+rr75fCFv83orjf0P9Av7NPQMba8xbc3rbmGllgqPjs+eFreJuaLZQ7IVA2LbLji9AOi/AsOeq54NIGjHMwTds/6sWgYSGmpFtZNUJPwZU6MtQAkxSha7+RKjPSQnmoVUb9/3vb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(7416014)(1800799024)(18002099003)(22082099003)(8126099003)(38070700021)(11063799003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eNAc91toe3JkIoRmn1407c/uoNd5mU5ugvyGRURljQf4vOaPSKrencLFGI?=
 =?iso-8859-1?Q?37UVC5zYyty59kKJN+GVpaM2cmizBP3S9sjCsWXKnJjbBJB9ZoJobmLJTA?=
 =?iso-8859-1?Q?vCXN88hX8OvNXclFb0xMKZud5f0g2RX1FDMz+s0q10KumoO7Q0wkVV9H37?=
 =?iso-8859-1?Q?mvNSeyM62vQiWZ9gVUJ10/6SBHR1K9y1RLpkgbywmeGfdG7mR1LIA/Fc2J?=
 =?iso-8859-1?Q?0zqwm+f/UNAKLPRsoTPYhF1Tkl1uZ5Sg0/Ae1N8qORwqLvrcP4eAtjpkS3?=
 =?iso-8859-1?Q?+k2kIyS+Kg+byi6YxPo3FIdP+BSxiaCj10d/Dqdmo20cuQtQmzlnqWtxx0?=
 =?iso-8859-1?Q?qrKtD9MCT2k8jc1LZeGayShU+jHXRebtNg3X41IkzsklVLCoP1vbSznPga?=
 =?iso-8859-1?Q?oFSiH4qxZ/CvDnHiOGG0fe0TLw4MiAz9jtTT9cd4gqSJSTFiFEdeTAG3Sz?=
 =?iso-8859-1?Q?o+Q9cORj/GkR+ylj0uYL/N1miBrUWecNZ7fYEA2Ja2Wln80rw7PH62n/31?=
 =?iso-8859-1?Q?F+UtOrZlqLrQJ8NzEG4IUbaKWjUnAE0R8Xy8Sy64llidDVoxLuhunM8cM5?=
 =?iso-8859-1?Q?HtMrxIW1FvPWC7mr/0q2YSbvMnAVzuCxsdu1u0xGtFfXQZS7J0BXvA+gJd?=
 =?iso-8859-1?Q?fQlZ41UfxR/P+aWPQImRiynN09zC0Yzoyu+OX1gixSr8oT3W+Eq61OblzN?=
 =?iso-8859-1?Q?L8M3les+8dIvOVH3qqLimpzj2PsqdSkY6JzyokWDXzPOPvlk6/K9pGfj84?=
 =?iso-8859-1?Q?fN6VroJECZi6jW6m42SKN9m/Mil8xHr/CVMmz3ksGVt3smUVgglcOcwK0i?=
 =?iso-8859-1?Q?apnaqV7/LBlLlWAyKeehv0z3b+Zk56zCqj43Pvp/q/m2+kzZcaJcKZ8vW2?=
 =?iso-8859-1?Q?kxLWDgkPFAatutFYGQ/NcncIQcv1jXvFU++p4ZPDSmhOUkGvRDPjlhRvuM?=
 =?iso-8859-1?Q?+uL4I0E3acQAyJYueKeGq2Pg6iijuZyC3Xamifz/dOCL8RRM/6GcCI0UvY?=
 =?iso-8859-1?Q?ZorYAr0/TfiP9rN/ULtuZus1pwGDrRGSEHqbaTW3QT6dJ2EKABUvmaJmlq?=
 =?iso-8859-1?Q?VgHOPQh1Por0ObCbSqT1Y8o6UCuYZh4BLr8Gpqi8GfpFGIei+JDgyxn3xs?=
 =?iso-8859-1?Q?Pgtc1lqS6wEyjjXiw4Q+ItuO8b2PQDm1TkWTBU5vgpxP9YBy8PqoWR6RbJ?=
 =?iso-8859-1?Q?muxUaklIRNjziuEtYKqDB3DJ4euB5wvbURXDHtMxpjTLL2F2wvECCYDZ+r?=
 =?iso-8859-1?Q?uB9Ze4Acz1BRNF9CpqoXckRznOhe2ceYPmt27jv2yarI20ZSi6Uf9R+MTw?=
 =?iso-8859-1?Q?wZXZrFUvzI3xRF98TYTOrrTHjuzjVrxh2uHOJ4lbVf6h32NHWqiLq7QsRr?=
 =?iso-8859-1?Q?R07cdOq0krEb3XHr/TooSJx/JchzJnq5P48pitixlDrWxTtF7tzmHgRbR4?=
 =?iso-8859-1?Q?lP/2THys0FU8NOFS8QRBwPz5ooxp5Q0EWi98Cjn3kW0guJxejpJnky0vSD?=
 =?iso-8859-1?Q?bkCAMWjqiBRpTY+kvYwE5Vl3kx9sHtUwx3jSv6WORuXQSKtyJ7axpmJB+W?=
 =?iso-8859-1?Q?R+axmX64NrYrz0DUBgoHUzFdy26GIlS7dqC5NBjpobR+ZQVrg//tyi6Nlx?=
 =?iso-8859-1?Q?5w6unHB3eM+2ejGep/5iAcfGxYWHq4Be9Y8uU+uV2m1dl1oapulDXW835r?=
 =?iso-8859-1?Q?g4Q4IkMUC2oeDkehywwqfl2lrSw6cjmsZzjzsAJ6zo8o/sOfbbkqNo1oaA?=
 =?iso-8859-1?Q?Otn/nNCAYHgLoOp0XbgrLtir9wKI1KBhEdluJEtJwPvd/P?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c40105ce-c6c7-453b-86dc-08deb0ccce62
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 08:51:21.5405 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N08JUNn/wMB2Ta/YEoNu3YgcZeAZh96mhmkBnunxyfdxfgw6Ynv+uBg6Sf3j7kg7XgCVxw6qFvRurB2fa14e9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10443
X-Mailman-Approved-At: Wed, 13 May 2026 14:35:03 +0200
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

> Subject: Re: [PATCH v3 7/9] watchdog: ulp_wdog: Use driver model for
> reset_cpu()
>=20
> On Tue, May 12, 2026 at 11:10:14AM +0800, alice.guo@oss.nxp.com
> wrote:
> >From: Alice Guo <alice.guo@nxp.com>
> >
> >Replace hardcoded WDOG_BASE_ADDR with driver model based
> dynamic
> >address lookup from device tree.
> >
> >- Remove hardcoded WDOG_BASE_ADDR from hw_watchdog_*
> functions
> >- Reimplement reset_cpu() using UCLASS_WDT device iteration
> >- Add ulp_wdt_expire_now() callback for standard WDT interface
> >- Pass wdog register pointer to hw_watchdog_set_timeout()
>=20
> In theory, patch 9 shoud be merge with this patch to avoid git bisect

Typo: patch 8.

Regards
Peng

> issues.
> or switch to uclass_wdt step by step.
>=20
> Because without patch 9, reset_cpu will not work if people are doing
> git bisect.
>=20
> Or I may miss something.
>=20
> Regards
> Peng
