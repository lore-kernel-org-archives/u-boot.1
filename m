Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C30C48BC3
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 14:24:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AC5587E29;
	Wed, 21 Feb 2024 15:24:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="qHy8bKbt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A354F8801D; Wed, 21 Feb 2024 15:24:34 +0100 (CET)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB02187E01
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 15:24:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1708525470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O0B3F6+jUHjUDbfLvmDmqFwipJE6nWaGfF6uZQqd5rA=;
 b=qHy8bKbt+WUA7FC+oGZeWNHTzONzcjHPi0tpK4IM7rVv04ZEVK99hYzqHCyVza6fGY8QB0
 9uCTOOOk4GOmOKN0H84PqOKaXACgIBMUZpO2WVdOxiXv4Hr/TRD9bvAAPJf75fnmkhl1uU
 wJdCkkF6qoFH/lJXs3RlcXKiGL/DZXg=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2041.outbound.protection.outlook.com [104.47.22.41]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-h0dL1bZoMWGusf9V5mwBiQ-1; Wed, 21 Feb 2024 15:24:26 +0100
X-MC-Unique: h0dL1bZoMWGusf9V5mwBiQ-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR0P278MB0106.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:19::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.21; Wed, 21 Feb 2024 14:24:23 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::36ff:9449:ac0a:edd6]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::36ff:9449:ac0a:edd6%5]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 14:24:23 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "trini@konsulko.com" <trini@konsulko.com>
CC: "clamor95@gmail.com" <clamor95@gmail.com>, "uboot-imx@nxp.com"
 <uboot-imx@nxp.com>, "festevam@gmail.com" <festevam@gmail.com>, Emanuele
 Ghidoli <emanuele.ghidoli@toradex.com>, "francesco@dolcini.it"
 <francesco@dolcini.it>, "sbabic@denx.de" <sbabic@denx.de>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "treding@nvidia.com" <treding@nvidia.com>
Subject: Re: [PATCH v1 5/7] toradex: common: Add sysinfo driver
Thread-Topic: [PATCH v1 5/7] toradex: common: Add sysinfo driver
Thread-Index: AQHaZCrCAI5Dzc/3GU+3jyk5qTm057ETmc2AgAAKjYCAASHfAIAAFQiA
Date: Wed, 21 Feb 2024 14:24:23 +0000
Message-ID: <c7d26d3a59e48582286bc889b67dacdf9e02cbdc.camel@toradex.com>
References: <20240220182926.101161-1-francesco@dolcini.it>
 <20240220182926.101161-6-francesco@dolcini.it>
 <CAPVz0n1oQZR5muRGHFm66hY6jEA8cSVUdJG0t2WTqV=oC6DiEA@mail.gmail.com>
 <bf6806f9ca2444bcbf634cad379e9f34f7aa581c.camel@toradex.com>
 <20240221131002.GT3040305@bill-the-cat>
In-Reply-To: <20240221131002.GT3040305@bill-the-cat>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZR0P278MB0106:EE_
x-ms-office365-filtering-correlation-id: b97ac2ca-062d-4b31-180f-08dc32e8ccf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: xmGRjlyQRw+RU/CJgAN806oKW1J5RSUL7e6poIakPMvDsji4CF24O+MI36VgqlpEYNq8Tq5qYZZMXvE4mbN/mGPbmT9F/rLbhnU0NWq/5fPqaVaPr/YIyk8e/xCpK43rf0iVIh7DrBzh2fZsgzTsvWDwpXGL8iSxAGPtES6i53f5UFVsi0Fd76dK5zsi39WbGW4kmz6X2FfKgNNgt0f4ujaXv64IwuPzam0T4VMGQyQyX6zOcLDOMlx2JMrkM2qsfD32k7xhqXXx7mrxRDIjftVwUJrpCuiMrymVny+I4DMfPQhwbhUqtXF7dDSIl+3hixOkKAUMpdjBCPgZYaUBPW2hYkJ4mqUoRgyCuckaPbHZmfq5ZMJFWhG85iSGlzruKPfPLeWgNn9pslky2MONkbdTbtaKn3mnknSw45kKMH0La3r5lEkhtHf3a+onCkBgYmc5A8xl8Wu/VgR8Skd403XYUSwIYBHNs6aZZYEBY+tx6xXwdHczf5OYwOTo72OSGFnlhDzHXT0xkBob6Ndj1AyY3k/JMN+km0O6Mcs+1KNhzOGacfDhzVrFSWoidrmXrVrg27CWrRoXZIVTDyrOBMtQm05ltguWZlxr9B9eOTw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkJSLyt1SlFvaHB2anV3TTh1NWJ6UEJsbFVFUE02R1R6MTJFOVBwd2EvTHJv?=
 =?utf-8?B?NWxGWFIxM0hLek92RldTUmxkNHdrR2NOUUxxUndXNk5SMW9zWXVUL3Q1bFJu?=
 =?utf-8?B?ZEwrSnlZV2RyTUZ0NnR3aXpad3B0eUs5eDB0N2lJMlhTL21VRnlTS2lnREJQ?=
 =?utf-8?B?MTRTaDZMalc0OGR4eWdMV21NR1Y1MmRXZGliM0ZEOXZCZ1R6MjIzWFgrZW5R?=
 =?utf-8?B?STY1a2hOdDhJOG9OQjZuVGtEay91dkhlY0pSeksyeTBkOXBTcGVZSldVUzZr?=
 =?utf-8?B?eEt5UStuUG4rUXl4L1c1bVRkNHZ6NnVXRFJnMnVXeVgzZ290YUZleHlGazZ1?=
 =?utf-8?B?OTJQNjBrd1ZEUktEYnVTcDVyVGtMenpidkJqVDBZbTZabWpudk9teUlpUW1s?=
 =?utf-8?B?M3FGbUZRMHFXU3B2blk1YUxZVllEaVAyYWhJYThQK1ZrN2h1U2svQURqSU9M?=
 =?utf-8?B?cVJla2Y5L3VZcG56UENQT1R3TUZHaE5DUUpyQmY5OFdkMXNQTlZqYlM2dFBV?=
 =?utf-8?B?RlZpeWVPNUViM1RHM3hBU2k1SjNTS3hlWXRUT3hzK2NxODMzV0lPQmJGV2JS?=
 =?utf-8?B?ek1OWEFianNCZ0EvTVljR2xJN2c3N2NQdmxCVEcreVBoNmVpRndWOU5JaGNq?=
 =?utf-8?B?TUZaNS9mOEo4dlRHR1gvMk5UMTZmUU9BanZDa0tBK1QzOW41VllJUFFjaUFv?=
 =?utf-8?B?MUI5c0ZmcGtFWkg0MGNuQ3J2dEh1OHd6S2hrZ0k2MXYxWS8vR3VESDZBVkhY?=
 =?utf-8?B?OEt4NzhtbE5CL2pDenlBY041OFhkODd3eEpkUGNQblRnRndwOUpjdE5ocnVR?=
 =?utf-8?B?N0JCQ2VPRW51Y2c2blVWSGpwSlhBTFZucktEUjB5Z2xQTFpvcFczcEpxS3c4?=
 =?utf-8?B?MmtKenZxdkxkRkJRVFN2RmpiZUk4dVNmWmpZZmt2Qk1TRmdNcTc3MFU1QmVn?=
 =?utf-8?B?TnNxZUhYZ3BPaHB4Q1MzODNaWklZcENETzh6RjdrRkFpaXRsU1BZODBxMjZB?=
 =?utf-8?B?dFlrWExhSG9qdHA2Q2Nwc2NrOHZqYzVTYjJ1NjMrQkdUbTJyYmQ3SjJ4TkIr?=
 =?utf-8?B?Yjk2MzIrcm42SFlMN1BmcVhuVkcxVklFcFJZNU5lMWNJRzNlZlRJYm1iU2Fu?=
 =?utf-8?B?ek5JSG81Z0o4bGNFUWZFZXNaUEU3QjNjSVBuQ2lCWHcvbHUzOWlWUjlTbW9h?=
 =?utf-8?B?RzlMWUNuMlpWQ1g3M3ZJVTFCakVITFovSmhCbmU1OEo3cGJKU0VSSW5sTjRI?=
 =?utf-8?B?aTZqSU5lclhGVGRhWlpiUDh3TFMrTElzV05XaW1RMW1Dc0ZiSHV1TE1tdldu?=
 =?utf-8?B?SEtaMmZreXh1MXpZdE1vR2djbUR6K1dvaGhhS0M2QUsrZS9ZNFQwa0x1ckk0?=
 =?utf-8?B?RVRQQlZxQlJkcXNXK3VGaFoydHcwT0MwMjYySmtLUzRiOXh3M3UzYlplNDBh?=
 =?utf-8?B?cC91eFZrN1Nqc2ltZW02bi9uSEtJZ3pWejdOcGpMRXpBWnU0YUZXcTBoT0pw?=
 =?utf-8?B?RFBqWHZhVXZUUnZXTHFEQ0dhOTk5RkJFNlhIZE5SMkltM1NZNWlySnIrbmdF?=
 =?utf-8?B?bXpzTHM1OVZwalF0WVp1dFphcjZDckg2SFFsVExRN3dLaDVXK3RkVWVIdlYr?=
 =?utf-8?B?TWg2dHFHYVFzR2w1S0U0MFRKYlg4dnNPWGIwUlJIMHBNckRmN3doNWFLUjBl?=
 =?utf-8?B?SmlTQ1QycEU1QnB0cnY4c1hEVnBBQkd3MFgveTlhazVrbi9IUHBBNXlUYmU5?=
 =?utf-8?B?czErS2gwLzJ4OXFtcVdoYjFPQVRSbGFhVEwycW5QSjBnVU0waDFUd3lwQ3dx?=
 =?utf-8?B?bVF6QTRMQ0lLQ2RTL0VSTFNNa1VyZFJLeEVUeXpjL2MrREU5Qnk5bTVlWFh6?=
 =?utf-8?B?VnY1dTJZamlPRGVzT0pKdWtVZ0hTK09sMThmbnRDdU04aEZXVlZLK3VtVE01?=
 =?utf-8?B?TU1WOXlCYkpVRFY5U1RzV2lBVm5telc1NE1idmY5amtuZ2FJRmZOOFZRN3RJ?=
 =?utf-8?B?UmR1b1pTYkI4RWFTQytVUEM2WW1PMDhLdjIyUllBV1M1R1JzYVRDQjBYc2Na?=
 =?utf-8?B?K1d0RnE3RXcxbUZiQnJyTDlqalBZY0hXMEk3T2p4eFZwUDdiYnBOYVhEVDhm?=
 =?utf-8?B?TlVsUnRpWUluUU5tbWllRnZ2MzFpbkwxYkVPWVZjUndVeE8vZlJBSUR0ckkx?=
 =?utf-8?B?bFE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b97ac2ca-062d-4b31-180f-08dc32e8ccf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 14:24:23.2211 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +wyUxT7hdsPZNyAAn2iCwJK7xCT3p2yfiHrnckmFYxOjxNmjltY/M9QenzBCL0H9OShODIm3j8MptuOgcsYf7mBcD7AcRXHKfFWz5I/t7Ag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0106
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <8561E94023D35C43B9D69C8E4533673F@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
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

SGkgVG9tDQoNCk9uIFdlZCwgMjAyNC0wMi0yMSBhdCAwODoxMCAtMDUwMCwgVG9tIFJpbmkgd3Jv
dGU6DQo+IE9uIFR1ZSwgRmViIDIwLCAyMDI0IGF0IDA3OjUxOjM1UE0gKzAwMDAsIE1hcmNlbCBa
aXN3aWxlciB3cm90ZToNCj4gPiBPbiBUdWUsIDIwMjQtMDItMjAgYXQgMjE6MTQgKzAyMDAsIFN2
eWF0b3NsYXYgUnloZWwgd3JvdGU6DQo+ID4gPiDQstGCLCAyMCDQu9GO0YIuIDIwMjTigK/RgC4g
0L4gMjA6MjkgRnJhbmNlc2NvIERvbGNpbmkgPGZyYW5jZXNjb0Bkb2xjaW5pLml0PiDQv9C40YjQ
tToNCj4gPiA+ID4gDQo+ID4gPiA+IEZyb206IEVtYW51ZWxlIEdoaWRvbGkgPGVtYW51ZWxlLmdo
aWRvbGlAdG9yYWRleC5jb20+DQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlzIGNvbW1pdCBpbnRyb2R1
Y2VzIHN1cHBvcnQgZm9yIHRoZSBUb3JhZGV4IHN5c2luZm8gZHJpdmVyIGluIFUtQm9vdCwNCj4g
PiA+ID4gd2hpY2ggdXNlcyBpbmZvcm1hdGlvbiBmcm9tIFRvcmFkZXggY29uZmlnIGJsb2NrIHRv
IHByaW50IGNvcnJlY3QNCj4gPiA+ID4gYm9hcmQgbW9kZWwuDQo+ID4gPiA+IEluIGNhc2UgdGhl
IFRvcmFkZXggY29uZmlnIGJsb2NrIGlzIG5vdCBwcmVzZW50IHN5c2luZm8gcHJpbnRzIHRoZSBt
b2RlbA0KPiA+ID4gPiBvZiB0aGUgYm9hcmQgcHJvdmlkZWQgYnkgZGV2aWNlIHRyZWUgcmVtb3Zp
bmcgcGVyIGJvYXJkIHNwZWNpZmljIHByaW50cy4NCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IEVtYW51ZWxlIEdoaWRvbGkgPGVtYW51ZWxlLmdoaWRvbGlAdG9yYWRleC5jb20+DQo+
ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEZyYW5jZXNjbyBEb2xjaW5pIDxmcmFuY2VzY28uZG9sY2lu
aUB0b3JhZGV4LmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+IMKgYXJjaC9hcm0vZHRzL2ZzbC1p
bXg4cW0tYXBhbGlzLXUtYm9vdC5kdHNpwqDCoMKgIHzCoCA2ICsrKw0KPiA+ID4gPiDCoGFyY2gv
YXJtL2R0cy9mc2wtaW14OHF4cC1jb2xpYnJpLXUtYm9vdC5kdHNpwqAgfMKgIDYgKysrDQo+ID4g
PiA+IMKgLi4uL2R0cy9pbXg2ZGwtY29saWJyaS1ldmFsLXYzLXUtYm9vdC5kdHNpwqDCoMKgIHzC
oCA0ICsrDQo+ID4gPiA+IMKgYXJjaC9hcm0vZHRzL2lteDZxLWFwYWxpcy1ldmFsLXUtYm9vdC5k
dHNpwqDCoMKgIHzCoCA0ICsrDQo+ID4gPiA+IMKgLi4uL2R0cy9pbXg2dWxsLWNvbGlicmktZXZh
bC12My11LWJvb3QuZHRzacKgwqAgfMKgIDQgKysNCj4gPiA+ID4gwqAuLi4vYXJtL2R0cy9pbXg3
ZC1jb2xpYnJpLWV2YWwtdjMtdS1ib290LmR0c2kgfMKgIDQgKysNCj4gPiA+ID4gwqAuLi4vZHRz
L2lteDhtbS12ZXJkaW4td2lmaS1kZXYtdS1ib290LmR0c2nCoMKgwqAgfMKgIDQgKysNCj4gPiA+
ID4gwqAuLi4vZHRzL2lteDhtcC12ZXJkaW4td2lmaS1kZXYtdS1ib290LmR0c2nCoMKgwqAgfMKg
IDQgKysNCj4gPiA+ID4gwqAuLi4vZHRzL2szLWFtNjI1LXZlcmRpbi13aWZpLWRldi11LWJvb3Qu
ZHRzacKgIHzCoCA0ICsrDQo+ID4gPiA+IMKgYXJjaC9hcm0vZHRzL3RlZ3JhMTI0LWFwYWxpcy11
LWJvb3QuZHRzacKgwqDCoMKgwqAgfCAxMiArKysrKw0KPiA+ID4gPiDCoGFyY2gvYXJtL2R0cy90
ZWdyYTIwLWNvbGlicmktdS1ib290LmR0c2nCoMKgwqDCoMKgIHwgMTIgKysrKysNCj4gPiA+ID4g
wqBhcmNoL2FybS9kdHMvdGVncmEzMC1hcGFsaXMtdS1ib290LmR0c2nCoMKgwqDCoMKgwqAgfCAx
MiArKysrKw0KPiA+ID4gPiDCoGFyY2gvYXJtL2R0cy90ZWdyYTMwLWNvbGlicmktdS1ib290LmR0
c2nCoMKgwqDCoMKgIHwgMTIgKysrKysNCj4gPiA+ID4gwqAuLi4vYXJtL2R0cy92ZjYxMC1jb2xp
YnJpLWV2YWwtdjMtdS1ib290LmR0c2kgfMKgIDQgKysNCj4gPiA+ID4gwqBib2FyZC90b3JhZGV4
L2NvbW1vbi9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMSAr
DQo+ID4gPiA+IMKgYm9hcmQvdG9yYWRleC9jb21tb24vdGR4LWNvbW1vbi5jwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHwgNTAgKysrKysrKysrKysrKysrKy0tLQ0KPiA+ID4gPiDCoDE2IGZpbGVz
IGNoYW5nZWQsIDEzNiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+ID4gPiDCoGNy
ZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9kdHMvdGVncmExMjQtYXBhbGlzLXUtYm9vdC5kdHNp
DQo+ID4gPiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL2R0cy90ZWdyYTIwLWNvbGli
cmktdS1ib290LmR0c2kNCj4gPiA+ID4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vZHRz
L3RlZ3JhMzAtYXBhbGlzLXUtYm9vdC5kdHNpDQo+ID4gPiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0
IGFyY2gvYXJtL2R0cy90ZWdyYTMwLWNvbGlicmktdS1ib290LmR0c2kNCj4gPiA+ID4gDQo+ID4g
PiANCj4gPiA+IEdyZWV0aW5ncyEgVGhhbmsgeW91IGZvciBjb250cmlidXRpb24gYnV0IG1heSB5
b3UgYXQgc3BsaXQgcGF0Y2hlcw0KPiA+ID4gYWNjb3JkaW5nIHRvIFNvQyB2ZW5kb3IgYXQgbGVh
c3Q/IEZvciBpbXgsIHRlZ3JhIGFuZCB0aSBzaW5jZSBpdA0KPiA+ID4gd291bGQgYmUgaGFyZCB0
byBib3RoIHJldmlldyBhbmQgcGljayB0aGVtIHRvIGNvcnJlY3QgY3VzdG9kaWFuDQo+ID4gPiB0
cmVlcy4NCj4gPiANCj4gPiBJIHdvdWxkIGFzc3VtZSBmb3IgdGhvc2UgdXJnZW50IGZpeGVzIHRv
IGdvIHRocm91Z2ggVG9tIGRpcmVjdGx5IHRvIG1hc3Rlci4gVGhhbmtzIQ0KPiANCj4gU28gdGhp
cyBpcyBhIHNlcmllcyB3ZSBuZWVkIGZvciB2MjAyNC4wNCB0aGVuPw0KDQpZZXMsIHBsZWFzZS4g
RnJvbSB0aGUgY292ZXIgbGV0dGVyOg0KDQo+IFRoaXMgc2VyaWVzIGZpeGVzIHR3byByZWdyZXNz
aW9ucyBhZmZlY3RpbmcgbXVsdGlwbGUgVG9yYWRleCBib2FyZHMgKGkuTVgsIFRJIGFuZCBURUdS
QSBiYXNlZCkgYW5kIHRhcmdldHMNCnRoZSBjdXJyZW50IG1hc3RlciwgZS5nLiB2MjAyNC4wNCBy
ZWxlYXNlLg0KDQpUaGFua3MhDQoNCkNoZWVycw0KDQpNYXJjZWwNCg==

