Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376E8C47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 10:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84B7E87AAB;
	Thu, 11 Jan 2024 11:56:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="YnUd7XH6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A3EF87883; Thu, 11 Jan 2024 11:56:15 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8961E87A99
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 11:56:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=T.Remmet@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1704970573; x=1707562573;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9YtpavA8dKI2y7UB/BrQmWFK0aFB6PJQ8rDebd3O0uY=;
 b=YnUd7XH6jCawcnjLJrY5PczGg7kPXqd61DG+OdAs0knGsoqrX4yymS3vOK7vdEzJ
 mZbToCmEvy7IUwT3DGkwXxCRkVNG6k0xsVYsIrwsnxdVzBGdugweJzc9Hau3mKT8
 tHroksRyRYLNNJQJp/dLAZtR9kFCvaO9uXWcRLfevlo=;
X-AuditID: ac14000a-fbefe7000000290d-9c-659fc94d3adc
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 72.6A.10509.D49CF956;
 Thu, 11 Jan 2024 11:56:13 +0100 (CET)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 11 Jan
 2024 11:56:13 +0100
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Thu, 11 Jan 2024 11:56:13 +0100
From: Teresa Remmet <T.Remmet@phytec.de>
To: "festevam@gmail.com" <festevam@gmail.com>, "uboot-imx@nxp.com"
 <uboot-imx@nxp.com>, Yannic Moog <Y.Moog@phytec.de>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 3/3] board: phytec: MAINTAINERS: add missing phytec doc
 files
Thread-Topic: [PATCH v2 3/3] board: phytec: MAINTAINERS: add missing phytec
 doc files
Thread-Index: AQHaQ8nwYO10s9cPL02tW0sL/cN0I7DUYT0A
Date: Thu, 11 Jan 2024 10:56:13 +0000
Message-ID: <981fd3e1e90028f5b532141812115e6ceede9ca7.camel@phytec.de>
References: <20240110-wip-y-moog-phytec-de-tauri-l_upstream-v2-0-4ea2dd6a4f74@phytec.de>
 <20240110-wip-y-moog-phytec-de-tauri-l_upstream-v2-3-4ea2dd6a4f74@phytec.de>
In-Reply-To: <20240110-wip-y-moog-phytec-de-tauri-l_upstream-v2-3-4ea2dd6a4f74@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5589D05783D675478E9FB4B5E1C4CB06@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsWyRpKBR9f35PxUgy/XJSweXvW3eLu3k91i
 yuP17Bbd79QdWDx2zrrL7nH2zg5Gj/7uFlaPje92MAWwRHHZpKTmZJalFunbJXBlfJ4gUXBJ
 uOJ0x0mWBsYJwl2MnBwSAiYSq39MZOpi5OIQEljMJHHm22o2COc+o8TtE6/YQKqEBDYwSkxd
 WAdiswloSLw80c0EYosIVEj0n13FCmIzC2RJ/L84C6xeWCBMYuPSfmaImnCJH0+fQtlGEkse
 7gGq4eBgEVCVWDtRBiTMK+AmseVtPwvE3hWMEscPPwGbySkQKbGy6zNYL6OArMSGDeeZIXaJ
 S2x69p0V4gMBiSV7IOISAqISLx//g4rLS5y4NY0JZBezgKbE+l36EK0WEs/P7GCEsBUlpnQ/
 ZIe4QVDi5MwnLBMYxWch2TALoXsWku5ZSLpnIelewMi6ilEoNzM5O7UoM1uvIKOyJDVZLyV1
 EyMoEkUYuHYw9s3xOMTIxMF4iFGCg1lJhFfh85xUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryr
 O4JThQTSE0tSs1NTC1KLYLJMHJxSDYzr8y/sVft9qGDttejsVWVPZ3JfMr1necd/+rcWIw+l
 NayrCvgDi/ZItfz8JRyaY+aUuSbHUGKRevaX0xztLR/eXC9i8u+5z9zyoKrIuE91ypX9m1c/
 Na/PiUlaPs2hQsEqTLBE98b2Wp65RtU6U7iuJhTNrVFY1XE4nPVPqtpegz+rtmbIb1RiKc5I
 NNRiLipOBAAlLCbRsgIAAA==
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
IE1vb2c6DQo+IEFkZCByc3QgZG9jdW1lbnRhdGlvbiBmaWxlcyB0byB0aGUgcmVzcGVjdGl2ZSBN
QUlOVEFJTkVSUyBmaWxlIGZvcg0KPiBQSFlURUMgYm9hcmRzLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogWWFubmljIE1vb2cgPHkubW9vZ0BwaHl0ZWMuZGU+DQoNClJldmlld2VkLWJ5OiBUZXJlc2Eg
UmVtbWV0IDx0LnJlbW1ldEBwaHl0ZWMuZGU+DQoNCj4gLS0tDQo+IMKgYm9hcmQvcGh5dGVjL3Bo
eWNvcmVfaW14OG1tL01BSU5UQUlORVJTIHwgMSArDQo+IMKgYm9hcmQvcGh5dGVjL3BoeWNvcmVf
aW14OG1wL01BSU5UQUlORVJTIHwgMSArDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bW0vTUFJ
TlRBSU5FUlMNCj4gYi9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bW0vTUFJTlRBSU5FUlMNCj4g
aW5kZXggY2Y2ZjkyYzA3ZTUuLmU0NmUzNjkxYmFjIDEwMDY0NA0KPiAtLS0gYS9ib2FyZC9waHl0
ZWMvcGh5Y29yZV9pbXg4bW0vTUFJTlRBSU5FUlMNCj4gKysrIGIvYm9hcmQvcGh5dGVjL3BoeWNv
cmVfaW14OG1tL01BSU5UQUlORVJTDQo+IEBAIC0xMiw0ICsxMiw1IEBAIEY6wqDCoMKgwqBjb25m
aWdzL2lteDhtbS1waHlnYXRlLXRhdXJpLWxfZGVmY29uZmlnDQo+IMKgRjrCoMKgwqDCoMKgIGNv
bmZpZ3MvcGh5Y29yZS1pbXg4bW1fZGVmY29uZmlnDQo+IMKgRjrCoMKgwqDCoMKgZG9jL2JvYXJk
L3BoeXRlYy9pbXg4bW0tcGh5Z2F0ZS10YXVyaS1sLnJzdA0KPiDCoEY6wqDCoMKgwqDCoGRvYy9i
b2FyZC9waHl0ZWMvaW5kZXgucnN0DQo+ICtGOsKgwqDCoMKgwqBkb2MvYm9hcmQvcGh5dGVjL3Bo
eWNvcmVfaW14OG1tLnJzdA0KPiDCoEY6wqDCoMKgwqDCoCBpbmNsdWRlL2NvbmZpZ3MvcGh5Y29y
ZV9pbXg4bW0uaA0KPiBkaWZmIC0tZ2l0IGEvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1wL01B
SU5UQUlORVJTDQo+IGIvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1wL01BSU5UQUlORVJTDQo+
IGluZGV4IGNiN2NlNTU4YTgxLi5kM2JlYjk3OGQzYSAxMDA2NDQNCj4gLS0tIGEvYm9hcmQvcGh5
dGVjL3BoeWNvcmVfaW14OG1wL01BSU5UQUlORVJTDQo+ICsrKyBiL2JvYXJkL3BoeXRlYy9waHlj
b3JlX2lteDhtcC9NQUlOVEFJTkVSUw0KPiBAQCAtNiw0ICs2LDUgQEAgRjrCoMKgwqDCoMKgIGFy
Y2gvYXJtL2R0cy9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay5kdHMNCj4gwqBGOsKgwqDCoMKg
wqAgYXJjaC9hcm0vZHRzL2lteDhtcC1waHlib2FyZC1wb2xsdXgtcmRrLXUtYm9vdC5kdHNpDQo+
IMKgRjrCoMKgwqDCoMKgIGJvYXJkL3BoeXRlYy9waHljb3JlX2lteDhtcC8NCj4gwqBGOsKgwqDC
oMKgwqAgY29uZmlncy9waHljb3JlLWlteDhtcF9kZWZjb25maWcNCj4gK0Y6wqDCoMKgwqDCoGRv
Yy9ib2FyZC9waHl0ZWMvcGh5Y29yZS1pbXg4bXAucnN0DQo+IMKgRjrCoMKgwqDCoMKgIGluY2x1
ZGUvY29uZmlncy9waHljb3JlX2lteDhtcC5oDQo+IA0KDQotLSANClBIWVRFQyBNZXNzdGVjaG5p
ayBHbWJIIHwgQmFyY2Vsb25hLUFsbGVlIDEgfCA1NTEyOSBNYWlueiwgR2VybWFueQ0KDQpHZXNj
aMOkZnRzZsO8aHJlcjogRGlwbC4tSW5nLiBNaWNoYWVsIE1pdGV6a2ksIERpcGwuLUluZy4gQm9k
byBIdWJlciwNCkRpcGwuLUluZy4gKEZIKSBNYXJrdXMgTGlja2VzIHwgSGFuZGVsc3JlZ2lzdGVy
IE1haW56IEhSQiA0NjU2IHwNCkZpbmFuemFtdCBNYWlueiB8IFN0Lk5yLiAyNjY1MDA2MDgsIERF
IDE0OTA1OTg1NQ0K
