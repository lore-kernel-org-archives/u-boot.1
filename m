Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6479C021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 13:10:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBCB780104;
	Mon, 17 Feb 2025 14:10:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rYPpslqv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7815807F1; Mon, 17 Feb 2025 14:10:35 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82DF180017
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 14:10:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38dcac27bcbso3250976f8f.0
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 05:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739797833; x=1740402633; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=awmF4eiEfBmhrYueFdzAV3/uovSIE9LG+CLQjKKx5oI=;
 b=rYPpslqvYyqyulsErej/658l0JTuw8NE4wplIDSNKXjhWHqRk3k5jxP5nICStczgIm
 4eb1Gb5hzWEhwh/Ga4wQpXG6jrEcw3lg2rHsqjyhSgG8Zwm9ecMirq+Uftj2dw+xdrve
 1f9c5SKnW8d/EWa0IAVuSZDfnpptPNLrdCLjcsVwKgQCUmcmEbqCkI/U/mrWV2uyqyvv
 mfyoigb+60qzz5wLHQRrsj69zLbsDCzeY9KjBXkvF/pi5F5zYBKylf2J9MCmW4FfaGo7
 8jj5jJ6x0PseRllnQLyMMKyzf0TAlsCWBApdRugUZFcwKN8jyBrGE8LD9zKL0wgtLKbd
 5h2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739797833; x=1740402633;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=awmF4eiEfBmhrYueFdzAV3/uovSIE9LG+CLQjKKx5oI=;
 b=sZ026I04oSBCC0wkN+mJm6PIRdbycXFWJrgpFO8P58LzMFHUmmDU6UO03MDhgk6rdi
 flujCAR7TKrF/yEb9Rk4LQN6optzQZxbk7VGa7m+0bdDe+wbJxKjhWMX5hbpmkxjrxFx
 HqTN46nfI79ICc50HeK0FWWSXBzFUED18UhO9Q/tW6KGSAUGPNTEeisxBOXgA9NNsR9j
 MGTNjXqE8EljBEE1yEhz3425RgZHeFHX0beGuqAPntW+ZD9rDqUPkomalIQWJQuKbj0i
 +8tB8wJz7F8xTo+wsr4qnZMh4n+YfgzGnD/mLGjtgCJWT8F7T/Re4g1o+bcyqWOZwoJU
 k1Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfkgSe7+iXd+dcqFH7HC+IKXW4JOydFCclMq6QUI3chSg2oKfiR66uqJY2Vw8QsgU7M9ZefRI=@lists.denx.de
X-Gm-Message-State: AOJu0YwnNeJE8ttM5V9j/gGKPBCRePZ5KshumIYiunoEQTvM4oSPDcvJ
 pa1qV6OWtIERole0lAl8JFNG8805jtwyex1rBZCkUVWbMnUrC97f3oZcQ5Ywm4A=
X-Gm-Gg: ASbGncvZhXEz7Hz1vos3Sj3TIIGCe3/+/D1CcKZtlpbS3oq73JU3O5UiHyNq8T5ap4p
 Bqj7lcDFueUQ4PXYx7jD9cE9/wgEGkVgugxwtTPcvqJQZEKjaFTmA8cjh0MzfAubvysZh1XhO2A
 Uz8xTkYV6JBHDyrymAxC6GjEVGBzPKi2boiiMM4PxaKcSYiM6hH8LrzNuhiR1IMcsqcCIAP13KA
 Zz4LTwDpcAoofIyD8AVfxYJ6i3JJ+ECJb7Zf0TeoeffUEG4BUdr4jUqcJJ39DUa+vni8KHWzCaw
 vdL+XcoyCUIUCoQs1xe4VU3xPXmE4xMUCWuia7iBSBUKye3r6/2qeb5Aa++GJJ4lKQIukgQ=
X-Google-Smtp-Source: AGHT+IGCm1r/Oz6+Tr9TPMalHMK8sj09cKRBYpTULoXQNrAydZuMiC6hPgC+5ejiTIGTMb5gXrE+Xg==
X-Received: by 2002:a05:6000:1865:b0:38f:4ca6:5fc6 with SMTP id
 ffacd0b85a97d-38f4ca660b3mr1465554f8f.14.1739797832910; 
 Mon, 17 Feb 2025 05:10:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:ca57:a43a:4f8f:ebba?
 ([2a01:e0a:3cb:7bb0:ca57:a43a:4f8f:ebba])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43986b475ffsm21986995e9.17.2025.02.17.05.10.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 05:10:32 -0800 (PST)
Message-ID: <60e8252d-baba-4d36-a41d-f07f04dec860@linaro.org>
Date: Mon, 17 Feb 2025 14:10:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/10] arm: add initjmp()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Simon Glass <sjg@chromium.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
References: <20250214140031.484344-1-jerome.forissier@linaro.org>
 <20250214140031.484344-3-jerome.forissier@linaro.org>
 <67029ea6-5629-443d-928b-86578df8df6c@gmx.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <67029ea6-5629-443d-928b-86578df8df6c@gmx.de>
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



On 2/14/25 15:35, Heinrich Schuchardt wrote:
> On 14.02.25 15:00, Jerome Forissier wrote:
>> Implement initjmp() for Arm.
> 
> Could you, please, describe in the commit message what initjmp() good
> for and why it is needed and why it would not be needed for any other
> architectures but ARM.

Sure. If you don't mind, I will update the commit message of "arch:
introduce symbol HAVE_INITJMP" rather than this one, to avoid duplication
for each architecture. I mean, if I update "arm: add initjmp()" then why
not "riscv: add initjmp()".

> 
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
> 
> Please, always provide a Sphinx description for any new function.

Will do in v2.

> 
> Best regards
> 
> Heinrich
> 
>> +int initjmp(jmp_buf jmp, void __noreturn (*func)(void), void *stack_top);
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

Thanks,
-- 
Jerome
