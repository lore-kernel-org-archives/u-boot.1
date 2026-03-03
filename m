Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738D9E67A61
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 04:21:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6EBA83F2D;
	Tue,  3 Mar 2026 05:21:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="dH87CESB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0A2883F30; Tue,  3 Mar 2026 05:21:01 +0100 (CET)
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [202.36.163.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6933A80212
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 05:20:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=alliedtelesis.co.nz
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Ronan.Dalton@alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 803302C0304;
 Tue,  3 Mar 2026 17:20:52 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
 s=mail181024; t=1772511652;
 bh=yveSSJwd15gbSDUPd/MDTlaRUowQFmMp0tr0H7p4J5s=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=dH87CESBeUVkBJvwOfPaajqb5lSSNcxFTiXYv1V/1HkWKbHMtKlPYAFczcBTMtOXC
 sliezHZCQsNPbpzoVe9Q9JhWbFQAMVoohsTfz50tFuOmDA/6mElKDXpKYmdkb//Bia
 uJbmwfBpXaZLDTbiOD4WrYjxXpbWBLFA0kGshtDbJMR3QNVwOFCL+qgd0icS9m0UUN
 cyQiZkFk9rxzJ2NhTNECWLbCLr4+rv9UlX3KTxVypXhSSAhSp8lzIpmJNEmDcnICf/
 W/xJbViTD81IdjKDWPuGtKxVEaWTZ4kCaH0abL6O6A2uiE1+BFf1mylJtZz/MaIAzq
 4mYsTBqSRFzaw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by
 svr-chch-seg1.atlnz.lc with Trustwave SEG (v8, 2, 6, 11305)
 id <B69a661a40000>; Tue, 03 Mar 2026 17:20:52 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Tue, 3 Mar 2026 17:20:52 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1748.039; Tue, 3 Mar 2026 17:20:52 +1300
From: Ronan Dalton <Ronan.Dalton@alliedtelesis.co.nz>
To: "marek.vasut@mailbox.org" <marek.vasut@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "ariel.dalessandro@collabora.com" <ariel.dalessandro@collabora.com>
Subject: Re: [PATCH v3 2/4] iopoll: Improve handling of timeout_us param in
 read_poll_timeout macro
Thread-Topic: [PATCH v3 2/4] iopoll: Improve handling of timeout_us param in
 read_poll_timeout macro
Thread-Index: AQHcqgCBorjk92KJyUqYJDuQiZkz0LWaWV8AgAEC7oA=
Date: Tue, 3 Mar 2026 04:20:52 +0000
Message-ID: <433b8b32e46ae1ef47157473afa051322ba6955d.camel@alliedtelesis.co.nz>
References: <20260302044532.2891813-2-ronan.dalton@alliedtelesis.co.nz>
 <20260302044532.2891813-4-ronan.dalton@alliedtelesis.co.nz>
 <49be65da-0d6f-4a5c-9819-c2bfdd8894c3@mailbox.org>
In-Reply-To: <49be65da-0d6f-4a5c-9819-c2bfdd8894c3@mailbox.org>
Accept-Language: en-US, en-NZ
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.12.18]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B61BAEDAC691FD4BA4FDCFF8E7BA8CF9@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=d/NWygjE c=1 sm=1 tr=0 ts=69a661a4
 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=BhaoXNk7gXQA:10
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=W3GrKG5lrAg1L7bVKfUA:9
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

T24gTW9uLCAyMDI2LTAzLTAyIGF0IDEzOjU0ICswMTAwLCBNYXJlayBWYXN1dCB3cm90ZToNCj4g
T24gMy8yLzI2IDU6NDUgQU0sIFJvbmFuIERhbHRvbiB3cm90ZToNCj4gPiBXcmFwIHRoZSB0aW1l
b3V0X3VzIHBhcmFtZXRlciBpbiBicmFja2V0cyBhbmQgYXNzaWduIHRvIGEgdmFyaWFibGUNCj4g
PiB3aXRoDQo+ID4gdHdvIGxlYWRpbmcgdW5kZXJzY29yZXMgdG8gZm9sbG93IG1hY3JvIGRlZmlu
aXRpb24gYmVzdC1wcmFjdGljZXMuDQo+IElzIHRoZXJlIGEgbWF0Y2hpbmcgTGludXgga2VybmVs
IGZpeCA/DQoNClRoZSBpbml0aWFsIGNvbW1pdCB0aGF0IGludHJvZHVjZWQgdGhlIG1hY3JvIGlu
IExpbnV4IGFscmVhZHkgZGlkIGl0DQpjb3JyZWN0bHkuIFRoaXMgY29tbWl0IGJyaW5ncyBpdCBt
b3JlIGluIGxpbmUgd2l0aCB3aGF0IExpbnV4IGRvZXMuDQo=
