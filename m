Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00711C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 15:01:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82AD482D21;
	Fri,  2 May 2025 17:01:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J63grXOm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAF9F801BE; Fri,  2 May 2025 14:32:57 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE2E681FDE
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 14:32:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so11882815e9.1
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 05:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746189175; x=1746793975; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qYQpkIA8LFOW9i8viV7LWDHUyvPUMmeAc509xHzuKSM=;
 b=J63grXOmd2++I5MM/pzY6zpsR5Cl4dkeQwDcCuHQPfkAqrf6bnp8in/QsIrkYPEzyh
 bJeaIZRg0gr9Op6sptJhU7WuvOkRa8EGPHPcXx1efEQMLwmhN2rLUobnqvf64ZZ/BcYW
 TnQS+4gReDQz2x5IyhGsmEkLvTS/KJK0X8vZ/y7rKFkJS53ZbVh+XqPVaFkJbegvdD5f
 x5UtzlA07O7vjkiBORaqiOl8RDI2M6ggMqyrS7fiiBzk6wBmSCKAekk1F8eeLY0B6wUO
 fEWuptYyPEocTmek4bLlllHzsX+5y7NmXzwOu9AzFKJRTfuJFMugeRttkkp+UpvlCgEF
 nx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746189175; x=1746793975;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qYQpkIA8LFOW9i8viV7LWDHUyvPUMmeAc509xHzuKSM=;
 b=TlYE/guO/zkVFt+47B68bsiFzwTurD4rL5qFeT4hW31aO7u3jhahNpZsit9gwzTdXl
 KaCJlmWEnxjGo9gxthx2khhmKuNTo7CM+RXW43HHnv0vYs8Nmf/7z/wemyaI5OccoT7T
 U8VMEdP9CLjtfx1QabiBVv4IWNOVUDcaxd5WyAGLNZmWgsze46ueFbOr94GzEiFXoxqW
 L5LTEkflnl9Fyf3GfPSrkX9syue3yE4XbB+v+QwihWDUGUoFuLPgbgvRoUir9dLKlX68
 qV4iNftfZeICANoVdtJ6maKg9Cz4tmrlTGIymnWW1hRZuqt7l7sJLyqVEy/fhzpic+ZR
 5BhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5UAvoj3lztG0yir7CL11xmbBygddmh0PLPxJsk53ChhzkrHzjlm71UbM8Esu8enqYSV1MXQI=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4neGZ4NFUSkX42vOB2o5u0goalIw157tZHxVcGnZqkn1bkZC0
 9o113bmhRx5NWU04kuiDR5Q7qsD3yxb3ECYireDiDV41qwSsQGKIspc9okvj3dI=
X-Gm-Gg: ASbGncujXW46W1F3B4IapNGvq6bHwAtPG/I+u5YPqSvlanTZ6brQpw1jMLDp4C1gR0i
 ahDrnemxJETrkCsXTKcgQ2HwOrh9UpcD6ttbgJVQCOG50iO3MPBixksezTzPam3yasBhPr1o/vV
 B/W3Aj+Kf6W+0PlZXg/NziO0BWgpbVIQdvA1HNNcaUNW7o8EDxRMw831BO5ThhJPuyMEhVadjFr
 HuN92CyGxPuEqaSb5ZXn07TNresplrQor7JvImwvLx+CaobUdNN61JHE7TrgLo+w/TMxu+u2iTX
 gIjpOjrMODvTZ2pgG28EMKnP092d+TjedRALQrkxYWFI7gFLGy57zg8KIo5naIZHYSSII+o=
X-Google-Smtp-Source: AGHT+IHtU3g9L6lEPCk6iD/G4OXvsOqEVZZfwiFO3in4zet7ddXw8hwLOI2shh3bJc8zp8/jY5gv2Q==
X-Received: by 2002:a05:600c:cca:b0:43d:36c:f24 with SMTP id
 5b1f17b1804b1-441bbec2335mr24956385e9.13.1746189175104; 
 Fri, 02 May 2025 05:32:55 -0700 (PDT)
Received: from [192.168.1.47] (i5E863B79.versanet.de. [94.134.59.121])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89ed4f5sm43843075e9.18.2025.05.02.05.32.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 05:32:54 -0700 (PDT)
Message-ID: <9e06d089-3fd9-4161-988b-14273a2aba0e@linaro.org>
Date: Fri, 2 May 2025 14:32:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] sysreset: Implement PSCI based reset to EDL mode
 for QCOM SoCs
To: Varadarajan Narayanan <quic_varada@quicinc.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org, seashell11234455@gmail.com, clamor95@gmail.com,
 ycliang@andestech.com, me@samcday.com, robert.marko@sartura.hr,
 sjg@chromium.org, marek.vasut+renesas@mailbox.org, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20250430085428.1090801-1-quic_varada@quicinc.com>
 <20250430085428.1090801-2-quic_varada@quicinc.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250430085428.1090801-2-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 02 May 2025 17:01:15 +0200
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

Hi Varadarajan,

You have almost entirely ignored my feedback on the previous revision.

If there's some technical disagreement or you don't understand my 
feedback then please let me know (in private if you prefer).

This approach is fundamentally wrong, full of layering violations and 
totally unsustainable (imagine if every vendor started polluting core 
code with their custom stuff).

These abstractions need to be improved to add this feature properly and 
there's no getting around it.

Kind regards,
Casey (she/they)

On 4/30/25 10:54, Varadarajan Narayanan wrote:
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

-- 
Casey (she/they)

