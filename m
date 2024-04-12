Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0C8C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 08:36:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7780E87FC8;
	Fri, 12 Apr 2024 10:36:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g9JR8fmB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC2D88801E; Fri, 12 Apr 2024 10:36:03 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2C3B87FC8
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 10:36:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3454fbdd88aso525770f8f.3
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 01:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712910961; x=1713515761; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=LwkIp+HrfA2jpjLLt5coiUxDUI1Z0JldRHwAv6tmQzI=;
 b=g9JR8fmBI5Qyt9dpYKVpopaMtxm88vB1bJu2L31hoO1ve2gBNnxJOZG18r2lRZI2jy
 4tb/Xwdbck5/cjQnv8m2IjvsId+OshGhEnSk90f+9ucuBCXHCVCkbcVlKL9l1did61bs
 Z+bNxZOrGIt0fCMO2XCkVdK/BGgaka5y5ByYTzi3JXTPHAUFYB2Sui2XY0xXzPG8T43G
 DUGq21QPXfoy96XWu7jV0HT/jRXfwn9lFf/86NScU8bjoYHtqdOF35IdRPi+a0EAl1L8
 dIASF6yyexFcnvAxC0v7z5aPAF+d90ZwsdNSC1MRhucF6FmpuuYaQnm/63RJKE3yu5h/
 h6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712910961; x=1713515761;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LwkIp+HrfA2jpjLLt5coiUxDUI1Z0JldRHwAv6tmQzI=;
 b=OYoMxjfm9oaolAk1E6ptpMZUhd7oPe3QYMl79Bx00PTrpgChN2dg8URPOQtDQrIEi+
 ZBdfS219egXVT3tc3K9QdIBXcN75Y0hKLKv7yTGoDyFETy0z2BX7ZIRapCPaISO4Nu2n
 /fVee8OyY+zMJ1Ov3UThTrMsNH29WxQSmgZExLTkvXiEYBtfexo4xCrWxn7MjV8Oz9SZ
 cXUjAZQoJnAibd53PUe/XZhqNsPm/rdbTiOZZwS6dMLQgWlyT7Nsj/zv6tD/Ol5PZge4
 2mnKwbZBy1sg+cuL/bHdqdjd6/6qvi5gNzapnHJZaXQJpX2kmRHvtKTLuDjy1OOKTwJS
 tKlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs9cfTMdxWEKPno4N8pHSDUkWJeQwkW7eMSPZNK5Tgm7kt0ji1AtjiSwBJj/geLMFrwciIg90DZR2a+FQ4SpGMtK0HzQ==
X-Gm-Message-State: AOJu0Yx2IQh+01NeAuASzBE6WgFigmdI3Qq6NiGP38CDQKzKuuTUAtOB
 1ihVI7cWqwO4VBRuSGcwX19hqR3/1noLG55pquYLqjWLxohipz43MrDwpRrrLeM=
X-Google-Smtp-Source: AGHT+IH2pIePLKFm/WrI1cnDlPQ769orVdICX14AglQHQzTvdVb14gtsb78X+iDgiZzDW6EFHvF3Tg==
X-Received: by 2002:adf:e991:0:b0:343:b9e4:d254 with SMTP id
 h17-20020adfe991000000b00343b9e4d254mr1460682wrm.13.1712910960966; 
 Fri, 12 Apr 2024 01:36:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:986c:54c:12ce:a121?
 ([2a01:e0a:982:cbb0:986c:54c:12ce:a121])
 by smtp.gmail.com with ESMTPSA id
 m4-20020adff384000000b0033e7de97214sm3706628wro.40.2024.04.12.01.36.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 01:36:00 -0700 (PDT)
Message-ID: <e98e2da6-ddd4-488c-8244-b868bcf3164d@linaro.org>
Date: Fri, 12 Apr 2024 10:35:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/7] mmc: msm_sdhci: correct vendor_spec_cap0 register for
 v5
To: Sumit Garg <sumit.garg@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de
References: <20240409-b4-qcom-mmc-fixes-v1-0-5039164ecbf7@linaro.org>
 <20240409-b4-qcom-mmc-fixes-v1-1-5039164ecbf7@linaro.org>
 <CAFA6WYO+3VroUdFUVH390taViQX8pMQrOQDTSn0yU6BD5YY53A@mail.gmail.com>
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
In-Reply-To: <CAFA6WYO+3VroUdFUVH390taViQX8pMQrOQDTSn0yU6BD5YY53A@mail.gmail.com>
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

On 11/04/2024 15:59, Sumit Garg wrote:
> On Tue, 9 Apr 2024 at 23:33, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> The V4 and V5 controllers have quite varied register layouts. Inherit
>> the register offsets and naming from the Linux driver. More version
>> specific offsets can be inherited from Linux as needed.
>>
>> Fixes: 364c22a ("mmc: msm_sdhci: Add SDCC version 5.0.0 support")
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>   drivers/mmc/msm_sdhci.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
> 
> This patch broke booting on the HMIBSC board, have you tested it on
> db410c? It's very likely that this has caused regression there too.
> 
> Error observed:
> 
> sdhci_send_command: Timeout for status update: 00000000 00000001

Indeed swapping the core_vendor_spec_capabilities0 between msm_sdhc_v5_var & msm_sdhc_mci_var
fixes this and I'm now able to enable SDCard on the SM8550-HDK

Neil

> 
> -Sumit
> 
>> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
>> index 059cb3da77c5..f23d425144ef 100644
>> --- a/drivers/mmc/msm_sdhci.c
>> +++ b/drivers/mmc/msm_sdhci.c
>> @@ -32,11 +32,8 @@
>>   #define SDCC_MCI_STATUS2 0x6C
>>   #define SDCC_MCI_STATUS2_MCI_ACT 0x1
>>   #define SDCC_MCI_HC_MODE 0x78
>>
>> -/* Non standard (?) SDHCI register */
>> -#define SDHCI_VENDOR_SPEC_CAPABILITIES0  0x11c
>> -
>>   struct msm_sdhc_plat {
>>          struct mmc_config cfg;
>>          struct mmc mmc;
>>   };
>> @@ -48,8 +45,10 @@ struct msm_sdhc {
>>   };
>>
>>   struct msm_sdhc_variant_info {
>>          bool mci_removed;
>> +
>> +       u32 core_vendor_spec_capabilities0;
>>   };
>>
>>   DECLARE_GLOBAL_DATA_PTR;
>>
>> @@ -180,9 +179,9 @@ static int msm_sdc_probe(struct udevice *dev)
>>           */
>>          if (core_major >= 1 && core_minor != 0x11 && core_minor != 0x12) {
>>                  caps = readl(host->ioaddr + SDHCI_CAPABILITIES);
>>                  caps |= SDHCI_CAN_VDD_300 | SDHCI_CAN_DO_8BIT;
>> -               writel(caps, host->ioaddr + SDHCI_VENDOR_SPEC_CAPABILITIES0);
>> +               writel(caps, host->ioaddr + var_info->core_vendor_spec_capabilities0);
>>          }
>>
>>          ret = mmc_of_parse(dev, &plat->cfg);
>>          if (ret)
>> @@ -243,12 +242,16 @@ static int msm_sdc_bind(struct udevice *dev)
>>   }
>>
>>   static const struct msm_sdhc_variant_info msm_sdhc_mci_var = {
>>          .mci_removed = false,
>> +
>> +       .core_vendor_spec_capabilities0 = 0x21c,
>>   };
>>
>>   static const struct msm_sdhc_variant_info msm_sdhc_v5_var = {
>>          .mci_removed = true,
>> +
>> +       .core_vendor_spec_capabilities0 = 0x11c,
>>   };
>>
>>   static const struct udevice_id msm_mmc_ids[] = {
>>          { .compatible = "qcom,sdhci-msm-v4", .data = (ulong)&msm_sdhc_mci_var },
>>
>> --
>> 2.44.0
>>

