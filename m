Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4BCC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 18:32:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8418A8714F;
	Wed,  1 Nov 2023 19:32:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aEorPL5W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EFC387D3E; Wed,  1 Nov 2023 19:32:10 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F269870FF
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 19:32:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7788db95652so2030385a.2
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 11:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698863527; x=1699468327; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VTehGfHPaOXvZmV5aL+CwV91i4pPqoWpcnGezzYLDzA=;
 b=aEorPL5WJkQmyywIg3ll15wGMMsyHdS0YYBOJKrqk/4uo0lHcB5QDijjR9H3agiRqr
 gH17VccHLKgslYFT/VKOjuOnAA7pO/Ejt3idC756CowL+5ZtlFjN40uU6l4yMYNeaDQK
 tSJHmn2ni1wtgYx8BF4LMZg6jPi0Pi2S7fnw6RZkPKbekffKeXD+8X+cSCFk21wYJWwA
 JPYITNUI3boWEdhWHo+4phyPXTXNTIRJC5skwuX4QNPBPaURtSEfPmLvEUkRg1lhARJ5
 H8HNZC0jDpn7dtKeplNVq2/ediAg9CmHng0jLe/HrU9E3vNl/MyPV5eacV4ItPyEB3zt
 uhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698863527; x=1699468327;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VTehGfHPaOXvZmV5aL+CwV91i4pPqoWpcnGezzYLDzA=;
 b=E9btRHGshaO8t71UrA3B+xasmt3G7tUssTRZeVzk91sCvcKxzBoSNzszfx7Bdy6DCm
 6ODGTHI2Ky/Q3zB8j3273U3xDb9tZWEqp2ivQfl5J+FXK60mYNRR5Aj+FSTCxAApFEBQ
 PjF3oUq4ZZxz2N54d14KHVsv6UuMJgJexPGp026jdCmOFs72iYBNUtyedqJjqLRHN248
 XX/xURTHwub81Z5vZ0hkfxxxLrubIJZ2tEElFAUdWR3l61aSQveSAx3OwzaJk8lyEk2M
 9vCj09SdRiCA9xddukw8V818oHG0yuQOsMxAjGEVDNBMNt2JYqvpHUgAl8kMQiEPQyag
 7Crg==
X-Gm-Message-State: AOJu0YycfxMJmeMQg/GZJsfOnkAIEoDXOX2wSKdre8RJ78FqdjKhZDRY
 bbz8orQ3Sr3ghZmFdrpY1lXNoloLIqArYA==
X-Google-Smtp-Source: AGHT+IFD6zUKln+sFkmO8gp2rgsnaL4IY8+TcRFRu8nd35R8LwaJ61Hu2h62l3LqN95BPQ+BoYsOug==
X-Received: by 2002:a05:620a:2912:b0:779:cf04:3c47 with SMTP id
 m18-20020a05620a291200b00779cf043c47mr18714022qkp.24.1698863527137; 
 Wed, 01 Nov 2023 11:32:07 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 e25-20020a05620a12d900b007678973eaa1sm1656330qkl.127.2023.11.01.11.32.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 11:32:06 -0700 (PDT)
Message-ID: <142fae2e-7d24-581f-4974-b98237e54681@gmail.com>
Date: Wed, 1 Nov 2023 14:32:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: cli: Add explicit kconfig dependency for CONFIG_IS_ENABLED macro
Content-Language: en-US
To: Pavel Korotkevich <pawday@mail.ru>, u-boot@lists.denx.de
References: <24370129-51c8-5a0f-4c3a-3c3a86e65968@mail.ru>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <24370129-51c8-5a0f-4c3a-3c3a86e65968@mail.ru>
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

T24gOC81LzIzIDE5OjMyLCBQYXZlbCBLb3JvdGtldmljaCB3cm90ZToNCj4gIEZyb20gZmUy
Y2ViN2M0MzY1MTEyMDU1ZWNmYzNiYmY2OGFkNDczMzBiNzQ0ZCBNb24gU2VwIDE3IDAwOjAw
OjAwIDIwMDENCj4gRnJvbTogUGF2ZWwgS29yb3RrZXZpY2ggPHBhd2RheUBtYWlsLnJ1Pg0K
PiBEYXRlOiBTdW4sIDYgQXVnIDIwMjMgMDI6MDA6NDEgKzAzMDANCj4gU3ViamVjdDogW1BB
VENIXSBjbGk6IEFkZCBleHBsaWNpdCBrY29uZmlnIGRlcGVuZGVuY3kgZm9yIENPTkZJR19J
U19FTkFCTEVEIG1hY3JvDQoNClBsZWFzZSBhZGQgYSBzdWl0YWJsZSBjb21taXQgbWVzc2Fn
ZSBhbmQgdXNlIGBnaXQgc2VuZC1lbWFpbGAgKG9yIHNpbWlsYXIpIHRvIHNlbmQgeW91ciBw
YXRjaGVzLg0KDQotLVNlYW4NCg0KPiAtLS0NCj4gIMKgaW5jbHVkZS9jbGkuaCB8IDIgKysN
Cj4gIMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvY2xpLmggYi9pbmNsdWRlL2NsaS5oDQo+IGluZGV4IDA5NGE2NjAyZDcu
LmQ2ZGJiZGUwNzAgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvY2xpLmgNCj4gKysrIGIvaW5j
bHVkZS9jbGkuaA0KPiBAQCAtOSw2ICs5LDggQEANCj4gDQo+ICDCoCNpbmNsdWRlIDxzdGRi
b29sLmg+DQo+IA0KPiArI2luY2x1ZGUgPGxpbnV4L2tjb25maWcuaD4NCj4gKw0KPiAgwqAv
KioNCj4gIMKgICogc3RydWN0IGNsaV9jaF9zdGF0ZSAtIHN0YXRlIGluZm9ybWF0aW9uIGZv
ciByZWFkaW5nIGNtZGxpbmUgY2hhcmFjdGVycw0KPiAgwqAgKg0KDQo=
