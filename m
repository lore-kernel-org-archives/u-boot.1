Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282C3CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 07:17:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EBB786BEB;
	Wed, 18 Oct 2023 09:17:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46AEC86D82; Wed, 18 Oct 2023 09:17:26 +0200 (CEST)
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
 by phobos.denx.de (Postfix) with ESMTP id F310F86A3C
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 09:17:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kuanlim.lee@starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
 by ex01.ufhost.com (Postfix) with ESMTP id 154CA24E15D;
 Wed, 18 Oct 2023 15:17:20 +0800 (CST)
Received: from EXMBX067.cuchost.com (172.16.6.67) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 18 Oct
 2023 15:17:20 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX067.cuchost.com
 (172.16.6.67) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 18 Oct
 2023 15:17:19 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Wed, 18 Oct 2023 15:17:19 +0800
From: KuanLim.Lee <kuanlim.lee@starfivetech.com>
To: Sean Anderson <seanga2@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Cheehong Ang <cheehong.ang@starfivetech.com>, WeiLiang Lim
 <weiliang.lim@starfivetech.com>
Subject: RE: [PATCH] spl: mmc: Resolve emmc not load image after switched hw
 partition
Thread-Topic: [PATCH] spl: mmc: Resolve emmc not load image after switched hw
 partition
Thread-Index: AQHZ9bCNy1u6JRMnxUuVKA8o7Cp387BOlhCAgACMjeCAABZ2QA==
Date: Wed, 18 Oct 2023 07:17:19 +0000
Message-ID: <70a168dc02544085bebf7a9b958e3e37@EXMBX066.cuchost.com>
References: <20231003041720.893-1-kuanlim.lee@starfivetech.com>
 <cf37d9b4-e896-5109-ae03-b8ddfbf8d913@gmail.com>
 <c5bdd703f65c4bb6b627a299678573db@EXMBX066.cuchost.com>
In-Reply-To: <c5bdd703f65c4bb6b627a299678573db@EXMBX066.cuchost.com>
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

SGkgQW5kZXJzb24sDQoNClRoYW5rcyBmb3IgeW91ciBmZWVkYmFjay4gDQpQbGVhc2UgaWdub3Jl
IHRoaXMgcGF0Y2guDQoNCkJlc3QgUmVnYXJkcywNCkt1YW5MaW0NCg0KT24gMTAvMy8yMyAxNDoy
MSwgS3VhbiBMaW0gTGVlIHdyb3RlOg0KPiBPbiAxMC8xOC8yMyAxMzoyNywgU2VhbiBBbmRlcnNv
biB3cm90ZToNCj4gPiBPbiAxMC8zLzIzIDAwOjE2LCBLdWFuIExpbSBMZWUgd3JvdGU6DQo+ID4g
PiBXaGVuIHNlbGVjdGluZyBNTUNTRF9NT0RFX0VNTUNCT09UIGFzIGJvb3RfbW9kZSwgZW1tYyBk
byBub3QNCj4gPiBsb2FkDQo+ID4gPiBVLWJvb3QgcHJvcGVyIGltYWdlIGFmdGVyIHN3aXRjaGVk
IGhhcmR3YXJlIHBhcnRpdGlvbi4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBLdWFuIExp
bSBMZWUgPGt1YW5saW0ubGVlQHN0YXJmaXZldGVjaC5jb20+DQo+ID4gPiBSZXZpZXdlZC1ieTog
Q2hlZSBIb25nIEFuZyA8Y2hlZWhvbmcuYW5nQHN0YXJmaXZldGVjaC5jb20+DQo+ID4gPiBSZXZp
ZXdlZC1ieTogV2VpIExpYW5nIExpbSA8d2VpbGlhbmcubGltQHN0YXJmaXZldGVjaC5jb20+DQo+
ID4gPiAtLS0NCj4gPiA+ICAgY29tbW9uL3NwbC9zcGxfbW1jLmMgfCAzICsrKw0KPiA+ID4gICAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBh
L2NvbW1vbi9zcGwvc3BsX21tYy5jIGIvY29tbW9uL3NwbC9zcGxfbW1jLmMgaW5kZXgNCj4gPiA+
IDIwZjY4N2UxMzguLmRjOGE0NTIyMmIgMTAwNjQ0DQo+ID4gPiAtLS0gYS9jb21tb24vc3BsL3Nw
bF9tbWMuYw0KPiA+ID4gKysrIGIvY29tbW9uL3NwbC9zcGxfbW1jLmMNCj4gPiA+IEBAIC00NDcs
NiArNDQ3LDkgQEAgaW50IHNwbF9tbWNfbG9hZChzdHJ1Y3Qgc3BsX2ltYWdlX2luZm8NCj4gKnNw
bF9pbWFnZSwNCj4gPiA+ICAgI2VuZGlmDQo+ID4gPiAgIAkJCXJldHVybiBlcnI7DQo+ID4gPiAg
IAkJfQ0KPiA+ID4gKwkJZXJyID0gbW1jX2xvYWRfaW1hZ2VfcmF3X3NlY3RvcihzcGxfaW1hZ2Us
IGJvb3RkZXYsIG1tYywNCj4gPiAwKTsNCj4gPiA+ICsJCWlmICghZXJyKQ0KPiA+ID4gKwkJCXJl
dHVybiBlcnI7DQo+ID4gPiAgIAkJLyogRmFsbCB0aHJvdWdoICovDQo+ID4gPiAgIAljYXNlIE1N
Q1NEX01PREVfUkFXOg0KPiA+ID4gICAJCWRlYnVnKCJzcGw6IG1tYyBib290IG1vZGU6IHJhd1xu
Iik7DQo+ID4NCj4gPiBTbyB3aHkgZG9lc24ndCB0aGUgbW1jX2xvYWRfaW1hZ2VfcmF3X3NlY3Rv
ciBiZWxvdyAobGluZSA0NzUgb3Igc28pDQo+IHdvcms/DQo+IGJvb3RfbW9kZSB0aGF0ICBJIGNo
b29zZSBpcyBNTUNTRF9NT0RFX0VNTUNCT09ULiBUaGlzIGlzIGEgc3dpdGNoIGNhc2UNCj4gbWV0
aG9kLg0KPiBJZiB0aGUgY2FzZSBmaW5pc2hlZCBleGVjdXRpb24sIHByb2dyYW0gd2lsbCBqdW1w
IHRvICdyZXR1cm4gZXJyb3I7JyBpbiBsaW5lIDQ5Mi4NCj4gU2luY2UgdGhlcmUgYXJlIG5vIGxv
YWQgaW1hZ2UgZnVuY3Rpb24sIGluIGJvb3RfbW9kZToNCj4gTU1DU0RfTU9ERV9FTU1DQk9PVCwg
aXQgd2lsbCBqdXN0IHN3aXRjaCB0aGUgaHdwYXJ0aXRpb24gYW5kIHF1aXQgdGhlDQo+IHByb2Nl
c3MgJiBmYWlsIHRvIGJvb3QuDQo+IA0KPiAJY2FzZSBNTUNTRF9NT0RFX0VNTUNCT09UOg0KPiAq
KiogIGhlcmUgaXMgdGhlIGNhc2UgSSBhZGQgbW1jX2xvYWRfaW1hZ2VfcmF3X3NlY3RvcigpDQo+
IC8qIEZhbGwgdGhyb3VnaCAqLw0KPiAJY2FzZSBNTUNTRF9NT0RFX1JBVzoNCj4gKioqICBoZXJl
IGlzIHRoZSBjYXNlIHdoaWNoIGV4ZWN1dGUgbW1jX2xvYWRfaW1hZ2VfcmF3X3NlY3RvcigpIGlu
IGxpbmUgNDcwLg0KPiA+DQo+ID4gLS1TZWFuDQo+IFBsZWFzZSBjb3JyZWN0IG1lIGlmIEkgYW0g
d3JvbmcuDQo+IC0tS3VhbkxpbQ0K
