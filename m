Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43163C3DA61
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 23:58:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A39288821;
	Fri, 19 Jul 2024 01:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EdESA3Fr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E350088B33; Fri, 19 Jul 2024 01:58:21 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8500885AE
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 01:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-79ef7635818so55640285a.3
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 16:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721347098; x=1721951898; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=atgrj/tjroPp2u0gPRyJZXIygb41a2RQdWbg9dJFht0=;
 b=EdESA3FriqeZKIkWVsXA+jaZgZ9Or+P7Tqr/rVBoYpZJYUDhSjH3Z2HenZSWGjUuR1
 LNCdEDmS//y4focn8ANJOtMPrS7ZK0FRXNleSSFeFDvTauzFkWuZGW6Yer7nm8WKXsYr
 nic4wTcb0Qojk7lAa+YvAhCPRp3Uz61uTkIG2Ek8zWcepXjS00WJSF4ig01Xa/2+QxxG
 LKUEtjoviTQQ9enlk9RhP8XKfRUWfvx9TILVFUZNlaQv2N6UZ9VVyCV1ET9NnENLJab8
 Y5HFVZp+v8b8L3nFZY6XUCTyPOfZrvlfSB5jnSvJvnv5AfUCrVzIKjucT0zMNHqMekLL
 6b6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721347098; x=1721951898;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=atgrj/tjroPp2u0gPRyJZXIygb41a2RQdWbg9dJFht0=;
 b=CfzH77HXkL1ESC3jypLH5O9GMPNBpvuAmluHSF7iis0FO+XOwIur7bNzNi8y3dfvBn
 xdyhsrYNWpO1G+99GGX8UV5HLqRagmvGPKNMyQRzdwDQDhSG4RHuvSUWqP01grbhQFuo
 wflgv0IgwpPzJfTobh91O0USAxjuLFI13++ZrbXqetkcjQB+emHKSTfFXW3heqaaCibr
 IZy4gYZfA/wfavtt2uFFErr8hQKXBVVKbXkpQplBvTqbCjLJTBQs1lpfLFT88VVeuZs0
 au8hG1MIynCJZaUJOkPig6J3FzhdUfbJ4fCyWcA+Ay8PHj6GpHFSUeU9hxJL166Qjgk0
 2cAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMC9FwjZGxkvC2cwioW05NInwz2NJvbW1m2a70VYVdV+NMVuhGUFoKjaSu5SYqlpSDKep102fiLfSti24AttzuMI4VUg==
X-Gm-Message-State: AOJu0YyQm2wYppJA5qM1yqqC/yh9Ppl5s59IVZQTI/Xbj6WnOlskU8er
 EX+jKlqqUa4UQaJ9w7Dkl6JcC7EFZ2ePS8iBYIxznjsWX/oodh4S
X-Google-Smtp-Source: AGHT+IGRJfoXiqil77NeXId7oCBdPAmWYjVy43Qzxm/QU4mPB23WD5cVu62q4yDkd4zRkU0Wn2mubw==
X-Received: by 2002:a05:620a:4145:b0:79f:c81:3051 with SMTP id
 af79cd13be357-7a18744154amr799719585a.2.1721347098552; 
 Thu, 18 Jul 2024 16:58:18 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a198fab076sm13781485a.22.2024.07.18.16.58.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 16:58:18 -0700 (PDT)
Message-ID: <ef802785-90a1-9e14-e1c4-85f73fb1dd01@gmail.com>
Date: Thu, 18 Jul 2024 19:58:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 04/21] sandbox: Enable SPL_LOAD_BLOCK
Content-Language: en-US
From: Sean Anderson <seanga2@gmail.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>
References: <20240713070055.2172883-1-sjg@chromium.org>
 <20240713070055.2172883-5-sjg@chromium.org>
 <26f6d85c-7d22-fb2f-d18b-5adcf494bc34@gmail.com>
In-Reply-To: <26f6d85c-7d22-fb2f-d18b-5adcf494bc34@gmail.com>
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

T24gNy8xOC8yNCAwOToyOCwgU2VhbiBBbmRlcnNvbiB3cm90ZToNCj4gT24gNy8xMy8yNCAw
MzowMCwgU2ltb24gR2xhc3Mgd3JvdGU6DQo+PiBFbmFibGUgdGhpcyBvcHRpb24gZm9yIGFs
bCBzYW5kYm94IGJvYXJkcyBzbyB0aGF0IHRoZSBGSVQtbG9hZGluZyBjb2RlDQo+PiBjYW4g
YmUgdXNlZCB3aXRob3V0IGdlbmVyYXRpbmcgYW4gZXJyb3IgYWJvdXQgYmxvY2sgZGV2aWNl
cyBub3QgYmVpbmcNCj4+IHN1cHBvcnRlZC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBTaW1v
biBHbGFzcyA8c2pnQGNocm9taXVtLm9yZz4NCj4+IC0tLQ0KPj4NCj4+IChubyBjaGFuZ2Vz
IHNpbmNlIHYxKQ0KPj4NCj4+IMKgIGNvbW1vbi9zcGwvS2NvbmZpZyB8IDEgKw0KPj4gwqAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2Nv
bW1vbi9zcGwvS2NvbmZpZyBiL2NvbW1vbi9zcGwvS2NvbmZpZw0KPj4gaW5kZXggYWY0M2I1
ZjVkM2MuLjk3MGE0YTM0NmU0IDEwMDY0NA0KPj4gLS0tIGEvY29tbW9uL3NwbC9LY29uZmln
DQo+PiArKysgYi9jb21tb24vc3BsL0tjb25maWcNCj4+IEBAIC0yODgsNiArMjg4LDcgQEAg
Y29uZmlnIFNQTF9CT0FSRF9JTklUDQo+PiDCoCBjb25maWcgU1BMX0xPQURfQkxPQ0sNCj4+
IMKgwqDCoMKgwqAgYm9vbA0KPj4gK8KgwqDCoCBkZWZhdWx0IHkgaWYgU0FOREJPWA0KPj4g
wqDCoMKgwqDCoCBoZWxwDQo+PiDCoMKgwqDCoMKgwqDCoCBTdXBwb3J0IGxvYWRpbmcgaW1h
Z2VzIGZyb20gYmxvY2sgZGV2aWNlcy4gVGhpcyBhZGRzIGEgYmxfbGVuIG1lbWJlcg0KPj4g
wqDCoMKgwqDCoMKgwqAgdG8gc3RydWN0IHNwbF9sb2FkX2luZm8uDQo+IA0KPiBOQUNLLg0K
PiANCj4gRW5hYmxlIG9uZSBvZiB0aGUgbWFueSBjb25maWdzIHdoaWNoIHNlbGVjdCB0aGlz
IG9uZSBpbnN0ZWFkLg0KPiANCj4gLS1TZWFuDQoNCk9LLCBzbyBJIHRoaW5rIHlvdSB3YW50
ZWQgdG8gYWRkIHRoaXMgYmVjYXVzZSBvZiB0aGUgcHJldmlvdXMgcGF0Y2gvcGF0Y2ggMjAu
DQoNCkkgdGhpbmsgYSBiZXR0ZXIgc29sdXRpb24gd291bGQgYmUgdG8ganVzdCByZWR1Y2Ug
dGhlIGJsX2xlbiB0byAxLCBzaW5jZSB1bml4IEkvTw0KaXMgYnl0ZS1vcmllbnRlZCBhbnl3
YXkgYW5kIHdlIG5vdyBoYXZlIHNldmVyYWwgdGVzdHMgZm9yIGJsX2xlbiAhPSAxLg0KDQot
LVNlYW4NCg==
