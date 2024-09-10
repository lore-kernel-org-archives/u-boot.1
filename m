Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6B7EB64DE
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 13:04:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9259789048;
	Tue, 10 Sep 2024 15:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N8qet6TG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C162890BD; Tue, 10 Sep 2024 15:04:27 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E5D788F6F
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 15:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6c367e0ce98so2433936d6.3
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 06:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725973459; x=1726578259; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SnTCkW11Ol/b2hNHIeYaCSF5pmHbpWVm7telQKe60jU=;
 b=N8qet6TGTzQyu6y0OO2WDPSOAWP60WsRjYuXxfeJAXHTXO4LXg67aPTmhRDJoPZMa8
 OA5yb2LGjcGJT5PnhX0P7Ijy5+SeUBD//72JJio1zZKNbkgNoaNS4GYLr7cj8+3vLVET
 fOpaKA2yQzmodL1ToG/ytrEOHxVsj4hbBawfv0BNUeYFwCjHzwcG3SjasHUx+03mjPrt
 fk1pncSORVt4cQVTwns6IbmmVbbz9+O/rLhPVRQWvDnP/wKeUXR/7bOns8pMcomDfaN1
 lPZLKa7b6Zjb/mQvsPbOX9qeEvdqRY1VplrqmcsPr5n38NiiZ1f1dNKPNBPP9zI05cq/
 2v/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725973459; x=1726578259;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SnTCkW11Ol/b2hNHIeYaCSF5pmHbpWVm7telQKe60jU=;
 b=JiJB+52H0++BgVhBqNb2ssGOJ3yWsfebVS8fyJP4/5lRODTT2wCgBrMvE3raTEkMTs
 CrCMQO/lwFKJva1VDgpgDFaguk1TZ22QWnDZlm2TIms99+pH7M1SUeJF17XZ+NhF9KVp
 hGgRvA65/87DqizEWxaZUUXKqRP7K3S7gSphZHAnCV4ib10JUkmgz0Dxn0GpRsbMH3wD
 WkvD370+GbnRtiEa/i25Fm3syC5BxxNrAHhT41qeoqZ8AZ9QOveXbuom+9ef/vemUsL8
 LkTj60wKdXc1d0hCX/ayaYsU27QyC8nHsrdeFm1ebRMjj1tzZf79NrLv2EXmjtkj/BGJ
 z8Kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuwu0iFWeHGAXji8KMkSdlRhF/shAtdwl8dL1eoX7knJh6PkvuyT4FTVd+MOPaZ1sd/HId8f8=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+mHgMhTcouVL5UIUrwTN0jnpn2BjIfS2agbF4WjAvo+C0kRpp
 rQkfHYY5YVInDxnDDtciMUxmdW2VnCdhQdM6Svbqb9y1WQaJF3wL
X-Google-Smtp-Source: AGHT+IESjLyS7bFS02Y0RXCGlC6LKNaFDToqYqctspYMypYRwNSxEXjb8FzDXsGm4Q2Amjz3zCirIw==
X-Received: by 2002:ad4:5f4d:0:b0:6c5:258f:26c1 with SMTP id
 6a1803df08f44-6c52850dc46mr83344436d6.7.1725973457220; 
 Tue, 10 Sep 2024 06:04:17 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c53478601csm29787626d6.134.2024.09.10.06.04.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 06:04:16 -0700 (PDT)
Message-ID: <5feee73f-f2d2-e21a-af62-277fb54fc0d2@gmail.com>
Date: Tue, 10 Sep 2024 09:04:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] spl: ram: hide SPL_RAM_SUPPORT
Content-Language: en-US
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Marek Vasut
 <marex@denx.de>, Simon Glass <sjg@chromium.org>,
 Andre Przywara <andre.przywara@arm.com>, Samuel Holland
 <samuel@sholland.org>, Lukas Funke <lukas.funke@weidmueller.com>,
 Jonas Karlman <jonas@kwiboo.se>, Miquel Raynal <miquel.raynal@bootlin.com>
References: <20240910130019.3211647-1-jerome.forissier@linaro.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240910130019.3211647-1-jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
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

T24gOS8xMC8yNCAwOTowMCwgSmVyb21lIEZvcmlzc2llciB3cm90ZToNCj4gTWFrZSBTUExf
UkFNX1NVUFBPUlQgYSBoaWRkZW4gS2NvbmZpZyBzeW1ib2wsIGF1dG9tYXRpY2FsbHkgc2Vs
ZWN0ZWQNCj4gYnkgU1BMX1JBTV9ERVZJQ0Ugb3IgU1BMX0RGVS4gQXZvaWRzIHRoZSBzaXR1
YXRpb24gd2hlcmUgU1BMX1JBTV9TVVBQT1JUDQo+IG1heSBiZSBlbmFibGVkIHdpdGhvdXQg
dGhlIG90aGVyIHR3byBiZWluZyBlbmFibGVkLCB3aGljaCByZXN1bHRzIGluIHRoZQ0KPiBm
b2xsb3dpbmcgYnVpbGQgd2FybmluZzoNCj4gDQo+IGNvbW1vbi9zcGwvc3BsX3JhbS5jOjE5
OjE0OiB3YXJuaW5nOiDigJhzcGxfcmFtX2xvYWRfcmVhZOKAmSBkZWZpbmVkIGJ1dCBub3Qg
dXNlZCBbLVd1bnVzZWQtZnVuY3Rpb25dDQo+ICAgICAxOSB8IHN0YXRpYyB1bG9uZyBzcGxf
cmFtX2xvYWRfcmVhZChzdHJ1Y3Qgc3BsX2xvYWRfaW5mbyAqbG9hZCwgdWxvbmcgc2VjdG9y
LA0KPiAgICAgICAgfCAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEplcm9tZSBGb3Jpc3NpZXIgPGplcm9tZS5mb3Jpc3NpZXJAbGluYXJv
Lm9yZz4NCj4gLS0tDQo+ICAgY29tbW9uL3NwbC9LY29uZmlnICAgICAgICAgfCA4ICsrLS0t
LS0tDQo+ICAgZHJpdmVycy91c2IvZ2FkZ2V0L0tjb25maWcgfCAyICstDQo+ICAgMiBmaWxl
cyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvY29tbW9uL3NwbC9LY29uZmlnIGIvY29tbW9uL3NwbC9LY29uZmlnDQo+IGlu
ZGV4IGMwOGZmMDY0NDkzLi44ODVhMDEyNDYxYyAxMDA2NDQNCj4gLS0tIGEvY29tbW9uL3Nw
bC9LY29uZmlnDQo+ICsrKyBiL2NvbW1vbi9zcGwvS2NvbmZpZw0KPiBAQCAtMTIzOCwxNSAr
MTIzOCwxMSBAQCBjb25maWcgU1BMX1BPV0VSX0RPTUFJTg0KPiAgIAkgIHRoZSBkcml2ZXJz
IGluIGRyaXZlcnMvcG93ZXIvZG9tYWluIGFzIHBhcnQgb2YgYSBTUEwgYnVpbGQuDQo+ICAg
DQo+ICAgY29uZmlnIFNQTF9SQU1fU1VQUE9SVA0KPiAtCWJvb2wgIlN1cHBvcnQgYm9vdGlu
ZyBmcm9tIFJBTSINCj4gLQlkZWZhdWx0IHkgaWYgTUlDUk9CTEFaRSB8fCBBUkNIX1NPQ0ZQ
R0EgfHwgQVJDSF9URUdSQSB8fCBBUkNIX1pZTlENCj4gLQloZWxwDQo+IC0JICBFbmFibGUg
Ym9vdGluZyBvZiBhbiBpbWFnZSBpbiBSQU0uIFRoZSBpbWFnZSBjYW4gYmUgcHJlbG9hZGVk
IG9yDQo+IC0JICBpdCBjYW4gYmUgbG9hZGVkIGJ5IFNQTCBkaXJlY3RseSBpbnRvIFJBTSAo
ZS5nLiB1c2luZyBVU0IpLg0KPiArCWJvb2wNCj4gICANCj4gICBjb25maWcgU1BMX1JBTV9E
RVZJQ0UNCj4gICAJYm9vbCAiU3VwcG9ydCBib290aW5nIGZyb20gcHJlbG9hZGVkIGltYWdl
IGluIFJBTSINCj4gLQlkZXBlbmRzIG9uIFNQTF9SQU1fU1VQUE9SVA0KPiArCXNlbGVjdCBT
UExfUkFNX1NVUFBPUlQNCj4gICAJZGVmYXVsdCB5IGlmIE1JQ1JPQkxBWkUgfHwgQVJDSF9T
T0NGUEdBIHx8IEFSQ0hfVEVHUkEgfHwgQVJDSF9aWU5RDQo+ICAgCWhlbHANCj4gICAJICBF
bmFibGUgYm9vdGluZyBvZiBhbiBpbWFnZSBhbHJlYWR5IGxvYWRlZCBpbiBSQU0uIFRoZSBp
bWFnZSBoYXMgdG8NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC9LY29uZmln
IGIvZHJpdmVycy91c2IvZ2FkZ2V0L0tjb25maWcNCj4gaW5kZXggNDYyMWE2ZmQ1ZTYuLmIx
MjQ3YTllZWFlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvS2NvbmZpZw0K
PiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvS2NvbmZpZw0KPiBAQCAtMzIzLDcgKzMyMyw3
IEBAIGNvbmZpZyBTUExfREZVDQo+ICAgCWJvb2wgIlN1cHBvcnQgREZVIChEZXZpY2UgRmly
bXdhcmUgVXBncmFkZSkgaW4gU1BMIg0KPiAgIAlzZWxlY3QgU1BMX0hBU0gNCj4gICAJc2Vs
ZWN0IFNQTF9ERlVfTk9fUkVTRVQNCj4gLQlkZXBlbmRzIG9uIFNQTF9SQU1fU1VQUE9SVA0K
PiArCXNlbGVjdCBTUExfUkFNX1NVUFBPUlQNCj4gICAJaGVscA0KPiAgIAkgIFRoaXMgZmVh
dHVyZSBlbmFibGVzIHRoZSBERlUgKERldmljZSBGaXJtd2FyZSBVcGdyYWRlKSBpbiBTUEwg
d2l0aA0KPiAgIAkgIFJBTSBtZW1vcnkgZGV2aWNlIHN1cHBvcnQuIFRoZSBST00gY29kZSB3
aWxsIGxvYWQgYW5kIGV4ZWN1dGUNCg0KUmV2aWV3ZWQtYnk6IFNlYW4gQW5kZXJzb24gPHNl
YW5nYTJAZ21haWwuY29tPg0K
