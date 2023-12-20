Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B8CC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 20:25:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37AD18783A;
	Wed, 20 Dec 2023 21:25:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=prolan.hu header.i=@prolan.hu header.b="EP3RFo6d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD5C88718F; Wed, 20 Dec 2023 20:24:12 +0100 (CET)
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47E5B8781D
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 20:24:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Csokas.Bence@prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain
 [127.0.0.1])
 by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 4AAD7A140D;
 Wed, 20 Dec 2023 20:24:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
 :cc:content-id:content-transfer-encoding:content-type
 :content-type:date:from:from:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=mail; bh=FMtzl03IU
 B5WsaN2lQBaUMfw4JNabQSc4zKoHn6MoeY=; b=EP3RFo6dj1mMktb7BgRiypvel
 0U8ZPP4KmO3btyYIbCBfi//5VbqcloA4EERX+VwBi+6Ffmn1HI+raS43twEWGkw9
 zRA1kCf2Rt6ibbz/aO1KVhl14skJfV+FVP4MChyzvge+ag3TLhY4Eqzs1/ttUlTR
 KUbQbXNC+swO9kVRErtLg7xk4UI19kOAxKCPscU/mGyXUSdS/Dnn4SPnbV9tLs7u
 en/PtgacaMp4D4k6AFQVpyGc78TzZUEmQ1bwkFnIKVsCqo+BVN+LRnOU3nlkbetm
 jcULV8DnKMlPLLHgm3qL4NeL6TWN1jIqLMxFTj79s6kfsjBrsjr4+Xb5z9y4k8ci
 2LV8GRLn/spg9kFJP0mTX9fuzKH/0MAGdS0cmXc8+xRnmjFMatCpJg9sQ84l8+yD
 hQ+MqR6wZK+ZzouUwBn80qf69FPvKzyO25xGCO3YmJI9XZj1gDfVQPOnEl+jUPq4
 MraAFMkZ3viBuLectubo+WAxeG9/+9LmEpb367hpWFySsPk3O+1YbH2tLi9yw8u2
 PJq1KA16jFUQ4CMYqNGDoVoZEhZfNp9wMdoJ7PWAblrdOUgLx+ok2GY/q85XvhAO
 XF8A/JmLFFNmWxGLsyfu6Gdoiqljjw/R9jxTA11zfUgaopZJDsqIA1mXZ5ntB2oP
 yqIhw181elNARdzkUY=
From: =?utf-8?B?Q3PDs2vDoXMgQmVuY2U=?= <Csokas.Bence@prolan.hu>
To: Dragan Simic <dsimic@manjaro.org>
CC: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Daniel Golle
 <daniel@makrotopia.org>, Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: Passing boot logs to Linux?
Thread-Topic: Passing boot logs to Linux?
Thread-Index: AQHaMrctQ91qLkCwS0+C38IRePG/PrCxfvIAgAAJqQCAAAUhAIAAHXMAgAAFjICAAAwqgIAACkGAgAC224A=
Date: Wed, 20 Dec 2023 19:24:07 +0000
Message-ID: <f22f86ec-987f-4404-8722-82270f1e8da8@prolan.hu>
References: <6fd0dd4c-4bce-47cf-a669-7d093b9a1f10@prolan.hu>
 <CAPnjgZ01=y-Kf=XmDv6UyEdPgXLp8bhZnSZDBVk1FPfBh8CdOw@mail.gmail.com>
 <6ae238be-3c5f-5ef6-9e18-282be9ae24c2@gmail.com>
 <16e633f9d4b1c426aaca510157479d65@manjaro.org>
 <51121aee-faca-4196-8532-719fb6ec9bdc@prolan.hu>
 <2c108e1ff92db2b74f5ccccd770872a7@manjaro.org>
 <5e0e71a5-f3c8-413e-96a3-a0b6edee928f@prolan.hu>
 <3900f4b15852d0af65635b3a794d34af@manjaro.org>
In-Reply-To: <3900f4b15852d0af65635b3a794d34af@manjaro.org>
Accept-Language: hu-HU, en-US
Content-Language: hu-HU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [152.66.192.27]
x-esetresult: clean, is OK
x-esetid: 37303A29CE70385C6C7462
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4AB5BAE91FDE84B819C9B24A58FEC28@prolan.hu>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 20 Dec 2023 21:25:28 +0100
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

T24gMjAyMy4gMTIuIDIwLiA5OjI5LCBEcmFnYW4gU2ltaWMgd3JvdGU6DQo+IE9uIDIwMjMtMTIt
MjAgMDg6NTIsIENzw7Nrw6FzIEJlbmNlIHdyb3RlOg0KPj4gT24gMjAyMy4gMTIuIDIwLiA4OjA5
LCBEcmFnYW4gU2ltaWMgd3JvdGU6DQo+Pj4gT24gMjAyMy0xMi0yMCAwNzo0OSwgQ3PDs2vDoXMg
QmVuY2Ugd3JvdGU6DQo+Pj4+IEkgZG9uJ3QgdGhpbmsgdGhhdCB3b3VsZCBiZSBhIGh1Z2UgcHJv
YmxlbSwgTGludXggdXNlcnNwYWNlIGNhbiBmaWx0ZXINCj4+Pj4gQU5TSSBjb250cm9sIGNvZGVz
IGlmIGl0IHdhbnRzIHRvLiBGb3Igbm93LCBJJ2QgbGlrZSBhIGJ5dGUtZm9yLWJ5dGUNCj4+Pj4g
Y29weSBvZiB0aGUgY29uc29sZSwgYXMtaXMsIHByZXNlbnRlZCB0byBMaW51eC4NCj4+Pg0KPj4+
IEJ1dCB3b3VsZG4ndCByZWNvcmRpbmcgdGhlIGNvbnRyb2wgc2VxdWVuY2VzIGFzLWlzIGFjdHVh
bGx5IGJlIHByZXR0eQ0KPj4+IG11Y2ggdXNlbGVzcz/CoCBGb3IgZXhhbXBsZSwgc29tZSB1c2Vy
IGNhbiBzcGVuZCBhIGZldyBtaW51dGVzDQo+Pj4gc2Nyb2xsaW5nIHRocm91Z2ggdGhlIGJvb3Qg
bWVudSwgd2hpY2ggd291bGQgcHJvZHVjZSBhIGZhaXIgYW1vdW50IG9mDQo+Pj4gbmVhcmx5IHVz
ZWxlc3MgcmVjb3JkZWQgZGF0YS4NCj4+Pg0KPj4+IE1vcmVvdmVyLCBpZiBJJ20gbm90IHdyb25n
LCB2aWV3aW5nIG9yIHBhcnNpbmcgc3VjaCBhcy1pcyBkYXRhIHdvdWxkDQo+Pj4gYWN0dWFsbHkg
cmVxdWlyZSByZXBsYXlpbmcgdGhlIGNvbnRyb2wgc2VxdWVuY2VzLCB0byByZXByb2R1Y2UgdGhl
DQo+Pj4gYWN0dWFsIGNvbnNvbGUgY29udGVudHMgYXMgaXQgd2FzIHJlY29yZGVkLCB3aGljaCB3
b3VsZCBiZSBxdWl0ZQ0KPj4+IGN1bWJlcnNvbWUuDQo+Pg0KPj4gSXQgKmlzKiB1c2VsZXNzLCBi
dXQgbW9zdCBvZiB0aGUgdGltZXMgdGhlIHVzZXIgd29uJ3QgYmUgc2Nyb2xsaW5nIGF0DQo+PiBh
bGwgYW55d2F5cywgdGhhdCdzIHdoeSBJIGRvbid0IHRoaW5rIHRoZXNlIGZldyBleHRyYSBieXRl
cyB3b3VsZCBiZSBhDQo+PiBwcm9ibGVtLg0KPiANCj4gUXVpdGUgZnJhbmtseSwgd2hlbiBpdCBj
b21lcyB0byBjb21wdXRpbmcgaW4gZ2VuZXJhbCwgdGFraW5nIHRoZSAiYWgsIGl0IA0KPiBwcm9i
YWJseSB3b24ndCBoYXBwZW4iIGFwcHJvYWNoIGlzbid0IHRoZSBiZXN0IHRoaW5nIHRvIGRvLsKg
IFdlIHNob3VsZCANCj4gYWltIHRvd2FyZCBjb3ZlcmluZyBwcm9wZXJseSBldmVuIHRoZSBlZGdl
IGNhc2VzLCBpZiB5b3UgYWdyZWUuDQoNCllvdSdyZSBhYnNvbHV0ZWx5IHJpZ2h0OyBob3dldmVy
LCBJIGRpZCBub3Qgc2F5ICJpdCB3b24ndCBoYXBwZW4iLCBJIA0Kc2FpZCB0aGF0IExpbnV4IHVz
ZXJzcGFjZSBjYW4gZ28gZGVhbCB3aXRoIGl0IGlmIGl0IGhhcHBlbnMsIGFuZCBpZiBpdCANCndh
bnRzIHRvLiBBbmQgdGhhdCBpbiBteSBvcGluaW9uLCB0aGUgYmVzdCBjb3Vyc2Ugb2YgYWN0aW9u
IGZvciBVLUJvb3QgDQppcyB0byByZWNvcmQgKmV2ZXJ5dGhpbmcqIChhcyBpdCBkb2VzIG5vdyks
IGFuZCB0aGVuIHVzZXJzcGFjZSBjYW4gDQpkZWNpZGUgdG8gZmlsdGVyIGl0IGZvciBlZy4gQU5T
SSBjb2Rlcy4gQnV0IEkgdGhpbmsgaXQncyBiZXN0IHRvIGtlZXAgDQp0aGUgVS1Cb290IGNvZGUg
ZGVhZCBzaW1wbGUsIGFuZCBhbHNvIHN1cHBseSB0aGUgbW9zdCBkYXRhIHRvIHVzZXJzcGFjZS4N
Cg0KDQo+PiBUaGF0J3Mgd2hhdCBJIHJlYWQgYXMgd2VsbC4gSXMgdGhlcmUgc3VwcG9ydCBmb3Ig
VS1ib290IHRvIHdyaXRlIGFuZA0KPj4gTGludXggdG8gcmVhZCBQU3RvcmVzPw0KPiANCj4gTm8g
YW5kIHllcywgYnV0IFUtQm9vdCBjYW4gYWxyZWFkeSByZWFkIHBzdG9yZS7CoCBQbGVhc2Ugc2Vl
IA0KPiBkb2MvdXNhZ2UvY21kL3BzdG9yZS5yc3QgZm9yIHRoZSBVLUJvb3QgcGFydCwgYW5kIA0K
PiBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL3BzdG9yZS1ibGsucnN0IGZvciB0aGUgTGludXgg
a2VybmVsIHBhcnQuDQoNCklycmVsZXZhbnQsIGFzIHdlIG9ubHkgd2FudCB0byB3cml0ZSBvdXQg
dGhlIGNvbnNvbGUgbG9nIHRvIFUtQm9vdCwgYW5kIA0Kbm90IHRoZSBvdGhlciB3YXkgYXJvdW5k
ICh0aGF0J3MgZm9yIGNvbGxlY3RpbmcgcGFuaWMgbG9ncywgd2hpY2ggaXMgDQphbHJlYWR5IGlt
cGxlbWVudGVkKS4NCg0KPiBBbm90aGVyIGJlbmVmaXQgb2YgdXNpbmcgcHN0b3JlIHdvdWxkIGJl
IG5vIHBlcm1hbmVudGx5IHdhc3RlZCBSQU0gZm9yIA0KPiB0aGUgcmVjb3JkZWQgY29uc29sZSBj
b250ZW50cy7CoCBBbHNvLCBoYXZpbmcgdGhlIGRhdGEgcmVjb3JkZWQgdG8gYSANCj4gc3RvcmFn
ZSBkZXZpY2UgYWxzbyBnb2VzIGFsb25nIHdpdGggcHJvdmlkaW5nIHBlcm1hbmVudCByZWNvcmRz
Lg0KDQpJJ20gcG9zaXRpdmVseSAqbm90IGdvbm5hIHNhdmUgYm9vdCBsb2dzIHRvIGRpc2sqLCBh
cyBtb3N0IGVtYmVkZGVkIA0Kc3lzdGVtcyBoYXZlIEZsYXNoLWJhc2VkIHN0b3JhZ2UgbWVkaWE7
IHdyaXRpbmcgdG8gdGhlbSBvbiBldmVyeSBib290IA0Kd291bGQgYmUgZGV2YXN0YXRpbmcuIFBs
dXMsIEkgZG9uJ3Qgd2FudCB0aGUgY29uc29sZSBzdWJzeXN0ZW0gdG8gZGVwZW5kIA0Kb24gYW55
IGZpbGUvZGlzayBvcGVyYXRpb25zL2RyaXZlcnMuDQoNClRoZXJlZm9yZSwgaXQgd2lsbCBiZSBu
ZWNlc3NhcnkgdG8gcGVybWFuZW50bHkga2VlcCB0aGUgbG9ncyBpbi1tZW1vcnksIA0KcmVnYXJk
bGVzcyBvZiB3aGV0aGVyIHdlIHVzZSB0aGUgUFN0b3JlIGZvcm1hdCBvciBzb21ldGhpbmcgZWxz
ZS4gVW5sZXNzIA0KTGludXggd2FudHMgdG8gY29weSBpdCBlbHNld2hlcmUgKHdoaWNoIHByb2Jh
Ymx5IHdpbGwgYmUgbWVtb3J5IA0KYW55d2F5cykuIEJ1dCBtYXliZSB3ZSBjb3VsZCBvZmZlciBz
b21lIG9wdGlvbiBpbiB0aGUgTGludXggZHJpdmVyIHRvIA0KcmVsZWFzZSB0aGUgbG9ncywgYWxv
bmcgd2l0aCB0aGUgYXNzb2NpYXRlZCBtZW1vcnkgcmVnaW9uLi4uDQoNCkFsbCBpbiBhbGwsIEkn
bSBhbGwgZm9yIHVzaW5nIHByZS1leGlzdGluZyBzdGFuZGFyZCBpbnRlcmZhY2VzIGluc3RlYWQg
DQpvZiBpbnZlbnRpbmcgc29tZXRoaW5nIG5ldyBhbmQgY3VzdG9tLCBidXQgYXMgSSBzZWUgaXQg
bm93LCBQU3RvcmUganVzdCANCmNhbm5vdCBkbyB3aGF0IHdlIHdhbnQgaGVyZS4gSWYgYW55IG9m
IHlvdSB0aGluayBvdGhlcndpc2UsIGZlZWwgZnJlZSB0byANCnRyeSB0byBjb252aW5jZSBtZSBm
dXJ0aGVyLCBvciBldmVuIGd1aWRlIG1lIG9uIGhvdyB0byB1c2UgUFN0b3Jlcy4NCg0KSGVyZSdz
IHdoYXQgSSB3b3VsZCB3YW50Og0KKiB3cml0aW5nIGFscmVhZHkgc3VwcG9ydGVkIGluIFUtQm9v
dA0KKiBwdXJlIGluLW1lbW9yeSBzb2x1dGlvbg0KKiBtaW5pbWFsIG92ZXJoZWFkIHRvIHRoZSBj
b25zb2xlIHN1YnN5c3RlbQ0KDQo=

