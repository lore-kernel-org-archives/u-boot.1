Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F202C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 14:15:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 829BD87FC7;
	Tue, 12 Mar 2024 15:15:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Td3R2kSP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3BB687FAC; Tue, 12 Mar 2024 15:15:36 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 408C187DE3
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 15:15:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=T.Remmet@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1710252933; x=1712844933;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ewASmwPROy0KlPyI8cXmMj1LCPYXet+TycbjX6qxwQM=;
 b=Td3R2kSPHo5bTvzO6JbpDu84JgqXUKTOkSFJg+3TmOQuTfIAaXPbmDoOEqfkN01N
 Cmv3vaCOGiZT8L0d7Sl77oYmha9WAyGqSOisOeadwWsvezXRR/RcNf+2XkxR6dK1
 ctxWJ9XTMPJ83uQUGdvVPHySf/6eiAKHuwgDdjde3cA=;
X-AuditID: ac14000a-fadff7000000290d-05-65f0638545be
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 97.F9.10509.58360F56;
 Tue, 12 Mar 2024 15:15:33 +0100 (CET)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 12 Mar
 2024 15:15:32 +0100
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Tue, 12 Mar 2024 15:15:32 +0100
From: Teresa Remmet <T.Remmet@phytec.de>
To: "festevam@gmail.com" <festevam@gmail.com>, Leonard Anderweit
 <L.Anderweit@phytec.de>, "trini@konsulko.com" <trini@konsulko.com>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 5/5] board: phytec: phycore_imx8mp: Add RAUC boot logic
 to environment
Thread-Topic: [PATCH v2 5/5] board: phytec: phycore_imx8mp: Add RAUC boot
 logic to environment
Thread-Index: AQHadFuuBE3sb5Li30CGM0C0oMsTVbE0FgEA
Date: Tue, 12 Mar 2024 14:15:32 +0000
Message-ID: <73200545e653adaa34f7cd7bd8d77bbced7c6651.camel@phytec.de>
References: <20240312085957.902398-1-l.anderweit@phytec.de>
 <20240312085957.902398-6-l.anderweit@phytec.de>
In-Reply-To: <20240312085957.902398-6-l.anderweit@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C7F8A30E2661E4C9C8CA08575C76774@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsWyRpKBR7c1+UOqwbUlbBYPr/pbTJ20md3i
 7d5Odovud+oOLB47Z91l93h1YBW7x9k7Oxg9+rtbWANYorhsUlJzMstSi/TtErgyDjxezlzw
 TaTiyJ8fjA2MG0S6GDk5JARMJJZcWcLexcjFISSwmEni+ImXTBDOfUaJP1sXsEE4GxglLvxf
 zw7SwiagIfHyRDdYlYhAK6PE3sdPWUASzAJZEv8vzgLq4OAQFoiX2LchBiQsIpAg8XP5ClYI
 20hi6aedYDaLgKrEuRUnGUFsXgE3iY7vXWBxIYE8iROvNzCB2JwCNhK/D8wDsxkFZCU2bDjP
 DLFKXGLTs++sEC8ISCzZAxGXEBCVePn4H1RcXuLErWlMIOcwC2hKrN+lD9FqIfHsxE02CFtR
 Ykr3Q3aIEwQlTs58wjKBUXwWkg2zELpnIemehaR7FpLuBYysqxiFcjOTs1OLMrP1CjIqS1KT
 9VJSNzGColGEgWsHY98cj0OMTByMhxglOJiVRHhf67xNFeJNSaysSi3Kjy8qzUktPsQozcGi
 JM67uiM4VUggPbEkNTs1tSC1CCbLxMEp1cDosvuFekxajwRvi/mTisIs7xs9j5/n7jFUrmYr
 qrt+tjvgXLlsOq/u/NeVLke2LS0SsUmPrt/gcjkvpOpt/FfW71sbuaenRrMm2u2e+4l16u21
 jA/czA+46PWcSVD+Z/lSW0Yv5ODFJ3ovBb4e6+9wyVD5Ydq2Yd3mB43KzJIqP/a6+u84UKrE
 UpyRaKjFXFScCABRA134tAIAAA==
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

QW0gRGllbnN0YWcsIGRlbSAxMi4wMy4yMDI0IHVtIDA5OjU5ICswMTAwIHNjaHJpZWIgTGVvbmFy
ZCBBbmRlcndlaXQ6Cj4gQWRkIFJBVUMgYm9vdCBsb2dpYyB0byB0aGUgZW52aXJvbm1lbnQuIFRo
aXMgaXMgdGhlIGZpcnN0IGJvYXJkIHRvCj4gdXRpbGl6ZSB0aGlzIGVudmlyb25tZW50Lgo+IAo+
IFNpZ25lZC1vZmYtYnk6IExlb25hcmQgQW5kZXJ3ZWl0IDxsLmFuZGVyd2VpdEBwaHl0ZWMuZGU+
CgpUZXN0ZWQtYnk6IFRlcmVzYSBSZW1tZXQgPHQucmVtbWV0QHBoeXRlYy5kZT4KCj4gLS0tCj4g
wqBib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bXAvcGh5Y29yZV9pbXg4bXAuZW52IHwgNyArKysr
KystCj4gwqAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4g
Cj4gZGlmZiAtLWdpdCBhL2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDhtcC9waHljb3JlX2lteDht
cC5lbnYKPiBiL2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDhtcC9waHljb3JlX2lteDhtcC5lbnYK
PiBpbmRleCA3MzIwMmMzYjEyOWEuLmQ1OGQyNTQ3NmY2YiAxMDA2NDQKPiAtLS0gYS9ib2FyZC9w
aHl0ZWMvcGh5Y29yZV9pbXg4bXAvcGh5Y29yZV9pbXg4bXAuZW52Cj4gKysrIGIvYm9hcmQvcGh5
dGVjL3BoeWNvcmVfaW14OG1wL3BoeWNvcmVfaW14OG1wLmVudgo+IEBAIC0xLDkgKzEsMTQgQEAK
PiArI2luY2x1ZGUgPGVudi9waHl0ZWMvcmF1Yy5lbnY+Cj4gKwo+IMKgYm9vdGNtZD0KPiDCoMKg
wqDCoMKgwqDCoMKgaWYgdGVzdCAke2RvZmFzdGJvb3R9ID0gMTsgdGhlbgo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgZmFzdGJvb3QgMDsKPiDCoMKgwqDCoMKgwqDCoMKgZmk7Cj4g
wqDCoMKgwqDCoMKgwqDCoG1tYyBkZXYgJHttbWNkZXZ9Owo+IMKgwqDCoMKgwqDCoMKgwqBpZiBt
bWMgcmVzY2FuOyB0aGVuCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIHRlc3Qg
JHtkb3JhdWNib290fSA9IDE7IHRoZW4KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJ1biByYXVjaW5pdDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgZmk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiBydW4gbG9hZGlt
YWdlOyB0aGVuCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcnVuIG1tY2Jvb3Q7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlbHNlCj4g
QEAgLTIzLDcgKzI4LDcgQEAgbG9hZGltYWdlPWZhdGxvYWQgbW1jICR7bW1jZGV2fToke21tY3Bh
cnR9Cj4gJHtsb2FkYWRkcn0gJHtpbWFnZX0KPiDCoGxvYWRmZHQ9ZmF0bG9hZCBtbWMgJHttbWNk
ZXZ9OiR7bW1jcGFydH0gJHtmZHRfYWRkcn0gJHtmZHRfZmlsZX0KPiDCoG1tY2FyZ3M9Cj4gwqDC
oMKgwqDCoMKgwqDCoHNldGVudiBib290YXJncyBjb25zb2xlPSR7Y29uc29sZX0KPiAtwqDCoMKg
wqDCoMKgwqByb290PS9kZXYvbW1jYmxrJHttbWNkZXZ9cCR7bW1jcm9vdH0gcm9vdHdhaXQgcncK
PiArwqDCoMKgwqDCoMKgwqByb290PS9kZXYvbW1jYmxrJHttbWNkZXZ9cCR7bW1jcm9vdH0gJHty
YXVjYXJnc30gcm9vdHdhaXQgcncKPiDCoG1tY2F1dG9kZXRlY3Q9eWVzCj4gwqBtbWNib290PQo+
IMKgwqDCoMKgwqDCoMKgwqBlY2hvIEJvb3RpbmcgZnJvbSBtbWMgLi4uOwoKLS0gClBIWVRFQyBN
ZXNzdGVjaG5payBHbWJIIHwgQmFyY2Vsb25hLUFsbGVlIDEgfCA1NTEyOSBNYWlueiwgR2VybWFu
eQoKR2VzY2jDpGZ0c2bDvGhyZXI6IERpcGwuLUluZy4gTWljaGFlbCBNaXRlemtpLCBEaXBsLi1J
bmcuIEJvZG8gSHViZXIsCkRpcGwuLUluZy4gKEZIKSBNYXJrdXMgTGlja2VzIHwgSGFuZGVsc3Jl
Z2lzdGVyIE1haW56IEhSQiA0NjU2IHwKRmluYW56YW10IE1haW56IHwgU3QuTnIuIDI2NjUwMDYw
OCwgREUgMTQ5MDU5ODU1Cg==
