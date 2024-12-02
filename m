Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE39D78337
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 17:17:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC7B088DB1;
	Mon,  2 Dec 2024 18:17:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="U3LNcxWp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47FC588FC4; Mon,  2 Dec 2024 18:17:39 +0100 (CET)
Received: from mx3.securetransport.de (mx3.securetransport.de
 [IPv6:2a01:4f8:c0c:92be::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47B9588A1B
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 18:17:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1733159848;
 bh=CB0m+10ZfOqVtuZ98g3XXNzTuWjw1GmA4HGZ0gYoHMk=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=U3LNcxWpCq0DOEZopykFoCpaenB2s+euG5pmPYqRgWxOgLACam1IgHi7aEIWYhBbx
 2qQvgtTbPlf7KiJxQ+UbBiSF9Xl5kN02rScrM930SMHpa8fa1t7/kNqcvcHWfTE2iO
 F0BVKmJ5WcBlsq7bhc8UzBqN1Vuq4Tk6WcKZ/nsTYMCbUdgkecIfwmFY5377xPTW71
 28L2Lh9SV1WSguPLnHpZRdfr7EJlN8lLxfm3FEJFh2UDAt/ZRLs4byuFn+F/tgCj9T
 csHGRo8hb4f9gR3AXECiPHxfzyb5VE7LSEMXVQvtHjWQWZwKJsm6+Syf3FIEaj5NKN
 NJwNkoGQP4RYw==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: NXP i.MX U-Boot Team <uboot-imx@nxp.com>, Fabio Estevam
 <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>, Tom Rini
 <trini@konsulko.com>, u-boot <u-boot@dh-electronics.com>
Subject: RE: [PATCH V4 2/4] arm64: imx8mp: Read values from M24C32-D
 write-lockable page on DHCOM i.MX8MP
Thread-Topic: [PATCH V4 2/4] arm64: imx8mp: Read values from M24C32-D
 write-lockable page on DHCOM i.MX8MP
Thread-Index: AQHbQaDkhrFsIVpTPEC/70FVRfpllrLRrdQAgAGKgdA=
Date: Mon, 2 Dec 2024 17:17:26 +0000
Message-ID: <25004ade364e43ef91736d2e9d178cd8@dh-electronics.com>
References: <20241128142020.35386-1-cniedermaier@dh-electronics.com>
 <20241128142020.35386-3-cniedermaier@dh-electronics.com>
 <f3c84d83-31ff-4408-a733-a97a2219ed33@denx.de>
In-Reply-To: <f3c84d83-31ff-4408-a733-a97a2219ed33@denx.de>
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

RnJvbTogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQpTZW50OiBTdW5kYXksIERlY2VtYmVy
IDEsIDIwMjQgNzo0NCBQTQ0KPiBPbiAxMS8yOC8yNCAzOjIwIFBNLCBDaHJpc3RvcGggTmllZGVy
bWFpZXIgd3JvdGU6DQo+IA0KPiBbLi4uXQ0KPiANCj4+ICsrKyBiL2JvYXJkL2RoZWxlY3Ryb25p
Y3MvY29tbW9uL2RoX2NvbW1vbi5jDQo+PiBAQCAtNyw2ICs3LDcgQEANCj4+ICAgI2luY2x1ZGUg
PGRtLmg+DQo+PiAgICNpbmNsdWRlIDxpMmNfZWVwcm9tLmg+DQo+PiAgICNpbmNsdWRlIDxuZXQu
aD4NCj4+ICsjaW5jbHVkZSA8dS1ib290L2NyYy5oPg0KPj4NCj4+ICAgI2luY2x1ZGUgImRoX2Nv
bW1vbi5oIg0KPj4NCj4+IEBAIC0zMCw2ICszMSwxNDggQEAgaW50IGRoX2dldF9tYWNfaXNfZW5h
YmxlZChjb25zdCBjaGFyICphbGlhcykNCj4+ICAgCXJldHVybiAwOw0KPj4gICB9DQo+Pg0KPj4g
K2ludCBkaF9yZWFkX2VlcHJvbV9pZF9wYWdlKHU4ICplZXByb21fYnVmZmVyLCBjb25zdCBjaGFy
ICphbGlhcykNCj4+ICt7DQo+PiArCXN0cnVjdCBlZXByb21faWRfcGFnZSAqZWlwID0gKHN0cnVj
dCBlZXByb21faWRfcGFnZSAqKWVlcHJvbV9idWZmZXI7DQo+PiArCXN0cnVjdCB1ZGV2aWNlICpk
ZXY7DQo+PiArCXNpemVfdCBwYXlsb2FkX2xlbjsNCj4+ICsJaW50IGVlcHJvbV9zaXplOw0KPj4g
Kwl1MTYgY3JjMTZfY2FsYzsNCj4+ICsJdTE2IGNyYzE2X2VpcDsNCj4+ICsJdTggY3JjOF9jYWxj
Ow0KPj4gKwlvZm5vZGUgbm9kZTsNCj4+ICsJaW50IHJldDsNCj4+ICsNCj4+ICsJbm9kZSA9IG9m
bm9kZV9wYXRoKGFsaWFzKTsNCj4+ICsNCj4+ICsJcmV0ID0gdWNsYXNzX2dldF9kZXZpY2VfYnlf
b2Zub2RlKFVDTEFTU19JMkNfRUVQUk9NLCBub2RlLCAmZGV2KTsNCj4+ICsJaWYgKHJldCkNCj4+
ICsJCXJldHVybiByZXQ7DQo+PiArDQo+PiArCWVlcHJvbV9zaXplID0gaTJjX2VlcHJvbV9zaXpl
KGRldik7DQo+PiArCWlmIChlZXByb21fc2l6ZSA8IDApIHsNCj4+ICsJCXByaW50ZigiJXM6IEVy
cm9yIGdldHRpbmcgRUVQUk9NIElEIHBhZ2Ugc2l6ZSEgcmV0ID0gJWRcbiIsIF9fZnVuY19fLCBy
ZXQpOw0KPj4gKwkJcmV0dXJuIGVlcHJvbV9zaXplOw0KPj4gKwl9IGVsc2UgaWYgKGVlcHJvbV9z
aXplID09IDAgfHwgZWVwcm9tX3NpemUgPiBESF9FRVBST01fSURfUEFHRV9NQVhfU0laRSkgew0K
PiANCj4gVGhlIGVsc2UgcGFydCBpcyBub3QgbmVjZXNzYXJ5LCB1c2UgcGxhaW46DQo+IA0KPiAu
Li4NCj4gICAuLi4NCj4gICByZXR1cm4gZWVwcm9tX3NpemU7DQo+IH0NCj4gDQo+IGlmIChlZXBy
b21fc2l6ZSA9PSAwIHx8IGVlcHJvbV9zaXplID4gREhfRUVQUk9NX0lEX1BBR0VfTUFYX1NJWkUp
IHsNCj4gLi4uDQoNCkkgd2lsbCBjaGFuZ2UgaXQgaW4gVjUuDQoNCj4+ICsJCWVlcHJvbV9zaXpl
ID0gREhfRUVQUk9NX0lEX1BBR0VfTUFYX1NJWkU7DQo+PiArCQlwcmludGYoIkdldCBpbnZhbGlk
IEVFUFJPTSBJRCBwYWdlIHNpemUgJWQgYnl0ZXMhIFRyeSB0byByZWFkICVkIGJ5dGVzLlxuIiwN
Cj4+ICsJCSAgICAgICBlZXByb21fc2l6ZSwgREhfRUVQUk9NX0lEX1BBR0VfTUFYX1NJWkUpOw0K
Pj4gKwl9DQo+PiArDQo+PiArCXJldCA9IGkyY19lZXByb21fcmVhZChkZXYsIDB4MCwgZWVwcm9t
X2J1ZmZlciwgZWVwcm9tX3NpemUpOw0KPj4gKwlpZiAocmV0KSB7DQo+PiArCQlwcmludGYoIiVz
OiBFcnJvciByZWFkaW5nIEVFUFJPTSBJRCBwYWdlISByZXQgPSAlZFxuIiwgX19mdW5jX18sIHJl
dCk7DQo+PiArCQlyZXR1cm4gcmV0Ow0KPj4gKwl9DQo+PiArDQo+PiArCS8qIFZhbGlkYXRlIGhl
YWRlciBJRCAqLw0KPj4gKwlpZiAoZWlwLT5oZHIuaWRbMF0gIT0gJ0QnIHx8IGVpcC0+aGRyLmlk
WzFdICE9ICdIJyB8fCBlaXAtPmhkci5pZFsyXSAhPSAnRScpIHsNCj4+ICsJCXByaW50ZigiJXM6
IEVycm9yIHZhbGlkYXRpbmcgaGVhZGVyIElEISAoZ290ICVjJWMlYyAoMHglMDJ4IDB4JTAyeCAw
eCUwMngpICE9IGV4cGVjdGVkIERIRSlcbiIsDQo+PiArCQkgICAgICAgX19mdW5jX18sIGlzcHJp
bnQoZWlwLT5oZHIuaWRbMF0pID8gZWlwLT5oZHIuaWRbMF0gOiAnLicsDQo+PiArCQkgICAgICAg
aXNwcmludChlaXAtPmhkci5pZFsxXSkgPyBlaXAtPmhkci5pZFsxXSA6ICcuJywNCj4+ICsJCSAg
ICAgICBpc3ByaW50KGVpcC0+aGRyLmlkWzJdKSA/IGVpcC0+aGRyLmlkWzJdIDogJy4nLA0KPj4g
KwkJICAgICAgIGVpcC0+aGRyLmlkWzBdLCBlaXAtPmhkci5pZFsxXSwgZWlwLT5oZHIuaWRbMl0p
Ow0KPj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+PiArCX0NCj4+ICsNCj4+ICsJLyogVmFsaWRhdGUg
aGVhZGVyIGNoZWNrc3VtICovDQo+PiArCWNyYzhfY2FsYyA9IGNyYzgoMHhmZiwgZWVwcm9tX2J1
ZmZlciwgb2Zmc2V0b2Yoc3RydWN0IGVlcHJvbV9pZF9wYWdlLCBoZHIuY3JjOF9oZHIpKTsNCj4+
ICsJaWYgKGVpcC0+aGRyLmNyYzhfaGRyICE9IGNyYzhfY2FsYykgew0KPj4gKwkJcHJpbnRmKCIl
czogRXJyb3IgdmFsaWRhdGluZyBoZWFkZXIgY2hlY2tzdW0hIChnb3QgMHglMDJ4ICE9IGNhbGMg
MHglMDJ4KVxuIiwNCj4+ICsJCSAgICAgICBfX2Z1bmNfXywgZWlwLT5oZHIuY3JjOF9oZHIsIGNy
YzhfY2FsYyk7DQo+PiArCQlyZXR1cm4gLUVJTlZBTDsNCj4+ICsJfQ0KPj4gKw0KPj4gKwkvKg0K
Pj4gKwkgKiBWYWxpZGF0ZSBoZWFkZXIgdmVyc2lvbg0KPj4gKwkgKiBUaGUgcGF5bG9hZCBpcyBk
ZWZpbmVkIGJ5IHRoZSB2ZXJzaW9uIHNwZWNpZmllZCBpbiB0aGUgaGVhZGVyLg0KPj4gKwkgKiBD
dXJyZW50bHkgb25seSB2ZXJzaW9uIDB4MTAgaXMgZGVmaW5lZCwgc28gdGFrZSB0aGUgbGVuZ3Ro
IG9mDQo+PiArCSAqIHRoZSBvbmx5IGRlZmluZWQgcGF5bG9hZCBhcyB0aGUgcGF5bG9hZCBsZW5n
dGguDQo+PiArCSAqLw0KPj4gKwlpZiAoZWlwLT5oZHIudmVyc2lvbiA9PSBESF9FRVBST01fSURf
UEFHRV9WMV8wKSB7DQo+IA0KPiBJbnZlcnQgdGhpcyBjb25kaXRpb25hbDoNCj4gDQo+IC4uLg0K
PiBpZiAoZWlwLT5oZHIudmVyc2lvbiAhPSBESF9FRVBST01fSURfUEFHRV9WMV8wKSB7DQo+ICAg
cHJpbnRmKC4uLik7DQo+ICAgcmV0dXJuIC4uLjsNCj4gfQ0KPiANCj4gcGF5bG9hZF9sZW4gPSBz
aXplb2YoZWlwLT5wbCk7DQo+IC4uLg0KDQpJIHdpbGwgY2hhbmdlIGl0IGluIFY1Lg0KDQo+PiAr
CQlwYXlsb2FkX2xlbiA9IHNpemVvZihlaXAtPnBsKTsNCj4+ICsJfSBlbHNlIHsNCj4+ICsJCXBy
aW50ZigiJXM6IEVycm9yIHZhbGlkYXRpbmcgdmVyc2lvbiEgKDB4JTAyWCBpcyBub3Qgc3VwcG9y
dGVkKVxuIiwNCj4+ICsJCSAgICAgICBfX2Z1bmNfXywgZWlwLT5oZHIudmVyc2lvbik7DQo+PiAr
CQlyZXR1cm4gLUVJTlZBTDsNCj4+ICsJfQ0KPj4gKw0KPj4gKwkvKiBWYWxpZGF0ZSBwYXlsb2Fk
IGNoZWNrc3VtICovDQo+PiArCWNyYzE2X2VpcCA9IChlaXAtPmhkci5jcmMxNl9wbFsxXSA8PCA4
KSB8IGVpcC0+aGRyLmNyYzE2X3BsWzBdOw0KPj4gKwljcmMxNl9jYWxjID0gY3JjMTYoMHhmZmZm
LCBlZXByb21fYnVmZmVyICsgc2l6ZW9mKGVpcC0+aGRyKSwgcGF5bG9hZF9sZW4pOw0KPj4gKwlp
ZiAoY3JjMTZfZWlwICE9IGNyYzE2X2NhbGMpIHsNCj4+ICsJCXByaW50ZigiJXM6IEVycm9yIHZh
bGlkYXRpbmcgZGF0YSBjaGVja3N1bSEgKGdvdCAweCUwMnggIT0gY2FsYyAweCUwMngpXG4iLA0K
Pj4gKwkJICAgICAgIF9fZnVuY19fLCBjcmMxNl9laXAsIGNyYzE2X2NhbGMpOw0KPj4gKwkJcmV0
dXJuIC1FSU5WQUw7DQo+PiArCX0NCj4+ICsNCj4+ICsJcmV0dXJuIDA7DQo+PiArfQ0KPiANCj4g
Wy4uLl0NCg0KVGhhbmtzIGFuZCByZWdhcmRzDQpDaHJpc3RvcGgNCg==
