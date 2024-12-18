Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8771E77188
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 10:29:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 431F480288;
	Wed, 18 Dec 2024 11:29:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bHDG31dv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57F81802EF; Wed, 18 Dec 2024 11:29:16 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC7468027E
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 11:29:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5cec9609303so8765296a12.1
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 02:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734517753; x=1735122553; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OXX2Ey1HxNeXcT5Cd20FX34PSsKDVYm9bgKot4XI0Fw=;
 b=bHDG31dvIIE9OCj+5tsOPlupgm+C5cprRnGxEPCPGlIC5rfhdT2Fd34mE+TAdFYCTK
 Qo3EX+A1VixYO+EIizcZyRf1IzyitPl3yLmyX2KTB90BM1hvUefriTUXJoDHiRHsQRFQ
 VaYC7NI8mhq/QvK4KnKSthr9O08yUSRs6icDd9hkGrytSYWgTbG1IpYvTFLoKSGgzzjr
 c/tg+oaSKkx2vKpWGFP7+FYAZRn2o5LaD/wvERbXHkAUxWJPVCycRXqSPj5CpuUhI1Rn
 OkvuMFk+qAaOYHsB42o8wMHaVBp0yWdQzg5EyYt7xYPgmB0A8oxCdZdEE46GhJJRXznq
 SQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734517753; x=1735122553;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OXX2Ey1HxNeXcT5Cd20FX34PSsKDVYm9bgKot4XI0Fw=;
 b=atCYPupmy9noR6+aIXU4a9RkumxHWJWay+y1EVaKJ4T5HOrnWqmZd4zY0xhkBhjXJ+
 p8RoyTV304WwmoKJ4eTgcORPBUdAIEz2/ITEg3WB9WldlwfzM2viwnA4rJEFcY8fO+Up
 WLLQLuwz84lY7ArcBwnZVmtRTi3Ubpo/1TBR2m9fMHhYbwZCxGhQ24p/Jnn8cjjadD36
 9UepCcp5+94CwK5LVjt9snwX03UJs/kGFIHGz47oUEE+W/I6pU2d8NILIRGmeFiyzpu4
 77hJdAORka90OFFAaZcGwWJUi1oj9SrB+o0LnetZBedLnFO79Nj1O6bMTl1Tl9TbZ4Ue
 Bo2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoU/kjIs9kv+E0bS4nlwHaQD4ZU/N/scJOM4BTNcXx8Z/jeRAWelKcKo0eIF5QI4/0E5ytSaw=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7I1NlFtw5jL3Ktp5gHzktHViJV6YkuGe35wIglL/m5XskOwC7
 OjffPV435eoCg+A2qFNI4wHNG2Z/wPMLOwpFpWJc/201WRGY354wY34kuLV9JMaecdUXYrAEBd4
 r3B4=
X-Gm-Gg: ASbGncvNkk1Z5TItVKdCM7kGC5a9Zaf2DWerpxbcmpjGHXv6W45W6YcW2AINeD/NJvI
 GfPurdNdqfq8vhSoOZp+zqacKI/55zhtErXIXeY5gh9ZitIsTbdQK/NdDaXs7HGBQY7tGqNqyOp
 IBE3y98EEoalU+Igp8eAYZfDgiUfmBERbNOmJW7XPvVoNK5U8YSqk+4ao4UCeLKY7RsCOFwjabP
 5rgDs5iqO301o3LEHynJD1sdbH9AkyKnBv9sSldg85eQmADmZupuRO3pMvSJc7bH37ILNvF2Dwd
 L/Rf91saPJt6h91gGHETb+puLrWULxcxVMDU
X-Google-Smtp-Source: AGHT+IH3iRT7D4AAb/f1Uqj9H4+HrdTUfO8UF9fC+1NICEgwQkbYEG30UxhZ97VuOSkdkvRB0DG02w==
X-Received: by 2002:a05:6402:2345:b0:5d0:bcdd:ff8f with SMTP id
 4fb4d7f45d1cf-5d7ee3a334emr2416889a12.4.1734517753135; 
 Wed, 18 Dec 2024 02:29:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:7a7b:97ce:b355:53a9?
 ([2a01:e0a:3cb:7bb0:7a7b:97ce:b355:53a9])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d652ab5114sm5444270a12.5.2024.12.18.02.29.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 02:29:12 -0800 (PST)
Message-ID: <4dfe81d0-e15f-45cd-bc0e-a509157877b7@linaro.org>
Date: Wed, 18 Dec 2024 11:29:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] cmd: Add support for optee commands
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, trini@konsulko.com, sjg@chromium.org,
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
 mkorpershoek@baylibre.com, akashi.tkhro@gmail.com,
 francis.laniel@amarulasolutions.com, ddrokosov@salutedevices.com, git@amd.com
References: <20241218041914.1463666-1-venkatesh.abbarapu@amd.com>
 <20241218041914.1463666-2-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241218041914.1463666-2-venkatesh.abbarapu@amd.com>
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



On 12/18/24 05:19, Venkatesh Yadav Abbarapu wrote:
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
>  cmd/Kconfig  |  6 +++++
>  cmd/Makefile |  1 +
>  cmd/optee.c  | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 83 insertions(+)
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
> index 00000000000..e8d5f4ceb36
> --- /dev/null
> +++ b/cmd/optee.c
> @@ -0,0 +1,76 @@
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
> +	printf("Value before: 0x%x\n", (int)param[0].u.value.a);
> +	printf("Calling TA\n");
> +	tee_invoke_func(tee, &arg, 1, param);
> +
> +	printf("Value after: 0x%x\n", (int)param[0].u.value.a);
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

What is this supposed to mean?

> +		"optee hello\n"
> +		"optee hello <value>\n"

Optional values are usually indicated with []

> +		"\n"
> +		"With:\n"
> +		"\t<value>: integer value\n"
> +		);
> +
> +U_BOOT_CMD_WITH_SUBCMDS(optee, "OP-TEE commands", optee_help_text,
> +			U_BOOT_SUBCMD_MKENT(hello, 2, 1, do_optee_hello_world_ta));

I believe the following should be clear and good enough:

U_BOOT_LONGHELP(optee,
	"hello [<value>]   Invoke the OP-TEE 'Hello World' TA\n");
U_BOOT_CMD_WITH_SUBCMDS(optee, "OP-TEE commands", optee_help_text,
	U_BOOT_SUBCMD_MKENT(hello, 2, 1, do_optee_hello_world_ta));


With that:

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
