Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CB1C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 20:24:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEFE387A0E;
	Mon, 15 Apr 2024 22:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="QGh46aYe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A8B08826E; Mon, 15 Apr 2024 22:24:27 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C37B878ED
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 22:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1713212664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bb8+obQYd+ocC2tEIjhb8jmSIlBQhQ18qttfJGWYEfg=;
 b=QGh46aYeiSp4PkwoClLCTF/NBMhbIAxjISLhvxwahnSdsbPLlXz2HPIBnKtgq4hn6tYpWG
 fWLRop9PDs/FWFQBGQKRKg4zIgTKRQLfkMpZt/zM9/rRIaeCZuqWkMoA2hCfV/YgxtDBHE
 h2jX/0731dBpiQtK+nQkmzArvcvPA8I=
Received: from ZRZP278CU001.outbound.protection.outlook.com
 (mail-switzerlandnorthazlp17011007.outbound.protection.outlook.com
 [40.93.85.7]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-70-L9yXJ2eFO8uDrs1FN1p0vQ-2; Mon, 15 Apr 2024 22:24:23 +0200
X-MC-Unique: L9yXJ2eFO8uDrs1FN1p0vQ-2
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR1P278MB1580.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:a9::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.42; Mon, 15 Apr 2024 20:24:20 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ff81:7388:f0a:3555]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ff81:7388:f0a:3555%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 20:24:20 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "francesco@dolcini.it" <francesco@dolcini.it>, "trini@konsulko.com"
 <trini@konsulko.com>
CC: "d-gole@ti.com" <d-gole@ti.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Parth Pancholi <parth.pancholi@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, "kamlesh@ti.com"
 <kamlesh@ti.com>, "n-francis@ti.com" <n-francis@ti.com>
Subject: Re: [PATCH v1] arm: dts: k3-am625-verdin: add tifsstub to tispl.bin
Thread-Topic: [PATCH v1] arm: dts: k3-am625-verdin: add tifsstub to tispl.bin
Thread-Index: AQHajwo7l3sIMmt5pUyYu5QeN6btcrFpx7KA
Date: Mon, 15 Apr 2024 20:24:20 +0000
Message-ID: <1186f66c6518f3cc3135390e67c7e1a5588f99ca.camel@toradex.com>
References: <20240415075458.8584-1-francesco@dolcini.it>
In-Reply-To: <20240415075458.8584-1-francesco@dolcini.it>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZR1P278MB1580:EE_
x-ms-office365-filtering-correlation-id: 2155a5f1-dd0c-45bd-5cee-08dc5d8a0800
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: VRnrphfYyTsd3bAJvdQmp/Ll3SsHQ+wVA0Fwlkkvmh5UFQl1DjVxi5X/jEwSQpTexIlWmX9gSjfX+dXMaIjyUWBi0QFoF+1Yokmm9MsiwuWklB4hlEG17EZWDTh8OJSQCRZYePQI4yHokTbxPX3+mWJCUfQMUu4YtwhnN0lPixeU23Tc0/68Oc/jtGFiwFhsW08AWkWt+53RmoGcea47T0KaYT6McOSuIpIcNRdujXarzdH2r7+EoasDmw4tZsDhDDNVKPPyYPuUUz54vMXHWSjOtUSHtlqXqzKOH5qN586F1lHJZK7MLoHs4AWBd++Rvq0D6bIgZLQA81xR8YoHxsXcDdMrtcC1fyWlgrWs/R9ObvyrS4SE4tj7E0ThSK458uy7uyraTdaZ6ip7FNd4h/nRUjXNjWBHd5v4blnb04tGS4hB9KjS1Oj9oirRC0TRN9bdftCXh5PTq3KUdpwcwXRnpLMVgnFswzkBQVjn+i3ibvTRhALuuFhRo8M9fIgvsZVw6T5uA9+yl3wWwbSbu/a8/Ul7J4lKDRe/PHlDlusde+dvw/58LxvrHDOZHVOfflgk7i9KKgKStSejmX7h3v1ajA5k4F/OP4ndIrW4YzL6wmApZjYX27EbQAlRcWUpNHsgAmNjYyu15OOfr/iItWBg2ArkpPx43lvmJT/6IqnnB1hRGfjumbyxIY4Gr0eB1JtYMjqUlsuCMDpbWXCdKQK8pcOUNjc+XeiYXDoxjhg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlR2d0doajhQMXVVRUQ4M3dRb2FrNytNcm43VE1kRnpDeXFYb1N1ZVNTVklr?=
 =?utf-8?B?Zjd3MFgvZExtRkNvMy9iT1NqUGIwcGZ0b05nNTlZdmdKQUtRdzRjQnRXMi8y?=
 =?utf-8?B?OWFmWlJ2UVhBVEVGUmpCcUhHR3VvMjhLWVlMckc1MDFWcFB5K292ZVJrVWNv?=
 =?utf-8?B?MStDelYwcGc4cXIzb3NDeDFFeGFOaTNkZllwYzl4WS9SQ3JZcDhNSHoyNXFR?=
 =?utf-8?B?WnVIL2xVY0dDTWh5WGdyV0IvdFM5NDFpYTRxcjQ0U1hyNW5TUENmemRGUVhN?=
 =?utf-8?B?MG1PWVRNTzFRSDN4NHhOV0JyWENqWkZEL1djT1Z0Rkx0QlFkYTNBeEpaeHVa?=
 =?utf-8?B?MExOQUxpSm1nanU2K1NRTzk5OTRJaVVUQXFsTDV5OWFuMEdSdGR4Sm1sOTFw?=
 =?utf-8?B?MUNZL1pnUkZWZXBQQlIydXN6SjZIUzFuZnNkR2ZBK0YwdGlsS1Q5eG9KUXRJ?=
 =?utf-8?B?bVBXRTFsTVhtNTNROTBtMHdLNkdDT3llRUYvcXp3ZXBhZjVUNHV6akJnZEl0?=
 =?utf-8?B?R3ljd25qckF1K2JKcENqSVZ6VmpIZE9HM2JTTUI0VG1iVmFsOXA5YkN2b09z?=
 =?utf-8?B?REU0SlRpYWlYa1BFWnJwYnBNTUhIT0xQMVZlNmp2NlduN2EzamxWTkZ2TWZL?=
 =?utf-8?B?eVhGVUZhNjFMV1VwZENnNDNxeU9MUERWVnZNSFNQSnRRTnAyakJGc0pnaldQ?=
 =?utf-8?B?SDdUU3FhakhVMFo2dHZtdVlCS1FLK3VNVjRFb010VkVxSDcxV2Eyblp1V3ll?=
 =?utf-8?B?UjAvdmlwY0FHSG9GTktWR1V5YUl1RVB4M2dqa1h4L2UvaS9wdHdZa2VRU0F2?=
 =?utf-8?B?d0lnaDcvVVhXK2tzTTZXaEtJMk5ROWVVa0ZLeXJpTGw0ZE83QnkzSmVEbnUz?=
 =?utf-8?B?WVh5M3ZDSHc2ZjdDVVZmRkkrNGhrTDk1bEJ5OHZoZVNtNUUySTkzaGVhcDBj?=
 =?utf-8?B?ZHBjUkFmaHRSVFluQ0krOElpU2FrZDE2TkFDSGF1YW82STViaVpoSUtrVG42?=
 =?utf-8?B?eHdsR0Rpd2p6Wmd0bzFDYUhZTWtpdlpzaEZGQzBCYVhmcnlWWVFMVk5neHNW?=
 =?utf-8?B?cU9zSyt6L0kyWUJVMlFPOGd5V3UzNUlMdDVLcStHbTgzNnBmb2hCTStKaXdV?=
 =?utf-8?B?ZEZHNEFFM0NpWnV1WFVZOFJOVlJNd0FUWFdNcmd6alBkK0V4NFVwcVk0d3RY?=
 =?utf-8?B?cFJXTUVldzNaeSt5VlI3T3VJQUdacWJQdGxJMm16THV3NFhqcTNzbW1iT2Zu?=
 =?utf-8?B?M0tsZ3RUaDdWTkl4aklJcUlSV0MyRWxBa3FUcG52dGFYQjJWUUdwblA4b25z?=
 =?utf-8?B?eGd5RXRzZmNFWERhdEZhbGh4WWUwMXF5V25iZTJmN0NIK3lDdW4ycGR2aEw0?=
 =?utf-8?B?UDN5MXRmb0ZUWFUxcWdYaXpCZmEzbmI5NW8rQW0zSXY3SmNycUpmNzdBaXlz?=
 =?utf-8?B?VjNxd1VqVElFWlA0WHpsaVl1Ujc1c2VPdW41dXFtanJhQW9xa1Jwek0vZlov?=
 =?utf-8?B?TkM4TkgvRG9qdnE5MlBzY2kxd2hlWkEzRWlsc25mSUpLZHBzYkNxdW5CL1ZQ?=
 =?utf-8?B?Sm85TkxmZERuNDdkYzBCVzFQRUJvRnRRZ3NNZ0lhTXd5ZWx1N0FaaklEVG80?=
 =?utf-8?B?YUM5dEVBYWdENm9HcEFkRkZOajZubWlqNkZxaUlDUUtta0xwQ0ExREtsa2Zl?=
 =?utf-8?B?UDBZMjdhNXhiZmF1NmttQWpCbVpseEN3bWhvR0gxV3VxcWFRT0ZuKzFVOFJK?=
 =?utf-8?B?Yk1Ocy92eXp6UCszSWY5amFRcndWTGs4MDhtMDlNMC95d2Ewc2dKVFFNMlF2?=
 =?utf-8?B?YzNVU09ISVU2V0VXSXBUcUdkT3ljZDE1cVBORGV0OWJmOFk5RFlQZ29idk1X?=
 =?utf-8?B?RDZMeDk2TXZ6REN6eGxVdVpIM1EveFZjd3ZNenlGaGRZdTlvL2lNU1llU0Qw?=
 =?utf-8?B?Qmo1M1h3RTJ6SlZDWkFiUW5NRmdrTUlrM3NDTlJMajRTR29WRDZLVVZ6OW4r?=
 =?utf-8?B?Zm1PRGVkWDd0bGp2WUh6cUJNMVlLYkpiZVBPQ1c4bjJaclpjTlBDWmZDanlF?=
 =?utf-8?B?L0h1bUdiTStKVlRlMkFPU0w2NlRvVWJoS05hQ0tKOGNNWHpJUjVFSkpiK0U0?=
 =?utf-8?B?OTZwaHZUQ2UxNmNqZUU5M0ptYkxnZjFSOE01VmRteHVSaHBSbkNvdDJ1ajd2?=
 =?utf-8?B?V0E9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2155a5f1-dd0c-45bd-5cee-08dc5d8a0800
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 20:24:20.0427 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UAgGDoT1N31B9PUh8reDSruNTmZ16YYCgbfmxV5YDSFcPeCbYZ4WzXLsVqhBPpm99K90e2B1m8UhdhlmUpdczUhpM/cwZcu8vLiloguIA9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1580
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <CB3F597E04EB254791B74B4A295A6CCF@CHEP278.PROD.OUTLOOK.COM>
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

SGkgRnJhbmNlc2NvDQoNCk9uIE1vbiwgMjAyNC0wNC0xNSBhdCAwOTo1NCArMDIwMCwgRnJhbmNl
c2NvIERvbGNpbmkgd3JvdGU6DQo+IEZyb206IFBhcnRoIFBhbmNob2xpIDxwYXJ0aC5wYW5jaG9s
aUB0b3JhZGV4LmNvbT4NCj4gDQo+IEFkZHMgdGlmc3N0dWIgYmluYXJpZXMsIHRoaXMgaXMgcmVx
dWlyZWQgZm9yIGRlZXBzbGVlcCBmdW5jdGlvbmFsaXR5Lg0KPiANCj4gVGhpcyBpbXBsZW1lbnRz
IHRoZSBzYW1lIGNoYW5nZSBhcyBjb21taXQgMTI4ZjgxMjkwYjdkICgiYXJtOiBkdHM6IGszOg0K
PiBiaW5tYW46IGFtNjI1OiBhZGQgc3VwcG9ydCBmb3Igc2lnbmluZyBUSUZTU1RVQiBJbWFnZXMi
KSBkaWQgZm9yIFRJIEFNNjINCj4gU0sgYm9hcmQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQYXJ0
aCBQYW5jaG9saSA8cGFydGgucGFuY2hvbGlAdG9yYWRleC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6
IEZyYW5jZXNjbyBEb2xjaW5pIDxmcmFuY2VzY28uZG9sY2luaUB0b3JhZGV4LmNvbT4NCg0KQWNr
ZWQtYnk6IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPg0KDQpK
dXN0IG9uZSBtaW5vciBub3RlIGluLWxpbmVkIGZ1cnRoZXIgYmVsb3cuDQoNCj4gLS0tDQo+IMKg
Li4uL2R0cy9rMy1hbTYyNS12ZXJkaW4td2lmaS1kZXYtYmlubWFuLmR0c2nCoCB8IDE0MCArKysr
KysrKysrKysrKysrKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMTM4IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vZHRzL2szLWFtNjI1LXZl
cmRpbi13aWZpLWRldi1iaW5tYW4uZHRzaSBiL2FyY2gvYXJtL2R0cy9rMy1hbTYyNS12ZXJkaW4t
d2lmaS1kZXYtDQo+IGJpbm1hbi5kdHNpDQo+IGluZGV4IDZmNTg0NTAyNGYyNy4uYTliODZiNjFl
NTNlIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9kdHMvazMtYW02MjUtdmVyZGluLXdpZmktZGV2
LWJpbm1hbi5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2R0cy9rMy1hbTYyNS12ZXJkaW4td2lmaS1k
ZXYtYmlubWFuLmR0c2kNCj4gQEAgLTE1MCwxMiArMTUwLDEwNyBAQA0KPiDCoAkJCWZpbGVuYW1l
ID0gInRpLWRtL2FtNjJ4eC9pcGNfZWNob190ZXN0Yl9tY3UxXzBfcmVsZWFzZV9zdHJpcC54ZXI1
ZiI7DQo+IMKgCQl9Ow0KPiDCoAl9Ow0KPiArDQo+ICsJdGlmc3N0dWItaHMgew0KPiArCQlmaWxl
bmFtZSA9ICJ0aWZzc3R1Yi5iaW5faHMiOw0KPiArCQl0aS1zZWN1cmUtcm9tIHsNCj4gKwkJCWNv
bnRlbnQgPSA8JnRpZnNzdHViX2hzX2NlcnQ+Ow0KPiArCQkJY29yZSA9ICJzZWN1cmUiOw0KPiAr
CQkJbG9hZCA9IDwweDQwMDAwPjsNCj4gKwkJCXN3LXJldiA9IDxDT05GSUdfSzNfWDUwOV9TV1JW
PjsNCj4gKwkJCWtleWZpbGUgPSAiY3VzdE1way5wZW0iOw0KPiArCQkJY291bnRlcnNpZ247DQo+
ICsJCQl0aWZzc3R1YjsNCj4gKwkJfTsNCj4gKwkJdGlmc3N0dWJfaHNfY2VydDogdGlmc3N0dWIt
aHMtY2VydC5iaW4gew0KPiArCQkJZmlsZW5hbWUgPSAidGktc3lzZncvdGktZnMtc3R1Yi1maXJt
d2FyZS1hbTYyeC1ocy1jZXJ0LmJpbiI7DQo+ICsJCQl0eXBlID0gImJsb2ItZXh0IjsNCj4gKwkJ
CW9wdGlvbmFsOw0KPiArCQl9Ow0KPiArCQl0aWZzc3R1Yl9oc19lbmM6IHRpZnNzdHViLWhzLWVu
Yy5iaW4gew0KPiArCQkJZmlsZW5hbWUgPSAidGktc3lzZncvdGktZnMtc3R1Yi1maXJtd2FyZS1h
bTYyeC1ocy1lbmMuYmluIjsNCj4gKwkJCXR5cGUgPSAiYmxvYi1leHQiOw0KPiArCQkJb3B0aW9u
YWw7DQo+ICsJCX07DQo+ICsJfTsNCj4gKw0KPiArCXRpZnNzdHViLWZzIHsNCj4gKwkJZmlsZW5h
bWUgPSAidGlmc3N0dWIuYmluX2ZzIjsNCj4gKwkJdGlmc3N0dWJfZnNfY2VydDogdGlmc3N0dWIt
ZnMtY2VydC5iaW4gew0KPiArCQkJZmlsZW5hbWUgPSAidGktc3lzZncvdGktZnMtc3R1Yi1maXJt
d2FyZS1hbTYyeC1ocy1jZXJ0LmJpbiI7DQo+ICsJCQl0eXBlID0gImJsb2ItZXh0IjsNCj4gKwkJ
CW9wdGlvbmFsOw0KPiArCQl9Ow0KPiArCQl0aWZzc3R1Yl9mc19lbmM6IHRpZnNzdHViLWZzLWVu
Yy5iaW4gew0KPiArCQkJZmlsZW5hbWUgPSAidGktc3lzZncvdGktZnMtc3R1Yi1maXJtd2FyZS1h
bTYyeC1ocy1lbmMuYmluIjsNCj4gKwkJCXR5cGUgPSAiYmxvYi1leHQiOw0KPiArCQkJb3B0aW9u
YWw7DQo+ICsJCX07DQo+ICsNCj4gKwl9Ow0KPiArDQo+ICsJdGlmc3N0dWItZ3Agew0KPiArCQlm
aWxlbmFtZSA9ICJ0aWZzc3R1Yi5iaW5fZ3AiOw0KPiArCQl0aS1zZWN1cmUtcm9tIHsNCj4gKwkJ
CWNvbnRlbnQgPSA8JnRpZnNzdHViX2dwPjsNCj4gKwkJCWNvcmUgPSAic2VjdXJlIjsNCj4gKwkJ
CWxvYWQgPSA8MHg2MDAwMD47DQo+ICsJCQlzdy1yZXYgPSA8Q09ORklHX0szX1g1MDlfU1dSVj47
DQo+ICsJCQlrZXlmaWxlID0gInRpLWRlZ2VuZXJhdGUta2V5LnBlbSI7DQo+ICsJCQl0aWZzc3R1
YjsNCj4gKwkJfTsNCj4gKwkJdGlmc3N0dWJfZ3A6IHRpZnNzdHViLWdwLmJpbiB7DQo+ICsJCQlm
aWxlbmFtZSA9ICJ0aS1zeXNmdy90aS1mcy1zdHViLWZpcm13YXJlLWFtNjJ4LWdwLmJpbiI7DQo+
ICsJCQl0eXBlID0gImJsb2ItZXh0IjsNCj4gKwkJCW9wdGlvbmFsOw0KPiArCQl9Ow0KPiArCX07
DQo+ICsNCj4gwqAJdGktc3BsIHsNCj4gwqAJCWluc2VydC10ZW1wbGF0ZSA9IDwmdGlfc3BsX3Rl
bXBsYXRlPjsNCj4gwqANCj4gwqAJCWZpdCB7DQo+DQoNCldlIGFsc28gbWlnaHQgd2FudCB0byBj
bGVhbi11cCB0aGlzIHNwdXJpb3VzIG5ld2xpbmUgYmVpbmcgYSByZW1uYW50IG9mDQpjb21taXQg
NDUwOWI5ZmYwYjhjICgiYXJtOiBkdHM6IGszLSotYmlubWFuOiBNb3ZlIHRvIHVzaW5nIHRlbXBs
YXRlZCBGSVRzIikuDQoNCj4gwqAJCQlpbWFnZXMgew0KPiArCQkJCXRpZnNzdHViLWhzIHsNCj4g
KwkJCQkJZGVzY3JpcHRpb24gPSAiVElGU1NUVUIiOw0KPiArCQkJCQl0eXBlID0gImZpcm13YXJl
IjsNCj4gKwkJCQkJYXJjaCA9ICJhcm0zMiI7DQo+ICsJCQkJCWNvbXByZXNzaW9uID0gIm5vbmUi
Ow0KPiArCQkJCQlvcyA9ICJ0aWZzc3R1Yi1ocyI7DQo+ICsJCQkJCWxvYWQgPSA8MHg5ZGMwMDAw
MD47DQo+ICsJCQkJCWVudHJ5ID0gPDB4OWRjMDAwMDA+Ow0KPiArCQkJCQlibG9iLWV4dCB7DQo+
ICsJCQkJCQlmaWxlbmFtZSA9ICJ0aWZzc3R1Yi5iaW5faHMiOw0KPiArCQkJCQl9Ow0KPiArCQkJ
CX07DQo+ICsNCj4gKwkJCQl0aWZzc3R1Yi1mcyB7DQo+ICsJCQkJCWRlc2NyaXB0aW9uID0gIlRJ
RlNTVFVCIjsNCj4gKwkJCQkJdHlwZSA9ICJmaXJtd2FyZSI7DQo+ICsJCQkJCWFyY2ggPSAiYXJt
MzIiOw0KPiArCQkJCQljb21wcmVzc2lvbiA9ICJub25lIjsNCj4gKwkJCQkJb3MgPSAidGlmc3N0
dWItZnMiOw0KPiArCQkJCQlsb2FkID0gPDB4OWRjMDAwMDA+Ow0KPiArCQkJCQllbnRyeSA9IDww
eDlkYzAwMDAwPjsNCj4gKwkJCQkJYmxvYi1leHQgew0KPiArCQkJCQkJZmlsZW5hbWUgPSAidGlm
c3N0dWIuYmluX2ZzIjsNCj4gKwkJCQkJfTsNCj4gKwkJCQl9Ow0KPiArDQo+ICsJCQkJdGlmc3N0
dWItZ3Agew0KPiArCQkJCQlkZXNjcmlwdGlvbiA9ICJUSUZTU1RVQiI7DQo+ICsJCQkJCXR5cGUg
PSAiZmlybXdhcmUiOw0KPiArCQkJCQlhcmNoID0gImFybTMyIjsNCj4gKwkJCQkJY29tcHJlc3Np
b24gPSAibm9uZSI7DQo+ICsJCQkJCW9zID0gInRpZnNzdHViLWdwIjsNCj4gKwkJCQkJbG9hZCA9
IDwweDlkYzAwMDAwPjsNCj4gKwkJCQkJZW50cnkgPSA8MHg5ZGMwMDAwMD47DQo+ICsJCQkJCWJs
b2ItZXh0IHsNCj4gKwkJCQkJCWZpbGVuYW1lID0gInRpZnNzdHViLmJpbl9ncCI7DQo+ICsJCQkJ
CX07DQo+ICsJCQkJfTsNCj4gKw0KPiDCoAkJCQlkbSB7DQo+IMKgCQkJCQl0aS1zZWN1cmUgew0K
PiDCoAkJCQkJCWNvbnRlbnQgPSA8JmRtPjsNCj4gQEAgLTE4Nyw3ICsyODIsOCBAQA0KPiDCoAkJ
CQljb25mLTAgew0KPiDCoAkJCQkJZGVzY3JpcHRpb24gPSAiazMtYW02MjUtdmVyZGluLXdpZmkt
ZGV2IjsNCj4gwqAJCQkJCWZpcm13YXJlID0gImF0ZiI7DQo+IC0JCQkJCWxvYWRhYmxlcyA9ICJ0
ZWUiLCAiZG0iLCAic3BsIjsNCj4gKwkJCQkJbG9hZGFibGVzID0gInRlZSIsICJ0aWZzc3R1Yi1o
cyIsICJ0aWZzc3R1Yi1mcyIsDQo+ICsJCQkJCQnCoMKgwqAgInRpZnNzdHViLWdwIiwgImRtIiwg
InNwbCI7DQo+IMKgCQkJCQlmZHQgPSAiZmR0LTAiOw0KPiDCoAkJCQl9Ow0KPiDCoAkJCX07DQo+
IEBAIC0yNDMsNiArMzM5LDQ1IEBADQo+IMKgDQo+IMKgCQlmaXQgew0KPiDCoAkJCWltYWdlcyB7
DQo+ICsJCQkJdGlmc3N0dWItaHMgew0KPiArCQkJCQlkZXNjcmlwdGlvbiA9ICJ0aWZzc3R1YiI7
DQo+ICsJCQkJCXR5cGUgPSAiZmlybXdhcmUiOw0KPiArCQkJCQlhcmNoID0gImFybTMyIjsNCj4g
KwkJCQkJY29tcHJlc3Npb24gPSAibm9uZSI7DQo+ICsJCQkJCW9zID0gInRpZnNzdHViLWhzIjsN
Cj4gKwkJCQkJbG9hZCA9IDwweDlkYzAwMDAwPjsNCj4gKwkJCQkJZW50cnkgPSA8MHg5ZGMwMDAw
MD47DQo+ICsJCQkJCWJsb2ItZXh0IHsNCj4gKwkJCQkJCWZpbGVuYW1lID0gInRpZnNzdHViLmJp
bl9ocyI7DQo+ICsJCQkJCX07DQo+ICsJCQkJfTsNCj4gKw0KPiArCQkJCXRpZnNzdHViLWZzIHsN
Cj4gKwkJCQkJZGVzY3JpcHRpb24gPSAidGlmc3N0dWIiOw0KPiArCQkJCQl0eXBlID0gImZpcm13
YXJlIjsNCj4gKwkJCQkJYXJjaCA9ICJhcm0zMiI7DQo+ICsJCQkJCWNvbXByZXNzaW9uID0gIm5v
bmUiOw0KPiArCQkJCQlvcyA9ICJ0aWZzc3R1Yi1mcyI7DQo+ICsJCQkJCWxvYWQgPSA8MHg5ZGMw
MDAwMD47DQo+ICsJCQkJCWVudHJ5ID0gPDB4OWRjMDAwMDA+Ow0KPiArCQkJCQlibG9iLWV4dCB7
DQo+ICsJCQkJCQlmaWxlbmFtZSA9ICJ0aWZzc3R1Yi5iaW5fZnMiOw0KPiArCQkJCQl9Ow0KPiAr
CQkJCX07DQo+ICsNCj4gKwkJCQl0aWZzc3R1Yi1ncCB7DQo+ICsJCQkJCWRlc2NyaXB0aW9uID0g
InRpZnNzdHViIjsNCj4gKwkJCQkJdHlwZSA9ICJmaXJtd2FyZSI7DQo+ICsJCQkJCWFyY2ggPSAi
YXJtMzIiOw0KPiArCQkJCQljb21wcmVzc2lvbiA9ICJub25lIjsNCj4gKwkJCQkJb3MgPSAidGlm
c3N0dWItZ3AiOw0KPiArCQkJCQlsb2FkID0gPDB4OWRjMDAwMDA+Ow0KPiArCQkJCQllbnRyeSA9
IDwweDlkYzAwMDAwPjsNCj4gKwkJCQkJYmxvYi1leHQgew0KPiArCQkJCQkJZmlsZW5hbWUgPSAi
dGlmc3N0dWIuYmluX2dwIjsNCj4gKwkJCQkJfTsNCj4gKwkJCQl9Ow0KPiArDQo+IMKgCQkJCWRt
IHsNCj4gwqAJCQkJCXRpLWRtIHsNCj4gwqAJCQkJCQlmaWxlbmFtZSA9ICJ0aS1kbS5iaW4iOw0K
PiBAQCAtMjY2LDcgKzQwMSw4IEBADQo+IMKgCQkJCWNvbmYtMCB7DQo+IMKgCQkJCQlkZXNjcmlw
dGlvbiA9ICJrMy1hbTYyNS12ZXJkaW4td2lmaS1kZXYiOw0KPiDCoAkJCQkJZmlybXdhcmUgPSAi
YXRmIjsNCj4gLQkJCQkJbG9hZGFibGVzID0gInRlZSIsICJkbSIsICJzcGwiOw0KPiArCQkJCQls
b2FkYWJsZXMgPSAidGVlIiwgInRpZnNzdHViLWhzIiwgInRpZnNzdHViLWZzIiwNCj4gKwkJCQkJ
CcKgwqDCoCAidGlmc3N0dWItZ3AiLCAiZG0iLCAic3BsIjsNCj4gwqAJCQkJCWZkdCA9ICJmZHQt
MCI7DQo+IMKgCQkJCX07DQo+IMKgCQkJfTsNCg0KQ2hlZXJzDQoNCk1hcmNlbA0K

