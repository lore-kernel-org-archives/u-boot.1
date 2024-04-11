Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29DACD1284
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 13:14:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9765C8825A;
	Thu, 11 Apr 2024 15:14:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mir0F/t8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F9D988260; Thu, 11 Apr 2024 15:14:24 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0165E87EBA
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 15:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-78d61097b43so349570485a.2
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 06:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712841261; x=1713446061; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4MNqKgNrw33vqUdQHKj3fH6SequsOBEZ/0WudaQljQs=;
 b=mir0F/t8W8qmzu2k+4Y1p5cuqLi5nFeRK6icA0vMrKtlSfeXpe7hW22sbM7Odf2Q9c
 8P5Doj5urK5WAkGsZ8p0GrcylUKL928q7qk4ur3hYWQnd6R/bz5xMTKvM4VYxntmT/J9
 5Jq37MLNdr8jw/Ef3DmOCOBszGbgV0sED7LCZRLcuVkHbaaDZ1sbaEb/8I22xi0E6aWi
 m5Y2ztNHNdQEv3W8+Wd+L32JFQuQy5eHDXWflWR8U+M6skEz/uYRIMexEZCXkYEEjUUw
 WzSBRHtP2ul34/hUdI5iGvkCwTP0H+pwI3uT98719X1mO5lfcWQDWkZgEsCGdJrGp37x
 2v1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712841261; x=1713446061;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4MNqKgNrw33vqUdQHKj3fH6SequsOBEZ/0WudaQljQs=;
 b=A79lKcS5VBX1tbD+OcwaRL+8L/Y0U0LUxPYhlxkRrjVbwBqxzI5ada5unlrLnck0AS
 hivMD+2r2suX8RTT9kj0fhN0XVe2PsM5U3NM1cLTd93wi/JT2vIQNCYFfk42J7/2ulTU
 soqi3rrdGLdK9QO98/p/+S76ngEKS/xIa1P2Bxmq1TnTyqj0I4s49hG2E40wVOFPkXpY
 uTI7RKWzjXHI8NRXkvfzQ4RcWT6qvt3RgI2Aoos5TU0ZEbBeCyQgrZsaLQ9rHAkjaoW3
 QEjrWGaYIfR+GXsKhtm1FyLHMdXxHQSARNiqx+9vV5Vtt4U0UGqlN8c1k/wnLP6FMzxG
 J4YA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMKhJylPUazVLB6UeGvXYxYC+Uelv3NwXGn+ULCPXvSTiJHDlGsYpyoGYG9O+1iHOSf+u2G7Fh5tUOCsMTauKFq81p8w==
X-Gm-Message-State: AOJu0Yw8FlDAn3YzHiHZgszfBT3EKLuBXpkztnedAAkNjX4yU9t7raDa
 jxMuVavtB3XY4fFItXWAlmMwvm8jinDXM64KdotIXChFrnq5OJkH
X-Google-Smtp-Source: AGHT+IGJMkzmOqvl760/TmcYU7calZ4m7mbEZ4CQ7TpibDwMCxmia4xI++vuiugk4gyqAy21LGr+ug==
X-Received: by 2002:a05:620a:171e:b0:78e:c0de:5783 with SMTP id
 az30-20020a05620a171e00b0078ec0de5783mr2273154qkb.13.1712841260760; 
 Thu, 11 Apr 2024 06:14:20 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 a19-20020a05620a439300b0078d6ef5fd07sm987056qkp.50.2024.04.11.06.14.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 06:14:20 -0700 (PDT)
Message-ID: <dd694ee3-963c-98b6-1ab5-c94f6e6c28ab@gmail.com>
Date: Thu, 11 Apr 2024 09:14:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] clk: sifive: append missing \n to messages
Content-Language: en-US
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Anup Patel <Anup.Patel@wdc.com>, u-boot@lists.denx.de,
 Lukasz Majewski <lukma@denx.de>, Paul Walmsley <paul.walmsley@sifive.com>
References: <20240216163535.275085-1-heinrich.schuchardt@canonical.com>
 <d98c06e7-ba9f-f09b-2f59-f678de6d4b93@gmail.com>
 <2ee61041-2fe6-4b3a-96af-f657242ce9a3@canonical.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <2ee61041-2fe6-4b3a-96af-f657242ce9a3@canonical.com>
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

T24gNC8xMS8yNCAwNDozNywgSGVpbnJpY2ggU2NodWNoYXJkdCB3cm90ZToNCj4gT24gMTEu
MDQuMjQgMDU6MTMsIFNlYW4gQW5kZXJzb24gd3JvdGU6DQo+PiBPbiAyLzE2LzI0IDExOjM1
LCBIZWlucmljaCBTY2h1Y2hhcmR0IHdyb3RlOg0KPj4+IElmIG11bHRpcGxlIG1lc3NhZ2Vz
IGFyZSB3cml0dGVuLCBsaW5lLWZlZWRzIGltcHJvdmUgdGhlIHJlYWRhYmlsaXR5Lg0KPj4+
DQo+Pj4gRml4ZXM6IGM0MGI2ZGY4N2ZjMCAoImNsazogQWRkIFNpRml2ZSBGVTU0MCBQUkNJ
IGNsb2NrIGRyaXZlciIpDQo+Pj4gU2lnbmVkLW9mZi1ieTogSGVpbnJpY2ggU2NodWNoYXJk
dCA8aGVpbnJpY2guc2NodWNoYXJkdEBjYW5vbmljYWwuY29tPg0KPj4+IC0tLQ0KPj4+IMKg
IGRyaXZlcnMvY2xrL2FuYWxvZ2JpdHMvd3JwbGwtY2xuMjhocGMuYyB8IDYgKysrLS0tDQo+
Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkN
Cj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9hbmFsb2diaXRzL3dycGxsLWNs
bjI4aHBjLmMgYi9kcml2ZXJzL2Nsay9hbmFsb2diaXRzL3dycGxsLWNsbjI4aHBjLmMNCj4+
PiBpbmRleCBhM2NiMTA5ZDM1Ny4uNTM3YzY5NmI3MjcgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJp
dmVycy9jbGsvYW5hbG9nYml0cy93cnBsbC1jbG4yOGhwYy5jDQo+Pj4gKysrIGIvZHJpdmVy
cy9jbGsvYW5hbG9nYml0cy93cnBsbC1jbG4yOGhwYy5jDQo+Pj4gQEAgLTgxLDcgKzgxLDcg
QEAgc3RhdGljIGludCBfX3dycGxsX2NhbGNfZmlsdGVyX3JhbmdlKHVuc2lnbmVkIGxvbmcg
cG9zdF9kaXZyX2ZyZXEpDQo+Pj4gwqAgew0KPj4+IMKgwqDCoMKgwqAgaWYgKHBvc3RfZGl2
cl9mcmVxIDwgTUlOX1BPU1RfRElWUl9GUkVRIHx8DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
IHBvc3RfZGl2cl9mcmVxID4gTUFYX1BPU1RfRElWUl9GUkVRKSB7DQo+Pj4gLcKgwqDCoMKg
wqDCoMKgIFdBUk4oMSwgIiVzOiBwb3N0LWRpdmlkZXIgcmVmZXJlbmNlIGZyZXEgb3V0IG9m
IHJhbmdlOiAlbHUiLA0KPj4+ICvCoMKgwqDCoMKgwqDCoCBXQVJOKDEsICIlczogcG9zdC1k
aXZpZGVyIHJlZmVyZW5jZSBmcmVxIG91dCBvZiByYW5nZTogJWx1XG4iLA0KPj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19mdW5jX18sIHBvc3RfZGl2cl9mcmVxKTsNCj4+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FUkFOR0U7DQo+Pj4gwqDCoMKgwqDCoCB9
DQo+Pj4gQEAgLTIyOSw3ICsyMjksNyBAQCBpbnQgd3JwbGxfY29uZmlndXJlX2Zvcl9yYXRl
KHN0cnVjdCB3cnBsbF9jZmcgKmMsIHUzMiB0YXJnZXRfcmF0ZSwNCj4+PiDCoMKgwqDCoMKg
IGludCByYW5nZTsNCj4+PiDCoMKgwqDCoMKgIGlmIChjLT5mbGFncyA9PSAwKSB7DQo+Pj4g
LcKgwqDCoMKgwqDCoMKgIFdBUk4oMSwgIiVzIGNhbGxlZCB3aXRoIHVuaW5pdGlhbGl6ZWQg
UExMIGNvbmZpZyIsIF9fZnVuY19fKTsNCj4+PiArwqDCoMKgwqDCoMKgwqAgV0FSTigxLCAi
JXMgY2FsbGVkIHdpdGggdW5pbml0aWFsaXplZCBQTEwgY29uZmlnXG4iLCBfX2Z1bmNfXyk7
DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOw0KPj4+IMKgwqDCoMKg
wqAgfQ0KPj4+IEBAIC0zMzUsNyArMzM1LDcgQEAgdW5zaWduZWQgbG9uZyB3cnBsbF9jYWxj
X291dHB1dF9yYXRlKGNvbnN0IHN0cnVjdCB3cnBsbF9jZmcgKmMsDQo+Pj4gwqDCoMKgwqDC
oCB1NjQgbjsNCj4+PiDCoMKgwqDCoMKgIGlmIChjLT5mbGFncyAmIFdSUExMX0ZMQUdTX0VY
VF9GRUVEQkFDS19NQVNLKSB7DQo+Pj4gLcKgwqDCoMKgwqDCoMKgIFdBUk4oMSwgImV4dGVy
bmFsIGZlZWRiYWNrIG1vZGUgbm90IHlldCBzdXBwb3J0ZWQiKTsNCj4+PiArwqDCoMKgwqDC
oMKgwqAgV0FSTigxLCAiZXh0ZXJuYWwgZmVlZGJhY2sgbW9kZSBub3QgeWV0IHN1cHBvcnRl
ZFxuIik7DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBVTE9OR19NQVg7DQo+Pj4g
wqDCoMKgwqDCoCB9DQo+Pg0KPj4gUmV2aWV3ZWQtYnk6IFNlYW4gQW5kZXJzb24gPHNlYW5n
YTJAZ21haWwuY29tPg0KPj4NCj4+IEJ1dCBtYXliZSB0aGVzZSBzaG91bGQgYmUgZGV2X2Ri
Zz8NCj4gDQo+IFRoZSBtZXNzYWdlcyBsb29rIGxpa2UgaW5kaWNhdGluZyBtaXNjb25maWd1
cmF0aW9uLiBTbyB0aGUgdXNlciBzaG91bGQgc2VlIHRoZXNlLg0KDQpZZWFoLCBidXQgd2Ug
YWxyZWFkeSByZXR1cm4gYW4gZXJyb3IuIFNvIHRoZSB1c2VyIHdpbGwgbm90aWNlLg0KDQo+
IFRoZSBrZXJuZWwgY29kZSBhbHNvIHVzZXMgV0FSTigpIChhbmQgYWxzbyBsYWNrcyB0aGUg
bGluZS1mZWVkcykuDQoNCkluIHRoZSBrZXJuZWwgdGhlcmUgYXJlIG5vIHNpemUgcmVzdHJp
Y3Rpb25zLCBzbyBpdCBpcyBmaW5lIHRvIGluY2x1ZGUgbWVzc2FnZXMuDQoNCi0tU2Vhbg0K
DQo=
