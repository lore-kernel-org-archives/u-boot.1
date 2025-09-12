Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B812CAC58E
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 02:39:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B73A833EB;
	Fri, 12 Sep 2025 04:39:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="cxAkjj+b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78A1B833EC; Fri, 12 Sep 2025 04:39:01 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C2748334F
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 04:38:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sA/5A7fVJVkesS8XS4LNEAHQeCXwYHI/fjIQp496fIA3Tl0UVQO9u1zII0Muvp9Dt9i4arbU43KjzzDIJaDjs3KeWwUeqBjyFYBgEhmCKqb2XbpfVTB0b4ucwmBfe92MZACcXblrvyt8aTWA2zPDGWm8y/rCRak8zivb5EFbCQKRGz9pd2JGb+9Z33sPqgcoqlDIjSDV4wYLJvFB2jRNWKTxMG9OLTHi6nTBIZjaOJCysITKygx7+zeogrxRo3NsKVGkBRifCmMwSvQDzPJ8/p/TrYstqv0B2ag/mbBqmova1z1YgLoyaHkbh102w6bVg29PkZfqS9rjwjzLMqds6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkS6+X+0D3HVxMUrRJB/Mj/NunwSm9gckmR2yrSDHvA=;
 b=lADUBIv1QnxeaRJjkG9KCknlZMJT/NAw78Uabvzqy8fQebBBo1dAamQF8oJmTJbRhWCIjA6an3tTlDswKSnSL2/d24UU9hqB055Wd93zot+qC11c/kB0v1KmQu8rM1zVKGDkOaE5l4wv024uVxL0BmTPIAxY+3upS6L+Ebjnvv0n9i05yC81euRRX6qzJGQVauB2ztMPQe5jzQbgIgeaK2y8s2sh81E3QZuwNvTtXeKy8yZguLjqy0ZoIffp//WyGnGJFUXp16L0VKigHLL61eLbYPvedGpNd1f4W+rC+qYs90NbvuTXC1B41upHGjEatTklkkVn0SX+NUvU+WUOQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkS6+X+0D3HVxMUrRJB/Mj/NunwSm9gckmR2yrSDHvA=;
 b=cxAkjj+bBc7hqJ4Vw+Sxt5BLN4e1JUxoQ0stsgAdRtwos0yubz/uQQg7UGGoK8Zu9mnjoB7jR9dHhQQv+gXi/v66NS9dNr7pdAsxPBsWQJRM3cbs7lc3qVqCmQhKtI2FtEoMXTCrzHdqUNxINqwhDponybBVLx3WGewwTgckw+dbtNrZwK1u0ivDPVuLJ0eNLIwvKduYZ6AYeNLon8Zef7m9yfOcoRs2NrSRLZqFxIPzV7ChJjCa6ZWPqURxDpRqEZ6a2YHIq5PX0iD2+QRL7B06gc8AtWFIz0GlFgWtYas1Nz/W6uJRqvuwZfWNKxSF+F4WmgyiWe/shUJjMXNdoQ==
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SJ0PR03MB6342.namprd03.prod.outlook.com (2603:10b6:a03:390::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.17; Fri, 12 Sep
 2025 02:38:55 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%6]) with mapi id 15.20.9115.015; Fri, 12 Sep 2025
 02:38:54 +0000
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
To: Tom Rini <trini@konsulko.com>
CC: Peng Fan <peng.fan@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, "Chee, Tien
 Fong" <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>, Marek
 Vasut <marek.vasut+renesas@mailbox.org>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>
Subject: RE: [PATCH v2 1/3] include: dt-bindings: clk: agilex: Add Agilex
 clock definitions header file
Thread-Topic: [PATCH v2 1/3] include: dt-bindings: clk: agilex: Add Agilex
 clock definitions header file
Thread-Index: AQHcIS9EXK9rj2JvcESc/M/9iiybRrSNhoyAgAAL+bCAAIGHAIAAxlXQ
Date: Fri, 12 Sep 2025 02:38:54 +0000
Message-ID: <PH7PR03MB7063886829175CED9C9072B1AD08A@PH7PR03MB7063.namprd03.prod.outlook.com>
References: <20250909021116.12599-1-alif.zakuan.yuslaimi@altera.com>
 <20250909021116.12599-2-alif.zakuan.yuslaimi@altera.com>
 <PAXPR04MB84591699BEC41960D222BB6D8809A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <PH7PR03MB7063972B766EC67BA14BA639AD09A@PH7PR03MB7063.namprd03.prod.outlook.com>
 <20250911144900.GL124814@bill-the-cat>
In-Reply-To: <20250911144900.GL124814@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB7063:EE_|SJ0PR03MB6342:EE_
x-ms-office365-filtering-correlation-id: b3784a0d-46f9-4f0a-7b1e-08ddf1a5844f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?dXKSRZlYHnkdpAYKYXOKN8PDyAt69KKdNJOT15AklnrZ0p9NDMwgRvvJJUFh?=
 =?us-ascii?Q?0e9YqxFCURXAps7xg9skEI3pps37Wbn7pu8gEI/+wmcgGvQVANFcw9ffUHx6?=
 =?us-ascii?Q?uoZW7St8xsCIUh7JrrUOE0BRcz54Aa9s2NTYtv3wB0N+N514MmTDvSF60wge?=
 =?us-ascii?Q?0OY5HQscC1ZBYmz4LdxjuQnzb4rdJVNc4eq3qOvbl95qhG6rGn6v2uUKlksm?=
 =?us-ascii?Q?2EBWy12DMEZHb/S8o+DvC1pQvSAKavIct17BeUGRzY+iNDM2vz3ZPuFH3SL/?=
 =?us-ascii?Q?I/wBcFQqQ9G0q8a/vESJ3ENg54UAWWjjBoMb4rKSSSMOAuZeY8z9S+6Jp2BK?=
 =?us-ascii?Q?oFbospvpo4KOjm5xSVVtRAbgu+Ea+zVxr1PW42xAHYezAxTppp3vwZgovKkb?=
 =?us-ascii?Q?5ohbjCwJ3iRfMdF2+LUiWBLwL3hJkZUMJEgKpd+VvvWnVeNXl2Z1o/9jpP/6?=
 =?us-ascii?Q?oJqpuMcQYIpWKWDigk/mOEX9ifnk1slnS9+5pRIL4m0ZLsd/98vlBXhCJGV0?=
 =?us-ascii?Q?QMCepV4Tn2n2Upr/R0WanHEJGuKO1r3cBPbWzNQoFjPMlqYQJKVp4H+/6kUz?=
 =?us-ascii?Q?3xiPG3taXmpwXLITMIc4Y8czjU7iwQYPAlH8RkPeXqmQbH5JvO5bC4BDFYPa?=
 =?us-ascii?Q?bYpDoRSqU91p1Nzweesx75Ijq5oTsL1ykq56Vwalj8NlJ/ZxbPZTGE8I+Zrp?=
 =?us-ascii?Q?RhZvk+Xxb5kXvzKYha9yNZ1aWDvaq56WOjbpL/NzYsIdb6j1323YBbCbvsRZ?=
 =?us-ascii?Q?gpVwjHswDEwlgoT9AecDD6ifWXjxBjZDp31PfUUhVdUFu6fGTHXv+pllMPzw?=
 =?us-ascii?Q?9bDVHOte0Lua3noYoj782Vr7sCk3CdP7yoTrO87yTOqSB1MXfv/5lZZpNfMt?=
 =?us-ascii?Q?TqKT210v+YOnED8by+UTB9pWPsKeFKBJxrleRsc4rxh2oY3bpCSFOZKMqFBC?=
 =?us-ascii?Q?CQFEOTXaQdH2z7K5g1BsvSXfIZiQDxaH8ul20hku6CZFVnK5RzcXI9B7RXBs?=
 =?us-ascii?Q?IYBdED2mdkcWKODsK6fLwx5PjndrgbzomdJZq169V9xpfwCCgSvBp9a1wddt?=
 =?us-ascii?Q?5YmZStnPs+KUl4StR4nZlVp8AfO1EQ/0dAvLvfxKcbjCWc1HcFhEt8fMirHq?=
 =?us-ascii?Q?SLUMZDzrJ99GErSQ9NOP+evrYAiPenFoyVaMaBiwq1oD0rdAcb+UNDJYAbwc?=
 =?us-ascii?Q?u43To1gFy3IkGyBAGS8PnBcfU+MJ9Ofs/zKHC8qZS0vLAZGEPIxWPatiQYFb?=
 =?us-ascii?Q?k8qcoBIPnqbu5wOkTUyhtQkNQ3WsI4F+Kv6QpG+2hxH6qKi5qzXIuv+t3kPB?=
 =?us-ascii?Q?tjKAtM0hHmBRz0XB5s1Dg8m7xmiwcfz0O1tAkFo9ER1DP5evTUIouiF0mFag?=
 =?us-ascii?Q?REtO18Lr2ZCTkBuM0I/qaru+rafoOn8XWSqhha9uVFF8WH/Rx0q1JPSeah6p?=
 =?us-ascii?Q?NyhCnKGQ+jT0LVDnvk+fAa5SbiPTc21ITrT6M24Ya/9E7SCTgs4aXQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pBkbRx/Z27ZnBzqlLSn2+zdcAs6ezJxAo1wb2isprO7dAI22aVfrrwF4tFe6?=
 =?us-ascii?Q?4DOTmkzZ8KazQRPkiU+cE+2uuwXRfwx5rqCIGZCwtxQ19oliQyKEPPSKIZME?=
 =?us-ascii?Q?+5Ajr3NYCDucf+BTZDcxlBfYoZFzr4rsjAIvYhbyfrN0p1/bLBLGM1O5HjZO?=
 =?us-ascii?Q?3gffOkDvjAGRt0dHO5L4VD6LIBlhtoWs5Zih5GcL9Cj8F05GRGS8x4OJLfw6?=
 =?us-ascii?Q?UAJPuBWwfxbQ/2EcrJaZwdZmThRoAiSm2CnM9gNkLJC3NcZFSbq6E3zFre7P?=
 =?us-ascii?Q?DKG5PLjrNctcRvAWG6GoIOJoMm6r9tArbRUKPRoxYeR9Uk8lWoo9Wi1OSFbm?=
 =?us-ascii?Q?NHB3azQYisDyJ81Yd16pwtqMj1WX6buxsf5qF63Ql7izDOMIiexjNKsPZRCz?=
 =?us-ascii?Q?5IUFjqK6o9mL6QsuW1SxwaYrqUWGt7UWXnNAYJ86ppomVZVKZ8dQ+2yTDNAm?=
 =?us-ascii?Q?v1jLx80PbQWDEio9pReG3GW6Gy8cA3scrLAqw9382HHV1qXmzmEKoc1MSU57?=
 =?us-ascii?Q?dIARgmTyIJBg3BeT6m+IRZxSXW87Qqr0djgrf9B4phOcVZvJTTBCoKCoSIjP?=
 =?us-ascii?Q?rFmcV2cDbIKbCIaMY3crMD4lW4ET2WsqWMxeJrIHzj2kngu2tT2f6QvWg5DJ?=
 =?us-ascii?Q?kUuEFpbECvrmJ78STqTQOQP+ivJWoUAqPfyZ7cDZWXD2WBL72Sjg8VO5iKzy?=
 =?us-ascii?Q?xxSTyFhwOZ5oUQ+VZafDF/KrfYaoap+iZTulp6voV2T2zC5jReuHTBrhgGHn?=
 =?us-ascii?Q?HFpnDb3qmx0FAQnHVrQBjqA4gPoxC/dGZ81A1IoJbYZLfUvGtlJZOO6WoCgU?=
 =?us-ascii?Q?IWmSEx6ahF2ECSqJMu2XT931VeaZEbfLSEX0VnnSx/H1xaVta8y2K+zkew5h?=
 =?us-ascii?Q?Vu/j+sP7RnCvXgoONAxQHcsdT2NcpRHq02p5LTe4oB84YjShJqpQXTKqrhbG?=
 =?us-ascii?Q?RGa1Zi8YjWZYFBE7IptH0Z59TRxGgaq8Phy/uOCSue7AsMfrG/y1x61armHj?=
 =?us-ascii?Q?LYqB9mvQo8WihkWKQiVwbwfd+S9hr1NL4pSaQl4CCDBs7396pQGAbOopdAmj?=
 =?us-ascii?Q?Poakran/bJQLym8kmRnO8YcqoZndIQnxLXHLplS+tDmfyPAAkij3jTroI6H+?=
 =?us-ascii?Q?ZRSJgiUfVYUMMwhMh+4E1yzui8CpQhuajaLcFvRrbs9MSkBWENCySLfBEN5+?=
 =?us-ascii?Q?9QQBbxyqsuUVjEHO8Y1znPq2XiahlygWq+7y5mcP75Rb5HQC3N+s1KuYKpDH?=
 =?us-ascii?Q?v1zm5ma5ndxoKhmovm2S8amMDW0eozsR5x3Z0nggGmeD7Epf7HCtRXHKveOK?=
 =?us-ascii?Q?3buRryGSxZ6Ei8lBp0z0iJ0znMmUUotYcWY4pMqyYWQzURHj3HWLc/gQZsmF?=
 =?us-ascii?Q?xiOgDOdY/dadO/qVrsMGg2oyxJVYtN8jLAsF2HFj+pbXZsVo++lpcgu3XmoN?=
 =?us-ascii?Q?5VgOGdjvXMUDSWLTF6vdajIAuQ/VBNHHwctw83JxrIoX+W7n0PyYj5ogktQA?=
 =?us-ascii?Q?OpWWvZo+KI62jHR3mHKKzfoE+QFzVFqHnwy6eAcbU2Rpmpsji+/Ks0z4IFo1?=
 =?us-ascii?Q?7w8ShDgMxkacRIcDL3eND9SuDOqy/sIdVmqnQetCmK4JlyLnEl3kFLxqQfOw?=
 =?us-ascii?Q?Ag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3784a0d-46f9-4f0a-7b1e-08ddf1a5844f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 02:38:54.7647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NjRSzzJl09fQ+/ykY2lmfC6WyL86JeFWudDFYrzyIuS6sEUNsBGd3Is3VcqfjPRz82jwNqTMyjLjJo6810XHRZ0GPPJHMlhGI6iWM9oBFKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6342
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
> Sent: Thursday, September 11, 2025 10:49 PM
> To: Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>
> Cc: Peng Fan <peng.fan@nxp.com>; u-boot@lists.denx.de; Lukasz Majewski
> <lukma@denx.de>; Sean Anderson <seanga2@gmail.com>; Jaehoon Chung
> <jh80.chung@samsung.com>; Chee, Tien Fong <tien.fong.chee@altera.com>;
> Simon Glass <sjg@chromium.org>; Marek Vasut
> <marek.vasut+renesas@mailbox.org>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>
> Subject: Re: [PATCH v2 1/3] include: dt-bindings: clk: agilex: Add Agilex=
 clock
> definitions header file
>=20
> On Thu, Sep 11, 2025 at 07:17:32AM +0000, Yuslaimi, Alif Zakuan wrote:
> > Hi,
> >
> > > -----Original Message-----
> > > From: Peng Fan <peng.fan@nxp.com>
> > > Sent: Thursday, September 11, 2025 2:23 PM
> > > To: Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>; u-
> > > boot@lists.denx.de
> > > Cc: Tom Rini <trini@konsulko.com>; Lukasz Majewski <lukma@denx.de>;
> > > Sean Anderson <seanga2@gmail.com>; Jaehoon Chung
> > > <jh80.chung@samsung.com>; Chee, Tien Fong
> > > <tien.fong.chee@altera.com>; Simon Glass <sjg@chromium.org>; Marek
> > > Vasut <marek.vasut+renesas@mailbox.org>; Simon Goldschmidt
> > > <simon.k.r.goldschmidt@gmail.com>
> > > Subject: RE: [PATCH v2 1/3] include: dt-bindings: clk: agilex: Add
> > > Agilex clock definitions header file
> > >
> > > [CAUTION: This email is from outside your organization. Unless you
> > > trust the sender, do not click on links or open attachments as it
> > > may be a fraudulent email attempting to steal your information
> > > and/or compromise your computer.]
> > >
> > > > Subject: [PATCH v2 1/3] include: dt-bindings: clk: agilex: Add
> > > > Agilex clock definitions header file
> > > > From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> > > >
> > > > Introduce header file to define the clock indexes for the Agilex pl=
atform.
> > > >
> > > > Signed-off-by: Alif Zakuan Yuslaimi
> > > > <alif.zakuan.yuslaimi@altera.com>
> > > > ---
> > > >  include/dt-bindings/clock/agilex-clock.h | 71
> > >
> > > This not landed into linux kernel?
> > >
> >
> > The existing Agilex clock header file in Linux mainline is outdated
> > and missing several clock ID definitions required by the current U-Boot=
 clock
> driver.
> >
> > To avoid dependency on Linux upstream progress, this patch introduces
> > a self-contained copy of the updated Agilex clock header file within U-=
Boot.
> >
> > This ensures U-Boot on Agilex can be built and function correctly with
> > the latest values for the clock driver.
> >
> > We can clean this up later once the latest version of the clock header
> > file has been upstreamed into Linux mainline and synced over to U-Boot.
>=20
> What's the progress on syncing this to Linux? I am OK with this path IF a=
nd only
> IF once this is in upstream Linux any conflicts will be quickly resolved =
here in U-
> Boot to use the upstream header.

The plan is to submit the same header support upstream to Linux, so both fi=
les will
be identical eventually. Once Linux upstream and U-Boot sync is complete, w=
e'll update
U-Boot to reuse the upstream header and drop our local copy to avoid diverg=
ence.

In the meantime, this patch provides the minimal support needed on the U-Bo=
ot side.
We'll make sure to track Linux changes closely and resolve any conflicts pr=
omptly.

Alif
