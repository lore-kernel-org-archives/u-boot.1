Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A41C87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 14:47:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9F4783145;
	Tue, 12 Aug 2025 16:47:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bkuysF2n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AB39830B3; Tue, 12 Aug 2025 16:47:01 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18CB1830B3
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 16:46:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-458b2d9dba5so35681085e9.1
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 07:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755010017; x=1755614817; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/TOEhcBKI6o3rvCjlFHNCNirHNtn5Ieg1csuwyGjHfo=;
 b=bkuysF2nCCFOfFSj1aX2Rty0n47vQrLdt1dkzrup25dmZx45k0usOL+cyhlg9yqabU
 F3JRyFEBedEueSA2VpEvGqzbDD1X6LuOJ6c6Ifk2NEDoa+rF5HrF1+fPOCn6JXq1zCVV
 T4C7jYzAsNz80lzmvfEPXEqr94+8BNqt9ufJEMxXfT2f+p9vkM8kmC58JrJa3lgWVhVY
 mOqNsnas5ds5AMbpEHV/cQfx2BUjnH7pVK5xrIaOApd41l+se4o/uHA6SWqGAQi3Q2hr
 aftuJ9+o91b8qw2hmqK830qH/E+4Pg4h5W1xXidmfMcLaHzqIbfrYjY/yX5+nqiV/4/R
 5+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755010017; x=1755614817;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/TOEhcBKI6o3rvCjlFHNCNirHNtn5Ieg1csuwyGjHfo=;
 b=haAdR9kI4kYHWfohIIlMdUbUPE1bmoaDIxbkXxWZMI/xmSzsaKdEhutVc+OmjMEjU8
 s9x+k6GqKBwsIi67bx7ZbFAw//OpsKrQXSXBtZduacAmRVMiS9Cw02KmkFW9tAyXsI2g
 AA8LEBCfd3KDiR8wgiPvvPAmaMGt/ZWTvmPiD/J+pNYgu23wE1hLdNQJCZ+tLZh5Zl4v
 L+A8ipTnzmZGF7iczx6womjzJZNUD5CU044k/0u7zkDwfxLRP1xoKwgZTBnA5okVZcfR
 7LsOGt6z926ygTbmR94vU2f93s/nu2nryEdzZ4KxUSEnHUsHZy2mptWazoPWYH3YT1ai
 rkjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCt0AlFXySZT3fOd68TH/uABfL/3zP4djCgDARqb2i4LOuTlItHYlnzk/g5Y2dJXN+r/Zj+60=@lists.denx.de
X-Gm-Message-State: AOJu0YwSheMxQCJhStTr3Fyle/nH4+78hCGHGUCGDVj/LhE1G3XAmymP
 bGTrJPqeSfrhQivLnkBBZdf3MoeuMkIWPFcWTkoUyxp84wkcrq46BMN/MlBiGSGXzP4=
X-Gm-Gg: ASbGncvRG+RsRVLvbTZa2gWl7v2a0a4/wJeNqCJwz99TTBSooYWpyXtZGuf3v5W54o7
 iS8Y9TYGOHe87yPVZUcTVEDbS7gxUsvtzug25x7ioO5KMG4optSDRG+ORpkPA4Ok+SS5g1iOTv/
 TONAmc+zAjwgPtDKkIwV2Pi56Yze/hp37p2zYVwo4T3IIFtMJ6ttzw2Cexu7CHGp9u09OmB25di
 SUpIkfCS6hrYnIwmc7dkin+JC2mHyxMZLpGKg25CdqtyFSczGr7B5dcMw+LQNrPMGyTLl0aKAUQ
 itr/H2p7+cKFuKsYcTXeoOsGABE/7lHgMv1420fJMT7BGAClaI4REK0B8o9Lk3SZp5Cj6DcB2gB
 0cDOn9BIi69ZJSzC06Y1j6kO4wbNFizbqswOtVVll88sFwlk5X8A35Vj/vtuyIpzB4viX/0Q6/z
 97Bw==
X-Google-Smtp-Source: AGHT+IH/jrbtkzSDG+Udzrm8azvg+UMRCSBXskCRfket4Asly4QM4jGTibaZAC5SzrVgvOEgEfNJ0Q==
X-Received: by 2002:a05:600c:1d02:b0:456:285b:db29 with SMTP id
 5b1f17b1804b1-45a15b4eee8mr633985e9.29.1755010017380; 
 Tue, 12 Aug 2025 07:46:57 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:97a2:1bc7:9f2e:6519?
 ([2a0a:ef40:f9e:3c01:97a2:1bc7:9f2e:6519])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e6867193sm304631815e9.6.2025.08.12.07.46.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 07:46:56 -0700 (PDT)
Message-ID: <cc82add8-5f9c-4ee1-87ea-a458e840e621@linaro.org>
Date: Tue, 12 Aug 2025 15:46:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Seeking advice on API return type inconsistency
To: Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <f5c94319-8ef8-459d-88b2-836702779cfb@linaro.org>
 <e10a39e4-9606-4ae4-86dd-11de4b39b5ed@cherry.de>
 <2d6457b8-c637-4531-8f56-e2aea320a319@linaro.org>
 <20250812143349.GQ124814@bill-the-cat>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250812143349.GQ124814@bill-the-cat>
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

On 12/08/2025 15:33, Tom Rini wrote:
> On Tue, Aug 12, 2025 at 10:17:47AM +0100, Andrew Goodbody wrote:
>> On 11/08/2025 17:36, Quentin Schulz wrote:
>>> Hi Andrew,
>>>
>>> On 8/11/25 5:24 PM, Andrew Goodbody wrote:
>>>> Hi,
>>>>
>>>> I was wondering what people's thoughts were on API return types. In
>>>> particular there is this and other examples in include/clk-uclass.h
>>>>
>>>> /**
>>>>    * get_rate() - Get current clock rate.
>>>>    * @clk:    The clock to query.
>>>>    *
>>>>    * This returns the current rate of a clock. If the clock is
>>>> disabled, it
>>>>    * returns the rate at which the clock would run if it was enabled. The
>>>>    * following pseudo-code should hold::
>>>>    *
>>>>    *   disable(clk)
>>>>    *   rate = get_rate(clk)
>>>>    *   enable(clk)
>>>>    *   assert(get_rate(clk) == rate)
>>>>    *
>>>>    * Return:
>>>>    * * The rate of @clk
>>>>    * * -%ENOSYS if this function is not implemented for @clk
>>>>    * * -%ENOENT if @clk->id is invalid. Prefer using an assert
>>>> instead, and doing
>>>>    *   this check in request().
>>>>    * * Another negative error value (such as %EIO or %ECOMM) if the
>>>> rate could
>>>>    *   not be determined due to a bus error.
>>>>    */
>>>> ulong get_rate(struct clk *clk);
>>>>
>>>>
>>>> get_rate is declared as returning a ulong but the description says
>>>> that it can return negative errors. A simple test of the return
>>>> value for being less than 0 will always fail so errors can go
>>>> undetected. Casting to a signed type seems less than ideal.
>>>>
>>>> What is the best way to deal with this? Cast to a signed or update
>>>> the API to be signed or...?
>>>>
>>>
>>> Note that clk_get_rate() in the kernel has the same function signature
>>> so I would refrain from changing the type otherwise we'll have some
>>> "funny" bugs to handle considering it isn't that uncommon to import
>>> drivers almost as-is from the Linux kernel.
>>
>> Ah yes. The difference being that the kernel does not seem to attempt to
>> push an error code through this API, you get a rate or you get 0.
> 
> How is the error code pushed? Or is it up to the caller to decide that 0
> means on a case by case basis?

In the Linux kernel almost no code checks the return of clk_get_rate at 
all. Some code will check the value is sensible and 0 is obviously not 
sensible. But pretty much the call to clk_get_rate is not expected to fail.

Andrew
