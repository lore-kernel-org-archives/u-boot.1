Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE90C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 18:42:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1913D87D8D;
	Wed,  1 Nov 2023 19:42:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L/PkZkAP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 769F487D8F; Wed,  1 Nov 2023 19:42:17 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88B5187D8C
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 19:42:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7788ebea620so2371085a.3
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 11:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698864126; x=1699468926; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sfi+VaZwjyhmmoSfe1Q6+EUrJy7DEr+vYbsiNkspcWw=;
 b=L/PkZkAP8HFxgx+MnBP6v0p7fC3wqgUY4dOlivgnecnC3rDH+5FLO++p53Ra+qLPrp
 MYCRJGGoE0zmhxwwJ9aaN6vs1Soze+EeV03jVHKmsLpmufb3QJrsLGBo/xoNtuujnBbW
 tRhX5P0UceMs/Mc7kyn2uMFIKVzPu9Ql0hs16v2tdMKXRioE2tcoyh9SeP3ddbfWzwzw
 1DuzP+B+STUjLM4OWr0uRSy5fWCp3gca7ZbOyKB3ex54gqYrj6jg1ZyjqJREjqHrcVZO
 kWNkkGS8qamzHFU03mTRlc2XPx0o/shT3BMjMnNjCUrX5Hmgs7tep3hdvTXMNfxqaYSw
 bhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698864126; x=1699468926;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sfi+VaZwjyhmmoSfe1Q6+EUrJy7DEr+vYbsiNkspcWw=;
 b=uO8kdQU2UWLpm3RUGiB6K5xyKuzOJQtXPjDEcDuvtyqQJZBgPsVjBHSe5/SRcW2DW1
 HfxM/g4+SPGtJW0DMI+5Z9Mua3I/hVqpEYlG8VjFHc6mkIl2Cj2//TX2Waagtgv1NWmw
 QmP3q4qBvlcQt4nIQKx67X+E0HbDOleVIpTjKDBhrMw+4jWmd5U5NmX2h0vCA1rP3Gkc
 9B54FHWbJZ/kbKVn2v2FVYLOlOtGd9hXqi2M3PsE9gC8P+ER/BWlk6cwarg/Kwqw/D1O
 b/zMaCKED8rmhw3PLLqhK62bUts2GqXCa78cBMas+Mpz9yxP7+gNhvH/j3yd7N+n8Ysz
 qf5w==
X-Gm-Message-State: AOJu0YwdsJzS7xhzOeF5FTujIY5CDJwubrLwomc7gc8rSiFixj67zewJ
 yKCc9Og92I9pbAHHjdk5Ir8=
X-Google-Smtp-Source: AGHT+IFdUl7m7ugfgcJNxl5afnB0zJopiOoJAYKW1PIiLX1Hnl10zkjMEKz8WDvyEANnTvtI1VLfmg==
X-Received: by 2002:a05:620a:4048:b0:771:31c:adcb with SMTP id
 i8-20020a05620a404800b00771031cadcbmr20186232qko.7.1698864126179; 
 Wed, 01 Nov 2023 11:42:06 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 bj42-20020a05620a192a00b00767da9b6ae9sm1670343qkb.11.2023.11.01.11.42.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 11:42:05 -0700 (PDT)
Message-ID: <e5141f84-7a00-a159-3c2b-d8c4ea6ecbc5@gmail.com>
Date: Wed, 1 Nov 2023 14:42:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RESEND 1/5] clk: export clk_register_mux_table()
Content-Language: en-US
To: Yang Xiwen <forbidden405@outlook.com>, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de
References: <20230818-clk-fix-v1-0-49ec18f820bf@outlook.com>
 <20230818-clk-fix-v1-1-49ec18f820bf@outlook.com>
 <36a30ab5-652c-80d4-5e33-c0be3cde113b@gmail.com>
 <KL1PR06MB6964F8FB84EA5744C01BD48096A7A@KL1PR06MB6964.apcprd06.prod.outlook.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <KL1PR06MB6964F8FB84EA5744C01BD48096A7A@KL1PR06MB6964.apcprd06.prod.outlook.com>
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

T24gMTEvMS8yMyAxNDozNywgWWFuZyBYaXdlbiB3cm90ZToNCj4gT24gMTEvMi8yMDIzIDE6
NTAgQU0sIFNlYW4gQW5kZXJzb24gd3JvdGU6DQo+PiBPbiA4LzE3LzIzIDEzOjA0LCBZYW5n
IFhpd2VuIHZpYSBCNCBSZWxheSB3cm90ZToNCj4+PiBGcm9tOiBZYW5nIFhpd2VuIDxmb3Ji
aWRkZW40MDVAb3V0bG9vay5jb20+DQo+Pj4NCj4+PiBJdCdzIGFscmVhZHkgaW1wbGVtZW50
ZWQgaW4gY2xrLW11eC5jLCBleHBvcnQgaXQgaW4gdGhlIGhlYWRlciBmaWxlLg0KPj4+DQo+
Pj4gU2lnbmVkLW9mZi1ieTogWWFuZyBYaXdlbiA8Zm9yYmlkZGVuNDA1QG91dGxvb2suY29t
Pg0KPj4+IC0tLQ0KPj4+ICDCoCBpbmNsdWRlL2xpbnV4L2Nsay1wcm92aWRlci5oIHwgNiAr
KysrKysNCj4+PiAgwqAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPj4+DQo+
Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvY2xrLXByb3ZpZGVyLmggYi9pbmNsdWRl
L2xpbnV4L2Nsay1wcm92aWRlci5oDQo+Pj4gaW5kZXggYjhhY2FjZDQ5ZS4uODAxNDA0NDgw
YiAxMDA2NDQNCj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2Nsay1wcm92aWRlci5oDQo+Pj4g
KysrIGIvaW5jbHVkZS9saW51eC9jbGstcHJvdmlkZXIuaA0KPj4+IEBAIC0yNDcsNiArMjQ3
LDEyIEBAIHN0cnVjdCBjbGsgKmNsa19yZWdpc3Rlcl9tdXgoc3RydWN0IGRldmljZSAqZGV2
LA0KPj4+IGNvbnN0IGNoYXIgKm5hbWUsDQo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCB2b2lk
IF9faW9tZW0gKnJlZywgdTggc2hpZnQsIHU4IHdpZHRoLA0KPj4+ICDCoMKgwqDCoMKgwqDC
oMKgwqAgdTggY2xrX211eF9mbGFncyk7DQo+Pj4gIMKgICtzdHJ1Y3QgY2xrICpjbGtfcmVn
aXN0ZXJfbXV4X3RhYmxlKHN0cnVjdCBkZXZpY2UgKmRldiwgY29uc3QgY2hhcg0KPj4+ICpu
YW1lLA0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3Qg
Y2hhciAqIGNvbnN0ICpwYXJlbnRfbmFtZXMsIHU4IG51bV9wYXJlbnRzLA0KPj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBmbGFncywN
Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZvaWQgX19pb21l
bSAqcmVnLCB1OCBzaGlmdCwgdTMyIG1hc2ssDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB1OCBjbGtfbXV4X2ZsYWdzLCB1MzIgKnRhYmxlKTsNCj4+PiAr
DQo+Pj4gIMKgIHN0cnVjdCBjbGsgKmNsa19yZWdpc3Rlcl9maXhlZF9yYXRlKHN0cnVjdCBk
ZXZpY2UgKmRldiwgY29uc3QgY2hhcg0KPj4+ICpuYW1lLA0KPj4+ICDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWxvbmcgcmF0ZSk7DQo+Pj4gICANCj4+
DQo+PiBXaHkgZG8geW91IHdhbnQgdG8gZXhwb3J0IHRoaXM/IE5vbmUgb2YgeW91ciBvdGhl
ciBwYXRjaGVzIHVzZSBpdC4NCj4gSXQgd2lsbCBiZSB1c2VkIGluIEhpU2lsaWNvbiBjbGsg
ZnJhbWV3b3JrIGRyaXZlciB3aGljaCBpIHdpbGwgc2VuZA0KPiBhZnRlciB0aGlzIHNlcmll
cyBpcyBhcHBsaWVkLiBBbmQgdGhpcyBmdW5jdGlvbiBpcyBleHBvcnRlZCBpbiBMaW51eA0K
PiBrZXJuZWwgQ0NGLiBTbyBpIHRoaW5rIGl0J3MgZmluZSB0byBleHBvcnQgaXQgaW4gVS1C
b290IGFzIHdlbGwuDQoNClBsZWFzZSBqdXN0IHNlbmQgaXQgYWxvbmcgd2l0aCB0aGF0IHNl
cmllcyB0aGVuLg0KDQotLVNlYW4NCg0K
