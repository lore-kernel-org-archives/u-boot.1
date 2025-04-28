Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4B0C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 17:12:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D7BA82836;
	Mon, 28 Apr 2025 19:10:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="C6LQUdHs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B03C282A96; Mon, 28 Apr 2025 16:22:52 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32C5482A33
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 16:22:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39bf44be22fso3296177f8f.0
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 07:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745850169; x=1746454969; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uYjVzQv8iDUFE4bdD9BXX0SHAt/Ly69CQvzN5frS1fc=;
 b=C6LQUdHs7BLjRMuBv0t6DPxYWq0Wvt+evSOtxdmZCwNZ2tZvUP0EV7yclm44SB+UiG
 d7c5W7ptRkLTJA0jqGIT91e5YYUeg3Nh19jPoWWloP1EdeBLvz9Zl88TPIA+kH4b0nEg
 rytBCuituzCY1YYViC65Z0iXEvplPwJMKxOsEsE22rs4buArA320HqRNm/vWDffs08pK
 Ozm6t0VNcRL+8HH+Sd2F5/MLv9xYPLDKIDPD9DOyT6DBM8UVkCl4v55Tk7pa4lGcLJiu
 UVcxnBeB8HBiSg92RDDz5zyMsl0FUKrK+gOVKAETTXI+2W2hFF/UiLlUbVLC9bRjF0Mv
 l2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745850169; x=1746454969;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uYjVzQv8iDUFE4bdD9BXX0SHAt/Ly69CQvzN5frS1fc=;
 b=Z6P5rVSS7dPfpgSLpjZj2UlOwM+SjGdm2VHHIOcBpuXmB4dEHVaJj4K7cMLyBaTc/B
 iPErVy3zYVnULk7Z04o0xETPNEU0JZ8A/aVvqzCgE867isC4O835IoXQeeHXhFmH8uA1
 c+F7YDdVtOjs+lylqbVXsvyoATi0L5ZZn13kYc4Ixrhz3HyZ9NUt1QLN/KKZm3HooJfB
 ZBp+x9ZOZuC/6H3BA/bKxFko0tJPRhHmUCBY4NYgQX1VRd2UNA8Xtm8cW629NdbhaLlb
 qR1L0SvXZMNA3w7b3IvXT6wE/wuPzYlQgjziNyRxrujOoCoQyk4wOg2DRvQh54OAqSCp
 eknw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURRgDmFbxZldVpew7tKLs6MBTW5T2slKddNBU4RxikpeGZfhErDKJJ8jBSnPgITxT7spD7J4U=@lists.denx.de
X-Gm-Message-State: AOJu0YyfKJSba7S/KkvQeW+K5cdGxHC2A6wdO/JNsOm4HpF+g6i4VaXE
 rEzLHJrlZX00YC3wI3eJQvlm++ApqWvwSRAih/wfhhNKvnlkAEurbDXqNo992oo=
X-Gm-Gg: ASbGncsffXwCJdmRMxHuMywmbZtdnnMPC2WandmHHBk/pM00tw3fGs5M4kcRe0c0ThQ
 jUs4IR85K4wK1qHZ1AHQgd2bq5aqKh8vlQMsn+amgibobvlLfzP3fNEg9JaU9dy44hajgeDz2cY
 SKl/3t4c5zzV/AxdCXGXei1TYjX9P1/T6d1dWlQkwsiFaW3QMo15MPGN7JCpT3rL8jHsyGAHBXV
 IE+gdYyvbtUgb7MGzOCdH2eI7KL6je1IDTy/yPOQ2MiFNUGgCunfgPDriT64/iUWfsBZVcUJqju
 /9LEBY8HlR1dbzyb/vIYmNQx4YfBXIjH3TVvlqgIGVorhd1ZWauWTOi1ViwksKpY+spipvjiJvk
 PDYP4WA==
X-Google-Smtp-Source: AGHT+IFgvKYDMlufz7jXedSVdCW2P8LhQOneaZI/g0xM00Ga1NwwXENe5UIdXMsENL1T/WUvyJ9XVA==
X-Received: by 2002:a05:6000:4205:b0:3a0:7d64:502 with SMTP id
 ffacd0b85a97d-3a07d640504mr5783169f8f.11.1745850169528; 
 Mon, 28 Apr 2025 07:22:49 -0700 (PDT)
Received: from [192.168.1.47] (i5E863A78.versanet.de. [94.134.58.120])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca4e50sm11587472f8f.30.2025.04.28.07.22.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 07:22:48 -0700 (PDT)
Message-ID: <1e0e9a72-40a8-4ce3-a390-edef1d6a03d8@linaro.org>
Date: Mon, 28 Apr 2025 16:22:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] sysreset: Implement PSCI based reset to EDL mode
 for QCOM SoCs
To: Varadarajan Narayanan <quic_varada@quicinc.com>, trini@konsulko.com,
 caleb.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 sjg@chromium.org, ilias.apalodimas@linaro.org, sughosh.ganu@linaro.org,
 me@samcday.com, marex@denx.de, robert.marko@sartura.hr,
 seashell11234455@gmail.com, ycliang@andestech.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20250410120208.4142087-1-quic_varada@quicinc.com>
 <20250410120208.4142087-3-quic_varada@quicinc.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250410120208.4142087-3-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 28 Apr 2025 19:10:31 +0200
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



On 4/10/25 14:02, Varadarajan Narayanan wrote:
> Add SYSRESET_EDL to sysreset_t and handle the different SYSRESET_xxx
> requests in sysreset_qcom-psci.c.

To be honest, I'm not really excited about this. Copying the entire PSCI 
reset code and polluting the global sysreset reason enum with entirely 
platform specific symbols is not good practise.

Additionally, while this specific EDL implementation works on your 
platform, it does not work on (for example) sdm845 and sm8250 which are 
platforms we still very much care about. I'm also not sure if it works 
on SC7280.

I think this should be handled in an/the SCM driver like it is in Linux, 
not sure if Sam is working on that or if I can send a barebones version 
of the one I have in my tree. It will need to be based on the compatible 
string for the scm node in DT (and checking for the qcom,dload-mode 
property too I think).

As I proposed before on IRC, I think it makes sense to pass the "reset" 
arguments into sysreset and allow the sysreset driver to implement a 
callback/handler for them, this way the "edl" argument makes it all the 
way to our platform-specific driver which can then call 
"psci_system_reset2()"

I would implement this by adding a new op to sysreset_ops, something 
like .request_args, then have a second for loop which calls this, since 
we want any reset handler which /can/ parse the args to do so before we 
call the normal .request callback (otherwise some other handler might do 
a normal reset before we have parsed the arguments).

For now I'm fine with this new sysreset-qcom.c driver being specific to 
qcs9100, but please include a comment that the psci reset2 call is only 
supported on some newer qualcomm platforms and that others can be 
supported via SCM.

On that note, how does this new driver actually get bound? It doesn't 
have any compatible strings associated? Or am I missing something 
here... Please explain this.

Otherwise, I'm looking forward to v2.

Kind regards,

> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>   drivers/sysreset/Kconfig              |  5 +++
>   drivers/sysreset/Makefile             |  1 +
>   drivers/sysreset/sysreset-uclass.c    |  7 ++--
>   drivers/sysreset/sysreset_qcom-psci.c | 47 +++++++++++++++++++++++++++
>   include/sysreset.h                    |  2 ++
>   5 files changed, 60 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/sysreset/sysreset_qcom-psci.c
> 
> diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
> index 121194e4418..a6a1e57b603 100644
> --- a/drivers/sysreset/Kconfig
> +++ b/drivers/sysreset/Kconfig
> @@ -240,6 +240,11 @@ config SYSRESET_RAA215300
>   	help
>   	  Add support for the system reboot via the Renesas RAA215300 PMIC.
>   
> +config SYSRESET_QCOM_PSCI
> +	bool "Support sysreset for Qualcomm SoCs via PSCI"
> +	help
> +	  Add support for the system reboot on Qualcomm SoCs via PSCI.
> +
>   config SYSRESET_QCOM_PSHOLD
>   	bool "Support sysreset for Qualcomm SoCs via PSHOLD"
>   	depends on ARCH_IPQ40XX
> diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
> index 796fc9effa5..12dbad5254a 100644
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
> index 536ac727142..d06c0a6908a 100644
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
> +		else if (!strncmp("edl", argv[1], 3))
> +			reset_type = SYSRESET_EDL;
>   	}
>   
>   	printf("resetting ...\n");
> diff --git a/drivers/sysreset/sysreset_qcom-psci.c b/drivers/sysreset/sysreset_qcom-psci.c
> new file mode 100644
> index 00000000000..3afb79e2d2e
> --- /dev/null
> +++ b/drivers/sysreset/sysreset_qcom-psci.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2017 Masahiro Yamada <yamada.masahiro@socionext.com>
> + */
> +
> +#include <dm.h>
> +#include <sysreset.h>
> +#include <asm/system.h>
> +#include <linux/errno.h>
> +#include <linux/psci.h>
> +
> +__weak int qcom_psci_sysreset_get_status(struct udevice *dev, char *buf, int size)
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
> index ff20abdeed3..8bda9703cd9 100644
> --- a/include/sysreset.h
> +++ b/include/sysreset.h
> @@ -21,6 +21,8 @@ enum sysreset_t {
>   	SYSRESET_POWER,
>   	/** @SYSRESET_POWER_OFF: turn off power */
>   	SYSRESET_POWER_OFF,
> +	/** @SYSRESET_EDL: reset and boot into Emergency DownLoader */
> +	SYSRESET_EDL,
>   	/** @SYSRESET_COUNT: number of available reset types */
>   	SYSRESET_COUNT,
>   };
-- 
Casey (she/they)

