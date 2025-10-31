Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B3FCCF9F0
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 00:27:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA35683642;
	Fri, 31 Oct 2025 01:27:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="E1rsWOdc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7538B836D3; Fri, 31 Oct 2025 01:27:26 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BC7F8331F
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 01:27:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dk7szA83kqpEE2robYsqDjZ0Ri8alMxjpZ9V98h4GALm3Zm+qJHS7/eIRMc616bVwajn91QxomjM2XceJmPZFS2cZ8qDeLD4A5v8oTJwdDpHivjlPhfqoSMLezdCemrULPoClVQ8hX/AdbFu3cApE8ZCIEwYcBj9GBFy3lwFOSdhYiGk3PokXFmxB/L3/W2ofFt6rmbeV5mCvuqTIQ2SExnw2aExB9iJ0WWZtn7nUqjFiM46Rc2TuCAkbObYz0AAdtpRgkJzU8hP0AuafXmEHkiqsF54qQuOUPG4fvXUKZaBH2a9gkBiztiZhgrTC8CDpLZ9uJZlPzLfDw6Sl29Ddw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeB7Gh4YF8i3Fq2+YnRXo0iJ1xgXZH2qk/boYR+OeOk=;
 b=ENi0+ouNmizT9yeU8XBF5Fx3aVwg3EiPBaVs29d5GRp2/u6/py2i9KfZ3WH1X/QFYf0astZ/6lPKbhtJ9JNQsfrk7nSXlwGl4gTqacQIozTUmG5zCIu0nJDJELZYepCwoEeTPQJluzSRN2RgdoJK72zkZvB+/gIxTZ2sfU7WrzLzBbRSUmjxo5OPeHt0ka0z3szz7/RzhlbuaOzxGeTYwEySvmt2iyWA5Kp9wKxq4yy1GobH0HQisMQbJN7GSXYGUogRMLMSed4PaQIqgZt2Fk3hYhNKaW2Bk/ZSI1XSyepdmAhuqWVWTe5x5hSuFYJZw/Fjn6jH4YwFFRl52T0oEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeB7Gh4YF8i3Fq2+YnRXo0iJ1xgXZH2qk/boYR+OeOk=;
 b=E1rsWOdcr8iipx5W/I5/bMc3B/ToZjAIBTr9rBbdTB8RJO6NbaND5gwyy2U49A5cVaqBfAP9x9g1OUCYjlgLzUmCi4EiZm5hKct+bEgFiW1yGKwCAHd3piEa7xoHOh++VHtu1TlFG4a1M2rZtt/xqUwN5cYdd8nrD2+DHxwm7FyyiIMFv9z2cqM7SfBT1ZONWcuZnkUkTUpDnflkYJYqS1cGNBeLoHU4jNYbXDKcYiDyyMGITjqz0GPTMVCO2wWitjIfdZ0n7elZSJgcIHJbAmII3Hy065xq5PlDQkBnxUwIeRqYAULW7cbFbyBs5Izh4OFEkKv4NT+ZPRJDbhampw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8576.eurprd04.prod.outlook.com (2603:10a6:102:217::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 00:27:23 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 00:27:23 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH] imx8mp_evk: Fix typo on maintainer's name
Thread-Topic: [PATCH] imx8mp_evk: Fix typo on maintainer's name
Thread-Index: AQHcSaeOBvNOi2uydUyO7MZRBOF2TLTbZtqg
Date: Fri, 31 Oct 2025 00:27:23 +0000
Message-ID: <PAXPR04MB845949553B48AA17B6506E5188F8A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251030141440.250629-1-festevam@gmail.com>
In-Reply-To: <20251030141440.250629-1-festevam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB8576:EE_
x-ms-office365-filtering-correlation-id: d20b736a-b5a2-4ae3-f42a-08de181442c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|19092799006|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?DYSO78Cl95hHTYslXbwD9Cyzfl4m0jg9Jx8oUZRwXyHRMebkGlRLeaKqzCqR?=
 =?us-ascii?Q?t5SS/5d3B9fwt26od4cg3vjJBXr+1adD5n+MqqT/X8cWiBMSaTtZWcX0KkVn?=
 =?us-ascii?Q?M5a64rFL3HRe6wJ9UML2LVJf3fxfmpQT0LeHHFoWoySqDeZ16nN060AOyZFX?=
 =?us-ascii?Q?bYvYQauuWPzxteWgImBNfFOHn6vaNIPeKgklX+AjZzBws1lT4BAt32lxzsLg?=
 =?us-ascii?Q?2ONbRkxlGZOL1YOUXZws5h5ll0HHynP9IuCi2mMMkcBTff8zj221F5r12708?=
 =?us-ascii?Q?b4j5r0mJ8SOsdg0BetSdsl7J8wuFavKgIy8Q4NTdPYn6KeXyXjlkM6Ln2xEv?=
 =?us-ascii?Q?tTZs4zN46s0sxBc3zXfLNY46cUsFPATUjfgPMakkQdUbwyX/e/BXW38Mbc12?=
 =?us-ascii?Q?yW/lF3K8RDoYGgsaJumeISZtMRMlX33cl4nY5u5w07H92YQwsu3rpqRCoyf/?=
 =?us-ascii?Q?YNke1mZ5NnsHry8kvVTFai+BzQwCfBrYfs4TZH5yPYtjJQxFbQBtBRrKdMKD?=
 =?us-ascii?Q?cv08IX2C/ad42SRV5W5sSMRiuePPHNP+EQk2jZdWOhp3uaND0DFm5Rh3kC7B?=
 =?us-ascii?Q?Uc+NvimqOMiVlwq7cze1QMnePLywWaEelWCD5qF7PPgtc6Kpw8fMJcrm+JUz?=
 =?us-ascii?Q?8m5YVZ5yk5tmrovawx3BjCippyA7YAh68F1fLusOpDIw6FpAcXDxiKRiJ5Zo?=
 =?us-ascii?Q?HpvVunD54oHu6HfWDtDDjz65FfQ6tuy49sOEivERUp24sAzX2+GFBPcfLmtx?=
 =?us-ascii?Q?/G1LPY/eo3qYs5GljFo+vPVw+fLCnTbAcIUUbXMmydh+y7xc32gqoNdFYeU2?=
 =?us-ascii?Q?WbCrhs31SW0wU+9aJCaxO3guH9qAdEtxqqvco0aIlJQe7hHkZicvrHSN29+L?=
 =?us-ascii?Q?HB0jFqPOWyn37xxoNWhkQtk1BdQ5wf854bpfsgDiZZSLbTgy4A0tSk5gRSVk?=
 =?us-ascii?Q?DaLZzb9gmLP4xUM574e2I3L+HQjFjEqNTpkzGpPt3/R67xLR3/0g7zQBBTYr?=
 =?us-ascii?Q?LzybDMR2aXHveR/XXJGxfl/i2OT9/T5LV5gle4/J3Xj+i3FFNZMeM5Q5h1BU?=
 =?us-ascii?Q?ZUXSaImeROEXIzQqLgNYUmI/KKqKFbab3V0O4EkEXLLhS1pu8AaMAZLh2akc?=
 =?us-ascii?Q?Oe3ivo1wb+Xw49c3VfWP2qvd2AARz6/E0+MZnAgYPY6APEt/PPwO3Z6VFDLu?=
 =?us-ascii?Q?kuJfD+kunBAciNBMeHFBJ9+I3yefeCc9EGPugw2xFC3yPq//zFeyyJKEXufq?=
 =?us-ascii?Q?bfB/fg+3naRLAUVP7eP6hOVXBJPxfA5uSeevG2PG2fum7lnZtJJ/LmUK5muD?=
 =?us-ascii?Q?PT8GR35ttG99e2mer6gRRnl/3OoYJBxr9+cCkUrpClwV9IIyBMAYY/NIW1Qi?=
 =?us-ascii?Q?1nfKszgvf/3J5B3gXNeEH7xjoHhr/Vy/sJcdj3MBnRJtKdm/PPqoG1sJyhbV?=
 =?us-ascii?Q?rL8jT3dCi16FW5kBTgSUM5EMwuPjFKtQ9dVcYmVDSSv8YavfFqcn9bfp1Mvr?=
 =?us-ascii?Q?yDrsXR4D8gT5rIrlknGU33UMovU9JcGrdFro?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NlTIT9rDjtxsO69R8Fjbqn2ZSyW2puwQVlBa9pFXnMjQqk2T0+X3TXQ67cEz?=
 =?us-ascii?Q?7m4PSk7QWsp+PNDbiaOQYigpnUJyB05dxUiUlW3Cl/qPW6Aktr0d5H6eQzUm?=
 =?us-ascii?Q?XESvzuJJAFi+oz7KqacH0iabxVU03OqQW66sy9y2NNBwbQYomYOEICWuYIft?=
 =?us-ascii?Q?+YbLS2PkCF67nXVKUo6EQ5ntpqHzkxRWyCxnUvnsGB30F6WNSomfE9F46FN8?=
 =?us-ascii?Q?KXQi74reipwvmvp3xDN0brPbgrV7COMklkijb9e9HU+jL7uMgOiMwtY+eAgq?=
 =?us-ascii?Q?CzHRKn7Ml1+50sGNGOr92ZgUMOMaTsYIPGGWnV1q9jBZTnYe7ksgawutcBmP?=
 =?us-ascii?Q?+5iJDRq0FiUVZfcLl02UPVtR4iTZUXXsmbTZr9XBUW2NWu/CFlYuOdgxckn/?=
 =?us-ascii?Q?4LteRLE0BoOxNd6EhCBJma/D00iddm+eTxBGDqDc0q15jdx9tqP6XKQri+f9?=
 =?us-ascii?Q?u1KZdbOdRYS9BAkDGHPd34+QLTvbyDfKNgYK8bo4mM2zQCYMWMflj4RwN5iZ?=
 =?us-ascii?Q?/VBkQSNCoU//x7Jcs1rK7Y/boJGU3WefQR3O68ps2b8yQjvptKm7KFzfBKmH?=
 =?us-ascii?Q?jn1eivGClKGKus2aKmKrhw7K5Q4ccw+/+iSMSw+6ENr5FoG/vLN2i1cVjLqH?=
 =?us-ascii?Q?BxMKwcmOea3x875qeMKRaaMGWbN0LsItEt1xT1/bQPpPFB8/6os06r0bsup+?=
 =?us-ascii?Q?AAPQiODczoPdXaa4NRazIl6u72lr0H8XtyvSJ1La2KHJXj9geE3ckKl4yUtC?=
 =?us-ascii?Q?FLjIbiL2Gkd983ZKSrH3sdAdkptj+FQn4nSrNcn/pQ726JeUgJPM8To5WkPZ?=
 =?us-ascii?Q?u11FmClFWj7UPmUoTBf1vl7CrLwGpXVNudg1XZbakHbJxGovmy/0pnved382?=
 =?us-ascii?Q?lfEiVROUQHgrnPuOWG7Ejn3aBzIomnaGQD8xFanSh8iMa9YOKuop+TppitKr?=
 =?us-ascii?Q?C8fJTJ5SI/PFZ2idk1T1RAilqMAEtlgPtBmJYvPJjOdvUNU/C22Huel60r2p?=
 =?us-ascii?Q?YLsL78sfXJyeS/zrOq5kBhkgjTMJG1C+P3m5kvOAypUVx64jyKc2P9ga8NcY?=
 =?us-ascii?Q?g94iCjtV/ZVNAzlUs64OsDJ3DpI+HdK39cLCYf9QYOiJvpA7rf0pOOU4z9fZ?=
 =?us-ascii?Q?ZtmWyGC2ggFdgcBv3wZIdLTxHXga35gRi4HExsdm4SzY+raxs+EHOzb92HcP?=
 =?us-ascii?Q?Ba1fxsHDnJyqGioZxvmcRpoKkt23N5b5hSQjLGx6qMC8VTCqooDMnEVh+ROp?=
 =?us-ascii?Q?U1fawx8JbINWhOwy5x4tnQJXI1psrSw7+wS3NH+Bc2c4vKy4dV2GTp0qsKOo?=
 =?us-ascii?Q?lPiQbXomOLvZTOMj+5NsOsFTkVI/LQpN0Ylrjqa95jkySkyr3XCblJHXCaLI?=
 =?us-ascii?Q?IZWFPCF+RLJLzBjhYIyr8iCgMBK5+6b6eoQfxs4IjUjPNHyFzxooEvqN1aM3?=
 =?us-ascii?Q?qsiurwLRB+DCrFGdFDm3jXDInwpnsf1CPWpAkVdcgctj0USI2jrs+uNnoSrV?=
 =?us-ascii?Q?bJv9k4JKezUqB9biLfdfAPCTLD4NF0Qa/r4vAD+EUw554E578z8732Cvf0mK?=
 =?us-ascii?Q?ZJPWooguMsIZt6fklc0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d20b736a-b5a2-4ae3-f42a-08de181442c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 00:27:23.1700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 74SUkfYeGgYEBfdJmTewUNhg14boj4EC4tEF57g72DVoPe9gloVzKBZipY3hYVDSbqQpHs0nWuTNMXxTpwL5DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8576
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

> Subject: [PATCH] imx8mp_evk: Fix typo on maintainer's name
>=20
> My last name was misspelled. Fix it.
>=20
> Fixes: ae09edaeec3d2 ("imx8mp_evk: Add myself to MAINTAINERS")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
