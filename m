Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B26C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 08:36:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 408B782D06;
	Tue, 29 Jul 2025 10:35:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="c/RzX7jC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B80E82D21; Tue, 29 Jul 2025 10:35:58 +0200 (CEST)
Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 623C482CBB
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 10:35:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1753778153;
 bh=n1A8ZiEmJ5Q56Pz10hKQ58JKErFIRFiSR3eD14APFao=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=c/RzX7jCphWeDgsA74SdyWgNV+Qw247MIluFyX1YKjU9t2wWqOYqdT8p5cQNznEQL
 00BYH84257FCLXDg+7cGSY+qi7FZKHXYdhhyFquA/OrnC51+1ZvOn1gUza8GunoQQg
 uVJPI1Lyw/e2g3tb8NzifFYUFeI4AFamm8JAjYGieeWeuDpInZAh1PZXl/DjcyDcL7
 jc8CXLuNzrNitfE8IO9UaYi4VoQrwpbFT5EOekAI+0930+r5lOMnA1z7fAt3JggZ1q
 GDRr1hbqzEqCdIup0hIqPsrFWNMHFcVwbTPEK/u10lPz4/LbzIF5dT34T140RaKyML
 0Vujvh2CpXYmA==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Marek Vasut <marek.vasut@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Andreas Geisreiter <ageisreiter@dh-electronics.com>, Tom Rini
 <trini@konsulko.com>, u-boot <u-boot@dh-electronics.com>
Subject: RE: [PATCH] ARM: imx6: dh-imx6: Enable USB OTG ID pin pull up in SPL
Thread-Topic: [PATCH] ARM: imx6: dh-imx6: Enable USB OTG ID pin pull up in SPL
Thread-Index: AQHcABBsPy4g2HEyUEOteLu5JrblmrRIwglA
Date: Tue, 29 Jul 2025 08:35:50 +0000
Message-ID: <36dd6e00451644cab6af925423b03315@dh-electronics.com>
References: <20250728223849.87212-1-marek.vasut@mailbox.org>
In-Reply-To: <20250728223849.87212-1-marek.vasut@mailbox.org>
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

RnJvbTogTWFyZWsgVmFzdXQgPG1hcmVrLnZhc3V0QG1haWxib3gub3JnPg0KU2VudDogVHVlc2Rh
eSwgSnVseSAyOSwgMjAyNSAxMjozOSBBTQ0KPiBFbmFibGUgU29DIHB1bGwgdXAgZm9yIFVTQiBP
VEcgSUQgcGluIGluIFNQTC4gVGhlcmUgaXMgbm8gZGVkaWNhdGVkIHB1bGwgdXANCj4gcmVzaXN0
b3Igb24gdGhlIFNvTSBpdHNlbGYsIGFuZCB0aGUgcHVsbCB1cCBpcyBtYW5kYXRvcnkgZm9yIGNv
cnJlY3QgVVNCIE9URw0KPiBJRCBwaW4gZGV0ZWN0aW9uLiBVLUJvb3QgcHJvcGVyIGFscmVhZHkg
Y29uZmlndXJlcyB0aGUgVVNCIE9URyBJRCBwaW4gcHVsbA0KPiB1cCB2aWEgRFQgcGluY3RybCBu
b2RlIGVudHJ5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFyZWsgVmFzdXQgPG1hcmVrLnZhc3V0
QG1haWxib3gub3JnPg0KPiAtLS0NCj4gQ2M6IEFuZHJlYXMgR2Vpc3JlaXRlciA8YWdlaXNyZWl0
ZXJAZGgtZWxlY3Ryb25pY3MuZGU+DQo+IENjOiBDaHJpc3RvcGggTmllZGVybWFpZXIgPGNuaWVk
ZXJtYWllckBkaC1lbGVjdHJvbmljcy5jb20+DQo+IENjOiBUb20gUmluaSA8dHJpbmlAa29uc3Vs
a28uY29tPg0KPiBDYzogdS1ib290QGRoLWVsZWN0cm9uaWNzLmNvbQ0KPiBDYzogdS1ib290QGxp
c3RzLmRlbnguZGUNCj4gLS0tDQo+ICBib2FyZC9kaGVsZWN0cm9uaWNzL2RoX2lteDYvZGhfaW14
Nl9zcGwuYyB8IDYgKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYm9hcmQvZGhlbGVjdHJvbmljcy9kaF9p
bXg2L2RoX2lteDZfc3BsLmMNCj4gYi9ib2FyZC9kaGVsZWN0cm9uaWNzL2RoX2lteDYvZGhfaW14
Nl9zcGwuYw0KPiBpbmRleCBhNTA3NjNlMTkyNi4uZWI5YmM5M2Q5NzMgMTAwNjQ0DQo+IC0tLSBh
L2JvYXJkL2RoZWxlY3Ryb25pY3MvZGhfaW14Ni9kaF9pbXg2X3NwbC5jDQo+ICsrKyBiL2JvYXJk
L2RoZWxlY3Ryb25pY3MvZGhfaW14Ni9kaF9pbXg2X3NwbC5jDQo+IEBAIC00OSw2ICs0OSwxMCBA
QA0KPiAgICAgICAgIChQQURfQ1RMX1BVU180N0tfVVAgfCBQQURfQ1RMX1NQRUVEX0xPVyB8IFBB
RF9DVExfRFNFXzgwb2htIHwgICBcDQo+ICAgICAgICAgIFBBRF9DVExfU1JFX0ZBU1QgfCBQQURf
Q1RMX0hZUykNCj4gDQo+ICsjZGVmaW5lIE9UR19QQURfQ1RSTCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gKyAgICAgICAoUEFEX0NUTF9QVVNf
MTAwS19VUCB8IFBBRF9DVExfU1BFRURfTUVEIHwgUEFEX0NUTF9EU0VfNDBvaG0gfCAgXA0KPiAr
ICAgICAgICBQQURfQ1RMX1NSRV9TTE9XIHwgUEFEX0NUTF9IWVMpDQo+ICsNCj4gIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgbXg2ZHFfaW9tdXhfZGRyX3JlZ3MgZGhjb202ZHFfZGRyX2lvcmVncyA9IHsN
Cj4gICAgICAgICAuZHJhbV9zZGNsa18wICAgPSAweDAwMDIwMDMwLA0KPiAgICAgICAgIC5kcmFt
X3NkY2xrXzEgICA9IDB4MDAwMjAwMzAsDQo+IEBAIC01MDksNyArNTEzLDcgQEAgaW50IGJvYXJk
X21tY19pbml0KHN0cnVjdCBiZF9pbmZvICpiaXMpDQo+IA0KPiAgLyogVVNCICovDQo+ICBzdGF0
aWMgaW9tdXhfdjNfY2ZnX3QgY29uc3QgdXNiX3BhZHNbXSA9IHsNCj4gLSAgICAgICBJT01VWF9Q
QURTKFBBRF9HUElPXzFfX1VTQl9PVEdfSUQgICAgICAgfCBNVVhfUEFEX0NUUkwoTk9fUEFEX0NU
UkwpKSwNCj4gKyAgICAgICBJT01VWF9QQURTKFBBRF9HUElPXzFfX1VTQl9PVEdfSUQgICAgICAg
fCBNVVhfUEFEX0NUUkwoT1RHX1BBRF9DVFJMKSksDQo+ICAgICAgICAgSU9NVVhfUEFEUyhQQURf
RUlNX0QzMV9fR1BJTzNfSU8zMSAgICAgIHwgTVVYX1BBRF9DVFJMKE5PX1BBRF9DVFJMKSksDQo+
ICB9Ow0KDQpUZXN0ZWQtYnk6IENocmlzdG9waCBOaWVkZXJtYWllciA8Y25pZWRlcm1haWVyQGRo
LWVsZWN0cm9uaWNzLmNvbT4NCg==
