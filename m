Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC101E6ADCA
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 21:58:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BF49897D0;
	Fri, 22 Nov 2024 22:58:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="uTD6NqfM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A07C89836; Fri, 22 Nov 2024 22:58:05 +0100 (CET)
Received: from mx2.securetransport.de (mx2.securetransport.de
 [IPv6:2a03:4000:13:6c7::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 663A589265
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 22:58:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1732312676;
 bh=QstH1Whn3G25x8GUZHTMuu+E95osXw/19MO3CmHdV3w=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=uTD6NqfMX13dd0GhFtIIIX/TKC3ghyZKF5J0HXmHJL3stJSp0BSBPX4fdqtXvdijC
 A3TvPk/EbyavgKU4DKMXIZ/WQbx2Ey2UU9byOwOrckmR6+coT5SWS/1txL2u+PqAwl
 nDtGgRtgAg7no7x8a2P1F2Je3sm04GnU23kw+14G69qFua7FzTXKLNN3/cseXMlRX1
 NZrZCzWJtMvTZT2KLYwhljW8OASK+Pm2ldRJ4i+4kEM8Ei1dC7JR47D7HeRcX45wF9
 YD3H0X1/uO4F3Z2E2GNolWTgp7Lev9kno9TUzd3N9zUQcFKyZKZPsf3LQylqCjNZ7P
 2QHICc7gyNQ0A==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: NXP i.MX U-Boot Team <uboot-imx@nxp.com>, Fabio Estevam
 <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>, Tom Rini
 <trini@konsulko.com>, u-boot <u-boot@dh-electronics.com>
Subject: RE: [PATCH V3 1/3] arm64: dts: imx8mp: Add aliases for the access to
 the EEMPROM ID page node
Thread-Topic: [PATCH V3 1/3] arm64: dts: imx8mp: Add aliases for the access to
 the EEMPROM ID page node
Thread-Index: AQHbPDoZyjyaCzfh7UO2kGN6KT8DgLLB7skAgAHrYVA=
Date: Fri, 22 Nov 2024 21:57:51 +0000
Message-ID: <9d26daffc5974e18b3f00dc4407dd402@dh-electronics.com>
References: <20241121172154.90507-1-cniedermaier@dh-electronics.com>
 <044e0ac0-9c86-404e-acb4-e1db149c4bf6@denx.de>
In-Reply-To: <044e0ac0-9c86-404e-acb4-e1db149c4bf6@denx.de>
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

RnJvbTogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQpTZW50OiBUaHVyc2RheSwgTm92ZW1i
ZXIgMjEsIDIwMjQgNjozNyBQTQ0KPiBPbiAxMS8yMS8yNCA2OjIxIFBNLCBDaHJpc3RvcGggTmll
ZGVybWFpZXIgd3JvdGU6DQo+PiBUaGUgbmV3IGkuTVg4TSBQbHVzIERIQ09NIHJldi4yMDAgaXMg
cG9wdWxhdGVkIHdpdGggTTI0QzMyLUQgRUVQUk9NDQo+PiB0aGF0IGNvbnRhaW5zIGFuIGFkZGl0
aW9uYWwgd3JpdGUtbG9ja2FibGUgcGFnZSBjYWxsZWQgSUQgcGFnZS4gQWRkDQo+PiBhbGlhc2Vz
IGVlcHJvbTB3bCBhbmQgZWVwcm9tMXdsIGZvciB0aGUgYWNjZXNzIHRvIHRoZSBFRU1QUk9NIElE
DQo+PiBwYWdlIG5vZGUuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIE5pZWRlcm1h
aWVyIDxjbmllZGVybWFpZXJAZGgtZWxlY3Ryb25pY3MuY29tPg0KPiBTdWJqZWN0IHJlYWRzIEVF
TVBST00gLCBzaG91bGQgYmUgRUVQUk9NDQo+IA0KPiBXaXRoIHRoYXQgZml4ZWQ6DQo+IA0KPiBS
ZXZpZXdlZC1ieTogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQoNCkkgc2VlIGl0IGlzIGFs
c28gd3JvbmcgaW4gdGhlIGNvbW1pdCB0ZXh0Lg0KV2lsbCBmaXggYm90aCBpbiBWNC4NCg0KUmVn
YXJkcw0KQ2hyaXN0b3BoDQo=
