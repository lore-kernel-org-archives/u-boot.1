Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F3CC61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 16:04:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DF81875FB;
	Wed, 22 Nov 2023 17:04:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nabTPYon";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 993748761F; Wed, 22 Nov 2023 17:04:07 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E015587499
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 17:04:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40b2a8575d9so14056225e9.0
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 08:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700669042; x=1701273842; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JpfInHWXPzeHbxkxirE+q8T9yisY5YzmhRkDtjOrkSM=;
 b=nabTPYonH/y76PORqZtnBeXMh9tqeMZ7+M41Es0kWYdLN3nGViLfo4eEKQ/+bpJjyf
 UtDXUtbGAGFZLOP346yPDlV2EHRBnMIrv+af2lFDn+VRtJk627cp1Yi1uvJvCHTPYqDo
 Tv/ATT7az+tvhVZM1FbDcxAtTEiTDuN7A5ot+DqsNXidrsJRQ4C3UIviN0ctrE2sygCZ
 /HgPY5RTFOuQlLeDFTk0enINRGrSA+xpSsd8vZiQkiUzhH3d7eLxHAOfmvSG87whtFOH
 rrIHvy4T2WgfDDet6/HLiifJ85cv0ayZHkEIF5S+faJE7tte0dXnYGO4aeM5FCYwwHFk
 wMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700669042; x=1701273842;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JpfInHWXPzeHbxkxirE+q8T9yisY5YzmhRkDtjOrkSM=;
 b=Q/SSwnSXOiul/NoaHvKJLFSfMGaEmruSr7yJ7dmzDpYl8geZ/sRoz3XVUlq7MEILer
 OPf3HKpF3ePbfH1V3X1JHp+BFiWivL8QaCc1Svo9ap17yWHdMEaN3sZD/qmTgWdqi1TO
 5nGKQIwrkw+KcakPhJodbjcqOapxEtbzakQ+ZQ4DDth1ukgDNnQUoPF+JKaAlXxuPvQq
 v3XPj9iBN27driN0drpFnDYVxK1f7a7JeZ5WpXz1wMp1b6iFFmmrJ8am9Wu0w0t4dHw7
 LvZIsm7795nSDQu4tJggsJCUBxIlEQlhCED+ekl135BZNYTkbXExRDDEvg63m7xtkqkh
 HVgQ==
X-Gm-Message-State: AOJu0YyIzB1rzNA86hRGmh0j6f3Mla30d1dOpXKlhW7FTG4kfQ5ExFrG
 NYUo7aGZbkB4xohCtFHhD/HEcQ==
X-Google-Smtp-Source: AGHT+IFv95+GGd5emxJnBs6dd9Bnlf2yxcBIN0WBOKtOQYi/0bjVq16LLJBAOdG94MaXGwjAA6g25g==
X-Received: by 2002:a05:600c:468a:b0:40a:55a8:2a44 with SMTP id
 p10-20020a05600c468a00b0040a55a82a44mr2349977wmo.22.1700669042154; 
 Wed, 22 Nov 2023 08:04:02 -0800 (PST)
Received: from [192.168.1.7] ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 n19-20020a05600c4f9300b0040a43d458c9sm2671351wmq.25.2023.11.22.08.04.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Nov 2023 08:04:01 -0800 (PST)
Message-ID: <c47b163b-d0d9-4de6-8ea8-ebe884b28e4b@linaro.org>
Date: Wed, 22 Nov 2023 16:04:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/21] Qualcomm generic board support
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
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
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20231122142758.GU2513409@bill-the-cat>
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



On 22/11/2023 14:27, Tom Rini wrote:
> On Wed, Nov 22, 2023 at 07:44:09PM +0530, Sumit Garg wrote:
>> On Wed, 22 Nov 2023 at 19:31, Tom Rini <trini@konsulko.com> wrote:
>>>
>>> On Wed, Nov 22, 2023 at 11:51:29AM +0530, Sumit Garg wrote:
>>>> Hi Caleb,
>>>>
>>>> On Tue, 21 Nov 2023 at 22:39, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>> [snip]
>>>>> == DT loading ==
>>>>>
>>>>> Previously, boards used the FDT blob embedded into U-Boot (via
>>>>> OF_SEPARATE). However, most Qualcomm boards run U-Boot as a secondary
>>>>> bootloader, so we can instead rely on the first-stage bootloader to
>>>>> populate some useful FDT properties for us (notably the /memory node and
>>>>> KASLR seed) and fetch the DTB that it provides. Combined with the memory
>>>>> map changes above, this let's us entirely avoid configuring the memory
>>>>> map explicitly.
>>>>
>>>> Since with this change, we don't need to embed FDT blob in the u-boot
>>>> binary, so I was thinking if we really need to import DTs from Linux
>>>> for different platforms and then play a catchup game?

For now, yes. There are quite a few features which aren't handled by
U-Boot that it shouldn't need to handle (rpm/h resources for example).
Also the fixed-regulator / regulator-gpio binding differences.

I would definitely like to move towards supporting Linux DT directly,
but this approach gives us a nice middleground of minimising the U-Boot
specific DT parts.
>>>>
>>>> IMO, the build command would look like following if we import
>>>> pre-built FDT blob from Linux:
>>>>
>>>> - Build u-boot::
>>>>
>>>>        $ export CROSS_COMPILE=<aarch64 toolchain prefix>
>>>>        $ make qcom_defconfig
>>>>        $ make
>>>>
>>>> - gzip u-boot::
>>>>
>>>>        gzip u-boot-nodtb.bin
>>>>
>>>> - Append dtb to gzipped u-boot::
>>>>
>>>>         cat u-boot-nodtb.bin.gz
>>>> <linux-tree>/arch/arm64/boot/dts/qcom/your-board.dtb >
>>>> u-boot-nodtb.bin.gz-dtb
>>>>
>>>> This would avoid the maintenance burden to keep DT in sync with that
>>>> of Linux. And since DT bindings in Linux are backwards compatible, we
>>>> can say u-boot should work with DTB picked up from any Linux kernel
>>>> stable release.
>>>
>>> I guess one question I have is, are we being passed the device tree
>>> (since we're acting like the Linux Kernel)
>>
>> Yeah that is the case here, see patch #1 in this series regarding how
>> FDT address is being retrieved from previous stage bootloader (ABL on
>> sdm845 and qcs404 SoCs).
> 
> That's what I thought.
> 
>>> or knowing that we have the
>>> dtb attached to the end of us and making use of the old kernel appended
>>> dtb option? We're fine in for example the rpi_arm64 case of just being
>>> given a device tree from the previous stage and not needing one in-tree.
>>
>> That's good to know and we can replicate that for Qcom platforms which
>> are chainloaded and don't need an embedded DT.
> 
> So yes, moving these towards the direction of rpi_arm64 and specifically
> using imply OF_HAS_PRIOR_STAGE or select OF_HAS_PRIOR_STAGE (force that
> the dtb must be provided to us) sounds like the right direction to take
> these platforms.
> 

-- 
// Caleb (they/them)
