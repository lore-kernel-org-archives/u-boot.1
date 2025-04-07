Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E646C3601A
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 09:53:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FA9282D0C;
	Mon,  7 Apr 2025 11:53:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rW9UEcKr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F082882DB4; Mon,  7 Apr 2025 11:53:10 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11D0582D0C
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 11:53:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso21564475e9.3
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 02:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744019587; x=1744624387; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=lCwIbiaE7IsR1tDk9gUOnm1VJaXlh7sMUx6otoSu50A=;
 b=rW9UEcKrQb0fsZWGNoes+CFqlwFfvJgrJrBnZBzQTYKdH0qkS9xrg2NykZtK+vDKuu
 mfLxo1LrXEqWGqdeU80P1C7/LLPkA5EpR0Qb2o2ZPuaM6adQh+AQXms/TE6cOsaFk40J
 AP89Ei58ch6qEIjHaQVFIWd61piDP3zuG27bPJLA3ea7btirv7z8o4bRlP3NBE1SWQDg
 7EkHAFnlq1bcomTaLxjSOR76qweu9C8BkIkNoaOqZGIkV7sK4tLNA8Ouz+f/SAYqu7U4
 I7GElSp8mLvqcK2EHFGVNkfcLJJlsftAvyvu7zHbAQTcUuIaYxyYHH9ea0zU2MfGRk+M
 dfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744019587; x=1744624387;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lCwIbiaE7IsR1tDk9gUOnm1VJaXlh7sMUx6otoSu50A=;
 b=sDKqATizpaT+LLWFE2LktWWYuieAdMuYyUYxtBjkyqaPdB/jCEGyshH1OprWwFEwjJ
 6Y3A0996CeHmtNq2/IJSndPErTe9Fd6F+/TJHO8BMm/tSZZ1DMMTH6L2n8Gx5JeTE2HB
 Snf8ppolLzVabkrU2XdMUFdMh15RDE+PZ8BnGTPWc7j1EpudeU3ohcjed4fMhlI4lF8v
 UA/VU9dvmRCFrXFYD+L+0XOFL2+zDof0kUpYumk5lWBcWnWRQDQOJB6Rg78XB08EyRJa
 xsuhNmGY6cU3z++YnYowEtINfo5vwASPUiGr1u/OSL7KlK0TgE5m8S6qNkmbd9z9E2q4
 Z4Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfMW5uZkICZoviijv9mrpCyYXkQMLf5vgUu474tzeDGcmYyh/g6SQWZpMdWbRT7s5samUGbJo=@lists.denx.de
X-Gm-Message-State: AOJu0YwsJSqvwyGUyVE1pbM1OEM5QUazMluNoV7Y+qbSedp7ai8xiOeE
 DkmRJ+iRLyEmFaEBYpbaiVdB8DiNPssIcb/K35VJMql2WkYEx9eXlvJm+EdrFOQ=
X-Gm-Gg: ASbGnctlivK6oGAT9k/PM2/ZXRwYc7zQuHQ4nZM73YbQogFc980uxRSBpgBFf3HtI92
 nje0gRAZ7gSO6a6QvNU0irOEM3nf6bYk1WqYVs9fu6yhPsErzWKHqEfhSmO49OQK2CtqeFuK9sX
 cxObvwHONRoa6FPg0BfFIat8OpXjQZjny6LRawtzV6a5vPhKtE+i2wS8cqEZi5qRUWijSOZ+fTf
 ILJQSdKXahvDXqKgPolWdzIKUVwhSM3nkBvspXXI/RDF4+4HOxsayYvnlFWmiyUBcbwupyypZH9
 /etZoXqGNDslIhzkJT+Obvt28PH5JY/fMc+U9QsobiV9w8KVE0AW+giZAZvKIb17RQrDHal91wz
 HoGrk0oRmprgR68ipWSAD/g==
X-Google-Smtp-Source: AGHT+IG/nHIxrb5N5reMKiiVyAY/7vN6OjijV/Te8yVbXGxAnVWW+fCjxKMxBweyAYYnq9znYgFxFA==
X-Received: by 2002:a05:600c:4fd6:b0:43b:c5a3:2e1a with SMTP id
 5b1f17b1804b1-43ee0616f6fmr79207995e9.2.1744019587500; 
 Mon, 07 Apr 2025 02:53:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f2a4:b974:cba3:a605?
 ([2a01:e0a:3d9:2080:f2a4:b974:cba3:a605])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34a75fcsm123018555e9.11.2025.04.07.02.53.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 02:53:07 -0700 (PDT)
Message-ID: <629e3b50-1574-4d24-b638-da898873d1a6@linaro.org>
Date: Mon, 7 Apr 2025 11:53:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/7] mmc: msm_sdhci: handle bulk clock initialization error
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Cc: caleb.connolly@linaro.org, sumit.garg@kernel.org, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20250407081927.138915-1-jorge.ramirez@oss.qualcomm.com>
 <20250407081927.138915-4-jorge.ramirez@oss.qualcomm.com>
 <157becc8-34c2-48eb-a65e-55d312e9aa05@linaro.org>
 <6118b3c5-4bf4-4692-8353-bd9a02d5b2df@linaro.org> <Z/OdDPn3R7Rojbps@trex>
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
In-Reply-To: <Z/OdDPn3R7Rojbps@trex>
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

On 07/04/2025 11:38, Jorge Ramirez wrote:
> On 07/04/25 11:10:45, Neil Armstrong wrote:
>> On 07/04/2025 11:02, neil.armstrong@linaro.org wrote:
>>> On 07/04/2025 10:19, Jorge Ramirez-Ortiz wrote:
>>>> Some boards do not require all clocks to be available (i.e:
>>>> dragonboard820c).
>>>
>>> Can you specify which clock isn't available ? Because we have clk-stub for that
> 
> right, either GCC_SDCC2_AHB_CLK or RPM_SMD_XO_CLK_SRC (we have
> GCC_SDCC2_APPS_CLK which is the one I needed to initialize and work with
> MMC).
> 
>>
>> Enable:
>> CONFIG_CLK_STUB=y
>>
>> and change this:
>> diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
>> index 343fa5cd3fe..c14f5b6e1a6 100644
>> --- a/drivers/clk/clk-stub.c
>> +++ b/drivers/clk/clk-stub.c
>> @@ -14,7 +14,7 @@
>>   static const struct udevice_id nop_parent_ids[] = {
>>          { .compatible = "qcom,rpm-proc" },
>>          { .compatible = "qcom,glink-rpm" },
>> -       { .compatible = "qcom,rpm-sm6115" },
>> +       { .compatible = "qcom,glink-smd-rpm" },
>>          { }
>>   };
>>
>> And clk_get_bulk() should work!
> 
> ah cool. yes  that did work but something else popped up
> is it worth looking further into this?

Yeah look at clk_init_sdc(), it sets SDCC2_AHB & SDCC2_APPS, so you can change next patch to:

diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
index c77d69128b0..832cda332dc 100644
--- a/drivers/clk/qcom/clock-apq8096.c
+++ b/drivers/clk/qcom/clock-apq8096.c
@@ -83,7 +83,7 @@ static ulong apq8096_clk_set_rate(struct clk *clk, ulong rate)
         struct msm_clk_priv *priv = dev_get_priv(clk->dev);

         switch (clk->id) {
-       case GCC_SDCC1_APPS_CLK: /* SDC1 */
+       case GCC_SDCC2_AHB_CLK: /* SDC2 */
                 return clk_init_sdc(priv, rate);
                 break;
         case GCC_BLSP2_UART2_APPS_CLK: /*UART2*/


Neil

> 
> U-Boot 2025.04-rc5-00022-gccd064439bc2-dirty (Apr 07 2025 - 11:30:21 +0200)
> Qualcomm-DragonBoard 820C
> DRAM:  3.5 GiB (effective 3 GiB)
> Core:  140 devices, 18 uclasses, devicetree: board
> MMC:   Couldn't set MMC core clock rate: 0
> Couldn't set MMC core clock rate: 0
> mmc@74a4900 - probe failed: -22
> Couldn't set MMC core clock rate: 0
> Loading Environment from EXT4... Couldn't set MMC core clock rate: 0
> ** Bad device specification mmc 0 **
> In:    serial@75b0000
> Out:   serial@75b0000
> Err:   serial@75b0000
> Net:   No ethernet found.
> dragonboard820c =>
> 
>>
>> Neil
>>
>>>
>>> Thanks,
>>> Neil
>>>
>>>>
>>>> This change provides a fallback to the core clock when the bulk cant be
>>>> retrived.
>>>>
>>>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
>>>> ---
>>>>    drivers/mmc/msm_sdhci.c | 27 +++++++++++++++++++++++++--
>>>>    1 file changed, 25 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
>>>> index 27bb7052fca..8081330bd25 100644
>>>> --- a/drivers/mmc/msm_sdhci.c
>>>> +++ b/drivers/mmc/msm_sdhci.c
>>>> @@ -9,6 +9,7 @@
>>>>    #include <clk.h>
>>>>    #include <dm.h>
>>>> +#include <dm/devres.h>
>>>>    #include <malloc.h>
>>>>    #include <sdhci.h>
>>>>    #include <wait_bit.h>
>>>> @@ -56,6 +57,17 @@ struct msm_sdhc_variant_info {
>>>>    DECLARE_GLOBAL_DATA_PTR;
>>>> +static int get_core_clock(struct udevice *dev, struct clk_bulk *bulk)
>>>> +{
>>>> +    bulk->count = 1;
>>>> +
>>>> +    bulk->clks = devm_kcalloc(dev, 1, sizeof(struct clk), GFP_KERNEL);
>>>> +    if (!bulk->clks)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    return clk_get_by_name(dev, "core", &bulk->clks[0]);
>>>> +}
>>>> +
>>>>    static int msm_sdc_clk_init(struct udevice *dev)
>>>>    {
>>>>        struct msm_sdhc *prv = dev_get_priv(dev);
>>>> @@ -73,8 +85,15 @@ static int msm_sdc_clk_init(struct udevice *dev)
>>>>        ret = clk_get_bulk(dev, &prv->clks);
>>>>        if (ret) {
>>>> -        log_warning("Couldn't get mmc clocks: %d\n", ret);
>>>> -        return ret;
>>>> +        log_warning("Bulk clocks not available (%d), trying core clock\n", ret);
>>>> +
>>>> +        /* Sometimes not all clocks are needed - chainloading uboot */
>>>> +        ret = get_core_clock(dev, &prv->clks);
>>>> +        if (ret) {
>>>> +            log_warning("Core clock not available:(%d)\n", ret);
>>>> +            return ret;
>>>> +        }
>>>> +        n_clks = 1;
>>>>        }
>>>>        ret = clk_enable_bulk(&prv->clks);
>>>> @@ -83,6 +102,9 @@ static int msm_sdc_clk_init(struct udevice *dev)
>>>>            return ret;
>>>>        }
>>>> +    if (n_clks == 1)
>>>> +        goto set_rate;
>>>> +
>>>>        /* If clock-names is unspecified, then the first clock is the core clock */
>>>>        if (!ofnode_get_property(node, "clock-names", &n_clks)) {
>>>>            if (!clk_set_rate(&prv->clks.clks[0], clk_rate)) {
>>>> @@ -105,6 +127,7 @@ static int msm_sdc_clk_init(struct udevice *dev)
>>>>            return -EINVAL;
>>>>        }
>>>> +set_rate:
>>>>        /* The clock is already enabled by the clk_bulk above */
>>>>        clk_rate = clk_set_rate(&prv->clks.clks[i], clk_rate);
>>>>        /* If we get a rate of 0 then something has probably gone wrong. */
>>>
>>

