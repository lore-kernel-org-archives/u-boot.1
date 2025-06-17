Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3074FC7114A
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 07:09:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54A2D80C83;
	Tue, 17 Jun 2025 09:09:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lS8dSV+t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF4A681E18; Tue, 17 Jun 2025 09:09:07 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ADEA8070C
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 09:09:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a54700a463so316383f8f.1
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 00:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750144142; x=1750748942; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hwgQrU4PXy58mxxVAeEz5jhFEzvB2P7b/O48ZHhD3EI=;
 b=lS8dSV+tgOLvjLKKZpz15v/i1mJvzXbIEhafBLUJV+zsQsmxWoG/jfnUQPQ+8V2Y9i
 Uz5g1Q/sBzT1CucrMq/JJqJXxwNUZvja/eJ38gwbyxLFFbyEr34a2s8oRpIEeXtQ7oTJ
 +7WIzNRcxe5BmOmw7/66MOulNHCDtIlL9lOcsSUkApuYmUfnfEFGt6s9/hQm1L1jIP90
 3vXi3xg0YFDDp719reulGmJx6rJly+ipcNiRr8Een2lxF530Tj1g2n+ahCiVx3112q26
 MVyXYb93QPNQrNEftfjh7qgr752IFluFxPXzgESA8DS/h5trx98NZuWdvGXba+E+1XU7
 lsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750144142; x=1750748942;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hwgQrU4PXy58mxxVAeEz5jhFEzvB2P7b/O48ZHhD3EI=;
 b=tjUb6hazi+RLDKhchlB/TgJzCdUrmhgf/ON80RcRmmJBaL3dMtfipNOE/heanfIhIb
 JY92QKCMLaTAxEjj69TtbT8ClLR8r2/R0bPmOX8C74GWDD0fDK37KSj+20PkTxlmzHBm
 z95ZttjVs4z/rYeuQrf5b/31AiTvD/H2yEfAaDSWF9FfcGGceKRoDfTMBfm6od9mS/eG
 yb39xuRV+77IyF/b4B+buOUyu2EIX3vlSkRl873DCn2ti3nHSyV2ReqgAOWmpikbWqkO
 iuyl4TKZcmRC8GH4cr+e+dRlcs6Rm+8Se28MW6JRy5BgNwViBA0J9/luJNoqIvm1ZU30
 x/ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXToE/TDJ8Cn5HtVE/BjMKgAlzLXUat+/w+HPy5GOpAOKHKLB+nRjwucxgp2lAzkO0S+fLu7BA=@lists.denx.de
X-Gm-Message-State: AOJu0YwMX/hQQobiVq17cKxieYTIJX5yfZyrYw+1sGMZSVsdgtsduSbn
 BpBsSBU/RxFIP9gJ9LOZdSfTlQ+yc1Dwj+nxGf0yU0bJTM8lJd8mudwRNzD+vsCIjpE=
X-Gm-Gg: ASbGncs0juRogktKIfn1LqnjM/EErxBA0Epycg4EW3Djt5T3GylioXVHRTMMD0QaAMf
 OeCXy7m0pRfdoRJeRS6aORvDXD1uv7H+UXt0rHXqVVg+58ulRPeolfyGA30tZvRyIEtXvqIlMRn
 LCHzmQUqkminvEILQVyEp4nxE6Ai5t23B+LzQcKdOMUAmrpp/ydaI8MTKQoWBYH7Nzc6niQBhO0
 3tZl4Z+zrYj19JfvvhKRgtyEROsefJEf/EEsvlCZC074YsXX7XGj5CuZYnwoJYUK9PVBk/aFV1Z
 z7XiAs1KITqqFP2ZjPaIjzjAUobx4fspUgnUx2epcZOg1kmDmAy0i/49i4K+Hnn8aJxNYeEc84l
 vsMwEsqdmIqgzJtvVNfCIj+Joff5a3QthZPlkYrSwTQ==
X-Google-Smtp-Source: AGHT+IGhWrJlTQgoXtQ+8C45UUA/HIslaHfcPs6vK7GPKsS9cvaMhzV4hg/uWHuQKcj5w9wHv1LAhw==
X-Received: by 2002:a05:6000:310f:b0:3a4:e231:8632 with SMTP id
 ffacd0b85a97d-3a57239587bmr9222386f8f.12.1750144142205; 
 Tue, 17 Jun 2025 00:09:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:fab8:6e00:5653:6566?
 ([2a01:e0a:3cb:7bb0:fab8:6e00:5653:6566])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568a73845sm13286816f8f.35.2025.06.17.00.09.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 00:09:01 -0700 (PDT)
Message-ID: <9df8e773-92f8-4594-b45f-4d62f0521e46@linaro.org>
Date: Tue, 17 Jun 2025 09:09:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] net: lwip: call sys_check_timeouts and schedule on
 rx
To: Tim Harvey <tharvey@gateworks.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, u-boot@lists.denx.de,
 Anatolij Gustschin <agust@denx.de>
References: <20250530153826.1057407-1-tharvey@gateworks.com>
 <f19b630b-4a01-4e6f-b419-d2995b45198c@canonical.com>
 <CAJ+vNU2UfSVHvo=_HsCKbWH5AFsYV=SnVGru4ZBWHrGnAVBcRw@mail.gmail.com>
 <CAJ+vNU2trStWN_7jG5OxvvKtodz=qq9JVMaYHPWdpzUDJYiU=Q@mail.gmail.com>
 <63e2718b-81f8-4f2b-9d23-73d53a26b358@linaro.org>
 <CAJ+vNU2-iaDxsPYkkNC1P=OREj2c9FxNuRZrajYiT4TDnuh9Hg@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAJ+vNU2-iaDxsPYkkNC1P=OREj2c9FxNuRZrajYiT4TDnuh9Hg@mail.gmail.com>
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



On 6/16/25 19:37, Tim Harvey wrote:
> On Mon, Jun 16, 2025 at 12:18 AM Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>>
>>
>> On 6/9/25 19:35, Tim Harvey wrote:
>>> On Tue, Jun 3, 2025 at 5:04 PM Tim Harvey <tharvey@gateworks.com> wrote:
>>>>
>>>> On Sun, Jun 1, 2025 at 2:07 PM Heinrich Schuchardt
>>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>>
>>>>> On 5/30/25 17:38, Tim Harvey wrote:
>>>>>> Call schedule() in net_lwip_rx() to service U-Boot tasks and
>>>>>> actions during packet rx.
>>>>>>
>>>>>> As a cleanup also move sys_check_timeouts() here and remove it from the
>>>>>> functions that call net_lwip_rx().
>>>>>>
>>>>>> This resolves the issue of an active watchdog resetting the board on
>>>>>> long network activities.
>>>>>>
>>>>>> Suggested-by: Jerome Forissier <jerome.forissier@linaro.org>
>>>>>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>>>>>> ---
>>>>>> v2:
>>>>>>   - remove duplication of sys_check_timeouts() from functions that call
>>>>>>     net_lwip_rx()
>>>>>> ---
>>>>>>   net/lwip/dhcp.c     | 1 -
>>>>>>   net/lwip/dns.c      | 1 -
>>>>>>   net/lwip/net-lwip.c | 7 +++++++
>>>>>>   net/lwip/ping.c     | 1 -
>>>>>>   net/lwip/tftp.c     | 1 -
>>>>>>   net/lwip/wget.c     | 1 -
>>>>>>   6 files changed, 7 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
>>>>>> index 92bd7067a7fb..b79b746db390 100644
>>>>>> --- a/net/lwip/dhcp.c
>>>>>> +++ b/net/lwip/dhcp.c
>>>>>> @@ -57,7 +57,6 @@ static int dhcp_loop(struct udevice *udev)
>>>>>>       /* Wait for DHCP to complete */
>>>>>>       do {
>>>>>>               net_lwip_rx(udev, netif);
>>>>>> -             sys_check_timeouts();
>>>>>>               bound = dhcp_supplied_address(netif);
>>>>>>               if (bound)
>>>>>>                       break;
>>>>>> diff --git a/net/lwip/dns.c b/net/lwip/dns.c
>>>>>> index 19172ac959ac..738f8bf3196b 100644
>>>>>> --- a/net/lwip/dns.c
>>>>>> +++ b/net/lwip/dns.c
>>>>>> @@ -91,7 +91,6 @@ static int dns_loop(struct udevice *udev, const char *name, const char *var)
>>>>>>                       net_lwip_rx(udev, netif);
>>>>>>                       if (dns_cb_arg.done)
>>>>>>                               break;
>>>>>> -                     sys_check_timeouts();
>>>>>>                       if (ctrlc()) {
>>>>>>                               printf("\nAbort\n");
>>>>>>                               break;
>>>>>> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
>>>>>> index f05c4cd3f64f..e8d4cc542ed8 100644
>>>>>> --- a/net/lwip/net-lwip.c
>>>>>> +++ b/net/lwip/net-lwip.c
>>>>>> @@ -13,8 +13,10 @@
>>>>>>   #include <lwip/etharp.h>
>>>>>>   #include <lwip/init.h>
>>>>>>   #include <lwip/prot/etharp.h>
>>>>>> +#include <lwip/timeouts.h>
>>>>>>   #include <net.h>
>>>>>>   #include <timer.h>
>>>>>> +#include <u-boot/schedule.h>
>>>>>>
>>>>>>   /* xx:xx:xx:xx:xx:xx\0 */
>>>>>>   #define MAC_ADDR_STRLEN 18
>>>>>> @@ -284,6 +286,11 @@ int net_lwip_rx(struct udevice *udev, struct netif *netif)
>>>>>>       int len;
>>>>>>       int i;
>>>>>>
>>>>>> +     /* lwIP timers */
>>>>>> +     sys_check_timeouts();
>>>>>> +     /* Other tasks and actions */
>>>>>> +     schedule(
>>>>>
>>>>> Some scheduled tasks have a long duration, specifically video_sync_all()
>>>>> called via video_idle(). This change will lead to lost packages.
>>>>>
>>>>>
>>>>> @Tom, Simon
>>>>>
>>>>> The EFI code was impacted by 29caf9305b6f ("cyclic: Use schedule()
>>>>> instead of WATCHDOG_RESET()"). This added schedule() calls to EFI
>>>>> networking. Package losses can expected if schedule() takes more than 1
>>>>> µs. This is much shorter than the time needed for synchronizing a 1 MiB
>>>>> frame buffer. The cyclic framework was explicitly meant for short
>>>>> duration function calls, not for long duration tasks like syncing the
>>>>> video frame buffer.
>>>>>
>>>>>
>>>>> I think we should remove video_idle() from the cyclic framework.
>>>>> video_sync_all() should only be triggered if there is video output.
>>>>>
>>>>
>>>> Hi Heinrich,
>>>>
>>>> It makes sense what you are saying but I don't have the hardware to
>>>> test your scenario. Can you submit a patch for discussion with a fixes
>>>> tag?
>>>
>>> Gentle ping here.
>>>
>>> Can we get some discussion on the point Heinrich brings up about
>>> video_idle in cyclic? Without my patch here which this discussion is
>>> blocking, large lwIP network transfers are quite broken on boards with
>>> watchdogs.
>>
>> Another option might be to increase the watchdog timeout?
>>
> Hi Jerome,
> 
> I don't think that makes much sense. Long transfers for compressed
> disk images can take minutes sometimes. It doesn't make sense to not
> call any cyclic's in that timeframe.

Sorry I wasn't clear and I was mistaken.  I was not suggesting not to
call schedule() in the network receive loop, I was responding to the
fact that schedule()->video_idle()->video_sync_all() can take a long
time. I thought this would in turn cause issues with watchdogs (hence
my question if the watchdog can be adjusted), while in fact the issue
is packet loss. So please ignore my comment ;)
Not using the cyclic framework for this video thing is probably the
right thing to do I guess.

> Additionally its possible some
> older less capable watchdogs don't have that much flexibility in
> timeouts.
> 
> What Heinrich points out here seems valid but I'm not familiar with
> the video framework to work up a patch.

Yeah, same.

Thanks,
-- 
Jerome
> Best Regards,
> 
> Tim
