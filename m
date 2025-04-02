Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B2CC36014
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 09:04:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6758481703;
	Wed,  2 Apr 2025 11:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="RMl9vrfr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F174781CF0; Wed,  2 Apr 2025 11:04:31 +0200 (CEST)
Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C8CE80584
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 11:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1743584634;
 bh=6MhLua3spISVM2VVka5eJ5uQCaNuua1QGylDhZs7vKY=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=RMl9vrfre7dWojjoh2QTshbyECeozpMDRrK2jeLc+frAg4OQkZaPei6MP7dU4S+jM
 Dbt0rny88MrlpIqNaLgKfMdaUv3fTNUV8Caf8QqExqRXFI8XJ070C2XFQlY8zMua3b
 CJm6I6K2BUU5QFWql/rg4Mlza94vEMr7lJMNXnnULclGnlPlFZDljViNTSrYUOZOlA
 GQWSgog3KgxkmCiGsnOUUMn+bcTIrSUE6tLpUo922xJy91t5oV0WuQvOCpUfOJXNtc
 6+Siqz3vODxuJkN5BXgOn5vSej+24ABLfE67RQa5W6o8PFQRT6O7L1eLHVykWi50ZF
 JPoXKh0WxZ00Q==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Michael Walle <mwalle@kernel.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, Marek Vasut <marex@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Benedikt Spranger
 <b.spranger@linutronix.de>, Simon Glass <sjg@chromium.org>, John Ogness
 <john.ogness@linutronix.de>, Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: RE: [PATCH] tiny-printf: Add support for upper case hex values
Thread-Topic: [PATCH] tiny-printf: Add support for upper case hex values
Thread-Index: AQHbmYJXS9LfVQSOoEantzWfxGK4yLN72G+AgAAkmwCAEnYcAIAAcb5ggAEAtgCAAD/j0A==
Date: Wed, 2 Apr 2025 09:03:53 +0000
Message-ID: <de267e9022f844cf83bfd3e284c67955@dh-electronics.com>
References: <20250320102346.13564-1-cniedermaier@dh-electronics.com>
 <a6ab86ac-4404-4081-8529-b8d11b37b5d2@denx.de>
 <ab32ace5-efc0-41b9-8d13-292f6f87835d@cherry.de>
 <D8V6D9S6CBRH.3LRHNU4XCVF14@kernel.org>
 <052e98f6480b4490bd9338eb2f9ed5d2@dh-electronics.com>
 <D8VYKGGMN3DQ.1TYW767T1V3WJ@kernel.org>
In-Reply-To: <D8VYKGGMN3DQ.1TYW767T1V3WJ@kernel.org>
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

RnJvbTogTWljaGFlbCBXYWxsZSA8bXdhbGxlQGtlcm5lbC5vcmc+DQpTZW50OiBXZWRuZXNkYXks
IEFwcmlsIDIsIDIwMjUgOTowMiBBTQ0KPj4+PiBUaGUgaXNzdWUgaXMgdGhhdCBkaXNhYmxpbmcg
VElOWV9QUklOVEYgbWF5IG5vdCBiZSBwb3NzaWJsZSAoc2l6ZQ0KPj4+PiBjb25zdHJhaW50cykg
YW5kIHNvbWUgY29kZSBpcyBjb21waWxlZCBmb3IgZGlmZmVyZW50IHN0YWdlcyBhbmQgcGVvcGxl
DQo+Pj4+IHR5cGljYWxseSBkb24ndCBjaGVjayB3aGV0aGVyIHRoZSBmb3JtYXQgdXNlZCBpbiBw
cmludGYgaXMgdmFsaWQgd2l0aA0KPj4+PiB0aW55X3ByaW50Zi4gSSd2ZSBoYWQgdGhpcyBpc3N1
ZSBhbHJlYWR5IGluIHRoZSBwYXN0LCBJIHZhZ3VlbHkgcmVjYWxsDQo+Pj4+ICJjb21wbGFpbmlu
ZyIgYWJvdXQgaXQgb24gSVJDLg0KPj4+DQo+Pj4gWWVzLCBJJ3ZlIHN0dW1ibGVkIG9uICIlcGEi
IHdpdGggdGlueSBwcmludGYgKGkuZS4gaW4NCj4+PiBkcml2ZXJzL3BpbmN0cmwvcGluY3RybC1z
aW5nbGUuYykgd2hpY2ggaXMgcHJpbnRpbmcgdGhlIHZlcnkgd3JvbmcNCj4+PiB2YWx1ZSwgYWN0
dWFsbHkgOikgU28gcHJpbnRpbmcgYW55dGhpbmcgdW5rbm93biBhcyAnPycgd291bGQgcmVhbGx5
DQo+Pj4gaGVscCBoZXJlLg0KPj4NCj4+IFNvbWV0aGluZyBsaWtlIHRoYXQgd291bGQgaGVscDoN
Cj4+IGRpZmYgLS1naXQgYS9saWIvdGlueS1wcmludGYuYyBiL2xpYi90aW55LXByaW50Zi5jDQo+
PiBpbmRleCA0OGRiN2IxZjc4Zi4uYjkxOGQ2ZDczODYgMTAwNjQ0DQo+PiAtLS0gYS9saWIvdGlu
eS1wcmludGYuYw0KPj4gKysrIGIvbGliL3RpbnktcHJpbnRmLmMNCj4+IEBAIC0yODAsNiArMjgw
LDEyIEBAIHN0YXRpYyBpbnQgX3ZwcmludGYoc3RydWN0IHByaW50Zl9pbmZvICppbmZvLCBjb25z
dCBjaGFyICpmbXQsIHZhX2xpc3QgdmEpDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgd2hpbGUgKGlzYWxudW0oZm10WzBdKSkNCj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZtdCsrOw0KPj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB9IGVsc2Ugew0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGlmIChmbXRbMF0gIT0gJ1wwJyAmJiAoZm10WzBdID09ICdhJyB8fCBmbXRbMF0gPT0g
J20nIHx8DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBmbXRbMF0gPT0gJ00nIHx8IGZtdFswXSA9PSAnSScpKSB7DQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmbXQrKzsNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gdW5z
dXBwb3J0ZWQ7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfQ0K
PiANCj4gSSB3b3VsZG4ndCBtaW5kIHByaW50aW5nIHRoZSBwb2ludGVyIGZvciAlcFttTUldLCBi
dXQgJXBhIHByaW50cyB0aGUNCj4gKmNvbnRlbnQqIG9mIHRoZSBwb2ludGVyIHdoaWNoIGlzIHJl
YWxseSBjb25mdXNpbmcuIEkuZS4gaW4NCj4gcGluY3RybC1zaW5nbGUuYyB0aGUgcmVnIHZhbHVl
IHBhaXJzIGFyZSBwcmludGVkIGxpa2UNCj4gDQo+ICAgZGV2X2RiZyhkZXYsICJyZWcvdmFsICVw
YS8weCUwOHhcbiIsICZyZWcsIHZhbCk7DQo+IA0KPiB3aXRoIHJlZyBiZWluZyBhIHBvaW50ZXIg
dG8gYSBwaHlzaWNhbCBhZGRyZXNzLiBTbyB3aXRoIHRpbnlfcHJpbnRmDQo+IHRoZSBhZGRyZXNz
IG9mIHJlZyAod2hpY2ggaXMgYSBwb2ludGVyIHRvIHRoZSBzdGFjaykgaXMgcHJpbnRlZCBpbg0K
PiB0aGlzIGNhc2UuDQo+IA0KPiBJIGRvbid0IHRoaW5rIHdlIGNhbiBwcmludCAlcCB3aXRob3V0
IHB1dHRpbmcgbW9yZSBsb2dpYyBpbnRvIHRoZQ0KPiBkZWNvZGluZy4gSSB0aGluayB0aGUgY3Vs
cHJpdCBoZXJlIGlzIHRoZSBmYWxsdGhyb3VnaCB0byAleCwgd2hpY2gNCj4gdGhlbiBsZWFkcyB0
byB0aGUgY29uZnVzaW5nIGJlaGF2aW9yIHNob3duIGFib3ZlLiBJTUhPIGlmIHdlIHdhbnQgdG8N
Cj4gYXZvaWQgdGhhdCwgd2UnZCBoYXZlIHRvIG1ha2UgJXAgZW50aXJlbHkgdW5zdXBwb3J0ZWQu
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvbGliL3RpbnktcHJpbnRmLmMgYi9saWIvdGlueS1wcmludGYu
Yw0KPiBpbmRleCBmYWY1NWQ3ZjMyNy4uODE0N2ZmYTJjMWIgMTAwNjQ0DQo+IC0tLSBhL2xpYi90
aW55LXByaW50Zi5jDQo+ICsrKyBiL2xpYi90aW55LXByaW50Zi5jDQo+IEBAIC0yNjksMjEgKzI2
OSwxOCBAQCBzdGF0aWMgaW50IF92cHJpbnRmKHN0cnVjdCBwcmludGZfaW5mbyAqaW5mbywgY29u
c3QgY2hhciAqZm10LA0KPiB2YV9saXN0IHZhKQ0KPiAgCQkJCQkJZGl2X291dChpbmZvLCAmbnVt
LCBkaXYpOw0KPiAgCQkJCX0NCj4gIAkJCQlicmVhazsNCj4gKyNpZiBDT05GSUdfSVNfRU5BQkxF
RChORVQpIHx8IENPTkZJR19JU19FTkFCTEVEKE5FVF9MV0lQKSB8fCBfREVCVUcNCg0KV2hhdCBp
ZiB3ZSBmaW5lLXR1bmUgdGlueXByaW5mIHZpYSBjb25maWcgaGVyZT8NCkZvciBleGFtcGxlIFNQ
TF9VU0VfVElOWV9QUklOVEZfUE9JTlRFUl9TVVBQT1JUIGFuZA0Kc2VsZWN0IGl0IGJ5IE5FVCBv
ciBORVRfTFdJUC4gSWYgc29tZW9uZSBuZWVkcyBpdCwNCnRoZSBwb2ludGVyIG91dHB1dCBjYW4g
YmUgZW5hYmxlZCwgb3RoZXJ3aXNlICc/JyBmb3INCnVuc3VwcG9ydGVkIGlzIG91dHB1dC4NCg0K
PiAgCQkJY2FzZSAncCc6DQo+IC0JCQkJaWYgKENPTkZJR19JU19FTkFCTEVEKE5FVCkgfHwNCj4g
LQkJCQkgICAgQ09ORklHX0lTX0VOQUJMRUQoTkVUX0xXSVApIHx8IF9ERUJVRykgew0KPiAtCQkJ
CQlwb2ludGVyKGluZm8sIGZtdCwgdmFfYXJnKHZhLCB2b2lkICopKTsNCj4gLQkJCQkJLyoNCj4g
LQkJCQkJICogU2tpcCB0aGlzIGJlY2F1c2UgaXQgcHVsbHMgaW4gX2N0eXBlIHdoaWNoIGlzDQo+
IC0JCQkJCSAqIDI1NiBieXRlcywgYW5kIHdlIGRvbid0IGdlbmVyYWxseSBpbXBsZW1lbnQNCj4g
LQkJCQkJICogcG9pbnRlciBhbnl3YXkNCj4gLQkJCQkJICovDQo+IC0JCQkJCXdoaWxlIChpc2Fs
bnVtKGZtdFswXSkpDQo+IC0JCQkJCQlmbXQrKzsNCj4gLQkJCQkJYnJlYWs7DQo+IC0JCQkJfQ0K
PiAtCQkJCWlzbG9uZyA9IHRydWU7DQo+IC0JCQkJLyogbm8gYnJlYWsgKi8NCj4gKwkJCQlwb2lu
dGVyKGluZm8sIGZtdCwgdmFfYXJnKHZhLCB2b2lkICopKTsNCj4gKwkJCQkvKg0KPiArCQkJCSAq
IFNraXAgdGhpcyBiZWNhdXNlIGl0IHB1bGxzIGluIF9jdHlwZSB3aGljaCBpcw0KPiArCQkJCSAq
IDI1NiBieXRlcywgYW5kIHdlIGRvbid0IGdlbmVyYWxseSBpbXBsZW1lbnQNCj4gKwkJCQkgKiBw
b2ludGVyIGFueXdheQ0KPiArCQkJCSAqLw0KPiArCQkJCXdoaWxlIChpc2FsbnVtKGZtdFswXSkp
DQo+ICsJCQkJCWZtdCsrOw0KPiArCQkJCWJyZWFrOw0KPiArI2VuZGlmDQo+ICAJCQljYXNlICd4
JzoNCj4gIAkJCQlpZiAoaXNsb25nKSB7DQo+ICAJCQkJCW51bSA9IHZhX2FyZyh2YSwgdW5zaWdu
ZWQgbG9uZyk7DQo+IEBAIC0zMTAsNiArMzA3LDggQEAgc3RhdGljIGludCBfdnByaW50ZihzdHJ1
Y3QgcHJpbnRmX2luZm8gKmluZm8sIGNvbnN0IGNoYXIgKmZtdCwgdmFfbGlzdCB2YSkNCj4gIAkJ
CWNhc2UgJyUnOg0KPiAgCQkJCW91dChpbmZvLCAnJScpOw0KPiAgCQkJZGVmYXVsdDoNCj4gKwkJ
CQlvdXQoaW5mbywgJz8nKTsNCj4gIAkJCQlicmVhazsNCj4gIAkJCX0NCg0KUmVnYXJkcw0KQ2hy
aXN0b3BoDQo=
