Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D24E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 08:25:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A590480141;
	Fri, 13 Dec 2024 09:25:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WGSyIlfQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76E008018E; Fri, 13 Dec 2024 09:25:16 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE89B8012C
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 09:25:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aa5f1909d6fso265850866b.3
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 00:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734078313; x=1734683113; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nUCwGRIcduk6KjpeUiUoahBAAa0ZttArhOnRhNV+SJA=;
 b=WGSyIlfQyefZfDJ/KQ3S9NGt23vC1VYUAw0OP8sy5Ozuy6sweBBOBRlqXsj5JRPFmp
 qr6izS+JMnn9QSL/3apw01iWFJhMqUiyGJ0/jd+kM+Lo3ywE5PKcAxqTENrdcbu5BQ+e
 4AuZ88x3d/L7iy0OyTWShv6i5029BAJ0XyJps6D9Ba6XtBmEd34AF0EDRyUYxUNv5yeU
 0KzZf2S5sMJt7is8TGH7wt/hsx91juBZg1/IPINBsoHNMHwLZ30Kyv/sA3Y4frWpwzpl
 zvQ6UlsEqA8fDGo57RAdSrLHV22sg0CspsZJ1jOfNh4ewnKDnjksTlYKQMw8aCrrolLY
 uSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734078313; x=1734683113;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nUCwGRIcduk6KjpeUiUoahBAAa0ZttArhOnRhNV+SJA=;
 b=noDyKjYpgQp1ezcxVqczanNljUbcPJSPfEmrj1BCTT/ZkOzu2xUDR0pHW2E57BZxAS
 5Em0dImA3O8zo+RDbYAmk7p4rpfHu9CwbdYKUU6f+svs70llSpvZUauV48o3XQWrV9ae
 CUvlNxbg/h0M6py/Hj3KsjJuwooyi45bJlKwcAD+cVszddM7PYQ9hBPLNV9Q+fDlkOTm
 nH6XRuAd+ylo7xwCou9Sxt3I4Ai/bVdx0MOJGyF1Iw+MK8gysJ4pklVqcMq5g/NdWlJw
 DXJHLAI5SimKNx7DokLygtjm9pvXH63LI1NfJyzNeLmp4BUoE5pfX7Au+bzGrO57dAsL
 sSaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+SfPUM8eF/vUNqliq/vJqneh2RZnvGD/d2uvThmos/TMYyiBOhYi5xEdHP2hpVOq7geq50ws=@lists.denx.de
X-Gm-Message-State: AOJu0YwMOW7AV8ZX7RGCqUKpcRanB0V1gjhJ0/1s5pogum0r2Ywk6ql4
 0hecrxUlWhMC+EwGjTYhl+WyPZZMHXxembDuGcG3tIVSrrYVUccHx4N82sIBhcqj5Bi8uJ2qfQS
 22yo=
X-Gm-Gg: ASbGnctx+GBGdM4UXd5jpcOiy44fHPL5dX0nNfuW9hxbWe23yoBaxwnXKkH0IZ3yq1v
 EiqXtKtL5n9vwN0Y1h4tPS1e7KcxFFPCjvllXIK8hcj1kIhOQO8Fe2aZT8WpvR1RDa+lPILtue4
 /65OXginrO4hlXvzfhb8+uPOJIN4pps+xfXUlQvK28KZL1kCq7Lk0SD8kfXJylO1H8P/v+RZMBi
 Z5A3TPv9BJrcIQuiF8igha84VGSLTqBopr70/5S2kd6y+6gkb0FPFqS9xOuQXDAlQi4AYOTTb8A
 caw7F73Mu9ntyqeDnlCgSdk6jrnBe0YRTt0+
X-Google-Smtp-Source: AGHT+IH9QrquE4Uaa2mJ2vhrCNaQzB3EFeurMSjvJk3WEKCiHSQRnt9pz+/tovyAxrJ4cVpkW1+Zaw==
X-Received: by 2002:a17:907:1c08:b0:aa5:225f:47d9 with SMTP id
 a640c23a62f3a-aab779ceb5cmr179651166b.29.1734078313092; 
 Fri, 13 Dec 2024 00:25:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:2c5c:e3d1:41b5:d71c?
 ([2a01:e0a:3cb:7bb0:2c5c:e3d1:41b5:d71c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa6696acc74sm856443466b.134.2024.12.13.00.25.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 00:25:12 -0800 (PST)
Message-ID: <f769ebbb-8f86-4105-a34d-97915e584927@linaro.org>
Date: Fri, 13 Dec 2024 09:25:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: Add support for optee hello world ta command
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, trini@konsulko.com, sjg@chromium.org,
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
 mkorpershoek@baylibre.com, akashi.tkhro@gmail.com,
 francis.laniel@amarulasolutions.com, ddrokosov@salutedevices.com, git@amd.com
References: <20241213070149.1089009-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241213070149.1089009-1-venkatesh.abbarapu@amd.com>
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



On 12/13/24 08:01, Venkatesh Yadav Abbarapu wrote:
> Enable "hello_world_ta" command which increments the value passed.
> This provides easy test for establishing a session with OPTEE

Spelling: OP-TEE

> TA and verify.
> 
> It includes following subcommands:
> hello_world_ta write_value value: value to increment via OPTEE HELLO
> WORLD TA.

How about calling the command 'optee' and the subcommand 'hello', with
the integer argument being optional? This would make for an easier
syntax and possible evolutions ('optee version' etc.)

=> optee hello
=> optee hello 42

> To enable the OPTEE side HELLO WORLD example please refer
> https://optee.readthedocs.io/en/latest/building/gits/optee_examples/optee_examples.html
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>  cmd/Kconfig                |  8 ++++
>  cmd/Makefile               |  1 +
>  cmd/optee_hello_world_ta.c | 98 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 107 insertions(+)
>  create mode 100644 cmd/optee_hello_world_ta.c
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 1d7ddb4ed36..f1f8d1b9571 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1446,6 +1446,14 @@ config CMD_OPTEE_RPMB
>  	  in the Replay Protection Memory Block partition in eMMC by
>  	  using Persistent Objects in OPTEE
>  
> +config CMD_OPTEE_HELLO_WORLD
> +	bool "Enable Hello world TA"
> +	depends on OPTEE
> +	default y
> +	help
> +	 Enable the hello world ta command to test the OPTEE by passing
> +	 a "value" which should increment by OPTEE TA example.
> +
>  config CMD_MTD
>  	bool "mtd"
>  	depends on MTD
> diff --git a/cmd/Makefile b/cmd/Makefile
> index d1f369deec0..049147a1442 100644
> --- a/cmd/Makefile
> +++ b/cmd/Makefile
> @@ -118,6 +118,7 @@ obj-$(CONFIG_CMD_PAUSE) += pause.o
>  obj-$(CONFIG_CMD_SLEEP) += sleep.o
>  obj-$(CONFIG_CMD_MMC) += mmc.o
>  obj-$(CONFIG_CMD_OPTEE_RPMB) += optee_rpmb.o
> +obj-$(CONFIG_CMD_OPTEE_HELLO_WORLD) += optee_hello_world_ta.o
>  obj-$(CONFIG_CMD_MP) += mp.o
>  obj-$(CONFIG_CMD_MTD) += mtd.o
>  obj-$(CONFIG_CMD_MTDPARTS) += mtdparts.o
> diff --git a/cmd/optee_hello_world_ta.c b/cmd/optee_hello_world_ta.c
> new file mode 100644
> index 00000000000..54342b90812
> --- /dev/null
> +++ b/cmd/optee_hello_world_ta.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * (C) Copyright 2024, Advanced Micro Devices, Inc.
> + */
> +#include <command.h>
> +#include <errno.h>
> +#include <tee.h>
> +#include <vsprintf.h>
> +
> +static struct udevice *tee;
> +static u32 session;
> +
> +#define TA_HELLO_WORLD_CMD_INC_VALUE 0
> +/* This needs to match the UUID of the Hello World TA. */
> +#define TA_HELLO_WORLD_UUID \
> +	{ 0x8aaaf200, 0x2450, 0x11e4, \
> +	{ 0xab, 0xe2, 0x00, 0x02, 0xa5, 0xd5, 0xc5, 0x1b} }
> +
> +static int hello_world_ta_open_session(void)
> +{
> +	const struct tee_optee_ta_uuid uuid = TA_HELLO_WORLD_UUID;
> +	struct tee_open_session_arg arg;
> +	int rc;
> +
> +	tee = tee_find_device(tee, NULL, NULL, NULL);
> +	if (!tee)
> +		return -ENODEV;
> +
> +	memset(&arg, 0, sizeof(arg));
> +	tee_optee_ta_uuid_to_octets(arg.uuid, &uuid);
> +	rc = tee_open_session(tee, &arg, 0, NULL);
> +	if (!rc)
> +		session = arg.session;
> +
> +	return 0;

Should return an error if rc != 0

> +}
> +
> +static int hello_world_ta(unsigned int value)
> +{
> +	struct tee_param param[2];
> +	struct tee_invoke_arg arg;
> +	int status = -EACCES;
> +
> +	printf("The Hello World TA is going to be called\n");
> +
> +	status = hello_world_ta_open_session();
> +	if (status) {
> +		printf("HellWorldTA: OpenSession FAILED!\n");
"hello_world_ta_open_session() failed (%d)", status

> +		return status;
> +	}
> +
> +	arg.func = TA_HELLO_WORLD_CMD_INC_VALUE;
> +	arg.session = session;
> +
> +	param[0].attr = TEE_PARAM_ATTR_TYPE_VALUE_INOUT;
> +	param[0].u.value.a = value;
> +
> +	printf("TA value: %d\n", (int)param[0].u.value.a);
> +
> +	tee_invoke_func(tee, &arg, 1, param);
> +
> +	printf("TA value: %d\n", (int)param[0].u.value.a);
> +
> +	tee_invoke_func(tee, &arg, 1, param);
> +
> +	printf("TA value: %d\n", (int)param[0].u.value.a);
> +
> +	status = tee_close_session(tee, session);
> +
> +	return status;
> +}
> +
> +static int do_optee_hello_world_ta(struct cmd_tbl *cmdtp, int flag, int argc,
> +				   char * const argv[])
> +{
> +	int ret;
> +	int value;
> +
> +	if (argc != cmdtp->maxargs) {
> +		debug("hello_world_ta: incorrect parameters passed\n");
> +		return CMD_RET_USAGE;
> +	}
> +
> +	value = dectoul(argv[1], NULL);
> +	ret = hello_world_ta(value);
> +	if (ret)
> +		return CMD_RET_FAILURE;
> +
> +	return CMD_RET_SUCCESS;
> +}
> +
> +U_BOOT_LONGHELP(optee_hello_world_ta,
> +		"write_value value - Write value to increment\n"
> +		"Command for testing Hello World OPTEE TA\n"
> +		"pass the 'value' which needs to increment from OPTEE world\n");
> +
> +U_BOOT_CMD_WITH_SUBCMDS(hello_world_ta, "OPTEE hello world TA", optee_hello_world_ta_help_text,
> +			U_BOOT_SUBCMD_MKENT(write_value, 2, 1, do_optee_hello_world_ta));
