Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AABAC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 03:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1850A87CF2;
	Mon, 11 Mar 2024 04:50:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mDzetvcT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 614738644E; Mon, 11 Mar 2024 04:50:02 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19CA187CF2
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 04:50:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-512e4f4e463so5284117e87.1
 for <u-boot@lists.denx.de>; Sun, 10 Mar 2024 20:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710128999; x=1710733799; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7agCoEXeUtnrG4v5FyL7WdamyHOmPTgvDh0aBnHwCCQ=;
 b=mDzetvcTjJ1qJ8d8JmKP7FdUq993zy6knLMu2Bs1Mb1naxgP19OoXSw+rNP2ZEuE6k
 67Ih6g5hD40kR+wJGVftK60dNfJqz33wFrtcsHUIuSockiOuO06R0AOyPylGGsziJGDu
 /CZTm77NTsBqmh3wjmN5/isMXI6ESENu4J7kKnReJ1BggzPUEQoaVpgPRsy6f4gHGaxr
 o7bFYUnViMJqCDO4mIUeSTBoSbFHhPohqh6kbirhgsTiKxbwe5oYoACPQMC14pov7xDE
 vI8dsT2RT6a/yqNhKIZBsxjibkhlbU7Kje/IOSFFBiO75HFSr88q9voI57BO4iSWomMz
 uRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710128999; x=1710733799;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7agCoEXeUtnrG4v5FyL7WdamyHOmPTgvDh0aBnHwCCQ=;
 b=j0HO+1FQ5nRJfzhneqLe1Mm7S36n7XfPvMvUqBBk0B9KaXLQyT5TO3cELSxGjVU4JO
 cWr5EwnMOjepm2ScgVwuolJYtDDt+XmzgQyfSYnZqsHHa9tq661bqaWtUKCqVxn/hgw5
 Spg4I5w6EjbCL56NARkWuxOE7kzrgGaGr8HYMSWoggbUv7q+NS4aEbOmd4bn/4HEtTHb
 Gv8h1EYGwX1OM7XJ4nqSuaA9jnOiM/W9OGuMQON3V0GQUSnq44N6CLHoAYS0N2bSQrBC
 GN/DDzPQKILgyr4AHDxRR87gjY056zVFkRD6RFaltTMSSk7/HX4IdkobdGKN4lRTtQVR
 f1Hw==
X-Gm-Message-State: AOJu0YwIPe1YLEQhpKEG2L4c9bpRXyxdXExrng2/oTFPyVV5h57Cprua
 AHaiOKW0WFieujwQPCh2M76SlAo7qAMb2VjdKoDGovU8WGhGRhAWNzfYaSH1qqth/6X2kxZjXeR
 bVJ4oT2dQsxZqO/FNq5R/N2i33j0=
X-Google-Smtp-Source: AGHT+IEIG90VoWuAJq92X8+fENFeoygkJJM0Mxk1vcHFPgdi4WY8BAwWtUxsmx0lrRZh9MHQagpWYSjZ+Q+1h9o7Hf4=
X-Received: by 2002:a05:6512:1052:b0:513:a088:17bc with SMTP id
 c18-20020a056512105200b00513a08817bcmr3830622lfb.50.1710128999094; Sun, 10
 Mar 2024 20:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
 <170929783825.70492.4756963077870833230.b4-ty@konsulko.com>
 <CAOMZO5CjeUhFfLBs3FRt4Hbk0ULXrRoOZaZqvSRzWbNySdsOhQ@mail.gmail.com>
 <CAFA6WYMf7Z-sW8pSHzYUJ_O9fqfunBEhyigJj3BW-DYuujxDbw@mail.gmail.com>
 <CAOMZO5AhTGskhEX9mv8oMJ1k4cbZzfZ2Vck5VcrVrYUvBA2r7w@mail.gmail.com>
 <CAFA6WYM12F_9yyNwXY5xj9+zh3Jwa_Jmz8MkaKsxm3Jn3NPNKA@mail.gmail.com>
 <CAOMZO5DgEaTGmxJfJf=fGgwauE-M+XyHm+tA8rfOw+MwRK_mqA@mail.gmail.com>
In-Reply-To: <CAOMZO5DgEaTGmxJfJf=fGgwauE-M+XyHm+tA8rfOw+MwRK_mqA@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Sun, 10 Mar 2024 20:49:47 -0700
Message-ID: <CAJaLiFxgNPoiGZMFt7SvTdVRUz1QNC7pibbeoaed7DaxEnFWNQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] An effort to bring DT bindings compliance within
 U-Boot
To: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Bryan Brattlof <bb@ti.com>, Stefan Roese <sr@denx.de>,
 Fabio Estevam <festevam@denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Sumit,
Hi Tom,

On Mon, Mar 4, 2024 at 4:29=E2=80=AFAM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> On Mon, Mar 4, 2024 at 9:15=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>
> > I suppose the earlier reference patch wasn't complete, can you rather
> > try its v4 [1] instead?
> >
> > [1] https://patchwork.ozlabs.org/project/uboot/patch/20240304121257.355=
1104-1-sumit.garg@linaro.org/
>
> This one works, thanks!

I'm testing this for a Marvell Armada 385 board (Synology DS116). I'm
on the next branch, but  perhaps something is still missing.

diff --git a/configs/ds116_defconfig b/configs/ds116_defconfig
index 02ddc0e7918..1fbedcf91cf 100644
--- a/configs/ds116_defconfig
+++ b/configs/ds116_defconfig
@@ -16,7 +16,7 @@ CONFIG_SF_DEFAULT_SPEED=3D50000000
 CONFIG_ENV_SIZE=3D0x10000
 CONFIG_ENV_OFFSET=3D0x7E0000
 CONFIG_ENV_SECT_SIZE=3D0x10000
-CONFIG_DEFAULT_DEVICE_TREE=3D"armada-385-synology-ds116"
+CONFIG_DEFAULT_DEVICE_TREE=3D"marvell/armada-385-synology-ds116"
 CONFIG_SPL_TEXT_BASE=3D0x40000030
 CONFIG_SPL_SERIAL=3Dy
 CONFIG_SPL_STACK=3D0x4002c000
@@ -29,7 +29,6 @@ CONFIG_PCI=3Dy
 CONFIG_DEBUG_UART=3Dy
 CONFIG_AHCI=3Dy
 CONFIG_BOOTSTD_FULL=3Dy
-CONFIG_BOOTSTD_DEFAULTS=3Dy
 CONFIG_BOOTDELAY=3D10
 CONFIG_USE_PREBOOT=3Dy
 CONFIG_SYS_CONSOLE_INFO_QUIET=3Dy
@@ -57,6 +56,7 @@ CONFIG_CMD_CACHE=3Dy
 CONFIG_CMD_TIME=3Dy
 CONFIG_CMD_MTDPARTS=3Dy
 CONFIG_MTDPARTS_DEFAULT=3D"mtdparts=3Dspi0.0:1m(u-boot),7040k(kernel),64k(=
u-boot-env),-(data)"
+CONFIG_OF_UPSTREAM=3Dy
 CONFIG_ENV_OVERWRITE=3Dy
 CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
 CONFIG_VERSION_VARIABLE=3Dy

# make ds116_defconfig

# grep -i ds116 .config
CONFIG_SYS_BOARD=3D"ds116"
CONFIG_SYS_CONFIG_NAME=3D"ds116"
CONFIG_TARGET_DS116=3Dy
CONFIG_DEFAULT_DEVICE_TREE=3D"marvell/armada-385-synology-ds116"
CONFIG_IDENT_STRING=3D"\nSynology DS116"
CONFIG_SYS_PROMPT=3D"DS116> "
CONFIG_OF_LIST=3D"marvell/armada-385-synology-ds116"
CONFIG_SPL_OF_LIST=3D"marvell/armada-385-synology-ds116"

Built it, and looks like vendor Marvell is missing during the Make
file execution.

make -f ./scripts/Makefile.build obj=3Ddts dtbs
make -f ./scripts/Makefile.build obj=3Ddts/upstream/src/arm dtbs
scripts/Makefile.build:57: dts/upstream/src/arm/Makefile: No such file
or directory
make[2]: *** No rule to make target 'dts/upstream/src/arm/Makefile'.  Stop.
make[1]: *** [dts/Makefile:54: arch-dtbs] Error 2
make: *** [Makefile:1166: dts/dt.dtb] Error 2
make: *** Waiting for unfinished jobs....
make: Leaving directory '/usr/src/u-boot'

I also tried Bryan's patch like you've suggested to Fabio. But it
seems Bryan's patch was already in the next branch. Did I miss
something?

All the best ,
Tony
