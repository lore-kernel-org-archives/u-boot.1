Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209F0E67A6D
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 06:21:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4850883F2D;
	Tue,  3 Mar 2026 07:21:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="M+muYiZb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B490983F30; Tue,  3 Mar 2026 07:21:41 +0100 (CET)
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [202.36.163.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D80288063E
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 07:21:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Ronan.Dalton@alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D1BF12C030A;
 Tue,  3 Mar 2026 19:21:32 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
 s=mail181024; t=1772518892;
 bh=LLV6Q+LHQmX7QtzuPKhtfGDtGQP/Jf44LFFV84G3zTY=;
 h=From:To:Subject:Date:References:In-Reply-To:From;
 b=M+muYiZbVJ4dGYyIq3zGpAvK03Dsm5J++sdGxZC6s24dDYWw7KEV/VQyLhVvcJb1n
 +C22C3h75FNhjDRdjQymwJ80F30lHW8v6NARQNkRDYLmMEvNGUUGBU5N2/ziAgr2TW
 hB9EdhpU8BM/BKB+fWvSS9ii+fsNqgMbb0BXFLQ6CtDzys6ey9yv3Sp3ekd0uxC2dZ
 i7/HLpK0M4ZC7x0hYaEXmY29zLQNpE2zUDpcQFhNh4GNk3Bfe9iBNUo4wrQ0vzNh7E
 ayC1kWIcj6Of6jpLC1in7bw10UHav45NNOq5rYtfg9jJa4TvzYnhlsmGta3Kz3Lzrd
 CgIknAizkDZFw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by
 svr-chch-seg1.atlnz.lc with Trustwave SEG (v8, 2, 6, 11305)
 id <B69a67dec0000>; Tue, 03 Mar 2026 19:21:32 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Tue, 3 Mar 2026 19:21:32 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1748.039; Tue, 3 Mar 2026 19:21:32 +1300
From: Ronan Dalton <Ronan.Dalton@alliedtelesis.co.nz>
To: "marek.vasut@mailbox.org" <marek.vasut@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 4/4] usb: Convert ad-hoc poll/timeout sequences in
 usb.c to iopoll
Thread-Topic: [PATCH v3 4/4] usb: Convert ad-hoc poll/timeout sequences in
 usb.c to iopoll
Thread-Index: AQHcqgC/ISoLqboORkimp5kRclKV3LWaWvkAgAEjDAA=
Date: Tue, 3 Mar 2026 06:21:32 +0000
Message-ID: <d41ebc57f23e1afb559745d9a4e857655c8ea328.camel@alliedtelesis.co.nz>
References: <20260302044532.2891813-2-ronan.dalton@alliedtelesis.co.nz>
 <20260302044532.2891813-8-ronan.dalton@alliedtelesis.co.nz>
 <c1fba062-91e1-41f1-957f-114f255839f3@mailbox.org>
In-Reply-To: <c1fba062-91e1-41f1-957f-114f255839f3@mailbox.org>
Accept-Language: en-US, en-NZ
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.12.18]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC80868188A20E45AB7A05257CE26FB4@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=d/NWygjE c=1 sm=1 tr=0 ts=69a67dec
 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=BhaoXNk7gXQA:10
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=b3CbU_ItAAAA:8 a=1Q66CTAe6K3rsq7gy5YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Rv2g8BkzVjQTVhhssdqe:22
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

T24gTW9uLCAyMDI2LTAzLTAyIGF0IDEzOjU5ICswMTAwLCBNYXJlayBWYXN1dCB3cm90ZToKPiBP
biAzLzIvMjYgNTo0NSBBTSwgUm9uYW4gRGFsdG9uIHdyb3RlOgo+IAo+IFsuLi5dCj4gCj4gPiBA
QCAtMjc2LDE5ICsyNzksMjIgQEAgaW50IHVzYl9jb250cm9sX21zZyhzdHJ1Y3QgdXNiX2Rldmlj
ZSAqZGV2LAo+ID4gdW5zaWduZWQgaW50IHBpcGUsCj4gPiDCoCBpbnQgdXNiX2J1bGtfbXNnKHN0
cnVjdCB1c2JfZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBwaXBlLAo+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdm9pZCAqZGF0YSwgaW50IGxlbiwg
aW50ICphY3R1YWxfbGVuZ3RoLAo+ID4gaW50IHRpbWVvdXQpCj4gPiDCoCB7Cj4gPiArwqDCoMKg
wqDCoMKgwqB2b2xhdGlsZSB1bnNpZ25lZCBsb25nIHVzYl9zdGF0dXM7Cj4gPiArCj4gPiDCoMKg
wqDCoMKgwqDCoMKgaWYgKGxlbiA8IDApCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJldHVybiAtRUlOVkFMOwo+ID4gwqAgCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAodGltZW91
dCA8IDApCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FSU5WQUw7
Cj4gPiArCj4gPiDCoMKgwqDCoMKgwqDCoMKgZGV2LT5zdGF0dXMgPSBVU0JfU1RfTk9UX1BST0M7
IC8qbm90IHlldCBwcm9jZXNzZWQgKi8KPiA+IMKgIAo+ID4gwqDCoMKgwqDCoMKgwqDCoGlmIChz
dWJtaXRfYnVsa19tc2coZGV2LCBwaXBlLCBkYXRhLCBsZW4pIDwgMCkKPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FSU87Cj4gPiDCoCAKPiA+IC3CoMKgwqDCoMKg
wqDCoHdoaWxlICh0aW1lb3V0LS0pIHsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBpZiAoISgodm9sYXRpbGUgdW5zaWduZWQgbG9uZylkZXYtPnN0YXR1cyAmCj4gPiBVU0JfU1Rf
Tk9UX1BST0MpKQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBicmVhazsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBtZGVsYXkoMSk7
Cj4gPiAtwqDCoMKgwqDCoMKgwqB9Cj4gPiArwqDCoMKgwqDCoMKgwqByZWFkX3BvbGxfdGltZW91
dCgodm9sYXRpbGUgdW5zaWduZWQgbG9uZyksIHVzYl9zdGF0dXMsCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICEodXNiX3N0YXR1cyAmIFVTQl9T
VF9OT1RfUFJPQyksIDEwMDAsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHRpbWVvdXQgKiAxMDAwVUwsIGRldi0+c3RhdHVzKTsKPiAKPiBNYXli
ZSB0aGlzIGNvdWxkIHVzZSBhbiBlcnJvciBjaGVjayBoZXJlIHRvbyA/Cj4gCj4gV2l0aCB0aGF0
IGZpeGVkOgo+IAo+IFJldmlld2VkLWJ5OiBNYXJlayBWYXN1dCA8bWFyZWsudmFzdXRAbWFpbGJv
eC5vcmc+CgpJbiBwYXRjaCB2MiBJIG1hZGUgdGhlIGZvbGxvd2luZyBub3RlIGFib3V0IHRoaXM6
Cgo+IHVzYl9idWxrX21zZyBjb3VsZCBiZSB1cGRhdGVkIHRvIHJldHVybiAtRVRJTUVET1VUIG9u
IHRoZSB0aW1lb3V0Cj4gY2FzZS4gQ3VycmVudGx5IGl0IGxvb2tzIGxpa2UgLUVJTyBpcyByZXR1
cm5lZCBpZiBhIHRpbWVvdXQgb2NjdXJzCj4gYW5kIGNhbGxlcnMgY2FuJ3QgdGVsbCBpZiBhIHRp
bWVvdXQgb2NjdXJyZWQgYXMgc3VjaC4gVGhlIC1FSU8KPiByZXR1cm7CoGNvZGUgaXMgYWxzbyBp
bmNvbnNpc3RlbnQgd2l0aCB1c2JfY29udHJvbF9tc2cgd2hpY2jCoAo+IHJldHVybnPCoC0xLgoK
SSd2ZSBtYWRlIGl0IHJldHVybiAtRVRJTUVET1VUIG5vdyBpbiB0aGUgdGltZW91dCBjYXNlLiBI
b3dldmVyIGl0J3MKc29tZXRoaW5nIEknbSBhIGJpdCBoZXNpdGFudCBhYm91dCBzaW5jZSB0aGF0
IHdpbGwgY2hhbmdlIHRoZSBlcnJvcgpjb2RlIHJldHVybmVkIG5vdyAoYXdheSBmcm9tIC1FSU8p
LgoKVGhlIHNldHRpbmcgb2YgdGhlIGFjdHVhbF9sZW5ndGggb3V0cHV0IHBhcmFtIGlzIGFsc28g
cXVlc3Rpb25hYmxlLiBJCndhcyBnb2luZyB0byBwdXQgdGhlIHRpbWVvdXQgY2hlY2sgcmlnaHQg
YWZ0ZXIgdGhlIGNhbGwgdG8KcmVhZF9wb2xsX3RpbWVvdXQsIGJ1dCBkZWNpZGVkIHRvIHNldCB0
aGUgYWN0dWFsX2xlbmd0aCB2YWx1ZSBmaXJzdCB0bwptaW5pbWl6ZSB0aGUgY2hhbmNlIG9mIGJy
ZWFrYWdlLiBDYWxsZXJzIHRvIHVzYl9idWxrX21zZyByZWFsbHkKc2hvdWxkbid0IGJlIGlucGVj
dGluZyB0aGUgdmFsdWUgb2YgdGhhdCBvdXRwdXQgcGFyYW1ldGVyIGlmIHRoZQpmdW5jdGlvbiBy
ZXR1cm5zIGFuIGVycm9yLCBidXQgc29tZSBkbyBzZWVtIHRvIGRvIHRoYXQsIGFuZCB0aGV5IHdv
dWxkCmJlIHJlYWRpbmcgZ2FyYmFnZSBpbiB0aGUgdGltZW91dCBjYXNlLgo=
