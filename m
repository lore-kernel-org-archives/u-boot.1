Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFE3C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 13:46:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2722687C8C;
	Wed, 24 Jan 2024 14:46:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="k9j0BQZj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C97D587C8D; Wed, 24 Jan 2024 14:46:06 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 475A587C77
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 14:46:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1706103962; x=1708695962;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BgV25VjxA99xs1XomldLVHVP8jWczKJtbIyDr8QZQ/A=;
 b=k9j0BQZj/1zO2WPFuu/gFGesdJzWiIwdImPBpvFHl1ZZv8g7fzgtfT16V0OUrz4S
 a6GNiUQu16pxCwZT3ReiFLEDaO2rv44Pm5jhXuTRvL8AyUp91WNxD6QMWzEBCCga
 7geb6HA7aXT7e6thdogVWTSXZs44xDw+JJy6ieXenX4=;
X-AuditID: ac14000a-fbefe7000000290d-6e-65b1149acb3b
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 83.C0.10509.A9411B56;
 Wed, 24 Jan 2024 14:46:02 +0100 (CET)
Received: from Berlix.phytec.de (172.25.0.12) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 24 Jan
 2024 14:46:02 +0100
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Wed, 24 Jan 2024 14:46:27 +0100
From: Yannic Moog <Y.Moog@phytec.de>
To: "othacehe@gnu.org" <othacehe@gnu.org>
CC: "festevam@gmail.com" <festevam@gmail.com>, Christoph Stoidner
 <C.Stoidner@phytec.de>, Wadim Egorov <W.Egorov@phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] Add Phytec i.MX93 support
Thread-Topic: [PATCH] Add Phytec i.MX93 support
Thread-Index: AQHaSRot8kpDN1J+g0iVJFysGsaNDrDgrUgAgAhTd2b///OfAA==
Date: Wed, 24 Jan 2024 13:46:27 +0000
Message-ID: <23016372e131fc169d25197a8966a876aa85ba6a.camel@phytec.de>
References: <20240117075254.8520-1-othacehe@gnu.org>
 <e88317c9172455727459367953e0bb2acbd63eab.camel@phytec.de>
 <87a5ou6eqj.fsf@gnu.org>
In-Reply-To: <87a5ou6eqj.fsf@gnu.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AAD624372589124794F2089F4E259959@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsWyRpKBV3eWyMZUg8VNJhYPr/pbnL+7hdni
 7d5Odgdmj52z7rJ7tE0z8zh7ZwdjAHMUl01Kak5mWWqRvl0CV0bT1iNsBQe4Kq6uesPcwDiH
 q4uRk0NCwETi1f17bF2MXBxCAouZJOY9WMwC4dxnlFh6p5EJwtnAKHF+1m42kBY2ARWJkzMu
 MYLYIgKaEkcvTmUGKWIWWMcosXDyZVaQhLCAnsShOX1MEEX6Ehdad7ND2E4SHZM3gsVZBFQl
 zh3eA1bPK+Amce/iOmaIbX2MEn8v/QTbxglU9P7tIrAiRgFZiQ0bzjOD2MwC4hKbnn1nhXhC
 QGLJHoi4hICoxMvH/6Di8hInbk0DWsYBVK8psX6XPoRpIbHrqTzEFEWJKd0P2SFOEJQ4OfMJ
 ywRG8VlIFsxCaJ6F0DwLSfMsJM0LGFlXMQrlZiZnpxZlZusVZFSWpCbrpaRuYgRFnggD1w7G
 vjkehxiZOBgPMUpwMCuJ8N6QXJcqxJuSWFmVWpQfX1Sak1p8iFGag0VJnHd1R3CqkEB6Yklq
 dmpqQWoRTJaJg1OqgXG6R4y5evdfxoPi304yr5JYvNt1UsihbWIPEk021FTwTVR/a+3+7PLJ
 ErMjl0zvaEzdZWWZnqWVfeVx9nm3dd0NUUau7Hdzi625hNYf+Dyvddvd19qTUixmLTnHkFJ7
 Wec+Y1b7/1kCa98cW3+L5+eNr1JRb67ekm2/zhcs+O3PE9dTBc+nOcsosRRnJBpqMRcVJwIA
 BTwnZ6oCAAA=
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

T24gV2VkLCAyMDI0LTAxLTI0IGF0IDE0OjMwICswMTAwLCBNYXRoaWV1IE90aGFjZWhlIHdyb3Rl
Og0KPiANCj4gSGVsbG8gWWFubmljLA0KPiANCj4gPiBBcyBhIGhlYWRzLXVwOiB5b3UgbmVlZCB0
byByZWJhc2UgYXMgYW02MiAoZG9jKSBnb3QgYXBwbGllZCBieSBUb20uDQo+IA0KPiBOb3RlZC4N
Cj4gDQo+ID4gSXMgdGhlIHRydXN0ZWQtZmlybXdhcmUtYSB1cHN0cmVhbSB2ZXJzaW9uIHdvcmtp
bmc/IElmIHNvLCBwbGVhc2UgdXNlIHRoYXQgaW5zdGVhZC4NCj4gDQo+IEl0IGlzIGJ1dCBvbmx5
IG9uIHRoZSBtYXN0ZXIgYnJhbmNoLCBzbyBpdCBtaWdodCBiZSBiZXR0ZXIgdG8gc3RpY2sgdG8N
Cj4gdGhlIG54cC1pbXggcmVwb3NpdG9yeSB1bnRpbCBhIGx0cyByZWxlYXNlIGlzIGNyZWF0ZWQu
DQoNCk9rLCBzb3VuZHMgcmVhc29uYWJsZS4NCg0KPiANCj4gPiA+ICsjaW5jbHVkZSA8Y29uZmln
X2Rpc3Ryb19ib290Y21kLmg+DQo+ID4gDQo+ID4gSSBkb24ndCBzZWUgYSBzcGVjaWZpYyByZWFz
b24gdG8gaGF2ZSB0aGlzIGluY2x1ZGUgc2VwYXJhdGU/ISBHcm91cCBpdCB3aXRoIHRoZSBvdGhl
cnMsIHBsZWFzZS4NCj4gDQo+IE1hbnkgb3RoZXIgaW5jbHVkZSBmaWxlcyBwbGFjZSBpdCBoZXJl
LCByaWdodCBhZnRlciB0aGUNCj4gQk9PVF9UQVJHRVRfREVWSUNFUyBtYWNybywgc28gSSBndWVz
cyB0aGVyZSBtdXN0IGJlIGEgcmVhc29uLCBldmVuDQo+IHRob3VnaCBJIGFtIHVuc3VyZSB3aHkg
OikuDQoNClNlZSBkb2MvZGV2ZWxvcC9kaXN0cm8ucnN0IGZvciBpbmZvcm1hdGlvbi4gVGhlIHJl
YXNvbiB0byBoYXZlIHRoaXMgc2VwYXJhdGUgaXMgdG8gaGF2ZSB0aGlzIHdyYXBwZWQNCmluIGlm
ZGVmcy4gU2luY2UgeW91IGhhdmUgdGhpcyB1bmNvbmRpdGlvbmFsbHksIHlvdSBtYXkgbW92ZSB0
aGlzIGluY2x1ZGUgYXMgZmFyIGFzIEkgY2FuIHRlbGwuDQoNCj4gDQo+IFRoYW5rcywNCj4gDQo+
IE1hdGhpZXUNCg0K
