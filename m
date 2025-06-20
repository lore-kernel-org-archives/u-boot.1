Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE5AC7115B
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 08:56:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1380C82D88;
	Fri, 20 Jun 2025 10:56:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="C9G2Q+lY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C13D082E08; Fri, 20 Jun 2025 10:56:27 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA99D82CF4
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 10:56:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-450dd065828so11262515e9.2
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 01:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750409785; x=1751014585; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=v7Xio3ajAvwmcDE7XJifhkZRpQZ6TVg/4XNkAn+gBZE=;
 b=C9G2Q+lYYRMNqkAW8RXdyxCBr98a8fIP9UBbqbQkeVIfp9P6oqALQQ47YEqTYwkcul
 UJA6xQ5KYK3iN5wyogARIOKcGuPwBKgqtzTlxYppA40lIhzH28eBQQMGyoaO2beIVKHw
 OsBJMuSSJSLiPcQ5T00pGZVEn9zMysITg9AU31YiTtxY1XmiazgorAGzX7b6u2tA0vx/
 8AZrOqIdaD5vXxIFlNQl6yOXYB1wHrstz64j+Eubod8IwFign2TCyLBEG2LieeQEX25E
 qkinuCc0fAViiK3RVWxT2hHdl+yFicc26oIKWXjLOrzm1zbFP2R2Ws0W66nJVmGqiDSo
 XePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750409785; x=1751014585;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=v7Xio3ajAvwmcDE7XJifhkZRpQZ6TVg/4XNkAn+gBZE=;
 b=gCPU843ejTH2/5O5um65JjHpeJh9aPntTeB5/oHdLmDIuKBT0n08i0wXkY8wybgrjS
 rMtxn8lLdRrNxH8LRCA3IFoUyv44vvFxefBB+Ojseuaa6hhKkPOHyliJNdlVF8m+ckyZ
 7undkmX7W6GCRzDZzHLpMCtYIxrMDqvtkPsQbTt4xh6v3yiR0D+zOlFFZ/6nI/4F7t1W
 w5fVj3G14QBgx/tDrNVAEInC2PEMUbcfuVsF7zf9HJBM1gRj+j/Z2c/7SG7BqcqdXXyG
 vI+RCwcG+LIdgCPEq9aXyeWkAum8zxyStqyY8L6fontjShyt0EMhWIoHwH/K56FwXTmG
 p/Zw==
X-Gm-Message-State: AOJu0YyNWEXhQ4bj0D0XqdYmRo2k1lc/o6qQ+SwWZRo/yNsS1LY+Cju0
 amYDtDTFsZQLBBA44dYfYymvZMw9IdKDO7XFKpYuIWUD1NfOTyp57dQIKreLjsGaJIg=
X-Gm-Gg: ASbGncvLTCEwK4jfEyf8KQspeVz7RIS4jwVAU59VOUGon/MaozOwlH7qB8IB3SYSmXv
 t+132InvAOftO6d3IGWpoHrDQodkjZgoEdM4RU82KdyyXw+hor9sAXiR/AQP+pXiPW2fSmHx23S
 BeWlG/ndxtdfkPdiyuba8OTyF+S+1Jx/PlNyRXcWpCep4zsczpQxOHVWYwh//VgC+O/+FKRIefS
 hZGwG1utGbZwNWOZwWwLYYAM4i2VGTaxIKnTkv1DrbA6BHNuAzSYG6g97xEmCiBer4JyGGsOORl
 nT6GQfrZTwvcsIVixYW1o8+NkCr2mOWuOPNh0mBWgUty4NEvR+Cig//0oQaOy9HkLPolfDb8KKf
 4RBZ9XXDXDlhEgRIB/hR8BPw5RBqcVDfxPu3YOsY=
X-Google-Smtp-Source: AGHT+IELSTGxqhwuUBf9gmcwGBUhJgstdtHyvurXI724P897zhYToA+/Kdj9r275Xip38eR6AebLWQ==
X-Received: by 2002:a05:600c:3115:b0:440:9b1a:cd78 with SMTP id
 5b1f17b1804b1-453654cbfdbmr18904685e9.10.1750409785204; 
 Fri, 20 Jun 2025 01:56:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3d60:2fa3:b982:4627?
 ([2a01:e0a:3d9:2080:3d60:2fa3:b982:4627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535eac8c16sm51629345e9.19.2025.06.20.01.56.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Jun 2025 01:56:24 -0700 (PDT)
Message-ID: <868e429a-75b5-47a1-828d-1791e2826c4c@linaro.org>
Date: Fri, 20 Jun 2025 10:56:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 6/8] regulator: qcom-rpmh-regulator: add support for
 pm6150l regulators
To: Luca Weiss <luca.weiss@fairphone.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250618-sm6350-bringup-v1-0-3cc22aab7a7a@fairphone.com>
 <20250618-sm6350-bringup-v1-6-3cc22aab7a7a@fairphone.com>
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
In-Reply-To: <20250618-sm6350-bringup-v1-6-3cc22aab7a7a@fairphone.com>
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

On 18/06/2025 16:25, Luca Weiss wrote:
> Add the pm6150l regulator data found on the Qualcomm SM6350 platform.
> The tables are imported from the Linux driver. The SMPS regulators were
> not added now.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   drivers/power/regulator/qcom-rpmh-regulator.c | 31 +++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
> index 954deca5ed75ca4f58898ee401bd06c9da82e56e..0646614256049e49846aa257bd02466fb9cf59d7 100644
> --- a/drivers/power/regulator/qcom-rpmh-regulator.c
> +++ b/drivers/power/regulator/qcom-rpmh-regulator.c
> @@ -456,6 +456,16 @@ static const struct rpmh_vreg_hw_data pmic5_pldo_lv = {
>   	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic5_ldo),
>   };
>   
> +static const struct rpmh_vreg_hw_data pmic5_nldo = {
> +	.regulator_type = VRM,
> +	.ops = &rpmh_regulator_vrm_drms_ops,
> +	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 123, 8000),
> +	.n_voltages = 124,
> +	.hpm_min_load_uA = 30000,
> +	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
> +	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic5_ldo),
> +};
> +
>   static const struct rpmh_vreg_hw_data pmic5_nldo515 = {
>   	.regulator_type = VRM,
>   	.ops = &rpmh_regulator_vrm_drms_ops,
> @@ -493,6 +503,23 @@ static const struct rpmh_vreg_hw_data pmic5_pldo515_mv = {
>   	.supply_name	= _supply_name, \
>   }
>   
> +static const struct rpmh_vreg_init_data pm6150l_vreg_data[] = {
> +	/* smps1 - smps8 are not added to u-boot yet */
> +	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_pldo_lv,   "vdd-l1-l8"),
> +	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_nldo,      "vdd-l2-l3"),
> +	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,      "vdd-l2-l3"),
> +	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_pldo,      "vdd-l4-l5-l6"),
> +	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo,      "vdd-l4-l5-l6"),
> +	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo,      "vdd-l4-l5-l6"),
> +	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo,      "vdd-l7-l11"),
> +	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_pldo,      "vdd-l1-l8"),
> +	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_pldo,      "vdd-l9-l10"),
> +	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_pldo,      "vdd-l9-l10"),
> +	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_pldo,      "vdd-l7-l11"),
> +	RPMH_VREG("bob",    "bob%s1",  &pmic5_bob,       "vdd-bob"),
> +	{}
> +};
> +
>   static const struct rpmh_vreg_init_data pm8150_vreg_data[] = {
>   	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_pldo,      "vdd-l13-l16-l17"),
>   	{}
> @@ -705,6 +732,10 @@ static int rpmh_regulators_bind(struct udevice *dev)
>   }
>   
>   static const struct udevice_id rpmh_regulator_ids[] = {
> +	{
> +		.compatible = "qcom,pm6150l-rpmh-regulators",
> +		.data = (ulong)pm6150l_vreg_data,
> +	},
>   	{
>   		.compatible = "qcom,pm8150-rpmh-regulators",
>   		.data = (ulong)pm8150_vreg_data,
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
