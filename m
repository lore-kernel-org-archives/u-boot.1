Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3DAC71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 08:09:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69B908645D;
	Mon, 28 Aug 2023 10:09:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="QkIspNlo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADA3686481; Mon, 28 Aug 2023 10:09:50 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2133C8056B
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 10:09:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1693210187; x=1695802187;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=noDZvupRpWLTNk0iFtwPM3cS7rFDVKLPixFcqaQAqng=;
 b=QkIspNlol3ftZPBWh5q8qkGFccBGltrYyQTXuvdwmS1H3rYOqfjKNFtjM2qW++Fo
 NMA242prKgnii0y0zQPQy3H1P4TqXYbf302eFYduhvwedxTiaBtpNF3nudYlO7cO
 EihSNZR5I/6JP/I36Ubhu7iT1TuE27EkKNji09MhzTs=;
X-AuditID: ac14000a-917fe70000007ecb-5f-64ec564b347b
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 57.01.32459.B465CE46;
 Mon, 28 Aug 2023 10:09:47 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Aug
 2023 10:09:46 +0200
Received: from Berlix.phytec.de ([fe80::61cc:ebf0:7375:8768]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2375.018;
 Mon, 28 Aug 2023 10:09:46 +0200
From: Yannic Moog <Y.Moog@phytec.de>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "jmcosta944@gmail.com"
 <jmcosta944@gmail.com>
CC: "sjg@chromium.org" <sjg@chromium.org>, "trini@konsulko.com"
 <trini@konsulko.com>, "antoningodard@pm.me" <antoningodard@pm.me>
Subject: Re: [PATCH v1 0/4] Port gen_compile_commands.py from Linux to U-Boot
Thread-Topic: [PATCH v1 0/4] Port gen_compile_commands.py from Linux to U-Boot
Thread-Index: AQHZ05knrGUkh2RKv0udL94c3/OIOa//RUoA
Date: Mon, 28 Aug 2023 08:09:46 +0000
Message-ID: <30bc9a25cb0b3c6a7251056c0054680b5cb04d40.camel@phytec.de>
References: <20230820190412.21266-1-jmcosta944@gmail.com>
In-Reply-To: <20230820190412.21266-1-jmcosta944@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B96285F588860E458C816FDF0D510396@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsWyRpKBR9c77E2KwbVeWYsFHxayWMydspPF
 4tuWbYwWUydtZrd4u7eT3YHVY3bDRRaPnbPusnu8OrCK3ePsnR2MHkf3nGMLYI3isklJzcks
 Sy3St0vgylj/6ix7wS2eiq+98xgbGDfwdDFyckgImEj8XzqBvYuRi0NIYAmTxMnFZ1khnAeM
 Ep8eLIdyNjJKbLs6nRmkhU1AReLkjEuMILaIQJLEot8XweLMAs2MEitv+YPYwgK+Eq8OnAOK
 cwDV+EmsvMoKUW4k0d50FqycRUBV4sX3eSwgNq+Am8SmTU/A4kIClhILz+4HszkFrCTOTLnL
 DmIzCshKbNhwHmqVuMSmZ99ZIT4QkFiyByIuISAq8fLxP6i4vMSJW9OYQE5gFtCUWL9LH6LV
 QuLAukvsELaixJTuh+wQJwhKnJz5hGUCo/gsJBtmIXTPQtI9C0n3LCTdCxhZVzEK5WYmZ6cW
 ZWbrFWRUlqQm66WkbmIExagIA9cOxr45HocYmTgYDzFKcDArifBecnyVIsSbklhZlVqUH19U
 mpNafIhRmoNFSZz3fg9TopBAemJJanZqakFqEUyWiYNTqoFx6gzhBXGxymvrDnxLrJx8tzNW
 6M73lDt6k/llAmIvzZwk9unZLz+LW1OzTLrzOYVMHmm7WV+3S4+r/Pmu/VDfhh9v7gSpXk2w
 FdNTmnrG2OVIx9m3SxXlrc6u3rTdXPOt4vYE/YiXIQFWvG/v87/W50r/p7Pxevq2hfxH/xYf
 Spj4yzRr5quVSizFGYmGWsxFxYkACaoPpr8CAAA=
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

SGVsbG8gSm9hbywNCg0KT24gU3VuLCAyMDIzLTA4LTIwIGF0IDIxOjA0ICswMjAwLCBKb2FvIE1h
cmNvcyBDb3N0YSB3cm90ZToNCj4gSGVsbG8gVS1Cb290IGNvbW11bml0eSwNCj4gDQo+IEknbSBz
dWJtaXR0aW5nIGEgcGF0Y2ggc2VyaWVzIHRoYXQgcG9ydHMgdGhlIGdlbl9jb21waWxlX2NvbW1h
bmRzLnB5DQo+IHNjcmlwdCBmcm9tIHRoZSBMaW51eCBrZXJuZWwncyBzb3VyY2VzIHRvIFUtQm9v
dC4gVGhpcyBzY3JpcHQsDQo+IG9yaWdpbmFsbHkNCj4gbG9jYXRlZCBpbiBzY3JpcHRzL2NsYW5n
LXRvb2xzL2dlbl9jb21waWxlX2NvbW1hbmRzLnB5LCBlbmFibGVzIHRoZQ0KPiBnZW5lcmF0aW9u
IG9mIGNvbXBpbGVfY29tbWFuZHMuanNvbiBmaWxlcyBmb3IgaW1wcm92ZWQgY29kZQ0KPiBuYXZp
Z2F0aW9uDQo+IGFuZCBhbmFseXNpcy4gVGhlIHNlcmllcyBjb25zaXN0cyBvZiBmb3VyIHBhdGNo
ZXM6IHRoZSBpbml0aWFsIHNjcmlwdA0KPiBpbXBvcnQgYW5kIHRoZSBuZWNlc3NhcnkgbW9kaWZp
Y2F0aW9ucyBmb3IgVS1Cb290IGNvbXBhdGliaWxpdHkuDQo+IA0KPiBZb3VyIGZlZWRiYWNrIG9u
IHRoZXNlIGNvbnRyaWJ1dGlvbnMgd291bGQgYmUgZ3JlYXRseSBhcHByZWNpYXRlZC4NCj4gDQo+
IEJlc3QgcmVnYXJkcywNCj4gDQo+IEpvYW8gTWFyY29zIENvc3RhICg0KToNCj4gwqAgc2NyaXB0
czogUG9ydCBMaW51eCdzIGdlbl9jb21waWxlX2NvbW1hbmRzLnB5IHRvIFUtQm9vdA0KPiDCoCBz
Y3JpcHRzL2dlbl9jb21waWxlX2NvbW1hbmRzLnB5OiBhZGFwdCBfTElORV9QQVRURVJODQo+IMKg
IHNjcmlwdHMvZ2VuX2NvbXBpbGVfY29tbWFuZHMucHk6IGZpeCBkb2NzdHJpbmcNCj4gwqAgc2Ny
aXB0cy9nZW5fY29tcGlsZV9jb21tYW5kcy5weTogYWRkIGFja25vd2xlZGdtZW50cw0KDQpDYW4g
eW91IGFsc28gYWRkIGEgcGF0Y2ggdG8gYWRkIHRoZSBjb21waWxlX2NvbW1hbmRzLmpzb24gdG8N
Ci5naXRpZ25vcmUsIHBsZWFzZT8NCg0KWWFubmljDQoNCj4gDQo+IMKgc2NyaXB0cy9nZW5fY29t
cGlsZV9jb21tYW5kcy5weSB8IDIyOQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyMjkgaW5zZXJ0aW9ucygrKQ0KPiDCoGNyZWF0ZSBtb2Rl
IDEwMDc1NSBzY3JpcHRzL2dlbl9jb21waWxlX2NvbW1hbmRzLnB5DQo+IA0KDQo=
