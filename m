Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBFBAEC01B8
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 10:07:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7629983DB6;
	Mon, 23 Mar 2026 11:07:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="DRiV+Wy+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79B0984129; Mon, 23 Mar 2026 11:07:14 +0100 (CET)
Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AF55805D7
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 11:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1774260425;
 bh=iA1UFhemcwLaaWmdd8GI6BOqNWYnLs492pIgpn4ubBY=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=DRiV+Wy+CHc4KUlKyI/NXtdR1pdK23g/gKNvw15QIwzcKIFd6MnRe0KGCv3d+d6AA
 8ca+gTuQqJ77whSFhTpCINB2b4LH8o9pW848XmmfYcY3Ou+v3D5hwM4XrjE7jiBcmo
 y4AEFkf5AeZhm/mC4SBtFPlyx/aRb6XRENGCyjNm43PeSZPSVCrxEDENoiCx3xZ+Ui
 adPdcNIX78ucXVSWOxz9GxNZw1w70AzFxaqb+0SEyEfWs2ZjmSz0GDqiPX6ubybo3e
 VplKfd49zH/3Pc/zlKE4HY0Pi7dQWL2JHi+vnOAC0inaaX3bLmU2WJVxrlddurnWo7
 +iE05alK9UL1g==
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
Thread-Index: AQHcuFTCAYeM+Dh5A0K4haKIts4CsrW3q5OAgAHGg1CAACS3gIACOHIA
Date: Mon, 23 Mar 2026 10:07:02 +0000
Message-ID: <2eebac26eff54f9da7e2d01dbca71569@dh-electronics.com>
References: <20260320102918.4011-1-cniedermaier@dh-electronics.com>
 <382f338c-020f-482d-80b8-5a39ad724843@nabladev.com>
 <b443e161b5db4abab8d8889135a345fa@dh-electronics.com>
 <941708e9-a2e6-4f8d-a15d-d1da8a91ae91@nabladev.com>
In-Reply-To: <941708e9-a2e6-4f8d-a15d-d1da8a91ae91@nabladev.com>
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

RnJvbTogTWFyZWsgVmFzdXQgPG1hcmV4QG5hYmxhZGV2LmNvbT4NClNlbnQ6IFN1bmRheSwgTWFy
Y2ggMjIsIDIwMjYgMTI6NDEgQU0NCj4gT24gMy8yMS8yNiA5OjU1IFBNLCBDaHJpc3RvcGggTmll
ZGVybWFpZXIgd3JvdGU6DQo+PiBGcm9tOiBNYXJlayBWYXN1dCA8bWFyZXhAbmFibGFkZXYuY29t
Pg0KPj4gU2VudDogRnJpZGF5LCBNYXJjaCAyMCwgMjAyNiA3OjIyIFBNDQo+Pj4gT24gMy8yMC8y
NiAxMToyOSBBTSwgQ2hyaXN0b3BoIE5pZWRlcm1haWVyIHdyb3RlOg0KPj4+DQo+Pj4gWy4uLl0N
Cj4+Pg0KPj4+PiArKysgYi9ib2FyZC9kaGVsZWN0cm9uaWNzL2RoX2lteDhtcC9pbXg4bXBfZGhj
b21fcGRrMi5jDQo+Pj4+IEBAIC01MCw3ICs1MCw3IEBAIHN0YXRpYyBpbnQgZGhfaW14OF9zZXR1
cF9ldGhhZGRyKHN0cnVjdCBlZXByb21faWRfcGFnZSAqZWlwKQ0KPj4+PiAgICAgICAgaWYgKGRo
X2dldF9tYWNfaXNfZW5hYmxlZCgiZXRoZXJuZXQwIikpDQo+Pj4+ICAgICAgICAgICAgICAgIHJl
dHVybiAwOw0KPj4+Pg0KPj4+PiAtICAgICBpZiAoIWRoX2lteF9nZXRfbWFjX2Zyb21fZnVzZShl
bmV0YWRkcikpDQo+Pj4+ICsgICAgIGlmICghZGhfaW14X2dldF9tYWNfZnJvbV9mdXNlKDAsIGVu
ZXRhZGRyKSkNCj4+Pj4gICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+Pj4+DQo+Pj4+ICAgICAg
ICBpZiAoIWRoX2dldF92YWx1ZV9mcm9tX2VlcHJvbV9idWZmZXIoREhfTUFDMCwgZW5ldGFkZHIs
IHNpemVvZihlbmV0YWRkciksIGVpcCkpDQo+Pj4+IEBAIC03NSw4ICs3NSw4IEBAIHN0YXRpYyBp
bnQgZGhfaW14OF9zZXR1cF9ldGgxYWRkcihzdHJ1Y3QgZWVwcm9tX2lkX3BhZ2UgKmVpcCkNCj4+
Pj4gICAgICAgIGlmIChkaF9nZXRfbWFjX2lzX2VuYWJsZWQoImV0aGVybmV0MSIpKQ0KPj4+PiAg
ICAgICAgICAgICAgICByZXR1cm4gMDsNCj4+Pj4NCj4+Pj4gLSAgICAgaWYgKCFkaF9pbXhfZ2V0
X21hY19mcm9tX2Z1c2UoZW5ldGFkZHIpKQ0KPj4+PiAtICAgICAgICAgICAgIGdvdG8gaW5jcmVt
ZW50X291dDsNCj4+Pj4gKyAgICAgaWYgKCFkaF9pbXhfZ2V0X21hY19mcm9tX2Z1c2UoMSwgZW5l
dGFkZHIpKQ0KPj4+PiArICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPj4+DQo+Pj4gVGhlIG9yZGVy
aW5nIGluIHRoaXMgYW5kIG5leHQgaHVuayBzZWVtcyBib2d1cy4NCj4+Pg0KPj4+IElmIHJlYWQg
ZnJvbSB0aGUgKG5ldy9zZWNvbmQpIGZ1c2Ugc2xvdCAxIGZhaWxzLCB0aGUgY29kZSBzaG91bGQg
YXR0ZW1wdA0KPj4+IHRvIHVzZSBmdXNlIHNsb3QgMCBjb250ZW50IGluY3JlbWVudGVkIGJ5IDEs
IGp1c3QgbGlrZSBpdCBkaWQgYmVmb3JlIC4uLg0KPj4+DQo+Pj4gIg0KPj4+IGlmICghZGhfaW14
X2dldF9tYWNfZnJvbV9mdXNlKDEsIGVuZXRhZGRyKSkNCj4+PiAgICAgZ290byBvdXQ7DQo+Pj4g
aWYgKCFkaF9pbXhfZ2V0X21hY19mcm9tX2Z1c2UoMCwgZW5ldGFkZHIpKQ0KPj4+ICAgICBnb3Rv
IGluY3JlbWVudF9vdXQ7DQo+Pj4gIg0KPj4+DQo+Pj4+ICAgICAgICBpZiAoIWRoX2dldF92YWx1
ZV9mcm9tX2VlcHJvbV9idWZmZXIoREhfTUFDMSwgZW5ldGFkZHIsIHNpemVvZihlbmV0YWRkciks
IGVpcCkpDQo+Pj4+ICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPj4+PiBAQCAtOTIsNiArOTIs
MTMgQEAgc3RhdGljIGludCBkaF9pbXg4X3NldHVwX2V0aDFhZGRyKHN0cnVjdCBlZXByb21faWRf
cGFnZSAqZWlwKQ0KPj4+PiAgICAgICAgaWYgKCFkaF9nZXRfbWFjX2Zyb21fZWVwcm9tKGVuZXRh
ZGRyLCAiZWVwcm9tMCIpKQ0KPj4+PiAgICAgICAgICAgICAgICBnb3RvIGluY3JlbWVudF9vdXQ7
DQo+Pj4+DQo+Pj4+ICsgICAgIC8qDQo+Pj4+ICsgICAgICAqIElmIG9ubHkgdGhlIGZpcnN0IE1B
QyBhZGRyZXNzIGlzIGZ1c2VkIGJ1dCBub3QgdGhlIHNlY29uZCwgdXNlIHRoZQ0KPj4+PiArICAg
ICAgKiBmdXNlZCBNQUMgYWRkcmVzcyBpbmNyZW1lbnRlZCBieSBvbmUsIGZvciB0aGUgc2Vjb25k
IE1BQyBhZGRyZXNzLg0KPj4+PiArICAgICAgKi8NCj4+Pj4gKyAgICAgaWYgKCFkaF9pbXhfZ2V0
X21hY19mcm9tX2Z1c2UoMCwgZW5ldGFkZHIpKQ0KPj4+PiArICAgICAgICAgICAgIGdvdG8gaW5j
cmVtZW50X291dDsNCj4+PiAuLi4gdGhpcyBwYXJ0IHdvdWxkIHRoZW4gYmUgdW5uZWNlc3Nhcnku
DQo+Pg0KPj4gVGhhdCdzIGhvdyBpdCdzIHN1cHBvc2VkIHRvIGJlLiBUaGUgdHdvIE1BQyBhZGRy
ZXNzZXMgc2hvdWxkIGJlIGFzc2lnbmVkIHRoZSBzYW1lDQo+PiBwcmlvcml0eSBvcmRlciBhbmQg
YmUgYXMgaW5kZXBlbmRlbnQgb2YgZWFjaCBvdGhlciBhcyBwb3NzaWJsZSB0byBhdm9pZCBjb25m
dXNpb24uDQo+PiBTb3VyY2VzIGFzc29jaWF0ZWQgd2l0aCB0aGUgc2Vjb25kIE1BQyBhZGRyZXNz
IHRoZXJlZm9yZSBoYXZlIGEgaGlnaGVyIHByaW9yaXR5DQo+PiB0aGFuIHRob3NlIGFzc29jaWF0
ZWQgd2l0aCB0aGUgZmlyc3QgTUFDIGFkZHJlc3MgaW4gdGhlIGZ1c2VzLiBVc2luZyB0aGUgZnVz
ZSBvZg0KPj4gdGhlIGZpcnN0IE1BQyBhZGRyZXNzIGluY3JlbWVudGVkIGJ5IG9uZSBhcyBhIGZh
bGxiYWNrIGlzIHRoZSBsYXN0IHJlc29ydCBpZiBubw0KPj4gYWRkcmVzcyBpcyBmb3VuZCBmb3Ig
dGhlIHNlY29uZCBNQUMgYWRkcmVzcyBhZnRlciB0aGUgcHJpb3JpdHkgb3JkZXIgaGFzIGJlZW4N
Cj4+IGNoZWNrZWQuDQo+IFRoZSBwcmlvcml0eSBpcyB0aGlzOg0KPiAtIEVOViAtLSBiZWNhdXNl
IHVzZXIgY2FuIG92ZXJyaWRlIHRoZSBjb250ZW50LCBhbmQgdXNlciBvdmVycmlkZSBpcw0KPiBo
aWdoZXN0IHByaW8NCj4gLSBEZXZpY2Ugbm90IGVuYWJsZWQgaW4gRFQsIGRvIG5vdGhpbmcNCj4g
LSBGdXNlcywgKG5ld2x5IGZpcnN0IGZ1c2UgYmxvY2sgMSAsIHRoZW4pIGZ1c2UgYmxvY2sgMCAt
LSBiZWNhdXNlDQo+IGluLVNvQyBmdXNlcyBhbHdheXMgaGF2ZSB0byB0YWtlIHByZWNlZGVuY2Ug
b3ZlciB0aGUgZXh0ZXJuYWwgRUVQUk9NDQo+IC0gRUVQUk9NLCBmaXJzdCBibG9jayAxLCB0aGVu
IGJsb2NrIDAgLS0gYmVjYXVzZSB0aGlzIGlzIHdoYXQgaXMgdXN1YWxseQ0KPiBwcm9ncmFtbWVk
IG91dCBvZiBmYWN0b3J5LCBhbnl0aGluZyBoaWdoZXIgcHJpb3JpdHkgaXMgdXAgdG8gdGhlIHVz
ZXINCg0KVGhlIFNvTSBpcyBkZWxpdmVyZWQgd2l0aCBib3RoIE1BQyBhZGRyZXNzZXMgY29taW5n
IGZyb20gREggZWxlY3Ryb25pY3MgcHJvdmlkZWQNCmJ5IEVFUFJPTXMuIElmIGEgY3VzdG9tZXIg
d2FudHMgaGlzIG93biBNQUMsIHRoZXkgY2FuIGZ1c2UgdGhlIE1BQyBhZGRyZXNzIHRvDQpvdmVy
cmlkZSBpdCBwZXJtYW5lbnRseSwgYnV0IHJlZmVycmluZyB0byB5b3VyIHN1Z2dlc3Rpb24gaWYg
dGhlIGN1c3RvbWVyIG9ubHkNCmZ1c2Ugb25lIE1BQyBhZGRyZXNzIHRoZSBiZWhhdmlvciBkZXBl
bmRzIG9uIHdoaWNoIE1BQyBhZGRyZXNzIGlzIGZ1c2VkLg0KDQpGdXNlIG9ubHkgdGhlIGZpcnN0
IE1BQyBhZGRyZXNzOg0KLSAxLiBFdGhlcm5ldDogTUFDIGlzIHRha2VuIGZyb20gRlVTRSAwDQot
IDIuIEV0aGVybmV0OiBNQUMgaXMgdGFrZW4gZnJvbSBGVVNFIDAgKyBpbmNyZW1lbnRlZCBieSBv
bmUNCg0KRnVzZSBvbmx5IHRoZSBzZWNvbmQgTUFDIGFkZHJlc3M6DQotIDEuIEV0aGVybmV0OiBN
QUMgaXMgdGFrZW4gZnJvbSBFRVBST00NCi0gMi4gRXRoZXJuZXQ6IE1BQyBpcyB0YWtlbiBmcm9t
IEZVU0UgMQ0KDQpUaGUgcHJvYmxlbSBpcyB0aGF0IHdlIGhhdmUgYSBjdXN0b21lciB3aXRoIFNv
TXMgd2hlcmUgb25seSB0aGUgZmlyc3QgTUFDIGFkZHJlc3MNCndhcyBzZXF1ZW50aWFsbHkgZnVz
ZWQgZnJvbSBhIE1BQyBhZGRyZXNzIHBvb2wuIFRoYXQgbWVhbnMgdGhlIHNlY29uZCBNQUMgYWRk
cmVzcw0Kb2YgdGhlIFNvTSBpcyB0aGUgc2FtZSBNQUMgYWRkcmVzcyBhcyB0aGUgTUFDIGFkZHJl
c3MgZnJvbSB0aGUgbmV4dCBTb00ncyBmaXJzdA0KTUFDIGFkZHJlc3MuIFRoaXMgcGF0Y2ggcHJl
dmVudHMgdGhpcyBieSBzZXR0aW5nIHRoZSBNQUMgYWRkcmVzc2VzIGluZGVwZW5kZW50bHkNCm9m
IG9uZSBhbm90aGVyLiBUaGVuIGZvciB0aGUgc2Vjb25kIE1BQyBhZGRyZXNzIHRoZSBESCBlbGVj
dHJvbmljcyBNQUMgZnJvbSB0aGUNCkVFUFJPTSBpcyB1c2VkLiBJbiB0aGlzIHBhdGNoIHRoZSBm
YWxsYmFjayB3aGVyZSB0aGUgZmlyc3QgTUFDIGFkZHJlc3MgaW5jcmVtZW50ZWQNCmJ5IG9uZSBp
cyB1c2VkIHNob3VsZCBub3Qgb2NjdXIgb24gdGhlIGN1c3RvbWVyIHNpZGUsIGFzIHRoZSBTb01z
IGFyZSBzaGlwcGVkIHdpdGgNCk1BQyBhZGRyZXNzZXMgaW4gdGhlIEVFUFJPTXMuIElmIHRoaXMg
ZG9lcyBvY2N1ciwgaG93ZXZlciBkdWUgdG8gYW4gRUVQUk9NIHJlYWQNCmVycm9yIG9yIHdoYXRl
dmVyIHRoaXMgcGF0Y2ggY291bGQgYmUgaW1wcm92ZWQgYnkgYSB3YXJuaW5nIG1lc3NhZ2UuDQoN
ClJlZ2FyZHMNCkNocmlzdG9waA0K
