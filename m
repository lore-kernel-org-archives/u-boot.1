Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C27BC19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 14:16:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5524809D4;
	Fri, 28 Feb 2025 15:16:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mNLAnhXq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C25C80BA4; Fri, 28 Feb 2025 15:16:41 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A405807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 15:16:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5dca468c5e4so3605894a12.1
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 06:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740752198; x=1741356998; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cpVMDJd/1e5qbJyqDR5sD4URubytAj2a3SOMTScRqbw=;
 b=mNLAnhXqi0YMCVrdxBMGxOYXrDOXtOiOdiHXWORUgg3PcCvLOo4QBqos0/6yBgbMMU
 tCiQB1G15qj9i0SjDSpYzGcD1ps7R0cX4IjntIQBW3u/bO3ApS1lSd/jzHRukkCzMXce
 h9VarbrZQbsDydYnO0HhdF2WgRMkjZVwinEqq+6blS1kufUOUTxcDeTnRyy18R8E4LO9
 lTUVUAictPe+xIIaW23rkRnR2DMnRptzjrI7mpBc/fet7dovP/Qm8Sq5VKg4GbghE+r8
 HTR3nHa77nE3JomNqDUuDdx1CjhVgVc49TtnrIwD8KD7AtgchYUg1YpQhV9YWO/fddeT
 depA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740752198; x=1741356998;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cpVMDJd/1e5qbJyqDR5sD4URubytAj2a3SOMTScRqbw=;
 b=sVDh6At/nBNu2jrXhYiwIK1FDXRRUG6XX/3oNXmHJMtkJjnQ2VRu/DCXZOVv8taYdT
 B/G+l40P9KJX4KlaRjx7b0tDBIWYPv8Yj2ZPITBUseBO589RQCdHcI+FEi0C9BDT9cjt
 DMWU7G1o3jcfRQpDyI6O6R3djmtFfO/lh4u4n3UPAdbVnTPpQDck47ovapA7nNg1bhCW
 1DnYu3/QL9YmDjrN/gzG+DXZXtkJ0Nb0Jzo5wgWEyD6fjjh7uvX2YNh3WHfPAACng4q7
 Id0BF0p/GLKnEi/I7rxPIwcmM8BH2iNEfDmjx6erVG5om97Sn8ULplwk9Oe+SMT3TXkb
 6PuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFTpTowAMdswXZbzY15MqNEydFu26+dq7d35O8sQAPhywhxxXJT0qWP44ix5pgBoL42TJcvj0=@lists.denx.de
X-Gm-Message-State: AOJu0YyLEf0VbRuhEmsBj/s4wKSwqAZCGLhnf2AEXvNoCkG8PA9okZnt
 iNU4vIyvrofk1GfK48PEUYFRMPGSXoZc5jVexpalyPsI3QLrFtUFJWL8yWKJi24=
X-Gm-Gg: ASbGncs+A/vdH2Co9AlENrzjpWmr5Vr5Ys0iR9FuX4TtomIyn6c47/N46D7l5we1NRc
 GQht5hQZRrzCHM6b2FOjgqrvkwSzb5xmBdoh9N4FzO4sZcefUmw5UwJju9PJ6zEpaNTX2JG0Slo
 cBf3+krUP4Q1fWqksCHE9F4Tekx0dwt0Yo6wAKj1WZU1Osd2e11jmSORgayFhFm0ls4WcL3KCiM
 KnVyblgkP/RrUAOlV9iZY+MEA5G93caazVmRB63ixT6kSKr4jqOuGdAjgSkPUSDmSFjhSyquPuD
 xwqVpWs6ghNcu7BCdpS4lHkUSqBAB859f82QHaGqV5j+4cNHMKE9WUkFSkUGw6kE/b2hI9eTmls
 0sJ7Kag==
X-Google-Smtp-Source: AGHT+IGKjiYL+QlqzjIeQ0IS0I53XZVSmQ2x+a5nHF8PiSQlUYSAxKpMShuXUkuU/2Kbh7qf0OO0sA==
X-Received: by 2002:a05:6402:2790:b0:5e4:d229:ad3d with SMTP id
 4fb4d7f45d1cf-5e4d6afa4c4mr2985330a12.16.1740752198540; 
 Fri, 28 Feb 2025 06:16:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:c779:ac28:4c86:118c?
 ([2a01:e0a:3cb:7bb0:c779:ac28:4c86:118c])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c3fb610dsm2502499a12.58.2025.02.28.06.16.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 06:16:38 -0800 (PST)
Message-ID: <c7961116-77b7-4db1-91ea-6e47f11d183c@linaro.org>
Date: Fri, 28 Feb 2025 15:16:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] arm: add initjmp()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>, u-boot@lists.denx.de
References: <cover.1740499185.git.jerome.forissier@linaro.org>
 <bba48e537696016b94faa69a20f998256b060685.1740499185.git.jerome.forissier@linaro.org>
 <2a3e72c0-30d3-4f52-84c2-81d34b2a4286@gmx.de>
 <911a467a-3dbb-4a12-aa49-2aaef2094011@linaro.org>
 <0cd2dd22-e653-481d-b9b7-fafa91059e47@gmx.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <0cd2dd22-e653-481d-b9b7-fafa91059e47@gmx.de>
Content-Type: text/plain; charset=UTF-8
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



On 2/28/25 14:28, Heinrich Schuchardt wrote:
> On 28.02.25 14:21, Jerome Forissier wrote:
>>
>>
>> On 2/28/25 14:05, Heinrich Schuchardt wrote:
>>> On 25.02.25 17:34, Jerome Forissier wrote:
>>>> Implement initjmp() for Arm.
>>>>
>>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>>> ---
>>>>    arch/Kconfig                  |  1 +
>>>>    arch/arm/include/asm/setjmp.h |  1 +
>>>>    arch/arm/lib/setjmp.S         | 11 +++++++++++
>>>>    arch/arm/lib/setjmp_aarch64.S |  9 +++++++++
>>>>    4 files changed, 22 insertions(+)
>>>>
>>>> diff --git a/arch/Kconfig b/arch/Kconfig
>>>> index 8d5b54031b3..57695fada8d 100644
>>>> --- a/arch/Kconfig
>>>> +++ b/arch/Kconfig
>>>> @@ -94,6 +94,7 @@ config ARC
>>>>    config ARM
>>>>        bool "ARM architecture"
>>>>        select HAVE_SETJMP
>>>> +    select HAVE_INITJMP
>>>>        select ARCH_SUPPORTS_LTO
>>>>        select CREATE_ARCH_SYMLINK
>>>>        select HAVE_PRIVATE_LIBGCC if !ARM64
>>>> diff --git a/arch/arm/include/asm/setjmp.h b/arch/arm/include/asm/setjmp.h
>>>> index 662bec86321..1ad5b500f2a 100644
>>>> --- a/arch/arm/include/asm/setjmp.h
>>>> +++ b/arch/arm/include/asm/setjmp.h
>>>> @@ -23,5 +23,6 @@ typedef struct jmp_buf_data jmp_buf[1];
>>>>
>>>>    int setjmp(jmp_buf jmp);
>>>>    void longjmp(jmp_buf jmp, int ret);
>>>> +int initjmp(jmp_buf jmp, void __noreturn (*func)(void), void *stack_top);
>>>
>>> As this is not a standard function we cannot expect developers to know
>>> what it does and how to use it.
>>>
>>> Please, provide Sphinx style documentation with the necessary information.
>>
>> I agree on principle, but if I add documentation here then I should add the
>> same for all architectures. That being said the prototypes are already
>> duplicated so maybe consolidation is a question for another time.  I will
>> add Shpinx style doc to all 3 commits "{arm,riscv,sandbox}: add initjmp()".
> 
> Yes, this was not designed correctly:
> 
> We should move setjmp.h to include/asm-generic and include an
> architecture specific setjmp_bits.h from there.
> 
> setjmp_bits.h would provide the struct jmp_buf_data definition.

Makes sense. I'll rework in v3.

> 
>>
>> As for usage, I think the best documentation is test/lib/initjmp.c added
>> by "test: lib: add initjmp() test".
> 
> Example code is valuable but does not replace documentation.

Should I provide a stripped-down example in the Sphinx doc? Or do you have
another location in mind? (doc/develop/initjmp.rst?).

Thanks,
-- 
Jerome

> 
> Best regards
> 
> Heinrich
