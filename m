Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C22C021A4
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 15:52:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD62C809D0;
	Wed, 12 Feb 2025 16:52:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="czRQto7n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3621C80BAE; Wed, 12 Feb 2025 16:52:06 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6AF280017
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 16:52:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38dc73cc5acso724634f8f.0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 07:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739375523; x=1739980323; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ipo3SuFTLsUFm9z0Scf+LPXFTTs34DYOrKXAvyRLmG4=;
 b=czRQto7nwf4ejrcnUoq/xSodxH30N1Rm1AXI9hdTQb3hvnN6QkdkPsbe3rfrK2v6ge
 mM004Q6PmSnW0YFRv6zes7C4HtNY7Kg4dl1EIn/h9Gwn1fkGSRBzAzMZXTvKhiDXDGZx
 DHLgsNJimSgsTlCl7Z2G1P0+sMm382GoxNOKRQBBVuNzMATo0NtoehM0XNxrR9/6/9q7
 iVY5QxVrHalhOwMu6kCQtO8jKzY6/PqX4a/w/R5UeuI+Prm1N+n6OtmWCaCUU/61Nel6
 rUlBB02I4csH9WZ8F/gK1spFZOd25f9I71O8PoSLMl6819yGbWwY6uP7Qo0FDBcisM12
 nr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739375523; x=1739980323;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ipo3SuFTLsUFm9z0Scf+LPXFTTs34DYOrKXAvyRLmG4=;
 b=OxAVIPspJBCxa2S8JcsQrQ98exBUvnjyW2f7wN+ZORHSlKIIFXs/sZJv+FLCGj4ACg
 6OEhe08Qdf38J8ZNZeNCL+hBhIF3Rqcgyrc2SyW5Y0N2H/e6VEovIG69n8JB7MmR9I7p
 +eg/75YEQ1v2Q4haX3jDaWGBVC1A7bfXYlgfRLrOr8EB/KoZ23J1FgkyQJgJlBrFjhSd
 eb0Gm1enLvnzerV0ZjZ6hwvdD9OST/mJt3ikWew8GQxaEb7HMbpN6IdyfQsUULDnb5OS
 6Kw5zrmegIGoO+ER8A1ZYWKa3yGgMJYW4dEEUCj7kU4OuL07wMLMleW6zV2XPby9PQ6D
 tulw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoJvBD9YRED+RbLcAF0Jvo8/Gfhhqllvu82kSPqH67NG+vRg287GnbvCa/Gg11gGrZDCkogpg=@lists.denx.de
X-Gm-Message-State: AOJu0YwMkSXQ5FnEWScqYVAPU5nIGjWGU+jFQ3j/JZs1XEGYTs1JJmFn
 LISaSadixaql4IXnRildoRbLhaqYi0+sPLGilxesbzThms2z2bf89aPvrevOCxI=
X-Gm-Gg: ASbGncvi+ESETJTtPBi/dyyTkAcMPH+DrFUFzTbMdq4rpTDmVHp3qAQEG5LLITHvG1s
 2VoSqyFxYa0BRG6nPlFdQy5vp1OCMeWjQ2Cb8HapQhlrtG+/pk6cH7s9se7UZ2Z92DtjrTwC68M
 Tl/dfqfapSVNZTsJa9rYmYmz/RHm2DUGsp99i4+p2boGKKsuHgYV8qwP97tjRsG3BwXplummiyQ
 ofv4RPyMXdOv21ej6+nNYYv40q6VQjMiPgi4g1Jzy7E+KAJeEAsZTljuzy4uxXwQE1XogGMoGK2
 j1Y1mVu5y7PrzcT3U2dvTsRCwMfEXihyQDvy8D67oXUMkuXIAM234ZKph4w4SbcbRJIB6Q==
X-Google-Smtp-Source: AGHT+IHnC5F1WNUVrL8+EBFcXRb9nUJqBVLg6WTdndJtr7HhicZ2JXmzeUBLNdMozPyvDX/8VsG2NQ==
X-Received: by 2002:a5d:64ac:0:b0:38d:c74f:4234 with SMTP id
 ffacd0b85a97d-38dea26a18cmr3152794f8f.29.1739375523260; 
 Wed, 12 Feb 2025 07:52:03 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:416b:3913:893e:bb4?
 ([2a0a:ef40:1d11:ab01:416b:3913:893e:bb4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc846e980sm15520582f8f.73.2025.02.12.07.52.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 07:52:02 -0800 (PST)
Message-ID: <17765ee7-9583-41e8-a2c1-51ded136070b@linaro.org>
Date: Wed, 12 Feb 2025 15:52:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] pinctrl: qcom: Add ipq9574 pinctrl driver
To: Varadarajan Narayanan <quic_varada@quicinc.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@linaro.org, lukma@denx.de,
 seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 ilias.apalodimas@linaro.org, sjg@chromium.org, Volodymyr_Babchuk@epam.com,
 lehmanju@devpi.de, pbrobinson@gmail.com, marek.vasut+renesas@mailbox.org,
 robert.marko@sartura.hr, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250130053751.3148614-1-quic_varada@quicinc.com>
 <20250130053751.3148614-4-quic_varada@quicinc.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250130053751.3148614-4-quic_varada@quicinc.com>
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



On 1/30/25 05:37, Varadarajan Narayanan wrote:
> Add pinctrl driver for the TLMM block found in the ipq9574 SoC.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>   drivers/pinctrl/qcom/Kconfig           |   7 +
>   drivers/pinctrl/qcom/Makefile          |   1 +
>   drivers/pinctrl/qcom/pinctrl-ipq9574.c | 226 +++++++++++++++++++++++++
>   3 files changed, 234 insertions(+)
>   create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq9574.c
> 
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index d3eb699855..26ef59b938 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -27,6 +27,13 @@ config PINCTRL_QCOM_IPQ4019
>   	  Say Y here to enable support for pinctrl on the IPQ4019 SoC,
>   	  as well as the associated GPIO driver.
>   
> +config PINCTRL_QCOM_IPQ9574
> +	bool "Qualcomm IPQ9574 Pinctrl"
> +	select PINCTRL_QCOM
> +	help
> +	  Say Y here to enable support for pinctrl on the IPQ9574 SoC,
> +	  as well as the associated GPIO driver.
> +
>   config PINCTRL_QCOM_QCM2290
>   	bool "Qualcomm QCM2290 GCC"
>   	select PINCTRL_QCOM
> diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
> index 06d3c95f93..0253687fab 100644
> --- a/drivers/pinctrl/qcom/Makefile
> +++ b/drivers/pinctrl/qcom/Makefile
> @@ -5,6 +5,7 @@
>   obj-$(CONFIG_PINCTRL_QCOM) += pinctrl-qcom.o
>   obj-$(CONFIG_PINCTRL_QCOM_APQ8016) += pinctrl-apq8016.o
>   obj-$(CONFIG_PINCTRL_QCOM_IPQ4019) += pinctrl-ipq4019.o
> +obj-$(CONFIG_PINCTRL_QCOM_IPQ9574) += pinctrl-ipq9574.o
>   obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
>   obj-$(CONFIG_PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
>   obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
> diff --git a/drivers/pinctrl/qcom/pinctrl-ipq9574.c b/drivers/pinctrl/qcom/pinctrl-ipq9574.c
> new file mode 100644
> index 0000000000..5d3d23374d
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/pinctrl-ipq9574.c
> @@ -0,0 +1,226 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Clock drivers for Qualcomm ipq9574

pinctrl driver
> + *
> + * (C) Copyright 2024 Linaro Ltd.
> + */
> +
> +#include <dm.h>
> +
> +#include "pinctrl-qcom.h"
> +
> +#define MAX_PIN_NAME_LEN 32
> +static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
> +
> +enum ipq9574_functions {
> +	msm_mux_blsp0_spi,
> +	msm_mux_blsp0_uart,
> +	msm_mux_blsp1_i2c,
> +	msm_mux_blsp1_spi,
> +	msm_mux_blsp1_uart,
> +	msm_mux_blsp2_i2c,
> +	msm_mux_blsp2_spi,
> +	msm_mux_blsp2_uart,
> +	msm_mux_blsp3_i2c,
> +	msm_mux_blsp3_spi,
> +	msm_mux_blsp3_uart,
> +	msm_mux_blsp4_i2c,
> +	msm_mux_blsp4_spi,
> +	msm_mux_blsp4_uart,
> +	msm_mux_blsp5_i2c,
> +	msm_mux_blsp5_uart,
> +	msm_mux_gpio,
> +	msm_mux_mdc,
> +	msm_mux_mdio,
> +	msm_mux_pcie0_clk,
> +	msm_mux_pcie0_wake,
> +	msm_mux_pcie1_clk,
> +	msm_mux_pcie1_wake,
> +	msm_mux_pcie2_clk,
> +	msm_mux_pcie2_wake,
> +	msm_mux_pcie3_clk,
> +	msm_mux_pcie3_wake,
> +	msm_mux_qspi_data,
> +	msm_mux_qspi_clk,
> +	msm_mux_qspi_cs,
> +	msm_mux_sdc_data,
> +	msm_mux_sdc_clk,
> +	msm_mux_sdc_cmd,
> +	msm_mux_sdc_rclk,
> +	msm_mux_NA,
> +};
> +
> +#define MSM_PIN_FUNCTION(fname)				\
> +	[msm_mux_##fname] = {#fname, msm_mux_##fname}
> +
> +static const struct pinctrl_function msm_pinctrl_functions[] = {
> +	MSM_PIN_FUNCTION(blsp0_spi),
> +	MSM_PIN_FUNCTION(blsp0_uart),
> +	MSM_PIN_FUNCTION(blsp1_i2c),
> +	MSM_PIN_FUNCTION(blsp1_spi),
> +	MSM_PIN_FUNCTION(blsp1_uart),
> +	MSM_PIN_FUNCTION(blsp2_i2c),
> +	MSM_PIN_FUNCTION(blsp2_spi),
> +	MSM_PIN_FUNCTION(blsp2_uart),
> +	MSM_PIN_FUNCTION(blsp3_i2c),
> +	MSM_PIN_FUNCTION(blsp3_spi),
> +	MSM_PIN_FUNCTION(blsp3_uart),
> +	MSM_PIN_FUNCTION(blsp4_i2c),
> +	MSM_PIN_FUNCTION(blsp4_spi),
> +	MSM_PIN_FUNCTION(blsp4_uart),
> +	MSM_PIN_FUNCTION(blsp5_i2c),
> +	MSM_PIN_FUNCTION(blsp5_uart),
> +	MSM_PIN_FUNCTION(gpio),
> +	MSM_PIN_FUNCTION(mdc),
> +	MSM_PIN_FUNCTION(mdio),
> +	MSM_PIN_FUNCTION(pcie0_clk),
> +	MSM_PIN_FUNCTION(pcie0_wake),
> +	MSM_PIN_FUNCTION(pcie1_clk),
> +	MSM_PIN_FUNCTION(pcie1_wake),
> +	MSM_PIN_FUNCTION(pcie2_clk),
> +	MSM_PIN_FUNCTION(pcie2_wake),
> +	MSM_PIN_FUNCTION(pcie3_clk),
> +	MSM_PIN_FUNCTION(pcie3_wake),
> +	MSM_PIN_FUNCTION(qspi_data),
> +	MSM_PIN_FUNCTION(qspi_clk),
> +	MSM_PIN_FUNCTION(qspi_cs),
> +	MSM_PIN_FUNCTION(sdc_data),
> +	MSM_PIN_FUNCTION(sdc_clk),
> +	MSM_PIN_FUNCTION(sdc_cmd),
> +	MSM_PIN_FUNCTION(sdc_rclk),
> +};
> +
> +typedef unsigned int msm_pin_function[10];
> +
> +#define PINGROUP(id, f1, f2, f3, f4, f5, f6, f7, f8, f9) \
> +	[id] = {        msm_mux_gpio, /* gpio mode */	\
> +			msm_mux_##f1,			\
> +			msm_mux_##f2,			\
> +			msm_mux_##f3,			\
> +			msm_mux_##f4,			\
> +			msm_mux_##f5,			\
> +			msm_mux_##f6,			\
> +			msm_mux_##f7,			\
> +			msm_mux_##f8,			\
> +			msm_mux_##f9,			\
> +	}
> +
> +static const msm_pin_function ipq9574_pin_functions[] = {
> +	PINGROUP(0, sdc_data, qspi_data, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(1, sdc_data, qspi_data, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(2, sdc_data, qspi_data, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(3, sdc_data, qspi_data, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(4, sdc_cmd, qspi_cs, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(5, sdc_clk, qspi_clk, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(6, sdc_data, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(7, sdc_data, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(8, sdc_data, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(9, sdc_data, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(10, sdc_rclk, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(11, blsp0_spi, blsp0_uart, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(12, blsp0_spi, blsp0_uart, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(13, blsp0_spi, blsp0_uart, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(14, blsp0_spi, blsp0_uart, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(15, blsp3_spi, blsp3_i2c, blsp3_uart, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(16, blsp3_spi, blsp3_i2c, blsp3_uart, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(17, blsp3_spi, blsp3_uart, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(18, blsp3_spi, blsp3_uart, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(19, blsp3_spi, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(20, blsp3_spi, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(21, blsp3_spi, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(22, pcie0_clk, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(23, NA, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(24, pcie0_wake, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(25, pcie1_clk, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(26, NA, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(27, pcie1_wake, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(28, pcie2_clk, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(29, NA, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(30, pcie2_wake, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(31, pcie3_clk, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(32, NA, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(33, pcie3_wake, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(34, blsp2_uart, blsp2_i2c, blsp2_spi, blsp1_uart, NA, NA, NA, NA, NA),
> +	PINGROUP(35, blsp2_uart, blsp2_i2c, blsp2_spi, blsp1_uart, NA, NA, NA, NA, NA),
> +	PINGROUP(36, blsp1_uart, blsp1_i2c, blsp2_spi, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(37, blsp1_uart, blsp1_i2c, blsp2_spi, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(38, mdc, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(39, mdio, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(40, NA, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(41, NA, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(42, NA, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(43, NA, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(44, NA, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(45, NA, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(46, NA, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(47, NA, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(48, blsp5_i2c, blsp5_uart, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(49, blsp5_i2c, blsp5_uart, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(50, blsp4_uart, blsp4_i2c, blsp4_spi, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(51, blsp4_uart, blsp4_i2c, blsp4_spi, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(52, blsp4_uart, blsp4_spi, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(53, blsp4_uart, blsp4_spi, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(54, NA, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(55, NA, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(56, NA, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(57, NA, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(58, NA, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(59, NA, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(60, NA, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(61, blsp1_spi, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(62, blsp1_spi, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(63, blsp1_spi, NA, NA, NA, NA, NA, NA, NA, NA),
> +	PINGROUP(64, blsp1_spi, NA, NA, NA, NA, NA, NA, NA, NA),
> +};
> +
> +static const char *ipq9574_get_function_name(struct udevice *dev,
> +					     unsigned int selector)
> +{
> +	return msm_pinctrl_functions[selector].name;
> +}
> +
> +static const char *ipq9574_get_pin_name(struct udevice *dev,
> +					unsigned int selector)
> +{
> +	snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
> +	return pin_name;
> +}
> +
> +static unsigned int ipq9574_get_function_mux(unsigned int pin,
> +					     unsigned int selector)
> +{
> +	unsigned int i;
> +	const msm_pin_function *func = ipq9574_pin_functions + pin;
> +
> +	for (i = 0; i < 10; i++)
> +		if ((*func)[i] == selector)
> +			return i;
> +
> +	pr_err("Can't find requested function for pin %u pin\n", pin);

Please demote to debug() and include the selector, or drop this entirely.
> +	return -EINVAL;

This function is currently assumed to never fail (so I guess on other 
platforms if you try to mux a pin to a function it doesn't support it 
would just be programmed wrong). Maybe you could fix this codepath to 
the error is actually bubbled up? Since this will just program (-EINVAL) 
<< 2 into your pin which is probably undesirable.
> +}
> +
> +static const struct msm_pinctrl_data ipq9574_data = {
> +	.pin_data = {
> +		.pin_count = 65,
> +		.special_pins_start = 65, /* There are no special pins */

No need to specify them then, please drop this.

Kind regards,
> +	},
> +	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
> +	.get_function_name = ipq9574_get_function_name,
> +	.get_function_mux = ipq9574_get_function_mux,
> +	.get_pin_name = ipq9574_get_pin_name,
> +};
> +
> +static const struct udevice_id msm_pinctrl_ids[] = {
> +	{ .compatible = "qcom,ipq9574-tlmm", .data = (ulong)&ipq9574_data },
> +	{ /* Sentinal */ }
> +};
> +
> +U_BOOT_DRIVER(pinctrl_ipq9574) = {
> +	.name		= "pinctrl_ipq9574",
> +	.id		= UCLASS_NOP,
> +	.of_match	= msm_pinctrl_ids,
> +	.ops		= &msm_pinctrl_ops,
> +	.bind		= msm_pinctrl_bind,
> +	.flags = DM_FLAG_PRE_RELOC,
> +};

-- 
Caleb (they/them)

