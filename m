Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD82C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 10:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EFDB8283E;
	Wed, 30 Apr 2025 12:36:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="k9BOOftu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D400C8283E; Wed, 30 Apr 2025 12:36:42 +0200 (CEST)
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A10B08215E
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 12:36:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1746009345;
 bh=5wtZ1PuV9L1jtKWkUtSZlF2x4KiFlXy1OZbejy2tnfc=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=k9BOOftuJ3uujKjVzTlOrWPaBt8rJLnDHqgs8PlnrVf3vcfsSEOsOGMM+s2zubX3w
 3iyq8TohC1fBnd0z07WjuzbP0IWMvgrq3ybnixoGg1oV3fshFQrxV1N1p+CQUePAGI
 fWPYR3/XhEiPBm0Bdg2HOIgdn+1iPVhcVqmM0rbYjG7y/v2DhRUXt1vHPQAt26gcvV
 VJvyHJZVM7YkeWofCD3n21R5eEU6nY1O5kK2qeTsxthao8GaFpBw60rmXXCJeXiuZ0
 myCaxPhIb+Wt4kdOsqq1qxBEKQrirNBFla5fWqwz1/8tBuL+cA3D1/Epgftp52FUzl
 uyFCvpQWJIiYw==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, "Michael
 Walle" <mwalle@kernel.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Benedikt Spranger <b.spranger@linutronix.de>, Jerome Forissier
 <jerome.forissier@linaro.org>, John Ogness <john.ogness@linutronix.de>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Subject: RE: [PATCH V2] tiny-printf: Handle formatting of %p with an extra
 Kconfig
Thread-Topic: [PATCH V2] tiny-printf: Handle formatting of %p with an extra
 Kconfig
Thread-Index: AQHbuRXk+iic1MGqEUWpXwhst71iGbO6ouEAgAAqo3CAATaWgA==
Date: Wed, 30 Apr 2025 10:35:30 +0000
Message-ID: <b8ad1ab5a2b14f7f8a895b855ca26990@dh-electronics.com>
References: <20250429144756.2467039-1-cniedermaier@dh-electronics.com>
 <6ac53871-954f-4321-9ab4-23038216c2ae@denx.de>
 <8c330a4933d0447394ce375b0548e966@dh-electronics.com>
In-Reply-To: <8c330a4933d0447394ce375b0548e966@dh-electronics.com>
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

RnJvbTogQ2hyaXN0b3BoIE5pZWRlcm1haWVyDQpTZW50OiBUdWVzZGF5LCBBcHJpbCAyOSwgMjAy
NSA2OjQ5IFBNDQo+IEZyb206IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPg0KPiBTZW50OiBU
dWVzZGF5LCBBcHJpbCAyOSwgMjAyNSA1OjI4IFBNDQo+PiBPbiA0LzI5LzI1IDQ6NDcgUE0sIENo
cmlzdG9waCBOaWVkZXJtYWllciB3cm90ZToNCj4+PiBUaGUgZm9ybWF0dGluZyB3aXRoICVwYSAv
ICVwYXAgYmVoYXZlcyBsaWtlICV4LCB3aGljaCByZXN1bHRzIGluIGFuDQo+Pj4gaW5jb3JyZWN0
IHZhbHVlIGJlaW5nIG91dHB1dC4gVG8gaW1wcm92ZSB0aGlzLCBhIG5ldyBmaW5lLXR1bmluZw0K
Pj4+IEtjb25maWcgU1BMX1VTRV9USU5ZX1BSSU5URl9QT0lOVEVSX1NVUFBPUlQgZm9yIHBvaW50
ZXIgZm9ybWF0dGluZw0KPj4+IGhhcyBiZWVuIGFkZGVkLiBJZiBpdCBpcyBlbmFibGVkLCB0aGUg
b3V0cHV0IG9mICVwYSAvICVwYXAgc2hvdWxkDQo+Pj4gYmUgY29ycmVjdCwgYW5kIGlmIGl0IGlz
IGRpc2FibGVkLCB0aGUgcG9pbnRlciBmb3JtYXR0aW5nIGlzDQo+Pj4gY29tcGxldGVseSB1bnN1
cHBvcnRlZC4gSW4gYWRkaXRpb24gdG8gaW5kaWNhdGUgdW5zdXBwb3J0ZWQgZm9ybWF0dGluZywN
Cj4+PiAnPycgd2lsbCBiZSBvdXRwdXQuIFRoaXMgYWxsb3dzIGVuYWJsaW5nIHBvaW50ZXIgZm9y
bWF0dGluZyBvbmx5DQo+Pj4gd2hlbiBuZWVkZWQuIEZvciBTUExfTkVUIGFuZCBORVRfTFdJUCBp
dCBpcyBzZWxlY3RlZCBieSBkZWZhdWx0Lg0KPj4+IFRoZW4gaXQgYWxzbyBzdXBwb3J0cyB0aGUg
Zm9ybWF0dGluZyB3aXRoICVwbSwgJXBNIGFuZCAlcEk0Lg0KPj4+DQo+Pj4gSW4gc3VtbWVyeSB0
aGlzIGxldmVsIG9mICVwIHN1cHBvcnQgZm9yIHRpbnkgcHJpbnRmIGlzIHBvc3NpYmxlIG5vdzoN
Cj4+Pg0KPj4+IDEpIFRoZSBzdGFuZGFyZCB0aW55IHByaW50ZiB3b24ndCBoYXZlIHN1cHBvcnQg
Zm9yIHBvaW50ZXIgZm9ybWF0dGluZy4NCj4+PiAgICAgU28gaXQgZG9lc24ndCBwcmludCBtaXNs
ZWFkaW5nIHZhbHVlcyBmb3IgJXBhLCBpbnN0ZWFkICc/JyB3aWxsIGJlDQo+Pj4gICAgIG91dHB1
dDoNCj4+PiAgICAgJXAgICA9PiA/DQo+Pj4gICAgICVwYSAgPT4gP2ENCj4+PiAgICAgJXBhcCA9
PiA/YXANCj4+Pg0KPj4+IDIpIElmIFNQTF9VU0VfVElOWV9QUklOVEZfUE9JTlRFUl9TVVBQT1JU
IGlzIGVuYWJsZWQgb3IgREVCVUcgaXMgZGVmaW5lZA0KPj4+ICAgICB0aW55IHByaW50ZiBzdXBw
b3J0cyBmb3JtYXR0aW5nICVwIGFuZCAlcGEgLyAlcGFwLg0KPj4+DQo+Pj4gMykgSWYgU1BMX05F
VCBvciBORVRfTFdJUCBpcyBlbmFibGVkIHRoZSBzdXBwb3J0IG9mIHBvaW50ZXJzIGlzIGV4dGVu
ZGVkDQo+Pj4gICAgIGZvciAlcG0sICVwTSBhbmQgJXBJNC4NCj4+IElmIHlvdSBuZWVkIHJpY2gg
cHJpbnRmIGZvcm1hdHRpbmcgc3VwcG9ydCAsIGVuYWJsZSBmdWxsIHByaW50ZiBpbnN0ZWFkPw0K
PiANCj4gSXQgaXMgbm90IGFib3V0IGV4dGVuZGluZyB0aW55IHByaW50ZiB3aXRoIG1vcmUgZm9y
bWF0dGluZy4gVGhlIGN1cnJlbnQNCj4gc3VwcG9ydCBmb3IgcG9pbnRlcnMgbGVhZHMgdG8gdGhl
IHByaW50aW5nIG9mIG1pc2xlYWRpbmcgdmFsdWVzLiBUaGlzIHBhdGNoDQo+IHJlbW92ZXMgdGhl
IHN1cHBvcnQgZm9yIHBvaW50ZXJzLCBidXQgbWFrZXMgdGhlIGFscmVhZHkgZXhpc3RpbmcgcG9p
bnRlcg0KPiBzdXBwb3J0IGZvciAlcGEgLyAlcGFwIG9wdGlvbmFsLiBUaGUgZXhpc3Rpbmcgc3Vw
cG9ydCBmb3IgJXBtLCAlcE0gYW5kICVwSTQNCj4gZW5hYmxlZCBieSBTUExfTkVUIG9yIE5FVF9M
V0lQIENPTkYgaGFzIHJlbWFpbmVkIGZ1bmN0aW9uYWxseSB0aGUgc2FtZS4NCg0KU29ycnksIEkg
aGF2ZSBub3RpY2VkIHRoYXQgaW4gVjIgdGhlIG91dHB1dCBvZiAnPycgaXMgbWlzc2luZyBpbiB0
aGUNCmRlZmF1bHQgY2FzZS4gSSB3aWxsIGZpeCBpdCBpbiBWMy4NCg0KUmVnYXJkcw0KQ2hyaXN0
b3BoDQo=
