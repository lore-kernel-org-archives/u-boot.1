Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35508C52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 20:33:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5609D88E49;
	Wed, 21 Aug 2024 22:33:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="plB3n2tr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E61E988E44; Wed, 21 Aug 2024 22:33:15 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DFA988AA7
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 22:33:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a8683dc3b17so5276266b.3
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 13:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724272393; x=1724877193; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=adzW2nG3vnre5igcN6JG/l23ZQU/RvoLKKVJ7G7+ObY=;
 b=plB3n2tr9ThT+rYQI1jaYI12/W03zIKRWa2xv05YD+Ji1EXPJfGlLisg2NfIOrkSHG
 04ZpJEVLsLzybo1WrSBaTM+Ani6HVs49YreeLK4jf+ELrlxNbl6VLoAqZZIG14mV4L6V
 qLgrYB0LC6y/96bxbJvOlfrE45qcBrO4WEvlyV/6MEZ7UnWYu690xHLmR7TLPsyjODJ1
 HU30CPXElARbbjQoNSGhvdIPf00xQsViycVLbeoXvlo9sAns5x5Rq/BzJN6Ls5KikIPH
 XNtGN4i7UuMrD/bnkRGRhL/iWwFp2X3ss1XDg+SaTcR+TNTItgpa1LGGWi6Uo9XpHpMX
 cOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724272393; x=1724877193;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=adzW2nG3vnre5igcN6JG/l23ZQU/RvoLKKVJ7G7+ObY=;
 b=j6ZuM0m4urBil4nrGF1QaQIUMpx4zohNxT4T1feirtt2dxPicj7AEq5Jkurr3rmE6V
 LwRkkQSah64fnhcjCTOllef9bTsHXk/9WqhmVjsu9RaGmOURe5VYeq6Uj3Vcw8tsFTlr
 cGGB4vzCGSGA1Oha+lAf1+N8cbMELMOCL23VV4U2yozB03DcNXXPdcuPcQpM/i9S4cnk
 AIpVeE6ruGDZ+9I/F+PwUhdrr8GLbvMWKCzYLm6sP32r9q9pQIojuzwFE1cOCPCi+74p
 UKW4Syz3BUIQiH3fKvkIMywWwurSIrVeT3yPv7TAE53xvsHNc0wLJD2FS0UXEKfkdd5C
 2lLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw1mPChENzomId3UVfwMysND4xMJBfE+weJPy6Vt/ZWGqdlBI5zbmemPiFFnZCWWeBj4e6xlM=@lists.denx.de
X-Gm-Message-State: AOJu0Yxasc6+rykMBirQY/G0NBgKWstoGuOQGa0c7HkyAMZi71CMBoJM
 RCQrllhM1k7zLln2l7kfzz247SEZetxipE8r9gKT/1wlKP+PYuXnOdEk1Nz3iaw=
X-Google-Smtp-Source: AGHT+IF2O1j82rBDG2caz1Q2Ta1CApK8I9cn/yH1X+vdh53QKT9kQjp6bWndoLGQHD/HO7FbKUyUUg==
X-Received: by 2002:a05:6402:354a:b0:5a1:2ce9:f416 with SMTP id
 4fb4d7f45d1cf-5bf1f294394mr3061611a12.37.1724272392865; 
 Wed, 21 Aug 2024 13:33:12 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::676e? ([2a02:8109:aa0d:be00::676e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c044ddbed8sm16002a12.7.2024.08.21.13.33.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 13:33:12 -0700 (PDT)
Message-ID: <75ba1b5c-5809-46ac-ad85-e4d8c8637853@linaro.org>
Date: Wed, 21 Aug 2024 22:33:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] clk/qcom: add initial clock driver for sc7280
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20240821-b4-rb3gen2-v2-0-49b07633f3a8@linaro.org>
 <20240821-b4-rb3gen2-v2-1-49b07633f3a8@linaro.org>
 <CAFLszTjjS8m2DsNp0nMEknM0ggu4QEET81iSyYFGDYWCwVjf2w@mail.gmail.com>
 <2a45562f-792f-4ad5-9871-bef82ccd2d18@linaro.org>
 <CAFLszTjwjUnGYMdujDUNePBiEU8_oMpkZYpSK8REKxrMYUadpw@mail.gmail.com>
 <eda3f2ad-d011-4ae6-b722-9114daafeae1@linaro.org>
 <CAFLszTidT+=wySmu1uo2auxnsbdvm0Qkav-vwu-3vbU9iuEhhA@mail.gmail.com>
 <c03c84a4-660a-4f20-8da4-e29d613600ac@linaro.org>
 <CAFLszThOJ_pYipxtqaBRCqU+npYrXy4nK4u8C+zM1cVxaR8fjg@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszThOJ_pYipxtqaBRCqU+npYrXy4nK4u8C+zM1cVxaR8fjg@mail.gmail.com>
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



On 21/08/2024 20:27, Simon Glass wrote:
> Hi Caleb,
> 
> On Wed, 21 Aug 2024 at 10:47, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>>
>>
>> On 21/08/2024 18:16, Simon Glass wrote:
>>> Hi Caleb,
>>>
>>> On Wed, 21 Aug 2024 at 08:49, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>>>
>>>>
>>>>
>>>> On 21/08/2024 16:37, Simon Glass wrote:
>>>>> Hi Caleb,
>>>>>
>>>>> On Wed, 21 Aug 2024 at 08:11, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>>>>>
>>>>>> Hi Simon,
>>>>>>>> +U_BOOT_DRIVER(gcc_sc7280) = {
>>>>>>>> +       .name           = "gcc_sc7280",
>>>>>>>> +       .id             = UCLASS_NOP,
>>>>>>>> +       .of_match       = gcc_sc7280_of_match,
>>>>>>>> +       .bind           = qcom_cc_bind,
>>>>>>>> +       .flags          = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
>>>>>>>> +};
>>>>>>>
>>>>>>> This should use driver model, with a UCLASS_CLK and UCLASS_RESET
>>>>>>
>>>>>> Please refer to qcom_cc_bind() which binds the clock, reset, and power
>>>>>> domain drivers.
>>>>>
>>>>> Gosh, why? Are these devices not in the devicetree?
>>>>
>>>> They are, the gcc block contains clock, reset, and pd parts. On Linux
>>>> this is not an issue because a single device can be multiple different
>>>> classes (e..g when you register a reset you do it for a device) whereas
>>>> U-Boot requires a device per class.
>>>>
>>>> e.g. see devm_reset_controller_register() in Linux, it populates a
>>>> struct reset_controller_dev which references the struct device created
>>>> for the node. In U-Boot you have to create a new device which _is_ the
>>>> reset controller.
>>>
>>> OK, I see. Rockchip has a CRU (Clock & Reset Unit) which uses syscon
>>> to access registers. The clock driver 'owns' the node in U-Boot and it
>>> manually binds a reset driver. It isn't great, either.
>>>
>>> Looking at drivers/clk/qcom/clock-sdm845.c (for example), I can't
>>> actually find "qcom,gcc-sdm845" (for example) in U-Boot, except as a
>>> binding. Can you please point me to the node?
>>
>> It's in dts/upstream/src/arm64/qcom/sdm845.dtsi
>>
>>>
>>> Re devm_reset_controller_register(), yes the U-Boot driver model is a
>>> lot more regular, e.g. we don't really want drivers creating their own
>>> struct udevice. We want all devices to be created automatically by the
>>> devicetree and most memory allocations to be done automatically. This
>>> helps to reduce code size and execution time. You probably know all
>>> this :-)
>>
>> Yeah, U-Boot's model is simpler for most cases. This makes sense. But it
>> doesn't reflect the reality of DT so well in cases like this.
>>>
>>> To a significant degree, the devicetree bindings are created without
>>> much thought to efficient operation in U-Boot. I hope that eventually
>>> this might change.
>>
>> I strongly disagree with this mental model. This is the approach I see
>> vendors take in their BSP sources and the result is not pleasant.
>>
>> DT should (within reason) never be written with the OS in mind. It is an
>> agnostic structure to describe the hardware. I think the new power
>> sequencing subsystem in Linux does a good job at embodying how we should
>> approach consuming DT.
> 
> I'm only really involved in mainline and don't really see vendor trees
> much. An example is where pinctrl has a GPIO controller but it is not
> mentioned in the devicetree. It would be better for U-Boot to add a
> subnode for each GPIO controller. In general, if the SoC has a device,
> it should be in the devicetree.

The concept of a device is an OS one. DT is not "telling the OS how to 
use the hardware", it is describing the hardware.

This distinction is important because it's the only way to ensure that 
future OS changes can be done regardless of the DT. And also of course 
because different OS's will have different ideas of how to model devices 
(case in point).

The GCC block on Qualcomm platforms is a single hardware block. The 
datasheets and hardware programming guides describe it as such. The 
clocks, resets, and GDSCs are all entwined at the hardware level. They 
also have overlapping register addresses.

The further away DT gets from describing the hardware in favour of 
simplifying the OS, the more likely we are to start running into issues 
with fitting hardware changes into our arbitrary model.

> 
> Part of this difference (between U-Boot and Linux) comes about because
> Linux device setup is fairly manual, whereas U-Boot tries to put all
> of that in common DM code. Whenever you are including
> dm/device-internal.h that is often a sign that the binding is causing
> issues.

To me this indicates an inability for U-Boot's DM to handle complicated 
devices. I don't think U-Boot should dictate the design of devicetree.

I don't know how else to describe this. This issue has been litigated 
over and over again on the kernel mailing list. Every time someone 
suggests changing DT because of a limitation in Linux they are 
(rightfully) shut down. If these changes were accepted then it would be 
impossible for DT to be an OS agnostic hardware description, because it 
would be full of OS specific hacks.
> 
> I'm happy for you to change my mind.
> 
>>
>>>
>>> Anyway, with the devicetree we have, I wonder how we could do this better?
>>>
>>> Some ideas:
>>>
>>> 1. Allow DM to bind multiple devices to each devicetree node, perhaps
>>> as a Kconfig option (to avoid time penalty for all boards), or by
>>> requiring a new DM_FLAG_MULTI_NODE flag. The devices would then be
>>> independent, with no common parent device
>>
>> This would make sharing match data hard, and likely cause issues with
>> generic compatible strings.
> 
> You would have to repeat the same compatible string in each driver.
> 
> For generic compatible strings we could a) worry about it later or b)
> restrict this technique to only nodes with a single compatible string,
> or c) use the driver flag as mentioned
> 
>>>
>>> 2. As 1 but have DM create a parent 'UCLASS_MULTI' device
>>> automatically. I am thinking that we should have a new uclass for
>>> these things, or rename the NOP uclass. This option would allow easy
>>> access to the parent device, if needed.
>>
>> This is the current approach, we just bind the clk/reset/pd drivers
>> explicitly, allowing us to create and share common data. I don't believe
>> there is a sensible way to do this generically.
> 
> How come? What is qcom_cc_bind() doing which DM couldn't?

Maybe DM could look at the "#clock-cells", "#reset-cells", and 
"#power-domain-cells" properties and match on compatible string + 
uclass? I think that could work.
> 
>>>
>>> 3. Implement devices which are in more than one uclass. There would
>>> still be a primary uclass, but others can be added too. This would
>>> involve declaring a list of secondary uclasses in the U_BOOT_DRIVER()
>>> macro. We would then have a struct dmtag_node for each secondary
>>> uclass, containing the ID and the uclass pointer. Certain functions
>>> would need to be updated to support this, and again it could be behind
>>> a Kconfig.
>>
>> Many device classes in U-Boot rely on going from a struct udevice to
>> some uclass specific data or ops. I have always found this to be a bit
>> odd, though simpler to deal with than Linux.
> 
> In U-Boot the uclass is a stronger concept, e.g. you can generically
> iterate through all devices in a uclass, and all devices have one.
> 
>>>
>>> What do you think?
>>
>> I think if we're to try and solve this at all, the Linux model is by far
>> the most sensible. It is already tried and tested, and would have the
>> huge bonus of simplifying driver porting.
>>
>> barebox went with this approach and it seems to have worked out quite
>> well for them.
> 
> What is the Linux model, in this sense? Whenever I see barebox I
> wonder why we can't fold whatever new features it needs into
> U-Boot...perhaps the code bases have converged too much...?

barebox is livetree only (like Linux) as I understand it, and I think it 
aims to be literally copy/paste compatible with Linux. I would love for 
U-Boot to adopt this approach.
> 
>>
>> All that being said, while it's taken me some time to get my head around
>> "the U-Boot way", I think there is still value in the simplicity of
>> U-Boot's approach. I also think the solution we've ended up with (after
>> many iterations I might add) in clock-qcom is clean, simple, and easy to
>> understand; though I do agree that U-Boot's DM is definitely hitting the
>> limit of what complexity it can handle.
> 
> Well I would like to tidy this up in DM, so let's figure out which
> option makes the most sense...once I understand what you mean by
> 'Linux model' above.

I mean where a single struct device can be multiple classes, so you 
create a device and then create a reset controller and associate the 
device with it.
> 
>>
>> I would honestly be much more interested in seeing early init get
>> cleaned up, OF_LIVE becoming the default, and the ofnode abstraction
>> going away.
> 
> So far as I can tell, you are always going to have a flat tree, even
> if only before relocation or in SPL. How would we get around that?
> Also, what don't you like about ofnode?

Yeah, you start with a flat tree and then should build a live one as 
early as possible.

The problem with ofnode is that it is more or less restricted to the 
subset of operations fdt supports. It lacks some of the fancier features 
of a live tree. It also means that every use of the of_* API has to be 
preceded by a check that we're actually running the live tree, otherwise 
some kind of hard bail.

Would be great to use of_* API by default, for capable platforms anyway.
> 
> Given that Qualcomm is only using U-Boot as a second-stage loader so
> far, (please, not for long!!) everything looks quite different. But
> most platforms use U-Boot from SoC-boot-ROM handoff, so the
> constraints are different (tighter).

For U-Boot SPL yeah I expect the constraints to be different. We're 
getting a bit closer to the metal on the rb3gen2 (now it's just bootROM 
-> SBL1 -> (tz -> hyp) -> U-Boot, without going through edk2 first haha).

I hope we'll get to do U-Boot SPL on some Qualcomm platforms eventually.
> 
> Anyway, certainly OF_LIVE being the default would be good. I have
> often wondered if we can (at build-time) convert the devicetree into a
> 'live' version, where the pointers are replaced by integers, such that
> the early U-Boot code can easily compute the pointer value for each
> node. It should make the unflattening much faster. For pre-relocation
> and SPL, since we know the load address, we can (I am pretty sure)
> have Binman put a full, live tree in the image and avoid the
> unflattening code at all. Relocating a livetree is fairly easy too.

This might be a nice optimisation? I think it would be acceptable to 
just read the memory layout -> enable the MMU -> build the live tree. 
This would probably be fast enough.

And of course, the great thing we have on Qualcomm platforms is that we 
can run the same U-Boot binary on every sdm845 and newer platform.
> 
> Regards,
> Simon

-- 
// Caleb (they/them)
