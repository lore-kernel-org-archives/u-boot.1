Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B60EC2BA15
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 14:16:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF5A888271;
	Mon, 17 Jun 2024 16:16:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EkX6zPBk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D356E88283; Mon, 17 Jun 2024 16:16:41 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DF2D8826E
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 16:16:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4218008c613so33591015e9.2
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 07:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718633799; x=1719238599; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=h/UxvtKDSCKSlvZ9r+ERpSJogbi924hhsFqgM0dznqY=;
 b=EkX6zPBkCTpiCAwSZp/DPfovlm2pIPHbS8czvKBZ6UjsiTf6F7XpmZK+Jxf8A6N2EJ
 0EZdIcZmh3GQE+gQXYgBX1LwQbFv9dTXGk2BXsY/d8zo6dm2JSVs51AeSfG0euoY6kU2
 XBtn/An7HpiXYTzMrwy2ElEhqvc59QjF0IOlIkfpHZwGfaV4fl8XVaE2wzoFTBCWq6Z6
 mjeTLfBjzf50ASmmaOASQb1oDfUutwJ6zT8C6d/UQVg7rDSo4K/liz9WeqNKQLAM2SBW
 gZcs4MBvhs+I+izAP/Ze0Sgx3oCZ09XrtFbkdTrOIJQtCAlCjIzBPjY1lcedRaxOwWdX
 R98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718633799; x=1719238599;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=h/UxvtKDSCKSlvZ9r+ERpSJogbi924hhsFqgM0dznqY=;
 b=by6a2yl24pBIXQPb5TcNWNieAqv6dXi9qsqfB0b75VqLiAJFfldwNe7JHf/HpyPdHT
 UGePpPE0QUk6aDiOZEjp8C9hze98C7ltAh8/ajfBjfNdE03b6c8LOWk7X1N1N9egK0jf
 cZwD4YLSIIvVt5BKeDIEz44anSSbWyQeLS0tpKmFPRE2habAHdl5QxTFab9ku5OhnChq
 2N6pFrJic8915UqHCcIwpkZPEg8OQ5V4Tos+o2VsGJLHsCfze3vy3UQ/9adLFmBHYKI1
 ZZJtnryOP1cqVYUZ8qUdabfonl6z1IErwAIP1+//zVhRdqLNT79R9/WIM/Dy8oLQAVSY
 9f2A==
X-Gm-Message-State: AOJu0YxUABRjMjggAy3c9YX47XeGiXdD5xap4ZzjjOMH/psp42EhTBNz
 atc+Rd4YerF4ANfN+0HmdTxs7nF1z7PXE92I5DqeWDmtDtG4oPFw2F2regJCcI4=
X-Google-Smtp-Source: AGHT+IEGDdKvlq/QfFXVWr/3A66SPdAH11vgv72Zw82An7qARKT5565yfJtQUnpckAWq8pKU+QU94g==
X-Received: by 2002:a7b:ce07:0:b0:421:79c8:dd37 with SMTP id
 5b1f17b1804b1-4230485a341mr66112995e9.40.1718633798358; 
 Mon, 17 Jun 2024 07:16:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7f86:d83c:9278:7757?
 ([2a01:e0a:982:cbb0:7f86:d83c:9278:7757])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42286eef9c1sm198120725e9.7.2024.06.17.07.16.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 07:16:37 -0700 (PDT)
Message-ID: <259fcd2b-d85f-4a09-af48-3e25afbfef98@linaro.org>
Date: Mon, 17 Jun 2024 16:16:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/3] power: regulator: add qcom-rpmh-regulator
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20240617-b4-qcom-rpmh-v1-0-bd2336923e0a@linaro.org>
 <20240617-b4-qcom-rpmh-v1-3-bd2336923e0a@linaro.org>
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
In-Reply-To: <20240617-b4-qcom-rpmh-v1-3-bd2336923e0a@linaro.org>
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

On 17/06/2024 10:32, Caleb Connolly wrote:
> Add a regulator driver for controlling the PMIC rails via the RPMh on
> Qualcomm platforms. This driver is restricted to only know about rails
> which are required by u-boot.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/power/regulator/Kconfig               |   8 +
>   drivers/power/regulator/Makefile              |   1 +
>   drivers/power/regulator/qcom-rpmh-regulator.c | 534 ++++++++++++++++++++++++++
>   3 files changed, 543 insertions(+)
> 
> diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
> index 102ec7bc5f89..bc061c20d75e 100644
> --- a/drivers/power/regulator/Kconfig
> +++ b/drivers/power/regulator/Kconfig
> @@ -215,8 +215,16 @@ config DM_REGULATOR_GPIO
>   	This config enables implementation of driver-model regulator uclass
>   	features for gpio regulators. The driver implements get/set for
>   	voltage value.
>   
> +config DM_REGULATOR_QCOM_RPMH
> +	bool "Enable driver model for Qualcomm RPMh regulator"
> +	depends on DM_REGULATOR && QCOM_RPMH
> +	---help---
> +	  Enable support for the Qualcomm RPMh regulator. The driver
> +	  implements get/set api for a limited set of regulators used
> +	  by u-boot.
> +
>   config SPL_DM_REGULATOR_GPIO
>   	bool "Enable Driver Model for GPIO REGULATOR in SPL"
>   	depends on DM_REGULATOR_GPIO && SPL_GPIO
>   	select SPL_DM_REGULATOR_COMMON
> diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
> index f79932d83307..56a527612b74 100644
> --- a/drivers/power/regulator/Makefile
> +++ b/drivers/power/regulator/Makefile
> @@ -20,8 +20,9 @@ obj-$(CONFIG_$(SPL_)REGULATOR_PWM) += pwm_regulator.o
>   obj-$(CONFIG_$(SPL_)DM_REGULATOR_FAN53555) += fan53555.o
>   obj-$(CONFIG_$(SPL_)DM_REGULATOR_COMMON) += regulator_common.o
>   obj-$(CONFIG_$(SPL_)DM_REGULATOR_FIXED) += fixed.o
>   obj-$(CONFIG_$(SPL_)DM_REGULATOR_GPIO) += gpio-regulator.o
> +obj-$(CONFIG_DM_REGULATOR_QCOM_RPMH) += qcom-rpmh-regulator.o
>   obj-$(CONFIG_$(SPL_TPL_)REGULATOR_RK8XX) += rk8xx.o
>   obj-$(CONFIG_DM_REGULATOR_S2MPS11) += s2mps11_regulator.o
>   obj-$(CONFIG_REGULATOR_S5M8767) += s5m8767.o
>   obj-$(CONFIG_DM_REGULATOR_SANDBOX) += sandbox.o
> diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
> new file mode 100644
> index 000000000000..51d8d493a3d5
> --- /dev/null
> +++ b/drivers/power/regulator/qcom-rpmh-regulator.c
> @@ -0,0 +1,534 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018-2021, The Linux Foundation. All rights reserved.
> +
> +#include <linux/err.h>
> +#include <dm/device_compat.h>
> +#include <dm/device.h>
> +#include <dm/devres.h>
> +#include <dm/lists.h>
> +#include <power/regulator.h>
> +#include <log.h>
> +
> +#include <soc/qcom/cmd-db.h>
> +#include <soc/qcom/rpmh.h>
> +
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +
> +/**
> + * enum rpmh_regulator_type - supported RPMh accelerator types
> + * @VRM:	RPMh VRM accelerator which supports voting on enable, voltage,
> + *		and mode of LDO, SMPS, and BOB type PMIC regulators.
> + * @XOB:	RPMh XOB accelerator which supports voting on the enable state
> + *		of PMIC regulators.
> + */
> +enum rpmh_regulator_type {
> +	VRM,
> +	XOB,
> +};
> +
> +enum rpmh_regulator_mode {
> +	REGULATOR_MODE_RETENTION,
> +	REGULATOR_MODE_LPM,
> +	REGULATOR_MODE_AUTO,
> +	REGULATOR_MODE_HPM,
> +};
> +
> +#define RPMH_REGULATOR_REG_VRM_VOLTAGE		0x0
> +#define RPMH_REGULATOR_REG_ENABLE		0x4
> +#define RPMH_REGULATOR_REG_VRM_MODE		0x8
> +
> +#define PMIC4_LDO_MODE_RETENTION		4
> +#define PMIC4_LDO_MODE_LPM			5
> +#define PMIC4_LDO_MODE_HPM			7
> +
> +#define PMIC4_SMPS_MODE_RETENTION		4
> +#define PMIC4_SMPS_MODE_PFM			5
> +#define PMIC4_SMPS_MODE_AUTO			6
> +#define PMIC4_SMPS_MODE_PWM			7
> +
> +#define PMIC4_BOB_MODE_PASS			0
> +#define PMIC4_BOB_MODE_PFM			1
> +#define PMIC4_BOB_MODE_AUTO			2
> +#define PMIC4_BOB_MODE_PWM			3
> +
> +#define PMIC5_LDO_MODE_RETENTION		3
> +#define PMIC5_LDO_MODE_LPM			4
> +#define PMIC5_LDO_MODE_HPM			7
> +
> +#define PMIC5_SMPS_MODE_RETENTION		3
> +#define PMIC5_SMPS_MODE_PFM			4
> +#define PMIC5_SMPS_MODE_AUTO			6
> +#define PMIC5_SMPS_MODE_PWM			7
> +
> +#define PMIC5_BOB_MODE_PASS			2
> +#define PMIC5_BOB_MODE_PFM			4
> +#define PMIC5_BOB_MODE_AUTO			6
> +#define PMIC5_BOB_MODE_PWM			7
> +
> +/**
> + * struct linear_range - table of selector - value pairs
> + *
> + * Define a lookup-table for range of values. Intended to help when looking
> + * for a register value matching certaing physical measure (like voltage).
> + * Usable when increment of one in register always results a constant increment
> + * of the physical measure (like voltage).
> + *
> + * @min:  Lowest value in range
> + * @min_sel: Lowest selector for range
> + * @max_sel: Highest selector for range
> + * @step: Value step size
> + */
> +struct linear_range {
> +	unsigned int min;
> +	unsigned int min_sel;
> +	unsigned int max_sel;
> +	unsigned int step;
> +};
> +
> +/* Initialize struct linear_range for regulators */
> +#define REGULATOR_LINEAR_RANGE(_min_uV, _min_sel, _max_sel, _step_uV)	\
> +{									\
> +	.min		= _min_uV,					\
> +	.min_sel	= _min_sel,					\
> +	.max_sel	= _max_sel,					\
> +	.step		= _step_uV,					\
> +}
> +
> +/**
> + * struct rpmh_vreg_hw_data - RPMh regulator hardware configurations
> + * @regulator_type:		RPMh accelerator type used to manage this
> + *				regulator
> + * @ops:			Pointer to regulator ops callback structure
> + * @voltage_range:		The single range of voltages supported by this
> + *				PMIC regulator type
> + * @n_voltages:			The number of unique voltage set points defined
> + *				by voltage_range
> + * @hpm_min_load_uA:		Minimum load current in microamps that requires
> + *				high power mode (HPM) operation.  This is used
> + *				for LDO hardware type regulators only.
> + * @pmic_mode_map:		Array indexed by regulator framework mode
> + *				containing PMIC hardware modes.  Must be large
> + *				enough to index all framework modes supported
> + *				by this regulator hardware type.
> + * @of_map_mode:		Maps an RPMH_REGULATOR_MODE_* mode value defined
> + *				in device tree to a regulator framework mode
> + */
> +struct rpmh_vreg_hw_data {
> +	enum rpmh_regulator_type		regulator_type;
> +	const struct dm_regulator_ops		*ops;
> +	struct linear_range			voltage_range;
> +	int					n_voltages;
> +	int					hpm_min_load_uA;
> +	struct dm_regulator_mode		*pmic_mode_map;
> +	int					n_modes;
> +	unsigned int				(*of_map_mode)(unsigned int mode);
> +};
> +
> +/**
> + * struct rpmh_vreg - individual RPMh regulator data structure encapsulating a
> + *		single regulator device
> + * @dev:			Device pointer for the top-level PMIC RPMh
> + *				regulator parent device.  This is used as a
> + *				handle in RPMh write requests.
> + * @addr:			Base address of the regulator resource within
> + *				an RPMh accelerator
> + * @rdesc:			Regulator descriptor
> + * @hw_data:			PMIC regulator configuration data for this RPMh
> + *				regulator
> + * @always_wait_for_ack:	Boolean flag indicating if a request must always
> + *				wait for an ACK from RPMh before continuing even
> + *				if it corresponds to a strictly lower power
> + *				state (e.g. enabled --> disabled).
> + * @enabled:			Flag indicating if the regulator is enabled or
> + *				not
> + * @bypassed:			Boolean indicating if the regulator is in
> + *				bypass (pass-through) mode or not.  This is
> + *				only used by BOB rpmh-regulator resources.
> + * @uv:				Selector used for get_voltage_sel() and
> + *				set_value() callbacks
> + * @mode:			RPMh VRM regulator current framework mode
> + */
> +struct rpmh_vreg {
> +	struct udevice			*dev;
> +	u32				addr;
> +	const struct rpmh_vreg_hw_data	*hw_data;
> +	bool				always_wait_for_ack;
> +
> +	int				enabled;
> +	bool				bypassed;
> +	int				uv;
> +	int			mode;
> +};
> +
> +/**
> + * struct rpmh_vreg_init_data - initialization data for an RPMh regulator
> + * @name:			Name for the regulator which also corresponds
> + *				to the device tree subnode name of the regulator
> + * @resource_name:		RPMh regulator resource name format string.
> + *				This must include exactly one field: '%s' which
> + *				is filled at run-time with the PMIC ID provided
> + *				by device tree property qcom,pmic-id.  Example:
> + *				"ldo%s1" for RPMh resource "ldoa1".
> + * @supply_name:		Parent supply regulator name
> + * @hw_data:			Configuration data for this PMIC regulator type
> + */
> +struct rpmh_vreg_init_data {
> +	const char			*name;
> +	const char			*resource_name;
> +	const char			*supply_name;
> +	const struct rpmh_vreg_hw_data	*hw_data;
> +};
> +
> +/**
> + * rpmh_regulator_send_request() - send the request to RPMh
> + * @vreg:		Pointer to the RPMh regulator
> + * @cmd:		Pointer to the RPMh command to send
> + * @wait_for_ack:	Boolean indicating if execution must wait until the
> + *			request has been acknowledged as complete
> + *
> + * Return: 0 on success, errno on failure
> + */
> +static int rpmh_regulator_send_request(struct rpmh_vreg *vreg,
> +				       struct tcs_cmd *cmd, bool wait_for_ack)
> +{
> +	int ret;
> +
> +	if (wait_for_ack || vreg->always_wait_for_ack)
> +		ret = rpmh_write(vreg->dev->parent, RPMH_ACTIVE_ONLY_STATE, cmd, 1);
> +	else
> +		ret = rpmh_write_async(vreg->dev->parent, RPMH_ACTIVE_ONLY_STATE, cmd, 1);
> +
> +	return ret;
> +}
> +
> +static int _rpmh_regulator_vrm_set_value(struct udevice *rdev,
> +					 int uv, bool wait_for_ack)
> +{
> +	struct rpmh_vreg *vreg = dev_get_priv(rdev);
> +	struct tcs_cmd cmd = {
> +		.addr = vreg->addr + RPMH_REGULATOR_REG_VRM_VOLTAGE,
> +	};
> +	int ret;
> +
> +	/* VRM voltage control register is set with voltage in millivolts. */
> +	uv = (uv / vreg->hw_data->voltage_range.step) *
> +		(vreg->hw_data->voltage_range.step / 1000);
> +	cmd.data = uv; // XXX: CHECKME

While adding support for the *8550* regulators, I inspire myself from the
Linux regulator_list_voltage_linear_range() and it gave me much better results:

```
unsigned int selector = (uv - vreg->hw_data->voltage_range.min) / vreg->hw_data->voltage_range.step;
cmd.data = DIV_ROUND_UP(vreg->hw_data->voltage_range.min + selector * vreg->hw_data->voltage_range.step, 1000);
vreg->uv = cmd.data * 1000;
```

Neil

> +
> +	ret = rpmh_regulator_send_request(vreg, &cmd, wait_for_ack);
> +	if (!ret)
> +		vreg->uv = uv;
> +
> +	return ret;
> +}
> +
> +static int rpmh_regulator_vrm_set_value(struct udevice *rdev,
> +					int uv)
> +{
> +	struct rpmh_vreg *vreg = dev_get_priv(rdev);
> +
> +	debug("%s: set_value %d (current %d)\n", rdev->name, uv, vreg->uv);
> +
> +	if (vreg->enabled == -EINVAL) {
> +		/*
> +		 * Cache the voltage and send it later when the regulator is
> +		 * enabled or disabled.
> +		 */
> +		vreg->uv = uv;
> +		return 0;
> +	}
> +
> +	return _rpmh_regulator_vrm_set_value(rdev, uv,
> +					uv > vreg->uv);
> +}
> +
> +static int rpmh_regulator_vrm_get_value(struct udevice *rdev)
> +{
> +	struct rpmh_vreg *vreg = dev_get_priv(rdev);
> +
> +	debug("%s: get_value %d\n", rdev->name, vreg->uv);
> +
> +	return vreg->uv;
> +}
> +
> +static int rpmh_regulator_is_enabled(struct udevice *rdev)
> +{
> +	struct rpmh_vreg *vreg = dev_get_priv(rdev);
> +
> +	debug("%s: is_enabled %d\n", rdev->name, vreg->enabled);
> +
> +	return vreg->enabled > 0;
> +}
> +
> +static int rpmh_regulator_set_enable_state(struct udevice *rdev,
> +					   bool enable)
> +{
> +	struct rpmh_vreg *vreg = dev_get_priv(rdev);
> +	struct tcs_cmd cmd = {
> +		.addr = vreg->addr + RPMH_REGULATOR_REG_ENABLE,
> +		.data = enable,
> +	};
> +	int ret;
> +
> +	debug("%s: set_enable %d (current %d)\n", rdev->name, enable,
> +	      vreg->enabled);
> +
> +	if (vreg->enabled == -EINVAL &&
> +	    vreg->uv != -ENOTRECOVERABLE) {
> +		ret = _rpmh_regulator_vrm_set_value(rdev,
> +						    vreg->uv, true);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret = rpmh_regulator_send_request(vreg, &cmd, enable);
> +	if (!ret)
> +		vreg->enabled = enable;
> +
> +	return ret;
> +}
> +
> +static int rpmh_regulator_vrm_set_mode_bypass(struct rpmh_vreg *vreg,
> +					      unsigned int mode, bool bypassed)
> +{
> +	struct tcs_cmd cmd = {
> +		.addr = vreg->addr + RPMH_REGULATOR_REG_VRM_MODE,
> +	};
> +	struct dm_regulator_mode *pmic_mode;
> +	int i;
> +
> +	if (mode > REGULATOR_MODE_HPM)
> +		return -EINVAL;
> +
> +	for (i = 0; i < vreg->hw_data->n_modes; i++) {
> +		pmic_mode = &vreg->hw_data->pmic_mode_map[i];
> +		if (pmic_mode->id == mode)
> +			break;
> +	}
> +	if (pmic_mode->id != mode) {
> +		printf("Invalid mode %d\n", mode);
> +		return -EINVAL;
> +	}
> +
> +	if (bypassed)
> +		cmd.data = PMIC4_BOB_MODE_PASS;
> +	else
> +		cmd.data = pmic_mode->id;
> +
> +	return rpmh_regulator_send_request(vreg, &cmd, true);
> +}
> +
> +static int rpmh_regulator_vrm_set_mode(struct udevice *rdev,
> +				       int mode)
> +{
> +	struct rpmh_vreg *vreg = dev_get_priv(rdev);
> +	int ret;
> +
> +	debug("%s: set_mode %d (current %d)\n", rdev->name, mode, vreg->mode);
> +
> +	if (mode == vreg->mode)
> +		return 0;
> +
> +	ret = rpmh_regulator_vrm_set_mode_bypass(vreg, mode, vreg->bypassed);
> +	if (!ret)
> +		vreg->mode = mode;
> +
> +	return ret;
> +}
> +
> +static int rpmh_regulator_vrm_get_mode(struct udevice *rdev)
> +{
> +	struct rpmh_vreg *vreg = dev_get_priv(rdev);
> +
> +	debug("%s: get_mode %d\n", rdev->name, vreg->mode);
> +
> +	return vreg->mode;
> +}
> +
> +static const struct dm_regulator_ops rpmh_regulator_vrm_drms_ops = {
> +	.get_value = rpmh_regulator_vrm_get_value,
> +	.set_value = rpmh_regulator_vrm_set_value,
> +	.set_enable = rpmh_regulator_set_enable_state,
> +	.get_enable = rpmh_regulator_is_enabled,
> +	.set_mode = rpmh_regulator_vrm_set_mode,
> +	.get_mode = rpmh_regulator_vrm_get_mode,
> +};
> +
> +static struct dm_regulator_mode pmic_mode_map_pmic5_ldo[] = {
> +	{
> +		.id = REGULATOR_MODE_RETENTION,
> +		.register_value = PMIC5_LDO_MODE_RETENTION,
> +		.name = "PMIC5_LDO_MODE_RETENTION"
> +	}, {
> +		.id = REGULATOR_MODE_LPM,
> +		.register_value = PMIC5_LDO_MODE_LPM,
> +		.name = "PMIC5_LDO_MODE_LPM"
> +	}, {
> +		.id = REGULATOR_MODE_HPM,
> +		.register_value = PMIC5_LDO_MODE_HPM,
> +		.name = "PMIC5_LDO_MODE_HPM"
> +	},
> +};
> +
> +static const struct rpmh_vreg_hw_data pmic5_pldo_lv = {
> +	.regulator_type = VRM,
> +	.ops = &rpmh_regulator_vrm_drms_ops,
> +	.voltage_range = REGULATOR_LINEAR_RANGE(1504000, 0, 62, 8000),
> +	.n_voltages = 63,
> +	.hpm_min_load_uA = 10000,
> +	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
> +};
> +
> +static const struct rpmh_vreg_hw_data pmic5_pldo = {
> +	.regulator_type = VRM,
> +	.ops = &rpmh_regulator_vrm_drms_ops,
> +	.voltage_range = REGULATOR_LINEAR_RANGE(1504000, 0, 255, 8000),
> +	.n_voltages = 256,
> +	.hpm_min_load_uA = 10000,
> +	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
> +	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic5_ldo),
> +};
> +
> +#define RPMH_VREG(_name, _resource_name, _hw_data, _supply_name) \
> +{ \
> +	.name		= _name, \
> +	.resource_name	= _resource_name, \
> +	.hw_data	= _hw_data, \
> +	.supply_name	= _supply_name, \
> +}
> +
> +static const struct rpmh_vreg_init_data pm8150_vreg_data[] = {
> +	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_pldo,      "vdd-l13-l16-l17"),
> +};
> +
> +static const struct rpmh_vreg_init_data pm8150l_vreg_data[] = {
> +	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_pldo_lv,   "vdd-l1-l8"),
> +	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_pldo,      "vdd-l7-l11"),
> +	{}
> +};
> +
> +/* probe an individual regulator */
> +static int rpmh_regulator_probe(struct udevice *dev)
> +{
> +	const struct rpmh_vreg_init_data *init_data;
> +	struct rpmh_vreg *priv;
> +	struct dm_regulator_uclass_plat *plat_data;
> +
> +	init_data = (const struct rpmh_vreg_init_data *)dev_get_driver_data(dev);
> +	priv = dev_get_priv(dev);
> +	plat_data = dev_get_uclass_plat(dev);
> +
> +	priv->dev = dev;
> +	priv->addr = cmd_db_read_addr(dev->name);
> +	if (!priv->addr) {
> +		printf("Failed to read RPMh address for %s\n", dev->name);
> +		return -ENODEV;
> +	}
> +
> +	priv->hw_data = init_data->hw_data;
> +	priv->enabled = -EINVAL;
> +	priv->uv = -ENOTRECOVERABLE;
> +	if (ofnode_read_u32(dev_ofnode(dev), "regulator-initial-mode", &priv->mode))
> +		priv->mode = -EINVAL;
> +
> +	// handle stepping
> +	// almost there!!!
> +	plat_data->mode = priv->hw_data->pmic_mode_map;
> +	plat_data->mode_count = priv->hw_data->n_modes;
> +
> +	return 0;
> +}
> +
> +/* for non-drm, xob, or bypass regulators add additional driver definitions */
> +U_BOOT_DRIVER(rpmh_regulator_drm) = {
> +	.name = "rpmh_regulator_drm",
> +	.id = UCLASS_REGULATOR,
> +	.probe = rpmh_regulator_probe,
> +	.priv_auto = sizeof(struct rpmh_vreg),
> +	.ops = &rpmh_regulator_vrm_drms_ops,
> +};
> +
> +/* This driver intentionally only supports a subset of the available regulators.
> + * This function checks to see if a given regulator node in DT matches a regulator
> + * defined in the driver.
> + */
> +static const struct rpmh_vreg_init_data *
> +vreg_get_init_data(const struct rpmh_vreg_init_data *init_data, ofnode node)
> +{
> +	const struct rpmh_vreg_init_data *data;
> +
> +	for (data = init_data; data->name; data++) {
> +		if (!strcmp(data->name, ofnode_get_name(node)))
> +			return data;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int rpmh_regulators_bind(struct udevice *dev)
> +{
> +	const struct rpmh_vreg_init_data *init_data, *data;
> +	const char *pmic_id;
> +	char *name;
> +	struct driver *drv;
> +	ofnode node;
> +	int ret;
> +	size_t namelen;
> +
> +	init_data = (const struct rpmh_vreg_init_data *)dev_get_driver_data(dev);
> +	if (!init_data) {
> +		printf("No RPMh regulator init data\n");
> +		return -ENODEV;
> +	}
> +
> +	pmic_id = ofnode_read_string(dev_ofnode(dev), "qcom,pmic-id");
> +	if (!pmic_id) {
> +		printf("No PMIC ID\n");
> +		return -ENODEV;
> +	}
> +
> +	drv = lists_driver_lookup_name("rpmh_regulator_drm");
> +
> +	ofnode_for_each_subnode(node, dev_ofnode(dev)) {
> +		data = vreg_get_init_data(init_data, node);
> +		if (!data)
> +			continue;
> +
> +		/* %s is replaced with pmic_id, so subtract 2, then add 1 for the null terminator */
> +		namelen = strlen(data->resource_name) + strlen(pmic_id) - 1;
> +		name = devm_kzalloc(dev, namelen, GFP_KERNEL);
> +		ret = snprintf(name, namelen, data->resource_name, pmic_id);
> +		if (ret < 0 || ret >= namelen) {
> +			printf("Failed to create RPMh regulator name\n");
> +			return -ENOMEM;
> +		}
> +
> +		ret = device_bind_with_driver_data(dev, drv, name, (ulong)data,
> +						   node, NULL);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct udevice_id rpmh_regulator_ids[] = {
> +	{
> +		.compatible = "qcom,pm8150-rpmh-regulators",
> +		.data = (ulong)pm8150_vreg_data,
> +	},
> +	{
> +		.compatible = "qcom,pm8150l-rpmh-regulators",
> +		.data = (ulong)pm8150l_vreg_data,
> +	},
> +	{ /* sentinal */ },
> +};
> +
> +/* Driver for a 'bank' of regulators. This creates devices for each
> + * individual regulator
> + */
> +U_BOOT_DRIVER(rpmh_regulators) = {
> +	.name = "rpmh_regulators",
> +	.id = UCLASS_MISC,
> +	.bind = rpmh_regulators_bind,
> +	.of_match = rpmh_regulator_ids,
> +	.ops = &rpmh_regulator_vrm_drms_ops,
> +};
> 

