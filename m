Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E34FC87FCE
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 08:49:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 301AC832C8;
	Mon, 28 Jul 2025 10:46:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Fe53dl+A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA04B82F8E; Mon, 28 Jul 2025 09:00:59 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0522182F00
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 09:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjN4cmggkTGAuFIdhoeQLHNm2KfE6XZPYVz2ah/FDqy077gTvFOn2hj3pDqBko2dAaWweSAgldqT9EivEeCYPfYlPLY4Beze/a9Dlfy+H7zawY7d7AcaIc9ehfnBKYPlDMCDn0XyBZlDFbYPm2ZlQhj7Vj7Pmnc1FvhlwUelgROZ/ATkbdFB45imWF4oaPKkD3ZYNxAM/TGLhG771VeS5GXMkismm7IxcUW8G82pjqNAhmqgXgvjak4OjWwX1Gplquh/4+UExaqt/jEn8sEZ5pJPhOF8UWe1y0zX4M1XKVhC57IrUl9aXsXss8MwP3m8bFyXL7a3/AQP3KUby7hy0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3USrWNDKpN2CdNVn8gZxtszm5DxZlZX1sFx8Fxia4Yw=;
 b=uAVfRe7s9qChPxUivuyxswJD7RlXkUCY6TAThnHfJRQeo3IufEM6m9B14scopJM97Sg4108igFEeDmLet/Ksva+pZ/fuv3F+3FGq1OhmrLL2Cbw+JVdAIg2yWTGTDRiFYVDKs2sd31zPDeTWwVVhWh2ncEdJItv9SxogOcy78/aDl8Wvz0gRBnC9U/fBwws+7kV/zYbh8MverTUwCRecgYjKYV3vqmfupw+JII7RrOA5YbWHW+5R6/oeUHO97yByZRznE1wHwzdMhXB9I9PA07FgcXtAh2TSPvUHTBR0+6XW5MdhPve+nET0N+y7/ShBpiUcDPwmsRrSaRQ3wKvIPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3USrWNDKpN2CdNVn8gZxtszm5DxZlZX1sFx8Fxia4Yw=;
 b=Fe53dl+AS70n0P++R0lOBNMTtLBme3H3cjbpoCVdeOCqRFFJ9F47AFbN9PHEE+/UeeRTr8cvksB/wOZsq1ebV2t+GDM69MUrDTHhuWJGW/52EMIklmEtSN7nY7xAyJ3yZ5JSzL1yWQt/H9tKFAKCcK/ipDi2x/BFJsRcfnR3Tjlet316H2YtLsX/Wtg9+3YgSHzk1wtYzQk+GllgVRY+yneK7XpMdGsoK4pgRZImcdHsd1lsZEJDbmlJmekP0lRZFz8XNHbkGJctFiyETSfsTTaKCgyda3YFrpbJyjIHk82r6ZPfzaiRy/Ye5kTJetPxx8ort97eEgIEoSjmLRv8Ug==
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SA1PR03MB8081.namprd03.prod.outlook.com (2603:10b6:806:45c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 07:00:53 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8964.024; Mon, 28 Jul 2025
 07:00:53 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Heiko Schocher <hs@denx.de>
CC: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>, Dmitry Rokosov
 <ddrokosov@salutedevices.com>, Jonas Karlman <jonas@kwiboo.se>, Sebastian
 Reichel <sebastian.reichel@collabora.com>, "Chee, Tien Fong"
 <tien.fong.chee@altera.com>, "Hea, Kok Kiang" <kok.kiang.hea@altera.com>,
 "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Lim, Jit Loon" <jit.loon.lim@altera.com>, 
 "Maniyam, Dinesh" <dinesh.maniyam@intel.com>
Subject: RE: [PATCH v7 00/12] Add Synopsys MIPI I3C Driver support
Thread-Topic: [PATCH v7 00/12] Add Synopsys MIPI I3C Driver support
Thread-Index: AQHb/4y+/bqcqUbjXEihpMO3sLKgx7RHGuoA
Date: Mon, 28 Jul 2025 07:00:53 +0000
Message-ID: <PH7PR03MB69423C4746FB6E025F699C89F75AA@PH7PR03MB6942.namprd03.prod.outlook.com>
References: <20250728065612.6039-1-dinesh.maniyam@altera.com>
In-Reply-To: <20250728065612.6039-1-dinesh.maniyam@altera.com>
Accept-Language: en-MW, en-US
Content-Language: en-US
X-Mentions: hs@denx.de
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB6942:EE_|SA1PR03MB8081:EE_
x-ms-office365-filtering-correlation-id: 627043a1-61f6-4102-e4c2-08ddcda47e59
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|10070799003|13003099007|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?unWRufjVwyQBLgZUT1VbeQaEyJ7V+5ocgY4q4F/WszEzz+A+avzMTKN/d1d6?=
 =?us-ascii?Q?Dil3l6xbBnBR0NdhK6c7Bu7TjUMyQ7JVCDm6/rae9bq3KspXf2QPpfRLNmPQ?=
 =?us-ascii?Q?lhSXvH8Ck3S7SLHQC0RGWsSJEF69udlae71fhiHmGgu927qmpROQH+kLr5On?=
 =?us-ascii?Q?Pmi8l4r+02SHkIxQefpAu1En4GGH6aDgzHP8VAl5x9q3bupd0Rk7aU1Bldfc?=
 =?us-ascii?Q?qZWxZbWyTBIswspWuhIK9Q4nvz3wNsqL6pOugra/wHZkQo5q3+HYDFA1Ozgl?=
 =?us-ascii?Q?WDEfuFKfC8pHUb4YK3Lx7VzWp8XBL3J7yCMueKceN2TBLqfSjw12rpiQ5NBd?=
 =?us-ascii?Q?1OHJdhljAGyYDDSlOPodlFSgkYwJsFODow8OZGRcsS4DKFwgTn0TiQ/19AuE?=
 =?us-ascii?Q?XyG28qW3kG9TH69N1JNHYdleJORMmQP3hlZBxUaiYv33BRx9AcMU7Frn33/y?=
 =?us-ascii?Q?tt7XQl+tkdd3Liqo2c3cU4GHpKWpXu44rKJU8yRHsT8tzaKcvo52fPwvTNHh?=
 =?us-ascii?Q?4j+mAPT4z9pJhbNbi9miCbSEkyV4GSm0xSbCvOYZDWecfa1WAB7pjO8Q1qGW?=
 =?us-ascii?Q?CiGIhs6GcEFe003WrbI7Dl/J9hjZmlvNSv5HZYper51mIIP/Rj3EfzWSUycD?=
 =?us-ascii?Q?uZNzD7Cv/Ei4y8J72rtMSEzPBcYGQBAoIA0KQZ8yRw3yTrCT159irkl6xa/B?=
 =?us-ascii?Q?srevG3lLVpF+eOLiYTPxvLhM3MD2dE9azxCgZwQfx1e4bVAH1fHh/YYGwHjl?=
 =?us-ascii?Q?Y7KCYQZ7T14ZTgjou+Lr0n/6efZPodencTEQt6ANF8CQPAfn8zF5w/s4Pt9L?=
 =?us-ascii?Q?RsQt7BovCf4Xm7CQDf00soNSKvcyMzLbkWEEcpZbqUoQ6rITC8+F+0SwOMVi?=
 =?us-ascii?Q?XgW953ndmRrrBWN2/lCb04IhxK9Mu6DhoRhDnjN8DEn1IyGNubiVSSPmpse+?=
 =?us-ascii?Q?n22tmUQ678T0ccdWAAghjzUIVbVt+Oxg3BAGUWDs91/ewLqGVWMlyXJwazG+?=
 =?us-ascii?Q?gsbszgRL/J/RNDSazeVwD7efaImHs7hp2bJi7FbKlcKbSrz9QvG/Y9qxD5T3?=
 =?us-ascii?Q?Jw6FfbysTusDlWpdxIVv1N5CXdXlVrNnIPPuEkuNrSXnvu7BY2uw96yx520e?=
 =?us-ascii?Q?RyeQ4ACiNLrXYUHJM66mkyijBwbDBeQT48rHDQXTvi7lHM/VUnq6aeLzh4RE?=
 =?us-ascii?Q?l0I+D8sxbp9fep4xykwRpG1Zo8PtvUZ1LOvJGyHkimRwyfkBSHYB+Fvb+Hdx?=
 =?us-ascii?Q?zeRCztPl6/Quz4kqXlRERoZdiord4KOUPnq4ImOET3RtjHYqmEzPCg5oMxbU?=
 =?us-ascii?Q?L6aOaE7yQAEYsUHgekr1ojl2M1lDQbPjzPoNMtVLSCAYw5bWzQVQKHpDkftQ?=
 =?us-ascii?Q?rKJwOA/lbNyuiwfKmrmMrN+osh56MQizXHHp0SLb+/LE9/IJGt030jgZMJ1e?=
 =?us-ascii?Q?8LrQBbs6ZCqu87y9kSIukf2oynx8JaB+TiNWN+J7SjBvTH4Twi7VWFCZoNjJ?=
 =?us-ascii?Q?gOOihQsfiatc7DY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(13003099007)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vB2k46jDBX2PxrDuwU5K/fcRBkwAfF/fc1sPM42j2GnK3lVQg8tmNjqRxjqI?=
 =?us-ascii?Q?asfcRV2fHfGDVDSPb0Wtu46dje3gOoyyWoYqVpaVZA6YByc7UGJEuIhgaWxq?=
 =?us-ascii?Q?+LTtq8z5B5uPYj3KVbrT7VPfj/rivRAToBx33wNAvuUYgutzPA2v88cf/eEO?=
 =?us-ascii?Q?57GOkOnKS5y0f/+NZRNxrTcR+WjktfOiPvg5Nl+qAAzEnhrERedKPFTuFIY5?=
 =?us-ascii?Q?/RDALqrl9uSkTJYEYwI/jd+v1xOaaIZmGXcjNn0TX0QjVWCUyq89W96kUCVL?=
 =?us-ascii?Q?KAVReNowNUzLnRyBxpHHzkHVRNAs3EIsnWerCwN0pVUTUFRIDiksULYbck0a?=
 =?us-ascii?Q?D6C5P7Y6IUbKb2YnjjL1KqZfGLIW2pxXuvYlbgvQo/mb6QHUF7KAZ8IUEpeB?=
 =?us-ascii?Q?vHqoNEMtQprb9uYMOmnOgiuzYzmlbgZyEe3jE1tF7/kCx5PcDhnQ6979Sc4T?=
 =?us-ascii?Q?q0qxDyry6vhUJ4qqKKQgY7kqw/67MFHQwpkCA+YtAc6LTh+D08tHUDFqs26m?=
 =?us-ascii?Q?LvMxochGkCfGerJXbUj0bTAEHY2EsjmopLNNKg6NksDKjMniEA34ok6a2+yw?=
 =?us-ascii?Q?B5zLSERydb6CQy22lx8a2d0ydNolZLD8i2DsabBMAAWqPkYjdF8lYSKtdwen?=
 =?us-ascii?Q?NMR4qqqSN1UEjyFuJixMLekXf7Gs6s57En4LYXUzNOh0vg1R5ILpDXaHpEQx?=
 =?us-ascii?Q?zySLZ8HzOUEFE6esKRe+IkIav2l03ioqa/G3o/f4+GaGVoqYaCvawZRN5249?=
 =?us-ascii?Q?6pAzR6DbIiBj/jlqqBkRuguHQFr7+BlQpbLaktkaCo3VdpTSw2Hc1ZIEwiCf?=
 =?us-ascii?Q?vRgvW64Oy85Kfhojwe++X/cw9qAFOxPnSPSwbAj/Yimjo/ZBqL+ZCVyVudc0?=
 =?us-ascii?Q?fEW8NQGAXyCAne5izV1Fj3OZ+WfVmiE77up93cpqI6TgwoCPTqSXMOCqOJ/Q?=
 =?us-ascii?Q?TDdTN0PpiW423a9Hp52QGU8s4I0n1efEsmDUgo6UsUWDhkUqx+20b9Z4iFyE?=
 =?us-ascii?Q?QaXpQxvH0Otyvcne07kgjofvhNDPL66ngfO2VxKKTuWzfndjlDwsdTknbj+L?=
 =?us-ascii?Q?++epSu3eABodv0av3BWR/G8BGj/PO4hP4N2/t+S+8iQlzQGn8jgorf85YVO4?=
 =?us-ascii?Q?xi8wY9PNm6x85qWGTE+xGzcDBO9pDm/9j4u+zaU4z2epIYxKSpquuNq7IZ7z?=
 =?us-ascii?Q?Z/uOn9Q/EXldQlGis91hyzXzb99HN5Ulz91vWFxWEzsDYyc0128bg6KI+SkU?=
 =?us-ascii?Q?ZbpGNa3JUNFIRQorXtKT5P/Tk9ZlJByLh9Sk8eAfZ5LQUXasAEeam1udIaK4?=
 =?us-ascii?Q?SKwNn2sppMVPu0oGlX+OYcVDhYzyAs2sr39jnCQk1I+Itup0D7A16JK80Vbn?=
 =?us-ascii?Q?u/S4NRKHKHtjx8YSlj46ytWDvAzffcQomnbp2bobdRn8NRAyofaFP8YFOiyL?=
 =?us-ascii?Q?PEkJtOQxD8BeDiJ8DNFlPZuSqdRtJdPIuZ46SiKnl+DkON1Wqdl7PZhETgLQ?=
 =?us-ascii?Q?qXG5h40O3RgHL7cj84ZxWGRMPHjqSMzNITOxA6qyGZ2CrYuiRJhMWuLf4UND?=
 =?us-ascii?Q?Tqm7/Ihp1qqZPjyHWSUbFYnvwuHkV52/DTqHzUrylMEaQNZrgmp1JnrcI4zu?=
 =?us-ascii?Q?F0Q3ZQI6GxscmQsFWC8gumINHUbCaDPJ8kN6RKvc5/bT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 627043a1-61f6-4102-e4c2-08ddcda47e59
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 07:00:53.4516 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uf3bOxpd/hJvzWF2/vKWCErCBbbASOh0QJw2zQW5ckOcwPMOs+WBWNQG1HCwW5SUzTiMRD/yvY9M83lhS7aeXQSwPWdsRtdNgc4OghsvJr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB8081
X-Mailman-Approved-At: Mon, 28 Jul 2025 10:46:50 +0200
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

Hi @Heiko Schocher

> -----Original Message-----
> From: Maniyam, Dinesh <dinesh.maniyam@altera.com>
> Sent: Monday, 28 July 2025 2:56 pm
> To: u-boot@lists.denx.de
> Cc: Marek <marex@denx.de>; Simon <simon.k.r.goldschmidt@gmail.com>;
> Simon Glass <sjg@chromium.org>; Tom Rini <trini@konsulko.com>; Heiko
> Schocher <hs@denx.de>; Dario Binacchi
> <dario.binacchi@amarulasolutions.com>; Ilias Apalodimas
> <ilias.apalodimas@linaro.org>; Heinrich Schuchardt <xypron.glpk@gmx.de>;
> Jerome Forissier <jerome.forissier@linaro.org>; Mattijs Korpershoek
> <mkorpershoek@baylibre.com>; Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>;
> Michal Simek <michal.simek@amd.com>; Dmitry Rokosov
> <ddrokosov@salutedevices.com>; Jonas Karlman <jonas@kwiboo.se>; Sebastian
> Reichel <sebastian.reichel@collabora.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Hea, Kok Kiang <kok.kiang.hea@altera.com>;
> Maniyam, Dinesh <dinesh.maniyam@altera.com>; Ng, Boon Khai
> <boon.khai.ng@altera.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>; Lim, Jit Loon <jit.loon.lim@altera.com=
>;
> Dinesh Maniyam <dinesh.maniyam@intel.com>
> Subject: [PATCH v7 00/12] Add Synopsys MIPI I3C Driver support
>=20
> From: Dinesh Maniyam <dinesh.maniyam@intel.com>
>=20
> This patchset add Synopsys MIPI I3C Driver support for Intel Agilex5 devi=
ces.
>=20
> The i3c driver is leveraged from the master/dw-i3c-master.c, i3c/device.c=
 and
> i3c/master.c Linux version 6.6.37 LTS And few header files included to be=
 part of
> the migration; i3c/internals.h, include/linux/i3c/ccc.h, include/linux/i3=
c/device.h
> and include/linux/i3c/master.h.
> Additional i3c uclass driver and command files added to support i3c read =
and
> write in U-Boot.
>=20
> Patch status:
>=20
> Detail changelog can find in commit message.
>=20
> v7->v6:
> --------
> - Remove extra variable in struct udevice
> - reuse the existing dev_ofnode to get the node in  master.c
>=20
> v6->v5:
> --------
> - Resolved documentation warning in include/i3c.h
> - Move declarations to the top in cmd/i3c.c functions
>=20
> v5->v4:
> --------
> - Add header file to doc/api/i3c
> - Rephrase function description for i3c.h
> - Separated subcommand as a function for cmd/i3c.c
> - Used memory address to transfer msgs from i3c
> - Rephrase description in cmd/i3c.rst file
> - Replaced int with unsigned for positive variables.
>=20
> v4->v3:
> --------
> Resolve ci test:
> - Add i3c node in index.rst
> - Formating error in i3c.rst
> - Resolve cpu_relax undefined for sandbox
>=20
> v3->v2:
> --------
> - Squash commit 10 to commit 9
> - Resolve index for new files to pass the checkpatch
>=20
> Commit: sandbox_defconfig: Enable configs for sandbox i3c
> Commit: agilex5_defconfig: Enable i3c configs for agilex5
> - use savedefconfig
>=20
> drivers: Enabled Kconfig and Makefile for i3c support
> - Add maintainer for i3c
>=20
> drivers: i3c: Enabled Kconfig and Makefile for DWI3C
> - Add empty lines for if/endif
>=20
> drivers: i3c: Add i3c sandbox simple test.
> - Removed DECLARE_GLOBAL_DATA_PTR
>=20
> v1->v2:
> --------
> Reorder commits.
>=20
> Added commits:
> - drivers: i3c: Add i3c sandbox simple test.
> - test: cmd: Add simple test for i3c
> - configs: sandbox_defconfig: Enable configs for sandbox i3c
> - configs: agilex5_defconfig: Enable i3c configs for agilex5
>=20
> History:
> --------
> [v1]:
> https://patchwork.ozlabs.org/project/uboot/cover/20250218025705.50051-1-
> dinesh.maniyam@intel.com/
> [v2]:
> https://patchwork.ozlabs.org/project/uboot/cover/20250314040902.43621-1-
> dinesh.maniyam@altera.com/
> [v3]:
> https://patchwork.ozlabs.org/project/uboot/cover/20250324083704.26259-1-
> dinesh.maniyam@altera.com/
> [v4]: https://patchwork.ozlabs.org/project/uboot/cover/20250417021840.621=
2-
> 1-dinesh.maniyam@altera.com/
> [v5]:
> https://patchwork.ozlabs.org/project/uboot/cover/20250513101913.30880-1-
> dinesh.maniyam@altera.com/
> [v6]:
> https://patchwork.ozlabs.org/project/uboot/cover/20250513101913.30880-1-
> dinesh.maniyam@altera.com/
>=20
> Dinesh Maniyam (12):
>   drivers: i3c: Add new i3c uclass id
>   drivers: i3c: Add driver for MIPI DWI3C
>   drivers: i3c: Add i3c uclass driver.
>   drivers: Enabled Kconfig and Makefile for i3c support
>   drivers: i3c: Enabled Kconfig and Makefile for DWI3C
>   drivers: i3c: Add i3c sandbox simple test.
>   drivers: i3c: master: Enable probe i3c without slave device
>   i3c: master: dw-i3c-master: Fix OD_TIMING for spike filter
>   cmd: Add i3c command support.
>   test: cmd: Add simple test for i3c
>   configs: sandbox_defconfig: Enable configs for sandbox i3c
>   configs: agilex5_defconfig: Enable i3c configs for agilex5
>=20
>  MAINTAINERS                        |    7 +
>  arch/sandbox/dts/test.dts          |    8 +
>  cmd/Kconfig                        |    6 +
>  cmd/Makefile                       |    1 +
>  cmd/i3c.c                          |  271 ++++
>  configs/sandbox_defconfig          |    4 +
>  configs/socfpga_agilex5_defconfig  |    3 +
>  doc/api/i3c.rst                    |    8 +
>  doc/api/index.rst                  |    1 +
>  doc/usage/cmd/i3c.rst              |  146 ++
>  doc/usage/index.rst                |    1 +
>  drivers/Kconfig                    |    2 +
>  drivers/Makefile                   |    1 +
>  drivers/i3c/Kconfig                |   27 +
>  drivers/i3c/Makefile               |    5 +
>  drivers/i3c/device.c               |  262 ++++
>  drivers/i3c/i3c-uclass.c           |   38 +
>  drivers/i3c/internals.h            |   26 +
>  drivers/i3c/master.c               | 2066 ++++++++++++++++++++++++++++
>  drivers/i3c/master/Kconfig         |   11 +
>  drivers/i3c/master/Makefile        |    3 +
>  drivers/i3c/master/dw-i3c-master.c | 1062 ++++++++++++++
>  drivers/i3c/sandbox_i3c.c          |   56 +
>  include/dm/uclass-id.h             |    1 +
>  include/dw-i3c.h                   |  252 ++++
>  include/i3c.h                      |   93 ++
>  include/linux/i3c/ccc.h            |  385 ++++++
>  include/linux/i3c/device.h         |  286 ++++
>  include/linux/i3c/master.h         |  698 ++++++++++
>  test/cmd/Makefile                  |    1 +
>  test/cmd/i3c.c                     |   50 +
>  test/dm/Makefile                   |    1 +
>  test/dm/i3c.c                      |   34 +
>  33 files changed, 5816 insertions(+)
>  create mode 100644 cmd/i3c.c
>  create mode 100644 doc/api/i3c.rst
>  create mode 100644 doc/usage/cmd/i3c.rst  create mode 100644
> drivers/i3c/Kconfig  create mode 100644 drivers/i3c/Makefile  create mode
> 100644 drivers/i3c/device.c  create mode 100644 drivers/i3c/i3c-uclass.c =
 create
> mode 100644 drivers/i3c/internals.h  create mode 100644 drivers/i3c/maste=
r.c
> create mode 100644 drivers/i3c/master/Kconfig  create mode 100644
> drivers/i3c/master/Makefile  create mode 100644 drivers/i3c/master/dw-i3c=
-
> master.c
>  create mode 100644 drivers/i3c/sandbox_i3c.c  create mode 100644
> include/dw-i3c.h  create mode 100644 include/i3c.h  create mode 100644
> include/linux/i3c/ccc.h  create mode 100644 include/linux/i3c/device.h  c=
reate
> mode 100644 include/linux/i3c/master.h  create mode 100644 test/cmd/i3c.c
> create mode 100644 test/dm/i3c.c
>=20
> --
> 2.35.3

As discussed earlier, I have made changes to pass the ci.
CI is passing now for me.

https://github.com/u-boot/u-boot/pull/802/checks?check_run_id=3D46661813275

Thanks
Dinesh
