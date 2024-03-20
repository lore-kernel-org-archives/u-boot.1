Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94314C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 14:41:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ED128808A;
	Wed, 20 Mar 2024 15:41:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ao2pb27w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39E9988092; Wed, 20 Mar 2024 15:41:57 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D57288085
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 15:41:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-78a16114b69so93286385a.0
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 07:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710945714; x=1711550514; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gFH2ca0Do464X0qVuZgko8vq1PfcCaVa1ktumiS8Kyc=;
 b=ao2pb27wK/ulQ33bKLy87DUf+o7GozgfTlIruhzwXLJJTdwIvsw19xGtZ+CbMnUshJ
 8DEXk4iqUzMzrh79dh0NaL3GqS32WgFVLs6veKaHQWrpvOoINALjTcdv33vAKP6RP5/w
 C4eg7Wb1xMT1bY9OEBPv7WdgAkZS+Suygp7HB+B29QbRI1mAVhckCYbjv6/RjuTP2Og2
 IJw/WUhs8o1EspD2u44vcyKzq0bte5bfUEaa5Vjw9irgGzH40WId1iyUoK/sQZnPb+Xz
 CQodHEKE6qQzWheug/Yxuml3kt0PL88/Uz51gBGecKknGR/Hj10ub3kDNfIGQC0XO0Cf
 aCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710945714; x=1711550514;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gFH2ca0Do464X0qVuZgko8vq1PfcCaVa1ktumiS8Kyc=;
 b=sY5veKMUbqPnf66YBPE8PlekH3KeHsHiYozxRxtlwEnl2Qo04Chy70FrXJPjLuEj4C
 5Pwb0hId7OeSSmbIn6o3qbY5c/78bHNgXzd6PcUDb3AtQ7kiwT4UCiK7IYp/ai+CKNzA
 GGDcoXTxHxkuN2gk4xMQiXBe5s/FOIQ9h/cLZQ4pKnCcAzNfFx0eZCVAAeTsra9a17cJ
 qeK/lFYNt+EN9XyR+BApTQYwuaAyFygnbs6Bms+3yLWhuaqg5Gm2cSeCBh/qUL3Gx1+D
 7QrqGpse2GcV1ofrFZUfrUEduBuf8LDUj4NW+axSzjKwURhhP7P1tvrqRWNzoeq/Wj+k
 F63A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJrec702vp+apuxwZ9dv1zocZ4n2pZAORNQpoGO8mAhOnLziHXLj1OTMqX7YX/s9cpnUnd0+zLOdL7ojJPWJ7lBhvmyw==
X-Gm-Message-State: AOJu0YwjfLpRcdtExRYSOS8VWrjWz/tKGew+IzZgue2egJOdWcB+hko7
 iMFu1G/99UchsaULYMv+SEowY6RhYveOrMMhx8D/Su5+lNz+EmnyhPqV1B4O
X-Google-Smtp-Source: AGHT+IHwZqSv7XhX9P75zBCgKMZeVPpimEX0Khnw8NfZurL1MqVhX/vBRwwoBcxor830ptI1yZRJwA==
X-Received: by 2002:ae9:f40b:0:b0:789:c760:176e with SMTP id
 y11-20020ae9f40b000000b00789c760176emr4040316qkl.20.1710945714005; 
 Wed, 20 Mar 2024 07:41:54 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 n21-20020a05620a223500b00789ed8823f5sm4274289qkh.0.2024.03.20.07.41.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 07:41:53 -0700 (PDT)
Message-ID: <569b832f-8fcc-9515-40ae-5590b1456f02@gmail.com>
Date: Wed, 20 Mar 2024 10:41:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] clk: clk-imx8qxp: Add LPUART IPG entries
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>
Cc: peng.fan@nxp.com, ye.li@nxp.com, u-boot@lists.denx.de,
 marcel.ziswiler@toradex.com, francesco.dolcini@toradex.com,
 hiago.franco@toradex.com, joao.goncalves@toradex.com
References: <20240308201316.1721909-1-festevam@gmail.com>
 <CAOMZO5Aa_EaTtL9r7k0P7CaJQ0fixGLJSR3WvxHAD2=5RJdncQ@mail.gmail.com>
 <20240319190450.GI3442575@bill-the-cat>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240319190450.GI3442575@bill-the-cat>
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

T24gMy8xOS8yNCAxNTowNCwgVG9tIFJpbmkgd3JvdGU6DQo+IE9uIE1vbiwgTWFyIDE4LCAy
MDI0IGF0IDA5OjE0OjUzUE0gLTAzMDAsIEZhYmlvIEVzdGV2YW0gd3JvdGU6DQo+PiBIaSBU
b20gYW5kIFNlYW4sDQo+Pg0KPj4gT24gRnJpLCBNYXIgOCwgMjAyNCBhdCA1OjEz4oCvUE0g
RmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPiB3cm90ZToNCj4+Pg0KPj4+IFNp
bmNlIGNvbW1pdCBjYzdkZjBiOWU4YmMgKCJzZXJpYWw6IGxwdWFydDogRW5hYmxlIElQRyBj
bG9jayIpDQo+Pj4gdGhlIGNvbGlicmktaW14OHF4cCBib2FyZCBubyBsb25nZXIgYm9vdHMu
DQo+Pj4NCj4+PiBUaGUgcmVhc29uIGlzIHRoYXQgdGhlIGlteDhxeHAgY2xvY2sgZHJpdmVy
IGRvZXMgbm90IGhhbmRsZSB0aGUNCj4+PiBMUFVBUlQgSVBHIGNsb2NrcyBpbnNpZGUgZ2V0
X3JhdGUoKSwgc2V0X3JhdGUoKSBhbmQgZW5hYmxlKCkgZnVuY3Rpb25zLg0KPj4+DQo+Pj4g
Rml4IHRoZSBib290IHJlZ3Jlc3Npb24gYnkgYWRkaW5nIHRoZSBMUFVBUlQgSVBHIGVudHJp
ZXMuDQo+Pj4NCj4+PiBGaXhlczogY2M3ZGYwYjllOGJjICgic2VyaWFsOiBscHVhcnQ6IEVu
YWJsZSBJUEcgY2xvY2siKQ0KPj4+IFJlcG9ydGVkLWJ5OiBNYXJjZWwgWmlzd2lsZXIgPG1h
cmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBGYWJpbyBF
c3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+DQo+Pg0KPj4gUGxlYXNlIGNvbnNpZGVyIGFw
cGx5aW5nIHRoaXMgc2VyaWVzIHRvIDIwMjQuMDQuDQo+Pg0KPj4gSXQgZml4ZXMgYSBib290
IHJlZ3Jlc3Npb24gb24gaW14OHF4cCBhbmQgaW14OHFtLg0KPiANCj4gRmluZSB3aXRoIG1l
LCBTZWFuPw0KPiANCg0KQWNrZWQtYnk6IFNlYW4gQW5kZXJzb24gPHNlYW5nYTJAZ21haWwu
Y29tPg0KDQpDYW4geW91IHBpY2sgdGhpcyB1cCBkaXJlY3RseSwgVG9tPyBUaGFua3MuDQo=

