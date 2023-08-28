Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A2EC71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 12:33:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 188818645F;
	Mon, 28 Aug 2023 14:33:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="pFWR8HhK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 321E580295; Mon, 28 Aug 2023 14:33:49 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 878248645F
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 14:33:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1693226025; x=1695818025;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Qliblg0wvdNGkWJV6nMiqhWK3qd5ruFn/bNcA+K1Kic=;
 b=pFWR8HhKQ16LO8mBjQFbD1i4AuVK+2ra0gQm28l7gGV2tGoNQPS/DjTdHBOCvo6E
 TNMIS2O0+d+l4h6utXZLcAUnEZMC3FogPCfbEDDF6BFiTtIG6gJTo/zldx/wnF+9
 JJFud+mDBZCz8mCAG1KUB2nHel3O368sXwmf86p3FvY=;
X-AuditID: ac14000a-923ff70000007ecb-3f-64ec9429d8a7
Received: from Diagnostix.phytec.de (Diagnostix.phytec.de [172.25.0.14])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id B6.54.32459.9249CE46;
 Mon, 28 Aug 2023 14:33:45 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Aug
 2023 14:33:44 +0200
Received: from Berlix.phytec.de ([fe80::61cc:ebf0:7375:8768]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2375.018;
 Mon, 28 Aug 2023 14:33:44 +0200
From: Yannic Moog <Y.Moog@phytec.de>
To: "festevam@gmail.com" <festevam@gmail.com>, "uboot-imx@nxp.com"
 <uboot-imx@nxp.com>, "sbabic@denx.de" <sbabic@denx.de>, Teresa Remmet
 <T.Remmet@phytec.de>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Daniel Schultz
 <D.Schultz@phytec.de>, Wadim Egorov <W.Egorov@phytec.de>
Subject: Re: [PATCH v2 6/6] board: phytec: phycore_imx8mp: Add 4000MTS RAM
 timings based on PCB rev
Thread-Topic: [PATCH v2 6/6] board: phytec: phycore_imx8mp: Add 4000MTS RAM
 timings based on PCB rev
Thread-Index: AQHZ0OjXlpH9DYhmBUSZPXro3yprq6//lGsA
Date: Mon, 28 Aug 2023 12:33:44 +0000
Message-ID: <41b9e008c60fc032edb0e8692015030382e13a18.camel@phytec.de>
References: <20230817085711.45339-1-t.remmet@phytec.de>
 <20230817085711.45339-7-t.remmet@phytec.de>
In-Reply-To: <20230817085711.45339-7-t.remmet@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <07638E73E90D494080D7671F6F6886D6@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWyRpKBT1dzypsUgzVb+CweXvW3aD/lY/F2
 bye7xZTH69ktut+pO7B6zJt1gsVj56y77B5n7+xg9OjvbmH12PhuB1MAaxSXTUpqTmZZapG+
 XQJXxsRDi9gLllhV9PUcZm9gfGLRxcjJISFgItHauZKti5GLQ0hgHZPE3w9bmSGcJ4wSezt/
 sEA4GxklJl/tZAdpYRNQkTg54xIjSEJEYCGjxMkdj9lBHGaBrYwSS5pmMYJUCQukSjya0s8C
 YosIpEk0N9xg7WLkALKNJFb8lwcJswioSuw+8BhsKK+Am8TVxTtYQWwhoPIHj+6zgdicAhYS
 s6/NBxvDKCArsWHDeWYQm1lAXGLTs++sED8ISCzZAxGXEBCVePn4H1RcXuLErWlMIGuZBTQl
 1u/ShzAtJDqvQ01RlJjS/RDqAkGJkzOfsExgFJ+FZMEshOZZCM2zkDTPQtK8gJF1FaNQbmZy
 dmpRZrZeQUZlSWqyXkrqJkZQdIowcO1g7JvjcYiRiYPxEKMEB7OSCO8lx1cpQrwpiZVVqUX5
 8UWlOanFhxilOViUxHnv9zAlCgmkJ5akZqemFqQWwWSZODilGhiT9yerPrfvMnnfNKsuomLl
 8TZ7y+rMCuEFM85rWoT9OG29ViJt2qMHYom7tp8Uq+MtX2pQ+vWR6BH2oBqRM0cnC3mxmfNF
 WJ5zL1v3fHb6xhVzzWcKb5qduPfbNgmG2AsWUokVOxJWFCsVv9HVb/AsKJuz8F30Re17tUe6
 +892CEu3PU0LSFNiKc5INNRiLipOBADRldZrvAIAAA==
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

T24gVGh1LCAyMDIzLTA4LTE3IGF0IDEwOjU3ICswMjAwLCBUZXJlc2EgUmVtbWV0IHdyb3RlOgo+
IFN0YXJ0aW5nIHdpdGggUENCIHJldmlzaW9uIDMgd2UgY2FuIHNhZmVseSBtYWtlIHVzZSBvZiBo
aWdoZXIgUkFNCj4gZnJlcXVlbmN5IGFnYWluLiBNYWtlIHVzZSBvZiB0aGUgRUVQUk9NIGRldGVj
dGlvbiB0byBkZXRlcm1pbmUgdGhlCj4gcmV2aXNpb24gYW5kIHVzZSB0aGUgdXBkYXRlZCBSQU0g
dGltaW5ncyBmb3IgbmV3IFNvTXMuCj4gCj4gU2lnbmVkLW9mZi1ieTogVGVyZXNhIFJlbW1ldCA8
dC5yZW1tZXRAcGh5dGVjLmRlPgoKUmV2aWV3ZWQtYnk6IFlhbm5pYyBNb29nIDx5Lm1vb2dAcGh5
dGVjLmRlPgpUZXN0ZWQtYnk6IFlhbm5pYyBNb29nIDx5Lm1vb2dAcGh5dGVjLmRlPgoKPiAtLQo+
IENoYW5nZXMgaW4gdjI6Cj4gLSBGaXggd3JvbmcgUkFNIFRpbWluZyB2YWx1ZXMgYXMgcG9pbnRl
ZCBvdXQgYnkgWWFubmljCj4gLS0tCj4gwqBib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bXAvc3Bs
LmMgfCA2MQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiDCoDEgZmlsZSBjaGFu
Z2VkLCA2MSBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2JvYXJkL3BoeXRlYy9waHlj
b3JlX2lteDhtcC9zcGwuYwo+IGIvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1wL3NwbC5jCj4g
aW5kZXggNDk0MDZmMmVhZmFkLi5kMzhmNjM2OGZlMzYgMTAwNjQ0Cj4gLS0tIGEvYm9hcmQvcGh5
dGVjL3BoeWNvcmVfaW14OG1wL3NwbC5jCj4gKysrIGIvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14
OG1wL3NwbC5jCj4gQEAgLTQ2LDYgKzQ2LDY3IEBAIHZvaWQgc3BsX2RyYW1faW5pdCh2b2lkKQo+
IMKgwqDCoMKgwqDCoMKgwqBpZiAoIXJldCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHBoeXRlY19wcmludF9zb21faW5mbyhOVUxMKTsKPiDCoAo+ICvCoMKgwqDCoMKgwqDCoHJl
dCA9IHBoeXRlY19nZXRfcmV2KE5VTEwpOwo+ICvCoMKgwqDCoMKgwqDCoGlmIChyZXQgPj0gMyAm
JiByZXQgIT0gUEhZVEVDX0VFUFJPTV9JTlZBTCkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBkcmFtX3RpbWluZy5kZHJjX2NmZ1szXS52YWwgPSAweDEzMjM7Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRyYW1fdGltaW5nLmRkcmNfY2ZnWzRdLnZhbCA9IDB4MWU4
NDgwMDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZHJhbV90aW1pbmcuZGRyY19j
ZmdbNV0udmFsID0gMHg3YTAxMTg7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRy
YW1fdGltaW5nLmRkcmNfY2ZnWzhdLnZhbCA9IDB4YzAwMzA3YTM7Cj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGRyYW1fdGltaW5nLmRkcmNfY2ZnWzldLnZhbCA9IDB4YzUwMDAwOwo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkcmFtX3RpbWluZy5kZHJjX2NmZ1sxMF0u
dmFsID0gMHhmNDAwM2Y7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRyYW1fdGlt
aW5nLmRkcmNfY2ZnWzExXS52YWwgPSAweGYzMDAwMDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgZHJhbV90aW1pbmcuZGRyY19jZmdbMTRdLnZhbCA9IDB4MjAyODIyMmE7Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRyYW1fdGltaW5nLmRkcmNfY2ZnWzE1XS52YWwg
PSAweDgwODNmOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkcmFtX3RpbWluZy5k
ZHJjX2NmZ1sxNl0udmFsID0gMHhlMGUwMDA7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGRyYW1fdGltaW5nLmRkcmNfY2ZnWzE3XS52YWwgPSAweDEyMDQwYTEyOwo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkcmFtX3RpbWluZy5kZHJjX2NmZ1sxOF0udmFsID0gMHgy
MDUwZjBmOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkcmFtX3RpbWluZy5kZHJj
X2NmZ1sxOV0udmFsID0gMHgxMDEwMDA5Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBkcmFtX3RpbWluZy5kZHJjX2NmZ1syMF0udmFsID0gMHg1MDI7Cj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGRyYW1fdGltaW5nLmRkcmNfY2ZnWzIxXS52YWwgPSAweDIwODAwOwo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkcmFtX3RpbWluZy5kZHJjX2NmZ1syMl0u
dmFsID0gMHhlMTAwMDAyOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkcmFtX3Rp
bWluZy5kZHJjX2NmZ1syM10udmFsID0gMHgxMjA7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGRyYW1fdGltaW5nLmRkcmNfY2ZnWzI0XS52YWwgPSAweGM4MDA2NDsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZHJhbV90aW1pbmcuZGRyY19jZmdbMjVdLnZhbCA9IDB4
M2U4MDAxZTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZHJhbV90aW1pbmcuZGRy
Y19jZmdbMjZdLnZhbCA9IDB4MzIwN2ExMjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgZHJhbV90aW1pbmcuZGRyY19jZmdbMjhdLnZhbCA9IDB4NGEzODIwZTsKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgZHJhbV90aW1pbmcuZGRyY19jZmdbMzBdLnZhbCA9IDB4MjMw
ZTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZHJhbV90aW1pbmcuZGRyY19jZmdb
MzddLnZhbCA9IDB4Nzk5Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkcmFtX3Rp
bWluZy5kZHJjX2NmZ1szOF0udmFsID0gMHg5MTQxZDFjOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBkcmFtX3RpbWluZy5kZHJjX2NmZ1s3NF0udmFsID0gMHgzMDI7Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRyYW1fdGltaW5nLmRkcmNfY2ZnWzgzXS52YWwgPSAw
eDU5OTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZHJhbV90aW1pbmcuZGRyY19j
ZmdbOTldLnZhbCA9IDB4MzAyOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkcmFt
X3RpbWluZy5kZHJjX2NmZ1sxMDhdLnZhbCA9IDB4NTk5Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBkcmFtX3RpbWluZy5kZHJwaHlfY2ZnWzY2XS52YWwgPSAweDE4Owo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkcmFtX3RpbWluZy5kZHJwaHlfY2ZnWzc1XS52YWwg
PSAweDFlMzsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZHJhbV90aW1pbmcuZGRy
cGh5X2NmZ1s3N10udmFsID0gMHgxZTM7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGRyYW1fdGltaW5nLmRkcnBoeV9jZmdbNzldLnZhbCA9IDB4MWUzOwo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBkcmFtX3RpbWluZy5kZHJwaHlfY2ZnWzE0NV0udmFsID0gMHgzZTg7
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRyYW1fdGltaW5nLmZzcF9tc2dbMF0u
ZHJhdGUgPSA0MDAwOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkcmFtX3RpbWlu
Zy5mc3BfbXNnWzBdLmZzcF9jZmdbMV0udmFsID0gMHhmYTA7Cj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGRyYW1fdGltaW5nLmZzcF9tc2dbMF0uZnNwX2NmZ1sxMF0udmFsID0gMHgz
ZmY0Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkcmFtX3RpbWluZy5mc3BfbXNn
WzBdLmZzcF9jZmdbMTFdLnZhbCA9IDB4ZjM7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGRyYW1fdGltaW5nLmZzcF9tc2dbMF0uZnNwX2NmZ1sxNV0udmFsID0gMHgzZmY0Owo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkcmFtX3RpbWluZy5mc3BfbXNnWzBdLmZzcF9j
ZmdbMTZdLnZhbCA9IDB4ZjM7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRyYW1f
dGltaW5nLmZzcF9tc2dbMF0uZnNwX2NmZ1syMl0udmFsID0gMHhmNDAwOwo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBkcmFtX3RpbWluZy5mc3BfbXNnWzBdLmZzcF9jZmdbMjNdLnZh
bCA9IDB4ZjMzZjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZHJhbV90aW1pbmcu
ZnNwX21zZ1swXS5mc3BfY2ZnWzI4XS52YWwgPSAweGY0MDA7Cj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGRyYW1fdGltaW5nLmZzcF9tc2dbMF0uZnNwX2NmZ1syOV0udmFsID0gMHhm
MzNmOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkcmFtX3RpbWluZy5mc3BfbXNn
WzNdLmRyYXRlID0gNDAwMDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZHJhbV90
aW1pbmcuZnNwX21zZ1szXS5mc3BfY2ZnWzFdLnZhbCA9IDB4ZmEwOwo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBkcmFtX3RpbWluZy5mc3BfbXNnWzNdLmZzcF9jZmdbMTFdLnZhbCA9
IDB4M2ZmNDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZHJhbV90aW1pbmcuZnNw
X21zZ1szXS5mc3BfY2ZnWzEyXS52YWwgPSAweGYzOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBkcmFtX3RpbWluZy5mc3BfbXNnWzNdLmZzcF9jZmdbMTZdLnZhbCA9IDB4M2ZmNDsK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZHJhbV90aW1pbmcuZnNwX21zZ1szXS5m
c3BfY2ZnWzE3XS52YWwgPSAweGYzOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBk
cmFtX3RpbWluZy5mc3BfbXNnWzNdLmZzcF9jZmdbMjNdLnZhbCA9IDB4ZjQwMDsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZHJhbV90aW1pbmcuZnNwX21zZ1szXS5mc3BfY2ZnWzI0
XS52YWwgPSAweGYzM2Y7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRyYW1fdGlt
aW5nLmZzcF9tc2dbM10uZnNwX2NmZ1syOV0udmFsID0gMHhmNDAwOwo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBkcmFtX3RpbWluZy5mc3BfbXNnWzNdLmZzcF9jZmdbMzBdLnZhbCA9
IDB4ZjMzZjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZHJhbV90aW1pbmcuZGRy
cGh5X3BpZVs0ODBdLnZhbCA9IDB4NDY1Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBkcmFtX3RpbWluZy5kZHJwaHlfcGllWzQ4MV0udmFsID0gMHhmYTsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgZHJhbV90aW1pbmcuZGRycGh5X3BpZVs0ODJdLnZhbCA9IDB4OWM0
Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkcmFtX3RpbWluZy5mc3BfdGFibGVb
MF0gPSA0MDAwOwo+ICvCoMKgwqDCoMKgwqDCoH0KPiArCj4gwqBvdXQ6Cj4gwqDCoMKgwqDCoMKg
wqDCoGRkcl9pbml0KCZkcmFtX3RpbWluZyk7Cj4gwqB9Cgo=
