Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F80CE8D5D
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 07:52:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C23388E11;
	Thu, 19 Sep 2024 09:52:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xmBglDpy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82F2C88B3F; Thu, 19 Sep 2024 09:52:27 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D04688E11
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 09:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42ca4e0299eso3873355e9.2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 00:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726732345; x=1727337145; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=jCa55kB5rDZrUc85f2jIuWE1tItir3FZ4KrxlHO+ovs=;
 b=xmBglDpyo2WtDlDG16qsQAoBvWXCqQZ/WtN3JMf64YLh+dm5LkaBrNT9s+ctuEVrkY
 WzTADReonJ5M9TxYFCrJ1yZUk+T6d7d1WK8znnm0pFTpOOy4nAa+gleCEAhtPIFqEeoT
 ZDVzIVRu/MGTuR6EHOcSgiZpDcZScFZbfRBpyYU5pJ6ilTeRShwqk4uutgM/aZXF4pTe
 C8UA7Y+5MIyIjuoJ+98SIxd5TKtkGI6WnTH9Os+koZEf/tCui0FUOHhevLW62mziKw4e
 lSatjWGce2HE8nMeS5JPxm0cFGk5Q2b+Q8dWduc7EScBVTRy6BM5qADFK3mCNdeDfDbO
 IonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726732345; x=1727337145;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jCa55kB5rDZrUc85f2jIuWE1tItir3FZ4KrxlHO+ovs=;
 b=hhvjptiRnoE3z6QVeOtNwn/midDCszREuak54mvNoc+tzsxwMnm+iwiJ3RwmRScHG8
 F+Pjr5nroDGTPYUTET76dlrn42rO6eVN5u3yjvBLX8X08tk0hixN+eue/WFwlbR4FFx3
 AnOmMM2kTh5qxmxIyP69JOdioTOZdjOQMkXv3xPkxolqocJziFniOOzUUaCmVkOUYgMW
 cGTe4bTQL+rTBHSpRDxWkgCbEA5sp8adK/4sufE6PBKO09xKWdLyBSC6fjc6UMuujQJd
 qgHsp8LU3RjBoxTSlNbXy0CggALi1A5yaWV7gPAsz7R/eyKF5MCRbcQLfiXQafTMZjdN
 PBXw==
X-Gm-Message-State: AOJu0YxDVacZRZ8AGghcnuMVEdgSXP5I3lP9fnM4e86Q4NjNaxUeOtdB
 P+QOQez5e9Pk44+hvv9ZURuFPQW9/htEIZNHlOlz1zo7o16NEVpTHjvn6o7hLN6LoTQy5f2OO+8
 7
X-Google-Smtp-Source: AGHT+IH1IVQsKslZ0ARH/tgwUzxatNdW6pNyqZhx1UZSMMZRdVK/Lah3kARkBmkl6mOL+qgWHUzc4Q==
X-Received: by 2002:a05:600c:1550:b0:42c:a8cb:6a96 with SMTP id
 5b1f17b1804b1-42cdb5721eamr167963425e9.31.1726732344743; 
 Thu, 19 Sep 2024 00:52:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8ea1:6137:3157:6e66?
 ([2a01:e0a:982:cbb0:8ea1:6137:3157:6e66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7543f3f4sm14820945e9.16.2024.09.19.00.52.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2024 00:52:23 -0700 (PDT)
Message-ID: <7b71a9fe-946a-4b1a-bdc8-76050e1d8954@linaro.org>
Date: Thu, 19 Sep 2024 09:52:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 00/13] ufs: enhancements to support Qualcomm UFS
 controllers
To: Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Tom Rini <trini@konsulko.com>, bmeng.cn@gmail.com,
 "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Bhupesh Sharma <bhupesh.linux@gmail.com>
References: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
 <bff9ce50-b5a6-45d8-9969-f116d91f75dd@linaro.org>
 <49932fef-c37a-4736-a2ac-829d5c39081d@amd.com>
 <79c51777-fbe0-4a02-9f81-bd468740ac6b@linaro.org>
 <69b3b92d-b263-40b1-8d39-66a5fb445015@amd.com>
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
In-Reply-To: <69b3b92d-b263-40b1-8d39-66a5fb445015@amd.com>
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

On 18/09/2024 12:47, Michal Simek wrote:
> 
> 
> On 9/18/24 12:40, neil.armstrong@linaro.org wrote:
>> Hi,
>>
>> On 18/09/2024 11:03, Michal Simek wrote:
>>> Hi Neil,
>>>
>>> On 9/18/24 10:06, Neil Armstrong wrote:
>>>> Hi Marek, Manorit, Tom, Michal,
>>>>
>>>> On 10/09/2024 11:20, Neil Armstrong wrote:
>>>>> This serie regroups all the fixes and base enhancements required to
>>>>> support the Qualcomm UFS controllers in U-Boot.
>>>>>
>>>>> This syncs headers & defines from Linux, and includes 2 set of
>>>>> fixes that were sent separately:
>>>>> - ufs: core: remove link_startup_again logic
>>>>> - ufs: properly fix cache operations
>>>>>
>>>>> Without those 2 sets, UFS cannot initialize on Qualcomm controlers
>>>>> since v5, and a numerous of Cache issues makes any UFS controller
>>>>> fail to initialize.
>>>>>
>>>>> Since UFS core hasn't changed for a while, and since UFS is core
>>>>> technology for the Qualcomm SoCs, I volunteer maintaininig the
>>>>> UFS subsystem if Bhupesh & Neha Malcom Francis are ok with that.
>>>>
>>>> Could you run this serie on the r8a779f0_spider, j721s2_evm_a72, j721e_evm_a72,
>>>> j7200_evm_a72, amd_versal2_virt and qemu-riscv and check for possible regressions ?
>>>>
>>>> It seems the only user of UFS_PCI is qemu-riscv, is there other users ?
>>>
>>>
>>> Good timing. We are close to send some updates to UFS which we require to get DWC version to work inside U-Boot.
>>>
>>> How far are that core changes from Linux? I see 9/13 is sync with Linux but when this is done you should also say which Linux version was used for sync.
>>
>> I think we are still quite far from Linux, we just took the basic required bits and pieces
>> to at least make the Qcom UFS controller driver build work, but Linux driver is overly complicated
>> with power management code we do not really need in U-Boot, so it's quite hard to sync honestly.
>>
>> But the plan is to align as much as possible once we get the basic Qcom UFS mainline.
> 
> That's understandable. But even when you say sync with Linux for some headers, etc it is good to say that it is sync with 6.11 for example.

Oh yes exact, I forgot to add this info, I planned to... I'll fix this in a v2.

Thanks,
Neil

> 
> Thanks,
> Michal
> 

