Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18242D35E5D
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 10:07:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13BCE891DB;
	Thu,  7 Nov 2024 11:07:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="UUDuH8Wu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58074891E1; Thu,  7 Nov 2024 11:07:38 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5996089177
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 11:07:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9014D3F2AB
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 10:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730974053;
 bh=3kYOlAU9bYfUekmamYfVSYUKBL8FPoUAbdNF/CayahQ=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=UUDuH8Wu99skK0ly2sDJdUy39l2I7lA2/7lYD4xDXB+arOF9WACEPnRt0WOOgp9fI
 n+W63JO0D872gHLLCoqBsFOBmzH3X5Zy6drvQqMXoZgvR/XprCmuxbwS3iSqx/tbKE
 2Wl+j/nJkVEukm0AFZKO6WoGVBnz07sHVZJFcOyHqMtKA1R9hw3HT04TC29F4dWnyh
 GA2oY1Qc7QbIDW/Wvyc+4WW5R4NNZOu359NiZuNjSSRxEaew2K47Ypu7+FzQeWUHmM
 Ta69d/YTjtAQAqY6e4tw5LI8ZiV2XAz95UOT3lm8e/w310aU6kbm2XJSLIKPLob9Mz
 lrC/MhgYamS/g==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315eaa3189so7293955e9.1
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 02:07:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730974053; x=1731578853;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3kYOlAU9bYfUekmamYfVSYUKBL8FPoUAbdNF/CayahQ=;
 b=QvOlTse5d7rqkVsFy+0KHyepp45N0MEMyWdQ50LsHnBIyH4z1+Kou9rzBD3qdyKdkG
 RVt1keKdiJj6lgF/DZ2ZV1igVwc3XjTizz7UUl8bKZrrqHHUufKzqszhY8hU2uVeQ2Eq
 b2zvmzWVO4oKhKZPKuBliUDuao+DeKKfnhRxKLNMdQMouZj+Z9zni8v3s9BrdmTwv8Gc
 IT7BpHH1jkWgzd/dthFHDKz4iXvmnMmEqXSrgI6IPm5tHgO3yeCY84nP7Toq02Uk5WAW
 4HlS4hm46aLvsl1J3/0t14n0OXaid9PI+OuK8NKiK5r4cMPj4J06avuYEn2OcQdNbQeh
 2C/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1Cne/zYAOd6z+E36jxZv7IQQt7f4Qmifw1FUu6fwpFlP0BCok7TlCSw5nM5cNWjXs6kgIdSQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8belUx0658hPkyR1ANLtmWL9f9f9zxL31Yme4cM5VloDkm4MY
 UoXC8kFXMSkm0ZTURn4ff9DERVgSRswmn+YntJ2Xas9yYfPPJdJLCVXwicGd7gsV5yD8MxMYGM+
 7SIH/OZflGf8JcA8Mh6bVOwktdJ83I+vsLsqAy2/moWzORWuRCOP2mWz9dxvmmDQyKB8=
X-Received: by 2002:a05:600c:1d1e:b0:431:604d:b22 with SMTP id
 5b1f17b1804b1-43283255922mr236981125e9.16.1730974053165; 
 Thu, 07 Nov 2024 02:07:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPO6G5XQM6sbeKg2b0OZasw0zhOoCSfNzBe1CRu2y6HTuutFKkee95JDE8VHEioDhkEBnvig==
X-Received: by 2002:a05:600c:1d1e:b0:431:604d:b22 with SMTP id
 5b1f17b1804b1-43283255922mr236980785e9.16.1730974052775; 
 Thu, 07 Nov 2024 02:07:32 -0800 (PST)
Received: from [192.168.123.161]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b05319aesm17752035e9.8.2024.11.07.02.07.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 02:07:32 -0800 (PST)
Message-ID: <811d9095-f0ef-4798-981c-4b45bb84f3c9@canonical.com>
Date: Thu, 7 Nov 2024 11:07:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] lmb.c: add missing comma in lmb_dump_region()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 u-boot@lists.denx.de
References: <20241102064127.41571-1-heinrich.schuchardt@canonical.com>
 <CAC_iWj+RvycgEoFZXbs8G4YCY+k6jwLzzWj5WAp5xpu6D17xww@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWj+RvycgEoFZXbs8G4YCY+k6jwLzzWj5WAp5xpu6D17xww@mail.gmail.com>
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

On 11/7/24 10:56, Ilias Apalodimas wrote:
> On Sat, 2 Nov 2024 at 06:41, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> In the message string " %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: "
>> a comma is missing before flags.
>>
>> To avoid increasing the code size replace '0x%' by '%#'.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   lib/lmb.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/lmb.c b/lib/lmb.c
>> index 00c8888936a..95adf2e93a4 100644
>> --- a/lib/lmb.c
>> +++ b/lib/lmb.c
>> @@ -97,7 +97,7 @@ static void lmb_dump_region(struct alist *lmb_rgn_lst, char *name)
>>          enum lmb_flags flags;
>>          int i;
>>
>> -       printf(" %s.count = 0x%x\n", name, lmb_rgn_lst->count);
>> +       printf(" %s.count = %#x\n", name, lmb_rgn_lst->count);
>>
>>          for (i = 0; i < lmb_rgn_lst->count; i++) {
>>                  base = rgn[i].base;
>> @@ -105,7 +105,7 @@ static void lmb_dump_region(struct alist *lmb_rgn_lst, char *name)
>>                  end = base + size - 1;
>>                  flags = rgn[i].flags;
>>
>> -               printf(" %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: ",
>> +               printf(" %s[%d]\t[%#llx-%#llx], %#08llx bytes, flags: ",

If we use #, we have to increase the size (8) by two to get the same 
output. But why have leading zeros for the size if we have none for the 
addresses?

Let's drop the 08. Allocations of more than 4 GiB anyway would not fit 
into 8 digits.

Best regards

Heinrich

>>                         name, i, base, end, size);
>>                  lmb_print_region_flags(flags);
>>          }
>> --
>> 2.45.2
>>
> 
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

