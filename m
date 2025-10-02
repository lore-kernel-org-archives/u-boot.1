Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F492CAC5B0
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 16:42:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B877828A2;
	Thu,  2 Oct 2025 18:42:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Njxuy3Kx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59287835A2; Thu,  2 Oct 2025 18:42:42 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 048D581D6A
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 18:42:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vishalm@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 592GgbOE2870700;
 Thu, 2 Oct 2025 11:42:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759423357;
 bh=FF2UkDrW3Fwe7wecXqz3fIMSM3y98Fe0emXpOdb27Z0=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:list-post;
 b=Njxuy3KxBsY4nzLqWvlNH/dfyu2xmKOYUsv0YOrA2lADFyKv/UR7uQhgYkfFUmVNy
 +gJQpCMzvuCc1Jqsi3hZ2I1GuLDIk52NiqyovX1bi9z93r0j6IoW7L30kddlFy+IBN
 /ueFUJ6m2MBFvZJfYZOgkuxaB7PPqZLy4MWDtbpY=
Received: from DFLE214.ent.ti.com (dfle214.ent.ti.com [10.64.6.72])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 592GgbHE151266
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 2 Oct 2025 11:42:37 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Oct
 2025 11:42:35 -0500
Received: from DFLE204.ent.ti.com ([fe80::e74e:2634:c5f2:539c]) by
 DFLE204.ent.ti.com ([fe80::e74e:2634:c5f2:539c%11]) with mapi id
 15.02.2562.020; Thu, 2 Oct 2025 11:42:35 -0500
From: "Mahaveer, Vishal" <vishalm@ti.com>
To: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>,
 "linux-patch-review@list.ti.com - An open list to review linux patches
 internally. (May contain non-TIers)" <linux-patch-review@list.ti.com>,
 "Bajjuri, Praneeth" <praneeth@ti.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "mfournier@baylibre.com" <mfournier@baylibre.com>, "khilman@baylibre.com"
 <khilman@baylibre.com>
Subject: RE: [PATCH tiU25.01 0/2] ANDROID: Add some features link to OPTEE TA
 AVB
Thread-Topic: [PATCH tiU25.01 0/2] ANDROID: Add some features link to OPTEE TA
 AVB
Thread-Index: AQHcM4m1UOoo7NS8DEm26abpsfPrBrSvD7mw
Date: Thu, 2 Oct 2025 16:42:35 +0000
Message-ID: <09e8ef8eef3443b88b4f48b4e1647ca6@ti.com>
References: <20251002-avb-v1-0-1f93543822ce@baylibre.com>
In-Reply-To: <20251002-avb-v1-0-1f93543822ce@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.250.36.65]
x-c2processedorg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
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

PiBUaGlzIHNlcmllcyBhZGQgc29tZSBBbmRyb2lkIGZlYXR1cmVzIGxpbmsgdG8gQW5kcm9pZCBW
ZXJpZnkgQm9vdCwgZGV2aWNlDQo+IGxvY2svdW5sb2NrIGFuZCBrZXltaW50IFRBDQo+IA0KPiAt
IEFkZCBzdXBwb3J0IG9mIGZhc3Rib290IGZsYXNoaW5nIGxvY2svdW5sb2NrICBhbmQNCj4gbG9j
a19jcml0aWNhbC91bmxvY2tfY3JpdGljYWwgd2l0aCBPcHRlZSBUQSBBVkIgaWYgc3VwcG9ydGVk
IG9yIHdpdGggZW52DQo+IHZhcmlhYmxlIChmb3IgZGV2ZWxvcG1lbnQgb25seSkNCj4gLSBBZGQg
c3VwcG9ydCBvZiBnZXQgcm9vdCBvciB0cnVzdCB3aXRoIFRBIEFWQiBhbmQgS2V5bWludCBUQQ0K
PiANCj4gVGhpcyBzZXJpZXMgd2lsbCBiZSB1cHN0cmVhbSBhZnRlciByZWxlYXNlLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogR3VpbGxhdW1lIExhIFJvcXVlIChUSS5jb20pIDxnbGFyb3F1ZUBiYXls
aWJyZS5jb20+DQo+IC0tLQ0KPiBHdWlsbGF1bWUgTGEgUm9xdWUgKFRJLmNvbSkgKDIpOg0KPiAg
ICAgICBQRU5ESU5HOiBmYXN0Ym9vdDogSW1wbGVtZW50IEFuZHJvaWQgYm9vdGxvYWRlciBsb2Nr
aW5nIHdpdGgNCj4gQ09ORklHX0ZBU1RCT09UX0xPQ0tJTkcNCj4gICAgICAgUEVORElORzogYXZi
OiBBZGQgYXV0b21hdGljIFJvb3Qgb2YgVHJ1c3QgaW50ZWdyYXRpb24gZm9yIEFuZHJvaWQNCj4g
S2V5TWludA0KPiANCj4gIGJvb3QvYm9vdG1ldGhfYW5kcm9pZC5jICAgICAgIHwgIDE1ICsrDQo+
ICBjbWQvS2NvbmZpZyAgICAgICAgICAgICAgICAgICB8ICAxMyArDQo+ICBjbWQvTWFrZWZpbGUg
ICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ICBjbWQvYXZiLmMgICAgICAgICAgICAgICAgICAg
ICB8ICAxMyArDQo+ICBjbWQvY21kX2F2Yl9yb3QuYyAgICAgICAgICAgICB8IDEyOSArKysrKysr
KysrDQo+ICBjb21tb24vYXZiX3ZlcmlmeS5jICAgICAgICAgICB8IDE4MyArKysrKysrKysrKysr
Ky0NCj4gIGRyaXZlcnMvZmFzdGJvb3QvS2NvbmZpZyAgICAgIHwgIDIxICsrDQo+ICBkcml2ZXJz
L2Zhc3Rib290L2ZiX2NvbW1hbmQuYyB8IDQ1MCArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPiAgZHJpdmVycy9mYXN0Ym9vdC9mYl9nZXR2YXIuYyAgfCAgNjggKysrKysrDQo+
ICBpbmNsdWRlL2F2Yl9yb290X29mX3RydXN0LmggICB8ICA1MCArKysrDQo+ICBpbmNsdWRlL2F2
Yl92ZXJpZnkuaCAgICAgICAgICB8ICAgOSArDQo+ICBpbmNsdWRlL2Zhc3Rib290LmggICAgICAg
ICAgICB8ICAgNSArDQo+ICBsaWIvS2NvbmZpZyAgICAgICAgICAgICAgICAgICB8ICAxOCArKw0K
PiAgbGliL01ha2VmaWxlICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiAgbGliL2F2Yl9yb290
X29mX3RydXN0LmMgICAgICAgfCA1MzQNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+ICAxNSBmaWxlcyBjaGFuZ2VkLCAxNTAzIGluc2VydGlvbnMoKyksIDcg
ZGVsZXRpb25zKC0pDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogNWI5M2MzZWM3ZjlkNjZkYzQwZDA2
MmE0N2E0YTg4MGY3ZDM0NmI3YQ0KPiBjaGFuZ2UtaWQ6IDIwMjUxMDAyLWF2Yi02YmU0MDFjMDkw
NTANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gLS0NCj4gR3VpbGxhdW1lIExhIFJvcXVlIChUSS5j
b20pIDxnbGFyb3F1ZUBiYXlsaWJyZS5jb20+DQoNCkFja2VkLUJ5OiBWaXNoYWwgTWFoYXZlZXIg
PHZpc2hhbG1AdGkuY29tPg0KDQo=
