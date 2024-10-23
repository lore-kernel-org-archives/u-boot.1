Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB95CF5386
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 13:20:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9E0B89266;
	Wed, 23 Oct 2024 15:20:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="jrwdN/dS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EC6E88FA5; Wed, 23 Oct 2024 15:20:38 +0200 (CEST)
Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3D9788F4B
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 15:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1729689623;
 bh=mFKsUzBkIdsQhNVxeWWUOIc5yjxmj0fXUKVNMBCYAjM=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=jrwdN/dSQqS1Eeklbt9Ttm7I4FJJUNDQzH/OejjB58TwwcDFSIljKPalsWTQ67ZgF
 bIVgNrIEIpaW24mXMdQQnd0MpotbcU4RJ+NYN0Ek3yc6CSqXSUISBazqwR/Rjo5k5a
 a+01zf8B7KmFX535UTwUPsqq99Cb/29ZKqPA+VUCAgWn3+b7tQObmUq9txwhP7obaN
 zvVdLUg7z8/Gu7wRzu+zJRxsvcVsiHMXA4iYq+YkO0VoIGYF/mKKkteA9F/5du7wj+
 2GqivVqDoDkxUaF4wNZxCNQ0YkYlPQw9l+W3GfKI8gqF1fXB2wolH2dC3rZA692gcu
 lZejjQDGPgsVA==
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
Thread-Index: AQHbGxfHmD5+3BWcGkWm07IML/aPr7KDeoyAgAXUiUCAAK5vAIAA1rQQgABasgCABjFZgIAAYh8AgADI4vCAABAiAIABs80Q///qwYCAACbfkA==
Date: Wed, 23 Oct 2024 13:20:21 +0000
Message-ID: <95c20aac320049eda6a324d360743691@dh-electronics.com>
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
 <bef41c1fefeb422e9e1b8f8f0d241a13@dh-electronics.com>
 <1fd571bc-d133-4e91-8ab6-45e6e7429027@denx.de>
In-Reply-To: <1fd571bc-d133-4e91-8ab6-45e6e7429027@denx.de>
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

RnJvbTogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQpTZW50OiBXZWRuZXNkYXksIE9jdG9i
ZXIgMjMsIDIwMjQgMjo0MSBQTQ0KPiBPbiAxMC8yMy8yNCAyOjE4IFBNLCBDaHJpc3RvcGggTmll
ZGVybWFpZXIgd3JvdGU6DQo+IA0KPiBbLi4uXQ0KPiANCj4+PiBZb3UgZG8gbm90LCB0aGUgZm9s
bG93aW5nIGF1dG9tYXRpY2FsbHkgcmVzZXJ2ZXMgc3BhY2Ugb24gc3RhY2sgd2hlbg0KPj4+IGNh
bGxlZCBhbmQgZnJlZXMgaXQgdXAgdXBvbiBmdW5jdGlvbiByZXR1cm46DQo+Pj4NCj4+PiBmdW5j
dGlvbiBmb28oKSB7DQo+Pj4gICAgIHU4IGFycmF5WzEyXTsNCj4+PiAgICAgLi4uDQo+Pj4gICAg
IHN0dWZmKGFycmF5KTsNCj4+PiAgICAgLi4uDQo+Pj4gfQ0KPj4NCj4+IFNvcnJ5LCBJIGV4cHJl
c3NlZCBteXNlbGYgaW5jb3JyZWN0bHkgaGVyZS4gT2YgY291cnNlIEkgbWVhbnQgdGhhdA0KPj4g
SSBkb24ndCB3YW50IHRvIHJlc2VydmUgbWVtb3J5IG9uIHRoZSBzdGFjayBmb3IgdGhlIEVFUFJP
TSBJRCBwYWdlDQo+PiBpbiB0aGUgYm9hcmRfaW5pdCgpIGZ1bmN0aW9uLg0KPiANCj4gV2h5ID8N
Cg0KSXQncyBhYm91dCBzdHJ1Y3R1cmluZyB0aGUgc29mdHdhcmUuIEkgd2FudCB0byBpc29sYXRl
IHRoZSBmdW5jdGlvbiB3aGljaA0KaXMgcmVzcG9uc2libGUgZm9yIGV2YWx1YXRlIHRoZSBFRVBS
T00gZnJvbSB0aGUgY2FsbGVyIGZ1bmN0aW9uLiBJIHdhbnRlZA0KdG8gYXZvaWQgZW50YW5nbGlu
ZyB0aGUgdHdvLiBUaGlzIG1lYW5zIHRoYXQgSSwgYXMgdGhlIGNhbGxlciBvZiB0aGUgZnVuY3Rp
b24sDQpkbyBub3QgaGF2ZSB0byB3b3JyeSBhYm91dCB0aGUgaW50ZXJuYWwgc3RydWN0dXJlIG9m
IHRoZSBFRVBST00gSUQgcGFnZS4NCg0KPj4+PiBJIHdhbnQgdG8gaGFuZGxlDQo+Pj4+IHNpemUg
YW5kIGNhY2hpbmcgaW4gdGhlIGZ1bmN0aW9uIGRoX2dldF92YWx1ZV9mcm9tX2VlcHJvbV9pZF9w
YWdlKCkuIFNvIEkgZG9uJ3QNCj4+Pj4gd2FudCB0byBkZWFsIHdpdGggc2l6ZSBhbmQgc3RydWN0
dXJlIGluIHRoZSBmdW5jdGlvbiBib2FyZF9pbml0KCkuIEZvciBtZSwgdGhlIHVzZQ0KPj4+PiBv
ZiBhIHN0YXRpYyB2YXJpYWJsZSBpcyBPSywgYnV0IHlvdSBkb24ndCBsaWtlIGl0LiBEbyB5b3Ug
a25vdyBob3cgSSBjYW4gZG8gdGhpcw0KPj4+PiB3aXRob3V0IGFzc2lnbmluZyBhIHN0YXRpYyB2
YXJpYWJsZSwgYnV0IG5vdCBhbGxvY2F0ZSB0aGUgbWVtb3J5IHNvbWV3aGVyZSBpbiBhDQo+Pj4+
IGNhbGxlciBmdW5jdGlvbj8NCj4+PiBFdmVuIHRoZSBzdGF0aWMgdmFyaWFibGUgc3BhY2UgaXMg
YWxsb2NhdGVkIHNvbWV3aGVyZSwgZWl0aGVyIGluIC5ic3Mgb3INCj4+PiAuZGF0YSBzZWN0aW9u
LCBleGNlcHQgd2l0aCBzdGF0aWMgdmFyaWFibGUocykgdGhlIG1lbW9yeSBwZXJzaXN0cw0KPj4+
IHRocm91Z2hvdXQgdGhlIGxpZmV0aW1lIG9mIFUtQm9vdCBiZWNhdXNlIHRoZWlyIGNvbnRlbnQg
aGFzIHRvIGJlDQo+Pj4gcmV0YWluZWQgZXZlbiB3aGVuIHRoZSBmdW5jdGlvbiB1c2luZyB0aGVp
ciBjb250ZW50IHJldHVybnMuDQo+Pj4NCj4+PiBXaXRoIHZhcmlhYmxlKHMpIGFsbG9jYXRlZCBv
biBzdGFjayAod2hpY2ggaXMgbWFqb3JpdHkgb2YgdmFyaWFibGUpLCB0aGUNCj4+PiBtZW1vcnkg
YWxsb2NhdGlvbiBoYXBwZW5zIG9uIGVudHJ5IHRvIHRoZSBmdW5jdGlvbiBhbmQgdGhlIG1lbW9y
eSBpcw0KPj4+IGF1dG9tYXRpY2FsbHkgZnJlZWQgb24gZXhpdCBmcm9tIHRoZSBmdW5jdGlvbi4N
Cj4+Pg0KPj4+IEl0IGlzIHBlcmZlY3RseSBmaW5lIHRvIGNhbGwgc29tZSB3cmFwcGVyIHN1cGVy
ZnVuY3Rpb24gZnJvbQ0KPj4+IGJvYXJkX2luaXQoKSB3aGljaCBob2xkcyB0aGUgYXJyYXkgb24g
c3RhY2sgYW5kIGNhbGxzIGFsbCB0aGUgRUVQUk9NDQo+Pj4gcGFyc2VyL2hhbmRsZXIgZnVuY3Rp
b25zOg0KPj4+DQo+Pj4gZWVwcm9tX3N1cGVyd3JhcHBlcigpIHsNCj4+PiAgICAgdTggZWVwcm9t
WzY0XTsNCj4+PiAgICAgLi4uDQo+Pj4gICAgIGVlcHJvbV9kb19zdHVmZjEoZWVwcm9tKTsNCj4+
PiAgICAgZWVwcm9tX2RvX3N0dWZmMihlZXByb20pOw0KPj4+ICAgICAuLi4NCj4+PiB9DQo+Pj4N
Cj4+PiBib2FyZF9pbml0KCkgew0KPj4+ICAgICAuLi4NCj4+PiAgICAgZWVwcm9tX3N1cGVyd3Jh
cHBlcigpOw0KPj4+ICAgICAuLi4NCj4+PiB9DQo+Pg0KPj4gVGhhdCdzIG5vdCB3aGF0IEknbSBs
b29raW5nIGZvci4gRG8geW91IGhhdmUgYW5vdGhlciBzb2x1dGlvbj8NCj4gTm8uIEkgZG8gbm90
IHVuZGVyc3RhbmQgd2hhdCBpcyB0aGUgcHJvYmxlbSB3aXRoIGFsbG9jYXRpbmcgNjQgQnl0ZXMg
b24NCj4gc3RhY2sgPw0KDQpUaGVyZSBpcyBubyBwcm9ibGVtIHdpdGggdGhlIHJlc2VydmF0aW9u
IG9mIHRoZSBFRVBST00gYnVmZmVyIG9uIHRoZQ0Kc3RhY2suIEkgd2FudGVkIHRvIGlzb2xhdGUg
dGhlIGV2YWx1YXRpb24gZnVuY3Rpb24gZnJvbSB0aGUgY2FsbGVyDQpmdW5jdGlvbiwgc28gdGhh
dCBJIGhhdmUgbm8gZGVwZW5kZW5jaWVzIG9uIHRoZSBjYWxsZXIuIFNpbmNlIHRoZXJlDQpzZWVt
cyB0byBiZSBubyBiZXR0ZXIgc29sdXRpb24sIEkgd2lsbCBhZGQgdGhlIHZhcmlhYmxlIHRvIHRo
ZQ0KYm9hcmRfaW5pdCgpIGZ1bmN0aW9uIGluIFYyLg0KDQoNClJlZ2FyZHMNCkNocmlzdG9waA0K
