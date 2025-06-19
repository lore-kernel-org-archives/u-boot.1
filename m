Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B5FC71159
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 07:35:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40BBF82BA1;
	Thu, 19 Jun 2025 09:35:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cei7cuTa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A82182CD5; Thu, 19 Jun 2025 09:35:40 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1632882B18
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 09:35:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a503d9ef59so373067f8f.3
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 00:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750318537; x=1750923337; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wbg9Ts4XMlMNkELHjEURVQVk/3IiWQATKQufoAHDjvg=;
 b=cei7cuTaEzSGNrI1GH87/KFLWtIXAfM5d4j4QbAiH66bXP2eQOrbLfSEDqN8fu5tFi
 LN8rl/qJyRhg6qGyP3UZMKTH1jQvoEW4OqF3MdCIYP15sDW+BZ4pCQOvOVUY3b7dI/KO
 at22MPdDCUYEum1t7nHiZwNb+WV0GaWMeBB/bOui92OO/3xk6HbOob+vRunmszqH4NI9
 L7UtH0MdAN40NYRa7uYIRqNEjpcvMcdZaxRrX1wtuYu0o6LPfu8Xgs9hXZqyXQA15Vug
 Je6xRsXbqIwK+DRyMpm7rFDGN9+e01d5mtlk4jtNEmJgxB2Od4oWN+k0GefVkxGy4A2t
 Xpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750318537; x=1750923337;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wbg9Ts4XMlMNkELHjEURVQVk/3IiWQATKQufoAHDjvg=;
 b=tofIsjvldrRk9aSxHOHCDJwG7TG1VrAW9SRquB5BCEYIo/miLeWBiFXKnZdJlfQT3b
 hTiP2pg2v4psghHxlfyHJUPhFcKpd4XsF5IrUYpoaswLCDpnDV1mKLElsGefsk0QP68d
 KfkuGQj2Jwj5K2LA6JgfKIbSSHOrGyE/OaKMCTmYTnWA7dps0LomiEwmD8uAfdg0J2Ji
 h4oTj3716+frHw6cX+0PyWOMvt3MhwCDnmh5KXPmspZ9kPLx9y5+GCAIPEiSiTyDTA5e
 WalcbWTzp4PAoV7j8yYxHVJIK5YYW1ejk0QZ1HRTJnWmSpA5hlchai/gu8toZ/3WBa7H
 WGMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrJvoVBrsJAWXy3qpisN71ZJKy7yCkmdC3tfBX4LNyrij7zdGb3cBmabeHBM66ga8kW2cmpUA=@lists.denx.de
X-Gm-Message-State: AOJu0YyHtzedMZPVc61dFhulunrIkpBDEhPs8zVx4hEOa+fgDMEZrPgJ
 8nvcjSpZ6lTl5x5qhqkuQDsjhJWiegc4MOoa35XdxLTVRSdXuCCbU/A1hBwN1uvFX+E=
X-Gm-Gg: ASbGncsr+DI+HMUe0JJfnUHlNwgkAYMVve1mxqcHxeUJbVpMVydgKH34K9s6pgRC8eH
 rv3h6zUe6L0vLkIrcfI7tg9Hvzqd1pvBWqVKSBcnx4+wBFuUEM7PxOexqD4ScO/2qTEQ+oIET5o
 djoAqZ6Dm+WaG8e3aKoudZviMBBvKYtTOlLDG8PdPM2hbJXDbIUKlDqdgOhKonEqM16XqwBXgLy
 LS7+lUh+Qy5AgpVV9yFA43dpJ2usPv/+6JCYT83h9RT1YV/zdson5Fa7v4KnWZA65iSTj4a6de4
 Fy7/RTFEL4wSusQyNO1wcDV7SmpQHTxU0vapcGC/yE4/Ed4l7TLADkh7WGNHhynaIL44RvAB9Mv
 5c3OORoYtOQd7FelgyVQ7JnuG0W06UxbxzfSIwzjtQw==
X-Google-Smtp-Source: AGHT+IGAAPqPYl56qQuG2RcPHM0agCrLyy5kUZ9P6CpA26MscZNvvG7o3fDsAC4kt/R7VxptynedDQ==
X-Received: by 2002:a05:6000:1acb:b0:3a4:f038:af76 with SMTP id
 ffacd0b85a97d-3a572e886ddmr17754632f8f.53.1750318537440; 
 Thu, 19 Jun 2025 00:35:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:74f8:af5e:a2d5:5049?
 ([2a01:e0a:3cb:7bb0:74f8:af5e:a2d5:5049])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b5c372sm18356251f8f.89.2025.06.19.00.35.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 00:35:37 -0700 (PDT)
Message-ID: <12e60010-a856-4db1-84e5-d5bdf289a449@linaro.org>
Date: Thu, 19 Jun 2025 09:35:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] net: lwip: call sys_check_timeouts and schedule on
 rx
To: Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Anatolij Gustschin <agust@denx.de>
References: <20250530153826.1057407-1-tharvey@gateworks.com>
 <f19b630b-4a01-4e6f-b419-d2995b45198c@canonical.com>
 <20250617224551.GA1687135@bill-the-cat>
 <CAJ+vNU2oNMpupHLHHcf3HTXBTN8mnPczo6T8khAkN875YwmUxg@mail.gmail.com>
 <CAJ+vNU3UH2fMBc=fg4aMvUCdxHf4ADf2KeApBeiCiGrrNyc+ew@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAJ+vNU3UH2fMBc=fg4aMvUCdxHf4ADf2KeApBeiCiGrrNyc+ew@mail.gmail.com>
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



On 6/18/25 21:38, Tim Harvey wrote:
> On Wed, Jun 18, 2025 at 8:32 AM Tim Harvey <tharvey@gateworks.com> wrote:
>>
>> On Tue, Jun 17, 2025 at 3:45 PM Tom Rini <trini@konsulko.com> wrote:
>>>
>>> On Sun, Jun 01, 2025 at 11:07:16PM +0200, Heinrich Schuchardt wrote:
>>>> On 5/30/25 17:38, Tim Harvey wrote:
>>>>> Call schedule() in net_lwip_rx() to service U-Boot tasks and
>>>>> actions during packet rx.
>>>>>
>>>>> As a cleanup also move sys_check_timeouts() here and remove it from the
>>>>> functions that call net_lwip_rx().
>>>>>
>>>>> This resolves the issue of an active watchdog resetting the board on
>>>>> long network activities.
>>>>>
>>>>> Suggested-by: Jerome Forissier <jerome.forissier@linaro.org>
>>>>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>>>>> ---
>>>>> v2:
>>>>>   - remove duplication of sys_check_timeouts() from functions that call
>>>>>     net_lwip_rx()
>>>>> ---
>>>>>   net/lwip/dhcp.c     | 1 -
>>>>>   net/lwip/dns.c      | 1 -
>>>>>   net/lwip/net-lwip.c | 7 +++++++
>>>>>   net/lwip/ping.c     | 1 -
>>>>>   net/lwip/tftp.c     | 1 -
>>>>>   net/lwip/wget.c     | 1 -
>>>>>   6 files changed, 7 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
>>>>> index 92bd7067a7fb..b79b746db390 100644
>>>>> --- a/net/lwip/dhcp.c
>>>>> +++ b/net/lwip/dhcp.c
>>>>> @@ -57,7 +57,6 @@ static int dhcp_loop(struct udevice *udev)
>>>>>     /* Wait for DHCP to complete */
>>>>>     do {
>>>>>             net_lwip_rx(udev, netif);
>>>>> -           sys_check_timeouts();
>>>>>             bound = dhcp_supplied_address(netif);
>>>>>             if (bound)
>>>>>                     break;
>>>>> diff --git a/net/lwip/dns.c b/net/lwip/dns.c
>>>>> index 19172ac959ac..738f8bf3196b 100644
>>>>> --- a/net/lwip/dns.c
>>>>> +++ b/net/lwip/dns.c
>>>>> @@ -91,7 +91,6 @@ static int dns_loop(struct udevice *udev, const char *name, const char *var)
>>>>>                     net_lwip_rx(udev, netif);
>>>>>                     if (dns_cb_arg.done)
>>>>>                             break;
>>>>> -                   sys_check_timeouts();
>>>>>                     if (ctrlc()) {
>>>>>                             printf("\nAbort\n");
>>>>>                             break;
>>>>> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
>>>>> index f05c4cd3f64f..e8d4cc542ed8 100644
>>>>> --- a/net/lwip/net-lwip.c
>>>>> +++ b/net/lwip/net-lwip.c
>>>>> @@ -13,8 +13,10 @@
>>>>>   #include <lwip/etharp.h>
>>>>>   #include <lwip/init.h>
>>>>>   #include <lwip/prot/etharp.h>
>>>>> +#include <lwip/timeouts.h>
>>>>>   #include <net.h>
>>>>>   #include <timer.h>
>>>>> +#include <u-boot/schedule.h>
>>>>>   /* xx:xx:xx:xx:xx:xx\0 */
>>>>>   #define MAC_ADDR_STRLEN 18
>>>>> @@ -284,6 +286,11 @@ int net_lwip_rx(struct udevice *udev, struct netif *netif)
>>>>>     int len;
>>>>>     int i;
>>>>> +   /* lwIP timers */
>>>>> +   sys_check_timeouts();
>>>>> +   /* Other tasks and actions */
>>>>> +   schedule(
>>>>
>>>> Some scheduled tasks have a long duration, specifically video_sync_all()
>>>> called via video_idle(). This change will lead to lost packages.
>>>>
>>>>
>>>> @Tom, Simon
>>>>
>>>> The EFI code was impacted by 29caf9305b6f ("cyclic: Use schedule() instead
>>>> of WATCHDOG_RESET()"). This added schedule() calls to EFI networking.
>>>> Package losses can expected if schedule() takes more than 1 µs. This is much
>>>> shorter than the time needed for synchronizing a 1 MiB frame buffer. The
>>>> cyclic framework was explicitly meant for short duration function calls, not
>>>> for long duration tasks like syncing the video frame buffer.
>>>>
>>>>
>>>> I think we should remove video_idle() from the cyclic framework.
>>>> video_sync_all() should only be triggered if there is video output.
>>>
>>> So for testing purposes, if CYCLIC is disabled but LWIP is enabled,
>>> things are fine here? And so we need to at least partially revert commit
>>> 5c8dddadf1c9 ("video: Use cyclic to handle video sync") if not fully
>>> revert it?
>>
>> Hi Tom,
>>
>> I can't disable CYCLIC without also disabling WDT which then works
>> fine as the watchdog isn't being used.
>>
>> You are likely pointing to the correct patch that is causing
>> Heinrich's issue but as far as I know he has the
>> hardware/configuration needed to test this and I don't know how to
>> re-create his issue.
>>
>> So in my opinion there is nothing wrong with my patch here and it's
>> more of an issue with the video using cyclic for video sync.

I agree. This patch is:

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>


...and I will add the whole series in my next PR to Tom.

Thanks,

-- 
Jerome

>>
> 
> Incidentally, I've noticed that I only have this
> watchdog-not-getting-reset issue when using the IMX FEC driver. The
> IMX QOS (imx8mp) has calls to udelay in the packet send and udelay
> calls schedule. I'm not sure how many network drivers out there end up
> calling udelay/schedule on their own.
> 
> Best Regards,
> 
> Tim
