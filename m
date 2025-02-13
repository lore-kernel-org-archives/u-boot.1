Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A05C0219D
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 15:03:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 953A180EBD;
	Thu, 13 Feb 2025 16:03:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WlRHtOKF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51D7480EBD; Thu, 13 Feb 2025 16:03:35 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61F8080C96
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 16:03:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38f24fc466aso690966f8f.2
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 07:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739459012; x=1740063812; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6J0NmfLUwkngPGlPU/bZNSpalwtyj9Jium1smynQvbs=;
 b=WlRHtOKFEJ/P9jXaRrwmXzghanJSUDXAb35EMIX4/HAPTZjwZi+ZHcVTld+UnyGShh
 nGcJ9XwtnXClQ6podLg53WWOXgO79LTSrgD7GvEcdrgr+4fdxkTSeP/9l1bSdcaYqE23
 LCz8jVXMOtrYzylWBOXGCfWNFOIPqa2b49SXbCVa1A5y1E8EcEH+DrVqfGHGnmwEuGmi
 tsLsaA2UvEv8+I7s51QE9bdzonXjDj57nuBeMhQfSJz34Wn7m5jQ+1raYcqmTx9kw1hQ
 0voUyPSHJ1o2hkzgsU4H2mFTLMZsoE4RbNu+BLTDKzbDX7GT/le09voM6Ly09Le2zs7c
 DipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739459012; x=1740063812;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6J0NmfLUwkngPGlPU/bZNSpalwtyj9Jium1smynQvbs=;
 b=RLsjtlZ3OhAcW4Z2zwk7vnqBLYxMpKx/8zmj2nK/nW1VUzP8nwWBU+A3vpAFsVtb3k
 KH1D4Zl7pwvkW337EPa70wANkou29+kRTvpdQCOanKF1YUnMdY/iIY6++nX96qmqj4mA
 uOOttdeSFuwUV1KX1sVD/HPIoU+qaZ6lspQtCm5hNAdBQAmlU+9s71po4duc4AwqziRl
 y1a4XZ+n0LEUtcwvRuBdsXxk3vTuUT4p45kW6yz/98cVdhh0d65fotifTrfQORAVRFXA
 PAyBnjSSq/iY0mgHeFfxuygWy0TgJFScucedOVr+a6wus51KxVl5dNcOL4ae9gLTIP7j
 WKag==
X-Gm-Message-State: AOJu0YwdyNDotUDM3/6Fet09shGk8r5eUc2xuDvwQG3mVeAirqfVQ/rs
 IGMTJuY5YZmz8suObNbr4yR6uiQno/buqhMOYrJ+k2sNVBnQjjKi6LqFm0+GK2969y4MHtkBGFm
 w0V4=
X-Gm-Gg: ASbGnctcz89td2a1IAeF1gieVCjEZJYhPyp1uGY5asFfBQH9MG0iWs0RVgP/k5PODit
 dauwnrGjOszdLqrRPiDa+5pt3fa2SKiOeHGpfLJfcU/bnF9WBPBPWqKev6LHkQaXlox57SNKNgP
 wsRVFLgje15qP0jkqnjTdLyLjbvIXrfIs82/Gbx88QymZalhqdK9ZoKNQI/4Io4o6jepzWYeV/f
 e/+wC6Siz9aXKgxIZkwfrvTyLXU/1zs+kxm7LEfJbE8UQQgR5fGVOrzM2li5aAsmRJMMyl4jIbP
 EqTHnmvlMYQoArfl62Ao6lAilN9nYRC8R6PeYH7bi3FuTZlBdSitB08Pu41HonSZMpLyijcH
X-Google-Smtp-Source: AGHT+IFbo3BYhYwFBx4FAuwSaTAidwLB74g2gxpQM4apcjHig1ZkWw95GWgBJ/7Vaq9ZGpgVnIotZA==
X-Received: by 2002:a05:6000:1545:b0:38d:d664:67d8 with SMTP id
 ffacd0b85a97d-38dea258b8bmr7447976f8f.11.1739459011540; 
 Thu, 13 Feb 2025 07:03:31 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:88c1:7339:7690:c850?
 ([2a0a:ef40:1d11:ab01:88c1:7339:7690:c850])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43960e937c7sm14056955e9.3.2025.02.13.07.03.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 07:03:30 -0800 (PST)
Message-ID: <b5d2bd37-4424-4660-b5c3-d505e5485ced@linaro.org>
Date: Thu, 13 Feb 2025 15:03:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Generic U-Boot (was: Re: xPL Proposal)
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>,
 marek.vasut+renesas@mailbox.org
References: <CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=ieT2oaHfgLf3_nC+xXA9g@mail.gmail.com>
 <20250211212222.GH1233568@bill-the-cat>
 <CAFLszTjaGsXZH6_CAbBhwJ7MAPdzdOUYn=CVBewQKCMX2CS1EQ@mail.gmail.com>
 <20250212164000.GO1233568@bill-the-cat>
 <CAFLszTghQcXGUWS-5GRtWydMzLyYKgKKi7Sd4_NikVrDGHkuzA@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszTghQcXGUWS-5GRtWydMzLyYKgKKi7Sd4_NikVrDGHkuzA@mail.gmail.com>
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

Hi all,

On 2/12/25 17:41, Simon Glass wrote:
> Hi Tom,
> 
> On Wed, 12 Feb 2025 at 09:40, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Tue, Feb 11, 2025 at 03:54:21PM -0700, Simon Glass wrote:
>>>
>>> The way I see it, both schemes remove the ambiguity. Mine retains a
>>> single deconfig file and a single 'make menuconfig' for each board.
>>> Yours feels more like building independent U-Boot images.
>>
>> It is explicitly building independent U-Boot images, yes. With a wrapper
>> around "make all of the images for a given platform". So much of our
>> confusing and messy code is because we aren't doing that. And since most
>> modern SoCs can work as (mostly )generic SPL selects correct DTB for PPL
>> we really could have fewer overall build configurations.

Big +1 for this. Most Qualcomm platforms in the wild today that would 
benefit from chainloading U-Boot will NEVER be able to run any stage 
except PPL due to codesigning. For these I would ideally never like to 
even think about non-PPL stages since they only added confusion.

At the same time, it would be great to eventually have U-Boot SPL for 
Qualcomm platforms that can replace Qualcomm's proprietary sbl1, and 
maybe event some even smaller/earlier secure TPL(?) stage that replaces 
their xbl_sec.

I would very much prefer that these be distinct, since they vary in how 
board specific they need to be (see below).

Folks who are just contributing support for their device/soc (a few 
quirks or simple driver ports from Linux in most cases) are going to 
have the best experience when the learning curve from Linux to U-Boot is 
minimal. Mixing up various boot stages into a single defconfig and 
having custom kbuild infrastructure is the opposite of that, and seems 
unnecessary.

> 
> I'd really like to see a generic aarch64 U-Boot for PPL, although it
> would be quite large with all the drivers. Perhaps we could start by
> having a generic Rockchip one, for example.

We already have this for Qualcomm. Some small QoL things still need to 
go upstream but you can build a single U-Boot binary and boot it on a 
bunch of differences devices just by using the right DTB. See this build 
script for example which builds for just a few devices:

https://gitlab.com/sdm845-mainline/validation/-/blob/main/build_uboot.sh

I think a bunch of things in mach-snapdragon could be moved to a generic 
mach-aarch64 that could also target other SoCs like Rockchip or 
Mediatek. I'd be super interested in helping to make this happen.

Probably would even want to put more things into common code so other 
architectures can adopt it (and make themselves smaller), then 
mach-aarch64 can just be a stub for devices that are fully generic.

The other potential concern with a generic aarch64 target is that we 
then lose track of what devices are actually supported. It would be nice 
to have something like a list of DTBs either in U-Boot or in some 
associated infrastructure we use to build reference images.

Which all ties back to the goal of providing distro-agnostic U-Boot 
images to make Qualcomm (and other?) Android phones capable of running 
more Linux distros.

Sorry for the big thought-dump, this has been on my mind for a while and 
since it seems like something you're both also interested in I just 
wanted to offer my perspective as a device and distro maintainer as well.

Kind regards,

> 
> Regards,
> Simon
> 
>>
>> --
>> Tom


-- 
Caleb (they/them)

