Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0F1CAC5AE
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 16:06:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B68B838C8;
	Fri, 26 Sep 2025 18:06:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Zn+l4KUg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA7C583189; Fri, 26 Sep 2025 12:36:29 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 366AF8206E
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 12:36:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gaurav.jain@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJMjVHt0pwTqHRfpRBRhNsMJS3pMhIooozRASI5MKTXqlDL+ehc4x2zCWitlhrhwKzPa64T74qYizOFIqWnNUuKCKnkasklUkA+x8dHK+mr5j7n6zoqUvRXOYhkF2vK7VkCpCOFd0GStAk7KTsGjs4Wy3a8o4CjCaFnYbPRXHQ3Eejd6z78YDU3S9zPo0gte05S8G4zEFEyzxnNiUHQKUlmkQnPgMoBP2r2Kiqf800U8sqZlfwz2sMCgVKiiWurDoyTZkfP69L43doF6T/Es1G/fpwczYeGgxhFxQvrxummhb3NeJCgbkceHfAr6MbIvzIG3m1uxjz0wwvjIEIo39A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/v9Ws2l4MWqlUj6pVnqNTONMwv5HeCgwj2oNK2wfjo=;
 b=PGBYYTBZQODWUbtwxObR6ee05rv0Lu4xMln4bRv+Y6cXSXhvDvlup4Xk/y6pmaJH9dXaQ2lWigJO/ulL+EDpvQCgWdg36uqrrpEtbyBEebTbcG5rHp2a8UQoJKVuPaz0IWrRw7uiJ3FzArcUlyBv77P8mJzd3GHQQ+n6jF+gbsE6TMHcNPe5IPrfqqfJwjSsepMZsvKD+tbxcdlcoYusmDlHjgQBnWmPFoH8ZQ6Pso6Jb7I5VxSkKvAWBd8IqnIlR2sAEzLUjit1fjn37gMvDhw3r5jmVwb+oT1VamOPi9Upeg5sPykF3SIwD9rphvIBYuaG40oMt3TUW3LeiLVY7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/v9Ws2l4MWqlUj6pVnqNTONMwv5HeCgwj2oNK2wfjo=;
 b=Zn+l4KUgzK6IqinFqV+oNpcSTYs0khTsNHsPr/h03YOZ6vMrFuwEQzSR1HTph4SO+2h3kV/RVwrTYGxKwIbvInaG6bGkok2IlxZ7x4H/M9d67ShVpngC3lcnFPmBxE1PclWuaH1iWn9zwxJ/h7xiYvj3XrGfAJ7G5RaNFHTwJczLQnjB0zF3FM2XyqIXAU7eeTYcyNBvPhdG5kTRrqEqV3c70MziZ4gEztW6f9HLmj2jpBg7Q2CTesIwJ0rzppfLHFeStFaL6iPAl16nzjl7W/6eo5YBt51lkmjwGYe3S9fmsQN/VMYfplb98JSzwa76U3X1VU2ghyui4ShXm6A1Hg==
Received: from DB9PR04MB8409.eurprd04.prod.outlook.com (2603:10a6:10:244::6)
 by VE1PR04MB7389.eurprd04.prod.outlook.com (2603:10a6:800:1b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.8; Fri, 26 Sep
 2025 10:36:23 +0000
Received: from DB9PR04MB8409.eurprd04.prod.outlook.com
 ([fe80::1436:d8ba:25b8:1637]) by DB9PR04MB8409.eurprd04.prod.outlook.com
 ([fe80::1436:d8ba:25b8:1637%4]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 10:36:23 +0000
From: Gaurav Jain <gaurav.jain@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Horia Geanta <horia.geanta@nxp.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, 
 Varun Sethi <V.Sethi@nxp.com>, Silvano Di Ninno <silvano.dininno@nxp.com>, 
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>, Tom Rini
 <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, Peng Fan
 <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>, "Baehring, Olaf"
 <olaf.baehring@draeger.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH] crypto/rng: double the entropy delay interval for retry
Thread-Topic: [PATCH] crypto/rng: double the entropy delay interval for retry
Thread-Index: AQHcHkhDXtNuizJfXkivOLzUhM7Ih7Sgl9kAgATKzFA=
Date: Fri, 26 Sep 2025 10:36:23 +0000
Message-ID: <DB9PR04MB840990678ACDDF8243F90303E71EA@DB9PR04MB8409.eurprd04.prod.outlook.com>
References: <20250905093348.204409-1-gaurav.jain@nxp.com>
 <20250923091238.GF31170@nxa18884-linux.ap.freescale.net>
In-Reply-To: <20250923091238.GF31170@nxa18884-linux.ap.freescale.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8409:EE_|VE1PR04MB7389:EE_
x-ms-office365-filtering-correlation-id: 5a1d6a52-5933-46ed-9c61-08ddfce889dd
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|19092799006|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?jrDAQqs5RtgpnhR8Nv1KVvGQT3YNcRHM5eyahmXHb5fvQLF9SKHrhL/GfyYq?=
 =?us-ascii?Q?Vs0wt9iw3KGUY14TLgG+unfPaF+F0HIBZsAi0v1vRnpmkysV4JIt8kmwqDhY?=
 =?us-ascii?Q?l19L6D8hNlru4wmb/u4RSJpHgQd7kuCjqmoOG4Izz5sr4rtWfjvD4hNV6lQj?=
 =?us-ascii?Q?mFocDp+AWxQFa4WTJezbUSXb4miNFafvInFwT4k7fHYk40DK/CGg3k8p0SzW?=
 =?us-ascii?Q?FyAEIhN3RkuBpGllSXxyePptYmsB9QKqgw1dQWzeg71ZCNXxRfBJRpPF29Ml?=
 =?us-ascii?Q?+yBzCPqV0GSoQ1rAtqsQ+4txHuCqCz6D5rA5wFoxGfWZqa4l45kFabz32QRY?=
 =?us-ascii?Q?tSX2LQwmny0r/K/t984uAKOu6d8ckcquRtRZenPCHiDbv02Xnqa3KpA9Tuhp?=
 =?us-ascii?Q?06tMkHad9GZZVbs+VYgHDTTxg2kjy+KVDUEjHGbHkaDuXRSidSF38wI5+HcC?=
 =?us-ascii?Q?3g8oPRRQQ9Iosg6U2FpKVGKgNn0guhGnTXTF+cuVbQGX6l2MlT8JSB6IAAtX?=
 =?us-ascii?Q?dKNEchP2kAsXSQWRXNV4aMk5UCEigCej5HkP+9XWvBk8AibspzBKQmd+k8vK?=
 =?us-ascii?Q?62J3CN0pvNLSKCCK3i+/fD7Ao041eW8MTCq+cMCZ4ZT2TpfhKgNd5kaEg0IR?=
 =?us-ascii?Q?l/nYzK3Xxy+WM+UfDEkHlQjvGzzIG23gBwwPv9Iabfk7IC0ISgQn9qRt7CTA?=
 =?us-ascii?Q?hWaof1L9vzn0njslCedoKzRQsnd1O/dEuJQ09w4owyuB+pjlsyTrXHzAnV4A?=
 =?us-ascii?Q?FphYQxs9rxaNHl1dT0FdKQmWUuNF5afaCsVbCuQULFL/7LC/W0aufhS3twOv?=
 =?us-ascii?Q?kTgNBR71K15eNJUkgqojVCS+7lIBM/ChzYsubVlKx0S2AGEgu1l+iKbu5Cv+?=
 =?us-ascii?Q?u6DSWK7xIHK/U/RkUkjSSbZgWkFFmx0+jbN0csJbFN2QPcZXnNqfWdk6bis2?=
 =?us-ascii?Q?XwszqIVKN5HqUzTIiPXXvkGrHfCHSmk2dfkq8gJSX7DSgs87vJSlslO1DOpj?=
 =?us-ascii?Q?hhuX46JRQbFbNihpxMxjt9EHZgJQ4B70uxO4Rx70Xa+dOKItr35RRftvlk5w?=
 =?us-ascii?Q?sZG7vmRP13wLxSkHMFvt/2z6o+bTVaT7pAdIu/PJwCKTUvB+n150yBkIkmt4?=
 =?us-ascii?Q?+p5Df9B1wZDXr79XVci2W5twE6n2T2wva6e3UrQX3LcdFaDpxRNt8Iwn+w9Y?=
 =?us-ascii?Q?gcdTGPDO8assNluZhYJEORLKyMo0Ika8/bp9Y0I98oFGIXnq8bR8Llo9o1LB?=
 =?us-ascii?Q?nI3oh084AjjzugLoz8jSZv38o/10aUEjCEwd5w1ma8PI0dD7wkvWoQZDcNnV?=
 =?us-ascii?Q?d1NITSLIwC6qmt/JjwhP+l9wuWHbXhdoj3fouNXno+4tU1n5Nn2FLDpFK48O?=
 =?us-ascii?Q?97uNvKzlr1MzrV9oM4tor1yWlnaPUNWJ3aEo5TEoCZlwOb9U6DEw3q3U7H1y?=
 =?us-ascii?Q?enUzdPtusAd+B+avY8gexNsnWSRYofQkL6mE9zf+NexpaKF1gUc0/zBvfDIu?=
 =?us-ascii?Q?vfS961qfjV/TL+g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8409.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qDTxS5HEsOENGoIcMrox0aMSteYM1dMhRip0poWUVCckcYMwnjmx8iwJ5HVM?=
 =?us-ascii?Q?2/9jeSwiJM/HJbewqWQJQkfF9Gs8LLaVZ6uniWAGim817wlCwJPlZVLbwFxs?=
 =?us-ascii?Q?bRNnrMHgE5/66nwB330wPixfs4pGhVpjMH3LxnhA5heGF7cA3cJ+IfQ1S/dk?=
 =?us-ascii?Q?qaT2l3lzij5H6gHbmZDvUiCzRQGNBatrnkpdZDp8wzI+jsRmG8pvXmXNLusD?=
 =?us-ascii?Q?Mnt37RQeaAZzVSce1XtOx9kq6/dIrdejmIrLW3QQ5HveEYJBjBJ5HChrIgRD?=
 =?us-ascii?Q?YF8mz0wLKhSqY+mv200HAOcH5BO95ygjQ/YhgjZ+2p54UjzmPRYeBw+MYHAP?=
 =?us-ascii?Q?CX0hMqGeejy7nBH5VPFPKzFBHQt+IcutHxQ3iN/hzA3IUzAvcsgwcaICF5H8?=
 =?us-ascii?Q?lO1LUCspsHeQgf0c5Y5rVvWXsFVLcT79VqveFkdic5Q78x38XJ4MyRa8gQA9?=
 =?us-ascii?Q?vjMXHdrqRqY2rznkkJ3DG/OPgVrCj7GwDUinbg9ep3JIvvdds1cihtRyALrn?=
 =?us-ascii?Q?u5e3v3bINqPh3RV5oHcKBW+W4buHDICd65MKuW361dv83MHxMIhuvFc7/dja?=
 =?us-ascii?Q?Gwh52QNuC9/4Dg1wQ17OOLsIrFZGmFStv9DDnlVCvUekgQQdRkCiNWHk+tk9?=
 =?us-ascii?Q?pf0K88cAlSqZOXa6L+yM6TgySZpL2bPEux1kXjHPeBC32wqbLd4iz8Cf3ZaW?=
 =?us-ascii?Q?FE+ev83pQktvPd0djwEr+eSP3J0ysSSxAHoAfjRYL2Kh3yMpNacTQMtp1Y2G?=
 =?us-ascii?Q?ZnBPJsFgsW5FWbByaJnPY59OVGVoJruWHni3ugyurb2R8CatEpxB7S5qsg+i?=
 =?us-ascii?Q?dZf0K7MXXZPSh6CiLUXitHnOZhRrnHW2IOyY5KS94O0cSytmykx1Jh3BCd2g?=
 =?us-ascii?Q?e+cwyeOZvUlux7rkqXLe4OG8I4f5oLw56eSYiC6c1tJQEiY56lNt9dCwYEcX?=
 =?us-ascii?Q?RQnJhlevx6cn7ZQlyjJkM6lEuf9JNJqaggwCO6ZpgJ+XZR89RytXHI0z+9DE?=
 =?us-ascii?Q?qLyAOJRd6DBaPTUrIiB9yLly6iaG914o/CuNrHtQKPmZFbhSFIntPbf9NhBB?=
 =?us-ascii?Q?UfCVrULurAn5JMYSUwemu3LKy/XdvFaOGNlmWZn8sEBaECx8slu60ejZTgJI?=
 =?us-ascii?Q?6GPUNAVUM83DwYAAlZhe34jB6B5OdKq2YgtbIdfb+g014ZTiZCqUP7tHXnIB?=
 =?us-ascii?Q?6vs0leyGshK6UCYSjMeK9k/ldFn12Xd9QbaXenZDevNF38YGkXs1WcOOJq9I?=
 =?us-ascii?Q?Qtn2dz6QtCk9dD2qCGaUjUSPNhHwY25kYT2+EY9Z9evA27B8u61iYsF6yNV9?=
 =?us-ascii?Q?tyJpUFIACxr2j6BYsBUCMHcIY60yRA+bIRmQNVKmjk/eoa57zVUzWTqgM70A?=
 =?us-ascii?Q?cnkXOAd1K6ZZgYD2oiK2EAEfvh1qKmEr4j+DY5FSK1Wk+cvqXhBnvfEyM8Uo?=
 =?us-ascii?Q?XGMH+Snf2ZmWpsMq51jSo/Tz9fHqYGbNHSTsbSIO91eJWicfaksxLZBouyRx?=
 =?us-ascii?Q?Q1dz/D+sIUz3WCyImGo+Zg6WrRoPL/kkIIpSXLGT5ZHrHByfoXgt0fnKqVgP?=
 =?us-ascii?Q?R/+++AOueXpNknlH4B/HvcWHWlo31mL3CK6Landn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8409.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1d6a52-5933-46ed-9c61-08ddfce889dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 10:36:23.1975 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ok7dBU8Sq2QF4UriTw5HOSeVnUwXyR4nK2EpsIqZPhKEu7/HA9ZtPAlnBb1O+8R7OFfqArq6x3vKX7Oe2NAzZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7389
X-Mailman-Approved-At: Fri, 26 Sep 2025 18:06:11 +0200
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



> -----Original Message-----
> From: Peng Fan (OSS) <peng.fan@oss.nxp.com>
> Sent: Tuesday, September 23, 2025 2:43 PM
> To: Gaurav Jain <gaurav.jain@nxp.com>
> Cc: Horia Geanta <horia.geanta@nxp.com>; Pankaj Gupta
> <pankaj.gupta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>; Silvano Di Ninno
> <silvano.dininno@nxp.com>; Meenakshi Aggarwal
> <meenakshi.aggarwal@nxp.com>; Tom Rini <trini@konsulko.com>; Fabio
> Estevam <festevam@gmail.com>; Peng Fan <peng.fan@nxp.com>; Simon Glass
> <sjg@chromium.org>; Baehring, Olaf <olaf.baehring@draeger.com>; Heinrich
> Schuchardt <xypron.glpk@gmx.de>; u-boot@lists.denx.de
> Subject: Re: [PATCH] crypto/rng: double the entropy delay interval for re=
try
>=20
> Hi Gaurav,
>=20
> On Fri, Sep 05, 2025 at 03:03:48PM +0530, Gaurav Jain wrote:
> >during entropy evaluation, if the generated samples fail any
> >statistical test, then, all of the bits will be discarded, and a second
> >set of samples will be generated and tested.
> >
> >the entropy delay interval should be doubled before performing retry.
> >
> >Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
> >---
> > drivers/crypto/fsl/jr.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/drivers/crypto/fsl/jr.c b/drivers/crypto/fsl/jr.c index
> >8f7a821ebf3..07d336c074a 100644
> >--- a/drivers/crypto/fsl/jr.c
> >+++ b/drivers/crypto/fsl/jr.c
> >@@ -642,7 +642,7 @@ static int rng_init(uint8_t sec_idx, ccsr_sec_t *sec=
)
> > 		 */
> > 		if (!inst_handles) {
> > 			kick_trng(ent_delay, sec);
> >-			ent_delay +=3D 400;
> >+			ent_delay =3D ent_delay * 2;
>=20
> I not get the point on why need to double, would you please update the co=
mmit
> why not 500, 800 or else. What make ent_delay * 2 the best choice?

The typical reason a re-try is required when the entropy delay value is set=
 too low.
Therefore, when the re-try is attempted the entropy delay is doubled, thus =
giving twice as long to generate each bit of entropy.
This is done to prevent having too many failures.

Regards
Gaurav Jain
>=20
> Thanks,
> Peng
>=20
> > 		}
> > 		/*
> > 		 * if instantiate_rng(...) fails, the loop will rerun
> >--
> >2.25.1
> >
