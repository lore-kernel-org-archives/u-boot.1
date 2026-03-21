Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30615109449C
	for <u-boot@archiver.kernel.org>; Sat, 21 Mar 2026 20:55:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 838F784035;
	Sat, 21 Mar 2026 21:55:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="kAz9lp/f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EF468404D; Sat, 21 Mar 2026 21:55:31 +0100 (CET)
Received: from mx3.securetransport.de (mx3.securetransport.de
 [IPv6:2a01:4f8:c0c:92be::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48C7F84013
 for <u-boot@lists.denx.de>; Sat, 21 Mar 2026 21:55:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1774126522;
 bh=Lnpp65UIya6CoxcX+87FpnyVSVCz+jE15B+d80Qoe2M=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=kAz9lp/f+IX8CHJKWFFptqbhEcv8qI/3X2kvkqBsxG5nChCBSY1ehp/Gfx/7IIvzN
 FWas1BBTiQwjTZED/rN42s9H+VOGBYYClbmAbC9yvPIfSVSe01AxlDfVAyk1UsZIKp
 nHIVebkIyU9KHUYDoI6C6l+XNCU0aH5opUYxB/UluUAaBHTLJhR9Uu12D8atoKpQ0o
 ixdliXpdk8bYVHt3FEEZnbnHdaJcN7viNpNobXvghKDYEwMofU++lgcatXA+ZOMv1U
 qqQpnVZogO81wo6IvsbyKOUkLlpI3aIoWcgHUV9FQWKX0nkRkl01OALi5TsefWsUHi
 GUn3DeXKdCcGQ==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Marek Vasut <marex@nabladev.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini
 <trini@konsulko.com>, u-boot <u-boot@dh-electronics.com>
Subject: RE: [PATCH] board: dhelectronics: imx: Use second Ethernet MAC also
 from fuse
Thread-Topic: [PATCH] board: dhelectronics: imx: Use second Ethernet MAC also
 from fuse
Thread-Index: AQHcuFTCAYeM+Dh5A0K4haKIts4CsrW3q5OAgAHGg1A=
Date: Sat, 21 Mar 2026 20:55:19 +0000
Message-ID: <b443e161b5db4abab8d8889135a345fa@dh-electronics.com>
References: <20260320102918.4011-1-cniedermaier@dh-electronics.com>
 <382f338c-020f-482d-80b8-5a39ad724843@nabladev.com>
In-Reply-To: <382f338c-020f-482d-80b8-5a39ad724843@nabladev.com>
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

RnJvbTogTWFyZWsgVmFzdXQgPG1hcmV4QG5hYmxhZGV2LmNvbT4NClNlbnQ6IEZyaWRheSwgTWFy
Y2ggMjAsIDIwMjYgNzoyMiBQTQ0KPiBPbiAzLzIwLzI2IDExOjI5IEFNLCBDaHJpc3RvcGggTmll
ZGVybWFpZXIgd3JvdGU6DQo+IA0KPiBbLi4uXQ0KPiANCj4+ICsrKyBiL2JvYXJkL2RoZWxlY3Ry
b25pY3MvZGhfaW14OG1wL2lteDhtcF9kaGNvbV9wZGsyLmMNCj4+IEBAIC01MCw3ICs1MCw3IEBA
IHN0YXRpYyBpbnQgZGhfaW14OF9zZXR1cF9ldGhhZGRyKHN0cnVjdCBlZXByb21faWRfcGFnZSAq
ZWlwKQ0KPj4gICAgICAgaWYgKGRoX2dldF9tYWNfaXNfZW5hYmxlZCgiZXRoZXJuZXQwIikpDQo+
PiAgICAgICAgICAgICAgIHJldHVybiAwOw0KPj4NCj4+IC0gICAgIGlmICghZGhfaW14X2dldF9t
YWNfZnJvbV9mdXNlKGVuZXRhZGRyKSkNCj4+ICsgICAgIGlmICghZGhfaW14X2dldF9tYWNfZnJv
bV9mdXNlKDAsIGVuZXRhZGRyKSkNCj4+ICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+Pg0KPj4g
ICAgICAgaWYgKCFkaF9nZXRfdmFsdWVfZnJvbV9lZXByb21fYnVmZmVyKERIX01BQzAsIGVuZXRh
ZGRyLCBzaXplb2YoZW5ldGFkZHIpLCBlaXApKQ0KPj4gQEAgLTc1LDggKzc1LDggQEAgc3RhdGlj
IGludCBkaF9pbXg4X3NldHVwX2V0aDFhZGRyKHN0cnVjdCBlZXByb21faWRfcGFnZSAqZWlwKQ0K
Pj4gICAgICAgaWYgKGRoX2dldF9tYWNfaXNfZW5hYmxlZCgiZXRoZXJuZXQxIikpDQo+PiAgICAg
ICAgICAgICAgIHJldHVybiAwOw0KPj4NCj4+IC0gICAgIGlmICghZGhfaW14X2dldF9tYWNfZnJv
bV9mdXNlKGVuZXRhZGRyKSkNCj4+IC0gICAgICAgICAgICAgZ290byBpbmNyZW1lbnRfb3V0Ow0K
Pj4gKyAgICAgaWYgKCFkaF9pbXhfZ2V0X21hY19mcm9tX2Z1c2UoMSwgZW5ldGFkZHIpKQ0KPj4g
KyAgICAgICAgICAgICBnb3RvIG91dDsNCj4gDQo+IFRoZSBvcmRlcmluZyBpbiB0aGlzIGFuZCBu
ZXh0IGh1bmsgc2VlbXMgYm9ndXMuDQo+IA0KPiBJZiByZWFkIGZyb20gdGhlIChuZXcvc2Vjb25k
KSBmdXNlIHNsb3QgMSBmYWlscywgdGhlIGNvZGUgc2hvdWxkIGF0dGVtcHQNCj4gdG8gdXNlIGZ1
c2Ugc2xvdCAwIGNvbnRlbnQgaW5jcmVtZW50ZWQgYnkgMSwganVzdCBsaWtlIGl0IGRpZCBiZWZv
cmUgLi4uDQo+IA0KPiAiDQo+IGlmICghZGhfaW14X2dldF9tYWNfZnJvbV9mdXNlKDEsIGVuZXRh
ZGRyKSkNCj4gICAgZ290byBvdXQ7DQo+IGlmICghZGhfaW14X2dldF9tYWNfZnJvbV9mdXNlKDAs
IGVuZXRhZGRyKSkNCj4gICAgZ290byBpbmNyZW1lbnRfb3V0Ow0KPiAiDQo+IA0KPj4gICAgICAg
aWYgKCFkaF9nZXRfdmFsdWVfZnJvbV9lZXByb21fYnVmZmVyKERIX01BQzEsIGVuZXRhZGRyLCBz
aXplb2YoZW5ldGFkZHIpLCBlaXApKQ0KPj4gICAgICAgICAgICAgICBnb3RvIG91dDsNCj4+IEBA
IC05Miw2ICs5MiwxMyBAQCBzdGF0aWMgaW50IGRoX2lteDhfc2V0dXBfZXRoMWFkZHIoc3RydWN0
IGVlcHJvbV9pZF9wYWdlICplaXApDQo+PiAgICAgICBpZiAoIWRoX2dldF9tYWNfZnJvbV9lZXBy
b20oZW5ldGFkZHIsICJlZXByb20wIikpDQo+PiAgICAgICAgICAgICAgIGdvdG8gaW5jcmVtZW50
X291dDsNCj4+DQo+PiArICAgICAvKg0KPj4gKyAgICAgICogSWYgb25seSB0aGUgZmlyc3QgTUFD
IGFkZHJlc3MgaXMgZnVzZWQgYnV0IG5vdCB0aGUgc2Vjb25kLCB1c2UgdGhlDQo+PiArICAgICAg
KiBmdXNlZCBNQUMgYWRkcmVzcyBpbmNyZW1lbnRlZCBieSBvbmUsIGZvciB0aGUgc2Vjb25kIE1B
QyBhZGRyZXNzLg0KPj4gKyAgICAgICovDQo+PiArICAgICBpZiAoIWRoX2lteF9nZXRfbWFjX2Zy
b21fZnVzZSgwLCBlbmV0YWRkcikpDQo+PiArICAgICAgICAgICAgIGdvdG8gaW5jcmVtZW50X291
dDsNCj4gLi4uIHRoaXMgcGFydCB3b3VsZCB0aGVuIGJlIHVubmVjZXNzYXJ5Lg0KDQpUaGF0J3Mg
aG93IGl0J3Mgc3VwcG9zZWQgdG8gYmUuIFRoZSB0d28gTUFDIGFkZHJlc3NlcyBzaG91bGQgYmUg
YXNzaWduZWQgdGhlIHNhbWUNCnByaW9yaXR5IG9yZGVyIGFuZCBiZSBhcyBpbmRlcGVuZGVudCBv
ZiBlYWNoIG90aGVyIGFzIHBvc3NpYmxlIHRvIGF2b2lkIGNvbmZ1c2lvbi4NClNvdXJjZXMgYXNz
b2NpYXRlZCB3aXRoIHRoZSBzZWNvbmQgTUFDIGFkZHJlc3MgdGhlcmVmb3JlIGhhdmUgYSBoaWdo
ZXIgcHJpb3JpdHkNCnRoYW4gdGhvc2UgYXNzb2NpYXRlZCB3aXRoIHRoZSBmaXJzdCBNQUMgYWRk
cmVzcyBpbiB0aGUgZnVzZXMuIFVzaW5nIHRoZSBmdXNlIG9mDQp0aGUgZmlyc3QgTUFDIGFkZHJl
c3MgaW5jcmVtZW50ZWQgYnkgb25lIGFzIGEgZmFsbGJhY2sgaXMgdGhlIGxhc3QgcmVzb3J0IGlm
IG5vDQphZGRyZXNzIGlzIGZvdW5kIGZvciB0aGUgc2Vjb25kIE1BQyBhZGRyZXNzIGFmdGVyIHRo
ZSBwcmlvcml0eSBvcmRlciBoYXMgYmVlbg0KY2hlY2tlZC4NCg0KDQpSZWdhcmRzDQpDaHJpc3Rv
cGgNCg==
