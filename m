Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E30C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 16:36:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD70F86F26;
	Wed, 29 Nov 2023 17:36:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="u2MUedC+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5859287646; Wed, 29 Nov 2023 17:36:55 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DE4087008
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 17:36:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40b4d9e81deso17418405e9.0
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 08:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701275813; x=1701880613; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=u1ZqDmAIzP4yPq/fCbWgdIa8FjOpQtMXV5T0XYdllS8=;
 b=u2MUedC+KCa2yN4UiL0ytu2Q+zSKroYAGKOU/M/pSrsouwFlclmOw5l7vuknvkrYwo
 nSVRWoFdzkKXAYFjmcXCUCzoDzug4kn2nF0NjcHvTPUxI5uEkef6ptshU74UEdpwSZKj
 QES1Zo+1SZtfZ36Ky4aGzZywNwSU8NhBv/DIeZwL4lTHCWFgsJx14GU44vBl78ZVWph2
 wWjegj4r/zZsoSoAsVd/ZpboadPHIL4Wrm6m7B70RD6kQTnmeUQy2xxHdADpPVUVNWWu
 WAjjMpAyvnBnxKj1HPjpvIMe1u7A7b9b9+p7ueK1hglUqPDJ9R7vCB3wdutQDakf7Tj5
 +BQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701275813; x=1701880613;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=u1ZqDmAIzP4yPq/fCbWgdIa8FjOpQtMXV5T0XYdllS8=;
 b=C/bCOV4CLq1N9dT6jmRUMTtQOPCbwX75ku7Ir2XUBvVxK+6HA94GB5uHRpxoEJq3dL
 C5gcwe4uLC8BDALPP4Sv2sCWODA+OWoABWCJQ1vLLGsbQ4iqwe7cgCqJ/hLpkvhsoKo7
 ey+Lhu9rD626gG/s5LKFeKes6nK33Q8GGVeTsfj3rMFdjXsib6MWCYE/8YYR08RnXBM+
 Bvu8z1ep5esUTcyBWpIe4UTCRtlVH/rwJ7TmlEPjX6lRTahLEVrY6cYV+k4riAEJ2BEX
 7KPLRgUeXTXwVECclFiEc1kupzx8WE3GZB4fz+Qvi6vYgai8vhhIVok2LaV6EUHeRQ41
 I5+Q==
X-Gm-Message-State: AOJu0Yz28FMv2XGfAWmIXoCurMS2MWRY8EHK7WZCpy8EGmsZ3AIToTUX
 sy2h5LW0GJM1S9MMxx2UaxBlcA==
X-Google-Smtp-Source: AGHT+IFol9hbNqN+7qOcYdRaExdtNarwJKOnUGI33XGN5u0RVeKw3zwKPphTYz1igu+tsiDKnSWxJQ==
X-Received: by 2002:a05:600c:21c7:b0:40a:4c7e:6f37 with SMTP id
 x7-20020a05600c21c700b0040a4c7e6f37mr13555784wmj.20.1701275812612; 
 Wed, 29 Nov 2023 08:36:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:31d3:eea3:8f97:6a2c?
 ([2a01:e0a:982:cbb0:31d3:eea3:8f97:6a2c])
 by smtp.gmail.com with ESMTPSA id
 n40-20020a05600c3ba800b0040b34720206sm2774208wms.12.2023.11.29.08.36.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Nov 2023 08:36:52 -0800 (PST)
Message-ID: <260c6f67-17f7-4255-b759-12fe25024673@linaro.org>
Date: Wed, 29 Nov 2023 17:36:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
Content-Language: en-US, fr
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
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
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <22b2c2e2-9ce1-4a5f-8cda-565184eec120@linaro.org>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 29/11/2023 16:34, Caleb Connolly wrote:
> 
> 
> On 23/11/2023 07:04, Sumit Garg wrote:
>> On Wed, 22 Nov 2023 at 21:34, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>>
>>>
>>>
>>> On 22/11/2023 14:27, Tom Rini wrote:
>>>> On Wed, Nov 22, 2023 at 07:44:09PM +0530, Sumit Garg wrote:
>>>>> On Wed, 22 Nov 2023 at 19:31, Tom Rini <trini@konsulko.com> wrote:
>>>>>>
>>>>>> On Wed, Nov 22, 2023 at 11:51:29AM +0530, Sumit Garg wrote:
>>>>>>> Hi Caleb,
>>>>>>>
>>>>>>> On Tue, 21 Nov 2023 at 22:39, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>>>>> [snip]
>>>>>>>> == DT loading ==
>>>>>>>>
>>>>>>>> Previously, boards used the FDT blob embedded into U-Boot (via
>>>>>>>> OF_SEPARATE). However, most Qualcomm boards run U-Boot as a secondary
>>>>>>>> bootloader, so we can instead rely on the first-stage bootloader to
>>>>>>>> populate some useful FDT properties for us (notably the /memory node and
>>>>>>>> KASLR seed) and fetch the DTB that it provides. Combined with the memory
>>>>>>>> map changes above, this let's us entirely avoid configuring the memory
>>>>>>>> map explicitly.
>>>>>>>
>>>>>>> Since with this change, we don't need to embed FDT blob in the u-boot
>>>>>>> binary, so I was thinking if we really need to import DTs from Linux
>>>>>>> for different platforms and then play a catchup game?
>>>
>>> For now, yes.
>>
>> But why? Is there any value added by larger u-boot specific DT (most
>> of the nodes being unused by u-boot) than what currently u-boot
>> supports? The more important part is to get alignment with Linux DT
>> bindings. If you need to have memory/reserved-memory nodes in u-boot
>> DT for generalization purposes then you should import those particular
>> nodes only.
> 
> I've been thinking about and hacking on this for the last week or so,
> sorry for the delayed reply here.
> 
> The value is in preventing any of the existing bindings from regressing,
> and simplifying the bringup process for new platforms (just copy
> SoC/PMIC DTSI and write a minimal board DTS to enable the needed hardware).
>>
>>> There are quite a few features which aren't handled by
>>> U-Boot that it shouldn't need to handle (rpm/h resources for example).
>>> Also the fixed-regulator / regulator-gpio binding differences.
>>
>> IMO, we should fix them first and then use Linux DT as it is.
> 
> The biggest blocker here is USB, on sdm845 and the 4 new platforms I
> have working, I only support USB high speed, this requires removing the
> superspeed phy and adding a DTS property.
> 
> I tried using OF_BOARD_SETUP to make this changes during boot but this
> approach really isn't scalable (and I couldn't find a way to make it
> work anyway).
> 
>>
>>>
>>> I would definitely like to move towards supporting Linux DT directly,
>>> but this approach gives us a nice middleground of minimising the U-Boot
>>> specific DT parts.
>>
>> I don't see any real benefits here apart from the maintenance burden.
>> If it had been an actual Linux DT then that can be passed to Linux as
>> it is. However, the current modified import you are trying to do
>> doesn't solve that purpose as well.
> 
> Ensuring that we don't introduce non-standard bindings (by using Linux
> DTSI) is one benefit, simplifying new platform bringup is another.
> 
> The amount of work required to switch to upstream DT is too much to
> block this series on. We can work on improving the situation there once
> we have these Qualcomm improvements upstream and new boards added. I do
> admit that this is quite an awkward middle-ground, and I would not like
> it to last for too long.

I'm a real supporter of targeting support of unmodified (or very slighly)
Linux DT, having a reduced version of the Linux DT will be a pain at each
sync, and you'll need to do this manually.

Simply having to copy the Linux DT without any changes will make sure you
are in sync with Linux's bindings, and will help making sure you'll boot
unchanged Linux DTBs you get from previous loaders.

And in bonus, you'll be able to chain it to the next loader like EFI.

So I don't see why any work toward this goal is useless, and if an
intermediate step is needed, let's do it.

Neil

> 
>>
>> -Sumit
>>
>>>>>>>
>>>>>>> IMO, the build command would look like following if we import
>>>>>>> pre-built FDT blob from Linux:
>>>>>>>
>>>>>>> - Build u-boot::
>>>>>>>
>>>>>>>          $ export CROSS_COMPILE=<aarch64 toolchain prefix>
>>>>>>>          $ make qcom_defconfig
>>>>>>>          $ make
>>>>>>>
>>>>>>> - gzip u-boot::
>>>>>>>
>>>>>>>          gzip u-boot-nodtb.bin
>>>>>>>
>>>>>>> - Append dtb to gzipped u-boot::
>>>>>>>
>>>>>>>           cat u-boot-nodtb.bin.gz
>>>>>>> <linux-tree>/arch/arm64/boot/dts/qcom/your-board.dtb >
>>>>>>> u-boot-nodtb.bin.gz-dtb
>>>>>>>
>>>>>>> This would avoid the maintenance burden to keep DT in sync with that
>>>>>>> of Linux. And since DT bindings in Linux are backwards compatible, we
>>>>>>> can say u-boot should work with DTB picked up from any Linux kernel
>>>>>>> stable release.
>>>>>>
>>>>>> I guess one question I have is, are we being passed the device tree
>>>>>> (since we're acting like the Linux Kernel)
>>>>>
>>>>> Yeah that is the case here, see patch #1 in this series regarding how
>>>>> FDT address is being retrieved from previous stage bootloader (ABL on
>>>>> sdm845 and qcs404 SoCs).
>>>>
>>>> That's what I thought.
>>>>
>>>>>> or knowing that we have the
>>>>>> dtb attached to the end of us and making use of the old kernel appended
>>>>>> dtb option? We're fine in for example the rpi_arm64 case of just being
>>>>>> given a device tree from the previous stage and not needing one in-tree.
>>>>>
>>>>> That's good to know and we can replicate that for Qcom platforms which
>>>>> are chainloaded and don't need an embedded DT.
>>>>
>>>> So yes, moving these towards the direction of rpi_arm64 and specifically
>>>> using imply OF_HAS_PRIOR_STAGE or select OF_HAS_PRIOR_STAGE (force that
>>>> the dtb must be provided to us) sounds like the right direction to take
>>>> these platforms
>>>>
>>>
>>> --
>>> // Caleb (they/them)
> 

