Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E01C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 15:21:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CADF805C3;
	Mon, 24 Feb 2025 16:21:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="p2AhQWS8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 349A780F3F; Mon, 24 Feb 2025 16:21:10 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D46B4800B3
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 16:21:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4397dff185fso39800805e9.2
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 07:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740410467; x=1741015267; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=szM2unfz8e8pTzXhiP9T1SYPRu4kreIKNjXk2Jdz6dM=;
 b=p2AhQWS8nuiffw48Qj2D2ZFmjgadiYdDAFW4Bw0Xi6ewWOavInOEZxG9Qwo+zge7/U
 70qyRtKl1ZqO698XTd8pdDmCmtnMoRMD+sOWSgP/nHuZr6LkvRYCjD6LQe/UL2wJSF3b
 d14aCaXvg8xMd6/NuCjbNHoWHVNh4IQGP3dPDby7zXQGOaEPznhJDgWNoUkdNqJtOiFv
 joU7Y2sXBdoWRaHKrME9t6F4fnR4wyMwWXUkprUsgKzX42dnaBtOlRb0asbblTU2x+3I
 A3ophG8oAkt9HRqqXnY9s5kVk8EXdlRgXqUgNP/tHwtXG3KWFVTOZ0hJ074RaWK99eyG
 p1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740410467; x=1741015267;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=szM2unfz8e8pTzXhiP9T1SYPRu4kreIKNjXk2Jdz6dM=;
 b=kjUv0pLnSJZYNlzX29oRlEaTdxjWaJDpagcOUKwYXDqk6oGbQ3Dkj1StBRPCSJm458
 dL9G62MEU82ZUPfLJedPB8hfTnuX+ffHNdPKSUP0Dxg88iyYsQcD9FXIA2qEjB2/a9RW
 K2Gz+QpvPQaydWchhJTBD6wtMPALUQ24WYWtvifI1rPHMbLOGeh4JxgAOwabKbEp+wRN
 OLi4CQybox+gUexHuVFQflyKypufKxDgPx4ZedhKP2BKfMAbgdqTE9yHVbpGFAodiYMj
 Xqd5SFuH3rfrD578syE6rCV5Jj1D0ofpOixrWmwu+cU+034dBFGVrJXZINROMhPJ4LLT
 LsAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg6lpTDzg83XmVogKZfwaJaqxbsype48OEd5CrSfZVX7xpAK8U3Ihx/CPvXX3h20aU9Z2y8k0=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4TjcY29EJvc5PKyGXHyVIi51ixGWvfeYcpxBDn6qc3teXISlS
 urPO3RjCbWTZHIepmigxiqXKOXIiWys0C6EA8hBfyBSUg5M/8pmN2GeS6Zthp2I=
X-Gm-Gg: ASbGncu94RfkUjRt4cf2uPUt7hxFmSW+UJB0CgrRZk6vKHUNNtzOJcWtCYrzyOHnNnB
 1+J6c0lZb91K139p3jKMdpUn3uywQo005zAbOGBoRlvsbm7XrBjzz690Oy5hbmIbomMvPpn+Yn6
 YIDGVeMnL6R84ruPuLdw0vQSpc3MHIzQKFB1CsittkovcbXygGUivmj0hKxVefap7VH7kBQzsKK
 797V1qF4yPNVUk33MgSFausBc01RK0Y9Sah+GRAj8L80hi9AfCANs4cWBn40JEXhrYPAwg+pd+s
 V0pr46DBCys2aS+sPRczTy6YnD+ytmjjc9yCjQvG91LiGrNSaYnFiYApmoJzhJnovPOLTDrngtX
 QRd+c41Q=
X-Google-Smtp-Source: AGHT+IEqa6m/Dktrn2mx+ayLdWmeDG89tGlU+pQHFdymjCQ/BAolBQamF6ZB3aKp6JcfodJS0nM0lg==
X-Received: by 2002:a05:600c:1390:b0:439:8bc3:a697 with SMTP id
 5b1f17b1804b1-439ae1d7e97mr116146065e9.4.1740410467189; 
 Mon, 24 Feb 2025 07:21:07 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:3974:dc91:a561:d080?
 ([2a0a:ef40:1d11:ab01:3974:dc91:a561:d080])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02ce685sm108710045e9.2.2025.02.24.07.21.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 07:21:06 -0800 (PST)
Message-ID: <b9993690-c50a-42ad-98ec-b57cd16516b1@linaro.org>
Date: Mon, 24 Feb 2025 15:21:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] pinctrl: qcom: Add ipq9574 pinctrl driver
To: Varadarajan Narayanan <quic_varada@quicinc.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@linaro.org, lukma@denx.de,
 seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 robert.marko@sartura.hr, luka.perkov@sartura.hr, Volodymyr_Babchuk@epam.com,
 sjg@chromium.org, lehmanju@devpi.de, pbrobinson@gmail.com,
 marek.vasut+renesas@mailbox.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250220073937.133687-1-quic_varada@quicinc.com>
 <20250220073937.133687-6-quic_varada@quicinc.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250220073937.133687-6-quic_varada@quicinc.com>
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



On 2/20/25 07:39, Varadarajan Narayanan wrote:
> Add pinctrl driver for the TLMM block found in the ipq9574 SoC.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>   drivers/pinctrl/qcom/Kconfig           |   7 +
>   drivers/pinctrl/qcom/Makefile          |   1 +
>   drivers/pinctrl/qcom/pinctrl-ipq9574.c | 227 +++++++++++++++++++++++++
>   3 files changed, 235 insertions(+)
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
> index 0000000000..d5a938dfdb
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/pinctrl-ipq9574.c
> @@ -0,0 +1,227 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * pinctrl driver for Qualcomm ipq9574
> + *
> + * (C) Copyright 2025 Linaro Ltd.
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
> +static int ipq9574_get_function_mux(unsigned int pin, unsigned int selector)
> +{
> +	unsigned int i;
> +	const msm_pin_function *func = ipq9574_pin_functions + pin;
> +
> +	for (i = 0; i < 10; i++)
> +		if ((*func)[i] == selector)
> +			return i;
> +
> +	debug("Can't find requested function for pin:selector %u:%u\n",
> +	      pin, selector);
> +
> +	return -EINVAL;
> +}
> +
> +static const struct msm_pinctrl_data ipq9574_data = {
> +	.pin_data = {
> +		.pin_count = 65,
> +		.special_pins_start = 65, /* There are no special pins */

Please remove this as I mentioned on a previous revision, it isn't 
necessary to specify if there are no special pins.

With that:

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
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

