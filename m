Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87152C5AE59
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 17:48:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 172BF8091A;
	Thu,  5 Jun 2025 19:48:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Qs9t/aAH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2273481E25; Thu,  5 Jun 2025 19:48:36 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 857E3803DF
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 19:48:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-450cfb790f7so9954655e9.0
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 10:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749145713; x=1749750513; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=wBXazXCDbfujYYxUBnjAdBoxahdicgL+S4DbuaH678A=;
 b=Qs9t/aAHDbRavvdZ0PeAd4N7FD/JS0DuaOOynBpAEQ0abED6Zzu9j5UGB2U7DMO2qf
 WS4c5TwfI1Vk/JacAh12BL5kya4DwytmpuSwCSHffvpUu81l8soPTXSl4Ebg2FAH5tt/
 j43tV+j8sTIfXe/juyGhKT3CxseytV4mLJmtmmzw2XEfaZ7hXbDs4BlzyE+qWtl+deyl
 nLqeICzPPAhb4cSC/af7FtCT5rLZxRRC1G9pKnQJtbCz3UnJyby1PzBbsWMvQk30BHYV
 CkKsLnkZLVPeGGeXdmCUD8P3VeVZrHripoHbl/4e2OdWwE8bKAclCYuqIE7j/FO0Rf8a
 oflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749145713; x=1749750513;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wBXazXCDbfujYYxUBnjAdBoxahdicgL+S4DbuaH678A=;
 b=sv9BaKZ2fvToE1FnOc4zsivuCoYiM27Xi3Vi/sEaIPeHL+bmhFMPMb/y0DAmVE7vbV
 CPmse31wkdMSapR3ZMQc+8172Pwg8It5tiCTkAHma6H5PUImjkFp9Z0C/yIIVr/kGTHu
 gnHkbSlzQeoO/GkZ9v9Yd0AmxwfT6uhg+iHgU/2e6dUFi24gMbkwnyD3X6k5uSMM1xAu
 zd5f8lPzjFFDKJmMl6VqdKANvqDAYSKsKWUQh3bjvEsbYvJociejEWpEGZtoGKtuPYtz
 ksO+bHeKK4mPEVCaadZZWhfEldEMOaS+WoYIp9FOo8xLpXUnkYnc6rvTXa8MUsYCqXhf
 RAxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUO0DAcUILVW+utlEKfDlslPQyspRQybzcMbiv/ceF19JoIfIpgVKJjrJU4BdmHDEl2nt5k5c=@lists.denx.de
X-Gm-Message-State: AOJu0YxbxA2r1UpUArVa5tF0l04FAwtbp1AsqvQojkEJG1xjNpN/gtJG
 Z+xgCVHFIF9zaSZS1M863kS5T/JA+FehZDpvKX9mCBt2M5hlfWex0uIKUqF/LWC/lB8=
X-Gm-Gg: ASbGncsJ2hA3vNOu71lMxPCM0m3CDGrv1kg71/maD/tr/61XrxczDj5bDBcQy7lHb2J
 BxOWL7JXFC5s6El5Mgqn8yddKx9jxQ5iyJffaVNdrdNqEk0G4jp1dFbk7/VUluX5R2NrUrmBTgH
 yddQ7WkvRCLmIS+FDPjbHkRQzZZSKyguacJhi/xlIMm8ULIWp2WVLQzyXqMw7trGsZq4x/ZXi/O
 85An/eIAQJtJEDqC0s4KaWef+LenbHN2V5MZUYnwkkEi4fKuE2FmvPildTTnmA/zp7EJwhP5vsE
 3N3iduWpKsh9DWh2RUDzTEHICb3JO2KxQaVsbiMbw1NL+lLbuFl4wMn4I+4jTvxHMOnUmB3HMIT
 h4rHcoeFwOf6GbIRp4U4igAc9ldX+a1F6waTdpdI=
X-Google-Smtp-Source: AGHT+IFwNP0MuXPMYXFzImniVLTc/yQY4IPc58WMYquxxNDXIUtlXCh9WMaLghgoVUMw7qXnsL/I9A==
X-Received: by 2002:a05:600c:3e85:b0:43d:300f:fa1d with SMTP id
 5b1f17b1804b1-45201427814mr2848175e9.31.1749145712943; 
 Thu, 05 Jun 2025 10:48:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:a613:826b:6813:c968?
 ([2a01:e0a:3d9:2080:a613:826b:6813:c968])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45209bc6d6dsm253645e9.3.2025.06.05.10.48.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 10:48:32 -0700 (PDT)
Message-ID: <3d86cf5f-028c-4858-b292-5233b7194c60@linaro.org>
Date: Thu, 5 Jun 2025 19:48:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFT v4 3/3] fastboot: integrate block flashing back-end
To: Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Dmitrii Merkurev <dimorinny@google.com>
References: <20250522-topic-fastboot-blk-v4-0-af7f7f30564d@linaro.org>
 <20250522-topic-fastboot-blk-v4-3-af7f7f30564d@linaro.org>
 <20250522143958.GJ100073@bill-the-cat>
 <b83cfc3a-39e6-4710-a6ac-c24c878052cc@linaro.org>
 <20250605142126.GV1382132@bill-the-cat>
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
In-Reply-To: <20250605142126.GV1382132@bill-the-cat>
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

On 05/06/2025 16:21, Tom Rini wrote:
> On Thu, Jun 05, 2025 at 10:16:54AM +0200, Neil Armstrong wrote:
>> On 22/05/2025 16:39, Tom Rini wrote:
>>> On Thu, May 22, 2025 at 02:37:07PM +0200, Neil Armstrong wrote:
>>>
>>>> From: Dmitrii Merkurev <dimorinny@google.com>
>>>>
>>>> 1. Get partition info/size
>>>> 2. Erase partition
>>>> 3. Flash partition
>>>> 4. BCB
>>>>
>>>> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
>>>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>>> Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
>>>>    drivers/fastboot/Kconfig      | 29 +++++++++++++++++++++++++++++
>>>>    drivers/fastboot/Makefile     |  1 +
>>>>    drivers/fastboot/fb_command.c |  8 ++++++++
>>>>    drivers/fastboot/fb_common.c  | 22 ++++++++++++++++++----
>>>>    drivers/fastboot/fb_getvar.c  |  8 +++++++-
>>>>    5 files changed, 63 insertions(+), 5 deletions(-)
>>>
>>> I know this was posted before I replied with more feedback moments ago.
>>>
>>> [snip]
>>>> @@ -193,6 +197,31 @@ config FASTBOOT_MMC_USER_NAME
>>>>    	  defined here.
>>>>    	  The default target name for erasing EMMC_USER is "mmc0".
>>>> +config FASTBOOT_FLASH_BLOCK_INTERFACE_NAME
>>>> +	string "Define FASTBOOT block interface name"
>>>> +	depends on FASTBOOT_FLASH_BLOCK
>>>> +	default ""
>>>> +	help
>>>> +	  The fastboot "flash" and "erase" commands support operations
>>>> +	  on any Block device, this should specify the block device name
>>>> +	  like ide, scsi, usb, sata, nvme, virtio, blkmap, mtd...
>>>> +	  The mmc block device type can be used but most of the features
>>>> +	  available in the FASTBOOT_MMC will be missing.
>>>> +	  Consider using FASTBOOT_MMC on a MMC block device until all
>>>> +	  features are migrated.
>>>
>>> A default like "" in order to un-stick configs that are now here and
>>> enabling the option is wrong. If we're enabling new functionality for
>>> platforms, it needs to be configured correctly. This leads to building
>>> code on platforms that won't be used on the platform so we've likely
>>> added run-time bloat for no benefit.
>>
>> I agree but what's the solution ? I'll prefer having no default as it was initially.
> 
> No defaults is correct here, yes. It's just that the primary
> dependencies need to be fixed so that platforms don't get stuck on the
> prompt on features they won't actually use either.
> 
> Seeing what boards get stuck, and then having an idea on what
> dependencies trip them up is tricky. What I usually do in this
> situation, to see what platform is stuck on the prompt is:
> - In one terminal, fire off tools/qconfig -sC. Then wait for it to
>    seemingly be stuck with just one or two platforms left to finish
>    syncing.
> - In another terminal, 'ps uxwwww | grep make' to see what the build
>    directory of one of those stuck platforms is, then manually save off
>    the .config file, begin investigation.
> 
> That should provide what platform is asking this question and not having
> a reasonable answer. Then it's a matter of seeing if it makes sense for
> this platform to be here and so just needs to be migrated to this
> functionality or if it's here because of some dependency problem, for
> example what I was talking about in the previous part of this series.
> 

Ok I can't reproduce the crash with the last version, somehow v4 fixed it,
and the changes I did still work:
https://source.denx.de/u-boot/custodians/u-boot-ufs/-/pipelines/26523

Neil
