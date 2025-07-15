Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B351C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 09:08:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D726582F14;
	Tue, 15 Jul 2025 11:08:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AtexrqJP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0B2E8304F; Tue, 15 Jul 2025 11:08:11 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3924382BF6
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 11:08:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a54700a463so2873378f8f.1
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 02:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752570488; x=1753175288; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xh1oYDFlKOnYZJtv8lrwSVlcJ/ux1lJWxKXRvWoRUM0=;
 b=AtexrqJPWwsu9LE3f5wGf/Foti3rC1Rzn+Hw6I3iS1b0Pmyu+qw/Ic9Scx7taeJJZU
 dMWMMgVdmNWJVUojUscgcmkRPLg6QWrd+qJ6aHIKEc3t7d/D5GX6mgkNHTwoeVwV3uv1
 B7L0M514/Ke6hlA1XzmMS1mv4qfsARl5dUgPXlvGQCmJFdxAFX5I9elLgKGwLlOMD9QD
 EPS8dAhhREsXToAJwIfV5ScpvQAVhZ5o9Yq7TU1s0x9or4NI0HipfRtncp/F/+u+VQBV
 VZIAM/t0HV1s5CZTZ//hgVSz30chtwyJpmxOCgqmxbbOL1Mh16+Wmy4NzQxghQGJKgKo
 WKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752570488; x=1753175288;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xh1oYDFlKOnYZJtv8lrwSVlcJ/ux1lJWxKXRvWoRUM0=;
 b=Kl7OxQ+kJhGmZm3h1wvmam5qlExV5gaxr/Z+LsvvduEbJEz4J819FiMMu3L3RODlzJ
 0FsApv3c2UpObIODwFausEqUEX5KBUjNSPkZ7l86BFJt3Er9Q2Hgh6s32mx5QsfpGI4Q
 lwq3wulmDZGD22oWzsO9rS+F+s+hnBrgk7v3o61vlqkCt1rV2TLyR5pdPPjemTFVERid
 9JJr01s+6/R1aUX60LqJ7CRID/iktA0BTE5lAVjHR0Z6mvWryoJ1MPWhbifUS5BiWvuN
 VTI2FXTGMm6lYxl4VHv15hGyxceLw0QlmtckmTSJdh2n8IeFbXHX63TPK9WYM4xfI9lW
 BViQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPNUrtnI+rU1SRXrGjmXe/awYjqCqo1HbaXIpZf0VLroo3d7WV0a8U2QmuHaL+pCez1Sk7ARc=@lists.denx.de
X-Gm-Message-State: AOJu0Yxt8QsFJw41zUYG9fSlL8R61g1IG32Bg8S5fWu5jBAbTt0Dagnj
 5Uq25rRXR+W+4cKmwcL8NRziGl9MgsNZVd6Un792Nj6Aty13TExr/JhmZImIr9E8FjLnI4s97tF
 VPHTw
X-Gm-Gg: ASbGncvuQbNwPuNufA6cr7TjaZF/eNuexfAOPCb4zf/wunV3WTBf/RKpm8sb/T1bRvN
 Yf8ZDFi9e/t5MWzYdKHjZyrAUh/cS+RCycCdQSiY78rNaHUaxDC6ppLkQbOuRajzVO1kW4wkgZ9
 Tfw26CCWcils/8ILbh2FTOKy8Cd/YOCYrXrdZYPe3LJ3SxhSe9YvPcYxJvtgBUbrrLZOzpgVWd/
 QfRh4D0+7FihGDZ0GC+0sbg4r51qGDjKY4yaAaoRJjyjXpRgTUHLIcrOtKnqP9V72kQZy47wp+Y
 14Q7JRgqTqPl/04Y3HRs8lT1uGwAnQm0kP5p70/XjJ0CDkbXhdeuknAfgdX37bEd++NM9PE1isa
 ZiXfLsJBWxz7b9FPTc7HfqeH2XGJ4KKXt4D9f+Vl6fylYmILlLDyDbnakg/aOnmkM4XUXHcrEBl
 E=
X-Google-Smtp-Source: AGHT+IFc0C2mv02OT3QtcOyq4ayH6oC2lPV7NNDe4jFxoDebnsH7QVXRGkKzGd0jxYSp9kxKJayCYg==
X-Received: by 2002:a05:6000:2dc6:b0:3a3:64b9:773 with SMTP id
 ffacd0b85a97d-3b609526044mr1870124f8f.10.1752570488474; 
 Tue, 15 Jul 2025 02:08:08 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:e07:801:c1bc:9f9a:fc67:a1d1?
 ([2a0a:ef40:e07:801:c1bc:9f9a:fc67:a1d1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc2025sm14867607f8f.31.2025.07.15.02.08.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 02:08:07 -0700 (PDT)
Message-ID: <bd2a68e7-a79d-4d5c-af67-e89e36982f57@linaro.org>
Date: Tue, 15 Jul 2025 10:08:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Remove unreachable code
To: Greg Malysa <malysagreg@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250714-blk-uclass-v1-1-d21428c5f762@linaro.org>
 <20250714162951.GI13084@bill-the-cat>
 <04953cfc-0475-4560-bd7c-fee27739e351@linaro.org>
 <CABdDSeVtccemn8PTgs-f+QzZqJDZ_R=GRmrK2wquasCYDwWYPQ@mail.gmail.com>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <CABdDSeVtccemn8PTgs-f+QzZqJDZ_R=GRmrK2wquasCYDwWYPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 14/07/2025 20:13, Greg Malysa wrote:
> Hi Tom, Andrew,
> 
> On Mon, Jul 14, 2025 at 1:12 PM Andrew Goodbody
> <andrew.goodbody@linaro.org> wrote:
>>
>> On 14/07/2025 17:29, Tom Rini wrote:
>>> On Mon, Jul 14, 2025 at 04:38:53PM +0100, Andrew Goodbody wrote:
>>>> The two functions blk_find_first and blk_find_next use a for loop with
>>>> the content being a 'return 0' which means that the 'increment' code is
>>>> unreachable so remove it and also remove the variable ret which is
>>>> assigned to but its value is never used.
>>>>
>>>> This issue found by Smatch.
>>>>
>>>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>>>> ---
>>>>    drivers/block/blk-uclass.c | 14 ++++----------
>>>>    1 file changed, 4 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
>>>> index f3ac8db9464..b38c21ffbe2 100644
>>>> --- a/drivers/block/blk-uclass.c
>>>> +++ b/drivers/block/blk-uclass.c
>>>> @@ -613,11 +613,8 @@ static int blk_flags_check(struct udevice *dev, enum blk_flag_t req_flags)
>>>>
>>>>    int blk_find_first(enum blk_flag_t flags, struct udevice **devp)
>>>>    {
>>>> -    int ret;
>>>> -
>>>> -    for (ret = uclass_find_first_device(UCLASS_BLK, devp);
>>>> -         *devp && !blk_flags_check(*devp, flags);
>>>> -         ret = uclass_find_next_device(devp))
>>>> +    for (uclass_find_first_device(UCLASS_BLK, devp);
>>>> +         *devp && !blk_flags_check(*devp, flags);)
>>>>               return 0;
>>>>
>>>>       return -ENODEV;
>>>> @@ -625,11 +622,8 @@ int blk_find_first(enum blk_flag_t flags, struct udevice **devp)
>>>>
>>>>    int blk_find_next(enum blk_flag_t flags, struct udevice **devp)
>>>>    {
>>>> -    int ret;
>>>> -
>>>> -    for (ret = uclass_find_next_device(devp);
>>>> -         *devp && !blk_flags_check(*devp, flags);
>>>> -         ret = uclass_find_next_device(devp))
>>>> +    for (uclass_find_next_device(devp);
>>>> +         *devp && !blk_flags_check(*devp, flags);)
>>>>               return 0;
>>>>
>>>>       return -ENODEV;
>>>
>>> Should we clean up uclass_find_next_device(...) to not return int? The
>>> function comments don't quite make sense (include/dm/uclass-internal.h)
>>> and it always returns 0.
>>
>> OK, that should not be too bad.
>>
>> Andrew
> 
> To me it looks like this function doesn't do what is advertised in
> include/blk.h in either case (find the first block device with
> matching flags by checking each one until one matches or we run out),
> instead it seems to test the first block device for the flags
> requested and either returns -ENODEV or 0. Out of curiosity, i looked
> for uses of blk_find_first and blk_find_next, and (except for
> test/dm/blk.c where all the functions are used) they're only used by
> the blk_foreach macro (include/blk.h again), which is only used in
> blk_foreach_probe, which is only used in blk_count_devices, which is
> used nowhere. Instead users use blk_first_device_err which is a
> completely separate path (drivers/block/blk-uclass.c:638).

I was also going to follow up on how much this code was actually used. 
So yes thanks for confirming that all this code has no user. In which 
case I would suggest that it can just be removed.

In the meantime I will post my V2 to include clean up of 
uclass_find_next_device as it is at least a step in the right direction.

Andrew

> I was hoping the test code could clarify a bit and it might. In test/dm/blk.c:
> 
> dm_test_blk_flags first looks for devices with either flag (BLKF_BOTH)
> so the flag check never fails, then it looks for BLKF_FIXED ,which it
> indicates must fail because before probing all devices are removable,
> then it looks for BLKF_REMOVABLE, which is set for the first device
> before probing (even though it will become BLKF_FIXED later). So none
> of these are (I think) testing for the situation where the first
> device is missing a flag, but the second device has it and
> blk_find_first should return the second device. Then in
> dm_test_blk_iter, blk_count_devices is used with varying flag
> combinations and is expected to give the correct answer, which
> suggests that the code does actually work, assuming the test case runs
> and succeeds.
> 
> I've been looking for something to poke around in and if you're ok
> with it I'd be interested in exploring this further to figure out
> whether the function does what it is intended to or if there's an
> opportunity to improve the test coverage.
> 
> Thanks,
> Greg

