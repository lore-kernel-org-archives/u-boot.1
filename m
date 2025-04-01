Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A93C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 14:08:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3492A81703;
	Tue,  1 Apr 2025 16:08:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="D/Mz1Yor";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7A2E8171B; Tue,  1 Apr 2025 16:08:52 +0200 (CEST)
Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72E7E801BE
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 16:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1743516486;
 bh=jakAqX8qLkPy+BP2IgyLWcaH8oQpq+WlcQd+RDDl1Jk=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=D/Mz1Yorq9frPVGMjE8vv6HYJln3nTD2XiIxq2u7vrHMtFksAIwLYAipSz+ueKe38
 4PA0+1FKB8RWNpQOaZ//XxqzQgpfghHgNwai3oxBxCU0KXBhBTCFbm/nfUJG+oR2dq
 A9XbD0kleA7Yir0sfKdlQtzYlvkxoNRLr3tlxekbF9ZSfnYpCOgf/jLxP9Lq84mZG8
 KPq03VYbgF6tw8FTcGEAn1C5dxEWIQvuTtyjx1ghR/jSWpLB/TBDLDm+BBKfl/eyfO
 vjbrpIHhPEUS7xCP7hKEPG1Qt36LMMbRvGqHvZAqMoNRgOGINwAGNnn95LJC+3s1BI
 lhUZrvN1qOgrw==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Michael Walle <mwalle@kernel.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, Marek Vasut <marex@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Benedikt Spranger
 <b.spranger@linutronix.de>, Simon Glass <sjg@chromium.org>, John Ogness
 <john.ogness@linutronix.de>, Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: RE: [PATCH] tiny-printf: Add support for upper case hex values
Thread-Topic: [PATCH] tiny-printf: Add support for upper case hex values
Thread-Index: AQHbmYJXS9LfVQSOoEantzWfxGK4yLN72G+AgAAkmwCAEnYcAIAAcb5g
Date: Tue, 1 Apr 2025 14:08:03 +0000
Message-ID: <052e98f6480b4490bd9338eb2f9ed5d2@dh-electronics.com>
References: <20250320102346.13564-1-cniedermaier@dh-electronics.com>
 <a6ab86ac-4404-4081-8529-b8d11b37b5d2@denx.de>
 <ab32ace5-efc0-41b9-8d13-292f6f87835d@cherry.de>
 <D8V6D9S6CBRH.3LRHNU4XCVF14@kernel.org>
In-Reply-To: <D8V6D9S6CBRH.3LRHNU4XCVF14@kernel.org>
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

RnJvbTogTWljaGFlbCBXYWxsZSA8bXdhbGxlQGtlcm5lbC5vcmc+DQpTZW50OiBUdWVzZGF5LCBB
cHJpbCAxLCAyMDI1IDEwOjU2IEFNDQo+IA0KPiBIaSwNCj4gDQo+PiBUaGUgaXNzdWUgaXMgdGhh
dCBkaXNhYmxpbmcgVElOWV9QUklOVEYgbWF5IG5vdCBiZSBwb3NzaWJsZSAoc2l6ZQ0KPj4gY29u
c3RyYWludHMpIGFuZCBzb21lIGNvZGUgaXMgY29tcGlsZWQgZm9yIGRpZmZlcmVudCBzdGFnZXMg
YW5kIHBlb3BsZQ0KPj4gdHlwaWNhbGx5IGRvbid0IGNoZWNrIHdoZXRoZXIgdGhlIGZvcm1hdCB1
c2VkIGluIHByaW50ZiBpcyB2YWxpZCB3aXRoDQo+PiB0aW55X3ByaW50Zi4gSSd2ZSBoYWQgdGhp
cyBpc3N1ZSBhbHJlYWR5IGluIHRoZSBwYXN0LCBJIHZhZ3VlbHkgcmVjYWxsDQo+PiAiY29tcGxh
aW5pbmciIGFib3V0IGl0IG9uIElSQy4NCj4gDQo+IFllcywgSSd2ZSBzdHVtYmxlZCBvbiAiJXBh
IiB3aXRoIHRpbnkgcHJpbnRmIChpLmUuIGluDQo+IGRyaXZlcnMvcGluY3RybC9waW5jdHJsLXNp
bmdsZS5jKSB3aGljaCBpcyBwcmludGluZyB0aGUgdmVyeSB3cm9uZw0KPiB2YWx1ZSwgYWN0dWFs
bHkgOikgU28gcHJpbnRpbmcgYW55dGhpbmcgdW5rbm93biBhcyAnPycgd291bGQgcmVhbGx5DQo+
IGhlbHAgaGVyZS4NCg0KU29tZXRoaW5nIGxpa2UgdGhhdCB3b3VsZCBoZWxwOg0KZGlmZiAtLWdp
dCBhL2xpYi90aW55LXByaW50Zi5jIGIvbGliL3RpbnktcHJpbnRmLmMNCmluZGV4IDQ4ZGI3YjFm
NzhmLi5iOTE4ZDZkNzM4NiAxMDA2NDQNCi0tLSBhL2xpYi90aW55LXByaW50Zi5jDQorKysgYi9s
aWIvdGlueS1wcmludGYuYw0KQEAgLTI4MCw2ICsyODAsMTIgQEAgc3RhdGljIGludCBfdnByaW50
ZihzdHJ1Y3QgcHJpbnRmX2luZm8gKmluZm8sIGNvbnN0IGNoYXIgKmZtdCwgdmFfbGlzdCB2YSkN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB3aGlsZSAoaXNhbG51bShm
bXRbMF0pKQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Zm10Kys7DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0gZWxzZSB7DQorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGZtdFswXSAhPSAnXDAnICYmIChmbXRbMF0gPT0g
J2EnIHx8IGZtdFswXSA9PSAnbScgfHwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZtdFswXSA9PSAnTScgfHwgZm10WzBdID09
ICdJJykpIHsNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGZtdCsrOw0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Z290byB1bnN1cHBvcnRlZDsNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB9DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0NCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgaXNsb25nID0gdHJ1ZTsNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgLyogbm8gYnJlYWsgKi8NCkBAIC0zMDgsNiArMzE0LDggQEAgc3RhdGljIGludCBfdnBy
aW50ZihzdHJ1Y3QgcHJpbnRmX2luZm8gKmluZm8sIGNvbnN0IGNoYXIgKmZtdCwgdmFfbGlzdCB2
YSkNCiAgICAgICAgICAgICAgICAgICAgICAgIGNhc2UgJyUnOg0KICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBvdXQoaW5mbywgJyUnKTsNCiAgICAgICAgICAgICAgICAgICAgICAgIGRl
ZmF1bHQ6DQordW5zdXBwb3J0ZWQ6DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG91
dChpbmZvLCAnPycpOw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCiAg
ICAgICAgICAgICAgICAgICAgICAgIH0NCg0KQnV0IG1heWJlIGl0IGlzIHRvbyBtdWNoIGZvciB0
aW55IHByaW50ZiwgYmVjYXVzZSB0aW55IG1lYW5zDQp0aW55LiBJdCdzIGEgcXVlc3Rpb24gb2Yg
ZWl0aGVyIGdhaW4gb3Igc21hbGwgY29kZSBzaXplLg0KDQpSZWdhcmRzDQpDaHJpc3RvcGgNCg==
