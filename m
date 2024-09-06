Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0CBCE7AB8
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 08:08:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE76188113;
	Fri,  6 Sep 2024 10:08:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E519883D4; Fri,  6 Sep 2024 10:08:18 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20707.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::707])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B44F88113
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 10:08:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWcgnf/2mre9hvsBvMYNTH2nGVf03ZtjJHO6mSxdWNJ8sPt66V8tvmzX2cpUJmLVk0fRXULVl0DUXf11M351+0FbDgvuaE7YjgpsOkEvr39ezIFWARowiWBENcUk082tm30EdHhUktWHtaxYi0unrjYSwEvYgHqeIGILWY31HPYq+NQEFnCoTH6mgus1cr58GTKfXEszEjccjb9zZ3OU6tQpOUR+eBXSjEWC7fZXLfIbOTPd6gzIt/S8Oga9YFRTwLvLYtb4xguW2hx0D9MRdDVi6wuwyewzo1tM65AsVH+gdv7QTsubj5RniBv7C/ShdGG1t0hYzHO4wME/xpWRPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1RFsBx1l0ir5WF2YP+yMvBym7g2c6VhAugdOgwQJxQ=;
 b=SP/ae1XJIe/Qs2VjTE8x8jVv6LhgHEYeDhoz67ga6qvbxschTake7crkZywBbxS92+UNZWXDqK6xXNiiR0f+kiuQMLl9lgpAXXO2t5FpFQabqDtSKM52ZJVBTYbsneIeRlf0J0TkW2TXvjenSyjduRbEU51uB4NA06/PBc+b7OAnu/8YiZl8w1+SoZ2jeYUDDYBqpF6FEyMHT+fabBFtJ3W21VXVNZBUgwL/dBHvd1o1E/q1kkp33ufJRzLgg5tmJYdHHSEkUInf0c+ihplXnZph+/AaJJRgOS7eHQuGhhdGAi7BcYtnASJNf0a0RVrCXpS7SCV/y4fKTBYBeIB4Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0639.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.31; Fri, 6 Sep
 2024 08:08:10 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%5])
 with mapi id 15.20.7897.029; Fri, 6 Sep 2024 08:08:10 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Roger Quadros
 <rogerq@kernel.org>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, Neil Armstrong <neil.armstrong@linaro.org>, Alexey
 Romanov <avromanov@salutedevices.com>, Sumit Garg <sumit.garg@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Nishanth Menon <nm@ti.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, E Shattow
 <lucent@gmail.com>
Subject: Re: [PATCH v4 2/9] phy: starfive: Add Starfive JH7110 USB 2.0 PHY
 driver
Thread-Topic: [PATCH v4 2/9] phy: starfive: Add Starfive JH7110 USB 2.0 PHY
 driver
Thread-Index: AQHa+bMgtIcz9GyCq0S+ln9vdu+43rI/ALGAgAtzuqA=
Date: Fri, 6 Sep 2024 08:08:09 +0000
Message-ID: <SHXPR01MB08632175780A7FBFE0C6B5D6E69E2@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20240829013058.6178-1-minda.chen@starfivetech.com>
 <20240829013058.6178-3-minda.chen@starfivetech.com>
 <cf1beaa1-8811-4c33-aad3-febd7ea3c00b@denx.de>
In-Reply-To: <cf1beaa1-8811-4c33-aad3-febd7ea3c00b@denx.de>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0639:EE_
x-ms-office365-filtering-correlation-id: 8350bb84-4ccf-411c-50cb-08dcce4b0c1a
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|41320700013|366016|1800799024|7416014|38070700018|921020; 
x-microsoft-antispam-message-info: Js5fnP6fl3zIyhhHs3GnYyVGDpqYzwsfsGjwd1qfNCgUZ4U4b8iPHY2jpm3xScCl4+hiuCk+2yCfPSivGuosNeCOQfWlytuMSKrKkKAx/JZPr5+re4E3Oa0VJvOA4bMtpLi9KfGM10Rc/Py7uY+D8Boy0Pkk/MuIhqZAsuV4Thm9CtwHwOVpY9WxWF7v3+vCHCDIltir4OpiPgLEfowh00dyaGmJpAzT6V0pfDb+r7PL8bwDXA/KUVNVrJND0KH6ezPxSzwQbFip/BggFU0VwlPotYlVwW9Lk51lp8+vvpoRTuS+4OEEImLbas+3oLynmmShwnsRK36eYDwUD5nuTQ9VeyFXHkTlAItje1pmV7LjwBf1SssMYaRJcaCfUpcC+xRd6SCXvdjRPKKTp7P+c1NNb08ChXAyAuzkGLgHTPGFmtw3cYzKXQO+jpq0Lx5EXhUxljFCpptG2cAsOAjJXE8AIKJupjLWYXt+Mb98X2tG/rPHmvlFwmbh6Rw+lcMo+iqUhB+OHdRwSrIgmLoahL/HKBV8Vpj6wAiJI5RSOVbBwtl3hvHojKAy6Ei0KuoyqI5TQH6I6DV3L1Gl+tsaMJ6E2JoJZWB5+EkwrJdf+4WGoUBMSgQGXdGOygJN1shtzFawjEBuVkfhNG1pjIF4mw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(41320700013)(366016)(1800799024)(7416014)(38070700018)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkpZYnUrMlVQYnMxWjBYNzlHRExLREtYMi9WZzdmN3RhZE5wYUVtVlVvL0RG?=
 =?utf-8?B?eW1Ub1JmTFd4WEUvSm1TZDVrNytTUkxTMmwxNCtzZ1BKQlA0dTY5RWRjU1Zh?=
 =?utf-8?B?S1lXWUllMDZ0WXpPVjVNU3dCTGgxMk4rTUFYTmdVemlkWXFtSnM1eklGWFdE?=
 =?utf-8?B?QnVNRXNROThUdG1iRzg0TDh1WDdXMG5HMDQ3a2JUY3c0VW4wZ0g4OWpZY3Zi?=
 =?utf-8?B?T3Z6K2tZV3paOGxFMjlRaUJOWlI3WU9mUXN0L0ZBdUVVWmFrR3JMZ01jTlJy?=
 =?utf-8?B?NERkdUZOaVlsM2FQb0ZqWnBHWlQvMitqd0RQQnNIRUkzR0VJdWI3cmdyNURT?=
 =?utf-8?B?am5DaXRieWJDZ2xkVVplNUZzd3hwLytCRTJOUkZZRlpMcGlDek1OdG5lUjdN?=
 =?utf-8?B?Zlh6a1VFdG9WRTNRS29hZGhReUtrN3hVZ1U2bS9zZXM0a2ZIbkE3MjRuaGdh?=
 =?utf-8?B?aGRGM3dITnU2VUM3cXZOUThtbXd2aFYzTUV4cjE4SGg0QXFKdllHMjhzSnln?=
 =?utf-8?B?TVJsT3dSYldxam1yMDlWS2RTa1dSOWNvdFZNRWp4WWZVVy84QitmQkZNQUZQ?=
 =?utf-8?B?emhNMk50ZTlBSHAweUJ6RXZ2SVFBZjZETGF5OFo4MTVscFdBczNKc0JNVGNV?=
 =?utf-8?B?cnEwOFEzdnJFeTlkYmJPTi95ODd1eGFSME9TY2l6YlJ0aitYMDZyam5FQUkr?=
 =?utf-8?B?NHhTc0xYb0FTWHJ4bjdDSmwraVBTUjNSTjRlSTRFdEYvWUQ4eTNybFdyRnM4?=
 =?utf-8?B?RWVhR2VJRFp0VytPY1NPSlBjQkd5bHJhbHlreXVmZkE3K1lHK3cveEpOQ1g5?=
 =?utf-8?B?UmVhZzJzOVdOd1RWS0F0dkxuZTkxT21mdjRDeGRaVUxQZmo3UWdqTk12anU5?=
 =?utf-8?B?QmRLUEpLeW5lUy9WeU9BUFMwVlJMbENxTm1SNFdLaWpJLzdYeFRiU09pbGor?=
 =?utf-8?B?OHBzc0RjTjk1S1B5d2ZwN1JtdXRkR1prcm4yb3dMVmo5REFOOFNPSTVydFlq?=
 =?utf-8?B?SGVEZWNITmZscExRSVNDVzcxVVNiTWJScGd1aVFCeVZ1ZHgwRU9YTGZSWFRo?=
 =?utf-8?B?ZlhxVDRwcG9MNnM1NHRVTS9vRW9USnl3K0tJeXZoUE82RjJ6RFZHUnl1YzVX?=
 =?utf-8?B?MXV1VE9CM2JUZ3hBVFdsVWNTcE44WmdhL256ajNHTkVleFZPcDg3UkJWbGx1?=
 =?utf-8?B?cjVvelNHN2c1VkJHbUhST0drejZQdS9TZEk1UlVRTmMvYk9XVExTc2h2TjJv?=
 =?utf-8?B?U2ZUZVUvd1k5T0pTYnlOdTkxNGdwVHlINEFiYlRHZENVTlBMWEIyMXgycTI5?=
 =?utf-8?B?cHlOakEvMTlLeUFPQXRoZ1AwZ0gvQ2FmSzVmSzZKdi96bFAzRkRXa0Fodzdh?=
 =?utf-8?B?RTBLNi9wQXVwbEVCT3l6MHQzcmR4VXpMY1BFdXlYNmhmb25oUXNRV2VMaTBx?=
 =?utf-8?B?RTZ1MUhHOWtLRHNlbDJra1lsMklMdndOTXF6UmJKNjNFQkw0T2lnRE9OUm13?=
 =?utf-8?B?TVYveDF3SUdNRXRtbzhYcmFISG9hSTZkZEVZT2E4MXVqRGlRZ0l2U01kUGhs?=
 =?utf-8?B?SnBSUG9BSmF0NklwYXU5blVpOE5FeGpuc3hOZ3JmRjYzU1psQ2sxcVVRcmJD?=
 =?utf-8?B?cWg2ekl4TnNhY2kxeDNhbkZtV1ZNLzIvcU5wK1gyL29iNzdhNEllUFRka3Rl?=
 =?utf-8?B?SCtGZTJmWWMrdEg0R3BUOVZwQ1VVTjJWZUtwUmoxQlVkdzdSVExCNUZPNGVn?=
 =?utf-8?B?RGdFVzk2MlZFMjYrSFpUQ25iVzZHekFPaE1hbXBIaUhHaHJaNExMZ3ZrZnQz?=
 =?utf-8?B?b3FVeUpwYUN0d3BMSkVCMVk5RXNtQ1UwaTd4WGFDYyt6d2xLc0xURTNHb09l?=
 =?utf-8?B?YUliaThoYjBJY2xGUGNyUDc0dklkVG50aXloemlodEFwYnAvbmYzTGJXSnFk?=
 =?utf-8?B?QjRXcXh0MktZMWhsa2V6b3prMStyTzk0emNNd2JVNTBlUXlrYXZGa2VuM3NS?=
 =?utf-8?B?SjBHOTdrcGQ3aUpSZGVGRDFsd2ZnZTd2aXU2ZEJJai9oWnhOVktUY21lUzNk?=
 =?utf-8?B?eGdWNDAzcG5PN3U4TjVZVmJzZ3p4L0ZHdTRnaWhWQjdqaHJ5a0R5S2NscFNp?=
 =?utf-8?B?MmVSVkJtc3N0SmtqYXR2Y0JYbU5vSGkvUGpPWVp6Qi84djM0TTZRcXpUZE5T?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 8350bb84-4ccf-411c-50cb-08dcce4b0c1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 08:08:10.0137 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WXudSr7alxfihjWsnklu+fm/zGGZNd6Grxq+QkMYsNfhcYptJuT7+hBCADygdohK/2amKC07wP8lpHDqOBHbRwwSdAFq8GE3HvDVtlsdC9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0639
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

DQoNCj4gDQo+IE9uIDgvMjkvMjQgMzozMCBBTSwgTWluZGEgQ2hlbiB3cm90ZToNCj4gDQo+IFsu
Li5dDQo+IA0KPiA+ICttZW51ICJTdGFyZml2ZSBQSFkgZHJpdmVyIg0KPiA+ICsNCj4gPiArY29u
ZmlnIFBIWV9TVEFSRklWRV9KSDcxMTBfVVNCMg0KPiA+ICsJYm9vbCAiU3RhcmZpdmUgSkg3MTEw
IFVTQiAyLjAgUEhZIGRyaXZlciINCj4gPiArCXNlbGVjdCBQSFkNCj4gDQo+IENhbiB0aGlzIFBI
WV9TVEFSRklWRV9KSDcxMTBfVVNCMiBzeW1ib2wgYmUgc2VsZWN0ZWQgaWYgQ09ORklHX1BIWSBp
cyBub3QNCj4gc2V0ID8gSSB0aGluayBpdCBjYW5ub3QsIHNvIHRoaXMgJ3NlbGVjdCBQSFknIGlz
IHVubmVjZXNzYXJ5IGFuZCBzaG91bGQgYmUgcmVtb3ZlZC4NCj4gDQo+IFsuLi5dDQo+IA0KVGhh
bmtzLiBJIHdpbGwgY2hlY2sgaXQuIA0KT3RoZXIgYXJlIGZvcm1hdCBpc3N1ZXMuIEkgd2lsbCBt
b2RpZnkgdGhlbS4NCj4gPiArc3RhdGljIHZvaWQgdXNiMl9zZXRfbHNfa2VlcGFsaXZlKHN0cnVj
dCBqaDcxMTBfdXNiMl9waHkgKnBoeSwgYm9vbA0KPiA+ICtzZXQpIHsNCj4gPiArCS8qIEhvc3Qg
bW9kZSBlbmFibGUgdGhlIExTIHNwZWVkIGtlZXAtYWxpdmUgc2lnbmFsICovDQo+ID4gKwlpZiAo
c2V0KQ0KPiA+ICsJCWNscnNldGJpdHNfbGUzMihwaHktPnJlZ3MgKyBVU0JfTFNfS0VFUEFMSVZF
X09GRiwNCj4gPiArCQkJCVVTQl9MU19LRUVQQUxJVkVfRU5BQkxFLA0KPiA+ICsJCQkJVVNCX0xT
X0tFRVBBTElWRV9FTkFCTEUpOw0KPiA+ICsJZWxzZQ0KPiA+ICsJCWNscnNldGJpdHNfbGUzMihw
aHktPnJlZ3MgKyBVU0JfTFNfS0VFUEFMSVZFX09GRiwNCj4gPiArCQkJCVVTQl9MU19LRUVQQUxJ
VkVfRU5BQkxFLCAwKTsNCj4gDQo+IEVpdGhlciB1c2UgY2xyYml0c19sZTMyKCkgb3IgdXNlIHJl
d29yayB0aGUgZnVuY3Rpb24gdGhpcyB3YXk6DQo+IA0KPiAJCWNscnNldGJpdHNfbGUzMihwaHkt
PnJlZ3MgKyBVU0JfTFNfS0VFUEFMSVZFX09GRiwNCj4gCQkJCVVTQl9MU19LRUVQQUxJVkVfRU5B
QkxFLA0KPiAJCQkJc2V0ID8gVVNCX0xTX0tFRVBBTElWRV9FTkFCTEUgOiAwKTsNCj4gDQo+IFsu
Li5dDQo=
