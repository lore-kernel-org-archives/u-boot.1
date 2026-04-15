Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C1CFA0C5A
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 08:55:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A943083E36;
	Wed, 15 Apr 2026 10:55:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="EXmpyXgq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C106F84129; Wed, 15 Apr 2026 10:55:17 +0200 (CEST)
Received: from mx3.securetransport.de (mx3.securetransport.de
 [IPv6:2a01:4f8:c0c:92be::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B12CB83936
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 10:55:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1776243307;
 bh=wAqveU9dhOucOVUIK9EOdedaMmTjwYODx8tWoeucCAg=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=EXmpyXgqi43bwPmaTnaopLifhmbxhK0Itt4KE4vaPlRo86x11WM2qmSumBuVv/hDu
 e0kB4n0kMB0O2yHqP/4aVbLT1kZYB2HCokT0ZD5ZTDLzMhhuSubkUxqK4aIutZMq2H
 /5VG7N1tHRYbA63VshujTJnpeHMSMQE6oxTScK3D3mSvhzs+2jPnts0TDO0/RqGch0
 ly/tjKQIjwe20uz3x6phOX7Wc3GctobPMajZu10FLQE35HMslu2JM7hcOPD6AgquBJ
 I878nlv0QFY1tu2eWuTBQwE6R9poXdwHEaBHJh8Xto5vdcVd9avVpsiFLQ9XS9YyFD
 CesLoDB7Ij34g==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Marek Vasut <marex@nabladev.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Peng Fan <peng.fan@nxp.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot <u-boot@dh-electronics.com>
Subject: RE: [PATCH V2] board: dhelectronics: imx: Use second Ethernet MAC
 also from fuse
Thread-Topic: [PATCH V2] board: dhelectronics: imx: Use second Ethernet MAC
 also from fuse
Thread-Index: AQHcwq59IKNEXiUV00K6AcV5oHy4OLXMoeQAgBNC3bA=
Date: Wed, 15 Apr 2026 08:55:04 +0000
Message-ID: <777338f432944ee78bc0a3f89ce7c585@dh-electronics.com>
References: <20260402143753.40142-1-cniedermaier@dh-electronics.com>
 <f33fd3f7-fbab-44d4-bce8-e33d8d03b933@nabladev.com>
In-Reply-To: <f33fd3f7-fbab-44d4-bce8-e33d8d03b933@nabladev.com>
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

RnJvbTogTWFyZWsgVmFzdXQgPG1hcmV4QG5hYmxhZGV2LmNvbT4NClNlbnQ6IEZyaWRheSwgQXBy
aWwgMywgMjAyNiA2OjQzIEFNDQo+IE9uIDQvMi8yNiA0OjM3IFBNLCBDaHJpc3RvcGggTmllZGVy
bWFpZXIgd3JvdGU6DQo+PiBDdXJyZW50bHksIHRoZSBib2FyZCBzcGVjaWZpYyBjb2RlIGV2YWx1
YXRlcyBvbmx5IHRoZSBmaXJzdCBFdGhlcm5ldA0KPj4gTUFDIGFkZHJlc3MgZnVzZSwgcmVnYXJk
bGVzcyBvZiB3aGV0aGVyIHRoZSBmaXJzdCBvciBzZWNvbmQgTUFDDQo+PiBhZGRyZXNzIGlzIHJl
cXVlc3RlZC4gV2hlbiB0aGUgZnVuY3Rpb24gZm9yIGRldGVybWluZSB0aGUgc2Vjb25kDQo+PiBF
dGhlcm5ldCBNQUMgYWRkcmVzcyBpcyBsb29raW5nIGZvciB0aGUgZnVzZWQgTUFDIGFkZHJlc3Ms
IGl0IG9ubHkNCj4+IHJlYWRzIHRoZSBmaXJzdCBNQUMgYWRkcmVzcyBmdXNlIGFuZCBpbmNyZW1l
bnQgaXQgYnkgb25lIHRvIHNldA0KPj4gdGhlIHNlY29uZCBFdGhlcm5ldCBNQUMgYWRkcmVzcy4g
VGhhdCBpcyBub3QgdGhlIGV4cGVjdGVkIGJlaGF2aW9yDQo+PiB3aGVuIHR3byBNQUMgYWRkcmVz
c2VzIGFyZSBmdXNlZCwgYmVjYXVzZSB0aGlzIGNhdXNlcyB0aGUgc2Vjb25kDQo+PiBmdXNlZCBN
QUMgYWRkcmVzcyB0byBiZSBpZ25vcmVkLiBDaGFuZ2UgdGhpcyBzbyB0aGF0IHRoZSBzZWNvbmQN
Cj4+IGZ1c2VkIE1BQyBhZGRyZXNzIHdpbGwgYmUgdXNlZC4NCj4+DQo+PiBJbiBhZGRpdGlvbiwg
dGhlIGhhbmRsaW5nIG9mIHRoZSBNQUMgYWRkcmVzcyBmb3IgZWFybHkgcHJvdG90eXBlcw0KPj4g
d2lsbCBiZSByZW1vdmVkLCBhcyBzdWNoIFNvTXMgd2VyZSBub3QgdXNlZCBieSBjdXN0b21lcnMu
DQo+IA0KPiBUaGlzIF4gc2hvdWxkIGJlIGtlcHQuDQoNCldpbGwgY2hhbmdlIHRoaXMgaW4gVjMu
DQoNCj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBOaWVkZXJtYWllciA8Y25pZWRlcm1haWVy
QGRoLWVsZWN0cm9uaWNzLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5A
bnhwLmNvbT4NCj4gDQo+IFJCIGdvZXMgYWJvdmUgU29CIGxpbmUNCg0KV2lsbCBmaXggaXQgaW4g
VjMuDQoNCj4gWy4uLl0NCj4gDQo+PiBAQCAtODQsMTkgKzg0LDggQEAgc3RhdGljIGludCBkaF9p
bXg4X3NldHVwX2V0aDFhZGRyKHN0cnVjdCBlZXByb21faWRfcGFnZSAqZWlwKQ0KPj4gICAgICAg
aWYgKCFkaF9nZXRfbWFjX2Zyb21fZWVwcm9tKGVuZXRhZGRyLCAiZWVwcm9tMSIpKQ0KPj4gICAg
ICAgICAgICAgICBnb3RvIG91dDsNCj4+DQo+PiAtICAgICAvKg0KPj4gLSAgICAgICogUG9wdWxh
dGUgc2Vjb25kIGV0aGVybmV0IE1BQyBmcm9tIGZpcnN0IGV0aGVybmV0IEVFUFJPTSB3aXRoIE1B
Qw0KPj4gLSAgICAgICogYWRkcmVzcyBMU0J5dGUgaW5jcmVtZW50ZWQgYnkgMS4gVGhpcyBpcyBv
bmx5IHVzZWQgb24gU29NcyB3aXRob3V0DQo+PiAtICAgICAgKiBzZWNvbmQgZXRoZXJuZXQgRUVQ
Uk9NLCBpLmUuIGVhcmx5IHByb3RvdHlwZXMuDQo+PiAtICAgICAgKi8NCj4+IC0gICAgIGlmICgh
ZGhfZ2V0X21hY19mcm9tX2VlcHJvbShlbmV0YWRkciwgImVlcHJvbTAiKSkNCj4+IC0gICAgICAg
ICAgICAgZ290byBpbmNyZW1lbnRfb3V0Ow0KPj4gLQ0KPj4gICAgICAgcmV0dXJuIC1FTlhJTzsN
Cj4+DQo+PiAtaW5jcmVtZW50X291dDoNCj4+IC0gICAgIGVuZXRhZGRyWzVdKys7DQo+PiAtDQo+
PiAgIG91dDoNCj4+ICAgICAgIHJldHVybiBldGhfZW52X3NldF9lbmV0YWRkcigiZXRoMWFkZHIi
LCBlbmV0YWRkcik7DQo+PiAgIH0NCj4gDQo+IFBsZWFzZSBrZWVwIHRoaXMgXiBodW5rLCB0aGUg
cmVzdCBpcyBmaW5lLCB0aGFuayB5b3UuDQoNCldpbGwgcmV2ZXJ0IGl0IGluIFYzLg0KDQoNClJl
Z2FyZHMNCkNocmlzdG9waA0K
