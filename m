Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10EED1AD4E
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 11:57:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D882988B70;
	Wed, 16 Oct 2024 13:57:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="PI0ViS4s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37E1B88BD2; Wed, 16 Oct 2024 13:57:56 +0200 (CEST)
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42B7E88B39
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 13:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1729079867;
 bh=Maw3ZBxk2ZsFIWaOuzm38j5sUCSPHCF5eMzG73+t1LA=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=PI0ViS4sifmvbSyXSlWlPvm11PTB9UBzqOrFrn3IQJyNMDNm+NxFXmb0KdSlBYMHK
 UjiC6bSf1Q2ilo+vYkPMGkOtJa/fV3mZhfZi8aYh/8nukHMD6RF3kmwDfkXZxZyXjD
 T8hMJ3bRHm291PR7O70rY/X7azwEhWD/JmwpABhEJ6xzpken48qKA9aEa+goxwTOCc
 dScixoASCPeGxNkE9+ZdFwb5pTGaaKBM3J9mw/A6u8w1oZ4Wf0teTH9oRBqC7sijmC
 kJ0Py77Rh5CEOkSbcp1fxVbfLapKoebwU5sJyVYMWohnxAQu51IynT/us34dW4EWK7
 AjjPzZT5BbbOA==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: NXP i.MX U-Boot Team <uboot-imx@nxp.com>, Fabio Estevam
 <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>, Tom Rini
 <trini@konsulko.com>, u-boot <u-boot@dh-electronics.com>
Subject: RE: [PATCH 1/2] arm64: imx8mp: Read MAC address from M24C32-D
 write-lockable page on DH i.MX8MP DHCOM if available
Thread-Topic: [PATCH 1/2] arm64: imx8mp: Read MAC address from M24C32-D
 write-lockable page on DH i.MX8MP DHCOM if available
Thread-Index: AQHbGxfGhQwPx5oDdEKUB8iQmKl/XLKDdt0AgAXWXZA=
Date: Wed, 16 Oct 2024 11:57:36 +0000
Message-ID: <62b02b850c194dc080684db8d00cf413@dh-electronics.com>
References: <20241010132337.3259-1-cniedermaier@dh-electronics.com>
 <9b2f1914-ed29-429b-8c0a-e2a25a1172a9@denx.de>
In-Reply-To: <9b2f1914-ed29-429b-8c0a-e2a25a1172a9@denx.de>
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

RnJvbTogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQpTZW50OiBTYXR1cmRheSwgT2N0b2Jl
ciAxMiwgMjAyNCAxMDo0MyBQTQ0KPiBPbiAxMC8xMC8yNCAzOjIzIFBNLCBDaHJpc3RvcGggTmll
ZGVybWFpZXIgd3JvdGU6DQo+PiBUaGUgaS5NWDhNIFBsdXMgREhDT00gY3VycmVudGx5IHN1cHBv
cnRzIHBhcnNpbmcgZXRoZXJuZXQgTUFDIGFkZHJlc3MNCj4+IGZyb20gbXVsdGlwbGUgc291cmNl
cyBpbiB0aGUgZm9sbG93aW5nIHByaW9yaXR5IG9yZGVyOg0KPj4NCj4+IDEpIFUtQm9vdCBlbnZp
cm9ubWVudCAnZXRoYWRkcicvJ2V0aDFhZGRyJyBlbnZpcm9ubWVudCB2YXJpYWJsZQ0KPj4gMikg
U29DIE9UUCBmdXNlcw0KPj4gMykgT24tU29NIEVFUFJPTQ0KPj4NCj4+IFRoZSBuZXcgaS5NWDhN
IFBsdXMgREhDT00gcmV2LjIwMCBpcyBwb3B1bGF0ZWQgd2l0aCBNMjRDMzItRCBFRVBST00NCj4+
IHdoaWNoIGNvbnRhaW5zIGFkZGl0aW9uYWwgd3JpdGUtbG9ja2FibGUgcGFnZSwgd2hpY2ggY2Fu
IGFsc28gYmUNCj4+IHBvcHVsYXRlZCB3aXRoIGEgc3RydWN0dXJlIGNvbnRhaW5pbmcgZXRoZXJu
ZXQgTUFDIGFkZHJlc3MuDQo+Pg0KPj4gQWRkIHN1cHBvcnQgZm9yIHBhcnNpbmcgdGhlIGNvbnRl
bnQgb2YgdGhpcyBuZXcgd3JpdGUtbG9ja2FibGUgcGFnZQ0KPj4gYW5kIHBsYWNlIGl0IGJldHdl
ZW4gMikgYW5kIDMpIG9uIHRoZSBwcmlvcml0eSBsaXN0LiBUaGUgbmV3IGVudHJ5IGlzDQo+PiAy
LjUpIE9uLVNvTSBFRVBST00gd3JpdGUtbG9ja2FibGUgcGFnZQ0KPj4NCj4+IEJlY2F1c2UgdGhl
IHdyaXRlLWxvY2thYmxlIHBhZ2UgaXMgbm90IHByZXNlbnQgb24gcmV2LjEwMCBpLk1YOE1QIERI
Q09NDQo+PiBTb00sIHRlc3Qgd2hldGhlciBFRVBST00gSUQgcGFnZSBleGlzdHMgaW4gRFQgYW5k
IHdoZXRoZXIgaXQgaXMgZW5hYmxlZA0KPj4gZmlyc3QuIElmIHNvLCByZWFkIHRoZSBlbnRpcmUg
SUQgcGFnZSBvdXQsIHZhbGlkYXRlIGl0LCBhbmQgZGV0ZXJtaW5lDQo+PiB3aGV0aGVyIEVFUFJP
TSBNQUMgYWRkcmVzcyBpcyBwb3B1bGF0ZWQgaW4gaXQgaW4gREggc3BlY2lmaWMgZm9ybWF0LiBJ
Zg0KPj4gc28sIHVzZSB0aGUgTUFDIGFkZHJlc3MuIFRoZXJlIG1heSBiZSBtdWx0aXBsZSBFRVBS
T01zIHdpdGggYW4gSUQgcGFnZQ0KPj4gb24gdGhpcyBwbGF0Zm9ybSwgYWx3YXlzIHVzZSB0aGUg
Zmlyc3Qgb25lLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBOaWVkZXJtYWllciA8
Y25pZWRlcm1haWVyQGRoLWVsZWN0cm9uaWNzLmNvbT4NCj4+IC0tLQ0KPj4gQ2M6ICJOWFAgaS5N
WCBVLUJvb3QgVGVhbSIgPHVib290LWlteEBueHAuY29tPg0KPj4gQ2M6IE1hcmVrIFZhc3V0IDxt
YXJleEBkZW54LmRlPg0KPj4gQ2M6IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4N
Cj4+IENjOiBTdGVmYW5vIEJhYmljIDxzYmFiaWNAZGVueC5kZT4NCj4+IENjOiBUb20gUmluaSA8
dHJpbmlAa29uc3Vsa28uY29tPg0KPj4gQ2M6IHUtYm9vdEBkaC1lbGVjdHJvbmljcy5jb20NCj4+
IC0tLQ0KPj4gICBib2FyZC9kaGVsZWN0cm9uaWNzL2NvbW1vbi9kaF9jb21tb24uYyAgICAgICAg
fCAxMTMgKysrKysrKysrKysrKysrKysrDQo+PiAgIGJvYXJkL2RoZWxlY3Ryb25pY3MvY29tbW9u
L2RoX2NvbW1vbi5oICAgICAgICB8ICAyMyArKysrDQo+PiAgIC4uLi9kaF9pbXg4bXAvaW14OG1w
X2RoY29tX3BkazIuYyAgICAgICAgICAgICB8ICAgNiArDQo+PiAgIDMgZmlsZXMgY2hhbmdlZCwg
MTQyIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYm9hcmQvZGhlbGVjdHJvbmlj
cy9jb21tb24vZGhfY29tbW9uLmMgYi9ib2FyZC9kaGVsZWN0cm9uaWNzL2NvbW1vbi9kaF9jb21t
b24uYw0KPj4gaW5kZXggMzJjNTBiNGYwZi4uOGVhNzBmYzk4NCAxMDA2NDQNCj4+IC0tLSBhL2Jv
YXJkL2RoZWxlY3Ryb25pY3MvY29tbW9uL2RoX2NvbW1vbi5jDQo+PiArKysgYi9ib2FyZC9kaGVs
ZWN0cm9uaWNzL2NvbW1vbi9kaF9jb21tb24uYw0KPj4gQEAgLTcsOSArNywyMiBAQA0KPj4gICAj
aW5jbHVkZSA8ZG0uaD4NCj4+ICAgI2luY2x1ZGUgPGkyY19lZXByb20uaD4NCj4+ICAgI2luY2x1
ZGUgPG5ldC5oPg0KPj4gKyNpbmNsdWRlIDx1LWJvb3QvY3JjLmg+DQo+Pg0KPj4gICAjaW5jbHVk
ZSAiZGhfY29tbW9uLmgiDQo+Pg0KPj4gK3N0cnVjdCBlZXByb21faWRfcGFnZSB7DQo+PiArICAg
ICB1OCAgICAgIGlkWzNdOyAgICAgICAgICAvKiBJZGVudGlmaWVyICdEJywgJ0gnLCAnRScgLSAn
RCcgaXMgYXQgaW5kZXggMCAqLw0KPj4gKyAgICAgdTggICAgICB2ZXJzaW9uOyAgICAgICAgLyog
MHgxMCAtLSBWZXJzaW9uIDEuMCAqLw0KPj4gKyAgICAgdTggICAgICBkYXRhX2NyYzE2WzJdOyAg
LyogWzFdIGlzIE1TYnl0ZSAqLw0KPj4gKyAgICAgdTggICAgICBoZWFkZXJfY3JjODsNCj4+ICsg
ICAgIHU4ICAgICAgbWFjMFs2XTsNCj4+ICsgICAgIHU4ICAgICAgbWFjMVs2XTsNCj4+ICsgICAg
IHU4ICAgICAgaXRlbV9wcmVmaXg7ICAgIC8qIEgvRiBpcyBjb2RlZCBpbiBNU2JpdHMsIFZlbmRv
ciBjb2Rpbmcgc3RhcnRzIGF0IExTYml0cyAqLw0KPj4gKyAgICAgdTggICAgICBpdGVtX251bVsz
XTsgICAgLyogWzJdIGlzIE1TYnl0ZSAqLw0KPj4gKyAgICAgdTggICAgICBzZXJpYWxbOV07ICAg
ICAgLyogWzhdIGlzIE1TYnl0ZSAqLw0KPj4gK30gX19wYWNrZWQ7DQo+IA0KPiBJcyBfX3BhY2tl
ZCBuZWVkZWQgPw0KDQpJIHdhbnQgdG8gYXZvaWQgcGFkZGluZyBpbiBhbnkgY2FzZS4NCg0KUmVn
YXJkcw0KQ2hyaXN0b3BoDQo=
