Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7805CC87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 10:58:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF26A83236;
	Wed, 13 Aug 2025 12:58:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RBrIdno/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CB5683253; Wed, 13 Aug 2025 12:58:23 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECE9782CEA
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 12:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b914a9c77dso1175351f8f.2
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 03:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755082700; x=1755687500; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NjvNJzxFS9QWA6wIyVPbVMZpkkLwUFGxvc6hDdsN8VM=;
 b=RBrIdno/Zr1cjqvvZNOa9BcTurAIUa8G5xDbtU1VUyLWzFVyKBgQjcsUisQEaAU4kr
 XuNzWJwYRp3WVFDXqOx9jUYjwrFpNmRssUi5eJXHfXq9y/+lpv4WD2ayk1MeVkRmtujQ
 VLEpmn+ETr0nN4z2+m3sBfrkg5L1Y21aEVkWhZuiO0V09r3RciKtJ8isvXOxT1RyvHH/
 9ZFNuoNXqlSVxt72HMWFFBixNx6iYRm8uE9hzgSO6fju1RjjqLyCcvHDBLOraDTMWYm5
 5e3oj6EpOs0DJGUU5PdxhlWzIoi4DSqdmGqX8wYK3Kqt0aNpzWIyucDL+50xS3rnGGTt
 Pbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755082700; x=1755687500;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NjvNJzxFS9QWA6wIyVPbVMZpkkLwUFGxvc6hDdsN8VM=;
 b=la1DTZAYzFX+qEUXVIva0brpqtGMtDtRyXmmoRp5/DwsG+lbJRVNaN3MZYg07XJdvj
 QX9FBV+6/862U5Q+eKlDanCNTNXWyF0rs9uq+3SU3edqz86HpVHvB+BNfcDois3l1kSc
 KGTuhcfx8FG9v48zCC2ILixFsaIj1E0U1Ep87GMi1Il4ME5ltA25NH2jH3gPAlZP7Nep
 6EUQ5YzJb6+E2Nz9k/ipmiGJSdEq8/GpnO8xy+04mIafB1O7YEsMy6noNWycUBwCfepN
 JBalbH+w6yX9yGo1iUv+8EkjVb6/c0DGFtbCMMRpI+0+H33Tjq7sg/lj9q3DfxtsS1iv
 pnuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6668hGM+3g5jfb4HUFCzKvjH0QSY3A3lXAdtLssHhV8V8zhoVb4ZAW58Y1F375LZYd+/Lf94=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3hxyrwHBMSY54FXEdfnbdjbnoKOBz0cta+hKtqqdrd10TvG1E
 OBAEwPwIsu463EZtm4U6X8x0qRxGO+9X/otifJnFLUQ680JnwxPT02BRCy4JV/v4X/s=
X-Gm-Gg: ASbGnctphtyaOrN9wKPjCyyFzps70YusouRwxdNN4cW+jj7Zr1SsgCVDDdwvvLWXLKs
 wtINVhizi/6kaoPT6qyhBDx8E+5MYLxv1HR88nb0cDpN/PyUTypRe7VwdnsSai1pR4Psd0KdO+D
 xBNf7J6MW4UZYThWLuSb8lhUy0Gu2jyP6md0Ip1fw3AKiskgO3izoSuB6WlIo3rbqImxqmgxSVd
 dxZtBSkJfgmzGLPdSwaW5WEbpr9isiel2iVrdmK9QArVYhaN+tWy7OWFtzvIHL6RCyr41Q49egf
 oVwqicK/WK6udQ7oHdYVE6xlMia2UxZezEYLeOoAwWIFTy3wLk+YcDDZSleURV8pJ6Bi3Tr3NC1
 rAuERESdApJoiIgurH5I7uioJmBPlSam5BYBRzmKAtvQk1crIAT6+OZvIsgDNfDubgMgcL3FH
X-Google-Smtp-Source: AGHT+IHTyt1mFy4eJcTWJ+i68J/XWnN5C3R8fDnmYcedoKiHDi9WP1ApYgLLsY5B/4oBr/G8GWrWqQ==
X-Received: by 2002:a05:6000:24c2:b0:3b7:882c:790 with SMTP id
 ffacd0b85a97d-3b917ead036mr1695194f8f.37.1755082700129; 
 Wed, 13 Aug 2025 03:58:20 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:f76:d65c:a81:fe01?
 ([2a0a:ef40:f9e:3c01:f76:d65c:a81:fe01])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b90fdc85a4sm8116223f8f.60.2025.08.13.03.58.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Aug 2025 03:58:19 -0700 (PDT)
Message-ID: <56d03251-1185-44ca-98e6-f45ac0e0af53@linaro.org>
Date: Wed, 13 Aug 2025 11:58:19 +0100
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
 <cc82add8-5f9c-4ee1-87ea-a458e840e621@linaro.org>
 <20250812150359.GS124814@bill-the-cat>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250812150359.GS124814@bill-the-cat>
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

On 12/08/2025 16:03, Tom Rini wrote:
> On Tue, Aug 12, 2025 at 03:46:56PM +0100, Andrew Goodbody wrote:
>> On 12/08/2025 15:33, Tom Rini wrote:
>>> On Tue, Aug 12, 2025 at 10:17:47AM +0100, Andrew Goodbody wrote:
>>>> On 11/08/2025 17:36, Quentin Schulz wrote:
>>>>> Hi Andrew,
>>>>>
>>>>> On 8/11/25 5:24 PM, Andrew Goodbody wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I was wondering what people's thoughts were on API return types. In
>>>>>> particular there is this and other examples in include/clk-uclass.h
>>>>>>
>>>>>> /**
>>>>>>     * get_rate() - Get current clock rate.
>>>>>>     * @clk:    The clock to query.
>>>>>>     *
>>>>>>     * This returns the current rate of a clock. If the clock is
>>>>>> disabled, it
>>>>>>     * returns the rate at which the clock would run if it was enabled. The
>>>>>>     * following pseudo-code should hold::
>>>>>>     *
>>>>>>     *   disable(clk)
>>>>>>     *   rate = get_rate(clk)
>>>>>>     *   enable(clk)
>>>>>>     *   assert(get_rate(clk) == rate)
>>>>>>     *
>>>>>>     * Return:
>>>>>>     * * The rate of @clk
>>>>>>     * * -%ENOSYS if this function is not implemented for @clk
>>>>>>     * * -%ENOENT if @clk->id is invalid. Prefer using an assert
>>>>>> instead, and doing
>>>>>>     *   this check in request().
>>>>>>     * * Another negative error value (such as %EIO or %ECOMM) if the
>>>>>> rate could
>>>>>>     *   not be determined due to a bus error.
>>>>>>     */
>>>>>> ulong get_rate(struct clk *clk);
>>>>>>
>>>>>>
>>>>>> get_rate is declared as returning a ulong but the description says
>>>>>> that it can return negative errors. A simple test of the return
>>>>>> value for being less than 0 will always fail so errors can go
>>>>>> undetected. Casting to a signed type seems less than ideal.
>>>>>>
>>>>>> What is the best way to deal with this? Cast to a signed or update
>>>>>> the API to be signed or...?
>>>>>>
>>>>>
>>>>> Note that clk_get_rate() in the kernel has the same function signature
>>>>> so I would refrain from changing the type otherwise we'll have some
>>>>> "funny" bugs to handle considering it isn't that uncommon to import
>>>>> drivers almost as-is from the Linux kernel.
>>>>
>>>> Ah yes. The difference being that the kernel does not seem to attempt to
>>>> push an error code through this API, you get a rate or you get 0.
>>>
>>> How is the error code pushed? Or is it up to the caller to decide that 0
>>> means on a case by case basis?
>>
>> In the Linux kernel almost no code checks the return of clk_get_rate at all.
>> Some code will check the value is sensible and 0 is obviously not sensible.
>> But pretty much the call to clk_get_rate is not expected to fail.
> 
> Perhaps getting lost in the specifics then, but perhaps for this case we
> should just do the same? But your question was more general, so another
> example might help.

I suspect that the answer is always going to that it depends on the 
specifics of each case. The U-Boot implementation of clk_get_rate seems 
to have become more complicated leading to the addition of returning 
error codes. This leads to the question about what level of 
compatibility should there be maintained with the kernel? That addition 
of returning error codes in U-Boot already means that the API is no 
longer compatible with that of the kernel.

Another example is a patch I just submitted [1] where the called 
function is a static so a reasonable candidate for just changing the 
signature maybe? But in this case it is only possible for it to return a 
single error code so the choice I made was to alter the test from '< 0' 
to '== -EBUSY' which I made on the basis of keeping to as small a change 
as is reasonable. If however the called function was able to return two 
or more different error codes then I would likely have opted to changing 
the signature to return a signed type as long as I was confident that 
overflow was not possible.

Andrew

1) 
https://patchwork.ozlabs.org/project/uboot/patch/20250813-tpm_tis_infineon-v1-1-c95434a98efd@linaro.org/
