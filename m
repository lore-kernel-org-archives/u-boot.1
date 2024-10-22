Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDBFD1CDC7
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 09:33:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7910488F4B;
	Tue, 22 Oct 2024 11:33:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="VFppT++P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C75DC88F4B; Tue, 22 Oct 2024 11:33:27 +0200 (CEST)
Received: from mx2.securetransport.de (mx2.securetransport.de
 [IPv6:2a03:4000:13:6c7::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA2FF88D9C
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 11:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1729589469;
 bh=z2UHSG6hzXAEg76IuAdRnquICa4aisbQIqfsEcE79s4=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=VFppT++PTAWchVzAan39A3fpY79BzHVR32zAdkSnBA43vetpKTCSIIhch8mMOxAPE
 tBMLXX7jEh8kyudbiyrveBSAwSc5Wtb9hgrRO9hJiZDretxQSDPOrm9Qk6/wMhJ9xa
 rdbdKptuxhGtXzGnZi7kM1C1a1ucTro59pC7Jhx6DfbhGRz+7F9TjSrjHKea6Gbv+9
 ArorJF7R1OzZd8FJl6iJb2tB+VJVdOO5YAlomUMhjL5lMqieLsk3DfR4mGDhbN9HCm
 L7iF29e4J4ka0r7MPGxrKBI90ApkMZRs+w7ESCdo/wRvi/riekUL50M0g2bVDf/XsZ
 WunJmWF1tmULQ==
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
Thread-Index: AQHbGxfHmD5+3BWcGkWm07IML/aPr7KDeoyAgAXUiUCAAK5vAIAA1rQQgABasgCABjFZgIAAYh8AgADI4vA=
Date: Tue, 22 Oct 2024 09:31:08 +0000
Message-ID: <d06620ee891f4e419bfeb8fe657ba729@dh-electronics.com>
References: <20241010132337.3259-1-cniedermaier@dh-electronics.com>
 <20241010132337.3259-2-cniedermaier@dh-electronics.com>
 <934d25c2-39d8-4f51-b29e-8f20feb7431f@denx.de>
 <a305b1455a984fca83de5a6c0d4b8dfc@dh-electronics.com>
 <74bd0a6b-fe12-4e2c-af79-c1f8ffb7d484@denx.de>
 <73ccb69b85094e24be2343d5cbc8879a@dh-electronics.com>
 <17b9380b-39c0-40f2-bb28-319d26b2e13c@denx.de>
 <7b9b543d7aad498591fa6a04a3154cf8@dh-electronics.com>
 <a0f70ee2-6d71-4f66-b22e-994df2b28504@denx.de>
In-Reply-To: <a0f70ee2-6d71-4f66-b22e-994df2b28504@denx.de>
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
IDIyLCAyMDI0IDE6MDEgQU0NCj4gT24gMTAvMjEvMjQgNTozOCBQTSwgQ2hyaXN0b3BoIE5pZWRl
cm1haWVyIHdyb3RlOg0KPiANCj4gWy4uLl0NCj4gDQo+Pj4gSWYgeWVzLCB0aGVuIHRoZXJlIGlz
IG5vIG5lZWQgZm9yIGFueSBzdGF0aWMgdmFyaWFibGU6DQo+Pj4NCj4+PiBib2FyZF9pbml0KCkg
ew0KPj4+ICAgIHU4IGVlcHJvbVszMl07DQo+Pj4gICAgZGhfcmVhZF9lZXByb21fd2xwKGVlcHJv
bSk7IC8vIHJlYWQgdGhlIGVlcHJvbSBvbmNlDQo+Pj4gICAgZGhfc2V0dXBfbWFjX2FkZHJlc3Mo
ZWVwcm9tKTsgLy8gZXh0cmFjdCBNQUMgZnJvbSBFRVBST00NCj4+PiAgICBkaF9hZGRfaXRlbV9u
dW1iZXJfYW5kX3NlcmlhbF90b19lbnYoZWVwcm9tKTsgLy8gZXh0cmFjdCBTTiBmcm9tIEVFUFJP
TQ0KPj4+ICAgIC8vIG9uY2UgdGhpcyBmdW5jdGlvbiBleGl0cywgdGhlIGVlcHJvbSB2YXJpYWJs
ZSBvbiBzdGFjayBpcyBkaXNjYXJkZWQNCj4+PiAgICAvLyB3aGljaCBpcyBPSywgc2luY2UgaXQg
d29uJ3QgYmUgdXNlZCBhbnltb3JlIGFueXdheQ0KPj4+IH0NCj4+DQo+PiBUaGUgaWRlYSBpcyB0
aGF0IGZ1bmN0aW9uIGRoX2FkZF9pdGVtX251bWJlcl9hbmRfc2VyaWFsX3RvX2VudigpIGVuY2Fw
c3VsYXRlcw0KPj4gdGhlIHJlYWRpbmcuDQo+IA0KPiBUaGUgZnVuY3Rpb24gd2hpY2ggaW50ZXJh
Y3RzIHdpdGggdGhlIEVFUFJPTSBvbiBzdGFydCB1cCwgb25jZSwgY2FuIGhhdmUNCj4gdGhpcyBu
YW1lLCBzdXJlLg0KDQpTb3JyeSwgSSBtZWFuIHRoZSBmdW5jdGlvbiBkaF9nZXRfdmFsdWVfZnJv
bV9lZXByb21faWRfcGFnZSgpIGhlcmUuDQoNCj4+IEkgZG9uJ3Qgd2FudCB0byBoYXZlIHRvIHdv
cnJ5IGFib3V0IHRoZSBzdHJ1Y3R1cmUgYW5kIG51bWJlciBvZg0KPj4gYnl0ZXMgb2YgdGhlIEVF
UFJPTSBJRCBwYWdlIGFuZCB3YW50IHRvIGJlIGluZGVwZW5kZW50IG9mIGl0LiBJdCBpcyBwbGFu
bmVkIHRvDQo+PiBleHRlbmQgdGhlIHN0cnVjdHVyZSBhbmQgaW5jcmVhc2UgdGhlIG51bWJlciBv
ZiBieXRlcyBmb3IgdGhlIFNUTTMyTVAyLiBUaGUNCj4+IGNoYW5nZXMgdG8gdGhlIHNpemUgd2ls
bCB0aGVuIGRlcGVuZCBvbiB0aGUgdmVyc2lvbiBvZiB0aGUgZGF0YSBpbiB0aGUgaGVhZGVyDQo+
PiB3aXRoaW4gdGhlIHN0cnVjdHVyZS4NCj4gDQo+IEl0IGlzIE9LIHRvIGFsbG9jYXRlIDMyIG9y
IDY0IGJ5dGVzIG9uIHN0YWNrLCBzaW5jZSB0aGF0IGNodW5rIG9mIG1lbW9yeQ0KPiBpcyBmcmVl
J2Qgb24gcmV0dXJuIGZyb20gdGhlIGZ1bmN0aW9uLiBUaGUgbGlmZXNwYW4gb2YgdGhhdCBhbGxv
Y2F0ZWQNCj4gbWVtb3J5IGlzIGV4YWN0bHkgYXMgbG9uZyBhcyBpdCBzaG91bGQgYmUsIGFuZCBp
dCBkb2VzIG5vdCB3YXN0ZSBVLUJvb3QNCj4gbWVtb3J5IHVubmVjZXNzYXJpbHkuDQo+IA0KPiBT
byBmYXIsIGFsbCBrbm93biBFRVBST01zIGhhdmUgV0xQIHNpemUgb2YgMzIgb3IgNjQgQnllcy4N
Cj4gDQo+PiBIb3dldmVyLCB0aGVzZSBjaGFuZ2VzIHNob3VsZCB0aGVuIG9ubHkgaGF2ZSB0byBi
ZSBtYWRlDQo+PiB3aXRoaW4gdGhlIGZ1bmN0aW9uIGRoX2FkZF9pdGVtX251bWJlcl9hbmRfc2Vy
aWFsX3RvX2VudigpIGZvciByZWFkaW5nIHRoZQ0KPj4gRUVQUk9NIElEIHBhZ2UuIEkgYWNjZXB0
IHRoZSBzdGF0aWMgdmFyaWFibGUgaW4gb3JkZXIgdG8gYmV0dGVyIGlzb2xhdGUgdGhlDQo+PiBm
dW5jdGlvbi4NCg0KU29ycnksIGhlcmUgSSBtZWFuIGFsc28gdGhlIGZ1bmN0aW9uIGRoX2dldF92
YWx1ZV9mcm9tX2VlcHJvbV9pZF9wYWdlKCkuDQoNCj4gVGhpcyBjYW4gdmVyeSB3ZWxsIGJlOg0K
PiANCj4gZGhfYWRkX2l0ZW1fbnVtYmVyX2FuZF9zZXJpYWxfdG9fZW52KCkgew0KPiAgICAgdTgg
ZWVwcm9tWzMyXTsNCj4gICAgIGRoX3JlYWRfZWVwcm9tX3dscChlZXByb20pOyAvLyByZWFkIHRo
ZSBlZXByb20gb25jZQ0KPiAgICAgZGhfc2V0dXBfbWFjX2FkZHJlc3MoZWVwcm9tKTsgLy8gZXh0
cmFjdCBNQUMgZnJvbSBFRVBST00NCj4gICAgIGRoX2FkZF9pdGVtX251bWJlcl9hbmRfc2VyaWFs
X3RvX2VudihlZXByb20pOyAvLyBleHRyYWN0IFNOIGZyb20gRUVQUk9NDQo+ICAgICAvLyBvbmNl
IHRoaXMgZnVuY3Rpb24gZXhpdHMsIHRoZSBlZXByb20gdmFyaWFibGUgb24gc3RhY2sgaXMgZGlz
Y2FyZGVkDQo+ICAgICAvLyB3aGljaCBpcyBPSywgc2luY2UgaXQgd29uJ3QgYmUgdXNlZCBhbnlt
b3JlIGFueXdheQ0KPiB9DQo+IA0KPiBib2FyZF9pbml0KCkgew0KPiAgICAuLg0KPiAgICBkaF9h
ZGRfaXRlbV9udW1iZXJfYW5kX3NlcmlhbF90b19lbnYoKTsNCj4gICAgLi4uDQo+IH0NCj4gDQo+
PiBTaW5jZSB0aGUgbWVtb3J5IGlzIGZyZWVkIHVwIGFnYWluIHdoZW4gdGhlIG9wZXJhdGluZyBz
eXN0ZW0gYm9vdHMsDQo+PiB0aGlzIGNvbnN1bXB0aW9uIG9mIDMyIGJ5dGVzIGluIFUtQm9vdCBp
cyBub3QgYSBwcm9ibGVtLCBiZWNhdXNlIGl0IGlzIG9ubHkNCj4+IHRlbXBvcmFyeS4NCj4gVGhp
cyBpcyBub3QgZ29vZCwgcGxlYXNlIGRvIG5vdCB3YXN0ZSBtZW1vcnkgaW4gVS1Cb290IGlmIGl0
IGNhbiBiZQ0KPiBlYXNpbHkgYXZvaWRlZCBieSBhdXRvbWF0aWNhbGx5IGFsbG9jYXRpbmcgaXQg
b24gc3RhY2sgYW5kIGZyZWVpbmcgaXQNCj4gd2hlbiBub3QgbmVlZGVkLg0KPiANCj4gWy4uLl0N
Cg0KSSBkb24ndCB3YW50IHRvIGFsbG9jYXRlIHRoZSBtZW1vcnkgaW4gdGhlIGZ1bmN0aW9uIGJv
YXJkX2luaXQoKS4gSSB3YW50IHRvIGhhbmRsZQ0Kc2l6ZSBhbmQgY2FjaGluZyBpbiB0aGUgZnVu
Y3Rpb24gZGhfZ2V0X3ZhbHVlX2Zyb21fZWVwcm9tX2lkX3BhZ2UoKS4gU28gSSBkb24ndA0Kd2Fu
dCB0byBkZWFsIHdpdGggc2l6ZSBhbmQgc3RydWN0dXJlIGluIHRoZSBmdW5jdGlvbiBib2FyZF9p
bml0KCkuIEZvciBtZSwgdGhlIHVzZQ0Kb2YgYSBzdGF0aWMgdmFyaWFibGUgaXMgT0ssIGJ1dCB5
b3UgZG9uJ3QgbGlrZSBpdC4gRG8geW91IGtub3cgaG93IEkgY2FuIGRvIHRoaXMNCndpdGhvdXQg
YXNzaWduaW5nIGEgc3RhdGljIHZhcmlhYmxlLCBidXQgbm90IGFsbG9jYXRlIHRoZSBtZW1vcnkg
c29tZXdoZXJlIGluIGENCmNhbGxlciBmdW5jdGlvbj8NCg0KDQpSZWdhcmRzDQpDaHJpc3RvcGgN
Cg==
