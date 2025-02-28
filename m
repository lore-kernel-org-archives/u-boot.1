Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB14C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 13:21:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 843C881253;
	Fri, 28 Feb 2025 14:21:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZQes3aOL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B42EE8118A; Fri, 28 Feb 2025 14:21:19 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DCB2811C1
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 14:21:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5dedae49c63so3757107a12.0
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 05:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740748877; x=1741353677; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XssGmSNHXbM3vxAGN33SazSvUkLsUSAkv84cbuWCeqg=;
 b=ZQes3aOLl/EFheoTwD4+NSjYt1QYsXix2kZkF8tfCwYL3NDEEXd7LfpHsdeLkJRr76
 ynjeUdWHXR1w31IKdoaRDoBgoWFdqemn3/n09q1HGT/FCac14itv6tBb3r5oayV0PxE5
 YnROJih6wZ72Cm+wyrS3yMjW2EUrZOoLJEUqID4adw5OG0SzQVkLkHXAZKcS91V84p82
 nrxW+q562cl/Z4kGMbMf95OzISCUyRR+kU0k4HF/SyTcQQBnjP3n6bVqrcIlIttrZ0rD
 nkcZhJBepd8jSPZ7NeLJ6gBTJFNZPgFYESW+ZcfBEvRMTwHPYLlY3dnWi0Q72gQvUELn
 bPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740748877; x=1741353677;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XssGmSNHXbM3vxAGN33SazSvUkLsUSAkv84cbuWCeqg=;
 b=hKCT4564rc8RQKb+p0PLRPyoNrNyetPx5HT+zeltOiJDQr6jg3KBE9IdMnh8XXE8M4
 nO2F+WbW/fj4Jjno66F+OCCH7PTTdDKiBRYH10h4NTU45AtRGr5YL2GqxcKHsdpwZCjR
 WlCKaO67jrejfpgxiGUTMOivw66tvzcX+fMoTooqW3RSxPn/k/5xQbYI5N60s1IYyJR/
 zvFKno4IRmhwve4QQV3X4X7mhk7M1eV5leHDnwjpKPxhFwRXrqVJONl0SLSarH58kgBW
 MJ1GS0w/yMhxAYGRav+COqcmSKIaXQqjc4hAfg0DGJf6p7GfDNZdhHi919PZQM5VhKhw
 KdYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkLm84nsMd+lbBMQHVdW1KENGZplnc9wnoJIR6yPvxmegFdgUwH9bZBWMSVLhw0GILZG+X8js=@lists.denx.de
X-Gm-Message-State: AOJu0YyqfVUlVNnetKz/ZTFKC8X9EDBtuuzqYMarpqsZysd/4AMXd0pm
 S6g/hxrP/lJ6jlmdBD7lYIRrSySPVrw1GgoosvdiCFBYZp08GTnRFr0F00gLUAQ=
X-Gm-Gg: ASbGncsZFwBEdEb7rC+6pvL4QIypNDis8b6+dp7wktt1uKcDxdNoAolJqt6cvgzIg6p
 X5AvKny4YqsJNYUAk/sCED7YrvVTF4vj/bEVLHNvK6rehblZnXZ2S4AAZQjq6bWwmGEl0g+EJER
 pQ4LfyxMtNWhI94vK+UygSoo73BfZ7z1Ay9jgwnLebTL+lj2ArBqc7upfAvI0jjwdA4ZAfLM+oZ
 FuBYHwsYJR9ChYZTVqXuTqNtlxyHAs89/1lFVnVq3DRdH2yhfkCVBIcc7e2g0oegkA7Z9/kNeG2
 YhvUrWjtxL+E0Skxti1uQPkG5Gadhmt2hitGCrH3kiEndiFdb9+F7atxib1JVUPmwI4GkZYjDuu
 NTDRrSKOXRpbxrxZo2M6GgTWB
X-Google-Smtp-Source: AGHT+IF54XQMZJFd5KRz9ctM8NDvayCuIs3fF2cpB2Yt6niUh+/IlVyhxoVZV1hjHDz88j2x9Bs5aw==
X-Received: by 2002:a17:907:9691:b0:ab7:db5d:44ea with SMTP id
 a640c23a62f3a-abf261f8d19mr309416066b.27.1740748876637; 
 Fri, 28 Feb 2025 05:21:16 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:c779:ac28:4c86:118c?
 ([2a01:e0a:3cb:7bb0:c779:ac28:4c86:118c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c755e0asm286076866b.133.2025.02.28.05.21.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 05:21:16 -0800 (PST)
Message-ID: <911a467a-3dbb-4a12-aa49-2aaef2094011@linaro.org>
Date: Fri, 28 Feb 2025 14:21:15 +0100
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
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <2a3e72c0-30d3-4f52-84c2-81d34b2a4286@gmx.de>
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



On 2/28/25 14:05, Heinrich Schuchardt wrote:
> On 25.02.25 17:34, Jerome Forissier wrote:
>> Implement initjmp() for Arm.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>   arch/Kconfig                  |  1 +
>>   arch/arm/include/asm/setjmp.h |  1 +
>>   arch/arm/lib/setjmp.S         | 11 +++++++++++
>>   arch/arm/lib/setjmp_aarch64.S |  9 +++++++++
>>   4 files changed, 22 insertions(+)
>>
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 8d5b54031b3..57695fada8d 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -94,6 +94,7 @@ config ARC
>>   config ARM
>>       bool "ARM architecture"
>>       select HAVE_SETJMP
>> +    select HAVE_INITJMP
>>       select ARCH_SUPPORTS_LTO
>>       select CREATE_ARCH_SYMLINK
>>       select HAVE_PRIVATE_LIBGCC if !ARM64
>> diff --git a/arch/arm/include/asm/setjmp.h b/arch/arm/include/asm/setjmp.h
>> index 662bec86321..1ad5b500f2a 100644
>> --- a/arch/arm/include/asm/setjmp.h
>> +++ b/arch/arm/include/asm/setjmp.h
>> @@ -23,5 +23,6 @@ typedef struct jmp_buf_data jmp_buf[1];
>>
>>   int setjmp(jmp_buf jmp);
>>   void longjmp(jmp_buf jmp, int ret);
>> +int initjmp(jmp_buf jmp, void __noreturn (*func)(void), void *stack_top);
> 
> As this is not a standard function we cannot expect developers to know
> what it does and how to use it.
> 
> Please, provide Sphinx style documentation with the necessary information.

I agree on principle, but if I add documentation here then I should add the
same for all architectures. That being said the prototypes are already
duplicated so maybe consolidation is a question for another time.  I will
add Shpinx style doc to all 3 commits "{arm,riscv,sandbox}: add initjmp()".

As for usage, I think the best documentation is test/lib/initjmp.c added
by "test: lib: add initjmp() test".

Thanks,
-- 
Jerome

> 
> Best regards
> 
> Heinrich
> 
>>
>>   #endif /* _SETJMP_H_ */
>> diff --git a/arch/arm/lib/setjmp.S b/arch/arm/lib/setjmp.S
>> index 2f041aeef01..320ddea85f9 100644
>> --- a/arch/arm/lib/setjmp.S
>> +++ b/arch/arm/lib/setjmp.S
>> @@ -34,3 +34,14 @@ ENTRY(longjmp)
>>       ret  lr
>>   ENDPROC(longjmp)
>>   .popsection
>> +
>> +.pushsection .text.initjmp, "ax"
>> +ENTRY(initjmp)
>> +    stm  a1, {v1-v8}
>> +    /* a2: entry point address, a3: stack top */
>> +    str  a3, [a1, #32]  /* where setjmp would save sp */
>> +    str  a2, [a1, #36]  /* where setjmp would save lr */
>> +    mov  a1, #0
>> +    ret  lr
>> +ENDPROC(initjmp)
>> +.popsection
>> diff --git a/arch/arm/lib/setjmp_aarch64.S b/arch/arm/lib/setjmp_aarch64.S
>> index 1b8d000eb48..074320d25fb 100644
>> --- a/arch/arm/lib/setjmp_aarch64.S
>> +++ b/arch/arm/lib/setjmp_aarch64.S
>> @@ -39,3 +39,12 @@ ENTRY(longjmp)
>>       ret
>>   ENDPROC(longjmp)
>>   .popsection
>> +
>> +.pushsection .text.initjmp, "ax"
>> +ENTRY(initjmp)
>> +    /* x1: entry point address, x2: stack top */
>> +    stp x1, x2, [x0,#88]
>> +    mov  x0, #0
>> +    ret
>> +ENDPROC(initjmp)
>> +.popsection
> 
