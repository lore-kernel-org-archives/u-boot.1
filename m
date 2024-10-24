Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2A7CE8E7A
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 14:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BA6188FA4;
	Thu, 24 Oct 2024 16:16:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="elqvTw2w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05F5288FA4; Thu, 24 Oct 2024 16:16:41 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDB9B88F69
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 16:16:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43167ff0f91so10077525e9.1
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 07:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729779393; x=1730384193; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=W8A2FKgsw5oZYLlBC0PbvDy8QiRQ2Onc+qwkKpdkdJo=;
 b=elqvTw2w+IOgzpRD0qPg1w1llrB+Zw4R9NJenbascHXkhBxbpIw8s6Y+96INIPWCys
 r4HoekecG1o+y8hdnIM4I5XYJlmskzV/fCxvnzWw59St1TRUj53LaSvUJodWvEHwWcXw
 E0AJw5CLB3zqAfBfeSBdmzg0y1mLqk25JpItmiVnKkJ73gNgRb2mLVPwdUL7b54pGW28
 t3eLBzW4faMPfYwkksmxqVMeZt2Wel0+vtDbXgijBJlf5opJcPTQJ5gDE7ikLzK2fFoI
 5DVvgFhvVYr3fFVobDarpdPy45FQArEPtw2Dm77sjrzB0bn4XpU9PTUlU7cyruzpUwYb
 h5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729779393; x=1730384193;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=W8A2FKgsw5oZYLlBC0PbvDy8QiRQ2Onc+qwkKpdkdJo=;
 b=b3qqPkobVPmESBwVBvO2VQ7EPS93sAvrfk31OecpejlqGE3ONxsRa3UBRmcoeW3jie
 IehB9N5EWJBLC7hhMXL6/fBReM1j+pYXjKo5jUo6TgI1chHyw5tYfKdm/bQ9seiMg/r/
 E2UN5z4kOwuazBTUurqBYilxHoOLpfCdFkeYeDfdOx7d2S7V+yNo7NNnKSWMEf4vxpDZ
 +X3xZpNcAW1gJt5O1p7zjt90nmpchDhBQuD2FgtStik7NDbHOp/54aaaUUPfNlTv51Mh
 whGQNQmUBu/9kurVsgQ7O5MCwoA72UqRijrjcaL87tZXCbTnbZQNnM6PfxcVZbhOzQkS
 nlJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPD8yGX3U94hEcS7Ip3lSYE/Fwg2GM458pXBkSjarw2pu9MYhv2HzLouabOoWTJtZfTLlORPc=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+FhZpC1E9kRXMxesyV9KgCtRVwpelGXkStxBRhJagqMUtb3ww
 k3K8dptO3Fcc0s584N5CmbnR4QTw040v+FdN3KQ+y12s07nvnaPhJpqBceUhOS0=
X-Google-Smtp-Source: AGHT+IHNm15+I9ir02wHgkfuyWSiD1dmbHeBcYppP+RDAVz5n04HPq5akawsDtguOW4sZCWqDz+cOA==
X-Received: by 2002:a05:600c:46d0:b0:42c:b220:4778 with SMTP id
 5b1f17b1804b1-431841b2ce5mr45694725e9.33.1729779393384; 
 Thu, 24 Oct 2024 07:16:33 -0700 (PDT)
Received: from [192.168.1.70] (147.48.71.86.rev.sfr.net. [86.71.48.147])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43186bdeb4asm47777185e9.15.2024.10.24.07.16.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2024 07:16:32 -0700 (PDT)
Message-ID: <52e77e08-f122-4f7b-ba0f-b82e1a5911fb@linaro.org>
Date: Thu, 24 Oct 2024 16:16:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] mmc: msm_sdhci: enable vqmmc at probe if available
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20241016-topic-sm8x50-mmc-vqmmc-v1-1-767af5351d37@linaro.org>
 <cd028a77-c645-403b-9f2e-9ad2943ea146@linaro.org>
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
In-Reply-To: <cd028a77-c645-403b-9f2e-9ad2943ea146@linaro.org>
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

On 24/10/2024 15:11, Caleb Connolly wrote:
> Hi Neil,
> 
> On 16/10/2024 11:17, Neil Armstrong wrote:
>> On earlier platforms, the vqmmc regulator was enabled by the
>> previous bootloader, but on the newest (SM8650) it's not
>> and we need vqmmc to be enabled in order to have the card
>> to respond.
> 
> Isn't/shouldn't this be handled in mmc_power_init() ?

So, yes and no, the device_get_supply_regulator(vqmmc-supply) in mmc_power_init is
done to be used by sdhci_set_voltage() but .... but ... Qualcomm doesn't use
MMC_SIGNAL_VOLTAGE_330 but MMC_SIGNAL_VOLTAGE_300 which is implemented in Linux
but not in Uboot, so it would require a significant mmc/sdhci driver update
but since we 're not even far from supporting any card state requiring
MMC_SIGNAL_VOLTAGE_180 we don't even declare the sdhci_ops and neither
any of the config_dll/set_enhanced_strobe/execute_tuning so in our current
case we just need to enable vqmmc.

Neil
> 
> Kind regards,
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/mmc/msm_sdhci.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
>> index 4e5c932c071..27bb7052fca 100644
>> --- a/drivers/mmc/msm_sdhci.c
>> +++ b/drivers/mmc/msm_sdhci.c
>> @@ -15,6 +15,7 @@
>>   #include <asm/global_data.h>
>>   #include <asm/io.h>
>>   #include <linux/bitops.h>
>> +#include <power/regulator.h>
>>   /* Non-standard registers needed for SDHCI startup */
>>   #define SDCC_MCI_POWER   0x0
>> @@ -43,6 +44,7 @@ struct msm_sdhc {
>>       struct sdhci_host host;
>>       void *base;
>>       struct clk_bulk clks;
>> +    struct udevice *vqmmc;
>>   };
>>   struct msm_sdhc_variant_info {
>> @@ -163,6 +165,16 @@ static int msm_sdc_probe(struct udevice *dev)
>>       if (ret)
>>           return ret;
>> +    /* Get the vqmmc regulator and enable it if available */
>> +    device_get_supply_regulator(dev, "vqmmc-supply", &prv->vqmmc);
>> +    if (prv->vqmmc) {
>> +        ret = regulator_set_enable_if_allowed(prv->vqmmc, true);
>> +        if (ret) {
>> +            printf("Failed to enable the VQMMC regulator\n");
>> +            return ret;
>> +        }
>> +    }
>> +
>>       var_info = (void *)dev_get_driver_data(dev);
>>       if (!var_info->mci_removed) {
>>           ret = msm_sdc_mci_init(prv);
>>
>> ---
>> base-commit: d5cab0d6adc26ec1bbd45c2fed101184d04454ae
>> change-id: 20241016-topic-sm8x50-mmc-vqmmc-b7cf8176ec51
>>
>> Best regards,
> 

