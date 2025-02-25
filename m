Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5022BC021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 11:42:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A134C80F92;
	Tue, 25 Feb 2025 12:42:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wa3dIiVD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8665380F9E; Tue, 25 Feb 2025 12:42:49 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39AE1807B1
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 12:42:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so3090092f8f.3
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 03:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740483766; x=1741088566; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4AqAY0OeZCK7DRekaMCrtw+hB08Ec4PLGKo3TQHhqYE=;
 b=wa3dIiVDtHpwyxMInOekau8iXvhOtlUgSAHp/ZZvuY1CVwpbCTWl6h6hWzq2Rmokcf
 PP+SFRnCHzbQKFAmoxCWE6N9OxIwPZRZqn4qf3PUjmIs9F1nhOMRrDZXmF0ydVneJ9R/
 bQdVdegOecmh4ZYj3U+wm4J6iOrR1vPnLFxexSjpoDyfzL5PL1uFupqXa36wYhZzXIOF
 F09znF9NWtgSdfKvURN9oAKtlCGoBhbtmVccLQvkhXH6E4Wzo3zUDD9z6qQQ/G4xcle3
 GgEQoZCWBUnsS6egN7b/NyiwNIqO3yp9lHGWfoqXcA/MZVMQAm+4nZRBbkpgIDWR6Wu7
 a5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740483766; x=1741088566;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4AqAY0OeZCK7DRekaMCrtw+hB08Ec4PLGKo3TQHhqYE=;
 b=KXHZUbwQCWnwc8cAU0AMSp0Z1i6LCx7slbzBZ+osHao9tzV5bcQ2PPqR6ygQkR2G1I
 hi21JRQzQPl0oTZGSbLdd9YV78hOBq9NIJwpLFCwOm9jB8PPEDM00rnAr+1DpPMgKRmV
 HFa6gdFiI4nC540toI4+TnzdTm11aeJ8BkRwke1C4raUudwgkaC2w5V/cFSzYc0lY2WD
 DEqpsH/bhEwgYQZ1N/qGKzqLswJKptfEF6pJywB5ab7+N3XbT/00XvX2hPF8WSqCOuhz
 W+ASivef4SV8JeKMONQMmpMebCGZ28Pf6Z0TUU97KgFcC0NYWqjcq6ciM5FIsfss/oL8
 TS+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzN6LYKEtt9ZI+aMwUV96gLVfLB4FaVVYYQEJF+hoZY4/VxoQ6/5yKB4+fuRiMSgRp89k/RxM=@lists.denx.de
X-Gm-Message-State: AOJu0YzSZU4xA2rX8iWsk3A7jTBn00mZL8v9uTKvkL7BdBMLjMoX50ZG
 DOzfukTqaYUgSZ2tmFtc/FVI19wSszm1gWElUJZAfie1VdtHKvDqr1BEuFPZjGI=
X-Gm-Gg: ASbGncu7kzu3ijVwtz+LwSI7BIluLPIWAL2aLIHXKrfexoGQQzIeM4fsS33/E3aIYH8
 Jg6fZLI0s4SSkQcZXRsnKOLMTlk5jtPHfbSnAfspWroWStW9dKPtW4q/7OIRZmf+SaQgtVtC1ZM
 S1ZSTVobyxf7KgctZc9TGARxjPmEVuqe5ke1rQ+c0l7oDxx33NWtsaflEjrPGMhrsJlsUoLu9+W
 uU98iMiiir4tcjtsFt674jM+YxEw6KjsDZ7Abd+/8fsd+OzuhQ1DS0pKUq5PH3eI1h+ralwCpsu
 foz/Hni1HdTb77FTPZ1PAMenG7xLBAFYDKHJFwo7vn17f3euRY+FLShy/dQtfTIbUZlksnOKEIM
 4JuxszEQ=
X-Google-Smtp-Source: AGHT+IGhXn64K/T0hQqbOfJFRQK22HDGjoYV+TJpTWWsUuOFM/ONmE3mmQ8jk4frp+ONS8DqJHKdVQ==
X-Received: by 2002:a05:6000:1786:b0:38f:3e8d:dd42 with SMTP id
 ffacd0b85a97d-38f6f0d6ccemr15917045f8f.53.1740483765695; 
 Tue, 25 Feb 2025 03:42:45 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:5422:1d27:3fbc:deb3?
 ([2a0a:ef40:1d11:ab01:5422:1d27:3fbc:deb3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd882af4sm1973406f8f.47.2025.02.25.03.42.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 03:42:44 -0800 (PST)
Message-ID: <a33d1a99-9e88-4fbb-bc16-290230b174bf@linaro.org>
Date: Tue, 25 Feb 2025 11:42:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] clk/qcom: add initial clock driver for ipq9574
To: Varadarajan Narayanan <quic_varada@quicinc.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@linaro.org, lukma@denx.de,
 seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 robert.marko@sartura.hr, luka.perkov@sartura.hr, lehmanju@devpi.de,
 Volodymyr_Babchuk@epam.com, sjg@chromium.org, pbrobinson@gmail.com,
 marek.vasut+renesas@mailbox.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250225065303.342174-1-quic_varada@quicinc.com>
 <20250225065303.342174-4-quic_varada@quicinc.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250225065303.342174-4-quic_varada@quicinc.com>
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

Hiya,

On 2/25/25 06:52, Varadarajan Narayanan wrote:
> Add initial set of clocks and resets for enabling U-Boot on ipq9574
> based RDP platforms.
> 
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v3: Use gate clk framework
> 
> v2: Combined driver file and makefile/kconfig changes into one patch
> ---
>   drivers/clk/qcom/Kconfig         |   8 +++
>   drivers/clk/qcom/Makefile        |   1 +
>   drivers/clk/qcom/clock-ipq9574.c | 109 +++++++++++++++++++++++++++++++
>   drivers/clk/qcom/clock-qcom.h    |   1 +
>   4 files changed, 119 insertions(+)
>   create mode 100644 drivers/clk/qcom/clock-ipq9574.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index cb867acc48c..3ea01f3c969 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -31,6 +31,14 @@ config CLK_QCOM_IPQ4019
>   	  on the Snapdragon IPQ4019 SoC. This driver supports the clocks
>   	  and resets exposed by the GCC hardware block.
>   
> +config CLK_QCOM_IPQ9574
> +	bool "Qualcomm IPQ9574 GCC"
> +	select CLK_QCOM
> +	help
> +	  Say Y here to enable support for the Global Clock Controller
> +	  on the Snapdragon IPQ9574 SoC. This driver supports the clocks
> +	  and resets exposed by the GCC hardware block.
> +
>   config CLK_QCOM_QCM2290
>   	bool "Qualcomm QCM2290 GCC"
>   	select CLK_QCOM
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 1bc0f15005b..e13fc8c1071 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_CLK_QCOM_SDM845) += clock-sdm845.o
>   obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
>   obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
>   obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
> +obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
>   obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
>   obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
>   obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
> diff --git a/drivers/clk/qcom/clock-ipq9574.c b/drivers/clk/qcom/clock-ipq9574.c
> new file mode 100644
> index 00000000000..fff87036dd0
> --- /dev/null
> +++ b/drivers/clk/qcom/clock-ipq9574.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Clock drivers for Qualcomm ipq9574
> + *
> + * (C) Copyright 2025 Linaro Ltd.
> + */
> +
> +#include <linux/types.h>
> +#include <clk-uclass.h>
> +#include <dm.h>
> +#include <linux/delay.h>
> +#include <asm/io.h>
> +#include <linux/bug.h>
> +#include <linux/bitops.h>
> +#include <dt-bindings/clock/qcom,ipq9574-gcc.h>
> +#include <dt-bindings/reset/qcom,ipq9574-gcc.h>
> +
> +#include "clock-qcom.h"
> +
> +#define GCC_BLSP1_AHB_CBCR			0x1004
> +#define GCC_BLSP1_UART3_APPS_CMD_RCGR		0x402C
> +#define GCC_BLSP1_UART3_APPS_CBCR		0x4054
> +
> +#define GCC_SDCC1_APPS_CBCR			0x3302C
> +#define GCC_SDCC1_AHB_CBCR			0x33034
> +#define GCC_SDCC1_APPS_CMD_RCGR			0x33004
> +#define GCC_SDCC1_ICE_CORE_CBCR			0x33030
> +
> +static ulong ipq9574_set_rate(struct clk *clk, ulong rate)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +	switch (clk->id) {
> +	case GCC_BLSP1_UART3_APPS_CLK:
> +		clk_rcg_set_rate_mnd(priv->base, GCC_BLSP1_UART3_APPS_CMD_RCGR,
> +				     0, 144, 15625, CFG_CLK_SRC_GPLL0, 16);
> +		return rate;
> +	case GCC_SDCC1_APPS_CLK:
> +		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC1_APPS_CMD_RCGR,
> +				     11, 0, 0, CFG_CLK_SRC_GPLL2, 16);
> +		return rate;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct gate_clk ipq9574_clks[] = {
> +	GATE_CLK(GCC_BLSP1_UART3_APPS_CLK,	 0x4054, 0x00000001),
> +	GATE_CLK(GCC_BLSP1_AHB_CLK,		 0x1004, 0x00000001),
> +	GATE_CLK(GCC_SDCC1_AHB_CLK,		0x33034, 0x00000001),
> +	GATE_CLK(GCC_SDCC1_APPS_CLK,		0x3302C, 0x00000001),
> +	GATE_CLK(GCC_SDCC1_ICE_CORE_CLK,	0x33030, 0x00000001),
> +};
> +
> +static int ipq9574_enable(struct clk *clk)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +	debug("%s: clk %s\n", __func__, ipq9574_clks[clk->id].name);
> +
> +	switch (clk->id) {
> +	case GCC_BLSP1_UART3_APPS_CLK:
> +		qcom_gate_clk_en(priv, GCC_BLSP1_UART3_APPS_CLK);
> +		break;
> +	case GCC_BLSP1_AHB_CLK:
> +		qcom_gate_clk_en(priv, GCC_BLSP1_AHB_CLK);
> +		break;
> +	case GCC_SDCC1_AHB_CLK:
> +		qcom_gate_clk_en(priv, GCC_SDCC1_AHB_CLK);
> +		break;
> +	case GCC_SDCC1_APPS_CLK:
> +		qcom_gate_clk_en(priv, GCC_SDCC1_APPS_CLK);
> +		break;
> +	case GCC_SDCC1_ICE_CORE_CLK:
> +		qcom_gate_clk_en(priv, GCC_SDCC1_ICE_CORE_CLK);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

Last nitpick here, the reason I proposed using the gate_clk API is 
because it lets you drop this switch/case. Since you don't do any prep 
before enabling these clocks you can just call

	qcom_gate_clk_en(priv, clk->id);

With that fixed

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

Thanks for sticking with me on this.

Kind regards,
> +
> +	return 0;
> +}
> +
> +static const struct qcom_reset_map ipq9574_gcc_resets[] = {
> +	[GCC_SDCC_BCR] = { 0x33000 },
> +};
> +
> +static struct msm_clk_data ipq9574_gcc_data = {
> +	.resets = ipq9574_gcc_resets,
> +	.num_resets = ARRAY_SIZE(ipq9574_gcc_resets),
> +	.enable = ipq9574_enable,
> +	.set_rate = ipq9574_set_rate,
> +};
> +
> +static const struct udevice_id gcc_ipq9574_of_match[] = {
> +	{
> +		.compatible = "qcom,ipq9574-gcc",
> +		.data = (ulong)&ipq9574_gcc_data,
> +	},
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(gcc_ipq9574) = {
> +	.name		= "gcc_ipq9574",
> +	.id		= UCLASS_NOP,
> +	.of_match	= gcc_ipq9574_of_match,
> +	.bind		= qcom_cc_bind,
> +	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
> +};
> diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
> index ff336dea39c..e038dc421ec 100644
> --- a/drivers/clk/qcom/clock-qcom.h
> +++ b/drivers/clk/qcom/clock-qcom.h
> @@ -11,6 +11,7 @@
>   #define CFG_CLK_SRC_CXO   (0 << 8)
>   #define CFG_CLK_SRC_GPLL0 (1 << 8)
>   #define CFG_CLK_SRC_GPLL0_AUX2 (2 << 8)
> +#define CFG_CLK_SRC_GPLL2 (2 << 8)
>   #define CFG_CLK_SRC_GPLL9 (2 << 8)
>   #define CFG_CLK_SRC_GPLL0_ODD (3 << 8)
>   #define CFG_CLK_SRC_GPLL6 (4 << 8)

-- 
Caleb (they/them)

