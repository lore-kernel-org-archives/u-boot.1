Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E803C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 14:03:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A139C81101;
	Mon, 17 Mar 2025 15:03:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WrUm00A1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0608D81101; Mon, 17 Mar 2025 15:03:13 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C833F80107
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 15:03:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3995ff6b066so893914f8f.3
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 07:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742220190; x=1742824990; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=1huRy8BAZoO0RiA4KLA2Pw7IwXgKkbmWmLlx5NhKVk0=;
 b=WrUm00A1bO3HlDTfgGpj5WXB5myykB9u+/XJLqgkU3d7b9TFTW/8w6+umFHHgdUFa4
 4/SNHDMYQzggfmk4iRwJAM+8onrviXqDGprUBthg1vgmcUq2OqCEqhc8YO8KXdFCS7Yr
 NjWhlYT0WwEMMf9+NmxSHlYhLsbW6sskprMeMFZopSbeE1XwDowUiLS61UOsKJAKOOaU
 0wR3ZD8nqfpp7Kh+tOnOhf2QhCzompj386+ll+jSjRswmYIZ6fImeCMpQw95gC9Q23Pn
 nem7HCYiV6YRHn+eeEZ37Ti8eBa30hMI66MZtbvopvxSfknckP+8ReMcvaKRaZwsLTFN
 cUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742220190; x=1742824990;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1huRy8BAZoO0RiA4KLA2Pw7IwXgKkbmWmLlx5NhKVk0=;
 b=hhB5JdTMyGy5fC47nHV8NtzlwE07jKkAH+ioOlYiLF25vK1Zo7BbCF1gMCnzikUwrQ
 DALmijiYESkUNqJVaNxwVHy+Kenq9ClmRwI0UfJzk178L4bwaS/iuxRgRqeOw+0f75GU
 OlCsz3myldS92uPiTFIdA1c94ZxCGa4YjxWnN4Qs7H3Bp5GrrYc6dlBjqzTmMHEMp4CN
 /wrqYB0W+eH8eCQ+M8gpocqLX3NCBPgFl4zTUq2l4QxneEmgJPV/frvap7D4TZaRLSVI
 osgmkIgcXZRTyLgthyWHxzQGZhlYJ928egBNpEo2PmeGv6S7IdEGLmmR98V/Gb1pYv4T
 54/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrmqYah30AqA/Bg3uv99os+niIMwaM8aMmB8F3hWj+YGNyQgyvE+GaBhSVU9coqgjqECKgnB4=@lists.denx.de
X-Gm-Message-State: AOJu0YzYhcB3dfN7o+dLGQ9HQcYATXw6dbe4Z7Bw8VhPlSOhK9UkuzXB
 cCCMBHuORnfNnW4g+MwfE3AbmJorI2YMxPWJEQvf7DPn8OtY2oUiMTebmQQB8/s=
X-Gm-Gg: ASbGncsn62ZkL6BCEuVThgt15uklDGrQUpAzE39gz+X+X4V5n3hTWjQwPvr/mhb8MZG
 /0O+c0P1aZ9/Cg8xouyj4tZYJDKXi3DQYAeULn2os+mmfI3k9iSK78mt/8i4BMQ+Bibc3x36mHU
 q5M8XJdAAK6vfKrprrRWmfX52cbd2fMgzyIiP3jPgm2YIwrcebOnaKQWkPbMNWa4ui+NuB6RLdI
 PinX677MucXAlyz4lC2kJ7TNUhXcn/jBuCS3Zt0NuBg7iGCSHYUq5/JqhdDHqGWTLLko6EPU27+
 Bq4MJPrDeKTzxYWCadmvDh9jo7IY70/hBlPzeugl/+37aSKYl0F9PRjnqsa8a1a2CfXyMIJb+yZ
 6DE6cIV8la7agdIOgZmZqfmVOxjTHEOEl
X-Google-Smtp-Source: AGHT+IGT/KnYroBKVS71/M9ylLUzb3VvU/zq/fu/JfTKDPvRckRFQdtALSyWGBEMQL1DJhQbEVW4pw==
X-Received: by 2002:a05:6000:1545:b0:391:2e6a:30de with SMTP id
 ffacd0b85a97d-3971e971991mr15818776f8f.19.1742220190134; 
 Mon, 17 Mar 2025 07:03:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:1a77:b55f:a550:458c?
 ([2a01:e0a:3d9:2080:1a77:b55f:a550:458c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c8975febsm15455843f8f.59.2025.03.17.07.03.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 07:03:09 -0700 (PDT)
Message-ID: <9c1f0efe-c92d-44fc-91fc-7cdac6392e3e@linaro.org>
Date: Mon, 17 Mar 2025 15:03:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/3] clk/qcom: sc7280: add GENI, PCIe, and more USB clocks
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250314-sc7280-more-clocks-v1-0-ead54487c38e@linaro.org>
 <20250314-sc7280-more-clocks-v1-3-ead54487c38e@linaro.org>
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
In-Reply-To: <20250314-sc7280-more-clocks-v1-3-ead54487c38e@linaro.org>
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

On 14/03/2025 16:31, Caleb Connolly wrote:
> Add support for a bunch of new clocks, including PCIe, GENI (for all
> peripherals used on the RB3 Gen 2), and some missing USB clocks.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/clk/qcom/clock-sc7280.c | 104 +++++++++++++++++++++++++++++++++++-----
>   1 file changed, 93 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
> index 2cbc01b6e0a4f1db0e4a894cd869b532d6b3fa45..8691f08109b39639d8a5defe75161049399bf682 100644
> --- a/drivers/clk/qcom/clock-sc7280.c
> +++ b/drivers/clk/qcom/clock-sc7280.c
> @@ -15,31 +15,66 @@
>   #include <dt-bindings/clock/qcom,gcc-sc7280.h>
>   
>   #include "clock-qcom.h"
>   
> -#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf038
>   #define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf020
> +#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf038
> +#define USB30_SEC_MASTER_CLK_CMD_RCGR 0x9e020
> +#define USB30_SEC_MOCK_UTMI_CLK_CMD_RCGR 0x9e038
> +#define PCIE_1_AUX_CLK_CMD_RCGR 0x8d058
> +#define PCIE1_PHY_RCHNG_CMD_RCGR 0x8d03c
> +#define PCIE_1_PIPE_CLK_PHY_MUX 0x8d054
> +
> +static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
> +	F(66666667, CFG_CLK_SRC_GPLL0_EVEN, 4.5, 0, 0),
> +	F(133333333, CFG_CLK_SRC_GPLL0, 4.5, 0, 0),
> +	F(200000000, CFG_CLK_SRC_GPLL0_ODD, 1, 0, 0),
> +	F(240000000, CFG_CLK_SRC_GPLL0, 2.5, 0, 0),
> +	{ }
> +};
> +
> +static const struct freq_tbl ftbl_gcc_usb30_sec_master_clk_src[] = {
> +	F(60000000, CFG_CLK_SRC_GPLL0_EVEN, 5, 0, 0),
> +	F(120000000, CFG_CLK_SRC_GPLL0_EVEN, 2.5, 0, 0),
> +	{ }
> +};
>   
>   static ulong sc7280_set_rate(struct clk *clk, ulong rate)
>   {
>   	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +	const struct freq_tbl *freq;
>   
>   	if (clk->id < priv->data->num_clks)
>   		debug("%s: %s, requested rate=%ld\n", __func__, priv->data->clks[clk->id].name, rate);
>   
>   	switch (clk->id) {
> -	case GCC_USB30_PRIM_MOCK_UTMI_CLK:
> -		WARN(rate != 19200000, "Unexpected rate for USB30_PRIM_MOCK_UTMI_CLK: %lu\n", rate);
> -		clk_rcg_set_rate(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
> -		return rate;
>   	case GCC_USB30_PRIM_MASTER_CLK:
> -		WARN(rate != 200000000, "Unexpected rate for USB30_PRIM_MASTER_CLK: %lu\n", rate);
> +		freq = qcom_find_freq(ftbl_gcc_usb30_prim_master_clk_src, rate);
>   		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
> -				     1, 0, 0, CFG_CLK_SRC_GPLL0_ODD, 8);
> -		clk_rcg_set_rate(priv->base, 0xf064, 0, 0);
> -		return rate;
> +				     freq->pre_div, freq->m, freq->n, freq->src, 8);
> +		return freq->freq;
> +	case GCC_USB30_PRIM_MOCK_UTMI_CLK:
> +		clk_rcg_set_rate(priv->base, USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR, 1, 0);
> +		return 19200000;
> +	case GCC_USB3_PRIM_PHY_AUX_CLK_SRC:
> +		clk_rcg_set_rate(priv->base, USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR, 1, 0);
> +		return 19200000;
> +	case GCC_USB30_SEC_MASTER_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_usb30_sec_master_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, USB30_SEC_MASTER_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 8);
> +		return freq->freq;
> +	case GCC_USB30_SEC_MOCK_UTMI_CLK:
> +		clk_rcg_set_rate(priv->base, USB30_SEC_MOCK_UTMI_CLK_CMD_RCGR, 1, 0);
> +		return 19200000;
> +	case GCC_USB3_SEC_PHY_AUX_CLK_SRC:
> +		clk_rcg_set_rate(priv->base, USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR, 1, 0);
> +		return 19200000;
> +	case GCC_PCIE1_PHY_RCHNG_CLK:
> +		clk_rcg_set_rate(priv->base, PCIE1_PHY_RCHNG_CMD_RCGR, 5, CFG_CLK_SRC_GPLL0_EVEN);
> +		return 100000000;
>   	default:
> -		return 0;
> +		return rate;
>   	}
>   }
>   
>   static const struct gate_clk sc7280_clks[] = {
> @@ -49,15 +84,37 @@ static const struct gate_clk sc7280_clks[] = {
>   	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0xf018, 1),
>   	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0xf01c, 1),
>   	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf054, 1),
>   	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf058, 1),
> +	GATE_CLK(GCC_CFG_NOC_USB3_SEC_AXI_CLK, 0x9e07c, 1),
> +	GATE_CLK(GCC_USB30_SEC_MASTER_CLK, 0x9e010, 1),
> +	GATE_CLK(GCC_AGGRE_USB3_SEC_AXI_CLK, 0x9e080, 1),
> +	GATE_CLK(GCC_USB30_SEC_SLEEP_CLK, 0x9e018, 1),
> +	GATE_CLK(GCC_USB30_SEC_MOCK_UTMI_CLK, 0x9e01c, 1),
> +	GATE_CLK(GCC_USB3_SEC_PHY_AUX_CLK, 0x9e054, 1),
> +	GATE_CLK(GCC_USB3_SEC_PHY_COM_AUX_CLK, 0x9e058, 1),
> +	GATE_CLK(GCC_PCIE_CLKREF_EN, 0x8c004, 1),
> +	GATE_CLK(GCC_PCIE_1_PIPE_CLK, 0x52000, BIT(30)),
> +	GATE_CLK(GCC_PCIE_1_AUX_CLK, 0x52000, BIT(29)),
> +	GATE_CLK(GCC_PCIE_1_CFG_AHB_CLK, 0x52000, BIT(28)),
> +	GATE_CLK(GCC_PCIE_1_MSTR_AXI_CLK, 0x52000, BIT(27)),
> +	GATE_CLK(GCC_PCIE_1_SLV_AXI_CLK, 0x52000, BIT(26)),
> +	GATE_CLK(GCC_PCIE_1_SLV_Q2A_AXI_CLK, 0x52000, BIT(25)),
> +	GATE_CLK(GCC_PCIE1_PHY_RCHNG_CLK, 0x52000, BIT(23)),
> +	GATE_CLK(GCC_DDRSS_PCIE_SF_CLK, 0x52000, BIT(19)),
> +	GATE_CLK(GCC_AGGRE_NOC_PCIE_TBU_CLK, 0x52000, BIT(18)),
> +	GATE_CLK(GCC_AGGRE_NOC_PCIE_1_AXI_CLK, 0x52000, BIT(11)),
> +	GATE_CLK(GCC_AGGRE_NOC_PCIE_CENTER_SF_AXI_CLK, 0x52008, BIT(28)),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x52008, BIT(10)),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x52008, BIT(11)),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK, 0x52008, BIT(13)),
>   };
>   
>   static int sc7280_enable(struct clk *clk)
>   {
>   	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
>   
> -	if (priv->data->num_clks < clk->id) {
> +	if (priv->data->num_clks <= clk->id) {
>   		debug("%s: unknown clk id %lu\n", __func__, clk->id);
>   		return 0;
>   	}
>   
> @@ -70,8 +127,31 @@ static int sc7280_enable(struct clk *clk)
>   	case GCC_USB30_PRIM_MASTER_CLK:
>   		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_AUX_CLK);
>   		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
>   		break;
> +	case GCC_AGGRE_USB3_SEC_AXI_CLK:
> +		qcom_gate_clk_en(priv, GCC_USB30_SEC_MASTER_CLK);
> +		fallthrough;
> +	case GCC_USB30_SEC_MASTER_CLK:
> +		qcom_gate_clk_en(priv, GCC_USB3_SEC_PHY_AUX_CLK);
> +		qcom_gate_clk_en(priv, GCC_USB3_SEC_PHY_COM_AUX_CLK);
> +		break;
> +	case GCC_PCIE_1_PIPE_CLK:
> +		clk_phy_mux_enable(priv->base, PCIE_1_PIPE_CLK_PHY_MUX, true);
> +		break;
> +	case GCC_PCIE_1_AUX_CLK:
> +		clk_rcg_set_rate_mnd(priv->base, PCIE_1_AUX_CLK_CMD_RCGR, 1, 0, 0,
> +				     CFG_CLK_SRC_CXO, 16);
> +		break;
> +	case GCC_QUPV3_WRAP0_S0_CLK:
> +		clk_rcg_set_rate_mnd(priv->base, 0x17010, 1, 0, 0, CFG_CLK_SRC_CXO, 16);
> +		break;
> +	case GCC_QUPV3_WRAP0_S1_CLK:
> +		clk_rcg_set_rate_mnd(priv->base, 0x17140, 1, 0, 0, CFG_CLK_SRC_CXO, 16);
> +		break;
> +	case GCC_QUPV3_WRAP0_S3_CLK:
> +		clk_rcg_set_rate_mnd(priv->base, 0x173a0, 1, 0, 0, CFG_CLK_SRC_CXO, 16);
> +		break;
>   	}
>   
>   	return qcom_gate_clk_en(priv, clk->id);
>   }
> @@ -97,8 +177,10 @@ static const struct qcom_reset_map sc7280_gcc_resets[] = {
>   
>   static const struct qcom_power_map sc7280_gdscs[] = {
>   	[GCC_UFS_PHY_GDSC] = { 0x77004 },
>   	[GCC_USB30_PRIM_GDSC] = { 0xf004 },
> +	[GCC_USB30_SEC_GDSC] = { 0x9e004 },
> +	[GCC_PCIE_1_GDSC] = { 0x8d004 },
>   };
>   
>   static const phys_addr_t sc7280_rcg_addrs[] = {
>   	0x10f020, // USB30_PRIM_MASTER_CLK_CMD_RCGR
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
