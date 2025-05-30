Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51647C5AD49
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 18:14:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C6BF82B72;
	Fri, 30 May 2025 20:14:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="bd0Yw/nA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A27E833CA; Fri, 30 May 2025 20:14:17 +0200 (CEST)
Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04F8F82B0E
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 20:14:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1748628840;
 bh=WYNM6Uh+BqpDND5eQKgzYOuIkWRRw0I5PndmVtiNFTM=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=bd0Yw/nAQCeVWRZ6SNdrvtbkACTBDm79zUGaFmsH8PxZY+/f3GJNSHkUgvkpLWE3u
 15DKdKj1Xu59GiUviQfOoMms8NqMifEsR/v7+zDY6uotp1M3jCu9K/AIYEH8echfev
 8NKZkBteJpu5zGawcj5ed+mbRsfeF/L95oGk84mTXwUmEn0oIqE+bySjfKKgOPmVMF
 Scwuu06hCklLFlmmoQH11TcvIF+FAcPxt0Y0DYIlmPbltpOGcGQ/HebDqmhr5dkkKH
 Kvu5dRLkUA1mr49a/qHBvganyTpDX+B2cnEW+/Aem7L4dz95QXqobpSleVCx3yWvKh
 Kss2DCioFzSbg==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "linux-amarula@amarulasolutions.com" <linux-amarula@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Adam Ford <aford173@gmail.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>, Tom Rini
 <trini@konsulko.com>
Subject: RE: [PATCH v3 1/4] clk: imx: add i.MX6UL clk driver
Thread-Topic: [PATCH v3 1/4] clk: imx: add i.MX6UL clk driver
Thread-Index: AQHb0FgEZAQHOs0ZHEi7FlTaxZPL4bPrKVXw///+9YCAAFAfIA==
Date: Fri, 30 May 2025 18:13:57 +0000
Message-ID: <06019262ef084bdf8471f18b08b78240@dh-electronics.com>
References: <20250529051024.42340-1-michael@amarulasolutions.com>
 <96e475655f574beea41b4f46353deffd@dh-electronics.com>
 <CAOf5uwk6-rRimCUC+xBYqi3Tr1vo0_4viw5vPUg-FAgq34MzUw@mail.gmail.com>
In-Reply-To: <CAOf5uwk6-rRimCUC+xBYqi3Tr1vo0_4viw5vPUg-FAgq34MzUw@mail.gmail.com>
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

SGVsbG8sDQoNCkZyb206IE1pY2hhZWwgTmF6emFyZW5vIFRyaW1hcmNoaSA8bWljaGFlbEBhbWFy
dWxhc29sdXRpb25zLmNvbT4NClNlbnQ6IEZyaWRheSwgTWF5IDMwLCAyMDI1IDU6MTIgUE0NClN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMS80XSBjbGs6IGlteDogYWRkIGkuTVg2VUwgY2xrIGRyaXZl
cg0KDQpbLi4uXQ0KDQo+PiBJIGhhdmUgb25seSBhbiBpbXg2dWxsIGZvciB0ZXN0aW5nLiBBdCB0
aGUgbW9tZW50IGl0IGxvb2tzIGdvb2QsIGFsdGhvdWdoDQo+PiB0aGUgRXRoZXJuZXQgb24gbXkg
ZGV2aWNlIGlzIG5vdCB5ZXQgd29ya2luZyB3aXRoIHRoaXMgY2xvY2sgZHJpdmVyLiBJIG5lZWQN
Cj4+IHRvIGZpbmQgb3V0IHdoeSBpdCdzIG5vdCB3b3JraW5nIGFuZCB3aWxsIHByb2JhYmx5IGRv
IGEgZm9sbG93IHVwIHBhdGNoLg0KPj4NCj4+IFdpdGggdGhhdCBjaGFuZ2VzIGFib3ZlDQo+PiBS
ZXZpZXdlZC1ieTogQ2hyaXN0b3BoIE5pZWRlcm1haWVyIDxjbmllZGVybWFpZXJAZGgtZWxlY3Ry
b25pY3MuY29tPg0KPj4NCj4gDQo+IEkgd2lsbCBhZGQgeW91IHJldmlldyBhbmQgdGVzdGVkLWJ5
OiBkdXJpbmcgcmVzcGluLiBGb3IgdGhlIGV0aGVybmV0IEkNCj4gY2FuIHRha2UgYSBsb29rDQo+
IGJ1dCBJIGhhdmUgbm90IGluIG15IG1vZHVsZQ0KDQpOb3QgbmVjZXNzYXJ5LCB3aXRoIHRoZSBp
bXg2dWx6IHRoaXMgbWFrZXMgbm8gc2Vuc2UuIEknbGwgaGF2ZSBhIGxvb2sNCmF0IGl0LiBJIHdp
bGwgdXNlIHlvdXIgcGF0Y2ggdjQgYXMgdGhlIGJhc2UgZm9yIG15IGFkanVzdG1lbnRzLg0KDQpS
ZWdhcmRzDQpDaHJpc3RvcGgNCg==
