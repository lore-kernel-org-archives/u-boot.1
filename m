Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F662CA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 13:18:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD2D68318E;
	Wed, 10 Sep 2025 15:18:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="fWGku5ex";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76085831D5; Wed, 10 Sep 2025 15:18:21 +0200 (CEST)
Received: from mx3.securetransport.de (mx3.securetransport.de
 [IPv6:2a01:4f8:c0c:92be::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BBFC830B4
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 15:18:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1757510294;
 bh=wfaYcFXk7imcSVz+cGvs4r2gkrF8ZjN5EuTI5yd3qw0=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=fWGku5ex8KH1M9tA+BQjsBvvumQ3O6FsDQm0KVT5OqNCEbLG/SWODKkjRv45nb2Nk
 y9GdRGzrimaUZfnGK2LP/ZIzPsobN/szAXOi9g6ft4iwXTWiUP4PnkBNozs+/u1iHs
 k1hVDoyzt/bbGndF0RL6wdFA50FIaH0SuS57DwJQXTYE8LnpHLKVs4SPmgavY89D+g
 EYvi9ipObwBjErrtO8x2jN36c0Ts/SuWQEIC9bvBOriMdaLDEEN4Y87xNHPhq6B4xz
 WDrEWRp/dz6fuCXPHGnZmpLVoR+J2hWJZpnQ3ey54qhEfWM0gCSTwu2aATqfvOx7vT
 q7o7oljvHmIag==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Marek Vasut <marek.vasut@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH 1/2] board: dhelectronics: Check pointer before access in
 dh_get_value_from_eeprom_buffer()
Thread-Topic: [PATCH 1/2] board: dhelectronics: Check pointer before access in
 dh_get_value_from_eeprom_buffer()
Thread-Index: AQHcH5L0jFgLOqgNzU2osHMXKuUj+7SMaktA
Date: Wed, 10 Sep 2025 13:18:13 +0000
Message-ID: <31547fea5bd345e5b47d1e21a095f176@dh-electronics.com>
References: <20250907010103.667681-1-marek.vasut@mailbox.org>
In-Reply-To: <20250907010103.667681-1-marek.vasut@mailbox.org>
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

RnJvbTogTWFyZWsgVmFzdXQgPG1hcmVrLnZhc3V0QG1haWxib3gub3JnPg0KU2VudDogU3VuZGF5
LCBTZXB0ZW1iZXIgNywgMjAyNSAzOjAxIEFNDQo+IFRoZSBlaXAgcG9pbnRlciBpbiBkaF9nZXRf
dmFsdWVfZnJvbV9lZXByb21fYnVmZmVyKCkgbWlnaHQgYmUgTlVMTC4NCj4gVGhlIGN1cnJlbnQg
TlVMTCBwb2ludGVyIGNoZWNrIGhhcHBlbnMgdG9vIGxhdGUsIGFmdGVyIHRoZSBlaXAgd2FzDQo+
IGFjY2Vzc2VkIGluIHZhcmlhYmxlIGFzc2lnbm1lbnQuIFJlb3JkZXIgdGhlIHR3bywgc28gdGhl
IE5VTEwgcG9pbnRlcg0KPiBjaGVjayBoYXBwZW5zIGZpcnN0LCBhbmQgYW55IGFjY2VzcyBzZWNv
bmQsIG90aGVyd2lzZSB0aGUgYWNjZXNzIG1heQ0KPiB0cmlnZ2VyIGEgaGFuZyBvciBvdGhlciB1
bmRlZmluZWQgYmVoYXZpb3IuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJlayBWYXN1dCA8bWFy
ZWsudmFzdXRAbWFpbGJveC5vcmc+DQo+IC0tLQ0KPiBDYzogQ2hyaXN0b3BoIE5pZWRlcm1haWVy
IDxjbmllZGVybWFpZXJAZGgtZWxlY3Ryb25pY3MuY29tPg0KPiBDYzogU2ltb24gR2xhc3MgPHNq
Z0BjaHJvbWl1bS5vcmc+DQo+IENjOiBUb20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPg0KPiAt
LS0NCj4gIGJvYXJkL2RoZWxlY3Ryb25pY3MvY29tbW9uL2RoX2NvbW1vbi5jIHwgOSArKysrKyst
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvYm9hcmQvZGhlbGVjdHJvbmljcy9jb21tb24vZGhfY29tbW9uLmMN
Cj4gYi9ib2FyZC9kaGVsZWN0cm9uaWNzL2NvbW1vbi9kaF9jb21tb24uYw0KPiBpbmRleCA5Zjhl
NTc1NGQ4Yy4uYWVhYmQ2MTczNzQgMTAwNjQ0DQo+IC0tLSBhL2JvYXJkL2RoZWxlY3Ryb25pY3Mv
Y29tbW9uL2RoX2NvbW1vbi5jDQo+ICsrKyBiL2JvYXJkL2RoZWxlY3Ryb25pY3MvY29tbW9uL2Ro
X2NvbW1vbi5jDQo+IEBAIC0xMzEsMTQgKzEzMSwxNyBAQCBpbnQgZGhfcmVhZF9lZXByb21faWRf
cGFnZSh1OCAqZWVwcm9tX2J1ZmZlciwgY29uc3QgY2hhciAqYWxpYXMpDQo+ICBpbnQgZGhfZ2V0
X3ZhbHVlX2Zyb21fZWVwcm9tX2J1ZmZlcihlbnVtIGVpcF9yZXF1ZXN0X3ZhbHVlcyByZXF1ZXN0
LCB1OCAqZGF0YSwgaW50DQo+IGRhdGFfbGVuLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzdHJ1Y3QgZWVwcm9tX2lkX3BhZ2UgKmVpcCkNCj4gIHsNCj4gLSAgICAgICBj
b25zdCBjaGFyIGZpbl9jaHIgPSAoZWlwLT5wbC5pdGVtX3ByZWZpeCAmIERIX0lURU1fUFJFRklY
X0ZJTl9CSVQpID8NCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICBESF9JVEVNX1BSRUZJ
WF9GSU5fRkxBU0hFRF9DSFIgOiBESF9JVEVNX1BSRUZJWF9GSU5fSEFMRl9DSFI7DQo+IC0gICAg
ICAgY29uc3QgdTggc29jX2NvZGVkID0gZWlwLT5wbC5pdGVtX3ByZWZpeCAmIDB4ZjsNCj4gKyAg
ICAgICBjaGFyIGZpbl9jaHI7DQo+ICsgICAgICAgdTggc29jX2NvZGVkOw0KPiAgICAgICAgIGNo
YXIgc29jX2NocjsNCj4gDQo+ICAgICAgICAgaWYgKCFlaXApDQo+ICAgICAgICAgICAgICAgICBy
ZXR1cm4gLUVJTlZBTDsNCj4gDQo+ICsgICAgICAgZmluX2NociA9IChlaXAtPnBsLml0ZW1fcHJl
Zml4ICYgREhfSVRFTV9QUkVGSVhfRklOX0JJVCkgPw0KPiArICAgICAgICAgICAgICAgICBESF9J
VEVNX1BSRUZJWF9GSU5fRkxBU0hFRF9DSFIgOiBESF9JVEVNX1BSRUZJWF9GSU5fSEFMRl9DSFI7
DQo+ICsgICAgICAgc29jX2NvZGVkID0gZWlwLT5wbC5pdGVtX3ByZWZpeCAmIDB4ZjsNCj4gKw0K
PiAgICAgICAgIC8qIENvcHkgcmVxdWVzdGVkIGRhdGEgKi8NCj4gICAgICAgICBzd2l0Y2ggKHJl
cXVlc3QpIHsNCj4gICAgICAgICBjYXNlIERIX01BQzA6DQoNClJldmlld2VkLWJ5OiBDaHJpc3Rv
cGggTmllZGVybWFpZXIgPGNuaWVkZXJtYWllckBkaC1lbGVjdHJvbmljcy5jb20+DQo=
