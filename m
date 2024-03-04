Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9C2C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 16:50:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F51587FC7;
	Mon,  4 Mar 2024 17:50:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MSVy2T5e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B75E87FAA; Mon,  4 Mar 2024 17:50:42 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A59287FAE
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 17:50:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2d28464c554so64448391fa.3
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 08:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709571038; x=1710175838; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vDYkICsT64ItNVrghaKisRSouXqGb/Dy6ER+LQlOh4I=;
 b=MSVy2T5epdcV4EkGFTsMICU1dIq4l67a9pXecXyL3k+MMxyBesHg7S01OKMo01rp/q
 evySBmFpaiv7P0Ez5fm9jPJqvxKiP17/AVHOZHdJqOlj5aneEFT0rAcp0Jky4vY0BM0T
 TXVo0PryxQbv3aqiTbtuog2cVFZ+X2sFygtvpC+houzzzoWFhO1Q345McnM9l0En/WpT
 HMqClr4QA7Vs4qLk4czu6WoKs5NFdrdF2pvUkxxo8dJ3wTn8vVlVp3Mi/C0ZlzIjQoIH
 41JrbUy7nh+jCoWe92qL9TJlFA+h30QRruUEmZ8mPUR78Tmt0fHBF3IIYse1LKk+GItu
 JcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709571038; x=1710175838;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vDYkICsT64ItNVrghaKisRSouXqGb/Dy6ER+LQlOh4I=;
 b=cfbiRVvp3kbVdYktE9GoY0I2PCtCmn4VeR5cHfblQ5unh7A72ZK7BZSuVgMv5dTUM6
 mwsHaP17TaPOi/32yO75fdyr9OpSYBotVggaTXz+ejxnN43jUrMSp7VrMkb6QLCE3Wz/
 5NE9Ml83Pb/gBYDpdLkjZHw7EZ1yLBMP1OB34V1J5dWTjgR8jkrLEVn5gsx7tVPVt9R/
 JNhgymVlcA6Cc1tpafriXo36k69QFPCz3XWGR/+MZMJT1Z2RQmu87J6sC2RTumf4eI/s
 eWUv5QNGLAqLjaR3VKMiRcD74vi7MfnEiZvS4KXIy8q4sfcCjBSzG/r89vdwe28aN9OL
 Stng==
X-Gm-Message-State: AOJu0YynkxHK2VELXnj61b+IdiVcFb57fFlFKOe92VETjyu+vdzlPpSc
 MmNpvEfkrDCQstgMho15WFupgjcXg2BmNOt1O7dNI3NVxto9CCIFhWossk2gnN0=
X-Google-Smtp-Source: AGHT+IFI1OQ3WhODRIYz616JaDNp/s9vk9pZQh1WdhN0m3699pyA3VApNfKSg2yiO48cvZGfLO1Z8A==
X-Received: by 2002:a2e:a545:0:b0:2d2:c83c:ffd7 with SMTP id
 e5-20020a2ea545000000b002d2c83cffd7mr7684315ljn.42.1709571038617; 
 Mon, 04 Mar 2024 08:50:38 -0800 (PST)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 17-20020a05600c229100b00412b2afb2c8sm17771021wmf.26.2024.03.04.08.50.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 08:50:38 -0800 (PST)
Message-ID: <708b363f-1a32-47d8-9937-36167d654786@linaro.org>
Date: Mon, 4 Mar 2024 16:50:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Add support for Qualcomm SA8155-ADP board
Content-Language: en-US
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 Stephan Gerhold <stephan@gerhold.net>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Elmar Psilog
 <epsi@gmx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Ley Foon Tan <leyfoon.tan@starfivetech.com>, Lukasz Majewski
 <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>
References: <20240229142043.1263690-1-volodymyr_babchuk@epam.com>
 <dc97490e-4029-41e2-bbbd-b1351f5cf9eb@linaro.org> <87bk7x6c88.fsf@epam.com>
 <ZeXN7EZHU89qS5PF@gerhold.net> <87r0gq3shy.fsf@epam.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <87r0gq3shy.fsf@epam.com>
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



On 04/03/2024 15:51, Volodymyr Babchuk wrote:
> 
> Hi Stephan,
> 
> Stephan Gerhold <stephan@gerhold.net> writes:
> 
>> On Fri, Mar 01, 2024 at 06:25:39PM +0000, Volodymyr Babchuk wrote:
>>> Caleb Connolly <caleb.connolly@linaro.org> writes:
>>>> On 29/02/2024 14:21, Volodymyr Babchuk wrote:
>>>>> This patch series adds support for Qualcomm SA8155-ADP development
>>>>> board. Main motivation for this series is to allow running
>>>>> virtualization software on this board and U-Boot is a good way to
>>>>> break Qualcomm's boot chain at EL2 with more convenient ways for
>>>>> uploading and running the code. With this patches applied it is
>>>>> possible to upload and run Xen on this board. KVM probably should work
>>>>> too.
>>>>
>>>> This is really cool! I've experimented with this on SDM845 and SM8250
>>>> but never really did anything with it... I'd love to take a look at your
>>>> Xen branch?
>>>
>>> Honestly, there is nothing to look at right now. I just implemented
>>> early printk serial driver for the qcom, made hacks to the device tree
>>> and trying to boot Dom0. I already expecting issues with the GPU,
>>> because it has own SMMU without virtualization support and Xen already
>>> complains about it. So I had to remove it from the DTS for a time being.
>>>
>>
>> Did you enable all the clocks/power domains/etc for the GPU SMMU? If I
>> remember correctly it is off by default and all registers read as
>> zeroes. The SMMU driver could easily get confused about the capabilities
>> of the SMMU (e.g. the stage 2/virtualization support) if all the ID
>> registers read as zeroes.
> 
> Ah, this is a great idea, thanks. I tried a quick test by enabling only
> clocks that are provided by GCC, but looks like I need to enable GPUCC
> clocks as well. So I need to write a driver for GPUCC or at least
> figure which registers to write with a debugger. I'll try this later.
> 
> By the way, do you have any suggestion about my second issue? When Linux
> in the Dom0 tries to access UFS, CPU gets a secure interrupt and hangs in
> TZ. I had the same exactly behavior when I tried to access EMAC without enabling
> clocks and power domains in U-Boot. But Linux should enable all
> prerequisites for UFS... I suspect that there is an additional
> initialization needs to be done, but I didn't figured it yet.

Maybe it would be easiest to try enabling UFS in U-Boot first? I have it
working on SDM845 and SM8250, so it should be easy enough to add SM8150
as well...

You can find the UFS and PHY patches in the branch linked below (sorry
it's not very clean... Maybe easier to just add your drivers on top)

This way we can more easily dig in and see what the root cause is.

If you run into issues there let me know and I can maybe give it a try
on an SM8150 HDK.

https://git.codelinaro.org/linaro/qcomlt/u-boot/-/commits/caleb/rbx-integration/?ref_type=HEADS
> 

-- 
// Caleb (they/them)
