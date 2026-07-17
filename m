Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122CAC4451C
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 12:39:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 447D584DF4;
	Fri, 17 Jul 2026 14:39:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=infineon.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=infineon.com header.i=@infineon.com header.b="JLo5+Zy2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98A6984D85; Fri, 17 Jul 2026 08:32:42 +0200 (CEST)
Received: from smtp2.infineon.com (smtp2.infineon.com
 [IPv6:2a00:18f0:1e00:4::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1780684D16
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 08:32:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Takahiro.Kuwano@infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1784269960; x=1815805960;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VB5WXBQSke+BVgS+m3X7tMRSv4PJOjt+6JIiAvCRHgo=;
 b=JLo5+Zy2xdf7U/Mi/CvV7gCOecJkkXgDtKlQAMq5jEXD/dAM2Se9lqol
 43NRNNlNr7vsTye0Pe7AsHldTmLyVB9e+7FgsvjOu+u6KU9IMzNMvy3b6
 bzhQk9Y9NG9Jy47ymwfwwHhZZ65TQNUDUiDFI7mhA8G3EBvUU4qYNegXS w=;
X-CSE-ConnectionGUID: RQjNaP5WTdidgpwJ305g0w==
X-CSE-MsgGUID: AQoofzVLQ2WukoCHRtVgAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="168000424"
X-IronPort-AV: E=Sophos;i="6.25,168,1779141600"; d="scan'208";a="168000424"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
 by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 08:32:40 +0200
Received: from MUCSE813.infineon.com (172.23.29.39) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 17 Jul
 2026 08:32:39 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE813.infineon.com
 (172.23.29.39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 17 Jul
 2026 08:32:39 +0200
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.043; Fri, 17 Jul 2026 08:32:39 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <weijie.gao@mediatek.com>, <u-boot@lists.denx.de>
CC: <GSS_MTK_Uboot_upstream@mediatek.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>, <marek.vasut+renesas@mailbox.org>,
 <tudor.ambarus@linaro.org>, <jeyu@issi.com>, <christoph.reiter@evk.biz>,
 <miquel.raynal@bootlin.com>, <yangshiji66@outlook.com>,
 <bernhard.messerklinger@at.abb.com>, <vaishnav.a@ti.com>,
 <prasad.kummari@amd.com>
Subject: RE: [PATCH v6 1/7] mtd: spi-nor-ids: Correct flash flags for ESMT/EON
 flashes
Thread-Topic: [PATCH v6 1/7] mtd: spi-nor-ids: Correct flash flags for
 ESMT/EON flashes
Thread-Index: AQHc/Jlf2JBwehz5N06ixsn9vXvgT7ZbmczQgBJXqACAA3tiYA==
Date: Fri, 17 Jul 2026 06:32:38 +0000
Message-ID: <1a1f02b8f5ef4037a748328cc293e0d4@infineon.com>
References: <cover.1781508530.git.weijie.gao@mediatek.com>
 <3facbb0d047ffeab20aacee385ce137bb8894716.1781508530.git.weijie.gao@mediatek.com>
 <d8dfad96296b4654b206e08dc2156600@infineon.com>
 <7be0c4e8dc3fe32bef1452de434a9812719d5dd3.camel@mediatek.com>
In-Reply-To: <7be0c4e8dc3fe32bef1452de434a9812719d5dd3.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 17 Jul 2026 14:39:44 +0200
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

SGksDQoNCj4gT24gRnJpLCAyMDI2LTA3LTAzIGF0IDA5OjAzICswMDAwLCBUYWthaGlyby5LdXdh
bm9AaW5maW5lb24uY29tIHdyb3RlOg0KPiA+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5v
dCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+ID4geW91IGhhdmUgdmVy
aWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPg0KPiA+DQo+ID4gSGksDQo+ID4N
Cj4gPiA+IEFsbCBjdXJyZW50bHkgc3VwcG9ydGVkIEVTTVQvRU9OIGZsYXNoZXMgc3VwcG9ydHMg
NEtCIHNlY3RvciBhbmQNCj4gPiA+IGR1YWwgcmVhZC4NCj4gPiA+IEVOMjVRODBCIGFsc28gc3Vw
cG9ydHMgMS0xLTQgcXVhZCByZWFkLg0KPiA+ID4NCj4gPiA+IExpbms6DQo+ID4gPg0KPiBodHRw
czovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly93d3cuZXNtdC5jb20udHcvdXBsb2FkL3Bk
Zi9FU01UL2RhdGFzaGVldHMvRU4yNVE4MEIucGRmX187ISFDVFJOS0E5d01nMEFSYncNCj4gIWo3
RTY4MVk0Vnp0NlM0YUlzaGVpVmRWT3E5bThkdjBZVEhEVTloOUJkM2Z1ODNBU3lJVHh0NGN4b3U1
NWhlUkJPUzUycDhwT2ZzbXU1Y2pZNXVLN01kUW5BNVltT2dFJA0KPiA+ID4gTGluazoNCj4gPiA+
DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL3d3dy5lc210LmNvbS50dy91
cGxvYWQvcGRmL0VTTVQvZGF0YXNoZWV0cy9FTjI1UUgxMjhBKjIwKDJUQykucGRmX187SlEhIUNU
Ug0KPiBOS0E5d01nMEFSYnchajdFNjgxWTRWenQ2UzRhSXNoZWlWZFZPcTltOGR2MFlUSERVOWg5
QmQzZnU4M0FTeUlUeHQ0Y3hvdTU1aGVSQk9TNTJwOHBPZnNtdTVjalk1dUs3TWRRbjZDdzNGWTAk
DQo+ID4gPiBMaW5rOg0KPiA+ID4NCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBz
Oi8vd3d3LmVzbXQuY29tLnR3L3VwbG9hZC9wZGYvRVNNVC9kYXRhc2hlZXRzL0VOMjVTNjRBKDJT
QykucGRmX187ISFDVFJOS0E5d01nDQo+IDBBUmJ3IWo3RTY4MVk0Vnp0NlM0YUlzaGVpVmRWT3E5
bThkdjBZVEhEVTloOUJkM2Z1ODNBU3lJVHh0NGN4b3U1NWhlUkJPUzUycDhwT2ZzbXU1Y2pZNXVL
N01kUW5mUkx5MWpFJA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogV2VpamllIEdhbyA8d2VpamllLmdh
b0BtZWRpYXRlay5jb20+DQo+ID4gPiAtLS0NCj4gPiA+IHY2OiByZW1vdmVkIFNQSV9OT1JfUVVB
RF9SRUFEIGZyb20gaW5jb21wYXRpYmxlIGZsYXNoZXMNCj4gPiA+IHY1OiBub3QgY2hhbmdlZA0K
PiA+ID4gdjMtdjQ6IHVwZGF0ZWQgY29tbWl0IG1lc3NhZ2UNCj4gPiA+IHYyOiBub3QgY2hhbmdl
ZA0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9tdGQvc3BpL3NwaS1ub3ItaWRzLmMgfCAxMiAr
KysrKystLS0tLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2IGRl
bGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGkvc3Bp
LW5vci1pZHMuYyBiL2RyaXZlcnMvbXRkL3NwaS9zcGktDQo+ID4gPiBub3ItaWRzLmMNCj4gPiA+
IGluZGV4IGMwZmE5ODQyNGFhLi4wZGFjYjRhYmRiYyAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZl
cnMvbXRkL3NwaS9zcGktbm9yLWlkcy5jDQo+ID4gPiArKysgYi9kcml2ZXJzL210ZC9zcGkvc3Bp
LW5vci1pZHMuYw0KPiA+ID4gQEAgLTkwLDEyICs5MCwxMiBAQCBjb25zdCBzdHJ1Y3QgZmxhc2hf
aW5mbyBzcGlfbm9yX2lkc1tdID0gew0KPiA+ID4gICNlbmRpZg0KPiA+ID4gICNpZmRlZiBDT05G
SUdfU1BJX0ZMQVNIX0VPTiAgICAgICAgICAgIC8qIEVPTiAqLw0KPiA+ID4gICAgICAgICAvKiBF
T04gLS0gZW4yNXh4eCAqLw0KPiA+ID4gLSAgICAgICB7IElORk8oImVuMjVxODBiIiwgICAweDFj
MzAxNCwgMCwgNjQgKiAxMDI0LCAgIDE2LCBTRUNUXzRLKQ0KPiA+ID4gfSwNCj4gPiA+IC0gICAg
ICAgeyBJTkZPKCJlbjI1cTMyYiIsICAgMHgxYzMwMTYsIDAsIDY0ICogMTAyNCwgICA2NCwgMCkg
fSwNCj4gPiA+IC0gICAgICAgeyBJTkZPKCJlbjI1cTY0IiwgICAgMHgxYzMwMTcsIDAsIDY0ICog
MTAyNCwgIDEyOCwgU0VDVF80SykNCj4gPiA+IH0sDQo+ID4gPiAtICAgICAgIHsgSU5GTygiZW4y
NXExMjhiIiwgIDB4MWMzMDE4LCAwLCA2NCAqIDEwMjQsICAyNTYsIDApIH0sDQo+ID4gPiAtICAg
ICAgIHsgSU5GTygiZW4yNXFoMTI4IiwgIDB4MWM3MDE4LCAwLCA2NCAqIDEwMjQsICAyNTYsIDAp
IH0sDQo+ID4gPiAtICAgICAgIHsgSU5GTygiZW4yNXM2NCIsICAgIDB4MWMzODE3LCAwLCA2NCAq
IDEwMjQsICAxMjgsIFNFQ1RfNEspDQo+ID4gPiB9LA0KPiA+ID4gKyAgICAgICB7IElORk8oImVu
MjVxODBiIiwgICAweDFjMzAxNCwgMCwgNjQgKiAxMDI0LCAgIDE2LCBTRUNUXzRLDQo+ID4gPiB8
IFNQSV9OT1JfRFVBTF9SRUFEIHwgU1BJX05PUl9RVUFEX1JFQUQpIH0sDQo+ID4gPiArICAgICAg
IHsgSU5GTygiZW4yNXEzMmIiLCAgIDB4MWMzMDE2LCAwLCA2NCAqIDEwMjQsICAgNjQsIFNFQ1Rf
NEsNCj4gPiA+IHwgU1BJX05PUl9EVUFMX1JFQUQpIH0sDQo+ID4gPiArICAgICAgIHsgSU5GTygi
ZW4yNXE2NCIsICAgIDB4MWMzMDE3LCAwLCA2NCAqIDEwMjQsICAxMjgsIFNFQ1RfNEsNCj4gPiA+
IHwgU1BJX05PUl9EVUFMX1JFQUQpIH0sDQo+ID4gPiArICAgICAgIHsgSU5GTygiZW4yNXExMjhi
IiwgIDB4MWMzMDE4LCAwLCA2NCAqIDEwMjQsICAyNTYsIFNFQ1RfNEsNCj4gPiA+IHwgU1BJX05P
Ul9EVUFMX1JFQUQpIH0sDQo+ID4gPiArICAgICAgIHsgSU5GTygiZW4yNXFoMTI4IiwgIDB4MWM3
MDE4LCAwLCA2NCAqIDEwMjQsICAyNTYsIFNFQ1RfNEsNCj4gPiA+IHwgU1BJX05PUl9EVUFMX1JF
QUQpIH0sDQo+ID4gPiArICAgICAgIHsgSU5GTygiZW4yNXM2NCIsICAgIDB4MWMzODE3LCAwLCA2
NCAqIDEwMjQsICAxMjgsIFNFQ1RfNEsNCj4gPiA+IHwgU1BJX05PUl9EVUFMX1JFQUQpIH0sDQo+
ID4NCj4gPiBJbiBvdXIgZGlzY3Vzc2lvbiBpbiBwcmV2aW91cyByZXZpc2lvbiBbMV0sIG9ubHkg
ZW4yNXFoMTI4IHN1cHBvcnRzDQo+ID4gMS0xLTQNCj4gPiByZWFkIGFuZCBwcm9ncmFtLCBidXQg
eW91IHNldCBRVUFEX1JFQUQgZmxhZyBpbiBlbjI1cTgwYiBpbnN0ZWFkLg0KPiA+IFBsZWFzZSBm
aXguDQo+IA0KPiBJIHJlc2VydmVkIHRoaXMgZmxhZyBiZWNhdXNlIEkgZm91bmQgYSBuZXdlciBk
YXRhc2hlZXQgdGhhdCBjbGFpbXMgaXQNCj4gc3VwcG9ydHMgdGhlIDZCIG9wY29kZSBmb3IgMS0x
LTQgcmVhZDoNCj4gDQo+IGh0dHBzOi8vd3d3Lm5vdml0cm9uaWMuY29tL0RhdGVuYmwlQzMlQTR0
dGVyL0FrdGl2ZSUyMEtvbXBvbmVudGVuL0VOMjVRODBCJTI4MkMlMjkucGRmDQo+IA0KQnV0IHdo
eSBkaWQgeW91IGRyb3AgUVVBRF9SRUFEIGZsYWcgZnJvbSBlbjI1cWgxMjg/DQpQZXIgZGF0YXNo
ZWV0LCBpdCBzdXBwb3J0cyBib3RoIDEtMS00IHJlYWQgYW5kIHByb2dyYW0uDQoNCj4gQXMgdGhl
IEVOMjVRODBCIGlzIEVPTCwgSSBjYW4ndCBidXkgb25lIGZvciB0ZXN0aW5nLiBJJ2xsIHJlbW92
ZSB0aGlzDQo+IGZsYWcgaW4gbmV4dCBwYXRjaCBzZXJpZXMuDQo+IA0KSSB3b3VsZCByZWNvbW1l
bmQgbm90IHRvIGFkZCBFT0wgY2hpcHMuDQpXZSBzaG91bGQgbm90IGV4cGFuZCBJRCBkYXRhYmFz
ZSBmb3IgY2hpcHMgdGhhdCBub2JvZHkgaGFzIGNoYW5jZSB0byB1c2UuDQoNClRoYW5rcywNClRh
a2FoaXJvDQoNCg==
