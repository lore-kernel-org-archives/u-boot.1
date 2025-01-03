Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2B7E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 15:12:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1DDB80295;
	Fri,  3 Jan 2025 16:12:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="icfHoyAY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67A1A8035E; Fri,  3 Jan 2025 16:12:29 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2DDC801A0
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 16:12:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4361fe642ddso130230955e9.2
 for <u-boot@lists.denx.de>; Fri, 03 Jan 2025 07:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735917146; x=1736521946; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=9Sta7xetUZAvJJlLpw9xixl6FUuSQu/TJyoP2hNCcXs=;
 b=icfHoyAYuMJtcvHpT4RMlpMsrBgAV0YQMvLcfrSyRUdPbptzGSN4C39E60keQGSH6E
 PE6vwylvoRwjBU2rs3xWTsLdq26g06cWyZJ06ZDdxQK4XNjT1rWCqJ8SrSu8uIoduDbc
 AdAeR/0X5S0xzSZYDHoL+DkrGXxn2uX1YkvkMCSXpoySKjjyao+4LIM31FRUhpk/Xl9k
 mQ0wVP9qN/41MKNxa5BMwAPoQjO0m1wKNIkw2PvG6N1odYPJfmfGa3Z4Rf3Mud3DXvUR
 cJl+aT+hloO5M1HJgReWWDxjoCS4FGGV16M/H7zJvyltXfOxDkunw8wEdbvO7CWCqbh6
 0I+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735917146; x=1736521946;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9Sta7xetUZAvJJlLpw9xixl6FUuSQu/TJyoP2hNCcXs=;
 b=sYfqFw1srmK+n2JMfyRGEbjwu+cqF4rwuzrhMZ5uw16huOrvd11dZG2I8Wa4GMKZyZ
 WV+NxMNRhhU41AzVf8Af13wW9FR9u40fBk0Sa+GK4PNL3AlaElPRPMQs50EXoC5UnUc1
 9J54wD362yE6VeShnD9f5dZ5MqnYyxPn6B8gNcgjQIeOZE8nZuOjvwR1nvUVN/APLy0C
 J+fmqBpjTEhYVgbLylLcPfzsI7/wEAR5g6+wj7iTw0sNVg5Y/T49Xh4XBIpfu8SB+zhH
 2LAJTKdSIeBRPq6m9Nrn3UICBvqw75sRJi1xzogqMgHqqKySXK8xp2VFmI6Zv8TSol3Q
 QQzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCgj1rOsX85itI8FXlYv0Z1MvLA960RvBTLs58qOaESBveG9bPp2+wRoCQpDewWc9JGEZ3/Pk=@lists.denx.de
X-Gm-Message-State: AOJu0YyjekLEOXbXAWMTordmxTetDAlg1hoHeDa13Rs2LIJkt2zgt7/H
 eE59cVOG6nJ3yu1AR/WzS/UbTiC8MOcDvf0rStQPPqyZrIMXZPHOOw+bgK7cV+Q=
X-Gm-Gg: ASbGncsuIiIVnXAH7P+WfiyH4ZjiRsyR+iLoPkJsbYNeGj3YDpiULHdHnR6v1QLo2vQ
 C3rbbunyRpUKmSCR+ChjTQAvEK4qhXUui7jQrcafqOL0QGAZDtMYS/Cq6B2Z5H+chzPWdOH6be9
 64SVr/HDWZBQTQob2uTUPbNysDjBcAMFFhactWZKAFEdFeAfIyXl2ykOsTD2TBwJVOQFdsAHYYa
 N5ftOGic0SUyjM/bt+NIBzwA8SB3WyqQoJo5YYF2If1vaaghKc9sF6/4k7g+GP81vjiLCMmiw9D
 2PdtOJFUIcNkyhsyabmpdNU+5iX9x4NDeg==
X-Google-Smtp-Source: AGHT+IEIgpN4brIIIH5c1h2vXO3ZgfPn4pTIvxthJjN8rn2epWixwdwUvbT11VFOwJ00J5o+/F0mUQ==
X-Received: by 2002:a05:600c:35cb:b0:434:a386:6cf with SMTP id
 5b1f17b1804b1-43668548b49mr387939705e9.2.1735917146195; 
 Fri, 03 Jan 2025 07:12:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:3084:b2a4:688f:2d3a?
 ([2a01:e0a:982:cbb0:3084:b2a4:688f:2d3a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b442dasm517445545e9.42.2025.01.03.07.12.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 07:12:25 -0800 (PST)
Message-ID: <0930426c-8101-460a-b35c-1f0524c3cf7d@linaro.org>
Date: Fri, 3 Jan 2025 16:12:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 2/5] clk/qcom: add initial clock driver for qcs9100
To: Varadarajan Narayanan <quic_varada@quicinc.com>, trini@konsulko.com,
 caleb.connolly@linaro.org, sumit.garg@linaro.org, lukma@denx.de,
 seanga2@gmail.com, ilias.apalodimas@linaro.org, sjg@chromium.org,
 Volodymyr_Babchuk@epam.com, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250103051404.1965469-1-quic_varada@quicinc.com>
 <20250103051404.1965469-3-quic_varada@quicinc.com>
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
In-Reply-To: <20250103051404.1965469-3-quic_varada@quicinc.com>
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

On 03/01/2025 06:14, Varadarajan Narayanan wrote:
> Add initial set of clocks and resets for enabling U-Boot on QCS9100
> based Ride platforms.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>   drivers/clk/qcom/Kconfig         |   8 ++
>   drivers/clk/qcom/Makefile        |   1 +
>   drivers/clk/qcom/clock-sa8775p.c | 142 +++++++++++++++++++++++++++++++
>   3 files changed, 151 insertions(+)
>   create mode 100644 drivers/clk/qcom/clock-sa8775p.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index d76fca5dba..ad5797ab85 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -103,6 +103,14 @@ config CLK_QCOM_SC7280
>   	  on the Snapdragon SC7280 SoC. This driver supports the clocks
>   	  and resets exposed by the GCC hardware block.
>   
> +config CLK_QCOM_SA8775P
> +        bool "Qualcomm SA8775 GCC"
> +        select CLK_QCOM
> +        help
> +          Say Y here to enable support for the Global Clock Controller
> +          on the Snapdragon SA8775 SoC. This driver supports the clocks
> +          and resets exposed by the GCC hardware block.
> +
>   endmenu
>   
>   endif
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index ab33f1c5fa..01b541af32 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -15,3 +15,4 @@ obj-$(CONFIG_CLK_QCOM_SM8150) += clock-sm8150.o
>   obj-$(CONFIG_CLK_QCOM_SM8250) += clock-sm8250.o
>   obj-$(CONFIG_CLK_QCOM_SM8550) += clock-sm8550.o
>   obj-$(CONFIG_CLK_QCOM_SM8650) += clock-sm8650.o
> +obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
> diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
> new file mode 100644
> index 0000000000..e31f24ed4f
> --- /dev/null
> +++ b/drivers/clk/qcom/clock-sa8775p.c
> @@ -0,0 +1,142 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Clock drivers for Qualcomm sa8775p
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
> +#include <dt-bindings/clock/qcom,sa8775p-gcc.h>
> +#include "clock-qcom.h"
> +
> +#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf038
> +#define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf020
> +
> +static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +	if (clk->id < priv->data->num_clks)
> +		debug("%s: %s, requested rate=%ld\n", __func__,
> +		      priv->data->clks[clk->id].name, rate);
> +
> +	switch (clk->id) {
> +	case GCC_USB30_PRIM_MOCK_UTMI_CLK:
> +		WARN(rate != 19200000, "Unexpected rate for USB30_PRIM_MOCK_UTMI_CLK: %lu\n", rate);
> +		clk_rcg_set_rate(priv->base, USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
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
> +static const struct gate_clk sa8775p_clks[] = {
> +	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x1b088, 1),
> +	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0x1b018, 1),
> +	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0x1b084, 1),
> +	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0x1b020, 1),
> +	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1b024, 1),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0x1b05c, 1),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1b060, 1),
> +};
> +
> +static int sa8775p_enable(struct clk *clk)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +	if (priv->data->num_clks < clk->id) {
> +		debug("%s: unknown clk id %lu\n", __func__, clk->id);
> +		return 0;
> +	}
> +
> +	debug("%s: clk %ld: %s\n", __func__, clk->id, sa8775p_clks[clk->id].name);
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
> +static const struct qcom_reset_map sa8775p_gcc_resets[] = {
> +	[GCC_CAMERA_BCR] = { 0x32000 },
> +	[GCC_DISPLAY1_BCR] = { 0xC7000 },
> +	[GCC_DISPLAY_BCR] = { 0x33000 },
> +	[GCC_EMAC0_BCR] = { 0xB6000 },
> +	[GCC_EMAC1_BCR] = { 0xB4000 },
> +	[GCC_GPU_BCR] = { 0x7D000 },
> +	[GCC_MMSS_BCR] = { 0x17000 },
> +	[GCC_PCIE_0_BCR] = { 0xa9000 },
> +	[GCC_PCIE_0_LINK_DOWN_BCR] = { 0xBF000 },
> +	[GCC_PCIE_0_NOCSR_COM_PHY_BCR] = { 0xBF008 },
> +	[GCC_PCIE_0_PHY_BCR] = { 0xAD144 },
> +	[GCC_PCIE_0_PHY_NOCSR_COM_PHY_BCR] = { 0xBF00C },
> +	[GCC_PCIE_1_BCR] = { 0x77000 },
> +	[GCC_PCIE_1_LINK_DOWN_BCR] = { 0xAE084 },
> +	[GCC_PCIE_1_NOCSR_COM_PHY_BCR] = { 0xAE090 },
> +	[GCC_PCIE_1_PHY_BCR] = { 0xAE08C },
> +	[GCC_PCIE_1_PHY_NOCSR_COM_PHY_BCR] = { 0xAE094 },
> +	[GCC_PDM_BCR] = { 0x3F000 },
> +	[GCC_QUPV3_WRAPPER_0_BCR] = { 0x23000 },
> +	[GCC_QUPV3_WRAPPER_1_BCR] = { 0x24000 },
> +	[GCC_QUPV3_WRAPPER_2_BCR] = { 0x2A000 },
> +	[GCC_QUPV3_WRAPPER_3_BCR] = { 0xC4000 },
> +	[GCC_SDCC1_BCR] = { 0x20000 },
> +	[GCC_TSCSS_BCR] = { 0x21000 },
> +	[GCC_UFS_CARD_BCR] = { 0x81000 },
> +	[GCC_UFS_PHY_BCR] = { 0x83000 },
> +};
> +
> +static const struct qcom_power_map sa8775p_gdscs[] = {
> +	[UFS_PHY_GDSC] = { 0x83004 },
> +	[USB30_PRIM_GDSC] = { 0x1B004 },
> +};
> +
> +static struct msm_clk_data sa8775_gcc_data = {
> +	.resets = sa8775p_gcc_resets,
> +	.num_resets = ARRAY_SIZE(sa8775p_gcc_resets),
> +	.clks = sa8775p_clks,
> +	.num_clks = ARRAY_SIZE(sa8775p_clks),
> +
> +	.power_domains = sa8775p_gdscs,
> +	.num_power_domains = ARRAY_SIZE(sa8775p_gdscs),
> +
> +	.enable = sa8775p_enable,
> +	.set_rate = sa8775p_set_rate,
> +};
> +
> +static const struct udevice_id gcc_sa8775p_of_match[] = {
> +	{
> +		.compatible = "qcom,sa8775p-gcc",
> +		.data = (ulong)&sa8775_gcc_data,
> +	},
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(gcc_sa8775p) = {
> +	.name		= "gcc_sa8775p",
> +	.id		= UCLASS_NOP,
> +	.of_match	= gcc_sa8775p_of_match,
> +	.bind		= qcom_cc_bind,
> +	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
> +};

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
