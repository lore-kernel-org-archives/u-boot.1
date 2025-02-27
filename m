Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F8FC19F32
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 17:06:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C73B81280;
	Thu, 27 Feb 2025 18:05:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jBkoelWo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45D60812BF; Thu, 27 Feb 2025 18:05:33 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C9CB811C1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 18:05:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-54524740032so1147903e87.3
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 09:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740675930; x=1741280730; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sTvLkgEy7RBon+KMszr6K6AzZcpvhPcP2ii+4xs6jPY=;
 b=jBkoelWoAPSCsMhOyU0IR9gLempv0snk5TJDaB2neHH5Cr4m0ygEi/+ODumvt954H1
 uIP9DjQnNeejoXWg6d+8LTJHWIzlB8puAMAJAW7XPEwqvyEJI2liHgCK3iSckR17d7lK
 S1ciOd2cAnkFmJU+f80FGgrKbUDIW9XFjcmkE4TYcNpsA5ZhcRr0EiYTVQqoIWzTTW5D
 8xc7uWHVNmAzoCmQw/wwkB2upC3BDdwg9J1vTHQDoWvZvSipmLmu2nRTRPg7AmeJ9XWi
 c1WGcSQO3pelZ4rKMppnlkoSyeELtHw1HBCMci7zUTuq0yw+dxnXI6+e+QuYjqAjVtgA
 VUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740675930; x=1741280730;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sTvLkgEy7RBon+KMszr6K6AzZcpvhPcP2ii+4xs6jPY=;
 b=LMzirGm3GjL7eiTRFCXZfGyTpa59zRvFRy52WnaeCFxpp0Uyn+xPLsj5/WpbJ6n2KD
 syoUJTdgYTNQBnxeTK5TgwfFIFUyTqMkA+/Net94rx5IZ4qhnEKVUCcG4lnL3x4zREMd
 t/TKrjd9aSWPdOJPog7Qhj1E9WNvJp6pZnlmt8V3j7iI+Aq1hAh7n+3S9JDWbW3RGmud
 a6Ncx+MKNJkr8ckGI4Lm/dLIQsPExwhbthZ7JmmN/Gigmb/cEk+XR7N+0iG22ltrcH+x
 Sa9rvRljQDtNhP0k6UM1oIxzkFndIStAj9eLWgFxyPivlWBnVho626wADKTpchsnDZ21
 FO6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAPMZZouB3+YzMob2GBrIBPakbHZ8lP+8lLlbwn30CDKJvSuzuz6/7GOI4W9vsrxcY0jnvfHk=@lists.denx.de
X-Gm-Message-State: AOJu0YzOXdOdVS2SWLVm7+qk4gYrIvcuJcqWH2NJw0ju6uOb0Q+BP1iA
 OArCP64lxuUYm7HFDJI5hTa80SZlef70FmqnNhMyfeceLqnRpKDCHPl6K92x6Mw=
X-Gm-Gg: ASbGncsUrsO00E9Taby5XwiSxDXFzsKrgtBlBKcGDjUdJVpWNTy02lvwLP70S+YO8Bi
 GhI+rNFUOlWRusHDhaBXtig9ToKjowFm9F6Bc/M81hoCVwzx2C9cLyrQob6agfWrqJqTVbTpuPu
 mTmHo/0KD+CybzcAkePDSbAfzjYxPkJYz0Zc98Gydyxg4nQsb++0FhN2LHeiHTMYSqvsi7O7VnD
 AGN1vURX6wQGT7+32mQw0eRUt3HYi6sccabdCMRaIgNnD+Bx0rcI81ZIVxho2qwVWaurl6/Gju1
 0s+FgzEVwv6CihY7TuW2pl8fOEMV0SVSPjjgmuUn5Wq6hUGIbOV88iia80qMnoTwpQQCsh2hsjg
 52ZFmWg==
X-Google-Smtp-Source: AGHT+IHnjceeO4Ubt8euAAOJdNZXBJboeM3eb5BGhhugNLOy08llHvWE5/GjUgIB+5UnLLol4E76Ng==
X-Received: by 2002:a05:6512:a8b:b0:545:2302:6835 with SMTP id
 2adb3069b0e04-5494c107e6bmr113623e87.2.1740675929970; 
 Thu, 27 Feb 2025 09:05:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:a4a3:25fd:919c:f316?
 ([2a01:e0a:3cb:7bb0:a4a3:25fd:919c:f316])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c6ed7f1sm149728366b.120.2025.02.27.09.05.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 09:05:29 -0800 (PST)
Message-ID: <1d2680d2-aa0f-4dbd-b446-5c061cbbac36@linaro.org>
Date: Thu, 27 Feb 2025 18:05:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] cyclic: invoke uthread_schedule() from schedule()
To: Stefan Roese <sr@denx.de>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Patrice Chotard <patrice.chotard@foss.st.com>
References: <cover.1740499185.git.jerome.forissier@linaro.org>
 <f209e0a9ca2dc8687599d9938fc319779cd8e08d.1740499185.git.jerome.forissier@linaro.org>
 <25a26671-78aa-4d24-8457-aaa7008addf1@denx.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <25a26671-78aa-4d24-8457-aaa7008addf1@denx.de>
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

Hi Stefan,

On 2/27/25 13:30, Stefan Roese wrote:
> Hi Jerome,
> 
> On 25.02.25 17:34, Jerome Forissier wrote:
>> Make the schedule() call from the CYCLIC framework a uthread scheduling
>> point too. This makes sense since schedule() is called from a lot of
>> places where uthread_schedule() needs to be called.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> 
> Frankly, at first I was wondering a bit, if and why another framework
> for "multitasking" is needed in U-Boot, additionally to the cyclic
> framework that I introduced a few years ago. Which was greatly enhanced
> by Rasmus over the time. But looking at your "uthread" implementation
> it makes sense to add such a probably more intuitive interface as well.

cyclic is clean and simple and certainly well suited when introducing new
code. But when reworking older code I find it somewhat difficult to use
due to the need to keep a context and pass it everywhere. This can lead
to lots of changes when call stacks are deep.

> In general I'm really happy seeing activity in this "multitaking" area
> in U-Boot. As it brings a lot of new possibilities and, as you've also
> shown in your patchset, may greatly help reducing boot time in the
> USB example. :)

Thank you.
 
> One question though:
> Do you have some means in your uthread framework, measuring and
> perhaps limiting the time spent in these uthreads? If and how is a
> preemption of a uthread possible? So that it does not consume too
> much time resulting in e.g. things like dropping input chars on
> the prompt? Sorry, I did not thoroughly go through all your code
> to get the internals from there. It would be great if you could
> elaborate a bit on this.

That's a very valid point. The short answer is no, there is no control
over how long a thread keeps the CPU busy. uthread is similar to cyclic
in that respect. That said, I occasionally noted the issue you mentioned
about the console dropping characters, and yes it is annoying. I believe
there is a simple solution though. If we can somehow make sure we're
always scheduling the main thread every other time, we're much less
likely to starve it from the CPU, especially when many threads are
active. That is, assume we have 2 threads in addition to the main thread.
The thread list is main -> thread1 -> thread2 and uthread_schedule() will
iterate in that order. So back to main only after thread1 *and* thread2
have run and called uthread_schedule(). The idea is to schedule in a
different order: main -> thread1 -> main -> thread2 -> main etc.,
effectively giving a higher priority to the main thread (which would be
the console parsing thread).

I feel that introducing preemption would be opening a can of worms...
Because in this case we would likely need locking everywhere. Without
preemption, we still do need locking in theory, it's just that I have
not yet identified critical sections where locks would be mandatory in
the code that I have "parallelized". BTW I believe a uthread lock would
be trivial to implement like so:

struct uthread_lock {
	bool locked;
};

void uthread_lock(struct uthread_lock *l)
{
	while (l->locked)
		uthread_schedule();
	l->locked = true;
}
void uthread_unlock(struct uthread_lock *l)
{
	l->locked = false;
}

> 
> For this patch:
> 
> Reviewed-by: Stefan Roese <sr@denx.de>
> 
> Thanks,
> Stefan

Thanks,
-- 
Jerome

> 
>> ---
>>   common/cyclic.c           | 3 +++
>>   include/u-boot/schedule.h | 3 +++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/common/cyclic.c b/common/cyclic.c
>> index fad071a39c6..b695f092f52 100644
>> --- a/common/cyclic.c
>> +++ b/common/cyclic.c
>> @@ -16,6 +16,7 @@
>>   #include <linux/list.h>
>>   #include <asm/global_data.h>
>>   #include <u-boot/schedule.h>
>> +#include <uthread.h>
>>     DECLARE_GLOBAL_DATA_PTR;
>>   @@ -100,6 +101,8 @@ void schedule(void)
>>        */
>>       if (gd)
>>           cyclic_run();
>> +
>> +    uthread_schedule();
>>   }
>>     int cyclic_unregister_all(void)
>> diff --git a/include/u-boot/schedule.h b/include/u-boot/schedule.h
>> index 4fd34c41229..4605971fdcb 100644
>> --- a/include/u-boot/schedule.h
>> +++ b/include/u-boot/schedule.h
>> @@ -3,6 +3,8 @@
>>   #ifndef _U_BOOT_SCHEDULE_H
>>   #define _U_BOOT_SCHEDULE_H
>>   +#include <uthread.h>
>> +
>>   #if CONFIG_IS_ENABLED(CYCLIC)
>>   /**
>>    * schedule() - Schedule all potentially waiting tasks
>> @@ -17,6 +19,7 @@ void schedule(void);
>>     static inline void schedule(void)
>>   {
>> +    uthread_schedule();
>>   }
>>     #endif
> 
> Viele Grüße,
> Stefan Roese
> 
