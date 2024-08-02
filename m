Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC797C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 08:50:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBC6888B79;
	Fri,  2 Aug 2024 10:50:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="B4051jvq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 099CF88AD3; Fri,  2 Aug 2024 10:50:32 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9E878863C
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 10:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1722588629; x=1725180629;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=azaIHTCu6sRHVNBiIQvdNC9JGAjKPskaOXchzrAYg2w=;
 b=B4051jvqJ6y9pHhSX7/5EcbPuz02+PYMpzmU0p+uSz19Y+J3LAK3XhuS9xFqpGsi
 hd42q+DxIh0bPHg2UbCX1mPvWbECh9toJWNAycHWVWPAMKOnYS3zhaAqszdqQA1j
 M/dqHkXViqqAojpRDXycVf64V3opAlEKeRnMJc7BsXs=;
X-AuditID: ac14000a-03e52700000021bc-29-66ac9dd539d8
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id EF.11.08636.5DD9CA66;
 Fri,  2 Aug 2024 10:50:29 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 2 Aug 2024
 10:50:28 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Fri, 2 Aug 2024 10:50:28 +0200
From: Benjamin Hahn <B.Hahn@phytec.de>
To: Lukasz Majewski <lukma@denx.de>, Teresa Remmet <T.Remmet@phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Cem Tenruh <C.Tenruh@phytec.de>, "Martyn
 Welch" <martyn.welch@collabora.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/2] config: Add 'update_bootimg' command to update
 flash.bin on Phytec's imx8mm
Thread-Topic: [PATCH 1/2] config: Add 'update_bootimg' command to update
 flash.bin on Phytec's imx8mm
Thread-Index: AQHa5BH04BXzxqgNfUeeI1JsqPoJibITiGAA
Date: Fri, 2 Aug 2024 08:50:28 +0000
Message-ID: <71f5fc5c-296e-40e7-b849-3d860e39184f@phytec.de>
References: <20240801125416.1582652-1-lukma@denx.de>
In-Reply-To: <20240801125416.1582652-1-lukma@denx.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F53252A574F574BA947F1602D2B8592@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWyRpKBR/fq3DVpBl+ec1s8f3eZyeLBxS4W
 i29btjFaTJ20md3i7d5OdgdWj9kNF1k8dtxdwugxb9YJFo9XB1axe5y9s4MxgDWKyyYlNSez
 LLVI3y6BK+Ppn4PsBbOkK86vLW5gPCDVxcjJISFgIrFw9wnGLkYuDiGBJUwSndNPsYMkhATu
 MUq0TjWAsNczSrz9qwliswmoSex685oVxBYRqJA4tOsKE4jNLDCRUaLtAFiNsECaxObfPYwQ
 NekS22dMYoawjSSudDSA9bIIqEis7JnPAmLzCthI9LQ+YYbYZSJxo2MqWJxTwFRi59p3YDaj
 gKzEhg3nmSF2iUtsevadFeIBAYkleyDiEgKiEi8f/4OKy0ucuDUN6DYOoHpNifW79CFaLSQe
 n53DAmErSkzpfsgOcYKgxMmZT1gmMIrPQrJhFkL3LCTds5B0z0LSvYCRdRWjUG5mcnZqUWa2
 XkFGZUlqsl5K6iZGUHyKMHDtYOyb43GIkYmD8RCjBAezkgiv0MmVaUK8KYmVValF+fFFpTmp
 xYcYpTlYlMR5V3cEpwoJpCeWpGanphakFsFkmTg4pRoY9/37yXFh04l7Nv68V3hFvHOu8Pnr
 3PmcsFJ1ftf0WW/uN/DNmzeRear+ZvOzbJmHXuoHhCmvs/w65ZJwp9HiXzXr9Yv0DmiLTyhU
 mZ66pPKy/f7A8GW9/L+dDU0nbldZavUoikm97NjKDyov4ta5tUW/+jotfpfItCtb/3Q7LRTV
 7BJ48fWhjhJLcUaioRZzUXEiAPVTS369AgAA
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

SGkgTHVrYXN6LA0KDQpPbiAwMS4wOC4yNCAxNDo1NCwgTHVrYXN6IE1hamV3c2tpIHdyb3RlOg0K
PiBUaGlzIGNvbW1hbmQgYWxsb3dzIGVhc3kgdXBkYXRlIG9uIFNEIGNhcmQgKGhlbmNlIHRoZSB1
cGRhdGVfbW1jX3BhcnQ9MSkNCj4gb2YgdGhlIGZsYXNoLmJpbiBnZW5lcmF0ZWQgZHVyaW5nIHUt
Ym9vdCBidWlsZC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogTHVrYXN6IE1hamV3c2tpIDxsdWttYUBk
ZW54LmRlPg0KPiAtLS0NCj4gICBpbmNsdWRlL2NvbmZpZ3MvcGh5Y29yZV9pbXg4bW0uaCB8IDEx
ICsrKysrKysrKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykNCj4NCj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvY29uZmlncy9waHljb3JlX2lteDhtbS5oIGIvaW5jbHVkZS9j
b25maWdzL3BoeWNvcmVfaW14OG1tLmgNCj4gaW5kZXggY2U2ZGM4N2M2OS4uZmRlYjExOTMzZiAx
MDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9jb25maWdzL3BoeWNvcmVfaW14OG1tLmgNCj4gKysrIGIv
aW5jbHVkZS9jb25maWdzL3BoeWNvcmVfaW14OG1tLmgNCj4gQEAgLTI5LDYgKzI5LDE3IEBADQo+
ICAgCSJtbWNkZXY9IiBfX3N0cmluZ2lmeShDT05GSUdfU1lTX01NQ19FTlZfREVWKSAiXDAiIFwN
Cj4gICAJIm1tY3BhcnQ9MVwwIiBcDQo+ICAgCSJtbWNyb290PTJcMCIgXA0KPiArCSJ1cGRhdGVf
bW1jX3BhcnQ9MVwwIiBcDQoNCllvdSBkZWZpbmUgdGhlIHVwZGF0ZV9tbWNfcGFydCB2YXJpYWJs
ZSBoZXJlLCBidXQgZG8gbm90IHVzZSBpdCANCmFueXdoZXJlLiBZb3UgdXNlIHRoZSBtbWNkZXYg
dmFyaWFibGUgbGF0ZXIgd2hpY2ggaXMgZ29vZCwgYmVjYXVzZSB0aGUgDQpmdW5jdGlvbiB0aGVu
IHdvcmtzIG5vdCBvbmx5IGZvciBTRC1DYXJkLCBidXQgYWxzbyBmb3IgZU1NQy4NCg0KSW4gdGhl
IGNvbW1pdCBkZXNjcmlwdGlvbiB5b3Ugc2F5IGl0IGlzIGZvciB1cGRhdGluZyBTRC1DYXJkLCB3
aGljaCANCndvdWxkIGJlIG1tYyBkZXYgMSwgYnV0IHRoZSBuYW1lIG9mIHRoZSB2YXJpYWJsZSB3
b3VsZCBpbmRpY2F0ZSB0aGF0IGlzIA0KaXMgZm9yIGEgcGFydGl0aW9uLg0KQXMgSSB1bmRlcnN0
YW5kIGl0IHlvdSB3YW50IHRvIHVwZGF0ZSBqdXN0IHRoZSBVLUJvb3QsIHdoaWNoIGlzIG5vdCAN
Cmluc2lkZSBhbnkgcGFydGl0aW9uLCBzbyB5b3Ugd291bGQgbm90IG5lZWQgdGhpcyB2YXJpYWJs
ZS4NCg0KPiArCSJ1cGRhdGVfb2Zmc2V0PTB4NDJcMCIgXA0KPiArCSJ1cGRhdGVfZmlsZW5hbWU9
Zmxhc2guYmluXDAiIFwNCj4gKwkiaG9zdG5hbWU9L3RmdHBib290L2x1a21hL1wwIiBcDQpXZSBh
ZGl2c2UgdG8gdXNlIC9zcnYvdGZ0cMKgIGFzIHRmdHAgZGlyIGluIG91ciBCU1AgZG9jdW1lbnRh
dGlvbi4gQnV0IEkgDQpkb24ndCB0aGluayB5b3UgbmVlZCB0aGF0IHZhcmlhYmxlIGF0IGFsbCwg
YmVjYXVzZSB0aGUgZGhjcCBjb21tYW5kIA0Kc2hvdWxkIGZpbmQgdGhlIHRmdHAgZGlyIGF1dG9t
YXRpY2FsbHkuDQo+ICsJInVwZGF0ZV9ib290aW1nPSIJCQkJCQlcDQo+ICsJCSJtbWMgZGV2ICR7
bW1jZGV2fSA7ICIJCVwNCj4gKwkJImlmIGRoY3AgJHtob3N0bmFtZX0vJHt1cGRhdGVfZmlsZW5h
bWV9IDsgdGhlbiAiCVwNCg0KRG9lcyB0aGlzIHdvcms/IEZvciBtZSBpdCBkb2VzIG5vdC4gQXMg
ZmFyIGFzIEkga25vdyB0aGUgc3ludGF4IG9mIHRoaXMgY29tbWFuZCBpcyAiZGhjcCA8bG9hZGFk
ZHI+IDxmaWxlbmFtZT4iLg0KU28gSSB3b3VsZCBleHBlY3QgdGhpcyB0byBiZToNCmRoY3AgJHts
b2FkYWRkcn0gJHt1cGRhdGVfZmlsZW5hbWV9DQoNCj4gKwkJInNldGV4cHIgZndfc3ogJHtmaWxl
c2l6ZX0gLyAweDIwMCA7ICIJLyogU0QgYmxvY2sgc2l6ZSAqLyBcDQo+ICsJCSJzZXRleHByIGZ3
X3N6ICR7Zndfc3p9ICsgMSA7ICIJCQkJXA0KV2h5IGRvIHlvdSBhZGQgb25lIGhlcmU/IElzIHRo
aXMgaW1wb3J0YW50IGZvciBzb21ldGhpbmc/IEZvciBtZSBpdCANCndvcmtzIGFsc28gd2l0aG91
dCB0aGUgb25lLg0KSXQgaXMgYWxzbyBkZXNjcmliZWQgaW4gb3VyIEJTUCBkb2N1bWVudGF0aW9u
IHdpdGhvdXQgYWRkaW5nIG9uZS4gU2VlOg0KaHR0cHM6Ly9waHl0ZWMuZ2l0aHViLmlvL2RvYy1i
c3AteW9jdG8vYnNwL2lteDgvaW14OG1wL21haW5saW5lLWhlYWQuaHRtbCNmbGFzaC1lbW1jLXUt
Ym9vdC1pbWFnZS12aWEtbmV0d29yay1mcm9tLXJ1bm5pbmctdS1ib290IA0KDQooVGhpcyBpcyBm
b3Igb3VyIGlteDhtcCBtYWlubGluZSByZWxlYXNlIGJ1dCBpcyB0aGUgc2FtZSBmb3IgaW14OG1t
IHdpdGggDQphbm90aGVyIG9mZnNldCkuDQoNCkJlbmphbWluDQo+ICsJCSJtbWMgd3JpdGUgJHts
b2FkYWRkcn0gJHt1cGRhdGVfb2Zmc2V0fSAke2Z3X3N6fSA7ICIJXA0KPiArCQkiZmlcMCIgXA0K
PiAgIAkibW1jYXV0b2RldGVjdD15ZXNcMCIgXA0KPiAgIAkibW1jYXJncz1zZXRlbnYgYm9vdGFy
Z3MgY29uc29sZT0ke2NvbnNvbGV9ICIgXA0KPiAgIAkJInJvb3Q9L2Rldi9tbWNibGske21tY2Rl
dn1wJHttbWNyb290fSByb290d2FpdCByd1wwIiBcDQoNCg0K
