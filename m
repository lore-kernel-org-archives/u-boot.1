Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C550C36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 16:24:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADBBB81253;
	Wed, 26 Mar 2025 17:24:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="oxDuRUJf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51A4781B42; Wed, 26 Mar 2025 17:24:33 +0100 (CET)
Received: from mx2.securetransport.de (mx2.securetransport.de
 [IPv6:2a03:4000:13:6c7::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F408F810E8
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 17:24:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1743005005;
 bh=Aiwe7utK1TweQeFtJF7FgkwcVQtoNB5JptvOTEWWy40=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=oxDuRUJfCzDnuJ1YDSLiHoGsJUDA9AQ0yEJm3t/K2p1Sf4gYaSMtmPd+pMQZLHd2E
 DxDxdlLHTTp+0nJT9T6Ix+FmUrc1iDNKBr0yVoAQb0R2YCDXTzcIFrcveSB9NaotmE
 C/KZ2CA+P19JjvjBquJAfo2RAMDzqL4btKxvfuyaihmWWCGGM2MRl+ICJN5l7r4XPU
 3s+mkHtg7mOIQns9gElhqOAhnTjBZb5BZ+MG542hK1QL9mmRFhlMGLXwEN/naANd+1
 JSsC6vqtmGZ3Dza0k//KKU5f5OKtHHbMbrkq8YKl0whPPL7C8EozmUxnfEBYKOD7Jd
 o3QrQelpShxUg==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>
Subject: RE: [PATCH V2] cmd: env: select: Add output for available evironment
 targets
Thread-Topic: [PATCH V2] cmd: env: select: Add output for available evironment
 targets
Thread-Index: AQHbmpFivIZenhQ1FkO4CJlGJQedFLN952SAgAey9QA=
Date: Wed, 26 Mar 2025 16:02:54 +0000
Message-ID: <8a6f66eb182744a3b6d53dfb62623ed8@dh-electronics.com>
References: <20250321184357.4079845-1-cniedermaier@dh-electronics.com>
 <1fac6372-b251-4778-b3fe-7f7eda3aac8f@denx.de>
In-Reply-To: <1fac6372-b251-4778-b3fe-7f7eda3aac8f@denx.de>
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

RnJvbTogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQpTZW50OiBGcmlkYXksIE1hcmNoIDIx
LCAyMDI1IDg6MjMgUE0NCj4gT24gMy8yMS8yNSA3OjQzIFBNLCBDaHJpc3RvcGggTmllZGVybWFp
ZXIgd3JvdGU6DQo+PiBBZGQgcGFyYW1ldGVyICItbCIgZm9yIHByaW50aW5nIGF2YWlsYWJsZSBl
bnZpcm9ubWVudCB0YXJnZXRzLiBUaGUNCj4+IGFjdGl2ZSB0YXJnZXQgaXMgbWFya2VkIHdpdGgg
YW4gYXN0ZXJpc2suIFRoaXMgaXMgZG9uZSBieSBhZGRpbmcNCj4+IHRoZSBmdW5jdGlvbiBlbnZf
c2VsZWN0X3ByaW50X2xpc3QoKS4NCj4+DQo+PiBJZiAiZW52IHNlbGVjdCIgaXMgY2FsbGVkIHdp
dGhvdXQgYSB0YXJnZXQgcGFyYW1ldGVyIHRoZSByZXN1bHQgaXMNCj4+ICJTZWxlY3QgRW52aXJv
bm1lbnQgb24gPE5VTEw+OiBkcml2ZXIgbm90IGZvdW5kIi4gUmVwbGFjZSB0aGlzIG5vdA0KPj4g
c28gdXNlZnVsIG91dHB1dCBieSBzaG93aW5nIHRoZSBlbnYgdXNhZ2UgbWVzc2FnZSBpbnN0ZWFk
Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBOaWVkZXJtYWllciA8Y25pZWRlcm1h
aWVyQGRoLWVsZWN0cm9uaWNzLmNvbT4NCj4+IC0tLQ0KPj4gQ2M6IE1hcmVrIFZhc3V0IDxtYXJl
eEBkZW54LmRlPg0KPj4gQ2M6IFBhdHJpY2sgRGVsYXVuYXkgPHBhdHJpY2suZGVsYXVuYXlAZm9z
cy5zdC5jb20+DQo+PiBDYzogSm9lIEhlcnNoYmVyZ2VyIDxqb2UuaGVyc2hiZXJnZXJAbmkuY29t
Pg0KPj4gQ2M6IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+DQo+PiAtLS0NCj4+IFYyOiAt
IFNob3dpbmcgYXZhaWxhYmxlIGVudmlyb25tZW50IHRhcmdldHMgYnkgcGFyYW1ldGVyICItbCIN
Cj4+ICAgICAgLSBTaG93aW5nIGVudiB1c2FnZSBtZXNzYWdlIGlmIGVudiBzZWxlY3QgaXMgY2Fs
bGVkIHdpdGhvdXQgYSB0YXJnZXQNCj4+IC0tLQ0KPj4gICBjbWQvbnZlZGl0LmMgIHwgMTkgKysr
KysrKysrKysrKysrKysrLQ0KPj4gICBlbnYvZW52LmMgICAgIHwgMTYgKysrKysrKysrKysrKysr
Kw0KPj4gICBpbmNsdWRlL2Vudi5oIHwgIDcgKysrKysrKw0KPj4gICAzIGZpbGVzIGNoYW5nZWQs
IDQxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvY21k
L252ZWRpdC5jIGIvY21kL252ZWRpdC5jDQo+PiBpbmRleCAxZjI1OTgwMTI5My4uZGU2NDA5NGRi
NGQgMTAwNjQ0DQo+PiAtLS0gYS9jbWQvbnZlZGl0LmMNCj4+ICsrKyBiL2NtZC9udmVkaXQuYw0K
Pj4gQEAgLTQ5OSw2ICs0OTksMjMgQEAgc3RhdGljIGludCBkb19lbnZfbG9hZChzdHJ1Y3QgY21k
X3RibCAqY21kdHAsIGludCBmbGFnLCBpbnQgYXJnYywNCj4+ICAgc3RhdGljIGludCBkb19lbnZf
c2VsZWN0KHN0cnVjdCBjbWRfdGJsICpjbWR0cCwgaW50IGZsYWcsIGludCBhcmdjLA0KPj4gICAJ
CQkgY2hhciAqY29uc3QgYXJndltdKQ0KPj4gICB7DQo+PiArCWlmICghYXJndlsxXSkNCj4+ICsJ
CXJldHVybiBDTURfUkVUX1VTQUdFOw0KPj4gKw0KPj4gKwl3aGlsZSAoYXJnYyA+IDEgJiYgKioo
YXJndiArIDEpID09ICctJykgew0KPiBUd28gaGlnaGVyIGxldmVsIHRoaW5nczoNCj4gDQo+IC0g
Q2FuIHlvdSBmaXJzdCBjb252ZXJ0IGNtZC9udmVkaXQuaCB0byB1c2UgaW5jbHVkZS9nZXRvcHQu
aCBhbmQgdGhlbg0KPiAgICB1c2UgZ2V0b3B0KCkgaGVyZSB0b28gPyBUaGlzIGhhbmQgcm9sbGVk
IGFyZyBwYXJzaW5nIGlzIHJlcHVsc2l2ZSwNCj4gICAgdGhlIG11bHRpcGxlIGFkLWhvYyBjb3Bp
ZXMgb2YgdGhhdCBhcmUgZXZlbiB3b3JzZS4NCg0KSSB3aWxsIHRyeS4NCg0KPiAtIFBsZWFzZSB3
cml0ZSBhIHRlc3QgZm9yIHRoaXMsIHNlZSB0ZXN0L2NtZC8gLCBtYXliZSBTaW1vbiBjYW4gaGVs
cA0KPiAgICB3aXRoIGRldGFpbHMgb2YgdGhpcyAuLi4gPw0KDQpJIHdpbGwgdHJ5Lg0KDQoNClJl
Z2FyZHMNCkNocmlzdG9waA0K
