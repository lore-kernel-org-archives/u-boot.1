Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E47CCFA00
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 08:35:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61E8E82A9E;
	Tue,  4 Nov 2025 09:35:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="fm46OI3V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A652838CE; Tue,  4 Nov 2025 09:35:11 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CFF98144A
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 09:35:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ifuSGLk5ptWfZWFrzobU4P1oq3XpkdTnVoP8ZpZtJbFWWWGVlQ8WaP7snB9JsVSr+RzgJQ3WCnqmktgWi9HfNdJGp/dRWJADpSrWjy2t1QQpGq9ettJVlxp/mtYEc2+QRHyAZ9mnVM6uMAPfECQopJ7ujxi/jMp/DyemC9PZ4vPkuufk6rk7znM3GzxGWYns9Rdry9ZbKSua7BVyCooVlqOBCHSxomcb5cotqOaI66fqc43KOv6CjTYeuieoZulF0mEC+vX5PlTvrOifLrUFF4j3UDJXPUc/XAwXN7pmo/PSzQ6e5QuG+kUubrwiCBuaDxOcXNxDfSlznvdvYPM06Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWEpkBK35ccRdiWAoqt8f/FR3d1QUykhHYew/UxoUKI=;
 b=qx971yM0jH7n0ero5xvZ+drG0pB526whdvCfnGvWEma1IYBEhKjgY1bGroBqJxUwVvDOdutO9bpYcUF+4/qcEJ2J2G9KuGjCUuaZ/YdAAqFE3N8WgWEFs7LXFgMmd4SsMCQql+uraR7/YPcZ1pBxog4OUTO7kjLTA3Q/UACDC9A1iwfTrijjb+4a0sY/oRmoRHjOYnh6TkUBSAKSZ8fpkCH7c5hh6/wE5gowDYLWahEJw3o+QwNP7NxdYms2s7/Mg5t2KgEWxaisl/07blA3Q6bdROQwo5XiMx44WKx5V2OFuLJwJBZ6ATcelSbvQTkf8S34H+vjUTvR1MXJnTw17A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWEpkBK35ccRdiWAoqt8f/FR3d1QUykhHYew/UxoUKI=;
 b=fm46OI3Vv/9pyFHAvNM3dpnVnwiclBsdxc2UlHvm7Cx3rYqb9ib13DbVAZe6o9m+xu4BPgpX+tnJdAY/Ocl39Etho84MpvXjiBRHy3N9ElTCSkOTHzH6uv4b0QF2yJAVvtIiZOJVMcOGfsoiBG/FhDGX1rcmzSfVlGfZDFt/3IU51cD2uKfiGAAYRPnuQ2qYfiyPuxlDraQ3ECGalB1sF34+mqWpx3niT6+dIWPNfBZ6VOIkqxcS3T9e2lAk7whUosZvhfOGND8qQTfPuAlIIDUk0blNsaWukGnZ3vP1dhzEb3pUNXFx7tTMOAeSevDXY9a+Y8ZVWBP7CeqM3VnMGg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10986.eurprd04.prod.outlook.com (2603:10a6:102:489::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 08:35:06 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 08:35:06 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: dl-uboot-imx <uboot-imx@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 "u-boot@dh-electronics.com" <u-boot@dh-electronics.com>
Subject: RE: [PATCH] arm64: dts: imx8mp: Add missing LED enumerators for DH
 electronics i.MX8M Plus DHCOM on PDK2
Thread-Topic: [PATCH] arm64: dts: imx8mp: Add missing LED enumerators for DH
 electronics i.MX8M Plus DHCOM on PDK2
Thread-Index: AQHcTS2odJvmcu8FfUanpqIjyMIOc7TiMV8w
Date: Tue, 4 Nov 2025 08:35:06 +0000
Message-ID: <PAXPR04MB84590C4ADAF37AE45E00C41B88C4A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251104015212.220542-1-marek.vasut@mailbox.org>
In-Reply-To: <20251104015212.220542-1-marek.vasut@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA1PR04MB10986:EE_
x-ms-office365-filtering-correlation-id: e88737ba-edb3-44ba-2105-08de1b7d0e88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?rttYRfEOcx11aYLeiv2acBxBWt+SktRWRWFTGo6FzUYF9rLGpbNzmmX/G3MW?=
 =?us-ascii?Q?mNNG1AY+68o7Z9bZ0E5ZqPBISplPe3supDoQ0t6pQs4LmrZZ/VFMsLg/dTX9?=
 =?us-ascii?Q?Iyky65TMH/8TLRNxqQ9n87A/p+rjCB6dEKZxkSevBPljUIsFDVKxTsGwYGQQ?=
 =?us-ascii?Q?B5ACA66bzhqKmqT+0P0URjeou/NFI3v4wT5++5qZRXRA/zO6xNq9C3Dwlzw4?=
 =?us-ascii?Q?bbTiiqWfMG4XnZ1DVEwQxyjgR8bXoTvNrpWKiDu6N+/L+b4bxRk0zESQvc4l?=
 =?us-ascii?Q?gJhSbNNfF5QGicsdAeEn4jOQrQkmk5rYajfreB0Kh+iSsKnY7CB5ogY89PU5?=
 =?us-ascii?Q?z5GzPJVbBo/bBH6h2U/i3uxiOXvt4PP+OWnlJlBx3pOEh/LNdqRqTlLuAb2g?=
 =?us-ascii?Q?hjTQTxIF7NapxnIHVdMCgxdZ/No+LJx+J2G9qLAiuwDpQthGIyAdE/si5POu?=
 =?us-ascii?Q?B/NLpVWtZ/fkOlalUiPHXK5Dsriszy/4ZOEWmcS8CqwmK+QRJy8hZuCVkXDA?=
 =?us-ascii?Q?O17u4vkccBwXkpuXfDUMRcpEYdxWFjX8QYO4+ZQARHTJVQvQMdvXoqBTwi/v?=
 =?us-ascii?Q?tkab8HuuCuL/XJ9n2w9523lws+a4XZlcE60n1a8a3t7Zs3h2Fa1nz4krxPwS?=
 =?us-ascii?Q?hd+sxrEt5LbikMSrr79PrZZobcSvut+5zuUPHfZp4OnlqfOSu+L71OLhaKqO?=
 =?us-ascii?Q?vshYM9+42i4Mpmu87mZy6Ph8Y+Sm0zsvmJXazuD9HEkAc0uHZv3FyeVgK7Eb?=
 =?us-ascii?Q?grWvzjKe70ULmt40W4NvIoR3trL3zCd5KGeQO3e1zBKOmx/slFG53ydMgl3S?=
 =?us-ascii?Q?Oh6MYMMeyoZoqb1ZruDTQZOSidjSBIIjgzlFDpfIHYVZVtXMcWeBZqYYAekk?=
 =?us-ascii?Q?nSIBBNLh6fdOMhb6EkmltahKFWYtlKmdfWolwctazdKYj8B3in90o6I7Y6O1?=
 =?us-ascii?Q?Q/DEMPiobFBrVAqK4/hToyt0TZ1RcMtCYDwew+lvT1aQaqESV1cMvotCfWVe?=
 =?us-ascii?Q?07KtFiBoDMJbJhMc0yAWs+OHSpEGgigR5IO7WuOSaFKWtH90Opx+pvMIsChu?=
 =?us-ascii?Q?gHhgAukhqhocCIH9p4udGeA8jXiyuya19QeezoG+f/VNOGsjhox9M0cRjpG5?=
 =?us-ascii?Q?IpctyBjOOIENEUQTtb99wK0NwUqB7cVYWnhf4b88kWZVeaMQNYPBZ5njDXeo?=
 =?us-ascii?Q?4V6o16shifQkuuqEG0RdEWAIX8988YbJruQO/84B2+e8/jOdmBs0drNDZsmY?=
 =?us-ascii?Q?iyI6GTdQOlCH7W1cBsa+kDvHbKp5ccASwqEfjALRpwA/VoME1OPAYqSGpTeW?=
 =?us-ascii?Q?gTEj4z+4Vjg+/bUxOkZ6XKzGRy+UyjE86xqLjk48O5OyTmcSPer+2r9kNA6a?=
 =?us-ascii?Q?FwSy7kAXfZgia7yKesuvX/AUu9xy3KRdH37cC+bKkLo2TQDZvFQk3YK/mhrh?=
 =?us-ascii?Q?fzT9gi+Qwlkpf09b5PUIaI2ntqoPCgP9NdqG1lGI/j1EUkQSkwtQKvWMN3Xh?=
 =?us-ascii?Q?1OoSBnxFnivjrRJEAnYIvjwLWcfTwaqIXo1q?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VfNEYwS7DgDsJlLc/3OCTngP3vt0T1ZO4fL4rd+6ZsAe5oNnHYbtUQdo4Aio?=
 =?us-ascii?Q?nv51/93htRtsORbKQ1TECgRlQUNEjGT7CHpyXZ/YNbIRBDehkDh0lxuO7t4X?=
 =?us-ascii?Q?hOV7WZ//QL1YOAUmGzhx4H4pUSlrJ4/6pvuD2pIFs58Iytdfs61jQSs4taVb?=
 =?us-ascii?Q?3f3MPPN+jN69sabcIEvrHalyMCKHCN2cyXYGM9APIs9HSk324DnBho/bsq2D?=
 =?us-ascii?Q?bURPpDsMlho3IVZfgkkCY/PsB7pPqczRs92d2oqeFg0qSIhVqrpJQjGCTHrV?=
 =?us-ascii?Q?QHOeX3exbkmpnCVUAe9wdiSCjTeJwfa/54+fC/BJrN57tbiHmEbfz5KASSoE?=
 =?us-ascii?Q?T4Maj6k6Xrc2gl+j6noa5gtW1o770Yevo0ghqdDpM/ydH9/IIQi6WrEbKpVi?=
 =?us-ascii?Q?WKz6LUROpbz3ea3wPlQb7iZzkBTwDXEhzdawI3onvWAlinYjFFSdGrLtLHim?=
 =?us-ascii?Q?k7U6VI0bmfzKn8AAAXHcpyNQaA01Rw5uiE+RFXf/CoQNvHEJDPt5nI4/rKHI?=
 =?us-ascii?Q?j8qYokO0ZbEvfh3Idlwpvjo9gYPus7piSB/zmrIsplVRA7mqQMlsPYZY9NZj?=
 =?us-ascii?Q?pmmKxAcEIaEAOgad5m3P/HD9l3s5bboPVi9koovFztUt+wxdm4B+/Wo8oDLs?=
 =?us-ascii?Q?nduAJH9rk79faN/hND9GpdtGtMWLNYP2rtxxVAKeSfneEsIG/7sXOKRV5kWp?=
 =?us-ascii?Q?CpK9qcR+mZYmSMFR/l+kTp1hHbcc1KPDVpJPVxg8dzXU+daQtNlxMQufEZXC?=
 =?us-ascii?Q?7CnYC24xV6Xp9JWc5rtytglhFKitLjxEChEvaDN+hLbLnDuVKqbvlHWzUU0x?=
 =?us-ascii?Q?zJD4iNL98Sd8h2a/xk1DkwFhLRfLeC3eLsxTr9KYWjBPfophZJLVVImENJnm?=
 =?us-ascii?Q?DD42ejeZGZkk3gIQv7IBYMwrIRvM3ICROQdu1YKnWb7hme1yh4coIJxUbLvv?=
 =?us-ascii?Q?RDDeTcT4y4o1OTR4DIymp20/aUJEzQufniVKJRTQo/FnCx2hrt7naI1xsBNh?=
 =?us-ascii?Q?/Ab5EfYk97jLAMX3nvWGGPorVDDKTO81gY7bAXI8mPs9hd2/+UAEfCLf2kpK?=
 =?us-ascii?Q?njZVbpMptrSqTogsWJG2HgrzHsq01CaQLTKdAWZcjE8G2WGJ9r3CwifKsOKi?=
 =?us-ascii?Q?LXZtGqMGQpADGb5alkfasdrUzauFche4AD45mamf0NZRmf0KICejB+N1sCfa?=
 =?us-ascii?Q?tlg5fqfr9UpndZts+OmueBUtSPaixg93OsW+5o02//AYwBHGNYUtjLP7GRiu?=
 =?us-ascii?Q?D5JLHZP/Sx3tc4fMEIxomywn6sun9DEvWh4mXLPRthCupUvLdcQvLXkWKn1a?=
 =?us-ascii?Q?tCcu2DLp6VQzlqgV50J339V1rv5VFMOcBXXx7piYA8pcdc3bxBjKd6oeI7tz?=
 =?us-ascii?Q?DPXj1+8nigZSJpd/aOex5Z8od8K0PCTemzdRf85a6kk42s/Zzmv3+bDE2XWy?=
 =?us-ascii?Q?6kalp/RZqAa6oNZZtorvM881UOA0/vm9w1FpMla9tH6IBz+kDPP4z8SWVA5t?=
 =?us-ascii?Q?pz0PJ83F146wGmw2yacSknIkaWY0bm8RcgQWf5U9YUMqDS6gUHrB6sFy4rwQ?=
 =?us-ascii?Q?B/d2npXH5wlsM9aLk/Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88737ba-edb3-44ba-2105-08de1b7d0e88
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 08:35:06.1316 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5PVUH5zt9Ujci35nHBYADS2tlywVvviMsbcG1loUQGV4SPGcx0oXEWxRdFw2jZ3Cbtye52YovJa0M21qZ8foFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10986
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

> Subject: [PATCH] arm64: dts: imx8mp: Add missing LED enumerators
> for DH electronics i.MX8M Plus DHCOM on PDK2
>=20
> The LED enumerators are missing, which prevents the LEDs from being
> accurately told apart by label. Fill in the enumerators the same way
> they are already present on PDK3. Put this into local DT extras until
> matching kernel patch lands in Linux.
>=20
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
