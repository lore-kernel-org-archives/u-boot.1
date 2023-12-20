Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E33C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 23:49:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 493E28783F;
	Thu, 21 Dec 2023 00:49:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=prolan.hu header.i=@prolan.hu header.b="kVV3ewmC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA42D8781A; Thu, 21 Dec 2023 00:27:29 +0100 (CET)
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B5BA8773C
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 00:27:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Csokas.Bence@prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain
 [127.0.0.1])
 by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 831D0A13E7;
 Thu, 21 Dec 2023 00:27:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
 :cc:content-id:content-transfer-encoding:content-type
 :content-type:date:from:from:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=mail; bh=rTeoSN5l1
 RdOc4/9FgvscsQ02xSxWKHgxyQHqPcPV1I=; b=kVV3ewmCmqNl01Mxr1dojlJEZ
 uLxpJR0P9/MqVml84izw1gHf1DRG3wd/tAu6Qz7PxYab3k9O+iOh8tnSRt/RrOrr
 pPqDyE9za1mbQmbHGm4fQTDB5vqCvmQndDmHfcIwID/sCnu4jJqrbQY5CN62CvMi
 1wCrOZPQOqeYnkp8c3wBJ3ZOY3rk8ExRL8WVaHVZm9gGj2f7nPS9FxN0cCdFVqLW
 fGSFuUGd1iaoXGS9smkLOe+K65cGMAGKt0YvPMc4S5GckzdopFssT8Two8qSxiau
 sEfhNF8aEEP9gqX69TkFk50uAJdosSvdg0CrMPr95aw1kRsgvR4052sbakPBZSIg
 ZCJEjKkEqNrM4UMLKQpZTJQkbLfO8rAoJxc90RtbCNGA7OnFMt7+YXay4nghfRkQ
 l6sFnhMy8MpiV6s42sm6jkjMQ6zBObT5tkoR52QwlOOQ+kXXNDJhcErzsZgqQilu
 zcWFfMk+BGMEF/1Q3W9sdOwPK9cFsmbuBLRvt3bOf7lRq3vovz8QN8kXpT7Blw8A
 u69Pl7A3hSFt3F/4gNFW+VDolXVyeYJVBNOFZ86oGTo/UgOTKeYtq6hEjmJhd4ai
 Mof6OojgnyancYoIZV20fYFo51X0EE9ZkUh0cYYImtcsKYMNLWSVH1vvLigWjPcN
 8yL7i+09xt1tEO9yoc=
From: =?utf-8?B?Q3PDs2vDoXMgQmVuY2U=?= <Csokas.Bence@prolan.hu>
To: Dragan Simic <dsimic@manjaro.org>
CC: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Daniel Golle
 <daniel@makrotopia.org>, Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: Passing boot logs to Linux?
Thread-Topic: Passing boot logs to Linux?
Thread-Index: AQHaMrctQ91qLkCwS0+C38IRePG/PrCxfvIAgAAJqQCAAAUhAIAAHXMAgAAFjICAAAwqgIAACkGAgAC224CAAAmNAIAAOmwA
Date: Wed, 20 Dec 2023 23:27:24 +0000
Message-ID: <5fd64984-4715-4880-ba27-ef78094da6cb@prolan.hu>
References: <6fd0dd4c-4bce-47cf-a669-7d093b9a1f10@prolan.hu>
 <CAPnjgZ01=y-Kf=XmDv6UyEdPgXLp8bhZnSZDBVk1FPfBh8CdOw@mail.gmail.com>
 <6ae238be-3c5f-5ef6-9e18-282be9ae24c2@gmail.com>
 <16e633f9d4b1c426aaca510157479d65@manjaro.org>
 <51121aee-faca-4196-8532-719fb6ec9bdc@prolan.hu>
 <2c108e1ff92db2b74f5ccccd770872a7@manjaro.org>
 <5e0e71a5-f3c8-413e-96a3-a0b6edee928f@prolan.hu>
 <3900f4b15852d0af65635b3a794d34af@manjaro.org>
 <f22f86ec-987f-4404-8722-82270f1e8da8@prolan.hu>
 <d1350e2c5ff1da1cf10c92b1b49dec6b@manjaro.org>
In-Reply-To: <d1350e2c5ff1da1cf10c92b1b49dec6b@manjaro.org>
Accept-Language: hu-HU, en-US
Content-Language: hu-HU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [152.66.192.27]
x-esetresult: clean, is OK
x-esetid: 37303A29916D385C6C7460
Content-Type: text/plain; charset="utf-8"
Content-ID: <99A2D29C922C9845B9AB72687265F5D1@prolan.hu>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 21 Dec 2023 00:49:08 +0100
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

T24gMjAyMy4gMTIuIDIwLiAyMDo1OCwgRHJhZ2FuIFNpbWljIHdyb3RlOg0KPiBPbiAyMDIzLTEy
LTIwIDIwOjI0LCBDc8Oza8OhcyBCZW5jZSB3cm90ZToNCj4+IE9uIDIwMjMuIDEyLiAyMC4gOToy
OSwgRHJhZ2FuIFNpbWljIHdyb3RlOg0KPj4+IE9uIDIwMjMtMTItMjAgMDg6NTIsIENzw7Nrw6Fz
IEJlbmNlIHdyb3RlOg0KPj4+PiBUaGF0J3Mgd2hhdCBJIHJlYWQgYXMgd2VsbC4gSXMgdGhlcmUg
c3VwcG9ydCBmb3IgVS1ib290IHRvIHdyaXRlIGFuZA0KPj4+PiBMaW51eCB0byByZWFkIFBTdG9y
ZXM/DQo+Pj4NCj4+PiBObyBhbmQgeWVzLCBidXQgVS1Cb290IGNhbiBhbHJlYWR5IHJlYWQgcHN0
b3JlLsKgIFBsZWFzZSBzZWUNCj4+PiBkb2MvdXNhZ2UvY21kL3BzdG9yZS5yc3QgZm9yIHRoZSBV
LUJvb3QgcGFydCwgYW5kDQo+Pj4gRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9wc3RvcmUtYmxr
LnJzdCBmb3IgdGhlIExpbnV4IGtlcm5lbCBwYXJ0Lg0KPj4NCj4+IElycmVsZXZhbnQsIGFzIHdl
IG9ubHkgd2FudCB0byB3cml0ZSBvdXQgdGhlIGNvbnNvbGUgbG9nIHRvIFUtQm9vdCwgYW5kDQo+
PiBub3QgdGhlIG90aGVyIHdheSBhcm91bmQgKHRoYXQncyBmb3IgY29sbGVjdGluZyBwYW5pYyBs
b2dzLCB3aGljaCBpcw0KPj4gYWxyZWFkeSBpbXBsZW1lbnRlZCkuDQo+IA0KPiBRdWl0ZSBmcmFu
a2x5LCB0aGlzIGlzIGEgYml0IGNvbmZ1c2luZyB0byBtZS7CoCBXaHkgc2hvdWxkIGl0IGJlIA0K
PiBpcnJlbGV2YW50LCBpZiB3ZSB3YW50IHRvIHN0b3JlIHRoZSBVLUJvb3QgY29uc29sZSBsb2dz
IGludG8gdGhlIHBzdG9yZSwgDQo+IGFuZCByZWFkIHRoZW0gbGF0ZXIgaW4gTGludXg/wqAgVGhh
dCdzIGV4YWN0bHkgd2hhdCB5b3UgYXNrZWQgYWJvdXQsIGFuZCANCj4gaXQgd2FzIGEgZ29vZCBx
dWVzdGlvbi4NCg0KQmVjYXVzZSB3ZSB3YW50IHRvICp3cml0ZSogUFN0b3JlIGZyb20gVS1Cb290
LiBUaGUgcmVhZCBiZWluZyBhbHJlYWR5IA0KaW1wbGVtZW50ZWQgaXMgbm90IHZlcnkgdXNlZnVs
LCB3ZSBjb3VsZCBvbmx5IHJlLXJlYWQgYW4gYWxyZWFkeS13cml0dGVuIA0KY29uc29sZSBsb2cg
KHdoaWNoIGlzIG5vdCBoZWxwZnVsIGZvciB1cykuDQoNCj4+PiBBbm90aGVyIGJlbmVmaXQgb2Yg
dXNpbmcgcHN0b3JlIHdvdWxkIGJlIG5vIHBlcm1hbmVudGx5IHdhc3RlZCBSQU0gZm9yDQo+Pj4g
dGhlIHJlY29yZGVkIGNvbnNvbGUgY29udGVudHMuwqAgQWxzbywgaGF2aW5nIHRoZSBkYXRhIHJl
Y29yZGVkIHRvIGENCj4+PiBzdG9yYWdlIGRldmljZSBhbHNvIGdvZXMgYWxvbmcgd2l0aCBwcm92
aWRpbmcgcGVybWFuZW50IHJlY29yZHMuDQo+Pg0KPj4gSSdtIHBvc2l0aXZlbHkgKm5vdCBnb25u
YSBzYXZlIGJvb3QgbG9ncyB0byBkaXNrKiwgYXMgbW9zdCBlbWJlZGRlZA0KPj4gc3lzdGVtcyBo
YXZlIEZsYXNoLWJhc2VkIHN0b3JhZ2UgbWVkaWE7IHdyaXRpbmcgdG8gdGhlbSBvbiBldmVyeSBi
b290DQo+PiB3b3VsZCBiZSBkZXZhc3RhdGluZy4NCj4gDQo+IFdyaXRpbmcgMzAtNDAgS0Igb2Yg
ZGF0YSB0byBhbiBldmVuIHJlbW90ZWx5IG1vZGVybiBmbGFzaC1iYXNlZCBzdG9yYWdlIA0KPiBt
ZWRpYSBvbiBlYWNoIGJvb3QgaXMgcHJldHR5IG11Y2ggbm90aGluZy7CoCBPVE9ILCB3cml0aW5n
IDMwLTQwIEtCIG9mIA0KPiBkYXRhIHRvIGFuIFNQSSBjaGlwIG9uIGVhY2ggYm9vdCB3b3VsZCBi
ZSByYXRoZXIgYmFkLCBidXQgd2UgYXJlbid0IA0KPiBnb2luZyB0byBkbyB0aGF0IGZvciBzdXJl
Lg0KPiANCj4gVG8gcHV0IHRoaW5ncyBpbnRvIHBlcnNwZWN0aXZlLCBJJ20gd3JpdGluZyB0aGlz
IG9uIGEgUGluZWJvb2sgUHJvIHdpdGggDQo+IGFuIGVNTUMgY2hpcCwgYW5kIGl0IGhhcyBzdG9y
ZWQgbWFueSBHQnMgb2YgZGF0YSBvdmVyIGEgZmV3IHllYXJzLsKgIEV2ZW4gDQo+IGhpZ2gtZW5k
dXJhbmNlIG1pY3JvU0QgY2FyZHMgYXJlIHJhdGhlciByZWxpYWJsZSBpbiB0aGF0IHJlZ2FyZC4N
Cg0KTm90IGV2ZXJ5IHN5c3RlbSBoYXMgZU1NQy91U0QsIGFuZCBhcyB5b3Ugc2FpZCwgdGhlc2Ug
YXJndW1lbnRzIGRvbid0IA0KaG9sZCBmb3IgYSA0IE1CIFNQSSBOQU5ELCBmb3IgZXhhbXBsZSwg
b25lIHlvdSBtaWdodCBmaW5kIGluIGFuIE9wZW5XcnQgDQpyb3V0ZXIgZm9yIGV4YW1wbGUuIFdo
ZXJlYXMgUkFNIGlzIHF1aXRlIGNoZWFwIG5vd2FkYXlzLg0KDQo+PiBQbHVzLCBJIGRvbid0IHdh
bnQgdGhlIGNvbnNvbGUgc3Vic3lzdGVtIHRvIGRlcGVuZCBvbiBhbnkgZmlsZS9kaXNrDQo+PiBv
cGVyYXRpb25zL2RyaXZlcnMuDQo+IA0KPiBXZWxsLCB0aGUgY29uc29sZSB3b3VsZCBzdGlsbCB3
b3JrIGFzIHVzdWFsIGV2ZW4gaWYgbG9nZ2luZyB0byBkaXNrIA0KPiB3b3VsZCBmYWlsIGZvciBh
bnkgcmVhc29uLCB3aGljaCBpcyBzaW1pbGFyIHRvIHRoZSBzZXJpYWwgY29uc29sZSBzdGlsbCAN
Cj4gd29ya2luZyBpZiB0aGUgZ3JhcGhpY2FsIGNvbnNvbGUgZmFpbHMuwqAgTW9yZW92ZXIsIGlm
IHRoZSBkaXNrIGZhaWxzLCANCj4gdGhlIHN5c3RlbSBpc24ndCBiZSBhYmxlIHRvIGJvb3QsIHNv
IGFueSBSQU0tYmFzZWQgY29uc29sZSBsb2dzIHdvdWxkIGJlIA0KPiBsb3N0IGluIHRoYXQgY2Fz
ZS7CoCBBbGwgdGhpcyBtYWtlcyB0aGUgUkFNLWJhc2VkIGxvZ2dpbmcgbm8gbW9yZSANCj4gcmVz
aWxpZW50IHRvIGRpc2sgZmFpbHVyZXMuDQoNCkNvcnJlY3Rpb246IGlmIGRpc2sgKnJlYWRzKiBm
YWlsLCBhcyB3ZWxsIGFzIHdyaXRlcywgdGhlbiB0aGUgc3lzdGVtIA0Kd2lsbCBub3QgYm9vdC4g
SG93ZXZlciwgdHlwaWNhbCBmYWlsdXJlIG9mIEZsYXNoIG1lZGlhIGlzIHRoYXQgaXQgDQpiZWNv
bWVzIHJlYWQtb25seS4NCg0KPiBJIHN0aWxsIHRoaW5rIHRoYXQgdXNpbmcgZGlzay1iYXNlZCBw
c3RvcmUgaXMgYSBiZXR0ZXIgb3B0aW9uLsKgIEp1c3QgYXMgDQo+IHlvdSBkb24ndCB3YW50IHRv
IHdlYXIgb3V0IHlvdXIgZmxhc2ggZGlza3Mgd2l0aCAzMC00MCBLQiBvZiBkYXRhLCBJIA0KPiBh
bHNvIGRvbid0IHdhbnQgdG8gd2FzdGUgMzAtNDAgS0Igb2YgUkFNLg0KDQpBcyBJIHNhaWQsIHlv
dSBjb3VsZCBqdXN0IHVubG9hZCB0aGUgbG9nIGFmdGVyIHlvdSdyZSBkb25lIHByb2Nlc3Npbmcg
DQppdC4gNDAgS0IgUkFNIGlzIGxlc3MsIHRoYW4gd2hhdCBgc3NoZGAgdXNlcywgZm9yIGluc3Rh
bmNlICg4NjBrIG9uIG15IA0KbGFwdG9wLCBidXQgaXQgY2FuIHByb2JhYmx5IGJlIGxlc3MsIG1h
eWJlIGV2ZW4gMTB4IGxlc3MsIHNvIDgwLTkwaz8pLCANCnNvIHlvdSBjb3VsZCwgaW4geW91ciBp
bml0LCBwcm9jZXNzIHRoZSBpbi1SQU0gbG9nLCB0aGVuIHVubG9hZCBpdCwgdGhlbiANCnN0YXJ0
IHlvdXIgb3RoZXIgc2VydmljZXMsIHRoZXJlYnkgcmVjbGFpbWluZyB0aGF0IFJBTS4NCg0KPiBB
bHNvLCBlbWJlZGRlZCBkZXZpY2VzIHN1Y2ggDQo+IGFzIHRoZSBQaW5lUGhvbmUgd291bGQgYmVu
ZWZpdCBhZGRpdGlvbmFsbHkgZnJvbSB1c2luZyBkaXNrLWJhc2VkIA0KPiBsb2dnaW5nLCBiZWNh
dXNlIHBlb3BsZSBvZnRlbiBjYW4ndCBkbyBhbnl0aGluZyBpbiB0aGUgZmllbGQgaWYgYm9vdGlu
ZyANCj4gZmFpbHMgZm9yIHNvbWUgcmVhc29uLCBzbyBSQU0tYmFzZWQgbG9ncyB3b3VsZCBlbmQg
dXAgYmVpbmcgbG9zdCwgDQo+IHByZXZlbnRpbmcgYW55IHBvc3QtbW9ydGVtIGRlYnVnZ2luZyBs
YXRlci4NCg0KUG9zdC1tb3J0ZW0gYW5hbHlzaXMgY291bGQgYmUgaW50ZXJlc3RpbmcsIHRydWUu
DQoNCj4gUGVyaGFwcyB3ZSBjYW4gYWN0dWFsbHkgb2ZmZXIgYm90aCBvcHRpb25zLCBpLmUuIGJv
dGggbG9nZ2luZyB0byBSQU0gYW5kIA0KPiB0byBkaXNrLCBzbyBldmVyeW9uZSBjYW4gY2hvb3Nl
IHdoYXQgdGhleSBwcmVmZXIuwqAgSSdkIGFsc28gYmUgZmluZSB3aXRoIA0KPiB3b3JraW5nIG9u
IHN1Y2ggYSBkdWFsIGFwcHJvYWNoLCBidXQgaXQgd291bGQgb2J2aW91c2x5IGJlIG1vcmUgY29t
cGxleC4NCg0KUGVyaGFwcyB0aGF0IGlzIHRoZSBiZXN0IG9wdGlvbi4gQnV0LCBhcyBTZWFuIGhh
cyBwb2ludGVkIG91dCwgVS1Cb290IA0KZG9lc24ndCBzdXBwb3J0IGRpc2stYmFja2VkIFBTdG9y
ZSBhbnl3YXlzLi4uIFNvIHRoZW4sIHNob3VsZCB3ZSANCmltcGxlbWVudCBSQU0tYmFzZWQgUFN0
b3JlIHdyaXRpbmcgZm9yIHRoZSB0aW1lIGJlaW5nLCBhbmQgdGhlbiBtYXliZSANCmV4cGFuZCBp
dCBsYXRlcj8NCg0KQmVuY2UNCg==

