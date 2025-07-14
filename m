Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE90C83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 14:57:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAFBA82F49;
	Mon, 14 Jul 2025 16:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="fntUhl1s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98F1883020; Mon, 14 Jul 2025 16:57:47 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E464982CFA
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 16:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=hitachienergy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=holger.brunck@hitachienergy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x//9jM8OTC0lRJtNWFI8+wzZrqOhapfe+qL2qNa63rs7BWpsKaJCizXRTlmkt7+xa6WjvZqOfYAF0ZyiUhWqLYfRsYP7UcNDM9Wft++pjSNgUrsxF7oZ+YscTUbxesykmlkrOpYWx2xY7ZPFOZZnAsLfj+YhRQIhbVkCJm6l479aEu3YBTPnVOKzp7/b3EttYLgh2DIPjcDtJSTsJtEGfOTgkGg+MUnULw8ORngEvSGWMUe6h14XjIPXbTUTP+5iJgkZJtBDdDcPYdEdbaFg3M51puKWZW//3XesHn6+3tV8E9/wmwTqjs7cSiG1KZg5t0dRIf41sZmkndjMMGKXAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lN8rZV6WYGyw5uU5MH2vNgNuAfFtsbCnvDgSl7g9g6A=;
 b=B6Z3/yGs/wZop1CS1hEEibVW288rQJgNf/Z02i2YoFD0AXiiJebzeFzKvUEPYFOc1lHBYSNF8NQNgHyJvfH9j4zISUCsgQmXCJz+dbiO6rafCEAqecV6r0tsdVHoqaLuzdUQRJXUXd8Qh0+Hq9pqMx+Hk69mwbttHaltTQBv1B1gmTFTlRrJ69vJ64ki2hYY0Wl4xeuzJfBz6XcmIz6N1oJq1Ma3u7O2nicQaUY0XXnbpKSO8Z5AkYC9T1x3/8sdYTCaSFKgsH26lSKXJ87+RGSe2aTcPLkEFZAYVQVcfnc85pEsG5dzfnutioVdfTSTka/ovWWfCvzPZrUiXYddZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachienergy.com; dmarc=pass action=none
 header.from=hitachienergy.com; dkim=pass header.d=hitachienergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hitachienergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lN8rZV6WYGyw5uU5MH2vNgNuAfFtsbCnvDgSl7g9g6A=;
 b=fntUhl1sebSCg9GgVQtdmmfbMr6a1I19APFs4CbECkDPqA04ztw8UiV6tju9H5fR5u86vf/M5xIFbSivbTwzxM29t7lqwbQG6VJrXdsjtXnFV9y7YkBFonj4/nGUOINViiPJGrgWFao4S/lnxpOoBQ09v/4EudvM0uayzZHOAO+nk+ZuL2dnk/mhDYIZRpFOSAK6z20xvt7V0bqWaEiz2Ff0oHmJ0ZwG9bXf9Io+w45bOlWFUsZ/rYgYuxFWyhQkmCvunNw2WOFjOQ9+23dufGPP5SGChSDpQx9vb5/jYbc8aYnfbaBC4a+afC9JPIHckJZZzsP+B7eDMwoM5mtXCQ==
Received: from AM9PR06MB7843.eurprd06.prod.outlook.com (2603:10a6:20b:3a2::11)
 by GV1PR06MB8402.eurprd06.prod.outlook.com (2603:10a6:150:21::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 14:57:42 +0000
Received: from AM9PR06MB7843.eurprd06.prod.outlook.com
 ([fe80::ccee:fd8e:4e65:1bd2]) by AM9PR06MB7843.eurprd06.prod.outlook.com
 ([fe80::ccee:fd8e:4e65:1bd2%5]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 14:57:42 +0000
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Tomas Alvarez Vanoli
 <tomas.alvarez-vanoli@hitachienergy.com>
Subject: RE: [PATCH 2/6] km: Kconfig: set KM_RESERVED_PRAM to zero for all
 designs
Thread-Topic: [PATCH 2/6] km: Kconfig: set KM_RESERVED_PRAM to zero for all
 designs
Thread-Index: AQHb9MJdEQ5YBzZK40WFzT8hfeW5ILQxtD4AgAAAqhA=
Date: Mon, 14 Jul 2025 14:57:41 +0000
Message-ID: <AM9PR06MB7843D024FB26194DC5AE943CF754A@AM9PR06MB7843.eurprd06.prod.outlook.com>
References: <20250714132221.2471558-1-holger.brunck@hitachienergy.com>
 <20250714132221.2471558-2-holger.brunck@hitachienergy.com>
 <20250714145212.GF13084@bill-the-cat>
In-Reply-To: <20250714145212.GF13084@bill-the-cat>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachienergy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR06MB7843:EE_|GV1PR06MB8402:EE_
x-ms-office365-filtering-correlation-id: ecffdeea-6dbc-4e71-397b-08ddc2e6c8a6
x-he-o365-outbound: HEO365Out
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?VoI8hOJJI3IZL0PBps5UrepYKovL9L64fyoTs1XYR1q51ReukY9RaJENh+KQ?=
 =?us-ascii?Q?LL6SvEQt4fg/CFkI81ZTFX2l6yWfSio64l/kdcPirR9peYqckyqO85iyVE62?=
 =?us-ascii?Q?2d9YGzQ6Ut3YH9UvrcDCVtNqTmlMFq3BpCxPlUBrCfc6StZALcTw3TnoJq0W?=
 =?us-ascii?Q?mHh8erutcpIpBoQdTGEEFJ/B+C0L1GJ4ZurgtARcTpQ5K+qKe1li5LHPZSMM?=
 =?us-ascii?Q?tR+L3AjsUfGPM88pwcJXUqxjs0HObRYXtV2qDKHJgYsO0r7xg1G/rwxfAaGZ?=
 =?us-ascii?Q?LANXF1/RAeLSWtVh60opEzRJ1ERbnKMx2otCUh5gUcTvkiwpYOSjVon7MBTO?=
 =?us-ascii?Q?+4myptAST6MPGjjBSvjFLG4ydTG/j1PTZRiZDJSXzqUsR9g1ejpHIfOXL196?=
 =?us-ascii?Q?2x8nGntxmMaWuRv/G7ntGc9W0E7Tqpq48YFFtn0Atgic8meSW9cxnWa6W+aj?=
 =?us-ascii?Q?HMFdF5NSH3yQA8eSNAA4z5jvQmaTdLuWzUK2C/aa96QkOmK3+k4aEF2/FnxR?=
 =?us-ascii?Q?CAIY8cSwSJBR/xFwMreXqyksNCd98lEf2CsN58HyZuYn9D/aq+8aBGkRsWLq?=
 =?us-ascii?Q?3igA1XcduxoPfzlTXwZoDIqc7TuAX9co5dBgGFTIplfXfIvRHlnv2ytB3dgV?=
 =?us-ascii?Q?d5xREf56LaR9mfjWD46twfl24KinC9q/e/fyp3musUUnOQtzohxdiIOnNRaT?=
 =?us-ascii?Q?uYH/22VaDqEgBLhKJR+w+up3o6hf54uoVszq4aZfZ2CFLeZCnGj490AcOP5C?=
 =?us-ascii?Q?0pBJo1M8t8IvtRFaeCVMT+G+ggqQC1ArIMo4d5QwCsOv6qGKJDS0Q/T15AGs?=
 =?us-ascii?Q?9HhDj4X/1ckjDsd9ssNybKg87gYjKVeJZaYqaMXtNBoSlxn55JeGVZ9/BGX7?=
 =?us-ascii?Q?qntxjbSu8qZ73KaRAitC2168nsEAZyQPl7m/cnXpTygNkhjoZ2weagmOrXjG?=
 =?us-ascii?Q?CzRgw2wN1EFiTIOcMKhd3GwyTXnpe/gAgwSysyduoDNV9rjnik/UsVd5sMGR?=
 =?us-ascii?Q?kNBDr3oaJAkaqqb1yM1Tcm88r/6R1zfIy8/gPVWZVf02TlSug+P4est5qF/l?=
 =?us-ascii?Q?5ZnM9NSWTVseGsnYajYGBIVgObBXTUkmyj9HLHTR8t2dLIIMrHkSZnt2l6Cd?=
 =?us-ascii?Q?PCr8PkUyS2ioX1qGIrA5fJqXmMwOFD4rLQV3BpBefUd88nNfsymliJgjDZZ2?=
 =?us-ascii?Q?E6+8ytVQxu7cGhCB1pMW03eJwazJJ4gVP/prCXyXfaKEy65jIxy7mnsPIXpe?=
 =?us-ascii?Q?cA/LKYpb372VWUjzU6+SEKpJulLJ1EaJGOa41RbizrFnpYZVKBGtynH2EwVR?=
 =?us-ascii?Q?NKwvEMJUhKaZgzFfKkot0D6/0s2kDmuH/tDgNmqPvUlk0UqrFXQ3H8/ozvSZ?=
 =?us-ascii?Q?i9l+zOcf2cyBAs5S2ml6JXowYvoORCItoq51BHzhz58gEX5ieeG9G/OlamLO?=
 =?us-ascii?Q?wsjH+Yr7fHrJlPrlIqaCvh+uPh3f4eJoK4cOXpn7/i9nHsfUg8c7ZA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR06MB7843.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J6F6c7L7pttrH/ZjL9LC02c/Tke02XF4vuYVu2/KGSKwB7snM6t7/D88lUMw?=
 =?us-ascii?Q?psl5QF4hQBklEKm6Nv3JF55oy3+d6JzFc5nO6UPdZzhHWdwJfzgW7IGwJ2Ey?=
 =?us-ascii?Q?3fM/fv5CQWbgJPDFdFIqsWJ46klXrCwNjSvuO5eUs/kKCX+yW1r2o97JSC9a?=
 =?us-ascii?Q?BFrbQXwzFWMihzodu0VfYf89gnxL5SC9e1a4JEBFAfgUPh5sFJUSwoY+D/Eb?=
 =?us-ascii?Q?kHZdf0IMNjZ1YY2+fnapZEfL3kMKq6N8uUi0kCctsPwb8Xt9+Ts+d7uo4mhJ?=
 =?us-ascii?Q?ADKG/L7p1nqNFVbmya/h67XUc0kTDUZ0WdRqcfvFlbnMAUk6pWJUzebBKsnM?=
 =?us-ascii?Q?Q64GiKttBGdtmcEZauHqlcUhsCrig+mbHHklXEHWfNS7ZhRwAP2s5Utt05mi?=
 =?us-ascii?Q?G3uiJTIzNrdbd1P5N38LfN/qqHXHPTEXbyw/yP76yEoolsa3GKn0ib7/zq6h?=
 =?us-ascii?Q?kETY411CT3rgGSrC/ogMC1r/3npy7c+Snt89WDAmtUK6CPW2yRNJfOazYTWv?=
 =?us-ascii?Q?RB/eM1CVaaoVAjIxsqhjLw9+3VIZ7dhpqphyWw/mCE5X1HKYcPjWbxI8WeZl?=
 =?us-ascii?Q?oz4FpTBIhxaNNSuzcnZ5Pm9d/sJFSM1fmUSTqyyHOMbraEt30FahDJKfCN/o?=
 =?us-ascii?Q?c0YQZpM/MLh7/8vH/yKA0Kj43K2Si/KH3QLgAbhF/t8UfAAZp9TV+4P70znY?=
 =?us-ascii?Q?g6a8iUpc7QYlB/GqD9gRkkJ/wXEeeZKDeqMmuvFtpGSFz+TXOiLKvf6QyxIX?=
 =?us-ascii?Q?zH7JbWPpqPyOcDdEBmgP8R5cUiC/57TbtoBm2CkpAt7w2MWqMNEHH6hKmYny?=
 =?us-ascii?Q?54BsxRsRjUWsMV5iG0T0u2pfkiObJjJEnxnv6f1ZYIVKzHHw//VsaxiI+upm?=
 =?us-ascii?Q?4jOeSj7bJKVSyk4CnFHbvuMyrJgTIWKugMqZAEz/0QJA4TrLoDu1l5S5NHGl?=
 =?us-ascii?Q?IUT2r9Js5YktDQ0pcqkRDJNaakwrPT5lzkWg33n2v87bp/FxQs+WXYNtB0Ga?=
 =?us-ascii?Q?+TsLBi3baxQNoAKM0jh6034PJ/Agp6IE1cdSOHef2Z1qlubLH0HHtguXCIpC?=
 =?us-ascii?Q?PMiVsq5zMFao84wjxRmE2awzAKdzoHbBQq0bp4/krvNICM2DgOAx9U0YpPZM?=
 =?us-ascii?Q?L6ZJuf7yx2bGM26G7Jtztq84REbQL+wSlApz292l5UCOWxdABplbuVgLChYe?=
 =?us-ascii?Q?FnOHlJB6nFIwAl9v8Q/85NRm//m+HprToyw1IY1GFR2HTRVrG0uahIbjG/oZ?=
 =?us-ascii?Q?n341WE1oA3esSme4P9BMiCLl50x/dgIEztoERpPyB0TKv1K88cciIfcNf9GS?=
 =?us-ascii?Q?SqbwB6PZhpCkz7D0uEZhBEWs8CiLElIUnZjah6YxsrLFaWcMEQ5Qi+vYeyME?=
 =?us-ascii?Q?AJKUc0IGtB+jLT8OlkLqOPDVrFj4rvTHWN8Z0KOyHUmwz7A/CHH3ryiaBXvR?=
 =?us-ascii?Q?fcqxjSZtx54UETCfBiO3iv/AyDvF3wVHDFA/FDsgDCLBDL8tzAYGOoh4+UHF?=
 =?us-ascii?Q?7vYpcAGIeMeXfVVWBIJO6gg5G5CDGGPqCmPwkg+FXN9bipPepsCuE62sy7lw?=
 =?us-ascii?Q?zoO7bQ/GKPeD2WSQXktMJoKg0fJFSpdIJ2RB0kqj5Xq8QwBPm/zI90DmrPKZ?=
 =?us-ascii?Q?ZQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hitachienergy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7843.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecffdeea-6dbc-4e71-397b-08ddc2e6c8a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 14:57:42.0776 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7831e6d9-dc6c-4cd1-9ec6-1dc2b4133195
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +JyNqMW6+iWTG6UzJFWohxiS6qky6y2KfFUONLuBJVRQlMd8d2z5k+t/Mp0tvJrHTeJZEdcg8JlZzaGjpvFjzShpQzelZ6Tu3RP0sWjjznE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR06MB8402
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

> On Mon, Jul 14, 2025 at 03:22:17PM +0200, Holger Brunck wrote:
>=20
> > This area was used for special purposes on kirkwood. On the current
> > designs we don't need this anymore.
> >
> > Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
> > ---
> >  board/keymile/Kconfig | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/board/keymile/Kconfig b/board/keymile/Kconfig index
> > 41458813858..3a66b2915ac 100644
> > --- a/board/keymile/Kconfig
> > +++ b/board/keymile/Kconfig
> > @@ -31,8 +31,7 @@ config KM_PHRAM
> >
> >  config KM_RESERVED_PRAM
> >  	hex "Reserved RAM"
> > -	default 0x0 if MPC83xx
> > -	default 0x1000 if MPC85xx || ARCH_LS1021A
> > +	default 0x0
> >  	depends on !ARCH_SOCFPGA
> >  	help
> >  	  Reserved physical RAM area at the end of memory for special
> purposes.
>=20
> Can the whole thing be removed then? Thanks.
>=20

Good point, I can drop it completely. Should I send a v2 for the whole seri=
es
then or only for this one?

Best regards
Holger

