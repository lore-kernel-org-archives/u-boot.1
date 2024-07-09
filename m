Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C85C2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 06:49:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88AAE88370;
	Tue,  9 Jul 2024 08:49:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="lPLDi1oN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C97A87B30; Tue,  9 Jul 2024 08:49:53 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F8B987B30
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 08:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1720507791; x=1723099791;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ckHN9VIEMaistiITaUBZ5OmWR+WYk/vKWfs8knZsNPQ=;
 b=lPLDi1oNI2ODxEseDkegbegq2lVMs43mezzC7nJH7cowx46/mfc8mwHpmifJ6LJd
 J+niV3EqkoLpjrUYSkm3TF0eGWdYP3nVwxejJ7W4ciTy0SqoJ99yx+xfkatWctEE
 yCHC8S/TkYhtREbeiV3MwMmboywCSX2vzR0BX+3rMxM=;
X-AuditID: ac14000a-03e52700000021bc-3e-668cdd8e9568
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id C0.F6.08636.E8DDC866;
 Tue,  9 Jul 2024 08:49:51 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 9 Jul 2024
 08:49:50 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Tue, 9 Jul 2024 08:49:50 +0200
From: Yannic Moog <Y.Moog@phytec.de>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Daniel Schultz
 <D.Schultz@phytec.de>, "joe.hershberger@ni.com" <joe.hershberger@ni.com>,
 "trini@konsulko.com" <trini@konsulko.com>, Wadim Egorov <W.Egorov@phytec.de>
CC: "kamlesh@ti.com" <kamlesh@ti.com>, "d-gole@ti.com" <d-gole@ti.com>,
 Benjamin Hahn <B.Hahn@phytec.de>, "m-chawdhry@ti.com" <m-chawdhry@ti.com>,
 "mkorpershoek@baylibre.com" <mkorpershoek@baylibre.com>, "jm@ti.com"
 <jm@ti.com>, PHYTEC Upstream <upstream@lists.phytec.de>, "nm@ti.com"
 <nm@ti.com>, Teresa Remmet <T.Remmet@phytec.de>
Subject: Re: [PATCH 1/6] include: env: phytec: overlays: Add extension command
Thread-Topic: [PATCH 1/6] include: env: phytec: overlays: Add extension command
Thread-Index: AQHa0P0rcHVTUT8xk0mk9dSCmXMhhLHt1OIA
Date: Tue, 9 Jul 2024 06:49:50 +0000
Message-ID: <510c99dfff5e17768df3fde691d96d848e288583.camel@phytec.de>
References: <20240708060734.4029040-1-d.schultz@phytec.de>
 <20240708060734.4029040-2-d.schultz@phytec.de>
In-Reply-To: <20240708060734.4029040-2-d.schultz@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E2B73CC54E8454FAFC3495638E93F7F@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsWyRpKBR7f/bk+awblci5a1HhafPmRafNr5
 mNXiaP8aZotLD1ItXhyby27x5sdZJoupkzazW7zd28lu0f1O3YHL4/2NVnaPVwdWsXucvbOD
 0aO/u4XV4/qZ7Uwex29sZwpgi+KySUnNySxLLdK3S+DKmPS8k7lghnDFqbkKDYw3hLoYOTkk
 BEwk/i79zt7FyMUhJLCESeL7uUYWCOceo8T11pVQmfWMErP2PmEFaWETUJE4OeMSI0hCROAO
 o8SU1i9gDrPAFSaJj41NTCBVwgJ+EtPufGHuYuQAqgqUaH7uABIWETCSuHlhPjOIzQI0aNv0
 Q2DlvAJuElOf/2MHsYUEciT6zqwEa+UUsJY4eyQXJMwoICuxYcN5sFZmAXGJTc++s0K8ICCx
 ZA9EXEJAVOLl439QcXmJE7emMYGMYRbQlFi/Sx+i1ULiS1sb1BhFiSndD9khLhCUODnzCcsE
 RvFZSDbMQuiehaR7FpLuWUi6FzCyrmIUys1Mzk4tyszWK8ioLElN1ktJ3cQIimoRBq4djH1z
 PA4xMnEwHmKU4GBWEuGdf6M7TYg3JbGyKrUoP76oNCe1+BCjNAeLkjjv6o7gVCGB9MSS1OzU
 1ILUIpgsEwenVAOjqaz4jSdGmhcsLvr//cZftO2cU4uJzi/rfTtkPr8xUTr0/trktpcfftUy
 2LDeOb3PwcH4iNvT/hZt0dDcM/v/lS1znfHjlcpHRbfq9buc9jm9ebRAJk83o03igOzCZU+/
 MU3TLYuLO3CFxTM89LnTSbUJYQa7NgnW9B/ZvvXDlfsvCz7/tezzU2Ipzkg01GIuKk4EAMvY
 T6LYAgAA
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

SGVsbG8gRGFuaWVsLA0KDQpPbiBTdW4sIDIwMjQtMDctMDcgYXQgMjM6MDcgLTA3MDAsIERhbmll
bCBTY2h1bHR6IHdyb3RlOg0KPiBBZGQgYSBuZXcgZW52aXJvbm1lbnQgcm91dGluZSB0byBhcHBs
eSBleHRlbnNpb25zLiBPdXIgU09NIGRldGVjdGlvbg0KPiBhZGRzIG92ZXJsYXlzIHZpYSB0aGUg
ZXh0ZW5zaW9uIGZyYW1ld29yayB0byBhbHRlciB0aGUga2VybmVsDQo+IGRldmljZS10cmVlIGFj
Y29yZGluZyB0byB0aGUgZmxhc2hlZCBFRVBST00gaW1hZ2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBEYW5pZWwgU2NodWx0eiA8ZC5zY2h1bHR6QHBoeXRlYy5kZT4NCj4gLS0tDQo+IMKgaW5jbHVk
ZS9lbnYvcGh5dGVjL292ZXJsYXlzLmVudiB8IDIwICsrKysrKysrKysrKysrKysrKysrDQo+IMKg
MSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2Vudi9waHl0ZWMvb3ZlcmxheXMuZW52IGIvaW5jbHVkZS9lbnYvcGh5dGVjL292ZXJsYXlz
LmVudg0KPiBpbmRleCA3ODcyMWNkZTY1NC4uNTAxMTBlNzMxYmQgMTAwNjQ0DQo+IC0tLSBhL2lu
Y2x1ZGUvZW52L3BoeXRlYy9vdmVybGF5cy5lbnYNCj4gKysrIGIvaW5jbHVkZS9lbnYvcGh5dGVj
L292ZXJsYXlzLmVudg0KPiBAQCAtMjMsNiArMjMsMTYgQEAgbW1jX2FwcGx5X292ZXJsYXlzPQ0K
PiDCoAkJCWZpOw0KPiDCoAkJZG9uZTsNCj4gwqAJZmk7DQo+ICsjaWZkZWYgQ09ORklHX0NNRF9F
WFRFTlNJT04NCj4gK21tY19hcHBseV9leHRlbnNpb25zPQ0KPiArCXNldGVudiBleHRlbnNpb25f
b3ZlcmxheV9hZGRyICR7ZmR0b3ZlcmxheV9hZGRyX3J9Ow0KPiArCXNldGVudiBleHRlbnNpb25f
b3ZlcmxheV9jbWQgJ2xvYWQgbW1jICR7bW1jZGV2fToke21tY3BhcnR9DQo+ICsJwqAgJHtmZHRv
dmVybGF5X2FkZHJfcn0gJHtleHRlbnNpb25fb3ZlcmxheV9uYW1lfSc7DQo+ICsJZXh0ZW5zaW9u
IHNjYW47DQo+ICsJZXh0ZW5zaW9uIGFwcGx5IGFsbDsNCj4gKyNlbHNlDQo+ICttbWNfYXBwbHlf
ZXh0ZW5zaW9ucz1lY2hvICJubyBleHRlbnNpb24gY29tbWFuZCINCg0KRG8geW91IHRoaW5rIGl0
IG1ha2VzIHNlbnNlIHRvIG1ha2UgdGhpcyBmYWlsPyBJIHdvdWxkIHRoaW5rICJhcHBseV9leHRl
bnNpb25zIiB3b3VsZCBiZQ0KdW5zdWNjZXNzZnVsIGlmIGV4dGVuc2lvbnMgYXJlIG5vdCB3b3Jr
aW5nLg0KDQpZYW5uaWMNCg0KPiArI2VuZGlmDQo+IMKgbmV0X2xvYWRfYm9vdGVudj0ke2dldF9j
bWR9ICR7Ym9vdGVudl9hZGRyX3J9ICR7Ym9vdGVudn0NCj4gwqBuZXRfbG9hZF9vdmVybGF5PSR7
Z2V0X2NtZH0gJHtmZHRvdmVybGF5X2FkZHJfcn0gJHtvdmVybGF5fQ0KPiDCoG5ldF9hcHBseV9v
dmVybGF5cz0NCj4gQEAgLTM2LDMgKzQ2LDEzIEBAIG5ldF9hcHBseV9vdmVybGF5cz0NCj4gwqAJ
CQlmaTsNCj4gwqAJCWRvbmU7DQo+IMKgCWZpOw0KPiArI2lmZGVmIENPTkZJR19DTURfRVhURU5T
SU9ODQo+ICtuZXRfYXBwbHlfZXh0ZW5zaW9ucz0NCj4gKwlzZXRlbnYgZXh0ZW5zaW9uX292ZXJs
YXlfYWRkciAke2ZkdG92ZXJsYXlfYWRkcl9yfTsNCj4gKwlzZXRlbnYgZXh0ZW5zaW9uX292ZXJs
YXlfY21kICcke2dldF9jbWR9ICR7ZmR0b3ZlcmxheV9hZGRyX3J9DQo+ICsJICR7ZXh0ZW5zaW9u
X292ZXJsYXlfbmFtZX0nOw0KPiArCWV4dGVuc2lvbiBzY2FuOw0KPiArCWV4dGVuc2lvbiBhcHBs
eSBhbGw7DQo+ICsjZWxzZQ0KPiArbmV0X2FwcGx5X2V4dGVuc2lvbnM9ZWNobyAibm8gZXh0ZW5z
aW9uIGNvbW1hbmQiDQo+ICsjZW5kaWYNCg0K
