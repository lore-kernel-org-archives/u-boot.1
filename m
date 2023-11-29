Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21041C10DAA
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 15:34:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EA7287164;
	Wed, 29 Nov 2023 16:34:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F2wbuXwy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F80E87164; Wed, 29 Nov 2023 16:34:37 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B229F87745
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 16:34:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40b31232bf0so55427985e9.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 07:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701272073; x=1701876873; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qp4xucXhNkB2aTVKWskjyw9ke73G29gguS1Kl/Q5EyU=;
 b=F2wbuXwyqQjZYt8fFSIbl11LrfN6RzoCS59aD9ZBLDnPmur5ZgC7zxKoWA70vW+YgI
 k5SiCnA3+4I1XmvuBBRrr+jLIJm8fNOqQjSQN2judaVsPtZnp4irDaJQq6R03CGXSxVH
 dDi1uoBAdabPrw+eFVdINka5Oa5v0YYaZ+Ny2mCAm0peg61QuTSrr+xkXtBMDbO8qO4k
 e42Ef/0c0T8Q95RlxT3E+onD4/HLDGhLyv+PXW9H1bgtoDQ1ctZrPdngXSiQFLbLPvgb
 67KjBs2efzG9xS76WHTkoJfWBMTAlIAT/nyyJKkn7VMLl0EgKBx5yQe3xyj3JTZ2bd1v
 5cCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701272073; x=1701876873;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qp4xucXhNkB2aTVKWskjyw9ke73G29gguS1Kl/Q5EyU=;
 b=JcRMlZ6BctGl9ByRs0tkPaGK2qPFPrSK9LnLl/5yXhGR6E8OlDGR8pinjQqkpf4o0g
 18G8SmcILyvrgxQna3WLHkEqb6vtMtOX30UotuA3Nlt7/bhxD6TZk0GxdYT5Cb60SaTg
 ZSFka9LpXD4f/OnjqRMtF4Y859YqPJxOD4eUDXuX42QJK+B1pHtnl0hyTU+jKZdzJHJB
 +0EodK/CToYJanDzZd5q9mm9LP9Bl/jHS78vfg7m/Ew1KS6k56uRa9Kl5RMMLSL36ixf
 JItpCPe243YzuxhUbQ5oOlk8IPDzQet2m20sLAFaeEUOk0l/gd0shJskjLOXR6wyp2mT
 GA+w==
X-Gm-Message-State: AOJu0YwP06klCSBfjzLeiUH5riSSlLvgxc+dUydKYDezG1AlWNdVbmyf
 th5WOtKNkIiCdCLDD8wryaAd4A==
X-Google-Smtp-Source: AGHT+IESrCGAThaIFryoEiuJNv1JKFqa5qm7zSeZVbD2ASFaamj6xHH9JJxRRFvVHGU9hz+DYQozyQ==
X-Received: by 2002:a05:600c:4507:b0:405:3a3d:6f53 with SMTP id
 t7-20020a05600c450700b004053a3d6f53mr15880478wmo.3.1701272072938; 
 Wed, 29 Nov 2023 07:34:32 -0800 (PST)
Received: from [192.168.1.7] ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a05600c311100b0040b3e79bad3sm2624823wmo.40.2023.11.29.07.34.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Nov 2023 07:34:32 -0800 (PST)
Message-ID: <22b2c2e2-9ce1-4a5f-8cda-565184eec120@linaro.org>
Date: Wed, 29 Nov 2023 15:34:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <CAFA6WYPe8_onKNYzAVr9RHVbwUZCTiEkDizwnfL6QRsqii-JUg@mail.gmail.com>
 <20231122140100.GT2513409@bill-the-cat>
 <CAFA6WYNoz-Pqn38FpKLj9eJxX6B019HvQoukdCma3S=+O6tOCg@mail.gmail.com>
 <20231122142758.GU2513409@bill-the-cat>
 <c47b163b-d0d9-4de6-8ea8-ebe884b28e4b@linaro.org>
 <CAFA6WYO_Dk+7FWDGjUdDub27YCwVKRjS+vZfMrT8otjvv-QO_Q@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAFA6WYO_Dk+7FWDGjUdDub27YCwVKRjS+vZfMrT8otjvv-QO_Q@mail.gmail.com>
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



On 23/11/2023 07:04, Sumit Garg wrote:
> On Wed, 22 Nov 2023 at 21:34, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>>
>>
>> On 22/11/2023 14:27, Tom Rini wrote:
>>> On Wed, Nov 22, 2023 at 07:44:09PM +0530, Sumit Garg wrote:
>>>> On Wed, 22 Nov 2023 at 19:31, Tom Rini <trini@konsulko.com> wrote:
>>>>>
>>>>> On Wed, Nov 22, 2023 at 11:51:29AM +0530, Sumit Garg wrote:
>>>>>> Hi Caleb,
>>>>>>
>>>>>> On Tue, 21 Nov 2023 at 22:39, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>>>> [snip]
>>>>>>> == DT loading ==
>>>>>>>
>>>>>>> Previously, boards used the FDT blob embedded into U-Boot (via
>>>>>>> OF_SEPARATE). However, most Qualcomm boards run U-Boot as a secondary
>>>>>>> bootloader, so we can instead rely on the first-stage bootloader to
>>>>>>> populate some useful FDT properties for us (notably the /memory node and
>>>>>>> KASLR seed) and fetch the DTB that it provides. Combined with the memory
>>>>>>> map changes above, this let's us entirely avoid configuring the memory
>>>>>>> map explicitly.
>>>>>>
>>>>>> Since with this change, we don't need to embed FDT blob in the u-boot
>>>>>> binary, so I was thinking if we really need to import DTs from Linux
>>>>>> for different platforms and then play a catchup game?
>>
>> For now, yes.
> 
> But why? Is there any value added by larger u-boot specific DT (most
> of the nodes being unused by u-boot) than what currently u-boot
> supports? The more important part is to get alignment with Linux DT
> bindings. If you need to have memory/reserved-memory nodes in u-boot
> DT for generalization purposes then you should import those particular
> nodes only.

I've been thinking about and hacking on this for the last week or so,
sorry for the delayed reply here.

The value is in preventing any of the existing bindings from regressing,
and simplifying the bringup process for new platforms (just copy
SoC/PMIC DTSI and write a minimal board DTS to enable the needed hardware).
> 
>> There are quite a few features which aren't handled by
>> U-Boot that it shouldn't need to handle (rpm/h resources for example).
>> Also the fixed-regulator / regulator-gpio binding differences.
> 
> IMO, we should fix them first and then use Linux DT as it is.

The biggest blocker here is USB, on sdm845 and the 4 new platforms I
have working, I only support USB high speed, this requires removing the
superspeed phy and adding a DTS property.

I tried using OF_BOARD_SETUP to make this changes during boot but this
approach really isn't scalable (and I couldn't find a way to make it
work anyway).

> 
>>
>> I would definitely like to move towards supporting Linux DT directly,
>> but this approach gives us a nice middleground of minimising the U-Boot
>> specific DT parts.
> 
> I don't see any real benefits here apart from the maintenance burden.
> If it had been an actual Linux DT then that can be passed to Linux as
> it is. However, the current modified import you are trying to do
> doesn't solve that purpose as well.

Ensuring that we don't introduce non-standard bindings (by using Linux
DTSI) is one benefit, simplifying new platform bringup is another.

The amount of work required to switch to upstream DT is too much to
block this series on. We can work on improving the situation there once
we have these Qualcomm improvements upstream and new boards added. I do
admit that this is quite an awkward middle-ground, and I would not like
it to last for too long.

> 
> -Sumit
> 
>>>>>>
>>>>>> IMO, the build command would look like following if we import
>>>>>> pre-built FDT blob from Linux:
>>>>>>
>>>>>> - Build u-boot::
>>>>>>
>>>>>>         $ export CROSS_COMPILE=<aarch64 toolchain prefix>
>>>>>>         $ make qcom_defconfig
>>>>>>         $ make
>>>>>>
>>>>>> - gzip u-boot::
>>>>>>
>>>>>>         gzip u-boot-nodtb.bin
>>>>>>
>>>>>> - Append dtb to gzipped u-boot::
>>>>>>
>>>>>>          cat u-boot-nodtb.bin.gz
>>>>>> <linux-tree>/arch/arm64/boot/dts/qcom/your-board.dtb >
>>>>>> u-boot-nodtb.bin.gz-dtb
>>>>>>
>>>>>> This would avoid the maintenance burden to keep DT in sync with that
>>>>>> of Linux. And since DT bindings in Linux are backwards compatible, we
>>>>>> can say u-boot should work with DTB picked up from any Linux kernel
>>>>>> stable release.
>>>>>
>>>>> I guess one question I have is, are we being passed the device tree
>>>>> (since we're acting like the Linux Kernel)
>>>>
>>>> Yeah that is the case here, see patch #1 in this series regarding how
>>>> FDT address is being retrieved from previous stage bootloader (ABL on
>>>> sdm845 and qcs404 SoCs).
>>>
>>> That's what I thought.
>>>
>>>>> or knowing that we have the
>>>>> dtb attached to the end of us and making use of the old kernel appended
>>>>> dtb option? We're fine in for example the rpi_arm64 case of just being
>>>>> given a device tree from the previous stage and not needing one in-tree.
>>>>
>>>> That's good to know and we can replicate that for Qcom platforms which
>>>> are chainloaded and don't need an embedded DT.
>>>
>>> So yes, moving these towards the direction of rpi_arm64 and specifically
>>> using imply OF_HAS_PRIOR_STAGE or select OF_HAS_PRIOR_STAGE (force that
>>> the dtb must be provided to us) sounds like the right direction to take
>>> these platforms.
>>>
>>
>> --
>> // Caleb (they/them)

-- 
// Caleb (they/them)
