Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D66CD98C6
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 02:56:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60BC3849A3;
	Thu, 11 Jun 2026 04:54:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="G0UQ8TSr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2173F8491C; Thu, 11 Jun 2026 02:09:54 +0200 (CEST)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c40f::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42EEE848BC
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 02:09:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ryan_chen@aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prU8AHNyDcbjLEzUwKMefPldRzRWAMZkbFSX4OcYSyNEtLuFV1hnOnqmsev4igI4aHoLyHF56HQgwWZXDVPYyNqZSREI3/nrxCGYmdKTwRnWNhDsN9/OC1mfdZYVAIJktaFYTtzKGzjjAsww3SaINtZLzh75lBxm1MMl8RUwtk4nIS5diLUK/ucefM3mgVcOdBOI+MPkRTKADUK6UdpaHSlIXZ5RlvBh0vT2N+Xy8UdddkYOonTUHPax4F1ha71JVp9nW53v2bLaRHy6D/AJkB939iWJ2QYSpSvj0IF0S4LvstjqR6EtvoPd1isTO9IWnRfW8vmvQZB4BlwSzMK92Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clKxSGKtFm7XIVV9wetrFt3xH1oVa4762paAwao9YHE=;
 b=NM7F0gGamVxD9rxlWRAEGuNu8YiISIUZ4LHTOFP/h3LKLgbbictfzM0mkuNSoV4JqF7XR/khh/nDoSb0Zc8sNhKlFPq3PZ3aKtCrN8+kZAicXbwVWcoZ6LXZAoBwyPlJIhKVgckL/mL91Hq4OOjEovlZ9AqsRsLgVQjc78AdJ5XYANgGTW1JynOjsLbRVFBhbM/8/fO94AjZ7ngYL22SfOkoxCmSSwZjVS3dfoIa5vUN3A5CK025Sr2ibUhA7X6aR7wVi8LdKSRbxOsmrN0WwLAV/cVo60zdEkx1jz+Nen6cGjFnBiut/dkllvNEH+3cgTWCMacYs6GRix6ktLpoHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clKxSGKtFm7XIVV9wetrFt3xH1oVa4762paAwao9YHE=;
 b=G0UQ8TSrAGFXCN05CaWwfs52o3sVTdv5HtP0XI4HphRXpLqyuVQ7TDhE62/N2XjN6iF82QLXOOvMTswc17MDGjh8U5liaq/ex+E+sR4DAbbpj/qp587WgUoOy7/WHKFCSxMjJOVfEIYusR07jH2Y9NZ1efQZ1Ibc8nuqEBClVM+Na3fwTysCL4n1f91r2RzayWruYmtE+rbonuXGgK4hlG4HBUPHpi2xMeeVvZ9FvGw8vHxBqlx+TmEVpvul7lo51b6zcpsAiY14HadvaALoP3n5o7GN6tmYMGdHx8sOGNAnDUxe/Yb1GuhijyLYDCYULmvHe2vKT6d4a6ijXFvLhg==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by SE3PR06MB8406.apcprd06.prod.outlook.com (2603:1096:101:32b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 00:09:45 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::b696:e104:1f5e:7838]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::b696:e104:1f5e:7838%7]) with mapi id 15.21.0092.007; Thu, 11 Jun 2026
 00:09:45 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Tom Rini <trini@konsulko.com>
CC: BMC-SW <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Lukasz Majewski
 <lukma@denx.de>, ChiaWei Wang <chiawei_wang@aspeedtech.com>, Sumit Garg
 <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Tien Fong Chee <tien.fong.chee@altera.com>, Andre
 Przywara <andre.przywara@arm.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Peng Fan <peng.fan@nxp.com>, Ernest Van Hoecke
 <ernest.vanhoecke@toradex.com>, Brian Sune <briansune@gmail.com>, Johan
 Jonker <jbx6244@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>, David Lechner
 <dlechner@baylibre.com>, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Janne Grunau <j@jannau.net>, Paul Kocialkowski <contact@paulk.fr>, Patrice
 Chotard <patrice.chotard@foss.st.com>, Gabriel Fernandez
 <gabriel.fernandez@foss.st.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Finley Xiao <finley.xiao@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>, Kuan-Wei
 Chiu <visitorckw@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, Quentin
 Schulz <quentin.schulz@cherry.de>, Stefan Roese <stefan.roese@mailbox.org>,
 Jerome Forissier <jerome.forissier@arm.com>, Philip Molloy
 <philip.molloy@analog.com>
Subject: RE: [PATCH v3 0/5] arm: aspeed: add initial AST2700 SoC support
Thread-Topic: [PATCH v3 0/5] arm: aspeed: add initial AST2700 SoC support
Thread-Index: AQHc7Ke8r8q9DzgzU0apsQGQASmET7Y3JRJQgAEIegCAAGY6gA==
Date: Thu, 11 Jun 2026 00:09:45 +0000
Message-ID: <TY2PPF5CB9A1BE64531124EC1A606FF63FEF21B2@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260526-ast2700_clk-v3-0-a4cd24c214d6@aspeedtech.com>
 <TY2PPF5CB9A1BE61846EEBD7BD6648BE188F21A2@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <20260610180324.GC382693@bill-the-cat>
In-Reply-To: <20260610180324.GC382693@bill-the-cat>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|SE3PR06MB8406:EE_
x-ms-office365-filtering-correlation-id: 08e30f98-e356-4064-d3e7-08dec74dbe3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|38070700021|22082099003|18002099003|56012099006|4143699003;
x-microsoft-antispam-message-info: LO7dyvrljMjUJrmmjekxpHEcUTsxxIM27W3aY1eNQx14ucVmGeybzfEIr+66rfWYaBOcMtEZgNDYj0TXXHom6oo+JSAPgFN8AyiIb3eSKiqPOEMCR4eDIFQdKRTduuSU5YEgx5l1n4bctbyYLyuN2HThUOAChDnB2GRYb0dIrMANHFyGg1eSllKCv9UyTGZAigTb145+AHGGhr7TfPowUVwBeV6F+dqrMkeNWLB2yenhYYJpkam3VYV3S7gpH9uZP5Phqdfu72oYP3IEIr+VlMeK3mFbIjfdzVEqq3MKSKQw3HUZzEBYAmTV8/VFDLQHp++zd5NP/LAUYI0K5ig1QPf09WBd+TTChlqu4QT7xo8NgVqw6CrU0rfXBJFMSqZRF4Yx6hQBwI1G2afXYZbOo6DWNhnnInow884Dp/7+BjyVAlZVNG/J8U0XToUSyMBIkjlC7WzeA60K8V7BsH1VPdds6p/MO0uYQryQFYueEFWz1YfPXOzMLqzSYiI3tzx5xqqHN+5lYYxlSXlrk4+NjwW7X7z25lScgq/cczMqktDNE6bSwVrYruaY1yd7JVzSfIw9SsV5zkOiEPO9A4aWkcv8L3iGf8RBt73fyk1gwBbcWPwIisWLn9syL4F9HKsQ5/TRY1bO8qoVFLcuSWJ8z8NdL/qkJKA5hwHbSLFbVPLm+lb63rHuCB1Bfs6x5rnGIZpdYo4bBiNEZOD0vqd98ytgLsYkIedxAf56s2kf3+oszBOOZYdUc/oQ44aPcuYZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(38070700021)(22082099003)(18002099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VirEfXDeaIlfMycviGOCcM1HyBAXvpkfcRqfw/ZaLlAz6D6NFQ/3jBVjfPzU?=
 =?us-ascii?Q?BxwU3rKpfx/G/7WmsIILHxKlGe7lQHFLlMQJk6YAysTyhiTeEtqFITwCw7kR?=
 =?us-ascii?Q?PSyJvjDWt7taCZPj1wdW3SEnXEA6F1nG31NB3AY5u4QEAo+J9c2LLAH4QKyc?=
 =?us-ascii?Q?Q7ec3H2GpRKLokFONSRSofTfyVSFgv/2xK1Q7a2Q69qnbC4OyjU0gDdqUG+0?=
 =?us-ascii?Q?CpbJEMWgC26KV1YS0mPJpRtJFAC9+QRctS3kkOOG3L63x9W+YHwRKvSuzEfa?=
 =?us-ascii?Q?fhqDEKKJ+L09si5h4W456qdbX3FuLWFtjAi17SeHrlInE3BHci4Okn+rg2IB?=
 =?us-ascii?Q?EU2h22tMb0XDYrVnIT15j4Yeicll2AnBUW6Dcl8L4E/1pRCqJdhzXtSxcV/h?=
 =?us-ascii?Q?+LSAeQhoO11N5IdC134DWKJuphw4SfAn5rb6M4F5UX9MHmRt0P0+yFYDDwd5?=
 =?us-ascii?Q?y2RpxlY1XuaMrBUTQntDl2bSYOuZpezss+g2V8cuOj2EN8ksbSsc9jnlnXAZ?=
 =?us-ascii?Q?zl4JgdMEnGdpmCzDzt9FFNZcZgyRdb5WIP7GsC1cSiiM+M4IZ8ZvUvXdfdIY?=
 =?us-ascii?Q?hSRZm8pBUwO2jXc4mvUjbs9lIVtfYVPsKUbWngzU+zE92Vv3yDbvAU7MJETn?=
 =?us-ascii?Q?tBEsZYavHt0nDDUivTO0D12Hbst/e5YelaEPUFFp0oZSfjVgpY/3Z3Pw025c?=
 =?us-ascii?Q?nMxbnrcSeZcC+GuRfXPx4dUXl7Ff22NFjGFiv0vk2lN3NYX76ly2zQYsW62x?=
 =?us-ascii?Q?YcenPDV0USX7yY6mEZ+g+z6sZF8gWmzvcShYhmO0oqINeJ7ovtHhQVM/OSnt?=
 =?us-ascii?Q?o9nZErEdkMhpLN/v3liQD02ghFfQ45AxfQhKFYiZK34jfRyzmNLRKsC0BaiN?=
 =?us-ascii?Q?jgRG132Ejmmf3G5Co+LGpZIC7VDRaDisntrBp9zasP6K3JAtO0Wj77/6oHtL?=
 =?us-ascii?Q?9uI/aj6E0uFj7DzZ8bWGIZdM/+tIMyMFUt98ymB9noFO/mqQ6MtU2pllCq3V?=
 =?us-ascii?Q?mPWmLVmxRvwRD99SOI8qoiitm4r9nwaHh9OR46kSK7BzU2a9M8mIYb2Jid5H?=
 =?us-ascii?Q?ZOP1uZY7rfOEy637VbSUjFAJ2hZ/Hvd4OqjTbsvep4PCSUUCeJx+1+kfXbzq?=
 =?us-ascii?Q?NB4cwiCPP4XOb2Dnpiwd+mto0l41RmURYSrXdoPayeZikolXoLw/j1QcsGwQ?=
 =?us-ascii?Q?Mw4RYp/dWcdMkzLGByhvDXyYHHsj5nOrFzdJtl2pm+5n7j47JdfqZ/MSu9sJ?=
 =?us-ascii?Q?71B6YXw/Hw2Wh+z34MP6Mh9CO0uGVy0foq9b2gJLOM6xP9u8Ww1l0z/Fjz3u?=
 =?us-ascii?Q?4om6RhZmU65lXZnW7A5NTr7wCnNPMSw5X2XSb9x8B1XcA31B/p11SkjeQN0/?=
 =?us-ascii?Q?YpE0r4C9wYRUZZdm6NNwI73N4IQxbHHdZfBT2Fg4P3NGX97CVPmhdiuqVqlx?=
 =?us-ascii?Q?Lmj5wYuUh5xrtKEShm2g6Jbfp5pXRhGW5YW3i/EuA3Ib2SOj6PyPjKnw/W6U?=
 =?us-ascii?Q?0a69O95xZjaQkXIbTYAO3XJJQY1J5pWc9k3n7pvueyjEvkeBrBi3LyIwch6+?=
 =?us-ascii?Q?6Ejq2gQP0yfljYNESKy3spJ1j29/X+wPuhF9KjTQE52BEKAmoP8gBzVCcEoD?=
 =?us-ascii?Q?JO4y2sbTVfiDNA5A5FGAgK82CvrKhBGLb+i0Eao6l/CdNqexsu7x7DuvyhCQ?=
 =?us-ascii?Q?di+BaiBcH+vVw84tzu5x72avEVJ6Dey8bcFWyzQO6BYWzeGg3GRfCNpLGY1I?=
 =?us-ascii?Q?0V4NhypCig=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WdvKSagufzBoAbyVzzCP3DO4B7LGWCupOux5OoN0/9tsEVnyz2NWFYj1unxDWeSMuyWG3+57Rn2vrOh2kEJshT3RMbT7PLmNX2NnAjc1yef0FIXYpS7y3fswWrjFOMxBz+4Cj0Y9KjgQHHU5i2lmAJ5KjnNpTMb5+DMXlXBAY+FUAfomJ4GvNRKQ9kgj1fzLClT0UlgpijQi3AQy/gzcZCBScGklZBM1eF/77fm4wPLYrl9qzcmkyfch9U10f9+aX/e9hzb4U8BjswYtqA3FV7DedwKmwEGFlfb5TsPY/kCNj3KWWXEVEZp6XMbwvIYf3zsybjNUXPlxB2dwnwNjEA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e30f98-e356-4064-d3e7-08dec74dbe3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 00:09:45.0877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GK5waYjm+fuEXJuyDQk2EEOZ6sHSkG02zXDNoRbCKzW6VTNgjBJm2ci7eGbrpiDkc8jkm3cNtkrIh2B+Sia+L5gTRFzBtKrLhPbbsPiwk+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8406
X-Mailman-Approved-At: Thu, 11 Jun 2026 04:54:05 +0200
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

> Subject: Re: [PATCH v3 0/5] arm: aspeed: add initial AST2700 SoC support
>=20
> On Wed, Jun 10, 2026 at 02:17:53AM +0000, Ryan Chen wrote:
> > Hello Tom,
> > 	Will this AST2700 SoC patch series can been merged?
>=20
> I expect to take v3 in to the next branch somewhat soon, thanks for your
> patience.
>=20
Thanks for the update. I appreciate your help and will wait for the v3 seri=
es
to be taken into the next branch.
> >
> > > Subject: [PATCH v3 0/5] arm: aspeed: add initial AST2700 SoC support
> > >
> > > AST2700 is the 8th generation of Integrated Remote Management
> > > Processor introduced by ASPEED Technology Inc. It is a Board
> > > Management Controller
> > > (BMC) SoC family with a dual-die architecture:
> > > SoC0 ("CPU" die with four ARM Cortex-A35 application cores) and
> > > SoC1 ("IO" die with peripherals) each SoC have its own SCU PLLs,
> > > clock dividers and reset domains.
> > >
> > > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > > ---
> > > Changes in v3:
> > >   - mach: add "N: ast2700" to the ARM ASPEED MAINTAINERS entry.
> > >   - Link to v2:
> > > https://lore.kernel.org/r/20260520-ast2700_clk-v2-0-c778b2908e5e@asp
> > > eedte
> > > ch.com
> > > Changes in v2:
> > >   - v1 only have clk driver, v2 apply full AST2700 platform and
> > >     reset, clk, ram driver.
> > >   - Move scu_ast2700.h from the clk patch into the mach-aspeed
> > >   - patch so the SoC header is provided alongside the SoC code
> > >     that consumes it.
> > >   Link to v1:
> > > https://lore.kernel.org/r/20260508-ast2700_clk-v1-1-2797a626a238@asp
> > > eedt
> > > ech.com
> > >
> > > ---
> > > Ryan Chen (5):
> > >       arm: aspeed: add ASPEED AST2700 SoC family support
> > >       arm: dts: aspeed: Add initial AST27xx SoC device tree
> > >       clk: ast2700: add clock driver support
> > >       reset: ast2700: add reset driver support
> > >       ram: aspeed: add SDRAM controller driver for AST2700
> > >
> > >  MAINTAINERS                                    |   1 +
> > >  arch/arm/dts/Makefile                          |   2 +
> > >  arch/arm/dts/ast2700-evb.dts                   |  88 +++
> > >  arch/arm/dts/ast2700-u-boot.dtsi               |  25 +
> > >  arch/arm/dts/ast2700.dtsi                      | 693
> > > ++++++++++++++++++
> > >  arch/arm/include/asm/arch-aspeed/fmc_hdr.h     |  52 ++
> > >  arch/arm/include/asm/arch-aspeed/platform.h    |  30 +-
> > >  arch/arm/include/asm/arch-aspeed/scu.h         | 145 ++++
> > >  arch/arm/include/asm/arch-aspeed/scu_ast2700.h | 514 +++++++++++++
> > >  arch/arm/include/asm/arch-aspeed/sdram.h       | 137 ++++
> > >  arch/arm/mach-aspeed/Kconfig                   |  11 +
> > >  arch/arm/mach-aspeed/Makefile                  |   1 +
> > >  arch/arm/mach-aspeed/ast2700/Kconfig           |  36 +
> > >  arch/arm/mach-aspeed/ast2700/Makefile          |   2 +
> > >  arch/arm/mach-aspeed/ast2700/arm64-mmu.c       |  43 ++
> > >  arch/arm/mach-aspeed/ast2700/board_common.c    |  90 +++
> > >  arch/arm/mach-aspeed/ast2700/cpu-info.c        | 114 +++
> > >  arch/arm/mach-aspeed/ast2700/lowlevel_init.S   | 132 ++++
> > >  arch/arm/mach-aspeed/ast2700/platform.c        |  64 ++
> > >  board/aspeed/evb_ast2700/Kconfig               |  13 +
> > >  board/aspeed/evb_ast2700/Makefile              |   1 +
> > >  board/aspeed/evb_ast2700/evb_ast2700.c         |   5 +
> > >  configs/evb-ast2700_defconfig                  | 149 ++++
> > >  drivers/clk/aspeed/Makefile                    |   1 +
> > >  drivers/clk/aspeed/clk_ast2700.c               | 952
> > > +++++++++++++++++++++++++
> > >  drivers/ram/aspeed/Kconfig                     |   4 +-
> > >  drivers/ram/aspeed/Makefile                    |   2 +-
> > >  drivers/ram/aspeed/sdram_ast2700.c             |  15 +-
> > >  drivers/reset/Kconfig                          |   9 +
> > >  drivers/reset/Makefile                         |   1 +
> > >  drivers/reset/reset-ast2700.c                  |  82 +++
> > >  include/configs/evb_ast2700.h                  |  58 ++
> > >  32 files changed, 3463 insertions(+), 9 deletions(-)
> > > ---
> > > base-commit: 38dbe637c9dfcadbd1bc201bfbb27f96b2ad525a
> > > change-id: 20260327-ast2700_clk-258eacb9d703
> > >
> > > Best regards,
> > > --
> > > Ryan Chen <ryan_chen@aspeedtech.com>
> >
>=20
> --
> Tom
