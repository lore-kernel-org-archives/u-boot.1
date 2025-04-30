Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D4AC369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 09:06:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B195482B20;
	Wed, 30 Apr 2025 11:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oERF9oD6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ACEF82B26; Wed, 30 Apr 2025 11:06:03 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E64AA82B17
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 11:06:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso77809935e9.3
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 02:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746003960; x=1746608760; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=cNNlxsCx/t2R0WdVuGVIWaFWpRH+5LIswt14Bhjksx0=;
 b=oERF9oD6GFIEQJNjggzYohwI2Wb+96atYSnbFPAKdaM92lU3r7Xbddr/7W1FxsZgrv
 Cf+5l+g5Qc1U/DZVcAkZlzFvAYApOS42nhHHP82B4B2JzK2jARZ3B61k9kX6RzVIBhyz
 NxGWtx/gZ6zt5nbEhorzL7oczquurIH22zTn8uMkFphDOhXAt5z2B3GjU0F3VPgJIkh7
 tH0Kc9BDyDt97kEG1gLkozmGFwtGJZTtGUdwwCySvBB7AtDD0DxDkkGpKJ+eVbvzpGh+
 tBF5+cMo34WC30xGFMXdRcLf7oO4g7YY+1NI6sBuqSdW2LO380+LWiHGdUOJU/oel6s1
 g8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746003960; x=1746608760;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cNNlxsCx/t2R0WdVuGVIWaFWpRH+5LIswt14Bhjksx0=;
 b=YK1Z1P63wgd9VfggtKQzTsoFRJJbelPfysAqvfLRQbNFb6a93Ha6pN8bqDyWrXj/3i
 cfY10enWOqSZCle8k+x8A70/2tC3Mmiq3ku4MpJ8qEVOlrYBbwkCifKyHgTg9gnXzyIq
 SgVhL5hANNmcG38G7cPTtLxnqa+vGKrLjUXxQjsJHLvqVwdKMvAz1FIitu0y864wEKqZ
 RpJqzIvPqywzXlo+YxvMA8TbhwLIFPz0b8/oAJ2u11FtnbPE2O0GW2mskse9/fnKb7Rf
 4b90KlqZ5/0DLjPx4ZI0bGZgchYVmkA5jt5BPjYY5HWiHu2VFLibVslHQK2JbKSOPCnt
 eaWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT34GEeNGv1oGVIungVwJR6POsbTayFN+7FlH6eDTZPjVAqBaAhJli2/LTMiBVVuQRefUfmEs=@lists.denx.de
X-Gm-Message-State: AOJu0YwGJ0Ulg55ibUJaDHkf5ekXSQyp9UTvh8hUnuMtsAcBBVaPeehi
 pVRTd+ayTaqXBTL906a3YPrmrgv99inPzYqaX+Fmn7/O6nz+vst+r7ZewUoHsbM=
X-Gm-Gg: ASbGncuvv7s6xsiKcjWqTZb6C9ts6/IHgyjDMYKLj1qYLO8ZmaCl0qa0TPEOTFxk8oK
 HFmbW9RVlkKkIu+dXEwOgPHXwAeq1g0YXRGBiywgid+s4h2dyx72IDI25FYlfhK0aY0o7axeZ1h
 3sfFWxFcPTNuvfEiw6e+7BYnmE5fxTBVJ/Gl22Um7fn0WOaaOesyjmV82OUrwrR5IfaVWC3u/hh
 an8pm9rhlZg+MIvmffXGnpAq9DrNAZpaCYhAgdh0xMD0Z+gEpt6dMScWpr7WHFyFJQye3YF3xn1
 siJexgpzeN5jJUrdyhX/EGGff/bfngTaKzAs/IsVN6mEomxnngc4WOAyUvZCzHbS4DwbsdaFXBp
 h/kjpZ47efeOKqA0TLA==
X-Google-Smtp-Source: AGHT+IER/J4jAdAvBMEviEbwzs3zX4nXaNHwOqc5SCtHcBoMH/ukNs3mB5crAiST5L6w+vn0PDwtCg==
X-Received: by 2002:a05:600c:3c8d:b0:43c:fcbc:9680 with SMTP id
 5b1f17b1804b1-441b1f5c80cmr17491285e9.25.1746003960280; 
 Wed, 30 Apr 2025 02:06:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:b3d6:213c:5c50:7785?
 ([2a01:e0a:3d9:2080:b3d6:213c:5c50:7785])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2bbbedfsm17208325e9.26.2025.04.30.02.05.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 02:05:59 -0700 (PDT)
Message-ID: <939dc699-5aaa-42da-ae74-71234b607785@linaro.org>
Date: Wed, 30 Apr 2025 11:05:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/2] sysreset: Implement PSCI based reset to EDL mode
 for QCOM SoCs
To: Varadarajan Narayanan <quic_varada@quicinc.com>,
 casey.connolly@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org, seashell11234455@gmail.com, clamor95@gmail.com,
 ycliang@andestech.com, me@samcday.com, robert.marko@sartura.hr,
 sjg@chromium.org, marek.vasut+renesas@mailbox.org, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20250430085428.1090801-1-quic_varada@quicinc.com>
 <20250430085428.1090801-2-quic_varada@quicinc.com>
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
In-Reply-To: <20250430085428.1090801-2-quic_varada@quicinc.com>
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

On 30/04/2025 10:54, Varadarajan Narayanan wrote:
> The SYSRESET_PSCI interface presently available doesn't support booting
> into Emergency DownLoad (EDL) mode. The EDL mode is used to flash the
> board with different firmware.
> 
> Since EDL is Qcom specific, implement a Qcom specific SYSRESET_PSCI
> handler that handles resetting to EDL in addition to the usual cold/warm
> reset and poweroff.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v2: * Update commit message
>      * Elaborate Kconfig help text
>      * Use '-edl' instead of 'edl' for consistency with other arguments of reset
>        command
>      * Remove 'weak' for qcom_psci_sysreset_get_status() and make it static
>      * Mention 'SYSRESET_EDL' is Qcom specific in the enum's comments
> ---
>   drivers/firmware/psci.c               |  4 +++
>   drivers/sysreset/Kconfig              |  7 ++++
>   drivers/sysreset/Makefile             |  1 +
>   drivers/sysreset/sysreset-uclass.c    |  7 ++--
>   drivers/sysreset/sysreset_qcom-psci.c | 48 +++++++++++++++++++++++++++
>   include/sysreset.h                    |  7 ++++
>   6 files changed, 72 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/sysreset/sysreset_qcom-psci.c
> 
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index 2e3223e1c32..b6838a244d2 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -186,6 +186,10 @@ static int psci_bind(struct udevice *dev)
>   					 NULL);
>   		if (ret)
>   			pr_debug("PSCI System Reset was not bound.\n");
> +		if (IS_ENABLED(CONFIG_SYSRESET_QCOM_PSCI) &&
> +		    device_bind_driver(dev, "qcom_psci-sysreset",
> +				       "qcom_psci-sysreset", NULL))
> +			pr_debug("QCOM PSCI System Reset was not bound.\n");
>   	}
>   
>   	/* From PSCI v1.0 onward we can discover services through ARM_SMCCC_FEATURE */
> diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
> index 4972905482a..d407c322bdb 100644
> --- a/drivers/sysreset/Kconfig
> +++ b/drivers/sysreset/Kconfig
> @@ -285,6 +285,13 @@ config SYSRESET_RAA215300
>   	help
>   	  Add support for the system reboot via the Renesas RAA215300 PMIC.
>   
> +config SYSRESET_QCOM_PSCI
> +	bool "Support sysreset for Qualcomm SoCs via PSCI"
> +	help
> +	  Add support for the system reboot on Qualcomm SoCs via PSCI.
> +	  This allows warm/cold reset, poweroff and reset to EDL (Emergency
> +	  Download)
> +
>   config SYSRESET_QCOM_PSHOLD
>   	bool "Support sysreset for Qualcomm SoCs via PSHOLD"
>   	help
> diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
> index ded91a4d325..58eb0e356e1 100644
> --- a/drivers/sysreset/Makefile
> +++ b/drivers/sysreset/Makefile
> @@ -29,5 +29,6 @@ obj-$(CONFIG_SYSRESET_RESETCTL) += sysreset_resetctl.o
>   obj-$(CONFIG_$(PHASE_)SYSRESET_AT91) += sysreset_at91.o
>   obj-$(CONFIG_$(PHASE_)SYSRESET_X86) += sysreset_x86.o
>   obj-$(CONFIG_SYSRESET_RAA215300) += sysreset_raa215300.o
> +obj-$(CONFIG_SYSRESET_QCOM_PSCI) += sysreset_qcom-psci.o
>   obj-$(CONFIG_SYSRESET_QCOM_PSHOLD) += sysreset_qcom-pshold.o
>   obj-$(CONFIG_TARGET_XTFPGA) += sysreset_xtfpga.o
> diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
> index 536ac727142..ff9bc962ec0 100644
> --- a/drivers/sysreset/sysreset-uclass.c
> +++ b/drivers/sysreset/sysreset-uclass.c
> @@ -125,8 +125,11 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>   	if (argc > 2)
>   		return CMD_RET_USAGE;
>   
> -	if (argc == 2 && argv[1][0] == '-' && argv[1][1] == 'w') {
> -		reset_type = SYSRESET_WARM;
> +	if (argc == 2) {
> +		if (argv[1][0] == '-' && argv[1][1] == 'w')
> +			reset_type = SYSRESET_WARM;
> +		else if (!strncmp("-edl", argv[1], 4))
> +			reset_type = SYSRESET_EDL;
>   	}
>   
>   	printf("resetting ...\n");
> diff --git a/drivers/sysreset/sysreset_qcom-psci.c b/drivers/sysreset/sysreset_qcom-psci.c
> new file mode 100644
> index 00000000000..9d0606c059b
> --- /dev/null
> +++ b/drivers/sysreset/sysreset_qcom-psci.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2017 Masahiro Yamada <yamada.masahiro@socionext.com>
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <dm.h>
> +#include <sysreset.h>
> +#include <asm/system.h>
> +#include <linux/errno.h>
> +#include <linux/psci.h>
> +
> +static int qcom_psci_sysreset_get_status(struct udevice *dev, char *buf, int size)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int qcom_psci_sysreset_request(struct udevice *dev, enum sysreset_t type)
> +{
> +	switch (type) {
> +	case SYSRESET_WARM:
> +	case SYSRESET_COLD:
> +		psci_sys_reset(type);
> +		break;
> +	case SYSRESET_POWER_OFF:
> +		psci_sys_poweroff();
> +		break;
> +	case SYSRESET_EDL:
> +		psci_system_reset2(0, 1);

Can you explicit which platforms do support this new psci_system_reset2() ?

> +		break;
> +	default:
> +		return -EPROTONOSUPPORT;
> +	}
> +
> +	return -EINPROGRESS;
> +}
> +
> +static struct sysreset_ops qcom_psci_sysreset_ops = {
> +	.request = qcom_psci_sysreset_request,
> +	.get_status = qcom_psci_sysreset_get_status,
> +};
> +
> +U_BOOT_DRIVER(qcom_psci_sysreset) = {
> +	.name = "qcom_psci-sysreset",
> +	.id = UCLASS_SYSRESET,
> +	.ops = &qcom_psci_sysreset_ops,
> +	.flags = DM_FLAG_PRE_RELOC,
> +};
> diff --git a/include/sysreset.h b/include/sysreset.h
> index ff20abdeed3..d0f60ed2456 100644
> --- a/include/sysreset.h
> +++ b/include/sysreset.h
> @@ -21,6 +21,13 @@ enum sysreset_t {
>   	SYSRESET_POWER,
>   	/** @SYSRESET_POWER_OFF: turn off power */
>   	SYSRESET_POWER_OFF,
> +#if IS_ENABLED(CONFIG_SYSRESET_QCOM_PSCI)
> +	/**
> +	 * @SYSRESET_EDL: Reset and boot into Emergency DownLoader.
> +	 *		  This is supported only in recent Qcom SoCs.
> +	 */
> +	SYSRESET_EDL,
> +#endif
>   	/** @SYSRESET_COUNT: number of available reset types */
>   	SYSRESET_COUNT,
>   };

