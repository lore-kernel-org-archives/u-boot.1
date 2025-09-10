Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF67CA0FED
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 13:21:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 835328318E;
	Wed, 10 Sep 2025 15:21:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="TGwyDgGN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75DAB8319C; Wed, 10 Sep 2025 15:21:00 +0200 (CEST)
Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71E49830B4
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 15:20:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1757510453;
 bh=LYUnsWuMGv3pfP6yNkKrg7o4lB6E0Kl2y7TODzhHFHE=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=TGwyDgGNKVmX2+kbTpYSbwhNpl11e7YKB7rptA5YpEw0wgd/TvvPRhVmnEfNUTYIh
 C1fnPW0nshXlogP6ZX/5Cx7XCDhGXFr5zGx/5kGcMpMgtYOrSS8XpqgUc612vTl5yH
 Iz+mLoiEcVSXtymuNg5E0Kd2fxSyNxHSnDCMFJyEq5B3aqfU5muNXt496gkxOjDWKd
 B4t/pnROegT8age0EA4MIaxHR781NcRt9aHHxl75XChlG0Pt0Ts/z8AaSJMS+n3XXl
 ewRxP5vYOkaCmBCLNQ976/pWaQdWP9Vsr62dvaWQPFSn/cUhZhWqwLzgBum3zguY7U
 S7oib5KUHwxeg==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Marek Vasut <marek.vasut@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH 2/2] board: dhelectronics: Use isascii() before isprint()
 in dh_read_eeprom_id_page()
Thread-Topic: [PATCH 2/2] board: dhelectronics: Use isascii() before isprint()
 in dh_read_eeprom_id_page()
Thread-Index: AQHcH5L0j1PwsYiH8kK2MhqXemD/qbSMa4fg
Date: Wed, 10 Sep 2025 13:20:52 +0000
Message-ID: <581a80daec794054907b009ab249c3d1@dh-electronics.com>
References: <20250907010103.667681-1-marek.vasut@mailbox.org>
 <20250907010103.667681-2-marek.vasut@mailbox.org>
In-Reply-To: <20250907010103.667681-2-marek.vasut@mailbox.org>
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
LCBTZXB0ZW1iZXIgNywgMjAyNSAzOjAxIEFNDQo+IFRoZSBpc3ByaW50KCkgY2hlY2tzIHByaW50
YWJpbGl0eSBhY3Jvc3MgYWxsIDI1NiBjaGFyYWN0ZXJzLCBzb21lIG9mIHRoZQ0KPiB1cHBlciAx
MjggY2hhcmFjdGVycyBhcmUgcHJpbnRhYmxlIGFuZCBwcm9kdWNlIGFydGlmYWN0cyBvbiBVQVJU
LiBDYWxsDQo+IGlzYXNjaWkoKSBmaXJzdCB0byBvbmx5IGNvbnNpZGVyIHRoZSBib3R0b20gN2Jp
dCBBU0NJSSBjaGFyYWN0ZXJzIGFzDQo+IHByaW50YWJsZSwgYW5kIHRoZW4gY2hlY2sgdGhlaXIg
cHJpbnRhYmlsaXR5IHVzaW5nIGlzcHJpbnQoKS4gVGhpcyBmaXhlcw0KPiBhIHJhcmUgbWlzcHJp
bnQgaW4gY2FzZSB0aGUgSUQgcGFnZSBjb250ZW50IGlzIHVuaW5pdGlhbGl6ZWQgb3IgY29ycnVw
dGVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFyZWsgVmFzdXQgPG1hcmVrLnZhc3V0QG1haWxi
b3gub3JnPg0KPiAtLS0NCj4gQ2M6IENocmlzdG9waCBOaWVkZXJtYWllciA8Y25pZWRlcm1haWVy
QGRoLWVsZWN0cm9uaWNzLmNvbT4NCj4gQ2M6IFNpbW9uIEdsYXNzIDxzamdAY2hyb21pdW0ub3Jn
Pg0KPiBDYzogVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT4NCj4gLS0tDQo+ICBib2FyZC9k
aGVsZWN0cm9uaWNzL2NvbW1vbi9kaF9jb21tb24uYyB8IDYgKysrLS0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2JvYXJkL2RoZWxlY3Ryb25pY3MvY29tbW9uL2RoX2NvbW1vbi5jDQo+IGIvYm9hcmQvZGhlbGVj
dHJvbmljcy9jb21tb24vZGhfY29tbW9uLmMNCj4gaW5kZXggYWVhYmQ2MTczNzQuLmU3ZWUyM2Fh
OGNlIDEwMDY0NA0KPiAtLS0gYS9ib2FyZC9kaGVsZWN0cm9uaWNzL2NvbW1vbi9kaF9jb21tb24u
Yw0KPiArKysgYi9ib2FyZC9kaGVsZWN0cm9uaWNzL2NvbW1vbi9kaF9jb21tb24uYw0KPiBAQCAt
ODgsOSArODgsOSBAQCBpbnQgZGhfcmVhZF9lZXByb21faWRfcGFnZSh1OCAqZWVwcm9tX2J1ZmZl
ciwgY29uc3QgY2hhciAqYWxpYXMpDQo+ICAgICAgICAgLyogVmFsaWRhdGUgaGVhZGVyIElEICov
DQo+ICAgICAgICAgaWYgKGVpcC0+aGRyLmlkWzBdICE9ICdEJyB8fCBlaXAtPmhkci5pZFsxXSAh
PSAnSCcgfHwgZWlwLT5oZHIuaWRbMl0gIT0gJ0UnKSB7DQo+ICAgICAgICAgICAgICAgICBwcmlu
dGYoIiVzOiBFcnJvciB2YWxpZGF0aW5nIGhlYWRlciBJRCEgKGdvdCAlYyVjJWMgKDB4JTAyeCAw
eCUwMnggMHglMDJ4KQ0KPiAhPSBleHBlY3RlZCBESEUpXG4iLA0KPiAtICAgICAgICAgICAgICAg
ICAgICAgIF9fZnVuY19fLCBpc3ByaW50KGVpcC0+aGRyLmlkWzBdKSA/IGVpcC0+aGRyLmlkWzBd
IDogJy4nLA0KPiAtICAgICAgICAgICAgICAgICAgICAgIGlzcHJpbnQoZWlwLT5oZHIuaWRbMV0p
ID8gZWlwLT5oZHIuaWRbMV0gOiAnLicsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgaXNwcmlu
dChlaXAtPmhkci5pZFsyXSkgPyBlaXAtPmhkci5pZFsyXSA6ICcuJywNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICBfX2Z1bmNfXywgKGlzYXNjaWkoZWlwLT5oZHIuaWRbMF0pICYmIGlzcHJpbnQo
ZWlwLT5oZHIuaWRbMF0pKSA/DQo+IGVpcC0+aGRyLmlkWzBdIDogJy4nLA0KPiArICAgICAgICAg
ICAgICAgICAgICAgIChpc2FzY2lpKGVpcC0+aGRyLmlkWzFdKSAmJiBpc3ByaW50KGVpcC0+aGRy
LmlkWzFdKSkgPyBlaXAtDQo+ID5oZHIuaWRbMV0gOiAnLicsDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgKGlzYXNjaWkoZWlwLT5oZHIuaWRbMl0pICYmIGlzcHJpbnQoZWlwLT5oZHIuaWRbMl0p
KSA/IGVpcC0NCj4gPmhkci5pZFsyXSA6ICcuJywNCj4gICAgICAgICAgICAgICAgICAgICAgICBl
aXAtPmhkci5pZFswXSwgZWlwLT5oZHIuaWRbMV0sIGVpcC0+aGRyLmlkWzJdKTsNCj4gICAgICAg
ICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiAgICAgICAgIH0NCg0KUmV2aWV3ZWQtYnk6IENo
cmlzdG9waCBOaWVkZXJtYWllciA8Y25pZWRlcm1haWVyQGRoLWVsZWN0cm9uaWNzLmNvbT4NCg==
