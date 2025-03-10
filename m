Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97713C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 12:13:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F503811DF;
	Mon, 10 Mar 2025 13:13:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PJnQ7bdV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DF3E8141E; Mon, 10 Mar 2025 13:13:03 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 181AA811B2
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 13:13:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4394a823036so34880175e9.0
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 05:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741608780; x=1742213580; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OdfmwekRcnm6+hVomvY2PqXKIheQFp464xM//1EbODA=;
 b=PJnQ7bdVFUf6gkyJ2/jLumudUpIIbURaSPmdmSDyiZbOVTWYYcf+BfTtemnNBfDB1y
 LVGyzfhXl0NJgy8gGiYIXVTZ0Ig14lWmr0AdrdJN5Pc95tMj+5ci2DLvFzh9+a/4evbt
 lqScSOFHXf1SONc3NUB/QK+Mi5cVL5SlbmmIs3COEDM7jrQsAY1RVR1X641o3IbWmHV9
 mWWMmCIFxl3ODOJvPdkVIsbs5l0Mn2dhOYzaLM+ysjWdcBlKNC2eJ2qeDbAktrdGJiPC
 35QrLLyCU2rTogTSYOOCKubr1tJRpEJ6YGJuubeCPqaByvm4H1P5Q6z/t+XETRUZxmhC
 9roQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741608780; x=1742213580;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OdfmwekRcnm6+hVomvY2PqXKIheQFp464xM//1EbODA=;
 b=UzKMAcJojSxuMjDvnhxrcC8rZjvJxweTeYGCvbwz2RViG4bcuEPJdOQjagEHkFq/fH
 e1m5DesGHnMI0yCUO4YnFvXVzS+lgWxDvFUx4QU47PPTXZi+m9ptBLo0hYDFg+7Okn23
 Itui9wS3a0bjH05xNNOirHkeHxEBS05XN2FwHu5dRYdjrm1lDsp6CoSoWbaOI73/3Pe5
 QOpTzR8jJczN3ccds0CDfbt+wmZUnTZmWa25D/PaNCgMXsvjxXUsJYGX560DaU9K0W1J
 zlnhlsz2NX+qWzuFU/FKVWinkIbWORYKQW9JDWEPPs7md8Q7QdNd+tZzL99Kr+4wEzi/
 ovzw==
X-Gm-Message-State: AOJu0YxRsG3dohXohXbqy3xHLojxO84Hr2wjueeqhZgncAYq7qgpff5O
 u3gKXCDplFZLsL9DN4txf8Nfr3XZdUEWiMt9tR4couOQ9NHYQszWQc33iBWflpQ=
X-Gm-Gg: ASbGncte6B5dL6kvu2OhxLzykm8MdCwkb+RzduzDNR4Evbn+JrLSi/8RkoA6KGxJM+J
 Bs+y4eIYTD3CFv9+rcFLzNImHQrqU+K9btiW8m4cvOHLe4aOPq4yCNHBdsFSV6YyyCBUw80ifBZ
 szCUtffcDqo/BDkbr5PRaI5/xr/MXgHKMYCCCogq8pfwqPzRKL/kqm0UoqG2/MuOIhU13pHmMP5
 c87pMJS7CLXsgidDtVU6ebbkvj763PAJN0SqbjXTZ2rBtibCCwGAdGlYbc5fV2E8TNyH0ZJqsqs
 ghRq1e4H/oaaJZ4vTkkzOzuXQGPmY1m+EKhdJk6WJLBWjz7VujmKOzPhk/MD+EdgLWzz76/Vl4z
 K/mOh42yhRThjxFJuaAk4p+Ob
X-Google-Smtp-Source: AGHT+IESi2IB0Gs6yv7PDOO5TrdLlaOFr7FUYeJvRgj39HG7KUyqTQcRnHfahsmVNbyEBdRkgSmaDQ==
X-Received: by 2002:a05:600c:5115:b0:43c:f64c:44a4 with SMTP id
 5b1f17b1804b1-43cf64c4740mr22627815e9.8.1741608780486; 
 Mon, 10 Mar 2025 05:13:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:72e5:c885:a214:4261?
 ([2a01:e0a:3cb:7bb0:72e5:c885:a214:4261])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cf86b1d80sm33094085e9.9.2025.03.10.05.12.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 05:13:00 -0700 (PDT)
Message-ID: <684ad95c-eff2-4ed4-a305-670977eff7ed@linaro.org>
Date: Mon, 10 Mar 2025 13:12:59 +0100
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
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWjLbpU-1NW5YzxuEauAizjLS1iB_tjMiCBWu2tbjuf189A@mail.gmail.com>
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



On 3/10/25 12:52, Ilias Apalodimas wrote:
> Hi Jerome,
> 
> [...]
> 
> 
>>>>
>>>> +#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
>>>> +       cacert_initialized = true;
>>>> +#endif
>>>>         return CMD_RET_SUCCESS;
>>>>  }
>>>> +
>>>> +#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
>>>> +static int set_cacert_builtin(void)
>>>> +{
>>>> +       return _set_cacert(builtin_cacert, builtin_cacert_size);
>>>> +}
>>>>  #endif
>>>>
>>>> +#if CONFIG_IS_ENABLED(WGET_CACERT)
>>>> +static int set_cacert(char * const saddr, char * const ssz)
>>>> +{
>>>> +       ulong addr, sz;
>>>> +
>>>> +       addr = hextoul(saddr, NULL);
>>>> +       sz = hextoul(ssz, NULL);
>>>> +
>>>> +       return _set_cacert((void *)addr, sz);
>>>> +}
>>>> +#endif
>>>> +#endif  /* CONFIG_WGET_CACERT || CONFIG_WGET_BUILTIN_CACERT */
>>>> +
>>>>  static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>>>>  {
>>>>  #if CONFIG_IS_ENABLED(WGET_HTTPS)
>>>> @@ -373,8 +401,15 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>>>>         memset(&conn, 0, sizeof(conn));
>>>>  #if CONFIG_IS_ENABLED(WGET_HTTPS)
>>>>         if (is_https) {
>>>> -               char *ca = cacert;
>>>> -               size_t ca_sz = cacert_size;
>>>> +               char *ca;
>>>> +               size_t ca_sz;
>>>> +
>>>> +#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
>>>> +               if (!cacert_initialized)
>>>> +                       set_cacert_builtin();
>>>> +#endif
>>>
>>> The code and the rest of the patch seems fine, but the builtin vs
>>> downloaded cert is a bit confusing here.
>>> Since the built-in cert always gets initialized in the wget loop it
>>> would overwrite any certificates that are downloaded in memory?
>>
>> The built-in certs are enabled only when cacert_initialized is false.
>> set_cacert_builtin() will set it to true (via _set_cacert()), so it will
>> happen only once. Note also that any successful "wget cacert" command
>> will also do the same. So effectively these two lines enable the
>> built-in certificates by default, that's all they do.
> 
> Ok, so if you download a cert in memory and have u-boot with a builtin
> certificate, then the memory one will be overwritten in the first run.

No, because the downloaded cert must have be made active via "wget cacert
<addr> <size>", which will set cacert_initialized to true, and thus the
built-in certs won't overwrite them. Or did I miss something?

Cheers,
-- 
Jerome

> This is not easy to solve, I was trying to think of ways to make the
> functionality clearer to users.
> 
> Cheers
> /Ilias
>>
>> Cheers,
>> --
>> Jerome
>>
>>>
>>> [...]
>>>
>>> Cheers
>>> /Ilias
