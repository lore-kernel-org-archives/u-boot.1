Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F04CCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 10:11:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1859583B5E;
	Tue, 11 Nov 2025 11:11:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=br-automation.com header.i=@br-automation.com header.b="QoeB8gs3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0BC883F63; Tue, 11 Nov 2025 11:11:17 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E036683B55
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 11:11:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=wolfgang.wallner@br-automation.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRAjvDXqcnrRkHYlrWTQr0JuK2oJMiu/TKoofNOpioqMl1mbmKO60rIoXOD1lqNNuJaxAeDPdXoCEOm2ssT8OyBwlOxq/TrbSQjCZ1V7aqzRWpfMwkQsmtDxHSTtogtGIq9c3XjVyv+WASA6DslqFXCUndS3cxgBNVEbpOa5k4m67bnH41529ADbn8Ub+ZPknBSXtuIh8Hu5jYxkkkSuaqSGymdc3DiW2J0+apFVMtKH13Zn2NPeRPFsvSRKr/qzVwoj3zgV5etx3qiohlmKzO1umf4ceGYOGbspQKJo4m3GDEFsIIeFTTqKXyaURw7i8iSamN53XPC3tgL7FuqHkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zP7cMQS1Kawwk5vCvydTc5LQuQsJ/w3s7DiTrcctKBw=;
 b=yUmLCvrz0UyDu0JkwCbdqsAbxAhP1ABjuU/jmXeHo+Z6yjyULpREQwQW4smiJ8qU5n4Ac6RiWiHVhYuBwTXkBEvbDohXM3UjXGKNlwuOcn9Uj/2F8Zui7LETge4eZnIt6hLo9oELK5KvIUa/oZ/CBExWqduhNBQtCciNuUh+XYdgOpPFxH8vDRt06MNthBvwYPFPkAZYgL0QmR+qTGNdYHgWrvspUdBX8qjKeYWJr44uVf+4nrwK+naxvQeXlf1dDJTZtZpRUTretfZFmsoa9PenMA3Ql4sxmmE6rAIRcPF6iu+8QQcm/06vWU3Ju+4a68hxF9LwRyk4bGSFnl3XDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=br-automation.com; dmarc=pass action=none
 header.from=br-automation.com; dkim=pass header.d=br-automation.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=br-automation.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zP7cMQS1Kawwk5vCvydTc5LQuQsJ/w3s7DiTrcctKBw=;
 b=QoeB8gs3GiwKuNTPHvctmUNnzHw3cxr0oEBsGGw57ZqsJV38g1pLHbDNfUciFIluZHL4sN5n5k3teWlhkFSpx6VhWyNqzA4ZKyLxgTv1S223OMCzjLeMz+CDP/GzepkRYXAS5kIiAR4ebwBSj91pU0R3Z7P3TNRAMiiERqbFg9Mgx77YimdT2C9l7/pCEQe1MIcGOyRhEbdHo8kQIzTcjke3ilPiToQNuEHh7UQx2GV5+L1Uwk3BHYkircwBKZGqzQ17hWL/tjE6AEcyI0qzNIrDh+Gj2Mp6jbJhTAjDTCy55gEkHxgy0VljlfOO/eOy26HKUU5FKf4LR4cCxyN97Q==
Received: from DB9PR06MB8512.eurprd06.prod.outlook.com (2603:10a6:10:36c::17)
 by PA1PR06MB10090.eurprd06.prod.outlook.com (2603:10a6:102:4f7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 10:11:14 +0000
Received: from DB9PR06MB8512.eurprd06.prod.outlook.com
 ([fe80::5f8:554f:fee1:6cd5]) by DB9PR06MB8512.eurprd06.prod.outlook.com
 ([fe80::5f8:554f:fee1:6cd5%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 10:11:14 +0000
From: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
To: Quentin Schulz <foss+uboot@0leil.net>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Aristo Chen <jj251510319013@gmail.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>, Paul
 HENRYS <paul.henrys_ext@softathome.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Shiji Yang <yangshiji66@outlook.com>, Anton Moryakov
 <ant.v.moryakov@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, Bryan Brattlof <bb@ti.com>, Quentin Schulz
 <quentin.schulz@cherry.de>
Subject: Re: [PATCH 2/3] tools: binman: mkimage: add support for passing the
 engine
Thread-Topic: [PATCH 2/3] tools: binman: mkimage: add support for passing the
 engine
Thread-Index: AQHcSnpXBBXLXwlppEe0OwdUhNbAI7TtUFOe
Date: Tue, 11 Nov 2025 10:11:14 +0000
Message-ID: <DB9PR06MB851278A11CBD19D7414A04A5CBCFA@DB9PR06MB8512.eurprd06.prod.outlook.com>
References: <20251031-binman-engine-v1-0-c13c1b5dac43@cherry.de>
 <20251031-binman-engine-v1-2-c13c1b5dac43@cherry.de>
In-Reply-To: <20251031-binman-engine-v1-2-c13c1b5dac43@cherry.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Enabled=True;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SiteId=372ee9e0-9ce0-4033-a64a-c07073a91ecd;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SetDate=2025-11-11T10:11:13.936Z;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Name=Internal;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_ContentBits=1;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=br-automation.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR06MB8512:EE_|PA1PR06MB10090:EE_
x-ms-office365-filtering-correlation-id: 95dbc3a2-eb2f-41ed-eab6-08de210aa598
x-abb-o365-outbound: ABBOUTBOUND1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?D3tZvYVvBq/F8/BJK0RF/Wl5NngLv9sQElJmYfDJ11Qc6GBxMF8GhI/hhD?=
 =?iso-8859-1?Q?LRlxHIGTGXyvYuo/vCK5K5fKQ7Y9gEWhvnujeK26bgzm6PFD3pWNJ9SufY?=
 =?iso-8859-1?Q?Yw6pKC1+PTGxRBnC9HRBPUPD1i4bFB00OpPEdA2kjQzVvuWQ8HEqN+HOBB?=
 =?iso-8859-1?Q?k5I/x/CPnvxoN82YefA3rRINCHwl0lb/PLcQlbwEpQar6mHn5TuMliLT6B?=
 =?iso-8859-1?Q?MZe+IKljtGzI6TXC35JZxJMJhvRn3WU929y1OUdz5goNDiTaW5ksq97ZnB?=
 =?iso-8859-1?Q?Rw7qC2VrWbpraGOMRg7Yq0Nv4Btl5s+qTwXvVn9gyO4VaRKdkYqPWd4nF8?=
 =?iso-8859-1?Q?f+SzafsjJGOjMD6FJRf1Ue8XqSgfOWtjdPc/Fz2kD+0dBARhPedbSY/ecX?=
 =?iso-8859-1?Q?hNLhU2mQB13p0AtEt44viXivvoyqHXt+toMc17qbi2gMKvtkBWAkscxfIc?=
 =?iso-8859-1?Q?xuTqkrQY5vXZtP8oV6q7e1OEe3jy653GChtEBhEXXTow0+vgmZreJYpdlc?=
 =?iso-8859-1?Q?2hC4Q9/PYA4f6Njar0izJevaLQyxO33g4P/nsRlMxGQ5NZ5h0Z5WuRFZxM?=
 =?iso-8859-1?Q?zH0xeEQJhSVdEXsihaG9SbehULVlQBtoSXFLcD85HxYOxhX0Hj3MLHc/QO?=
 =?iso-8859-1?Q?wZHexcW8ip7M1Ad2AMEMtRcOpmrnk06gS7jANJfG0FAvKmKA7p2vWEDqzh?=
 =?iso-8859-1?Q?ohh8MUNVjVgHsOnqLb+qiS+U0MPQlIqs9Poxx9A9nUM/MvEOiR3ao3VZ5L?=
 =?iso-8859-1?Q?SB/lFa+NjtfYT66jbNFUR6f3mLMn1IaAIHmzROZwptUDnG9KJBzdb2ik8h?=
 =?iso-8859-1?Q?AVQes2D/JWIBfmBDE3K8LzUXT9wRsAy1Uv6WaRBII4R74VprMZEYqFji3j?=
 =?iso-8859-1?Q?pk4t3rkJWVTYTafhOOADA3QyrkVnjjPGwN4zX9693HBTm/gzfYZK8qEnJQ?=
 =?iso-8859-1?Q?vt23/ofq38iPvnRt5kU0ZOgH4LUyAesYLoAHotEevTPHqJMAbADPFiWUyQ?=
 =?iso-8859-1?Q?oVL5fChrvfsQ+ODg7AXpKQ4N8n9OxniAp/BRtP+bqQWAe/jr3ddp+8dCpd?=
 =?iso-8859-1?Q?bbVGDSznbBzpQXVARaOmz+MTMzKq+PHcL1GyQxzVYGzG8IiOyUmp0Xppnn?=
 =?iso-8859-1?Q?fcxsS8U8ITabXm9CbOGRvbwDey8dDbyI/LSf/YXeuHlfDWBdD0yepvxRUA?=
 =?iso-8859-1?Q?MCTwoxaNRm1EKqEZQI2D2I7y2z0C7WoXi9hAPIGgOVpkUFG9bj4Trl7K7S?=
 =?iso-8859-1?Q?CvC4wLxFL6DEGdgtH/2rpn+IJC6HBHKxawubyS5hSAa8l9ZqO4M5tAob/A?=
 =?iso-8859-1?Q?XPG+1zMOtbyjCDlbEK1h1EAxzprT/s4w/pHIyib5/e15Tn323deCAqeEYv?=
 =?iso-8859-1?Q?/4bF7WBbRlv0EqYaMhf6Z/iWCjOM2YHo39C3WOYKZ0KiQH4v0JnMCJH3PJ?=
 =?iso-8859-1?Q?pInkXWUsxgThkNpnEC0yFocIJm8g09S38jgPFSIfPv9dm2kfEyP9gV1Ujm?=
 =?iso-8859-1?Q?wY0RSainlAqVWuki51nbNDq4OFcII5Q44DADblSC90px1MNkefRWI8x62O?=
 =?iso-8859-1?Q?2KqadAJnBM+sgdAwUxcyQilDwdin?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB8512.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mVRdTNz00vWoporlELr2QtunEvANGNS+lFLPpnIltvjUmS39jZw0eM8YP3?=
 =?iso-8859-1?Q?dC/fdouzEA+EoU/Jih7cLXhgwZObU9eciRpqCut9plNBhs6iptlZ+5SfO1?=
 =?iso-8859-1?Q?4ageDWfArFq7QZrxvWidXvmFg/cQ0ja/X/NhMwmZSIAsd9RXpdKd6pKyXo?=
 =?iso-8859-1?Q?zLebqcCuC7c79I2E3XqGLoejnRi0jE5TpqLXs85HnXHLUGjExNOtFQ6FMn?=
 =?iso-8859-1?Q?3GfnJtdJWrmkOVlRImB2uENwEqwjSx5G7rwPkgLdCEdSQTImpUEXCmflnN?=
 =?iso-8859-1?Q?d8utdMeh1wHaV/ox6jKHsu/jYyEgOBEfxcM1+Wohmn7n0vU8oEBcl/jd5H?=
 =?iso-8859-1?Q?7Y57DCUJ/8cdagkc37wDk+Faludbfjnik241VjIvRs9/EJFFm1TYqmhipF?=
 =?iso-8859-1?Q?m2DmHcyzU6862ldM9fJLqWEnEjbpsVV9miA17tX0GbjfN6+YMNRzvWE7Va?=
 =?iso-8859-1?Q?ySX/qkDdvBYxwHKSv6QqwS9lGkLvKbCdrPVWyeYv4GATIdLg1OICWdeV4V?=
 =?iso-8859-1?Q?iCVUaOyFkN6Hza2pHmj+6NS6cjkbsUbJASdS3FEQG4qjRHKcCI7jfphtx5?=
 =?iso-8859-1?Q?iF/LijnIODVOM1jynyRvEDEnc3/E6Lmd7Wp1wcdk3FoebTZaHY7YSra5N4?=
 =?iso-8859-1?Q?X54kdVPlZDTsOz/PvanbOvZYxkA8TDSEh/+hYAZxLwI5nBN/E1ViVwz+iD?=
 =?iso-8859-1?Q?+kPzpPbqgv8HBjMWSv2Rj4fCtTZhCOMLtJi0YcSGR7kp8+HGH8Sf5O0+SQ?=
 =?iso-8859-1?Q?c2/dPZSfBh5VvXJJ2FDoVoNjWS4Zhfny08/iQrbyak0RGa6nkIGhbQ0pjz?=
 =?iso-8859-1?Q?cEXyAiN3JM086LQHhGm2sru5bqkp/t7+Zv1NNTLX4MUsDW7GP50/NfpBet?=
 =?iso-8859-1?Q?GGWIG8dbte6MJuSZtgsmxD7rW85RaYboAwfpFxNpnHTLSwuSzWbrp9nue2?=
 =?iso-8859-1?Q?lHaHuFnx/q/tsKTDQ7+04GzXZCdipYiMUx9pD91cEhRGJ2A5irN9kFkgHH?=
 =?iso-8859-1?Q?adESycEkBeWtqAwUYrNgQD5T84wxIeAE0I3SW1eYZwtFf5kpVja+bGfVa7?=
 =?iso-8859-1?Q?ZhU48nNxzcAK2Aql9Zq5uCWkmfqgeJ0b2XmN5nqvWMbZzO/5WbUm+xV031?=
 =?iso-8859-1?Q?TBb3cj4ElAVz6fqOnZoi7d60tDwCJkPb8C7gnEYTGKtd9kLbEVfByJeZA/?=
 =?iso-8859-1?Q?wMYbWCRZ1lACVUamk1Sf9dJbitIJm+JgMNytB5auyNDpK7Qr+C0PIUPZm/?=
 =?iso-8859-1?Q?q69vZoHeQgMEgzoGq0skdtxxARbz3r9y/nMQDVuyaIfX8xNPWnkkdp07bX?=
 =?iso-8859-1?Q?1Sd4bgubnQtx0AFMNIWAlrU+ZmnhgWWfa3Y8uquwHzrxwKt/vuZFoWGW2+?=
 =?iso-8859-1?Q?L4vvDyVYHwjqsCtoRxg016O8Ur9vx11y9ehuGGD6qt3+/3q1LYNHg95A3S?=
 =?iso-8859-1?Q?w/BCbL2dGYlJDmZdS9qomJTU7bISS3ERSunYFcorKW3oRUJR+7qNrLae4w?=
 =?iso-8859-1?Q?gdprY0MR9GdicelAbrigNo8rQ18JnK5rTZgKVIPWtAc2ZfIkR+Uo4hIm+w?=
 =?iso-8859-1?Q?vsN8iS6FWUOMfY3FZdmHFtWMnLM9+xevL4xElje8SMxNBEQOdFJjEBs+cI?=
 =?iso-8859-1?Q?1v30UdFABLT5/s36a856McXbhnh26KwqbjIRQ1u7KhzJbRMTQ9cCrTcA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: br-automation.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB8512.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95dbc3a2-eb2f-41ed-eab6-08de210aa598
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 10:11:14.4797 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 372ee9e0-9ce0-4033-a64a-c07073a91ecd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B+llcsslAJOa8HcAAtB2RThLR2D42bgBtccJw5YPjZKrNaLiEaWTyp7y2w0YsAWGacjfaJ0igm9N6cE1DrfYd3CuuowLT7Va/Nu+QpijliUxV1l7D45Gbx7raUz4qaI8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR06MB10090
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

Hi Quentin,=0A=
=0A=
From: Quentin Schulz <quentin.schulz@cherry.de>=0A=
> mkimage has support for OpenSSL engines but binman currently doesn't for=
=0A=
> direct callers of mkimage (e.g. the fit etype). This prepares for adding=
=0A=
> support for OpenSSL engines for signing elements of a FIT image, which=0A=
> will done in the next commit.=0A=
> =0A=
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>=0A=
> ---=0A=
>  tools/binman/btool/mkimage.py | 5 ++++-=0A=
>  1 file changed, 4 insertions(+), 1 deletion(-)=0A=
=0A=
Reviewed-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>=0A=
=0A=
Regards, Wolfgang=
