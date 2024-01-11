Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C41CC47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 10:55:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82F178792C;
	Thu, 11 Jan 2024 11:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="FtOhBnDj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70EB98792C; Thu, 11 Jan 2024 11:55:53 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BB9387883
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 11:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=T.Remmet@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1704970550; x=1707562550;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=23f0/YWrmXoiAeqWino5BJp5F+5luCaoD5pZ2Gwbj+4=;
 b=FtOhBnDj2/tKWWyOttnhqvy+zLUQsRW01h+Lt4mf1AImlx7yJPcmiOXR8cW5e+LL
 rwNBUJwxT9MKP5HAFGUod4l6BKT43fBWmFrdYGF/u4+pAohs+/RVKxYN4+RclJTW
 /O355wGczzns7iVzw7w7pKQAZOWuMlAgT7EuLDXcYZo=;
X-AuditID: ac14000a-fadff7000000290d-95-659fc936f0bf
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 40.6A.10509.639CF956;
 Thu, 11 Jan 2024 11:55:50 +0100 (CET)
Received: from Berlix.phytec.de (172.25.0.12) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 11 Jan
 2024 11:55:50 +0100
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Thu, 11 Jan 2024 11:55:50 +0100
From: Teresa Remmet <T.Remmet@phytec.de>
To: "festevam@gmail.com" <festevam@gmail.com>, "uboot-imx@nxp.com"
 <uboot-imx@nxp.com>, Yannic Moog <Y.Moog@phytec.de>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 2/3] doc: board: phytec: Add phyGATE-Tauri board
 documentation
Thread-Topic: [PATCH v2 2/3] doc: board: phytec: Add phyGATE-Tauri board
 documentation
Thread-Index: AQHaQ8nwExJeuWK6U0usTlhYQYprq7DUYSIA
Date: Thu, 11 Jan 2024 10:55:50 +0000
Message-ID: <fbcbeed976e145f8c9ec865ca10a0f99d5764b13.camel@phytec.de>
References: <20240110-wip-y-moog-phytec-de-tauri-l_upstream-v2-0-4ea2dd6a4f74@phytec.de>
 <20240110-wip-y-moog-phytec-de-tauri-l_upstream-v2-2-4ea2dd6a4f74@phytec.de>
In-Reply-To: <20240110-wip-y-moog-phytec-de-tauri-l_upstream-v2-2-4ea2dd6a4f74@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <938E63C46AA48247A1BA69EAC00077FB@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWyRpKBV9fs5PxUgwcTrS0eXvW3eLu3k91i
 yuP17Bbd79QdWDx2zrrL7nH2zg5Gj/7uFlaPje92MAWwRHHZpKTmZJalFunbJXBlnNg3gaWg
 Ta3izgO3BsYO1S5GTg4JAROJC1OWs4PYQgKLmSSmPZbuYuQCsu8zSuzY/Y0FwtnAKPH9/jkm
 kCo2AQ2Jlye6wWwRgQqJ/rOrWEFsZoEsif8XZ7GB2MIC4RIbTr5mgaiJkJj9/Tw7hG0kMWHi
 DmYQm0VAVWJC8zywOK+Am0TLjU9MEMtWMErcPLoQrIhTIFJiz9EmsAWMArISGzacZ4ZYJi6x
 6dl3VogXBCSW7IGISwiISrx8/A8qLi9x4tY0oKEcQPWaEut36UO0WkjseP+VCcJWlJjS/RDq
 BkGJkzOfsExgFJ+FZMMshO5ZSLpnIemehaR7ASPrKkah3Mzk7NSizGy9gozKktRkvZTUTYyg
 WBRh4NrB2DfH4xAjEwfjIUYJDmYlEV6Fz3NShXhTEiurUovy44tKc1KLDzFKc7AoifOu7ghO
 FRJITyxJzU5NLUgtgskycXBKNTDuM1xYp/gm50TvHrNFr9Y5i07XOK5vVLjQxyRUe+Z6nYun
 OmTuM7kIT0lu0ua0ttqrXv/4xWmWnxs/2PclT3746NS53Pddd2cpyr79JyzlIWfOHOI85XSJ
 eZRdjGLFUolqRZ/C54ndfCdLbVOmCNRekllj/HhTgstrq8bA6ZZpn25ve2G+gkWJpTgj0VCL
 uag4EQDQJwa7swIAAA==
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

QW0gTWl0dHdvY2gsIGRlbSAxMC4wMS4yMDI0IHVtIDE0OjM1ICswMTAwIHNjaHJpZWIgWWFubmlj
IE1vb2c6DQo+IEFkZCBicmllZiBkb2N1bWVudGF0aW9uIG9uIGhvdyB0byBidWlsZCBhIGJvb3Rh
YmxlIFUtQm9vdCBpbWFnZSBmb3INCj4gdGhlDQo+IHBoeUdBVEUtVGF1cmktTC4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFlhbm5pYyBNb29nIDx5Lm1vb2dAcGh5dGVjLmRlPg0KDQpSZXZpZXdlZC1i
eTogVGVyZXNhIFJlbW1ldCA8dC5yZW1tZXRAcGh5dGVjLmRlPg0KDQo+IC0tLQ0KPiDCoGJvYXJk
L3BoeXRlYy9waHljb3JlX2lteDhtbS9NQUlOVEFJTkVSU8KgwqDCoMKgIHzCoCAyICsNCj4gwqBk
b2MvYm9hcmQvcGh5dGVjL2lteDhtbS1waHlnYXRlLXRhdXJpLWwucnN0IHwgNjANCj4gKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCj4gwqBkb2MvYm9hcmQvcGh5dGVjL2luZGV4LnJzdMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgKw0KPiDCoDMgZmlsZXMgY2hh
bmdlZCwgNjMgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2JvYXJkL3BoeXRlYy9w
aHljb3JlX2lteDhtbS9NQUlOVEFJTkVSUw0KPiBiL2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDht
bS9NQUlOVEFJTkVSUw0KPiBpbmRleCAwNWQ0OGJhMjQ3Mi4uY2Y2ZjkyYzA3ZTUgMTAwNjQ0DQo+
IC0tLSBhL2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDhtbS9NQUlOVEFJTkVSUw0KPiArKysgYi9i
b2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bW0vTUFJTlRBSU5FUlMNCj4gQEAgLTEwLDQgKzEwLDYg
QEAgRjrCoMKgwqDCoGFyY2gvYXJtL2R0cy9pbXg4bW0tcGh5Z2F0ZS10YXVyaS1sLXUtDQo+IGJv
b3QuZHRzaQ0KPiDCoEY6wqDCoMKgwqDCoCBib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bW0vDQo+
IMKgRjrCoMKgwqDCoMKgY29uZmlncy9pbXg4bW0tcGh5Z2F0ZS10YXVyaS1sX2RlZmNvbmZpZw0K
PiDCoEY6wqDCoMKgwqDCoCBjb25maWdzL3BoeWNvcmUtaW14OG1tX2RlZmNvbmZpZw0KPiArRjrC
oMKgwqDCoMKgZG9jL2JvYXJkL3BoeXRlYy9pbXg4bW0tcGh5Z2F0ZS10YXVyaS1sLnJzdA0KPiAr
RjrCoMKgwqDCoMKgZG9jL2JvYXJkL3BoeXRlYy9pbmRleC5yc3QNCj4gwqBGOsKgwqDCoMKgwqAg
aW5jbHVkZS9jb25maWdzL3BoeWNvcmVfaW14OG1tLmgNCj4gZGlmZiAtLWdpdCBhL2RvYy9ib2Fy
ZC9waHl0ZWMvaW14OG1tLXBoeWdhdGUtdGF1cmktbC5yc3QNCj4gYi9kb2MvYm9hcmQvcGh5dGVj
L2lteDhtbS1waHlnYXRlLXRhdXJpLWwucnN0DQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGlu
ZGV4IDAwMDAwMDAwMDAwLi4yOGI2MTRmZDE0NA0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2Rv
Yy9ib2FyZC9waHl0ZWMvaW14OG1tLXBoeWdhdGUtdGF1cmktbC5yc3QNCj4gQEAgLTAsMCArMSw2
MCBAQA0KPiArLi4gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArDQo+ICsNCj4gK3Bo
eUdBVEUtVGF1cmktTC1pLk1YIDhNIE1pbmkNCj4gKz09PT09PT09PT09PT09PT09PT09PT09PT09
PT0NCj4gKw0KPiArVGhlIHBoeUdBVEUtVGF1cmktTC1pLk1YIDhNIE1pbmkgd2l0aCAyR0Igb2Yg
bWFpbiBtZW1vcnkgaXMNCj4gc3VwcG9ydGVkLg0KPiArDQo+ICtRdWljayBTdGFydA0KPiArLS0t
LS0tLS0tLS0NCj4gKw0KPiArLSBCdWlsZCB0aGUgQVJNIFRydXN0ZWQgZmlybXdhcmUgYmluYXJ5
DQo+ICstIEdldCBkZHIgZmlybXdhcmUNCj4gKy0gQnVpbGQgVS1Cb290DQo+ICstIEJvb3QNCj4g
Kw0KPiArQnVpbGQgdGhlIEFSTSBUcnVzdGVkIGZpcm13YXJlIGJpbmFyeQ0KPiArLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiArDQo+ICsuLiBjb2RlLWJsb2NrOjogYmFz
aA0KPiArDQo+ICvCoMKgICQgZ2l0IGNsb25lDQo+IGh0dHBzOi8vZ2l0LnRydXN0ZWRmaXJtd2Fy
ZS5vcmcvVEYtQS90cnVzdGVkLWZpcm13YXJlLWEuZ2l0DQo+ICvCoMKgICQgY2QgdHJ1c3RlZC1m
aXJtd2FyZS1hDQo+ICvCoMKgICQgZXhwb3J0IENST1NTX0NPTVBJTEU9YWFyY2g2NC1saW51eC1n
bnUNCj4gK8KgwqAgJCBleHBvcnQgSU1YX0JPT1RfVUFSVF9CQVNFPTB4MzA4ODAwMDANCj4gK8Kg
wqAgJCBtYWtlIFBMQVQ9aW14OG1tIGJsMzENCj4gKw0KPiArR2V0IHRoZSBkZHIgZmlybXdhcmUN
Cj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICsNCj4gKy4uIGNvZGUtYmxvY2s6OiBiYXNoDQo+
ICsNCj4gK8KgwqAgJCB3Z2V0DQo+IGh0dHBzOi8vd3d3Lm54cC5jb20vbGdmaWxlcy9OTUcvTUFE
L1lPQ1RPL2Zpcm13YXJlLWlteC04LjIzLmJpbg0KPiArwqDCoCAkIGNobW9kICt4IGZpcm13YXJl
LWlteC04LjIzLmJpbg0KPiArwqDCoCAkIC4vZmlybXdhcmUtaW14LTguMjMuYmluDQo+ICsNCj4g
K0J1aWxkIFUtQm9vdCBmb3IgU0QgY2FyZA0KPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+
ICsNCj4gK0NvcHkgYmluYXJpZXMNCj4gK15eXl5eXl5eXl5eXl4NCj4gKw0KPiArLi4gY29kZS1i
bG9jazo6IGJhc2gNCj4gKw0KPiArwqDCoCAkIGNwIDxURi1BIGRpcj4vYnVpbGQvaW14OG1tL3Jl
bGVhc2UvYmwzMS5iaW4gLg0KPiArwqDCoCAkIGNwIGZpcm13YXJlLWlteC04LjIzL2Zpcm13YXJl
L2Rkci9zeW5vcHN5cy9scGRkcjQqLmJpbiAuDQo+ICsNCj4gK0J1aWxkIFUtQm9vdA0KPiArXl5e
Xl5eXl5eXl5eDQo+ICsNCj4gKy4uIGNvZGUtYmxvY2s6OiBiYXNoDQo+ICsNCj4gK8KgwqAgJCBt
YWtlIGlteDhtbS1waHlnYXRlLXRhdXJpLWxfZGVmY29uZmlnDQo+ICvCoMKgICQgbWFrZSBmbGFz
aC5iaW4NCj4gKw0KPiArRmxhc2ggU0QgY2FyZA0KPiArXl5eXl5eXl5eXl5eXg0KPiArDQo+ICsu
LiBjb2RlLWJsb2NrOjogYmFzaA0KPiArDQo+ICvCoMKgICQgc3VkbyBkZCBpZj1mbGFzaC5iaW4g
b2Y9L2Rldi9zZFt4XSBicz0xMDI0IHNlZWs9MzMgY29udj1zeW5jDQo+IGRpZmYgLS1naXQgYS9k
b2MvYm9hcmQvcGh5dGVjL2luZGV4LnJzdCBiL2RvYy9ib2FyZC9waHl0ZWMvaW5kZXgucnN0DQo+
IGluZGV4IGE1YjQ0MjA0NWVkLi45OTk2YmNlOTc0MSAxMDA2NDQNCj4gLS0tIGEvZG9jL2JvYXJk
L3BoeXRlYy9pbmRleC5yc3QNCj4gKysrIGIvZG9jL2JvYXJkL3BoeXRlYy9pbmRleC5yc3QNCj4g
QEAgLTYsNSArNiw2IEBAIFBIWVRFQw0KPiDCoC4uIHRvY3RyZWU6Og0KPiDCoMKgwqAgOm1heGRl
cHRoOiAyDQo+IMKgDQo+ICvCoMKgIGlteDhtbS1waHlnYXRlLXRhdXJpLWwNCj4gwqDCoMKgIHBo
eWNvcmUtaW14OG1tDQo+IMKgwqDCoCBwaHljb3JlLWlteDhtcA0KPiANCg0KLS0gDQpQSFlURUMg
TWVzc3RlY2huaWsgR21iSCB8IEJhcmNlbG9uYS1BbGxlZSAxIHwgNTUxMjkgTWFpbnosIEdlcm1h
bnkNCg0KR2VzY2jDpGZ0c2bDvGhyZXI6IERpcGwuLUluZy4gTWljaGFlbCBNaXRlemtpLCBEaXBs
Li1JbmcuIEJvZG8gSHViZXIsDQpEaXBsLi1JbmcuIChGSCkgTWFya3VzIExpY2tlcyB8IEhhbmRl
bHNyZWdpc3RlciBNYWlueiBIUkIgNDY1NiB8DQpGaW5hbnphbXQgTWFpbnogfCBTdC5Oci4gMjY2
NTAwNjA4LCBERSAxNDkwNTk4NTUNCg==
