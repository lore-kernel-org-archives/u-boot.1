Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE11D6DDC6
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 03:18:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8650A89343;
	Fri, 15 Nov 2024 04:18:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="T+ZPFSzT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 874D389328; Fri, 15 Nov 2024 04:18:24 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AC8C89552
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 04:18:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f73MrACQGXfn0oUozHcLxaRU24GAFZ++sBzAHTykMCQzFHPMCROe2zxPN38/3BrJ5yGZt9AZWziybvb5sVRLJ9VN5BloTJeVnANQHvAd9qSkkb3sVDjegrIpdKJWQ0aGVa7NfdoCnmzAj9T9kWcYhSipH8d6FNb6+NszNkzoGEdINtLbuKG6zQ3yEhFr8nc4WQnjYn3wMe5xr89u/4SfkQPE/cq1Thpewe1J888Aun067hn4hwOsx26aD7wg74nTJxl0wyH8NkpfmqXLlnX6Kkt+3140pFtQ79uThj0Y8u5VP2ol/gS29NdspK4VPBEtf/PWj58EnyHwXhvuamnfvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSXLCLFv+XPYErNlbsZRiDag9BPgaVkfqy51cMvCpH4=;
 b=FDZ2FMj+csLK2YUhtMnWKIUoIdwMiIsYgDvD7FGkwoTX+j63atdTwIDz0nAiuvl5esGZ0th5Q+I0gvaOluF+QNX7B/Zs9HqqTvvc1nnTI/yPKrhRfI75CKi8a5wxl7Q+09hRnka7DAGnOZPYsTDovOgzsKGLrYmhGUnW9Pv3jIjA/uifIAVDVecXKhJ5u6umMBJolNRiZRtRhNwPIlKmxWH5G8roLpf4RZN5+AUOOIyHZTF9qHXXUdNsXWwXhCXob3JCg3gplnKtFxY1jZE8n0k23zn0/OwlU1iaZL14/ovYU/FYbPaOPijjTIG2ks8TQrP/SfPN8owS+75XBQk9wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSXLCLFv+XPYErNlbsZRiDag9BPgaVkfqy51cMvCpH4=;
 b=T+ZPFSzTPm01h3t5szMaw7Ye5JzofQDnD46G188jGKyzsazaUtK0/0jFYP1RxD5B+xQH1xCqJQonGVWW6tbbGJxAybiFhbMRc4KL1p5Z591TQboOloAeB0yowlN3uF7KzicWFXaWwFE0yjnxhpKWy+iZvHF/SWKekUjVwWhgYTPtoqWEEmu1cE7+tfCDlYZkgoGNi3+XZeiTEeu9cdZPwESGrOL/kbsn0uhUTMghnzD8LBXTy/SEpCxAkn19Ockxrc8GU8ytjylAvms+71Gkd//UrQx3cGdS6Jq/x3gygAifakwo3+5x+hLCfbkZOj8UUxYT9qpDy+S5wdBcK+aLHA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7830.eurprd04.prod.outlook.com (2603:10a6:20b:2ac::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 03:18:20 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 03:18:20 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, Francesco
 Dolcini <francesco.dolcini@toradex.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH v1] imx: Fix critical thermal threshold
Thread-Topic: [PATCH v1] imx: Fix critical thermal threshold
Thread-Index: AQHbNSvyid4TMPRFj0OUXUIRLt4zCLK0rtVggAA1poCAAAgO0IAB/GCAgADGHbA=
Date: Fri, 15 Nov 2024 03:18:20 +0000
Message-ID: <PAXPR04MB84599FEDAE5A30749533446188242@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241112175427.83979-1-francesco@dolcini.it>
 <PAXPR04MB845982FC3C40774BAB0CA92A885A2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <ZzRlhaxjr96CqX8b@gaggiata.pivistrello.it>
 <PAXPR04MB84592EF185F8F80089BB6796885A2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <ZzYWu5bPiWG2uxEC@gaggiata.pivistrello.it>
In-Reply-To: <ZzYWu5bPiWG2uxEC@gaggiata.pivistrello.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB7830:EE_
x-ms-office365-filtering-correlation-id: 1f4a2578-f57b-45fa-2da3-08dd05242803
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?QdEUs6E82PMA2PoWCFCAhZFFv1GKjrS6oVML4OD60+hCRftErndEFZ+eGsoW?=
 =?us-ascii?Q?PyjeLuaQ1h6wVpcGrnNAw9zZF0IRKm2aebyyJHgGAtB4tBScy10H3Pjj2VuS?=
 =?us-ascii?Q?7jHay8rd3Z55W0g6F9QTMG4ZWf8fqPhsfRll0dg42seK7shOzIai9YY7YNs/?=
 =?us-ascii?Q?rAl5SHWYYtMk38xB4gXoeSzgDFHAYt0+QNE/qt+KRw0XrJwAFV14yNxVXNiV?=
 =?us-ascii?Q?XIuJhihGKY4PRrSP8zBkxIKRqC6pxKOweV6ldmkZM1w7edTOm609jcIAcq8+?=
 =?us-ascii?Q?oEYZzdy0BeHw9HKOJAQ4wlbVvaLAriBeLMdJsvEjHh8+tkYTheVb8J7p8G78?=
 =?us-ascii?Q?8l8eLW1euMTUaYGU/HMGCpQXwgewBh+YihTP420+u8BwQRlf8yG7X51Dvg0m?=
 =?us-ascii?Q?dHAbfMBm3+M7BOMcA8qTvl6P0c+TtkkMsj6pCnzVZJEXyNifU9N37/QL8BEx?=
 =?us-ascii?Q?bX053dAOzLbHUPf5/EbyQW1B64nv4O+SEvMmD13bRCcqYgmVBuRyNATUuq4l?=
 =?us-ascii?Q?1Vi7Arr0V7/q4NIH3xstDdPUqYPnI0BC4Xwxdu06YpLGKdBra1KbuqZv1pT0?=
 =?us-ascii?Q?uNLd60kYfY4rZtqjfArW8ZNcoNqYihncY/RIRxbdIsFNoZI8Qu2SUMsvBcl0?=
 =?us-ascii?Q?cpsb709Q/P+IBXIpsAFZ70o6NcNu2Dd9jDyJQY2MmOb/OURSEf/LPyW+Gogf?=
 =?us-ascii?Q?3tzlb4a8NnAnJiKqnTsuViC7QFcR8FsJy/ekKjhi8G9tZBgW84e+YDH2U1wM?=
 =?us-ascii?Q?MAoppC4Uport6PjC9kb9YbxIi0ahAVWy7wFRFObzgFKzv27WhfYhInd/Fh02?=
 =?us-ascii?Q?2i0YD8dQQgvIMEL2x6KzoQvJZQmHrPcgrnXb0LXhyGVrvOcZ9S1zFlPTN5xG?=
 =?us-ascii?Q?DbzkNhupm3G9w9usOPjz+qwppPy0kLXr1bS7a44xNgiJrW+gJBw5/gMtBh9J?=
 =?us-ascii?Q?FZJZ5nU5FltOkm1vTy7QQHCeS4wvEd9EXby53iXrHhe2WbKzl68hnWNiDzef?=
 =?us-ascii?Q?N6+txZVACV18CwmBGpL0K5hjZAH698m33i5k4o63O9xyEjQ48/3n+VlRAjgy?=
 =?us-ascii?Q?f1Qb2slPKbF+KYqn4IMXqeywRydkxc1Aj40m80tjOiDhlSac6614PeOUXy5S?=
 =?us-ascii?Q?p5vtkQQLXP0Vf10AGLvdJyy/uVIkVOjjqsDqQsK5bjlmVBU5VEiq0C0oOHhW?=
 =?us-ascii?Q?1ZkxNuUqYs0y+5VBaC0DMK/kUK7TzHoiboRlTFOQIdqXws/5YvlzImtgaenM?=
 =?us-ascii?Q?Wy+qNukoPqH39Z0DGilMh1LQ+S8jaAixaejwzR93ikKtecY+ZweBLjX92avU?=
 =?us-ascii?Q?R8LtnNwyhaBYuf2xgfdFGzpSwJiOBxwcy9MNjG2XPM7STfLH4DOya61gUSFv?=
 =?us-ascii?Q?+H91NiY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ELCoPhY9Xv6sfsBMr+/xjMXK336Rhty0kxciiz2+qD5ZC1TkyI9qhoTOaFhg?=
 =?us-ascii?Q?CLQHkQOcxB8cta8HiPVfKyqSZpSb7JojF2hkrHR1CJb0c6YP1ZEdlvrq+EMj?=
 =?us-ascii?Q?JCjcR8aF9qAKD7Txp5IHz8adCho2bCJ71vZ0YHbfuXRyjvATaD31Xdyr4k4r?=
 =?us-ascii?Q?HoVlyUWqTYMJ8iFzSONmt+7eSjuCXCnkd4RXc4o+8Y3frCYjzeg63S5255pK?=
 =?us-ascii?Q?/4P7Ig23IYdqWCNgqHLx9PO2Hr9EHu0k2T8KKND63GuNALP7quvtsvhHO+wN?=
 =?us-ascii?Q?0lwey9jKyz8TKLQhba1iw81TlaiMQJjKBZu/Rsa55sWN2dLPDhOf6Q5yikH6?=
 =?us-ascii?Q?HdsAcBc5q+LuvWbR9VhQGE+WTiWIIumGXtoQ4Co5xJfLAVi9RiyyY912YJXD?=
 =?us-ascii?Q?ltNzk92E0+iIMbJfTYggVcE0oNio5/EdQLKxZ6IPfg6EAIuWTvAcCpJljAJD?=
 =?us-ascii?Q?el/XdbZT1JAE5ZFgeqlsIw0XlDvOMjjvoZaedVDVHPapbriqYsAeJQsS7udu?=
 =?us-ascii?Q?+iTKE4bllnZOW40pOa1wHF6QkEFc3VfwvQnmQU+wx0WA2OVW3pPwyvEAFpaM?=
 =?us-ascii?Q?phdcFY4Q/2CB0nfDnvaPc1r8HRorhlWn3McRc8COst+Qt1cKXACRzSquyXTv?=
 =?us-ascii?Q?3x59shregQuoEdgiWyp8ZoM2RZa5F0oLp7xgD82vJqTYJmUZxFb7JAWQtYNq?=
 =?us-ascii?Q?S80BMJKdxaRmARqOiOT/SaTVWKuIzoyVD9Sd8H35bomWJg0Mq+ugEw7XjS+T?=
 =?us-ascii?Q?ajE8xVdQoeD7tD6xoBpEimOhnxORuB/WbLbkyF3Lwp9d1brgjIxrfmGmXXr5?=
 =?us-ascii?Q?xCuHf+RwGke28/jbKPja5xjqh4f9Nv4WLVUpPd1eeQOVc8M/xSvxR+vkoJLl?=
 =?us-ascii?Q?56ErkJ0/dBxvLpUMoTJqIFfcHg48AQuse8RAg1idFg6hpZTgc0zqcnnxS8MX?=
 =?us-ascii?Q?qjgZP3g3taFOZIm/i/lHEHMRPGiJDCxrOD4DTMlvNhbF2SAwI2gYiKWX4NI/?=
 =?us-ascii?Q?CVoWdwdTEfakF/kw++tGx1zUXbBmVqUrtHYrHrdphwqZpPyBVUjUuAQeJ4QO?=
 =?us-ascii?Q?EZoIogQbKwGKQLxpxwoNlCsQtwnrKWoUYdlEU8D0tHretnTQ+cyta+3H+jzG?=
 =?us-ascii?Q?Tz8fBM2zP4k/gP6LgrbX7x56YAu5d2T+31kT2TJhVxNe9DtF+CS6WbnlJLVN?=
 =?us-ascii?Q?1a2/jwP5kbzX7YTDXqIpnJh1Cw/RckTMA8Zsd1c7rKelNRSRXHFFB/Luu/5z?=
 =?us-ascii?Q?Zo9rb8F03ADbZp6ExCfC6Quf0EWTxM80LoYQlk/DqhO+Gi8Lzm+1RNSltAm/?=
 =?us-ascii?Q?em/MCeozHlGtgJshMcIWEi/otwzx2Zxt5fZCmRuMGlA/Sgu2UUAw6ILo6n+6?=
 =?us-ascii?Q?8/MWT5FFZzsDMMVkDVgN48+lz8xGDEkneU/CJXcTHTUo7XzP06QhL0eAwJRN?=
 =?us-ascii?Q?rJTjUi0teu75fs/5eC3meBq9dgBIvG3p76sUTTTYPwH7fUIcUhEGgbVcq4L4?=
 =?us-ascii?Q?RJ4FR6pBHfZxaMr7NRHf5Ha/oLlX3NbSj4iwVBeof6VdLXa271ans4XVX8MJ?=
 =?us-ascii?Q?OFhOp7+CCqVgk/8xeLc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4a2578-f57b-45fa-2da3-08dd05242803
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 03:18:20.4392 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8HuPVmAJ0V6uE1cMPnd0wZE+bxOYSWZZlU7VdqgRCvudsPDRG4Lnx9ik74qlv42Jq3tEufF1NQf5t6YDCXw7+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7830
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

> Subject: Re: [PATCH v1] imx: Fix critical thermal threshold
>=20
> Hello Peng,
>=20
> On Wed, Nov 13, 2024 at 09:10:46AM +0000, Peng Fan wrote:
> > > Subject: Re: [PATCH v1] imx: Fix critical thermal threshold On Wed,
> > > Nov 13, 2024 at 05:27:23AM +0000, Peng Fan wrote:
> > > > > Subject: [PATCH v1] imx: Fix critical thermal threshold
> > > > >
> > > > > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > >
> > > > > Fix the critical thermal threshold for i.MX processors, this was
> > > > > changed while moving the code from imx8m/imx9 directories
> into
> > > a
> > > > > shared place.
> > > > >
> > > > > There is no need to keep the critical threshold 5 degrees less
> > > > > than the SoC maximum temperature threshold, what is actually
> > > > > going to happen in practice is that we are going to power-off
> > > > > the board
> > > when
> > > > > the SoC is still within its working temperature range.
> > > >
> > > > Should we leave some margin for the critical temperature?
> > >
> > > What's the point of such a margin? For doing what?
> > >
> > > What is happening is that the OS takes some drastic measure when
> the
> > > critical threshold is reached, for example rebooting or shutting
> > > down the system. Why would I want to deliberately remove 5
> Celsius
> > > degrees of valid working temperature range from my SoC?
> >
> > The maxc means the maximum temperature that the soc might run
> at.
> > If the current temperature >=3D maxc, the chip might be broken.
> > And temperature sensor may have some deviation.
> > So leave margin for SW to shutdown the system.
>=20
> Let's brake this problem in two.
>=20
> 1. the change you did created a regression. this must be solved, and
> this patch
>    is solving it. after that we can discuss if this needs to be refined i=
n any
> way,
>    for example making this threshold configurable in some way
>=20
> 2. the device tree is supposed to describe the HW. This is the threshold
>    without any *arbitrary* margin. I need to be able to run my system
> at the
>    maximum allowed working temperature. If you want a policy to
> preserve some
>    margin this is not something that should be enforced this way. How
> can you
>    decide that 5 degrees are enough to be able to shutdown the system?
> It really
>    depends if the temperature is raising or not, how fast it is raising, =
and
> even
>    more external factors.

ok. Fair enough. I am fine with your change.

Regards,
Peng.

>=20
> Francesco

