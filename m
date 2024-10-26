Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA37D10BED
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 22:48:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 700B588DE5;
	Sun, 27 Oct 2024 00:48:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nNAaXevt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6154E88E3C; Sun, 27 Oct 2024 00:48:57 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58F73889DA
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 00:48:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c96b2a10e1so4822106a12.2
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 15:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729982925; x=1730587725; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pveZg8hRGqZ4F4zVl9AuQKplER23meMz/jSzJBp7XvQ=;
 b=nNAaXevtQoeZpS6UQ+DZdRubB93G+IaRveMUvwQssKRWlE6Y1bISzNhRj1gUZgoaK9
 Bg6nJYNvuHpyLpj4BAaNlK5dlDUk1eDk09obons0BEi1+HGEJZz1hTW1LvcTMeHXHuwJ
 yWapwee2rKxA0gNKYqThGwbQhmHJJjyFVjUBt0dgz9bp7C1HaudvL9g1HPIC4UUnq7Tc
 8lfUpXqMK6uRQa6WM/E5gNQK3lv1mofnfkA2U6hhTGDCNdc1zGiB+QNfItzCkEK3nUrq
 I6VuoD7vgep64aKM52JJetEMt1Z7wKZTH4NRpVM/nTisedV0dHUy6oyvQ2gkVPslYypJ
 RV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729982925; x=1730587725;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pveZg8hRGqZ4F4zVl9AuQKplER23meMz/jSzJBp7XvQ=;
 b=wixsCXMqXfAGPq1/rXJfQ0aVURuplE1KRW/vzGI30OlamW/YuSBgS+8xpVMM86tDfy
 n5fm/Yv6Sul5NGNGj6Y78s/n3aMwMjaq+HSTRs2e/ZztBEqlI5HjFeOwkZfh0ZzVFZjp
 iz1XT97cAxWdVrIEb245knRahqKUdDWfdGrOZKuS4ascD+lDIdq14gk0P9d+No3y1LCu
 3lmMmtT3fIhNbX+Ufdbzr4PjS5gf+rsnbhJtLuG5IVy/kfR9AvdulYejoHDqrT5bR6l3
 2VawmT7jlghdIqlPpZs+OP/MOPDW/6MwxkfQVw2uWTf6Tk3LfiOm9rs2lMxEM2P/RdfN
 n09w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGZIH7czngYw2JOaNK7wwznDaOlMhdZYQxEf54fpiAjYqQ9LBLNhyfjHLZtZVtUnOVeeL6O9M=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3SOBiQypcnM9pJPZc2xxT6nRPMF26uNHIbU1fUcrpBR9lG3zt
 BJDZjjMTBuLFByqNm7SE1ysIj5s3RmKhhMi37YzRLh+e3qAEccscIZbzp5kMHfo=
X-Google-Smtp-Source: AGHT+IHs5Lat8bFWM3Cq/eBRVv/dL3V1qkIkwKT4L5CX7aVHQknaQNYsnm4fq0eyRcd7ScXqTk2gJg==
X-Received: by 2002:a17:906:6a1d:b0:a9a:18ee:5106 with SMTP id
 a640c23a62f3a-a9de61e95a5mr295681966b.65.1729982924649; 
 Sat, 26 Oct 2024 15:48:44 -0700 (PDT)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b1f29737fsm216509266b.113.2024.10.26.15.48.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Oct 2024 15:48:43 -0700 (PDT)
Message-ID: <ad794a0a-ef85-4d9b-9923-791a8f9958e7@linaro.org>
Date: Sun, 27 Oct 2024 00:48:42 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] mmc: msm_sdhci: enable vqmmc at probe if available
Content-Language: en-US
To: neil.armstrong@linaro.org, Sumit Garg <sumit.garg@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20241016-topic-sm8x50-mmc-vqmmc-v1-1-767af5351d37@linaro.org>
 <cd028a77-c645-403b-9f2e-9ad2943ea146@linaro.org>
 <52e77e08-f122-4f7b-ba0f-b82e1a5911fb@linaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <52e77e08-f122-4f7b-ba0f-b82e1a5911fb@linaro.org>
Content-Type: text/plain; charset=UTF-8
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 24/10/2024 16:16, Neil Armstrong wrote:
> On 24/10/2024 15:11, Caleb Connolly wrote:
>> Hi Neil,
>>
>> On 16/10/2024 11:17, Neil Armstrong wrote:
>>> On earlier platforms, the vqmmc regulator was enabled by the
>>> previous bootloader, but on the newest (SM8650) it's not
>>> and we need vqmmc to be enabled in order to have the card
>>> to respond.
>>
>> Isn't/shouldn't this be handled in mmc_power_init() ?
> 
> So, yes and no, the device_get_supply_regulator(vqmmc-supply) in
> mmc_power_init is
> done to be used by sdhci_set_voltage() but .... but ... Qualcomm doesn't
> use
> MMC_SIGNAL_VOLTAGE_330 but MMC_SIGNAL_VOLTAGE_300 which is implemented
> in Linux
> but not in Uboot, so it would require a significant mmc/sdhci driver update
> but since we 're not even far from supporting any card state requiring
> MMC_SIGNAL_VOLTAGE_180 we don't even declare the sdhci_ops and neither
> any of the config_dll/set_enhanced_strobe/execute_tuning so in our current
> case we just need to enable vqmmc.

Ahhh, welp this presumably explains a bunch of my sdcard woes ;( I
thought the generic code was handling this (and clearly did a bad job at
checking the regulators themselves)

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

Kind regards,
> 
> Neil
>>
>> Kind regards,
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>>   drivers/mmc/msm_sdhci.c | 12 ++++++++++++
>>>   1 file changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
>>> index 4e5c932c071..27bb7052fca 100644
>>> --- a/drivers/mmc/msm_sdhci.c
>>> +++ b/drivers/mmc/msm_sdhci.c
>>> @@ -15,6 +15,7 @@
>>>   #include <asm/global_data.h>
>>>   #include <asm/io.h>
>>>   #include <linux/bitops.h>
>>> +#include <power/regulator.h>
>>>   /* Non-standard registers needed for SDHCI startup */
>>>   #define SDCC_MCI_POWER   0x0
>>> @@ -43,6 +44,7 @@ struct msm_sdhc {
>>>       struct sdhci_host host;
>>>       void *base;
>>>       struct clk_bulk clks;
>>> +    struct udevice *vqmmc;
>>>   };
>>>   struct msm_sdhc_variant_info {
>>> @@ -163,6 +165,16 @@ static int msm_sdc_probe(struct udevice *dev)
>>>       if (ret)
>>>           return ret;
>>> +    /* Get the vqmmc regulator and enable it if available */
>>> +    device_get_supply_regulator(dev, "vqmmc-supply", &prv->vqmmc);
>>> +    if (prv->vqmmc) {
>>> +        ret = regulator_set_enable_if_allowed(prv->vqmmc, true);
>>> +        if (ret) {
>>> +            printf("Failed to enable the VQMMC regulator\n");
>>> +            return ret;
>>> +        }
>>> +    }
>>> +
>>>       var_info = (void *)dev_get_driver_data(dev);
>>>       if (!var_info->mci_removed) {
>>>           ret = msm_sdc_mci_init(prv);
>>>
>>> ---
>>> base-commit: d5cab0d6adc26ec1bbd45c2fed101184d04454ae
>>> change-id: 20241016-topic-sm8x50-mmc-vqmmc-b7cf8176ec51
>>>
>>> Best regards,
>>
> 

-- 
// Caleb (they/them)
