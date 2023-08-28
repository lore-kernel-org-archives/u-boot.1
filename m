Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F44C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 12:33:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1814852DB;
	Mon, 28 Aug 2023 14:33:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="qqo3LIjo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03F7C864B7; Mon, 28 Aug 2023 14:33:19 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C23A80295
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 14:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1693225996; x=1695817996;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z/t72Wfx3rxL/46tZBWzb0l3oD9rQRaTm2gmsq2uINc=;
 b=qqo3LIjoz5JTTsFffwI72Ye4VT8fZYpU98fFXwCWyxukkv8oxEUvPv1j+rJsRHxZ
 b0X4q20kKTtVjLzigmE5l+spFRrQcRZx7o8ksy57t4LtUkqHd36qEVSl11hEk7IW
 Xjx7aEPQu9r0krBeQOEoidHVFuDkeohoj5OwXbChlaQ=;
X-AuditID: ac14000a-923ff70000007ecb-29-64ec940c8298
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id A2.54.32459.C049CE46;
 Mon, 28 Aug 2023 14:33:16 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Aug
 2023 14:33:16 +0200
Received: from Berlix.phytec.de ([fe80::61cc:ebf0:7375:8768]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2375.018;
 Mon, 28 Aug 2023 14:33:16 +0200
From: Yannic Moog <Y.Moog@phytec.de>
To: "festevam@gmail.com" <festevam@gmail.com>, "uboot-imx@nxp.com"
 <uboot-imx@nxp.com>, "sbabic@denx.de" <sbabic@denx.de>, Teresa Remmet
 <T.Remmet@phytec.de>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Daniel Schultz
 <D.Schultz@phytec.de>, Wadim Egorov <W.Egorov@phytec.de>
Subject: Re: [PATCH v2 5/6] board: phytec: common: phytec_som_detection: Add
 helper for PCB revision
Thread-Topic: [PATCH v2 5/6] board: phytec: common: phytec_som_detection: Add
 helper for PCB revision
Thread-Index: AQHZ0OjXJ1Ha1S0MVkaPs2OBVQGg7q//lEiA
Date: Mon, 28 Aug 2023 12:33:16 +0000
Message-ID: <5a0c96f3218d68e3ac366550d1f1a5eca6ba0e37.camel@phytec.de>
References: <20230817085711.45339-1-t.remmet@phytec.de>
 <20230817085711.45339-6-t.remmet@phytec.de>
In-Reply-To: <20230817085711.45339-6-t.remmet@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <34F2EB95E5B5124EB9730087BAA89122@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsWyRpKBR5dnypsUg6ZjIhYPr/pbtJ/ysXi7
 t5PdYsrj9ewW3e/UHVg95s06weKxc9Zddo+zd3YwevR3t7B6bHy3gymANYrLJiU1J7MstUjf
 LoEr4+TKk6wFjyQqmvqXMDUwTpDoYuTkkBAwkZiy8T5jFyMXh5DAEiaJzns/WSGcB4wSV3/8
 YYFwNjJKfNvazwbSwiagInFyxiWwFhGBhYwSJ3c8ZgdxmAW2MkosaZrFCFIlLJAmcej7W1YQ
 W0QgXeLNhEXsELaRxLw9X5m7GDk4WARUJW5ddwQJ8wq4SRyYfgpsgRBQa++dpUwgNqeAhcTh
 rsMsIDajgKzEhg3nmUFsZgFxiU3PvrNC/CAgsWQPRFxCQFTi5eN/UHF5iRO3pjGBrGIW0JRY
 v0sfotVC4kTnCyYIW1FiSvdDdogTBCVOznzCMoFRfBaSDbMQumch6Z6FpHsWku4FjKyrGIVy
 M5OzU4sys/UKMipLUpP1UlI3MYIiVISBawdj3xyPQ4xMHIyHGCU4mJVEeC85vkoR4k1JrKxK
 LcqPLyrNSS0+xCjNwaIkznu/hylRSCA9sSQ1OzW1ILUIJsvEwSnVwJhW6MK7Xqwtoc06e7Xl
 67q9FbLWnD7qE14Gn0zh6t+w9uzGziyjXKYvKYIb9ofNVLhSp/nVXXnFpgSp5oIa8eTHt5/u
 87c4t66G9+b0LU23Poj4FO+tPzZp+9nN/2I2nTr1WVR69/frYTMnrzJcM9P/k+o9N2lOwxT2
 DUe7t/Od8Q/4bizxy0qJpTgj0VCLuag4EQB6jyhyvgIAAA==
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
PiBBZGQgaGVscGVyIGZ1bmN0aW9uIHRvIHJlYWQgb3V0IHRoZSBQQ0IgcmV2aXNpb24gb2YgYSBQ
SFlURUMgU29NLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVGVyZXNhIFJlbW1ldCA8dC5yZW1tZXRA
cGh5dGVjLmRlPg0KDQpSZXZpZXdlZC1ieTogWWFubmljIE1vb2cgPHkubW9vZ0BwaHl0ZWMuZGU+
DQpUZXN0ZWQtYnk6IFlhbm5pYyBNb29nIDx5Lm1vb2dAcGh5dGVjLmRlPg0KDQo+IC0tLQ0KPiBD
aGFuZ2VzIGluIHYyOg0KPiAtIG5vbmUNCj4gLS0tDQo+IMKgYm9hcmQvcGh5dGVjL2NvbW1vbi9w
aHl0ZWNfc29tX2RldGVjdGlvbi5jIHwgMTUgKysrKysrKysrKysrKysrDQo+IMKgYm9hcmQvcGh5
dGVjL2NvbW1vbi9waHl0ZWNfc29tX2RldGVjdGlvbi5oIHzCoCA1ICsrKysrDQo+IMKgMiBmaWxl
cyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYm9hcmQvcGh5
dGVjL2NvbW1vbi9waHl0ZWNfc29tX2RldGVjdGlvbi5jDQo+IGIvYm9hcmQvcGh5dGVjL2NvbW1v
bi9waHl0ZWNfc29tX2RldGVjdGlvbi5jDQo+IGluZGV4IDM2NmJkZDRhY2U0Yi4uNTU1NjI3MzEy
NzBiIDEwMDY0NA0KPiAtLS0gYS9ib2FyZC9waHl0ZWMvY29tbW9uL3BoeXRlY19zb21fZGV0ZWN0
aW9uLmMNCj4gKysrIGIvYm9hcmQvcGh5dGVjL2NvbW1vbi9waHl0ZWNfc29tX2RldGVjdGlvbi5j
DQo+IEBAIC0xODYsMyArMTg2LDE4IEBAIGNoYXIgKiBfX21heWJlX3VudXNlZCBwaHl0ZWNfZ2V0
X29wdChzdHJ1Y3QNCj4gcGh5dGVjX2VlcHJvbV9kYXRhICpkYXRhKQ0KPiDCoA0KPiDCoMKgwqDC
oMKgwqDCoMKgcmV0dXJuIG9wdDsNCj4gwqB9DQo+ICsNCj4gK3U4IF9fbWF5YmVfdW51c2VkIHBo
eXRlY19nZXRfcmV2KHN0cnVjdCBwaHl0ZWNfZWVwcm9tX2RhdGEgKmRhdGEpDQo+ICt7DQo+ICvC
oMKgwqDCoMKgwqDCoHN0cnVjdCBwaHl0ZWNfYXBpMl9kYXRhICphcGkyOw0KPiArDQo+ICvCoMKg
wqDCoMKgwqDCoGlmICghZGF0YSkNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRh
dGEgPSAmZWVwcm9tX2RhdGE7DQo+ICsNCj4gK8KgwqDCoMKgwqDCoMKgaWYgKGRhdGEtPmFwaV9y
ZXYgPCBQSFlURUNfQVBJX1JFVjIpDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBy
ZXR1cm4gUEhZVEVDX0VFUFJPTV9JTlZBTDsNCj4gKw0KPiArwqDCoMKgwqDCoMKgwqBhcGkyID0g
JmRhdGEtPmRhdGEuZGF0YV9hcGkyOw0KPiArDQo+ICvCoMKgwqDCoMKgwqDCoHJldHVybiBhcGky
LT5wY2JfcmV2Ow0KPiArfQ0KPiBkaWZmIC0tZ2l0IGEvYm9hcmQvcGh5dGVjL2NvbW1vbi9waHl0
ZWNfc29tX2RldGVjdGlvbi5oDQo+IGIvYm9hcmQvcGh5dGVjL2NvbW1vbi9waHl0ZWNfc29tX2Rl
dGVjdGlvbi5oDQo+IGluZGV4IDAxZjdlNDY1MmRkYi4uYzY4ZTIzMDJjYzQyIDEwMDY0NA0KPiAt
LS0gYS9ib2FyZC9waHl0ZWMvY29tbW9uL3BoeXRlY19zb21fZGV0ZWN0aW9uLmgNCj4gKysrIGIv
Ym9hcmQvcGh5dGVjL2NvbW1vbi9waHl0ZWNfc29tX2RldGVjdGlvbi5oDQo+IEBAIC02OCw2ICs2
OCw3IEBAIGludCBwaHl0ZWNfZWVwcm9tX2RhdGFfaW5pdChzdHJ1Y3QNCj4gcGh5dGVjX2VlcHJv
bV9kYXRhICpkYXRhLA0KPiDCoHZvaWQgX19tYXliZV91bnVzZWQgcGh5dGVjX3ByaW50X3NvbV9p
bmZvKHN0cnVjdCBwaHl0ZWNfZWVwcm9tX2RhdGENCj4gKmRhdGEpOw0KPiDCoA0KPiDCoGNoYXIg
KiBfX21heWJlX3VudXNlZCBwaHl0ZWNfZ2V0X29wdChzdHJ1Y3QgcGh5dGVjX2VlcHJvbV9kYXRh
DQo+ICpkYXRhKTsNCj4gK3U4IF9fbWF5YmVfdW51c2VkIHBoeXRlY19nZXRfcmV2KHN0cnVjdCBw
aHl0ZWNfZWVwcm9tX2RhdGEgKmRhdGEpOw0KPiDCoA0KPiDCoCNlbHNlDQo+IMKgDQo+IEBAIC05
OSw2ICsxMDAsMTAgQEAgaW5saW5lIGNoYXIgKl9fbWF5YmVfdW51c2VkIHBoeXRlY19nZXRfb3B0
KHN0cnVjdA0KPiBwaHl0ZWNfZWVwcm9tX2RhdGEgKmRhdGEpDQo+IMKgwqDCoMKgwqDCoMKgwqBy
ZXR1cm4gTlVMTDsNCj4gwqB9DQo+IMKgDQo+ICt1OCBfX21heWJlX3VudXNlZCBwaHl0ZWNfZ2V0
X3JldihzdHJ1Y3QgcGh5dGVjX2VlcHJvbV9kYXRhICpkYXRhKQ0KPiArew0KPiArwqDCoMKgwqDC
oMKgwqByZXR1cm4gUEhZVEVDX0VFUFJPTV9JTlZBTDsNCj4gK30NCj4gwqAjZW5kaWYgLyogSVNf
RU5BQkxFRChDT05GSUdfUEhZVEVDX1NPTV9ERVRFQ1RJT04pICovDQo+IMKgDQo+IMKgI2VuZGlm
IC8qIF9QSFlURUNfU09NX0RFVEVDVElPTl9IICovDQoNCg==
