Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FF2CD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 14:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2367488268;
	Thu,  4 Apr 2024 16:47:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RzENFThO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ED918826D; Thu,  4 Apr 2024 16:47:07 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 249C988251
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 16:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d6a1af9c07so12568291fa.3
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 07:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712242024; x=1712846824; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZGuAykUj/8vaboOJZ0C4bfUx/3vyMv/Bud6jUh3NniM=;
 b=RzENFThOgvNH1OQ2aT3y0hjBGfs9MQSaotjhiw404ngYWJaOtqC/YiIgY058moQ97b
 qv21G0upm+wu1bawv8tv7Xu3Nw3eC/g2PaKC/0LRbL7gRcng+LTcON4+8UYOKQQCwS3F
 GQf2++3irAiSo5i6rRHWC6ReyrqmUmUfSADxhTtlM3H1yZBWJRyQsGlskNqajzW5DI0r
 59WAtp+/OxIsp1A0b/nZmtuDkm8SERc1n2f1mEqorVUuuiXCbXrz2EnX+OEEcTmVZWel
 gzmpT6GjgYhaojgnY893ICnNOPxbyZ7iio0HyJ2FoSMLgFZRQceUn8UNH6kjnHIaEJRD
 PWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712242024; x=1712846824;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZGuAykUj/8vaboOJZ0C4bfUx/3vyMv/Bud6jUh3NniM=;
 b=wPlsUtjEwSkvXO43nRibsap36UmK495AvEqHAQLN646P3NvlUH9s9vj/8RVwVw+o+1
 z/zLc7Q9PllefJif8mFViojP1xkZ71xPxpxOrRdNgYovwLqsXwu1KXLp8IoqonHbF906
 o9+xQ1h0rHWeecSHhbFd/z1XS844BlyeF4f/GRSgBbUCbqT0O9BNafcsfQh7kZiTrVBf
 qBG8q3QJanCIW1ROIoVhHZoGWt7yXHPygMrqg5UjRl11tNqhT3J6ygLGdOLpxb3HuuZt
 dSoxcNg/X75LYfYc8GWyzyyewCVgAtJzY+uiRxK51JiOvY0TfQ/AXBZ3YO4Hv0ELJqIW
 rwiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtiuuAswEpO2SnP2UjUlNaIKebgJszZq+pOB7M36XiVZck2UUcchtGHSBJdtL8aw3LGApt9h/jIwo6XqBnBKLf/CIYTA==
X-Gm-Message-State: AOJu0YxeHx71YfpG4sWvWKfhbHWfRyY27Vlww1tXdHoQSu8VGx/cc5LP
 /burTnxA7VAvYd4+ntsz1OI050YrNW8t6FkJgyp1kmjnUZ7hDb1AO9bJUWEiiCk7+ldhN+kLagC
 Gh6jJdpjQnptsqD6OH+khV47r4lWFF8o3jsf+mw==
X-Google-Smtp-Source: AGHT+IELvNo5blqf//pbj4HuprxrwtcBvjIhS7rOReOaFAejBAx1ja0zFoAXLQqPvXp2sr2qJ/14PEtEdC7dFallQIo=
X-Received: by 2002:a2e:9a8d:0:b0:2d8:41fb:9c6e with SMTP id
 p13-20020a2e9a8d000000b002d841fb9c6emr2288223lji.47.1712242024390; Thu, 04
 Apr 2024 07:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240404114742.81187-1-heinrich.schuchardt@canonical.com>
 <20240404114742.81187-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240404114742.81187-5-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 4 Apr 2024 17:46:28 +0300
Message-ID: <CAC_iWjJ3Fk-j227rGjdvH6RQy=t2jXXdrYmfgh2vtPT4Wg8ZRQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] boot: correct finding the default EFI binary
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Bryan Brattlof <bb@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, 
 "Leon M . Busch-George" <leon@georgemail.eu>,
 Eddie James <eajames@linux.ibm.com>, Bin Meng <bmeng@tinylab.org>, 
 Shantur Rathore <i@shantur.com>, Mark Kettenis <kettenis@openbsd.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Sean Edmond <seanedmond@microsoft.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 E Shattow <lucent@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich,

FWIW reading at this, I don't see a point of having it overall. It has
a nice feature of trying to load external DTBs from a path though.
I think in the future we can move the dtb selection in
bootmeth_efi_mgr.c and delete this one

On Thu, 4 Apr 2024 at 14:49, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> * The sandbox must not use an arbitrary file name bootsbox.efi but the
>   file name matching the host architecture to properly boot the respective
>   file. We already have an include which provides a macro with the name of
>   the EFI binary. Use it.
>
> * The path to the EFI binary should be absolute.
>
> * The path and the file name must be capitalized to conform to the UEFI
>   specification. This is important when reading from case sensitive
>   file systems.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         new patch
> ---
>  boot/bootmeth_efi.c  | 44 +++-----------------------------------------
>  test/boot/bootflow.c |  4 +++-
>  2 files changed, 6 insertions(+), 42 deletions(-)
>
> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> index a46b6c9c805..aebc5207fc0 100644
> --- a/boot/bootmeth_efi.c
> +++ b/boot/bootmeth_efi.c
> @@ -14,6 +14,7 @@
>  #include <bootmeth.h>
>  #include <command.h>
>  #include <dm.h>
> +#include <efi_default_filename.h>
>  #include <efi_loader.h>
>  #include <fs.h>
>  #include <malloc.h>
> @@ -23,43 +24,7 @@
>  #include <pxe_utils.h>
>  #include <linux/sizes.h>
>
> -#define EFI_DIRNAME    "efi/boot/"
> -
> -/**
> - * get_efi_leafname() - Get the leaf name for the EFI file we expect
> - *
> - * @str: Place to put leaf name for this architecture, e.g. "bootaa64.efi".
> - *     Must have at least 16 bytes of space
> - * @max_len: Length of @str, must be >=16
> - */
> -static int get_efi_leafname(char *str, int max_len)
> -{
> -       const char *base;
> -
> -       if (max_len < 16)
> -               return log_msg_ret("spc", -ENOSPC);
> -       if (IS_ENABLED(CONFIG_ARM64))
> -               base = "bootaa64";
> -       else if (IS_ENABLED(CONFIG_ARM))
> -               base = "bootarm";
> -       else if (IS_ENABLED(CONFIG_X86_RUN_32BIT))
> -               base = "bootia32";
> -       else if (IS_ENABLED(CONFIG_X86_RUN_64BIT))
> -               base = "bootx64";
> -       else if (IS_ENABLED(CONFIG_ARCH_RV32I))
> -               base = "bootriscv32";
> -       else if (IS_ENABLED(CONFIG_ARCH_RV64I))
> -               base = "bootriscv64";
> -       else if (IS_ENABLED(CONFIG_SANDBOX))
> -               base = "bootsbox";
> -       else
> -               return -EINVAL;
> -
> -       strcpy(str, base);
> -       strcat(str, ".efi");
> -
> -       return 0;
> -}
> +#define EFI_DIRNAME    "/EFI/BOOT/"
>
>  static int get_efi_pxe_arch(void)
>  {
> @@ -259,10 +224,7 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
>                 return -ENOENT;
>
>         strcpy(fname, EFI_DIRNAME);
> -       ret = get_efi_leafname(fname + strlen(fname),
> -                              sizeof(fname) - strlen(fname));
> -       if (ret)
> -               return log_msg_ret("leaf", ret);
> +       strcat(fname, BOOTEFI_NAME);
>
>         if (bflow->blk)
>                  desc = dev_get_uclass_plat(bflow->blk);
> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> index e60e9309fa9..674d4c05f83 100644
> --- a/test/boot/bootflow.c
> +++ b/test/boot/bootflow.c
> @@ -13,6 +13,7 @@
>  #include <bootstd.h>
>  #include <cli.h>
>  #include <dm.h>
> +#include <efi_default_filename.h>
>  #include <expo.h>
>  #ifdef CONFIG_SANDBOX
>  #include <asm/test.h>
> @@ -179,7 +180,8 @@ static int bootflow_cmd_scan_e(struct unit_test_state *uts)
>         ut_assert_nextline("  3  efi          media   mmc          0  mmc1.bootdev.whole        ");
>         ut_assert_nextline("     ** No partition found, err=-2: No such file or directory");
>         ut_assert_nextline("  4  extlinux     ready   mmc          1  mmc1.bootdev.part_1       /extlinux/extlinux.conf");
> -       ut_assert_nextline("  5  efi          fs      mmc          1  mmc1.bootdev.part_1       efi/boot/bootsbox.efi");
> +       ut_assert_nextline("  5  efi          fs      mmc          1  mmc1.bootdev.part_1       /EFI/BOOT/"
> +                          BOOTEFI_NAME);
>
>         ut_assert_skip_to_line("Scanning bootdev 'mmc0.bootdev':");
>         ut_assert_skip_to_line(
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
