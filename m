Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E490CFEA83B
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 09:43:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8264C83AAB;
	Wed, 25 Mar 2026 10:43:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="tW6vyi7P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7106583A91; Wed, 25 Mar 2026 10:43:15 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8CBF83E76
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 10:43:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t.remmet@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkHFRa9FmmOCdDXz2pr/4qjSnCPnnaVhHVzvQYxI1PwHwSKOPwX9h6aZduaBZmUzwKuYllpBQGMCS+t7FYmkc1LrvGBuIQmWDHw6INYg3k9uhDhCRGtOArjFcbBpxME5Isac99dNwMpmgzbjenWgc5uwyQjxGBH4RAxg+Ex+IBxQ3fMJ1F87+oYl371bdZcP28g2oKdJrlG8dxdHJ0LpuBUq9ip7lvXN/q+mC5DlUWTWyqJmKZnWLQt5VrQB/y0qOeTgjLOE+HcJLKoIeLxzcF88T+tvtGeYvVdD8teyjBx1d2HY3Dd3oHo0nMcZtbkvw5QwKsOGpupFqpWGQPW76w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBUJoeqYiBvsni1j+zcMsYRrkGEzliA5uRJA19WNxoY=;
 b=SlX8yE1Ra9vDiA45C6IqsEe+cyMMoag+QtDkPzgtJVFvrzJU/GhAN4CZnZsj/7hFDP+il8crYVW3JxEeebsZSgP+dXiQiuOqwbWTLPT2Dfa7Yisi5IXuzeAiaaQvi1jIBabFRhyDVj1mDazY1h0diPn0GoHHDXzx+RVJVNylKJfdrjCVtyJ8Jdz8Mi/WXWBoQ9shkVO+PtqRBog7OPZu+ExFFL6qE+SxskfdKXuVHb/bbEx6NpMDodlJ/qfnzlBl77s+u/o5l4m30rmMnV52KjBbEwPzO+awR3+/LUo/x65Ugf5TvTKq5EpzkbjWutX4vV8zRxEWRKL4I5nE4dmp4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBUJoeqYiBvsni1j+zcMsYRrkGEzliA5uRJA19WNxoY=;
 b=tW6vyi7P07hljqG5sgcsgRy8aV7uzpUdSHv5Jxmkur3gh+FSNWM2by3YenZ5KGNXmyYEYhY2XJO4i+imZXsV2AwV3Rb0EJ2OL51xkKUDj5npNfoMZAXKeOrPR8DvGVSyUr1gdIeZHuDNWFZjoaYm7BHu8lMSvWTGpkN+wiVNYRzayRi9pKNeW47cz40t8RV9bC7OsslgJ1S8RbuWpaiJC1cuGCcPBHvn6N8GmCPRlYNS/rAgigJiSoyDMXOikYkbhJFb7MkNLfkcrvZyne9p/w2dHMI/P5M8K5YppVlnd8VD/UtxzSvIA3FbisZcG1t7DZcbUri54t7uxxS0XUaxow==
Received: from DB9P195MB1228.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:297::14)
 by DB8P195MB0629.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:150::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 09:43:10 +0000
Received: from DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
 ([fe80::efce:766c:909a:9335]) by DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
 ([fe80::efce:766c:909a:9335%3]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 09:43:10 +0000
From: Teresa Remmet <t.remmet@phytec.de>
To: "sbabic@nabladev.com" <sbabic@nabladev.com>, "uboot-imx@nxp.com"
 <uboot-imx@nxp.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "peng.fan@nxp.com"
 <peng.fan@nxp.com>, "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 Yannic Moog <Y.Moog@phytec.de>, "frieder.schrempf@kontron.de"
 <frieder.schrempf@kontron.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "peng.fan@oss.nxp.com" <peng.fan@oss.nxp.com>
CC: "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 Leonard Anderweit <L.Anderweit@phytec.de>, "emanuele.ghidoli@toradex.com"
 <emanuele.ghidoli@toradex.com>, Benjamin Hahn <B.Hahn@phytec.de>,
 "francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>,
 "matteo.lisi@engicam.com" <matteo.lisi@engicam.com>,
 "abbaraju.manojsai@amarulasolutions.com"
 <abbaraju.manojsai@amarulasolutions.com>
Subject: Re: [PATCH 1/4] imx8mp: phyboard-pollux-rdk: Convert to DM_PMIC
Thread-Topic: [PATCH 1/4] imx8mp: phyboard-pollux-rdk: Convert to DM_PMIC
Thread-Index: AQHcu26vAHASgIg2tUyrTGbfHiDkArW9odiAgAAM/wCAAA5aAIAA4N4AgABAXQCAACJKgA==
Date: Wed, 25 Mar 2026 09:43:10 +0000
Message-ID: <a76c18324af6af84f42a0c07d7396f8cb09b9703.camel@phytec.de>
References: <20260324-power-legacy-v1-0-ed432367817c@nxp.com>
 <20260324-power-legacy-v1-1-ed432367817c@nxp.com>
 <0c16dfd0d1cedc87bbac071030bbb4d6f04ff4af.camel@phytec.de>
 <PAXPR04MB84596009AB3591BBE0AD49F98848A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <5f44e3d45ac725c16c61a92fff527f9b7bea2fc4.camel@phytec.de>
 <PAXPR04MB845968E9F7A73809AFAE21E18849A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <fd99509a-315f-4c0d-b300-eba1308f7ff1@kontron.de>
In-Reply-To: <fd99509a-315f-4c0d-b300-eba1308f7ff1@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P195MB1228:EE_|DB8P195MB0629:EE_
x-ms-office365-filtering-correlation-id: e9d7849b-3c3a-4623-0b4e-08de8a52ed38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014|38070700021|921020|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: iIno8BYmiXnfcNnYXvvr1RL7ZZIIUxU+Leugz5il8bQEg1MsCjPrGGx57DaUxXjD5v/Q5b+d3sr0XTbJqImHBUqtDqNixWYLFem++EgzoPhVpkqsNq519ZbYxqexbFYluBQ0gPhADvM8fyb2hkESqmet5Uuj5WQZsqMc//hqWnBq7DA84B47Q2K5+ezXZVzB5NeoB5Rri7q/2D8tJcQMRcQvjbqI6LdUQeZEtHCACzfFb0C/q5hP0coY/RB/LnDD3JTE3EDBpLhCVyn7KRmP7hHn0YDQAzEWB8nweks+SvU0Xs7Y1EYhLQ/XqS1au/6KTKdtGNwOn8fI8nbE1waiWY+THB5XP09myzg0VL/eCwagOMq9+6ApFFhnabLPWtMuFnQso1raaJeg+a9SgZWsOBP0WINlrpsv01SLeMeda7XluYVLPWaVRuzEjTZagHQ+3dQ9jnq7+a8MLgaZiVrRLHGBOyyVYzvBffaAKDm50wmIHFQx2xgsOzLb+RpI9h9oMsKI7lvIZiJCEohcyp1j+hrYcuITZPe6zbO7vsVkCY2J1ytD5tQrRj6pAjwsmIKcBc+yhXmkNadJXuI+6d7FZNkHEs3AQbHjAMDMrmVbQqjGIF/c/dv9A3UTHHSzFha80z/H4i83UlbjtB0XghQZGM0IBUjVeCcLtNT/K53NN0OIfk3IlA/wK5fKIvCl/kDu5K6oEOM1O45kYN3YdrLG2BbEffA7iLlCNjj0BQgc6gSN92k1LIEE2rux0VDXWPbLw8BErKUyQLyq2yqgMjwuPQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9P195MB1228.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(38070700021)(921020)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkN2U3RjYUMxNHB0MWhFR3hXa3JMQzkvbFcxTXRFRXRTUlNuWDlSYmd2a2hD?=
 =?utf-8?B?MkdCSndtYzdxcy9Sa3hXVGdPY0tBSzRmMURISE5haUNwNzdSNy9qSUZhSERx?=
 =?utf-8?B?TlNPbWkzNC9pSTU5K1N1LyttdzFvNU5XeTZMZGJVbzZEN0liTjdOeUQwS3Fw?=
 =?utf-8?B?WEZoZUhxOG11WEg1QlovMnQwaHQ1MzBUSVF5R283SnkzUlpER004Y0EyNnk0?=
 =?utf-8?B?NTFJclQ3T3QxNnluMU5iSzdsVTNTbncrQ3NicG5qdTNBckdEUEZ5NEdvMFdX?=
 =?utf-8?B?SmU0S2N3Z2k3RnlpU0swTFQ3Mm45K2VPbzZWRW0zTElwV29YUDltaWJsQ3NT?=
 =?utf-8?B?NFNScFVZVnJ0WEtJSWdkZUs0MTZ1Q3NpaGtyeW9mOU42TlpkN0plaUVIRDQ0?=
 =?utf-8?B?NXloNUlkVnlWdEtwQllHUkZTbnl2VWhYUzNVTDJPclFSajdCQ010RHZuSzRG?=
 =?utf-8?B?dVhtUWV1UWsxbGdmUUdBTTVGMFNIQW9xQW1DZVAyMFFkUzduVTA5Y3AwNWZr?=
 =?utf-8?B?Vm92TXFVdERuSWRZVHdHTWlNVkZnQ0pBV3RiSlpyTTJsMVdUVHpHOGxxc3pG?=
 =?utf-8?B?dWhqenpsTWZtNTJ1aWJPS2JqYmFCK3hWYTF0MUJRMmdoc3ZKV0lQazZzTjlm?=
 =?utf-8?B?NStmalFRY2RNVDBDdTNObjh3RTJHNjU4ZUhOTE5xekk5YXhtNTYzeUl3cVBX?=
 =?utf-8?B?RmlieFVBM0xHWnFmTzA4Snp4U21vaWFFYUZsTkttV0lxU2N6MmlDSER6WG9H?=
 =?utf-8?B?R3ppZUdUVEJmcHlJMXkrV3NSTXFqUnMzajVlLzYyVG9pZHJibDBWSWNLNVdp?=
 =?utf-8?B?cUhDVHdkdzFndlZnYks2eVRrYlZ3bkJZSjAxbFdTZXNBRTlsUTF4NUpCTXpR?=
 =?utf-8?B?SUVKTEhpcEZNUHZOcXBmYUdTcjhWV3NWT0haR2xTNnd2eFNHK2hSSFhndEk2?=
 =?utf-8?B?OTRYRTljdjVmTnIwaUdXb3NIMnF6MFdtTEQrUTdHcmJ2VWFXbGwrU0lNLzk2?=
 =?utf-8?B?NXJKKzBaZVFsTWN2ZHpVdXhVOFozK2JKTTJsYm0wdU9SQU95azMwQUNtMkhp?=
 =?utf-8?B?UzB4S1c4UXMrRHpFWmh4SjlUUk9tczgxVnk2eG1UMFl1bnJuVTZMdURsaUE0?=
 =?utf-8?B?N09pZmt3Sm5sc1grYVV2bTFJeVROK2ZBU2NxNmFESWczeGVkbXZlK3A2ZXFP?=
 =?utf-8?B?U2NqUTdFdldpYVhkUkxSci83T3RBaTJMbC9hWHNzR2k4RDlJMzBEdW55Vjd4?=
 =?utf-8?B?bFFUTWxtVWJnWTVlWmJQZU54MFpxV3dGYloyaUFud1JaN1ZBRGpnOC9NZHpm?=
 =?utf-8?B?eEN2ZGtJenlVRTVqNTdrY2pmYjBEWXY2UEFwdTUzNEpWb1dwU3JUdXd3TENR?=
 =?utf-8?B?aHAyNkdSaVoxWkFGZHhvTXY2cWl0Q0YvREhIOUVSSVZUOVVOWVZNbUVWdGpq?=
 =?utf-8?B?YXFrQWlWN0JGbDlLaUtQcWFRbFdxaU4yeWg3TUlETnJaNS81WFJpNTh0UWU2?=
 =?utf-8?B?NWVLcDF0ejAxZUhoQTVCZjhNWTJCMmoyRDVuSnU0OXlOY0lzUkRUcWlMNGEz?=
 =?utf-8?B?QWowYVI4Q3ZQekhRS01wbkMvSUNPWFZnS1ZTbytxYk9KTTh0bjVzQks3QnE3?=
 =?utf-8?B?eXpmcnAyVEdLb0ZtNWREZUcwcEtFdWNQdGJlRnBJYmpRNzd0ZUFZY3RWbFV2?=
 =?utf-8?B?S2RQT0xoNXBuZ1p6R3lUT1MxcmlZdFBQa1dDRVBhOC9QQTFzLzVCQUROTkFT?=
 =?utf-8?B?TlA0anlocUR4dVFzeXFzbWxTMHowb3NOVXJvb1F5a1NIcjB0cVBkdFNGV0tj?=
 =?utf-8?B?Q2czaS9hRjhwUXl4UDdwaE10a2NCSm01eFplVUNqWEE4QmNmeXlMRUhlaDU4?=
 =?utf-8?B?QVM2OStmODZtZ3g3Umhuc3NTMVZSZlQ4Sk9qK1VSRm1jRHlOVHg1L3VlTzlF?=
 =?utf-8?B?bloyRTBnU2NlNUxuZ2ZZLyszbW5tYVNCbkU1aDFraGcydGs0QktZOHFLWnVj?=
 =?utf-8?B?ZGdlRGNVUGg0aHJxSHR3TlM3OXhRVm40bTBFY0d6K0FVenMzY0UxV0RtdHVY?=
 =?utf-8?B?dlJGMnV0RTcxUzl0L3Q3R2RyeEhNcjUrVk5DQkJZN3N2bGpUdk1MTGIrSUN0?=
 =?utf-8?B?cEJwQWJNSG9ub2hST3VSQ2dPZ0pNZG9tQUUySXc3U3pxa0VzQm04VWF0RWNw?=
 =?utf-8?B?N1ZVNWNiU1VyNW5haEwybHc3czRBeFgzM05tSVZQa3pvTS9vUG5jeTl1T1Z3?=
 =?utf-8?B?MjUzZzMxdExVbW1ETzNLSjZkb09WYmRrYXp0OVpsTHRFa3UrR1RHQ2RuZ3Uz?=
 =?utf-8?B?cDlDWTZvSUF1cTExZ2ZkQWQzbzFOOWp4OTJTeEFhQXVsQzkzYms0MGh4TzY5?=
 =?utf-8?Q?81c5LNMHn+EyTtg53qKBsBcyFS7sXmmAS4a8ZEOZqxpXm?=
x-ms-exchange-antispam-messagedata-1: /AuctO1EolEtgg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7340CA73777DB4188631AB02220F80C@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d7849b-3c3a-4623-0b4e-08de8a52ed38
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 09:43:10.3866 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: myCWuiKuVFHfteIDLJviR3+/+PS/0Eknb3DgJfkdQDnmsRYv80gX7ege+6vf7QQuNjF4ONsi6YDk2Q59T13zsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P195MB0629
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

SGVsbG8gRnJpZWRlciwNCg0KQW0gTWl0dHdvY2gsIGRlbSAyNS4wMy4yMDI2IHVtIDA4OjQwICsw
MTAwIHNjaHJpZWIgRnJpZWRlciBTY2hyZW1wZjoNCj4gT24gMjUuMDMuMjYgMDQ6NTAsIFBlbmcg
RmFuIHdyb3RlOg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzRdIGlteDhtcDogcGh5Ym9h
cmQtcG9sbHV4LXJkazogQ29udmVydCB0bw0KPiA+ID4gRE1fUE1JQw0KPiA+ID4gDQo+ID4gPiBI
ZWxsbyBQZW5nLA0KPiA+ID4gSGVsbG8gWWFubmljLA0KPiA+ID4gDQo+ID4gPiBBbSBEaWVuc3Rh
ZywgZGVtIDI0LjAzLjIwMjYgdW0gMTM6MzMgKzAwMDAgc2NocmllYiBQZW5nIEZhbjoNCj4gPiA+
ID4gSGkgWWFubmljLA0KPiA+ID4gPiANCj4gPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDEv
NF0gaW14OG1wOiBwaHlib2FyZC1wb2xsdXgtcmRrOiBDb252ZXJ0DQo+ID4gPiA+ID4gdG8NCj4g
PiA+ID4gPiBETV9QTUlDDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSGkgUGVuZywNCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiBPbiBUdWUsIDIwMjYtMDMtMjQgYXQgMTg6MzAgKzA4MDAsIFBlbmcgRmFu
IChPU1MpIHdyb3RlOg0KPiA+ID4gPiA+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5j
b20+DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IENvbnZlcnQgdGhlIGJvYXJkIHRvIHVzZSBE
TV9QTUlDIGluc3RlYWQgb2YgdGhlIGxlZ2FjeSBTUEwNCj4gPiA+ID4gPiBJMkMvUE1JQw0KPiA+
ID4gPiA+ID4gaGFuZGxpbmcuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IENoYW5nZXMgaW5j
bHVkZToNCj4gPiA+ID4gPiA+IC0gRW5hYmxlIERNX1BNSUMsIERNX1BNSUNfUENBOTQ1MCwgYW5k
DQo+ID4gPiA+ID4gU1BMX0RNX1BNSUNfUENBOTQ1MCBpbiBkZWZjb25maWcuDQo+ID4gPiA+ID4g
PiAtIERyb3AgbGVnYWN5IFNQTCBJMkMgYW5kIFBNSUMgb3B0aW9ucy4NCj4gPiA+ID4gPiA+IC0g
UmVtb3ZlIG1hbnVhbCBJMkMxIHBhZCBzZXR1cCBhbmQgbGVnYWN5DQo+ID4gPiA+ID4gPiBwb3dl
cl9wY2E5NDUwX2luaXQoKQ0KPiA+ID4gPiA+IHVzYWdlLg0KPiA+ID4gPiA+ID4gLSBVc2UgRE0t
YmFzZWQgcG1pY19nZXQoKSB3aXRoIHRoZSBEVCBub2RlICJwbWljQDI1Ii4NCj4gPiA+ID4gPiA+
IC0gVXBkYXRlIFBNSUMgcmVnaXN0ZXIgcHJvZ3JhbW1pbmcgdG8gdXNlIHN0cnVjdCB1ZGV2aWNl
DQo+ID4gPiA+ID4gPiBBUEkuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gdGhlc2UgY2hhbmdlcyBi
cmVhayBzb21ldGhpbmcuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gR2V0dGluZw0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+IExvYWRpbmcgRW52aXJvbm1lbnQgZnJvbSBNTUMuLi4gQ2FyZCBkaWQgbm90
IHJlc3BvbmQgdG8NCj4gPiA+ID4gPiB2b2x0YWdlDQo+ID4gPiA+ID4gc2VsZWN0ISA6IC0xMTAN
Cj4gPiA+ID4gPiAqKiogV2FybmluZyAtIE5vIGJsb2NrIGRldmljZSwgdXNpbmcgZGVmYXVsdCBl
bnZpcm9ubWVudA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IGFuZCBTRCBjYXJkIGlzIG5vdCBhY2Nl
c3NpYmxlIGFzIGEgcmVzdWx0LiBJIGFsc28gd29ya2VkIG9uDQo+ID4gPiA+ID4gdGhpcw0KPiA+
ID4gPiA+IG1vZGVybml6YXRpb24gYW5kIGdvdCB0aGUgc2FtZSByZXN1bHQgYXMgd2l0aCB5b3Vy
IGNvbW1pdC4NCj4gPiA+ID4gPiBIYXZlDQo+ID4gPiBub3QNCj4gPiA+ID4gPiBoYWQgdGltZSB0
byBpbnZlc3RpZ2F0ZSB0aGUgY2F1c2UsIHlldC4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoaXMgY2hh
bmdlIHNob3VsZCBub3QgaW1wYWN0IHNkLCB1bmxlc3MgcG1pYyBub3QgcHJvYmUNCj4gPiA+ID4g
Y29ycmVjdGx5Lg0KPiA+ID4gPiBZb3UgbWF5IGdpdmUgYSBsb29rIG9uICJyZWd1bGF0b3JzIiwg
InBtaWMiIGluIFUtQm9vdCBzaGVsbCwgdG8NCj4gPiA+ID4gc2VlDQo+ID4gPiA+IHdoZXRoZXIg
cG1pYyBpcyBnb29kLg0KPiA+ID4gPiANCj4gPiA+ID4gQW5kIHlvdSBtYXkgYWxzbyBuZWVkIHRv
IGNvbmZpcm0sIHdoZXRoZXIgU0Qgd29ya3Mgb3Igbm90DQo+ID4gPiA+IHdpdGhvdXQNCj4gPiA+
IHRoaXMNCj4gPiA+ID4gbWlncmF0aW9uIHRvIERNX1BNSUMuDQo+ID4gPiANCj4gPiA+IEkgc2Vl
IHRoZSBzYW1lIGlzc3VlLiBUaGUgZXJyb3IgaXMgZ29uZSB3aGVuIHRoZSBwYXRjaCBpcw0KPiA+
ID4gcmV2ZXJ0ZWQgYWdhaW4uDQo+ID4gPiBQTUlDIHByb2JpbmcgaXMgd29ya2luZyBidXQgdGhl
IHZvbHRhZ2UgY2hhbmdlIG9mIFNELUNhcmQgaXMNCj4gPiA+IHByb2JhYmx5DQo+ID4gPiBub3Qu
DQo+ID4gPiBXZSBoYXZlIHNldA0KPiA+ID4gZHRzL3Vwc3RyZWFtL3NyYy9hcm02NC9mcmVlc2Nh
bGUvaW14OG1wLXBoeWNvcmUtZnBzYy5kdHNpOg0KPiA+ID4gdnFtbWMtc3VwcGx5ID0gPCZsZG81
PjsNCj4gPiA+IA0KPiA+ID4gd2hpY2ggcmVmZXJlbmNlcyB0aGUgUE1JQy4NCj4gPiA+IFRoZSBl
dmsgaXMgbm90IHVzaW5nIHRoaXMgcHJvcGVydHkuDQo+ID4gDQo+ID4gSSB0cmllZCB0byBhZGQg
dnFtbWMtc3VwcGx5IGZvciBpLk1YOE1QLUVWSywgSSBub3Qgc2VlIGlzc3Vlcy4NCj4gPiBOb3Qg
c3VyZSB3aHkgdGhpcyBwcm9wZXJ0eSBpbXBhY3RzIHBoeWNvcmUtZnBzYy4NCj4gPiANCj4gPiBU
aGUgb25seSBzdXNwZWN0aW5nIHBvaW50IGlzIA0KPiA+IA0KPiA+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBNWDhNUF9JT01VWENfR1BJTzFfSU8wNF9fVVNE
SEMyX1ZTRUxFQ1QNCj4gPiAweGMwDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIE1YOE1QX0lPTVVYQ19HUElPMV9JTzA0X19VU0RIQzJfVlNFTEVDVA0K
PiA+IDB4MWMwDQo+ID4gDQo+ID4gTm8gbW9yZSBpZGVhcyBhcyBvZiBub3cuDQo+IA0KPiBJJ20g
cHJldHR5IHN1cmUgdGhpcyBpc3N1ZSBpcyByZWxhdGVkIHRvIHRoZSBWU0VMRUNUIHNpZ25hbCBp
biBzb21lDQo+IHdheS4NCj4gDQo+IFdpdGggTVg4TVBfSU9NVVhDX0dQSU8xX0lPMDRfX1VTREhD
Ml9WU0VMRUNUIGJlaW5nIHNldCwgdGhlIFNESEMNCj4gY29udHJvbGxlciBjb250cm9scyB0aGUg
VlNFTEVDVCBzaWduYWwgdGhhdCBnb2VzIGludG8gdGhlIFNEX1ZTRUwNCj4gaW5wdXQNCj4gb2Yg
dGhlIFBNSUMgYW5kIHN3aXRjaGVzIHRoZSBMRE81IGJldHdlZW4gMS44ViBhbmQgMy4zVi4gSW50
ZXJuYWxseQ0KPiB0aGUNCj4gUE1JQyB1c2VzIHRoZSBzdGF0ZSBvZiBTRF9WU0VMIHRvIGRlY2lk
ZSB3aGljaCBvbmUgb2YgdHdvIHZvbHRhZ2UNCj4gcmVnaXN0ZXJzIGZvciBMRE81IGlzIHVzZWQu
DQo+IA0KPiBXaGVuIHZxbW1jLXN1cHBseSBpcyBzZXQsIHRoZSBkcml2ZXIgYWRkaXRpb25hbGx5
IHNldHMgdGhlIHZvbHRhZ2UgYnkNCj4gd3JpdGluZyB0byB0aGUgUE1JQyBMRE81IHZvbHRhZ2Ug
cmVnaXN0ZXIuIFRoaXMgY2FuIHBvdGVudGlhbGx5IGNhdXNlDQo+IGNvbmZsaWN0cyBhbmQgbGVh
ZCB0byBhbiBpbnZhbGlkIHN0YXRlLCB3aGVyZSB0aGUgZHJpdmVyIHRoaW5rcyB0aGUNCj4gY2Fy
ZA0KPiBpcyBpbiAxLjhWIHN0YXRlIGJ1dCB0aGUgdm9sdGFnZSBpcyBzZXQgdG8gMy4zViBvciB0
aGUgb3RoZXIgd2F5DQo+IHJvdW5kLg0KDQpJIG1hZGUgYSBxdWljayBtZWFzdXJlbWVudCBhbmQg
SSBzYXcgdGhlIG1pc3MgbWF0Y2guIFNXIHRoaW5rcyB0aGUgMS44Vg0KaXMgY29uZmlndXJlZCBi
dXQgd2Ugc3RpbGwgaGF2ZSAzLjNWLg0KDQo+IA0KPiBPbmUgd2F5IHRvIGhhbmRsZSB0aGlzLCBp
cyB0byBzZXQgdGhlIFNJT04gYml0IGZvciB0aGUgVlNFTEVDVCBzaWduYWwNCj4gYW5kIHNwZWNp
ZnkgdGhlIHNkLXZzZWwtZ3Bpb3MgcHJvcGVydHkgaW4gdGhlIGxkbzUgbm9kZS4gVGhpcyBhbGxv
d3MNCj4gdGhlDQo+IFBNSUMgZHJpdmVyIHRvIGtub3cgYWJvdXQgdGhlIGN1cnJlbnQgc3RhdGUg
b2YgdGhlIFZTRUxFQ1Qgc2lnbmFsIGFuZA0KPiB1c2UgdGhlIGNvcnJlY3Qgdm9sdGFnZSByZWdp
c3RlciB3aGVuIHNldHRpbmcgb3IgZ2V0dGluZyB0aGUgTERPNQ0KPiB2b2x0YWdlLg0KDQpBZGRp
bmcgdGhlIGNoYW5nZXMgdG8gdGhlIGRldmljZSB0cmVlIG1ha2VzIGl0IHdvcmtpbmcuDQpTbyBp
dCBsb29rcyBsaWtlIHRoYXQgaXMgdGhlIGlzc3VlLg0KDQpUaGFuayB5b3UgdmVyeSBtdWNoIGZv
ciB5b3VyIGhlbHAuDQoNCldlIHdpbGwgY3JlYXRlIGEga2VybmVsIGR0IHBhdGNoIHRoZW4gdG8g
Zml4IHRoaXMuDQoNClRoYW5rcywNClRlcmVzYQ0KDQoNCg0KDQo+IA0KPiBCZWxvdyB5b3UgY2Fu
IGZpbmQgc29tZSBwb2ludGVycyBmb3IgYWRkaXRpb25hbCBpbmZvcm1hdGlvbi4gSSBob3BlDQo+
IHRoaXMNCj4gaGVscHMgdG8gc29sdmUgdGhlIGlzc3VlIG9uIHlvdXIgYm9hcmQuDQo+IA0KPiBC
ZXN0IHJlZ2FyZHMNCj4gRnJpZWRlcg0KPiANCj4gUmVsZXZhbnQgVS1Cb290IHBhdGNoc2V0Og0K
PiBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvdWJvb3QvY292ZXIvMjAyNTA4
MTExMzEyMTMuMjExMTI0LTEtZnJpZWRlckBmcmlzLmRlLw0KPiANCj4gUmVsZXZhbnQgS2VybmVs
IHBhdGNoc2V0Og0KPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgt
YXJtLWtlcm5lbC9jb3Zlci8yMDI0MTIxODE1Mjg0Mi45NzQ4My0xLWZyaWVkZXJAZnJpcy5kZS8N
Cj4gDQo+IEV4YW1wbGUgZm9yIHNkLXZzZWwtZ3Bpb3M6DQo+IGh0dHBzOi8vc291cmNlLmRlbngu
ZGUvdS1ib290L3UtYm9vdC8tL2Jsb2IvbWFzdGVyL2R0cy91cHN0cmVhbS9zcmMvYXJtNjQvZnJl
ZXNjYWxlL2lteDhtcC1rb250cm9uLW9zbS1zLmR0c2kjTDMxNA0KPiANCj4gRXhhbXBsZSBmb3Ig
cGlubXV4IHdpdGggU0lPTiBiaXQ6DQo+IGh0dHBzOi8vc291cmNlLmRlbnguZGUvdS1ib290L3Ut
Ym9vdC8tL2Jsb2IvbWFzdGVyL2R0cy91cHN0cmVhbS9zcmMvYXJtNjQvZnJlZXNjYWxlL2lteDht
cC1rb250cm9uLW9zbS1zLmR0c2kjTDgxMg0KDQotLSANClBIWVRFQyBNZXNzdGVjaG5payBHbWJI
IHwgQmFyY2Vsb25hLUFsbGVlIDEgfCA1NTEyOSBNYWlueiwgR2VybWFueQ0KDQpHZXNjaMOkZnRz
ZsO8aHJlcjogRGlwbC4tSW5nLiBNaWNoYWVsIE1pdGV6a2ksIERpcGwuLUluZy4gQm9kbyBIdWJl
ciwNCkRpcGwuLUluZy4gKEZIKSBNYXJrdXMgTGlja2VzIHwgSGFuZGVsc3JlZ2lzdGVyIE1haW56
IEhSQiA0NjU2IHwNCkZpbmFuemFtdCBNYWlueiB8IFN0Lk5yLiAyNi82NjUvMDA2MDgsIERFIDE0
OTA1OTg1NQ0K
