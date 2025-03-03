Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958A8C282CD
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 15:18:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DD7E811DF;
	Mon,  3 Mar 2025 16:18:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PwkOEx7z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DC33811E0; Mon,  3 Mar 2025 16:18:42 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24D7A811B2
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 16:18:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso31438175e9.2
 for <u-boot@lists.denx.de>; Mon, 03 Mar 2025 07:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741015119; x=1741619919; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=XcWSby/NeSZ0yzAKlMOw7D7naJeI809BHBe6PACDOWM=;
 b=PwkOEx7zMisVkBLtE4cpl9G6LAu7Btid5n65ykE1cEAfkUWQ85pwswMAlVPeQgcGAz
 3QoZE2vPYrPHghSnf2Ygh7OUDisa9hnP/VWeIP+TadXZU/KYq5heo2rV9Pd/LosEzSGD
 D3E3zJhs5tbKazsWVJyCcGeE8dCcXsHYhD4SDoOeuttENmurYekzjxuQZnzxcDd1pW3o
 K7RtkNINVHe9aiVrpo8f6x3dEng91delg/aneQl4gntZBHZ0jrR7sErV/PLpNlOd4meC
 73eeQu1IdhALV0kR8nv5Pt/03n4FrbkxBGcIQbw4YR6b7CSQY26u0Eigh17mAEAEjkw+
 pBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741015119; x=1741619919;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XcWSby/NeSZ0yzAKlMOw7D7naJeI809BHBe6PACDOWM=;
 b=bA4Elb3Vk0n12F3ZsnHGTZVfZRNvju/hs8ENqrbm3AIOXXkZnQbinnH9jha3wCDMJZ
 eTQGK2ldk3QA2jsIaRsrXr7INAi/E9xYAFbWISnEUlcXmH2mF8uStkTjNd4JIeKCQaou
 JVQEzERriConNt4fYggJxWYGEGppMiH1pCiR7lyA6lwzVLEGXRG0siHwMXWRKbgkHtJ3
 H9tZpy4j4iXDU4e8unQp+gSqYNS4PKSqaluYKSW3/wDiFKV/5kajxOiA+GiK9E1wD7rm
 5qOkMNRik36j1BQ5RR8L4nHeMayqrzSj5gp0lu5v8NwOyHtkBdSH1UN3kY1uqoOFs5/Z
 zFAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF1LM7TMiodBQw3UCNlJKWVGlNgY/ZR/NcxP9AMKfovOqWbgQMwCK6FMOBD2FMoZhe8BaBBGk=@lists.denx.de
X-Gm-Message-State: AOJu0YzjfEsI/kcRluyeAhwmRozqas9IbgelfnUeSctQ+6+Hc6T4SHvx
 Zsvpcg3PYL/ABM4kMMoSoZpFhxwTEVK5msRUQiHvOaXimeEb1p3AMbubZgSKEVk=
X-Gm-Gg: ASbGncvg3t5QLg4s4jWKybePi2zEA6yKVqJNzNObk/6ojVtwTQ9mTkZJ5ZrGkTH5zY0
 BwKlPddlGBGqHbrPW4Zjpph0/kU6T/rmJzL94fPnpUP5LmMn8esQ+IXzLnAgE6RS1RBWkl38ENQ
 mcoIFkWT4GCW6xSFkzk9Y9lPy2RLjK05/YdvYj0PRTfXfz6tBIDDhPAb41kV1xbtk21iRSjCAa0
 TybOlt35iVu47DjNU7Tcbi0iacrvLpKi0mclR5tDdEfXyakLWQBnaD8BZ4vQcdJ9hQMXGSYsRaZ
 Rl+zqPzafomYMpW5IJVXYWmxmaBDkL7Fivi2D4OAlwVbw6PfknEn/BNiRQ5i9AlTTVMzzi6qHyW
 xSLyAAhQFkEhA5LMPDm6mSA==
X-Google-Smtp-Source: AGHT+IEiApjVhrB+YNYuRqmGAVY68RwZ9IJ9snffuqKSHKzQQbwDk4D9b0OoDl63yujHe0nZTu2JBQ==
X-Received: by 2002:a05:600c:1384:b0:439:9f42:8652 with SMTP id
 5b1f17b1804b1-43ba6704748mr125675505e9.17.1741015119127; 
 Mon, 03 Mar 2025 07:18:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:1c49:dea2:d749:5015?
 ([2a01:e0a:982:cbb0:1c49:dea2:d749:5015])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bc57529fasm25993745e9.31.2025.03.03.07.18.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 07:18:38 -0800 (PST)
Message-ID: <ccdc2594-76f9-44b2-ab39-da310eee69cd@linaro.org>
Date: Mon, 3 Mar 2025 16:18:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] pci: dw_common: Set INCREASE_REGION_SIZE flag based on
 limit address
To: Tom Rini <trini@konsulko.com>
Cc: caleb.connolly@linaro.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250206-topic-sm8x50-pcie-dw-atu-increase-region-size-v1-1-33088c62600c@linaro.org>
 <e2a0da0e-6246-42c7-85c9-84a2097cf09d@linaro.org>
 <20250228170845.GM2640854@bill-the-cat>
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
In-Reply-To: <20250228170845.GM2640854@bill-the-cat>
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

On 28/02/2025 18:08, Tom Rini wrote:
> On Fri, Feb 28, 2025 at 04:27:06PM +0100, Neil Armstrong wrote:
>> Hi,
>>
>> On 06/02/2025 09:49, Neil Armstrong wrote:
>>> Set the INCREASE_REGION_SIZE for the outbound iATU entry if it
>>> causes the 4GB range overflow in order to activate the extended
>>> limit address by means of an additional iATU CSR (upper limit
>>> address register).
>>>
>>> This is required to make PCIe host controller work on Qualcomm SoCs,
>>> namely the SM8550 and SM8650.
>>>
>>> Based on the Linux commit 777e7c3ab7303 that can be found at [1].
>>>
>>> [1] https://lore.kernel.org/all/20220624143428.8334-5-Sergey.Semin@baikalelectronics.ru/
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>>    drivers/pci/pcie_dw_common.c | 8 ++++++--
>>>    drivers/pci/pcie_dw_common.h | 2 ++
>>>    2 files changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/pcie_dw_common.c b/drivers/pci/pcie_dw_common.c
>>> index 78961271a8eef8e4b6991675ee9de2bb1968b8da..5322f6bdaee450470d7f706bb4b4097a368ec455 100644
>>> --- a/drivers/pci/pcie_dw_common.c
>>> +++ b/drivers/pci/pcie_dw_common.c
>>> @@ -78,8 +78,12 @@ int pcie_dw_prog_outbound_atu_unroll(struct pcie_dw *pci, int index,
>>>    				 lower_32_bits(pci_addr));
>>>    	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
>>>    				 upper_32_bits(pci_addr));
>>> -	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
>>> -				 type);
>>> +	if (upper_32_bits(cpu_addr + size - 1) > upper_32_bits(cpu_addr))
>>> +		dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
>>> +					 type | PCIE_ATU_INCREASE_REGION_SIZE);
>>> +	else
>>> +		dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
>>> +					 type);
>>>    	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
>>>    				 PCIE_ATU_ENABLE);
>>> diff --git a/drivers/pci/pcie_dw_common.h b/drivers/pci/pcie_dw_common.h
>>> index 8cb99a12ea1a5fd3687f980cc1ff99839d06dbc2..748945f95975e8251cdb92a670e8d5bc575d2847 100644
>>> --- a/drivers/pci/pcie_dw_common.h
>>> +++ b/drivers/pci/pcie_dw_common.h
>>> @@ -46,6 +46,8 @@
>>>    #define PCIE_ATU_DEV(x)			(((x) & 0x1f) << 19)
>>>    #define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
>>> +#define PCIE_ATU_INCREASE_REGION_SIZE    BIT(13)
>>> +
>>>    /* Register address builder */
>>>    #define PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(region)	((region) << 9)
>>>
>>> ---
>>> base-commit: b3c09eb36529fbb277bec17b35e638f42cb33683
>>> change-id: 20250206-topic-sm8x50-pcie-dw-atu-increase-region-size-878465356c54
>>>
>>> Best regards,
>>
>> Gentle ping, this change is required to make PCIe enumerate
>> on some the Qualcomm SoCs.
> 
> So I see this is config is use on:
> am65x_evm_a53 bananapi-cm4-cm4io bananapi-m2s cm3588-nas-rk3588
> coolpi-4b-rk3588s coolpi-cm5-evb-rk3588 coolpi-cm5-genbook-rk3588
> imx8mm_data_modul_edm_sbc imx8mm_venice imx8mp_beacon imx8mp_dhcom_pdk3
> imx8mp_venice iot2050 jaguar-rk3588 khadas-vim3_android_ab
> khadas-vim3_android khadas-vim3 khadas-vim3l_android_ab
> khadas-vim3l_android khadas-vim3l nanopc-t6-rk3588 nanopi-r3s-rk3566
> nanopi-r5c-rk3568 nanopi-r5s-rk3568 nanopi-r6c-rk3588s
> nanopi-r6s-rk3588s nova-rk3588s odroid-hc4 odroid-m1-rk3568
> odroid-m1s-rk3566 odroid-m2-rk3588s orangepi-3b-rk3566
> orangepi-5-plus-rk3588 orangepi-5-rk3588s phycore-imx8mm
> qnap-ts433-rk3568 quartz64-a-rk3566 quartz64-b-rk3566 quartzpro64-rk3588
> radxa-e25-rk3568 rock-3a-rk3568 rock-3b-rk3568 rock-3c-rk3566
> rock-5-itx-rk3588 rock-5c-rk3588s rock5b-rk3588 sifive_unmatched
> sige7-rk3588 soquartz-blade-rk3566 soquartz-cm4-rk3566
> soquartz-model-a-rk3566 tiger-rk3588 turing-rk1-rk3588 verdin-imx8mp
> 
> I see a few of those are also amlogic boards, did you sanity test there?
> 

Not yet, I'll have a test run.

Neil
