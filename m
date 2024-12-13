Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF01E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 12:30:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ED838010E;
	Fri, 13 Dec 2024 13:30:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ENeyw/+S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2A608012C; Fri, 13 Dec 2024 13:30:32 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85CC78007A
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 13:30:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aa68b513abcso280025166b.0
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 04:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734093030; x=1734697830; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aKV7S3mJYq25WXfWY0qMkSTOp0gBnFOSq6alWzPL9PA=;
 b=ENeyw/+SZsYKxsK/xxuhllSVq0WjhJj1y+UoHOZU7SYI2XGVpsFQTjIEdZFyXMsz+1
 wxPA3FSznsFbi6pZr6c9pBkDQKAn8EskpL9dvc11M7AmJNdDRgwljGfEsMjptGhdHEyr
 DSPOLz8drMKe87U552AnrT8vYbqj6PMn6JuX54rcF3RUxip0wlCHqZTYZMx+4WHvMVaW
 hLolG6E2mmVssTeFiJdhqwWBYUyOdmbNiGcHojNXeLeBGd/aYGcJK4ozpdjkxB79xMr4
 ZhMQzaka5xXrcsRZecq3AGmo0l04WMkeTeVwrUSD81yfz4/pLpg1dOxZMtbBmd8s9IQR
 vkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734093030; x=1734697830;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aKV7S3mJYq25WXfWY0qMkSTOp0gBnFOSq6alWzPL9PA=;
 b=va7YAGhrKrOX9MLCT5XJhQ8qODbMGO4xaQwYEfiiaMguEkGPJ1gxLSdUPZHXzjU2o4
 xzC356BXkqHvdo9ckomZiC2l+ZXuRLieR7xNL9E1buFqqi0fH5m1KXyWAEOAZEEXo/Gp
 ezXoUVLIfM2+4hjgtrMOmcqTnAh8HpLugOeGJIyIdUidBrsaDM2IaB5PdLfllFqKZgkP
 UegXd/2izy4pk0tiPyIxnKQVjHbFwxKnZ384zPLf8LQr+4oHvzqzjyrLWMUjY2XKyU2O
 uhlRUxDg2Y0qDY15f2STcIe+nwM/2jDF+KlO4qbTKUsRO9x8hAiwQlwg3zKeCm1rywnJ
 dmSA==
X-Gm-Message-State: AOJu0YwRO1Cjr48Hw48oBXPeQPWRaAJooGcOVyDJ+1iGGFBSk2XBfBmT
 Dut1ckyg3t3/EueGIFuI2eEmf8cxGm0BjblOc2XzsL5qtwYxGGgSWf6hFJNBgQ3lRtFOABxTU1O
 tsTM=
X-Gm-Gg: ASbGncvX5a0vngMKOYJ69Pddv5wEeQKZvZPz6T/mhPFzysadMXZvYotJYX2u2sKAmSM
 wkPVf+MQBYi+Hjy0VndnHMafoFl9CTOTVyZJiC9m7f7nUr2dj1sUXy7qy7dp/1F2xoY9Y4vW0nk
 +ZwYSjUfaIXrm5qHtpukvhul0C5MPew87gds6dAyVuGAagU/MMcIcWq0GIMSwfgWzU17avVva1v
 7HLiQapWKq8SlFbJfC6Wz+D64R/Cl1UBLqfEFl0i0fTDB9mvqzDDTavH6JxidejQn4hSQm1OsiH
 W4t05zrKp4aOQuBT0L2iPsd9pnkA7LEMz9Vi
X-Google-Smtp-Source: AGHT+IH5swugCiGxpixtRtR1SZt25INZ9PKSp7am48+GOkxAJf5KV5CH2KfecN5qAJBLU2S1ej3ADQ==
X-Received: by 2002:a17:907:3da4:b0:aa6:7737:1998 with SMTP id
 a640c23a62f3a-aab778c7d18mr289976766b.3.1734093029704; 
 Fri, 13 Dec 2024 04:30:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:aa4c:f9c5:f039:83a9?
 ([2a01:e0a:3cb:7bb0:aa4c:f9c5:f039:83a9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa6b1552b05sm342826166b.164.2024.12.13.04.30.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 04:30:29 -0800 (PST)
Message-ID: <e13ef4c2-4e0a-4d85-a00c-43ee10d7c06b@linaro.org>
Date: Fri, 13 Dec 2024 13:30:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] trace: add support for "trace clear"
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
References: <cover.1733757864.git.jerome.forissier@linaro.org>
 <47c647a8dfc23ba24c90560feb1360788609384a.1733757864.git.jerome.forissier@linaro.org>
 <CAC_iWjJ8gNmnyfwg-DURJhZQ=Vs=8LUS-Vv=dD30NdR6rcApHQ@mail.gmail.com>
 <613a8e02-d5ed-4528-81f1-10f07986730a@linaro.org>
 <CAC_iWjJGxaP+SW05OXjKgQoLY5O4Ecf43-uHsU6fk_8PQxkw5Q@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWjJGxaP+SW05OXjKgQoLY5O4Ecf43-uHsU6fk_8PQxkw5Q@mail.gmail.com>
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



On 12/13/24 13:16, Ilias Apalodimas wrote:
> Thanks,
> 
> Apologies I missed something else as well
> 
> On Fri, 13 Dec 2024 at 14:14, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>>
>>
>> On 12/13/24 13:09, Ilias Apalodimas wrote:
>>> Hi Jerome
>>>
>>> On Mon, 9 Dec 2024 at 17:32, Jerome Forissier
>>> <jerome.forissier@linaro.org> wrote:
>>>>
>>>> Implement a "trace clear" command to delete the currently accumulated
>>>> trace data. This comes handy when someone needs to trace a particular
>>>> command. For example:
>>>>
>>>>   => trace clear; dhcp; trace pause
>>>>   => trace stats
>>>>   => trace calls 0x02100000 0x10000000
>>>>   => tftpput $profbase $profoffset 192.168.0.16:trace.bin
>>>>
>>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>>> ---
>>>>  cmd/trace.c     | 13 ++++++++++++-
>>>>  include/trace.h |  2 ++
>>>>  lib/trace.c     | 47 +++++++++++++++++++++++++++++++++--------------
>>>>  3 files changed, 47 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/cmd/trace.c b/cmd/trace.c
>>>> index 937e6a682ad..e95ac7ca9da 100644
>>>> --- a/cmd/trace.c
>>>> +++ b/cmd/trace.c
>>>> @@ -87,8 +87,18 @@ int do_trace(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>>>                 trace_set_enabled(0);
>>>>                 break;
>>>>         case 'c':
>>>> -               if (create_call_list(argc, argv))
>>>> +               switch (*(cmd + 1)) {
>>>> +               case 'a':
>>>> +                       if (create_call_list(argc, argv))
>>>> +                               return cmd_usage(cmdtp);
>>>> +                       break;
>>>> +               case 'l':
>>>> +                       if (trace_clear())
>>>> +                               return CMD_RET_FAILURE;
>>>> +                       break;
>>>
>>> Instead of this, mind changing the command to trace wipe or something similar?
>>> Then we can have a discrete case for 'w' rather than scanning for a string
>>
>> Good idea.
>>
>> Thanks,
>> --
>> Jerome
>>
>>>
>>> Cheers
>>> /Ilias
>>>> +               default:
>>>>                         return cmd_usage(cmdtp);
>>>> +               }
>>>>                 break;
>>>>         case 'r':
>>>>                 trace_set_enabled(1);
>>>> @@ -113,6 +123,7 @@ U_BOOT_CMD(
>>>>         "stats                        - display tracing statistics\n"
>>>>         "trace pause                        - pause tracing\n"
>>>>         "trace resume                       - resume tracing\n"
>>>> +       "trace clear                        - clear traces\n"
>>>>         "trace funclist [<addr> <size>]     - dump function list into buffer\n"
>>>>         "trace calls  [<addr> <size>]       "
>>>>                 "- dump function call trace into buffer"
>>>> diff --git a/include/trace.h b/include/trace.h
>>>> index 763d6d1255a..782eaae2fc2 100644
>>>> --- a/include/trace.h
>>>> +++ b/include/trace.h
>>>> @@ -100,6 +100,8 @@ void trace_set_enabled(int enabled);
>>>>
>>>>  int trace_early_init(void);
>>>>
>>>> +int trace_clear(void);
>>>> +
>>>>  /**
>>>>   * Init the trace system
>>>>   *
>>>> diff --git a/lib/trace.c b/lib/trace.c
>>>> index cabbe47b58a..def9f912c92 100644
>>>> --- a/lib/trace.c
>>>> +++ b/lib/trace.c
>>>> @@ -351,14 +351,8 @@ static int get_func_count(void)
>>>>         return gd->mon_len / FUNC_SITE_SIZE;
>>>>  }
>>>>
>>>> -/**
>>>> - * trace_init() - initialize the tracing system and enable it
>>>> - *
>>>> - * @buff:      Pointer to trace buffer
>>>> - * @buff_size: Size of trace buffer
>>>> - * Return:     0 if ok
>>>> - */
>>>> -int notrace trace_init(void *buff, size_t buff_size)
>>>> +static int notrace trace_init_(void *buff, size_t buff_size, bool copy_early,
>>>> +                              bool enable)
>>>>  {
>>>>         int func_count = get_func_count();
>>>>         size_t needed;
>>>> @@ -368,7 +362,7 @@ int notrace trace_init(void *buff, size_t buff_size)
>>>>                 return func_count;
>>>>         trace_save_gd();
>>>>
>>>> -       if (!was_disabled) {
>>>> +       if (copy_early) {
>>>>  #ifdef CONFIG_TRACE_EARLY
>>>>                 ulong used, count;
>>>>                 char *end;
>>>> @@ -394,9 +388,6 @@ int notrace trace_init(void *buff, size_t buff_size)
>>>>                 }
>>>>                 puts("\n");
>>>>                 memcpy(buff, hdr, used);
>>>> -#else
>>>> -               puts("trace: already enabled\n");
>>>> -               return -EALREADY;
>>>>  #endif
>>>>         }
>>>>         hdr = (struct trace_hdr *)buff;
>>>> @@ -419,13 +410,41 @@ int notrace trace_init(void *buff, size_t buff_size)
>>>>         hdr->ftrace_size = (buff_size - needed) / sizeof(*hdr->ftrace);
>>>>         hdr->depth_limit = CONFIG_TRACE_CALL_DEPTH_LIMIT;
>>>>
>>>> -       puts("trace: enabled\n");
>>>> -       trace_enabled = 1;
>>>> +       printf("trace: initialized, %senabled\n", enable ? "" : "not ");
>>>> +       trace_enabled = enable;
>>>>         trace_inited = 1;
>>>>
>>>>         return 0;
>>>>  }
>>>>
>>>> +/**
>>>> + * trace_init() - initialize the tracing system and enable it
>>>> + *
>>>> + * @buff:      Pointer to trace buffer
>>>> + * @buff_size: Size of trace buffer
>>>> + * Return:     0 if ok
>>>> + */
>>>> +int notrace trace_init(void *buff, size_t buff_size)
>>>> +{
>>>> +       /* If traces are enabled already, we may have early traces to copy */
>>>> +       return trace_init_(buff, buff_size, trace_enabled, true);
> 
> This is a global, so you can skip passing it and just check the
> trace_enabled in trace_init_()

Unfortunately not, because trace_clear() needs to be able to invoke trace_init_()
with copy_early = false (we never want to copy the early trace buffer when
coming from the 'trace clear' command).

Thanks,
-- 
Jerome

> 
> Thanks
> /Ilias
>>>> +}
>>>> +
>>>> +/**
>>>> + * trace_clear() - clear accumulated traced data
>>>> + *
>>>> + * May be called with tracing enabled or disabled.
>>>> + */
>>>> +int notrace trace_clear(void)
>>>> +{
>>>> +       bool was_enabled = trace_enabled;
>>>> +
>>>> +       if (trace_enabled)
>>>> +               trace_enabled = 0;
>>>> +       return trace_init_(gd->trace_buff, CONFIG_TRACE_BUFFER_SIZE,
>>>> +                          false, was_enabled);
>>>> +}
>>>> +
>>>>  #ifdef CONFIG_TRACE_EARLY
>>>>  /**
>>>>   * trace_early_init() - initialize the tracing system for early tracing
>>>> --
>>>> 2.43.0
>>>>
