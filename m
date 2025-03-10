Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACD1C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 09:16:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0A8B812C8;
	Mon, 10 Mar 2025 10:16:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=icenowy.me header.i=uwu@icenowy.me header.b="bMekBTLC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA666812D9; Mon, 10 Mar 2025 10:16:35 +0100 (CET)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6DEB8129F
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 10:16:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=uwu@icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1741598187; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JnXIElBrhxld/OxIgMq5ru+g03VC6LPVlWou+AaAYMJf8/rSIQzcJUDNUGkEkWODW4K1Iv/hKETx9OlviRMyHiNmLSKtd/L4lgIhms/y9BPotoZ/YX74v6vja0jnwCG7fHKAvvbCogmdIsC+MwgGP/pjlhqZ9P6z8Y7eo2y06HU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1741598187;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=LIsNC0d0+vMPzVLhQsuXvCpcApfcbeBCFsHnT4lffgI=; 
 b=QRSaa79EVuEH5OX58kpMSaTuFEiaP8tQDyRInCG7xDoHj3WJA+lpqbR/RwsOQYFyUiIEGVsQQvRuJBNG0kwiHI3NrEWpyud7dYFoaDWXO6Md0p6tuBa92vCpi7CstGaXUYrdQgI38bsvURGTQquscZWZWI63CBlbqY8bPNZhzJg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741598187; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=LIsNC0d0+vMPzVLhQsuXvCpcApfcbeBCFsHnT4lffgI=;
 b=bMekBTLCC/pQTrrbhIyDC5qGaXkViK4Y9TRz2R+KOFtz0RVkJn4VZOUEzvADiwcG
 SdwKHCM+6FhFspPWK3fgmNuYPtq7Gp85LsFAm5hbKthu7syOnCo12zU1zaMeznF4B9q
 YdoT4xwPzTfCPHSCPJm25l946mChsUwJEg1vIXkTYasTV3CpymPcjo9KX8Kre/Slfbi
 LpYuyTKJfw6FJvS2RLOInG7eB/KEidZ15DrFtT1WOXS+lguYmd03WlI2FgNNgvFRITd
 7ufjhiz2vXHqj89P/ien3wT6eyn4rHk6BdFF/tZn4D3R259eCFNEk41ukWvZ8Ck0X4/
 JKxoEampEA==
Received: by mx.zohomail.com with SMTPS id 1741598184307212.35897077943946;
 Mon, 10 Mar 2025 02:16:24 -0700 (PDT)
Message-ID: <271b604cc5d4e8f145651f7c327ddeb50e2945d8.camel@icenowy.me>
Subject: Re: [PATCH 1/2] sunxi: h616: dram: Rework size detection
From: Icenowy Zheng <uwu@icenowy.me>
To: Jernej Skrabec <jernej.skrabec@gmail.com>, jagan@amarulasolutions.com, 
 andre.przywara@arm.com, trini@konsulko.com
Cc: macromorgan@hotmail.com, u-boot@lists.denx.de, linux-sunxi@lists.linux.dev
Date: Mon, 10 Mar 2025 17:16:16 +0800
In-Reply-To: <20250309063143.62859-2-jernej.skrabec@gmail.com>
References: <20250309063143.62859-1-jernej.skrabec@gmail.com>
 <20250309063143.62859-2-jernej.skrabec@gmail.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
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

5ZyoIDIwMjUtMDMtMDnmmJ/mnJ/ml6XnmoQgMDc6MzEgKzAxMDDvvIxKZXJuZWogU2tyYWJlY+WG
memBk++8mgo+IFNpbmNlIHRoZXJlIGlzIHF1aXRlIGEgZmV3IHBvc3NpYmxlIERSQU0gY29uZmln
dXJhdGlvbnMgaW4gdGVybXMgb2YKPiBidXMKPiB3aWR0aCwgcmFuayBhbmQgcm93cyBhbmQgY29s
dW1ucyBjb3VudCwgc2l6ZSBkZXRlY3Rpb24gYWxnb3JpdGhtIG11c3QKPiBiZQo+IHZlcnkgY2Fy
ZWZ1bCBub3QgdG8gdGVzdCBjb21iaW5hdGlvbiB3aGljaCB3b3VsZCBiZSBiaWdnZXIgdGhhbiBI
NjE2Cj4gaXMKPiBhY3R1YWxseSBjYXBhYmxlIG9mIGhhbmRsaW5nLgo+IAo+IElkZWFsbHksIHdl
IHNob3VsZCBhbHdheXMgZGV0ZWN0IG1lbW9yeSBhbGlhc2luZywgZXZlbiBmb3IgNCBHQgo+IG1l
bW9yeQo+IHNpemUsIHdoaWNoIGlzIHRoZSBtYXhpbXVtIGFtb3VudCBvZiBtZW1vcnkgdGhhdCBI
NjE2IGlzIGNhcGFibGUgb2YKPiBoYW5kbGluZy4gRm9yIHRoaXMgcmVhc29uLCB3ZSBoYXZlIHRv
IGNvbmZpZ3VyZSBtaW5pbXVtIGFtb3VudCBvZgo+IHN1cHBvcnRlZCByb3dzIHdoZW4gdGVzdGlu
ZyBmb3IgY29sdW1ucyBhbmQgdmljZSB2ZXJzYS4gVGhpcyB3YXkgdGVzdAo+IGNvZGUgd2lsbCBu
ZXZlciBzdGVwIG91dCBvZiA0IEdCIGJvdW5kYXJ5LgoKVGhpcyBpcyBhbHNvIHRoZSBiZWhhdmlv
ciBvZiBwcmV2aW91cyBEUkFNIGRyaXZlcnMuCgo+IAo+IFdoaWxlIGF0IGl0LCBjaGVjayBmb3Ig
MTcgcm93cyBtYXhpbXVtLiBUaGlzIGFsaWducyBjb2RlIHdpdGggQlNQCj4gRFJBTQo+IGRyaXZl
ci4gVGhlcmUgaXMgcHJvYmFibHkgbm8gc3VjaCBjb25maWd1cmF0aW9uIHdoaWNoIHdvdWxkIG1h
a2UKPiBzZW5zZQo+IHdpdGggNCBHQiBtZW1vcnkuCgpJIGNoZWNrZWQgdGhlIEpFREVDIEpFU0Q3
OS00RCBkb2N1bWVudCwgYW5kIGZvdW5kIHRoYXQgMTggcm93cyBhcmUgb25seQphdmFpbGFibGUg
Zm9yIHg0IGRpZXMsIHdoaWNoIGFyZSBub3QgY29tcGF0aWJsZSB3aXRoIHRoZXNlIEFsbHdpbm5l
cgpTb0NzIGF0IGFsbCAobm90IGVub3VnaCBEUVMgcGlucykuCgpSZXZpZXdlZC1ieTogSWNlbm93
eSBaaGVuZyA8dXd1QGljZW5vd3kubWU+Cgo+IAo+IFNpZ25lZC1vZmYtYnk6IEplcm5laiBTa3Jh
YmVjIDxqZXJuZWouc2tyYWJlY0BnbWFpbC5jb20+Cj4gLS0tCj4gwqBhcmNoL2FybS9tYWNoLXN1
bnhpL2RyYW1fc3VuNTBpX2g2MTYuYyB8IDIwICsrKysrKysrKysrKy0tLS0tLS0tCj4gwqAxIGZp
bGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm0vbWFjaC1zdW54aS9kcmFtX3N1bjUwaV9oNjE2LmMgYi9hcmNoL2FybS9t
YWNoLQo+IHN1bnhpL2RyYW1fc3VuNTBpX2g2MTYuYwo+IGluZGV4IGIzNTU0Y2M2NGJmNS4uNmY4
NGU1OWUzOWNkIDEwMDY0NAo+IC0tLSBhL2FyY2gvYXJtL21hY2gtc3VueGkvZHJhbV9zdW41MGlf
aDYxNi5jCj4gKysrIGIvYXJjaC9hcm0vbWFjaC1zdW54aS9kcmFtX3N1bjUwaV9oNjE2LmMKPiBA
QCAtMTM2Myw3ICsxMzYzLDcgQEAgc3RhdGljIHZvaWQgbWN0bF9hdXRvX2RldGVjdF9yYW5rX3dp
ZHRoKGNvbnN0Cj4gc3RydWN0IGRyYW1fcGFyYSAqcGFyYSwKPiDCoHN0YXRpYyB2b2lkIG1jdGxf
YXV0b19kZXRlY3RfZHJhbV9zaXplKGNvbnN0IHN0cnVjdCBkcmFtX3BhcmEgKnBhcmEsCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZHJhbV9jb25maWcgKmNvbmZpZykKPiDCoHsKPiAtwqDC
oMKgwqDCoMKgwqB1bnNpZ25lZCBpbnQgc2hpZnQ7Cj4gK8KgwqDCoMKgwqDCoMKgdW5zaWduZWQg
aW50IHNoaWZ0LCBjb2xzLCByb3dzOwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoC8qIG1heC4gY29u
ZmlnIGZvciBjb2x1bW5zLCBidXQgbm90IHJvd3MgKi8KPiDCoMKgwqDCoMKgwqDCoMKgY29uZmln
LT5jb2xzID0gMTE7Cj4gQEAgLTEzNzMsMjMgKzEzNzMsMjcgQEAgc3RhdGljIHZvaWQgbWN0bF9h
dXRvX2RldGVjdF9kcmFtX3NpemUoY29uc3QKPiBzdHJ1Y3QgZHJhbV9wYXJhICpwYXJhLAo+IMKg
wqDCoMKgwqDCoMKgwqBzaGlmdCA9IGNvbmZpZy0+YnVzX2Z1bGxfd2lkdGggKyAxOwo+IMKgCj4g
wqDCoMKgwqDCoMKgwqDCoC8qIGRldGVjdCBjb2x1bW4gYWRkcmVzcyBiaXRzICovCj4gLcKgwqDC
oMKgwqDCoMKgZm9yIChjb25maWctPmNvbHMgPSA4OyBjb25maWctPmNvbHMgPCAxMTsgY29uZmln
LT5jb2xzKyspIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKG1jdGxfbWVt
X21hdGNoZXMoMVVMTCA8PCAoY29uZmlnLT5jb2xzICsgc2hpZnQpKSkKPiArwqDCoMKgwqDCoMKg
wqBmb3IgKGNvbHMgPSA4OyBjb2xzIDwgMTE7IGNvbHMrKykgewo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBpZiAobWN0bF9tZW1fbWF0Y2hlcygxVUxMIDw8IChjb2xzICsgc2hpZnQp
KSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBicmVh
azsKPiDCoMKgwqDCoMKgwqDCoMKgfQo+IC3CoMKgwqDCoMKgwqDCoGRlYnVnKCJkZXRlY3RlZCAl
dSBjb2x1bW5zXG4iLCBjb25maWctPmNvbHMpOwo+ICvCoMKgwqDCoMKgwqDCoGRlYnVnKCJkZXRl
Y3RlZCAldSBjb2x1bW5zXG4iLCBjb2xzKTsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqAvKiByZWNv
bmZpZ3VyZSB0byBtYWtlIHN1cmUgdGhhdCBhbGwgYWN0aXZlIHJvd3MgYXJlCj4gYWNjZXNzaWJs
ZSAqLwo+IC3CoMKgwqDCoMKgwqDCoGNvbmZpZy0+cm93cyA9IDE4Owo+ICvCoMKgwqDCoMKgwqDC
oGNvbmZpZy0+Y29scyA9IDg7Cj4gK8KgwqDCoMKgwqDCoMKgY29uZmlnLT5yb3dzID0gMTc7Cj4g
wqDCoMKgwqDCoMKgwqDCoG1jdGxfY29yZV9pbml0KHBhcmEsIGNvbmZpZyk7Cj4gwqAKPiDCoMKg
wqDCoMKgwqDCoMKgLyogZGV0ZWN0IHJvdyBhZGRyZXNzIGJpdHMgKi8KPiDCoMKgwqDCoMKgwqDC
oMKgc2hpZnQgPSBjb25maWctPmJ1c19mdWxsX3dpZHRoICsgNCArIGNvbmZpZy0+Y29sczsKPiAt
wqDCoMKgwqDCoMKgwqBmb3IgKGNvbmZpZy0+cm93cyA9IDEzOyBjb25maWctPnJvd3MgPCAxODsg
Y29uZmlnLT5yb3dzKyspIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKG1j
dGxfbWVtX21hdGNoZXMoMVVMTCA8PCAoY29uZmlnLT5yb3dzICsgc2hpZnQpKSkKPiArwqDCoMKg
wqDCoMKgwqBmb3IgKHJvd3MgPSAxMzsgcm93cyA8IDE3OyByb3dzKyspIHsKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKG1jdGxfbWVtX21hdGNoZXMoMVVMTCA8PCAocm93cyAr
IHNoaWZ0KSkpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgYnJlYWs7Cj4gwqDCoMKgwqDCoMKgwqDCoH0KPiAtwqDCoMKgwqDCoMKgwqBkZWJ1ZygiZGV0
ZWN0ZWQgJXUgcm93c1xuIiwgY29uZmlnLT5yb3dzKTsKPiArwqDCoMKgwqDCoMKgwqBkZWJ1Zygi
ZGV0ZWN0ZWQgJXUgcm93c1xuIiwgcm93cyk7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGNvbmZpZy0+
Y29scyA9IGNvbHM7Cj4gK8KgwqDCoMKgwqDCoMKgY29uZmlnLT5yb3dzID0gcm93czsKPiDCoH0K
PiDCoAo+IMKgc3RhdGljIHVuc2lnbmVkIGxvbmcgbWN0bF9jYWxjX3NpemUoY29uc3Qgc3RydWN0
IGRyYW1fY29uZmlnCj4gKmNvbmZpZykKCg==

