Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41049D1F9A5
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 10:31:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8AFA83DA7;
	Thu,  4 Dec 2025 11:31:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="m7qN6EUJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B22883FA5; Thu,  4 Dec 2025 11:31:46 +0100 (CET)
Received: from mx3.securetransport.de (mx3.securetransport.de
 [IPv6:2a01:4f8:c0c:92be::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D12C983B4A
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 11:31:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1764844300;
 bh=JInDlyEWfMJ7HkdrszCHMpLJpwyUZgPDYtF5ZKfNnTI=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=m7qN6EUJMlYaU0rbn5+MxWD56uwexksyIGB37gxgBmghjqgjIR6DiEqTtCQhuWSv4
 QST+Nz/5Uh9C+Dgw/s7hQt250mxQgEqwuZJzagMAMT08qxMhFmZFQ9qBay4HCTiDnJ
 7w8VS8QOVGjhH0mo2HGg+LjC4vyFc/+deUwpvd8Q6x7CrJ7KLTy4rZ25HbyHgYETN8
 qhUb4v2Kk+MMinvypp2HvH6RaoTeBx+v62mD7DAanuQGIWWdNSUQqvutOHA0ecdr9N
 /VQMlppqFbEwQ3NT7XzPxwxQAEHW7Hz47D+/DVrvKGKrwZRJXVMJ3+uAHzp+Klj/5/
 Z7W9tfTcVB/GA==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Anshul Dalal <anshuld@ti.com>, Andrew Davis <afd@ti.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Judith Mendez <jm@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Hrushikesh Salunke <h-salunke@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Vignesh R <vigneshr@ti.com>
Subject: RE: [PATCH v2] configs: am65x_usbdfu: add
 SPL_USE_TINY_PRINTF_POINTER_SUPPORT
Thread-Topic: [PATCH v2] configs: am65x_usbdfu: add
 SPL_USE_TINY_PRINTF_POINTER_SUPPORT
Thread-Index: AQHcTnBeIxSP/fOWikC17lyd3rnxbLTkUQ2AgC0EAwCAABZlAA==
Date: Thu, 4 Dec 2025 10:31:39 +0000
Message-ID: <160da03ccb1e4957ac0a48fc09907cc2@dh-electronics.com>
References: <20251105-am65_dfu_fix-v2-1-ccada89d966d@ti.com>
 <31b4e016-379d-4637-8a02-896a897fc371@ti.com>
 <DEPBWFGM21LL.1YE7UZ0TNKVQ1@ti.com>
In-Reply-To: <DEPBWFGM21LL.1YE7UZ0TNKVQ1@ti.com>
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

RnJvbTogQW5zaHVsIERhbGFsIDxhbnNodWxkQHRpLmNvbT4NClNlbnQ6IFRodXJzZGF5LCBEZWNl
bWJlciA0LCAyMDI1IDEwOjM2IEFNDQo+IE9uIFdlZCBOb3YgNSwgMjAyNSBhdCAxMTozOSBQTSBJ
U1QsIEFuZHJldyBEYXZpcyB3cm90ZToNCj4+IE9uIDExLzUvMjUgMTA6MjEgQU0sIEFuc2h1bCBE
YWxhbCB3cm90ZToNCj4+PiBTaW5jZSB0aGUgY29tbWl0IDFlMjRlODRkYjQxYSAoInRpbnktcHJp
bnRmOiBIYW5kbGUgZm9ybWF0dGluZyBvZiAlcA0KPj4+IHdpdGggYW4gZXh0cmEgS2NvbmZpZyIp
LCBTUExfVVNFX1RJTllfUFJJTlRGX1BPSU5URVJfU1VQUE9SVCBoYXMgYmVlbg0KPj4+IG1hZGUg
bWFuZGF0b3J5IGluIG9yZGVyIHRvIHVzZSAlcCB3aGljaCB3b3VsZCBlYXJsaWVyIGhhdmUgZGVm
YXVsdGVkIHRvDQo+Pj4gYSAnbG9uZycgcHJpbnQuDQo+Pj4NCj4+PiBXaXRob3V0IHRoaXMgY29u
ZmlnIHN5bWJvbCwgazNfc3lzZndfZGZ1X2Rvd25sb2FkIGZhaWxzIHRvIHNldCB0aGUNCj4+PiBj
b3JyZWN0IHZhbHVlIGZvciB0aGUgREZVIHN0cmluZyB3aXRoOg0KPj4+DQo+Pj4gICBzcHJpbnRm
KGRmdV9zdHIsICJzeXNmdy5pdGIgcmFtIDB4JXAgMHgleCIsIGFkZHIsDQo+Pj4gICAgIENPTkZJ
R19LM19TWVNGV19JTUFHRV9TSVpFX01BWCk7DQo+Pj4NCj4+PiBUaGUgdmFsdWUgd2UgZ2V0ICJz
eXNmdy5pdGIgcmFtIDB4PyAweDQxYzI5ZDQwIiBjYXVzZXMgYSBib290IGZhaWx1cmUuDQo+Pj4N
Cj4+PiBUaGVyZWZvcmUgdGhpcyBwYXRjaCBzZXRzIFNQTF9VU0VfVElOWV9QUklOVEZfUE9JTlRF
Ul9TVVBQT1JUIGZvciB0aGUNCj4+PiB1c2JkZnUgZGVmY29uZmlnLg0KPj4+DQo+Pj4gU2lnbmVk
LW9mZi1ieTogQW5zaHVsIERhbGFsIDxhbnNodWxkQHRpLmNvbT4NCj4+PiAtLS0NCj4+PiBOb3Qg
c3VyZSBpZiBhICdGaXhlcycgdGFnIGlzIGFwcHJvcHJpYXRlIGhlcmUgc2luY2UgdGhlIGNvbW1p
dA0KPj4+IDFlMjRlODRkYjQxYSAoInRpbnktcHJpbnRmOiBIYW5kbGUgZm9ybWF0dGluZyBvZiAl
cCB3aXRoIGFuIGV4dHJhDQo+Pj4gS2NvbmZpZyIpIGRpZCBjYXVzZSBhIHJlZ3Jlc3Npb24gdGhv
dWdoIEkgdGhpbmsgdGhlIHByb2JsZW0gZXhpc3RlZCB3aXRoDQo+Pj4gdGhlIHVzYWdlIG9mICIl
cCIgd2l0aCBUSU5ZX1BSSU5URiBzZXQgdG8gYmVnaW4gd2l0aC4NCj4+DQo+PiBTbyBJIGRvIHRo
aW5rIHRoaXMgZml4IGlzIHZhbGlkLCBidXQgaXQgd291bGQgYmUgbmljZSB0byBub3QgaGF2ZSB0
byBmaXgNCj4+IHRoaXMgaW4gZWFjaCBkZWZjb25maWcgdGhhdCBtaWdodCBmYWxsIGludG8gdGhp
cyB0cmFwLiBJbnN0ZWFkIGlzIHRoZXJlDQo+PiBzb21lIHdheSB0byBiYWtlIHRoaXMgaW50byB0
aGUgS2NvbmZpZyBsb2dpYyBzbyB0aGF0IHdoZW4gSzMsIERGVSwgYW5kDQo+PiBVU0VfVElOWV9Q
UklOVEYgYXJlIHNldCwgdGhlIFNQTF9VU0VfVElOWV9QUklOVEZfUE9JTlRFUl9TVVBQT1JUIHN5
bWJvbA0KPj4gaXMgYWxzbyBzZXQgYXV0b21hdGljYWxseT8NCj4+DQo+PiBPciBiZXR0ZXIgeWV0
LCBzaW5jZSB0aGlzIGxvb2tzIHRvIGJlIHNwZWNpZmljIHRvIGszX3N5c2Z3X2RmdV9kb3dubG9h
ZCgpDQo+PiB1c2luZyAweCVwIGluIGEgcGxhY2Ugd2hlcmUgVVNFX1RJTlkgbWlnaHQgYmUgZW5h
YmxlZCB3ZSBjb3VsZCBqdXN0IHN3aXRjaA0KPj4gdG8gdXNpbmcgMHgleCB3aXRoIGEgY2FzdCB0
aGVyZS4NCj4+DQo+PiBBbHRob3VnaCB0aGUgYmVzdCBzb2x1dGlvbiBJTUhPIHdvdWxkIGJlIHRv
IGZpeCAxZTI0ZTg0ZGI0MWEgd2hpY2gNCj4+IGRvZXNuJ3Qgc2VlbSByaWdodCB0byBtZS4gV2Ug
dXNlZCB0byBoYXZlIGl0IHNvIFRJTllfUFJJTlRGIHdvdWxkDQo+PiBzaW1wbHkgZmFsbCB0aG91
Z2ggd2l0aCAlcCBhbmQgdXNlIHRoZSAleCBoYW5kbGluZy4gVGhlIGNvbW1pdA0KPj4gZG9lcyBw
b2ludCBvdXQgdGhhdCAlcGEgLyAlcGFwIHdvdWxkIGJlIHdyb25nIGJ1dCBpdCBkb2Vzbid0IGFj
dHVhbGx5DQo+PiBmaXggdGhvc2UgYW55d2F5LCBqdXN0IHJlbW92ZXMgdGhlIGFiaWxpdHkgZm9y
ICVwIHRvIHdvcmsgd2l0aG91dA0KPj4gdGhhdCBuZXcgZmxhZy4uDQo+Pg0KPiANCj4gSSB0aGlu
ayBoYW5kbGluZyBpdCBpbiB0aGUgS2NvbmZpZyBtaWdodCBiZSB0aGUgYmVzdCB3YXkgZm9yd2Fy
ZHMNCj4gYWx0aG91Z2ggSSdtIG5vdCBvcHBvc2VkIHRvIGZpeGluZyAxZTI0ZTg0ZGI0MWEgdG8g
YmVnaW4gd2l0aC4NCj4gDQo+IFNQTF9VU0VfVElOWV9QUklOVEZfUE9JTlRFUl9TVVBQT1JUIG9u
bHkgYWRkcyB+MTAwIGJ5dGVzIHRvIG91ciBTUEwNCj4gc2l6ZSwgaWYgdGhhdCdzIGFuIGFjY2Vw
dGFibGUgaW5jcmVhc2Ugd2UgY2FuIGVuYWJsZSBpdCBieSBkZWZhdWx0IGZvcg0KPiBLMy4NCg0K
VGhlIGlkZWEgaXMgdG8gZWl0aGVyIHN1cHBvcnQgcG9pbnRlciBuZWFybHkgY29tcGxldGVseSBv
ciBub3QgYXQgYWxsLg0KT25seSBwYXJ0aWFsIHN1cHBvcnQgKGZhbGwgdGhyb3VnaCkgYWx3YXlz
IGNhdXNlcyBwcm9ibGVtcy4gQnV0IG5vdyBpZg0KeW91IGVuYWJsZSBTUExfVVNFX1RJTllfUFJJ
TlRGX1BPSU5URVJfU1VQUE9SVCBwb2ludGVyIHN1cHBvcnQgaXMgaGFuZGxlZA0KY29ycmVjdGx5
IGJ5IHRoZSBwb2ludGVyKCkgZnVuY3Rpb24uIEJlZm9yZSBpdCB3YXMgb25seSBhY3RpdmUgd2l0
aA0KTkVUIHN1cHBvcnQuIFNvIHRoZXJlIGlzIG5vdGhpbmcgdG8gZml4LiBUaGUgaWRlYSB3YXMg
ZGV2ZWxvcGVkIGFuZA0KZGlzY3Vzc2VkIGhlcmUgaW4gYSBwcmV2aW91cyBwYXRjaDoNCmh0dHBz
Oi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC91Ym9vdC9wYXRjaC8yMDI1MDMyMDEwMjM0
Ni4xMzU2NC0xLWNuaWVkZXJtYWllckBkaC1lbGVjdHJvbmljcy5jb20vIzM0ODI1OTANCg0KUmVn
YXJkcw0KQ2hyaXN0b3BoDQo=
