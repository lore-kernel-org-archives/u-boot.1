Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92B9C44506
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 21:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0278B84AA4;
	Fri, 10 Jul 2026 23:27:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ysoft.com header.i=@ysoft.com header.b="nfIHYlAs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8515B84AF6; Fri, 10 Jul 2026 23:27:52 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 691C684AA4
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 23:27:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ysoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Petr.Benes@ysoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MX3jUPYrQf9gBd2x410Qkcj36HPZ3+dmCSC06SgE+XN5LUskKdls4gd2QDChmVKiP9Di7MPbEzMpcTXv6MdVl+TNnI5SyroQ5YbjapL5jI8UQ2k+cVD8gXvVIrbrjV+Q7Gq400VDD8YelQC1HtMGB54ySosUxOvDFJs+XPFR7sZE5YIBivXJsYALpcVmENuj4gWkcW2F+6+mB0psyXAqsfEOwrEWMErVaeWMWlysnHjZhcz1zlZHluIOpSSHjPXslBtzFG5pSXgQRsjC1S6wcs2msFZ0MfoYCnpLYwxTIs0GEmammKx7Rrrcan70Q5AEQl9V/Ph1alUfQUSYut2Wcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63uBcwclJqWMbjPsucoekq0lzmflr2am0e1BJwhjAeY=;
 b=GIwftPMheBskH5hr3GL5Yl1KJSBJnmkvHTz7VhebtK6FvDZVH457TvzFGU65YtNwrJ//kgW3zR6olRpAJr0j+v2gdHWtJ6p20A7e4wnOGaWQ2PlvgqPOHIpNxf1ImqdOa9CdPMH1B4wX0ulGGiQz+7JBm6QkXTKTTVG06TOAqOW5H7OxuuBw/WVsdoCfZzeJtmsOssQwprUo3jzplqgm3rg8KgtrddAwxjOrRCVX7H+CQEpZpowsGrOGV0MxNKFVoxBxOB9yDv2r3hWKanNjtgZYRYmZb1zM0GD0Bcl4uG7fCwoBSEt4f/UD/b6pcmCDpT1EPy7/OMtia5NoDtQc2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ysoft.com; dmarc=pass action=none header.from=ysoft.com;
 dkim=pass header.d=ysoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63uBcwclJqWMbjPsucoekq0lzmflr2am0e1BJwhjAeY=;
 b=nfIHYlAsEVQB3mTVEvDzlq+l+TGG8de39PjPJToXQzrebVMfUNOSnTBjTEmZrdj8zDRl3AAnS64aRSGXE0UCp2C9i3gufIkN+HhEnxh6/dD7J7Vp7DYW3P0/FFExuescfamQBnMW/QE0iWmRpsUDZxPUuNvMVuylGTZ/sMGLONO5n7dVPIsxOGMwKb5NrpzphwDGDVmMDBxVbbjlCIjaZbUGl3kleK9b2EWtJqwllxe2UKzE7YwhJBE4cPeSuOd1+yeW6DezBum509SWsjKTJxJA+xKW7ILH+kY1FvcxhM9iugvrhd0Mma2IP0gba13yqY9laCoMHk6GogOcbemIgw==
Received: from DB9PR04MB8219.eurprd04.prod.outlook.com (2603:10a6:10:24d::12)
 by AM0PR04MB11915.eurprd04.prod.outlook.com (2603:10a6:20b:701::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Fri, 10 Jul
 2026 21:27:48 +0000
Received: from DB9PR04MB8219.eurprd04.prod.outlook.com
 ([fe80::d966:551f:de78:815f]) by DB9PR04MB8219.eurprd04.prod.outlook.com
 ([fe80::d966:551f:de78:815f%3]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 21:27:48 +0000
From: =?Windows-1252?Q?Petr_Bene=9A?= <Petr.Benes@ysoft.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 =?Windows-1252?Q?Lothar_Wa=DFmann?= <LW@KARO-electronics.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: Regression in f_fastboot due to commit 6a92e9827650 ("usb:
 ci_udc: Check ci_ep->desc before use")
Thread-Topic: Regression in f_fastboot due to commit 6a92e9827650 ("usb:
 ci_udc: Check ci_ep->desc before use")
Thread-Index: AQHdDphzj59sxXh4xkakbDfS05lXebZlTnKAgAH08E4=
Date: Fri, 10 Jul 2026 21:27:48 +0000
Message-ID: <DB9PR04MB8219B75AE3A1D4D750B7C3B880FD2@DB9PR04MB8219.eurprd04.prod.outlook.com>
References: <20260708071255.13f58e98.LW@KARO-electronics.de>
 <875x2okxcs.fsf@kernel.org>
In-Reply-To: <875x2okxcs.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ysoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8219:EE_|AM0PR04MB11915:EE_
x-ms-office365-filtering-correlation-id: db68dca2-df7f-4239-46f2-08dedeca16f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|786006|1800799024|366016|10070799003|38070700021|18002099003|22082099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: HdvEIEeCrdFwfN9I7oSAcrc3ax/D4/q9XEt8cB1oUwq8m2gaIuikUKKb7jDMw0UiMb8/khXdMrf345EK0fG/rHM2Gww8BslxqGs8gNA9YTA+u0ZHbbeFi5XhFsiwRZwAY8ncowrv8Xg3vNARQ1+yOehpF9QJkuRHWVUlZwg4EzlL3xOe8AybcmTatfNEbZRLtun3SOYTxbvOct0AwnXVPM/V8261pH6yroodtNIUiS1jIDQoc3rEoGxa8JEVLEgWJ6USEGYojbeA8B/QzK5Fvd8/pWjKuSUnaOzPLgW2wKMF4/J29dGmYahxks4071FMsHmLvwJTPTJVRHht99CF+or+JzIhygkcgPTwI8c9YqNkiBlFu0giuOBda8fvbZiC+xoXNOgSZAL+GO24WxsLRPUvJoRAOM6Je0jlZAd7qkkxR5Ml6pxUo+SY3ga22iuwA71XgeR8a8WxTCI9ybP3KOVb4ktYObHZe8GvBqIe1GYh9qf7EaXpKvCDDxhgOP4X4noBVEXGgiH5H5mJHTYbfLOPu3xQPOj4sE2s89jOLTC9J4KVLNda9oU/r7bEXEYQ3l6w6bEy+OpAL1HgdMHVPbF/YYPf+3zurFBjQB1ABbwHN10IeiV8IJvD77MIDqtZAm1fxITFOyWFrB9o2Pzxw4bj/q7MnTbol0MF7c15j9juLZYIpNUWLSp1wUM5M5nUZ1KXanl5ey64ho6LT8eTJg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8219.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(786006)(1800799024)(366016)(10070799003)(38070700021)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?MG64F5+D9mOHz4cWw3xfMbcgfYmjo38Xf9a8D4TyGSGdbRuqp0/MnryO?=
 =?Windows-1252?Q?T9N6CLQHYWZe1kPFw5E63rDAIDv8MW8fXxm5JNwCyUv+xRsOfUFy9uFh?=
 =?Windows-1252?Q?bnCaFADTlf7omaggn76HK92yHAmaYeHE/KljlPrE+b1ESAhA2Sag2Q58?=
 =?Windows-1252?Q?wQliUV/2IAMM9kjFR54E1gXSqNaBTMCocnqSZ9+gJD7LjxiMvkwjZRxh?=
 =?Windows-1252?Q?6YZWbwyJUDTjRFtAgs1rIkbh4QGNNdN1Zy1lK/aZztSWN8xK6PoRM5Qt?=
 =?Windows-1252?Q?7ps4oEzhmb8g5ZLt/oZgXe7sG/fl6/z7e4v75e315lzPD5ueGTsPlA9/?=
 =?Windows-1252?Q?3iorJgrawOfFBgv38KrHlZo3FUFOLYabHjnTvuI+K7UOsB6XTG3cy1vl?=
 =?Windows-1252?Q?YmFC66pe8zagNzxHMwZHT7tj+TllTxv02EFUhDxlbK93XTR4dEm38P8w?=
 =?Windows-1252?Q?W6/yov3+Lx1ZL6IZ53S/+6xIeQt3U/frORYgzjWz75qwAzpI2vAngwNV?=
 =?Windows-1252?Q?1zma7JYDA+QuNga2Ic1D6KFeNYNBFczdG5KN8xlAjdoOv+dgtXD1tgmt?=
 =?Windows-1252?Q?l8p5BBUTkJMkMnYUGTiHPE2lbtkBXsI1sOXS6yrhha8lKUJJ+gZqeSck?=
 =?Windows-1252?Q?hvy2tAwK8KGVrgNJD26OXR7KLlLXi96dM52l4ELZBE8mOiZQ1pP5g7uP?=
 =?Windows-1252?Q?6Xe3Kv5t/4qAUUbBtJYrKKIM8hqR36P3jWGkQ8t3GYuI1/CiUrMP4z/a?=
 =?Windows-1252?Q?TQyyUvCaj7xlLAzYzWGkLQJlqc7g+2UzZj6iJtkjEU3n5/6q309Lqhfa?=
 =?Windows-1252?Q?3dZ7IWgLR0vu/8KR3LAMuC39cua8PaceO7Ftl6AxuI6Gema6fbGPUR2q?=
 =?Windows-1252?Q?r4QmkKYqzqOKZr/rfqQQqdTeANmQwfq8HTVhCQNiKadBb00QzuV00Abn?=
 =?Windows-1252?Q?GH2lu7hvYcKPFQq2nmuW6ohpxXwNGWRuGSwJdFFzcFkGDPdbZOeflY4S?=
 =?Windows-1252?Q?WOmH94dQkmGq4mg7OACGYbZs3C++NHtXCawErn1AHPMWYMFvy3d56JmE?=
 =?Windows-1252?Q?cxSBlGEf7XWf5GZHpl+F5ZiStYNATbEEtIKWb1MBqIUn1PedQB08jJ3I?=
 =?Windows-1252?Q?epzYA4zgLFsLSX/MmH53TalSL4jLgFoSOxEN/knTX8QAvzS1EL/TYYaV?=
 =?Windows-1252?Q?Z5DUJtzMbT46Rn8mYp5khXXrQlWjavbxg5f9Exo7JIPmkrte9DQ2/w7v?=
 =?Windows-1252?Q?u41ALZrNo8apgTqGGiNREgAtM0JQKv1FXSbVpWvuGGE05pQna70ypqfi?=
 =?Windows-1252?Q?5IMf+y3Ags6D9qXmVHtcOlREpuCxMnStVwUEHRx4YQcLqHZrmN7lrcVV?=
 =?Windows-1252?Q?4jRARxg8hVfgQRvalZA/+ZHdGlCvE2nxYUfDySYzh8o00jJnF1rUdVV5?=
 =?Windows-1252?Q?3oFAPR+O66HdjAe9k4yxl9vXy09yiGUX7mKHBFyvI8/6zCI4qpQoogTE?=
 =?Windows-1252?Q?8GhUht3vNi5bk0Ua0T2THUQiPhWf6KXE1QcJARTYtPTEIujZBuQLF3Jb?=
 =?Windows-1252?Q?eieknpWwBjrKIcgbLnL5osWaXCRkGSogLDUAjSGMDxT0vcSBNfHqyLYm?=
 =?Windows-1252?Q?deTlrq0MgcvlT/X+QYD76Vw5iaVlPcOZb2r25tUPGzrEV6uwbEc6zm+J?=
 =?Windows-1252?Q?PmFmpo0jv8CxWz8PqFnc1hh5yGOux8UgnHOdAtni0f3KuIQMSAzYO3hP?=
 =?Windows-1252?Q?ASsGXSc/iNAiNVwjWiTAo3pHk8dU5EHDrXbnoP/sAi2eVLpyPSA3B7KU?=
 =?Windows-1252?Q?E+lKjneuATNlc+0ndQ9SQsSdSCpDmd4qf+Oou4bCQFcpwDsYKrpPaeOo?=
 =?Windows-1252?Q?PPHqbA/zSVzHNg=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8219.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db68dca2-df7f-4239-46f2-08dedeca16f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 21:27:48.2835 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 303Vcqg8dK/c/opGU+CqfKhwvFoKVs4YMd9CoNvnalN1BlhJPO35Vh6UIZHC8JKNaf+k/9kuH5DfTJhMk3aQWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11915
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

Hello Lothar and Mattijs,=0A=
=0A=
I hope web outlook doesn't render my response unreadable.=0A=
________________________________________=0A=
From: Mattijs Korpershoek <mkorpershoek@kernel.org>=0A=
Sent: Thursday, July 9, 2026 17:15=0A=
To: Lothar Wa=DFmann; u-boot@lists.denx.de=0A=
Cc: Petr Bene=9A=0A=
Subject: Re: Regression in f_fastboot due to commit 6a92e9827650 ("usb: ci_=
udc: Check ci_ep->desc before use")=0A=
=0A=
Hi Lothar,=0A=
=0A=
On Wed, Jul 08, 2026 at 07:12, Lothar Wa=DFmann <LW@KARO-electronics.de> wr=
ote:=0A=
=0A=
> Hi,=0A=
>=0A=
> commit 6a92e9827650 ("usb: ci_udc: Check ci_ep->desc before use") has=0A=
> the side effect that an empty buffer is being passed on to=0A=
> rx_handler_command() in drivers/usb/gadget/f_fastboot.c upon=0A=
> termination of a fastboot session which leads to a=0A=
> 'command  not recognized' error message being printed on the console.=0A=
=0A=
Thank you for reporting this.=0A=
=0A=
>=0A=
> Obviously without the commit the offending USB request had been silently=
=0A=
> dropped but is now delivered to the upper levels.=0A=
=0A=
Well, it was not silently dropped in case of the ethernet gadget, it was si=
lently corrupting memory.=0A=
=0A=
>=0A=
> I'm not sure what the correct fix would be.=0A=
> Should the fastboot driver ignore the empty command buffer or should=0A=
> the "Moreover, the patch gets rid of possible outstanding requests=0A=
> if the endpoint's state changes to disabled." part of the commit be=0A=
> reverted?=0A=
=0A=
Hmm, maybe I got it wrong. The endpoint got disabled, so what should happen=
 with requests?=0A=
=0A=
linux/usb/gadget.h reads:=0A=
=0A=
 * @complete: Function called when request completes, so this request and=
=0A=
 *      its buffer may be re-used.=0A=
 *      Reads terminate with a short packet, or when the buffer fills,=0A=
 *      whichever comes first.  When writes terminate, some data bytes=0A=
 *      will usually still be in flight (often in a hardware fifo).=0A=
 *      Errors (for reads or writes) stop the queue from advancing=0A=
 *      until the completion function returns, so that any transfers=0A=
 *      invalidated by the error may first be dequeued.=0A=
=0A=
Petr, did you observe similar behaviour with the ums gadget?=0A=
=0A=
I didn't see any wrongdoing of the ethernet gadget.=0A=
>=0A=
>=0A=
> Lothar Wa=DFmann=0A=
=0A=
Regards,=0A=
Petr=0A=
