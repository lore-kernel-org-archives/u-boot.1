Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD08EC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 12:14:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1CF187775;
	Wed, 20 Dec 2023 13:13:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=prolan.hu header.i=@prolan.hu header.b="Vu7kK27n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 248B48715C; Wed, 20 Dec 2023 07:49:40 +0100 (CET)
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05DAB8700D
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 07:49:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Csokas.Bence@prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain
 [127.0.0.1])
 by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 66290A182C;
 Wed, 20 Dec 2023 07:49:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
 :cc:content-id:content-transfer-encoding:content-type
 :content-type:date:from:from:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=mail; bh=FEeWEGU+g
 Jm9bOGyjHcS1z7/+ylLbmWTWPoik3rD/U4=; b=Vu7kK27nqybLMC2vDngGrJb6s
 qfWG620mYROVVafuch/eKEGq9TNERVnNfMOizvuyz04ng92YJHBI9smaVygyZaRd
 njjGKOrpM2oTIUKuo9UH6HecmYXngjHgwAjttt+8JxIIWQDTbVn/OWBXALS2HKh6
 oJier1eH1DTeny6QgiQDs8gc7ZmEgOFDaWtcNVcy/XW16qWbeMkPSKwgk5/Qc1Le
 A3p4/xyCbOkOO7R6GUul5IEI5bRkqXEVFtCLoOUVlqSGLSBQDOKEHA1IScBrwGql
 0GQ2rgzooAHmKVLFmWhRd1U86OLpZAKTFFh13r8kX8fMi75vttnMaHvrfIi4iznj
 koS6Ws3sQq2thqTSliX0nHbuoPdRWQ78aKLXVHA4ALENOIIH6lx+QDCtKgR6WrlG
 h9K2njrv9Hb8xu0rpJgpqwRGFgvqGOvqmSSlC6Y8uc9g+BolagWR8jAUbZ5sS2ue
 PcBOhl+PxXfqKjH2EWiZCMwVdOP0Lx5IZ3PeYyA/Yhn2SUIPPxzEA9lA4JdzG7Uh
 Sm/a13mhI/AE5IjYyExlkSs3Vq4MIIC330rX30s9aXEwCdy9SQRGCD/WeR4o/L6+
 PWBXnE34rT3INgGKA7uuIw/KbLUoPjryXtg/H3kSE2C/vsBtcXYPkamVDxVgA1T5
 20y0UG0mAk9jjCYWiA=
From: =?utf-8?B?Q3PDs2vDoXMgQmVuY2U=?= <Csokas.Bence@prolan.hu>
To: Dragan Simic <dsimic@manjaro.org>, Sean Anderson <seanga2@gmail.com>
CC: Simon Glass <sjg@chromium.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Daniel Golle <daniel@makrotopia.org>
Subject: Re: Passing boot logs to Linux?
Thread-Topic: Passing boot logs to Linux?
Thread-Index: AQHaMrctQ91qLkCwS0+C38IRePG/PrCxfvIAgAAJqQCAAAUhAIAAHXMA
Date: Wed, 20 Dec 2023 06:49:35 +0000
Message-ID: <51121aee-faca-4196-8532-719fb6ec9bdc@prolan.hu>
References: <6fd0dd4c-4bce-47cf-a669-7d093b9a1f10@prolan.hu>
 <CAPnjgZ01=y-Kf=XmDv6UyEdPgXLp8bhZnSZDBVk1FPfBh8CdOw@mail.gmail.com>
 <6ae238be-3c5f-5ef6-9e18-282be9ae24c2@gmail.com>
 <16e633f9d4b1c426aaca510157479d65@manjaro.org>
In-Reply-To: <16e633f9d4b1c426aaca510157479d65@manjaro.org>
Accept-Language: hu-HU, en-US
Content-Language: hu-HU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [152.66.192.27]
x-esetresult: clean, is OK
x-esetid: 37303A29916D385C6C7566
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4B6AF47166B3C4FA9508CA11C52B9B5@prolan.hu>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 20 Dec 2023 13:13:44 +0100
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

T24gMjAyMy4gMTIuIDE5LiAyMTozMywgRGFuaWVsIEdvbGxlIHdyb3RlOg0KPiBIaSBCZW5jZSwN
Cj4NCj4gT24gVHVlLCBEZWMgMTksIDIwMjMgYXQgMDg6MDg6NDhQTSArMDAwMCwgQ3PDs2vDoXMg
QmVuY2Ugd3JvdGU6DQo+PiBIaSENCj4+DQo+PiBJcyBwYXNzaW5nIHRoZSBVLUJvb3QgYm9vdCBs
b2cgdG8gTGludXggc3VwcG9ydGVkIHlldD8gV2UgYXJlIHdvcmtpbmcNCj4+IHdpdGggYSB0aGly
ZC1wYXJ0eSBzb2x1dGlvbiwgd2hpY2ggd29ya3MsIGJ1dCBpcyBhIGJpdCBoYWNreSwgc28gSSB3
YXMNCj4+IHdvbmRlcmluZyBpZiBhbiBvZmZpY2lhbCBzb2x1dGlvbiBoYXMgYmVlbiBtZXJnZWQg
eWV0Lg0KPj4NCj4+IEkgc2F3IHRoYXQgdGhlcmUgd2FzIGFuIG9wdGlvbiBDT05GSUdfQ09OU09M
RV9SRUNPUkQgdGhhdCBzYXZlcw0KPj4gZXZlcnl0aGluZyB0byBhIG1lbWJ1ZmYsIGJ1dCBJIGRv
bid0IGtub3cgaWYgdGhhdCBjYW4gYmUgZXhwb3J0ZWQgdG8NCj4+IExpbnV4IHlldC4gQW5kIGlm
IG5vdCBpbiB0aGUgdHJlZSB5ZXQsIHdvdWxkIHN1Y2ggYSBwYXRjaCBiZSB3ZWxjb21lPw0KPiBU
byBtZSB0aGlzIHNvdW5kcyB2ZXJ5IHVzZWZ1bCBhbmQgZGVmaW5pdGVseSBzb21ldGhpbmcgd2Un
ZCBsaWtlIHRvDQo+IGhhdmUgaW4gT3BlbldydC4gU28gSSdkIHZvbHVudGVlciB0byByZXZpZXcg
YW5kIHRlc3QgeW91ciBwYXRjaGVzIG9uY2UNCj4gdGhleSBhcmUgcmVhZHkuDQo+DQo+IFdoYXQg
Y29tZXMgdG8gbWluZCBpcyB0aGF0IENPTkZJR19DT05TT0xFX1JFQ09SRCBhbHNvIGNhcHR1cmVz
IEFOU0kNCj4gc2VxdWVuY2VzIGR1cmluZyBtZW51IG9yIGNvdW50LWRvd24gYmVmb3JlIGJvb3Qs
IHNvIHdlJ2QgaGF2ZSB0byBlaXRoZXINCj4gaW50cm9kdWNlIGEgZGVkaWNhdGVkIGxvZ19wcmlu
dGYoKSBjYWxsIGFuZCB1c2UgdGhhdCB3aGVuIGV2ZXIgd2Ugd2FudA0KPiB0aGUgb3V0cHV0IHRv
IGFsc28gYmVjb21lIHBhcnQgb2YgdGhlIGxvZyBidWZmZXIgb3Igd2UgY291bGQgc29tZWhvdw0K
PiBmaWx0ZXIgdGhlIHJlY29yZGVkIGNvbnNvbGUsIGVsaW1pbmF0aW5nIGFsbCB0ZXJtaW5hbCBj
b250cm9sIHNlcXVlbmNlcy4NCj4NCj4NCj4gQ2hlZXJzDQo+DQo+DQo+IERhbmllbA0KPg0KDQpJ
IGRvbid0IHRoaW5rIHRoYXQgd291bGQgYmUgYSBodWdlIHByb2JsZW0sIExpbnV4IHVzZXJzcGFj
ZSBjYW4gZmlsdGVyIA0KQU5TSSBjb250cm9sIGNvZGVzIGlmIGl0IHdhbnRzIHRvLiBGb3Igbm93
LCBJJ2QgbGlrZSBhIGJ5dGUtZm9yLWJ5dGUgDQpjb3B5IG9mIHRoZSBjb25zb2xlLCBhcy1pcywg
cHJlc2VudGVkIHRvIExpbnV4Lg0KDQpPbiAyMDIzLiAxMi4gMjAuIDY6MDQsIERyYWdhbiBTaW1p
YyB3cm90ZToNCj4gT24gMjAyMy0xMi0yMCAwNTo0NSwgU2VhbiBBbmRlcnNvbiB3cm90ZToNCj4+
IE9uIDEyLzE5LzIzIDIzOjExLCBTaW1vbiBHbGFzcyB3cm90ZToNCj4+PiBPbiBUdWUsIDE5IERl
YyAyMDIzIGF0IDEzOjE1LCBDc8Oza8OhcyBCZW5jZSA8Q3Nva2FzLkJlbmNlQHByb2xhbi5odT4g
DQo+Pj4gd3JvdGU6DQo+Pj4+IElzIHBhc3NpbmcgdGhlIFUtQm9vdCBib290IGxvZyB0byBMaW51
eCBzdXBwb3J0ZWQgeWV0PyBXZSBhcmUgd29ya2luZw0KPj4+PiB3aXRoIGEgdGhpcmQtcGFydHkg
c29sdXRpb24sIHdoaWNoIHdvcmtzLCBidXQgaXMgYSBiaXQgaGFja3ksIHNvIEkgd2FzDQo+Pj4+
IHdvbmRlcmluZyBpZiBhbiBvZmZpY2lhbCBzb2x1dGlvbiBoYXMgYmVlbiBtZXJnZWQgeWV0Lg0K
Pj4+Pg0KPj4+PiBJIHNhdyB0aGF0IHRoZXJlIHdhcyBhbiBvcHRpb24gQ09ORklHX0NPTlNPTEVf
UkVDT1JEIHRoYXQgc2F2ZXMNCj4+Pj4gZXZlcnl0aGluZyB0byBhIG1lbWJ1ZmYsIGJ1dCBJIGRv
bid0IGtub3cgaWYgdGhhdCBjYW4gYmUgZXhwb3J0ZWQgdG8NCj4+Pj4gTGludXggeWV0LiBBbmQg
aWYgbm90IGluIHRoZSB0cmVlIHlldCwgd291bGQgc3VjaCBhIHBhdGNoIGJlIHdlbGNvbWU/DQo+
Pj4NCj4+PiBOb3QgeWV0LCBidXQgeWVzIEkgd291bGQgbGlrZSB0byBzZWUgdGhpcy4NCj4+DQo+
PiBJIHRoaW5rIG1vc3Qgb2YgdGhlIGluZnJhc3RydWN0dXJlIGlzIGFscmVhZHkgaGVyZS4gV2Ug
Y291bGQgdXNlIGVpdGhlcg0KPj4gY29uc29sZSByZWNvcmRpbmcgKGFzIG1lbnRpb25lZCBhYm92
ZSksIHdoaWNoIGlzIG1vcmUgY29tcGxldGUsIG9yIGEgbmV3DQo+PiBMT0dfRFJJVkVSICh3aGlj
aCB3b3VsZCBoYXZlIHRoZSBhZHZhbnRhZ2Ugb2Ygb21pdHRpbmcgdGhpbmdzIGxpa2UgDQo+PiBj
b3VudGRvd25zKS4NCj4+DQo+PiBJbiB0ZXJtcyBvZiBzZW5kaW5nIHRoaW5ncyB0byBMaW51eCwg
SSB0aGluayB0aGUgbmF0dXJhbCBjaG9pY2Ugd291bGQgDQo+PiBiZSBwc3RvcmUsDQo+PiB3aGlj
aCB3ZSBhbHJlYWR5IGhhdmUgYSBwYXJzZXIgZm9yLg0KPg0KPiBZZXMsIHVzaW5nIHBzdG9yZSB3
b3VsZCBtYWtlIHNlbnNlLg0KPg0KPiBBcyBhIG5vdGUsIEknbSB3aWxsaW5nIHRvIHdvcmsgb24g
dGhpcywgaWYgQ3PDs2vDoXMgYWN0dWFsbHkgZG9lc24ndCANCj4gcGljayBpdCB1cC7CoCBJJ2xs
IGJlIHNvIGhhcHB5IHRvIHNlZSB0aGlzIGZlYXR1cmUgcmVhY2hpbmcgYWxsIGtpbmRzIA0KPiBv
ZiBib2FyZHMgYW5kIGRldmljZXMuDQo+DQpBcyBJIHVuZGVyc2FuZCAobmV2ZXIgdXNlZCBpdCBi
ZWZvcmUsIGp1c3QgcXVpY2tseSByZWFkIHRoZSBrZXJuZWwgZG9jKSwgDQpQU3RvcmUgaXMgZm9y
IExpbnV4IC0+IFUtQm9vdCBjb21tdW5pY2F0aW9uLiBXaGF0IEknbSBkb2luZyBpcyB0aGUgDQpv
cHBvc2l0ZS4gQnV0IHRoZSBhcHByb2FjaCBJIGVudmlzaW9uZWQgaXMgc2ltaWxhcjogbWFrZSBV
LUJvb3Qgc2F2ZSBhIA0KY29weSBvZiB0aGUgbG9nIHRvIGEgc3RydWN0IGF0IGEgZml4ZWQgbWVt
b3J5IGFkZHJlc3MsIHRoZW4gcGFzcyB0aGlzIA0KYWRkcmVzcyArIHRoZSBsZW5ndGggb2YgdGhl
IGxvZyB0byB0aGUga2VybmVsIHZpYSBEVCBhbmQvb3IgY29tbWFuZGxpbmUuDQoNCg0KV2hhdCBJ
IHRob3VnaHQgdG8gaW5jbHVkZSBpbiB0aGUgc3RydWN0Og0KDQoqIG1hZ2ljIGNvb2tpZSAoaXQg
d2FzIGluIHRoZSAzcmQgcGFydHkgc29sdXRpb24sIGFuZCBpdCdzIGFuIGVhc3kgd2F5IA0Kb2Yg
ZG9pbmcgc29tZSBmb3JtIG9mIGludGVncml0eSBjaGVjaykNCg0KKiBzdHJ1Y3QgdmVyc2lvbiAo
aW4gY2FzZSB3ZSBldmVyIGNoYW5nZSB0aGUgbGF5b3V0KQ0KDQoqIFUtQm9vdCB2ZXJzaW9uIGNv
ZGUgKG1heWJlIG5vdCBuZWNlc3Nhcnk/IEl0IGNhbiBiZSBwYXJzZWQgb3V0IG9mIHRoZSANCmxv
ZyBhcyB3ZWxsKQ0KDQoqIGxlbmd0aCBvZiB0aGUgbG9nIChvciBpdCBjb3VsZCBhbHNvIGJlIHBh
c3NlZCB2aWEgRFQvY21kbGluZSkNCg0KKiBhbmQgdGhlbiB0aGUgbG9nIGJ1ZmZlciBvZiBjb3Vy
c2UNCg0KDQpCZW5jZQ0KDQo=

