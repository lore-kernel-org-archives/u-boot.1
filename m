Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BF6109C05B
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 20:12:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7F3183CD3;
	Wed, 25 Mar 2026 21:12:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Ks8ckR/p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E98D83DA6; Wed, 25 Mar 2026 21:12:38 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82D8E83A91
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 21:12:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e7f4=B2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1774469554;
 bh=zHHwz/+3M7NfTahxD6ru0zt1ES7K64xNpVDwnEHLHg8=;
 b=Ks8ckR/pfbcpFhhkYVthqkl+8DKZHMuRWlxE0CNthxvgv3ZmF9TP4FEw/XN14UFvgHzan73DZ
 IqcMDyX8P7c04TDsfPsyQnpTMDBvpb3Ybvo4IDDo7FesdKIl+FciDXyHDDPi+anX0gT9Vrn8v7O
 8iMra4emvuQaEnHdE51LUSQm4jd4vGUT7P2IHiOkCb9BUNjBf4FFavCE3iHtIn4uZz+JAwj2OIy
 ppycF+u0t6ixKsh3K+/50SshGA2V8y0vyNlXAqpbT7IjtW0pn3nWvTMK5it+qsOt5ARJanW9yH9
 pxfsDoOygm5CjbBG6QiKH4dPJkl4WYYUHFwcUIfuAKcA==
X-Forward-Email-ID: 69c441b167e6eae9db0904fd
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.6.55
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <c67bddd4-3827-4e72-a08e-99691cea2165@kwiboo.se>
Date: Wed, 25 Mar 2026 21:12:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: rockchip: Guard call of board_early_init_f in SPL
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
References: <20260325190025.3428560-1-trini@konsulko.com>
 <fb6ee141-3369-45e6-8320-e91f67ec6b1e@kwiboo.se>
 <CAFLszTiF4RDyo8+4RZhsNViSNquU3Ouq2fNr5NjG7PvK+2zrtg@mail.gmail.com>
 <20260325195129.GX502704@bill-the-cat>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260325195129.GX502704@bill-the-cat>
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

On 3/25/2026 8:51 PM, Tom Rini wrote:
> On Wed, Mar 25, 2026 at 01:42:28PM -0600, Simon Glass wrote:
>> Hi Jonas,
>>
>> On Wed, 25 Mar 2026 at 13:31, Jonas Karlman <jonas@kwiboo.se> wrote:
>>>
>>> Hi Tom,
>>>
>>> On 3/25/2026 8:00 PM, Tom Rini wrote:
>>>> Today, no platforms call board_early_init_f, and rockchip provides a
>>>> weak default function. Change this to not providing a weak function and
>>>> only call board_early_init_f if CONFIG_BOARD_EARLY_INIT_F is enabled.
>>>> This will allow any potential future needs to be taken care of, and make
>>>> future consolidation easier.
>>>>
>>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>>> ---
>>>> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
>>>> Cc: Kever Yang <kever.yang@rock-chips.com>
>>>> ---
>>>>  arch/arm/mach-rockchip/spl.c | 8 ++------
>>>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
>>>> index e989c148079a..8026cc0abb8d 100644
>>>> --- a/arch/arm/mach-rockchip/spl.c
>>>> +++ b/arch/arm/mach-rockchip/spl.c
>>>> @@ -97,11 +97,6 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
>>>>       return MMCSD_MODE_RAW;
>>>>  }
>>>>
>>>> -__weak int board_early_init_f(void)
>>>> -{
>>>> -     return 0;
>>>> -}
>>>> -
>>>>  __weak int arch_cpu_init(void)
>>>>  {
>>>>       return 0;
>>>> @@ -111,7 +106,8 @@ void board_init_f(ulong dummy)
>>>>  {
>>>>       int ret;
>>>>
>>>> -     board_early_init_f();
>>>> +     if (IS_ENABLED(CONFIG_BOARD_EARLY_INIT_F))
>>>
>>> This patch seem to introduce a change in behavior for chromebook bob and
>>> kevin, they do not seem to enable BOARD_EARLY_INIT_F, yet they have a
>>> board_early_init_f() in board/google/gru/gru.c no longer being called
>>> after this change.
> 
> I wouldn't call it a behavior change, since it's not called now, and

You mean the function is currently being optimized out? Why would it not
be called before the change introduced in this patch?

The code in board/google/gru/gru.c is silly and probably gets optimized
out anyway, but the comment there suggest something was done to try and
make so it was not.

> this is the output from building before/after, checking for size
> differnces (and how I spotted odd cases as part of this overall work):
> 
>             chromebook_bob : spl/u-boot-spl:all -8 spl/u-boot-spl:text -8
>                spl-u-boot-spl: add: 0/-1, grow: 0/-1 bytes: 0/-12 (-12)
>                  function                                   old     new   delta
>                  board_init_f                               148     144      -4
>                  board_early_init_f                           8       -      -8
>             chromebook_kevin: spl/u-boot-spl:all -8 spl/u-boot-spl:text -8
>                spl-u-boot-spl: add: 0/-1, grow: 0/-1 bytes: 0/-12 (-12)
>                  function                                   old     new   delta
>                  board_init_f                               148     144      -4
>                  board_early_init_f                           8       -      -8
> 
> 
>>> I do not have a chromebook_bob/kevin so I cannot help verify if this
>>> change break anything, hopefully Simon can help test/verify.
>>
>> Kevin spews some junk to the console with or without this patch.
>>
>> No change observed on bob or kevin. BTW both are in the lab so you
>> should be able to test if you push to your tree.
>>
>> Tested-by: Simon Glass <sjg@chromium.org>  # chromebook_kevin
>> Tested-by: Simon Glass <sjg@chromium.org>  # chromebook_bob
> 
> Perhaps the problem is those platforms should be enabling, but lost.
> I'll take a look, but would be unrelated to this (since if enabling
> BOARD_EARLY_INIT_F it would then call it).

board_early_init_f() in gru.c is wrapped around CONFIG_XPL_BUILD so
should only be included in SPL and was called from rockchip spl.c
board_init_f() prior to this patch.

Based on Simons comment I guess the board_early_init_f() in gru.c
probably could and should be fully removed, as it currently does not
seem to provide the suggested delay.

Regards,
Jonas
