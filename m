Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3A9C77B7F
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 11:38:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BAEE81F66;
	Mon, 23 Jun 2025 13:38:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="I2YsnzIS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08ACE8210D; Mon, 23 Jun 2025 13:38:22 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 099FA80548
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 13:38:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fiona.klute@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1750678699; x=1751283499; i=fiona.klute@gmx.de;
 bh=qvc6rkQAE3Kah2hVEjN0/hrIQmcikgOhjb+7DmP+YBA=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=I2YsnzISl9PsabD4PVPhg3wmitF4Gb9ori6wDrOUbFW1JfRwPG0djf+5bX1K+0fF
 dV5d6c1q33PWuYTcKHP14F/3HgaCvukLnVLxotKMi+LgayGEQUlubgAai6mceUW0a
 uIa4LIJ58RysVvcf+dQO/e8PdVQjW2HPfA5oSKq7wOBk97cKiiTiv+qd03CwDB2/B
 AhJniMrcgy4249nVWPEbL09Yb8mIyJ/ARYzmjNkwd0+kNn2hQ1z+I1jAKlHO89pST
 MeAONrfj9UwNT23eWaNmk+QmepTjhoIs+FAh1x7NckG0mL7tyRkfYf0TSTpXAjwhv
 Sih+/SA+YGYhDg9ROw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.home.arpa ([85.22.119.189]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mzyyk-1uihif1OdC-017TJC; Mon, 23
 Jun 2025 13:38:19 +0200
From: Fiona Klute <fiona.klute@gmx.de>
To: u-boot@lists.denx.de
Cc: Fiona Klute <fiona.klute@gmx.de>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/1] doc: mention that extlinux.conf can use environment in
 "append"
Date: Mon, 23 Jun 2025 13:38:01 +0200
Message-ID: <20250623113801.2655669-1-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:FiTb2VfqhiS1u4GfPIZ4iR8lFMKJ5PFzuVv+YpS3lU8Bpv5EWXU
 FGr7V38ndbMYsElPxm/IL1Io8cJLsxlHCLY/8/sC//pycySCqq1GCTLKuuPEQGkyNZI3R7B
 8mCN9pdmstxf4/XUy+zz0FYQcydo/UvVFC91b79U5A0wcK43gEgZIjrwIR2ALcrpAp4P4ky
 DZ7faalDv+STNgtvGd+Dg==
UI-OutboundReport: notjunk:1;M01:P0:nWjQLtzkOd0=;0O/creCH/arx4kw2XdyxpDGgmNT
 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
 YtWvNA0PBGVdP4HGWZmCYJPhVlraMQUUu8eZFQ==
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

VGhpcyBvcHRpb24gaXMgdmVyeSB1c2VmdWwgZm9yIEEvQiBib290IHNldHVwcyB3aXRoIHJlYWQt
b25seQpmaWxlc3lzdGVtczogTGV0dGluZyBVLUJvb3QgZmlsbCBpbiB0aGUgcm9vdGZzIChhbmQg
cG9zc2libHkgcmVsYXRlZApwYXJhbWV0ZXJzKSBhbGxvd3Mga2VlcGluZyBhbGwgYm9vdCBwYXJh
bWV0ZXJzIGV4Y2VwdCB0aGUgYWN0dWFsIHNsb3QKc2VsZWN0aW9uIGluIHRoZSBleHRsaW51eC5j
b25mIGZpbGUsIHdoZXJlIHRoZXkgY2FuIGJlIHVwZGF0ZWQgZWFzaWx5LgoKU2lnbmVkLW9mZi1i
eTogRmlvbmEgS2x1dGUgPGZpb25hLmtsdXRlQGdteC5kZT4KQ2M6IFRvbSBSaW5pIDx0cmluaUBr
b25zdWxrby5jb20+Ci0tLQogZG9jL1JFQURNRS5weGUgICAgICAgICB8IDMgKystCiBkb2MvZGV2
ZWxvcC9kaXN0cm8ucnN0IHwgNyArKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RvYy9SRUFETUUucHhlIGIvZG9jL1JF
QURNRS5weGUKaW5kZXggOWZmZjJjZDVhZTkuLmJhMTg5MDgwZThjIDEwMDY0NAotLS0gYS9kb2Mv
UkVBRE1FLnB4ZQorKysgYi9kb2MvUkVBRE1FLnB4ZQpAQCAtMTc4LDcgKzE3OCw4IEBAIGRldmlj
ZXRyZWUtb3ZlcmxheSA8cGF0aD4gWy4uLl0gLSBpZiB0aGlzIGxhYmVsIGlzIGNob3NlbiwgdXNl
IHRmdHAgdG8gcmV0cmlldmUKIGthc2xyc2VlZCAgICAgICAgICAgLSBzZXQgdGhpcyBsYWJlbCB0
byByZXF1ZXN0IHJhbmRvbSBudW1iZXIgZnJvbSBod3JuZyBhcyBrYXNsciBzZWVkLgogCiBhcHBl
bmQgPHN0cmluZz4JICAgIC0gdXNlIDxzdHJpbmc+IGFzIHRoZSBrZXJuZWwgY29tbWFuZCBsaW5l
IHdoZW4gYm9vdGluZyB0aGlzCi0JCSAgICAgIGxhYmVsLgorCQkgICAgICBsYWJlbC4gRW52aXJv
bm1lbnQgdmFyaWFibGUgcmVmZXJlbmNlcyBsaWtlICR7dmFyfSBhcmUKKwkJICAgICAgc3Vic3Rp
dHV0ZWQgYmVmb3JlIGJvb3QuCiAKIGluaXRyZCA8cGF0aD4JICAgIC0gaWYgdGhpcyBsYWJlbCBp
cyBjaG9zZW4sIHVzZSB0ZnRwIHRvIHJldHJpZXZlIHRoZSBpbml0cmQKIAkJICAgICAgYXQgPHBh
dGg+LiBpdCB3aWxsIGJlIHN0b3JlZCBhdCB0aGUgYWRkcmVzcyBpbmRpY2F0ZWQgaW4KZGlmZiAt
LWdpdCBhL2RvYy9kZXZlbG9wL2Rpc3Ryby5yc3QgYi9kb2MvZGV2ZWxvcC9kaXN0cm8ucnN0Cmlu
ZGV4IDFkMmY5YzRjMzJiLi4wMWVmY2U0MGEyOSAxMDA2NDQKLS0tIGEvZG9jL2RldmVsb3AvZGlz
dHJvLnJzdAorKysgYi9kb2MvZGV2ZWxvcC9kaXN0cm8ucnN0CkBAIC05Miw2ICs5MiwxMyBAQCBU
aGF0IHNhaWQsIHdlIGhhdmUgc29tZSBkaWZmZXJlbmNlcyB0byB0aGVzZSBkb2N1bWVudHMsIG5h
bWVseToKICogSWYgYGAtYGAgaXMgcGFzc2VkIGFzIGZkdCBhcmd1bWVudCBhbmQgYGBDT05GSUdf
U1VQUE9SVF9QQVNTSU5HX0FUQUdTYGAgaXMKICAgZW5hYmxlZCwgdGhlbiBubyBkZXZpY2UgdHJl
ZSB3aWxsIGJlIHVzZWQgKGxlZ2FjeSBib290aW5nIC8gcHJlLWR0YiBrZXJuZWwpLgogCisqIFRo
ZSBgYGFwcGVuZGBgIHN0cmluZyBtYXkgdXNlIGVudmlyb25tZW50IHZhcmlhYmxlcy4gRm9yIGV4
YW1wbGUsIGFuCisgIEEvQiBib290IHNldHVwIGNvdWxkIHVzZSBgYGFwcGVuZCByb290PVBBUlRM
QUJFTD1yb290XyR7Ym9vdHNsb3R9YGAKKyAgdG8gc2V0IHRoZSByb290IGZpbGVzeXN0ZW0gdG8g
dGhlIHJpZ2h0IG9uZSBmb3IgdGhlIHNlbGVjdGVkIHNsb3QsCisgIGFzc3VtaW5nIHRoZSBgYGJv
b3RzbG90YGAgZW52aXJvbm1lbnQgdmFyaWFibGUgaXMgc2V0IGJlZm9yZSB0aGUKKyAgZXh0bGlu
dXguY29uZiBmaWxlIGlzIHByb2Nlc3NlZCwgYW5kIHRoZSBwYXJ0aXRpb24gaXMgbGFiZWxlZCB0
bworICBtYXRjaC4KKwogU2VlIGFsc28gZG9jL1JFQURNRS5weGUgdW5kZXIgJ3B4ZSBmaWxlIGZv
cm1hdCcuCiAKIE9uZSBleGFtcGxlIGV4dGxpbnV4LmNvbmYgZ2VuZXJhdGVkIGJ5IHRoZSBGZWRv
cmEgaW5zdGFsbGVyIGlzOjoKLS0gCjIuNTAuMAoK
