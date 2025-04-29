Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B033C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 16:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 636D5829A1;
	Tue, 29 Apr 2025 18:49:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="IvaGvNyN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E54F682A39; Tue, 29 Apr 2025 18:49:42 +0200 (CEST)
Received: from mx3.securetransport.de (mx3.securetransport.de
 [IPv6:2a01:4f8:c0c:92be::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB57E82958
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 18:49:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1745945356;
 bh=5val2fLetrFcuOORSdBip63oLYl/cZS/sSn/JvH9d4w=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=IvaGvNyNDG2ijviHBWC+aF4RM40IhGtLryQ5nmESIeYVGgH2mzfcpvgfdff9HwoW5
 H8CM6xjbpy8KuklIi1qb/wEB216Pl+C/yPym/pVJarU+siiYpJT52bhwdlRNqdyJ43
 TN84NAam5fYGtaf23fRarFlO5cUGtAJcJmO/7BiZ0c3l2tI9bhUwqknODMWm0GMQVj
 OLSiP0isUUmCVEpzEShjfAo5lFk/GF0l5MKIf+fz6tzSuA7BVsNONMoOruQPlentae
 GeDwTOaL1aUiHHDv9Aj6Eyab9gMzIMCgHcabNjvMSZjHsazOM66/FA/+GRvdhrKrLs
 i+PB1PmiYg4mg==
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
Thread-Index: AQHbuRXk+iic1MGqEUWpXwhst71iGbO6ouEAgAAqo3A=
Date: Tue, 29 Apr 2025 16:49:14 +0000
Message-ID: <8c330a4933d0447394ce375b0548e966@dh-electronics.com>
References: <20250429144756.2467039-1-cniedermaier@dh-electronics.com>
 <6ac53871-954f-4321-9ab4-23038216c2ae@denx.de>
In-Reply-To: <6ac53871-954f-4321-9ab4-23038216c2ae@denx.de>
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

RnJvbTogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQpTZW50OiBUdWVzZGF5LCBBcHJpbCAy
OSwgMjAyNSA1OjI4IFBNDQo+IE9uIDQvMjkvMjUgNDo0NyBQTSwgQ2hyaXN0b3BoIE5pZWRlcm1h
aWVyIHdyb3RlOg0KPj4gVGhlIGZvcm1hdHRpbmcgd2l0aCAlcGEgLyAlcGFwIGJlaGF2ZXMgbGlr
ZSAleCwgd2hpY2ggcmVzdWx0cyBpbiBhbg0KPj4gaW5jb3JyZWN0IHZhbHVlIGJlaW5nIG91dHB1
dC4gVG8gaW1wcm92ZSB0aGlzLCBhIG5ldyBmaW5lLXR1bmluZw0KPj4gS2NvbmZpZyBTUExfVVNF
X1RJTllfUFJJTlRGX1BPSU5URVJfU1VQUE9SVCBmb3IgcG9pbnRlciBmb3JtYXR0aW5nDQo+PiBo
YXMgYmVlbiBhZGRlZC4gSWYgaXQgaXMgZW5hYmxlZCwgdGhlIG91dHB1dCBvZiAlcGEgLyAlcGFw
IHNob3VsZA0KPj4gYmUgY29ycmVjdCwgYW5kIGlmIGl0IGlzIGRpc2FibGVkLCB0aGUgcG9pbnRl
ciBmb3JtYXR0aW5nIGlzDQo+PiBjb21wbGV0ZWx5IHVuc3VwcG9ydGVkLiBJbiBhZGRpdGlvbiB0
byBpbmRpY2F0ZSB1bnN1cHBvcnRlZCBmb3JtYXR0aW5nLA0KPj4gJz8nIHdpbGwgYmUgb3V0cHV0
LiBUaGlzIGFsbG93cyBlbmFibGluZyBwb2ludGVyIGZvcm1hdHRpbmcgb25seQ0KPj4gd2hlbiBu
ZWVkZWQuIEZvciBTUExfTkVUIGFuZCBORVRfTFdJUCBpdCBpcyBzZWxlY3RlZCBieSBkZWZhdWx0
Lg0KPj4gVGhlbiBpdCBhbHNvIHN1cHBvcnRzIHRoZSBmb3JtYXR0aW5nIHdpdGggJXBtLCAlcE0g
YW5kICVwSTQuDQo+Pg0KPj4gSW4gc3VtbWVyeSB0aGlzIGxldmVsIG9mICVwIHN1cHBvcnQgZm9y
IHRpbnkgcHJpbnRmIGlzIHBvc3NpYmxlIG5vdzoNCj4+DQo+PiAxKSBUaGUgc3RhbmRhcmQgdGlu
eSBwcmludGYgd29uJ3QgaGF2ZSBzdXBwb3J0IGZvciBwb2ludGVyIGZvcm1hdHRpbmcuDQo+PiAg
ICAgU28gaXQgZG9lc24ndCBwcmludCBtaXNsZWFkaW5nIHZhbHVlcyBmb3IgJXBhLCBpbnN0ZWFk
ICc/JyB3aWxsIGJlDQo+PiAgICAgb3V0cHV0Og0KPj4gICAgICVwICAgPT4gPw0KPj4gICAgICVw
YSAgPT4gP2ENCj4+ICAgICAlcGFwID0+ID9hcA0KPj4NCj4+IDIpIElmIFNQTF9VU0VfVElOWV9Q
UklOVEZfUE9JTlRFUl9TVVBQT1JUIGlzIGVuYWJsZWQgb3IgREVCVUcgaXMgZGVmaW5lZA0KPj4g
ICAgIHRpbnkgcHJpbnRmIHN1cHBvcnRzIGZvcm1hdHRpbmcgJXAgYW5kICVwYSAvICVwYXAuDQo+
Pg0KPj4gMykgSWYgU1BMX05FVCBvciBORVRfTFdJUCBpcyBlbmFibGVkIHRoZSBzdXBwb3J0IG9m
IHBvaW50ZXJzIGlzIGV4dGVuZGVkDQo+PiAgICAgZm9yICVwbSwgJXBNIGFuZCAlcEk0Lg0KPiBJ
ZiB5b3UgbmVlZCByaWNoIHByaW50ZiBmb3JtYXR0aW5nIHN1cHBvcnQgLCBlbmFibGUgZnVsbCBw
cmludGYgaW5zdGVhZD8NCg0KSXQgaXMgbm90IGFib3V0IGV4dGVuZGluZyB0aW55IHByaW50ZiB3
aXRoIG1vcmUgZm9ybWF0dGluZy4gVGhlIGN1cnJlbnQNCnN1cHBvcnQgZm9yIHBvaW50ZXJzIGxl
YWRzIHRvIHRoZSBwcmludGluZyBvZiBtaXNsZWFkaW5nIHZhbHVlcy4gVGhpcyBwYXRjaA0KcmVt
b3ZlcyB0aGUgc3VwcG9ydCBmb3IgcG9pbnRlcnMsIGJ1dCBtYWtlcyB0aGUgYWxyZWFkeSBleGlz
dGluZyBwb2ludGVyDQpzdXBwb3J0IGZvciAlcGEgLyAlcGFwIG9wdGlvbmFsLiBUaGUgZXhpc3Rp
bmcgc3VwcG9ydCBmb3IgJXBtLCAlcE0gYW5kICVwSTQNCmVuYWJsZWQgYnkgU1BMX05FVCBvciBO
RVRfTFdJUCBDT05GIGhhcyByZW1haW5lZCBmdW5jdGlvbmFsbHkgdGhlIHNhbWUuDQoNClJlZ2Fy
ZHMNCkNocmlzdG9waA0K
