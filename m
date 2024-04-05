Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A123CD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 09:26:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC9608850B;
	Fri,  5 Apr 2024 11:26:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aBRfAsb2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A6A58847A; Fri,  5 Apr 2024 11:26:54 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E41158851D
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 11:26:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4162ffb97a2so2656555e9.3
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 02:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712309210; x=1712914010; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=EqJLWgsTNxbya7hveUhoPuiHhb20MI4AV5RazJfmTB0=;
 b=aBRfAsb20Uhd5DCSbJFEPWzQQwHD1h2o67dZGACSJ0J5ibF5WUZJAQJwgQiVWrXLzd
 s+yxJdk9tBaKmt7AvoWnRlWSlXmlsWiFrrzEjRuuW6cpWrV0oMPXYpF3RItHPpDGZhw4
 T0SOIfknh/svWkdrJnCd0Ubz60BwwOIAjLv6qzStWfjeTYdDzMU8xLjERse6kVwuapla
 74zW8lqsMoE3vKCJtksv0Jb/WCd5XSQGv5Dsyu9iIrBWc6A0YmrR3exhCBBejxgCeQUv
 htHWgVFxBne99Z1TEHsjLjmH+hhZgbR4tym+v8LLv8+NWe2qxDc2a0Dus2wJV6dVCPXe
 RNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712309210; x=1712914010;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=EqJLWgsTNxbya7hveUhoPuiHhb20MI4AV5RazJfmTB0=;
 b=qGjnfbVONo45SM2MYsURf9FG60OCQbkjBvPmaUJk3V/QH/Q64DPSCLoKsd/Tff36Ro
 hODqTM2O5X1EkPWzCxuA41Wu+vrvLpJ2uULzH8ShzrsUtCPvnOGh6UpvdzrIXCXaiVtG
 uzWgCPOTGiBL0eLOtcaLk/sOkQdDoOQphxiRX5+Baw7VgImrXbahYXZP6Bqm9MmKWB5k
 VoMd59UC66hxG1kAA9dzPUyuj/uk/1WCxNx7b5X9cd5/WYLhQG2leTSsT0YKT1LGdElk
 44YeQ5QbLdIrdoe7XrnW+kKsUiLMq4w8vBORgyWhdeeymf1LM9aN/cXfdTqXPVIM3gRU
 yjlQ==
X-Gm-Message-State: AOJu0YzfWY0fFcU7+uoH7OOqI3uL5Nr80reowvqEKxSKIkTHlrrWaFg6
 zHd2XgvjjxSxH/Dp65Tj4esmgrxZU2mHPcExLnpoznIa9na8+oFG6VrcvnkQpG8=
X-Google-Smtp-Source: AGHT+IFGRI4IxFrGGcaxMtyKBsQ1T8O5ECzCvlHEOfHYKC5w/4nXt6ySCfiQzP7hxYcGv9cXKyq9/A==
X-Received: by 2002:adf:fac7:0:b0:343:8d1b:b12d with SMTP id
 a7-20020adffac7000000b003438d1bb12dmr635520wrs.46.1712309210115; 
 Fri, 05 Apr 2024 02:26:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8e64:fc77:aa3a:87a?
 ([2a01:e0a:982:cbb0:8e64:fc77:aa3a:87a])
 by smtp.gmail.com with ESMTPSA id
 d15-20020adfa34f000000b00341c88ab493sm1589425wrb.10.2024.04.05.02.26.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 02:26:49 -0700 (PDT)
Message-ID: <9a7622c5-6b48-4f3e-a032-301e5815018a@linaro.org>
Date: Fri, 5 Apr 2024 11:26:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/3] button: qcom-pmic: add support for pmk8350 button
 configs
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240405-topic-sm8x50-spmi-clients-v1-0-c28603ebcf18@linaro.org>
 <20240405-topic-sm8x50-spmi-clients-v1-3-c28603ebcf18@linaro.org>
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
In-Reply-To: <20240405-topic-sm8x50-spmi-clients-v1-3-c28603ebcf18@linaro.org>
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

On 05/04/2024 10:27, Neil Armstrong wrote:
> Finally add the entries for the qcom,pmk8350-pwrkey and qcom,pmk8350-resin
> found on PMICs used with SM8350 and later SoCs.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/button/button-qcom-pmic.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/button/button-qcom-pmic.c b/drivers/button/button-qcom-pmic.c
> index f6da958097c..6153601017b 100644
> --- a/drivers/button/button-qcom-pmic.c
> +++ b/drivers/button/button-qcom-pmic.c
> @@ -36,6 +36,8 @@ struct qcom_pmic_btn_priv {
>   #define PON_INT_RT_STS                        0x10
>   #define  PON_KPDPWR_N_SET		0
>   #define  PON_RESIN_N_SET		1
> +#define  PON_GEN3_RESIN_N_SET		6
> +#define  PON_GEN3_KPDPWR_N_SET		7
>   
>   static enum button_state_t qcom_pwrkey_get_state(struct udevice *dev)
>   {
> @@ -69,6 +71,18 @@ static const struct qcom_pmic_btn_data qcom_pmic_btn_data_table[] = {
>   		.code = KEY_DOWN,
>   		.label = "vol_down",
>   	},
> +	{
> +		.compatible = "qcom,pmk8350-pwrkey",
> +		.status_bit = PON_GEN3_KPDPWR_N_SET,
> +		.code = KEY_ENTER,
> +		.label = "pwrkey",
> +	},
> +	{
> +		.compatible = "qcom,pmk8350-resin",
> +		.status_bit = PON_GEN3_RESIN_N_SET,
> +		.code = KEY_DOWN,
> +		.label = "vol_down",
> +	},
>   };
>   
>   static const struct qcom_pmic_btn_data *button_qcom_pmic_match(ofnode node)
> 

Missing change:

diff --git a/drivers/button/button-qcom-pmic.c b/drivers/button/button-qcom-pmic.c
index 6153601017b..ad7fed3ddaa 100644
--- a/drivers/button/button-qcom-pmic.c
+++ b/drivers/button/button-qcom-pmic.c
@@ -193,6 +193,7 @@ static const struct udevice_id qcom_pwrkey_ids[] = {
         { .compatible = "qcom,pm8916-pon" },
         { .compatible = "qcom,pm8941-pon" },
         { .compatible = "qcom,pm8998-pon" },
+       { .compatible = "qcom,pmk8350-pon" },
         { }
  };

Will send a v2 in a few days.

Neil
