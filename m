Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2348ACD98DD
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 00:03:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8638E86C59;
	Wed, 11 Oct 2023 02:03:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DqNZjvJZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 817B886C21; Wed, 11 Oct 2023 02:03:52 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5C1886BAC
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 02:03:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-77433d61155so409724585a.2
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 17:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696982620; x=1697587420; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u6uVU0HlLOqspUpXO9waQVyhNmB9hD6TVAUgYv3V8yE=;
 b=DqNZjvJZQuYORsTViLxklqmubVwhVBPp747HIhRNmXvCrQgElmAjHI2kJK70HPWdAy
 Mrp7J25WDCOTavyT/EZFIMCxCw4k6f3W6/SsRr+VdF33Aqz/d1GheRqGb44Cho5AHafH
 PCV60bCQ7YubNGVHmUdHbRyVcH9lyx9btWtQza1KOF1w/CvydnFMM9rYzuTQ9Dj6v2PP
 Y579i81gXJHkrCa2+GtAQU2QzXpEWdu7bcU9rc2i5xvpLvtedC5LH89+t6rqhniHbEM1
 jp6kJDwakFFblfhx+rmFCQVUpJZb3XlQ68mCBW1P9z7MkfDBYDuAPx7d5bFwdAUDLAtU
 Jhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696982620; x=1697587420;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u6uVU0HlLOqspUpXO9waQVyhNmB9hD6TVAUgYv3V8yE=;
 b=LAjcs48xR4G/m22BKSvd4XYwXFMsI3h55N6FJSkqy2Poz17PFi/AIsHCSF8dLn/L+w
 XHQGKqxZol6fw1NNTfN125wKKz40dN/zr4Qs8cdRHJeH7I61Mlwbqi3HaQBa4XemCqdX
 ixzs/zxUalqVIq+aiKXhfdih+YNQVXKza/+LB1xp/zc++RJI5NhywZ5jDK4vzoNk2FeT
 PcN3MELfqPJabY4PvGGcT99lhpCZ7XN0pn0inq+xLrjr/OQO6JWrdJJ7NppnKAV5u0bn
 E5PSZbQd5rAvqblWntzMu4gWnOz8qNiP7Wy0Jfo1cd3pl6D4cCJIWCn7MGHdbJ6xLrng
 J1Fg==
X-Gm-Message-State: AOJu0YxAVutfWaIAF3H/UroJibrRkTa3mk0wsgc4SPjrSd7HBTSbyh5R
 0E9VBjZQauIMnOUc/CGZGdI=
X-Google-Smtp-Source: AGHT+IF0OHi4gQIHNg5nKiOstFMmtjhpJek2HJ02uxFoRAha/A3YSSN0rExgPJCVeGQGOb87dz4U0A==
X-Received: by 2002:a0c:f28e:0:b0:66c:f070:2883 with SMTP id
 k14-20020a0cf28e000000b0066cf0702883mr4193537qvl.19.1696982620538; 
 Tue, 10 Oct 2023 17:03:40 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 2-20020a05620a078200b007742bc74184sm4727611qka.110.2023.10.10.17.03.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 17:03:40 -0700 (PDT)
Message-ID: <ec7f63e8-f891-ec5f-b1ee-fecd3b5ce77a@gmail.com>
Date: Tue, 10 Oct 2023 20:03:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 07/25] tegra: Change #ifdef for nop
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List
 <u-boot@lists.denx.de>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Tom Warren <twarren@nvidia.com>
References: <20230924203953.1829820-1-sjg@chromium.org>
 <20230924203953.1829820-8-sjg@chromium.org>
 <20230925004346.GP305624@bill-the-cat>
 <CAPnjgZ3ieXXhidSeqzMuPBCgy9UrvOt5zSMO671t1KG9zWAGxQ@mail.gmail.com>
 <cad8dcca-eaa5-872b-db9a-86f5438b120c@gmail.com>
 <CAPnjgZ38gfWghmejpQFkJ9y9F8fdC-Wo-YSHT_4_cu8dW1UDGw@mail.gmail.com>
 <2ffb2d81-9c63-2ce3-ccba-3d5461008a51@gmail.com>
 <CAPnjgZ1Goy0Xt=vj6YYeOEPwYO7wkATKawQtOwCW8JTM1ShdcQ@mail.gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAPnjgZ1Goy0Xt=vj6YYeOEPwYO7wkATKawQtOwCW8JTM1ShdcQ@mail.gmail.com>
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

On 10/10/23 10:42, Simon Glass wrote:
> Hi Sean,
> 
> On Mon, 9 Oct 2023 at 17:40, Sean Anderson <seanga2@gmail.com> wrote:
>>
>> On 10/9/23 11:32, Simon Glass wrote:
>>> Hi Sean,
>>>
>>> On Sat, 7 Oct 2023 at 17:21, Sean Anderson <seanga2@gmail.com> wrote:
>>>>
>>>> On 10/7/23 19:10, Simon Glass wrote:
>>>>> Hi Tom.
>>>>>
>>>>> On Sun, 24 Sept 2023 at 18:43, Tom Rini <trini@konsulko.com> wrote:
>>>>>>
>>>>>> On Sun, Sep 24, 2023 at 02:39:25PM -0600, Simon Glass wrote:
>>>>>>
>>>>>>> This code is normally compiled for Tegra, but sandbox can also compile
>>>>>>> it. We should not use UNIT_TEST as a synonym for SANDBOX, since it is
>>>>>>> possible to disable UNIT_TEST for sandbox.
>>>>>>>
>>>>>>> Correct the condition.
>>>>>>>
>>>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>>>>> ---
>>>>>>>
>>>>>>>     include/k210/pll.h | 2 +-
>>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/include/k210/pll.h b/include/k210/pll.h
>>>>>>> index fd16a89cb203..6dd60b2eb4fc 100644
>>>>>>> --- a/include/k210/pll.h
>>>>>>> +++ b/include/k210/pll.h
>>>>>>> @@ -13,7 +13,7 @@ struct k210_pll_config {
>>>>>>>          u8 od;
>>>>>>>     };
>>>>>>>
>>>>>>> -#ifdef CONFIG_UNIT_TEST
>>>>>>> +#ifdef CONFIG_SANDBOX
>>>>>>>     TEST_STATIC int k210_pll_calc_config(u32 rate, u32 rate_in,
>>>>>>>                                       struct k210_pll_config *best);
>>>>>>>     #ifndef nop
>>>>>>
>>>>>> Tegra? Do you mean sifive?  That's where CLK_K210 stuff is... but it
>>>>>
>>>>> Oh yes, I got confused.
>>>>>
>>>>>> also seems wrong, you can run unit test on real hardware, and this is a
>>>>>> test that could (should?) be run on that platform.
>>>>>
>>>>> Only if it enables UNIT_TEST. You cannot run unit tests without that.
>>>>> The current tests are designed for sandbox.
>>>>
>>>> FWIW I have run this test on actual hardware. My intent here was to allow
>>>> unit tests to access functions which would otherwise be declared static.
>>>
>>> Er, with or without UNIT_TEST enabled? How can it even build if this
>>> declaration is only for sandbox?
>>
>> With UNIT_TEST of course. Although since this is a forward-declaration, the
>> UNIT_TEST ifdef isn't really even necessary. If it's on actual hardware, nop
>> should already be defined. So maybe this should be something like
>>
>> #if CONFIG_SANDBOX
>> #define nop()
>> #endif
> 
> It is the CONFIG_SANDBOX that I am trying to remove. Can it be
> CONFIG_UNIT_TEST instead?

Well, you can just remove the `ifdef UNIT_TEST` then.

--Sean

