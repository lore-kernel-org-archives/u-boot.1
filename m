Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320EEC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 07:30:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9AD48895C;
	Tue, 23 Apr 2024 09:30:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="TgXwNAFH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9B4A8897D; Tue, 23 Apr 2024 09:30:14 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC6FF88573
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 09:30:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=T.Remmet@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1713857412; x=1716449412;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6XfgT3XLQz/gDqUOCksappKx59eLeaclKlpUsGDrztQ=;
 b=TgXwNAFHCau5Hn0b2/EmDTSPZ9z3Mbg8Tg8FceR9z69SA5DqhJj3W54rj8bgjFKT
 Dx1UxKwAkIP4Bd6GI0R+KdWm9jpgMwsrmEQELQq6v1YM4AZ9vxn45rLsz7QIKBeS
 SatOeYvuIJDfPWzAse60qzfeezxJ9C9yJKGJ7Wf8MxE=;
X-AuditID: ac14000a-fbefe7000000290d-92-66276384e6d8
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 96.A1.10509.48367266;
 Tue, 23 Apr 2024 09:30:12 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 23 Apr
 2024 09:30:12 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Tue, 23 Apr 2024 09:30:12 +0200
From: Teresa Remmet <T.Remmet@phytec.de>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Daniel Schultz
 <D.Schultz@phytec.de>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>
Subject: Re: [PATCH 1/5] board: phytec: common: Generic "add extension"
 function
Thread-Topic: [PATCH 1/5] board: phytec: common: Generic "add extension"
 function
Thread-Index: AQHaknXLnlr7m8QStk+sO7j55lfpBLF1WbOA
Date: Tue, 23 Apr 2024 07:30:12 +0000
Message-ID: <ed0c77eb9d56a1743d08d5e14f9c379a64225dcb.camel@phytec.de>
References: <20240419155540.2447006-1-d.schultz@phytec.de>
 <20240419155540.2447006-2-d.schultz@phytec.de>
In-Reply-To: <20240419155540.2447006-2-d.schultz@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <73A55B76EC98834AAF6296978B46C730@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42JZI8nAo9uSrJ5m0D1d1eLt3k52i+536g5M
 Hmfv7GD06O9uYQ1giuKySUnNySxLLdK3S+DKuLt4ElPBPO2K3cfvMDcwTtDqYuTkkBAwkZi7
 4wpLFyMXh5DAEiaJOS8+sEI49xkl/rXcZYdwNjBKfO5axgjSwiagIfHyRDcTiC0iECmx6NZ7
 FhCbWcBSonXnEbAaYYEgiStvXrJC1ARLnP32HareSOLti+tgcRYBVYnn3TPBenkF3CSmTdrB
 DGILCeRING6+zg5icwpYS3QcPc0GYjMKyEps2HCeGWKXuMSmZ99ZIV4QkFiyByIuISAq8fLx
 P6i4vMSJW9OA9nIA1WtKrN+lD9FqIdHQNAtqjKLElO6H7BAnCEqcnPmEZQKj+CwkG2YhdM9C
 0j0LSfcsJN0LGFlXMQrlZiZnpxZlZusVZFSWpCbrpaRuYgTFmQgD1w7GvjkehxiZOBgPMUpw
 MCuJ8P76o5ImxJuSWFmVWpQfX1Sak1p8iFGag0VJnHd1R3CqkEB6YklqdmpqQWoRTJaJg1Oq
 gVGqfPr7Ml2RujuH4v5dC5v11Kfxyu2DrTnS29rm18m/2Xjl8LT2xP1P51f/SG+supWWU/TV
 b1bsBAmBJwuCBQwDJC0c61+/7vp+a5KFZsujD357vpjmt9o9jck/nFST4f9PdJv/dcMVDtN/
 bM37Ebvt09u0xs57sZNWxTn+PsvXdIVpS3KIw3QlluKMREMt5qLiRABVU4Q2oQIAAA==
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

QW0gRnJlaXRhZywgZGVtIDE5LjA0LjIwMjQgdW0gMDg6NTUgLTA3MDAgc2NocmllYiBEYW5pZWwg
U2NodWx0ejoNCj4gQWRkIGEgZ2VuZXJpYyBmdW5jdGlvbiB0byBhcHBseSBvdmVybGF5cyBpbiBv
dXIgYm9hcmQgY29kZSB0byBub3QNCj4gaW1wbGVtZW50IHRoZSBzYW1lIGxvZ2ljIGluIGRpZmZl
cmVudCBQSFlURUMgcHJvZHVjdHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgU2NodWx0
eiA8ZC5zY2h1bHR6QHBoeXRlYy5kZT4NCg0KUmV2aWV3ZWQtYnk6IFRlcmVzYSBSZW1tZXQgPHQu
cmVtbWV0QHBoeXRlYy5kZT4NCg0KPiAtLS0NCj4gwqBib2FyZC9waHl0ZWMvY29tbW9uL3BoeXRl
Y19zb21fZGV0ZWN0aW9uLmMgfCAzMw0KPiArKysrKysrKysrKysrKysrKysrKysrDQo+IMKgYm9h
cmQvcGh5dGVjL2NvbW1vbi9waHl0ZWNfc29tX2RldGVjdGlvbi5oIHzCoCA1ICsrKysNCj4gwqAy
IGZpbGVzIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9ib2Fy
ZC9waHl0ZWMvY29tbW9uL3BoeXRlY19zb21fZGV0ZWN0aW9uLmMNCj4gYi9ib2FyZC9waHl0ZWMv
Y29tbW9uL3BoeXRlY19zb21fZGV0ZWN0aW9uLmMNCj4gaW5kZXggYTU2ZTBmNjBkNjIuLmQxNjdh
NzdjMjViIDEwMDY0NA0KPiAtLS0gYS9ib2FyZC9waHl0ZWMvY29tbW9uL3BoeXRlY19zb21fZGV0
ZWN0aW9uLmMNCj4gKysrIGIvYm9hcmQvcGh5dGVjL2NvbW1vbi9waHl0ZWNfc29tX2RldGVjdGlv
bi5jDQo+IEBAIC05LDYgKzksOCBAQA0KPiDCoCNpbmNsdWRlIDxkbS91Y2xhc3MuaD4NCj4gwqAj
aW5jbHVkZSA8aTJjLmg+DQo+IMKgI2luY2x1ZGUgPHUtYm9vdC9jcmMuaD4NCj4gKyNpbmNsdWRl
IDxtYWxsb2MuaD4NCj4gKyNpbmNsdWRlIDxleHRlbnNpb25fYm9hcmQuaD4NCj4gwqANCj4gwqAj
aW5jbHVkZSAicGh5dGVjX3NvbV9kZXRlY3Rpb24uaCINCj4gwqANCj4gQEAgLTIxMyw2ICsyMTUs
MjggQEAgdTggX19tYXliZV91bnVzZWQgcGh5dGVjX2dldF9zb21fdHlwZShzdHJ1Y3QNCj4gcGh5
dGVjX2VlcHJvbV9kYXRhICpkYXRhKQ0KPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGRhdGEtPmRh
dGEuZGF0YV9hcGkyLnNvbV90eXBlOw0KPiDCoH0NCj4gwqANCj4gKyNpZiBJU19FTkFCTEVEKENP
TkZJR19DTURfRVhURU5TSU9OKQ0KPiArc3RydWN0IGV4dGVuc2lvbiAqcGh5dGVjX2FkZF9leHRl
bnNpb24oY29uc3QgY2hhciAqbmFtZSwgY29uc3QgY2hhcg0KPiAqb3ZlcmxheSwNCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGNvbnN0IGNoYXIgKm90aGVyKQ0KPiArew0KPiArwqDCoMKgwqDCoMKgwqBz
dHJ1Y3QgZXh0ZW5zaW9uICpleHRlbnNpb247DQo+ICsNCj4gK8KgwqDCoMKgwqDCoMKgaWYgKHN0
cmxlbihvdmVybGF5KSA+IHNpemVvZihleHRlbnNpb24tPm92ZXJsYXkpKSB7DQo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwcl9lcnIoIk92ZXJsYXkgbmFtZSAlcyBpcyBsb25nZXIg
dGhhbiAlbHUuXG4iLA0KPiBvdmVybGF5LA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHNpemVvZihleHRlbnNpb24tPm92ZXJsYXkpKTsNCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBOVUxMOw0KPiArwqDCoMKgwqDCoMKgwqB9DQo+
ICsNCj4gK8KgwqDCoMKgwqDCoMKgZXh0ZW5zaW9uID0gY2FsbG9jKDEsIHNpemVvZihzdHJ1Y3Qg
ZXh0ZW5zaW9uKSk7DQo+ICvCoMKgwqDCoMKgwqDCoHNucHJpbnRmKGV4dGVuc2lvbi0+bmFtZSwg
c2l6ZW9mKGV4dGVuc2lvbi0+bmFtZSksIG5hbWUpOw0KPiArwqDCoMKgwqDCoMKgwqBzbnByaW50
ZihleHRlbnNpb24tPm92ZXJsYXksIHNpemVvZihleHRlbnNpb24tPm92ZXJsYXkpLA0KPiBvdmVy
bGF5KTsNCj4gK8KgwqDCoMKgwqDCoMKgc25wcmludGYoZXh0ZW5zaW9uLT5vdGhlciwgc2l6ZW9m
KGV4dGVuc2lvbi0+b3RoZXIpLCBvdGhlcik7DQo+ICvCoMKgwqDCoMKgwqDCoHNucHJpbnRmKGV4
dGVuc2lvbi0+b3duZXIsIHNpemVvZihleHRlbnNpb24tPm93bmVyKSwNCj4gIlBIWVRFQyIpOw0K
PiArDQo+ICvCoMKgwqDCoMKgwqDCoHJldHVybiBleHRlbnNpb247DQo+ICt9DQo+ICsjZW5kaWYg
LyogSVNfRU5BQkxFRChDT05GSUdfQ01EX0VYVEVOU0lPTikgKi8NCj4gKw0KPiDCoCNlbHNlDQo+
IMKgDQo+IMKgaW5saW5lIGludCBwaHl0ZWNfZWVwcm9tX2RhdGFfc2V0dXAoc3RydWN0IHBoeXRl
Y19lZXByb21fZGF0YSAqZGF0YSwNCj4gQEAgLTI1Myw0ICsyNzcsMTMgQEAgdTggX19tYXliZV91
bnVzZWQgcGh5dGVjX2dldF9zb21fdHlwZShzdHJ1Y3QNCj4gcGh5dGVjX2VlcHJvbV9kYXRhICpk
YXRhKQ0KPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIFBIWVRFQ19FRVBST01fSU5WQUw7DQo+IMKg
fQ0KPiDCoA0KPiArI2lmIElTX0VOQUJMRUQoQ09ORklHX0NNRF9FWFRFTlNJT04pDQo+ICtpbmxp
bmUgc3RydWN0IGV4dGVuc2lvbiAqcGh5dGVjX2FkZF9leHRlbnNpb24oY29uc3QgY2hhciAqbmFt
ZSwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3QgY2hhciAqb3Zlcmxh
eSwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3QgY2hhciAqb3RoZXIp
DQo+ICt7DQo+ICvCoMKgwqDCoMKgwqDCoHJldHVybiBOVUxMOw0KPiArfQ0KPiArI2VuZGlmIC8q
IElTX0VOQUJMRUQoQ09ORklHX0NNRF9FWFRFTlNJT04pICovDQo+ICsNCj4gwqAjZW5kaWYgLyog
SVNfRU5BQkxFRChDT05GSUdfUEhZVEVDX1NPTV9ERVRFQ1RJT04pICovDQo+IGRpZmYgLS1naXQg
YS9ib2FyZC9waHl0ZWMvY29tbW9uL3BoeXRlY19zb21fZGV0ZWN0aW9uLmgNCj4gYi9ib2FyZC9w
aHl0ZWMvY29tbW9uL3BoeXRlY19zb21fZGV0ZWN0aW9uLmgNCj4gaW5kZXggN2VkYmZhM2NhNWMu
LmVhOTlhNjg3ZmVlIDEwMDY0NA0KPiAtLS0gYS9ib2FyZC9waHl0ZWMvY29tbW9uL3BoeXRlY19z
b21fZGV0ZWN0aW9uLmgNCj4gKysrIGIvYm9hcmQvcGh5dGVjL2NvbW1vbi9waHl0ZWNfc29tX2Rl
dGVjdGlvbi5oDQo+IEBAIC03Niw0ICs3Niw5IEBAIGNoYXIgKiBfX21heWJlX3VudXNlZCBwaHl0
ZWNfZ2V0X29wdChzdHJ1Y3QNCj4gcGh5dGVjX2VlcHJvbV9kYXRhICpkYXRhKTsNCj4gwqB1OCBf
X21heWJlX3VudXNlZCBwaHl0ZWNfZ2V0X3JldihzdHJ1Y3QgcGh5dGVjX2VlcHJvbV9kYXRhICpk
YXRhKTsNCj4gwqB1OCBfX21heWJlX3VudXNlZCBwaHl0ZWNfZ2V0X3NvbV90eXBlKHN0cnVjdCBw
aHl0ZWNfZWVwcm9tX2RhdGENCj4gKmRhdGEpOw0KPiDCoA0KPiArI2lmIElTX0VOQUJMRUQoQ09O
RklHX0NNRF9FWFRFTlNJT04pDQo+ICtzdHJ1Y3QgZXh0ZW5zaW9uICpwaHl0ZWNfYWRkX2V4dGVu
c2lvbihjb25zdCBjaGFyICpuYW1lLCBjb25zdCBjaGFyDQo+ICpvdmVybGF5LA0KPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgY29uc3QgY2hhciAqb3RoZXIpOw0KPiArI2VuZGlmIC8qIElTX0VOQUJMRUQo
Q09ORklHX0NNRF9FWFRFTlNJT04pICovDQo+ICsNCj4gwqAjZW5kaWYgLyogX1BIWVRFQ19TT01f
REVURUNUSU9OX0ggKi8NCg0KLS0gDQpQSFlURUMgTWVzc3RlY2huaWsgR21iSCB8IEJhcmNlbG9u
YS1BbGxlZSAxIHwgNTUxMjkgTWFpbnosIEdlcm1hbnkNCg0KR2VzY2jDpGZ0c2bDvGhyZXI6IERp
cGwuLUluZy4gTWljaGFlbCBNaXRlemtpLCBEaXBsLi1JbmcuIEJvZG8gSHViZXIsDQpEaXBsLi1J
bmcuIChGSCkgTWFya3VzIExpY2tlcyB8IEhhbmRlbHNyZWdpc3RlciBNYWlueiBIUkIgNDY1NiB8
DQpGaW5hbnphbXQgTWFpbnogfCBTdC5Oci4gMjY2NTAwNjA4LCBERSAxNDkwNTk4NTUNCg==
