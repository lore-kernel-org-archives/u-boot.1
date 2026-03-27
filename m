Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F5410F2871
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 22:02:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24D9A83C14;
	Fri, 27 Mar 2026 23:02:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="BU6wgJyc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52ACA83C5E; Fri, 27 Mar 2026 23:02:54 +0100 (CET)
Received: from mx2.securetransport.de (mx2.securetransport.de
 [IPv6:2a03:4000:13:6c7::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FEA78394E
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 23:02:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1774648964;
 bh=hEQ/2t98dTfXvWEX1g4RC0xVX5rIY4po7OmkuDTXv/w=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=BU6wgJycN6OJvpvgrkZy8RgcEAUJkDQUxZ1zkD6Vr/hWbspw0P91+ptkTIWZ8Kruz
 femkQZ5X3xh9mybVzkLXEpE8y4ma8ijcZEQxuM2r7Ekm3NSfQTyB/wfrZ9l65T9jKC
 SEP1XobCs29A5/rbnpRjMEFlt8ofSHRMRN8C0JuAcmMcw8SZ1NSOWtqM/I4S8VYh88
 acpikRn3rUYofQzo38i4DCuqvM/yBUtbzjRXR6ODWYEGQZSvGe0J1NQA05C53TjmpM
 GC0j/0XHnO9Q4syl3GqnG6SOS9ZpuOjhjo4H/41YCqyig+bnpqGf9IF91pZqctM3Sp
 8twFscjmKtEWw==
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
Thread-Index: AQHcuFTCAYeM+Dh5A0K4haKIts4CsrW3q5OAgAHGg1CAACS3gIACOHIAgABacoCAACH7kIAABaOAgABQ+/A=
Date: Fri, 27 Mar 2026 22:02:41 +0000
Message-ID: <3a8724ffe4fa44808ac8a278e4a702f7@dh-electronics.com>
References: <20260320102918.4011-1-cniedermaier@dh-electronics.com>
 <382f338c-020f-482d-80b8-5a39ad724843@nabladev.com>
 <b443e161b5db4abab8d8889135a345fa@dh-electronics.com>
 <941708e9-a2e6-4f8d-a15d-d1da8a91ae91@nabladev.com>
 <2eebac26eff54f9da7e2d01dbca71569@dh-electronics.com>
 <a40a11f9-f3f5-4eee-ab6e-c2597808c471@nabladev.com>
 <a7ebfe912f084176b79c54a2e9e3d8e3@dh-electronics.com>
 <2dca42bf-a247-4190-9439-14e14f65aec3@nabladev.com>
In-Reply-To: <2dca42bf-a247-4190-9439-14e14f65aec3@nabladev.com>
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
Y2ggMjMsIDIwMjYgNjoyMSBQTQ0KPiBPbiAzLzIzLzI2IDU6NDkgUE0sIENocmlzdG9waCBOaWVk
ZXJtYWllciB3cm90ZToNCj4gDQo+IFsuLi5dDQo+IA0KPj4+IEFzIGZvciB0aGUgcmVzdCwgaXQg
cmVhbGx5IGJvaWxzIGRvd24gdG8gdGhlIG9yZGVyaW5nIG9mIGZhbGxiYWNrcywgaXQNCj4+PiBp
cyBlaXRoZXI6DQo+Pj4NCj4+PiBBKQ0KPj4+IGZ1c2UxDQo+Pj4gZWVwcm9tMQ0KPj4+IGZ1c2Uw
KzENCj4+PiBlZXByb20wKzENCj4+Pg0KPj4+IG9yDQo+Pj4NCj4+PiBCKQ0KPj4+IGZ1c2UxDQo+
Pj4gZnVzZTArMQ0KPj4+IGVlcHJvbTENCj4+PiBlZXByb20wKzENCj4+Pg0KPj4+IFRoZSBmb2xs
b3dpbmcgb3JkZXJpbmcsIHdoaWNoIGlzIHRoZSBvcmRlcmluZyBpbnRyb2R1Y2VkIGJ5IHRoaXMg
cGF0Y2gsDQo+Pj4gaXMgY29uZnVzaW5nOg0KPj4+DQo+Pj4gZnVzZTENCj4+PiBlZXByb20xDQo+
Pj4gZWVwcm9tMCsxDQo+Pj4gZnVzZTArMQ0KPj4+DQo+Pj4gU28gcGxlYXNlIHBpY2sgZWl0aGVy
IEEpIG9yIEIpIGFib3ZlLiBJIGRvIG5vdCBzZWUgYW55IHBhcnRpY3VsYXINCj4+PiBhZHZhbnRh
Z2Ugb2YgZWl0aGVyIG9mIHRoZSBvdGhlciwgZXhjZXB0IG1heWJlIEIpIGltcHJvdmVzIGJvb3Qg
dGltZSBpbg0KPj4+IGNhc2UgYm90aCBmdXNlIGJsb2NrcyBhcmUgYmxvd24sIGJlY2F1c2UgaXQg
YXZvaWRzIHRoZSBFRVBST00gSTJDIGFjY2Vzcy4NCj4+DQo+PiBUaGUgcHJldmVudGlvbiBvZiBJ
MkMgYWNjZXNzIGlzIG9ubHkgYSBvbmUgdGltZSBlZmZlY3QsIGJlY2F1c2UgdGhlbiB0aGUNCj4+
IE1BQyBhZGRyZXNzZXMgd2lsbCBwcm92aWRlZCBieSB0aGUgZW52aXJvbm1lbnQuDQo+IA0KPiBX
aGljaCBpbmNyZWFzZXMgdGhlIHN5c3RlbSBib290IHRpbWUsIHdoaWNoIGlzIHVuZGVzaXJlZC4N
Cg0KSWYgYSBjdXN0b21lciBzZXF1ZW50aWFsbHkgZnVzZSBvbmx5IHRoZSBmaXJzdCBNQUMgYWRk
cmVzcyBmcm9tIGEgTUFDIGFkZHJlc3MNCnBvb2wuIFRoZW4gdGhlIHNlY29uZCBNQUMgYWRkcmVz
cyBvZiB0aGUgU29NIGlzIHRoZSBzYW1lIE1BQyBhZGRyZXNzIGFzIHRoZSBNQUMNCmFkZHJlc3Mg
ZnJvbSB0aGUgbmV4dCBTb00ncyBmaXJzdCBNQUMgYWRkcmVzcy4gVGhhdCBpcyB2ZXJ5IGJhZC4g
V2l0aCB0aGUgQSkNCml0IGNhbiBiZSBhdm9pZGVkLCBiZWNhdXNlIHRoZSBzZWNvbmQgTUFDIGFk
ZHJlc3MgdGhlbiBpcyB0YWtlbiBmcm9tIHRoZSBFRVBST00uDQpJZiBJIGhhZCB0byBjaG9vc2Ug
YmV0d2VlbiByZWR1Y2luZyB0aGUgYm9vdCB0aW1lIG9uY2UgYW5kIHByZXZlbnRpbmcgcG90ZW50
aWFsDQpkdXBsaWNhdGUgTUFDIGFkZHJlc3NlcywgSSB3b3VsZCBzYXkgdGhhdCBwcmV2ZW50aW5n
IHBvdGVudGlhbCBkdXBsaWNhdGUgTUFDDQphZGRyZXNzZXMgaXMgdGhlIGJldHRlciBvcHRpb24u
IEZ1cnRoZXJtb3JlLCB0aGUgaXNzdWUgb2YgZHVwbGljYXRlIE1BQyBhZGRyZXNzZXMNCmluIHRo
ZSBzeXN0ZW0gaXMgbm90IGEgaHlwb3RoZXRpY2FsIHNjZW5hcmlvLCBpdCBoYXMgYWxyZWFkeSBv
Y2N1cnJlZCBpbiBwcmFjdGljZS4NCg0KPj4gSWYgSSByZW1vdmUgdGhlIGVlcHJvbTArMSwgYmVj
YXVzZSBpdCB3YXMgZm9yIHByb3RvdHlwZSBjb25maWd1cmF0aW9ucywNCj4+IG15IHByZWZlcnJl
ZCBvcmRlciB3b3VsZCBiZToNCj4+DQo+PiBmdXNlMQ0KPj4gZWVwcm9tMQ0KPj4gZnVzZTArMQ0K
PiBlZXByb20wIGNhbiBub3QgYmUgcmVtb3ZlZCwgdGhhdCBicmVha3MgYmFja3dhcmQgY29tcGF0
aWJpbGl0eS4gQW5kIHRoZQ0KPiBvcmRlcmluZyBvZiBmdXNlLWVlcHJvbS1mdXNlIGlzIGNvbmZ1
c2luZyBhbmQgaGFzIHRoZSBib290IHRpbWUgaW5jcmVhc2UNCj4gZG93bnNpZGUgb2YgQSkuDQoN
CkZvciB3aGljaCBTb00gc2hvdWxkIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgYmUgbWFpbnRhaW5l
ZCBoZXJlLiBUaGVyZSBpcw0Kbm8gU29NIGF0IHRoZSBjdXN0b21lcidzIHNpdGUgd2hlcmUgaXQg
aXMgcmVxdWlyZWQuIEZvciByZXYuMjAwIHRoZSBFRVBST00NCklEIHBhZ2UgaXMgdXNlZCwgZm9y
IHJldi4xMDAgb25seSBzb21lIGludGVybmFsIFNvTSBwcm90b3R5cGVzIHdpdGggdHdvDQpFdGhl
cm5ldCBpbnRlcmZhY2VzIGhhZCBvbmx5IHRoZSBmaXJzdCBFRVBST00gcG9wdWxhdGVkLiBJdCdz
IG5vdCB3b3J0aA0Ka2VlcGluZyB0aGF0IGNvZGUuDQoNCj4gSSB3b3VsZCBzYXkgQikgaXMgdGhl
IHdheSB0byBnbywgaXQgc2hvdWxkIGFsc28gY292ZXIgeW91ciByZXF1aXJlbWVudHMsDQo+IGtl
ZXBzIHRoZSBib290IHRpbWUgbG93IGlmIGJvdGggZnVzZSBiYW5rcyBhcmUgZnVzZWQgKHdoaWNo
IGNhbiBiZSBmaXhlZA0KPiBldmVuIG9uIGV4aXN0aW5nIGhhcmR3YXJlLCBzaW1wbHkgcmVhZCBv
dXQgZWVwcm9tIGNvbnRlbnQgYW5kIGZ1c2UgaXQNCj4gaW50byBmdXNlIGJhbmsgMSksIGFuZCBp
dCByZXRhaW5zIHRoZSBwcmlvcml0eSBvcmRlcmluZyAoZW52LCBmdXNlLA0KPiBlZXByb20pIHdp
dGhvdXQgbWl4aW5nIGl0IHVwLg0KDQpUaGUgY2FzZSB0aGF0IG9ubHkgdGhlIGZpcnN0IE1BQyBh
ZGRyZXNzIGlzIGZ1c2VkIGFuZCBub3QgdGhlIHNlY29uZCBvbmUgaXMNCmEgc3BlY2lhbCBjYXNl
LCBidXQgaWYgdGhpcyBoYXBwZW5zLCB3aXRoIHRoZSBvcmRlciBBKSBhYm92ZSB5b3UgY2FuIHBy
ZXZlbnQNCmR1cGxpY2F0ZSBNQUMgYWRkcmVzc2VzIGZyb20gYXBwZWFyaW5nIGluIHRoZSBzeXN0
ZW0uIEluIGFkZGl0aW9uLCBpZiB5b3Ugd2FudA0KdG8gZml4IGl0LCBpdCdzIGRhbmdlcm91cyB0
byBmdXNlIHRoZSBzZWNvbmQgTUFDIGFkZHJlc3MgYXQgdGhlIGN1c3RvbWVyJ3MNCmxvY2F0aW9u
LCBiZWNhdXNlIGlmIHNvbWV0aGluZyBnb2VzIHdyb25nIGR1cmluZyB0aGUgZnVzaW5nLCB0aGUg
ZGV2aWNlIG11c3QNCmJlIHJlcGxhY2VkIG9uLXNpdGUuIFRoaXMgY2FuIGFsc28gYmUgYXZvaWRl
ZCB3aXRoIG9yZGVyIEEpLg0KDQoNClJlZ2FyZHMNCkNocmlzdG9waA0K
