Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7333310A62CB
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 13:34:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1C3D81E18;
	Thu, 26 Mar 2026 14:34:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="wcn6E7t+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC81883CF5; Thu, 26 Mar 2026 14:34:32 +0100 (CET)
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EA7080517
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 14:34:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1774532063;
 bh=rFswUFzx81PlSTAYeabjYZAqEYHz5YdGFY5g6WUNDM8=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=wcn6E7t+QhvYUweKuwIQnAvtydTtowCEGvY7whVXFZOPIwFww7c3T/YMqBuzAPrb+
 Aa7tgfUH6xt4skEBc33LIhHSyAcgzs3GqinYrlZ+V+LNLzYrI8WpnWAeAfGQg/hbMm
 DirSDxYXvWgxrc3f62op4X5Yn5S6P2NPNJbx3v7p3TRiMsaj0vj9UqkgkKuVYx0FnT
 f1dHqSm/jQ3Wq3MgRvjX9+SO/W1ERo8DRqi84HVblnrybxTqQFNthSFEN5yqlmDmKQ
 4kEGMX6WZUOSG8Xc4BtoEAnRHX8L0OQazgJz5iEOwpAmM80uZnwpeF8lynFNUk0xEl
 zDrQjR0z+S0gg==
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
Thread-Index: AQHcuFTCAYeM+Dh5A0K4haKIts4CsrW8VUEAgASES0A=
Date: Thu, 26 Mar 2026 13:34:21 +0000
Message-ID: <b42cfbe814b24a54a0758b2e37c4353c@dh-electronics.com>
References: <20260320102918.4011-1-cniedermaier@dh-electronics.com>
 <b5b04334-704e-49aa-819d-c6500e82e35f@nabladev.com>
In-Reply-To: <b5b04334-704e-49aa-819d-c6500e82e35f@nabladev.com>
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

RnJvbTogTWFyZWsgVmFzdXQgPG1hcmV4QG5hYmxhZGV2LmNvbT4NClNlbnQ6IE1vbmRheSwgTWFy
Y2ggMjMsIDIwMjYgNjozNSBQTQ0KPiBPbiAzLzIwLzI2IDExOjI5IEFNLCBDaHJpc3RvcGggTmll
ZGVybWFpZXIgd3JvdGU6DQo+IA0KPiBbLi4uXQ0KPiANCj4+ICtpbnQgZGhfaW14X2dldF9tYWNf
ZnJvbV9mdXNlKGludCBkZXZfaWQsIHVuc2lnbmVkIGNoYXIgKmVuZXRhZGRyKQ0KPj4gICB7DQo+
PiAgICAgICAvKg0KPj4gICAgICAgICogSWYgSUlNIGZ1c2VzIGNvbnRhaW4gdmFsaWQgTUFDIGFk
ZHJlc3MsIHVzZSBpdC4NCj4+ICAgICAgICAqIFRoZSBJSU0gTUFDIGFkZHJlc3MgZnVzZXMgYXJl
IE5PVCBwcm9ncmFtbWVkIGJ5IGRlZmF1bHQuDQo+PiAgICAgICAgKi8NCj4+IC0gICAgIGlteF9n
ZXRfbWFjX2Zyb21fZnVzZSgwLCBlbmV0YWRkcik7DQo+PiArICAgICBpbXhfZ2V0X21hY19mcm9t
X2Z1c2UoZGV2X2lkLCBlbmV0YWRkcik7DQo+IGRoX3N0bTMyIHVzZXMgdGhlIHNlY29uZCBwYXJh
bWV0ZXIgYXMgdGhlIElELCBzbyBsZXQncyBiZSBjb25zaXN0ZW50IGhlcmUuDQoNCkknbGwgY2hh
bmdlIHRoZSBwYXJhbWV0ZXJzIGluIHRoZSBuZXh0IHZlcnNpb24NCg0KDQpSZWdhcmRzDQpDaHJp
c3RvcGgNCg0KREggZWxlY3Ryb25pY3MgR21iSA0KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCkFtIEFu
Z2VyIDggfCA4MzM0NiBCZXJnZW4gfCBHZXJtYW55IHwgd3d3LmRoLWVsZWN0cm9uaWNzLmNvbSB8
IFRlbDogKzQ5IDg2NjIgNDg4MiA0Mg0KQm9hcmQgb2YgTWFuYWdlbWVudDogU3RlZmFuIERheGVu
YmVyZ2VyLCBIZWxtdXQgSGVuc2Noa2UgfCBIUkIgVHJhdW5zdGVpbiA5NjAyDQo=
