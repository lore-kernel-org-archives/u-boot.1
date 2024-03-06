Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45678C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 20:27:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 760E2875FC;
	Wed,  6 Mar 2024 21:27:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G9EJxCYI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EBF68786C; Wed,  6 Mar 2024 21:27:04 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C54D86D38
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 21:27:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33e4c676f0aso9962f8f.3
 for <u-boot@lists.denx.de>; Wed, 06 Mar 2024 12:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709756819; x=1710361619; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QpaB5vLxfDfXyPw66/K35zUerAyQgVPwsg1bqDQTqoo=;
 b=G9EJxCYI6A/hzM/DPSHhqLtMyCnwTnm8YNYM9g/wKOiYjZHSe24Mb9YnJt7jUAO+TI
 p4qbQRZLtVV3P6HqYe4veDO7gRmWiN0QxpqGliyYLxiATGa8SUcuVSFAsG8Ec+JtMeG/
 ygHRZR+JrqP03eZgyXWaJig9hU4/agf1X7peGV3IOG3IfF+qXr1SDC9e20NC5SnzC7Zr
 FInA7T3dMgkgh8ziNrfgUoejebeDxk9uOYiLTw2yuJGGgcBBbyvMmMhVZ9NxvK1qVk3v
 kacP2SE7Tl9vxgG3bVuS5nLZrpKlejidM03lZs02in9PGjlXGeFjwbxB5YkABLUTHt5s
 Rv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709756819; x=1710361619;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QpaB5vLxfDfXyPw66/K35zUerAyQgVPwsg1bqDQTqoo=;
 b=nx2+WN+HSZ/nEpYD6pD+97c7DDjizbVv/LIVjTwVsWrtQlEen4tozacsLd9Y8Sd/Am
 bw6mzNIeLLmV6OvctxTJChBF39lgk9FOVif4DMr3VITux+0TW5U6U5ftDoXX3UcQ+30Y
 PK2njuy2257BpHIiP+VMRqqEJjZbFX4A/c6sKG4lVP1npzMBA/IdQryTTBDqILmgRJmw
 EjIlZ5JM8hDBsMcvVEQYvycYO97CYYMbvB4PtpzN18495C4Xfi2o3Q5Q4oAyC9Dl04Qz
 T5PA7JUTiB8n3i3OnjvqXltthxpY6gAsW/el22eAkSVUQoPkGysKUUo7BWAxthuYX5a0
 ceGg==
X-Gm-Message-State: AOJu0YwyqcOMpSpnhbDghkjYS4f4e1IPCVI3joCtba7co4O7s8IGRXDW
 up5Kl72AmlE9wVSdNFyA/2+ac/NpShtHhGHFbUiIVHJzvEeg/fR24vnUmRnJRTHdXzY2PaJzPLA
 v
X-Google-Smtp-Source: AGHT+IGNwnZFizCy5DGYMerMrHzWyRoKLCmoGiEVbVtIE4tQDKhSkkWp8RcH9FbfDzQOCxywC8ivNA==
X-Received: by 2002:adf:fb90:0:b0:33d:30a4:d744 with SMTP id
 a16-20020adffb90000000b0033d30a4d744mr10054570wrr.30.1709756819297; 
 Wed, 06 Mar 2024 12:26:59 -0800 (PST)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bd10-20020a05600c1f0a00b00412704a0e4asm341440wmb.2.2024.03.06.12.26.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 12:26:58 -0800 (PST)
Message-ID: <e5e47988-c617-48a0-a10a-e37edb9a8267@linaro.org>
Date: Wed, 6 Mar 2024 20:26:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] board: add support for Qualcomm SA8155P-ADP board
Content-Language: en-US
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
 <20240306005230.2638972-9-volodymyr_babchuk@epam.com>
 <CAFA6WYNWxHU4W0xrTC=mQJbP49hFMm56fbz1isd0xNNQ_VdVSw@mail.gmail.com>
 <87jzmf2mvi.fsf@epam.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <87jzmf2mvi.fsf@epam.com>
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



On 06/03/2024 19:14, Volodymyr Babchuk wrote:
> 
> Hi Sumit,
> 
> Sumit Garg <sumit.garg@linaro.org> writes:
> 
>> Hi Volodymyr,
>>
>> On Wed, 6 Mar 2024 at 06:23, Volodymyr Babchuk
>> <Volodymyr_Babchuk@epam.com> wrote:
>>>
>>> SA8155P Automotive Development Platform is Qualcomm SA8155-based board
>>> for developers. The nice thing that it has unlocked loaders with test
>>> keys support, which means that U-Boot for this platform can be
>>> launched at earlier stages.
>>>
>>> This patch adds basic board support with only serial port and
>>> networking operation. I am using U-Boot to ease up Xen porting onto
>>> this board, so I am mostly interesting in booting U-Boot in EL2. But
>>> more conventional setup with Android boot image is supported as well.
>>>
>>> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
>>>
>>> ---
>>>
>>> Changes in v2:
>>>  - Rebased onto qcom-next branch
>>>  - Removed unnecessary files thanks to generic qualcomm board support
>>>  - Enabled CONFIG_REMAKE_ELF (this removes one extra step in the
>>>    readme)
>>
>> Thanks for the rebase.
> 
> Thank you for the review.
> 
>>>
>>>  arch/arm/dts/sa8155p-adp-u-boot.dtsi   | 30 +++++++++
>>>  board/qualcomm/sa8155p-adp/MAINTAINERS |  5 ++
>>>  configs/sa8155p_adp_defconfig          | 35 +++++++++++
>>>  doc/board/qualcomm/index.rst           |  1 +
>>>  doc/board/qualcomm/sa8155p-adp.rst     | 87 ++++++++++++++++++++++++++
>>>  5 files changed, 158 insertions(+)
>>>  create mode 100644 arch/arm/dts/sa8155p-adp-u-boot.dtsi
>>>  create mode 100644 board/qualcomm/sa8155p-adp/MAINTAINERS
>>>  create mode 100644 configs/sa8155p_adp_defconfig
>>>  create mode 100644 doc/board/qualcomm/sa8155p-adp.rst
>>>
>>> diff --git a/arch/arm/dts/sa8155p-adp-u-boot.dtsi b/arch/arm/dts/sa8155p-adp-u-boot.dtsi
>>> new file mode 100644
>>> index 0000000000..ffbf0933c7
>>> --- /dev/null
>>> +++ b/arch/arm/dts/sa8155p-adp-u-boot.dtsi
>>> @@ -0,0 +1,30 @@
>>> +// SPDX-License-Identifier: BSD-3-Clause
>>> +/*
>>> + * Qualcomm SA8155P-ADP device tree fixups for U-BOot
>>> + *
>>> + * Volodymyr Babchuk <volodymyr_babchuk@epam.com>
>>> + * Copyright (c) 2024 EPAM Systems.
>>> + */
>>> +
>>> +/ {
>>> +       /* Populate memory node with actual memory configuration */
>>> +       memory@80000000 {
>>> +               reg = <0x00 0x80000000 0x00 0x39900000>,
>>> +               <0x02 0x0        0x1  0x7fd00000>,
>>> +               <0x00 0xC0000000 0x1  0x40000000>;
>>> +       };
>>> +};
>>> +
>>> +&ethernet {
>>> +       /* Ethernet driver tries to find reset by name */
>>> +       reset-names = "emac";
>>
>> This deserves to be pushed upstream in Linux kernel DT. In the
>> meantime we can carry it here.
>>
>>> +};
>>> +
>>> +&tlmm {
>>> +       /* U-Boot pinctrl driver does not understand multiple tiles */
>>> +       reg = <0x0 0x03000000 0x0 0x1000000>;
>>> +       /delete-property/ reg-names;
>>
>> This won't be needed if we can make the tiles offset in the pinctrl
>> driver compatible:
>>
>> #define WEST   0x00000000
>> #define EAST   0x00400000
>> #define NORTH  0x00800000
>> #define SOUTH  0x00C00000
> 
> Hmm, I assume that in this case pinctrl driver should map all the four
> tiles independently? Are there guarantees in U-Boot that four separate
> memory regions will be mapped into virtual memory with the same relative
> positions? Linux clearly don't make such guarantees.

U-Boot doesn't use virtual addresses on arm platforms, it only goes as
far as reading the address from DT, nothing else, so this is totally
fine and is how the other SoCs do it.
> 
>>> +
>>> +       /* U-Boot ethernet driver wants to drive reset as GPIO */
>>> +       /delete-node/ phy-reset-pins;
>>
>> I suppose this is not needed as phy-reset-pins also configures the pin
>> as GPIO only.
>>
> Well, yes. This also puzzles me up, but for some reason it stops working
> if I leave this node intact. Looks like I need to look at this deeper
> before posting the next version.

Possibly the pinconf defined in the phy-reset-pins node causes U-Boot to
misbehave, can you check if this patch fixes it (there is a bug in the
line "return msm_gpio_direction_input(dev, gpio);", it should become
just "msm_gpio_direction_input(dev, gpio);").

I had the exact same issue with the gpio-regulator driver and this was
the solution I ended up going with.

https://lore.kernel.org/u-boot/20240131-b4-qcom-livetree-v1-7-4071c0787db0@linaro.org/
> 
>>> +};
>>> diff --git a/board/qualcomm/sa8155p-adp/MAINTAINERS b/board/qualcomm/sa8155p-adp/MAINTAINERS
>>> new file mode 100644
>>> index 0000000000..03fac84f51
>>> --- /dev/null
>>> +++ b/board/qualcomm/sa8155p-adp/MAINTAINERS
>>> @@ -0,0 +1,5 @@
>>> +Qualcomm SA8155P Automotive Development Platform
>>> +M:     Volodymyr Babchuk <volodymyr_babchuk@epam.com>
>>> +S:     Maintained
>>> +F:     board/qualcomm/sa8155p-adp/
>>> +F:     configs/sa8155p-adp_defconfig
>>> diff --git a/configs/sa8155p_adp_defconfig b/configs/sa8155p_adp_defconfig
>>> new file mode 100644
>>> index 0000000000..b6969767f8
>>> --- /dev/null
>>> +++ b/configs/sa8155p_adp_defconfig
>>> @@ -0,0 +1,35 @@
>>> +CONFIG_ARM=y
>>> +CONFIG_SKIP_LOWLEVEL_INIT=y
>>> +CONFIG_COUNTER_FREQUENCY=19000000
>>> +CONFIG_POSITION_INDEPENDENT=y
>>> +CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
>>> +CONFIG_ARCH_SNAPDRAGON=y
>>> +CONFIG_TEXT_BASE=0x85710000
>>
>> Being position independent shouldn't require a hardcoded U-Boot text
>> base. Can you try if we can get rid of this?
>>
> 
> Well, it is required if we want to load U-Boot instead of hyp.mbn. We
> need correct addresses in the ELF file so Qualcomm loader will not
> reject it right away.
> 
>>> +CONFIG_DEFAULT_DEVICE_TREE="qcom/sa8155p-adp"
>>> +CONFIG_IDENT_STRING="\nQualcomm SA8155P-ADP"
>>> +CONFIG_SYS_LOAD_ADDR=0x85710000
>>
>> Ditto.
>>
>>> +CONFIG_REMAKE_ELF=y
>>> +CONFIG_BOOTDELAY=3
>>> +CONFIG_SYS_CBSIZE=512
>>> +# CONFIG_DISPLAY_CPUINFO is not set
>>> +CONFIG_HUSH_PARSER=y
>>> +CONFIG_OF_UPSTREAM=y
>>> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>>> +CONFIG_NET_RANDOM_ETHADDR=y
>>> +CONFIG_CLK=y
>>> +CONFIG_CLK_QCOM_SM8150=y
>>> +CONFIG_MSM_GPIO=y
>>> +CONFIG_PHY_MICREL=y
>>> +CONFIG_PHY_MICREL_KSZ90X1=y
>>> +CONFIG_DM_MDIO=y
>>> +CONFIG_DM_ETH_PHY=y
>>> +CONFIG_DWC_ETH_QOS=y
>>> +CONFIG_DWC_ETH_QOS_QCOM=y
>>> +CONFIG_PHY=y
>>> +CONFIG_PINCTRL=y
>>> +CONFIG_PINCONF=y
>>> +CONFIG_PINCTRL_QCOM_SM8150=y
>>> +CONFIG_POWER_DOMAIN=y
>>> +CONFIG_MSM_GENI_SERIAL=y
>>> +CONFIG_SPMI_MSM=y
>>> +CONFIG_LMB_MAX_REGIONS=64
>>
>> Apart from above, I think this platform should be able to reuse
>> qcom_defconfig as you can find most of the config options there. Can
>> you try to reuse it?
> 
> Honestly, the whole reason I am porting U-Boot to this platform is
> because I want to run Xen on it. And to run Xen, I need to run U-Boot in
> EL2. And to do this I need u-boot.elf with "correct" load address and
> entry point.
> 
> I am planning to publish and upstream Xen patches as well (once I finish
> them). And it will be really nice if Xen users will be able use
> mainline U-Boot to boot Xen.

I would like to enable the SM8150 drivers in qcom_defconfig (for
chainloading and supporting other platforms). But I'm totally fine with
having a separate defconfig for this board with this configuration.
> 
>>> diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
>>> index 4955274a39..268218b05f 100644
>>> --- a/doc/board/qualcomm/index.rst
>>> +++ b/doc/board/qualcomm/index.rst
>>> @@ -7,5 +7,6 @@ Qualcomm
>>>     :maxdepth: 2
>>>
>>>     dragonboard410c
>>> +   sa8155p-adp
>>>     board
>>>     debugging
>>> diff --git a/doc/board/qualcomm/sa8155p-adp.rst b/doc/board/qualcomm/sa8155p-adp.rst
>>> new file mode 100644
>>> index 0000000000..66db512b52
>>> --- /dev/null
>>> +++ b/doc/board/qualcomm/sa8155p-adp.rst
>>> @@ -0,0 +1,87 @@
>>> +.. SPDX-License-Identifier: BSD-3-Clause
>>> +.. sectionauthor:: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
>>> +
>>> +SA8155P Automotive Development Platform
>>> +=======================================
>>> +
>>> +About
>>> +-----
>>> +This document describes the information about SA8155P Automotive
>>> +Development Platform aka SA8155P-ADP.
>>> +
>>> +Currently U-Boot can be booted either as Android boot image, or in EL2
>>> +mode, instead of hypervisor image. In the latter case it is possible
>>> +to use U-Boot to either boot Linux with KVM support or to boot Xen
>>> +Hypervisor on this board.
>>> +
>>> +Supported HW modules
>>> +^^^^^^^^^^^^^^^^^^^^
>>> +Port for this board is in early development state. Right now U-Boot
>>> +supports serial console and networking. No USB/fastboot or UFS support
>>> +yet. So it is not possible to save environment variables as
>>> +well. Nevertheless this is enough for development as user can download
>>> +all required images via TFTP.
>>> +
>>> +Installation
>>> +------------
>>> +Build
>>> +^^^^^
>>> +Setup ``CROSS_COMPILE`` for aarch64 and build U-Boot for your board::
>>> +
>>> +       $ export CROSS_COMPILE=<aarch64 toolchain prefix>
>>> +       $ make sa8155p_adp_defconfig
>>> +       $ make
>>> +
>>> +This will build ``u-boot.bin`` in the configured output directory.
>>> +
>>> +Boot in EL1 mode instead of Android boot image
>>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>> +
>>> +Create a dummy ramdisk image:::
>>> +
>>> +       $ echo "This is not a ramdisk" > ramdisk.img
>>> +
>>> +Compress u-boot binary:::
>>> +
>>> +       $ gzip -c u-boot.bin > u-boot.bin.gz
>>> +
>>> +Append DTB again (binary we use already have DTB embedded in, but
>>> +Android boot image format requires another DTB at the end of the
>>> +archive):::
>>> +
>>> +       $ cat u-boot.bin.gz u-boot.dtb > u-boot.bin.gz-dtb
>>> +
>>> +Now we've got everything to build android boot image:::
>>> +
>>> +       $ mkbootimg --kernel u-boot.bin.gz-dtb \
>>> +       --ramdisk ramdisk.img --pagesize 4096 \
>>> +       --base 0x80000000 -o boot.img
>>> +
>>> +Finally you can flash new boot image with fastboot:::
>>> +
>>> +       $ fastboot flash boot boot.img
>>> +
>>> +Or just boot U-Boot without flashing anything:::
>>> +
>>> +       $ fastboot boot boot.img
>>> +
>>> +Boot in EL2 mode instead of Qualcomm's hypervisor stub
>>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>> +This approach ensures that U-Boot is booted in EL2 and it is possible
>>> +to run virtualization software (like Xen or KVM) on the board. You
>>> +must understand that this approach breaks Qualcomm's boot chain. You
>>> +will not be able to call all subsequent loaders, so you will not be
>>> +able to use fastboot for example. Use this approach only if you want
>>> +to experiment with virtualization on SA8155P-ADP.
>>> +
>>> +U-Boot ELF file needs to be signed with test keys. `qtestsign
>>> +<https://urldefense.com/v3/__https://github.com/msm8916-mainline/qtestsign__;!!GF_29dbcQIUBPA!0UfvyQldjKBqYC9K5XA-YFiHToTTSqPC1Bik0hYoZFjtfVhrSIOdYKRg45Pu_frCx0I4Shei89pxPWV2V1fqTuquDoA$
>>> [github[.]com]>`_ tool can be used ::
>>> +
>>> +       $ ../qtestsign/qtestsign.py -v6 hyp u-boot.elf
>>> +
>>> +Resulting ``u-boot-test-signed.mbn`` then can be written to the
>>> +board. Easiest way is to use ``edl`` tool: ::
>>> +
>>> +       $ ../edl/edl w hyp_a u-boot-test-signed.mbn --memory=ufs --lun=4
>>> +
>>
>> Can you provide reference to the EDL tool and its usage so that people
>> can recover their board if it gets bricked?
> 
> Sure, I'll add the link in the next version.
> 

-- 
// Caleb (they/them)
