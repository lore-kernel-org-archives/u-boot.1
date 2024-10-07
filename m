Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2412CFB43F
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 12:15:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 689D1889E1;
	Mon,  7 Oct 2024 14:15:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dsuPGBPG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBB4A88B78; Mon,  7 Oct 2024 14:15:35 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D1D988663
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 14:15:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42cbc38a997so26866205e9.1
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 05:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728303333; x=1728908133; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=q5Xh85VeTWgyH5dbwyTj6B+PUtS1Xnmn8VhVU7dW9Xw=;
 b=dsuPGBPGu/W2zFUp9OmXYXkYqoB/qxengRP4IGvaF56hbupxTFf4ghaaUA3JBNMAZt
 Je40VNVULcchCoFbteRWopKasggP8065yaCc0N001Pjs9qr5edD9JvdNLsBQYZzgG/iV
 +5wXoTNVDGw1QzOZwX86kkpG3RyMiVuY0FnzIiffLOBIUMcuJw0Qtq8gXpd5RVsfKAkW
 zJBH0dQUC+30v9DCokVUcKea8uSZM+5Az9gsy6jl7YNSPBPRW1cRudN+JTzA0ADm7iEu
 wbSJuQ4LYDUaQUI253vqK3IbR9ZKKx8Mg4wzLSzK5rjkV0yoXg/OmHzGzPXZ5miHsiH1
 IobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728303333; x=1728908133;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=q5Xh85VeTWgyH5dbwyTj6B+PUtS1Xnmn8VhVU7dW9Xw=;
 b=ctnHioiSfAvwaVvVq249XCfyq3dJ2BBRGPj1taNTavcqRCfEU7xOlpRwigGRXV2aOt
 GCiK4yLMxlYRVnEdN6tQ4JJHKAN/UpTQvBYqxwM5hz+iQIoFlOgc36UDQ9cCux+3k8wI
 /6WywRAYHdpJ6LmPI6tUT2U1etZ6leWKBFxofP7FoguxY5+ClrIeprj8oB1U/txQVPKv
 QgQIUesjMrAtUbgIztD7fLCFyK7c3Cou0bac9PYGzwN0ckI5TEorfHUDCcQT525nIzjh
 GSdKRlKO0Xz8Bii6ea/RVHaZmk2GGxH/hztaDRqPdZBK+KRMwYrzy96msYP/t1SybsTk
 aDkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9+ZaZITND7aI1cGaDHYP/l3wiLsrCjax7fek0qQwP6GF+m8XXUPdP2X6Jsfb+mP5XkI9R4S8=@lists.denx.de
X-Gm-Message-State: AOJu0YxR2R7mm9lyOTZRcXSSnmzJl4UPQOOvzEmfJtt9Ue6dowIlvdk8
 tpgHWPAYLXmYISIxPmqcPdGncINjknrmmDABYqk8Vb94IrLURFeIIUG9lcBzBg8=
X-Google-Smtp-Source: AGHT+IHCmPKq/SQ+DRzrsDkUIyn7IIJesr/dzCvJAGLlrqDU3tjVcXqwyselAUcZ07ICNrhvlqptKg==
X-Received: by 2002:a7b:c5c3:0:b0:426:64c1:8388 with SMTP id
 5b1f17b1804b1-42f892fd471mr55805575e9.17.1728303332996; 
 Mon, 07 Oct 2024 05:15:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a99f:3c24:fa3b:1e7?
 ([2a01:e0a:982:cbb0:a99f:3c24:fa3b:1e7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1690f24fsm5622798f8f.1.2024.10.07.05.15.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 05:15:32 -0700 (PDT)
Message-ID: <f92b4033-b94d-4034-a93b-60b498bb644a@linaro.org>
Date: Mon, 7 Oct 2024 14:15:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 00/13] ufs: enhancements to support Qualcomm UFS
 controllers
To: Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, bmeng.cn@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20240930-topic-ufs-enhancements-v3-0-58234f84ab89@linaro.org>
 <9a25aaeb-98c1-4f21-8789-03582b8a4431@linaro.org>
 <41d7be2a-1411-4cea-949f-8e447bc83687@ti.com>
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
In-Reply-To: <41d7be2a-1411-4cea-949f-8e447bc83687@ti.com>
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

On 07/10/2024 10:17, Neha Malcom Francis wrote:
> Hi Neil
> 
> On 07/10/24 13:43, Neil Armstrong wrote:
>> Hi Bhupesh, Neha Malcom Francis,
>>
>> On 30/09/2024 14:44, Neil Armstrong wrote:
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
>>>
>>> It has been reported to show regressions on:
> 
> Both of the links are saying that there are "no regressions" seen.

Yes it's a typo, I was meaning "It has been reported to show no regressions on"

> 
>>> - TI K3 platforms (j721s2, j721e, j7200, j784s4) [1]
>>> - AMD platform (amd_versal2_virt_defconfig) [2]
>>>
>>> [1] https://lore.kernel.org/all/38f599a8-7094-4a04-8ff6-96fc8b9d168a@ti.com/
>>> [2] https://lore.kernel.org/all/SA1PR12MB869713CA620F99077B75EF0E98632@SA1PR12MB8697.namprd12.prod.outlook.com/
>>
>> Is it ok for me to apply the patches ?
>>
>> Thanks,
>> Neil
>>
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>> Changes in v3:
>>> - Fixup patch 9
>>> - Link to v2: https://lore.kernel.org/r/20240920-topic-ufs-enhancements-v2-0-65ae61e73eaa@linaro.org
>>>
>>> Changes in v2:
>>> - Added review and tested-by tags
>>> - Updated patch 12 message with more explanations
>>> - Synced patch 9 again with Linux 6.11
>>> - Updated patches 7, 8, 9 and 10 with informations about the origins of the changes
>>> - Link to v1: https://lore.kernel.org/r/20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org
>>>
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
>>>   drivers/ufs/ufs.c |  98 +++++++++++++++-----------
>>>   drivers/ufs/ufs.h | 203 ++++++++++++++++++++++++++++++++++++++++++++++++------
>>>   3 files changed, 241 insertions(+), 61 deletions(-)
>>> ---
>>> base-commit: ddbcafeb53e7093c58488596bfce6d8823777c3a
>>> change-id: 20240910-topic-ufs-enhancements-fe8ef9ce39d8
>>>
>>> Best regards,
>>
> 

