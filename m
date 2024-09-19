Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4C0CE8D7A
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 11:48:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83B4389010;
	Thu, 19 Sep 2024 13:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OO/LHXdy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F8E189121; Thu, 19 Sep 2024 13:48:23 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98CDF88966
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 13:48:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42cbc38a997so4846465e9.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 04:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726746501; x=1727351301; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=ZSsIjOjis4UkttuduGDRSu/+aflxa0o3q3jxRW8tw24=;
 b=OO/LHXdy0jwuVYdYdYXbroKa79BlXhf03Iw01xrX9Nx6gWweKXYyLq0/iJ7Vc5UBWM
 CIlYLjUxQ81MR/au6VFk1h1OsR1XEj6MNmIeYwjFcM6vend0kDuqqhPG7ZZ/1qTQuFB2
 McaYNnesCABHq25PmLotumKvnlLi2egiWQDLE4oqHbetf7aVqtNX5eI2RGoTHt+2Zw16
 4H/ec9g+fv30agBbnb6P6JZeUmY2uLf6TMRzvCSzCecQgt28iepYCT0l1TDEqHiVZ2lu
 EJN3bZ0Vfz9gfnPVI7W00nzdAdYR1BGWvajzWXy5wrAJXE69SNqcx2Hli2dEUFaYK49t
 XEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726746501; x=1727351301;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ZSsIjOjis4UkttuduGDRSu/+aflxa0o3q3jxRW8tw24=;
 b=uuYKzOqW9U3333zkhM3r5WBrYuIC1IgntcDEACFkUgO23Bl4M2Mg5yUDujByks8/7G
 +EiSghV6kCMaTdi50VeK0LGK5uenxyaqNhtv4fx3Zs6lyjotNZ7QLatbIIH/ZiPKQgB4
 Qx9a/7JR5K4+d4Kq139wxXYS0SCYwIIHLGIunVOf78x3U1DIoIls8+8Y0D5r49sK6llo
 vBjuQrH7iyKkJ6XkcAew9pgGduCG5b8zDPIkeI1xCfCOdFXmLnsKiZlY4Y2byWUR8mzv
 utBoa7S7y255ZVsXYnmc18yIFm+NWM2/YhTTkKVyNvmwVUZntBxzfMc4I2F1DYii2f0W
 UuFg==
X-Gm-Message-State: AOJu0Yx5g5o11yDdqGsbiVIiVVO1vZM+bPlm4qELW5DTPzY3AamzHeHB
 VvESygCrsZ9HcuK+TAOm8UPe0iDQUG6rt+gvlsOZhaH5D9LvuhiRmZbdkpIHpI4=
X-Google-Smtp-Source: AGHT+IFPS0P94McJbVvRRSkXbgzJlmRQFd3qMtznZvzmCWOEVr4XdsyN9bcBkQb5U59oByzgoHG1kQ==
X-Received: by 2002:a05:600c:3b28:b0:42c:b81b:c49c with SMTP id
 5b1f17b1804b1-42e74426c30mr16676475e9.10.1726746500990; 
 Thu, 19 Sep 2024 04:48:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8ea1:6137:3157:6e66?
 ([2a01:e0a:982:cbb0:8ea1:6137:3157:6e66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e71f06a4sm14766474f8f.23.2024.09.19.04.48.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2024 04:48:20 -0700 (PDT)
Message-ID: <e139808f-d75a-4a32-815c-0b29784ca290@linaro.org>
Date: Thu, 19 Sep 2024 13:48:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 00/13] ufs: enhancements to support Qualcomm UFS
 controllers
To: Neha Malcom Francis <n-francis@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>, bmeng.cn@gmail.com
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Bhupesh Sharma <bhupesh.linux@gmail.com>
References: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
 <bff9ce50-b5a6-45d8-9969-f116d91f75dd@linaro.org>
 <38f599a8-7094-4a04-8ff6-96fc8b9d168a@ti.com>
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
In-Reply-To: <38f599a8-7094-4a04-8ff6-96fc8b9d168a@ti.com>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 19/09/2024 10:56, Neha Malcom Francis wrote:
> Hi Neil
> 
> On 18/09/24 13:36, Neil Armstrong wrote:
>> Hi Marek, Manorit, Tom, Michal,
>>
>> On 10/09/2024 11:20, Neil Armstrong wrote:
>>> This serie regroups all the fixes and base enhancements required to
>>> support the Qualcomm UFS controllers in U-Boot.
>>>
>>> This syncs headers & defines from Linux, and includes 2 set of
>>> fixes that were sent separately:
>>> - ufs: core: remove link_startup_again logic
>>> - ufs: properly fix cache operations
>>>
>>> Without those 2 sets, UFS cannot initialize on Qualcomm controlers
>>> since v5, and a numerous of Cache issues makes any UFS controller
>>> fail to initialize.
>>>
>>> Since UFS core hasn't changed for a while, and since UFS is core
>>> technology for the Qualcomm SoCs, I volunteer maintaininig the
>>> UFS subsystem if Bhupesh & Neha Malcom Francis are ok with that.
>>
>> Could you run this serie on the r8a779f0_spider, j721s2_evm_a72, j721e_evm_a72,
>> j7200_evm_a72, amd_versal2_virt and qemu-riscv and check for possible regressions ?
>>
> 
> For the K3 platforms (j721s2, j721e, j7200, j784s4) I have already done a sanity test with this series on j784s4 with no regressions seen, so should be fine.

Ack, thanks for the report!

Neil

> 
>> It seems the only user of UFS_PCI is qemu-riscv, is there other users ?
>>
>> Thanks,
>> Neil
>>
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>> Bhupesh Sharma (5):
>>>        ufs/ufs.h: Add definition of 'ufshcd_rmwl()'
>>>        ufs: Clear UECPA once due to LINERESET has happened during LINK_STARTUP
>>>        ufs: Sync possible UFS Quirks with Linux UFS driver
>>>        ufs: Add missing memory barriers
>>>        ufs: Fix debug message in 'ufs_start'
>>>
>>> Marek Vasut (2):
>>>        ufs: Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS
>>>        ufs: Add UFSHCD_QUIRK_HIBERN_FASTAUTO
>>>
>>> Neil Armstrong (6):
>>>        ufs: allocate descriptors with size aligned with DMA_MINALIGN
>>>        ufs: fix dcache flush and invalidate range calculation
>>>        ufs: split flush and invalidate to only invalidate when required
>>>        ufs: use dcache helpers for scsi_cmd data and only invalidate if necessary
>>>        ufs: core: remove link_startup_again logic
>>>        MAINTAINERS: Add myself to the list of UFS maintainers
>>>
>>>   MAINTAINERS       |   1 +
>>>   drivers/ufs/ufs.c |  98 ++++++++++++++++++++--------------
>>>   drivers/ufs/ufs.h | 157 +++++++++++++++++++++++++++++++++++++++++++++++-------
>>>   3 files changed, 197 insertions(+), 59 deletions(-)
>>> ---
>>> base-commit: ca55cf8104c0dd78aae45fa66dd8400ef1b3d0ac
>>> change-id: 20240910-topic-ufs-enhancements-fe8ef9ce39d8
>>>
>>> Best regards,
>>
> 

