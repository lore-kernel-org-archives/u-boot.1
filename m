Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3D9C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 11:49:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5273488993;
	Mon, 19 Aug 2024 13:49:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ceD1VO14";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FBFE88C13; Mon, 19 Aug 2024 13:49:07 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6BF488B39
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 13:49:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37196681d3bso1958040f8f.3
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 04:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724068144; x=1724672944; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=VKqX0sEJJyW7nQsETx7LdzCspkACnlgRTsnv9EV9qDc=;
 b=ceD1VO14hUzQi6R8KOOQZmqG7utU8d4wBX6nkpyqxClkV+VA90YAPAQqKB+MD1otLt
 zZbyJriVgg3l/GdvZOdXkOBW3WIDjTc70CE3weYcnoih6EPz4MhNQvwp9xShd7TSMLmx
 5tbaupQTO6XXch9nuL2YeauwAlULeiZ5dEH7YCGTgcM9OQXS3OJ3dh8zRDKgj4mUu1fQ
 LYJkOLPLyNThhhrMfnPe0WyWfPZOwEfGtD+CAKhKHMEwXGXckapKtPSvEwS2fraEG2ch
 w3xfkFqEFgIyYfOwNQCarAETLvp+FtoJPaGi5Qc1x04vlVoaPE3g919PuSGvg9wI5a7h
 lsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724068144; x=1724672944;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=VKqX0sEJJyW7nQsETx7LdzCspkACnlgRTsnv9EV9qDc=;
 b=ZqBL+baowijEwdn4r+PTf8m6Fz5ziuMx5OfdI9hX4WKtU9y8y9fl9+GC+MNz4/klme
 simjlJCobrUhbgicWAWEjg7FXWOi+9p/zIfi06HhVjmh5xbLQ2ZxvVEZ6c5EGaRjTrhy
 yermMmRvlx4NQt0CTETPK0/0JW3SkdnwvJrcNUkMDt9orTrmPFxKSU0i5tnULYYd2GFb
 ekxwvz5+dLtfeLhHz1c2qO8f7zssYxJe6K9inE40MQmqT7iVTQ7njJHcpYftr5HYdb1O
 u/e15NNHMVHNQNJPqViMF9pPkI+jvsXSJQ/htIkcx+gtQnepsyiTW8Q7inThcTS7iab0
 GIBg==
X-Gm-Message-State: AOJu0YxlZM1rQRh/2HNxARnj80Mp618H18gA5Ezb6W93+XR59KW6AKYX
 uGpPSy7MElEjTEx8ixPvD1H03cXiJcjzJcC5uEKqrROFiwODIP1Q0JxoTDRK5WA=
X-Google-Smtp-Source: AGHT+IGuNah7LNNS9p301UeltlIMsTF/nveeY6yAI/8HB/MpyDxNTbXa7lOVrUAsuBwDx+Glx3qgjg==
X-Received: by 2002:adf:e805:0:b0:367:9621:6fa with SMTP id
 ffacd0b85a97d-37194660ea2mr7410218f8f.37.1724068143817; 
 Mon, 19 Aug 2024 04:49:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f54e:4b0a:5175:5727?
 ([2a01:e0a:982:cbb0:f54e:4b0a:5175:5727])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37189896bf0sm10319628f8f.73.2024.08.19.04.49.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2024 04:49:03 -0700 (PDT)
Message-ID: <3d6ebe62-9cb3-45b9-8a71-f65a940e655e@linaro.org>
Date: Mon, 19 Aug 2024 13:49:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/7] clk/qcom: add initial clock driver for sc7280
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20240809-b4-rb3gen2-v1-0-7c73fe05b37a@linaro.org>
 <20240809-b4-rb3gen2-v1-1-7c73fe05b37a@linaro.org>
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
In-Reply-To: <20240809-b4-rb3gen2-v1-1-7c73fe05b37a@linaro.org>
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

On 09/08/2024 02:48, Caleb Connolly wrote:
> We don't actually need any clocks to get UFS up and running, resets are
> useful though.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/clk/qcom/Kconfig        |   8 +++
>   drivers/clk/qcom/Makefile       |   1 +
>   drivers/clk/qcom/clock-qcom.h   |   1 +
>   drivers/clk/qcom/clock-sc7280.c | 132 ++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 142 insertions(+)
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 45d63c6d6dbf..0d2c0ac225c5 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -85,7 +85,15 @@ config CLK_QCOM_SM8650
>   	  Say Y here to enable support for the Global Clock Controller
>   	  on the Snapdragon SM8650 SoC. This driver supports the clocks
>   	  and resets exposed by the GCC hardware block.
>   
> +config CLK_QCOM_SC7280
> +	bool "Qualcomm SC7280 GCC"
> +	select CLK_QCOM
> +	help
> +	  Say Y here to enable support for the Global Clock Controller
> +	  on the Snapdragon SC7280 SoC. This driver supports the clocks
> +	  and resets exposed by the GCC hardware block.
> +
>   endmenu
>   
>   endif
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index dec20e4b5943..e223c131ee4d 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -8,8 +8,9 @@ obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
>   obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
>   obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
>   obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
>   obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
> +obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
>   obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
>   obj-$(CONFIG_CLK_QCOM_SM8250) += clock-sm8250.o
>   obj-$(CONFIG_CLK_QCOM_SM8550) += clock-sm8550.o
>   obj-$(CONFIG_CLK_QCOM_SM8650) += clock-sm8650.o
> diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
> index f6445c8f566f..7aa6ca59aad5 100644
> --- a/drivers/clk/qcom/clock-qcom.h
> +++ b/drivers/clk/qcom/clock-qcom.h
> @@ -10,8 +10,9 @@
>   #define CFG_CLK_SRC_CXO   (0 << 8)
>   #define CFG_CLK_SRC_GPLL0 (1 << 8)
>   #define CFG_CLK_SRC_GPLL0_AUX2 (2 << 8)
>   #define CFG_CLK_SRC_GPLL9 (2 << 8)
> +#define CFG_CLK_SRC_GPLL0_ODD (3 << 8)
>   #define CFG_CLK_SRC_GPLL6 (4 << 8)
>   #define CFG_CLK_SRC_GPLL7 (3 << 8)
>   #define CFG_CLK_SRC_GPLL4 (5 << 8)
>   #define CFG_CLK_SRC_GPLL0_EVEN (6 << 8)
> diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
> new file mode 100644
> index 000000000000..5d343f120519
> --- /dev/null
> +++ b/drivers/clk/qcom/clock-sc7280.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Clock drivers for Qualcomm sc7280
> + *
> + * (C) Copyright 2024 Linaro Ltd.
> + */
> +
> +#include <linux/types.h>
> +#include <clk-uclass.h>
> +#include <dm.h>
> +#include <linux/delay.h>
> +#include <asm/io.h>
> +#include <linux/bug.h>
> +#include <linux/bitops.h>
> +#include <dt-bindings/clock/qcom,gcc-sc7280.h>
> +
> +#include "clock-qcom.h"
> +
> +#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf038
> +#define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf020
> +
> +static ulong sc7280_set_rate(struct clk *clk, ulong rate)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +	if (clk->id < priv->data->num_clks)
> +		debug("%s: %s, requested rate=%ld\n", __func__, priv->data->clks[clk->id].name, rate);
> +
> +	switch (clk->id) {
> +	case GCC_USB30_PRIM_MOCK_UTMI_CLK:
> +		WARN(rate != 19200000, "Unexpected rate for USB30_PRIM_MOCK_UTMI_CLK: %lu\n", rate);
> +		clk_rcg_set_rate(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
> +		return rate;
> +	case GCC_USB30_PRIM_MASTER_CLK:
> +		WARN(rate != 200000000, "Unexpected rate for USB30_PRIM_MASTER_CLK: %lu\n", rate);
> +		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
> +				     1, 0, 0, CFG_CLK_SRC_GPLL0_ODD, 8);
> +		clk_rcg_set_rate(priv->base, 0xf064, 0, 0);
> +		return rate;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static const struct gate_clk sc7280_clks[] = {
> +	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0xf07c, 1),
> +	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0xf010, 1),
> +	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0xf080, 1),
> +	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0xf018, 1),
> +	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0xf01c, 1),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf054, 1),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf058, 1),
> +};
> +
> +static int sc7280_enable(struct clk *clk)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +	if (priv->data->num_clks < clk->id) {
> +		debug("%s: unknown clk id %lu\n", __func__, clk->id);
> +		return 0;
> +	}
> +
> +	debug("%s: clk %ld: %s\n", __func__, clk->id, sc7280_clks[clk->id].name);
> +
> +	switch (clk->id) {
> +	case GCC_AGGRE_USB3_PRIM_AXI_CLK:
> +		qcom_gate_clk_en(priv, GCC_USB30_PRIM_MASTER_CLK);
> +		fallthrough;
> +	case GCC_USB30_PRIM_MASTER_CLK:
> +		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_AUX_CLK);
> +		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
> +		break;
> +	}
> +
> +	qcom_gate_clk_en(priv, clk->id);
> +
> +	return 0;
> +}
> +
> +static const struct qcom_reset_map sc7280_gcc_resets[] = {
> +	[GCC_PCIE_0_BCR] = { 0x6b000 },
> +	[GCC_PCIE_0_PHY_BCR] = { 0x6c01c },
> +	[GCC_PCIE_1_BCR] = { 0x8d000 },
> +	[GCC_PCIE_1_PHY_BCR] = { 0x8e01c },
> +	[GCC_QUSB2PHY_PRIM_BCR] = { 0x12000 },
> +	[GCC_QUSB2PHY_SEC_BCR] = { 0x12004 },
> +	[GCC_SDCC1_BCR] = { 0x75000 },
> +	[GCC_SDCC2_BCR] = { 0x14000 },
> +	[GCC_SDCC4_BCR] = { 0x16000 },
> +	[GCC_UFS_PHY_BCR] = { 0x77000 },
> +	[GCC_USB30_PRIM_BCR] = { 0xf000 },
> +	[GCC_USB30_SEC_BCR] = { 0x9e000 },
> +	[GCC_USB3_DP_PHY_PRIM_BCR] = { 0x50008 },
> +	[GCC_USB3_PHY_PRIM_BCR] = { 0x50000 },
> +	[GCC_USB3PHY_PHY_PRIM_BCR] = { 0x50004 },
> +	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
> +};
> +
> +static const struct qcom_power_map sc7280_gdscs[] = {
> +	[GCC_UFS_PHY_GDSC] = { 0x77004 },
> +	[GCC_USB30_PRIM_GDSC] = { 0xf004 },
> +};
> +
> +static struct msm_clk_data qcs404_gcc_data = {
> +	.resets = sc7280_gcc_resets,
> +	.num_resets = ARRAY_SIZE(sc7280_gcc_resets),
> +	.clks = sc7280_clks,
> +	.num_clks = ARRAY_SIZE(sc7280_clks),
> +
> +	.power_domains = sc7280_gdscs,
> +	.num_power_domains = ARRAY_SIZE(sc7280_gdscs),
> +
> +	.enable = sc7280_enable,
> +	.set_rate = sc7280_set_rate,
> +};
> +
> +static const struct udevice_id gcc_sc7280_of_match[] = {
> +	{
> +		.compatible = "qcom,gcc-sc7280",
> +		.data = (ulong)&qcs404_gcc_data,
> +	},
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(gcc_sc7280) = {
> +	.name		= "gcc_sc7280",
> +	.id		= UCLASS_NOP,
> +	.of_match	= gcc_sc7280_of_match,
> +	.bind		= qcom_cc_bind,
> +	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
> +};
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
