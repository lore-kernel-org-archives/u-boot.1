Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36448CDB479
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 09:35:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90FDE846E1;
	Wed, 24 Jun 2026 11:35:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=infineon.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=infineon.com header.i=@infineon.com header.b="kUP/OFyO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBEA8849CE; Wed, 24 Jun 2026 10:37:35 +0200 (CEST)
Received: from smtp2.infineon.com (smtp2.infineon.com
 [IPv6:2a00:18f0:1e00:4::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5412E84995
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 10:37:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Takahiro.Kuwano@infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1782290253; x=1813826253;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HIzqJU+q9zEQ9b9pVLAXCR71V0eWibLOu9/GOQvxzTg=;
 b=kUP/OFyOiJfb5SCTTz6N/Y9bhORLdtL4UhldSoowoPfpphe+r6r6o8hc
 2TYtaAh0PJU4FWr9F2O7n9eNyy3+ZyNyIdhFiDXaW4hK/xfmMTky6gjiF
 iMZnueWGty1TobyHnMbxlzClkaPVJ2PnySlBsiScHKtuohZCLlraS1ViK I=;
X-CSE-ConnectionGUID: 3svK9Qt+TTiDHlSGTm/4Sg==
X-CSE-MsgGUID: 4MJu0MPRQF6zZDAxLS6hdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="164277532"
X-IronPort-AV: E=Sophos;i="6.24,222,1774306800"; d="scan'208";a="164277532"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
 by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 10:37:31 +0200
Received: from MUCSE811.infineon.com (172.23.29.37) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 24 Jun
 2026 10:37:31 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE811.infineon.com
 (172.23.29.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 24 Jun
 2026 10:37:31 +0200
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.043; Wed, 24 Jun 2026 10:37:31 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <marex@nabladev.com>, <u-boot@lists.denx.de>, <vlim@gigadevice.com>
CC: <akoch@initse.com>, <dlechner@baylibre.com>, <flaviu.nistor@gmail.com>,
 <miquel.raynal@bootlin.com>, <trini@konsulko.com>,
 <tudor.ambarus@linaro.org>, <vigneshr@ti.com>
Subject: RE: [PATCH] mtd: spi-nor: Add GigaDevice GD25LQ16 support
Thread-Topic: [PATCH] mtd: spi-nor: Add GigaDevice GD25LQ16 support
Thread-Index: AQHc+e1oIqA0iAOK0kSoF0hAoPRFjLY6qm3wgADsQwCAEdTB8A==
Date: Wed, 24 Jun 2026 08:37:30 +0000
Message-ID: <bbd3bff2876441b3b3b01a36a2612857@infineon.com>
References: <20260611215808.177934-1-marex@nabladev.com>
 <e19646ac03734dcc8f7e38243040f60e@infineon.com>
 <2744741c-5903-4396-8216-c8bf093da08c@nabladev.com>
In-Reply-To: <2744741c-5903-4396-8216-c8bf093da08c@nabladev.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 24 Jun 2026 11:35:14 +0200
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

SGVsbG8gTWFyZWssDQoNCj4gDQo+IE9uIDYvMTIvMjYgMTE6NTEgQU0sIFRha2FoaXJvLkt1d2Fu
b0BpbmZpbmVvbi5jb20gd3JvdGU6DQo+IA0KPiBIZWxsbyBLdXdhbm8tc2FuLA0KPiANCj4gK0ND
IEdpZ2FEZXZpY2UNCj4gDQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGkvc3BpLW5v
ci1pZHMuYyBiL2RyaXZlcnMvbXRkL3NwaS9zcGktbm9yLWlkcy5jDQo+ID4+IGluZGV4IGMwZmE5
ODQyNGFhLi5kM2EyNGI1MWRhZiAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpL3Nw
aS1ub3ItaWRzLmMNCj4gPj4gKysrIGIvZHJpdmVycy9tdGQvc3BpL3NwaS1ub3ItaWRzLmMNCj4g
Pj4gQEAgLTExNyw2ICsxMTcsMTEgQEAgY29uc3Qgc3RydWN0IGZsYXNoX2luZm8gc3BpX25vcl9p
ZHNbXSA9IHsNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgIFNFQ1RfNEsgfCBTUElfTk9S
X0RVQUxfUkVBRCB8IFNQSV9OT1JfUVVBRF9SRUFEIHwNCj4gPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgIFNQSV9OT1JfSEFTX0xPQ0sgfCBTUElfTk9SX0hBU19UQikNCj4gPj4gICAgICAgICAg
fSwNCj4gPj4gKyAgICAgICB7DQo+ID4+ICsgICAgICAgICAgICAgICBJTkZPKCJnZDI1bHExNiIs
IDB4Yzg2MDE1LCAwLCA2NCAqIDEwMjQsIDMyLA0KPiA+PiArICAgICAgICAgICAgICAgICAgICAg
ICBTRUNUXzRLIHwgU1BJX05PUl9EVUFMX1JFQUQgfCBTUElfTk9SX1FVQURfUkVBRCB8DQo+ID4+
ICsgICAgICAgICAgICAgICAgICAgICAgIFNQSV9OT1JfSEFTX0xPQ0sgfCBTUElfTk9SX0hBU19U
QikNCj4gPg0KPiA+IEkgY291bGQgZmluZCBhIGRhdGFzaGVldCBvZiBHRDI1TFExNkUgdGhhdCBt
ZW50aW9ucyB0aGUgc2FtZSBJRCAoQzggNjAgMTUpLg0KPiA+IGh0dHBzOi8vd3d3Lm1vdXNlci5j
b20vZGF0YXNoZWV0LzIvODcwL2dkMjVscTE2ZV9kYXRhc2hlZXRfdjFfMl8yMDIxMDEwOC0NCj4g
MjM5OTY2MC5wZGY/c3JzbHRpZD1BZm1CT29wRXI1MGxZV1p1SU53NGdlTmxqWHFXWnhIcXZyWWMt
X0h5Smk3SVNiT2NfOVJSYWlDMQ0KPiA+DQo+ID4gVGhpcyBjaGlwIGhhcyA0IEJQIGJpdHMgKEJQ
My4uQlAwKSArIFRCIChCUDQpLg0KPiA+IFRoZSB1LWJvb3QgZHJpdmVyIGRvZXNuJ3Qgc3VwcG9y
dCA0LWJpdCBCUCB5ZXQgc28gbG9ja2luZyBmZWF0dXJlIHNob3VsZG4ndA0KPiA+IHdvcmsgYXMg
ZXhwZWN0ZWQuDQo+IA0KPiBUaGF0IGlzIGEgZ29vZCBwb2ludC4NCj4gDQo+IEkgaGFkIGEgYnJp
ZWYgbG9vayBhdCBpdCwgYW5kIGl0IGxvb2tzIGxpa2UgaXQgd291bGQgYmUgcG9zc2libGUgdG8g
cGljaw0KPiBhIGNvdXBsZSBvZiBrZXJuZWwgcGF0Y2hlcyB0byBzdXBwb3J0IHRoZSB2YXJpb3Vz
IFNSIHRvcG9sb2dpZXMsIEkNCj4gY3JlYXRlZCBhIHRlc3QgYnJhbmNoIFsxXSB3aXRoIHRob3Nl
IHBhdGNoZXMuIERvIHlvdSB0aGluayB0aGlzIGlzIGENCj4gd29ya2FibGUgYXBwcm9hY2ggPw0K
PiANClllcywgSSB0aGluayBpdCdzIGRlZmluaXRlbHkgd29ya2FibGUuIEdvb2QgdG8ga25vdyB3
ZSBhbHJlYWR5IGhhdmUgYSBzZXQgb2YNCndvcmtpbmcgcGF0Y2hlcy4gQXQgdGhlIHNhbWUgdGlt
ZSwgd2Ugc2hvdWxkIHNwbGl0IHRoZSBwcm90ZWN0aW9uIGxvZ2ljcyBmcm9tDQpjb3JlIGxpa2Ug
TGludXggKGkuZS4sIG10ZC9zcGktbm9yL3N3cC5jKS4gSXMgdGhpcyBhbHNvIHNvbWV0aGluZyB5
b3UgY2FuDQphc3Npc3Qgd2l0aD8NCg0KSW4gYSBzZXJpZXMgWzJdLCBJIHNwbGl0IElEIHRhYmxl
cyBhbmQgU0ZEUCwgYnV0IG5vdCBmb3IgcHJvdGVjdGlvbi4gDQoNCj4gWzFdDQo+IGh0dHBzOi8v
c291cmNlLmRlbnguZGUvdS1ib290L2N1c3RvZGlhbnMvdS1ib290LXVzYi8tL2NvbW1pdHMvc3Bp
LW5vci00Yml0LXNyDQo+IA0KPiAtLQ0KPiBCZXN0IHJlZ2FyZHMsDQo+IE1hcmVrIFZhc3V0DQoN
ClRoYW5rcyENClRha2FoaXJvDQoNClsyXQ0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvdS1ib290
LzIwMjYwNjEyLXNwbGl0LWlkLXRhYmxlLWludG8tdmVuZG9yLWZpbGVzLXYxLTAtZGZhYWE4MmNj
NmYwQGluZmluZW9uLmNvbS8NCg0K
