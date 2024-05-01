Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C355DC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:12:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C1DD88D14;
	Wed,  1 May 2024 04:48:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="YswYmEdj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8740788D12; Wed,  1 May 2024 04:48:02 +0200 (CEST)
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [202.36.163.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EB2D88D03
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:48:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Chris.Packham@alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 432952C0183;
 Wed,  1 May 2024 14:47:57 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
 s=mail181024; t=1714531677;
 bh=MaqV5yuaSl7hPY0MEpVh6pQpaqGtfFU22FePHx3N50w=;
 h=From:To:Subject:Date:References:In-Reply-To:From;
 b=YswYmEdjlgwJZ1e8P6Yd6B1Zf9WETmob1bGabt5sp4skf5l5BlZJmjkcE0aSDbL0g
 9FpMCSISqGVr71I3XdRgkIpxfxmxvNW1Id3RSeQXSZFRMzcm+k8S/u4qOQvha0HKXu
 od0Qn6GhriyYi2XftDuyhTyZmsN0AEQGkb3ygjA7AUYJgKUp9BHy1uyBwtqVwsujYN
 0UTI5Zrv+yJmAoTglb1bGCiy8wFvsqUIlDeudDkPbqm8f5lcrpiu/G9WqbgEbrftR9
 SxgJY3/Y2smGjRD6nj57Kn+NTFwUZ/fxVVjePU3oLYp5cu4PbvwTX0RuMb+ms/pLrw
 126KBci/N5B9A==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by
 svr-chch-seg1.atlnz.lc with Trustwave SEG (v8, 2, 6, 11305)
 id <B6631ad5d0000>; Wed, 01 May 2024 14:47:57 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1544.9; Wed, 1 May 2024 14:47:57 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Wed, 1 May 2024 14:47:56 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.009; Wed, 1 May 2024 14:47:56 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 014/149] board: alliedtelesis: Remove <common.h> and add
 needed includes
Thread-Topic: [PATCH 014/149] board: alliedtelesis: Remove <common.h> and add
 needed includes
Thread-Index: AQHam3FeRe2/pAezhUGnZwnMvJzYZLGA4+KA
Date: Wed, 1 May 2024 02:47:56 +0000
Message-ID: <8ee1781d-7035-4bc7-994b-040c02eba971@alliedtelesis.co.nz>
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-14-trini@konsulko.com>
In-Reply-To: <20240501024316.1767971-14-trini@konsulko.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC360B8139C82E44885409D889C6B50D@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=dY4j3mXe c=1 sm=1 tr=0 ts=6631ad5d
 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10
 a=IkcTkHD0fZMA:10 a=TpHVaj0NuXgA:10 a=k-42gJp3AAAA:8 a=62ntRvTiAAAA:8
 a=EwdJqzo0AAAA:8 a=WkyLweOAVj0_RPDuXIAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uCSXFHLys93vLW5PjgO_:22 a=pToNdpNmrtiFLRE6bQ9Z:22 a=B-ZPNXADpTp2rtj6ZcRP:22
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

DQpPbiAxLzA1LzI0IDE0OjQxLCBUb20gUmluaSB3cm90ZToNCj4gUmVtb3ZlIDxjb21tb24uaD4g
ZnJvbSB0aGlzIGJvYXJkIHZlbmRvciBkaXJlY3RvcnkgYW5kIHdoZW4gbmVlZGVkDQo+IGFkZCBt
aXNzaW5nIGluY2x1ZGUgZmlsZXMgZGlyZWN0bHkuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFRvbSBS
aW5pIDx0cmluaUBrb25zdWxrby5jb20+DQo+IC0tLQ0KPiBDYzogQ2hyaXMgUGFja2hhbSA8Y2hy
aXMucGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KDQpSZXZpZXdlZC1ieTogQ2hyaXMgUGFj
a2hhbSA8Y2hyaXMucGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KDQo+IC0tLQ0KPiAgIGJv
YXJkL2FsbGllZHRlbGVzaXMvU0J4ODFMSUZLVy9zYng4MWxpZmt3LmMgICAgIHwgMSAtDQo+ICAg
Ym9hcmQvYWxsaWVkdGVsZXNpcy9TQng4MUxJRlhDQVQvc2J4ODFsaWZ4Y2F0LmMgfCAxIC0NCj4g
ICBib2FyZC9hbGxpZWR0ZWxlc2lzL2NvbW1vbi9ncGlvX2hvZy5jICAgICAgICAgICB8IDEgLQ0K
PiAgIGJvYXJkL2FsbGllZHRlbGVzaXMveDI0MC94MjQwLmMgICAgICAgICAgICAgICAgIHwgMiAr
LQ0KPiAgIGJvYXJkL2FsbGllZHRlbGVzaXMveDUzMC94NTMwLmMgICAgICAgICAgICAgICAgIHwg
MiArLQ0KPiAgIDUgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygt
KQ0KPg0KPiBkaWZmIC0tZ2l0IGEvYm9hcmQvYWxsaWVkdGVsZXNpcy9TQng4MUxJRktXL3NieDgx
bGlma3cuYyBiL2JvYXJkL2FsbGllZHRlbGVzaXMvU0J4ODFMSUZLVy9zYng4MWxpZmt3LmMNCj4g
aW5kZXggZTBhN2YzZmE4OWYwLi41ZTZkNmM2MjM0ZmIgMTAwNjQ0DQo+IC0tLSBhL2JvYXJkL2Fs
bGllZHRlbGVzaXMvU0J4ODFMSUZLVy9zYng4MWxpZmt3LmMNCj4gKysrIGIvYm9hcmQvYWxsaWVk
dGVsZXNpcy9TQng4MUxJRktXL3NieDgxbGlma3cuYw0KPiBAQCAtNCw3ICs0LDYgQEANCj4gICAg
KiBBbGxpZWQgVGVsZXNpcyA8aHR0cDovL3NjYW5tYWlsLnRydXN0d2F2ZS5jb20vP2M9MjA5ODgm
ZD0yYXl4NWtOaXF5UC1aaHUtNmNHUnN3aEl1dlU4SUtPdzdUTjVXN3N3ZmcmdT1odHRwJTNhJTJm
JTJmd3d3JTJlYWxsaWVkdGVsZXNpcyUyZWNvbT4NCj4gICAgKi8NCj4gICANCj4gLSNpbmNsdWRl
IDxjb21tb24uaD4NCj4gICAjaW5jbHVkZSA8aW5pdC5oPg0KPiAgICNpbmNsdWRlIDxuZXQuaD4N
Cj4gICAjaW5jbHVkZSA8YXNtL2dsb2JhbF9kYXRhLmg+DQo+IGRpZmYgLS1naXQgYS9ib2FyZC9h
bGxpZWR0ZWxlc2lzL1NCeDgxTElGWENBVC9zYng4MWxpZnhjYXQuYyBiL2JvYXJkL2FsbGllZHRl
bGVzaXMvU0J4ODFMSUZYQ0FUL3NieDgxbGlmeGNhdC5jDQo+IGluZGV4IDUyYjhlYmE5MmZjMS4u
ZjMwODIxYzE3OTYzIDEwMDY0NA0KPiAtLS0gYS9ib2FyZC9hbGxpZWR0ZWxlc2lzL1NCeDgxTElG
WENBVC9zYng4MWxpZnhjYXQuYw0KPiArKysgYi9ib2FyZC9hbGxpZWR0ZWxlc2lzL1NCeDgxTElG
WENBVC9zYng4MWxpZnhjYXQuYw0KPiBAQCAtNCw3ICs0LDYgQEANCj4gICAgKiBBbGxpZWQgVGVs
ZXNpcyA8aHR0cDovL3NjYW5tYWlsLnRydXN0d2F2ZS5jb20vP2M9MjA5ODgmZD0yYXl4NWtOaXF5
UC1aaHUtNmNHUnN3aEl1dlU4SUtPdzdUTjVXN3N3ZmcmdT1odHRwJTNhJTJmJTJmd3d3JTJlYWxs
aWVkdGVsZXNpcyUyZWNvbT4NCj4gICAgKi8NCj4gICANCj4gLSNpbmNsdWRlIDxjb21tb24uaD4N
Cj4gICAjaW5jbHVkZSA8aW5pdC5oPg0KPiAgICNpbmNsdWRlIDxtaWlwaHkuaD4NCj4gICAjaW5j
bHVkZSA8bmV0Lmg+DQo+IGRpZmYgLS1naXQgYS9ib2FyZC9hbGxpZWR0ZWxlc2lzL2NvbW1vbi9n
cGlvX2hvZy5jIGIvYm9hcmQvYWxsaWVkdGVsZXNpcy9jb21tb24vZ3Bpb19ob2cuYw0KPiBpbmRl
eCA0YWVjZjdlMmNlZjcuLjdkYTcwZmI0ZjdkNiAxMDA2NDQNCj4gLS0tIGEvYm9hcmQvYWxsaWVk
dGVsZXNpcy9jb21tb24vZ3Bpb19ob2cuYw0KPiArKysgYi9ib2FyZC9hbGxpZWR0ZWxlc2lzL2Nv
bW1vbi9ncGlvX2hvZy5jDQo+IEBAIC0zLDcgKzMsNiBAQA0KPiAgICAqIENvcHlyaWdodCAoQykg
MjAxOCBBbGxpZWQgVGVsZXNpcyBMYWJzDQo+ICAgICovDQo+ICAgDQo+IC0jaW5jbHVkZSA8Y29t
bW9uLmg+DQo+ICAgI2luY2x1ZGUgPGRtLmg+DQo+ICAgI2luY2x1ZGUgPGFzbS9nbG9iYWxfZGF0
YS5oPg0KPiAgICNpbmNsdWRlIDxhc20vZ3Bpby5oPg0KPiBkaWZmIC0tZ2l0IGEvYm9hcmQvYWxs
aWVkdGVsZXNpcy94MjQwL3gyNDAuYyBiL2JvYXJkL2FsbGllZHRlbGVzaXMveDI0MC94MjQwLmMN
Cj4gaW5kZXggMGM0ZjhlMDNiODU5Li5jMWI3Y2MzYjYxM2MgMTAwNjQ0DQo+IC0tLSBhL2JvYXJk
L2FsbGllZHRlbGVzaXMveDI0MC94MjQwLmMNCj4gKysrIGIvYm9hcmQvYWxsaWVkdGVsZXNpcy94
MjQwL3gyNDAuYw0KPiBAQCAtMSw2ICsxLDYgQEANCj4gICAvLyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMCsNCj4gICANCj4gLSNpbmNsdWRlIDxjb21tb24uaD4NCj4gKyNpbmNsdWRl
IDxjb25maWcuaD4NCj4gICAjaW5jbHVkZSA8YXNtL2dsb2JhbF9kYXRhLmg+DQo+ICAgDQo+ICAg
REVDTEFSRV9HTE9CQUxfREFUQV9QVFI7DQo+IGRpZmYgLS1naXQgYS9ib2FyZC9hbGxpZWR0ZWxl
c2lzL3g1MzAveDUzMC5jIGIvYm9hcmQvYWxsaWVkdGVsZXNpcy94NTMwL3g1MzAuYw0KPiBpbmRl
eCA4MGFkNjJjMmM2NjUuLjY1ZTZkNDhkYjBhNiAxMDA2NDQNCj4gLS0tIGEvYm9hcmQvYWxsaWVk
dGVsZXNpcy94NTMwL3g1MzAuYw0KPiArKysgYi9ib2FyZC9hbGxpZWR0ZWxlc2lzL3g1MzAveDUz
MC5jDQo+IEBAIC0zLDcgKzMsNyBAQA0KPiAgICAqIENvcHlyaWdodCAoQykgMjAxNyBBbGxpZWQg
VGVsZXNpcyBMYWJzDQo+ICAgICovDQo+ICAgDQo+IC0jaW5jbHVkZSA8Y29tbW9uLmg+DQo+ICsj
aW5jbHVkZSA8Y29uZmlnLmg+DQo+ICAgI2luY2x1ZGUgPGNvbW1hbmQuaD4NCj4gICAjaW5jbHVk
ZSA8ZG0uaD4NCj4gICAjaW5jbHVkZSA8ZW52Lmg+
