Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D65C5474A
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 07:41:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FBA988A76;
	Wed, 28 Aug 2024 09:41:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="F7ehhggD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09D708863B; Wed, 28 Aug 2024 09:41:13 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 156D588A76
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 09:41:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIX0RBYJT95omBGLROcc5fSY2UlyjsglidYbD4v49J5ArH1b3Fg0Eey16qdeYVUAGec9nLdtfgRRwxDI9L+awGdf5zsHgkpJNC78pzhdU9EpQL+/rIvRAvqXB/BnYwYSGPZC0z+YQ55FzrY5rgHz9eNX2hjKE/B9WejH2U5+R4iGALvkfSieYekzt/XqPj58mKtUBD3UEM8+BwU/XDzhJstuuhS78sk6z9mS2mv0Re/zgCOaDlm/n9vPntOIu0r6SLAT9P2BfGBPdB7H2Ac9syYjcrK9BpYolk64FtELJfBuIn7Md7l+ufIpynw3gl5bo/dk7g73gyd4E09bPkA9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GOeMA1ikIOKWhuI/TsqG+ziggUZ8P4pXlu1GhIKF7M=;
 b=O+MinGQDDrIn5AWGbdw+Zb+jifYxHkwP2j1N65r89Jc1N4+z9udIu1ZXDhjnaWeGhJc3I7WlaPLVlwzhBZisKY3ShwrGpChH/O3ru7T99MM6SE6Qy9fplMp5YHuhppWJ8a1ztNUI2ZSChxM0UJuWvEk7VM/Nj551lGLt9FmLnw7+nAY1rCAB7RtZJW8gojSBq1+lU2MICFJQZm0jWBxJLH/csWTfHqJKtilNp+VfqxDZq5w1VlPQUiDY48hhG6QDAuJJ3+aLvrvYH4EjhIn33PWCIfnLCy4Q/gJYnalQKCjDB25L2eU4Ww15WYyrWsM4uXCWrcRqr2Lr4GgkB6ktvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GOeMA1ikIOKWhuI/TsqG+ziggUZ8P4pXlu1GhIKF7M=;
 b=F7ehhggDz7Z6Y6lKKd2VFy9F7d6b71GPOnDCslrjCLa6c8QZRzqf+gRp13mFnEWwC1SILkZUBNg8KauOheSoAA8BtJFLlTEtgKguHThVUIKhGu3XEo6KskVaPY7ncs0dQadcX1QItM+HSErBreprUbFyTqabAnnYVmpk0P3fwt/CgOR3hB+X/c6RCsTJW5HT0djk5MmqsTsSd5nwKlT/MAaREmq46Gd/OHaoEZxam9CHcwbSx+0dIc6a//SF3hRirGPTmaGBcAYQlpIu0Uhe17JYfM/ROfT60ydI0UZJmIPqoLW8gvrGqp/hc1Ym/WLCNroZ3PnXatHQyJakpHskDw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7702.eurprd04.prod.outlook.com (2603:10a6:20b:23f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 07:41:09 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 07:41:09 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "marex@denx.de" <marex@denx.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "tharvey@gateworks.com" <tharvey@gateworks.com>,
 "smoch@web.de" <smoch@web.de>, Fabio Estevam <festevam@denx.de>
Subject: RE: [PATCH v2 1/4] imx: Remove CFG_MXC_USB_FLAGS
Thread-Topic: [PATCH v2 1/4] imx: Remove CFG_MXC_USB_FLAGS
Thread-Index: AQHa+LlfP6dt0B05a02B0N5Uc0srwbI8SbnQ
Date: Wed, 28 Aug 2024 07:41:09 +0000
Message-ID: <PAXPR04MB8459385C1067A2124173297388952@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240827194307.2933299-1-festevam@gmail.com>
In-Reply-To: <20240827194307.2933299-1-festevam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB7702:EE_
x-ms-office365-filtering-correlation-id: c02594f1-860a-4a96-fd23-08dcc734c83a
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?mSD6M0leHdUB50TMrZUsJgEWZaeJfPSwY5UbE9/v++IQcmOYMTJM9tCYlWJH?=
 =?us-ascii?Q?liGy7ndntUXTpu5hI9Iyf4X8j7WdjI4a4dXviFSa1Wm8hHjP6x9o9C5jF4OE?=
 =?us-ascii?Q?fBMa+vKYoMo4tMvEPOmCshfkN/RT7resrgEitTQjGQKg61j9OPwI/3KFlNrE?=
 =?us-ascii?Q?LyG9HbJrpiYYElYq9QmxToNkfhqIE5ZoYT7BUGfvD2vlAa7Tp9aZ+MyS44Ho?=
 =?us-ascii?Q?isvX/zn2BWSf8xHIxKZx/dNhHE78xQz+oz7mlkUNfrSOBmkVeZdUdfKNCtbj?=
 =?us-ascii?Q?joeAX+CAP2fsahGlwE1y3nUtWPmfKoaBvqzz9Rq3IKxbp78/KLK5Ta80dZYD?=
 =?us-ascii?Q?6VCY8vZ758zTZWYeUWEx6phzfYTWL4WFL9w3YaKKtbnu7hNo2gGT60T9ULrJ?=
 =?us-ascii?Q?LejfsB8/pn5zC1M6l1KNnMQoU8mY9mmPjvjpeZTp76mlGjU2nut+ZtpmzoUj?=
 =?us-ascii?Q?XAo0ay3PAGLQyeJm1Wesz4pEVQyoR2JAqflnSLbmat0xgm5vaKX9IuenHHXd?=
 =?us-ascii?Q?QyHDUEgrpVOR2IOlqoGxOyuRmu68uYrTB02YWCt2OBidY3NYvD3z0LlHUUoR?=
 =?us-ascii?Q?3si8fkd3/OmhgQXlkPFuREBjZeWbxX65zG2M/JdiO0VT1XIMe/qibGHB6trJ?=
 =?us-ascii?Q?Cz49VaMM4ADZXea5QBkppwBhU8jQ1FnjJf0VSTBtTiAX6iY2esdOywNrhaXV?=
 =?us-ascii?Q?HQ+wsEysxRo3FyKvr9WBYcajJ5oWaxTH7M+lLt+nJSyvDw3dIN4ZsIdPc9cm?=
 =?us-ascii?Q?L8922nOq1OnQzMO3Ls5M1AFL2iWw0SZ572b+AQGDmiyUCka7GOCqwQlPodMs?=
 =?us-ascii?Q?6vVgLeDbZup2yOep6nAsqbHdVk0Xr2S126vHQmhUx9Ln9kwl4oCvUucEPM6L?=
 =?us-ascii?Q?1jwUqB0x8AufjwPakCQ152wiHNGweNzppdE+zIgnJT77fcxHPTY+KkQrce4H?=
 =?us-ascii?Q?z1DprqyKZQ5uk64C59+LiViWZlonADih9ZXesiN0yYZseRn+dU46iqLTW0GU?=
 =?us-ascii?Q?I1Hh1rbxUQXyJC527rZB40buRJCXg4Bg0T9E6KeoTsA/Czomyux5DL9SYz5y?=
 =?us-ascii?Q?7BKkjgs0RuKle0bESIHs8BFSHutc8ZKhKPeTzGrH0f4dQBAH3i9NjrQfesPH?=
 =?us-ascii?Q?T1QCGlvENId3FGNVSr1pvHrSwpK5DoOxymOiWoNFoLaJuP0xCljYWQ9hEuvz?=
 =?us-ascii?Q?f0oRb8yKYrh4KoPt79BZfboesJmkNdtWyXowvpvSezrGRdHx+AIwIHyOVJR7?=
 =?us-ascii?Q?YOVbdwO/kTdTXVrxh/PxHN+q4eBKm7UT04vQiJ1sk/m4+aLXQSgPbIHt+Zkf?=
 =?us-ascii?Q?kcpkthD+I3iAXqaltBt/MZLcp2L+rEWy+Lgi+zbVW5AbGtASzRmE15u0Sngn?=
 =?us-ascii?Q?rMFf1EUUZ7aBtxMMv27lcHRLqK8NvUsjwvvA9FnMAstNFjp8zQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ekxoIrRjQ0ayByahoQdLnuLdoOLPvwYjHZVqC+syRlueAfhBlz/89phFAx7m?=
 =?us-ascii?Q?PZUKHSXN1fCcVN9ImttoyWecILzElqwlHVR/589nnIATJV6U3Z6GsnrgwXFC?=
 =?us-ascii?Q?KOCec3iz1sOU7Bog6tEDDtO5DgZFW0oBY8T39LgxSmzJnMtcpc/05WvZ/4gk?=
 =?us-ascii?Q?ny4yite3tF+KexPyFFDNsNeLytOF3+QFsVz0v287/VAsLTvN8PhHknZoE3Gp?=
 =?us-ascii?Q?bixVYfhW55vVla5JrHIK2FVqF9mjcDYxmCKYBGS3gSIfRW7SIbl2mcHsKvhv?=
 =?us-ascii?Q?DSGWCao2sjwFvpcTNvEpdJqf0He7c0JVQ/s2dN4WsZ4sLkC7z0ToBb6LS6Hw?=
 =?us-ascii?Q?LLONi2S3f0OGOgEx1Bz3vnAIpqWlFbyO56pK76IChtfY5QSZcouraf1Hy72+?=
 =?us-ascii?Q?awJGo8k4WaAxeg8RVod0yqDRvfWhErRHeCI6qwAX6YTGT48wzTNEEyFEeNkP?=
 =?us-ascii?Q?Fp40SG0nl6AqSv4BgFpgI11HF+zxGF1/nVNL8cgsNkSTNshKGFNZK57wL8w+?=
 =?us-ascii?Q?rgKNK3QNpg0B7zmzJW4QofXyyN3ePQJQoj7FlJmzTa2VzvRBTFgAZWYpQ8XM?=
 =?us-ascii?Q?hnoPB0OQF/6eIxXA11dYAz1Qk2xJOdyH5xnk8ZZcAaaEMRmumeI/7IaZ/EU5?=
 =?us-ascii?Q?FvQeBpJjLNQhbbes4xi+xKXjw+gSxITaZrnQuo5j7Bxq7GQcy2KlsSoFp0Up?=
 =?us-ascii?Q?psQpkrjG7HZb9daBPe0CocyuFAre7/FFkoaA7gdO1iS5CCk6M8xNB8P50FHf?=
 =?us-ascii?Q?x3EYqdjdBRGzTGh13N8CZ/SBPjhLs6zsfc+T1ItQ9WqTf0JDAG9Xy5JZW89+?=
 =?us-ascii?Q?/L78DkTGUVe6n260chmAwvAMXl5cEX+m/Dx8pJOfep8rC1O0kPFdVr5Yr/qa?=
 =?us-ascii?Q?DBjcLm//5E2QKL8t2WKWwGEscfUHeRbNG0X45tQyIXi2+ZmUoEvps86hV0sd?=
 =?us-ascii?Q?35fX+uOcJDsftCnYtNSruDUgCYHEuh9j45BPg8JgDWCiDoCq2ycXlACae0Et?=
 =?us-ascii?Q?oF7ojbqtEl+xjBivSpl069rFv1aEXmB5Qm86Fj4NcwljdCfsJ1Px/5Z5g8bA?=
 =?us-ascii?Q?L3xrGKMkqOX0RG4fiOfIOS9oHTCni/GEALazXwkZgI9koXhNnriLveXz5Tvb?=
 =?us-ascii?Q?BKId55i5C2lvxv0ErHYLNSAdS75vZpnnrsYXYA++JAgB4wUgmj1IQxiuAKmT?=
 =?us-ascii?Q?b6aCW1EB5VdBK5Wc5roB0s2igPh7hxDn0ccl4MS5gHVRyXzg4g0ldWH6lLfX?=
 =?us-ascii?Q?oc5v9R915XHG9jy8MZFMAMQtj13ukIuw0sgYnrP+GpyvcdbSPm6tO5bvKIWO?=
 =?us-ascii?Q?C1ioDX9MWyWucA3H9Wb2KV2d/f3uNSKl9Rfrm8eat191T1sJpab7jcCU3Kr1?=
 =?us-ascii?Q?5SpVxIo4we4Lsngf5KLYI1AcL08WiRD7CzF+dr7CEu4fjlBDfeezJkK3mZpN?=
 =?us-ascii?Q?keTKtjiynYRwtO311nMQskgSqm5XxBwj/y+mzYUsdD7EwHUAQf8I9k/4HBQW?=
 =?us-ascii?Q?HEYDZN8McwCqH+gHGwtaCdxhPvkYqqi6kE6iLErRXJQOYcttbEkm0QlMNAI9?=
 =?us-ascii?Q?OEWG8F7RCh1smSqZ+UI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c02594f1-860a-4a96-fd23-08dcc734c83a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 07:41:09.1180 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dAuwPk9L/Gg/lcrdko5Uw3YrlafpZkfojtg/eCvVcj0JsuKY/OGCfivOA5xNgVTQ9Oqojgs2QoCjZyTBicm+FA==
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

> Subject: [PATCH v2 1/4] imx: Remove CFG_MXC_USB_FLAGS
>=20
> From: Fabio Estevam <festevam@denx.de>
>=20
> CFG_MXC_USB_FLAGS is only used for drivers/usb/host/ehci-mx5.c, so
> it can be removed from all the imx6/imx7/imx8m board config files.
>=20
> mx51evk.h is the only place CFG_MXC_USB_FLAGS is not set to 0.
>=20
> Suggested-by: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> Reviewed-by: Marek Vasut <marex@denx.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
