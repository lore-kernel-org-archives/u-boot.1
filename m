Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9395C25B5F
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 06:55:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ABE2882D2;
	Mon, 13 May 2024 08:55:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=yadro.com header.i=@yadro.com header.b="GvIm/7+l";
	dkim=pass (2048-bit key; unprotected) header.d=yadro.com header.i=@yadro.com header.b="QF8YHCjd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD039882E8; Mon, 13 May 2024 08:55:27 +0200 (CEST)
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59ED4882B8
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 08:55:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=v.v.mitrofanov@yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 80B4DC0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
 t=1715583324; bh=lAUJ+66gk7U5bIqCl6MrtmwTLiFviitkKjkaPEsA7Es=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=GvIm/7+ljrKU3hDVfSIMdmQbIMOKflaJZsDd9oGAYbI6bhTpse9Xs9KGez1npHKKW
 JtMjeeoIyfHs4vaoyBBeGkJks5pUBAp+PAeCVze5+WLYeA+nfYvuDqQ4oCb3f7snCn
 ldGdhX5x2bnMPG6FzptbsDLgcG0iaxtv/YUXY+VUiIRjwcr+ErIl65Xx+GPZi/7XL4
 SQCigE6QlRXLfeDaVoKFNw4RcguWLCr+sbsGoz9dTxCNU5iWr73LJe7TSeEJSaDbXz
 yMdMrBsYB+MEr3D2rvI6NpCVMWoMW21DZkjtL/F+QYhhH0RkmirVq8GznI+mRg1ktr
 ktadSZboblyWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
 t=1715583324; bh=lAUJ+66gk7U5bIqCl6MrtmwTLiFviitkKjkaPEsA7Es=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=QF8YHCjdP0OhfAfdGiflbNOk/uFsM4TpCiO3OuxG6NA11lIOwv5wj74MYkRZihGYt
 R4Q1FwXt5PkIHa+Wf3+wNw0ORkp+X9lQwjbWwnPvNv/+taOK3P9mzSinEgdZYdK/id
 gsXJtY+lmtuMRx/cG1UFS7kxF2uUl1VgGuTqQzSOeqr565DovQTImlpFXH9HnTa5YX
 yZDVRTFBVwNslk0Sut0BvQ7MDqkR9HnyBsAnulqyr9GiCGL3wxyIgNkDbBHP2GH9fN
 KNRd4iOTo7KXDS6c2K3REevQDDN8Sx3fbxZN8vbJtGXmoziVzPAP6SPUpRP0M0h3Q/
 ibgHEcZkwA4Xw==
From: "Vyacheslav V. Mitrofanov" <v.v.mitrofanov@yadro.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "seanedmond@linux.microsoft.com" <seanedmond@linux.microsoft.com>
CC: "trini@konsulko.com" <trini@konsulko.com>, "joe.hershberger@ni.com"
 <joe.hershberger@ni.com>, "rfried.dev@gmail.com" <rfried.dev@gmail.com>,
 "saproj@gmail.com" <saproj@gmail.com>, "seanedmond@microsoft.com"
 <seanedmond@microsoft.com>
Subject: Re: [PATCH] Fix neighbor discovery ethernet address saving
Thread-Topic: [PATCH] Fix neighbor discovery ethernet address saving
Thread-Index: AQHammY8edxoSjJSfEa2TmoN/0kXxLGIOU4AgARtgACAB/cnAA==
Date: Mon, 13 May 2024 06:55:23 +0000
Message-ID: <d8017b043ae127bdd3fa4b3edf61ba8454d3d8f2.camel@yadro.com>
References: <20240429185116.2287092-1-seanedmond@linux.microsoft.com>
 <2c8ff0fe4c082799118bbf13de7b2f6558493334.camel@yadro.com>
 <9f6ea33b-9bdb-49a3-b8a6-51072d3b1a34@linux.microsoft.com>
In-Reply-To: <9f6ea33b-9bdb-49a3-b8a6-51072d3b1a34@linux.microsoft.com>
Accept-Language: en-UM, en-150, ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <A766E81D6C65644EAC91F5C8C3D3E229@yadro.com>
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

SGVsbG8sIFNlYW4uIA0KSSBzZWUuIFlvdSBhcmUgcmlnaHQuDQoNClJldmlld2VkLWJ5OiBWaWFj
aGVzbGF2IE1pdHJvZmFub3YgPHYudi5taXRyb2Zhbm92QHlhZHJvLmNvbT4NCg0KDQpPbiBUdWUs
IDIwMjQtMDUtMDcgYXQgMjI6MTYgLTA3MDAsIFNlYW4gRWRtb25kIHdyb3RlOg0KPiANCj4gSGkg
VnlhY2hlc2xhLA0KPiANCj4gTGV0J3Mgc3RhcnQgYnkgc2F5aW5nIG5laWdoYm91ciBkaXNjb3Zl
cnkgcHJvdG9jb2wgaXMgZGVmaW5pdGVseQ0KPiB3b3JraW5nDQo+IHByb3Blcmx5LsKgIEknbSBv
bmx5IHN1Z2dlc3RpbmcgdGhhdCBpdCBpc24ndCBwcm9wZXJseSBjYWNoaW5nIHRoZSBNQUMNCj4g
YWRkcmVzcy7CoCBEdXJpbmcgSVB2NiBURlRQIEkgb2JzZXJ2ZSB0aGF0IG5laWdoYm91ciBkaXNj
b3ZlcnkgaXMNCj4gcGVyZm9ybWVkIGJlZm9yZSBldmVyeSBwYWNrZXQgc2VudCBmcm9tIGNsaWVu
dCh1LWJvb3QpLT5zZXJ2ZXIuDQo+IA0KPiBIZXJlJ3MgYSBzbmFwc2hvdCBvZiB3aGF0IHRoZSBw
YWNrZXRzIGZyb20gY2xpZW50KHUtYm9vdCk8LT5zZXJ2ZXINCj4gbG9vaw0KPiBsaWtlIGR1cmlu
ZyBJUHY2IFRGVFA6DQo+IC0+IG5laWdoYm91ciBzb2xpY2l0YXRpb24NCj4gPC0gbmVpZ2hib3Vy
IGFkdmVydGlzZW1lbnQNCj4gLT4gcmVhZCByZXF1ZXN0DQo+IDwtIEJsb2NrIDANCj4gLT4gbmVp
Z2hib3VyIHNvbGljaXRhdGlvbg0KPiA8LSBuZWlnaGJvdXIgYWR2ZXJ0aXNlbWVudA0KPiAtPiBB
Q0sgYmxvY2sgMA0KPiA8LSBCbG9jayAxDQo+IC0+IG5laWdoYm91ciBzb2xpY2l0YXRpb24NCj4g
PC0gbmVpZ2hib3VyIGFkdmVydGlzZW1lbnQNCj4gLT4gQUNLIGJsb2NrIDENCj4gLSAuLi4gKGNv
bnRpbnVlcyBmb3IgZW50aXJlIGZpbGUgdHJhbnNmZXIpDQo+IA0KPiBUaGUgbmVpZ2hib3VyIGRp
c2NvdmVyeSBvbiBldmVyeSBUWCBURlRQIHBhY2tldCBpc24ndCByZXF1aXJlZCBhbmQNCj4gcmVz
dWx0cyBpbiBkZWdyYWRlZCBwZXJmb3JtYW5jZS7CoCBOb3RlLCB3aGVuIHBlcmZvcm1pbmcgdGhl
IHRlc3Qgd2l0aA0KPiBJUHY0LCBBUlAgaXMgbm90IHBlcmZvcm1lZCBiZWZvcmUgZXZlcnkgVFgg
cGFja2V0Lg0KPiANCj4gSGVyZSdzIGEgZGVzY3JpcHRpb24gb2YgdGhlIGNvZGUgZmxvdyAoaW5j
bHVkaW5nIG15IHByb3Bvc2FsKToNCj4gLSBuZXQuYyBkZWZpbmVzICJ1OCBuZXRfc2VydmVyX2V0
aGFkZHJbNl07Ig0KPiAtIHRmdHBfc2VuZCgpLT4gbmV0X3NlbmRfdWRwX3BhY2tldDYobmV0X3Nl
cnZlcl9ldGhhZGRyLCAuLi4pDQo+IC0gaW4gbmV0X3NlbmRfdWRwX3BhY2tldDYoKSwgIm5ldF9u
ZF9wYWNrZXRfbWFjID0gZXRoZXI7IsKgIChub3csDQo+IG5ldF9uZF9wYWNrZXRfbWFjIGlzIHBv
aW50aW5nIHRvIG5ldF9zZXJ2ZXJfZXRoYWRkcikNCj4gLSBpbiBuZGlzY19yZWNlaXZlKCksIHdo
ZW4gTkEgaXMgcmVjZWl2ZWQgdGhlIG1hYyBiZWNvbWVzIGF2YWlsYWJsZQ0KPiBpbg0KPiBuZWln
aF9ldGhfYWRkcg0KPiAtIE15IHByb3Bvc2FsIGlzLCAiaWYgcG9pbnRlciBuZXRfbmRfcGFja2V0
X21hYyBpc24ndCBOVUxMLCBjb3B5IHRoaXMNCj4gY29udGVudHMgb2YgbmVpZ2hfZXRoX2FkZHIg
aW50byBuZXRfbmRfcGFja2V0X21hYyINCj4gLSBGb3IgVEZUUCwgbXkgZml4IGFsbG93cyB0aGUg
c2VydmVyJ3MgTUFDIHRvIGdldCBjb3BpZWQgaW50bw0KPiBuZXRfc2VydmVyX2V0aGFkZHINCj4g
LSBvbiB0aGUgbmV4dCB0ZnRwX3NlbmQoKSwgaW4gbmV0X3NlbmRfdWRwX3BhY2tldDYoKSBuZWln
aGJvdXINCj4gZGlzY292ZXJ5DQo+IGlzIHNraXBwZWQgYmVjYXVzZSAiZXRoZXIiIGlzbid0IGFs
bCB6ZXJvcw0KPiANCj4gVGhlIG1lbWNweSBpc24ndCBkYW5nZXJvdXMsIGJlY2F1c2UgaXQncyBj
b3B5aW5nIHRoZSBkaXNjb3ZlcmVkIG1hYw0KPiBhZGRyZXNzIGludG8gdGhlIGFscmVhZHkgYWxs
b2NhdGVkIG5ldF9zZXJ2ZXJfZXRoYWRkciAoYW5kIGl0J3MNCj4gY2hlY2tpbmcNCj4gdG8gbWFr
ZSBzdXJlIHRoYXQgbmV0X25kX3BhY2tldF9tYWMgaXNuJ3QgTlVMTCBiZWZvcmUgY29weWluZyku
DQo+IA0KPiBBbHNvLCB0aGUgY3VycmVudCBjb2RlIHNlcnZlcyBubyBwdXJwb3NlLsKgIFRoZSBj
dXJyZW50IGNvZGUgaXMsICJpZg0KPiBuZXRfbmRfcGFja2V0X21hYyBpcyBOVUxMLCBzZXQgaXQg
dG8gc3RhY2sgdmFyaWFibGUgbmVpZ2hfZXRoX2FkZHIsDQo+IHRoZW4NCj4gc2V0IG5ldF9uZF9w
YWNrZXRfbWFjIHRvIE5VTEwgd2hlbiB0aGVyZSBpcyBubyBORCBwZW5kaW5nICh0aGUgbWFjDQo+
IGFkZHJlc3MgZG9lc24ndCBnZXQgc2F2ZWQgaW4gbmV0X3NlcnZlcl9ldGhhZGRyKS4NCj4gDQo+
IFNlYW4NCj4gDQo+IA0KPiANCj4gDQo+IA0KPiANCj4gDQo+IA0KPiANCj4gDQo+IE9uIDIwMjQt
MDUtMDUgMjo0MCBhLm0uLCBWeWFjaGVzbGF2IFYuIE1pdHJvZmFub3Ygd3JvdGU6DQo+ID4gT24g
TW9uLCAyMDI0LTA0LTI5IGF0IDExOjUxIC0wNzAwLCBzZWFuZWRtb25kQGxpbnV4Lm1pY3Jvc29m
dC5jb20NCj4gPiB3cm90ZToNCj4gPiA+IHNvY0B5YWRyby5jb208bWFpbHRvOnNvY0B5YWRyby5j
b20+DQo+ID4gPiANCj4gPiA+IEZyb206IFNlYW4gRWRtb25kIDxzZWFuZWRtb25kQG1pY3Jvc29m
dC5jb20+DQo+ID4gPiANCj4gPiA+IFdoZW4gYSBzdWNjZXNzZnVsIG5laWdoYm9yIGFkdmVydGlz
ZW1lbnQgaXMgcmVjZWl2ZWQsIHRoZQ0KPiA+ID4gZXRoZXJuZXQNCj4gPiA+IGFkZHJlc3Mgc2hv
dWxkIGJlIHNhdmVkIGZvciBsYXRlciB1c2UgdG8gYXZvaWQgaGF2aW5nIHRvIHJlZG8gdGhlDQo+
ID4gPiBuZWlnaGJvciBkaXNjb3ZlcnkgcHJvY2Vzcy4NCj4gPiA+IA0KPiA+ID4gRm9yIGV4YW1w
bGUsIHdpdGggVEZUUCB0aGUgYWRkcmVzcyBzaG91bGQgZ2V0IHNhdmVkIGludG8NCj4gPiA+ICJu
ZXRfc2VydmVyX2V0aGFkZHIiLsKgIFRoaXMgaXMgYmVpbmcgZG9uZSBjb3JyZWN0bHkgd2l0aCBB
UlAgZm9yDQo+ID4gPiBJUHY0LA0KPiA+ID4gYnV0IG5vdCBmb3IgbmVpZ2hib3IgZGlzY292ZXJ5
IHdpdGggSVB2Ni4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogU2VhbiBFZG1vbmQgPHNl
YW5lZG1vbmRAbWljcm9zb2Z0LmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gwqAgbmV0L25kaXNjLmMg
fCA0ICsrLS0NCj4gPiA+IMKgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9uZXQvbmRpc2MuYyBiL25ldC9u
ZGlzYy5jDQo+ID4gPiBpbmRleCBkMWNlYzA2MDFjOC4uNTA1NTE1ZjJkOTUgMTAwNjQ0DQo+ID4g
PiAtLS0gYS9uZXQvbmRpc2MuYw0KPiA+ID4gKysrIGIvbmV0L25kaXNjLmMNCj4gPiA+IEBAIC00
NjEsOCArNDYxLDggQEAgaW50IG5kaXNjX3JlY2VpdmUoc3RydWN0IGV0aGVybmV0X2hkciAqZXQs
DQo+ID4gPiBzdHJ1Y3QNCj4gPiA+IGlwNl9oZHIgKmlwNiwgaW50IGxlbikNCj4gPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZGlzY19leHRyYWN0
X2VuZXRhZGRyKG5kaXNjLA0KPiA+ID4gbmVpZ2hfZXRoX2FkZHIpOw0KPiA+ID4gDQo+ID4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogc2F2ZSBh
ZGRyZXNzIGZvciBsYXRlciB1c2UgKi8NCj4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIW5ldF9uZF9wYWNrZXRfbWFjKQ0KPiA+ID4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBu
ZXRfbmRfcGFja2V0X21hYyA9DQo+ID4gPiBuZWlnaF9ldGhfYWRkcjsNCj4gPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAobmV0X25kX3BhY2tldF9t
YWMpDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIG1lbWNweShuZXRfbmRfcGFja2V0X21hYywNCj4gPiA+IG5laWdoX2V0
aF9hZGRyLCA2KTsNCj4gPiA+IA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIC8qIG1vZGlmeSBoZWFkZXIsIGFuZCB0cmFuc21pdCBpdCAqLw0K
PiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1l
bWNweSgoKHN0cnVjdCBldGhlcm5ldF9oZHINCj4gPiA+ICopbmV0X25kX3R4X3BhY2tldCktPmV0
X2Rlc3QsDQo+ID4gPiAtLQ0KPiA+ID4gMi40Mi4wDQo+ID4gPiANCj4gPiBIZWxsbywgU2Vhbi4g
VGhhbmtzIGZvciB5b3VyIG5vdGljZS4gSSBzZWUgdGhhdCBuZXRfbmRfcGFja2V0X21hYw0KPiA+
IGlzDQo+ID4ganVzdCBhIHVjaGFyIHBvaW50ZXIgd2l0aG91dCBtZW1vcnkgYWxsb2NhdGlvbi4g
SXQgaXMgZGFuZ2Vyb3VzIHRvDQo+ID4gZG8NCj4gPiBtZW1jcHkgYW5kIG5vdCBuZWNlc3Nhcnku
IEFsbCB3b3JrcyBhcyBpdCBoYXMgdG8gYmUuDQoNCg==
