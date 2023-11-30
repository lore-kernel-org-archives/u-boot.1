Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970B8C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 14:24:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F154C87677;
	Thu, 30 Nov 2023 15:24:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FlfTmRPA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 926AA875EE; Thu, 30 Nov 2023 15:24:15 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CAC987646
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 15:24:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3316a4bc37dso836418f8f.2
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 06:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701354250; x=1701959050; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cle43HObp8ztrDftXQTzP4NUEWB5TZv/I9AxWjYpXJs=;
 b=FlfTmRPAervsqE8wQwF94S8bzglvrpRofXn/udf/WTyrcY7zzwJiAX2v5SzlwFkgDj
 AEQQMqyngTP04BuQqtrB/pQn0WCS+UROh+LgGY7WB+HVr+uRRG+ZrgSD8HiH8RkEtuyx
 bBK4xh2wF35hXsKO7oLj42NjkroIjFbmIwU4UzdVWBNpjtrer25O0W6tanxgOyjy7aU3
 tYTWIWrwVvIaoQi4MdLPc9fOpGxExx9ph/qNBqWgWPAMMEiUravDHetDQ+Ilgp7vv+/1
 HyV57G2LTJAWgckKzRTLEzXlr66GuuiaA772vpBz++nmfWlpjupMA/EYcju/lp5Onedd
 Fj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701354250; x=1701959050;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cle43HObp8ztrDftXQTzP4NUEWB5TZv/I9AxWjYpXJs=;
 b=H02hfNufUct+66NcsGfMHN7/YSsxl+MUk1Vbxy9Gl9eJ3wSdN/MFZgIqe46Oo6zPmP
 9JiR2SQB9FVrICC8HkwrF5x8yukKdwCWQgSfUC4ZvJVttNh+g5ZmskVtbtQ9IM6+SCwJ
 ddeawiQV7XvLFH0JGYUx70T3MmOvDz2ZoI9DOX7iatdE9ObmgIFLzzZogg+S4ySFCuvq
 xaEUqu1eThy/9fGf8sN68B4SfVzUkzSAtI8kp1wUaGjCbjW7Qs1iYIV2S8Jq0wDbKOkZ
 z8+Dn1PLvkZoAUJkzfEPStPfGdncQN5tDN6d6twNTa4NGQszuIcMjsl84tt0B4hXI5zW
 tc1A==
X-Gm-Message-State: AOJu0YzaKo6iM9J1KsguSDVtYHgao6JO+6H+Gpgk+WV3TIGbHLYjGaNb
 lT98Qgu1vhrVeQ2687buS+ToWw==
X-Google-Smtp-Source: AGHT+IE0QuFB0qEvMLh6TmZMrj+nmG1kwgkpV9BAJ6muHfqoG/UXM5yi1vv27s++SMM3X3EOT83Rsg==
X-Received: by 2002:a5d:4647:0:b0:333:fd3:1a7f with SMTP id
 j7-20020a5d4647000000b003330fd31a7fmr5807870wrs.52.1701354250300; 
 Thu, 30 Nov 2023 06:24:10 -0800 (PST)
Received: from [192.168.1.7] ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 t17-20020a05600c451100b0040b379e8526sm5789903wmo.25.2023.11.30.06.24.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Nov 2023 06:24:09 -0800 (PST)
Message-ID: <9d28855f-dfc7-42b9-abf6-51a15e046b3e@linaro.org>
Date: Thu, 30 Nov 2023 14:24:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/21] Qualcomm generic board support
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, neil.armstrong@linaro.org
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
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
 <22b2c2e2-9ce1-4a5f-8cda-565184eec120@linaro.org>
 <260c6f67-17f7-4255-b759-12fe25024673@linaro.org>
 <CAFA6WYMeg6B7Ozb42u79U43=26JmK3CaxfO29uuqQnGipFowEA@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYMeg6B7Ozb42u79U43=26JmK3CaxfO29uuqQnGipFowEA@mail.gmail.com>
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


>>>>>>>>> Since with this change, we don't need to embed FDT blob in the u-boot
>>>>>>>>> binary, so I was thinking if we really need to import DTs from Linux
>>>>>>>>> for different platforms and then play a catchup game?
>>>>>
>>>>> For now, yes.
>>>>
>>>> But why? Is there any value added by larger u-boot specific DT (most
>>>> of the nodes being unused by u-boot) than what currently u-boot
>>>> supports? The more important part is to get alignment with Linux DT
>>>> bindings. If you need to have memory/reserved-memory nodes in u-boot
>>>> DT for generalization purposes then you should import those particular
>>>> nodes only.
>>>
>>> I've been thinking about and hacking on this for the last week or so,
>>> sorry for the delayed reply here.
>>>
>>> The value is in preventing any of the existing bindings from regressing,
> 
> That is actually best addressed in Linux by checking the DTS against
> yaml DT bindings. We don't have that testing available in u-boot and
> only depend on careful reviews.

Sorry, I didn't explain myself very well here. By having .dtsi files be
identical to Linux, we ensure that U-Boot drivers will remain compatible
with them. Just as an argument not to use custom SoC dts in U-Boot
(which is what we do currently).
> 
>>> and simplifying the bringup process for new platforms (just copy
>>> SoC/PMIC DTSI and write a minimal board DTS to enable the needed hardware).
>>>>
>>>>> There are quite a few features which aren't handled by
>>>>> U-Boot that it shouldn't need to handle (rpm/h resources for example).
>>>>> Also the fixed-regulator / regulator-gpio binding differences.
>>>>
>>>> IMO, we should fix them first and then use Linux DT as it is.
>>>
>>> The biggest blocker here is USB, on sdm845 and the 4 new platforms I
>>> have working, I only support USB high speed, this requires removing the
>>> superspeed phy and adding a DTS property.
>>>
>>> I tried using OF_BOARD_SETUP to make this changes during boot but this
>>> approach really isn't scalable (and I couldn't find a way to make it
>>> work anyway).
> 
> Okay so let's try an alternative intermediate step then. We import the
> Linux DT files *as it is* and then keep the u-boot specific custom
> changes in <soc>-u-boot.dtsi file which is included by the board DTS
> file. This has been the approach that other u-boot platforms follow
> and allow us to easily sync them with Linux while reducing custom
> u-boot specific bits. Eventually we should target at dropping u-boot
> specific custom bits and then directly pick up DTB from Linux and boot
> it.

Ok, I think this is a reasonable approach. Will do that for the next
revision
> 
>>>
>>>>
>>>>>
>>>>> I would definitely like to move towards supporting Linux DT directly,
>>>>> but this approach gives us a nice middleground of minimising the U-Boot
>>>>> specific DT parts.
>>>>
>>>> I don't see any real benefits here apart from the maintenance burden.
>>>> If it had been an actual Linux DT then that can be passed to Linux as
>>>> it is. However, the current modified import you are trying to do
>>>> doesn't solve that purpose as well.
>>>
>>> Ensuring that we don't introduce non-standard bindings (by using Linux
>>> DTSI) is one benefit, simplifying new platform bringup is another.
>>>
>>> The amount of work required to switch to upstream DT is too much to
>>> block this series on. We can work on improving the situation there once
>>> we have these Qualcomm improvements upstream and new boards added. I do
>>> admit that this is quite an awkward middle-ground, and I would not like
>>> it to last for too long.
>>
>> I'm a real supporter of targeting support of unmodified (or very slighly)
>> Linux DT, having a reduced version of the Linux DT will be a pain at each
>> sync, and you'll need to do this manually.
> 
> We have to choose the middle-ground carefully here. It shouldn't give
> the impression that it is an actual Linux DT that you can pass
> directly to Linux via EFI. As otherwise users will hit problems due to
> the partially modified DTs in u-boot.
> 
>>
>> Simply having to copy the Linux DT without any changes will make sure you
>> are in sync with Linux's bindings, and will help making sure you'll boot
>> unchanged Linux DTBs you get from previous loaders.
> 
> Once we have the previous loaders (ABL or LK) providing u-boot fully
> fledged DTB then we don't need to maintain Linux DT copy in u-boot
> which is always a pain to keep in sync.

Yes
> 
>>
>> And in bonus, you'll be able to chain it to the next loader like EFI.
>>
>> So I don't see why any work toward this goal is useless, and if an
>> intermediate step is needed, let's do it.
> 
> See the side effects of an intermediate step mentioned above. Having
> <soc>-u-boot.dtsi clearly separates the changes we have to make for
> u-boot.

Sounds good.

Thanks,
> 
> -Sumit
> 
>>
>> Neil
>>
>>>
>>>>
>>>> -Sumit
>>>>
>>>>>>>>>
>>>>>>>>> IMO, the build command would look like following if we import
>>>>>>>>> pre-built FDT blob from Linux:
>>>>>>>>>
>>>>>>>>> - Build u-boot::
>>>>>>>>>
>>>>>>>>>          $ export CROSS_COMPILE=<aarch64 toolchain prefix>
>>>>>>>>>          $ make qcom_defconfig
>>>>>>>>>          $ make
>>>>>>>>>
>>>>>>>>> - gzip u-boot::
>>>>>>>>>
>>>>>>>>>          gzip u-boot-nodtb.bin
>>>>>>>>>
>>>>>>>>> - Append dtb to gzipped u-boot::
>>>>>>>>>
>>>>>>>>>           cat u-boot-nodtb.bin.gz
>>>>>>>>> <linux-tree>/arch/arm64/boot/dts/qcom/your-board.dtb >
>>>>>>>>> u-boot-nodtb.bin.gz-dtb
>>>>>>>>>
>>>>>>>>> This would avoid the maintenance burden to keep DT in sync with that
>>>>>>>>> of Linux. And since DT bindings in Linux are backwards compatible, we
>>>>>>>>> can say u-boot should work with DTB picked up from any Linux kernel
>>>>>>>>> stable release.
>>>>>>>>
>>>>>>>> I guess one question I have is, are we being passed the device tree
>>>>>>>> (since we're acting like the Linux Kernel)
>>>>>>>
>>>>>>> Yeah that is the case here, see patch #1 in this series regarding how
>>>>>>> FDT address is being retrieved from previous stage bootloader (ABL on
>>>>>>> sdm845 and qcs404 SoCs).
>>>>>>
>>>>>> That's what I thought.
>>>>>>
>>>>>>>> or knowing that we have the
>>>>>>>> dtb attached to the end of us and making use of the old kernel appended
>>>>>>>> dtb option? We're fine in for example the rpi_arm64 case of just being
>>>>>>>> given a device tree from the previous stage and not needing one in-tree.
>>>>>>>
>>>>>>> That's good to know and we can replicate that for Qcom platforms which
>>>>>>> are chainloaded and don't need an embedded DT.
>>>>>>
>>>>>> So yes, moving these towards the direction of rpi_arm64 and specifically
>>>>>> using imply OF_HAS_PRIOR_STAGE or select OF_HAS_PRIOR_STAGE (force that
>>>>>> the dtb must be provided to us) sounds like the right direction to take
>>>>>> these platforms
>>>>>>
>>>>>
>>>>> --
>>>>> // Caleb (they/them)
>>>
>>

-- 
// Caleb (they/them)
