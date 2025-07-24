Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E0CC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 11:43:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F2C583831;
	Thu, 24 Jul 2025 13:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qThcmxr+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DD9C83881; Thu, 24 Jul 2025 13:43:55 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 566DD836A3
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 13:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4563cfac2d2so8944945e9.3
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 04:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753357433; x=1753962233; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=In9Q3znwTfTGN3dvbqYDNnrrVv8n9d/DNlYKeUxfrys=;
 b=qThcmxr+tnbbfd/yPxmNlwBqwrdDhpMp1IAFJ2yB8mBSW17YaWMWlC3M8htpWrDYNR
 2zdkkqVJEJUtNh8lXb9Xb1n391XJy6VS+RuAPFgNhtIbcPp9NNfSQ6cCMNd03Elg+ei6
 RwjZdCXsxVlU3SCzjqCuP9hiH+WIrUB/h+2eXjVfR8xeQ6butbcrPcMxSFKkQLWv+OpU
 z2yjbu5TFUyOX0s/zXSGMDrdQherZLw7dF9EUTDBIhw6SMEG6KobO3yPY7TLMa/OQ5As
 SgnVsaEKM8s28g986ualOoJHabZJdfX4TRINmzjOQxhZ1gP1JRqNtzoHDer1Es5N5B22
 NZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753357433; x=1753962233;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=In9Q3znwTfTGN3dvbqYDNnrrVv8n9d/DNlYKeUxfrys=;
 b=kYOlPqB8aWBJ7tiGnk7IwewtBR6gQlMMPN0ZJT5nQu9FOiGQ0NnJAx8ZW/gw6g/DH2
 D+uqlhD8xET46esqs3bdE/vt2McXxdlEQBC/9izHuOCVXzLQ+V58mni++GcYSlBOTlL3
 dW69SFnsuWoggBuy7cNcU8KeRFQUJgeoUVHFLPyIxUwDzkk9bUIn6PNHM0anD6GMfTbF
 Mg8Bz6WFkg71BNk7+SVCuaBoiHJuYT5Y0y8EQZpyQOKctIoA3NUq2eyGAYsxsLs5B49y
 45+Al1Blr3g7h+Nzhx3phbXKk8/fa4FpLjtfMwa3cZGSmZVsHQWdtxp7kz9iiuQuNw21
 C1FQ==
X-Gm-Message-State: AOJu0YzKfvVEdxa7VOE4vwd7dpaC0TKUQZzTk+Q6CQsKF7fu3y4/2Glh
 HMtOECwd3FnkpYcq4TcE9Aq51PdibWnDgrUg3pfASm3OqmLJlU1WRZI7g0CgU3mpkMA=
X-Gm-Gg: ASbGncvAUmGzDaNq1LIEoXFIN4kUPwRkQbSvKFa+ZiGlH/xI+GGQFcW1tgMzUzbwItz
 2+pT8QvibkGs5ESfFClRrWPJ8xs732gGRMICcz9hjeRaNaYX0ucdwkeZvZ3QTKtet41U4sQC1bU
 JFjqubnk5sw7wuWuzpSksK41tDeQsRdzDU0rh/0uKetINVmwSJOll6PCTHRKob+nEqS+b/xRj5N
 D7C+SlWSHnxnWeq2QQN9pxI8EiX5Iz5v3B9h5hf3sIqm0NA0FzhsSqv6ZT3SAYdjA+4jsMg1+f5
 c0TSw049ySXVou34rst7/5MR0Pbmav48B86rtbQ3SLKcyD9Eh8KEHvwM5v1BKygk0EE+HqlBTdE
 w086kW3qnhBWh+by2tJ0/c/f0WfTAqbc0IRXERcIbhtmfEGFlxb33/bGgXECsCVrNrM3+W/gvqi
 h1nxzZlk+r7A==
X-Google-Smtp-Source: AGHT+IHWGOFJD7xW9Wp2UeQsDFrKmNB4UzddOeqDO4Zb18UPMgPoNO/8FDfLGH+zPEa8/i3LglGeVw==
X-Received: by 2002:a05:6000:24c5:b0:3a5:27ba:47c7 with SMTP id
 ffacd0b85a97d-3b768f00df9mr6506420f8f.48.1753357432635; 
 Thu, 24 Jul 2025 04:43:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:e2d3:d328:dc00:f187?
 ([2a01:e0a:cad:2140:e2d3:d328:dc00:f187])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b76fc6d085sm1905245f8f.21.2025.07.24.04.43.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 04:43:52 -0700 (PDT)
Message-ID: <7995f43a-aeb1-4635-a915-c3451d631e9b@linaro.org>
Date: Thu, 24 Jul 2025 13:43:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/8] clk/qcom: Add SM6350 clock driver
To: Luca Weiss <luca.weiss@fairphone.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250618-sm6350-bringup-v1-0-3cc22aab7a7a@fairphone.com>
 <20250618-sm6350-bringup-v1-1-3cc22aab7a7a@fairphone.com>
 <7ba396a4-d248-41bd-ace2-6d8f5c4c3bda@linaro.org>
 <DAR8PXSLCOFN.GNOSXEGBFEX3@fairphone.com>
 <DBJENX4A7C1B.1PUG0XWDE98UE@fairphone.com>
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
In-Reply-To: <DBJENX4A7C1B.1PUG0XWDE98UE@fairphone.com>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 23/07/2025 13:41, Luca Weiss wrote:
> Hi Neil,
> 
> On Fri Jun 20, 2025 at 11:07 AM CEST, Luca Weiss wrote:
>> On Fri Jun 20, 2025 at 10:54 AM CEST, Neil Armstrong wrote:
>>> On 18/06/2025 16:25, Luca Weiss wrote:
>>>> Add Clock driver for the GCC block found in the SM6350 SoC.
>>>>
>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>> ---
>>
>> <snip>
>>
>>>> +static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
>>>> +	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
>>>> +	F(9600000, CFG_CLK_SRC_CXO, 2, 0, 0),
>>>> +	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
>>>> +	F(25000000, CFG_CLK_SRC_GPLL0_ODD, 8, 0, 0),
>>>> +	F(50000000, CFG_CLK_SRC_GPLL0_ODD, 4, 0, 0),
>>>> +	F(100000000, CFG_CLK_SRC_GPLL0_ODD, 2, 0, 0),
>>>> +	F(202000000, CFG_CLK_SRC_GPLL7, 4, 0, 0),
>>>> +	{}
>>>> +};
>>>> +
>>>> +static struct pll_vote_clk gpll7_vote_clk = {
>>>> +	.status = APCS_GPLL7_STATUS,
>>>> +	.status_bit = BIT(31),
>>>> +	.ena_vote = APCS_GPLLX_ENA_REG,
>>>> +	.vote_bit = BIT(7),
>>>> +};
>>>> +
>>>> +static ulong sm6350_set_rate(struct clk *clk, ulong rate)
>>>> +{
>>>> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
>>>> +	const struct freq_tbl *freq;
>>>> +
>>>> +	if (clk->id < priv->data->num_clks)
>>>> +		debug("%s: %s, requested rate=%ld\n", __func__,
>>>> +		      priv->data->clks[clk->id].name, rate);
>>>> +
>>>> +	switch (clk->id) {
>>>> +	case GCC_QUPV3_WRAP1_S3_CLK: /*UART9*/
>>>> +		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap1_s3_clk_src, rate);
>>>> +		clk_rcg_set_rate_mnd(priv->base, GCC_SE12_UART_RCG_REG,
>>>> +				     freq->pre_div, freq->m, freq->n, freq->src,
>>>> +				     16);
>>>> +
>>>> +		return freq->freq;
>>>> +	case GCC_SDCC2_APPS_CLK:
>>>> +		/* Enable GPLL7 so that we can point SDCC2_APPS_CLK_SRC at it */
>>>> +		clk_enable_gpll0(priv->base, &gpll7_vote_clk);
>>>> +		freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
>>>> +		printf("%s: got freq %u\n", __func__, freq->freq);
>>>> +		WARN(freq->src != CFG_CLK_SRC_GPLL7,
>>>> +		     "SDCC2_APPS_CLK_SRC not set to GPLL7, requested rate %lu\n",
>>>> +		     rate);
>>>
>>> Why not enabling GPLL7 only if freq->src == CFG_CLK_SRC_GPLL7 ??
>>
>> I honestly just copy-pasted this part, I didn't think too much about
>> this code. But also doesn't the code do the wrong thing when pointing to
>> any freq apart from 202 MHz? The warn and the clk_rcg_set_rate_mnd call
>> below will complain about/set the wrong parent?
>>
>> Seems that construct is in clock drivers for qcm2290, sm6115 and sm8250.
>>
>> Also other clk drivers like clock-sc7280.c don't have any set_rate
>> handling for this clock either and SD card supposedly works fine on the
>> Shiftphone 8.
> 
> Do you have any feedback how the clock drivers would be correct?

Nothing precise, but I guess we can fix this later on, it's not wrong as-is,
just not optimal.

Neil

> 
> Regards
> Luca

