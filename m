Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68465C8303C
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 14:49:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 939D98304D;
	Mon,  7 Jul 2025 16:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e8X2/Nxb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3C5B830CA; Mon,  7 Jul 2025 16:49:55 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D46C683046
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 16:49:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so32985075e9.3
 for <u-boot@lists.denx.de>; Mon, 07 Jul 2025 07:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751899793; x=1752504593; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+njz1tQ1dUMupU2uLWzSDc7zpT8bGnOXVCGPya7uD34=;
 b=e8X2/NxbBG264S3GJuC4wrio2QrzgxrwvG7Fdz18pj4SA+9Clhm+xnvCONxWxF2l3F
 3nSipiOlVl28yjL+agaVytm8u749GHAeK75oub51Nfe2CyeYFYBSUa258sTjLzuLTTd2
 agut1s+/Q/NtIQrXJCXlwnJzbqLpTv2I65OYfxeyOEdOd3vrvyaF5GewFL5gFWp7CEgq
 qgVpH8stgYUSw3qdu2FrvYlMPHVzdXvGsh+A/mGYrJfXnkqTWZrj7fxvd9j5+e2n8CyA
 rgtu2A4EJ+gnKq5R4PZ9fY59Ehi0DVi0WCUBz4d79WskHnz6OV+Su0vW1MOjBMU5WvO6
 EV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751899793; x=1752504593;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+njz1tQ1dUMupU2uLWzSDc7zpT8bGnOXVCGPya7uD34=;
 b=PzhZ5Kq4t37Pf3lrnT1S9EB+Dz5g2czsL1dcf5BptLdzvT+Vp1q4/ObvzMGdpJJ8zu
 tSmecLQV1dWjHDmbn38bZGwrYO2BSGlwUI2PSoJv8yMeTQkCgJaJhGfVa4qOCBO2BTaZ
 LZ4RSHe78Jzc7js+XDXUtV67wwZn+ArxppsqyjU5GdSRixPB9meT96uIoZt4/rxBvY4G
 0NE8Hip+AFGE5r3nVmvI3awRltGmYe0t/Ubwfa4cEo1w6AErg2vr/m1V0jN1wJPd7Dey
 /P5aPzZ+6Sv6fsl6i5jjHyT2vF7CI9FfXaSHRRKdfH5tnuAXNP54/OFD7cbM1uFnFAZD
 8hew==
X-Gm-Message-State: AOJu0YwqJRXCnR3l+q8C6qVg22zzNX4qKF8wQbQ+DoawqTHgDkK3RB3y
 qq+tsGNJ6ePCByagOCcE7pWsGThXwiQMaUgoChTwjywu+6y/9QiY9m3Fqjh9Qfj6QZc=
X-Gm-Gg: ASbGncssGovweD3rI4iKP3StguVlMBWxtiB0pAZcSwJlfnFCAx8Lx5D7UBaQ1U8OLJG
 mtXdC+rPg/g4QtYleD14BbYYZL6rqAeK3YDAeSqlcG8RkZoSJYRh5QIKiYWlAZVOAeAGQKIHXF0
 nPqG2bzwXdGFNz605uHfXLPYJa/uGyOaWnzmyDIRaGL2uIgHk0hJmFFmLam0iwhgeYWtDTXJjzi
 HRNoQYrVIl2ghio9z94kXn+OVdrLoCTLDb1xlCnlrxGkurFnemO+IL0FNz136h3bmyiCz5EfUgU
 C+a/aK/zkh6BUSmZQ6g3FlKrQbmXygcSdF8KOBQ7iMMeQcRjXwb59VXg8DtxhXyVb7kTJdHoLVC
 1FtrU4HRR83CCiLS8tzxatS1qew32uAbaZBcOrI4=
X-Google-Smtp-Source: AGHT+IFQU5GkRMDXK3B5ZqQgY1S+d7lIkD/LMu+skA2qq/KGVpFK3GK4ttsgvX59BK9ewmc/daNqDA==
X-Received: by 2002:a05:600c:3549:b0:453:a88:d509 with SMTP id
 5b1f17b1804b1-454b308c9bcmr153599425e9.10.1751899792939; 
 Mon, 07 Jul 2025 07:49:52 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:e07:801:7bf5:4bcd:8bca:5bc3?
 ([2a0a:ef40:e07:801:7bf5:4bcd:8bca:5bc3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b4708d0ed9sm10536169f8f.38.2025.07.07.07.49.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 07:49:52 -0700 (PDT)
Message-ID: <2ca9c84d-5b07-483e-aeac-77b9fa4df4bd@linaro.org>
Date: Mon, 7 Jul 2025 15:49:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PCI config read functions
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <3df65973-626b-4894-84bd-5a03a19032c2@linaro.org>
 <20250704205905.GL6424@bill-the-cat>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250704205905.GL6424@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 04/07/2025 21:59, Tom Rini wrote:
> On Fri, Jul 04, 2025 at 10:53:55AM +0100, Andrew Goodbody wrote:
>> Hi Tom,
>>
>> Smatch reports that the callers of the functions
>> (dm_)pci_config_read(8|16|32) from drivers/pci/pci-uclass.c do not check the
>> return value for an error before using the variable that should have been
>> assigned with the value read. However in the error path that variable is not
>> assigned to and so the code can use an uninitialised variable in that case.
>> eg line 1396 in drivers/pci/pci-uclass.c addr may not have been assigned to
>> in the error case.
>>
>> This also seems to be the case with callers from other files as well.
>>
>> Would a patch that adds a default assignment before returning an error to
>> the affected functions be accepted?
> 
> Can you please check the size growth on say qemu_arm* and we can go from
> there? Thanks.

Size info from buildman

    aarch64: (for 3/3 boards) all +26.7 rodata +2.7 text +24.0
        arm: (for 1/1 boards) all +16.0 text +16.0

Andrew
