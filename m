Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB423C02183
	for <u-boot@archiver.kernel.org>; Sun, 19 Jan 2025 09:25:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42DF180141;
	Sun, 19 Jan 2025 10:25:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="abTc+sgk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CA7C801CF; Sun, 19 Jan 2025 10:25:23 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
 by phobos.denx.de (Postfix) with ESMTP id 5A110800CF
 for <u-boot@lists.denx.de>; Sun, 19 Jan 2025 10:25:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=andyshrk@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=oxd6inc4S6kpFq2ht3+u5r6V2pVsOmEoaBf/cwv27mU=; b=a
 bTc+sgkZREFR26ePZaFf9QvNCKlhs3ogFQ6P0vmMqGz15mUNW/pSDAA51AXSLojY
 R/hiS5cXlGudnyqXZ2Ew7VkI6v75L9hSlu66JTzZWFbxt7wVoLLXwtwswLqW8B7j
 1DSRdSORANwQwTBV9dWC0vrbI5+N/XrBbFPaT1JRtI=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-141 (Coremail) ; Sun, 19 Jan 2025 17:25:07 +0800
 (CST)
X-Originating-IP: [58.22.7.114]
Date: Sun, 19 Jan 2025 17:25:07 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Quentin Schulz" <quentin.schulz@cherry.de>
Cc: kever.yang@rock-chips.com, u-boot@lists.denx.de,
 "Dragan Simic" <dsimic@manjaro.org>, "Jonas Karlman" <jonas@kwiboo.se>
Subject: Re:Re: [PATCH] doc: coolpi: Fix the defconfig name
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <0b88a0e0-626c-4550-b59c-d118290d2e96@cherry.de>
References: <20250113105617.2403788-1-andyshrk@163.com>
 <0b88a0e0-626c-4550-b59c-d118290d2e96@cherry.de>
X-NTES-SC: AL_Qu2YBf6ct08r4SWaY+kfmkcVgOw9UcO5v/Qk3oZXOJF8jCrr+CUnVkFMJFbsweeONhCLrheYTj1O48h1bZN6b5Mb+rGYaiWsLYzfUyqSHKsd4Q==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <42f75b94.18f0.1947de1574f.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: jSgvCgD33wHzxIxnF15aAA--.10218W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqADZXmeMvjtCrQACss
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
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

CkhpIFF1ZW50aW4sCgpBdCAyMDI1LTAxLTE1IDE3OjI5OjEwLCAiUXVlbnRpbiBTY2h1bHoiIDxx
dWVudGluLnNjaHVsekBjaGVycnkuZGU+IHdyb3RlOgo+SGkgQW5keSwKPgo+T24gMS8xMy8yNSAx
MTo1NiBBTSwgQW5keSBZYW4gd3JvdGU6Cj4+IFRoZSBkZWZjb25maWcgbmFtZSBzaG91bGQgYmU6
IGNvb2xwaS1jbTUtZ2VuYm9vay1yazM1ODhfZGVmY29uZmlnCj4+IAo+PiBTaWduZWQtb2ZmLWJ5
OiBBbmR5IFlhbiA8YW5keXNocmtAMTYzLmNvbT4KPgo+UmV2aWV3ZWQtYnk6IFF1ZW50aW4gU2No
dWx6IDxxdWVudGluLnNjaHVsekBjaGVycnkuZGU+CgpGaXJzdCwgIHRoYW5rcyBmb3IgeW91ciBy
ZXZpZXcuCgo+Cj4+IC0tLQo+PiAKPj4gICBkb2MvYm9hcmQvY29vbHBpL2dlbmJvb2tfY201X3Jr
MzU4OC5yc3QgfCAyICstCj4KPldoYXQgYWJvdXQgcmVuYW1pbmcgZXZlcnkgZmlsZSB0aGF0IGFy
ZSBpbmNvbnNpc3RlbnQgaW4gbmFtaW5nPwo+Cj5ib2FyZC9jb29scGkvZ2VuYm9va19jbTVfcmsz
NTg4LyB0byBib2FyZC9jb29scGkvY201X2dlbmJvb2tfcmszNTg4Lwo+ZG9jL2JvYXJkL2Nvb2xw
aS9nZW5ib29rX2NtNV9yazM1ODgucnN0IHRvIAo+ZG9jL2JvYXJkL2Nvb2xwaS9jbTVfZ2VuYm9v
a19yazM1ODgucnN0Cj5pbmNsdWRlL2NvbmZpZ3MvZ2VuYm9vay1jbTUtcmszNTg4LmggdG8gaW5j
bHVkZS9jb25maWdzL2NtNS1nZW5ib29rLXJrMzU4OC5oCj4KPklmIHdlIGRvIHRoaXMgY2hhbmdl
LCB3ZSBhbHNvIG5lZWQgdG8gY2hhbmdlIGEgZmV3IHZhcmlhYmxlcyBpbiAKPktjb25maWcvZGVm
Y29uZmlnLiBJZiB3ZSBkbyB0aGlzIGNoYW5nZSwgaXQgbmVlZHMgdG8gYmUgZG9uZSBpbiBhIAo+
c2VwYXJhdGUgcGF0Y2ggdGhvdWdoIQoKUGxlYXNlIGNoZWNrIHRoZSByZXZpZXcgcmVjb3JkcyB3
aGVuIEkgZmlyc3Qgc3VibWl0dGVkIHRoZSBwYXRjaCBmb3IgdGhpcyBib2FyZCdzIHN1cHBvcnRb
MF1bMV0sCgpBcyBmb3IgbXlzZWxmLCBJIGNhbiBhY2NlcHQgYm90aCBuYW1pbmcgY29udmVudGlv
bnMuIEhvd2V2ZXIsIGRpZmZlcmVudCByZXZpZXdlciAgc2VlbSB0byBoYXZlIGRpZmZlcmVudApu
YW1laW5nIHJ1bGVzLiAKClswXWh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3UtYm9vdC8yMDI0MDgx
MTEwMDI1NS4xNjY0MDk1LTEtYW5keXNocmtAMTYzLmNvbS8KWzFdaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvdS1ib290L2UyNTFhYjhjLWYzZDItNDg5ZS1hM2M4LWM3MTU0ZTk2YzJlNEBrd2lib28u
c2UvCj4KPldoYXQgZG8geW91IHRoaW5rPwoKQW55d2F5LCBJIHRoaW5rIHRoaXMgcGF0Y2ggc2hv
dWxkIGJlIG1lcmdlZCBmaXJzdCB0byBhdm9pZCBtaXNsZWFkaW5nIG90aGVycyB3aG8gd2FudCB0
byBwcmFjdGljZSBvbiB0aGVpciBvd24uCgo+Cj5DaGVlcnMsCj5RdWVudGluCg==
