Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A2DCD5BB1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 14:03:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2720C846E2;
	Tue, 26 May 2026 16:03:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="idU1WDoY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB9E7848CF; Tue, 26 May 2026 16:03:03 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88238846BD
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 16:03:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGQvy3My5MWife16LoK9iNxxjOVvEytUOMFZq9d1GQLwNkmRNXjO4HABpcpGOJlQi3uhO7VqaS7knohMR03VW271DD2m+DyKwqXbKN9XbNAKQ9RTfqYCyP2ZuSMVY8qBUabHWVGtDtdKA/R5rJGEDuuVSvcHkYzL53rcTAHHQozPf8sVG29ur9s/f8rtcTgfgd+KhrrO/GK2FQLcXaWk7NuesdQasddz8r79c6UaWoaKDSN5gQdBg6H+V4p9KgpKQqrZnzMiM3MB4Xq6QiYXvPcEnZ6v/yN2deMQK0LOifaE7tC602hQC/64yH0bQAJtp72Uz+23brpv9RDSbTBydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1m9saRnrkIWCIQZmo6gpfqH47S8bHRFzqC87G9h/0+w=;
 b=oIMs+zUfyaKMNDmIZyDbSOv/a1IqdIuoL0sTHRkt2tt8R5C8hcRoJsAsRaFMi03+22FZ7KV3HixjCzxtBfsLqXa3Winckzs57Ul3CsCyoHujf35pH7+BM4U9n6Xe6S9F+31z8Y/8k+oiS2lrwrFjLrtP8s9titACSD51AlbB5BSdHU1mA93gz7AxirDGJHfZuyMUekmq5Yi2uRN7w5voADRD2Zz0dqZuptj07iW5IvEqPn6SiDJ9xqehXDbwAMDQQYva/O6Y4lBlA77cCK3+l1xBiM9wybvVur0YayTeGgfvUQEqhLjVAR2f+YRdECXCL95HO03Ia7QcxYClA1tumA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1m9saRnrkIWCIQZmo6gpfqH47S8bHRFzqC87G9h/0+w=;
 b=idU1WDoYkhKHdH4no4Op16QY3MtgrtDHn5HnBXK5SlhQLFx4VW3OolaJWK5+0hnErq1326Vt20GeKzATm3s5CJK+xOeNZVtwTtLUpwCZDNrHhlRf97dbG8ui7j6jrf6BCrRehyRRBGI/KnSMnUGivOVByQHPyjq+CRclLYfUWxwNrxgvTfEVcDJ1y/2MFJKLekC5xxw4TH6bMy6YEc6o0oKmWuw7oQ+hn5+jW7H9fvzhYYitocOt/686Gf47xT0k3y3kRBpFusylfcGrioXQzqYnd6JgDm7EaRTAbkuX3tSiq+A1BfQVIaHo+GuW2A/q2S/hasxp6IqsV603CcZg/g==
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PR3PR04MB7402.eurprd04.prod.outlook.com (2603:10a6:102:89::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 14:02:58 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 14:02:58 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Frieder Schrempf <frieder@fris.de>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Tom Rini <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: dl-uboot-imx <uboot-imx@nxp.com>, Annette Kobou
 <annette.kobou@kontron.de>, Eberhard Stoll <eberhard.stoll@kontron.de>,
 Oualid Derouiche <oualid.derouiche@kontron.de>
Subject: RE: [PATCH] imx: kontron-sl-mx6ul: Enable I2C support
Thread-Topic: [PATCH] imx: kontron-sl-mx6ul: Enable I2C support
Thread-Index: AQHc7Qn6TvKe55bHRUq0V2/CYi2y8LYgVobQ
Date: Tue, 26 May 2026 14:02:58 +0000
Message-ID: <MRWPR04MB123306B9D1719385C5ED38A04880B2@MRWPR04MB12330.eurprd04.prod.outlook.com>
References: <20260526121934.828310-1-frieder@fris.de>
In-Reply-To: <20260526121934.828310-1-frieder@fris.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRWPR04MB12330:EE_|PR3PR04MB7402:EE_
x-ms-office365-filtering-correlation-id: ec2dc2f1-be03-454d-5b97-08debb2f7e11
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|19092799006|11063799006|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: COjUeimBZMyZ34m2s9Yh5JzTsTx7eDImhliZlKomisB8o48fOnZm4S4m/SUbS+44bWo9wQNwyb2vTuunPNPjHRsZ1EBf5bO2BjlXhudbP0420LBv5hyvdI9Vq38dJebo5fvEDJjxEo9/bDd1oqQ1d7V8jIrvxdycKl/qV+faVwew9jQyYBFZ+GPGCptKiLPadgcVVznpgFohwqHBMvVfa7WwcMNPukDq93TYlMvJ4YpjGsSmGkncDBVPdkfsnqnf/9b6yQn4tFgclzSfy7p9yLSSZgEgMs+5lHbXB/dNfksnbIMXuZtlqDIPMZ//eOXj55xled36IwsYffa/iex4dcShJZAK3BFJSRDIq9WTEUjntqneCYhXOu/5HI2/6Q641NKL4Zmeq5nHcwFNFOzCQcygwq38iAUVy8TIVPm+DhX1H1VD4QuEAKequDgQcCvs+GrBu0fDPT1lzAAyVHQlNvy7v7f1lHhKd36QYsM1LyVqqwZfQZ1pMZ7TeZaNfHC3XvFQFCOldlxFUDOZUc7YIcvsb8atsg2a/nsRrqet8u9iqcdhy3XpcHaW8ixzMdR+3mR2xKh9FwgZwTULtTyeH+YL44ixqzFALEjEA147rE82ygH7aAS0Av7BOnwRJ3oohNi1w8HvPgG30t1NGzfgFIEqS5TRsOxIEas0V5zyes8zmFSYV4vvpyoJqRYiGsYt8d9MJWwAEdunx0awD2TRnAN6+7qZ4h7Ca2PHy3QxAvR4nZ9VF1f8iV74uH9CTnhe
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(11063799006)(22082099003)(18002099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8/D63kVYGI/xBg5Won866RF056F6zD4LD2vWkQyykjOHHJ4Gw9VYR/B2o1kX?=
 =?us-ascii?Q?evLUEZpXHXvMd9frtM2zA1LF2Gg01mHcc7/di8v5vMr1brVlAje3vZuJ2re1?=
 =?us-ascii?Q?zkbuv8OD/awhiSn7KBQoZfRbuX3+itv1BqN/sG/4ck1M4RrfHhCWAR3lQycd?=
 =?us-ascii?Q?qoCACpX04VPyluSErAH3fW9CrlCLVVdY7ctZW22z2jOTEyoirA9GG7rmsBYJ?=
 =?us-ascii?Q?ai1nYIx89FHZWJMywqMNSO81Uf+rFaryFNK2s4Ce6sIeTMxLQCtmJdXGpBo+?=
 =?us-ascii?Q?2DRYgvlw7sKZsmItVG5ik+KXqAA8BsgBZc+9a3xIP/C2gOED2Lu8Eu1TdDBO?=
 =?us-ascii?Q?J3ap9nUMpt62QTd2HuRB+pZ4a/4tEUtFN2vdwaBNxCu3pKKElMZBhXwjszD7?=
 =?us-ascii?Q?6Y3QW0au0M+ZYCzFxmsQhamYKjW/dKvbe6ffrf1/H58A5Wb8DO80JRz3rQfx?=
 =?us-ascii?Q?oNi89XiU7d0kDfDVal3L19QJQReZ2+QdoO3i31mrQJEaghymVlqag4TbmmNJ?=
 =?us-ascii?Q?612UHszpRGgmombEX/mbSjwig8briIh7ACKM34u+nAwgulBe0J1FO24/3d46?=
 =?us-ascii?Q?r7agmrbr05MS78q4ERpAz5/FaFDSNM7gCeYqkXRtDDxr1x0eZ0TyTTz99zBc?=
 =?us-ascii?Q?NOGfR0bRavWrl1BvOSZ5FPTc0BvqnfIvftsn3Ef+dVr+KSesDrtgA08Wcw5+?=
 =?us-ascii?Q?06i2j/pB/kow7ZsHjjfBpHt3IMvs0iBm47e+GOCU8t0ah055uiLLM6Mtgtp/?=
 =?us-ascii?Q?dFAQDE0rxzKC8oq00kyhrpsu7cm/XIIuuOeGB61Ddmr2KNSKnVzXMNPphGda?=
 =?us-ascii?Q?Rau+RO+nfJbSMe6XMiz0k7djmIQ8suOUJk0VTO+C89DGEL/t77XretWJXPVL?=
 =?us-ascii?Q?ZcUyCndozZ4RfkMr6tlBxtD8CrBUhXqFTlLeWI3pYSwSCRzgvGtFf3iSeCQw?=
 =?us-ascii?Q?n7Mn3EES3PJ2fUHnKkOylP1PrDc7lUOe9T6hWx1Xnp0Hk8GBZXIFyN4cXXca?=
 =?us-ascii?Q?zfMwyWXvyI2scgfwjKOsLpRUwP0W9pPYlY1biZcGQ1LtfZaJD+HXrAv42pk5?=
 =?us-ascii?Q?cWwTdEmwWf278pmzHRl6sKPZzy9Jf/4Xc856zjTpHr6zCpP/wjieZI3Tyv9b?=
 =?us-ascii?Q?SMcMbG3Hr5l+g7isjvZOWvAPq8EPp7YvizcG3nzfNhDZg084tMRwt3/q53iH?=
 =?us-ascii?Q?6SUzIRZsWK+jbvDgRifqCovllLe+6VYmOFdW9FIYBDN6g2OAB6hESNXPlVtY?=
 =?us-ascii?Q?RCGHYV5/etgU8qttSrD5+182tz2Gr+TCaXbPg6hp0mtsxguvSfOk5rZNRjGf?=
 =?us-ascii?Q?JoBw6XcXpmnvWrFvbPBPEYsebiUdfrpa1gJygWCql56CzDZb0FDeYFNI4uM5?=
 =?us-ascii?Q?fczc1bAJgvwtHX/Ef8qC39XBHQ7RijQ0xzrwAJe0BqFck57fnDxQv5WuiGRG?=
 =?us-ascii?Q?xRbs5NGhPBTwA1Dpr3p+dWS6e3bBN5ifVxpYIWbbgzZtIChg7i+HOGSj0+wm?=
 =?us-ascii?Q?Pe5xINhxy4GXFPjNZN8zwKPgovLbkXNDnyecTpcGEhGgZkRKTcTPZv0fsBGT?=
 =?us-ascii?Q?ZDz2zpLTuoxFlclIIFAcAwstgHs57AcF7LDu66Fk5ov2vwiLeYSoBDERaC13?=
 =?us-ascii?Q?5BCBPXJfOg6AQCkXirS3tW4tFZ7NtKZJqDm2RIH9U4c4lgtBURbb3xYUSx0s?=
 =?us-ascii?Q?d3fLo5QAjzHwQE+uKZd8tDqA5kSMHP7DNcpYktRfXUSNRieF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2dc2f1-be03-454d-5b97-08debb2f7e11
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 14:02:58.5730 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1deRUSeTLLW9rAGQDnf2RkCQFGZ5CO7EIfYW32UwkwhhR10NfJMgTlkfukpFPCgtufEAl0BWcoSs8vt5yntpRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7402
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

> Subject: [PATCH] imx: kontron-sl-mx6ul: Enable I2C support
>=20
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>=20
> Enable the driver to support using I2C interfaces.
>=20
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
