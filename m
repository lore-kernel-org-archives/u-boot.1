Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8A0CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 06:21:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC55D86D82;
	Wed, 18 Oct 2023 08:21:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C5CA86D2E; Wed, 18 Oct 2023 08:21:09 +0200 (CEST)
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com
 [61.152.239.71]) by phobos.denx.de (Postfix) with ESMTP id 1BB5D86BB4
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 08:21:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kuanlim.lee@starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
 by fd01.gateway.ufhost.com (Postfix) with ESMTP id E54427FE0;
 Wed, 18 Oct 2023 14:20:55 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 18 Oct
 2023 14:20:55 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 18 Oct
 2023 14:20:55 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Wed, 18 Oct 2023 14:20:55 +0800
From: KuanLim.Lee <kuanlim.lee@starfivetech.com>
To: Sean Anderson <seanga2@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Cheehong Ang <cheehong.ang@starfivetech.com>, WeiLiang Lim
 <weiliang.lim@starfivetech.com>
Subject: RE: [PATCH] spl: mmc: Resolve emmc not load image after switched hw
 partition
Thread-Topic: [PATCH] spl: mmc: Resolve emmc not load image after switched hw
 partition
Thread-Index: AQHZ9bCNy1u6JRMnxUuVKA8o7Cp387BOlhCAgACMjeA=
Date: Wed, 18 Oct 2023 06:20:55 +0000
Message-ID: <c5bdd703f65c4bb6b627a299678573db@EXMBX066.cuchost.com>
References: <20231003041720.893-1-kuanlim.lee@starfivetech.com>
 <cf37d9b4-e896-5109-ae03-b8ddfbf8d913@gmail.com>
In-Reply-To: <cf37d9b4-e896-5109-ae03-b8ddfbf8d913@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [202.188.176.82]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
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

T24gMTAvMTgvMjMgMTM6MjcsIFNlYW4gQW5kZXJzb24gd3JvdGU6DQo+IE9uIDEwLzMvMjMgMDA6
MTYsIEt1YW4gTGltIExlZSB3cm90ZToNCj4gPiBXaGVuIHNlbGVjdGluZyBNTUNTRF9NT0RFX0VN
TUNCT09UIGFzIGJvb3RfbW9kZSwgZW1tYyBkbyBub3QNCj4gbG9hZA0KPiA+IFUtYm9vdCBwcm9w
ZXIgaW1hZ2UgYWZ0ZXIgc3dpdGNoZWQgaGFyZHdhcmUgcGFydGl0aW9uLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogS3VhbiBMaW0gTGVlIDxrdWFubGltLmxlZUBzdGFyZml2ZXRlY2guY29tPg0K
PiA+IFJldmlld2VkLWJ5OiBDaGVlIEhvbmcgQW5nIDxjaGVlaG9uZy5hbmdAc3RhcmZpdmV0ZWNo
LmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogV2VpIExpYW5nIExpbSA8d2VpbGlhbmcubGltQHN0YXJm
aXZldGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gICBjb21tb24vc3BsL3NwbF9tbWMuYyB8IDMgKysr
DQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvY29tbW9uL3NwbC9zcGxfbW1jLmMgYi9jb21tb24vc3BsL3NwbF9tbWMuYyBpbmRleA0K
PiA+IDIwZjY4N2UxMzguLmRjOGE0NTIyMmIgMTAwNjQ0DQo+ID4gLS0tIGEvY29tbW9uL3NwbC9z
cGxfbW1jLmMNCj4gPiArKysgYi9jb21tb24vc3BsL3NwbF9tbWMuYw0KPiA+IEBAIC00NDcsNiAr
NDQ3LDkgQEAgaW50IHNwbF9tbWNfbG9hZChzdHJ1Y3Qgc3BsX2ltYWdlX2luZm8gKnNwbF9pbWFn
ZSwNCj4gPiAgICNlbmRpZg0KPiA+ICAgCQkJcmV0dXJuIGVycjsNCj4gPiAgIAkJfQ0KPiA+ICsJ
CWVyciA9IG1tY19sb2FkX2ltYWdlX3Jhd19zZWN0b3Ioc3BsX2ltYWdlLCBib290ZGV2LCBtbWMs
DQo+IDApOw0KPiA+ICsJCWlmICghZXJyKQ0KPiA+ICsJCQlyZXR1cm4gZXJyOw0KPiA+ICAgCQkv
KiBGYWxsIHRocm91Z2ggKi8NCj4gPiAgIAljYXNlIE1NQ1NEX01PREVfUkFXOg0KPiA+ICAgCQlk
ZWJ1Zygic3BsOiBtbWMgYm9vdCBtb2RlOiByYXdcbiIpOw0KPiANCj4gU28gd2h5IGRvZXNuJ3Qg
dGhlIG1tY19sb2FkX2ltYWdlX3Jhd19zZWN0b3IgYmVsb3cgKGxpbmUgNDc1IG9yIHNvKSB3b3Jr
Pw0KYm9vdF9tb2RlIHRoYXQgIEkgY2hvb3NlIGlzIE1NQ1NEX01PREVfRU1NQ0JPT1QuIFRoaXMg
aXMgYSBzd2l0Y2ggY2FzZSBtZXRob2QuIA0KSWYgdGhlIGNhc2UgZmluaXNoZWQgZXhlY3V0aW9u
LCBwcm9ncmFtIHdpbGwganVtcCB0byAncmV0dXJuIGVycm9yOycgaW4gbGluZSA0OTIuDQpTaW5j
ZSB0aGVyZSBhcmUgbm8gbG9hZCBpbWFnZSBmdW5jdGlvbiwgaW4gYm9vdF9tb2RlOiBNTUNTRF9N
T0RFX0VNTUNCT09ULCBpdCANCndpbGwganVzdCBzd2l0Y2ggdGhlIGh3cGFydGl0aW9uIGFuZCBx
dWl0IHRoZSBwcm9jZXNzICYgZmFpbCB0byBib290Lg0KDQoJY2FzZSBNTUNTRF9NT0RFX0VNTUNC
T09UOg0KKioqICBoZXJlIGlzIHRoZSBjYXNlIEkgYWRkIG1tY19sb2FkX2ltYWdlX3Jhd19zZWN0
b3IoKQ0KLyogRmFsbCB0aHJvdWdoICovDQoJY2FzZSBNTUNTRF9NT0RFX1JBVzogDQoqKiogIGhl
cmUgaXMgdGhlIGNhc2Ugd2hpY2ggZXhlY3V0ZSBtbWNfbG9hZF9pbWFnZV9yYXdfc2VjdG9yKCkg
aW4gbGluZSA0NzAuDQo+IA0KPiAtLVNlYW4NClBsZWFzZSBjb3JyZWN0IG1lIGlmIEkgYW0gd3Jv
bmcuDQotLUt1YW5MaW0NCg==
