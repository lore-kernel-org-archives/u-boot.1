Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB580FD461E
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 05:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 321BD83C54;
	Thu, 26 Feb 2026 06:10:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sl5O7dOW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9674083D1A; Thu, 26 Feb 2026 06:10:42 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C8ED83AA9
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 06:10:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-506984b6e65so593731cf.0
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 21:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772082639; x=1772687439; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zbTMzgxCYzCMxDqhkxjbSQzh+G9VTsNy6s6AQvPIfGs=;
 b=Sl5O7dOWG5gC2H0zfNgPBldS1zzIsDWD2zAH9VXm5ntmOnf+kRmCJ2u0L7utzenzmD
 ECKWmNN0x+GhaH7qzndvLk7flIpq3ZVWfphDr+33qbjzCQXcIoX1z5JCyCgYfjqhg7cJ
 +K46Z5SHFATvDbt3mA1K2JjEtDChKuevTEz1Fhdk/mUDrlCVJSlQHsqSP4Mpx77jcTnR
 r4/tsWbvf359pUHJaDrZP56xqE2jl3GaZJAbw6CiYO0hB7M/rxRhHF2GfuncD4UEGr5R
 xuVNAaGiOs27LojSfBvPhPNDfolLlmCby9lzjAidWOA3Se9vmxAMq+4l03lJBDnZK2L3
 A+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772082639; x=1772687439;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zbTMzgxCYzCMxDqhkxjbSQzh+G9VTsNy6s6AQvPIfGs=;
 b=bfcCa8D03oaqpQLgTsTCML6KtpMlmuNZq8uck4fx182PQTyT6znCTxdTEg3n/FmFBN
 3RwVzfKF9nlGPMfd0KgfxMh4z6zgmHtmxXZhpyxYKnj/ggXufqI9jjvB2GoVqEvKnbNQ
 o9emzFIZQegg2pBaEqARDnTgJ8Sbo+c0zJxvwZ6xi7X6va4IqLJtVDPKIJEXGoDv74DO
 I+s8+GusZ6WU1AqZWS6k2Y0IHKhAnV6cezXQUa1BlB6ZzyAlRw9HW4ch6KBF+Do32MrO
 hmlO1XLhHqtOW2pAlAKxpINiLtT21k5ckKmnAIm+9chyyoxCH8/Kna4px8QZMilX16dT
 7aaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVznAvJsi5shi4/Qe3X98LQevWHVZzujaPldYiz8BHuB1d0xO5biSkUrHjEFNRA3dqVXWFFqro=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2T8er7I8lHdbM/GChEX4VkMi/r0njU26H+RitecOVMsvIazU6
 z1qRUdl6zsV6NIZYmm9+7pl/dq2yTpYjgr4oAxlwtA6e2YQJEjaWKKDM
X-Gm-Gg: ATEYQzyaIDKi5fqAdlhxHiz7n5r9wDfNuC3Iie9IniQQWJhDAgV1IjTsgqOd6WlsTnH
 5e3UVFMAapxUNHXTlmeOn8oc9E6C3D8NVGM3MnwTqBWtxlhZgsqrxQ8N5wHbsXxwNriO0AqYKOk
 st7qSTEwVPKmPK4GJZAPjGfEke6r5CHwVKV/AIS+wGPYZ9cP+nnUcrXmAQOW1krNwwGx2KBCN81
 fC9jCZzNy6JTEVy9NypotbibtR2l+mjeJ+n/QpVCQRx+vdpzwFB/YEdxhPZ0gVWdY2gtrGmAldT
 ePrt7eFgVgrXNMqS3xfqj18Y5AGLSDtPJaz5xKUcHqeL11NwMac4jgsvrIZxGow/Wrd91KBFjzc
 c7YyQ1hnK0+PxE36a5vrgPdmda3hSoUEfib+sGZ/lhh/w7DE2/5i/KXyXkkqCId84j41tyM24/8
 QCN/FQpCKKOggPGOm9h2tZYvqWeC6x4nsYsBa++9AeyMl6Rvawq1nBRZZhY8ZV5uo/8HvDQB9xR
 OOV3w==
X-Received: by 2002:a05:622a:11c3:b0:4ee:1e33:bc45 with SMTP id
 d75a77b69052e-5070bc6891dmr213396851cf.5.1772082639215; 
 Wed, 25 Feb 2026 21:10:39 -0800 (PST)
Received: from ?IPV6:2600:4040:4476:3800:2d8:61ff:fe7c:5d59?
 ([2600:4040:4476:3800:2d8:61ff:fe7c:5d59])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50744ad885bsm10696241cf.28.2026.02.25.21.10.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 21:10:38 -0800 (PST)
Message-ID: <1a128389-fe86-5ba5-1e01-4f2d932908f2@gmail.com>
Date: Thu, 26 Feb 2026 00:10:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] spl: Add generic SPL MTD loader support
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>
Cc: michael@amarulasolutions.com, u-boot@lists.denx.de, trini@konsulko.com,
 dinesh.maniyam@altera.com, a-dutta@ti.com, a-nandan@ti.com, jonas@kwiboo.se,
 Fabio Estevam <festevam@nabladev.com>
References: <20260220031232.1254728-1-festevam@gmail.com>
 <fecf9c20-f5a5-d9f6-ddc0-dc8db483922d@gmail.com>
 <82b70e8b-3adb-5c0e-cf98-d5f501e0bc48@gmail.com>
 <CAOMZO5C9BwWosjdgJFPX8XMsrqo_rQLeTn9PLFi9JRoLw+-yag@mail.gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAOMZO5C9BwWosjdgJFPX8XMsrqo_rQLeTn9PLFi9JRoLw+-yag@mail.gmail.com>
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

T24gMi8yNS8yNiAxOTowOCwgRmFiaW8gRXN0ZXZhbSB3cm90ZToNCj4gSGkgU2VhbiwNCj4g
DQo+IE9uIFdlZCwgRmViIDI1LCAyMDI2IGF0IDQ6NDXigK9QTSBTZWFuIEFuZGVyc29uIDxz
ZWFuZ2EyQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPj4gQWN0dWFsbHksIEkgZG9uJ3QgdGhp
bmsgdGhpcyBpcyBjb3JyZWN0LiBOQU5EIGRldmljZXMgaGF2ZSBoYXZlIG11bHRpcGxlIE1U
RHMgZm9yIGVhY2gNCj4+IENTLCBhbmQgU1BJLU5PUiBkZXZpY2VzIGFyZSBVQ0xBU1NfU1BJ
X0ZMQVNIIGFuZCBub3QgVUNMQVNTX01URC4gU28gSSB0aGluayBpdCdzIGJldHRlcg0KPj4g
dG8gZG8gc29tZXRoaW5nIGxpa2UNCj4+DQo+PiAgICAgICAgICBtdGRfcHJvYmVfZGV2aWNl
cygpOw0KPj4gICAgICAgICAgc3dpdGNoIChib290ZGV2LT5ib290X2RldmljZSkgew0KPj4g
ICAgICAgICAgY2FzZSBCT09UX0RFVklDRV9OQU5EOg0KPj4gICAgICAgICAgICAgICAgICBt
dGQgPSBnZXRfbXRkX2RldmljZV9ubShDT05GSUdfU1BMX01URF9OQU5EX05BTUUpOw0KPj4g
ICAgICAgICAgICAgICAgICBicmVhazsNCj4+ICAgICAgICAgIGNhc2UgQk9PVF9ERVZJQ0Vf
U1BJOg0KPj4gICAgICAgICAgICAgICAgICBtdGQgPSBnZXRfbXRkX2RldmljZV9ubShDT05G
SUdfU1BMX01URF9TUElfRkxBU0hfTkFNRSk7DQo+PiAgICAgICAgICAgICAgICAgIGJyZWFr
Ow0KPj4gICAgICAgICAgZGVmYXVsdDoNCj4+ICAgICAgICAgICAgICAgICAgbXRkID0gRVJS
X1BUUigtRU5PREVWKTsNCj4+ICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+PiAgICAgICAg
ICB9DQo+PiAgICAgICAgICBpZiAoSVNfRVJSKG10ZCkpIHsNCj4+ICAgICAgICAgICAgICAg
ICAgcmV0ID0gUFRSX0VSUihtdGQpOw0KPj4gICAgICAgICAgICAgICAgICBnb3RvIG91dDsN
Cj4+ICAgICAgICAgIH0NCj4gLi4uDQo+IA0KPj4+IEFjdHVhbGx5LCBpZiBDT05GSUdfU1BM
X05BTkRfU1VQUE9SVCBpcyBlbmFibGVkIHRoZW4gdGhlIG5hdGl2ZSBuYW5kIGxvYWRlciBp
cyBjb21waWxlZC4NCj4+PiBNYXliZSB3ZSBzaG91bGQgYWRkIGEgc2VwYXJhdGUgS2NvbmZp
ZyBmb3IgaXQgKENPTkZJR19TUExfTkFORF9MT0FEKSBkZWZhdWx0aW5nIHRvDQo+Pj4gU1BM
X05BTkRfU1VQUE9SVC4gVGhlbiB1c2VycyBjYW4gZGlzYWJsZSB0aGUgIm5hdGl2ZSIgbG9h
ZCBtZXRob2QgaWYgdGhleSB3YW50IHRvIHVzZSBNVEQuDQo+Pg0KPj4gSSBoYXZlIGEgcGF0
Y2ggZm9yIHRoaXMgdGhhdCBJIHdpbGwgdHJ5IHRvIHNlbmQgdGhpcyB3ZWVrLg0KPiANCj4g
SWYgeW91IHdvdWxkIGxpa2UgdG8gcHJlcGFyZSBhIHBhdGNoIGZvciB0aGUgZ2VuZXJpYyBT
UEwgTVREIGxvYWRlciwNCj4gSSdsbCBiZSBnbGFkIHRvIHRlc3QgaXQuDQoNCkkgY2FuIHRy
eSwgYnV0IEkgY2FuJ3QgcHJvbWlzZSBJJ2xsIGJlIGRvbmUgd2l0aCBpdCBpbiBhbnkgcGFy
dGljdWxhciB0aW1lZnJhbWUuDQoNCkJ1dCBUQkggSSBkb24ndCB0aGluayBhIHNwaV9uYW5k
LmMtc3R5bGUgbG9hZGVyIGlzIHRoZSByaWdodCB3YXkgdG8gZG8gdGhpbmdzIHdoZW4gVUJJ
IGV4aXN0cy4NCk1heWJlIERpbmVzaCBjYW4gY29tbWVudCwgYnV0IEkgZG9uJ3QgcmVhbGx5
IHNlZSB0aGUgcG9pbnQgZXhjZXB0IGlmIGUuZy4geW91IGFyZSByZWFsbHkgc2hvcnQNCm9u
IHNwYWNlIGluIFNQTCwgYnV0IG5vdCBzbyBtdWNoIHRoYXQgeW91IGNhbid0IGZpdCBpbiBN
VEQuDQoNCi0tU2Vhbg0K
