Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF189C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:39:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5E3888A08;
	Wed, 31 Jul 2024 16:38:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HEs8cRUm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15FC1889FA; Wed, 31 Jul 2024 16:38:54 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCE2288A10
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:38:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6b79fc76d03so32601626d6.1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722436731; x=1723041531; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MnPwtYoQMjpTUqlCEdJ4huIOuLjA9b1KKR7M2m8HOHY=;
 b=HEs8cRUmxHzNatlSbX0fY6cABy7f+8+l68rWT4qCHbbd9cpULUWLejho/y7b7k5jxc
 hHMKJ82RClVDlITbn0SpAehw9QA9Vg7w9KIg8n56wCO4q3ZN11bRdDCdfwtZyHd0SS2c
 YC2FxkFWGK58po8h89ilQMFMBBMTXy+DsC/N4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722436731; x=1723041531;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MnPwtYoQMjpTUqlCEdJ4huIOuLjA9b1KKR7M2m8HOHY=;
 b=CI+dfM9sVI3CO77j1Ah0q62/Erz9fHQJNpXQDx82mMI6Fu/cxaxGRyWHRe5a3E405a
 E9wZ0SKtIX5udit2F4Tw911IUCwzI/aCUDWwJ3N/hZPRPT7J7cFTbEyvwQdGtoxKr9gh
 jloTBqPU3mPFx68lecflE4i2nI1vqjbJWbF1dKvdrnl7g0A+kZXrpdADBDGMFJxQ7w9X
 neGouuVnhAoIswPiqDeE544XnpUEhz89j6tZ/3cIP5Y35s89+uBg4MloCjSDYyI79tUz
 npVFu5lKhhmIQrifnorFGOuaS9aNNMq5i+4QAvnoLm69BBVIMxx7yk2ZZrLirTUJ9bmD
 L69w==
X-Gm-Message-State: AOJu0YziCx5StW0tqJh9qS7PqRKjzDPuPJFajxTEsVo9FhM1j5kBk42P
 ypB2mrjjYmvYqC17XkWxXBgIHc5pGcYlKHoKPxuUu691/1VQDZ6oMI8RPGMIWQRlGsIDtZhxN38
 w2sqbGkX3FU/cQl1WZvVcmkby1MiWXBFw4LJk
X-Google-Smtp-Source: AGHT+IHn40VnvvlGo1cxFAyzEjDgL3sCQQm3JQJvX5RUpD0L5W5DYk51QLbYL6eeqqXOswME7OewKo+f+lL3yvrExw4=
X-Received: by 2002:a05:6214:20c6:b0:6b5:936d:e5e7 with SMTP id
 6a1803df08f44-6bb559fb49bmr225794956d6.18.1722436730807; Wed, 31 Jul 2024
 07:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240730073003.28892-1-Zhiqiang.Hou@nxp.com>
 <20240730073003.28892-11-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20240730073003.28892-11-Zhiqiang.Hou@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 31 Jul 2024 08:38:40 -0600
Message-ID: <CAFLszTgzXzUym-JBNk8i+50TsN81vU=Nhs_GMzvR+jmYaqMPsQ@mail.gmail.com>
Subject: Re: [PATCHv4 10/14] cmd: cpu: add release subcommand
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com, 
 festevam@gmail.com, marex@denx.de, lukma@denx.de, seanga2@gmail.com, 
 xypron.glpk@gmx.de
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

Hi Zhiqiang,

On Tue, 30 Jul 2024 at 01:09, Zhiqiang Hou <Zhiqiang.Hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> Add a new subcommand 'release' to bring up a core to run baremetal
> and RTOS applications.
>
> For example on i.MX8M Plus EVK, release the LAST core to run a RTOS
> application, passing the sequence number of the CPU core to release,
> here it is 3:
>     u-boot=3D> cpu list
>       0: cpu@0      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C
>       1: cpu@1      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 30C
>       2: cpu@2      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C
>       3: cpu@3      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C
>
>     u-boot=3D> load mmc 1:2 c0000000 /hello_world.bin
>     66008 bytes read in 5 ms (12.6 MiB/s)
>     u-boot=3D> dcache flush; icache flush
>     u-boot=3D> cpu release 3 c0000000
>     Released CPU core (mpidr: 0x3) to address 0xc0000000
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> V4:
>  - Updated the change logs.
>
>  cmd/cpu.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 42 insertions(+), 2 deletions(-)
>
> diff --git a/cmd/cpu.c b/cmd/cpu.c
> index 9e323069b9..2755250756 100644
> --- a/cmd/cpu.c
> +++ b/cmd/cpu.c
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2015 Google, Inc
>   * Written by Simon Glass <sjg@chromium.org>
>   * Copyright (c) 2017 =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.co=
m>
> + * Copyright 2024 NXP
>   */
>
>  #include <command.h>
> @@ -18,6 +19,19 @@ static const char *cpu_feature_name[CPU_FEAT_COUNT] =
=3D {
>         "Device ID",
>  };
>
> +static struct udevice *cpu_find_device(unsigned long cpu_id)
> +{
> +       struct udevice *dev;
> +
> +       for (uclass_first_device(UCLASS_CPU, &dev); dev;
> +            uclass_next_device(&dev)) {
> +               if (cpu_id =3D=3D dev_seq(dev))
> +                       return dev;
> +       }
> +
> +       return NULL;
> +}
> +
>  static int print_cpu_list(bool detail)
>  {
>         struct udevice *dev;
> @@ -82,10 +96,36 @@ static int do_cpu_detail(struct cmd_tbl *cmdtp, int f=
lag, int argc,
>         return 0;
>  }
>
> +static int do_cpu_release(struct cmd_tbl *cmdtp, int flag, int argc,
> +                         char *const argv[])
> +{
> +       struct udevice *dev;
> +       unsigned long cpu_id;
> +       unsigned long long boot_addr;
> +
> +       if (argc !=3D 3)
> +               return CMD_RET_USAGE;
> +
> +       cpu_id =3D dectoul(argv[1], NULL);

I just noticed this...normally we use hex for parameters.

> +       dev =3D cpu_find_device(cpu_id);
> +       if (!dev)
> +               return CMD_RET_FAILURE;
> +
> +       boot_addr =3D simple_strtoull(argv[2], NULL, 16);
> +
> +       if (cpu_release_core(dev, boot_addr))
> +               return CMD_RET_FAILURE;
> +
> +       return 0;
> +}
> +
>  U_BOOT_LONGHELP(cpu,
>         "list   - list available CPUs\n"
> -       "cpu detail     - show CPU detail");
> +       "cpu detail     - show CPU detail\n"
> +       "cpu release <core ID> <addr>   - Release CPU <core ID> at <addr>=
\n"
> +       "            <core ID>: the sequence number in list subcommand ou=
tputs");
>
>  U_BOOT_CMD_WITH_SUBCMDS(cpu, "display information about CPUs", cpu_help_=
text,
>         U_BOOT_SUBCMD_MKENT(list, 1, 1, do_cpu_list),
> -       U_BOOT_SUBCMD_MKENT(detail, 1, 0, do_cpu_detail));
> +       U_BOOT_SUBCMD_MKENT(detail, 1, 0, do_cpu_detail),
> +       U_BOOT_SUBCMD_MKENT(release, 3, 0, do_cpu_release));
> --
> 2.17.1
>

Regards,
Simon
