Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3663CD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 08:42:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4AFD88120;
	Wed, 10 Apr 2024 10:42:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sZdzlQQf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4BEC870AB; Wed, 10 Apr 2024 10:42:05 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8358088191
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 10:42:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-416d141be48so2464475e9.1
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 01:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712738522; x=1713343322; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=zjXbZT/CDpM6SeDXpp/stgzKzHJuCeIAlrqhOey5tRY=;
 b=sZdzlQQfjHDKRs+QW/UHCNKT5MWUW9WaDsrE15PhA9DNL3yz5fi2DIjnc0BuAoozIw
 QCXp9G84IKk99AjC6dJb7FuRl7MZS7/mYPCI2/g+D+jxk9mEsMumJbLpWBJwJXbw8E5T
 Sf0ZJ6O1YZ7ZjACjtDaSIMChIojZgqpPGyTn+jhSDiYNgiq6iLvXl1MwmxV4WdzVxINr
 SZOBRhNSSiigNmNEMrzmb6ntVtoLB2uXCdglJ1amdbwvZnu+gq0cjiltaUNpyiVTEpbz
 DcnokpB4lKhkcfSZgQkPQPnltaFw0pO7MmvMhvTZ+Z4feM31o+5+ydQHpzeAHlCpn4UH
 wt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712738522; x=1713343322;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=zjXbZT/CDpM6SeDXpp/stgzKzHJuCeIAlrqhOey5tRY=;
 b=kwTx1G9pnCpcFX03PWgtZJI71pWoNunzVB4RvxBMu7hT4JcKpw0VVByLi7pnWcNDaw
 mFL7NFq0mEQ4u2Wm1c8ezqFC6pcZHCYuYI7TEjo1zMrLqda1rnLnuIq/vm5zeHrbSMdZ
 DEcvaPEmSULpQBj02ZPSmek05K3O8L4DjsrdCp+lvBZBK1iAvoxzCo6/eC3ccdlpBg5M
 g3HSrXN4kjxaUH66Jp4lIJj0PKpcYi49xSIDiictd6pMlWMzhY4AaZPRf/DZa2q2hmPa
 I51k15C2HtwUagaf7MfAo1K9NOO104JE0D8cTTeKjuj5ydEa0Ic3vyCoUbIjIUM5IypR
 Zq1A==
X-Gm-Message-State: AOJu0Yx30959Wp8Hfg9rVArLWaAp87+eBk4kuffsLdQbzITwsXGrdJQ8
 2k8lTsKamhAFwDrtWnV4DFUVkB6VIRJ4GQMtYW+LgMFAYDc34pVoliNdcrnkn8E=
X-Google-Smtp-Source: AGHT+IGvi3xsE/ggplHG4IT5fgqRZ9cLGQl0vA+XkcBF448y6+uEzgrzBs3FWqSytLZDdqVcgN7vbQ==
X-Received: by 2002:a5d:584d:0:b0:343:4c6e:eb5b with SMTP id
 i13-20020a5d584d000000b003434c6eeb5bmr1758026wrf.48.1712738521273; 
 Wed, 10 Apr 2024 01:42:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7b0c:6cd:4afa:674b?
 ([2a01:e0a:982:cbb0:7b0c:6cd:4afa:674b])
 by smtp.gmail.com with ESMTPSA id
 q18-20020adfcd92000000b00343e5f3a3e2sm12918304wrj.19.2024.04.10.01.42.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Apr 2024 01:42:00 -0700 (PDT)
Message-ID: <37da6982-fbe4-44a9-8011-24da9f171271@linaro.org>
Date: Wed, 10 Apr 2024 10:42:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/7] mmc: msm_sdhci: correct vendor_spec_cap0 register for
 v5
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240409-b4-qcom-mmc-fixes-v1-0-5039164ecbf7@linaro.org>
 <20240409-b4-qcom-mmc-fixes-v1-1-5039164ecbf7@linaro.org>
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
In-Reply-To: <20240409-b4-qcom-mmc-fixes-v1-1-5039164ecbf7@linaro.org>
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

On 09/04/2024 20:03, Caleb Connolly wrote:
> The V4 and V5 controllers have quite varied register layouts. Inherit
> the register offsets and naming from the Linux driver. More version
> specific offsets can be inherited from Linux as needed.
> 
> Fixes: 364c22a ("mmc: msm_sdhci: Add SDCC version 5.0.0 support")
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/mmc/msm_sdhci.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> index 059cb3da77c5..f23d425144ef 100644
> --- a/drivers/mmc/msm_sdhci.c
> +++ b/drivers/mmc/msm_sdhci.c
> @@ -32,11 +32,8 @@
>   #define SDCC_MCI_STATUS2 0x6C
>   #define SDCC_MCI_STATUS2_MCI_ACT 0x1
>   #define SDCC_MCI_HC_MODE 0x78
>   
> -/* Non standard (?) SDHCI register */
> -#define SDHCI_VENDOR_SPEC_CAPABILITIES0  0x11c
> -
>   struct msm_sdhc_plat {
>   	struct mmc_config cfg;
>   	struct mmc mmc;
>   };
> @@ -48,8 +45,10 @@ struct msm_sdhc {
>   };
>   
>   struct msm_sdhc_variant_info {
>   	bool mci_removed;
> +
> +	u32 core_vendor_spec_capabilities0;
>   };
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> @@ -180,9 +179,9 @@ static int msm_sdc_probe(struct udevice *dev)
>   	 */
>   	if (core_major >= 1 && core_minor != 0x11 && core_minor != 0x12) {
>   		caps = readl(host->ioaddr + SDHCI_CAPABILITIES);
>   		caps |= SDHCI_CAN_VDD_300 | SDHCI_CAN_DO_8BIT;
> -		writel(caps, host->ioaddr + SDHCI_VENDOR_SPEC_CAPABILITIES0);
> +		writel(caps, host->ioaddr + var_info->core_vendor_spec_capabilities0);
>   	}
>   
>   	ret = mmc_of_parse(dev, &plat->cfg);
>   	if (ret)
> @@ -243,12 +242,16 @@ static int msm_sdc_bind(struct udevice *dev)
>   }
>   
>   static const struct msm_sdhc_variant_info msm_sdhc_mci_var = {
>   	.mci_removed = false,
> +
> +	.core_vendor_spec_capabilities0 = 0x21c,
>   };
>   
>   static const struct msm_sdhc_variant_info msm_sdhc_v5_var = {
>   	.mci_removed = true,
> +
> +	.core_vendor_spec_capabilities0 = 0x11c,
>   };
>   
>   static const struct udevice_id msm_mmc_ids[] = {
>   	{ .compatible = "qcom,sdhci-msm-v4", .data = (ulong)&msm_sdhc_mci_var },
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
