Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D14C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 14:31:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7BA287971;
	Wed,  6 Mar 2024 15:31:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zC//CPev";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FCDE876A4; Wed,  6 Mar 2024 15:31:38 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B1B6876A4
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 15:31:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33e4f15710aso921568f8f.2
 for <u-boot@lists.denx.de>; Wed, 06 Mar 2024 06:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709735481; x=1710340281; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tku27GahUeP9i/tcqxY2XxnuPxKqnKLHuLxf7ipYg/o=;
 b=zC//CPevsHd1kvuThLkQs3iyUg9HCTEWB1H9nb4KrsDdlRYDjHZKxlzYZyXL1wcuiu
 NOTJtKdo1eHfjBPPFBXjZao5ZP2YFEDHgVRQjXHWzlmaOc88TPRvVMmZKdaKM2AuQExE
 lJc6l4os2tGaJOginsw5F1iIEgEGY3IY3sLHHWmhIm+xoEXB1zFlNxiyoEVOO9P08Bv4
 TWpelc8JxHmJDSO4g5Cwj6WB6y8UACiIMuXRWwCjM8REmSS7327SqkvF28lgP9QXR0j8
 1fVEL3FAw2VC06g9bz8ShG710bLm9DoD7nB6FkglmfGFi9UPwIMxPXn1EtolL84Q3LA8
 mRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709735481; x=1710340281;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tku27GahUeP9i/tcqxY2XxnuPxKqnKLHuLxf7ipYg/o=;
 b=dMuEyYTsMap8IU2Cjbie41dA3pRGJc++hGM6oyolEvRe2Qrn0i9dqMZ9g1KQ9w8nJh
 FJqOdZp+d6ShubegTZyf9Qd4+AWEDBY/n+6LvHoJBhzYJZCOsPhLOSK2Wz90P7cMpQnc
 1balGs2L2o74PVWRrG786vrFrVgClThJud8dI1/8sUdYtp1qIJihx2+qb/zOKu3F9s3P
 xQlEfS23vgmD4ZhMx2Dm9IWnZ16gbNQF5QXXqr0HkS3QBZcR8I/FqgxkTohW0CMA3bNW
 6SA3nBoTyck9RK/cPSAdAsjutrgKIC+nQfqF2vFMnx1E0W91fXOAY1pgng7G0UvOCxth
 R7qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3hZHnJeYnuEwXJWEx/EHFCIR1WdbRtAoaTewVRb8gwR+ezNllmvD/RNy71g6ZnDedL038ElCIC2idM5nTDstNjLrI4A==
X-Gm-Message-State: AOJu0YxokyJ0WEOBC2xVV8xMmEoublkXWWregGjHmx8OCHkN9qjHbcDe
 ibugJP1/1k2tM09yaTtkBPgIAPGXbq72sdtjj9YXaAY/NU0VKLaaPkTzYFK8UgI=
X-Google-Smtp-Source: AGHT+IGG62NE5pN1fvpTmV8NQ2xqCJRdgeBS+Il4O3eFuJqA8P9/CZyru/+f4JZPpglv5QXy2eslOA==
X-Received: by 2002:adf:9dc6:0:b0:33d:87e9:5903 with SMTP id
 q6-20020adf9dc6000000b0033d87e95903mr12594212wre.15.1709735480924; 
 Wed, 06 Mar 2024 06:31:20 -0800 (PST)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bt12-20020a056000080c00b0033e3a110d7fsm9447720wrb.71.2024.03.06.06.31.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 06:31:20 -0800 (PST)
Message-ID: <77ef0fcd-53ac-4f01-9c24-d4c6a95b6761@linaro.org>
Date: Wed, 6 Mar 2024 14:31:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] pinctrl: qcom: add driver for SM8150 SoC
Content-Language: en-US
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
 <20240306005230.2638972-8-volodymyr_babchuk@epam.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240306005230.2638972-8-volodymyr_babchuk@epam.com>
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



On 06/03/2024 00:53, Volodymyr Babchuk wrote:
> Add pinctrl and GPIO driver for SM8150. Driver code is based on the
> similar U-Boot drivers. All constants are taken from the corresponding
> Linux driver. This drivers differs from the similar U-Boot drivers,
> because SM8150 SoC have different function IDs for the same functions
> on different pins.
> 
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
With the tile offsets fixed as mentioned on the other patch

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> 
> (no changes since v1)
> 
>  drivers/pinctrl/qcom/Kconfig          |   7 +
>  drivers/pinctrl/qcom/Makefile         |   1 +
>  drivers/pinctrl/qcom/pinctrl-sm8150.c | 589 ++++++++++++++++++++++++++
>  3 files changed, 597 insertions(+)
>  create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8150.c
> 
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index 2fe6398147..290cefca47 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -41,6 +41,13 @@ config PINCTRL_QCOM_SDM845
>  	  Say Y here to enable support for pinctrl on the Snapdragon 845 SoC,
>  	  as well as the associated GPIO driver.
>  
> +config PINCTRL_QCOM_SM8150
> +	bool "Qualcomm SM8150 GCC"
> +	select PINCTRL_QCOM
> +	help
> +	  Say Y here to enable support for pinctrl on the Snapdragon SM8150 SoC,
> +	  as well as the associated GPIO driver.
> +
>  endmenu
>  
>  endif
> diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
> index 6d9aca6d7b..3c7be4a685 100644
> --- a/drivers/pinctrl/qcom/Makefile
> +++ b/drivers/pinctrl/qcom/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_PINCTRL_QCOM_IPQ4019) += pinctrl-ipq4019.o
>  obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
>  obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
>  obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
> +obj-$(CONFIG_PINCTRL_QCOM_SM8150) += pinctrl-sm8150.o
> diff --git a/drivers/pinctrl/qcom/pinctrl-sm8150.c b/drivers/pinctrl/qcom/pinctrl-sm8150.c
> new file mode 100644
> index 0000000000..a6c14d7254
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/pinctrl-sm8150.c
> @@ -0,0 +1,589 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Qualcomm SM8150 pinctrl and GPIO driver
> + *
> + * Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> + * Copyright (c) 2024 EPAM Systems.
> + *
> + * Based on similar U-Boot drivers. Constants were taken from the Linux driver
> + */
> +
> +#include <dm.h>
> +
> +#include "pinctrl-qcom.h"
> +
> +#define WEST	0x00100000
> +#define EAST	0x00500000
> +#define NORTH	0x00900000
> +#define SOUTH	0x00D00000
> +
> +#define MAX_PIN_NAME_LEN 32
> +static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
> +
> +enum sm8150_functions {
> +	msm_mux_adsp_ext,
> +	msm_mux_agera_pll,
> +	msm_mux_aoss_cti,
> +	msm_mux_atest_char,
> +	msm_mux_atest_char0,
> +	msm_mux_atest_char1,
> +	msm_mux_atest_char2,
> +	msm_mux_atest_char3,
> +	msm_mux_atest_usb1,
> +	msm_mux_atest_usb2,
> +	msm_mux_atest_usb10,
> +	msm_mux_atest_usb11,
> +	msm_mux_atest_usb12,
> +	msm_mux_atest_usb13,
> +	msm_mux_atest_usb20,
> +	msm_mux_atest_usb21,
> +	msm_mux_atest_usb22,
> +	msm_mux_atest_usb23,
> +	msm_mux_audio_ref,
> +	msm_mux_btfm_slimbus,
> +	msm_mux_cam_mclk,
> +	msm_mux_cci_async,
> +	msm_mux_cci_i2c,
> +	msm_mux_cci_timer0,
> +	msm_mux_cci_timer1,
> +	msm_mux_cci_timer2,
> +	msm_mux_cci_timer3,
> +	msm_mux_cci_timer4,
> +	msm_mux_cri_trng,
> +	msm_mux_cri_trng0,
> +	msm_mux_cri_trng1,
> +	msm_mux_dbg_out,
> +	msm_mux_ddr_bist,
> +	msm_mux_ddr_pxi0,
> +	msm_mux_ddr_pxi1,
> +	msm_mux_ddr_pxi2,
> +	msm_mux_ddr_pxi3,
> +	msm_mux_edp_hot,
> +	msm_mux_edp_lcd,
> +	msm_mux_emac_phy,
> +	msm_mux_emac_pps,
> +	msm_mux_gcc_gp1,
> +	msm_mux_gcc_gp2,
> +	msm_mux_gcc_gp3,
> +	msm_mux_gpio,
> +	msm_mux_jitter_bist,
> +	msm_mux_hs1_mi2s,
> +	msm_mux_hs2_mi2s,
> +	msm_mux_hs3_mi2s,
> +	msm_mux_lpass_slimbus,
> +	msm_mux_mdp_vsync,
> +	msm_mux_mdp_vsync0,
> +	msm_mux_mdp_vsync1,
> +	msm_mux_mdp_vsync2,
> +	msm_mux_mdp_vsync3,
> +	msm_mux_mss_lte,
> +	msm_mux_m_voc,
> +	msm_mux_nav_pps,
> +	msm_mux_pa_indicator,
> +	msm_mux_pci_e0,
> +	msm_mux_pci_e1,
> +	msm_mux_phase_flag,
> +	msm_mux_pll_bist,
> +	msm_mux_pll_bypassnl,
> +	msm_mux_pll_reset,
> +	msm_mux_pri_mi2s,
> +	msm_mux_pri_mi2s_ws,
> +	msm_mux_prng_rosc,
> +	msm_mux_qdss,
> +	msm_mux_qdss_cti,
> +	msm_mux_qlink_enable,
> +	msm_mux_qlink_request,
> +	msm_mux_qspi0,
> +	msm_mux_qspi1,
> +	msm_mux_qspi2,
> +	msm_mux_qspi3,
> +	msm_mux_qspi_clk,
> +	msm_mux_qspi_cs,
> +	msm_mux_qua_mi2s,
> +	msm_mux_qup0,
> +	msm_mux_qup1,
> +	msm_mux_qup2,
> +	msm_mux_qup3,
> +	msm_mux_qup4,
> +	msm_mux_qup5,
> +	msm_mux_qup6,
> +	msm_mux_qup7,
> +	msm_mux_qup8,
> +	msm_mux_qup9,
> +	msm_mux_qup10,
> +	msm_mux_qup11,
> +	msm_mux_qup12,
> +	msm_mux_qup13,
> +	msm_mux_qup14,
> +	msm_mux_qup15,
> +	msm_mux_qup16,
> +	msm_mux_qup17,
> +	msm_mux_qup18,
> +	msm_mux_qup19,
> +	msm_mux_qup_l4,
> +	msm_mux_qup_l5,
> +	msm_mux_qup_l6,
> +	msm_mux_rgmii,
> +	msm_mux_sdc4,
> +	msm_mux_sd_write,
> +	msm_mux_sec_mi2s,
> +	msm_mux_spkr_i2s,
> +	msm_mux_sp_cmu,
> +	msm_mux_ter_mi2s,
> +	msm_mux_tgu_ch0,
> +	msm_mux_tgu_ch2,
> +	msm_mux_tgu_ch1,
> +	msm_mux_tgu_ch3,
> +	msm_mux_tsense_pwm1,
> +	msm_mux_tsense_pwm2,
> +	msm_mux_tsif1,
> +	msm_mux_tsif2,
> +	msm_mux_uim1,
> +	msm_mux_uim2,
> +	msm_mux_uim_batt,
> +	msm_mux_usb2phy_ac,
> +	msm_mux_usb_phy,
> +	msm_mux_vfr_1,
> +	msm_mux_vsense_trigger,
> +	msm_mux_wlan1_adc1,
> +	msm_mux_wlan1_adc0,
> +	msm_mux_wlan2_adc1,
> +	msm_mux_wlan2_adc0,
> +	msm_mux_wmss_reset,
> +	msm_mux__,
> +};
> +
> +#define MSM_PIN_FUNCTION(fname)				\
> +	[msm_mux_##fname] = {#fname, msm_mux_##fname}
> +
> +static const struct pinctrl_function msm_pinctrl_functions[] = {
> +	MSM_PIN_FUNCTION(adsp_ext),
> +	MSM_PIN_FUNCTION(agera_pll),
> +	MSM_PIN_FUNCTION(aoss_cti),
> +	MSM_PIN_FUNCTION(ddr_pxi2),
> +	MSM_PIN_FUNCTION(atest_char),
> +	MSM_PIN_FUNCTION(atest_char0),
> +	MSM_PIN_FUNCTION(atest_char1),
> +	MSM_PIN_FUNCTION(atest_char2),
> +	MSM_PIN_FUNCTION(atest_char3),
> +	MSM_PIN_FUNCTION(audio_ref),
> +	MSM_PIN_FUNCTION(atest_usb1),
> +	MSM_PIN_FUNCTION(atest_usb2),
> +	MSM_PIN_FUNCTION(atest_usb10),
> +	MSM_PIN_FUNCTION(atest_usb11),
> +	MSM_PIN_FUNCTION(atest_usb12),
> +	MSM_PIN_FUNCTION(atest_usb13),
> +	MSM_PIN_FUNCTION(atest_usb20),
> +	MSM_PIN_FUNCTION(atest_usb21),
> +	MSM_PIN_FUNCTION(atest_usb22),
> +	MSM_PIN_FUNCTION(atest_usb23),
> +	MSM_PIN_FUNCTION(btfm_slimbus),
> +	MSM_PIN_FUNCTION(cam_mclk),
> +	MSM_PIN_FUNCTION(cci_async),
> +	MSM_PIN_FUNCTION(cci_i2c),
> +	MSM_PIN_FUNCTION(cci_timer0),
> +	MSM_PIN_FUNCTION(cci_timer1),
> +	MSM_PIN_FUNCTION(cci_timer2),
> +	MSM_PIN_FUNCTION(cci_timer3),
> +	MSM_PIN_FUNCTION(cci_timer4),
> +	MSM_PIN_FUNCTION(cri_trng),
> +	MSM_PIN_FUNCTION(cri_trng0),
> +	MSM_PIN_FUNCTION(cri_trng1),
> +	MSM_PIN_FUNCTION(dbg_out),
> +	MSM_PIN_FUNCTION(ddr_bist),
> +	MSM_PIN_FUNCTION(ddr_pxi0),
> +	MSM_PIN_FUNCTION(ddr_pxi1),
> +	MSM_PIN_FUNCTION(ddr_pxi3),
> +	MSM_PIN_FUNCTION(edp_hot),
> +	MSM_PIN_FUNCTION(edp_lcd),
> +	MSM_PIN_FUNCTION(emac_phy),
> +	MSM_PIN_FUNCTION(emac_pps),
> +	MSM_PIN_FUNCTION(gcc_gp1),
> +	MSM_PIN_FUNCTION(gcc_gp2),
> +	MSM_PIN_FUNCTION(gcc_gp3),
> +	MSM_PIN_FUNCTION(gpio),
> +	MSM_PIN_FUNCTION(hs1_mi2s),
> +	MSM_PIN_FUNCTION(hs2_mi2s),
> +	MSM_PIN_FUNCTION(hs3_mi2s),
> +	MSM_PIN_FUNCTION(jitter_bist),
> +	MSM_PIN_FUNCTION(lpass_slimbus),
> +	MSM_PIN_FUNCTION(mdp_vsync),
> +	MSM_PIN_FUNCTION(mdp_vsync0),
> +	MSM_PIN_FUNCTION(mdp_vsync1),
> +	MSM_PIN_FUNCTION(mdp_vsync2),
> +	MSM_PIN_FUNCTION(mdp_vsync3),
> +	MSM_PIN_FUNCTION(mss_lte),
> +	MSM_PIN_FUNCTION(m_voc),
> +	MSM_PIN_FUNCTION(nav_pps),
> +	MSM_PIN_FUNCTION(pa_indicator),
> +	MSM_PIN_FUNCTION(pci_e0),
> +	MSM_PIN_FUNCTION(phase_flag),
> +	MSM_PIN_FUNCTION(pll_bypassnl),
> +	MSM_PIN_FUNCTION(pll_bist),
> +	MSM_PIN_FUNCTION(pci_e1),
> +	MSM_PIN_FUNCTION(pll_reset),
> +	MSM_PIN_FUNCTION(pri_mi2s),
> +	MSM_PIN_FUNCTION(pri_mi2s_ws),
> +	MSM_PIN_FUNCTION(prng_rosc),
> +	MSM_PIN_FUNCTION(qdss),
> +	MSM_PIN_FUNCTION(qdss_cti),
> +	MSM_PIN_FUNCTION(qlink_request),
> +	MSM_PIN_FUNCTION(qlink_enable),
> +	MSM_PIN_FUNCTION(qspi0),
> +	MSM_PIN_FUNCTION(qspi1),
> +	MSM_PIN_FUNCTION(qspi2),
> +	MSM_PIN_FUNCTION(qspi3),
> +	MSM_PIN_FUNCTION(qspi_clk),
> +	MSM_PIN_FUNCTION(qspi_cs),
> +	MSM_PIN_FUNCTION(qua_mi2s),
> +	MSM_PIN_FUNCTION(qup0),
> +	MSM_PIN_FUNCTION(qup1),
> +	MSM_PIN_FUNCTION(qup2),
> +	MSM_PIN_FUNCTION(qup3),
> +	MSM_PIN_FUNCTION(qup4),
> +	MSM_PIN_FUNCTION(qup5),
> +	MSM_PIN_FUNCTION(qup6),
> +	MSM_PIN_FUNCTION(qup7),
> +	MSM_PIN_FUNCTION(qup8),
> +	MSM_PIN_FUNCTION(qup9),
> +	MSM_PIN_FUNCTION(qup10),
> +	MSM_PIN_FUNCTION(qup11),
> +	MSM_PIN_FUNCTION(qup12),
> +	MSM_PIN_FUNCTION(qup13),
> +	MSM_PIN_FUNCTION(qup14),
> +	MSM_PIN_FUNCTION(qup15),
> +	MSM_PIN_FUNCTION(qup16),
> +	MSM_PIN_FUNCTION(qup17),
> +	MSM_PIN_FUNCTION(qup18),
> +	MSM_PIN_FUNCTION(qup19),
> +	MSM_PIN_FUNCTION(qup_l4),
> +	MSM_PIN_FUNCTION(qup_l5),
> +	MSM_PIN_FUNCTION(qup_l6),
> +	MSM_PIN_FUNCTION(rgmii),
> +	MSM_PIN_FUNCTION(sdc4),
> +	MSM_PIN_FUNCTION(sd_write),
> +	MSM_PIN_FUNCTION(sec_mi2s),
> +	MSM_PIN_FUNCTION(spkr_i2s),
> +	MSM_PIN_FUNCTION(sp_cmu),
> +	MSM_PIN_FUNCTION(ter_mi2s),
> +	MSM_PIN_FUNCTION(tgu_ch0),
> +	MSM_PIN_FUNCTION(tgu_ch1),
> +	MSM_PIN_FUNCTION(tgu_ch2),
> +	MSM_PIN_FUNCTION(tgu_ch3),
> +	MSM_PIN_FUNCTION(tsense_pwm1),
> +	MSM_PIN_FUNCTION(tsense_pwm2),
> +	MSM_PIN_FUNCTION(tsif1),
> +	MSM_PIN_FUNCTION(tsif2),
> +	MSM_PIN_FUNCTION(uim1),
> +	MSM_PIN_FUNCTION(uim2),
> +	MSM_PIN_FUNCTION(uim_batt),
> +	MSM_PIN_FUNCTION(usb2phy_ac),
> +	MSM_PIN_FUNCTION(usb_phy),
> +	MSM_PIN_FUNCTION(vfr_1),
> +	MSM_PIN_FUNCTION(vsense_trigger),
> +	MSM_PIN_FUNCTION(wlan1_adc0),
> +	MSM_PIN_FUNCTION(wlan1_adc1),
> +	MSM_PIN_FUNCTION(wlan2_adc0),
> +	MSM_PIN_FUNCTION(wlan2_adc1),
> +	MSM_PIN_FUNCTION(wmss_reset),
> +};
> +
> +static const unsigned int sm8150_pin_offsets[] = {
> +	[0]   = SOUTH, [1]   = SOUTH, [2]   = SOUTH, [3]   = SOUTH,
> +	[4]   = SOUTH, [5]   = SOUTH, [6]   = SOUTH, [7]   = SOUTH,
> +	[8]   = NORTH, [9]   = NORTH, [10]  = NORTH, [11]  = NORTH,
> +	[12]  = NORTH, [13]  = NORTH, [14]  = NORTH, [15]  = NORTH,
> +	[16]  = NORTH, [17]  = NORTH, [18]  = NORTH, [19]  = NORTH,
> +	[20]  = NORTH, [21]  = EAST,  [22]  = EAST,  [23]  = EAST,
> +	[24]  = EAST,  [25]  = EAST,  [26]  = EAST,  [27]  = EAST,
> +	[28]  = EAST,  [29]  = EAST,  [30]  = EAST,  [31]  = NORTH,
> +	[32]  = NORTH, [33]  = NORTH, [34]  = NORTH, [35]  = NORTH,
> +	[36]  = NORTH, [37]  = NORTH, [38]  = SOUTH, [39]  = NORTH,
> +	[40]  = NORTH, [41]  = NORTH, [42]  = NORTH, [43]  = EAST,
> +	[44]  = EAST,  [45]  = EAST,  [46]  = EAST,  [47]  = EAST,
> +	[48]  = EAST,  [49]  = EAST,  [50]  = EAST,  [51]  = SOUTH,
> +	[52]  = SOUTH, [53]  = SOUTH, [54]  = SOUTH, [55]  = SOUTH,
> +	[56]  = SOUTH, [57]  = SOUTH, [58]  = SOUTH, [59]  = SOUTH,
> +	[60]  = SOUTH, [61]  = SOUTH, [62]  = SOUTH, [63]  = SOUTH,
> +	[64]  = SOUTH, [65]  = SOUTH, [66]  = SOUTH, [67]  = SOUTH,
> +	[68]  = SOUTH, [69]  = SOUTH, [70]  = SOUTH, [71]  = SOUTH,
> +	[72]  = SOUTH, [73]  = SOUTH, [74]  = SOUTH, [75]  = SOUTH,
> +	[76]  = SOUTH, [77]  = SOUTH, [78]  = SOUTH, [79]  = SOUTH,
> +	[80]  = SOUTH, [81]  = SOUTH, [82]  = SOUTH, [83]  = NORTH,
> +	[84]  = NORTH, [85]  = NORTH, [86]  = NORTH, [87]  = EAST,
> +	[88]  = NORTH, [89]  = NORTH, [90]  = NORTH, [91]  = NORTH,
> +	[92]  = NORTH, [93]  = NORTH, [94]  = NORTH, [95]  = NORTH,
> +	[96]  = NORTH, [97]  = NORTH, [98]  = SOUTH, [99]  = SOUTH,
> +	[100] = SOUTH, [101] = SOUTH, [102] = NORTH, [103] = NORTH,
> +	[104] = NORTH, [105] = WEST,  [106] = WEST,  [107] = WEST,
> +	[108] = WEST,  [109] = WEST,  [110] = WEST,  [111] = WEST,
> +	[112] = WEST,  [113] = WEST,  [114] = SOUTH, [115] = SOUTH,
> +	[116] = SOUTH, [117] = SOUTH, [118] = SOUTH, [119] = SOUTH,
> +	[120] = SOUTH, [121] = SOUTH, [122] = SOUTH, [123] = SOUTH,
> +	[124] = SOUTH, [125] = WEST,  [126] = SOUTH, [127] = SOUTH,
> +	[128] = SOUTH, [129] = SOUTH, [130] = SOUTH, [131] = SOUTH,
> +	[132] = SOUTH, [133] = SOUTH, [134] = SOUTH, [135] = SOUTH,
> +	[136] = SOUTH, [137] = SOUTH, [138] = SOUTH, [139] = SOUTH,
> +	[140] = SOUTH, [141] = SOUTH, [142] = SOUTH, [143] = SOUTH,
> +	[144] = SOUTH, [145] = SOUTH, [146] = SOUTH, [147] = SOUTH,
> +	[148] = SOUTH, [149] = SOUTH, [150] = SOUTH, [151] = SOUTH,
> +	[152] = SOUTH, [153] = SOUTH, [154] = SOUTH, [155] = WEST,
> +	[156] = WEST,  [157] = WEST,  [158] = WEST,  [159] = WEST,
> +	[160] = WEST,  [161] = WEST,  [162] = WEST,  [163] = WEST,
> +	[164] = WEST,  [165] = WEST,  [166] = WEST,  [167] = WEST,
> +	[168] = WEST,  [169] = NORTH, [170] = NORTH, [171] = NORTH
> +};
> +
> +typedef unsigned int msm_pin_function[10];
> +
> +#define PINGROUP(id, f1, f2, f3, f4, f5, f6, f7, f8, f9)	\
> +	[id] = {        msm_mux_gpio, /* gpio mode */	\
> +			msm_mux_##f1,			\
> +			msm_mux_##f2,			\
> +			msm_mux_##f3,			\
> +			msm_mux_##f4,			\
> +			msm_mux_##f5,			\
> +			msm_mux_##f6,			\
> +			msm_mux_##f7,			\
> +			msm_mux_##f8,			\
> +			msm_mux_##f9			\
> +	}
> +
> +static const msm_pin_function sm8150_pin_functions[] = {
> +	PINGROUP(0, qup0,  _, _, _, _, _, _, _, _),
> +	PINGROUP(1, qup0, _, _, _, _, _, _, _, _),
> +	PINGROUP(2, qup0, _, _, _, _, _, _, _, _),
> +	PINGROUP(3, qup0, _, _, _, _, _, _, _, _),
> +	PINGROUP(4, qup6, rgmii, _, _, _, _, _, _, _),
> +	PINGROUP(5, qup6, rgmii, _, _, _, _, _, _, _),
> +	PINGROUP(6, qup6, rgmii, qup_l6, _, _, _, _, _, _),
> +	PINGROUP(7, qup6, rgmii, qup_l5, _, _, _, _, _, _),
> +	PINGROUP(8, mdp_vsync, _, _, _, _, _, _, _, _),
> +	PINGROUP(9, mdp_vsync, edp_lcd, qup10, _, _, _, _, _, _),
> +	PINGROUP(10, mdp_vsync, m_voc, edp_hot, qup10, _, _, _, _, _),
> +	PINGROUP(11, qup10, _, _, _, _, _, _, _, _),
> +	PINGROUP(12, qup10, _, _, _, _, _, _, _, _),
> +	PINGROUP(13, cam_mclk, qdss, _, _, _, _, _, _, _),
> +	PINGROUP(14, cam_mclk, qdss, _, _, _, _, _, _, _),
> +	PINGROUP(15, cam_mclk, qdss, _, _, _, _, _, _, _),
> +	PINGROUP(16, cam_mclk, qdss, _, _, _, _, _, _, _),
> +	PINGROUP(17, cci_i2c, qdss, _, _, _, _, _, _, _),
> +	PINGROUP(18, cci_i2c, phase_flag, _, qdss, _, _, _, _, _),
> +	PINGROUP(19, cci_i2c, phase_flag, _, qdss, _, _, _, _, _),
> +	PINGROUP(20, cci_i2c, phase_flag, _, qdss, _, _, _, _, _),
> +	PINGROUP(21, cci_timer0, gcc_gp2, qdss, _, _, _, _, _, _),
> +	PINGROUP(22, cci_timer1, gcc_gp3, qdss, _, _, _, _, _, _),
> +	PINGROUP(23, cci_timer2, qup18, qdss, _, _, _, _, _, _),
> +	PINGROUP(24, cci_timer3, cci_async, qup18, qdss, _, _, _, _, _),
> +	PINGROUP(25, cci_timer4, cci_async, qup18, qdss, _, _, _, _, _),
> +	PINGROUP(26, cci_async, qup18, qdss, _, _, _, _, _, _),
> +	PINGROUP(27, qup15, _, qdss, _, _, _, _, _, _),
> +	PINGROUP(28, qup15, qdss, _, _, _, _, _, _, _),
> +	PINGROUP(29, qup15, qdss, _, _, _, _, _, _, _),
> +	PINGROUP(30, qup15, qdss, _, _, _, _, _, _, _),
> +	PINGROUP(31, cci_i2c, qdss, _, _, _, _, _, _, _),
> +	PINGROUP(32, cci_i2c, qdss, _, _, _, _, _, _, _),
> +	PINGROUP(33, cci_i2c, qup_l5, qdss, _, _, _, _, _, _),
> +	PINGROUP(34, cci_i2c, qup_l6, _, _, _, _, _, _, _),
> +	PINGROUP(35, pci_e0, _, _, _, _, _, _, _, _),
> +	PINGROUP(36, pci_e0, _, _, _, _, _, _, _, _),
> +	PINGROUP(37, qup_l4, agera_pll, _, _, _, _, _, _, _),
> +	PINGROUP(38, usb_phy, _, _, _, _, _, _, _, _),
> +	PINGROUP(39, qup9, qdss, _, _, _, _, _, _, _),
> +	PINGROUP(40, qup9, qdss, _, _, _, _, _, _, _),
> +	PINGROUP(41, qup9, qdss, _, _, _, _, _, _, _),
> +	PINGROUP(42, qup9, qdss, _, _, _, _, _, _, _),
> +	PINGROUP(43, qup13, _, _, _, _, _, _, _, _),
> +	PINGROUP(44, qup13, _, _, _, _, _, _, _, _),
> +	PINGROUP(45, qup13, qdss_cti, _, _, _, _, _, _, _),
> +	PINGROUP(46, qup13, qdss_cti, _, _, _, _, _, _, _),
> +	PINGROUP(47, qup14, qdss, _, _, _, _, _, _, _),
> +	PINGROUP(48, qup14, qdss, _, _, _, _, _, _, _),
> +	PINGROUP(49, qup14, _, qdss_cti, _, _, _, _, _, _),
> +	PINGROUP(50, qup14, qdss_cti, _, _, _, _, _, _, _),
> +	PINGROUP(51, qup4, _, _, _, _, _, _, _, _),
> +	PINGROUP(52, qup4, _, _, _, _, _, _, _, _),
> +	PINGROUP(53, qup4, _, _, _, _, _, _, _, _),
> +	PINGROUP(54, qup4, _, _, _, _, _, _, _, _),
> +	PINGROUP(55, qup17, qup19, phase_flag, _, _, _, _, _, _),
> +	PINGROUP(56, qup17, qup19, qdss_cti, phase_flag, _, _, _, _, _),
> +	PINGROUP(57, qup17, qup19, qdss_cti, phase_flag, _, _, _, _, _),
> +	PINGROUP(58, qup17, qup19, qdss_cti, phase_flag, _, _, _, _, _),
> +	PINGROUP(59, rgmii, qup_l4, phase_flag, _, atest_char, _, _, _, _),
> +	PINGROUP(60, _, nav_pps, nav_pps, atest_usb2, _, _, _, _, _),
> +	PINGROUP(61, qlink_request, _, _, _, _, _, _, _, _),
> +	PINGROUP(62, qlink_enable, _, _, _, _, _, _, _, _),
> +	PINGROUP(63, wmss_reset, atest_usb23, _, _, _, _, _, _, _),
> +	PINGROUP(64, _, phase_flag, _, _, _, _, _, _, _),
> +	PINGROUP(65, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(66, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(67, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(68, _, pa_indicator, phase_flag, _, _, _, _, _, _),
> +	PINGROUP(69, mss_lte, _, _, _, _, _, _, _, _),
> +	PINGROUP(70, mss_lte, _, _, _, _, _, _, _, _),
> +	PINGROUP(71, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(72, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(73, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(74, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(75, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(76, _, _, _, nav_pps, nav_pps, phase_flag, _, _, _),
> +	PINGROUP(77, _, _, _, nav_pps, nav_pps, _, _, _, _),
> +	PINGROUP(78, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(79, _, _, phase_flag, _, _, _, _, _, _),
> +	PINGROUP(80, _, _, phase_flag, _, _, _, _, _, _),
> +	PINGROUP(81, _, _, _, nav_pps, nav_pps, qup_l4, mdp_vsync, emac_pps, _),
> +	PINGROUP(82, _, _, _, nav_pps, nav_pps, qup_l5, mdp_vsync, _, _),
> +	PINGROUP(83, qup12, qup16, _, qdss, _, _, _, _, _),
> +	PINGROUP(84, qup12, qup16, _, _, _, _, _, _, _),
> +	PINGROUP(85, qup12, qup16, _, _, _, _, _, _, _),
> +	PINGROUP(86, qup12, qup16, _, _, _, _, _, _, _),
> +	PINGROUP(87, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(88, tsif1, qup8, qspi_cs, tgu_ch3, _, _, _, _, _),
> +	PINGROUP(89, tsif1, qup8, qspi0, mdp_vsync0, mdp_vsync1, mdp_vsync2,
> +		 mdp_vsync3, tgu_ch0, _),
> +	PINGROUP(90, tsif1, qup8, qspi1, sdc4, phase_flag, tgu_ch1, _, _,
> +		 wlan1_adc1),
> +	PINGROUP(91, tsif1, qup8, qspi2, sdc4, vfr_1, phase_flag, tgu_ch2,
> +		 _, _),
> +	PINGROUP(92, tsif2, qup11, qspi_clk, sdc4, phase_flag, _, wlan2_adc1,
> +		 _, _),
> +	PINGROUP(93, tsif2, qup11, qspi3, sdc4, phase_flag, _, wlan2_adc0,
> +		 _, _),
> +	PINGROUP(94, tsif2, qup11, qspi_cs, sdc4, phase_flag, _, _, _, _),
> +	PINGROUP(95, tsif2, qup11, sdc4, qup_l4, _, _, _, _, _),
> +	PINGROUP(96, tsif2, qup_l5, phase_flag, _, _, _, _, _, _),
> +	PINGROUP(97, sd_write, tsif1, qup_l6, _, _, _, _, _, _),
> +	PINGROUP(98, qup7, ddr_bist, ddr_pxi3, _, _, _, _, _, _),
> +	PINGROUP(99, qup7, ddr_bist, atest_usb13, ddr_pxi1, _, _, _, _, _),
> +	PINGROUP(100, qup7, pll_bypassnl, atest_usb12, ddr_pxi1, _, _, _, _, _),
> +	PINGROUP(101, qup7, pll_reset, ddr_pxi3, _, _, _, _, _, _),
> +	PINGROUP(102, pci_e1, _, _, _, _, _, _, _, _),
> +	PINGROUP(103, pci_e1, _, _, _, _, _, _, _, _),
> +	PINGROUP(104, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(105, uim2, _, _, _, _, _, _, _, _),
> +	PINGROUP(106, uim2, _, _, _, _, _, _, _, _),
> +	PINGROUP(107, uim2, _, _, _, _, _, _, _, _),
> +	PINGROUP(108, uim2, _, _, _, _, _, _, _, _),
> +	PINGROUP(109, uim1, _, _, _, _, _, _, _, _),
> +	PINGROUP(110, uim1, _, _, _, _, _, _, _, _),
> +	PINGROUP(111, uim1, _, _, _, _, _, _, _, _),
> +	PINGROUP(112, uim1, _, _, _, _, _, _, _, _),
> +	PINGROUP(113, uim_batt, usb2phy_ac, aoss_cti, _, _, _, _, _, _),
> +	PINGROUP(114, qup1, rgmii, phase_flag, _, _, _, _, _, _),
> +	PINGROUP(115, qup1, rgmii, phase_flag, adsp_ext, _, _, _, _, _),
> +	PINGROUP(116, qup1, rgmii, phase_flag, _, _, _, _, _, _),
> +	PINGROUP(117, qup1, rgmii, phase_flag, _, qdss, _, _, _, _),
> +	PINGROUP(118, rgmii, phase_flag, _, qdss, _, _, _, _, _),
> +	PINGROUP(119, qup5, rgmii, phase_flag, _, qdss, _, _, _, _),
> +	PINGROUP(120, qup5, rgmii, phase_flag, _, qdss, _, _, _, _),
> +	PINGROUP(121, qup5, rgmii, phase_flag, _, qdss, _, _, _, _),
> +	PINGROUP(122, qup5, rgmii, phase_flag, _, _, _, _, _, _),
> +	PINGROUP(123, usb2phy_ac, qup_l6, atest_usb22, _, _, _, _, _, _),
> +	PINGROUP(124, emac_phy, _, _, _, _, _, _, _, _),
> +	PINGROUP(125, hs3_mi2s, _, _, _, _, _, _, _, _),
> +	PINGROUP(126, sec_mi2s, qup2, phase_flag, _, _, _, _, _, _),
> +	PINGROUP(127, sec_mi2s, qup2, phase_flag, _, _, _, _, _, _),
> +	PINGROUP(128, sec_mi2s, qup2, phase_flag, _, _, _, _, _, _),
> +	PINGROUP(129, sec_mi2s, qup2, jitter_bist, atest_usb21, _, _, _, _, _),
> +	PINGROUP(130, sec_mi2s, pll_bist, atest_usb20, atest_char0,
> +		 _, _, _, _, _),
> +	PINGROUP(131, ter_mi2s, gcc_gp1, _, _, _, _, _, _, _),
> +	PINGROUP(132, ter_mi2s, _, qdss, _, _, _, _, _, _),
> +	PINGROUP(133, ter_mi2s, qdss, atest_char1, _, _, _, _, _, _),
> +	PINGROUP(134, ter_mi2s, qdss, atest_char2, _, _, _, _, _, _),
> +	PINGROUP(135, ter_mi2s, atest_char3, _, _, _, _, _, _, _),
> +	PINGROUP(136, qua_mi2s, gcc_gp1, _, _, _, _, _, _, _),
> +	PINGROUP(137, qua_mi2s, gcc_gp2, _, _, _, _, _, _, _),
> +	PINGROUP(138, qua_mi2s, gcc_gp3, _, _, _, _, _, _, _),
> +	PINGROUP(139, qua_mi2s, _, _, _, _, _, _, _, _),
> +	PINGROUP(140, qua_mi2s, _, _, _, _, _, _, _, _),
> +	PINGROUP(141, qua_mi2s, _, _, _, _, _, _, _, _),
> +	PINGROUP(142, qua_mi2s, _, _, _, _, _, _, _, _),
> +	PINGROUP(143, pri_mi2s, _, _, _, _, _, _, _, _),
> +	PINGROUP(144, pri_mi2s, qup3, phase_flag, _, ddr_pxi0, _, _, _, _),
> +	PINGROUP(145, pri_mi2s_ws, qup3, phase_flag, ddr_bist, _,
> +		 vsense_trigger, atest_usb1, ddr_pxi0, _),
> +	PINGROUP(146, pri_mi2s, qup3, ddr_bist, atest_usb11, ddr_pxi2,
> +		 _, _, _, _),
> +	PINGROUP(147, pri_mi2s, qup3, dbg_out, atest_usb10, ddr_pxi2,
> +		 _, _, _, _),
> +	PINGROUP(148, spkr_i2s, audio_ref, _, _, _, _, _, _, _),
> +	PINGROUP(149, lpass_slimbus, spkr_i2s, _, _, _, _, _, _, _),
> +	PINGROUP(150, lpass_slimbus, spkr_i2s, tsense_pwm1, tsense_pwm2,
> +		 _, _, _, _, _),
> +	PINGROUP(151, lpass_slimbus, spkr_i2s, _, _, _, _, _, _, _),
> +	PINGROUP(152, lpass_slimbus, spkr_i2s, _, _, _, _, _, _, _),
> +	PINGROUP(153, btfm_slimbus, _, _, _, _, _, _, _, _),
> +	PINGROUP(154, btfm_slimbus, _, _, _, _, _, _, _, _),
> +	PINGROUP(155, hs1_mi2s, _, _, _, _, _, _, _, _),
> +	PINGROUP(156, hs1_mi2s, _, _, _, _, _, _, _, _),
> +	PINGROUP(157, hs1_mi2s, _, _, _, _, _, _, _, _),
> +	PINGROUP(158, hs1_mi2s, _, _, _, _, _, _, _, _),
> +	PINGROUP(159, hs1_mi2s, cri_trng0, _, _, _, _, _, _, _),
> +	PINGROUP(160, hs2_mi2s, cri_trng1, _, _, _, _, _, _, _),
> +	PINGROUP(161, hs2_mi2s, cri_trng, _, _, _, _, _, _, _),
> +	PINGROUP(162, hs2_mi2s, sp_cmu, _, _, _, _, _, _, _),
> +	PINGROUP(163, hs2_mi2s, prng_rosc, _, _, _, _, _, _, _),
> +	PINGROUP(164, hs2_mi2s, _, _, _, _, _, _, _, _),
> +	PINGROUP(165, hs3_mi2s, _, _, _, _, _, _, _, _),
> +	PINGROUP(166, hs3_mi2s, _, _, _, _, _, _, _, _),
> +	PINGROUP(167, hs3_mi2s, _, _, _, _, _, _, _, _),
> +	PINGROUP(168, hs3_mi2s, _, _, _, _, _, _, _, _),
> +	PINGROUP(169, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(170, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(171, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(172, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(173, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(174, _, _, _, _, _, _, _, _, _),
> +};
> +
> +static const char *sm8150_get_function_name(struct udevice *dev,
> +					    unsigned int selector)
> +{
> +	return msm_pinctrl_functions[selector].name;
> +}
> +
> +static const char *sm8150_get_pin_name(struct udevice *dev,
> +				       unsigned int selector)
> +{
> +	snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
> +	return pin_name;
> +}
> +
> +static unsigned int sm8150_get_function_mux(unsigned int pin,
> +					    unsigned int selector)
> +{
> +	unsigned int i;
> +	const msm_pin_function *func = sm8150_pin_functions + pin;
> +
> +	for (i = 0; i < 10; i++)
> +		if ((*func)[i] == selector)
> +			return i;
> +
> +	pr_err("Can't find requested function for pin %u pin\n", pin);
> +	return 0;
> +}
> +
> +static struct msm_pinctrl_data sm8150_data = {
> +	.pin_data = {
> +		.pin_offsets = sm8150_pin_offsets,
> +		.pin_count = ARRAY_SIZE(sm8150_pin_offsets),
> +	},
> +	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
> +	.get_function_name = sm8150_get_function_name,
> +	.get_function_mux = sm8150_get_function_mux,
> +	.get_pin_name = sm8150_get_pin_name,
> +};
> +
> +static const struct udevice_id msm_pinctrl_ids[] = {
> +	{ .compatible = "qcom,sm8150-pinctrl", .data = (ulong)&sm8150_data },
> +	{ /* Sentinel */ }
> +};
> +
> +U_BOOT_DRIVER(pinctrl_sm8150) = {
> +	.name		= "pinctrl_sm8150",
> +	.id		= UCLASS_NOP,
> +	.of_match	= msm_pinctrl_ids,
> +	.ops		= &msm_pinctrl_ops,
> +	.bind		= msm_pinctrl_bind,
> +};

-- 
// Caleb (they/them)
