Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB40CD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 19:55:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE50584BB7;
	Thu,  7 May 2026 21:55:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AcLXwpFL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ACB884BBE; Thu,  7 May 2026 21:55:39 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C453284B58
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 21:55:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso12818795e9.2
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 12:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778183736; x=1778788536; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZltRqwYLJwSkiq9GJ0gUyZBISdn0krDQMrgjewOxDeg=;
 b=AcLXwpFLv+VRPxQlelyq+wu7bvpnT1BMSaNxR3Sv10KcwYqC/Ddp5gk9Scmyv4jeLt
 c1u5xSE+13KQbfqNXDVpEF8VyJfnlt7qhdXvpDx1qxlXbAEcjcpZRyaGiJUc8OPsy4cb
 LHJdiJzZwCIvbZ1X2zk2hZHcHFC4h7zM66p1ogJ8xnWki24VS5l50P43RdUPz/wGBV0v
 PkabQPDZE6LmoU1B4Ic8kw45kNvS3xumyamLKZpxzrbql+phVKwak/5LB57wH1RP6IrD
 an9nsVtHVTVXXTXbJzIvPXb7Yf1RCvJ43fXF9VZgQO616dusJS+WRyplVTCCtqwNKoVP
 hVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778183736; x=1778788536;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZltRqwYLJwSkiq9GJ0gUyZBISdn0krDQMrgjewOxDeg=;
 b=sbWq3tONzvdHJ8gG/za/D4GCfEiXKrkVY2Ex84+xqgp11rZJeDqNzWpnb/Hz0O3ICc
 w7XRcNW35QwMDy5jJ4qSeV+yl2UoFovcSn+WLmd5+lt6rTsY0ixqCWidNXECNUDPEYCr
 7NeseCgGMygMbLNmQfBmivKFPlwrHV4F/SkOTGQtkfaWx8MjXGApt69g//l889GGcIIw
 qxTCXVinFoGWSnotjOP/LTDoGM7zEvFVzL1kZdnIJCno4EAnWaxVtKxfAeuXKSl1s89l
 n/WJzBhnrpdYw8aLZzK9G4UsQhIpEreXgjS6VIRzi/kUBs0R6XIvgk5os7JYPzP8u0Pi
 fRRw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9xUnAm9u6z2FAIsOAN8YrXdRJh1RURUtfWzTSNVXGflDw7+/2mZ3Ktlwt4wglxgnTaOFAnTUY=@lists.denx.de
X-Gm-Message-State: AOJu0YwpiRdTwp06qHHNcRVrowxTUyb2gbASGOTlogbTLuxLD80u3Xj8
 hqKlA2gZDM0Qphow5zKOQ/tj6e9rQuENKdcPBQm9l0to3IYq8e1WYizsFCtC29HU5O8=
X-Gm-Gg: AeBDietxEUOowcMjYBqxmcP5VtFyR3l3m4cELUNa6pIugoUW0uHG/x6sr4TGJPZMsSF
 IHNFekWOuh/+chj4wloD7fUOpjrednYGqXfEoks4wUk1rXqSF8Y9FxQKDy8qobJu/hQfdY0MhwB
 sEdEDlyEo0gni6Hvf0OncH3Z9GTWJkn5u2uiULzXU8mfaal3hsTGbO4R+4yTKtWtt1sufuaqUfB
 6OjH4VXTyQ7gSW+hVjti5IQ658o3SofKLP/YG3iF5G+gP7I8SYdt/M7B95oOlI0yAX8BU/IvrMw
 6zZ6uH/g8/W+iDKlnYTmUqAHTEGe/LpyaSM/BJjXSoqAMopDq1IQM7PgRVxmJ3bPX9SWqEzn2K9
 Rm2TfT/kaBzFFD0ESzbINH8e/Jdx9xOElH+M9E8soDeZdg9iIU6tPlwU1xCCHbQUffBCYoyoEHZ
 OAyWTvBpTUpCiu9pItAd5BWMMabnOY/pVpI5Yay8W840RYTL2poPn5l/JCaOVA1SQBVGreWymsS
 /Fo
X-Received: by 2002:a05:600c:3548:b0:488:c40b:c8a4 with SMTP id
 5b1f17b1804b1-48e51e097a2mr151124165e9.1.1778183736090; 
 Thu, 07 May 2026 12:55:36 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e65d1367bsm1080735e9.31.2026.05.07.12.55.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 12:55:34 -0700 (PDT)
Message-ID: <a45e0c48-58c3-4002-8e8f-d08cb52912f8@linaro.org>
Date: Thu, 7 May 2026 21:55:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] armv8: mmu: support unmapping regions with
 set_one_region()
Content-Language: en-US
To: Sumit Garg <sumit.garg@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Anshul Dalal <anshuld@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20260504183721.646712-1-casey.connolly@linaro.org>
 <CAC_iWjLkz8oMSvGsv-_1UTwNkuLGd3uzEoY90ERWLeeyWCP-_g@mail.gmail.com>
 <afwkwE1OJehspQa7@sumit-xelite>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <afwkwE1OJehspQa7@sumit-xelite>
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



On 07/05/2026 07:36, Sumit Garg wrote:
> On Wed, May 06, 2026 at 10:13:24AM +0300, Ilias Apalodimas wrote:
>> Hi Casey,
>>
>> On Mon, 4 May 2026 at 21:37, Casey Connolly <casey.connolly@linaro.org> wrote:
>>>
>>> Currently set_one_region() implicitly assumes that we want to map a
>>> region and aggressively splits blocks into tables to do this, but when
>>> called with PTE_TYPE_FAULT to unmap a currently mapped region it may
>>> try to unnecessarily split blocks which doesn't make sense if the entire
>>> block should actually be unmapped. In the end it then has to walk every
>>> single page and create a bunch of empty tables.
>>>
>>> Introduce a check for this kind of behaviour and optimise with a fast
>>> path, if we're unmapping a region >= the size of this entry then we can
>>> just unmap the entire PTE and whatever it contains.
>>>
>>> This fixes some bogus empty tables being left behind when carving out
>>> reserved memory regions on Qualcomm, and should improve the performance
>>> of the break-before-make in mmu_change_region_attr().
>>>
>>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>>> ---
>>> Changes in v2:
>>>  - Update pte_type() to correctly check the PTE_TYPE_VALID bit
>>>  - Explicitly unset both bits of PTE_TYPE_MASK to be extra safe
>>>  - V1: https://lore.kernel.org/u-boot/20260504175511.585797-1-casey.connolly@linaro.org/
>>> ---
>>
>> [...]
>>
>>>
>>> +       /*
>>> +        * If we're trying to unmap a region then check if it's already unmapped or if it's bigger
>>> +        * then the PTE we're looking at right now, in the first case we can do nothing and in the
>>> +        * second case we just need to unmap this page/block.
>>> +        * Otherwise we will needlessly create new tables until we have traversed every single page
>>> +        * in the region.
>>> +        */
>>> +       if (attrs == PTE_TYPE_FAULT && (pte_type(pte) == PTE_TYPE_FAULT || size >= levelsize)) {
>>
>> You need an alignment check (with is_aligned) here instead of just the
>> size and levelsize. But then you have to measure if that makes a
>> meningful difference on the time it takes to run.
>>
>> For example imagine you have two 2mb block mapping and the user
>> requests to unmap 2mb starting at 1mb offset. Something like that:
>> Mapped memory:
>> 0x0-0x200000
>> 0x0000000-0x4000000
>>
>> and the user reqeusts to unmap 0x100000-0x300000
>> The size >= levelsize will succed in this case, but if I am reading
>> the code right you'll end up unmapping 0-0x200000
> 
> I think this is the reason why we need to ensure that unmap calls from
> Qcom platform code should all be block mapping aligned (2MB). That will
> ensure we don't run into creating 4K page tables just for the sake of
> un-mapping reserved memory regions.

That wasn't what the code does in the qcom side, I did previously look
into this but it's quite complicated to do without the risk of treading
on a region we actually do need, since we're dcache-off at that point it
didn't seem worth it to add that complexity.

Anyhow, I have an improved version which unfortunately is slower but is
at least actually correct XD on sm8650 it now takes ~200ms. I think this
is the best we can hope for until U-Boot gets proper support for dynamic
memory mapping and we can get dcache enabled much earlier.

> 
> -Sumit

-- 
// Casey (she/her)

