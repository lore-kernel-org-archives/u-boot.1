Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFAD5C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 13:18:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68A8988361;
	Thu,  2 May 2024 15:18:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=beckhoff.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=permerror (0-bit key) header.d=beckhoff.com header.i=@beckhoff.com header.b="iFbld/+u";
	dkim=pass (2048-bit key; unprotected) header.d=beckhoff.com header.i=@beckhoff.com header.b="CRFX0QPp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 693C988D11; Thu,  2 May 2024 08:47:09 +0200 (CEST)
Received: from netsrv01.beckhoff.com (netsrv01.beckhoff.com [62.159.14.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 507C288D03
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 08:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=beckhoff.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=P.Bruenn@beckhoff.com
Received: from 172.17.2.169 by netsrv01.beckhoff.com (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Thu, 02 May 2024 06:47:07 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1714632427; bh=YvS4bD7/XijEyHQEJHesjkearZKigv2rFMo4Hf5pllU=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 iFbld/+ubS2Yii8IfyhWE/ISGdIGHVV6MewJ8mcATIb7lLelUnmS5mrZuSC+O3PnIN2AQ1TJUxwPymhhr3+JDA==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1714632427; bh=YvS4bD7/XijEyHQEJHesjkearZKigv2rFMo4Hf5pllU=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 CRFX0QPpUnvuCS3B/fwLeI17FKzzSP4Nb4CRazB5OcOngDWiUuJfuPCsVuWtQYx5qfAi9UvJ7Eu+uFtirfqqSuWe6u03E18A0jWtFb5RVxqyECqo5OqOqBhpZFRvvIGDR7DZz3nDi669qLN7vOP6vmvIyrosbWO4UFP9/93D5I8NCeNE42awfuqBH4zq69Gf8PxBhihNBiO2/HgiXUkRa1kSi5yYb7DyLfSUv7HzkcEQfYgkyGFd3vJDekFIDurcqRjYOGEMj9nS2Qexq5Q95bTNPBnX3P9FvzcsQUwPnzTou6M+cOR30dzsj/YB8H7IcDJT6D5dHZF9XTOigSrJ0A==
Received: from ex01.beckhoff.com (172.17.2.168) by ex03.beckhoff.com
 (172.17.2.169) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 2 May
 2024 08:47:05 +0200
Received: from ex01.beckhoff.com ([fe80::f430:9287:849d:b171]) by
 ex01.beckhoff.com ([fe80::f430:9287:849d:b171%7]) with mapi id
 15.01.2507.035; Thu, 2 May 2024 08:47:05 +0200
From: =?utf-8?B?UGF0cmljayBCcsO8bm4=?= <P.Bruenn@beckhoff.com>
To: "trini@konsulko.com" <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 025/149] board: beckhoff: Remove <common.h> and add needed
 includes
Thread-Topic: [PATCH 025/149] board: beckhoff: Remove <common.h> and add
 needed includes
Thread-Index: AQHam3Fm6qgevFNfb0yUTr/StlRApbGDYKqA
Date: Thu, 2 May 2024 06:47:04 +0000
Message-ID: <0472737240a94e150914246388a0d608fe8467cc.camel@beckhoff.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-25-trini@konsulko.com>
In-Reply-To: <20240501024316.1767971-25-trini@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.129.198]
x-olx-disclaimer: EX03.BECKHOFF.COM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2124DD4FF54FFE4F9DA49FCA024EE713@beckhoff.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 02 May 2024 15:17:58 +0200
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

VGVzdGVkLWJ5OiBQYXRyaWNrIEJydWVubiA8cC5icnVlbm5AYmVja2hvZmYuY29tPg0KDQoNCk9u
IFR1ZSwgMjAyNC0wNC0zMCBhdCAyMDo0MSAtMDYwMCwgVG9tIFJpbmkgd3JvdGU6DQo+IO+7v0NB
VVRJT046IEV4dGVybmFsIEVtYWlsISENCj4gUmVtb3ZlIDxjb21tb24uaD4gZnJvbSB0aGlzIGJv
YXJkIHZlbmRvciBkaXJlY3RvcnkgYW5kIHdoZW4gbmVlZGVkDQo+IGFkZCBtaXNzaW5nIGluY2x1
ZGUgZmlsZXMgZGlyZWN0bHkuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFRvbSBSaW5pIDx0cmluaUBr
b25zdWxrby5jb20+DQo+IC0tLQ0KPiBDYzogUGF0cmljayBCcnVlbm4gPHAuYnJ1ZW5uQGJlY2to
b2ZmLmNvbT4NCj4gLS0tDQo+ICBib2FyZC9iZWNraG9mZi9teDUzY3g5MDIwL214NTNjeDkwMjAu
YyAgICAgICB8IDEgLQ0KPiAgYm9hcmQvYmVja2hvZmYvbXg1M2N4OTAyMC9teDUzY3g5MDIwX3Zp
ZGVvLmMgfCAxIC0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkNCj4NCj4gZGlm
ZiAtLWdpdCBhL2JvYXJkL2JlY2tob2ZmL214NTNjeDkwMjAvbXg1M2N4OTAyMC5jIGIvYm9hcmQv
YmVja2hvZmYvbXg1M2N4OTAyMC9teDUzY3g5MDIwLmMNCj4gaW5kZXggZTdiMTMxODM2YjYxLi4z
YTc2NjcyOGE2ZjcgMTAwNjQ0DQo+IC0tLSBhL2JvYXJkL2JlY2tob2ZmL214NTNjeDkwMjAvbXg1
M2N4OTAyMC5jDQo+ICsrKyBiL2JvYXJkL2JlY2tob2ZmL214NTNjeDkwMjAvbXg1M2N4OTAyMC5j
DQo+IEBAIC03LDcgKzcsNiBAQA0KPiAgICogQ29weXJpZ2h0IChDKSAyMDExIEZyZWVzY2FsZSBT
ZW1pY29uZHVjdG9yLCBJbmMuDQo+ICAgKi8NCj4NCj4gLSNpbmNsdWRlIDxjb21tb24uaD4NCj4g
ICNpbmNsdWRlIDxjcHVfZnVuYy5oPg0KPiAgI2luY2x1ZGUgPGluaXQuaD4NCj4gICNpbmNsdWRl
IDxhc20vYXJjaC9zeXNfcHJvdG8uaD4NCj4gZGlmZiAtLWdpdCBhL2JvYXJkL2JlY2tob2ZmL214
NTNjeDkwMjAvbXg1M2N4OTAyMF92aWRlby5jIGIvYm9hcmQvYmVja2hvZmYvbXg1M2N4OTAyMC9t
eDUzY3g5MDIwX3ZpZGVvLmMNCj4gaW5kZXggYmY0NzI5MDI1NjIyLi5mZDI4YTcwZjRkNzIgMTAw
NjQ0DQo+IC0tLSBhL2JvYXJkL2JlY2tob2ZmL214NTNjeDkwMjAvbXg1M2N4OTAyMF92aWRlby5j
DQo+ICsrKyBiL2JvYXJkL2JlY2tob2ZmL214NTNjeDkwMjAvbXg1M2N4OTAyMF92aWRlby5jDQo+
IEBAIC03LDcgKzcsNiBAQA0KPiAgICogQ29weXJpZ2h0IChDKSAyMDEyIEZyZWVzY2FsZSBTZW1p
Y29uZHVjdG9yLCBJbmMuDQo+ICAgKi8NCj4NCj4gLSNpbmNsdWRlIDxjb21tb24uaD4NCj4gICNp
bmNsdWRlIDxhc20vYXJjaC9pb211eC1teDUzLmg+DQo+ICAjaW5jbHVkZSA8YXNtL2dwaW8uaD4N
Cj4gICNpbmNsdWRlIDxhc20vbWFjaC1pbXgvdmlkZW8uaD4NCg0KVGhpcyBlbWFpbCBjb250YWlu
cyBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24uIElmIHlvdSBoYXZlIHJlY2VpdmVkIGl0IGluIGVy
cm9yLCB5b3UgbXVzdCBub3QgcmVhZCwgdXNlLCBjb3B5IG9yIHBhc3Mgb24gdGhpcyBlLW1haWwg
b3IgaXRzIGF0dGFjaG1lbnRzLiBJZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGUgZS1tYWlsIGluIGVy
cm9yLCBwbGVhc2UgaW5mb3JtIG1lIGltbWVkaWF0ZWx5IGJ5IHJlcGx5IGUtbWFpbCBhbmQgdGhl
biBkZWxldGUgdGhpcyBlLW1haWwgZnJvbSB5b3VyIHN5c3RlbS4gVGhhbmsgeW91DQoNCkRpZXNl
IEUtTWFpbCBlbnRow6RsdCB2ZXJ0cmF1bGljaGUgSW5mb3JtYXRpb25lbi4gU29sbHRlbiBTaWUg
c2llIGlycnTDvG1saWNoIGVyaGFsdGVuIGhhYmVuLCBkw7xyZmVuIFNpZSBkaWVzZSBFLU1haWwg
b2RlciBpaHJlIEFuaMOkbmdlIG5pY2h0IGxlc2VuLCB2ZXJ3ZW5kZW4sIGtvcGllcmVuIG9kZXIg
d2VpdGVyZ2ViZW4uIFNvbGx0ZW4gU2llIGRpZSBNYWlsIHZlcnNlaGVudGxpY2ggZXJoYWx0ZW4g
aGFiZW4sIHRlaWxlbiBTaWUgbWlyIGRpZXMgYml0dGUgdW1nZWhlbmQgcGVyIEFudHdvcnQtRS1N
YWlsIG1pdCB1bmQgbMO2c2NoZW4gU2llIGRpZXNlIEUtTWFpbCBkYW5uIGF1cyBJaHJlbSBTeXN0
ZW0uIFZpZWxlbiBEYW5rDQoNCkJlY2tob2ZmIEF1dG9tYXRpb24gR21iSCAmIENvLiBLRyB8IE1h
bmFnaW5nIERpcmVjdG9yOiBEaXBsLiBQaHlzLiBIYW5zIEJlY2tob2ZmDQpSZWdpc3RlcmVkIG9m
ZmljZTogVmVybCwgR2VybWFueSB8IFJlZ2lzdGVyIGNvdXJ0OiBHdWV0ZXJzbG9oIEhSQSA3MDc1
DQoNCg0K

