Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83984C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 16:42:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07FEF878F9;
	Thu, 21 Dec 2023 17:42:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h6nlcCKw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05A11878FE; Thu, 21 Dec 2023 17:42:52 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A34A878F6
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 17:42:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-336746a545fso619169f8f.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 08:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703176969; x=1703781769; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=ehmv+MqtxAs8qIceF6RzEuCykZ3ljn0wg/iD9cMxuJA=;
 b=h6nlcCKwc6kGHXWnwsBPU2T/jIH5L4HdHbxUNHDaLqdrBP2kSnCsrRgBaereqBhJeG
 pmeWGqTQNtPDQh65oKJjB7+Z4Q5u8b/aIu1DWLO2uSQojijhiUXBSb3yuUzPboUWbD/b
 ePtUpSYtk6sGafcN6dl/W8ILNG871SF/ZT7HQnuQS3bAvsEFHpdBMyD26Mu6FJtdPVkn
 rfAG2xP6TWlVjAGBiNcqoCs2M7ktYazn/n0qhjV9R3o2pJSRoVxEHACBITgAihEzxZD5
 pmlW0GttZylYUXmCq4S1Dz+gnzUn48rlt+gO8XQO2JZcvxgYGHMQC4A8kRfbsHDK0CYu
 +sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703176969; x=1703781769;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ehmv+MqtxAs8qIceF6RzEuCykZ3ljn0wg/iD9cMxuJA=;
 b=PicpOsFkGKV+Y8HWvqyFUmNieKavBAIF49NAd1j2hEpkyjtB+fbXdnpKw7a7xa3pZp
 Ydcmwvx8X+dt3UmLsp+5UY7K+8kIuURCDOMrOkXgdwhevkg6tFLwu2WPOwB0V5sPAyMZ
 XcGBgf2hcYYHx2k/TorS2WhcwWjdK53YNiKxCC86J56GZBUZn65QXKSmo7IBIwJmh6Qt
 H5aKKHuUbGib3k9HzisPe7obz/drJU7YEqFaK0y8y4B5fpn3evScvxQlt09TI+TNeZL7
 05WhUXjnkAkqxmMGa4tAgkRKn9cBE7QyHmnr7crlhS6pxBUrMKwiSHACfCStn4Hla3Nv
 Fpeg==
X-Gm-Message-State: AOJu0YyaD0fVRcRRLoAWjeqLG7Ouuj7zOLjdkh+YwHYm3jAj3JHGD/Zd
 SD4BdB9U/qaA99OrJnI5uDuVVg==
X-Google-Smtp-Source: AGHT+IEmoqA8r2PWU5EPUFYQfR/faPRJlKMqh8DYKDCOv5N4bLuRdm/mmBywQdkvymf/VuZuSLYVOQ==
X-Received: by 2002:a5d:5918:0:b0:336:8af0:1fd1 with SMTP id
 v24-20020a5d5918000000b003368af01fd1mr501428wrd.11.1703176969059; 
 Thu, 21 Dec 2023 08:42:49 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed?
 ([2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed])
 by smtp.gmail.com with ESMTPSA id
 s23-20020adf9797000000b00336813bb588sm2414625wrb.111.2023.12.21.08.42.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 08:42:48 -0800 (PST)
Message-ID: <a9297a28-7dc7-4150-82d9-e48177af6752@linaro.org>
Date: Thu, 21 Dec 2023 17:42:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 03/32] mmc: msm_sdhci: use modern clock handling
Content-Language: en-US, fr
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
 <20231219-b4-qcom-common-target-v2-3-b6dd9704219e@linaro.org>
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
Organization: Linaro Developer Services
In-Reply-To: <20231219-b4-qcom-common-target-v2-3-b6dd9704219e@linaro.org>
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

On 19/12/2023 17:04, Caleb Connolly wrote:
> Use the clk_* helper functions and the correct property name for clocks.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/mmc/msm_sdhci.c | 69 ++++++++++++++++++++++++++++++++-----------------
>   1 file changed, 46 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> index 604f9c3ff99c..863e6007a905 100644
> --- a/drivers/mmc/msm_sdhci.c
> +++ b/drivers/mmc/msm_sdhci.c
> @@ -44,6 +44,7 @@ struct msm_sdhc_plat {
>   struct msm_sdhc {
>   	struct sdhci_host host;
>   	void *base;
> +	struct clk_bulk clks;
>   };
>   
>   struct msm_sdhc_variant_info {
> @@ -54,36 +55,56 @@ DECLARE_GLOBAL_DATA_PTR;
>   
>   static int msm_sdc_clk_init(struct udevice *dev)
>   {
> -	int node = dev_of_offset(dev);
> -	uint clk_rate = fdtdec_get_uint(gd->fdt_blob, node, "clock-frequency",
> -					400000);
> -	uint clkd[2]; /* clk_id and clk_no */
> -	int clk_offset;
> -	struct udevice *clk_dev;
> -	struct clk clk;
> -	int ret;
> +	struct msm_sdhc *prv = dev_get_priv(dev);
> +	ofnode node = dev_ofnode(dev);
> +	uint clk_rate;
> +	int ret, i = 0, n_clks;
> +	const char *clk_name;
>   
> -	ret = fdtdec_get_int_array(gd->fdt_blob, node, "clock", clkd, 2);
> +	ret = ofnode_read_u32(node, "clock-frequency", &clk_rate);
>   	if (ret)
> -		return ret;
> +		clk_rate = 400000;
>   
> -	clk_offset = fdt_node_offset_by_phandle(gd->fdt_blob, clkd[0]);
> -	if (clk_offset < 0)
> -		return clk_offset;
> -
> -	ret = uclass_get_device_by_of_offset(UCLASS_CLK, clk_offset, &clk_dev);
> -	if (ret)
> +	ret = clk_get_bulk(dev, &prv->clks);
> +	if (ret) {
> +		debug("Couldn't get mmc clocks: %d\n", ret);
>   		return ret;
> +	}
>   
> -	clk.id = clkd[1];
> -	ret = clk_request(clk_dev, &clk);
> -	if (ret < 0)
> +	ret = clk_enable_bulk(&prv->clks);
> +	if (ret) {
> +		debug("Couldn't enable mmc clocks: %d\n", ret);
>   		return ret;
> +	}
>   
> -	ret = clk_set_rate(&clk, clk_rate);
> -	clk_free(&clk);
> -	if (ret < 0)
> -		return ret;
> +	/* If clock-names is unspecified, then the first clock is the core clock */
> +	if (!ofnode_get_property(node, "clock-names", &n_clks)) {
> +		if (!clk_set_rate(&prv->clks.clks[0], clk_rate)) {
> +			printf("Couldn't set core clock rate: %d\n", ret);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	/* Find the index of the "core" clock */
> +	while (i < n_clks) {
> +		ofnode_read_string_index(node, "clock-names", i, &clk_name);
> +		if (!strcmp(clk_name, "core"))
> +			break;
> +		i++;
> +	}
> +
> +	if (i >= prv->clks.count) {
> +		printf("Couldn't find core clock (index %d but only have %d clocks)\n", i,
> +		       prv->clks.count);
> +		return -EINVAL;
> +	}
> +
> +	/* The clock is already enabled by the clk_bulk above */
> +	ret = clk_set_rate(&prv->clks.clks[i], clk_rate);
> +	if (!ret) {
> +		printf("Couldn't set core clock rate: %d\n", ret);
> +		return -EINVAL;
> +	}
>   
>   	return 0;
>   }
> @@ -188,6 +209,8 @@ static int msm_sdc_remove(struct udevice *dev)
>   	if (!var_info->mci_removed)
>   		writel(0, priv->base + SDCC_MCI_HC_MODE);
>   
> +	clk_release_bulk(&priv->clks);
> +
>   	return 0;
>   }
>   
> 
Looks better like this!

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
