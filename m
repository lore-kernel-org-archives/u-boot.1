Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B940EE499C
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 18:05:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33E30892F3;
	Wed, 11 Sep 2024 20:05:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n2w6HDkt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2C928876E; Wed, 11 Sep 2024 20:05:39 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95B60892F3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 20:05:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42cb1e623d1so479175e9.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 11:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726077937; x=1726682737; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=wdxn17PgqhPOM4otkbJoArejDkxqW/cGbs/SJLPUBOw=;
 b=n2w6HDktaTrbuPHqjtbGqGjmL6q0JtNKmUDWTZHOAm1EihD1fwOzBGpiFl5L0iEC4j
 pLvXh29y153s+eeT6TOmrthg0MKpD7F14YDIkKr8EQoGz5Hsv3fbFbs0qbnm3kQ/ZIp5
 mAIbx1c+pmh+RNZf2onQmnaarr1Mqnrf2sQJVt+KctC3pd9nc4nMmAbJBV4BfGwvCDZt
 VB/X9ea03NFlzR/txmR5ZUqRVBazLCRN0+saw63IHwALWrsmbAjakFGpqarQoG5SFpw6
 mA6mF8U7re+tMY72ozKtr394AyYaxeZANzRXRdrb5K06a/b2+uYmYPRaQh0qsOkueKeP
 ihLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726077937; x=1726682737;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wdxn17PgqhPOM4otkbJoArejDkxqW/cGbs/SJLPUBOw=;
 b=jGy3ek7M9mmZ88rTxCXOXadp9XEr5n0DpnNg8PFGjWuBgpRWOd18tzf//wx4E9O8lk
 2d3gjQExxvy2v2Hmn0gP4LBZRewWgHhqrBFexrjz8hJ5YUBF+Zw6q0aTBkRdlCPbOu8L
 GB1/ILZKCjl3tOZwNEIj94MJnGZm0+BQaZs7WXU8DqG/xyjbHBsELruereok6dq/hAhV
 ICikwOSbVoeSh2vVzzScIGnM0qbfzTt2hBYZdnNrow6yO1Jf4gj0ck25/pMoAHDV1WPn
 xvBiT7NGzGUiGfs9ay2qAb0F+WdR7Nghs8Czk6PwC78Mb7ioABjHajLhumxMZVv94hNW
 PVag==
X-Gm-Message-State: AOJu0YyQOvMre6qqtbYZpJqeV7CTuL8BY6ureUigYf/aLCY83lSqyeXk
 BHWYh+iQuVAdUmB5hgp0lem/Mt+wNE4vciu0f+dyps1sebLeuiBWmT36WXCAs5M=
X-Google-Smtp-Source: AGHT+IEv924Kw4K6sHrPwas2abeVb5bd0Kx3kVsLdhIUQoLveTM5mIUuYPiKg9VxYeX9jcLTrPfyGg==
X-Received: by 2002:a05:600c:474d:b0:42c:ac9f:b528 with SMTP id
 5b1f17b1804b1-42cdb57b3e1mr2719215e9.35.1726077936621; 
 Wed, 11 Sep 2024 11:05:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:1680:3625:e94b:7c21?
 ([2a01:e0a:982:cbb0:1680:3625:e94b:7c21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cc1375c6esm50160825e9.1.2024.09.11.11.05.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 11:05:36 -0700 (PDT)
Message-ID: <b930dab7-1baa-471d-ac4a-18ac3d470c7d@linaro.org>
Date: Wed, 11 Sep 2024 20:05:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 1/3] clk: qcom: add driver for SM8150 SoC
To: Julius Lehmann <lehmanju@devpi.de>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>
References: <20240911-sm8150-patches-v3-0-d9164b71316f@devpi.de>
 <20240911-sm8150-patches-v3-1-d9164b71316f@devpi.de>
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
In-Reply-To: <20240911-sm8150-patches-v3-1-d9164b71316f@devpi.de>
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

On 11/09/2024 19:13, Julius Lehmann wrote:
> Add clock, reset and power domain driver for SM8150. Driver code is
> based on the similar U-Boot drivers. All constants are taken from the
> corresponding Linux driver.
> 
> This driver supports clock rate setting only debug UART,
> RGMII/Ethernet modules and USB controller.
> 
> Co-authored-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> Signed-off-by: Julius Lehmann <lehmanju@devpi.de>
> ---
>   drivers/clk/qcom/Kconfig        |   9 ++
>   drivers/clk/qcom/Makefile       |   1 +
>   drivers/clk/qcom/clock-sm8150.c | 319 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 329 insertions(+)
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 0d2c0ac225..d76fca5dba 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -63,12 +63,21 @@ config CLK_QCOM_SM6115
>   	  on the Snapdragon SM6115 SoC. This driver supports the clocks
>   	  and resets exposed by the GCC hardware block.
>   
> +config CLK_QCOM_SM8150
> +	bool "Qualcomm SM8150 GCC"
> +	select CLK_QCOM
> +	help
> +	  Say Y here to enable support for the Global Clock Controller
> +	  on the Snapdragon 8150 SoC. This driver supports the clocks
> +	  and resets exposed by the GCC hardware block.
> +
>   config CLK_QCOM_SM8250
>   	bool "Qualcomm SM8250 GCC"
>   	select CLK_QCOM
>   	help
>   	  Say Y here to enable support for the Global Clock Controller
>   	  on the Snapdragon SM8250 SoC. This driver supports the clocks
> +	  and resets exposed by the GCC hardware block.
>   
>   config CLK_QCOM_SM8550
>   	bool "Qualcomm SM8550 GCC"
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index e223c131ee..ab33f1c5fa 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
>   obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
>   obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
>   obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
> +obj-$(CONFIG_CLK_QCOM_SM8150) += clock-sm8150.o
>   obj-$(CONFIG_CLK_QCOM_SM8250) += clock-sm8250.o
>   obj-$(CONFIG_CLK_QCOM_SM8550) += clock-sm8550.o
>   obj-$(CONFIG_CLK_QCOM_SM8650) += clock-sm8650.o
> diff --git a/drivers/clk/qcom/clock-sm8150.c b/drivers/clk/qcom/clock-sm8150.c
> new file mode 100644
> index 0000000000..88f2e678f4
> --- /dev/null
> +++ b/drivers/clk/qcom/clock-sm8150.c
> @@ -0,0 +1,319 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Clock drivers for Qualcomm SM8150
> + *
> + * Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> + * Copyright (c) 2024 EPAM Systems.
> + *
> + * (C) Copyright 2024 Julius Lehmann <lehmanju@devpi.de>
> + *
> + * Based on U-Boot driver for SM8250. Constants are taken from the Linux driver.
> + */
> +
> +#include <clk-uclass.h>
> +#include <dm.h>
> +#include <errno.h>
> +#include <asm/io.h>
> +#include <linux/bitops.h>
> +#include <dt-bindings/clock/qcom,gcc-sm8150.h>
> +
> +#include "clock-qcom.h"
> +
> +#define EMAC_RGMII_CLK_CMD_RCGR 0x601c
> +#define QUPV3_WRAP0_S0_CLK_CMD_RCGR 0x18148
> +#define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf01c
> +#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf034
> +#define USB30_PRIM_PHY_AUX_CLK_CMD_RCGR 0xf060
> +#define USB30_SEC_MASTER_CLK_CMD_RCGR 0x1001c
> +#define USB30_SEC_MOCK_UTMI_CLK_CMD_RCGR 0x10034
> +#define USB30_SEC_PHY_AUX_CLK_CMD_RCGR 0x10060
> +#define SDCC2_APPS_CLK_CMD_RCGR 0x1400c
> +
> +static struct pll_vote_clk gpll7_vote_clk = {
> +	.status = 0x1a000,
> +	.status_bit = BIT(31),
> +	.ena_vote = 0x52000,
> +	.vote_bit = BIT(7),
> +};
> +
> +static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
> +	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
> +	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
> +	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
> +	F(29491200, CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
> +	F(32000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 75),
> +	F(48000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 25),
> +	F(64000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 16, 75),
> +	F(80000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 15),
> +	F(96000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 25),
> +	F(100000000, CFG_CLK_SRC_GPLL0_EVEN, 3, 0, 0),
> +	F(102400000, CFG_CLK_SRC_GPLL0_EVEN, 1, 128, 375),
> +	F(112000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 28, 75),
> +	F(117964800, CFG_CLK_SRC_GPLL0_EVEN, 1, 6144, 15625),
> +	F(120000000, CFG_CLK_SRC_GPLL0_EVEN, 2.5, 0, 0),
> +	F(128000000, CFG_CLK_SRC_GPLL0, 1, 16, 75),
> +	{ }
> +};
> +
> +static const struct freq_tbl ftbl_gcc_emac_rgmii_clk_src[] = {
> +	F(2500000, CFG_CLK_SRC_CXO, 1, 25, 192),
> +	F(5000000, CFG_CLK_SRC_CXO, 1, 25, 96),
> +	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
> +	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
> +	F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
> +	F(125000000, CFG_CLK_SRC_GPLL7, 4, 0, 0),
> +	F(250000000, CFG_CLK_SRC_GPLL7, 2, 0, 0),
> +	{ }
> +};
> +
> +static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
> +	F(33333333, CFG_CLK_SRC_GPLL0_EVEN, 9, 0, 0),
> +	F(66666667, CFG_CLK_SRC_GPLL0_EVEN, 4.5, 0, 0),
> +	F(133333333, CFG_CLK_SRC_GPLL0, 4.5, 0, 0),
> +	F(200000000, CFG_CLK_SRC_GPLL0, 3, 0, 0),
> +	F(240000000, CFG_CLK_SRC_GPLL0, 2.5, 0, 0),
> +	{ }
> +};
> +
> +static const struct freq_tbl ftbl_gcc_usb30_prim_mock_utmi_clk_src[] = {
> +	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
> +	F(20000000, CFG_CLK_SRC_GPLL0_EVEN, 15, 0, 0),
> +	F(60000000, CFG_CLK_SRC_GPLL0_EVEN, 5, 0, 0),
> +	{ }
> +};
> +
> +static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
> +	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
> +	F(9600000, CFG_CLK_SRC_CXO, 2, 0, 0),
> +	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
> +	F(25000000, CFG_CLK_SRC_GPLL0, 12, 1, 2),
> +	F(50000000, CFG_CLK_SRC_GPLL0, 12, 0, 0),
> +	F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
> +	F(202000000, CFG_CLK_SRC_GPLL0, 4, 0, 0),
> +	{ }
> +};
> +
> +static ulong sm8150_clk_set_rate(struct clk *clk, ulong rate)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +	const struct freq_tbl *freq;
> +
> +	switch (clk->id) {
> +	case GCC_QUPV3_WRAP1_S4_CLK: /* UART2 aka debug-uart */
> +		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP0_S0_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 16);
> +		return freq->freq;
> +	case GCC_EMAC_RGMII_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_emac_rgmii_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, EMAC_RGMII_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 8);
> +		return freq->freq;
> +	case GCC_USB30_PRIM_MASTER_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_usb30_prim_master_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 8);
> +		return freq->freq;
> +	case GCC_USB30_PRIM_MOCK_UTMI_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_usb30_prim_mock_utmi_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 0);
> +		return freq->freq;
> +	case GCC_USB3_PRIM_PHY_AUX_CLK_SRC:
> +		freq = qcom_find_freq(ftbl_gcc_usb30_prim_mock_utmi_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_PHY_AUX_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 0);
> +		return freq->freq;
> +	case GCC_USB30_SEC_MASTER_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_usb30_prim_master_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, USB30_SEC_MASTER_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 8);
> +		return freq->freq;
> +	case GCC_USB30_SEC_MOCK_UTMI_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_usb30_prim_mock_utmi_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, USB30_SEC_MOCK_UTMI_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 0);
> +		return freq->freq;
> +	case GCC_USB3_SEC_PHY_AUX_CLK_SRC:
> +		freq = qcom_find_freq(ftbl_gcc_usb30_prim_mock_utmi_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, USB30_SEC_PHY_AUX_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 0);
> +		return freq->freq;
> +	case GCC_SDCC2_APPS_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, SDCC2_APPS_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 8);
> +		return freq->freq;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static const struct gate_clk sm8150_clks[] = {
> +	GATE_CLK(GCC_AGGRE_UFS_CARD_AXI_CLK,		0x750c0, 0x00000001),
> +	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK,			0x770c0, 0x00000001),
> +	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK,		0xf07c, 0x00000001),
> +	GATE_CLK(GCC_AGGRE_USB3_SEC_AXI_CLK,		0x1007c, 0x00000001),
> +	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK,		0xf078, 0x00000001),
> +	GATE_CLK(GCC_CFG_NOC_USB3_SEC_AXI_CLK,		0x10078, 0x00000001),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK,		0x5200c, 0x00000400),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK,		0x5200c, 0x00000800),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK,		0x5200c, 0x00001000),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK,		0x5200c, 0x00002000),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S4_CLK,		0x5200c, 0x00004000),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S5_CLK,		0x5200c, 0x00008000),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S0_CLK,		0x5200c, 0x00400000),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S1_CLK,		0x5200c, 0x00800000),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S3_CLK,		0x5200c, 0x02000000),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S4_CLK,		0x5200c, 0x04000000),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S5_CLK,		0x5200c, 0x08000000),
> +	GATE_CLK(GCC_QUPV3_WRAP_0_M_AHB_CLK,		0x5200c, 0x00000040),
> +	GATE_CLK(GCC_QUPV3_WRAP_0_S_AHB_CLK,		0x5200c, 0x00000080),
> +	GATE_CLK(GCC_QUPV3_WRAP_1_M_AHB_CLK,		0x5200c, 0x00100000),
> +	GATE_CLK(GCC_QUPV3_WRAP_1_S_AHB_CLK,		0x5200c, 0x00200000),
> +	GATE_CLK(GCC_SDCC2_AHB_CLK,			0x14008, 0x00000001),
> +	GATE_CLK(GCC_SDCC2_APPS_CLK,			0x14004, 0x00000001),
> +	GATE_CLK(GCC_SDCC4_AHB_CLK,			0x16008, 0x00000001),
> +	GATE_CLK(GCC_SDCC4_APPS_CLK,			0x16004, 0x00000001),
> +	GATE_CLK(GCC_UFS_CARD_AHB_CLK,			0x75014, 0x00000001),
> +	GATE_CLK(GCC_UFS_CARD_AXI_CLK,			0x75010, 0x00000001),
> +	GATE_CLK(GCC_UFS_CARD_CLKREF_CLK,		0x8c004, 0x00000001),
> +	GATE_CLK(GCC_UFS_CARD_ICE_CORE_CLK,		0x7505c, 0x00000001),
> +	GATE_CLK(GCC_UFS_CARD_PHY_AUX_CLK,		0x75090, 0x00000001),
> +	GATE_CLK(GCC_UFS_CARD_RX_SYMBOL_0_CLK,		0x7501c, 0x00000001),
> +	GATE_CLK(GCC_UFS_CARD_RX_SYMBOL_1_CLK,		0x750ac, 0x00000001),
> +	GATE_CLK(GCC_UFS_CARD_TX_SYMBOL_0_CLK,		0x75018, 0x00000001),
> +	GATE_CLK(GCC_UFS_CARD_UNIPRO_CORE_CLK,		0x75058, 0x00000001),
> +	GATE_CLK(GCC_UFS_MEM_CLKREF_CLK,		0x8c000, 0x00000001),
> +	GATE_CLK(GCC_UFS_PHY_AHB_CLK,			0x77014, 0x00000001),
> +	GATE_CLK(GCC_UFS_PHY_AXI_CLK,			0x77010, 0x00000001),
> +	GATE_CLK(GCC_UFS_PHY_ICE_CORE_CLK,		0x7705c, 0x00000001),
> +	GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK,		0x77090, 0x00000001),
> +	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK,		0x7701c, 0x00000001),
> +	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_1_CLK,		0x770ac, 0x00000001),
> +	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK,		0x77018, 0x00000001),
> +	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK,		0x77058, 0x00000001),
> +	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK,		0x0f00c, 0x00000001),
> +	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK,		0x0f014, 0x00000001),
> +	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK,		0x0f010, 0x00000001),
> +	GATE_CLK(GCC_USB30_SEC_MASTER_CLK,		0x1000c, 0x00000001),
> +	GATE_CLK(GCC_USB30_SEC_MOCK_UTMI_CLK,		0x10014, 0x00000001),
> +	GATE_CLK(GCC_USB30_SEC_SLEEP_CLK,		0x10010, 0x00000001),
> +	GATE_CLK(GCC_USB3_PRIM_CLKREF_CLK,		0x8c008, 0x00000001),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK,		0x0f04c, 0x00000001),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK,		0x0f050, 0x00000001),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK,		0x0f054, 0x00000001),
> +	GATE_CLK(GCC_USB3_SEC_CLKREF_CLK,		0x8c028, 0x00000001),
> +	GATE_CLK(GCC_USB3_SEC_PHY_AUX_CLK,		0x1004c, 0x00000001),
> +	GATE_CLK(GCC_USB3_SEC_PHY_PIPE_CLK,		0x10054, 0x00000001),
> +	GATE_CLK(GCC_USB3_SEC_PHY_COM_AUX_CLK,		0x10050, 0x00000001),
> +	GATE_CLK(GCC_EMAC_AXI_CLK,			0x06010, 0x00000001),
> +	GATE_CLK(GCC_EMAC_SLV_AHB_CLK,			0x06014, 0x00000001),
> +	GATE_CLK(GCC_EMAC_PTP_CLK,			0x06034, 0x00000001),
> +	GATE_CLK(GCC_EMAC_RGMII_CLK,			0x06018, 0x00000001),
> +};
> +
> +static int sm8150_clk_enable(struct clk *clk)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +	if (priv->data->num_clks <= clk->id) {
> +		debug("%s: unknown clk id %lu\n", __func__, clk->id);
> +		return 0;
> +	}
> +
> +	debug("%s: clk %s\n", __func__, sm8150_clks[clk->id].name);
> +
> +	switch (clk->id) {
> +	case GCC_EMAC_RGMII_CLK:
> +		clk_enable_gpll0(priv->base, &gpll7_vote_clk);
> +	case GCC_AGGRE_USB3_PRIM_AXI_CLK:
> +		qcom_gate_clk_en(priv, GCC_USB30_PRIM_MASTER_CLK);
> +		fallthrough;
> +	case GCC_USB30_PRIM_MASTER_CLK:
> +		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_AUX_CLK);
> +		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
> +		break;
> +	case GCC_AGGRE_USB3_SEC_AXI_CLK:
> +		qcom_gate_clk_en(priv, GCC_USB30_SEC_MASTER_CLK);
> +		fallthrough;
> +	case GCC_USB30_SEC_MASTER_CLK:
> +		qcom_gate_clk_en(priv, GCC_USB3_SEC_PHY_AUX_CLK);
> +		qcom_gate_clk_en(priv, GCC_USB3_SEC_PHY_COM_AUX_CLK);
> +		break;
> +	};
> +
> +	qcom_gate_clk_en(priv, clk->id);
> +
> +	return 0;
> +}
> +
> +static const struct qcom_reset_map sm8150_gcc_resets[] = {
> +	[GCC_EMAC_BCR] = { 0x6000 },
> +	[GCC_GPU_BCR] = { 0x71000 },
> +	[GCC_MMSS_BCR] = { 0xb000 },
> +	[GCC_NPU_BCR] = { 0x4d000 },
> +	[GCC_PCIE_0_BCR] = { 0x6b000 },
> +	[GCC_PCIE_0_PHY_BCR] = { 0x6c01c },
> +	[GCC_PCIE_1_BCR] = { 0x8d000 },
> +	[GCC_PCIE_1_PHY_BCR] = { 0x8e01c },
> +	[GCC_PCIE_PHY_BCR] = { 0x6f000 },
> +	[GCC_PDM_BCR] = { 0x33000 },
> +	[GCC_PRNG_BCR] = { 0x34000 },
> +	[GCC_QSPI_BCR] = { 0x24008 },
> +	[GCC_QUPV3_WRAPPER_0_BCR] = { 0x17000 },
> +	[GCC_QUPV3_WRAPPER_1_BCR] = { 0x18000 },
> +	[GCC_QUPV3_WRAPPER_2_BCR] = { 0x1e000 },
> +	[GCC_QUSB2PHY_PRIM_BCR] = { 0x12000 },
> +	[GCC_QUSB2PHY_SEC_BCR] = { 0x12004 },
> +	[GCC_USB3_PHY_PRIM_BCR] = { 0x50000 },
> +	[GCC_USB3_DP_PHY_PRIM_BCR] = { 0x50008 },
> +	[GCC_USB3_PHY_SEC_BCR] = { 0x5000c },
> +	[GCC_USB3PHY_PHY_SEC_BCR] = { 0x50010 },
> +	[GCC_SDCC2_BCR] = { 0x14000 },
> +	[GCC_SDCC4_BCR] = { 0x16000 },
> +	[GCC_TSIF_BCR] = { 0x36000 },
> +	[GCC_UFS_CARD_BCR] = { 0x75000 },
> +	[GCC_UFS_PHY_BCR] = { 0x77000 },
> +	[GCC_USB30_PRIM_BCR] = { 0xf000 },
> +	[GCC_USB30_SEC_BCR] = { 0x10000 },
> +	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
> +};
> +
> +static const struct qcom_power_map sm8150_gcc_power_domains[] = {
> +	[EMAC_GDSC] = { 0x6004 },
> +	[PCIE_0_GDSC] = { 0x6b004 },
> +	[PCIE_1_GDSC] = { 0x8d004 },
> +	[UFS_CARD_GDSC] = { 0x75004 },
> +	[UFS_PHY_GDSC] = { 0x77004 },
> +	[USB30_PRIM_GDSC] = { 0xf004 },
> +	[USB30_SEC_GDSC] = { 0x10004 },
> +};
> +
> +static struct msm_clk_data sm8150_clk_data = {
> +	.resets = sm8150_gcc_resets,
> +	.num_resets = ARRAY_SIZE(sm8150_gcc_resets),
> +	.clks = sm8150_clks,
> +	.num_clks = ARRAY_SIZE(sm8150_clks),
> +	.power_domains = sm8150_gcc_power_domains,
> +	.num_power_domains = ARRAY_SIZE(sm8150_gcc_power_domains),
> +
> +	.enable = sm8150_clk_enable,
> +	.set_rate = sm8150_clk_set_rate,
> +};
> +
> +static const struct udevice_id gcc_sm8150_of_match[] = {
> +	{
> +		.compatible = "qcom,gcc-sm8150",
> +		.data = (ulong)&sm8150_clk_data,
> +	},
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(gcc_sm8150) = {
> +	.name		= "gcc_sm8150",
> +	.id             = UCLASS_NOP,
> +	.of_match	= gcc_sm8150_of_match,
> +	.bind		= qcom_cc_bind,
> +	.flags		= DM_FLAG_PRE_RELOC,
> +};
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
