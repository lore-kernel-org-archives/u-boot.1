Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE86C4451C
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 12:40:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB1D784E2D;
	Fri, 17 Jul 2026 14:39:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=infineon.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=infineon.com header.i=@infineon.com header.b="kf820cQ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26BBF84DAA; Fri, 17 Jul 2026 08:50:16 +0200 (CEST)
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8D7584D68
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 08:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Takahiro.Kuwano@infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1784271014; x=1815807014;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QHyOfKrCQSdMNe+BysR0/yfSD3+cOcIW7AWDr7oGjyI=;
 b=kf820cQ+IK/0OhI7BzrFGxUvlyaQCfoi3rbvVb/3CL0sFsDrRr/lECup
 lSLRyRdeY99+ALg0NOBSIKyT1FfOsMEOJwdDZbrvLt3nCumBIkuibdIXn
 yvaR0JSUc6WcPUcyFb5KpbM9NySrerzRTcrZ+eBJGNP2y939LBuI7CsNw M=;
X-CSE-ConnectionGUID: +RALTLGVRw+o6n2dKpVqlw==
X-CSE-MsgGUID: kzBe3lhVQOuANVNfV5PaEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="101286039"
X-IronPort-AV: E=Sophos;i="6.25,168,1779141600"; d="scan'208";a="101286039"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE822.infineon.com) ([172.23.29.53])
 by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 08:49:13 +0200
Received: from MUCSE816.infineon.com (172.23.29.42) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 17 Jul
 2026 08:49:13 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE816.infineon.com
 (172.23.29.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 17 Jul
 2026 08:49:12 +0200
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.043; Fri, 17 Jul 2026 08:49:12 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <weijie.gao@mediatek.com>, <u-boot@lists.denx.de>
CC: <GSS_MTK_Uboot_upstream@mediatek.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>, <marek.vasut+renesas@mailbox.org>,
 <tudor.ambarus@linaro.org>, <jeyu@issi.com>, <christoph.reiter@evk.biz>,
 <miquel.raynal@bootlin.com>, <yangshiji66@outlook.com>,
 <bernhard.messerklinger@at.abb.com>, <vaishnav.a@ti.com>,
 <prasad.kummari@amd.com>
Subject: RE: [PATCH v6 4/7] mtd: spi-nor-ids: Add 4K page support for Macronix
 MX25L25635E
Thread-Topic: [PATCH v6 4/7] mtd: spi-nor-ids: Add 4K page support for
 Macronix MX25L25635E
Thread-Index: AQHc/JlhmrwCxIewZEiWGKOfwEa/Y7Zbjk2AgBJmQICAA4A8EA==
Date: Fri, 17 Jul 2026 06:49:12 +0000
Message-ID: <42ec010326054892b3858e4cc13b00e7@infineon.com>
References: <cover.1781508530.git.weijie.gao@mediatek.com>
 <ab4739209544e1f55f623d17db1183547adce79b.1781508530.git.weijie.gao@mediatek.com>
 <d29fbb24a43b4593b7916bc50037d306@infineon.com>
 <55d9b1b63eb2418d4140b04b4bdb3dc3d4b7cabd.camel@mediatek.com>
In-Reply-To: <55d9b1b63eb2418d4140b04b4bdb3dc3d4b7cabd.camel@mediatek.com>
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

SGksDQoNCj4gT24gRnJpLCAyMDI2LTA3LTAzIGF0IDA4OjUxICswMDAwLCBUYWthaGlyby5LdXdh
bm9AaW5maW5lb24uY29tIHdyb3RlOg0KPiA+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5v
dCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+ID4geW91IGhhdmUgdmVy
aWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPg0KPiA+DQo+ID4gSGksDQo+ID4N
Cj4gPiBJbiBTdWJqZWN0LA0KPiA+IHMvNEsgcGFnZS80SyBzZWN0b3IvDQo+ID4NCj4gPiA+IE1Y
MjVMMjU2MzVFIHN1cHBvcnRzIDRLQi8zMktCLzY0S0IgdW5pZm9ybSBlcmFzZSBzZWN0b3IvYmxv
Y2tzLg0KPiA+ID4NCj4gPiA+IExpbms6DQo+ID4gPg0KPiBodHRwczovL3VybGRlZmVuc2UuY29t
L3YzL19faHR0cHM6Ly93d3cubXhpYy5jb20udHcvTGlzdHMvRGF0YXNoZWV0L0F0dGFjaG1lbnRz
Lzg1OTIvTVgyNUwyNTYzNUUsKjIwM1YsKjIwMjU2TWINCj4gLCoyMHYxLjMucGRmX187SlNVbCEh
Q1RSTktBOXdNZzBBUmJ3IWtIbTIzRVVYNFdhNUJ2eFQ1cUlkRVpiYVZLemNLSGR5Wno1b2FpcWlI
R25PeF9ZbUN5eUFpaGR2NWlsV29nRjZuTUNXT0NRX1Z2DQo+IGxlUmNxVDZxMTd2d1phT19oUlNi
NCQNCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFdlaWppZSBHYW8gPHdlaWppZS5nYW9AbWVkaWF0ZWsu
Y29tPg0KPiA+ID4gLS0tDQo+ID4gPiB2NS12Njogbm90IGNoYW5nZWQNCj4gPiA+IHYzLXY0OiB1
cGRhdGVkIGNvbW1pdCBtZXNzYWdlDQo+ID4gPiB2Mjogbm90IGNoYW5nZWQNCj4gPiA+IC0tLQ0K
PiA+ID4gIGRyaXZlcnMvbXRkL3NwaS9zcGktbm9yLWlkcy5jIHwgMiArLQ0KPiA+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4NCj4gPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGkvc3BpLW5vci1pZHMuYyBiL2RyaXZlcnMvbXRkL3Nw
aS9zcGktDQo+ID4gPiBub3ItaWRzLmMNCj4gPiA+IGluZGV4IDRkMDcyMjFhZTY1Li4wMThhODM0
MTU1MyAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS9zcGktbm9yLWlkcy5jDQo+
ID4gPiArKysgYi9kcml2ZXJzL210ZC9zcGkvc3BpLW5vci1pZHMuYw0KPiA+ID4gQEAgLTMyMyw3
ICszMjMsNyBAQCBjb25zdCBzdHJ1Y3QgZmxhc2hfaW5mbyBzcGlfbm9yX2lkc1tdID0gew0KPiA+
ID4gICAgICAgICB7IElORk8oIm14MjV1NTEyNDVnIiwgMHhjMjI1M2EsIDAsIDY0ICogMTAyNCwg
MTAyNCwgU0VDVF80Sw0KPiA+ID4gfA0KPiA+ID4gICAgICAgICAgICAgICAgU1BJX05PUl9EVUFM
X1JFQUQgfCBTUElfTk9SX1FVQURfUkVBRCB8DQo+ID4gPiBTUElfTk9SXzRCX09QQ09ERVMpIH0s
DQo+ID4gPiAgICAgICAgIHsgSU5GTygibXgyNWwxMjg1NWUiLCAweGMyMjYxOCwgMCwgNjQgKiAx
MDI0LCAyNTYsIDApIH0sDQo+ID4gPiAtICAgICAgIHsgSU5GTygibXgyNWwyNTYzNWUiLCAweGMy
MjAxOSwgMCwgNjQgKiAxMDI0LCA1MTIsDQo+ID4gPiBTUElfTk9SX0RVQUxfUkVBRCB8IFNQSV9O
T1JfUVVBRF9SRUFEKSB9LA0KPiA+ID4gKyAgICAgICB7IElORk8oIm14MjVsMjU2MzVlIiwgMHhj
MjIwMTksIDAsIDY0ICogMTAyNCwgNTEyLCBTRUNUXzRLDQo+ID4gPiB8IFNQSV9OT1JfRFVBTF9S
RUFEIHwgU1BJX05PUl9RVUFEX1JFQUQpIH0sDQo+ID4NCj4gPiBMaWtlIGFzIHNvbWUgY2hpcHMg
aW4gdGhpcyBzZXJpZXMsIHRoaXMgY2hpcCBkb2Vzbid0IHN1cHBvcnQgUFBfMV8xXzQNCj4gPiAo
MzJoKS4NCj4gPiBNYXliZSB1c2luZyBTRkRQIGNhbiBjb3JyZWN0IHRoZSBjaGlwIGNhcGFiaWxp
dHkuDQo+ID4gSWYgeW91IHRlc3RlZCB0aGlzIGNoaXAsIGl0IHdvdWxkIGJlIGdvb2QgdG8gZGVz
Y3JpYmUgdGVzdA0KPiA+IGNvbmRpdGlvbnMsIHN1Y2gNCj4gPiBhcyBTRkRQIHVzZWQgKG9yIG5v
dCksIHJlYWQvcHJvZ3JhbSBwcm90b2NvbHMsIGFuZCBzbyBmb3J0aC4NCj4gPg0KPiA+IFRoaXMg
aXMgYSBwcmUtZXhpc3RpbmcgaXNzdWUgaW4gY29yZSB0aGF0IGFkZHMgUFBfMV8xXzQgY2FwYWJp
bGl0eQ0KPiA+IGFsb25nIHdpdGgNCj4gPiBSRUFEXzFfMV80Lg0KPiANCj4gTXkgdGVzdCBwbGF0
Zm9ybSBzdXBwb3J0cyBvbmx5IDEtMS0xIHBhZ2UgcHJvZ3JhbS4gU28gSSBjYW4ndCBhbmQNCj4g
ZGlkbid0IHRlc3QgdGhlIDEtMS00LzEtNC00IHBhZ2UgcHJvZ3JhbS4NCj4gDQo+IEkgY2FuIHJl
bW92ZSB0aGUgU1BJX05PUl9RVUFEX1JFQUQgZmxhZyBpZiBuZWNlc3NhcnkuDQo+IA0KDQpZb3Ug
YWxyZWFkeSByZW1vdmVkIHRoZSBmbGFnIGluIHY3IGJ1dCBJIGRpZG4ndCBtZWFuIHJlbW92aW5n
IGl0Lg0KSSBqdXN0IHdhbnRlZCB0byBrbm93IHlvdXIgdGVzdCBjb25kaXRpb24uIA0KU29tZW9u
ZSBlbHNlIG1pZ2h0IGJlIHVzaW5nIHRoaXMgY2hpcCB3aXRoIDEtMS00IHJlYWQgYW5kIDEtMS0x
IHBwDQpzbyBwbGVhc2Uga2VlcCBhcyBpdCBpcy4NCg0KPiA+DQo+ID4gPiAgICAgICAgIHsgSU5G
TygibXgyNXUyNTYzNWYiLCAweGMyMjUzOSwgMCwgNjQgKiAxMDI0LCA1MTIsIFNFQ1RfNEsNCj4g
PiA+IHwgU1BJX05PUl80Ql9PUENPREVTKSB9LA0KPiA+ID4gICAgICAgICB7IElORk8oIm14MjV2
ODAzNWYiLCAgMHhjMjIzMTQsIDAsIDY0ICogMTAyNCwgIDE2LCBTRUNUXzRLDQo+ID4gPiB8IFNQ
SV9OT1JfRFVBTF9SRUFEIHwgU1BJX05PUl9RVUFEX1JFQUQpIH0sDQo+ID4gPiAgICAgICAgIHsg
SU5GTygibXgyNXIxNjM1ZiIsICAweGMyMjgxNSwgMCwgNjQgKiAxMDI0LCAgMzIsIFNFQ1RfNEsN
Cj4gPiA+IHwgU1BJX05PUl9EVUFMX1JFQUQgfCBTUElfTk9SX1FVQURfUkVBRCkgfSwNCj4gPiA+
IC0tDQo+ID4gPiAyLjQ1LjINCj4gPg0KPiA+IFRoYW5rcywNCj4gPiBUYWthaGlybw0KPiA+DQoN
ClRoYW5rcywNClRha2FoaXJvDQoNCg==
