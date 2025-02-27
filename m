Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0F2C021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 12:11:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA7F580F12;
	Thu, 27 Feb 2025 13:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K8HCkzu2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB344810F1; Thu, 27 Feb 2025 13:11:15 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7034F80FF4
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 13:11:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38f378498b0so644241f8f.0
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 04:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740658273; x=1741263073; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=ZSBLKldh3VOIZh27fJp4oLs+Sb6ttedmKSKvqywmRFE=;
 b=K8HCkzu22odlMUNUmRab0/CUj3iawbMfFP3L7wyvvjE51RdQUhHl7YkeRHkhAKqWny
 ZPpMq5+Lc0a1e4et7CGRbK4BIkLohTxKWKMLdjSRcLuvldl5uUD1hdjIx8FfLv2asfT6
 tsos69QreE3QkzriQAitROohQNFCzMCwi22ClKZ26f7IelOSOxPXiPQsp3SfM9fkgzsb
 kXaDuchRKtwvhfykpsoq5I9B9+fksQxRWWQ1nxzm6jhuJFU3h+fY/m7M6b29LWiUWhK8
 Ty+PziRfgUaPHYhVZpRC646wfVZhMJhTfbtNBeNDnNQby9kSXBJJx/Uo+/Mb68MvFxOi
 EGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740658273; x=1741263073;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ZSBLKldh3VOIZh27fJp4oLs+Sb6ttedmKSKvqywmRFE=;
 b=uTnVBfRFrEri4yfRSQp83RDNEa8U0p8VP6SGy+VNuHqulWJH6nNW6mWSP82MAxbzzi
 ZD1ZcfxWzV3wEO8DowIwXFyhP/sQURvkuJWKkh+driUfD/d7CYwq1e/7BkEwhQ7TMyGO
 lK/1Dv+deWbhc/AW6f5P3FaWMmsmfTHz4MKd9oQL2+neGNM5rZQBVkQPGitZzI8TlJkV
 4HC9RbVxpfgxuTmKkro1Pra9ohJNED1XudIFODuujVWuLHT35VssfaOguR6lCZNaWVgH
 4FKsSlUNjd+QnVdUjOHWjg3ImXCXaskcN+pDNpe8S7o9MIT+YlhuT01elxsATBTSOf7D
 IOhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4Ehn8lOgINBG4K4i/mqgaAgaH4PQ+iqiW4k4IlGcnHz9n4+M1aEkb1mVvq6U/EFna3pK89Xo=@lists.denx.de
X-Gm-Message-State: AOJu0YwqXlNjjAD73XpHfpEpd9sFkKv7+D3AFbFlnZXbniRpvB0iGjuI
 unMkO1O/MNmrMbUHMGB7Wb/D7wMzlD75S4wRpiWfqlFnC+G6xsLdf0wmBVL3UuA=
X-Gm-Gg: ASbGncvuemiIsV26rYSjm5FsA9CvKtzpiXD3BXYMR1dy/ggRT8Drv39h4+uEkFmStbZ
 9daUMXM1EQRVkZa7bTge1Fm25CCjGhlYxFZ9tuygoVnYq++VIer8KicOL7h2EcAJpQrIEc4hc1H
 fHbyzeIOMMY8caXUmhWeIuM6o7jnmeVNbog13Aa7DlewYay8tvD4uVaEvBpESod0bk45ecspNIJ
 4KModo2+r+D42M+OWQpQW53QPsSPwN2ShXz5Im0Zi9cLsnn9C+92GUa9/lknldrC2VnKbgfJRPt
 G326MOe90DYsJjfndtBgx1CnC5RjSfccGQWI2RlEzAXRtVD7THP0waLcmwRFKkUjJEYFipyxqS/
 mHBk=
X-Google-Smtp-Source: AGHT+IGpA1SjhLyGnlWnbx24CYFoO2C7ljlUhtFoh0nwkEewN/tGo2/agTJCq9+VEmjsCpw9wBUnCA==
X-Received: by 2002:adf:e405:0:b0:38f:4acd:9753 with SMTP id
 ffacd0b85a97d-390d4f4c7fcmr4823416f8f.32.1740658272764; 
 Thu, 27 Feb 2025 04:11:12 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:c5de:e7f3:73c7:7958?
 ([2a01:e0a:982:cbb0:c5de:e7f3:73c7:7958])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a66bcsm1822424f8f.21.2025.02.27.04.11.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 04:11:12 -0800 (PST)
Message-ID: <9dccb526-b0c7-400a-8925-b2f7862d12ab@linaro.org>
Date: Thu, 27 Feb 2025 13:11:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 02/15] clk: qcom: Add driver for sc7180
To: Stephen Boyd <swboyd@chromium.org>, u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
References: <20250226221607.1283592-1-swboyd@chromium.org>
 <20250226221607.1283592-3-swboyd@chromium.org>
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
In-Reply-To: <20250226221607.1283592-3-swboyd@chromium.org>
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

On 26/02/2025 23:15, Stephen Boyd wrote:
> The clks are already configured properly by coreboot on sc7180, but this
> is good enough to make the MMC and USB drivers work.
> 
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>   drivers/clk/qcom/Kconfig        |   8 ++
>   drivers/clk/qcom/Makefile       |   1 +
>   drivers/clk/qcom/clock-sc7180.c | 150 ++++++++++++++++++++++++++++++++
>   3 files changed, 159 insertions(+)
>   create mode 100644 drivers/clk/qcom/clock-sc7180.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index cb867acc48c3..973ebc01ec31 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -103,6 +103,14 @@ config CLK_QCOM_SM8650
>   	  on the Snapdragon SM8650 SoC. This driver supports the clocks
>   	  and resets exposed by the GCC hardware block.
>   
> +config CLK_QCOM_SC7180
> +	bool "Qualcomm SC7180 GCC"
> +	select CLK_QCOM
> +	help
> +	  Say Y here to enable support for the Global Clock Controller
> +	  on the Snapdragon SC7180 SoC. This driver supports the clocks
> +	  and resets exposed by the GCC hardware block.
> +
>   config CLK_QCOM_SC7280
>   	bool "Qualcomm SC7280 GCC"
>   	select CLK_QCOM
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 1bc0f15005b3..aae9d5ea578e 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
>   obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
>   obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
>   obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
> +obj-$(CONFIG_CLK_QCOM_SC7180) += clock-sc7180.o
>   obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
>   obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
>   obj-$(CONFIG_CLK_QCOM_SM8150) += clock-sm8150.o
> diff --git a/drivers/clk/qcom/clock-sc7180.c b/drivers/clk/qcom/clock-sc7180.c
> new file mode 100644
> index 000000000000..b91c0f38c8f7
> --- /dev/null
> +++ b/drivers/clk/qcom/clock-sc7180.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Clock drivers for Qualcomm sc7180
> + */
> +
> +#include <linux/types.h>
> +#include <clk-uclass.h>
> +#include <dm.h>
> +#include <linux/bug.h>
> +#include <linux/bitops.h>
> +#include <dt-bindings/clock/qcom,gcc-sc7180.h>
> +
> +#include "clock-qcom.h"
> +
> +#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf034
> +#define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf01c
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
> +	{ }
> +};
> +
> +static ulong sc7180_set_rate(struct clk *clk, ulong rate)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +	const struct freq_tbl *freq;
> +
> +	if (clk->id < priv->data->num_clks)
> +		debug("%s: %s, requested rate=%ld\n", __func__, priv->data->clks[clk->id].name, rate);
> +
> +	switch (clk->id) {
> +	case GCC_QUPV3_WRAP1_S2_CLK: /* UART8 */
> +		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap1_s3_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, 0x18278,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 16);
> +		return freq->freq;
> +	case GCC_USB30_PRIM_MOCK_UTMI_CLK:
> +		WARN(rate != 19200000, "Unexpected rate for USB30_PRIM_MOCK_UTMI_CLK: %lu\n", rate);
> +		clk_rcg_set_rate(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
> +		return rate;
> +	case GCC_USB30_PRIM_MASTER_CLK:
> +		/* DT has 150000000 but this is actually rounded to 200000000 */
> +		WARN(rate != 150000000, "Unexpected rate for USB30_PRIM_MASTER_CLK: %lu\n", rate);
> +		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
> +				     3, 0, 0, CFG_CLK_SRC_GPLL0, 8);
> +		clk_rcg_set_rate(priv->base, 0xf060, 0, 0);
> +		return rate;
> +	case GCC_SDCC1_APPS_CLK:
> +		/* TODO: Actually set a rate here */
> +		return rate;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static const struct gate_clk sc7180_clks[] = {
> +	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x502c, 1),
> +	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0xf010, 1),
> +	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0x8201c, 1),
> +	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0xf014, 1),
> +	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0xf018, 1),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf050, 1),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf054, 1),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S2_CLK, 0x18274, 1),
> +};
> +
> +static int sc7180_enable(struct clk *clk)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +	if (priv->data->num_clks < clk->id) {
> +		debug("%s: unknown clk id %lu\n", __func__, clk->id);
> +		return 0;
> +	}
> +
> +	debug("%s: clk %ld: %s\n", __func__, clk->id, sc7180_clks[clk->id].name);
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
> +static const struct qcom_reset_map sc7180_gcc_resets[] = {
> +	[GCC_QUSB2PHY_PRIM_BCR] = { 0x26000 },
> +	[GCC_QUSB2PHY_SEC_BCR] = { 0x26004 },
> +	[GCC_UFS_PHY_BCR] = { 0x77000 },
> +	[GCC_USB30_PRIM_BCR] = { 0xf000 },
> +	[GCC_USB3_DP_PHY_PRIM_BCR] = { 0x50008 },
> +	[GCC_USB3_PHY_PRIM_BCR] = { 0x50000 },
> +	[GCC_USB3PHY_PHY_PRIM_BCR] = { 0x50004 },
> +	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
> +	[GCC_USB3_PHY_SEC_BCR] = { 0x5000c },
> +	[GCC_USB3PHY_PHY_SEC_BCR] = { 0x50010 },
> +	[GCC_USB3_DP_PHY_SEC_BCR] = { 0x50014 },
> +	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
> +};
> +
> +static const struct qcom_power_map sc7180_gdscs[] = {
> +	[UFS_PHY_GDSC] = { 0x77004 },
> +	[USB30_PRIM_GDSC] = { 0xf004 },
> +};
> +
> +static struct msm_clk_data sc7180_gcc_data = {
> +	.resets = sc7180_gcc_resets,
> +	.num_resets = ARRAY_SIZE(sc7180_gcc_resets),
> +	.clks = sc7180_clks,
> +	.num_clks = ARRAY_SIZE(sc7180_clks),
> +
> +	.power_domains = sc7180_gdscs,
> +	.num_power_domains = ARRAY_SIZE(sc7180_gdscs),
> +
> +	.enable = sc7180_enable,
> +	.set_rate = sc7180_set_rate,
> +};
> +
> +static const struct udevice_id gcc_sc7180_of_match[] = {
> +	{
> +		.compatible = "qcom,gcc-sc7180",
> +		.data = (ulong)&sc7180_gcc_data,
> +	},
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(gcc_sc7180) = {
> +	.name		= "gcc_sc7180",
> +	.id		= UCLASS_NOP,
> +	.of_match	= gcc_sc7180_of_match,
> +	.bind		= qcom_cc_bind,
> +	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
> +};

Looks good !

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
