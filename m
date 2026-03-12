Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAAFFED2E0
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 07:39:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A49A83F8A;
	Thu, 12 Mar 2026 08:39:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bLlc8tpx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2A868407E; Thu, 12 Mar 2026 08:39:28 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A00E83F6D
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 08:39:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4AA3843E2D;
 Thu, 12 Mar 2026 07:39:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A56FC116C6;
 Thu, 12 Mar 2026 07:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773301164;
 bh=SIG2/StF5JOQR0ArEsRgq1rHawdQ8cHIh9uj41dsOLg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bLlc8tpx8DMv3a60i6PR7zk2owUd9+eISxdzIC9evIybxujHs6vOBZXN4/gDz4MdT
 rNt0teuwb7cffO7ftXmoiVCFjrn41g/Fsu+gGcY7jj/sDiZReAKpldkIbvz7RS+Qme
 +qDRB8bJKi9UpVrXlOUtDcqrPZFjaACeo/xwqTPgVrawmKWpl5n6Fw6XBr1CO7jNkA
 ql+Qg1Y06BaMS6LWyGSbLSSVEUadMn5Pqk00yNNbaBP0FQoxBdBol8n3H6ALARhx88
 fv46Kbqi5ih2GQbICc0F61jeWs4lWZEJsO/K6Ma00cmn4x28QeqcDC1PJlL3RM9ky/
 CJW9fcOQslHDg==
Date: Thu, 12 Mar 2026 13:09:15 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 David Wronek <david.wronek@mainlining.org>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>,
 Lukasz Majewski <lukma@denx.de>, Aelin Reidel <aelin@mainlining.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Sam Day <me@samcday.com>
Subject: Re: [PATCH 1/7] drivers: pinctrl: Add Qualcomm Milos TLMM driver
Message-ID: <abJto36jxEm1c8Tq@sumit-xelite>
References: <20260311-milos-bringup-v1-0-eb905c467f10@fairphone.com>
 <20260311-milos-bringup-v1-1-eb905c467f10@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-milos-bringup-v1-1-eb905c467f10@fairphone.com>
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

On Wed, Mar 11, 2026 at 03:20:41PM +0100, Luca Weiss wrote:
> Add support for TLMM pin controller block (Top Level Mode Multiplexer)
> on Milos SoC, with support for special pins.
> 
> Correct pin configuration is required for working debug UART and eMMC/SD
> cards.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/pinctrl/qcom/Kconfig         |   8 +++
>  drivers/pinctrl/qcom/Makefile        |   1 +
>  drivers/pinctrl/qcom/pinctrl-milos.c | 104 +++++++++++++++++++++++++++++++++++
>  3 files changed, 113 insertions(+)
> 

Looks good to me apart from minor comment below, FWIW:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index 580308621b1..11e6763b5f3 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -54,6 +54,14 @@ config PINCTRL_QCOM_IPQ9574
>  	  Say Y here to enable support for pinctrl on the IPQ9574 SoC,
>  	  as well as the associated GPIO driver.
>  
> +config PINCTRL_QCOM_MILOS
> +	bool "Qualcomm Milos Pinctrl"
> +	default y if PINCTRL_QCOM_GENERIC
> +	select PINCTRL_QCOM
> +	help
> +	  Say Y here to enable support for pinctrl on the Snapdragon Milos SoC,
> +	  as well as the associated GPIO driver.
> +
>  config PINCTRL_QCOM_QCM2290
>  	bool "Qualcomm QCM2290 Pinctrl"
>  	default y if PINCTRL_QCOM_GENERIC
> diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
> index b5a111605ed..4096c1aa491 100644
> --- a/drivers/pinctrl/qcom/Makefile
> +++ b/drivers/pinctrl/qcom/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_PINCTRL_QCOM_IPQ4019) += pinctrl-ipq4019.o
>  obj-$(CONFIG_PINCTRL_QCOM_IPQ5424) += pinctrl-ipq5424.o
>  obj-$(CONFIG_PINCTRL_QCOM_IPQ9574) += pinctrl-ipq9574.o
>  obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
> +obj-$(CONFIG_PINCTRL_QCOM_MILOS) += pinctrl-milos.o
>  obj-$(CONFIG_PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
>  obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
>  obj-$(CONFIG_PINCTRL_QCOM_QCS615) += pinctrl-qcs615.o
> diff --git a/drivers/pinctrl/qcom/pinctrl-milos.c b/drivers/pinctrl/qcom/pinctrl-milos.c
> new file mode 100644
> index 00000000000..974c1a7d594
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/pinctrl-milos.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Qualcomm Milos pinctrl
> + *
> + * (C) Copyright 2024 Linaro Ltd.
> + * (C) Copyright 2025 Luca Weiss <luca.weiss@fairphone.com>

It's 2026 now, maybe you want to update copyright here?

-Sumit

> + *
> + */
> +
> +#include <dm.h>
> +
> +#include "pinctrl-qcom.h"
> +
> +#define MAX_PIN_NAME_LEN 32
> +static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
> +
> +static const struct pinctrl_function msm_pinctrl_functions[] = {
> +	{"qup0_se5", 1},
> +	{"sdc2_clk", 1},
> +	{"sdc2_cmd", 1},
> +	{"sdc2_data", 1},
> +	{"gpio", 0},
> +};
> +
> +#define SDC_QDSD_PINGROUP(pg_name, ctl, pull, drv)	\
> +	{					        \
> +		.name = pg_name,			\
> +		.ctl_reg = ctl,				\
> +		.io_reg = 0,				\
> +		.pull_bit = pull,			\
> +		.drv_bit = drv,				\
> +		.oe_bit = -1,				\
> +		.in_bit = -1,				\
> +		.out_bit = -1,				\
> +	}
> +
> +#define UFS_RESET(pg_name, ctl, io)			\
> +	{					        \
> +		.name = pg_name,			\
> +		.ctl_reg = ctl,				\
> +		.io_reg = io,				\
> +		.pull_bit = 3,				\
> +		.drv_bit = 0,				\
> +		.oe_bit = -1,				\
> +		.in_bit = -1,				\
> +		.out_bit = 0,				\
> +	}
> +
> +static const struct msm_special_pin_data msm_special_pins_data[] = {
> +	[0] = UFS_RESET("ufs_reset", 0xb4004, 0xb5000),
> +	[1] = SDC_QDSD_PINGROUP("sdc2_clk", 0xab000, 0, 6),
> +	[2] = SDC_QDSD_PINGROUP("sdc2_cmd", 0xab000, 12, 3),
> +	[3] = SDC_QDSD_PINGROUP("sdc2_data", 0xab000, 9, 0),
> +};
> +
> +static const char *milos_get_function_name(struct udevice *dev,
> +					   unsigned int selector)
> +{
> +	return msm_pinctrl_functions[selector].name;
> +}
> +
> +static const char *milos_get_pin_name(struct udevice *dev,
> +				      unsigned int selector)
> +{
> +	if (selector >= 167 && selector <= 170)
> +		snprintf(pin_name, MAX_PIN_NAME_LEN,
> +			 msm_special_pins_data[selector - 167].name);
> +	else
> +		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
> +
> +	return pin_name;
> +}
> +
> +static int milos_get_function_mux(__maybe_unused unsigned int pin,
> +				  unsigned int selector)
> +{
> +	return msm_pinctrl_functions[selector].val;
> +}
> +
> +static struct msm_pinctrl_data milos_data = {
> +	.pin_data = {
> +		.pin_count = 171,
> +		.special_pins_start = 167,
> +		.special_pins_data = msm_special_pins_data,
> +	},
> +	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
> +	.get_function_name = milos_get_function_name,
> +	.get_function_mux = milos_get_function_mux,
> +	.get_pin_name = milos_get_pin_name,
> +};
> +
> +static const struct udevice_id msm_pinctrl_ids[] = {
> +	{ .compatible = "qcom,milos-tlmm", .data = (ulong)&milos_data },
> +	{ /* Sentinel */ }
> +};
> +
> +U_BOOT_DRIVER(pinctrl_milos) = {
> +	.name		= "pinctrl_milos",
> +	.id		= UCLASS_NOP,
> +	.of_match	= msm_pinctrl_ids,
> +	.ops		= &msm_pinctrl_ops,
> +	.bind		= msm_pinctrl_bind,
> +};
> +
> 
> -- 
> 2.53.0
> 
