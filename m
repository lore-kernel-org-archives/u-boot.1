Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8483FC47DDF
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 07:56:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 455DD87579;
	Thu,  1 Feb 2024 08:56:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="rXbda4WP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 833938753A; Thu,  1 Feb 2024 08:56:44 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91DD887579
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 08:56:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1706774201; x=1709366201;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7vytMr9n/gHP1VHZfoYeCM05dPaSadCkz27KjXzN6yE=;
 b=rXbda4WPUwqv5vEzZJsFBXbRk1OLh8QYqfrvzqD+iThWTuI0rmBgZiVyG+VcNqQL
 WCbIiV/Y8KlhbyGiPhiCXbVYKh4C9f2X6aRSGsmlYbMeLKh5mwK/V2TxM/QNSan5
 KDvsC0yJ345wBQZlQu+3LVydqNAXmnp6HZbjCUjhzHE=;
X-AuditID: ac14000a-fadff7000000290d-a8-65bb4eb90d9c
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id A2.23.10509.9BE4BB56;
 Thu,  1 Feb 2024 08:56:41 +0100 (CET)
Received: from Berlix.phytec.de (172.25.0.12) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 1 Feb 2024
 08:56:40 +0100
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Thu, 1 Feb 2024 08:56:40 +0100
From: Yannic Moog <Y.Moog@phytec.de>
To: "uboot-imx@nxp.com" <uboot-imx@nxp.com>, Wadim Egorov
 <W.Egorov@phytec.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "peng.fan@nxp.com"
 <peng.fan@nxp.com>, "othacehe@gnu.org" <othacehe@gnu.org>, "sbabic@denx.de"
 <sbabic@denx.de>, Christoph Stoidner <C.Stoidner@phytec.de>,
 "primoz.fiser@norik.com" <primoz.fiser@norik.com>, "m.othacehe@gmail.com"
 <m.othacehe@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v4] board: phytec: phycore-imx93: Add
 phyBOARD-Segin-i.MX93 support
Thread-Topic: [PATCH v4] board: phytec: phycore-imx93: Add
 phyBOARD-Segin-i.MX93 support
Thread-Index: AQHaU4u4x61F39SRaE+RCXbMefU+6bD1EIUA
Date: Thu, 1 Feb 2024 07:56:40 +0000
Message-ID: <79b414247b0098cd988dec139446600e07309b2f.camel@phytec.de>
References: <20240130145037.32672-1-othacehe@gnu.org>
In-Reply-To: <20240130145037.32672-1-othacehe@gnu.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D81E5A18A3747040B15560AE82DF26DF@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsWyRpKBV3en3+5UgyPLmS0eXvW3mHFzGpvF
 +btbmC1+rPrCanGi6yGrRfspH4upkzazW7zd28luMeXxenYHTo95s06weOycdZfdo22amcer
 A6vYPc7e2cHo8f3rBlaPje92MAWwR3HZpKTmZJalFunbJXBlnP03lblgg3zFtouH2RsYT8h1
 MXJySAiYSPxb+4W5i5GLQ0hgMZPE4wcP2CCce4wSZ5rWQWXWM0qcnb6cDaSFTUBF4uSMS4wg
 CRGBdcwSXd9vM4IkmAUMJXbtfwZWJCwQKbF7ywwwW0QgSuLmmmlMELaRxOKuyewgNgvQoOMt
 S8BsXgE3iVlz9oHNERIwlXj8/D4riM0pYCbxfNlGsBpGAVmJDRvOM0PsEpfY9Ow7K8QPAhJL
 9kDEJQREJV4+/gcVl5c4cQtkLwdQvabE+l36EK0WEnd3nmKBsBUlpnQ/hDpBUOLkzCcsExjF
 ZyHZMAuhexaS7llIumch6V7AyLqKUSg3Mzk7tSgzW68go7IkNVkvJXUTIyi6RRi4djD2zfE4
 xMjEwXiIUYKDWUmEd6XczlQh3pTEyqrUovz4otKc1OJDjNIcLErivKs7glOFBNITS1KzU1ML
 UotgskwcnFINjKZK5efd7hgtvqG6b9XVnbf5tv7/b3hz3sV4lti6HY9+/fDV5+HeEvFf6vnp
 YP2dRzJnG19Nl+n285sl6jT96I32Bu9kjbOnOSeqnz7Tmrn3xJrEyJf/iuv2H0vJd3imdts0
 M5qV0y/het3/LN260Gvsr8J5wsV9g70eLhCfbXPobNw9IeVUPyWW4oxEQy3mouJEAFbdxWrc
 AgAA
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

T24gVHVlLCAyMDI0LTAxLTMwIGF0IDE1OjUwICswMTAwLCBNYXRoaWV1IE90aGFjZWhlIHdyb3Rl
Og0KPiBBZGQgaW5pdGlhbCBzdXBwb3J0IGZvciB0aGUgUEhZVEVDIHBoeUJPQVJELVNlZ2luLWku
TVg5MyBib2FyZCBiYXNlZCBvbg0KPiB0aGUgUEhZVEVDIHBoeUNPUkUtaS5NWDkzIFNvTS4NCj4g
DQo+IFN1cHBvcnRlZCBmZWF0dXJlczoNCj4gLSAxR0IgTFBERFI0IFJBTQ0KPiAtIGVNTUMNCj4g
LSBleHRlcm5hbCBTRA0KPiAtIEZFQyBFdGhlcm5ldA0KPiAtIGRlYnVnIFVBUlQNCj4gLSB3YXRj
aGRvZw0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF0aGlldSBPdGhhY2VoZSA8b3RoYWNlaGVAZ251
Lm9yZz4NCg0KUmV2aWV3ZWQtYnk6IFlhbm5pYyBNb29nIDx5Lm1vb2dAcGh5dGVjLmRlPg0KDQo+
IC0tLQ0KPiBIZWxsbywNCj4gDQo+IFRoaXMgbmV3IHJldmlzaW9uIGZpeGVzIHRoZSByZW1hcmtz
IG9mIFByaW1vei4gVGhlIGNvbmZpZ3VyYXRpb24gaXMgbm93DQo+IGFsaWduZWQgb24gdGhlIHNh
dmVkZWZjb25maWcgb3V0cHV0LiBUaGUgRkVDIEV0aGVybmV0IGlzIGFsc28gdGVzdGVkIHRvIGJl
DQo+IHdvcmtpbmcgaWYgdGhpcyBwYXRjaCBpcyBpbjoNCj4gDQo+IGh0dHBzOi8vcGF0Y2h3b3Jr
Lm96bGFicy5vcmcvcHJvamVjdC91Ym9vdC9wYXRjaC8yMDI0MDEzMDEyNDMzNy40OTc3NDgtMS1w
cmltb3ouZmlzZXJAbm9yaWsuY29tLw0KPiANCj4gVGhlIHByb3Bvc2VkIHBhdGNoIGhhcyBiZWVu
IHJlYmFzZWQgb24gdG9wIG9mIDZmYWJhNDEuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBNYXRoaWV1
DQo+IA0KPiB2MzogaHR0cHM6Ly9saXN0cy5kZW54LmRlL3BpcGVybWFpbC91LWJvb3QvMjAyNC1K
YW51YXJ5LzU0NDQ5My5odG1sDQo+IA0KPiDCoGFyY2gvYXJtL2R0cy9NYWtlZmlsZcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgIDMgKy0NCj4g
wqBhcmNoL2FybS9kdHMvaW14OTMtcGh5Ym9hcmQtc2VnaW4tdS1ib290LmR0c2kgfMKgIDI5MyAr
KysrDQo+IMKgYXJjaC9hcm0vZHRzL2lteDkzLXBoeWJvYXJkLXNlZ2luLmR0c8KgwqDCoMKgwqDC
oMKgwqAgfMKgIDExNyArKw0KPiDCoGFyY2gvYXJtL2R0cy9pbXg5My1waHljb3JlLXNvbS5kdHNp
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEyNiArKw0KPiDCoGFyY2gvYXJtL21hY2gtaW14L2lt
eDkvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgIDYgKw0KPiDC
oGJvYXJkL3BoeXRlYy9waHljb3JlX2lteDkzL0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgIDEzICsNCj4gwqBib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg5My9NQUlOVEFJTkVSU8Kg
wqDCoMKgwqDCoMKgIHzCoMKgIDEwICsNCj4gwqBib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg5My9N
YWtlZmlsZcKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDE0ICsNCj4gwqBib2FyZC9waHl0ZWMv
cGh5Y29yZV9pbXg5My9scGRkcjRfdGltaW5nLmPCoMKgwqAgfCAxNTQ2ICsrKysrKysrKysrKysr
KysrDQo+IMKgYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OTMvcGh5Y29yZS1pbXg5My5jwqDCoMKg
IHzCoMKgIDQyICsNCj4gwqBib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg5My9waHljb3JlX2lteDkz
LmVudsKgIHzCoMKgIDczICsNCj4gwqBib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg5My9zcGwuY8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxNDggKysNCj4gwqBjb25maWdzL2lteDkzLXBo
eWJvYXJkLXNlZ2luX2RlZmNvbmZpZ8KgwqDCoMKgwqDCoMKgIHzCoCAxMzggKysNCj4gwqBkb2Mv
Ym9hcmQvcGh5dGVjL2lteDkzLXBoeWJvYXJkLXNlZ2luLnJzdMKgwqDCoMKgIHzCoMKgIDYxICsN
Cj4gwqBkb2MvYm9hcmQvcGh5dGVjL2luZGV4LnJzdMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoMKgwqAgMSArDQo+IMKgaW5jbHVkZS9jb25maWdzL3BoeWNvcmVfaW14
OTMuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMjggKw0KPiDCoDE2IGZpbGVz
IGNoYW5nZWQsIDI2MTggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiDCoGNyZWF0ZSBt
b2RlIDEwMDY0NCBhcmNoL2FybS9kdHMvaW14OTMtcGh5Ym9hcmQtc2VnaW4tdS1ib290LmR0c2kN
Cj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vZHRzL2lteDkzLXBoeWJvYXJkLXNlZ2lu
LmR0cw0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9kdHMvaW14OTMtcGh5Y29yZS1z
b20uZHRzaQ0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg5
My9LY29uZmlnDQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGJvYXJkL3BoeXRlYy9waHljb3JlX2lt
eDkzL01BSU5UQUlORVJTDQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGJvYXJkL3BoeXRlYy9waHlj
b3JlX2lteDkzL01ha2VmaWxlDQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGJvYXJkL3BoeXRlYy9w
aHljb3JlX2lteDkzL2xwZGRyNF90aW1pbmcuYw0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBib2Fy
ZC9waHl0ZWMvcGh5Y29yZV9pbXg5My9waHljb3JlLWlteDkzLmMNCj4gwqBjcmVhdGUgbW9kZSAx
MDA2NDQgYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OTMvcGh5Y29yZV9pbXg5My5lbnYNCj4gwqBj
cmVhdGUgbW9kZSAxMDA2NDQgYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OTMvc3BsLmMNCj4gwqBj
cmVhdGUgbW9kZSAxMDA2NDQgY29uZmlncy9pbXg5My1waHlib2FyZC1zZWdpbl9kZWZjb25maWcN
Cj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgZG9jL2JvYXJkL3BoeXRlYy9pbXg5My1waHlib2FyZC1z
ZWdpbi5yc3QNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9jb25maWdzL3BoeWNvcmVf
aW14OTMuaA0KPiANCj4gDQo8c25pcD4NCg0K
