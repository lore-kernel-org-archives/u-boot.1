Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A53CCA0EE4
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 00:31:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A554F832F0;
	Mon, 18 Aug 2025 02:31:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="z5nbb+He";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA58083314; Mon, 18 Aug 2025 02:31:34 +0200 (CEST)
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [202.36.163.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B3F6831E4
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 02:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Chris.Packham@alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D8FB82C0330;
 Mon, 18 Aug 2025 12:31:26 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
 s=mail181024; t=1755477086;
 bh=Nr8DIOXkOKOtZtgg8Q3ImYQt8GwgVnFBDLrihBpHXuc=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=z5nbb+HeKxnEhuTQXy6L8dhUzUBC2U3/90dgSqgtoqFSCHYLkA1vgmpkfIF+vAQ5d
 K3GWYKg1itCdXCl/LWFYB8cNm3NGiKB8I6x3UpvzLuatClaknRZIVyCktTawJRIuJz
 7zAwaBHT0BLjbUeGRkoitOGD0QRYHZUfOlYNSYTp1QP6QXKoskkrRgeLE1X30Ds9hL
 x18jce7HKXZYywMmS4qavw9rZYnGMx1mYQi+kw1CieEhHHQcKTtqQ5jLBd6rB54iSw
 +VbUKC/6mr6R71jJoVaRgUFCYLIjYINgeU7nVZPOM3sOzvq1bXx/GHvKCVjH4vabfj
 9QdGElsDezDbg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by
 svr-chch-seg1.atlnz.lc with Trustwave SEG (v8, 2, 6, 11305)
 id <B68a2745e0000>; Mon, 18 Aug 2025 12:31:26 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 18 Aug 2025 12:31:26 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.014; Mon, 18 Aug 2025 12:31:26 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Ben Hoelker <Ben.Hoelker@alliedtelesis.co.nz>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Bruce Adams <Bruce.Adams@alliedtelesis.co.nz>, Mark Tomlinson
 <Mark.Tomlinson@alliedtelesis.co.nz>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] drivers: rtc: max313xx: Add delay after setting date
Thread-Topic: [PATCH] drivers: rtc: max313xx: Add delay after setting date
Thread-Index: AQHcD8bXHQdtWRzjIk2y5vkNviwOQbRmxiQA
Date: Mon, 18 Aug 2025 00:31:26 +0000
Message-ID: <4054f6d2-e570-4f50-b538-abce156e8731@alliedtelesis.co.nz>
References: <20250818102959.1.I51da487efb143e03f6609e584f452e5aae1c9e9a@changeid>
In-Reply-To: <20250818102959.1.I51da487efb143e03f6609e584f452e5aae1c9e9a@changeid>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A13E8A85BA34E4796CC52159BEC07C2@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=dtt4CEg4 c=1 sm=1 tr=0 ts=68a2745e
 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=6WUYveBszS4Gzd4hnDcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
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

SGkgQmVuLA0KDQpPbiAxOC8wOC8yMDI1IDEwOjMwLCBCZW4gSG9lbGtlciB3cm90ZToNCj4gVGhl
IE1BWDMxMzMxIHdhcyBub3QgY29ycmVjdGx5IHVwZGF0aW5nIHRoZSBzZWNvbmRzIHdoZW4NCj4g
c2V0dGluZyB0aGUgdGltZSBhbmQgd291bGQgcmV0dXJuIHRoZSBzZWNvbmRzIHByZXZpb3VzbHkg
c2V0Lg0KPg0KPiBMaWtlIHRoZSBNQVgzMTM0MywgYSBkZWxheSBuZWVkcyB0byBiZSBhZGRlZCBh
ZnRlciBzZXR0aW5nIHRoZQ0KPiB0aW1lLiBXYWl0IG9uZSBzZWNvbmQgYWZ0ZXIgd3JpdGluZyBz
byB0aGF0IHRoZSBkYXRlIGNvbW1hbmQgc2hvd3MgdGhlDQo+IGNvcnJlY3QgdGltZS4NCj4NCj4g
UmV2aWV3ZWQtYnk6IENocmlzIFBhY2toYW0gPGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5j
by5uej4NCj4gUmV2aWV3ZWQtYnk6IEJydWNlIEFkYW1zIDxicnVjZS5hZGFtc0BhbGxpZWR0ZWxl
c2lzLmNvLm56Pg0KV2hlbiBzZW5kaW5nIGNoYW5nZXMgdXBzdHJlYW0gdGhlIHItYnkgc2hvdWxk
IGNvbWUgZnJvbSBhIHJlc3BvbmRlciBvbiANCnRoZSBsaXN0IGFuZCB3aWxsIGJlIGNvbGxlY3Rl
ZCBieSB0aGUgbWFpbnRhaW5lciBhcHBseWluZyB0aGUgcGF0Y2guIFlvdSANCmNhbiBpbmNsdWRl
IGl0IG9uIHYyIG9mIGEgcGF0Y2ggKGlmIGl0IGhhcyBiZWVuIG9mZmVyZWQpLg0KPiBTaWduZWQt
b2ZmLWJ5OiBCZW4gSG9lbGtlciA8YmVuLmhvZWxrZXJAYWxsaWVkdGVsZXNpcy5jby5uej4NClRo
ZSBhYm92ZSBhc2lkZQ0KDQpSZXZpZXdlZC1ieTogQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFja2hh
bUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KDQo+IC0tLQ0KPg0KPiAgIGRyaXZlcnMvcnRjL21heDMx
M3h4LmMgfCAxICsNCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4NCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcnRjL21heDMxM3h4LmMgYi9kcml2ZXJzL3J0Yy9tYXgzMTN4eC5j
DQo+IGluZGV4IDJjYjNmMjQ1MDQxLi5mMGQzOGIxMGM5NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9ydGMvbWF4MzEzeHguYw0KPiArKysgYi9kcml2ZXJzL3J0Yy9tYXgzMTN4eC5jDQo+IEBAIC0z
MDgsNiArMzA4LDcgQEAgc3RhdGljIGludCBtYXgzMTN4eF9zZXRfdGltZShzdHJ1Y3QgdWRldmlj
ZSAqZGV2LCBjb25zdCBzdHJ1Y3QgcnRjX3RpbWUgKnQpDQo+ICAgCQkJcmV0dXJuIHJldDsNCj4g
ICANCj4gICAJCWJyZWFrOw0KPiArCWNhc2UgSURfTUFYMzEzMzE6DQo+ICAgCWNhc2UgSURfTUFY
MzEzNDM6DQo+ICAgCQkvKiBUaW1lIGlzIG5vdCB1cGRhdGVkIGZvciAxIHNlY29uZCBhZnRlciB3
cml0aW5nICovDQo+ICAgCQkvKiBTbGVlcCBoZXJlIHNvIHRoZSBkYXRlIGNvbW1hbmQgc2hvd3Mg
dGhlIG5ldyB0aW1lICov
