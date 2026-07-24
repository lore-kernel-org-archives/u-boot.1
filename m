Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47236C531FA
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 07:36:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D638F80FB4;
	Fri, 24 Jul 2026 07:36:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TBUciI7p5xuc; Fri, 24 Jul 2026 07:36:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3413180F78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784878597;
	bh=5VI3/N/DQx9Vkhy4hjxJMqAWzxyvnbi0MA6clpufSYo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MKUn+zjAzTE1XCE47ZTyc9fzj5bD+TmPOACZgktTNf0guNrcFdOFQe4MAR+ewZNHc
	 uQ3HYRvlf2Tl5N2TlEClamKiolPrRV1bxJtdXFKh7eXLAeZFaIVa9pPob7U9XCZahb
	 gB6QXspPowUktJXbqrmL+5w8CQwgqIRVeb9KaOZrblZRKwWS+lu7WLeP4275aDSllf
	 SXg9OOIb84eU4SKAU54drnnQZMZX98H8fHHHj+ubEu5ZjQG64h5+vhI02Yw0NEaZBL
	 4h9P+a/rfR8vdA2HZ4FgXIlol4E1BoIcjbXbX9lXTuszC53BKR5+7L2XjlKtSte4Ye
	 KBBqsB5ABI8LQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3413180F78;
	Fri, 24 Jul 2026 07:36:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8FCB7A47
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 07:36:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 75BB540156
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 07:36:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mw2gwC6r0NEb for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 07:36:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=ghidoliemanuele@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A03CC400A0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A03CC400A0
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A03CC400A0
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 07:36:35 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47f7872abb6so79242f8f.3
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 00:36:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784878593; x=1785483393;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5VI3/N/DQx9Vkhy4hjxJMqAWzxyvnbi0MA6clpufSYo=;
 b=AblTuC2ILWZ/FYn5zTdWAKW+ihpUdjuuKpTtkhwWEwOmc4ZKyS7aikzOp4+0L0LgUd
 j+EiT0d6KuYennCj/xXOcx5j4+xfbexyIddFqKp0lzxN3sulb5dp7QpBt9I201INOSFv
 NK1t/KTYldeK8onP5AgfYYh9nGFHNXJORBopCnyqM1kBMF1iDpajrW/wcxrm0feZxhVc
 0bqVf4cbdcPrQvUAto1CpcyzJEcd8xHYFSucioYb8zdlOcb45MBLIX5RQlmKTsC0IlcM
 0BP4jc8EeQLzPsk6vD8SGKOQZ+jt/o45uy0C6oGaoLXHhuXQNnS1iE7Bb6NEJpdLT3Va
 nAew==
X-Forwarded-Encrypted: i=1;
 AHgh+RpJPki1a/LzMdQT8GJOgvkdPmC2VB4JnryRytj5lE3q225FSW7AhwoUV2txVF19pgrthNINdOo=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwtLjQRRK4X/2NTgROCq45uonbUu5KkqLZJStQ01fjxrua1UFeG
 kESY5Z9KOdmAMRAMvEvYsI4aWCjIEz8Cp2EEK/js+bsxhuSggeOEgwTr
X-Gm-Gg: AR+sD10MHWx/rpUf5HbAHGZfXEVFY4xgQYCbm1NGZkjU+4eUmJqTN1R2/gtnsfyYe1o
 3h8b/rckH8K/52rD4NRFwHV1NRHkihHbt0Z3rdHMZshZayYXPVWfveSrg0SrD5nCSblrtqmk610
 jfeKHvD7vgzBuUCLZs9iLFFDHjzYW/HIwk/nSxoVhl20+DtezgsrI26ZEyBdzG4fwZvqXByApOk
 D6i8yK2VK8QE2Emcx0XKT15nEwDiZ3IhXmPuMfw1Q5WKSUnnQ9eeLkaxPyW+LrDaFYIqS1D0FAr
 CMsit3g9lpTvN+fe6vSy3LinFDWWyqkA/ZnP8EnSa6kefHaD6IbLe+D7yLqHW9Paq4R6+NE23qC
 cUIiT9k6zgfdDiT9R2hLw2Cn9Cwddb1L9lwQH+m4oPaT0njEqLCzSn+R9x6rvCU+funPP9ddQSi
 549BiMqLSq9fvNRNq5dY1zmdzgtndyZAp6X3ggp0kBrRhocnijhbclx5XJmy4=
X-Received: by 2002:a05:6000:1841:b0:47f:93fc:2d27 with SMTP id
 ffacd0b85a97d-47f93fc2ecbmr4122074f8f.30.1784878593346; 
 Fri, 24 Jul 2026 00:36:33 -0700 (PDT)
Received: from [192.168.68.84] (host-87-5-153-198.retail.telecomitalia.it.
 [87.5.153.198]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c66cebsm21237681f8f.30.2026.07.24.00.36.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 00:36:33 -0700 (PDT)
Message-ID: <a164c15a-9331-4361-8a50-692e9855512a@gmail.com>
Date: Fri, 24 Jul 2026 09:36:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression on colibri-imx7 due to commit 9c1b13b3fd27 ("cyclic:
 reduce get_timer_us() calls inside hlist_for_each_entry_safe()")
To: Marek Vasut <marek.vasut@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
References: <27d77997-2651-423f-ba1d-652d5a133e39@gmail.com>
 <23084e8e-ad4c-4f37-872a-9d2a8feb325f@mailbox.org>
 <140e540b-08a7-4fca-a6fa-ee398d92dbea@gmail.com>
 <0c11f834-7b7a-4e94-90b3-23de79040b4a@mailbox.org>
Content-Language: en-US
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
In-Reply-To: <0c11f834-7b7a-4e94-90b3-23de79040b4a@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784878593; x=1785483393;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5VI3/N/DQx9Vkhy4hjxJMqAWzxyvnbi0MA6clpufSYo=;
 b=qpyPtWxxUBR2sVjSCuS381VklNQahU3yGQS12bP57kl+/3R1wpbnkaav+qT/vJ+6Or
 4BuTJ7e33VzkB+RT7ZK3Anj9rd2l0/49B/rBZk7kkwxMgR5z2hU5nWzPtH09nX8imloX
 bts3vC4HS/uWfM1QCvERF/GVE6N0ULS0o8yGZdHzX7HRbSPjL4gVdfYNe1Msq/EBBVAe
 93z/VuL+biV+B+3uuajTzIILxE0VeKDDrf/PMvkJ4vfYmp1I8Edg9bqqg+FKogS4ZGai
 CdT2EEOVnreC+kPIpUI+U+Y/Fxtft0UKCY3Np/WuU93Y1PYwb0swEX5B+2+XhNZTJ1YF
 YYTw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=qpyPtWxx
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



On 7/24/26 02:00, Marek Vasut wrote:
> On 7/23/26 10:41 PM, Emanuele Ghidoli wrote:
>>
>>
>> On 7/23/26 20:35, Marek Vasut wrote:
>>> On 7/23/26 4:53 PM, Emanuele Ghidoli wrote:
>>>
>>> Hello everyone,
>>>
>>>> I found that Colibri iMX7 no longer boots when commit 9c1b13b3fd27
>>>> ("cyclic: reduce get_timer_us() calls inside hlist_for_each_entry_safe()")
>>>> is applied. Nothing is printed on the serial.
>>>>
>>>> I bisected the issue: booting the parent commit works fine, and
>>>> reverting this patch on top of current main also restores
>>>> boot. It's not yet obvious to me what in this change causes the
>>>> regression.
>>>>
>>>> Would it make sense to revert it until the root cause is found?
>>>
>>> Give Patrice a bit of time to analyze the problem.
>>>
>>
>> Hello,
>>
>> after the regression, get_timer_us() is called on every cyclic_run() call,
>> even when the cyclic list is empty. On imx7 this happens earlier than before,
>> when the timer has not yet been initialized: get_timer_us() calls get_tbclk(),
>> whose value is zero, and uses it as a divisor in tick_to_time_us(), leading to
>> a division by zero.
>>
>> I would fix this by ensuring get_tbclk() returns at least 1 on imx7, but we
>> could hide bugs in this way. However, this bug could also be present on other
>> architectures, so I would just guard against entering the cyclic loop by
>> checking whether the list is empty before doing anything else, so
>> get_timer_us() is called "at the same point in time" as before.
>> Something like:
>> if (hlist_empty(cyclic_get_list())) {
>>     gd->flags &= ~GD_FLG_CYCLIC_RUNNING;
>>     return;
>> }
> It looks like there are two topics -- optimize the cyclic run and fix the MX7
> timer.
> 
> I agree the cyclic run should exit if the list is empty, but please wait for
> input from Rasmus on that.
> 
> Regarding the timer, how come the timer is initialized so late on MX7 ?
timer_init() called in initcall_run_f().>
> The Cortex-A7 should have its own ARM timer, that should be available right
> from the beginning. Is that ARM timer in use on your system, or does your
> system use GPT timer ?
iMX7 uses arch/arm/mach-imx/syscounter.c.

udelay() is called in initcall_run_f(), before timer_init().
arch_cpu_init() (arch/arm/mach-imx/mx7/soc.c) -> imx_gpcv2_init -> udelay
(which runs schedule/cyclic).

And this is interesting, udelay() before timer_init() leads to a 0 us delay,
so there is another bug.

I have verified that removing this udelay(65) the board boots.
> 
> Which board is this ?
board/toradex/colibri_imx7/
> 
> +CC Peng

Kind regards,
Emanuele
