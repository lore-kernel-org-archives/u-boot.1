Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300BAC3ABDA
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 08:38:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85F1B82162;
	Wed, 14 May 2025 10:38:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D2sONuem";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37CE38294C; Wed, 14 May 2025 10:38:37 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B32F81DD6
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 10:38:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so3960035e9.0
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 01:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747211914; x=1747816714; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=FWequr2VWKkr+/iQHNf9qGEO9bmy5nx3cRVnnoX/oP0=;
 b=D2sONuemMU3gMpyfYqJ8oWvcSHiCB4NrA3vQc3G4FY/cl1fw5xgcFYCxEoVvB33Rnm
 AXlB4IGoYrLySQN7zn/Oaso2wIZmASIrEWg4rwxlHdSw6BTj7Gy27yBvvTiPHPm1sg5U
 CGhFSGpeIfxC3Mxf8DyD9AjWq6FhMnc4e+hT7EvG9lDjJoNsvzKRgjpHL04hP9+wAJqK
 prHBUoEl8ux6APRYpdVKQ7mf7k1KYS9Bcy74gF2poC9Jn9PZlpPcxl5mv5G2kjDFqaBs
 WymSUoCJCjjcRPpUfUDA1fff7jBFN2yn86WxPUb3ikh+v4H3BjpgIs1VeICl7gl715ZK
 DbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747211914; x=1747816714;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FWequr2VWKkr+/iQHNf9qGEO9bmy5nx3cRVnnoX/oP0=;
 b=AuiRXK4DaCRoVFXoFuO6ATfqRDWFnW9OYIz3XDcjMwbdTgD1lCexyiQfoEFJfL/zgK
 06vPNCNBgDBh/GeZ5WUadTBDnwEM0yCC1u8bUjTMD1H0x3VUb3S3aRDh+kUmBoy1F/EW
 cAaFHrJzxKBzrf6qKd8jd3V+G0M/7743SOUku976s0yJG/BPxcFbgL0yYPUweU0u5YFW
 yHRqQ9Zd5pqAa3zDRtd7g/IFv8N1tuGe8DE8ypiMWV8y+b8N4CQ9fAC5suZEZr6MceqM
 9hbK3T3QR7DlKVhwlHgR3yMfOO0nR9bsftK8/u13S/vqCluNDh05zd4B0Z6rnGfjZ8Yo
 bmuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV14gcpnxZYtuxbhft9C0qqLvwoJzq+x/Xj6EOpAddws4JDuctzss1MliCgaWIwT41KRw7n1oo=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8sU0WNvM86Wu7UhqPvDyHjgbAlnLfx7g+zTo5f97ArF+ZYp6K
 tGBjlnZ8FeHRB6phFvgyz/s2iKEr/UrSLflSAH2OcIViqQtBG/03wOuK6KyzTbQ=
X-Gm-Gg: ASbGncvNnPU+9DP1EJaYFwzIDGL7OmG8++D6bIDX5MVQ8TahN+adDr9TZ/WyvdqPI59
 oxa8gH+AI9PFP2d+27Kvoydv0B12arskBEXU3zDn0QOTo0JUNWY9zctuEpym09TLG31LOvBVhok
 f9XmgcusryJ2onZJXonzyL9ZrL+iXdqVVPB8VLvoOhXqMcrxx7L0DltccKLglpcxNzW+Ty2vwkg
 Sy3y2a0O6H/3YpcRy9CJN59K5XpuJ92cqM6R+xKbSEeNaQdW+FR6X8zuaSqiTlb6i/3WWNYbsHs
 yUVD6TNC3jko/d6sjjiZEbV8Evfk61oFAPDeN0WyQl7FJXTZxvbTAo1RLxDxFfDl4Z6tb+8lw0o
 Q977EqXw+YfJs
X-Google-Smtp-Source: AGHT+IH19DbFkG/hdtXm1d3CcNGZSbZKpFWQ90D2ppIKJ3heUfUF/qzj8wzYGUc7UHr1YOm08Kh7Xw==
X-Received: by 2002:a05:600c:37c7:b0:442:d9fb:d9a5 with SMTP id
 5b1f17b1804b1-442f1a428a5mr24040815e9.9.1747211914437; 
 Wed, 14 May 2025 01:38:34 -0700 (PDT)
Received: from [10.61.1.139] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f3951b62sm20952605e9.22.2025.05.14.01.38.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 01:38:33 -0700 (PDT)
Message-ID: <7199ea71-31c9-4531-bfd9-be800bcf61d1@linaro.org>
Date: Wed, 14 May 2025 10:38:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 3/5] clk/qcom: qcs615: Add GCC clock driver for QCS615
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 casey.connolly@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 seanga2@gmail.com, ilias.apalodimas@linaro.org, me@samcday.com,
 sjg@chromium.org, quic_varada@quicinc.com, sughosh.ganu@linaro.org,
 lehmanju@devpi.de, bhupesh.linux@gmail.com, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20250513110213.330495-1-aswin.murugan@oss.qualcomm.com>
 <20250513110213.330495-4-aswin.murugan@oss.qualcomm.com>
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
In-Reply-To: <20250513110213.330495-4-aswin.murugan@oss.qualcomm.com>
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

On 13/05/2025 13:02, Aswin Murugan wrote:
> Port Linux's gcc-qcs615.c driver to U-Boot for basic bring-up.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>   drivers/clk/qcom/Kconfig        |   8 ++
>   drivers/clk/qcom/Makefile       |   1 +
>   drivers/clk/qcom/clock-qcs615.c | 163 ++++++++++++++++++++++++++++++++
>   3 files changed, 172 insertions(+)
>   create mode 100644 drivers/clk/qcom/clock-qcs615.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 3ea01f3c969..eaac4a97376 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -55,6 +55,14 @@ config CLK_QCOM_QCS404
>   	  on the Snapdragon QCS404 SoC. This driver supports the clocks
>   	  and resets exposed by the GCC hardware block.
>   
> +config CLK_QCOM_QCS615
> +        bool "Qualcomm QCS615 GCC"
> +        select CLK_QCOM
> +        help
> +          Say Y here to enable support for the Global Clock Controller
> +          on the Snapdragon QCS615 SoC. This driver supports the clocks
> +          and resets exposed by the GCC hardware block.
> +
>   config CLK_QCOM_SA8775P
>   	bool "Qualcomm SA8775 GCC"
>   	select CLK_QCOM
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index e13fc8c1071..8f749487246 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
>   obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
>   obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
>   obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
> +obj-$(CONFIG_CLK_QCOM_QCS615) += clock-qcs615.o
>   obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
>   obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
>   obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
> diff --git a/drivers/clk/qcom/clock-qcs615.c b/drivers/clk/qcom/clock-qcs615.c
> new file mode 100644
> index 00000000000..161db0eeef5
> --- /dev/null
> +++ b/drivers/clk/qcom/clock-qcs615.c
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Clock drivers for Qualcomm qcs615
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
> +#include <dt-bindings/clock/qcom,qcs615-gcc.h>
> +#include "clock-qcom.h"
> +
> +#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0xf034
> +#define USB30_PRIM_MASTER_CLK_CMD_RCGR		0xf01c
> +#define USB3_PRIM_PHY_AUX_CMD_RCGR		0xf060
> +
> +#define GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT BIT(10)
> +#define GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT BIT(11)
> +#define GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT BIT(12)
> +#define GCC_QUPV3_WRAP0_S3_CLK_ENA_BIT BIT(13)
> +#define GCC_QUPV3_WRAP0_S4_CLK_ENA_BIT BIT(14)
> +#define GCC_QUPV3_WRAP0_S5_CLK_ENA_BIT BIT(15)
> +
> +#define GCC_QUPV3_WRAP1_S0_CLK_ENA_BIT BIT(22)
> +#define GCC_QUPV3_WRAP1_S1_CLK_ENA_BIT BIT(23)
> +#define GCC_QUPV3_WRAP1_S2_CLK_ENA_BIT BIT(24)
> +#define GCC_QUPV3_WRAP1_S3_CLK_ENA_BIT BIT(25)
> +#define GCC_QUPV3_WRAP1_S4_CLK_ENA_BIT BIT(26)
> +#define GCC_QUPV3_WRAP1_S5_CLK_ENA_BIT BIT(27)
> +
> +static ulong qcs615_set_rate(struct clk *clk, ulong rate)
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
> +				     5, 0, 0, CFG_CLK_SRC_GPLL0, 8);
> +		clk_rcg_set_rate(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR, 0, 0);
> +		return rate;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static const struct gate_clk qcs615_clks[] = {
> +	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0xf078, 1),
> +	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0xf010, 1),
> +	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0xf07c, 1),
> +	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0xf014, 1),
> +	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0xf018, 1),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf050, 1),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf054, 1),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0xf058, 1),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x5200c, GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x5200c, GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK, 0x5200c, GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK, 0x5200c, GCC_QUPV3_WRAP0_S3_CLK_ENA_BIT),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S4_CLK, 0x5200c, GCC_QUPV3_WRAP0_S4_CLK_ENA_BIT),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S5_CLK, 0x5200c, GCC_QUPV3_WRAP0_S5_CLK_ENA_BIT),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S0_CLK, 0x5200c, GCC_QUPV3_WRAP1_S0_CLK_ENA_BIT),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S1_CLK, 0x5200c, GCC_QUPV3_WRAP1_S1_CLK_ENA_BIT),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S2_CLK, 0x5200c, GCC_QUPV3_WRAP1_S2_CLK_ENA_BIT),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S3_CLK, 0x5200c, GCC_QUPV3_WRAP1_S3_CLK_ENA_BIT),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S4_CLK, 0x5200c, GCC_QUPV3_WRAP1_S4_CLK_ENA_BIT),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S5_CLK, 0x5200c, GCC_QUPV3_WRAP1_S5_CLK_ENA_BIT),
> +	GATE_CLK(GCC_DISP_HF_AXI_CLK, 0xb038, 1),
> +	GATE_CLK(GCC_DISP_AHB_CLK, 0xb032, 1)

Please replace the "1" with BIT(0)

> +};
> +
> +static int qcs615_enable(struct clk *clk)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +	if (priv->data->num_clks < clk->id) {
> +		debug("%s: unknown clk id %lu\n", __func__, clk->id);
> +		return 0;
> +	}
> +
> +	debug("%s: clk %ld: %s\n", __func__, clk->id, qcs615_clks[clk->id].name);
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
> +static const struct qcom_reset_map qcs615_gcc_resets[] = {
> +	[GCC_EMAC_BCR] = { 0x6000 },
> +	[GCC_QUSB2PHY_PRIM_BCR] = { 0xd000 },
> +	[GCC_QUSB2PHY_SEC_BCR] = { 0xd004 },
> +	[GCC_USB30_PRIM_BCR] = { 0xf000 },
> +	[GCC_USB2_PHY_SEC_BCR] = { 0x50018 },
> +	[GCC_USB3_DP_PHY_SEC_BCR] = { 0x50020 },
> +	[GCC_USB3PHY_PHY_SEC_BCR] = { 0x5001c },
> +	[GCC_PCIE_0_BCR] = { 0x6b000 },
> +	[GCC_PCIE_0_PHY_BCR] = { 0x6c01c },
> +	[GCC_PCIE_PHY_BCR] = { 0x6f000 },
> +	[GCC_PCIE_PHY_COM_BCR] = { 0x6f010 },
> +	[GCC_UFS_PHY_BCR] = { 0x77000 },
> +	[GCC_USB20_SEC_BCR] = { 0xa6000 },
> +	[GCC_USB3PHY_PHY_PRIM_SP0_BCR] = { 0x50008 },
> +	[GCC_USB3_PHY_PRIM_SP0_BCR] = { 0x50000 },
> +	[GCC_SDCC1_BCR] = { 0x12000 },
> +	[GCC_SDCC2_BCR] = { 0x14000 }
> +};
> +
> +static const struct qcom_power_map qcs615_gdscs[] = {
> +	[UFS_PHY_GDSC] = { 0x77004 },
> +	[USB30_PRIM_GDSC] = { 0xf004 },
> +};
> +
> +static struct msm_clk_data sa8775_gcc_data = {
> +	.resets = qcs615_gcc_resets,
> +	.num_resets = ARRAY_SIZE(qcs615_gcc_resets),
> +	.clks = qcs615_clks,
> +	.num_clks = ARRAY_SIZE(qcs615_clks),
> +
> +	.power_domains = qcs615_gdscs,
> +	.num_power_domains = ARRAY_SIZE(qcs615_gdscs),
> +
> +	.enable = qcs615_enable,
> +	.set_rate = qcs615_set_rate,
> +};
> +
> +static const struct udevice_id gcc_qcs615_of_match[] = {
> +	{
> +		.compatible = "qcom,qcs615-gcc",
> +		.data = (ulong)&sa8775_gcc_data,
> +	},
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(gcc_qcs615) = {
> +	.name		= "gcc_qcs615",
> +	.id		= UCLASS_NOP,
> +	.of_match	= gcc_qcs615_of_match,
> +	.bind		= qcom_cc_bind,
> +	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
> +};

With that:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
