Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5AEFF60F1
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 09:19:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D218683F0A;
	Tue, 31 Mar 2026 11:19:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="xqSDza3d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AF5B83F5B; Tue, 31 Mar 2026 11:19:50 +0200 (CEST)
Received: from mx3.securetransport.de (mx3.securetransport.de
 [IPv6:2a01:4f8:c0c:92be::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FB3583E7A
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 11:19:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1774948777;
 bh=uzPvl0jseOjbvh+nEwMgcuzRvtc2sgZEjiq+MaUzZao=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=xqSDza3djEEJqXEZMSpUu6B9G9yXFKjTcp4On8XzxJy8S7F3o5E5NVyokrUohVN1e
 uE2nSVH9vFldQIOTdvhezAr2Q6F2hpNn0CnLzwydJapfpeLLg8RZSULj3PYbral35V
 Btw9EwEx8hyixVHZI/Xl4iFkU1UL42ejSaSucDA+oaFfQso4hD/pFc0b7V+2dmWUtm
 8R2lxfuODJU3N9qXXw+sbymIp0wnRVIxl4EK71dgYeY9TWQfE1ZzyxoiN4DVAGmdsj
 d0T/CsQwkgqP7RSeTgw7oxr/pYq2agmpOuGMf6XlZbNAAfZVg29vP+uMVNO8Iq1QVO
 7oxIjWvUQaSPQ==
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
Thread-Index: AQHcuFTCAYeM+Dh5A0K4haKIts4CsrW3q5OAgAHGg1CAACS3gIACOHIAgABacoCAACH7kIAABaOAgABQ+/CABlp8AIAFayOQ
Date: Tue, 31 Mar 2026 09:19:35 +0000
Message-ID: <61267e12e816481bb7192bb0a5a7b752@dh-electronics.com>
References: <20260320102918.4011-1-cniedermaier@dh-electronics.com>
 <382f338c-020f-482d-80b8-5a39ad724843@nabladev.com>
 <b443e161b5db4abab8d8889135a345fa@dh-electronics.com>
 <941708e9-a2e6-4f8d-a15d-d1da8a91ae91@nabladev.com>
 <2eebac26eff54f9da7e2d01dbca71569@dh-electronics.com>
 <a40a11f9-f3f5-4eee-ab6e-c2597808c471@nabladev.com>
 <a7ebfe912f084176b79c54a2e9e3d8e3@dh-electronics.com>
 <2dca42bf-a247-4190-9439-14e14f65aec3@nabladev.com>
 <3a8724ffe4fa44808ac8a278e4a702f7@dh-electronics.com>
 <03fd5ca1-6581-4c50-8d50-2cfae6d98683@nabladev.com>
In-Reply-To: <03fd5ca1-6581-4c50-8d50-2cfae6d98683@nabladev.com>
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

RnJvbTogTWFyZWsgVmFzdXQgPG1hcmV4QG5hYmxhZGV2LmNvbT4NClNlbnQ6IFNhdHVyZGF5LCBN
YXJjaCAyOCwgMjAyNiAxMjoxMiBBTQ0KPiBPbiAzLzI3LzI2IDExOjAyIFBNLCBDaHJpc3RvcGgg
TmllZGVybWFpZXIgd3JvdGU6DQo+PiBGcm9tOiBNYXJlayBWYXN1dCA8bWFyZXhAbmFibGFkZXYu
Y29tPg0KPj4gU2VudDogTW9uZGF5LCBNYXJjaCAyMywgMjAyNiA2OjIxIFBNDQo+Pj4gT24gMy8y
My8yNiA1OjQ5IFBNLCBDaHJpc3RvcGggTmllZGVybWFpZXIgd3JvdGU6DQo+Pj4NCj4+PiBbLi4u
XQ0KPj4+DQo+Pj4+PiBBcyBmb3IgdGhlIHJlc3QsIGl0IHJlYWxseSBib2lscyBkb3duIHRvIHRo
ZSBvcmRlcmluZyBvZiBmYWxsYmFja3MsIGl0DQo+Pj4+PiBpcyBlaXRoZXI6DQo+Pj4+Pg0KPj4+
Pj4gQSkNCj4+Pj4+IGZ1c2UxDQo+Pj4+PiBlZXByb20xDQo+Pj4+PiBmdXNlMCsxDQo+Pj4+PiBl
ZXByb20wKzENCj4+Pj4+DQo+Pj4+PiBvcg0KPj4+Pj4NCj4+Pj4+IEIpDQo+Pj4+PiBmdXNlMQ0K
Pj4+Pj4gZnVzZTArMQ0KPj4+Pj4gZWVwcm9tMQ0KPj4+Pj4gZWVwcm9tMCsxDQo+Pj4+Pg0KPj4+
Pj4gVGhlIGZvbGxvd2luZyBvcmRlcmluZywgd2hpY2ggaXMgdGhlIG9yZGVyaW5nIGludHJvZHVj
ZWQgYnkgdGhpcyBwYXRjaCwNCj4+Pj4+IGlzIGNvbmZ1c2luZzoNCj4+Pj4+DQo+Pj4+PiBmdXNl
MQ0KPj4+Pj4gZWVwcm9tMQ0KPj4+Pj4gZWVwcm9tMCsxDQo+Pj4+PiBmdXNlMCsxDQo+Pj4+Pg0K
Pj4+Pj4gU28gcGxlYXNlIHBpY2sgZWl0aGVyIEEpIG9yIEIpIGFib3ZlLiBJIGRvIG5vdCBzZWUg
YW55IHBhcnRpY3VsYXINCj4+Pj4+IGFkdmFudGFnZSBvZiBlaXRoZXIgb2YgdGhlIG90aGVyLCBl
eGNlcHQgbWF5YmUgQikgaW1wcm92ZXMgYm9vdCB0aW1lIGluDQo+Pj4+PiBjYXNlIGJvdGggZnVz
ZSBibG9ja3MgYXJlIGJsb3duLCBiZWNhdXNlIGl0IGF2b2lkcyB0aGUgRUVQUk9NIEkyQyBhY2Nl
c3MuDQo+Pj4+DQo+Pj4+IFRoZSBwcmV2ZW50aW9uIG9mIEkyQyBhY2Nlc3MgaXMgb25seSBhIG9u
ZSB0aW1lIGVmZmVjdCwgYmVjYXVzZSB0aGVuIHRoZQ0KPj4+PiBNQUMgYWRkcmVzc2VzIHdpbGwg
cHJvdmlkZWQgYnkgdGhlIGVudmlyb25tZW50Lg0KPj4+DQo+Pj4gV2hpY2ggaW5jcmVhc2VzIHRo
ZSBzeXN0ZW0gYm9vdCB0aW1lLCB3aGljaCBpcyB1bmRlc2lyZWQuDQo+Pg0KPj4gSWYgYSBjdXN0
b21lciBzZXF1ZW50aWFsbHkgZnVzZSBvbmx5IHRoZSBmaXJzdCBNQUMgYWRkcmVzcyBmcm9tIGEg
TUFDIGFkZHJlc3MNCj4+IHBvb2wuIFRoZW4gdGhlIHNlY29uZCBNQUMgYWRkcmVzcyBvZiB0aGUg
U29NIGlzIHRoZSBzYW1lIE1BQyBhZGRyZXNzIGFzIHRoZSBNQUMNCj4+IGFkZHJlc3MgZnJvbSB0
aGUgbmV4dCBTb00ncyBmaXJzdCBNQUMgYWRkcmVzcy4gVGhhdCBpcyB2ZXJ5IGJhZC4gV2l0aCB0
aGUgQSkNCj4+IGl0IGNhbiBiZSBhdm9pZGVkLCBiZWNhdXNlIHRoZSBzZWNvbmQgTUFDIGFkZHJl
c3MgdGhlbiBpcyB0YWtlbiBmcm9tIHRoZSBFRVBST00uDQo+IA0KPiBUaGlzIGVkZ2UgY2FzZSBj
YW4gYmUgZml4ZWQgb24gZmlyc3QgYm9vdCBpbiBhIGJvb3Qgc2NyaXB0LiBSZWFkIG91dCB0aGUN
Cj4gZnVzZSB1c2luZyAic2V0ZXhwciB2YXIgKmFkZHIiLCBkZXRlY3Qgd2hldGhlciB0aGUgZnVz
ZSBpcyBlbXB0eSB1c2luZw0KPiAiaWYgdGVzdCAuLi4iLCBhbmQgaWYgaXQgZW1wdHksIHRoZW4g
cG9wdWxhdGUgaXRzIGNvbnRlbnQgd2l0aCBFRVBST00NCj4gY29udGVudC4gVGhpcyBzYXZlcyB5
b3Ugb25lIGV4dHJhIEkyQyBvcGVyYXRpb24gb24gZXZlcnkgYm9vdCBhZnRlcndhcmQuDQoNCldp
dGggdGhlIHJpZ2h0IG9yZGVyIGFsbCB0eXBpY2FsIHNjZW5hcmlvcyBjYW4gYmUgY292ZXJlZCBh
bmQgYWxzbyB0aGUNCiJlZGdlIGNhc2UiIGlzIGF2b2lkZWQuDQoNCj4+IElmIEkgaGFkIHRvIGNo
b29zZSBiZXR3ZWVuIHJlZHVjaW5nIHRoZSBib290IHRpbWUgb25jZSBhbmQgcHJldmVudGluZyBw
b3RlbnRpYWwNCj4+IGR1cGxpY2F0ZSBNQUMgYWRkcmVzc2VzLCBJIHdvdWxkIHNheSB0aGF0IHBy
ZXZlbnRpbmcgcG90ZW50aWFsIGR1cGxpY2F0ZSBNQUMNCj4+IGFkZHJlc3NlcyBpcyB0aGUgYmV0
dGVyIG9wdGlvbi4gRnVydGhlcm1vcmUsIHRoZSBpc3N1ZSBvZiBkdXBsaWNhdGUgTUFDIGFkZHJl
c3Nlcw0KPj4gaW4gdGhlIHN5c3RlbSBpcyBub3QgYSBoeXBvdGhldGljYWwgc2NlbmFyaW8sIGl0
IGhhcyBhbHJlYWR5IG9jY3VycmVkIGluIHByYWN0aWNlLg0KPj4NCj4+Pj4gSWYgSSByZW1vdmUg
dGhlIGVlcHJvbTArMSwgYmVjYXVzZSBpdCB3YXMgZm9yIHByb3RvdHlwZSBjb25maWd1cmF0aW9u
cywNCj4+Pj4gbXkgcHJlZmVycmVkIG9yZGVyIHdvdWxkIGJlOg0KPj4+Pg0KPj4+PiBmdXNlMQ0K
Pj4+PiBlZXByb20xDQo+Pj4+IGZ1c2UwKzENCj4+PiBlZXByb20wIGNhbiBub3QgYmUgcmVtb3Zl
ZCwgdGhhdCBicmVha3MgYmFja3dhcmQgY29tcGF0aWJpbGl0eS4gQW5kIHRoZQ0KPj4+IG9yZGVy
aW5nIG9mIGZ1c2UtZWVwcm9tLWZ1c2UgaXMgY29uZnVzaW5nIGFuZCBoYXMgdGhlIGJvb3QgdGlt
ZSBpbmNyZWFzZQ0KPj4+IGRvd25zaWRlIG9mIEEpLg0KPj4NCj4+IEZvciB3aGljaCBTb00gc2hv
dWxkIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgYmUgbWFpbnRhaW5lZCBoZXJlLiBUaGVyZSBpcw0K
Pj4gbm8gU29NIGF0IHRoZSBjdXN0b21lcidzIHNpdGUgd2hlcmUgaXQgaXMgcmVxdWlyZWQuIEZv
ciByZXYuMjAwIHRoZSBFRVBST00NCj4+IElEIHBhZ2UgaXMgdXNlZCwgZm9yIHJldi4xMDAgb25s
eSBzb21lIGludGVybmFsIFNvTSBwcm90b3R5cGVzIHdpdGggdHdvDQo+PiBFdGhlcm5ldCBpbnRl
cmZhY2VzIGhhZCBvbmx5IHRoZSBmaXJzdCBFRVBST00gcG9wdWxhdGVkLiBJdCdzIG5vdCB3b3J0
aA0KPj4ga2VlcGluZyB0aGF0IGNvZGUuDQo+IA0KPiBTbyB5ZXMsIGVlcHJvbTAgY2FuIG5vdCBi
ZSByZW1vdmVkLCBiZWNhdXNlIGl0IGFsc28gY29udGFpbnMgdGhlIFdMUC4NCg0KV2lsbCBkbyB0
aGlzIGluIFYyLg0KDQo+Pj4gSSB3b3VsZCBzYXkgQikgaXMgdGhlIHdheSB0byBnbywgaXQgc2hv
dWxkIGFsc28gY292ZXIgeW91ciByZXF1aXJlbWVudHMsDQo+Pj4ga2VlcHMgdGhlIGJvb3QgdGlt
ZSBsb3cgaWYgYm90aCBmdXNlIGJhbmtzIGFyZSBmdXNlZCAod2hpY2ggY2FuIGJlIGZpeGVkDQo+
Pj4gZXZlbiBvbiBleGlzdGluZyBoYXJkd2FyZSwgc2ltcGx5IHJlYWQgb3V0IGVlcHJvbSBjb250
ZW50IGFuZCBmdXNlIGl0DQo+Pj4gaW50byBmdXNlIGJhbmsgMSksIGFuZCBpdCByZXRhaW5zIHRo
ZSBwcmlvcml0eSBvcmRlcmluZyAoZW52LCBmdXNlLA0KPj4+IGVlcHJvbSkgd2l0aG91dCBtaXhp
bmcgaXQgdXAuDQo+Pg0KPj4gVGhlIGNhc2UgdGhhdCBvbmx5IHRoZSBmaXJzdCBNQUMgYWRkcmVz
cyBpcyBmdXNlZCBhbmQgbm90IHRoZSBzZWNvbmQgb25lIGlzDQo+PiBhIHNwZWNpYWwgY2FzZSwg
YnV0IGlmIHRoaXMgaGFwcGVucywgd2l0aCB0aGUgb3JkZXIgQSkgYWJvdmUgeW91IGNhbiBwcmV2
ZW50DQo+PiBkdXBsaWNhdGUgTUFDIGFkZHJlc3NlcyBmcm9tIGFwcGVhcmluZyBpbiB0aGUgc3lz
dGVtLiBJbiBhZGRpdGlvbiwgaWYgeW91IHdhbnQNCj4+IHRvIGZpeCBpdCwgaXQncyBkYW5nZXJv
dXMgdG8gZnVzZSB0aGUgc2Vjb25kIE1BQyBhZGRyZXNzIGF0IHRoZSBjdXN0b21lcidzDQo+PiBs
b2NhdGlvbiwgYmVjYXVzZSBpZiBzb21ldGhpbmcgZ29lcyB3cm9uZyBkdXJpbmcgdGhlIGZ1c2lu
ZywgdGhlIGRldmljZSBtdXN0DQo+PiBiZSByZXBsYWNlZCBvbi1zaXRlLiBUaGlzIGNhbiBhbHNv
IGJlIGF2b2lkZWQgd2l0aCBvcmRlciBBKS4NCj4gSWYgdGhpcyBpcyBhIHNwZWNpYWwgY2FzZSwg
dGhlbiBwbGVhc2UgY29udmVydCBpdCBpbnRvIGEgY29tbW9uIGNhc2UsIHNvDQo+IHRoZSBnZW5l
cmljIGNvZGUgdXBzdHJlYW0gY2FuIGJlIGtlcHQgdGhhdCwgZ2VuZXJpYy4NCj4gDQo+IElmIHRo
aXMgc3BlY2lhbCBjYXNlIGNhbiBub3QgYmUgY29udmVydGVkIHRvIGNvbW1vbiBjYXNlLCB0aGVu
IGFkZCBsb2NhbA0KPiBwYXRjaCB0byBoYW5kbGUgdGhhdCBzcGVjaWZpYyBkZXZpY2UuDQoNCkkn
bGwgdHJ5IHRvIGltcGxlbWVudCB0aGF0IGluIFYyLg0KDQoNClJlZ2FyZHMNCkNocmlzdG9waA0K
