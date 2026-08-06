Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548CDC5AC7C
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 17:40:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC87380DCA;
	Thu,  6 Aug 2026 17:40:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pbe9gMroTCvT; Thu,  6 Aug 2026 17:40:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1D85B80E63
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786038012;
	bh=YSEudvUQkZ7LaUgFMiF21PA/jUPow2MNXpq9w29cWak=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IXPmxx9xkwLUEAEnOnYeB75rjPl6gGsdMl7PmshJ2AyVj9sXjJcQ4XeBZfVtZsbuF
	 OPCQmi25RnKPNlorXYhtUpHiwINTUxOYxO1i7h0EoL4vcXqLXjyWgWKfQ2HqYyl8i1
	 yf+edgmJaB/WYC6XIDsiWvamWUuG3a7leYpG8qgBwCBoj2qZnjxy5K8aFe8MJr+1oS
	 XqOxboU1x66/ijdUXjululHD4Zxng13OyKUmaf6vz1Rkwaps1lffJfX+wX44W8It2d
	 nGzvFBB0DNrIUraUucvXOsTc9bVbD6LttFTvAsyx6ewEEjuU7rlJi4su0b4nTVJGko
	 IUTyglZatCYaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D85B80E63;
	Thu,  6 Aug 2026 17:40:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EEFAE2B6
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 17:40:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CCC4580E63
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 17:40:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CYYP-y_0ew3H for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 17:40:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=165c=ga=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E659C80DCA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E659C80DCA
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E659C80DCA
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 17:40:08 +0000 (UTC)
X-Forward-Email-ID: 6a74c6f33d42beda28bc536d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.10
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <86a8a080-ec65-46e1-9a12-5b0fe28173ee@kwiboo.se>
Date: Thu, 6 Aug 2026 19:40:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] rockchip: spl: replace ifdef by IS_ENABLED for
 timer_init() call condition
To: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Cc: Johan Jonker <jbx6244@gmail.com>, kever.yang@rock-chips.com,
 sjg@chromium.org, ilias.apalodimas@linaro.org,
 u-boot@lists.u-boot-project.org
References: <cded3ae1-b908-49c6-af92-30b931d160c1@gmail.com>
 <c6530788-e823-4cb4-905a-5473d9c00914@cherry.de>
 <6e43369a-832e-40d3-af23-a0981af84d75@gmail.com>
 <75f48c14-bad9-4250-a4b5-321cc17bc1ec@cherry.de>
 <20260730220623.GI1773261@bill-the-cat>
 <f3d4bfd6-3b99-426b-b025-d236b9feedff@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <f3d4bfd6-3b99-426b-b025-d236b9feedff@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1786038007;
 bh=YSEudvUQkZ7LaUgFMiF21PA/jUPow2MNXpq9w29cWak=;
 b=C/yZanVBfJ19Zs/Tm/aU/JftSCz+hjnor5KLWBStwKmzCNvRGiMjsrz1h81DokeLfOeYPFm5C
 9pX8RDORhGrbgPIrEkH9gt9Hjt/JyxyVkDpHd3lxJxvvG0tOxW+k7S7j7KAhnuSKnqzVgfCE8qY
 5LID9l3kpQs/wD5yvOVYI96uNS0znARgrR75eD+YAwznEtIKpNyU9/v0iMKPLmr97JX62b0WrGK
 YqsO4Rg/oYS3IKEfZXLRJkDcSg0XvQU371T8hqxyP4lNrtczjy7hTU/SFHToDsFSf9Kv82hVWwX
 vgu5w/vkToOtdvKvLT0O3omkM6qfHEj7Jv3XWsBxNXgg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=C/yZanVB
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/6/2026 6:46 PM, Quentin Schulz wrote:
> On 7/31/26 12:06 AM, Tom Rini wrote:
>> On Thu, Jul 30, 2026 at 05:37:52PM +0200, Quentin Schulz wrote:
>>> Hi Johan,
>>>
>>> On 7/24/26 11:53 AM, Johan Jonker wrote:
>>>>
>>>>
>>>> On 7/24/26 10:45, Quentin Schulz wrote:
>>>>> Hi Johan,
>>>>>
>>>>> On 7/24/26 12:17 AM, Johan Jonker wrote:
>>>>>> Not all Rockchip SoC models use the ARM arch timer.
>>>>>> Call the function timer_init() only when
>>>>>> CONFIG_SYS_ARCH_TIMER is available.
>>>>>> Replace the ifdef call condition by IS_ENABLED
>>>>>> to increase build coverage and make the code easier to read.
>>>>>>
>>>>>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>>>>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>>>>> ---
>>>>>>
>>>>>> Previous version not needed for serie, so resend separate.
>>>>>> https://patchwork.ozlabs.org/project/uboot/patch/20220403230659.12039-5-jbx6244@gmail.com/
>>>>>>
>>>>>
>>>>
>>>> Hi Quentin,
>>>>> You didn't answer Kever's question in the linked patch and I have the same question.
>>>>
>>>> Yes we end up the same code. But...
>>>>
>>>>>
>>>>> This is essentially the same code, so what's the benefit, are you trying to fix a specific issue? How does this improve the situation?
>>>>    > How does doing that increase code coverage... etc :)
>>>>
>>>> This patch originates around the time this concept as introduced.
>>>> We are changing all code to the new norm and we leave this as it is...
>>>> Fix this as well as a favor to Simon as part of the review. As we are there then fix them all as this is the new norm.
>>>> https://patchwork.ozlabs.org/project/uboot/patch/20220403230659.12039-6-jbx6244@gmail.com/
>>>>
>>>
>>> This doesn't point at what Simon could have said that prompted this patch.
>>> The pointed patch did actually fix something, and instead of using
>>>
>>> #ifdef CONFIG_SYS_ARCH_TIMER
>>>
>>> you used
>>>
>>>      if (IS_ENABLED(CONFIG_SYS_ARCH_TIMER))
>>>
>>> which is absolutely the correct and "modern" way of doing it.
>>
>> Right, and when it makes sense to and improves the readability of the
>> overall code. If it not a must-do every time. There is a judgement call
>> to it.
>>
>>>> The concept:
>>>>
>>>> Currently with #ifdef the compiler sees this code:
>>>> =============
>>>>
>>>> 	rockchip_stimer_init();
>>>>
>>>> 	ret = dram_init();
>>>>
>>>> =============
>>>>
>>>> Now the compiler sees this code:
>>>>
>>>>
>>>> int timer_init(void)
>>>> {
>>>> 	gd->arch.tbl = 0;
>>>> 	gd->arch.tbu = 0;
>>>>
>>>> #ifdef CFG_SYS_HZ_CLOCK
>>>> 	gd->arch.timer_rate_hz = CFG_SYS_HZ_CLOCK;
>>>> #else
>>>> 	gd->arch.timer_rate_hz = read_cntfrq();
>>>> #endif
>>>> 	return 0;
>>>> }
>>>>
>>>>
>>>>
>>>> 	rockchip_stimer_init();
>>>>
>>>> 	if (IS_ENABLED(CONFIG_SYS_ARCH_TIMER))
>>>> 		timer_init();
>>>>
>>>> 	ret = dram_init();
>>>>
>>>> ============
>>>>
>>>> By using IS_ENABLED and CONFIG_IS_ENABLED the compiler is able to look further into code and catch possible errors or warnings.
>>>
>>> I don't know anything about compilers but I'm surprised this would actually
>>> do anything different than what we currently have.
>>>
>>> If CONFIG_SYS_ARCH_TIMER is not set, then you get
>>>
>>> if (0)
>>>      timer_init();
>>>
>>> which the compiler will (hopefully) see as a non-reachable branch and
>>> discard it.
>>>
>>> Otherwise, it'll be:
>>>
>>> if (1)
>>>      timer_init();
>>>
>>> which hopefully the compiler will simply replace without the branch:
>>>
>>> timer_init();
>>>
>>> Maybe Simon or someone else can teach me something here because my naive
>>> view on this is: does not make a difference. What kind of benefits do we
>>> have, what do you run to see those benefits?
>>
>> The compiler benefit that using IS_ENABLED provides is that we will make
>> sure that timer_init is declared in a header that is included. That's
>> it. It can be useful for more generic code, but it's of course imperfect
>> if the include chain brings it on some platforms, but not others (as a
>> warning pointed out on IRC today reminded me).
>>
> 
> Yeah I'm not too sure of the benefit. We need to have timer_init() 
> defined and thus may require "fallbacks" that are just empty stubs. 
> Jonas had a look at doing size optimization for TPL for Rockchip a month 
> ago and if i remember correctly, empty __weak stubs were actually 
> costing a few bytes compared to simply not having one declared. See 
> https://libera.catirclogs.org/linux-rockchip/2026-07-01 for some context.

Correct, an empty weak function will still cost 8 bytes on AArch64, most
likely branch and return instructions. And it seem to be similar for
a call to timer_init() in Rockchip TPL.

I have since then learned that if we use a '__weak void func(void);'
declaration without a default empty definition the entire operation is
optimized out at link time.

I even have one pending patch related to that TPL work that will drop
the default definition of the Rockchip TPL specific tpl_board_init() to
save those 8 bytes, and another one to make the timer_init() call
conditional on !IS_ENABLED(CONFIG_ARM64) to save 8 more bytes :-)

Regards,
Jonas

> 
>>>> There is even a warning for it in ./scripts/checkpatch.pl
>>>>
>>>
>>> I'm aware, I quite often trigger it :)
>>>
>>>> ============
>>>> __weak void rockchip_stimer_init(void)
>>>> {
>>>> #if defined(CONFIG_ROCKCHIP_STIMER_BASE)
>>>>
>>>> #endif
>>>> }
>>>> ============
>>>> There are exceptions like in rockchip_stimer_init where certain defines are missing, so that's still allowed.
>>>> In all other settings we use IS_ENABLED and CONFIG_IS_ENABLED.
>>>> Hope that explains your questions.
>>>>
>>>
>>> Not really no, sorry.
>>>
>>> The commit log is misleading and needs rewording. As far as my understanding
>>> goes, it's clean-up. Maybe there's something helpful for the compiler but
>>> you need to prove it because I don't see it (I'm interested to know if it
>>> does, so please tell us!).
>>
>> I agree, at minimum, the commit message isn't clear that we're just
>> replacing #ifdef with if (IS_ENABLED()) as a clean-up. I'll defer to
>> Quentin on if that's worthwhile doing here, or not.
>>
> 
> It's fine for me, I just don't want to only receive that kind of patches 
> as I don't find them particularly useful :)
> 
> Cheers,
> Quentin

