Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E321CEBF93
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 08:05:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5BBA83C65;
	Tue, 18 Nov 2025 09:05:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M8kRX065";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0198283C72; Tue, 18 Nov 2025 09:05:41 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6343483C5E
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 09:05:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so53257945e9.1
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 00:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763453138; x=1764057938; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=s5BGP20P76NMFo+4odf2+tH1HBzfleSS80ScfIku0aU=;
 b=M8kRX0658Uw41pNG0Izo5NpytsZS453xZ8dgO/7SFy3Tn3m1TPmIRpUlxtexsYtk1D
 tFS049QFVePk2wOg+fgwIfbLMRM4EiGYPsFmLgfW5RdEAFYhRbtiYKS7AmBwQE7LOkoh
 urN5n/kTvFLROQj5H/2i4/0CXdjG+7+85oiAyL+Fgkx8LP6rbFEvvq3MHRnCpYAEK0ww
 AeuMXgdtc5flb3V1ES+q0mf4E/pHaiEGegb+DJ8or25utd8JWxcgX4JgoaOSB2jm+6TW
 EN8oP3ofkU52oz4FaqWgIp+Dd1zvtqdDXzF2Xd7LTk4N2TMo8uLIjkvvBVcYFa8GGKVy
 K0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763453138; x=1764057938;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s5BGP20P76NMFo+4odf2+tH1HBzfleSS80ScfIku0aU=;
 b=QLpYfDCxMO5jA/RfTbqwH9lcsPcjbjQLkz8VTgC7j2erne1c5xQwi/FrWGXl5FxKF2
 cngpn2uA2nBWZ4febJ6ahaUk8PJg/AIfXs8FuWdJPJTr/MuLUcxtbuaonO5EAQMrxqRu
 CMk/69pjZIgHxg5DvXnxz3HyXxrHtaycKBaJccWMHxRTSVUoONaJtXM2+bHmKq1iyGGM
 lOp0BiUC8K0FBSdkJZEXQupatpuHgPIVg97yANHu9V7nQMXx1Zlks2pJZPImSxydcX7z
 z3yQI3GKslpVFTx5v09uOleD3CIDGye+rch95ByfLL+/Ynm3vFHnXJUqvEUiiUNjMqbR
 ubNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMOnCv2hyj1SwWpfVIdnvVbRgVhFQzHzitnQBMpPVMWmAAvBwItHGNubenA6ojhmOjD3FM/HM=@lists.denx.de
X-Gm-Message-State: AOJu0YwWvVS2niiDxRrocqYQ6cqSdIcImshdvsKClyHK79+r9LAtBd1s
 luHDFLv1g6wlyDcR5bUMJ37N6fwl+EsBsM30fBpoxK7KZvkNS2r+hO7lVRvWKMwLsxQ=
X-Gm-Gg: ASbGnctnJpqPnw4SJoJEqOmI2Xnb2fWJdstJINzLAXCLYX+5bHMFYoJKEyygBJhKpgS
 LgemCk1VpEKntY48HAvYKqCceGkjCMegRLP9BDOUYhcpXmPTkTu3VElTxLGd/Hj9Gc2c8eawViO
 /x1DaqABVMd4Vc0bJ1X9AZf+FMoWexZOCAKOOjxiktP17ZBDIyZPjguonV0RE+Sh4qQ3pRe31xF
 ZlaV9kRFOWRvXRY7FmxQAuyYVUTYiTnTsP9w1TZlXihj85ID6YvfNOjlzoEHFGYkzSqc3BSj00s
 RUQjl9C6sObqJQLzyjNQ+vLZvbTGglozn/UIxwACuN8DekC94P3ryuudNBhkBnQI90rfIcC5iXp
 eEBtDp3t2g/w236rgIsRNyeQuUAKHM2COLzX1dXpNIEWHcGtYTj1IP2vvCPyJn9l8B0rrWmtIq2
 67hIY0i/bGycliXP7z6QuyMsMOilCvCiCADcO5IeSJQ2uYgpOP2DAIEWS7mivjrv5bJap22Yqi/
 w==
X-Google-Smtp-Source: AGHT+IFAHGXsbaZjIlCXLI6Ph5ry1+DdCk10bRIvPraYrorrnJzYaOXe/wQzB7aj2HvGyQw6keVNjw==
X-Received: by 2002:a05:600c:3b20:b0:477:fad:acd9 with SMTP id
 5b1f17b1804b1-4778fea2114mr150387905e9.34.1763453136653; 
 Tue, 18 Nov 2025 00:05:36 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:366e:5264:fffe:1c49?
 ([2a01:e0a:3d9:2080:366e:5264:fffe:1c49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a96aed1esm12527725e9.0.2025.11.18.00.05.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 00:05:35 -0800 (PST)
Message-ID: <511f810f-c862-4f27-b6ce-6c8dd4444a83@linaro.org>
Date: Tue, 18 Nov 2025 09:05:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 1/1] regulator: qcom-rpmh-regulator: add support for
 PM8150 PM8350 PM7325
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, jh80.chung@samsung.com,
 peng.fan@nxp.com, casey.connolly@linaro.org, sumit.garg@kernel.org,
 trini@konsulko.com, luca.weiss@fairphone.com, quic_varada@quicinc.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20251112164204.1557934-1-aswin.murugan@oss.qualcomm.com>
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
In-Reply-To: <20251112164204.1557934-1-aswin.murugan@oss.qualcomm.com>
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

On 11/12/25 17:42, Aswin Murugan wrote:
> Add the PM8150, PM8350, and PM7325 regulator data found on Qualcomm
> platforms. These regulator tables are imported from the Linux driver
> to enable support for these PMICs in U-Boot.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>   drivers/power/regulator/qcom-rpmh-regulator.c | 130 ++++++++++++++++++
>   1 file changed, 130 insertions(+)
> 
> diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
> index 06466142560..b16cbccbfc4 100644
> --- a/drivers/power/regulator/qcom-rpmh-regulator.c
> +++ b/drivers/power/regulator/qcom-rpmh-regulator.c
> @@ -402,6 +402,42 @@ static const struct rpmh_vreg_hw_data pmic5_bob = {
>   	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic5_bob),
>   };
>   
> +static const struct rpmh_vreg_hw_data pmic5_hfsmps510 = {
> +	.regulator_type = VRM,
> +	.ops = &rpmh_regulator_vrm_drms_ops,
> +	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
> +	.n_voltages = 216,
> +	.pmic_mode_map = pmic_mode_map_pmic5_smps,
> +	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic5_smps),
> +};
> +
> +static const struct rpmh_vreg_hw_data pmic5_hfsmps515 = {
> +	.regulator_type = VRM,
> +	.ops = &rpmh_regulator_vrm_drms_ops,
> +	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 235, 16000),
> +	.n_voltages = 236,
> +	.pmic_mode_map = pmic_mode_map_pmic5_smps,
> +	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic5_smps),
> +};
> +
> +static const struct rpmh_vreg_hw_data pmic5_ftsmps510 = {
> +	.regulator_type = VRM,
> +	.ops = &rpmh_regulator_vrm_drms_ops,
> +	.voltage_range = REGULATOR_LINEAR_RANGE(300000, 0, 263, 4000),
> +	.n_voltages = 264,
> +	.pmic_mode_map = pmic_mode_map_pmic5_smps,
> +	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic5_smps),
> +};
> +
> +static const struct rpmh_vreg_hw_data pmic5_ftsmps520 = {
> +	.regulator_type = VRM,
> +	.ops = &rpmh_regulator_vrm_drms_ops,
> +	.voltage_range = REGULATOR_LINEAR_RANGE(300000, 0, 263, 4000),
> +	.n_voltages = 264,
> +	.pmic_mode_map = pmic_mode_map_pmic5_smps,
> +	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic5_smps),
> +};
> +
>   static const struct rpmh_vreg_hw_data pmic5_ftsmps525_lv = {
>   	.regulator_type = VRM,
>   	.ops = &rpmh_regulator_vrm_drms_ops,
> @@ -521,7 +557,34 @@ static const struct rpmh_vreg_init_data pm6150l_vreg_data[] = {
>   };
>   
>   static const struct rpmh_vreg_init_data pm8150_vreg_data[] = {
> +	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps510, "vdd-s1"),
> +	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps510, "vdd-s2"),
> +	RPMH_VREG("smps3",  "smp%s3",  &pmic5_ftsmps510, "vdd-s3"),
> +	RPMH_VREG("smps4",  "smp%s4",  &pmic5_hfsmps510, "vdd-s4"),
> +	RPMH_VREG("smps5",  "smp%s5",  &pmic5_hfsmps510, "vdd-s5"),
> +	RPMH_VREG("smps6",  "smp%s6",  &pmic5_ftsmps510, "vdd-s6"),
> +	RPMH_VREG("smps7",  "smp%s7",  &pmic5_ftsmps510, "vdd-s7"),
> +	RPMH_VREG("smps8",  "smp%s8",  &pmic5_ftsmps510, "vdd-s8"),
> +	RPMH_VREG("smps9",  "smp%s9",  &pmic5_ftsmps510, "vdd-s9"),
> +	RPMH_VREG("smps10", "smp%s10", &pmic5_ftsmps510, "vdd-s10"),
> +	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo,      "vdd-l1-l8-l11"),
> +	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_pldo,      "vdd-l2-l10"),
> +	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,      "vdd-l3-l4-l5-l18"),
> +	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo,      "vdd-l3-l4-l5-l18"),
> +	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_nldo,      "vdd-l3-l4-l5-l18"),
> +	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_nldo,      "vdd-l6-l9"),
> +	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo,      "vdd-l7-l12-l14-l15"),
> +	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_nldo,      "vdd-l1-l8-l11"),
> +	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_nldo,      "vdd-l6-l9"),
> +	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_pldo,      "vdd-l2-l10"),
> +	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_nldo,      "vdd-l1-l8-l11"),
> +	RPMH_VREG("ldo12",  "ldo%s12", &pmic5_pldo_lv,   "vdd-l7-l12-l14-l15"),
>   	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_pldo,      "vdd-l13-l16-l17"),
> +	RPMH_VREG("ldo14",  "ldo%s14", &pmic5_pldo_lv,   "vdd-l7-l12-l14-l15"),
> +	RPMH_VREG("ldo15",  "ldo%s15", &pmic5_pldo_lv,   "vdd-l7-l12-l14-l15"),
> +	RPMH_VREG("ldo16",  "ldo%s16", &pmic5_pldo,      "vdd-l13-l16-l17"),
> +	RPMH_VREG("ldo17",  "ldo%s17", &pmic5_pldo,      "vdd-l13-l16-l17"),
> +	RPMH_VREG("ldo18",  "ldo%s18", &pmic5_nldo,      "vdd-l3-l4-l5-l18"),
>   	{}
>   };
>   
> @@ -626,6 +689,65 @@ static const struct rpmh_vreg_init_data pmm8654au_vreg_data[] = {
>   	{}
>   };
>   
> +static const struct rpmh_vreg_init_data pm8350c_vreg_data[] = {
> +	RPMH_VREG("smps1",  "smp%s1",  &pmic5_hfsmps515, "vdd-s1"),
> +	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps510, "vdd-s2"),
> +	RPMH_VREG("smps3",  "smp%s3",  &pmic5_ftsmps510, "vdd-s3"),
> +	RPMH_VREG("smps4",  "smp%s4",  &pmic5_ftsmps510, "vdd-s4"),
> +	RPMH_VREG("smps5",  "smp%s5",  &pmic5_ftsmps510, "vdd-s5"),
> +	RPMH_VREG("smps6",  "smp%s6",  &pmic5_ftsmps510, "vdd-s6"),
> +	RPMH_VREG("smps7",  "smp%s7",  &pmic5_ftsmps510, "vdd-s7"),
> +	RPMH_VREG("smps8",  "smp%s8",  &pmic5_ftsmps510, "vdd-s8"),
> +	RPMH_VREG("smps9",  "smp%s9",  &pmic5_ftsmps510, "vdd-s9"),
> +	RPMH_VREG("smps10", "smp%s10", &pmic5_ftsmps510, "vdd-s10"),
> +	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_pldo_lv,   "vdd-l1-l12"),
> +	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_pldo_lv,   "vdd-l2-l8"),
> +	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_pldo,      "vdd-l3-l4-l5-l7-l13"),
> +	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_pldo,      "vdd-l3-l4-l5-l7-l13"),
> +	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo,      "vdd-l3-l4-l5-l7-l13"),
> +	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo,      "vdd-l6-l9-l11"),
> +	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo,      "vdd-l3-l4-l5-l7-l13"),
> +	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_pldo_lv,   "vdd-l2-l8"),
> +	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_pldo,      "vdd-l6-l9-l11"),
> +	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_nldo,      "vdd-l10"),
> +	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_pldo,      "vdd-l6-l9-l11"),
> +	RPMH_VREG("ldo12",  "ldo%s12", &pmic5_pldo_lv,   "vdd-l1-l12"),
> +	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_pldo,      "vdd-l3-l4-l5-l7-l13"),
> +	RPMH_VREG("bob",    "bob%s1",  &pmic5_bob,       "vdd-bob"),
> +	{}
> +};
> +
> +static const struct rpmh_vreg_init_data pm7325_vreg_data[] = {
> +	RPMH_VREG("smps1",  "smp%s1",  &pmic5_hfsmps510, "vdd-s1"),
> +	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps520, "vdd-s2"),
> +	RPMH_VREG("smps3",  "smp%s3",  &pmic5_ftsmps520, "vdd-s3"),
> +	RPMH_VREG("smps4",  "smp%s4",  &pmic5_ftsmps520, "vdd-s4"),
> +	RPMH_VREG("smps5",  "smp%s5",  &pmic5_ftsmps520, "vdd-s5"),
> +	RPMH_VREG("smps6",  "smp%s6",  &pmic5_ftsmps520, "vdd-s6"),
> +	RPMH_VREG("smps7",  "smp%s7",  &pmic5_ftsmps520, "vdd-s7"),
> +	RPMH_VREG("smps8",  "smp%s8",  &pmic5_hfsmps510, "vdd-s8"),
> +	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo,      "vdd-l1-l4-l12-l15"),
> +	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_pldo,      "vdd-l2-l7"),
> +	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,      "vdd-l3"),
> +	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo,      "vdd-l1-l4-l12-l15"),
> +	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_nldo,      "vdd-l5"),
> +	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_nldo,      "vdd-l6-l9-l10"),
> +	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo,      "vdd-l2-l7"),
> +	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_nldo,      "vdd-l8"),
> +	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_nldo,      "vdd-l6-l9-l10"),
> +	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_nldo,      "vdd-l6-l9-l10"),
> +	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_pldo_lv,   "vdd-l11-l17-l18-l19"),
> +	RPMH_VREG("ldo12",  "ldo%s12", &pmic5_nldo,      "vdd-l1-l4-l12-l15"),
> +	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_nldo,      "vdd-l13"),
> +	RPMH_VREG("ldo14",  "ldo%s14", &pmic5_nldo,      "vdd-l14-l16"),
> +	RPMH_VREG("ldo15",  "ldo%s15", &pmic5_nldo,      "vdd-l1-l4-l12-l15"),
> +	RPMH_VREG("ldo16",  "ldo%s16", &pmic5_nldo,      "vdd-l14-l16"),
> +	RPMH_VREG("ldo17",  "ldo%s17", &pmic5_pldo_lv,   "vdd-l11-l17-l18-l19"),
> +	RPMH_VREG("ldo18",  "ldo%s18", &pmic5_pldo_lv,   "vdd-l11-l17-l18-l19"),
> +	RPMH_VREG("ldo19",  "ldo%s19", &pmic5_pldo_lv,   "vdd-l11-l17-l18-l19"),
> +	{}
> +};
> +
>   /* probe an individual regulator */
>   static int rpmh_regulator_probe(struct udevice *dev)
>   {
> @@ -736,6 +858,10 @@ static const struct udevice_id rpmh_regulator_ids[] = {
>   		.compatible = "qcom,pm6150l-rpmh-regulators",
>   		.data = (ulong)pm6150l_vreg_data,
>   	},
> +	{
> +		.compatible = "qcom,pm7325-rpmh-regulators",
> +		.data = (ulong)pm7325_vreg_data,
> +	},
>   	{
>   		.compatible = "qcom,pm8150-rpmh-regulators",
>   		.data = (ulong)pm8150_vreg_data,
> @@ -744,6 +870,10 @@ static const struct udevice_id rpmh_regulator_ids[] = {
>   		.compatible = "qcom,pm8150l-rpmh-regulators",
>   		.data = (ulong)pm8150l_vreg_data,
>   	},
> +	{
> +		.compatible = "qcom,pm8350c-rpmh-regulators",
> +		.data = (ulong)pm8350c_vreg_data,
> +	},
>   	{
>   		.compatible = "qcom,pm8550-rpmh-regulators",
>   		.data = (ulong)pm8550_vreg_data,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
