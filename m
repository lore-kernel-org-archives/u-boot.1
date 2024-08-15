Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDA6C52D7D
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 08:59:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04AB487E64;
	Thu, 15 Aug 2024 10:59:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="k/uwpOUg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3887988A43; Thu, 15 Aug 2024 10:58:58 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48C5F87E64
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 10:58:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1723712335; x=1726304335;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+smVOp3Et51ukPwoqscJjcOKTL/aiOf2Y3Y5Uo9g6vA=;
 b=k/uwpOUg6actNvD1iIGtkCWplR3rbsD0EcgXfBHuIEJ8hkNlBUAAHbt3YoBRAKqg
 rCmzYiq1INkuuIuEaeHtseiH7/RaD0igJwFSvSLM9EaGzT7tQVYInP7zqZX6XGnZ
 N77d4LSB/dnSxCHUXUuGhYjrO0ONxEz3u11fv8CEyjM=;
X-AuditID: ac14000a-03e52700000021bc-2e-66bdc34f81d1
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 68.5A.08636.F43CDB66;
 Thu, 15 Aug 2024 10:58:55 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 15 Aug
 2024 10:58:55 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Thu, 15 Aug 2024 10:58:55 +0200
From: Benjamin Hahn <B.Hahn@phytec.de>
To: Lukasz Majewski <lukma@denx.de>, Teresa Remmet <T.Remmet@phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Cem Tenruh <C.Tenruh@phytec.de>, "Martyn
 Welch" <martyn.welch@collabora.com>, Simon Glass <sjg@chromium.org>, "Fabio
 Estevam" <festevam@gmail.com>
Subject: Re: [PATCH v4] config: Add 'update_bootimg' command to update
 flash.bin on Phytec's imx8mm
Thread-Topic: [PATCH v4] config: Add 'update_bootimg' command to update
 flash.bin on Phytec's imx8mm
Thread-Index: AQHa6ny7FF3XwmmxwkagUaYyYJL6PLIn7DaA
Date: Thu, 15 Aug 2024 08:58:55 +0000
Message-ID: <122509b9-378c-4f7a-8448-f796e26f6c70@phytec.de>
References: <20240809165332.1898756-1-lukma@denx.de>
In-Reply-To: <20240809165332.1898756-1-lukma@denx.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AFA75EFAADEB541B2C54CD0A612E65D@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsWyRpKBR9f/8N40gw3ftSweXvW3eP7uMpPF
 g4tdLBbftmxjtJg6aTO7xdu9newObB6zGy6yeOy4u4TRY96sEyweO2fdZfd4dWAVu8fZOzsY
 A9iiuGxSUnMyy1KL9O0SuDK+rC0q6BKomPHhB1MD4xX+LkZODgkBE4nPl6awdzFycQgJLGGS
 WPu2kwXCuc8oseNcF1RmA6PEkfWT2EFa2ATUJHa9ec0KYosIVEgc2nWFCaSIWWAno8Tbrb2M
 IAlhgVSJlR1zGSGK0iQOrr3BBmEbSSz4exGsmUVAVeLVri1gcV4BG4kH/1uZQGwhoJvOdP0G
 6+UUMJVonHgOzGYUkJXYsOE8M4jNLCAusenZd1aIHwQkluyBiEsIiEq8fPwPKi4vceLWNKCZ
 HED1mhLrd+lDmBYS3YeCIKYoSkzpfsgOcYGgxMmZT1gmMIrPQrJgFkLzLITmWUiaZyFpXsDI
 uopRKDczOTu1KDNbryCjsiQ1WS8ldRMjKGZFGLh2MPbN8TjEyMTBeIhRgoNZSYQ30GRXmhBv
 SmJlVWpRfnxRaU5q8SFGaQ4WJXHe1R3BqUIC6YklqdmpqQWpRTBZJg5OqQZG7afhVwriAiLs
 ducfKPxrU+Na4rHe6HlG8brXb7ZN1+G6wniU93daUs3OH1PZX6z7vThRTmzV54zX3VMct237
 YO7ab7Bu1vSiopDTbpradsnsVnUvb5/mjDx3v9VnX2xjoKuhZq+JmapJ0rtiJx7ZPwfWiGk8
 v3fEufH0S8Y+ed6y3NongYJKLMUZiYZazEXFiQCv6h65xwIAAA==
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

T24gMDkuMDguMjQgMTg6NTMsIEx1a2FzeiBNYWpld3NraSB3cm90ZToNCj4gVGhpcyBjb21tYW5k
IGFsbG93cyBlYXN5IHVwZGF0ZSBvbiBTRCBjYXJkIG9yIGVNTUMgb2YgdGhlIGZsYXNoLmJpbg0K
PiBnZW5lcmF0ZWQgKHdpdGggYmlubWFuKSBkdXJpbmcgdS1ib290IGJ1aWxkLg0KPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBMdWthc3ogTWFqZXdza2kgPGx1a21hQGRlbnguZGU+DQpSZXZpZXdlZC1ieTog
QmVuamFtaW4gSGFobiA8Qi5IYWhuQHBoeXRlYy5kZT4NCj4gLS0tDQo+IENoYW5nZXMgZm9yIHYy
Og0KPiAtIFJlbW92ZSAndXBkYXRlX21tY19wYXJ0JyB2YXJpYWJsZQ0KPiAtIENoYW5nZSBwYXRo
IGZvciBob3N0bmFtZQ0KPiAtIFVzZSBmdWxsIHZlcnNpb24gb2YgZGhjcCBjb21tYW5kICgke2xv
YWRhZGRyfSBhZGRlZCkNCj4NCj4gQ2hhbmdlcyBmb3IgdjM6DQo+IC0gUmVtb3ZlICsxIHdoZW4g
Y2FsY3VsYXRpbmcgdGhlIHNpemUgb2YgYmluYXJ5IHRvIGJlIHdyaXR0ZW4NCj4NCj4gQ2hhbmdl
cyBmb3IgdjQ6DQo+IC0gUmVwbGFjZSAke2hvc3RuYW1lfSB3aXRoICR7dXBkYXRlX2ZpbGVwYXRo
fQ0KPiAtLS0NCj4gICBpbmNsdWRlL2NvbmZpZ3MvcGh5Y29yZV9pbXg4bW0uaCB8IDggKysrKysr
KysNCj4gICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2NvbmZpZ3MvcGh5Y29yZV9pbXg4bW0uaCBiL2luY2x1ZGUvY29uZmlncy9waHlj
b3JlX2lteDhtbS5oDQo+IGluZGV4IGRkN2NmZGJhNTIuLjA5MTBhZTJkODcgMTAwNjQ0DQo+IC0t
LSBhL2luY2x1ZGUvY29uZmlncy9waHljb3JlX2lteDhtbS5oDQo+ICsrKyBiL2luY2x1ZGUvY29u
Zmlncy9waHljb3JlX2lteDhtbS5oDQo+IEBAIC0yOSw2ICsyOSwxNCBAQA0KPiAgIAkibW1jZGV2
PSIgX19zdHJpbmdpZnkoQ09ORklHX1NZU19NTUNfRU5WX0RFVikgIlwwIiBcDQo+ICAgCSJtbWNw
YXJ0PTFcMCIgXA0KPiAgIAkibW1jcm9vdD0yXDAiIFwNCj4gKwkidXBkYXRlX29mZnNldD0weDQy
XDAiIFwNCj4gKwkidXBkYXRlX2ZpbGVuYW1lPWZsYXNoLmJpblwwIiBcDQo+ICsJInVwZGF0ZV9i
b290aW1nPSIJCQkJCQlcDQo+ICsJCSJtbWMgZGV2ICR7bW1jZGV2fSA7ICIJCVwNCj4gKwkJImlm
IGRoY3AgJHtsb2FkYWRkcn0gJHt1cGRhdGVfZmlsZXBhdGh9LyR7dXBkYXRlX2ZpbGVuYW1lfSA7
IHRoZW4gIglcDQo+ICsJCSJzZXRleHByIGZ3X3N6ICR7ZmlsZXNpemV9IC8gMHgyMDAgOyAiCS8q
IFNEIGJsb2NrIHNpemUgKi8gXA0KPiArCQkibW1jIHdyaXRlICR7bG9hZGFkZHJ9ICR7dXBkYXRl
X29mZnNldH0gJHtmd19zen0gOyAiCVwNCj4gKwkJImZpXDAiIFwNCj4gICAJIm1tY2F1dG9kZXRl
Y3Q9eWVzXDAiIFwNCj4gICAJIm1tY2FyZ3M9c2V0ZW52IGJvb3RhcmdzIGNvbnNvbGU9JHtjb25z
b2xlfSAiIFwNCj4gICAJCSJyb290PS9kZXYvbW1jYmxrJHttbWNkZXZ9cCR7bW1jcm9vdH0gcm9v
dHdhaXQgcndcMCIgXA0KDQoNCg==
