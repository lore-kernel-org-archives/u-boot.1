Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4197EC71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 07:19:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CFBD81E18;
	Mon, 16 Jun 2025 09:19:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mNhXIjbY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA25382063; Mon, 16 Jun 2025 09:18:59 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F33F81E06
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 09:18:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6071ac9dc3eso7295342a12.1
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 00:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750058337; x=1750663137; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Swrh2N/Oaco3miEDVIR8AzpD3fa9n09S8VS6y2PY5eU=;
 b=mNhXIjbYQ5XOUqXO8wISCQ4k96u9wr5DmUGYWVFBkwlndeL1YCd+oRjBHgwSPit1es
 EeAfmiTKfFVwVpQqwTo2WK45FWum71aWCcghaB79zCmKs2yhojwboELU0pqpmcRYeRIf
 BCr4a/NoA+/081mFkolRCQC5xCZm8R1kDL4Yr0jnOVZbwxhltC8dFJaoSLdlarsprEgm
 /w0cQKX4r1RPudT7DQraLozO8aHb88KstL6T4xN5n3emJ3ZJbSsd9U3n7uneLwWIt9gU
 ZKySG9z59X8zixeOxLavu//3qt3g/gG9871wBPI7gQxLTRcfBiQY+Z961LLYD1CfajIy
 MmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750058337; x=1750663137;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Swrh2N/Oaco3miEDVIR8AzpD3fa9n09S8VS6y2PY5eU=;
 b=XG8pNJV+kgoHJBPPpN2Jg2BlzXcyDoPWrl0rP9rcjTlYDa+0fvktjYVDD76cqhr4Dp
 e2gBFpr6CcBMxbvV/NnWosPM45cCYRT+btXRZyoSz6UWQpdBHZHYcPntUJIGWJ0N/roa
 0Y+bXS9c+4UfWY+jg9a40+ztlfe6sD9udaGEvOx5b8inMfWiCuCEqng31KaD2Gl1zQeb
 En+SG7AF3Nl094/cXPwGOcNjBMIL6Sj+ew+U+6zBhv0YX5eD3YPvE6ZegZvKf0RHn3J0
 KgyWuODyCyA5z3l2x38XJzatF3bVfXPPrwfFBUcVIgbWJhvqdTqKi7wUahpZAYFyYr2E
 gJ6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7YYsY7HaZXacJppDVRRKjGgkzB6w1uEBUWV5PozHtTHS7CgzJDUNcGje2AAXxolqT2/NpZAY=@lists.denx.de
X-Gm-Message-State: AOJu0YyJWENbDcAWGooGvz64y+1TZnzx/QNyYuOaXgUUFMLBRd2zhJAZ
 HsWbKxfhQISPR1auV8VrOy5NuzKOxNsBuUt4mJy9x+vLBsmJyFq0oOSwpm7MKOBNLK8=
X-Gm-Gg: ASbGncvdV8ZiNN8E3AaI4HX85JXgHxFZij1lpJSmTQcZymVd7GwZe8g5Sy12FjX1YQd
 95sOXFD+E6VpavA/i8rDFWmTG0DgWED0HjI4xjweNkCH94QH6YJQDBVShfC085qD5fUx0lyXSnZ
 +Ea0C5pC34e6ZE5s3mzh8ogjinH9/3ghUT/IFN1lXY5W0UpobsUkD0ymXlP10arnMHWIiVmI4cP
 Q2Zjje5hpp1Y2nPj5T3fL1AWoYv0X6+iW6qL4NCHna2PC+gEXJ5CMxfyyfrKQxnkdUyvHT03nKn
 K5p9v/eJlCzgTGzPfnQcpJtM1dAfM6ZfoL0xItqT6fK3oaOhqgMMu5edD3JA8S3u9dP5FziP2Q3
 Bc/TEB/IuofCIphx81pEDVDB8qq/tMh1uE2eSJ2S1t2Do5akkkg==
X-Google-Smtp-Source: AGHT+IGphFRNn09PRDaSzonlLP2QSWna9SNSkPC8V/f5WUo+8FoecOaNg2PV72Oi2wrvzU9+QgOTvg==
X-Received: by 2002:a17:907:72c4:b0:ade:4339:9358 with SMTP id
 a640c23a62f3a-adfad327ffdmr774379966b.22.1750058336731; 
 Mon, 16 Jun 2025 00:18:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:ed5:5ba4:73c4:b199?
 ([2a01:e0a:3cb:7bb0:ed5:5ba4:73c4:b199])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adf93630a33sm466214766b.29.2025.06.16.00.18.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Jun 2025 00:18:56 -0700 (PDT)
Message-ID: <63e2718b-81f8-4f2b-9d23-73d53a26b358@linaro.org>
Date: Mon, 16 Jun 2025 09:18:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] net: lwip: call sys_check_timeouts and schedule on
 rx
To: Tim Harvey <tharvey@gateworks.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, u-boot@lists.denx.de,
 Anatolij Gustschin <agust@denx.de>
References: <20250530153826.1057407-1-tharvey@gateworks.com>
 <f19b630b-4a01-4e6f-b419-d2995b45198c@canonical.com>
 <CAJ+vNU2UfSVHvo=_HsCKbWH5AFsYV=SnVGru4ZBWHrGnAVBcRw@mail.gmail.com>
 <CAJ+vNU2trStWN_7jG5OxvvKtodz=qq9JVMaYHPWdpzUDJYiU=Q@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAJ+vNU2trStWN_7jG5OxvvKtodz=qq9JVMaYHPWdpzUDJYiU=Q@mail.gmail.com>
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



On 6/9/25 19:35, Tim Harvey wrote:
> On Tue, Jun 3, 2025 at 5:04 PM Tim Harvey <tharvey@gateworks.com> wrote:
>>
>> On Sun, Jun 1, 2025 at 2:07 PM Heinrich Schuchardt
>> <heinrich.schuchardt@canonical.com> wrote:
>>>
>>> On 5/30/25 17:38, Tim Harvey wrote:
>>>> Call schedule() in net_lwip_rx() to service U-Boot tasks and
>>>> actions during packet rx.
>>>>
>>>> As a cleanup also move sys_check_timeouts() here and remove it from the
>>>> functions that call net_lwip_rx().
>>>>
>>>> This resolves the issue of an active watchdog resetting the board on
>>>> long network activities.
>>>>
>>>> Suggested-by: Jerome Forissier <jerome.forissier@linaro.org>
>>>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>>>> ---
>>>> v2:
>>>>   - remove duplication of sys_check_timeouts() from functions that call
>>>>     net_lwip_rx()
>>>> ---
>>>>   net/lwip/dhcp.c     | 1 -
>>>>   net/lwip/dns.c      | 1 -
>>>>   net/lwip/net-lwip.c | 7 +++++++
>>>>   net/lwip/ping.c     | 1 -
>>>>   net/lwip/tftp.c     | 1 -
>>>>   net/lwip/wget.c     | 1 -
>>>>   6 files changed, 7 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
>>>> index 92bd7067a7fb..b79b746db390 100644
>>>> --- a/net/lwip/dhcp.c
>>>> +++ b/net/lwip/dhcp.c
>>>> @@ -57,7 +57,6 @@ static int dhcp_loop(struct udevice *udev)
>>>>       /* Wait for DHCP to complete */
>>>>       do {
>>>>               net_lwip_rx(udev, netif);
>>>> -             sys_check_timeouts();
>>>>               bound = dhcp_supplied_address(netif);
>>>>               if (bound)
>>>>                       break;
>>>> diff --git a/net/lwip/dns.c b/net/lwip/dns.c
>>>> index 19172ac959ac..738f8bf3196b 100644
>>>> --- a/net/lwip/dns.c
>>>> +++ b/net/lwip/dns.c
>>>> @@ -91,7 +91,6 @@ static int dns_loop(struct udevice *udev, const char *name, const char *var)
>>>>                       net_lwip_rx(udev, netif);
>>>>                       if (dns_cb_arg.done)
>>>>                               break;
>>>> -                     sys_check_timeouts();
>>>>                       if (ctrlc()) {
>>>>                               printf("\nAbort\n");
>>>>                               break;
>>>> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
>>>> index f05c4cd3f64f..e8d4cc542ed8 100644
>>>> --- a/net/lwip/net-lwip.c
>>>> +++ b/net/lwip/net-lwip.c
>>>> @@ -13,8 +13,10 @@
>>>>   #include <lwip/etharp.h>
>>>>   #include <lwip/init.h>
>>>>   #include <lwip/prot/etharp.h>
>>>> +#include <lwip/timeouts.h>
>>>>   #include <net.h>
>>>>   #include <timer.h>
>>>> +#include <u-boot/schedule.h>
>>>>
>>>>   /* xx:xx:xx:xx:xx:xx\0 */
>>>>   #define MAC_ADDR_STRLEN 18
>>>> @@ -284,6 +286,11 @@ int net_lwip_rx(struct udevice *udev, struct netif *netif)
>>>>       int len;
>>>>       int i;
>>>>
>>>> +     /* lwIP timers */
>>>> +     sys_check_timeouts();
>>>> +     /* Other tasks and actions */
>>>> +     schedule(
>>>
>>> Some scheduled tasks have a long duration, specifically video_sync_all()
>>> called via video_idle(). This change will lead to lost packages.
>>>
>>>
>>> @Tom, Simon
>>>
>>> The EFI code was impacted by 29caf9305b6f ("cyclic: Use schedule()
>>> instead of WATCHDOG_RESET()"). This added schedule() calls to EFI
>>> networking. Package losses can expected if schedule() takes more than 1
>>> µs. This is much shorter than the time needed for synchronizing a 1 MiB
>>> frame buffer. The cyclic framework was explicitly meant for short
>>> duration function calls, not for long duration tasks like syncing the
>>> video frame buffer.
>>>
>>>
>>> I think we should remove video_idle() from the cyclic framework.
>>> video_sync_all() should only be triggered if there is video output.
>>>
>>
>> Hi Heinrich,
>>
>> It makes sense what you are saying but I don't have the hardware to
>> test your scenario. Can you submit a patch for discussion with a fixes
>> tag?
> 
> Gentle ping here.
> 
> Can we get some discussion on the point Heinrich brings up about
> video_idle in cyclic? Without my patch here which this discussion is
> blocking, large lwIP network transfers are quite broken on boards with
> watchdogs.

Another option might be to increase the watchdog timeout?

Regards,
-- 
Jerome

> 
> Best Regards,
> 
> Tim
