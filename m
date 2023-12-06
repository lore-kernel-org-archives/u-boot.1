Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA04C10DC1
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 11:50:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9796D86E73;
	Wed,  6 Dec 2023 12:50:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J1U+CEo4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31D3586D10; Wed,  6 Dec 2023 12:50:25 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 193B78768A
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 12:50:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3332efd75c9so608724f8f.2
 for <u-boot@lists.denx.de>; Wed, 06 Dec 2023 03:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701863421; x=1702468221; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HjT3YSpB+bQ48xP0RN0rIDrXAC2LKSCg6yvo6qHcIqE=;
 b=J1U+CEo4bj3jPZIaSIYyxb2yxxRYxEfdFutbxe/qeRFWpg2MgYPjeR6yKW9uOyETsl
 r1C/Q6RXPl0VXsLKXcTGVxc/M1ZhM7Zg0rCUNvxdWFZcuBqxur6fmrAuxT8PIsPC7Gdl
 9rk1yYTm0c11UItZp5YkwmgkJ/fuCzy834tpN4cF6hT8GESMaF3nXuAy+24klQpDHVll
 gYCyVsXp/8y8s+beLDR0YrvWIH9WD5I6mcnCyXYoUlw7HdYByFf2BNJGyPpacq/HL0BG
 6m9pJwhTQaWa/5A3G+1TUwAOVqQ3kqwzvu1/CnPdyg4FPJ4ra1iWqC5WCNbA7ph5R/6c
 71Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701863421; x=1702468221;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HjT3YSpB+bQ48xP0RN0rIDrXAC2LKSCg6yvo6qHcIqE=;
 b=gbV1WpxNnRy+sQ+ypL1TdqzX0RtJGq37oed84HVYGhqpjCbJjSEoRByvYWb53pYCbs
 shPivGweEkL4fIzc6uThNHwSEQw0jjEn6GXGzobcLaymY5GkFgjisgRTOQdIF9gi3d6I
 lyZOv7C8xivDXW+YvDSZugzrDne20fgHtNkQiOevgGKGiBbE1q8bR1NqKnRxD5p1MSFx
 wpOdZq6k8XYF4nfq8RakQHU8K3I6YqmegpmG9xgB1ZiKIq7cSS2ULsLGgyAljVAzV9fS
 ZczqXyjM/0nLhZNSxZo9RvPkbPOQEqIHlV8wX+Vu8O7tAi7vlu+fZ4lr+dyasFmHxkIB
 Mnyg==
X-Gm-Message-State: AOJu0YxA0f5Qw5n9xF+S124vko/B8yoW3nOpZe2V7NW0z1GBJNq88BZQ
 IYNJpSdAngE2Acb3IjQP2QoB0w==
X-Google-Smtp-Source: AGHT+IE1Whc1GDOKoeBGhUjxvIXg8hJ4nyQeHT4jXEBy/oE+T0DNG7GNibw3yZj0U1Q1J3K1QCjGoA==
X-Received: by 2002:a5d:42cf:0:b0:333:3bd6:5280 with SMTP id
 t15-20020a5d42cf000000b003333bd65280mr212640wrr.166.1701863421446; 
 Wed, 06 Dec 2023 03:50:21 -0800 (PST)
Received: from [192.168.1.15] (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 j5-20020a5d5645000000b0033335644478sm3237891wrw.114.2023.12.06.03.50.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Dec 2023 03:50:21 -0800 (PST)
Message-ID: <b343d717-857d-4624-a6e5-1aecea56a808@linaro.org>
Date: Wed, 6 Dec 2023 11:50:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/21] Qualcomm generic board support
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Dzmitry Sankouski
 <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
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
 <CAC_iWjJ6KKJH=oBcXD7gb6f8KcK+OQV4Qo=B=UNeEUk-w2q61A@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAC_iWjJ6KKJH=oBcXD7gb6f8KcK+OQV4Qo=B=UNeEUk-w2q61A@mail.gmail.com>
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



On 06/12/2023 10:44, Ilias Apalodimas wrote:
> Hi Tom,
> 
> On Wed, 22 Nov 2023 at 16:28, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Wed, Nov 22, 2023 at 07:44:09PM +0530, Sumit Garg wrote:
>>> On Wed, 22 Nov 2023 at 19:31, Tom Rini <trini@konsulko.com> wrote:
>>>>
>>>> On Wed, Nov 22, 2023 at 11:51:29AM +0530, Sumit Garg wrote:
>>>>> Hi Caleb,
>>>>>
>>>>> On Tue, 21 Nov 2023 at 22:39, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>>> [snip]
>>>>>> == DT loading ==
>>>>>>
>>>>>> Previously, boards used the FDT blob embedded into U-Boot (via
>>>>>> OF_SEPARATE). However, most Qualcomm boards run U-Boot as a secondary
>>>>>> bootloader, so we can instead rely on the first-stage bootloader to
>>>>>> populate some useful FDT properties for us (notably the /memory node and
>>>>>> KASLR seed) and fetch the DTB that it provides. Combined with the memory
>>>>>> map changes above, this let's us entirely avoid configuring the memory
>>>>>> map explicitly.
>>>>>
>>>>> Since with this change, we don't need to embed FDT blob in the u-boot
>>>>> binary, so I was thinking if we really need to import DTs from Linux
>>>>> for different platforms and then play a catchup game?
>>>>>
>>>>> IMO, the build command would look like following if we import
>>>>> pre-built FDT blob from Linux:
>>>>>
>>>>> - Build u-boot::
>>>>>
>>>>>        $ export CROSS_COMPILE=<aarch64 toolchain prefix>
>>>>>        $ make qcom_defconfig
>>>>>        $ make
>>>>>
>>>>> - gzip u-boot::
>>>>>
>>>>>        gzip u-boot-nodtb.bin
>>>>>
>>>>> - Append dtb to gzipped u-boot::
>>>>>
>>>>>         cat u-boot-nodtb.bin.gz
>>>>> <linux-tree>/arch/arm64/boot/dts/qcom/your-board.dtb >
>>>>> u-boot-nodtb.bin.gz-dtb
>>>>>
>>>>> This would avoid the maintenance burden to keep DT in sync with that
>>>>> of Linux. And since DT bindings in Linux are backwards compatible, we
>>>>> can say u-boot should work with DTB picked up from any Linux kernel
>>>>> stable release.
>>>>
>>>> I guess one question I have is, are we being passed the device tree
>>>> (since we're acting like the Linux Kernel)
>>>
>>> Yeah that is the case here, see patch #1 in this series regarding how
>>> FDT address is being retrieved from previous stage bootloader (ABL on
>>> sdm845 and qcs404 SoCs).
>>
>> That's what I thought.
>>
>>>> or knowing that we have the
>>>> dtb attached to the end of us and making use of the old kernel appended
>>>> dtb option? We're fine in for example the rpi_arm64 case of just being
>>>> given a device tree from the previous stage and not needing one in-tree.
>>>
>>> That's good to know and we can replicate that for Qcom platforms which
>>> are chainloaded and don't need an embedded DT.
>>
>> So yes, moving these towards the direction of rpi_arm64 and specifically
>> using imply OF_HAS_PRIOR_STAGE or select OF_HAS_PRIOR_STAGE (force that
>> the dtb must be provided to us) sounds like the right direction to take
>> these platforms.

This is implicitly enforced by the bootloader on Qualcomm platforms. It
will only even boot U-Boot if we gzip u-boot-nodtb.bin, then append some
valid DTB to it, and then shove it in an Android boot image. If there is
no DTB then the bootloader won't run U-Boot. If we somehow did run
U-Boot without a valid DTB then we wouldn't be able to print anything
anyway (unless debug UART is enabled).


>>
> 
> IMHO that option isn't that useful.  Grepping for OF_HAS_PRIOR_STAGE
> shows that we use it to print where the DT came from unless I am
> missing something...
> On top of that having implies in the Kconfig to control those prints
> makes little sense to me and it's a half-baked solution anyway,
> because may boards don't fill this properly.  This thing was cleaned
> up in 2e8d2f88439d, 2ea63271e522f, and d6f8ab30a2af46 but then got
> reintroduced in 275b4832f6bf91 without anyone acking or reviewing. I
> am fine with Caleb suggests here, but I think we can do way better.
> 
> Instead of having that imply we can get rid of it and only have
> OF_BOARD(and perhaps rename it). So a general cleanup I have in mind
> is
> 
> CONFIG_OF_SEPARATE -> rename it to CONFIG_OF_APPEND because it is
> actually appended at the end of the binary.
> CONFIG_OF_EMBED -> Leave it as is, it's there for debugging mostly.
> CONFIG_OF_BOARD perhaps rename it to something more useful, but the
> semantics are 'The DT comes from an *external* source. A bloblist,
> some EEPROM location, CPU registers etc'
> CONFIG_OF_HAS_PRIOR_STAGE -> Get rid of it again. gd already has
> gd->fdt_src, just add a FDTSRC_UNKNOWN as default and delegate the
> responsibility of filling this properly at fdtdec_setup(). The boards
> that use OF_BOARD can fill this in properly, instead of relying on
> Kconfig imply options and we can even be more explicit on where the DT
> came from.

This sounds good to me, although I guess I'm mostly unaffected anyways.
> 
> I can send an RFC if anyone thinks this is a cleaner approach>
> Thanks
> /Ilias
> 
> 
> 
>> --
>> Tom

-- 
// Caleb (they/them)
