Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E44E7716A
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 08:29:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC016801CE;
	Tue, 17 Dec 2024 09:29:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZylqI1Gs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 977A5801CF; Tue, 17 Dec 2024 09:29:41 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ED5C801A0
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 09:29:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a9f1d76dab1so1019473166b.0
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 00:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734424178; x=1735028978; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kFlUdtFdhA9knSorH7igU94yJ7N0/iVuvLHvNnD096g=;
 b=ZylqI1Gs2jBcFDPC8R2YYTQ3YZWtvrjHosCKsfTLAKkJHVZNBPTREs9Z4OIvcfZ9i4
 hxeARn9RNUfL9h0EYtq2wVtzZ2HCQA9wCUynEmg9aTb/kHdfrqSpy6G6otRrIDRhY4h4
 BLSfmPiCtJR8EQUSCAHeGqDmHdms5SpNKMg+KWus2yWzqqy/gOPPbRItg9oQjkXeJdXN
 ahM0+kwldaabYeWNnn1tYLUuCU8ChYs7tbxKxTHMRdEJkvpx3J/AhwfQ0qN7kpGp1OE2
 FtaLurh8qQbmA8hWpthaxgItz0Q582BVMfr8/xhLydUBAwPymcvlkvmmMXj60u3jCyKM
 J4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734424178; x=1735028978;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kFlUdtFdhA9knSorH7igU94yJ7N0/iVuvLHvNnD096g=;
 b=RxLnjqyg9iDsOlP3MKbu19OSxj02hCpqhMMIXcvXqDOWhHl+ZkFMNsvmVbdjbrd6Rp
 Bn+VDZkWrOSKPX9J9T6WkJI35JJrUcTg973x+06OhgeamLfrmmtWIhxY0ZeRZ2fMK9GH
 +WK/2dPc/yYIdnZvjx4owpm7SK5Z5dpiYZBPPhw5JkJo8hq8XZGtCSZt2Iy8/GEV5s83
 qJXz/yILDTQ+N4bPPy4n+wxmxcEdNwdMT4d4/n4xdUmutukwXesf8s8lSVZ/rdHNUDHC
 qhaPH1xVGtTob7pHGcLlfKEYMWvGg08ERafqzLe5CrwZ5bEmYqpqvv10F0wAgA8URNBf
 6/Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAMIW0+11o/C9i+GP1dyVAjAzfjl60HyHpOR6RHog/ICOMcDK92ldJ7GRPOFiIaCsRamsD50Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+S9mFol9RfwfRIJGtvo1x1y8X/kcj6m2MR24j+zAQrj/zV7II
 R6DDM0MXCc2Obz2k+9neRpwiF+FlFZPtHiTek8xnwtTtR6YIjXXpLEkyj49sT1I=
X-Gm-Gg: ASbGnctorYpuQyfSfrhKc8VpqzJV7H1R5+iNwfT+7rXUmAol806LcwEatAHAJHGHAfc
 6axHNrBLVJACoXhG7GEtSXdgpY8d1CEXYAN9o0LjOM7Vtt9X2W09/SooR7fTE1aPz7RnP8NChyZ
 d0K1gEg2GjWUUR5H5WzknGhjID066tJxACMdSzkrH7FST7ctUzE0Lp4z958FwUjgcLLfTrsmUNE
 +ovoaJtmhf8M6t5lx5bEFf7dYROTSjuaBkpv6EgalTT+lej+RsWYlKCfDK3+JBjP1kA
X-Google-Smtp-Source: AGHT+IF7jZP+unNEPEO7FD4hrrDGQUcyDYDiphdLKk4XoK28iy6DlZvn2bwX1+2c7H5Uk2gL6Mf1MA==
X-Received: by 2002:a17:907:7753:b0:aa6:707a:af59 with SMTP id
 a640c23a62f3a-aabdb8ddc26mr205337366b.50.1734424178392; 
 Tue, 17 Dec 2024 00:29:38 -0800 (PST)
Received: from [10.100.0.2] ([194.15.111.158])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab963cecd1sm417226366b.198.2024.12.17.00.29.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 00:29:38 -0800 (PST)
Message-ID: <7f5b4f46-1ca6-4207-88d1-40a8e22c56e2@linaro.org>
Date: Tue, 17 Dec 2024 09:29:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] cmd: Add support for optee commands
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, trini@konsulko.com, sjg@chromium.org,
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
 mkorpershoek@baylibre.com, akashi.tkhro@gmail.com,
 francis.laniel@amarulasolutions.com, ddrokosov@salutedevices.com, git@amd.com
References: <20241217035914.1297469-1-venkatesh.abbarapu@amd.com>
 <20241217035914.1297469-2-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241217035914.1297469-2-venkatesh.abbarapu@amd.com>
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

Hi Venkatesh,

On 12/17/24 04:59, Venkatesh Yadav Abbarapu wrote:
> Add the basic 'hello world ta' command which increment
> of the value passed. This provides easy test for
> establishing a session with OP-TEE TA and verify.
> 
> It includes following "hello world ta" subcommands:
> optee hello; default value '0' is passed and gets incremented.
> optee hello <value>; value to increment via OP-TEE HELLO
> WORLD TA.
> 
> To enable the OP-TEE side HELLO WORLD example please refer
> https://optee.readthedocs.io/en/latest/building/gits/optee_examples/optee_examples.html
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>  cmd/Kconfig  |  6 ++++
>  cmd/Makefile |  1 +
>  cmd/optee.c  | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 84 insertions(+)
>  create mode 100644 cmd/optee.c
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 1d7ddb4ed36..4b33468891e 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1446,6 +1446,12 @@ config CMD_OPTEE_RPMB
>  	  in the Replay Protection Memory Block partition in eMMC by
>  	  using Persistent Objects in OPTEE
>  
> +config CMD_OPTEE
> +	bool "Enable OP-TEE commands"
> +	depends on OPTEE
> +	help
> +	 OP-TEE commands support.
> +
>  config CMD_MTD
>  	bool "mtd"
>  	depends on MTD
> diff --git a/cmd/Makefile b/cmd/Makefile
> index d1f369deec0..533d0f6a1be 100644
> --- a/cmd/Makefile
> +++ b/cmd/Makefile
> @@ -118,6 +118,7 @@ obj-$(CONFIG_CMD_PAUSE) += pause.o
>  obj-$(CONFIG_CMD_SLEEP) += sleep.o
>  obj-$(CONFIG_CMD_MMC) += mmc.o
>  obj-$(CONFIG_CMD_OPTEE_RPMB) += optee_rpmb.o
> +obj-$(CONFIG_CMD_OPTEE) += optee.o
>  obj-$(CONFIG_CMD_MP) += mp.o
>  obj-$(CONFIG_CMD_MTD) += mtd.o
>  obj-$(CONFIG_CMD_MTDPARTS) += mtdparts.o
> diff --git a/cmd/optee.c b/cmd/optee.c
> new file mode 100644
> index 00000000000..39947c00145
> --- /dev/null
> +++ b/cmd/optee.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * (C) Copyright 2024, Advanced Micro Devices, Inc.
> + */
> +#include <command.h>
> +#include <errno.h>
> +#include <tee.h>
> +#include <vsprintf.h>
> +
> +#define TA_HELLO_WORLD_CMD_INC_VALUE 0
> +/* This needs to match the UUID of the Hello World TA. */
> +#define TA_HELLO_WORLD_UUID \
> +	{ 0x8aaaf200, 0x2450, 0x11e4, \
> +	{ 0xab, 0xe2, 0x00, 0x02, 0xa5, 0xd5, 0xc5, 0x1b} }
> +
> +static int hello_world_ta(unsigned int value)
> +{
> +	const struct tee_optee_ta_uuid uuid = TA_HELLO_WORLD_UUID;
> +	struct tee_open_session_arg session_arg;
> +	struct udevice *tee = NULL;
> +	struct tee_invoke_arg arg;
> +	struct tee_param param[2];
> +	int rc;
> +
> +	printf("The Hello World TA is going to be called\n");

I would remove this, and replace with "Calling TA" -- see below.

> +
> +	tee = tee_find_device(tee, NULL, NULL, NULL);
> +	if (!tee)
> +		return -ENODEV;
> +
> +	memset(&session_arg, 0, sizeof(session_arg));
> +	tee_optee_ta_uuid_to_octets(session_arg.uuid, &uuid);
> +	rc = tee_open_session(tee, &session_arg, 0, NULL);
> +	if (rc) {
> +		printf("tee_open_session(): failed(%d)\n", rc);
> +		return rc;
> +	}
> +
> +	arg.func = TA_HELLO_WORLD_CMD_INC_VALUE;
> +	arg.session = session_arg.session;
> +
> +	param[0].attr = TEE_PARAM_ATTR_TYPE_VALUE_INOUT;
> +	param[0].u.value.a = value;
> +
> +	tee_invoke_func(tee, &arg, 1, param);
> +
> +	printf("value: 0x%x TA value: 0x%x\n", value, (int)param[0].u.value.a);

I find "value" and "TA value" unclear. How about:

printf("Value before: 0x%x\n", (int)param[0].u.value.a);
printf("Calling TA\n");
tee_invoke_func(tee, &arg, 1, param);
printf("Value after: 0x%x\n", (int)param[0].u.value.a);

?

> +
> +	return tee_close_session(tee, session_arg.session);
> +}
> +
> +static int do_optee_hello_world_ta(struct cmd_tbl *cmdtp, int flag, int argc,
> +				   char * const argv[])
> +{
> +	int ret, value = 0;
> +
> +	if (strcmp(argv[1], NULL))
> +		value = hextoul(argv[1], NULL);
> +
> +	ret = hello_world_ta(value);
> +	if (ret)
> +		return CMD_RET_FAILURE;
> +
> +	return CMD_RET_SUCCESS;
> +}
> +
> +U_BOOT_LONGHELP(optee,
> +		"- commands can be verified on OP-TEE\n\n"
> +		"optee hello\n"
> +		"optee hello <value>\n"
> +		"\n"
> +		"With:\n"
> +		"\t<value>: integer value\n"
> +		);
> +
> +U_BOOT_CMD_WITH_SUBCMDS(optee, "OP-TEE commands", optee_help_text,
> +			U_BOOT_SUBCMD_MKENT(hello, 2, 1, do_optee_hello_world_ta));

Thanks,
-- 
Jerome
