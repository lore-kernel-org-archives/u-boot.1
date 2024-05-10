Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C77C25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 15:50:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41E6488563;
	Fri, 10 May 2024 17:49:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WRXwH2e2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E595488122; Fri, 10 May 2024 17:49:57 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A08388563
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 17:49:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a59c5c9c6aeso541099566b.2
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 08:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1715356194; x=1715960994;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=90ocL8r0R0eaK8Hyf4h1NmQA//4eE2v0FNRibdK4f+Q=;
 b=WRXwH2e24jgQGrJ7IzT9ecxz+FZf1/pBEw1ZwiOp93ip05WEQ2IdiDZbJTU+hjmiPS
 05IHSMdxJf2ln2qRPqaXRgG2tx8IpQxziNUmYpUn3CqDLlVcRfjhA75WrfK8HHSAnpMI
 UwPPGZV6qSWS267LNt3jxqF0Njv+AhK6tQFv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715356194; x=1715960994;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=90ocL8r0R0eaK8Hyf4h1NmQA//4eE2v0FNRibdK4f+Q=;
 b=ZWZlVv2BwSbLSroNcggccMWFiHLb05TgydNhUun0vCFZcu6p/FLpL2Qg+M2CyQAOdW
 59B7gKRfBRCzK9GapvKfseOfoXxssJJ81xjMCDno3mk2tD9YImMqhCHm3zRYl73m2TYV
 IfDsBZvtv+rdMZr+fhuOzl1eWctQNEjV0uHaDja2CyO32+CuewWiR/1UdNMIDwQFnfhF
 gZMI/tCHJT0MqpPK/UTnq7BZFkA4UHkceE0LBRCtH/SIzoxS/PSkzixw/AVl1TtdTC+6
 myhA5TSMm0ebzL7+7JlxEJIqaPKIbUffxCL1Q8f1X3dI4C4pkBmL9hz8fK3L+imn/wNF
 1jPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg7TBWsu7SBFhJPAESOln4MjJAZpk3a4IwZtmtx8QLNB1g4W90QPK/T2lcKLLDyifaCPWAX5e08CTgfDZ+wPuhbnDn9g==
X-Gm-Message-State: AOJu0Yw7tuU6A53UUhBTCWL44J92/0CDgf4a7zJWmQYJPR/y44t8aSNc
 W4LNuXZ67iMi+dtlaWQH3c/KeZELOzYVF0uZw9olQ9nYT9nh9nBu9qCsJru+KEyxpzR90/xpT1w
 yZFO/n3fza4xOuy7xFgUnOEvoBpNbFDn83IQcQw==
X-Google-Smtp-Source: AGHT+IF8ZvLcUoPF4gXNyZ+twpYfzXiqYTnTEGeMYKy9m6CocsDGC+iJWkYSO7NWKxdnbY5QsMEslqUggPNx8C1FYAc=
X-Received: by 2002:a50:d496:0:b0:572:42ac:9b19 with SMTP id
 4fb4d7f45d1cf-5734d440712mr2103518a12.0.1715356193920; Fri, 10 May 2024
 08:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5AnweEsKk_LXVLRmC5=6L2x-Oo+rdngsAs_hcrSHFH91Q@mail.gmail.com>
 <CAOf5uw=2tob+MQfgGTfhXQqJK8vBjOPNPSD1CFkR70yXyEgAZg@mail.gmail.com>
 <CAOMZO5Bb9C+9-gj22LnVLGgQbh259h7iuff5jinD3LEDpAnkhQ@mail.gmail.com>
In-Reply-To: <CAOMZO5Bb9C+9-gj22LnVLGgQbh259h7iuff5jinD3LEDpAnkhQ@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 10 May 2024 17:49:42 +0200
Message-ID: <CAOf5uw=y8n+6GtjkQOCogqLGTuPj41arBxucQVZUecGoDOwzbg@mail.gmail.com>
Subject: Re: imx8mp: Flashing U-Boot into eMMC hardware partition via UUU
To: Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <frank.li@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>, 
 U-Boot-Denx <u-boot@lists.denx.de>, Tim Harvey <tharvey@gateworks.com>, 
 Adam Ford <aford173@gmail.com>, Heiko Schocher <hs@denx.de>
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

Hi Fabio

On Fri, May 10, 2024 at 5:10=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Michael,
>
> On Fri, May 10, 2024 at 11:28=E2=80=AFAM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
>
> > You can just change as you want. We have this file in buildroot, uuu
> > can run command on the device
> > using FB command. Example how call it
>
> Thanks for sharing the example.
>
> I adapted the UUU script like this:
>
> SDPS: boot -f flash.bin
> FB: ucmd setenv fastboot_buffer ${loadaddr}
> FB: ucmd mmc dev 2 1
> FB: download -f flash.bin
> FB: ucmd setexpr blkcnt $filesize + 0x1ff
> FB: ucmd setexpr blkcnt $blkcnt / 0x200
> FB: ucmd mmc write $loadaddr 0 $blkcnt

My suggestion is use timeout of some command when is possible

> FB: reboot
> FB: done
>
> Did the following changes based on imx8mn_bsh_smm_s2pro:
>
> index 024b46ef8bc2..0b6026c34309 100644
> --- a/board/freescale/imx8mp_evk/imx8mp_evk.c
> +++ b/board/freescale/imx8mp_evk/imx8mp_evk.c
> @@ -3,6 +3,8 @@
>   * Copyright 2019 NXP
>   */
>
> +#include <common.h>
> +#include <asm/arch/sys_proto.h>
>  #include <env.h>
>
>  int board_init(void)
> @@ -17,5 +19,11 @@ int board_late_init(void)
>         env_set("board_rev", "iMX8MP");
>  #endif
>
> +       if (is_usb_boot()) {
> +               printf("***** Entering in USB download mode\n");
> +               env_set("bootcmd", "fastboot usb 0");
> +               env_set("bootdelay", "0");
> +       }
> +

I think that is kind of good example

>         return 0;
>  }
> diff --git a/include/configs/imx8mp_evk.h b/include/configs/imx8mp_evk.h
> index 1759318fdd35..148b36bd3169 100644
> --- a/include/configs/imx8mp_evk.h
> +++ b/include/configs/imx8mp_evk.h
> @@ -25,8 +25,17 @@
>
>  #include <config_distro_bootcmd.h>
>
> +#define EMMCARGS \
> +       "fastboot_partition_alias_all=3D" \
> +               __stringify(CONFIG_FASTBOOT_FLASH_MMC_DEV) ".0:0\0" \
> +       "fastboot_partition_alias_bootloader=3D" \
> +               __stringify(CONFIG_FASTBOOT_FLASH_MMC_DEV) ".1:0\0" \
> +       "emmc_dev=3D" __stringify(CONFIG_FASTBOOT_FLASH_MMC_DEV) "\0" \
> +       "emmc_ack=3D1\0" \
> +
>  /* Initial environment variables */
>  #define CFG_EXTRA_ENV_SETTINGS         \
> +       EMMCARGS \
>         BOOTENV \
>         "scriptaddr=3D" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
>         "kernel_addr_r=3D" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
>
> and now UUU correctly flashes the eMMC hardware partition.
>
> Thanks a lot,

No problem

Micheal

>
> Fabio Estevam



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
