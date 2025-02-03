Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4D6C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 11:03:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41AD7800B2;
	Mon,  3 Feb 2025 12:03:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Z1G77QAk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64F7880107; Mon,  3 Feb 2025 12:03:29 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD2348004F
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 12:03:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9B91F3F1EF
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 11:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1738580605;
 bh=WeJBNoE15FX7HHbcn2IVP/NyvNC9sd4PGsM1NsBvYfg=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Z1G77QAkIwLEDCJ6/H2cieyRJYuZ/xNUKI2Y/ZdFURTlY2HyWcv3AE3jWu4gj83l4
 SVlnmgKPuH6tM7GR6TpEfLqALsdfp2RodKA4xnDHX9q5CBdnHwKt0ptYaTRgaaLIrA
 2OhSIx+svwA5HorkKAvTtVwXOs4LgQkVIjiB85NbizqBjUzTBk0Wcp3giAe6wwM/Kk
 RmHekREyITvS9n/vussBTCV+6WhYhkoo+L2J4JxUGt5EUHWTTacgjkT2rVI2+1ixGB
 gxN+WvgXSX3xfOaVrUfPqWW0LStPMZfQe2MTT2taVtxnWHcdPYoPIL04GlHqYO98ev
 BpiE0Q1qG4AkQ==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-436225d4389so22770115e9.1
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 03:03:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738580605; x=1739185405;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WeJBNoE15FX7HHbcn2IVP/NyvNC9sd4PGsM1NsBvYfg=;
 b=PrX5mvSsaOOKhVBecFe91yyVLeCEdhDD3fwLEljXRQJsuazxzL48MGRRqu0l5S6tIg
 ZKnEwtzJsMOOIGHE/eGQ1ihfviYxesmpQtSULFxFn6PtZiClGjRZc3RLiLotPgwyoS+Q
 CkpcgJ4knzBJTZ/KQv7gC472LwkDjgF9bUhskPdNFb8evu8fhRQ54IZlQecYTgS7TmmF
 Ni5dwoHq20/GQfFs6PsCuvF3XxgODXAHGPmbFyGlnPpeCbgOIuUyjeEFWobX40J8XUIq
 A9MalAPZKYPQFxm2IZw4TPD5C7v4NunhCRpQcrnMk7VmMISOtbK634e+uoelTYLqt0kA
 ZlcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBaubylp81qcyOnPYBy3Ef/NXsvC+Yd7UIibAbW/MKOUOBbTkhrAaby3k7OmsB2QVMs28Bhzw=@lists.denx.de
X-Gm-Message-State: AOJu0YztVjFfR/hRE7SYShYpqy3JzO+Df53YvQLm3POJ1HavVUA2q/2m
 9p+gKanpTJar9RSjX0fcZ1vBl0/SEjkyTb7iLSM0JCz8y/TQ9rK1QbZ3l/VGjPI+RS2GdvuAaYU
 G6W9H0dtYgc9CQyzKabvItGuhyvXtOdFeItt5u3A3jRiHhoRkmOxlO6mHG15TVChUXww=
X-Gm-Gg: ASbGncvepPcxcRjxTxAjTcW1mwVQeaKP7QAJ9fQj6+Dt6wFbMwJB5lD5yo7P25A8/m+
 q1pVr+qcklVL7Ea0rd8IFuHH4kQXM4v6LNPlAH63j8cuNsUtd5QdSvXv4MtR3Po09q2XGOWSE2t
 XSEfbWAb17m7s0l+L8IueojKV6MAAr8es0WdStLABYCgwI6hrYIIQ6p+i9VSrflOPv5BogHFghU
 0ZsNO/fJIRgJah1NnbEpyZ7xc+m5h5T5/EHLXgKYE5ceda0rW57UYQ11KB0+R6JgggCRn0MO8uT
 SQXi1okwrLrECoZy5RgcTJowKGLu/VFnZWD8xBY4deNOlfA0LXBXRTpdKZtg3XqEzBNKvSc=
X-Received: by 2002:a05:600c:424b:b0:434:92f8:54a8 with SMTP id
 5b1f17b1804b1-438e6e0cb00mr100295955e9.0.1738580605076; 
 Mon, 03 Feb 2025 03:03:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYzninihfOZ1c39M55wSrQQQr743HsgLZHYvlnF3Totmd5z/gtf7C3/raddG/iRBiIlL6T0g==
X-Received: by 2002:a05:600c:424b:b0:434:92f8:54a8 with SMTP id
 5b1f17b1804b1-438e6e0cb00mr100295705e9.0.1738580604716; 
 Mon, 03 Feb 2025 03:03:24 -0800 (PST)
Received: from ?IPV6:2a02:3035:6e0:4aa6:8ee1:4638:a26c:daf2?
 ([2a02:3035:6e0:4aa6:8ee1:4638:a26c:daf2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23e6984sm150232075e9.22.2025.02.03.03.03.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 03:03:23 -0800 (PST)
Message-ID: <f8a62534-f62b-4d5b-80ad-31464b67e547@canonical.com>
Date: Mon, 3 Feb 2025 12:03:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] cmd/setexpr: support concatenation of direct
 strings
To: Tom Rini <trini@konsulko.com>
Cc: Massimiliano Minella <massimiliano.minella@se.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
References: <20250105104614.7916-1-heinrich.schuchardt@canonical.com>
 <20250120205232.GE3476@bill-the-cat>
 <81b96e0f-0721-4488-b379-b09bb0f436a8@canonical.com>
 <20250202150022.GV1233568@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250202150022.GV1233568@bill-the-cat>
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

On 2/2/25 16:00, Tom Rini wrote:
> On Sun, Feb 02, 2025 at 01:01:00PM +0100, Heinrich Schuchardt wrote:
>> On 1/20/25 21:52, Tom Rini wrote:
>>> On Sun, Jan 05, 2025 at 11:46:14AM +0100, Heinrich Schuchardt wrote:
>>>
>>>> The setexpr.s command allows to concatenate two strings.
>>>>
>>>> According to the description in doc/usage/cmd/setexpr.rst the parameters
>>>> value1 and value2 can be either direct values or pointers to a
>>>> memory location holding the values.
>>>>
>>>> Unfortunately `setexpr.s <value1> + <value2>` fails if any of the values
>>>> is a direct value. $? is set to false.
>>>>
>>>> * Add support for direct values in setexpr.s.
>>>> * Correct the unit test for "setexpr.s fred 0".
>>>> * Add a new unit test for "setexpr.s fred '1' + '3'" giving '13'.
>>>>
>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>
>>> This causes ut_setexpr_setexpr_test_str to fail.
>>>
>>
>> Hello Tom,
>>
>> I am not able to reproduce this problem in Gitlab.
>> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/24424
>>
>> Please, provide a link to the failure.
> 
> The three failures in:
> https://source.denx.de/u-boot/u-boot/-/jobs/999497
> were from that test. Do we have some problem lurking perhaps similar to
> what Marek fixed in commit 082b41df8abd ("test/cmd/wget.c: Fix loadaddr
> rewrite") ?
> 

Hello Tom,

Thanks for the link.

With my patch

    setexpr.s fred 0

is expected to succeed and allocate a string "0" that is assigned to 
environment variable fred.

A few lines below Simon acknowledges that the assumption that replacing 
an environment string by a string of same size does not change the value 
of ut_check_free() does not hold true:

         /*
          * This fails in CI at present.
          *
          * ut_assertok(ut_check_delta(start_mem));
          */

I will update the patch accordingly.

@Simon:
In env_do_env_set() free() occurs after malloc(). Depending on the 
current memory layout the free() may or may not result in merging of 
chunks. So it is not expected that the available memory size stays the 
same when replacing the value of an environment variable by a string of 
the same size.

Best regards

Heinrich
