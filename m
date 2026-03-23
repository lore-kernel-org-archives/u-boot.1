Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9907F483CC
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 16:49:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90317841C8;
	Mon, 23 Mar 2026 17:49:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="WL9cWmHU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CB2F8410D; Mon, 23 Mar 2026 17:49:22 +0100 (CET)
Received: from mx2.securetransport.de (mx2.securetransport.de
 [IPv6:2a03:4000:13:6c7::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2D5984213
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 17:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1774284553;
 bh=oq0gW3xMHLhBzWcIOXvLP51SObG7RmbihLdgekJaq9A=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=WL9cWmHU5QdY9uQwTYYmaokjwb9M46H7JzbCAcXXS/wmDfi9+cIlkqx4OZNsJgEaH
 E8qr8CzuWzlFkYm7Xy+TZ+GltoUfmNAsT9ZEjqVwNXFiGPUww24a+tmY1rv5G7Ax7q
 4nWt+pz6vUQJf6jpk69O0kAxwuBbn8xAnoRFXQiIs+/+XvydtxBrYeeOnjI2+/jte7
 q8D3jUB6ccDTwRPSDE7fcG92U1B7prH8c587PSpz43uPjK7OzSX240OXHocpdYgqvF
 zEj8XYQEkO6JkbEjXMOCgX1kfq6J/JkTbxMtMg5mYRw38D5HKyeiZlYmQqrHgzcXFv
 HTOckTQy3JG4A==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Marek Vasut <marex@nabladev.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini
 <trini@konsulko.com>, u-boot <u-boot@dh-electronics.com>
Subject: RE: [PATCH] board: dhelectronics: imx: Use second Ethernet MAC also
 from fuse
Thread-Topic: [PATCH] board: dhelectronics: imx: Use second Ethernet MAC also
 from fuse
Thread-Index: AQHcuFTCAYeM+Dh5A0K4haKIts4CsrW3q5OAgAHGg1CAACS3gIACOHIAgABacoCAACH7kA==
Date: Mon, 23 Mar 2026 16:49:08 +0000
Message-ID: <a7ebfe912f084176b79c54a2e9e3d8e3@dh-electronics.com>
References: <20260320102918.4011-1-cniedermaier@dh-electronics.com>
 <382f338c-020f-482d-80b8-5a39ad724843@nabladev.com>
 <b443e161b5db4abab8d8889135a345fa@dh-electronics.com>
 <941708e9-a2e6-4f8d-a15d-d1da8a91ae91@nabladev.com>
 <2eebac26eff54f9da7e2d01dbca71569@dh-electronics.com>
 <a40a11f9-f3f5-4eee-ab6e-c2597808c471@nabladev.com>
In-Reply-To: <a40a11f9-f3f5-4eee-ab6e-c2597808c471@nabladev.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
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

RnJvbTogTWFyZWsgVmFzdXQgPG1hcmV4QG5hYmxhZGV2LmNvbT4NClNlbnQ6IE1vbmRheSwgTWFy
Y2ggMjMsIDIwMjYgMzo1OSBQTQ0KPiBPbiAzLzIzLzI2IDExOjA3IEFNLCBDaHJpc3RvcGggTmll
ZGVybWFpZXIgd3JvdGU6DQo+IA0KPiBbLi4uXQ0KPiANCj4+PiBUaGUgcHJpb3JpdHkgaXMgdGhp
czoNCj4+PiAtIEVOViAtLSBiZWNhdXNlIHVzZXIgY2FuIG92ZXJyaWRlIHRoZSBjb250ZW50LCBh
bmQgdXNlciBvdmVycmlkZSBpcw0KPj4+IGhpZ2hlc3QgcHJpbw0KPj4+IC0gRGV2aWNlIG5vdCBl
bmFibGVkIGluIERULCBkbyBub3RoaW5nDQo+Pj4gLSBGdXNlcywgKG5ld2x5IGZpcnN0IGZ1c2Ug
YmxvY2sgMSAsIHRoZW4pIGZ1c2UgYmxvY2sgMCAtLSBiZWNhdXNlDQo+Pj4gaW4tU29DIGZ1c2Vz
IGFsd2F5cyBoYXZlIHRvIHRha2UgcHJlY2VkZW5jZSBvdmVyIHRoZSBleHRlcm5hbCBFRVBST00N
Cj4+PiAtIEVFUFJPTSwgZmlyc3QgYmxvY2sgMSwgdGhlbiBibG9jayAwIC0tIGJlY2F1c2UgdGhp
cyBpcyB3aGF0IGlzIHVzdWFsbHkNCj4+PiBwcm9ncmFtbWVkIG91dCBvZiBmYWN0b3J5LCBhbnl0
aGluZyBoaWdoZXIgcHJpb3JpdHkgaXMgdXAgdG8gdGhlIHVzZXINCj4+DQo+PiBUaGUgU29NIGlz
IGRlbGl2ZXJlZCB3aXRoIGJvdGggTUFDIGFkZHJlc3NlcyBjb21pbmcgZnJvbSBESCBlbGVjdHJv
bmljcyBwcm92aWRlZA0KPj4gYnkgRUVQUk9Ncy4gSWYgYSBjdXN0b21lciB3YW50cyBoaXMgb3du
IE1BQywgdGhleSBjYW4gZnVzZSB0aGUgTUFDIGFkZHJlc3MgdG8NCj4+IG92ZXJyaWRlIGl0IHBl
cm1hbmVudGx5LCBidXQgcmVmZXJyaW5nIHRvIHlvdXIgc3VnZ2VzdGlvbiBpZiB0aGUgY3VzdG9t
ZXIgb25seQ0KPj4gZnVzZSBvbmUgTUFDIGFkZHJlc3MgdGhlIGJlaGF2aW9yIGRlcGVuZHMgb24g
d2hpY2ggTUFDIGFkZHJlc3MgaXMgZnVzZWQuDQo+Pg0KPj4gRnVzZSBvbmx5IHRoZSBmaXJzdCBN
QUMgYWRkcmVzczoNCj4+IC0gMS4gRXRoZXJuZXQ6IE1BQyBpcyB0YWtlbiBmcm9tIEZVU0UgMA0K
Pj4gLSAyLiBFdGhlcm5ldDogTUFDIGlzIHRha2VuIGZyb20gRlVTRSAwICsgaW5jcmVtZW50ZWQg
Ynkgb25lDQo+Pg0KPj4gRnVzZSBvbmx5IHRoZSBzZWNvbmQgTUFDIGFkZHJlc3M6DQo+PiAtIDEu
IEV0aGVybmV0OiBNQUMgaXMgdGFrZW4gZnJvbSBFRVBST00NCj4+IC0gMi4gRXRoZXJuZXQ6IE1B
QyBpcyB0YWtlbiBmcm9tIEZVU0UgMQ0KPj4NCj4+IFRoZSBwcm9ibGVtIGlzIHRoYXQgd2UgaGF2
ZSBhIGN1c3RvbWVyIHdpdGggU29NcyB3aGVyZSBvbmx5IHRoZSBmaXJzdCBNQUMgYWRkcmVzcw0K
Pj4gd2FzIHNlcXVlbnRpYWxseSBmdXNlZCBmcm9tIGEgTUFDIGFkZHJlc3MgcG9vbC4gVGhhdCBt
ZWFucyB0aGUgc2Vjb25kIE1BQyBhZGRyZXNzDQo+PiBvZiB0aGUgU29NIGlzIHRoZSBzYW1lIE1B
QyBhZGRyZXNzIGFzIHRoZSBNQUMgYWRkcmVzcyBmcm9tIHRoZSBuZXh0IFNvTSdzIGZpcnN0DQo+
PiBNQUMgYWRkcmVzcy4gVGhpcyBwYXRjaCBwcmV2ZW50cyB0aGlzIGJ5IHNldHRpbmcgdGhlIE1B
QyBhZGRyZXNzZXMgaW5kZXBlbmRlbnRseQ0KPj4gb2Ygb25lIGFub3RoZXIuIFRoZW4gZm9yIHRo
ZSBzZWNvbmQgTUFDIGFkZHJlc3MgdGhlIERIIGVsZWN0cm9uaWNzIE1BQyBmcm9tIHRoZQ0KPj4g
RUVQUk9NIGlzIHVzZWQuIEluIHRoaXMgcGF0Y2ggdGhlIGZhbGxiYWNrIHdoZXJlIHRoZSBmaXJz
dCBNQUMgYWRkcmVzcyBpbmNyZW1lbnRlZA0KPj4gYnkgb25lIGlzIHVzZWQgc2hvdWxkIG5vdCBv
Y2N1ciBvbiB0aGUgY3VzdG9tZXIgc2lkZSwgYXMgdGhlIFNvTXMgYXJlIHNoaXBwZWQgd2l0aA0K
Pj4gTUFDIGFkZHJlc3NlcyBpbiB0aGUgRUVQUk9Ncy4gSWYgdGhpcyBkb2VzIG9jY3VyLCBob3dl
dmVyIGR1ZSB0byBhbiBFRVBST00gcmVhZA0KPj4gZXJyb3Igb3Igd2hhdGV2ZXIgdGhpcyBwYXRj
aCBjb3VsZCBiZSBpbXByb3ZlZCBieSBhIHdhcm5pbmcgbWVzc2FnZS4NCj4gSSBkb24ndCB1bmRl
cnN0YW5kIHRoaXMgbGFzdCBzZW50ZW5jZSwgY2FuIHlvdSBwbGVhc2UgcmVwaHJhc2UgPyBLZWVw
IGluDQo+IG1pbmQsIG5vdCBhbGwgTVg4TVAgREhDT00gd2VyZSBwb3B1bGF0ZWQgd2l0aCBib3Ro
IEVFUFJPTXMsIHRoZSByZXYuMTAwDQo+IG9ubHkgaGFkIG9uZSBFRVBST00gb24gdGhlbS4NCg0K
T24gdGhlIHJldi4xMDAgdGhlIGFtb3VudCBvZiBwb3B1bGF0ZWQgRUVQUk9NIGRlcGVuZHMgb24g
dGhlIG51bWJlciBvZiBFdGhlcm5ldA0KaW50ZXJmYWNlcy4gT25lIEV0aGVybmV0IGludGVyZmFj
ZSBtZWFucyBvbiBFRVBST00gaXMgcG9wdWxhdGVkIGFuZCBvbiBhIFNvTQ0Kd2l0aCB0d28gRXRo
ZXJuZXQgaW50ZXJmYWNlcyB0d28gRUVQUk9NIGFyZSBwb3B1bGF0ZWQuIFRoZSBTb01zIHdpdGgg
dHdvIEV0aGVybmV0DQppbnRlcmZhY2VzLCBpbiB3aGljaCBvbmx5IG9uZSBFRVBST00gd2FzIHBv
cHVsYXRlZCwgd2VyZSBwcm90b3R5cGUgY29uZmlndXJhdGlvbnMuDQpUaGlzIGlzIG5vIGxvbmdl
ciB0aGUgY2FzZSBpbiB0aGUgcHJvZHVjdGlvbiBzZXJpZXMuIFRoaXMgZmFsbGJhY2sgY2FuIHRo
ZXJlZm9yZQ0KYmUgcmVtb3ZlZC4NCkluIHRoZSBsYXN0IHNlbnRlbmNlIEkgbWVhbiBpZiB0aGUg
RUVQUk9NIGNhbid0IHByb3ZpZGUgYSBNQUMgYWRkcmVzcyBpdCBpcyBhbg0KaW5kaWNhdGlvbiB0
aGF0IHNvbWV0aGluZyBnb2VzIHdyb25nIGFuZCBpZiB0aGUgTUFDIGFkZHJlc3MgZnJvbSB0aGUg
Zmlyc3QgTUFDDQpmdXNlIGluY3JlbWVudGVkIGJ5IG9uZSBpcyB1c2VkIGEgbWVzc2FnZSBjb3Vs
ZCBiZSBkaXNwbGF5ZWQgdG8gaW5mb3JtIGFib3V0DQp0aGF0Lg0KDQo+IEFzIGZvciB0aGUgcmVz
dCwgaXQgcmVhbGx5IGJvaWxzIGRvd24gdG8gdGhlIG9yZGVyaW5nIG9mIGZhbGxiYWNrcywgaXQN
Cj4gaXMgZWl0aGVyOg0KPiANCj4gQSkNCj4gZnVzZTENCj4gZWVwcm9tMQ0KPiBmdXNlMCsxDQo+
IGVlcHJvbTArMQ0KPiANCj4gb3INCj4gDQo+IEIpDQo+IGZ1c2UxDQo+IGZ1c2UwKzENCj4gZWVw
cm9tMQ0KPiBlZXByb20wKzENCj4gDQo+IFRoZSBmb2xsb3dpbmcgb3JkZXJpbmcsIHdoaWNoIGlz
IHRoZSBvcmRlcmluZyBpbnRyb2R1Y2VkIGJ5IHRoaXMgcGF0Y2gsDQo+IGlzIGNvbmZ1c2luZzoN
Cj4gDQo+IGZ1c2UxDQo+IGVlcHJvbTENCj4gZWVwcm9tMCsxDQo+IGZ1c2UwKzENCj4gDQo+IFNv
IHBsZWFzZSBwaWNrIGVpdGhlciBBKSBvciBCKSBhYm92ZS4gSSBkbyBub3Qgc2VlIGFueSBwYXJ0
aWN1bGFyDQo+IGFkdmFudGFnZSBvZiBlaXRoZXIgb2YgdGhlIG90aGVyLCBleGNlcHQgbWF5YmUg
QikgaW1wcm92ZXMgYm9vdCB0aW1lIGluDQo+IGNhc2UgYm90aCBmdXNlIGJsb2NrcyBhcmUgYmxv
d24sIGJlY2F1c2UgaXQgYXZvaWRzIHRoZSBFRVBST00gSTJDIGFjY2Vzcy4NCg0KVGhlIHByZXZl
bnRpb24gb2YgSTJDIGFjY2VzcyBpcyBvbmx5IGEgb25lIHRpbWUgZWZmZWN0LCBiZWNhdXNlIHRo
ZW4gdGhlDQpNQUMgYWRkcmVzc2VzIHdpbGwgcHJvdmlkZWQgYnkgdGhlIGVudmlyb25tZW50Lg0K
DQpJZiBJIHJlbW92ZSB0aGUgZWVwcm9tMCsxLCBiZWNhdXNlIGl0IHdhcyBmb3IgcHJvdG90eXBl
IGNvbmZpZ3VyYXRpb25zLA0KbXkgcHJlZmVycmVkIG9yZGVyIHdvdWxkIGJlOg0KDQpmdXNlMQ0K
ZWVwcm9tMQ0KZnVzZTArMQ0KDQoNClJlZ2FyZHMNCkNocmlzdG9waA0K
