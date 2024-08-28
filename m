Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDBDC5472D
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 07:41:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27681886F9;
	Wed, 28 Aug 2024 09:41:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="oBGkZuHd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 429F0886AF; Wed, 28 Aug 2024 09:41:55 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 681E1886F9
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 09:41:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZlmsj4yEAx7gnJSIaurxbzZI5s0gbMHbZufLD6CAYE9jw/bKZo10S+Wp8BcqvMfh8QTjrO0kpPBQkw8NWWhyN80YqCGepyu1OF/G2lT8G7o1ASaOPuRsGujoPWnuVoFW2iNmBvIyLkjrj+7NFfuw4hDM8oD3M6LePU4yAbMkNgcP4knkcU/rTCyow620uo1jEbmve2xYlOAoYBjvjmi/jqvg3oyd4hjOQ/Z9IMAhsGyNeSnAguoCgMf2XKxWU1f3hqKSgaSkZ/JNAZaPj5kDYPtnux4jli2bY/1Wh7KVCx2GW8X/haxHlkOshAEIS9QWGXgRmgKM3WiWMuN+7neFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4cyZ7QxgWPS47joz71UE7vQImhITIor1iynjitxqRQ=;
 b=nOTvPo1E49RA7N8kaW4Vs9Klla8lFdBwX/aK5/8ot9uIoxizQeowEqNgt6GXZEfZ/zXU6l30Dgsu7dxnMMYvkPPerwehi+2l99FmjDxluJNZXxphKnIWfJpCI0R/hAimjFKwusAOW99ciltXTDI1RIhUIpZaO1Ex/g8OJTo1Vs3WKG2qFuSAPoUx0fUIHsRSVhfOQW+pZ1YB8EQ4CgV1y3Ssceo8VrPtc4VIP2vaQkzEvNJoKepbReMuvUb3uefCQHwjOB5tRRl8qCtJ9uxxNpIAa2PhtvKWjTzTRk87xzXJC6/rGg0IxgzndZ8OWMf09LjMnFKixkbfspZ1dza2Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4cyZ7QxgWPS47joz71UE7vQImhITIor1iynjitxqRQ=;
 b=oBGkZuHdHx+RHTQPiTq6YWtUonf8Se3N6AQJGC/2T0Wv0EvfrwzPcxCHuCOxdew9DzP8ghbL9E6EARi7EFDfAYsjFJb6rno3lFlwxVmEWgGHl5CvAjuL6Jia0vn6+7BHZT7pr4POiN0nBELQdVSTKjVEAHnFv7pViSNFbeOagMiYSqGK+S7XR2GA+FIyVYqBJT0dkPqVojr7OQT66RGkqoq+4qo80aqojhfznIkLpaqAxPfNGDqvVsNmrrs1MdRgi7jwzuC/fxb3iXD0GCv/XcJ6nr7aa4O60NnWyUoXzshYsvUn9Wd5pR0UxmK7EWjBlTroCuAT9lkNoIYZSVqXmA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7702.eurprd04.prod.outlook.com (2603:10a6:20b:23f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 07:41:51 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 07:41:51 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "marex@denx.de" <marex@denx.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "tharvey@gateworks.com" <tharvey@gateworks.com>,
 "smoch@web.de" <smoch@web.de>, Fabio Estevam <festevam@denx.de>
Subject: RE: [PATCH v2 2/4] usb: ehci-mx5: Add a default for CFG_MXC_USB_PORTSC
Thread-Topic: [PATCH v2 2/4] usb: ehci-mx5: Add a default for
 CFG_MXC_USB_PORTSC
Thread-Index: AQHa+LlgmybEAXAQXUKYbiyRMxIEoLI8Seog
Date: Wed, 28 Aug 2024 07:41:51 +0000
Message-ID: <PAXPR04MB84594C6A1BF6860C385E803A88952@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240827194307.2933299-1-festevam@gmail.com>
 <20240827194307.2933299-2-festevam@gmail.com>
In-Reply-To: <20240827194307.2933299-2-festevam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB7702:EE_
x-ms-office365-filtering-correlation-id: 23de0d5a-78e6-431c-ceab-08dcc734e1a0
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ZCX35vMe0CRg0qSvCfun5IotBCHBc/lIWfsciOxH2vxN20tZwM52fvCET9/l?=
 =?us-ascii?Q?ud5JrUARGtce9qWwEvUGWKroCjdKWf+j0K1sXeySqmNDYIHOu29SnYcBYIsk?=
 =?us-ascii?Q?RLmLZY+emItoZ7E43IniJUz0iT6s/Vi88XBQcWg0Bcc0b7TE9QTtnuolhRE2?=
 =?us-ascii?Q?5Y9Y4rYERy+W/Wx58ORVRX3iOTZ0d0fBKRko1dGJS9fxtJFbNY19TWjAowVP?=
 =?us-ascii?Q?Rt9O78I2K1foZONHn0RxvLZEBM3KEW970QfnPZRsbbExSIrwQh87skLwY2Ys?=
 =?us-ascii?Q?yhg8RJM9xKAkW1WoadwiPS2woyeKy6rV9BXAylctLGjT3RXFI7AoEXxk63DE?=
 =?us-ascii?Q?9E+pXz3n3qvgfTKByn0vEei/fsMNVhIZHRNG7iZWaXSgqKVjYKOa2IC5O0eV?=
 =?us-ascii?Q?btmM2StUqNpPWiJxs7Ipwyx4Js84YRgu8aaO5KzwCpFn7YKg+vrJu1pfsqdl?=
 =?us-ascii?Q?hmHuN+98F249UODri1w92Epykvcxl5C1Ns3wzETCoIOpem/fynXCMtYL/HlB?=
 =?us-ascii?Q?3Sn8Qi/Pv0rT4459CYTtyTYQz8XYo/V8GR0Tc6UPIRfjk3T3PiRxcSsT8qqH?=
 =?us-ascii?Q?dNmzlBeCAY5gL6ASA2ZLNTkDFL96DQKD4Ch9bEzikkFrMEE57kGzgoz6TKrk?=
 =?us-ascii?Q?YKU+a6AZZVIYb3swi8hRHK/DJQlWnvCwbD7D1Uuzs5A2VMREkykDq0WP1Eyu?=
 =?us-ascii?Q?iN846wA+RAw9plvSei7OHReVVQgSls/8ftQjJQybk1uC4TT/m3d1QIOMHv38?=
 =?us-ascii?Q?5id2rJEDGJ4NDlXCQWqfqRFXm9lAK5Oloj6vhZhq/tTMkW2k6SY7qpgBAXLp?=
 =?us-ascii?Q?Prw/N8hx6R7sYFw5C4JuFEUcZ8n6JjYOP8FzU1JwOPUxxYR/9bR/o9fo7nIl?=
 =?us-ascii?Q?7UXL5rgOFxD3PTR73+1yhBpU+OWuiTYdpo9WxAhGJffqzb5RU46hnFbgoW1c?=
 =?us-ascii?Q?0UJgcxsC9luIMBMxYdAghQ1U4J9iayzYsGUxbeQqgZ5+Z6lKvTxAKrHH8RNU?=
 =?us-ascii?Q?YElQd/saPDlLpziwLq09NoN4iVzXLQ33I1u9X8gyeyDt5jfLaTruEHR5H5UE?=
 =?us-ascii?Q?9DYoX2VDjIEQiLlRdteWn6H2i9y3QcV6O7ILuQQY9HPl2X1+QoO62BAkbnO/?=
 =?us-ascii?Q?cgBHjJ2KL1Yi+nerRvsC+vH4yHtL/nUS2njl5vGs3ZGVt+7BY/0qqXw5fkEt?=
 =?us-ascii?Q?NYD0ytPPzCcrjT5Eebt7XPpGyYkLspWvgLGjN5pfX1zUje5D+aYSQSVg1sNR?=
 =?us-ascii?Q?ot2EJU0+vhZKTnP4cVRPDwllwtjv/f3zaXEKYOV2ZjToL1Yf9OYIRDmm+lx8?=
 =?us-ascii?Q?XahgqySyoPj8cnZKRt63NUhe/SNkb7Gn0X3C36djsmrwMpQ3n9MBkAGDLnHg?=
 =?us-ascii?Q?fKBGvcrZ0kytr8kTY91nFx8h0TxLXUvlxBpg/7DfR/gsd7/k3A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/Z7xYHA21z2A4qrhY8izqW2UscUY6wghpNt+rBJM9+UjY+yYHLAfD1b3kw6k?=
 =?us-ascii?Q?xeJ4hfb4atTgFf9Lg6SenDTRMz4Wymuyr1PHMkWs8ggpunjeiKHy/MT+GWOe?=
 =?us-ascii?Q?PU3DLnZo6d1kHb2f0uDfqmFzmb+l8GAhHNHwyFyUKok4oxIJTyrkb7c8Tt5N?=
 =?us-ascii?Q?zO9PjyWgA4XYhqCiNJh2G/kY+L2vspu9qPmzfZSIozq1eh3dmtPiZcgL88DB?=
 =?us-ascii?Q?ZMB2e3Obd1dqS4eRog5kCBagPzGDLf1AdtzyV4jfW8K3Q1m9vsEblcn9RpPR?=
 =?us-ascii?Q?J02TKW6tXUbMC/QlNvfjt/I6hHotbKfHCaSIgusGglorkh88eBOVL7OHHaDG?=
 =?us-ascii?Q?v6yhe+f8Hs8x2PAcIo9XfUBvFZyfPEr7DWxJAu0HqIeqMskcHiUdjxln+/1S?=
 =?us-ascii?Q?H19mGVDJPSou3RzWtGO6Q0VPRjMnflfzvUY5YlPNSMG9qLHxouxe4d81YCQq?=
 =?us-ascii?Q?us8jIJHDHOKZkDcDPsiQp3OE5nors0h/N/2Z1ZZPEIAKx9GS0MbCj3YaEZ8o?=
 =?us-ascii?Q?P4LRwHI0XbzrWM1WFi2uQV0hMHE3sAYqbICFr/DQ07hs4RxN5W/8iRHkzieF?=
 =?us-ascii?Q?hLIyqxnyLZJ077BuDlV7wUnEisWEHTRXaNc3iTV+i4Lcn+5ZpEK84xEY3DHk?=
 =?us-ascii?Q?cu7eq3CtLBBaSIKxSt6dZpiLmkZGHJlS3al0b+4o+wJgj/gw6+LyH7XHIJ9p?=
 =?us-ascii?Q?aRyE7BiCdxgI4DJ9TrxMaqPbu72rIzp40JyfR7iVwwM4fKFuwDZpXpOYCI20?=
 =?us-ascii?Q?VX0MPtGxHddC2WVcpoo88eL9UhYqQVYukBY+ekqhtiRt++z/ze1Zwym/e/Av?=
 =?us-ascii?Q?iG+zWM+lvaSWv+BOcdP9bg+DrKKN6ZLSeclm2oFHrb9vJwoISnWQGMbZp8bJ?=
 =?us-ascii?Q?ftN5a1u9Ar2a7q4Y6DSc9peik/YnPakEh2kN2soh5Ljztt/xJzQb0SklOETc?=
 =?us-ascii?Q?GpfYgH3yXnUVp2OeGHl2GGsJHF/FeU4dkSlvH/lFQNFegiCT3pu4DRGQbL1R?=
 =?us-ascii?Q?wpI/mL/p1GLYG+O6FojM2eSnh99+Zh+BHOy8MnFWko0+sM/TK3/ojllHJ879?=
 =?us-ascii?Q?vygblDnoeOMJ09z1ugx65EsbbuTtD6FFapfq3whBjGhB2M6J9hxUUVBgJFIT?=
 =?us-ascii?Q?m81C81f0wMTVLsqFsbt7Mit/xWiBuLuQEeIFGQfg6AU5gOIr3fzgU0vmVMuG?=
 =?us-ascii?Q?SNo3pbUmAen7vIkxUQCGU+MOZN86ewkKtR1f2MJf0qcRgjrf8Ui7NE08JWP8?=
 =?us-ascii?Q?TOmetDghdAem7/7DZl28K1g+epWUp8KssY5dIFErTBbSQYvrMOYYbwEus5p3?=
 =?us-ascii?Q?6AtXhoaZuJqWPCMxK11H4i/uKRxKfeX/0iK4KWAwupPrG3LUy+brapF+Ilmv?=
 =?us-ascii?Q?90GcI02tYOQQBVXrgJbzJM0uGUKMnegdxw0+G1X1kUdRNozcIHs26+f3Lgct?=
 =?us-ascii?Q?WFXU5eBDwI8wuC9YWve2XcYDpvNWDncOvZdDb5NdJBfFlyWtFZAb3d0gPCz+?=
 =?us-ascii?Q?4LwiTLNB2qcgdItxTVTEn2h7aTByCKCLjfXOaAT2CUZu1YzSgroWPJ4KGOfW?=
 =?us-ascii?Q?4/2xipHteWRexdZqdZY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23de0d5a-78e6-431c-ceab-08dcc734e1a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 07:41:51.7312 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o7Bkp+iGdvd0+yK8eKOVJYpH34+SXdjZ43h9jSnQ6qX5FJUE6bRMx2azPu24zbHFwWbojvFd6cHrylsnunuK8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7702
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

> Subject: [PATCH v2 2/4] usb: ehci-mx5: Add a default for
> CFG_MXC_USB_PORTSC
>=20
> From: Fabio Estevam <festevam@denx.de>
>=20
> Just like drivers/usb/host/ehci-mx6.c, add a default for
> drivers/usb/host/ehci-mx5.c.
>=20
> The motivation for doing this is to remove CFG_MXC_USB_PORTSC
> from board config files.
>=20
> All the mx5 boards, with the exeption of mx51evk, define
> CFG_MXC_USB_PORTSC as:
>=20
>  #define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
>=20
> So move this definition as a default into ehci-mx5.c.
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

