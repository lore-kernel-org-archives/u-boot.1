Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC26C28B2E
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 12:48:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D24080107;
	Mon, 10 Mar 2025 13:48:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pmKcEucc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CCAF811C1; Mon, 10 Mar 2025 13:48:46 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19FA08003E
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 13:48:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so2422295e9.2
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 05:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741610923; x=1742215723; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mx3e016/rMGAOvBG3f0wwZ452Zvfwf6VnZ42wtjNEaU=;
 b=pmKcEucc7LaVWAeDuG8NPZ7AMMA3EjfOIuRvw77N+zVqngevTUo/6StMciG4FXCqR3
 Oaga7f6L1LMnMv8Fh2FjZt09dsLhOYqDDQ9JNqdozMteR6C1O+oPAjcJ3uWW9rDi97YH
 jGUz4CR2k57VA85E62xOhQWmBdFJziAqpNBZUUWhJs+rwshB5mLw+TWLvQ5K9XaC2qNj
 jAg6HHV07DSg71fJ28zazmoyqH/xdJfIDp0UlxRNN9xRO8DhT/Wjk07cXjf8fIQr4xA8
 103Pd6ZAsOdi0WvFsKsQWKUqWOPC3Be+HYA2bXWTKJIiH0lngc2EaWzNF1EKlQfKsl0m
 1p3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741610923; x=1742215723;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mx3e016/rMGAOvBG3f0wwZ452Zvfwf6VnZ42wtjNEaU=;
 b=vGe833wzfDmDOYGJGnj7whWpQ4bcrFgf56h0MDvieVxot+9MFSa9RAriQul0plLFSX
 MdMTs/fNWt3DwAYwMwIQLvwMU5njBTJAgU1EWb6rE0fHLD+XT/xSRo+JrVVCQDHOKR6D
 2UkQmcwwwLOC/H3MI+02W+8Rf9ykxsSiY1iwEbxfjQyxbNMG4qbZQdcr+6UjEgSRFEKL
 telu+XOiUTl4lOxvkDRgdfHv3cJ7FTXA3ggyCV5C3qn7DsVLc/eF/Y+cvwwUDseEAIrn
 YcRsZBV7EoG++eSNZObqq95DD4FLMpcfVddL0wrlW2Kyba133/aU7VKwrf47GvQoxXX2
 Q7eQ==
X-Gm-Message-State: AOJu0Yz9yKj9mrFYKzXFOH9hnGx03gmJuR0Lfhm6I2CtIeWKaDAFTQPs
 WAjHYe/6ZBbcIqg6B8tvdc/ZnSbCof7uiYDB7qrKoTVGsGjjHj298A3uIBo7VTs=
X-Gm-Gg: ASbGncuY7qKag40pd7VSFLkOVKEMUkVC8Pua9S3BAG4wAvNRn7XeRIJ0bzB5RPPJ0z5
 wilUIqeVhtn9vL9Qvfq1AqicZlO2kYAL+uFVUYEJc3/ROW6boA3LzysOJMr9twsHPlV8VBXynqo
 It0qLpiltl8i88TSC0d2Qv3y7vxrLs6f2nX5ZYYvewe0c+0bLP7adCVhr6sf/SqJeQznzRuy5CV
 R0S2Ik9eCg9DnqZ1y6MFJ/Klk7jCe0lp57Wbtf7VypFIbCdz+QRnooURaX0JDwfbcoZZTi/ZPXB
 T0jQBB/6GUs9zIyPyWCyZuOQ/NmOUw9v9fWFRQBAvK45JNHRqmXueT+AbFoGw0ttiU840n5i1Hf
 TtmZ5IxEhPQ3BP8s3gkMVqQPtYrZe5of3Mv4=
X-Google-Smtp-Source: AGHT+IHIBhA7RPT4wUD1z4lrS6bzTwlqkjNMgP76KL1QP08e7bItYy0FBYd3+ZLcN8922+2nGnWuTQ==
X-Received: by 2002:a05:6000:402a:b0:391:2dea:c9a5 with SMTP id
 ffacd0b85a97d-39132d6b61cmr8578104f8f.20.1741610923497; 
 Mon, 10 Mar 2025 05:48:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:72e5:c885:a214:4261?
 ([2a01:e0a:3cb:7bb0:72e5:c885:a214:4261])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01cdd7sm15094145f8f.56.2025.03.10.05.48.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 05:48:42 -0700 (PDT)
Message-ID: <baf67248-1d3d-4489-b900-e15b48ca4c1e@linaro.org>
Date: Mon, 10 Mar 2025 13:48:41 +0100
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
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWjLwbtqLmr71rqEuM2c01LNe09W7xVdZvT9XCH+ivsjd-g@mail.gmail.com>
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



On 3/10/25 13:38, Ilias Apalodimas wrote:
> On Mon, 10 Mar 2025 at 14:13, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>>
>>
>> On 3/10/25 12:52, Ilias Apalodimas wrote:
>>> Hi Jerome,
>>>
>>> [...]
>>>
>>>
>>>>>>
>>>>>> +#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
>>>>>> +       cacert_initialized = true;
>>>>>> +#endif
>>>>>>         return CMD_RET_SUCCESS;
>>>>>>  }
>>>>>> +
>>>>>> +#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
>>>>>> +static int set_cacert_builtin(void)
>>>>>> +{
>>>>>> +       return _set_cacert(builtin_cacert, builtin_cacert_size);
>>>>>> +}
>>>>>>  #endif
>>>>>>
>>>>>> +#if CONFIG_IS_ENABLED(WGET_CACERT)
>>>>>> +static int set_cacert(char * const saddr, char * const ssz)
>>>>>> +{
>>>>>> +       ulong addr, sz;
>>>>>> +
>>>>>> +       addr = hextoul(saddr, NULL);
>>>>>> +       sz = hextoul(ssz, NULL);
>>>>>> +
>>>>>> +       return _set_cacert((void *)addr, sz);
>>>>>> +}
>>>>>> +#endif
>>>>>> +#endif  /* CONFIG_WGET_CACERT || CONFIG_WGET_BUILTIN_CACERT */
>>>>>> +
>>>>>>  static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>>>>>>  {
>>>>>>  #if CONFIG_IS_ENABLED(WGET_HTTPS)
>>>>>> @@ -373,8 +401,15 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>>>>>>         memset(&conn, 0, sizeof(conn));
>>>>>>  #if CONFIG_IS_ENABLED(WGET_HTTPS)
>>>>>>         if (is_https) {
>>>>>> -               char *ca = cacert;
>>>>>> -               size_t ca_sz = cacert_size;
>>>>>> +               char *ca;
>>>>>> +               size_t ca_sz;
>>>>>> +
>>>>>> +#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
>>>>>> +               if (!cacert_initialized)
>>>>>> +                       set_cacert_builtin();
>>>>>> +#endif
>>>>>
>>>>> The code and the rest of the patch seems fine, but the builtin vs
>>>>> downloaded cert is a bit confusing here.
>>>>> Since the built-in cert always gets initialized in the wget loop it
>>>>> would overwrite any certificates that are downloaded in memory?
>>>>
>>>> The built-in certs are enabled only when cacert_initialized is false.
>>>> set_cacert_builtin() will set it to true (via _set_cacert()), so it will
>>>> happen only once. Note also that any successful "wget cacert" command
>>>> will also do the same. So effectively these two lines enable the
>>>> built-in certificates by default, that's all they do.
>>>
>>> Ok, so if you download a cert in memory and have u-boot with a builtin
>>> certificate, then the memory one will be overwritten in the first run.
>>
>> No, because the downloaded cert must have be made active via "wget cacert
>> <addr> <size>", which will set cacert_initialized to true, and thus the
>> built-in certs won't overwrite them. Or did I miss something?
> 
> Nop I did, when reading the patch. But should the command that clears
> the downloaded cert set cacert_initialized; to false now?

It's probably easier if it does not, so that "wget cacert 0 0" really clears
the certs. We have a command to restore the built-in ones ("wget cacert
builtin").

Thanks,
-- 
Jerome

> 
> Thanks
> /Ilias
>>
>> Cheers,
>> --
>> Jerome
>>
>>> This is not easy to solve, I was trying to think of ways to make the
>>> functionality clearer to users.
>>>
>>> Cheers
>>> /Ilias
>>>>
>>>> Cheers,
>>>> --
>>>> Jerome
>>>>
>>>>>
>>>>> [...]
>>>>>
>>>>> Cheers
>>>>> /Ilias
