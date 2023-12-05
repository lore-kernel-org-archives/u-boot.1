Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE87C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 10:55:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39D33878BD;
	Tue,  5 Dec 2023 11:55:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QUjK2y6o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A84B878C6; Tue,  5 Dec 2023 11:55:22 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F9BA877AC
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 11:55:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40c09d0b045so26327175e9.0
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 02:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701773719; x=1702378519; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UjknMmjbYSGOEE2GxC161Z37A/uinLKGEBQCsXWyc9U=;
 b=QUjK2y6ocmdIlZcuac8ljfVQyABqI42419MZQUYCtoxedJ5FMCikaqmXgzJ2WZxh8y
 0c8TdKJGiF+dUE3/MdJ+fo8cgYKxJsXM2htPJZxgPAlAPdxOr17HuCmuakde6zU4gn72
 tyfjKLMz1GI7tElJateaDfQf/ieczrzph0PDAOL1UX6R+URhRzTh1Fe1aijVQ8k3O6JE
 TzMBRFNhA7ca+VIiQ0E3OV1gSviL3KRBb12xvhb4GPkijfUsoAo5vekakJkQr0/VJimo
 iiS5Z4gSPI57SZNNQ05Apj+TMs+2Wu/WPdLWYgWudu8sPdgNV56Vj8wYA19dorT1n3Qu
 K1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701773719; x=1702378519;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UjknMmjbYSGOEE2GxC161Z37A/uinLKGEBQCsXWyc9U=;
 b=TGpM3NFzbNTxStDnx6rmzo1FTRDzsJAPPd91SPZ8WIbS31SRVCAgAFDb2UTi+abHmr
 RNu9meNCtgM2I+AsChI2yyRSJxt7XLZOBKgIPIV4V5LfXeJgmEaVkvL4iwh3F0cqqv8U
 oVyR251L+ALio2QhT6v48hUU5xcwD9HYMC4LhJi2Qa6rrheDuMUxBQ0ZZscR8U9EwBIK
 x+eQyYVBB3Y7n/MH+E/9D3CtH9FB3EDIvOAB43g6YRH4aNT/c8F2ghmaKKNngUiOWO5e
 iwNtjnQa2jQdXBQ3MSCBdNVs+nU4m5WDX1DbfhAmSLIg2g7cOL60EJGok2L6i7BjaWXe
 jITg==
X-Gm-Message-State: AOJu0YwBaxPmoaA6pPHvMJEwc5fl95PT951SX+WPtiQfOKJlN2S6eP/2
 tV+oOMri1qJiLCGsSKtkStkW8A==
X-Google-Smtp-Source: AGHT+IHqJbTC29gBx8Jlu0GSRRgImVMZCHadczBYu1hB7sNCBiO97FJx8o21BWb3FVNr6N/B2xVwSQ==
X-Received: by 2002:a05:600c:54d0:b0:40c:c98:3de9 with SMTP id
 iw16-20020a05600c54d000b0040c0c983de9mr237647wmb.251.1701773719483; 
 Tue, 05 Dec 2023 02:55:19 -0800 (PST)
Received: from [192.168.1.15] ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 bh12-20020a05600c3d0c00b0040b2976eb02sm18338572wmb.10.2023.12.05.02.55.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Dec 2023 02:55:19 -0800 (PST)
Message-ID: <b93994f4-40a7-4e1c-9e15-1dcaa16d900f@linaro.org>
Date: Tue, 5 Dec 2023 10:55:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/21] Qualcomm generic board support
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Dzmitry Sankouski
 <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <CAFA6WYPe8_onKNYzAVr9RHVbwUZCTiEkDizwnfL6QRsqii-JUg@mail.gmail.com>
 <CAPnjgZ03MEK_PeuaXcR1VuC-_tBmQmrzq3bo-jS3Jd22+rSgww@mail.gmail.com>
 <CAFA6WYOQX64jArOAV1W-8=174pru78SotGNVhjYth8qu=Swa=Q@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYOQX64jArOAV1W-8=174pru78SotGNVhjYth8qu=Swa=Q@mail.gmail.com>
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



On 05/12/2023 07:44, Sumit Garg wrote:
> Hi Simon,
> 
> On Tue, 5 Dec 2023 at 06:22, Simon Glass <sjg@chromium.org> wrote:
>>
>> Hi Sumit,
>>
>> On Tue, 21 Nov 2023 at 23:21, Sumit Garg <sumit.garg@linaro.org> wrote:
>>>
>>> Hi Caleb,
>>>
>>> On Tue, 21 Nov 2023 at 22:39, Caleb Connolly <caleb.connolly@linaro.org> wrote:
[...]
>>>> == DT loading ==
>>>>
>>>> Previously, boards used the FDT blob embedded into U-Boot (via
>>>> OF_SEPARATE). However, most Qualcomm boards run U-Boot as a secondary
>>>> bootloader, so we can instead rely on the first-stage bootloader to
>>>> populate some useful FDT properties for us (notably the /memory node and
>>>> KASLR seed) and fetch the DTB that it provides. Combined with the memory
>>>> map changes above, this let's us entirely avoid configuring the memory
>>>> map explicitly.
>>>
>>> Since with this change, we don't need to embed FDT blob in the u-boot
>>> binary, so I was thinking if we really need to import DTs from Linux
>>> for different platforms and then play a catchup game?
>>>
>>> IMO, the build command would look like following if we import
>>> pre-built FDT blob from Linux:
>>>
>>> - Build u-boot::
>>>
>>>        $ export CROSS_COMPILE=<aarch64 toolchain prefix>
>>>        $ make qcom_defconfig
>>>        $ make
>>>
>>> - gzip u-boot::
>>>
>>>        gzip u-boot-nodtb.bin
>>>
>>> - Append dtb to gzipped u-boot::
>>>
>>>         cat u-boot-nodtb.bin.gz
>>> <linux-tree>/arch/arm64/boot/dts/qcom/your-board.dtb >
>>> u-boot-nodtb.bin.gz-dtb
>>
>> What is this?? Who or what uses a gzipped image with a single DT attached?
> 
> The gzipped image is loaded by Qcom proprietary bootloaders (ABL or
> LK). It is the usual way Linux is booted on these platforms. U-boot is
> being brought into this chain to leverage standardized EFI boot
> processes.

Yes, just to clarify, this is the state that _all_ non-WoA Qualcomm
boards/devices are in right now (with the exception of db410c), with
production devices we can't modify the bootloader without vendors
releasing their signing keys.

For devices that haven't been locked with vendor keys ("Secureboot off"
in Qualcomm terminology, note that this has nothing to do with UEFI
secureboot) we can work towards replacing the bootloader entirely with
U-Boot, I have done a PoC of this on SDM845. In that case, we have to
embed the DTB into U-Boot.
> 
>>
>>>
>>> This would avoid the maintenance burden to keep DT in sync with that
>>> of Linux. And since DT bindings in Linux are backwards compatible, we
>>> can say u-boot should work with DTB picked up from any Linux kernel
>>> stable release.
>>
>> That is not the current situation, unfortunately.
>>
> 
> Hopefully with efforts from Caleb and team we can reach that point soon.
> 
>> U-Boot is moving to using Binman to package the firmware. There needs
>> to be a description of the firmware image for each U-Boot boot. To my
>> way of thinking, rpi is a degenerate form, not something to be copied,
>> due to the closed-source nature of the firmware and its inability to
>> be changed. We do have (in the works) a way to pass a DT using a
>> standard firmware handoff. Perhaps that can be adopted by these
>> closed-source projects?
> 
> Why should we really need firmware handoff if the DT can be passed in
> one of the u-boot boot arguments? Linux kernel does support this
> method to retrieve DT as well.

Unfortunately the chances of Qualcomm releasing bootloader updates to
adopt a standard for chainloading U-Boot on their wholely deprecated
platforms of 5/6/7 years ago, and then having OEMs/ODMs (who have no
reason to care, and may not even be around anymore) apply these patches
to their own hacked up fork of the bootloader and ship it to end-users
is honestly even less likely than OEMs releasing the signing keys for
devices they don't support anymore.
> 
>>
>> BTW I am very pleased to see this series and I hope that Qualcomm (via
>> Linaro) can continue to improve its U-Boot support.
> 
> It's good to know, thanks.
> 
> -Sumit
> 
>>
>> [..]
>>
>> Regards,
>> Simon

-- 
// Caleb (they/them)
