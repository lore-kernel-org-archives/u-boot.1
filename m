Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31032CD1296
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 09:30:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE2C788166;
	Wed, 10 Apr 2024 11:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w7b9SKXk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D249787666; Wed, 10 Apr 2024 11:30:38 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD403881AF
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 11:30:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-343c2f5b50fso4296364f8f.2
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 02:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712741435; x=1713346235; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=ehrtJ0mGmHzqfuYsW3tBnzOJbfrl1JzUuSTvJwDoSgU=;
 b=w7b9SKXkeed8tJuMFxGwi4UsbHaSNNC/WlLfdpX5mT9W6x0BxGJJsaT/dDVjUmq5sh
 qnfFDKbud5t+uLSrxzkqAqTfkjBiHrB5yjuwvNNhRyDQDFs1lKtf7i61Sbij7Zg2Dym+
 bSCD+z2OrN2DVQROOuv4RGXFn2q6YI6awjYk6BWuhp4QZtO2KquIbdxrB0YbRyTc6pLc
 /IlSBK0ceucD7d/ApLExwvLi98jyj04gdgM2tgn7x3PIOL5R203NVt+V7lelrCV9Jx7l
 ToLiVq2emM4+qnyp1Mf0s3r09gA5k88BPYaA6qrt5VvStO0Zp/hlfn5j/qyW1EfdzQfE
 Cl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712741435; x=1713346235;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ehrtJ0mGmHzqfuYsW3tBnzOJbfrl1JzUuSTvJwDoSgU=;
 b=Sz9+1e+b0bJKJEoOnrQY7iennnyXFHl3qVygz975/JiILR2+fthRa7rXDw+3IpHrZ1
 SNspzQOQrzI0mHYuNxnBwWLlt3XpVWWP7v68AntSVZKcdbslhGpp/hV/r2mlu4I44TOV
 LgcYNZcXos6amKE/UA7XNqHmEQWYZ1XdPPN6y8V2WWNGl9NBpHmTuviXDmLQmflwV1nH
 Xgv7h4NQkykgsCIy9XUBh6ry9WYMGBBkDkhSkt0f7UdwafzgDbsDMfNQak0fEkKUeg/k
 2xl3B4cHTISS94jz5cCqn/vf9vG19SE9b6UfoCnwPxy3c7RZpT4fQ/UEpSNenliEatqN
 /kNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7fXLvVbHbNVQ3pfIQ7mvoiwhrwFKjYLwav84zE3WFrWw7x/oCs/rg6Shb/KykvwqOfxIMRFR4QWqStWaO3B6YRI5acA==
X-Gm-Message-State: AOJu0YxFCZJ31r/h4YoXeKva9rcJx2GrE7x8Y3tzojvtsLHyr8hmRhpZ
 iRcpjc/jfqNvn8mRATTa4FrGYDhxbXgpmrhLpMRgcPvGDJCuTVtYXeWEIRxZYmowOoXg9jsp0rm
 koCY=
X-Google-Smtp-Source: AGHT+IETUqdBwPlL+D29mtpzC+D2Tvw32JpNe/W/ussnEAHDqS6R7NE40jzPPPSsbQprpDXUoKODkA==
X-Received: by 2002:a5d:6709:0:b0:343:b942:326b with SMTP id
 o9-20020a5d6709000000b00343b942326bmr1277052wru.18.1712741434880; 
 Wed, 10 Apr 2024 02:30:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7b0c:6cd:4afa:674b?
 ([2a01:e0a:982:cbb0:7b0c:6cd:4afa:674b])
 by smtp.gmail.com with ESMTPSA id
 z8-20020adfe548000000b0034335e47102sm13332554wrm.113.2024.04.10.02.30.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Apr 2024 02:30:34 -0700 (PDT)
Message-ID: <f9a0f4e5-4593-4d12-8880-3ec31799eb2b@linaro.org>
Date: Wed, 10 Apr 2024 11:30:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/3] clk: qcom: Add SM8550 clock driver
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, u-boot@lists.denx.de
References: <20240404-topic-sm8x50-clock-v1-0-0c8ea7fad003@linaro.org>
 <20240404-topic-sm8x50-clock-v1-1-0c8ea7fad003@linaro.org>
 <CAFA6WYPwCMk2b-U0JA0nKEE-E_TSpaX7-60JYfsCT3TU_mzktg@mail.gmail.com>
 <1961c187-702b-4cb3-b37e-69d8b4658013@linaro.org>
 <CAFA6WYNEfXDa42OaF72pf3V4UH7AU_dxVjYeJBx7wnhRP3dyUw@mail.gmail.com>
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
In-Reply-To: <CAFA6WYNEfXDa42OaF72pf3V4UH7AU_dxVjYeJBx7wnhRP3dyUw@mail.gmail.com>
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

On 10/04/2024 11:27, Sumit Garg wrote:
> On Wed, 10 Apr 2024 at 14:46, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> On 10/04/2024 11:13, Sumit Garg wrote:
>>> Hi Neil,
>>>
>>> On Thu, 4 Apr 2024 at 22:16, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>>>
>>>> Add the GCC and TCSRCC clock driver for the SM8550 SoC.
>>>>
>>>> The GCC driver uses the clk-qcom infrastructure to support GDSCs,
>>>> Resets and gates. While the TCSRCC is a simpler clock driver which
>>>> only supports gates.
>>>>
>>>> The GCC enable and set_rate callbacks contains some tweaks to
>>>> setup clocks for Debug UART, SDCard controller and USB.
>>>
>>> Okay so these are the peripherals you intend to support to begin with.
>>>
>>>>
>>>> The TCSRCC gates returns the XO frequency, which is used by the
>>>> Synopsys eUSB2 driver to determine the PHY configuration.
>>>>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
>>>>    drivers/clk/qcom/Kconfig        |   8 +
>>>>    drivers/clk/qcom/Makefile       |   1 +
>>>>    drivers/clk/qcom/clock-sm8550.c | 335 ++++++++++++++++++++++++++++++++++++++++
>>>>    3 files changed, 344 insertions(+)
>>>>
>>>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>>>> index 8dae635ac2c..c908a3d19c9 100644
>>>> --- a/drivers/clk/qcom/Kconfig
>>>> +++ b/drivers/clk/qcom/Kconfig
>>>> @@ -47,6 +47,14 @@ config CLK_QCOM_SDM845
>>>>             on the Snapdragon 845 SoC. This driver supports the clocks
>>>>             and resets exposed by the GCC hardware block.
>>>>
>>>> +config CLK_QCOM_SM8550
>>>> +       bool "Qualcomm SM8550 GCC"
>>>> +       select CLK_QCOM
>>>> +       help
>>>> +         Say Y here to enable support for the Global Clock Controller
>>>> +         on the Snapdragon SM8550 SoC. This driver supports the clocks
>>>> +         and resets exposed by the GCC hardware block.
>>>> +
>>>>    endmenu
>>>>
>>>>    endif
>>>> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
>>>> index cb179fdac58..d9ac5719f49 100644
>>>> --- a/drivers/clk/qcom/Makefile
>>>> +++ b/drivers/clk/qcom/Makefile
>>>> @@ -8,3 +8,4 @@ obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
>>>>    obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
>>>>    obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
>>>>    obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
>>>> +obj-$(CONFIG_CLK_QCOM_SM8550) += clock-sm8550.o
>>>> diff --git a/drivers/clk/qcom/clock-sm8550.c b/drivers/clk/qcom/clock-sm8550.c
>>>> new file mode 100644
>>>> index 00000000000..c0249925cc7
>>>> --- /dev/null
>>>> +++ b/drivers/clk/qcom/clock-sm8550.c
>>>> @@ -0,0 +1,335 @@
>>>> +// SPDX-License-Identifier: BSD-3-Clause
>>>> +/*
>>>> + * Clock drivers for Qualcomm sm8550
>>>> + *
>>>> + * (C) Copyright 2024 Linaro Ltd.
>>>> + */
>>>> +
>>>> +#include <clk-uclass.h>
>>>> +#include <dm.h>
>>>> +#include <linux/delay.h>
>>>> +#include <errno.h>
>>>> +#include <asm/io.h>
>>>> +#include <linux/bug.h>
>>>> +#include <linux/bitops.h>
>>>> +#include <dt-bindings/clock/qcom,sm8550-gcc.h>
>>>> +#include <dt-bindings/clock/qcom,sm8550-tcsr.h>
>>>> +
>>>> +#include "clock-qcom.h"
>>>> +
>>>> +/* On-board TCXO, TOFIX get from DT */
>>>> +#define TCXO_RATE      38400000
>>>> +
>>>> +/* bi_tcxo_div2 divided after RPMh output */
>>>> +#define TCXO_DIV2_RATE (TCXO_RATE / 2)
>>>> +
>>>> +static const struct freq_tbl ftbl_gcc_qupv3_wrap1_s2_clk_src[] = {
>>>> +       F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
>>>> +       F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
>>>> +       F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
>>>> +       F(29491200, CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
>>>> +       F(32000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 75),
>>>> +       F(48000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 25),
>>>> +       F(51200000, CFG_CLK_SRC_GPLL0_EVEN, 1, 64, 375),
>>>> +       F(64000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 16, 75),
>>>> +       F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
>>>> +       F(80000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 15),
>>>> +       F(96000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 25),
>>>> +       F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
>>>> +       { }
>>>> +};
>>>> +
>>>> +static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
>>>> +       F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
>>>> +       F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
>>>> +       F(37500000, CFG_CLK_SRC_GPLL0_EVEN, 8, 0, 0),
>>>> +       F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
>>>> +       F(100000000, CFG_CLK_SRC_GPLL0_EVEN, 3, 0, 0),
>>>> +       /* TOFIX F(202000000, CFG_CLK_SRC_GPLL9, 4, 0, 0), */
>>>> +       { }
>>>> +};
>>>> +
>>>> +static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
>>>> +       F(66666667, CFG_CLK_SRC_GPLL0_EVEN, 4.5, 0, 0),
>>>> +       F(133333333, CFG_CLK_SRC_GPLL0, 4.5, 0, 0),
>>>> +       F(200000000, CFG_CLK_SRC_GPLL0, 3, 0, 0),
>>>> +       F(240000000, CFG_CLK_SRC_GPLL0, 2.5, 0, 0),
>>>> +       { }
>>>> +};
>>>> +
>>>> +static ulong sm8550_set_rate(struct clk *clk, ulong rate)
>>>> +{
>>>> +       struct msm_clk_priv *priv = dev_get_priv(clk->dev);
>>>> +       const struct freq_tbl *freq;
>>>> +
>>>> +       switch (clk->id) {
>>>> +       case GCC_QUPV3_WRAP1_S7_CLK: /* UART7 */
>>>> +               freq = qcom_find_freq(ftbl_gcc_qupv3_wrap1_s2_clk_src, rate);
>>>> +               clk_rcg_set_rate_mnd(priv->base, 0x18898,
>>>> +                                    freq->pre_div, freq->m, freq->n, freq->src, 16);
>>>> +               return freq->freq;
>>>> +       case GCC_SDCC2_APPS_CLK:
>>>> +               freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
>>>> +               clk_rcg_set_rate_mnd(priv->base, 0x14018,
>>>> +                                    freq->pre_div, freq->m, freq->n, freq->src, 8);
>>>> +               return freq->freq;
>>>> +       case GCC_USB30_PRIM_MASTER_CLK:
>>>> +               freq = qcom_find_freq(ftbl_gcc_usb30_prim_master_clk_src, rate);
>>>> +               clk_rcg_set_rate_mnd(priv->base, 0x3902c,
>>>> +                                    freq->pre_div, freq->m, freq->n, freq->src, 8);
>>>> +               return freq->freq;
>>>> +       case GCC_USB30_PRIM_MOCK_UTMI_CLK:
>>>> +               clk_rcg_set_rate(priv->base, 0x39044, 0, 0);
>>>> +               return TCXO_DIV2_RATE;
>>>> +       case GCC_USB3_PRIM_PHY_AUX_CLK_SRC:
>>>> +               clk_rcg_set_rate(priv->base, 0x39070, 0, 0);
>>>> +               return TCXO_DIV2_RATE;
>>>> +       default:
>>>> +               return 0;
>>>> +       }
>>>> +}
>>>> +
>>>> +static const struct gate_clk sm8550_clks[] = {
>>>> +       GATE_CLK(GCC_AGGRE_NOC_PCIE_AXI_CLK,            0x52000, BIT(12)),
>>>> +       GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK,             0x770e4, BIT(0)),
>>>> +       GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_HW_CTL_CLK,      0x770e4, BIT(1)),
>>>> +       GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK,           0x3908c, BIT(0)),
>>>> +       GATE_CLK(GCC_CNOC_PCIE_SF_AXI_CLK,              0x52008, BIT(6)),
>>>> +       GATE_CLK(GCC_DDRSS_GPU_AXI_CLK,                 0x71154, BIT(0)),
>>>> +       GATE_CLK(GCC_DDRSS_PCIE_SF_QTB_CLK,             0x52000, BIT(19)),
>>>> +       GATE_CLK(GCC_PCIE_0_AUX_CLK,                    0x52008, BIT(3)),
>>>> +       GATE_CLK(GCC_PCIE_0_CFG_AHB_CLK,                0x52008, BIT(2)),
>>>> +       GATE_CLK(GCC_PCIE_0_MSTR_AXI_CLK,               0x52008, BIT(1)),
>>>> +       GATE_CLK(GCC_PCIE_0_PHY_RCHNG_CLK,              0x52000, BIT(22)),
>>>> +       GATE_CLK(GCC_PCIE_0_PIPE_CLK,                   0x52008, BIT(4)),
>>>> +       GATE_CLK(GCC_PCIE_0_SLV_AXI_CLK,                0x52008, BIT(0)),
>>>> +       GATE_CLK(GCC_PCIE_0_SLV_Q2A_AXI_CLK,            0x52008, BIT(5)),
>>>> +       GATE_CLK(GCC_PCIE_1_AUX_CLK,                    0x52000, BIT(29)),
>>>> +       GATE_CLK(GCC_PCIE_1_CFG_AHB_CLK,                0x52000, BIT(28)),
>>>> +       GATE_CLK(GCC_PCIE_1_MSTR_AXI_CLK,               0x52000, BIT(27)),
>>>> +       GATE_CLK(GCC_PCIE_1_PHY_AUX_CLK,                0x52000, BIT(24)),
>>>> +       GATE_CLK(GCC_PCIE_1_PHY_RCHNG_CLK,              0x52000, BIT(23)),
>>>> +       GATE_CLK(GCC_PCIE_1_PIPE_CLK,                   0x52000, BIT(30)),
>>>> +       GATE_CLK(GCC_PCIE_1_SLV_AXI_CLK,                0x52000, BIT(26)),
>>>> +       GATE_CLK(GCC_PCIE_1_SLV_Q2A_AXI_CLK,            0x52000, BIT(25)),
>>>> +       GATE_CLK(GCC_QUPV3_I2C_CORE_CLK,                0x52008, BIT(8)),
>>>> +       GATE_CLK(GCC_QUPV3_I2C_S0_CLK,                  0x52008, BIT(10)),
>>>> +       GATE_CLK(GCC_QUPV3_I2C_S1_CLK,                  0x52008, BIT(11)),
>>>> +       GATE_CLK(GCC_QUPV3_I2C_S2_CLK,                  0x52008, BIT(12)),
>>>> +       GATE_CLK(GCC_QUPV3_I2C_S3_CLK,                  0x52008, BIT(13)),
>>>> +       GATE_CLK(GCC_QUPV3_I2C_S4_CLK,                  0x52008, BIT(14)),
>>>> +       GATE_CLK(GCC_QUPV3_I2C_S5_CLK,                  0x52008, BIT(15)),
>>>> +       GATE_CLK(GCC_QUPV3_I2C_S6_CLK,                  0x52008, BIT(16)),
>>>> +       GATE_CLK(GCC_QUPV3_I2C_S7_CLK,                  0x52008, BIT(17)),
>>>> +       GATE_CLK(GCC_QUPV3_I2C_S8_CLK,                  0x52010, BIT(14)),
>>>> +       GATE_CLK(GCC_QUPV3_I2C_S9_CLK,                  0x52010, BIT(15)),
>>>> +       GATE_CLK(GCC_QUPV3_I2C_S_AHB_CLK,               0x52008, BIT(7)),
>>>> +       GATE_CLK(GCC_QUPV3_WRAP1_CORE_2X_CLK,           0x52008, BIT(18)),
>>>> +       GATE_CLK(GCC_QUPV3_WRAP1_CORE_CLK,              0x52008, BIT(19)),
>>>> +       GATE_CLK(GCC_QUPV3_WRAP1_S0_CLK,                0x52008, BIT(22)),
>>>> +       GATE_CLK(GCC_QUPV3_WRAP1_S1_CLK,                0x52008, BIT(23)),
>>>> +       GATE_CLK(GCC_QUPV3_WRAP1_S2_CLK,                0x52008, BIT(24)),
>>>> +       GATE_CLK(GCC_QUPV3_WRAP1_S3_CLK,                0x52008, BIT(25)),
>>>> +       GATE_CLK(GCC_QUPV3_WRAP1_S4_CLK,                0x52008, BIT(26)),
>>>> +       GATE_CLK(GCC_QUPV3_WRAP1_S5_CLK,                0x52008, BIT(27)),
>>>> +       GATE_CLK(GCC_QUPV3_WRAP1_S6_CLK,                0x52008, BIT(28)),
>>>> +       GATE_CLK(GCC_QUPV3_WRAP1_S7_CLK,                0x52010, BIT(16)),
>>>> +       GATE_CLK(GCC_QUPV3_WRAP2_CORE_2X_CLK,           0x52010, BIT(3)),
>>>> +       GATE_CLK(GCC_QUPV3_WRAP2_CORE_CLK,              0x52010, BIT(0)),
>>>> +       GATE_CLK(GCC_QUPV3_WRAP2_S0_CLK,                0x52010, BIT(4)),
>>>> +       GATE_CLK(GCC_QUPV3_WRAP2_S1_CLK,                0x52010, BIT(5)),
>>>> +       GATE_CLK(GCC_QUPV3_WRAP2_S2_CLK,                0x52010, BIT(6)),
>>>> +       GATE_CLK(GCC_QUPV3_WRAP2_S3_CLK,                0x52010, BIT(7)),
>>>> +       GATE_CLK(GCC_QUPV3_WRAP2_S4_CLK,                0x52010, BIT(8)),
>>>> +       GATE_CLK(GCC_QUPV3_WRAP2_S5_CLK,                0x52010, BIT(9)),
>>>> +       GATE_CLK(GCC_QUPV3_WRAP2_S6_CLK,                0x52010, BIT(10)),
>>>> +       GATE_CLK(GCC_QUPV3_WRAP2_S7_CLK,                0x52010, BIT(17)),
>>>> +       GATE_CLK(GCC_QUPV3_WRAP_1_M_AHB_CLK,            0x52008, BIT(20)),
>>>> +       GATE_CLK(GCC_QUPV3_WRAP_1_S_AHB_CLK,            0x52008, BIT(21)),
>>>> +       GATE_CLK(GCC_QUPV3_WRAP_2_M_AHB_CLK,            0x52010, BIT(2)),
>>>> +       GATE_CLK(GCC_QUPV3_WRAP_2_S_AHB_CLK,            0x52010, BIT(1)),
>>>> +       GATE_CLK(GCC_SDCC2_AHB_CLK,                     0x14010, BIT(0)),
>>>> +       GATE_CLK(GCC_SDCC2_APPS_CLK,                    0x14004, BIT(0)),
>>>> +       GATE_CLK(GCC_UFS_PHY_AHB_CLK,                   0x77024, BIT(0)),
>>>> +       GATE_CLK(GCC_UFS_PHY_AXI_CLK,                   0x77018, BIT(0)),
>>>> +       GATE_CLK(GCC_UFS_PHY_AXI_HW_CTL_CLK,            0x77018, BIT(1)),
>>>> +       GATE_CLK(GCC_UFS_PHY_ICE_CORE_CLK,              0x77074, BIT(0)),
>>>> +       GATE_CLK(GCC_UFS_PHY_ICE_CORE_HW_CTL_CLK,       0x77074, BIT(1)),
>>>> +       GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK,               0x770b0, BIT(0)),
>>>> +       GATE_CLK(GCC_UFS_PHY_PHY_AUX_HW_CTL_CLK,        0x770b0, BIT(1)),
>>>> +       GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK,           0x7702c, BIT(0)),
>>>> +       GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_1_CLK,           0x770cc, BIT(0)),
>>>> +       GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK,           0x77028, BIT(0)),
>>>> +       GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK,           0x77068, BIT(0)),
>>>> +       GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_HW_CTL_CLK,    0x77068, BIT(1)),
>>>> +       GATE_CLK(GCC_USB30_PRIM_MASTER_CLK,             0x39018, BIT(0)),
>>>> +       GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK,          0x39028, BIT(0)),
>>>> +       GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK,              0x39024, BIT(0)),
>>>> +       GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK,             0x39060, BIT(0)),
>>>> +       GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK,         0x39064, BIT(0)),
>>>> +       GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK,            0x39068, BIT(0)),
>>>> +};
>>>
>>> Shouldn't this list be trimmed down to supported peripherals only?
>>
>> It's already the case, I also intend to support PCIe so I added the gates already,
>> it would need some proper support in sm8550_set_rate/sm8550_enable when I'll
>> figure out what's needed.
> 
> Is that all you need? Do we have the Qcom PCIe driver in U-Boot to
> start with? So please don't add unsupported code.

Saying it's unsupported code is quite exagerated, not sure I'm aligned on your position.

Neil

> 
> -Sumit

