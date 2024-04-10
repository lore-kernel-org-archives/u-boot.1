Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94119CD1296
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 08:40:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0946F870AB;
	Wed, 10 Apr 2024 10:40:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Da0xTPbX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BE3588116; Wed, 10 Apr 2024 10:39:58 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B74687073
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 10:39:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-345b857d7adso1978178f8f.1
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 01:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712738396; x=1713343196; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Xy8azzE46+R8vbhNFGjb9CnMzXBuYCZA5IMeQtBTAHk=;
 b=Da0xTPbXwlrErSIq8Ebb9uaXD07ALzkR/DVNJ5mPJ3K+uyqFxo38md+mZbEKboAcnM
 R6OsTaW4Co/ar/qGdsaTJcyCWLBPE85xAHJF7lWLdmu+Ad6YOT1fDvBdMlpqcAPi/RB8
 Smc9cpHwGunJ9jZL8MtB5nRLcQQZ70J+9SubYmf5xWT/eYL4Qhcgp5wtFhh+cz9XZlrT
 TOrw1aWlOeCRIeRE3lKwxXGgsS3r0cv9Xe4c3XYc9QbvPBXVMW68k/oI2UJ4MQtV+LYN
 nkN7piJrVBie5JmnGU2aFPsX48jOsWnuDExrfVv171miPk3hEbpoMOe41yv26hG9ZPeU
 1yoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712738396; x=1713343196;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Xy8azzE46+R8vbhNFGjb9CnMzXBuYCZA5IMeQtBTAHk=;
 b=NHep6/u3C5urMDYGVSsDu76VmFClx+y3HDgQwjgTTSTg+uFHEbu77y+bwRc6AaYsce
 z0d4UsK+B6QShPRPMjo/oJS3/cLAWJ4jPDyHDvQXHzq5BbBjUQG/4MCQ/sQwfawSoZVH
 0HFxYXGY0sEbnmlUwsltCO2KfpJVPQFpcJred2q5fzIU4GakmKJvyhEE9TJpgJr1/l37
 tyCfYxa114ceKgquG6RuZkGNw7+djAiq4nhg40SyJSDFK0ILN1QHd80RBr4FGvRzt3G+
 pku72K8LYc2sPGJgnKsWxC9qDP6Qjj7VmH8mEwS32MzkFHCoQM0sJS/GllIDemGcloHU
 YOlg==
X-Gm-Message-State: AOJu0YxX5rqJnnXcm8fbXGWEUvzfXfa0x2Os3wwK0vTCnGe6pwTa8VQb
 WDaJ11Cc8JGJCcsVxJrKcsKADQgMQX5gqIdSO7yLQcRn4p21WLonEMwJIIm+jAU=
X-Google-Smtp-Source: AGHT+IFcfhRBi8Pjleg5Ld+SYUkJ8S2onj86bh/+yvZDGEB15hobeTWtFcnaso12BCcyfFYNFTv4tg==
X-Received: by 2002:a05:6000:2a3:b0:346:4160:99b9 with SMTP id
 l3-20020a05600002a300b00346416099b9mr2274933wry.4.1712738395489; 
 Wed, 10 Apr 2024 01:39:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7b0c:6cd:4afa:674b?
 ([2a01:e0a:982:cbb0:7b0c:6cd:4afa:674b])
 by smtp.gmail.com with ESMTPSA id
 y16-20020adff6d0000000b0034335f13570sm13287825wrp.116.2024.04.10.01.39.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Apr 2024 01:39:55 -0700 (PDT)
Message-ID: <f6725bd9-1944-4f9a-9b5a-ffc4346be09f@linaro.org>
Date: Wed, 10 Apr 2024 10:39:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 4/7] mmc: msm_sdhci: use a more sensible default clock rate
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240409-b4-qcom-mmc-fixes-v1-0-5039164ecbf7@linaro.org>
 <20240409-b4-qcom-mmc-fixes-v1-4-5039164ecbf7@linaro.org>
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
In-Reply-To: <20240409-b4-qcom-mmc-fixes-v1-4-5039164ecbf7@linaro.org>
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

Hi,

On 09/04/2024 20:03, Caleb Connolly wrote:
> We currently default to the lowest rate but this actually doesn't work
> on most platforms. Default to the HS400 speed instead which is most
> common on Qualcomm platforms.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/mmc/msm_sdhci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> index ea5d6b4cbbee..2144772ac325 100644
> --- a/drivers/mmc/msm_sdhci.c
> +++ b/drivers/mmc/msm_sdhci.c
> @@ -61,9 +61,9 @@ static int msm_sdc_clk_init(struct udevice *dev)
>   	const char *clk_name;
>   
>   	ret = ofnode_read_u32(node, "clock-frequency", (uint *)(&clk_rate));
>   	if (ret)
> -		clk_rate = 400000;
> +		clk_rate = 201500000;

I think we may either use INT_MAX so the clock driver uses the max freq in the table,
or we could also parse the DT OPPs and take the max frequency ?

>   
>   	ret = clk_get_bulk(dev, &prv->clks);
>   	if (ret) {
>   		log_warning("Couldn't get mmc clocks: %d\n", ret);
> 

