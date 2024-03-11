Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457CEC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 14:33:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DA9087D3C;
	Mon, 11 Mar 2024 15:33:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="mrzjdIvf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E21B87DD3; Mon, 11 Mar 2024 15:33:01 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EFD98272A
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 15:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1710167578; x=1712759578;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y0349SvCY647Wz++03remdaDfxEqW4hQ5XujGmjy8hs=;
 b=mrzjdIvfoNd0/5+IAyY67udkPurnZWjMTOeFMgevWbNAilxDISTfPXyGmtJq6Kq9
 HtJwdIqA5FA5AT+WxF4ytNcTFVWcJ8Kgd1RKxLDqwEeINCwAMWNyEPQtYD+1z7aj
 HZGJIUrFCARITNQmTCz7WyTFDnUEYj1ffL0jzbettgU=;
X-AuditID: ac14000a-fbefe7000000290d-59-65ef161a2515
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 9D.14.10509.A161FE56;
 Mon, 11 Mar 2024 15:32:58 +0100 (CET)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 11 Mar
 2024 15:32:58 +0100
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Mon, 11 Mar 2024 15:32:58 +0100
From: Leonard Anderweit <L.Anderweit@phytec.de>
To: "festevam@gmail.com" <festevam@gmail.com>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "trini@konsulko.com" <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Teresa Remmet <T.Remmet@phytec.de>
Subject: Re: [PATCH 3/5] configs: phycore-imx8mp_defconfig: Use redundant
 environment
Thread-Topic: [PATCH 3/5] configs: phycore-imx8mp_defconfig: Use redundant
 environment
Thread-Index: AQHac71F0lO07+KFWUuxIucjFAs93LEyicgA
Date: Mon, 11 Mar 2024 14:32:58 +0000
Message-ID: <f35b563652de6337603d513e294d8cdeb7c73744.camel@phytec.de>
References: <20240311130400.4023780-1-l.anderweit@phytec.de>
 <20240311130400.4023780-4-l.anderweit@phytec.de>
 <CAOMZO5Cm08dpaEdRSZkj8khP3T1HySP1fqKM12cOF4XSr7kJfQ@mail.gmail.com>
In-Reply-To: <CAOMZO5Cm08dpaEdRSZkj8khP3T1HySP1fqKM12cOF4XSr7kJfQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B883493F9CB9DB44BE4B4646F25B0375@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsWyRpKBR1dK7H2qQfMPXYuHV/0tpk7azG7x
 dm8nu0X3O3UHFo+ds+6ye7w6sIrd4+ydHYwe/d0trAEsUVw2Kak5mWWpRfp2CVwZ084tZS84
 x1Gx/PcUtgbGDRxdjBwcEgImEvs+OHcxcnEICSxmklh/dR8zhHOfUeLp3PVMEM4GRon2n3eA
 MpwcbAL6EitXPAWzRQR0JVac6GIEKWIW2M0oMWPncjaQhLBAuMTru30sEEUREpsPrYWyjSSu
 nmljAlnNIqAq8fxIAkiYV8BN4mx/FxvEsh2MEh0/7jGCJDgFAiUWvz0CNpNRQFZiw4bzYIuZ
 BcQlNj37zgpiSwgISCzZAxGXEBCVePn4H1RcXuLErWlgu5gFNCXW79KHMC0kHv6QhpiiKDGl
 +yE7xAmCEidnPmGZwCg+C8mCWQjNsxCaZyFpnoWkeQEj6ypGodzM5OzUosxsvYKMypLUZL2U
 1E2MoEgUYeDawdg3x+MQIxMH4yFGCQ5mJRHe1zpvU4V4UxIrq1KL8uOLSnNSiw8xSnOwKInz
 ru4IThUSSE8sSc1OTS1ILYLJMnFwSjUwLgiLm7T2ee7v7cfa8vXrN53YGssX33S8d17rC93H
 E760uDPVcYQzCez6e/Bb0t8vGmd3z7QOMWjfIa8qvs3zAMup8E3TQtPnKET6djO9ucnVceW+
 +f1nbH61HcWXJ5u8217P4MEr5N6e9shB+WxqE+s2/l09TbNOqnvHhJZPv3TUY/HJtowNSizF
 GYmGWsxFxYkAHHMAnLICAAA=
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

SGkgRmFiaW8sDQoNCkFtIE1vbnRhZywgZGVtIDExLjAzLjIwMjQgdW0gMTE6MDUgLTAzMDAgc2No
cmllYiBGYWJpbyBFc3RldmFtOg0KPiBIaSBMZW9uYXJkLA0KPiANCj4gT24gTW9uLCBNYXIgMTEs
IDIwMjQgYXQgMTA6MDTigK9BTSBMZW9uYXJkIEFuZGVyd2VpdA0KPiA8bC5hbmRlcndlaXRAcGh5
dGVjLmRlPiB3cm90ZToNCj4gPiANCj4gPiBBZGQgc3VwcG9ydCBmb3IgdGhlIHJlZHVuZGFudCBl
bnZpcm9ubWVudC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBMZW9uYXJkIEFuZGVyd2VpdCA8
bC5hbmRlcndlaXRAcGh5dGVjLmRlPg0KPiANCj4gUGxlYXNlIHJlYmFzZSB0aGlzIHNlcmllcyBh
Z2FpbnN0IFUtQm9vdCBuZXh0IGJyYW5jaCBhbmQgcmVzZW5kLg0KDQpUaGlzIHNlcmllcyBpcyBi
YXNlZCBvbiB0aGUgbGF0ZXN0IG1hc3RlciBicmFuY2guDQo+IA0KPiBUaGVyZSBpcyBhbiBlcnJv
ciB3aGlsZSBhcHBseWluZyB0aGlzIHBhdGNoIGFnYWluc3QgbmV4dC4NCg0KSSBhbHNvIGdvdCBh
biBlcnJvciB3aGlsZSBhcHBseWluZyB0aGlzIHRvIG5leHQuIFRvIGFwcGx5IGNsZWFubHkgdGhp
cw0Kc2VyaWVzIHJlcXVpcmVzIHRoZSBjb21taXQgMTlmNjU3NjAwNzgxIChjb25maWdzOiBSZXN5
bmMgd2l0aA0Kc2F2ZWRlZmNvbmZpZykgd2hpY2ggaXMgb24gbWFzdGVyIGJ1dCBub3Qgb24gbmV4
dC4NCg0KSWYgdGhpcyBtaXNzaW5nIGNvbW1pdCBpcyBpbnRlbmRlZCBJJ2xsIHJlc2VuZCB0aGlz
IHNlcmllcyBiYXNlZCBvbg0KbmV4dC4NCg0KUmVnYXJkcywNCkxlb25hcmQNCj4gDQo+IFRoYW5r
cw0KDQo=
