Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D9AE784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:46:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8504871C5;
	Mon,  2 Oct 2023 03:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vvv4XkYU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 764C6871CC; Mon,  2 Oct 2023 03:46:24 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11448871AB
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:46:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-65afd746330so72265876d6.3
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696211181; x=1696815981; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xM3VcpedO4NB0RFuIXpKbUhtHwPg+MMVZYy4CoL7lGw=;
 b=Vvv4XkYU70GyNl+a/M9Laxz+iw+JeOFd9qh4bUZlRm+HIRw2nrCr8qq0zkjRuKMlHc
 5j+sR59oWn0YpEVigv72LOV+5AcI6CVJ8qlgW6OBKfaTApJbdiLcn8CuJ3Ie/shZUwdh
 szkuMDIBbdCvhok+GEkuiPSiP4/tvTx1V4uWjVZ8JHNXocjOtvZfbpC1W/07taOzjovj
 eNHgQ140BAgswJDGit+oBW1LRda3qh98gTO+WXChzN/e0BGnTOuIFBLyCP6gnoZliolr
 w8Zct1obvVmilRaFUbQXa7vORMnoicP0rZF1jzN9Mj1C6mXTXl5Qg7bENHDG9ONdpMJW
 FAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696211181; x=1696815981;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xM3VcpedO4NB0RFuIXpKbUhtHwPg+MMVZYy4CoL7lGw=;
 b=IaVICs1VJ8ziOGJawavoyPKs0eM1+auIqZ72w+brJqck2fH4IaFLhLzobq/YYiW0rr
 H0cYMn6vW56y5tj79R4PFmed0wlZhh5xVlOm+L/iu+QsFyNSLVwFxxz5bY8/ZRyI5XPB
 hIa9rjd2b+KzeIOdKqyjooqWeLefJa/8gBl/4K3FbnifORuoxZ5EGtAy9b0XhoOTUfNO
 oqXJAQV+Ey8mE1VrO9X3YvSTpq37L9YuCwIiqa3v4kLAOWZK/YzqSxcHgyExpXZ0960y
 Rbr1f9hO8jgu5MkKNQIeLhv9MLQ5nmxOXD49OGG1DOFuhKfzDXodNwmKRrhzovuqwcan
 wk+w==
X-Gm-Message-State: AOJu0Yw2Zyu0kGPUzcaHITw33VitA2h0IZSbvz6x8MMV1K7iahVMz8Io
 1YiMEdlDdsxjBpucdqwpboY=
X-Google-Smtp-Source: AGHT+IGwme0JJkP5b5LjSVXC4KCnAwJKz7iDyeTMagBwFnzZJI2I4/ZAjrET3AJvoFu2QpwfMY9EPw==
X-Received: by 2002:a05:6214:16c2:b0:658:2857:ed6a with SMTP id
 d2-20020a05621416c200b006582857ed6amr10723530qvz.43.1696211180791; 
 Sun, 01 Oct 2023 18:46:20 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 fc17-20020ad44f31000000b00668bb8be252sm668312qvb.60.2023.10.01.18.46.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Oct 2023 18:46:20 -0700 (PDT)
Message-ID: <be166e65-9892-11ac-3727-3779c453014a@gmail.com>
Date: Sun, 1 Oct 2023 21:46:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 0/4] malloc: Reduce size by initializing data at runtime
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, Sean Anderson <sean.anderson@seco.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20230928144458.2511087-1-sean.anderson@seco.com>
 <CAPnjgZ1Y=+2GoHzj=6mJySyYrn9CoHBZzSDjFreWNEWJyi+jMQ@mail.gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAPnjgZ1Y=+2GoHzj=6mJySyYrn9CoHBZzSDjFreWNEWJyi+jMQ@mail.gmail.com>
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

On 10/1/23 21:16, Simon Glass wrote:
> Hi Sean,
> 
> On Thu, 28 Sept 2023 at 08:45, Sean Anderson <sean.anderson@seco.com> wrote:
>>
>> In my efforts to get SPL to fit into flash after some changes I made, I
>> noticed that av_ is one of the largest variables in SPL. As it turns
>> out, we can generate it at runtime, and the code is already there. This
>> has the potential to save 1-2k across the board, for some (very) minor
>> boot time increase.
>>
>> This series is based on [1], since this makes checking for SYS_MALLOC_F
>> easier. Passing CI at [2].
>>
>> To measure the boot time difference, I applied the following patch:
>>
>> ---
>>   common/board_r.c | 5 +++++
>>   common/spl/spl.c | 4 ++++
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/common/board_r.c b/common/board_r.c
>> index 58a5986aa54..ca624b20d46 100644
>> --- a/common/board_r.c
>> +++ b/common/board_r.c
>> @@ -194,6 +194,7 @@ static int initr_barrier(void)
>>          return 0;
>>   }
>>
>> +static ulong malloc_begin, malloc_end;
>>   static int initr_malloc(void)
>>   {
>>          ulong malloc_start;
>> @@ -208,8 +209,10 @@ static int initr_malloc(void)
>>           * reserve_noncached().
>>           */
>>          malloc_start = gd->relocaddr - TOTAL_MALLOC_LEN;
>> +       malloc_begin = timer_get_boot_us();
> 
> Perhaps this would be better done with bootstage, since then the
> timing can be enabled / disabled, and reported along with other
> timings.

I'll try that out next time.

>>          mem_malloc_init((ulong)map_sysmem(malloc_start, TOTAL_MALLOC_LEN),
>>                          TOTAL_MALLOC_LEN);
>> +       malloc_end = timer_get_boot_us();
>>          gd->flags |= GD_FLG_FULL_MALLOC_INIT;
>>          return 0;
>>   }
>> @@ -570,6 +573,8 @@ static int dm_announce(void)
>>
>>   static int run_main_loop(void)
>>   {
>> +       printf("malloc_init took %luus (%lu %lu)\n", malloc_end - malloc_begin,
>> +              malloc_begin, malloc_end);
>>   #ifdef CONFIG_SANDBOX
>>          sandbox_main_loop_init();
>>   #endif
>> diff --git a/common/spl/spl.c b/common/spl/spl.c
>> index d74acec10b5..b34d1f4b4e6 100644
>> --- a/common/spl/spl.c
>> +++ b/common/spl/spl.c
>> @@ -755,7 +755,9 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
>>          spl_set_bd();
>>
>>   #if defined(CONFIG_SYS_SPL_MALLOC)
>> +       ulong malloc_begin = timer_get_boot_us();
>>          mem_malloc_init(SYS_SPL_MALLOC_START, CONFIG_SYS_SPL_MALLOC_SIZE);
>> +       ulong malloc_end = timer_get_boot_us();
>>          gd->flags |= GD_FLG_FULL_MALLOC_INIT;
>>   #endif
>>          if (!(gd->flags & GD_FLG_SPL_INIT)) {
>> @@ -817,6 +819,8 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
>>          spl_image.boot_device = BOOT_DEVICE_NONE;
>>          board_boot_order(spl_boot_list);
>>
>> +       printf("malloc_init took %luus (%lu %lu)\n", malloc_end - malloc_begin,
>> +              malloc_begin, malloc_end);
> 
> debug() ?

Well, this is not going to be applied, so I used the easiest thing :)

--Sean

>>          ret = boot_from_devices(&spl_image, spl_boot_list,
>>                                  ARRAY_SIZE(spl_boot_list));
>>          if (ret) {
>> --
>> 2.25.1
>>
>> I found that MALLOC_CLEAR_ON_INIT dominated the mem_malloc_init time
>> (taking around 150 ms in SPL on my board). After disabling it, I found
>> that MALLOC_RUNTIME_INIT took around 5 us on average.
>>
>> [1] https://lore.kernel.org/u-boot/20230926141514.2101787-1-sjg@chromium.org/
>> [2] https://source.denx.de/u-boot/custodians/u-boot-clk/-/pipelines/17900
>>
>> Changes in v3:
>> - Use CONFIG_IS_ENABLED in conditionals
>> - Don't enable SPL_SYS_MALLOC_RUNTIME_INIT if we are short on BSS
>>
>> Changes in v2:
>> - Only mark malloc initialized after mem_malloc_init
>> - Fix cALLOc condition
>>
>> Sean Anderson (4):
>>    common: Only mark malloc initialized after mem_malloc_init
>>    malloc: Don't use ifdefs for SYS_MALLOC_DEFAULT_TO_INIT
>>    malloc: Don't statically initialize av_ if using malloc_init
>>    malloc: Enable SYS_MALLOC_RUNTIME_INIT by default in SPL
>>
>>   Kconfig           | 27 +++++++++++++++++----------
>>   common/board_r.c  |  3 ++-
>>   common/dlmalloc.c | 16 ++++++++--------
>>   3 files changed, 27 insertions(+), 19 deletions(-)
>>
>> --
>> 2.35.1.1320.gc452695387.dirty
>>
> 
> REgards,
> SImon

