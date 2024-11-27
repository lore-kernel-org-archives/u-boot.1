Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CEFD6ACF9
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 17:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F0A0897E6;
	Wed, 27 Nov 2024 18:27:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="w3OKLzlc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 140C6897C1; Wed, 27 Nov 2024 16:29:15 +0100 (CET)
Received: from mx2.securetransport.de (mx2.securetransport.de
 [IPv6:2a03:4000:13:6c7::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9C2A897C1
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 16:29:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pzimmermann@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1732721347;
 bh=2CmUZRKWX1MFxCBnPhSfh7wWFt9MjqP+Egh37+CUFDA=;
 h=From:To:CC:Subject:Date:From;
 b=w3OKLzlcNmIVpfp15syxKNnswULWM5Gt1gFPt/6h3HvUz9wdRbSqTl/rJSdo/nMbT
 yg2aMc745WUBhHX30ilsN0UDvbApvvlswN+/Ng5EDpJB4ALykWvFLkz+o2Br/ScZCG
 2eA0AF+mNVX0FCA1mn5BGnFPDm4FfZ0R1OEOtlKB7GiYd2hOMTA9PGSYH/Tw424z57
 eQ3D8j6JKiwz+CDSDYZK9yTo1ik2ijAKgvT7rY89snwne0uPOCXlep3gKrjf3X1Xwm
 uPr8SDThoCzO4X750yclW3mKYlCGOIuUNWQdbLNWJd/psIwtMKJUhKG6yycVL7gDZp
 beojvFzLLHqHQ==
X-secureTransport-forwarded: yes
From: Pascal Zimmermann <pzimmermann@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Simon Glass <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH 1/2] config_distro_bootcmd: make possible to substitute
 'part list' in distro_bootcmd
Thread-Topic: [PATCH 1/2] config_distro_bootcmd: make possible to substitute
 'part list' in distro_bootcmd
Thread-Index: AdtA31t8WFBCNxZFTWOa9j5CkUfgdw==
Date: Wed, 27 Nov 2024 15:29:05 +0000
Message-ID: <9ee7f1fc7c77445b85348555f705a774@dh-electronics.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 27 Nov 2024 18:27:29 +0100
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

SGVsbG8gU2ltb24sDQoNCk9uIFdlZCwgMjcgTm92IDIwMjQgYXQgMTQ6MDgsIFNpbW9uIEdsYXNz
IDxzamdAY2hyb21pdW0ub3JnPiB3cm90ZToNCj4gDQo+IEhpIFBhc2NhbCwNCj4gDQo+IE9uIFdl
ZCwgMjcgTm92IDIwMjQgYXQgMDM6MzAsIFBhc2NhbCBaaW1tZXJtYW5uIDxwemltbWVybWFubkBk
aC0NCj4gZWxlY3Ryb25pY3MuY29tPiB3cm90ZToNCj4gPg0KPiA+IE1ha2UgaXQgcG9zc2libGUg
dG8gc3Vic3RpdHV0ZSB0aGUgJ3BhcnQgbGlzdCcgY29tbWFuZCBpbnNpZGUNCj4gPiAnc2Nhbl9k
ZXZfZm9yX2Jvb3RfcGFydCcgd2l0aCBhIGN1c3RvbSBib2FyZCBzcGVjaWZpYyBpbXBsZW1lbnRh
dGlvbi4NCj4gPg0KPiA+IEZvciB0aGlzIHRoZSBuZXcgZGVmaW5lICdTQ0FOX0RFVl9GT1JfQk9P
VF9QQVJUUycgaXMgaW50cm9kdWNlZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBhc2NhbCBa
aW1tZXJtYW5uIDxwemltbWVybWFubkBkaC1lbGVjdHJvbmljcy5jb20+DQo+ID4gLS0tDQo+ID4g
Q2M6IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+DQo+ID4gQ2M6IFNpbW9uIEdsYXNzIDxz
amdAY2hyb21pdW0ub3JnPg0KPiA+IENjOiB1LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiA+IC0tLQ0K
PiA+ICBpbmNsdWRlL2NvbmZpZ19kaXN0cm9fYm9vdGNtZC5oIHwgNyArKysrKystDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IEhhdmUg
eW91IGxvb2tlZCBhdCBjb252ZXJ0aW5nIHRoZSBib2FyZCB0byBzdGFuZGFyZCBib290Pw0KDQpX
ZSBhcmUgYXQgaW50ZXJuYWwgZGlzY3Vzc2lvbiBhYm91dCB0aGUgc3dpdGNoIHRvIHN0YW5kYXJk
IGJvb3QNCmZvciBvdXIgYm9hcmRzLCBidXQgdGhpcyB3aWxsIHRha2Ugc29tZSB0aW1lLg0KDQo+
IA0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvY29uZmlnX2Rpc3Ryb19ib290Y21kLmgN
Cj4gPiBiL2luY2x1ZGUvY29uZmlnX2Rpc3Ryb19ib290Y21kLmggaW5kZXggMGE0ZTRiOGZmOC4u
ZGYwZGM4Y2ZkZSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2NvbmZpZ19kaXN0cm9fYm9vdGNt
ZC5oDQo+ID4gKysrIGIvaW5jbHVkZS9jb25maWdfZGlzdHJvX2Jvb3RjbWQuaA0KPiA+IEBAIC0x
OTQsNiArMTk0LDExIEBADQo+ID4gICNkZWZpbmUgU0NBTl9ERVZfRk9SX0VGSQ0KPiA+ICAjZW5k
aWYNCj4gPg0KPiA+ICsjaWZuZGVmIFNDQU5fREVWX0ZPUl9CT09UX1BBUlRTDQo+ID4gKyNkZWZp
bmUgU0NBTl9ERVZfRk9SX0JPT1RfUEFSVFMgXA0KPiA+ICsgICAgICAgInBhcnQgbGlzdCAke2Rl
dnR5cGV9ICR7ZGV2bnVtfSAtYm9vdGFibGUgZGV2cGxpc3Q7ICINCj4gPiArI2VuZGlmDQo+ID4g
Kw0KPiA+ICAjaWZkZWYgQ09ORklHX1NBVEENCj4gPiAgI2RlZmluZSBCT09URU5WX1NIQVJFRF9T
QVRBICAgIEJPT1RFTlZfU0hBUkVEX0JMS0RFVihzYXRhKQ0KPiA+ICAjZGVmaW5lIEJPT1RFTlZf
REVWX1NBVEEgICAgICAgQk9PVEVOVl9ERVZfQkxLREVWDQo+ID4gQEAgLTUzOCw3ICs1NDMsNyBA
QA0KPiA+ICAgICAgICAgICAgICAgICAiXDAiICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiA+ICAgICAgICAgXA0KPiA+ICAgICAgICAgInNj
YW5fZGV2X2Zvcl9ib290X3BhcnQ9IiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXA0KPiA+IC0gICAgICAgICAgICAgICAicGFydCBsaXN0ICR7ZGV2dHlwZX0gJHtkZXZu
dW19IC1ib290YWJsZSBkZXZwbGlzdDsgIiAgICAgXA0KPiA+ICsgICAgICAgICAgICAgICBTQ0FO
X0RFVl9GT1JfQk9PVF9QQVJUUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0K
PiA+ICAgICAgICAgICAgICAgICAiZW52IGV4aXN0cyBkZXZwbGlzdCB8fCBzZXRlbnYgZGV2cGxp
c3QgMTsgIiAgICAgICAgICAgICAgXA0KPiA+ICAgICAgICAgICAgICAgICAiZm9yIGRpc3Ryb19i
b290cGFydCBpbiAke2RldnBsaXN0fTsgZG8gIiAgICAgICAgICAgICAgICAgXA0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICJpZiBmc3R5cGUgJHtkZXZ0eXBlfSAiICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXA0KPiA+IC0tDQo+ID4gMi4zMC4yDQo+ID4NCj4gDQo+IFJlZ2FyZHMsDQo+
IFNpbW9uDQoNCkJlc3QgcmVnYXJkcywNClBhc2NhbA0K
