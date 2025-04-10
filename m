Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EA9C369A6
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 14:04:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 059E383CF5;
	Thu, 10 Apr 2025 16:04:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HUBoDBhf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBC2A83CCF; Thu, 10 Apr 2025 16:04:45 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3BB783C2F
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 16:04:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so13833685e9.1
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 07:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744293883; x=1744898683; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wjnuXwEDKQq98BB3LCLKdHIgKcOOz5/6mt186yoluPY=;
 b=HUBoDBhfBTdoTZgZwrC8apvoOPi4e+bIX1Q2Srj//0zULas4JyN65r4fYFess3ewTb
 eUFlhegKkZVKcAeCsAAjs5n87ADjrFA7IL4kQsPOpQdjUBbm1h+TQhspd2dPEre0FCMl
 Q3dzntyR9MRAE9nYSZ+g2eQYbuAzFC9AHn+t45005EDTt7x4LFuh2Is3I9FQzaVdjgOM
 QzUVEHHipb+VJ6WkS95f8BXcT/RToW4icGwwosBLZVRtNeCkRBGywjruyL2iP9ATvNMv
 XCaCVoc+HOkbMQmdfZqEe0vDGd2186u4ztBFRmK3YRvf8iBu06Dcq0S35keQbmz068sD
 NDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744293883; x=1744898683;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wjnuXwEDKQq98BB3LCLKdHIgKcOOz5/6mt186yoluPY=;
 b=oPt7JAp3YQatkb3ZTuJuVmSr6fXM6TDxOOU/wv/rdc8CJHwN8Zw0ALM0ZfR/8WG6pq
 Urak7n75RN2beerMx4QwaKweTzJkqe7vKSmMCNZvFVR2dMz19GVjCqc8rqgJWWLJgagj
 kklm+8H/tDm1+KfFKI9EgUGG88U254BXn9r1COz7incz2uwjr7BGaCktfN9ipARVb6LT
 9uyaMsVwYCuWOx9cNNgKNiqqv9n6OuNYcTlb8ot9ystykvNeRhm0feTWO2hv8PQCNQP5
 3uNYRabEPTQDpEIVNvFXV5Z7ncUdiGt77HYJvBq1qCwwsEDWEuvO+rkjQ6BfxW8MOz+2
 YAYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVebWOoNWPoJFYGpjotaSKafsKZk/wOg7u9JQ/1rgnet97ikFBzXjkPf+axhF1H+4DzTTlqB0=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/m3yvX5XQE+RprdDFp0lxhhzp3yvs3pQ8chJTvvwOz8WmVCea
 h4r7KAZcQ/a76bsGULI1Oga6wnn5oopb5JEQFlGbxPvR+mfxwurXTiJBl9a3fo0BF4NKDdzloR2
 1SFc=
X-Gm-Gg: ASbGncsSIVo1+IBPjX0AhGKrnIkPEavhGCmAKe0jE4NjThiNQf1MEC1x6RfoqB90ohp
 gx86R08Vliht0vJaiX2SK6zk8HfuY1VABvYJyzxEfY9MBV0I1fjsmh5JzGrkivN5qfkeJcpaQ1Q
 i4nLJ+q5h5zUMoMsGZymzQwkT0Drlrq598wLd5DL24eho2k3AaNB2h2JmZkePt6SAfDj4Vtulsl
 v1rQbn2Ky8bm2P1LEqbT2czV/qdSb+PAiNECAux4qUvzTV1xKFZhoF9Nps136HTUs1wV0oK5MP0
 4i6MYVFyo9lV9PAMnGBhFgifh+xq3HStWQTVwODNbafoA3x8Rp3TuFWb7n+xrd56Uko1
X-Google-Smtp-Source: AGHT+IHdU8z3WdjdgM1lD0GPjSs7OMoRWbW+YhaUZXG/wJAqOwxA7vL+yPHE/LbE4ZDJnjYU6D5vfA==
X-Received: by 2002:a05:600c:350b:b0:43b:c7f0:6173 with SMTP id
 5b1f17b1804b1-43f2f0283cemr25668155e9.4.1744293882830; 
 Thu, 10 Apr 2025 07:04:42 -0700 (PDT)
Received: from [192.168.1.47] (i5E863B08.versanet.de. [94.134.59.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f20a303absm39494885e9.1.2025.04.10.07.04.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 07:04:41 -0700 (PDT)
Message-ID: <6e9bb23d-566f-4047-8d02-58dc6170fb5c@linaro.org>
Date: Thu, 10 Apr 2025 16:04:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] event: signal when livetree has been built
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
 <20250409-livetree-fixup-v1-1-76dfea80b07f@linaro.org>
 <CAFLszTjLGv0a3W=hPW+pexa1ASaSrrKAcbRoo5cF_LChj-bizA@mail.gmail.com>
 <d807638b-c6ac-429f-b177-ce9427b504f6@linaro.org>
 <CAFLszTgEGd1hHS7D6C_Y8RMrkQ8k_+UgzvZO2zE6rhBizSQXBQ@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszTgEGd1hHS7D6C_Y8RMrkQ8k_+UgzvZO2zE6rhBizSQXBQ@mail.gmail.com>
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



On 4/10/25 15:07, Simon Glass wrote:
> Hi Caleb,
> 
> On Thu, 10 Apr 2025 at 07:00, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> Hi Simon,
>>
>> On 4/10/25 13:27, Simon Glass wrote:
>>> Hi Caleb,
>>>
>>> On Wed, 9 Apr 2025 at 11:17, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>>>
>>>> OF_LIVE offers a variety of benefits, one of them being that the live
>>>> tree can be modified without caring about the underlying FDT. This is
>>>> particularly valuable for working around U-Boot limitations like lacking
>>>> USB superspeed support on Qualcomm platforms, no runtime OTG, or
>>>> peripherals like the sdcard being broken (and displaying potentially
>>>> worrying error messages).
>>>>
>>>> Add an event to signal when the live tree has been built so that we can
>>>> apply fixups to it directly before devices are bound.
>>>>
>>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>>> ---
>>>>    common/event.c  | 3 +++
>>>>    include/event.h | 9 +++++++++
>>>>    lib/of_live.c   | 3 +++
>>>>    3 files changed, 15 insertions(+)
>>>>
>>>> diff --git a/common/event.c b/common/event.c
>>>> index dda569d447851f559a83f98fb7b1f3543156eab5..8d7513eb10b61919e1e784481dfdcc076be14986 100644
>>>> --- a/common/event.c
>>>> +++ b/common/event.c
>>>> @@ -47,8 +47,11 @@ const char *const type_name[] = {
>>>>           "ft_fixup",
>>>>
>>>>           /* main loop events */
>>>>           "main_loop",
>>>> +
>>>> +       /* livetree has been built */
>>>> +       "of_live_init",
>>>>    };
>>>>
>>>>    _Static_assert(ARRAY_SIZE(type_name) == EVT_COUNT, "event type_name size");
>>>>    #endif
>>>> diff --git a/include/event.h b/include/event.h
>>>> index 75141a192a48b0931667632f41be8ff4d6139f7c..3fc673ba635ed45467aae8587705d37bef1c2a3f 100644
>>>> --- a/include/event.h
>>>> +++ b/include/event.h
>>>> @@ -152,8 +152,17 @@ enum event_t {
>>>>            * A non-zero return value causes the boot to fail.
>>>>            */
>>>>           EVT_MAIN_LOOP,
>>>>
>>>> +       /**
>>>> +        * @EVT_OF_LIVE_INIT:
>>>> +        * This event is triggered immediately after the live device tree has been
>>>> +        * built. This allows for machine specific fixups to be done to the live tree
>>>> +        * (like disabling known-unsupported devices) before DM init happens. This
>>>> +        * event is only available if OF_LIVE is enabled and is only used after relocation.
>>>> +        */
>>>> +       EVT_OF_LIVE_INIT,
>>>> +
>>>>           /**
>>>>            * @EVT_COUNT:
>>>>            * This constants holds the maximum event number + 1 and is used when
>>>>            * looping over all event classes.
>>>> diff --git a/lib/of_live.c b/lib/of_live.c
>>>> index 90b9459ede313e492e28c8556c730f3bd8aaa9df..e1962b8f1fb9d8c2c87d04ca4e238a1e4d00376a 100644
>>>> --- a/lib/of_live.c
>>>> +++ b/lib/of_live.c
>>>> @@ -10,8 +10,9 @@
>>>>
>>>>    #define LOG_CATEGORY   LOGC_DT
>>>>
>>>>    #include <abuf.h>
>>>> +#include <event.h>
>>>>    #include <log.h>
>>>>    #include <linux/libfdt.h>
>>>>    #include <of_live.h>
>>>>    #include <malloc.h>
>>>> @@ -334,8 +335,10 @@ int of_live_build(const void *fdt_blob, struct device_node **rootp)
>>>>                   return ret;
>>>>           }
>>>>           debug("%s: stop\n", __func__);
>>>>
>>>> +       event_notify_null(EVT_OF_LIVE_INIT);
>>>> +
>>>
>>> This should go in initr_of_live() since the function you are dealing
>>> with here is supposed to just do the live build.
>>
>> Well, we only every call this function from one place right now, but if
>> it was called multiple times for some reason then I would want to be
>> able to re-apply fixups to the new live tree.... I guess it should
>> probably pass in *rootp to the event handler, let me rework that.>
> 
> There's no need to change the root, so what you have is find here.
> 
>>> Same for the EFI_STUB thing which I just noticed, actually
>>
>> what EFI_STUB thing?>
> 
> Oh, it's your EFI stub patch which isn't in Tom's tree yet. Just for
> when you get to it, then.
> 
>>> Also please check for error
>>>
>>> Otherwise this seems OK to me. I do wonder why we can't use
>>> EVT_FT_FIXUP though. Could you add mention of that to your comment in
>>> event.h?
>>
>> Because FT_FIXUP is for fixing up the flat tree before starting the OS?
>> these are obviously different things imo, im not sure how i could
>> clarify this.>
> 
> Well, what is the purpose of your code? Are you saying that it is used
> within U-Boot, but not passed to the OS?

Yes, please read the cover letter and commit messages. FT_FIXUP allows 
for the FDT that is about to be passed to the OS to be fixed up, 
OF_LIVE_INIT signifies that U-Boot has finished building it's livetree. 
The livetree is obviously not used outside of U-Boot, being a totally 
custom in-memory representation of the DT.

> 
>>>>           return ret;
>>>>    }
>>>>
>>>>    void of_live_free(struct device_node *root)
>>>>
>>>> --
>>>> 2.49.0
>>>>
> 
> Regards,
> Simon

-- 
Caleb (they/them)

