Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E47AC02182
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 15:34:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BA8A807EC;
	Wed, 22 Jan 2025 16:34:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i5PYDvl9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 689D880805; Wed, 22 Jan 2025 16:34:18 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A159807E9
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 16:34:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d41848901bso2213037a12.0
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 07:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737560055; x=1738164855; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DI+IQpbl30II+lJrHDIqfNS950U8Zz8eUfH2MvMVjLs=;
 b=i5PYDvl9lmUW+Ws4n6019H7eg7M+vygHmQUJYsdohffIn+w0V2y4cONQ3xjxN+raqM
 Q8b69iG0V0frsiZDci6kwXG12tKivBmLC2ylIHXY8qQoVUfGm/A8fqTZF+ahUOgbCAPO
 JHSgsuAUSMjZ1fL0XiV0jxehr0grrRbjyUO+JoYx0sqPjpIHN21+OnoLHfDDWlQKFpBX
 HGNoWp8W4IgXDI+bA3GVYKVHqB+SewR7n+Yd09Bw/EjcbNqSZPcYHKpA+/30Ffz6KeJA
 z0qTuuB0QdaNIGi1a0YBlGjGVSbipwFs0vzVqrIV/Gn9kM2l8B30u5RGS30HO4G127wh
 1gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737560055; x=1738164855;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DI+IQpbl30II+lJrHDIqfNS950U8Zz8eUfH2MvMVjLs=;
 b=Ff48OFedTgRVVb/dpkf9h0KGzYEZfPhXVIFOK9NG92HGlEr/seqSg86WQc2RZNsSE/
 BJy0E+rmj47J70x5wWaPd12SM2E/k0cMP4LszrrFX3+/ia/Qs6viQoNOzKAMe+ZCHhdv
 Y8qYe2va0HvPnP8DkFihpcohafvd+1+vnZYoc/Zfd20+SIxKl23v5lDr2D1FPzengBv0
 TWYaMKwbExpC9XjeFTUE/etvjnMKekge216UwYmwHjx8JpSvBQIU/2nue1fFYayU1gC6
 /KQnN6iI2bI5KzoM79xm2R6EnrMjXSS1LeANTXPgJIU/MoE48M22bQdL1CvEc/JZah3z
 IuTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlriV5lvLPadvIChgF574GvyoUD4yMJMsVp1LZPkF2dqIaqIwyZyV0oWV+LYgahTb5diBTEMg=@lists.denx.de
X-Gm-Message-State: AOJu0YxHA3J6vKseOYwY/u0b5lJ2Af3DaYbhHwZG7CZYIryo4m6IgEVH
 TB4szNYa1QIxyzmDJhuJCKUP9uGR05cwDi9moyBjj6J7GeU3GYI9DkkpjXH46Zs=
X-Gm-Gg: ASbGncv9ZpMwrPwSGeF7TtM8sGEWv7bJ/oUwSTOtrudCxvOsxR0EVRSkupQcvt4dRqt
 fMOTryllWNztpaxsz9C2Z1ST4HYkmaSy0jwfwSdGopYN/B6WyvKw1Yc/8FKuSlHXkg6ndjumQAF
 OMFSXYYh59YagrFYjXbR31nTXxw3pchsPKCkP3Y50h7oaK9vaVqoeCJ3UOm4CBrWIcesL91UymN
 ipKoicotR1AmchSyCirvsHhart1a70Vg/Z5hg5sWSojYyZMqUnzgaYv+2RY5TgyZYYsdIRgp48U
 lZ0hLDioQJ/bI3w2cU42/XSMgGO3wlkLqoHcYC9fB3+eKjuK50HX
X-Google-Smtp-Source: AGHT+IGC6PhDELu/d9Z0hvpWd01YhtCA48ftOBjGMKR3On/r+rBPiwFF6YOIj135/0sjgWXIg9YHNw==
X-Received: by 2002:a50:9f26:0:b0:5db:68bd:ab71 with SMTP id
 4fb4d7f45d1cf-5db68bdaef2mr17495275a12.7.1737560055514; 
 Wed, 22 Jan 2025 07:34:15 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db73edccd4sm8810077a12.77.2025.01.22.07.34.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2025 07:34:14 -0800 (PST)
Message-ID: <dfa6e9cc-5d29-453a-8cbe-6154104814bf@linaro.org>
Date: Wed, 22 Jan 2025 16:34:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] clk/qcom: add initial clock driver for qcs9100
Content-Language: en-US
To: Varadarajan Narayanan <quic_varada@quicinc.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@linaro.org, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, ilias.apalodimas@linaro.org,
 Volodymyr_Babchuk@epam.com, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 konradybcio@kernel.org, quic_tengfan@quicinc.com, andersson@kernel.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250110050817.3819282-1-quic_varada@quicinc.com>
 <20250110050817.3819282-4-quic_varada@quicinc.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250110050817.3819282-4-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 10/01/2025 06:08, Varadarajan Narayanan wrote:
> Add initial set of clocks and resets for enabling U-Boot on QCS9100
> based Ride platforms.
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

Just a small nit: please keep the Kconfig and Makefile in alphabetical
order.

Additionally, use tabs for indentation in Kconfig files.

No need to respin, I'll fix it while applying.

Kind regards,
> ---
> v2: Add 'Reviewed-by: Neil Armstrong'
> ---
>  drivers/clk/qcom/Kconfig         |   8 ++
>  drivers/clk/qcom/Makefile        |   1 +
>  drivers/clk/qcom/clock-sa8775p.c | 142 +++++++++++++++++++++++++++++++
>  3 files changed, 151 insertions(+)
>  create mode 100644 drivers/clk/qcom/clock-sa8775p.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index d76fca5dba..ad5797ab85 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -103,6 +103,14 @@ config CLK_QCOM_SC7280
>  	  on the Snapdragon SC7280 SoC. This driver supports the clocks
>  	  and resets exposed by the GCC hardware block.
>  
> +config CLK_QCOM_SA8775P
> +        bool "Qualcomm SA8775 GCC"
> +        select CLK_QCOM
> +        help
> +          Say Y here to enable support for the Global Clock Controller
> +          on the Snapdragon SA8775 SoC. This driver supports the clocks
> +          and resets exposed by the GCC hardware block.
> +
>  endmenu
>  
>  endif
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index ab33f1c5fa..01b541af32 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -15,3 +15,4 @@ obj-$(CONFIG_CLK_QCOM_SM8150) += clock-sm8150.o
>  obj-$(CONFIG_CLK_QCOM_SM8250) += clock-sm8250.o
>  obj-$(CONFIG_CLK_QCOM_SM8550) += clock-sm8550.o
>  obj-$(CONFIG_CLK_QCOM_SM8650) += clock-sm8650.o
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

-- 
// Caleb (they/them)

