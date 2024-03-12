Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97538C54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 14:15:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C89A87F4E;
	Tue, 12 Mar 2024 15:15:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Ow+PlKT2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6489787F65; Tue, 12 Mar 2024 15:15:24 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58EBC87DE3
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 15:15:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=T.Remmet@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1710252922; x=1712844922;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IEdCiwEh4/ahdh6337XvOv4z2g+j51xrMiwaSQhttos=;
 b=Ow+PlKT22tZwOmlayryCoNM22adcTbqZoJ3gUdbEvuFuDYfIKZ2o6dVNgy1/hWSi
 29De6e+wZyjxBqIohM9nttXGxY8HO/+KL+SoqosTKdQsB/p/avxoAzyX4QUs5Xsi
 FHYFeQJjDgDNoGlqFJUZRQGo0Am+rhX5hWmGwSK9Odg=;
X-AuditID: ac14000a-fadff7000000290d-01-65f063795baa
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 85.F9.10509.97360F56;
 Tue, 12 Mar 2024 15:15:21 +0100 (CET)
Received: from Berlix.phytec.de (172.25.0.12) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 12 Mar
 2024 15:15:21 +0100
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Tue, 12 Mar 2024 15:15:21 +0100
From: Teresa Remmet <T.Remmet@phytec.de>
To: "festevam@gmail.com" <festevam@gmail.com>, Leonard Anderweit
 <L.Anderweit@phytec.de>, "trini@konsulko.com" <trini@konsulko.com>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 4/5] include: env: Add phytec RAUC boot logic
Thread-Topic: [PATCH v2 4/5] include: env: Add phytec RAUC boot logic
Thread-Index: AQHadFuuzlVCVsxAq0mMz0l5z01HmLE0FfSA
Date: Tue, 12 Mar 2024 14:15:21 +0000
Message-ID: <39d286519786708270a16e872539c4ded13cb2f3.camel@phytec.de>
References: <20240312085957.902398-1-l.anderweit@phytec.de>
 <20240312085957.902398-5-l.anderweit@phytec.de>
In-Reply-To: <20240312085957.902398-5-l.anderweit@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6FF378CB447AA4BBA1B646119617FED@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWyRpKBV7cq+UOqwZXPzBYPr/pbTJ20md3i
 7d5Odovud+oOLB47Z91l93h1YBW7x9k7Oxg9+rtbWANYorhsUlJzMstSi/TtErgydu+bz1Kw
 Q7uifUczSwPjCq0uRk4OCQETiceP5zCB2EICi5kkdraJQdj3GSV+/EnrYuQCsjcwSkx4tpMR
 JMEmoCHx8kQ3E0hCRKCVUWLv46csIAlmgSyJ/xdnsYHYwgIuEj8ffgSzRQRcJfbtXc0KYRtJ
 TFizGqyeRUBV4vX/g2BxXgE3ib0ND5ghNudJPJ00FczmFLCROLroBtgcRgFZiQ0bzjND7BKX
 2PTsOyvEBwISS/ZAxCUERCVePv4HFZeXOHFrGtChHED1mhLrd+lDtFpIrLg+gR3CVpSY0v2Q
 HeIEQYmTM5+wTGAUn4VkwyyE7llIumch6Z6FpHsBI+sqRqHczOTs1KLMbL2CjMqS1GS9lNRN
 jKBYFGHg2sHYN8fjECMTB+MhRgkOZiUR3tc6b1OFeFMSK6tSi/Lji0pzUosPMUpzsCiJ867u
 CE4VEkhPLEnNTk0tSC2CyTJxcEo1MLbeiWs8FWMkccPmX2+t0d36o07qh3ueVhSxv1d46h73
 xjqsQHdzuvLm2Ytyt95/zPN9o7Vcu0D27pCP/2MOlDybHzdPUKX2xYxZ1an3fz19lmiZsnj3
 j9VZ/56q6f2J7JjUL6thtn5qUOPqNaW9jw3tvP43hRVYzypKdG07wSN993Us1zPNh0osxRmJ
 hlrMRcWJAAzgpvCzAgAA
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

QW0gRGllbnN0YWcsIGRlbSAxMi4wMy4yMDI0IHVtIDA5OjU5ICswMTAwIHNjaHJpZWIgTGVvbmFy
ZCBBbmRlcndlaXQ6Cj4gQWRkIGxvZ2ljIGZvciBib290aW5nIHN5c3RlbXMgd2l0aCB0aGUgUkFV
QyB1cGRhdGUgbWVjaGFuaXNtLiBUaGlzCj4gY2FuCj4gYmUgcmV1c2VkIGJ5IG90aGVyIHBoeXRl
YyBib2FyZHMuCj4gCj4gU2lnbmVkLW9mZi1ieTogTGVvbmFyZCBBbmRlcndlaXQgPGwuYW5kZXJ3
ZWl0QHBoeXRlYy5kZT4KClRlc3RlZC1ieTogVGVyZXNhIFJlbW1ldCA8dC5yZW1tZXRAcGh5dGVj
LmRlPgoKPiAtLS0KPiDCoGluY2x1ZGUvZW52L3BoeXRlYy9yYXVjLmVudiB8IDUyCj4gKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+IMKgMSBmaWxlIGNoYW5nZWQsIDUyIGlu
c2VydGlvbnMoKykKPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2Vudi9waHl0ZWMvcmF1
Yy5lbnYKPiAKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9lbnYvcGh5dGVjL3JhdWMuZW52Cj4gYi9p
bmNsdWRlL2Vudi9waHl0ZWMvcmF1Yy5lbnYKPiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+IGluZGV4
IDAwMDAwMDAwMDAwMC4uODllMTdmZjcwZWM2Cj4gLS0tIC9kZXYvbnVsbAo+ICsrKyBiL2luY2x1
ZGUvZW52L3BoeXRlYy9yYXVjLmVudgo+IEBAIC0wLDAgKzEsNTIgQEAKPiArLyogU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IEdQTC0yLjArICovCj4gKwo+ICsvKiBMb2dpYyB0byBzZWxlY3QgYSBi
b290IHBhcnRpdGlvbiBiYXNlZCBvbiBlbnZpcm9ubWVudCB2YXJpYWJsZXMKPiBhbmQgc3dpdGNo
Cj4gKyAqIHRvIHRoZSBvdGhlciBpZiB0aGUgYm9vdCBmYWlscy4gKi8KPiArCj4gK2RvcmF1Y2Jv
b3Q9MAo+ICsKPiArcmF1Y2Jvb3RwYXJ0MD0xCj4gK3JhdWNyb290cGFydDA9NQo+ICtyYXVjYm9v
dHBhcnQxPTIKPiArcmF1Y3Jvb3RwYXJ0MT02Cj4gKwo+ICtyYXVjaW5pdD0KPiArwqDCoMKgwqDC
oMKgwqBlY2hvIEJvb3RpbmcgUkFVQyBBL0Igc3lzdGVtOwo+ICvCoMKgwqDCoMKgwqDCoHRlc3Qg
LW4gIiR7Qk9PVF9PUkRFUn0iIHx8IGVudiBzZXQgQk9PVF9PUkRFUiAic3lzdGVtMAo+IHN5c3Rl
bTEiOwo+ICvCoMKgwqDCoMKgwqDCoHRlc3QgLW4gIiR7Qk9PVF9zeXN0ZW0wX0xFRlR9IiB8fCBl
bnYgc2V0IEJPT1Rfc3lzdGVtMF9MRUZUCj4gMzsKPiArwqDCoMKgwqDCoMKgwqB0ZXN0IC1uICIk
e0JPT1Rfc3lzdGVtMV9MRUZUfSIgfHwgZW52IHNldCBCT09UX3N5c3RlbTFfTEVGVAo+IDM7Cj4g
K8KgwqDCoMKgwqDCoMKgZW52IHNldCByYXVjc3RhdHVzOwo+ICvCoMKgwqDCoMKgwqDCoGZvciBC
T09UX1NMT1QgaW4gIiR7Qk9PVF9PUkRFUn0iOyBkbwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBpZiB0ZXN0ICJ4JHtyYXVjc3RhdHVzfSIgIT0gIngiOyB0aGVuCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlY2hvIFNraXBwaW5nIHJlbWFp
bmcgc2xvdHMhOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlbGlmIHRlc3QgIngk
e0JPT1RfU0xPVH0iID0gInhzeXN0ZW0wIjsgdGhlbgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgdGVzdCAke0JPT1Rfc3lzdGVtMF9MRUZUfSAtZ3Qg
MDsgdGhlbgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGVjaG8gRm91bmQgdmFsaWQgc2xvdCBBLAo+ICR7Qk9PVF9zeXN0ZW0w
X0xFRlR9IGF0dGVtcHRzIHJlbWFpbmluZzsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzZXRleHByIEJPT1Rfc3lzdGVtMF9M
RUZUCj4gJHtCT09UX3N5c3RlbTBfTEVGVH0gLSAxOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVudiBzZXQgbW1jcGFydCAk
e3JhdWNib290cGFydDB9Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVudiBzZXQgbW1jcm9vdCAke3JhdWNyb290cGFydDB9
Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGVudiBzZXQgcmF1Y2FyZ3MgcmF1Yy5zbG90PXN5c3RlbTA7Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZW52
IHNldCByYXVjc3RhdHVzIHN1Y2Nlc3M7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBmaTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZWxp
ZiB0ZXN0ICJ4JHtCT09UX1NMT1R9IiA9ICJ4c3lzdGVtMSI7IHRoZW4KPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIHRlc3QgJHtCT09UX3N5c3RlbTFf
TEVGVH0gLWd0IDA7IHRoZW4KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlY2hvIEZvdW5kIHZhbGlkIHNsb3QgQiwKPiAke0JP
T1Rfc3lzdGVtMV9MRUZUfSBhdHRlbXB0cyByZW1haW5pbmc7Cj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc2V0ZXhwciBCT09U
X3N5c3RlbTFfTEVGVAo+ICR7Qk9PVF9zeXN0ZW0xX0xFRlR9IC0gMTsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlbnYgc2V0
IG1tY3BhcnQgJHtyYXVjYm9vdHBhcnQxfTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlbnYgc2V0IG1tY3Jvb3QgJHtyYXVj
cm9vdHBhcnQxfTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBlbnYgc2V0IHJhdWNhcmdzIHJhdWMuc2xvdD1zeXN0ZW0xOwo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGVudiBzZXQgcmF1Y3N0YXR1cyBzdWNjZXNzOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZmk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGZpOwo+ICvCoMKgwqDCoMKgwqDCoGRvbmU7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgdGVz
dCAtbiAiJHtyYXVjc3RhdHVzfSI7IHRoZW4KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgZW52IGRlbGV0ZSByYXVjc3RhdHVzOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBlbnYgc2F2ZTsKPiArwqDCoMKgwqDCoMKgwqBlbHNlCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGVjaG8gV0FSTjogTm8gdmFsaWQgc2xvdCBmb3VuZDsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgZW52IHNldCBCT09UX3N5c3RlbTBfTEVGVCAzOwo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlbnYgc2V0IEJPT1Rfc3lzdGVtMV9MRUZUIDM7Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVudiBkZWxldGUgcmF1Y3N0YXR1czsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZW52IHNhdmU7Cj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHJlc2V0Owo+ICvCoMKgwqDCoMKgwqDCoGZpOwoKLS0gClBIWVRFQyBNZXNz
dGVjaG5payBHbWJIIHwgQmFyY2Vsb25hLUFsbGVlIDEgfCA1NTEyOSBNYWlueiwgR2VybWFueQoK
R2VzY2jDpGZ0c2bDvGhyZXI6IERpcGwuLUluZy4gTWljaGFlbCBNaXRlemtpLCBEaXBsLi1Jbmcu
IEJvZG8gSHViZXIsCkRpcGwuLUluZy4gKEZIKSBNYXJrdXMgTGlja2VzIHwgSGFuZGVsc3JlZ2lz
dGVyIE1haW56IEhSQiA0NjU2IHwKRmluYW56YW10IE1haW56IHwgU3QuTnIuIDI2NjUwMDYwOCwg
REUgMTQ5MDU5ODU1Cg==
