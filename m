Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE7AC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 06:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43E2382C87;
	Mon,  7 Apr 2025 08:56:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="V5CVBrQZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 313D482CA4; Mon,  7 Apr 2025 08:56:15 +0200 (CEST)
Received: from mx3.securetransport.de (mx3.securetransport.de
 [IPv6:2a01:4f8:c0c:92be::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08FF582C55
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 08:56:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1744008936;
 bh=bEgNkQe+ZLvN8QBTmsbF8EDK4IWaUCt9RGod4OwpyvM=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=V5CVBrQZSQ1bYIZQ3Gs36tlRlHz9I6cLJg22bKiV3dOQZrOA4mOU0Gem2qyuWOj7W
 3x0SSwHzN2lPiv5IeprC8y2PLI/NDlSD60ejd9EM51vAGuyDmK8ClsCaDUCmAay3CO
 W74y8UCKSmH+9RaOUQXEDh0shgq8B+9PrHAmyEg77NB6SUlBrDfJeLojI5rWVXkU0B
 Gw/41atflZV66CmnUIvrybGA+T0Wg6S5W3bm9ZKCkZyrP6zcvg32GCza0t1lY41nVg
 3iJsOeNnN50hpJ8vCiZugn6gTbZdxALhWT+PnuN43wx+exDMMYATdG2+XDZFn5vgd0
 Xt/85ht5XpeuA==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Michael Walle <mwalle@kernel.org>, Tom Rini <trini@konsulko.com>
CC: Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Benedikt Spranger
 <b.spranger@linutronix.de>, Simon Glass <sjg@chromium.org>, John Ogness
 <john.ogness@linutronix.de>, Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: RE: [PATCH] tiny-printf: Add support for upper case hex values
Thread-Topic: [PATCH] tiny-printf: Add support for upper case hex values
Thread-Index: AQHbmYJXS9LfVQSOoEantzWfxGK4yLN72G+AgAAkmwCAEnYcAIAAcb5ggAEAtgCAAD/j0IAC/m2AgABrtwCABBduAIAAOG8A
Date: Mon, 7 Apr 2025 06:55:35 +0000
Message-ID: <fcd7ade8c011428a91ac1d6f4f924aa4@dh-electronics.com>
References: <20250320102346.13564-1-cniedermaier@dh-electronics.com>
 <a6ab86ac-4404-4081-8529-b8d11b37b5d2@denx.de>
 <ab32ace5-efc0-41b9-8d13-292f6f87835d@cherry.de>
 <D8V6D9S6CBRH.3LRHNU4XCVF14@kernel.org>
 <052e98f6480b4490bd9338eb2f9ed5d2@dh-electronics.com>
 <D8VYKGGMN3DQ.1TYW767T1V3WJ@kernel.org>
 <de267e9022f844cf83bfd3e284c67955@dh-electronics.com>
 <D8XPRUHR9LEF.1K6BBAH3IJS1Q@kernel.org> <20250404145856.GR5495@bill-the-cat>
 <D905PDKW5YBK.34KA6NCU8GLWB@kernel.org>
In-Reply-To: <D905PDKW5YBK.34KA6NCU8GLWB@kernel.org>
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

RnJvbTogTWljaGFlbCBXYWxsZSA8bXdhbGxlQGtlcm5lbC5vcmc+DQpTZW50OiBNb25kYXksIEFw
cmlsIDcsIDIwMjUgNzoyOCBBTQ0KPiBIaSwNCj4gPiA+ID4gPiBJIHdvdWxkbid0IG1pbmQgcHJp
bnRpbmcgdGhlIHBvaW50ZXIgZm9yICVwW21NSV0sIGJ1dCAlcGEgcHJpbnRzIHRoZQ0KPiA+ID4g
PiA+ICpjb250ZW50KiBvZiB0aGUgcG9pbnRlciB3aGljaCBpcyByZWFsbHkgY29uZnVzaW5nLiBJ
LmUuIGluDQo+ID4gPiA+ID4gcGluY3RybC1zaW5nbGUuYyB0aGUgcmVnIHZhbHVlIHBhaXJzIGFy
ZSBwcmludGVkIGxpa2UNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICAgZGV2X2RiZyhkZXYsICJyZWcv
dmFsICVwYS8weCUwOHhcbiIsICZyZWcsIHZhbCk7DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiB3aXRo
IHJlZyBiZWluZyBhIHBvaW50ZXIgdG8gYSBwaHlzaWNhbCBhZGRyZXNzLiBTbyB3aXRoIHRpbnlf
cHJpbnRmDQo+ID4gPiA+ID4gdGhlIGFkZHJlc3Mgb2YgcmVnICh3aGljaCBpcyBhIHBvaW50ZXIg
dG8gdGhlIHN0YWNrKSBpcyBwcmludGVkIGluDQo+ID4gPiA+ID4gdGhpcyBjYXNlLg0KPiA+ID4g
PiA+DQo+ID4gPiA+ID4gSSBkb24ndCB0aGluayB3ZSBjYW4gcHJpbnQgJXAgd2l0aG91dCBwdXR0
aW5nIG1vcmUgbG9naWMgaW50byB0aGUNCj4gPiA+ID4gPiBkZWNvZGluZy4gSSB0aGluayB0aGUg
Y3VscHJpdCBoZXJlIGlzIHRoZSBmYWxsdGhyb3VnaCB0byAleCwgd2hpY2gNCj4gPiA+ID4gPiB0
aGVuIGxlYWRzIHRvIHRoZSBjb25mdXNpbmcgYmVoYXZpb3Igc2hvd24gYWJvdmUuIElNSE8gaWYg
d2Ugd2FudCB0bw0KPiA+ID4gPiA+IGF2b2lkIHRoYXQsIHdlJ2QgaGF2ZSB0byBtYWtlICVwIGVu
dGlyZWx5IHVuc3VwcG9ydGVkLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2xp
Yi90aW55LXByaW50Zi5jIGIvbGliL3RpbnktcHJpbnRmLmMNCj4gPiA+ID4gPiBpbmRleCBmYWY1
NWQ3ZjMyNy4uODE0N2ZmYTJjMWIgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvbGliL3RpbnktcHJp
bnRmLmMNCj4gPiA+ID4gPiArKysgYi9saWIvdGlueS1wcmludGYuYw0KPiA+ID4gPiA+IEBAIC0y
NjksMjEgKzI2OSwxOCBAQCBzdGF0aWMgaW50IF92cHJpbnRmKHN0cnVjdCBwcmludGZfaW5mbyAq
aW5mbywgY29uc3QgY2hhciAqZm10LCB2YV9saXN0IHZhKQ0KPiA+ID4gPiA+ICAJCQkJCQlkaXZf
b3V0KGluZm8sICZudW0sIGRpdik7DQo+ID4gPiA+ID4gIAkJCQl9DQo+ID4gPiA+ID4gIAkJCQli
cmVhazsNCj4gPiA+ID4gPiArI2lmIENPTkZJR19JU19FTkFCTEVEKE5FVCkgfHwgQ09ORklHX0lT
X0VOQUJMRUQoTkVUX0xXSVApIHx8IF9ERUJVRw0KPiA+ID4gPg0KPiA+ID4gPiBXaGF0IGlmIHdl
IGZpbmUtdHVuZSB0aW55cHJpbmYgdmlhIGNvbmZpZyBoZXJlPw0KPiA+ID4gPiBGb3IgZXhhbXBs
ZSBTUExfVVNFX1RJTllfUFJJTlRGX1BPSU5URVJfU1VQUE9SVCBhbmQNCj4gPiA+ID4gc2VsZWN0
IGl0IGJ5IE5FVCBvciBORVRfTFdJUC4gSWYgc29tZW9uZSBuZWVkcyBpdCwNCj4gPiA+ID4gdGhl
IHBvaW50ZXIgb3V0cHV0IGNhbiBiZSBlbmFibGVkLCBvdGhlcndpc2UgJz8nIGZvcg0KPiA+ID4g
PiB1bnN1cHBvcnRlZCBpcyBvdXRwdXQuDQo+ID4gPg0KPiA+ID4gWWVhaCBJIGhhZCBhIHNpbWls
YXIgaWRlYSwgYnV0IEknbSBub3Qgc3VyZSBpZiB5ZXQgYW5vdGhlciBjb25maWcNCj4gPiA+IHN5
bWJvbCBpcyB3b3J0aCBpdC4gVGhhdCdzIHVwIHRvIHRoZSBtYWludGFpbmVyIHRvIGRlY2lkZSA6
KQ0KPiA+ID4NCj4gPiA+IEluIGFueSBjYXNlLCB3ZSBoYXZlIGEgZGlmZmVyZW50IGJlaGF2aW9y
IHRvIHdoYXQgaXMgcHJpbnRlZA0KPiA+ID4gcmlnaHQgbm93LCBhcyB3ZSBkcm9wIHRoZSBmYWxs
dGhyb3VnaCB0byAleC4gVG9tPyBTaW1vbj8NCj4gPg0KPiA+IEEgS2NvbmZpZyBzeW1ib2wgdGhh
dCBORVR8fE5FVF9MV0lQIHNlbGVjdCBzZWVtcyBmaW5lLCBhbmQgZmFsbCB0aHJvdWdoDQo+ID4g
dG8gcHJpbnRpbmcgIj8iLg0KPiANCj4gR3JlYXQhIENocmlzdG9waCwgd2lsbCB5b3UgcHJlcGFy
ZSBhIHBhdGNoIG9yIHNob3VsZCBJPw0KDQpPSywgSSB3aWxsIHByZXBhcmUgYSBwYXRjaC4NCg0K
UmVnYXJkcw0KQ2hyaXN0b3BoDQo=
