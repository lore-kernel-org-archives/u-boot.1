Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53190D2F7CE
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 11:55:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 988AD88C60;
	Thu, 17 Oct 2024 13:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="tpFRuyEB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D976C88E5C; Thu, 17 Oct 2024 13:55:56 +0200 (CEST)
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0FD688B16
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 13:55:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1729166145;
 bh=ZevuNtEiJEmgh4K+7+Tw7iq5BkTzxYVljvmt55Dw7oA=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=tpFRuyEBaRnPlEAtp4mJ3xR4O6+Pui+358hyDwnncU97wwHrznvgk9jCqa4+d3U5F
 w1pz6AOliGQXeUAd0BYVhlA6iqh61rHiSvr4GUqcYrHabSqygbq4RQLTUp4sAayFno
 woUsYPpV2y9GbS7ou6Qa+noUe26ueO+R+z45Rh4j/YryLbIndGpE6spYCymOqwjGep
 QwpQ4hVx+T/7MHnpZ+Y9AcwIUvgbCjZOIoYLVN1TLoMQMvXkP683D2XUM9vg18YwUH
 n8UYMQ2vyvg5iyirDNtuY2c8i2pePzuUl+/OItGCfHVKMtxAHTHPrd0TheQ4AtjSW4
 tf+Khsw8ZRSRA==
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
Thread-Index: AQHbGxfHmD5+3BWcGkWm07IML/aPr7KDeoyAgAXUiUCAAK5vAIAA1rQQ
Date: Thu, 17 Oct 2024 11:55:43 +0000
Message-ID: <73ccb69b85094e24be2343d5cbc8879a@dh-electronics.com>
References: <20241010132337.3259-1-cniedermaier@dh-electronics.com>
 <20241010132337.3259-2-cniedermaier@dh-electronics.com>
 <934d25c2-39d8-4f51-b29e-8f20feb7431f@denx.de>
 <a305b1455a984fca83de5a6c0d4b8dfc@dh-electronics.com>
 <74bd0a6b-fe12-4e2c-af79-c1f8ffb7d484@denx.de>
In-Reply-To: <74bd0a6b-fe12-4e2c-af79-c1f8ffb7d484@denx.de>
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

RnJvbTogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQpTZW50OiBUaHVyc2RheSwgT2N0b2Jl
ciAxNywgMjAyNCAyOjIyIEFNDQo+IE9uIDEwLzE2LzI0IDI6MzEgUE0sIENocmlzdG9waCBOaWVk
ZXJtYWllciB3cm90ZToNCj4gDQo+IFsuLi5dDQo+IA0KPj4+PiBkaWZmIC0tZ2l0IGEvYm9hcmQv
ZGhlbGVjdHJvbmljcy9jb21tb24vZGhfY29tbW9uLmggYi9ib2FyZC9kaGVsZWN0cm9uaWNzL2Nv
bW1vbi9kaF9jb21tb24uaA0KPj4+PiBpbmRleCA0YzIyZWNlNDM1Li4xYmFhNDVlMzQwIDEwMDY0
NA0KPj4+PiAtLS0gYS9ib2FyZC9kaGVsZWN0cm9uaWNzL2NvbW1vbi9kaF9jb21tb24uaA0KPj4+
PiArKysgYi9ib2FyZC9kaGVsZWN0cm9uaWNzL2NvbW1vbi9kaF9jb21tb24uaA0KPj4+PiBAQCAt
Niw2ICs2LDggQEANCj4+Pj4gICAgZW51bSBlaXBfcmVxdWVzdF92YWx1ZXMgew0KPj4+PiAgICAg
ICAgTUFDMCwNCj4+Pj4gICAgICAgIE1BQzEsDQo+Pj4+ICsgICAgIElURU1fTlVNQkVSLA0KPj4+
PiArICAgICBTTiwNCj4+Pg0KPj4+IFdoeSBpcyB0aGlzIHBhdGNoIG5vdCBzcXVhc2hlZCBpbnRv
IDEvMiA/IEl0IHNlZW1zIHRvIGJlIGNoYW5naW5nIHRoZQ0KPj4+IHNhbWUgY29kZS4NCj4+DQo+
PiBUaGUgZmlyc3QgcGF0Y2ggYWRkIHRoZSByZWFkaW5nIGZvciBNQUMgYWRkcmVzcyBmcm9tIHRo
ZSBFRVBST00gSUQNCj4+IHBhZ2UgYW5kIGFkZCB0aGUgdXNlIG9mIHRoYXQgYWRkcmVzc2VzLiBU
aGUgc2Vjb25kIGV4dGVuZHMgdGhlIHJlYWRpbmcNCj4+IHRvIHRoZSBzZXJpYWwgbnVtYmVyIGFu
ZCB0aGUgaXRlbSBudW1iZXIuIFNvIHRoYXQgdGhlIHBhdGNoIGRvZXNuJ3QNCj4+IGdldCB0b28g
YmlnIEkgZm91bmQgaXQgdXNlZnVsIHRvIHNwbGl0IGl0IGludG8gdHdvLiBEbyB5b3Ugd2FudCBt
ZSB0bw0KPj4gbWFrZSBvbmUgcGF0Y2ggb3V0IG9mIGl0Pw0KPiANCj4gWWVzIHBsZWFzZS4gT25j
ZSB5b3UgY2FjaGUgdGhlIEVFUFJPTSBjb250ZW50LCB0aGUgcGF0Y2ggd291bGQgbGlrZWx5DQo+
IGdldCBzaW1wbGVyIGFueXdheS4NCg0KV2lsbCBiZSBkb25lIGluIHYyLg0KDQo+IA0KPiBbLi4u
XQ0KPiANCj4+Pj4gKyAgICAgcmV0ID0gZGhfZ2V0X3ZhbHVlX2Zyb21fZWVwcm9tX2lkX3BhZ2Uo
SVRFTV9OVU1CRVIsIGl0ZW1fbnVtYmVyLCBzaXplb2YoaXRlbV9udW1iZXIpLA0KPj4+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiZWVwcm9tMCIpOw0KPj4+
PiArICAgICBpZiAocmV0KSB7DQo+Pj4+ICsgICAgICAgICAgICAgLyoNCj4+Pj4gKyAgICAgICAg
ICAgICAgKiBUaGUgZnVuY3Rpb24gb25seSByZXR1cm5zIHRoZSB2YWx1ZSAtRU5PRU5UIGZvciBT
b00gcmV2LjEwMCwgYmVjYXVzZQ0KPj4+PiArICAgICAgICAgICAgICAqIHRoZSBFRVBST00gSUQg
cGFnZSBpc24ndCBhdmFpbGFibGUgdGhlcmUuIFRoZXJlZm9yZSB0aGUgb3V0cHV0IG1ha2VzDQo+
Pj4+ICsgICAgICAgICAgICAgICogbm8gc2Vuc2UgYW5kIHdpbGwgYmUgc3VwcHJlc3NlZCBoZXJl
Lg0KPj4+PiArICAgICAgICAgICAgICAqLw0KPj4+PiArICAgICAgICAgICAgIGlmIChyZXQgIT0g
LUVOT0VOVCkNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgIHByaW50ZigiJXM6IFVuYWJsZSB0
byBnZXQgaXRlbSBudW1iZXIgZm9ybSBFRVBST00gSUQgcGFnZSEgcmV0ID0gJWRcbiIsDQo+IA0K
PiAnZm9ybScgdHlwbw0KDQpXaWxsIGJlIGZpeGVkIGluIHYyLg0KDQo+Pj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgX19mdW5jX18sIHJldCk7DQo+Pj4NCj4+PiBUaGlzIHdpbGwgYmUg
cHJpbnRlZCBvbiBldmVyeSBkZXZpY2UsIGV2ZW4gdGhlIG9uZXMgd2l0aG91dCBJRCBFRVBST00s
DQo+Pj4gY29ycmVjdCA/IFRoaXMgc2hvdWxkIG5vdCBiZSBwcmludGVkIG9uIGRldmljZXMgd2l0
aG91dCBJRCBFRVBST00uIEFsc28sDQo+Pg0KPj4gVGhpcyBpcyBzdXBwcmVzc2VkIGJ5IHRoZSAt
RU5PRU5UIGNoZWNrLg0KPiANCj4gRG9lcyBpMmNfZWVwcm9tX3JlYWQoKSBpbiBkaF9nZXRfdmFs
dWVfZnJvbV9lZXByb21faWRfcGFnZSgpIHJldHVybg0KPiAtRU5PRU5UIGluIGNhc2UgdGhlIEVF
UFJPTSBpcyBkZXNjcmliZWQgaW4gRFQsIGJ1dCBub3QgcG9wdWxhdGVkIG9uIHRoZQ0KPiBib2Fy
ZCA/IEkgc3VzcGVjdCBpdCByZXR1cm5zIHNvbWUgb3RoZXIgZXJyb3IgY29kZSwgLUVUSU1FRE9V
VCBvcg0KPiAtRUlOVkFMIG1heWJlID8NCg0KSXQgY291bGQgb25seSBiZSBwb3NzaWJsZSBpZiB0
aGUgRFRPIGZvciBoYXJkd2FyZSByZXYuIDEwMCAod2hpY2ggaGFzIG5vDQpFRVBST00gSUQgcGFn
ZSkgaXMgbm90IGxvYWRlZC4gVGhlIHJldHVybiB2YWx1ZSB0aGVuIGlzIC1FTk9ERVYuDQpJIHdp
bGwgaW5jbHVkZWQgdGhpcyBpbiB2Mi4NCg0KPj4+IGlmIChyZXQgJiYgcmV0ICE9IC1FTk9FTlQp
IHt9DQo+Pj4NCj4+PiB3b3JrcyBlcXVhbGx5IHdlbGwgd2l0aG91dCB0aGUgZXh0cmEgaW5kZW50
Lg0KPj4NCj4+IEkgaGF2ZSBhbiBlbHNlIHRvIChyZXQpIGhlcmUgbm90IHRvIChyZXQgJiYgcmV0
ICE9IC1FTk9FTlQpLg0KPj4gVGhpcyB3b3VsZCBjaGFuZ2UgdGhlIGxvZ2ljLg0KPiANCj4gfSBl
bHNlIGlmICghcmV0KSB7IG9yIHNpbWlsYXIgc2hvdWxkIGZpeCB0aGF0LCByaWdodCA/DQo+IA0K
PiBCYXNpY2FsbHksIHRoZSBxdWVzdGlvbiBpcywgY2FuIHdlIGF2b2lkIHRoaXMgdHdvIGxldmVs
IGRlZXAgaW5kZW50ID8gSQ0KPiB0aGluayB5ZXMgPw0KDQpJIHdhbnQgdG8gdHJ5IGl0IGluIHYy
Lg0KDQo+IFsuLi5dDQo+IA0KPj4+IEFsc28sIHRoaXMgc2hvdWxkbid0IGJlIHJlcGVhdGVkbHkg
cmVhZGluZyB0aGUgRUVQUk9NLCB0aGUgRUVQUk9NIHJlYWQNCj4+PiBvcGVyYXRpb24gaXMgdGhl
IHNsb3cgcGFydCwgdGhlIEVFUFJPTSBpcyAzMiBieXRlcywgc28gdGhlIEVFUFJPTSBzaG91bGQN
Cj4+PiBiZSByZWFkIG9uY2UgYW5kIGNhY2hlZCwgYW5kIG9uY2UgdGhlIGNhY2hlIGlzIHBvcHVs
YXRlZCBhbGwgcmVhZA0KPj4+IGFjY2Vzc2VzIHRvIHRoZSBFRVBST00gc2hvdWxkIHVzZSB0aGUg
Y2FjaGUuDQo+Pg0KPj4gVGhpcyBpcyBhbHJlYWR5IGNvdmVyZWQgaW4gZnVuY3Rpb24gZGhfZ2V0
X3ZhbHVlX2Zyb21fZWVwcm9tX2lkX3BhZ2UoKS4NCj4gSXQgc2VlbXMgdGhhdCBmdW5jdGlvbiBh
bHdheXMgY2FsbHMNCj4gcmV0ID0gaTJjX2VlcHJvbV9yZWFkKGRldiwgMHgwLCBlaXBhLCBzaXpl
b2YoZWlwYSkpOw0KPiA/DQoNClRoZSAzMiBieXRlcyBhcmUgcmVhZCBpbnRvIGEgc3RhdGljIHZh
cmlhYmxlLiBJZiB0aGUgSUQgKERIRSkgYWxyZWFkeSBleGlzdHMNCmluIGl0LCB0aGUgaTJjX2Vl
cHJvbV9yZWFkKCkgZnVuY3Rpb24gaXMgbm8gbG9uZ2VyIGNhbGxlZC4NCg0KDQpSZWdhcmRzDQpD
aHJpc3RvcGgNCg==
