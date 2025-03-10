Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56323C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 13:48:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D59DF812D9;
	Mon, 10 Mar 2025 14:48:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w69cu3M5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C8F581417; Mon, 10 Mar 2025 14:48:35 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7467180107
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 14:48:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so3543275e9.2
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 06:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741614513; x=1742219313; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=05TFopkfb/pTjc4ok0ojW63hoEXnJPaPr615zxtSNOk=;
 b=w69cu3M5hExa1K6h89w7iZTweo0qE5oqH5uYyTvRgSt0S/Y0Q41QnPyoiv765RSxTt
 HE0mRH0oJ5sY5QkFYbw06zWzSZTUx7uNXclM2tOg6sdYysxTUfSdR+h8Ar/5LSeJEtk0
 99vU+jS2FBhsAmnfXsrto25WcAYNJShZhmOc/MrhnNGgNkxQPmh9YVrLTeBnNO4t+b6H
 /BdrKxwGh6ItdunBtNlmWxMb9ZzbPQWIjWhrLuRJ9/9PCFfJN78aOC6huWUnQSaa71JB
 SNxHyoxyzxaCRI/5kzi/fRMKlBTOYuxOZhj6RRTEj74wP1TCXLnlYCMNzJnenKXlCfUu
 abUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741614513; x=1742219313;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=05TFopkfb/pTjc4ok0ojW63hoEXnJPaPr615zxtSNOk=;
 b=D3PW/4b76FfsHe7+es/O+1oR6oeh3rXl2M4+ddOtSA8US1gdm9oyQQ8iqOZ+6imngO
 jYDXZ1TryRlo8y1uoXhKOATPotjBcOkFjK3klJixTmqAtGLboW5VJbhB3+jiqiudv3gM
 8hyFqkYnnqaAXrLS4fQxRZAMAKpAz2D40fLYP0PVBJBFYQqADpdQQAFZUCFcdnqS7jR8
 S6LVby+5DnZW8FGTXGyqtPYh1m7uEzXepguG7N4imBevtkDXWwwK6EkgPEpoQlnZqCG8
 vPt8GF5AIBcc5lOpUp1mKl9yZcOlk4jtNWBfjIJRNp9/PzpqPMq808lAZ3PBuHgy+4DV
 KorA==
X-Gm-Message-State: AOJu0YxNWrB1IunP3MN5KFOrYmv/NcNsKFF0a7vkaCCMl8SktH9daU/i
 S96G0sXCQthVXw7E44/v6pqbeyt/HIxs252IoCLhxzmDv0sSNHRsRPHOI2OOZhg=
X-Gm-Gg: ASbGnctFjlL5tHef3pNdK5m5LjGlMU9GUl666k6tnLPq+nzWzVwjgwnU8rGq36/shsS
 4u026uDWgW8EiFNcUNxaIRFkZKDuiSf3fdm7fxa3RwH7r5vQPu1H6j34ztzkhVHFUU210o63zPg
 1cI0/t9kFvUSEgSP9AiMkS33RMR+k5HVeIO6dIX2y0wBQuXgnbfhEUy9ZYlRFLxl78RPASKJb5g
 YpWsNSskvBRKWtq9wThGoKCf3lYIYXgHYRzfbVW3PCAe1yREoCRzIdchGufDzUZCWNsE4aV+YUv
 ScKZr2OtbkvVU8T9WgUAl/hT0Lw2ltUiGWFJEV9Z3CEjAFifdEZBu6KWvf84XDluxg5/o8jYxgi
 2LO4ITpKryLxtVv2z9F+MHXh/
X-Google-Smtp-Source: AGHT+IGpE69eGkWbFo5Zl3YGOEuhywaJkD40q/ubmXP23HABTAkPRpbRB71YqM8mv4hS1zMuSbNWlA==
X-Received: by 2002:a05:600c:470d:b0:43c:fab3:4fad with SMTP id
 5b1f17b1804b1-43cfab351c6mr23273175e9.16.1741614512744; 
 Mon, 10 Mar 2025 06:48:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:72e5:c885:a214:4261?
 ([2a01:e0a:3cb:7bb0:72e5:c885:a214:4261])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cf3bf0e48sm47251225e9.20.2025.03.10.06.48.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 06:48:32 -0700 (PDT)
Message-ID: <db313ea7-8132-4fdd-bd7c-6c42feb03215@linaro.org>
Date: Mon, 10 Mar 2025 14:48:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] net: lwip: add support for built-in root
 certificates
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>
References: <20250305142650.2966738-1-jerome.forissier@linaro.org>
 <20250305142650.2966738-5-jerome.forissier@linaro.org>
 <CAC_iWj+kn1Ah98XthW_kGmNQHjKy=VEL9kd+PjVKV9phwJeVcQ@mail.gmail.com>
 <4c723e83-5287-4c94-8859-e1c49d6af927@linaro.org>
 <CAC_iWjLbpU-1NW5YzxuEauAizjLS1iB_tjMiCBWu2tbjuf189A@mail.gmail.com>
 <684ad95c-eff2-4ed4-a305-670977eff7ed@linaro.org>
 <CAC_iWjLwbtqLmr71rqEuM2c01LNe09W7xVdZvT9XCH+ivsjd-g@mail.gmail.com>
 <baf67248-1d3d-4489-b900-e15b48ca4c1e@linaro.org>
 <CAC_iWj+FEusnb8jSkGSyLyjcM8ejJELtc1+swsTK6JKQ1+NG2w@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWj+FEusnb8jSkGSyLyjcM8ejJELtc1+swsTK6JKQ1+NG2w@mail.gmail.com>
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



On 3/10/25 14:04, Ilias Apalodimas wrote:
> On Mon, 10 Mar 2025 at 14:48, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>>
>>
>> On 3/10/25 13:38, Ilias Apalodimas wrote:
>>> On Mon, 10 Mar 2025 at 14:13, Jerome Forissier
>>> <jerome.forissier@linaro.org> wrote:
>>>>
>>>>
>>>>
>>>> On 3/10/25 12:52, Ilias Apalodimas wrote:
>>>>> Hi Jerome,
>>>>>
>>>>> [...]
>>>>>
>>>>>
>>>>>>>>
>>>>>>>> +#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
>>>>>>>> +       cacert_initialized = true;
>>>>>>>> +#endif
>>>>>>>>         return CMD_RET_SUCCESS;
>>>>>>>>  }
>>>>>>>> +
>>>>>>>> +#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
>>>>>>>> +static int set_cacert_builtin(void)
>>>>>>>> +{
>>>>>>>> +       return _set_cacert(builtin_cacert, builtin_cacert_size);
>>>>>>>> +}
>>>>>>>>  #endif
>>>>>>>>
>>>>>>>> +#if CONFIG_IS_ENABLED(WGET_CACERT)
>>>>>>>> +static int set_cacert(char * const saddr, char * const ssz)
>>>>>>>> +{
>>>>>>>> +       ulong addr, sz;
>>>>>>>> +
>>>>>>>> +       addr = hextoul(saddr, NULL);
>>>>>>>> +       sz = hextoul(ssz, NULL);
>>>>>>>> +
>>>>>>>> +       return _set_cacert((void *)addr, sz);
>>>>>>>> +}
>>>>>>>> +#endif
>>>>>>>> +#endif  /* CONFIG_WGET_CACERT || CONFIG_WGET_BUILTIN_CACERT */
>>>>>>>> +
>>>>>>>>  static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>>>>>>>>  {
>>>>>>>>  #if CONFIG_IS_ENABLED(WGET_HTTPS)
>>>>>>>> @@ -373,8 +401,15 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>>>>>>>>         memset(&conn, 0, sizeof(conn));
>>>>>>>>  #if CONFIG_IS_ENABLED(WGET_HTTPS)
>>>>>>>>         if (is_https) {
>>>>>>>> -               char *ca = cacert;
>>>>>>>> -               size_t ca_sz = cacert_size;
>>>>>>>> +               char *ca;
>>>>>>>> +               size_t ca_sz;
>>>>>>>> +
>>>>>>>> +#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
>>>>>>>> +               if (!cacert_initialized)
>>>>>>>> +                       set_cacert_builtin();
>>>>>>>> +#endif
>>>>>>>
>>>>>>> The code and the rest of the patch seems fine, but the builtin vs
>>>>>>> downloaded cert is a bit confusing here.
>>>>>>> Since the built-in cert always gets initialized in the wget loop it
>>>>>>> would overwrite any certificates that are downloaded in memory?
>>>>>>
>>>>>> The built-in certs are enabled only when cacert_initialized is false.
>>>>>> set_cacert_builtin() will set it to true (via _set_cacert()), so it will
>>>>>> happen only once. Note also that any successful "wget cacert" command
>>>>>> will also do the same. So effectively these two lines enable the
>>>>>> built-in certificates by default, that's all they do.
>>>>>
>>>>> Ok, so if you download a cert in memory and have u-boot with a builtin
>>>>> certificate, then the memory one will be overwritten in the first run.
>>>>
>>>> No, because the downloaded cert must have be made active via "wget cacert
>>>> <addr> <size>", which will set cacert_initialized to true, and thus the
>>>> built-in certs won't overwrite them. Or did I miss something?
>>>
>>> Nop I did, when reading the patch. But should the command that clears
>>> the downloaded cert set cacert_initialized; to false now?
>>
>> It's probably easier if it does not, so that "wget cacert 0 0" really clears
>> the certs. We have a command to restore the built-in ones ("wget cacert
>> builtin").
> 
> So right now if  a user defines a builtin cert it will be used on the
> first download.

Yes.

> If after that he defines a memory one, that will be
> used on the next download,

Yes.

> but if he unloads it shouldn't the built in
> be restired automatically?

If he unloads with "wget cacert 0 0" then it means clear certificates, so no,
the builtin should not be restored IMO. To restore them one needs to run
"wget cacert builtin".

I think it is cleaner to keep the same meaning for "wget cacert 0 0" whether or
not builtin certificates are enabled. It's a matter of consistency.

Thanks,
-- 
Jerome


> 
> Thanks
> /Ilias
>>
>> Thanks,
>> --
>> Jerome
>>
>>>
>>> Thanks
>>> /Ilias
>>>>
>>>> Cheers,
>>>> --
>>>> Jerome
>>>>
>>>>> This is not easy to solve, I was trying to think of ways to make the
>>>>> functionality clearer to users.
>>>>>
>>>>> Cheers
>>>>> /Ilias
>>>>>>
>>>>>> Cheers,
>>>>>> --
>>>>>> Jerome
>>>>>>
>>>>>>>
>>>>>>> [...]
>>>>>>>
>>>>>>> Cheers
>>>>>>> /Ilias
