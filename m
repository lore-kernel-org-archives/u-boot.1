Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEFEC5B549
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 13:23:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 819468070C;
	Wed,  4 Jun 2025 15:23:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A26JnVoL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4628807B1; Wed,  4 Jun 2025 15:23:08 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BBA780584
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 15:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a50fc819f2so2202199f8f.2
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 06:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749043385; x=1749648185; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+3a5UPDlotylEXugTMWtpp9VrJG5sviEUnMA7Um07gI=;
 b=A26JnVoL+eihsZc54EyX3OVDNb+Vh3nq+rJI5Ms6bI8lAigDULkIbVD2Om1H+8y6od
 lXu3CHfXIZXk+oRAVHM/rDFpWk1RvAutd0ZKKiCJO4kd/dsR3WiHI0V4gw0M/s6SiB3i
 xio1DqSz0s1T6nUQSKRVE86Zu9AprGS+fmbVeNI0c2b8Di1+MnEJGwezSPhR3Jok8st4
 rncqLEqHcXktqtWnCuWrYo7hxmd4JRu9Q9zA45xSJN1C/S/59riXFogbcy+8k1wB2weh
 SqNjIeRCFcNsILZewg/xWAjy2Rx9VhhktcUkd9NMTb6xpKfs4uK77JGXwdAC5j3yseKn
 O/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749043385; x=1749648185;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+3a5UPDlotylEXugTMWtpp9VrJG5sviEUnMA7Um07gI=;
 b=e30hn4+8gO5i5fIzysKdWRxX1TjiorFyyce2YFeSIYw8ioGqG+tdd3hxqC4m8nW9pn
 t+x5g/elmKruM/qz9TBBuoaeokHuzb46NxafXLqa/2wXLYtESRMTPi4lT/zMx6+wKfaD
 c2BGbCLLR3Uye4ucysQu0eO6INwGepCTNIh8InGyZLvtlgZCZ0+RUAAnXX4xlQZ6WVDa
 zurIsK4rZ89mdyhfJO2orzuqi9rYGwXPLfSzJTmzIyucvgSpJC2KfaLpSsdXLUyNMN5/
 dvgpQAEIe9ECBXb5F2jXN2yTJconeTpydhFlXuSOYBKfyl9UVGarqLHwEKa91XVh0LVs
 3MoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmn5k0Ub6/1L2/VsDWdsDgzF0QozuZslFDmG6npD83cDrhWpC5Z+MO9aaoPSW3JEIVyy07THg=@lists.denx.de
X-Gm-Message-State: AOJu0YxieqHseHsqvvj9wT2lkPxbxvXQ/xq0Modqw5QTlR/h1O8pSzFU
 Z3QuZXLJ92GvGGv+a12Av9QcKvT9PATEPhFsrdltHpciCggbkxXrKiIXZjaG74BAgaQ=
X-Gm-Gg: ASbGncsGYCMAsgFAQ3mYvSnuseYGb3b56lmvOxqPejD29c5BZGvkHZsD++vSq4Fy0GL
 oHOlVseVw8Qf6Tzgn7RCzrFAc9eA75kbHVKcCUezWWwIM2VPOd5cyrJzdNUkTl/eQOvtTP5HFd3
 4galYpUi1iPEGWOtBlTvwGFflQrcQi+m88oD5+Yd00fQjOFjBhTalEjs5Fy8aqNFYpcCym0gwdI
 9ZMYu/09fWFfldpVbG5no4m1HQBq7TgfuRw8UZVu6+h00QzefnQ1UXSJ1TV4ZnuMPTqR5gif7O1
 sxdJ89GLJ3ciW3kuFrejqT2L91A9ole78s1Zm9gdFCwv3BT6YuE8YPDmJUcI/RPjw62RE1lqyu+
 1W+4Jz0/xpZp6Z8I/mIuqY6odyAesMpw2AUgm
X-Google-Smtp-Source: AGHT+IFFHkOhWLayHUbUZYxGFk4RgZLBImABP6tJ/9anSqbiPX5edCJDAyxwc2lg1D8wzE3zuDc3kQ==
X-Received: by 2002:a05:6000:4212:b0:3a4:f7af:db9c with SMTP id
 ffacd0b85a97d-3a51d9871a2mr2669481f8f.59.1749043385197; 
 Wed, 04 Jun 2025 06:23:05 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:968c:2df3:c75e:5a31?
 ([2a01:170:117e:fc:968c:2df3:c75e:5a31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f00972c1sm22061452f8f.68.2025.06.04.06.23.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 06:23:04 -0700 (PDT)
Message-ID: <e3de0f5f-22dd-4152-8a74-15bd123620f0@linaro.org>
Date: Wed, 4 Jun 2025 15:23:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Determining Simon Glass's future in the U-Boot project
From: Casey Connolly <casey.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
References: <20250528175901.GG100073@bill-the-cat>
 <d3f66117-4b1a-4670-82f7-0d895c74fbc7@linaro.org>
Content-Language: en-US
In-Reply-To: <d3f66117-4b1a-4670-82f7-0d895c74fbc7@linaro.org>
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



On 6/4/25 15:15, Casey Connolly wrote:
> Hi Tom,
> 
> On 5/28/25 19:59, Tom Rini wrote:
>> Hey all,
>>
>> First, I am not happy to be writing this email. But at this point, I
>> feel I have no other choice, for the good of the overall project and
>> community.
>>
>> Back in January[0] of this year I made a post with almost this same
>> subject line. At that point there had already been a number of problems
>> working with Simon and the overall community. I did not include a list
>> of links. At that point the easiest answer would be to go to the mailing
>> list archive, pick any thread that Simon and I had and see the long
>> disagreements. This trend has fundamentally not changed. And while I
>> started this out with some threads and my summaries of them, instead I
>> want to point to this email I sent this mornig:
>> https://lore.kernel.org/u-boot/20250528170533.GE100073@bill-the-cat/
>>
>> And to repeat what I said there, Simon needs to decide if it's more
>> important to work with the community or have his way every time. Simon
>> cannot have both. Simon needs to accept that some things he think are
>> good ideas have been rejected or he needs to fork off from U-Boot. Or he
>> can ask the community to take over as the project head. If the community
>> wants Simon to run things, I will step down and just be an individual
>> contributor again. Five months of this experiment shows me that it's not
>> working at all and will only be a bigger problem as time goes on.
>>
>> And, I mean it. I cannot take the additional stress of what new problems
>> await me every morning. I do not take the above lightly, but I do not
>> think the project can become healthy moving forward without some
>> resolution here and quickly. While I won't claim my time as the head of
>> the project has been perfect, I have tried my best to always be honest
>> and fair and to seek compromise.
> 
> You've been nothing but encouraging to me as a new contributor and 
> custodian, and I really can't imagine U-Boot without you leading the 
> charge.
> 
> Simon has been repeatedly engaging with people unproductively, wasting 
> time and delaying valuable contributions. His complains tend to come in 
> the form of vague hand waving about how things should be with seemingly 
> no attention given to the actual intentions of the patch and dealing 
> with the reality of how U-Boot works today. With so much attention given 
> to his ever-diverging fork I can only imagine increasing confusion about 
> how U-Boot actually works when it comes to reviewing upstream patches.

fwiw I am missing a lot of history here which I probably should have 
considered more while writing this. I have had good discussions without 
Simon about some topics, but particularly in the last few months it has 
become much more difficult.


> 
> Referring back to: https://lore.kernel.org/u-boot/1c1bcd1e- 
> bec5-4e6a-9f09-e1d2895969b3@linaro.org/
> 
> Simon seems to think that his arbitrary *implementation* of a boot flow 
> is the only correct design, and there is no other usecase where 
> something else would be desirable.
> 
> After many repeated discussions with the same themes (and having 
> witnessed many of yours) I struggle to see Simons engagements as 
> anything other than bad faith, particularly when it's so hard to pin 
> down what the technical disagreements here actually are.
> 
> The patches in Simons U-Boot fork all appear to be either picked from 
> the list (often earlier versions that what actually made it upstream) by 
> other folks or his own patches that have been rejected for totally valid 
> reasons that he doesn't seem to want to get into good enough shape to 
> upstream.
> 
> You have repeatedly and publicly explained what it would take to get his 
> features merged upstreamed, and to be honest I think you have offered 
> him far more grace than other people in your position would.
> 
>>
>> With respect to voting, would anyone volunteer to run a poll from
>> https://civs1.civs.us/ (which is used by the Yocto Project /
>> OpenEmbedded and likely other FOSS projects/communities) ?
> 
> Maybe rather than this we could form a U-Boot board (via voting) and 
> this board would be responsible for managing the project and associated 
> resources, having and enforcing a code of conduct, etc etc.
> 
> There are various organisations which can help with this like the Linux 
> Foundation, NLNet (I have experience with this from postmarketOS) and it 
> would give the U-Boot community a way to be represented when it comes to 
> difficult situations like this as well as provide a way for the project 
> to grow sustainable as it increases in scope.
> 
>>

-- 
Casey (she/they)

