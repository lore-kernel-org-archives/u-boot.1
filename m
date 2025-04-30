Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B5CC369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 14:25:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E5128210F;
	Wed, 30 Apr 2025 16:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="XajqZGyO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77B8182B45; Wed, 30 Apr 2025 16:25:45 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 344368210E
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 16:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 598393FC4C
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 14:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1746023142;
 bh=FViRCWh3IEZgGmG0GgRAvYxZ21KfGq/TVjzlBIWowC8=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=XajqZGyOGKFwvRge/B+twX/ROa1tCTiqTUeoB3xAgo46otnrgmJBr1/cuRknFHiwp
 5pL0hn8tAIcivJDFwIwdtvkYXrXQt7wYu/N+xsAcAwkz9fdJH4d+Xh9OqLiVo9Rtny
 gTeimUb6WkZUO3RhLf2GW3Qom5jYLErbuunXOLpeuWF/AklZYN84/XkIkvUnlVRXW+
 ugIl3NJk2lf2DhTHJ/etwgYAeWkls5pz958thUYjJif7XrMwhDXHAI9Sj4Oq3ZiPkC
 pS6pdPOykvirPE8vtrjp3AndyTgoLR6XaVGfGQYEYy3FjqASQpDBXbGDYxZAJKsw3V
 las1qTfoQzZ+A==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43ceb011ea5so42022215e9.2
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 07:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746023142; x=1746627942;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FViRCWh3IEZgGmG0GgRAvYxZ21KfGq/TVjzlBIWowC8=;
 b=bgFt7IxXPS9mZinTEVKEpU5lfvM9qR1caDWjql70lhsiLjkr1A+MKU+JfGslWT0iC7
 TCLWc2OgK8TM36GIFJ3kYGapGs/gx/h/BELpFXkk69Fpq8KzoG8OJXc+0k+TpxaNvpv3
 slOqUJBA1wO4KFhDtYIKypATdnIZGwKrhnNlFD5GzCNhJRTgEdcy2fwJ0SOLD/4dPW9a
 cUKxCXt6lhF7AAMZrf20WPzkXORbti7DHwplnIGQ1VURVc9Rfp9aAHgqNXdy3g461Pw3
 ewKUWTUySaLVpm/YU/QhIfd/g4w5esRq7XNmcfpOTcVVYBr8iCz/ycI1NDGT0udcw6fU
 fQ5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdBSOGdDJkxC8rBuKVZy9MPd+jeDtYptUkpW4dY0wi/czA7BIgxlbX1r2K2pKGz4CDaJ8PJ9g=@lists.denx.de
X-Gm-Message-State: AOJu0Yydt//tDJNmjcz06gTllO1FcKjEViA14wfEf2/8lBJygTUT8sTe
 TTlwTd6dbp6HAi2BX020b0ne1VpZHsMagyIxTfE2rubvDI6lwQW37LIP9Ek0d8Vj4lQd9s6FiGo
 vT6rMLzf8r5qfX7Rd5vZm+O7lrawr+I/sRoH7KJu3MWhY1J62WN61v6NER1SZIksf5E8=
X-Gm-Gg: ASbGncu2N4wBjd/Sx76DRZxmKpJpVBNkEepcf9OPnMBKDeFfwa+Xy+7KHJQ9DDoa5Mg
 jyHbGo1teShFqMUE+FVIQOQ9ZOiP/IEUnOMPywqUDcvaGThYfndsOIsDQ1P4TKjBv/Vb4iGJW5E
 ymuXJBpaDUU1vEDzgEWxMwg0UnbXZzd2yfxAqfzVslDwY468qEX3a3Lnl1a2WXa22IMrcvuWdBW
 Fy2h6jDKF1yktD5gjwtC+X67z36koeyxvOjthQdDawYJfjF++5cGjm9FrzwKumrOKbVex+cEfio
 lvNV+y4FF7HE2fMfb4qKtJp659/0tTfgU+wJg8ylocN/wcWYJ2DpSrITZ77lzusVhLCPUy/W7Pn
 beA==
X-Received: by 2002:a05:600c:a44:b0:43d:224:86b5 with SMTP id
 5b1f17b1804b1-441b2634af5mr24933035e9.4.1746023141874; 
 Wed, 30 Apr 2025 07:25:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3B9l003B7VUmVQUHUP3cCMN3lKuNMzrfepzF5KwLfEpv7FHzlzXKkdiz5dDMk5ZV3bNXZNg==
X-Received: by 2002:a05:600c:a44:b0:43d:224:86b5 with SMTP id
 5b1f17b1804b1-441b2634af5mr24932735e9.4.1746023141514; 
 Wed, 30 Apr 2025 07:25:41 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:9d1c:a02f:5865:bfa0:f5d4?
 ([2a02:3035:6e0:9d1c:a02f:5865:bfa0:f5d4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2ad784asm26878195e9.7.2025.04.30.07.25.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 07:25:40 -0700 (PDT)
Message-ID: <5cb97876-fcb7-4920-b99e-fac3b69d8e3e@canonical.com>
Date: Wed, 30 Apr 2025 16:25:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] boot: print the boot stage id in the report
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>,
 Richard Weinberger <richard@nod.at>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
References: <20250430091147.321944-1-heinrich.schuchardt@canonical.com>
 <CAFLszTiqXtf9yyLN_JcviaxCkap-zpNnrW7epGoHMjJSVZ53sA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTiqXtf9yyLN_JcviaxCkap-zpNnrW7epGoHMjJSVZ53sA@mail.gmail.com>
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

On 30.04.25 15:54, Simon Glass wrote:
> +Michal Simek
> 
> Hi Heinrich,
> 
> On Wed, 30 Apr 2025 at 03:11, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> An output like the following is not helpful:
>>
>>      Timer summary in microseconds (40 records):
>>             Mark    Elapsed  Stage
>>                0          0  reset
>>      ...
>>       56,448,158      4,845  fit_image_load
>>       56,448,186         28  fit_image_load
>>       56,448,187          1  fit_image_load
>>       56,451,971      3,784  fit_image_load
>>       56,483,951     31,980  fit_image_load
>>       56,483,956          5  fit_image_load
>>       56,483,984         28  fit_image_load
>>       56,484,001         17  fit_image_load
>>       56,484,008          7  fit_image_load
>>
>> It provides no clue about what is happening in the fit_image_load stage.
>>
>> Add the bootstage ID to the report. Now we get:
>>
>>      Timer summary in microseconds (40 records):
>>             Mark    Elapsed    ID Stage
>>                0          0   171 reset
>>        3,181,017  3,181,017   178 board_init_f
>>        3,229,282     48,265   179 board_init_r
>>        4,184,866    955,584    64 eth_common_init
>>        4,280,304     95,438    65 eth_initialize
>>        4,284,509      4,205   186 main_loop
>>        4,390,704    106,195   180 usb_start
>>        5,694,146  1,303,442   187 cli_loop
>>       59,908,029 54,213,883   184 bootm_start
>>       59,908,031          2     1 boot_get_kernel
>>       59,912,875      4,844   100 fit_image_load
>>       59,912,903         28   101 fit_image_load
>>       59,912,904          1   102 fit_image_load
>>       59,916,688      3,784   110 fit_image_load
>>       59,948,668     31,980   105 fit_image_load
>>       59,948,673          5   106 fit_image_load
>>      ...
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   common/bootstage.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/common/bootstage.c b/common/bootstage.c
>> index 4532100acea..0810c4e5271 100644
>> --- a/common/bootstage.c
>> +++ b/common/bootstage.c
>> @@ -254,7 +254,7 @@ static uint32_t print_time_record(struct bootstage_record *rec, uint32_t prev)
>>                  print_grouped_ull(rec->time_us, BOOTSTAGE_DIGITS);
>>                  print_grouped_ull(rec->time_us - prev, BOOTSTAGE_DIGITS);
>>          }
>> -       printf("  %s\n", get_record_name(buf, sizeof(buf), rec));
>> +       printf("  %4u %s\n", rec->id, get_record_name(buf, sizeof(buf), rec));
>>
>>          return rec->time_us;
>>   }
>> @@ -333,7 +333,7 @@ void bootstage_report(void)
>>
>>          printf("Timer summary in microseconds (%d records):\n",
>>                 data->rec_count);
>> -       printf("%11s%11s  %s\n", "Mark", "Elapsed", "Stage");
>> +       printf("%11s%11s  %4s %s\n", "Mark", "Elapsed", "ID", "Stage");
>>
>>          prev = print_time_record(rec, 0);
>>
>> --
>> 2.48.1
> 
> This is largely a revert of [1] so you should mention that, at least
> and cc the author.

There isn't anything reverting [1] in my patch.

> 
> When I wrote the bootstage feature[2], Wolfgang asked me to replace
> the old show_boot_progress() which used an integer. The whole series
> was done with very tight size constraints.
> 
> The function name fit_image_load() is not at all useful in the case
> you are showing.

Booting via bootm is not very exotic.

> 
> In this day and age we should add strings, included if BOOTSTAGE is
> enabled, i.e. convert the calls like:
> 
> bootstage_mark(bootstage_id + BOOTSTAGE_SUB_CHECK_ARCH);
> 
> to
> 
> bootstage_mark(bootstage_id, BOOTSTAGE_SUB_CHECK_ARCH)

If the ID is not meant to be accessible to the user, why would we write 
it to the records at all?

Best regards

Heinrich

> 
> and have it create a string comprising the base ID and the sub-ID,
> e.g. "kernel: check arch"
> 
> Regards,
> Simon
> 
> [1] 55bc22760c3 bootstage: Show func name for bootstage_mark/error
> [2] 770605e4f98 bootstage: Replace show_boot_progress/error() with
> bootstage_...()

