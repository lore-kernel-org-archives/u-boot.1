Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EDCEDE994
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 02:20:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7122588EC7;
	Tue, 10 Sep 2024 04:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B8DeBPcb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C78F88ED1; Tue, 10 Sep 2024 04:20:28 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E18E88EBC
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 04:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-458361c7d81so2019491cf.3
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 19:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725934825; x=1726539625; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=avWgw9hfjvddBzp3RtkzjDJZfdjU3Vw3vHe8xwbjMOQ=;
 b=B8DeBPcbGpOhpHCaHXj+zcHw4CM7eNnTI79t4qrld3CsA5v1zZ9RQRYCZ1ciQpu+0O
 Nj4x2s1/WiW5ohQXRPPaGol/FDABOIMLOxfmojdwALqfOw7rNPszHtzWknFyWuQDk9Fc
 nth+Q+gdOG9jlnwKIi9J/YfbuIUiB/BUme47q0K8KGYsb9p7mr0BFKr3UnJEvvYdTOvP
 Gp2IE2L9XUWkOmWjXP63yfyqhznvxFib4pGjRXgnNdMDSJcbnH053vp4m8Z97a6Rel1n
 J3qAEXtNuelB8AUnsAeSoslwuOKHMLwcXucbqwHjuWW5DDBXnNa+I/PP35iM3o2Z0O3H
 i2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725934825; x=1726539625;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=avWgw9hfjvddBzp3RtkzjDJZfdjU3Vw3vHe8xwbjMOQ=;
 b=orSXHYkqS4KANPxYnMuL7Tv9WBqWecp/0CvPTRxFc6F9kF8hEXWIvSIPXq522foPJk
 hjl9zIOyUb6rHpoTgplu+o3HLNvTIFdGeqCuf3aFft0GpHCrrZ/NUeM5kErL5D5hUHG1
 zOkfXjxMleQTDLrz1CwCBVfpJce+yXBM7r2/GYb//Mw9B+2xvYd700VzADP3+w0xA9yM
 WI0hFS4wN3KEdg6+ppcXtC0a9bfSgD0HfYaHQi7QNJR99yuqSiv3HphESsikMsIUGq3r
 B4+lUVhl/YgfJdjojR5u66NuR/tJ6ko+4NFyiyf8F2opQiPExxTWYNFxTvR47g+XXxgc
 hhKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpRQzHykHFDnNg52yeEY3PVlEqTLUXpjTxXq5lTodCzFMgaQ6rliwcuhEAb87hmnDuhMJRMps=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+KChcdtygWtRLevZs/NTK5gdz6EWsyqK9yh+W1C5tbQM+kqHw
 avuVUDB4HMNrdYNuaY585mjFaZMtiYAw9kRHQ7ANU1b5rQ2bFvdk
X-Google-Smtp-Source: AGHT+IE7R3nL8xKp7as2tNzSTQGfuzT1kpkxk0CS0BId7CK/VqJiGQmIBWw9Togg3bhnvpM1tLXHPw==
X-Received: by 2002:a05:620a:468d:b0:7a9:b52a:a6f2 with SMTP id
 af79cd13be357-7a9b52aaaa0mr323571485a.8.1725934824980; 
 Mon, 09 Sep 2024 19:20:24 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a9a799238fsm270009385a.64.2024.09.09.19.20.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 19:20:24 -0700 (PDT)
Message-ID: <8022cc2e-bcc0-62f9-b00e-c830987967e7@gmail.com>
Date: Mon, 9 Sep 2024 22:20:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] spl: ram: fix build warning when neither RAM_DEVICE nor
 DFU are enabled
Content-Language: en-US
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20240909132252.3975017-1-jerome.forissier@linaro.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240909132252.3975017-1-jerome.forissier@linaro.org>
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

T24gOS85LzI0IDA5OjIyLCBKZXJvbWUgRm9yaXNzaWVyIHdyb3RlOg0KPiBGaXhlcyB0aGUg
Zm9sbG93aW5nIHdhcm5pbmc6DQo+IA0KPiBjb21tb24vc3BsL3NwbF9yYW0uYzoxOToxNDog
d2FybmluZzog4oCYc3BsX3JhbV9sb2FkX3JlYWTigJkgZGVmaW5lZCBidXQgbm90IHVzZWQg
Wy1XdW51c2VkLWZ1bmN0aW9uXQ0KPiAgICAgMTkgfCBzdGF0aWMgdWxvbmcgc3BsX3JhbV9s
b2FkX3JlYWQoc3RydWN0IHNwbF9sb2FkX2luZm8gKmxvYWQsIHVsb25nIHNlY3RvciwNCj4g
ICAgICAgIHwgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+DQoNCkRvZXMgdGhpcyBj
b25maWcgZXZlbiBtYWtlIHNlbnNlPyBXaGF0IGlzIHRoZSBwb2ludCBvZiBlbmFibGluZyBT
UExfUkFNX1NVUFBPUlQgd2l0aG91dCBvbmUgb2YgdGhlIGFib3ZlIGNvbmZpZ3M/DQoNCk1h
eWJlIHdlIHNob3VsZCBtYWtlIHRob3NlIGNvbmZpZ3Mgc2VsZWN0IFJBTV9TVVBQT1JUIGlu
c3RlYWQuDQoNCj4gU2lnbmVkLW9mZi1ieTogSmVyb21lIEZvcmlzc2llciA8amVyb21lLmZv
cmlzc2llckBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gICBjb21tb24vc3BsL3NwbF9yYW0uYyB8
IDMgKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2NvbW1vbi9zcGwvc3BsX3JhbS5jIGIvY29tbW9uL3NwbC9zcGxfcmFtLmMN
Cj4gaW5kZXggNzFiN2E4Mzc0YmIuLjFhNTg3NGMzOTQ5IDEwMDY0NA0KPiAtLS0gYS9jb21t
b24vc3BsL3NwbF9yYW0uYw0KPiArKysgYi9jb21tb24vc3BsL3NwbF9yYW0uYw0KPiBAQCAt
MTYsNiArMTYsNyBAQA0KPiAgICNpbmNsdWRlIDxzcGwuaD4NCj4gICAjaW5jbHVkZSA8bGlu
dXgvbGliZmR0Lmg+DQo+ICAgDQo+ICsjaWYgQ09ORklHX0lTX0VOQUJMRUQoUkFNX0RFVklD
RSkgfHwgQ09ORklHX0lTX0VOQUJMRUQoREZVKQ0KPiAgIHN0YXRpYyB1bG9uZyBzcGxfcmFt
X2xvYWRfcmVhZChzdHJ1Y3Qgc3BsX2xvYWRfaW5mbyAqbG9hZCwgdWxvbmcgc2VjdG9yLA0K
PiAgIAkJCSAgICAgICB1bG9uZyBjb3VudCwgdm9pZCAqYnVmKQ0KPiAgIHsNCj4gQEAgLTk2
LDYgKzk3LDggQEAgc3RhdGljIGludCBzcGxfcmFtX2xvYWRfaW1hZ2Uoc3RydWN0IHNwbF9p
bWFnZV9pbmZvICpzcGxfaW1hZ2UsDQo+ICAgDQo+ICAgCXJldHVybiByZXQ7DQo+ICAgfQ0K
PiArI2VuZGlmDQo+ICsNCj4gICAjaWYgQ09ORklHX0lTX0VOQUJMRUQoUkFNX0RFVklDRSkN
Cj4gICBTUExfTE9BRF9JTUFHRV9NRVRIT0QoIlJBTSIsIDAsIEJPT1RfREVWSUNFX1JBTSwg
c3BsX3JhbV9sb2FkX2ltYWdlKTsNCj4gICAjZW5kaWYNCg0K
