Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD95AC02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 02:38:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D3D280758;
	Tue, 21 Jan 2025 03:38:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="atA03MBy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 519CB80759; Tue, 21 Jan 2025 03:38:42 +0100 (CET)
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [202.36.163.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB6B180326
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 03:38:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Chris.Packham@alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id BC75C2C0DBB;
 Tue, 21 Jan 2025 15:38:36 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
 s=mail181024; t=1737427116;
 bh=euFlyJ4ELUMnmprlbV6zr9QMG3XcVq9M6QuJIh6pi1U=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=atA03MByqGpKzAcRsvFIG6CYJMsku6fM+FWOmaJTd6S1oLRxNiDeUm2dbJZuClAhC
 s90FkrIh+Is4o5O7ZJwcAxFKcueRK6rD89iI4IN4Jup+tITSztrtMaAM54/C1CnmDr
 tOKHlWJvYMYEmGtFRRIkdRdYZW2uWL5gKS0BzeLCgLWWC3QE1fJ8xudTWmHcWb9KRM
 KSpAnO+gC0j/JD7GkSJbgcxg5N6BsBro4wB+A7vdANkUfcTyPwyfgdGIPoVYKtKjQG
 rkWzo7K70IBuhUcXzePBA6tQ3wti++XNsSvLgzHbWKeGeHzNWxAGza877zmeyMZKuv
 mpgQI4oPi4l8A==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by
 svr-chch-seg1.atlnz.lc with Trustwave SEG (v8, 2, 6, 11305)
 id <B678f08ac0000>; Tue, 21 Jan 2025 15:38:36 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jan 2025 15:38:36 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Tue, 21 Jan 2025 15:38:36 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Mark Tomlinson <Mark.Tomlinson@alliedtelesis.co.nz>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Chris Packham <judge.packham@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 2/2] drivers: rtc: max313xx: Ensure correct date is read
 after setting
Thread-Topic: [PATCH 2/2] drivers: rtc: max313xx: Ensure correct date is read
 after setting
Thread-Index: AQHba62S2u1uZxXljk2k1AJOnESYqw==
Date: Tue, 21 Jan 2025 02:38:36 +0000
Message-ID: <34272d64-aa8b-40ca-ab06-65afe3423037@alliedtelesis.co.nz>
References: <20250120015941.1849667-1-mark.tomlinson@alliedtelesis.co.nz>
 <20250120015941.1849667-2-mark.tomlinson@alliedtelesis.co.nz>
In-Reply-To: <20250120015941.1849667-2-mark.tomlinson@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <75558BB2F7ABAA4CAD1241D8A8609749@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BNQQr0QG c=1 sm=1 tr=0 ts=678f08ac
 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10
 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=pGLkceISAAAA:8 a=3FyghA0lbrn3jub3NLwA:9
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

DQpPbiAyMC8wMS8yMDI1IDE0OjU5LCBNYXJrIFRvbWxpbnNvbiB3cm90ZToNCj4gV2hlbiBzZXR0
aW5nIHRoZSB0aW1lIG9uIHRoZSBNQVgzMTM0MywgdGhlIHRpbWUgaXMgbm90IHVwZGF0ZWQNCj4g
Zm9yIG9uZSBzZWNvbmQsIGFuZCByZWFkaW5nIHRoZSB0aW1lIGluIHRoaXMgaW50ZXJ2YWwgd2ls
bCBnaXZlDQo+IHRoZSBvbGQgdGltZS4gV2FpdCBvbmUgc2Vjb25kIGFmdGVyIHdyaXRpbmcgc28g
dGhhdCB0aGUgZGF0ZQ0KPiBjb21tYW5kIHdpbGwgc2hvdyB0aGUgY29ycmVjdCB0aW1lIHdoZW4g
c2V0dGluZyB0aGUgY2xvY2suDQo+DQo+IFNpZ25lZC1vZmYtYnk6IE1hcmsgVG9tbGluc29uIDxt
YXJrLnRvbWxpbnNvbkBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPiBDYzogQ2hyaXMgUGFja2hhbSA8
anVkZ2UucGFja2hhbUBnbWFpbC5jb20+DQpSZXZpZXdlZC1ieTogQ2hyaXMgUGFja2hhbSA8anVk
Z2UucGFja2hhbUBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvcnRjL21heDMxM3h4LmMg
fCA1ICsrKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ydGMvbWF4MzEzeHguYyBiL2RyaXZlcnMvcnRjL21heDMxM3h4LmMN
Cj4gaW5kZXggY2NmZDZiNmQwZTIuLjJjYjNmMjQ1MDQxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3J0Yy9tYXgzMTN4eC5jDQo+ICsrKyBiL2RyaXZlcnMvcnRjL21heDMxM3h4LmMNCj4gQEAgLTMw
Nyw2ICszMDcsMTEgQEAgc3RhdGljIGludCBtYXgzMTN4eF9zZXRfdGltZShzdHJ1Y3QgdWRldmlj
ZSAqZGV2LCBjb25zdCBzdHJ1Y3QgcnRjX3RpbWUgKnQpDQo+ICAgCQlpZiAocmV0KQ0KPiAgIAkJ
CXJldHVybiByZXQ7DQo+ICAgDQo+ICsJCWJyZWFrOw0KPiArCWNhc2UgSURfTUFYMzEzNDM6DQo+
ICsJCS8qIFRpbWUgaXMgbm90IHVwZGF0ZWQgZm9yIDEgc2Vjb25kIGFmdGVyIHdyaXRpbmcgKi8N
Cj4gKwkJLyogU2xlZXAgaGVyZSBzbyB0aGUgZGF0ZSBjb21tYW5kIHNob3dzIHRoZSBuZXcgdGlt
ZSAqLw0KPiArCQltZGVsYXkoMTAwMCk7DQo+ICAgCQlicmVhazsNCj4gICAJZGVmYXVsdDoNCj4g
ICAJCWJyZWFrOw==
