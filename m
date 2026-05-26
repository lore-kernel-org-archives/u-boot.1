Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DB0CD5BB1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 15:02:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24FD6848A2;
	Tue, 26 May 2026 17:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YhLlLZTc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC4B7848B4; Tue, 26 May 2026 17:02:44 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CBF08484F
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 17:02:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43d75312379so9054396f8f.1
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 08:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779807762; x=1780412562; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=yWhYyQ/K/NVNWfJXBPyU8Ims8X4uoCyEdOWRaKz5MYY=;
 b=YhLlLZTcMefsWmVzgYhSIIbIEu5rwc/+6OpFXpDOSWDdGzvubgjEqGhQiwvuPONXFP
 bNni4F4hMx0QR7fbpajk/OsRDRznBGOa8OSJpn4tmcGfBa/mRI8Fa7u4pN9KQll1DAtO
 pw6o9DPKkO0BltXyQBH0J1sebIF2d+4Rl4YgxwNb5q1lMkk2lJnae+IK4v+2r4bZFt8d
 e2au5dcQ8lM9hccanxgopiY09JfsHcQ65zAP7iDR38J0lxU6lioitZ9FxH5SRzKZyW6h
 GZTfrwv/mm5UDpHb1nxcT53eZEPBDisTqpE+Nz/3tYRyAqgmQ+uq1jU/0tW6WpdvBT4B
 wuvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779807762; x=1780412562;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yWhYyQ/K/NVNWfJXBPyU8Ims8X4uoCyEdOWRaKz5MYY=;
 b=ViMV6pvc9wEnNE2478eqrKiu/3EwqN4872Z4PdGBnOEaFVWG5hsOP1aySlt74pZAy5
 yZ148x6psLItsbs3YJfF/+wpOVM4814kVIpTOJkWn2OoIwFOFcrXx+SNCfuAdNu413vg
 e3tR+Za5bRJdXMQalyWZlkIxNMr/DPpDKyW0gaYTBJpd8pTHnqEeYPq4eP5kfq2C/8gi
 cpCDUp7Fgm+ChC1uwmvb+Mr92ZGWzyJmcf5ZQpvp4oP3avuG8bEvrt+RAYXMp6lZMJXO
 fR4wyFPjfEgu4jpdtVDajnjHhdI2tdCCyF/4x1XhI3bZFMhMis2hLeig6v5NltqonOOI
 T8UA==
X-Gm-Message-State: AOJu0Yzyic+iZsEw8U4FBRtAHs2lzUI2IrtdbPkNGdspVUgRuZwDW9jc
 lalPpj7Eru0LpiJ3fm5ccLcylVZjVLluh5t4gB1IXK6JGYUXn7L3rdSRkKRNdfNzH+8=
X-Gm-Gg: Acq92OGbgmSGaKANL9KqkkojC8DxDQMRXWedku8awT70e3pzSlpnK2GvZfvH9wuxdzl
 vErE0TcRRBrFKKb8hyrcTlJ7oF98Ev4uzp5UqC35eThRh2ni9lbxxFZBlro4YchEMfrgbhCbXvn
 GuUkqFMegDNjsQCu9bu4yyS/ib3ipAHHPmi8ppYodtiucX2JFJQ8Fk5arWLDcX+MRtp6XntpowC
 5XLEIm9G0qVfB4jw93aSlqWMEBp6BvvSMFL2Fea0OcwvxipLNXR6geZelXLYxarVyQUyWvq21Kr
 bsQQl1rpaNkauadlTIGThXnus6iiWkFem3dwek8Czzh3Ze60V2/Jsz08F0yhun3fBGB8p/tc1Pj
 XdplxDXffUSYwz14iruF6kPAhOTn4cnRsTHY5/VXJnyzmzscM44+wIhA13CYvGno5EDRNowiGzk
 9dNOaeJTFD0dFAIrXRy4K971/VNXE6Q5UfaHHAUm6rqcX1PrymADlwT9IHCekPW1lGnbA4QTf6c
 nC3UUY=
X-Received: by 2002:a05:6000:2407:b0:44f:69f4:39b5 with SMTP id
 ffacd0b85a97d-45ea31e7930mr37675126f8f.29.1779807761490; 
 Tue, 26 May 2026 08:02:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:e83e:a0d0:39e4:2d25?
 ([2a01:e0a:106d:1080:e83e:a0d0:39e4:2d25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6cce0a4sm35784405f8f.12.2026.05.26.08.02.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 08:02:41 -0700 (PDT)
Message-ID: <bddb3c03-f306-4622-8e3f-119aa06a3fc5@linaro.org>
Date: Tue, 26 May 2026 17:02:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] board/qualcomm: use bootflow for default boot
To: Casey Connolly <casey.connolly@linaro.org>,
 "Ricardo de Araujo (Salveti)" <ricardo.salveti@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, sumit.garg@kernel.org
References: <20260514205759.3553253-1-ricardo.salveti@oss.qualcomm.com>
 <ae4eec1e-1c5b-42d3-a26f-3911b1a2839d@linaro.org>
 <CAA_5yov+8_G2FUQ-QrKBtykt_vwZPdU-KGEzzmguYBJsUveqeQ@mail.gmail.com>
 <e13fe55d-1f43-4c07-a92a-045b0db9cf38@linaro.org>
 <CAA_5yosVpB6L6yN8gBAnMmxV7uSNjvyKtxeBV7ELGF+z18aibw@mail.gmail.com>
 <7b61004a-6166-4566-869b-7157e5563ff3@linaro.org>
 <CAA_5yova4YXN5GssCtZ-dYd94K9Ms6yqkA7zZepbtK0OxsW-3A@mail.gmail.com>
 <504b47b9-c43d-408c-aaa9-4979e3b1b7b1@linaro.org>
 <CAA_5yosvLR7Dm90_xGVHeSiPQ4=uMpMpg2uoJrJJf9MO6C-vZg@mail.gmail.com>
 <138e5dcd-ba56-4806-b1c6-7d68114d0402@linaro.org>
Content-Language: en-US, fr
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
Organization: Linaro
In-Reply-To: <138e5dcd-ba56-4806-b1c6-7d68114d0402@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 5/26/26 16:33, Casey Connolly wrote:
> 
> 
> On 23/05/2026 01:53, Ricardo de Araujo (Salveti) wrote:
>> On Fri, May 22, 2026 at 10:10 AM Casey Connolly
>> <casey.connolly@linaro.org> wrote:
>>> On 21/05/2026 19:07, Ricardo de Araujo (Salveti) wrote:
>>>> On Thu, May 21, 2026 at 12:32 PM Casey Connolly
>>>> <casey.connolly@linaro.org> wrote:
>>>>> I'd also strongly recommend against bootflow, you can just chain
>>>>> commands together "bootefi bootmgr; bootm ..." to implement fallbacks.
>>>>
>>>> Would it be fine to change the patch to add bootflow after "bootefi
>>>> bootmgr" then?
>>>
>>> If anything I'd rather disable bootflow entirely by default. How do you
>>> actually load the FIT image to boot? Is it combined with extlinux?
>>
>> You can load with extlinux or via a boot script (often the preferred
>> option as you can add boot specific logic to it to support a/b
>> selection and so on).
>>
>>>>>> I agree that EFI is more suitable for generic distributions, but we
>>>>>> expect that some embedded products will leverage FIT directly, and
>>>>>> disable EFI entirely (e.g. faster boot, reduced complexity, etc).
>>>>>
>>>>> I'd expect those products to fork U-Boot already and/or send specific
>>>>> support for their board configuration upstream.
>>>>
>>>> They will probably all reuse qcom_defconfig, which uses
>>>> board/qualcomm/default.env, and that is why I wanted to have bootflow
>>>> available there by default.
>>>
>>> Do you have a list of boards? I don't think any of the Dragonwing boards
>>> use qcom_defconfig currently, maybe they #include it?
>>
>> Yeah, it is included directly at the moment:
>>
>> configs/qcm6490_defconfig:#include "qcom_defconfig"
>> configs/qcom_qcs8300_defconfig:#include "qcom_defconfig"
>> configs/qcom_qcs615_defconfig:#include "qcom_defconfig"
>> configs/qcom_qcs9100_defconfig:#include "qcom_defconfig"
>>
>>> they also will
>>> need CONFIG_QCOM_GENERATE_MBN once the MBN support is merged, so even if
>>> we can get it down to a single config for all of them (which would be
>>> awesome!) I don't think it should be qcom_defconfig. The need for
>>> supporting non-EFI boot methods is additional justification for that.
>>
>> The board level config can contain whatever that is specific for them
>> at that point (e.g. mbn header version), now the boot mechanics would
>> probably be more generic.
>>
>>>>>> Since FIT is already widely known and used in u-boot, I think it is
>>>>>> good to also support it by default here.
>>>>>
>>>>> Appeals to popularity go directly against the point from my last email,
>>>>> booting without EFI might be justified for your product but that doesn't
>>>>> mean the /reference/ Qualcomm env in upstream U-Boot should support it.
>>>>>
>>>>> The reference env upstream is there primarily for testing.
>>>>
>>>> I would say this is more a personal preference, my thinking was having
>>>> both enabled and available by default to facilitate the life of every
>>>> developer/user.
>>>
>>> The community devs over in the #u-boot-qcom IRC channel are also focused
>>> on EFI as far as I'm aware. To a large degree yes it's personal
>>> preference, when there are no technical reasons justifying a change then
>>> that's typically what it boils down to.
>>>
>>> I'm strongly in favour of having Qualcomms dev boards be well supported
>>> upstream to the point where there's no need to have a fork and users can
>>> just run upstream, I'm very glad that ya'll are working towards that
>>> goal. I'm also glad that there has been communication and discussion
>>> about how to architecture some parts of this so that it can land
>>> upstream and you don't have to make breaking changes later.
>>>
>>> I think part of what we're running up against here is that
>>> qcom_defconfig and the default environment don't really have a defined
>>> scope with regards to what platforms and configurations are supported.
>>> I'll share my thoughts here and maybe we can build on that?
>>>
>>> To me it should be a maximally compatible baseline *horizontally* that
>>> runs on as many platforms as possible with as many universal features as
>>> possible (e.g. capsule updates, fastboot, usb, networking...) while
>>> being minimally *deep*.
>>>
>>> So the image it creates requires different post-processing for every
>>> different platform/board (be that building an Android boot image or
>>> baking it into an MBN). The image can boot with EFI and gets you to a
>>> working system but it won't handle PXE boot or expose a UI that can be
>>> navigated with volume keys on a phone. It doesn't support every
>>> filesystem or have secureboot, and so on.
>>>
>>> If you want additional features to support a specific board or usecase
>>> more deeply (like emitting .mbn files directly, booting in a
>>> non-standard way, storing the u-boot env on a partition) then you have
>>> to make some changes to the build configuration.
>>>
>>> Attempting to enable/use bootflow in the most generic qcom_defconfig
>>> might improve things for the platforms/configurations you care about but
>>> it's also a level of vertical integration that does have an impact on
>>> other platforms that use the same configuration.
>>>
>>> To pick an arbitrary example, bootflow has an "Android" boot method,
>>> it's quite possible that on some dev boards or phones U-Boot might then
>>> attempt to boot Android from one of the boot partitions, this could
>>> result in the device booting to a broken state, infinitely booting
>>> U-Boot (if it's chainloaded), crashing, crashlooping, maybe U-Boot tries
>>> to update the slot status and touches something on the misc partition
>>> that makes ABL crashloop and potentially hard bricks a phone (since many
>>> vendors don't provide signed firehose or even a way to access EDL) so
>>> someones perfectly fine device becomes landfill.
>>
>> While that is possible, it depends on the boot methods that are
>> enabled by default in the config, and from my perspective it is ok to
>> assume that it should try all the boot methods which are enabled.
>> Currently we do have several methods enabled (by default), but they
>> are not leveraged by the default boot command and environment.
>>
>> The methods I have with standard qcm6490_defconfig:
>>
>>    - CONFIG_BOOTMETH_EXTLINUX=y
>>    - CONFIG_BOOTMETH_SCRIPT=y
>>    - CONFIG_BOOTMETH_EFILOADER=y
>>    - CONFIG_BOOTMETH_EFI_BOOTMGR=y
>>    - CONFIG_BOOTMETH_EXTLINUX_PXE=y
>>
>> So if we enable bootflow by default (could as well be the second
>> option after trying efi boot), the behavior will depend on the methods
>> that are enabled, and we can disable options that are not necessarily
>> known to work.
>>
>>> I don't know how likely any of those outcomes are, but given how
>>> crash-heavy all of the non-EFI boot paths are I'd really rather not
>>> tempt fate.
>>>
>>> Hence, I'd feel much more comfortable if we all worked to minimise
>>> unnecessary scope, having board/usecase specific configurations is
>>> absolutely the best way to do that and as a bonus make it much easier to
>>> justify a lot of quality of life improvements that only make sense in
>>> specific cases.
>>>
>>> That's why I would much rather see a dragonwing defconfig and default
>>> environment where we don't have to worry about some change breaking
>>> someone else with a completely different setup.
>>
>> Having a dedicated default configuration for dragonwind should be
>> perfectly fine (and included by the dragonwing targets by default), as
>> we can probably assume that u-boot would be supported natively instead
>> of chainloaded.
>>
>> If you are OK with that I can send another set to create a specific
>> dragonwind configuration file that could support a wider range of use
>> cases by default.
> 
> I think that would be the best way to go here. It technically isn't
> necessary to set CONFIG_TEXT_BASE once my tooling rework is merged since
> U-Boot is PIE and mkmbn sets the appropriate load address. So you could
> have a single qcom_dragonwing_defconfig and just pass DEVICE_TREE=... to
> make. Maybe that level of commonisation can come later though.
> 
> I'd propose adding a qcom-dragonwing.config fragment in the configs/ dir
> and having the boards all #include it.
> 
> To clarify the boot methods situation, could you explicitly unset
> BOOTSTD and bootflow/bootmeth and enable them in the dragonwing
> fragment, then you can add a dragonwing.env and I think that neatly
> makes space for all of the dragonwing specific functionality you want.
> 
> That all being said, I would still very much prefer you avoid standard
> boot or at least try to keep the scope small, but I understand it seems
> to be the best way to support extlinux/FIT and I don't want to block
> that (though I do still question the merits over just sticking with EFI).
> 
> You should also update board/qualcomm/MAINTAINERS, maybe merge all the
> dragonwing stuff together, add "N: dragonwing" and list a few folks who
> are active on the list and willing to maintain this support going forwards.
> 
> I'd like to get Neil's input on this but barring any issues on his side
> I think this is the right way to go.

Yeah I agree this is the best way to go

> 
> Thanks for taking the time to discuss this and find a good middleground
> to move forwards.
> 
>>
>> Thanks,
>>
>> Ricardo
> 

