Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D822C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 16:11:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E302C82AA7;
	Tue,  3 Jun 2025 18:11:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yxpc/sSw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20D5082AAA; Tue,  3 Jun 2025 18:10:59 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A08E682A76
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 18:10:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a3673e12c4so3898530f8f.2
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 09:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748967056; x=1749571856; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SpSs5UNpTZLdtjvHXgHzyw77vfpE9v/y6yc/rWtb2Sk=;
 b=yxpc/sSwR0/YVhbItF40G/TEmIwNSwPxEpstXZY371T1/tctWJ/aVdBBe0Ji0SpXV7
 4cZgMHzVQEADI8mT0u+MLzQCok1TOrixfBtq+jof5Uy6Hb3GigpsDgFLNGZOD14fUD8A
 Kw8vlQKrImJLV1dE0BV2Wh0vmkueeVRD0XQZ+rCgxjSI4epWzLFVfydZNK/Gy6tIpA0Y
 SBNKFNLQwdyq5nfDLwstW4y5yFWU8ENAY1SRmcePERq1wDOr+ugwOOw1XlYWZCefyYVB
 2NJOBAmeo5JwDjGEO7WCqTNZk/UkHFT/DwVM5D+V+k87RttwFQ5tRGVZtBtgIEbC7WLG
 5BdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748967056; x=1749571856;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SpSs5UNpTZLdtjvHXgHzyw77vfpE9v/y6yc/rWtb2Sk=;
 b=azDJ02zJLWy+FrPVsiiA8/OM7XX/4L+0cqYphvplOZpf6+KPnmYHnobRKWXGuk4dF6
 XDbpe8emW9Y702ZTGlLIytmir5rfrXijUuZd155aCq16GlMfBLKAT4cVfelKWDYil/i7
 NRy+8PuHTT77g3WCF7iLCYYdCulP9Gapf4/AC4SMS9OaFh9ZsoprFt7qJMduS8VKP7jd
 UBmpzENQYs2hv332qMwEaBJQreUaFsPk9ylJInAHuyuCU7edktAKvvGQJv/d6rEmRmcV
 A/39QUPn2q8FAuMP310nITViKMEWT1EHPkjq/MqSwvcfzgzZTTzNGiMoK2EeGMoPWFGA
 af7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfJJzd63+EjJsveRxV7OEzNtO/mLiDXYOXIPeoM9wiLPvjEcBANZJTT5nZKIfFmPpqnoT/2G0=@lists.denx.de
X-Gm-Message-State: AOJu0YyxMJNBb1er9m7w+KeTy3pRmSlZ8Pr5OVJWinriz/EeJ6hsLdXn
 puhLVf31cIFLxquK2EAPg/UF3sR8Zl9k7Acpm6Tf/oarAHMwmmIrZDGukaK7tVyN1PU=
X-Gm-Gg: ASbGncsmAPgJaCBy8PqF9OWgWDM/8wEpt4XfwwK2TPlzXhK7WAcgIxtJsVplSI15oJ9
 7Zqh7Njwia/kwStWSX26xOKFFyWOYNtw3M6uImbY3kuyYvkjYYBKOGRCyelX0W4oYe0fLsPB6ea
 OHlxoAlA5AkzepcGzGpu0o2aEJgaV9N4kuQN2SDafJCvSedcrjTWIlbTWSzYLOEz4XkLb5pcpKI
 vg1GglY3XPSCji79axg7SvkuinWCbWqP6h8rXb3FC49SEA8YnSm7Lbj2LVWH+tT/V/hlQje0F4q
 Ro8L2fSHp8LOlKDM1y2N4/1XHom57dp28adOrBf4Had/pjy/96RS4w97KsQQaTuqAGHAYIusZ7f
 ElBXYIywfA0Yxsexbtk/2wstR+Q==
X-Google-Smtp-Source: AGHT+IGN/rrodV1t1j+Jw0eS2LlTj+8lPLVu0/XsXuLiTC3kqErc1sUDp38RxAK0ai0hxJY3Mx2FzA==
X-Received: by 2002:a05:6000:40dc:b0:3a5:1f2:68f3 with SMTP id
 ffacd0b85a97d-3a501f26b0emr8833396f8f.46.1748967055986; 
 Tue, 03 Jun 2025 09:10:55 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:e089:f4a9:4c4d:e359?
 ([2a01:170:117e:fc:e089:f4a9:4c4d:e359])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7f8f188sm168355945e9.3.2025.06.03.09.10.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 09:10:55 -0700 (PDT)
Message-ID: <912ff2fb-194f-4924-babd-6ac134709630@linaro.org>
Date: Tue, 3 Jun 2025 18:10:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] clk/qcom: qcs615: Add GCC clock driver for QCS615
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 seanga2@gmail.com, ilias.apalodimas@linaro.org, me@samcday.com,
 christopher.obbard@linaro.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, sjg@chromium.org, lehmanju@devpi.de,
 bhupesh.linux@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250521035324.1182833-1-aswin.murugan@oss.qualcomm.com>
 <20250521035324.1182833-4-aswin.murugan@oss.qualcomm.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250521035324.1182833-4-aswin.murugan@oss.qualcomm.com>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 5/21/25 05:53, Aswin Murugan wrote:
> Port Linux's gcc-qcs615.c driver to U-Boot for basic bring-up.
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> Changes in v2:
> - Replaced the "1" with BIT(0) in GATE_CLK()
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

FYI your formatting is wrong here, this should be tab indented. I'll fix 
this while applying. In future please run checkpatch, I recommend using 
the b4 tool which can do it all for you with "b4 prep --check" before 
sending.

Kind regards,

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
> index 00000000000..4700baba8c9
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
> +	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0xf078, BIT(0)),
> +	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0xf010, BIT(0)),
> +	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0xf07c, BIT(0)),
> +	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0xf014, BIT(0)),
> +	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0xf018, BIT(0)),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf050, BIT(0)),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf054, BIT(0)),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0xf058, BIT(0)),
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
> +	GATE_CLK(GCC_DISP_HF_AXI_CLK, 0xb038, BIT(0)),
> +	GATE_CLK(GCC_DISP_AHB_CLK, 0xb032, BIT(0))
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

-- 
Casey (she/they)

