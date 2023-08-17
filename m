Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A9FC27C7A
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 08:53:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69E0786A92;
	Thu, 17 Aug 2023 10:53:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="mjPRG29R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 052EE86A33; Thu, 17 Aug 2023 10:53:20 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D15C86A94
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 10:53:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=T.Remmet@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1692262397; x=1694854397;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h2pETFto3OmY7xDp7LjF6ziBL8KNK+jIFxIaG4y/U3s=;
 b=mjPRG29Rvu8Yw0Bz0HqlXkrY3AvBxY6jo+FUsu0g/kKgGjc2h3IZ0XkbQfVRCxmc
 X0J8oNlUESvTbuMETIQlWQS7hNlzajyb2Hs9XV1jDHA2XIfPTb6dFlwOSWCY5LH+
 ITB0imesY2dx3OpJgifrggFZl5U5AliMV6A0NCaGsoE=;
X-AuditID: ac14000a-917fe70000007ecb-fb-64dddffd4ce1
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 02.B2.32459.DFFDDD46;
 Thu, 17 Aug 2023 10:53:17 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Aug
 2023 10:53:16 +0200
Received: from Berlix.phytec.de ([fe80::61cc:ebf0:7375:8768]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2375.018;
 Thu, 17 Aug 2023 10:53:16 +0200
From: Teresa Remmet <T.Remmet@phytec.de>
To: "festevam@gmail.com" <festevam@gmail.com>, "uboot-imx@nxp.com"
 <uboot-imx@nxp.com>, "sbabic@denx.de" <sbabic@denx.de>, Yannic Moog
 <Y.Moog@phytec.de>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Daniel Schultz
 <D.Schultz@phytec.de>, Wadim Egorov <W.Egorov@phytec.de>
Subject: Re: [PATCH 3/6] board: phytec: phycore-imx8mp: Add EEPROM detection
 initialisation
Thread-Topic: [PATCH 3/6] board: phytec: phycore-imx8mp: Add EEPROM detection
 initialisation
Thread-Index: AQHZxeHoyxARvJHJgkiAp5Ni+Ug1Na/uIzsA
Date: Thu, 17 Aug 2023 08:53:16 +0000
Message-ID: <ab257923c1114043facb608e41636551a335d8d0.camel@phytec.de>
References: <20230718133555.6627-1-t.remmet@phytec.de>
 <20230718133555.6627-4-t.remmet@phytec.de>
 <e9ab84c693f5bc93a10eff97d460d93f319a9a88.camel@phytec.de>
In-Reply-To: <e9ab84c693f5bc93a10eff97d460d93f319a9a88.camel@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <037C5E43DDD53D47A9D57DC9118746CA@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWyRpKBR/fv/bspBi8WcFk8vOpv0X7Kx+Lt
 3k52iymP17NbdL9Td2D1mDfrBIvHzll32T3O3tnB6NHf3cLqsfHdDqYA1igum5TUnMyy1CJ9
 uwSujAnPTAtWqFTM+crVwLhBuYuRg0NCwERix/ziLkYuDiGBJUwSs983skM4DxglmjdsZYNw
 NjJK/P9zlLmLkZODTUBD4uWJbiaQhIjAXEaJrV8WsII4zAJbGSWWNM1iBKkSFoiVWNU6AcwW
 EYiT+HThCROEbSTRcuwEM8huFgFViS23IkHCvAJuEp1rf4AtEBJYxCix/H89iM0p4C4xc+1D
 FhCbUUBWYsOG82A1zALiEpuefWcFsSUEBCSW7IGISwiISrx8/A8qLi9x4tY0JpBVzAKaEut3
 6UO0Wkh0ztzEAmErSkzpfsgOcYKgxMmZT1gmMIrPQrJhFkL3LCTds5B0z0LSvYCRdRWjUG5m
 cnZqUWa2XkFGZUlqsl5K6iZGUGyKMHDtYOyb43GIkYmD8RCjBAezkghvD++tFCHelMTKqtSi
 /Pii0pzU4kOM0hwsSuK893uYEoUE0hNLUrNTUwtSi2CyTBycUg2M20tymzfnJPxyC3XdstMg
 90T1ybMSG2InPN84yfsJt6hT60oLj84fqXbd2snqHzUOXbJ2/3/e7q3ZZKaqnp1nFu5ZuJl1
 v0cl67T3y4JdngixTlhhYLrv+salqbYm2/7z8/zYwdQas3hn9KwZW9b8vvihY6WqhFPq3eDN
 Mtut2fod1VkZ3KtklViKMxINtZiLihMBvli9G7sCAAA=
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

SGVsbG8gWWFubmljLA0KDQpBbSBEb25uZXJzdGFnLCBkZW0gMDMuMDguMjAyMyB1bSAxMDoxMCAr
MDIwMCBzY2hyaWViIFlhbm5pYyBNb29nOg0KPiBIZWxsbyBUZXJlc2EsDQo+IA0KPiBPbiBUdWUs
IDIwMjMtMDctMTggYXQgMTU6MzUgKzAyMDAsIFRlcmVzYSBSZW1tZXQgd3JvdGU6DQo+ID4gQWRk
IEVFUFJPTSBkZXRlY3Rpb24gaW5pdGlhbGlzYXRpb24gZm9yIHBoeUNPUkUtaS5NWDhNTSBhbmQN
Cj4gPiBwcmludCBTb00gaW5mb3JtYXRpb24gZHVyaW5nIGJvb3Qgd2hlbiBzdWNjZXNzZnVsLg0K
PiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFRlcmVzYSBSZW1tZXQgPHQucmVtbWV0QHBoeXRlYy5k
ZT4NCj4gPiAtLS0NCj4gPiDCoGJvYXJkL3BoeXRlYy9waHljb3JlX2lteDhtcC9LY29uZmlnIHzC
oCAxICsNCj4gPiDCoGJvYXJkL3BoeXRlYy9waHljb3JlX2lteDhtcC9zcGwuY8KgwqAgfCAxOSAr
KysrKysrKysrKysrKysrKysrDQo+ID4gwqBjb25maWdzL3BoeWNvcmUtaW14OG1wX2RlZmNvbmZp
Z8KgwqDCoCB8wqAgMSArDQo+ID4gwqAzIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKykN
Cj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1wL0tjb25m
aWcNCj4gPiBiL2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDhtcC9LY29uZmlnDQo+ID4gaW5kZXgg
YzA1M2E0NmZjOWQxLi5mODQ2ZDEwYmFkOWUgMTAwNjQ0DQo+ID4gLS0tIGEvYm9hcmQvcGh5dGVj
L3BoeWNvcmVfaW14OG1wL0tjb25maWcNCj4gPiArKysgYi9ib2FyZC9waHl0ZWMvcGh5Y29yZV9p
bXg4bXAvS2NvbmZpZw0KPiA+IEBAIC0xMiw0ICsxMiw1IEBAIGNvbmZpZyBTWVNfQ09ORklHX05B
TUUNCj4gPiDCoGNvbmZpZyBJTVhfQ09ORklHDQo+ID4gwqDCoMKgwqDCoMKgwqDCoGRlZmF1bHQg
ImJvYXJkL3BoeXRlYy9waHljb3JlX2lteDhtcC9pbXhpbWFnZS04bXAtc2QuY2ZnIg0KPiA+IMKg
DQo+ID4gK3NvdXJjZSAiYm9hcmQvcGh5dGVjL2NvbW1vbi9LY29uZmlnIg0KPiA+IMKgZW5kaWYN
Cj4gPiBkaWZmIC0tZ2l0IGEvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1wL3NwbC5jDQo+ID4g
Yi9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bXAvc3BsLmMNCj4gPiBpbmRleCBmYWVkNmZjM2I3
NmQuLmUwODRmZTA4MTk4NyAxMDA2NDQNCj4gPiAtLS0gYS9ib2FyZC9waHl0ZWMvcGh5Y29yZV9p
bXg4bXAvc3BsLmMNCj4gPiArKysgYi9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bXAvc3BsLmMN
Cj4gPiBAQCAtMjEsOCArMjEsMTMgQEANCj4gPiDCoCNpbmNsdWRlIDxwb3dlci9wY2E5NDUwLmg+
DQo+ID4gwqAjaW5jbHVkZSA8c3BsLmg+DQo+ID4gwqANCj4gPiArI2luY2x1ZGUgIi4uL2NvbW1v
bi9pbXg4bV9zb21fZGV0ZWN0aW9uLmgiDQo+ID4gKw0KPiA+IMKgREVDTEFSRV9HTE9CQUxfREFU
QV9QVFI7DQo+ID4gwqANCj4gPiArI2RlZmluZSBFRVBST01fQUREUsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAweDUxDQo+ID4gKyNkZWZpbmUgRUVQUk9NX0FERFJfRkFMTEJBQ0vCoMKgwqAgMHg1
OQ0KPiA+ICsNCj4gPiDCoGludCBzcGxfYm9hcmRfYm9vdF9kZXZpY2UoZW51bSBib290X2Rldmlj
ZSBib290X2Rldl9zcGwpDQo+ID4gwqB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiBCT09U
X0RFVklDRV9CT09UUk9NOw0KPiA+IEBAIC0zMCw2ICszNSwyMCBAQCBpbnQgc3BsX2JvYXJkX2Jv
b3RfZGV2aWNlKGVudW0gYm9vdF9kZXZpY2UNCj4gPiBib290X2Rldl9zcGwpDQo+ID4gwqANCj4g
PiDCoHZvaWQgc3BsX2RyYW1faW5pdCh2b2lkKQ0KPiA+IMKgew0KPiA+ICvCoMKgwqDCoMKgwqDC
oGludCByZXQ7DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDCoHJldCA9IHBoeXRlY19lZXByb21f
ZGF0YV9zZXR1cF9mYWxsYmFjayhOVUxMLCAwLA0KPiA+IEVFUFJPTV9BRERSLA0KPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgRUVQUk9NX0FERFJfRkFMTEJBQw0KPiA+
IEspDQo+ID4gOw0KPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChyZXQpDQo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0Ow0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgwqBy
ZXQgPSBwaHl0ZWNfaW14OG1fZGV0ZWN0KE5VTEwpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChy
ZXQpDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0Ow0KPiA+ICsN
Cj4gPiArwqDCoMKgwqDCoMKgwqBwaHl0ZWNfcHJpbnRfc29tX2luZm8oTlVMTCk7DQo+ID4gKw0K
PiANCj4gSXMgaXQgYmV0dGVyIHRvIGRvIGEgZGRyX2luaXQgaGVyZSBhbmQgdGhlbiByZXR1cm4/
IEZvciBzYWZldHkNCj4gcmVhc29ucy4NCg0KSSB3aWxsIGp1c3QgcmVtb3ZlIHRoZSBzZWNvbmQg
Z290by4gQXMgaXQgaXMgbm90IG5lZWRlZC4NCg0KVGhhbmtzLA0KVGVyZXNhDQoNCj4gDQo+IFlh
bm5pYw0KPiANCj4gPiArb3V0Og0KPiA+IMKgwqDCoMKgwqDCoMKgwqBkZHJfaW5pdCgmZHJhbV90
aW1pbmcpOw0KPiA+IMKgfQ0KPiA+IMKgDQo+ID4gZGlmZiAtLWdpdCBhL2NvbmZpZ3MvcGh5Y29y
ZS1pbXg4bXBfZGVmY29uZmlnIGIvY29uZmlncy9waHljb3JlLQ0KPiA+IGlteDhtcF9kZWZjb25m
aWcNCj4gPiBpbmRleCA3YmY0MDRiZTg2MGIuLjc5MzdlMTVlNjQyMiAxMDA2NDQNCj4gPiAtLS0g
YS9jb25maWdzL3BoeWNvcmUtaW14OG1wX2RlZmNvbmZpZw0KPiA+ICsrKyBiL2NvbmZpZ3MvcGh5
Y29yZS1pbXg4bXBfZGVmY29uZmlnDQo+ID4gQEAgLTEyLDYgKzEyLDcgQEAgQ09ORklHX0RNX0dQ
SU89eQ0KPiA+IMKgQ09ORklHX0RFRkFVTFRfREVWSUNFX1RSRUU9ImlteDhtcC1waHlib2FyZC1w
b2xsdXgtcmRrIg0KPiA+IMKgQ09ORklHX1NQTF9URVhUX0JBU0U9MHg5MjAwMDANCj4gPiDCoENP
TkZJR19UQVJHRVRfUEhZQ09SRV9JTVg4TVA9eQ0KPiA+ICtDT05GSUdfUEhZVEVDX1NPTV9ERVRF
Q1RJT049eQ0KPiA+IMKgQ09ORklHX1NZU19QUk9NUFQ9InUtYm9vdD0+ICINCj4gPiDCoENPTkZJ
R19TWVNfTU9OSVRPUl9MRU49NTI0Mjg4DQo+ID4gwqBDT05GSUdfU1BMX01NQz15DQo+IA0KDQot
LSANClBIWVRFQyBNZXNzdGVjaG5payBHbWJIIHwgQmFyY2Vsb25hLUFsbGVlIDEgfCA1NTEyOSBN
YWlueiwgR2VybWFueQ0KDQpHZXNjaMOkZnRzZsO8aHJlcjogRGlwbC4tSW5nLiBNaWNoYWVsIE1p
dGV6a2ksIERpcGwuLUluZy4gQm9kbyBIdWJlciwNCkRpcGwuLUluZy4gKEZIKSBNYXJrdXMgTGlj
a2VzIHwgSGFuZGVsc3JlZ2lzdGVyIE1haW56IEhSQiA0NjU2IHwNCkZpbmFuemFtdCBNYWlueiB8
IFN0Lk5yLiAyNjY1MDA2MDgsIERFIDE0OTA1OTg1NQ0K
