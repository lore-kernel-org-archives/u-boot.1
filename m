Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2296EC5472D
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 07:42:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90CF688A2E;
	Wed, 28 Aug 2024 09:42:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="B6ITh1oa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53475887B4; Wed, 28 Aug 2024 09:42:38 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C853886AF
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 09:42:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YuGRSXxkioefW6kUtKDkJX3c7MQzKuycmRLkHbZjbIzUAgh/RFwuqxZt/UX2N0qAPmahmHtLU4smzreR0Clh3LxjiqPzXF7bzOYoyfcPxgzKlxkHRN7GXf1rkiKVZUnx6ZRQmXERfH8RNSFLV9RNTJN95SMZCAitYUDTncctCMsuTF9UngUpkpGAURwtgEG643RAyFHelRrq4nWzEBqknfeHIfZgNhnCuFZvOEptqa5btaMir8Oh4mPDxo+ITwEaFNKISxsYzsC16sYMYYsoms+oTWVeryFlEiXdz3FAarbm1j8z4ehX6ecdHSxpUTqKnXX9CEExqBFJS66ClAd1EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+M25FdgaUIzJCzb0Pp/bZL54BWA5tBVSnaf+zhE6DiE=;
 b=X40drQ6wPhBZGGaeBtC5pS1jtyXWN1SXI6cm9eJQlNTUR+5gAoRNyo9q9bbYUJ3lZEPj/3cDuAQmKct6SqcTgc41Bn34QSjMGG4tahf4z0H+NsXL4gYZfzJdZ0feM0ee+0/m+mIszq6fgGxI9ubreP6NxaqC9S/vIH4QJ2OYhqozbVQPtB3lH9Hiq54sboel4VvGtR1pyeYe34pL+oWhrJkfIDenPUSbdrSAn3CNU1hCH0V8oSPkuGXuT2BaN8ZuQrnOTWdIujyiP6cfsY940i+FI1d84x+G8jZxa7JsrKfKXFhl7bCWreTgwtRJvmkQzTW73V4wvVsUVyThbCKjQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+M25FdgaUIzJCzb0Pp/bZL54BWA5tBVSnaf+zhE6DiE=;
 b=B6ITh1oaWt9m7MP3QTilEPCgX/Xgba76Y2usOznoACuuy44MwgwC+ZwvLFEJrJPAFzq7H2BtWRZQflm/LwMWlybgRsr7VV/IIeFN2AvW0RxbPtNhayAPwu9eUjoczNaM/djL0t/4LY98dBapIlzqARCJ8i9ZRpEqLqtpdEjwaE9wprK/nKkxjjsMHJaBKndwtqytEZT4rkiRiRkKoLG7zZBNSydFrLVBAQEs10vk1xSe21cqoC5swUxkqH+9CDUU80RcGYmxZiPPebon09Dwg9ePKxTdAzib6cqZAGrZ1U9hSszcgmCmXun3bA0KpeHjIIlgE8VaALCfdt6WrZCHeA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7702.eurprd04.prod.outlook.com (2603:10a6:20b:23f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 07:42:35 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 07:42:34 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "marex@denx.de" <marex@denx.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "tharvey@gateworks.com" <tharvey@gateworks.com>,
 "smoch@web.de" <smoch@web.de>, Fabio Estevam <festevam@denx.de>
Subject: RE: [PATCH v2 3/4] mx5: Remove CFG_MXC_USB_PORT
Thread-Topic: [PATCH v2 3/4] mx5: Remove CFG_MXC_USB_PORT
Thread-Index: AQHa+Llh/d1OJiZQoEGMF/s0iZdRmrI8Shdw
Date: Wed, 28 Aug 2024 07:42:34 +0000
Message-ID: <PAXPR04MB84596331F7E17787C6B59E6288952@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240827194307.2933299-1-festevam@gmail.com>
 <20240827194307.2933299-3-festevam@gmail.com>
In-Reply-To: <20240827194307.2933299-3-festevam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB7702:EE_
x-ms-office365-filtering-correlation-id: 960fddbb-454b-457e-4481-08dcc734fb49
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?UCHrzVKZOu7WRQ+jpFje8PsnxJQ2IZilkXXZOdeoX0lfqHD0zmxoOMEtXmIH?=
 =?us-ascii?Q?8QOsTwr2cyDL/VsvPwMGeyGtEGJU1wGdVUoitBQwRZngc3syJkS7EbkUOJ4U?=
 =?us-ascii?Q?g+Bhf85IiJ1PqKdZ4vJhpChCsUWOWB+hVFBwDqRP0UUXK7bwcccOS3CwrfkF?=
 =?us-ascii?Q?yTBE5hqT0tBA8MmuwdG6mhSDcAudPCyg/J++aYYAsY5EZzMiNXzDug6AhMKX?=
 =?us-ascii?Q?rsnLwoVRk2cST1JEgmxJiwn3lJ5wrQbmh0vq7PVufyKXcQG+5WaSzimBYPh9?=
 =?us-ascii?Q?ucXps/H5JI8WSxZ1QPx7Ojwz5pYnC79uuiPQwl8qVoJILUkakaCj4jU7sevz?=
 =?us-ascii?Q?60GQ5xPSNSNe2dXbAyA5TkyDU0kDlCpOKUB1etC4qbfJRiyKi7wAhWrd603R?=
 =?us-ascii?Q?fQdYPoNDw5oju3kVjFP2T+aqe5w00p5bB9YWfDbVlIUDKHMnIxdi9gR/0prA?=
 =?us-ascii?Q?pOFJ+Jeru8lWi3ZMFAJi7nYd0TZf0N7x49FDvHmB2/rAoMoejXns6yALz3pq?=
 =?us-ascii?Q?UawImFj/Ax0xUwT10nNb5fxXHFUnNPNZym8BUn4BG/oYdR7x6OWzk6mha4V6?=
 =?us-ascii?Q?EH5zth1kBVRULleEbnbrHM2VAp8LFajTf917KgOScGY3H3Jvv1Xi/kyrfw+q?=
 =?us-ascii?Q?PQHjxvgzoZkM5iXJQuDoldPf+/5o3+D5lBCJTATmJXFAfifVqPf+gxzbYgCS?=
 =?us-ascii?Q?XjNXTvjEFcrH7KOUnqldIyBqvQHfpUNqyrfKVYYjh3+QKh99/TxD5XomOgv6?=
 =?us-ascii?Q?2SdbIITz0QYIiwwj/etbIz+uwCtsbCT8rVRiTslK3RJpJIO28x1UP85l19Dw?=
 =?us-ascii?Q?jBVLPfJ2uhOWwNGAToKGYLpufxJnGtcnQg8zWnrYT0nvkS4ye4SQTCEQI3iD?=
 =?us-ascii?Q?rNhZNMG66tOXdvyDKaxgcISUtTk62YhT23AEwDFN7U/5uBeTXwUoSXjQWdfg?=
 =?us-ascii?Q?g/XigJxWK+kNcV1pacS5zZXWQYGUwLphjV2Ppl8xu9oBJimULMohawgh02x1?=
 =?us-ascii?Q?qagkPTk0rLV/m9SFbkyAo0zF6X/ScpwQMBHR3ohXv5xVgTXuYBshr7+D09DT?=
 =?us-ascii?Q?+uhhL97wheDiys2v5dZIn0eMXD3nXhMyZlC/BpntQQpH1+fnNx5yyNRr37BN?=
 =?us-ascii?Q?X+Y82/pTQgdOtN8IZrfR3VuCIXZK7rsKpIVfatpneYB4UTZxvkUm18YqihkI?=
 =?us-ascii?Q?LvB2QNGID9LRHVjmE2ssA/oDoWcz6fjsy4a6QP9oKVuonfnQ4lnf37+clRAL?=
 =?us-ascii?Q?SGiDAEVFydrQI+bS9r3i5rTn7K4tDHViNspbFAHDLoobitSwqoM5jfuwHT3w?=
 =?us-ascii?Q?5qb+9nvDqLnyhLIFCNC7E9K285Q3GY5iZphRcVNnaNbRjxgNPcrMlVOOd5Ke?=
 =?us-ascii?Q?zfx5e5aHz2vwHEcEGVSZuUNl1GUJs7AD24APf+fQ1wlTZfHM7w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nn+AckM0Bor82enpfL8ROTd/07N9f+fAUGW/7ICI8e4WBmWkQ58NZk6jzSV2?=
 =?us-ascii?Q?fo+OB9/aanMASh7w3TfRJHSf0TH1dsrDXgLjN21u0hq+eJk7U+hQ8Za2mC3w?=
 =?us-ascii?Q?cRSdyCHpsVoFVIU/sT8K3TyONGKK0zw5s+4+1oaQOGjaItcnGS3Pcj/dpjAA?=
 =?us-ascii?Q?dJRddPzF3tdWkbFtrNZYRNbIYF1pR7Rvz8IA8Xj4wXqJPlj9ZcexAETJnTRC?=
 =?us-ascii?Q?xP2VABCw9D7nct7O+GZ6e+1F9VmHzwHCiRfEXaI8/rBmg2aONuOIr0CqEAPp?=
 =?us-ascii?Q?B4E6Z7bWZ70lbCRmp9AbWM8swCYNCpwKZt3QVu7kX8lmWddTQBz0VQk/xLcJ?=
 =?us-ascii?Q?uJtSQbFlCHIfXwlWoHDwhnkPom4TUIqllDuKi+NnWwY6mGAZKJIfXyE4GQL+?=
 =?us-ascii?Q?0jk6a2OlaBQyBtbWP50ZsvcSnaix2iIIP/ADuqw/vvErGwsO1Mg5zZQoAVh9?=
 =?us-ascii?Q?LCyC71P5Ap3+fI/xIGDO7p5kUEDMK6sxZap+Wx3WMbpCuqxbCPv6cOtCPy8D?=
 =?us-ascii?Q?HgOD9+ZO5WiFCpNrcX+WFOGVHS7hp60fWAndHChNwpNahfOFGaO5ncnBfnYg?=
 =?us-ascii?Q?zrVVm6ZJ9CVzvMk9xRMd88dGufmXvRKnn2vFzRSF9pRaAw7ofvsbLApyfQ2+?=
 =?us-ascii?Q?zK0zN45UWUL2Hs7VEf8EWEPEtPIuqpcXuPjlma7DN1/th3QmOQuoFJU/PnsI?=
 =?us-ascii?Q?54HqNec4MhqHB20/QdHzAsB2ZrmfjMG+2XQZNSeiz8TnMuRkXAoaHKBA43G+?=
 =?us-ascii?Q?ZujS7W8+ALgtk5MyufAGhSN1MPRu2RYK3Htf/Vzxn1myKNmetxiaJ4XLOg8d?=
 =?us-ascii?Q?4U8NfUQOBhEchl8bO7p7bWJhyPKWzq9YaTBoqXp/PhylQlqSaAshjDtzAdCa?=
 =?us-ascii?Q?l4FP23jnS4hpXCYFs5L1gt01o1wRSqh0sHv0egHSk89w67o0wpFUOE+Li/OT?=
 =?us-ascii?Q?wD5lOUehNRmFKXhqcJGHyQpLKiHSEF7M77o4C/FBzSnrIKvSvuPi8q9DrTNU?=
 =?us-ascii?Q?HmgJMWct4jFe1AhC9gdO6X4raVIv+kUqmKdckP3YYgrvMsdQ4eTET/bCZ2R2?=
 =?us-ascii?Q?mJSNYE8S8VNKjtIq2APkQz68RKxe8ESjPR3f5pbs7+oPZtSkMqsOvpI/oRQs?=
 =?us-ascii?Q?HHmaBDnNgLhy5gJtdQKaHZcWSv79DxJUs/C/xfUikvjQKht5TWKcfUNtah3b?=
 =?us-ascii?Q?W4u1d/L/IGx4wC4G7Ft8SRd20N35wx6ZVOEZUFiun5mVW9cgzGRhOYqHuBZl?=
 =?us-ascii?Q?kp8VfGyas+oQK9BMjjGh/jqRUtWKho51c3kEF3J17qj44uNn5MrnrknSb9o4?=
 =?us-ascii?Q?tdNiDJGvwYVP+xy+Mm3Fzck6ryLn3sR4AgFVUCylQs//DsRIjH5MuenM0Yx2?=
 =?us-ascii?Q?nFWC6CQmxlql/riF4iR7c1ajLGAe6bK2WWUJHDSe71OAesAVfA+5kEyS0dJW?=
 =?us-ascii?Q?vAVJF2SfIyLsf7TKMN/Pye7cMLurX//ExyBtJz5xSUTXqmMo4Gz/nHrEDTnm?=
 =?us-ascii?Q?N8UvsIuABUIS0HWSj/J172Ty0y4eKbnlJbMJn3ohxHoNKsplg+aSQRrmRISG?=
 =?us-ascii?Q?U9eEHFh03tYZOfb59qE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 960fddbb-454b-457e-4481-08dcc734fb49
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 07:42:34.7525 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lWBV/2U8sB42MatyERepr0AReke6Kks5CnMfYlI3mBOZaleiuuWzCvgIPkLnT9gn9QpQVMlzbrI8l8qooNEPhg==
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

> Subject: [PATCH v2 3/4] mx5: Remove CFG_MXC_USB_PORT
>=20
> From: Fabio Estevam <festevam@denx.de>
>=20
> CFG_MXC_USB_PORT is not used anywhere, so remove this unused
> symbol.
>=20
> Suggested-by: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
