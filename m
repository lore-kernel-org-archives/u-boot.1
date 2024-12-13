Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1237E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 12:14:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CCED80137;
	Fri, 13 Dec 2024 13:14:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KFgpxNPm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1B8F80104; Fri, 13 Dec 2024 13:14:32 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC71580141
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 13:14:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a9a977d6cc7so213713666b.3
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 04:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734092070; x=1734696870; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8khqCwCjUNY/um+rxJB1PNEbXXGBNcMDhUbBoYDNUSo=;
 b=KFgpxNPmjeYDGepmdf/NJm0bUuWHUelD0FWpyToHNsBSSqw4fmIs1TvW+sOWpltC78
 KOIjY+TrK2KeSEeU4bJsK1PzGqloV/pS5kIKwOGDUpw/y2xazvzns0yYHrz7g/yNwcEE
 CUG20PAkItNOHD865t+r9/3TOLhDfEOp4BhFfsSR0ob9BoThDR4yLubXlKdexp+EVhM4
 v8cdNBnqulXz997w5HefiU7h/WUmtvippF2zwM1qOW1a8sFlr8MAOhAX3Zo2T75FmIdF
 SNop85QGSEYQ8uNlbK6ifAJZ/HYHL1wLXPWDAqGHWk1bCLy6dayuC1W8Ehid3YFBgk7o
 ZRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734092070; x=1734696870;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8khqCwCjUNY/um+rxJB1PNEbXXGBNcMDhUbBoYDNUSo=;
 b=NArBdFRaBwUSLi8Fyz2xcLHC2uwX4QvDGmIZkNx2HTlioTKbneeuOomQ+uxuZiIzMZ
 +2Q9O3bN34TLz/xfqi5xGPmVUz+WLUiHDsS+0MPq8R3/lon17tc1upjGyyEDsDLJbLnV
 XT5m6MZDNlaZ/DE42EDdhlrz5k1qUTE6Lh8RbR2c6BmIpsCzqGYZ18fuKatI8CvSPeYE
 z61CAqqWHTFHLOnqIZdt4NYAIXsJjoDs58LSGmZajVCcSbjDu03C1wL9k2eulTM7bLuT
 sno0Xb0WamRH/R6yC2rSMi6j67IiKVMGjeNM+etbu56VYPfipRnS+vIPAu22UL9jbDes
 tNHQ==
X-Gm-Message-State: AOJu0YxTQ4sQlJ2TALHaw4QIjvXjfJPRkJV6vgWbjEaB3rPzWfUtCW1+
 1IcC4avAQPcGOZTKsEMe3jZbkvdPIXTKdzve7H4yuY36tyNe99Qqna7/iNYB5Yo=
X-Gm-Gg: ASbGncvcjJZ1PVgqybMqeYPJ20QFyzjwc14wiR4BGnVncxXBqkQ9Rj0jDUN6BZ/Gx4F
 bL0L+ozWH6KJlFx72ZgbYcPkJSFN9aiU2p8XxTAvcEXhMx+5xX++jW8vlJBHzXcRD7P0HNQ4ESM
 X5Jn56NsvU8HKu46NmXE6KChgWtrs4gtoO1d357xquZ4MPNIHD4jjBmTGesl5tHvZ0ZPPQtPUZ/
 K0xE4qXE8zUjuOqCO+yP7Kvd9jwi8SAAB1oopGPBcXjOKbTeBHlDmdCiUnhfBKyvXAwGZVstv/A
 fer2xE1/hq9rDVLQSOMSVeqVeTmBppVJB79s
X-Google-Smtp-Source: AGHT+IGqsuD/1aguaqaEI1zhd2haVXMKNZSqKGPnDwX1dc1o0fGuQScRJxqrdWQdkCydgJfncyTflg==
X-Received: by 2002:a05:6402:51c6:b0:5d2:7199:ac2 with SMTP id
 4fb4d7f45d1cf-5d63c300da1mr4398400a12.2.1734092069874; 
 Fri, 13 Dec 2024 04:14:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:aa4c:f9c5:f039:83a9?
 ([2a01:e0a:3cb:7bb0:aa4c:f9c5:f039:83a9])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d14c798fc7sm11320696a12.62.2024.12.13.04.14.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 04:14:29 -0800 (PST)
Message-ID: <613a8e02-d5ed-4528-81f1-10f07986730a@linaro.org>
Date: Fri, 13 Dec 2024 13:14:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] trace: add support for "trace clear"
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
References: <cover.1733757864.git.jerome.forissier@linaro.org>
 <47c647a8dfc23ba24c90560feb1360788609384a.1733757864.git.jerome.forissier@linaro.org>
 <CAC_iWjJ8gNmnyfwg-DURJhZQ=Vs=8LUS-Vv=dD30NdR6rcApHQ@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWjJ8gNmnyfwg-DURJhZQ=Vs=8LUS-Vv=dD30NdR6rcApHQ@mail.gmail.com>
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



On 12/13/24 13:09, Ilias Apalodimas wrote:
> Hi Jerome
> 
> On Mon, 9 Dec 2024 at 17:32, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> Implement a "trace clear" command to delete the currently accumulated
>> trace data. This comes handy when someone needs to trace a particular
>> command. For example:
>>
>>   => trace clear; dhcp; trace pause
>>   => trace stats
>>   => trace calls 0x02100000 0x10000000
>>   => tftpput $profbase $profoffset 192.168.0.16:trace.bin
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  cmd/trace.c     | 13 ++++++++++++-
>>  include/trace.h |  2 ++
>>  lib/trace.c     | 47 +++++++++++++++++++++++++++++++++--------------
>>  3 files changed, 47 insertions(+), 15 deletions(-)
>>
>> diff --git a/cmd/trace.c b/cmd/trace.c
>> index 937e6a682ad..e95ac7ca9da 100644
>> --- a/cmd/trace.c
>> +++ b/cmd/trace.c
>> @@ -87,8 +87,18 @@ int do_trace(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>                 trace_set_enabled(0);
>>                 break;
>>         case 'c':
>> -               if (create_call_list(argc, argv))
>> +               switch (*(cmd + 1)) {
>> +               case 'a':
>> +                       if (create_call_list(argc, argv))
>> +                               return cmd_usage(cmdtp);
>> +                       break;
>> +               case 'l':
>> +                       if (trace_clear())
>> +                               return CMD_RET_FAILURE;
>> +                       break;
> 
> Instead of this, mind changing the command to trace wipe or something similar?
> Then we can have a discrete case for 'w' rather than scanning for a string

Good idea.

Thanks,
-- 
Jerome

> 
> Cheers
> /Ilias
>> +               default:
>>                         return cmd_usage(cmdtp);
>> +               }
>>                 break;
>>         case 'r':
>>                 trace_set_enabled(1);
>> @@ -113,6 +123,7 @@ U_BOOT_CMD(
>>         "stats                        - display tracing statistics\n"
>>         "trace pause                        - pause tracing\n"
>>         "trace resume                       - resume tracing\n"
>> +       "trace clear                        - clear traces\n"
>>         "trace funclist [<addr> <size>]     - dump function list into buffer\n"
>>         "trace calls  [<addr> <size>]       "
>>                 "- dump function call trace into buffer"
>> diff --git a/include/trace.h b/include/trace.h
>> index 763d6d1255a..782eaae2fc2 100644
>> --- a/include/trace.h
>> +++ b/include/trace.h
>> @@ -100,6 +100,8 @@ void trace_set_enabled(int enabled);
>>
>>  int trace_early_init(void);
>>
>> +int trace_clear(void);
>> +
>>  /**
>>   * Init the trace system
>>   *
>> diff --git a/lib/trace.c b/lib/trace.c
>> index cabbe47b58a..def9f912c92 100644
>> --- a/lib/trace.c
>> +++ b/lib/trace.c
>> @@ -351,14 +351,8 @@ static int get_func_count(void)
>>         return gd->mon_len / FUNC_SITE_SIZE;
>>  }
>>
>> -/**
>> - * trace_init() - initialize the tracing system and enable it
>> - *
>> - * @buff:      Pointer to trace buffer
>> - * @buff_size: Size of trace buffer
>> - * Return:     0 if ok
>> - */
>> -int notrace trace_init(void *buff, size_t buff_size)
>> +static int notrace trace_init_(void *buff, size_t buff_size, bool copy_early,
>> +                              bool enable)
>>  {
>>         int func_count = get_func_count();
>>         size_t needed;
>> @@ -368,7 +362,7 @@ int notrace trace_init(void *buff, size_t buff_size)
>>                 return func_count;
>>         trace_save_gd();
>>
>> -       if (!was_disabled) {
>> +       if (copy_early) {
>>  #ifdef CONFIG_TRACE_EARLY
>>                 ulong used, count;
>>                 char *end;
>> @@ -394,9 +388,6 @@ int notrace trace_init(void *buff, size_t buff_size)
>>                 }
>>                 puts("\n");
>>                 memcpy(buff, hdr, used);
>> -#else
>> -               puts("trace: already enabled\n");
>> -               return -EALREADY;
>>  #endif
>>         }
>>         hdr = (struct trace_hdr *)buff;
>> @@ -419,13 +410,41 @@ int notrace trace_init(void *buff, size_t buff_size)
>>         hdr->ftrace_size = (buff_size - needed) / sizeof(*hdr->ftrace);
>>         hdr->depth_limit = CONFIG_TRACE_CALL_DEPTH_LIMIT;
>>
>> -       puts("trace: enabled\n");
>> -       trace_enabled = 1;
>> +       printf("trace: initialized, %senabled\n", enable ? "" : "not ");
>> +       trace_enabled = enable;
>>         trace_inited = 1;
>>
>>         return 0;
>>  }
>>
>> +/**
>> + * trace_init() - initialize the tracing system and enable it
>> + *
>> + * @buff:      Pointer to trace buffer
>> + * @buff_size: Size of trace buffer
>> + * Return:     0 if ok
>> + */
>> +int notrace trace_init(void *buff, size_t buff_size)
>> +{
>> +       /* If traces are enabled already, we may have early traces to copy */
>> +       return trace_init_(buff, buff_size, trace_enabled, true);
>> +}
>> +
>> +/**
>> + * trace_clear() - clear accumulated traced data
>> + *
>> + * May be called with tracing enabled or disabled.
>> + */
>> +int notrace trace_clear(void)
>> +{
>> +       bool was_enabled = trace_enabled;
>> +
>> +       if (trace_enabled)
>> +               trace_enabled = 0;
>> +       return trace_init_(gd->trace_buff, CONFIG_TRACE_BUFFER_SIZE,
>> +                          false, was_enabled);
>> +}
>> +
>>  #ifdef CONFIG_TRACE_EARLY
>>  /**
>>   * trace_early_init() - initialize the tracing system for early tracing
>> --
>> 2.43.0
>>
