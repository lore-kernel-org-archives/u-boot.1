Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545CAC44516
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 12:39:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8608184E20;
	Fri, 17 Jul 2026 14:39:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=infineon.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=infineon.com header.i=@infineon.com header.b="KkksunTc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72F4284D85; Fri, 17 Jul 2026 08:36:13 +0200 (CEST)
Received: from smtp11.infineon.com (smtp11.infineon.com
 [IPv6:2a00:18f0:1e00:4::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B15A84D16
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 08:36:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Takahiro.Kuwano@infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1784270171; x=1815806171;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=l4r7ey+tM8XAFe3qecK3UoEgzrBC2jdw5pESZi3MErA=;
 b=KkksunTcLJS8EvziWSH+YrsUeOjwuGfnV0id1e+MbR1P7sROcCJQ2os3
 GfYH/YmUqfHI2E/9IWdyaI0bg4TpIICVqy6uE40QoHSiHhBFjI3RUBfXQ
 ulm6qk0AeMWKg3sBeFS3R7v+AwSEE/gxM5gUYNuT2A4ONB9DnsQu5x++n Y=;
X-CSE-ConnectionGUID: 6jramDBGQ+6GOGTmMF/KwA==
X-CSE-MsgGUID: ACcZNJPFSEiEuG0/Na1ITw==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="152026758"
X-IronPort-AV: E=Sophos;i="6.25,168,1779141600"; d="scan'208";a="152026758"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE803.infineon.com) ([172.23.29.29])
 by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 08:36:11 +0200
Received: from MUCSE813.infineon.com (172.23.29.39) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 17 Jul
 2026 08:36:10 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE813.infineon.com
 (172.23.29.39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 17 Jul
 2026 08:36:10 +0200
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.043; Fri, 17 Jul 2026 08:36:10 +0200
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
Thread-Index: AQHc/Jlf2JBwehz5N06ixsn9vXvgT7ZbmczQgBJXqACAA3tiYIAABoFA
Date: Fri, 17 Jul 2026 06:36:10 +0000
Message-ID: <9ce30036a4df4f8cb473effe2fe3f501@infineon.com>
References: <cover.1781508530.git.weijie.gao@mediatek.com>
 <3facbb0d047ffeab20aacee385ce137bb8894716.1781508530.git.weijie.gao@mediatek.com>
 <d8dfad96296b4654b206e08dc2156600@infineon.com>
 <7be0c4e8dc3fe32bef1452de434a9812719d5dd3.camel@mediatek.com>
 <1a1f02b8f5ef4037a748328cc293e0d4@infineon.com>
In-Reply-To: <1a1f02b8f5ef4037a748328cc293e0d4@infineon.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3V3YW5vIFRha2FoaXJv
IChBVFYgTVMgTVBMIFBBRSAtIE1TKQ0KPiBTZW50OiBGcmlkYXksIEp1bHkgMTcsIDIwMjYgMzoz
MyBQTQ0KPiBUbzogJ1dlaWppZSBHYW8nIDx3ZWlqaWUuZ2FvQG1lZGlhdGVrLmNvbT47IHUtYm9v
dEBsaXN0cy5kZW54LmRlDQo+IENjOiBHU1NfTVRLX1Vib290X3Vwc3RyZWFtQG1lZGlhdGVrLmNv
bTsgdHJpbmlAa29uc3Vsa28uY29tOyB2aWduZXNockB0aS5jb207IG1hcmVrLnZhc3V0K3JlbmVz
YXNAbWFpbGJveC5vcmc7DQo+IHR1ZG9yLmFtYmFydXNAbGluYXJvLm9yZzsgamV5dUBpc3NpLmNv
bTsgY2hyaXN0b3BoLnJlaXRlckBldmsuYml6OyBtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tOw0K
PiB5YW5nc2hpamk2NkBvdXRsb29rLmNvbTsgYmVybmhhcmQubWVzc2Vya2xpbmdlckBhdC5hYmIu
Y29tOyB2YWlzaG5hdi5hQHRpLmNvbTsgcHJhc2FkLmt1bW1hcmlAYW1kLmNvbQ0KPiBTdWJqZWN0
OiBSRTogW1BBVENIIHY2IDEvN10gbXRkOiBzcGktbm9yLWlkczogQ29ycmVjdCBmbGFzaCBmbGFn
cyBmb3IgRVNNVC9FT04gZmxhc2hlcw0KPiANCj4gSGksDQo+IA0KPiA+IE9uIEZyaSwgMjAyNi0w
Ny0wMyBhdCAwOTowMyArMDAwMCwgVGFrYWhpcm8uS3V3YW5vQGluZmluZW9uLmNvbSB3cm90ZToN
Cj4gPiA+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+ID4gPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9y
IHRoZSBjb250ZW50Lg0KPiA+ID4NCj4gPiA+DQo+ID4gPiBIaSwNCj4gPiA+DQo+ID4gPiA+IEFs
bCBjdXJyZW50bHkgc3VwcG9ydGVkIEVTTVQvRU9OIGZsYXNoZXMgc3VwcG9ydHMgNEtCIHNlY3Rv
ciBhbmQNCj4gPiA+ID4gZHVhbCByZWFkLg0KPiA+ID4gPiBFTjI1UTgwQiBhbHNvIHN1cHBvcnRz
IDEtMS00IHF1YWQgcmVhZC4NCj4gPiA+ID4NCj4gPiA+ID4gTGluazoNCj4gPiA+ID4NCj4gPg0K
PiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly93d3cuZXNtdC5jb20udHcvdXBs
b2FkL3BkZi9FU01UL2RhdGFzaGVldHMvRU4yNVE4MEIucGRmX187ISFDVFJOS0E5d01nMEFSYncN
Cj4gPiAhajdFNjgxWTRWenQ2UzRhSXNoZWlWZFZPcTltOGR2MFlUSERVOWg5QmQzZnU4M0FTeUlU
eHQ0Y3hvdTU1aGVSQk9TNTJwOHBPZnNtdTVjalk1dUs3TWRRbkE1WW1PZ0UkDQo+ID4gPiA+IExp
bms6DQo+ID4gPiA+DQo+ID4NCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8v
d3d3LmVzbXQuY29tLnR3L3VwbG9hZC9wZGYvRVNNVC9kYXRhc2hlZXRzL0VOMjVRSDEyOEEqMjAo
MlRDKS5wZGZfXztKUSEhQ1RSDQo+ID4gTktBOXdNZzBBUmJ3IWo3RTY4MVk0Vnp0NlM0YUlzaGVp
VmRWT3E5bThkdjBZVEhEVTloOUJkM2Z1ODNBU3lJVHh0NGN4b3U1NWhlUkJPUzUycDhwT2ZzbXU1
Y2pZNXVLN01kUW42Q3czRlkwJA0KPiA+ID4gPiBMaW5rOg0KPiA+ID4gPg0KPiA+DQo+IGh0dHBz
Oi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL3d3dy5lc210LmNvbS50dy91cGxvYWQvcGRm
L0VTTVQvZGF0YXNoZWV0cy9FTjI1UzY0QSgyU0MpLnBkZl9fOyEhQ1RSTktBOXdNZw0KPiA+IDBB
UmJ3IWo3RTY4MVk0Vnp0NlM0YUlzaGVpVmRWT3E5bThkdjBZVEhEVTloOUJkM2Z1ODNBU3lJVHh0
NGN4b3U1NWhlUkJPUzUycDhwT2ZzbXU1Y2pZNXVLN01kUW5mUkx5MWpFJA0KPiA+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBXZWlqaWUgR2FvIDx3ZWlqaWUuZ2FvQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4g
LS0tDQo+ID4gPiA+IHY2OiByZW1vdmVkIFNQSV9OT1JfUVVBRF9SRUFEIGZyb20gaW5jb21wYXRp
YmxlIGZsYXNoZXMNCj4gPiA+ID4gdjU6IG5vdCBjaGFuZ2VkDQo+ID4gPiA+IHYzLXY0OiB1cGRh
dGVkIGNvbW1pdCBtZXNzYWdlDQo+ID4gPiA+IHYyOiBub3QgY2hhbmdlZA0KPiA+ID4gPiAtLS0N
Cj4gPiA+ID4gIGRyaXZlcnMvbXRkL3NwaS9zcGktbm9yLWlkcy5jIHwgMTIgKysrKysrLS0tLS0t
DQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygt
KQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpL3NwaS1ub3It
aWRzLmMgYi9kcml2ZXJzL210ZC9zcGkvc3BpLQ0KPiA+ID4gPiBub3ItaWRzLmMNCj4gPiA+ID4g
aW5kZXggYzBmYTk4NDI0YWEuLjBkYWNiNGFiZGJjIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2
ZXJzL210ZC9zcGkvc3BpLW5vci1pZHMuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL210ZC9zcGkv
c3BpLW5vci1pZHMuYw0KPiA+ID4gPiBAQCAtOTAsMTIgKzkwLDEyIEBAIGNvbnN0IHN0cnVjdCBm
bGFzaF9pbmZvIHNwaV9ub3JfaWRzW10gPSB7DQo+ID4gPiA+ICAjZW5kaWYNCj4gPiA+ID4gICNp
ZmRlZiBDT05GSUdfU1BJX0ZMQVNIX0VPTiAgICAgICAgICAgIC8qIEVPTiAqLw0KPiA+ID4gPiAg
ICAgICAgIC8qIEVPTiAtLSBlbjI1eHh4ICovDQo+ID4gPiA+IC0gICAgICAgeyBJTkZPKCJlbjI1
cTgwYiIsICAgMHgxYzMwMTQsIDAsIDY0ICogMTAyNCwgICAxNiwgU0VDVF80SykNCj4gPiA+ID4g
fSwNCj4gPiA+ID4gLSAgICAgICB7IElORk8oImVuMjVxMzJiIiwgICAweDFjMzAxNiwgMCwgNjQg
KiAxMDI0LCAgIDY0LCAwKSB9LA0KPiA+ID4gPiAtICAgICAgIHsgSU5GTygiZW4yNXE2NCIsICAg
IDB4MWMzMDE3LCAwLCA2NCAqIDEwMjQsICAxMjgsIFNFQ1RfNEspDQo+ID4gPiA+IH0sDQo+ID4g
PiA+IC0gICAgICAgeyBJTkZPKCJlbjI1cTEyOGIiLCAgMHgxYzMwMTgsIDAsIDY0ICogMTAyNCwg
IDI1NiwgMCkgfSwNCj4gPiA+ID4gLSAgICAgICB7IElORk8oImVuMjVxaDEyOCIsICAweDFjNzAx
OCwgMCwgNjQgKiAxMDI0LCAgMjU2LCAwKSB9LA0KPiA+ID4gPiAtICAgICAgIHsgSU5GTygiZW4y
NXM2NCIsICAgIDB4MWMzODE3LCAwLCA2NCAqIDEwMjQsICAxMjgsIFNFQ1RfNEspDQo+ID4gPiA+
IH0sDQo+ID4gPiA+ICsgICAgICAgeyBJTkZPKCJlbjI1cTgwYiIsICAgMHgxYzMwMTQsIDAsIDY0
ICogMTAyNCwgICAxNiwgU0VDVF80Sw0KPiA+ID4gPiB8IFNQSV9OT1JfRFVBTF9SRUFEIHwgU1BJ
X05PUl9RVUFEX1JFQUQpIH0sDQo+ID4gPiA+ICsgICAgICAgeyBJTkZPKCJlbjI1cTMyYiIsICAg
MHgxYzMwMTYsIDAsIDY0ICogMTAyNCwgICA2NCwgU0VDVF80Sw0KPiA+ID4gPiB8IFNQSV9OT1Jf
RFVBTF9SRUFEKSB9LA0KPiA+ID4gPiArICAgICAgIHsgSU5GTygiZW4yNXE2NCIsICAgIDB4MWMz
MDE3LCAwLCA2NCAqIDEwMjQsICAxMjgsIFNFQ1RfNEsNCj4gPiA+ID4gfCBTUElfTk9SX0RVQUxf
UkVBRCkgfSwNCj4gPiA+ID4gKyAgICAgICB7IElORk8oImVuMjVxMTI4YiIsICAweDFjMzAxOCwg
MCwgNjQgKiAxMDI0LCAgMjU2LCBTRUNUXzRLDQo+ID4gPiA+IHwgU1BJX05PUl9EVUFMX1JFQUQp
IH0sDQo+ID4gPiA+ICsgICAgICAgeyBJTkZPKCJlbjI1cWgxMjgiLCAgMHgxYzcwMTgsIDAsIDY0
ICogMTAyNCwgIDI1NiwgU0VDVF80Sw0KPiA+ID4gPiB8IFNQSV9OT1JfRFVBTF9SRUFEKSB9LA0K
PiA+ID4gPiArICAgICAgIHsgSU5GTygiZW4yNXM2NCIsICAgIDB4MWMzODE3LCAwLCA2NCAqIDEw
MjQsICAxMjgsIFNFQ1RfNEsNCj4gPiA+ID4gfCBTUElfTk9SX0RVQUxfUkVBRCkgfSwNCj4gPiA+
DQo+ID4gPiBJbiBvdXIgZGlzY3Vzc2lvbiBpbiBwcmV2aW91cyByZXZpc2lvbiBbMV0sIG9ubHkg
ZW4yNXFoMTI4IHN1cHBvcnRzDQo+ID4gPiAxLTEtNA0KPiA+ID4gcmVhZCBhbmQgcHJvZ3JhbSwg
YnV0IHlvdSBzZXQgUVVBRF9SRUFEIGZsYWcgaW4gZW4yNXE4MGIgaW5zdGVhZC4NCj4gPiA+IFBs
ZWFzZSBmaXguDQo+ID4NCj4gPiBJIHJlc2VydmVkIHRoaXMgZmxhZyBiZWNhdXNlIEkgZm91bmQg
YSBuZXdlciBkYXRhc2hlZXQgdGhhdCBjbGFpbXMgaXQNCj4gPiBzdXBwb3J0cyB0aGUgNkIgb3Bj
b2RlIGZvciAxLTEtNCByZWFkOg0KPiA+DQo+ID4gaHR0cHM6Ly93d3cubm92aXRyb25pYy5jb20v
RGF0ZW5ibCVDMyVBNHR0ZXIvQWt0aXZlJTIwS29tcG9uZW50ZW4vRU4yNVE4MEIlMjgyQyUyOS5w
ZGYNCj4gPg0KPiBCdXQgd2h5IGRpZCB5b3UgZHJvcCBRVUFEX1JFQUQgZmxhZyBmcm9tIGVuMjVx
aDEyOD8NCj4gUGVyIGRhdGFzaGVldCwgaXQgc3VwcG9ydHMgYm90aCAxLTEtNCByZWFkIGFuZCBw
cm9ncmFtLg0KPiANCj4gPiBBcyB0aGUgRU4yNVE4MEIgaXMgRU9MLCBJIGNhbid0IGJ1eSBvbmUg
Zm9yIHRlc3RpbmcuIEknbGwgcmVtb3ZlIHRoaXMNCj4gPiBmbGFnIGluIG5leHQgcGF0Y2ggc2Vy
aWVzLg0KPiA+DQo+IEkgd291bGQgcmVjb21tZW5kIG5vdCB0byBhZGQgRU9MIGNoaXBzLg0KPiBX
ZSBzaG91bGQgbm90IGV4cGFuZCBJRCBkYXRhYmFzZSBmb3IgY2hpcHMgdGhhdCBub2JvZHkgaGFz
IGNoYW5jZSB0byB1c2UuDQo+IA0KT2ggc29ycnksIG15IGJhZC4gWW91IGRvbid0IHRyeSB0byBh
ZGQgdGhpcyBjaGlwLg0KUGxlYXNlIGlnbm9yZSBteSBjb21tZW50Lg0KDQo+IFRoYW5rcywNCj4g
VGFrYWhpcm8NCg0K
