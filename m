Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF9DC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 13:59:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A098D88119;
	Tue, 23 Apr 2024 15:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M6M98+l9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90DD78811A; Tue, 23 Apr 2024 15:59:21 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7982588080
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 15:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-51ab4ee9df8so5756168e87.1
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 06:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713880759; x=1714485559; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4laetiLlUER27b8EkDpD17JqR9QSpN1mz47VPp/yWEY=;
 b=M6M98+l9ABnhfAvg+wte6csmw32+IVCXaT8zd7yMxvmQmgjKZs0mYbSAFQP/X3AKBd
 SB1lWGDvTAhs/4G4N2Fcx1811a7+MSwUalIqfcRX4ieU0KBOTD1HpYuZpV4MLkf5Z3u+
 uuRgXxXqU0Ay0jzcVYiMOqojyqRP9kc2cbm4UtOelqLaJn7K7WbOBbKYxSrMHbnrnAtO
 zqQpNU3CSA5MBPkUxf7+08XtwB047wZi5ZOfFtOU37eaJaV5Eqqx1IkNoamYlpT6GhJR
 JC+556Q9AEZjf6TC+NopTZBXCFnYfoCsdzmF+hXZI9aNA7wGRc0sZDvCgZwIK6Rn0Cjd
 066w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713880759; x=1714485559;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4laetiLlUER27b8EkDpD17JqR9QSpN1mz47VPp/yWEY=;
 b=PxjEiyw2StyZvbCinAZl1S4Udtb/dTNGWZiDvmTp0t3cv586kaN+7ZggRQUlV7xi3q
 PfEGj3P6Y+5cjnArryyVF2a/DxpoqyPIvBK+baU/thk3CWuRdKoHRipqZP1k9AGVBMAT
 SZ0n6X5YMkHUetExkpG2h/AfbGvtK0ZsZU2HEBQ4C9F7uEh+C39ON1J2Z0MYfvhYY3gQ
 pWVKv8xnTuJdl0TZ56v0pixSWq9WHzhnNKfuhWBlYlYBgTJyk/iH/RQz0bbi1WVYvyR4
 Iq9kor5gUGTX9uJNCNUSZTj+591vU9XenBTlFWvhKeq757vyBzocl/Hr4+Z9u6Ngu6nc
 r5uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTgjQPI30EbSbfO2Db8jCN17cQQi6bCUXxKjKst4oeDN+uvfN6gXQwIbm+zzEkMCPUHiBaWzCDfiUGGIxmBZf2CVhqVA==
X-Gm-Message-State: AOJu0Yw1hlrZT8mupduEaubs0BUAAQEwu30WOD5ado32CWyStqIMcMok
 RcaGorQu24vKfIwsu+AqMC6+Q01B8Gn/kSzgGopOPyozbN939cU5vc7m57Hki7s=
X-Google-Smtp-Source: AGHT+IH4biHM7UBzFUC0eWiMw+Ucrq8G7WwJJfuIn//DQGtveHYe2dtJREDciTwzgDJBJX/YfLOkLA==
X-Received: by 2002:ac2:5046:0:b0:51b:5c40:da74 with SMTP id
 a6-20020ac25046000000b0051b5c40da74mr3532743lfm.1.1713880758679; 
 Tue, 23 Apr 2024 06:59:18 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::1795? ([2a02:8109:aa0d:be00::1795])
 by smtp.gmail.com with ESMTPSA id
 v19-20020a170906339300b00a5592a12fe2sm4838227eja.128.2024.04.23.06.59.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 06:59:17 -0700 (PDT)
Message-ID: <2d4ac770-414a-45b2-b4f4-4024fd2976d8@linaro.org>
Date: Tue, 23 Apr 2024 15:59:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sysreset: add Qualcomm PSHOLD reset driver
To: Robert Marko <robert.marko@sartura.hr>, trini@konsulko.com,
 u-boot@lists.denx.de, neil.armstrong@linaro.org, sumit.garg@linaro.org
Cc: j.beck@linefinity.com
References: <20240423113437.84339-1-robert.marko@sartura.hr>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240423113437.84339-1-robert.marko@sartura.hr>
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

Hi Robert,

On 23/04/2024 13:33, Robert Marko wrote:
> Number of Qualcomm ARMv7 SoC-s did not use PSCI but rather used PSHOLD
> (Qualcomm Power Supply Hold Reset) bit to trigger reset or poweroff.
> 
> Qualcomm IPQ40XX is one of them, so provide a simple sysreset driver based
> on the upstream Linux one, it is DT compatible as well.

Thanks for the patch.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>   drivers/sysreset/Kconfig               |  6 +++
>   drivers/sysreset/Makefile              |  1 +
>   drivers/sysreset/sysreset_msm-pshold.c | 56 ++++++++++++++++++++++++++
>   3 files changed, 63 insertions(+)
>   create mode 100644 drivers/sysreset/sysreset_msm-pshold.c
> 
> diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
> index 49c0787b26..30ff9e576d 100644
> --- a/drivers/sysreset/Kconfig
> +++ b/drivers/sysreset/Kconfig
> @@ -235,6 +235,12 @@ config SYSRESET_RAA215300
>   	help
>   	  Add support for the system reboot via the Renesas RAA215300 PMIC.
>   
> +config SYSRESET_MSM_PSHOLD

For the sake of consistency, please use QCOM instead of MSM (ditto for 
the driver).

With that,

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> +	bool "Support sysreset for Qualcomm SoCs via PSHOLD"
> +	depends on ARCH_IPQ40XX
> +	help
> +	  Add support for the system reboot on Qualcomm SoCs via PSHOLD.
> +
>   endif
>   
>   endmenu
> diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
> index e0e732205d..da61dca8e2 100644
> --- a/drivers/sysreset/Makefile
> +++ b/drivers/sysreset/Makefile
> @@ -28,4 +28,5 @@ obj-$(CONFIG_SYSRESET_RESETCTL) += sysreset_resetctl.o
>   obj-$(CONFIG_$(SPL_TPL_)SYSRESET_AT91) += sysreset_at91.o
>   obj-$(CONFIG_$(SPL_TPL_)SYSRESET_X86) += sysreset_x86.o
>   obj-$(CONFIG_SYSRESET_RAA215300) += sysreset_raa215300.o
> +obj-$(CONFIG_SYSRESET_MSM_PSHOLD) += sysreset_msm-pshold.o
>   obj-$(CONFIG_TARGET_XTFPGA) += sysreset_xtfpga.o
> diff --git a/drivers/sysreset/sysreset_msm-pshold.c b/drivers/sysreset/sysreset_msm-pshold.c
> new file mode 100644
> index 0000000000..d25a412954
> --- /dev/null
> +++ b/drivers/sysreset/sysreset_msm-pshold.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Qualcomm PSHOLD reset driver
> + *
> + * Copyright (c) 2024 Sartura Ltd.
> + *
> + * Author: Robert Marko <robert.marko@sartura.hr>
> + * Based on the Linux msm-poweroff driver.
> + *
> + */
> +
> +#include <common.h>
> +#include <dm.h>
> +#include <sysreset.h>
> +#include <asm/io.h>
> +#include <linux/delay.h>
> +
> +struct msm_pshold_priv {
> +	phys_addr_t base;
> +};
> +
> +static int msm_pshold_request(struct udevice *dev, enum sysreset_t type)
> +{
> +	struct msm_pshold_priv *priv = dev_get_priv(dev);
> +
> +	writel(0, priv->base);
> +	mdelay(10000);
> +
> +	return 0;
> +}
> +
> +static struct sysreset_ops msm_pshold_ops = {
> +	.request = msm_pshold_request,
> +};
> +
> +static int msm_pshold_probe(struct udevice *dev)
> +{
> +	struct msm_pshold_priv *priv = dev_get_priv(dev);
> +
> +	priv->base = dev_read_addr(dev);
> +	return priv->base == FDT_ADDR_T_NONE ? -EINVAL : 0;
> +}
> +
> +static const struct udevice_id msm_pshold_ids[] = {
> +	{ .compatible = "qcom,pshold", },
> +	{ /* sentinel */ }
> +};
> +
> +U_BOOT_DRIVER(msm_pshold) = {
> +	.name 		= "msm_pshold",
> +	.id 		= UCLASS_SYSRESET,
> +	.of_match 	= msm_pshold_ids,
> +	.probe 		= msm_pshold_probe,
> +	.priv_auto	= sizeof(struct msm_pshold_priv),
> +	.ops 		= &msm_pshold_ops,
> +};

-- 
// Caleb (they/them)
