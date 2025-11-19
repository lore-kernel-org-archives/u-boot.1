Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE76FCF34C3
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 15:19:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AE0F83F7D;
	Wed, 19 Nov 2025 16:19:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="hLWTCwPT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 492E383F80; Wed, 19 Nov 2025 16:19:29 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55FA783F50
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 16:19:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDSM/tfGo8MLQMtIRvSkV5dSCnNwuIDBpuEaZ95ClJrzjO7ErvdcDXlFDHqQBJ+0J6mX/HxKeEiBUzv1rqq1kD5Hb5Uoj3iA+jaetDA7nR2hYVlYSb+FD+l6xczFmaQRRiC5PGx+p1275YnJqyNHdAyZNLAQHrMy3F9Crw2nxwgmFn0LrOIjHOGp12RNyrF5AlSgNOIftF4SAx3EP6HBaLXBB8Bz6E5L0X2zKTG0pQl29/WdC7wJ2T7QXQtv9pMzARlWP4HyDwX6NpOhNXl/twUSPt9+Y+IjQsjcMtDFyk9olvmEebFy5yAVfhfW3d6ji3tBEnQgr6a4YsHOl0WuZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCnhcjty4QTklQ3xpyKvjdSrgWkLIECDRGhNZ28Ja2E=;
 b=ZaPZsxh0vGdiaTagZU9cGwNxrmZtk+vVQJlu/XV0fxCinQVanGhC4zNc2ThLo8ib1a0IG9Rvb8AQWGQI/A3RDU1xfvLRkjc7BAElpfv0PDQdZWiCJyENkQrZwjwfSrjsTIly1auzQ0RQIGSLH3e9ph0DB//CVukWEzcDW4q0NkpnPIdPwbXFOY7Sg1DiUKx5ZpZVTs2mTnPJFfz+aO8iT4dkvEaGxSdkZnhUx7PRAG11M6xR2lJBuFsVhU8Mih9zD3hlmK6FgF1zEKcqNt9olAEi2jcjivyTheV2z7LLkApfaguG9iNvCNRP6JN8Rt2+xfr/m4RFS0XXnY36SZaTrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCnhcjty4QTklQ3xpyKvjdSrgWkLIECDRGhNZ28Ja2E=;
 b=hLWTCwPTt5K30VuHO5lrAGIjNEio5UvPjEInIFH6a0qNfCpnzsnaqQGfRj2Xdspbrig3c6M3ZPE+BN7HuAguKtbtbjNbLYZ1Re0dFEIdJW0rNDhk/qVIVzxQv2MY1h2lZGnT5xqtzlKKAvHGegQxNVBQxdp28J/2Fi5AmTU3AHumPIEUzz6W0BvH1MwB36JJv2KqpCpPlp91KaMaLBab1ALtmWdWOy/5cfWii02WNjjUBVch/0qUELcPOL4wnA6wiGQo33Wlpgd69HvzzOkWltZFSzVKZvIMufRxcSG+Y79q95V5e50c5M1Ggz4gTVsK/w3hHrvNiaidgG/K+d9E9Q==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8619.eurprd04.prod.outlook.com (2603:10a6:20b:43a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 15:19:25 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9320.013; Wed, 19 Nov 2025
 15:19:25 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH] imx8qm_mek: Stop disabling device tree relocation
Thread-Topic: [PATCH] imx8qm_mek: Stop disabling device tree relocation
Thread-Index: AQHcWWPcN2iD8eVhRkSNlV8zBVCwbrT6HNLA
Date: Wed, 19 Nov 2025 15:19:25 +0000
Message-ID: <PAXPR04MB845959CFE23583F843DFCABA88D7A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251119145028.842128-1-trini@konsulko.com>
In-Reply-To: <20251119145028.842128-1-trini@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM9PR04MB8619:EE_
x-ms-office365-filtering-correlation-id: eb055eec-e544-4082-9409-08de277f065c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Yn/b1O7aObEhtls+QoBROmHG4Na7lcGNPsuDgNPBYQBzShN/TPYd569/J8Eo?=
 =?us-ascii?Q?LAKR8xCjnrOz8JNveeEOBqBBDDr8lq13pwMDOsrFAF6QwDXseXLEV05zv9Ma?=
 =?us-ascii?Q?mgz/uiEyhcitfocEtlGYhRK/K+EI5/Ey2sO8o7L9dwTMYjBVk3YN2vF6p7bF?=
 =?us-ascii?Q?F7+vcl5I1OFg1n2xKj9jqCf5M6Jsv/8dFOGnZ7NbJjX5ov6cswMofxT2y+2W?=
 =?us-ascii?Q?G4NjLj7cd7Wud27oi8B0TFUZMa+CbxU8KbaGebwkpdHOtDKNLhDXXp+lg+/9?=
 =?us-ascii?Q?LYAyANbGcYYGxrRiFeraRa90M0iQ2rmEE6IIRheBY7mpEyTBVxJ4c0VLPfge?=
 =?us-ascii?Q?bn/ch2c++CjIcrSbxCZARmKf/DMZkcdvh5cMJvvQonUaP40oasr7Y6ZHjcog?=
 =?us-ascii?Q?QQXmY+X1y6/M5zduhMvC7nv1SVIg9HLGCTha5xxCoKQVLSe1XDeB3wHhgi7Q?=
 =?us-ascii?Q?8r9olXK8hQTJmcutOjj5OJXue9EkiOPJi32gXuVtcVVKJun+Vm38zuAd+dk1?=
 =?us-ascii?Q?PbWBYD7u49E7AYJA75qjEWKeYCf+Hj4T1F0GtyWOfA5a0frP1f6ZySn+8p+k?=
 =?us-ascii?Q?/tkXBTzAQEwqgj3iVAzBJotnSsGh6KOahzJZ+uT1oA2WJS2aHjb8GvgB8x5G?=
 =?us-ascii?Q?Nwsm27mNtMhVUMYf8JB59H9XQTtFtPeosP9R5pSsfmqBoHOfRN+9KUulvvLQ?=
 =?us-ascii?Q?JnsD4/fOmDWXLDY8689O2KwvYewIE2j63T55eVsqM34/AeHJ9dEHfcS8XBV7?=
 =?us-ascii?Q?a1OGjn7hAKhhFO7X+wJyGLzwW1hR8irk+mD86kq0VMF8u8j4TWPIGPAMNPSV?=
 =?us-ascii?Q?VIfKHKwog0ycR+PeSSbuyvlcLxeaxrLsGgUTgerTqTJvDyhCUA/j4CdLCj5I?=
 =?us-ascii?Q?7kJubJ39RzvlI/+OSUkVZwBiz4fOmCepbN8v5syRDy2Ska3ix+T1h1yN0s+U?=
 =?us-ascii?Q?wY7MtHgg+3htQ8OjMSEJUr+bHEsSfr4nYm3rad01RIZEPuMEeMHR7rFUc504?=
 =?us-ascii?Q?oOJHREmBZqnXwvqmX1baggsuWPdrZEnqMgFV+tPCrhOwJ37aZNPJok1s99NL?=
 =?us-ascii?Q?2nvw2JIiYecnyP0AA7/mEC5znolGOXki6SG2gPm627Mturu809fBnuDeQtWc?=
 =?us-ascii?Q?u9W8T6lcaRgxnPvHrokOLxwTsvTd5ZeO4rtgME76v5oqxqM78ewgxpX5kN2+?=
 =?us-ascii?Q?kQPQFgFTBojGKLoqMFFVaomlNdGhwJ6oKxb7cmvD1to9wh+oWNFRtMPtcojT?=
 =?us-ascii?Q?+2AkBbWJskAEQ6nFlI6ez8BluQOsnYkD7DmSixZKlqr6ttXzB1q1OG8ODpCU?=
 =?us-ascii?Q?0lmlEjh6Y3gantqTk30eQVjMRIOvD7I1TySCWa03KhQj0P5oAcw/ooX7Ewnf?=
 =?us-ascii?Q?FDMkCcytYzLqtKmFFTFcOGosGeln9TVd+D9W0NjttvGBz90O/f8grB/i4xAj?=
 =?us-ascii?Q?m3eLh7+SVHQAhQ7e3/h+DqEHyNvXrlsRFSZbK49BlAW/kh1MoGpVETAj9ylu?=
 =?us-ascii?Q?jyPj/8d8VyZfFG3B6AGa3xheHet6tnKOzg1k?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lepsVoor02VX0SO/vzl11SoDVxbhgG2z7dlzdlPOaxmmPIg7MoC6PfIBPAj9?=
 =?us-ascii?Q?XAz0yory0p4jlRwzg0NHmJ/7TJaaWn8ewahOtypfGv2Pq71i9e6f8JNjQ6eq?=
 =?us-ascii?Q?q/lpyWL2mDSfaNuv7HwFefBjanuzsAUoMpFbX6TDtthb8iICboVisKQNP3H6?=
 =?us-ascii?Q?1NJ/hU/iE/if3nZZd5OJ6JEK1mTVLmb5KQS8od5X67EveYVqC8wH/2lErLie?=
 =?us-ascii?Q?YN9KM7tSd7zy+w9sNxgfsvNsLz6xMLsOpqpS63sxPP9A1IPdxme9z2uS87w8?=
 =?us-ascii?Q?Q/gRdJ1aH5TsbsferChXfjN9CQPUa7RkZigCtrL5J0q03SGHOYPLZ0tnKUvS?=
 =?us-ascii?Q?b31EW3N4Jc5cm8eS+2mAbdcPGuq6JlOo4ZGEtpiRmCC0iFx/0CqFe7wYGxBB?=
 =?us-ascii?Q?SOf4S9/BYykAKCIjFXs/lifVfwCG8oTDORoCrmKgk7xgSSxkpJjK25sBzKvB?=
 =?us-ascii?Q?RJbPcztusUeUZ08g6jqcGhuWH+9MOLZJjKqJ8L9/F077icoTD9H7bmSSRapb?=
 =?us-ascii?Q?FTGQBT0/IVkihbxVtzfndnPtQfhaVnp++/YPnSj2VdDU37bflpDhXOLOwUNg?=
 =?us-ascii?Q?02tkrT/sHl5FWKdHcMdPZ7fXiTc8sWCviqS7SKjaX3m/rnB/CAde7o35JCI0?=
 =?us-ascii?Q?nAn5W+nIHNXM8TIvEc59lNXyr8o7QVLUmDZF3xOB7sh1g01jIOgJGZUw+KYw?=
 =?us-ascii?Q?e9r00t/LPMCdbhkuFzXBrxwbldivXu8Xp0bQ15OddWeg0qVSmBPektuEdcyY?=
 =?us-ascii?Q?J8wul3FLkseI2AOwmcIMXHqRd1ROBWbelPJS8vS42aHMK5o7pMNHqJIZxRxG?=
 =?us-ascii?Q?yo9yEXBySQbxXSs0wf0knfz8ggc6ugGTBW75OXakITm/xvXogqBv7n32XWlG?=
 =?us-ascii?Q?ej2TLjYJtzsRPAGU5slblBemvvM3YkbZZG7VOBNrkVsQtWOmaHxp7cSa/lH+?=
 =?us-ascii?Q?Arfvg2NTR+qtOuGqSArTBvHMXNsd0PDbO6+C9hDa8gaV9Bo0RGI15x3I8+bp?=
 =?us-ascii?Q?Xt9E0HQ5+/vnwOowhTSASrNzIyTqoMpgLqBHhehvI3XvDMpW5abEO7g679hs?=
 =?us-ascii?Q?2AgQ+l8GF26HHdIVfmrV73UHTyDSIbfdoRbLUXtlLJYs55O+AqGGTohOLlio?=
 =?us-ascii?Q?+uKNb2XWsyd+6P0kZ/vDZLU4HTExt3Asfo/IFqKC+iOnlDr9XVWOWNdo9yg0?=
 =?us-ascii?Q?J7Q0XvGa4JhTUs20SJrfSOkjrc3wUfSwKMRC+NN7MDDJMn6iOm4qznUvWCkO?=
 =?us-ascii?Q?KN5ww6BP7y1fMf3GLl6OdReDrGfHVFkv/lhWVrRqZYqoW94jCO88Iu63o1o1?=
 =?us-ascii?Q?hVzok5sDv1Hb46bLqJ14bbImjiw1c8Q9DtYYRZM3uKS8g5fMfTtlimPRiFfQ?=
 =?us-ascii?Q?PjcMktsMeHskn1bs3Nk5DZ5AnxfCE2psfkbPNVyR1/ZdsiUE4NlJV2XGjTYr?=
 =?us-ascii?Q?wMrMExkguCMNicAgErzVeOxqEQZroub/GkZw8KiGpfMnX1YIGzTn6xGGr9y8?=
 =?us-ascii?Q?vFGgxBq8tKUDSCGdW/4qSQt24HYMWzX3KIiSyXM+od3W7kudnD7TU9N+WgWB?=
 =?us-ascii?Q?iZgDMcjgJWXxz374VpM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb055eec-e544-4082-9409-08de277f065c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 15:19:25.4017 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iqmBfU2Bjur7fvgOISo5PwuyIgiai4ZnSBiaxKNtPxVfL8ve8svcD1yfUff1PTbXNN9TJ4XETVM+6caFObLrHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8619
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

> Subject: [PATCH] imx8qm_mek: Stop disabling device tree relocation
>=20
> Remove setting of fdt_high to ~0, which disables device tree relocation,
> from the default environment. Doing so prevents U-Boot from
> correcting problems such as having an unaligned device tree and leads
> to various failure modes in the OS.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
