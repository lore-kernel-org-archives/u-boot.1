Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E514FC54756
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 07:52:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7507D8301E;
	Thu, 22 May 2025 09:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sHSm4gWe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7669982F67; Thu, 22 May 2025 09:52:35 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8EE183022
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 09:52:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a36c2d3104so2785284f8f.1
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 00:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747900351; x=1748505151; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=A+a4CMHzTOSx4MZp7FJY/npSjB4gdfwm4flDAZw/mh4=;
 b=sHSm4gWe+/CM77Rg/Gsbtnnysgqz/fdSNvxQnTPBw+vIKtIlaytrp1MKzWIPBKuOfU
 zZk8aeGuS0cVUXc13WqRl6UmpaUQUrm22Pok1Ndlbl3DoN4TybDhiFFyODQJGyIxvcG4
 Sqg7rxPcIxwtFfDkuBg1DODBulPlivn7+GC47hkfHgK9bwti/ohgpgubCZAzriSoHA7p
 n3SkIi9oX0H9e/p7x7VrSajq83MJTnfwk0nAefKpXjVm7UO7/3s2EXpUBhkaKZSQU0Fa
 QtFKj/A1GmFdCoHeeBW+2qWBGICuBlHSbFu6xauDdAq8c75gZXYlkUZxeajqm5VhyVxt
 JkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747900351; x=1748505151;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=A+a4CMHzTOSx4MZp7FJY/npSjB4gdfwm4flDAZw/mh4=;
 b=sQEFd/R+Irl57ltR01xtadHqlEcOHbbqRB9fZgbTCk2USfL0vFBlP0RF6iS01blklh
 VA4IEn0I7df0gP4Z6XS5hRsiDRFIczwNfRxUrRKKJkiAbbKyJexAusVJmrKDyPqVjBgq
 qgTf+FCMu92oZx5ZbNJUPCQWQya1CXAasB5lg9cYhGlWXMpGHTBEInO4oHnszCRTQNms
 SUMmI+a4N+aC/1M6KlA/HTKm3jrgztnamgyrrh7M635+PH4sbjXDuyOfuP5ZCQDgy43g
 oqyMgLkJWz6WNrFmS7bXVfB2zBhcI8kV44YDU8z76+UDpa0nmXD4t6kaBcYG30iDEB0T
 iaJw==
X-Gm-Message-State: AOJu0YwFQB4qCaef8UPyHTHCsI34NQHdCcC+OPb6AFoaztBSyyFdAi6x
 wDGJt9ZFO9ZMfbWKVwP+kvgC8Uu4O7vneWOJGyZxWqfGeBCrjVFShp9R8h0JYn8UA6M=
X-Gm-Gg: ASbGncsecFQdnAfAvVWJC5e6WfUL4SRWpp3ERYTs1E/GOqq2PXufO+5GCkmRo2mbgKH
 j/Xzmxusbym+zyrYCHiH0Wg8DvGICc237LODRqtwMZrcSaN29A0MMVhXtA3uBII9QIfN4Gd+FoL
 tsqesjLrnkBnKNwO4z6kO/o959Ht7ji7hYv0FNnH02ru3NRuYYC3WlWkNYBjOhOtjhYgj/Q2deC
 47dWSntE9yEJiNKs96dyvhWYRe+mIWuS0Q8uecJc0yTaIiv4XmtX8bMow38sLCs5lx+fvX8p4vR
 ZaXXDTyX2fbNFWRO23N27qlFjBvANKCy6FeH4Md30zxiUWDmcJN6UPLSnsdbbTCJcphFeJ0lPdt
 Y4sCzHOHcg+jKkRyluXsJY9MrYAM5
X-Google-Smtp-Source: AGHT+IFxXxVLZRwZJkAa7eWi5Cd+WX/PB3Mz1+il8FL1ZBmLrvoFjjta02PKloPRgDecn2P/ARhBhw==
X-Received: by 2002:a05:6000:178c:b0:3a3:671e:3b7c with SMTP id
 ffacd0b85a97d-3a3671e3c09mr17992048f8f.48.1747900351278; 
 Thu, 22 May 2025 00:52:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:ca6a:4d93:cd32:83a5?
 ([2a01:e0a:3d9:2080:ca6a:4d93:cd32:83a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca62961sm21863637f8f.49.2025.05.22.00.52.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 May 2025 00:52:30 -0700 (PDT)
Message-ID: <70222dab-ffc6-4065-9b11-234a63a9b738@linaro.org>
Date: Thu, 22 May 2025 09:52:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH RFT v3 0/3] fastboot: add support for generic block
 flashing
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Dmitrii Merkurev <dimorinny@google.com>
References: <20250506-topic-fastboot-blk-v3-0-d94be5829f46@linaro.org>
 <174774092427.332438.8643753165301653831.b4-ty@kernel.org>
 <87zff6nhmo.fsf@kernel.org> <20250521151236.GC100073@bill-the-cat>
 <87wma9okxy.fsf@kernel.org> <20250521190347.GF100073@bill-the-cat>
 <87a575gmid.fsf@kernel.org>
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
In-Reply-To: <87a575gmid.fsf@kernel.org>
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

On 22/05/2025 08:58, Mattijs Korpershoek wrote:
> Hi Tom,
> 
> On mer., mai 21, 2025 at 13:03, Tom Rini <trini@konsulko.com> wrote:
> 
>> On Wed, May 21, 2025 at 08:52:41PM +0200, Mattijs Korpershoek wrote:
>>> Hi Tom,
>>>
>>> On mer., mai 21, 2025 at 09:12, Tom Rini <trini@konsulko.com> wrote:
>>>
>>>> On Wed, May 21, 2025 at 04:49:35PM +0200, Mattijs Korpershoek wrote:
>>>>> Hi Neil,
>>>>>
>>>>> On mar., mai 20, 2025 at 13:35, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On Tue, 06 May 2025 18:10:06 +0200, neil.armstrong@linaro.org wrote:
>>>>>>> This serie permits using any block device as target
>>>>>>> for fastboot by moving the generic block logic into
>>>>>>> a common set of helpers and also use them as generic
>>>>>>> backend.
>>>>>>>
>>>>>>> The erase logic has been extended to support software
>>>>>>> erase since only 2 block drivers exposes the erase
>>>>>>> operation.
>>>>>>>
>>>>>>> [...]
>>>>>>
>>>>>> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)
>>>>>>
>>>>>> [1/3] fastboot: blk: introduce fastboot block flashing support
>>>>>>        https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/88239b5bb04bea2b58f7bf4c3ea72cf832de818c
>>>>>> [2/3] fastboot: blk: switch emmc to use the block helpers
>>>>>>        https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/25ab5c32c28b9f25fb193f726f239d75af3c365a
>>>>>> [3/3] fastboot: integrate block flashing back-end
>>>>>>        https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/a885bd8c969e25d03bf406207d89b1145c9490fb
>>>>>
>>>>> It seems this series cause CI to fail:
>>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/26238
>>>>>
>>>>> Without the patches applied, it passes:
>>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/26235
>>>>>
>>>>> Do you have any idea what is going wrong?
>>>>> I could not find anything obvious by skimming through the logs.
>>>>
>>>> It's a Kconfig problem then. Some platform is prompting for a value (not
>>>> a y/n) and there's no default.
>>>
>>> You are correct. Thank you for the suggestion.
>>>
>>> I've applied the following diff to 3/3:
>>> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
>>> index 68967abb751e..fdf34a6abe1e 100644
>>> --- a/drivers/fastboot/Kconfig
>>> +++ b/drivers/fastboot/Kconfig
>>> @@ -200,6 +200,7 @@ config FASTBOOT_MMC_USER_NAME
>>>   config FASTBOOT_FLASH_BLOCK_INTERFACE_NAME
>>>          string "Define FASTBOOT block interface name"
>>>          depends on FASTBOOT_FLASH_BLOCK
>>> +       default "none"
>>>          help
>>>            The fastboot "flash" and "erase" commands support operations
>>>            on any Block device, this should specify the block device name
>>
>> Assuming that the code will see "none" and handle the error correctly,
>> OK. But we really should have a configured true value here, yes?
> 
> The code does not handle any special cases.
> If FASTBOOT_FLASH_BLOCK_INTERFACE_NAME is "none", we will call:
> 
> blk_get_dev("none", 0);
> 
> Which will then be handled via:
> 
> 	if (!dev_desc) {
> 		fastboot_fail("no such device", response);
> 		return -ENODEV;
> 	}

It could be "" aswell ?

> 
>>
>>> @@ -212,6 +213,7 @@ config FASTBOOT_FLASH_BLOCK_INTERFACE_NAME
>>>   config FASTBOOT_FLASH_BLOCK_DEVICE_ID
>>>          int "Define FASTBOOT block device identifier"
>>>          depends on FASTBOOT_FLASH_BLOCK
>>> +       default 0
>>>          help
>>>            The fastboot "flash" and "erase" commands support operations
>>>            on any Block device, this should specify the block device
>>
>> I do not like this at first. If FASTBOOT_FLASH_BLOCK_DEVICE_ID is set,
>> there should be a valid ID set too yes? Potentially worse, is 0 a valid
>> option here? If so, is that likely to be a real and common one? In that
> 
> Yes, 0 is a valid option here. Think of this symbol as a similar one to
> FASTBOOT_FLASH_MMC_DEV however it's for generic block device type
> (virtio, scsi, ...)
> 
> I'd think that 0 is typically the most common value, since it's the
> first block controller of a specific type.

Yes 0 is a sentible value

> 
>> case, we should also be updating the help text to make sure it's clear
>> what the normal range is I think.
> 
> Ok. That's a bit too much for me to do in a fixup.
> 
> Neil, can you send a v4?


Sure

Thanks,
Neil

> 
>>
>> -- 
>> Tom

