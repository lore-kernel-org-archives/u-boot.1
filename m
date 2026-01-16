Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9347D4A604
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 07:34:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6962D82BF2;
	Fri, 16 Jan 2026 08:34:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M3bjYM/L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F078830E4; Fri, 16 Jan 2026 08:34:38 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE13680077
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 08:34:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so1136841f8f.2
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 23:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768548875; x=1769153675; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=CEqTv0BdfL0PYtfneUYhrh1HQKE956SXDgNDwIECaBo=;
 b=M3bjYM/Lq08UeVHJ3vvrBUt1UHXxKIFyFeVqEEN8O188ptG3Z3UXI+tm79x6UqvBD2
 su8PlNhxum3xOSUGSUS4kGuVsf7YCC5jlQfaFtjdBeoB8RDJxqln87AbmZhHRJpxZFNL
 fDQhS93RCN8cJ6LbvJHLYM2a9Kc5cN2bGQBiHt6KxoUj9TnbeFXrCqmXdhir9yaqZkEB
 d/qoX0x1YgZdQazvE430pHeuH6Lo9IfKq3GtCsxLQHGBXNWNg+KJzMlFxpyxq+0xeOzs
 4GwYB6yl3JV/fuqiUfchsCG7i0dHtC7CMSNpQe60p6BMX4iGe9fw3mGsQPSj1wtXD2A5
 JjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768548875; x=1769153675;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CEqTv0BdfL0PYtfneUYhrh1HQKE956SXDgNDwIECaBo=;
 b=J0bUBPNzN23FTESGfwvrihQpnytKn/jdiPmn3X5m6N9cCskKDtFx9WleSNSRAMRCeD
 I2hQMM5SsI+UISath5YFhuCZmYWUazg5dzT/o6UHxUyyurGqXFWIOUqTUY/s4qJE9TpV
 hittUa/Q8azzfE2UaMaS++0LwMP+lbdje84yKPEc8V7aBEVWWtNLbZ36dRfNiaf2w3gf
 VES3cvYGhmGdjZDCpGzfkV1wLtNUNm7lBzhYxxGwed0IHF5UbXlnUTg9Wq+V/8aVHjff
 DYsgVDHJlhBzrH2+enU1avWzqop/LGplcZmm8cu6ELjkpX/i+X4embMqPxA7BXAto3Hb
 ZNhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe1Y7709gh+ZvOBvt1vLlvgFXGU/YvwlFtWyMad0W6rGTsMPMziD7USw6NI6pmD7Jji+lf2Bs=@lists.denx.de
X-Gm-Message-State: AOJu0YzsXslfwfjJeJTFLmD8zBMLGKY9649dONalmW55A83sRqSn69rw
 YsSVvEs8JufHfSsA+azQOHVb/0+8zLt+rIgJiqFVkP9dmNZTal4z3V1IeRjTmeiydGw=
X-Gm-Gg: AY/fxX7ftgpYH1skFtVHA7oSNfGs8MmT9SaY0wQXVK2OWryb1whd0V/bbsSAnZn32TA
 2Go6okWl2KBGWWVF0OH7fbke11Bre10cfAgJQnqWEKGIxEU4ZqQY7asajzsyfqNDGsot1AUoO6o
 CUuI3do9l2h1wVf6P6qxxqt38n2btxW8P6elXH7GS+x/yaOwHVZFyJrfqvg2qPg6aw+FNLMH0vq
 sv+RRQaXBAjg2OoYgKRPPnwcm3VUroVhPErwnaBQvDCGE+1cMMi1Z5bQPDQ1GMxnVp3WTovUg0I
 i0yZ06JyF+hY5DBSXXH1eszhmuAWmllyiayGJ0MCkpUkj5DwvRq13IkQKfTtdwmx3uNR1tUpbF9
 x3e8W2+kB9gziCd1z5swZ+CsBik3tKC/2pGSmWpEmjjuqw7Oh6DUOT+CHRbiVdBUopuRTecSbpH
 b39nISEcycifFnOsDCpfRksEK1Lh3CN0IBcC+pO2J9EObZ9i/Jb01Fif9rUnrIjOOpulC8xzggf
 g==
X-Received: by 2002:a05:6000:428a:b0:430:f23f:4bc5 with SMTP id
 ffacd0b85a97d-43569bc77a2mr2259960f8f.45.1768548875088; 
 Thu, 15 Jan 2026 23:34:35 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:d283:7a7e:4c57:678d?
 ([2a01:e0a:3d9:2080:d283:7a7e:4c57:678d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435699271dfsm3456426f8f.15.2026.01.15.23.34.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 23:34:34 -0800 (PST)
Message-ID: <dc3c2b6d-16fe-4a52-ba9b-35bfd268c5e2@linaro.org>
Date: Fri, 16 Jan 2026 08:34:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/2] configs: Add generic qcom_tfa_optee_defconfig
To: Sumit Garg <sumit.garg@kernel.org>
Cc: jens.wiklander@linaro.org, Casey Connolly <casey.connolly@linaro.org>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de, trini@konsulko.com,
 jorge.ramirez@oss.qualcomm.com, varadarajan.narayanan@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20251229114312.668068-2-sumit.garg@kernel.org>
 <c0bc6cab-6eee-40c2-b6f7-ff14d91906c5@linaro.org>
 <aWDgNIR4jcNcUZ6W@sumit-xelite>
 <c4cccc8f-639e-4806-992a-2e7c950c2c7b@linaro.org>
 <aWiE4LygCijxYOS2@sumit-xelite>
 <d2f7ed00-0c4f-4587-8dad-e1aaf1177204@linaro.org>
 <aWjc04IqdiZPR1e4@sumit-xelite>
 <1d162515-9bf3-4bf4-90fe-6d2cc37cacfc@linaro.org>
 <aWjrLF9DUPTaSA1c@sumit-xelite>
 <63eb28ff-7a52-4c60-a206-e79af508f112@linaro.org>
 <aWnhdIwtgqclaTVq@sumit-xelite>
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
In-Reply-To: <aWnhdIwtgqclaTVq@sumit-xelite>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 1/16/26 07:57, Sumit Garg wrote:
> On Thu, Jan 15, 2026 at 02:35:23PM +0100, Neil Armstrong wrote:
>> On 1/15/26 14:27, Sumit Garg wrote:
>>> On Thu, Jan 15, 2026 at 02:03:29PM +0100, Neil Armstrong wrote:
>>>> On 1/15/26 13:25, Sumit Garg wrote:
>>>>> + Jens (OP-TEE driver author in U-Boot)
>>>>>
>>>>> On Thu, Jan 15, 2026 at 11:49:49AM +0100, neil.armstrong@linaro.org wrote:
>>>>>> On 1/15/26 07:10, Sumit Garg wrote:
>>>>>>> On Wed, Jan 14, 2026 at 03:56:02PM +0100, Casey Connolly wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 09/01/2026 12:02, Sumit Garg wrote:
>>>>>>>>> On Thu, Jan 08, 2026 at 05:41:42PM +0100, Casey Connolly wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 29/12/2025 12:43, Sumit Garg wrote:
>>>>>>>>>>> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>>>>>>>>>>
>>>>>>>>>>> Recently upstream TF-A/OP-TEE has started gaining support for Qcom
>>>>>>>>>>> platforms. RB3Gen2 being the first one and more to come. U-Boot in
>>>>>>>>>>> corresponding boot flow is packaged as a position independent executable.
>>>>>>>>>>>
>>>>>>>>>>> So, lets add a generic U-Boot defconfig for Qcom platforms to support
>>>>>>>>>>> TF-A/OP-TEE based TrustZone stack. Build command:
>>>>>>>>>>>
>>>>>>>>>>> $ make qcom_tfa_optee_defconfig
>>>>>>>>>>> $ make -j`nproc` DEVICE_TREE=qcom/qcs6490-rb3gen2
>>>>>>>>>>
>>>>>>>>>> This would be better suited as a config fragment rather than a new
>>>>>>>>>> defconfig imo.
>>>>>>>>>
>>>>>>>>> That's fine with me to add it as a config fragment.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> But more importantly, enabling OPTEE support in U-Boot doesn't imply
>>>>>>>>>> that it will be used, just that it's supported.
>>>>>>>>>
>>>>>>>>> There are real use-cases of OP-TEE in U-Boot for Qcom platforms like
>>>>>>>>> secure EFI variables based on OP-TEE secure storage. Have a look here [1].
>>>>>>>>>
>>>>>>>>> And sure there will be more such use-cases like fTPM, KASLR etc. can be
>>>>>>>>> supported based on OP-TEE.
>>>>>>>>
>>>>>>>> I was referring literally to the fact that CONFIG_OPTEE being enabled
>>>>>>>> doesn't imply that OP-TEE is running, it's faulty logic to assume that's
>>>>>>>> the case and add nodes to the DT.
>>>>>>>
>>>>>>> I don't disagree here as having a runtime check is always a better
>>>>>>> choice then a compile time config option. However, there isn't a common
>>>>>>> info method from properietary firmware that says if QTEE is running
>>>>>>> instead of OP-TEE.
>>>>>>>
>>>>>>>>
>>>>>>>> I just checked and there is an SMC call that tells you the UUID for the
>>>>>>>> trusted OS, referred to as OPTEE_SMC_CALL_GET_OS_UUID in U-Boot and
>>>>>>>> OPTEE_ABI_CALL_GET_OS_UUID in OP-TEE. Presumably this identifies OP-TEE
>>>>>>>> specifically.
>>>>>>>
>>>>>>> Also, we don't know how the QTEE will react to this OP-TEE specific SMC
>>>>>>> call given it's different variants running on legacy and the newer SoCs.
>>>>>>> So I would suggest to better gate OP-TEE presence behind a compile time
>>>>>>> check only.
>>>>>>
>>>>>> So you say it's fine to add the optee node, and the driver will bail out if
>>>>>> OPTEE is not present, but it's not good to call OPTEE_SMC_CALL_GET_OS_UUID
>>>>>> in the fixup code to enable OPTEE only if present ?
>>>>>>
>>>>>> It's literally the same, my point in https://lore.kernel.org/all/b60d5ee7-fa27-4dc1-8a09-964912ec5654@linaro.org/
>>>>>> was exactly that, just call OPTEE_SMC_CALL_GET_OS_UUID and add the OPTEE
>>>>>> node only if present _AND_ if CONFIG_OPTEE is enabled.
>>>>>>
>>>>>> Move the CONFIG_OPTEE enable in a fragment and we're done, you will only
>>>>>> select OPTEE explicitly on desired platforms, and won't run the naughty
>>>>>> OPTEE_SMC_CALL_GET_OS_UUID on old crappy platforms.
>>>>>
>>>>> I am still trying to understand what benefit does invoking
>>>>> OPTEE_SMC_CALL_GET_OS_UUID from platform code provides us. Surely it
>>>>> can't be used to detect OP-TEE not present when QTEE is running due to
>>>>> unknown behaviour with QTEE.
>>>>
>>>> Sorry but what exactly do you expect that will happen if you enable the OPTEE
>>>> driver when running with QTEE ?
>>>
>>> The OP-TEE SMC calls are not at all supported with QTEE, so the expected
>>> behaviour is undefined. IOW, the OP-TEE SMC ABI is not compatible with
>>> QTEE. However, it's going to be hit and trial method to see what QTEE
>>> responds to OP-TEE SMC calls. So it's not a reliable source of
>>> information we can use to detect which TEE is present or not.
>>
>> So until we know, this change is a no go, we can't just add the /optee node
>> and hope the person building uboot did the right thing.
> 
> Not sure why you think Qualcomm platforms are special in this regards
> when similar OP-TEE node additions based on CONFIG_OPTEE exist for other
> platforms, see example here [1] [2] [3].
> 
> The OP-TEE configs will surely be part of a separate config fragment and
> I can add comments there for developer's awareness.
> 
> [1] arch/arm/dts/imx8mm-u-boot.dtsi:10
> [2] arch/arm/dts/imx8mn-u-boot.dtsi:10
> [3] arch/arm/dts/imx8mp-u-boot.dtsi:11
> 
>>
>> I propose an alternate way, is to check for QTEE and then test for OPTEE.
> 
> There are more combinations rather than just QTEE or OP-TEE as follows:
> - Older targets have support for QSEECOM
> - Newer targets with QTEE support
> - Chrome targets without any TEE support
> - IoT targets with OP-TEE support
> 
> Do you have any particular mechanism in mind for detecting OP-TEE
> presence at runtime? And surely that has to be well supported on variety
> of SoC where U-Boot is supported as of now.

OPTEE_SMC_CALL_GET_OS_UUID which works fine on like all the other ARM based
platforms.

It's the only way, and only Qualcomm engineers can answer how to determine
without any risk which TEE is running on the system.

Without this, all this discussions is pointless.

> 
> Also, there is added complexity for targets where the developer can't
> change the TZ firmware themselves on Qcom SoCs due to QTI signing
> requirement.
> 
> -Sumit
> 
>>
>> Neil
>>
>>>
>>> -Sumit
>>>
>>>>
>>>>>
>>>>> Jens,
>>>>>
>>>>> Will it be fine with you to expose is_optee_api() from the OP-TEE driver
>>>>> for the platform code to invoke it independently? Just for the sake of this
>>>>> discussion in case people still insist on it being the right thing to do.
>>>>>
>>>>> -Sumit
>>>>>
>>>>>>
>>>>>> Neil
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> My suggestion would be to make this SMC call if CONFIG_OPTEE is enabled
>>>>>>>> in qcom_psci_fixup(), compare the UUID and add the node if it matches.
>>>>>>>
>>>>>>> That's exactly the first SMC call that U-Boot and Linux OP-TEE driver
>>>>>>> does to compare the UUID here [1] and bail out of the driver. I don't
>>>>>>> see a value of a redundant invoke in the Qcom specific platform code.
>>>>>>>
>>>>>>> [1] drivers/tee/optee/core.c:823:   if (!is_optee_api(pdata->invoke_fn))
>>>>>>>
>>>>>>> -Sumit
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> [1] lib/efi_loader/efi_variable_tee.c
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> So I think the more appropriate patch here would be to just enable
>>>>>>>>>> OP-TEE in qcom_defconfig (assuming the binary size isn't significantly
>>>>>>>>>> affected).
>>>>>>>>>
>>>>>>>>> The OP-TEE driver in U-Boot itself is probed based on DT and it's not
>>>>>>>>> only specific to Qcom platforms but every other platform using OP-TEE.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Considering the other patch is based on this assumption that if OP-TEE
>>>>>>>>>> support is enabled then the board must be using it, a different approach
>>>>>>>>>> is definitely needed.
>>>>>>>>>
>>>>>>>>> Yeah that's true even with TF-A boot flow, there is possibility to boot
>>>>>>>>> without OP-TEE as well. However, TF-A generally doesn't provide a
>>>>>>>>> generic option to detect whether OP-TEE is running or not.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> When I was looking into this last year I remember discussing this same
>>>>>>>>>> issue from the Linux side, there is a good argument to be made that
>>>>>>>>>> OP-TEE support in Linux shouldn't be based on the devicetree -
>>>>>>>>>> particularly in the Qualcomm case where whether or not OP-TEE is used is
>>>>>>>>>> a simple software change, nothing to do with hardware.
>>>>>>>>>
>>>>>>>>> Sadly it's true for every other silicon vendor too. But OP-TEE support
>>>>>>>>> based on DT has become an ABI unless migration for OP-TEE support based
>>>>>>>>> on FF-A comes into picture.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> So in general I'm not particularly keen on this approach, I think it
>>>>>>>>>> /might/ be acceptable for U-Boot to have some fixup code to add the
>>>>>>>>>> OP-TEE node if OP-TEE is in use with the idea of phasing that out in
>>>>>>>>>> favour of runtime detection in the OS itself. I'd also expect that fixup
>>>>>>>>>> code to go in the generic U-Boot DT fixup code that runs before we jump
>>>>>>>>>> to the OS (like the EFI DT fixup function).
>>>>>>>>>
>>>>>>>>> The EFI DT fixup code is already there based on U-Boot DT. Have a look
>>>>>>>>> here:
>>>>>>>>>
>>>>>>>>> boot/image-fdt.c:627:   fdt_ret = optee_copy_fdt_nodes(blob);
>>>>>>>>>
>>>>>>>>> In general on Arm platforms there isn't any SMC bus to detect
>>>>>>>>> dynamically if there is support for OP-TEE or not. That's why
>>>>>>>>> platform bus was choosen for the U-Boot and Linux OP-TEE driver. It's
>>>>>>>>> similar to how we have the SCM DT node for Qcom platforms.
>>>>>>>>>
>>>>>>>>> FF-A bus tries to solve that problem to unify that approach for future
>>>>>>>>> platform but U-Boot hasn't yet gained support for FF-A based OP-TEE
>>>>>>>>> driver too.
>>>>>>>>>
>>>>>>>>> Anyhow, this is the sanest way I can come up with to enable OP-TEE
>>>>>>>>> support in a general way for all the Qcom platforms. This is aligned
>>>>>>>>> with how OP-TEE support is detected for other silicon vendors too.
>>>>>>>>>
>>>>>>>>> -Sumit
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Kind regards,
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> For more information refer here:
>>>>>>>>>>> https://trustedfirmware-a.readthedocs.io/en/latest/plat/qti/rb3gen2.html
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>>>>>>>>>> ---
>>>>>>>>>>>      configs/qcom_tfa_optee_defconfig | 7 +++++++
>>>>>>>>>>>      1 file changed, 7 insertions(+)
>>>>>>>>>>>      create mode 100644 configs/qcom_tfa_optee_defconfig
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/configs/qcom_tfa_optee_defconfig b/configs/qcom_tfa_optee_defconfig
>>>>>>>>>>> new file mode 100644
>>>>>>>>>>> index 00000000000..c398521770f
>>>>>>>>>>> --- /dev/null
>>>>>>>>>>> +++ b/configs/qcom_tfa_optee_defconfig
>>>>>>>>>>> @@ -0,0 +1,7 @@
>>>>>>>>>>> +# Configuration for building a generic U-Boot image
>>>>>>>>>>> +# with support for TF-A/OP-TEE based Arm TrustZone stack.
>>>>>>>>>>> +
>>>>>>>>>>> +#include "qcom_defconfig"
>>>>>>>>>>> +
>>>>>>>>>>> +CONFIG_TEE=y
>>>>>>>>>>> +CONFIG_OPTEE=y
>>>>>>>>>>
>>>>>>>>>> -- 
>>>>>>>>>> // Casey (she/her)
>>>>>>>>>>
>>>>>>>>
>>>>>>>> -- 
>>>>>>>> // Casey (she/her)
>>>>>>>>
>>>>>>
>>>>
>>

