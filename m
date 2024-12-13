Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F18E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 12:48:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B08780137;
	Fri, 13 Dec 2024 13:48:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Rb6Pw4TN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0416D80141; Fri, 13 Dec 2024 13:48:50 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 527F48012C
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 13:48:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso3892095e9.1
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 04:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734094127; x=1734698927;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NIf9g74E5fPVZx/A+HVu76TbRYpP0Y8CBaYYb4HbBDU=;
 b=Rb6Pw4TNYCbGJiLb0ODzfzHX5GgEi22Vy5aUVr+8H88v06LBq3XOQdRYOg7gNbW6R5
 XYhipG7YjWPtM20Am6ffuZ+/4G6xw9hkLHKhGiLFGPlNzBQFheHFjxoYlbLOxz5Ilwad
 +gonVt5AxqCi7NNv6oJYZ2F7Uu4t6q6RdfIVTsNpIdBUG6G8JWEd35b4PpUZqZdN/wxi
 pKaNqRxHczx+ES/ALD9V4ToA77nUzfX4npWrWYTTob/Vgnxiqa1DkqmROV5Pz+dzMqzG
 9VTWYRYstsmgxrR+usXmbbQfxbFP2kVb+OqIq19uefyFQJ7LDJ7gCxPtoO4sbmeGGzF4
 008Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734094127; x=1734698927;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NIf9g74E5fPVZx/A+HVu76TbRYpP0Y8CBaYYb4HbBDU=;
 b=cnEDQLM93LVBru051jcfdsj9tOlCYeYQwvxzNco42bWawjxTpdFMfU597ITqZqOvnL
 /UC9ebzn7rdn2T4DS9E5Nz4wy9taRv+z3UBI7Ywg3XOOKxna/XB6gbZljF1I77iVgxdm
 ZjAOe8/67xT5CCIsUcsyP83Hb/TpfruUkUGgWoXmwn8+CehVovs8/tdpz4VRl5d/5K/f
 Cxs3d4Im3dPf2oL4raPK2y0f+6JkrCdTtH4SCLFQiokkNN1RNgW1l05zeW1TnljtuaUz
 RUlel7oz/OBw6o3WA2IP9bd1bskeK0h4y5oEin7i54W7rbNN07hU5sLXMZNljoHC6uPy
 i5wQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4+YIodWK5vyz0QFghbZDJUz/O535hEHRWIjArLd4eb9n0MvqqJo2Na5V8JtbFWhmjf0aZa7o=@lists.denx.de
X-Gm-Message-State: AOJu0YxR/G5QZV4V4q7aV5JLpHkvWLTNjyF/RfNe6w7zVwsZZSM6yat6
 MhtDxCg5u9acuSPAB2ADkD0PCxhYuQ19vozFM7wUf0PDKMmllxcCnaDPJSFyqgM=
X-Gm-Gg: ASbGncuUu8s1jz0L2f3VEmJb/bGFPiHMRpgkqPsY3halkMjkyJCvDXuR6OC9r5bjMgO
 CG3cn2pD1VbXigTsSMCL7MreWZx7wxIfONS0Zb2gXu2jnfbohzHwCe2BFzWJJCoDtau3uIclYBY
 WNOezwINC9CF9yzzDCym9LPNgnm9hbjghTvD/EqJj+OcRslYcAef1QAEJ/gW4qlJxYKABXI1pu/
 2qRmCNNRYlpZ0TcWFCmfacJJj6F+75+rEO6G/irt5KLpdunLusto5Tuj6HYfngAbA==
X-Google-Smtp-Source: AGHT+IE7sKSfQvZ7YrnJISeKSeUttUuKTQ/ne1otx8/ZcywQV5sSjS9j954nupO5PRe/midgPfN2+g==
X-Received: by 2002:a05:600c:1da1:b0:431:547e:81d0 with SMTP id
 5b1f17b1804b1-4362aa4386dmr20693135e9.11.1734094126676; 
 Fri, 13 Dec 2024 04:48:46 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436256e02b7sm48601365e9.37.2024.12.13.04.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 04:48:45 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, trini@konsulko.com, sjg@chromium.org,
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de, jerome.forissier@linaro.org, akashi.tkhro@gmail.com,
 francis.laniel@amarulasolutions.com, ddrokosov@salutedevices.com,
 git@amd.com
Subject: Re: [PATCH v2 1/2] cmd: Add support for optee hello world ta command
In-Reply-To: <20241213110034.1113036-2-venkatesh.abbarapu@amd.com>
References: <20241213110034.1113036-1-venkatesh.abbarapu@amd.com>
 <20241213110034.1113036-2-venkatesh.abbarapu@amd.com>
Date: Fri, 13 Dec 2024 13:48:44 +0100
Message-ID: <87a5czg34j.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Thank you for the patch.

On ven., d=C3=A9c. 13, 2024 at 16:30, Venkatesh Yadav Abbarapu <venkatesh.a=
bbarapu@amd.com> wrote:

> Enable "optee hello" command which increments the value passed.
> This provides easy test for establishing a session with OP-TEE
> TA and verify.
>
> It includes following subcommands:
> optee hello
> optee hello <value>; value to increment via OP-TEE HELLO
> WORLD TA.
>
> To enable the OP-TEE side HELLO WORLD example please refer
> https://optee.readthedocs.io/en/latest/building/gits/optee_examples/optee=
_examples.html
>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>  cmd/Kconfig                |   8 +++
>  cmd/Makefile               |   1 +
>  cmd/optee_hello_world_ta.c | 104 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 113 insertions(+)
>  create mode 100644 cmd/optee_hello_world_ta.c
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 1d7ddb4ed36..f1f8d1b9571 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1446,6 +1446,14 @@ config CMD_OPTEE_RPMB
>  	  in the Replay Protection Memory Block partition in eMMC by
>  	  using Persistent Objects in OPTEE
>=20=20
> +config CMD_OPTEE_HELLO_WORLD

If CMD_OPTEE_HELLO_WORLD has hello as a subcommand and we plan to add
other commands, shouldn't we give this Kconfig symbol a more generic
name?

How about CMD_OPTEE or CMD_OPTEE_TEST?

Maybe others have better recommendations for the naming.

> +	bool "Enable Hello world TA"
> +	depends on OPTEE
> +	default y

Are we sure we want this enabled by default for everyone?
It seems indeed like a nice debugging tool, but maybe keep it opt-in?

> +	help
> +	 Enable the hello world ta command to test the OPTEE by passing

OPTEE -> OP-TEE

> +	 a "value" which should increment by OPTEE TA example.

Ditto

> +
>  config CMD_MTD
>  	bool "mtd"
>  	depends on MTD
> diff --git a/cmd/Makefile b/cmd/Makefile
> index d1f369deec0..049147a1442 100644
> --- a/cmd/Makefile
> +++ b/cmd/Makefile
> @@ -118,6 +118,7 @@ obj-$(CONFIG_CMD_PAUSE) +=3D pause.o
>  obj-$(CONFIG_CMD_SLEEP) +=3D sleep.o
>  obj-$(CONFIG_CMD_MMC) +=3D mmc.o
>  obj-$(CONFIG_CMD_OPTEE_RPMB) +=3D optee_rpmb.o
> +obj-$(CONFIG_CMD_OPTEE_HELLO_WORLD) +=3D optee_hello_world_ta.o

Similar remark for the file name.

>  obj-$(CONFIG_CMD_MP) +=3D mp.o
>  obj-$(CONFIG_CMD_MTD) +=3D mtd.o
>  obj-$(CONFIG_CMD_MTDPARTS) +=3D mtdparts.o
> diff --git a/cmd/optee_hello_world_ta.c b/cmd/optee_hello_world_ta.c
> new file mode 100644
> index 00000000000..7c398bcad2c
> --- /dev/null
> +++ b/cmd/optee_hello_world_ta.c
> @@ -0,0 +1,104 @@
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
> +	const struct tee_optee_ta_uuid uuid =3D TA_HELLO_WORLD_UUID;
> +	struct tee_open_session_arg arg;
> +	int rc;
> +
> +	tee =3D tee_find_device(tee, NULL, NULL, NULL);
> +	if (!tee)
> +		return -ENODEV;
> +
> +	memset(&arg, 0, sizeof(arg));
> +	tee_optee_ta_uuid_to_octets(arg.uuid, &uuid);
> +	rc =3D tee_open_session(tee, &arg, 0, NULL);
> +	if (rc !=3D 0)
> +		session =3D arg.session;
> +
> +	return 0;
> +}
> +
> +static int hello_world_ta(unsigned int value)
> +{
> +	struct tee_param param[2];
> +	struct tee_invoke_arg arg;
> +	int status =3D -EACCES;
> +
> +	printf("The Hello World TA is going to be called\n");
> +
> +	status =3D hello_world_ta_open_session();
> +	if (status) {
> +		printf("hello_world_ta_open_session failed(%d)", status);
> +		return status;
> +	}
> +
> +	arg.func =3D TA_HELLO_WORLD_CMD_INC_VALUE;
> +	arg.session =3D session;
> +
> +	param[0].attr =3D TEE_PARAM_ATTR_TYPE_VALUE_INOUT;
> +	param[0].u.value.a =3D value;
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
> +	status =3D tee_close_session(tee, session);
> +
> +	return status;
> +}
> +
> +static int do_optee_hello_world_ta(struct cmd_tbl *cmdtp, int flag, int =
argc,
> +				   char * const argv[])
> +{
> +	int ret;
> +	int value =3D 0;
> +
> +	if (argc !=3D cmdtp->maxargs && argv[1] !=3D NULL) {
> +		debug("do_optee_hello_world_ta: incorrect parameters passed\n");
> +		return CMD_RET_USAGE;
> +	}
> +
> +	if (argv[1] !=3D NULL)
> +		value =3D dectoul(argv[1], NULL);
> +
> +	ret =3D hello_world_ta(value);
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
> --=20
> 2.34.1
