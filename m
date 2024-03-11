Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFADC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 15:13:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B757087E50;
	Mon, 11 Mar 2024 16:13:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xpTxaBbi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B80B87E13; Mon, 11 Mar 2024 16:13:21 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 591EC87E32
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 16:13:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33e76d653b5so3108035f8f.3
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 08:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710169997; x=1710774797; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1zaxPnJnc8gaH0Bbx3wKKm2kwOyR+crciMJK41HMLvE=;
 b=xpTxaBbiIJMgVN5XjRedt2dLK58mDwmFA+KJRp0mYzhMqu4RoTF07wM2W18UEAaCBN
 /ugJcxUbnY3v0H4yV26gmSd40KQsGh/dr4RvTB+2dRAQ3sY+PFGRnHLlx4yzYv2mTeHc
 jiOPGuuXKPMGifZiNI9WNJAvOtosXqL7CgfCgDrcPFT46b7T8VHlGqEKS/nTk+6Q3aHK
 Io1kBlpZOsgFuL6faocctetqFfDmFA3bIwJdFITUvwfScyNVJV4MXXnHz1N8im1cX7x0
 Lc6JArB0Db3vNEbr/z8tOYVxp4oPJ6TsBmah7Ggj58JdrWIfsOi8EXt8zKBAlnq3ydAX
 aurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710169997; x=1710774797;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1zaxPnJnc8gaH0Bbx3wKKm2kwOyR+crciMJK41HMLvE=;
 b=SQx49CxYRBW4KA86GJiFIxBkwNJQTbFH/ZqnRsbIUpEFY26u7/0K7vwxhGGfyMU70u
 SU6/jgP2z4pjxq2JtOqC1Nq1fJ4TwtHChwksLUCobWCg3Z3wMmM8ymcct0zcqJ0uKbT3
 QHzGZn+j+6FQpRKg8bvfRhT8n1kMqzv2Tm99ML0ByFqzDTrDwUlhXHxyewIy32dY/JOn
 1INfhN/mzHa8oIpqXAJfQRjN6UInlHheaXrPJuc1C02WaESSMdybnut0rhPUiHeHBIts
 SPO4rdsMkP4BT7Hp8v6bggb8n2YlYRWp0jPnY8tuSUUXkwHSNPFdFkl3hJWrv6hTxm2v
 YCcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGGETvuhQ9+iUC++peQjwemhiBCu5wnxFeZhgII9Va2KNUPq9mqcU6zdPbgazF7kMQtZ6RpVOz+vSV77JdIaGv+JUXaw==
X-Gm-Message-State: AOJu0YycRre1ZQNyG8CLcOW5s2GR6RbkOPKTSQm6RZtBtax6UPzjijQ/
 UYQGhM4uNJ9nKLAE0TxVpbwE35o7jaaDb9IK2puDmupXjMFDTbyBer85iUI7rA4=
X-Google-Smtp-Source: AGHT+IG3hqX4iYAqMOsXnG88DSJAnK0O6xfCyGM1AgxUhdQ9pSsNYD7w9y8hZDi/Y87Ori8DPnuWaA==
X-Received: by 2002:adf:fe8a:0:b0:33e:7fbd:5e6d with SMTP id
 l10-20020adffe8a000000b0033e7fbd5e6dmr4419108wrr.11.1710169996763; 
 Mon, 11 Mar 2024 08:13:16 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 n2-20020a5d4002000000b0033de2f2a88dsm6609269wrp.103.2024.03.11.08.13.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 08:13:16 -0700 (PDT)
Message-ID: <0cda2608-856f-4650-92a6-4860a0d7c8b6@linaro.org>
Date: Mon, 11 Mar 2024 15:13:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] board: add support for Qualcomm SA8155P-ADP board
Content-Language: en-US
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: Sumit Garg <sumit.garg@linaro.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
 <20240306005230.2638972-9-volodymyr_babchuk@epam.com>
 <CAFA6WYNWxHU4W0xrTC=mQJbP49hFMm56fbz1isd0xNNQ_VdVSw@mail.gmail.com>
 <87jzmf2mvi.fsf@epam.com> <e5e47988-c617-48a0-a10a-e37edb9a8267@linaro.org>
 <87y1av12bg.fsf@epam.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <87y1av12bg.fsf@epam.com>
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



On 06/03/2024 21:24, Volodymyr Babchuk wrote:
> 
> Hi Caleb,
> 
> Caleb Connolly <caleb.connolly@linaro.org> writes:
> 
> [...]
>>>>> +};
>>>>> +
>>>>> +&tlmm {
>>>>> +       /* U-Boot pinctrl driver does not understand multiple tiles */
>>>>> +       reg = <0x0 0x03000000 0x0 0x1000000>;
>>>>> +       /delete-property/ reg-names;
>>>>
>>>> This won't be needed if we can make the tiles offset in the pinctrl
>>>> driver compatible:
>>>>
>>>> #define WEST   0x00000000
>>>> #define EAST   0x00400000
>>>> #define NORTH  0x00800000
>>>> #define SOUTH  0x00C00000
>>>
>>> Hmm, I assume that in this case pinctrl driver should map all the four
>>> tiles independently? Are there guarantees in U-Boot that four separate
>>> memory regions will be mapped into virtual memory with the same relative
>>> positions? Linux clearly don't make such guarantees.
>>
>> U-Boot doesn't use virtual addresses on arm platforms, it only goes as
>> far as reading the address from DT, nothing else, so this is totally
>> fine and is how the other SoCs do it.
> 
> For me it looks like we are depending on implementation details
> knowledge. I.e MMU API does not provide such guarantees, but drivers
> know how ARM MMU code is working internally and drivers depend on
> exactly this behavior. But if you are saying that it is totally fine,
> I'll rework the patch. No big deal. Actually, I already tried this and
> it is working fine.
> 
>>>>> +
>>>>> +       /* U-Boot ethernet driver wants to drive reset as GPIO */
>>>>> +       /delete-node/ phy-reset-pins;
>>>>
>>>> I suppose this is not needed as phy-reset-pins also configures the pin
>>>> as GPIO only.
>>>>
>>> Well, yes. This also puzzles me up, but for some reason it stops working
>>> if I leave this node intact. Looks like I need to look at this deeper
>>> before posting the next version.
>>
>> Possibly the pinconf defined in the phy-reset-pins node causes U-Boot to
>> misbehave, can you check if this patch fixes it (there is a bug in the
>> line "return msm_gpio_direction_input(dev, gpio);", it should become
>> just "msm_gpio_direction_input(dev, gpio);").
>>
>> I had the exact same issue with the gpio-regulator driver and this was
>> the solution I ended up going with.
>>
>> https://urldefense.com/v3/__https://lore.kernel.org/u-boot/20240131-b4-qcom-livetree-v1-7-4071c0787db0@linaro.org/__;!!GF_29dbcQIUBPA!xFhZe7DKgRbr63sirEJLuH-B0AnGs7jvx8tdJPKLTgFuZ3I3_zpVml7l23G-_vJO_JiUR-wUO4GMPJFcE-8p50H3pf7nbxit$
>> [lore[.]kernel[.]org]
> 
> It is exactly this. With your patch I don't need to /delete-node/
> anymore. I'll add a comment in the cover message that this series are
> depended on your patch.

Please can you split the power domain and clock patches into a separate
series? As I'd like to depend on them for the next revision of my
series, and we'd otherwise have a cyclical dependency.
> 
> (and sorry for the mangled link. It is our corporate mail server doing)
> 
> 
>>>
>>>>> +};
>>>>> diff --git a/board/qualcomm/sa8155p-adp/MAINTAINERS b/board/qualcomm/sa8155p-adp/MAINTAINERS
>>>>> new file mode 100644
>>>>> index 0000000000..03fac84f51
>>>>> --- /dev/null
>>>>> +++ b/board/qualcomm/sa8155p-adp/MAINTAINERS
>>>>> @@ -0,0 +1,5 @@
>>>>> +Qualcomm SA8155P Automotive Development Platform
>>>>> +M:     Volodymyr Babchuk <volodymyr_babchuk@epam.com>
>>>>> +S:     Maintained
>>>>> +F:     board/qualcomm/sa8155p-adp/
>>>>> +F:     configs/sa8155p-adp_defconfig
>>>>> diff --git a/configs/sa8155p_adp_defconfig b/configs/sa8155p_adp_defconfig
>>>>> new file mode 100644
>>>>> index 0000000000..b6969767f8
>>>>> --- /dev/null
>>>>> +++ b/configs/sa8155p_adp_defconfig
>>>>> @@ -0,0 +1,35 @@
>>>>> +CONFIG_ARM=y
>>>>> +CONFIG_SKIP_LOWLEVEL_INIT=y
>>>>> +CONFIG_COUNTER_FREQUENCY=19000000
>>>>> +CONFIG_POSITION_INDEPENDENT=y
>>>>> +CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
>>>>> +CONFIG_ARCH_SNAPDRAGON=y
>>>>> +CONFIG_TEXT_BASE=0x85710000
>>>>
>>>> Being position independent shouldn't require a hardcoded U-Boot text
>>>> base. Can you try if we can get rid of this?
>>>>
>>>
>>> Well, it is required if we want to load U-Boot instead of hyp.mbn. We
>>> need correct addresses in the ELF file so Qualcomm loader will not
>>> reject it right away.
>>>
>>>>> +CONFIG_DEFAULT_DEVICE_TREE="qcom/sa8155p-adp"
>>>>> +CONFIG_IDENT_STRING="\nQualcomm SA8155P-ADP"
>>>>> +CONFIG_SYS_LOAD_ADDR=0x85710000
>>>>
>>>> Ditto.
>>>>
>>>>> +CONFIG_REMAKE_ELF=y
>>>>> +CONFIG_BOOTDELAY=3
>>>>> +CONFIG_SYS_CBSIZE=512
>>>>> +# CONFIG_DISPLAY_CPUINFO is not set
>>>>> +CONFIG_HUSH_PARSER=y
>>>>> +CONFIG_OF_UPSTREAM=y
>>>>> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>>>>> +CONFIG_NET_RANDOM_ETHADDR=y
>>>>> +CONFIG_CLK=y
>>>>> +CONFIG_CLK_QCOM_SM8150=y
>>>>> +CONFIG_MSM_GPIO=y
>>>>> +CONFIG_PHY_MICREL=y
>>>>> +CONFIG_PHY_MICREL_KSZ90X1=y
>>>>> +CONFIG_DM_MDIO=y
>>>>> +CONFIG_DM_ETH_PHY=y
>>>>> +CONFIG_DWC_ETH_QOS=y
>>>>> +CONFIG_DWC_ETH_QOS_QCOM=y
>>>>> +CONFIG_PHY=y
>>>>> +CONFIG_PINCTRL=y
>>>>> +CONFIG_PINCONF=y
>>>>> +CONFIG_PINCTRL_QCOM_SM8150=y
>>>>> +CONFIG_POWER_DOMAIN=y
>>>>> +CONFIG_MSM_GENI_SERIAL=y
>>>>> +CONFIG_SPMI_MSM=y
>>>>> +CONFIG_LMB_MAX_REGIONS=64
>>>>
>>>> Apart from above, I think this platform should be able to reuse
>>>> qcom_defconfig as you can find most of the config options there. Can
>>>> you try to reuse it?
>>>
>>> Honestly, the whole reason I am porting U-Boot to this platform is
>>> because I want to run Xen on it. And to run Xen, I need to run U-Boot in
>>> EL2. And to do this I need u-boot.elf with "correct" load address and
>>> entry point.
>>>
>>> I am planning to publish and upstream Xen patches as well (once I finish
>>> them). And it will be really nice if Xen users will be able use
>>> mainline U-Boot to boot Xen.
>>
>> I would like to enable the SM8150 drivers in qcom_defconfig (for
>> chainloading and supporting other platforms). But I'm totally fine with
>> having a separate defconfig for this board with this configuration.
> 
> Yes, this is a good approach. I'll do this.
> 
> [...]
> 

-- 
// Caleb (they/them)
