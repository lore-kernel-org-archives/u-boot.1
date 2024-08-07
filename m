Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE9BC52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 09:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0894488B89;
	Wed,  7 Aug 2024 11:58:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="crVLzVQj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20D8488B98; Wed,  7 Aug 2024 11:58:55 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30B9188B87
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 11:58:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1723024732; x=1725616732;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dadiAj+jsmfwXQkoWSkR0ykmcg2x85BALnJQN0DuS/s=;
 b=crVLzVQj93wgbk/fGeTZXT8nzfIq/kMxhp2D/yDFDEDh42vc+kgjAdQmYLgiN5SU
 a0qA2JwuFgnX+3teYkGg58Aofia/asVcuTq8LXnA7b5fSjmS+QeTIp4oQeXl6YRM
 AYQs/Nzb12CyIFcXTkc1+IG64udGxS+duSc+76BlJnU=;
X-AuditID: ac14000a-03e52700000021bc-5a-66b3455cf6b1
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id B3.B4.08636.C5543B66;
 Wed,  7 Aug 2024 11:58:52 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 7 Aug 2024
 11:58:52 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Wed, 7 Aug 2024 11:58:52 +0200
From: Benjamin Hahn <B.Hahn@phytec.de>
To: Lukasz Majewski <lukma@denx.de>, Teresa Remmet <T.Remmet@phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Cem Tenruh <C.Tenruh@phytec.de>, "Martyn
 Welch" <martyn.welch@collabora.com>, Simon Glass <sjg@chromium.org>, "Fabio
 Estevam" <festevam@gmail.com>
Subject: Re: [PATCH v3] config: Add 'update_bootimg' command to update
 flash.bin on Phytec's imx8mm
Thread-Topic: [PATCH v3] config: Add 'update_bootimg' command to update
 flash.bin on Phytec's imx8mm
Thread-Index: AQHa59hOrMsGpuHsJEal2CNafihrfbIbb5gA
Date: Wed, 7 Aug 2024 09:58:52 +0000
Message-ID: <dd54f3f8-7d80-4d0c-9eaa-639e45ddfdcf@phytec.de>
References: <20240806081131.4065425-1-lukma@denx.de>
In-Reply-To: <20240806081131.4065425-1-lukma@denx.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <352BF19DDE0E5E4E924FCE9E4BD5908D@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsWyRpKBVzfGdXOaQf8EHYuHV/0tnr+7zGTx
 4GIXi8W3LdsYLaZO2sxu8XZvJ7sDm8fshossHjvuLmH0mDfrBIvHzll32T1eHVjF7nH2zg7G
 ALYoLpuU1JzMstQifbsErowlzY+ZCpaJVhx+foypgfGBSBcjJ4eEgInE1X197CC2kMASJomm
 +1xdjFxA9j1GiS/LtrFCOOsZJU5MeM8MUsUmoCax681rVhBbRKBC4tCuK0wgRcwCOxkl3m7t
 ZQRJCAukSny4socNoihN4uSHmUBxDiDbSGLWW3eQMIuAisTP//PYQcK8AjYS+3cWgphCQAf9
 XQk2nVPAVOL1wT9gAxkFZCU2bDgPdgGzgLjEpmffWSHuF5BYsgciLiEgKvHy8T+ouLzEiVvT
 mEBGMgtoSqzfpQ/RaiFxYVUvE4StKDGl+yHY67wCghInZz5hmcAoPgvJhlkI3bOQdM9C0j0L
 SfcCRtZVjEK5mcnZqUWZ2XoFGZUlqcl6KambGEERK8LAtYOxb47HIUYmDsZDjBIczEoivM3h
 m9KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ867uCE4VEkhPLEnNTk0tSC2CyTJxcEo1MDZdOOfH
 /LjK42GDrb5RKzOLR4G36ZlNjAt2t926IOmj9jLm9JHoL2d0Hj7uC59S9sHeTyBt+8EDapsc
 J9gKnDJectbwPJ+c8a6Dgcl32FbOPu3+UkBGj1lmwwM5b4H/T+MmzuhiT/6loJFlmTYnI6L7
 Da/cljBuC44H5fNZglmOJk2WqXq6XYmlOCPRUIu5qDgRABn0CD3GAgAA
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

SGkgTHVrYXN6LA0KDQpPbiAwNi4wOC4yNCAxMDoxMSwgTHVrYXN6IE1hamV3c2tpIHdyb3RlOg0K
PiBUaGlzIGNvbW1hbmQgYWxsb3dzIGVhc3kgdXBkYXRlIG9uIFNEIGNhcmQgb3IgZU1NQyBvZiB0
aGUgZmxhc2guYmluDQo+IGdlbmVyYXRlZCAod2l0aCBiaW5tYW4pIGR1cmluZyB1LWJvb3QgYnVp
bGQuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEx1a2FzeiBNYWpld3NraSA8bHVrbWFAZGVueC5kZT4N
Cj4gLS0tDQo+IENoYW5nZXMgZm9yIHYyOg0KPiAtIFJlbW92ZSAndXBkYXRlX21tY19wYXJ0JyB2
YXJpYWJsZQ0KPiAtIENoYW5nZSBwYXRoIGZvciBob3N0bmFtZQ0KPiAtIFVzZSBmdWxsIHZlcnNp
b24gb2YgZGhjcCBjb21tYW5kICgke2xvYWRhZGRyfSBhZGRlZCkNCj4NCj4gQ2hhbmdlcyBmb3Ig
djM6DQo+IC0gUmVtb3ZlICsxIHdoZW4gY2FsY3VsYXRpbmcgdGhlIHNpemUgb2YgYmluYXJ5IHRv
IGJlIHdyaXR0ZW4NCj4gLS0tDQo+ICAgaW5jbHVkZS9jb25maWdzL3BoeWNvcmVfaW14OG1tLmgg
fCAxMCArKysrKysrKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4N
Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvY29uZmlncy9waHljb3JlX2lteDhtbS5oIGIvaW5jbHVk
ZS9jb25maWdzL3BoeWNvcmVfaW14OG1tLmgNCj4gaW5kZXggY2U2ZGM4N2M2OS4uMzYxZTY2NTY3
NiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9jb25maWdzL3BoeWNvcmVfaW14OG1tLmgNCj4gKysr
IGIvaW5jbHVkZS9jb25maWdzL3BoeWNvcmVfaW14OG1tLmgNCj4gQEAgLTI5LDYgKzI5LDE2IEBA
DQo+ICAgCSJtbWNkZXY9IiBfX3N0cmluZ2lmeShDT05GSUdfU1lTX01NQ19FTlZfREVWKSAiXDAi
IFwNCj4gICAJIm1tY3BhcnQ9MVwwIiBcDQo+ICAgCSJtbWNyb290PTJcMCIgXA0KPiArCSJ1cGRh
dGVfb2Zmc2V0PTB4NDJcMCIgXA0KPiArCSJ1cGRhdGVfZmlsZW5hbWU9Zmxhc2guYmluXDAiIFwN
Cj4gKwkiaG9zdG5hbWU9L3Nydi90ZnRwL1wwIiBcDQo+ICsJInVwZGF0ZV9ib290aW1nPSIJCQkJ
CQlcDQo+ICsJCSJtbWMgZGV2ICR7bW1jZGV2fSA7ICIJCVwNCj4gKwkJImlmIGRoY3AgJHtsb2Fk
YWRkcn0gJHtob3N0bmFtZX0vJHt1cGRhdGVfZmlsZW5hbWV9IDsgdGhlbiAiCVwNCg0KVGhlIGRo
Y3AgYW5kIHRmdHAgY29tbWFuZCBzaG91bGQgdGFrZSB0aGUgZmlsZXBhdGggZnJvbSB0aGUgdGZ0
cCANCmRpcmVjdG9yeSBhbmQgZ2V0IHRoZSB0ZnRwIGRpcmVjdG9yeSBhdXRvbWF0aWNhbGx5IG5v
dCB0aGUgYWJzb2x1dGUgcGF0aC4NClNvIHRoaXMgd2lsbCB0cnkgdG8gZ2V0IHRoZSBmaWxlIGZy
b20gDQovcGF0aF90b190ZnRwX2ZvbGRlci9zcnYvdGZ0cC9mbGFzaC5iaW4gYW5kIHdpbGwgZmFp
bCBiZWNhdXNlIGl0IGNhbid0IA0KZmluZCBpdC4gU28geW91IGNhbiBkcm9wIHRoZSAke2hvc3Ru
YW1lfS4NCkFsc28gZHJvcCB0aGUgaW5pdGlhbGl6YXRpb24gb2YgJHtob3N0bmFtZX0gYWJvdmUg
c2luY2UgaXQgaXMgbm8gbG9uZ2VyIA0KbmVlZGVkLg0KDQpTaG91bGQgYmUgbGlrZSB0aGlzOg0K
DQpkaGNwICR7bG9hZGFkZHJ9ICR7dXBkYXRlX2ZpbGVuYW1lfQ0KDQo+ICsJCSJzZXRleHByIGZ3
X3N6ICR7ZmlsZXNpemV9IC8gMHgyMDAgOyAiCS8qIFNEIGJsb2NrIHNpemUgKi8gXA0KPiArCQki
c2V0ZXhwciBmd19zeiAke2Z3X3N6fSA7ICINCkkgdGhpbmsgeW91IGNhbiBkcm9wIHRoaXMgbGlu
ZSBzaW5jZSBpdCBkb2VzIG5vdCBkbyBhbnl0aGluZy4NCg0KQmVuamFtaW4NCj4gCQkJCVwNCj4g
KwkJIm1tYyB3cml0ZSAke2xvYWRhZGRyfSAke3VwZGF0ZV9vZmZzZXR9ICR7Zndfc3p9IDsgIglc
DQo+ICsJCSJmaVwwIiBcDQo+ICAgCSJtbWNhdXRvZGV0ZWN0PXllc1wwIiBcDQo+ICAgCSJtbWNh
cmdzPXNldGVudiBib290YXJncyBjb25zb2xlPSR7Y29uc29sZX0gIiBcDQo+ICAgCQkicm9vdD0v
ZGV2L21tY2JsayR7bW1jZGV2fXAke21tY3Jvb3R9IHJvb3R3YWl0IHJ3XDAiIFwNCg0KDQo=
