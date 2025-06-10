Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9DAC5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 11:17:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF7B482AC4;
	Tue, 10 Jun 2025 13:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="gDT/f5xs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A2BC82AE9; Tue, 10 Jun 2025 13:17:29 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 290B38070C
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 13:17:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 15A8F3F675
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 11:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1749554246;
 bh=lC90cSFapr/1zzIvPvlYAdvL1QpfWochKq8k1nt3l2E=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=gDT/f5xs3jKNDwL89N+VvXP8wkua7jOCygfH2VSjzYJseS4+HTmyBny4jzJ1Pr7OL
 rhyAr5J4SXFvdu8pypFJJ7Mkw3dPF/ytkiEQaFHECmQsfxFcEok9GLG60WGpTbDfhj
 oZcVaIMb4aRBxNxwesMopQlWRw3MH5eKgpeA2LoQC8oZIgMrsv01pUM9jl0UjYhNI4
 +Q+c+G37WGSRMU2TTJGvGy2/E3ZCBGbieXbESiG0hUdf1gR/qxVG6w5IHraaaRNMUQ
 9TKh/9osTAAXP8J+d+xGDrlXUHesNzhBoFnTyuDgqwG+vK9vMRbLiY0ZYimYiH7uhe
 TxkC/EVHRbmqQ==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-450cb8f8b1bso12659765e9.3
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 04:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749554245; x=1750159045;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lC90cSFapr/1zzIvPvlYAdvL1QpfWochKq8k1nt3l2E=;
 b=Y4Ele3CA/EU3a3kj6y4I2Fllb7kapENENqVYn2pDctdNYmvBHlvCnRBQh/s3CyXDB1
 9Z3Gy07BvJOVdGTVCBta2j0IniMkItqmwux9i8fIlfATnVi+rBW2P3LrVMxYQL0DKSxD
 Dq2wgK0JtdGJAl2Yh6TeGsix7GZlc9EWnI32u6ueXraQqTK509Fwj8BYwCximC1CDTLR
 VL0RHi5ygBnxMaWKC1xBlxnVk83qsoVQqwM+pAZecISvl+DIuQULOP4a+0kP4XxJE3nx
 dFGiR4eXLBlElibJCcsr8J5EEgMop+psa+8gaIZUXvkFEvniFBEUu+QtXA2L/qvFjDaT
 axDw==
X-Gm-Message-State: AOJu0YyMWMjtus/8In99UDw9gPXkytm0i+SIqHZGONu5uH7LW8821/FE
 YCNfmE2Y2uoakCzFIxVR3btMEiLevNLXvTLDlkCpO/x307O6KXqvep8CjpcMy8u+IPIpSYvIdPg
 3sbTKrb7gQHqDXGcMlz+PZXwprX2ULP2R0aFq0cw8KhiI7TyWjseRGlSStunAgz3ZkBb/+Ys=
X-Gm-Gg: ASbGncv1VuQtWabeqbtcYQUF3FUC85+mX2WZy3t0iWXW+jQqcATl+ZAkb2UeMmVYDeg
 Fc64kWd/7oqDPBI3nLZ4Jc3xxxoUBTSczurWt9KAuj+Hksq/Lwj7/2TohyKiw0FhZNEuxQnWgAg
 Yyj6iUBlPOlyRrN7SKxavHhQqCmZ9qbobHawG3IlcVSCf/1U+vyRJeIbhylXl2rbsSiSrP2BfHo
 XL4NDvtwIrhYxU5qYfmydYv3o/tUCiNtvuiOI0VHmIc2du6NI56g0j9aG5e5wpT08e4yneZPsBd
 ln9IKNdzHRPh5Zw2C1ug/49rC7EZ6BZ1e9YJqRGd9EU4rc69NR9OcRwzVzSMdkEdOy4kEu96AiM
 DafJvjuEeyMEZ
X-Received: by 2002:a05:600c:1c14:b0:43c:fffc:786c with SMTP id
 5b1f17b1804b1-452013bb7c6mr137988455e9.19.1749554245186; 
 Tue, 10 Jun 2025 04:17:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWYXiTbT0nLxtGUu/j5p5cAnDFoWvVEmeXSGsLzYTytM42mqgPwHeZ0l6aMMFVZHw/L2E60A==
X-Received: by 2002:a05:600c:1c14:b0:43c:fffc:786c with SMTP id
 5b1f17b1804b1-452013bb7c6mr137988175e9.19.1749554244743; 
 Tue, 10 Jun 2025 04:17:24 -0700 (PDT)
Received: from ?IPV6:2a02:3038:2e0:2ece:2a01:7458:883c:9b1b?
 ([2a02:3038:2e0:2ece:2a01:7458:883c:9b1b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53229da18sm12217516f8f.19.2025.06.10.04.17.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 04:17:23 -0700 (PDT)
Message-ID: <5f843f23-77fe-441e-80f7-28ad10431f68@canonical.com>
Date: Tue, 10 Jun 2025 13:17:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] pylibfdt: correct license information
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20250607113218.208923-1-heinrich.schuchardt@canonical.com>
 <7240ff54-a730-4f86-9ed2-8ca242ab8388@cherry.de>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <7240ff54-a730-4f86-9ed2-8ca242ab8388@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10.06.25 12:53, Quentin Schulz wrote:
> Hi Heinrich,
> 
> On 6/7/25 1:32 PM, Heinrich Schuchardt wrote:
>> Setuptools 78.1.1 shows warnings:
>>
>> * Pattern 'GPL' did not match any files.
>> * Pattern 'BSD-2-Clause' did not match any files.
>> * SetuptoolsDeprecationWarning: License classifiers are deprecated.
>>
>> Cf. https://packaging.python.org/en/latest/guides/writing-pyproject- 
>> toml/#license
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   scripts/dtc/pylibfdt/setup.py | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/scripts/dtc/pylibfdt/setup.py b/scripts/dtc/pylibfdt/ 
>> setup.py
>> index c6fe5a6a446..487e669f524 100755
>> --- a/scripts/dtc/pylibfdt/setup.py
>> +++ b/scripts/dtc/pylibfdt/setup.py
>> @@ -158,12 +158,10 @@ setup(
>>       long_description_content_type="text/plain",
>>       url="https://git.kernel.org/pub/scm/utils/dtc/dtc.git",
>>       license="BSD",
>> -    license_files=["GPL", "BSD-2-Clause"],
>> +    license_files=["Licenses/gpl-2.0.txt", "Licenses/bsd-2-clause.txt"],
>>       classifiers=[
>>           "Programming Language :: Python :: 3",
>> -        "License :: OSI Approved :: BSD License",
>> -        "License :: OSI Approved :: GNU General Public License v2 or 
>> later (GPLv2+)",
> 
> This is an issue though, as it's supposed to be replaced by the license 
> argument to the setuptools.setup() function and we aren't matching there 
> (though tbf, we weren't already matching :) ).

Upstream setup tools has been changed to ignore these lines.

> 
> Also, I'm not entirely sure BSD is unambiguous?

There are BSD Zero Clause License, BSD 1-Clause License, BSD-2-Clause, 
and BSD-3-Clause, and further variants. See

https://spdx.org/licenses/

The linked files in license_files are unambiguous.

> 
> I would suggest:
> 
> license="GPL-2.0-or-later OR BSD-2-Clause"
> 
> to match the SPDX-License-Identifier at the top if the setup.py file :)

51ec8db23280 ("pylibfdt: correct license information") is already 
merged. Please, send a new patch id you want to change the license field.

Best regards

Heinrich
