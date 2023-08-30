Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD6CC6FA8F
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 19:12:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F3738653F;
	Wed, 30 Aug 2023 21:12:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ACVcOwr/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FED38653F; Wed, 30 Aug 2023 21:12:52 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37B598653E
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 21:12:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31768ce2e81so5015785f8f.1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 12:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693422767; x=1694027567; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M4qvSKBd+8qAzEGVd4+uEtjvUKHRFljUJI0HM1DprPg=;
 b=ACVcOwr/K3cRYKUuesFFpv6z3XiFcfSMECiBDzLaZ64Apf3MPnE24mJMzP4Z4oky4T
 hTiexhBpXUXiwjpBy4FVxpuXFGVsNC8OqAqioJ0l7xxqTh1Uiu8qLWPVpxGK5VPyv5b9
 pvzZrdzj6jyNCp4+BI8F1Sg+5C8griNtWgBMEwC26Q+V+O2VYjOyaToacl9QFVDcG46z
 Y6Kq4d6G9XOL+qTluvirOCZBR1AjAYxFYkzB91HVJ1g9cX6Av8Tuyw+VXo7eEdZxAtPF
 CbWpopWwrwnD/qBWui80wVGu5zqC1KQUVrQWNF0vwIHNHq7VnGxn2OhNYPIDmwwiCbUw
 ZvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693422767; x=1694027567;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M4qvSKBd+8qAzEGVd4+uEtjvUKHRFljUJI0HM1DprPg=;
 b=A9rweeOQwujiLXpIqBDsjbhS/L305vIoBM/qrHiz1HfuXcMCvmS/xl37vXogQKldeg
 dKil/yeYOHJpehaUDE+Mecp7u37fLirnECMKlgswb6F0u4tlVwPc/1KYQ11alBpVpzVF
 lOJDaqEbgQJmDExfSEP9XrvwO+gRIaO8fI176vGF1mBSi2DBt+Va1PjaAQf8rWO8wSKe
 SvbSBG5Gv5SwooWw33yWVhNhlSuitv+ofN9G8Tx6+dSFGGIC4ZZeaK3cPbGQdS2xEAdF
 fcIMK+ctDKJvk7oknN291R3vtkht8aej2AhwErG3ixRs7kDDVYn+ZdQ91RnSiN2Fmsnj
 CBJg==
X-Gm-Message-State: AOJu0YzjnjOWu2Tthfed/HWItAdyqAhjHq3crA2JGMIBpJ0/v2aRsGd6
 ZQR2DsBSCqxuG5BboTAZszU=
X-Google-Smtp-Source: AGHT+IElYKdUGnTaMoOgulCKXhwLtLm6+/pitlvsJlgrGPI77h24RKYtTmWQNVqu5l3+XjCoqGN/gg==
X-Received: by 2002:adf:fd85:0:b0:313:dee2:e052 with SMTP id
 d5-20020adffd85000000b00313dee2e052mr2228062wrr.26.1693422767339; 
 Wed, 30 Aug 2023 12:12:47 -0700 (PDT)
Received: from [192.168.0.84] ([178.233.24.1])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a5d6503000000b00317c742ca9asm17305581wru.43.2023.08.30.12.12.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 12:12:46 -0700 (PDT)
Message-ID: <2f283c6b-bf2c-4893-b286-25a44ff37dd1@gmail.com>
Date: Wed, 30 Aug 2023 22:12:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/13] video: Only dcache flush damaged lines
Content-Language: en-US, tr, en-GB
To: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>
Cc: u-boot@lists.denx.de, Kever Yang <kever.yang@rock-chips.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Andrew Davis <afd@ti.com>,
 Da Xue <da@libre.computer>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Derald Woods <woods.technical@gmail.com>, Anatolij Gustschin
 <agust@denx.de>, uboot-stm32@st-md-mailman.stormreply.com,
 Matthias Brugger <mbrugger@suse.com>, u-boot-amlogic@groups.io,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20230821135111.3558478-1-alpernebiyasak@gmail.com>
 <20230821135111.3558478-11-alpernebiyasak@gmail.com>
 <CAPnjgZ2_9s_n9RWO_t_UUJWK1uvjDQSHikpMg7VbpmCn9uuk5g@mail.gmail.com>
 <e24d94b4-d519-4491-a38b-488510059a2a@csgraf.de>
 <CAPnjgZ2HqmyOPixmec8v9g2V9mvCQ2mnG4+jUL4-4=qXPOvsOw@mail.gmail.com>
 <1b8f64c7-deab-ae3a-3d22-a69fd74bdae9@csgraf.de>
 <CAPnjgZ2wivMkM407VxYfgOsgrZnLY7UXVMgZt1OfzJzjiKgKjg@mail.gmail.com>
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
In-Reply-To: <CAPnjgZ2wivMkM407VxYfgOsgrZnLY7UXVMgZt1OfzJzjiKgKjg@mail.gmail.com>
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

On 2023-08-22 02:03 +03:00, Simon Glass wrote:
> Hi Alex,
> 
> On Mon, 21 Aug 2023 at 16:44, Alexander Graf <agraf@csgraf.de> wrote:
>>
>>
>> On 22.08.23 00:10, Simon Glass wrote:
>>> Hi Alex,
>>>
>>> On Mon, 21 Aug 2023 at 13:59, Alexander Graf <agraf@csgraf.de> wrote:
>>>>
>>>> On 21.08.23 21:11, Simon Glass wrote:
>>>>> Hi Alper,
>>>>>
>>>>> On Mon, 21 Aug 2023 at 07:51, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>>>>>> From: Alexander Graf <agraf@csgraf.de>
>>>>>>
>>>>>> Now that we have a damage area tells us which parts of the frame buffer
>>>>>> actually need updating, let's only dcache flush those on video_sync()
>>>>>> calls. With this optimization in place, frame buffer updates - especially
>>>>>> on large screen such as 4k displays - speed up significantly.
>>>>>>
>>>>>> Signed-off-by: Alexander Graf <agraf@csgraf.de>
>>>>>> Reported-by: Da Xue <da@libre.computer>
>>>>>> [Alper: Use damage.xstart/yend, IS_ENABLED()]
>>>>>> Co-developed-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
>>>>>> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
>>>>>> ---
>>>>>>
>>>>>> Changes in v5:
>>>>>> - Use xstart, ystart, xend, yend as names for damage region
>>>>>> - Use IS_ENABLED() instead of CONFIG_IS_ENABLED()
>>>>>>
>>>>>> Changes in v2:
>>>>>> - Fix dcache range; we were flushing too much before
>>>>>> - Remove ifdefs
>>>>>>
>>>>>>    drivers/video/video-uclass.c | 41 +++++++++++++++++++++++++++++++-----
>>>>>>    1 file changed, 36 insertions(+), 5 deletions(-)
>>>>> This is a little strange, since flushing the whole cache will only
>>>>> actually write out data that was actually written (to the display). Is
>>>>> there a benefit to this patch, in terms of performance?
>>>>
>>>> I'm happy to see you go through the same thought process I went through
>>>> when writing these: "This surely can't be the problem, can it?". The
>>>> answer is "simple" in hindsight:
>>>>
>>>> Have a look at the ARMv8 cache flush function. It does the only "safe"
>>>> thing you can expect it to do: Clean+Invalidate to POC because we use it
>>>> for multiple things, clearing modified code among others:
>>>>
>>>> ENTRY(__asm_flush_dcache_range)
>>>>           mrs     x3, ctr_el0
>>>>           ubfx    x3, x3, #16, #4
>>>>           mov     x2, #4
>>>>           lsl     x2, x2, x3              /* cache line size */
>>>>
>>>>           /* x2 <- minimal cache line size in cache system */
>>>>           sub     x3, x2, #1
>>>>           bic     x0, x0, x3
>>>> 1:      dc      civac, x0       /* clean & invalidate data or unified
>>>> cache */
>>>>           add     x0, x0, x2
>>>>           cmp     x0, x1
>>>>           b.lo    1b
>>>>           dsb     sy
>>>>           ret
>>>> ENDPROC(__asm_flush_dcache_range)
>>>>
>>>>
>>>> Looking at the "dc civac" call, we find this documentation page from
>>>> ARM:
>>>> https://developer.arm.com/documentation/ddi0601/2022-03/AArch64-Instructions/DC-CIVAC--Data-or-unified-Cache-line-Clean-and-Invalidate-by-VA-to-PoC
>>>>
>>>> This says we're writing any dirtyness of this cache line up to the POC
>>>> and then invalidate (remove the cache line) also up to POC. That means
>>>> when you look at a typical SBC, this will either be L2 or system level
>>>> cache. Every read afterwards needs to go and pull it all the way back to
>>>> L1 to modify it (or not) on the next character write and then flush it
>>>> again.
>>>>
>>>> Even worse: Because of the invalidate, we may even evict it from caches
>>>> that the display controller uses to read the frame buffer. So depending
>>>> on the SoC's cache topology and implementation, we may force the display
>>>> controller to refetch the full FB content on its next screen refresh cycle.
>>>>
>>>> I faintly remember that I tried to experiment with CVAC instead to only
>>>> flush without invalidating. I don't fully remember the results anymore
>>>> though. I believe CVAC just behaved identical to CIVAC on the A53
>>>> platform I was working on. And then I looked at Cortex-A53 errata like
>>>> [1] and just accepted that doing anything but restricting the flushing
>>>> range is a waste of time :)
>>> Yuck I didn't know it was invalidating too. That is horrible. Is there
>>> no way to fix it?
>>
>>
>> Before building all of this damage logic, I tried, but failed. I'd
>> welcome anyone else to try again :). I'm not even convinced yet that it
>> is actually fixable: Depending on the SoC's internal cache logic, it may
>> opt to always invalidate I think.
> 
> Wow, that is crazy! How is anyone supposed to make the system run well
> with logic like that??!
> 
>>
>> That said, this patch set really also makes sense outside of the
>> particular invalidate problem. It creates a generic abstraction between
>> the copy and non-copy code path and allows us to reduce the amount of
>> work spent for both, generically for any video sync operation.
> 
> Sure...my question was really why it helps so much, given what I
> understood the caches to be doing. If they are invalidating, then it
> is amazing anything gets done...

I don't really know cache mechanisms and terminology, but AFAIU there's
nothing actionable for this patch regarding this discussion, right?

Meanwhile I noticed this patch only flushes priv->fb, and think it also
needs to flush priv->copy_fb if VIDEO_COPY.
