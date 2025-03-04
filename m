Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE04C282C6
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 01:13:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E3BF80786;
	Tue,  4 Mar 2025 02:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="VnlxvJnH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBA8280842; Tue,  4 Mar 2025 02:13:11 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by phobos.denx.de (Postfix) with ESMTP id D79048059D
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 02:13:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=andyshrk@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=fn7Ji4ARfAY/IYAmEHvco5DJ1bXyrK4DX7wJGDgKxHg=; b=V
 nlxvJnH3Kmw8Iy4vG2/GP8MBbVr6V2sq/kkzh7/iEopFhKiylqSuMyOwDoaDm/Gy
 6mftI2XZear6BG9c7teJT6+v+/y4UzTwFonCpuJZShu5AWBJwQKO0/kYwa08tPw4
 T1qXt3FAarwfeHruQmngakWJqRPUqNLN/1SeHiHBSA=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-100 (Coremail) ; Tue, 4 Mar 2025 09:12:42 +0800 (CST)
X-Originating-IP: [58.22.7.114]
Date: Tue, 4 Mar 2025 09:12:42 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Dang Huynh" <danct12@riseup.net>
Cc: "Anatolij Gustschin" <agust@denx.de>, "Simon Glass" <sjg@chromium.org>,
 "Philipp Tomsich" <philipp.tomsich@vrull.eu>,
 "Kever Yang" <kever.yang@rock-chips.com>, "Tom Rini" <trini@konsulko.com>,
 "Nicolas Frattaroli" <frattaroli.nicolas@gmail.com>,
 "Jonas Karlman" <jonas@kwiboo.se>, "Ondrej Jirman" <megi@xff.cz>,
 "Dragan Simic" <dsimic@manjaro.org>,
 "Svyatoslav Ryhel" <clamor95@gmail.com>, u-boot@lists.denx.de,
 "Chaoyi Chen" <chaoyi.chen@rock-chips.com>,
 "Damon Ding" <damon.ding@rock-chips.com>
Subject: Re:Re: [PATCH v2 06/11] video: rockchip: Add VOP2 support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <2377708.irdbgypaU6@melttower>
References: <20250223-vop2-pt2-v2-0-71350e482970@riseup.net>
 <20250223-vop2-pt2-v2-6-71350e482970@riseup.net>
 <97d68df3-e6e3-4912-aab3-0ffe09c218e2@rock-chips.com>
 <2377708.irdbgypaU6@melttower>
X-NTES-SC: AL_Qu2fA/yev08t5CiQZOkfmkcVgOw9UcO5v/Qk3oZXOJF8jCrp+T4yXHBTF1zd3fCDBzi2nQiHVRZJ0dhgcY1zcacMIcDjrtaQhEgloeXd2dYhcw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <79e71a91.ebe.1955eb65686.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: ZCgvCgDXlliKU8Zn8esaAA--.19176W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBkAoGXmfGTj2YMgABs7
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

CkhpIERhbnEsCgpBdCAyMDI1LTAzLTAyIDEyOjA5OjM0LCAiRGFuZyBIdXluaCIgPGRhbmN0MTJA
cmlzZXVwLm5ldD4gd3JvdGU6Cj5IaSBDaGFveWkgQ2hlbiwKPgo+T24gVGh1cnNkYXksIEZlYnJ1
YXJ5IDI3LCAyMDI1IDY6Mjk6MTPigK9BTSBVVEMgQ2hhb3lpIENoZW4gd3JvdGU6Cj4+IAo+PiBD
b3VsZCB5b3UgdXNlIGEgbmFtaW5nIHByZWZpeCBsaWtlICJya3ZvcDIiIHRvIGV4cGxpY2l0bHkg
aW5kaWNhdGUgdGhlCj4+IHVzZSBvZiB2b3AyLCB0aGVyZWJ5IGRpc3Rpbmd1aXNoaW5nIGl0IGZy
b20gcmtfdm9wLmM/Cj4+IAo+WWVzLiBUaGlzIHdpbGwgYmUgaW4gdjMuCj4KPj4gPiArCXN0cnVj
dCByazM1Njhfdm9wX2VzbWFydCAqZXNtYXJ0ID0gcHJpdi0+cmVncyArIAo+Vk9QMl9FU01BUlRf
T0ZGU0VUKDApOwo+PiAKPj4gWW91IGFyZSBhc3N1bWluZyB0aGF0IHRoZSBSSzM1NlggaXMgYWx3
YXlzIHVzZWQgRVNNQVJUMCwgd2hpY2ggZ2VuZXJhbGx5Cj4+IHdvcmtzLiBCdXQgY29uc2lkZXJp
bmcKPj4gdGhhdCB0aGVyZSBhcmUgbXVsdGlwbGUgVmlkZW8gUG9ydHMgYW5kIGRpZmZlcmVudCBW
aWRlbyBQb3J0cyBtYXkgaGF2ZQo+PiBkaWZmZXJlbnQgcHJpbWFyeSB3aW4sCj4+IHNlbGVjdGlu
ZyB0aGUgYXBwcm9wcmlhdGUgd2luIGNhbiBzaW1wbGlmaWVzIHRoZSBwcm9jZXNzaW5nIGZvciBV
LUJvb3QKPj4gdG8gS2VybmVsIHRyYW5zaXRpb25zIGluIHRoZSBmdXR1cmUuCj4+IAo+PiBJdCdz
IGEgZ29vZCBpZGVhIHRvIGltcGxlbWVudCB0aGUgd2luIHNlbGVjdGlvbiBhcyBhIGNvbmZpZ3Vy
YWJsZQo+PiBwYXJhbWV0ZXIsIG9yIHdlIGNhbiBjb25zaWRlciB0aGUKPj4gZGVmYXVsdCB3aW4g
dXNlZCBmb3IgZGlmZmVyZW50IFZpZGVvIFBvcnRzLgo+RVNNQVJUMCBpcyBjb25maWd1cmVkIHRv
IHRoZSBkZXNpcmVkIHZpZGVvIHBvcnQgb24gVS1Cb290LiBWT1AyIHNob3VsZCBiZSAKPnJlY29u
ZmlndXJlZCBieSBMaW51eC4KCkFzIHlvdSBjdXJyZW50bHkgIkRpc2FibGUgZXNtYXJ0IGFuZCBw
b3N0IGJlZm9yZSBib290aW5nIHRvIE9TIiwgIFNvIHRoZSBjdXJyZW50CmFwcHJvYWNoIHdvbid0
IGNhdXNlIGFueSBpc3N1ZXMuIEJ1dCBpZiBvbmUgZGF5IHdlIGNhbiBtYWtlIHRoZSBVLUJvb3Qg
bG9nbyByZW1haW5zIGRpc3BsYXllZCB1bnRpbAprZXJuZWwgYm9vdHVwIGNvbXBsZXRpb24sIGFu
ZCBpZiB0aGUgdS1ib290IGxvZ28gaXMgbm90IGRpc3BsYXllZCBvbiB0aGUgcHJpbWFyeSBwbGFu
ZSwgdGhlcmUgd291bGQgYmUKbm8gYXBwbGljYXRpb25zIGF0dGVtcHRpbmcgdG8gZGlzYWJsZSB0
aGUgdS1ib290IGxvZ2/vvIxiZWNhc3VlIExpbnV4IGtlcm5lbCBsb2dvIG9yIFVJIGFwcGxpY2F0
aW9uIGFsd2F5cwpzZWxlY3QgcHJpbWFyeSBwbGFuZeOAggpJIGFtIHVuY2VydGFpbiB3aGV0aGVy
IG90aGVyIHBsYXRmb3JtcyBoYXZlIGltcGxlbWVudGVkIGFuYWxvZ291cyBjb25zaWRlcmF0aW9u
cyB3aGVuIGNob3NlIHdoaWNoIHBsYW5lIHRvIHNob3cKbG9nbyB3aXRoaW4gVS1Cb290LgoKCj4K

