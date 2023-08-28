Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61A9C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 12:32:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AC248645F;
	Mon, 28 Aug 2023 14:32:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="VXzvm9nm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FEDB80295; Mon, 28 Aug 2023 14:32:52 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4F2C86481
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 14:32:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1693225967; x=1695817967;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fZdrkeoqJeYzoVVhwhCNUAzBrkmjrnsL+Lqm5fszF3o=;
 b=VXzvm9nmiYINw16ANtWrQJKzKSwY0ebxJr4rPhPftQ07VB8yCH+TbUXwkvJ8EoNb
 VfZMZVBCpNHpqr1dLuQM1msD0XtVjsVBGFlRyN6IapgIp7YPUGxiT9y5PpMz9Jex
 Nm5smrNuAEsXC/F+ntXokdKBNhO5p0oSVkJagwQyPVs=;
X-AuditID: ac14000a-917fe70000007ecb-fd-64ec93ef92d5
Received: from Diagnostix.phytec.de (Diagnostix.phytec.de [172.25.0.14])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id AA.44.32459.FE39CE46;
 Mon, 28 Aug 2023 14:32:47 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Aug
 2023 14:32:47 +0200
Received: from Berlix.phytec.de ([fe80::61cc:ebf0:7375:8768]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2375.018;
 Mon, 28 Aug 2023 14:32:47 +0200
From: Yannic Moog <Y.Moog@phytec.de>
To: "festevam@gmail.com" <festevam@gmail.com>, "uboot-imx@nxp.com"
 <uboot-imx@nxp.com>, "sbabic@denx.de" <sbabic@denx.de>, Teresa Remmet
 <T.Remmet@phytec.de>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Daniel Schultz
 <D.Schultz@phytec.de>, Wadim Egorov <W.Egorov@phytec.de>
Subject: Re: [PATCH v2 3/6] board: phytec: phycore-imx8mp: Add EEPROM
 detection initialisation
Thread-Topic: [PATCH v2 3/6] board: phytec: phycore-imx8mp: Add EEPROM
 detection initialisation
Thread-Index: AQHZ0OjXr3NQTorPQUWBGFtJz8n59q//lCYA
Date: Mon, 28 Aug 2023 12:32:47 +0000
Message-ID: <ff178735711e9b86857e091bb86300e43498b610.camel@phytec.de>
References: <20230817085711.45339-1-t.remmet@phytec.de>
 <20230817085711.45339-4-t.remmet@phytec.de>
In-Reply-To: <20230817085711.45339-4-t.remmet@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECE462BC75473B498B7A0D1208FCFA65@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsWyRpKBT/f95DcpBg9malg8vOpv0X7Kx+Lt
 3k52iymP17NbdL9Td2D1mDfrBIvHzll32T3O3tnB6NHf3cLqsfHdDqYA1igum5TUnMyy1CJ9
 uwSujMvXFrEXvJKt6Nn6na2BsUO2i5GTQ0LAROLms52MXYxcHEIC65gkTj6bzAThPGGUeP71
 BAuEs5FR4vLh2awgLWwCKhInZ1wCaxERWMgocXLHY3YQh1lgK6PEkqZZjCBVwgIJEvN+r2ED
 sUUEEiWuP2oDsjmAbCOJo7s1QcIsAqoS75+eASvhFXCTaDw3iwnEFhJIk5g65xnYGE4BC4l1
 q6+C1TAKyEps2HCeGcRmFhCX2PTsOyvEDwISS/ZAxCUERCVePv4HFZeXOHFrGhPIWmYBTYn1
 u/QhWi0kZiz9wAphK0pM6X7IDnGCoMTJmU9YJjCKz0KyYRZC9ywk3bOQdM9C0r2AkXUVo1Bu
 ZnJ2alFmtl5BRmVJarJeSuomRlCEijBw7WDsm+NxiJGJg/EQowQHs5II7yXHVylCvCmJlVWp
 RfnxRaU5qcWHGKU5WJTEee/3MCUKCaQnlqRmp6YWpBbBZJk4OKUaGJNevxdmZ44rOycdvfnL
 kZ0RgWIO96p+qvyu+2hv73jn5Kc7M6en7thy4/8Ztet/C/afYHh+T7nlqMEfuYAdSXdcfNJf
 i+z9xZ29JfNPruC16BfGKhfaDsy9YPj3+Lua39H37JbInHZi3WN+Y/kz2byW5wHVFfkS8uL/
 X8Xd+xF+7X3o1XTXNe5KLMUZiYZazEXFiQBtCJScvgIAAA==
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

T24gVGh1LCAyMDIzLTA4LTE3IGF0IDEwOjU3ICswMjAwLCBUZXJlc2EgUmVtbWV0IHdyb3RlOg0K
PiBBZGQgRUVQUk9NIGRldGVjdGlvbiBpbml0aWFsaXNhdGlvbiBmb3IgcGh5Q09SRS1pLk1YOE1N
IGFuZA0KPiBwcmludCBTb00gaW5mb3JtYXRpb24gZHVyaW5nIGJvb3Qgd2hlbiBzdWNjZXNzZnVs
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVGVyZXNhIFJlbW1ldCA8dC5yZW1tZXRAcGh5dGVjLmRl
Pg0KDQpSZXZpZXdlZC1ieTogWWFubmljIE1vb2cgPHkubW9vZ0BwaHl0ZWMuZGU+DQpUZXN0ZWQt
Ynk6IFlhbm5pYyBNb29nIDx5Lm1vb2dAcGh5dGVjLmRlPg0KDQo+IC0tLQ0KPiBDaGFuZ2VzIGlu
IHYyOg0KPiAtIHJlbW92ZWQgc3VwZXJmbHVvdXMgZ290bw0KPiAtLS0NCj4gwqBib2FyZC9waHl0
ZWMvcGh5Y29yZV9pbXg4bXAvS2NvbmZpZyB8wqAgMSArDQo+IMKgYm9hcmQvcGh5dGVjL3BoeWNv
cmVfaW14OG1wL3NwbC5jwqDCoCB8IDE3ICsrKysrKysrKysrKysrKysrDQo+IMKgY29uZmlncy9w
aHljb3JlLWlteDhtcF9kZWZjb25maWfCoMKgwqAgfMKgIDEgKw0KPiDCoDMgZmlsZXMgY2hhbmdl
ZCwgMTkgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2JvYXJkL3BoeXRlYy9waHlj
b3JlX2lteDhtcC9LY29uZmlnDQo+IGIvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1wL0tjb25m
aWcNCj4gaW5kZXggYzA1M2E0NmZjOWQxLi5mODQ2ZDEwYmFkOWUgMTAwNjQ0DQo+IC0tLSBhL2Jv
YXJkL3BoeXRlYy9waHljb3JlX2lteDhtcC9LY29uZmlnDQo+ICsrKyBiL2JvYXJkL3BoeXRlYy9w
aHljb3JlX2lteDhtcC9LY29uZmlnDQo+IEBAIC0xMiw0ICsxMiw1IEBAIGNvbmZpZyBTWVNfQ09O
RklHX05BTUUNCj4gwqBjb25maWcgSU1YX0NPTkZJRw0KPiDCoMKgwqDCoMKgwqDCoMKgZGVmYXVs
dCAiYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1wL2lteGltYWdlLThtcC1zZC5jZmciDQo+IMKg
DQo+ICtzb3VyY2UgImJvYXJkL3BoeXRlYy9jb21tb24vS2NvbmZpZyINCj4gwqBlbmRpZg0KPiBk
aWZmIC0tZ2l0IGEvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1wL3NwbC5jDQo+IGIvYm9hcmQv
cGh5dGVjL3BoeWNvcmVfaW14OG1wL3NwbC5jDQo+IGluZGV4IGZhZWQ2ZmMzYjc2ZC4uNDk0MDZm
MmVhZmFkIDEwMDY0NA0KPiAtLS0gYS9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bXAvc3BsLmMN
Cj4gKysrIGIvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1wL3NwbC5jDQo+IEBAIC0yMSw4ICsy
MSwxMyBAQA0KPiDCoCNpbmNsdWRlIDxwb3dlci9wY2E5NDUwLmg+DQo+IMKgI2luY2x1ZGUgPHNw
bC5oPg0KPiDCoA0KPiArI2luY2x1ZGUgIi4uL2NvbW1vbi9pbXg4bV9zb21fZGV0ZWN0aW9uLmgi
DQo+ICsNCj4gwqBERUNMQVJFX0dMT0JBTF9EQVRBX1BUUjsNCj4gwqANCj4gKyNkZWZpbmUgRUVQ
Uk9NX0FERFLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHg1MQ0KPiArI2RlZmluZSBFRVBST01f
QUREUl9GQUxMQkFDS8KgwqDCoCAweDU5DQo+ICsNCj4gwqBpbnQgc3BsX2JvYXJkX2Jvb3RfZGV2
aWNlKGVudW0gYm9vdF9kZXZpY2UgYm9vdF9kZXZfc3BsKQ0KPiDCoHsNCj4gwqDCoMKgwqDCoMKg
wqDCoHJldHVybiBCT09UX0RFVklDRV9CT09UUk9NOw0KPiBAQCAtMzAsNiArMzUsMTggQEAgaW50
IHNwbF9ib2FyZF9ib290X2RldmljZShlbnVtIGJvb3RfZGV2aWNlDQo+IGJvb3RfZGV2X3NwbCkN
Cj4gwqANCj4gwqB2b2lkIHNwbF9kcmFtX2luaXQodm9pZCkNCj4gwqB7DQo+ICvCoMKgwqDCoMKg
wqDCoGludCByZXQ7DQo+ICsNCj4gK8KgwqDCoMKgwqDCoMKgcmV0ID0gcGh5dGVjX2VlcHJvbV9k
YXRhX3NldHVwX2ZhbGxiYWNrKE5VTEwsIDAsIEVFUFJPTV9BRERSLA0KPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEVFUFJPTV9BRERSX0ZBTExCQUNLKTsNCj4gK8KgwqDC
oMKgwqDCoMKgaWYgKHJldCkNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8g
b3V0Ow0KPiArDQo+ICvCoMKgwqDCoMKgwqDCoHJldCA9IHBoeXRlY19pbXg4bV9kZXRlY3QoTlVM
TCk7DQo+ICvCoMKgwqDCoMKgwqDCoGlmICghcmV0KQ0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcGh5dGVjX3ByaW50X3NvbV9pbmZvKE5VTEwpOw0KPiArDQo+ICtvdXQ6DQo+IMKg
wqDCoMKgwqDCoMKgwqBkZHJfaW5pdCgmZHJhbV90aW1pbmcpOw0KPiDCoH0NCj4gwqANCj4gZGlm
ZiAtLWdpdCBhL2NvbmZpZ3MvcGh5Y29yZS1pbXg4bXBfZGVmY29uZmlnIGIvY29uZmlncy9waHlj
b3JlLQ0KPiBpbXg4bXBfZGVmY29uZmlnDQo+IGluZGV4IDdiZjQwNGJlODYwYi4uNzkzN2UxNWU2
NDIyIDEwMDY0NA0KPiAtLS0gYS9jb25maWdzL3BoeWNvcmUtaW14OG1wX2RlZmNvbmZpZw0KPiAr
KysgYi9jb25maWdzL3BoeWNvcmUtaW14OG1wX2RlZmNvbmZpZw0KPiBAQCAtMTIsNiArMTIsNyBA
QCBDT05GSUdfRE1fR1BJTz15DQo+IMKgQ09ORklHX0RFRkFVTFRfREVWSUNFX1RSRUU9ImlteDht
cC1waHlib2FyZC1wb2xsdXgtcmRrIg0KPiDCoENPTkZJR19TUExfVEVYVF9CQVNFPTB4OTIwMDAw
DQo+IMKgQ09ORklHX1RBUkdFVF9QSFlDT1JFX0lNWDhNUD15DQo+ICtDT05GSUdfUEhZVEVDX1NP
TV9ERVRFQ1RJT049eQ0KPiDCoENPTkZJR19TWVNfUFJPTVBUPSJ1LWJvb3Q9PiAiDQo+IMKgQ09O
RklHX1NZU19NT05JVE9SX0xFTj01MjQyODgNCj4gwqBDT05GSUdfU1BMX01NQz15DQoNCg==
