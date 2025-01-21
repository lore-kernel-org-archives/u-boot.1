Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8CEC02181
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 02:38:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8901800CF;
	Tue, 21 Jan 2025 03:38:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Oafbsjhg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56798801CF; Tue, 21 Jan 2025 03:38:26 +0100 (CET)
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [IPv6:2001:df5:b000:5::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D0F6800C2
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 03:38:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Chris.Packham@alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9E3672C0D7A;
 Tue, 21 Jan 2025 15:38:16 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
 s=mail181024; t=1737427096;
 bh=rjWRLcY8z+0VasZD26eeo4zqXOHDZxKtqSsyl3D87zI=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=OafbsjhgBE+0OgDqp6vdAoawLb03TdDA/h/TBLOpQ0b1en+KKvuf3qJSMdP9nNmqF
 vkd6/ji6FKCR6ER0E926PBrYRyHUXkenlWEE8o8yWG6969FzdXxhOPFTRCbP1mDX03
 iamCxNMjkIu7Y/sSDRAfjEB9fByeVmvKDBUhxySNZxrFbmQOTaP+XjwKTEW411SC57
 26RQh68jQZnwSRHyo/hseLG6T9xlRdFog7rjc1j45UoYEmE38VnT8gqETrL6qzWlVc
 rdzFdv8jnThoK01NWnNjhInbR7uLlk4VPNU/4mDGj+qoxROndxZ4sxr9n5trZOaq2t
 2p22Bt2U5UB3g==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by
 svr-chch-seg1.atlnz.lc with Trustwave SEG (v8, 2, 6, 11305)
 id <B678f08980000>; Tue, 21 Jan 2025 15:38:16 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jan 2025 15:38:16 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Tue, 21 Jan 2025 15:38:16 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Mark Tomlinson <Mark.Tomlinson@alliedtelesis.co.nz>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Chris Packham <judge.packham@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/2] drivers: rtc: max313xx: Fix setting years 2100-2199
Thread-Topic: [PATCH 1/2] drivers: rtc: max313xx: Fix setting years 2100-2199
Thread-Index: AQHba62GOhZ5ci2X+E+xJmBI7OSJZQ==
Date: Tue, 21 Jan 2025 02:38:16 +0000
Message-ID: <8ff6dd62-63af-49bf-9529-a966d6e9837a@alliedtelesis.co.nz>
References: <20250120015941.1849667-1-mark.tomlinson@alliedtelesis.co.nz>
In-Reply-To: <20250120015941.1849667-1-mark.tomlinson@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <851D75B2828206499FF5A26038E79722@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BNQQr0QG c=1 sm=1 tr=0 ts=678f0898
 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10
 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=pGLkceISAAAA:8 a=pSk1HE5lBlezLuTHFRMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kkB4UJddPxAZW7rNxBJ9:22
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

UmVwbHlpbmcgZnJvbSBteSB3b3JrIGVtYWlsIGJlY2F1c2UgZ21haWwgc2VlbXMgdG8gYmUgZGlz
Y2FyZGluZyBtZXNzYWdlcw0KDQpPbiAyMC8wMS8yMDI1IDE0OjU5LCBNYXJrIFRvbWxpbnNvbiB3
cm90ZToNCj4gQW4gaW52YWxpZCBjYWxjdWxhdGlvbiBtYWRlIHNldHRpbmcgeWVhcnMgMjEwMC0y
MTk5IGltcG9zc2libGUuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IE1hcmsgVG9tbGluc29uIDxtYXJr
LnRvbWxpbnNvbkBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPiBDYzogQ2hyaXMgUGFja2hhbSA8anVk
Z2UucGFja2hhbUBnbWFpbC5jb20+DQpSZXZpZXdlZC1ieTogQ2hyaXMgUGFja2hhbSA8anVkZ2Uu
cGFja2hhbUBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvcnRjL21heDMxM3h4LmMgfCAy
ICstDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3J0Yy9tYXgzMTN4eC5jIGIvZHJpdmVycy9ydGMvbWF4
MzEzeHguYw0KPiBpbmRleCA2MDQwMDIzNWRkMC4uY2NmZDZiNmQwZTIgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvcnRjL21heDMxM3h4LmMNCj4gKysrIGIvZHJpdmVycy9ydGMvbWF4MzEzeHguYw0K
PiBAQCAtMjg1LDcgKzI4NSw3IEBAIHN0YXRpYyBpbnQgbWF4MzEzeHhfc2V0X3RpbWUoc3RydWN0
IHVkZXZpY2UgKmRldiwgY29uc3Qgc3RydWN0IHJ0Y190aW1lICp0KQ0KPiAgIAlyZWdzWzVdID0g
YmluMmJjZCh0LT50bV9tb24pOw0KPiAgIAlyZWdzWzZdID0gYmluMmJjZCgodC0+dG1feWVhciAt
IDIwMDApICUgMTAwKTsNCj4gICANCj4gLQlpZiAoKHQtPnRtX3llYXIgLSAyMDAwKSA+PSAyMDAp
DQo+ICsJaWYgKHQtPnRtX3llYXIgPj0gMjEwMCkNCj4gICAJCXJlZ3NbNV0gfD0gRklFTERfUFJF
UChNQVgzMTNYWF9NT05USF9DRU5UVVJZLCAxKTsNCj4gICANCj4gICAJcmV0ID0gZG1faTJjX3dy
aXRlKGRldiwgcnRjLT5jaGlwLT5zZWNfcmVnLCByZWdzLCA3KTs=
