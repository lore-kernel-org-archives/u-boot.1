Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF2DC3ABD9
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 08:39:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA89D82162;
	Wed, 14 May 2025 10:39:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NazhEFp+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7831C8294C; Wed, 14 May 2025 10:39:38 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5640581DD6
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 10:39:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a0b9c371d8so5494682f8f.0
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 01:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747211976; x=1747816776; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=5Ll6RkeRFF55Eo5DoHQr3oi+J1geKgKFAciaWkkAbao=;
 b=NazhEFp+/+OLs2NQJGhk5gGVI6vNf2v6ptLVaAa39dtdFfyQWvo7FnD0IxzSxzdcyk
 O7PAszyJtyzPLYqQQe2Q1YD9b9hxrNlAV6FeZdLyQRSUOpwGz2wcITmjZcn1XYM21l6b
 SVTcWRNIvI53+ItMoCbuphRLarYVvIZkbM3VMI1XZtliDnN1qhjqsohR56vbEiW854DU
 ACEm4w8VUDILgmTRIb93H7CeYe6MZPL2xQ6r+Zv2TEN9aDPXagWHcAL1ycsPK++ZUw8K
 k2SAAcOVlXgN4nGJ/NawSdXR9Woiexejn+O5FhJO5NRok9OLB3/FQja/A6GS3fixHC2q
 LOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747211976; x=1747816776;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5Ll6RkeRFF55Eo5DoHQr3oi+J1geKgKFAciaWkkAbao=;
 b=OXKucirrtuzmLNDkWwgspSEIDSe4Zg7hM8tNWNDp6AZ8iE9d69bigPoUNW6tTT5ZkL
 KcFmM/kY6HWPLakvKqlAIAoANwNr6R5AdRsAVbEWaae9TvKO6HVgONX68dqyyIDt0SUu
 Rln6PBWv44rVuX4AJYFLFOtgFU6kjvYZC+u+Tocj62BqgNUjdzu+Vj9aAYNaDgYTF1Lh
 BONpVrHoH4QoqlSZK9FT+a9SeSxzdwX/U0gtYwSDcFkK4C40e0eoocFo6+bSFIw4FQfJ
 C2yv+scpPxNtZdSXcbgjnYW9EuaaDNT5WCSOHmxUrFdYl8x5YZCT2ChLSqX1CB3E03Jl
 3/Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfl8XFFEdJIL9zL7e2YnrgvlJXFbCRLl3hWzDGi3sF2B0FH0ENFX7raBHlCT07WD0znKxWUVg=@lists.denx.de
X-Gm-Message-State: AOJu0Yxweog5FtxNeYke4YOoKDtrbDDajK/M4uc6uMqsuYAaVlgOzgMB
 s1zS524Uvq3MNvqbInVmrTlOkmkaE9yOx7wZUBK6uJT4t9RC5QBl39JE11FP9dk=
X-Gm-Gg: ASbGncv7L5+indEkGMQSf3R0Bi48BOxduR1FWoH6+RoKBxWRtNco9MYIYenkdNytJQE
 2tdEGcCyfBdU1SIKAv+ypFSAIYFg02gFrD0/gtcope8UJwm+x2CwUq6rDSzfaVf9kSCw+BSPdKF
 E7i3WM+i1EgU86AefAw6qyy6MR1mrbhWusqzO93nbT6ItDiwJmPO8hWSIjZhHgKLcXQGwu/vAk5
 vJU9ytv/IyB3OBZslin30zlunz49lbJjj/Ei7zMd7Zjpg51ot1WT+JR4OyNDN2IUjmlPIXuLOIb
 fvtZ83OegXw4BSGM0uah5r2qXye4PEcryC0pho+wVRzYemIHNofa745NslHQb3BM3J6F230anXL
 j7t3waMwrBp7D
X-Google-Smtp-Source: AGHT+IEgVJXKXMmXXUDor7alEpdqkoqxbGpwpi/FL5VwmeorL4r06lXF65i1e9vIMr4G6fPwNR08bg==
X-Received: by 2002:a5d:5f42:0:b0:3a0:aed9:e39 with SMTP id
 ffacd0b85a97d-3a3496bf2ecmr1833457f8f.28.1747211975699; 
 Wed, 14 May 2025 01:39:35 -0700 (PDT)
Received: from [10.61.1.139] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a4c7b2sm19052457f8f.93.2025.05.14.01.39.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 01:39:35 -0700 (PDT)
Message-ID: <1bfc9169-9144-4c01-a4e4-31c153468813@linaro.org>
Date: Wed, 14 May 2025 10:39:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 3/6] clk/qcom: qcs8300: Add GCC clock driver for QCS8300
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, casey.connolly@linaro.org, sumit.garg@kernel.org,
 lukma@denx.de, seanga2@gmail.com, ilias.apalodimas@linaro.org,
 me@samcday.com, christopher.obbard@linaro.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, sjg@chromium.org,
 bhupesh.linux@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250514044212.1422714-1-balaji.selvanathan@oss.qualcomm.com>
 <20250514044212.1422714-4-balaji.selvanathan@oss.qualcomm.com>
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
In-Reply-To: <20250514044212.1422714-4-balaji.selvanathan@oss.qualcomm.com>
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

On 14/05/2025 06:42, Balaji Selvanathan wrote:
> * Port Linux's gcc-qcs8300.c driver to U-Boot for basic bring-up.
> 
> * Enable QCS8300 clocks in qcom_defconfig.
> 
> Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v2:
> - Arranged the configs in Kconfig file in alphabetical order
> - Took care of alphabetical order in Makefile
> ---
>   drivers/clk/qcom/Kconfig         |   8 ++
>   drivers/clk/qcom/Makefile        |   1 +
>   drivers/clk/qcom/clock-qcs8300.c | 146 +++++++++++++++++++++++++++++++
>   3 files changed, 155 insertions(+)
>   create mode 100644 drivers/clk/qcom/clock-qcs8300.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 3ea01f3c969..0544556c672 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -55,6 +55,14 @@ config CLK_QCOM_QCS404
>   	  on the Snapdragon QCS404 SoC. This driver supports the clocks
>   	  and resets exposed by the GCC hardware block.
>   
> +config CLK_QCOM_QCS8300
> +	bool "Qualcomm QCS8300 GCC"
> +	select CLK_QCOM
> +	help
> +	  Say Y here to enable support for the Global Clock Controller
> +	  on the Snapdragon QCS8300 SoC. This driver supports the clocks
> +	  and resets exposed by the GCC hardware block.
> +
>   config CLK_QCOM_SA8775P
>   	bool "Qualcomm SA8775 GCC"
>   	select CLK_QCOM
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index e13fc8c1071..be2ec526cfe 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
>   obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
>   obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
>   obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
> +obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
>   obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
>   obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
>   obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
> diff --git a/drivers/clk/qcom/clock-qcs8300.c b/drivers/clk/qcom/clock-qcs8300.c
> new file mode 100644
> index 00000000000..f0b9a0b4fd5
> --- /dev/null
> +++ b/drivers/clk/qcom/clock-qcs8300.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024-2025, Qualcomm Innovation Center, Inc. All rights reserved.
> + *
> + */
> +
> +#include <linux/types.h>
> +#include <clk-uclass.h>
> +#include <dm.h>
> +#include <linux/delay.h>
> +#include <asm/io.h>
> +#include <linux/bug.h>
> +#include <linux/bitops.h>
> +#include <dt-bindings/clock/qcom,qcs8300-gcc.h>
> +#include "clock-qcom.h"
> +
> +#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf038
> +#define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf020
> +
> +static ulong qcs8300_set_rate(struct clk *clk, ulong rate)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +	if (clk->id < priv->data->num_clks)
> +		debug("%s: %s, requested rate=%ld\n",
> +		      __func__, priv->data->clks[clk->id].name, rate);
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
> +static const struct gate_clk qcs8300_clks[] = {
> +	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x1b088, 1),
> +	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0x1b018, 1),
> +	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0x1b084, 1),
> +	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0x1b020, 1),
> +	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1b024, 1),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0x1b05c, 1),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1b060, 1),
> +	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x83020, 1),
> +	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x83018, 1),
> +	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x830d4, 1),
> +	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x83064, 1),

Please replace "1" with BIT(0) is you re-spin

Thanks,
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

> +};
> +
> +static int qcs8300_enable(struct clk *clk)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +	if (priv->data->num_clks < clk->id) {
> +		debug("%s: unknown clk id %lu\n", __func__, clk->id);
> +		return 0;
> +	}
> +
> +	debug("%s: clk %ld: %s\n", __func__, clk->id, qcs8300_clks[clk->id].name);
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
> +static const struct qcom_reset_map qcs8300_gcc_resets[] = {
> +	[GCC_EMAC0_BCR] = { 0xb6000 },
> +	[GCC_PCIE_0_BCR] = { 0xa9000 },
> +	[GCC_PCIE_0_LINK_DOWN_BCR] = { 0xbf000 },
> +	[GCC_PCIE_0_NOCSR_COM_PHY_BCR] = { 0xbf008 },
> +	[GCC_PCIE_0_PHY_BCR] = { 0xa9144 },
> +	[GCC_PCIE_0_PHY_NOCSR_COM_PHY_BCR] = { 0xbf00c },
> +	[GCC_PCIE_1_BCR] = { 0x77000 },
> +	[GCC_PCIE_1_LINK_DOWN_BCR] = { 0xae084 },
> +	[GCC_PCIE_1_NOCSR_COM_PHY_BCR] = { 0xae090 },
> +	[GCC_PCIE_1_PHY_BCR] = { 0xae08c },
> +	[GCC_PCIE_1_PHY_NOCSR_COM_PHY_BCR] = { 0xae094 },
> +	[GCC_SDCC1_BCR] = { 0x20000 },
> +	[GCC_UFS_PHY_BCR] = { 0x83000 },
> +	[GCC_USB20_PRIM_BCR] = { 0x1c000 },
> +	[GCC_USB2_PHY_PRIM_BCR] = { 0x5c01c },
> +	[GCC_USB2_PHY_SEC_BCR] = { 0x5c020 },
> +	[GCC_USB30_PRIM_BCR] = { 0x1b000 },
> +	[GCC_USB3_DP_PHY_PRIM_BCR] = { 0x5c008 },
> +	[GCC_USB3_PHY_PRIM_BCR] = { 0x5c000 },
> +	[GCC_USB3_PHY_TERT_BCR] = { 0x5c024 },
> +	[GCC_USB3_UNIPHY_MP0_BCR] = { 0x5c00c },
> +	[GCC_USB3_UNIPHY_MP1_BCR] = { 0x5c010 },
> +	[GCC_USB3PHY_PHY_PRIM_BCR] = { 0x5c004 },
> +	[GCC_USB3UNIPHY_PHY_MP0_BCR] = { 0x5c014 },
> +	[GCC_USB3UNIPHY_PHY_MP1_BCR] = { 0x5c018 },
> +	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x76000 },
> +	[GCC_VIDEO_BCR] = { 0x34000 },
> +};
> +
> +static const struct qcom_power_map qcs8300_gdscs[] = {
> +	[GCC_UFS_PHY_GDSC] = { 0x83004 },
> +	[GCC_USB30_PRIM_GDSC] = { 0x1B004 },
> +};
> +
> +static struct msm_clk_data qcs8300_gcc_data = {
> +	.resets = qcs8300_gcc_resets,
> +	.num_resets = ARRAY_SIZE(qcs8300_gcc_resets),
> +	.clks = qcs8300_clks,
> +	.num_clks = ARRAY_SIZE(qcs8300_clks),
> +
> +	.power_domains = qcs8300_gdscs,
> +	.num_power_domains = ARRAY_SIZE(qcs8300_gdscs),
> +
> +	.enable = qcs8300_enable,
> +	.set_rate = qcs8300_set_rate,
> +};
> +
> +static const struct udevice_id gcc_qcs8300_of_match[] = {
> +	{
> +		.compatible = "qcom,qcs8300-gcc",
> +		.data = (ulong)&qcs8300_gcc_data,
> +	},
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(gcc_qcs8300) = {
> +	.name		= "gcc_qcs8300",
> +	.id		= UCLASS_NOP,
> +	.of_match	= gcc_qcs8300_of_match,
> +	.bind		= qcom_cc_bind,
> +	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
> +};

