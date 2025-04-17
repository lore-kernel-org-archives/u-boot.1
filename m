Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5004C369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 04:59:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98F4F8300F;
	Thu, 17 Apr 2025 06:58:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="rxQQ6fgE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E510082EAA; Thu, 17 Apr 2025 04:36:02 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F95682CBC
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 04:36:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JuojCAeQC6ZEsXlvlp7kcctAHZonYaainT3OI0RNI/fHtcOvwDs8rB4XAnIn6kHIr8JNK0yu3b/8+JllPxBgojpdSB37X/k05oUDqYkUX2pnUAKl4nwRV+I/69cwsNBULK93Kkrq5/eMrHgHn3EZM8MP6IGV8YxUv6S8tJUPi6I1WUUzlRfV3A8c8AXcnIToRXTY1jm4tEKKwyw99Os5EagRDA/lqQ5U2at8KVg1p8/IE2Wi0qpkmG3IT+Tbk5w9brJ3M56cYfZMtEU/fboyVvZZKHbI1j8/5q2h+zLLG56474LVvgF4t9w/2FIph0MzHenBRTFN4AA6P6KyFVaW8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sC18UxrAGxNiZwr6NJMHoMGfTyVv/2QmbJ8i9TVIyH8=;
 b=l0s5Ym175Xiqh3b+gmvafC1sXy3TN/TXxZeeqhmAmASlocaY4kTObP3i+55jyhuqY/lRsUqHL8pr7wgOlEOII4p+Dcka0xWJlYyruTYYHUc4wdbSzY65wkOcNDI1RnfcrAXFqjo+8noWIEGZ1jIkvT5It9JtD4W0ucfq9upj/QsuQSzcq75LxTJHnX/ARWqcmQupV46EsrKv3tMfW1JtKRtHyJzuay037iXsHdD0SEWDTq/y0VtZZQxFA5mux5uIFJSUyMcXiMwcrbkiZxFRSUX4+d1byEaWtXN0e3ryedUQNPo4yY+JZIk0MgfFu5XQkFe4qCwIU5Bgm+A+CZuVXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sC18UxrAGxNiZwr6NJMHoMGfTyVv/2QmbJ8i9TVIyH8=;
 b=rxQQ6fgE8iHdY93e0zjL7kQ2Htqg4RXvbzx4ghNG4AG5Bue01h5M04N6qgTbQTD9XS8RoMdfuxYIqWBdhE5eWOchdJcOp2WmxjoaAl1RLmMXcOda20p42c7ZPO0LKKQFALEzluYygZT70SX/ta+eqFdshV+w8BcSX5D31txCUNIg044SUkNy71PluTomaIhvvkKkbuH2lh9A+EiWEuendQE4LsZXEfbGBs2hGA2yjqVUimXy8aVoWqu/SDq6pGx5ujAhsB7QzSHdBNcxnPPMoYB+EF0qdLBnq06orRx10uCkWJn6mVxQ5MOt041YJZlr5v2n/pmpgfXYZyiQooEpVA==
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by DM6PR03MB5065.namprd03.prod.outlook.com (2603:10b6:5:1e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 02:35:56 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 02:35:56 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>, Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>, Dmitry Rokosov
 <ddrokosov@salutedevices.com>, Jonas Karlman <jonas@kwiboo.se>, Sebastian
 Reichel <sebastian.reichel@collabora.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>, "Ng, Boon Khai"
 <boon.khai.ng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@altera.com>, "Lim, Jit Loon"
 <jit.loon.lim@altera.com>, "Tang, Sieu Mun" <sieu.mun.tang@altera.com>
Subject: RE: [resend v3 00/12] Add Synopsys MIPI I3C Driver support
Thread-Topic: [resend v3 00/12] Add Synopsys MIPI I3C Driver support
Thread-Index: AQHbnJhPL6oic8rJyUK393me9B/PZbOZcsMwgAB4nYCABDovUIAAg/4AgAie5MA=
Date: Thu, 17 Apr 2025 02:35:56 +0000
Message-ID: <SA1PR03MB637019E2A83F8B44DEBA95FDF7BC2@SA1PR03MB6370.namprd03.prod.outlook.com>
References: <20250324083704.26259-1-dinesh.maniyam@altera.com>
 <SA1PR03MB6370C3D360FC1E92B4766F3CF7B52@SA1PR03MB6370.namprd03.prod.outlook.com>
 <20250408142657.GX5495@bill-the-cat>
 <SA1PR03MB637095CF17776E7274561E5FF7B62@SA1PR03MB6370.namprd03.prod.outlook.com>
 <20250411145240.GO5495@bill-the-cat>
In-Reply-To: <20250411145240.GO5495@bill-the-cat>
Accept-Language: en-MW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR03MB6370:EE_|DM6PR03MB5065:EE_
x-ms-office365-filtering-correlation-id: eff65dff-108a-4994-b832-08dd7d5894e2
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|7416014|1800799024|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?IjnTsN96vRTLiLkppmjxULvJ+S4j4pzbk2d47Unwc1RNzVsSq6+ZnHmw+79U?=
 =?us-ascii?Q?qLpRPJHIqa7bRq0/KBQ8Ak3dG9Xxws7Q4DhHQIv3CcpYUdpvCx2lflbySylh?=
 =?us-ascii?Q?nXhmDUXsM1piJFwrZHrSBnEt71vcIW2PeWCMPpwoPT75HPnXtTDuOA/hr8ot?=
 =?us-ascii?Q?FpDPznJh/PuPkFmYgiRehuepx1r2FZzQTfkJVgb8kPmP/LajFma9zdvc3Jw5?=
 =?us-ascii?Q?cMf4d2P3gEndIDw0kt9SLB5JBwCvs9qWQwLRypZ7Eqn/Z2p8Ic4gY5JI6LOH?=
 =?us-ascii?Q?TqachjVN/+m8IcVnAkZC/Z9fXsJxlRHnrc0db2hAfuqOp4FYbRxn8L2KkjYl?=
 =?us-ascii?Q?xgulb920ecwMyg9DwPEodYn3QXz78LgZ/BA79Efwmu41+mHuneH1IhhFJp1O?=
 =?us-ascii?Q?nur/tpc2ZTCOcPRnKg4Gvb2MRZskWNMVwS/uWcJ7rtVNr/0i1Ava1pLHpb4e?=
 =?us-ascii?Q?CN2G+V3ns6PWQiObrXSQgvvdcUBF1tPW/Ap4uJJzxFQspPQXxGmn7FqSHd0A?=
 =?us-ascii?Q?LgIBIGaHK/9h/XdpTU/+QVtmp+XoUCwomGIeMPgnmEMmZVvg7X9UXjKIFPgm?=
 =?us-ascii?Q?HA1pcAwg0kmty3CTd3YIYkFDB+49uMor9ZxdeSgIhAmztwdfO+a9jBAzLFGc?=
 =?us-ascii?Q?ENAsshlJXyJ6x40Fdaxx8VNHlL5rOzCTgl0+HgxVcpAmGmjVxJ7mssrMRed9?=
 =?us-ascii?Q?8F0YwyOCHVaGbfpMrMzdeadIv+v4zO267rGthk9EXRLKq3hRfgLFmLucPQ2F?=
 =?us-ascii?Q?+450ma9DxUVpJlxPs+e91deiboMhFDf+nwizPsXFUaBaO6rd6+6tDjDzh3y3?=
 =?us-ascii?Q?fhz7Var8Wj/Hayf0+ZohuSQn5DCXj0qYPgd3s6iugSmrhzXBHDfmbh7yInBG?=
 =?us-ascii?Q?xnIgpk3kxzHrJdO8vSDWlXw8E84x7hd4ryr8DxwLiN18xMMzfTTUYGxqAwmO?=
 =?us-ascii?Q?4Qbd4CKEiyc8NGJfcp2nyB5A9A0KLOCFe1G8+hOAapoxyrm+XAZ0tvr1AGBn?=
 =?us-ascii?Q?tohHjQA1FqqG1+/duBdwpLJzc++aqeVp1aAyf2ehvUbvfYwE66bbH+q9m0vj?=
 =?us-ascii?Q?1cLO+OkYd7agTZ4Ild+14eN+6Ikh7buerAKdbaZ0q5av/00SbDmKFK2HOva7?=
 =?us-ascii?Q?ZEdVn2mrl8zSKxVHKhsJMWSmU/JagGpkfG61DegDAkex5rPxh0AzrXTNYsPg?=
 =?us-ascii?Q?vUN9o75XoeL4MieN7c79czamTiYcaBtcYIWMMqHDxfZCq7spD5aPFpvIbMSn?=
 =?us-ascii?Q?MNUX7jFNQ89UAyXZriPQOZIqBolI5ZWdBiZ/yN8kE6fXIUepxGm/xQdN1n+F?=
 =?us-ascii?Q?C+U2k/bF+0ylFaq0zS0fWSPErZJCGQ0Wwmk8+qZj0gWnuZDNCAAWM+OubBYv?=
 =?us-ascii?Q?vTYYLB7cJQ8CJnqEq6lZDcTrJoMFzwmsb5hnQukc/Z/MAqZsr2Tyrnb+7YKi?=
 =?us-ascii?Q?vinTHzImGXUCCnWfWba5j1ZLBIB8OsDyEoX2al92EOZ3eSJQJX5RGw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(1800799024)(376014)(366016)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JUsDXvrgXvE50QcmR+iKAzJfTdoToej84t4srNgtGENsSogKVYGFZPk9RAgU?=
 =?us-ascii?Q?ZcXKEQ6EW+9ZYDDzvnpcoLsh2gIM628H8Cg7XSLG8HT9yXuxGdhIDnMpR2rK?=
 =?us-ascii?Q?3br+rspwW/5KDq38yGKWbXduzE2bnut1YCkPDb3888xl2GcfFgfqP6RdMxQ6?=
 =?us-ascii?Q?EK+3cWBS/DgMYwwnzrpKaZNffkXZQEFMTc0h805096j3wu6UAy6ZVSLz3erO?=
 =?us-ascii?Q?ncUKMmeakE/l3PD3srJ7zga3hraPJKhHxvkX886rlCxgnPCiL3kl42OJoMM7?=
 =?us-ascii?Q?A31vYi85ItT8rUw7sjpB8vmHY6GHXlW0hMd7+87Z3JH3x9Lo4AxcEfddViGe?=
 =?us-ascii?Q?EQlqWk78h49+YnPRwiXbZM8Uu6EurU9IHQwSVP9vQBM4avPXPkGWSE1xGsuN?=
 =?us-ascii?Q?eaVSWYZZEgyf8CvioRkuIg62YOMEkp6Q2DnL76tuNBoVmNEJm4OO+pvdyMa1?=
 =?us-ascii?Q?3R/+IhmyQgj1vFSQHAl9qSq155rP+FrZU1vjtL/cy0lHAdPtsxFsFGDcdWFy?=
 =?us-ascii?Q?qHB2pLdfTwdsKfIs4Sy8JUyF6dr8pp1ZXPGmr3tVumsg9+deh9riu+zNaaOz?=
 =?us-ascii?Q?emqLG5WVqkIXqBhSHmLt5N8TM1C1oa3cNe1TyKbQ6QgnH5rv4iF4o9lYVlrd?=
 =?us-ascii?Q?ejCa9L48u70P3BsMe3JD/hqyHXXEcFnb1Ht+8Qobw8AzH6oVjih39WYDpJOl?=
 =?us-ascii?Q?3phOP9FdHHvGoHHJcyQiMbrLavBOVHUr48GY1XLdfbndNJjRsuSYPzwCl6xP?=
 =?us-ascii?Q?2efRT/fr6xWQneMSx1TNudoneveSOSkJKDTP23XCdeGySeD3Hkt/2hbgLE9E?=
 =?us-ascii?Q?LDXbrXKzskGylT67b8CwT2DqIf5Hz8kHB1ulyyJxtUodFKRYhCw7oI0VgVPC?=
 =?us-ascii?Q?R+v2hzAmDJWGy7p33Kut3BCnJUoroK6mIv8m7dSToPvrGMP0gHZWWQFpDHcj?=
 =?us-ascii?Q?sKAPBMcIzdP994ehNITuiXuFQiBDl0q5XtmEkvX/d0RzgIzgHBk+1QxH4fqp?=
 =?us-ascii?Q?HVO1C1A7HAGPb3ivXZ+nxFrMdpS4XExnSIh1iYmmjZbBhxyglEv6axvvw/64?=
 =?us-ascii?Q?w0ZHvCnrGirdUyJ5iV6wqcP9O+LtyPYmWNcLsr0TE9flGhwFVxP7afdb8qh5?=
 =?us-ascii?Q?oSRmErfGXw65UZQnNDsAyzNdsndspTsXp2hn2eheHHkDS0zSreLBqIX7YTBZ?=
 =?us-ascii?Q?EgtK8XwAvU23ky1dBWbEnOzV+bCZv4nQURlGatrZuzSDQ0OdXqwZLjLQHhBK?=
 =?us-ascii?Q?p++Ypk8Ux6tK3BKuYtTH9xo1PLuD/c0UffKIgYd4AjptMqD/LwyzjUshC/OH?=
 =?us-ascii?Q?GCNxRsxaCGfdhA9zcnKN1z+ypXygqX72OreuvEGiFm9TP0kmymfreZ+xafyQ?=
 =?us-ascii?Q?NutK5v0LqeJ5MbV1P9Zz+Bk9R0pgi9ii3FDYgSN7oUFmJmCC4Ze27CTTWzHf?=
 =?us-ascii?Q?H49sJYU8eylkbRIMv1ThmO+hi+FLGbtHIFmWo7Ycv2qgvljUYSLRyMUypfcG?=
 =?us-ascii?Q?Kr07aQ0fnV/qM5Nn928NzSjs6PYMVGgdEytY3xWlmKVewrEZpCKHcUjlaYmk?=
 =?us-ascii?Q?8Ax14/rMRJSZcyrVjCrcn+u3bjF0OWpoAUV1qewu8r8ksFFtzzTi5zL9bCfw?=
 =?us-ascii?Q?alIc+s7Gszn0JT7BCuo387jTEzJZBz63Rz7HyvtIpF0E?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eff65dff-108a-4994-b832-08dd7d5894e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 02:35:56.4600 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kl3Sb8x6K9fU+pP+nUh0bPV8iT4ggRZacT5uEaS0Cf+AFWDdmTNTN6Ji7nxTEbq6b2a0EXqSHEe0gIHop59gaI2HSjNqP2CgQaEyxEEgP1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5065
X-Mailman-Approved-At: Thu, 17 Apr 2025 06:57:49 +0200
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
> From: Tom Rini <trini@konsulko.com>
> Sent: Friday, 11 April 2025 10:53 pm
> To: Maniyam, Dinesh <dinesh.maniyam@altera.com>
> Cc: u-boot@lists.denx.de; Marek <marex@denx.de>; Simon
> <simon.k.r.goldschmidt@gmail.com>; Simon Glass <sjg@chromium.org>; Dario
> Binacchi <dario.binacchi@amarulasolutions.com>; Ilias Apalodimas
> <ilias.apalodimas@linaro.org>; Heinrich Schuchardt <xypron.glpk@gmx.de>;
> Jerome Forissier <jerome.forissier@linaro.org>; Mattijs Korpershoek
> <mkorpershoek@baylibre.com>; Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>;
> Michal Simek <michal.simek@amd.com>; Dmitry Rokosov
> <ddrokosov@salutedevices.com>; Jonas Karlman <jonas@kwiboo.se>; Sebastian
> Reichel <sebastian.reichel@collabora.com>; Meng, Tingting
> <tingting.meng@altera.com>; Chee, Tien Fong <tien.fong.chee@altera.com>;
> Hea, Kok Kiang <kok.kiang.hea@altera.com>; Ng, Boon Khai
> <boon.khai.ng@altera.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@altera.com>; Lim, Jit Loon
> <jit.loon.lim@altera.com>; Tang, Sieu Mun <sieu.mun.tang@altera.com>
> Subject: Re: [resend v3 00/12] Add Synopsys MIPI I3C Driver support
>=20
> [CAUTION: This email is from outside your organization. Unless you trust =
the
> sender, do not click on links or open attachments as it may be a fraudule=
nt email
> attempting to steal your information and/or compromise your computer.]

Hi Tom, Rini,

Submitted patch v4; already run CI for these patches, and it is passing now=
.
Thanks.

Dinesh

