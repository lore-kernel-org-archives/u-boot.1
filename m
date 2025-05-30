Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A5AC5AD49
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 19:23:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23C0B82C15;
	Fri, 30 May 2025 21:23:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="A96FbN34";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B475782C49; Fri, 30 May 2025 21:23:52 +0200 (CEST)
Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 979B282AFC
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 21:23:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1748633013;
 bh=g0UcZwf8T9/FQKNyFOGiXTI62+iQIEOsn17O0nXRRwc=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=A96FbN34vYD7pJKZqf37Mrn6W5qEjG/xoqEPa6xHR/wkormWk+vb2nH8x9BZBaPIW
 BluC/4v6Jx07jmNNlS18BQoiziTiIQsP9F8o79vm8JIMXqlK29fWM6Rz/NC0u9LdtH
 kbiznpUapr9boJupIqoyOlpug4aNfS+un/4waExVEACVq4XrFWbK3JhzIBHVhtF8JC
 Rrh8gwzpAcErIvwlcINWNNT0OmdFHI/gOYcbdRcKbRQgx6VbJkeul0qeEHMJ2eMf2C
 nqBXdDm3XoYBslr0kNsuZaMmVWgtHS08RbT2mYVadeeG7y6X87SLKsr8C6kcs8W3Xw
 qyrdxA7FYik2Q==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: U-Boot-Denx <u-boot@lists.denx.de>, linux-amarula
 <linux-amarula@amarulasolutions.com>, Peng Fan <peng.fan@nxp.com>, Adam Ford
 <aford173@gmail.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Stefano Babic
 <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH v3 1/4] clk: imx: add i.MX6UL clk driver
Thread-Topic: [PATCH v3 1/4] clk: imx: add i.MX6UL clk driver
Thread-Index: AQHb0FgEZAQHOs0ZHEi7FlTaxZPL4bPrKVXw///+9YCAAFAfIP//5HeAgAAr73A=
Date: Fri, 30 May 2025 19:23:30 +0000
Message-ID: <0c86ed2a45be47cf9ea591d8872019b3@dh-electronics.com>
References: <20250529051024.42340-1-michael@amarulasolutions.com>
 <96e475655f574beea41b4f46353deffd@dh-electronics.com>
 <CAOf5uwk6-rRimCUC+xBYqi3Tr1vo0_4viw5vPUg-FAgq34MzUw@mail.gmail.com>
 <06019262ef084bdf8471f18b08b78240@dh-electronics.com>
 <CAOf5uwmpau9YUQevx0+gKyLn4_Q0GhaWpXqBzBZ-eDm8zjweBw@mail.gmail.com>
In-Reply-To: <CAOf5uwmpau9YUQevx0+gKyLn4_Q0GhaWpXqBzBZ-eDm8zjweBw@mail.gmail.com>
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

SGVsbG8sDQoNCj4gRnJvbTogTWljaGFlbCBOYXp6YXJlbm8gVHJpbWFyY2hpIDxtaWNoYWVsQGFt
YXJ1bGFzb2x1dGlvbnMuY29tPg0KPiBTZW50OiBGcmlkYXksIE1heSAzMCwgMjAyNSA1OjEyIFBN
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMS80XSBjbGs6IGlteDogYWRkIGkuTVg2VUwgY2xr
IGRyaXZlcg0KPiANCj4gWy4uLl0NCj4gDQo+Pj4gSSBoYXZlIG9ubHkgYW4gaW14NnVsbCBmb3Ig
dGVzdGluZy4gQXQgdGhlIG1vbWVudCBpdCBsb29rcyBnb29kLCBhbHRob3VnaA0KPj4+IHRoZSBF
dGhlcm5ldCBvbiBteSBkZXZpY2UgaXMgbm90IHlldCB3b3JraW5nIHdpdGggdGhpcyBjbG9jayBk
cml2ZXIuIEkgbmVlZA0KPj4+IHRvIGZpbmQgb3V0IHdoeSBpdCdzIG5vdCB3b3JraW5nIGFuZCB3
aWxsIHByb2JhYmx5IGRvIGEgZm9sbG93IHVwIHBhdGNoLg0KPj4+DQo+Pj4gV2l0aCB0aGF0IGNo
YW5nZXMgYWJvdmUNCj4+PiBSZXZpZXdlZC1ieTogQ2hyaXN0b3BoIE5pZWRlcm1haWVyIDxjbmll
ZGVybWFpZXJAZGgtZWxlY3Ryb25pY3MuY29tPg0KPj4+DQo+PiANCj4+IEkgd2lsbCBhZGQgeW91
IHJldmlldyBhbmQgdGVzdGVkLWJ5OiBkdXJpbmcgcmVzcGluLiBGb3IgdGhlIGV0aGVybmV0IEkN
Cj4+IGNhbiB0YWtlIGEgbG9vaw0KPj4gYnV0IEkgaGF2ZSBub3QgaW4gbXkgbW9kdWxlDQo+IA0K
PiBOb3QgbmVjZXNzYXJ5LCB3aXRoIHRoZSBpbXg2dWx6IHRoaXMgbWFrZXMgbm8gc2Vuc2UuIEkn
bGwgaGF2ZSBhIGxvb2sNCj4gYXQgaXQuIEkgd2lsbCB1c2UgeW91ciBwYXRjaCB2NCBhcyB0aGUg
YmFzZSBmb3IgbXkgYWRqdXN0bWVudHMuDQo+IA0KPiBJIGhhdmUgYW5vdGhlciB1cHN0cmVhbSBv
biBnb2luZyBzbyBJIHNob3VsZCBhYmxlIHRvIHRlc3QuIEFueXdheSBJIGhvcGUgdGhhdCB0aGlz
IGlzIHRoZSBsYXN0IHJlc3Bpbi4NCg0KSSBjYW4ndCBzYXkgd2hlbiBFdGhlcm5ldCB3aWxsIHdv
cmsgb24gbXkgZGV2aWNlLiBCdXQgZnJvbSBteSBwb2ludA0Kb2YgdmlldywgdGhlIGN1cnJlbnQg
c3RhdHVzIG9mIHlvdXIgcGF0Y2ggY2FuIGFscmVhZHkgYmUgYXBwbGllZC4NCiANCj4gRG8geW91
IHRlc3QgdGhlIG5hbmQ/DQoNCk5vLCB1bmZvcnR1bmF0ZWx5IEkgaGF2ZSBlTU1DIG9uIG15IGlt
eDZ1bGwuDQoNCg0KUmVnYXJkcw0KQ2hyaXN0b3BoDQo=
