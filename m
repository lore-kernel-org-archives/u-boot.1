Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C778EC7115B
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 08:54:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B59382CBC;
	Fri, 20 Jun 2025 10:54:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NyE7JA4b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E028E82CF4; Fri, 20 Jun 2025 10:54:14 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC69F80E9A
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 10:54:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a589d99963so1584103f8f.1
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 01:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750409652; x=1751014452; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=KNHq+ILn+GqjpN4w0bedpw4Yhb+W4uwjgb0z95pL/Pc=;
 b=NyE7JA4bBQq2SuTB6MhpKEWSHdwWnQTfR702f3RvYFxFfIADvEuUh33XP2RqNfS7zm
 Ifo5F5XL+3GYeNn7ccO8+w/AW7vY6FONRKuGj7nC4ES56rt/YrwefZ9farqhurVbpbsd
 ulJrR2BEjoYMuyud8TNkAY4tWVhm+Pdz+qoQ7JxjauePpMh7kpLHmwvwDurSwHGc5p7/
 CDNdY5ba+NUKkt3mdsOSuB7VEv+MER7vPA7TWOEDbOktrr54YjDUsAj3oRzoi0KJo6/H
 2QZfyVg9W4rYih5BZrE8yru4JIn5mTGmGUcw0/y5wSONxlM30ViYV32RbmYaWye3t6vS
 wZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750409652; x=1751014452;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=KNHq+ILn+GqjpN4w0bedpw4Yhb+W4uwjgb0z95pL/Pc=;
 b=QwstdwYeVXYZn5fRGQOHrq5qMdOTa0BcD2mBO/6+q5G1+S29aw/JifadlWzDtpYtky
 mT582fKu1jhESIyrlP6QJ1nb2Ty9raOgivE3N4bcwIS9LfG01FARBK96QoJoVBfRtQeH
 zadtE9qf8wOFkbl+Kt6Xzg1OqWTE4ATk2ZQOdAjtjLKp9ob+tt0niwW0yFzAej9zwrqC
 goL0fJl8JYUzMkkM/YWLetEZZnsVrgSZs+22T2F/XoooTEIssrrzo3Hzbi0H6OHroWY6
 aD6RX5pY5VZT7f/o/MGnwLyCVdVL3EsaI9PQp3MkENeDFrfvvQ5lNN+MxV1IUDYPCukl
 y90w==
X-Gm-Message-State: AOJu0Yyoz9zApcZu+1tJjR/w3hNQxLBcP2Fth8hZ76cWFIZSplWZYF2c
 0dUbhmSrwWFoK4460D0O+vWJZz+Z535vEBWBMl+knqKFw3k/JKVFNRDcamXUD0ZieSE=
X-Gm-Gg: ASbGncvUJwShC2vtqpZRaUfeex2D4XK3iAoX/QMKyU0ysv7GRm7yyFCF2CK50ceFXbu
 hWmBufh4x33z4DykE1Q+Cg8+lR9JILpdnh3ni9SeOFq64FnP8wXHMRN8w5j1k614oXUt26hRFoD
 y59TMIe1S9dcl9aJKeaD3kry8pKIXTi8vRZrjXxX32e62sp1CmQVNO28XOHpsIOpGyyy1MJ2TqQ
 40KXuxZnyhJ82vDdAsv5rvqH5Y2rIxLS39VVMZP6sOVDG45qM5/ItYa7nMoyIwBt/CmQ2G8QKB+
 5sfRlMeE9qZMPUt+KLdaWCdoTgu8DlOLJY5vYUIe8cjaayu1yuktJPNLPp+q8t6N9CwT1+lTeW8
 CBUEEsmJ+ERYqXO+QhW+ZnTw+5l2PRWHuzCEcSfo=
X-Google-Smtp-Source: AGHT+IGrrK17Ea52PRLFM3ehzv8O4ffpqMl1bsy7DGudRtQgGwFCICIkeS4N+lOZhNxK4IcRJGpXSg==
X-Received: by 2002:a05:6000:2301:b0:3a3:4baa:3f3d with SMTP id
 ffacd0b85a97d-3a6d128a42fmr1350813f8f.6.1750409651934; 
 Fri, 20 Jun 2025 01:54:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3d60:2fa3:b982:4627?
 ([2a01:e0a:3d9:2080:3d60:2fa3:b982:4627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f18207sm1489293f8f.30.2025.06.20.01.54.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Jun 2025 01:54:11 -0700 (PDT)
Message-ID: <7ba396a4-d248-41bd-ace2-6d8f5c4c3bda@linaro.org>
Date: Fri, 20 Jun 2025 10:54:11 +0200
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
In-Reply-To: <20250618-sm6350-bringup-v1-1-3cc22aab7a7a@fairphone.com>
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
> Add Clock driver for the GCC block found in the SM6350 SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   drivers/clk/qcom/Kconfig        |   8 ++
>   drivers/clk/qcom/Makefile       |   1 +
>   drivers/clk/qcom/clock-sm6350.c | 194 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 203 insertions(+)
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 3ea01f3c969a3456a7c2ebf731b8b74b66d93f96..e0e91dadd854e6e3a7beb1ef351734a5ab77787f 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -79,6 +79,14 @@ config CLK_QCOM_SM6115
>   	  on the Snapdragon SM6115 SoC. This driver supports the clocks
>   	  and resets exposed by the GCC hardware block.
>   
> +config CLK_QCOM_SM6350
> +	bool "Qualcomm SM6350 GCC"
> +	select CLK_QCOM
> +	help
> +	  Say Y here to enable support for the Global Clock Controller
> +	  on the Snapdragon SM6350 SoC. This driver supports the clocks
> +	  and resets exposed by the GCC hardware block.
> +
>   config CLK_QCOM_SM8150
>   	bool "Qualcomm SM8150 GCC"
>   	select CLK_QCOM
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index e13fc8c107176000e14e3a2c56fcd25dac8b9df4..5807caa7e040cb3ea494943b1077a50e684b88f4 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
>   obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
>   obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
>   obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
> +obj-$(CONFIG_CLK_QCOM_SM6350) += clock-sm6350.o
>   obj-$(CONFIG_CLK_QCOM_SM8150) += clock-sm8150.o
>   obj-$(CONFIG_CLK_QCOM_SM8250) += clock-sm8250.o
>   obj-$(CONFIG_CLK_QCOM_SM8550) += clock-sm8550.o
> diff --git a/drivers/clk/qcom/clock-sm6350.c b/drivers/clk/qcom/clock-sm6350.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..2218d81f1532b38f9b9759dc4d1304504657439a
> --- /dev/null
> +++ b/drivers/clk/qcom/clock-sm6350.c
> @@ -0,0 +1,194 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Clock drivers for Qualcomm sm6350
> + *
> + * (C) Copyright 2024 Linaro Ltd.
> + * (C) Copyright 2025 Luca Weiss <luca.weiss@fairphone.com>
> + */
> +
> +#include <clk-uclass.h>
> +#include <dm.h>
> +#include <linux/delay.h>
> +#include <asm/io.h>
> +#include <linux/bug.h>
> +#include <linux/bitops.h>
> +#include <dt-bindings/clock/qcom,gcc-sm6350.h>
> +
> +#include "clock-qcom.h"
> +
> +#undef CFG_CLK_SRC_GPLL0_ODD
> +#define CFG_CLK_SRC_GPLL0_ODD (2 << 8)
> +#define CFG_CLK_SRC_GPLL6_EVEN (2 << 8)
> +
> +#define GCC_SE12_UART_RCG_REG 0x223a8
> +#define GCC_SDCC2_APPS_CLK_SRC_REG 0x2000c
> +
> +#define APCS_GPLL7_STATUS 0x7000
> +#define APCS_GPLLX_ENA_REG 0x52010
> +
> +static const struct freq_tbl ftbl_gcc_qupv3_wrap1_s3_clk_src[] = {
> +	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
> +	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
> +	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
> +	F(29491200, CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
> +	F(32000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 75),
> +	F(48000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 25),
> +	F(64000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 16, 75),
> +	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
> +	F(80000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 15),
> +	F(96000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 25),
> +	F(100000000, CFG_CLK_SRC_GPLL0_EVEN, 3, 0, 0),
> +	F(102400000, CFG_CLK_SRC_GPLL0_EVEN, 1, 128, 375),
> +	F(112000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 28, 75),
> +	F(117964800, CFG_CLK_SRC_GPLL0_EVEN, 1, 6144, 15625),
> +	F(120000000, CFG_CLK_SRC_GPLL0_EVEN, 2.5, 0, 0),
> +	F(128000000, CFG_CLK_SRC_GPLL6_EVEN, 3, 0, 0),
> +	{}
> +};
> +
> +static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
> +	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
> +	F(9600000, CFG_CLK_SRC_CXO, 2, 0, 0),
> +	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
> +	F(25000000, CFG_CLK_SRC_GPLL0_ODD, 8, 0, 0),
> +	F(50000000, CFG_CLK_SRC_GPLL0_ODD, 4, 0, 0),
> +	F(100000000, CFG_CLK_SRC_GPLL0_ODD, 2, 0, 0),
> +	F(202000000, CFG_CLK_SRC_GPLL7, 4, 0, 0),
> +	{}
> +};
> +
> +static struct pll_vote_clk gpll7_vote_clk = {
> +	.status = APCS_GPLL7_STATUS,
> +	.status_bit = BIT(31),
> +	.ena_vote = APCS_GPLLX_ENA_REG,
> +	.vote_bit = BIT(7),
> +};
> +
> +static ulong sm6350_set_rate(struct clk *clk, ulong rate)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +	const struct freq_tbl *freq;
> +
> +	if (clk->id < priv->data->num_clks)
> +		debug("%s: %s, requested rate=%ld\n", __func__,
> +		      priv->data->clks[clk->id].name, rate);
> +
> +	switch (clk->id) {
> +	case GCC_QUPV3_WRAP1_S3_CLK: /*UART9*/
> +		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap1_s3_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, GCC_SE12_UART_RCG_REG,
> +				     freq->pre_div, freq->m, freq->n, freq->src,
> +				     16);
> +
> +		return freq->freq;
> +	case GCC_SDCC2_APPS_CLK:
> +		/* Enable GPLL7 so that we can point SDCC2_APPS_CLK_SRC at it */
> +		clk_enable_gpll0(priv->base, &gpll7_vote_clk);
> +		freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
> +		printf("%s: got freq %u\n", __func__, freq->freq);
> +		WARN(freq->src != CFG_CLK_SRC_GPLL7,
> +		     "SDCC2_APPS_CLK_SRC not set to GPLL7, requested rate %lu\n",
> +		     rate);

Why not enabling GPLL7 only if freq->src == CFG_CLK_SRC_GPLL7 ??

> +		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC2_APPS_CLK_SRC_REG,
> +				     freq->pre_div, freq->m, freq->n,
> +				     CFG_CLK_SRC_GPLL7, 8);
> +
> +		return rate;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static const struct gate_clk sm6350_clks[] = {
> +	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x3e014, 0x00000001),
> +	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0x3e010, 0x00000001),
> +	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x1101c, 0x00000001),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S3_CLK, 0x52000, 0x00800000),
> +	GATE_CLK(GCC_QUPV3_WRAP_1_M_AHB_CLK, 0x52000, 0x00040000),
> +	GATE_CLK(GCC_QUPV3_WRAP_1_S_AHB_CLK, 0x52000, 0x00080000),
> +	GATE_CLK(GCC_SDCC2_AHB_CLK, 0x20008, 0x00000001),
> +	GATE_CLK(GCC_SDCC2_APPS_CLK, 0x20004, 0x00000001),
> +	GATE_CLK(GCC_UFS_MEM_CLKREF_CLK, 0x8c000, 0x00000001),
> +	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x3a00c, 0x00000001),
> +	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x3a034, 0x00000001),
> +	GATE_CLK(GCC_UFS_PHY_ICE_CORE_CLK, 0x3a0a4, 0x00000001),
> +	GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK, 0x3a0ac, 0x00000001),
> +	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK, 0x3a014, 0x00000001),
> +	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_1_CLK, 0x3a018, 0x00000001),
> +	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK, 0x3a010, 0x00000001),
> +	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x3a09c, 0x00000001),
> +	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0x1a00c, 0x00000001),
> +	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1a018, 0x00000001),
> +	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0x1a014, 0x00000001),
> +	GATE_CLK(GCC_USB3_PRIM_CLKREF_CLK, 0x8c010, 0x00000001),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0x1a050, 0x00000001),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1a054, 0x00000001),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0x1a058, 0x00000001),
> +};
> +
> +static int sm6350_enable(struct clk *clk)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +	if (priv->data->num_clks < clk->id) {
> +		debug("%s: unknown clk id %lu\n", __func__, clk->id);
> +		return 0;
> +	}
> +
> +	debug("%s: clk %s\n", __func__, sm6350_clks[clk->id].name);
> +
> +	switch (clk->id) {
> +	case GCC_USB30_PRIM_MASTER_CLK:
> +		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_AUX_CLK);
> +		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
> +		break;
> +	}
> +
> +	return qcom_gate_clk_en(priv, clk->id);
> +}
> +
> +static const struct qcom_reset_map sm6350_gcc_resets[] = {
> +	[GCC_QUSB2PHY_PRIM_BCR] = { 0x1d000 },
> +	[GCC_QUSB2PHY_SEC_BCR] = { 0x1e000 },
> +	[GCC_SDCC1_BCR] = { 0x4b000 },
> +	[GCC_SDCC2_BCR] = { 0x20000 },
> +	[GCC_UFS_PHY_BCR] = { 0x3a000 },
> +	[GCC_USB30_PRIM_BCR] = { 0x1a000 },
> +	[GCC_USB3_PHY_PRIM_BCR] = { 0x1c000 },
> +	[GCC_USB3_DP_PHY_PRIM_BCR] = { 0x1c008 },
> +};
> +
> +static const struct qcom_power_map sm6350_gdscs[] = {
> +	[USB30_PRIM_GDSC] = { 0x1a004 },
> +	[UFS_PHY_GDSC] = { 0x3a004 },
> +	[HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC] = { 0xb7040 },
> +	[HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC] = { 0xb7044 },
> +};
> +
> +static struct msm_clk_data sm6350_gcc_data = {
> +	.resets = sm6350_gcc_resets,
> +	.num_resets = ARRAY_SIZE(sm6350_gcc_resets),
> +	.clks = sm6350_clks,
> +	.num_clks = ARRAY_SIZE(sm6350_clks),
> +	.power_domains = sm6350_gdscs,
> +	.num_power_domains = ARRAY_SIZE(sm6350_gdscs),
> +
> +	.enable = sm6350_enable,
> +	.set_rate = sm6350_set_rate,
> +};
> +
> +static const struct udevice_id gcc_sm6350_of_match[] = {
> +	{
> +		.compatible = "qcom,gcc-sm6350",
> +		.data = (ulong)&sm6350_gcc_data,
> +	},
> +	{}
> +};
> +
> +U_BOOT_DRIVER(gcc_sm6350) = {
> +	.name = "gcc_sm6350",
> +	.id = UCLASS_NOP,
> +	.of_match = gcc_sm6350_of_match,
> +	.bind = qcom_cc_bind,
> +	.flags = DM_FLAG_PRE_RELOC,
> +};
> 

Apart that, looks good :-)

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

