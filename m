Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D196C38150
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 05:38:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BAD8886EB;
	Wed, 10 Jul 2024 07:38:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="qWt7E/N4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77AE5886F0; Wed, 10 Jul 2024 07:38:22 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D85F88657
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 07:38:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1720589900; x=1723181900;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0BBCq+8gFKOwrQR1rNy068ckVsdGoURBw0epETfGa2c=;
 b=qWt7E/N4P+3qImXQJbnu+K/ianIAtu1RzWJalqYL2BaOSRbUj3YZlVqst2knTjU2
 21w8P7WX7+muFNyuifidXudABWIWb9f39Xl5/BTcmXakZqWVa9tWm+EzPSN5z3ff
 rKfOrF97Dd9WGloFj19y/15L2DMH2Bm7HZk5cZCbTpk=;
X-AuditID: ac14000a-03251700000021bc-48-668e1e4cc25f
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 37.9D.08636.C4E1E866;
 Wed, 10 Jul 2024 07:38:20 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 10 Jul
 2024 07:38:19 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Wed, 10 Jul 2024 07:38:19 +0200
From: Yannic Moog <Y.Moog@phytec.de>
To: Wadim Egorov <W.Egorov@phytec.de>, Daniel Schultz <D.Schultz@phytec.de>,
 "joe.hershberger@ni.com" <joe.hershberger@ni.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "trini@konsulko.com" <trini@konsulko.com>
CC: "kamlesh@ti.com" <kamlesh@ti.com>, "d-gole@ti.com" <d-gole@ti.com>,
 Benjamin Hahn <B.Hahn@phytec.de>, "m-chawdhry@ti.com" <m-chawdhry@ti.com>,
 "mkorpershoek@baylibre.com" <mkorpershoek@baylibre.com>, "jm@ti.com"
 <jm@ti.com>, PHYTEC Upstream <upstream@lists.phytec.de>, "nm@ti.com"
 <nm@ti.com>, Teresa Remmet <T.Remmet@phytec.de>
Subject: Re: [PATCH 1/6] include: env: phytec: overlays: Add extension command
Thread-Topic: [PATCH 1/6] include: env: phytec: overlays: Add extension command
Thread-Index: AQHa0P0rcHVTUT8xk0mk9dSCmXMhhLHt1OIAgABwUQCAAARrgIABCZ2A
Date: Wed, 10 Jul 2024 05:38:19 +0000
Message-ID: <083880b0637806fbbcff5305aceddf354426e282.camel@phytec.de>
References: <20240708060734.4029040-1-d.schultz@phytec.de>
 <20240708060734.4029040-2-d.schultz@phytec.de>
 <510c99dfff5e17768df3fde691d96d848e288583.camel@phytec.de>
 <d5790f87-e4d4-4ac8-9858-2bb199f195ef@phytec.de>
 <f5f4b384-1a81-4e0f-b1aa-931db73cd251@phytec.de>
In-Reply-To: <f5f4b384-1a81-4e0f-b1aa-931db73cd251@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <782D3833A709B54A9EB06A8523B79F93@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsWyRpKBR9dHri/NYN5/ZouWtR4Wnz5kWnza
 +ZjV4mj/GmaLSw9SLV4cm8tu8ebHWSaLqZM2s1u83dvJbtH9Tt2By+P9jVZ2j1cHVrF7nL2z
 g9Gjv7uF1eP6me1MHsdvbGcKYIvisklJzcksSy3St0vgyth9YiFzwSS1inO7rrE2ME5R7WLk
 5JAQMJHY23SRuYuRi0NIYAmTROvO66wQzn1GiZ+HFjFBOBsYJY50nmUEaWETUJE4OeMSI0hC
 ROAOo8S748/ZQBxmgStMEh8bm5hAqoQF/CSm3fkCNJgDqCpQovm5A0hYRMBN4vHOpWwgNouA
 qsShn5PBbF6g+JUD79khtk1ikmhu2cAKkuAUsJXYMn8HWBGjgKzEhg3nmUFsZgFxiU3PvrNC
 PCEgsWQPRFxCQFTi5eN/UHF5iRO3pjGB3MAsoCmxfpc+RKuFRNv8p+wQtqLElO6H7BA3CEqc
 nPmEZQKj+CwkG2YhdM9C0j0LSfcsJN0LGFlXMQrlZiZnpxZlZusVZFSWpCbrpaRuYgRFtwgD
 1w7GvjkehxiZOBgPMUpwMCuJ8M6/0Z0mxJuSWFmVWpQfX1Sak1p8iFGag0VJnHd1R3CqkEB6
 YklqdmpqQWoRTJaJg1OqgTFOJnmSjvI+lpnKfDLh93R0OrhuHJm2r4bbw3UhA/+L/K0t6utr
 1ts0NcU1le7zWh7PddB6vsjpWkmv+125bi9Mtt16q8x0i/34OVfT9HVHTJKvb/1zQWcKRypj
 67k28WVvDVwWLeuQmvj9oe5h3R95k2PP7lz73P4956zm/Pl7Il+1+xwrW63EUpyRaKjFXFSc
 CAARZc9A3AIAAA==
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

T24gVHVlLCAyMDI0LTA3LTA5IGF0IDE1OjQ3ICswMjAwLCBXYWRpbSBFZ29yb3Ygd3JvdGU6DQo+
IA0KPiANCj4gQW0gMDkuMDcuMjQgdW0gMTU6MzEgc2NocmllYiBEYW5pZWwgU2NodWx0ejoNCj4g
PiBIaSBZYW5uaWMsDQo+ID4gDQo+ID4gT24gMDkuMDcuMjQgMDg6NDksIFlhbm5pYyBNb29nIHdy
b3RlOg0KPiA+ID4gSGVsbG8gRGFuaWVsLA0KPiA+ID4gDQo+ID4gPiBPbiBTdW4sIDIwMjQtMDct
MDcgYXQgMjM6MDcgLTA3MDAsIERhbmllbCBTY2h1bHR6IHdyb3RlOg0KPiA+ID4gPiBBZGQgYSBu
ZXcgZW52aXJvbm1lbnQgcm91dGluZSB0byBhcHBseSBleHRlbnNpb25zLiBPdXIgU09NIGRldGVj
dGlvbg0KPiA+ID4gPiBhZGRzIG92ZXJsYXlzIHZpYSB0aGUgZXh0ZW5zaW9uIGZyYW1ld29yayB0
byBhbHRlciB0aGUga2VybmVsDQo+ID4gPiA+IGRldmljZS10cmVlIGFjY29yZGluZyB0byB0aGUg
Zmxhc2hlZCBFRVBST00gaW1hZ2UuDQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBE
YW5pZWwgU2NodWx0eiA8ZC5zY2h1bHR6QHBoeXRlYy5kZT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+
IMKgwqBpbmNsdWRlL2Vudi9waHl0ZWMvb3ZlcmxheXMuZW52IHwgMjAgKysrKysrKysrKysrKysr
KysrKysNCj4gPiA+ID4gwqDCoDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspDQo+ID4g
PiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9lbnYvcGh5dGVjL292ZXJsYXlzLmVu
diANCj4gPiA+ID4gYi9pbmNsdWRlL2Vudi9waHl0ZWMvb3ZlcmxheXMuZW52DQo+ID4gPiA+IGlu
ZGV4IDc4NzIxY2RlNjU0Li41MDExMGU3MzFiZCAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvaW5jbHVk
ZS9lbnYvcGh5dGVjL292ZXJsYXlzLmVudg0KPiA+ID4gPiArKysgYi9pbmNsdWRlL2Vudi9waHl0
ZWMvb3ZlcmxheXMuZW52DQo+ID4gPiA+IEBAIC0yMyw2ICsyMywxNiBAQCBtbWNfYXBwbHlfb3Zl
cmxheXM9DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZpOw0KPiA+ID4gPiDC
oMKgwqDCoMKgwqDCoMKgwqAgZG9uZTsNCj4gPiA+ID4gwqDCoMKgwqDCoCBmaTsNCj4gPiA+ID4g
KyNpZmRlZiBDT05GSUdfQ01EX0VYVEVOU0lPTg0KPiA+ID4gPiArbW1jX2FwcGx5X2V4dGVuc2lv
bnM9DQo+ID4gPiA+ICvCoMKgwqAgc2V0ZW52IGV4dGVuc2lvbl9vdmVybGF5X2FkZHIgJHtmZHRv
dmVybGF5X2FkZHJfcn07DQo+ID4gPiA+ICvCoMKgwqAgc2V0ZW52IGV4dGVuc2lvbl9vdmVybGF5
X2NtZCAnbG9hZCBtbWMgJHttbWNkZXZ9OiR7bW1jcGFydH0NCj4gPiA+ID4gK8KgwqDCoCDCoCAk
e2ZkdG92ZXJsYXlfYWRkcl9yfSAke2V4dGVuc2lvbl9vdmVybGF5X25hbWV9JzsNCj4gPiA+ID4g
K8KgwqDCoCBleHRlbnNpb24gc2NhbjsNCj4gPiA+ID4gK8KgwqDCoCBleHRlbnNpb24gYXBwbHkg
YWxsOw0KPiA+ID4gPiArI2Vsc2UNCj4gPiA+ID4gK21tY19hcHBseV9leHRlbnNpb25zPWVjaG8g
Im5vIGV4dGVuc2lvbiBjb21tYW5kIg0KPiA+ID4gRG8geW91IHRoaW5rIGl0IG1ha2VzIHNlbnNl
IHRvIG1ha2UgdGhpcyBmYWlsPyBJIHdvdWxkIHRoaW5rIA0KPiA+ID4gImFwcGx5X2V4dGVuc2lv
bnMiIHdvdWxkIGJlDQo+ID4gPiB1bnN1Y2Nlc3NmdWwgaWYgZXh0ZW5zaW9ucyBhcmUgbm90IHdv
cmtpbmcuDQo+ID4gDQo+ID4gVGVjaG5pY2FsbHksIHlvdSBkb24ndCBuZWVkIG91ciBTT00gZGV0
ZWN0aW9uIG92ZXJsYXlzLiBUaGV5IGp1c3QgbWFrZSANCj4gPiB0aGUgYm9vdCBuaWNlciBhbmQg
eW91IGRvbid0IGhhdmUgYW55IHByb2JlIGVycm9ycyBvciBvdGhlciBlcnJvciANCj4gPiBtZXNz
YWdlcy4gU28sIGluIG15IG9waW5pb24sIGl0J3MgYmV0dGVyIG5vdCBhcHBseSB0aGVtIGluc3Rl
YWQgb2YgDQo+ID4gc3RvcHBpbmcgdGhlIGVudGlyZSBib290Lg0KPiANCj4gTXkgcmVjb21tZW5k
YXRpb24gaXMgdG8gZW1iZWQgYWxsIFNvTSB2YXJpYW50IHJlbGF0ZWQgb3ZlcmxheXMgaW50byAN
Cj4gdS1ib290LmltZydzIEZJVCB1c2luZyBiaW5tYW4uDQoNCkRpZG4ndCB0aGluayBiaW5tYW4g
d291bGQgYmUgdXNlZCBmb3IgdGhhdCwgYnV0IEkgc2hhcmUgeW91ciBvcGluaW9uIHJlZ2FyZGlu
ZyBvdmVybGF5IHBhY2thZ2luZy4NCg0KWWFubmljDQoNCj4gDQo+IFRoaXMgbWFrZXMgdGhlIGV4
dGVuc2lvbiBjb21tYW5kIG9ic29sZXRlLCBhbmQgZXNwZWNpYWxseSB0aGUgaGFuZGxpbmcgDQo+
IGZvciBsb2FkaW5nIG9mIG92ZXJsYXlzIGZyb20gZGlmZmVyZW50IGJvb3Qgc291cmNlcyAvIHN0
b3JhZ2UgZGV2aWNlcy4NCj4gDQo+IEhhdmluZyB0aGVtIGF2YWlsYWJsZSBkaXJlY3RseSBpbiB0
aGUgdS1ib290IGJpbmFyeSByZXNvbHZlcyB0aGUgaXNzdWUgDQo+IG9mIG5vdCBmb3VuZCBvdmVy
bGF5cy4NCj4gDQo+IFdlIGRvIG5vdCBrbm93IGhvdyB1c2VycyB3aWxsIHByb2NlZWQgYWZ0ZXIg
dS1ib290IGJvb3RlZCBhbmQgaWYgdGhlIA0KPiBvdmVybGF5cyB3aWxsIGJlIGF2YWlsYWJsZSB0
byB0aGUgImV4dGVuc2lvbiBzZXR1cCIuIEJldHRlciB0byBoYXZlIA0KPiBldmVyeXRoaW5nIGlu
IHBsYWNlIGFuZCBmaXh1cCB0byB0aGUgYmVzdCB3ZSBrbm93IHVzaW5nIG91ciBTb00gZGF0YSAN
Cj4gc3RvcmVkIGluIHRoZSBFRVBST00uDQo+IA0KPiBUaGlzIGtpbmQgb2Ygb3ZlcmxheXMgc2hv
dWxkIGJlIGFwcGxpZWQgcmVnYXJkbGVzcyBvZiB0aGUgYm9vdCBkZXZpY2UuDQo+IA0KPiA+IA0K
PiA+IFJlZ2FyZHMsDQo+ID4gRGFuaWVsDQo+ID4gDQo+ID4gPiANCj4gPiA+IFlhbm5pYw0KPiA+
ID4gDQo+ID4gPiA+ICsjZW5kaWYNCj4gPiA+ID4gwqDCoG5ldF9sb2FkX2Jvb3RlbnY9JHtnZXRf
Y21kfSAke2Jvb3RlbnZfYWRkcl9yfSAke2Jvb3RlbnZ9DQo+ID4gPiA+IMKgwqBuZXRfbG9hZF9v
dmVybGF5PSR7Z2V0X2NtZH0gJHtmZHRvdmVybGF5X2FkZHJfcn0gJHtvdmVybGF5fQ0KPiA+ID4g
PiDCoMKgbmV0X2FwcGx5X292ZXJsYXlzPQ0KPiA+ID4gPiBAQCAtMzYsMyArNDYsMTMgQEAgbmV0
X2FwcGx5X292ZXJsYXlzPQ0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmaTsN
Cj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgIGRvbmU7DQo+ID4gPiA+IMKgwqDCoMKgwqAgZmk7
DQo+ID4gPiA+ICsjaWZkZWYgQ09ORklHX0NNRF9FWFRFTlNJT04NCj4gPiA+ID4gK25ldF9hcHBs
eV9leHRlbnNpb25zPQ0KPiA+ID4gPiArwqDCoMKgIHNldGVudiBleHRlbnNpb25fb3ZlcmxheV9h
ZGRyICR7ZmR0b3ZlcmxheV9hZGRyX3J9Ow0KPiA+ID4gPiArwqDCoMKgIHNldGVudiBleHRlbnNp
b25fb3ZlcmxheV9jbWQgJyR7Z2V0X2NtZH0gJHtmZHRvdmVybGF5X2FkZHJfcn0NCj4gPiA+ID4g
K8KgwqDCoMKgICR7ZXh0ZW5zaW9uX292ZXJsYXlfbmFtZX0nOw0KPiA+ID4gPiArwqDCoMKgIGV4
dGVuc2lvbiBzY2FuOw0KPiA+ID4gPiArwqDCoMKgIGV4dGVuc2lvbiBhcHBseSBhbGw7DQo+ID4g
PiA+ICsjZWxzZQ0KPiA+ID4gPiArbmV0X2FwcGx5X2V4dGVuc2lvbnM9ZWNobyAibm8gZXh0ZW5z
aW9uIGNvbW1hbmQiDQo+ID4gPiA+ICsjZW5kaWYNCg0K
