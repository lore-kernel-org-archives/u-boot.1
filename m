Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91C1ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 12:49:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 258BA8902F;
	Tue, 10 Sep 2024 14:49:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZfvWZ3BJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4ABD8907E; Tue, 10 Sep 2024 14:49:45 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F22A8902B
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 14:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-45823ee8e62so2929121cf.2
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 05:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725972582; x=1726577382; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VzADzj8n+Ma0iVpWBaZgxZ+ELSo+MnH2aJlohJN2KQY=;
 b=ZfvWZ3BJBRIVvVCpcElcWETbfYwOb7LPCqWfBP1j73ZkRhPNcA85pR1j/0atwcvL7F
 0yQhZwIwLRs0awdctzaYmUQp+ljuodOqxJsWD3fCc/XQdyJqB/e/Ax8CcB8zrFj/Ih2a
 ugwVl8waKXKFA7GHlXlozvk3+/1UXS+zlpyGTGFUgByBF/2cch98FPP5WT9Ep1BPnwwW
 bG69njOICFiEzJab8/bp90I4FL7TBoMjBWQup6nhf+KkI4mo1BH05cBwLh8v1qQYCt28
 nORj5WFfJeGwTUgriLpAffVGLB8dHDbStBWMROfeXWe+ykcGA7jMyJwsb9daggehlLtj
 OZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725972582; x=1726577382;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VzADzj8n+Ma0iVpWBaZgxZ+ELSo+MnH2aJlohJN2KQY=;
 b=fwPzGZucU6MdlnpJPmL5iyZMahy46CCt/eyLr8n101WzD0PtieLhaCn7dgyYTRatZK
 IcDlp5j7ag6iQsURBumwq6uZzMbMXi35U2iwVelGiv6WeIe6ZvAw6HIhC1fpIPzhucvX
 yqNzr8X6+15/z7j36yLNYK3K+xpIhe5J5FFyQYwUcd8YPyFvsmo5KtVhE3iWbC6OrXoX
 j650JRwRoojxmihOpNPSmL9q6YVhIMMXWFhXWgovqWjYIN5eMDw4lt4hlezQOA6Q6Nf/
 hR2JBZemE81mFf0HBseC06dXqtPBkk1x9Ndvv1c8xPJZoPa6ufH/d/6ZgVwDiBytzgqN
 sr5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy3KkBq7d6MvH3T6EQzkz3VmqXFLj6n4hTycvoJldrPOjGIY7ZXSx0Ml7JohExFkjld/O72tA=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/e1qkknm8UpdtcZywfZvCyYqz71v0tzqlzTpYa05Xpzs/vtys
 5MJLwbiFCmrgCBh/vZVJX2mBwXObtVlNuzOZOVpH1OtQYYyIV/eCoE54Y0sK
X-Google-Smtp-Source: AGHT+IEPlZFFRvJFwT0/Td9Qd+cDWuHMbkvZNvt95p6jhzRwsr0NqDtxGLBXR+w4dgkF9QAHf8Eypg==
X-Received: by 2002:a05:6214:76c:b0:6c3:69f9:fb5b with SMTP id
 6a1803df08f44-6c5281b87c1mr80175616d6.0.1725972582265; 
 Tue, 10 Sep 2024 05:49:42 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c5343471b8sm29703796d6.66.2024.09.10.05.49.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 05:49:41 -0700 (PDT)
Message-ID: <51833d83-d6e2-0bff-67a9-cf9a04ea9c91@gmail.com>
Date: Tue, 10 Sep 2024 08:49:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] spl: ram: hide SPL_RAM_SUPPORT
Content-Language: en-US
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andre Przywara <andre.przywara@arm.com>, Samuel Holland
 <samuel@sholland.org>, Lukas Funke <lukas.funke@weidmueller.com>
References: <20240910090013.2686124-1-jerome.forissier@linaro.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240910090013.2686124-1-jerome.forissier@linaro.org>
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

T24gOS8xMC8yNCAwNTowMCwgSmVyb21lIEZvcmlzc2llciB3cm90ZToNCj4gTWFrZSBTUExf
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
Lm9yZz4NCj4gLS0tDQo+ICAgY29tbW9uL3NwbC9LY29uZmlnIHwgOCArKy0tLS0tLQ0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0K
PiBSZXBsYWNlcyAic3BsOiByYW06IGZpeCBidWlsZCB3YXJuaW5nIHdoZW4gbmVpdGhlciBS
QU1fREVWSUNFIG5vciBERlUNCj4gYXJlIGVuYWJsZWQiIFsxXS4NCj4gDQo+IFsxXSBodHRw
czovL2xpc3RzLmRlbnguZGUvcGlwZXJtYWlsL3UtYm9vdC8yMDI0LVNlcHRlbWJlci81NjQz
MDIuaHRtbA0KPiANCj4gZGlmZiAtLWdpdCBhL2NvbW1vbi9zcGwvS2NvbmZpZyBiL2NvbW1v
bi9zcGwvS2NvbmZpZw0KPiBpbmRleCBjMDhmZjA2NDQ5My4uODg1YTAxMjQ2MWMgMTAwNjQ0
DQo+IC0tLSBhL2NvbW1vbi9zcGwvS2NvbmZpZw0KPiArKysgYi9jb21tb24vc3BsL0tjb25m
aWcNCj4gQEAgLTEyMzgsMTUgKzEyMzgsMTEgQEAgY29uZmlnIFNQTF9QT1dFUl9ET01BSU4N
Cj4gICAJICB0aGUgZHJpdmVycyBpbiBkcml2ZXJzL3Bvd2VyL2RvbWFpbiBhcyBwYXJ0IG9m
IGEgU1BMIGJ1aWxkLg0KPiAgIA0KPiAgIGNvbmZpZyBTUExfUkFNX1NVUFBPUlQNCj4gLQli
b29sICJTdXBwb3J0IGJvb3RpbmcgZnJvbSBSQU0iDQo+IC0JZGVmYXVsdCB5IGlmIE1JQ1JP
QkxBWkUgfHwgQVJDSF9TT0NGUEdBIHx8IEFSQ0hfVEVHUkEgfHwgQVJDSF9aWU5RDQo+IC0J
aGVscA0KPiAtCSAgRW5hYmxlIGJvb3Rpbmcgb2YgYW4gaW1hZ2UgaW4gUkFNLiBUaGUgaW1h
Z2UgY2FuIGJlIHByZWxvYWRlZCBvcg0KPiAtCSAgaXQgY2FuIGJlIGxvYWRlZCBieSBTUEwg
ZGlyZWN0bHkgaW50byBSQU0gKGUuZy4gdXNpbmcgVVNCKS4NCj4gKwlib29sDQo+ICAgDQo+
ICAgY29uZmlnIFNQTF9SQU1fREVWSUNFDQo+ICAgCWJvb2wgIlN1cHBvcnQgYm9vdGluZyBm
cm9tIHByZWxvYWRlZCBpbWFnZSBpbiBSQU0iDQo+IC0JZGVwZW5kcyBvbiBTUExfUkFNX1NV
UFBPUlQNCj4gKwlzZWxlY3QgU1BMX1JBTV9TVVBQT1JUDQo+ICAgCWRlZmF1bHQgeSBpZiBN
SUNST0JMQVpFIHx8IEFSQ0hfU09DRlBHQSB8fCBBUkNIX1RFR1JBIHx8IEFSQ0hfWllOUQ0K
PiAgIAloZWxwDQo+ICAgCSAgRW5hYmxlIGJvb3Rpbmcgb2YgYW4gaW1hZ2UgYWxyZWFkeSBs
b2FkZWQgaW4gUkFNLiBUaGUgaW1hZ2UgaGFzIHRvDQoNCkkgdGhpbmsgU1BMX0RGVSBzaG91
bGQgYWxzbyBzZWxlY3QgU1BMX1JBTV9TVVBQT1JUDQoNCi0tU2Vhbg0K
