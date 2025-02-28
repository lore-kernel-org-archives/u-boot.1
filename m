Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA633C282C1
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 14:45:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C816809A5;
	Fri, 28 Feb 2025 15:45:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YkMfiyK0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F02F80FE1; Fri, 28 Feb 2025 15:45:07 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 564DC807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 15:45:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5e4ad1d67bdso3285690a12.2
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 06:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740753905; x=1741358705; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z2hCZiuDVluWPC8npqUOC7t/oKF8IfhRkg4DSvLNf9E=;
 b=YkMfiyK0weZnlxr8+AZVlvfTFafjcyn95KW1U0OTHREQw2m/ngZtwUwUJQ6KyGQ6gg
 J0wpQxCZPzMzHOAMVThFO9Z7EFVQ6VsuRuYPwfAdkX2YVcEMAZyTglDE/2ttlN3hj1hp
 JA15e7KEG/R38wxRTlYXrfATdDeTj9t2wwHO2eai2r0Iuh1sc0NCQJkxTo2L4q+mUA74
 8JgSKhi/MB0FqoaTVAcNNPwEpFzAhvNHKIn3cppozDhQKAsqjm2WpQmzcuE2jw8Brp15
 8fvfoMNiX5/8Enk4N9X44Qq9bijxERBJPPtfKVU2FpgKssJh6opPEd6QdzgicOppA0sx
 cFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740753905; x=1741358705;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z2hCZiuDVluWPC8npqUOC7t/oKF8IfhRkg4DSvLNf9E=;
 b=Yzjmp+RFdmL8XiuW6QNeJfCIAPMWe3EHnPuRzZa4QFBw+TMQKEVxOVKLX12Uggf0nF
 RAUrmm+rehIPzc9f8cN4PGj+Tc4kwccCH3kPWhsAYwyPUNy5zS0CPxxXubJLe3iHTf5f
 N9upYA6P5ni1CVUuZWB6xsAd7/67zNJuURynHb9TC1dA9ZN16cYAkuNYgnwEA3Z+K5OV
 k+byHWHaM84qFDkUgERjpe/M3VIpQwlULyDZS/VApCSjsDdAo9VriBfn48Dzm7NTdtmb
 eFla6XKsZ7nrNgFoAjKxG4yaLGeftGzA2AvZp8tLyTR13pNka7YW/VODRVXnlPu9dH5d
 fEmw==
X-Gm-Message-State: AOJu0Yx/Jr1VWVj9ZeXLV+M8wSk1q0ccdcOTq5lxV+5KNJwQlxq55O83
 m0hVgtXUmnGHClK4lcQ7DsoUkT538dQlsnk1Tgxrx0pYZSDwrw1q00ClOUR77upqIFc502mBq7h
 oW3A=
X-Gm-Gg: ASbGncuIjm0fJ1sGq5IRNYDuXuOiLgd2/ZIk2IXU7V5RKjnWIPWH2/XiA54uCuP78ND
 sMQ7l2ro6BH7Ciyrsu4bjybllXLcDB/KrRYlpVd9YDK6OEBfx/VPeChhP8SaasbTyjwelC0EH35
 LnAMeuRV3Nlvv+T9jNvjUMhKtUt4wYoAro0Vy1KSUzfHMKln75+xdGFbSpeXPnSpYANCUIFT2F8
 VY6fdrJWbkBNoL3YJpsXksdBrFb9k6Jf5GYVJHvXfTuBu0qjh1CHBluSbgjVXmkR4HtNugR6IjR
 zhDcBmM/T2oyKWfgsTgvhjQkg5+armmdGGZoH8gQBunBnwvb18kPnJQYDoM/WbQCZ7mY8gWyR5l
 bG7hJJw==
X-Google-Smtp-Source: AGHT+IFtmtyu5/HthP0iDbnxwG5U0zCxhj2xMeHOj3kT371DBPGxMPsVi+569BeAIc/9i+RGG615hg==
X-Received: by 2002:a17:906:da88:b0:ab7:851d:4718 with SMTP id
 a640c23a62f3a-abf265a306emr452530466b.36.1740753904731; 
 Fri, 28 Feb 2025 06:45:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:c779:ac28:4c86:118c?
 ([2a01:e0a:3cb:7bb0:c779:ac28:4c86:118c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c0b9a90sm297743666b.34.2025.02.28.06.45.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 06:45:04 -0800 (PST)
Message-ID: <848a4afd-288e-4367-8fff-8e5527c8f6d2@linaro.org>
Date: Fri, 28 Feb 2025 15:45:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] lib: time: hook uthread_schedule() into udelay()
To: Yao Zi <ziyao@disroot.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
References: <cover.1740499185.git.jerome.forissier@linaro.org>
 <f9568a6c5140b99cbd5b48de21f4d5b12a76d92e.1740499185.git.jerome.forissier@linaro.org>
 <CAC_iWjLtTzCAqR_aq6Q1kBEn=E3oQoCDuvxWAnfrT6R=KCgSeQ@mail.gmail.com>
 <Z8HFRuCH8TQWC7Pw@pie>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <Z8HFRuCH8TQWC7Pw@pie>
Content-Type: text/plain; charset=UTF-8
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



On 2/28/25 15:16, Yao Zi wrote:
> On Fri, Feb 28, 2025 at 03:38:22PM +0200, Ilias Apalodimas wrote:
>> Hi Jerome,
>>
>> On Tue, 25 Feb 2025 at 18:35, Jerome Forissier
>> <jerome.forissier@linaro.org> wrote:
>>>
>>> Introduce a uthread scheduling loop into udelay() when CONFIG_UTHREAD
>>> is enabled. This means that any uthread calling into udelay() may yield
>>> to uthread and be scheduled again later.
>>>
>>> While not strictly necessary since uthread_schedule() is already called
>>> by schedule(),
>>> tests show that it is desirable to call it in a tight
>>> loop instead of calling __usleep(). It gives more opportunities for
>>> other threads to make progress and results in better performances.
>>
>> Some examples of timing gains would be nice.

I'll try to provide numbers in v3.

>>
>>>
>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>> ---
>>>  lib/time.c | 10 +++++++++-
>>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/lib/time.c b/lib/time.c
>>> index d88edafb196..d1a1a66f301 100644
>>> --- a/lib/time.c
>>> +++ b/lib/time.c
>>> @@ -17,6 +17,7 @@
>>>  #include <asm/global_data.h>
>>>  #include <asm/io.h>
>>>  #include <linux/delay.h>
>>> +#include <uthread.h>
>>>
>>>  #ifndef CFG_WD_PERIOD
>>>  # define CFG_WD_PERIOD (10 * 1000 * 1000)      /* 10 seconds default */
>>> @@ -197,7 +198,14 @@ void udelay(unsigned long usec)
>>>         do {
>>>                 schedule();
>>>                 kv = usec > CFG_WD_PERIOD ? CFG_WD_PERIOD : usec;
>>> -               __udelay(kv);
>>> +               if (CONFIG_IS_ENABLED(UTHREAD)) {
>>> +                       ulong t0 = timer_get_us();
>>> +                       while (timer_get_us() < t0 + kv)
>>
>> Do we make progress by constantly scheduling new tasks? Perhaps we
>> should at least leave the task running for some time?
> 
> If I get the point, the UTHREAD is a cooperative framework, which means
> a task yields the control flow only when it considers nothing else could
> be done. And there's no preemption (at least in this revision). Thus I
> don't think it's a problem.

That's correct. Code always executes uninterrupted until it reaches
uthread_schedule().

Thanks,
-- 
Jerome

> 
>> Thanks
>> /Ilias
> 
> Best regards,
> Yao Zi
> 
>>> +                               uthread_schedule();
>>> +               } else {
>>> +                       __udelay(kv);
>>> +               }
>>>                 usec -= kv;
>>>         } while(usec);
>>> +
>>>  }
>>> --
>>> 2.43.0
>>>
