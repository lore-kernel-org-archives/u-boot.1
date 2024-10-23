Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E31CF5366
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 12:18:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0371989266;
	Wed, 23 Oct 2024 14:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="rR3Z9hga";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 608A489268; Wed, 23 Oct 2024 14:18:52 +0200 (CEST)
Received: from mx2.securetransport.de (mx2.securetransport.de
 [IPv6:2a03:4000:13:6c7::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F6858925A
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 14:18:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1729685920;
 bh=U2qmkjipLPClSzXLWtuLWeK4MtXuouaGV9Wp/aNAefc=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=rR3Z9hgaGdWTEeHI89CiS/xIP1xUW7UJ+G6gF2UaLiSzx/mnDFBGyQ2Jeiz/w5V7d
 tBhYjH9i9bWB95r0OIdEmkoEWif31lS7DdtwH0S3meOqAcNjr1xDuaxvOXvAZKNg3t
 Tf5qzPzJGDsMaxWO14kSqvzCuc/D58/7xLzEDXBgJBVXAadQAl3q4XVH7yYgp8BwSs
 OFo16bmTSC77gcptC4oBbqRVyjeLZWTn9gHats3x+8nRh76I94vN24S5AcfE5brPSM
 P0lHJdAA62dFEENe+RkluNvYjOd/l3FbHaTyet779doz3cViOzNJKOCU/8up2TPDi6
 I3zbNc0OdtJ5Q==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: NXP i.MX U-Boot Team <uboot-imx@nxp.com>, Fabio Estevam
 <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>, Tom Rini
 <trini@konsulko.com>, u-boot <u-boot@dh-electronics.com>
Subject: RE: [PATCH 2/2] arm64: imx8mp: Read item and serial number from
 EEPROM ID page on DH i.MX8MP DHCOM
Thread-Topic: [PATCH 2/2] arm64: imx8mp: Read item and serial number from
 EEPROM ID page on DH i.MX8MP DHCOM
Thread-Index: AQHbGxfHmD5+3BWcGkWm07IML/aPr7KDeoyAgAXUiUCAAK5vAIAA1rQQgABasgCABjFZgIAAYh8AgADI4vCAABAiAIABs80Q
Date: Wed, 23 Oct 2024 12:18:14 +0000
Message-ID: <bef41c1fefeb422e9e1b8f8f0d241a13@dh-electronics.com>
References: <20241010132337.3259-1-cniedermaier@dh-electronics.com>
 <20241010132337.3259-2-cniedermaier@dh-electronics.com>
 <934d25c2-39d8-4f51-b29e-8f20feb7431f@denx.de>
 <a305b1455a984fca83de5a6c0d4b8dfc@dh-electronics.com>
 <74bd0a6b-fe12-4e2c-af79-c1f8ffb7d484@denx.de>
 <73ccb69b85094e24be2343d5cbc8879a@dh-electronics.com>
 <17b9380b-39c0-40f2-bb28-319d26b2e13c@denx.de>
 <7b9b543d7aad498591fa6a04a3154cf8@dh-electronics.com>
 <a0f70ee2-6d71-4f66-b22e-994df2b28504@denx.de>
 <d06620ee891f4e419bfeb8fe657ba729@dh-electronics.com>
 <009179c8-5512-4ba6-beeb-2d508dd5abd8@denx.de>
In-Reply-To: <009179c8-5512-4ba6-beeb-2d508dd5abd8@denx.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
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

RnJvbTogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQpTZW50OiBUdWVzZGF5LCBPY3RvYmVy
IDIyLCAyMDI0IDE6NTcgUE0NCj4gT24gMTAvMjIvMjQgMTE6MzEgQU0sIENocmlzdG9waCBOaWVk
ZXJtYWllciB3cm90ZToNCj4+IEZyb206IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPg0KPj4g
U2VudDogVHVlc2RheSwgT2N0b2JlciAyMiwgMjAyNCAxOjAxIEFNDQo+Pj4gT24gMTAvMjEvMjQg
NTozOCBQTSwgQ2hyaXN0b3BoIE5pZWRlcm1haWVyIHdyb3RlOg0KPj4+DQo+Pj4gWy4uLl0NCj4+
Pg0KPj4+Pj4gSWYgeWVzLCB0aGVuIHRoZXJlIGlzIG5vIG5lZWQgZm9yIGFueSBzdGF0aWMgdmFy
aWFibGU6DQo+Pj4+Pg0KPj4+Pj4gYm9hcmRfaW5pdCgpIHsNCj4+Pj4+ICAgICB1OCBlZXByb21b
MzJdOw0KPj4+Pj4gICAgIGRoX3JlYWRfZWVwcm9tX3dscChlZXByb20pOyAvLyByZWFkIHRoZSBl
ZXByb20gb25jZQ0KPj4+Pj4gICAgIGRoX3NldHVwX21hY19hZGRyZXNzKGVlcHJvbSk7IC8vIGV4
dHJhY3QgTUFDIGZyb20gRUVQUk9NDQo+Pj4+PiAgICAgZGhfYWRkX2l0ZW1fbnVtYmVyX2FuZF9z
ZXJpYWxfdG9fZW52KGVlcHJvbSk7IC8vIGV4dHJhY3QgU04gZnJvbSBFRVBST00NCj4+Pj4+ICAg
ICAvLyBvbmNlIHRoaXMgZnVuY3Rpb24gZXhpdHMsIHRoZSBlZXByb20gdmFyaWFibGUgb24gc3Rh
Y2sgaXMgZGlzY2FyZGVkDQo+Pj4+PiAgICAgLy8gd2hpY2ggaXMgT0ssIHNpbmNlIGl0IHdvbid0
IGJlIHVzZWQgYW55bW9yZSBhbnl3YXkNCj4+Pj4+IH0NCj4+Pj4NCj4+Pj4gVGhlIGlkZWEgaXMg
dGhhdCBmdW5jdGlvbiBkaF9hZGRfaXRlbV9udW1iZXJfYW5kX3NlcmlhbF90b19lbnYoKSBlbmNh
cHN1bGF0ZXMNCj4+Pj4gdGhlIHJlYWRpbmcuDQo+Pj4NCj4+PiBUaGUgZnVuY3Rpb24gd2hpY2gg
aW50ZXJhY3RzIHdpdGggdGhlIEVFUFJPTSBvbiBzdGFydCB1cCwgb25jZSwgY2FuIGhhdmUNCj4+
PiB0aGlzIG5hbWUsIHN1cmUuDQo+Pg0KPj4gU29ycnksIEkgbWVhbiB0aGUgZnVuY3Rpb24gZGhf
Z2V0X3ZhbHVlX2Zyb21fZWVwcm9tX2lkX3BhZ2UoKSBoZXJlLg0KPiANCj4gVGhlIGZ1bmN0aW9u
IG5hbWUgZG9lc24ndCByZWFsbHkgbWF0dGVyLCBwbGVhc2UgcGljayBhIGZpdHRpbmcgb25lLg0K
DQpJdCdzIG5vdCBhYm91dCB0aGUgZnVuY3Rpb24gbmFtZS4gSSBoYXZlIHJlZmVyZW5jZWQgdGhl
IHdyb25nIGZ1bmN0aW9uLg0KDQo+Pj4+IEkgZG9uJ3Qgd2FudCB0byBoYXZlIHRvIHdvcnJ5IGFi
b3V0IHRoZSBzdHJ1Y3R1cmUgYW5kIG51bWJlciBvZg0KPj4+PiBieXRlcyBvZiB0aGUgRUVQUk9N
IElEIHBhZ2UgYW5kIHdhbnQgdG8gYmUgaW5kZXBlbmRlbnQgb2YgaXQuIEl0IGlzIHBsYW5uZWQg
dG8NCj4+Pj4gZXh0ZW5kIHRoZSBzdHJ1Y3R1cmUgYW5kIGluY3JlYXNlIHRoZSBudW1iZXIgb2Yg
Ynl0ZXMgZm9yIHRoZSBTVE0zMk1QMi4gVGhlDQo+Pj4+IGNoYW5nZXMgdG8gdGhlIHNpemUgd2ls
bCB0aGVuIGRlcGVuZCBvbiB0aGUgdmVyc2lvbiBvZiB0aGUgZGF0YSBpbiB0aGUgaGVhZGVyDQo+
Pj4+IHdpdGhpbiB0aGUgc3RydWN0dXJlLg0KPj4+DQo+Pj4gSXQgaXMgT0sgdG8gYWxsb2NhdGUg
MzIgb3IgNjQgYnl0ZXMgb24gc3RhY2ssIHNpbmNlIHRoYXQgY2h1bmsgb2YgbWVtb3J5DQo+Pj4g
aXMgZnJlZSdkIG9uIHJldHVybiBmcm9tIHRoZSBmdW5jdGlvbi4gVGhlIGxpZmVzcGFuIG9mIHRo
YXQgYWxsb2NhdGVkDQo+Pj4gbWVtb3J5IGlzIGV4YWN0bHkgYXMgbG9uZyBhcyBpdCBzaG91bGQg
YmUsIGFuZCBpdCBkb2VzIG5vdCB3YXN0ZSBVLUJvb3QNCj4+PiBtZW1vcnkgdW5uZWNlc3Nhcmls
eS4NCj4+Pg0KPj4+IFNvIGZhciwgYWxsIGtub3duIEVFUFJPTXMgaGF2ZSBXTFAgc2l6ZSBvZiAz
MiBvciA2NCBCeWVzLg0KPj4+DQo+Pj4+IEhvd2V2ZXIsIHRoZXNlIGNoYW5nZXMgc2hvdWxkIHRo
ZW4gb25seSBoYXZlIHRvIGJlIG1hZGUNCj4+Pj4gd2l0aGluIHRoZSBmdW5jdGlvbiBkaF9hZGRf
aXRlbV9udW1iZXJfYW5kX3NlcmlhbF90b19lbnYoKSBmb3IgcmVhZGluZyB0aGUNCj4+Pj4gRUVQ
Uk9NIElEIHBhZ2UuIEkgYWNjZXB0IHRoZSBzdGF0aWMgdmFyaWFibGUgaW4gb3JkZXIgdG8gYmV0
dGVyIGlzb2xhdGUgdGhlDQo+Pj4+IGZ1bmN0aW9uLg0KPj4NCj4+IFNvcnJ5LCBoZXJlIEkgbWVh
biBhbHNvIHRoZSBmdW5jdGlvbiBkaF9nZXRfdmFsdWVfZnJvbV9lZXByb21faWRfcGFnZSgpLg0K
Pj4NCj4+PiBUaGlzIGNhbiB2ZXJ5IHdlbGwgYmU6DQo+Pj4NCj4+PiBkaF9hZGRfaXRlbV9udW1i
ZXJfYW5kX3NlcmlhbF90b19lbnYoKSB7DQo+Pj4gICAgICB1OCBlZXByb21bMzJdOw0KPj4+ICAg
ICAgZGhfcmVhZF9lZXByb21fd2xwKGVlcHJvbSk7IC8vIHJlYWQgdGhlIGVlcHJvbSBvbmNlDQo+
Pj4gICAgICBkaF9zZXR1cF9tYWNfYWRkcmVzcyhlZXByb20pOyAvLyBleHRyYWN0IE1BQyBmcm9t
IEVFUFJPTQ0KPj4+ICAgICAgZGhfYWRkX2l0ZW1fbnVtYmVyX2FuZF9zZXJpYWxfdG9fZW52KGVl
cHJvbSk7IC8vIGV4dHJhY3QgU04gZnJvbSBFRVBST00NCj4+PiAgICAgIC8vIG9uY2UgdGhpcyBm
dW5jdGlvbiBleGl0cywgdGhlIGVlcHJvbSB2YXJpYWJsZSBvbiBzdGFjayBpcyBkaXNjYXJkZWQN
Cj4+PiAgICAgIC8vIHdoaWNoIGlzIE9LLCBzaW5jZSBpdCB3b24ndCBiZSB1c2VkIGFueW1vcmUg
YW55d2F5DQo+Pj4gfQ0KPj4+DQo+Pj4gYm9hcmRfaW5pdCgpIHsNCj4+PiAgICAgLi4NCj4+PiAg
ICAgZGhfYWRkX2l0ZW1fbnVtYmVyX2FuZF9zZXJpYWxfdG9fZW52KCk7DQo+Pj4gICAgIC4uLg0K
Pj4+IH0NCj4+Pg0KPj4+PiBTaW5jZSB0aGUgbWVtb3J5IGlzIGZyZWVkIHVwIGFnYWluIHdoZW4g
dGhlIG9wZXJhdGluZyBzeXN0ZW0gYm9vdHMsDQo+Pj4+IHRoaXMgY29uc3VtcHRpb24gb2YgMzIg
Ynl0ZXMgaW4gVS1Cb290IGlzIG5vdCBhIHByb2JsZW0sIGJlY2F1c2UgaXQgaXMgb25seQ0KPj4+
PiB0ZW1wb3JhcnkuDQo+Pj4gVGhpcyBpcyBub3QgZ29vZCwgcGxlYXNlIGRvIG5vdCB3YXN0ZSBt
ZW1vcnkgaW4gVS1Cb290IGlmIGl0IGNhbiBiZQ0KPj4+IGVhc2lseSBhdm9pZGVkIGJ5IGF1dG9t
YXRpY2FsbHkgYWxsb2NhdGluZyBpdCBvbiBzdGFjayBhbmQgZnJlZWluZyBpdA0KPj4+IHdoZW4g
bm90IG5lZWRlZC4NCj4+Pg0KPj4+IFsuLi5dDQo+Pg0KPj4gSSBkb24ndCB3YW50IHRvIGFsbG9j
YXRlIHRoZSBtZW1vcnkgaW4gdGhlIGZ1bmN0aW9uIGJvYXJkX2luaXQoKS4NCj4gDQo+IFlvdSBk
byBub3QsIHRoZSBmb2xsb3dpbmcgYXV0b21hdGljYWxseSByZXNlcnZlcyBzcGFjZSBvbiBzdGFj
ayB3aGVuDQo+IGNhbGxlZCBhbmQgZnJlZXMgaXQgdXAgdXBvbiBmdW5jdGlvbiByZXR1cm46DQo+
IA0KPiBmdW5jdGlvbiBmb28oKSB7DQo+ICAgIHU4IGFycmF5WzEyXTsNCj4gICAgLi4uDQo+ICAg
IHN0dWZmKGFycmF5KTsNCj4gICAgLi4uDQo+IH0NCg0KU29ycnksIEkgZXhwcmVzc2VkIG15c2Vs
ZiBpbmNvcnJlY3RseSBoZXJlLiBPZiBjb3Vyc2UgSSBtZWFudCB0aGF0DQpJIGRvbid0IHdhbnQg
dG8gcmVzZXJ2ZSBtZW1vcnkgb24gdGhlIHN0YWNrIGZvciB0aGUgRUVQUk9NIElEIHBhZ2UNCmlu
IHRoZSBib2FyZF9pbml0KCkgZnVuY3Rpb24uDQoNCj4+IEkgd2FudCB0byBoYW5kbGUNCj4+IHNp
emUgYW5kIGNhY2hpbmcgaW4gdGhlIGZ1bmN0aW9uIGRoX2dldF92YWx1ZV9mcm9tX2VlcHJvbV9p
ZF9wYWdlKCkuIFNvIEkgZG9uJ3QNCj4+IHdhbnQgdG8gZGVhbCB3aXRoIHNpemUgYW5kIHN0cnVj
dHVyZSBpbiB0aGUgZnVuY3Rpb24gYm9hcmRfaW5pdCgpLiBGb3IgbWUsIHRoZSB1c2UNCj4+IG9m
IGEgc3RhdGljIHZhcmlhYmxlIGlzIE9LLCBidXQgeW91IGRvbid0IGxpa2UgaXQuIERvIHlvdSBr
bm93IGhvdyBJIGNhbiBkbyB0aGlzDQo+PiB3aXRob3V0IGFzc2lnbmluZyBhIHN0YXRpYyB2YXJp
YWJsZSwgYnV0IG5vdCBhbGxvY2F0ZSB0aGUgbWVtb3J5IHNvbWV3aGVyZSBpbiBhDQo+PiBjYWxs
ZXIgZnVuY3Rpb24/DQo+IEV2ZW4gdGhlIHN0YXRpYyB2YXJpYWJsZSBzcGFjZSBpcyBhbGxvY2F0
ZWQgc29tZXdoZXJlLCBlaXRoZXIgaW4gLmJzcyBvcg0KPiAuZGF0YSBzZWN0aW9uLCBleGNlcHQg
d2l0aCBzdGF0aWMgdmFyaWFibGUocykgdGhlIG1lbW9yeSBwZXJzaXN0cw0KPiB0aHJvdWdob3V0
IHRoZSBsaWZldGltZSBvZiBVLUJvb3QgYmVjYXVzZSB0aGVpciBjb250ZW50IGhhcyB0byBiZQ0K
PiByZXRhaW5lZCBldmVuIHdoZW4gdGhlIGZ1bmN0aW9uIHVzaW5nIHRoZWlyIGNvbnRlbnQgcmV0
dXJucy4NCj4gDQo+IFdpdGggdmFyaWFibGUocykgYWxsb2NhdGVkIG9uIHN0YWNrICh3aGljaCBp
cyBtYWpvcml0eSBvZiB2YXJpYWJsZSksIHRoZQ0KPiBtZW1vcnkgYWxsb2NhdGlvbiBoYXBwZW5z
IG9uIGVudHJ5IHRvIHRoZSBmdW5jdGlvbiBhbmQgdGhlIG1lbW9yeSBpcw0KPiBhdXRvbWF0aWNh
bGx5IGZyZWVkIG9uIGV4aXQgZnJvbSB0aGUgZnVuY3Rpb24uDQo+IA0KPiBJdCBpcyBwZXJmZWN0
bHkgZmluZSB0byBjYWxsIHNvbWUgd3JhcHBlciBzdXBlcmZ1bmN0aW9uIGZyb20NCj4gYm9hcmRf
aW5pdCgpIHdoaWNoIGhvbGRzIHRoZSBhcnJheSBvbiBzdGFjayBhbmQgY2FsbHMgYWxsIHRoZSBF
RVBST00NCj4gcGFyc2VyL2hhbmRsZXIgZnVuY3Rpb25zOg0KPiANCj4gZWVwcm9tX3N1cGVyd3Jh
cHBlcigpIHsNCj4gICAgdTggZWVwcm9tWzY0XTsNCj4gICAgLi4uDQo+ICAgIGVlcHJvbV9kb19z
dHVmZjEoZWVwcm9tKTsNCj4gICAgZWVwcm9tX2RvX3N0dWZmMihlZXByb20pOw0KPiAgICAuLi4N
Cj4gfQ0KPiANCj4gYm9hcmRfaW5pdCgpIHsNCj4gICAgLi4uDQo+ICAgIGVlcHJvbV9zdXBlcndy
YXBwZXIoKTsNCj4gICAgLi4uDQo+IH0NCg0KVGhhdCdzIG5vdCB3aGF0IEknbSBsb29raW5nIGZv
ci4gRG8geW91IGhhdmUgYW5vdGhlciBzb2x1dGlvbj8NCg0KUmVnYXJkcw0KQ2hyaXN0b3BoDQo=
