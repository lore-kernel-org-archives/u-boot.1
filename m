Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A7BC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 06:25:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24C6587D35;
	Mon, 11 Mar 2024 07:25:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oqKRputS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9440F87D2C; Mon, 11 Mar 2024 07:25:05 +0100 (CET)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B5F587D50
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 07:25:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-7dba8bc7d7cso1509177241.0
 for <u-boot@lists.denx.de>; Sun, 10 Mar 2024 23:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710138298; x=1710743098; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AZRgwB20QKRe7H8DH2W2uaVW/D4RZoANeJkR4s73DeY=;
 b=oqKRputSadRzaH+ftIo5iUeCOfxUoJI/emxj9dD3gH2zE9vULzyDyvFw6QqGgvjx7K
 3U9K8+ufokXokIbGvd0HgtC998Wf14QD9H6PsP9ps8TrXZ5eeNDi+drtz473XjpDyFh0
 kFxCnz59ZwdWw5w90Ii0Mz6J8LrV+IYugEe3FVdx3eXSEjLVkNCmrro7isRlft0VjaGt
 XVDkyMeKktwO2hf7zlk5UMuGr0sga4ptsgj88//b55D6G/66J9yXatqVqDhDkFB5EvRY
 MeuL/8YY8YKMeBabUZDZNv527ETkOheCAIgj8qVJjMVGqn1MdIVkQipZkxBWH32esp6H
 xMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710138298; x=1710743098;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AZRgwB20QKRe7H8DH2W2uaVW/D4RZoANeJkR4s73DeY=;
 b=TDrW1C5K3MOZdcQb7KkMopiCbipq9IvBhbHGjl/8uBfenuAfjG+z0XYsuJCnmD+j6Z
 z0BKOEHeU6ZN68ANCV/XnLkuzEOaecbJFey6N7mE+tWdUCMVuSf0AYX4BIb+ML3uA2Dw
 wYyCOdznZWKr8LTRb7OsadONwbwLXYWkzWmDFYVmgvtU1VePiSn+FujOrE7v0iIDUG8A
 hl3JeFpiQWYpCFR8i9Oe3JfRWXvR3wftkPIyboWWIMbxG2aU2YBmpFGvydwdwyzYiogM
 EULVeqWAlkvBhgwxtA4xMgjklXwwEYmHO6w5innkjv/Ch31vxlmF4ft9MFK53h7FtPkA
 x4yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCURM+e958tw2o33YOkoD4LHmyJl7qEHGabb8ovY6GpFcWkd9r2cFgC+XXfuCEyAyTQh2W3DWvX3xHqfeoqmKwhSw/lnlQ==
X-Gm-Message-State: AOJu0Yyoa4UyX8BTbp6P4Zcp6+5kQzgHaSpb7jJ0tRopnCCy9GPgZPpG
 3tYNIT1EaaqhtF9h3L20tYh07SeSwH1TUV1VpLvAhQODWcnNeVluVGxJ1Sy9rJG80Yv2+x7jiBt
 EVJzcDHcX29x/2D88PI3GPiaSBZESL26EtcT4ug==
X-Google-Smtp-Source: AGHT+IHvuVRjzxGQxSU831Lo/z9fta4q1te+OcI/QXlNCXISd9So6uQRavSqHdhEAFdcZdu+sV7BVoIMg77XFUh9WPs=
X-Received: by 2002:a67:e25a:0:b0:472:9b30:567a with SMTP id
 w26-20020a67e25a000000b004729b30567amr4546723vse.3.1710138298615; Sun, 10 Mar
 2024 23:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
 <170929783825.70492.4756963077870833230.b4-ty@konsulko.com>
 <CAOMZO5CjeUhFfLBs3FRt4Hbk0ULXrRoOZaZqvSRzWbNySdsOhQ@mail.gmail.com>
 <CAFA6WYMf7Z-sW8pSHzYUJ_O9fqfunBEhyigJj3BW-DYuujxDbw@mail.gmail.com>
 <CAOMZO5AhTGskhEX9mv8oMJ1k4cbZzfZ2Vck5VcrVrYUvBA2r7w@mail.gmail.com>
 <CAFA6WYM12F_9yyNwXY5xj9+zh3Jwa_Jmz8MkaKsxm3Jn3NPNKA@mail.gmail.com>
 <CAOMZO5DgEaTGmxJfJf=fGgwauE-M+XyHm+tA8rfOw+MwRK_mqA@mail.gmail.com>
 <CAJaLiFxgNPoiGZMFt7SvTdVRUz1QNC7pibbeoaed7DaxEnFWNQ@mail.gmail.com>
In-Reply-To: <CAJaLiFxgNPoiGZMFt7SvTdVRUz1QNC7pibbeoaed7DaxEnFWNQ@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 11 Mar 2024 11:54:47 +0530
Message-ID: <CAFA6WYOJJ2=x01DcF_u4env=r1On1Ry0kkdi4MZcz8xT7o7V0Q@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] An effort to bring DT bindings compliance within
 U-Boot
To: Tony Dinh <mibodhi@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Bryan Brattlof <bb@ti.com>, 
 Stefan Roese <sr@denx.de>, Fabio Estevam <festevam@denx.de>
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

Hi Tony,

On Mon, 11 Mar 2024 at 09:20, Tony Dinh <mibodhi@gmail.com> wrote:
>
> Hi Sumit,
> Hi Tom,
>
> On Mon, Mar 4, 2024 at 4:29=E2=80=AFAM Fabio Estevam <festevam@gmail.com>=
 wrote:
> >
> > On Mon, Mar 4, 2024 at 9:15=E2=80=AFAM Sumit Garg <sumit.garg@linaro.or=
g> wrote:
> >
> > > I suppose the earlier reference patch wasn't complete, can you rather
> > > try its v4 [1] instead?
> > >
> > > [1] https://patchwork.ozlabs.org/project/uboot/patch/20240304121257.3=
551104-1-sumit.garg@linaro.org/
> >
> > This one works, thanks!
>
> I'm testing this for a Marvell Armada 385 board (Synology DS116). I'm
> on the next branch, but  perhaps something is still missing.
>
> diff --git a/configs/ds116_defconfig b/configs/ds116_defconfig
> index 02ddc0e7918..1fbedcf91cf 100644
> --- a/configs/ds116_defconfig
> +++ b/configs/ds116_defconfig
> @@ -16,7 +16,7 @@ CONFIG_SF_DEFAULT_SPEED=3D50000000
>  CONFIG_ENV_SIZE=3D0x10000
>  CONFIG_ENV_OFFSET=3D0x7E0000
>  CONFIG_ENV_SECT_SIZE=3D0x10000
> -CONFIG_DEFAULT_DEVICE_TREE=3D"armada-385-synology-ds116"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"marvell/armada-385-synology-ds116"
>  CONFIG_SPL_TEXT_BASE=3D0x40000030
>  CONFIG_SPL_SERIAL=3Dy
>  CONFIG_SPL_STACK=3D0x4002c000
> @@ -29,7 +29,6 @@ CONFIG_PCI=3Dy
>  CONFIG_DEBUG_UART=3Dy
>  CONFIG_AHCI=3Dy
>  CONFIG_BOOTSTD_FULL=3Dy
> -CONFIG_BOOTSTD_DEFAULTS=3Dy
>  CONFIG_BOOTDELAY=3D10
>  CONFIG_USE_PREBOOT=3Dy
>  CONFIG_SYS_CONSOLE_INFO_QUIET=3Dy
> @@ -57,6 +56,7 @@ CONFIG_CMD_CACHE=3Dy
>  CONFIG_CMD_TIME=3Dy
>  CONFIG_CMD_MTDPARTS=3Dy
>  CONFIG_MTDPARTS_DEFAULT=3D"mtdparts=3Dspi0.0:1m(u-boot),7040k(kernel),64=
k(u-boot-env),-(data)"
> +CONFIG_OF_UPSTREAM=3Dy
>  CONFIG_ENV_OVERWRITE=3Dy
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
>  CONFIG_VERSION_VARIABLE=3Dy
>
> # make ds116_defconfig
>
> # grep -i ds116 .config
> CONFIG_SYS_BOARD=3D"ds116"
> CONFIG_SYS_CONFIG_NAME=3D"ds116"
> CONFIG_TARGET_DS116=3Dy
> CONFIG_DEFAULT_DEVICE_TREE=3D"marvell/armada-385-synology-ds116"
> CONFIG_IDENT_STRING=3D"\nSynology DS116"
> CONFIG_SYS_PROMPT=3D"DS116> "
> CONFIG_OF_LIST=3D"marvell/armada-385-synology-ds116"
> CONFIG_SPL_OF_LIST=3D"marvell/armada-385-synology-ds116"
>
> Built it, and looks like vendor Marvell is missing during the Make
> file execution.
>
> make -f ./scripts/Makefile.build obj=3Ddts dtbs
> make -f ./scripts/Makefile.build obj=3Ddts/upstream/src/arm dtbs
> scripts/Makefile.build:57: dts/upstream/src/arm/Makefile: No such file
> or directory

As you are building for the 32-bit Arm, you have to add a Makefile
here [1] similar to this one [2] for arm64.

[1] https://source.denx.de/u-boot/u-boot/-/tree/next/dts/upstream/src/arm?r=
ef_type=3Dheads
[2] https://source.denx.de/u-boot/u-boot/-/blob/next/dts/upstream/src/arm64=
/Makefile?ref_type=3Dheads

-Sumit

> make[2]: *** No rule to make target 'dts/upstream/src/arm/Makefile'.  Sto=
p.
> make[1]: *** [dts/Makefile:54: arch-dtbs] Error 2
> make: *** [Makefile:1166: dts/dt.dtb] Error 2
> make: *** Waiting for unfinished jobs....
> make: Leaving directory '/usr/src/u-boot'
>
> I also tried Bryan's patch like you've suggested to Fabio. But it
> seems Bryan's patch was already in the next branch. Did I miss
> something?
>
> All the best ,
> Tony
