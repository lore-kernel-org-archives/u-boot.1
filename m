Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEB7C02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 15:04:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3980F80B98;
	Fri, 14 Feb 2025 16:04:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WQ5LRcPM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D12780C7E; Fri, 14 Feb 2025 16:03:59 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B109B80756
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 16:03:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5dcdb56c9d3so3202014a12.0
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 07:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739545436; x=1740150236; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W3FEzsDl37swl3wqJtiR7Zw6AsT/PmlF84c7fNqWSOc=;
 b=WQ5LRcPMAlwYwX77mFu+NqbHNt/RLcPuXq+j1IdTqJJexf3GO3yMVFyywNARv9Shdj
 1DokgMMKzxUAxvKc7L1wtIgkeFa+zIif+yCyV6KF+6oagHwxa4JxxJo87GVEnhEn/e4d
 lI1GFRTn/QNEHkcMsniw245bZYHfx7+u6fBx6fPBbcExhPqT6eNw3nY6aVdv/ggu0qzi
 j/fxGZZF310MQwY7Xx7+Y4WpkwKO55EENjDBNMNVm2kM/fvOcXIWgAOc+Zr4Qzsu5toZ
 45W/57Jm2KjmGpmfbwZuTYnZ2g9N2JWlEs3wQO0NLye+leK0z2oDNsjtrJSGoiazGYei
 uQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739545436; x=1740150236;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W3FEzsDl37swl3wqJtiR7Zw6AsT/PmlF84c7fNqWSOc=;
 b=RNC+lYx3IkzgJUIszRLJVkDkz3SnLr4ICq22E/iAl9HM/AB7Oatfe2tg5ywOU6gZFL
 JS3rzSH3AXt/O5zPaQ2E2Ckp0aXV6WM5ADHMAtNpe10sP3z4cGpslwnwWhgSTi9ADr3S
 fH+oScRT9VeLuP50iE0IVoTFnn42GpD87NLMWIKn1s03wyPj8xky7MNSKtgIORKRJwNb
 9Gwk1xQsCzvbLKxBs/fEIsSmEVoI62kGF+/nVcNDZMvDbO9+28pLbl14uKxzR3gz5WuW
 T2LvDhv4Q6rLNc1yZQO1ZGh75SbJ1za3P8/AcNLM1iL+QMF9swVA5Pde1NZEH8zRActz
 S8NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6zsZ8Jn2EOMww7eFDRDPIzcb4punX3uFiXn5JvBERt61JYPXCEJDVBUEAd9x9rgXg3t8sTjs=@lists.denx.de
X-Gm-Message-State: AOJu0YyIR85Q4OKwbGRZBF1beSwIRI7F9aVURLTwycxv4OirTBPflx8N
 geJVSpjCIo86uklBLXz6XWyywTLYlN0tuJHeUkrecCqHHzajjzNgHFaLbcOOgW4=
X-Gm-Gg: ASbGnctx3Ii18RpGpOhHP10gywtYBoxLuex6PCaZCFgjs7bWnI1DD37nJvE6rWqBjHR
 kmtf136G4odOo2PejPym4Nv6zone9rbtFuQSwJ/Zl7M/bwjuSpDyLWHh0A7tR28yVpRrTQZGfLq
 rurn4X/FVwe3c7uOWJSJXT0GsSwgzyTcJM9MRO/4WPhtA+E7aFF6p7X2kQmK2x/ixzCLkNILaSm
 EkZ4XGzZFUNuC6hJ0Ed7Ez6sUz0VMN4HETIhvXrT6M1zalaGbRjMCjI9mCUNlKvHHCc507r2LSc
 CyChcGOKthK3DP7y3LwOnR34G8xexDA6erT+O0KB9JOIOSUhQFDcgI2lDy6SW6fwWgtdNH8=
X-Google-Smtp-Source: AGHT+IH0njJtXGz5bALUBBp3CBGvhOrd9c1mJn9pyKLRh+Pfn76whGBUgcJP72ENoUEazhK+wDh/mQ==
X-Received: by 2002:a05:6402:35cb:b0:5dc:9589:9f64 with SMTP id
 4fb4d7f45d1cf-5dec9d3b932mr17451431a12.13.1739545429754; 
 Fri, 14 Feb 2025 07:03:49 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:267e:7d32:f6a8:d8bf?
 ([2a01:e0a:3cb:7bb0:267e:7d32:f6a8:d8bf])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dece1d48c5sm3167969a12.47.2025.02.14.07.03.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2025 07:03:49 -0800 (PST)
Message-ID: <89249ee4-a3b6-4080-992c-8a3000e78fc3@linaro.org>
Date: Fri, 14 Feb 2025 16:03:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/10] arch: introduce symbol HAVE_INITJMP
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de
References: <20250214140031.484344-1-jerome.forissier@linaro.org>
 <20250214140031.484344-2-jerome.forissier@linaro.org>
 <8821a103-50b2-48c1-b919-4a0462f02e6a@gmx.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <8821a103-50b2-48c1-b919-4a0462f02e6a@gmx.de>
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

Hi Heinrich,

On 2/14/25 15:41, Heinrich Schuchardt wrote:
> On 14.02.25 15:00, Jerome Forissier wrote:
>> HAVE_INIJMP will be set by architectures that support initjmp(), a
>> non-standard extension to setjmp()/longjmp() allowing to initialize a
>> jump buffer with a function pointer and a stack pointer. This will be
>> useful to later introduce threads.
> 
> How is initjmp() used in threading?

It's used so that we can longjmp() to a particular function pointer
(rather than to a point previously reached during program execution
as is the case with setjmp()), and with a custom stack. Both things
are needed to spin off a thread.

I will update the description.

> 
> A cover-letter for the series would have been helpful.

It's here [1].

[1] https://lists.denx.de/pipermail/u-boot/2025-February/580550.html

> 
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>   arch/Kconfig | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 35b19f9bfdc..8d5b54031b3 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -13,6 +13,12 @@ config HAVE_SETJMP
>>       help
>>        The architecture supports setjmp() and longjmp().
>>
>> +config HAVE_INITJMP
>> +    bool
>> +    help
>> +     The architecture supports initjmp(), a non-standard companion to
>> +     setjmp() and longjmp().
> 
> If this required for thread support, I would have expected this to be in
> the help text.
> 
> Best regards
> 
> Heinrich
> 
>> +
>>   config SUPPORT_BIG_ENDIAN
>>       bool
>>
> 
