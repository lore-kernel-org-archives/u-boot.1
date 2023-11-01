Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81D4C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 18:01:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FCAD876DC;
	Wed,  1 Nov 2023 19:01:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RVCA4OtD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95C69876E1; Wed,  1 Nov 2023 19:01:29 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43EC187D50
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 19:01:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6707401e1edso712696d6.1
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 11:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698861684; x=1699466484; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q5dUIYTCoqhvszOpX/H3gdG3DbLUkU7kQfYzrfjNY84=;
 b=RVCA4OtDc2pROkiOhzuhSZlI+uTKeWzxAlLIzwjyYf1YWM8UtGaM59Njd7d9yrlOzV
 Mxk2l2aYviQ6qML38tBE8wiTAzKMay1lZDuslp75Qy438Wv3gWf5p08eWyUhT+JWmcOQ
 5lG/HCpXB00WkLkP8lqH6mYMwpQwU8vVslshE7QE2OGGyGb6stqAgzJZ+S0beZ8tY9bP
 A7xs+xYkMwMQOQIjE1pl7uC89Sv45+CxvUDpZlGMSj2oLb3ZpCT0cz1wTZ+5Iv3q2EFP
 0trbyAVX3n7XX52dxUgGyC5WK+1YqAG0UgR5UeHMYf5+H+/tZX5GkKEPCCjJkWcFCs3L
 oV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698861684; x=1699466484;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q5dUIYTCoqhvszOpX/H3gdG3DbLUkU7kQfYzrfjNY84=;
 b=RKJPq1PI/YhRGUw7p13l9CCzeJYP3HhmzAuGk6vQXGAOpb01q3K7eO1NvG7e4+9I0h
 QV5z5X3uT9L3r49Te6dFQsmPT5wwwQt8m4XxNIKf94DyUNug+t7K2JLLpwgCYkoq2hb1
 b2wBPmXrvUCS30pKWmDcblahb6nOfLzKsACQJ7rLKfw1sh856kTfA4l8QkFi3ztTMVml
 r6gkhIqZJ9En98So2pF7o4tzbURn5BmGxCMwRRULU10oDgnlbaYWzM2J8pI4UlKr4iAL
 Weq5Y4cbJ8O2hOCXIAvm4jOHv+zrMlsAInxPaFJnm69CSMDAgFUEDlzk8KfUPiarbzuO
 taag==
X-Gm-Message-State: AOJu0YwHPPSe/PNo8+NkCk5gCFv6iB4Pj4fSg7sz1cH1wCMWu67doVE7
 cqCC5DmIhSfUWjrT+bfPm5c=
X-Google-Smtp-Source: AGHT+IE30oO38NjZrLDOS9erTLudfLVYQw4Z2izSMeBi+hN2ndCN5hwQERIjv951k4GeiIp1x/6cSw==
X-Received: by 2002:a05:6214:2582:b0:670:f264:1552 with SMTP id
 fq2-20020a056214258200b00670f2641552mr13220301qvb.22.1698861683982; 
 Wed, 01 Nov 2023 11:01:23 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 ez2-20020ad45902000000b0066cf06339bcsm1691490qvb.0.2023.11.01.11.01.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 11:01:23 -0700 (PDT)
Message-ID: <7d218787-b802-9ea7-9132-ae1e817b6997@gmail.com>
Date: Wed, 1 Nov 2023 14:01:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RESEND 2/5] clk: call log_debug() instead to avoid console
 log printing
Content-Language: en-US
From: Sean Anderson <seanga2@gmail.com>
To: forbidden405@outlook.com, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de
References: <20230818-clk-fix-v1-0-49ec18f820bf@outlook.com>
 <20230818-clk-fix-v1-2-49ec18f820bf@outlook.com>
 <02b22344-bdab-ea52-cad7-637a94aa852f@gmail.com>
In-Reply-To: <02b22344-bdab-ea52-cad7-637a94aa852f@gmail.com>
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

T24gMTEvMS8yMyAxMzo1NSwgU2VhbiBBbmRlcnNvbiB3cm90ZToNCj4gT24gOC8xNy8yMyAx
MzowNCwgWWFuZyBYaXdlbiB2aWEgQjQgUmVsYXkgd3JvdGU6DQo+PiBGcm9tOiBZYW5nIFhp
d2VuIDxmb3JiaWRkZW40MDVAb3V0bG9vay5jb20+DQo+Pg0KPj4gaXQncyBhIHZlcnkgY29t
bW9uIGNhc2UgdG8gcmVnaXN0ZXIgYSBjbG9jayB3aXRob3V0IGEgcGFyZW50LCBzdWNoIGFz
DQo+PiBjbGtfcmVnaXN0ZXJfZml4ZWRfcmF0ZSgpLg0KPiANCj4gQWN0dWFsbHksIHRoYXQg
c2VlbXMgbGlrZSB0aGUgb25seSBwbGFjZSB0aGlzIGlzIGRvbmUuDQo+IA0KPj4gUmVwbGFj
ZSBsb2dfZXJyb3IoKSB3aXRoIGxvZ19kZWJ1ZygpIHRvIGF2b2lkDQo+PiB1c2VsZXNzIGNv
bnNvbGUgbG9nIGlmIG5vdCBkZWJ1Z2dpbmcuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWWFu
ZyBYaXdlbiA8Zm9yYmlkZGVuNDA1QG91dGxvb2suY29tPg0KPj4gLS0tDQo+PiDCoCBkcml2
ZXJzL2Nsay9jbGsuYyB8IDQgKystLQ0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9j
bGsvY2xrLmMgYi9kcml2ZXJzL2Nsay9jbGsuYw0KPj4gaW5kZXggYTVhMzQ2MWI2Ni4uYTM4
ZGFhYWMwYyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvY2xrL2Nsay5jDQo+PiArKysgYi9k
cml2ZXJzL2Nsay9jbGsuYw0KPj4gQEAgLTI0LDggKzI0LDggQEAgaW50IGNsa19yZWdpc3Rl
cihzdHJ1Y3QgY2xrICpjbGssIGNvbnN0IGNoYXIgKmRydl9uYW1lLA0KPj4gwqDCoMKgwqDC
oCByZXQgPSB1Y2xhc3NfZ2V0X2RldmljZV9ieV9uYW1lKFVDTEFTU19DTEssIHBhcmVudF9u
YW1lLCAmcGFyZW50KTsNCj4+IMKgwqDCoMKgwqAgaWYgKHJldCkgew0KPj4gLcKgwqDCoMKg
wqDCoMKgIGxvZ19lcnIoIiVzOiBmYWlsZWQgdG8gZ2V0ICVzIGRldmljZSAocGFyZW50IG9m
ICVzKVxuIiwNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fZnVuY19fLCBwYXJlbnRf
bmFtZSwgbmFtZSk7DQo+PiArwqDCoMKgwqDCoMKgwqAgbG9nX2RlYnVnKCIlczogZmFpbGVk
IHRvIGdldCAlcyBkZXZpY2UgKHBhcmVudCBvZiAlcylcbiIsDQo+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgX19mdW5jX18sIHBhcmVudF9uYW1lLCBuYW1lKTsNCj4+IMKgwqDC
oMKgwqAgfSBlbHNlIHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBsb2dfZGVidWcoIiVzOiBu
YW1lOiAlcyBwYXJlbnQ6ICVzIFsweCVwXVxuIiwgX19mdW5jX18sIG5hbWUsDQo+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGFyZW50LT5uYW1lLCBwYXJlbnQpOw0KPj4N
Cj4gDQo+IEkgdGhpbmsgYSBjb3JyZWN0IGZpeCB3b3VsZCBiZQ0KPiANCj4gZGlmZiAtLWdp
dCBpL2RyaXZlcnMvY2xrL2Nsay5jIHcvZHJpdmVycy9jbGsvY2xrLmMNCj4gaW5kZXggYTVh
MzQ2MWI2NmMuLmNiMzMzYzgzZjY2IDEwMDY0NA0KPiAtLS0gaS9kcml2ZXJzL2Nsay9jbGsu
Yw0KPiArKysgdy9kcml2ZXJzL2Nsay9jbGsuYw0KPiBAQCAtMTgsMTcgKzE4LDE5IEBADQo+
ICDCoGludCBjbGtfcmVnaXN0ZXIoc3RydWN0IGNsayAqY2xrLCBjb25zdCBjaGFyICpkcnZf
bmFtZSwNCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0IGNoYXIg
Km5hbWUsIGNvbnN0IGNoYXIgKnBhcmVudF9uYW1lKQ0KPiAgwqB7DQo+IC3CoMKgwqDCoMKg
wqAgc3RydWN0IHVkZXZpY2UgKnBhcmVudDsNCj4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3QgdWRl
dmljZSAqcGFyZW50ID0gTlVMTDsNCj4gIMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBkcml2ZXIg
KmRydjsNCj4gIMKgwqDCoMKgwqDCoMKgIGludCByZXQ7DQo+IA0KPiAtwqDCoMKgwqDCoMKg
IHJldCA9IHVjbGFzc19nZXRfZGV2aWNlX2J5X25hbWUoVUNMQVNTX0NMSywgcGFyZW50X25h
bWUsICZwYXJlbnQpOw0KPiAtwqDCoMKgwqDCoMKgIGlmIChyZXQpIHsNCj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgbG9nX2VycigiJXM6IGZhaWxlZCB0byBnZXQgJXMgZGV2
aWNlIChwYXJlbnQgb2YgJXMpXG4iLA0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgX19mdW5jX18sIHBhcmVudF9uYW1lLCBuYW1lKTsNCj4gLcKg
wqDCoMKgwqDCoCB9IGVsc2Ugew0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBs
b2dfZGVidWcoIiVzOiBuYW1lOiAlcyBwYXJlbnQ6ICVzIFsweCVwXVxuIiwgX19mdW5jX18s
IG5hbWUsDQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcGFyZW50LT5uYW1lLCBwYXJlbnQpOw0KPiArwqDCoMKgwqDCoMKgIGlmIChwYXJl
bnRfbmFtZSkgew0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSB1Y2xh
c3NfZ2V0X2RldmljZV9ieV9uYW1lKFVDTEFTU19DTEssIHBhcmVudF9uYW1lLA0KPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJnBhcmVudCk7DQo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChyZXQpDQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsb2dfZXJyKCIlczogZmFpbGVkIHRvIGdl
dCAlcyBkZXZpY2UgKHBhcmVudCBvZiAlcylcbiIsDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19mdW5jX18sIHBh
cmVudF9uYW1lLCBuYW1lKTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZWxz
ZQ0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbG9n
X2RlYnVnKCIlczogbmFtZTogJXMgcGFyZW50OiAlcyBbMHglcF1cbiIsIF9fZnVuY19fLA0K
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBuYW1lLCBwYXJlbnQtPm5hbWUsIHBhcmVudCk7DQo+ICDCoMKgwqDC
oMKgwqDCoCB9DQo+IA0KPiAgwqDCoMKgwqDCoMKgwqAgZHJ2ID0gbGlzdHNfZHJpdmVyX2xv
b2t1cF9uYW1lKGRydl9uYW1lKTsNCj4gDQo+IC0tU2Vhbg0KDQpvciB5b3UgY291bGQgbW9k
aWZ5IHRoZSBjb25kaXRpb24gdG8gYmUgYGlmIChyZXQgJiYgcGFyZW50X25hbWUpYCB3aXRo
IGFwcHJvcHJpYXRlDQptb2RpZmljYXRpb24gb2YgdGhlIHNlY29uZCBkZWJ1ZyBtZXNzYWdl
Lg0KDQotLVNlYW4NCg==
