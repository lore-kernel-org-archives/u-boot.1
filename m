Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB67CD2F7D8
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 01:10:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 414E088DDE;
	Thu, 17 Oct 2024 03:10:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="H+vTyX58";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9FC388DE6; Thu, 17 Oct 2024 03:10:06 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99B7D88DDE
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 03:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgScvvpPd7z5J6PESFsJq7YMIx0MOKrno/QlHbhTLfMOK2QTCHoFuz2/rl+dWh6CbxwvUP5tkZDgm99vt0082K0vh9/jjmmsqZy1RpnCew56ZQQV/SRoW5pRb08T0ov6ftX/nxiz0FP+1VZCmag2vVEEwBmUQYc2g+Nw3YLKTw4yhvFyWbJrP7FX06lXpAM520awbwqv1F1JHuyM1FepeCvHUK1xGjSfFRQ/ZonVEpfh0tC/sUFAe7sMBIMMAtGT5qRconk5fliaSageSn2jRwJpzHlLuBxXqQ/T4js6tnjOSF2SXoNz9d5zo5Y2JYfdAfhN6CbcYlNrsX2vwA1b6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/502Wd4ge2kfsiiJQsio/8DCa331ksUL3rPimJs7hI8=;
 b=dpqhW78n8zykMMiff2NwZcqxn4dwM0q+VOJf1Rn4ILGuH1zQ4oi/w+9TYAUIUx0dJiKt4pF0pLJWoo/pkLD8zxGSn4bxUHPETnw74kjMYcGLzkCPKuaF3kJZJUlSfrRVX15Ax31W6AQuYWfUg3iW3Z/vwcJU9NpBIu5haH1mYf13OSnYxSLNGqT1/m+N1dFCacsZShVS1Woo8IFAM6ziYW44v6TJNkhrulSMRGFqtlJfLCYv8mBt8ryrVLMzhzmsyMXW7dcFzKP2vgHeFQaEnLFI6HRT1J49nBB/hjG3XGsFmeF6EVA84A2pJaNI1R4tBgkozA2F3f69nQdug5Y9Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/502Wd4ge2kfsiiJQsio/8DCa331ksUL3rPimJs7hI8=;
 b=H+vTyX58blBHJW/PHl3vcSpvgpE8vu7GGevOvwO4xh/8hO+3qTeLq4b7YqasPyu2u/Edn/Sq9a/zhrMuz6uUWWRRx6d+UYwn287OT5rOM9EnG+dW6uXcvaDEI66ZjGsd+TcaSkbLoYEELsJKhsKu20v3cg837kYkZ+Fmgvf+VN4+TLc9FVQt9lkbMQgVj+ZM+U5Lt5+3K331wdLNBRjyfIyhQKBObO5qrhIl48e05O2/iqXRf3qTVm5U03EOx8unOn/R6wvoJ1V4x1/8P3eaabawbHfRPay8wdjg2Xx8WnY88x6V23RxWa3yz6E6VkerpUeYkZlvQs9CmNJsjD/SMQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA2PR04MB10130.eurprd04.prod.outlook.com (2603:10a6:102:408::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 01:10:02 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 01:10:02 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>
CC: Fabio Estevam <festevam@gmail.com>, "Peng Fan (OSS)"
 <peng.fan@oss.nxp.com>, Simon Glass <sjg@chromium.org>, "sbabic@denx.de"
 <sbabic@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>, dl-uboot-imx
 <uboot-imx@nxp.com>, Gilles Talis <gilles.talis@nxp.com>
Subject: RE: [PATCH] cpu: imx8_cpu: Avoid revision to corrupt device tree
Thread-Topic: [PATCH] cpu: imx8_cpu: Avoid revision to corrupt device tree
Thread-Index: AQHbG8OV2ytJDPNYZkWDYfI8Ze6VULKBxXEAgAATiACAAGYkoIAHgIyAgABqvEA=
Date: Thu, 17 Oct 2024 01:10:02 +0000
Message-ID: <PAXPR04MB845987E412CB6526FAC7D7F188472@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241011105827.7729-1-peng.fan@oss.nxp.com>
 <20241011165616.GW14210@bill-the-cat>
 <CAOMZO5CSK74_TcubtN1W1MpVmTwTmbv_XfhaOexpdvoc5WGb=w@mail.gmail.com>
 <PAXPR04MB845979AC895A90D969E5F216887A2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20241016184539.GF4959@bill-the-cat>
In-Reply-To: <20241016184539.GF4959@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA2PR04MB10130:EE_
x-ms-office365-filtering-correlation-id: a4dbbdbf-6273-42dd-8d31-08dcee486d87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?tFdh/fUp8oBT0z3RXSpGWa0u1jAfo9z3sFO0OMi5xldBnNbW3jRzjqgxJW4j?=
 =?us-ascii?Q?j6OMMzXrxfoY8yvIPKGck9OYXlQAbUidgoV0r441JrvUWI2UYbOaq+Jc+Ary?=
 =?us-ascii?Q?2P2rccdkGKiWk9muKcH4enxX/55MV9ZWRDIUcfxW/tKkxA2fNLquUNjwmcPJ?=
 =?us-ascii?Q?R4Nf7SmvQuO7HtGA20Q6pMB31HagQGP9tajiWHSC96/vjh01Nbpa8GT/2DGF?=
 =?us-ascii?Q?nLeKJYx8aAga4nGoeW0ss8ONx9ydNIYx2Ky0E1GqCf+OUDpUfWWgmWjt5J1z?=
 =?us-ascii?Q?CkXq3wgboCiribxPqDysRdfNVo4mHLSVUiUOyRqfR525OMNTDXns+Tj/Cgh+?=
 =?us-ascii?Q?qJfwJ60un7sElWxKbANNjjSKEUMS9LwVitMAhFt+saq+ikKZ1u/gzP5JztQ/?=
 =?us-ascii?Q?G0W+0DN11g040ULVHmYqeIibcrx9lGkcdB278b8/RgRPZEt8DzrtLG79YxrA?=
 =?us-ascii?Q?ETXk5wbhZGQM4pQAbk6AJgJJVbX6frVUincQbZTqahX4KJECOma11+3dMqx0?=
 =?us-ascii?Q?XTWRQVSgDJfceVqYnziM/c4+9BjpJ+a0UYNxW4Hxbf2y1YPaHL1y3VrYbFOh?=
 =?us-ascii?Q?9hokHZwZLx98DgoO47okp5wVYqGP08DQckdvrT8MImcIhzYHSs1rk0kv1+tF?=
 =?us-ascii?Q?14sayYodAyFoWTkVXf6gZkb49DAJoqndM7TgdqKEoJX3u+tUkWtHWlnnhk4Y?=
 =?us-ascii?Q?HvdhQeB6qielHNgz3kbejS0wpVkcIO+O9awk6ydzp4r1n5RHkjt4acXFtA8x?=
 =?us-ascii?Q?lK/G3q36FCXZa5YS+1OswIEpwnQCd1FAPd6dpIqWdjkY9Gio4OvWrfXWMsW7?=
 =?us-ascii?Q?akh84HX2bcHPmQHp9qtVnQUD9mK0psoQKPZp7vkOUeeVfnVBRoJ3yArWRbMo?=
 =?us-ascii?Q?lRm1Gon/VS41GkG86z/po4YA/E4q1IDXcvbjCEeVN79YLPfuKVOUt3ZlWkdW?=
 =?us-ascii?Q?IfpTgWk9mGFifamhyq6xLJUZEL4c+9Ftqv3NErmvRTe3egIgsd3HFVCBuG4f?=
 =?us-ascii?Q?hZDcHoB3SVXR1czoujQWlIb8h3TgJf+MQ28xu4YuRPkGGaTNDGZO5jOIJTQW?=
 =?us-ascii?Q?zt3pSrA/yf3dQW79deOhxe9Yd8+uRwCtS0fd/LLy4J1V5E8pueRri/gj6CVG?=
 =?us-ascii?Q?SYBAT59xblnrEWnFG0nJMv+5COyU/r+OGQWi+xyjtsc5/aOlvz8dtiUTkmUN?=
 =?us-ascii?Q?e9V52NggOOaRofk+gUvX96makmWZCm+ujlp1okm8Dsmgw+IY58BRdAU84T0s?=
 =?us-ascii?Q?ve8OkBV8Bq/MN4d840hDaDpCJcwtIoYUN2tPqBRFOHe1SptXLDMnwP3sNPxZ?=
 =?us-ascii?Q?SzBUPOo/+tcGP10m3Sy/Gd6e+aLw5DSfSV445sGksweUhjA56142zw+ZjWDa?=
 =?us-ascii?Q?U6KyJro=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+U/1HSihstQtTaCXwU8Rypu7I9yuEirn+NFBE5X0jgNPtibM83b++a07jtiF?=
 =?us-ascii?Q?pTJYxcmN3taYXQ8tibl/ur5i0v0aPxJucrWbe/lJcLTJmaIiUTcFq3DRvIMz?=
 =?us-ascii?Q?51HCTpdktxBqd74GkK4EwywDnj3hOdtIM7eUCYfnutbV7qWRTf5PD2Foc6Dj?=
 =?us-ascii?Q?3P8gP7NkTpH+J0E9xij+i8IQMG0Pp//femEVAaES9lGTh9F8jpyg94c0cCrw?=
 =?us-ascii?Q?9HX2bYpNGpchU0IxscRdPji2eS/eRfMWbUfSpHCeDyCuJ0UfsP4KZQW6GIua?=
 =?us-ascii?Q?0kFIfoB6JAX8vgWCU4xe6xyR+ixIZ8/RYyiehdpG40hhkoGFBRFkIfQvdrgs?=
 =?us-ascii?Q?/jHoTkp83mBHWRxZPL5yzkCzztVLF5Izii13acpgjsRltpMKE8T3jF0YhIMA?=
 =?us-ascii?Q?eKU5Rb18IwRf6r6Zf11kx6g1ppxmrB+wMQylAvCWe4kW9JAMHHayo7kfKM4k?=
 =?us-ascii?Q?t9t87AzIRGK+NBphjrjghuiwQbYphsZoXVc1T6cWcQrHK68GH900cYllA1t4?=
 =?us-ascii?Q?ypYb2MrrgQsQw5w9qIYGwJMf3R2kcsRB1roNLukDhDauHZ90dz3u/Z81vFlh?=
 =?us-ascii?Q?X2UYbNnMCZtPFKlP9JE1FxKjGYJsixqY2P3jwgWeVzkYXeQ4q45agBi53BHd?=
 =?us-ascii?Q?gG8Zs9cD+jVWv9P95syMszxcaHNSy7WBkyzcwGFqxXMTVj69sUpZZPSMhhiG?=
 =?us-ascii?Q?Q0iaWyFZEal78PNgobhyZdqTmTsua4ay99Dvu/SI4kWkx0/6dgWg2CyQumP7?=
 =?us-ascii?Q?cucS4gXpKYJ6J0J6G3OZfAijyEPl8zTJMVTZE00szv9Rbch3GlqTWOmwQ2sd?=
 =?us-ascii?Q?IkRXW+UXczRWcz4P1+WIeKTfIVH+1B6+R6IyFVugv6frnWPNLEOr2z2WRxys?=
 =?us-ascii?Q?CzTDACZUTEadqhHPPtrzurd3/wBsNIopRJoMJpeuYFwg3omoJeMNpFLT2jEW?=
 =?us-ascii?Q?+BkD/l35Q13nQtY0DiQBbezIWnmQWfPPFH1dPxiJAxtbV28uyzaL8wRbJJwN?=
 =?us-ascii?Q?H/bR7Oi1aKHrvBZvqgaSn7lTKlxWfnOGR9Fuw2PKuwj+xPZLr5NIdryKNPDy?=
 =?us-ascii?Q?GPjTwPsrr4EiKs3xeIjXY2IyaF11hXe8MYxtgSzj8qVVC0rdH5S6pOHaE0DR?=
 =?us-ascii?Q?xMGDXlIECXIVOhzjCNje+8LxO6XsE7MYIEC0+5a/cyO8nSAFFn+1NqE/LfE6?=
 =?us-ascii?Q?ZD5nsae8c5lFBR4CjcunNWPoqxRaYFx/whGdmU7iqsEw+eCHf4Y21CEKoa6L?=
 =?us-ascii?Q?aw741fdbfAr6k9w2fWIizZiWxGi/uEtOd4KMYKxVVv0TjhpqAMsyuSBND8ZH?=
 =?us-ascii?Q?6TiPoT8J2SaIaCT34wRPaBQ+v18aLRzkgzC4KsqOYCOnoLyhl/QkZBRnMM1T?=
 =?us-ascii?Q?SIpwiV5X1qZ2ng6grRZEuxeZ6zg4/TFzEisxng1QXICbZtN60l0rQamjx0H7?=
 =?us-ascii?Q?JG65ooudjZXti1iq1ST7Ayvu9cbQAtqQz4i09FIAWaOCK+bU+1qL+CZU+BA3?=
 =?us-ascii?Q?zsV9/lEw0on/Bq4VEviexYrmoDrsYtFZYDBM7enP/kRKT0FAxVbLbELTms1K?=
 =?us-ascii?Q?DsXEDo+OCcpcCezp5CY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4dbbdbf-6273-42dd-8d31-08dcee486d87
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 01:10:02.1825 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DYqnTUVV1iUuYaCGBQz20ytyxEn4xzLRshAzqV9U9jNAvFRFWZgZ76QK8tag3eNNdIvfRL/SQ4/1ZtfQRPeNjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10130
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

> Subject: Re: [PATCH] cpu: imx8_cpu: Avoid revision to corrupt device
> tree
>=20
> On Sat, Oct 12, 2024 at 12:16:14AM +0000, Peng Fan wrote:
> > > Subject: Re: [PATCH] cpu: imx8_cpu: Avoid revision to corrupt
> device
> > > tree
> > >
> > > > Why isn't this padding and alignment with the BSS being taken
> care
> > > of
> > > > in either the linker script or the binman dts?
> >
> > Sorry, I am not sure what you mean.
>=20
> I mean, why are things placed in this position to start with? Why is the
> device tree not already in a place where we aren't smashing it at run
> time? Is this a problem of the alignment / placement of items in a blob?
> A runtime placement problem? What?

Whether binman or not. I think u-boot.dtb is padded just end
of u-boot-nodtb.bin. Not alignment or else.

This is a common issue, bss should not be written before reloc_fdt.

Regards,
Peng.

>=20
> --
> Tom
