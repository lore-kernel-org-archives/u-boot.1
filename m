Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DA6C0219D
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 15:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D247D80EBD;
	Thu, 13 Feb 2025 16:10:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V7eitnsR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7EB480F4E; Thu, 13 Feb 2025 16:10:40 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D1D680EBD
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 16:10:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4395a06cf43so6785575e9.2
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 07:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739459438; x=1740064238; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CutC+NBxPHc9u9c8GKQOm0PzgTtwSMw9bUIh+ifiS6Q=;
 b=V7eitnsRzEt6b+5Nj5cDSxgGoV74yQTDZhP+FTa4mnGUYHTKDgp8nKMtzevIGRcXj/
 sjmSORWJwXXM8MAeucXTOHSBv+NIoQ/1rP3IILsLpl07Z0EGavVzKa/jqiGw0MKK8mQl
 1gtinQlJeJAzFb4/wvqbaAotolxMrBHbpmyMIsaZLYLyVIQB8XTLij9t6gZMZUED4e2Y
 skVklHxrU7obvhHiLG4BQshioLdM/ciTPQt/AA3mdLGrvKkQTF3vunHdbjZWYokyqKTB
 FhqVNoEOjc20pWlKungdHqCpRETnpOguAB3tVUJeiWLMCb8Z2h5DcTlBDx6A0DdqpOW6
 Dc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739459438; x=1740064238;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CutC+NBxPHc9u9c8GKQOm0PzgTtwSMw9bUIh+ifiS6Q=;
 b=t4xlrSlP+1tMVRZGoUl9+Mb51u3xv+mDmCaajGGiTUV6gGxGNHA3ajUfRtBPm4+/NL
 MyQzDzif6TH6ZJ6wPhjj1CgRQAW+0Hn1nDSpMejlaa6Ia0bQcTs3J+Ln8Xck/LebqjGL
 K8w84TFFMICgtw6aCi2snLr7isATJAPCO9xqPi8VHOSBGlTQrMVg5eHwZAORE3kZj7YT
 KmQk3b9ZQA1LHSvafQPQ5p71v9rnAMkKhj4QfOfFKh7ib/vMi29bs5ZJbC5qcqMXt8Au
 uHj8Lqm8tlMyOqmrrSQkG6Oi0IjvT61jg4EbXnEVW4ncQuNHq2U0dBlXm/m7dn01j7Bh
 yopA==
X-Gm-Message-State: AOJu0YwuJxUz3Q/EKN6X5viYy73zO+iBGbNgpCNNYLeLuF9Dlta2JwX0
 h1PQHgBarNXSCOCRWtvtmH87OKwA4h5qHf+fUu7BWKhOYV1k1ARoQMoKKAFGCcbZd7A4Ra5+sQj
 CA74=
X-Gm-Gg: ASbGnctd+2kHd1v4UcgL0b7gfvcJTR8aYk0fwsEwT5K1peFtvHUZramNk+y4SXlGwi5
 Mk1yekIRD2stfURqNTN4jcXyOLU6nushVWBMJNzoAq1txZY7ECSXgHDlYpL1nVb0l85ZHACtYFf
 Qhm8sQ5SsQsz6CcXvUT2EdBgiBgp1solbCksznzfT8TAGGzyLEtuTXfF78hgQKpg6wo84/1pwTh
 fGmAUL5zSQcsqhKbcDXGYEn0tyPkusQclN7n7gDACVrM6SIu0AzIoZpNfyhuTDhBdhmNYhK7oy6
 qG7TslOHkwXYDFy7vTi6czENy8F1Du37Irb48T2bKKebcPQZzX0I3QZmSKjYFZC26So5+cWi
X-Google-Smtp-Source: AGHT+IEEurjpXsYtXCMNrJwOjWs4c8nrzhjrkGzYbQCo3N6nOQOeBnbBnEidfthtC7pHwOsRJQ1C9A==
X-Received: by 2002:a05:600c:5013:b0:434:ff9d:a3a1 with SMTP id
 5b1f17b1804b1-4396016989amr45450465e9.2.1739459437563; 
 Thu, 13 Feb 2025 07:10:37 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:88c1:7339:7690:c850?
 ([2a0a:ef40:1d11:ab01:88c1:7339:7690:c850])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f8602sm2178511f8f.94.2025.02.13.07.10.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 07:10:36 -0800 (PST)
Message-ID: <60e3e20c-3a02-4965-a3a4-a1b12335614e@linaro.org>
Date: Thu, 13 Feb 2025 15:10:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Generic U-Boot
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>,
 marek.vasut+renesas@mailbox.org, Stephan Gerhold <stephan.gerhold@linaro.org>
References: <CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=ieT2oaHfgLf3_nC+xXA9g@mail.gmail.com>
 <20250211212222.GH1233568@bill-the-cat>
 <CAFLszTjaGsXZH6_CAbBhwJ7MAPdzdOUYn=CVBewQKCMX2CS1EQ@mail.gmail.com>
 <20250212164000.GO1233568@bill-the-cat>
 <CAFLszTghQcXGUWS-5GRtWydMzLyYKgKKi7Sd4_NikVrDGHkuzA@mail.gmail.com>
 <b5d2bd37-4424-4660-b5c3-d505e5485ced@linaro.org>
Content-Language: en-US
In-Reply-To: <b5d2bd37-4424-4660-b5c3-d505e5485ced@linaro.org>
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



On 2/13/25 15:03, Caleb Connolly wrote:
> Hi all,
> 
> On 2/12/25 17:41, Simon Glass wrote:
>> Hi Tom,
>>
>> On Wed, 12 Feb 2025 at 09:40, Tom Rini <trini@konsulko.com> wrote:
>>>
>>> On Tue, Feb 11, 2025 at 03:54:21PM -0700, Simon Glass wrote:
>>>>
>>>> The way I see it, both schemes remove the ambiguity. Mine retains a
>>>> single deconfig file and a single 'make menuconfig' for each board.
>>>> Yours feels more like building independent U-Boot images.
>>>
>>> It is explicitly building independent U-Boot images, yes. With a wrapper
>>> around "make all of the images for a given platform". So much of our
>>> confusing and messy code is because we aren't doing that. And since most
>>> modern SoCs can work as (mostly )generic SPL selects correct DTB for PPL
>>> we really could have fewer overall build configurations.
> 
> Big +1 for this. Most Qualcomm platforms in the wild today that would 
> benefit from chainloading U-Boot will NEVER be able to run any stage 
> except PPL due to codesigning. For these I would ideally never like to 
> even think about non-PPL stages since they only added confusion.
> 
> At the same time, it would be great to eventually have U-Boot SPL for 
> Qualcomm platforms that can replace Qualcomm's proprietary sbl1, and 
> maybe event some even smaller/earlier secure TPL(?) stage that replaces 
> their xbl_sec.
> 
> I would very much prefer that these be distinct, since they vary in how 
> board specific they need to be (see below).
> 
> Folks who are just contributing support for their device/soc (a few 
> quirks or simple driver ports from Linux in most cases) are going to 
> have the best experience when the learning curve from Linux to U-Boot is 
> minimal. Mixing up various boot stages into a single defconfig and 
> having custom kbuild infrastructure is the opposite of that, and seems 
> unnecessary.
> 
>>
>> I'd really like to see a generic aarch64 U-Boot for PPL, although it
>> would be quite large with all the drivers. Perhaps we could start by
>> having a generic Rockchip one, for example.
> 
> We already have this for Qualcomm. Some small QoL things still need to 
> go upstream but you can build a single U-Boot binary and boot it on a 
> bunch of differences devices just by using the right DTB. See this build 
> script for example which builds for just a few devices:
> 
> https://gitlab.com/sdm845-mainline/validation/-/blob/main/build_uboot.sh
> 
> I think a bunch of things in mach-snapdragon could be moved to a generic 
> mach-aarch64 that could also target other SoCs like Rockchip or 
> Mediatek. I'd be super interested in helping to make this happen.
> 
> Probably would even want to put more things into common code so other 
> architectures can adopt it (and make themselves smaller), then mach- 
> aarch64 can just be a stub for devices that are fully generic.
> 
> The other potential concern with a generic aarch64 target is that we 
> then lose track of what devices are actually supported. It would be nice 
> to have something like a list of DTBs either in U-Boot or in some 
> associated infrastructure we use to build reference images.
> 
> Which all ties back to the goal of providing distro-agnostic U-Boot 
> images to make Qualcomm (and other?) Android phones capable of running 
> more Linux distros.

This has been very successful for older Qualcomm SoC's using lk2nd which 
supports a frankly ridiculous number of phones

https://github.com/msm8916-mainline/lk2nd/blob/main/Documentation/devices.md

notably with just a binary per soc: 
https://github.com/msm8916-mainline/lk2nd/releases/tag/20.0

They also do some fun things with DT that we might find some inspiration in.
> 
> Sorry for the big thought-dump, this has been on my mind for a while and 
> since it seems like something you're both also interested in I just 
> wanted to offer my perspective as a device and distro maintainer as well.
> 
> Kind regards,
> 
>>
>> Regards,
>> Simon
>>
>>>
>>> -- 
>>> Tom
> 
> 

-- 
Caleb (they/them)

