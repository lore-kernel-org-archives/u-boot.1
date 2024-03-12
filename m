Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B671C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 14:14:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E464087F16;
	Tue, 12 Mar 2024 15:14:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="jM0RMmiE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6B7787F4E; Tue, 12 Mar 2024 15:14:29 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5FE887DE3
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 15:14:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=T.Remmet@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1710252867; x=1712844867;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZRMTLJeGTWLvj3afD2TDY6h0IDF7WLX1LifkUuRMqfg=;
 b=jM0RMmiEMZ2iesHzJ+ZYg/ZOYqZEJUo6e1sArg4BcTEKeIf4UvLGCN5Dl18c2tnG
 35A2SjwTrkt/m5ivcKLWgcHUWAgr9K8D2O3kcTuPA6r/nf2AT10B8/1GjYhnWhAg
 qfaGFicm6YQ64R01iWwag442K6flhbqau9CRZ2aJT1E=;
X-AuditID: ac14000a-fbefe7000000290d-f4-65f06343128a
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id C0.F9.10509.34360F56;
 Tue, 12 Mar 2024 15:14:27 +0100 (CET)
Received: from Berlix.phytec.de (172.25.0.12) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 12 Mar
 2024 15:14:27 +0100
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Tue, 12 Mar 2024 15:14:27 +0100
From: Teresa Remmet <T.Remmet@phytec.de>
To: "festevam@gmail.com" <festevam@gmail.com>, Leonard Anderweit
 <L.Anderweit@phytec.de>, "trini@konsulko.com" <trini@konsulko.com>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 2/5] phycore_imx8mp: Move default bootcmd to board env
Thread-Topic: [PATCH v2 2/5] phycore_imx8mp: Move default bootcmd to board env
Thread-Index: AQHadFuuzi8jl7siukakRkQyuhsrMbE0FbIA
Date: Tue, 12 Mar 2024 14:14:27 +0000
Message-ID: <e2f1def28436a8323c83ba60a23a01ab448a9aac.camel@phytec.de>
References: <20240312085957.902398-1-l.anderweit@phytec.de>
 <20240312085957.902398-3-l.anderweit@phytec.de>
In-Reply-To: <20240312085957.902398-3-l.anderweit@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A4AC6883B43ED47B5007B81ECFDA2FF@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWyRpKBV9c5+UOqQcNfFYuHV/0tpk7azG7x
 dm8nu0X3O3UHFo+ds+6ye7w6sIrd4+ydHYwe/d0trAEsUVw2Kak5mWWpRfp2CVwZG9sNCnok
 Ki6vmMbSwLhHvIuRk0NCwETi1Ir/zF2MXBxCAouZJH6v388K4dxnlHi0bCmUs4FR4srkXWwg
 LWwCGhIvT3QzgSREBFoZJfY+fsoCkmAWyJL4f3EWWJGwgK/Enf9tQDYHUJGfxIEPjCBhEQEj
 iW8r9rOD2CwCqhJz//8Ca+UVcJOYdeIemC0kkCfR+nwvM4jNKWAjcfz+fDCbUUBWYsOG88wQ
 q8QlNj37zgrxgoDEkj0QcQkBUYmXj/9BxeUlTtyaxgRyArOApsT6XfoQrRYSm5YthrpYUWJK
 90N2iBMEJU7OfMIygVF8FpINsxC6ZyHpnoWkexaS7gWMrKsYhXIzk7NTizKz9QoyKktSk/VS
 UjcxgmJRhIFrB2PfHI9DjEwcjIcYJTiYlUR4X+u8TRXiTUmsrEotyo8vKs1JLT7EKM3BoiTO
 u7ojOFVIID2xJDU7NbUgtQgmy8TBKdXAyLkurGdBw9IT9jImf1/YMvl3vuT+8q8xreXkkvT1
 yxp1i8/MaKrc8eNslmPLNu+0R+c7ahlm/ElpfGGucuDMzLbYGbfcbj4yTCzRX2h6b83aJ3HH
 fTTNHfsaYxwZUktSWUvWz74+cfbyN0k7FvHePmWmsMpAkG2iwLO+5KX/zFc3a/V5+4UmKLEU
 ZyQaajEXFScCAOrEtzWzAgAA
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

QW0gRGllbnN0YWcsIGRlbSAxMi4wMy4yMDI0IHVtIDA5OjU5ICswMTAwIHNjaHJpZWIgTGVvbmFy
ZCBBbmRlcndlaXQ6DQo+IE1vdmUgdGhlIGRlZmF1bHQgYm9vdGNtZCBmcm9tIHRoZSBkZWZjb25m
aWcgdG8gdGhlIGJvYXJkIGVudmlyb25tZW50Lg0KPiBObyBjaGFuZ2UgaW4gZnVuY3Rpb25hbGl0
eS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExlb25hcmQgQW5kZXJ3ZWl0IDxsLmFuZGVyd2VpdEBw
aHl0ZWMuZGU+DQoNClRlc3RlZC1ieTogVGVyZXNhIFJlbW1ldCA8dC5yZW1tZXRAcGh5dGVjLmRl
Pg0KDQo+IC0tLQ0KPiDCoGJvYXJkL3BoeXRlYy9waHljb3JlX2lteDhtcC9waHljb3JlX2lteDht
cC5lbnYgfCAxMiArKysrKysrKysrKysNCj4gwqBjb25maWdzL3BoeWNvcmUtaW14OG1wX2RlZmNv
bmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIgLS0NCj4gwqAyIGZpbGVzIGNo
YW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1wL3BoeWNvcmVfaW14OG1wLmVudg0KPiBiL2Jv
YXJkL3BoeXRlYy9waHljb3JlX2lteDhtcC9waHljb3JlX2lteDhtcC5lbnYNCj4gaW5kZXggNmQx
NWI3ZjNkYzlmLi43MzIwMmMzYjEyOWEgMTAwNjQ0DQo+IC0tLSBhL2JvYXJkL3BoeXRlYy9waHlj
b3JlX2lteDhtcC9waHljb3JlX2lteDhtcC5lbnYNCj4gKysrIGIvYm9hcmQvcGh5dGVjL3BoeWNv
cmVfaW14OG1wL3BoeWNvcmVfaW14OG1wLmVudg0KPiBAQCAtMSwzICsxLDE1IEBADQo+ICtib290
Y21kPQ0KPiArwqDCoMKgwqDCoMKgwqBpZiB0ZXN0ICR7ZG9mYXN0Ym9vdH0gPSAxOyB0aGVuDQo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmYXN0Ym9vdCAwOw0KPiArwqDCoMKgwqDC
oMKgwqBmaTsNCj4gK8KgwqDCoMKgwqDCoMKgbW1jIGRldiAke21tY2Rldn07DQo+ICvCoMKgwqDC
oMKgwqDCoGlmIG1tYyByZXNjYW47IHRoZW4NCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGlmIHJ1biBsb2FkaW1hZ2U7IHRoZW4NCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBydW4gbW1jYm9vdDsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGVsc2UNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBydW4gbmV0Ym9vdDsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZp
Ow0KPiArwqDCoMKgwqDCoMKgwqBmaTsNCj4gwqBjb25zb2xlPXR0eW14YzAsMTE1MjAwDQo+IMKg
ZG9mYXN0Ym9vdD0wDQo+IMKgZW1tY19kZXY9Mg0KPiBkaWZmIC0tZ2l0IGEvY29uZmlncy9waHlj
b3JlLWlteDhtcF9kZWZjb25maWcgYi9jb25maWdzL3BoeWNvcmUtDQo+IGlteDhtcF9kZWZjb25m
aWcNCj4gaW5kZXggYjNhN2JiZDc5YmI2Li5mZDQ5MmViYTNjMTAgMTAwNjQ0DQo+IC0tLSBhL2Nv
bmZpZ3MvcGh5Y29yZS1pbXg4bXBfZGVmY29uZmlnDQo+ICsrKyBiL2NvbmZpZ3MvcGh5Y29yZS1p
bXg4bXBfZGVmY29uZmlnDQo+IEBAIC0yNSw4ICsyNSw2IEBAIENPTkZJR19GSVQ9eQ0KPiDCoENP
TkZJR19GSVRfRVhURVJOQUxfT0ZGU0VUPTB4MzAwMA0KPiDCoENPTkZJR19TUExfTE9BRF9GSVQ9
eQ0KPiDCoENPTkZJR19PRl9TWVNURU1fU0VUVVA9eQ0KPiAtQ09ORklHX1VTRV9CT09UQ09NTUFO
RD15DQo+IC1DT05GSUdfQk9PVENPTU1BTkQ9ImlmIHRlc3QgJHtkb2Zhc3Rib290fSA9IDE7IHRo
ZW4gZmFzdGJvb3QgMDsgZmk7DQo+IG1tYyBkZXYgJHttbWNkZXZ9OyBpZiBtbWMgcmVzY2FuOyB0
aGVuIGlmIHJ1biBsb2FkaW1hZ2U7IHRoZW4gcnVuDQo+IG1tY2Jvb3Q7IGVsc2UgcnVuIG5ldGJv
b3Q7IGZpOyBmaTsiDQo+IMKgQ09ORklHX0RFRkFVTFRfRkRUX0ZJTEU9Im9mdHJlZSINCj4gwqBD
T05GSUdfU1lTX0NCU0laRT0yMDQ4DQo+IMKgQ09ORklHX1NZU19QQlNJWkU9MjA3NA0KDQotLSAN
ClBIWVRFQyBNZXNzdGVjaG5payBHbWJIIHwgQmFyY2Vsb25hLUFsbGVlIDEgfCA1NTEyOSBNYWlu
eiwgR2VybWFueQ0KDQpHZXNjaMOkZnRzZsO8aHJlcjogRGlwbC4tSW5nLiBNaWNoYWVsIE1pdGV6
a2ksIERpcGwuLUluZy4gQm9kbyBIdWJlciwNCkRpcGwuLUluZy4gKEZIKSBNYXJrdXMgTGlja2Vz
IHwgSGFuZGVsc3JlZ2lzdGVyIE1haW56IEhSQiA0NjU2IHwNCkZpbmFuemFtdCBNYWlueiB8IFN0
Lk5yLiAyNjY1MDA2MDgsIERFIDE0OTA1OTg1NQ0K
